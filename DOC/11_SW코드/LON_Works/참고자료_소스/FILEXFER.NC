////////////////////////////////////////////////////////////////
//
//          FILEXFER.NC - file transfer sender/receiver reference
//          implementation.
//
//          Last Modified: 12/18/96
//
//          This implementation supports a single file transfer
//          in progress at any given time.
//
//          This implementation supports both sender and receiver
//          capability but either sender or receiver capability
//          can be removed via conditional compilation.
//
//          This implementation supports random access though this
//          can be removed via conditional compilation.
//
//          This implementation supports network error simulation
//          based.  This is removed by default.
//
//          Note that conditionally compiling out any of the above
//          features will remove most of the associated code and
//          data but is not guaranteed to get all of it.
//
//          This implementation assumes all file indices are numbered
//          0..N-1 as recommended (though not required) in the guidelines.
//
//          Declared items are prefaced by "fx" to denote their
//          association with file transfer.
//
//  Modification History:
//
//      12/18/96 - Clear "seek_occurred" flag in "stop_xfer".
//
//      12/18/96 - Support case where initiator and sender/receiver are
//                 one in the same.
//
////////////////////////////////////////////////////////////////

// This option allows random access to be implemented.
#define ENABLE_RA

// This option enables file transfer sender capability
#define ENABLE_SENDER

// This option enables file transfer receiver capability
#define ENABLE_RECEIVER

// This option enables local file transfer initiation
// within the node.  Note that this doesn't actually implement
// the initiator logic but simply allows the sender/receiver
// logic to correctly handle turnaround NV updates.  For
// initiator logic, see initiator.nc.
#define ENABLE_LOCAL_INITIATION

// This option enables network errors to be simulated by
// dropping packets at various rates (see fx_errmask).
// Use for testing only.  Off by default.
//#define ENABLE_ERROR_SIMULATION


#include <addrdefs.h>
#include <access.h>
#include <msg_addr.h>
// This definition should be moved to msg_addr.h.
#define TURNAROUND 4

#include "file.h"
#include "fsys.h"

//
// File transfer NVs
//
network input sync sd_string("file xfer SNVT") SNVT_file_req nv_file_request;
network output sync SNVT_file_status nv_file_status;
#ifdef ENABLE_RA
network input sync SNVT_file_pos nv_file_position;
#endif

#ifdef ENABLE_SENDER
//
// File transfer message tag
//
msg_tag bind_info( nonbind ) fx_explicit_tag;
#endif

//
// File definitions - size and initialize as appropriate.
//
#define FILE_COUNT 3
far char fx_files_initialized;
far char fx_file1[1];
far char fx_file2[32];
far char fx_file3[1530];

//
// File transfer timer
//
mtimer fx_operation_timer;          // timeout from a dead sender or initiator

//
// Error injection data
//
#ifdef ENABLE_ERROR_SIMULATION
// Use this variable to simulate errors in the data stream.  The lower
// the mask, the higher the error rate as follows:
//  0=>100% error rate
//  1=>50% error rate
//  3=>25% error rate
//  7=>12.5% error rate , etc.
// If both the sender and receiver have error injection turned on or there
// are multiple receivers with error injection turned on, then the actual
// error rate is a combination of all these rates.
config network input int fx_errmask=0x1f;  // Default is 3% error rate.
#endif

//
// File transfer state data
//
typedef struct {
    file_handle handle;         // handle of the currently open file
    file_status pending_status; // pending status
    file_request req_type;      // original request type
    unsigned window_number;     // current window number (shifted left 4)
    unsigned pkt_in_window;     // current packet within window
    boolean end_of_exchange;    // end of data exchange
    boolean auth_on;            // authentication
#ifdef ENABLE_SENDER
    msg_out_addr dest_addr;     // address for explicit messaging
    boolean prio_on;            // priority
    boolean end_of_window;      // current packet is last one in the window
    unsigned window_size;       // number of packets in current window
    boolean sending_packet;     // TRUE => packet send in progress
    boolean send_packet;        // TRUE => send a packet
    int last_pkt_size;          // length of last packet
#endif
} FxData;

FxData fx = {NULL_HANDLE};

#ifdef ENABLE_SENDER
far int fx_packets[FILE_WINDOW_SIZE][FILE_PACKET_SIZE]; // Window buffer
#endif


/////////////////////////////////////////////////////////////////
//
//      Start, stop and abort transfer functions
//
////////////////////////////////////////////////////////////////

