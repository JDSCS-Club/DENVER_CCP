;******************************************************************************
;* TMS320C3x/4x ANSI C Code Generator                            Version 5.11 *
;* Date/Time created: Mon Apr 16 19:12:10 2018                                *
;******************************************************************************
	.regalias	; enable floating point register aliases
fp	.set	ar3
FP	.set	ar3
;******************************************************************************
;* GLOBAL FILE PARAMETERS                                                     *
;*                                                                            *
;*   Optimization       : Always Choose Smaller Code Size                     *
;*   Memory             : Small Memory Model                                  *
;*   Float-to-Int       : Normal Conversions (round toward zero)              *
;*   Multiply           : in Hardware (24 bits max)                           *
;*   Memory Info        : Unmapped Memory Exists                              *
;*   Repeat Loops       : Use RPTS and/or RPTB                                *
;*   Calls              : Normal Library ASM calls                            *
;*   Debug Info         : Optimized TI Debug Information                      *
;******************************************************************************
;	c:\lang\tms320c3x\511\bin\ac30.exe user.c C:\Users\JDS_DELL\AppData\Local\Temp\user.if 
	.file	"user.c"
	.file	"stdio.h"
	.sym	_size_t,0,14,13,32
	.stag	.fake0,224
	.member	_fd,0,4,8,32
	.member	_buf,32,28,8,32
	.member	_pos,64,28,8,32
	.member	_bufend,96,28,8,32
	.member	_buff_stop,128,28,8,32
	.member	_flags,160,14,8,32
	.member	_index,192,4,8,32
	.eos
	.sym	_FILE,0,8,13,224,.fake0
	.sym	_fpos_t,0,5,13,32
	.stag	.fake1,544
	.member	_name,0,50,8,288,,9
	.member	_flags,288,13,8,32
	.member	_OPEN,320,148,8,32
	.member	_CLOSE,352,148,8,32
	.member	_READ,384,148,8,32
	.member	_WRITE,416,148,8,32
	.member	_LSEEK,448,149,8,32
	.member	_UNLINK,480,148,8,32
	.member	_RENAME,512,148,8,32
	.eos
	.sym	__DEVICE,0,8,13,544,.fake1
	.file	"string.h"
	.file	"def.h"
	.sym	_WORD,0,13,13,32
	.sym	_USHORT,0,13,13,32
	.sym	_BYTE,0,12,13,32
	.sym	_UCHAR,0,12,13,32
	.sym	_UINT,0,14,13,32
	.sym	_BOOL,0,4,13,32
	.sym	_DWORD,0,15,13,32
	.file	"ds1647.h"
	.stag	.fake3,32
	.member	_R,6,4,18,1
	.member	_W,7,4,18,1
	.eos
	.stag	.fake4,32
	.member	_Sec,0,4,18,7
	.member	_Osc,7,4,18,1
	.eos
	.stag	.fake5,32
	.member	_Day,0,4,18,3
	.member	_SPare2,3,4,18,3
	.member	_FT,6,4,18,1
	.member	_Spare1,7,4,18,1
	.eos
	.utag	.fake2,32
	.member	_CtrlBit,0,8,11,32,.fake3
	.member	_SecBit,0,8,11,32,.fake4
	.member	_DayBit,0,8,11,32,.fake5
	.member	_B8,0,12,11,32
	.eos
	.sym	_DS1647ONELTP,0,9,13,32,.fake2
	.sym	_PDS1647ONELTP,0,25,13,32,.fake2
	.stag	.fake6,256
	.member	_Ctrl,0,9,8,32,.fake2
	.member	_Second,32,9,8,32,.fake2
	.member	_Minute,64,9,8,32,.fake2
	.member	_Hour,96,9,8,32,.fake2
	.member	_Day,128,9,8,32,.fake2
	.member	_Date,160,9,8,32,.fake2
	.member	_Month,192,9,8,32,.fake2
	.member	_Year,224,9,8,32,.fake2
	.eos
	.sym	_DS1647BDY,0,8,13,256,.fake6
	.sym	_PDS1647BDY,0,24,13,32,.fake6
	.stag	.fake7,224
	.member	_second,0,12,8,32
	.member	_minute,32,12,8,32
	.member	_hour,64,12,8,32
	.member	_day,96,12,8,32
	.member	_month,128,12,8,32
	.member	_year,160,12,8,32
	.member	_weekday,192,12,8,32
	.eos
	.sym	_DATE_TIME_TYPE,0,8,13,224,.fake7
	.sym	_DATE_TIME_PTR,0,24,13,32,.fake7
	.file	"main.h"
	.file	"MpuDebug.h"
	.file	"user.h"
	.stag	.fake8,6400
	.member	_btStx,0,12,8,32
	.member	_btCmd,32,12,8,32
	.member	_btMessCode,64,12,8,32
	.member	_btLen,96,12,8,32
	.member	_btDat,128,60,8,6272,,196
	.eos
	.sym	_LNWKFTPIT,0,8,13,6400,.fake8
	.sym	_PLNWKFTPIT,0,24,13,32,.fake8
	.stag	.fake9,6400
	.member	_btStx,0,12,8,32
	.member	_btCmd,32,12,8,32
	.member	_btMessCode,64,12,8,32
	.member	_btLen,96,12,8,32
	.member	_btDat,128,60,8,6272,,196
	.eos
	.sym	_LNWKGERIT,0,8,13,6400,.fake9
	.sym	_PLNWKGERIT,0,24,13,32,.fake9
	.stag	.fake10,51712
	.member	_btKind,0,12,8,32
	.member	_btVerH,32,12,8,32
	.member	_btVerL,64,12,8,32
	.member	_btBuildDateHH,96,12,8,32
	.member	_btBuildDateHL,128,12,8,32
	.member	_btBuildDateLH,160,12,8,32
	.member	_btBuildDateLL,192,12,8,32
	.member	_btSpare,224,60,8,288,,9
	.member	_lfBuf,512,56,8,38400,.fake8,6
	.member	_lgRxBuf,38912,8,8,6400,.fake9
	.member	_lgTxBuf,45312,8,8,6400,.fake9
	.eos
	.sym	_LNWKDP,0,8,13,51712,.fake10
	.sym	_PLNWKDP,0,24,13,32,.fake10
	.stag	.fake11,416
	.member	_btSoh,0,12,8,32
	.member	_chSrcDev,32,60,8,64,,2
	.member	_chDestDev,96,60,8,64,,2
	.member	_chMsgCnt,160,60,8,64,,2
	.member	_chCmdCode,224,60,8,64,,2
	.member	_chDataLen,288,60,8,128,,4
	.eos
	.sym	_PTCHD,0,8,13,416,.fake11
	.sym	_PPTCHD,0,24,13,32,.fake11
	.stag	.fake12,768
	.member	_chPacT,0,60,8,64,,2
	.member	_chCcpM,64,60,8,64,,2
	.member	_chCncsT,128,60,8,64,,2
	.member	_chD0,192,60,8,64,,2
	.member	_chD1,256,60,8,64,,2
	.member	_chTran,320,252,8,192,,3,2
	.member	_chCid,512,252,8,192,,3,2
	.member	_chDs,704,60,8,64,,2
	.eos
	.sym	_PROTOCOL_1,0,8,13,768,.fake12
	.stag	.fake13,832
	.member	_phHdBuf,0,8,8,416,.fake11
	.member	_nDdata,416,60,8,64,,2
	.member	_nData_2,480,60,8,64,,2
	.member	_nCaller_ID,544,60,8,128,,4
	.member	_nCRC,672,60,8,128,,4
	.member	_btEot,800,12,8,32
	.eos
	.sym	_PACSDR,0,8,13,832,.fake13
	.sym	_PPACSDR,0,24,13,32,.fake13
	.stag	.fake16,32
	.member	_sACab_ON,0,14,18,1
	.member	_sAVoipCM,1,14,18,1
	.member	_sAAutom,2,14,18,1
	.member	_sAHead_Bit,3,14,18,1
	.member	_sBCab_ON,4,14,18,1
	.member	_sBVoipCM,5,14,18,1
	.member	_sBAutom,6,14,18,1
	.member	_sBHead_Bit,7,14,18,1
	.eos
	.utag	.fake15,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake16
	.eos
	.stag	.fake18,32
	.member	_sAWLR,0,14,18,1
	.member	_sAGPS,1,14,18,1
	.member	_sAVOIP,2,14,18,1
	.member	_sACCP1,3,14,18,1
	.member	_sBWLR,4,14,18,1
	.member	_sBGPS,5,14,18,1
	.member	_sBVOIP,6,14,18,1
	.member	_sBCCP1,7,14,18,1
	.eos
	.utag	.fake17,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake18
	.eos
	.stag	.fake20,32
	.member	_sACNCS,0,14,18,1
	.member	_sAVTX,1,14,18,1
	.member	_sALIC,2,14,18,1
	.member	_sAPAC,3,14,18,1
	.member	_sBCNCS,4,14,18,1
	.member	_sBVTX,5,14,18,1
	.member	_sBLIC,6,14,18,1
	.member	_sBPAC,7,14,18,1
	.eos
	.utag	.fake19,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake20
	.eos
	.stag	.fake22,32
	.member	_sAPII2,0,14,18,1
	.member	_sAPII1,1,14,18,1
	.member	_sAFDI,2,14,18,1
	.member	_sASp_3,3,14,18,1
	.member	_sBPII2,4,14,18,1
	.member	_sBPII1,5,14,18,1
	.member	_sBFDI,6,14,18,1
	.member	_sBSp_3,7,14,18,1
	.eos
	.utag	.fake21,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake22
	.eos
	.stag	.fake24,32
	.member	_sASDI4,0,14,18,1
	.member	_sASDI3,1,14,18,1
	.member	_sASDI2,2,14,18,1
	.member	_sASDI1,3,14,18,1
	.member	_sBSDI4,4,14,18,1
	.member	_sBSDI3,5,14,18,1
	.member	_sBSDI2,6,14,18,1
	.member	_sBSDI1,7,14,18,1
	.eos
	.utag	.fake23,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake24
	.eos
	.stag	.fake26,32
	.member	_sAPID1_4,0,14,18,1
	.member	_sAPID1_3,1,14,18,1
	.member	_sAPID1_2,2,14,18,1
	.member	_sAPID1_1,3,14,18,1
	.member	_sBPID1_4,4,14,18,1
	.member	_sBPID1_3,5,14,18,1
	.member	_sBPID1_2,6,14,18,1
	.member	_sBPID1_1,7,14,18,1
	.eos
	.utag	.fake25,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake26
	.eos
	.stag	.fake28,32
	.member	_sAPEI1,0,14,18,1
	.member	_sAPEI2,1,14,18,1
	.member	_sASp_3,2,14,18,1
	.member	_sAPID2_1,3,14,18,1
	.member	_sBPEI1,4,14,18,1
	.member	_sBPEI2,5,14,18,1
	.member	_sBSp_3,6,14,18,1
	.member	_sBPID2_1,7,14,18,1
	.eos
	.utag	.fake27,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake28
	.eos
	.stag	.fake30,32
	.member	_sAPEI1_Call,0,14,18,1
	.member	_sAPEI2_Call,1,14,18,1
	.member	_sASp_2,2,14,18,1
	.member	_sASp_3,3,14,18,1
	.member	_sBPEI1_Call,4,14,18,1
	.member	_sBPEI2_Call,5,14,18,1
	.member	_sBSp_2,6,14,18,1
	.member	_sBSp_3,7,14,18,1
	.eos
	.utag	.fake29,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake30
	.eos
	.stag	.fake32,32
	.member	_sADPO,0,14,18,1
	.member	_sASp_2,1,14,18,1
	.member	_sASp_3,2,14,18,1
	.member	_sADPH,3,14,18,1
	.member	_sBDPO,4,14,18,1
	.member	_sBSp_2,5,14,18,1
	.member	_sBSp_3,6,14,18,1
	.member	_sBDPH,7,14,18,1
	.eos
	.utag	.fake31,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake32
	.eos
	.stag	.fake14,352
	.member	_CRA_1,0,9,8,32,.fake15
	.member	_CRA_2,32,9,8,32,.fake17
	.member	_CRA_3,64,9,8,32,.fake19
	.member	_CRA_4,96,9,8,32,.fake21
	.member	_CRA_5,128,9,8,32,.fake23
	.member	_CRA_6,160,9,8,32,.fake25
	.member	_CRA_7,192,9,8,32,.fake27
	.member	_CRA_8,224,9,8,32,.fake29
	.member	_CRA_9,256,9,8,32,.fake31
	.member	_CarNum_H,288,12,8,32
	.member	_CarNum_L,320,12,8,32
	.eos
	.sym	_CRA_STATION,0,8,13,352,.fake14
	.sym	_PCRA_STATION,0,24,13,32,.fake14
	.stag	.fake33,704
	.member	_sUnitStat,0,252,8,576,,9,2
	.member	_sCarNumBcd_H,576,252,8,64,,1,2
	.member	_sCarNumBcd_L,640,252,8,64,,1,2
	.eos
	.sym	_CARSTAT_PRO,0,8,13,704,.fake33
	.stag	.fake34,8576
	.member	_phHdBuf,0,8,8,416,.fake11
	.member	_sPAC_T,416,60,8,64,,2
	.member	_sC_ID,480,60,8,64,,2
	.member	_sDO,544,60,8,64,,2
	.member	_sD1,608,60,8,64,,2
	.member	_sD2,672,60,8,64,,2
	.member	_sODM,736,252,8,256,,4,2
	.member	_sANS,992,60,8,64,,2
	.member	_sTRAN_NO,1056,252,8,192,,3,2
	.member	_sCRAW_ID,1248,252,8,192,,3,2
	.member	_sTRIP,1440,252,8,192,,3,2
	.member	_sD3,1632,60,8,64,,2
	.member	_sSTST,1696,252,8,128,,2,2
	.member	_sNOST,1824,252,8,128,,2,2
	.member	_sNEST,1952,252,8,128,,2,2
	.member	_sDEST,2080,252,8,128,,2,2
	.member	_sSPK,2208,252,8,128,,2,2
	.member	_sD4,2336,60,8,64,,2
	.member	_sD5,2400,60,8,64,,2
	.member	_sPR,2464,60,8,64,,2
	.member	_sPRVector,2528,252,8,128,,2,2
	.member	_sPACVector,2656,252,8,128,,2,2
	.member	_sFDI_SDI_Color,2784,252,8,128,,2,2
	.member	_sFDI_SDI_Vector1,2912,252,8,128,,2,2
	.member	_sFDI_SDI_Vector2,3040,252,8,128,,2,2
	.member	_sPII_Vector,3168,252,8,128,,2,2
	.member	_sPP_Line_Vector,3296,252,8,128,,2,2
	.member	_sPP_Vector,3424,252,8,128,,2,2
	.member	_sSP_Vector,3552,252,8,128,,2,2
	.member	_sROUTE_SKIP,3680,252,8,640,,10,2
	.member	_sCI_Index,4320,252,8,512,,8,2
	.member	_sCI_Fault,4832,60,8,64,,2
	.member	_sCCI,4896,60,8,64,,2
	.member	_sCPI,4960,60,8,64,,2
	.member	_phCRA_Sta,5024,1020,8,2816,,4,11,2
	.member	_sTrainLength,7840,60,8,64,,2
	.member	_sCI_IndexLic,7904,252,8,512,,8,2
	.member	_nCRC,8416,60,8,128,,4
	.member	_btEot,8544,12,8,32
	.eos
	.sym	_PAC_PAC,0,8,13,8576,.fake34
	.sym	_PPAC_PAC,0,24,13,32,.fake34
	.stag	.fake35,4800
	.member	_phHdBuf,0,8,8,416,.fake11
	.member	_sDO,416,60,8,64,,2
	.member	_sTRAN_NO,480,252,8,192,,3,2
	.member	_sCRAW_ID,672,252,8,192,,3,2
	.member	_sTRIP,864,252,8,192,,3,2
	.member	_sD1,1056,60,8,64,,2
	.member	_sSTST,1120,252,8,128,,2,2
	.member	_sNOST,1248,252,8,128,,2,2
	.member	_sNEST,1376,252,8,128,,2,2
	.member	_sDEST,1504,252,8,128,,2,2
	.member	_sSPK,1632,252,8,128,,2,2
	.member	_sODM,1760,252,8,256,,4,2
	.member	_sD2,2016,252,8,128,,2,2
	.member	_sD3,2144,252,8,128,,2,2
	.member	_sPR,2272,60,8,64,,2
	.member	_sPRVector,2336,252,8,128,,2,2
	.member	_sPACVector,2464,252,8,128,,2,2
	.member	_sFDI_SDI_Color,2592,252,8,128,,2,2
	.member	_sFDI_SDI_Vector1,2720,252,8,128,,2,2
	.member	_sFDI_SDI_Vector2,2848,252,8,128,,2,2
	.member	_sPII_Vector,2976,252,8,128,,2,2
	.member	_sPP_Line_Vector,3104,252,8,128,,2,2
	.member	_sPP_Vector,3232,252,8,128,,2,2
	.member	_sSP_Vector,3360,252,8,128,,2,2
	.member	_sROUTE_SKIP,3488,252,8,640,,10,2
	.member	_sCI_Index,4128,252,8,512,,8,2
	.member	_nCRC,4640,60,8,128,,4
	.member	_btEot,4768,12,8,32
	.eos
	.sym	_CCP_PAC,0,8,13,4800,.fake35
	.sym	_PCCP_PAC,0,24,13,32,.fake35
	.stag	.fake38,32
	.member	_Sp_0,0,14,18,1
	.member	_Sp_1,1,14,18,1
	.member	_CI_Fault,2,14,18,1
	.member	_DST,3,14,18,1
	.member	_Sp_4,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake37,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake38
	.eos
	.stag	.fake40,32
	.member	_All_Doors_Closed,0,14,18,1
	.member	_EP_Mode,1,14,18,1
	.member	_Traction,2,14,18,1
	.member	_Atcive_Cab,3,14,18,1
	.member	_Sp_4,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake39,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake40
	.eos
	.stag	.fake36,704
	.member	_phHdBuf,0,8,8,416,.fake11
	.member	_DATA2,416,9,8,32,.fake37
	.member	_DATA1,448,9,8,32,.fake39
	.member	_CI_Index_Num,480,60,8,64,,2
	.member	_nCRC,544,60,8,128,,4
	.member	_btEot,672,12,8,32
	.eos
	.sym	_LICSD,0,8,13,704,.fake36
	.sym	_PLICSDR,0,24,13,32,.fake36
	.stag	.fake41,480
	.member	_btSoh,0,12,8,32
	.member	_chSrcDev,32,60,8,64,,2
	.member	_chDestDev,96,60,8,64,,2
	.member	_chMsgCnt,160,60,8,128,,4
	.member	_chCmdCode,288,60,8,64,,2
	.member	_chDataLen,352,60,8,128,,4
	.eos
	.sym	_CNCSHD,0,8,13,480,.fake41
	.sym	_PCNCSHD,0,24,13,32,.fake41
	.stag	.fake42,10208
	.member	_phHdBuf,0,8,8,480,.fake41
	.member	_sCommand,480,60,8,64,,2
	.member	_sCarKind,544,60,8,64,,2
	.member	_sTextDataAsc,608,60,8,9600,,300
	.eos
	.sym	_LIC_CNCS_HD,0,8,13,10208,.fake42
	.sym	_PLIC_CNCS_HD,0,24,13,32,.fake42
	.stag	.fake43,320
	.member	_chVer,0,50,8,128,,4
	.member	_chBuildDate,128,50,8,192,,6
	.eos
	.sym	_CNCS_LIC_VERBDD_SD,0,8,13,320,.fake43
	.sym	_PCNCS_LIC_VERBDD_SD,0,24,13,32,.fake43
	.stag	.fake44,8096
	.member	_VerCnt,0,13,8,32
	.member	_cvbBuf,32,56,8,8000,.fake43,25
	.member	_CarNum,8032,61,8,64,,2
	.eos
	.sym	_LIC_DPRAM_Ver,0,8,13,8096,.fake44
	.sym	_PLIC_DPRAM_Ver,0,24,13,32,.fake44
	.stag	.fake45,9600
	.member	_phHdBuf,0,8,8,480,.fake41
	.member	_sCommand,480,60,8,64,,2
	.member	_sYear,544,60,8,64,,2
	.member	_sMonth,608,60,8,64,,2
	.member	_sDay,672,60,8,64,,2
	.member	_sHour,736,60,8,64,,2
	.member	_sMinute,800,60,8,64,,2
	.member	_sSecond,864,60,8,64,,2
	.member	_sWaySide,928,60,8,64,,2
	.member	_sDaType,992,60,8,64,,2
	.member	_sFaultTime,1056,60,8,256,,8
	.member	_cvbBuf,1312,56,8,8000,.fake43,25
	.member	_sRailNumVer,9312,60,8,128,,4
	.member	_nCRC,9440,60,8,128,,4
	.member	_btEot,9568,12,8,32
	.eos
	.sym	_CNCS_LIC_SD,0,8,13,9600,.fake45
	.sym	_PCNCS_LIC_SD,0,24,13,32,.fake45
	.stag	.fake46,896
	.member	_phHdBuf,0,8,8,480,.fake41
	.member	_sCommand,480,60,8,64,,2
	.member	_sTEXT,544,60,8,128,,4
	.member	_chContactSignalBuf,672,60,8,64,,2
	.member	_nCRC,736,60,8,128,,4
	.member	_btEot,864,12,8,32
	.eos
	.sym	_CNCS_LIC_T_F,0,8,13,896,.fake46
	.sym	_PCNCS_LIC_T_F,0,24,13,32,.fake46
	.stag	.fake47,832
	.member	_phHdBuf,0,8,8,480,.fake41
	.member	_sCommand,480,60,8,64,,2
	.member	_sTEXT,544,60,8,128,,4
	.member	_nCRC,672,60,8,128,,4
	.member	_btEot,800,12,8,32
	.eos
	.sym	_CNCS_LIC_T_F_C,0,8,13,832,.fake47
	.sym	_PCNCS_LIC_T_F_C,0,24,13,32,.fake47
	.stag	.fake48,96
	.member	_sChSum,0,60,8,64,,2
	.member	_sETX,64,12,8,32
	.eos
	.sym	_LIC_CNCS_ED,0,8,13,96,.fake48
	.sym	_PLIC_CNCS_ED,0,24,13,32,.fake48
	.stag	.fake50,32
	.member	_n1VTX,0,14,18,1
	.member	_n2CNCS,1,14,18,1
	.member	_n3PAC2,2,14,18,1
	.member	_n4LIC,3,14,18,1
	.member	_n5WLAN,4,14,18,1
	.member	_n6GPS,5,14,18,1
	.member	_n7PAC1,6,14,18,1
	.member	_n8sp,7,14,18,1
	.eos
	.stag	.fake51,32
	.member	_n1DPO1,0,14,18,1
	.member	_n2DPO2,1,14,18,1
	.member	_n3CCP1,2,14,18,1
	.member	_n4CCP2,3,14,18,1
	.member	_n5TRIC1,4,14,18,1
	.member	_n6TRIC2,5,14,18,1
	.member	_n7TR1,6,14,18,1
	.member	_n8TR2,7,14,18,1
	.eos
	.stag	.fake52,32
	.member	_n1Sp,0,14,18,1
	.member	_n2Sp,1,14,18,1
	.member	_n3CPO1,2,14,18,1
	.member	_n4CPO2,3,14,18,1
	.member	_n5CPO3,4,14,18,1
	.member	_n6CPO4,5,14,18,1
	.member	_n7Sp,6,14,18,1
	.member	_n8Sp,7,14,18,1
	.eos
	.stag	.fake53,32
	.member	_n1PEI1,0,14,18,1
	.member	_n2PEI2,1,14,18,1
	.member	_n3PEI3,2,14,18,1
	.member	_n4PEI4,3,14,18,1
	.member	_n5PEI5,4,14,18,1
	.member	_n6PEI6,5,14,18,1
	.member	_n7FDI1,6,14,18,1
	.member	_n8FDI2,7,14,18,1
	.eos
	.stag	.fake54,32
	.member	_n1SDI1,0,14,18,1
	.member	_n2SDI2,1,14,18,1
	.member	_n3SDI3,2,14,18,1
	.member	_n4SDI4,3,14,18,1
	.member	_n5SDI5,4,14,18,1
	.member	_n6SDI6,5,14,18,1
	.member	_n7SDI7,6,14,18,1
	.member	_n8SDI8,7,14,18,1
	.eos
	.stag	.fake55,32
	.member	_n1PID1_1,0,14,18,1
	.member	_n2PID1_2,1,14,18,1
	.member	_n3PID1_3,2,14,18,1
	.member	_n4PID1_4,3,14,18,1
	.member	_n5PID1_5,4,14,18,1
	.member	_n6PID1_6,5,14,18,1
	.member	_n7PID1_7,6,14,18,1
	.member	_n8PID1_8,7,14,18,1
	.eos
	.stag	.fake56,32
	.member	_n1PID2_1,0,14,18,1
	.member	_n2PID2_2,1,14,18,1
	.member	_n3PID2_3,2,14,18,1
	.member	_n4PID2_4,3,14,18,1
	.member	_n5PII1,4,14,18,1
	.member	_n6PII2,5,14,18,1
	.member	_n7PII3,6,14,18,1
	.member	_n8PII4,7,14,18,1
	.eos
	.stag	.fake49,256
	.member	_BYTE_1,0,8,8,32,.fake50
	.member	_BYTE_2,32,8,8,32,.fake51
	.member	_BYTE_3,64,8,8,32,.fake52
	.member	_BYTE_4,96,8,8,32,.fake53
	.member	_BYTE_5,128,12,8,32
	.member	_BYTE_6,160,8,8,32,.fake54
	.member	_BYTE_7,192,8,8,32,.fake55
	.member	_BYTE_8,224,8,8,32,.fake56
	.eos
	.sym	_COMMSTATUS_PA,0,8,13,256,.fake49
	.sym	_PCOMMSTATUS_PA,0,24,13,32,.fake49
	.stag	.fake59,32
	.member	_nCcp,0,14,18,1
	.member	_nsp,1,14,18,1
	.member	_nVtx,2,14,18,1
	.member	_nVoip,3,14,18,1
	.member	_nPac,4,14,18,1
	.member	_nLic,5,14,18,1
	.member	_nFdi,6,14,18,1
	.member	_nSdi1,7,14,18,1
	.eos
	.utag	.fake58,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake59
	.eos
	.stag	.fake61,32
	.member	_nSdi2,0,14,18,1
	.member	_nSdi3,1,14,18,1
	.member	_nSdi4,2,14,18,1
	.member	_nPii1,3,14,18,1
	.member	_nPii2,4,14,18,1
	.member	_nPid1_1,5,14,18,1
	.member	_nPid1_2,6,14,18,1
	.member	_nPid1_3,7,14,18,1
	.eos
	.utag	.fake60,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake61
	.eos
	.stag	.fake63,32
	.member	_nPid1_4,0,14,18,1
	.member	_nPid2_1,1,14,18,1
	.member	_nCncs,2,14,18,1
	.member	_CRA_LAUN,3,14,18,1
	.member	_CRA_UP,4,14,18,1
	.member	_CRA_PP,5,14,18,1
	.member	_CRA_SP,6,14,18,1
	.member	_CRA_FTP,7,14,18,1
	.eos
	.utag	.fake62,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake63
	.eos
	.stag	.fake65,32
	.member	_nPei1,0,14,18,1
	.member	_nPei2,1,14,18,1
	.member	_sp_2,2,14,18,1
	.member	_sp_3,3,14,18,1
	.member	_nDpo,4,14,18,1
	.member	_sp_5,5,14,18,1
	.member	_sp_6,6,14,18,1
	.member	_nDph,7,14,18,1
	.eos
	.utag	.fake64,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake65
	.eos
	.stag	.fake67,32
	.member	_sp_0,0,14,18,1
	.member	_sp_1,1,14,18,1
	.member	_sp_2,2,14,18,1
	.member	_sp_3,3,14,18,1
	.member	_sp_4,4,14,18,1
	.member	_sp_5,5,14,18,1
	.member	_sp_6,6,14,18,1
	.member	_sp_7,7,14,18,1
	.eos
	.utag	.fake66,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake67
	.eos
	.stag	.fake57,160
	.member	_BYTE_1,0,9,8,32,.fake58
	.member	_BYTE_2,32,9,8,32,.fake60
	.member	_BYTE_3,64,9,8,32,.fake62
	.member	_BYTE_4,96,9,8,32,.fake64
	.member	_BYTE_5,128,9,8,32,.fake66
	.eos
	.sym	_COMMSTATUS_LIC,0,8,13,160,.fake57
	.sym	_PCOMMSTATUS_LIC,0,24,13,32,.fake57
	.stag	.fake68,768
	.member	_nCcp_0,0,12,8,32
	.member	_nsp_1,32,12,8,32
	.member	_nVtx_2,64,12,8,32
	.member	_nVoip_3,96,12,8,32
	.member	_nPac_4,128,12,8,32
	.member	_nLic_5,160,12,8,32
	.member	_nFdi_6,192,12,8,32
	.member	_nSdi1_7,224,12,8,32
	.member	_nSdi2_8,256,12,8,32
	.member	_nSdi3_9,288,12,8,32
	.member	_nSdi4_10,320,12,8,32
	.member	_nPii1_11,352,12,8,32
	.member	_nPii2_12,384,12,8,32
	.member	_nPid1_1_13,416,12,8,32
	.member	_nPid1_2_14,448,12,8,32
	.member	_nPid1_3_15,480,12,8,32
	.member	_nPid1_4_16,512,12,8,32
	.member	_nPid2_1_17,544,12,8,32
	.member	_nCncs_18,576,12,8,32
	.member	_CRA_LAUN_19,608,12,8,32
	.member	_CRA_UP_20,640,12,8,32
	.member	_CRA_PP_21,672,12,8,32
	.member	_CRA_SP_22,704,12,8,32
	.member	_CRA_FTP_23,736,12,8,32
	.eos
	.sym	_COMMSTATUS_LIC_ERRCNT,0,8,13,768,.fake68
	.sym	_PCOMMSTATUS_LIC_ERRCNT,0,24,13,32,.fake68
	.etag	_eCDT_TYPE,32
	.member	_eCDT_A,0,4,16,32
	.member	_eCDT_B,1,4,16,32
	.member	_eCDT_MAXIMUM,2,4,16,32
	.eos
	.stag	.fake69,96
	.member	_nTCnt,0,4,8,32
	.member	_nStPosi,32,4,8,32
	.member	_nEdPosi,64,4,8,32
	.eos
	.sym	_T_FAULT_INFO,0,8,13,96,.fake69
	.sym	_PFAULT_INFO,0,24,13,32,.fake69
	.file	"Variable.h"
	.stag	.fake72,32
	.member	_Atcive_Cab,0,14,18,1
	.member	_Traction,1,14,18,1
	.member	_EP_Mode,2,14,18,1
	.member	_All_Doors_Closed,3,14,18,1
	.member	_Ci_CutOff,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake71,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake72
	.eos
	.stag	.fake70,11776
	.member	_LIC_VerList,0,242,8,7200,,25,9
	.member	_m_nUart1RxOneByteGapDelayTime,7200,14,8,32
	.member	_m_nUart2RxOneByteGapDelayTime,7232,14,8,32
	.member	_m_nUart3RxOneByteGapDelayTime,7264,14,8,32
	.member	_m_nUserDebug1msTimer,7296,14,8,32
	.member	_m_nTest1msTimer,7328,14,8,32
	.member	_m_tmCurTime,7360,8,8,224,.fake7
	.member	_m_tmUtcTime,7584,8,8,224,.fake7
	.member	_m_ProStartFlag,7808,12,8,32
	.member	_m_btCommSt,7840,60,8,256,,8
	.member	_m_btOldCommSt,8096,60,8,256,,8
	.member	_m_btSenseCommStBuf,8352,60,8,256,,8
	.member	_m_LIC_CNCS_Tx_Flag,8608,4,8,32
	.member	_m_LIC_CNCS_TX_DelyTime,8640,4,8,32
	.member	_m_nLnWkTxFlag,8672,4,8,32
	.member	_m_nFaultCnt,8704,4,8,32
	.member	_m_Recving_Posi,8736,4,8,32
	.member	_m_nCDT_FaultDataStFlag,8768,4,8,32
	.member	_m_TrainCofVal,8800,4,8,32
	.member	_m_TrainCofVal_Time_Flag,8832,4,8,32
	.member	_m_TrainCofVal_Chick,8864,4,8,32
	.member	_m_TrainCofVal_ing,8896,4,8,32
	.member	_m_nCarPos,8928,4,8,32
	.member	_m_nCarPos_Backup,8960,4,8,32
	.member	_m_btCiFaultVal,8992,4,8,32
	.member	_m_nCarNo,9024,13,8,32
	.member	_m_nCarNo_CncsRx,9056,13,8,32
	.member	_m_chCarKind,9088,2,8,32
	.member	_m_nCarKindToLonCnt,9120,4,8,32
	.member	_m_chCarKindNum,9152,2,8,32
	.member	_m_chCncsKindNum,9184,2,8,32
	.member	_m_bLnWkDbgTxFlag,9216,4,8,32
	.member	_m_nLnWkWaySideOnRxOk,9248,12,8,32
	.member	_m_nCarCnt,9280,12,8,32
	.member	_m_nNvsramPos,9312,14,8,32
	.member	_m_bLnWkFtpEndFlag,9344,4,8,32
	.member	_m_nDateTime2SecondCnt,9376,14,8,32
	.member	_m_nTxDbg1msTimer,9408,14,8,32
	.member	_m_nDbgTxPos,9440,14,8,32
	.member	_m_btExVersionTbl,9472,61,8,928,,29
	.member	_m_btExVersion_DAYTbl,10400,61,8,928,,29
	.member	_m_btCttSignalA,11328,9,8,32,.fake71
	.member	_m_btCttSignalB,11360,12,8,32
	.member	_m_LIC_CNCS_TimSetFlag,11392,4,8,32
	.member	_m_LIC_GIA_TimSetFlag,11424,4,8,32
	.member	_m_nCncsRxCheck1msTimer,11456,14,8,32
	.member	_m_nGiaRxCheck1msTimer,11488,14,8,32
	.member	_m_btTestOtherCiFault,11520,12,8,32
	.member	_m_bCiFaultFlag,11552,4,8,32
	.member	_m_tFaultInfo,11584,56,8,192,.fake69,2
	.eos
	.sym	_VARIABLE_H,0,8,13,11776,.fake70
	.sym	_PVARIABLE_H,0,24,13,32,.fake70
	.file	"LonInfo.h"
	.file	"xr16l784.h"
	.utag	.fake74,32
	.member	_btRxd,0,12,11,32
	.member	_btTxd,0,12,11,32
	.member	_btDll,0,12,11,32
	.eos
	.utag	.fake75,32
	.member	_btDlm,0,12,11,32
	.member	_btIer,0,12,11,32
	.eos
	.utag	.fake76,32
	.member	_btIir,0,12,11,32
	.member	_btFcr,0,12,11,32
	.eos
	.stag	.fake73,512
	.member	_CREG1,0,9,8,32,.fake74
	.member	_CREG2,32,9,8,32,.fake75
	.member	_CREG3,64,9,8,32,.fake76
	.member	_btLcr,96,12,8,32
	.member	_btMcr,128,12,8,32
	.member	_btLsr,160,12,8,32
	.member	_btMsr_U,192,12,8,32
	.member	_btScr,224,12,8,32
	.member	_btSp,256,60,8,256,,8
	.eos
	.sym	_XR16L784ST,0,8,13,512,.fake73
	.sym	_PXR16L784ST,0,24,13,32,.fake73
	.stag	.fake77,2048
	.member	_xr16Reg,0,56,8,2048,.fake73,4
	.eos
	.sym	_XR16L784BDY,0,8,13,2048,.fake77
	.sym	_PXR16L784BDY,0,24,13,32,.fake77
	.file	"user.c"
	.sect	 ".text"

	.global	_user_Init
	.sym	_user_Init,_user_Init,32,2,0
	.func	22
