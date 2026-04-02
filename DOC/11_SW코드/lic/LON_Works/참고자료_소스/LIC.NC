
//**************************************************************************************************//
//                                       Pragma Declarations                                        //
//**************************************************************************************************//
#pragma set_node_sd_string "COMM, WOOJIN, LIC, 2010-12-10"
#pragma num_alias_table_entries 17
#pragma num_addr_table_entries 15
#pragma run_unconfigured  
#pragma net_buf_in_size 146 
#pragma net_buf_in_count 7 
#pragma app_buf_in_size 146 
#pragma app_buf_in_count 7 
#pragma net_buf_out_size 146 
#pragma net_buf_out_count 7 
#pragma app_buf_out_size 146 
#pragma app_buf_out_count 7


//**************************************************************************************************//
//                                       Include Declarations                                       //
//**************************************************************************************************//
#include <addrdefs.h>
#include <access.h>
#include <msg_addr.h>
#include <s32.h>
#include <stdlib.h>
#include <control.h>
#include <io_types.h>
#include <netmgmt.h>
#include <status.h>
#include <string.h>
#include <byte.h>
#include <SNVT_fr.h>
#include <SNVT_fs.h>
#include <mem.h>
#include "COMM.h"

//**************************************************************************************************//
//                                    Constant Declarations                                 //
//**************************************************************************************************//
#define MAX_IN 20
#define MAX_OUT 134
#define	STX	0x02
#define	ETX	0x03
#define	MIN_PACKET_LEN	6
#define ENABLE_RECEIVER
#define TURNAROUND 4
#define TIMESTAMP_RATE 3600
// Status update rate timing
#define MIN_STATUS_RATE		500	// msec
#define DEFAULT_STATUS_RATE	9000	// msec
#define LED_ON 0
#define LED_OFF 1
//**************************************************************************************************//
//                                           I/O Declarations                                       //
//**************************************************************************************************//
IO_1 output bit LED7;
IO_2 output bit LED6;
IO_5 output bit LED8;

IO_3 output bit OutInetrupt; //FT->MCU Interrupt
IO_4 input bit InInetrupt; //MCU->FT Interrupt

//**************************************************************************************************//
//                                       Timer Declarations                                         //
//**************************************************************************************************//

mtimer repeating StatusTimer;
stimer repeating SilenceTimer;
stimer repeating ClockTimer=3600; //1Hour Timer
mtimer repeating SCITimer; //SCI Version Request

//**************************************************************************************************//
//                                    Dual Port Memory Declarations                                 //
//**************************************************************************************************//
typedef struct 
{ 
	char DataAddress[1]; //A000 DataAddress
	char verInfo[6]; //version info [0][1] Version [2]~[5]Build date
	char offset[1]; //offset
	char FtpData1[136]; // 0:length / 1~7 : offset / 8~135 :Data
	char FtpData2[136]; 
	char FtpData3[136]; 
	char FtpData4[136]; 
	char FtpData5[136]; 
	char FtpData6[136]; 
	char Tx[64]; // FT to MCU  0:length / 1~7 : offset / 8~63 :Data
	char Rx[64]; // MCU to FT  0:length / 1~7 : offset / 8~63 :Data
}*DataAccess;
  const DataAccess pData = (DataAccess) 0xA000;

//**************************************************************************************************//
//                                    Network Variable Declarations                                 //
//**************************************************************************************************//
config network input sd_string("&0,,0\x90,25;")int nci00NetConfig;

far network input sd_string("@0|1")		SNVT_obj_request 	nvi00ObjRequest;
far network output sd_string("@0|2")	SNVT_obj_status 	nvo00ObjStatus;
far network input sd_string("@0|3")		UNVT_CDT_Command 	nvi00CDTCommand;
far network output sd_string("@0|4")	SNVT_time_stamp 	nvo00TimeStamp;
far network input sd_string("@0|5")		SNVT_file_req 		nvi00FileReqA;
far network output sd_string("@0|6")	SNVT_file_status 	nvo00FileStatA;
far network input sd_string("@0|7")		SNVT_file_req 		nvi00FileReqB;
far network output sd_string("@0|8")	SNVT_file_status 	nvo00FileStatB;

far network input sd_string("@1|1") 	UNVT_subscribe 		nvi01Subscribe;
far network output sync sd_string("@1|2") SNVT_state_64 	nvo01StatusBits;
far network output sd_string("@1|3")	SNVT_state_64 		nvo01StatusBits2;
far network input sd_string("@1|4")		SNVT_state 			nvi01TransfState;
far network output sd_string("@1|5")	UNVT_parameter 		nvo01Parameter;
far network input sync sd_string("@1|6")SNVT_state_64 		nvi01CDTStBitsA;
far network input sync sd_string("@1|7")SNVT_state_64 		nvi01CDTStBitsB;
far network input sd_string("@1|8")		UNVT_parameter 		nvi01CDTParamA;
far network input sd_string("@1|9")		UNVT_parameter 		nvi01CDTParamB;

far network input sd_string("@3|1")		UNVT_sci_version_request nvi03SCIVersReq;
far network output sd_string("@3|2")	UNVT_sci_version 	nvo03SCIVersion;

far network input sd_string("@4|1")		UNVT_wayside_response nvi04WaysidRespA;
far network output sd_string("@4|2")	UNVT_wayside_request nvo04WaysideReqA;
far network input sd_string("@4|3")		UNVT_wayside_response nvi04WaysidRespB;
far network output sd_string("@4|4")	UNVT_wayside_request nvo04WaysideReqB;
 
eeprom unsigned long ee_config_setup = NOT_LOCAL_CONFIG;
//**************************************************************************************************//
//                                    Global variable define                                        //
//**************************************************************************************************//
boolean FtpRunning=FALSE;
boolean MultiFTP=FALSE;
boolean SelectAB=FALSE;
boolean CarType=FALSE; // FALSE : Single Car or Car A of married pair // TRUE : Car B of Married pair 
boolean CNCS_ACK=FALSE;

char _Checksum;
char TempTime[4];
char WaysideType;
char InBuffer[MAX_IN];
char OutBuffer[MAX_OUT];
char ErrorBuffer[MAX_IN];
far char SCI[50][8];
char BuildVersion[6];

unsigned int InChars,OutChars,SciCount;
unsigned int FtpLength,FtpReq_Number;
unsigned bytes_received;

union { SNVT_state_64 st; unsigned short b[8]; } StatusCopy;
unsigned short	StatErrCount,CDTCount,CDT_A,CDT_B,SCI_INDEX;
s32_type DefaultTime,ReceivedTime;
long LowByte,HiByte; 
s32_type s32Var,s32Low,s32Hi;

extern system void _change_state(int state);

void TxSend(int length)
{
	memcpy(pData->Tx,0x00,64); //initialization Memory
	memset(pData->DataAddress,0x07,1); // Data Address Set
	memcpy(pData->Tx,OutBuffer,length);
	io_out(OutInetrupt, FALSE); //Interrupt occure
	io_out(OutInetrupt, TRUE);
}

void TransferEnd(void)
{
	OutBuffer[0]=STX;
	OutBuffer[1]=0x06;
	OutBuffer[2]=0x00;
	OutBuffer[3]=0x00;
	OutBuffer[4]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3];
	OutBuffer[5]=ETX;
	TxSend(6);  
	FtpRunning=FALSE;
}
//**************************************************************************************************//
//                                       When Function                                              //
//**************************************************************************************************//

when(reset)
{
	watchdog_update();
	Self_Install();
	StatusTimer=DEFAULT_STATUS_RATE; //Status Timer initialize. 
	CarType=FALSE; 
	MultiFTP=FALSE;
	
	BuildVersion[0]=0x11;
	BuildVersion[1]=0x04;
	BuildVersion[2]=0x20;
	BuildVersion[3]=0x10;
	BuildVersion[4]=0x12;
	BuildVersion[5]=0x10;
	
	memcpy(pData->verInfo,BuildVersion,6); // Version Set
	io_out(OutInetrupt, TRUE);
	CDTCount=0;
	SCITimer=100;
	
	io_out(LED6, LED_OFF);
	io_out(LED7, LED_OFF);
	io_out(LED8, LED_OFF);
	_change_state(0x04); // configured online
}

/*****************************************************************************/
// Handle command from CDT
when(nv_update_occurs(nvi00CDTCommand))
{
	switch (nvi00CDTCommand.command_id)
	{
		case 1:
			OutBuffer[0]=STX;
			OutBuffer[1]=0x08;
			OutBuffer[2]=0x00;
			OutBuffer[3]=0x00;
			OutBuffer[4]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3];
			OutBuffer[5]=ETX;
			TxSend(6);
			ClockTimer=TIMESTAMP_RATE;	// restart hourly timer
		break;
	}
}

