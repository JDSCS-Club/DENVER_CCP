
//**************************************************************************************************//
//                                       Pragma Declarations                                        //
//**************************************************************************************************//
#pragma enable_sd_nv_names
#pragma set_node_sd_string "COMM, WOOJIN, LIC, 2012-05-17"
#pragma set_id_string "COMM"
#pragma num_alias_table_entries 10
#pragma num_addr_table_entries 10
#pragma run_unconfigured  
#pragma net_buf_in_size 146 
#pragma app_buf_in_size 146 
#pragma net_buf_out_size 146 
#pragma app_buf_out_size 146 

//**************************************************************************************************//
//                                       Include Declarations                                       //
//**************************************************************************************************//
#include <addrdefs.h>
#include <access.h>
#include <msg_addr.h>
#include <s32.h>
#include <nm_ste.h>
#include <control.h>
#include <io_types.h>
#include <netmgmt.h>
#include <status.h>
#include <SNVT_fr.h>
#include <SNVT_fs.h>
#include "COMM.h"

//**************************************************************************************************//
//                                    Constant Declarations                                 //
//**************************************************************************************************//
#define MAX_IN 20
#define MAX_OUT 134
#define	STX	0x02
#define	ETX	0x03
#define	ReadCmd	0x80
#define	WriteCmd 0x00
#define ENABLE_RECEIVER
#define TURNAROUND 4
#define TIMESTAMP_RATE 3600 
// Status update rate timing
#define MIN_STATUS_RATE		500	// msec
#define DEFAULT_STATUS_RATE	9000	// msec
#define INPUT 0
#define OUTPUT 1
//**************************************************************************************************//
//                                           I/O Declarations                                       //
//**************************************************************************************************//

IO_0 input bit InInetrupt; //MCU->FT Interrupt
IO_1 output bit OutInetrupt=1; //FT->MCU Interrupt
IO_7 output bit ioSelect = 1;
IO_8 spi master clock(0) clockedge(-) ioRTx;

//**************************************************************************************************//
//                                       Timer Declarations                                         //
//**************************************************************************************************//

mtimer repeating StatusTimer=DEFAULT_STATUS_RATE;
stimer repeating SilenceTimer;
stimer repeating ClockTimer=3600; //1Hour Timer

//**************************************************************************************************//
//                                    Network Variable Declarations                                 //
//**************************************************************************************************//
config network input sd_string("&0,,0\x90,25;")int nci00NetConfig;
far network input sd_string("@0|1") SNVT_obj_request nvi00ObjRequest;
far network output sd_string("@0|2") SNVT_obj_status nvo00ObjStatus;
far network input sd_string("@0|3") UNVT_CDT_command nvi00CDTCommand;
far network output sd_string("@0|4") SNVT_time_stamp nvo00TimeStamp;
far network input sd_string("@0|5") SNVT_file_req nvi00FileReq;
far network output sd_string("@0|6") SNVT_file_status nvo00FileStat;
far network input sd_string("@1|1") UNVT_subscribe nvi01Subscribe;
far network output sync sd_string("@1|2") SNVT_state_64 nvo01StatusBits;
far network output sync sd_string("@1|3") SNVT_state_64 nvo01StatusBits2;
far network input sd_string("@1|4") SNVT_state nvi01TransfState;
far network output sd_string("@1|5") UNVT_parameter nvo01Parameter;
far network input sync sd_string("@1|6") SNVT_state_64 nvi01CDTStBits;
far network input sd_string("@1|8") UNVT_parameter nvi01CDTParam;
far network input sd_string("@3|1") UNVT_sci_version_request nvi03SCIVersReq;
far network output sd_string("@3|2") UNVT_sci_version nvo03SCIVersion;
far network input sd_string("@4|1") UNVT_wayside_response nvi04WaysideResp;
far network output sd_string("@4|2") UNVT_wayside_request nvo04WaysideReq;

eeprom unsigned long ee_config_setup = NOT_LOCAL_CONFIG;

//**************************************************************************************************//
//                                    Global variable define                                        //
//**************************************************************************************************//
boolean FtpRunning=FALSE;
char CarType=0x41; // 0x41 : Single Car or Car A of married pair // 0x42 : Car B of Married pair 
char _Checksum,CarNumner,WaysideType;;

InData InBuffer;
OutData OutBuffer;
far char BuildVersion[6];
far char ErrorBuffer[MAX_IN];

unsigned int FtpLength;
unsigned bytes_received;

union { SNVT_state_64 st; unsigned short b[8]; } StatusCopy;
unsigned short	StatErrCount,SCI_INDEX;
far s32_type DefaultTime,ReceivedTime;
long LowByte,HiByte;
   
