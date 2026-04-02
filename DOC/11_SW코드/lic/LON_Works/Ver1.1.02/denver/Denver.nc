//**************************************************************************************************
// 뎀버 LIC용 LON프로그램
//
// * 주의 : 버전과 빌드날짜 수정은 반드시 "#define VERSION"와 "#define BUILDATE" 에서 수정 할것
//			
//
//
// 1) Ver1.1.02(2012.5.18) : 
//		1.1) 수정 : 연준상
//		1.2) 수정사항
//		- 버전 부분 수정(MPU와 CDT로 전달해 주는 프로그램이 달라 하나로 합침)
//		- SELECTOR와 INDEX번호 수정
//      - STATUS에서 순간적으로 생긴 데이터를 검지하도록 수정
//		- 파라메터값 3개 추가
//		- 버퍼의 크기가 작아서 데이터를 지그재그로 동작하도록 수정
//		- WaySideOn시 요청 로직 잘못되어 수정
//		- 변수 추가시 반드시 변수 앞에 "far"를 사용해야 3개 이상의 함수가 참조되는것을 확인 함. 그래서 변수를 수정 함
//		- 다운로드시 FT-5000가 멈추는 경우 24LC64의 CCLK과 DAT를 쇼트시키고 전원을 키고 다시 다운로드하면 되는것을 확인
//		- WaySideOn시 데이터 참조시 기존 SEPTA와 다른 배열을 참조하는것을 확인하고 수정
//		- RECENTLY와 HISTORICAL 호출시 마지막 REQ에서 시간을 정상적으로 전달하지못해 별도의 변수를 추가하고 배열의 위치가 달라 수정함
//		- HISTORICAL데이터시 'A'카 및 'B'카 데이터를 전달해 줄때 참조변수가 아무런 내용도 변함이 없어 별도 변수로 수정함
//		- 프로그램이 길어지면 LONMAKER나 NODEUTIL에서 다운로드하다가 FT-5000이 멈추는 현상이 발생하여 기존 프로그램을 간결하게 되도록 수정
//
//
//**************************************************************************************************

//**************************************************************************************************
// Pragma Declarations                                        
//**************************************************************************************************
#pragma enable_sd_nv_names
#pragma set_node_sd_string "COMM, WOOJIN, LIC, 2012-05-17"
#pragma set_id_string "COMM"

#pragma num_alias_table_entries 10
#pragma num_addr_table_entries 10
#pragma run_unconfigured  
#pragma net_buf_in_size 146 
#pragma app_buf_in_size 146 
#pragma net_buf_out_size 66 
#pragma app_buf_out_size 66 
#pragma net_buf_in_count 7
#pragma app_buf_in_count 7 
#pragma net_buf_out_count 3
#pragma app_buf_out_count 3
#pragma app_buf_out_priority_count 0
#pragma net_buf_out_priority_count 0

//**************************************************************************************************
// Include Declarations                                       
//**************************************************************************************************
#include <string.h>
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

//**************************************************************************************************
// Constant Declarations
//**************************************************************************************************
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

#define MAKE_BYTE(H,L) ((((H) << 4) | ((L) & 0x0f)) & 0xff)

#define IS_ACAR(x) ((x)&0x01)
#define IS_BCAR(x) !((x)&0x01) 

#define VERSION "1.1.02" // 프로그램 버젼
#define BUILDATE "2012-05-17" // 프로그램 만든 날짜


//*************************************************************************************************
// I/O Declarations                                       
//**************************************************************************************************
IO_0 input bit InInetrupt; //MCU->FT Interrupt
IO_1 output bit OutInetrupt=1; //FT->MCU Interrupt
IO_7 output bit ioSelect = 1;
IO_8 spi master clock(0) clockedge(-) ioRTx;

//**************************************************************************************************
// Timer Declarations                                         
//**************************************************************************************************

mtimer repeating StatusTimer=DEFAULT_STATUS_RATE;
stimer repeating SilenceTimer;
stimer repeating ClockTimer=3600; // 1Hour Timer
mtimer repeating TrainConfTimer=0;
mtimer repeating CiPosTimer=0;
mtimer repeating CarNoTimer=0; // 
mtimer repeating OtherCiFaultTimer=0; // 

//**************************************************************************************************
// Network Variable Declarations                                 
//**************************************************************************************************
config network input sd_string("&0,,0\x90,25;")int nci00NetConfig;


far network input sd_string("@0|1") SNVT_obj_request nvi00ObjRequest;
far network output sd_string("@0|2") SNVT_obj_status nvo00ObjStatus;

