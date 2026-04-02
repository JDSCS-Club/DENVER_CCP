/*******************************************************************************
          File:        main.c

       Version:        1.7

     Reference:        None

       Purpose:        The main scheduler for the protocol stack.
                       The scheduler first initializes the eeprom
                       based on custom.h and custom.c. A node
                       reset is then performed. The physical layer
                       is initialized to enable ISRs (Interrupt Service
                       Routine). Finally, the scheduler gets into a loop
                       where it calls DoApp followed by Send fns of all the
                       layers followed by Receive functions of
                       all the layers.

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
#include <custom.h>
#include <node.h>
#include <physical.h>

/*------------------------------------------------------------------------------
Section: Constant Definitions
------------------------------------------------------------------------------*/
#define LED_TIMER_VALUE      1000  /* How often to flash in ms */
#define CHECKSUM_TIMER_VALUE 1000  /* How often to check config checksum? */
/*------------------------------------------------------------------------------
Section: Type Definitions
------------------------------------------------------------------------------*/
void (*FnType)(void); /* Type of Send and Receive functions. */


/*------------------------------------------------------------------------------
Section: Globals
------------------------------------------------------------------------------*/
/* None */

/*------------------------------------------------------------------------------
Section: Local Globals
------------------------------------------------------------------------------*/
/* packetLossPercent is used to simulate packet losses in simulation
   mode. Valid values are 0-100. */
static uint8   packetLossPercent = 0;
static MsTimer ledTimer; /* To flash service LED */
static MsTimer checksumTimer; /* How often to cheksum? */

/*------------------------------------------------------------------------------
Section: Function Prototypes
------------------------------------------------------------------------------*/
extern void DoApp(void);   /* Application program in apppgm.c       */
extern Status AppInit(void); /* Init function for application program */

extern void APPInit(void); /* Init function for application layer */

/* Send functions for the layers */
extern void APPSend(void);
extern void TPSend(void);
extern void SNSend(void);
extern void AuthSend(void);
extern void NWSend(void);
extern void LKSend(void);
extern void PHYSend(void);

/* Receive functions for the layers */
extern void APPReceive(void);
extern void TPReceive(void);
extern void SNReceive(void);
extern void AuthReceive(void);
extern void NWReceive(void);
extern void LKReceive(void);
extern void PHYReceive(void);

/*------------------------------------------------------------------------------
Section: Local Function Prototypes.
------------------------------------------------------------------------------*/
void PhysicalStub(void);
void PhysicalLinkStub(void);
uint32 RandomNumber(int from, int to);

