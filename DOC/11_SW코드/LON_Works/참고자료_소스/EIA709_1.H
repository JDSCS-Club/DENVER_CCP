/*********************************************************************
  File:           eia709_1.h

  Version:        1.7

  Purpose:        To define constants and types that are needed
                  by all files. Most .c files will include
                  eia709_1.h either directly or indirectly.

  Note:           Reference implementation does not support 
                  special purpose nodes such as routers, repeaters
                  etc. Additional code is required to implement
                  these nodes.
                  
  To Do:          None.
*********************************************************************/
#ifndef _EIA709_1_H
#define _EIA709_1_H

/*------------------------------------------------------------------------------ 
Section: Includes
------------------------------------------------------------------------------*/ 
/* None */

/*------------------------------------------------------------------------------
Section: Macro Definitions
------------------------------------------------------------------------------*/
#define MIN(x,y) (((x)<(y))?(x):(y))
#define MAX(x,y) (((x)>(y))?(x):(y))
#define INCR_STATS(x) ((x < (uint16)0xFFFF)?x++:x)

/*------------------------------------------------------------------------------
Section: Constant Definitions
------------------------------------------------------------------------------*/
/* Reference implementation supports the use of alternate structures such
   as msg_in, msg_out etc for ease of porting application 
   programs. However, the disadvantage is the extra copy needed to
   use these structures. Uncomment this constant if you do not want
   to use the alternate structures (i.e you prefer to use reference implementation
   structures that use a different naming convention.) */
#define ALTERNATE_STRUCTURES_NEEDED

#define UNIQUE_NODE_ID_LEN 6 /* Length of the Unique Node Id.         */
#define ID_STR_LEN       8   /* Length of the program id string.      */
#define AUTH_KEY_LEN     6   /* Length of the authentication key.     */
#define DOMAIN_ID_LEN    6   /* Maximum length for a domain id.       */
#define LOCATION_LEN     6   /* Maximum length for location string.   */
#define NUM_COMM_PARAMS  7   /* Max # of parameters for a tranceiver. */
#define PROTOCOL_VERSION 0   /* 0 for reference implementaion.        */
#define MAX_DOMAINS      2   /* Maximum # of domains allowed.         */

/* Set the size of the array to log error messages from the protocol stack. 
   The error messages wrap around, if there are too many errors.
   Errors seldom happen. So, there is no need for this to be too large. */
#define ERROR_MSG_SIZE  1000  /* 20 messages each with 50 chars */

#define FLEX_DOMAIN          2   /* Indicates that the message was received
                                    in flex domain when domain index is 2 */
#define COMPUTE_DOMAIN_INDEX 3   /* When application layer communicates
                                    with transport or session layer,
                                    the domainIndex for the outgoing message
                                    can be either set by the application layer
                                    or computed by transport or session layer
                                    based on the destination address. 
                                    This value is used only in TSASenParam 
                                    structure. */
#define MAX_GROUP_NUMBER 63    /* Maximum number of a node in a group */                                                                        

/*------------------------------------------------------------------------------
Section: Type Definitions
------------------------------------------------------------------------------*/
/* The following type definitions need to be changed based on the
   compiler used. The rest of the files should use only int8,
   int16, uint8 etc. Application programs should use
   nint (8-bit int), nlong etc as much as possible. */
typedef char                int8;
typedef short int           int16;
typedef long int            int32;
typedef unsigned char       uint8;
typedef unsigned short int  uint16;
typedef unsigned long int   uint32;

/* Typical 709.1 definitions for int long etc. */
typedef int8                nshort;
typedef int8                nint; 
typedef uint8               nuint;
typedef uint8               nushort;
typedef int16               nlong;
typedef uint16              nulong;

typedef unsigned char Byte;
typedef unsigned char Bits;
typedef int16         MsgTag; /* Lots of Tags!!! */

/* This type definition may need #ifndef macro wrapped 
   around when porting to other platforms. */
typedef enum 
{
   FALSE = 0,
   TRUE  = 1
} Boolean;

typedef Boolean boolean; /* For nc compatibility. */

typedef enum
{
   NOBIND = 0,
   NON_BINDABLE = 0,   /* Same as NOBIND. */
   BIND   = 1,
   BINDABLE = 1       /* Same as BIND.   */
} BindNoBind;

typedef enum
{
   NV_INPUT  = 0,
   NV_OUTPUT = 1
} NVDirection;

/* Address Types. */
typedef enum 
{ 
   UNBOUND          = 0,

   SUBNET_NODE      = 1,

   UNIQUE_NODE_ID   = 2,

   BROADCAST        = 3,

   MULTICAST        = 4,

   MULTICAST_ACK    = 5,

   BROADCAST_GROUP  = 0x23 /* Used for broadcast req/resp requiring
                              up to N responses to be delivered. */
} AddrMode;

/* Reference: page 9-49 of Tech Device Data Book. Revision 2.
   In reference implementation, the application is always loaded 
   when downloading the code into the system. There is no provision 
   to download application program from management tools. However, 
   application can be placed in offline by calling GoOffline fn.  
   Thus the node state NO_APPL_UNCNFG is not possible.
   gp->appPgmMode indicates the state of the application program. */
typedef enum
{
   /* For nodeState */
   APPL_UNCNFG     = 2, /* Application is loaded but conf is not */
   NO_APPL_UNCNFG  = 3, /* Application is not loaded yet or bad  */
   CNFG_ONLINE     = 4, /* Normal operation mode                 */
   CNFG_OFFLINE    = 6, /* same as hard offline state            */
   HARD_OFFLINE    = 6,
   
   SOFT_OFFLINE    = 0xC,   /* For reporting purpose             */
   CNFG_BYPASS     = 0x8C   /* Not supported in reference imp.   */
} NodeState;   

