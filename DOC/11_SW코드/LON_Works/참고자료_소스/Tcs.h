/*********************************************************************
          File:        tcs.h

       Version:        1.7

       Purpose:        Interface for Transaction Control Sublayer.
                       Outgoing Sequencing
                       Incoming Sequencing and Duplicate Detection.

          Note:        For assigning TIds, a table is used. We
                       remember the last TID for each unique dest
                       addr. When a new TId is requested for a
                       destination, this table is searched for that
                       destination. If found, we make sure that we
                       don't assign the same TId used for that
                       destination. If the destination is not 
                       found, we make a new entry in the table.

                       We have an entry in the table for each
                       subnet/node, group, broadcast, subnet
                       broadcast, unique node id. When a table entry
                       is assigned, we remember the time stamp too.
                       If the table does not have space for a new
                       dest addr, we get rid of one which has
                       remained more than 24 sec. If no such entry,
                       then we fail to allocate the new trans ID.
                       The table size is configurable.

         To Do:        None

*********************************************************************/
#ifndef _TCS_H
#define _TCS_H

/*------------------------------------------------------------------------------ 
Section: Includes
------------------------------------------------------------------------------*/ 
#include <eia709_1.h>
#include <node.h>   

/*-------------------------------------------------------------------
Section: Constant Definitions 
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Type Definitions 
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Globals 
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Function Prototypes
-------------------------------------------------------------------*/
void TCSReset(void);

void   TransDone(Boolean  priorityIn);

/* Return Values:      SUCCESS or FAILURE  */
Status NewTrans(Boolean   priorityIn, DestinationAddress addrIn,
                TransNum *transNumOut); 

/* Return Values: TRAN_CURRENT or TRAN_NOT_CURRENT */
TransStatus ValidateTrans(Boolean  priorityIn, TransNum transNumIn);

#endif
/*------------------------End of tcs.h------------------------*/