/*****************************************************************************/
// Handle subscribe from CDT
when (nv_update_occurs(nvi01Subscribe))
{
	if(nvi01Subscribe.param_id == 0 ) //Status Update 
	{ 
		OutBuffer[0]=STX;
		OutBuffer[1]=0x0A;
		OutBuffer[2]=0x00;
		OutBuffer[3]=0x00;
		OutBuffer[4]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3];
		OutBuffer[5]=ETX;
		TxSend(6);
		ErrorStatus();
		StatusTimer=nvi01Subscribe.update_rate;
	}
}

/*****************************************************************************/
when(nv_update_occurs(nvi01TransfState))
{
	if (nvi01TransfState.bit0 == 1)
	{
		FtpRunning=TRUE;
		SilenceTimer = 60;	// (re)start timer
	}
	else
	{
		FtpRunning=FALSE;
		SilenceTimer = 0;	// stop timer
	}
}
//*****************************************************************************//
when (nv_update_occurs(nvi01CDTParamA))
{
	if(nvi01CDTParamA.param_id==0x05)
	{
		OutBuffer[0]=STX;
		OutBuffer[1]=0x07;
		OutBuffer[2]=0x00;
		OutBuffer[3]=0x02;
		OutBuffer[4]=high_byte(nvi01CDTParamA.param_value);
		OutBuffer[5]=low_byte(nvi01CDTParamA.param_value);
		OutBuffer[6]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3]^OutBuffer[4]^OutBuffer[5];
		OutBuffer[7]=ETX;
		TxSend(8);
	}
}

//*****************************************************************************//
when (nv_update_occurs(nvi01CDTParamB))
{
	if(nvi01CDTParamB.param_id==0x05)
	{
		OutBuffer[0]=STX;
		OutBuffer[1]=0x07;
		OutBuffer[2]=0x00;
		OutBuffer[3]=0x02;
		OutBuffer[4]=high_byte(nvi01CDTParamB.param_value);
		OutBuffer[5]=low_byte(nvi01CDTParamB.param_value);
		OutBuffer[6]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3]^OutBuffer[4]^OutBuffer[5];
		OutBuffer[7]=ETX;
		TxSend(8);
	}
}

/*****************************************************************************/
// Handle successful status transmission to CDT
when(nv_update_succeeds(nvo01StatusBits))
{
	StatErrCount = 0;	// clear error counter
}

/*****************************************************************************/
// Handle failed status transmission to CDT
when(nv_update_fails(nvo01StatusBits))
{
	if (StatErrCount < 4)
	{
		++StatErrCount;
		if (StatErrCount == 4)
		{
			StatusTimer=9000;
			if(FtpRunning==TRUE)
			{       
				Self_Install();
			}
		}
	}
}

when (nv_update_occurs(nvi01CDTStBitsA))
{ 
	CDT_A=1;
	OutBuffer[0]=STX;
	OutBuffer[1]=0x0E;
	OutBuffer[2]=0x00;
	OutBuffer[3]=0x01;
	OutBuffer[4]=nvi01CDTStBitsA.bit0;
	OutBuffer[4]=(OutBuffer[4]<<1)+nvi01CDTStBitsA.bit1;
	OutBuffer[4]=(OutBuffer[4]<<1)+nvi01CDTStBitsA.bit2;
	OutBuffer[4]=(OutBuffer[4]<<1)+nvi01CDTStBitsA.bit3;
	OutBuffer[5]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3]^OutBuffer[4];
	OutBuffer[6]=ETX;
	TxSend(7);
	if(CarType==TRUE){io_out(LED7, LED_ON);}else {io_out(LED7, LED_OFF);}
}

when(nv_update_fails(nvi01CDTStBitsA))
{ CDT_A=0; }

when (nv_update_occurs(nvi01CDTStBitsB))
{ 
	CDT_B=1; 
	OutBuffer[0]=STX;
	OutBuffer[1]=0x0F;
	OutBuffer[2]=0x00;
	OutBuffer[3]=0x01;
	OutBuffer[4]=nvi01CDTStBitsB.bit0;
	OutBuffer[4]=(OutBuffer[4]<<1)+nvi01CDTStBitsB.bit1;
	OutBuffer[4]=(OutBuffer[4]<<1)+nvi01CDTStBitsB.bit2;
	OutBuffer[4]=(OutBuffer[4]<<1)+nvi01CDTStBitsB.bit3;
	OutBuffer[5]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3]^OutBuffer[4];
	OutBuffer[6]=ETX;
	TxSend(7);
}

when(nv_update_fails(nvi01CDTStBitsB))
{ CDT_B=0; }