far network input sd_string("@0|3") UNVT_CDT_command nvi00CDTCommand; //MDS -> MPU_Lon 시간 요청  3600초 마다 요청 한다.
far network output sd_string("@0|4") SNVT_time_stamp nvo00TimeStamp;  //MPU_Lon -> MDS 시간 전달.

far network input sd_string("@0|5") SNVT_file_req nvi00FileReq;  //FTP function 
far network output sd_string("@0|6") SNVT_file_status nvo00FileStat; //FTP function


far network input sd_string("@1|1") UNVT_subscribe nvi01Subscribe; //MDS -> MPU_Lon 각 장치 상태 정보는 요청 한다.

/*nvi01Subscribe.param_id 
  --> 0 : 상태 데이타 요청.  	    9sec 간격으로 요청.
  --> 1 : 차량 구성 요청.      	    2sec 간격으로 요청.
  --> 2 : C/I 위치 요청.            2sec 간격으로 요청.
  --> 3 : 차량 번호 요청.      	    6 sec 간격으로 요청.
  --> 4 : C/I 고장 난 위치 요청. 2sec 간격으로 요청.  */

  
far network output sync sd_string("@1|2") SNVT_state_64 nvo01StatusBits; //MPU_Lon -> MDS 각 장치 상태를 전송. 
far network output sync sd_string("@1|3") SNVT_state_64 nvo01StatusBits2;

far network input sd_string("@1|4") SNVT_state nvi01TransfState; //FTP 
far network output sd_string("@1|5") UNVT_parameter nvo01Parameter; // MPU_Lon -> MDS
/*nvo01Parameter.param_id  
  --> 1 : 차량 구성 응답.
  --> 2 : C/I 위치 응답. 
  --> 3 : 차량 번호 응답.
  --> 4 : C/I 고장 난 위치 응답.  */

far network input sync sd_string("@1|6") SNVT_state_64 nvi01CDTStBits; //MDS -> MPU_Lon 차량 상태 전송.
/*-----------------------------------------------------
    index     Description                     Notes
  -----------------------------------------------------
       0        Active Cab                     CDT discrete input 
       1        Traction command          Powering operation mode from Propulsion status informati
       2            ""                                           ""
       3        All Doors closed            CDT Discrete inpu
       4        Cutout Feedback             C/I Phase Shift Information
--------------------------------------------------------*/
far network input sd_string("@1|8") UNVT_parameter nvi01CDTParam;


far network input sd_string("@3|1") UNVT_sci_version_request nvi03SCIVersReq; //MDS -> MPU_Lon 버전 정보 요청.


far network output sd_string("@3|2") UNVT_sci_version nvo03SCIVersion; //MPU_Lon -> MDS로 버전 정보 전달.

far network input sd_string("@4|1") UNVT_wayside_response nvi04WaysideResp;
far network output sd_string("@4|2") UNVT_wayside_request nvo04WaysideReq;

eeprom unsigned long ee_config_setup = NOT_LOCAL_CONFIG;

//**************************************************************************************************
// 전역 변수 정의                                 
//**************************************************************************************************
far boolean FtpRunning=FALSE;
far char WaysideType;
far unsigned long CarNumber = 1;

InData InBuffer;
OutData OutBuffer;
far char ErrorBuffer[4];

far unsigned int FtpLength;
far unsigned bytes_received;

union { SNVT_state_64 st; unsigned short b[8]; } StatusCopy;
unsigned short	StatErrCount,SCI_INDEX=0;
far s32_type DefaultTime,ReceivedTime;
long LowByte,HiByte;
s32_type s32Var,s32Low,s32Hi;

far unsigned char ReceviedTimeBuf[4];

extern system void _change_state(int state);

//**************************************************************************************************
// Function                                                 
//**************************************************************************************************
void Self_Install(void)
{
	DomainTable();
	AddressTable(); //Address Table Configuration
	NvConfig(); //Network Variable Config
	Location(); //Location Configuration
}

//**************************************************************************************************
// 도메인 테이블 만들기                                                 
//**************************************************************************************************
void DomainTable(void)
{
	domain_struct domain;
	domain= *access_domain(0);
	memset(&domain, 0, sizeof(domain));
	memset(domain.key, 0xFF, 8); //AUTHENTICATION code (Default)
	domain.len = 0; //////// Domain length
	domain.node = 8; /////// Node address 1
	if(IS_ACAR(CarNumber))// Car A 
	{
		domain.subnet = 1;
	}////// Subnet address 
	else// Car B
	{
		domain.subnet = 2;
	}////// Subnet address
	update_domain(&domain, 0); //Set domain with upper parameters 
	watchdog_update(); 
}

