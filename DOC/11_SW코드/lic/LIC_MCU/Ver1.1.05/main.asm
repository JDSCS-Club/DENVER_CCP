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
;	c:\lang\tms320c3x\511\bin\ac30.exe main.c C:\Users\JDS_DELL\AppData\Local\Temp\main.if 
	.file	"main.c"
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
	.file	"stdarg.h"
	.sym	_va_list,0,18,13,32
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
	.file	"MpuDebug.h"
	.file	"main.c"

	.sect	".cinit"
	.field  	IR_1,32
	.field  	_crc16tab+0,32
	.field  	0,32		; _crc16tab[0] @ 0
	.field  	4129,32		; _crc16tab[1] @ 32
	.field  	8258,32		; _crc16tab[2] @ 64
	.field  	12387,32		; _crc16tab[3] @ 96
	.field  	16516,32		; _crc16tab[4] @ 128
	.field  	20645,32		; _crc16tab[5] @ 160
	.field  	24774,32		; _crc16tab[6] @ 192
	.field  	28903,32		; _crc16tab[7] @ 224
	.field  	33032,32		; _crc16tab[8] @ 256
	.field  	37161,32		; _crc16tab[9] @ 288
	.field  	41290,32		; _crc16tab[10] @ 320
	.field  	45419,32		; _crc16tab[11] @ 352
	.field  	49548,32		; _crc16tab[12] @ 384
	.field  	53677,32		; _crc16tab[13] @ 416
	.field  	57806,32		; _crc16tab[14] @ 448
	.field  	61935,32		; _crc16tab[15] @ 480
	.field  	4657,32		; _crc16tab[16] @ 512
	.field  	528,32		; _crc16tab[17] @ 544
	.field  	12915,32		; _crc16tab[18] @ 576
	.field  	8786,32		; _crc16tab[19] @ 608
	.field  	21173,32		; _crc16tab[20] @ 640
	.field  	17044,32		; _crc16tab[21] @ 672
	.field  	29431,32		; _crc16tab[22] @ 704
	.field  	25302,32		; _crc16tab[23] @ 736
	.field  	37689,32		; _crc16tab[24] @ 768
	.field  	33560,32		; _crc16tab[25] @ 800
	.field  	45947,32		; _crc16tab[26] @ 832
	.field  	41818,32		; _crc16tab[27] @ 864
	.field  	54205,32		; _crc16tab[28] @ 896
	.field  	50076,32		; _crc16tab[29] @ 928
	.field  	62463,32		; _crc16tab[30] @ 960
	.field  	58334,32		; _crc16tab[31] @ 992
	.field  	9314,32		; _crc16tab[32] @ 1024
	.field  	13379,32		; _crc16tab[33] @ 1056
	.field  	1056,32		; _crc16tab[34] @ 1088
	.field  	5121,32		; _crc16tab[35] @ 1120
	.field  	25830,32		; _crc16tab[36] @ 1152
	.field  	29895,32		; _crc16tab[37] @ 1184
	.field  	17572,32		; _crc16tab[38] @ 1216
	.field  	21637,32		; _crc16tab[39] @ 1248
	.field  	42346,32		; _crc16tab[40] @ 1280
	.field  	46411,32		; _crc16tab[41] @ 1312
	.field  	34088,32		; _crc16tab[42] @ 1344
	.field  	38153,32		; _crc16tab[43] @ 1376
	.field  	58862,32		; _crc16tab[44] @ 1408
	.field  	62927,32		; _crc16tab[45] @ 1440
	.field  	50604,32		; _crc16tab[46] @ 1472
	.field  	54669,32		; _crc16tab[47] @ 1504
	.field  	13907,32		; _crc16tab[48] @ 1536
	.field  	9842,32		; _crc16tab[49] @ 1568
	.field  	5649,32		; _crc16tab[50] @ 1600
	.field  	1584,32		; _crc16tab[51] @ 1632
	.field  	30423,32		; _crc16tab[52] @ 1664
	.field  	26358,32		; _crc16tab[53] @ 1696
	.field  	22165,32		; _crc16tab[54] @ 1728
	.field  	18100,32		; _crc16tab[55] @ 1760
	.field  	46939,32		; _crc16tab[56] @ 1792
	.field  	42874,32		; _crc16tab[57] @ 1824
	.field  	38681,32		; _crc16tab[58] @ 1856
	.field  	34616,32		; _crc16tab[59] @ 1888
	.field  	63455,32		; _crc16tab[60] @ 1920
	.field  	59390,32		; _crc16tab[61] @ 1952
	.field  	55197,32		; _crc16tab[62] @ 1984
	.field  	51132,32		; _crc16tab[63] @ 2016
	.field  	18628,32		; _crc16tab[64] @ 2048
	.field  	22757,32		; _crc16tab[65] @ 2080
	.field  	26758,32		; _crc16tab[66] @ 2112
	.field  	30887,32		; _crc16tab[67] @ 2144
	.field  	2112,32		; _crc16tab[68] @ 2176
	.field  	6241,32		; _crc16tab[69] @ 2208
	.field  	10242,32		; _crc16tab[70] @ 2240
	.field  	14371,32		; _crc16tab[71] @ 2272
	.field  	51660,32		; _crc16tab[72] @ 2304
	.field  	55789,32		; _crc16tab[73] @ 2336
	.field  	59790,32		; _crc16tab[74] @ 2368
	.field  	63919,32		; _crc16tab[75] @ 2400
	.field  	35144,32		; _crc16tab[76] @ 2432
	.field  	39273,32		; _crc16tab[77] @ 2464
	.field  	43274,32		; _crc16tab[78] @ 2496
	.field  	47403,32		; _crc16tab[79] @ 2528
	.field  	23285,32		; _crc16tab[80] @ 2560
	.field  	19156,32		; _crc16tab[81] @ 2592
	.field  	31415,32		; _crc16tab[82] @ 2624
	.field  	27286,32		; _crc16tab[83] @ 2656
	.field  	6769,32		; _crc16tab[84] @ 2688
	.field  	2640,32		; _crc16tab[85] @ 2720
	.field  	14899,32		; _crc16tab[86] @ 2752
	.field  	10770,32		; _crc16tab[87] @ 2784
	.field  	56317,32		; _crc16tab[88] @ 2816
	.field  	52188,32		; _crc16tab[89] @ 2848
	.field  	64447,32		; _crc16tab[90] @ 2880
	.field  	60318,32		; _crc16tab[91] @ 2912
	.field  	39801,32		; _crc16tab[92] @ 2944
	.field  	35672,32		; _crc16tab[93] @ 2976
	.field  	47931,32		; _crc16tab[94] @ 3008
	.field  	43802,32		; _crc16tab[95] @ 3040
	.field  	27814,32		; _crc16tab[96] @ 3072
	.field  	31879,32		; _crc16tab[97] @ 3104
	.field  	19684,32		; _crc16tab[98] @ 3136
	.field  	23749,32		; _crc16tab[99] @ 3168
	.field  	11298,32		; _crc16tab[100] @ 3200
	.field  	15363,32		; _crc16tab[101] @ 3232
	.field  	3168,32		; _crc16tab[102] @ 3264
	.field  	7233,32		; _crc16tab[103] @ 3296
	.field  	60846,32		; _crc16tab[104] @ 3328
	.field  	64911,32		; _crc16tab[105] @ 3360
	.field  	52716,32		; _crc16tab[106] @ 3392
	.field  	56781,32		; _crc16tab[107] @ 3424
	.field  	44330,32		; _crc16tab[108] @ 3456
	.field  	48395,32		; _crc16tab[109] @ 3488
	.field  	36200,32		; _crc16tab[110] @ 3520
	.field  	40265,32		; _crc16tab[111] @ 3552
	.field  	32407,32		; _crc16tab[112] @ 3584
	.field  	28342,32		; _crc16tab[113] @ 3616
	.field  	24277,32		; _crc16tab[114] @ 3648
	.field  	20212,32		; _crc16tab[115] @ 3680
	.field  	15891,32		; _crc16tab[116] @ 3712
	.field  	11826,32		; _crc16tab[117] @ 3744
	.field  	7761,32		; _crc16tab[118] @ 3776
	.field  	3696,32		; _crc16tab[119] @ 3808
	.field  	65439,32		; _crc16tab[120] @ 3840
	.field  	61374,32		; _crc16tab[121] @ 3872
	.field  	57309,32		; _crc16tab[122] @ 3904
	.field  	53244,32		; _crc16tab[123] @ 3936
	.field  	48923,32		; _crc16tab[124] @ 3968
	.field  	44858,32		; _crc16tab[125] @ 4000
	.field  	40793,32		; _crc16tab[126] @ 4032
	.field  	36728,32		; _crc16tab[127] @ 4064
	.field  	37256,32		; _crc16tab[128] @ 4096
	.field  	33193,32		; _crc16tab[129] @ 4128
	.field  	45514,32		; _crc16tab[130] @ 4160
	.field  	41451,32		; _crc16tab[131] @ 4192
	.field  	53516,32		; _crc16tab[132] @ 4224
	.field  	49453,32		; _crc16tab[133] @ 4256
	.field  	61774,32		; _crc16tab[134] @ 4288
	.field  	57711,32		; _crc16tab[135] @ 4320
	.field  	4224,32		; _crc16tab[136] @ 4352
	.field  	161,32		; _crc16tab[137] @ 4384
	.field  	12482,32		; _crc16tab[138] @ 4416
	.field  	8419,32		; _crc16tab[139] @ 4448
	.field  	20484,32		; _crc16tab[140] @ 4480
	.field  	16421,32		; _crc16tab[141] @ 4512
	.field  	28742,32		; _crc16tab[142] @ 4544
	.field  	24679,32		; _crc16tab[143] @ 4576
	.field  	33721,32		; _crc16tab[144] @ 4608
	.field  	37784,32		; _crc16tab[145] @ 4640
	.field  	41979,32		; _crc16tab[146] @ 4672
	.field  	46042,32		; _crc16tab[147] @ 4704
	.field  	49981,32		; _crc16tab[148] @ 4736
	.field  	54044,32		; _crc16tab[149] @ 4768
	.field  	58239,32		; _crc16tab[150] @ 4800
	.field  	62302,32		; _crc16tab[151] @ 4832
	.field  	689,32		; _crc16tab[152] @ 4864
	.field  	4752,32		; _crc16tab[153] @ 4896
	.field  	8947,32		; _crc16tab[154] @ 4928
	.field  	13010,32		; _crc16tab[155] @ 4960
	.field  	16949,32		; _crc16tab[156] @ 4992
	.field  	21012,32		; _crc16tab[157] @ 5024
	.field  	25207,32		; _crc16tab[158] @ 5056
	.field  	29270,32		; _crc16tab[159] @ 5088
	.field  	46570,32		; _crc16tab[160] @ 5120
	.field  	42443,32		; _crc16tab[161] @ 5152
	.field  	38312,32		; _crc16tab[162] @ 5184
	.field  	34185,32		; _crc16tab[163] @ 5216
	.field  	62830,32		; _crc16tab[164] @ 5248
	.field  	58703,32		; _crc16tab[165] @ 5280
	.field  	54572,32		; _crc16tab[166] @ 5312
	.field  	50445,32		; _crc16tab[167] @ 5344
	.field  	13538,32		; _crc16tab[168] @ 5376
	.field  	9411,32		; _crc16tab[169] @ 5408
	.field  	5280,32		; _crc16tab[170] @ 5440
	.field  	1153,32		; _crc16tab[171] @ 5472
	.field  	29798,32		; _crc16tab[172] @ 5504
	.field  	25671,32		; _crc16tab[173] @ 5536
	.field  	21540,32		; _crc16tab[174] @ 5568
	.field  	17413,32		; _crc16tab[175] @ 5600
	.field  	42971,32		; _crc16tab[176] @ 5632
	.field  	47098,32		; _crc16tab[177] @ 5664
	.field  	34713,32		; _crc16tab[178] @ 5696
	.field  	38840,32		; _crc16tab[179] @ 5728
	.field  	59231,32		; _crc16tab[180] @ 5760
	.field  	63358,32		; _crc16tab[181] @ 5792
	.field  	50973,32		; _crc16tab[182] @ 5824
	.field  	55100,32		; _crc16tab[183] @ 5856
	.field  	9939,32		; _crc16tab[184] @ 5888
	.field  	14066,32		; _crc16tab[185] @ 5920
	.field  	1681,32		; _crc16tab[186] @ 5952
	.field  	5808,32		; _crc16tab[187] @ 5984
	.field  	26199,32		; _crc16tab[188] @ 6016
	.field  	30326,32		; _crc16tab[189] @ 6048
	.field  	17941,32		; _crc16tab[190] @ 6080
	.field  	22068,32		; _crc16tab[191] @ 6112
	.field  	55628,32		; _crc16tab[192] @ 6144
	.field  	51565,32		; _crc16tab[193] @ 6176
	.field  	63758,32		; _crc16tab[194] @ 6208
	.field  	59695,32		; _crc16tab[195] @ 6240
	.field  	39368,32		; _crc16tab[196] @ 6272
	.field  	35305,32		; _crc16tab[197] @ 6304
	.field  	47498,32		; _crc16tab[198] @ 6336
	.field  	43435,32		; _crc16tab[199] @ 6368
	.field  	22596,32		; _crc16tab[200] @ 6400
	.field  	18533,32		; _crc16tab[201] @ 6432
	.field  	30726,32		; _crc16tab[202] @ 6464
	.field  	26663,32		; _crc16tab[203] @ 6496
	.field  	6336,32		; _crc16tab[204] @ 6528
	.field  	2273,32		; _crc16tab[205] @ 6560
	.field  	14466,32		; _crc16tab[206] @ 6592
	.field  	10403,32		; _crc16tab[207] @ 6624
	.field  	52093,32		; _crc16tab[208] @ 6656
	.field  	56156,32		; _crc16tab[209] @ 6688
	.field  	60223,32		; _crc16tab[210] @ 6720
	.field  	64286,32		; _crc16tab[211] @ 6752
	.field  	35833,32		; _crc16tab[212] @ 6784
	.field  	39896,32		; _crc16tab[213] @ 6816
	.field  	43963,32		; _crc16tab[214] @ 6848
	.field  	48026,32		; _crc16tab[215] @ 6880
	.field  	19061,32		; _crc16tab[216] @ 6912
	.field  	23124,32		; _crc16tab[217] @ 6944
	.field  	27191,32		; _crc16tab[218] @ 6976
	.field  	31254,32		; _crc16tab[219] @ 7008
	.field  	2801,32		; _crc16tab[220] @ 7040
	.field  	6864,32		; _crc16tab[221] @ 7072
	.field  	10931,32		; _crc16tab[222] @ 7104
	.field  	14994,32		; _crc16tab[223] @ 7136
	.field  	64814,32		; _crc16tab[224] @ 7168
	.field  	60687,32		; _crc16tab[225] @ 7200
	.field  	56684,32		; _crc16tab[226] @ 7232
	.field  	52557,32		; _crc16tab[227] @ 7264
	.field  	48554,32		; _crc16tab[228] @ 7296
	.field  	44427,32		; _crc16tab[229] @ 7328
	.field  	40424,32		; _crc16tab[230] @ 7360
	.field  	36297,32		; _crc16tab[231] @ 7392
	.field  	31782,32		; _crc16tab[232] @ 7424
	.field  	27655,32		; _crc16tab[233] @ 7456
	.field  	23652,32		; _crc16tab[234] @ 7488
	.field  	19525,32		; _crc16tab[235] @ 7520
	.field  	15522,32		; _crc16tab[236] @ 7552
	.field  	11395,32		; _crc16tab[237] @ 7584
	.field  	7392,32		; _crc16tab[238] @ 7616
	.field  	3265,32		; _crc16tab[239] @ 7648
	.field  	61215,32		; _crc16tab[240] @ 7680
	.field  	65342,32		; _crc16tab[241] @ 7712
	.field  	53085,32		; _crc16tab[242] @ 7744
	.field  	57212,32		; _crc16tab[243] @ 7776
	.field  	44955,32		; _crc16tab[244] @ 7808
	.field  	49082,32		; _crc16tab[245] @ 7840
	.field  	36825,32		; _crc16tab[246] @ 7872
	.field  	40952,32		; _crc16tab[247] @ 7904
	.field  	28183,32		; _crc16tab[248] @ 7936
	.field  	32310,32		; _crc16tab[249] @ 7968
	.field  	20053,32		; _crc16tab[250] @ 8000
	.field  	24180,32		; _crc16tab[251] @ 8032
	.field  	11923,32		; _crc16tab[252] @ 8064
	.field  	16050,32		; _crc16tab[253] @ 8096
	.field  	3793,32		; _crc16tab[254] @ 8128
	.field  	7920,32		; _crc16tab[255] @ 8160
