/*********************************************************************
       File:      api.h

    Version:      1.7

  References:     Protocol Spec:
                  Section 10. Application Layer
                  Section 10.6. Application Protocol State
                  Variables

  Purpose:        API: Application Program Interface
                  This is the interface file for the API.

  Note:           The API is described in the Reference Implementation
                  Overview document.

  To Do:          None.
*********************************************************************/
#ifndef _API_H
#define _API_H

/*------------------------------------------------------------------------------
Section: Includes
------------------------------------------------------------------------------*/
#include <eia709_1.h>
#include <custom.h>

/*------------------------------------------------------------------------------
Section: Constant Definitions
------------------------------------------------------------------------------*/
/* None */

/*********************************************************************
Section: Type Definitions
*********************************************************************/
/* These constants are used to transfer data between RefImp structure
   an alternate format typically used by 709.1 applications.
   See RefImpToAlt and AltToRefImp functions */
typedef enum
{
   MSG_IN,
   MSG_OUT,
   RESP_IN,
   RESP_OUT,
   NV_IN_ADDR,
   NV_ARRAY_INDEX
} RefImpAltStruct;

/* SDS pragma to make sure that structures are aligned with byte boundaries */
#pragma maxalign(1)

typedef union
{
   struct
   {
      Bits apFlag : 2;
      Bits apCode : 6;
   } ap;
   struct
   {
      Bits nvFlag : 1;
      Bits nvDir  : 1;
      Bits nvCode : 6;
   } nv;
   struct
   {
      Bits nmFlag : 3;
      Bits nmCode : 5;
   } nm;
   struct
   {
      Bits ndFlag : 4;
      Bits ndCode : 4;
   } nd;
   struct
   {
      Bits ffFlag : 4;
      Bits ffCode : 4;
   } ff;
   uint8 allBits;
} DestinType;

/* Addresses used by API message structures */
typedef struct
{
   Bits      groupFlag       : 1;  /* 1 => group                  */
   Bits      groupSize       : 7;  /* group size (0 => huge group)*/
   Bits      domainIndex     : 1;  /* domain index                */
   Bits      member          : 7;  /* member num                  */
   Bits      rptTimer        : 4;  /* unackd_rpt timer            */
   Bits      retryCount      : 4;  /* retry count                 */
   Bits      rcvTimer        : 4;  /* receive timer index         */
   Bits      txTimer         : 4;  /* transmit timer index        */
   Bits      groupID         : 8;  /* group ID                    */
} GroupAddrMode;

typedef struct
{
   Bits      type            : 1;  /* 1 => group                  */
   Bits      size            : 7;  /* group size (0 => huge group)*/
   Bits      domain          : 1;  /* domain index                */
   Bits      member          : 7;  /* member num                  */
   Bits      rpt_timer       : 4;  /* unackd_rpt timer            */
   Bits      retry           : 4;  /* retry count                 */
   Bits      rcv_timer       : 4;  /* receive timer index         */
   Bits      tx_timer        : 4;  /* transmit timer index        */
   Bits      group           : 8;  /* group ID                    */
} group_struct;

typedef struct
{
   AddrMode  addrMode;             /* SUBNET_NODE             */
   Bits      domainIndex     : 1;  /* domain index            */
   Bits      node            : 7;  /* node number             */
   Bits      rptTimer        : 4;  /* unackd_rpt timer        */
   Bits      retryCount      : 4;  /* retry count             */
   Bits      reserved1       : 4;  /* UNUSED                  */
   Bits      txTimer         : 4;  /* transmit timer index    */
   Bits      subnetID        : 8;  /* subnet ID               */
} SNodeAddrMode;


typedef struct
{
   AddrMode  type;                 /* SUBNET_NODE             */
   Bits      domain          : 1;  /* domain index            */
   Bits      node            : 7;  /* node number             */
   Bits      rpt_timer       : 4;  /* unackd_rpt timer        */
   Bits      retry           : 4;  /* retry count             */
   Bits      reserved1       : 4;  /* UNUSED                  */
   Bits      tx_timer        : 4;  /* transmit timer index    */
   Bits      subnet          : 8;  /* subnet ID               */
} snode_struct;


