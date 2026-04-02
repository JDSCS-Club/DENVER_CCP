/////////////////////////////////////////////////////////////////
//
//          INITIATO.NC - initiator node for Neuron file transfer
//
//          Last Modified: 12/18/96 (see Modification History below)
//
//          This initiator implementation assumes that the
//          initiator's file transfer NVs are bound to the sender
//          and the receivers.  For multicast, it is assumed that
//          only the receivers are bound to the initiator (i.e.,
//          no other initiators are bound in nor is there any group
//          overloading where group overloading is a method used by
//          binders to have multiple connections share a group and
//          rely on selector uniqueness to avoid ambiguity.  Note that
//          the NSS for Windows binder does not use group overloading
//          for file transfer NV connections).
//
//          This initiator implementation assumes that the parameters
//          for all receivers (in the multicast case) are the same,
//          specifically, the file index and receive timeout.
//
//          This initiator does not support random access.
//
// Modification History:
// 12/19/96:Changed the initiator to allow either the sender or
//          the receiver to be the same node as the initiator (the
//          sender and receivers must always be in separate nodes since
//          file transfer uses explicit messages and there is no support
//          for turnaround explicit messages).  Note that not all turnaround
//          cases work using the simple scheme employed by this example.
//          In particular, this example uses the binding of the initiator
//          to the receivers to determine the destination address to be
//          used by the sender.  If there is one receiver and it is the
//          same node as the initiator, then the destination is simply
//          this node.  If there are multiple receivers in a group plus
//          a local receiver, then the destination is the group plus the
//          group size is bumped to included this node.  However, if there
//          are two receivers, one being local and one another node, then
//          the NV bind will use a subnet/node address whereas the sender
//          would need a group address.  Therefore, this case does not
//          work in this example.  To get this to work, a group must be
//          formed which includes both receivers and then that group would
//          need to be specified as the destination.
//
// 5/28/96: This initiator includes a key change from earlier versions
//          of this reference.  In particular, the initiator closes
//          the file of the sender in addition to the receiver.  The
//          new sender reference implementation does not unilaterally
//          close the file.  It relies on the initiator to close the
//          file (however, there is a 60 second timeout).  This change
//          means that senders based on the new reference will not work
//          with initiators based on the old reference if a transfer
//          is requested sooner than one minute following the last
//          transfer.
//
//          This implementation also fixes some problems associated
//          with multiple initiators trying to get simultaneous access
//          to files.  The old implementation had this initiator closing
//          the file even though it didn't gain access to it.  The sender/
//          receiver reference honors any close since it assumes only
//          the successful initiator will do a close.
//
/////////////////////////////////////////////////////////////////

#include <addrdefs.h>
#include <access.h>
#include <control.h>

#include "file.h"
#include <mem.h>

////////////////////////////////////////////////////////////////
//
//      Communications with sender and receiver
//
////////////////////////////////////////////////////////////////

network output sync SNVT_file_req        sender_request;
network output sync SNVT_file_req        receiver_request;
network input  sync SNVT_file_status     sender_status;
network input  sync SNVT_file_status     receiver_status;

////////////////////////////////////////////////////////////////
//
//  State machine for initiator
//
////////////////////////////////////////////////////////////////

enum {
    idle,
    wait_for_receiver,
    wait_for_sender,
    xfer_underway,
    lookup_underway,
    receiver_done,
    sender_done,
    receiver_busy,
    sender_busy,
    receiver_open_fail,
    sender_open_fail,
    receiver_xfer_fail,
    sender_xfer_fail,
} status;

////////////////////////////////////////////////////////////////
//
// Parameters of the file transfer
//
////////////////////////////////////////////////////////////////

network input file_index sender_index;      // file index on sending node
network input file_request function = FR_OPEN_TO_SEND;
                                            // browse this NV to start

file_index receiver_index;                  // file index on receiving nodes
boolean    auth_on;                         // authentication
boolean    prio_on;                         // priority
unsigned long receiver_timeout = 1000;      // milliseconds
unsigned long sender_timeout = 100;         // milliseconds
unsigned retry_count = 3;                   // for the request messages

////////////////////////////////////////////////////////////////
//
// Local variables
//
////////////////////////////////////////////////////////////////