void start_transfer( file_request request ) {
    fx.auth_on = nv_file_request.auth_on;

    if (SENDER(request)) {
#ifdef ENABLE_SENDER
        // copy destination address

        // Technically, using memcpy here is not correct since the SNVT_file_req
        // address and msg_out_addr address do not share the same structure.  However,
        // they are defined identically.  If they ever diverge, this code may need
        // to do something different.
        memcpy(&fx.dest_addr, &nv_file_request.dest_address, sizeof(fx.dest_addr));
        // Use domain definition based on incoming matching domain.
        fx.dest_addr.snode.domain = nv_in_addr.domain;

        fx.prio_on = nv_file_request.prio_on;   // copy other parameters
        // If this is not a random access transfer, start sending now.
        fx.send_packet = START_SEND(request);
#endif
    } else {
        fx_operation_timer = nv_file_request.receive_timeout;
    }

    // Go to FS_XFER_UNDERWAY unless random access in which case FS_SEEK_WAIT
    nv_file_status.status = START_STATE(request);
}

void stop_transfer(file_status status) {
#ifdef ENABLE_SENDER
    if (fx.sending_packet) {
        // Hold this thought until the sending is complete.  This handles the case
        // where a close request is received while a transfer is in progress.  We
        // don't want to allow the file to be closed until the sending is complete
        // (see abort_transfer).
        fx.pending_status = status;
        // Use "return" here because it makes conditional code look cleaner.
        return;
    }
#endif

    // Use previous status as long as we aren't handling a close directive.
    if (!CLOSE_STATUS(status) && fx.pending_status) {
        // A previous status was registered so use it instead.  Note this
        // could be a pending close type status.
        status = fx.pending_status;
    }

    // In any case, make sure pending status is cleared for next time.
    fx.pending_status = 0;

    // A "close" status (i.e., from the initiator) causes us to close
    // the file.  For all others, stop the transfer but wait for the
    // initiator to close the file.
    if (CLOSE_STATUS(status)) {
        close(fx.handle, status != FS_CLOSE && status != FS_XFER_OK);
        fx_operation_timer = 0;
        // Make the file available for other transfers
        fx.handle = NULL_HANDLE;
    } else {
        // Wait up to one minute for initiator to close before
        // unilaterally making the file available (by closing it).
        fx_operation_timer = FILE_INITIATOR_CLOSE_TIMEOUT;
        fx.pending_status = FS_CLOSE;
    }
    nv_file_status.status = status&FS_EXTERNAL_STATE_MASK;
}

#ifdef ENABLE_SENDER
boolean abort_transfer(void) {
    // Function to abort a transfer if a status update is pending
    // (i.e., due to a close which arrived while we were sending.
    if (fx.pending_status) {
        stop_transfer(fx.pending_status);
        return TRUE;
    }
    return FALSE;
}

////////////////////////////////////////////////////////////////
//
//          Send the next packet in the current window
//
////////////////////////////////////////////////////////////////

void send_next_packet( void ) {
    unsigned pkt_size;

    // Read from the file unless this is a retry.  Normally, pkt_in_window is equal
    // to the window_size at this point but check for > too just in case.
    if (fx.pkt_in_window >= fx.window_size) {
        fx.last_pkt_size = pkt_size = read( fx.handle, fx_packets[ fx.pkt_in_window ], FILE_PACKET_SIZE );
        if( pkt_size == -1 ) {
            stop_transfer( FS_IO_ERR );
            return;
        }
        // End of exchange if there's less than a full packet (might even be no data).
        fx.end_of_exchange = (pkt_size<FILE_PACKET_SIZE);
        // Last packet in window if window size is at maximum or at end of exchange.
        fx.end_of_window = (++fx.window_size==FILE_WINDOW_SIZE) || fx.end_of_exchange;
    } else {
        // This is a retry.  Determine if it is the last in the window
        fx.end_of_window = (fx.pkt_in_window==fx.window_size-1);
        // Retry size is full size unless it is the last packet in which case the size
        // was saved earlier.
        pkt_size = fx.end_of_window ? fx.last_pkt_size : FILE_PACKET_SIZE;
    }

    // Must set priority first for it to take effect.
    msg_out.priority_on = fx.prio_on;

    msg_out.authenticated = fx.auth_on;
    msg_out.code = FILE_MSG_CODE;
    msg_out.tag = fx_explicit_tag;
    msg_out.dest_addr = fx.dest_addr;

    // Last packet in window is a request, others use ACKD/UNACKD based on authentication.
    if (fx.end_of_window) {
        msg_out.service = REQUEST;
    } else if (!fx.auth_on) {
        // Authenticated transfer uses ACKD service, else UNACKD
        msg_out.service = UNACKD;
    }

    // Set up data portion of packet.
    msg_out.data[0] = fx.window_number | fx.pkt_in_window;
    if (pkt_size) {
        memcpy( &msg_out.data[ 1 ], fx_packets[ fx.pkt_in_window ], pkt_size );
    }

#ifdef ENABLE_ERROR_SIMULATION
    // Occasionally send a duplicate or lose one for error testing
    if (!fx.end_of_window && (random()&fx_errmask)==0) {
        if (fx.pkt_in_window > 0 && (random()&1)) {
            msg_out.data[0] = fx.window_number | fx.pkt_in_window-1;
        } else {
            // Rather than implement logic to actually not send a message, we simply send
            // one which will be ignored by the receiver.
            msg_out.code = 0x51;    // Query status
        }
    }
#endif

    // Bump packet counter to prep for next packet to send
    fx.pkt_in_window++;

    // Set flag to guard against taking certain paths while still transmitting.  This
    // logic is not necessary for a completely synchronous implementation (i.e., sender
    // waits for completion event prior to processing incoming messages).
    fx.sending_packet = TRUE;
    msg_send( );
}
#endif