//**************************************************************************************************
// 위치지정                                                
//**************************************************************************************************
void Location(void)
{
	config_data_struct configure;
	configure = config_data;
  
	configure.location[0] = 'C';  configure.location[1] = 'O';  configure.location[2] = 'M'; configure.location[3] = 'M'; configure.location[4] = ' ';
	if(IS_ACAR(CarNumber))// Car A 
	{
		configure.location[5] = 'A';
	}
	else//Car B
	{
		configure.location[5] = 'B';
	}
  
	configure.node_priority = 0; configure.non_group_timer = 4; configure.nm_auth = 0; configure.preemption_timeout = 1;
	update_config_data(&configure);
	watchdog_update(); 
	ee_config_setup = LOCAL_CONFIG_DONE;  
}

//**************************************************************************************************
// 어드레스 테이블 설정                                             
//**************************************************************************************************
void AddressTable(void)
{
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

//*****************************************************************************************
// 변수 및 SELECT정의
// NV Setting DDN-T097-0091-R03 p19
//*****************************************************************************************
void NvConfig(void)
{
	nv_struct nv_copy;
	nv_copy=*(access_nv(nv_table_index(nci00NetConfig)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x16;
		nv_copy.nv_addr_index=0x0F;
	}
	else //Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x96;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nci00NetConfig));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvi00ObjRequest)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x01;
		nv_copy.nv_addr_index=0x0F;
	}
	else //Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x81;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi00ObjRequest));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvo00ObjStatus)));
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x02;
		nv_copy.nv_addr_index=0x00;
	}
	else //Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x82;
		nv_copy.nv_addr_index=0x01;
	}
	update_nv(&nv_copy,nv_table_index(nvo00ObjStatus));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvi00FileReq)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x04;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x84;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi00FileReq));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvo00FileStat)));
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2 //2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x05;
		nv_copy.nv_addr_index=0x00;
	} 
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x85;
		nv_copy.nv_addr_index=0x01;
	}
	update_nv(&nv_copy,nv_table_index(nvo00FileStat));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvi00CDTCommand)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x11;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x91;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi00CDTCommand));
	watchdog_update();
	
	//******************************************************************************************
	// Selector Not defind
	nv_copy=*(access_nv(nv_table_index(nvo00TimeStamp)));
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=1; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x03;
		nv_copy.nv_addr_index=0x02;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x83;
		nv_copy.nv_addr_index=0x02;
	}
	update_nv(&nv_copy,nv_table_index(nvo00TimeStamp));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvi01Subscribe)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x06;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x86;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi01Subscribe));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvi01TransfState)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x09;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x09;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi01TransfState));
	watchdog_update();

	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvo01StatusBits)));
	nv_copy.nv_priority=0;
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi = 0x08;
		nv_copy.nv_selector_lo = 0x0A;
		nv_copy.nv_addr_index = 0x00;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi = 0x08;
		nv_copy.nv_selector_lo = 0x8A;
		nv_copy.nv_addr_index = 0x01;
	}
	update_nv(&nv_copy,nv_table_index(nvo01StatusBits));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvo01StatusBits2)));
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x0B;
		nv_copy.nv_addr_index=0x00;
	} 
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x8B;
		nv_copy.nv_addr_index=0x01;
	}
	update_nv(&nv_copy,nv_table_index(nvo01StatusBits2));
	watchdog_update();
	
	//*************************MPU_Lon -> MDS(차량 구성/CI위치/차량 번호/CI Fault )*****************
	nv_copy=*(access_nv(nv_table_index(nvo01Parameter)));
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2 //2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi = 0x08;
		nv_copy.nv_selector_lo = 0x0C;
		nv_copy.nv_addr_index = 0x00;
	} 
	else//Car B
	{
		nv_copy.nv_selector_hi = 0x08;
		nv_copy.nv_selector_lo = 0x8C;
		nv_copy.nv_addr_index = 0x01;
	}
	update_nv(&nv_copy,nv_table_index(nvo01Parameter));
	watchdog_update();
	
	//***********************MDS -> MPU_Lon 차량 상태 전송.************************
	nv_copy=*(access_nv(nv_table_index(nvi01CDTStBits)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2 
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x08;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x88;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi01CDTStBits));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvi01CDTParam)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=2; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x07;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x87;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi01CDTParam));
	watchdog_update();
	
	//************************MDS -> MPU_Lon 버전 정보 요청.*******************
	nv_copy=*(access_nv(nv_table_index(nvi03SCIVersReq)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x0F;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x8F;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi03SCIVersReq));
	watchdog_update();
	
	//**********************MPU_Lon -> MDS로 버전 정보 전달. *******************
	nv_copy=*(access_nv(nv_table_index(nvo03SCIVersion)));
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x10;
		nv_copy.nv_addr_index=0x00;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x08;
		nv_copy.nv_selector_lo =0x90;
		nv_copy.nv_addr_index=0x01;
	}
	update_nv(&nv_copy,nv_table_index(nvo03SCIVersion));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvo04WaysideReq)));
	nv_copy.nv_direction=OUTPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x14;
		nv_copy.nv_addr_index=0x00;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x94;
		nv_copy.nv_addr_index=0x01;
	}
	update_nv(&nv_copy,nv_table_index(nvo04WaysideReq));
	watchdog_update();
	
	//******************************************************************************************
	nv_copy=*(access_nv(nv_table_index(nvi04WaysideResp)));
	nv_copy.nv_direction=INPUT;
	nv_copy.nv_service=0; // 0:ACKD UNACKD_RTP:1 UNACK:2
	if(IS_ACAR(CarNumber))// Car A 
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x15;
		nv_copy.nv_addr_index=0x0F;
	}
	else//Car B
	{
		nv_copy.nv_selector_hi =0x01;
		nv_copy.nv_selector_lo =0x95;
		nv_copy.nv_addr_index=0x0F;
	}
	update_nv(&nv_copy,nv_table_index(nvi04WaysideResp));
	watchdog_update();
}