typedef struct
{
   AddrMode  addrMode;             /* BROADCAST                   */
   Bits      domainIndex     : 1;  /* domain index                */
   Bits      reserved1       : 1;  /* UNUSED                      */
   Bits      backlog         : 6;  /* backlog override value      */
   Bits      rptTimer        : 4;  /* unackd_rpt timer            */
   Bits      retryCount      : 4;  /* retry count                 */
   Bits      maxResponses    : 4;  /* Max Resp to deliver to app  */
   Bits      txTimer         : 4;  /* transmit timer index        */
   Bits      subnetID        : 8;  /* subnet ID (0 = domain bcast */
} BcastAddrMode;


typedef struct
{
   AddrMode  type;                 /* BROADCAST                   */
   Bits      domain          : 1;  /* domain index                */
   Bits                      : 1;  /* UNUSED                      */
   Bits      backlog         : 6;  /* backlog override value      */
   Bits      rpt_timer       : 4;  /* unackd_rpt timer            */
   Bits      retry           : 4;  /* retry count                 */
   Bits      max_responses   : 4;  /* Max Resp to deliver to app  */
   Bits      tx_timer        : 4;  /* transmit timer index        */
   Bits      subnet          : 8;  /* subnet ID (0 = domain bcast */
} bcast_struct;


typedef struct
{
   AddrMode  addrMode;             /* UNIQUE_NODE_ID              */
   Bits      domainIndex     : 1;  /* domain index                */
   Bits      reserved1       : 7;  /* UNUSED                      */
   Bits      rptTimer        : 4;  /* unackd_rpt timer            */
   Bits      retryCount      : 4;  /* retry count                 */
   Bits      reserved2       : 4;  /* UNUSED                      */
   Bits      txTimer         : 4;  /* transmit timer index        */
   Bits      subnetID        : 8;  /* subnet ID                   */
   uint8     uniqueId[UNIQUE_NODE_ID_LEN]; /* unique node ID      */
} UniqueNodeIdAddrMode;


typedef struct
{
   AddrMode  type;                 /* UNIQUE_NODE_ID              */
   Bits      domain          : 1;  /* domain index                */
   Bits      reserved1       : 7;  /* UNUSED                      */
   Bits      rpt_timer       : 4;  /* unackd_rpt timer            */
   Bits      retry           : 4;  /* retry count                 */
   Bits      reserved2       : 4;  /* UNUSED                      */
   Bits      tx_timer        : 4;  /* transmit timer index        */
   Bits      subnet          : 8;  /* subnet ID                   */
   uint8     uniqueId[UNIQUE_NODE_ID_LEN]; /* unique node ID      */
} uniqueNodeId_struct;

typedef union
{
   AddrMode          noAddress;  /* UNBOUND: 0 if no address    */
   GroupAddrMode     group;
   SNodeAddrMode     snode;
   UniqueNodeIdAddrMode uniqueNodeId;
   BcastAddrMode     bcast;
} MsgOutAddr;

typedef union
{
   AddrMode          no_address;  /* UNBOUND: 0 if no address    */
   group_struct      group;
   snode_struct      snode;
   uniqueNodeId_struct uniqueNodeId;
   bcast_struct      bcast;
} msg_out_addr;

/* Typedef for 'resp_in_addr', type of the field 'resp_in.addr'  */
typedef struct
{
   Bits     domain      : 1;
   Bits     flexDomain  : 1;
   struct
   {
      uint8    subnet;
      Bits     snodeFlag : 1;  /* 0=> group resp; 1=> snode resp */
      Bits     node      : 7;
   } srcAddr;
   union
   {
      struct
      {
         uint8    subnet;
         Bits              : 1;  /* UNUSED */
         Bits     node     : 7;
      } snode;
      struct
      {
         uint8    subnet;
         Bits              : 1;  /* UNUSED */
         Bits     node     : 7;
         uint8    group;
         Bits              : 2;  /* UNUSED */
         Bits     member   : 6;
      } group;
   } destAddr;
} RespInAddr;

