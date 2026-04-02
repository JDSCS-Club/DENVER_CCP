;******************************************************************************
;* TMS320C3x/4x ANSI C Code Generator                            Version 5.11 *
;* Date/Time created: Sat Sep 19 09:27:37 2015                                *
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
;	c:\lang\tms320c3x\511\bin\ac30.exe mpudebug.c C:\Users\JANGDU~1\AppData\Local\Temp\mpudebug.if 
	.file	"mpudebug.c"
	.file	"def.h"
	.sym	_WORD,0,13,13,32
	.sym	_USHORT,0,13,13,32
	.sym	_BYTE,0,12,13,32
	.sym	_UCHAR,0,12,13,32
	.sym	_UINT,0,14,13,32
	.sym	_BOOL,0,4,13,32
	.sym	_DWORD,0,15,13,32
	.file	"ds1647.h"
	.stag	.fake1,32
	.member	_R,6,4,18,1
	.member	_W,7,4,18,1
	.eos
	.stag	.fake2,32
	.member	_Sec,0,4,18,7
	.member	_Osc,7,4,18,1
	.eos
	.stag	.fake3,32
	.member	_Day,0,4,18,3
	.member	_SPare2,3,4,18,3
	.member	_FT,6,4,18,1
	.member	_Spare1,7,4,18,1
	.eos
	.utag	.fake0,32
	.member	_CtrlBit,0,8,11,32,.fake1
	.member	_SecBit,0,8,11,32,.fake2
	.member	_DayBit,0,8,11,32,.fake3
	.member	_B8,0,12,11,32
	.eos
	.sym	_DS1647ONELTP,0,9,13,32,.fake0
	.sym	_PDS1647ONELTP,0,25,13,32,.fake0
	.stag	.fake4,256
	.member	_Ctrl,0,9,8,32,.fake0
	.member	_Second,32,9,8,32,.fake0
	.member	_Minute,64,9,8,32,.fake0
	.member	_Hour,96,9,8,32,.fake0
	.member	_Day,128,9,8,32,.fake0
	.member	_Date,160,9,8,32,.fake0
	.member	_Month,192,9,8,32,.fake0
	.member	_Year,224,9,8,32,.fake0
	.eos
	.sym	_DS1647BDY,0,8,13,256,.fake4
	.sym	_PDS1647BDY,0,24,13,32,.fake4
	.stag	.fake5,224
	.member	_second,0,12,8,32
	.member	_minute,32,12,8,32
	.member	_hour,64,12,8,32
	.member	_day,96,12,8,32
	.member	_month,128,12,8,32
	.member	_year,160,12,8,32
	.member	_weekday,192,12,8,32
	.eos
	.sym	_DATE_TIME_TYPE,0,8,13,224,.fake5
	.sym	_DATE_TIME_PTR,0,24,13,32,.fake5
	.file	"main.h"
	.file	"user.h"
	.stag	.fake6,6400
	.member	_btStx,0,12,8,32
	.member	_btCmd,32,12,8,32
	.member	_btMessCode,64,12,8,32
	.member	_btLen,96,12,8,32
	.member	_btDat,128,60,8,6272,,196
	.eos
	.sym	_LNWKFTPIT,0,8,13,6400,.fake6
	.sym	_PLNWKFTPIT,0,24,13,32,.fake6
	.stag	.fake7,6400
	.member	_btStx,0,12,8,32
	.member	_btCmd,32,12,8,32
	.member	_btMessCode,64,12,8,32
	.member	_btLen,96,12,8,32
	.member	_btDat,128,60,8,6272,,196
	.eos
	.sym	_LNWKGERIT,0,8,13,6400,.fake7
	.sym	_PLNWKGERIT,0,24,13,32,.fake7
	.stag	.fake8,51712
	.member	_btKind,0,12,8,32
	.member	_btVerH,32,12,8,32
	.member	_btVerL,64,12,8,32
	.member	_btBuildDateHH,96,12,8,32
	.member	_btBuildDateHL,128,12,8,32
	.member	_btBuildDateLH,160,12,8,32
	.member	_btBuildDateLL,192,12,8,32
	.member	_btSpare,224,60,8,288,,9
	.member	_lfBuf,512,56,8,38400,.fake6,6
	.member	_lgRxBuf,38912,8,8,6400,.fake7
	.member	_lgTxBuf,45312,8,8,6400,.fake7
	.eos
	.sym	_LNWKDP,0,8,13,51712,.fake8
	.sym	_PLNWKDP,0,24,13,32,.fake8
	.stag	.fake9,352
	.member	_btSoh,0,12,8,32
	.member	_chSrcDev,32,60,8,64,,2
	.member	_chDestDev,96,60,8,64,,2
	.member	_chMsgCnt,160,60,8,64,,2
	.member	_chCmdCode,224,60,8,64,,2
	.member	_chDataLen,288,60,8,64,,2
	.eos
	.sym	_PTCHD,0,8,13,352,.fake9
	.sym	_PPTCHD,0,24,13,32,.fake9
	.stag	.fake10,768
	.member	_chPacT,0,60,8,64,,2
	.member	_chCcpM,64,60,8,64,,2
	.member	_chCncsT,128,60,8,64,,2
	.member	_chD0,192,60,8,64,,2
	.member	_chD1,256,60,8,64,,2
	.member	_chTran,320,252,8,192,,3,2
	.member	_chCid,512,252,8,192,,3,2
	.member	_chDs,704,60,8,64,,2
	.eos
	.sym	_PROTOCOL_1,0,8,13,768,.fake10
	.stag	.fake11,576
	.member	_phHdBuf,0,8,8,352,.fake9
	.member	_nDdata,352,60,8,64,,2
	.member	_nCRC,416,60,8,128,,4
	.member	_btEot,544,12,8,32
	.eos
	.sym	_PACSDR,0,8,13,576,.fake11
	.sym	_PPACSDR,0,24,13,32,.fake11
	.stag	.fake14,32
	.member	_sACab_ON,0,14,18,1
	.member	_sASp_1,1,14,18,1
	.member	_sASp_2,2,14,18,1
	.member	_sAHead_Bit,3,14,18,1
	.member	_sBCab_ON,4,14,18,1
	.member	_sBSp_1,5,14,18,1
	.member	_sBSp_2,6,14,18,1
	.member	_sBHead_Bit,7,14,18,1
	.eos
	.utag	.fake13,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake14
	.eos
	.stag	.fake16,32
	.member	_sAWLR,0,14,18,1
	.member	_sAGPS,1,14,18,1
	.member	_sAVOIP,2,14,18,1
	.member	_sACCP1,3,14,18,1
	.member	_sBWLR,4,14,18,1
	.member	_sBGPS,5,14,18,1
	.member	_sBVOIP,6,14,18,1
	.member	_sBCCP1,7,14,18,1
	.eos
	.utag	.fake15,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake16
	.eos
	.stag	.fake18,32
	.member	_sACNCS,0,14,18,1
	.member	_sAVTX,1,14,18,1
	.member	_sALIC,2,14,18,1
	.member	_sAPAC,3,14,18,1
	.member	_sBCNCS,4,14,18,1
	.member	_sBVTX,5,14,18,1
	.member	_sBLIC,6,14,18,1
	.member	_sBPAC,7,14,18,1
	.eos
	.utag	.fake17,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake18
	.eos
	.stag	.fake20,32
	.member	_sAPII2,0,14,18,1
	.member	_sAPII1,1,14,18,1
	.member	_sAFDI,2,14,18,1
	.member	_sASp_3,3,14,18,1
	.member	_sBPII2,4,14,18,1
	.member	_sBPII1,5,14,18,1
	.member	_sBFDI,6,14,18,1
	.member	_sBSp_3,7,14,18,1
	.eos
	.utag	.fake19,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake20
	.eos
	.stag	.fake22,32
	.member	_sASDI4,0,14,18,1
	.member	_sASDI3,1,14,18,1
	.member	_sASDI2,2,14,18,1
	.member	_sASDI1,3,14,18,1
	.member	_sBSDI4,4,14,18,1
	.member	_sBSDI3,5,14,18,1
	.member	_sBSDI2,6,14,18,1
	.member	_sBSDI1,7,14,18,1
	.eos
	.utag	.fake21,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake22
	.eos
	.stag	.fake24,32
	.member	_sAPID1_4,0,14,18,1
	.member	_sAPID1_3,1,14,18,1
	.member	_sAPID1_2,2,14,18,1
	.member	_sAPID1_1,3,14,18,1
	.member	_sBPID1_4,4,14,18,1
	.member	_sBPID1_3,5,14,18,1
	.member	_sBPID1_2,6,14,18,1
	.member	_sBPID1_1,7,14,18,1
	.eos
	.utag	.fake23,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake24
	.eos
	.stag	.fake26,32
	.member	_sAPEI1,0,14,18,1
	.member	_sAPEI2,1,14,18,1
	.member	_sASp_3,2,14,18,1
	.member	_sAPID2_1,3,14,18,1
	.member	_sBPEI1,4,14,18,1
	.member	_sBPEI2,5,14,18,1
	.member	_sBSp_3,6,14,18,1
	.member	_sBPID2_1,7,14,18,1
	.eos
	.utag	.fake25,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake26
	.eos
	.stag	.fake28,32
	.member	_sAPEI1_Call,0,14,18,1
	.member	_sAPEI2_Call,1,14,18,1
	.member	_sASp_2,2,14,18,1
	.member	_sASp_3,3,14,18,1
	.member	_sBPEI1_Call,4,14,18,1
	.member	_sBPEI2_Call,5,14,18,1
	.member	_sBSp_2,6,14,18,1
	.member	_sBSp_3,7,14,18,1
	.eos
	.utag	.fake27,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake28
	.eos
	.stag	.fake30,32
	.member	_sADPO,0,14,18,1
	.member	_sASp_2,1,14,18,1
	.member	_sASp_3,2,14,18,1
	.member	_sADPH,3,14,18,1
	.member	_sBDPO,4,14,18,1
	.member	_sBSp_2,5,14,18,1
	.member	_sBSp_3,6,14,18,1
	.member	_sBDPH,7,14,18,1
	.eos
	.utag	.fake29,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake30
	.eos
	.stag	.fake12,352
	.member	_CRA_1,0,9,8,32,.fake13
	.member	_CRA_2,32,9,8,32,.fake15
	.member	_CRA_3,64,9,8,32,.fake17
	.member	_CRA_4,96,9,8,32,.fake19
	.member	_CRA_5,128,9,8,32,.fake21
	.member	_CRA_6,160,9,8,32,.fake23
	.member	_CRA_7,192,9,8,32,.fake25
	.member	_CRA_8,224,9,8,32,.fake27
	.member	_CRA_9,256,9,8,32,.fake29
	.member	_CarNum_H,288,12,8,32
	.member	_CarNum_L,320,12,8,32
	.eos
	.sym	_CRA_STATION,0,8,13,352,.fake12
	.sym	_PCRA_STATION,0,24,13,32,.fake12
	.stag	.fake31,704
	.member	_sUnitStat,0,252,8,576,,9,2
	.member	_sCarNumBcd_H,576,252,8,64,,1,2
	.member	_sCarNumBcd_L,640,252,8,64,,1,2
	.eos
	.sym	_CARSTAT_PRO,0,8,13,704,.fake31
	.stag	.fake32,7872
	.member	_phHdBuf,0,8,8,352,.fake9
	.member	_sPAC_T,352,60,8,64,,2
	.member	_sC_ID,416,60,8,64,,2
	.member	_sDO,480,60,8,64,,2
	.member	_sD1,544,60,8,64,,2
	.member	_sODM,608,252,8,256,,4,2
	.member	_sANS,864,60,8,64,,2
	.member	_sTRAN_NO,928,252,8,192,,3,2
	.member	_sCRAW_ID,1120,252,8,192,,3,2
	.member	_sTRIP,1312,252,8,192,,3,2
	.member	_sD2,1504,60,8,64,,2
	.member	_sSTST,1568,252,8,128,,2,2
	.member	_sNOST,1696,252,8,128,,2,2
	.member	_sNEST,1824,252,8,128,,2,2
	.member	_sDEST,1952,252,8,128,,2,2
	.member	_sSPK,2080,252,8,128,,2,2
	.member	_sD3,2208,60,8,64,,2
	.member	_sD4,2272,60,8,64,,2
	.member	_sPR,2336,60,8,64,,2
	.member	_sPRVector,2400,252,8,128,,2,2
	.member	_sPACVector,2528,252,8,128,,2,2
	.member	_sFDI_SDI_Color,2656,252,8,128,,2,2
	.member	_sFDI_SDI_Vector1,2784,252,8,128,,2,2
	.member	_sFDI_SDI_Vector2,2912,252,8,128,,2,2
	.member	_sPII_Vector,3040,252,8,128,,2,2
	.member	_sPP_Line_Vector,3168,252,8,128,,2,2
	.member	_sPP_Vector,3296,252,8,128,,2,2
	.member	_sSP_Vector,3424,252,8,128,,2,2
	.member	_sROUTE_SKIP,3552,252,8,640,,10,2
	.member	_sCI_Index,4192,252,8,512,,8,2
	.member	_sCI_Fault,4704,60,8,64,,2
	.member	_sCCI,4768,60,8,64,,2
	.member	_phCRA_Sta,4832,1020,8,2816,,4,11,2
	.member	_sTrainLength,7648,60,8,64,,2
	.member	_nCRC,7712,60,8,128,,4
	.member	_btEot,7840,12,8,32
	.eos
	.sym	_PAC_PAC,0,8,13,7872,.fake32
	.sym	_PPAC_PAC,0,24,13,32,.fake32
	.stag	.fake33,4992
	.member	_phHdBuf,0,8,8,352,.fake9
	.member	_sDO,352,60,8,64,,2
	.member	_sTRAN_NO,416,252,8,192,,3,2
	.member	_sCRAW_ID,608,252,8,192,,3,2
	.member	_sTRIP,800,252,8,192,,3,2
	.member	_sD1,992,60,8,64,,2
	.member	_sSTST,1056,252,8,128,,2,2
	.member	_sNOST,1184,252,8,128,,2,2
	.member	_sNEST,1312,252,8,128,,2,2
	.member	_sDEST,1440,252,8,128,,2,2
	.member	_sSPK,1568,252,8,256,,4,2
	.member	_sD2,1824,252,8,128,,2,2
	.member	_sD3,1952,252,8,128,,2,2
	.member	_sPR,2080,60,8,64,,2
	.member	_sPRVector,2144,252,8,128,,2,2
	.member	_sPACVector,2272,252,8,128,,2,2
	.member	_sFDI_SDI_Color,2400,252,8,128,,2,2
	.member	_sFDI_SDI_Vector1,2528,252,8,128,,2,2
	.member	_sFDI_SDI_Vector2,2656,252,8,128,,2,2
	.member	_sPII_Vector,2784,252,8,128,,2,2
	.member	_sPP_Line_Vector,2912,252,8,128,,2,2
	.member	_sPP_Vector,3040,252,8,128,,2,2
	.member	_sSP_Vector,3168,252,8,128,,2,2
	.member	_sROUTE_SKIP,3296,252,8,640,,10,2
	.member	_sCI_Index,3936,252,8,512,,8,2
	.member	_sYear,4448,60,8,64,,2
	.member	_sMonth,4512,60,8,64,,2
	.member	_sDay,4576,60,8,64,,2
	.member	_sHour,4640,60,8,64,,2
	.member	_sMinute,4704,60,8,64,,2
	.member	_sSecond,4768,60,8,64,,2
	.member	_nCRC,4832,60,8,128,,4
	.member	_btEot,4960,12,8,32
	.eos
	.sym	_CCP_PAC,0,8,13,4992,.fake33
	.sym	_PCCP_PAC,0,24,13,32,.fake33
	.stag	.fake36,32
	.member	_Sp_0,0,14,18,1
	.member	_Sp_1,1,14,18,1
	.member	_CI_Fault,2,14,18,1
	.member	_DST,3,14,18,1
	.member	_Sp_4,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake35,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake36
	.eos
	.stag	.fake38,32
	.member	_Atcive_Cab,0,14,18,1
	.member	_Traction,1,14,18,1
	.member	_EP_Mode,2,14,18,1
	.member	_All_Doors_Closed,3,14,18,1
	.member	_Sp_4,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake37,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake38
	.eos
	.stag	.fake34,768
	.member	_phHdBuf,0,8,8,352,.fake9
	.member	_DATA2,352,9,8,32,.fake35
	.member	_DATA1,384,9,8,32,.fake37
	.member	_CI_Index_Num,416,60,8,64,,2
	.member	_chCarn,480,252,8,128,,2,2
	.member	_nCRC,608,60,8,128,,4
	.member	_btEot,736,12,8,32
	.eos
	.sym	_LICSD,0,8,13,768,.fake34
	.sym	_PLICSDR,0,24,13,32,.fake34
	.stag	.fake39,480
	.member	_btSoh,0,12,8,32
	.member	_chSrcDev,32,60,8,64,,2
	.member	_chDestDev,96,60,8,64,,2
	.member	_chMsgCnt,160,60,8,128,,4
	.member	_chCmdCode,288,60,8,64,,2
	.member	_chDataLen,352,60,8,128,,4
	.eos
	.sym	_CNCSHD,0,8,13,480,.fake39
	.sym	_PCNCSHD,0,24,13,32,.fake39
	.stag	.fake40,10208
	.member	_phHdBuf,0,8,8,480,.fake39
	.member	_sCommand,480,60,8,64,,2
	.member	_sCarKind,544,60,8,64,,2
	.member	_sTextDataAsc,608,60,8,9600,,300
	.eos
	.sym	_LIC_CNCS_HD,0,8,13,10208,.fake40
	.sym	_PLIC_CNCS_HD,0,24,13,32,.fake40
	.stag	.fake41,320
	.member	_chVer,0,50,8,128,,4
	.member	_chBuildDate,128,50,8,192,,6
	.eos
	.sym	_CNCS_LIC_VERBDD_SD,0,8,13,320,.fake41
	.sym	_PCNCS_LIC_VERBDD_SD,0,24,13,32,.fake41
	.stag	.fake42,10336
	.member	_VerCnt,0,13,8,32
	.member	_cvbBuf,32,56,8,10240,.fake41,32
	.member	_CarNum,10272,61,8,64,,2
	.eos
	.sym	_LIC_DPRAM_Ver,0,8,13,10336,.fake42
	.sym	_PLIC_DPRAM_Ver,0,24,13,32,.fake42
	.stag	.fake43,15168
	.member	_phHdBuf,0,8,8,480,.fake39
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
	.member	_cvbBuf,1312,56,8,13760,.fake41,43
	.member	_chChkSum,15072,60,8,64,,2
	.member	_btEot,15136,12,8,32
	.eos
	.sym	_CNCS_LIC_SD,0,8,13,15168,.fake43
	.sym	_PCNCS_LIC_SD,0,24,13,32,.fake43
	.stag	.fake44,832
	.member	_phHdBuf,0,8,8,480,.fake39
	.member	_sCommand,480,60,8,64,,2
	.member	_sTEXT,544,60,8,128,,4
	.member	_chContactSignalBuf,672,60,8,64,,2
	.member	_chChkSum,736,60,8,64,,2
	.member	_btEot,800,12,8,32
	.eos
	.sym	_CNCS_LIC_T_F,0,8,13,832,.fake44
	.sym	_PCNCS_LIC_T_F,0,24,13,32,.fake44
	.stag	.fake45,768
	.member	_phHdBuf,0,8,8,480,.fake39
	.member	_sCommand,480,60,8,64,,2
	.member	_sTEXT,544,60,8,128,,4
	.member	_chChkSum,672,60,8,64,,2
	.member	_btEot,736,12,8,32
	.eos
	.sym	_CNCS_LIC_T_F_C,0,8,13,768,.fake45
	.sym	_PCNCS_LIC_T_F_C,0,24,13,32,.fake45
	.stag	.fake46,96
	.member	_sChSum,0,60,8,64,,2
	.member	_sETX,64,12,8,32
	.eos
	.sym	_LIC_CNCS_ED,0,8,13,96,.fake46
	.sym	_PLIC_CNCS_ED,0,24,13,32,.fake46
	.stag	.fake48,32
	.member	_n1VTX,0,14,18,1
	.member	_n2CNCS,1,14,18,1
	.member	_n3PAC2,2,14,18,1
	.member	_n4LIC,3,14,18,1
	.member	_n5WLAN,4,14,18,1
	.member	_n6GPS,5,14,18,1
	.member	_n7PAC1,6,14,18,1
	.member	_n8sp,7,14,18,1
	.eos
	.stag	.fake49,32
	.member	_n1DPO1,0,14,18,1
	.member	_n2DPO2,1,14,18,1
	.member	_n3CCP1,2,14,18,1
	.member	_n4CCP2,3,14,18,1
	.member	_n5TRIC1,4,14,18,1
	.member	_n6TRIC2,5,14,18,1
	.member	_n7TR1,6,14,18,1
	.member	_n8TR2,7,14,18,1
	.eos
	.stag	.fake50,32
	.member	_n1Sp,0,14,18,1
	.member	_n2Sp,1,14,18,1
	.member	_n3CPO1,2,14,18,1
	.member	_n4CPO2,3,14,18,1
	.member	_n5CPO3,4,14,18,1
	.member	_n6CPO4,5,14,18,1
	.member	_n7Sp,6,14,18,1
	.member	_n8Sp,7,14,18,1
	.eos
	.stag	.fake51,32
	.member	_n1PEI1,0,14,18,1
	.member	_n2PEI2,1,14,18,1
	.member	_n3PEI3,2,14,18,1
	.member	_n4PEI4,3,14,18,1
	.member	_n5PEI5,4,14,18,1
	.member	_n6PEI6,5,14,18,1
	.member	_n7FDI1,6,14,18,1
	.member	_n8FDI2,7,14,18,1
	.eos
	.stag	.fake52,32
	.member	_n1SDI1,0,14,18,1
	.member	_n2SDI2,1,14,18,1
	.member	_n3SDI3,2,14,18,1
	.member	_n4SDI4,3,14,18,1
	.member	_n5SDI5,4,14,18,1
	.member	_n6SDI6,5,14,18,1
	.member	_n7SDI7,6,14,18,1
	.member	_n8SDI8,7,14,18,1
	.eos
	.stag	.fake53,32
	.member	_n1PID1_1,0,14,18,1
	.member	_n2PID1_2,1,14,18,1
	.member	_n3PID1_3,2,14,18,1
	.member	_n4PID1_4,3,14,18,1
	.member	_n5PID1_5,4,14,18,1
	.member	_n6PID1_6,5,14,18,1
	.member	_n7PID1_7,6,14,18,1
	.member	_n8PID1_8,7,14,18,1
	.eos
	.stag	.fake54,32
	.member	_n1PID2_1,0,14,18,1
	.member	_n2PID2_2,1,14,18,1
	.member	_n3PID2_3,2,14,18,1
	.member	_n4PID2_4,3,14,18,1
	.member	_n5PII1,4,14,18,1
	.member	_n6PII2,5,14,18,1
	.member	_n7PII3,6,14,18,1
	.member	_n8PII4,7,14,18,1
	.eos
	.stag	.fake47,256
	.member	_BYTE_1,0,8,8,32,.fake48
	.member	_BYTE_2,32,8,8,32,.fake49
	.member	_BYTE_3,64,8,8,32,.fake50
	.member	_BYTE_4,96,8,8,32,.fake51
	.member	_BYTE_5,128,12,8,32
	.member	_BYTE_6,160,8,8,32,.fake52
	.member	_BYTE_7,192,8,8,32,.fake53
	.member	_BYTE_8,224,8,8,32,.fake54
	.eos
	.sym	_COMMSTATUS_PA,0,8,13,256,.fake47
	.sym	_PCOMMSTATUS_PA,0,24,13,32,.fake47
	.stag	.fake57,32
	.member	_nCncs,0,14,18,1
	.member	_nVtx,1,14,18,1
	.member	_nLic,2,14,18,1
	.member	_nPac,3,14,18,1
	.member	_nWlr,4,14,18,1
	.member	_nGps,5,14,18,1
	.member	_nVoip,6,14,18,1
	.member	_nCcp,7,14,18,1
	.eos
	.utag	.fake56,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake57
	.eos
	.stag	.fake59,32
	.member	_nSdi4,0,14,18,1
	.member	_nSdi3,1,14,18,1
	.member	_nSdi2,2,14,18,1
	.member	_nSdi1,3,14,18,1
	.member	_nPii2,4,14,18,1
	.member	_nPii1,5,14,18,1
	.member	_nFdi,6,14,18,1
	.member	_sp_7,7,14,18,1
	.eos
	.utag	.fake58,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake59
	.eos
	.stag	.fake61,32
	.member	_nPid2_1,0,14,18,1
	.member	_nPid1_4,1,14,18,1
	.member	_nPid1_3,2,14,18,1
	.member	_nPid1_2,3,14,18,1
	.member	_nPid1_1,4,14,18,1
	.member	_sp_5,5,14,18,1
	.member	_sp_4,6,14,18,1
	.member	_sp_7,7,14,18,1
	.eos
	.utag	.fake60,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake61
	.eos
	.stag	.fake63,32
	.member	_nPei1,0,14,18,1
	.member	_nPei2,1,14,18,1
	.member	_sp_2,2,14,18,1
	.member	_sp_3,3,14,18,1
	.member	_nDpo,4,14,18,1
	.member	_sp_5,5,14,18,1
	.member	_sp_6,6,14,18,1
	.member	_nDph,7,14,18,1
	.eos
	.utag	.fake62,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake63
	.eos
	.stag	.fake65,32
	.member	_sp_0,0,14,18,1
	.member	_sp_1,1,14,18,1
	.member	_sp_2,2,14,18,1
	.member	_sp_3,3,14,18,1
	.member	_sp_4,4,14,18,1
	.member	_sp_5,5,14,18,1
	.member	_sp_6,6,14,18,1
	.member	_sp_7,7,14,18,1
	.eos
	.utag	.fake64,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake65
	.eos
	.stag	.fake55,160
	.member	_BYTE_1,0,9,8,32,.fake56
	.member	_BYTE_2,32,9,8,32,.fake58
	.member	_BYTE_3,64,9,8,32,.fake60
	.member	_BYTE_4,96,9,8,32,.fake62
	.member	_BYTE_5,128,9,8,32,.fake64
	.eos
	.sym	_COMMSTATUS_LIC,0,8,13,160,.fake55
	.sym	_PCOMMSTATUS_LIC,0,24,13,32,.fake55
	.etag	_eCDT_TYPE,32
	.member	_eCDT_A,0,4,16,32
	.member	_eCDT_B,1,4,16,32
	.member	_eCDT_MAXIMUM,2,4,16,32
	.eos
	.stag	.fake66,96
	.member	_nTCnt,0,4,8,32
	.member	_nStPosi,32,4,8,32
	.member	_nEdPosi,64,4,8,32
	.eos
	.sym	_T_FAULT_INFO,0,8,13,96,.fake66
	.sym	_PFAULT_INFO,0,24,13,32,.fake66
	.file	"Variable.h"
	.stag	.fake69,32
	.member	_Atcive_Cab,0,14,18,1
	.member	_Traction,1,14,18,1
	.member	_EP_Mode,2,14,18,1
	.member	_All_Doors_Closed,3,14,18,1
	.member	_Ci_CutOff,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake68,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake69
	.eos
	.stag	.fake67,14016
	.member	_LIC_VerList,0,242,8,9216,,32,9
	.member	_m_nUart1RxOneByteGapDelayTime,9216,14,8,32
	.member	_m_nUart2RxOneByteGapDelayTime,9248,14,8,32
	.member	_m_nUart3RxOneByteGapDelayTime,9280,14,8,32
	.member	_m_nUserDebug1msTimer,9312,14,8,32
	.member	_m_nTest1msTimer,9344,14,8,32
	.member	_m_tmCurTime,9376,8,8,224,.fake5
	.member	_m_tmUtcTime,9600,8,8,224,.fake5
	.member	_m_btCommSt,9824,60,8,256,,8
	.member	_m_btOldCommSt,10080,60,8,256,,8
	.member	_m_btSenseCommStBuf,10336,60,8,256,,8
	.member	_m_LIC_CNCS_Tx_Flag,10592,4,8,32
	.member	_m_LIC_CNCS_TX_DelyTime,10624,4,8,32
	.member	_m_nLnWkTxFlag,10656,4,8,32
	.member	_m_nFaultCnt,10688,4,8,32
	.member	_m_Recving_Posi,10720,4,8,32
	.member	_m_nCDT_FaultDataStFlag,10752,4,8,32
	.member	_m_TrainCofVal,10784,4,8,32
	.member	_m_nCarPos,10816,4,8,32
	.member	_m_btCiFaultVal,10848,4,8,32
	.member	_m_nCarNo,10880,13,8,32
	.member	_m_chCarKind,10912,2,8,32
	.member	_m_nCarKindToLonCnt,10944,4,8,32
	.member	_m_chCarKindNum,10976,2,8,32
	.member	_m_bLnWkDbgTxFlag,11008,4,8,32
	.member	_m_nLnWkWaySideOnRxOk,11040,12,8,32
	.member	_m_nCarCnt,11072,12,8,32
	.member	_m_nNvsramPos,11104,14,8,32
	.member	_m_bLnWkFtpEndFlag,11136,4,8,32
	.member	_m_nDateTime2SecondCnt,11168,14,8,32
	.member	_m_nTxDbg1msTimer,11200,14,8,32
	.member	_m_nDbgTxPos,11232,14,8,32
	.member	_m_btExVersionTbl,11264,61,8,1152,,36
	.member	_m_btExVersion_DAYTbl,12416,61,8,1152,,36
	.member	_m_btCttSignalA,13568,9,8,32,.fake68
	.member	_m_btCttSignalB,13600,12,8,32
	.member	_m_LIC_CNCS_TimSetFlag,13632,4,8,32
	.member	_m_LIC_GIA_TimSetFlag,13664,4,8,32
	.member	_m_nCncsRxCheck1msTimer,13696,14,8,32
	.member	_m_nGiaRxCheck1msTimer,13728,14,8,32
	.member	_m_btTestOtherCiFault,13760,12,8,32
	.member	_m_bCiFaultFlag,13792,4,8,32
	.member	_m_tFaultInfo,13824,56,8,192,.fake66,2
	.eos
	.sym	_VARIABLE_H,0,8,13,14016,.fake67
	.sym	_PVARIABLE_H,0,24,13,32,.fake67
	.file	"xr16l784.h"
	.utag	.fake71,32
	.member	_btRxd,0,12,11,32
	.member	_btTxd,0,12,11,32
	.member	_btDll,0,12,11,32
	.eos
	.utag	.fake72,32
	.member	_btDlm,0,12,11,32
	.member	_btIer,0,12,11,32
	.eos
	.utag	.fake73,32
	.member	_btIir,0,12,11,32
	.member	_btFcr,0,12,11,32
	.eos
	.stag	.fake70,512
	.member	_CREG1,0,9,8,32,.fake71
	.member	_CREG2,32,9,8,32,.fake72
	.member	_CREG3,64,9,8,32,.fake73
	.member	_btLcr,96,12,8,32
	.member	_btMcr,128,12,8,32
	.member	_btLsr,160,12,8,32
	.member	_btMsr_U,192,12,8,32
	.member	_btScr,224,12,8,32
	.member	_btSp,256,60,8,256,,8
	.eos
	.sym	_XR16L784ST,0,8,13,512,.fake70
	.sym	_PXR16L784ST,0,24,13,32,.fake70
	.stag	.fake74,2048
	.member	_xr16Reg,0,56,8,2048,.fake70,4
	.eos
	.sym	_XR16L784BDY,0,8,13,2048,.fake74
	.sym	_PXR16L784BDY,0,24,13,32,.fake74
	.file	"MpuDebug.h"
	.file	"mpudebug.c"

	.sect	".cinit"
	.field  	1,32
	.field  	_nRxPos$1+0,32
	.field  	0,32		; _nRxPos$1 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nOldUart1RxOneByteGapDelayTime$2+0,32
	.field  	0,32		; _nOldUart1RxOneByteGapDelayTime$2 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_DebugLoop
	.sym	_DebugLoop,_DebugLoop,32,2,0
	.func	15