//*****************************************************************************************
//	LIC의 버전과 만든날자를 MPU의 DPRAM으로 전달한다.
//*****************************************************************************************
void VerBuildDateSetToMpu(void)
{
	short nTxPos;
	unsigned char btBuf[16];
	char szBuf[16];

	io_out(ioSelect, FALSE);
	io_out(ioSelect, TRUE);
   
	nTxPos = 0;
	btBuf[nTxPos++]=0x00; // MODE
	btBuf[nTxPos++]=0x00; // ADDRESS
	btBuf[nTxPos++]=0x01;
	btBuf[nTxPos++]=0x00; // SPARE

	strcpy(szBuf,VERSION);
	btBuf[nTxPos++]=MAKE_BYTE(ConvAsc2Hex(szBuf[0]),ConvAsc2Hex(szBuf[2])); // DATA
	btBuf[nTxPos++]=MAKE_BYTE(ConvAsc2Hex(szBuf[4]),ConvAsc2Hex(szBuf[5])); // DATA
   
	strcpy(szBuf,BUILDATE);
	btBuf[nTxPos++]=MAKE_BYTE(ConvAsc2Hex(szBuf[0]),ConvAsc2Hex(szBuf[1])); // DATA
	btBuf[nTxPos++]=MAKE_BYTE(ConvAsc2Hex(szBuf[2]),ConvAsc2Hex(szBuf[3])); // DATA
	btBuf[nTxPos++]=MAKE_BYTE(ConvAsc2Hex(szBuf[5]),ConvAsc2Hex(szBuf[6])); // DATA
	btBuf[nTxPos++]=MAKE_BYTE(ConvAsc2Hex(szBuf[8]),ConvAsc2Hex(szBuf[9])); // DATA

	io_out(ioRTx,&btBuf,nTxPos);

	msec_delay(1);
}

//*****************************************************************************************
//	ASC를 HEX로 바꾼다.
//*****************************************************************************************
unsigned char ConvAsc2Hex(char chDat)
{
	unsigned char nBuf;
	
	nBuf = 0;	
	
	if(chDat >= '0' && chDat <= '9') nBuf = chDat-'0';		
	else
	if(chDat >= 'a' && chDat <= 'f') nBuf = ((chDat-'a') + 10);		
	else
	if(chDat >= 'A' && chDat <= 'F') nBuf = ((chDat-'A') + 10);
	
	return nBuf;
}