/*------------------------------------------------------------------------------
Section: Function Definitions
------------------------------------------------------------------------------*/
int main(void)
{
   Boolean done = FALSE;
   Boolean schedulerReset; /* TRUE ==> Scheduler should restart
                              from the beginning of the loop. */
   uint8   stackNum, fnNum;
   void (*sendFns[])(void) =
      {SNSend, TPSend, AuthSend, NWSend, LKSend, APPSend, NWSend, LKSend};
   void (*receiveFns[])(void) =
      {LKReceive, NWReceive, AuthReceive, TPReceive, SNReceive, APPReceive};
   uint8   fnsCnt; /* Count of functions in sendFns or receiveFns. */



   /* First init EEPROM based on custom.h, custom.c and default
      values for several variables */
   for (stackNum = 0; stackNum < NUM_STACKS; stackNum++)
   {
      eep = &eeprom[stackNum];
      cp  = &customDataGbl[stackNum];
      nmp = &nm[stackNum];
      InitEEPROM();
   }

   /* Reset the node at the start */
   for (stackNum = 0; stackNum < NUM_STACKS; stackNum++)
   {
      gp = &protocolStackDataGbl[stackNum];
      eep = &eeprom[stackNum];
      nmp = &nm[stackNum];
      gp->resetOk = TRUE;
      nmp->resetCause = POWER_UP_RESET;
      NodeReset(TRUE);
      if (!gp->resetOk)
      {
         return(FAILURE); /* Leave main and loop. */
      }
      /* Call APPInit and AppInit once before the loop. */
      APPInit();
      if (AppInit() == FAILURE)
      {
         return(FAILURE);
      }
      /* Compute the configCheckSum for the first time. NodeReset
         will not verify checkSum firt time. */
      eep->configCheckSum   = ComputeConfigCheckSum();
   }

#ifndef SIMULATION
   SetMsTimer(&ledTimer, LED_TIMER_VALUE);
   PHYIOInit(); /* gp eep nmp should be set in the for loop above */
#endif
   SetMsTimer(&checksumTimer, CHECKSUM_TIMER_VALUE); /* Initial value */

   /* Loop forever. 'done' used to silence the compiler from
      generating warning. Later on, 'done' can be used to stop the
      scheduler under certain conditions, if necessary. */

   while(!done)
   {
      for (stackNum = 0; stackNum < NUM_STACKS; stackNum++)
      {
         gp  = &protocolStackDataGbl[stackNum];
         eep = &eeprom[stackNum];
         nmp = &nm[stackNum];

         /* Check if the node needs to be reset. */
         if (gp->resetNode)
         {
            gp->resetOk = TRUE;
            NodeReset(FALSE);
            if (!gp->resetOk)
            {
               return(FAILURE); /* Leave main and loop. */
            }
            continue; /* Easy way to do scheduler reset, */
         }

         /* Call the application program, if needed. */
         if (AppPgmRuns())
         {
            DoApp(); /* Call the application. Let it do whatever it wants. */
         }

         /* Check if the node needs to be reset. */
         if (gp->resetNode)
         {
            gp->resetOk = TRUE;
            NodeReset(FALSE);
            if (!gp->resetOk)
            {
               return(FAILURE); /* Leave main and loop. */
            }
            continue; /* Easy way to do scheduler reset, */
         }

         /* Call all the Send functions */
         fnsCnt = sizeof(sendFns)/sizeof(FnType);
         schedulerReset = FALSE;
         for (fnNum = 0; fnNum < fnsCnt; fnNum++)
         {
            sendFns[fnNum](); /* Call the Send function. */
            /* Check if the node needs to be reset. */
            if (gp->resetNode)
            {
               gp->resetOk = TRUE;
               NodeReset(FALSE);
               if (!gp->resetOk)
               {
                  return(FAILURE); /* Leave main and loop. */
               }
               schedulerReset = TRUE;
               break;
            }
         }

         /* Check if the scheduler needs to reset the node now. */
         if (schedulerReset)
         {
            continue;
         }

         /* See if we need to call PHYSend or PhysicalStub. */
#ifndef SIMULATION
         PHYSend();
#else
         PhysicalStub(); /* Simulate the physical layer */
#endif
         /* Check if the node needs to be reset. */
         if (gp->resetNode)
         {
            gp->resetOk = TRUE;
            NodeReset(FALSE);
            if (!gp->resetOk)
            {
               return(FAILURE); /* Leave main and loop. */
            }
            continue;
         }


#ifndef SIMULATION
         PHYIO(); /* Call PHYIO to perform i/o (Pins, Leds etc) */
         if (gp->resetNode)
         {
            gp->resetOk = TRUE;
            NodeReset(FALSE);
            if (!gp->resetOk)
            {
               return(FAILURE); /* Leave main and loop. */
            }
            continue;
         }
         /* Flash service LED if needed. */
         if (MsTimerExpired(&ledTimer))
         {
            if (eep->readOnlyData.nodeState == APPL_UNCNFG)
            {
               gp->ioOutputPin1 = 1 - gp->ioOutputPin1; /* Toggle. */
            }
            SetMsTimer(&ledTimer, LED_TIMER_VALUE); /* Reset timer */
         }
#endif

#ifndef SIMULATION
         PHYReceive();
#endif
         /* Check if the node needs to be reset. */
         if (gp->resetNode)
         {
            gp->resetOk = TRUE;
            NodeReset(FALSE);
            if (!gp->resetOk)
            {
               return(FAILURE); /* Leave main and loop. */
            }
            continue;
         }


         /* Call all the Receive functions. */
         fnsCnt = sizeof(receiveFns)/sizeof(FnType);
         schedulerReset = FALSE;
         for (fnNum = 0; fnNum < fnsCnt; fnNum++)
         {
            receiveFns[fnNum](); /* Call the Receive function. */
            /* Check if the node needs to be reset. */
            if (gp->resetNode)
            {
               gp->resetOk = TRUE;
               NodeReset(FALSE);
               if (!gp->resetOk)
               {
                       return(FAILURE); /* Leave main and loop. */
               }
               schedulerReset = TRUE;
               break;
            }
         }
         /* Check if the scheduler needs to reset. */
         if (schedulerReset)
         {
            continue;
         }


#ifdef SIMULATION
         /* In simulation mode, the clock ticks once per cycle */
         gp->softwareTime++;
#endif
         /* Check for integrity of config structure */
         if (MsTimerExpired(&checksumTimer))
         {
            if (NodeConfigured() &&
                eep->configCheckSum != ComputeConfigCheckSum() )
            {
               /* Go unconfigured and reset. */
               eep->readOnlyData.nodeState = APPL_UNCNFG;
               gp->appPgmMode  = ON_LINE;
               OfflineEvent();  /* Indicate to application program. */
               gp->resetNode = TRUE;
               nmp->resetCause = SOFTWARE_RESET;
               nmp->errorLog = CNFG_CS_ERROR;
            }
            SetMsTimer(&checksumTimer, CHECKSUM_TIMER_VALUE);
         }

      } /* for loop on stackNum */
   } /* while (!done) */

   return(SUCCESS);
}