;******************************************************************************
;* FUNCTION NAME: _DebugLoop                                                  *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3,r4,r5,ar0,ar1,ar2,fp,ar4,ar5,ir0,ir1,bk,*
;*                        sp,st,rs,re,rc                                      *
;*   Regs Saved         : r4,r5,ar4,ar5                                       *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 796 Auto + 4 SOE = 802 words      *
;******************************************************************************
_DebugLoop:
	.bss	_nRxPos$1,1
	.sym	_nRxPos,_nRxPos$1,4,3,32
	.bss	_nOldUart1RxOneByteGapDelayTime$2,1
	.sym	_nOldUart1RxOneByteGapDelayTime,_nOldUart1RxOneByteGapDelayTime$2,12,3,32
	.bss	_btRxBuf$3,256
	.sym	_btRxBuf,_btRxBuf$3,60,3,8192,,256
	.sym	_i,1,4,1,32
	.sym	_j,2,4,1,32
	.sym	_sIndex,3,4,1,32
	.sym	_szBuf1,4,50,1,8192,,256
	.sym	_szBuf2,260,50,1,8192,,256
	.sym	_btBuf,516,60,1,8192,,256
	.sym	_sTemp,772,60,1,320,,10
	.sym	_nRxLen,782,4,1,32
	.sym	_tmBuf,783,8,1,224,.fake5
	.sym	_pLnWkDp,790,24,1,32,.fake8
	.sym	_pLicVerDp,791,24,1,32,.fake42
	.sym	_pCommStatus_Lic,792,24,1,32,.fake55
	.sym	_HH,793,12,1,32
	.sym	_HL,794,12,1,32
	.sym	_LH,795,12,1,32
	.sym	_LL,796,12,1,32
	.line	1
