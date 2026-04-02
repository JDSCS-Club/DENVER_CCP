
////////////////////////////////////////////////////////////////////////////////

#define	true	TRUE
#define	false	FALSE

#define PAC_PROTOCOL_R10	1
#define PAC_OCC_PTT_CTRL	1
#define DPO_BASS_ENABLE		0
#define _COUPLE_MODIFY_		1
typedef  void	(*pFunction)(void);

#define	UART0_Rx_Pin	0x0100		// 0.8
#define	UART0_Tx_Pin	0x0200		// 0.9
#define	UART1_Rx_Pin	0x0400		// 0.10
#define	UART1_Tx_Pin	0x0800		// 0.11
#define	UART2_Rx_Pin	0x2000		// 0.13
#define	UART2_Tx_Pin	0x4000		// 0.14
#define	UART3_Rx_Pin	0x0002		// 0.1
#define	UART3_Tx_Pin	0x0001		// 0.0

#define	PO_RESET		0x0020		// 0.5		// H: no reset
#define	PO_MP3_UPDATE	0x0010		// 0.4		// H: PAC
#define	PO_CL_TX		0x1000		// 0.12		// H: TX
#define	PO_TL_TX		0x0080		// 0.7		// H: TX

#define	PO_P0_OUT		0x10B0		// PO_RESET + PO_MP3_UPDATE + PO_CL_TX + PO_TL_TX

#define	PO_7			0x0200		// 1.9
#define	PO_6			0x0100		// 1.8
#define	PO_5			0x0080		// 1.7
#define	PO_4			0x0040		// 1.6
#define	PO_3			0x0020		// 1.5
#define	PO_2			0x0010		// 1.4
#define	PO_1			0x0008		// 1.3
#define	PO_0			0x0004		// 1.2

#define	PO_P12_P19		0x03FC		// 1.2 - 1.9

#define	PO_SCL_SEL_3	0x8000		// 2.15
#define	PO_SCL_SEL_2	0x1000		// 1.12
#define	PO_SCL_SEL_1	0x0800		// 1.11
#define	PO_SCL_SEL_0	0x0400		// 1.10

#define	PO_P10_P12		0x1C00		// 1.10 - 1.12

#define	PO_SCL_SEL		0x9C00		// PO_SCL_SEL_0 + PO_SCL_SEL_1 + PO_SCL_SEL_2 + PO_SCL_SEL_3

#define	PI_TEST			0x8000		// 1.15

#define	PI_7			0x0200		// 2.9
#define	PI_6			0x0100		// 2.8
#define	PI_5			0x0080		// 2.7
#define	PI_4			0x0040		// 2.6
#define	PI_3			0x0020		// 2.5
#define	PI_2			0x0010		// 2.4
#define	PI_1			0x0008		// 2.3
#define	PI_0			0x0004		// 2.2

#define	PI_P22_P29		0x03FC		// 2.2 - 2.9

#define	PI_PEI_ICALL	0x0400		// 2.10

#define	PO_IO_SEL_3		0x4000		// 2.14
#define	PO_IO_SEL_2		0x2000		// 2.13
#define	PO_IO_SEL_1		0x1000		// 2.12
#define	PO_IO_SEL_0		0x0800		// 2.11

#define	PO_IO_SEL		0x7800		// PO_IO_SEL_0 + PO_IO_SEL_1 + PO_IO_SEL_2 + PO_IO_SEL_3

////////////////////////////////////////////////////////////////////////////////

static	u8	A_Port_ST[5];		// 채터링 후 포트 값
static	u8	A_Port_Chatt[5];	// 채터링 후 변할 값
static	u16	A_Port_Flag[5][8];	// 채터링 중 플래그

static	u8	A_Port_In[5];

// 0	0001
#define	PI_DOOR_CLOSE       0x80      	// L: open
#define	PI_PAC_AB			0x40		// L: CRA
#define	PI_REVERSE			0x20		// H: no reverse
#define	PI_FORWARD			0x10		// H: no forward
#define	PI_BCOUPLE			0x08		// H: conn
#define	PI_ACOUPLE			0x04		// H: conn
#define	PI_BCAB				0x02		// H: cab
#define	PI_ACAB				0x01		// H: cab

// 1	0010
#define	PI_IC_VOICE			0x40		// H:no ic_voice // H: no RX3
#define	PI_INT_PA_IN		0x20		// H: 미사용
#define	PI_EXT_PA_IN		0x10		// H: 미사용
#define	PI_DPO_CANCEL		0x08		// H: no signal
#define	PI_PEI_CLEAR		0x04		// H: no signal
#define	PI_DPO_ESP			0x02		// H: no signal
#define	PI_DPO_ISP			0x01		// H: no signal