extern system void _change_state(int state);

//**************************************************************************************************//
//                                         Function                                                 //
//**************************************************************************************************//

void Self_Install(void)
{
 DomainTable();
 AddressTable(); //Address Table Configuration
 NvConfig(); //Network Variable Config
 Location(); //Location Configuration
}

void DomainTable(void)
{// : Domain Setting Refer to DDN-0432-0080 section 5.1 for domain configuration details.
  domain_struct domain;
  domain= *access_domain(0);
  memset(&domain, 0, sizeof(domain));
  memset(domain.key, 0xFF, 8); //AUTHENTICATION code (Default)
  domain.len = 1; //////// Domain length
  domain.node = 8; /////// Node address 1
  domain.subnet = 1; ////// Subnet address	
  update_domain(&domain, 0); //Set domain with upper parameters 
  watchdog_update();	
}

void Location(void)
{// : Loacation Setting DDN-T097-0091-R03 p18
  config_data_struct configure;
  configure = config_data;
  
  if (ee_config_setup == LOCAL_CONFIG_DONE)
  { return;}
  
  configure.location[0] = 'C';  configure.location[1] = 'O';  configure.location[2] = 'M'; configure.location[3] = 'M'; configure.location[4] = ' ';
  if(CarNumner==0xA1)// Car A 
  {configure.location[5] = 'A';}
  else if(CarNumner==0xA2)//Car B
  {configure.location[5] = 'B';}
  
  configure.node_priority = 0; configure.non_group_timer = 4; configure.nm_auth = 0; configure.preemption_timeout = 1;
  update_config_data(&configure);
  watchdog_update(); 
  ee_config_setup = LOCAL_CONFIG_DONE;  
}

void AddressTable(void)
{ // : Address Table Setting DDN-T097-0091-R03 p18
 address_struct AddrCopy;
 AddrCopy = *(access_address(0));
 AddrCopy.sn.type=1; AddrCopy.sn.domain=0; AddrCopy.sn.node=1; AddrCopy.sn.rpt_timer=0;
 AddrCopy.sn.retry=3; AddrCopy.sn.tx_timer=4; AddrCopy.sn.subnet=1; update_address(&AddrCopy, 0);
 watchdog_update();
 
 AddrCopy = *(access_address(1)); 
 AddrCopy.sn.type=1; AddrCopy.sn.domain=0; AddrCopy.sn.node=1; AddrCopy.sn.rpt_timer=0;
 AddrCopy.sn.retry=3; AddrCopy.sn.tx_timer=4; AddrCopy.sn.subnet=2; update_address(&AddrCopy, 1);
 watchdog_update();
 
 AddrCopy = *(access_address(2)); 
 AddrCopy.bc.type=3; AddrCopy.bc.domain=0; AddrCopy.bc.rpt_timer=3; AddrCopy.bc.retry=3;
 AddrCopy.bc.tx_timer=0; AddrCopy.bc.subnet=0; update_address(&AddrCopy, 2);
 watchdog_update();
}

void NvConfig(void)
{// : NV Setting DDN-T097-0091-R03 p19
  nv_struct nv_copy;
  nv_copy=*(access_nv(nv_table_index(nci00NetConfig)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x16;nv_copy.nv_addr_index=0x0F;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x96;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nci00NetConfig));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi00ObjRequest)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x01;nv_copy.nv_addr_index=0x0F;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x81;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi00ObjRequest));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvo00ObjStatus)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x02;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x82;nv_copy.nv_addr_index=0x00;}
  update_nv(&nv_copy,nv_table_index(nvo00ObjStatus));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi00FileReq)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x04;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x84;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi00FileReq));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvo00FileStat)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2 //2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x09;nv_copy.nv_selector_lo =0x05;nv_copy.nv_addr_index=0x0F;} 
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x09;nv_copy.nv_selector_lo =0x85;nv_copy.nv_addr_index=0x00;}
  update_nv(&nv_copy,nv_table_index(nvo00FileStat));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi00CDTCommand)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x11;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x91;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi00CDTCommand));
  watchdog_update();