;----------------------------------------------------------------------
;  15 | void DebugLoop()                                                       
;  17 | int i,j;                                                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      796,sp
        push      r4
        push      r5
        push      ar4
        push      ar5
	.line	4
;----------------------------------------------------------------------
;  18 | int sIndex = 0;                                                        
;  19 | char szBuf1[256];                                                      
;  20 | char szBuf2[256];                                                      
;  21 | UCHAR btBuf[256];                                                      
;  22 | UCHAR sTemp[10];                                                       
;  23 | int nRxLen;                                                            
;  24 | static int nRxPos = 0;                                                 
;  25 | static UCHAR nOldUart1RxOneByteGapDelayTime = 0;                       
;  26 | static UCHAR btRxBuf[256];                                             
;  27 | DATE_TIME_TYPE tmBuf;                                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(3)
	.line	14
;----------------------------------------------------------------------
;  28 | PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;                                
;----------------------------------------------------------------------
        ldiu      790,ir0
        ldiu      @CL1,r0
        sti       r0,*+fp(ir0)
	.line	15
;----------------------------------------------------------------------
;  29 | PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //¹öÀü Á¤º¸ Ã³¸
;     | ®¸¦ À§ÇØ ÀÓÀÇ·Î ¸¸µé¾ú´Ù.                                              
;  30 | PCOMMSTATUS_LIC pCommStatus_Lic;  //ÀåÄ¡ Status                        
;  31 | UCHAR HH,HL,LH,LL;                                                     
;  33 | // ¼ö½Å                                                                
;----------------------------------------------------------------------
        ldiu      791,ir0
        ldiu      @CL2,r0
        sti       r0,*+fp(ir0)
	.line	20
;----------------------------------------------------------------------
;  34 | nRxLen = user_DebugRx(btBuf,128);                                      
;----------------------------------------------------------------------
        ldiu      128,r1
        ldiu      516,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _user_DebugRx
                                        ; Call Occurs
        subi      2,sp
        ldiu      782,ir0
        sti       r0,*+fp(ir0)
	.line	21
;----------------------------------------------------------------------
;  35 | if(nRxLen)                                                             
;----------------------------------------------------------------------
        ldi       *+fp(ir0),r0
        beq       L6
;*      Branch Occurs to L6 
	.line	23
;----------------------------------------------------------------------
;  37 | if(!m_Variable.m_nUart1RxOneByteGapDelayTime) nRxPos = 0;              
;----------------------------------------------------------------------
        ldi       @_m_Variable+288,r0
        bne       L4
;*      Branch Occurs to L4 
        ldiu      0,r0
        sti       r0,@_nRxPos$1+0
L4:        
	.line	24
;----------------------------------------------------------------------
;  38 | nOldUart1RxOneByteGapDelayTime = m_Variable.m_nUart1RxOneByteGapDelayTi
;     | me = 10;                                                               
;----------------------------------------------------------------------
        ldiu      10,r0
        sti       r0,@_m_Variable+288
        sti       r0,@_nOldUart1RxOneByteGapDelayTime$2+0
	.line	26
;----------------------------------------------------------------------
;  40 | if(nRxPos + nRxLen < 250)                                              
;----------------------------------------------------------------------
        ldiu      782,ir0
        ldiu      *+fp(ir0),r0
        addi      @_nRxPos$1+0,r0
        cmpi      250,r0
        bge       L6
;*      Branch Occurs to L6 
	.line	28
;----------------------------------------------------------------------
;  42 | memcpy(&btRxBuf[nRxPos],btBuf,nRxLen);                                 
;----------------------------------------------------------------------
        ldiu      @CL3,r0
        ldiu      516,r1
        ldiu      *+fp(ir0),r2
        addi      @_nRxPos$1+0,r0       ; Unsigned
        addi      fp,r1
        push      r2
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	29
;----------------------------------------------------------------------
;  43 | nRxPos += nRxLen;                                                      
;----------------------------------------------------------------------
        ldiu      782,ir0
        ldiu      *+fp(ir0),r0
        addi      @_nRxPos$1+0,r0
        sti       r0,@_nRxPos$1+0
L6:        
	.line	33
;----------------------------------------------------------------------
;  47 | if(nOldUart1RxOneByteGapDelayTime && !m_Variable.m_nUart1RxOneByteGapDe
;     | layTime)                                                               
;----------------------------------------------------------------------
        ldi       @_nOldUart1RxOneByteGapDelayTime$2+0,r0
        beq       L295
;*      Branch Occurs to L295 
        ldi       @_m_Variable+288,r0
        bne       L295
;*      Branch Occurs to L295 
	.line	35
;----------------------------------------------------------------------
;  49 | strncpy(szBuf1,(char *)btRxBuf,MIN(32,nRxPos));                        
;----------------------------------------------------------------------
        ldiu      32,r0
        cmpi      @_nRxPos$1+0,r0
        bge       L10
;*      Branch Occurs to L10 
        bu        L11
;*      Branch Occurs to L11 
L10:        
        ldiu      @_nRxPos$1+0,r0
L11:        
        ldiu      fp,r1
        push      r0
        ldiu      @CL3,r2
        addi      4,r1
        push      r2
        push      r1
        call      _strncpy
                                        ; Call Occurs
        subi      3,sp
	.line	36
;----------------------------------------------------------------------
;  50 | szBuf1[32] = NULL;                                                     
;  51 | //for(i=0;i<strlen(szBuf1);i++) if(!IS_ASCALPHABET(szBuf1[i]) && !IS_AS
;     | CSPEC(szBuf1[i])) {szBuf1[i] = NULL; break;}                           
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      36,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	39
;----------------------------------------------------------------------
;  53 | if(btRxBuf[0] == '\r' || btRxBuf[0] == '\n')                           
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+0,r0
        cmpi      13,r0
        beq       L13
;*      Branch Occurs to L13 
        cmpi      10,r0
        bned      L15
        ldine     4,r2
        ldine     fp,r0
        ldine     @CL5,r1
;*      Branch Occurs to L15 
L13:        
	.line	41
;----------------------------------------------------------------------
;  55 | MyPrintf((char *)"->\r\n");                                            
;  57 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL4,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	44
;----------------------------------------------------------------------
;  58 | if(!strncmp(szBuf1,"Time",4))                                          
;----------------------------------------------------------------------
L15:        
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L47
        subi      3,sp
        ldine     1,r2
        ldine     fp,r0
;*      Branch Occurs to L47 
	.line	46
;----------------------------------------------------------------------
;  60 | if(IS_ASCNUMBER(btRxBuf[5])  && IS_ASCNUMBER(btRxBuf[6]) &&            
;  61 |         IS_ASCNUMBER(btRxBuf[7]) && IS_ASCNUMBER(btRxBuf[8]) &&        
;  62 |         IS_ASCNUMBER(btRxBuf[9]) && IS_ASCNUMBER(btRxBuf[10])&&        
;  63 |         IS_ASCNUMBER(btRxBuf[11])&& IS_ASCNUMBER(btRxBuf[12])&&        
;  64 |         IS_ASCNUMBER(btRxBuf[13])&& IS_ASCNUMBER(btRxBuf[14])&&        
;  65 |         IS_ASCNUMBER(btRxBuf[15])&& IS_ASCNUMBER(btRxBuf[16]))         
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+5,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+6,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+7,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+8,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+9,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+10,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+11,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+12,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+13,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+14,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+15,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
        ldiu      @_btRxBuf$3+16,r0
        cmpi      48,r0
        blo       L45
;*      Branch Occurs to L45 
        cmpi      57,r0
        bhi       L45
;*      Branch Occurs to L45 
	.line	53
;----------------------------------------------------------------------
;  67 | tmBuf.second = MAKE_BYTE(ConvAsc2Hex(btRxBuf[15]),ConvAsc2Hex(btRxBuf[1
;     | 6]));                                                                  
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+15,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      r0,r4
        ldiu      @_btRxBuf$3+16,r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      783,ir0
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	54
;----------------------------------------------------------------------
;  68 | tmBuf.minute = MAKE_BYTE(ConvAsc2Hex(btRxBuf[13]),ConvAsc2Hex(btRxBuf[1
;     | 4]));                                                                  
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+13,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      @_btRxBuf$3+14,r1
        push      r1
        ldiu      r0,r4
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      784,ir0
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	55
;----------------------------------------------------------------------
;  69 | tmBuf.hour   = MAKE_BYTE(ConvAsc2Hex(btRxBuf[11]),ConvAsc2Hex(btRxBuf[1
;     | 2]));                                                                  
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+11,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      r0,r4
        ldiu      @_btRxBuf$3+12,r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      785,ir0
        and       15,r0
        subi      1,sp
        or3       r4,r0,r0
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	56
;----------------------------------------------------------------------
;  70 | tmBuf.day    = MAKE_BYTE(ConvAsc2Hex(btRxBuf[9]),ConvAsc2Hex(btRxBuf[10
;     | ]));                                                                   
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+9,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        subi      1,sp
        ldiu      @_btRxBuf$3+10,r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      786,ir0
        subi      1,sp
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	57
;----------------------------------------------------------------------
;  71 | tmBuf.month  = MAKE_BYTE(ConvAsc2Hex(btRxBuf[7]),ConvAsc2Hex(btRxBuf[8]
;     | ));                                                                    
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+7,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        ldiu      @_btRxBuf$3+8,r0
        subi      1,sp
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      787,ir0
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	58
;----------------------------------------------------------------------
;  72 | tmBuf.year   = MAKE_BYTE(ConvAsc2Hex(btRxBuf[5]),ConvAsc2Hex(btRxBuf[6]
;     | ));                                                                    
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+5,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        subi      1,sp
        ldiu      @_btRxBuf$3+6,r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      788,ir0
        and       15,r0
        subi      1,sp
        or3       r4,r0,r0
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	59
;----------------------------------------------------------------------
;  73 | tmBuf.weekday = 0;                                                     
;----------------------------------------------------------------------
        ldiu      789,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	61
;----------------------------------------------------------------------
;  75 | m_Variable.m_tmCurTime.second = HEXA2BIN(tmBuf.second);                
;----------------------------------------------------------------------
        ldiu      -4,r1
        ldiu      783,ir0
        ldiu      783,ir1
        lsh3      r1,*+fp(ir0),r1
        mpyi      10,r1
        ldiu      15,r0
        and3      r0,*+fp(ir1),r0
        addi3     r0,r1,r0              ; Unsigned
        sti       r0,@_m_Variable+293
	.line	62
;----------------------------------------------------------------------
;  76 | m_Variable.m_tmCurTime.minute = HEXA2BIN(tmBuf.minute);                
;----------------------------------------------------------------------
        ldiu      784,ir0
        ldiu      784,ir1
        ldiu      -4,r1
        lsh3      r1,*+fp(ir1),r1
        ldiu      15,r0
        mpyi      10,r1
        and3      r0,*+fp(ir0),r0
        addi3     r0,r1,r0              ; Unsigned
        sti       r0,@_m_Variable+294
	.line	63
;----------------------------------------------------------------------
;  77 | m_Variable.m_tmCurTime.hour = HEXA2BIN(tmBuf.hour);                    
;----------------------------------------------------------------------
        ldiu      785,ir1
        ldiu      -4,r0
        lsh3      r0,*+fp(ir1),r0
        ldiu      785,ir0
        ldiu      15,r1
        and3      r1,*+fp(ir0),r1
        mpyi      10,r0
        addi3     r1,r0,r0              ; Unsigned
        sti       r0,@_m_Variable+295
	.line	64
;----------------------------------------------------------------------
;  78 | m_Variable.m_tmCurTime.day = HEXA2BIN(tmBuf.day);                      
;----------------------------------------------------------------------
        ldiu      786,ir1
        ldiu      786,ir0
        ldiu      -4,r0
        ldiu      15,r1
        lsh3      r0,*+fp(ir1),r0
        mpyi      10,r0
        and3      r1,*+fp(ir0),r1
        addi3     r1,r0,r0              ; Unsigned
        sti       r0,@_m_Variable+296
	.line	65
;----------------------------------------------------------------------
;  79 | m_Variable.m_tmCurTime.month = HEXA2BIN(tmBuf.month);                  
;----------------------------------------------------------------------
        ldiu      -4,r0
        ldiu      787,ir1
        ldiu      787,ir0
        ldiu      15,r1
        lsh3      r0,*+fp(ir1),r0
        and3      r1,*+fp(ir0),r1
        mpyi      10,r0
        addi3     r1,r0,r0              ; Unsigned
        sti       r0,@_m_Variable+297
	.line	66
;----------------------------------------------------------------------
;  80 | m_Variable.m_tmCurTime.year = HEXA2BIN(tmBuf.year);                    
;----------------------------------------------------------------------
        ldiu      -4,r0
        ldiu      15,r1
        ldiu      788,ir1
        ldiu      788,ir0
        lsh3      r0,*+fp(ir1),r0
        and3      r1,*+fp(ir0),r1
        mpyi      10,r0
        addi3     r1,r0,r0              ; Unsigned
        sti       r0,@_m_Variable+298
	.line	68
;----------------------------------------------------------------------
;  82 | memset(&m_Variable.m_tmUtcTime, 0x00, sizeof(DATE_TIME_TYPE));         
;----------------------------------------------------------------------
        ldiu      7,r2
        push      r2
        ldiu      0,r1
        push      r1
        ldiu      @CL6,r0
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	70
;----------------------------------------------------------------------
;  84 | if(m_Variable.m_LIC_CNCS_TimSetFlag = GetLocalTimeToUTC(&m_Variable.m_t
;     | mCurTime, -7, &m_Variable.m_tmUtcTime))                                
;----------------------------------------------------------------------
        ldiu      @CL6,r2
        push      r2
        ldiu      -7,r1
        ldiu      @CL7,r0
        push      r1
        push      r0
        call      _GetLocalTimeToUTC
                                        ; Call Occurs
        cmpi      0,r0
        beqd      L43
	nop
        subi      3,sp
        sti       r0,@_m_Variable+426
;*      Branch Occurs to L43 
	.line	72
;----------------------------------------------------------------------
;  86 | m_Variable.m_tmUtcTime.year         = ConvDec2Hex(m_Variable.m_tmUtcTim
;     | e.year   );                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+305,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+305
        subi      1,sp
	.line	73
;----------------------------------------------------------------------
;  87 | m_Variable.m_tmUtcTime.month    = ConvDec2Hex(m_Variable.m_tmUtcTime.mo
;     | nth );                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+304,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+304
        subi      1,sp
	.line	74
;----------------------------------------------------------------------
;  88 | m_Variable.m_tmUtcTime.day              = ConvDec2Hex(m_Variable.m_tmUt
;     | cTime.day        );                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+303,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+303
        subi      1,sp
	.line	75
;----------------------------------------------------------------------
;  89 | m_Variable.m_tmUtcTime.hour         = ConvDec2Hex(m_Variable.m_tmUtcTim
;     | e.hour   );                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+302,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+302
        subi      1,sp
	.line	76
;----------------------------------------------------------------------
;  90 | m_Variable.m_tmUtcTime.minute   = ConvDec2Hex(m_Variable.m_tmUtcTime.mi
;     | nute);                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+301,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+301
        subi      1,sp
	.line	77
;----------------------------------------------------------------------
;  91 | m_Variable.m_tmUtcTime.second   = ConvDec2Hex(m_Variable.m_tmUtcTime.se
;     | cond);                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+300,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+300
        subi      1,sp
	.line	79
;----------------------------------------------------------------------
;  93 | m_Variable.m_nCncsRxCheck1msTimer = 100000;                            
;----------------------------------------------------------------------
        ldiu      @CL8,r0
        sti       r0,@_m_Variable+428
L43:        
	.line	82
;----------------------------------------------------------------------
;  96 | m_Variable.m_tmUtcTime.year         = ConvDec2Hex(m_Variable.m_tmUtcTim
;     | e.year   );                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+305,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+305
        subi      1,sp
	.line	83
;----------------------------------------------------------------------
;  97 | m_Variable.m_tmUtcTime.month    = ConvDec2Hex(m_Variable.m_tmUtcTime.mo
;     | nth );                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+304,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+304
        subi      1,sp
	.line	84
;----------------------------------------------------------------------
;  98 | m_Variable.m_tmUtcTime.day              = ConvDec2Hex(m_Variable.m_tmUt
;     | cTime.day        );                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+303,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+303
        subi      1,sp
	.line	85
;----------------------------------------------------------------------
;  99 | m_Variable.m_tmUtcTime.hour         = ConvDec2Hex(m_Variable.m_tmUtcTim
;     | e.hour   );                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+302,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+302
        subi      1,sp
	.line	86