// 2	0011
#define	PI_DPH2_LIVE		0x80		// H: dead
#define	PI_DPH1_LIVE		0x40		// H: dead
#define	PI_DPO2_LIVE		0x20		// H: dead
#define	PI_DPO1_LIVE		0x10		// H: dead
#define	PI_PEI4_LIVE		0x08		// H: dead TX3
#define	PI_PEI3_LIVE		0x04		// H: dead TX2
#define	PI_PEI2_LIVE		0x02		// H: dead TX1
#define	PI_PEI1_LIVE		0x01		// H: dead TX0

// 3	0100
#define	PI_VOIPC2			0x20
#define	PI_VOIPC1			0x10
#define	PI_DETECT_11K		0x08		// H: no signal
#define	PI_RACK_FAULT		0x04		// H: open
#define	PI_COND				0x02		// H: no cond
#define	PI_MP3_MUTE			0x01		// H: no mute

// 4	0101
#define	PI_PEI_INT			0x10		// H: no SPARE18
#define	PI_OCC_INT			0x08		// H: no SPARE17
#define	PI_DPO_INT			0x04		// H: no SPARE16
#define	PI_OCC_PA_SUB		0x02		// H: no RX1
#define	PI_OCC_PA_MAIN		0x01		// H: no RX0

static	u8	A_Port_Out[3];

// 0	1001
#define	PO_SPKS_CONN		0x80		// H: open	// init H
#define	PO_SEL_11K			0x40		// H: 송신
#define	PO_SEL_PA_TL_IN		0x20		// H: off	// TL PA In : always low
#define	PO_SEL_PA_TL_OUT	0x10		// H: on	// TL PA Out
#define	PO_SEL_AUTO			0x08		// H: mute
#define	PO_SEL_PEI			0x04		// H: mute
#define	PO_SEL_DPO			0x02		// H: mute
#define	PO_SEL_OCC			0x01		// H: mute

// 1	1010
#define	PO_SPARE			0x80		// H: no RX3	// 중련x : main(L) sub(H), 중련o : 마스터(L) 아니면(H)
#define	PO_VOIPC_MAIN		0x40		// H: no RX2	// 중련x H 중련o L
#define	PO_INT_PA_OUT		0x20		// H: 미사용
#define	PO_EXT_PA_OUT		0x10		// H: 미사용
#define	PO_SEL_CSP			0x08		// H: select
#define	PO_SEL_ESP_L		0x04		// H: select
#define	PO_SEL_ESP_R		0x02		// H: select
#define	PO_SEL_ISP			0x01		// H: select

// 2	1011
#define	PO_REC_ESP			0x80		// L: Rec spare15
#define	PO_REC_ISP			0x40		// L: Rec spare14
#define	PO_REC_CSP			0x20		// L: Rec spare13
#define	PO_REC_PA			0x10		// L: Rec spare12
#define	PO_REC_INT			0x08		// L: Rec spare11
#define	PO_RS485_R1			0x04		// H: close
#define	PO_RS485_RB			0x02		// H: open
#define	PO_RS485_RA			0x01		// H: open

// INT
// DPO OCC 호출 O
// DPO OCC 응답	O
// PEI OCC 호출	O

// VOIPC
// OCC PEI 호출 00 01 10 11
// OCC PEI 호출 on/off
// OCC DPO 호출	O
// OCC DPO 응답	O

static	u8		T_LiveFlag;		// 살아 있었다 표시
static	u8		A_DeadCnt[8];	// 죽어 있는 카운트 수

////////////////////////////////////////////////////////////////////////////////

#define AS_FSYS	11					// AS : array size
#define AS_FVOL	20
static	u8		A_FSys[AS_FSYS];	// 0x400C0000
static	u8		A_FVol[AS_FVOL];	// 0x400C2000
//static	u8		A_ChkS_FSys[4];		// Chks : Check Sum
static	u8		A_ChkS_FVol[4];
//static	u8		AI_Chks_FSys;		// AI : Array Index
static	u8		AI_ChkS_FVol;

#define	I_UPGRADE		0			// I : index
#define	I_FIRMVER1		1
#define	I_FIRMVER2		2
#define	I_FIRMVER3		3
#define	I_CARNUM1		4
#define	I_CARNUM2		5
#define	I_DAYLIGHT		6
#define	I_FILESIZE1		7
#define	I_FILESIZE2		8
#define	I_FILESIZE3		9
#define	I_TOTCHKSUM		10

