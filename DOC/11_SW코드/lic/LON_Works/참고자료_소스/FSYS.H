#include "file.h"
#include <s32.h>

far unsigned long current_offset;
far unsigned long current_file_size;
far unsigned long bytes_left;         // counters for open file
far TFileDirectory FileDirectory;				  

file_descriptor* lookup(file_index index)
{ 
	// directory lookup
	return &FileDirectory.files[index].fileDescriptor;         // return descriptor of file
}


file_handle open(file_index index, file_request_t request)
{
	current_offset = 0;
	current_file_size = s32_to_ulong(&FileDirectory.files[index].fileDescriptor.size.s32size);
	
	// initialize file size counter (64K max)
	bytes_left = current_file_size;

	if (request == FR_OPEN_TO_SEND || request == FR_OPEN_TO_SEND_RA) 
	{
		return index;
	}
	else if (request == FR_OPEN_TO_RECEIVE)
	{
		return index;
	}
	else if (request == FR_OPEN_TO_RECEIVE_RA)
	{
		return index;
	}
	return NULL_HANDLE;     // invalid request
}

/////////////////////////////////////////////////////////////////

void close(file_handle handle, boolean backout)
{

#pragma ignore_notused handle
#pragma ignore_notused backout

	bytes_left = 0;
}