when (nv_update_occurs(nvi03SCIVersReq))
{

	if(FtpRunning==FALSE)
	{
		switch(nvi03SCIVersReq.sci_index)
		{
		case 0x01: SCI_INDEX=0;
			nvo03SCIVersion.sci_name[0]='T';nvo03SCIVersion.sci_name[1]='R'; //////////// TRIC1
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='C';
			nvo03SCIVersion.sci_name[4]='1';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x02: SCI_INDEX=1;
			nvo03SCIVersion.sci_name[0]='T';nvo03SCIVersion.sci_name[1]='R'; //////////// TRIC2
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='C';
			nvo03SCIVersion.sci_name[4]='2';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x03 :SCI_INDEX=2;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='C'; //////////// CCP1
			nvo03SCIVersion.sci_name[2]='P';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x04: SCI_INDEX=3;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='C'; //////////// CCP2
			nvo03SCIVersion.sci_name[2]='P';nvo03SCIVersion.sci_name[3]='2';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;       
		case 0x05: nvo03SCIVersion.sci_index=5;
			nvo03SCIVersion.sci_type=3;
			nvo03SCIVersion.sci_name[0]='L';
			nvo03SCIVersion.sci_name[1]='I';
			nvo03SCIVersion.sci_name[2]='C';
			nvo03SCIVersion.sci_name[3]='-';
			nvo03SCIVersion.sci_name[4]='L';
			nvo03SCIVersion.sci_name[5]='O';
			nvo03SCIVersion.sci_name[6]='N';
			
			nvo03SCIVersion.sci_version[0]='1';
			nvo03SCIVersion.sci_version[1]='.';
			nvo03SCIVersion.sci_version[2]='1';
			nvo03SCIVersion.sci_version[3]='.';
			nvo03SCIVersion.sci_version[4]='0';
			nvo03SCIVersion.sci_version[5]='4';
			nvo03SCIVersion.sci_version[6]='';
			nvo03SCIVersion.sci_version[7]='';
			
			nvo03SCIVersion.build_date[0]='2';
			nvo03SCIVersion.build_date[1]='0';
			nvo03SCIVersion.build_date[2]='1';
			nvo03SCIVersion.build_date[3]='0';
			nvo03SCIVersion.build_date[4]='-';
			nvo03SCIVersion.build_date[5]='1';
			nvo03SCIVersion.build_date[6]='2';
			nvo03SCIVersion.build_date[7]='-';
			nvo03SCIVersion.build_date[8]='1';
			nvo03SCIVersion.build_date[9]='0';
			propagate(nvo03SCIVersion); SCI_INDEX=51;
			break;
		
		case 0x06: SCI_INDEX=4;
			nvo03SCIVersion.sci_name[0]='L';nvo03SCIVersion.sci_name[1]='I';//////////// LIC-MPU
			nvo03SCIVersion.sci_name[2]='C';nvo03SCIVersion.sci_name[3]='-';
			nvo03SCIVersion.sci_name[4]='M';nvo03SCIVersion.sci_name[5]='P';
			nvo03SCIVersion.sci_name[6]='U';nvo03SCIVersion.sci_name[7]=''; 
			break;             	       
		case 0x07: SCI_INDEX=5;
			nvo03SCIVersion.sci_name[0]='G';nvo03SCIVersion.sci_name[1]='I';//////////// GIA
			nvo03SCIVersion.sci_name[2]='A';nvo03SCIVersion.sci_name[3]='';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x08: SCI_INDEX=6;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='T';//////////// VTX
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x09: SCI_INDEX=7;
			nvo03SCIVersion.sci_name[0]='P';nvo03SCIVersion.sci_name[1]='A';//////////// PAC1
			nvo03SCIVersion.sci_name[2]='C';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x0A: SCI_INDEX=8;
			nvo03SCIVersion.sci_name[0]='P';nvo03SCIVersion.sci_name[1]='A';//////////// PAC2
			nvo03SCIVersion.sci_name[2]='C';nvo03SCIVersion.sci_name[3]='2';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x0B: SCI_INDEX=9;
			nvo03SCIVersion.sci_name[0]='F';nvo03SCIVersion.sci_name[1]='D';//////////// FDI1
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x0C: SCI_INDEX=10;
			nvo03SCIVersion.sci_name[0]='F';nvo03SCIVersion.sci_name[1]='D';//////////// FDI2
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='2';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x0D: SCI_INDEX=11;
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI1
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x0E: SCI_INDEX=12;
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI2
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='2';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x0F: SCI_INDEX=13;
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI3
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='3';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x10: SCI_INDEX=14;
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI4
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='4';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x11: SCI_INDEX=15;
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI5
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='5';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x12: SCI_INDEX=16; 
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI6
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='6';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;   
		case 0x13: SCI_INDEX=17;
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI7
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='7';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break; 
		case 0x14: SCI_INDEX=18;
			nvo03SCIVersion.sci_name[0]='S';nvo03SCIVersion.sci_name[1]='D';//////////// SDI8
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='8';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;     
		case 0x15: SCI_INDEX=19;
			nvo03SCIVersion.sci_name[0]='P';nvo03SCIVersion.sci_name[1]='I';//////////// PII1
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x16: SCI_INDEX=20;
			nvo03SCIVersion.sci_name[0]='P';nvo03SCIVersion.sci_name[1]='I';//////////// PII2
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='2';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;   
		case 0x17: SCI_INDEX=21;
			nvo03SCIVersion.sci_name[0]='P';nvo03SCIVersion.sci_name[1]='I';//////////// PII3
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='3';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break; 
		case 0x18: SCI_INDEX=22;
			nvo03SCIVersion.sci_name[0]='P';nvo03SCIVersion.sci_name[1]='I';//////////// PII4
			nvo03SCIVersion.sci_name[2]='I';nvo03SCIVersion.sci_name[3]='4';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;   
		case 0x19: SCI_INDEX=23;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX1
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;       
		case 0x1A: SCI_INDEX=24; 
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX2
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='2';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x1B: SCI_INDEX=25;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX3
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='3';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break; 
		case 0x1C: SCI_INDEX=26;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX4
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='4';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x1D: SCI_INDEX=27;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX5
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='5';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;      
		case 0x1E: SCI_INDEX=28;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX6
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='6';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;   
		case 0x1F: SCI_INDEX=29;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX7
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='7';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break; 
		case 0x20: SCI_INDEX=30;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX8
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='8';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;    
		case 0x21: SCI_INDEX=31;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX9
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='9';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x22: SCI_INDEX=32;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX10
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='0';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;   
		case 0x23: SCI_INDEX=33;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX11
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='1';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break; 
		case 0x24: SCI_INDEX=34;
			nvo03SCIVersion.sci_name[0]='V';nvo03SCIVersion.sci_name[1]='R';//////////// VRX12
			nvo03SCIVersion.sci_name[2]='X';nvo03SCIVersion.sci_name[3]='1';
			nvo03SCIVersion.sci_name[4]='2';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;             
		case 0x25: SCI_INDEX=35;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='N';////////////CN-MAIN 
			nvo03SCIVersion.sci_name[2]='-';nvo03SCIVersion.sci_name[3]='M';
			nvo03SCIVersion.sci_name[4]='A';nvo03SCIVersion.sci_name[5]='I';
			nvo03SCIVersion.sci_name[6]='N';nvo03SCIVersion.sci_name[7]=''; 
			break; 
		case 0x26: SCI_INDEX=36;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='N';////////////CN-LAUN
			nvo03SCIVersion.sci_name[2]='-';nvo03SCIVersion.sci_name[3]='L';
			nvo03SCIVersion.sci_name[4]='A';nvo03SCIVersion.sci_name[5]='U';
			nvo03SCIVersion.sci_name[6]='N';nvo03SCIVersion.sci_name[7]=''; 
			break;     
		case 0x27: SCI_INDEX=37;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='N';////////////CN-UP
			nvo03SCIVersion.sci_name[2]='-';nvo03SCIVersion.sci_name[3]='U';
			nvo03SCIVersion.sci_name[4]='P';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;
		case 0x28: SCI_INDEX=38;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='N';////////////CN-PPLAY 
			nvo03SCIVersion.sci_name[2]='-';nvo03SCIVersion.sci_name[3]='P';
			nvo03SCIVersion.sci_name[4]='P';nvo03SCIVersion.sci_name[5]='L';
			nvo03SCIVersion.sci_name[6]='A';nvo03SCIVersion.sci_name[7]='Y'; 
			break;   
		case 0x29: SCI_INDEX=39;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='N';////////////CN-SPLAY 
			nvo03SCIVersion.sci_name[2]='-';nvo03SCIVersion.sci_name[3]='S';
			nvo03SCIVersion.sci_name[4]='P';nvo03SCIVersion.sci_name[5]='L';
			nvo03SCIVersion.sci_name[6]='A';nvo03SCIVersion.sci_name[7]='Y'; 
			break; 
		case 0x2A: SCI_INDEX=40;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='N';////////////CN-FTP
			nvo03SCIVersion.sci_name[2]='-';nvo03SCIVersion.sci_name[3]='F';
			nvo03SCIVersion.sci_name[4]='T';nvo03SCIVersion.sci_name[5]='P';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;  
		case 0x2B: SCI_INDEX=41;
			nvo03SCIVersion.sci_name[0]='C';nvo03SCIVersion.sci_name[1]='N';////////////CN-CDT
			nvo03SCIVersion.sci_name[2]='-';nvo03SCIVersion.sci_name[3]='C';
			nvo03SCIVersion.sci_name[4]='D';nvo03SCIVersion.sci_name[5]='T';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break; 
		case 0x2C: SCI_INDEX=42;
			nvo03SCIVersion.sci_name[0]='';nvo03SCIVersion.sci_name[1]='';////////////
			nvo03SCIVersion.sci_name[2]='';nvo03SCIVersion.sci_name[3]='';
			nvo03SCIVersion.sci_name[4]='';nvo03SCIVersion.sci_name[5]='';
			nvo03SCIVersion.sci_name[6]='';nvo03SCIVersion.sci_name[7]=''; 
			break;    
		}
 
		if(SCI_INDEX < 50)
		{ 
			nvo03SCIVersion.sci_index=SCI[SCI_INDEX][0];
			nvo03SCIVersion.sci_type=SCI[SCI_INDEX][1];
			if(SCI[SCI_INDEX][1] > 0)
			{
				nvo03SCIVersion.sci_version[0]=(SCI[SCI_INDEX][2]>>4)+0x30;
				nvo03SCIVersion.sci_version[1]='.';
				nvo03SCIVersion.sci_version[2]=(SCI[SCI_INDEX][2]&0x0F)+0x30;
				nvo03SCIVersion.sci_version[3]='.';
				nvo03SCIVersion.sci_version[4]=(SCI[SCI_INDEX][3]>>4)+0x30;
				nvo03SCIVersion.sci_version[5]=(SCI[SCI_INDEX][3]&0x0F)+0x30;
				
				nvo03SCIVersion.build_date[0]=(SCI[SCI_INDEX][4]>>4)+0x30;
				nvo03SCIVersion.build_date[1]=(SCI[SCI_INDEX][4]&0x0F)+0x30;
				nvo03SCIVersion.build_date[2]=(SCI[SCI_INDEX][5]>>4)+0x30;
				nvo03SCIVersion.build_date[3]=(SCI[SCI_INDEX][5]&0x0F)+0x30;
				nvo03SCIVersion.build_date[4]='-';
				nvo03SCIVersion.build_date[5]=(SCI[SCI_INDEX][6]>>4)+0x30;
				nvo03SCIVersion.build_date[6]=(SCI[SCI_INDEX][6]&0x0F)+0x30;
				nvo03SCIVersion.build_date[7]='-';
				nvo03SCIVersion.build_date[8]=(SCI[SCI_INDEX][7]>>4)+0x30;
				nvo03SCIVersion.build_date[9]=(SCI[SCI_INDEX][7]&0x0F)+0x30;
				propagate(nvo03SCIVersion); 
			}
			else
			{
				nvo03SCIVersion.sci_version[0]='';
				nvo03SCIVersion.sci_version[1]='';
				nvo03SCIVersion.sci_version[2]='';
				nvo03SCIVersion.sci_version[3]='';
				nvo03SCIVersion.sci_version[4]='';
				nvo03SCIVersion.sci_version[5]='';
				
				nvo03SCIVersion.build_date[0]='';
				nvo03SCIVersion.build_date[1]='';
				nvo03SCIVersion.build_date[2]='';
				nvo03SCIVersion.build_date[3]='';
				nvo03SCIVersion.build_date[4]='';
				nvo03SCIVersion.build_date[5]='';
				nvo03SCIVersion.build_date[6]='';
				nvo03SCIVersion.build_date[7]='';
				nvo03SCIVersion.build_date[8]='';
				nvo03SCIVersion.build_date[9]='';
				propagate(nvo03SCIVersion); 
			}
		}
	}
}