IR_1:	.set	256

	.sect	".text"
	.bss	_crc16tab,256
	.sym	_crc16tab,_crc16tab,61,3,8192,,256

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nDebug1msTimer+0,32
	.field  	0,32		; _m_nDebug1msTimer @ 0

	.sect	".text"

	.global	_m_nDebug1msTimer
	.bss	_m_nDebug1msTimer,1
	.sym	_m_nDebug1msTimer,_m_nDebug1msTimer,14,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nDebugCnt+0,32
	.field  	0,32		; _m_nDebugCnt @ 0

	.sect	".text"

	.global	_m_nDebugCnt
	.bss	_m_nDebugCnt,1
	.sym	_m_nDebugCnt,_m_nDebugCnt,4,2,32

	.sect	".cinit"
	.field  	IR_2,32
	.field  	_m_pBoardIdInfo+0,32
	.field  	SL1,32		; _m_pBoardIdInfo[0] @ 0
	.field  	SL2,32		; _m_pBoardIdInfo[1] @ 32
	.field  	SL3,32		; _m_pBoardIdInfo[2] @ 64
	.field  	0,32		; _m_pBoardIdInfo[3] @ 96
IR_2:	.set	4

	.sect	".text"

	.global	_m_pBoardIdInfo
	.bss	_m_pBoardIdInfo,4
	.sym	_m_pBoardIdInfo,_m_pBoardIdInfo,114,2,128,,4
	.sect	 ".text"

	.global	_main
	.sym	_main,_main,32,2,0
	.func	110
;******************************************************************************
;* FUNCTION NAME: _main                                                       *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3,ar0,fp,sp,st,rs                         *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 8 Auto + 0 SOE = 10 words         *
;******************************************************************************
_main:
	.sym	_i,1,4,1,32
	.sym	_tmBuf,2,8,1,224,.fake7
	.line	1
;----------------------------------------------------------------------
; 110 | void main(void)                                                        
; 112 | int i;                                                                 
; 113 | DATE_TIME_TYPE tmBuf;                                                  
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      8,sp
	.line	6
;----------------------------------------------------------------------
; 115 | DINT;                                                                  
;----------------------------------------------------------------------
	AND	0DFFFh, ST	
	.line	7
;----------------------------------------------------------------------
; 116 | WDI_ACT;                                                               
;----------------------------------------------------------------------
        ldiu      8192,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	8
;----------------------------------------------------------------------
; 117 | DspInit();                                                             
;----------------------------------------------------------------------
        call      _DspInit
                                        ; Call Occurs
	.line	9
;----------------------------------------------------------------------
; 118 | Debug3xInit(TMS320C31);                                                
;----------------------------------------------------------------------
        ldiu      31,r0
        push      r0
        call      _Debug3xInit
                                        ; Call Occurs
        subi      1,sp
	.line	11
;----------------------------------------------------------------------
; 120 | XR16L784_TXDIS(XR16L784_1CHL);                                         
;----------------------------------------------------------------------
        ldiu      0,r1
        ldiu      0,r0
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
	.line	12
;----------------------------------------------------------------------
; 121 | XR16L784_TXDIS(XR16L784_2CHL);                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      0,r1
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
	.line	13
;----------------------------------------------------------------------
; 122 | XR16L784_TXDIS(XR16L784_3CHL);                                         
;----------------------------------------------------------------------
        ldiu      2,r0
        ldiu      0,r1
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
	.line	14
;----------------------------------------------------------------------
; 123 | XR16L784_TXDIS(XR16L784_4CHL);                                         
;----------------------------------------------------------------------
        ldiu      0,r1
        ldiu      3,r0
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
	.line	16
;----------------------------------------------------------------------
; 125 | xr16l784_Init(XR16L784_1CHL,38400,XR16L784_DATA8,XR16L784_NONEPARITY,XR
;     | 16L784_1STOPBIT); // 디버그용                                          
;----------------------------------------------------------------------
        ldiu      0,r1
        push      r1
        ldiu      0,r0
        ldiu      3,rs
        push      r0
        push      rs
        ldiu      @CL1,r3
        ldiu      0,r2
        push      r3
        push      r2
        call      _xr16l784_Init
                                        ; Call Occurs
        subi      5,sp
	.line	17
;----------------------------------------------------------------------
; 126 | xr16l784_Init(XR16L784_2CHL,38400,XR16L784_DATA8,XR16L784_NONEPARITY,XR
;     | 16L784_1STOPBIT); // LIC <-> CNCS                                      
;----------------------------------------------------------------------
        ldiu      0,r2
        ldiu      0,r3
        ldiu      @CL1,r0
        push      r2
        ldiu      3,rs
        push      r3
        push      rs
        push      r0
        ldiu      1,r1
        push      r1
        call      _xr16l784_Init
                                        ; Call Occurs
        subi      5,sp
	.line	18
;----------------------------------------------------------------------
; 127 | xr16l784_Init(XR16L784_3CHL,19200,XR16L784_DATA8,XR16L784_NONEPARITY,XR
;     | 16L784_1STOPBIT); // LIC <-> PAC                                       
; 128 | //xr16l784_Init(XR16L784_4CHL,19200,XR16L784_DATA8,XR16L784_NONEPARITY,
;     | XR16L784_1STOPBIT); // LIC <-> PAC                                     
;----------------------------------------------------------------------
        ldiu      19200,r3
        ldiu      3,r2
        ldiu      0,r0
        ldiu      0,r1
        push      r0
        push      r1
        push      r2
        push      r3
        ldiu      2,rs
        push      rs
        call      _xr16l784_Init
                                        ; Call Occurs
        subi      5,sp
	.line	21
;----------------------------------------------------------------------
; 130 | WDI_ACT;                                                               
;----------------------------------------------------------------------
        ldiu      8192,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	22
;----------------------------------------------------------------------
; 131 | EINT;                                                                  
;----------------------------------------------------------------------
	OR	02000h, ST	
	.line	23
;----------------------------------------------------------------------
; 132 | user_Init();                                                           
; 135 | while(1)                                                               
;----------------------------------------------------------------------
        call      _user_Init
                                        ; Call Occurs
L2:        
	.line	28
;----------------------------------------------------------------------
; 137 | user_Loop();                                                           
;----------------------------------------------------------------------
        call      _user_Loop
                                        ; Call Occurs
	.line	29
;----------------------------------------------------------------------
; 138 | xr16l784_Loop();                                                       
;----------------------------------------------------------------------
        call      _xr16l784_Loop
                                        ; Call Occurs
	.line	31
;----------------------------------------------------------------------
; 140 | if(!XR16L784_INT_ST) xr16l784_Isr();                                   
;----------------------------------------------------------------------
        ldiu      @CL2,ar0
        ldiu      -2,r0
        lsh3      r0,*ar0,r0
        tstb      1,r0
        calleq    _xr16l784_Isr
                                        ; Call Occurs
	.line	33
;----------------------------------------------------------------------
; 142 | if(m_nDebug1msTimer > 500)                                             
;----------------------------------------------------------------------
        ldiu      @_m_nDebug1msTimer+0,r0
        cmpi      500,r0
        bls       L4
;*      Branch Occurs to L4 
	.line	35
;----------------------------------------------------------------------
; 144 | m_nDebug1msTimer = 0;                                                  
; 146 | //xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)"1234567",7,5);    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_nDebug1msTimer+0
L4:        
	.line	40
;----------------------------------------------------------------------
; 149 | m_nDebugCnt++;                                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nDebugCnt+0,r0
        sti       r0,@_m_nDebugCnt+0
	.line	42
        bu        L2
;*      Branch Occurs to L2 
	.line	43
	.endfunc	152,000000000h,8


	.sect	 ".text"

	.global	_DspInit
	.sym	_DspInit,_DspInit,32,2,0
	.func	156