//*****************************************************************************************
//	DPRAM에 SPI를 통해 데이터를 전송한다.
//*****************************************************************************************
void TxSend(unsigned long Address,unsigned short BufNum)
{
	// : Data Transfer to MCU
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

//*****************************************************************************************
//	STATUS비트를 업데이트 한다.
//*****************************************************************************************
void ErrorStatus(void) 
{
	//if(nvi01Subscribe.param_id==0 && FtpRunning==FALSE)
	if(FtpRunning==FALSE)
	{
		/*
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
		*/	
		StatusCopy.b[0] = ErrorBuffer[0];
		StatusCopy.b[1] = ErrorBuffer[1];
		StatusCopy.b[2] = ErrorBuffer[2];
		StatusCopy.b[3] = ErrorBuffer[3];

		nvo01StatusBits = StatusCopy.st; // send status
		StatusCopy.b[7]++; // increment rolling counter
		propagate(nvo01StatusBits);
	}   
}

//*****************************************************************************************
// WaySideOn 요청
//*****************************************************************************************
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

//*****************************************************************************************
// 시간전송
//*****************************************************************************************
void SendTime()
{
	unsigned char TempTime[4];
   
	//TempTime[0]=OutBuffer.Data[FtpLength-3]; //TimeStamp Low 1
	//TempTime[1]=OutBuffer.Data[FtpLength-4]; //TimeStamp Low 2
	//TempTime[2]=OutBuffer.Data[FtpLength-5]; //TimeStamp HI 1
	//TempTime[3]=OutBuffer.Data[FtpLength-6]; //TimeStamp HI 2
   
	TempTime[0]=ReceviedTimeBuf[0]; //TimeStamp Low 1
	TempTime[1]=ReceviedTimeBuf[1]; //TimeStamp Low 2
	TempTime[2]=ReceviedTimeBuf[2]; //TimeStamp HI 1
	TempTime[3]=ReceviedTimeBuf[3]; //TimeStamp HI 2

	LowByte=make_long(TempTime[0],TempTime[1]);
	HiByte=make_long(TempTime[2],TempTime[3]);

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
	else
	if(WaysideType==2) // Yard Historical Faults
	{	     
		nvo04WaysideReq.request=3; // Next FTP Start
		nvo04WaysideReq.time_stamp=ReceivedTime;
		propagate(nvo04WaysideReq); 
	}
}

//*****************************************************************************************
// 시간 형태만들기
//*****************************************************************************************
/*
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
	else
	if(WaysideType==2) // Yard Historical Faults
	{	     
		nvo04WaysideReq.request=3; // Next FTP Start
		nvo04WaysideReq.time_stamp=ReceivedTime;
		propagate(nvo04WaysideReq); 
	}
}
*/

//*****************************************************************************************
// MPU에서 요청한 인터럽트를 처리
//*****************************************************************************************
when (io_changes(InInetrupt))
{
	// Data Read from MCU
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

	// Address select
	io_in(ioRTx,&InBuffer,37);
   
	msec_delay(1);
    
	if((InBuffer.stx==STX))
	{
		switch(InBuffer.Cmd)
		{
		// Way side on 시작
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
			s32_from_ulong((unsigned long) 65535, (s32_type *) &s32Var);
			s32_from_ulong((unsigned long) HiByte, (s32_type *) &s32Hi);
			s32_from_ulong((unsigned long) LowByte, (s32_type *) &s32Low);
			s32_mul(&s32Hi,&s32Var,&ReceivedTime);
			s32_add(&s32Hi,&ReceivedTime,&ReceivedTime);
			s32_add(&s32Low,&ReceivedTime,&ReceivedTime);
			WaysideType=InBuffer.Data[0];
			WaySideOn(WaysideType);
			break;
			
		// 시간 전송
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
			
		// 상태데이터 저장
		case 0x0B : 
			if(FtpRunning==FALSE)
			{	       
				//if(nvi01Subscribe.param_id==0)
				//{
					memcpy(&ErrorBuffer,&InBuffer.Data[0],4);   
				//}
			}
			break; 
		
		// 버전 전송
		case 0x0D : 
			if(FtpRunning==FALSE && SCI_INDEX==InBuffer.Data[0])
			{
				nvo03SCIVersion.sci_index=InBuffer.Data[0];
				nvo03SCIVersion.sci_type=InBuffer.Data[1];
				
				for(i=0;i<9;i++)
				{
					nvo03SCIVersion.sci_name[i]=InBuffer.Data[i+2];
					nvo03SCIVersion.sci_version[i]=InBuffer.Data[i+11];
					nvo03SCIVersion.build_date[i]=InBuffer.Data[i+20];
				}
				
				nvo03SCIVersion.build_date[9]=InBuffer.Data[29];
				nvo03SCIVersion.build_date[10]=InBuffer.Data[30];
				
				propagate(nvo03SCIVersion);
			}
			break; 

		// 차량구성설정 응답
		case 0x11 : 
			if(FtpRunning==FALSE)
			{
				nvo01Parameter.param_id=1;
				nvo01Parameter.param_value=make_long(InBuffer.Data[1],InBuffer.Data[0]);
				propagate(nvo01Parameter);
			} 
			break;

		// CI 위치 요청
		case 0x13 : 
			if(FtpRunning==FALSE)
			{
				nvo01Parameter.param_id=2;
				nvo01Parameter.param_value=make_long(InBuffer.Data[1],InBuffer.Data[0]);
				propagate(nvo01Parameter);
			} 
			break;

		// 차량번호 응답
		case 0x15 : 
			if(FtpRunning==FALSE)
			{
				nvo01Parameter.param_id=3;
				nvo01Parameter.param_value=make_long(InBuffer.Data[1],InBuffer.Data[0]);
				propagate(nvo01Parameter);
				
				CarNumber = make_long(InBuffer.Data[1],InBuffer.Data[0]);
				//Self_Install();	

				//DpramMon(0x7fc,high_byte(CarNumber));
				//DpramMon(0x7fd,low_byte(CarNumber));
			} 
			break;

		// CI고장난 차량 위치 응답
		case 0x17 : 
			if(FtpRunning==FALSE)
			{
				nvo01Parameter.param_id=4;
				nvo01Parameter.param_value=make_long(InBuffer.Data[1],InBuffer.Data[0]);
				propagate(nvo01Parameter);    
			} 
			break;
			
		// 처음 기동시 'A'카인지 'B'카인지 알기위해 차량번호 전달
		case 0xF0:
			CarNumber = make_long(InBuffer.Data[1],InBuffer.Data[0]);
			Self_Install();	
			break;
		}
	}
}

//**************************************************************************************************
// DPRAM을 이용하여 모니터하는 함수 (0x7ff), 최대 1개                                       
//**************************************************************************************************
/*
void DpramMon(unsigned long wAddr,unsigned char btDat)
{
	short nTxPos;
	unsigned char btBuf[16];

	io_out(ioSelect, FALSE);
	io_out(ioSelect, TRUE);
   
	nTxPos = 0;
	btBuf[nTxPos++]=0x00; // MODE
	btBuf[nTxPos++]=wAddr>>8; // ADDRESS
	btBuf[nTxPos++]=wAddr&0xff;
	btBuf[nTxPos++]=0x00; // SPARE

	btBuf[nTxPos++]=btDat; // DATA
   
	io_out(ioRTx,&btBuf,nTxPos);

	msec_delay(1);		
}
*/
	
//**************************************************************************************************
// Reset                                            
//**************************************************************************************************
when(reset)
{
	watchdog_update();
	StatusTimer=DEFAULT_STATUS_RATE; //Status Timer initialize. 
    
	VerBuildDateSetToMpu();

	Self_Install();

	if (power_up()) 
	{
		Self_Install();
		_change_state (CNFG_ONLINE);
	}
}

//**************************************************************************************************
// Handle command from CDT                          
//**************************************************************************************************
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

//**************************************************************************************************
// when use FTP Function, Another Transfer is silent                        
//**************************************************************************************************
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

when (timer_expires(SilenceTimer)) // SilenceTimer
{
	FtpRunning=FALSE;
	SilenceTimer=0;
}

//**************************************************************************************************
// Error status update rate set
//**************************************************************************************************
when (nv_update_occurs(nvi01Subscribe))
{
	switch(nvi01Subscribe.param_id)  
	{ 
	// 상태데이터 요청
	case 0:
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
		break;

	// 차량 구성 요청
	case 1:
		if(!TrainConfTimer) TrainConfMpuSend();
		if(!nvi01Subscribe.update_rate)
		{
			TrainConfTimer = 0;
		}
		else
		{
			TrainConfTimer=nvi01Subscribe.update_rate+100;
		}
		break;

	// CI 위치 요청
	case 2:
		if(!CiPosTimer) CiPosMpuSend();
		if(!nvi01Subscribe.update_rate)
		{
			CiPosTimer = 0;
		}
		else
		{
			CiPosTimer=nvi01Subscribe.update_rate+200;
		}
		break;

	// 차량번호 요청
	case 3:
		if(!CarNoTimer) CarNoMpuSend();
		if(!nvi01Subscribe.update_rate)
		{
			CarNoTimer = 0;
		}
		else
		{
			CarNoTimer=nvi01Subscribe.update_rate+300;
		}		
		break;

	// CI고장난 차량 위치 요청
	case 4:
		if(!OtherCiFaultTimer) OtherCiFaultMpuSend();
		if(!nvi01Subscribe.update_rate)
		{
			OtherCiFaultTimer = 0;
		}
		else
		{
			OtherCiFaultTimer=nvi01Subscribe.update_rate;
		}
		break;
	}
}

//*************************************************************************************
// SunScribe관련 Timer
//*************************************************************************************
when (timer_expires(StatusTimer))
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
}