//******************************************************************************************
// Selector Not defind
  nv_copy=*(access_nv(nv_table_index(nvo00TimeStamp)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=1; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x11;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x91;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvo00TimeStamp));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi01Subscribe)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x06;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x86;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi01Subscribe));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi01TransfState)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x09;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x09;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi01TransfState));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvo01StatusBits)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x0A;nv_copy.nv_addr_index=0x0F;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x8A;nv_copy.nv_addr_index=0x00;}
  update_nv(&nv_copy,nv_table_index(nvo01StatusBits));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvo01StatusBits2)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x0B;nv_copy.nv_addr_index=0x0F;} 
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x8B;nv_copy.nv_addr_index=0x00;}
  update_nv(&nv_copy,nv_table_index(nvo01StatusBits2));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvo01Parameter)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2 //2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x0C;nv_copy.nv_addr_index=0x0F;} 
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x8C;nv_copy.nv_addr_index=0x00;}
  update_nv(&nv_copy,nv_table_index(nvo01Parameter));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi01CDTStBits)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2 
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x08;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x88;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi01CDTStBits));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi01CDTParam)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x07;nv_copy.nv_addr_index=0x0F;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x87;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi01CDTParam));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi03SCIVersReq)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x0F;nv_copy.nv_addr_index=0x0F;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x8F;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi03SCIVersReq));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvo03SCIVersion)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x10;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x08;nv_copy.nv_selector_lo =0x90;nv_copy.nv_addr_index=0x00;}
  update_nv(&nv_copy,nv_table_index(nvo03SCIVersion));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvo04WaysideReq)));
  nv_copy.nv_direction=OUTPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x14;nv_copy.nv_addr_index=0x00;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x94;nv_copy.nv_addr_index=0x01;}
  update_nv(&nv_copy,nv_table_index(nvo04WaysideReq));
  watchdog_update();
//******************************************************************************************
  nv_copy=*(access_nv(nv_table_index(nvi04WaysideResp)));
  nv_copy.nv_direction=INPUT;
  nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
  if(CarNumner==0xA1)// Car A 
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x15;nv_copy.nv_addr_index=0x0F;}
  else if(CarNumner==0xA2)//Car B
  {nv_copy.nv_selector_hi =0x01;nv_copy.nv_selector_lo =0x95;nv_copy.nv_addr_index=0x0F;}
  update_nv(&nv_copy,nv_table_index(nvi04WaysideResp));
  watchdog_update();
}

void TxSend(unsigned long Address,unsigned short BufNum)
{ // : Data Transfer to MCU
   char SelectAddress[5];
   io_out(ioSelect, FALSE);
   io_out(ioSelect, TRUE);
   SelectAddress[0]=0x00;
   SelectAddress[1]=0x00;
   SelectAddress[2]=0x00;
   SelectAddress[3]=0x00;
   SelectAddress[4]=BufNum;
   io_out(ioRTx,&SelectAddress,5);
 //**************************************** Address select
   msec_delay(1);
   io_out(ioSelect, FALSE);
   io_out(ioSelect, TRUE);
   OutBuffer.Address[0]=WriteCmd;
   OutBuffer.Address[1]=high_byte(Address);
   OutBuffer.Address[2]=low_byte(Address);
   OutBuffer.Address[3]=0x00;
   io_out(ioRTx,&OutBuffer,OutBuffer.Length+10);
   msec_delay(2);
   io_out(OutInetrupt, FALSE); //Interrupt occure
   io_out(OutInetrupt, TRUE);

}