const unsigned long timeout_table[ 16 ] = {
    16,   24,   32,   48,
    64,   96,  128,  192,
   256,  384,  512,  768,
  1024, 1536, 2048, 3072 };     // for computing tx_timer values

address_struct  dest_addr;              // address of receivers
unsigned   num_receivers;               // number of receivers
unsigned   num_responses;               // number of responses from rcvrs

SNVT_file_status    local_sender_status;
SNVT_file_status    local_receiver_status;

file_descriptor local_descriptor;           // result of directory lookup

////////////////////////////////////////////////////////////////
//
//      Top level functions
//
////////////////////////////////////////////////////////////////

void start_xfer( void ) {

    unsigned tx_timer;

    // This initiator assumes that the SNVT_file_req NV is bound to all the
    // receivers and nothing more (i.e., no other initiators nor is the
    // group overloaded (used by other connections) - see file header).
    dest_addr = * access_address( access_nv( nv_table_index(
        receiver_request ) )->nv_addr_index );
    // get address table entry for the receivers

    dest_addr.gp.retry = retry_count;       // copy parameters
        // find the tx_timer value for the address

    for( tx_timer = 0; tx_timer < 16; tx_timer++ )
        if( timeout_table[ tx_timer ] >= sender_timeout ) break;
    dest_addr.gp.tx_timer = tx_timer;

   if (access_nv(nv_table_index(receiver_request))->nv_turnaround) {
        if ( dest_addr.gp.type ) {
            // Since the initiator node is in the group and is also
            // going to act as a receiver in the group, bump the group
            // size to include it.
            dest_addr.gp.size++;
        } else if ( dest_addr.sn.type == SUBNET_NODE ) {
            // This can't work.  See explanation in modification history.
            status = idle;
            error_log( 1 );
            return;
        }
    }

    // if a group, get number of receivers
    if( dest_addr.gp.type )
        num_receivers = dest_addr.gp.size-1;
    else
        num_receivers = 1;         // one receiver

    // Check for initiator bound only to local receiver.  Hardcode use
    // of first domain - the second domain could be used if you choose.
    if (dest_addr.ta.type == UNBOUND &&
        dest_addr.ta.turnaround) {
        // Turnaround connection.  Destination address needs to
        // be my address.
        dest_addr.sn.type = SUBNET_NODE;
        dest_addr.sn.subnet = access_domain(0)->subnet;
        dest_addr.sn.node = access_domain(0)->node;
    }

    // Validate that sender is idle.
    if (sender_status.status == FS_XFER_OK) {
        receiver_request.request = FR_OPEN_TO_RECEIVE;
        receiver_request.index = receiver_index;
        receiver_request.auth_on = auth_on;
        receiver_request.receive_timeout = receiver_timeout;
        status = wait_for_receiver;
    } else {
        status = sender_busy;
    }
    num_responses = 0;      // start counting
}

void sender_directory_lookup( void ) {

    sender_request.request = FR_DIRECTORY_LOOKUP;
    sender_request.index = sender_index;
    status = lookup_underway;
}

boolean compare_address( SNVT_file_status * );

////////////////////////////////////////////////////////////////
//
//      Tasks
//
////////////////////////////////////////////////////////////////