#ifdef ENABLE_RECEIVER
////////////////////////////////////////////////////////////////
//
//          Receiver functions - process an incoming packet
//
////////////////////////////////////////////////////////////////

void process_packet( void ) {     // handle a packet in current window

    unsigned bytes_received, bytes_written;
    boolean complete;

    if ((msg_in.data[0] & FILE_PACKET_MASK) == fx.pkt_in_window) {
        // It's the packet I'm expecting
        bytes_received = msg_in.len - 1;        // size less the header
        if( bytes_received ) {      // non-zero number of bytes
            char temp_packet[FILE_PACKET_SIZE];

            // Copy to local buffer (Neuron C does not permit passing msg_in.data to
            // a function such as "write").
            memcpy( temp_packet, &msg_in.data[ 1 ], bytes_received );
            bytes_written = write( fx.handle, temp_packet, bytes_received, &complete );

            if (bytes_written < bytes_received) {
                stop_transfer( FS_IO_ERR );
                return;                     // can't write to file
            } else if (complete) {
                // No more room for writes.  For random access mode, we
                // need to make a state transition.
                fx.end_of_exchange = TRUE;
                if (fx.req_type == FR_OPEN_TO_RECEIVE_RA) {
                    nv_file_status.status = FS_SEEK_WAIT;
                }
            }
        }
        fx.pkt_in_window++;        // for next time
    }

    // Handle all request packets, even if I'm not expecting it
    if (msg_in.service == REQUEST) {
        if (fx.auth_on && !msg_in.authenticated) {
            stop_transfer( FS_AUTH_ERR );
            return;
        }
        resp_out.code = fx.pkt_in_window;  // return next one expected
        resp_send( );       // tell the sender
    }
}
#endif

////////////////////////////////////////////////////////////////
//
// Utility for processing incoming request address info
//
////////////////////////////////////////////////////////////////

boolean setup_status_address(void) {
    int valid;
    int i;
    domain_struct domain;

    valid = TRUE;
    // Acknowledge to initiator by placing the initiator's address in
    // the returned status.
    nv_file_status.adr.address.subnet = nv_in_addr.src_addr.subnet;
    nv_file_status.adr.address.node = nv_in_addr.src_addr.node;
    domain = *access_domain( nv_in_addr.domain );
    nv_file_status.adr.address.domain_length = domain.len;

#ifdef ENABLE_LOCAL_INITIATION
    // Allow for case where initiator is same node as sender/receiver
    if (nv_in_addr.format == TURNAROUND) {
        nv_file_status.adr.address.subnet = domain.subnet;
        nv_file_status.adr.address.node = domain.node;
    }
#endif

    // Check for flex domain on the off chance the NV update came
    // in on the flex domain (i.e., a Neuron ID message on a domain in
    // which were not configured).
    if (nv_in_addr.flex_domain) {
        nv_file_status.adr.address.domain_length = 0xff;
        valid = FALSE;
    } else {
        for (i=0; i<domain.len; i++) {
            // Neuron C doesn't allow memcpy here unless you use the relax casting pragma.
            nv_file_status.adr.address.domain_id[i] = domain.id[i];
        }
    }
    return valid;
}


