/*********************************************************************
          File:        apppgm.c

       Version:        1.6

     Reference:        None

       Purpose:        360 <--> Emulator Node 1
                       
                       intArrayOut    --> intArrayIn
                       
                       vice versa.
                       
                       Test Priority Messages and SPM
                                 
          Note:        We press a button on 360. An output array variable
                       is incremented. 
                       Every Button Press also sends  messages with
                       implicit addressing on tag1.

          Comments:    Use LonBuilde to monitor the var values.
*********************************************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <node.h>

/*-------------------------------------------------------------------
Section: Constant Definitions
-------------------------------------------------------------------*/
#define LIGHT_DURATION 2   /* In Seconds. Can be a fraction too */

/*-------------------------------------------------------------------
Section: Type Definitions
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Globals 
-------------------------------------------------------------------*/
MsTimer lightTimer;
Boolean lightOn;

int8   whichOutVar;
int    intSum;
long   longSum;

MsgTag tag0;
MsgTag tag1;


/*****************************************************************
          Network Variable Definition Format

   Prior  Dir    SelHi SelLo    bind Turn   Serv     Auth 
   explode length snvtDesc snvtExt snvtType  rateEst  maxrEst
   arrayCnt nvName nvSdoc nvAddr
*****************************************************************/
typedef nulong SNVT_count;

nint intOut;
NVDefinition intOutDef = 
{ 
   TRUE, NV_OUTPUT, 0,    0,   1, FALSE, ACKD,    FALSE, 
   0, sizeof(nint), 0x80, 0x30, 0,  0,  0,  
   0,  "intOut",  "intOutSD", &intOut
};
int16 intOutIndex;

SNVT_count longOut;
NVDefinition longOutDef = 
{ 
   FALSE, NV_OUTPUT, 0,    0,   1, FALSE, ACKD,    FALSE, 
   0, sizeof(SNVT_count), 0x80, 0x30, 8,  0,  0,  
   0,  "longOut",  "longOutVar", &longOut
};
int16 longOutIndex;

nint intArrayOut[3];
NVDefinition intArrayOutDef = 
{ 
   TRUE, NV_OUTPUT, 0,    0,   1, FALSE, ACKD,    FALSE, 
   0, sizeof(nint), 0x80, 0x38, 0,  0,  0,  
   3,  "intArrayOut",  "intArrayOutSD", intArrayOut
};
int16 intArrayOutIndex;

nint intIn; /* Polled */
NVDefinition intInDef = 
{ 
   FALSE, NV_INPUT, 0,    0,   1, FALSE, ACKD,    FALSE, 
   0, sizeof(nint), 0xA0, 0x30, 0,  0,  0,  
   0,  "intIn",  "intInSD", &intIn
};
int16 intInIndex;

nlong longIn;
NVDefinition longInDef = 
{ 
   FALSE, NV_INPUT, 0,    0,   1, FALSE, ACKD,    FALSE, 
   0, sizeof(nlong), 0x80, 0x30, 0,  0,  0,  
   0,  "longIn",  "longInSD", &longIn
};
int16 longInIndex;

nint intArrayIn[2];
NVDefinition intArrayInDef = 
{ 
   FALSE, NV_INPUT, 0,    0,   1, FALSE, ACKD,    FALSE, 
   0, sizeof(nint), 0x80, 0x38, 0,  0,  0,  
   2,  "intArrayIn",  "intArrayInSD", intArrayIn
};
int16 intArrayInIndex;


/*-------------------------------------------------------------------
Section: Local Function Prototypes
-------------------------------------------------------------------*/
void LightOn(void);
void LightOff(void);

/*-------------------------------------------------------------------
Section: Function Definitions
-------------------------------------------------------------------*/
void DoApp(void)
{
   if (MsTimerExpired(&lightTimer))
   {
      LightOff();
   }


   if (IOChanges(0) && gp->ioInputPin0)
   {
      intOut++;
      PropagateNV(intOutIndex);
         
      /* Update whole array */
      intArrayOut[0]++;
      intArrayOut[1]++;
      intArrayOut[2]++;
      PropagateNV(intArrayOutIndex);
          
   }

   /* Ignore incoming messages */
   msg_receive();
   
   /* Ignore incoming responses */
   resp_receive();
}

void  AppInit(void)
{
   /* Register Network variables */
   intOutIndex      = AddNV(&intOutDef);
   longOutIndex     = AddNV(&longOutDef);
   intArrayOutIndex = AddNV(&intArrayOutDef);
   intInIndex       = AddNV(&intInDef);
   longInIndex      = AddNV(&longInDef);
   intArrayInIndex  = AddNV(&intArrayInDef);
   
   tag0        = NewMsgTag(BINDABLE);
   tag1        = NewMsgTag(BINDABLE);
}

void  AppReset(void)
{
   lightOn = FALSE;
   SetMsTimer(&lightTimer, 0); /* Init to 0 */
   whichOutVar = 0;
   if (intOutIndex == -1 || longOutIndex == -1 || intArrayOutIndex == -1 ||
       intInIndex == -1 || longInIndex == -1 || intArrayInIndex == -1)
   {
      gp->resetOk = FALSE;
   }   
}

void  MsgCompletes(Status stat, MsgTag tag)
{

}

void NVUpdateOccurs(int16 nvIndex, int16 nvArrayIndex)
{
   if (nvIndex == intInIndex)
   {
      intSum = intSum + intIn;
   }
   else if (nvIndex == longInIndex)
   {
      longSum = longSum + longIn;
   }
   else if (nvIndex == intArrayInIndex)
   {
      intSum = intSum + intArrayIn[nvArrayIndex];
   }
}


void  Wink(void)
{
   gp->ioOutputPin1 = TRUE;
   SetMsTimer(&lightTimer, LIGHT_DURATION * 1000);
}

void OfflineEvent()
{
}

void OnlineEvent()
{
}

void NVUpdateCompletes(Status status, int16 nvIndex, int16 nvArrayIndex)
{
}

void LightOn(void)
{
   gp->ioOutputPin1 = TRUE;
   SetMsTimer(&lightTimer, LIGHT_DURATION * 1000);
   lightOn = TRUE;
}

void LightOff(void)
{
   gp->ioOutputPin1 = FALSE;
   lightOn = FALSE;
}


/*************************End of *************************/

 