//============================================================================================================//
when (nv_update_occurs(nvi04WaysidRespA))
{
	if(nvi04WaysidRespA.response==1 && CarType==TRUE) // No new entries available.
	{
		//WaySideOn(WaysideType);
	}
	
	if(nvi04WaysidRespA.response==2) // No new entries available.
	{
		TransferEnd();
	}
}
//============================================================================================================//

when (nv_update_occurs(nvi04WaysidRespB))
{
	if(nvi04WaysidRespB.response==1 && CarType==TRUE) // No new entries available.
	{
		//WaySideOn(WaysideType);
	}
	if(nvi04WaysidRespB.response==2) // No new entries available.
	{
		TransferEnd();
	}
}
//**************************************************************************************************//
//                                       Timer Event                                                //
//**************************************************************************************************//

/*****************************************************************************/

when (io_changes(InInetrupt))
{
	memcpy(InBuffer,pData->Rx,MAX_IN); //initialization Memory
	
	InChars=InBuffer[3]+6; // Check DataLength
	
	_Checksum=CheckSum(1); // Calculation Checksum
	
	if ((InBuffer[0]==STX) && (InBuffer[InChars-1]==ETX)){ //Check STX,ETX Data
	
	if(_Checksum==InBuffer[InChars-2]){ //Check Checksum Value
	
	switch(InBuffer[1])
	{
		case 0x01: // Wayside On         
		//Wayside On ACK
		
			if(InBuffer[5]==0x41){SelectAB=FALSE; io_out(LED6, LED_ON);}
			else if(InBuffer[5]==0x42){SelectAB=TRUE; io_out(LED6, LED_OFF);}
			
			OutBuffer[0]=STX;
			OutBuffer[1]=0x02;
			OutBuffer[2]=0x00;
			OutBuffer[3]=0x00;
			OutBuffer[4]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3];
			OutBuffer[5]=ETX;
			TxSend(6);
			
			HiByte=make_long(InBuffer[7],InBuffer[6]);
			LowByte=make_long(InBuffer[9],InBuffer[8]);
			s32_from_ulong((unsigned long) 65535, (s32_type *) &s32Var);
			s32_from_ulong((unsigned long) HiByte, (s32_type *) &s32Hi);
			s32_from_ulong((unsigned long) LowByte, (s32_type *) &s32Low);
			s32_mul(&s32Hi,&s32Var,&ReceivedTime);
			s32_add(&s32Hi,&ReceivedTime,&ReceivedTime);
			s32_add(&s32Low,&ReceivedTime,&ReceivedTime);
			WaysideType=InBuffer[4];
			WaySideOn(WaysideType);
			break;
		
		case 0x03: // CNCS FTP Ack
			CNCS_ACK=TRUE;
			break; 
		
		case 0x09: // Time information 
			if(FtpRunning==FALSE)
			{
			nvo00TimeStamp.year=0x7D0+InBuffer[4];
			nvo00TimeStamp.month=InBuffer[5];
			nvo00TimeStamp.day=InBuffer[6];
			nvo00TimeStamp.hour=InBuffer[7];
			nvo00TimeStamp.minute=InBuffer[8];
			nvo00TimeStamp.second=InBuffer[9]; // Time Update  
			propagate(nvo00TimeStamp);    
			}
			break;
		
		case 0x0B: // Comm Status data
			if(FtpRunning==FALSE)
			{	       
				if(nvi01Subscribe.param_id==0)
				{
					memcpy(ErrorBuffer,InBuffer,InChars);
				}
			}
			break;   
		case 0x0D: // SCI Version
			
			if(FtpRunning==FALSE)
			{
				switch(InBuffer[4])
				{              
					case 0x01: memcpy(&SCI[0][0],&InBuffer[4],8);break;  //TRIC,A/F        
					case 0x02: memcpy(&SCI[1][0],&InBuffer[4],8);break;  //TRIC,B
					case 0x03: memcpy(&SCI[2][0],&InBuffer[4],8);break;  //CCP,F/A
					case 0x04: memcpy(&SCI[3][0],&InBuffer[4],8);break;  //CCP,B       
					case 0x05: break;                                    //LIC-LON
					case 0x06: memcpy(&SCI[4][0],&InBuffer[4],8);break;  //LIC-MPU  
					case 0x07: memcpy(&SCI[5][0],&InBuffer[4],8);break;  //GIA           
					case 0x08: memcpy(&SCI[6][0],&InBuffer[4],8);break;  //VTX          
					case 0x09: memcpy(&SCI[7][0],&InBuffer[4],8);break;  //PAC,F/A        
					case 0x0A: memcpy(&SCI[8][0],&InBuffer[4],8);break;  //PAC,B       
					case 0x0B: memcpy(&SCI[9][0],&InBuffer[4],8);break;  //FDI,F/A       
					case 0x0C: memcpy(&SCI[10][0],&InBuffer[4],8);break;  //FDI,B        
					case 0x0D: memcpy(&SCI[11][0],&InBuffer[4],8);break; //SDI 1        
					case 0x0E: memcpy(&SCI[12][0],&InBuffer[4],8);break; //SDI 2                
					case 0x0F: memcpy(&SCI[13][0],&InBuffer[4],8);break; //SDI 3                
					case 0x10: memcpy(&SCI[14][0],&InBuffer[4],8);break; //SDI 4       
					case 0x11: memcpy(&SCI[15][0],&InBuffer[4],8);break; //SDI 5            
					case 0x12: memcpy(&SCI[16][0],&InBuffer[4],8);break; //SDI 6         
					case 0x13: memcpy(&SCI[17][0],&InBuffer[4],8);break; //SDI 7        
					case 0x14: memcpy(&SCI[18][0],&InBuffer[4],8);break; //SDI 8         
					case 0x15: memcpy(&SCI[19][0],&InBuffer[4],8);break; //PII 1                
					case 0x16: memcpy(&SCI[20][0],&InBuffer[4],8);break; //PII 2         
					case 0x17: memcpy(&SCI[21][0],&InBuffer[4],8);break; //PII 3              
					case 0x18: memcpy(&SCI[22][0],&InBuffer[4],8);break; //PII 4   
					case 0x19: memcpy(&SCI[23][0],&InBuffer[4],8);break; //VRX 1        
					case 0x1A: memcpy(&SCI[24][0],&InBuffer[4],8);break; //VRX 2                
					case 0x1B: memcpy(&SCI[25][0],&InBuffer[4],8);break; //VRX 3                
					case 0x1C: memcpy(&SCI[26][0],&InBuffer[4],8);break; //VRX 4       
					case 0x1D: memcpy(&SCI[27][0],&InBuffer[4],8);break; //VRX 5            
					case 0x1E: memcpy(&SCI[28][0],&InBuffer[4],8);break; //VRX 6         
					case 0x1F: memcpy(&SCI[29][0],&InBuffer[4],8);break; //VRX 7        
					case 0x20: memcpy(&SCI[30][0],&InBuffer[4],8);break; //VRX 8         
					case 0x21: memcpy(&SCI[31][0],&InBuffer[4],8);break; //VRX 9                
					case 0x22: memcpy(&SCI[32][0],&InBuffer[4],8);break; //VRX 10         
					case 0x23: memcpy(&SCI[33][0],&InBuffer[4],8);break; //VRX 11              
					case 0x24: memcpy(&SCI[34][0],&InBuffer[4],8);break; //VRX 12            
					case 0x25: memcpy(&SCI[35][0],&InBuffer[4],8);break; //CN-MAIN        
					case 0x26: memcpy(&SCI[36][0],&InBuffer[4],8);break; //CN-LAUN         
					case 0x27: memcpy(&SCI[37][0],&InBuffer[4],8);break; //CN-UP              
					case 0x28: memcpy(&SCI[38][0],&InBuffer[4],8);break; //CN-PPLAY         
					case 0x29: memcpy(&SCI[39][0],&InBuffer[4],8);break; //CN-SPLAY            
					case 0x2A: memcpy(&SCI[40][0],&InBuffer[4],8);break; //CN-FTP     	            
					case 0x2B: memcpy(&SCI[41][0],&InBuffer[4],8);break; //CN-CDT
					case 0x2C: memcpy(&SCI[42][0],&InBuffer[4],8);break; 
				}
			}
			break;
	
	} //end switch
	} //end Checksum if	
	} //end  STX,ETX if 
	memset(InBuffer,0x00,InChars); //Input Buffer Clear
}