when (timer_expires(TrainConfTimer))
{
	TrainConfMpuSend();
}

void TrainConfMpuSend(void)
{
	if(FtpRunning==FALSE)
	{
		memset(&OutBuffer,0x00,137);
		OutBuffer.stx=STX;
		OutBuffer.Cmd=0x10;
		OutBuffer.MagCode=0x00;
		OutBuffer.Length=0x00;
		OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
		OutBuffer.Data[1]=ETX;
		TxSend(0x04C0,7);
	}
}

when (timer_expires(CiPosTimer))
{
	CiPosMpuSend();
}

void CiPosMpuSend(void)
{
	if(FtpRunning==FALSE)
	{
		memset(&OutBuffer,0x00,137);
		OutBuffer.stx=STX;
		OutBuffer.Cmd=0x12;
		OutBuffer.MagCode=0x00;
		OutBuffer.Length=0x00;
		OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
		OutBuffer.Data[1]=ETX;
		TxSend(0x04C0,7);	
	}
}


when (timer_expires(CarNoTimer))
{
	CarNoMpuSend();
}

void CarNoMpuSend(void)
{
	if(FtpRunning==FALSE)
	{
		memset(&OutBuffer,0x00,137);
		OutBuffer.stx=STX;
		OutBuffer.Cmd=0x14;
		OutBuffer.MagCode=0x00;
		OutBuffer.Length=0x00;
		OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
		OutBuffer.Data[1]=ETX;
		TxSend(0x04C0,7);	
	}
}