;******************************************************************************
;* FUNCTION NAME: _DspInit                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0                                              *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_DspInit:
	.line	1
;----------------------------------------------------------------------
; 156 | void DspInit(void)                                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 158 | PRIMBUSREG = 0x10e8;                                                   
;----------------------------------------------------------------------
        ldiu      @CL3,ar0
        ldiu      4328,r0
        sti       r0,*ar0
	.line	4
;----------------------------------------------------------------------
; 159 | EN_CACHE;                                                              
; 161 | // Timer 0                                                             
;----------------------------------------------------------------------
   OR	00800h, ST	
	.line	7
;----------------------------------------------------------------------
; 162 | TMR0_CTRL = 0x2c0 ; // 내부 클럭                                       
;----------------------------------------------------------------------
        ldiu      @CL4,ar0
        ldiu      704,r0
        sti       r0,*ar0
	.line	8
;----------------------------------------------------------------------
; 163 | TMR0_PERD = 25000; // 100,000,000MHz / 4 / 25000(x) = 1000Hz(1000us)   
;----------------------------------------------------------------------
        ldiu      @CL5,ar0
        ldiu      25000,r0
        sti       r0,*ar0
	.line	10
;----------------------------------------------------------------------
; 165 | INT1_VECT                       = OP_BR | (int)c_int02; // Ext Int 0
;     |                                                                        
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        ldiu      @CL6,ar0
        or        @CL8,r0
        sti       r0,*ar0
	.line	11
;----------------------------------------------------------------------
; 166 | INT2_VECT                       = OP_BR | (int)c_int03; // Ext Int 1
;     |                                                                        
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        ldiu      @CL9,ar0
        or        @CL10,r0
        sti       r0,*ar0
	.line	12
;----------------------------------------------------------------------
; 167 | TINT0_VECT                      = OP_BR | (int)c_int10; // Timer 0
;     |                                                                        
; 169 | //EI_INT0;                                                             
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        ldiu      @CL11,ar0
        or        @CL12,r0
        sti       r0,*ar0
	.line	15
;----------------------------------------------------------------------
; 170 | EI_INT2;                                                               
;----------------------------------------------------------------------
	OR	00004h, IE	
	.line	16
;----------------------------------------------------------------------
; 171 | EI_TINT0;                                                              
; 173 | // XF0, XF1 출력 모드                                                  
;----------------------------------------------------------------------
 OR        00100h, IE 
	.line	19
;----------------------------------------------------------------------
; 174 | asm(" LDI 0066h,IOF");                                                 
;----------------------------------------------------------------------
 LDI 0066h,IOF
	.line	21
;----------------------------------------------------------------------
; 176 | BOOT2INT;                                                              
;----------------------------------------------------------------------
        ldiu      @CL13,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	22
        ldiu      *-fp(1),ar0
        ldiu      *fp,fp
        subi      2,sp
        bu        ar0
;*      Branch Occurs to ar0 
	.endfunc	177,000000000h,0


	.sect	 ".text"

	.global	_BCD_BIN
	.sym	_BCD_BIN,_BCD_BIN,45,2,0
	.func	184
;******************************************************************************
;* FUNCTION NAME: _BCD_BIN                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0                                                  *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_BCD_BIN:
	.sym	_nInput,-2,13,9,32
	.sym	_sNum,1,13,1,32
	.line	1
;----------------------------------------------------------------------
; 184 | WORD BCD_BIN(WORD nInput)                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 186 | WORD sNum = 0;                                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 188 | sNum += ((nInput>>12)&0xf) * 1000;                                     
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        lsh       -12,r0
        and       15,r0
        mpyi      1000,r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	6
;----------------------------------------------------------------------
; 189 | sNum += ((nInput>>8)&0xf) * 100;                                       
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        lsh       -8,r0
        and       15,r0
        mpyi      100,r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	7
;----------------------------------------------------------------------
; 190 | sNum += ((nInput>>4)&0xf) * 10;                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        lsh       -4,r0
        and       15,r0
        mpyi      10,r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	8
;----------------------------------------------------------------------
; 191 | sNum += ((nInput)&0xf) * 1;                                            
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *-fp(2),r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	9
;----------------------------------------------------------------------
; 192 | return sNum;                                                           
;----------------------------------------------------------------------
	.line	10
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	193,000000000h,1


	.sect	 ".text"

	.global	_ConvAsc2Hex
	.sym	_ConvAsc2Hex,_ConvAsc2Hex,44,2,0
	.func	198
;******************************************************************************
;* FUNCTION NAME: _ConvAsc2Hex                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_ConvAsc2Hex:
	.sym	_chDat,-2,2,9,32
	.sym	_nBuf,1,4,1,32
	.line	1
;----------------------------------------------------------------------
; 198 | UCHAR ConvAsc2Hex(char chDat)                                          
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 200 | int nBuf = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 201 | if(chDat >= '0' && chDat <= '9') nBuf = chDat-'0';                     
; 202 | else                                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      48,r0
        blt       L16
;*      Branch Occurs to L16 
        cmpi      57,r0
        bgt       L16
;*      Branch Occurs to L16 
        ldiu      48,r0
        subri     *-fp(2),r0
        sti       r0,*+fp(1)
        bu        L22
;*      Branch Occurs to L22 
L16:        
	.line	6
;----------------------------------------------------------------------
; 203 | if(chDat >= 'a' && chDat <= 'f') nBuf = ((chDat-'a') + 10);
;     |                                                                        
; 204 | else                                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      97,r0
        blt       L19
;*      Branch Occurs to L19 
        cmpi      102,r0
        bgt       L19
;*      Branch Occurs to L19 
        ldiu      87,r0
        subri     *-fp(2),r0
        sti       r0,*+fp(1)
        bu        L22
;*      Branch Occurs to L22 
L19:        
	.line	8
;----------------------------------------------------------------------
; 205 | if(chDat >= 'A' && chDat <= 'F') nBuf = ((chDat-'A') + 10);            
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      65,r0
        blt       L22
;*      Branch Occurs to L22 
        cmpi      70,r0
        bgt       L22
;*      Branch Occurs to L22 
        ldiu      55,r0
        subri     *-fp(2),r0
        sti       r0,*+fp(1)
L22:        
	.line	10
;----------------------------------------------------------------------
; 207 | return nBuf;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	11
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	208,000000000h,1


	.sect	 ".text"

	.global	_FunConvAscHex
	.sym	_FunConvAscHex,_FunConvAscHex,36,2,0
	.func	214
;******************************************************************************
;* FUNCTION NAME: _FunConvAscHex                                              *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r4,ar0,fp,ar4,ir0,sp,st                          *
;*   Regs Saved         : r4,ar4                                              *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 3 Parm + 2 Auto + 2 SOE = 9 words          *
;******************************************************************************
_FunConvAscHex:
	.sym	_InchData,-2,18,9,32
	.sym	_OuthexData,-3,28,9,32
	.sym	_Len,-4,4,9,32
	.sym	_i,1,4,1,32
	.sym	_sCnt,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 214 | int FunConvAscHex(char *InchData,UCHAR *OuthexData,int Len)            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
        push      r4
        push      ar4
	.line	2
;----------------------------------------------------------------------
; 216 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 217 | int sCnt = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 218 | for(i=0;i<Len; )                                                       
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      *-fp(4),r0
        bge       L27
;*      Branch Occurs to L27 
L26:        
	.line	7
;----------------------------------------------------------------------
; 220 | OuthexData[sCnt] = (ConvAsc2Hex(InchData[i++])<<4)&0xF0;               
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(1),ar0
        ldiu      *-fp(2),ir0
        addi      ar0,r0
        sti       r0,*+fp(1)
        ldiu      *+ar0(ir0),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ash       4,r0
        ldiu      *-fp(3),ir0
        ldiu      *+fp(2),ar0
        and       240,r0
        sti       r0,*+ar0(ir0)
	.line	8
;----------------------------------------------------------------------
; 221 | OuthexData[sCnt] |= ConvAsc2Hex(InchData[i++])&0x0F;                   
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(1),ar0
        addi      ar0,r0
        ldiu      *-fp(2),ir0
        sti       r0,*+fp(1)
        ldiu      *+fp(2),ar4
        ldiu      *-fp(3),r4
        ldiu      *+ar0(ir0),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r4,ir0
        and       15,r0
        or3       r0,*+ar4(ir0),r0
        subi      1,sp
        sti       r0,*+ar4(ir0)
	.line	10
;----------------------------------------------------------------------
; 223 | sCnt++;                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      *+fp(2),r0
        sti       r0,*+fp(2)
	.line	5
        ldiu      *+fp(1),r0
        cmpi      *-fp(4),r0
        blt       L26
;*      Branch Occurs to L26 
L27:        
	.line	12
;----------------------------------------------------------------------
; 225 | return sCnt;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	13
        pop       ar4
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      4,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	226,000001010h,2


	.sect	 ".text"

	.global	_IsNumAsc
	.sym	_IsNumAsc,_IsNumAsc,36,2,0
	.func	231
;******************************************************************************
;* FUNCTION NAME: _IsNumAsc                                                   *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 0 Auto + 0 SOE = 3 words          *
;******************************************************************************
_IsNumAsc:
	.sym	_nCh,-2,2,9,32
	.line	1
;----------------------------------------------------------------------
; 231 | BOOL IsNumAsc(char nCh)                                                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 233 | if(nCh >= '0' && nCh <= '9') return TRUE;                              
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      48,r0
        blt       L33
;*      Branch Occurs to L33 
        cmpi      57,r0
        bgt       L33
;*      Branch Occurs to L33 
        bud       L34
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L34 
L33:        
	.line	4
;----------------------------------------------------------------------
; 234 | return FALSE;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
L34:        
	.line	5
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	235,000000000h,0


	.sect	 ".text"

	.global	_ConvAsc2Dec
	.sym	_ConvAsc2Dec,_ConvAsc2Dec,36,2,0
	.func	240
;******************************************************************************
;* FUNCTION NAME: _ConvAsc2Dec                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_ConvAsc2Dec:
	.sym	_nCh,-2,2,9,32
	.sym	_nBuf,1,4,1,32
	.line	1
;----------------------------------------------------------------------
; 240 | int ConvAsc2Dec(char nCh)                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 242 | int nBuf = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 243 | if(nCh >= '0' && nCh <= '9') nBuf = nCh-'0'; else return 0;            
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      48,r0
        blt       L39
;*      Branch Occurs to L39 
        cmpi      57,r0
        bgt       L39
;*      Branch Occurs to L39 
        bud       L40
        ldiu      48,r0
        subri     *-fp(2),r0
        sti       r0,*+fp(1)
;*      Branch Occurs to L40 
L39:        
	.line	4
        bud       L41
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L41 
L40:        
	.line	5
;----------------------------------------------------------------------
; 244 | return nBuf;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
L41:        
	.line	6
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	245,000000000h,1


	.sect	 ".text"

	.global	_ConvHex2Asc
	.sym	_ConvHex2Asc,_ConvHex2Asc,34,2,0
	.func	250
;******************************************************************************
;* FUNCTION NAME: _ConvHex2Asc                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_ConvHex2Asc:
	.sym	_btCh,-2,12,9,32
	.sym	_chBuf,1,2,1,32
	.line	1
;----------------------------------------------------------------------
; 250 | char ConvHex2Asc(UCHAR btCh)                                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 252 | char chBuf = '0';                                                      
;----------------------------------------------------------------------
        ldiu      48,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 253 | if(btCh >= 0 && btCh <= 9) chBuf = btCh+'0';                           
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      9,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      48,r0
        addi      *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
        bu        L48
;*      Branch Occurs to L48 
L45:        
	.line	5
;----------------------------------------------------------------------
; 254 | else if(btCh >= 10 && btCh <= 15) chBuf = (btCh-10)+'A';               
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      10,r0
        blo       L48
;*      Branch Occurs to L48 
        cmpi      15,r0
        bhi       L48
;*      Branch Occurs to L48 
        ldiu      55,r0
        addi      *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
L48:        
	.line	6
;----------------------------------------------------------------------
; 255 | return chBuf;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	7
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	256,000000000h,1


	.sect	 ".text"

	.global	_ConvDec2Hex
	.sym	_ConvDec2Hex,_ConvDec2Hex,36,2,0
	.func	260
