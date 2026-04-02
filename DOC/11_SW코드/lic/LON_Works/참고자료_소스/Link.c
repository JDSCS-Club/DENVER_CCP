/*******************************************************************************
          File:        link.c

       Version:        1.7

     Reference:        Protocol Specification: Link Layer.

       Purpose:        Data structures and functions for Link layers.

          Note:        None

         To Do:        None
*******************************************************************************/
/*------------------------------------------------------------------------------
Section: Includes
------------------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <eia709_1.h>
#include <node.h>
#include <queue.h>
#include <link.h>

/*------------------------------------------------------------------------------
Section: Constant Definitions
------------------------------------------------------------------------------*/
/* None */

/*------------------------------------------------------------------------------
Section: Type Definitions
------------------------------------------------------------------------------*/
/* Need a structure that represents the 1 byte header portion for
   LPDU in the queue */
typedef struct
{
   Bits   priority    : 1;    /* priority            */
   Bits   altPath     : 1;    /* alternate path flag */
   Bits   deltaBL     : 6;    /* delta backlog value */
} LPDUHeader;

/*------------------------------------------------------------------------------
Section: Globals 
------------------------------------------------------------------------------*/
/* None */

/*------------------------------------------------------------------------------
Section: Function Prototypes
------------------------------------------------------------------------------*/
/* None */

/*------------------------------------------------------------------------------
Section: Function Definitions
------------------------------------------------------------------------------*/
/*******************************************************************************
Function:  LKReset
Returns:   None
Reference: None
Purpose:   To allocate space for link layer queues.
           
Comments:  Sets gp->resetOk to FALSE if unable to reset properly.
*******************************************************************************/
void LKReset(void)
{
   uint16 queueItemSize;
   Byte   *p; /* Used to initialize lkInQ. */
   uint16 i;

   /****************************************************************************
      Allocate and initialize the input queue.
      Since input queue is also used by the physical layer,
      it is not a regular queue. Each item in the queue has the
      form 
         <flag> <LPDUSize> <LPDU>
      where 
         <flag> is 1 byte 
         <LPDUSize> is 2 bytes
         <LPDU> is of the form LPDU_HEADER RESTOFLPDU CRC
         LPDU_HEADER is 1 byte (LPDU does not include the syncbits)
         CRC uses 2 bytes. 
      Total # bytes in addition to NPDU is thus 6 bytes.
   ****************************************************************************/
   gp->lkInBufSize   = 
      DecodeBufferSize((uint8)eep->readOnlyData.nwInBufSize) + 6;
   gp->lkInQCnt      = 
      DecodeBufferCnt((uint8)eep->readOnlyData.nwInBufCnt);

   gp->lkInQ = AllocateStorage((uint16)(gp->lkInBufSize * gp->lkInQCnt));
   if (gp->lkInQ == NULL)
   {
      ErrorMsg("LKReset: Unable to init the input queue.\n");
      gp->resetOk = FALSE;
      return;
   }
   /* Init the flag in each item of the queue to 0. */
   p = gp->lkInQ; 
   for (i = 0; i < gp->lkInQCnt; i++)
   {
      *p = 0;
      p  = (Byte *)((char *)p + gp->lkInBufSize);
   }

   gp->lkInQHeadPtr = gp->lkInQTailPtr = gp->lkInQ;

   /* Allocate and initialize the output queue. */
   gp->lkOutBufSize  = 
      DecodeBufferSize((uint8)eep->readOnlyData.nwOutBufSize);
   gp->lkOutQCnt     = 
      DecodeBufferCnt((uint8)eep->readOnlyData.nwOutBufCnt);
   queueItemSize    = gp->lkOutBufSize + sizeof(LKSendParam);

   if (QueueInit(&gp->lkOutQ, queueItemSize, gp->lkOutQCnt) 
       != SUCCESS)
   {
      ErrorMsg("LKReset: Unable to init the output queue.\n");
      gp->resetOk = FALSE;
      return;
   }

   /* Allocate and initialize the priority output queue. */
   gp->lkOutPriBufSize = gp->lkOutBufSize;
   gp->lkOutPriQCnt  = 
      DecodeBufferCnt((uint8)eep->readOnlyData.nwOutBufPriCnt);
   queueItemSize    = gp->lkOutPriBufSize + sizeof(LKSendParam);

   if (QueueInit(&gp->lkOutPriQ, queueItemSize, gp->lkOutPriQCnt) 
       != SUCCESS)
   {
      ErrorMsg("LKReset: Unable to init the priority output queue.\n");
      gp->resetOk = FALSE;
      return;
   }

  
   return;
}