when (timer_expires(OtherCiFaultTimer))
{
	OtherCiFaultMpuSend();
}

void OtherCiFaultMpuSend(void)
{
	if(FtpRunning==FALSE)
	{
		memset(&OutBuffer,0x00,137);
		OutBuffer.stx=STX;
		OutBuffer.Cmd=0x16;
		OutBuffer.MagCode=0x00;
		OutBuffer.Length=0x00;
		OutBuffer.Data[0]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length;
		OutBuffer.Data[1]=ETX;
		TxSend(0x04C0,7);	
	}
}

//*************************************************************************************
// Car Number transfer by CDT
//*************************************************************************************
when (nv_update_occurs(nvi01CDTParam))
{
	if(nvi01CDTParam.param_id==0x05)
	{
		/*
		memset(&OutBuffer,0x00,137);
		OutBuffer.stx=STX;
		OutBuffer.Cmd=0x07;
		OutBuffer.MagCode=0x00;
		OutBuffer.Length=0x02;
		OutBuffer.Data[0]=high_byte(nvi01CDTParam.param_value);
		OutBuffer.Data[1]=low_byte(nvi01CDTParam.param_value);
		CarNumber=low_byte(nvi01CDTParam.param_value);
		OutBuffer.Data[2]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length^OutBuffer.Data[0]^OutBuffer.Data[1];
		OutBuffer.Data[3]=ETX;
		TxSend(0x04C0,7);
	
		if(IS_ACAR(CarNumber)) // A Car
		{ 
			CarNumber=0xA1;
			Self_Install();
		}
		else // B Car
		{ 
			CarNumber=0xA2;
			Self_Install();
		}
		*/
	}
}

//*************************************************************************************
// nvi01CDTStBits 발생
//*************************************************************************************
when (nv_update_occurs(nvi01CDTStBits))
{
	memset(&OutBuffer,0x00,137);
	OutBuffer.stx=STX;
	OutBuffer.Cmd=0x0E;
	OutBuffer.MagCode=0x00;
	OutBuffer.Length=0x01;
	OutBuffer.Data[0] = 0x00;
	OutBuffer.Data[0] |= nvi01CDTStBits.bit4*16; // CI고장 여부
	OutBuffer.Data[0] |= nvi01CDTStBits.bit3*8; // All door close
	OutBuffer.Data[0] |= nvi01CDTStBits.bit1*2; // Traction command
	OutBuffer.Data[0] |= nvi01CDTStBits.bit0; // Active cab
	OutBuffer.Data[1]=OutBuffer.Cmd^OutBuffer.MagCode^OutBuffer.Length^OutBuffer.Data[0];
	OutBuffer.Data[2]=ETX;
	TxSend(0x04C0,7);
}

//*************************************************************************************
// Handle successful status transmission to CDT
//*************************************************************************************
when(nv_update_succeeds(nvo01StatusBits))
{
    StatErrCount = 0;	// clear error counter
}

//*************************************************************************************
// Handle failed status transmission to CDT
//*************************************************************************************
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