#define	I_V_OCC			0			// I_V : index volume
#define	I_V_DPO			1
#define	I_V_PEI			2
#define	I_V_AUTO		3
#define	I_V_TLIN		4
#define	I_V_TLOUT		5
#define	I_V_NORCSP		6
#define	I_V_NORISP		7
#define	I_V_NORESP		8
#define	I_V_SOFTCSP		9
#define	I_V_SOFTISP		10
#define	I_V_SOFTESP		11
#define	I_V_ANSSW		12
#define	I_V_ANSSEC		13
#define	I_V_I70H		14
#define	I_V_I70L		15
#define	I_V_I80H		16
#define	I_V_I80L		17
#define	I_V_O80			18
#define	I_V_O85			19

#define ISP_SCL_VOL1	0x01
#define ESPR_SCL_VOL2	0x02
#define ESPL_SCL_VOL3	0x03
#define TLOUT_SCL_VOL4	0x04
#define OCC_SCL_VOL5	0x05
#define DPO_SCL_VOL6	0x06
#define MP3_SCL_VOL7	0x07
#define TLIN_SCL_VOL8	0x08
#define CSP_SCL_VOL9	0x09
/*
31		6
30		5.5
29		5		// TLOut
28		4.5
27		4
26		3.5
25		3		// input , nor 85, TLin
24		2
23		1
22		0
21		-1		// nor 80
20		-3
19		-5
18		-7
17		-9		// nor
16		-11
15		-13
14		-15
13		-17		// soft
12		-19
11		-21
10		-23
9		-25
8		-27
7		-29
6		-31
5		-33
4		-35
3		-37
2		-39
1		-41
0		0
*/

////////////////////////////////////////////////////////////////////////////////

static	u8		T_State;
#define	F_PAC_MASTER		0x01		// Main cra or crb cab on
#define	F_PAC_MAIN			0x02
#define	F_CNCS_AUTO			0x04
#define	F_COUPLING_MODE		0x08
#define	F_CNCS_MODE			0x10
//#define	F_COUPLING_START	0x20
//#define	F_TRAIN_CONN		0x40
#define	F_TRAIN_HEAD		0x80

static	u8		T_Me_AB;		// 1=CRA, 2=CRB
static	u8		T_Me_ID;
static	u8		A_CarNum[4][2];
static	u8		A_TL_CarNum[5][2];		// ???
static	u8		AI_CarNum;
static	u8		T_Train_Len;
static	u8		TL_Coupling_ID;
//static	u8		T_Couple_ST;

////////////////////////////////////////////////////////////////////////////////

#define	CL_TIME_MAIN		5		// 50m
#define	CL_TIME_MSUB		350		// 4s
#define	CL_TIME_SSUB		700		// 8s

#define	TL_TIME_MAIN		30		// 300m orig time

//#define	TL_TIME_MAIN		45		// 300m test time
//#define	TL_TIME_MAIN		50		// 30 = 300m, 50 = 500m
#define	TL_TIME_SUB			1200	// 12s CRB로 cab이 전환시 delay time으로 사용함.

#define	TL_TIME_COUPLING	30		// 300m orig time

//#define	TL_TIME_COUPLING	45		// 300m test time
//#define	TL_TIME_COUPLING	50		// 30 = 300m, 50 = 500m

static	u32		CL_Tick;
static	u32		TL_Tick;

static	u32		CL_TCnt;
static	u32		TL_TCnt;

static	u8		CL_Tx_ID;
static	u8		CL_Rx_ID;

static	u8		A_ErrDevs[37];
static	u8		A_ErrCars[5];
static	u8		T_Cars_Err;

////////////////////////////////////////////////////////////////////////////////

static	u8		CL_State;
static	u8		TL_State;
#define ST_CL_SEL_PAC	1
#define ST_CL_POllING	2
#define	ST_TL_POLLING	3
#define	ST_TL_WAIT		4
#define	ST_TL_COUPLING	5

//#define	STATE_TRAINLINE_POLLING		8	// ???

static	u8		A_VDev_MS[10];
#define	AI_PACM			0
#define	AI_CCPM			1
#define	AI_CNCSM		2
#define	AI_LICM			3
#define	AI_VOIPCM		4
#define	AI_PACS			5
#define	AI_CCPS			6
#define	AI_CNCSS		7
#define	AI_LICS			8
#define	AI_VOIPCS		9

static	u8		A_RID[38];
static	u8		A_VID[256];

static	bool	CL_Rx_Turn;
static	bool	CL_Tx_Turn;

static	u8		A_CLMsg_Num[37];

static	u8		CL_PollM_IDX;
static	u8		CL_Poll1_IDX;
static	u8		CL_Poll2_IDX;
static	u8		CL_Poll3_IDX;