void ErrorStatus(void) //StatusBits Update
{
  if(nvi01Subscribe.param_id==0 && FtpRunning==FALSE)
  {
   StatusCopy.st.bit0=(ErrorBuffer[0]&0x01)?1:0; //CNCS
   StatusCopy.st.bit1=(ErrorBuffer[0]&0x02)?1:0; //VTX
   StatusCopy.st.bit2=(ErrorBuffer[0]&0x04)?1:0; //LIC
   StatusCopy.st.bit3=(ErrorBuffer[0]&0x08)?1:0; //PAC
   StatusCopy.st.bit4=(ErrorBuffer[0]&0x10)?1:0; //WLR
   StatusCopy.st.bit5=(ErrorBuffer[0]&0x20)?1:0; //GPS
   StatusCopy.st.bit6=(ErrorBuffer[0]&0x40)?1:0; //VOIPC
   StatusCopy.st.bit7=(ErrorBuffer[0]&0x80)?1:0; //CCP1
  
   StatusCopy.st.bit8=(ErrorBuffer[1]&0x01)?1:0; //SDI4
   StatusCopy.st.bit9=(ErrorBuffer[1]&0x02)?1:0; //SDI3
   StatusCopy.st.bit10=(ErrorBuffer[1]&0x04)?1:0; //SDI2
   StatusCopy.st.bit11=(ErrorBuffer[1]&0x08)?1:0; //SDI1
   StatusCopy.st.bit12=(ErrorBuffer[1]&0x10)?1:0; //PII2
   StatusCopy.st.bit13=(ErrorBuffer[1]&0x20)?1:0; //PII1
   StatusCopy.st.bit14=(ErrorBuffer[1]&0x40)?1:0; //FDI
   StatusCopy.st.bit15=(ErrorBuffer[1]&0x80)?1:0; //Unused
  
   StatusCopy.st.bit16=(ErrorBuffer[2]&0x01)?1:0; //PID2-1
   StatusCopy.st.bit17=(ErrorBuffer[2]&0x02)?1:0; //PID1-4
   StatusCopy.st.bit18=(ErrorBuffer[2]&0x04)?1:0; //PID1-3
   StatusCopy.st.bit19=(ErrorBuffer[2]&0x08)?1:0; //PID1-2
   StatusCopy.st.bit20=(ErrorBuffer[2]&0x10)?1:0; //PID1-1
   StatusCopy.st.bit21=(ErrorBuffer[2]&0x20)?1:0; //Unused
   StatusCopy.st.bit22=(ErrorBuffer[2]&0x40)?1:0; //Unused
   StatusCopy.st.bit23=(ErrorBuffer[2]&0x80)?1:0; //Unused
  
   StatusCopy.st.bit24=(ErrorBuffer[3]&0x01)?1:0; //PEI1
   StatusCopy.st.bit25=(ErrorBuffer[3]&0x02)?1:0; //PEI2
   StatusCopy.st.bit26=(ErrorBuffer[3]&0x04)?1:0; //Unused
   StatusCopy.st.bit27=(ErrorBuffer[3]&0x08)?1:0; //Unused
   StatusCopy.st.bit28=(ErrorBuffer[3]&0x10)?1:0; //DPO1
   StatusCopy.st.bit29=(ErrorBuffer[3]&0x20)?1:0; //Unused
   StatusCopy.st.bit30=(ErrorBuffer[3]&0x40)?1:0; //Unused
   StatusCopy.st.bit31=(ErrorBuffer[3]&0x80)?1:0; //DPH1
  
   StatusCopy.st.bit32=(ErrorBuffer[4]&0x01)?1:0; //Unused
   StatusCopy.st.bit33=(ErrorBuffer[4]&0x02)?1:0; //Unused
   StatusCopy.st.bit34=(ErrorBuffer[4]&0x04)?1:0; //Unused
   StatusCopy.st.bit35=(ErrorBuffer[4]&0x08)?1:0; //Unused
   StatusCopy.st.bit36=(ErrorBuffer[4]&0x10)?1:0; //Unused
   StatusCopy.st.bit37=(ErrorBuffer[4]&0x20)?1:0; //Unused
   StatusCopy.st.bit38=(ErrorBuffer[4]&0x40)?1:0; //Unused
   StatusCopy.st.bit39=(ErrorBuffer[4]&0x80)?1:0; //Unused

   nvo01StatusBits = StatusCopy.st;	// send status
   StatusCopy.b[7]++;					// increment rolling counter
   propagate(nvo01StatusBits);
 }   
}

void WaySideOn(int Request)
{
  switch(Request)
  {
   //0x01 : Wayside 0x02 : Yard
   case 1: // Recent Faults
           nvo04WaysideReq.request=Request;
           nvo04WaysideReq.time_stamp=DefaultTime;
           WaysideType=0x01;
           break;
  
   case 2: // Historical Faults // 1,2로 받아서 2로 올경우 +1를함 Historical Faults로 요청
           nvo04WaysideReq.request=Request+1;
           nvo04WaysideReq.time_stamp=ReceivedTime;
           WaysideType=0x02;
           break;
   }
}

void MakeTime(long LowByte,long HiByte)
{
   s32_type s32Var,s32Low,s32Hi;
 
   s32_from_ulong((unsigned long) 65535, (s32_type *) &s32Var);
   s32_from_ulong((unsigned long) HiByte, (s32_type *) &s32Hi);
   s32_from_ulong((unsigned long) LowByte, (s32_type *) &s32Low);
   s32_mul(&s32Hi,&s32Var,&ReceivedTime);
   s32_add(&s32Hi,&ReceivedTime,&ReceivedTime);
   s32_add(&s32Low,&ReceivedTime,&ReceivedTime);
   
   if(WaysideType==1) // Wayside Recent Faults
   {	     
    nvo04WaysideReq.request=2; // FTP End
	nvo04WaysideReq.time_stamp=ReceivedTime;
	propagate(nvo04WaysideReq);

    memset(&OutBuffer,0x00,137);
    OutBuffer.stx=STX;
    OutBuffer.Cmd=0x06;
    OutBuffer.MagCode=0x00;
    OutBuffer.Length=0x00;
    OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
    OutBuffer.Data[1]=ETX;
    TxSend(0x04C0,7);
    FtpRunning=FALSE; 
  }
  else if(WaysideType==2) // Yard Historical Faults
  {	     
    nvo04WaysideReq.request=3; // Next FTP Start
	nvo04WaysideReq.time_stamp=ReceivedTime;
	propagate(nvo04WaysideReq); 
  }
}