/*******************************************************************************
Function:  PhysicalLinkStub
Returns:   None
Reference: None
Purpose:   To transfer packets from network queue of current
           stack to network queue of all other stacks.

Comments:  This function was used for testing purpose when the physical
           layer code was not ready or not to be used.
*******************************************************************************/
void PhysicalLinkStub(void)
{
   uint8  sn;
   uint16 size1, size2;
   NWReceiveParam *nwReceiveParamPtr;
   LKSendParam    *lkSendParamPtr;
   Byte *pduPtr1, *pduPtr2;
   ProtocolStackData *rgp; /* Remote node's gp pointer */
   char msg[100];

   if (!QueueEmpty(&gp->lkOutPriQ))
   {
      lkSendParamPtr = QueueHead(&gp->lkOutPriQ);
      pduPtr1 = (Byte *) ((char *)lkSendParamPtr
                          + sizeof(LKSendParam));
      size1 = QueueItemSize(&gp->lkOutPriQ) - sizeof(LKSendParam);
      /* Transfer from current stack to every other stack */
      for (sn = 0; sn < NUM_STACKS; sn++)
      {
         rgp = &protocolStackDataGbl[sn];
         if (gp == rgp)
         {
            /* Current stack. Don't want to receive our own pkt. */
            continue;
         }


         if (!QueueFull(&rgp->nwInQ) &&
             RandomNumber(1,100) > packetLossPercent)
         {
            nwReceiveParamPtr  = QueueTail(&rgp->nwInQ);
            pduPtr2 = (Byte *) ((char *)nwReceiveParamPtr
                                + sizeof(NWReceiveParam));
            size2 = QueueItemSize(&rgp->nwInQ) -
                         sizeof(NWReceiveParam);
            if (size1 <= size2)
            {
               nwReceiveParamPtr->priority = TRUE;
               nwReceiveParamPtr->pduSize  = lkSendParamPtr->pduSize;
               memcpy(pduPtr2, pduPtr1, lkSendParamPtr->pduSize);
               EnQueue(&rgp->nwInQ);
            }
            else
            {
               sprintf(msg,
                       "PhysicalLinkStub: Pri Pkt Lost in %d\n",
                       sn+1);
               ErrorMsg(msg);
            }
         }
         else
         {
            sprintf(msg,
                    "PhysicalLinkStub: Pri Pkt Lost in %d\n", sn+1);
            ErrorMsg(msg);
         }
      }
      DeQueue(&gp->lkOutPriQ);
   }

   if (!QueueEmpty(&gp->lkOutQ))
   {
      lkSendParamPtr = QueueHead(&gp->lkOutQ);
      pduPtr1 = (Byte *) ((char *)lkSendParamPtr
                          + sizeof(LKSendParam));
      size1 = QueueItemSize(&gp->lkOutQ) - sizeof(LKSendParam);
      /* Transfer from current stack to every other stack. */
      for (sn = 0; sn < NUM_STACKS; sn++)
      {
         rgp = &protocolStackDataGbl[sn];
         if (gp == rgp)
         {
            /* Current stack. Don't want to receive our own pkt. */
            continue;
         }

         if (!QueueFull(&rgp->nwInQ) &&
             RandomNumber(1,100) > packetLossPercent)
         {
            nwReceiveParamPtr  = QueueTail(&rgp->nwInQ);
            pduPtr2 = (Byte *) ((char *)nwReceiveParamPtr
                                + sizeof(NWReceiveParam));
            size2 = QueueItemSize(&rgp->nwInQ) -
                         sizeof(NWReceiveParam);
            if (size1 <= size2)
            {
               nwReceiveParamPtr->priority = TRUE;
               nwReceiveParamPtr->pduSize  = lkSendParamPtr->pduSize;
               memcpy(pduPtr2, pduPtr1, lkSendParamPtr->pduSize);
               EnQueue(&rgp->nwInQ);
            }
            else
            {
               sprintf(msg,
                       "PhysicalLinkStub: Non-pri Pkt Lost in %d\n",
                       sn+1);
               ErrorMsg(msg);
            }
         }
         else
         {
            sprintf(msg,
                    "PhysicalLinkStub: Non-Pri Pkt Lost in %d\n",
                    sn+1);
            ErrorMsg(msg);
         }
      }
      DeQueue(&gp->lkOutQ);
   }

}