static	u8		CL_PollM_Arr[9];
static	u8		CL_Poll1_Arr[10];
static	u8		CL_Poll2_Arr[10];
static	u8		CL_Poll3_Arr[10];

#define	VAPAC		1		// 0x21
#define	VACCP		2		// 0x11
#define	VAVOIPC		3		// 0x13
#define	VALIC		4		// 0x22
#define	VAVTX		5		// 0x23
#define	VACNCS		6		// 0x24

#define	VAFDI		7		// 0x31
#define	VASDI1		8		// 0x41
#define	VASDI2		9		// 0x42
#define	VASDI3		10		// 0x43
#define	VASDI4		11		// 0x44
#define	VAPII1		12		// 0x51
#define	VAPII2		13		// 0x52
#define	VAPID11		14		// 0x61
#define	VAPID12		15		// 0x62
#define	VAPID13		16		// 0x63
#define	VAPID14		17		// 0x64
#define	VAPID21		18		// 0x71

#define	VBPAC		19		// 0x25
#define	VBCCP		20		// 0x12
#define	VBVOIPC		21		// 0x14
#define	VBLIC		22		// 0x26
#define	VBVTX		23		// 0x27
#define	VBCNCS		24		// 0x28

#define	VBFDI		25		// 0x32
#define	VBSDI1		26		// 0x45
#define	VBSDI2		27		// 0x46
#define	VBSDI3		28		// 0x47
#define	VBSDI4		29		// 0x48
#define	VBPII1		30		// 0x53
#define	VBPII2		31		// 0x54
#define	VBPID11		32		// 0x65
#define	VBPID12		33		// 0x66
#define	VBPID13		34		// 0x67
#define	VBPID14		35		// 0x68
#define	VBPID21		36		// 0x78

/*
PAC1
PAC2
CCPM
CNCSM
LICM
VOIPM
CCPS	CNCSS	LICS	VOIPS	AVTX	BVTX	AFDI	BF야	APID21	BPID21
ASID1	ASID2	ASID3	ASID4	APII1	APII2	APID11	APID12	APID13	APID14
BSID1	BSID2	BSID3	BSID4	BPII1	BPII2	BPID11	BPID12	BPID13	BPID14
*/

////////////////////////////////////////////////////////////////////////////////

static	u16		T_Ans_11k;

static	u16		A_Ans_Val[25];
static	u8		AI_Ans;
static	u32		T_Ans_Avr;

static	u8		T_Ans_Cnt;
#define	ANS_TICK_CNT		20		// 200m

//static	u8		TE_State;

static	u8		TP_Broad_Device;
#define	F_PEI_START		0x01
#define	F_PEI_ING		0x02
#define	F_PEI_AB		0x04	// L:CRA H:CRB
#define	F_IC_ING		0x08

static	u8		T_Broad;
#define	F_OCC_OUT		0x01
#define	F_OCC_START		0x02
#define	F_OCC_ING		0x04
#define	F_DPO_OUT		0x08
#define	F_DPO_START		0x10
#define	F_DPO_ING		0x20
#define	F_AUTO_START	0x40
#define	F_AUTO_ING		0x80

static	u8		TC_Broad[3];	// 0:OCC 1:DPO 2:AUTO
#define	TC_OCC		0
#define	TC_DPO		1
#define	TC_AUTO		2

static	u8		T_DPO_Call;
#define	F_CALL_DPO1			0x01
#define	F_CALL_DPH1			0x02
#define	F_CALL_DPO2			0x04
#define	F_CALL_DPH2			0x08

static	u16		T_PEI_Cnt;
static	u8		T_PEI_Name[6];
static	u8		T_PEI_Play[5];	// 플레이 해야할 리스트
static	u8		T_PEI_Num;

static	u16		T_IC_Cnt;
static	u8		T_IC_Name[6];

static	u8		ESpk_State;
static	u8		ESpk_ST_Me;
#define	ESP_MUTE_R			0x01
#define	ESP_MUTE_L			0x02
#define	ESP_NORMAL			0x04
#define	ESP_SOFT			0x08
#define	ESP_FLAG			0x10		// L : PAC, H : CCP

static	u8		CISpk_State;
static	u8		CISpk_ST_Me;
#define	ISP_MUTE			0x01
#define	ISP_NORMAL			0x02
#define	ISP_SOFT			0x04
#define	ISP_SPARE			0x08
#define	CSP_MUTE			0x10
#define	CSP_NORMAL			0x20
#define	CSP_SOFT			0x40
#define	CSP_SPARE			0x80

////////////////////////////////////////////////////////////////////////////////

#define	SPARE		0