void SendTime()
{
   char TempTime[4];
   
   TempTime[0]=OutBuffer.Data[FtpLength-4]; //TimeStamp Low 1
   TempTime[1]=OutBuffer.Data[FtpLength-5]; //TimeStamp Low 2
   TempTime[2]=OutBuffer.Data[FtpLength-6]; //TimeStamp HI 1
   TempTime[3]=OutBuffer.Data[FtpLength-7];  //TimeStamp HI 2
   
   LowByte=make_long(TempTime[0],TempTime[1]);
   HiByte=make_long(TempTime[2],TempTime[3]);
   MakeTime(LowByte,HiByte);

}

when (io_changes(InInetrupt))
{ // Data Read from MCU
   int i;
   char SelectAddress[3];
   io_out(ioSelect, FALSE);
   io_out(ioSelect, TRUE);

   SelectAddress[0]=ReadCmd;
   SelectAddress[1]=0x05;
   SelectAddress[2]=0x88;
   SelectAddress[3]=0x00;
   io_out(ioRTx,&SelectAddress,4);
   msec_delay(1); 

//**************************************** Address select
   io_in(ioRTx,&InBuffer,39);
   
   msec_delay(1);
    
   if((InBuffer.stx==STX))
   {
     switch(InBuffer.Cmd)
     {
       case 0x01 : // Wayside On        
                 memset(&OutBuffer,0x00,137);
	             OutBuffer.stx=STX;
  			     OutBuffer.Cmd=0x02;
  			     OutBuffer.MagCode=0x00;
  			     OutBuffer.Length=0x00;
  			     OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
  			     OutBuffer.Data[1]=ETX;
                 TxSend(0x04C0,7);// Wayside ACK
    	
                 HiByte=make_long(InBuffer.Data[3],InBuffer.Data[2]);
                 LowByte=make_long(InBuffer.Data[5],InBuffer.Data[4]);
                 MakeTime(LowByte,HiByte);
			     WaysideType=InBuffer.Data[0];
  			     WaySideOn(WaysideType);
                 break;
       case 0x09 : 
       	         if(FtpRunning==FALSE)
	             {
	              nvo00TimeStamp.year=0x7D0+InBuffer.Data[0];
	              nvo00TimeStamp.month=InBuffer.Data[1];
	              nvo00TimeStamp.day=InBuffer.Data[2];
	              nvo00TimeStamp.hour=InBuffer.Data[3];
	              nvo00TimeStamp.minute=InBuffer.Data[4];
	              nvo00TimeStamp.second=InBuffer.Data[5]; // Time Update  
	              propagate(nvo00TimeStamp);    
	            } 
               break;
       case 0x0B : 
	             if(FtpRunning==FALSE){	       
	              if(nvi01Subscribe.param_id==0)
	              {
	               memcpy(&ErrorBuffer,&InBuffer.Data[0],5);   
	              }
	             }
	             break; 
       case 0x0D : 
                  if(SCI_INDEX==InBuffer.Data[0])
                  {
                   nvo03SCIVersion.sci_index=InBuffer.Data[0];
                   nvo03SCIVersion.sci_type=InBuffer.Data[1];
                   for(i=0; i<9; i++)
                   {
                    nvo03SCIVersion.sci_name[i]=InBuffer.Data[i+2];
                    nvo03SCIVersion.sci_version[i]=InBuffer.Data[i+11];
                    nvo03SCIVersion.build_date[i]=InBuffer.Data[i+20];
                   }
                   nvo03SCIVersion.build_date[8]=InBuffer.Data[31];
                   nvo03SCIVersion.build_date[9]=InBuffer.Data[32];
                   propagate(nvo03SCIVersion); 
                  }
               break; 
     }// end Switch
   
   }
}

//**************************************************************************************************//
//                                       When Function                                              //
//**************************************************************************************************//