/* These constants are used to represent the mode when the node is
   configured. */
typedef enum
{
   OFF_LINE    = 0,  /* For soft off-line */
   ON_LINE     = 1,  /* For normal mode   */
   NOT_RUNNING = 2   /* For hard-offline. Not used in reference impl. 
                        unless commanded to enter this state. */
} ConfigMode;

/* The order of the first 4 items is important as it is used by
   network layer to determine the type of PDU. */
typedef enum 
{
   /* Do not change the order. The values are sent across the network */
   TPDU_TYPE,
   SPDU_TYPE,
   AUTHPDU_TYPE,
   APDU_TYPE,

   /* Something extra for internal use of the protocol stack */
   NPDU_TYPE,
   LPDU_TYPE,
} PDUType;

/* Services offered to application program. These are not sent over 
   the network */
typedef enum
{
   ACKD,       /* Transport Layer */
   UNACK_RPT,  /* Transport Layer */
   UNACKD,     /* Network   Layer */
   REQUEST,    /* Session   Layer */

   RESPONSE    /* Session   Layer. Used by resp_send function */
} ServiceType; 

/* Tranceiver types. Only the constants are used */
typedef enum
{
   BLANK            = 0,
   SINGLE_ENDED     = 1,
   SPECIAL_PURPOSE  = 2,
   DIFFERENTIAL     = 5
} TranceiverType;

/* Return status for all functions. */
typedef enum 
{
   SUCCESS               = 0,
   FAILURE               = 1,
   INVALID               = 2
} Status;

/* Reset cause */
typedef enum
{
   POWER_UP_RESET       = 0x01,
   EXTERNAL_RESET       = 0x02,
   WATCHDOG_RESET       = 0x0C,
   SOFTWARE_RESET       = 0x14,
   CLEARED              = 0x00
} ResetCause;
       
/* Turn alignment on so that structures packed tightly */
#pragma maxalign(1)

/* Software Timer definition. */
typedef struct
{
   uint32 curTimerValue;    /* Number of clock ticks left in timer.      */
   uint32 lastUpdatedTime;  /* The time when the timer was last updated. */
   Boolean expired;         /* TRUE => it has already expired.           */
} MsTimer;


typedef uint8  TransNum;    /* For transaction numbers. */
typedef uint16 RequestId;   /* For matching responses with requests. */

typedef Byte BroadcastAddress;
typedef Byte MulticastAddress;

typedef struct 
{
   Byte  subnet;
   Bits  selField   :1;  /* Used by nekwork layer for 2b. */
   Bits  node       :7;
} SubnetAddress;

typedef struct
{
   MulticastAddress group;
   Byte member;
} GroupAddress;

typedef struct
{
   SubnetAddress subnetAddr;
   GroupAddress  groupAddr;   /* Acknowledging group member. */
} MulticastAckAddress;

typedef struct
{
   Byte   subnet;  /* For routing purpose. */
   Byte   uniqueId[UNIQUE_NODE_ID_LEN];
} UniqueNodeIdAddress;


/*******************************************************************************
   DestinationAddress is used to indicate network layer which address
   mode is used to send the message. The destination address
   is always one of the five possibilities.
   domainIndex indicates the domain table to use to determine
   domain length and domain id. 
   If domainIndex = FLEX_DOMAIN, then it is flexdomain. 
   In this case, src subnet/node is 0/0.
*******************************************************************************/
typedef struct
{
   Byte  domainIndex;   
   uint8 flexDomainLen; /* Use if domainIndex == FLEX_DOMAIN */
   Byte  flexDomainId[DOMAIN_ID_LEN]; /* Use if domainIndex == FLEX_DOMAIN */
   AddrMode addressMode;
   union {
      BroadcastAddress       addr0;
      MulticastAddress       addr1;
      SubnetAddress          addr2a;
      MulticastAckAddress    addr2b;
      UniqueNodeIdAddress    addr3;
   } addr;
} DestinationAddress;

/*******************************************************************************
   SourceAddress is used by network layer to indicate to upper levels
   who sent the message and what mode was used. 
   Thus this structure is used only for receiving messages.
   domainIndex is used to respond back in the domain in which
   the message was received. 
*******************************************************************************/
typedef struct
{
   SubnetAddress        subnetAddr;   /* Subnet of source node. */
   AddrMode             addressMode;  /* What mode used. */
   Byte                 domainIndex;  /* 0 or 1 or FLEX_DOMAIN (i.e 2) */
   uint8                flexDomainLen;/* Used if domainIndex == FLEX_DOMAIN. */
   Byte  flexDomainId[DOMAIN_ID_LEN]; /* Used if domainIndex == FLEX_DOMAIN. */
   /* group is used only if addressMode is MULTICAST.
      It is the group of the source node sending this message. */
   MulticastAddress     group;           
   /* ackNode is used only if addressMode is MULTICAST_ACK.
      It is the destSubnet used and the group of the node sending the ack
      or response. */
   MulticastAckAddress  ackNode;      
   /* Destination subnet for broadcast messages. */
   Byte broadcastSubnet;
} SourceAddress;

#pragma maxalign()

#endif   /* #ifndef _EIA709_1 */
/**********************************eia709_1.h***********************************/