static	u8		P_PAC_Token;	// P_ : Packet
#if PAC_PROTOCOL_R10
#define	P_VOIPA_MAIN			0x02
#define	P_PACA_TOKEN			0x08
#define	P_VOIPB_MAIN			0x20
#define	P_PACB_TOKEN			0x80
#else
#define	P_VOIPA_MAIN			0x01
#define	P_PACA_TOKEN			0x08
#define	P_VOIPB_MAIN			0x10
#define	P_PACB_TOKEN			0x80
#endif
static	u8		P_Coupling_ID;
static	u8		P_Coupling_Old;

static	u8		P_IOport;
#define	P_PAC_ACAB			0x01
#define	P_PAC_BCAB			0x02
#define	P_PAC_ACOUPLE		0x04
#define	P_PAC_BCOUPLE		0x08
#define	P_PAC_REVERSE		0x10
#define	P_PAC_FORWARD		0x20
#define	P_PAC_DOOR			0x80
#if PAC_PROTOCOL_R10
#define	P_TRAIN_DIRECT		0x40	//1 : 열차 상향 방향.0 : 열차 하향 방향.
#define P_CCP_TRAIN_DIRECT	0x80	//1 : 열차 상향 방향.0 : 열차 하향 방향.
#endif
static	u8		P_Broad_Device;	// _B : Broad, _I : Intercom
#define	P_PAC_OCC_B		0x01
#define	P_PAC_DPO_B		0x02
#define	P_PAC_PEI_B		0x04
#define	P_PAC_AUTO_B	0x08
#define	P_PAC_OCC_I		0x10
#define	P_PAC_DPO_I		0x20
#define	P_PAC_PEI_I		0x40
#define	P_PAC_CNCS_PLAY	0x80

#if PAC_PROTOCOL_R10
static	u8		P_Broad_Occ;	// _B : Broad, _I : Intercom
#define OCC_MSG_ACT		0x01

static  u8      P_Broad_Priorit;// 
#define  Broad_Priority_tick	100
#endif

static	u8		AP_POdo[4];		// AP : Array Packet
static	u8		AP_COdo[4];		// AP : Array Packet
static	u8		P_Ans_Vol;
static	u8		AP_TrainNum[3];
static	u8		AP_CrewID[3];
static	u8		AP_TrigID[3];
static	u8		P_St_Type;

/*
static	u8		P_Spk_ST;			// ???
static	u8		P_Spk_Old;
#define	ESP_MUTE_R			0x01
#define	ESP_MUTE_L			0x02
#define	ESP_NORMAL			0x04
#define	ESP_SOFT			0x08
#define	ISP_MUTE			0x10
#define	ISP_NORMAL			0x20
#define	ISP_SOFT			0x40
#define	ESP_FLAG			0x80		// L : PAC, H : CCP
*/

static	u8		P_Disp_Msg;
static	u8		P_LED_MR;
static	u8		P_PR_Active;

static	u8		AP_St_Start[2];
static	u8		AP_St_Now[2];
static	u8		AP_St_Next[2];
static	u8		AP_St_Dest[2];

static	u8		AP_PR_Msg[2];

static	u8		AP_PAC_Vec[2];
static	u8		AP_FSDI_Vec[2];
static	u8		AP_DD_Vec1[2];
static	u8		AP_DD_Vec2[2];
static	u8		AP_PII_Vec[2];
static	u8		AP_PPL_Vec[2];
static	u8		AP_PPD_Vec[2];
static	u8		AP_SP_Vec[2];
static	u8		AP_St_Skip[10];
static  u8		AP_CI_AFLT,AP_CI_BFLT,AP_CI_FLT,AP_CI_RFLT;
static  u8		R_CI_Fault[8];
static	u8		AP_CID_LIC_Rx[8];//LIC car line data
static	u8		AP_CID_ALIC_Tx,AP_CID_BLIC_Tx;//LIC car line data
static	u8		AP_CID_Rx[8];//LIC car line data
static	u8		AP_CID_Tx[8];//CCP car line data
static	u8		T_CI_Fault;

static	u8		P_CCI;
//01	단일차량
//02~0C 열차 편성 정보
//10	열차편성정보 파악중
//20	열차편성정보 파악실패

#if PAC_PROTOCOL_R10
static	u8		P_Posi_Index;

//====================================================
//VoIP protocol확인 후 삭제.160122 voip protocol 학인됨.
//static  u8  	gVAVOIPC,gVBVOIPC;//VoIP interface 확인 후 삭제.
//static  u8      gByAVoIPComm,gByBVoIPComm;
//====================================================

#endif

static	u8		AP_Train_ST[5][9];