;******************************************************************************
;* FUNCTION NAME: _ConvDec2Hex                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3                                         *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 0 Auto + 0 SOE = 3 words          *
;******************************************************************************
_ConvDec2Hex:
	.sym	_nCh,-2,2,9,32
	.line	1
;----------------------------------------------------------------------
; 260 | int ConvDec2Hex(char nCh)                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 262 | return ((((nCh / 0x10) & 0x0F) << 4) | ((nCh % 0x10) & 0x0F));         
;----------------------------------------------------------------------
        ldiu      *-fp(2),r3
        ldiu      r3,r0
        ldiu      r0,r2
        ash       -3,r0
        lsh       -28,r0
        addi3     r0,r3,r0
        ash       -4,r0
        ldiu      0,r3
        and       15,r0
        subri     r2,r3
        ash       4,r0
        and       15,r3
        or3       r0,r3,r0
	.line	4
        ldiu      *-fp(1),r3
        ldiu      *fp,fp
        subi      2,sp
        bu        r3
;*      Branch Occurs to r3 
	.endfunc	263,000000000h,0


	.sect	 ".text"

	.global	_FunConvHexAsc
	.sym	_FunConvHexAsc,_FunConvHexAsc,36,2,0
	.func	265
;******************************************************************************
;* FUNCTION NAME: _FunConvHexAsc                                              *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r4,r5,ar0,fp,ir0,sp,st                        *
;*   Regs Saved         : r4,r5                                               *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 3 Parm + 2 Auto + 2 SOE = 9 words          *
;******************************************************************************
_FunConvHexAsc:
	.sym	_InhexData,-2,28,9,32
	.sym	_OUTAscData,-3,18,9,32
	.sym	_Len,-4,4,9,32
	.sym	_i,1,4,1,32
	.sym	_sCnt,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 265 | int FunConvHexAsc(UCHAR *InhexData,char *OUTAscData,int Len)           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
        push      r4
        push      r5
	.line	2
;----------------------------------------------------------------------
; 267 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 268 | int sCnt = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 269 | for(i=0;i<Len;i++)                                                     
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        ldiu      -4,r5
        cmpi      *-fp(4),r0
        ldiu      15,r4
        bge       L56
;*      Branch Occurs to L56 
L55:        
	.line	7
;----------------------------------------------------------------------
; 271 | OUTAscData[sCnt++] = ConvHex2Asc(BYTE_H(InhexData[i]));                
;----------------------------------------------------------------------
        ldiu      *-fp(2),ir0
        ldiu      *+fp(1),ar0
        lsh3      r5,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        ldiu      1,r1
        ldiu      *-fp(3),ir0
        addi      ar0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	8