;******************************************************************************
;* FUNCTION NAME: _user_Init                                                  *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3,r4,r5,ar0,ar1,fp,ir0,bk,sp,st           *
;*   Regs Saved         : r4,r5                                               *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 136 Auto + 2 SOE = 140 words      *
;******************************************************************************
_user_Init:
	.sym	_i,1,4,1,32
	.sym	_wCarNo,2,4,1,32
	.sym	_LL,3,12,1,32
	.sym	_LH,4,12,1,32
	.sym	_HL,5,12,1,32
	.sym	_HH,6,12,1,32
	.sym	_szBuf,7,50,1,4096,,128
	.sym	_pDpram,135,28,1,32
	.sym	_pLicVerDp,136,24,1,32,.fake44
	.line	1
;----------------------------------------------------------------------
;  22 | void user_Init()                                                       
;  24 | int i;                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      136,sp
        push      r4
        push      r5
	.line	4
;----------------------------------------------------------------------
;  25 | int wCarNo = 0;                                                        
;  26 | UCHAR LL,LH,HL,HH;                                                     
;  27 | char szBuf[128];                                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	7
;----------------------------------------------------------------------
;  28 | UCHAR *pDpram = (UCHAR *)DPRAM_BASE;                                   
;----------------------------------------------------------------------
        ldiu      @CL1,r0
        sti       r0,*+fp(135)
	.line	9
;----------------------------------------------------------------------
;  30 | PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //¹öÀü Á¤º¸ Ã³¸
;     | ®¸¦ À§ÇØ ÀÓÀÇ·Î ¸¸µé¾ú´Ù.                                              
;----------------------------------------------------------------------
        ldiu      @CL2,r0
        sti       r0,*+fp(136)
	.line	11
;----------------------------------------------------------------------
;  32 | user_Variable_Init();                                                  
;  34 | // ÃÊ±âÈ­ÇÏ±â                                                          
;  35 | //timeGet(&m_tmCurTime);                                               
;----------------------------------------------------------------------
        call      _user_Variable_Init
                                        ; Call Occurs
	.line	15
;----------------------------------------------------------------------
;  36 | memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt)); //»óÅ
;     | Â µ¥ÀÌÅ¸ ÀúÀå ¹öÆÛ                                                     
;----------------------------------------------------------------------
        ldiu      8,r2
        ldiu      0,r1
        ldiu      @CL3,r0
        push      r2
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	16
;----------------------------------------------------------------------
;  37 | memset(m_Variable.m_btOldCommSt,0x00,sizeof(m_Variable.m_btOldCommSt));
;     |  //»óÅÂ µ¥ÀÌÅ¸ ÀúÀå ¹öÆÛ                                               
;----------------------------------------------------------------------
        ldiu      @CL4,r2
        ldiu      0,r1
        ldiu      8,r0
        push      r0
        push      r1
        push      r2
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	17
;----------------------------------------------------------------------
;  38 | memset(m_Variable.m_btSenseCommStBuf,0x00,sizeof(m_Variable.m_btSenseCo
;     | mmStBuf)); //»óÅÂ µ¥ÀÌÅ¸ ÀúÀå ¹öÆÛ                                     
;----------------------------------------------------------------------
        ldiu      8,r0
        ldiu      0,r1
        push      r0
        push      r1
        ldiu      @CL5,r2
        push      r2
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	19
;----------------------------------------------------------------------
;  40 | memset(m_Variable.m_btExVersionTbl,0x0000,sizeof(m_Variable.m_btExVersi
;     | onTbl));                                                               
;----------------------------------------------------------------------
        ldiu      29,r0
        ldiu      0,r1
        push      r0
        push      r1
        ldiu      @CL6,r2
        push      r2
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	20
;----------------------------------------------------------------------
;  41 | memset(m_Variable.m_btExVersion_DAYTbl,0x0000,sizeof(m_Variable.m_btExV
;     | ersion_DAYTbl));                                                       
;----------------------------------------------------------------------
        ldiu      29,r0
        push      r0
        ldiu      @CL7,r2
        ldiu      0,r1
        push      r1
        push      r2
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	22
;----------------------------------------------------------------------
;  43 | memset(&m_MDS_ErrCnt, 0x00, sizeof(m_MDS_ErrCnt));                     
;----------------------------------------------------------------------
        ldiu      @CL8,r2
        ldiu      24,r0
        ldiu      0,r1
        push      r0
        push      r1
        push      r2
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	24
;----------------------------------------------------------------------
;  45 | m_Variable.m_LIC_CNCS_Tx_Flag = FALSE;                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+269
	.line	25
;----------------------------------------------------------------------
;  46 | m_Variable.m_LIC_CNCS_TX_DelyTime = 0;                                 
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+270
	.line	26
;----------------------------------------------------------------------
;  47 | m_Variable.m_nLnWkTxFlag = FALSE;                                      
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+271
	.line	27
;----------------------------------------------------------------------
;  48 | m_Variable.m_nFaultCnt = 0;                                            
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+272
	.line	28
;----------------------------------------------------------------------
;  49 | m_Variable.m_Recving_Posi = 0;                                         
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+273
	.line	29
;----------------------------------------------------------------------
;  50 | m_Variable.m_nCDT_FaultDataStFlag = FALSE;                             
;  53 | //memset(&m_Variable,0x00,sizeof(m_Variable));                         
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+274
	.line	35
;----------------------------------------------------------------------
;  56 | for(i=0;i<VER_BDD_MAX_CNT;i++)                                         
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      25,r0
        bge       L19
;*      Branch Occurs to L19 
L2:        
	.line	38
;----------------------------------------------------------------------
;  59 | if(WORD_L(pLicVerDp->VerCnt) == TRUE)                                  
;  61 |         // ¹öÀü Á¤º¸°¡  '0' ~ '9' ¼ý°¡ÀÎÁö È®ÀÎ ÇÑ´Ù. --> ¾Æ´Ï¸é ÃÊ±âÈ­
;     |  ÇÑ´Ù.(¾²·¹±â °ªÀÌ µé¾î ÀÖ´Â °É·Î ÆÇ´Ü)                                
;----------------------------------------------------------------------
        ldiu      *+fp(136),ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
        cmpi      1,r0
        bned      L17
	nop
        ldine     *+fp(136),ar0
        ldine     1,r0
;*      Branch Occurs to L17 
	.line	41
;----------------------------------------------------------------------
;  62 | if( !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[0])) || !IsNumAsc(WORD_
;     | L(pLicVerDp->cvbBuf[i].chVer[1])) ||                                   
;  63 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[2])) || !IsNumAsc(W
;     | ORD_L(pLicVerDp->cvbBuf[i].chVer[3])) ||                               
;  65 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[0])) || !IsNu
;     | mAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[1])) ||                   
;  66 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[2])) || !IsNu
;     | mAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[3])) ||                   
;  67 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[4])) || !IsNu
;     | mAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[5])))                     
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(1),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(2),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(3),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(4),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(5),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(6),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(7),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(8),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(9),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L13
;*      Branch Occurs to L13 
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(10),r0
        push      r0
        call      _IsNumAsc
                                        ; Call Occurs
        cmpi      0,r0
        bned      L15
        subi      1,sp
	nop
        ldine     *+fp(1),ar0
;*      Branch Occurs to L15 
L13:        
	.line	48
;----------------------------------------------------------------------
;  69 | memset(pLicVerDp->cvbBuf[i].chVer,'0',4);                              
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      4,r2
        ldiu      48,r1
        mpyi      10,r0
        addi      *+fp(136),r0          ; Unsigned
        push      r2
        addi      1,r0                  ; Unsigned
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	49
;----------------------------------------------------------------------
;  70 | memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);                        
;  72 | else                                                                   
;  73 | {   //°¢ ÀåÄ¡ ¹öÀü Á¤º¸¸¦ ÀÐ¾î¿Â´Ù.                                    
;----------------------------------------------------------------------
        ldiu      6,r2
        ldiu      *+fp(1),r0
        ldiu      48,r1
        mpyi      10,r0
        addi      *+fp(136),r0          ; Unsigned
        push      r2
        push      r1
        addi      5,r0                  ; Unsigned
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
        bu        L18
;*      Branch Occurs to L18 
	.line	53
;----------------------------------------------------------------------
;  74 | LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[0])),ConvA
;     | sc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[1])));                        
;----------------------------------------------------------------------
L15:        
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(1),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      255,r1
        ldiu      *+fp(1),ar0
        ldiu      r0,r4
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ash       4,r4
        and       *+ar0(2),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(4)
	.line	54
;----------------------------------------------------------------------
;  75 | LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[2])),ConvA
;     | sc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[3])));                        
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(3),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        ldiu      255,r1
        addi      *+fp(136),ar0         ; Unsigned
        ash       4,r4
        and       *+ar0(4),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(3)
	.line	55
;----------------------------------------------------------------------
;  76 | m_Variable.m_btExVersionTbl[i] = MAKE_WORD(LH,LL);                     
;----------------------------------------------------------------------
        ldiu      255,r0
        ldiu      *+fp(4),r1
        and       *+fp(3),r0
        ash       8,r1
        or3       r1,r0,r0
        ldiu      @CL6,ar0
        ldiu      *+fp(1),ir0
        and       65535,r0
        sti       r0,*+ar0(ir0)
	.line	56
;----------------------------------------------------------------------
;  77 | HH = 0x20;                                                             
;----------------------------------------------------------------------
        ldiu      32,r0
        sti       r0,*+fp(6)
	.line	57
;----------------------------------------------------------------------
;  78 | HL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[0]))
;     | ,ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[1])));            
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(5),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r1
        ldiu      r0,r4
        ash       4,r4
        and       *+ar0(6),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        subi      1,sp
        or3       r4,r0,r0
        and       255,r0
        sti       r0,*+fp(5)
	.line	58
;----------------------------------------------------------------------
;  79 | LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[2]))
;     | ,ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[3])));            
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(7),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        ldiu      255,r0
        subi      1,sp
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ash       4,r4
        and       *+ar0(8),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,*+fp(4)
	.line	59
;----------------------------------------------------------------------
;  80 | LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[4]))
;     | ,ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[5])));            
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        mpyi      10,ar0
        addi      *+fp(136),ar0         ; Unsigned
        ldiu      255,r0
        and       *+ar0(9),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(1),ar0
        ldiu      255,r1
        mpyi      10,ar0
        ldiu      r0,r4
        addi      *+fp(136),ar0         ; Unsigned
        ash       4,r4
        and       *+ar0(10),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(3)
	.line	61
;----------------------------------------------------------------------
;  82 | m_Variable.m_btExVersion_DAYTbl[i] = MAKE_DWORD(HH,HL,LH,LL);          
;  85 | else //ÇÑ¹øµµ ¹öÀü Á¤º¸ ÀÔ·ÂÀÌ µÇÁö¾ÊÀ» °æ¿ì 0 À¸·Î ÃÊ±âÈ­ ÇÑ´Ù.       
;----------------------------------------------------------------------
        ldiu      255,r0
        ldiu      *+fp(6),r3
        and       *+fp(5),r0
        ash       24,r3
        ash       16,r0
        or3       r3,r0,r0
        ldiu      255,r1
        and       *+fp(4),r1
        ldiu      255,r2
        ash       8,r1
        and       *+fp(3),r2
        ldiu      @CL7,ar0
        or3       r0,r1,r0
        ldiu      *+fp(1),ir0
        or3       r0,r2,r0
        sti       r0,*+ar0(ir0)
        bu        L18
;*      Branch Occurs to L18 
	.line	66
;----------------------------------------------------------------------
;  87 | pLicVerDp->VerCnt = TRUE;                                              
;----------------------------------------------------------------------
L17:        
        sti       r0,*ar0
	.line	67
;----------------------------------------------------------------------
;  88 | memset(pLicVerDp->cvbBuf[i].chVer,'0',4);                              
;----------------------------------------------------------------------
        ldiu      4,r2
        ldiu      48,r1
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi      *+fp(136),r0          ; Unsigned
        push      r2
        addi      1,r0                  ; Unsigned
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	68
;----------------------------------------------------------------------
;  89 | memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);                        
;  93 | // LIC-MPUÁ¦¾î±â ¹öÁ¯ & ºôµåµ¥ÀÌÆ®                                     
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi      *+fp(136),r0          ; Unsigned
        ldiu      6,r2
        push      r2
        ldiu      48,r1
        push      r1
        addi      5,r0                  ; Unsigned
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
L18:        
	.line	35
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      25,r0
        blt       L2
;*      Branch Occurs to L2 
L19:        
	.line	73
;----------------------------------------------------------------------
;  94 | m_Variable.m_btExVersionTbl[5] = MAKE_WORD(                            
;  95 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(1)/1000%10),ConvHex2Asc(GetFirmwareVersion(1)
;     | /100%10)),                                                             
;  96 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(1)/10%10),ConvHex2Asc(GetFirmwareVersion(1)%1
;     | 0))                                                                    
;  97 |                                                         );             
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      1000,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      1,r1
        ldiu      r0,r4
        subi      1,sp
        push      r1
        ash       4,r4
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      100,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      1,r1
        and       15,r0
        or3       r4,r0,r5
        and       255,r5
        subi      1,sp
        ash       8,r5
        push      r1
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      1,r1
        ldiu      r0,r4
        push      r1
        ash       4,r4
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        or3       r5,r0,r0
        and       65535,r0
        sti       r0,@_m_Variable+301
        subi      1,sp
	.line	78
;----------------------------------------------------------------------
;  99 | m_Variable.m_btExVersion_DAYTbl[5] = MAKE_DWORD(                       
; 100 |                                                         0x20,          
; 101 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(2)/100000%10),ConvHex2Asc(GetFirmwareVersion(
;     | 2)/10000%10)),                                                         
; 102 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(2)/1000%10),ConvHex2Asc(GetFirmwareVersion(2)
;     | /100%10)),                                                             
; 103 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(2)/10%10),ConvHex2Asc(GetFirmwareVersion(2)%1
;     | 0))                                                                    
; 104 |                                                         );             
;----------------------------------------------------------------------
        ldiu      2,r0
        push      r0
        call      _GetFirmwareVersion
                                        ; Call Occurs
        ldiu      @CL9,r1
        subi      1,sp
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      2,r1
        push      r1
        ldiu      r0,r4
        ash       4,r4
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      10000,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      2,r1
        and       15,r0
        subi      1,sp
        or3       r4,r0,r4
        push      r1
        and       255,r4
        ash       16,r4
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      1000,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      r0,r5
        ldiu      2,r1
        subi      1,sp
        push      r1
        ash       4,r5
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      100,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        and       15,r0
        ldiu      2,r1
        or3       r5,r0,r0
        and       255,r0
        ash       8,r0
        subi      1,sp
        or3       r4,r0,r5
        push      r1
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      2,r1
        ldiu      r0,r4
        push      r1
        ash       4,r4
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        or3       r5,r0,r0
        or        @CL10,r0
        sti       r0,@_m_Variable+330
        subi      1,sp
	.line	85
;----------------------------------------------------------------------
; 106 | i = GetFirmwareVersion(1);                                             
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(1)
	.line	86
;----------------------------------------------------------------------
; 107 | sprintf(szBuf,"Lonwork Monitor Program, Version:%d.%d%d%d\r\n",i/1000%1
;     | 0,i/100%10,i/10%10,i%10);                                              
;----------------------------------------------------------------------
        ldiu      1000,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      100,r1
        ldiu      r0,bk
        ldiu      *+fp(1),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      r0,r3
        ldiu      10,r1
        ldiu      *+fp(1),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      r0,ir0
        ldiu      10,r1
        ldiu      *+fp(1),r0
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,r1
        ldiu      @CL11,r2
        push      r0
        push      ir0
        push      r3
        push      bk
        addi      7,r1
        push      r2
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      6,sp
	.line	87
;----------------------------------------------------------------------
; 108 | user_DebugPrint(szBuf);                                                
; 110 | // ¾îµå·¹½º¿¡ ´ëÇÑ ÃÊ±â ¼³Á¤ °ª.                                       
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      7,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	90
;----------------------------------------------------------------------
; 111 | if(DI_ADDRESS_A)                                                       
;----------------------------------------------------------------------
        ldiu      @CL12,ar0
        ldiu      1,r0
        tstb3     *ar0,r0
        beqd      L26
	nop
        ldieq     @CL12,ar0
        ldieq     -1,r0
;*      Branch Occurs to L26 
	.line	92
;----------------------------------------------------------------------
; 113 | m_Variable.m_chCarKindNum = LIC_DEV_NO;                                
;----------------------------------------------------------------------
        ldiu      34,r0
        sti       r0,@_m_Variable+286
	.line	93
;----------------------------------------------------------------------
; 114 | m_Variable.m_chCncsKindNum = CNCS_DEV_NUM_A; //                        
;----------------------------------------------------------------------
        ldiu      36,r0
        sti       r0,@_m_Variable+287
	.line	95
;----------------------------------------------------------------------
; 116 | m_Variable.m_chCarKind = 'A';                                          
;----------------------------------------------------------------------
        ldiu      65,r0
        sti       r0,@_m_Variable+284
	.line	96
;----------------------------------------------------------------------
; 117 | m_Variable.m_nCarNo = MAKE_WORD(pLicVerDp->CarNum[0],pLicVerDp->CarNum[
;     | 1]);                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(136),ar1
        ldiu      ar1,ar0
        ldiu      *+ar1(251),r1
        ldiu      255,r0
        ash       8,r1
        and       *+ar0(252),r0
        or3       r1,r0,r0
        and       65535,r0
        sti       r0,@_m_Variable+282
	.line	97
;----------------------------------------------------------------------
; 118 | m_Variable.m_nCarNo_CncsRx = 0;                                        
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+283
	.line	99
;----------------------------------------------------------------------
; 120 | m_Variable.m_nCarPos = 1;                                              
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+279
        bu        L28
;*      Branch Occurs to L28 
	.line	101
;----------------------------------------------------------------------
; 122 | else if(DI_ADDRESS_B)                                                  
;----------------------------------------------------------------------
L26:        
        lsh3      r0,*ar0,r0
        tstb      1,r0
        beq       L28
;*      Branch Occurs to L28 
	.line	103
;----------------------------------------------------------------------
; 124 | m_Variable.m_chCarKindNum = LIC_BAKDEV_NO;                             
;----------------------------------------------------------------------
        ldiu      38,r0
        sti       r0,@_m_Variable+286
	.line	104
;----------------------------------------------------------------------
; 125 | m_Variable.m_chCncsKindNum = CNCS_DEV_NUM_B; //                        
;----------------------------------------------------------------------
        ldiu      40,r0
        sti       r0,@_m_Variable+287
	.line	105
;----------------------------------------------------------------------
; 126 | m_Variable.m_chCarKind = 'B';                                          
;----------------------------------------------------------------------
        ldiu      66,r0
        sti       r0,@_m_Variable+284
	.line	106
;----------------------------------------------------------------------
; 127 | m_Variable.m_nCarNo = MAKE_WORD(pLicVerDp->CarNum[0],pLicVerDp->CarNum[
;     | 1]);                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(136),ar1
        ldiu      ar1,ar0
        ldiu      *+ar1(251),r1
        ldiu      255,r0
        ash       8,r1
        and       *+ar0(252),r0
        or3       r1,r0,r0
        and       65535,r0
        sti       r0,@_m_Variable+282
	.line	107
;----------------------------------------------------------------------
; 128 | m_Variable.m_nCarNo_CncsRx = 0;                                        
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+283
	.line	108
;----------------------------------------------------------------------
; 129 | m_Variable.m_nCarPos = 2;                                              
;----------------------------------------------------------------------
        ldiu      2,r0
        sti       r0,@_m_Variable+279
L28:        
	.line	110
        pop       r5
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      138,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	131,000000030h,136


	.sect	 ".text"

	.global	_user_Variable_Init
	.sym	_user_Variable_Init,_user_Variable_Init,32,2,0
	.func	135
;******************************************************************************
;* FUNCTION NAME: _user_Variable_Init                                         *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,fp,sp                                      *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_user_Variable_Init:
	.line	1
;----------------------------------------------------------------------
; 135 | void user_Variable_Init()                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 137 | memset(&m_Variable,0x00,sizeof(VARIABLE_H));                           
;----------------------------------------------------------------------
        ldiu      368,r2
        ldiu      0,r0
        ldiu      @CL13,r1
        push      r2
        push      r0
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	5
;----------------------------------------------------------------------
; 139 | m_Variable.m_TrainCofVal = 0x8000;                                     
;----------------------------------------------------------------------
        ldiu      @CL14,r0
        sti       r0,@_m_Variable+275
	.line	7
;----------------------------------------------------------------------
; 141 | m_Variable.m_TrainCofVal_Time_Flag = 0;                                
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+276
	.line	8
;----------------------------------------------------------------------
; 142 | m_Variable.m_TrainCofVal_Chick = 0;                                    
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+277
	.line	11
;----------------------------------------------------------------------
; 145 | m_Variable.m_nCarPos = 0x8000;                                         
;----------------------------------------------------------------------
        ldiu      @CL14,r0
        sti       r0,@_m_Variable+279
	.line	12
;----------------------------------------------------------------------
; 146 | m_Variable.m_btCiFaultVal = 0x8000;                                    
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+281
	.line	13
;----------------------------------------------------------------------
; 147 | m_Variable.m_nCarNo = 0x8000;                                          
;----------------------------------------------------------------------
        ldiu      @CL15,r0
        sti       r0,@_m_Variable+282
	.line	14
;----------------------------------------------------------------------
; 148 | m_Variable.m_chCarKind = 'A';                                          
;----------------------------------------------------------------------
        ldiu      65,r0
        sti       r0,@_m_Variable+284
	.line	15
;----------------------------------------------------------------------
; 149 | m_Variable.m_bLnWkFtpEndFlag = FALSE;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+292
	.line	16
;----------------------------------------------------------------------
; 150 | m_Variable.m_nDbgTxPos = 0xFFFFFFFF;                                   
;----------------------------------------------------------------------
        ldiu      @CL16,r0
        sti       r0,@_m_Variable+295
	.line	17
;----------------------------------------------------------------------
; 151 | m_Variable.m_btTestOtherCiFault = 0x8000;                              
;----------------------------------------------------------------------
        ldiu      @CL17,r0
        sti       r0,@_m_Variable+360
	.line	18
;----------------------------------------------------------------------
; 152 | m_Variable.m_bCiFaultFlag = FALSE;                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+361
	.line	20
;----------------------------------------------------------------------
; 154 | strcpy(&m_Variable.LIC_VerList[0][0],"CCP");                           
;----------------------------------------------------------------------
        ldiu      @CL13,r1
        ldiu      @CL18,r0
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	21
;----------------------------------------------------------------------
; 155 | strcpy(&m_Variable.LIC_VerList[1][0],"CRA-LICL");                      
;----------------------------------------------------------------------
        ldiu      @CL20,r0
        ldiu      @CL19,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	22
;----------------------------------------------------------------------
; 156 | strcpy(&m_Variable.LIC_VerList[2][0],"CRA-VTX");                       
;----------------------------------------------------------------------
        ldiu      @CL22,r0
        ldiu      @CL21,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	23
;----------------------------------------------------------------------
; 157 | strcpy(&m_Variable.LIC_VerList[3][0],"CRA-VOIP");                      
;----------------------------------------------------------------------
        ldiu      @CL24,r0
        ldiu      @CL23,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	24
;----------------------------------------------------------------------
; 158 | strcpy(&m_Variable.LIC_VerList[4][0],"CRA-PAC");                       
;----------------------------------------------------------------------
        ldiu      @CL26,r0
        push      r0
        ldiu      @CL25,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	25
;----------------------------------------------------------------------
; 159 | strcpy(&m_Variable.LIC_VerList[5][0],"CRA-LICM");                      
;----------------------------------------------------------------------
        ldiu      @CL28,r0
        ldiu      @CL27,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	26
;----------------------------------------------------------------------
; 160 | strcpy(&m_Variable.LIC_VerList[6][0],"FDI1");                          
;----------------------------------------------------------------------
        ldiu      @CL30,r0
        push      r0
        ldiu      @CL29,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	27
;----------------------------------------------------------------------
; 161 | strcpy(&m_Variable.LIC_VerList[7][0],"SDI1");                          
;----------------------------------------------------------------------
        ldiu      @CL32,r0
        push      r0
        ldiu      @CL31,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	28
;----------------------------------------------------------------------
; 162 | strcpy(&m_Variable.LIC_VerList[8][0],"SDI2");                          
;----------------------------------------------------------------------
        ldiu      @CL34,r0
        push      r0
        ldiu      @CL33,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	29
;----------------------------------------------------------------------
; 163 | strcpy(&m_Variable.LIC_VerList[9][0],"SDI3");                          
;----------------------------------------------------------------------
        ldiu      @CL36,r0
        ldiu      @CL35,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	30
;----------------------------------------------------------------------
; 164 | strcpy(&m_Variable.LIC_VerList[10][0],"SDI4");                         
;----------------------------------------------------------------------
        ldiu      @CL38,r0
        ldiu      @CL37,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	31
;----------------------------------------------------------------------
; 165 | strcpy(&m_Variable.LIC_VerList[11][0],"PII1");                         
;----------------------------------------------------------------------
        ldiu      @CL40,r0
        ldiu      @CL39,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	32
;----------------------------------------------------------------------
; 166 | strcpy(&m_Variable.LIC_VerList[12][0],"PII2");                         
;----------------------------------------------------------------------
        ldiu      @CL42,r0
        push      r0
        ldiu      @CL41,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	33
;----------------------------------------------------------------------
; 167 | strcpy(&m_Variable.LIC_VerList[13][0],"VRX1");                         
;----------------------------------------------------------------------
        ldiu      @CL44,r0
        ldiu      @CL43,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	34
;----------------------------------------------------------------------
; 168 | strcpy(&m_Variable.LIC_VerList[14][0],"VRX2");                         
;----------------------------------------------------------------------
        ldiu      @CL46,r0
        push      r0
        ldiu      @CL45,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	35
;----------------------------------------------------------------------
; 169 | strcpy(&m_Variable.LIC_VerList[15][0],"VRX3");                         
;----------------------------------------------------------------------
        ldiu      @CL48,r0
        ldiu      @CL47,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	36
;----------------------------------------------------------------------
; 170 | strcpy(&m_Variable.LIC_VerList[16][0],"VRX4");                         
;----------------------------------------------------------------------
        ldiu      @CL50,r0
        ldiu      @CL49,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	37
;----------------------------------------------------------------------
; 171 | strcpy(&m_Variable.LIC_VerList[17][0],"VRX5");                         
;----------------------------------------------------------------------
        ldiu      @CL52,r0
        push      r0
        ldiu      @CL51,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	38
;----------------------------------------------------------------------
; 172 | strcpy(&m_Variable.LIC_VerList[18][0],"CRA-MAIN");                     
;----------------------------------------------------------------------
        ldiu      @CL54,r0
        push      r0
        ldiu      @CL53,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	39
;----------------------------------------------------------------------
; 173 | strcpy(&m_Variable.LIC_VerList[19][0],"CRA-LAUN");                     
;----------------------------------------------------------------------
        ldiu      @CL56,r0
        push      r0
        ldiu      @CL55,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	40
;----------------------------------------------------------------------
; 174 | strcpy(&m_Variable.LIC_VerList[20][0],"CRA-UP");                       
;----------------------------------------------------------------------
        ldiu      @CL58,r0
        ldiu      @CL57,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	41
;----------------------------------------------------------------------
; 175 | strcpy(&m_Variable.LIC_VerList[21][0],"CRA-PP");                       
;----------------------------------------------------------------------
        ldiu      @CL60,r0
        ldiu      @CL59,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	42
;----------------------------------------------------------------------
; 176 | strcpy(&m_Variable.LIC_VerList[22][0],"CRA-SP");                       
;----------------------------------------------------------------------
        ldiu      @CL62,r0
        ldiu      @CL61,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	43
;----------------------------------------------------------------------
; 177 | strcpy(&m_Variable.LIC_VerList[23][0],"CRA-FTP");                      
;----------------------------------------------------------------------
        ldiu      @CL64,r0
        push      r0
        ldiu      @CL63,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	44
;----------------------------------------------------------------------
; 178 | strcpy(&m_Variable.LIC_VerList[24][0],"CRA-CDT");                      
;----------------------------------------------------------------------
        ldiu      @CL65,r0
        ldiu      @CL66,r1
        push      r1
        push      r0
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	45
;----------------------------------------------------------------------
; 179 | m_Variable.LIC_VerList[25][0] = NULL;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+225
	.line	47
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	181,000000000h,0


	.sect	 ".text"

	.global	_user_Loop
	.sym	_user_Loop,_user_Loop,32,2,0
	.func	185
;******************************************************************************
;* FUNCTION NAME: _user_Loop                                                  *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs :                                                     *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 1 Auto + 0 SOE = 3 words          *
;******************************************************************************
_user_Loop:
	.sym	_i,1,4,1,32
	.line	1
;----------------------------------------------------------------------
; 185 | void user_Loop()                                                       
; 187 | int i;                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	5
;----------------------------------------------------------------------
; 189 | LonWorkLoop();                                                         
;----------------------------------------------------------------------
        call      _LonWorkLoop
                                        ; Call Occurs
	.line	7
;----------------------------------------------------------------------
; 191 | DebugLoop();                                                           
;----------------------------------------------------------------------
        call      _DebugLoop
                                        ; Call Occurs
	.line	9
;----------------------------------------------------------------------
; 193 | user_WithCncsRs232Loop();                                              
;----------------------------------------------------------------------
        call      _user_WithCncsRs232Loop
                                        ; Call Occurs
	.line	11
;----------------------------------------------------------------------
; 195 | user_WithPacRs485Loop();                                               
;----------------------------------------------------------------------
        call      _user_WithPacRs485Loop
                                        ; Call Occurs
	.line	13
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	197,000000000h,1


	.sect	 ".text"

	.global	_user_Lic2LicLoop
	.sym	_user_Lic2LicLoop,_user_Lic2LicLoop,32,2,0
	.func	203
;******************************************************************************
;* FUNCTION NAME: _user_Lic2LicLoop                                           *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs :                                                     *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_user_Lic2LicLoop:
	.line	1
;----------------------------------------------------------------------
; 203 | void user_Lic2LicLoop()                                                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	68
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	270,000000000h,0


	.sect	 ".text"

	.global	_user_IsSingleOrMarried
	.sym	_user_IsSingleOrMarried,_user_IsSingleOrMarried,36,2,0
	.func	281
;******************************************************************************
;* FUNCTION NAME: _user_IsSingleOrMarried                                     *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0                                                  *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_user_IsSingleOrMarried:
	.line	1
;----------------------------------------------------------------------
; 281 | int user_IsSingleOrMarried()                                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 283 | return 1;                                                              
;----------------------------------------------------------------------
        ldiu      1,r0
	.line	4
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	284,000000000h,0


	.sect	 ".text"

	.global	_user_DebugRx
	.sym	_user_DebugRx,_user_DebugRx,36,2,0
	.func	289
;******************************************************************************
;* FUNCTION NAME: _user_DebugRx                                               *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,fp,sp                                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 0 Auto + 0 SOE = 4 words          *
;******************************************************************************
_user_DebugRx:
	.sym	_pBuf,-2,28,9,32
	.sym	_nRxBuffLen,-3,4,9,32
	.line	1
;----------------------------------------------------------------------
; 289 | int user_DebugRx(UCHAR *pBuf,int nRxBuffLen)                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 291 | return xr16l784_GetRxBuffer1Ch(pBuf,nRxBuffLen);                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        push      r0
        ldiu      *-fp(2),r0
        push      r0
        call      _xr16l784_GetRxBuffer1Ch
                                        ; Call Occurs
        subi      2,sp
	.line	4
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	292,000000000h,0


	.sect	 ".text"

	.global	_user_DebugPrint
	.sym	_user_DebugPrint,_user_DebugPrint,32,2,0
	.func	294
;******************************************************************************
;* FUNCTION NAME: _user_DebugPrint                                            *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,fp,sp                                         *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 0 Auto + 0 SOE = 3 words          *
;******************************************************************************
_user_DebugPrint:
	.sym	_pTxBuf,-2,18,9,32
	.line	1
;----------------------------------------------------------------------
; 294 | void user_DebugPrint(char *pTxBuf)                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 296 | xr16l784_Send(XR16L784_1CHL,(UCHAR *)pTxBuf,strlen(pTxBuf));           
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      0,r1
        subi      1,sp
        push      r0
        ldiu      *-fp(2),r0
        push      r0
        push      r1
        call      _xr16l784_Send
                                        ; Call Occurs
        subi      3,sp
	.line	4
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	297,000000000h,0


	.sect	 ".text"

	.global	_user_CncsRx
	.sym	_user_CncsRx,_user_CncsRx,36,2,0
	.func	300
;******************************************************************************
;* FUNCTION NAME: _user_CncsRx                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,fp,sp                                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 0 Auto + 0 SOE = 4 words          *
;******************************************************************************
_user_CncsRx:
	.sym	_pBuf,-2,28,9,32
	.sym	_nRxBuffLen,-3,4,9,32
	.line	1
;----------------------------------------------------------------------
; 300 | int user_CncsRx(UCHAR *pBuf,int nRxBuffLen)                            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 302 | return xr16l784_GetRxBuffer2Ch(pBuf,nRxBuffLen);                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        push      r0
        ldiu      *-fp(2),r0
        push      r0
        call      _xr16l784_GetRxBuffer2Ch
                                        ; Call Occurs
        subi      2,sp
	.line	4
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	303,000000000h,0


	.sect	 ".text"

	.global	_user_CncsTx
	.sym	_user_CncsTx,_user_CncsTx,32,2,0
	.func	305