;----------------------------------------------------------------------
; 100 | m_Variable.m_tmUtcTime.minute   = ConvDec2Hex(m_Variable.m_tmUtcTime.mi
;     | nute);                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+301,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+301
        subi      1,sp
	.line	87
;----------------------------------------------------------------------
; 101 | m_Variable.m_tmUtcTime.second   = ConvDec2Hex(m_Variable.m_tmUtcTime.se
;     | cond);                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+300,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+300
        subi      1,sp
	.line	89
;----------------------------------------------------------------------
; 103 | sprintf(btBuf,"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour
;     | ],%02X[minute],%02X[second] \r\n",                                     
; 104 |         BIN2HEXA(m_Variable.m_tmUtcTime.year),                         
; 105 |         BIN2HEXA(m_Variable.m_tmUtcTime.month),                        
; 106 |         BIN2HEXA(m_Variable.m_tmUtcTime.day),                          
; 107 |         BIN2HEXA(m_Variable.m_tmUtcTime.hour),                         
; 108 |         BIN2HEXA(m_Variable.m_tmUtcTime.minute),                       
; 109 |         BIN2HEXA(m_Variable.m_tmUtcTime.second));                      
;----------------------------------------------------------------------
        ldiu      10,r1
        ldiu      @_m_Variable+305,r0
        call      DIV_U30
                                        ; Call Occurs
        ldiu      10,r1
        ldiu      r0,r2
        ash       4,r2
        ldiu      @_m_Variable+305,r0
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        ldiu      @_m_Variable+304,r0
        or3       r2,r1,ir1
        ldiu      10,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      @_m_Variable+304,r0
        ldiu      10,r1
        ash       4,r2
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        ldiu      @_m_Variable+303,r0
        or3       r2,r1,ar2
        ldiu      10,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      10,r1
        ldiu      @_m_Variable+303,r0
        ash       4,r2
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,bk
        ldiu      @_m_Variable+302,r0
        ldiu      10,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      @_m_Variable+302,r0
        ldiu      10,r1
        ash       4,r2
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,r3
        ldiu      10,r1
        ldiu      @_m_Variable+301,r0
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      10,r1
        ash       4,r2
        ldiu      @_m_Variable+301,r0
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,r2
        ldiu      10,r1
        ldiu      @_m_Variable+300,r0
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,ir0
        ldiu      @_m_Variable+300,r0
        ldiu      10,r1
        call      MOD_U30
                                        ; Call Occurs
        ash       4,ir0
        or3       ir0,r0,r0
        push      r0
        push      r2
        push      r3
        push      bk
        ldiu      @CL9,r0
        push      ar2
        push      ir1
        push      r0
        ldiu      516,r1
        addi      fp,r1
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      8,sp
	.line	97
;----------------------------------------------------------------------
; 111 | user_DebugPrint((char *)btBuf);                                        
; 113 | else                                                                   
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
L45:        
	.line	101
;----------------------------------------------------------------------
; 115 | user_DebugPrint("Not Date&time format \r\n");                          
; 118 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL10,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	105
;----------------------------------------------------------------------
; 119 | if(!strncmp(szBuf1,"t",1))                                             
;----------------------------------------------------------------------
L47:        
        ldiu      @CL11,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L51
        subi      3,sp
        ldine     7,r2
        ldine     fp,r0
;*      Branch Occurs to L51 
	.line	107
;----------------------------------------------------------------------
; 121 | sprintf(btBuf,"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour
;     | ],%02X[minute],%02X[second] \r\n",                                     
; 122 |         BIN2HEXA(m_Variable.m_tmUtcTime.year),                         
; 123 |         BIN2HEXA(m_Variable.m_tmUtcTime.month),                        
; 124 |         BIN2HEXA(m_Variable.m_tmUtcTime.day),                          
; 125 |         BIN2HEXA(m_Variable.m_tmUtcTime.hour),                         
; 126 |         BIN2HEXA(m_Variable.m_tmUtcTime.minute),                       
; 127 |         BIN2HEXA(m_Variable.m_tmUtcTime.second));                      
;----------------------------------------------------------------------
        ldiu      @_m_Variable+305,r0
        ldiu      10,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      10,r1
        ash       4,r2
        ldiu      @_m_Variable+305,r0
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,ir1
        ldiu      @_m_Variable+304,r0
        ldiu      10,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ash       4,r2
        ldiu      10,r1
        ldiu      @_m_Variable+304,r0
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,ar2
        ldiu      10,r1
        ldiu      @_m_Variable+303,r0
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      @_m_Variable+303,r0
        ldiu      10,r1
        ash       4,r2
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,bk
        ldiu      @_m_Variable+302,r0
        ldiu      10,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      @_m_Variable+302,r0
        ash       4,r2
        ldiu      10,r1
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,r3
        ldiu      10,r1
        ldiu      @_m_Variable+301,r0
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,r2
        ldiu      @_m_Variable+301,r0
        ash       4,r2
        ldiu      10,r1
        call      MOD_U30
                                        ; Call Occurs
        ldiu      r0,r1
        or3       r2,r1,r2
        ldiu      10,r1
        ldiu      @_m_Variable+300,r0
        call      DIV_U30
                                        ; Call Occurs
        ldiu      r0,ir0
        ldiu      10,r1
        ldiu      @_m_Variable+300,r0
        call      MOD_U30
                                        ; Call Occurs
        ash       4,ir0
        or3       ir0,r0,r0
        ldiu      516,r1
        push      r0
        push      r2
        addi      fp,r1
        push      r3
        ldiu      @CL9,r0
        push      bk
        push      ar2
        push      ir1
        push      r0
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      8,sp
	.line	114
;----------------------------------------------------------------------
; 128 | user_DebugPrint((char *)btBuf);                                        
; 130 | else                                                                   
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	117
;----------------------------------------------------------------------
; 131 | if(!strncmp(szBuf1,"Version",7))                                       
;----------------------------------------------------------------------
L51:        
        ldiu      @CL12,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L59
        subi      3,sp
        ldine     6,r2
        ldine     fp,r0
;*      Branch Occurs to L59 
	.line	119
;----------------------------------------------------------------------
; 133 | i = GetFirmwareVersion(1);                                             
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(1)
	.line	121
;----------------------------------------------------------------------
; 135 | memcpy(sTemp,&pLnWkDp->btVerH,2);                                      
;----------------------------------------------------------------------
        ldiu      790,ir0
        ldiu      772,ar1
        ldiu      1,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        addi      fp,ar1
        ldiu      *ar0,r0
        sti       r0,*ar1
        ldiu      *+ar0,r0
        sti       r0,*+ar1
	.line	122
;----------------------------------------------------------------------
; 136 | j = MAKE_WORD(sTemp[0],sTemp[1]);                                      
;----------------------------------------------------------------------
        ldiu      773,ir1
        ldiu      255,r1
        ldiu      772,ir0
        ldiu      8,r0
        and3      r1,*+fp(ir1),r1
        ash3      r0,*+fp(ir0),r0
        or3       r0,r1,r0
        and       65535,r0
        sti       r0,*+fp(2)
	.line	124
;----------------------------------------------------------------------
; 138 | sprintf(btBuf,"LIC-MPU Version:%d.%d%d%d,Build Date:20%06d, LIC-LON Ver
;     | sion:%d.%d%d%d,Build Date:%08X\r\n",                                   
; 139 |         i/1000%10,                                                     
; 140 |         i/100%10,                                                      
; 141 |         i/10%10,                                                       
; 142 |         i%10,                                                          
; 143 |         GetFirmwareVersion(2),                                         
; 144 |         BYTE_H(WORD_H(j)),                                             
; 145 |         BYTE_L(WORD_H(j)),                                             
; 146 |         BYTE_H(WORD_L(j)),                                             
; 147 |         BYTE_L(WORD_L(j)),                                             
; 148 |         MAKE_DWORD(pLnWkDp->btBuildDateHH,pLnWkDp->btBuildDateHL,pLnWkD
;     | p->btBuildDateLH,pLnWkDp->btBuildDateLL));                             
;----------------------------------------------------------------------
        ldiu      1000,r1
        ldiu      *+fp(1),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      r0,r5
        ldiu      100,r1
        ldiu      *+fp(1),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      r0,ar5
        ldiu      10,r1
        ldiu      *+fp(1),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      r0,ar4
        ldiu      *+fp(1),r0
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      2,r1
        push      r1
        ldiu      r0,r4
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        ldiu      790,ir0
        ldiu      790,ir1
        ldiu      255,re
        ldiu      255,r1
        ldiu      *+fp(ir0),ar1
        ldiu      *+fp(ir1),ar0
        and       *+ar0(4),r1
        ash       16,r1
        ldiu      *+fp(ir0),ar2
        ldiu      *+ar1(3),r2
        ash       24,r2
        or3       r2,r1,bk
        ldiu      255,r2
        ldiu      *+fp(2),r1
        ldiu      r1,r3
        ash       -8,r3
        and       15,r3
        and       *+fp(2),r2
        ldiu      255,rc
        and       *+ar2(5),re
        ldiu      *+fp(ir0),ar0
        ldiu      15,rs
        ash       8,re
        and       *+ar0(6),rc
        or3       bk,re,re
        and       *+fp(2),rs
        or3       re,rc,re
        push      re
        ash       -4,r2
        push      rs
        and       15,r2
        ash       -8,r1
        push      r2
        and       255,r1
        push      r3
        ash       -4,r1
        and       15,r1
        push      r1
        push      r0
        ldiu      @CL13,r1
        push      r4
        push      ar4
        ldiu      ar5,r0
        push      r0
        push      r5
        push      r1
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      12,sp
	.line	136
;----------------------------------------------------------------------
; 150 | user_DebugPrint((char *)btBuf);                                        
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	138
;----------------------------------------------------------------------
; 152 | memset(btBuf,0x00,256);                                                
; 154 | //2011_03_03 ¼öÁ¤                                                      
;----------------------------------------------------------------------
        ldiu      256,r0
        ldiu      0,r1
        push      r0
        ldiu      516,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	141
;----------------------------------------------------------------------
; 155 | for(i=0;i<VER_BDD_MAX_CNT;i++) //CNCS·Î ºÎÅÍ ¹ÞÀº ¹öÀü Á¤º¸ Ç¥Ãâ ÇÏ´Â º
;     | ÎºÐ Ãß°¡                                                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      32,r0
        bge       L57
;*      Branch Occurs to L57 
L54:        
	.line	143
;----------------------------------------------------------------------
; 157 | if(WORD_L(m_Variable.LIC_VerList[i][0]) == NULL) break;                
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL14,ar0
        mpyi      9,ir0
        ldiu      255,r0
        tstb3     *+ar0(ir0),r0
        beq       L57
;*      Branch Occurs to L57 
	.line	144
;----------------------------------------------------------------------
; 158 | memset(btBuf,0x00,256);                                                
;----------------------------------------------------------------------
        ldiu      256,r2
        ldiu      516,r1
        ldiu      0,r0
        push      r2
        addi      fp,r1
        push      r0
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	145
;----------------------------------------------------------------------
; 159 | strncpy((char *)btBuf,(char *)&m_Variable.LIC_VerList[i][0],strlen((cha
;     | r*)&m_Variable.LIC_VerList[i][0]));                                    
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      9,r0
        addi      @CL14,r0              ; Unsigned
        push      r0
        call      _strlen
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(1),r1
        mpyi      9,r1
        push      r0
        addi      @CL14,r1              ; Unsigned
        ldiu      516,r0
        addi      fp,r0
        push      r1
        push      r0
        call      _strncpy
                                        ; Call Occurs
        subi      3,sp
	.line	146
;----------------------------------------------------------------------
; 160 | sprintf(&btBuf[strlen((char*)&btBuf)],":");                            
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      @CL15,r1
        subi      1,sp
        push      r1
        addi3     r0,fp,r0              ; Unsigned
        addi      516,r0                ; Unsigned
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      2,sp
	.line	147
;----------------------------------------------------------------------
; 161 | strncpy((char *)&btBuf[strlen((char*)&btBuf)],(char *)&pLicVerDp->cvbBu
;     | f[i].chVer[0],4);                                                      
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(1),r1
        ldiu      791,ir0
        mpyi      10,r1
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        ldiu      4,r2
        push      r2
        addi3     r0,fp,r0              ; Unsigned
        addi      516,r0                ; Unsigned
        addi      1,r1                  ; Unsigned
        push      r1
        push      r0
        call      _strncpy
                                        ; Call Occurs
        subi      3,sp
	.line	148
;----------------------------------------------------------------------
; 162 | sprintf(&btBuf[strlen((char*)&btBuf)],":");                            
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      @CL15,r1
        subi      1,sp
        addi3     r0,fp,r0              ; Unsigned
        push      r1
        addi      516,r0                ; Unsigned
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      2,sp
	.line	149
;----------------------------------------------------------------------
; 163 | strncpy((char *)&btBuf[strlen((char*)&btBuf)],(char *)&pLicVerDp->cvbBu
;     | f[i].chBuildDate[0],6);                                                
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      791,ir0
        subi      1,sp
        ldiu      *+fp(1),r1
        mpyi      10,r1
        ldiu      6,r2
        addi3     r0,fp,r0              ; Unsigned
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        addi      516,r0                ; Unsigned
        push      r2
        addi      5,r1                  ; Unsigned
        push      r1
        push      r0
        call      _strncpy
                                        ; Call Occurs
        subi      3,sp
	.line	150
;----------------------------------------------------------------------
; 164 | sprintf(&btBuf[strlen((char*)&btBuf)],"\r\n");                         
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        subi      1,sp
        ldiu      @CL16,r1
        addi3     r0,fp,r0              ; Unsigned
        push      r1
        addi      516,r0                ; Unsigned
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      2,sp
	.line	153
;----------------------------------------------------------------------
; 167 | user_DebugPrint((char *)btBuf);                                        
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	141
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      32,r0
        blt       L54
;*      Branch Occurs to L54 
L57:        
	.line	156
;----------------------------------------------------------------------
; 170 | MyPrintf("\r\n\r\n");                                                  
; 172 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL17,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	159
;----------------------------------------------------------------------
; 173 | if(!strncmp(szBuf1,"Recent",6)) //°íÀå ±â·ÏÀ» ½ÃÀÛ ÇÑ´Ù.               
;----------------------------------------------------------------------
L59:        
        ldiu      @CL18,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L62
        subi      3,sp
        ldine     10,r2
        ldine     fp,r0
;*      Branch Occurs to L62 
	.line	161
;----------------------------------------------------------------------
; 175 | m_Variable.m_nLnWkTxFlag = 1;                                          
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+333
	.line	162
;----------------------------------------------------------------------
; 176 | user_DebugPrint("Recent fault read start send \r\n");                  
; 178 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL19,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	165
;----------------------------------------------------------------------
; 179 | if(!strncmp(szBuf1,"Historical",10))                                   
;----------------------------------------------------------------------
L62:        
        ldiu      @CL20,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L65
        subi      3,sp
        ldine     6,r2
        ldine     fp,r0
;*      Branch Occurs to L65 
	.line	167
;----------------------------------------------------------------------
; 181 | m_Variable.m_nLnWkTxFlag = 2;                                          
;----------------------------------------------------------------------
        ldiu      2,r0
        sti       r0,@_m_Variable+333
	.line	168
;----------------------------------------------------------------------
; 182 | gm_SysTimeToRtc(&tmBuf,m_Variable.m_nDateTime2SecondCnt);              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+349,r1
        ldiu      783,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _gm_SysTimeToRtc
                                        ; Call Occurs
        subi      2,sp
	.line	169
;----------------------------------------------------------------------
; 183 | sprintf(btBuf,"Historical read start send, Historical start time : %08X
;     | H, Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%02X[minut
;     | e],%02X[second] \r\n",                                                 
; 184 |         m_Variable.m_nDateTime2SecondCnt,                              
; 185 |         tmBuf.year,                                                    
; 186 |         tmBuf.month,                                                   
; 187 |         tmBuf.day,                                                     
; 188 |         tmBuf.hour,                                                    
; 189 |         tmBuf.minute,                                                  
; 190 |         tmBuf.second);                                                 
;----------------------------------------------------------------------
        ldiu      783,ir0
        ldiu      *+fp(ir0),r0
        ldiu      786,ir1
        ldiu      784,ir0
        push      r0
        ldiu      *+fp(ir0),r0
        ldiu      785,ir0
        push      r0
        ldiu      *+fp(ir0),r0
        push      r0
        ldiu      *+fp(ir1),r0
        ldiu      787,ir1
        push      r0
        ldiu      *+fp(ir1),r1
        push      r1
        ldiu      788,ir0
        ldiu      516,r2
        ldiu      *+fp(ir0),r1
        push      r1
        ldiu      @_m_Variable+349,r1
        addi      fp,r2
        push      r1
        ldiu      @CL21,r0
        push      r0
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      9,sp
	.line	177
;----------------------------------------------------------------------
; 191 | user_DebugPrint((char *)btBuf);                                        
; 193 | else                                                                   
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	180
;----------------------------------------------------------------------
; 194 | if(!strncmp(szBuf1,"Rxinfo",6))                                        
;----------------------------------------------------------------------
L65:        
        ldiu      @CL22,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L71
        subi      3,sp
        ldine     8,r2
        ldine     fp,r0
