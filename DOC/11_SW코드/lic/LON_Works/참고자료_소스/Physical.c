/*********************************************************************
          File:        physical.c

       Version:        1.7

     Reference:        None

       Purpose:        Physical Layer Functions.

          Note:        None

         To Do:        None

*********************************************************************/
/*------------------------------------------------------------------------------ 
Section: Includes
------------------------------------------------------------------------------*/ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <eia709_1.h>
#include <node.h>
#include <physical.h>

/*-------------------------------------------------------------------
Section: Constant Definitions
-------------------------------------------------------------------*/
/* #define DEBUG  */


/*-------------------------------------------------------------------
Section: Type Definitions
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Globals 
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Local Function Prototypes
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Function Definitions
-------------------------------------------------------------------*/
/*****************************************************************
Function:  PHYReset
Returns:   None
Reference: None
Purpose:   To Initialize the queue for physical layer. 
Comments:  Since the physical layer functions are interrupt based,
           we use a queue in which the first byte is used as a flag
           to indicate the status of the item. The rest of the
           queue item are the actual data to be processed.
           For Output Queue, flag = 1 => item needs to be sent.
                                         (i.e Phy needs to process)
                             flag = 0 => item has been sent.
                                         (i.e Link can reuse it)
           For Input Queue,  flag = 1 => item was received.
                                         (i.e Link needs to take it)
                             flag = 0 => item has been processed.
                                         (i.e Link layer took it)
Format of queue: flag pdusize lpduheader npdu crc
  size in bytes    1    2       
******************************************************************/
void PHYReset(void)
{
   Byte *p;
   uint16 i;

   /* Allocate and Initialize Output Queue */
   /* 6 = 2 CRC + 1 for header + 1 for flag + 2 for pdusize */
   gp->phyOutBufSize  = 
      DecodeBufferSize((uint8) eep->readOnlyData.nwOutBufSize) + 6;
   gp->phyOutQCnt     = 
      DecodeBufferCnt((uint8) eep->readOnlyData.nwOutBufCnt);

   gp->phyOutQ = AllocateStorage((uint16) (gp->phyOutBufSize * gp->phyOutQCnt));
   if (gp->phyOutQ == NULL)
   {
      ErrorMsg("PHYReset: Unable to init Output Queue.\n");
      gp->resetOk = FALSE;
      return;
   }

   /* Init all flags to 0 so that the queue is empty */
   p = gp->phyOutQ;
   for (i = 0; i < gp->phyOutQCnt; i++)
   {
      *p = 0;
      p = p + gp->phyOutBufSize;
   }
   gp->phyOutQHeadPtr = gp->phyOutQTailPtr = gp->phyOutQ;

   /* Allocate and Initialize Pri Output Queue */
   gp->phyOutPriBufSize = gp->phyOutBufSize;
   gp->phyOutPriQCnt    = 
      DecodeBufferCnt((uint8) eep->readOnlyData.nwOutBufPriCnt);

   gp->phyOutPriQ = AllocateStorage((uint16) (gp->phyOutPriBufSize * 
                                    gp->phyOutPriQCnt));
   if (gp->phyOutPriQ == NULL)
   {
      ErrorMsg("PHYReset: Unable to init Priority Output Queue.\n");
      gp->resetOk = FALSE;
      return;
   }
   /* Init all flags to 0 */
   p = gp->phyOutPriQ;
   for (i = 0; i < gp->phyOutPriQCnt; i++)
   {
      *p = 0;
      p = p + gp->phyOutPriBufSize;
   }
   gp->phyOutPriQHeadPtr = gp->phyOutPriQTailPtr = gp->phyOutPriQ;

   return;
}

/*****************************************************************
Function:  PHYSend
Returns:   None
Reference: None
Purpose:   To process outgoing messages in gp->phyOutQ or
           gp->phyOutPriQ
Comments:  None
******************************************************************/
void PHYSend(void)
{
   
   if (macGbl.tpr)
   {
      return; /* There is no space to send. We wait */
   }

   if (*gp->phyOutPriQHeadPtr == 1)
   {
      /* need to test for buffer length before copy, PKT_BUF_LEN */
      /* then lost message */
      /* There is message waiting to be sent in pri queue */
      if (*(uint16 *)(gp->phyOutPriQHeadPtr+1) <= PKT_BUF_LEN)
      {
         macGbl.tl = *(uint16 *)(gp->phyOutPriQHeadPtr+1) ;
         macGbl.tc = 0;
         macGbl.priorityPkt = TRUE;
         memcpy(macGbl.tPkt, gp->phyOutPriQHeadPtr + 3, macGbl.tl);
         /* get delta backlog value */
         macGbl.deltaBLTx = macGbl.tPkt[0] & 0x3F; 
         if ((macGbl.tPkt[0] & 0x40) != 0)
         {
            macGbl.altPathBit = 1; /* set alternate path bit */
         }
         else
         {
            macGbl.altPathBit = 0; /* set alternate path bit */
         }
#ifdef DEBUG
         DebugMsg("PHYSend: Sending a new packet to SPM.");
#endif                  
         macGbl.tpr = TRUE;
      }
      else
      {
         ErrorMsg("PHYSend: Pri Message Length too"
                  " long for ISR buffer.\n");
      }
      *gp->phyOutPriQHeadPtr = 0;
      gp->phyOutPriQHeadPtr += gp->phyOutPriBufSize;
      if (gp->phyOutPriQHeadPtr == 
               gp->phyOutPriQ + gp->phyOutPriBufSize * 
                                gp->phyOutPriQCnt)
      {
               gp->phyOutPriQHeadPtr = gp->phyOutPriQ;
      }
   }
   else if (*gp->phyOutQHeadPtr == 1)
   {
      /* There is message waiting to be sent in non-pri queue */
      if (*(uint16 *)(gp->phyOutQHeadPtr+1) <= PKT_BUF_LEN)
      {
         macGbl.tl = *(uint16 *)(gp->phyOutQHeadPtr+1);
         macGbl.tc = 0;
         macGbl.priorityPkt = FALSE;
         memcpy(macGbl.tPkt, gp->phyOutQHeadPtr + 3, macGbl.tl);
         /* get delta backlog */
         macGbl.deltaBLTx = macGbl.tPkt[0] & 0x3F; 
         if ((macGbl.tPkt[0] & 0x40) != 0)
         {
            macGbl.altPathBit = TRUE; /* set alternate path bit */
         }
         else
         {
            macGbl.altPathBit = FALSE; /* set alternate path bit */
         }
#ifdef DEBUG
         DebugMsg("PHYSend: Sending a new packet to SPM.");
#endif          
         macGbl.tpr = TRUE;
      }
      else
      {
         ErrorMsg("PHYSend: Message Length too long "
                  "for ISR buffer.\n");
      }
      
      *gp->phyOutQHeadPtr = 0;
      gp->phyOutQHeadPtr += gp->phyOutBufSize;
      if (gp->phyOutQHeadPtr == 
               gp->phyOutQ + gp->phyOutBufSize * gp->phyOutQCnt)
      {
              gp->phyOutQHeadPtr = gp->phyOutQ;
      }
   }
   else
   {
      return; /* Nothing to send */
   }

   return;
}

/*****************************************************************
Function:  PHYReceive
Returns:   None
Reference: None
Purpose:   To process incoming messages
Comments:  Interrupt Driven
******************************************************************/
void PHYReceive(void)
{
   /* superceded by ISR function. Hence return right away */
   return;
}


/*************************End of physical.c*************************/