;******************************************************************************
;* FUNCTION NAME: _user_CncsTx                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,fp,sp                                         *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 0 Auto + 0 SOE = 4 words          *
;******************************************************************************
_user_CncsTx:
	.sym	_pTxBuf,-2,28,9,32
	.sym	_nTxLen,-3,4,9,32
	.line	1
;----------------------------------------------------------------------
; 305 | void user_CncsTx(UCHAR *pTxBuf,int nTxLen)                             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 307 | xr16l784_RtsDelayStartSend(XR16L784_2CHL,(UCHAR *)pTxBuf,nTxLen,10);   
; 308 | //xr16l784_Send(XR16L784_2CHL,(UCHAR *)pTxBuf,nTxLen);                 
;----------------------------------------------------------------------
        ldiu      10,r0
        ldiu      1,r1
        push      r0
        ldiu      *-fp(3),r0
        push      r0
        ldiu      *-fp(2),r0
        push      r0
        push      r1
        call      _xr16l784_RtsDelayStartSend
                                        ; Call Occurs
        subi      4,sp
	.line	5
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	309,000000000h,0


	.sect	 ".text"

	.global	_user_PacRx
	.sym	_user_PacRx,_user_PacRx,36,2,0
	.func	313
;******************************************************************************
;* FUNCTION NAME: _user_PacRx                                                 *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,fp,sp                                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 0 Auto + 0 SOE = 4 words          *
;******************************************************************************
_user_PacRx:
	.sym	_pBuf,-2,28,9,32
	.sym	_nRxBuffLen,-3,4,9,32
	.line	1
;----------------------------------------------------------------------
; 313 | int user_PacRx(UCHAR *pBuf,int nRxBuffLen)                             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 315 | return xr16l784_GetRxBuffer3Ch(pBuf,nRxBuffLen);                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        push      r0
        ldiu      *-fp(2),r0
        push      r0
        call      _xr16l784_GetRxBuffer3Ch
                                        ; Call Occurs
        subi      2,sp
	.line	4
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	316,000000000h,0


	.sect	 ".text"

	.global	_user_PacTx
	.sym	_user_PacTx,_user_PacTx,32,2,0
	.func	318
;******************************************************************************
;* FUNCTION NAME: _user_PacTx                                                 *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,fp,sp                                         *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 0 Auto + 0 SOE = 4 words          *
;******************************************************************************
_user_PacTx:
	.sym	_pTxBuf,-2,28,9,32
	.sym	_nTxLen,-3,4,9,32
	.line	1
;----------------------------------------------------------------------
; 318 | void user_PacTx(UCHAR *pTxBuf,int nTxLen)                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 320 | xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)pTxBuf,nTxLen,10);   
;----------------------------------------------------------------------
        ldiu      10,r0
        ldiu      2,r1
        push      r0
        ldiu      *-fp(3),r0
        push      r0
        ldiu      *-fp(2),r0
        push      r0
        push      r1
        call      _xr16l784_RtsDelayStartSend
                                        ; Call Occurs
        subi      4,sp
	.line	4
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	321,000000000h,0


	.sect	 ".text"

	.global	_BitSwap
	.sym	_BitSwap,_BitSwap,44,2,0
	.func	328
;******************************************************************************
;* FUNCTION NAME: _BitSwap                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_BitSwap:
	.sym	_btDat,-2,12,9,32
	.sym	_btBuf,1,12,1,32
	.line	1
;----------------------------------------------------------------------
; 328 | UCHAR BitSwap(UCHAR btDat)                                             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 330 | UCHAR btBuf = 0x00;                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 332 | btBuf |= MASKBIT(btDat&0x01?1:0,7);                                    
;----------------------------------------------------------------------
        ldiu      1,r0
        tstb      *-fp(2),r0
        beq       L64
;*      Branch Occurs to L64 
        bu        L65
;*      Branch Occurs to L65 
L64:        
        ldiu      0,r0
L65:        
        and       1,r0
        ash       7,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	6
;----------------------------------------------------------------------
; 333 | btBuf |= MASKBIT(btDat&0x02?1:0,6);                                    
;----------------------------------------------------------------------
        ldiu      2,r0
        tstb      *-fp(2),r0
        beq       L67
;*      Branch Occurs to L67 
        bud       L68
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L68 
L67:        
        ldiu      0,r0
L68:        
        and       1,r0
        ash       6,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	7
;----------------------------------------------------------------------
; 334 | btBuf |= MASKBIT(btDat&0x04?1:0,5);                                    
;----------------------------------------------------------------------
        ldiu      4,r0
        tstb      *-fp(2),r0
        beq       L70
;*      Branch Occurs to L70 
        bud       L71
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L71 
L70:        
        ldiu      0,r0
L71:        
        and       1,r0
        ash       5,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	8
;----------------------------------------------------------------------
; 335 | btBuf |= MASKBIT(btDat&0x08?1:0,4);                                    
;----------------------------------------------------------------------
        ldiu      8,r0
        tstb      *-fp(2),r0
        beq       L73
;*      Branch Occurs to L73 
        bud       L74
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L74 
L73:        
        ldiu      0,r0
L74:        
        and       1,r0
        ash       4,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	9
;----------------------------------------------------------------------
; 336 | btBuf |= MASKBIT(btDat&0x10?1:0,3);                                    
;----------------------------------------------------------------------
        ldiu      16,r0
        tstb      *-fp(2),r0
        beq       L76
;*      Branch Occurs to L76 
        bud       L77
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L77 
L76:        
        ldiu      0,r0
L77:        
        and       1,r0
        ash       3,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 337 | btBuf |= MASKBIT(btDat&0x20?1:0,2);                                    
;----------------------------------------------------------------------
        ldiu      32,r0
        tstb      *-fp(2),r0
        beq       L79
;*      Branch Occurs to L79 
        bud       L80
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L80 
L79:        
        ldiu      0,r0
L80:        
        and       1,r0
        ash       2,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	11
;----------------------------------------------------------------------
; 338 | btBuf |= MASKBIT(btDat&0x40?1:0,1);                                    
;----------------------------------------------------------------------
        ldiu      64,r0
        tstb      *-fp(2),r0
        beq       L82
;*      Branch Occurs to L82 
        bud       L83
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L83 
L82:        
        ldiu      0,r0
L83:        
        and       1,r0
        ash       1,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	12
;----------------------------------------------------------------------
; 339 | btBuf |= MASKBIT(btDat&0x80?1:0,0);                                    
;----------------------------------------------------------------------
        ldiu      128,r0
        tstb      *-fp(2),r0
        beq       L85
;*      Branch Occurs to L85 
        bud       L86
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L86 
L85:        
        ldiu      0,r0
L86:        
        and       1,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	14
;----------------------------------------------------------------------
; 341 | return btBuf;                                                          
;----------------------------------------------------------------------
	.line	15
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	342,000000000h,1



	.sect	".cinit"
	.field  	1,32
	.field  	_d_MDS_info+0,32
	.field  	0,32		; _d_MDS_info @ 0

	.sect	".text"

	.global	_d_MDS_info
	.bss	_d_MDS_info,1
	.sym	_d_MDS_info,_d_MDS_info,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_nRxPos$1+0,32
	.field  	0,32		; _nRxPos$1 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nOldUart2RxOneByteGapDelayTime$2+0,32
	.field  	0,32		; _nOldUart2RxOneByteGapDelayTime$2 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nTimeSendCnt$5+0,32
	.field  	0,32		; _nTimeSendCnt$5 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_user_WithCncsRs232Loop
	.sym	_user_WithCncsRs232Loop,_user_WithCncsRs232Loop,32,2,0
	.func	350
;******************************************************************************
;* FUNCTION NAME: _user_WithCncsRs232Loop                                     *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3,r4,r5,ar0,ar1,fp,ir0,ir1,sp,st          *
;*   Regs Saved         : r4,r5                                               *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 999 Auto + 2 SOE = 1003 words     *
;******************************************************************************
_user_WithCncsRs232Loop:
	.bss	_nRxPos$1,1
	.sym	_nRxPos,_nRxPos$1,4,3,32
	.bss	_nOldUart2RxOneByteGapDelayTime$2,1
	.sym	_nOldUart2RxOneByteGapDelayTime,_nOldUart2RxOneByteGapDelayTime$2,12,3,32
	.bss	_btRx2chBuf$3,512
	.sym	_btRx2chBuf,_btRx2chBuf$3,60,3,16384,,512
	.bss	_btTx2chBuf$4,512
	.sym	_btTx2chBuf,_btTx2chBuf$4,60,3,16384,,512
	.bss	_nTimeSendCnt$5,1
	.sym	_nTimeSendCnt,_nTimeSendCnt$5,4,3,32
	.sym	_i,1,4,1,32
	.sym	_nRxLen,2,4,1,32
	.sym	_RxBuf,3,60,1,320,,10
	.sym	_btTmp,13,12,1,32
	.sym	_btBuf,14,60,1,8192,,256
	.sym	_sTimeBuf,270,60,1,320,,10
	.sym	_sPotoLen,280,4,1,32
	.sym	_sBcc,281,12,1,32
	.sym	_LL,282,12,1,32
	.sym	_LH,283,12,1,32
	.sym	_HL,284,12,1,32
	.sym	_HH,285,12,1,32
	.sym	_nBlkSize,286,4,1,32
	.sym	_nTempBlkEnd,287,4,1,32
	.sym	_sTxDataSize,288,4,1,32
	.sym	_btTxBuf,289,60,1,4096,,128
	.sym	_szBuf,417,50,1,16384,,512
	.sym	_szBuf2,929,50,1,2048,,64
	.sym	_pNvsram,993,28,1,32
	.sym	_pLicVerDp,994,24,1,32,.fake44
	.sym	_pLic_Cncs,995,24,1,32,.fake42
	.sym	_pCncsLicSd,996,24,1,32,.fake45
	.sym	_pCnsc_Lic_T_F,997,24,1,32,.fake46
	.sym	_pCncs_Lic_T_F_C,998,24,1,32,.fake47
	.sym	_pInfo,999,24,1,32,.fake69
	.line	1
;----------------------------------------------------------------------
; 350 | void user_WithCncsRs232Loop()                                          
; 352 | int i;                                                                 
; 353 | int nRxLen;                                                            
; 354 | UCHAR RxBuf[10];                                                       
; 355 | UCHAR btTmp;                                                           
; 356 | UCHAR btBuf[256]; //¼ö½Å ·¹Áö½ºÆ®¿¡¼­ ÀÐ¾î ¿À´Â º¯¼ö                   
; 357 | UCHAR sTimeBuf[10];//½Ã°£ Àü¼Û ¹öÆÛ.                                   
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      999,sp
        push      r4
        push      r5
	.line	9
;----------------------------------------------------------------------
; 358 | int sPotoLen = 0; //ºí·® ÆÐÅ¶ Index.                                   
;----------------------------------------------------------------------
        ldiu      280,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	10
;----------------------------------------------------------------------
; 359 | UCHAR sBcc = 0;                                                        
; 360 | static int nRxPos = 0; //¼ö½Å Ä«¿îÅÍ.                                  
; 361 | static UCHAR nOldUart2RxOneByteGapDelayTime = 0; //10ms ÀÌ»ó ¼ö½ÅÀÌ ¾Êµ
;     | Ç¸é ¼ö½Å Ã³¸® ÇÑ´Ù.                                                    
; 362 | static UCHAR btRx2chBuf[512]; //¼ö½Å ¹öÆÛ                              
; 363 | static UCHAR btTx2chBuf[512]; //Àü¼Û ¹öÆÛ.                             
; 364 | static int nTimeSendCnt = 0;                                           
; 365 | UCHAR LL,LH,HL,HH;                                                     
;----------------------------------------------------------------------
        ldiu      281,ir0
        sti       r0,*+fp(ir0)
	.line	18
;----------------------------------------------------------------------
; 367 | int nBlkSize = 0;                                                      
;----------------------------------------------------------------------
        ldiu      286,ir0
        sti       r0,*+fp(ir0)
	.line	19
;----------------------------------------------------------------------
; 368 | int nTempBlkEnd = 0;                                                   
;----------------------------------------------------------------------
        ldiu      287,ir0
        sti       r0,*+fp(ir0)
	.line	20
;----------------------------------------------------------------------
; 369 | int sTxDataSize = 0; //¼ö½Å¾Æ µ¥ÀÌÅ¸ size¸¦ ºñ·á ÇÏ¿© 128ÀÌ¸í Áß°£ ÀÛÀ¸
;     | ¸é ¸¶Áö¸· ÇÁ·¹ÀÓ ÀÌ´Ù.                                                 
; 371 | UCHAR btTxBuf[128];                                                    
; 372 | char szBuf[512];                                                       
; 373 | char szBuf2[64];                                                       
;----------------------------------------------------------------------
        ldiu      288,ir0
        sti       r0,*+fp(ir0)
	.line	27
;----------------------------------------------------------------------
; 376 | UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;                                 
;----------------------------------------------------------------------
        ldiu      993,ir0
        ldiu      @CL67,r0
        sti       r0,*+fp(ir0)
	.line	29
;----------------------------------------------------------------------
; 378 | PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //¹öÀü Á¤º¸ Ã³¸
;     | ®¸¦ À§ÇØ ÀÓÀÇ·Î ¸¸µé¾ú´Ù.                                              
; 379 | PLIC_CNCS_HD pLic_Cncs;                                                
; 380 | PCNCS_LIC_SD pCncsLicSd;                                               
; 382 | PCNCS_LIC_T_F pCnsc_Lic_T_F;                                           
;----------------------------------------------------------------------
        ldiu      994,ir0
        ldiu      @CL2,r0
        sti       r0,*+fp(ir0)
	.line	34
;----------------------------------------------------------------------
; 383 | PCNCS_LIC_T_F_C pCncs_Lic_T_F_C = (CNCS_LIC_T_F_C *) btRx2chBuf;
;     |                          // °íÀå ÆÐÅ¶ Àü¼Û ¿Ï·á È®ÀÎ ÇÁ·ÎÅäÄÝ Ãß°¡(Y.J 
;     | 2011-05-10)                                                            
; 385 | // Fault Block Information;                                            
;----------------------------------------------------------------------
        ldiu      998,ir0
        ldiu      @CL68,r0
        sti       r0,*+fp(ir0)
	.line	37
;----------------------------------------------------------------------
; 386 | PFAULT_INFO pInfo = NULL;                                              
; 388 | // ¼ö½Å                                                                
;----------------------------------------------------------------------
        ldiu      999,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	40
;----------------------------------------------------------------------
; 389 | nRxLen = user_CncsRx(btBuf,128);                                       
;----------------------------------------------------------------------
        ldiu      128,r1
        ldiu      fp,r0
        push      r1
        addi      14,r0
        push      r0
        call      _user_CncsRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(2)
	.line	41
;----------------------------------------------------------------------
; 390 | if(nRxLen)                                                             
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L94
;*      Branch Occurs to L94 
	.line	43
;----------------------------------------------------------------------
; 392 | if(!m_Variable.m_nUart2RxOneByteGapDelayTime) nRxPos = 0;              
;----------------------------------------------------------------------
        ldi       @_m_Variable+226,r0
        bne       L92
;*      Branch Occurs to L92 
        ldiu      0,r0
        sti       r0,@_nRxPos$1+0
L92:        
	.line	44
;----------------------------------------------------------------------
; 393 | m_Variable.m_nUart2RxOneByteGapDelayTime = 10;                         
;----------------------------------------------------------------------
        ldiu      10,r0
        sti       r0,@_m_Variable+226
	.line	46
;----------------------------------------------------------------------
; 395 | if(nRxPos + nRxLen < 511)                                              
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$1+0,r0
        cmpi      511,r0
        bged      L94
        ldilt     @CL68,r0
        ldilt     fp,r1
        ldilt     *+fp(2),r2
;*      Branch Occurs to L94 
	.line	48
;----------------------------------------------------------------------
; 397 | memcpy(&btRx2chBuf[nRxPos],btBuf,nRxLen);                              
;----------------------------------------------------------------------
        addi      @_nRxPos$1+0,r0       ; Unsigned
        addi      14,r1
        push      r2
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	49
;----------------------------------------------------------------------
; 398 | nRxPos += nRxLen;                                                      
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$1+0,r0
        sti       r0,@_nRxPos$1+0
L94:        
	.line	53
;----------------------------------------------------------------------
; 402 | if(nOldUart2RxOneByteGapDelayTime && !m_Variable.m_nUart2RxOneByteGapDe
;     | layTime)                                                               
;----------------------------------------------------------------------
        ldi       @_nOldUart2RxOneByteGapDelayTime$2+0,r0
        beq       L140
;*      Branch Occurs to L140 
        ldi       @_m_Variable+226,r0
        bne       L140
;*      Branch Occurs to L140 
	.line	55
;----------------------------------------------------------------------
; 404 | pCncsLicSd = (CNCS_LIC_SD *)btRx2chBuf;                                
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      @CL68,r0
        sti       r0,*+fp(ir0)
	.line	57
;----------------------------------------------------------------------
; 406 | pCnsc_Lic_T_F = (CNCS_LIC_T_F *) btRx2chBuf;                           
;----------------------------------------------------------------------
        ldiu      997,ir0
        sti       r0,*+fp(ir0)
	.line	59
;----------------------------------------------------------------------
; 408 | if(pCncsLicSd->phHdBuf.btSoh == SOH &&                                 
; 409 |    pCncsLicSd->btEot == EOT &&                                         
; 410 |    sizeof(CNCS_LIC_SD) == nRxPos &&                                    
; 411 |    //(TWOBYTE_ASC2HEX(pCncsLicSd->phHdBuf.chDestDev) == m_Variable.m_ch
;     | CarKindNum) &&                                                         
; 412 |    (TWOBYTE_ASC2HEX(pCncsLicSd->sCommand) == 0x09) &&  //CNCS°¡ ½Ã°£ ÀÀ
;     | ´ä                                                                     
; 415 |    ConvAsc2Hex(pCncsLicSd->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&pCncs
;     | LicSd->phHdBuf.chSrcDev[0],nRxPos-6)))&&                               
; 416 |    ConvAsc2Hex(pCncsLicSd->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&pCncs
;     | LicSd->phHdBuf.chSrcDev[0],nRxPos-6)))&&                               
; 417 |    ConvAsc2Hex(pCncsLicSd->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&pCncs
;     | LicSd->phHdBuf.chSrcDev[0],nRxPos-6)))&&                               
; 418 |    ConvAsc2Hex(pCncsLicSd->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&pCncs
;     | LicSd->phHdBuf.chSrcDev[0],nRxPos-6))))                                
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *ar0,r0
        cmpi      1,r0
        bne       L118
;*      Branch Occurs to L118 
        ldiu      *+fp(ir0),ir0
        ldiu      299,ar0
        ldiu      *+ar0(ir0),r0
        cmpi      4,r0
        bne       L118
;*      Branch Occurs to L118 
        ldiu      300,r0
        cmpi      @_nRxPos$1+0,r0
        bne       L118
;*      Branch Occurs to L118 
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(15),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(16),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        cmpi      9,r0
        subi      1,sp
        bne       L118
;*      Branch Occurs to L118 
        ldiu      1,r1
        ldiu      996,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      295,ar0
        ldiu      996,ir0
        ldiu      r0,r4
        subi      2,sp
        lsh       -8,r4
        ldiu      *+fp(ir0),ir0
        and       255,r4
        ldiu      *+ar0(ir0),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L118
;*      Branch Occurs to L118 
        ldiu      1,r1
        ldiu      996,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      296,ar0
        subi      2,sp
        ldiu      996,ir0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ir0
        ldiu      *+ar0(ir0),r0
        lsh       -8,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L118
;*      Branch Occurs to L118 
        ldiu      1,r1
        ldiu      996,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      996,ir0
        subi      2,sp
        ldiu      297,ar0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ir0
        and       255,r4
        ldiu      *+ar0(ir0),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L118
;*      Branch Occurs to L118 
        ldiu      1,r1
        ldiu      996,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      996,ir0
        subi      2,sp
        ldiu      298,ar0
        ldiu      *+fp(ir0),ir0
        ldiu      r0,r4
        ldiu      *+ar0(ir0),r0
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L118
;*      Branch Occurs to L118 
	.line	73
;----------------------------------------------------------------------
; 422 | d_DataBuf[0] = m_Variable.m_tmUtcTime.second = TWOBYTE_ASC2HEX(pCncsLic
;     | Sd->sSecond);                                                          
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(27),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(28),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+237
        sti       r0,@_d_DataBuf+0
        subi      1,sp
	.line	74
;----------------------------------------------------------------------
; 423 | d_DataBuf[1] = m_Variable.m_tmUtcTime.minute = TWOBYTE_ASC2HEX(pCncsLic
;     | Sd->sMinute);                                                          
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(25),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(26),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+238
        subi      1,sp
        sti       r0,@_d_DataBuf+1
	.line	75
;----------------------------------------------------------------------
; 424 | d_DataBuf[2] = m_Variable.m_tmUtcTime.hour   = TWOBYTE_ASC2HEX(pCncsLic
;     | Sd->sHour);                                                            
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(23),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(24),r1
        push      r1
        ldiu      r0,r4
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+239
        subi      1,sp
        sti       r0,@_d_DataBuf+2
	.line	76
;----------------------------------------------------------------------
; 425 | d_DataBuf[3] = m_Variable.m_tmUtcTime.day    = TWOBYTE_ASC2HEX(pCncsLic
;     | Sd->sDay);                                                             
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(21),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(22),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+240
        subi      1,sp
        sti       r0,@_d_DataBuf+3
	.line	77
;----------------------------------------------------------------------
; 426 | d_DataBuf[4] = m_Variable.m_tmUtcTime.month  = TWOBYTE_ASC2HEX(pCncsLic
;     | Sd->sMonth);                                                           
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(19),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(20),r1
        push      r1
        ldiu      r0,r4
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+241
        sti       r0,@_d_DataBuf+4
        subi      1,sp
	.line	78
;----------------------------------------------------------------------
; 427 | d_DataBuf[5] = m_Variable.m_tmUtcTime.year   = TWOBYTE_ASC2HEX(pCncsLic
;     | Sd->sYear);                                                            
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(17),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(18),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+242
        sti       r0,@_d_DataBuf+5
        subi      1,sp
	.line	81
;----------------------------------------------------------------------
; 430 | m_Variable.m_LIC_CNCS_TimSetFlag = TRUE;                               
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+356
	.line	82
;----------------------------------------------------------------------
; 431 | m_Variable.m_nCncsRxCheck1msTimer = 100000;//100ÃÊ(1ºÐ 30ÃÊ)           
;----------------------------------------------------------------------
        ldiu      @CL69,r0
        sti       r0,@_m_Variable+358
	.line	85
;----------------------------------------------------------------------
; 434 | FunConvAscHex((char *)&pCncsLicSd->sRailNumVer[0],RxBuf,4);            
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      291,r2
        ldiu      4,r1
        addi3     r2,*+fp(ir0),r2       ; Unsigned
        ldiu      fp,r0
        push      r1
        addi      3,r0
        push      r0
        push      r2
        call      _FunConvAscHex
                                        ; Call Occurs
        subi      3,sp
	.line	87
;----------------------------------------------------------------------
; 436 | m_Variable.m_nCarNo_CncsRx = MAKE_WORD(RxBuf[0],RxBuf[1]);             
; 438 | //---------------------------------------------                        
; 439 | // ¿­Â÷ ¹øÈ£´Â 4000 ~ 5000 ¹ø °ª¸¸ À¯È¿                                
; 440 | //---------------------------------------------                        
;----------------------------------------------------------------------
        ldiu      fp,ar1
        ldiu      fp,ar0
        addi      4,ar1
        addi      3,ar0
        ldiu      255,r0
        and3      r0,*ar1,r0
        ldiu      8,r1
        ash3      r1,*ar0,r1
        or3       r1,r0,r0
        and       65535,r0
        sti       r0,@_m_Variable+283
	.line	92
;----------------------------------------------------------------------
; 441 | if(m_Variable.m_nCarNo_CncsRx >= 0x4000 && m_Variable.m_nCarNo_CncsRx <
;     | = 0x5000)                                                              
;----------------------------------------------------------------------
        cmpi      16384,r0
        blo       L109
;*      Branch Occurs to L109 
        cmpi      20480,r0
        bhi       L109
;*      Branch Occurs to L109 
	.line	95
;----------------------------------------------------------------------
; 444 | if(m_Variable.m_nCarNo != m_Variable.m_nCarNo_CncsRx)                  
;----------------------------------------------------------------------
        ldiu      @_m_Variable+282,r0
        cmpi      @_m_Variable+283,r0
        beq       L109
;*      Branch Occurs to L109 
	.line	98
;----------------------------------------------------------------------
; 447 | m_Variable.m_nCarNo = m_Variable.m_nCarNo_CncsRx;                      
; 449 | //¿­Â÷ ¹øÈ£¸¦ NVSRAM¿¡ ÀúÀåÇÑ´Ù.                                       
;----------------------------------------------------------------------
        ldiu      @_m_Variable+283,r0
        sti       r0,@_m_Variable+282
	.line	101
;----------------------------------------------------------------------
; 450 | pLicVerDp->CarNum[0] = WORD_H(m_Variable.m_nCarNo);                    
;----------------------------------------------------------------------
        ldiu      994,ir0
        lsh       -8,r0
        ldiu      *+fp(ir0),ar0
        and       255,r0
        sti       r0,*+ar0(251)
	.line	102
;----------------------------------------------------------------------
; 451 | pLicVerDp->CarNum[1] = WORD_L(m_Variable.m_nCarNo);                    
; 457 | //MyPrintf("RailNumber :Cncs Rx[%04X] -- Nvr[%04X] \r\n",m_Variable.m_n
;     | CarNo,MAKE_WORD(pLicVerDp->CarNum[0],pLicVerDp->CarNum[1]));           
;----------------------------------------------------------------------
        ldiu      255,r0
        ldiu      *+fp(ir0),ar0
        and       @_m_Variable+282,r0
        sti       r0,*+ar0(252)
L109:        
	.line	111
;----------------------------------------------------------------------
; 460 | for(i=0;i<VER_BDD_MAX_CNT;i++)                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      25,r0
        bge       L114
;*      Branch Occurs to L114 
L110:        
	.line	113
;----------------------------------------------------------------------
; 462 | if(!MAKE_DWORD(0x00,m_Variable.m_tmUtcTime.year,m_Variable.m_tmUtcTime.
;     | month,m_Variable.m_tmUtcTime.day))                                     
;----------------------------------------------------------------------
        ldiu      255,r1
        ldiu      255,r0
        ldiu      255,r2
        and       @_m_Variable+242,r1
        and       @_m_Variable+241,r0
        and       @_m_Variable+240,r2
        ash       16,r1
        ash       8,r0
        or3       r1,r0,r0
        or3       r0,r2,r0
        bne       L113
;*      Branch Occurs to L113 
	.line	115
;----------------------------------------------------------------------
; 464 | pLicVerDp->VerCnt = FALSE;                                             
;----------------------------------------------------------------------
        ldiu      994,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	116
;----------------------------------------------------------------------
; 465 | memset(pLicVerDp->cvbBuf[i].chVer,'0',4);                              
;----------------------------------------------------------------------
        ldiu      4,r2
        ldiu      48,r1
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),r0       ; Unsigned
        push      r2
        addi      1,r0                  ; Unsigned
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	117
;----------------------------------------------------------------------
; 466 | memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);                        
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      994,ir0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),r0       ; Unsigned
        ldiu      6,r2
        push      r2
        addi      5,r0                  ; Unsigned
        ldiu      48,r1
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	118
;----------------------------------------------------------------------
; 467 | break;                                                                 
; 469 | else                                                                   
;----------------------------------------------------------------------
        bu        L114
;*      Branch Occurs to L114 
L113:        
	.line	122
;----------------------------------------------------------------------
; 471 | pLicVerDp->VerCnt = TRUE;                                              
; 473 | // ¹öÀü ÀÔ·Â                                                           
;----------------------------------------------------------------------
        ldiu      994,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      1,r0
        sti       r0,*ar0
	.line	125
;----------------------------------------------------------------------
; 474 | pLicVerDp->cvbBuf[i].chVer[0] = pCncsLicSd->cvbBuf[i].chVer[0];        
;----------------------------------------------------------------------
        ldiu      994,ir1
        ldiu      *+fp(1),r1
        ldiu      996,ir0
        ldiu      r1,r0
        mpyi      10,r0
        mpyi      10,r1
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        addi3     r1,*+fp(ir1),ar1      ; Unsigned
        ldiu      *+ar0(41),r0
        sti       r0,*+ar1(1)
	.line	126
;----------------------------------------------------------------------
; 475 | pLicVerDp->cvbBuf[i].chVer[1] = pCncsLicSd->cvbBuf[i].chVer[1];        
;----------------------------------------------------------------------
        ldiu      996,ir1
        ldiu      994,ir0
        ldiu      *+fp(1),r0
        ldiu      r0,r1
        mpyi      10,r0
        mpyi      10,r1
        addi3     r1,*+fp(ir1),ar0      ; Unsigned
        addi3     r0,*+fp(ir0),ar1      ; Unsigned
        ldiu      *+ar0(42),r0
        sti       r0,*+ar1(2)
	.line	127
;----------------------------------------------------------------------
; 476 | pLicVerDp->cvbBuf[i].chVer[2] = pCncsLicSd->cvbBuf[i].chVer[2];        
;----------------------------------------------------------------------
        ldiu      *+fp(1),r1
        ldiu      r1,r0
        mpyi      10,r1
        mpyi      10,r0
        addi3     r0,*+fp(ir1),ar0      ; Unsigned
        addi3     r1,*+fp(ir0),ar1      ; Unsigned
        ldiu      *+ar0(43),r0
        sti       r0,*+ar1(3)
	.line	128
;----------------------------------------------------------------------
; 477 | pLicVerDp->cvbBuf[i].chVer[3] = pCncsLicSd->cvbBuf[i].chVer[3];        
; 480 | // ¸¸µé¾îÁø ³¯Â¥ ÀÔ·Â                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      r0,r1
        ldiu      996,ir0
        mpyi      10,r1
        mpyi      10,r0
        ldiu      994,ir1
        addi3     r1,*+fp(ir0),ar0      ; Unsigned
        addi3     r0,*+fp(ir1),ar1      ; Unsigned
        ldiu      *+ar0(44),r0
        sti       r0,*+ar1(4)
	.line	132
;----------------------------------------------------------------------
; 481 | pLicVerDp->cvbBuf[i].chBuildDate[0] = pCncsLicSd->cvbBuf[i].chBuildDate
;     | [0];                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r1
        ldiu      r1,r0
        ldiu      996,ir1
        mpyi      10,r0
        mpyi      10,r1
        ldiu      994,ir0
        addi3     r0,*+fp(ir1),ar0      ; Unsigned
        addi3     r1,*+fp(ir0),ar1      ; Unsigned
        ldiu      *+ar0(45),r0
        sti       r0,*+ar1(5)
	.line	133
;----------------------------------------------------------------------
; 482 | pLicVerDp->cvbBuf[i].chBuildDate[1] = pCncsLicSd->cvbBuf[i].chBuildDate
;     | [1];                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      r0,r1
        mpyi      10,r1
        addi3     r1,*+fp(ir1),ar0      ; Unsigned
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar1      ; Unsigned
        ldiu      *+ar0(46),r0
        sti       r0,*+ar1(6)
	.line	134
;----------------------------------------------------------------------
; 483 | pLicVerDp->cvbBuf[i].chBuildDate[2] = pCncsLicSd->cvbBuf[i].chBuildDate
;     | [2];                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      r0,r1
        mpyi      10,r1
        mpyi      10,r0
        addi3     r1,*+fp(ir1),ar0      ; Unsigned
        addi3     r0,*+fp(ir0),ar1      ; Unsigned
        ldiu      *+ar0(47),r0
        sti       r0,*+ar1(7)
	.line	135
;----------------------------------------------------------------------
; 484 | pLicVerDp->cvbBuf[i].chBuildDate[3] = pCncsLicSd->cvbBuf[i].chBuildDate
;     | [3];                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r1
        ldiu      r1,r0
        mpyi      10,r0
        mpyi      10,r1
        addi3     r0,*+fp(ir1),ar0      ; Unsigned
        addi3     r1,*+fp(ir0),ar1      ; Unsigned
        ldiu      *+ar0(48),r0
        sti       r0,*+ar1(8)
	.line	136
;----------------------------------------------------------------------
; 485 | pLicVerDp->cvbBuf[i].chBuildDate[4] = pCncsLicSd->cvbBuf[i].chBuildDate
;     | [4];                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r1
        mpyi      10,r1
        ldiu      *+fp(1),r0
        ldiu      996,ir0
        mpyi      10,r0
        ldiu      994,ir1
        addi3     r1,*+fp(ir0),ar0      ; Unsigned
        addi3     r0,*+fp(ir1),ar1      ; Unsigned
        ldiu      *+ar0(49),r0
        sti       r0,*+ar1(9)
	.line	137
;----------------------------------------------------------------------
; 486 | pLicVerDp->cvbBuf[i].chBuildDate[5] = pCncsLicSd->cvbBuf[i].chBuildDate
;     | [5];                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r1
        ldiu      r1,r0
        mpyi      10,r0
        mpyi      10,r1
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        addi3     r1,*+fp(ir1),ar1      ; Unsigned
        ldiu      *+ar0(50),r0
        sti       r0,*+ar1(10)
	.line	111
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      25,r0
        blt       L110
;*      Branch Occurs to L110 
L114:        
	.line	143
;----------------------------------------------------------------------
; 492 | if(TWOBYTE_ASC2HEX(pCncsLicSd->sWaySide) == 0x01 && !m_Variable.m_LIC_C
;     | NCS_Tx_Flag) // wayside on ¾Ë¸²                                        
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(29),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(30),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        cmpi      1,r0
        subi      1,sp
        bne       L157
;*      Branch Occurs to L157 
        ldi       @_m_Variable+269,r0
        bne       L157
;*      Branch Occurs to L157 
	.line	145
;----------------------------------------------------------------------
; 494 | m_Variable.m_nCDT_FaultDataStFlag = 1;                                 
; 496 | //2011_03_03 ¼öÁ¤                                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+274
	.line	148
;----------------------------------------------------------------------
; 497 | m_Variable.m_nFaultCnt = 0;
;     |  // °íÀå °¹¼ö¸¦ 0À¸·Î ÃÊ±âÈ­.(Y.J Ãß°¡);                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+272
	.line	149