;*      Branch Occurs to L71 
	.line	182
;----------------------------------------------------------------------
; 196 | if(!m_Variable.m_nNvsramPos)                                           
;----------------------------------------------------------------------
        ldi       @_m_Variable+347,r0
        bne       L68
;*      Branch Occurs to L68 
	.line	184
;----------------------------------------------------------------------
; 198 | sprintf(btBuf,"Total byte : %d, Packet count : %d, window count : %d, r
;     | emaind packet : %d, m_nLnWkWaySideOnRxOk : %d, m_bLnWkFtpEndFlag : %d, 
;     | Historical start time : %08XH \r\n",                                   
; 199 |         0,0,0,0,                                                       
; 200 |         m_Variable.m_nLnWkWaySideOnRxOk,                               
; 201 |         m_Variable.m_bLnWkFtpEndFlag,                                  
; 202 |         m_Variable.m_nDateTime2SecondCnt);                             
; 204 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @_m_Variable+349,r0
        ldiu      516,rc
        ldiu      0,rs
        ldiu      0,r3
        ldiu      0,r1
        push      r0
        ldiu      0,r2
        ldiu      @_m_Variable+348,r0
        addi      fp,rc
        push      r0
        ldiu      @_m_Variable+345,re
        push      re
        ldiu      @CL23,r0
        push      rs
        push      r3
        push      r1
        push      r2
        push      r0
        push      rc
        call      _sprintf
                                        ; Call Occurs
        subi      9,sp
        bu        L69
;*      Branch Occurs to L69 
L68:        
	.line	192
;----------------------------------------------------------------------
; 206 | sprintf(btBuf,"Total byte : %d, Packet count : %d, window count : %d, r
;     | emaind packet : %d, m_nLnWkWaySideOnRxOk : %d, m_bLnWkFtpEndFlag : %d, 
;     | Historical start time : %08XH \r\n",                                   
; 207 |         m_Variable.m_nNvsramPos,                                       
; 208 |         ((m_Variable.m_nNvsramPos-1)/128)+1,                           
; 209 |         ((m_Variable.m_nNvsramPos-1)/128/6)+1,                         
; 210 |         m_Variable.m_nNvsramPos%128,                                   
; 211 |         m_Variable.m_nLnWkWaySideOnRxOk,                               
; 212 |         m_Variable.m_bLnWkFtpEndFlag,                                  
; 213 |         m_Variable.m_nDateTime2SecondCnt);                             
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     @_m_Variable+347,r0   ; Unsigned
        ldiu      768,r1
        call      DIV_U30
                                        ; Call Occurs
        ldiu      127,r2
        ldiu      @_m_Variable+349,r3
        ldiu      1,r1
        and       @_m_Variable+347,r2
        subri     @_m_Variable+347,r1   ; Unsigned
        push      r3
        ldiu      @_m_Variable+348,r3
        addi      1,r0                  ; Unsigned
        push      r3
        ldiu      @_m_Variable+345,r3
        push      r3
        push      r2
        lsh       -7,r1
        push      r0
        addi      1,r1                  ; Unsigned
        ldiu      @CL23,rs
        push      r1
        ldiu      @_m_Variable+347,r0
        push      r0
        ldiu      516,r3
        addi      fp,r3
        push      rs
        push      r3
        call      _sprintf
                                        ; Call Occurs
        subi      9,sp
L69:        
	.line	201
;----------------------------------------------------------------------
; 215 | user_DebugPrint((char *)btBuf);                                        
; 217 | else                                                                   
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	204
;----------------------------------------------------------------------
; 218 | if(!strncmp(szBuf1,"LnWayClr",8))                                      
;----------------------------------------------------------------------
L71:        
        ldiu      @CL24,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L74
        subi      3,sp
        ldine     8,r2
        ldine     fp,r0
;*      Branch Occurs to L74 
	.line	206
;----------------------------------------------------------------------
; 220 | m_Variable.m_nLnWkWaySideOnRxOk = 0;                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+345
	.line	207
;----------------------------------------------------------------------
; 221 | user_DebugPrint("'m_nLnWkWaySideOnRxOk' Clear OK \r\n");               
; 223 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL25,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	210
;----------------------------------------------------------------------
; 224 | if(!strncmp(szBuf1,"LnFtpClr",8))                                      
;----------------------------------------------------------------------
L74:        
        ldiu      @CL26,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L77
        subi      3,sp
        ldine     7,r2
        ldine     fp,r0
;*      Branch Occurs to L77 
	.line	212
;----------------------------------------------------------------------
; 226 | m_Variable.m_bLnWkFtpEndFlag = FALSE;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+348
	.line	213
;----------------------------------------------------------------------
; 227 | user_DebugPrint("'m_bLnWkFtpEndFlag' Clear OK \r\n");                  
; 229 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL27,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	216
;----------------------------------------------------------------------
; 230 | if(!strncmp(szBuf1,"HisStTm",7))                                       
;----------------------------------------------------------------------
L77:        
        ldiu      @CL28,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L130
        subi      3,sp
        ldine     8,r2
        ldine     fp,r0
;*      Branch Occurs to L130 
	.line	218
;----------------------------------------------------------------------
; 232 | if(IS_ASCHEX(btRxBuf[8]) && IS_ASCHEX(btRxBuf[9]) &&                   
; 233 |         IS_ASCHEX(btRxBuf[10]) && IS_ASCHEX(btRxBuf[11]) &&            
; 234 |         IS_ASCHEX(btRxBuf[12]) && IS_ASCHEX(btRxBuf[13]) &&            
; 235 |         IS_ASCHEX(btRxBuf[14]) && IS_ASCHEX(btRxBuf[15]))              
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+8,r0
        cmpi      48,r0
        blo       L80
;*      Branch Occurs to L80 
        cmpi      57,r0
        bls       L84
;*      Branch Occurs to L84 
L80:        
        ldiu      @_btRxBuf$3+8,r0
        cmpi      65,r0
        blo       L82
;*      Branch Occurs to L82 
        cmpi      70,r0
        bls       L84
;*      Branch Occurs to L84 
L82:        
        ldiu      @_btRxBuf$3+8,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L84:        
        ldiu      @_btRxBuf$3+9,r0
        cmpi      48,r0
        blo       L86
;*      Branch Occurs to L86 
        cmpi      57,r0
        bls       L90
;*      Branch Occurs to L90 
L86:        
        ldiu      @_btRxBuf$3+9,r0
        cmpi      65,r0
        blo       L88
;*      Branch Occurs to L88 
        cmpi      70,r0
        bls       L90
;*      Branch Occurs to L90 
L88:        
        ldiu      @_btRxBuf$3+9,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L90:        
        ldiu      @_btRxBuf$3+10,r0
        cmpi      48,r0
        blo       L92
;*      Branch Occurs to L92 
        cmpi      57,r0
        bls       L96
;*      Branch Occurs to L96 
L92:        
        ldiu      @_btRxBuf$3+10,r0
        cmpi      65,r0
        blo       L94
;*      Branch Occurs to L94 
        cmpi      70,r0
        bls       L96
;*      Branch Occurs to L96 
L94:        
        ldiu      @_btRxBuf$3+10,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L96:        
        ldiu      @_btRxBuf$3+11,r0
        cmpi      48,r0
        blo       L98
;*      Branch Occurs to L98 
        cmpi      57,r0
        bls       L102
;*      Branch Occurs to L102 
L98:        
        ldiu      @_btRxBuf$3+11,r0
        cmpi      65,r0
        blo       L100
;*      Branch Occurs to L100 
        cmpi      70,r0
        bls       L102
;*      Branch Occurs to L102 
L100:        
        ldiu      @_btRxBuf$3+11,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L102:        
        ldiu      @_btRxBuf$3+12,r0
        cmpi      48,r0
        blo       L104
;*      Branch Occurs to L104 
        cmpi      57,r0
        bls       L108
;*      Branch Occurs to L108 
L104:        
        ldiu      @_btRxBuf$3+12,r0
        cmpi      65,r0
        blo       L106
;*      Branch Occurs to L106 
        cmpi      70,r0
        bls       L108
;*      Branch Occurs to L108 
L106:        
        ldiu      @_btRxBuf$3+12,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L108:        
        ldiu      @_btRxBuf$3+13,r0
        cmpi      48,r0
        blo       L110
;*      Branch Occurs to L110 
        cmpi      57,r0
        bls       L114
;*      Branch Occurs to L114 
L110:        
        ldiu      @_btRxBuf$3+13,r0
        cmpi      65,r0
        blo       L112
;*      Branch Occurs to L112 
        cmpi      70,r0
        bls       L114
;*      Branch Occurs to L114 
L112:        
        ldiu      @_btRxBuf$3+13,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L114:        
        ldiu      @_btRxBuf$3+14,r0
        cmpi      48,r0
        blo       L116
;*      Branch Occurs to L116 
        cmpi      57,r0
        bls       L120
;*      Branch Occurs to L120 
L116:        
        ldiu      @_btRxBuf$3+14,r0
        cmpi      65,r0
        blo       L118
;*      Branch Occurs to L118 
        cmpi      70,r0
        bls       L120
;*      Branch Occurs to L120 
L118:        
        ldiu      @_btRxBuf$3+14,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L120:        
        ldiu      @_btRxBuf$3+15,r0
        cmpi      48,r0
        blo       L122
;*      Branch Occurs to L122 
        cmpi      57,r0
        bls       L126
;*      Branch Occurs to L126 
L122:        
        ldiu      @_btRxBuf$3+15,r0
        cmpi      65,r0
        blo       L124
;*      Branch Occurs to L124 
        cmpi      70,r0
        bls       L126
;*      Branch Occurs to L126 
L124:        
        ldiu      @_btRxBuf$3+15,r0
        cmpi      97,r0
        blo       L128
;*      Branch Occurs to L128 
        cmpi      102,r0
        bhi       L128
;*      Branch Occurs to L128 
L126:        
	.line	223
;----------------------------------------------------------------------
; 237 | m_Variable.m_nDateTime2SecondCnt = MAKE_DWORD(                         
; 238 |         MAKE_BYTE(ConvAsc2Hex(btRxBuf[8]),ConvAsc2Hex(btRxBuf[9])),    
; 239 |         MAKE_BYTE(ConvAsc2Hex(btRxBuf[10]),ConvAsc2Hex(btRxBuf[11])),  
; 240 |         MAKE_BYTE(ConvAsc2Hex(btRxBuf[12]),ConvAsc2Hex(btRxBuf[13])),  
; 241 |         MAKE_BYTE(ConvAsc2Hex(btRxBuf[14]),ConvAsc2Hex(btRxBuf[15]))); 
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+8,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      r0,r4
        ldiu      @_btRxBuf$3+9,r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      @_btRxBuf$3+10,r1
        push      r1
        and       15,r0
        or3       r4,r0,r5
        and       255,r5
        ash       24,r5
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        ldiu      @_btRxBuf$3+11,r0
        subi      1,sp
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r1
        and       255,r1
        ash       16,r1
        ldiu      @_btRxBuf$3+12,r0
        subi      1,sp
        or3       r5,r1,r5
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        ldiu      @_btRxBuf$3+13,r0
        subi      1,sp
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r1
        and       255,r1
        subi      1,sp
        ldiu      @_btRxBuf$3+14,r0
        ash       8,r1
        push      r0
        or3       r5,r1,r5
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        ldiu      @_btRxBuf$3+15,r0
        subi      1,sp
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        or3       r5,r0,r0
        sti       r0,@_m_Variable+349
        subi      1,sp
	.line	230
;----------------------------------------------------------------------
; 244 | gm_SysTimeToRtc(&tmBuf,m_Variable.m_nDateTime2SecondCnt);              
;----------------------------------------------------------------------
        ldiu      r0,r1
        push      r1
        ldiu      783,r0
        addi      fp,r0
        push      r0
        call      _gm_SysTimeToRtc
                                        ; Call Occurs
        subi      2,sp
	.line	231
;----------------------------------------------------------------------
; 245 | sprintf(btBuf,"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour
;     | ],%02X[minute],%02X[second], Setting OK \r\n",                         
; 246 |         tmBuf.year,                                                    
; 247 |         tmBuf.month,                                                   
; 248 |         tmBuf.day,                                                     
; 249 |         tmBuf.hour,                                                    
; 250 |         tmBuf.minute,                                                  
; 251 |         tmBuf.second                                                   
; 252 |         );                                                             
;----------------------------------------------------------------------
        ldiu      783,ir0
        ldiu      *+fp(ir0),r0
        ldiu      784,ir1
        push      r0
        ldiu      *+fp(ir1),r0
        ldiu      785,ir0
        push      r0
        ldiu      *+fp(ir0),r0
        ldiu      786,ir0
        push      r0
        ldiu      *+fp(ir0),r1
        ldiu      787,ir1
        push      r1
        ldiu      *+fp(ir1),r1
        push      r1
        ldiu      788,ir0
        ldiu      @CL29,r0
        ldiu      *+fp(ir0),r1
        push      r1
        push      r0
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      8,sp
	.line	239
;----------------------------------------------------------------------
; 253 | user_DebugPrint((char *)btBuf);                                        
; 255 | else                                                                   
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
L128:        
	.line	243
;----------------------------------------------------------------------
; 257 | user_DebugPrint("No format \r\n");                                     
; 260 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL30,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	247
;----------------------------------------------------------------------
; 261 | if(!strncmp(szBuf1,"CarNoSet",8))                                      
;----------------------------------------------------------------------
L130:        
        ldiu      @CL31,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L146
        subi      3,sp
        ldine     9,r2
        ldine     fp,r0
;*      Branch Occurs to L146 
	.line	249
;----------------------------------------------------------------------
; 263 | if(IS_ASCNUMBER(btRxBuf[9]) && IS_ASCNUMBER(btRxBuf[10]) && IS_ASCNUMBE
;     | R(btRxBuf[11]) && IS_ASCNUMBER(btRxBuf[12]))                           
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+9,r0
        cmpi      48,r0
        blo       L143
;*      Branch Occurs to L143 
        cmpi      57,r0
        bhi       L143
;*      Branch Occurs to L143 
        ldiu      @_btRxBuf$3+10,r0
        cmpi      48,r0
        blo       L143
;*      Branch Occurs to L143 
        cmpi      57,r0
        bhi       L143
;*      Branch Occurs to L143 
        ldiu      @_btRxBuf$3+11,r0
        cmpi      48,r0
        blo       L143
;*      Branch Occurs to L143 
        cmpi      57,r0
        bhi       L143
;*      Branch Occurs to L143 
        ldiu      @_btRxBuf$3+12,r0
        cmpi      48,r0
        blo       L143
;*      Branch Occurs to L143 
        cmpi      57,r0
        bhi       L143
;*      Branch Occurs to L143 
	.line	251
;----------------------------------------------------------------------
; 265 | m_Variable.m_nCarNo = ConvAsc2Dec(btRxBuf[9])*1000 + ConvAsc2Dec(btRxBu
;     | f[10])*100 + ConvAsc2Dec(btRxBuf[11])*10 + ConvAsc2Dec(btRxBuf[12]);   
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+9,r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      1000,r1
        ldiu      @_btRxBuf$3+10,r2
        mpyi3     r1,r0,r4
        push      r2
        call      _ConvAsc2Dec
                                        ; Call Occurs
        ldiu      100,r1
        ldiu      @_btRxBuf$3+11,r2
        subi      1,sp
        push      r2
        mpyi3     r1,r0,r0
        addi3     r0,r4,r4
        call      _ConvAsc2Dec
                                        ; Call Occurs
        ldiu      10,r1
        ldiu      @_btRxBuf$3+12,r2
        subi      1,sp
        mpyi3     r1,r0,r0
        push      r2
        addi3     r0,r4,r4
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        addi3     r0,r4,r0              ; Unsigned
        sti       r0,@_m_Variable+340
	.line	252
;----------------------------------------------------------------------
; 266 | m_Variable.m_chCarKind = m_Variable.m_nCarNo&0x01 ? 'A' : 'B';         
;----------------------------------------------------------------------
        ldiu      1,r0
        tstb      @_m_Variable+340,r0
        beq       L141
;*      Branch Occurs to L141 
        bud       L142
	nop
	nop
        ldiu      65,r0
;*      Branch Occurs to L142 
L141:        
        ldiu      66,r0
L142:        
        sti       r0,@_m_Variable+341
	.line	253
;----------------------------------------------------------------------
; 267 | MyPrintf("Car Number = %d,%c Car \r\n",m_Variable.m_nCarNo,m_Variable.m
;     | _chCarKind);                                                           
; 269 | else                                                                   
;----------------------------------------------------------------------
        push      r0
        ldiu      @CL32,r1
        ldiu      @_m_Variable+340,r0
        push      r0
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      3,sp
        bu        L144
;*      Branch Occurs to L144 
L143:        
	.line	257