/*****************************************************************************/
// Handle timer for Status update.
when (timer_expires(StatusTimer)) // Comm Status Timer
{
	CDTCount=CDT_A+CDT_B;
	if(CDTCount==1) {CarType=FALSE;}
	else if(CDTCount==2) {CarType=TRUE;}
	
	OutBuffer[0]=STX;
	OutBuffer[1]=0x0A;
	OutBuffer[2]=0x00;
	OutBuffer[3]=0x01;
	OutBuffer[4]=CDTCount;
	OutBuffer[5]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3]^OutBuffer[4];
	OutBuffer[6]=ETX;
	TxSend(7);
	ErrorStatus();
}

//============================================================================================================//

when (timer_expires(SilenceTimer)) // SilenceTimer
{
	FtpRunning=FALSE;
	SilenceTimer=0;
}

when (timer_expires(ClockTimer)) // 1Hour Timer
{
	OutBuffer[0]=STX;
	OutBuffer[1]=0x08;
	OutBuffer[2]=0x00;
	OutBuffer[3]=0x00;
	OutBuffer[4]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3];
	OutBuffer[5]=ETX;
	TxSend(6);
}

when (timer_expires(SCITimer)) 
{
	SciCount=SciCount+1;
	if(SciCount<45)
	{
		OutBuffer[0]=STX;
		OutBuffer[1]=0x0C;
		OutBuffer[2]=0x00;
		OutBuffer[3]=0x01;
		OutBuffer[4]=SciCount;
		OutBuffer[5]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3]^OutBuffer[4];
		OutBuffer[6]=ETX;
		TxSend(7);
	}
	else
	{
		SCITimer=0; SciCount=0;
	}
}


//**************************************************************************************************//
//                                        Function                                                  //
//**************************************************************************************************//
void WaySideOn(int Request)
{
	if(CarType==FALSE && SelectAB==FALSE)
	{
		switch(Request)
		{
		//0x01 : Wayside 0x02 : Yard
		case 1: // Recent Faults
			FtpReq_Number=2;
			nvo04WaysideReqA.request=Request;
			nvo04WaysideReqA.time_stamp=DefaultTime;
			break;
		
		case 2: // Historical Faults // 1,2로 받아서 2로 올경우 +1를함 Historical Faults로 요청
			FtpReq_Number=3;
			nvo04WaysideReqA.request=Request+1;
			nvo04WaysideReqA.time_stamp=ReceivedTime;
			break;
		}
	}
	else if(CarType==TRUE && SelectAB==FALSE)
	{
		switch(Request)
		{
		case 1: // Recent Faults
			FtpReq_Number=2;
			nvo04WaysideReqA.request=Request;
			nvo04WaysideReqA.time_stamp=DefaultTime;
			break;
		
		case 2: // Historical Faults // 1,2로 받아서 2로 올경우 +1를함  Historical Faults로 요청
			FtpReq_Number=3;
			nvo04WaysideReqA.request=Request+1;
			nvo04WaysideReqA.time_stamp=ReceivedTime;
			break;
		}
	}
	else if(CarType==TRUE && SelectAB==TRUE)
	{
	
		switch(Request)
		{
		case 1: // Recent Faults
			FtpReq_Number=2;
			nvo04WaysideReqB.request=Request;
			nvo04WaysideReqB.time_stamp=DefaultTime;
			break;
		
		case 2: // Historical Faults // 1,2로 받아서 2로 올경우 +1를함  Historical Faults로 요청
			FtpReq_Number=3;
			nvo04WaysideReqB.request=Request+1;
			nvo04WaysideReqB.time_stamp=ReceivedTime;
			break;
		}
	}
}

void SendTime()
{
	TempTime[0]=OutBuffer[FtpLength-8]; //TimeStamp Low 1
	TempTime[1]=OutBuffer[FtpLength-9]; //TimeStamp Low 2
	TempTime[2]=OutBuffer[FtpLength-10]; //TimeStamp HI 1
	TempTime[3]=OutBuffer[FtpLength-11];  //TimeStamp HI 2
	
	LowByte=make_long(TempTime[0],TempTime[1]);
	HiByte=make_long(TempTime[2],TempTime[3]);
	
	s32_from_ulong((unsigned long) 65535, (s32_type *) &s32Var);
	s32_from_ulong((unsigned long) HiByte, (s32_type *) &s32Hi);
	s32_from_ulong((unsigned long) LowByte, (s32_type *) &s32Low);
	s32_mul(&s32Hi,&s32Var,&ReceivedTime);
	s32_add(&s32Hi,&ReceivedTime,&ReceivedTime);
	s32_add(&s32Low,&ReceivedTime,&ReceivedTime);
	
	if(CarType==FALSE && WaysideType==1) // FALSE : Single Car Recent
	{	     
		nvo04WaysideReqA.request=FtpReq_Number;
		nvo04WaysideReqA.time_stamp=ReceivedTime;
		propagate(nvo04WaysideReqA);
		
		// FTP END
		OutBuffer[0]=STX;
		OutBuffer[1]=0x06;
		OutBuffer[2]=0x00;
		OutBuffer[3]=0x00;
		OutBuffer[4]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3];
		OutBuffer[5]=ETX;
		TxSend(6);  
		FtpRunning=FALSE;  
	}
	
	else if(CarType==TRUE && WaysideType==1) // Married pair Car Recent
	{	     
		if(SelectAB==FALSE)
		{  
			nvo04WaysideReqA.request=FtpReq_Number;
			nvo04WaysideReqA.time_stamp=ReceivedTime;
			propagate(nvo04WaysideReqA);
		}
		else if(SelectAB==TRUE)
		{ 
			nvo04WaysideReqB.request=FtpReq_Number;
			nvo04WaysideReqB.time_stamp=ReceivedTime;
			propagate(nvo04WaysideReqB);
		}
	
		// FTP END
		OutBuffer[0]=STX;
		OutBuffer[1]=0x06;
		OutBuffer[2]=0x00;
		OutBuffer[3]=0x00;
		OutBuffer[4]=OutBuffer[1]^OutBuffer[2]^OutBuffer[3];
		OutBuffer[5]=ETX;
		TxSend(6);  
		FtpRunning=FALSE;  
	}
	else if(CarType==FALSE && WaysideType==2 ) // Single Car Historical
	{
		nvo04WaysideReqA.request=FtpReq_Number;
		nvo04WaysideReqA.time_stamp=ReceivedTime;
		propagate(nvo04WaysideReqA);
		
		WaySideOn(WaysideType);
	}
	else if(CarType==TRUE && WaysideType==2 )// Married pair Historical
	{
		if(SelectAB==FALSE)
		{  
			nvo04WaysideReqA.request=FtpReq_Number;
			nvo04WaysideReqA.time_stamp=ReceivedTime;
			propagate(nvo04WaysideReqA);
		}
		else if(SelectAB==TRUE)
		{ 
			nvo04WaysideReqB.request=FtpReq_Number;
			nvo04WaysideReqB.time_stamp=ReceivedTime;
			propagate(nvo04WaysideReqB);
		}
		WaySideOn(WaysideType);
	}
}

void Interrupt(void)
{
	io_out(OutInetrupt, FALSE); //Interrupt occure
	io_out(OutInetrupt, TRUE);
}

char CheckSum(int NumSel)
{ 
	int i;
	char Check;
	switch(NumSel)
	{
	case 1:
		Check=InBuffer[1];
		for (i = 2; i < InChars-2; i++) {Check=Check^InBuffer[i];}
		break;
	case 2:
		Check=OutBuffer[1];
		for (i = 2; i < OutChars-2; i++) {Check=Check^OutBuffer[i];} // DataLenth +2 Byte
		break;
	}
	return Check; //return Checksum value
}

