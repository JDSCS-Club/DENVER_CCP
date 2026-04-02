/*******************************************************************************
          File:        netmgmt.h

       Version:        1.7

     Reference:        Section 10, Protocol Specification

       Purpose:        App Layer / Network Management

          Note:        For more information, see netmgmt.c.

         To Do:        None

*******************************************************************************/
#ifndef _NETMGMT_H
#define _NETMGMT_H

/*------------------------------------------------------------------------------
Section: Includes
------------------------------------------------------------------------------*/
#include <eia709_1.h>
#include <queue.h>
#include <tsa.h>
#include <network.h>
#include <api.h>

/*------------------------------------------------------------------------------
Section: Constant Definitions
------------------------------------------------------------------------------*/
typedef enum
{
   ND_MESSAGE,
   NM_MESSAGE
} NtwkMgmtMsgType;

/* Message codes */

#define NM_QUERY_ID           0x1
#define NM_RESPOND_TO_QUERY   0x2
#define NM_UPDATE_DOMAIN      0x3
#define NM_LEAVE_DOMAIN       0x4
#define NM_UPDATE_KEY         0x5
#define NM_UPDATE_ADDR        0x6
#define NM_QUERY_ADDR         0x7
#define NM_QUERY_NV_CNFG      0x8
#define NM_UPDATE_GROUP_ADDR  0x9
#define NM_QUERY_DOMAIN       0xA
#define NM_UPDATE_NV_CNFG     0xB
#define NM_SET_NODE_MODE      0xC
#define NM_READ_MEMORY        0xD
#define NM_WRITE_MEMORY       0xE
#define NM_CHECKSUM_RECALC    0xF
#define NM_INSTALL            0x10
#define NM_WINK               0x10 /* Alias for NM_INSTALL */
#define NM_MEMORY_REFRESH     0x11
#define NM_QUERY_SNVT         0x12
#define NM_NV_FETCH           0x13
#define NM_MANUAL_SERVICE_REQUEST 0x1F


/* Define offsets and masks for constructing request and response codes */

#define NM_opcode_base      0x60
#define NM_opcode_mask      0x1F
#define NM_resp_mask        0xE0
#define NM_resp_success     0x20
#define NM_resp_failure     0x00

#define ND_opcode_base      0x50
#define ND_opcode_mask      0x0F
#define ND_resp_mask        0xF0
#define ND_resp_success     0x30
#define ND_resp_failure     0x10

/* Network Diagnostic Message Codes */
#define ND_QUERY_STATUS     0x01
#define ND_PROXY_COMMAND    0x02
#define ND_CLEAR_STATUS     0x03
#define ND_QUERY_XCVR       0x04


/*------------------------------------------------------------------------------
Section: Type Definitions
------------------------------------------------------------------------------*/
#pragma maxalign(1)

typedef enum {
      ABSOLUTE_MEM_ADDR  = 0,
      READ_ONLY_RELATIVE = 1,
      CONFIG_RELATIVE    = 2,
      STAT_RELATIVE      = 3,
} ModeType;

typedef enum
{
   UNCONFIGURED   = 0,
   SELECTED       = 1,
   SELECTED_UNCFG = 2,   /* selected *AND* unconfigured */
} Selector;

typedef enum
{
   NO_ACTION            = 0,
   BOTH_CS_RECALC       = 1,
   CNFG_CS_RECALC       = 4,
   ACTION_RESET         = 8,
} Form;

typedef struct {
   Selector selector;
   ModeType mode;
   uint16   offset;
   Byte     count;
   Byte     data[MAX_DATA_SIZE];
} NMQueryIdRequest;

typedef struct {
   ModeType mode;
   uint16   offset;
   Byte     count;
   Form form;
   Byte     data[MAX_DATA_SIZE];
} NMWriteMemoryRequest;

#pragma maxalign()

/*------------------------------------------------------------------------------
Section: Globals
------------------------------------------------------------------------------*/
/* None */

/*------------------------------------------------------------------------------
Section: Function Prototypes
------------------------------------------------------------------------------*/
void HandleNM(APPReceiveParam *appReceiveParamPtr, APDU *apduPtr);
void HandleND(APPReceiveParam *appReceiveParamPtr, APDU *apduPtr);
void HandleProxyResponse(APPReceiveParam *appReceiveParamPtr, APDU *apduPtr);

#endif
/*-----------------------------End of netmgmt.h-------------------------------*/