;----------------------------------------------------------------------
; 271 | MyPrintf("Invalid syntax\r\n");                                        
;----------------------------------------------------------------------
        ldiu      @CL33,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
L144:        
	.line	260
;----------------------------------------------------------------------
; 274 | user_CarNoForCarKindToLon();                                           
; 276 | else                                                                   
;----------------------------------------------------------------------
        call      _user_CarNoForCarKindToLon
                                        ; Call Occurs
        bu        L294
;*      Branch Occurs to L294 
	.line	263
;----------------------------------------------------------------------
; 277 | if(!strncmp(szBuf1,"WaySideON",9))                                     
;----------------------------------------------------------------------
L146:        
        ldiu      @CL34,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L152
        subi      3,sp
        ldine     9,r2
        ldine     fp,r0
;*      Branch Occurs to L152 
	.line	265
;----------------------------------------------------------------------
; 279 | m_Variable.m_nCDT_FaultDataStFlag = 1;                                 
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+336
	.line	266
;----------------------------------------------------------------------
; 280 | m_Variable.m_Recving_Posi = 0;                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+335
	.line	268
;----------------------------------------------------------------------
; 282 | gm_SysTimeToRtc(&tmBuf,m_Variable.m_nDateTime2SecondCnt);              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+349,r1
        ldiu      783,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _gm_SysTimeToRtc
                                        ; Call Occurs
        subi      2,sp
	.line	269
;----------------------------------------------------------------------
; 283 | sprintf(btBuf,"m_nCDT_FaultDataStFlag  = %d,%s, Date&Time : 20%02X[year
;     | ],%02X[month],%02X[day],%02X[hour],%02X[minute],%02X[second]\r\n",m_Var
;     | iable.m_nCDT_FaultDataStFlag,m_Variable.m_nLnWkTxFlag == 2 ? "Historica
;     | l" : "Recently",                                                       
; 284 |                 tmBuf.year,                                            
; 285 |                 tmBuf.month,                                           
; 286 |                 tmBuf.day,                                             
; 287 |                 tmBuf.hour,                                            
; 288 |                 tmBuf.minute,                                          
; 289 |                 tmBuf.second                                           
; 290 |         );                                                             
;----------------------------------------------------------------------
        ldiu      @_m_Variable+333,r0
        cmpi      2,r0
        bned      L150
        ldine     @CL35,r1
        ldine     783,ir1
        ldine     784,ir0
;*      Branch Occurs to L150 
        ldiu      @CL20,r1
        ldiu      783,ir1
        ldiu      784,ir0
L150:        
        ldiu      *+fp(ir1),r0
        push      r0
        ldiu      *+fp(ir0),r2
        ldiu      786,ir1
        ldiu      785,ir0
        push      r2
        ldiu      *+fp(ir0),r0
        push      r0
        ldiu      *+fp(ir1),r0
        push      r0
        ldiu      787,ir0
        ldiu      *+fp(ir0),r0
        ldiu      788,ir0
        push      r0
        ldiu      *+fp(ir0),r3
        push      r3
        push      r1
        ldiu      @CL36,r2
        ldiu      @_m_Variable+336,r1
        ldiu      516,r0
        push      r1
        addi      fp,r0
        push      r2
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      10,sp
	.line	277
;----------------------------------------------------------------------
; 291 | user_DebugPrint((char *)btBuf);                                        
; 293 | else                                                                   
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	280
;----------------------------------------------------------------------
; 294 | if(!strncmp(szBuf1,"CommStSet",9))                                     
;----------------------------------------------------------------------
L152:        
        ldiu      @CL37,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L230
        subi      3,sp
        ldine     9,r1
        ldine     fp,r0
;*      Branch Occurs to L230 
	.line	282
;----------------------------------------------------------------------
; 296 | if( IS_ASCHEX(btRxBuf[10]) &&IS_ASCHEX(btRxBuf[11]) &&                 
; 297 |         IS_ASCHEX(btRxBuf[12]) &&IS_ASCHEX(btRxBuf[13]) &&             
; 298 |         IS_ASCHEX(btRxBuf[14]) &&IS_ASCHEX(btRxBuf[15]) &&             
; 299 |         IS_ASCHEX(btRxBuf[16]) &&IS_ASCHEX(btRxBuf[17]))               
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+10,r0
        cmpi      48,r0
        blo       L155
;*      Branch Occurs to L155 
        cmpi      57,r0
        bls       L159
;*      Branch Occurs to L159 
L155:        
        ldiu      @_btRxBuf$3+10,r0
        cmpi      65,r0
        blo       L157
;*      Branch Occurs to L157 
        cmpi      70,r0
        bls       L159
;*      Branch Occurs to L159 
L157:        
        ldiu      @_btRxBuf$3+10,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L159:        
        ldiu      @_btRxBuf$3+11,r0
        cmpi      48,r0
        blo       L161
;*      Branch Occurs to L161 
        cmpi      57,r0
        bls       L165
;*      Branch Occurs to L165 
L161:        
        ldiu      @_btRxBuf$3+11,r0
        cmpi      65,r0
        blo       L163
;*      Branch Occurs to L163 
        cmpi      70,r0
        bls       L165
;*      Branch Occurs to L165 
L163:        
        ldiu      @_btRxBuf$3+11,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L165:        
        ldiu      @_btRxBuf$3+12,r0
        cmpi      48,r0
        blo       L167
;*      Branch Occurs to L167 
        cmpi      57,r0
        bls       L171
;*      Branch Occurs to L171 
L167:        
        ldiu      @_btRxBuf$3+12,r0
        cmpi      65,r0
        blo       L169
;*      Branch Occurs to L169 
        cmpi      70,r0
        bls       L171
;*      Branch Occurs to L171 
L169:        
        ldiu      @_btRxBuf$3+12,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L171:        
        ldiu      @_btRxBuf$3+13,r0
        cmpi      48,r0
        blo       L173
;*      Branch Occurs to L173 
        cmpi      57,r0
        bls       L177
;*      Branch Occurs to L177 
L173:        
        ldiu      @_btRxBuf$3+13,r0
        cmpi      65,r0
        blo       L175
;*      Branch Occurs to L175 
        cmpi      70,r0
        bls       L177
;*      Branch Occurs to L177 
L175:        
        ldiu      @_btRxBuf$3+13,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L177:        
        ldiu      @_btRxBuf$3+14,r0
        cmpi      48,r0
        blo       L179
;*      Branch Occurs to L179 
        cmpi      57,r0
        bls       L183
;*      Branch Occurs to L183 
L179:        
        ldiu      @_btRxBuf$3+14,r0
        cmpi      65,r0
        blo       L181
;*      Branch Occurs to L181 
        cmpi      70,r0
        bls       L183
;*      Branch Occurs to L183 
L181:        
        ldiu      @_btRxBuf$3+14,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L183:        
        ldiu      @_btRxBuf$3+15,r0
        cmpi      48,r0
        blo       L185
;*      Branch Occurs to L185 
        cmpi      57,r0
        bls       L189
;*      Branch Occurs to L189 
L185:        
        ldiu      @_btRxBuf$3+15,r0
        cmpi      65,r0
        blo       L187
;*      Branch Occurs to L187 
        cmpi      70,r0
        bls       L189
;*      Branch Occurs to L189 
L187:        
        ldiu      @_btRxBuf$3+15,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L189:        
        ldiu      @_btRxBuf$3+16,r0
        cmpi      48,r0
        blo       L191
;*      Branch Occurs to L191 
        cmpi      57,r0
        bls       L195
;*      Branch Occurs to L195 
L191:        
        ldiu      @_btRxBuf$3+16,r0
        cmpi      65,r0
        blo       L193
;*      Branch Occurs to L193 
        cmpi      70,r0
        bls       L195
;*      Branch Occurs to L195 
L193:        
        ldiu      @_btRxBuf$3+16,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L195:        
        ldiu      @_btRxBuf$3+17,r0
        cmpi      48,r0
        blo       L197
;*      Branch Occurs to L197 
        cmpi      57,r0
        bls       L201
;*      Branch Occurs to L201 
L197:        
        ldiu      @_btRxBuf$3+17,r0
        cmpi      65,r0
        blo       L199
;*      Branch Occurs to L199 
        cmpi      70,r0
        bls       L201
;*      Branch Occurs to L201 
L199:        
        ldiu      @_btRxBuf$3+17,r0
        cmpi      97,r0
        blo       L228
;*      Branch Occurs to L228 
        cmpi      102,r0
        bhi       L228
;*      Branch Occurs to L228 
L201:        
	.line	288
;----------------------------------------------------------------------
; 302 | FunConvAscHex((char *)&btRxBuf[10],sTemp,8);                           
;----------------------------------------------------------------------
        ldiu      8,r1
        ldiu      772,r0
        ldiu      @CL38,r2
        push      r1
        addi      fp,r0
        push      r0
        push      r2
        call      _FunConvAscHex
                                        ; Call Occurs
        subi      3,sp
	.line	290
;----------------------------------------------------------------------
; 304 | memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt));      
;----------------------------------------------------------------------
        ldiu      8,r2
        ldiu      0,r1
        ldiu      @CL39,r0
        push      r2
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	291
;----------------------------------------------------------------------
; 305 | pCommStatus_Lic = (COMMSTATUS_LIC *)m_Variable.m_btCommSt;             
;----------------------------------------------------------------------
        ldiu      792,ir0
        ldiu      @CL39,r0
        sti       r0,*+fp(ir0)
	.line	293
;----------------------------------------------------------------------
; 307 | pCommStatus_Lic->BYTE_1.BYTE = sTemp[0];                               
;----------------------------------------------------------------------
        ldiu      792,ir1
        ldiu      772,ir0
        ldiu      *+fp(ir1),ar0
        ldiu      *+fp(ir0),r0
        sti       r0,*ar0
	.line	294
;----------------------------------------------------------------------
; 308 | pCommStatus_Lic->BYTE_2.BYTE = sTemp[1];                               
;----------------------------------------------------------------------
        ldiu      792,ir0
        ldiu      773,ir1
        ldiu      *+fp(ir0),ar0
        ldiu      *+fp(ir1),r0
        sti       r0,*+ar0(1)
	.line	295
;----------------------------------------------------------------------
; 309 | pCommStatus_Lic->BYTE_3.BYTE = sTemp[2];                               
;----------------------------------------------------------------------
        ldiu      774,ir1
        ldiu      *+fp(ir0),ar0
        ldiu      *+fp(ir1),r0
        sti       r0,*+ar0(2)
	.line	296
;----------------------------------------------------------------------
; 310 | pCommStatus_Lic->BYTE_4.BYTE = sTemp[3];                               
;----------------------------------------------------------------------
        ldiu      775,ir1
        ldiu      *+fp(ir0),ar0
        ldiu      *+fp(ir1),r0
        sti       r0,*+ar0(3)
	.line	298
;----------------------------------------------------------------------
; 312 | MyPrintf("CommStSet =  %02X-%02X-%02X-%02X \r\n",                      
; 313 | m_Variable.m_btCommSt[0],                                              
; 314 | m_Variable.m_btCommSt[1],                                              
; 315 | m_Variable.m_btCommSt[2],                                              
; 316 | m_Variable.m_btCommSt[3]);                                             
;----------------------------------------------------------------------
        ldiu      @_m_Variable+307,rs
        ldiu      @_m_Variable+308,r0
        ldiu      @_m_Variable+310,r2
        ldiu      @_m_Variable+309,r1
        push      r2
        push      r1
        push      r0
        ldiu      @CL40,r3
        push      rs
        push      r3
        call      _MyPrintf
                                        ; Call Occurs
        subi      5,sp
	.line	304
;----------------------------------------------------------------------
; 318 | for(i=0;i<8;i++)                                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        bge       L227
;*      Branch Occurs to L227 
L202:        
	.line	306
;----------------------------------------------------------------------
; 320 | if(!(m_Variable.m_btOldCommSt[i]&0x01) && (m_Variable.m_btCommSt[i]&0x0
;     | 1)) m_Variable.m_btSenseCommStBuf[i] |= 0x01;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      1,r0
        tstb3     *+ar0(ir0),r0
        bne       L205
;*      Branch Occurs to L205 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L205
;*      Branch Occurs to L205 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L205:        
	.line	307
;----------------------------------------------------------------------
; 321 | if(!(m_Variable.m_btOldCommSt[i]&0x02) && (m_Variable.m_btCommSt[i]&0x0
;     | 2)) m_Variable.m_btSenseCommStBuf[i] |= 0x02;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      2,r0
        tstb3     *+ar0(ir0),r0
        bne       L208
;*      Branch Occurs to L208 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L208
;*      Branch Occurs to L208 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L208:        
	.line	308
;----------------------------------------------------------------------
; 322 | if(!(m_Variable.m_btOldCommSt[i]&0x04) && (m_Variable.m_btCommSt[i]&0x0
;     | 4)) m_Variable.m_btSenseCommStBuf[i] |= 0x04;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      4,r0
        tstb3     *+ar0(ir0),r0
        bne       L211
;*      Branch Occurs to L211 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L211
;*      Branch Occurs to L211 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L211:        
	.line	309
;----------------------------------------------------------------------
; 323 | if(!(m_Variable.m_btOldCommSt[i]&0x08) && (m_Variable.m_btCommSt[i]&0x0
;     | 8)) m_Variable.m_btSenseCommStBuf[i] |= 0x08;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      8,r0
        tstb3     *+ar0(ir0),r0
        bne       L214
;*      Branch Occurs to L214 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L214
;*      Branch Occurs to L214 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L214:        
	.line	310
;----------------------------------------------------------------------
; 324 | if(!(m_Variable.m_btOldCommSt[i]&0x10) && (m_Variable.m_btCommSt[i]&0x1
;     | 0)) m_Variable.m_btSenseCommStBuf[i] |= 0x10;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      16,r0
        tstb3     *+ar0(ir0),r0
        bne       L217
;*      Branch Occurs to L217 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L217
;*      Branch Occurs to L217 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L217:        
	.line	311
;----------------------------------------------------------------------
; 325 | if(!(m_Variable.m_btOldCommSt[i]&0x20) && (m_Variable.m_btCommSt[i]&0x2
;     | 0)) m_Variable.m_btSenseCommStBuf[i] |= 0x20;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      32,r0
        tstb3     *+ar0(ir0),r0
        bne       L220
;*      Branch Occurs to L220 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L220
;*      Branch Occurs to L220 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L220:        
	.line	312
;----------------------------------------------------------------------
; 326 | if(!(m_Variable.m_btOldCommSt[i]&0x40) && (m_Variable.m_btCommSt[i]&0x4
;     | 0)) m_Variable.m_btSenseCommStBuf[i] |= 0x40;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      64,r0
        tstb3     *+ar0(ir0),r0
        bne       L223
;*      Branch Occurs to L223 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L223
;*      Branch Occurs to L223 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L223:        
	.line	313
;----------------------------------------------------------------------
; 327 | if(!(m_Variable.m_btOldCommSt[i]&0x80) && (m_Variable.m_btCommSt[i]&0x8
;     | 0)) m_Variable.m_btSenseCommStBuf[i] |= 0x80;                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL41,ar0
        ldiu      128,r0
        tstb3     *+ar0(ir0),r0
        bne       L226
;*      Branch Occurs to L226 
        ldiu      @CL39,ar0
        tstb3     *+ar0(ir0),r0
        beq       L226
;*      Branch Occurs to L226 
        ldiu      ir0,ar0
        ldiu      @CL42,ir0
        or3       r0,*+ar0(ir0),r0
        sti       r0,*+ar0(ir0)
L226:        
	.line	304
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        blt       L202
;*      Branch Occurs to L202 
L227:        
	.line	316