;----------------------------------------------------------------------
; 272 | OUTAscData[sCnt++] = ConvHex2Asc(BYTE_L(InhexData[i]));                
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *-fp(2),ir0
        and3      r4,*+ar0(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        ldiu      1,r1
        addi      ar0,r1
        sti       r1,*+fp(2)
        ldiu      *-fp(3),ir0
        sti       r0,*+ar0(ir0)
	.line	5
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *-fp(4),r0
        blt       L55
;*      Branch Occurs to L55 
L56:        
	.line	10
;----------------------------------------------------------------------
; 274 | return sCnt;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	11
        pop       r5
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      4,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	275,000000030h,2


	.sect	 ".text"

	.global	_Dec2Str
	.sym	_Dec2Str,_Dec2Str,32,2,0
	.func	279
;******************************************************************************
;* FUNCTION NAME: _Dec2Str                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,fp,ir0,sp,st                              *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 34 Auto + 0 SOE = 38 words        *
;******************************************************************************
_Dec2Str:
	.sym	_pBuf,-2,18,9,32
	.sym	_nDat,-3,4,9,32
	.sym	_i,1,4,1,32
	.sym	_nPos,2,4,1,32
	.sym	_szBuf,3,50,1,1024,,32
	.line	1
;----------------------------------------------------------------------
; 279 | void Dec2Str(char *pBuf,int nDat)                                      
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      34,sp
	.line	2
;----------------------------------------------------------------------
; 281 | int i;                                                                 
; 282 | int nPos;                                                              
; 283 | char szBuf[32];                                                        
;----------------------------------------------------------------------
	.line	7
;----------------------------------------------------------------------
; 285 | nPos=0;                                                                
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	8
;----------------------------------------------------------------------
; 286 | szBuf[nPos++] = (nDat/1000000000%10)+'0';                              
;----------------------------------------------------------------------
        ldiu      @CL14,r1
        ldiu      *-fp(3),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      1,r1
        addi      48,r0
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	9
;----------------------------------------------------------------------
; 287 | szBuf[nPos++] = (nDat/100000000%10)+'0';                               
;----------------------------------------------------------------------
        ldiu      @CL15,r1
        ldiu      *-fp(3),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      1,r1
        addi      48,r0
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	10
;----------------------------------------------------------------------
; 288 | szBuf[nPos++] = (nDat/10000000%10)+'0';                                
;----------------------------------------------------------------------
        ldiu      @CL16,r1
        ldiu      *-fp(3),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        addi      48,r0
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	11
;----------------------------------------------------------------------
; 289 | szBuf[nPos++] = (nDat/1000000%10)+'0';                                 
;----------------------------------------------------------------------
        ldiu      @CL17,r1
        ldiu      *-fp(3),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      1,r1
        addi      48,r0
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	12
;----------------------------------------------------------------------
; 290 | szBuf[nPos++] = (nDat/100000%10)+'0';                                  
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        ldiu      @CL18,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        addi      48,r0
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	13
;----------------------------------------------------------------------
; 291 | szBuf[nPos++] = (nDat/10000%10)+'0';                                   
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        ldiu      10000,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      48,r0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	14
;----------------------------------------------------------------------
; 292 | szBuf[nPos++] = (nDat/1000%10)+'0';                                    
;----------------------------------------------------------------------
        ldiu      1000,r1
        ldiu      *-fp(3),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      48,r0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	15
;----------------------------------------------------------------------
; 293 | szBuf[nPos++] = (nDat/100%10)+'0';                                     
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        ldiu      100,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        addi      48,r0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	16
;----------------------------------------------------------------------
; 294 | szBuf[nPos++] = (nDat/10%10)+'0';                                      
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      48,r0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	17
;----------------------------------------------------------------------
; 295 | szBuf[nPos++] = (nDat%10)+'0';                                         
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      ir0,r1
        ldiu      fp,ar0
        sti       r1,*+fp(2)
        addi      3,ar0
        addi      48,r0
        sti       r0,*+ar0(ir0)
	.line	18
;----------------------------------------------------------------------
; 296 | szBuf[nPos] = NULL;                                                    
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      *+fp(2),ir0
        ldiu      0,r0
        sti       r0,*+ar0(ir0)
	.line	20
;----------------------------------------------------------------------
; 298 | for(i=0;i<nPos;i++) if(szBuf[i]!='0') break;                           
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        bge       L63
;*      Branch Occurs to L63 
L61:        
        ldiu      fp,ar0
        ldiu      *+fp(1),ir0
        addi      3,ar0
        ldiu      *+ar0(ir0),r0
        cmpi      48,r0
        bne       L63
;*      Branch Occurs to L63 
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        blt       L61
;*      Branch Occurs to L61 
L63:        
	.line	21
;----------------------------------------------------------------------
; 299 | i = MIN(i,nPos-1);                                                     
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *+fp(1),r0
        subri     *+fp(2),r1
        cmpi3     r1,r0
        bge       L65
;*      Branch Occurs to L65 
        bu        L66
;*      Branch Occurs to L66 
L65:        
        ldiu      1,r0
        subri     *+fp(2),r0
L66:        
        sti       r0,*+fp(1)
	.line	23
;----------------------------------------------------------------------
; 301 | StrCpy(pBuf,&szBuf[i]);                                                
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      3,r0
        addi      *+fp(1),r0            ; Unsigned
        push      r0
        ldiu      *-fp(2),r0
        push      r0
        call      _StrCpy
                                        ; Call Occurs
        subi      2,sp
	.line	24
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      36,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	302,000000000h,34


	.sect	 ".text"

	.global	_StrCat
	.sym	_StrCat,_StrCat,32,2,0
	.func	307
;******************************************************************************
;* FUNCTION NAME: _StrCat                                                     *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,st                                    *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 1 Auto + 0 SOE = 5 words          *
;******************************************************************************
_StrCat:
	.sym	_dest,-2,18,9,32
	.sym	_src,-3,18,9,32
	.sym	_r1,1,18,1,32
	.line	1
;----------------------------------------------------------------------
; 307 | void StrCat(char *dest, const char *src)                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 309 | char *r1 = dest - 1;                                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
L70:        
	.line	4
;----------------------------------------------------------------------
; 310 | while (*++r1);                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldi       *++ar0(1),r0
        sti       ar0,*+fp(1)
        bne       L70
;*      Branch Occurs to L70 
L71:        
	.line	5
;----------------------------------------------------------------------
; 311 | while ((*r1++ = *src++) != 0);                                         
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      1,r1
        ldiu      *+fp(1),ar1
        ldiu      *ar0++(1),r0
        addi      ar1,r1
        cmpi      0,r0
        bned      L71
        sti       ar0,*-fp(3)
        sti       r1,*+fp(1)
        sti       r0,*ar1
;*      Branch Occurs to L71 
	.line	6
        ldiu      *-fp(1),ar1
        ldiu      *fp,fp
        subi      3,sp
        bu        ar1
;*      Branch Occurs to ar1 
	.endfunc	312,000000000h,1


	.sect	 ".text"

	.global	_StrLen
	.sym	_StrLen,_StrLen,36,2,0
	.func	317
;******************************************************************************
;* FUNCTION NAME: _StrLen                                                     *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,st                                           *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 1 Auto + 0 SOE = 4 words          *
;******************************************************************************
_StrLen:
	.sym	_string,-2,18,9,32
	.sym	_r1,1,18,1,32
	.line	1
;----------------------------------------------------------------------
; 317 | int StrLen(const char *string)                                         
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 319 | const char *r1 = string - 1;                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
L75:        
	.line	4
;----------------------------------------------------------------------
; 320 | while (*++r1);                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldi       *++ar0(1),r0
        sti       ar0,*+fp(1)
        bne       L75
;*      Branch Occurs to L75 
	.line	5
;----------------------------------------------------------------------
; 321 | return r1 - string;                                                    
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        subri     *+fp(1),r0            ; Unsigned
	.line	6
        ldiu      *-fp(1),ar0
        ldiu      *fp,fp
        subi      3,sp
        bu        ar0
;*      Branch Occurs to ar0 
	.endfunc	322,000000000h,1


	.sect	 ".text"

	.global	_StrCpy
	.sym	_StrCpy,_StrCpy,32,2,0
	.func	327
;******************************************************************************
;* FUNCTION NAME: _StrCpy                                                     *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,st                                    *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 1 Auto + 0 SOE = 5 words          *
;******************************************************************************
_StrCpy:
	.sym	_dest,-2,18,9,32
	.sym	_src,-3,18,9,32
	.sym	_result,1,18,1,32
	.line	1
;----------------------------------------------------------------------
; 327 | void StrCpy(char *dest, const char *src)                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 329 | char *result = dest;                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        sti       r0,*+fp(1)
L80:        
	.line	4
;----------------------------------------------------------------------
; 330 | while ((*dest++ = *src++) != 0);                                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      1,r1
        ldiu      *-fp(2),ar1
        ldiu      *ar0++(1),r0
        addi      ar1,r1
        cmpi      0,r0
        bned      L80
        sti       ar0,*-fp(3)
        sti       r1,*-fp(2)
        sti       r0,*ar1
;*      Branch Occurs to L80 
	.line	5
        ldiu      *-fp(1),ar1
        ldiu      *fp,fp
        subi      3,sp
        bu        ar1
;*      Branch Occurs to ar1 
	.endfunc	331,000000000h,1


	.sect	 ".text"

	.global	_StrCmp
	.sym	_StrCmp,_StrCmp,36,2,0
	.func	336
;******************************************************************************
;* FUNCTION NAME: _StrCmp                                                     *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,st                                    *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 3 Auto + 0 SOE = 7 words          *
;******************************************************************************
_StrCmp:
	.sym	_string1,-2,18,9,32
	.sym	_string2,-3,18,9,32
	.sym	_r1,1,18,1,32
	.sym	_r2,2,18,1,32
	.sym	_cp,3,2,1,32
	.line	1
;----------------------------------------------------------------------
; 336 | int StrCmp(const char *string1, const char *string2)                   
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 338 | char *r1 = (char *)string1 - 1;                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 339 | char *r2 = (char *)string2 - 1;                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(3),r0            ; Unsigned
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 340 | char cp = TRUE;                                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(3)
L84:        
	.line	7
;----------------------------------------------------------------------
; 342 | while ( (*++r2 == (cp = *++r1)) && cp );                               
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *+fp(2),ar1
        ldiu      *++ar0(1),r0
        sti       ar0,*+fp(1)
        sti       r0,*+fp(3)
        ldiu      *++ar1(1),r1
        cmpi3     r0,r1
        sti       ar1,*+fp(2)
        bne       L86
;*      Branch Occurs to L86 
        cmpi      0,r0
        bne       L84
;*      Branch Occurs to L84 
L86:        
	.line	9
;----------------------------------------------------------------------
; 344 | return *r1 - *r2;                                                      
;----------------------------------------------------------------------
        ldiu      *+fp(2),ar0
        ldiu      *+fp(1),ar1
        subi3     *ar0,*ar1,r0
	.line	10
        ldiu      *-fp(1),ar1
        ldiu      *fp,fp
        subi      5,sp
        bu        ar1
;*      Branch Occurs to ar1 
	.endfunc	345,000000000h,3


	.sect	 ".text"

	.global	_MyPrintf
	.sym	_MyPrintf,_MyPrintf,32,2,0
	.func	350
;******************************************************************************
;* FUNCTION NAME: _MyPrintf                                                   *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,fp,sp                                      *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 257 Auto + 0 SOE = 260 words      *
;******************************************************************************
_MyPrintf:
	.sym	_format,-2,18,27,32
	.sym	_args,1,18,1,32
	.sym	_szBuf,2,50,1,8192,,256
	.line	1
;----------------------------------------------------------------------
; 350 | void MyPrintf(char * format, ... )                                     
; 352 | va_list args;                                                          
; 353 | char szBuf[256];                                                       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      257,sp
	.line	6
;----------------------------------------------------------------------
; 355 | va_start(args, format);                                                
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      -2,r0
        sti       r0,*+fp(1)
	.line	7
;----------------------------------------------------------------------
; 356 | vsprintf(szBuf, format, args);                                         
;----------------------------------------------------------------------
        ldiu      r0,r1
        ldiu      fp,r0
        push      r1
        addi      2,r0
        ldiu      *-fp(2),r1
        push      r1
        push      r0
        call      _vsprintf
                                        ; Call Occurs
        subi      3,sp
	.line	9
;----------------------------------------------------------------------
; 358 | xr16l784_Send(XR16L784_1CHL,(UCHAR *)szBuf,strlen(szBuf));             
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      2,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      0,r2
        subi      1,sp
        ldiu      fp,r1
        push      r0
        addi      2,r1
        push      r1
        push      r2
        call      _xr16l784_Send
                                        ; Call Occurs
        subi      3,sp
	.line	10
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      259,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	359,000000000h,257


	.sect	 ".text"

	.global	_MyPrintf_TxAuto
	.sym	_MyPrintf_TxAuto,_MyPrintf_TxAuto,32,2,0
	.func	365
;******************************************************************************
;* FUNCTION NAME: _MyPrintf_TxAuto                                            *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r4,r5,ar0,fp,ir0,ir1,sp,st                 *
;*   Regs Saved         : r4,r5                                               *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 2049 Auto + 2 SOE = 2055 words    *
;******************************************************************************
_MyPrintf_TxAuto:
	.sym	_format,-2,28,9,32
	.sym	_nLen,-3,4,9,32
	.sym	_szBuf,1,50,1,32768,,1024
	.sym	_szBuf2,1025,50,1,32768,,1024
	.sym	_i,2049,4,1,32
	.line	1
;----------------------------------------------------------------------
; 365 | void MyPrintf_TxAuto(UCHAR *format,int nLen )                          
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2049,sp
        push      r4
        push      r5
	.line	2
;----------------------------------------------------------------------
; 368 | char szBuf[1024];                                                      
; 369 | char szBuf2[1024];                                                     
; 370 | int i;                                                                 
;----------------------------------------------------------------------
	.line	9
;----------------------------------------------------------------------
; 373 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      1,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	10
;----------------------------------------------------------------------
; 374 | sprintf(szBuf2,"[TX:%02d] ",nLen); strcat(szBuf,szBuf2);               
;----------------------------------------------------------------------
        ldiu      @CL19,r1
        ldiu      *-fp(3),r2
        ldiu      1025,r0
        push      r2
        addi      fp,r0
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      fp,r0
        ldiu      1025,r1
        addi      fp,r1
        addi      1,r0
        push      r1
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	11
;----------------------------------------------------------------------
; 375 | for(i=0;i<nLen;i++) {sprintf(szBuf2,"%02X ",WORD_L(format[i])); strcat(
;     | szBuf,szBuf2);}                                                        
;----------------------------------------------------------------------
        ldiu      2049,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
        ldiu      255,r4
        ldiu      1,r5
        ldiu      *+fp(ir0),r0
        cmpi      *-fp(3),r0
        bge       L94
;*      Branch Occurs to L94 
L93:        
        ldiu      2049,ir1
        ldiu      *-fp(2),ir0
        ldiu      1025,r2
        ldiu      *+fp(ir1),ar0
        ldiu      @CL20,r0
        and3      r4,*+ar0(ir0),r1
        addi      fp,r2
        push      r1
        push      r0
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      1025,r1
        ldiu      fp,r0
        addi      fp,r1
        addi      1,r0
        push      r1
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      2049,ir0
        addi3     r5,*+fp(ir0),r0
        sti       r0,*+fp(ir0)
        ldiu      *+fp(ir0),r0
        cmpi      *-fp(3),r0
        blt       L93
;*      Branch Occurs to L93 
L94:        
	.line	12
;----------------------------------------------------------------------
; 376 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL21,r1
        ldiu      fp,r0
        push      r1
        addi      1,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	14
;----------------------------------------------------------------------
; 378 | user_DebugPrint(szBuf);                                                
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      1,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	16
        pop       r5
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      2051,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	380,000000030h,2049


	.sect	 ".text"

	.global	_FirmwareVersionStrCmp
	.sym	_FirmwareVersionStrCmp,_FirmwareVersionStrCmp,36,2,0
	.func	387
;******************************************************************************
;* FUNCTION NAME: _FirmwareVersionStrCmp                                      *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,ar1,ir0,ir1,st                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 3 Parm + 2 Auto + 0 SOE = 7 words          *
;******************************************************************************
_FirmwareVersionStrCmp:
	.sym	_pObj,-2,18,9,32
	.sym	_pSrc,-3,18,9,32
	.sym	_nLen,-4,4,9,32
	.sym	_i,1,4,1,32
	.sym	_bFlag,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 387 | BOOL FirmwareVersionStrCmp(char *pObj,char *pSrc,int nLen)             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 389 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 390 | BOOL bFlag = TRUE;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 391 | for(i=0;i<nLen;i++) if(pObj[i] != pSrc[i]) {bFlag = FALSE; break;}     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      *-fp(4),r0
        bge       L101
;*      Branch Occurs to L101 
L98:        
        ldiu      *+fp(1),ar0
        ldiu      *-fp(3),ir0
        ldiu      *-fp(2),ir1
        ldiu      ar0,ar1
        cmpi3     *+ar0(ir0),*+ar1(ir1)
        beq       L100
;*      Branch Occurs to L100 
        ldiu      0,r0
        sti       r0,*+fp(2)
        bu        L101
;*      Branch Occurs to L101 
L100:        
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *-fp(4),r0
        blt       L98
;*      Branch Occurs to L98 
L101:        
	.line	6
;----------------------------------------------------------------------
; 392 | return bFlag;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	7
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      4,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	393,000000000h,2


	.sect	 ".text"

	.global	_GetFirmwareVersion
	.sym	_GetFirmwareVersion,_GetFirmwareVersion,36,2,0
	.func	400
;******************************************************************************
;* FUNCTION NAME: _GetFirmwareVersion                                         *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r4,ar0,fp,ir0,sp,st                        *
;*   Regs Saved         : r4                                                  *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 3 Auto + 1 SOE = 7 words          *
;******************************************************************************
_GetFirmwareVersion:
	.sym	_nVerBuildData,-2,12,9,32
	.sym	_i,1,4,1,32
	.sym	_nVer,2,4,1,32
	.sym	_pVersionString,3,18,1,32
	.line	1
;----------------------------------------------------------------------
; 400 | int GetFirmwareVersion(UCHAR nVerBuildData)                            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
        push      r4
	.line	2
;----------------------------------------------------------------------
; 402 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 403 | int nVer = 100;                                                        
; 404 | char *pVersionString;                                                  
;----------------------------------------------------------------------
        ldiu      100,r0
        sti       r0,*+fp(2)
	.line	7
;----------------------------------------------------------------------
; 406 | for(i=0;i<128;i++)                                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        bge       L114
;*      Branch Occurs to L114 
L105:        
	.line	9
;----------------------------------------------------------------------
; 408 | pVersionString = (char *)m_pBoardIdInfo[i];                            
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL22,ar0
        ldi       *+ar0(ir0),r0
        sti       r0,*+fp(3)
	.line	10
;----------------------------------------------------------------------
; 409 | if(pVersionString == NULL) break;                                      
;----------------------------------------------------------------------
        beq       L114
;*      Branch Occurs to L114 
	.line	12
;----------------------------------------------------------------------
; 411 | if(WORD_L(nVerBuildData) == 1)                                         
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(2),r0
        cmpi      1,r0
        bne       L110
;*      Branch Occurs to L110 
	.line	14
;----------------------------------------------------------------------
; 413 | if(FirmwareVersionStrCmp("Version",pVersionString,7))                  
;----------------------------------------------------------------------
        ldiu      7,r0
        push      r0
        ldiu      *+fp(3),r1
        ldiu      @CL23,r0
        push      r1
        push      r0
        call      _FirmwareVersionStrCmp
                                        ; Call Occurs
        cmpi      0,r0
        subi      3,sp
        beq       L113
;*      Branch Occurs to L113 
	.line	16
;----------------------------------------------------------------------
; 415 | nVer = ConvAsc2Dec(pVersionString[8])*1000+ConvAsc2Dec(pVersionString[1
;     | 0])*100+ConvAsc2Dec(pVersionString[11])*10+ConvAsc2Dec(pVersionString[1
;     | 2]);                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(3),ar0
        ldiu      *+ar0(8),r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      1000,r1
        ldiu      *+fp(3),ar0
        ldiu      *+ar0(10),r2
        mpyi3     r1,r0,r4
        push      r2
        call      _ConvAsc2Dec
                                        ; Call Occurs
        ldiu      100,r1
        subi      1,sp
        ldiu      *+fp(3),ar0
        mpyi3     r1,r0,r0
        ldiu      *+ar0(11),r1
        push      r1
        addi3     r0,r4,r4
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      10,r1
        ldiu      *+fp(3),ar0
        mpyi3     r1,r0,r0
        ldiu      *+ar0(12),r1
        push      r1
        addi3     r0,r4,r4
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        addi3     r0,r4,r0
        sti       r0,*+fp(2)
	.line	17
;----------------------------------------------------------------------
; 416 | break;                                                                 
;----------------------------------------------------------------------
        bu        L114
;*      Branch Occurs to L114 
L110:        
	.line	20
;----------------------------------------------------------------------
; 419 | else if(WORD_L(nVerBuildData) == 2)                                    
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(2),r0
        cmpi      2,r0
        bne       L113
;*      Branch Occurs to L113 
	.line	22
;----------------------------------------------------------------------
; 421 | if(FirmwareVersionStrCmp("Date",pVersionString,4))                     
;----------------------------------------------------------------------
        ldiu      4,r0
        ldiu      @CL24,r1
        push      r0
        ldiu      *+fp(3),r0
        push      r0
        push      r1
        call      _FirmwareVersionStrCmp
                                        ; Call Occurs
        cmpi      0,r0
        subi      3,sp
        beq       L113
;*      Branch Occurs to L113 
	.line	24
;----------------------------------------------------------------------
; 423 | nVer = ConvAsc2Dec(pVersionString[7])*100000+ConvAsc2Dec(pVersionString
;     | [8])*10000+ConvAsc2Dec(pVersionString[10])*1000+                       
; 424 |        ConvAsc2Dec(pVersionString[11])*100+ConvAsc2Dec(pVersionString[1
;     | 3])*10+ConvAsc2Dec(pVersionString[14]);                                
;----------------------------------------------------------------------
        ldiu      *+fp(3),ar0
        ldiu      *+ar0(7),r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      @CL18,r1
        ldiu      *+fp(3),ar0
        ldiu      *+ar0(8),r2
        mpyi3     r1,r0,r4
        push      r2
        call      _ConvAsc2Dec
                                        ; Call Occurs
        ldiu      10000,r1
        subi      1,sp
        ldiu      *+fp(3),ar0
        mpyi3     r1,r0,r1
        ldiu      *+ar0(10),r0
        push      r0
        addi3     r1,r4,r4
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      1000,r1
        ldiu      *+fp(3),ar0
        mpyi3     r1,r0,r0
        ldiu      *+ar0(11),r1
        push      r1
        addi3     r0,r4,r4
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),ar0
        ldiu      100,r1
        mpyi3     r1,r0,r0
        ldiu      *+ar0(13),r2
        addi3     r0,r4,r4
        push      r2
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      10,r1
        ldiu      *+fp(3),ar0
        ldiu      *+ar0(14),r2
        push      r2
        mpyi3     r1,r0,r0
        addi3     r0,r4,r4
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        addi3     r0,r4,r0
        sti       r0,*+fp(2)
	.line	26
