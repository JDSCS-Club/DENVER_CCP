/*******************************************************************************
          File:        netmgmt.c

       Version:        1.7

     Reference:        Section 10, Protocol Specification.

       Purpose:        App Layer/Network Management

                       The functions in this file handle the network
                       management messages (HandleNM()) and network
                       diagnostic messages (HandleND()).

          Note:
                           Discard if    Honor even if     Never
                           Not Request   read/write prot   Authcated
                           -----------   ---------------   -----------
Network Management Messages:
NM_QUERY_ID           0x61  YES           YES               YES
NM_RESPOND_TO_QUERY   0x62  no            YES               YES
NM_UPDATE_DOMAIN      0x63  no            YES               no
NM_LEAVE_DOMAIN       0x64  no            YES               no
NM_UPDATE_KEY         0x65  no            YES               no
NM_UPDATE_ADDR        0x66  no            YES               no
NM_QUERY_ADDR         0x67  YES           YES               no
NM_QUERY_NV_CNFG      0x68  YES           YES               no
NM_UPDATE_GROUP_ADDR  0x69  no            YES               no
NM_QUERY_DOMAIN       0x6A  YES           YES               no
NM_UPDATE_NV_CNFG     0x6B  no            YES               no
NM_SET_NODE_MODE      0x6C  no            YES               no
NM_READ_MEMORY        0x6D  YES           Limited           no
NM_WRITE_MEMORY       0x6E  no            Limited           no
NM_CHECKSUM_RECALC    0x6F  no            YES               no
NM_WINK               0x70  no            YES               no
NM_MEMORY_REFRESH     0x71  no            YES               no
NM_QUERY_SNVT         0x72  YES           YES               no
NM_NV_FETCH           0x73  YES           YES               no

Network Diagnostic Messages:
ND_QUERY_STATUS       0x51  YES           YES               YES
ND_PROXY_COMMAND      0x52  YES           YES               YES
ND_CLEAR_STATUS       0x53  NO            YES               no
ND_QUERY_XCVR         0x54  YES           YES               no

Manual Service Request Message:
NM_MANUAL_SERVICE_REQUEST
                      0x1F -na-          -na-              -na-

The HandleNM() function is called for each network management
message, and does the appropriate processing.  Some messages
are simple enough to be processed right in HandleNM(), others
have their own function which is called by HandleNM().

The HandleND() function is called for each network diagnostic
message.  Like HandleNM(), the HandleND() function takes care
of simple messages, and more complicated messages are handled
by their own function.

*******************************************************************************/
/*------------------------------------------------------------------------------
Section: Includes
------------------------------------------------------------------------------*/
#include <string.h>

#include <eia709_1.h>
#include <node.h>
#include <app.h>
#include <api.h>
#include <netmgmt.h>

/*------------------------------------------------------------------------------
Section: Constant Definitions
------------------------------------------------------------------------------*/
/* None */

/*------------------------------------------------------------------------------
Section: Type Definitions
------------------------------------------------------------------------------*/
#pragma maxalign(1)

typedef struct
{
   uint16  transmissionErrors;
   uint16  transmitTXFailures;
   uint16  receiveTXFull;
   uint16  lostMessages;
   uint16  missedMessages;
   uint8   resetCause;
   uint8   nodeState;
   uint8   versionNumber;
   uint8   errorLog;
   uint8   modelNumber;
} NDQueryStat;

#pragma maxalign()

/*------------------------------------------------------------------------------
Section: Globals
------------------------------------------------------------------------------*/
/* None */

/*------------------------------------------------------------------------------
Section: Function Prototypes.
------------------------------------------------------------------------------*/
/* Local Functions */
static void RecomputeChecksum(void);
static void NMNDRespond(NtwkMgmtMsgType msgType,
                        Status success,
                        APPReceiveParam *appReceiveParamPtr,
                        APDU *apduPtr);

/* Network management related functions */
void HandleNMQueryId(APPReceiveParam *appReceiveParamPtr,
                     APDU *apduPtr);

void HandleNMWink(APPReceiveParam *appReceiveParamPtr,
                  APDU *apduPtr);

void HandleNMLeaveDomain(APPReceiveParam *appReceiveParamPtr,
                        APDU *apduPtr);

void HandleNMQueryAddr(APPReceiveParam *appReceiveParamPtr,
                        APDU *apduPtr);

void HandleNMQueryNvCnfg(APPReceiveParam *appReceiveParamPtr,
                        APDU *apduPtr);

void HandleNMQuerySIData(APPReceiveParam *appReceiveParamPtr,
                         APDU *apduPtr);

void HandleNMNVFetch(APPReceiveParam *appReceiveParamPtr,
                     APDU *apduPtr);

void HandleNMReadMemory(APPReceiveParam *appReceiveParamPtr,
                        APDU *apduPtr);

void HandleNMWriteMemory(APPReceiveParam *appReceiveParamPtr,
                        APDU *apduPtr);

void HandleNMQueryDomain(APPReceiveParam *appReceiveParamPtr,
                         APDU *apduPtr);

/* Network diagnostics related functions */
void HandleNDQueryStatus(APPReceiveParam *appReceiveParamPtr,
                         APDU *apduPtr);

void HandleNDProxyCommand(APPReceiveParam *appReceiveParamPtr,
                          APDU            *apduPtr);

void HandleNDTransceiverStatus(APPReceiveParam *appReceiveParamPtr,
                               APDU            *apduPtr);

void HandleNDClearStatus(APPReceiveParam *appReceiveParamPtr,
                         APDU            *apduPtr);

/* This function is for use by HandleNDProxyCommand */
void HandleNDQueryUnconfig(APPReceiveParam *appReceiveParamPtr,
                           APDU *apduPtr);

/* External function from physical layer to get the transceiver status. */
extern void GetTransceiverStatus(Byte transceiverStatusOut[]);

/*------------------------------------------------------------------------------
Section: Function Definitions
------------------------------------------------------------------------------*/
/*******************************************************************************
Function:  RecomputeChecksum
Returns:   None.
Reference: None
Purpose:   To compute the configuration checksum and store.
Comments:  None.
*******************************************************************************/
static void RecomputeChecksum(void)
{
   eep->configCheckSum = ComputeConfigCheckSum();
}


/*******************************************************************************
Function:  ManualServiceRequestMessage
Returns:   TRUE if the message is sent, FALSE otherwise.
Reference: None
Purpose:   Produces a manual service request message.
Comments:  Prototype in api.h so that application program can use this
           function too. Returns TRUE or FALSE so that application
           program can determine whether the message was sent or not.
*******************************************************************************/
Boolean ManualServiceRequestMessage(void)
{
   NWSendParam       *nwSendParamPtr;
   APDU              *apduRespPtr;

   if(QueueFull(&gp->nwOutQ))
   {
      return(FALSE); /* Can't send it now. Try later. */
   }

   /* Send unack domain wide broadcast message. */
   nwSendParamPtr          = QueueTail(&gp->nwOutQ);
   nwSendParamPtr->pduSize = 1 + UNIQUE_NODE_ID_LEN + ID_STR_LEN;
   if (nwSendParamPtr->pduSize > gp->nwOutBufSize)
   {
      return(FALSE); /* Do not have sufficient space to send the message. */
   }
   apduRespPtr                            = (APDU *)(nwSendParamPtr + 1);
   apduRespPtr->code.allBits              = 0x7F;  /* Manual Service Request. */
   nwSendParamPtr->destAddr.domainIndex   = FLEX_DOMAIN;
   nwSendParamPtr->destAddr.flexDomainLen = 0;
   nwSendParamPtr->pduType                = APDU_TYPE;
   nwSendParamPtr->destAddr.addressMode   = BROADCAST;
   nwSendParamPtr->destAddr.addr.addr0    = 0; /* Domain wide broadcast. */
   nwSendParamPtr->deltaBL                = 0;
   nwSendParamPtr->altPath                = 0; /* don't use alternate path. */
   nwSendParamPtr->tag                    = MANUAL_SERVICE_REQ_TAG_VALUE;

   memcpy(apduRespPtr->data, eep->readOnlyData.uniqueNodeId,
          UNIQUE_NODE_ID_LEN);
   memcpy(&(apduRespPtr->data[UNIQUE_NODE_ID_LEN]),
          eep->readOnlyData.progId, ID_STR_LEN);
   EnQueue(&gp->nwOutQ);
   gp->manualServiceRequest = FALSE;
   return(TRUE);
}