;----------------------------------------------------------------------
; 498 | memset((UCHAR *)NVSRAM_BASE,0x00,1024); // °íÀå ºí·°À» "0" À¸·Î ÃÊ½ÃÈ­
;     | ÇÑ´Ù. ÃÊ±â À§Ä¡ 0ºÎÅÍ 1024±îÁö¸¸ ÃÊ±âÈ­ ÇÑ´Ù.                          
;----------------------------------------------------------------------
        ldiu      1024,r2
        ldiu      @CL70,r1
        push      r2
        push      r0
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	150
;----------------------------------------------------------------------
; 499 | ClearFltBlkInfo();                                              // °íÀå
;     |  Á¤º¸¸¦ ClearÇÏ´Â ºÎºÐ.                                                
; 501 | //memset(aaa_FaultBlkList, 0xFF, 1024);                                
;----------------------------------------------------------------------
        call      _ClearFltBlkInfo
                                        ; Call Occurs
	.line	154
;----------------------------------------------------------------------
; 503 | m_Variable.m_nNvsramPos = 0;    //ÀüÃ¼ ±â·Ï ±¸Á¶ À§Ä¡¸¦ Ã³À½À¸·Î       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+291
	.line	155
;----------------------------------------------------------------------
; 504 | m_Variable.m_Recving_Posi = 0;  //ÇöÀç ±îÁö Àü¼ÛÇÑ À§Ä¡¸¦ Ã³À½À¸·Î     
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+273
	.line	156
;----------------------------------------------------------------------
; 505 | m_Variable.m_nLnWkTxFlag = 0;   //°íÀå ÄÚµå ±¸ºÐÀ» 0À¸·Î ÃÊ±âÈ­        
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+271
	.line	158
;----------------------------------------------------------------------
; 507 | m_Variable.m_nLnWkTxFlag = TWOBYTE_ASC2HEX(pCncsLicSd->sDaType);       
; 509 | // °íÀå ½Ã°£ ¿äÃ» WORD -> DWORD·Î º¯°æ.(2011.05.08)                    
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(31),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(32),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        subi      1,sp
        sti       r0,@_m_Variable+271
	.line	161
;----------------------------------------------------------------------
; 510 | m_Variable.m_nDateTime2SecondCnt = MAKE_DWORD( MAKE_BYTE(ConvAsc2Hex(pC
;     | ncsLicSd->sFaultTime[0]),ConvAsc2Hex(pCncsLicSd->sFaultTime[1])),      
; 511 | 
;     |  MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[2]),ConvAsc2Hex(pCncsLicS
;     | d->sFaultTime[3])),                                                    
; 512 | 
;     |  MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[4]),ConvAsc2Hex(pCncsLicS
;     | d->sFaultTime[5])),                                                    
; 513 | 
;     |  MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[6]),ConvAsc2Hex(pCncsLicS
;     | d->sFaultTime[7])));                                                   
; 517 | //MyPrintf("CNCS--> LIC");                                             
; 518 | //MyPrintf_TxAuto(btRx2chBuf,sizeof(CNCS_LIC_SD));                     
;----------------------------------------------------------------------
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(33),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(34),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        and       15,r0
        ldiu      *+fp(ir0),ar0
        or3       r4,r0,r5
        ldiu      *+ar0(35),r0
        and       255,r5
        push      r0
        ash       24,r5
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(36),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(37),r1
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        ash       16,r0
        or3       r5,r0,r4
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r5
        ldiu      *+ar0(38),r0
        ash       4,r5
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        and       15,r0
        or3       r5,r0,r1
        and       255,r1
        ldiu      *+ar0(39),r0
        push      r0
        ash       8,r1
        or3       r4,r1,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r5
        ldiu      *+ar0(40),r0
        ash       4,r5
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r5,r0,r0
        and       255,r0
        or3       r4,r0,r0
        sti       r0,@_m_Variable+293
        subi      1,sp
        bu        L157
;*      Branch Occurs to L157 
L118:        
	.line	172
;----------------------------------------------------------------------
; 521 | else if(pCncs_Lic_T_F_C->phHdBuf.btSoh == SOH &&
;     |                                                                        
;     |                                           		// °íÀå ½Ã°£ ¿äÃ» WORD -> D
;     | WORD·Î º¯°æ.(2011.05.11)                                               
; 522 |         pCncs_Lic_T_F_C->btEot == EOT &&                               
; 523 |         sizeof(CNCS_LIC_T_F_C) == nRxPos &&                            
; 524 |    //(TWOBYTE_ASC2HEX(pCncs_Lic_T_F_C->phHdBuf.chDestDev) == 0x11) &&  
; 525 |    (TWOBYTE_ASC2HEX(pCncsLicSd->sCommand) == 0x07) &&  //°íÀå Àü¼Û È®ÀÎ
;     |  ÀÀ´ä(CNCS-> LIC)                                                      
; 527 |    ConvAsc2Hex(pCncs_Lic_T_F_C->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&
;     | pCncs_Lic_T_F_C->phHdBuf.chSrcDev[0],nRxPos-6)))&&                     
; 528 |    ConvAsc2Hex(pCncs_Lic_T_F_C->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&
;     | pCncs_Lic_T_F_C->phHdBuf.chSrcDev[0],nRxPos-6)))&&                     
; 529 |    ConvAsc2Hex(pCncs_Lic_T_F_C->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&
;     | pCncs_Lic_T_F_C->phHdBuf.chSrcDev[0],nRxPos-6)))&&                     
; 530 |    ConvAsc2Hex(pCncs_Lic_T_F_C->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&
;     | pCncs_Lic_T_F_C->phHdBuf.chSrcDev[0],nRxPos-6))))                      
; 532 |    //!((Make1ByteBcc(&pCncs_Lic_T_F_C->phHdBuf.chSrcDev[0],nRxPos-4)^(T
;     | WOBYTE_ASC2HEX(pCncs_Lic_T_F_C->chChkSum)))))                          
; 536 |         // Y.J 2011-05-10 ¿äÃ»ÇÑ °íÀå Index¸¦ »ç¿ëÇÏ¿©, Àü¼ÛÇÏµµ·Ï ¼öÁ¤
;     | .                                                                      
;----------------------------------------------------------------------
        ldiu      998,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *ar0,r0
        cmpi      1,r0
        bne       L157
;*      Branch Occurs to L157 
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(25),r0
        cmpi      4,r0
        bne       L157
;*      Branch Occurs to L157 
        ldiu      26,r0
        cmpi      @_nRxPos$1+0,r0
        bne       L157
;*      Branch Occurs to L157 
        ldiu      996,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(15),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      996,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(16),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        cmpi      7,r0
        subi      1,sp
        bne       L157
;*      Branch Occurs to L157 
        ldiu      1,r1
        ldiu      998,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      998,ir0
        ldiu      r0,r4
        subi      2,sp
        lsh       -8,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(21),r0
        lsh       -4,r4
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L157
;*      Branch Occurs to L157 
        ldiu      1,r1
        ldiu      998,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        subi      2,sp
        ldiu      998,ir0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(22),r0
        lsh       -8,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L157
;*      Branch Occurs to L157 
        ldiu      1,r1
        ldiu      998,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      998,ir0
        subi      2,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(23),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L157
;*      Branch Occurs to L157 
        ldiu      1,r1
        ldiu      998,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$1+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      998,ir0
        subi      2,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(24),r0
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L157
;*      Branch Occurs to L157 
	.line	188
;----------------------------------------------------------------------
; 537 | sPotoLen = MAKE_WORD(MAKE_BYTE(ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[0]),Con
;     | vAsc2Hex(pCnsc_Lic_T_F->sTEXT[1])),                                    
; 538 |                      MAKE_BYTE(ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[2]),Con
;     | vAsc2Hex(pCnsc_Lic_T_F->sTEXT[3])));                                   
;----------------------------------------------------------------------
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(17),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(18),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      997,ir0
        and       15,r0
        subi      1,sp
        or3       r4,r0,r5
        ldiu      *+fp(ir0),ar0
        and       255,r5
        ldiu      *+ar0(19),r0
        ash       8,r5
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(20),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      280,ir0
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        or3       r5,r0,r0
        subi      1,sp
        and       65535,r0
        sti       r0,*+fp(ir0)
	.line	190
;----------------------------------------------------------------------
; 539 | if(sPotoLen)                                                           
; 541 |         // ÀçÀü¼ÛÇÒ °íÀå ºí·Ï Á¤º¸¸¦ ¾òÀ½.                             
;----------------------------------------------------------------------
        ldi       *+fp(ir0),r0
        beq       L139
;*      Branch Occurs to L139 
	.line	193
;----------------------------------------------------------------------
; 542 | pInfo = GetFltBlkInfo(m_Variable.m_chCarKind);                         
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        ldiu      999,ir0
        sti       r0,*+fp(ir0)
	.line	195
;----------------------------------------------------------------------
; 544 | if(pInfo != NULL)                                                      
; 546 |         // Àü¼ÛÇÒ ºí·Ï À§Ä¡·Î ÀÌµ¿.                                    
;----------------------------------------------------------------------
        ldi       *+fp(ir0),r0
        beq       L138
;*      Branch Occurs to L138 
	.line	198
;----------------------------------------------------------------------
; 547 | m_Variable.m_Recving_Posi = pInfo->nStPosi + ((sPotoLen-1) * 128);     
; 549 | // Àü¼ÛÇÒ ºí·Ï Å©±â¸¦ ±¸ÇÏ´Â ºÎºÐ.                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      280,ir0
        ldiu      999,ir1
        subi3     r0,*+fp(ir0),r0
        ldiu      *+fp(ir1),ar0
        mpyi      128,r0
        addi      *+ar0(1),r0
        sti       r0,@_m_Variable+273
	.line	201
;----------------------------------------------------------------------
; 550 | if(sPotoLen < pInfo->nTCnt) //  (sPotoLen*128) <= nTempBlkEnd)         
;----------------------------------------------------------------------
        ldiu      *+fp(ir1),ar0
        cmpi3     *ar0,*+fp(ir0)
        bged      L131
	nop
        ldige     999,ir1
        ldige     280,ir0
;*      Branch Occurs to L131 
	.line	203
;----------------------------------------------------------------------
; 552 | nBlkSize = 128;                                                        
;----------------------------------------------------------------------
        ldiu      286,ir0
        ldiu      128,r0
        sti       r0,*+fp(ir0)
        bu        L135
;*      Branch Occurs to L135 
	.line	205
;----------------------------------------------------------------------
; 554 | else if(sPotoLen == pInfo->nTCnt)                                      
;----------------------------------------------------------------------
L131:        
        ldiu      *+fp(ir1),ar0
        cmpi3     *ar0,*+fp(ir0)
        bned      L134
	nop
        ldine     286,ir0
        ldine     0,r0
;*      Branch Occurs to L134 
	.line	207
;----------------------------------------------------------------------
; 556 | nBlkSize = (pInfo->nEdPosi - pInfo->nStPosi) % 128; // - ((sPotoLen - 1
;     | ) * 128);                                                              
; 558 | else                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(ir1),ar1
        ldiu      999,ir0
        ldiu      2,ar0
        ldiu      *+fp(ir0),ir1
        subi3     *+ar1,*+ar0(ir1),r1
        ldiu      r1,r0
        ldiu      286,ir0
        ash       -6,r0
        lsh       @CL71,r0
        addi3     r0,r1,r0
        andn      127,r0
        subri     r1,r0
        sti       r0,*+fp(ir0)
        bu        L135
;*      Branch Occurs to L135 
	.line	211
;----------------------------------------------------------------------
; 560 | nBlkSize = 0;                                                          
;----------------------------------------------------------------------
L134:        
        sti       r0,*+fp(ir0)
L135:        
	.line	214
;----------------------------------------------------------------------
; 563 | if(nBlkSize < 0) nBlkSize = 0;                                         
; 565 | // ºí·ÏÀÇ ¸¶Áö¸· À§Ä¡¸¦ ÁöÁ¤.                                          
;----------------------------------------------------------------------
        ldiu      286,ir0
        ldi       *+fp(ir0),r0
        bge       L137
;*      Branch Occurs to L137 
        ldiu      0,r0
        sti       r0,*+fp(ir0)
L137:        
	.line	217
;----------------------------------------------------------------------
; 566 | nTempBlkEnd = pInfo->nEdPosi;                                          
;----------------------------------------------------------------------
        ldiu      999,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      287,ir0
        ldiu      *+ar0(2),r0
        sti       r0,*+fp(ir0)
L138:        
	.line	220
;----------------------------------------------------------------------
; 569 | sTxDataSize = nBlkSize + 2;                                            
; 571 | // °íÀå µ¥ÀÌÅÍ¸¦ Àü¼ÛÇÏ´Â ºÎºÐ.                                        
;----------------------------------------------------------------------
        ldiu      2,r0
        ldiu      286,ir1
        ldiu      288,ir0
        addi3     r0,*+fp(ir1),r0
        sti       r0,*+fp(ir0)
	.line	223
;----------------------------------------------------------------------
; 572 | user_FaultDataTx(btTx2chBuf,sTxDataSize,TRUE,sPotoLen);                
;----------------------------------------------------------------------
        ldiu      280,ir1
        ldiu      1,r2
        ldiu      @CL72,r3

        ldiu      *+fp(ir0),r0
||      ldiu      *+fp(ir1),r1

        push      r1
        push      r2
        push      r0
        push      r3
        call      _user_FaultDataTx
                                        ; Call Occurs
        subi      4,sp
	.line	224
;----------------------------------------------------------------------
; 573 | user_CncsTx(btTx2chBuf,(sTxDataSize*2)+20);                            
; 575 | // Àü¼Û ÈÄ, ºí·Ï À§Ä¡¸¦ ¸¶Áö¸· À§Ä¡·Î º¹¿ø.                            
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      2,r1
        mpyi3     r1,*+fp(ir0),r1
        addi      20,r1
        push      r1
        ldiu      @CL72,r0
        push      r0
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
	.line	227
;----------------------------------------------------------------------
; 576 | m_Variable.m_Recving_Posi = nTempBlkEnd;                               
; 578 | else                                                                   
; 579 | //¹Ù·Î Á¾·á ÄÚµå°¡ ¼ö½Å µÉ¼ö ÀÖ´Ù.                                     
;----------------------------------------------------------------------
        ldiu      287,ir0
        ldiu      *+fp(ir0),r0
        sti       r0,@_m_Variable+273
        bu        L157
;*      Branch Occurs to L157 
L139:        
	.line	232
;----------------------------------------------------------------------
; 581 | user_FtpEnd_CarNumFun();                                               
; 585 | else // µ¥ÀÌÅ¸ Àü¼Û                                                    
;----------------------------------------------------------------------
        call      _user_FtpEnd_CarNumFun
                                        ; Call Occurs
        bu        L157
;*      Branch Occurs to L157 
L140:        
	.line	238
;----------------------------------------------------------------------
; 587 | if(m_Variable.m_nTxDbg1msTimer > 150) //150ms ¸¶´Ù ÇÑ¹ø¾¿ ½ÇÇà ÇÑ´Ù.   
; 589 |         //---------------------------------                            
; 590 |         //°íÀå Á¤º¸ Àü¼Û.                                              
; 591 |         //---------------------------------                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+294,r0
        cmpi      150,r0
        bls       L157
;*      Branch Occurs to L157 
	.line	243
;----------------------------------------------------------------------
; 592 | if(m_Variable.m_LIC_CNCS_Tx_Flag)                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+269,r0
        beq       L153
;*      Branch Occurs to L153 
	.line	245
;----------------------------------------------------------------------
; 594 | m_Variable.m_nTxDbg1msTimer = 0;                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+294
	.line	247
;----------------------------------------------------------------------
; 596 | m_Variable.m_LIC_CNCS_TX_DelyTime++;                                   
; 598 | // 150*50  = 7500  = 7.5ÃÊ µ¿¾È °íÀå ºí·° »çÀÌ°¡ ÀÀ´äÀÌ ¾øÀ¸¸é, Á¾·á ÇÑ
;     | ´Ù.                                                                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+270,r0
        sti       r0,@_m_Variable+270
	.line	250
;----------------------------------------------------------------------
; 599 | if(m_Variable.m_LIC_CNCS_TX_DelyTime > 50){m_Variable.m_bLnWkFtpEndFlag
;     |  = TRUE;}                                                              
;----------------------------------------------------------------------
        cmpi      50,r0
        ble       L144
;*      Branch Occurs to L144 
        ldiu      1,r0
        sti       r0,@_m_Variable+292
L144:        
	.line	252
;----------------------------------------------------------------------
; 601 | if((m_Variable.m_nNvsramPos !=  (m_Variable.m_Recving_Posi)) && (m_Vari
;     | able.m_nNvsramPos >= (m_Variable.m_Recving_Posi+128)))                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+291,r0
        cmpi      @_m_Variable+273,r0
        beqd      L149
	nop
        ldine     128,r0
        ldine     @_m_Variable+291,r1
;*      Branch Occurs to L149 
        addi      @_m_Variable+273,r0   ; Unsigned
        cmpi3     r0,r1
        blo       L149
;*      Branch Occurs to L149 
	.line	254
;----------------------------------------------------------------------
; 603 | m_Variable.m_nFaultCnt++;                                              
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+272,r0
        sti       r0,@_m_Variable+272
	.line	255
;----------------------------------------------------------------------
; 604 | if(m_Variable.m_nFaultCnt == 1)                                        
;----------------------------------------------------------------------
        cmpi      1,r0
        bne       L148
;*      Branch Occurs to L148 
	.line	256
;----------------------------------------------------------------------
; 605 | SetFltBlkStPos(m_Variable.m_chCarKind, m_Variable.m_Recving_Posi);
;     |                                                                  // Ã¹¹
;     | øÂ° ºí·ÏÀÏ °æ¿ì, °íÀå Á¤º¸ÀÇ ½ÃÀÛ À§Ä¡¸¦ ±â·Ï.                         
;----------------------------------------------------------------------
        ldiu      @_m_Variable+273,r0
        push      r0
        ldiu      @_m_Variable+284,r0
        push      r0
        call      _SetFltBlkStPos
                                        ; Call Occurs
        subi      2,sp
L148:        
	.line	258
;----------------------------------------------------------------------
; 607 | sTxDataSize = 128 + 2;                                                 
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      130,r0
        sti       r0,*+fp(ir0)
	.line	260
;----------------------------------------------------------------------
; 609 | user_FaultDataTx(btTx2chBuf,sTxDataSize,FALSE,0);                      
;----------------------------------------------------------------------
        ldiu      0,r2
        ldiu      @CL72,r1
        ldiu      *+fp(ir0),r3
        ldiu      0,r0
        push      r0
        push      r2
        push      r3
        push      r1
        call      _user_FaultDataTx
                                        ; Call Occurs
        subi      4,sp
	.line	262
;----------------------------------------------------------------------
; 611 | m_Variable.m_Recving_Posi += 128;                                      
;----------------------------------------------------------------------
        ldiu      128,r0
        addi      @_m_Variable+273,r0
        sti       r0,@_m_Variable+273
	.line	264
;----------------------------------------------------------------------
; 613 | user_CncsTx(btTx2chBuf,(sTxDataSize*2)+20);                            
; 615 | else                                                                   
; 616 | //¹Ù·Î Á¾·á ÄÚµå°¡ ¼ö½Å µÉ¼ö ÀÖ´Ù.                                     
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      2,r0
        mpyi3     r0,*+fp(ir0),r0
        ldiu      @CL72,r1
        addi      20,r0
        push      r0
        push      r1
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
        bu        L157
;*      Branch Occurs to L157 
L149:        
	.line	268
;----------------------------------------------------------------------
; 617 | if(m_Variable.m_bLnWkFtpEndFlag)                                       
;----------------------------------------------------------------------
        ldi       @_m_Variable+292,r0
        beq       L157
;*      Branch Occurs to L157 
	.line	270
;----------------------------------------------------------------------
; 619 | m_Variable.m_nFaultCnt++;                                              
; 620 | //aaa_CarAFautlCnt = m_nFaultCnt;                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+272,r0
        sti       r0,@_m_Variable+272
	.line	273
;----------------------------------------------------------------------
; 622 | if(m_Variable.m_nFaultCnt == 1)                                        
;----------------------------------------------------------------------
        cmpi      1,r0
        bne       L152
;*      Branch Occurs to L152 
	.line	274
;----------------------------------------------------------------------
; 623 | SetFltBlkStPos(m_Variable.m_chCarKind, m_Variable.m_Recving_Posi);
;     |                                                                  // Ã¹¹
;     | øÂ° ºí·ÏÀÏ °æ¿ì, °íÀå Á¤º¸ÀÇ ½ÃÀÛ À§Ä¡¸¦ ±â·Ï.                         
; 625 | // °íÀå Á¤º¸¸¦ ÀúÀåÇÏ´Â ºÎºÐ.                                          
;----------------------------------------------------------------------
        ldiu      @_m_Variable+273,r0
        push      r0
        ldiu      @_m_Variable+284,r0
        push      r0
        call      _SetFltBlkStPos
                                        ; Call Occurs
        subi      2,sp
L152:        
	.line	277
;----------------------------------------------------------------------
; 626 | SetFltBlkEdInfo(m_Variable.m_chCarKind, m_Variable.m_nNvsramPos, m_Vari
;     | able.m_nFaultCnt);                                                     
;----------------------------------------------------------------------
        ldiu      @_m_Variable+272,r1
        ldiu      @_m_Variable+291,r0
        push      r1
        push      r0
        ldiu      @_m_Variable+284,r0
        push      r0
        call      _SetFltBlkEdInfo
                                        ; Call Occurs
        subi      3,sp
	.line	279
;----------------------------------------------------------------------
; 628 | sTxDataSize = (m_Variable.m_nNvsramPos - m_Variable.m_Recving_Posi) + 2
;     | ;                                                                      
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      @_m_Variable+273,r0
        subri     @_m_Variable+291,r0   ; Unsigned
        addi      2,r0                  ; Unsigned
        sti       r0,*+fp(ir0)
	.line	280
;----------------------------------------------------------------------
; 629 | user_FaultDataTx(btTx2chBuf,sTxDataSize,TRUE,0);                       
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      0,r2
        ldiu      *+fp(ir0),r3
        ldiu      @CL72,r1
        push      r2
        push      r0
        push      r3
        push      r1
        call      _user_FaultDataTx
                                        ; Call Occurs
        subi      4,sp
	.line	281
;----------------------------------------------------------------------
; 630 | m_Variable.m_Recving_Posi += (sTxDataSize-2);                          
; 632 | // user_FtpEnd_CarNumFun();                                            
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      *+fp(ir0),r0
        addi      @_m_Variable+273,r0
        subi      2,r0
        sti       r0,@_m_Variable+273
	.line	285
;----------------------------------------------------------------------
; 634 | user_CncsTx(btTx2chBuf,(sTxDataSize*2)+20);                            
;----------------------------------------------------------------------
        ldiu      2,r1
        mpyi3     r1,*+fp(ir0),r1
        addi      20,r1
        push      r1
        ldiu      @CL72,r0
        push      r0
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
	.line	287
;----------------------------------------------------------------------
; 636 | m_Variable.m_LIC_CNCS_Tx_Flag = FALSE;                                 
; 639 | else                                                                   
; 640 | //---------------------------------------------------------------------
;     | ---------------                                                        
; 641 | //½Ã°£ Á¤º¸ ¿äÃ». LIC -> CNCS ·Î ½Ã°£ Á¤º¸¸¦ ¿äÃ» ÇÑ´Ù.(LIC´Â ¿­Â÷ ¹øÈ£
;     | ¸¦ Æ÷ÇÔÇÏ¿© Àü¼Û ÇÑ´Ù.)                                                
; 642 | //---------------------------------------------------------------------
;     | -----------------                                                      
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+269
        bu        L157
;*      Branch Occurs to L157 
L153:        
	.line	294
;----------------------------------------------------------------------
; 643 | if(m_Variable.m_nTxDbg1msTimer > 1000)                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+294,r0
        cmpi      1000,r0
        bls       L157
;*      Branch Occurs to L157 
	.line	296
;----------------------------------------------------------------------
; 645 | m_Variable.m_nTxDbg1msTimer = 0;                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+294
	.line	298
;----------------------------------------------------------------------
; 647 | nTimeSendCnt++;                                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_nTimeSendCnt$5+0,r0
        sti       r0,@_nTimeSendCnt$5+0
	.line	299
;----------------------------------------------------------------------
; 648 | nTimeSendCnt = nTimeSendCnt%255;                                       
;----------------------------------------------------------------------
        ldiu      255,r1
        call      MOD_I30
                                        ; Call Occurs
        sti       r0,@_nTimeSendCnt$5+0
	.line	301
;----------------------------------------------------------------------
; 650 | pCnsc_Lic_T_F = (CNCS_LIC_T_F *) btTx2chBuf;                           
;----------------------------------------------------------------------
        ldiu      997,ir0
        ldiu      @CL72,r0
        sti       r0,*+fp(ir0)
	.line	303
;----------------------------------------------------------------------
; 652 | sTxDataSize = 4;                                                       
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      4,r0
        sti       r0,*+fp(ir0)
	.line	305
;----------------------------------------------------------------------
; 654 | pCnsc_Lic_T_F->phHdBuf.btSoh =  0x01;                                  
;----------------------------------------------------------------------
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      1,r0
        sti       r0,*ar0
	.line	307
;----------------------------------------------------------------------
; 656 | pCnsc_Lic_T_F->phHdBuf.chSrcDev[0] =  ConvHex2Asc(BYTE_H(m_Variable.m_c
;     | hCarKindNum));                                                         
;----------------------------------------------------------------------
        ldiu      @_m_Variable+286,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(1)
	.line	308
;----------------------------------------------------------------------
; 657 | pCnsc_Lic_T_F->phHdBuf.chSrcDev[1] =  ConvHex2Asc(BYTE_L(m_Variable.m_c
;     | hCarKindNum));                                                         
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+286,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(2)
	.line	310
;----------------------------------------------------------------------
; 659 | pCnsc_Lic_T_F->phHdBuf.chDestDev[0] =  ConvHex2Asc(BYTE_H(m_Variable.m_
;     | chCncsKindNum));                                                       
;----------------------------------------------------------------------
        ldiu      @_m_Variable+287,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(3)
	.line	311
;----------------------------------------------------------------------
; 660 | pCnsc_Lic_T_F->phHdBuf.chDestDev[1] =  ConvHex2Asc(BYTE_L(m_Variable.m_
;     | chCncsKindNum));                                                       
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+287,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(4)
	.line	313