void ErrorStatus(void) //StatusBits Update
{
	if(nvi01Subscribe.param_id==0)
	{
		StatusCopy.st.bit0=(ErrorBuffer[4]&0x01)?1:0; //VTX
		StatusCopy.st.bit1=(ErrorBuffer[4]&0x02)?1:0; //CNCS
		StatusCopy.st.bit2=(ErrorBuffer[4]&0x04)?1:0; //PAC2
		StatusCopy.st.bit3=(ErrorBuffer[4]&0x08)?1:0; //LIC
		StatusCopy.st.bit4=(ErrorBuffer[4]&0x10)?1:0; //WLAN
		StatusCopy.st.bit5=(ErrorBuffer[4]&0x20)?1:0; //GPS
		StatusCopy.st.bit6=(ErrorBuffer[4]&0x40)?1:0; //PAC1
		StatusCopy.st.bit7=(ErrorBuffer[4]&0x80)?1:0; //Not Use
		
		StatusCopy.st.bit8=(ErrorBuffer[5]&0x01)?1:0; //DPO1
		StatusCopy.st.bit9=(ErrorBuffer[5]&0x02)?1:0; //DPO2
		StatusCopy.st.bit10=(ErrorBuffer[5]&0x04)?1:0; //CCP1
		StatusCopy.st.bit11=(ErrorBuffer[5]&0x08)?1:0; //CCP2
		StatusCopy.st.bit12=(ErrorBuffer[5]&0x10)?1:0; //TRIC1
		StatusCopy.st.bit13=(ErrorBuffer[5]&0x20)?1:0; //TRIC2
		StatusCopy.st.bit14=(ErrorBuffer[5]&0x40)?1:0; //Not Use
		StatusCopy.st.bit15=(ErrorBuffer[5]&0x80)?1:0; //Not Use
		
		StatusCopy.st.bit16=(ErrorBuffer[6]&0x01)?1:0; //CPO1
		StatusCopy.st.bit17=(ErrorBuffer[6]&0x02)?1:0; //CPO2
		StatusCopy.st.bit18=(ErrorBuffer[6]&0x04)?1:0; //CPO3
		StatusCopy.st.bit19=(ErrorBuffer[6]&0x08)?1:0; //CPO4
		StatusCopy.st.bit20=(ErrorBuffer[6]&0x10)?1:0; //Not Use
		StatusCopy.st.bit21=(ErrorBuffer[6]&0x20)?1:0; //Not Use
		StatusCopy.st.bit22=(ErrorBuffer[6]&0x40)?1:0; //Not Use
		StatusCopy.st.bit23=(ErrorBuffer[6]&0x80)?1:0; //Not Use
		
		StatusCopy.st.bit24=(ErrorBuffer[7]&0x01)?1:0; //PEI1
		StatusCopy.st.bit25=(ErrorBuffer[7]&0x02)?1:0; //PEI2
		StatusCopy.st.bit26=(ErrorBuffer[7]&0x04)?1:0; //PEI3
		StatusCopy.st.bit27=(ErrorBuffer[7]&0x08)?1:0; //PEI4
		StatusCopy.st.bit28=(ErrorBuffer[7]&0x10)?1:0; //PEI5
		StatusCopy.st.bit29=(ErrorBuffer[7]&0x20)?1:0; //PEI6
		StatusCopy.st.bit30=(ErrorBuffer[7]&0x40)?1:0; //FDI1
		StatusCopy.st.bit31=(ErrorBuffer[7]&0x80)?1:0; //FDI2
		
		StatusCopy.st.bit32=(ErrorBuffer[8]&0x01)?1:0; //SDI1
		StatusCopy.st.bit33=(ErrorBuffer[8]&0x02)?1:0; //SDI2
		StatusCopy.st.bit34=(ErrorBuffer[8]&0x04)?1:0; //SDI3
		StatusCopy.st.bit35=(ErrorBuffer[8]&0x08)?1:0; //SDI4
		StatusCopy.st.bit36=(ErrorBuffer[8]&0x10)?1:0; //SDI5
		StatusCopy.st.bit37=(ErrorBuffer[8]&0x20)?1:0; //SDI6
		StatusCopy.st.bit38=(ErrorBuffer[8]&0x40)?1:0; //SDI7
		StatusCopy.st.bit39=(ErrorBuffer[8]&0x80)?1:0; //SDI8
		
		StatusCopy.st.bit40=(ErrorBuffer[9]&0x01)?1:0; //PID1-1
		StatusCopy.st.bit41=(ErrorBuffer[9]&0x02)?1:0; //PID1-2
		StatusCopy.st.bit42=(ErrorBuffer[9]&0x04)?1:0; //PID1-3
		StatusCopy.st.bit43=(ErrorBuffer[9]&0x08)?1:0; //PID1-4
		StatusCopy.st.bit44=(ErrorBuffer[9]&0x10)?1:0; //PID1-5
		StatusCopy.st.bit45=(ErrorBuffer[9]&0x20)?1:0; //PID1-6
		StatusCopy.st.bit46=(ErrorBuffer[9]&0x40)?1:0; //PID1-7
		StatusCopy.st.bit47=(ErrorBuffer[9]&0x80)?1:0; //PID1-8
		
		StatusCopy.st.bit48=(ErrorBuffer[10]&0x01)?1:0; //PID2-1
		StatusCopy.st.bit49=(ErrorBuffer[10]&0x02)?1:0; //PID2-2
		StatusCopy.st.bit50=(ErrorBuffer[10]&0x04)?1:0; //PID2-3
		StatusCopy.st.bit51=(ErrorBuffer[10]&0x08)?1:0; //PID2-4
		StatusCopy.st.bit52=(ErrorBuffer[10]&0x10)?1:0; //PII1
		StatusCopy.st.bit53=(ErrorBuffer[10]&0x20)?1:0; //PII2
		StatusCopy.st.bit54=(ErrorBuffer[10]&0x40)?1:0; //PII3
		StatusCopy.st.bit55=(ErrorBuffer[10]&0x80)?1:0; //PII4
		
		nvo01StatusBits = StatusCopy.st;	// send status
		StatusCopy.b[7]++;					// increment rolling counter
		propagate(nvo01StatusBits);
	}   
}

void Self_Install(void)
{
	NvConfig(); //Network Variable Config
	Location(); //Location Configuration
	AddressTable(); //Address Table Configuration
	DomainTable();
}

void DomainTable(void)
{
	domain_struct domain_copy;
	domain_copy = *(access_domain(0));
	// domain_copy.id=0x01;
	domain_copy.subnet=1;
	domain_copy.len=0;
	domain_copy.node=8;
	update_domain(&domain_copy, 0);
}
//============================================================================================================//

void Location(void)
{
	config_data_struct configure;
	configure = config_data;
	
	if (ee_config_setup == LOCAL_CONFIG_DONE)
	{
		return;
	}
	configure.location[0] = 'C';
	configure.location[1] = 'O';
	configure.location[2] = 'M';
	configure.location[3] = 'M';
	configure.location[4] = ' ';
	configure.location[5] = ' ';
	configure.node_priority = 0;
	configure.non_group_timer = 4;
	configure.nm_auth = 0;
	configure.preemption_timeout = 1;
	update_config_data(&configure);
	watchdog_update();
	
	ee_config_setup = LOCAL_CONFIG_DONE;
   
}
//============================================================================================================//

void AddressTable(void)
{
	address_struct AddrCopy;
	AddrCopy = *(access_address(0)); 
	AddrCopy.sn.type=1;
	AddrCopy.sn.domain=0;
	AddrCopy.sn.node=1;
	AddrCopy.sn.rpt_timer=0;
	AddrCopy.sn.retry=3;
	AddrCopy.sn.tx_timer=4;
	AddrCopy.sn.subnet=1;
	update_address(&AddrCopy, 0);
	watchdog_update();
	
	AddrCopy = *(access_address(1)); 
	AddrCopy.sn.type=1;
	AddrCopy.sn.domain=0;
	AddrCopy.sn.node=1;
	AddrCopy.sn.rpt_timer=0;
	AddrCopy.sn.retry=3;
	//AddrCopy.sn.rcv_timer=0;
	AddrCopy.sn.tx_timer=4;
	AddrCopy.sn.subnet=2;
	update_address(&AddrCopy, 1);
	watchdog_update();
	
	AddrCopy = *(access_address(2)); 
	AddrCopy.bc.type=3;
	AddrCopy.bc.domain=0;
	//AddrCopy.bc.node=0;
	AddrCopy.bc.rpt_timer=3;
	AddrCopy.bc.retry=2;
	//AddrCopy.sn.rcv_timer=0;
	AddrCopy.bc.tx_timer=0;
	AddrCopy.bc.subnet=0;
	update_address(&AddrCopy, 2);
	watchdog_update();
}
//============================================================================================================//