typedef struct
{
   Bits     domain       : 1;
   Bits     flex_domain  : 1;
   struct
   {
      uint8    subnet;
      Bits     is_snode  : 1;  /* 0=> group resp; 1=> snode resp */
      Bits     node      : 7;
   } src_addr;
   union
   {
      struct
      {
         uint8    subnet;
         Bits              : 1;  /* UNUSED */
         Bits     node     : 7;
      } snode;
      struct
      {
         uint8    subnet;
         Bits              : 1;  /* UNUSED */
         Bits     node     : 7;
         uint8    group;
         Bits              : 2;  /* UNUSED */
         Bits     member   : 6;
      } group;
   } dest_addr;
} resp_in_addr;

typedef struct
{
   Bits     domain       : 1;
   Bits     flexDomain  : 1;
   Bits     format       : 6; /* 0 => Broadcast 1 => group
                                 2 => subnet/node 3 => Unique Node Id */
   struct
   {
      uint8    subnet;
      Bits               : 1;
      Bits     node      : 7;
   } srcAddr;
   union
   {
      uint8  bcastSubnet;  /* bcast dest address */
      uint8  group;        /* group destination */
      struct
      {
         uint8    subnet;
         Bits              : 1;  /* UNUSED */
         Bits     node     : 7;
      } snode;
      struct
      {
         uint8 subnet;
         Byte  uniqueId[UNIQUE_NODE_ID_LEN];
      } uniqueNodeId;
   } destAddr;
} MsgInAddr;

typedef struct
{
   Bits     domain       : 1;
   Bits     flex_domain  : 1;
   Bits     format       : 6; /* 0 => Broadcast 1 => group
                                 2 => subnet/node 3 => Unique Node Id */
   struct
   {
      uint8    subnet;
      Bits               : 1;
      Bits     node      : 7;
   } src_addr;
   union
   {
      uint8  bcast_subnet;  /* bcast dest address */
      uint8  group;        /* group destination */
      struct
      {
         uint8    subnet;
         Bits              : 1;  /* UNUSED */
         Bits     node     : 7;
      } snode;
      struct
      {
         uint8 subnet;
         Byte  uniqueId[UNIQUE_NODE_ID_LEN];
      } uniqueNodeId;
   } dest_addr;
} msg_in_addr;

typedef struct
{
   Bits     domain       : 1;
   Bits     flexDomain   : 1;
   Bits     format       : 6; /* 0 => Broadcast 1 => group
                                 2 => subnet/node 3 => Unique Node Id
                                 4 => turnaround */
   struct
   {
      uint8    subnet;
      Bits               : 1;
      Bits     node      : 7;
   } srcAddr;
   struct
   {
      uint8  group;
   } destAddr;
} NvInAddr;

typedef struct
{
   Bits     domain       : 1;
   Bits     flex_domain  : 1;
   Bits     format       : 6; /* 0 => Broadcast 1 => group
                                 2 => subnet/node 3 => Unique Node Id
                                 4 => turnaround */
   struct
   {
      uint8    subnet;
      Bits               : 1;
      Bits     node      : 7;
   } src_addr;
   struct
   {
      uint8  group;
   } dest_addr;
} nv_in_addr_type;

/* Message Declarations ****************************************** */

typedef struct
{
   uint8         code; /* message code                      */
   uint8         len;  /* length of message data            */
   uint8         data[MAX_DATA_SIZE];  /* message data      */
   Boolean       authenticated; /* TRUE if msg was authenticated */
   ServiceType   service;       /* Service used to send the msg  */
   RequestId     reqId;         /* Request ID to match responses   */
   MsgInAddr     addr;
} MsgIn;