/*******************************************************************************
Function:  LKSend
Returns:   None
Reference: None
Purpose:   To take the NPDU from link layer's output queue and put it
           in the queue for the physical layer. 
Comments:  We assume that there will be sufficient space as we
           allocated the extra bytes based on header size etc.
*******************************************************************************/
void LKSend(void)
{
   LKSendParam     *lkSendParamPtr;
   Queue           *lkSendQueuePtr;
   Byte            *npduPtr;
   Byte            *phyQItemPtr, *phyQPtr, *tempPtr;
   Byte           **phyQTailPtrPtr;
   uint16           queueCnt, itemSize;
   uint16          *pduSizePtr;
   LPDUHeader      *lpduHeaderPtr;
   Boolean          priority;

   /* First, make variables point to the right queue. */
   if (!QueueEmpty(&gp->lkOutPriQ))
   {
      priority        = TRUE;
      lkSendQueuePtr  = &gp->lkOutPriQ;
      phyQPtr         = gp->phyOutPriQ;
      phyQItemPtr     = gp->phyOutPriQTailPtr;
      phyQTailPtrPtr  = &gp->phyOutPriQTailPtr;
      queueCnt        = gp->phyOutPriQCnt;
      itemSize        = gp->phyOutPriBufSize;
   }
   else if (!QueueEmpty(&gp->lkOutQ))
   {
      priority        = FALSE;
      lkSendQueuePtr  = &gp->lkOutQ;
      phyQPtr         = gp->phyOutQ;
      phyQItemPtr     = gp->phyOutQTailPtr;
      phyQTailPtrPtr  = &gp->phyOutQTailPtr;
      queueCnt        = gp->phyOutQCnt;
      itemSize        = gp->phyOutBufSize;
   }
   else
   {
      return; /* Nothing to send. */
   }

   lkSendParamPtr = QueueHead(lkSendQueuePtr);
   npduPtr        = (Byte *) (lkSendParamPtr + 1);

   /* Check if there is space in the physical layer's queue. */
   if (*phyQItemPtr == 1)
   {
      return; /* No space in the physical layer queue. */
   }
   
   /* Fill the PDU size so that the physical layer knows about it. */
   pduSizePtr  = (uint16 *) ((char *)phyQItemPtr + 1);
   *pduSizePtr = lkSendParamPtr->pduSize + 3;

   /* First fill the data. */
   tempPtr = phyQItemPtr + 3;

   /* Form the header. */
   lpduHeaderPtr           = (LPDUHeader *)tempPtr;
   lpduHeaderPtr->priority = priority;
   lpduHeaderPtr->altPath  = lkSendParamPtr->altPath;
   lpduHeaderPtr->deltaBL  = lkSendParamPtr->deltaBL;
   tempPtr++;

   /* Copy the NPDU. */
   if (lkSendParamPtr->pduSize <= itemSize)
   {
      memcpy(tempPtr, npduPtr, lkSendParamPtr->pduSize);
   }
   else
   {
      ErrorMsg("LKSend: NPDU seems too large to fit.\n");
   }

   /* Compute the CRC value. */
   CRC16(phyQItemPtr+3, lkSendParamPtr->pduSize + 1);
   
   /* Turn the flag on so that physical layer can send it. */
   *phyQItemPtr = 1;

   /* Increment tail pointer taking care of wraparound. */
   *phyQTailPtrPtr = *phyQTailPtrPtr + itemSize;
   if (*phyQTailPtrPtr == (phyQPtr + queueCnt * itemSize))
   {
      *phyQTailPtrPtr = phyQPtr; /* wrap around. */
   }

   DeQueue(lkSendQueuePtr);

   return;
}