////////////////////////////////////////////////////////////////
//
//      Common when clauses
//
////////////////////////////////////////////////////////////////

when( timer_expires( fx_operation_timer ) ) {
    // Failed waiting for data from sender or close by initiator
    stop_transfer( FS_TIMEOUT_ERR );
}


when( nv_update_occurs( nv_file_request ) ) {
    int i;
    file_descriptor local_descriptor;

    if (!fx_files_initialized) {
        // Create files.  This is for demonstration only.  You may
        // want to put your analogous calls in the reset clause.
        // Note that the file indices are assigned 0 to N-1.  This is
        // strongly encouraged although the file transfer guidelines do
        // not stipulate this.  Since file directory queries are by
        // index, doing otherwise would make general perusal of your file
        // directory quite impractical.
        fx_files_initialized = TRUE;
        create(0, "file1", fx_file1, sizeof(fx_file1), 256);
        create(1, "file2", fx_file2, sizeof(fx_file2), 256);
        create(2, "file3", fx_file3, sizeof(fx_file3), 256);
    }

    // If this is a close, validate that the file indices match.
    // Otherwise, deny anything else if the file is in use.
    if (CLOSE(nv_file_request.request) ?
            (nv_file_request.index != nv_file_status.selected_file) :
            (fx.handle != NULL_HANDLE)) {
        return;
    }

    nv_file_status.number_of_files = FILE_COUNT; // always return this info
    nv_file_status.selected_file = nv_file_request.index;

    switch( nv_file_request.request ) {

    case FR_OPEN_TO_RECEIVE_RA:
    case FR_OPEN_TO_SEND_RA:
#ifndef ENABLE_RA
        // Return an error if we don't support random access
        setup_status_address();
        nv_file_status.status = FS_ACCESS_UNAVAIL;
        return;
#endif
    case FR_OPEN_TO_RECEIVE :
    case FR_OPEN_TO_SEND:
        if (!setup_status_address()) return;

        // Init state information
        memset(&fx, 0, sizeof(fx));

        fx.req_type = nv_file_request.request;
        fx.handle = open( nv_file_request.index, fx.req_type );
        if (fx.handle < 0) {
            nv_file_status.status = FS_OPEN_FAIL;      // could not open file
            return;
        }

        // Begin transfer process
        start_transfer(fx.req_type);
        break;

    case FR_CLOSE_FILE:
        stop_transfer(FS_CLOSE);
        break;

    case FR_CLOSE_DELETE_FILE:
        stop_transfer(FS_FAILURE);
        break;

    case FR_DIRECTORY_LOOKUP:
        // Assume indices are numbered 0..N-1.
        if (nv_file_request.index >= FILE_COUNT) {
            nv_file_status.status = FS_LOOKUP_ERR;
        } else {
            // Return directory information from file system
            local_descriptor = * lookup( nv_file_request.index );
            for( i = 0; i < FILE_INFO_SIZE; i++ ) {
                nv_file_status.adr.descriptor.file_info[ i ]
                = local_descriptor.file_info[ i ];
            }
            for( i = 0; i < 4; i++ ) {
                nv_file_status.adr.descriptor.size[ i ] = local_descriptor.size[ i ];
            }
            nv_file_status.adr.descriptor.type = local_descriptor.type;
            nv_file_status.status = FS_LOOKUP_OK;
        }
        break;
    }
}

#ifdef ENABLE_RA
when( nv_update_occurs(nv_file_position) ) {
    // Allow seek if waiting for seek or the previous data exchange has completed.
    // The latter allows an initiator/receiver to perform the next seek based on
    // the end of exchange indication without necessarily polling for or receiving
    // a status of FS_SEEK_WAIT.
    if (nv_file_status.status==FS_SEEK_WAIT || fx.end_of_exchange) {
        unsigned long xfer_offset;  // offset of transfer

        // Initiator has done a seek.  Ignore MSBs of 4 byte offset
        // in this 16-bit machine.
        memcpy(&xfer_offset, &nv_file_position.rw_ptr[2], sizeof(xfer_offset));

        // The seek starts the sending or receiving process
        nv_file_status.status = FS_XFER_UNDERWAY;

#ifdef ENABLE_SENDER
        fx.send_packet = SENDER(fx.req_type);
#endif

        if (seek(fx.handle, xfer_offset, nv_file_position.rw_length) == -1) {
            stop_transfer(FS_SEEK_INVALID);
        }
    } else {
        stop_transfer(FS_SEEK_INVALID);
    }
}
#endif