// 0
#define	ACAB_ON				0x01
#define	AVOIPC_MAIN			0x02
#define	ACNCS_AUTO			0x04
#define	A_HEADING			0x08
#define	BCAB_ON				0x10
#define	BVOIPC_MAIN			0x20
#define	BCNCS_AUTO			0x40
#define	B_HEADING			0x80

// 1
#define	LIVE_AWLR			0x01
#define	LIVE_AGPS			0x02
#define	LIVE_AVOIPC			0x04
#define	LIVE_ACCP			0x08
#define	LIVE_BWLR			0x10
#define	LIVE_BGPS			0x20
#define	LIVE_BVOIPC			0x40
#define	LIVE_BCCP			0x80

// 2
#define	LIVE_ACNCS			0x01
#define	LIVE_AVTX			0x02
#define	LIVE_ALIC			0x04
#define	LIVE_APAC			0x08
#define	LIVE_BCNCS			0x10
#define	LIVE_BVTX			0x20
#define	LIVE_BLIC			0x40
#define	LIVE_BPAC			0x80

// 3
#define	LIVE_APII2			0x01
#define	LIVE_APII1			0x02
#define	LIVE_AFDI			0x04
#define	LIVE_BPII2			0x10
#define	LIVE_BPII1			0x20
#define	LIVE_BFDI			0x40

// 4
#define	LIVE_ASDI4			0x01
#define	LIVE_ASDI3			0x02
#define	LIVE_ASDI2			0x04
#define	LIVE_ASDI1			0x08
#define	LIVE_BSDI4			0x10
#define	LIVE_BSDI3			0x20
#define	LIVE_BSDI2			0x40
#define	LIVE_BSDI1			0x80

// 5
#define	LIVE_APID14			0x01
#define	LIVE_APID13			0x02
#define	LIVE_APID12			0x04
#define	LIVE_APID11			0x08
#define	LIVE_BPID14			0x10
#define	LIVE_BPID13			0x20
#define	LIVE_BPID12			0x40
#define	LIVE_BPID11			0x80

// 6
#define	LIVE_APEI1			0x01
#define	LIVE_APEI2			0x02
#define	LIVE_APID21			0x08
#define	LIVE_BPEI1			0x10
#define	LIVE_BPEI2			0x20
#define	LIVE_BPID21			0x80

// 7
#define	CALL_APEI1			0x01
#define	CALL_APEI2			0x02
#define	CALL_BPEI1			0x10
#define	CALL_BPEI2			0x20

// 8
#define	LIVE_ADPO			0x01
#define	LIVE_ADPH			0x08
#define	LIVE_BDPO			0x10
#define	LIVE_BDPH			0x80

static	u8		P_LIC_0;
#define	P_LIC_DOOR		0x01
#define	P_LIC_EPMODE	0x02
#define	P_LIC_TRACTION	0x04
#define	P_LIC_ACTIVECAB	0x08
#define	P_LIC_CIFAULT	0x40
#define	P_LIC_DST		0x80

static	u8		P_CNCS_PA;
#define	P_CNCS_READY	0x01
#define	P_CNCS_ACTION	0x02
#if PAC_PROTOCOL_R10
#define P_CNCS_OCC_PA	0x04
#endif
static	u8		P_CNCS_GPS;
#define	P_CNCS_DST		0x01
#define	P_GPS_LIVE		0x80

////////////////////////////////////////////////////////////////////////////////

/*
#define	Block8	0x00008000	// Start offset of block 8
#define	Block9	0x00010000	// Start offset of block 9
#define	Block10	0x00018000	// Start offset of block 10
#define	Block11	0x00020000	// Start offset of block 11
#define	Block12	0x00028000	// Start offset of block 12
#define	Block13	0x00030000	// Start offset of block 13
*/

//static	u32		File_Idx;
//static	u8		File_ChkSum;

////////////////////////////////////////////////////////////////////////////////

static	u8		TL_Train_Len;
static	u8		TL_Coupling_ID;

static	u8		TL_Car_Temp[2];

static	u8		temps8;
static	u8		tempd8;

static	u8		TLC_State_ID;
static	u8		TLC_Status;
#define	CS_CAB_WAIT			0
#define	CS_COUPLING_START	1
#define	CS_HOC_REQ			2
#define	CS_HOC_ACK			3
#define	CS_TOC_REQ			4
#define	CS_TOC_ACK			5
#define	CS_HOC_RB_REQ		6
#define	CS_HOC_RB_ACK		7
#define	CS_HOC_RA_REQ		8
#define	CS_HOC_RA_ACK		9
#define	CS_PASS_RB_TOKEN	10
#define	CS_PASS_RB_ACK		11
#define	CS_PASS_RA_TOKEN	12
#define	CS_PASS_RA_ACK		13
#define	CS_11KHZ			14
#define	CS_COUPLING_STOP	15