;----------------------------------------------------------------------
; 330 | memcpy(m_Variable.m_btOldCommSt,m_Variable.m_btCommSt,8);              
; 332 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL41,ar1
        ldiu      @CL39,ar0
        ldiu      *ar0++(1),r0
        rpts      6                     ; Fast MEMCPY(#3)
        sti       r0,*ar1++(1)
||      ldi       *ar0++(1),r0
        sti       r0,*ar1++(1)
        bu        L294
;*      Branch Occurs to L294 
L228:        
	.line	320
;----------------------------------------------------------------------
; 334 | MyPrintf("Invalid syntax\r\n");                                        
; 337 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL33,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	324
;----------------------------------------------------------------------
; 338 | if(!strncmp(szBuf1,"TrainConf",9))                                     
;----------------------------------------------------------------------
L230:        
        ldiu      @CL43,r2
        push      r1
        addi      4,r0
        push      r2
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L239
        subi      3,sp
        ldine     9,r1
        ldine     fp,r0
;*      Branch Occurs to L239 
	.line	326
;----------------------------------------------------------------------
; 340 | if(IS_ASCNUMBER(btRxBuf[10]))                                          
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+10,r0
        cmpi      48,r0
        blo       L237
;*      Branch Occurs to L237 
        cmpi      57,r0
        bhi       L237
;*      Branch Occurs to L237 
	.line	328
;----------------------------------------------------------------------
; 342 | m_Variable.m_TrainCofVal = MIN(3,ConvAsc2Hex(btRxBuf[10]));            
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+10,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      3,r1
        cmpi3     r0,r1
        bhsd      L235
        subi      1,sp
	nop
        ldihs     @_btRxBuf$3+10,r0
;*      Branch Occurs to L235 
        bud       L236
	nop
	nop
        ldiu      3,r0
;*      Branch Occurs to L236 
L235:        
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
L236:        
        sti       r0,@_m_Variable+337
	.line	329
;----------------------------------------------------------------------
; 343 | MyPrintf("TrainConf value = %02X \r\n",m_Variable.m_TrainCofVal);      
; 345 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL44,r1
        push      r0
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
        bu        L294
;*      Branch Occurs to L294 
L237:        
	.line	333
;----------------------------------------------------------------------
; 347 | MyPrintf("Invalid syntax\r\n");                                        
; 350 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL33,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	337
;----------------------------------------------------------------------
; 351 | if(!strncmp(szBuf1,"CarPosSet",9))                                     
;----------------------------------------------------------------------
L239:        
        ldiu      @CL45,r2
        push      r1
        addi      4,r0
        push      r2
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L248
        subi      3,sp
        ldine     10,r1
        ldine     fp,r0
;*      Branch Occurs to L248 
	.line	339
;----------------------------------------------------------------------
; 353 | if(IS_ASCNUMBER(btRxBuf[10]))                                          
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+10,r0
        cmpi      48,r0
        blo       L246
;*      Branch Occurs to L246 
        cmpi      57,r0
        bhi       L246
;*      Branch Occurs to L246 
	.line	341
;----------------------------------------------------------------------
; 355 | if(ConvAsc2Dec(btRxBuf[10]) >= 1 && ConvAsc2Dec(btRxBuf[10]) <= 8)     
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+10,r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        ble       L245
;*      Branch Occurs to L245 
        ldiu      @_btRxBuf$3+10,r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        cmpi      8,r0
        subi      1,sp
        bgt       L245
;*      Branch Occurs to L245 
	.line	343
;----------------------------------------------------------------------
; 357 | m_Variable.m_nCarPos = ConvAsc2Dec(btRxBuf[10]);                       
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+10,r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        sti       r0,@_m_Variable+338
        subi      1,sp
	.line	344
;----------------------------------------------------------------------
; 358 | MyPrintf("CarPosVal = %02X \r\n",m_Variable.m_nCarPos);                
; 360 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL46,r1
        push      r0
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
        bu        L294
;*      Branch Occurs to L294 
L245:        
	.line	348
;----------------------------------------------------------------------
; 362 | MyPrintf("Invalid syntax [%d]\r\n",ConvAsc2Dec(btRxBuf[10]));          
; 365 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+10,r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        ldiu      @CL47,r1
        subi      1,sp
        push      r0
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
        bu        L294
;*      Branch Occurs to L294 
L246:        
	.line	353
;----------------------------------------------------------------------
; 367 | MyPrintf("Invalid syntax\r\n");                                        
; 370 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL33,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	357
;----------------------------------------------------------------------
; 371 | if(!strncmp(szBuf1,"CiFaultSet",10))                                   
;----------------------------------------------------------------------
L248:        
        ldiu      @CL48,r2
        push      r1
        addi      4,r0
        push      r2
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L256
        subi      3,sp
        ldine     6,r1
        ldine     fp,r0
;*      Branch Occurs to L256 
	.line	359
;----------------------------------------------------------------------
; 373 | if( IS_ASCNUMBER(btRxBuf[11]) && IS_ASCNUMBER(btRxBuf[12]))            
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+11,r0
        cmpi      48,r0
        blo       L254
;*      Branch Occurs to L254 
        cmpi      57,r0
        bhi       L254
;*      Branch Occurs to L254 
        ldiu      @_btRxBuf$3+12,r0
        cmpi      48,r0
        blo       L254
;*      Branch Occurs to L254 
        cmpi      57,r0
        bhi       L254
;*      Branch Occurs to L254 
	.line	361
;----------------------------------------------------------------------
; 375 | m_Variable.m_btCiFaultVal = MAKE_WORD(ConvAsc2Hex(btRxBuf[11]),ConvAsc2
;     | Hex(btRxBuf[12]));                                                     
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+11,r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      @_btRxBuf$3+12,r1
        ldiu      r0,r4
        ash       8,r4
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       255,r0
        or3       r4,r0,r0
        and       65535,r0
        sti       r0,@_m_Variable+339
        subi      1,sp
	.line	362
;----------------------------------------------------------------------
; 376 | MyPrintf("CiFault Val = %02X \r\n",m_Variable.m_btCiFaultVal);         
; 378 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL49,r1
        push      r0
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
        bu        L294
;*      Branch Occurs to L294 
L254:        
	.line	366
;----------------------------------------------------------------------
; 380 | MyPrintf("Invalid syntax\r\n");                                        
; 383 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL33,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	370
;----------------------------------------------------------------------
; 384 | if(!strncmp(szBuf1,"VerSet",6))                                        
;----------------------------------------------------------------------
L256:        
        ldiu      @CL50,r2
        push      r1
        addi      4,r0
        push      r2
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L289
        subi      3,sp
        ldine     1,r2
        ldine     fp,r0
;*      Branch Occurs to L289 
	.line	373
;----------------------------------------------------------------------
; 387 | if( IS_ASCNUMBER(btRxBuf[7]) && IS_ASCNUMBER(btRxBuf[8]) &&            
; 389 |         IS_ASCNUMBER(btRxBuf[10]) && IS_ASCNUMBER(btRxBuf[11]) &&      
; 390 |         IS_ASCNUMBER(btRxBuf[12]) && IS_ASCNUMBER(btRxBuf[13]) &&      
; 392 |         IS_ASCNUMBER(btRxBuf[15]) && IS_ASCNUMBER(btRxBuf[16]) &&      
; 393 |         IS_ASCNUMBER(btRxBuf[17]) && IS_ASCNUMBER(btRxBuf[18]) &&      
; 394 |         IS_ASCNUMBER(btRxBuf[19]) && IS_ASCNUMBER(btRxBuf[20])         
; 395 |         )                                                              
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+7,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+8,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+10,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+11,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+12,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+13,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+15,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+16,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+17,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+18,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+19,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
        ldiu      @_btRxBuf$3+20,r0
        cmpi      48,r0
        blo       L287
;*      Branch Occurs to L287 
        cmpi      57,r0
        bhi       L287
;*      Branch Occurs to L287 
	.line	383
;----------------------------------------------------------------------
; 397 | sIndex = ConvAsc2Dec(btRxBuf[7])*10 + ConvAsc2Dec(btRxBuf[8]);         
;----------------------------------------------------------------------
        ldiu      @_btRxBuf$3+7,r0
        push      r0
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        ldiu      10,r1
        ldiu      @_btRxBuf$3+8,r2
        mpyi3     r1,r0,r4
        push      r2
        call      _ConvAsc2Dec
                                        ; Call Occurs
        subi      1,sp
        addi3     r0,r4,r0
        sti       r0,*+fp(3)
	.line	384
;----------------------------------------------------------------------
; 398 | sIndex = MIN(VER_BDD_MAX_CNT,sIndex);                                  
;----------------------------------------------------------------------
        ldiu      32,r0
        cmpi      *+fp(3),r0
        bge       L283
;*      Branch Occurs to L283 
        bu        L284
;*      Branch Occurs to L284 
L283:        
        ldiu      *+fp(3),r0
L284:        
        sti       r0,*+fp(3)
	.line	386
;----------------------------------------------------------------------
; 400 | pLicVerDp->cvbBuf[sIndex].chVer[0] = btRxBuf[10];                      
;----------------------------------------------------------------------
        ldiu      791,ir0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+10,r0
        sti       r0,*+ar0(1)
	.line	387
;----------------------------------------------------------------------
; 401 | pLicVerDp->cvbBuf[sIndex].chVer[1] = btRxBuf[11];                      
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+11,r0
        sti       r0,*+ar0(2)
	.line	388
;----------------------------------------------------------------------
; 402 | pLicVerDp->cvbBuf[sIndex].chVer[2] = btRxBuf[12];                      
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+12,r0
        sti       r0,*+ar0(3)
	.line	389
;----------------------------------------------------------------------
; 403 | pLicVerDp->cvbBuf[sIndex].chVer[3] = btRxBuf[13];                      
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+13,r0
        sti       r0,*+ar0(4)
	.line	391
;----------------------------------------------------------------------
; 405 | pLicVerDp->cvbBuf[sIndex].chBuildDate[0]=btRxBuf[15];                  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+15,r0
        sti       r0,*+ar0(5)
	.line	392
;----------------------------------------------------------------------
; 406 | pLicVerDp->cvbBuf[sIndex].chBuildDate[1]=btRxBuf[16];                  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+16,r0
        sti       r0,*+ar0(6)
	.line	393
;----------------------------------------------------------------------
; 407 | pLicVerDp->cvbBuf[sIndex].chBuildDate[2]=btRxBuf[17];                  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+17,r0
        sti       r0,*+ar0(7)
	.line	394
;----------------------------------------------------------------------
; 408 | pLicVerDp->cvbBuf[sIndex].chBuildDate[3]=btRxBuf[18];                  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+18,r0
        sti       r0,*+ar0(8)
	.line	395
;----------------------------------------------------------------------
; 409 | pLicVerDp->cvbBuf[sIndex].chBuildDate[4]=btRxBuf[19];                  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+19,r0
        sti       r0,*+ar0(9)
	.line	396
;----------------------------------------------------------------------
; 410 | pLicVerDp->cvbBuf[sIndex].chBuildDate[5]=btRxBuf[20];                  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      @_btRxBuf$3+20,r0
        sti       r0,*+ar0(10)
	.line	398
;----------------------------------------------------------------------
; 412 | LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[0])),
;     | ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[1])));              
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      255,r0
        and       *+ar0(1),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      791,ir0
        ldiu      *+fp(3),r2
        ldiu      255,r1
        ldiu      r0,r4
        mpyi      10,r2
        addi3     r2,*+fp(ir0),ar0      ; Unsigned
        ash       4,r4
        and       *+ar0(2),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      795,ir0
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	399
;----------------------------------------------------------------------
; 413 | LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[2])),
;     | ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[3])));              
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        ldiu      791,ir0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      255,r0
        and       *+ar0(3),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      255,r1
        ldiu      *+fp(3),r2
        mpyi      10,r2
        ldiu      791,ir0
        ldiu      r0,r4
        addi3     r2,*+fp(ir0),ar0      ; Unsigned
        ash       4,r4
        and       *+ar0(4),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      796,ir0
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	400
;----------------------------------------------------------------------
; 414 | m_Variable.m_btExVersionTbl[sIndex] = MAKE_WORD(LH,LL);                
;----------------------------------------------------------------------
        ldiu      8,r1
        ldiu      795,ir0
        ldiu      796,ir1
        ash3      r1,*+fp(ir0),r1
        ldiu      255,r0
        and3      r0,*+fp(ir1),r0
        or3       r1,r0,r0
        ldiu      *+fp(3),ir0
        ldiu      @CL51,ar0
        and       65535,r0
        sti       r0,*+ar0(ir0)
	.line	401
;----------------------------------------------------------------------
; 415 | HH = 0x20;                                                             
;----------------------------------------------------------------------
        ldiu      793,ir0
        ldiu      32,r0
        sti       r0,*+fp(ir0)
	.line	402
;----------------------------------------------------------------------
; 416 | HL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate
;     | [0])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[1])));  
;----------------------------------------------------------------------
        ldiu      791,ir0
        ldiu      *+fp(3),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      255,r0
        and       *+ar0(5),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      791,ir0
        subi      1,sp
        ldiu      255,r1
        ldiu      *+fp(3),r2
        ldiu      r0,r4
        mpyi      10,r2
        addi3     r2,*+fp(ir0),ar0      ; Unsigned
        ash       4,r4
        and       *+ar0(6),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      794,ir0
        and       15,r0
        subi      1,sp
        or3       r4,r0,r0
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	403
;----------------------------------------------------------------------
; 417 | LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate
;     | [2])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[3])));  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        ldiu      791,ir0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      255,r0
        and       *+ar0(7),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),r2
        ldiu      791,ir0
        mpyi      10,r2
        addi3     r2,*+fp(ir0),ar0      ; Unsigned
        ldiu      255,r1
        ldiu      r0,r4
        ash       4,r4
        and       *+ar0(8),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      795,ir0
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	404
;----------------------------------------------------------------------
; 418 | LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate
;     | [4])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[5])));  
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        ldiu      791,ir0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      255,r0
        and       *+ar0(9),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      r0,r4
        subi      1,sp
        ldiu      791,ir0
        ldiu      *+fp(3),r2
        ldiu      255,r1
        mpyi      10,r2
        addi3     r2,*+fp(ir0),ar0      ; Unsigned
        ash       4,r4
        and       *+ar0(10),r1
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      796,ir0
        and       15,r0
        or3       r4,r0,r0
        subi      1,sp
        and       255,r0
        sti       r0,*+fp(ir0)
	.line	405
;----------------------------------------------------------------------
; 419 | m_Variable.m_btExVersion_DAYTbl[sIndex] = MAKE_DWORD(HH,HL,LH,LL);     
;----------------------------------------------------------------------
        ldiu      255,r2
        ldiu      794,ir1
        ldiu      795,ir0
        ldiu      255,r0
        and3      r2,*+fp(ir0),r2
        and3      r0,*+fp(ir1),r1
        ldiu      793,ir0
        ldiu      24,r0
        ash3      r0,*+fp(ir0),r0
        ash       16,r1
        ldiu      255,r3
        ash       8,r2
        or3       r0,r1,r0
        ldiu      796,ir1
        or3       r0,r2,r0
        and3      r3,*+fp(ir1),r1
        ldiu      @CL52,ar0
        ldiu      *+fp(3),ir0
        or3       r0,r1,r0
        sti       r0,*+ar0(ir0)
	.line	407
;----------------------------------------------------------------------
; 421 | memset(btBuf,0x00,256);                                                
;----------------------------------------------------------------------
        ldiu      256,r1
        push      r1
        ldiu      0,r0
        push      r0
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	408
;----------------------------------------------------------------------
; 422 | memcpy(btBuf,&m_Variable.LIC_VerList[sIndex][0],strlen((char*)&m_Variab
;     | le.LIC_VerList[sIndex][0]));                                           
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        mpyi      9,r0
        addi      @CL14,r0              ; Unsigned
        push      r0
        call      _strlen
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(3),r2
        ldiu      516,r1
        push      r0
        mpyi      9,r2
        addi      fp,r1
        ldiu      @CL14,r0
        addi      r2,r0
        push      r0
        push      r1
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	409
;----------------------------------------------------------------------
; 423 | sprintf(&btBuf[strlen((char*)&btBuf)],":");                            
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      @CL15,r1
        subi      1,sp
        addi3     r0,fp,r0              ; Unsigned
        push      r1
        addi      516,r0                ; Unsigned
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      2,sp
	.line	410
;----------------------------------------------------------------------
; 424 | memcpy(&btBuf[strlen((char*)&btBuf)],&pLicVerDp->cvbBuf[sIndex].chVer[0
;     | ],4);                                                                  
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      791,ir0
        subi      1,sp
        ldiu      *+fp(3),r1
        mpyi      10,r1
        addi3     r1,*+fp(ir0),ar0      ; Unsigned
        addi3     r0,fp,ar1             ; Unsigned
        addi      1,ar0                 ; Unsigned
        addi      516,ar1               ; Unsigned
        ldiu      *ar0,r0
        sti       r0,*ar1
        ldiu      *+ar0,r0
        sti       r0,*+ar1
        ldiu      *+ar0(2),r0
        sti       r0,*+ar1(2)
        ldiu      *+ar0(3),r0
        sti       r0,*+ar1(3)
	.line	411
;----------------------------------------------------------------------
; 425 | sprintf(&btBuf[strlen((char*)&btBuf)],":");                            
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      @CL15,r1
        subi      1,sp
        addi3     r0,fp,r0              ; Unsigned
        push      r1
        addi      516,r0                ; Unsigned
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      2,sp
	.line	412