when(reset)
{
    watchdog_update();
    StatusTimer=DEFAULT_STATUS_RATE; //Status Timer initialize. 
    CarType=0x41;  //A Car
    CarNumner=0xA1;

    BuildVersion[0]=0x11;
    BuildVersion[1]=0x04;
    BuildVersion[2]=0x20;
    BuildVersion[3]=0x10;
    BuildVersion[4]=0x12;
    BuildVersion[5]=0x10;
    Self_Install();

  	if (power_up()) 
	{
	  //Self_Install();
      _change_state (CNFG_ONLINE);
	}

}
//*****************************************************************************//
// Handle command from CDT
when(nv_update_occurs(nvi00CDTCommand))
{// : Request Current Time from MCU, nvo00TimeStamp Output
    if(nvi00CDTCommand.command_id==1)
    {
        memset(&OutBuffer,0x00,137);
    	OutBuffer.stx=STX;
        OutBuffer.Cmd=0x08;
        OutBuffer.MagCode=0x00;
        OutBuffer.Length=0x00;
        OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
        OutBuffer.Data[1]=ETX;
        TxSend(0x04C0,7);
        ClockTimer=TIMESTAMP_RATE;	// restart hourly timer
    }
}
//*****************************************************************************//

when(nv_update_occurs(nvi01TransfState))
{ //: when use FTP Function, Another Transfer is silent
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
// Handle subscribe from CDT
when (nv_update_occurs(nvi01Subscribe))
{//: Error status update rate set.
  if(nvi01Subscribe.param_id == 0 ) //Status Update 
  { 
    memset(&OutBuffer,0x00,137);
    OutBuffer.stx=STX;
    OutBuffer.Cmd=0x0A;
    OutBuffer.MagCode=0x00;
    OutBuffer.Length=0x00;
    OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
    OutBuffer.Data[1]=ETX;
    TxSend(0x04C0,7);
    ErrorStatus();
    StatusTimer=nvi01Subscribe.update_rate;
  }
}

//*****************************************************************************//
when (nv_update_occurs(nvi01CDTParam))
{//: Car Number transfer by CDT

 if(nvi01CDTParam.param_id==0x05)
 {
   memset(&OutBuffer,0x00,137);
   OutBuffer.stx=STX;
   OutBuffer.Cmd=0x07;
   OutBuffer.MagCode=0x00;
   OutBuffer.Length=0x02;
   OutBuffer.Data[0]=high_byte(nvi01CDTParam.param_value);
   OutBuffer.Data[1]=low_byte(nvi01CDTParam.param_value);
   CarNumner=low_byte(nvi01CDTParam.param_value);
   OutBuffer.Data[2]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length^OutBuffer.Data[0]^OutBuffer.Data[1];
   OutBuffer.Data[3]=ETX;
   TxSend(0x04C0,7);

   if( CarNumner==0xA1) // A Car
   { CarNumner=0xA1;
     Self_Install();
   }

   if( CarNumner==0xA2) // B Car
   { CarNumner=0xA2;
     Self_Install();
   }
 }
}

/*****************************************************************************/
when (nv_update_occurs(nvi01CDTStBits))
{ //: 
   memset(&OutBuffer,0x00,137);
   OutBuffer.stx=STX;
   OutBuffer.Cmd=0x0E;
   OutBuffer.MagCode=0x00;
   OutBuffer.Length=0x01;
   OutBuffer.Data[0]=nvi01CDTStBits.bit3*8;
   OutBuffer.Data[0]=OutBuffer.Data[0] + (nvi01CDTStBits.bit1*2);
   OutBuffer.Data[0]=OutBuffer.Data[0] + nvi01CDTStBits.bit0;
   OutBuffer.Data[1]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length^OutBuffer.Data[0];
   OutBuffer.Data[2]=ETX;
   TxSend(0x04C0,7);
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
		  StatusTimer=DEFAULT_STATUS_RATE;
        }
    }
}
/*****************************************************************************/

when (nv_update_occurs(nvi03SCIVersReq))
{//: SCI Version Transfer

  if(FtpRunning==FALSE && nvi03SCIVersReq.sci_index !=0x01)
  {
    SCI_INDEX=nvi03SCIVersReq.sci_index;
    memset(&OutBuffer,0x00,137);
    OutBuffer.stx=STX;
    OutBuffer.Cmd=0x0C;
    OutBuffer.MagCode=0x00;
    OutBuffer.Length=0x01;
    OutBuffer.Data[0]=nvi03SCIVersReq.sci_index;
    OutBuffer.Data[1]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length^OutBuffer.Data[0];
    OutBuffer.Data[2]=ETX;
    TxSend(0x04C0,7);
  }
  else if(FtpRunning==FALSE && nvi03SCIVersReq.sci_index ==0x01)
  {
    nvo03SCIVersion.sci_index=1;
	nvo03SCIVersion.sci_type=3;
	nvo03SCIVersion.sci_name[0]='L'; nvo03SCIVersion.sci_name[1]='I';
	nvo03SCIVersion.sci_name[2]='C'; nvo03SCIVersion.sci_name[3]='-';
	nvo03SCIVersion.sci_name[4]='A'; nvo03SCIVersion.sci_name[5]='-';
	nvo03SCIVersion.sci_name[6]='L'; nvo03SCIVersion.sci_name[7]='O'; nvo03SCIVersion.sci_name[8]='N';
			        
	nvo03SCIVersion.sci_version[0]='1'; nvo03SCIVersion.sci_version[1]='.';
	nvo03SCIVersion.sci_version[2]='1'; nvo03SCIVersion.sci_version[3]='.';
	nvo03SCIVersion.sci_version[4]='0'; nvo03SCIVersion.sci_version[5]='1';
	nvo03SCIVersion.sci_version[6]=''; nvo03SCIVersion.sci_version[7]='';
			
	nvo03SCIVersion.build_date[0]='2'; nvo03SCIVersion.build_date[1]='0';
	nvo03SCIVersion.build_date[2]='1'; nvo03SCIVersion.build_date[3]='2';
	nvo03SCIVersion.build_date[4]='-'; nvo03SCIVersion.build_date[5]='0';
	nvo03SCIVersion.build_date[6]='5'; nvo03SCIVersion.build_date[7]='-';
	nvo03SCIVersion.build_date[8]='1'; nvo03SCIVersion.build_date[9]='7';
	propagate(nvo03SCIVersion);
  }
}