;----------------------------------------------------------------------
; 425 | break;                                                                 
;----------------------------------------------------------------------
        bu        L114
;*      Branch Occurs to L114 
L113:        
	.line	7
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        blt       L105
;*      Branch Occurs to L105 
L114:        
	.line	31
;----------------------------------------------------------------------
; 430 | return nVer;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	32
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      5,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	431,000000010h,3


	.sect	 ".text"

	.global	_Make1ByteBcc
	.sym	_Make1ByteBcc,_Make1ByteBcc,44,2,0
	.func	436
;******************************************************************************
;* FUNCTION NAME: _Make1ByteBcc                                               *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,ir0,st                                       *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 2 Auto + 0 SOE = 6 words          *
;******************************************************************************
_Make1ByteBcc:
	.sym	_pDat,-2,28,9,32
	.sym	_nLen,-3,4,9,32
	.sym	_i,1,4,1,32
	.sym	_btBcc,2,12,1,32
	.line	1
;----------------------------------------------------------------------
; 436 | UCHAR Make1ByteBcc(UCHAR *pDat,int nLen)                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 438 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 439 | UCHAR btBcc = 0x00;                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 440 | for(i=0;i<nLen;i++)     btBcc ^= pDat[i];                              
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        bge       L119
;*      Branch Occurs to L119 
L118:        
        ldiu      *-fp(2),ir0
        ldiu      *+fp(1),ar0
        ldiu      *+ar0(ir0),r0
        xor       *+fp(2),r0
        sti       r0,*+fp(2)
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        blt       L118
;*      Branch Occurs to L118 
L119:        
	.line	6
;----------------------------------------------------------------------
; 441 | return btBcc;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	7
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      4,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	442,000000000h,2


	.sect	 ".text"

	.global	_MakeBcc
	.sym	_MakeBcc,_MakeBcc,32,2,0
	.func	447
;******************************************************************************
;* FUNCTION NAME: _MakeBcc                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,ar1,ir0,ir1,st                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 1 Auto + 0 SOE = 5 words          *
;******************************************************************************
_MakeBcc:
	.sym	_pDat,-2,28,9,32
	.sym	_nLen,-3,4,9,32
	.sym	_i,1,4,1,32
	.line	1
;----------------------------------------------------------------------
; 447 | void MakeBcc(UCHAR *pDat,int nLen)                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
;----------------------------------------------------------------------
; 449 | int i;                                                                 
;----------------------------------------------------------------------
	.line	5
;----------------------------------------------------------------------
; 451 | pDat[nLen] = pDat[nLen+1] = 0x00;                                      
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        addi      *-fp(2),ar0           ; Unsigned
        ldiu      0,r0
        sti       r0,*+ar0(1)
        ldiu      *-fp(2),ir0
        ldiu      *-fp(3),ar0
        sti       r0,*+ar0(ir0)
	.line	7
;----------------------------------------------------------------------
; 453 | for(i=0;i<nLen;i++)     pDat[nLen + (i&0x01)] ^= pDat[i];              
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        bge       L124
;*      Branch Occurs to L124 
L123:        
        ldiu      1,ar0
        ldiu      *-fp(2),ir0
        ldiu      *+fp(1),ar1
        and       *+fp(1),ar0
        ldiu      ir0,ir1
        addi      *-fp(3),ar0
        xor3      *+ar0(ir0),*+ar1(ir1),r0
        sti       r0,*+ar0(ir0)
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        blt       L123
;*      Branch Occurs to L123 
L124:        
	.line	8
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      3,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	454,000000000h,1


	.sect	 ".text"

	.global	_IsBccOk
	.sym	_IsBccOk,_IsBccOk,36,2,0
	.func	460
;******************************************************************************
;* FUNCTION NAME: _IsBccOk                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,ar1,fp,ir0,ir1,st                      *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 3 Auto + 0 SOE = 7 words          *
;******************************************************************************
_IsBccOk:
	.sym	_pDat,-2,28,9,32
	.sym	_nLen,-3,4,9,32
	.sym	_i,1,4,1,32
	.sym	_nBCC,2,60,1,64,,2
	.line	1
;----------------------------------------------------------------------
; 460 | int IsBccOk(UCHAR *pDat,int nLen)                                      
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
	.line	2
;----------------------------------------------------------------------
; 462 | int i;                                                                 
; 463 | UCHAR nBCC[2];                                                         
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 465 | nBCC[0] = nBCC[1] = 0x00;                                              
;----------------------------------------------------------------------
        ldiu      0,r0
        ldiu      fp,ar0
        ldiu      fp,ar1
        addi      3,ar0
        addi      2,ar1
        sti       r0,*ar0
        sti       r0,*ar1
	.line	8
;----------------------------------------------------------------------
; 467 | for(i=0;i<nLen;i++)                                                    
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        ldiu      255,r1
        ldiu      1,r2
        cmpi      *-fp(3),r0
        bge       L128
;*      Branch Occurs to L128 
L127:        
	.line	10
;----------------------------------------------------------------------
; 469 | nBCC[(i&0x01)] ^= WORD_L(pDat[i]);                                     
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar1
        ldiu      fp,ir0
        ldiu      *-fp(2),ir1
        ldiu      ar1,ar0
        addi      2,ir0
        and       r2,ar0
        and3      r1,*+ar1(ir1),r0
        xor3      r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
	.line	8
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        blt       L127
;*      Branch Occurs to L127 
L128:        
	.line	13
;----------------------------------------------------------------------
; 472 | if(nBCC[0] != WORD_L(pDat[nLen]) || nBCC[1] != WORD_L(pDat[nLen+1]))   
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      255,r0
        ldiu      *-fp(2),ir0
        addi      2,ar0
        ldiu      *-fp(3),ar1
        ldiu      *ar0,r1
        and3      r0,*+ar1(ir0),r0
        cmpi3     r0,r1
        bne       L130
;*      Branch Occurs to L130 
        ldiu      fp,ar0
        ldiu      255,r0
        addi      3,ar0
        addi      *-fp(2),ar1           ; Unsigned
        ldiu      *ar0,r1
        and       *+ar1(1),r0
        cmpi3     r0,r1
        beq       L132
;*      Branch Occurs to L132 
L130:        
	.line	15
;----------------------------------------------------------------------
; 474 | return FALSE;                                                          
; 476 | else                                                                   
;----------------------------------------------------------------------
        bud       L133
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L133 
L132:        
	.line	19
;----------------------------------------------------------------------
; 478 | return TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
L133:        
	.line	21
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      5,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	480,000000000h,3


	.sect	 ".text"

	.global	_crc16_ccitt
	.sym	_crc16_ccitt,_crc16_ccitt,45,2,0
	.func	486
;******************************************************************************
;* FUNCTION NAME: _crc16_ccitt                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,st                                *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 2 Auto + 0 SOE = 6 words          *
;******************************************************************************
_crc16_ccitt:
	.sym	_buf,-2,28,9,32
	.sym	_len,-3,4,9,32
	.sym	_counter,1,13,1,32
	.sym	_crc,2,13,1,32
	.line	1
;----------------------------------------------------------------------
; 486 | WORD crc16_ccitt(UCHAR *buf, int len)                                  
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 488 | WORD counter;                                                          
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 489 | WORD crc = 0xFFFF;                                                     
;----------------------------------------------------------------------
        ldiu      @CL25,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 490 | for( counter = 0; counter < len; counter++)                            
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        bhs       L137
;*      Branch Occurs to L137 
L136:        
	.line	6
;----------------------------------------------------------------------
; 491 | crc = (crc<<8) ^ crc16tab[((crc>>8)^buf[counter])&0x00FF];             
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        ldiu      *-fp(2),ir0
        ldiu      *+fp(1),ar0
        ldiu      r0,r1
        ldiu      @CL26,ar1
        lsh       -8,r0
        xor3      r0,*+ar0(ir0),ir0
        and       255,ir0
        ash       8,r1
        xor3      r1,*+ar1(ir0),r0
        sti       r0,*+fp(2)
	.line	5
        ldiu      1,r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        blo       L136
;*      Branch Occurs to L136 
L137:        
	.line	7
;----------------------------------------------------------------------
; 492 | return crc;                                                            
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	8
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      4,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	493,000000000h,2



	.sect	".cinit"
	.field  	IR_3,32
	.field  	.init0$1+0,32
	.field  	31,32		; .init0$1[0] @ 0
	.field  	28,32		; .init0$1[1] @ 32
	.field  	31,32		; .init0$1[2] @ 64
	.field  	30,32		; .init0$1[3] @ 96
	.field  	31,32		; .init0$1[4] @ 128
	.field  	30,32		; .init0$1[5] @ 160
	.field  	31,32		; .init0$1[6] @ 192
	.field  	31,32		; .init0$1[7] @ 224
	.field  	30,32		; .init0$1[8] @ 256
	.field  	31,32		; .init0$1[9] @ 288
	.field  	30,32		; .init0$1[10] @ 320
	.field  	31,32		; .init0$1[11] @ 352
IR_3:	.set	12

	.sect	".text"
	.sect	 ".text"

	.global	_gm_SysTimeToRtc
	.sym	_gm_SysTimeToRtc,_gm_SysTimeToRtc,36,2,0
	.func	499
;******************************************************************************
;* FUNCTION NAME: _gm_SysTimeToRtc                                            *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,ar1,fp,ir0,st,rs,re,rc                 *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 19 Auto + 0 SOE = 23 words        *
;******************************************************************************
_gm_SysTimeToRtc:
	.sym	_pTime,-2,24,9,32,.fake7
	.sym	_nSysTime,-3,14,9,32
	.bss	.init0$1,12
	.sym	.init0$1,.init0$1,52,3,384,,12
	.sym	_bSec,1,4,1,32
	.sym	_days,2,52,1,384,,12
	.sym	_nTemp,14,4,1,32
	.sym	_nDays,15,14,1,32
	.sym	_nTotalSecond,16,14,1,32
	.sym	_nFrontSec,17,14,1,32
	.sym	_nRearSec,18,14,1,32
	.sym	_nBaseYear,19,4,1,32
	.line	1
;----------------------------------------------------------------------
; 499 | BOOL gm_SysTimeToRtc(DATE_TIME_PTR pTime,UINT nSysTime)                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      19,sp
	.line	2