;----------------------------------------------------------------------
; 662 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[0] = ConvHex2Asc(BYTE_H(WORD_H(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      @_nTimeSendCnt$5+0,r0
        ash       -8,r0
        and       255,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(5)
	.line	314
;----------------------------------------------------------------------
; 663 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[1] = ConvHex2Asc(BYTE_L(WORD_H(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      @_nTimeSendCnt$5+0,r0
        ash       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(6)
	.line	315
;----------------------------------------------------------------------
; 664 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[2] = ConvHex2Asc(BYTE_H(WORD_L(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      255,r0
        and       @_nTimeSendCnt$5+0,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(7)
	.line	316
;----------------------------------------------------------------------
; 665 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[3] = ConvHex2Asc(BYTE_L(WORD_L(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_nTimeSendCnt$5+0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(8)
	.line	318
;----------------------------------------------------------------------
; 667 | pCnsc_Lic_T_F->phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(0x10));       
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(9)
	.line	319
;----------------------------------------------------------------------
; 668 | pCnsc_Lic_T_F->phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(0x10));       
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(10)
	.line	321
;----------------------------------------------------------------------
; 670 | pCnsc_Lic_T_F->phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(WORD_H(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      -8,r0
        ash3      r0,*+fp(ir0),r0
        and       255,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(11)
	.line	322
;----------------------------------------------------------------------
; 671 | pCnsc_Lic_T_F->phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(WORD_H(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      -8,r0
        ash3      r0,*+fp(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(12)
	.line	323
;----------------------------------------------------------------------
; 672 | pCnsc_Lic_T_F->phHdBuf.chDataLen[2] = ConvHex2Asc(BYTE_H(WORD_L(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      255,r0
        and3      r0,*+fp(ir0),r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(13)
	.line	324
;----------------------------------------------------------------------
; 673 | pCnsc_Lic_T_F->phHdBuf.chDataLen[3] = ConvHex2Asc(BYTE_L(WORD_L(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      15,r0
        and3      r0,*+fp(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(14)
	.line	326
;----------------------------------------------------------------------
; 675 | pCnsc_Lic_T_F->sCommand[0] = ConvHex2Asc(BYTE_H(0x08));                
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(15)
	.line	327
;----------------------------------------------------------------------
; 676 | pCnsc_Lic_T_F->sCommand[1] = ConvHex2Asc(BYTE_L(0x08));                
;----------------------------------------------------------------------
        ldiu      8,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(16)
	.line	329
;----------------------------------------------------------------------
; 678 | pCnsc_Lic_T_F->sTEXT[0] = ConvHex2Asc(BYTE_H(WORD_H(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+282,r0
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(17)
	.line	330
;----------------------------------------------------------------------
; 679 | pCnsc_Lic_T_F->sTEXT[1] = ConvHex2Asc(BYTE_L(WORD_H(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+282,r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(18)
	.line	331
;----------------------------------------------------------------------
; 680 | pCnsc_Lic_T_F->sTEXT[2] = ConvHex2Asc(BYTE_H(WORD_L(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      255,r0
        and       @_m_Variable+282,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(19)
	.line	332
;----------------------------------------------------------------------
; 681 | pCnsc_Lic_T_F->sTEXT[3] = ConvHex2Asc(BYTE_L(WORD_L(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+282,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(20)
	.line	334
;----------------------------------------------------------------------
; 683 | pCnsc_Lic_T_F->chContactSignalBuf[0] = ConvHex2Asc(BYTE_H(m_Variable.m_
;     | btCttSignalA.BYTE));                                                   
;----------------------------------------------------------------------
        ldiu      @_m_Variable+354,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(21)
	.line	335
;----------------------------------------------------------------------
; 684 | pCnsc_Lic_T_F->chContactSignalBuf[1] = ConvHex2Asc(BYTE_L(m_Variable.m_
;     | btCttSignalA.BYTE));                                                   
; 686 | //sBcc = Make1ByteBcc(&pCnsc_Lic_T_F->phHdBuf.chSrcDev[0],(sTxDataSize*
;     | 2)+14);                                                                
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+354,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(22)
	.line	339
;----------------------------------------------------------------------
; 688 | d_MDS_info = m_Variable.m_btCttSignalA.BYTE;                           
;----------------------------------------------------------------------
        ldiu      @_m_Variable+354,r0
        sti       r0,@_d_MDS_info+0
	.line	342
;----------------------------------------------------------------------
; 691 | btTmp = crc16_ccitt(&pCnsc_Lic_T_F->phHdBuf.chSrcDev[0],sizeof(CNCS_LIC
;     | _T_F)-6);                                                              
;----------------------------------------------------------------------
        ldiu      1,r0
        addi3     r0,*+fp(ir0),r0       ; Unsigned
        ldiu      22,r1
        push      r1
        push      r0
        call      _crc16_ccitt
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(13)
	.line	344
;----------------------------------------------------------------------
; 693 | pCnsc_Lic_T_F->nCRC[0] = ConvHex2Asc(BYTE_H(WORD_H(btTmp)));           
;----------------------------------------------------------------------
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      997,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(23)
	.line	345
;----------------------------------------------------------------------
; 694 | pCnsc_Lic_T_F->nCRC[1] = ConvHex2Asc(BYTE_L(WORD_H(btTmp)));           
;----------------------------------------------------------------------
        ldiu      *+fp(13),r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(24)
	.line	346
;----------------------------------------------------------------------
; 695 | pCnsc_Lic_T_F->nCRC[2] = ConvHex2Asc(BYTE_H(WORD_L(btTmp)));           
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *+fp(13),r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(25)
	.line	347
;----------------------------------------------------------------------
; 696 | pCnsc_Lic_T_F->nCRC[3] = ConvHex2Asc(BYTE_L(WORD_L(btTmp)));           
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *+fp(13),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      997,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(26)
	.line	349
;----------------------------------------------------------------------
; 698 | pCnsc_Lic_T_F->btEot = 0x04;                                           
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      4,r0
        sti       r0,*+ar0(27)
	.line	351
;----------------------------------------------------------------------
; 700 | user_CncsTx(&pCnsc_Lic_T_F->phHdBuf.btSoh,(sTxDataSize*2)+20);         
;----------------------------------------------------------------------
        ldiu      288,ir0
        ldiu      2,r0
        mpyi3     r0,*+fp(ir0),r0
        addi      20,r0
        ldiu      997,ir1
        push      r0
        ldiu      *+fp(ir1),r0
        push      r0
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
L157:        
	.line	356
;----------------------------------------------------------------------
; 705 | nOldUart2RxOneByteGapDelayTime = m_Variable.m_nUart2RxOneByteGapDelayTi
;     | me;                                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+226,r0
        sti       r0,@_nOldUart2RxOneByteGapDelayTime$2+0
	.line	357
        pop       r5
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      1001,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	706,000000030h,999


	.sect	 ".text"

	.global	_ClearFltBlkInfo
	.sym	_ClearFltBlkInfo,_ClearFltBlkInfo,32,2,0
	.func	709
;******************************************************************************
;* FUNCTION NAME: _ClearFltBlkInfo                                            *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,fp,sp                                      *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_ClearFltBlkInfo:
	.line	1
;----------------------------------------------------------------------
; 709 | void ClearFltBlkInfo()                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 711 | memset(&m_Variable.m_tFaultInfo, 0x00, sizeof(m_Variable.m_tFaultInfo))
;     | ;                        // °íÀå Á¤º¸ »èÁ¦.                            
;----------------------------------------------------------------------
        ldiu      6,r2
        ldiu      0,r0
        ldiu      @CL73,r1
        push      r2
        push      r0
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	4
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	712,000000000h,0


	.sect	 ".text"

	.global	_SetFltBlkStPos
	.sym	_SetFltBlkStPos,_SetFltBlkStPos,32,2,0
	.func	715
;******************************************************************************
;* FUNCTION NAME: _SetFltBlkStPos                                             *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,fp,sp,st                                     *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 1 Auto + 0 SOE = 5 words          *
;******************************************************************************
_SetFltBlkStPos:
	.sym	_chCarKind,-2,2,9,32
	.sym	_nStPosi,-3,4,9,32
	.sym	_pInfo,1,24,1,32,.fake69
	.line	1
;----------------------------------------------------------------------
; 715 | void SetFltBlkStPos(char chCarKind, int nStPosi)                       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 717 | PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 719 | if(pInfo != NULL)                                                      
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L165
;*      Branch Occurs to L165 
	.line	6
;----------------------------------------------------------------------
; 720 | pInfo->nStPosi = nStPosi;
;     |                  // °íÀå ½ÃÀÛ À§Ä¡¸¦ ÀúÀå.                             
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      *-fp(3),r0
        sti       r0,*+ar0(1)
L165:        
	.line	7
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	721,000000000h,1


	.sect	 ".text"

	.global	_SetFltBlkEdInfo
	.sym	_SetFltBlkEdInfo,_SetFltBlkEdInfo,32,2,0
	.func	724
;******************************************************************************
;* FUNCTION NAME: _SetFltBlkEdInfo                                            *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,fp,sp,st                                     *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 3 Parm + 1 Auto + 0 SOE = 6 words          *
;******************************************************************************
_SetFltBlkEdInfo:
	.sym	_chCarKind,-2,2,9,32
	.sym	_nEndPosi,-3,4,9,32
	.sym	_nFltTCnt,-4,4,9,32
	.sym	_pInfo,1,24,1,32,.fake69
	.line	1
;----------------------------------------------------------------------
; 724 | void SetFltBlkEdInfo(char chCarKind, int nEndPosi, int nFltTCnt)       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 726 | PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 728 | if(pInfo != NULL)                                                      
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L169
;*      Branch Occurs to L169 
	.line	7
;----------------------------------------------------------------------
; 730 | pInfo->nTCnt = nFltTCnt;
;     |                          // °íÀå ÀüÃ¼ °¹¼ö¸¦ ±â·Ï.                     
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      *-fp(4),r0
        sti       r0,*ar0
	.line	8
;----------------------------------------------------------------------
; 731 | pInfo->nEdPosi = nEndPosi;
;     |                          // °íÀå ¸¶Áö¸· À§Ä¡¸¦ ÀúÀå.                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *-fp(3),r0
        sti       r0,*+ar0(2)
L169:        
	.line	10
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	733,000000000h,1


	.sect	 ".text"

	.global	_GetFltBlkInfo
	.sym	_GetFltBlkInfo,_GetFltBlkInfo,104,2,0,.fake69
	.func	736
;******************************************************************************
;* FUNCTION NAME: _GetFltBlkInfo                                              *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_GetFltBlkInfo:
	.sym	_chCarKind,-2,2,9,32
	.sym	_nIdx,1,4,1,32
	.line	1
;----------------------------------------------------------------------
; 736 | PFAULT_INFO GetFltBlkInfo(char chCarKind)                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 738 | int nIdx = chCarKind - 'A';                                            
;----------------------------------------------------------------------
        ldiu      65,r0
        subri     *-fp(2),r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 740 | if(nIdx < eCDT_MAXIMUM)                                                
;----------------------------------------------------------------------
        cmpi      2,r0
        bge       L173
;*      Branch Occurs to L173 
	.line	6
;----------------------------------------------------------------------
; 741 | return &m_Variable.m_tFaultInfo[nIdx];                                 
;----------------------------------------------------------------------
        bud       L174
	nop
        mpyi      3,r0
        addi      @CL73,r0              ; Unsigned
;*      Branch Occurs to L174 
L173:        
	.line	8
;----------------------------------------------------------------------
; 743 | return NULL;                                                           
;----------------------------------------------------------------------
        ldiu      0,r0
L174:        
	.line	9
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	744,000000000h,1


	.sect	 ".text"

	.global	_GetFltBlkStPos
	.sym	_GetFltBlkStPos,_GetFltBlkStPos,36,2,0
	.func	747
;******************************************************************************
;* FUNCTION NAME: _GetFltBlkStPos                                             *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,fp,sp,st                                     *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 2 Auto + 0 SOE = 5 words          *
;******************************************************************************
_GetFltBlkStPos:
	.sym	_chCarKind,-2,2,9,32
	.sym	_nStPos,1,4,1,32
	.sym	_pInfo,2,24,1,32,.fake69
	.line	1
;----------------------------------------------------------------------
; 747 | int GetFltBlkStPos(char chCarKind)                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 749 | int nStPos = -1;                                                       
;----------------------------------------------------------------------
        ldiu      -1,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 750 | PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(2)
	.line	6
;----------------------------------------------------------------------
; 752 | if(pInfo != NULL)                                                      
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L178
;*      Branch Occurs to L178 
	.line	7
;----------------------------------------------------------------------
; 753 | nStPos = pInfo->nStPosi;                                               
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      *+ar0(1),r0
        sti       r0,*+fp(1)
L178:        
	.line	9
;----------------------------------------------------------------------
; 755 | return nStPos;                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	10
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      4,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	756,000000000h,2


	.sect	 ".text"

	.global	_user_FaultDataTx
	.sym	_user_FaultDataTx,_user_FaultDataTx,32,2,0
	.func	758
;******************************************************************************
;* FUNCTION NAME: _user_FaultDataTx                                           *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,fp,sp,st                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 4 Parm + 4 Auto + 0 SOE = 10 words         *
;******************************************************************************
_user_FaultDataTx:
	.sym	_pTxBuf,-2,28,9,32
	.sym	_nLen,-3,12,9,32
	.sym	_nEndFlag,-4,12,9,32
	.sym	_nFltIdx,-5,4,9,32
	.sym	_btTmp,1,12,1,32
	.sym	_sTempData,2,12,1,32
	.sym	_pLic_Cncs,3,24,1,32,.fake42
	.sym	_pNvsram,4,28,1,32
	.line	1
;----------------------------------------------------------------------
; 758 | void user_FaultDataTx(UCHAR *pTxBuf,UCHAR nLen,UCHAR nEndFlag,int nFltI
;     | dx)                                                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      4,sp
	.line	2
;----------------------------------------------------------------------
; 760 | UCHAR btTmp;                                                           
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 761 | UCHAR sTempData = 0;                                                   
; 762 | PLIC_CNCS_HD pLic_Cncs;                                                
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	6
;----------------------------------------------------------------------
; 763 | UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;                                 
;----------------------------------------------------------------------
        ldiu      @CL67,r0
        sti       r0,*+fp(4)
	.line	8
;----------------------------------------------------------------------
; 765 | pLic_Cncs =(LIC_CNCS_HD *) pTxBuf;                                     
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        sti       r0,*+fp(3)
	.line	10
;----------------------------------------------------------------------
; 767 | pLic_Cncs->phHdBuf.btSoh = 0x01;                                       
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      1,r0
        sti       r0,*ar0
	.line	12
;----------------------------------------------------------------------
; 769 | pLic_Cncs->phHdBuf.chSrcDev[0] =  ConvHex2Asc(BYTE_H(m_Variable.m_chCar
;     | KindNum));                                                             
;----------------------------------------------------------------------
        ldiu      @_m_Variable+286,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(1)
	.line	13
;----------------------------------------------------------------------
; 770 | pLic_Cncs->phHdBuf.chSrcDev[1] =  ConvHex2Asc(BYTE_L(m_Variable.m_chCar
;     | KindNum));                                                             
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+286,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(2)
	.line	14
;----------------------------------------------------------------------
; 771 | pLic_Cncs->phHdBuf.chDestDev[0] =  ConvHex2Asc(BYTE_H(m_Variable.m_chCn
;     | csKindNum));                                                           
;----------------------------------------------------------------------
        ldiu      @_m_Variable+287,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(3)
	.line	15
;----------------------------------------------------------------------
; 772 | pLic_Cncs->phHdBuf.chDestDev[1] =  ConvHex2Asc(BYTE_L(m_Variable.m_chCn
;     | csKindNum));                                                           
; 774 | // °íÀå ÀÎµ¦½º¸¦ ½Å±Ô·Î »ý¼º(Y.J ¼öÁ¤)                                 
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+287,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(4)
	.line	18
;----------------------------------------------------------------------
; 775 | if(!nFltIdx) nFltIdx = m_Variable.m_nFaultCnt;                         
;----------------------------------------------------------------------
        ldi       *-fp(5),r0
        bne       L183
;*      Branch Occurs to L183 
        ldiu      @_m_Variable+272,r0
        sti       r0,*-fp(5)
L183:        
	.line	20
;----------------------------------------------------------------------
; 777 | pLic_Cncs->phHdBuf.chMsgCnt[0] = ConvHex2Asc(BYTE_H(WORD_H(nFltIdx))); 
;----------------------------------------------------------------------
        ldiu      *-fp(5),r0
        ash       -8,r0
        and       255,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(5)
	.line	21
;----------------------------------------------------------------------
; 778 | pLic_Cncs->phHdBuf.chMsgCnt[1] = ConvHex2Asc(BYTE_L(WORD_H(nFltIdx))); 
;----------------------------------------------------------------------
        ldiu      *-fp(5),r0
        ash       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(6)
	.line	22
;----------------------------------------------------------------------
; 779 | pLic_Cncs->phHdBuf.chMsgCnt[2] = ConvHex2Asc(BYTE_H(WORD_L(nFltIdx))); 
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(5),r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(7)
	.line	23
;----------------------------------------------------------------------
; 780 | pLic_Cncs->phHdBuf.chMsgCnt[3] = ConvHex2Asc(BYTE_L(WORD_L(nFltIdx))); 
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *-fp(5),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(8)
	.line	25
;----------------------------------------------------------------------
; 782 | pLic_Cncs->phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(0x10));           
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(9)
	.line	26
;----------------------------------------------------------------------
; 783 | pLic_Cncs->phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(0x10));           
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(10)
	.line	28
;----------------------------------------------------------------------
; 785 | pLic_Cncs->phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(WORD_H(nLen)));   
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(11)
	.line	29
;----------------------------------------------------------------------
; 786 | pLic_Cncs->phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(WORD_H(nLen)));   
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(12)
	.line	30
;----------------------------------------------------------------------
; 787 | pLic_Cncs->phHdBuf.chDataLen[2] = ConvHex2Asc(BYTE_H(WORD_L(nLen)));   
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(3),r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(13)
	.line	31
;----------------------------------------------------------------------
; 788 | pLic_Cncs->phHdBuf.chDataLen[3] = ConvHex2Asc(BYTE_L(WORD_L(nLen)));   
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *-fp(3),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(14)
	.line	33
;----------------------------------------------------------------------
; 790 | if(nEndFlag)                                                           
;----------------------------------------------------------------------
        ldi       *-fp(4),r0
        beq       L185
;*      Branch Occurs to L185 
	.line	35
;----------------------------------------------------------------------
; 792 | pLic_Cncs->sCommand[0] = ConvHex2Asc(BYTE_H(0x06));//°íÀå Á¤º¸ ¼ö½Å ³¡.
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(15)
	.line	36
;----------------------------------------------------------------------
; 793 | pLic_Cncs->sCommand[1] = ConvHex2Asc(BYTE_L(0x06));//°íÀå Á¤º¸ ¼ö½Å ³¡.
; 795 | else                                                                   
;----------------------------------------------------------------------
        ldiu      6,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(16)
        bu        L186
;*      Branch Occurs to L186 
L185:        
	.line	40
;----------------------------------------------------------------------
; 797 | pLic_Cncs->sCommand[0] = ConvHex2Asc(BYTE_H(0x04));//°íÀå Á¤º¸ ¼ö½Å Áß.
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(15)
	.line	41
;----------------------------------------------------------------------
; 798 | pLic_Cncs->sCommand[1] = ConvHex2Asc(BYTE_L(0x04));//°íÀå Á¤º¸ ¼ö½Å Áß.
;----------------------------------------------------------------------
        ldiu      4,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(16)
L186:        
	.line	44
;----------------------------------------------------------------------
; 801 | pLic_Cncs->sCarKind[0] = ConvHex2Asc(BYTE_H(m_Variable.m_chCarKind));  
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(17)
	.line	45
;----------------------------------------------------------------------
; 802 | pLic_Cncs->sCarKind[1] = ConvHex2Asc(BYTE_L(m_Variable.m_chCarKind));  
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+284,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        sti       r0,*+ar0(18)
	.line	47
;----------------------------------------------------------------------
; 804 | FunConvHexAsc(&pNvsram[m_Variable.m_Recving_Posi],(char *)pLic_Cncs->sT
;     | extDataAsc,(nLen-2));                                                  
;----------------------------------------------------------------------
        ldiu      19,r1
        ldiu      2,r2
        ldiu      @_m_Variable+273,r0
        addi      *+fp(4),r0            ; Unsigned
        addi      *+fp(3),r1            ; Unsigned
        subri     *-fp(3),r2            ; Unsigned
        push      r2
        push      r1
        push      r0
        call      _FunConvHexAsc
                                        ; Call Occurs
        subi      3,sp
	.line	51
;----------------------------------------------------------------------
; 808 | btTmp = crc16_ccitt(&pLic_Cncs->phHdBuf.chSrcDev[0],(nLen*2)+14);      
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        mpyi      2,r0
        ldiu      1,r1
        addi      *+fp(3),r1            ; Unsigned
        addi      14,r0                 ; Unsigned
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(1)
	.line	52
;----------------------------------------------------------------------
; 809 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)] =   ConvHex2Asc(BYTE_H(WORD_H(btT
;     | mp)));                                                                 
;----------------------------------------------------------------------
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      2,ar0
        subri     *-fp(3),ar0           ; Unsigned
        mpyi      2,ar0
        addi      *+fp(3),ar0           ; Unsigned
        sti       r0,*+ar0(19)
	.line	53
;----------------------------------------------------------------------
; 810 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)+1] = ConvHex2Asc(BYTE_L(WORD_H(btT
;     | mp)));                                                                 
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      2,ar0
        subri     *-fp(3),ar0           ; Unsigned
        mpyi      2,ar0
        addi      *+fp(3),ar0           ; Unsigned
        sti       r0,*+ar0(20)
	.line	54
;----------------------------------------------------------------------
; 811 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)+2] = ConvHex2Asc(BYTE_H(WORD_L(btT
;     | mp)));                                                                 
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *+fp(1),r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      2,ar0
        subri     *-fp(3),ar0           ; Unsigned
        mpyi      2,ar0
        addi      *+fp(3),ar0           ; Unsigned
        sti       r0,*+ar0(21)
	.line	55
;----------------------------------------------------------------------
; 812 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)+3] = ConvHex2Asc(BYTE_L(WORD_L(btT
;     | mp)));                                                                 
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *+fp(1),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      2,ar0
        subri     *-fp(3),ar0           ; Unsigned
        mpyi      2,ar0
        addi      *+fp(3),ar0           ; Unsigned
        sti       r0,*+ar0(22)
	.line	57
;----------------------------------------------------------------------
; 814 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)+4] = 0x04;                        
;----------------------------------------------------------------------
        ldiu      2,ar0
        subri     *-fp(3),ar0           ; Unsigned
        mpyi      2,ar0
        addi      *+fp(3),ar0           ; Unsigned
        ldiu      4,r0
        sti       r0,*+ar0(23)
	.line	59
;----------------------------------------------------------------------
; 816 | m_Variable.m_LIC_CNCS_TX_DelyTime = 0;                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+270
	.line	60
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      6,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	817,000000000h,4


	.sect	 ".text"

	.global	_user_FtpEnd_CarNumFun
	.sym	_user_FtpEnd_CarNumFun,_user_FtpEnd_CarNumFun,32,2,0
	.func	822
;******************************************************************************
;* FUNCTION NAME: _user_FtpEnd_CarNumFun                                      *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0                                                  *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_user_FtpEnd_CarNumFun:
	.line	1
;----------------------------------------------------------------------
; 822 | void user_FtpEnd_CarNumFun()                                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 824 | m_Variable.m_bLnWkFtpEndFlag = FALSE;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+292
	.line	5
;----------------------------------------------------------------------
; 826 | m_Variable.m_LIC_CNCS_Tx_Flag = FALSE; //°íÀå Á¤º¸ ¸¶Áö¸· ºí·° ÀÌ¹Ç·Î À
;     | ü¼Û ³¡.                                                                
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+269
	.line	6
;----------------------------------------------------------------------
; 827 | m_Variable.m_nNvsramPos = 0;                                           
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+291
	.line	7
;----------------------------------------------------------------------
; 828 | m_Variable.m_Recving_Posi = 0;                                         
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+273
	.line	8
;----------------------------------------------------------------------
; 829 | m_Variable.m_nLnWkWaySideOnRxOk = 0;                                   
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+289
	.line	9
;----------------------------------------------------------------------
; 830 | m_Variable.m_nFaultCnt = 0;                                            
; 831 | //m_chCarKind = 'A';                                                   
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+272
	.line	11
;----------------------------------------------------------------------
; 832 | m_Variable.m_nLnWkTxFlag = 0;                                          
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+271
	.line	13
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	834,000000000h,0



	.sect	".cinit"
	.field  	1,32
	.field  	_d_CI_Fault+0,32
	.field  	0,32		; _d_CI_Fault @ 0

	.sect	".text"

	.global	_d_CI_Fault
	.bss	_d_CI_Fault,1
	.sym	_d_CI_Fault,_d_CI_Fault,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_CI_Index+0,32
	.field  	0,32		; _d_CI_Index @ 0

	.sect	".text"

	.global	_d_CI_Index
	.bss	_d_CI_Index,1
	.sym	_d_CI_Index,_d_CI_Index,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_CarNum+0,32
	.field  	0,32		; _d_CarNum @ 0

	.sect	".text"

	.global	_d_CarNum
	.bss	_d_CarNum,1
	.sym	_d_CarNum,_d_CarNum,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_CarConfig+0,32
	.field  	0,32		; _d_CarConfig @ 0

	.sect	".text"

	.global	_d_CarConfig
	.bss	_d_CarConfig,1
	.sym	_d_CarConfig,_d_CarConfig,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_CarConfig_St+0,32
	.field  	0,32		; _d_CarConfig_St @ 0

	.sect	".text"

	.global	_d_CarConfig_St
	.bss	_d_CarConfig_St,1
	.sym	_d_CarConfig_St,_d_CarConfig_St,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_ddddd+0,32
	.field  	0,32		; _ddddd @ 0

	.sect	".text"

	.global	_ddddd
	.bss	_ddddd,1
	.sym	_ddddd,_ddddd,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_Linc_to_PAC+0,32
	.field  	0,32		; _d_Linc_to_PAC @ 0

	.sect	".text"

	.global	_d_Linc_to_PAC
	.bss	_d_Linc_to_PAC,1
	.sym	_d_Linc_to_PAC,_d_Linc_to_PAC,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_Lic_to_PAC_Cnt+0,32
	.field  	0,32		; _m_Lic_to_PAC_Cnt @ 0

	.sect	".text"

	.global	_m_Lic_to_PAC_Cnt
	.bss	_m_Lic_to_PAC_Cnt,1
	.sym	_m_Lic_to_PAC_Cnt,_m_Lic_to_PAC_Cnt,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_Rem_Lic_to_PAC_Cnt+0,32
	.field  	0,32		; _Rem_Lic_to_PAC_Cnt @ 0

	.sect	".text"

	.global	_Rem_Lic_to_PAC_Cnt
	.bss	_Rem_Lic_to_PAC_Cnt,1
	.sym	_Rem_Lic_to_PAC_Cnt,_Rem_Lic_to_PAC_Cnt,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_nRxPos$6+0,32
	.field  	0,32		; _nRxPos$6 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nOldUart3RxOneByteGapDelayTime$7+0,32
	.field  	0,32		; _nOldUart3RxOneByteGapDelayTime$7 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_user_WithPacRs485Loop
	.sym	_user_WithPacRs485Loop,_user_WithPacRs485Loop,32,2,0
	.func	852
;******************************************************************************
;* FUNCTION NAME: _user_WithPacRs485Loop                                      *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r4,ar0,fp,ir0,ir1,sp,st                    *
;*   Regs Saved         : r4                                                  *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 432 Auto + 1 SOE = 435 words      *
;******************************************************************************
_user_WithPacRs485Loop:
	.bss	_nRxPos$6,1
	.sym	_nRxPos,_nRxPos$6,4,3,32
	.bss	_nOldUart3RxOneByteGapDelayTime$7,1
	.sym	_nOldUart3RxOneByteGapDelayTime,_nOldUart3RxOneByteGapDelayTime$7,12,3,32
	.bss	_btRx3chBuf$8,500
	.sym	_btRx3chBuf,_btRx3chBuf$8,60,3,16000,,500
	.sym	_i,1,4,1,32
	.sym	_nRxLen,2,4,1,32
	.sym	_sCarPosionIndex,3,4,1,32
	.sym	_sCabKeyCheck,4,4,1,32
	.sym	_sCabKeyCheck1,5,4,1,32
	.sym	_sIndexValue_A,6,12,1,32
	.sym	_sIndexValue_B,7,12,1,32
	.sym	_btTmp,8,12,1,32
	.sym	_btTmpBuf,9,60,1,3200,,100
	.sym	_btBuf,109,60,1,9600,,300
	.sym	_pPaSdrBuf,409,24,1,32,.fake13
	.sym	_lsLicSdBuf,410,8,1,704,.fake36
	.sym	_pPa_PaBuf,432,24,1,32,.fake34
	.line	1
;----------------------------------------------------------------------
; 852 | void user_WithPacRs485Loop()                                           
; 854 | int i;                                                                 
; 855 | int nRxLen;                                                            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      432,sp
        push      r4
	.line	6
;----------------------------------------------------------------------
; 857 | int sCarPosionIndex = 0;                                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(3)
	.line	7
;----------------------------------------------------------------------
; 858 | int sCabKeyCheck = 0;                                                  
;----------------------------------------------------------------------
        sti       r0,*+fp(4)
	.line	8
;----------------------------------------------------------------------
; 859 | int sCabKeyCheck1 = 0;                                                 
;----------------------------------------------------------------------
        sti       r0,*+fp(5)
	.line	10
;----------------------------------------------------------------------
; 861 | UCHAR sIndexValue_A = 0; // CI Index °ªÀ» È®ÀÎ ÇÏ´Â º¯¼ö.              
;----------------------------------------------------------------------
        sti       r0,*+fp(6)
	.line	11
;----------------------------------------------------------------------
; 862 | UCHAR sIndexValue_B = 0;                                               
; 864 | UCHAR btTmp;                                                           
; 865 | UCHAR btTmpBuf[100];                                                   
; 866 | UCHAR btBuf[300];                                                      
; 868 | static int nRxPos = 0;                                                 
; 869 | static UCHAR nOldUart3RxOneByteGapDelayTime = 0;                       
; 870 | static UCHAR btRx3chBuf[500];                                          
; 873 | PPACSDR pPaSdrBuf;                                                     
; 874 | LICSD lsLicSdBuf;                                                      
; 877 | PPAC_PAC pPa_PaBuf;                                                    
; 880 | //½ÃÀÛ                                                                 
; 881 | // ¼ö½Å                                                                
;----------------------------------------------------------------------
        sti       r0,*+fp(7)
	.line	31
;----------------------------------------------------------------------
; 882 | nRxLen = user_PacRx(btBuf,128);                                        
;----------------------------------------------------------------------
        ldiu      128,r1
        ldiu      fp,r0
        push      r1
        addi      109,r0
        push      r0
        call      _user_PacRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(2)
	.line	32
;----------------------------------------------------------------------
; 883 | if(nRxLen)                                                             
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L197
;*      Branch Occurs to L197 
	.line	34
;----------------------------------------------------------------------
; 885 | if(!m_Variable.m_nUart3RxOneByteGapDelayTime) nRxPos = 0;              
;----------------------------------------------------------------------
        ldi       @_m_Variable+227,r0
        bne       L195
;*      Branch Occurs to L195 
        ldiu      0,r0
        sti       r0,@_nRxPos$6+0
L195:        
	.line	35
;----------------------------------------------------------------------
; 886 | m_Variable.m_nUart3RxOneByteGapDelayTime = 3;                          
;----------------------------------------------------------------------
        ldiu      3,r0
        sti       r0,@_m_Variable+227
	.line	37
;----------------------------------------------------------------------
; 888 | if(nRxPos + nRxLen < 500)                                              
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$6+0,r0
        cmpi      500,r0
        bged      L197
        ldilt     @CL74,r0
        ldilt     fp,r1
        ldilt     *+fp(2),r2
;*      Branch Occurs to L197 
	.line	39
;----------------------------------------------------------------------
; 890 | memcpy(&btRx3chBuf[nRxPos],btBuf,nRxLen);                              
;----------------------------------------------------------------------
        addi      @_nRxPos$6+0,r0       ; Unsigned
        addi      109,r1
        push      r2
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	40
;----------------------------------------------------------------------
; 891 | nRxPos += nRxLen;                                                      
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$6+0,r0
        sti       r0,@_nRxPos$6+0
L197:        
	.line	45
;----------------------------------------------------------------------
; 896 | if(nOldUart3RxOneByteGapDelayTime && !m_Variable.m_nUart3RxOneByteGapDe
;     | layTime)                                                               
;----------------------------------------------------------------------
        ldi       @_nOldUart3RxOneByteGapDelayTime$7+0,r0
        beq       L262
;*      Branch Occurs to L262 
        ldi       @_m_Variable+227,r0
        bne       L262
;*      Branch Occurs to L262 
	.line	48
;----------------------------------------------------------------------
; 899 | if(nRxPos >= 10)                                                       
;----------------------------------------------------------------------
        ldiu      @_nRxPos$6+0,r0
        cmpi      10,r0
        blt       L262
;*      Branch Occurs to L262 
	.line	50
;----------------------------------------------------------------------
; 901 | pPaSdrBuf = (PACSDR *)btRx3chBuf;                                      
;----------------------------------------------------------------------
        ldiu      409,ir0
        ldiu      @CL74,r0
        sti       r0,*+fp(ir0)
	.line	52
;----------------------------------------------------------------------
; 903 | pPa_PaBuf = (PAC_PAC *)btRx3chBuf;                                     
; 906 | //PAC -> LIC ºÎºÐ ÇÁ·ÎÅäÄÝÀ» ºÐ¸® ÇÑ´Ù.                                
;----------------------------------------------------------------------
        ldiu      432,ir0
        sti       r0,*+fp(ir0)
	.line	56
;----------------------------------------------------------------------
; 907 | if(WORD_L(pPaSdrBuf->phHdBuf.btSoh) == SOH &&                          
; 908 |         WORD_L(pPaSdrBuf->btEot) == EOT &&                             
; 909 |         sizeof(PACSDR) == nRxPos &&                                    
; 910 |         (TWOBYTE_ASC2HEX(pPaSdrBuf->phHdBuf.chDestDev) == m_Variable.m_
;     | chCarKindNum)&&                                                        
; 912 |         ConvAsc2Hex(pPaSdrBuf->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&p
;     | PaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                            
; 913 |         ConvAsc2Hex(pPaSdrBuf->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&p
;     | PaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                            
; 914 |         ConvAsc2Hex(pPaSdrBuf->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&p
;     | PaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                            
; 915 |         ConvAsc2Hex(pPaSdrBuf->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&p
;     | PaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6))))                             
; 919 |         switch(TWOBYTE_ASC2HEX(pPaSdrBuf->phHdBuf.chCmdCode))          
; 921 |         case REQ_CMD: //LIC -> PAC                                     
;----------------------------------------------------------------------
        ldiu      409,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
        cmpi      1,r0
        bne       L216
;*      Branch Occurs to L216 
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and       *+ar0(25),r0
        cmpi      4,r0
        bne       L216
;*      Branch Occurs to L216 
        ldiu      26,r0
        cmpi      @_nRxPos$6+0,r0
        bne       L216
;*      Branch Occurs to L216 
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(3),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      409,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(4),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        cmpi      @_m_Variable+286,r0
        subi      1,sp
        bne       L216
;*      Branch Occurs to L216 
        ldiu      1,r1
        ldiu      409,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      409,ir0
        ldiu      r0,r4
        subi      2,sp
        lsh       -8,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(21),r0
        lsh       -4,r4
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L216
;*      Branch Occurs to L216 
        ldiu      1,r1
        ldiu      409,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      409,ir0
        subi      2,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(22),r0
        lsh       -8,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L216
;*      Branch Occurs to L216 
        ldiu      1,r1
        ldiu      409,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      409,ir0
        subi      2,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(23),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L216
;*      Branch Occurs to L216 
        ldiu      1,r1
        ldiu      409,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      409,ir0
        subi      2,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(24),r0
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L216
;*      Branch Occurs to L216 
        bud       L213
        ldiu      409,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(7),r0
;*      Branch Occurs to L213 
	.line	72
;----------------------------------------------------------------------
; 923 | lsLicSdBuf.phHdBuf.btSoh = SOH;                                        
;----------------------------------------------------------------------
L210:        
        sti       r0,*+fp(ir0)
	.line	73
;----------------------------------------------------------------------
; 924 | lsLicSdBuf.phHdBuf.chSrcDev[0] = ConvHex2Asc(BYTE_H(m_Variable.m_chCarK
;     | indNum));                                                              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+286,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      411,ir0
        sti       r0,*+fp(ir0)
	.line	74
;----------------------------------------------------------------------
; 925 | lsLicSdBuf.phHdBuf.chSrcDev[1] = ConvHex2Asc(BYTE_L(m_Variable.m_chCarK
;     | indNum));                                                              
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+286,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      412,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	75
;----------------------------------------------------------------------
; 926 | lsLicSdBuf.phHdBuf.chDestDev[0] = pPaSdrBuf->phHdBuf.chSrcDev[0];      
;----------------------------------------------------------------------
        ldiu      409,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      413,ir0
        ldiu      *+ar0(1),r0
        sti       r0,*+fp(ir0)
	.line	76
;----------------------------------------------------------------------
; 927 | lsLicSdBuf.phHdBuf.chDestDev[1] = pPaSdrBuf->phHdBuf.chSrcDev[1];      
;----------------------------------------------------------------------
        ldiu      409,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      414,ir0
        ldiu      *+ar0(2),r0
        sti       r0,*+fp(ir0)
	.line	77
;----------------------------------------------------------------------
; 928 | lsLicSdBuf.phHdBuf.chMsgCnt[0] = pPaSdrBuf->phHdBuf.chMsgCnt[0];       
;----------------------------------------------------------------------
        ldiu      409,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      415,ir0
        ldiu      *+ar0(5),r0
        sti       r0,*+fp(ir0)
	.line	78
;----------------------------------------------------------------------
; 929 | lsLicSdBuf.phHdBuf.chMsgCnt[1] = pPaSdrBuf->phHdBuf.chMsgCnt[1];       
;----------------------------------------------------------------------
        ldiu      409,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      416,ir0
        ldiu      *+ar0(6),r0
        sti       r0,*+fp(ir0)
	.line	79
;----------------------------------------------------------------------
; 930 | lsLicSdBuf.phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(RPY_CMD));        
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      417,ir0
        sti       r0,*+fp(ir0)
	.line	80
;----------------------------------------------------------------------
; 931 | lsLicSdBuf.phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(RPY_CMD));        
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      418,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	82
;----------------------------------------------------------------------
; 933 | lsLicSdBuf.phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H((WORD_H(sizeof(LIC
;     | SD)-18)/2)));                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      419,ir0
        sti       r0,*+fp(ir0)
	.line	83
;----------------------------------------------------------------------
; 934 | lsLicSdBuf.phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L((WORD_H(sizeof(LIC
;     | SD)-18)/2)));                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      420,ir0
        sti       r0,*+fp(ir0)
	.line	85
;----------------------------------------------------------------------
; 936 | lsLicSdBuf.phHdBuf.chDataLen[2] = ConvHex2Asc(BYTE_H((WORD_L(sizeof(LIC
;     | SD)-18)/2)));                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      421,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	86
;----------------------------------------------------------------------
; 937 | lsLicSdBuf.phHdBuf.chDataLen[3] = ConvHex2Asc(BYTE_L((WORD_L(sizeof(LIC
;     | SD)-18)/2)));                                                          
;----------------------------------------------------------------------
        ldiu      2,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      422,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	89
;----------------------------------------------------------------------
; 940 | lsLicSdBuf.DATA1.BIT.All_Doors_Closed = m_Variable.m_btCttSignalA.BIT.A
;     | ll_Doors_Closed;                                                       
;----------------------------------------------------------------------
        ldiu      8,r0
        and       @_m_Variable+354,r0
        ldiu      424,ir0
        lsh       -3,r0
        ldiu      *+fp(ir0),r1
        and       1,r0
        andn      1,r1
        ldiu      424,ir1
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	90
;----------------------------------------------------------------------
; 941 | lsLicSdBuf.DATA1.BIT.EP_Mode = m_Variable.m_btCttSignalA.BIT.EP_Mode;  
;----------------------------------------------------------------------
        ldiu      4,r0
        and       @_m_Variable+354,r0
        lsh       -2,r0
        and       1,r0
        ash       1,r0
        ldiu      *+fp(ir0),r1
        andn      2,r1
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	91
;----------------------------------------------------------------------
; 942 | lsLicSdBuf.DATA1.BIT.Traction = m_Variable.m_btCttSignalA.BIT.Traction;
;----------------------------------------------------------------------
        ldiu      2,r0
        and       @_m_Variable+354,r0
        lsh       -1,r0
        and       1,r0
        ldiu      *+fp(ir0),r1
        ash       2,r0
        andn      4,r1
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	92
;----------------------------------------------------------------------
; 943 | lsLicSdBuf.DATA1.BIT.Atcive_Cab = m_Variable.m_btCttSignalA.BIT.Atcive_
;     | Cab;                                                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(ir0),r1
        and       @_m_Variable+354,r0
        andn      8,r1
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	94
;----------------------------------------------------------------------
; 945 | lsLicSdBuf.DATA2.BIT.CI_Fault = m_Variable.m_bCiFaultFlag;             
;----------------------------------------------------------------------
        ldiu      423,ir1
        ldiu      1,r0
        and       @_m_Variable+361,r0
        ldiu      423,ir0
        ash       2,r0
        ldiu      *+fp(ir0),r1
        andn      4,r1
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	95
;----------------------------------------------------------------------
; 946 | lsLicSdBuf.DATA2.BIT.DST = 0;                                          
;----------------------------------------------------------------------
        ldiu      *+fp(ir1),r0
        andn      8,r0
        sti       r0,*+fp(ir0)
	.line	98
;----------------------------------------------------------------------
; 949 | lsLicSdBuf.DATA1.BYTE = ConvHex2Asc(BYTE_L(lsLicSdBuf.DATA1.BYTE));    
;----------------------------------------------------------------------
        ldiu      424,ir0
        ldiu      15,r0
        and3      r0,*+fp(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      424,ir0
        sti       r0,*+fp(ir0)
	.line	99
;----------------------------------------------------------------------
; 950 | lsLicSdBuf.DATA2.BYTE = ConvHex2Asc(BYTE_L(lsLicSdBuf.DATA2.BYTE));    
;----------------------------------------------------------------------
        ldiu      423,ir0
        ldiu      15,r0
        and3      r0,*+fp(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      423,ir0
        sti       r0,*+fp(ir0)
	.line	103
;----------------------------------------------------------------------
; 954 | lsLicSdBuf.CI_Index_Num[0] = ConvHex2Asc(BYTE_H(m_Variable.m_nCarPos));
;----------------------------------------------------------------------
        ldiu      @_m_Variable+279,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      425,ir0
        sti       r0,*+fp(ir0)
	.line	104
;----------------------------------------------------------------------
; 955 | lsLicSdBuf.CI_Index_Num[1] = ConvHex2Asc(BYTE_L(m_Variable.m_nCarPos));
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+279,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      426,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	106
;----------------------------------------------------------------------
; 957 | btTmp = crc16_ccitt(&lsLicSdBuf.phHdBuf.chSrcDev[0],sizeof(LICSD)-6);  
;----------------------------------------------------------------------
        ldiu      16,r1
        ldiu      411,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _crc16_ccitt
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(8)
	.line	107
;----------------------------------------------------------------------
; 958 | lsLicSdBuf.nCRC[0] = ConvHex2Asc(BYTE_H(WORD_H(btTmp)));               
;----------------------------------------------------------------------
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      427,ir0
        sti       r0,*+fp(ir0)
	.line	108
;----------------------------------------------------------------------
; 959 | lsLicSdBuf.nCRC[1] = ConvHex2Asc(BYTE_L(WORD_H(btTmp)));               
;----------------------------------------------------------------------
        ldiu      *+fp(8),r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      428,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	109
;----------------------------------------------------------------------
; 960 | lsLicSdBuf.nCRC[2] = ConvHex2Asc(BYTE_H(WORD_L(btTmp)));               
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *+fp(8),r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      429,ir0
        sti       r0,*+fp(ir0)
	.line	110
;----------------------------------------------------------------------
; 961 | lsLicSdBuf.nCRC[3] = ConvHex2Asc(BYTE_L(WORD_L(btTmp)));               
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *+fp(8),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      430,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	111
;----------------------------------------------------------------------
; 962 | lsLicSdBuf.btEot = EOT;                                                
;----------------------------------------------------------------------
        ldiu      431,ir0
        ldiu      4,r0
        sti       r0,*+fp(ir0)
	.line	113
;----------------------------------------------------------------------
; 964 | user_PacTx((UCHAR *)&lsLicSdBuf,sizeof(LICSD));                        
; 966 | //MyPrintf("LIC--> PAC");                                              
; 970 | //MyPrintf_TxAuto((UCHAR *)&lsLicSdBuf,sizeof(LICSD));                 
;----------------------------------------------------------------------
        ldiu      410,r0
        addi      fp,r0
        ldiu      22,r1
        push      r1
        push      r0
        call      _user_PacTx
                                        ; Call Occurs
        subi      2,sp
	.line	121
;----------------------------------------------------------------------
; 972 | break;                                                                 
; 973 | default:                                                               
;----------------------------------------------------------------------
        bu        L262
;*      Branch Occurs to L262 
	.line	123
;----------------------------------------------------------------------
; 974 | break;                                                                 
; 978 | else                                                                   
;----------------------------------------------------------------------
	.line	68
L213:        
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      409,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(8),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        cmpi      16,r0
        beqd      L210
        subi      1,sp
        ldieq     410,ir0
        ldieq     1,r0
;*      Branch Occurs to L210 
        bu        L262
;*      Branch Occurs to L262 
L216:        
	.line	128
;----------------------------------------------------------------------
; 979 | if(WORD_L(pPa_PaBuf->phHdBuf.btSoh) == SOH &&  // PAC <-> PAC ¿¡¼­ »óÅÂ
;     |  Á¤º¸¸¦ ÃßÃâÇÑ´Ù.                                                      
; 980 |             WORD_L(pPa_PaBuf->btEot) == EOT &&                         
; 981 |             sizeof(PAC_PAC) == nRxPos &&                               
; 982 |                 //(TWOBYTE_ASC2HEX(pPa_PaBuf->phHdBuf.chSrcDev) == PAC_
;     | DEV_NO) &&                                                             
; 983 |             //(TWOBYTE_ASC2HEX(pPa_PaBuf->phHdBuf.chDestDev) == PAC_DEV
;     | _NO) &&                                                                
; 985 |             ConvAsc2Hex(pPa_PaBuf->nCRC[0]) == BYTE_H(WORD_H(crc16_ccit
;     | t(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                        
; 986 |                 ConvAsc2Hex(pPa_PaBuf->nCRC[1]) == BYTE_L(WORD_H(crc16_
;     | ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                    
; 987 |                 ConvAsc2Hex(pPa_PaBuf->nCRC[2]) == BYTE_H(WORD_L(crc16_
;     | ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                    
; 988 |                 ConvAsc2Hex(pPa_PaBuf->nCRC[3]) == BYTE_L(WORD_L(crc16_
;     | ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))                      
; 989 |             )                                                          
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
        cmpi      1,r0
        bne       L262
;*      Branch Occurs to L262 
        ldiu      *+fp(ir0),ir0
        ldiu      267,ar0
        ldiu      255,r0
        and3      r0,*+ar0(ir0),r0
        cmpi      4,r0
        bne       L262
;*      Branch Occurs to L262 
        ldiu      268,r0
        cmpi      @_nRxPos$6+0,r0
        bne       L262
;*      Branch Occurs to L262 
        ldiu      1,r1
        ldiu      432,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      263,ar0
        ldiu      432,ir0
        ldiu      r0,r4
        subi      2,sp
        lsh       -8,r4
        ldiu      *+fp(ir0),ir0
        and       255,r4
        ldiu      *+ar0(ir0),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L262
;*      Branch Occurs to L262 
        ldiu      1,r1
        ldiu      432,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      264,ar0
        subi      2,sp
        ldiu      432,ir0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ir0
        ldiu      *+ar0(ir0),r0
        lsh       -8,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L262
;*      Branch Occurs to L262 
        ldiu      1,r1
        ldiu      432,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      432,ir0
        subi      2,sp
        ldiu      265,ar0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ir0
        and       255,r4
        ldiu      *+ar0(ir0),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L262
;*      Branch Occurs to L262 
        ldiu      1,r1
        ldiu      432,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$6+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      432,ir0
        subi      2,sp
        ldiu      266,ar0
        ldiu      *+fp(ir0),ir0
        ldiu      r0,r4
        ldiu      *+ar0(ir0),r0
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L262
;*      Branch Occurs to L262 
	.line	141
;----------------------------------------------------------------------
; 992 | m_Lic_to_PAC_Cnt++;                                                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Lic_to_PAC_Cnt+0,r0
        sti       r0,@_m_Lic_to_PAC_Cnt+0
	.line	144
;----------------------------------------------------------------------
; 995 | m_Variable.m_TrainCofVal_Chick = TWOBYTE_ASC2HEX(pPa_PaBuf->sCCI); ////
;     |  Â÷·® Áß·Ã »óÅÂ Á¤º¸¸¦ Àü´Þ.                                           
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(153),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      432,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(154),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        subi      1,sp
        sti       r0,@_m_Variable+277
	.line	147
;----------------------------------------------------------------------
; 998 | if(m_Variable.m_TrainCofVal_Chick == 0x10) //|| m_Variable.m_TrainCofVa
;     | l_Chick == 0x20)                                                       
;----------------------------------------------------------------------
        cmpi      16,r0
        bne       L225
;*      Branch Occurs to L225 
	.line	149
;----------------------------------------------------------------------
; 1000 | m_Variable.m_TrainCofVal_ing = FALSE;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+278
        bu        L227
;*      Branch Occurs to L227 
L225:        
	.line	151
;----------------------------------------------------------------------
; 1002 | else if(m_Variable.m_TrainCofVal_Chick) // Á¤»óÀûÀÎ °ªÀÌ µé¾î ¿À¸é, Áß·
;     | Ã ÁßÀ» ÇØÁ¦ ÇÑ´Ù.                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+277,r0
        beq       L227
;*      Branch Occurs to L227 
	.line	153
;----------------------------------------------------------------------
; 1004 | m_Variable.m_TrainCofVal_ing = TRUE;                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+278
L227:        
	.line	157
;----------------------------------------------------------------------
; 1008 | d_CarConfig_St = m_Variable.m_TrainCofVal_Chick;                       
;----------------------------------------------------------------------
        ldiu      @_m_Variable+277,r0
        sti       r0,@_d_CarConfig_St+0
	.line	159
;----------------------------------------------------------------------
; 1010 | m_Variable.m_btCiFaultVal = TWOBYTE_ASC2HEX(pPa_PaBuf->sCI_Fault); //CI
;     |  °íÀå Á¤º¸.                                                            
; 1013 | //### ÀÚ½ÅÀÇ À§Ä¡¸¦ Ã£¾Æ¼­ ÇØ´çÇÏ´Â ÀåÄ¡ »óÅÂ µ¥ÀÌÅ¸¸¦ ÃßÃâÇÑ´Ù.###    
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(151),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      432,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(152),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        subi      1,sp
        sti       r0,@_m_Variable+281
	.line	163
;----------------------------------------------------------------------
; 1014 | sCarPosionIndex = TWOBYTE_ASC2HEX(pPa_PaBuf->sCPI)-1;                  
; 1017 | //-----------------------------------------------------------------    
; 1018 | //CI Index Á¤º¸´Â CAB ½ÅÈ£°¡ ÀÖ°í, Index °ªÀÌ 0ÀÌ ¾Æ´Ï¸é ±× °ªÀ» »ç¿ëÇÑ
;     | ´Ù.                                                                    
; 1019 | //-----------------------------------------------------------------    
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(155),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(156),r1
        push      r1
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        subi      1,sp
        subi      1,r0                  ; Unsigned
        sti       r0,*+fp(3)
	.line	169
;----------------------------------------------------------------------
; 1020 | sCabKeyCheck |= MAKE_BYTE(ConvAsc2Hex(pPa_PaBuf->phCRA_Sta[0][0][0]),Co
;     | nvAsc2Hex(pPa_PaBuf->phCRA_Sta[0][0][1]));                             
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(157),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      432,ir0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(158),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        or        *+fp(4),r0
        sti       r0,*+fp(4)
	.line	170
;----------------------------------------------------------------------
; 1021 | sCabKeyCheck |= MAKE_BYTE(ConvAsc2Hex(pPa_PaBuf->phCRA_Sta[1][0][0]),Co
;     | nvAsc2Hex(pPa_PaBuf->phCRA_Sta[1][0][1]));                             
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(179),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      432,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(180),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        or        *+fp(4),r0
        sti       r0,*+fp(4)
	.line	171
;----------------------------------------------------------------------
; 1022 | sCabKeyCheck |= MAKE_BYTE(ConvAsc2Hex(pPa_PaBuf->phCRA_Sta[2][0][0]),Co
;     | nvAsc2Hex(pPa_PaBuf->phCRA_Sta[2][0][1]));                             
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(201),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(202),r1
        ash       4,r4
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        or        *+fp(4),r0
        sti       r0,*+fp(4)
	.line	172
;----------------------------------------------------------------------
; 1023 | sCabKeyCheck |= MAKE_BYTE(ConvAsc2Hex(pPa_PaBuf->phCRA_Sta[3][0][0]),Co
;     | nvAsc2Hex(pPa_PaBuf->phCRA_Sta[3][0][1]));                             
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(223),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      432,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(224),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        subi      1,sp
        or3       r4,r0,r0
        and       255,r0
        or        *+fp(4),r0
        sti       r0,*+fp(4)
	.line	175
;----------------------------------------------------------------------
; 1026 | sCabKeyCheck1 = MAKE_BYTE(ConvAsc2Hex(pPa_PaBuf->phCRA_Sta[sCarPosionIn
;     | dex][0][0]),ConvAsc2Hex(pPa_PaBuf->phCRA_Sta[sCarPosionIndex][0][1])); 
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(3),r0
        mpyi      22,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(157),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        subi      1,sp
        ldiu      *+fp(3),r0
        ash       4,r4
        ldiu      432,ir0
        mpyi      22,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(158),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(5)
	.line	178
;----------------------------------------------------------------------
; 1029 | sIndexValue_A = MAKE_BYTE(ConvAsc2Hex(pPa_PaBuf->sCI_Index[(sCarPosionI
;     | ndex*2)][0]),ConvAsc2Hex(pPa_PaBuf->sCI_Index[(sCarPosionIndex*2)][1]))
;     | ;                                                                      
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(3),r0
        mpyi      2,r0
        ash       1,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(135),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),r1
        mpyi      2,r1
        ldiu      r0,r4
        ldiu      432,ir0
        ash       4,r4
        ash       1,r1
        addi3     r1,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(136),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(6)
	.line	180
;----------------------------------------------------------------------
; 1031 | sIndexValue_B = MAKE_BYTE(ConvAsc2Hex(pPa_PaBuf->sCI_Index[(sCarPosionI
;     | ndex*2)+1][0]),ConvAsc2Hex(pPa_PaBuf->sCI_Index[(sCarPosionIndex*2)+1][
;     | 1]));                                                                  
; 1034 | //MyPrintf_TxAuto(&btTmpBuf[0], 11);                                   
; 1036 | //CAB Key °¡ ON µÇ¾î ÀÖ´ÂÁö È®ÀÎ ÇÑ´Ù.                                 
; 1037 | //Áß·ÃÁß(0x10) ¶Ç´Â Áß·Ã ½ÇÆÐ(0x20) °¡ ³ª¿À¸é Áß·Ã À§Ä¡ Á¤º¸¸¦ È®ÀÎ ÇÏÁ
;     | ö ¾Ê´Â´Ù.                                                              
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      2,r0
        addi      1,r0
        ldiu      432,ir0
        ash       1,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(135),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      r0,r4
        ldiu      432,ir0
        ldiu      *+fp(3),r1
        mpyi      2,r1
        addi      1,r1
        ash       4,r4
        ash       1,r1
        addi3     r1,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(136),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,*+fp(7)
	.line	187
;----------------------------------------------------------------------
; 1038 | if(((sCabKeyCheck&0x01) ||(sCabKeyCheck&0x10))&& m_Variable.m_TrainCofV
;     | al_ing)                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        tstb      *+fp(4),r0
        bne       L230
;*      Branch Occurs to L230 
        ldiu      16,r0
        tstb      *+fp(4),r0
        beq       L255
;*      Branch Occurs to L255 
L230:        
        ldi       @_m_Variable+278,r0
        beq       L255
;*      Branch Occurs to L255 
	.line	189
;----------------------------------------------------------------------
; 1040 | ddddd++;                                                               
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_ddddd+0,r0
        sti       r0,@_ddddd+0
	.line	191
;----------------------------------------------------------------------
; 1042 | m_Variable.m_TrainCofVal_Time_Flag = 0;                                
; 1044 | //ÀÚ½ÅÀÇ À§Ä¡¸¦ È®ÀÎ ÇÏ°í »óÅÂ °ªÀ» ÀÐ¾î ¿Â´Ù.                         
; 1045 | //Áß·Ã »óÅÂ Á¤º¸ È®ÀÎÀÌ ³¡³ª¸é »óÅÂ Á¤º¸¸¦ ¾÷µ¥ÀÌÆ® ÇÑ´Ù.              
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+276
	.line	196
;----------------------------------------------------------------------
; 1047 | if (m_Variable.m_ProStartFlag) // ÃÊ±âºÎÆÃ½Ã 3ºÐ (180,000ms)ÈÄ¿¡ µ¿ÀÛ Ç
;     | Ñ´Ù.                                                                   
;----------------------------------------------------------------------
        ldi       @_m_Variable+244,r0
        beq       L233
;*      Branch Occurs to L233 
	.line	198
;----------------------------------------------------------------------
; 1049 | FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[sCarPosionIndex][0][0], &bt
;     | TmpBuf[0], 22);                                                        
;----------------------------------------------------------------------
        ldiu      *+fp(3),r1
        ldiu      432,ir0
        ldiu      22,r0
        ldiu      fp,r2
        mpyi      22,r1
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        addi      157,r1                ; Unsigned
        push      r0
        addi      9,r2
        push      r2
        push      r1
        call      _FunConvAscHex
                                        ; Call Occurs
        subi      3,sp
	.line	199
;----------------------------------------------------------------------
; 1050 | USer_UnitState((CRA_STATION *)&btTmpBuf[0]);                           
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      9,r0
        push      r0
        call      _USer_UnitState
                                        ; Call Occurs
        subi      1,sp
L233:        
	.line	202
;----------------------------------------------------------------------
; 1053 | if(m_Variable.m_chCarKind =='A')                                       
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        cmpi      65,r0
        bne       L240
;*      Branch Occurs to L240 
	.line	205
;----------------------------------------------------------------------
; 1056 | if(sCabKeyCheck1&0x08)//A CAR °¡ Head Car ÀÏ°æ¿ì.                      
;----------------------------------------------------------------------
        ldiu      8,r0
        tstb      *+fp(5),r0
        beq       L237
;*      Branch Occurs to L237 
	.line	207
;----------------------------------------------------------------------
; 1058 | if(sIndexValue_A) // Index °ªÀÌ 0 ÀÌ»ó ÀÌ¸é »ç¿ë ÇÑ´Ù.                 
;----------------------------------------------------------------------
        ldi       *+fp(6),r0
        beq       L247
;*      Branch Occurs to L247 
	.line	209
;----------------------------------------------------------------------
; 1060 | m_Variable.m_nCarPos = sIndexValue_A;                                  
;----------------------------------------------------------------------
        ldiu      *+fp(6),r0
        sti       r0,@_m_Variable+279
        bu        L247
;*      Branch Occurs to L247 
L237:        
	.line	212
;----------------------------------------------------------------------
; 1063 | else if(sCabKeyCheck1&0x80)// B CAR °¡ Head Car ÀÏ°æ¿ì.                
;----------------------------------------------------------------------
        ldiu      128,r0
        tstb      *+fp(5),r0
        beq       L247
;*      Branch Occurs to L247 
	.line	214
;----------------------------------------------------------------------
; 1065 | if(sIndexValue_B) // Index °ªÀÌ 0 ÀÌ»ó ÀÌ¸é »ç¿ë ÇÑ´Ù.                 
;----------------------------------------------------------------------
        ldi       *+fp(7),r0
        beq       L247
;*      Branch Occurs to L247 
	.line	216
;----------------------------------------------------------------------
; 1067 | m_Variable.m_nCarPos = sIndexValue_B;                                  
;----------------------------------------------------------------------
        ldiu      *+fp(7),r0
        sti       r0,@_m_Variable+279
        bu        L247
;*      Branch Occurs to L247 
L240:        
	.line	221
;----------------------------------------------------------------------
; 1072 | else if((m_Variable.m_chCarKind =='B'))                                
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        cmpi      66,r0
        bne       L247
;*      Branch Occurs to L247 
	.line	224
;----------------------------------------------------------------------
; 1075 | if(sCabKeyCheck1&0x08)                                                 
;----------------------------------------------------------------------
        ldiu      8,r0
        tstb      *+fp(5),r0
        beq       L244
;*      Branch Occurs to L244 
	.line	226
;----------------------------------------------------------------------
; 1077 | if(sIndexValue_B) // Index °ªÀÌ 0 ÀÌ»ó ÀÌ¸é »ç¿ë ÇÑ´Ù.                 
;----------------------------------------------------------------------
        ldi       *+fp(7),r0
        beq       L247
;*      Branch Occurs to L247 
	.line	228
;----------------------------------------------------------------------
; 1079 | m_Variable.m_nCarPos = sIndexValue_B;                                  
;----------------------------------------------------------------------
        ldiu      *+fp(7),r0
        sti       r0,@_m_Variable+279
        bu        L247
;*      Branch Occurs to L247 
L244:        
	.line	231
;----------------------------------------------------------------------
; 1082 | else if(sCabKeyCheck1&0x80)                                            
;----------------------------------------------------------------------
        ldiu      128,r0
        tstb      *+fp(5),r0
        beq       L247
;*      Branch Occurs to L247 
	.line	233
;----------------------------------------------------------------------
; 1084 | if(sIndexValue_A) // Index °ªÀÌ 0 ÀÌ»ó ÀÌ¸é »ç¿ë ÇÑ´Ù.                 
;----------------------------------------------------------------------
        ldi       *+fp(6),r0
        beq       L247
;*      Branch Occurs to L247 
	.line	235
;----------------------------------------------------------------------
; 1086 | m_Variable.m_nCarPos = sIndexValue_A;                                  
;----------------------------------------------------------------------
        ldiu      *+fp(6),r0
        sti       r0,@_m_Variable+279
L247:        
	.line	241
;----------------------------------------------------------------------
; 1092 | if(m_Variable.m_TrainCofVal_Chick == 0x20)                             
;----------------------------------------------------------------------
        ldiu      @_m_Variable+277,r0
        cmpi      32,r0
        bne       L249
;*      Branch Occurs to L249 
	.line	242
;----------------------------------------------------------------------
; 1093 | {m_Variable.m_TrainCofVal = 1;}                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+275
        bu        L250
;*      Branch Occurs to L250 
L249:        
	.line	243
;----------------------------------------------------------------------
; 1094 | else{m_Variable.m_TrainCofVal = m_Variable.m_TrainCofVal_Chick;} // Â÷·
;     | ® Á¶¼º Á¤º¸¸¦ Àü´ÞÇÑ´Ù.}                                               
; 1096 | // cab Á¤º¸¸¦ È®ÀÎÇÏ°í, Â÷·® Á¤º¸¸¦ °»½ÅÇÑ´Ù.                          
;----------------------------------------------------------------------
        ldiu      @_m_Variable+277,r0
        sti       r0,@_m_Variable+275
L250:        
	.line	246
;----------------------------------------------------------------------
; 1097 | if(m_Variable.m_TrainCofVal)                                           
;----------------------------------------------------------------------
        ldi       @_m_Variable+275,r0
        beq       L261
;*      Branch Occurs to L261 
	.line	248
;----------------------------------------------------------------------
; 1099 | m_Variable.m_TrainCofVal =m_Variable.m_TrainCofVal - 1; // ¿ìÁø ÇÁ·ÎÅäÄ
;     | Ý °ªÀÌ 1 ´õ Å©´Ù.                                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     @_m_Variable+275,r0
        sti       r0,@_m_Variable+275
	.line	250
;----------------------------------------------------------------------
; 1101 | m_Variable.m_TrainCofVal = MIN(3,m_Variable.m_TrainCofVal);            
; 1105 | else                                                                   
; 1107 | // Áß·ÃÁß(0x10) ¶Ç´Â Áß·Ã ½ÇÆÐ(0x20) ÀÌ¸é, ´ÜÂ÷ ±âÁØÀ¸·Î Àû¿ëÇÑ´Ù.     
; 1108 | // CAB Key Á¤º¸°¡ ¾øÀ¸¸é 'A' Car ´Â  '1' / 'B' Car ´Â '2' ·Î Àü¼Û ÇÑ´Ù.
;----------------------------------------------------------------------
        ldiu      3,r0
        cmpi      @_m_Variable+275,r0
        bge       L253
;*      Branch Occurs to L253 
        bu        L254
;*      Branch Occurs to L254 
L253:        
        ldiu      @_m_Variable+275,r0
L254:        
        sti       r0,@_m_Variable+275
        bu        L261
;*      Branch Occurs to L261 
L255:        
	.line	258
;----------------------------------------------------------------------
; 1109 | m_Variable.m_TrainCofVal_Time_Flag++;                                  
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+276,r0
        sti       r0,@_m_Variable+276
	.line	260
;----------------------------------------------------------------------
; 1111 | if(m_Variable.m_TrainCofVal_Time_Flag > 15) // cab Å°°¡ 15ÃÊ µ¿¾È ºüÁö¸
;     | é ÃÊ±âÈ­ ÇÑ´Ù.                                                         
;----------------------------------------------------------------------
        cmpi      15,r0
        ble       L261
;*      Branch Occurs to L261 
	.line	263
;----------------------------------------------------------------------
; 1114 | if(m_Variable.m_chCarKind =='A')                                       
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        cmpi      65,r0
        bne       L258
;*      Branch Occurs to L258 
	.line	265
;----------------------------------------------------------------------
; 1116 | m_Variable.m_nCarPos = 1;                                              
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+279
        bu        L260
;*      Branch Occurs to L260 
L258:        
	.line	267
;----------------------------------------------------------------------
; 1118 | else if((m_Variable.m_chCarKind =='B'))                                
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        cmpi      66,r0
        bne       L260
;*      Branch Occurs to L260 
	.line	269
;----------------------------------------------------------------------
; 1120 | m_Variable.m_nCarPos = 2;                                              
;----------------------------------------------------------------------
        ldiu      2,r0
        sti       r0,@_m_Variable+279
L260:        
	.line	272
;----------------------------------------------------------------------
; 1123 | m_Variable.m_TrainCofVal = 0; // Â÷·® Á¶¼º Á¤º¸¸¦ 1Æí¼ºÀ¸·Î Àü´ÞÇÑ´Ù.  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+275
L261:        
	.line	276
;----------------------------------------------------------------------
; 1127 | d_CI_Index = m_Variable.m_nCarPos;                                     
;----------------------------------------------------------------------
        ldiu      @_m_Variable+279,r0
        sti       r0,@_d_CI_Index+0
	.line	277
;----------------------------------------------------------------------
; 1128 | d_CarNum = m_Variable.m_nCarNo;                                        
;----------------------------------------------------------------------
        ldiu      @_m_Variable+282,r0
        sti       r0,@_d_CarNum+0
	.line	278
;----------------------------------------------------------------------
; 1129 | d_CI_Fault = m_Variable.m_btCiFaultVal;                                
;----------------------------------------------------------------------
        ldiu      @_m_Variable+281,r0
        sti       r0,@_d_CI_Fault+0
	.line	289
;----------------------------------------------------------------------
; 1140 | d_CarConfig = m_Variable.m_TrainCofVal;                                
; 1147 | //MyPrintf("PAC--> PAC \r\n");                                         
; 1148 | //MyPrintf_TxAuto((UCHAR *)pPa_PaBuf,sizeof(PAC_PAC));                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+275,r0
        sti       r0,@_d_CarConfig+0
L262:        
	.line	304
;----------------------------------------------------------------------
; 1155 | nOldUart3RxOneByteGapDelayTime = m_Variable.m_nUart3RxOneByteGapDelayTi
;     | me;                                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+227,r0
        sti       r0,@_nOldUart3RxOneByteGapDelayTime$7+0
	.line	305
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      434,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	1156,000000010h,432



	.sect	".cinit"
	.field  	1,32
	.field  	_d_MDS_TX_Cnt_A+0,32
	.field  	0,32		; _d_MDS_TX_Cnt_A @ 0

	.sect	".text"

	.global	_d_MDS_TX_Cnt_A
	.bss	_d_MDS_TX_Cnt_A,1
	.sym	_d_MDS_TX_Cnt_A,_d_MDS_TX_Cnt_A,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_MDS_TX_Cnt_B+0,32
	.field  	0,32		; _d_MDS_TX_Cnt_B @ 0

	.sect	".text"

	.global	_d_MDS_TX_Cnt_B
	.bss	_d_MDS_TX_Cnt_B,1
	.sym	_d_MDS_TX_Cnt_B,_d_MDS_TX_Cnt_B,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_Cncs_commCnt1+0,32
	.field  	0,32		; _d_Cncs_commCnt1 @ 0

	.sect	".text"

	.global	_d_Cncs_commCnt1
	.bss	_d_Cncs_commCnt1,1
	.sym	_d_Cncs_commCnt1,_d_Cncs_commCnt1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_Cncs_commCnt2+0,32
	.field  	0,32		; _d_Cncs_commCnt2 @ 0

	.sect	".text"

	.global	_d_Cncs_commCnt2
	.bss	_d_Cncs_commCnt2,1
	.sym	_d_Cncs_commCnt2,_d_Cncs_commCnt2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_Cncs_commCnt3+0,32
	.field  	0,32		; _d_Cncs_commCnt3 @ 0

	.sect	".text"

	.global	_d_Cncs_commCnt3
	.bss	_d_Cncs_commCnt3,1
	.sym	_d_Cncs_commCnt3,_d_Cncs_commCnt3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_Cncs_commCnt4+0,32
	.field  	0,32		; _d_Cncs_commCnt4 @ 0

	.sect	".text"

	.global	_d_Cncs_commCnt4
	.bss	_d_Cncs_commCnt4,1
	.sym	_d_Cncs_commCnt4,_d_Cncs_commCnt4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_d_Cncs_commCnt5+0,32
	.field  	0,32		; _d_Cncs_commCnt5 @ 0

	.sect	".text"

	.global	_d_Cncs_commCnt5
	.bss	_d_Cncs_commCnt5,1
	.sym	_d_Cncs_commCnt5,_d_Cncs_commCnt5,4,2,32
	.sect	 ".text"

	.global	_USer_UnitState
	.sym	_USer_UnitState,_USer_UnitState,32,2,0
	.func	1173
;******************************************************************************
;* FUNCTION NAME: _USer_UnitState                                             *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,ar1,fp,sp,st,rs,re,rc                  *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_USer_UnitState:
	.sym	_pCarState,-2,24,9,32,.fake14
	.sym	_pCommStatus_Lic,1,24,1,32,.fake57
	.line	1
;----------------------------------------------------------------------
; 1173 | void USer_UnitState(PCRA_STATION pCarState)                            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
;----------------------------------------------------------------------
; 1175 | PCOMMSTATUS_LIC pCommStatus_Lic;                                       
;----------------------------------------------------------------------
	.line	5
;----------------------------------------------------------------------
; 1177 | memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt));      
;----------------------------------------------------------------------
        ldiu      8,r2
        ldiu      0,r0
        ldiu      @CL3,r1
        push      r2
        push      r0
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	7
;----------------------------------------------------------------------
; 1179 | pCommStatus_Lic = (COMMSTATUS_LIC *)m_Variable.m_btCommSt;             
;----------------------------------------------------------------------
        ldiu      @CL3,r0
        sti       r0,*+fp(1)
	.line	9
;----------------------------------------------------------------------
; 1181 | memcpy(&d_ErrorBuf[0], &m_MDS_ErrCnt.nCcp_0, sizeof(m_MDS_ErrCnt));    
;----------------------------------------------------------------------
        ldiu      @CL75,ar1
        ldiu      @CL8,ar0
        ldiu      *ar0++(1),r0
        rpts      22                    ; Fast MEMCPY(#3)
        sti       r0,*ar1++(1)
||      ldi       *ar0++(1),r0
        sti       r0,*ar1++(1)
	.line	11
;----------------------------------------------------------------------
; 1183 | if(m_Variable.m_chCarKind == 'A')                                      
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        cmpi      65,r0
        bne       L368
;*      Branch Occurs to L368 
	.line	14
;----------------------------------------------------------------------
; 1186 | d_MDS_TX_Cnt_A++;                                                      
; 1187 | //CCP °íÀå Ä«¿îÅÍ 100È¸                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_MDS_TX_Cnt_A+0,r0
        sti       r0,@_d_MDS_TX_Cnt_A+0
	.line	16
;----------------------------------------------------------------------
; 1188 | m_MDS_ErrCnt.nCcp_0 = (pCarState->CRA_2.BIT.sACCP1) ? m_MDS_ErrCnt.nCcp
;     | _0 + 1 : 0;                                                            
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      8,r0
        tstb      *+ar0(1),r0
        beq       L268
;*      Branch Occurs to L268 
        bud       L269
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+0,r0   ; Unsigned
;*      Branch Occurs to L269 
L268:        
        ldiu      0,r0
L269:        
        sti       r0,@_m_MDS_ErrCnt+0
	.line	17
;----------------------------------------------------------------------
; 1189 | pCommStatus_Lic->BYTE_1.BIT.nCcp = (m_MDS_ErrCnt.nCcp_0 >= 100) ? 1 : 0
;     | ;                                                                      
; 1191 | //VTX °íÀå Ä«¿îÅÍ 100È¸                                                
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L271
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L271 
        ldiu      1,r0
L271:        
        ldiu      *ar0,r1
        and       1,r0
        andn      1,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	20
;----------------------------------------------------------------------
; 1192 | m_MDS_ErrCnt.nVtx_2 = (pCarState->CRA_3.BIT.sAVTX) ? m_MDS_ErrCnt.nVtx_
;     | 2 + 1 : 0;                                                             
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      2,r0
        tstb      *+ar0(2),r0
        beq       L273
;*      Branch Occurs to L273 
        bud       L274
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+2,r0   ; Unsigned
;*      Branch Occurs to L274 
L273:        
        ldiu      0,r0
L274:        
        sti       r0,@_m_MDS_ErrCnt+2
	.line	21
;----------------------------------------------------------------------
; 1193 | pCommStatus_Lic->BYTE_1.BIT.nVtx = (m_MDS_ErrCnt.nVtx_2 >= 100) ? 1 : 0
;     | ;                                                                      
; 1196 | //Voip °íÀå Ä«¿îÅÍ 100È¸                                               
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L276
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L276 
        ldiu      1,r0
L276:        
        ldiu      *ar0,r1
        and       1,r0
        andn      4,r1
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	25
;----------------------------------------------------------------------
; 1197 | m_MDS_ErrCnt.nVoip_3 = (pCarState->CRA_2.BIT.sAVOIP) ? m_MDS_ErrCnt.nVo
;     | ip_3 + 1 : 0;                                                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      4,r0
        tstb      *+ar0(1),r0
        beq       L278
;*      Branch Occurs to L278 
        bud       L279
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+3,r0   ; Unsigned
;*      Branch Occurs to L279 
L278:        
        ldiu      0,r0
L279:        
        sti       r0,@_m_MDS_ErrCnt+3
	.line	26
;----------------------------------------------------------------------
; 1198 | pCommStatus_Lic->BYTE_1.BIT.nVoip = (m_MDS_ErrCnt.nVoip_3 >= 100) ? 1 :
;     |  0 ;                                                                   
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L281
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L281 
        ldiu      1,r0
L281:        
        ldiu      *ar0,r1
        and       1,r0
        andn      8,r1
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	28
;----------------------------------------------------------------------
; 1200 | m_MDS_ErrCnt.nPac_4 = (pCarState->CRA_3.BIT.sAPAC) ? m_MDS_ErrCnt.nPac_
;     | 4 + 1 : 0;                                                             
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      8,r0
        tstb      *+ar0(2),r0
        beq       L283
;*      Branch Occurs to L283 
        bud       L284
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+4,r0   ; Unsigned
;*      Branch Occurs to L284 
L283:        
        ldiu      0,r0
L284:        
        sti       r0,@_m_MDS_ErrCnt+4
	.line	29
;----------------------------------------------------------------------
; 1201 | pCommStatus_Lic->BYTE_1.BIT.nPac = (m_MDS_ErrCnt.nPac_4 >= 200) ? 1 : 0
;     | ;                                                                      
;----------------------------------------------------------------------
        cmpi      200,r0
        blod      L286
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L286 
        ldiu      1,r0
L286:        
        ldiu      *ar0,r1
        and       1,r0
        andn      16,r1
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	47
;----------------------------------------------------------------------
; 1219 | pCommStatus_Lic->BYTE_1.BIT.nLic = 0; // LIC_MÀº Ç×»ó ÂüÀ¸·Î ÇÑ´Ù.     
; 1222 | //FDI                                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *ar0,r0
        andn      32,r0
        sti       r0,*ar0
	.line	51
;----------------------------------------------------------------------
; 1223 | m_MDS_ErrCnt.nFdi_6 = (pCarState->CRA_4.BIT.sAFDI) ? (m_MDS_ErrCnt.nFdi
;     | _6 + 1) : 0;                                                           
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      4,r0
        tstb      *+ar0(3),r0
        beq       L288
;*      Branch Occurs to L288 
        bud       L289
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+6,r0   ; Unsigned
;*      Branch Occurs to L289 
L288:        
        ldiu      0,r0
L289:        
        sti       r0,@_m_MDS_ErrCnt+6
	.line	52
;----------------------------------------------------------------------
; 1224 | pCommStatus_Lic->BYTE_1.BIT.nFdi = (m_MDS_ErrCnt.nFdi_6 >= 100) ? 1 : 0
;     | ;                                                                      
; 1226 | //SDI                                                                  
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L291
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L291 
        ldiu      1,r0
L291:        
        ldiu      *ar0,r1
        and       1,r0
        andn      64,r1
        ash       6,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	55
;----------------------------------------------------------------------
; 1227 | m_MDS_ErrCnt.nSdi1_7 = (pCarState->CRA_5.BIT.sASDI1) ? (m_MDS_ErrCnt.nS
;     | di1_7 + 1) : 0;                                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      8,r0
        tstb      *+ar0(4),r0
        beq       L293
;*      Branch Occurs to L293 
        bud       L294
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+7,r0   ; Unsigned
;*      Branch Occurs to L294 
L293:        
        ldiu      0,r0
L294:        
        sti       r0,@_m_MDS_ErrCnt+7
	.line	56
;----------------------------------------------------------------------
; 1228 | pCommStatus_Lic->BYTE_1.BIT.nSdi1 = (m_MDS_ErrCnt.nSdi1_7 >= 100) ? 1 :
;     |  0;                                                                    
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L296
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L296 
        ldiu      1,r0
L296:        
        ldiu      *ar0,r1
        and       1,r0
        andn      128,r1
        ash       7,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	58
;----------------------------------------------------------------------
; 1230 | m_MDS_ErrCnt.nSdi2_8 = (pCarState->CRA_5.BIT.sASDI2) ? (m_MDS_ErrCnt.nS
;     | di2_8 + 1) : 0;                                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      4,r0
        tstb      *+ar0(4),r0
        beq       L298
;*      Branch Occurs to L298 
        bud       L299
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+8,r0   ; Unsigned
;*      Branch Occurs to L299 
L298:        
        ldiu      0,r0
L299:        
        sti       r0,@_m_MDS_ErrCnt+8
	.line	59
;----------------------------------------------------------------------
; 1231 | pCommStatus_Lic->BYTE_2.BIT.nSdi2 = (m_MDS_ErrCnt.nSdi2_8 >= 100) ? 1 :
;     |  0;                                                                    
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L301
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L301 
        ldiu      1,r0
L301:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      1,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	61
;----------------------------------------------------------------------
; 1233 | m_MDS_ErrCnt.nSdi3_9 = (pCarState->CRA_5.BIT.sASDI3) ? (m_MDS_ErrCnt.nS
;     | di3_9 + 1) : 0;                                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      2,r0
        tstb      *+ar0(4),r0
        beq       L303
;*      Branch Occurs to L303 
        bud       L304
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+9,r0   ; Unsigned
;*      Branch Occurs to L304 
L303:        
        ldiu      0,r0
L304:        
        sti       r0,@_m_MDS_ErrCnt+9
	.line	62
;----------------------------------------------------------------------
; 1234 | pCommStatus_Lic->BYTE_2.BIT.nSdi3 = (m_MDS_ErrCnt.nSdi3_9 >= 100) ? 1 :
;     |  0;                                                                    
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L306
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L306 
        ldiu      1,r0
L306:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      2,r1
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	64
;----------------------------------------------------------------------
; 1236 | m_MDS_ErrCnt.nSdi4_10 = (pCarState->CRA_5.BIT.sASDI4) ? (m_MDS_ErrCnt.n
;     | Sdi4_10 + 1) : 0;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      1,r0
        tstb      *+ar0(4),r0
        beq       L308
;*      Branch Occurs to L308 
        bud       L309
	nop
	nop
        addi      @_m_MDS_ErrCnt+10,r0  ; Unsigned
;*      Branch Occurs to L309 
L308:        
        ldiu      0,r0
L309:        
        sti       r0,@_m_MDS_ErrCnt+10
	.line	65
;----------------------------------------------------------------------
; 1237 | pCommStatus_Lic->BYTE_2.BIT.nSdi4 = (m_MDS_ErrCnt.nSdi4_10 >= 100) ? 1
;     | : 0;                                                                   
; 1239 | // PII                                                                 
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L311
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L311 
        ldiu      1,r0
L311:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      4,r1
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	68
;----------------------------------------------------------------------
; 1240 | m_MDS_ErrCnt.nPii1_11 = (pCarState->CRA_4.BIT.sAPII1) ? (m_MDS_ErrCnt.n
;     | Pii1_11 + 1) : 0;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      2,r0
        tstb      *+ar0(3),r0
        beq       L313
;*      Branch Occurs to L313 
        bud       L314
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+11,r0  ; Unsigned
;*      Branch Occurs to L314 
L313:        
        ldiu      0,r0
L314:        
        sti       r0,@_m_MDS_ErrCnt+11
	.line	69
;----------------------------------------------------------------------
; 1241 | pCommStatus_Lic->BYTE_2.BIT.nPii1 = (m_MDS_ErrCnt.nPii1_11 >= 100) ? 1
;     | : 0;                                                                   
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L316
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L316 
        ldiu      1,r0
L316:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      8,r1
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	71
;----------------------------------------------------------------------
; 1243 | m_MDS_ErrCnt.nPii2_12 = (pCarState->CRA_4.BIT.sAPII2) ? (m_MDS_ErrCnt.n
;     | Pii2_12 + 1) : 0;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      1,r0
        tstb      *+ar0(3),r0
        beq       L318
;*      Branch Occurs to L318 
        bud       L319
	nop
	nop
        addi      @_m_MDS_ErrCnt+12,r0  ; Unsigned
;*      Branch Occurs to L319 
L318:        
        ldiu      0,r0
L319:        
        sti       r0,@_m_MDS_ErrCnt+12
	.line	72
;----------------------------------------------------------------------
; 1244 | pCommStatus_Lic->BYTE_2.BIT.nPii2 = (m_MDS_ErrCnt.nPii2_12 >= 100) ? 1
;     | : 0;                                                                   
; 1246 | // PID1                                                                
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L321
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L321 
        ldiu      1,r0
L321:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      16,r1
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	75
;----------------------------------------------------------------------
; 1247 | m_MDS_ErrCnt.nPid1_1_13 = (pCarState->CRA_6.BIT.sAPID1_1) ? (m_MDS_ErrC
;     | nt.nPid1_1_13 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      8,r0
        tstb      *+ar0(5),r0
        beq       L323
;*      Branch Occurs to L323 
        bud       L324
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+13,r0  ; Unsigned
;*      Branch Occurs to L324 
L323:        
        ldiu      0,r0
L324:        
        sti       r0,@_m_MDS_ErrCnt+13
	.line	76
;----------------------------------------------------------------------
; 1248 | pCommStatus_Lic->BYTE_2.BIT.nPid1_1 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L326
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L326 
        ldiu      1,r0
L326:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      32,r1
        ash       5,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	78
;----------------------------------------------------------------------
; 1250 | m_MDS_ErrCnt.nPid1_2_14 = (pCarState->CRA_6.BIT.sAPID1_2) ? (m_MDS_ErrC
;     | nt.nPid1_2_14 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      4,r0
        tstb      *+ar0(5),r0
        beq       L328
;*      Branch Occurs to L328 
        bud       L329
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+14,r0  ; Unsigned
;*      Branch Occurs to L329 
L328:        
        ldiu      0,r0
L329:        
        sti       r0,@_m_MDS_ErrCnt+14
	.line	79
;----------------------------------------------------------------------
; 1251 | pCommStatus_Lic->BYTE_2.BIT.nPid1_2 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        ldiu      @_m_MDS_ErrCnt+13,r0
        cmpi      100,r0
        blod      L331
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L331 
        ldiu      1,r0
L331:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      64,r1
        ash       6,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	81
;----------------------------------------------------------------------
; 1253 | m_MDS_ErrCnt.nPid1_3_15 = (pCarState->CRA_6.BIT.sAPID1_3) ? (m_MDS_ErrC
;     | nt.nPid1_3_15 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      2,r0
        tstb      *+ar0(5),r0
        beq       L333
;*      Branch Occurs to L333 
        bud       L334
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+15,r0  ; Unsigned
;*      Branch Occurs to L334 
L333:        
        ldiu      0,r0
L334:        
        sti       r0,@_m_MDS_ErrCnt+15
	.line	82
;----------------------------------------------------------------------
; 1254 | pCommStatus_Lic->BYTE_2.BIT.nPid1_3 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        ldiu      @_m_MDS_ErrCnt+13,r0
        cmpi      100,r0
        blod      L336
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L336 
        ldiu      1,r0
L336:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      128,r1
        ash       7,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	84
;----------------------------------------------------------------------
; 1256 | m_MDS_ErrCnt.nPid1_4_16 = (pCarState->CRA_6.BIT.sAPID1_4) ? (m_MDS_ErrC
;     | nt.nPid1_4_16 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      1,r0
        tstb      *+ar0(5),r0
        beq       L338
;*      Branch Occurs to L338 
        bud       L339
	nop
	nop
        addi      @_m_MDS_ErrCnt+16,r0  ; Unsigned
;*      Branch Occurs to L339 
L338:        
        ldiu      0,r0
L339:        
        sti       r0,@_m_MDS_ErrCnt+16
	.line	85
;----------------------------------------------------------------------
; 1257 | pCommStatus_Lic->BYTE_3.BIT.nPid1_4 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
; 1260 | // PID2                                                                
;----------------------------------------------------------------------
        ldiu      @_m_MDS_ErrCnt+13,r0
        cmpi      100,r0
        blod      L341
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L341 
        ldiu      1,r0
L341:        
        ldiu      *+ar0(2),r1
        and       1,r0
        andn      1,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	89
;----------------------------------------------------------------------
; 1261 | m_MDS_ErrCnt.nPid2_1_17 = (pCarState->CRA_7.BIT.sAPID2_1) ? (m_MDS_ErrC
;     | nt.nPid2_1_17 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      8,r0
        tstb      *+ar0(6),r0
        beq       L343
;*      Branch Occurs to L343 
        bud       L344
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+17,r0  ; Unsigned
;*      Branch Occurs to L344 
L343:        
        ldiu      0,r0
L344:        
        sti       r0,@_m_MDS_ErrCnt+17
	.line	90
;----------------------------------------------------------------------
; 1262 | pCommStatus_Lic->BYTE_3.BIT.nPid2_1 = (m_MDS_ErrCnt.nPid2_1_17 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L346
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L346 
        ldiu      1,r0
L346:        
        ldiu      *+ar0(2),r1
        and       1,r0
        andn      2,r1
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	94
;----------------------------------------------------------------------
; 1266 | if (m_Variable.m_LIC_CNCS_TimSetFlag) // CNCS Åë½ÅÀ» ÇÑ¹øÀÌ¶óµµ Çß´Ù¸é.
;----------------------------------------------------------------------
        ldi       @_m_Variable+356,r0
        beq       L362
;*      Branch Occurs to L362 
	.line	96
;----------------------------------------------------------------------
; 1268 | d_Cncs_commCnt1++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt1+0,r0
        sti       r0,@_d_Cncs_commCnt1+0
	.line	98
;----------------------------------------------------------------------
; 1270 | if (m_Variable.m_nCncsRxCheck1msTimer) // 1ºÐ 30ÃÊ µ¿¾ÈÀº ÂüÀ¸·Î ±â·ÏÇÑ
;     | ´Ù.                                                                    
;----------------------------------------------------------------------
        ldi       @_m_Variable+358,r0
        beq       L349
;*      Branch Occurs to L349 
	.line	101
;----------------------------------------------------------------------
; 1273 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	102
;----------------------------------------------------------------------
; 1274 | d_Cncs_commCnt2++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt2+0,r0
        sti       r0,@_d_Cncs_commCnt2+0
	.line	104
;----------------------------------------------------------------------
; 1276 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
; 1278 | else                                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
L349:        
	.line	108
;----------------------------------------------------------------------
; 1280 | if(m_Variable.m_tmUtcTime.hour = 7 && m_Variable.m_tmUtcTime.minute > 5
;     | 5)                                                                     
;----------------------------------------------------------------------
        ldiu      @_m_Variable+238,r1
        cmpi      55,r1
        ldiu      0,r0
        ldihi     1,r0
        cmpi      0,r0
        beqd      L351
        sti       r0,@_m_Variable+239
	nop
        ldine     *+fp(1),ar0
;*      Branch Occurs to L351 
	.line	110
;----------------------------------------------------------------------
; 1282 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	111
;----------------------------------------------------------------------
; 1283 | d_Cncs_commCnt3++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt3+0,r0
        sti       r0,@_d_Cncs_commCnt3+0
	.line	112
;----------------------------------------------------------------------
; 1284 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
L351:        
	.line	114
;----------------------------------------------------------------------
; 1286 | else if (m_Variable.m_tmUtcTime.hour = 8)                              
;----------------------------------------------------------------------
        ldi       8,r0
        beqd      L354
        sti       r0,@_m_Variable+239
	nop
        ldieq     @_m_Variable+238,r1
;*      Branch Occurs to L354 
	.line	116
;----------------------------------------------------------------------
; 1288 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	117
;----------------------------------------------------------------------
; 1289 | d_Cncs_commCnt3++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt3+0,r0
        sti       r0,@_d_Cncs_commCnt3+0
	.line	118
;----------------------------------------------------------------------
; 1290 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
	.line	120
;----------------------------------------------------------------------
; 1292 | else if (m_Variable.m_tmUtcTime.hour = 9 && m_Variable.m_tmUtcTime.minu
;     | te < 30)                                                               
;----------------------------------------------------------------------
L354:        
        cmpi      30,r1
        ldiu      0,r0
        ldilo     1,r0
        cmpi      0,r0
        beqd      L356
        sti       r0,@_m_Variable+239
	nop
        ldine     *+fp(1),ar0
;*      Branch Occurs to L356 
	.line	122
;----------------------------------------------------------------------
; 1294 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	123
;----------------------------------------------------------------------
; 1295 | d_Cncs_commCnt4++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt4+0,r0
        sti       r0,@_d_Cncs_commCnt4+0
	.line	124
;----------------------------------------------------------------------
; 1296 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
; 1299 | else                                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
L356:        
	.line	129
;----------------------------------------------------------------------
; 1301 | m_MDS_ErrCnt.nCncs_18 = (pCarState->CRA_3.BIT.sACNCS) ? (m_MDS_ErrCnt.n
;     | Cncs_18 + 1) : 1;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      1,r0
        tstb      *+ar0(2),r0
        beq       L358
;*      Branch Occurs to L358 
        bud       L359
	nop
	nop
        addi      @_m_MDS_ErrCnt+18,r0  ; Unsigned
;*      Branch Occurs to L359 
L358:        
        ldiu      1,r0
L359:        
        sti       r0,@_m_MDS_ErrCnt+18
	.line	130
;----------------------------------------------------------------------
; 1302 | pCommStatus_Lic->BYTE_3.BIT.nCncs = (m_MDS_ErrCnt.nCncs_18 >= 100) ? 1
;     | : 0;                                                                   
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L361
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L361 
        ldiu      1,r0
L361:        
        ldiu      *+ar0(2),r1
        and       1,r0
        andn      4,r1
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	131
;----------------------------------------------------------------------
; 1303 | d_Cncs_commCnt5++;                                                     
; 1308 | else                                                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt5+0,r0
        sti       r0,@_d_Cncs_commCnt5+0
        bu        L471
;*      Branch Occurs to L471 
L362:        
	.line	138
;----------------------------------------------------------------------
; 1310 | m_MDS_ErrCnt.nCncs_18 = (pCarState->CRA_3.BIT.sACNCS) ? (m_MDS_ErrCnt.n
;     | Cncs_18 + 1) : 1;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      1,r0
        tstb      *+ar0(2),r0
        beq       L364
;*      Branch Occurs to L364 
        bud       L365
	nop
	nop
        addi      @_m_MDS_ErrCnt+18,r0  ; Unsigned
;*      Branch Occurs to L365 
L364:        
        ldiu      1,r0
L365:        
        sti       r0,@_m_MDS_ErrCnt+18
	.line	139
;----------------------------------------------------------------------
; 1311 | pCommStatus_Lic->BYTE_3.BIT.nCncs = (m_MDS_ErrCnt.nCncs_18 >= 100) ? 1
;     | : 0;                                                                   
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L367
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L367 
        ldiu      1,r0
L367:        
        ldiu      *+ar0(2),r1
        and       1,r0
        andn      4,r1
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	140
;----------------------------------------------------------------------
; 1312 | d_Cncs_commCnt5++;                                                     
; 1315 | //MyPrintf("LIC -> MDS (Unit State) : %02X ,%02X,%02X\r\n ",pCommStatus
;     | _Lic->BYTE_1.BYTE,pCommStatus_Lic->BYTE_2.BYTE,pCommStatus_Lic->BYTE_3.
;     | BYTE);                                                                 
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt5+0,r0
        sti       r0,@_d_Cncs_commCnt5+0
        bu        L471
;*      Branch Occurs to L471 
L368:        
	.line	146
;----------------------------------------------------------------------
; 1318 | else if(m_Variable.m_chCarKind == 'B') //ÇÁ·ÎÅäÄÝ¿¡´Â MA ¿­Â÷ ¹øÈ£¸¸ ÀÖ
;     | À¸¹Ç·Î MB´Â ½º½º·Î ÀÎ½Ä ÇØ¾ß ÇÑ´Ù.                                     
;----------------------------------------------------------------------
        ldiu      @_m_Variable+284,r0
        cmpi      66,r0
        bne       L471
;*      Branch Occurs to L471 
	.line	149
;----------------------------------------------------------------------
; 1321 | d_MDS_TX_Cnt_B++;                                                      
; 1323 | //CCP °íÀå Ä«¿îÅÍ 100È¸                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_MDS_TX_Cnt_B+0,r0
        sti       r0,@_d_MDS_TX_Cnt_B+0
	.line	152
;----------------------------------------------------------------------
; 1324 | m_MDS_ErrCnt.nCcp_0 = (pCarState->CRA_2.BIT.sBCCP1) ? m_MDS_ErrCnt.nCcp
;     | _0 + 1 : 0;                                                            
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      128,r0
        tstb      *+ar0(1),r0
        beq       L371
;*      Branch Occurs to L371 
        bud       L372
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+0,r0   ; Unsigned
;*      Branch Occurs to L372 
L371:        
        ldiu      0,r0
L372:        
        sti       r0,@_m_MDS_ErrCnt+0
	.line	153
;----------------------------------------------------------------------
; 1325 | pCommStatus_Lic->BYTE_1.BIT.nCcp = (m_MDS_ErrCnt.nCcp_0 >= 100) ? 1 : 0
;     | ;                                                                      
; 1327 | //VTX °íÀå Ä«¿îÅÍ 100È¸                                                
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L374
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L374 
        ldiu      1,r0
L374:        
        ldiu      *ar0,r1
        and       1,r0
        andn      1,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	156
;----------------------------------------------------------------------
; 1328 | m_MDS_ErrCnt.nVtx_2 = (pCarState->CRA_3.BIT.sBVTX) ? m_MDS_ErrCnt.nVtx_
;     | 2 + 1 : 0;                                                             
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      32,r0
        tstb      *+ar0(2),r0
        beq       L376
;*      Branch Occurs to L376 
        bud       L377
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+2,r0   ; Unsigned
;*      Branch Occurs to L377 
L376:        
        ldiu      0,r0
L377:        
        sti       r0,@_m_MDS_ErrCnt+2
	.line	157
;----------------------------------------------------------------------
; 1329 | pCommStatus_Lic->BYTE_1.BIT.nVtx = (m_MDS_ErrCnt.nVtx_2 >= 100) ? 1 : 0
;     | ;                                                                      
; 1332 | //Voip °íÀå Ä«¿îÅÍ 100È¸                                               
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L379
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L379 
        ldiu      1,r0
L379:        
        ldiu      *ar0,r1
        and       1,r0
        andn      4,r1
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	161
;----------------------------------------------------------------------
; 1333 | m_MDS_ErrCnt.nVoip_3 = (pCarState->CRA_2.BIT.sBVOIP) ? m_MDS_ErrCnt.nVo
;     | ip_3 + 1 : 0;                                                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      64,r0
        tstb      *+ar0(1),r0
        beq       L381
;*      Branch Occurs to L381 
        bud       L382
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+3,r0   ; Unsigned
;*      Branch Occurs to L382 
L381:        
        ldiu      0,r0
L382:        
        sti       r0,@_m_MDS_ErrCnt+3
	.line	162
;----------------------------------------------------------------------
; 1334 | pCommStatus_Lic->BYTE_1.BIT.nVoip = (m_MDS_ErrCnt.nVoip_3 >= 100) ? 1 :
;     |  0;                                                                    
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L384
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L384 
        ldiu      1,r0
L384:        
        ldiu      *ar0,r1
        and       1,r0
        andn      8,r1
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	164
;----------------------------------------------------------------------
; 1336 | m_MDS_ErrCnt.nPac_4 = (pCarState->CRA_3.BIT.sBPAC) ? m_MDS_ErrCnt.nPac_
;     | 4 + 1 : 0;                                                             
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      128,r0
        tstb      *+ar0(2),r0
        beq       L386
;*      Branch Occurs to L386 
        bud       L387
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+4,r0   ; Unsigned
;*      Branch Occurs to L387 
L386:        
        ldiu      0,r0
L387:        
        sti       r0,@_m_MDS_ErrCnt+4
	.line	165
;----------------------------------------------------------------------
; 1337 | pCommStatus_Lic->BYTE_1.BIT.nPac = (m_MDS_ErrCnt.nPac_4 >= 200) ? 1 : 0
;     | ;                                                                      
;----------------------------------------------------------------------
        cmpi      200,r0
        blod      L389
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L389 
        ldiu      1,r0
L389:        
        ldiu      *ar0,r1
        and       1,r0
        andn      16,r1
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	181
;----------------------------------------------------------------------
; 1353 | pCommStatus_Lic->BYTE_1.BIT.nLic = 0; // LIC_MÀº Ç×»ó ÂüÀ¸·Î ÇÑ´Ù.     
; 1356 | //FDI                                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *ar0,r0
        andn      32,r0
        sti       r0,*ar0
	.line	185
;----------------------------------------------------------------------
; 1357 | m_MDS_ErrCnt.nFdi_6 = (pCarState->CRA_4.BIT.sBFDI) ? (m_MDS_ErrCnt.nFdi
;     | _6 + 1) : 0;                                                           
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      64,r0
        tstb      *+ar0(3),r0
        beq       L391
;*      Branch Occurs to L391 
        bud       L392
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+6,r0   ; Unsigned
;*      Branch Occurs to L392 
L391:        
        ldiu      0,r0
L392:        
        sti       r0,@_m_MDS_ErrCnt+6
	.line	186
;----------------------------------------------------------------------
; 1358 | pCommStatus_Lic->BYTE_1.BIT.nFdi = (m_MDS_ErrCnt.nFdi_6 >= 100) ? 1 : 0
;     | ;                                                                      
; 1360 | //SDI                                                                  
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L394
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L394 
        ldiu      1,r0
L394:        
        ldiu      *ar0,r1
        and       1,r0
        andn      64,r1
        ash       6,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	189
;----------------------------------------------------------------------
; 1361 | m_MDS_ErrCnt.nSdi1_7 = (pCarState->CRA_5.BIT.sBSDI1) ? (m_MDS_ErrCnt.nS
;     | di1_7 + 1) : 0;                                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      128,r0
        tstb      *+ar0(4),r0
        beq       L396
;*      Branch Occurs to L396 
        bud       L397
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+7,r0   ; Unsigned
;*      Branch Occurs to L397 
L396:        
        ldiu      0,r0
L397:        
        sti       r0,@_m_MDS_ErrCnt+7
	.line	190
;----------------------------------------------------------------------
; 1362 | pCommStatus_Lic->BYTE_1.BIT.nSdi1 = (m_MDS_ErrCnt.nSdi1_7 >= 100) ? 1 :
;     |  0;                                                                    
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L399
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L399 
        ldiu      1,r0
L399:        
        ldiu      *ar0,r1
        and       1,r0
        andn      128,r1
        ash       7,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	192
;----------------------------------------------------------------------
; 1364 | m_MDS_ErrCnt.nSdi2_8 = (pCarState->CRA_5.BIT.sBSDI2) ? (m_MDS_ErrCnt.nS
;     | di2_8 + 1) : 0;                                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      64,r0
        tstb      *+ar0(4),r0
        beq       L401
;*      Branch Occurs to L401 
        bud       L402
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+8,r0   ; Unsigned
;*      Branch Occurs to L402 
L401:        
        ldiu      0,r0
L402:        
        sti       r0,@_m_MDS_ErrCnt+8
	.line	193
;----------------------------------------------------------------------
; 1365 | pCommStatus_Lic->BYTE_2.BIT.nSdi2 = (m_MDS_ErrCnt.nSdi2_8 >= 100) ? 1 :
;     |  0;                                                                    
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L404
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L404 
        ldiu      1,r0
L404:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      1,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	195
;----------------------------------------------------------------------
; 1367 | m_MDS_ErrCnt.nSdi3_9 = (pCarState->CRA_5.BIT.sBSDI3) ? (m_MDS_ErrCnt.nS
;     | di3_9 + 1) : 0;                                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      32,r0
        tstb      *+ar0(4),r0
        beq       L406
;*      Branch Occurs to L406 
        bud       L407
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+9,r0   ; Unsigned
;*      Branch Occurs to L407 
L406:        
        ldiu      0,r0
L407:        
        sti       r0,@_m_MDS_ErrCnt+9
	.line	196
;----------------------------------------------------------------------
; 1368 | pCommStatus_Lic->BYTE_2.BIT.nSdi3 = (m_MDS_ErrCnt.nSdi3_9 >= 100) ? 1 :
;     |  0;                                                                    
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L409
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L409 
        ldiu      1,r0
L409:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      2,r1
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	198
;----------------------------------------------------------------------
; 1370 | m_MDS_ErrCnt.nSdi4_10 = (pCarState->CRA_5.BIT.sBSDI4) ? (m_MDS_ErrCnt.n
;     | Sdi4_10 + 1) : 0;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      16,r0
        tstb      *+ar0(4),r0
        beq       L411
;*      Branch Occurs to L411 
        bud       L412
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+10,r0  ; Unsigned
;*      Branch Occurs to L412 
L411:        
        ldiu      0,r0
L412:        
        sti       r0,@_m_MDS_ErrCnt+10
	.line	199
;----------------------------------------------------------------------
; 1371 | pCommStatus_Lic->BYTE_2.BIT.nSdi4 = (m_MDS_ErrCnt.nSdi4_10 >= 100) ? 1
;     | : 0;                                                                   
; 1373 | // PII                                                                 
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L414
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L414 
        ldiu      1,r0
L414:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      4,r1
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	202
;----------------------------------------------------------------------
; 1374 | m_MDS_ErrCnt.nPii1_11 = (pCarState->CRA_4.BIT.sBPII1) ? (m_MDS_ErrCnt.n
;     | Pii1_11 + 1) : 0;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      32,r0
        tstb      *+ar0(3),r0
        beq       L416
;*      Branch Occurs to L416 
        bud       L417
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+11,r0  ; Unsigned
;*      Branch Occurs to L417 
L416:        
        ldiu      0,r0
L417:        
        sti       r0,@_m_MDS_ErrCnt+11
	.line	203
;----------------------------------------------------------------------
; 1375 | pCommStatus_Lic->BYTE_2.BIT.nPii1 = (m_MDS_ErrCnt.nPii1_11 >= 100) ? 1
;     | : 0;                                                                   
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L419
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L419 
        ldiu      1,r0
L419:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      8,r1
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	205
;----------------------------------------------------------------------
; 1377 | m_MDS_ErrCnt.nPii2_12 = (pCarState->CRA_4.BIT.sBPII2) ? (m_MDS_ErrCnt.n
;     | Pii2_12 + 1) : 0;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      16,r0
        tstb      *+ar0(3),r0
        beq       L421
;*      Branch Occurs to L421 
        bud       L422
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+12,r0  ; Unsigned
;*      Branch Occurs to L422 
L421:        
        ldiu      0,r0
L422:        
        sti       r0,@_m_MDS_ErrCnt+12
	.line	206
;----------------------------------------------------------------------
; 1378 | pCommStatus_Lic->BYTE_2.BIT.nPii2 = (m_MDS_ErrCnt.nPii2_12 >= 100) ? 1
;     | : 0;                                                                   
; 1380 | // PID1                                                                
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L424
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L424 
        ldiu      1,r0
L424:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      16,r1
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	209
;----------------------------------------------------------------------
; 1381 | m_MDS_ErrCnt.nPid1_1_13 = (pCarState->CRA_6.BIT.sBPID1_1) ? (m_MDS_ErrC
;     | nt.nPid1_1_13 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      128,r0
        tstb      *+ar0(5),r0
        beq       L426
;*      Branch Occurs to L426 
        bud       L427
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+13,r0  ; Unsigned
;*      Branch Occurs to L427 
L426:        
        ldiu      0,r0
L427:        
        sti       r0,@_m_MDS_ErrCnt+13
	.line	210
;----------------------------------------------------------------------
; 1382 | pCommStatus_Lic->BYTE_2.BIT.nPid1_1 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L429
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L429 
        ldiu      1,r0
L429:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      32,r1
        ash       5,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	212
;----------------------------------------------------------------------
; 1384 | m_MDS_ErrCnt.nPid1_2_14 = (pCarState->CRA_6.BIT.sBPID1_2) ? (m_MDS_ErrC
;     | nt.nPid1_2_14 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      64,r0
        tstb      *+ar0(5),r0
        beq       L431
;*      Branch Occurs to L431 
        bud       L432
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+14,r0  ; Unsigned
;*      Branch Occurs to L432 
L431:        
        ldiu      0,r0
L432:        
        sti       r0,@_m_MDS_ErrCnt+14
	.line	213
;----------------------------------------------------------------------
; 1385 | pCommStatus_Lic->BYTE_2.BIT.nPid1_2 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        ldiu      @_m_MDS_ErrCnt+13,r0
        cmpi      100,r0
        blod      L434
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r0
;*      Branch Occurs to L434 
        ldiu      1,r0
L434:        
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      64,r1
        ash       6,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	215
;----------------------------------------------------------------------
; 1387 | m_MDS_ErrCnt.nPid1_3_15 = (pCarState->CRA_6.BIT.sBPID1_3) ? (m_MDS_ErrC
;     | nt.nPid1_3_15 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      32,r0
        tstb      *+ar0(5),r0
        beq       L436
;*      Branch Occurs to L436 
        bud       L437
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+15,r0  ; Unsigned
;*      Branch Occurs to L437 
L436:        
        ldiu      0,r0
L437:        
        sti       r0,@_m_MDS_ErrCnt+15
	.line	216
;----------------------------------------------------------------------
; 1388 | pCommStatus_Lic->BYTE_2.BIT.nPid1_3 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        ldiu      @_m_MDS_ErrCnt+13,r0
        cmpi      100,r0
        blod      L439
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r1
;*      Branch Occurs to L439 
        ldiu      1,r1
L439:        
        ldiu      *+ar0(1),r0
        and       1,r1
        andn      128,r0
        ash       7,r1
        or3       r0,r1,r0
        sti       r0,*+ar0(1)
	.line	218
;----------------------------------------------------------------------
; 1390 | m_MDS_ErrCnt.nPid1_4_16 = (pCarState->CRA_6.BIT.sBPID1_4) ? (m_MDS_ErrC
;     | nt.nPid1_4_16 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      16,r0
        tstb      *+ar0(5),r0
        beq       L441
;*      Branch Occurs to L441 
        bud       L442
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+16,r0  ; Unsigned
;*      Branch Occurs to L442 
L441:        
        ldiu      0,r0
L442:        
        sti       r0,@_m_MDS_ErrCnt+16
	.line	219
;----------------------------------------------------------------------
; 1391 | pCommStatus_Lic->BYTE_3.BIT.nPid1_4 = (m_MDS_ErrCnt.nPid1_1_13 >= 100)
;     | ? 1 : 0;                                                               
; 1394 | // PID2                                                                
;----------------------------------------------------------------------
        ldiu      @_m_MDS_ErrCnt+13,r0
        cmpi      100,r0
        blod      L444
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r1
;*      Branch Occurs to L444 
        ldiu      1,r1
L444:        
        ldiu      *+ar0(2),r0
        and       1,r1
        andn      1,r0
        or3       r0,r1,r0
        sti       r0,*+ar0(2)
	.line	223
;----------------------------------------------------------------------
; 1395 | m_MDS_ErrCnt.nPid2_1_17 = (pCarState->CRA_7.BIT.sBPID2_1) ? (m_MDS_ErrC
;     | nt.nPid2_1_17 + 1) : 0;                                                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      128,r0
        tstb      *+ar0(6),r0
        beq       L446
;*      Branch Occurs to L446 
        bud       L447
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+17,r0  ; Unsigned
;*      Branch Occurs to L447 
L446:        
        ldiu      0,r0
L447:        
        sti       r0,@_m_MDS_ErrCnt+17
	.line	224
;----------------------------------------------------------------------
; 1396 | pCommStatus_Lic->BYTE_3.BIT.nPid2_1 = (m_MDS_ErrCnt.nPid2_1_17 >= 100)
;     | ? 1 : 0;                                                               
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L449
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r1
;*      Branch Occurs to L449 
        ldiu      1,r1
L449:        
        ldiu      *+ar0(2),r0
        and       1,r1
        andn      2,r0
        ash       1,r1
        or3       r0,r1,r0
        sti       r0,*+ar0(2)
	.line	228
;----------------------------------------------------------------------
; 1400 | if (m_Variable.m_LIC_CNCS_TimSetFlag) // CNCS Åë½ÅÀ» ÇÑ¹øÀÌ¶óµµ Çß´Ù¸é.
;----------------------------------------------------------------------
        ldi       @_m_Variable+356,r0
        beq       L465
;*      Branch Occurs to L465 
	.line	230
;----------------------------------------------------------------------
; 1402 | d_Cncs_commCnt1++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt1+0,r0
        sti       r0,@_d_Cncs_commCnt1+0
	.line	232
;----------------------------------------------------------------------
; 1404 | if (m_Variable.m_nCncsRxCheck1msTimer) // 1ºÐ 30ÃÊ µ¿¾ÈÀº ÂüÀ¸·Î ±â·ÏÇÑ
;     | ´Ù.                                                                    
;----------------------------------------------------------------------
        ldi       @_m_Variable+358,r0
        beq       L452
;*      Branch Occurs to L452 
	.line	234
;----------------------------------------------------------------------
; 1406 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	235
;----------------------------------------------------------------------
; 1407 | d_Cncs_commCnt2++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt2+0,r0
        sti       r0,@_d_Cncs_commCnt2+0
	.line	236
;----------------------------------------------------------------------
; 1408 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
; 1410 | else                                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
L452:        
	.line	240
;----------------------------------------------------------------------
; 1412 | if (m_Variable.m_tmUtcTime.hour = 7 && m_Variable.m_tmUtcTime.minute >
;     | 55)                                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+238,r1
        cmpi      55,r1
        ldiu      0,r0
        ldihi     1,r0
        cmpi      0,r0
        beqd      L454
        sti       r0,@_m_Variable+239
	nop
        ldine     *+fp(1),ar0
;*      Branch Occurs to L454 
	.line	242
;----------------------------------------------------------------------
; 1414 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	243
;----------------------------------------------------------------------
; 1415 | d_Cncs_commCnt3++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt3+0,r0
        sti       r0,@_d_Cncs_commCnt3+0
	.line	244
;----------------------------------------------------------------------
; 1416 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
L454:        
	.line	246
;----------------------------------------------------------------------
; 1418 | else if (m_Variable.m_tmUtcTime.hour = 8)                              
;----------------------------------------------------------------------
        ldi       8,r0
        beqd      L457
        sti       r0,@_m_Variable+239
	nop
        ldieq     @_m_Variable+238,r1
;*      Branch Occurs to L457 
	.line	248
;----------------------------------------------------------------------
; 1420 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	249
;----------------------------------------------------------------------
; 1421 | d_Cncs_commCnt3++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt3+0,r0
        sti       r0,@_d_Cncs_commCnt3+0
	.line	250
;----------------------------------------------------------------------
; 1422 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
	.line	252
;----------------------------------------------------------------------
; 1424 | else if (m_Variable.m_tmUtcTime.hour = 9 && m_Variable.m_tmUtcTime.minu
;     | te < 30)                                                               
;----------------------------------------------------------------------
L457:        
        cmpi      30,r1
        ldiu      0,r0
        ldilo     1,r0
        cmpi      0,r0
        beqd      L459
        sti       r0,@_m_Variable+239
	nop
        ldine     *+fp(1),ar0
;*      Branch Occurs to L459 
	.line	254
;----------------------------------------------------------------------
; 1426 | pCommStatus_Lic->BYTE_3.BIT.nCncs = 0;                                 
;----------------------------------------------------------------------
        ldiu      *+ar0(2),r0
        andn      4,r0
        sti       r0,*+ar0(2)
	.line	255
;----------------------------------------------------------------------
; 1427 | d_Cncs_commCnt4++;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt4+0,r0
        sti       r0,@_d_Cncs_commCnt4+0
	.line	256
;----------------------------------------------------------------------
; 1428 | m_MDS_ErrCnt.nCncs_18 = 0;                                             
; 1431 | else                                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_MDS_ErrCnt+18
        bu        L471
;*      Branch Occurs to L471 
L459:        
	.line	261
;----------------------------------------------------------------------
; 1433 | m_MDS_ErrCnt.nCncs_18 = (pCarState->CRA_3.BIT.sBCNCS) ? (m_MDS_ErrCnt.n
;     | Cncs_18 + 1) : 1;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      16,r0
        tstb      *+ar0(2),r0
        beq       L461
;*      Branch Occurs to L461 
        bud       L462
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+18,r0  ; Unsigned
;*      Branch Occurs to L462 
L461:        
        ldiu      1,r0
L462:        
        sti       r0,@_m_MDS_ErrCnt+18
	.line	262
;----------------------------------------------------------------------
; 1434 | pCommStatus_Lic->BYTE_3.BIT.nCncs = (m_MDS_ErrCnt.nCncs_18 >= 100) ? 1
;     | : 0;                                                                   
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L464
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r1
;*      Branch Occurs to L464 
        ldiu      1,r1
L464:        
        ldiu      *+ar0(2),r0
        and       1,r1
        andn      4,r0
        ash       2,r1
        or3       r0,r1,r0
        sti       r0,*+ar0(2)
	.line	263
;----------------------------------------------------------------------
; 1435 | d_Cncs_commCnt5++;                                                     
; 1440 | else                                                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt5+0,r0
        sti       r0,@_d_Cncs_commCnt5+0
        bu        L471
;*      Branch Occurs to L471 
L465:        
	.line	270
;----------------------------------------------------------------------
; 1442 | m_MDS_ErrCnt.nCncs_18 = (pCarState->CRA_3.BIT.sBCNCS) ? (m_MDS_ErrCnt.n
;     | Cncs_18 + 1) : 1;                                                      
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      16,r0
        tstb      *+ar0(2),r0
        beq       L467
;*      Branch Occurs to L467 
        bud       L468
	nop
        ldiu      1,r0
        addi      @_m_MDS_ErrCnt+18,r0  ; Unsigned
;*      Branch Occurs to L468 
L467:        
        ldiu      1,r0
L468:        
        sti       r0,@_m_MDS_ErrCnt+18
	.line	271
;----------------------------------------------------------------------
; 1443 | pCommStatus_Lic->BYTE_3.BIT.nCncs = (m_MDS_ErrCnt.nCncs_18 >= 100) ? 1
;     | : 0;                                                                   
;----------------------------------------------------------------------
        cmpi      100,r0
        blod      L470
        ldiu      *+fp(1),ar0
	nop
        ldilo     0,r1
;*      Branch Occurs to L470 
        ldiu      1,r1
L470:        
        ldiu      *+ar0(2),r0
        and       1,r1
        andn      4,r0
        ash       2,r1
        or3       r0,r1,r0
        sti       r0,*+ar0(2)
	.line	272
;----------------------------------------------------------------------
; 1444 | d_Cncs_commCnt5++;                                                     
; 1449 | //MyPrintf("LIC -> MDS (Unit State) : %02X ,%02X,%02X\r\n ",pCommStatus
;     | _Lic->BYTE_1.BYTE,pCommStatus_Lic->BYTE_2.BYTE,pCommStatus_Lic->BYTE_3.
;     | BYTE);                                                                 
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_d_Cncs_commCnt5+0,r0
        sti       r0,@_d_Cncs_commCnt5+0
L471:        
	.line	280
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	1452,000000000h,1


	.sect	 ".text"

	.global	_GetLocalTimeToUTC
	.sym	_GetLocalTimeToUTC,_GetLocalTimeToUTC,36,2,0
	.func	1458
;******************************************************************************
;* FUNCTION NAME: _GetLocalTimeToUTC                                          *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r4,ar0,ar1,fp,sp,st                           *
;*   Regs Saved         : r4                                                  *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 3 Parm + 5 Auto + 1 SOE = 11 words         *
;******************************************************************************
_GetLocalTimeToUTC:
	.sym	_pLocal,-2,24,9,32,.fake7
	.sym	_nHour,-3,4,9,32
	.sym	_pUTC,-4,24,9,32,.fake7
	.sym	_nHourT,1,4,1,32
	.sym	_nDayT,2,4,1,32
	.sym	_nLastDays,3,4,1,32
	.sym	_nMonthT,4,4,1,32
	.sym	_nYearT,5,4,1,32
	.line	1
;----------------------------------------------------------------------
; 1458 | BOOL GetLocalTimeToUTC( DATE_TIME_PTR pLocal, int nHour, DATE_TIME_PTR
;     | pUTC )                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      5,sp
        push      r4
	.line	2
;----------------------------------------------------------------------
; 1460 | // ½Ã°£À» °è»êÇÏ´Â ºÎºÐ.                                               
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 1461 | int nHourT = pLocal->hour - nHour;                                     
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      *-fp(3),r0
        subri     *+ar0(2),r0           ; Unsigned
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 1462 | int nDayT = pLocal->day;                                               
;----------------------------------------------------------------------
        ldiu      *+ar0(3),r0
        sti       r0,*+fp(2)
	.line	6
;----------------------------------------------------------------------
; 1463 | int nLastDays = GetDaysOfMonth( pLocal->month, pLocal->year );
;     |                                                                        
;     |                                                                        
;----------------------------------------------------------------------
        ldiu      ar0,ar1
        ldiu      *+ar0(4),r1
        ldiu      *+ar1(5),r0
        push      r0
        push      r1
        call      _GetDaysOfMonth
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(3)
	.line	7
;----------------------------------------------------------------------
; 1464 | int nMonthT = pLocal->month;                                           
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      *+ar0(4),r0
        sti       r0,*+fp(4)
	.line	8
;----------------------------------------------------------------------
; 1465 | int nYearT = 2000 + pLocal->year;                                      
; 1467 | // ½Ã°£ Á¤º¸¸¦ ±¸ÇÏ´Â ºÎºÐ.                                            
;----------------------------------------------------------------------
        ldiu      2000,r0
        addi      *+ar0(5),r0           ; Unsigned
        sti       r0,*+fp(5)
	.line	11
;----------------------------------------------------------------------
; 1468 | if(nHourT < 0 ) {                                                      
;----------------------------------------------------------------------
        ldi       *+fp(1),r0
        bge       L475
;*      Branch Occurs to L475 
	.line	12
;----------------------------------------------------------------------
; 1469 | nHourT += 24;                                                          
;----------------------------------------------------------------------
        ldiu      24,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
	.line	13
;----------------------------------------------------------------------
; 1470 | nDayT += -1;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *+fp(2),r0
        sti       r0,*+fp(2)
        bu        L477
;*      Branch Occurs to L477 
L475:        
	.line	15
;----------------------------------------------------------------------
; 1472 | else if( 24 <= nHourT ) {                                              
;----------------------------------------------------------------------
        ldiu      24,r0
        cmpi      *+fp(1),r0
        bgt       L477
;*      Branch Occurs to L477 
	.line	16
;----------------------------------------------------------------------
; 1473 | nHourT -= 24;                                                          
;----------------------------------------------------------------------
        subri     *+fp(1),r0
        sti       r0,*+fp(1)
	.line	17
;----------------------------------------------------------------------
; 1474 | nDayT += 1;                                                            
; 1477 | // ÀÏÀÚ¸¦ ±¸ÇÏ´Â ºÎºÐ.                                                 
; 1478 | // ½Ã°£À» °è»êÇÏ¿© ÀÏÀÚ¸¦ º¯°æÇØ¾ßÇÏ´Â °æ¿ì.                           
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      *+fp(2),r0
        sti       r0,*+fp(2)
L477:        
	.line	22
;----------------------------------------------------------------------
; 1479 | if(nDayT < 1)
;     |                                                                        
;     |                                                                        
;     |                                                                        
;----------------------------------------------------------------------
        ldi       *+fp(2),r0
        bgt       L480
;*      Branch Occurs to L480 
	.line	24
;----------------------------------------------------------------------
; 1481 | nDayT = GetDaysOfMonth( nMonthT, nYearT );                             
;----------------------------------------------------------------------
        ldiu      *+fp(5),r0
        push      r0
        ldiu      *+fp(4),r0
        push      r0
        call      _GetDaysOfMonth
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(2)
	.line	26
;----------------------------------------------------------------------
; 1483 | if(--nMonthT < 1)                                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *+fp(4),r0
        bgtd      L483
        sti       r0,*+fp(4)
	nop
        ldile     1,r0
;*      Branch Occurs to L483 
	.line	28
;----------------------------------------------------------------------
; 1485 | nYearT--;                                                              
;----------------------------------------------------------------------
        subri     *+fp(5),r0
        sti       r0,*+fp(5)
	.line	29
;----------------------------------------------------------------------
; 1486 | nMonthT = 12;                                                          
;----------------------------------------------------------------------
        ldiu      12,r0
        sti       r0,*+fp(4)
        bu        L483
;*      Branch Occurs to L483 
L480:        
	.line	32
;----------------------------------------------------------------------
; 1489 | else if(nLastDays < nDayT)                                             
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        cmpi      *+fp(2),r0
        bge       L483
;*      Branch Occurs to L483 
	.line	34
;----------------------------------------------------------------------
; 1491 | nDayT = 1;                                                             
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(2)
	.line	36
;----------------------------------------------------------------------
; 1493 | if(12 < ++nMonthT)                                                     
;----------------------------------------------------------------------
        ldiu      12,r1
        addi      *+fp(4),r0
        cmpi3     r0,r1
        bged      L483
        sti       r0,*+fp(4)
	nop
        ldilt     1,r0
;*      Branch Occurs to L483 
	.line	38
;----------------------------------------------------------------------
; 1495 | nYearT++;                                                              
;----------------------------------------------------------------------
        addi      *+fp(5),r0
        sti       r0,*+fp(5)
	.line	39
;----------------------------------------------------------------------
; 1496 | nMonthT = 1;                                                           
; 1500 | // °è»êµÈ ½ÃºÐÃÊ Á¤º¸¸¦ UTC ½Ã°£À¸·Î ÀÌµ¿½ÃÅ°´Â ºÎºÐ.                  
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(4)
L483:        
	.line	44
;----------------------------------------------------------------------
; 1501 | pUTC->second = pLocal->second;                                         
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      *-fp(4),ar1
        ldiu      *ar0,r0
        sti       r0,*ar1
	.line	45
;----------------------------------------------------------------------
; 1502 | pUTC->minute = pLocal->minute;                                         
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar1
        ldiu      *-fp(4),ar0
        ldiu      *+ar1(1),r0
        sti       r0,*+ar0(1)
	.line	46
;----------------------------------------------------------------------
; 1503 | pUTC->hour = nHourT;                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      *+fp(1),r0
        sti       r0,*+ar0(2)
	.line	47
;----------------------------------------------------------------------
; 1504 | pUTC->day = nDayT;                                                     
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      *+fp(2),r0
        sti       r0,*+ar0(3)
	.line	48
;----------------------------------------------------------------------
; 1505 | pUTC->month = nMonthT;                                                 
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      *+fp(4),r0
        sti       r0,*+ar0(4)
	.line	49
;----------------------------------------------------------------------
; 1506 | pUTC->year = nYearT - 2000;                                            
; 1508 | return      (( 10 <= pUTC->year ) &&
;     |                                                                        
;     |                                   // 10³â ÀÌ»ó                         
; 1509 |                         (( 1 <= pUTC->month ) && ( pUTC->month <= 12 ))
;     |  &&                                                                    
;     |                   // ¿ù                                                
; 1510 |                         (( 1 <= pUTC->day )   && ( pUTC->day <= GetDays
;     | OfMonth(nMonthT, nYearT) )) &&                           // ÀÏ         
; 1511 |                         (( 0 <= pUTC->hour )  && ( pUTC->hour < 24 ))
;     |  &&                                                                    
;     |                   // ½Ã                                                
; 1512 |                         (( 0 <= pUTC->minute) && ( pUTC->minute < 60 ))
;     |  &&                                                                    
;     |                   // ºÐ                                                
;----------------------------------------------------------------------
        ldiu      2000,r0
        ldiu      *-fp(4),ar0
        subri     *+fp(5),r0            ; Unsigned
        sti       r0,*+ar0(5)
	.line	56
;----------------------------------------------------------------------
; 1513 | (( 0 <= pUTC->second) && ( pUTC->second < 60 )));
;     |                                                                  // ÃÊ 
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      10,r0
        cmpi      *+ar0(5),r0
        ldiu      0,r4
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      1,r0
        cmpi      *+ar0(4),r0
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      *+ar0(4),r0
        cmpi      12,r0
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      1,r0
        cmpi      *+ar0(3),r0
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      *+fp(5),r0
        push      r0
        ldiu      *+fp(4),r0
        push      r0
        call      _GetDaysOfMonth
                                        ; Call Occurs
        subi      2,sp
        ldiu      *-fp(4),ar0
        ldiu      *+ar0(3),r1
        cmpi3     r0,r1
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      0,r0
        cmpi      *+ar0(2),r0
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      *+ar0(2),r0
        cmpi      24,r0
        bhs       L494
;*      Branch Occurs to L494 
        ldiu      0,r0
        cmpi3     *+ar0,r0
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      *+ar0(1),r0
        cmpi      60,r0
        bhs       L494
;*      Branch Occurs to L494 
        ldiu      0,r0
        cmpi3     *ar0,r0
        bhi       L494
;*      Branch Occurs to L494 
        ldiu      *ar0,r0
        cmpi      60,r0
        ldilo     1,r4
L494:        
	.line	57
        ldiu      r4,r0
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      7,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	1514,000000010h,5


	.sect	 ".text"

	.global	_IsLeapYear
	.sym	_IsLeapYear,_IsLeapYear,36,2,0
	.func	1519
;******************************************************************************
;* FUNCTION NAME: _IsLeapYear                                                 *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,st                                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 0 Auto + 0 SOE = 3 words          *
;******************************************************************************
_IsLeapYear:
	.sym	_nYear,-2,4,9,32
	.line	1
;----------------------------------------------------------------------
; 1519 | int IsLeapYear( int nYear )
;     |                  // À±³â Á¤º¸¸¦ ±¸ÇÏ´Â ºÎºÐ.                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 1521 | if( nYear % 400 == 0 )                                                 
;----------------------------------------------------------------------
        ldiu      400,r1
        ldiu      *-fp(2),r0
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L499
;*      Branch Occurs to L499 
	.line	4
;----------------------------------------------------------------------
; 1522 | return 1;                                                              
;----------------------------------------------------------------------
        bud       L504
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L504 
L499:        
	.line	6
;----------------------------------------------------------------------
; 1524 | if( nYear % 100 == 0 )                                                 
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        ldiu      100,r1
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L501
;*      Branch Occurs to L501 
	.line	7
;----------------------------------------------------------------------
; 1525 | return 0;                                                              
;----------------------------------------------------------------------
        bud       L504
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L504 
L501:        
	.line	9
;----------------------------------------------------------------------
; 1527 | if( nYear % 4 == 0 )                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(2),r1
        ldiu      r1,r0
        ash       -1,r0
        lsh       @CL76,r0
        addi3     r0,r1,r0
        andn      3,r0
        subri     r1,r0
        bne       L503
;*      Branch Occurs to L503 
	.line	10
;----------------------------------------------------------------------
; 1528 | return 1;                                                              
;----------------------------------------------------------------------
        bud       L504
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L504 
L503:        
	.line	12
;----------------------------------------------------------------------
; 1530 | return 0;                                                              
;----------------------------------------------------------------------
        ldiu      0,r0
L504:        
	.line	13
        ldiu      *-fp(1),ar1
        ldiu      *fp,fp
        subi      2,sp
        bu        ar1
;*      Branch Occurs to ar1 
	.endfunc	1531,000000000h,0


	.sect	 ".text"

	.global	_GetDaysOfMonth
	.sym	_GetDaysOfMonth,_GetDaysOfMonth,36,2,0
	.func	1533
;******************************************************************************
;* FUNCTION NAME: _GetDaysOfMonth                                             *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,fp,ir0,sp,st                                 *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 1 Auto + 0 SOE = 5 words          *
;******************************************************************************
_GetDaysOfMonth:
	.sym	_nMonth,-2,4,9,32
	.sym	_nYear,-3,4,9,32
	.sym	_nDays,1,4,1,32
	.line	1
;----------------------------------------------------------------------
; 1533 | int GetDaysOfMonth( int nMonth, int nYear )
;     |  // ´ÞÀÇ ¸¶Áö¸· ÀÏÀÚ¸¦ ±¸ÇÏ´Â ºÎºÐ.                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	4
;----------------------------------------------------------------------
; 1536 | int nDays = 0;                                                         
; 1538 | switch( nMonth )                                                       
; 1540 | case 1 :
;     |                                  // 31À» ¸¶Áö¸· ³¯´Þ                   
; 1541 | case 3 :                                                               
; 1542 | case 5 :                                                               
; 1543 | case 7 :                                                               
; 1544 | case 8 :                                                               
; 1545 | case 10 :                                                              
; 1546 | case 12 :                                                              
;----------------------------------------------------------------------
        bud       L512
        addi      1,sp
        ldiu      0,r0
        sti       r0,*+fp(1)
;*      Branch Occurs to L512 
L507:        
	.line	15
;----------------------------------------------------------------------
; 1547 | nDays = 31;                                                            
;----------------------------------------------------------------------
        ldiu      31,r0
        sti       r0,*+fp(1)
	.line	16
;----------------------------------------------------------------------
; 1548 | break;                                                                 
; 1549 | case 2 :                                                               
;----------------------------------------------------------------------
        bu        L514
;*      Branch Occurs to L514 
L508:        
	.line	18
;----------------------------------------------------------------------
; 1550 | nDays = 28;                                                            
;----------------------------------------------------------------------
        ldiu      28,r0
        sti       r0,*+fp(1)
	.line	19
;----------------------------------------------------------------------
; 1551 | if( IsLeapYear( nYear ) )
;     |          // À±³âÀ» °è»êÇÏ¿©, À±´ÞÀÏ °æ¿ì, +1                           
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        push      r0
        call      _IsLeapYear
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L514
;*      Branch Occurs to L514 
	.line	20
;----------------------------------------------------------------------
; 1552 | nDays += 1;                                                            
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
	.line	21
;----------------------------------------------------------------------
; 1553 | break;                                                                 
; 1554 | case 4 :
;     |                                  // 30À» ¸¶Áö¸· ³¯´Þ                   
; 1555 | case 6 :                                                               
; 1556 | case 9 :                                                               
; 1557 | case 11 :                                                              
;----------------------------------------------------------------------
        bu        L514
;*      Branch Occurs to L514 
L510:        
	.line	26
;----------------------------------------------------------------------
; 1558 | nDays = 30;                                                            
;----------------------------------------------------------------------
        ldiu      30,r0
        sti       r0,*+fp(1)
	.line	27
;----------------------------------------------------------------------
; 1559 | break;                                                                 
;----------------------------------------------------------------------
        bu        L514
;*      Branch Occurs to L514 
L512:        
	.line	6
        ldiu      1,r0
        ldiu      *-fp(2),ir0
        subri     ir0,r0
        cmpi      11,r0
        bhi       L514
;*      Branch Occurs to L514 
        subi      1,ir0
        ldiu      @CL77,ar0
        ldiu      *+ar0(ir0),r0
        bu        r0

	.sect	".text"
SW0:	.word	L507	; 1
	.word	L508	; 2
	.word	L507	; 3
	.word	L510	; 4
	.word	L507	; 5
	.word	L510	; 6
	.word	L507	; 7
	.word	L507	; 8
	.word	L510	; 9
	.word	L507	; 10
	.word	L510	; 11
	.word	L507	; 12
	.sect	".text"
;*      Branch Occurs to r0 
L514:        
	.line	30
;----------------------------------------------------------------------
; 1562 | return nDays;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	31
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	1563,000000000h,1


	.sect	 ".text"

	.global	_user_CarNoForCarKindToLon
	.sym	_user_CarNoForCarKindToLon,_user_CarNoForCarKindToLon,32,2,0
	.func	1569
;******************************************************************************
;* FUNCTION NAME: _user_CarNoForCarKindToLon                                  *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0                                                  *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_user_CarNoForCarKindToLon:
	.line	1
;----------------------------------------------------------------------
; 1569 | void user_CarNoForCarKindToLon()                                       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 1571 | m_Variable.m_nCarKindToLonCnt = 0;                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+285
	.line	4
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	1572,000000000h,0



	.sect	".cinit"
	.field  	1,32
	.field  	_ddd_timeCnt+0,32
	.field  	0,32		; _ddd_timeCnt @ 0

	.sect	".text"

	.global	_ddd_timeCnt
	.bss	_ddd_timeCnt,1
	.sym	_ddd_timeCnt,_ddd_timeCnt,12,2,32
	.sect	 ".text"

	.global	_user_1msLoop
	.sym	_user_1msLoop,_user_1msLoop,32,2,0
	.func	1579
;******************************************************************************
;* FUNCTION NAME: _user_1msLoop                                               *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_user_1msLoop:
	.line	1
;----------------------------------------------------------------------
; 1579 | void user_1msLoop()                                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 1581 | m_Variable.m_nTxDbg1msTimer++;                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+294,r0   ; Unsigned
        sti       r0,@_m_Variable+294
	.line	4
;----------------------------------------------------------------------
; 1582 | m_Variable.m_nUserDebug1msTimer++;                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+228,r0   ; Unsigned
        sti       r0,@_m_Variable+228
	.line	6
;----------------------------------------------------------------------
; 1584 | m_Variable.m_nTest1msTimer++;                                          
; 1586 | //ddd_timeCnt = m_Variable.m_nTest1msTimer;                            
; 1587 | //m_Variable.m_ProStartFlag = 1;                                       
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+229,r0   ; Unsigned
        sti       r0,@_m_Variable+229
	.line	10
;----------------------------------------------------------------------
; 1588 | if (m_Variable.m_nTest1msTimer >= 90000) { m_Variable.m_ProStartFlag =
;     | 1; }                                                                   
;----------------------------------------------------------------------
        cmpi      @CL78,r0
        blo       L522
;*      Branch Occurs to L522 
        ldiu      1,r0
        sti       r0,@_m_Variable+244
L522:        
	.line	12
;----------------------------------------------------------------------
; 1590 | if(m_Variable.m_nUart2RxOneByteGapDelayTime) m_Variable.m_nUart2RxOneBy
;     | teGapDelayTime--;                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+226,r0
        beq       L524
;*      Branch Occurs to L524 
        ldiu      1,r0
        subri     @_m_Variable+226,r0   ; Unsigned
        sti       r0,@_m_Variable+226
L524:        
	.line	13
;----------------------------------------------------------------------
; 1591 | if(m_Variable.m_nUart3RxOneByteGapDelayTime) m_Variable.m_nUart3RxOneBy
;     | teGapDelayTime--;                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+227,r0
        beq       L526
;*      Branch Occurs to L526 
        ldiu      1,r0
        subri     @_m_Variable+227,r0   ; Unsigned
        sti       r0,@_m_Variable+227
L526:        
	.line	15
;----------------------------------------------------------------------
; 1593 | if(m_Variable.m_nGiaRxCheck1msTimer) m_Variable.m_nGiaRxCheck1msTimer--
;     | ;                                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+359,r0
        beq       L528
;*      Branch Occurs to L528 
        ldiu      1,r0
        subri     @_m_Variable+359,r0   ; Unsigned
        sti       r0,@_m_Variable+359
L528:        
	.line	17
;----------------------------------------------------------------------
; 1595 | if(m_Variable.m_nCncsRxCheck1msTimer) m_Variable.m_nCncsRxCheck1msTimer
;     | --;                                                                    
;----------------------------------------------------------------------
        ldi       @_m_Variable+358,r0
        beq       L530
;*      Branch Occurs to L530 
        ldiu      1,r0
        subri     @_m_Variable+358,r0   ; Unsigned
        sti       r0,@_m_Variable+358
L530:        
	.line	21
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	1599,000000000h,0



	.global	_d_MDSFaulgTestBuf
	.bss	_d_MDSFaulgTestBuf,20
	.sym	_d_MDSFaulgTestBuf,_d_MDSFaulgTestBuf,52,2,640,,20

	.global	_m_MDS_ErrCnt
	.bss	_m_MDS_ErrCnt,24
	.sym	_m_MDS_ErrCnt,_m_MDS_ErrCnt,8,2,768,.fake68

	.global	_d_ErrorBuf
	.bss	_d_ErrorBuf,25
	.sym	_d_ErrorBuf,_d_ErrorBuf,52,2,800,,25

	.global	_m_Variable
	.bss	_m_Variable,368
	.sym	_m_Variable,_m_Variable,8,2,11776,.fake70

	.global	_d_DataBuf
	.bss	_d_DataBuf,10
	.sym	_d_DataBuf,_d_DataBuf,52,2,320,,10
;******************************************************************************
;* STRINGS                                                                    *
;******************************************************************************
	.sect	".const"
SL1:	.byte	"Lonwork Monitor Program, Version:%d.%d%d%d",13,10,0
SL2:	.byte	"CCP",0
SL3:	.byte	"CRA-LICL",0
SL4:	.byte	"CRA-VTX",0
SL5:	.byte	"CRA-VOIP",0
SL6:	.byte	"CRA-PAC",0
SL7:	.byte	"CRA-LICM",0
SL8:	.byte	"FDI1",0
SL9:	.byte	"SDI1",0
SL10:	.byte	"SDI2",0
SL11:	.byte	"SDI3",0
SL12:	.byte	"SDI4",0
SL13:	.byte	"PII1",0
SL14:	.byte	"PII2",0
SL15:	.byte	"VRX1",0
SL16:	.byte	"VRX2",0
SL17:	.byte	"VRX3",0
SL18:	.byte	"VRX4",0
SL19:	.byte	"VRX5",0
SL20:	.byte	"CRA-MAIN",0
SL21:	.byte	"CRA-LAUN",0
SL22:	.byte	"CRA-UP",0
SL23:	.byte	"CRA-PP",0
SL24:	.byte	"CRA-SP",0
SL25:	.byte	"CRA-FTP",0
SL26:	.byte	"CRA-CDT",0
;******************************************************************************
;* CONSTANT TABLE                                                             *
;******************************************************************************
	.sect	".const"
	.bss	CL1,1
	.bss	CL2,1
	.bss	CL3,1
	.bss	CL4,1
	.bss	CL5,1
	.bss	CL6,1
	.bss	CL7,1
	.bss	CL8,1
	.bss	CL9,1
	.bss	CL10,1
	.bss	CL11,1
	.bss	CL12,1
	.bss	CL13,1
	.bss	CL14,1
	.bss	CL15,1
	.bss	CL16,1
	.bss	CL17,1
	.bss	CL18,1
	.bss	CL19,1
	.bss	CL20,1
	.bss	CL21,1
	.bss	CL22,1
	.bss	CL23,1
	.bss	CL24,1
	.bss	CL25,1
	.bss	CL26,1
	.bss	CL27,1
	.bss	CL28,1
	.bss	CL29,1
	.bss	CL30,1
	.bss	CL31,1
	.bss	CL32,1
	.bss	CL33,1
	.bss	CL34,1
	.bss	CL35,1
	.bss	CL36,1
	.bss	CL37,1
	.bss	CL38,1
	.bss	CL39,1
	.bss	CL40,1
	.bss	CL41,1
	.bss	CL42,1
	.bss	CL43,1
	.bss	CL44,1
	.bss	CL45,1
	.bss	CL46,1
	.bss	CL47,1
	.bss	CL48,1
	.bss	CL49,1
	.bss	CL50,1
	.bss	CL51,1
	.bss	CL52,1
	.bss	CL53,1
	.bss	CL54,1
	.bss	CL55,1
	.bss	CL56,1
	.bss	CL57,1
	.bss	CL58,1
	.bss	CL59,1
	.bss	CL60,1
	.bss	CL61,1
	.bss	CL62,1
	.bss	CL63,1
	.bss	CL64,1
	.bss	CL65,1
	.bss	CL66,1
	.bss	CL67,1
	.bss	CL68,1
	.bss	CL69,1
	.bss	CL70,1
	.bss	CL71,1
	.bss	CL72,1
	.bss	CL73,1
	.bss	CL74,1
	.bss	CL75,1
	.bss	CL76,1
	.bss	CL77,1
	.bss	CL78,1

	.sect	".cinit"
	.field  	78,32
	.field  	CL1+0,32
	.field  	11534336,32
	.field  	16776716,32
	.field  	_m_Variable+245,32
	.field  	_m_Variable+253,32
	.field  	_m_Variable+261,32
	.field  	_m_Variable+296,32
	.field  	_m_Variable+325,32
	.field  	_m_MDS_ErrCnt,32
	.field  	100000,32
	.field  	536870912,32
	.field  	SL1,32
	.field  	2097153,32
	.field  	_m_Variable,32
	.field  	32768,32
	.field  	32768,32
	.field  	-1,32
	.field  	32768,32
	.field  	SL2,32
	.field  	_m_Variable+9,32
	.field  	SL3,32
	.field  	_m_Variable+18,32
	.field  	SL4,32
	.field  	_m_Variable+27,32
	.field  	SL5,32
	.field  	_m_Variable+36,32
	.field  	SL6,32
	.field  	_m_Variable+45,32
	.field  	SL7,32
	.field  	_m_Variable+54,32
	.field  	SL8,32
	.field  	_m_Variable+63,32
	.field  	SL9,32
	.field  	_m_Variable+72,32
	.field  	SL10,32
	.field  	_m_Variable+81,32
	.field  	SL11,32
	.field  	_m_Variable+90,32
	.field  	SL12,32
	.field  	_m_Variable+99,32
	.field  	SL13,32
	.field  	_m_Variable+108,32
	.field  	SL14,32
	.field  	_m_Variable+117,32
	.field  	SL15,32
	.field  	_m_Variable+126,32
	.field  	SL16,32
	.field  	_m_Variable+135,32
	.field  	SL17,32
	.field  	_m_Variable+144,32
	.field  	SL18,32
	.field  	_m_Variable+153,32
	.field  	SL19,32
	.field  	_m_Variable+162,32
	.field  	SL20,32
	.field  	_m_Variable+171,32
	.field  	SL21,32
	.field  	_m_Variable+180,32
	.field  	SL22,32
	.field  	_m_Variable+189,32
	.field  	SL23,32
	.field  	_m_Variable+198,32
	.field  	SL24,32
	.field  	_m_Variable+207,32
	.field  	SL25,32
	.field  	_m_Variable+216,32
	.field  	SL26,32
	.field  	12582912,32
	.field  	_btRx2chBuf$3,32
	.field  	100000,32
	.field  	12582912,32
	.field  	-25,32
	.field  	_btTx2chBuf$4,32
	.field  	_m_Variable+362,32
	.field  	_btRx3chBuf$8,32
	.field  	_d_ErrorBuf,32
	.field  	-30,32
	.field  	SW0,32
	.field  	90000,32

	.sect	".text"
;******************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                              *
;******************************************************************************

	.global	_sprintf

	.global	_memset

	.global	_strcpy

	.global	_strlen

	.global	_IsNumAsc

	.global	_ConvHex2Asc

	.global	_ConvAsc2Hex

	.global	_GetFirmwareVersion

	.global	_FunConvAscHex

	.global	_FunConvHexAsc

	.global	_crc16_ccitt

	.global	_DebugLoop

	.global	_xr16l784_RtsDelayStartSend

	.global	_xr16l784_Send

	.global	_xr16l784_GetRxBuffer1Ch

	.global	_xr16l784_GetRxBuffer3Ch

	.global	_xr16l784_GetRxBuffer2Ch

	.global	_LonWorkLoop
	.global	MOD_I30
	.global	DIV_I30
	.global	_memcpy
