#ifndef _FILE_H
#define _FILE_H

#include <addrdefs.h>
#include <access.h>
#include <msg_addr.h>
#include <s32.h>
#include <SNVT_fr.h>
#include <SNVT_fs.h>

//////////////////////////////////////////////////////////////////////////////
//   Filexfer Definitions        
#define NUM_FILES 3
#define NULL_HANDLE -1
#define FILE_INFO_SIZE 16               // directory information 
#define CONST_FILEINDEX 2

#define NULL_INDEX 0xFFFF

#define NULL_TYPE 0xFFFF        // null file type 


#define FILE_PACKET_SIZE 128     // bytes per packet transferred 
#define FILE_WINDOW_SIZE 6      // number of blocks per window 

#define FILE_MSG_CODE   (62)    //Message code 0x3E must be used for the transfer
								//of the configuration parameter template file and
								//the configuration parameter value file

#define FILE_PACKET_MASK 0x0F	// mask to extract packet number from header 
#define FILE_WINDOW_INC  0x10	// amount to increment one-byte encoded window
								// to advance to next window 

#define FILE_INITIATOR_CLOSE_TIMEOUT 5000  // One minute timeout for initiator close 


#define CLOSE(req)	((req)==FR_CLOSE_FILE || (req)==FR_CLOSE_DELETE_FILE)
#define SENDER(req)	((req)==FR_OPEN_TO_SEND || (req)==FR_OPEN_TO_SEND_RA)

#ifdef ENABLE_RA
#	define RANDOM_ACCESS(req) ((req)==FR_OPEN_TO_SEND_RA || (req)==FR_OPEN_TO_RECEIVE_RA)
#	define START_STATE(req)   (RANDOM_ACCESS(req) ? FS_SEEK_WAIT : FS_XFER_UNDERWAY)
#	define START_SEND(req)    !RANDOM_ACCESS(req)
#else
#	define START_SEND(req)    TRUE
#	define START_STATE(req)   FS_XFER_UNDERWAY
#endif	// enable_ra

// Internal states to indicate completion and failure condition
#define FS_CLOSE                (0x40 | FS_XFER_OK)
#define FS_FAILURE              (0x80 | FS_XFER_OK)
#define FS_EXTERNAL_STATE_MASK  0x3F    // Use to yield external state
#define FS_NO_PENDING           FS_XFER_OK
#define CLOSE_STATUS(s)         ((s)&(FS_CLOSE|FS_FAILURE))

typedef   signed long	file_handle;			// host operating system dependent
typedef unsigned long	file_index;

typedef enum  {
	VALUE_TYPE      = 1,				// 1
	TEMPLATE_TYPE,						// 2
	LAST_FILE = TEMPLATE_TYPE			// 2
} FILE_ENUM_T;

typedef union  {
	void* const readOnly;
	void* byteBase;
} FILEPTR_T;

typedef union  {
			struct  {
				unsigned long uHighWord;
				unsigned long uLowWord;
			} _dwsize;
			s32_type		s32size;
} file_size;

typedef struct  {
			char			info[FILE_INFO_SIZE];
			file_size		size;			// file size, unsigned 32 bits
			unsigned long   type;			// file type, 16 bits
} file_descriptor;                  // directory entry

typedef struct  {
			file_descriptor fileDescriptor;
			const FILEPTR_T	fileData;
} TFileDescriptor;
				
typedef struct  {
    unsigned window        : 4;
    unsigned pkt_in_window : 4;
    unsigned data[FILE_PACKET_SIZE];   // actual data
} file_packet;


typedef struct  {
		int		version;	
		int		numFiles;
		TFileDescriptor files[NUM_FILES];
} TFileDirectory;

typedef struct  {

    file_handle handle;         // handle of the currently open file
    file_status pending_status; // pending status
    file_request req_type;      // original request type
    unsigned window_number;     // current window number (shifted left 4)
    unsigned pkt_in_window;     // current packet within window
    boolean end_of_exchange;    // end of data exchange
    boolean auth_on;            // authentication
} FxData;

#endif 