/*******************************************************************************
Function:  LKReceive
Returns:   None
Reference: None
Purpose:   To receive the incoming LPDUs and process them.
Comments:  Each item of the queue gp->lkInQ has the following form:
           flag pduSize LPDU
           flag is 1 byte long.
           pduSize is 2 bytes long.
           LPDU has header followed by the rest of the LPDU and then CRC.
           The LPDU header is 1 byte long. CRC uses 2 bytes.
           If a packet is in lkInQ then it should fit into nwInQ.
*******************************************************************************/
void LKReceive(void)
{
   NWReceiveParam *nwReceiveParamPtr;
   Byte           *npduPtr;
   LPDUHeader     *lpduHeaderPtr;
   Byte           *tempPtr; 
   uint16          lpduSize;

   if (*(gp->lkInQHeadPtr) == 0)
   {
      /* There is nothing to receive. */
      return;
   }

     
   lpduSize = *(uint16 *)(gp->lkInQHeadPtr + 1);
   lpduHeaderPtr     = (LPDUHeader *)(gp->lkInQHeadPtr + 3);

   /* Throw away packets that are smaller than 8 bytes long. */
   /* this check is now  made in the mac sublayer */
   
   
   /* Do CRC check. */
   /* this check is now made in the mac sublayer */
   /* Only packets with valid CRC and >= 8 bytes are placed
      in the lkInQ by mac sublayer. */
   
   INCR_STATS(nmp->stats.layer2Received); /* Got a good packet. */

   
   
   /* We need to receive this message. */
   if (QueueFull(&gp->nwInQ))
   {
      /* We are losing this packet. */
      INCR_STATS(nmp->stats.missedMessages); 
   }
   else
   {
      nwReceiveParamPtr = QueueTail(&gp->nwInQ);
      npduPtr           = (Byte *)(nwReceiveParamPtr + 1); 
   
      nwReceiveParamPtr->priority = lpduHeaderPtr->priority;
      nwReceiveParamPtr->altPath  = lpduHeaderPtr->altPath;
      tempPtr = (Byte *)((char *)lpduHeaderPtr + 1);
      nwReceiveParamPtr->pduSize  = lpduSize - 3;
      
      /* Copy the NPDU. */
      /* if it was in link layer's queue, then the size should be
         sufficient in network layer's queue as they differ by 3.
         However, let us play safe by checking the size first. */
      if (nwReceiveParamPtr->pduSize <= gp->nwInBufSize)
      {
         memcpy(npduPtr, tempPtr, nwReceiveParamPtr->pduSize);
      }
      else
      {
         ErrorMsg("LKReceive: NPDU size seems too large.\n");
      }
      EnQueue(&gp->nwInQ);
   }      
   *(gp->lkInQHeadPtr) = 0;
   gp->lkInQHeadPtr = gp->lkInQHeadPtr + gp->lkInBufSize;
   if (gp->lkInQHeadPtr == 
       (gp->lkInQ + gp->lkInBufSize * gp->lkInQCnt))
   {
      gp->lkInQHeadPtr = gp->lkInQ; /* wrap around. */
   }

   return;
}

/*******************************************************************************
Function:  CRC16
Returns:   16 bit CRC computed.
Purpose:   To compute the 16 bit CRC for a given buffer.
Comments:  None.
*******************************************************************************/
void CRC16(Byte bufInOut[], uint16 sizeIn)
{
   uint16 poly = 0x1021;       /* Generator Polynomial. */
   uint16 crc = 0xffff;        
   uint16 i,j;
   unsigned char byte, crcbit, databit;

   for (i = 0; i < sizeIn; i++)
   {
      byte = bufInOut[i];
      for (j = 0; j < 8; j++)
      {
        crcbit = crc & 0x8000 ? 1 : 0;
        databit = byte & 0x80 ? 1 : 0;
        crc = crc << 1;
        if (crcbit != databit)
         {
           crc = crc ^ poly;
         }
        byte = byte << 1;
      }
      
   }
   crc = crc ^ 0xffff;
   bufInOut[sizeIn]     = (crc >> 8);
   bufInOut[sizeIn + 1] = (crc & 0x00FF);

   return;
}
/******************************End of link.c **********************************/