static	u8		HOC_State;
#define	B_HOC_REQ_EXIST		0x01
#define	B_HOC_ACK_EXIST		0x02
#define	B_RB_HOC_REQ		0x04
#define	B_RB_HOC_ACK		0x08
#define	B_RA_HOC_REQ		0x10
#define	B_RA_HOC_ACK		0x20
#define	B_RB_HOC_RPT_ACK	0x40
#define	B_RA_HOC_RPT_ACK	0x80

static	u8		Pass_State;
#define	B_RB_PASS_REQ		0x01
#define	B_RB_PASS_ACK		0x02
#define	B_RA_PASS_REQ		0x04
#define	B_RA_PASS_ACK		0x08
#define	B_RB_PASS_RPT_ACK	0x10
#define	B_RA_PASS_RPT_ACK	0x20
#define	B_TOC_REQ_EXIST		0x40
#define	B_TOC_ACK_EXIST		0x80

static	u8		Coupling_CMD;
#define	TLST_HOC			0x01
#define	TLST_TMP_HOC		0x02
#define	TL_TOKEN			0x04
#define	TL_PASS_TOKEN		0x08
#define	TLST_HEAD			0x10
#define	TLST_START			0xC0

static	u8		TL_CAB_ID;
static	u8		TL_Poll_ID;
static	u8		TL_Chk_ID;

static	bool	TL_Rx_Turn;
static	bool	TL_Tx_Turn;
/*
static	u8		Broad_State;
static	u8		State_Broad_TL;
#define	BROAD_INTERCOM_C	0x01
#define	BROAD_TRIC_C		0x02
#define	BROAD_PEI_C			0x04
#define	BROAD_MP3_C			0x08
#define	BROAD_IN_PA			0x10
#define	BROAD_INTERCOM_BOTH	0x20
#define	BROAD_INTERCOM_ESP	0x40
#define	BROAD_INTERCOM_ISP	0x80
#define	TL_INTERCOM_CANCEL	0x80
*/

////////////////////////////////////////////////////////////////////////////////

#define	CRX_ST_NONE		0
#define	CRX_ST_STX		1
#define	CRX_ST_SRC1		2
#define	CRX_ST_SRC2		3
#define	CRX_ST_DST1		4
#define	CRX_ST_DST2		5
#define	CRX_ST_MCNT1	6
#define	CRX_ST_MCNT2	7
#define	CRX_ST_CMD1		8
#define	CRX_ST_CMD2		9
#define	CRX_ST_1LEN1	10
#define	CRX_ST_1LEN2	11
#define	CRX_ST_2LEN1	12
#define	CRX_ST_2LEN2	13
#define	CRX_ST_DATA1	14
#define	CRX_ST_DATA2	15
#define	CRX_ST_CHKSUM1	16
#define	CRX_ST_CHKSUM2	17
#define	CRX_ST_CHKSUM3	18
#define	CRX_ST_CHKSUM4	19
#define	CRX_ST_ETX		20

#define	CTX_ST_NONE		0
#define	CTX_ST_STX		1
#define	CTX_ST_DATA		2
#define	CTX_ST_ETX		3

#define	TRX_ST_NONE		0
#define	TRX_ST_STX		1
#define	TRX_ST_SRC1		2
#define	TRX_ST_SRC2		3
#define	TRX_ST_DST1		4
#define	TRX_ST_DST2		5
#define	TRX_ST_MCNT1	6
#define	TRX_ST_MCNT2	7
#define	TRX_ST_CMD1		8
#define	TRX_ST_CMD2		9
#define	TRX_ST_LEN1		10
#define	TRX_ST_LEN2		11
#define	TRX_ST_DATA1	12
#define	TRX_ST_DATA2	13
#define	TRX_ST_CHKSUM1	14
#define	TRX_ST_CHKSUM2	15
#define	TRX_ST_CHKSUM3	16
#define	TRX_ST_CHKSUM4	17
#define	TRX_ST_ETX		18

#define	TTX_ST_NONE		0
#define	TTX_ST_DELAY	1
#define	TTX_ST_DUMMY1	2
#define	TTX_ST_DUMMY2	3
#define	TTX_ST_DUMMY3	4
#define	TTX_ST_DUMMY4	5
#define	TTX_ST_DUMMY5	6
#define	TTX_ST_STX		7
#define	TTX_ST_DATA		8
#define	TTX_ST_ETX		9
#define	TTX_ST_EDUMMY	10

static	u8		CTL_Temp[1];

static	u16		CRC_Table[256];