#ifdef ENABLE_SENDER
////////////////////////////////////////////////////////////////
//
//      Sender unique code - handle responses and completion events
//
////////////////////////////////////////////////////////////////

// Assume status got through even on failure.  If initiator doesn't
// get status, it will timeout and terminate.  Note that if the status
// is not bound to the initiator, we'll start sending potentially before
// the initiator has a chance to poll.  The initiator must be prepared
// for this.
when( nv_update_completes(nv_file_status) ) {
    if (fx.send_packet && !fx.sending_packet) {
        // Note that a completion event could occur for a previous terminate
        // during startup of the next transfer so make sure send_packet is
        // cleared to avoid multiple passes through here.
        fx.send_packet = FALSE;
        send_next_packet();
    }
}


when( resp_arrives( fx_explicit_tag ) ) {
#ifdef ENABLE_ERROR_SIMULATION
    if ((random()&fx_errmask) == 0) {
        fx.pkt_in_window = random()&3;
    }
#endif
    // Keep track of where to start retransmission (if any)
    fx.pkt_in_window = min( resp_in.code, fx.pkt_in_window );
}

when( msg_succeeds( fx_explicit_tag ) ) {
    fx.sending_packet = FALSE;
    if (!abort_transfer()) {
        // Retransmit if we sent a request and the current pkt_in_window
        // (as returned by receivers) does not match the window size.
        if (fx.end_of_window && (fx.pkt_in_window >= fx.window_size)) {
            // Successfully completed window
            fx.window_number += FILE_WINDOW_INC;    // increment high nibble
            fx.pkt_in_window = 0;
            fx.window_size = 0;
            if (fx.end_of_exchange) {     // data exchange complete
                fx.end_of_exchange = FALSE;
#ifdef ENABLE_RA
                if (fx.req_type == FR_OPEN_TO_SEND_RA) {
                    if (!fx.send_packet) {
                        nv_file_status.status = FS_SEEK_WAIT;
                    }
                    // Don't clear this in send_next_packet otherwise retries may
                    // clear it prematurely.
                    fx.send_packet = FALSE;
                } else
#endif
                {
                    // Signal xfer complete but don't close file.  This is
                    // the responsibility of the initiator.  This ensures
                    // that another initiator doesn't open the file before
                    // the current one closes.
                    stop_transfer(FS_XFER_OK);
                }
            }
        }
        // If we're still sending, send next
        if (nv_file_status.status == FS_XFER_UNDERWAY) {
            send_next_packet( );
        }
    }
}

when( msg_fails( fx_explicit_tag ) ) {
    fx.sending_packet = FALSE;
    stop_transfer(FS_TIMEOUT_ERR);
}
#endif

#ifdef ENABLE_RECEIVER
////////////////////////////////////////////////////////////////
//
//          Receiver unique processing.  Handle next packet.
//
////////////////////////////////////////////////////////////////
when( msg_arrives ) {

    unsigned received_window_number;

#ifdef ENABLE_ERROR_SIMULATION
    if ((random()&fx_errmask)==0) {
        // Occasionally drop an unackd packet
        if (msg_in.service != REQUEST) {
            return;
        }
    }
#endif

    switch( msg_in.code ) {

    case FILE_MSG_CODE:
        if (fx.handle == NULL_HANDLE) return;     // file not open
        fx_operation_timer = nv_file_request.receive_timeout;  // reset timer
        received_window_number = msg_in.data[ 0 ] & 0xF0;

        if (received_window_number == fx.window_number) {
                // a packet within the current window
            process_packet( );
            return;
        }

        //  Received a packet in a different window
        if (received_window_number == (fx.window_number+FILE_WINDOW_INC)) {
            // it's the next window
            if ((fx.pkt_in_window==FILE_WINDOW_SIZE) || fx.end_of_exchange) {
                // previous window received completely
                fx.window_number = received_window_number;   // new window
                fx.pkt_in_window = 0;                        // start a new window
                fx.end_of_exchange = FALSE;
                process_packet( );
                return;
            } else {
                stop_transfer( FS_WINDOW_ERR );
                return;     // old window didn't complete
            }
        } else {        // received a window out of sequence
            stop_transfer( FS_WINDOW_ERR );
            return;
        }
        break;
    default:        // ****** Handle other incoming messages here
        break;
    }
}
#endif