typedef struct
{
   uint8         code; /* message code                      */
   uint8         len;  /* length of message data            */
   uint8         data[MAX_DATA_SIZE];  /* message data      */
   Boolean       authenticated; /* TRUE if msg was authenticated */
   ServiceType   service;       /* Service used to send the msg  */
   RequestId     req_id;        /* Request ID to match responses   */
   msg_in_addr   addr;
} msg_in_type;

typedef struct
{
   Boolean     priorityOn;    /* TRUE if a priority message     */
   MsgTag      tag;           /* to correlate completion codes  */
   uint8       len;           /* message length in data array below */
   uint8       code;          /* message code                   */
   uint8       data[MAX_DATA_SIZE];  /* message data            */
   Boolean     authenticated; /* TRUE if to be authenticated    */
   ServiceType service;       /* service type used to send msg  */
   MsgOutAddr  addr;          /* destination address (see above)*/
} MsgOut;

typedef struct
{
   Boolean      priority_on;   /* TRUE if a priority message     */
   MsgTag       tag;           /* to correlate completion codes  */
   uint8        len;           /* message length in data array below */
   uint8        code;          /* message code                   */
   uint8        data[MAX_DATA_SIZE];  /* message data            */
   Boolean      authenticated; /* TRUE if to be authenticated    */
   ServiceType  service;       /* service type used to send msg  */
   msg_out_addr addr;          /* destination address (see above)*/
} msg_out_type;

typedef struct
{
   MsgTag      tag;                   /* To match req    */
   uint8       code;                  /* message code    */
   uint8       len;                   /* message length  */
   uint8       data[MAX_DATA_SIZE];   /* message data    */
   RespInAddr  addr;  /* destination address (see above) */
} RespIn;             /* struct for receiving responses  */

typedef struct
{
   MsgTag        tag;                   /* To match req    */
   uint8         code;                  /* message code    */
   uint8         len;                   /* message length  */
   uint8         data[MAX_DATA_SIZE];   /* message data    */
   resp_in_addr  addr;  /* destination address (see above) */
} resp_in_type;             /* struct for receiving responses  */


typedef struct
{
   RequestId  reqId;         /* Request ID to match responses */
   Boolean    nullResponse;  /* TRUE => no resp goes out */
   uint8      code;          /* message code */
   uint8      len;           /* message length  */
   uint8      data[MAX_DATA_SIZE];   /* message data */
} RespOut;                   /* structure for sending responses */

typedef struct
{
   RequestId  req_id;         /* Request ID to match responses */
   Boolean    null_response;  /* TRUE => no resp goes out */
   uint8      code;           /* message code */
   uint8      len;            /* message length  */
   uint8      data[MAX_DATA_SIZE];   /* message data */
} resp_out_type;                     /* structure for sending responses */


/*******************************************************************
NVDefinition is used to describe network variable properties.
These are used to create a new network variable with proper
attributes in network variable tables and SNVT structures.
*******************************************************************/
typedef struct
{
    Bits  priority     : 1; /* TRUE or FALSE */
    Bits  direction    : 1; /* NV_INPUT or NV_OUTPUT */
    Bits  selectorHi   : 6; /* Present only for non-bindable */

    Bits  selectorLo   : 8; /* Present only for non-bindable */

    Bits  bind         : 1; /* 1 => bindable 0 ==> nobindable */
    Bits  turnaround   : 1; /* TRUE or FALSE */
    Bits  service      : 2; /* ACKD, UNACKD_RPT, UNACKD */
    Bits  auth         : 1; /* TRUE or FALSE */
    Bits               : 3; /* Unused */

    Bits explodeArray : 1;   /* Explode arrays in SNVT structure */
    Bits  nvLength    : 7;   /* Length of network variable in bytes.
                                For arrays, give the size of each item. */

    uint8  snvtDesc;         /* snvtDesc_struct in byte form. Big_Endian */
    uint8  snvtExt;          /* Extension record. Big_Endian. */
    uint8  snvtType;         /* 0 => non-SNVT variable. */
    uint8  rateEst;
    uint8  maxrEst;
    uint16 arrayCnt;         /* 0 for simple variables. dim for arrays. */
    char  *nvName;           /* Name of the network variable */
    char  *nvSdoc;           /* Sel-doc string for the variable */
    void  *varAddr;          /* Address of the variable. */
} NVDefinition;