static	u8		CL_Rx_SrcID;
static	u8		CL_Rx_DstID;
static	u8		CL_Rx_MCnt;
static	u8		CL_Rx_Cmd;
static	u16		CL_Rx_Len;
static	u8		CL_Rx_Data[512];
static	u16		CL_Rx_CRC16;
static	u16		CL_Rx_CRCTemp;

static	u8		CL_Rx_Tmp_ID;
static	u8		CL_Rx_Tmp_Cmd;

static	u8		CL_Rx_State;
static	u16		CL_Rx_16Data;
static	u16		CL_Rx_Index;
static	bool	CL_OK_Packet;

static	u16		CL_Tx_Len;
#if PAC_PROTOCOL_R10
static	u8		CL_Tx_Data[256];
#else
static	u8		CL_Tx_Data[256];
#endif
static	u8		CL_Tx_Packet[512];
static	u16		CL_Tx_CRC16;
static	u8		CL_Tx_State;
static	u16		CL_Tx_Index;

static	u8		TL_Rx_SrcID;
static	u8		TL_Rx_DstID;
static	u8		TL_Rx_MCnt;
static	u8		TL_Rx_Cmd;
static	u16		TL_Rx_Len;
static	u8		TL_Rx_Data[256];
static	u16		TL_Rx_CRC16;
static	u16		TL_Rx_CRCTemp;

static	u8		TL_Rx_State;
static	u16		TL_Rx_16Data;
static	u16		TL_Rx_Index;
static	bool	TL_OK_Packet;

static	u8		TL_Tx_SrcID;
static	u8		TL_Tx_DstID;
static	u8		TL_Tx_MCnt;
static	u8		TL_Tx_Cmd;
static	u16		TL_Tx_Len;
static	u8		TL_Tx_Data[128];
static	u8		TL_Tx_Packet[256];
static	u16		TL_Tx_CRC16;
static	u8		TL_Tx_State;

#if PAC_PROTOCOL_R10
static  u8      TL_Tx_Rep_Dummy;
#endif

static	u16		TL_Tx_Index;

static	bool	TL_Mode_Send;
static	u8		TL_State_Send;

////////////////////////////////////////////////////////////////////////////////

void	Tim1_ISR(void);
void	CL_Timer(void);
void	Tim2_ISR(void);
void	TL_Timer(void);
void	PAC_Reboot(void);

////////////////////////////////////////////////////////////////////////////////

static	void	Set_Var(void);

static	void	Port_Check(void);
static	void	Device_Check(void);
static	u8		Port_RW_Data(u8 gbn, u8 sel);	// 1:read 2:write

static	void	Make_Data(u8 vid);
static	void	Read_CL_Data(u8 vsid, u8 vdid);

static	void	Set_Vol_I2C(u8 sel);
static	void	Set_MS_State(u8 state);
#define	SET_MAIN		1
#define	SET_SUB			2

static	void	Chk_LiveCall(u8 PIN_NUM, u8 *comm_status, u8 ERR_LOC, u8 chk_num, u8 *call_var, u8 CALL_VAL);

////////////////////////////////////////////////////////////////////////////////

/*
static u16 EXT_Read_Staus_Register(void);
static void EXT_Block_Unlock(u32 Block);
static void EXT_Block_Erase(u32 Block);
static void EXT_Write_2Byte(u32 address, u16 Data);
static u16 EXT_Read_2Byte(u32 address);
*/

////////////////////////////////////////////////////////////////////////////////

void	CL_RxTxISR(void);
void	CL_RxHandler(u8 rx_data);
void	CL_TxHandler(void);
void	CL_Receive(u8 rx_data, u8 state);
void	CL_Send(u8 SrcID, u8 CL_Tx_ID, u8 MCnt, u8 Cmd, u16 arrLen);
void	TL_RxTxISR(void);
void	TL_RxHandler(u8 rx_data);
void	TL_TxHandler(void);
void	TL_Receive(u8 rx_data, u8 state);
void	TL_Send(u8 SrcID, u8 DstID, u8 MCnt, u8 Cmd, u16 arrLen);
void    MP3_RxHandler(u8 rx_data);
void 	OCC_Ptt_Ctrl_SpeakerMode(void);
void 	OCC_Ptt_Ctrl_MicMode(void);

////////////////////////////////////////////////////////////////////////////////

static	void		HexIncDec(u8 *high, u8 *low, u8 gbn);	// 0:dec 1:inc
u16		CRC_Check(u16 seed, u8 val);
u8		ByteToAsc(u8 sel, u8 c);
#define	HBYTE		1
#define	LBYTE		2
u8		Asc16ToByte(u16 c);

////////////////////////////////////////////////////////////////////////////////