void NvConfig(void)
{
	nv_struct nv_copy;
	nv_copy=*(access_nv(nv_table_index(nci00NetConfig)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x16;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nci00NetConfig));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi00ObjRequest)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x01;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi00ObjRequest));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo00ObjStatus)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x02;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x00;
	update_nv(&nv_copy,nv_table_index(nvo00ObjStatus));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo00TimeStamp)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x03;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=1; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x02;
	update_nv(&nv_copy,nv_table_index(nvo00TimeStamp));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi00FileReqA)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x04;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi00FileReqA));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo00FileStatA)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x05;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x00;
	update_nv(&nv_copy,nv_table_index(nvo00FileStatA));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi00FileReqB)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x84;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi00FileReqB));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo00FileStatB)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x85;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x01;
	update_nv(&nv_copy,nv_table_index(nvo00FileStatB));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi00CDTCommand)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x11;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi00CDTCommand));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi01Subscribe)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x06;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi01Subscribe));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi01TransfState)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x09;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi01TransfState));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo01StatusBits)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x0A;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x00;
	update_nv(&nv_copy,nv_table_index(nvo01StatusBits));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo01StatusBits2)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x0B;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x00;
	update_nv(&nv_copy,nv_table_index(nvo01StatusBits2));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo01Parameter)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x0C;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x00;
	update_nv(&nv_copy,nv_table_index(nvo01Parameter));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi01CDTStBitsA)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x08;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi01CDTStBitsA));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi01CDTStBitsB)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x88;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi01CDTStBitsB));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi01CDTParamA)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x07;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi01CDTParamA));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi01CDTParamB)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x87;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi01CDTParamB));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi03SCIVersReq)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x0F;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi03SCIVersReq));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo03SCIVersion)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x08;
	nv_copy.nv_selector_lo =0x10;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x00;
	update_nv(&nv_copy,nv_table_index(nvo03SCIVersion));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo04WaysideReqA)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x14;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x00;
	update_nv(&nv_copy,nv_table_index(nvo04WaysideReqA));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi04WaysidRespA)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x15;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi04WaysidRespA));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvo04WaysideReqB)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=1; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x94;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x01;
	update_nv(&nv_copy,nv_table_index(nvo04WaysideReqB));
	watchdog_update();
	//////////////////////////////////////////////////////////////////
	nv_copy=*(access_nv(nv_table_index(nvi04WaysidRespB)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=0; //0 : INPUT 1: OUTPUT
	nv_copy.nv_selector_hi =0x01;
	nv_copy.nv_selector_lo =0x95;
	nv_copy.nv_turnaround=0; // 1:TurnAround
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	nv_copy.nv_auth=0;
	nv_copy.nv_addr_index=0x0F;
	update_nv(&nv_copy,nv_table_index(nvi04WaysidRespB));
	watchdog_update();
}

//**************************************************************************************************//
//                                       FTP Function                                              //
//**************************************************************************************************//

FxData fx = {NULL_HANDLE};

mtimer fx_operation_timer;   

void start_transfer(file_request_t request) 
{
	if((CarType==FALSE && SelectAB==FALSE) || (CarType==TRUE && SelectAB==FALSE)){ 
		fx.auth_on = nvi00FileReqA.auth_on;
		{
			fx_operation_timer = nvi00FileReqA.receive_timeout;
		}
		nvo00FileStatA.status = START_STATE(request);
	}
	
	else if((CarType==FALSE && SelectAB==TRUE) || (CarType==TRUE && SelectAB==TRUE)){    
		fx.auth_on = nvi00FileReqB.auth_on;
		{
			fx_operation_timer = nvi00FileReqB.receive_timeout;
		}
		nvo00FileStatB.status = START_STATE(request);
	}
}

void stop_transfer(file_status_t status)
{

	io_out(LED8, LED_ON);
	
	if (!CLOSE_STATUS(status) && fx.pending_status)  {
	
		status = fx.pending_status;
	}
	
	fx.pending_status = 0;
	
	if (CLOSE_STATUS(status))  {
		close(fx.handle, status != FS_CLOSE && status != FS_XFER_OK);
		fx_operation_timer = 0;
		fx.handle = NULL_HANDLE;
	} else {
		fx_operation_timer = FILE_INITIATOR_CLOSE_TIMEOUT;
		fx.pending_status = FS_CLOSE;
	}
	if((CarType==FALSE && SelectAB==FALSE) || (CarType==TRUE && SelectAB==FALSE)){
		nvo00FileStatA.status = status & FS_EXTERNAL_STATE_MASK;
	} 
	
	else if((CarType==FALSE && SelectAB==TRUE) || (CarType==TRUE && SelectAB==TRUE)){
		nvo00FileStatB.status = status & FS_EXTERNAL_STATE_MASK;
	} 

}

void process_packet(void)
{
	if ((msg_in.data[0] & FILE_PACKET_MASK) == fx.pkt_in_window)  {
	
	bytes_received = min(FILE_PACKET_SIZE, msg_in.len - 1);
	
	if (bytes_received >= 0 ) 
	{    		  
		FtpLength=bytes_received+8;
		
		OutBuffer[0]=STX;
		OutBuffer[1]=0x05;
		OutBuffer[3]=bytes_received; // Data Length
		if(SelectAB==FALSE){ OutBuffer[4]=0x41; }
		else if(SelectAB==TRUE){  OutBuffer[4]=0x42; }
		
		memcpy( &OutBuffer[5],&msg_in.data[1], bytes_received);          
		OutBuffer[bytes_received+5]=0xFF; //None ChechSum
		OutBuffer[bytes_received+6]=ETX;
		
		switch(fx.pkt_in_window)
		{
		case 0:
			OutBuffer[2]=0x01; //Message Code
			memset(pData->DataAddress,0x01,1); // Data Address Set
			memcpy(pData->FtpData1,OutBuffer,FtpLength);
			Interrupt();
			break;
		case 1:
			OutBuffer[2]=0x02; //Message Code
			memset(pData->DataAddress,0x02,1); // Data Address Set
			memcpy(pData->FtpData2,OutBuffer,FtpLength);
			Interrupt();    
			break;
		case 2:
			OutBuffer[2]=0x03; //Message Code
			memset(pData->DataAddress,0x03,1); // Data Address Set
			memcpy(pData->FtpData3,OutBuffer,FtpLength);
			Interrupt();       
			break;
		case 3:
			OutBuffer[2]=0x04; //Message Code
			memset(pData->DataAddress,0x04,1); // Data Address Set
			memcpy(pData->FtpData4,OutBuffer,FtpLength);
			Interrupt();         
			break;
		case 4:
			OutBuffer[2]=0x05; //Message Code
			memset(pData->DataAddress,0x05,1); // Data Address Set
			memcpy(pData->FtpData5,OutBuffer,FtpLength);
			Interrupt();      
			break;
		case 5: 
			OutBuffer[2]=0x06; //Message Code
			memset(pData->DataAddress,0x06,1); // Data Address Set
			memcpy(pData->FtpData6,OutBuffer,FtpLength);
			Interrupt();    
			break;
		}   
	
	}
	
	fx.pkt_in_window++;  
	
	}
	 
}

boolean setup_status_address(void)
{
	int valid;
	domain_struct domain;
	valid = TRUE;
	FtpRunning=TRUE;
	
	if((CarType==FALSE && SelectAB==FALSE) || (CarType==TRUE && SelectAB==FALSE)){     
		nvo00FileStatA.adr.address.subnet = nv_in_addr.src_addr.subnet;
		nvo00FileStatA.adr.address.node = nv_in_addr.src_addr.node;
		domain = *access_domain(nv_in_addr.domain);
		nvo00FileStatA.adr.address.domain_length = domain.len;
	}
	if((CarType==FALSE && SelectAB==TRUE) || (CarType==TRUE && SelectAB==TRUE)){   
		nvo00FileStatB.adr.address.subnet = nv_in_addr.src_addr.subnet;
		nvo00FileStatB.adr.address.node = nv_in_addr.src_addr.node;
		domain = *access_domain(nv_in_addr.domain);
		nvo00FileStatB.adr.address.domain_length = domain.len;
	}
	
	if (nv_in_addr.flex_domain)  {
	if((CarType==FALSE && SelectAB==FALSE) || (CarType==TRUE && SelectAB==FALSE)){  
		nvo00FileStatA.adr.address.domain_length = 0xff; 
	}
	else if((CarType==FALSE && SelectAB==TRUE) || (CarType==TRUE && SelectAB==TRUE)){ 
		nvo00FileStatB.adr.address.domain_length = 0xff;
	}
	valid = FALSE;
	} else {
	
	#pragma warnings_off
	#pragma relaxed_casting_on
	#define	DOMAIN_LEN_MASK	0x07
	
	if((CarType==FALSE && SelectAB==FALSE) || (CarType==TRUE && SelectAB==FALSE)){ 
		memcpy( (void *) nvo00FileStatA.adr.address.domain_id, domain.id, domain.len & DOMAIN_LEN_MASK );
	}
	else if((CarType==FALSE && SelectAB==TRUE) || (CarType==TRUE && SelectAB==TRUE)){
		memcpy( (void *) nvo00FileStatB.adr.address.domain_id, domain.id, domain.len & DOMAIN_LEN_MASK );
	}
	#pragma relaxed_casting_off
	#pragma warnings_on
	
	}
	return valid;
}

////////////////////////////////////////////////////////////////
//      Common when clauses
////////////////////////////////////////////////////////////////

when (timer_expires(fx_operation_timer))
{
	stop_transfer(FS_TIMEOUT_ERR);
}

when (nv_update_occurs(nvi00FileReqA)) // FALSE : Single Car or Car A of married pair
{
	file_descriptor local_descriptor;

	if (CLOSE(nvi00FileReqA.request) ?
		(nvi00FileReqA.index != nvo00FileStatA.selected_file) :
		(fx.handle != NULL_HANDLE))  {
		return;
	}

    nvo00FileStatA.number_of_files = NUM_FILES; // always return this info
	nvo00FileStatA.selected_file = nvi00FileReqA.index;

#ifndef ENABLE_RA
	if (nvi00FileReqA.request == FR_OPEN_TO_RECEIVE_RA || nvi00FileReqA.request == FR_OPEN_TO_SEND_RA)  {
		setup_status_address();
		nvo00FileStatA.status = FS_ACCESS_UNAVAIL;
		return;
	}
	else if (nvi00FileReqA.request == FR_OPEN_TO_RECEIVE ||
			nvi00FileReqA.request == FR_OPEN_TO_SEND	)  {
#else
	if (nvi00FileReqA.request == FR_OPEN_TO_RECEIVE_RA ||
		nvi00FileReqA.request == FR_OPEN_TO_SEND_RA	||	
		nvi00FileReqA.request == FR_OPEN_TO_RECEIVE 	||
		nvi00FileReqA.request == FR_OPEN_TO_SEND	)  {
#endif	// enable_ra

		if (!setup_status_address())return;
	
		// Init state information
		memset(&fx, 0, sizeof(fx));

		fx.req_type = nvi00FileReqA.request;
		fx.handle = open(nvi00FileReqA.index, fx.req_type);
		if (fx.handle < 0)  {
			nvo00FileStatA.status = FS_OPEN_FAIL;      // could not open file
			return;
		}

		// Begin transfer process
		start_transfer(fx.req_type);
	}
	else if (nvi00FileReqA.request == FR_CLOSE_FILE)  {
		stop_transfer(FS_CLOSE);
//*********************************************************************//
//END FTP LOGIC

	SendTime();
	
//*********************************************************************//	
	}
	else if (nvi00FileReqA.request == FR_CLOSE_DELETE_FILE)  {
		stop_transfer(FS_FAILURE);
	}
	else if (nvi00FileReqA.request == FR_DIRECTORY_LOOKUP)  {
		// Assume indices are numbered 0..N-1.
		if (nvi00FileReqA.index >= NUM_FILES)  {
			nvo00FileStatA.status = FS_LOOKUP_ERR;
		} else {
			// Return directory information from file system
			local_descriptor = * lookup(nvi00FileReqA.index);

			#pragma warnings_off
			#pragma relaxed_casting_on

			memcpy( (void *)nvo00FileStatA.adr.descriptor.file_info, local_descriptor.info, FILE_INFO_SIZE );
			
			#pragma relaxed_casting_off
			#pragma warnings_on

			nvo00FileStatA.adr.descriptor.size = local_descriptor.size.s32size;
			nvo00FileStatA.adr.descriptor.type = local_descriptor.type;
			nvo00FileStatA.status = FS_LOOKUP_OK;
		}
	}
}

when (nv_update_occurs(nvi00FileReqB)) // TRUE : Car B of Married pair 
{
	file_descriptor local_descriptor;

	if (CLOSE(nvi00FileReqB.request) ?
		(nvi00FileReqB.index != nvo00FileStatB.selected_file) :
		(fx.handle != NULL_HANDLE))  {
		return;
	}

    nvo00FileStatB.number_of_files = NUM_FILES; // always return this info
	nvo00FileStatB.selected_file = nvi00FileReqB.index;

#ifndef ENABLE_RA
	if (nvi00FileReqB.request == FR_OPEN_TO_RECEIVE_RA || nvi00FileReqA.request == FR_OPEN_TO_SEND_RA)  {
		// Return an error if we don't support random access
		setup_status_address();
		nvo00FileStatB.status = FS_ACCESS_UNAVAIL;
		return;
	}
	else if (nvi00FileReqB.request == FR_OPEN_TO_RECEIVE ||
			nvi00FileReqB.request == FR_OPEN_TO_SEND	)  {
#else
	if (nvi00FileReqB.request == FR_OPEN_TO_RECEIVE_RA ||
		nvi00FileReqB.request == FR_OPEN_TO_SEND_RA	||	
		nvi00FileReqB.request == FR_OPEN_TO_RECEIVE 	||
		nvi00FileReqB.request == FR_OPEN_TO_SEND	)  {
#endif	// enable_ra

		if (!setup_status_address())
			return;
	
		// Init state information
		memset(&fx, 0, sizeof(fx));

		fx.req_type = nvi00FileReqB.request;
		fx.handle = open(nvi00FileReqB.index, fx.req_type);
		if (fx.handle < 0)  {
			nvo00FileStatB.status = FS_OPEN_FAIL;      // could not open file
			return;
		}

		// Begin transfer process
		start_transfer(fx.req_type);
	}
	else if (nvi00FileReqB.request == FR_CLOSE_FILE)  {
		stop_transfer(FS_CLOSE);
//*********************************************************************//
//END FTP LOGIC

	SendTime();

//*********************************************************************//	
	}
	else if (nvi00FileReqB.request == FR_CLOSE_DELETE_FILE)  {
		stop_transfer(FS_FAILURE);
	}
	else if (nvi00FileReqB.request == FR_DIRECTORY_LOOKUP)  {
		// Assume indices are numbered 0..N-1.
		if (nvi00FileReqB.index >= NUM_FILES)  {
			nvo00FileStatB.status = FS_LOOKUP_ERR;
		} else {
			// Return directory information from file system
			local_descriptor = * lookup(nvi00FileReqB.index);

			#pragma warnings_off
			#pragma relaxed_casting_on
			
			memcpy( (void *)nvo00FileStatB.adr.descriptor.file_info, local_descriptor.info, FILE_INFO_SIZE );
			
			#pragma relaxed_casting_off
			#pragma warnings_on

			nvo00FileStatB.adr.descriptor.size = local_descriptor.size.s32size;
			nvo00FileStatB.adr.descriptor.type = local_descriptor.type;
			nvo00FileStatB.status = FS_LOOKUP_OK;
		}
	}
}

when (msg_arrives)
{
	unsigned received_window_number;
	
	switch( msg_in.code ) 
	{
	
	case FILE_MSG_CODE:
	
		if (fx.handle == NULL_HANDLE) return; 
		if(CarType==FALSE){ fx_operation_timer = nvi00FileReqA.receive_timeout; } 
		// reset timer // FALSE : Single Car or Car A of married pair
		else if(CarType==TRUE){ fx_operation_timer = nvi00FileReqB.receive_timeout;} 
		// TRUE : Car B of Married pair 
		
		received_window_number = msg_in.data[ 0 ] & 0xF0;
		
		if (received_window_number == fx.window_number && msg_in.service == REQUEST) 
		{
			if((msg_in.len - 1)==1)
			{
				resp_out.code = fx.pkt_in_window;  
				resp_send();  
				stop_transfer(FS_CLOSE);
				return; 
			}
			else
			{
				process_packet( );
				msec_delay(20);
				resp_out.code = fx.pkt_in_window;  
				resp_send();  
				
				if (bytes_received < 128)  
				{
					stop_transfer(FS_CLOSE);
				} 
				return; 
			}
		}
		
		if (received_window_number == fx.window_number) {
			process_packet( );
			return;
		}
		
		if (received_window_number == (fx.window_number+FILE_WINDOW_INC)) 
		{
			if ((fx.pkt_in_window==FILE_WINDOW_SIZE) || fx.end_of_exchange) 
			{
				fx.window_number = received_window_number;   
				fx.pkt_in_window = 0;                        
				fx.end_of_exchange = FALSE;
				process_packet( );
				return;
			
			} else {
				stop_transfer( FS_WINDOW_ERR );
				return;     
			}
		} else {        
			stop_transfer( FS_WINDOW_ERR );
			return;
		}
		break;
		
		default:        // ****** Handle other incoming messages here
		break;
	}
}