/*******************************************************************************
Function:  PhysicalLinkStub
Returns:   None
Reference: None
Purpose:   To transfer packets from link queue of current
           stack to link queue of all other stacks.

Comments:  Used only in simulation mode.
*******************************************************************************/
void PhysicalStub(void)
{
   uint16  sn;
   uint16 size1, size2;
   Byte  *phyQueuePtr1, *phyQueuePtr2;
   ProtocolStackData *rgp; /* Remote node's gp pointer. */
   char msg[100];

   phyQueuePtr1= gp->phyOutPriQHeadPtr;
   if (*phyQueuePtr1 == 1)
   {
      size1   = gp->phyOutPriBufSize;
      /* Transfer from current stack to every other stack. */
      for (sn = 0; sn < NUM_STACKS; sn++)
      {
         rgp = &protocolStackDataGbl[sn];
         if (gp == rgp)
         {
            /* Current stack. Don't want to receive our own pkt. */
            continue;
         }
         size2        = rgp->lkInBufSize;
         phyQueuePtr2 = rgp->lkInQTailPtr;
         if (size2 < size1)
         {
            sprintf(msg,
                    "PhysicalStub: Pri Pkt Lost in %d. Too Large\n",
                    sn+1);
            ErrorMsg(msg);
         }
         else if (*phyQueuePtr2 == 1)
         {
            sprintf(msg,
                    "PhysicalStub: Pri Pkt Lost in %d. No Space.\n",
                    sn+1);
            ErrorMsg(msg);
         }
         else if (RandomNumber(1,100) <= packetLossPercent)
         {
            sprintf(msg,
                    "PhysicalStub: Pri Pkt Lost in %d.\n",
                    sn+1);
            ErrorMsg(msg);
         }
         else
         {
            /* Copy the whole packet including the flag */
            memcpy(phyQueuePtr2, phyQueuePtr1, size1);
            /* Increment the Tail Ptr */
            rgp->lkInQTailPtr = rgp->lkInQTailPtr + size2;
            if (rgp->lkInQTailPtr ==
                rgp->lkInQ + size2 * rgp->lkInQCnt)
            {
               rgp->lkInQTailPtr = rgp->lkInQ;
            }
         }
      }
      /* Increment the head pointer of sending stack. */
      gp->phyOutPriQHeadPtr = gp->phyOutPriQHeadPtr +
                                  gp->phyOutPriBufSize;
      if (gp->phyOutPriQHeadPtr == gp->phyOutPriQ +
                                       gp->phyOutPriQCnt *
                                       gp->phyOutPriBufSize)
      {
         gp->phyOutPriQHeadPtr = gp->phyOutPriQ;
      }
      /* Make the queue item available again. */
      *phyQueuePtr1 = 0;
   }

   /* Do the same thing for non-priority queue. */
   phyQueuePtr1= gp->phyOutQHeadPtr;
   if (*phyQueuePtr1 == 1)
   {
      size1   = gp->phyOutBufSize;
      /* Transfer from current stack to every other stack. */
      for (sn = 0; sn < NUM_STACKS; sn++)
      {
         rgp = &protocolStackDataGbl[sn];
         if (gp == rgp)
         {
            /* Current stack. Don't want to receive our own pkt. */
            continue;
         }
         size2        = rgp->lkInBufSize;
         phyQueuePtr2 = rgp->lkInQTailPtr;
         if (size2 < size1)
         {
            sprintf(msg,
                    "PhysicalStub: Pri Pkt Lost in %d. Too Large\n",
                    sn+1);
            ErrorMsg(msg);
         }
         else if (*phyQueuePtr2 == 1)
         {
            sprintf(msg,
                    "PhysicalStub: Pri Pkt Lost in %d. No Space.\n",
                    sn+1);
            ErrorMsg(msg);
         }
         else if (RandomNumber(1,100) <= packetLossPercent)
         {
            sprintf(msg,
                    "PhysicalStub: Pri Pkt Lost in %d.\n",
                    sn+1);
            ErrorMsg(msg);
         }
         else
         {
            /* Copy the whole packet including the flag. */
            memcpy(phyQueuePtr2, phyQueuePtr1, size1);
            /* Increment the Tail Ptr */
            rgp->lkInQTailPtr = rgp->lkInQTailPtr + size2;
            if (rgp->lkInQTailPtr ==
                rgp->lkInQ + size2 * rgp->lkInQCnt)
            {
               rgp->lkInQTailPtr = rgp->lkInQ;
            }
         }
      }
      /* Increment the head pointer of sending stack. */
      gp->phyOutQHeadPtr = gp->phyOutQHeadPtr +
                                  gp->phyOutBufSize;
      if (gp->phyOutQHeadPtr == gp->phyOutQ +
                                       gp->phyOutQCnt *
                                       gp->phyOutBufSize)
      {
         gp->phyOutQHeadPtr = gp->phyOutQ;
      }
      /* Make the queue item available again. */
      *phyQueuePtr1 = 0;
   }
}

uint32 RandomNumber(int from, int to)
{
   uint32 randValue = rand();

   return ( from + (randValue % (to - from + 1)) );
}
/*********************************End of main.c********************************/