/*****************************************************************************/

when (nv_update_occurs(nvi04WaysideResp))
{
  if(nvi04WaysideResp.response==1) // new entries available.
  { //: Check and then delete

  }
  if(nvi04WaysideResp.response==2) // No new entries available.
  {
    memset(&OutBuffer,0x00,137);
    OutBuffer.stx=STX;
    OutBuffer.Cmd=0x06;
    OutBuffer.MagCode=0x00;
    OutBuffer.Length=0x00;
    OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
    OutBuffer.Data[1]=ETX;
    TxSend(0x04C0,7);
    FtpRunning=FALSE;
  }
}


when (timer_expires(StatusTimer)) // Comm Status Timer
{
  memset(&OutBuffer,0x00,137);
  OutBuffer.stx=STX;
  OutBuffer.Cmd=0x0A;
  OutBuffer.MagCode=0x00;
  OutBuffer.Length=0x00;
  OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
  OutBuffer.Data[1]=ETX;
  //TxSend(0x04C0,7);
  ErrorStatus();
}

when (timer_expires(ClockTimer)) // 1Hour Timer
{
  memset(&OutBuffer,0x00,137);
  OutBuffer.stx=STX;
  OutBuffer.Cmd=0x08;
  OutBuffer.MagCode=0x00;
  OutBuffer.Length=0x00;
  OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
  OutBuffer.Data[1]=ETX;
  TxSend(0x04C0,7);
}



//**************************************************************************************************//
//                                       FTP Function                                              //
//**************************************************************************************************//

FxData fx = {NULL_HANDLE};

mtimer fx_operation_timer;   

void start_transfer(file_request request) 
{

	fx.auth_on = nvi00FileReq.auth_on;
    {
		fx_operation_timer = nvi00FileReq.receive_timeout;
	}
	nvo00FileStat.status = START_STATE(request);
	
}

void stop_transfer(file_status status)
{

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
    nvo00FileStat.status = status & FS_EXTERNAL_STATE_MASK;
}