;----------------------------------------------------------------------
; 501 | BOOL bSec;                                                             
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 502 | int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };       
; 503 | int nTemp;                                                             
;----------------------------------------------------------------------
        ldiu      @CL27,ar1
        ldiu      fp,ar0
        addi      2,ar0
        ldiu      *ar1++(1),r0
        rpts      10                    ; Fast MEMCPY(#3)
        sti       r0,*ar0++(1)
||      ldi       *ar1++(1),r0
        sti       r0,*ar0++(1)
	.line	6
;----------------------------------------------------------------------
; 504 | unsigned int nDays,nTotalSecond = nSysTime,nFrontSec,nRearSec;         
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        sti       r0,*+fp(16)
	.line	7
;----------------------------------------------------------------------
; 505 | int nBaseYear = 2000;                                                  
;----------------------------------------------------------------------
        ldiu      2000,r0
        sti       r0,*+fp(19)
	.line	9
;----------------------------------------------------------------------
; 507 | bSec = FALSE;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 508 | nRearSec = nFrontSec = 0;                                              
;----------------------------------------------------------------------
        sti       r0,*+fp(17)
        sti       r0,*+fp(18)
	.line	11
;----------------------------------------------------------------------
; 509 | for(nTemp = nBaseYear; nTemp <= 2245 ;nTemp++)                         
;----------------------------------------------------------------------
        ldiu      *+fp(19),r0
        sti       r0,*+fp(14)
        cmpi      2245,r0
        bgt       L149
;*      Branch Occurs to L149 
L141:        
	.line	13
;----------------------------------------------------------------------
; 511 | nDays = 365;                                                           
;----------------------------------------------------------------------
        ldiu      365,r0
        sti       r0,*+fp(15)
	.line	14
;----------------------------------------------------------------------
; 512 | if((!(nTemp % 4) && (nTemp % 100)) || !(nTemp % 400)) nDays += 1;      
;----------------------------------------------------------------------
        ldiu      *+fp(14),r0
        ldiu      r0,r1
        ash       -1,r1
        lsh       @CL28,r1
        addi3     r1,r0,r1
        andn      3,r1
        subri     r0,r1
        bne       L143
;*      Branch Occurs to L143 
        ldiu      100,r1
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L144
;*      Branch Occurs to L144 
L143:        
        ldiu      *+fp(14),r0
        ldiu      400,r1
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L145
;*      Branch Occurs to L145 
L144:        
        ldiu      1,r0
        addi      *+fp(15),r0           ; Unsigned
        sti       r0,*+fp(15)
L145:        
	.line	15
;----------------------------------------------------------------------
; 513 | nRearSec = nFrontSec;                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(17),r0
        sti       r0,*+fp(18)
	.line	16
;----------------------------------------------------------------------
; 514 | nFrontSec += nDays*24*60*60;                                           
;----------------------------------------------------------------------
        ldiu      *+fp(15),r0
        mpyi      24,r0
        mpyi      60,r0
        mpyi      60,r0
        addi      *+fp(17),r0           ; Unsigned
        sti       r0,*+fp(17)
	.line	17
;----------------------------------------------------------------------
; 515 | if(ISRANGE_LOW(nTotalSecond,nRearSec,nFrontSec))                       
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        cmpi      *+fp(18),r0
        blo       L148
;*      Branch Occurs to L148 
        cmpi      *+fp(17),r0
        bhs       L148
;*      Branch Occurs to L148 
	.line	19
;----------------------------------------------------------------------
; 517 | pTime->year = BIN2BCD(nTemp-nBaseYear);                                
;----------------------------------------------------------------------
        ldiu      *+fp(19),r0
        subri     *+fp(14),r0
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      *+fp(19),r0
        ash       4,r2
        subri     *+fp(14),r0
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      *-fp(2),ar0
        or3       r2,r0,r0
        sti       r0,*+ar0(5)
	.line	20
;----------------------------------------------------------------------
; 518 | nTotalSecond -= nRearSec;                                              
;----------------------------------------------------------------------
        ldiu      *+fp(18),r0
        subri     *+fp(16),r0           ; Unsigned
        sti       r0,*+fp(16)
	.line	21
;----------------------------------------------------------------------
; 519 | bSec = TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(1)
	.line	22
;----------------------------------------------------------------------
; 520 | break;                                                                 
;----------------------------------------------------------------------
        bu        L149
;*      Branch Occurs to L149 
L148:        
	.line	11
        ldiu      1,r0
        addi      *+fp(14),r0
        sti       r0,*+fp(14)
        cmpi      2245,r0
        ble       L141
;*      Branch Occurs to L141 
L149:        
	.line	26
;----------------------------------------------------------------------
; 524 | if(!bSec) return FALSE;                                                
;----------------------------------------------------------------------
        ldi       *+fp(1),r0
        bne       L151
;*      Branch Occurs to L151 
        bud       L161
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L161 
L151:        
	.line	28
;----------------------------------------------------------------------
; 526 | bSec = FALSE;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	29
;----------------------------------------------------------------------
; 527 | nDays = 0;                                                             
;----------------------------------------------------------------------
        sti       r0,*+fp(15)
	.line	30
;----------------------------------------------------------------------
; 528 | nRearSec = nFrontSec = 0;                                              
;----------------------------------------------------------------------
        sti       r0,*+fp(17)
        sti       r0,*+fp(18)
	.line	31
;----------------------------------------------------------------------
; 529 | for(nTemp=0;nTemp<11;nTemp++)                                          
;----------------------------------------------------------------------
        sti       r0,*+fp(14)
        cmpi      11,r0
        bge       L156
;*      Branch Occurs to L156 
L152:        
	.line	33
;----------------------------------------------------------------------
; 531 | nDays += days[nTemp];                                                  
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      *+fp(14),ir0
        addi      2,ar0
        ldiu      *+ar0(ir0),r0
        addi      *+fp(15),r0           ; Unsigned
        sti       r0,*+fp(15)
	.line	34
;----------------------------------------------------------------------
; 532 | nRearSec = nFrontSec;                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(17),r0
        sti       r0,*+fp(18)
	.line	35
;----------------------------------------------------------------------
; 533 | nFrontSec = nDays*24*60*60;                                            
;----------------------------------------------------------------------
        ldiu      *+fp(15),r0
        mpyi      24,r0
        mpyi      60,r0
        mpyi      60,r0
        sti       r0,*+fp(17)
	.line	36
;----------------------------------------------------------------------
; 534 | if(ISRANGE_LOW(nTotalSecond,nRearSec,nFrontSec))                       
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        cmpi      *+fp(18),r0
        blo       L155
;*      Branch Occurs to L155 
        cmpi      *+fp(17),r0
        bhs       L155
;*      Branch Occurs to L155 
	.line	38
;----------------------------------------------------------------------
; 536 | pTime->month = BIN2BCD(nTemp+1);                                       
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      *+fp(14),r0
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      1,r1
        ash       4,r2
        addi      *+fp(14),r1
        ldiu      r1,r0
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      *-fp(2),ar0
        or3       r2,r0,r0
        sti       r0,*+ar0(4)
	.line	39
;----------------------------------------------------------------------
; 537 | nTotalSecond -= nRearSec;                                              
;----------------------------------------------------------------------
        ldiu      *+fp(18),r0
        subri     *+fp(16),r0           ; Unsigned
        sti       r0,*+fp(16)
	.line	40
;----------------------------------------------------------------------
; 538 | bSec = TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(1)
	.line	41
;----------------------------------------------------------------------
; 539 | break;                                                                 
;----------------------------------------------------------------------
        bu        L156
;*      Branch Occurs to L156 
L155:        
	.line	31
        ldiu      1,r0
        addi      *+fp(14),r0
        sti       r0,*+fp(14)
        cmpi      11,r0
        blt       L152
;*      Branch Occurs to L152 
L156:        
	.line	45
;----------------------------------------------------------------------
; 543 | if(!bSec) return FALSE;                                                
;----------------------------------------------------------------------
        ldi       *+fp(1),r0
        bned      L159
	nop
        ldine     *+fp(16),r0
        ldine     @CL29,r1
;*      Branch Occurs to L159 
        bud       L161
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L161 
	.line	47
;----------------------------------------------------------------------
; 545 | nTemp = nTotalSecond/(24*60*60);                                       
;----------------------------------------------------------------------
L159:        
        call      DIV_U30
                                        ; Call Occurs
        sti       r0,*+fp(14)
	.line	48
;----------------------------------------------------------------------
; 546 | pTime->day = BIN2BCD(nTemp+1);                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      *+fp(14),r0
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      1,r1
        ash       4,r2
        addi      *+fp(14),r1
        ldiu      r1,r0
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      *-fp(2),ar0
        or3       r2,r0,r0
        sti       r0,*+ar0(3)
	.line	49
;----------------------------------------------------------------------
; 547 | nTotalSecond %= (24*60*60);                                            
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        ldiu      @CL29,r1
        call      MOD_U30
                                        ; Call Occurs
        sti       r0,*+fp(16)
	.line	51
;----------------------------------------------------------------------
; 549 | nTemp = nTotalSecond/(60*60);                                          
;----------------------------------------------------------------------
        ldiu      3600,r1
        call      DIV_U30
                                        ; Call Occurs
        sti       r0,*+fp(14)
	.line	52
;----------------------------------------------------------------------
; 550 | pTime->hour = BIN2BCD(nTemp);                                          
;----------------------------------------------------------------------
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      10,r1
        ldiu      *+fp(14),r0
        ash       4,r2
        call      MOD_I30
                                        ; Call Occurs
        ldiu      *-fp(2),ar0
        or3       r2,r0,r0
        sti       r0,*+ar0(2)
	.line	53
;----------------------------------------------------------------------
; 551 | nTotalSecond %= (60*60);                                               
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        ldiu      3600,r1
        call      MOD_U30
                                        ; Call Occurs
        sti       r0,*+fp(16)
	.line	55
;----------------------------------------------------------------------
; 553 | nTemp = nTotalSecond/60;                                               
;----------------------------------------------------------------------
        ldiu      60,r1
        call      DIV_U30
                                        ; Call Occurs
        sti       r0,*+fp(14)
	.line	56
;----------------------------------------------------------------------
; 554 | pTime->minute = BIN2BCD(nTemp);                                        
;----------------------------------------------------------------------
        ldiu      10,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      *+fp(14),r0
        ldiu      10,r1
        ash       4,r2
        call      MOD_I30
                                        ; Call Occurs
        ldiu      *-fp(2),ar0
        or3       r2,r0,r0
        sti       r0,*+ar0(1)
	.line	57
;----------------------------------------------------------------------
; 555 | nTotalSecond %= 60;                                                    
;----------------------------------------------------------------------
        ldiu      60,r1
        ldiu      *+fp(16),r0
        call      MOD_U30
                                        ; Call Occurs
        sti       r0,*+fp(16)
	.line	59
;----------------------------------------------------------------------
; 557 | pTime->second = BIN2BCD(nTotalSecond);                                 
;----------------------------------------------------------------------
        ldiu      10,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      10,r1
        ash       4,r2
        ldiu      *+fp(16),r0
        call      MOD_U30
                                        ; Call Occurs
        ldiu      *-fp(2),ar0
        or3       r2,r0,r0
        sti       r0,*ar0
	.line	61
;----------------------------------------------------------------------
; 559 | return TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
L161:        
	.line	62
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      21,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	560,000000000h,19


	.sect	 ".text"

	.global	_Delay
	.sym	_Delay,_Delay,36,2,0
	.func	566
;******************************************************************************
;* FUNCTION NAME: _Delay                                                      *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,st                                     *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 1 Parm + 0 Auto + 0 SOE = 3 words          *
;******************************************************************************
_Delay:
	.sym	_nCnt,-2,4,9,32
	.line	1
;----------------------------------------------------------------------
; 566 | int Delay(int nCnt)                                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 568 | while(nCnt--) WDI_ACT;                                                 
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *-fp(2),r0
        subri     r0,r1
        cmpi      0,r0
        beqd      L165
        ldiu      0,r2
        ldiu      8192,ar0
        sti       r1,*-fp(2)
;*      Branch Occurs to L165 
L164:        
        sti       r2,*ar0
        ldiu      1,r1
        ldiu      *-fp(2),r0
        subri     r0,r1
        cmpi      0,r0
        sti       r1,*-fp(2)
        bne       L164
;*      Branch Occurs to L164 
L165:        
	.line	4
;----------------------------------------------------------------------
; 569 | return 0;                                                              
;----------------------------------------------------------------------
        ldiu      0,r0
	.line	5
        ldiu      *-fp(1),ar0
        ldiu      *fp,fp
        subi      2,sp
        bu        ar0
;*      Branch Occurs to ar0 
	.endfunc	570,000000000h,0



	.sect	".cinit"
	.field  	1,32
	.field  	_nInt_01_Cnt+0,32
	.field  	0,32		; _nInt_01_Cnt @ 0

	.sect	".text"

	.global	_nInt_01_Cnt
	.bss	_nInt_01_Cnt,1
	.sym	_nInt_01_Cnt,_nInt_01_Cnt,12,2,32
	.sect	 ".text"

	.global	_c_int02
	.sym	_c_int02,_c_int02,32,2,0
	.func	576
;******************************************************************************
;* FUNCTION NAME: _c_int02                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0                                                  *
;*   Regs Saved         : f0,r0,f1,r1,f2,r2,f3,r3,f4,r4,f5,r5,f6,r6,f7,r7,ar0,*
;*                        ar1,ar2,ir0,ir1,bk,sp,rs,re,rc,pc                   *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 25 SOE = 27 words        *
;******************************************************************************
_c_int02:
	.line	1
;----------------------------------------------------------------------
; 576 | void c_int02()                                                         
;----------------------------------------------------------------------
        push      st
        push      fp
        ldiu      sp,fp
        push      r0
        pushf     f0
        push      r1
        pushf     f1
        push      r2
        pushf     f2
        push      r3
        pushf     f3
        push      ar0
        push      ar1
        push      ar2
        push      ir0
        push      ir1
        push      rs
        push      re
        push      rc
        push      r4
        pushf     f4
        push      r5
        pushf     f5
        push      r6
        pushf     f6
        push      r7
        pushf     f7
        push      bk
        andn      256,st                ; Disable any existing repeat loops
	.line	3
;----------------------------------------------------------------------
; 578 | xr16l784_Isr();                                                        
;----------------------------------------------------------------------
        call      _xr16l784_Isr
                                        ; Call Occurs
	.line	4
;----------------------------------------------------------------------
; 579 | nInt_01_Cnt++;                                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_nInt_01_Cnt+0,r0    ; Unsigned
        sti       r0,@_nInt_01_Cnt+0
	.line	6
        pop       bk
        popf      f7
        pop       r7
        popf      f6
        pop       r6
        popf      f5
        pop       r5
        popf      f4
        pop       r4
        pop       rc
        pop       re
        pop       rs
        pop       ir1
        pop       ir0
        pop       ar2
        pop       ar1
        pop       ar0
        popf      f3
        pop       r3
        popf      f2
        pop       r2
        popf      f1
        pop       r1
        popf      f0
        pop       r0
        pop       fp
        pop       st
        reti
                                        	; Return From Interrupt
	.endfunc	581,0003f07ffh,0



	.sect	".cinit"
	.field  	1,32
	.field  	_nInt_02_Cnt+0,32
	.field  	0,32		; _nInt_02_Cnt @ 0

	.sect	".text"

	.global	_nInt_02_Cnt
	.bss	_nInt_02_Cnt,1
	.sym	_nInt_02_Cnt,_nInt_02_Cnt,12,2,32
	.sect	 ".text"

	.global	_c_int03
	.sym	_c_int03,_c_int03,32,2,0
	.func	587
;******************************************************************************
;* FUNCTION NAME: _c_int03                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0                                                  *
;*   Regs Saved         : f0,r0,f1,r1,f2,r2,f3,r3,f4,r4,f5,r5,f6,r6,f7,r7,ar0,*
;*                        ar1,ar2,ir0,ir1,bk,sp,rs,re,rc,pc                   *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 25 SOE = 27 words        *
;******************************************************************************
_c_int03:
	.line	1
;----------------------------------------------------------------------
; 587 | void c_int03()                                                         
;----------------------------------------------------------------------
        push      st
        push      fp
        ldiu      sp,fp
        push      r0
        pushf     f0
        push      r1
        pushf     f1
        push      r2
        pushf     f2
        push      r3
        pushf     f3
        push      ar0
        push      ar1
        push      ar2
        push      ir0
        push      ir1
        push      rs
        push      re
        push      rc
        push      r4
        pushf     f4
        push      r5
        pushf     f5
        push      r6
        pushf     f6
        push      r7
        pushf     f7
        push      bk
        andn      256,st                ; Disable any existing repeat loops
	.line	3
;----------------------------------------------------------------------
; 589 | LonWorkRead();                                                         
;----------------------------------------------------------------------
        call      _LonWorkRead
                                        ; Call Occurs
	.line	4
;----------------------------------------------------------------------
; 590 | nInt_02_Cnt++;                                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_nInt_02_Cnt+0,r0    ; Unsigned
        sti       r0,@_nInt_02_Cnt+0
	.line	5
        pop       bk
        popf      f7
        pop       r7
        popf      f6
        pop       r6
        popf      f5
        pop       r5
        popf      f4
        pop       r4
        pop       rc
        pop       re
        pop       rs
        pop       ir1
        pop       ir0
        pop       ar2
        pop       ar1
        pop       ar0
        popf      f3
        pop       r3
        popf      f2
        pop       r2
        popf      f1
        pop       r1
        popf      f0
        pop       r0
        pop       fp
        pop       st
        reti
                                        	; Return From Interrupt
	.endfunc	591,0003f07ffh,0



	.sect	".cinit"
	.field  	1,32
	.field  	_nRunLedCnt$2+0,32
	.field  	0,32		; _nRunLedCnt$2 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_c_int10
	.sym	_c_int10,_c_int10,32,2,0
	.func	596
;******************************************************************************
;* FUNCTION NAME: _c_int10                                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,ar1,st                                       *
;*   Regs Saved         : f0,r0,f1,r1,f2,r2,f3,r3,f4,r4,f5,r5,f6,r6,f7,r7,ar0,*
;*                        ar1,ar2,ir0,ir1,bk,sp,rs,re,rc,pc                   *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 25 SOE = 27 words        *
;******************************************************************************
_c_int10:
	.bss	_nRunLedCnt$2,1
	.sym	_nRunLedCnt,_nRunLedCnt$2,4,3,32
	.line	1
;----------------------------------------------------------------------
; 596 | void c_int10(void)                                                     
; 598 | static int nRunLedCnt=0;                                               
;----------------------------------------------------------------------
        push      st
        push      fp
        ldiu      sp,fp
        push      r0
        pushf     f0
        push      r1
        pushf     f1
        push      r2
        pushf     f2
        push      r3
        pushf     f3
        push      ar0
        push      ar1
        push      ar2
        push      ir0
        push      ir1
        push      rs
        push      re
        push      rc
        push      r4
        pushf     f4
        push      r5
        pushf     f5
        push      r6
        pushf     f6
        push      r7
        pushf     f7
        push      bk
        andn      256,st                ; Disable any existing repeat loops
	.line	5
;----------------------------------------------------------------------
; 600 | xr16l784_1msLoop();                                                    
;----------------------------------------------------------------------
        call      _xr16l784_1msLoop
                                        ; Call Occurs
	.line	6
;----------------------------------------------------------------------
; 601 | user_1msLoop();                                                        
;----------------------------------------------------------------------
        call      _user_1msLoop
                                        ; Call Occurs
	.line	7
;----------------------------------------------------------------------
; 602 | LonInfo_1msLoop();                                                     
;----------------------------------------------------------------------
        call      _LonInfo_1msLoop
                                        ; Call Occurs
	.line	8
;----------------------------------------------------------------------
; 603 | Debug_1msLoop();                                                       
;----------------------------------------------------------------------
        call      _Debug_1msLoop
                                        ; Call Occurs
	.line	10
;----------------------------------------------------------------------
; 605 | m_nDebug1msTimer++;                                                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nDebug1msTimer+0,r0 ; Unsigned
        sti       r0,@_m_nDebug1msTimer+0
	.line	12
;----------------------------------------------------------------------
; 607 | WDI_ACT;                                                               
;----------------------------------------------------------------------
        ldiu      8192,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	14
;----------------------------------------------------------------------
; 609 | RUN_LED(nRunLedCnt&0x20 ? 1 : 0);                                      
;----------------------------------------------------------------------
        ldiu      32,r0
        tstb      @_nRunLedCnt$2+0,r0
        beqd      L177
        ldieq     2,r0
        ldieq     @CL30,ar1
        ldieq     @CL30,ar0
;*      Branch Occurs to L177 
        ldiu      1,r0
        ldiu      @CL30,ar1
        ldiu      @CL30,ar0
        and3      r0,*ar1,r0
        sti       r0,*ar0
        bu        L179
;*      Branch Occurs to L179 
	.line	14
L177:        
        or3       r0,*ar1,r0
        sti       r0,*ar0
	.line	15
;----------------------------------------------------------------------
; 610 | ERR_LED(0);                                                            
;----------------------------------------------------------------------
        bu        L179
;*      Branch Occurs to L179 
L179:        
	.line	15
        ldiu      1,r0
        ldiu      @CL30,ar1
        ldiu      @CL30,ar0
        or3       r0,*ar1,r0
        sti       r0,*ar0
	.line	17
;----------------------------------------------------------------------
; 612 | nRunLedCnt++;                                                          
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_nRunLedCnt$2+0,r0
        sti       r0,@_nRunLedCnt$2+0
	.line	18
        pop       bk
        popf      f7
        pop       r7
        popf      f6
        pop       r6
        popf      f5
        pop       r5
        popf      f4
        pop       r4
        pop       rc
        pop       re
        pop       rs
        pop       ir1
        pop       ir0
        pop       ar2
        pop       ar1
        pop       ar0
        popf      f3
        pop       r3
        popf      f2
        pop       r2
        popf      f1
        pop       r1
        popf      f0
        pop       r0
        pop       fp
        pop       st
        reti
                                        	; Return From Interrupt
	.endfunc	613,0003f07ffh,0


;******************************************************************************
;* STRINGS                                                                    *
;******************************************************************************
	.sect	".const"
SL1:	.byte	"Firmware:LIC-C3",0
SL2:	.byte	"Version:1.105",0
SL3:	.byte	"Date:2018/04/10",0
SL4:	.byte	"[TX:%02d] ",0
SL5:	.byte	"%02X ",0
SL6:	.byte	13,10,0
SL7:	.byte	"Version",0
SL8:	.byte	"Date",0
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

	.sect	".cinit"
	.field  	30,32
	.field  	CL1+0,32
	.field  	38400,32
	.field  	8433664,32
	.field  	8421476,32
	.field  	8421408,32
	.field  	8421416,32
	.field  	8429506,32
	.field  	1610612736,32
	.field  	_c_int02,32
	.field  	8429507,32
	.field  	_c_int03,32
	.field  	8429513,32
	.field  	_c_int10,32
	.field  	1048576,32
	.field  	1000000000,32
	.field  	100000000,32
	.field  	10000000,32
	.field  	1000000,32
	.field  	100000,32
	.field  	SL4,32
	.field  	SL5,32
	.field  	SL6,32
	.field  	_m_pBoardIdInfo,32
	.field  	SL7,32
	.field  	SL8,32
	.field  	65535,32
	.field  	_crc16tab,32
	.field  	.init0$1,32
	.field  	-30,32
	.field  	86400,32
	.field  	2097152,32

	.sect	".text"
;******************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                              *
;******************************************************************************

	.global	_sprintf

	.global	_vsprintf

	.global	_strcat

	.global	_strlen

	.global	_Debug_1msLoop

	.global	_xr16l784_Send

	.global	_xr16l784_Loop

	.global	_xr16l784_Rts

	.global	_xr16l784_Isr

	.global	_LonWorkRead

	.global	_xr16l784_Init

	.global	_xr16l784_1msLoop

	.global	_LonInfo_1msLoop

	.global	_user_Init

	.global	_user_Loop

	.global	_user_DebugPrint

	.global	_user_1msLoop
	.global	_Debug3xInit
	.global	MOD_I30
	.global	DIV_I30
	.global	DIV_U30
	.global	MOD_U30