;----------------------------------------------------------------------
; 426 | memcpy(&btBuf[strlen((char*)&btBuf)],&pLicVerDp->cvbBuf[sIndex].chBuild
;     | Date[0],6);                                                            
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        subi      1,sp
        ldiu      791,ir0
        ldiu      *+fp(3),r1
        mpyi      10,r1
        addi3     r1,*+fp(ir0),ar1      ; Unsigned
        addi3     r0,fp,ar0             ; Unsigned
        addi      516,ar0               ; Unsigned
        addi      5,ar1                 ; Unsigned
        ldiu      *ar1++(1),r0
        rpts      4                     ; Fast MEMCPY(#6)
        sti       r0,*ar0++(1)
||      ldi       *ar1++(1),r0
        sti       r0,*ar0++(1)
	.line	413
;----------------------------------------------------------------------
; 427 | sprintf(&btBuf[strlen((char*)&btBuf)],"\r\n");                         
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      @CL16,r1
        subi      1,sp
        push      r1
        addi3     r0,fp,r0              ; Unsigned
        addi      516,r0                ; Unsigned
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      2,sp
	.line	415
;----------------------------------------------------------------------
; 429 | user_DebugPrint((char *)btBuf);                                        
; 432 | else                                                                   
;----------------------------------------------------------------------
        ldiu      516,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
L287:        
	.line	420
;----------------------------------------------------------------------
; 434 | user_DebugPrint("Syntax error\r\n");                                   
; 438 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL53,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	425
;----------------------------------------------------------------------
; 439 | if(!strncmp(szBuf1,"?",1))                                             
;----------------------------------------------------------------------
L289:        
        ldiu      @CL54,r1
        push      r2
        addi      4,r0
        push      r1
        push      r0
        call      _strncmp
                                        ; Call Occurs
        cmpi      0,r0
        bned      L293
        subi      3,sp
	nop
        ldine     @CL53,r0
;*      Branch Occurs to L293 
	.line	427
;----------------------------------------------------------------------
; 441 | MyPrintf("[ENTER]      : Move next line after out '->' \r\n");         
;----------------------------------------------------------------------
        ldiu      @CL55,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	428
;----------------------------------------------------------------------
; 442 | MyPrintf("'?'          : Help \r\n");                                  
;----------------------------------------------------------------------
        ldiu      @CL56,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	429
;----------------------------------------------------------------------
; 443 | MyPrintf("'Time'       : Date&time setting , 'Time=YYMMDDHHMNSS', 'EX)T
;     | ime=120102030405' \r\n");                                              
;----------------------------------------------------------------------
        ldiu      @CL57,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	430
;----------------------------------------------------------------------
; 444 | MyPrintf("'t'          : Date&time read \r\n");                        
;----------------------------------------------------------------------
        ldiu      @CL58,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	431
;----------------------------------------------------------------------
; 445 | MyPrintf("'Version     : Version \r\n");                               
;----------------------------------------------------------------------
        ldiu      @CL59,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	432
;----------------------------------------------------------------------
; 446 | MyPrintf("'Recent'     : Recently faults start \r\n");                 
;----------------------------------------------------------------------
        ldiu      @CL60,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	433
;----------------------------------------------------------------------
; 447 | MyPrintf("'Historical' : Historical data start \r\n");                 
;----------------------------------------------------------------------
        ldiu      @CL61,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	434
;----------------------------------------------------------------------
; 448 | MyPrintf("'Rxinfo'     : Recieve info \r\n");                          
;----------------------------------------------------------------------
        ldiu      @CL62,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	435
;----------------------------------------------------------------------
; 449 | MyPrintf("'LnWayClr'   : 'm_nLnWkWaySideOnRxOk' variable clear \r\n"); 
;----------------------------------------------------------------------
        ldiu      @CL63,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	436
;----------------------------------------------------------------------
; 450 | MyPrintf("'LnFtpClr'   : 'm_bLnWkFtpEndFlag' variable clear \r\n");    
;----------------------------------------------------------------------
        ldiu      @CL64,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	437
;----------------------------------------------------------------------
; 451 | MyPrintf("'HisStTm'    : Historical data start time set(2000/1/1 0:0:0
;     | ~ total second), HisStTm=XXXXXXXX, 'EX)HisStTm=0000000F' \r\n");       
;----------------------------------------------------------------------
        ldiu      @CL65,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	438
;----------------------------------------------------------------------
; 452 | MyPrintf("'CarNoSet'   : Car number set. CarNoSet=XXXX, EX)CarNoSet=400
;     | 1 -> [%d[0x%X],%c CAR]\r\n",m_Variable.m_nCarNo,m_Variable.m_nCarNo,m_V
;     | ariable.m_chCarKind);                                                  
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r1
        ldiu      @CL66,r0
        push      r1
        ldiu      @_m_Variable+340,r1
        push      r1
        ldiu      @_m_Variable+340,r1
        push      r1
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      4,sp
	.line	439
;----------------------------------------------------------------------
; 453 | MyPrintf("'TrainConf'  : Train Configuration. TrainConf=X(X : 0~3[2,4,6
;     | ,8Car]) => [0x%X]\r\n",m_Variable.m_TrainCofVal);                      
;----------------------------------------------------------------------
        ldiu      @_m_Variable+337,r0
        push      r0
        ldiu      @CL67,r1
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	440
;----------------------------------------------------------------------
; 454 | MyPrintf("'CarPosSet'  : Car index position. CarPosSet=X(X:1~8) 'EX)Car
;     | PosSet=1' => [0x%X]\r\n",m_Variable.m_nCarPos);                        
;----------------------------------------------------------------------
        ldiu      @_m_Variable+338,r0
        push      r0
        ldiu      @CL68,r1
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	441
;----------------------------------------------------------------------
; 455 | MyPrintf("'CiFaultSet' : Other C/I Fault. CiFaultSet=XX 'EX)CiFaultSet=
;     | 00' => [0x%02X]\r\n",m_Variable.m_btCiFaultVal);                       
;----------------------------------------------------------------------
        ldiu      @_m_Variable+339,r1
        ldiu      @CL69,r0
        push      r1
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	442
;----------------------------------------------------------------------
; 456 | MyPrintf("'WaySideON'  : WaySide_ON \r\n");                            
;----------------------------------------------------------------------
        ldiu      @CL70,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	443
;----------------------------------------------------------------------
; 457 | 		MyPrintf("'CommStSet'  : Comm Status. CommStSet=XXXXXXXX  'EX) CommSt
;     | Set=FF7F1F53' => [0x%02X,0x%02X,0x%02X,0x%02X]\r\n",WORD_L(m_Variable.m
;     | _btCommSt[0]),WORD_L(m_Variable.m_btCommSt[1]),WORD_L(m_Variable.m_btCo
;     | mmSt[2]),WORD_L(m_Variable.m_btCom                                     
;----------------------------------------------------------------------
        ldiu      255,r1
        ldiu      255,r3
        ldiu      255,rs
        and       @_m_Variable+309,r3
        ldiu      255,r0
        and       @_m_Variable+308,r1
        and       @_m_Variable+307,rs
        and       @_m_Variable+310,r0
        push      r0
        push      r3
        push      r1
        push      rs
        ldiu      @CL71,r2
        push      r2
        call      _MyPrintf
                                        ; Call Occurs
        subi      5,sp
	.line	444
;----------------------------------------------------------------------
; 458 | mSt[3]));                                                              
;----------------------------------------------------------------------
        ldiu      @CL72,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	445
;----------------------------------------------------------------------
; 459 | MyPrintf("'VerSet'     : Each unit version set. VerSet=XX(incdex):XXXX(
;     | Ver):XXXXXX(BuildDate) \r\n");                                         
; 460 | MyPrintf("\r\n");                                                      
; 462 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @CL16,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
        bu        L294
;*      Branch Occurs to L294 
	.line	449
;----------------------------------------------------------------------
; 464 | user_DebugPrint("Syntax error\r\n");                                   
;----------------------------------------------------------------------
L293:        
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
L294:        
	.line	452
;----------------------------------------------------------------------
; 467 | nOldUart1RxOneByteGapDelayTime = m_Variable.m_nUart1RxOneByteGapDelayTi
;     | me;                                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+288,r0
        sti       r0,@_nOldUart1RxOneByteGapDelayTime$2+0
L295:        
	.line	454
        pop       ar5
        ldiu      *-fp(1),bk
        pop       ar4
        pop       r5
        ldiu      *fp,fp
        pop       r4
        subi      798,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	468,000003030h,796


	.sect	 ".text"

	.global	_Debug_1msLoop
	.sym	_Debug_1msLoop,_Debug_1msLoop,32,2,0
	.func	474
;******************************************************************************
;* FUNCTION NAME: _Debug_1msLoop                                              *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,st                                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_Debug_1msLoop:
	.line	1
;----------------------------------------------------------------------
; 474 | //*********************************************************************
;     | *********************                                                  
; 475 | void Debug_1msLoop()                                                   
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 477 | if(m_Variable.m_nUart1RxOneByteGapDelayTime) m_Variable.m_nUart1RxOneBy
;     | teGapDelayTime--;                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+288,r0
        beq       L299
;*      Branch Occurs to L299 
        ldiu      1,r0
        subri     @_m_Variable+288,r0   ; Unsigned
        sti       r0,@_m_Variable+288
L299:        
	.line	5
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	478,000000000h,0


;******************************************************************************
;* STRINGS                                                                    *
;******************************************************************************
	.sect	".const"
SL1:	.byte	"->",13,10,0
SL2:	.byte	"Time",0
SL3:	.byte	"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%"
	.byte	"02X[minute],%02X[second] ",13,10,0
SL4:	.byte	"Not Date&time format ",13,10,0
SL5:	.byte	"t",0
SL6:	.byte	"Version",0
SL7:	.byte	"LIC-MPU Version:%d.%d%d%d,Build Date:20%06d, LIC-LON Versio"
	.byte	"n:%d.%d%d%d,Build Date:%08X",13,10,0
SL8:	.byte	":",0
SL9:	.byte	13,10,0
SL10:	.byte	13,10,13,10,0
SL11:	.byte	"Recent",0
SL12:	.byte	"Recent fault read start send ",13,10,0
SL13:	.byte	"Historical",0
SL14:	.byte	"Historical read start send, Historical start time : %08XH, "
	.byte	"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%"
	.byte	"02X[minute],%02X[second] ",13,10,0
SL15:	.byte	"Rxinfo",0
SL16:	.byte	"Total byte : %d, Packet count : %d, window count : %d, rema"
	.byte	"ind packet : %d, m_nLnWkWaySideOnRxOk : %d, m_bLnWkFtpEndFl"
	.byte	"ag : %d, Historical start time : %08XH ",13,10,0
SL17:	.byte	"LnWayClr",0
SL18:	.byte	"'m_nLnWkWaySideOnRxOk' Clear OK ",13,10,0
SL19:	.byte	"LnFtpClr",0
SL20:	.byte	"'m_bLnWkFtpEndFlag' Clear OK ",13,10,0
SL21:	.byte	"HisStTm",0
SL22:	.byte	"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%"
	.byte	"02X[minute],%02X[second], Setting OK ",13,10,0
SL23:	.byte	"No format ",13,10,0
SL24:	.byte	"CarNoSet",0
SL25:	.byte	"Car Number = %d,%c Car ",13,10,0
SL26:	.byte	"Invalid syntax",13,10,0
SL27:	.byte	"WaySideON",0
SL28:	.byte	"Recently",0
SL29:	.byte	"m_nCDT_FaultDataStFlag  = %d,%s, Date&Time : 20%02X[year],%"
	.byte	"02X[month],%02X[day],%02X[hour],%02X[minute],%02X[second]",13
	.byte	10,0
SL30:	.byte	"CommStSet",0
SL31:	.byte	"CommStSet =  %02X-%02X-%02X-%02X ",13,10,0
SL32:	.byte	"TrainConf",0
SL33:	.byte	"TrainConf value = %02X ",13,10,0
SL34:	.byte	"CarPosSet",0
SL35:	.byte	"CarPosVal = %02X ",13,10,0
SL36:	.byte	"Invalid syntax [%d]",13,10,0
SL37:	.byte	"CiFaultSet",0
SL38:	.byte	"CiFault Val = %02X ",13,10,0
SL39:	.byte	"VerSet",0
SL40:	.byte	"Syntax error",13,10,0
SL41:	.byte	"?",0
SL42:	.byte	"[ENTER]      : Move next line after out '->' ",13,10,0
SL43:	.byte	"'?'          : Help ",13,10,0
SL44:	.byte	"'Time'       : Date&time setting , 'Time=YYMMDDHHMNSS', 'EX"
	.byte	")Time=120102030405' ",13,10,0
SL45:	.byte	"'t'          : Date&time read ",13,10,0
SL46:	.byte	"'Version     : Version ",13,10,0
SL47:	.byte	"'Recent'     : Recently faults start ",13,10,0
SL48:	.byte	"'Historical' : Historical data start ",13,10,0
SL49:	.byte	"'Rxinfo'     : Recieve info ",13,10,0
SL50:	.byte	"'LnWayClr'   : 'm_nLnWkWaySideOnRxOk' variable clear ",13,10
	.byte	0
SL51:	.byte	"'LnFtpClr'   : 'm_bLnWkFtpEndFlag' variable clear ",13,10,0
SL52:	.byte	"'HisStTm'    : Historical data start time set(2000/1/1 0:0:"
	.byte	"0 ~ total second), HisStTm=XXXXXXXX, 'EX)HisStTm=0000000F' "
	.byte	13,10,0
SL53:	.byte	"'CarNoSet'   : Car number set. CarNoSet=XXXX, EX)CarNoSet=4"
	.byte	"001 -> [%d[0x%X],%c CAR]",13,10,0
SL54:	.byte	"'TrainConf'  : Train Configuration. TrainConf=X(X : 0~3[2,4"
	.byte	",6,8Car]) => [0x%X]",13,10,0
SL55:	.byte	"'CarPosSet'  : Car index position. CarPosSet=X(X:1~8) 'EX)C"
	.byte	"arPosSet=1' => [0x%X]",13,10,0
SL56:	.byte	"'CiFaultSet' : Other C/I Fault. CiFaultSet=XX 'EX)CiFaultSe"
	.byte	"t=00' => [0x%02X]",13,10,0
SL57:	.byte	"'WaySideON'  : WaySide_ON ",13,10,0
SL58:	.byte	"'CommStSet'  : Comm Status. CommStSet=XXXXXXXX  'EX) CommSt"
	.byte	"Set=FF7F1F53' => [0x%02X,0x%02X,0x%02X,0x%02X]",13,10,0
SL59:	.byte	"'VerSet'     : Each unit version set. VerSet=XX(incdex):XXX"
	.byte	"X(Ver):XXXXXX(BuildDate) ",13,10,0
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

	.sect	".cinit"
	.field  	72,32
	.field  	CL1+0,32
	.field  	11534336,32
	.field  	16776716,32
	.field  	_btRxBuf$3,32
	.field  	SL1,32
	.field  	SL2,32
	.field  	_m_Variable+300,32
	.field  	_m_Variable+293,32
	.field  	100000,32
	.field  	SL3,32
	.field  	SL4,32
	.field  	SL5,32
	.field  	SL6,32
	.field  	SL7,32
	.field  	_m_Variable,32
	.field  	SL8,32
	.field  	SL9,32
	.field  	SL10,32
	.field  	SL11,32
	.field  	SL12,32
	.field  	SL13,32
	.field  	SL14,32
	.field  	SL15,32
	.field  	SL16,32
	.field  	SL17,32
	.field  	SL18,32
	.field  	SL19,32
	.field  	SL20,32
	.field  	SL21,32
	.field  	SL22,32
	.field  	SL23,32
	.field  	SL24,32
	.field  	SL25,32
	.field  	SL26,32
	.field  	SL27,32
	.field  	SL28,32
	.field  	SL29,32
	.field  	SL30,32
	.field  	_btRxBuf$3+10,32
	.field  	_m_Variable+307,32
	.field  	SL31,32
	.field  	_m_Variable+315,32
	.field  	_m_Variable+323,32
	.field  	SL32,32
	.field  	SL33,32
	.field  	SL34,32
	.field  	SL35,32
	.field  	SL36,32
	.field  	SL37,32
	.field  	SL38,32
	.field  	SL39,32
	.field  	_m_Variable+352,32
	.field  	_m_Variable+388,32
	.field  	SL40,32
	.field  	SL41,32
	.field  	SL42,32
	.field  	SL43,32
	.field  	SL44,32
	.field  	SL45,32
	.field  	SL46,32
	.field  	SL47,32
	.field  	SL48,32
	.field  	SL49,32
	.field  	SL50,32
	.field  	SL51,32
	.field  	SL52,32
	.field  	SL53,32
	.field  	SL54,32
	.field  	SL55,32
	.field  	SL56,32
	.field  	SL57,32
	.field  	SL58,32
	.field  	SL59,32

	.sect	".text"
;******************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                              *
;******************************************************************************

	.global	_ConvDec2Hex

	.global	_ConvAsc2Dec

	.global	_ConvAsc2Hex

	.global	_GetFirmwareVersion

	.global	_gm_SysTimeToRtc

	.global	_MyPrintf

	.global	_FunConvAscHex

	.global	_user_DebugRx

	.global	_user_DebugPrint

	.global	_GetLocalTimeToUTC

	.global	_user_CarNoForCarKindToLon

	.global	_m_Variable
	.global	_memcpy
	.global	_strncpy
	.global	_strncmp
	.global	_memset
	.global	_sprintf
	.global	DIV_U30
	.global	MOD_U30
	.global	MOD_I30
	.global	DIV_I30
	.global	_strlen