void process_packet(void)
{
	if ((msg_in.data[0] & FILE_PACKET_MASK) == fx.pkt_in_window)  {
	
		bytes_received = min(FILE_PACKET_SIZE, msg_in.len - 1);
        FtpLength=bytes_received+1;
		if (bytes_received >= 0 ) 
		{  	  
		    memset(&OutBuffer,0x00,137);

            OutBuffer.stx=STX;
            OutBuffer.Cmd=0x05;
            OutBuffer.MagCode=fx.pkt_in_window+1;
            OutBuffer.Length=FtpLength; // Data Length
            memcpy( &OutBuffer.Data[1],&msg_in.data[1], bytes_received); 

           if(CarType==0x41)// Car A 
           {OutBuffer.Data[0]=0x41;}
           if(CarType==0x42)//Car B
           {OutBuffer.Data[0]=0x42;}

            OutBuffer.Data[FtpLength]=0xFF; //None ChechSum
            OutBuffer.Data[FtpLength+1]=0x03;
    
            switch(fx.pkt_in_window)
            {
              case 0:
                     OutBuffer.MagCode=0x01; //Message Code
                     TxSend(0x0010,1);
                     break;
              case 1:
                     OutBuffer.MagCode=0x02; //Message Code
                     TxSend(0x00D8,2);  
                     break;
              case 2:
                     OutBuffer.MagCode=0x03; //Message Code
                     TxSend(0x01A0,3);   
                     break;
              case 3:
                     OutBuffer.MagCode=0x04; //Message Code
                     TxSend(0x0268,4);        
                     break;
              case 4:
                     OutBuffer.MagCode=0x05; //Message Code
                     TxSend(0x0330,5);     
                     break;
              case 5: 
                     OutBuffer.MagCode=0x06; //Message Code
                     TxSend(0x03F8,6);   
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
	  
	nvo00FileStat.adr.address.subnet = nv_in_addr.src_addr.subnet;
	nvo00FileStat.adr.address.node = nv_in_addr.src_addr.node;
	domain = *access_domain(nv_in_addr.domain);
	nvo00FileStat.adr.address.domain_length = domain.len;
	
	if (nv_in_addr.flex_domain)  {

		nvo00FileStat.adr.address.domain_length = 0xff; 
		valid = FALSE;
	} else {

#pragma warnings_off
#pragma relaxed_casting_on
#define	DOMAIN_LEN_MASK	0x07

		      memcpy( (void *) nvo00FileStat.adr.address.domain_id, domain.id, domain.len & DOMAIN_LEN_MASK );

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

when (nv_update_occurs(nvi00FileReq)) // FALSE : Single Car or Car A of married pair
{
	file_descriptor local_descriptor;

	if (CLOSE(nvi00FileReq.request) ?
		(nvi00FileReq.index != nvo00FileStat.selected_file) :
		(fx.handle != NULL_HANDLE))  {
		return;
	}

    nvo00FileStat.number_of_files = NUM_FILES; // always return this info
	nvo00FileStat.selected_file = nvi00FileReq.index;

#ifndef ENABLE_RA
	if (nvi00FileReq.request == FR_OPEN_TO_RECEIVE_RA || nvi00FileReq.request == FR_OPEN_TO_SEND_RA)  {
		setup_status_address();
		nvo00FileStat.status = FS_ACCESS_UNAVAIL;
		return;
	}
	else if (nvi00FileReq.request == FR_OPEN_TO_RECEIVE ||
			nvi00FileReq.request == FR_OPEN_TO_SEND	)  {
#else
	if (nvi00FileReq.request == FR_OPEN_TO_RECEIVE_RA ||
		nvi00FileReq.request == FR_OPEN_TO_SEND_RA	||	
		nvi00FileReq.request == FR_OPEN_TO_RECEIVE 	||
		nvi00FileReq.request == FR_OPEN_TO_SEND	)  {
#endif	// enable_ra

		if (!setup_status_address())return;
	
		// Init state information
		memset(&fx, 0, sizeof(fx));

		fx.req_type = nvi00FileReq.request;
		fx.handle = open(nvi00FileReq.index, fx.req_type);
		if (fx.handle < 0)  {
			nvo00FileStat.status = FS_OPEN_FAIL;      // could not open file
			return;
		}

		// Begin transfer process
		start_transfer(fx.req_type);
	}
	else if (nvi00FileReq.request == FR_CLOSE_FILE)  {
		stop_transfer(FS_CLOSE);
//*********************************************************************//
//END FTP LOGIC
	SendTime();
//*********************************************************************//	
	}
	else if (nvi00FileReq.request == FR_CLOSE_DELETE_FILE)  {
		stop_transfer(FS_FAILURE);
	}
	else if (nvi00FileReq.request == FR_DIRECTORY_LOOKUP)  {
		// Assume indices are numbered 0..N-1.
		if (nvi00FileReq.index >= NUM_FILES)  {
			nvo00FileStat.status = FS_LOOKUP_ERR;
		} else {
			// Return directory information from file system
			local_descriptor = * lookup(nvi00FileReq.index);

#pragma warnings_off
#pragma relaxed_casting_on

			memcpy( (void *)nvo00FileStat.adr.descriptor.file_info, local_descriptor.info, FILE_INFO_SIZE );
#pragma relaxed_casting_off
#pragma warnings_on

			nvo00FileStat.adr.descriptor.size = local_descriptor.size.s32size;
			nvo00FileStat.adr.descriptor.type = local_descriptor.type;
			nvo00FileStat.status = FS_LOOKUP_OK;
		}
	}
}


when (msg_arrives)
{
	unsigned received_window_number;

    switch( msg_in.code ) {

    case FILE_MSG_CODE:
       
        if (fx.handle == NULL_HANDLE) return; 

        fx_operation_timer = nvi00FileReq.receive_timeout; 
      
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

        if (received_window_number == (fx.window_number+FILE_WINDOW_INC)) {
     
            if ((fx.pkt_in_window==FILE_WINDOW_SIZE) || fx.end_of_exchange) {

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