/*******************************************************************************
Function:  NMNDRespond
Returns:   None
Reference: None
Purpose:   Respond with success or failure code to current message.
           Can be called either for ND or NM messages.
Comments:  None
*******************************************************************************/
static void NMNDRespond(NtwkMgmtMsgType msgType,
                       Status success,
                       APPReceiveParam *appReceiveParamPtr,
                       APDU            *apduPtr)
{
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;

   /* If service type is not request, nothing to do. */
   if(appReceiveParamPtr->service != REQUEST)
   {
      /* Does not make sense to respond if the original is not a request. */
      return;
   }

   if (QueueFull(&gp->tsaRespQ))
   {
      return; /* Can't send the response. Do nothing. */
   }

   /* Send response. */
   tsaOutQPtr                    = &gp->tsaRespQ;
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->apduSize     = 1;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   if (msgType == NM_MESSAGE)
   {
      apduRespPtr->code.allBits     =
         (success == SUCCESS?NM_resp_success:NM_resp_failure)
            | (apduPtr->code.allBits & 0x1F);
   }
   else
   {
      apduRespPtr->code.allBits     =
         (success == SUCCESS?ND_resp_success:ND_resp_failure)
            | (apduPtr->code.allBits & 0x0F);

   }
   EnQueue(tsaOutQPtr);
}