//*************************************************************************************
// nvi03SCIVersReq 발생, 버전을 MPU에서 수신받아 전송한다.
//*************************************************************************************
when (nv_update_occurs(nvi03SCIVersReq))
{
	int i;
	char btBuf[16];
		
	// LIC외의 프로그램 버전&빌드데이터
	if(FtpRunning==FALSE && nvi03SCIVersReq.sci_index != 2)
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
	else 
	if(FtpRunning==FALSE && nvi03SCIVersReq.sci_index == 2)
	{
		nvo03SCIVersion.sci_index = 2;
		nvo03SCIVersion.sci_type = 3;
		
		/*
		nvo03SCIVersion.sci_name[0] = 'C';
		nvo03SCIVersion.sci_name[1] = 'A';
		nvo03SCIVersion.sci_name[2] = 'R';
		nvo03SCIVersion.sci_name[3] = '-';
		nvo03SCIVersion.sci_name[4] = 'L';
		nvo03SCIVersion.sci_name[5] = 'I';
		nvo03SCIVersion.sci_name[6] = 'C';
		nvo03SCIVersion.sci_name[7] = 'L';
		nvo03SCIVersion.sci_name[8] = '';
		*/
		strcpy(btBuf,"CRA-LICL");
		for(i=0;i<strlen(btBuf);i++) nvo03SCIVersion.sci_name[i] = (unsigned char)btBuf[i];
		
		strcpy(btBuf,VERSION);
		for(i=0;i<strlen(btBuf);i++) nvo03SCIVersion.sci_version[i] = (unsigned char)btBuf[i];
		/*
		nvo03SCIVersion.sci_version[0]=btBuf[0]; 
		nvo03SCIVersion.sci_version[1]=btBuf[1];
		nvo03SCIVersion.sci_version[2]=btBuf[2]; 
		nvo03SCIVersion.sci_version[3]=btBuf[3];
		nvo03SCIVersion.sci_version[4]=btBuf[4]; 
		nvo03SCIVersion.sci_version[5]=btBuf[5];
		nvo03SCIVersion.sci_version[6]=btBuf[6]; 
		nvo03SCIVersion.sci_version[7]='';
		*/
			
		strcpy(btBuf,BUILDATE);
		for(i=0;i<strlen(btBuf);i++) nvo03SCIVersion.build_date[i] = (unsigned char)btBuf[i];
		/*
		nvo03SCIVersion.build_date[0]=btBuf[2]; 
		nvo03SCIVersion.build_date[1]=btBuf[3];
		nvo03SCIVersion.build_date[2]=btBuf[4]; 
		nvo03SCIVersion.build_date[3]=btBuf[5];
		nvo03SCIVersion.build_date[4]=btBuf[6]; 
		nvo03SCIVersion.build_date[5]=btBuf[7];
		nvo03SCIVersion.build_date[6]=btBuf[8]; 
		nvo03SCIVersion.build_date[7]=btBuf[9];
		nvo03SCIVersion.build_date[8]=btBuf[10]; 
		nvo03SCIVersion.build_date[9]='';
		*/
		
		propagate(nvo03SCIVersion);
	}
}


//*************************************************************************************
// nvi04WaysideResp 발생
//*************************************************************************************
when (nv_update_occurs(nvi04WaysideResp))
{
	if(nvi04WaysideResp.response==1) // new entries available.
	{
		
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

//*************************************************************************************
// 1Hour Timer
//*************************************************************************************
when (timer_expires(ClockTimer))
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

//**************************************************************************************************
// 요기 부터 FTP 함수
//**************************************************************************************************
FxData fx = {NULL_HANDLE};

mtimer fx_operation_timer;   

void start_transfer(file_request_t request) 
{

	fx.auth_on = nvi00FileReq.auth_on;
    {
		fx_operation_timer = nvi00FileReq.receive_timeout;
	}
	nvo00FileStat.status = START_STATE(request);
	
}

void stop_transfer(file_status_t status)
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
            
            ReceviedTimeBuf[0] = OutBuffer.Data[FtpLength-5];
            ReceviedTimeBuf[1] = OutBuffer.Data[FtpLength-6];
            ReceviedTimeBuf[2] = OutBuffer.Data[FtpLength-7];
            ReceviedTimeBuf[3] = OutBuffer.Data[FtpLength-8];

			//DpramMon(0x7fe,high_byte(CarNumber));
			//DpramMon(0x7ff,low_byte(CarNumber));
           if(IS_ACAR(CarNumber))// Car A 
           {
           	OutBuffer.Data[0]='A';
           }
           else//Car B
           {
           	OutBuffer.Data[0]='B';
           }

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
	//FtpRunning=TRUE;
	  
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

//**************************************************************************************************
// Common when clauses
//**************************************************************************************************
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