when( nv_update_occurs( receiver_status ) ) {

    switch( status ) {
    case wait_for_receiver:

        local_receiver_status = receiver_status;
        if( ! compare_address( &local_receiver_status ) ) {
            status = receiver_busy;     // response not for me
            return;
        }

        if( receiver_status.status != FS_XFER_UNDERWAY ) {
            status = receiver_open_fail;
            receiver_request.request = FR_CLOSE_FILE;  // back out
            return;
        }
        if( ++num_responses < num_receivers ) return;    // wait some more

        if( sender_status.status == FS_XFER_UNDERWAY ) {
            status = sender_busy;
            receiver_request.request = FR_CLOSE_FILE;  // back out
            return;
        }

        // start the sender up

        sender_request.request = FR_OPEN_TO_SEND;
        sender_request.index = sender_index;

        if( num_receivers > 1 ) {
            sender_request.dest_address.gp.type = 1;
            sender_request.dest_address.gp.size = dest_addr.gp.size;
            sender_request.dest_address.gp.retry = dest_addr.gp.retry;
            sender_request.dest_address.gp.tx_timer = dest_addr.gp.tx_timer;
            sender_request.dest_address.gp.group = dest_addr.gp.group;
        } else {
            sender_request.dest_address.sn.type = SUBNET_NODE;
            sender_request.dest_address.sn.node = dest_addr.sn.node;
            sender_request.dest_address.sn.retry = dest_addr.sn.retry;
            sender_request.dest_address.sn.tx_timer = dest_addr.sn.tx_timer;
            sender_request.dest_address.sn.subnet = dest_addr.sn.subnet;
        }
                // pass receivers' address to sender

        sender_request.auth_on = auth_on;
        sender_request.prio_on = prio_on;
        status = wait_for_sender;
        return;
     // end case wait_for_receiver

    case xfer_underway :
        if( receiver_status.status != FS_XFER_OK ) {
             status = receiver_xfer_fail;
             sender_request.request = FR_CLOSE_FILE;
             receiver_request.request = FR_CLOSE_DELETE_FILE;  // backout
            return;
        }
                      // successful transfer
        if( ++ num_responses < num_receivers ) return;  // wait some more
        status = receiver_done;
        return;                     // all receivers done

    case sender_done :
        if( ++ num_responses < num_receivers ) return;  // wait some more
        status = idle;      // all receivers are done, all done
        return;
    }
}               // end when( nv_update_occurs( receiver_status ) )

////////////////////////////////////////////////////////////////

when( nv_update_occurs( sender_status ) ) {

    int i;

    local_sender_status = sender_status;

    switch( status ) {

    case wait_for_sender :
        if( ! compare_address( &local_sender_status ) ) {
            status = sender_busy;      // in use by someone else
            receiver_request.request = FR_CLOSE_DELETE_FILE;    // backout
            return;
        }

        if( sender_status.status != FS_XFER_UNDERWAY ) {
            status = sender_open_fail;
            receiver_request.request = FR_CLOSE_DELETE_FILE;   // backout
            return;
        }
        status = xfer_underway;

        return;

    case xfer_underway:
        if( sender_status.status != FS_XFER_OK ) {
            status = sender_xfer_fail;
            receiver_request.request = FR_CLOSE_DELETE_FILE;  // backout
            sender_request.request = FR_CLOSE_FILE;
            return;
        }
        status = sender_done;
        receiver_request.request = FR_CLOSE_FILE;      // all done, button up
        sender_request.request = FR_CLOSE_FILE;
        return;

    case sender_busy:
        if ( compare_address( &local_sender_status ) &&
             sender_status.status != FS_XFER_OK ) {
            // Sender appeared to fail earlier due to conflict but no appears to
            // be owned by us.  Make sure we close done the sender.
            sender_request.request = FR_CLOSE_FILE;
        }
        return;

    case receiver_done :
        status = idle;
        return;

    case lookup_underway :
        for( i = 0; i < FILE_INFO_SIZE; i++ )
            local_descriptor.file_info[ i ] =
            sender_status.adr.descriptor.file_info[ i ];
        for( i = 0; i < 4; i++ )
            local_descriptor.size[ i ]
            = sender_status.adr.descriptor.size[ i ];
        local_descriptor.type = sender_status.adr.descriptor.type;
        status = idle;
        return;
    }
}       // end when( nv_update_occurs( sender_status ) )


////////////////////////////////////////////////////////////////
//
//      Utility functions
//
////////////////////////////////////////////////////////////////

boolean compare_address( SNVT_file_status * remote_node_status ) {
    domain_struct domain;

    domain = * access_domain( nv_in_addr.domain );

    if( remote_node_status->adr.address.subnet != domain.subnet )
        return FALSE;
    if( remote_node_status->adr.address.node != domain.node )
        return FALSE;
    if( remote_node_status->adr.address.domain_length != domain.len )
        return FALSE;
    if( memcmp( remote_node_status->adr.address.domain_id,
        domain.id, domain.len ) ) return FALSE;

    return TRUE;
}

////////////////////////////////////////////////////////////////
//
//      Here is the main program for testing purposes
//
////////////////////////////////////////////////////////////////

when( reset )
when( nv_update_occurs( function ) ) {
    if (is_bound(sender_request)) {
        if( function == FR_OPEN_TO_SEND ) start_xfer( );
        if( function == FR_DIRECTORY_LOOKUP ) sender_directory_lookup( );
    }
}