#pragma maxalign()

/* API Functions ***************************************************/
Boolean  MsgAlloc(void);          /* Returns TRUE if msg allocated */
Boolean  msg_alloc(void);
Boolean  MsgAllocPriority(void);  /* Returns TRUE if msg allocated */
Boolean  msg_alloc_priority(void);
void     MsgSend(void);           /* Reads msgOut, sends message   */
void     msg_send(void);
void     MsgCancel(void);         /* Cancels MsgAlloc() or         */
                                  /*   msgAllocPriority()          */
void     msg_cancel(void);
void     MsgFree(void);           /* Releases data in msgIn        */
void     msg_free(void);
Boolean  msgReceive(void);        /* TRUE if there is msg          */
Boolean  msg_receive(void);

Boolean  RespAlloc(void);         /* Returns TRUE if resp allocated*/
Boolean  resp_alloc(void);
void     RespSend(void);          /* Reads respOut, sends response */
void     resp_send(void);
void     RespCancel(void);        /* Cancels RespAlloc()           */
void     resp_cancel(void);
void     RespFree(void);          /* Releases data in respIn       */
void     resp_free(void);
Boolean  RespReceive(void);
Boolean  resp_receive(void);

/* Functions to transfer data between Ref Imp structure and
   corresponding an alternate format. */
void RefImpToAlt(RefImpAltStruct whatIn, void *destAddr);
void AltToRefImp(RefImpAltStruct whatIn, void *srcAddr);

/********************************************************************
   Add a network variable with the given info.  Returns the index of
   the network variable that should be used with other functios such
   as SendNV, GetNVAddr.  For array variables, only one index value is
   returned, however each element is considered like a separate
   network variable
*********************************************************************/
int16    AddNV(NVDefinition *);

/* To send all network output variables in the node.
   Polled or not, Use Propagate function. */
void Propagate(void);

/* To send one simple network variable or a whole array */
void PropagateNV(int16 nvIndex);

/* To send an array element or any other simple variable.*/
void PropagateArrayNV(int16 arrayNVIndex, int16 index);

/* To poll all input network variables */
void  Poll(void);

/* To poll a specific simple input network variable or an array */
void  PollNV(int16 nvIndex);

/* Poll a specific array element or any other simple variable. */
void PollArrayNV(int16 arrayNVIndex, int16 index);

/* Application can call this fn to put itself offline */
void GoOffline(void);

/* Appplication can call this fn to put itself unconfigured */
void GoUnconfigured(void);

/* To get a new message tag. NewMsgTag(BIND) or NewMsgTag(NOBIND) */
MsgTag NewMsgTag(BindNoBind bindStatusIn);

/* To send a manual service request message  */
Boolean ManualServiceRequestMessage(void);

/* Functions that must be defined in the application program.       */
Status AppInit(void);             /* Application initialization      */
void  AppReset(void);            /* Code after a reset              */
void  DoApp(void);               /* Application processing          */
/* MsgCompletes is called when an explicit message has completed. */
void  MsgCompletes(Status stat, MsgTag tag);
/* NVUpdateCompletes is called when an nv update or nv poll completes. The 2nd
   parameter is the array index for array variables, 0 for simple variables. */
void  NVUpdateCompletes(Status stat, int16 nvIndex, int16 nvArrayIndex);
/* NVUpdateOccurs is called when an input nv has been changed. The 2nd
   parameter is the array index for array variables, 0 for simple variables. */
void  NVUpdateOccurs(int16 nvIndex, int16 nvArrayIndex);
void  Wink(void);                /* Call to app wink clause         */
void  OfflineEvent(void);        /* Going Application Offline       */
void  OnlineEvent(void);         /* Going Application Online        */
/* End of Functions that must be defined in the application program.*/


#endif   /* #ifndef _API_H */
/********************************api.h*******************************/