/*******************************************************************************
Function:  HandleNMLeaveDomain
Returns:   None
Reference: None
Purpose:   Handle incoming NM LeaveDomain message.
              - Delete the indicated domain table entry.
              - Recompute the configuration checksum.
              - If message was received on the indicated domain,
                do not respond
              - If node no longer belongs to any Domain:
                + become unconfigured
                + reset
Comments:  None.
*******************************************************************************/
void HandleNMLeaveDomain(APPReceiveParam *appReceiveParamPtr,
                         APDU            *apduPtr)
{
   /* Fail if message is not 2 bytes long */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* It is not required that the processing of network management commands include
    * parameter validation.  In general, it is the responsibility of the configuration
    * tool to ensure that requests are well formed. */
   if(appReceiveParamPtr->pduSize != 2)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* If the domain index is bad, fail */
   if (apduPtr->data[0] != 0 && apduPtr->data[0] != 1)
   {
      nmp->errorLog = INVALID_DOMAIN;
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   /* Leave the domain */
   memcpy(eep->domainTable[apduPtr->data[0]].domainId,
          "gmrdwf",
          DOMAIN_ID_LEN);
   eep->domainTable[apduPtr->data[0]].subnet      = 0;
   eep->domainTable[apduPtr->data[0]].cloneDomain = 1;
   eep->domainTable[apduPtr->data[0]].node        = 0;
   eep->domainTable[apduPtr->data[0]].len         = 0xFF; /* not in use */
   memcpy(eep->domainTable[apduPtr->data[0]].key,
          "NO_KEY",
          AUTH_KEY_LEN);

   /* Recompute the configuration checksum */
   RecomputeChecksum();

   /* If message not received on domain just left, then respond */
   if(apduPtr->data[0] != appReceiveParamPtr->srcAddr.domainIndex)
   {
      NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr,apduPtr);
   }

   /* If not a member of any domain, go unconfigured and reset. */
   if ((!eep->readOnlyData.twoDomains &&
         eep->domainTable[0].len == 0xFF) ||
       (eep->readOnlyData.twoDomains    &&
        eep->domainTable[0].len == 0xFF &&
        eep->domainTable[1].len == 0xFF) )
   {
      eep->readOnlyData.nodeState = APPL_UNCNFG;
      nmp->resetCause             = SOFTWARE_RESET;
      gp->resetNode               = TRUE; /* Scheduler will reset the node */
   }

   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNMQueryAddr
Returns:   None
Reference: None
Purpose:   Handle incoming NM Query Address message.
Comments:  None.
*******************************************************************************/
void HandleNMQueryAddr(APPReceiveParam *appReceiveParamPtr,
                       APDU            *apduPtr)
{
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;
   AddrTableEntry    *ap;

   tsaOutQPtr = &gp->tsaRespQ;
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   /* Fail if message is not 2 bytes long. */
   if(appReceiveParamPtr->pduSize != 2)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */
   /* Fail if the address table index is bad and set statistics. */
   if (apduPtr->data[0] >= NUM_ADDR_TBL_ENTRIES)
   {
      nmp->errorLog = INVALID_ADDR_TABLE_INDEX;
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* Fail if the buffer is insufficient for the response. */
   if (1 + sizeof(AddrTableEntry) > gp->tsaRespBufSize )
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }

   ap = AccessAddress(apduPtr->data[0]); /* ap should not NULL. */

   /* Send response */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   apduRespPtr->code.allBits     = NM_resp_success | NM_QUERY_ADDR;
   tsaSendParamPtr->apduSize     = 1 + sizeof(AddrTableEntry);
   memcpy(apduRespPtr->data, ap, sizeof(AddrTableEntry));
   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNMQueryNvCnfg
Returns:   None
Reference: None
Purpose:   Handle incoming NM Query Netvar Config message.
Comments:  None.
*******************************************************************************/
void HandleNMQueryNvCnfg(APPReceiveParam *appReceiveParamPtr,
                         APDU            *apduPtr)
{
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;
   uint16            n;
   uint16            nvAliasTableSize;

   /* Fail if the request does not have correct size */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (appReceiveParamPtr->pduSize != 2 && appReceiveParamPtr->pduSize != 4)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   n = apduPtr->data[0];
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (n == 255 && appReceiveParamPtr->pduSize != 4)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   /* Calculate current alias table size */
   nvAliasTableSize = nmp->snvt.aliasPtr->hostAlias;

   /* Decode index */

   /* *** START INFORMATIVE - Escaped NV Index *** */
   /* In implementations which handle a maximum number of network variables that is less
    * than 255, it is not necessary to check for network variable escapes of 255. */
   if(n == 255)
   {
      n = (uint16) apduPtr->data[1];
      n = (n << 8) | apduPtr->data[2];
   }
   /* *** END INFORMATIVE - Escaped NV Index *** */

   /* Fail if there is insufficient space to send the response */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (
       (n < nmp->nvTableSize && (1 + sizeof(NVStruct)) > gp->tsaRespBufSize ) ||
       (n >= nmp->nvTableSize && n < nmp->nvTableSize + nvAliasTableSize &&
         (1 + sizeof(AliasStruct)) > gp->tsaRespBufSize )
      )
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   /* Send response */
   tsaOutQPtr                    = &gp->tsaRespQ;
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   apduRespPtr->code.allBits     = NM_resp_success | NM_QUERY_NV_CNFG;
   if(n < nmp->nvTableSize)
   {
      /* Copy the NVStruct entry */
      tsaSendParamPtr->apduSize = 1 + sizeof(NVStruct);
      memcpy(apduRespPtr->data, &(nmp->nvConfigTable[n]),
         sizeof(NVStruct));
   }
   else if(n < nmp->nvTableSize + nvAliasTableSize)
   {
      /* Copy the alias table entry. */
      tsaSendParamPtr->apduSize = 1 + sizeof(AliasStruct);
      n = n - nmp->nvTableSize;
      memcpy(apduRespPtr->data, &(nmp->nvAliasTable[n]),
         sizeof(AliasStruct));
   }
   else
   {
      nmp->errorLog             = INVALID_NV_INDEX;
      apduRespPtr->code.allBits = NM_resp_failure | NM_QUERY_NV_CNFG;
      tsaSendParamPtr->apduSize = 1;
   }

   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNMNVFetch
Returns:   None
Reference: None
Purpose:   Handle incoming NM NV Fetch message.
Comments:  None.
*******************************************************************************/
void HandleNMNVFetch(APPReceiveParam *appReceiveParamPtr,
                     APDU            *apduPtr)
{
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;
   uint16            n;
   uint8             i;

   /* Check if the message has correct size. If not, fail. */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (appReceiveParamPtr->pduSize != 2 &&
       appReceiveParamPtr->pduSize != 4)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */
   n = apduPtr->data[0];
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (n == 255 && appReceiveParamPtr->pduSize != 4)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */
   tsaOutQPtr = &gp->tsaRespQ;
   /* Send response */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);

   /* *** START INFORMATIVE - Escaped NV Index *** */
   /* See "START INFORMATIVE - Escaped NV Index" above. */
   if(n == 255)
   {
      n = apduPtr->data[1];
      n = (n << 8) | apduPtr->data[2];
      memcpy(apduRespPtr->data, apduPtr->data, 3); /* copy the index */
      i = 3; /* index where value of nv is copied */
   }
   /* *** END INFORMATIVE - Escaped NV Index *** */
   else
   {
      apduRespPtr->data[0] = (char) n;
      i = 1;
   }
   if (n < nmp->nvTableSize)
   {
      /* Make sure there is sufficient space for the response. Else, fail. */
      /* *** START INFORMATIVE - Parameter Validation *** */
      /* See "START INFORMATIVE - Parameter Validation" above. */
      if (nmp->nvFixedTable[n].nvLength + i + 1 > gp->tsaRespBufSize)
      {
         NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      }
      /* *** END INFORMATIVE - Parameter Validation *** */
      memcpy(&apduRespPtr->data[i],
             nmp->nvFixedTable[n].nvAddress,
             nmp->nvFixedTable[n].nvLength);
      tsaSendParamPtr->apduSize = nmp->nvFixedTable[n].nvLength + i + 1;
      apduRespPtr->code.allBits = NM_resp_success | NM_NV_FETCH;
      EnQueue(tsaOutQPtr);

   }
   else
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
   }
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNMQuerySIData
Returns:   None
Reference: None
Purpose:   Handle incoming NM Query SI Data message.
Comments:  None.
*******************************************************************************/
void HandleNMQuerySIData(APPReceiveParam *appReceiveParamPtr,
                         APDU            *apduPtr)
{
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;
   uint16             offset;
   uint8              count;

   tsaOutQPtr = &gp->tsaRespQ;

   /* *** START INFORMATIVE - Query SI Data *** */
   /* It is only necessary to respond to Query SI Data messages (AKA Query SNVT) if
    * the implementation does not support direct memory read/[write] of the device
    * self identification data.  Only a device with a "ReadOnlyDataStruct.snvtStruct"
    * field with value 0xffff must implement this function. */

   /* Fail if message is not 4 bytes long */
   if(appReceiveParamPtr->pduSize != 4)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }

   /* Decode offset and count */
   offset = apduPtr->data[0];
   offset = (offset << 8) | apduPtr->data[1];
   count  = apduPtr->data[2];
   /* Check if we have enough space to respond for this message */
   if (count + 1 > gp->tsaRespBufSize)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }

   /* Send response */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   apduRespPtr->code.allBits     = NM_resp_success | NM_QUERY_SNVT;
   tsaSendParamPtr->apduSize     = 1 + count;
   memcpy(apduRespPtr->data,  offset + (char *)&(nmp->snvt), count);
   EnQueue(tsaOutQPtr);
   /* *** END INFORMATIVE - Query SI Data *** */
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNMWink
Returns:   None
Reference: None
Purpose:   Handle incoming NM Wink message.
Comments:  None.
*******************************************************************************/
void HandleNMWink(APPReceiveParam *appReceiveParamPtr,
                  APDU            *apduPtr)
{
   Queue             *tsaQueuePtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;
   int8               subcmd;
   int8               niIndex;

   subcmd = 0;

   if (appReceiveParamPtr->pduSize > 1)
   {
      subcmd  = apduPtr->data[0];
   }

   if (appReceiveParamPtr->pduSize > 2)
   {
      niIndex = apduPtr->data[1];
   }

   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (appReceiveParamPtr->pduSize > 3)
   {
      /* Incorrect size */
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   /* *** START INFORMATIVE - Wink Handling *** */
   /* Handling of wink subcommands is not required.  That is, it is acceptable
    * to treat all requests with this code as if they were simple wink requests.
    * Wink subcommands are a set of backward compatible extensions to the wink
    * command code. */
   if(appReceiveParamPtr->pduSize <= 1 || subcmd == 0)
   {
      if (appReceiveParamPtr->service != REQUEST)
      {
         /* Any service except request/response */
         Wink();  /* Simple Wink */
      }
      else
      {
        NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      }
      DeQueue(&gp->appInQ);
      return;
   }

   /* must be requesting SEND_ID_INFO. */
   if(appReceiveParamPtr->service != REQUEST)
   {
      DeQueue(&gp->appInQ); /* Discard */
      return; /* The message should be a request. */
   }

   tsaQueuePtr = &gp->tsaRespQ;
   if (QueueFull(tsaQueuePtr))
   {
      return;
   }
   tsaSendParamPtr                = QueueTail(tsaQueuePtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   /* Note: This implementation only has one NI Interface. i.e 0 */
   /* Send response. */
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->nullResponse = FALSE;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);

   if (niIndex == 0 &&
       UNIQUE_NODE_ID_LEN + ID_STR_LEN + 2 <= gp->tsaRespBufSize )
   {
      tsaSendParamPtr->apduSize      = ID_STR_LEN + UNIQUE_NODE_ID_LEN + 2;
      apduRespPtr->data[0]           = 0; /* Interface not down. */
      apduRespPtr->code.allBits      = NM_resp_success | NM_WINK;
      memcpy(&apduRespPtr->data[1], eep->readOnlyData.uniqueNodeId,
             UNIQUE_NODE_ID_LEN);
      memcpy(&(apduRespPtr->data[1+UNIQUE_NODE_ID_LEN]),
             eep->readOnlyData.progId, ID_STR_LEN);
   }
   else
   {
      tsaSendParamPtr->apduSize  = 1;
      apduRespPtr->code.allBits  = NM_resp_failure | NM_WINK;
   }
   EnQueue(tsaQueuePtr);
   /* *** END INFORMATIVE - Wink Handling *** */
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNMQueryId
Returns:   None
Reference: None
Purpose:   Handle incoming NM Query ID message.
Comments:  The message must be a request. There must be space in
           response queue. See HandleNM (We do these checks first).
*******************************************************************************/
void HandleNMQueryId(APPReceiveParam *appReceiveParamPtr,
                     APDU            *apduPtr)
{
   NMQueryIdRequest  *pid;
   char              *memp;
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;
   Boolean            allowed;
   uint16             offset;

   /* Fail if message does not have the correct size. Should be 2 or 6+n */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if(appReceiveParamPtr->pduSize != 2 && appReceiveParamPtr->pduSize < 6)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   tsaOutQPtr = &gp->tsaRespQ;

   /* Init some fields here. Assume we may fail. */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->apduSize     = 1;
   /* Since there are a lot of fail cases, init code to indicate failed
      response. */
   apduRespPtr->code.allBits     = NM_resp_failure | NM_QUERY_ID;

   pid = (NMQueryIdRequest *)&apduPtr->data;
   offset = pid->offset;

   /* if optional fields are present, check that the data field has
      sufficient bytes. */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (appReceiveParamPtr->pduSize > 2 &&
       appReceiveParamPtr->pduSize != (6 + pid->count))
   {
      /* The message does not have sufficient data or it has too much data. */
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   switch(pid->selector)
   {
      case UNCONFIGURED:
         if(!NodeUnConfigured())
         {
            /* Not unconfigured - don't respond. */
            tsaSendParamPtr->nullResponse = TRUE;
            EnQueue(tsaOutQPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         break;
      case SELECTED:
         if(!gp->selectQueryFlag)
         {
            /* Not selected - don't respond. */
            tsaSendParamPtr->nullResponse = TRUE;
            EnQueue(tsaOutQPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         break;
      case SELECTED_UNCFG:   /* must be selected and unconfigured */
         if(!gp->selectQueryFlag)
         {
            /* Not selected - don't respond. */
            tsaSendParamPtr->nullResponse = TRUE;
            EnQueue(tsaOutQPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         if(!NodeUnConfigured())
         {
            /* Not unconfigured - don't respond */
            tsaSendParamPtr->nullResponse = TRUE;
            EnQueue(tsaOutQPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         break;
      default:
         EnQueue(tsaOutQPtr); /* Failed response. */
         DeQueue(&gp->appInQ);
         return;
   }

   /* If memory matching is present, check memory match */
   if(appReceiveParamPtr->pduSize > 2)
   {
      switch(pid->mode)
      {
         case ABSOLUTE_MEM_ADDR:
            memp = (char *)nmp;
            if(offset >= 0xF000)
            {
               memp = (char *)eep - 0xF000;
            }
            else if (offset >= 0xFC00)
            {
               memp = (char *)nmp->memMapSpace - 0xFC00;
            }
            break;
         case CONFIG_RELATIVE:
            memp = (char *)&(eep->configData);
            break;
         case READ_ONLY_RELATIVE:
            memp = (char *)&(eep->readOnlyData);
            break;
         default:
            EnQueue(tsaOutQPtr);
            DeQueue(&gp->appInQ);
            return;   /* Failed response. */
      }

      memp += offset;

      /* Absolute addressing to read snvt is not possible */
      allowed = (memp >= (char *)&eep->readOnlyData &&
                 memp + apduPtr->data[3] < (char *)&eep->domainTable[0]);
      if (!allowed)
      {
         EnQueue(tsaOutQPtr);
         DeQueue(&gp->appInQ);
         return; /* Failed response. */
      }

      if(memcmp(pid->data, memp, pid->count) != 0)
      {
         /* Compare failed - don't reply. */
         tsaSendParamPtr->nullResponse = TRUE;
         EnQueue(tsaOutQPtr);
         DeQueue(&gp->appInQ);
         return;
      }
   }

   /* Send response */
   if (1 + UNIQUE_NODE_ID_LEN + ID_STR_LEN <= gp->tsaRespBufSize )
   {
      tsaSendParamPtr->apduSize = 1 + UNIQUE_NODE_ID_LEN + ID_STR_LEN;
      apduRespPtr->code.allBits = NM_resp_success | NM_QUERY_ID;
      memcpy(apduRespPtr->data, eep->readOnlyData.uniqueNodeId,
             UNIQUE_NODE_ID_LEN);
      memcpy(&(apduRespPtr->data[UNIQUE_NODE_ID_LEN]),
             eep->readOnlyData.progId, ID_STR_LEN);
   }

   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}


/*******************************************************************************
Function:  HandleNMQueryDomain
Returns:   None
Reference: None
Purpose:   Handle incoming NM QueryDomain message.
Comments:  Must be a Request.
*******************************************************************************/
void HandleNMQueryDomain(APPReceiveParam *appReceiveParamPtr,
                         APDU            *apduPtr)
{
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;
   int                n;  /* Domain Index */


   /* Fail if message does not have the correct size. */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if(appReceiveParamPtr->pduSize != 2)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   tsaOutQPtr = &gp->tsaRespQ;
   n = apduPtr->data[0];  /* Domain Index */
   /* If domain index is other than 0 or 1 or if the node is in only one
      domain and the index is 1, then fail. */
   if ((n != 0 && n != 1) || (eep->readOnlyData.twoDomains == 0 && n == 1))
   {
      /* Domain index is bad. */
      nmp->errorLog = INVALID_DOMAIN;
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* If there is not enough space, fail too. */
   if (1 + sizeof(DomainStruct) > gp->tsaRespBufSize)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }

   /* Send response */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->apduSize     = 1 + sizeof(DomainStruct);
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   apduRespPtr->code.allBits     = NM_resp_success | NM_QUERY_DOMAIN;
   memcpy(apduRespPtr->data, &eep->domainTable[n], sizeof(DomainStruct));

   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}


/*******************************************************************************
Function:  HandleNMReadMemory
Returns:   None
Reference: None
Purpose:   Handle incomming NM ReadMemory message
Comments:  None.
*******************************************************************************/
void HandleNMReadMemory(APPReceiveParam *appReceiveParamPtr,
                        APDU            *apduPtr)
{
   Queue               *tsaOutQPtr;
   TSASendParam        *tsaSendParamPtr;
   APDU                *apduRespPtr;
   char                *memp;
   uint16               offset;
   Boolean              allowed;

   tsaOutQPtr = &gp->tsaRespQ;

   /* Fail if message is not 5 bytes long. */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if(appReceiveParamPtr->pduSize != 5)
   {
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   offset = (apduPtr->data[1] << 8) | apduPtr->data[2];

   /* Assemlbe response */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->apduSize     = 1 + apduPtr->data[3];

   apduRespPtr = (APDU *)(tsaSendParamPtr + 1);

   apduRespPtr->code.allBits = NM_resp_success | NM_READ_MEMORY;

   switch(apduPtr->data[0])
   {
      case ABSOLUTE_MEM_ADDR:
         memp = (char *)nmp;
         if(offset >= 0xF000)
         {
            memp = (char *)eep - 0xF000;
         }
         else if (offset >= 0xFC00)
         {
            memp = (char *)nmp->memMapSpace - 0xFC00;
         }
         break;
      case READ_ONLY_RELATIVE:
      default:
         memp = (char *)&(eep->readOnlyData);
         break;
      case CONFIG_RELATIVE:
         memp = (char *)&(eep->configData);
         break;
      case STAT_RELATIVE:
         memp = (char *)&(nmp->stats);
         break;
   }

   memp += offset;

   /* If readWriteProtect flag is on, then only readonly data structure,
      snvt structures, and configuration structure can be read.
      The one byte read of location 0 (firmware number) is also allowed.
      Reference implementation does not support snvt reading through
      absolute addressing. readOnlyData.snvtStruct is 0xFFFF */


   if(eep->readOnlyData.readWriteProtect == TRUE)
   {
      allowed = (memp >= (char *)&eep->readOnlyData &&
                 memp + apduPtr->data[3] < (char *)&eep->domainTable[0]) ||
                 (memp == (char *)&nmp && apduPtr->data[3] == 1);

      if(!allowed)
      {
         tsaSendParamPtr->apduSize = 1;
         apduRespPtr->code.allBits = NM_resp_failure | NM_READ_MEMORY;
         EnQueue(tsaOutQPtr);
         DeQueue(&gp->appInQ);
         return;
      }
   }

   if (apduPtr->data[3] <= gp->tsaRespBufSize)
   {
      memcpy(apduRespPtr->data, memp, apduPtr->data[3]);
   }
   else
   {
      tsaSendParamPtr->apduSize = 1;
   }

   if (memp == (char *)nmp && apduPtr->data[3] == 1)
   {
      /* trap for absolute read of location 0 and write
         version number (hard code it as 11) */
      apduRespPtr->data[0] = 11;
   }
   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNMWriteMemory
Returns:   None
Reference: None
Purpose:   Handle incoming NM WriteMemory message.
Comments:  None.
*******************************************************************************/
void HandleNMWriteMemory(APPReceiveParam *appReceiveParamPtr,
                        APDU            *apduPtr)
{
   Queue                *tsaOutQPtr;
   TSASendParam         *tsaSendParamPtr;
   APDU                 *apduRespPtr;
   NMWriteMemoryRequest *pr;
   char                 *memp;
   uint16                offset;
   Boolean               allowed;

   tsaOutQPtr = &gp->tsaRespQ;

   /* Fail if message is not at least 6 bytes long */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if(appReceiveParamPtr->pduSize < 6)
   {
      NMNDRespond(NM_MESSAGE, FAILURE,appReceiveParamPtr,apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   /* Pointer to struct describing memory request */
   pr = (NMWriteMemoryRequest *)&apduPtr->data[0];

   offset = pr->offset;

   /* Fail if message length doesn't match count. Poke can use 16 data bytes.
      Allow that. Note that the code takes one byte. */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if(appReceiveParamPtr->pduSize != 6 + pr->count &&
      appReceiveParamPtr->pduSize != 17)
   {
      NMNDRespond(NM_MESSAGE, FAILURE,appReceiveParamPtr,apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   if (appReceiveParamPtr->service == REQUEST)
   {
      /* Assemble response */
      tsaSendParamPtr               = QueueTail(tsaOutQPtr);
      tsaSendParamPtr->altPathOverride = FALSE;
      tsaSendParamPtr->service      = RESPONSE;
      tsaSendParamPtr->nullResponse = FALSE;
      tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
      tsaSendParamPtr->apduSize     = 1;
      apduRespPtr = (APDU *)(tsaSendParamPtr + 1);
   }

   switch(pr->mode)
   {
      case ABSOLUTE_MEM_ADDR:
         memp = (char *)nmp;
         if(offset >= 0xF000)
         {
            memp = (char *)eep - 0xF000;
         }
         else if (offset >= 0xFC00)
         {
            memp = (char *)nmp->memMapSpace - 0xFC00;
         }
         break;
      case CONFIG_RELATIVE:
         memp = (char *)&(eep->configData);
         break;
      case STAT_RELATIVE:
         memp = (char *)&(nmp->stats);
         break;
      case READ_ONLY_RELATIVE:
         memp = (char *)&(eep->readOnlyData);
         break;
      default:
         /* Invalid Mode */
         NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
   }

   memp += offset;

   /* Check if the range of memory cells written is good. */
   allowed = (memp >= (char *)nmp &&
              (memp + pr->count) <= ((char *)nmp + 64 * 1024)) ||
              (memp >= (char *)eep &&
                     (memp + pr->count) <= ((char *)eep + sizeof(EEPROM)));
   if (! allowed)
   {

      /* Send failure response if the message was a request */
      NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }

   /* If readwrite flag is on, then only config structure can be written. */
   if(eep->readOnlyData.readWriteProtect == TRUE)
   {
      allowed = (memp >= (char *)&eep->configData &&
                 memp + pr->count < (char *)&eep->domainTable[0]);

      if(! allowed)
      {
         /* Send failure response if the message was a request */
         NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      }
   }

   /* Need to copy only the data array in NM_Req structure.
      The header is 5 bytes long */
   /* We have to assume that pr->count is good. Max is 255 */
   /* Reference implementation has no application check sum.
      Only config checksum */
   memcpy(memp, apduPtr->data+5, pr->count);

   if (pr->form & CNFG_CS_RECALC) {
      RecomputeChecksum();
   }
   if (pr->form & ACTION_RESET) {
      gp->resetNode   = TRUE;
      nmp->resetCause = SOFTWARE_RESET;
   }

   /* There is no harm in responding even when the node is reset. It will
      be lost anyway */
   if(appReceiveParamPtr->service == REQUEST)
   {
      apduRespPtr->code.allBits = NM_resp_success | NM_WRITE_MEMORY;
      EnQueue(tsaOutQPtr);
   }
   DeQueue(&gp->appInQ);
}



/*******************************************************************************
Function:  HandleProxyResponse
Returns:   None
Reference: None
Purpose:   Handle Proxy Response Message.
Comments:  None.
*******************************************************************************/
void HandleProxyResponse(APPReceiveParam *appReceiveParamPtr,
                         APDU            *apduPtr)
{
   Queue         *tsaOutQPtr;
   TSASendParam  *tsaSendParamPtr;
   APDU          *apduRespPtr;

   /* Send response */
   tsaOutQPtr = &gp->tsaRespQ;

   if(QueueFull(tsaOutQPtr))
   {
      return;  /* Return without processing message */
   }

   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = nmp->pxyData.reqId;
   tsaSendParamPtr->apduSize     = appReceiveParamPtr->pduSize;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   if (appReceiveParamPtr->pduSize <= gp->tsaRespBufSize)
   {
      memcpy(apduRespPtr, apduPtr, appReceiveParamPtr->pduSize);
   }
   else
   {
      tsaSendParamPtr->apduSize = 1;
   }

   EnQueue(tsaOutQPtr);

   /* Done processing */
   DeQueue(&gp->appInQ);

   /* Reset the flag as we have now responded */
   nmp->pxyData.pxyType = -1;
}

/*******************************************************************************
Function:  HandleNDQueryStatus
Returns:   none
Reference: None
Purpose:   Handle Network Diagnostics Query Status Message.
Comments:  None.
*******************************************************************************/
void HandleNDQueryStatus(APPReceiveParam *appReceiveParamPtr,
                         APDU *apduPtr)
{
   NDQueryStat    ndq;
   Queue         *tsaOutQPtr;
   TSASendParam  *tsaSendParamPtr;
   APDU          *apduRespPtr;

   tsaOutQPtr = &gp->tsaRespQ;
   if (((apduPtr->code.allBits & 0x0F) == ND_QUERY_STATUS) &&
        appReceiveParamPtr->pduSize != 1)
   {
      /* Incorrect size. Fail. */
      NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }

   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (((apduPtr->code.allBits & 0x0F) == ND_PROXY_COMMAND) &&
        appReceiveParamPtr->pduSize != 2)
   {
      /* Incorrect size. Fail. */
      NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   ndq.transmissionErrors = nmp->stats.transmissionErrors;
   ndq.transmitTXFailures = nmp->stats.transmitTXFailures;
   ndq.receiveTXFull      = nmp->stats.receiveTXFull;
   ndq.lostMessages       = nmp->stats.lostMessages;
   ndq.missedMessages     = nmp->stats.missedMessages;
   ndq.resetCause         = nmp->resetCause;
   if (eep->readOnlyData.nodeState == CNFG_ONLINE &&
       gp->appPgmMode == OFF_LINE)
   {
      ndq.nodeState = SOFT_OFFLINE;
   }
   else
   {
      ndq.nodeState = eep->readOnlyData.nodeState;
   }
   ndq.versionNumber = 128;
   ndq.errorLog      = nmp->errorLog;
   ndq.modelNumber   = 128;
    /* Send response */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->apduSize     = 1 + sizeof(NDQueryStat);
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   /* The response code is formed using apduPtr->code.allBits as the
      actual could be a proxy command and the response code will be
      different. Thus, using apduPtr->code.allBits works for both
      native query status command as well as proxy based query status */
   if (tsaSendParamPtr->apduSize <= gp->tsaRespBufSize)
   {
      apduRespPtr->code.allBits     =
         ND_resp_success | (apduPtr->code.allBits & 0x0F);
      memcpy(apduRespPtr->data, &ndq,  sizeof(NDQueryStat));
   }
   else
   {
      apduRespPtr->code.allBits     =
         ND_resp_failure | (apduPtr->code.allBits & 0x0F);
      tsaSendParamPtr->apduSize     = 1;
   }
   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);

}

/*******************************************************************************
Function:  HandleNDProxyCommand
Returns:   none
Reference: None
Purpose:   Handle network diagnostics proxy request message.
Comments:  None.
*******************************************************************************/
void HandleNDProxyCommand(APPReceiveParam *appReceiveParamPtr,
                          APDU            *apduPtr)
{
   Queue         *tsaOutQPtr;
   TSASendParam  *tsaSendParamPtr;
   APDU          *apduSendPtr;


   /* See if the proxy command is to be forwarded or it is for us
      to process. If the address information in the packet is missing,
      then there is no forwarding information and hence we respond directly */
   if (appReceiveParamPtr->pduSize == 2)
   {
       /* Address portion is missing. This node is the proxy target. */
      tsaOutQPtr = &gp->tsaRespQ;
      /* Send the response directly back to the sender */
      switch(apduPtr->data[0])
      {
         case 0:
            HandleNDQueryUnconfig(appReceiveParamPtr, apduPtr);
            break;
         case 1:
            HandleNDQueryStatus(appReceiveParamPtr, apduPtr);
            break;
         case 2:
            HandleNDTransceiverStatus(appReceiveParamPtr, apduPtr);
            break;
         default:
            /* Invalid sub_command. Send failure response */
            NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
      }
      return;
   }

   /* Send failure response if a proxy command is already in progress
      or we are proxy agent and the message received is on flex domain
      or it does not have correct size */
   if (
       nmp->pxyData.pxyType != -1 ||
       appReceiveParamPtr->srcAddr.domainIndex == FLEX_DOMAIN ||
       (apduPtr->data[1] == UNIQUE_NODE_ID &&
            appReceiveParamPtr->pduSize !=
               (2 + sizeof(AddrTableEntry) + UNIQUE_NODE_ID_LEN) ) ||
       (apduPtr->data[1] != UNIQUE_NODE_ID &&
            appReceiveParamPtr->pduSize != (2 + sizeof(AddrTableEntry)) )
      )
   {
      NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }


   /* We need to forward the proxy now. Set the target queue ptrs */
   if(appReceiveParamPtr->priority)
   {
      tsaOutQPtr = &gp->tsaOutPriQ;
   }
   else
   {
      tsaOutQPtr = &gp->tsaOutQ;
   }

   /* Check if the target queue has space for forwarding this request. */
   if(QueueFull(tsaOutQPtr))
   {
      return;  /* Return without processing message */
   }

   /* Save the proxy data for processing the response later.
      Also, pxyType will no longer be equal to -1 which serves
      as a kind of lock on this record. Future proxy commands
      will be ignored until this proxy command is done. The proxy
      command is done as soon as we get the response and we forward
      it to the original sender or when the transaction forwarding
      the proxy times out. Session layer will not give us duplicate
      requests and hence we don't need to handle that here. Also,
      session layet will take care of sending response again for
      duplicate requests. */
   nmp->pxyData.pxyType = apduPtr->data[0];
   nmp->pxyData.reqId   = appReceiveParamPtr->reqId;

   /* Generate request message */
   tsaSendParamPtr                = QueueTail(tsaOutQPtr);
   /* First copy the msg_out_addr info in the proxy command */
   if (apduPtr->data[1] == UNIQUE_NODE_ID)
   {
      memcpy(&tsaSendParamPtr->destAddr,&apduPtr->data[1],
             sizeof(MsgOutAddr) + UNIQUE_NODE_ID_LEN);
   }
   else
   {
      memcpy(&tsaSendParamPtr->destAddr,&apduPtr->data[1],
             sizeof(MsgOutAddr));
   }
   /* Set the domain index to be the one in which it was received.
      Note that this cannot be flex domain. Transport or session
      will use this instead of the one in the destAddr (i.e msg_out_addr) */
   tsaSendParamPtr->domainIndex   = appReceiveParamPtr->srcAddr.domainIndex;
   tsaSendParamPtr->service  = REQUEST;
   tsaSendParamPtr->auth     = FALSE;
   tsaSendParamPtr->tag      = (MsgTag) 0xFFFF;
   /* Proxy relays the message, the altpath bit should be same as the one
      used for the proxy message received */
   tsaSendParamPtr->altPathOverride = TRUE;
   tsaSendParamPtr->altPath = appReceiveParamPtr->altPath;
   tsaSendParamPtr->apduSize = 2; /* Always two bytes: code + sub_command */
   apduSendPtr  = (APDU *)(tsaSendParamPtr + 1);
   /* Copy the code as it is */
   apduSendPtr->code.allBits = apduPtr->code.allBits;
   apduSendPtr->data[0] = apduPtr->data[0];
   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNDTransceiverStatus
Returns:   none
Reference: None
Purpose:   Handle network diagnostics transceiver status message.
Comments:  None.
*******************************************************************************/
void HandleNDTransceiverStatus(APPReceiveParam *appReceiveParamPtr,
                               APDU            *apduPtr)
{
   Queue         *tsaOutQPtr;
   TSASendParam  *tsaSendParamPtr;
   APDU          *apduRespPtr;
   Byte           transceiverStatus[NUM_COMM_PARAMS];
   uint8          n;

   /* Check for proper size of the message. Regular pdusize is 1 byte.
      If this fn is called due to proxy request, then it is 2 bytes. */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (appReceiveParamPtr->pduSize > 2)
   {
      NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */
   else if (appReceiveParamPtr->pduSize == 2)
   {
      /* Make sure it is a proxy request. Or else, length is wrong. */
      if (apduPtr->code.nd.ndFlag == 0x5 &&
          apduPtr->code.nd.ndCode == ND_PROXY_COMMAND &&
          apduPtr->data[0] == 2)
      {
         ; /* It is indeed a proxy command. Length ok. Proceed. */
      }
      else
      {
         NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      }
   }

   if (eep->configData.commType == SPECIAL_PURPOSE)
   {
      GetTransceiverStatus(transceiverStatus);
      n = NUM_COMM_PARAMS;
   }
   else
   {
      n = 0;
   }

   /* Send response */
   tsaOutQPtr = &gp->tsaRespQ;
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->apduSize     = 1 + n;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);

   /* If a node does not have transceiver status registers, fail */
   if ( n > 0 &&
       tsaSendParamPtr->apduSize <= gp->tsaRespBufSize)
   {
      /* No registers or not enough space */
      apduRespPtr->code.allBits     = ND_resp_success |
                                       (apduPtr->code.allBits & 0x0F);

      memcpy(apduRespPtr->data, transceiverStatus, n);
   }
   else
   {
      apduRespPtr->code.allBits     = ND_resp_failure |
                                      (apduPtr->code.allBits & 0x0F);

      tsaSendParamPtr->apduSize     = 1;
   }
   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNDClearStatus
Returns:   none
Reference: None
Purpose:   Handle network diagnostics clear status message.
Comments:  None.
*******************************************************************************/
void HandleNDClearStatus(APPReceiveParam *appReceiveParamPtr,
                         APDU            *apduPtr)
{

   /* Check for proper size of the message */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (appReceiveParamPtr->pduSize != 1)
   {
      NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   /* Clear Status */
   nmp->stats.transmissionErrors   = 0;
   nmp->stats.transmitTXFailures   = 0;
   nmp->stats.receiveTXFull        = 0;
   nmp->stats.lostMessages         = 0;
   nmp->stats.missedMessages       = 0;
   nmp->stats.layer2Received       = 0;
   nmp->stats.layer3Received       = 0;
   nmp->stats.layer3Transmitted    = 0;
   nmp->stats.transmitTXRetries    = 0;
   nmp->stats.backlogOverflow      = 0;
   nmp->stats.lateAcknowledgements = 0;
   nmp->stats.collisions           = 0;
   nmp->resetCause                 = CLEARED;
   nmp->errorLog                   = NO_ERRORS;  /* Cleared */

   nmp->stats.layer6_7MsgsSent     = 0;
   nmp->stats.layer6_7RespSent     = 0;
   nmp->stats.layer6_7MsgsRcvd     = 0;
   nmp->stats.layer6_7RespRcvd     = 0;
   nmp->stats.lateResponses        = 0;
   nmp->stats.lateChallenges       = 0;
   nmp->stats.lateReplies          = 0;

   /* NMNDRespond will send response only if the msg is REQUEST */
   NMNDRespond(ND_MESSAGE, SUCCESS, appReceiveParamPtr, apduPtr);
   DeQueue(&gp->appInQ);
}

/*******************************************************************************
Function:  HandleNDQueryUnconfig
Returns:   None
Reference: None
Purpose:   Handle Query Unconfig through Proxy message.
Comments:  This is a simplified version of HandleNMQueryId.
           Only unconfig version of Query ID is supported.
*******************************************************************************/
void HandleNDQueryUnconfig(APPReceiveParam *appReceiveParamPtr,
                           APDU            *apduPtr)
{
   Queue             *tsaOutQPtr;
   TSASendParam      *tsaSendParamPtr;
   APDU              *apduRespPtr;


   /* Check for proper size of the message */
   /* *** START INFORMATIVE - Parameter Validation *** */
   /* See "START INFORMATIVE - Parameter Validation" above. */
   if (appReceiveParamPtr->pduSize != 2)
   {
      NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
      DeQueue(&gp->appInQ);
      return;
   }
   /* *** END INFORMATIVE - Parameter Validation *** */

   tsaOutQPtr = &gp->tsaRespQ;

   /* Init some fields here. */
   tsaSendParamPtr               = QueueTail(tsaOutQPtr);
   tsaSendParamPtr->altPathOverride = FALSE;
   apduRespPtr                   = (APDU *)(tsaSendParamPtr + 1);
   tsaSendParamPtr->service      = RESPONSE;
   tsaSendParamPtr->nullResponse = FALSE;
   tsaSendParamPtr->reqId        = appReceiveParamPtr->reqId;
   tsaSendParamPtr->apduSize     = 1;
   /* apduPtr->code.allBits should be proxy code */
   apduRespPtr->code.allBits     = ND_resp_failure |
                                   (apduPtr->code.allBits & 0x0F);


   if(!NodeUnConfigured())
   {
      /* Not unconfigured - don't respond. */
      tsaSendParamPtr->nullResponse = TRUE;
      EnQueue(tsaOutQPtr);
      DeQueue(&gp->appInQ);
      return;
   }

   /* Send response */
   if (1 + UNIQUE_NODE_ID_LEN + ID_STR_LEN <= gp->tsaRespBufSize )
   {
      tsaSendParamPtr->apduSize = 1 + UNIQUE_NODE_ID_LEN + ID_STR_LEN;
      apduRespPtr->code.allBits = ND_resp_success |
                                  (apduPtr->code.allBits & 0x0F);
      memcpy(apduRespPtr->data, eep->readOnlyData.uniqueNodeId,
             UNIQUE_NODE_ID_LEN);
      memcpy(&(apduRespPtr->data[UNIQUE_NODE_ID_LEN]),
             eep->readOnlyData.progId, ID_STR_LEN);
   }

   EnQueue(tsaOutQPtr);
   DeQueue(&gp->appInQ);
}


/*******************************************************************************
Function:  HandleND
Returns:   None
Reference: None
Purpose:   Handle incomming network diagnostic message.
Comments:  None.
*******************************************************************************/
void HandleND(APPReceiveParam *appReceiveParamPtr,
              APDU            *apduPtr)
{
   if(appReceiveParamPtr->service == RESPONSE)
   {
      /* It is not legal for a response to be an ND command */
      DeQueue(&gp->appInQ);
      return;
   }

   /* If network diagnostics messages need authentication
      and the message did not pass authentication and
      the node is not unconfigured
      then discard those messages that should be discarded and return. */
   if(!NodeUnConfigured() && eep->configData.nmAuth &&
      !appReceiveParamPtr->auth)
   {
      /* Only two messages are allowed. Others should be discarded */
      if (apduPtr->code.nd.ndCode != ND_QUERY_STATUS &&
          apduPtr->code.nd.ndCode != ND_PROXY_COMMAND)
      {
         if(QueueFull(&gp->tsaRespQ))
         {
            return;  /* Can't send response now. Try later. */
         }
         nmp->errorLog = AUTHENTICATION_MISMATCH;
         NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      }
   }

   /* Only clear status command need not be request message. Others
      must be request/response */
   if (apduPtr->code.nd.ndCode != ND_CLEAR_STATUS &&
       appReceiveParamPtr->service != REQUEST)
   {
      /* Discard. We can't respond anyway as it is not a request */
      DeQueue(&gp->appInQ);
      return;
   }

   if (appReceiveParamPtr->service == REQUEST &&
       QueueFull(&gp->tsaRespQ))
   {
      return; /* Can't send a response. Try later. */
   }

   /* Handle various network diagnostic message codes */
   switch(apduPtr->code.nd.ndCode)
   {
      case ND_QUERY_STATUS:
         HandleNDQueryStatus(appReceiveParamPtr, apduPtr);
         return;
      case ND_PROXY_COMMAND:
         HandleNDProxyCommand(appReceiveParamPtr, apduPtr);
         return;
      case ND_CLEAR_STATUS:
         HandleNDClearStatus(appReceiveParamPtr, apduPtr);
         return;
      case ND_QUERY_XCVR:
         HandleNDTransceiverStatus(appReceiveParamPtr, apduPtr);
         return;
      default:
         /* Discard unrecognized diagnostic command */
         NMNDRespond(ND_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
   }
}

/*******************************************************************************
Function:  HandleNM
Returns:   None
Reference: None
Purpose:   Handle incomming network management messages.
Comments:  None.
*******************************************************************************/
void HandleNM(APPReceiveParam *appReceiveParamPtr,
              APDU            *apduPtr)
{
   int16            i;
   uint16           n; /* for nv index */
   AddrTableEntry  *ap;
   GroupAddrMode   *groupStrPtr;
   uint16           addrIndex;
   NVStruct        *np;
   uint16           nvAliasTableSize;
   uint8            pduSize;

   if(appReceiveParamPtr->service == RESPONSE)
   {
      /* It is not legal for a response to be an NM command. */
      DeQueue(&gp->appInQ);
      return;
   }

   /* If network management messages need authentication
      and the message did not pass authentication and
      the node is not unconfigured
      then discard those messages that should be discarded and return. */
   if(!NodeUnConfigured() && eep->configData.nmAuth && !appReceiveParamPtr->auth)
   {
      /* Only two messages are allowed. Others should be discarded */
      if (apduPtr->code.nm.nmCode != NM_QUERY_ID &&
          apduPtr->code.nm.nmCode != NM_RESPOND_TO_QUERY)
      {
         if(QueueFull(&gp->tsaRespQ))
         {
            return;  /* Can't send response now. Try later. */
         }
         nmp->errorLog = AUTHENTICATION_MISMATCH;
         NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      }
   }

   /* If the service type is not request, discard certain messages. */
   if(appReceiveParamPtr->service != REQUEST)
   {
      switch(apduPtr->code.nm.nmCode)
      {
         /* messages that need request/resp. */
         case NM_QUERY_ID:
         case NM_QUERY_ADDR:
         case NM_QUERY_NV_CNFG:
         case NM_QUERY_DOMAIN:
         case NM_READ_MEMORY:
         case NM_QUERY_SNVT:
         case NM_NV_FETCH:
            DeQueue(&gp->appInQ);
            return;
         default:
            break;
      }
   }

   /* If service type is request, and there is no room for response
      return without processing - so message will be processed later. */
   if(appReceiveParamPtr->service == REQUEST)
   {
      if(QueueFull(&gp->tsaRespQ))
      {
         return; /* Wait until there is room for response. */
      }
   }

   /* Handle various network mgmt message codes */
   switch(apduPtr->code.nm.nmCode)
   {
      case NM_QUERY_ID:
         HandleNMQueryId(appReceiveParamPtr,apduPtr);
         return;
      case NM_RESPOND_TO_QUERY:
         /* Fail if message is not 2 bytes long or the byte is bad. */
         if(appReceiveParamPtr->pduSize != 2 ||
            (apduPtr->data[0] != 0 && apduPtr->data[0] != 1) )
         {
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         gp->selectQueryFlag = apduPtr->data[0];
         NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr,apduPtr);
         DeQueue(&gp->appInQ);
         return;
      case NM_UPDATE_DOMAIN:
         /* Fail if message is not the right size or the domain_index is bad. */
         if(appReceiveParamPtr->pduSize != 2 + sizeof(DomainStruct))
         {
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         if (apduPtr->data[0] != 0 && apduPtr->data[0] != 1)
         {
            nmp->errorLog = INVALID_DOMAIN;
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* If the node is in only one domain and the request is to update
            domain index 1, then we send a failure response. */
         if (eep->readOnlyData.twoDomains == 0 &&
             apduPtr->data[0] == 1)
         {
            nmp->errorLog = INVALID_DOMAIN;
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* Reference implementation allows even clone domain update. */
         if (((DomainStruct *)&apduPtr->data[1])->cloneDomain == 1)
         {
            UpdateDomain((DomainStruct *)&apduPtr->data[1], apduPtr->data[0]);
         }
         else
         {
            UpdateCloneDomain((DomainStruct *)&apduPtr->data[1],
                              apduPtr->data[0]);
         }
         NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr, apduPtr);
         RecomputeChecksum();
         DeQueue(&gp->appInQ);
         return;
      case NM_LEAVE_DOMAIN:
         HandleNMLeaveDomain(appReceiveParamPtr, apduPtr);
         return;
      case NM_UPDATE_KEY:
         /* Fail if message is not of correct length or domain index is bad. */
         /* *** START INFORMATIVE - Parameter Validation *** */
         /* See "START INFORMATIVE - Parameter Validation" above. */
         if(appReceiveParamPtr->pduSize != 2 + AUTH_KEY_LEN)
         {
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         if (apduPtr->data[0] != 0 && apduPtr->data[0] != 1)
         {
            nmp->errorLog = INVALID_DOMAIN;
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* *** END INFORMATIVE - Parameter Validation *** */

         for(i = 0; i < AUTH_KEY_LEN; i++)
         {
            eep->domainTable[apduPtr->data[0]].key[i] +=
               apduPtr->data[i+1];
         }
         RecomputeChecksum();
         NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr,apduPtr);
         DeQueue(&gp->appInQ);
         return;
      case NM_UPDATE_ADDR:
         /* Check for incorrect size. Allow for padding. */
         /* *** START INFORMATIVE - Parameter Validation *** */
         /* See "START INFORMATIVE - Parameter Validation" above. */
         if (  appReceiveParamPtr->pduSize < 6 ||
               appReceiveParamPtr->pduSize > 7)
         {
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         if (apduPtr->data[1] != UNBOUND)
         {
            /* Not turnaround. Must be 7 bytes. */
            if (appReceiveParamPtr->pduSize != 7)
            {
               NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
               DeQueue(&gp->appInQ);
               return;
            }
         }
         /* *** END INFORMATIVE - Parameter Validation *** */
         /* Fail if the address table index is bad. */
         if (apduPtr->data[0] >= NUM_ADDR_TBL_ENTRIES)
         {
            nmp->errorLog = INVALID_ADDR_TABLE_INDEX;
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }

         UpdateAddress((AddrTableEntry *)&apduPtr->data[1], apduPtr->data[0]);
         RecomputeChecksum();
         NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      case NM_QUERY_ADDR:
         HandleNMQueryAddr(appReceiveParamPtr, apduPtr);
         return;
      case NM_QUERY_NV_CNFG:
         HandleNMQueryNvCnfg(appReceiveParamPtr, apduPtr);
         return;
      case NM_UPDATE_GROUP_ADDR:
         /* This message must be delivered with group addressing and is
            updated based on the domain in which it was received. Hence,
            flex domain is not allowed. */
         if (appReceiveParamPtr->srcAddr.addressMode != MULTICAST ||
             appReceiveParamPtr->srcAddr.domainIndex == FLEX_DOMAIN)
         {
            /* This message should be sent in MULTICAST. Fail */
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* *** START INFORMATIVE - Parameter Validation *** */
         /* See "START INFORMATIVE - Parameter Validation" above. */
         if (appReceiveParamPtr->pduSize != 1 + sizeof(AddrTableEntry))
         {
            /* Incorrect size */
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* *** END INFORMATIVE - Parameter Validation *** */
         /* For accessing the corresponding address table entry,
            let us use the domainIndex in which it was received and
            the group in which it was received. It makes sense to use
            the domainIndex in which the message was received rather than
            the domain index in the packet(which will be same for all
            recipients) as it may be different for different nodes. */
         groupStrPtr = (GroupAddrMode *)&apduPtr->data[0];
         if (groupStrPtr->groupFlag == 1)
         {
            addrIndex = AddrTableIndex(appReceiveParamPtr->srcAddr.domainIndex,
                                       appReceiveParamPtr->srcAddr.group);
         }

         /* Make sure we got a good index. */
         if (groupStrPtr->groupFlag != 1 || addrIndex == 0xFF)
         {
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         ap = AccessAddress(addrIndex); /* ap cannot be NULL */
         /* Only group size and timer values should be changed */
         ap->groupEntry.groupSize  = groupStrPtr->groupSize;
         ap->groupEntry.rptTimer   = groupStrPtr->rptTimer;
         ap->groupEntry.retryCount = groupStrPtr->retryCount;
         ap->groupEntry.rcvTimer   = groupStrPtr->rcvTimer;
         ap->groupEntry.txTimer    = groupStrPtr->txTimer;
         RecomputeChecksum();
         NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      case NM_QUERY_DOMAIN:
         HandleNMQueryDomain(appReceiveParamPtr,apduPtr);
         return;
      case NM_UPDATE_NV_CNFG:
         /* Check for pdu size. Fail if the size is too small or too big */
         /* *** START INFORMATIVE - Parameter Validation *** */
         /* See "START INFORMATIVE - Parameter Validation" above. */
         if (appReceiveParamPtr->pduSize < 5 ||
             appReceiveParamPtr->pduSize > 10)
         {
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* *** END INFORMATIVE - Parameter Validation *** */
         nvAliasTableSize = nmp->snvt.aliasPtr->hostAlias;
         /* Decode index */

         n = apduPtr->data[0];
         /* *** START INFORMATIVE - Escaped NV Index *** */
         /* See "START INFORMATIVE - Escaped NV Index" above. */
         if(n == 255)
         {
            n = (uint16)apduPtr->data[1];
            n = (n << 8) | apduPtr->data[2];
            if (n < nmp->nvTableSize)
            {
               pduSize = sizeof(NVStruct) + 4; /* escaped regular update */
            }
            else
            {
               /* Escaped alias update. Assume that host_primary is
                  absent for now. */
               pduSize = (sizeof(AliasStruct) - 2) + 4;
            }
            np = (NVStruct *)(&apduPtr->data[3]);
         }
         /* *** END INFORMATIVE - Escaped NV Index *** */
         else
         {
            if (n < nmp->nvTableSize)
            {
               pduSize = sizeof(NVStruct) + 2; /* regular update */
            }
            else
            {
               /* Alias update. Assume that host_primary is absent for now. */
               /* last 2 is for index + code */
               pduSize = (sizeof(AliasStruct) - 2) + 2;
            }
            np = (NVStruct *)(&apduPtr->data[1]);
         }

         /* Update nv config or alias table */
         if(n < nmp->nvTableSize)
         {
            if (appReceiveParamPtr->pduSize >= pduSize)
            {
               memcpy(&nmp->nvConfigTable[n], np, sizeof(NVStruct));
            }
            else
            {
               /* Incorrect size */
               NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
               DeQueue(&gp->appInQ);
               return;
            }
         }
         else if(n < nmp->nvTableSize + nvAliasTableSize)
         {
            n = n - nmp->nvTableSize; /* Alias table index */
            /* Check for various forms of alias update */
            if (((AliasStruct *)np)->primary == 0xFF &&
                appReceiveParamPtr->pduSize == pduSize)
            {
               /* host_primary missing. default to 0xffff. Null alias update. */
               ((AliasStruct *)np)->hostPrimary = 0xffff;
            }
            else if (((AliasStruct *)np)->primary == 0xFF)
            {
               /* escaped alias. hostPrimary is present */
               pduSize += 2;
            }
            /* Update the nv alias table */
            if (appReceiveParamPtr->pduSize >= pduSize)
            {
               memcpy(&nmp->nvAliasTable[n], np, sizeof(AliasStruct));
            }
            else
            {
               /* Incorrect size */
               NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
               DeQueue(&gp->appInQ);
               return;
            }
         }
         else
         {
            /* Invalid nv table index */
            nmp->errorLog = INVALID_NV_INDEX;
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }

         /* Recompute checksum and send response */
         RecomputeChecksum();
         NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;

      /* NM_SET_NODE_MODE:
       *                                                          Possible
       * Description                   State  Mode   Service LED  in ref imp?
       * --------------------------------------------------------------------
       * Applicationless, unconfigured   3     -     On           NO
       * Unconfigured (w/application)    2     -     Flashing     YES
       * Configured, Hard Offline        6     -     Off          NO
       * Configured                      4     1     Off          YES
       * Configured, Soft offline        4     0     Off          YES
       *
       * The NM_SET_NODE_MODE message encompasses a lot of functionality,
       * and impacts some other areas of the implementation.
       * 1) Mode is not maintained in EEPROM
       * 2) A node that is soft-offline will go on-line when it is reset
       * 3) The hard-offline state is preserved across reset
       * 4) For either hard or soft offline, the scheduler is disabled
       * 5) When soft-offline:
       *    A) Polling an NV will return NULL data
       *    B) Incomming network variable updates are handled normally
       *    C) But nv_update_occurs events will be lost
       * 6) In all other states except configured:
       *    A) No response is returned on NV polls
       *    B) Incomming NV updates are discarded
       * 7) If a node is in a non-configured state, is reset and then issued
       *    a command to go configured, it will come up soft offline
       * 8) If a set node mode message changes the mode to offline or online
       *    the approprite task (if any) is executed
       * 9) Changing the node state recomputes the configuration checksum
       */
      case NM_SET_NODE_MODE:
         /* Fail if message is not 2 or 3 bytes long. */
         /* *** START INFORMATIVE - Parameter Validation *** */
         /* See "START INFORMATIVE - Parameter Validation" above. */
         if(appReceiveParamPtr->pduSize < 2 || appReceiveParamPtr->pduSize > 3)
         {
            NMNDRespond(NM_MESSAGE, FAILURE,appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         if ( (apduPtr->data[0] != 3 && (appReceiveParamPtr->pduSize < 2 || appReceiveParamPtr->pduSize > 3)) ||
              (apduPtr->data[0] == 3 && appReceiveParamPtr->pduSize != 3)
            )
         {
            /* Incorrect size */
            NMNDRespond(NM_MESSAGE, FAILURE,appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* *** END INFORMATIVE - Parameter Validation *** */

         /* Mode on-line and mode off-line messages must not be request
            messages. See Page 9-47 Technology Device Data Book. Rev 3 */
         if (
               (apduPtr->data[0] == 0 || apduPtr->data[0] == 1)
               &&
               appReceiveParamPtr->service == REQUEST
            )
         {
            /* Fail. */
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }

         switch(apduPtr->data[0])
         {
            case 0:  /* Go to soft offline state */
               if (AppPgmRuns())
               {
                  OfflineEvent();  /* Indicate to application program. */
               }
               eep->readOnlyData.nodeState = CNFG_ONLINE;
               gp->appPgmMode   = OFF_LINE;
               gp->ioOutputPin1 = FALSE; /* LED off */
               /* No response given as the message is not a request. */
               break;
            case 1:  /* Go on-line */
               OnlineEvent(); /* Indicate to application program. */
               eep->readOnlyData.nodeState = CNFG_ONLINE;
               gp->appPgmMode   = ON_LINE;
               gp->ioOutputPin1 = FALSE; /* LED off */
               /* No response given as the message is not a request. */
               break;
            case 2:  /* Application reset */
               gp->resetNode   = TRUE;
               nmp->resetCause = SOFTWARE_RESET; /* Software reset. */
               /* No response since the node is being reset. */
               break;
            case 3:  /* Change State */
               /* Fail if message is not 3 bytes long. */
               if(appReceiveParamPtr->pduSize != 3)
               {
                  NMNDRespond(NM_MESSAGE, FAILURE,
                              appReceiveParamPtr, apduPtr);
                  break;
               }
               eep->readOnlyData.nodeState = apduPtr->data[1];
               /* Preserve the state of appPgmMode except for
                  NO_APPL_UNCNFG. */
               if (eep->readOnlyData.nodeState == NO_APPL_UNCNFG)
               {
                  gp->appPgmMode = NOT_RUNNING;
               }
               RecomputeChecksum();
               /* Respond with success if the message was a request. */
               NMNDRespond(NM_MESSAGE, SUCCESS,
                           appReceiveParamPtr, apduPtr);
               break;
            default:
               /* Let us reset the node for this case */
               gp->resetNode   = TRUE;
               nmp->resetCause = SOFTWARE_RESET;
               break;
         }
         DeQueue(&gp->appInQ);
         return;
      case NM_READ_MEMORY:
         HandleNMReadMemory(appReceiveParamPtr, apduPtr);
         return;
      case NM_WRITE_MEMORY:
         HandleNMWriteMemory(appReceiveParamPtr, apduPtr);
         return;
      case NM_CHECKSUM_RECALC:
         /* Fail if the message does not have correct size or has bad value. */
         /* *** START INFORMATIVE - Parameter Validation *** */
         /* See "START INFORMATIVE - Parameter Validation" above. */
         if (appReceiveParamPtr->pduSize != 2 ||
              (apduPtr->data[0] != 1 && apduPtr->data[0] != 4))
         {
            NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
            DeQueue(&gp->appInQ);
            return;
         }
         /* *** END INFORMATIVE - Parameter Validation *** */
         /* We don't have checksum for application. Just config checksum */
         RecomputeChecksum();
         NMNDRespond(NM_MESSAGE, SUCCESS, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         return;
      case NM_WINK:   /* Same as NM_INSTALL */
         HandleNMWink(appReceiveParamPtr,apduPtr);
         return;
      case NM_MEMORY_REFRESH:
         /* *** START INFORMATIVE - Memory Refresh *** */
         /* It is acceptable to also respond with a failure to the memory
          * refresh request if the implementation does not include memory
          * which requires refreshing.  An example of responding to memory
          * refresh with non failure responses is not provided here. */
         NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ);
         /* *** END INFORMATIVE - Memory Refresh *** */
         return;
      case NM_QUERY_SNVT:
         HandleNMQuerySIData(appReceiveParamPtr, apduPtr);
         return;
      case NM_NV_FETCH:
         HandleNMNVFetch(appReceiveParamPtr, apduPtr);
         return;
      case NM_MANUAL_SERVICE_REQUEST:
         /* This is unsolicited message from a node. Reference
            implementation ignores manual service request message from other nodes */
         DeQueue(&gp->appInQ);
         return;
      default:
         /* This is where any message that is not taken care of should be
            handled. An example is product query command. For now, we treat
            everything else as unrecognized network management message. */
         NMNDRespond(NM_MESSAGE, FAILURE, appReceiveParamPtr, apduPtr);
         DeQueue(&gp->appInQ); /* Simply discard it */
   }
}

/******************************************************************************/
