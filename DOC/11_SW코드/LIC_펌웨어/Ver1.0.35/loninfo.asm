;******************************************************************************
;* TMS320C3x/4x ANSI C Code Generator                            Version 5.11 *
;* Date/Time created: Thu Sep 17 04:53:19 2015                                *
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
;	c:\lang\tms320c3x\511\bin\ac30.exe loninfo.c C:\Users\JDS\AppData\Local\Temp\loninfo.if 
	.file	"loninfo.c"
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
	.member	_nCcp,0,14,18,1
	.member	_nsp,1,14,18,1
	.member	_nVtx,2,14,18,1
	.member	_nVoip,3,14,18,1
	.member	_nPac,4,14,18,1
	.member	_nLic,5,14,18,1
	.member	_nFdi,6,14,18,1
	.member	_nSdi1,7,14,18,1
	.eos
	.utag	.fake56,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake57
	.eos
	.stag	.fake59,32
	.member	_nSdi2,0,14,18,1
	.member	_nSdi3,1,14,18,1
	.member	_nSdi4,2,14,18,1
	.member	_nPii1,3,14,18,1
	.member	_nPii2,4,14,18,1
	.member	_nPid1_1,5,14,18,1
	.member	_nPid1_2,6,14,18,1
	.member	_nPid1_3,7,14,18,1
	.eos
	.utag	.fake58,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake59
	.eos
	.stag	.fake61,32
	.member	_nPid1_4,0,14,18,1
	.member	_nPid2_1,1,14,18,1
	.member	_nCncs,2,14,18,1
	.member	_CRA_LAUN,3,14,18,1
	.member	_CRA_UP,4,14,18,1
	.member	_CRA_PP,5,14,18,1
	.member	_CRA_SP,6,14,18,1
	.member	_CRA_FTP,7,14,18,1
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
	.stag	.fake67,14048
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
	.member	_m_nCarPos_Re,10848,4,8,32
	.member	_m_btCiFaultVal,10880,4,8,32
	.member	_m_nCarNo,10912,13,8,32
	.member	_m_chCarKind,10944,2,8,32
	.member	_m_nCarKindToLonCnt,10976,4,8,32
	.member	_m_chCarKindNum,11008,2,8,32
	.member	_m_bLnWkDbgTxFlag,11040,4,8,32
	.member	_m_nLnWkWaySideOnRxOk,11072,12,8,32
	.member	_m_nCarCnt,11104,12,8,32
	.member	_m_nNvsramPos,11136,14,8,32
	.member	_m_bLnWkFtpEndFlag,11168,4,8,32
	.member	_m_nDateTime2SecondCnt,11200,14,8,32
	.member	_m_nTxDbg1msTimer,11232,14,8,32
	.member	_m_nDbgTxPos,11264,14,8,32
	.member	_m_btExVersionTbl,11296,61,8,1152,,36
	.member	_m_btExVersion_DAYTbl,12448,61,8,1152,,36
	.member	_m_btCttSignalA,13600,9,8,32,.fake68
	.member	_m_btCttSignalB,13632,12,8,32
	.member	_m_LIC_CNCS_TimSetFlag,13664,4,8,32
	.member	_m_LIC_GIA_TimSetFlag,13696,4,8,32
	.member	_m_nCncsRxCheck1msTimer,13728,14,8,32
	.member	_m_nGiaRxCheck1msTimer,13760,14,8,32
	.member	_m_btTestOtherCiFault,13792,12,8,32
	.member	_m_bCiFaultFlag,13824,4,8,32
	.member	_m_tFaultInfo,13856,56,8,192,.fake66,2
	.eos
	.sym	_VARIABLE_H,0,8,13,14048,.fake67
	.sym	_PVARIABLE_H,0,24,13,32,.fake67
	.file	"LonInfo.h"
	.file	"loninfo.c"
	.sect	 ".text"

	.global	_LonWorkLoop
	.sym	_LonWorkLoop,_LonWorkLoop,32,2,0
	.func	11
;******************************************************************************
;* FUNCTION NAME: _LonWorkLoop                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r4,ar0,fp,ir0,sp,st                        *
;*   Regs Saved         : r4                                                  *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 707 Auto + 1 SOE = 710 words      *
;******************************************************************************
_LonWorkLoop:
	.sym	_i,1,4,1,32
	.sym	_nTxPos,2,4,1,32
	.sym	_btTxBuf,3,60,1,4096,,128
	.sym	_pNvsram,131,28,1,32
	.sym	_szBuf,132,50,1,16384,,512
	.sym	_szBuf2,644,50,1,2048,,64
	.line	1
;----------------------------------------------------------------------
;  11 | void LonWorkLoop()                                                     
;  13 | int i;                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      707,sp
        push      r4
	.line	4
;----------------------------------------------------------------------
;  14 | int nTxPos = 0;                                                        
;  15 | UCHAR btTxBuf[128];                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	6
;----------------------------------------------------------------------
;  16 | UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;                                 
;  17 | char szBuf[512];                                                       
;  18 | char szBuf2[64];                                                       
;----------------------------------------------------------------------
        ldiu      @CL1,r0
        sti       r0,*+fp(131)
	.line	10
;----------------------------------------------------------------------
;  20 | if(m_Variable.m_nCDT_FaultDataStFlag == 1)                             
;----------------------------------------------------------------------
        ldiu      @_m_Variable+336,r0
        cmpi      1,r0
        bne       L3
;*      Branch Occurs to L3 
	.line	12
;----------------------------------------------------------------------
;  22 | m_Variable.m_nCDT_FaultDataStFlag = 0;                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+336
	.line	14
;----------------------------------------------------------------------
;  24 | m_Variable.m_LIC_CNCS_Tx_Flag = TRUE;                                  
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+331
	.line	15
;----------------------------------------------------------------------
;  25 | m_Variable.m_nTxDbg1msTimer = 0;                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+351
	.line	17
;----------------------------------------------------------------------
;  27 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
        sti       r0,*+fp(2)
	.line	18
;----------------------------------------------------------------------
;  28 | btTxBuf[nTxPos++] = STX;  // STX                                       
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      1,r1
        addi      3,ar0
        ldiu      r0,ir0
        addi      ir0,r1
        ldiu      2,r0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	19
;----------------------------------------------------------------------
;  29 | btTxBuf[nTxPos++] = 0x01; // Command Code                              
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      fp,ar0
        ldiu      *+fp(2),ir0
        addi      3,ar0
        addi      ir0,r1
        ldiu      1,r0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	20
;----------------------------------------------------------------------
;  30 | btTxBuf[nTxPos++] = 0x00; // 0x00¿∏∑Œ º≥¡§                             
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        sti       r1,*+fp(2)
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      0,r0
        sti       r0,*+ar0(ir0)
	.line	21
;----------------------------------------------------------------------
;  31 | btTxBuf[nTxPos++] = 0x06; // ±Ê¿Ã                                      
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      fp,ar0
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        sti       r1,*+fp(2)
        addi      3,ar0
        ldiu      6,r0
        sti       r0,*+ar0(ir0)
	.line	22
;----------------------------------------------------------------------
;  32 | btTxBuf[nTxPos++] = m_Variable.m_nLnWkTxFlag; // Ω∫≈◊¿Ãº«(Recently):0x0
;     | 1, ±‚¡ˆ√¢(Historycal):0x02                                             
;----------------------------------------------------------------------
        ldiu      *+fp(2),ir0
        ldiu      1,r0
        addi      ir0,r0
        sti       r0,*+fp(2)
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      @_m_Variable+333,r0
        sti       r0,*+ar0(ir0)
	.line	23
;----------------------------------------------------------------------
;  33 | btTxBuf[nTxPos++] = 0x00; //                                           
;----------------------------------------------------------------------
        ldiu      0,r0
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        ldiu      fp,ar0
        addi      ir0,r1
        addi      3,ar0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	24
;----------------------------------------------------------------------
;  34 | btTxBuf[nTxPos++] = WORD_H(DWORD_H(m_Variable.m_nDateTime2SecondCnt));
;     | // Ω√∞£(HH)                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+350,r0
        lsh       -16,r0
        and       65535,r0
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        lsh       -8,r0
        ldiu      fp,ar0
        and       255,r0
        addi      3,ar0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	25
;----------------------------------------------------------------------
;  35 | btTxBuf[nTxPos++] = WORD_L(DWORD_H(m_Variable.m_nDateTime2SecondCnt));
;     | // Ω√∞£(HL)                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+350,r0
        ldiu      *+fp(2),ir0
        lsh       -16,r0
        ldiu      1,r1
        ldiu      fp,ar0
        addi      ir0,r1
        addi      3,ar0
        and       255,r0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	26
;----------------------------------------------------------------------
;  36 | btTxBuf[nTxPos++] = WORD_H(DWORD_L(m_Variable.m_nDateTime2SecondCnt));
;     | // Ω√∞£(LH)                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+350,r0
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        ldiu      fp,ar0
        addi      ir0,r1
        and       65535,r0
        addi      3,ar0
        lsh       -8,r0
        sti       r1,*+fp(2)
        and       255,r0
        sti       r0,*+ar0(ir0)
	.line	27
;----------------------------------------------------------------------
;  37 | btTxBuf[nTxPos++] = WORD_L(DWORD_L(m_Variable.m_nDateTime2SecondCnt));
;     | // Ω√∞£(LL)                                                            
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        ldiu      255,r0
        ldiu      fp,ar0
        and       @_m_Variable+350,r0
        addi      ir0,r1
        addi      3,ar0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	28
;----------------------------------------------------------------------
;  38 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      4,r0
        ldiu      1,r1
        subri     *+fp(2),r1
        push      r1
        push      r0
        call      _Make1ByteBcc
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        ldiu      fp,ar0
        addi      ir0,r1
        addi      3,ar0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	29
;----------------------------------------------------------------------
;  39 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      3,r0
        ldiu      fp,ar0
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        addi      3,ar0
        addi      ir0,r1
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	30
;----------------------------------------------------------------------
;  40 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      3,r0
        ldiu      *+fp(2),r1
        push      r1
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	32
;----------------------------------------------------------------------
;  42 | MyPrintf("MDS Falut Request : ",nTxPos);                               
;  43 | //for(i=0;i<nTxPos;i++) MyPrintf("%02X ",WORD_L(btTxBuf[i]));          
;  44 | //MyPrintf("\r\n");                                                    
;  47 | // NVSRAMø° ¿˙¿Âµ» ≥ªøÎ¿ª RS232∑Œ ¿¸º€«œø© µπˆ±Î«—¥Ÿ.                 
;----------------------------------------------------------------------
        ldiu      @CL2,r0
        ldiu      *+fp(2),r1
        push      r1
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
L3:        
	.line	38
;----------------------------------------------------------------------
;  48 | if(m_Variable.m_bLnWkDbgTxFlag)                                        
;----------------------------------------------------------------------
        ldi       @_m_Variable+345,r0
        beq       L5
;*      Branch Occurs to L5 
	.line	40
;----------------------------------------------------------------------
;  50 | m_Variable.m_bLnWkDbgTxFlag = FALSE;                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+345
	.line	41
;----------------------------------------------------------------------
;  51 | m_Variable.m_nDbgTxPos = 0;                                            
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+352
	.line	42
;----------------------------------------------------------------------
;  52 | m_Variable.m_nTxDbg1msTimer = 0;                                       
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+351
L5:        
	.line	45
;----------------------------------------------------------------------
;  55 | if(m_Variable.m_nDbgTxPos < m_Variable.m_nNvsramPos) //m_nDbgTxPos = 0x
;     | FFFFFFFF ∑Œ «◊ªÛ ≈´ ∞™¿ª ∞°¡ˆ∞Ì ¿÷¥Ÿ∞° ¿¸º€«œ∂Û¥¬ ∏Ì∑…ø° ¿ß«ÿ 0¿∏∑Œ ≈¨∏
;     | ÆæÓ µ»¥Ÿ.                                                              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+352,r0
        cmpi      @_m_Variable+348,r0
        bhs       L15
;*      Branch Occurs to L15 
	.line	47
;----------------------------------------------------------------------
;  57 | if(m_Variable.m_nTxDbg1msTimer > 200)                                  
;----------------------------------------------------------------------
        ldiu      @_m_Variable+351,r0
        cmpi      200,r0
        bls       L20
;*      Branch Occurs to L20 
	.line	49
;----------------------------------------------------------------------
;  59 | m_Variable.m_nTxDbg1msTimer = 0;                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+351
	.line	50
;----------------------------------------------------------------------
;  60 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      132,ar0
        sti       r0,*ar0
	.line	51
;----------------------------------------------------------------------
;  61 | for(i=0;i<(MIN(128,(UINT)(m_Variable.m_nNvsramPos-m_Variable.m_nDbgTxPo
;     | s)));i++) {sprintf(szBuf2,"%02X ",pNvsram[m_Variable.m_nDbgTxPos+i]); s
;     | trcat(szBuf,szBuf2);}                                                  
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        bu        L10
;*      Branch Occurs to L10 
	.line	51
L9:        
        addi      *+fp(131),ir0         ; Unsigned
        ldiu      @CL3,r0
        ldiu      *+ar0(ir0),r2
        addi      fp,r1
        push      r2
        push      r0
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      644,r1
        ldiu      fp,r0
        addi      fp,r1
        addi      132,r0
        push      r1
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
L10:        
        ldiu      @_m_Variable+352,r0
        ldiu      128,r1
        subri     @_m_Variable+348,r0   ; Unsigned
        cmpi3     r0,r1
        bhs       L12
;*      Branch Occurs to L12 
        bud       L13
	nop
	nop
        ldiu      128,r0
;*      Branch Occurs to L13 
L12:        
        ldiu      @_m_Variable+352,r0
        subri     @_m_Variable+348,r0   ; Unsigned
L13:        
        ldiu      *+fp(1),r1
        cmpi3     r0,r1
        blod      L9
        ldilo     @_m_Variable+352,ir0
        ldilo     *+fp(1),ar0
        ldilo     644,r1
;*      Branch Occurs to L9 
	.line	52
;----------------------------------------------------------------------
;  62 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL4,r1
        ldiu      fp,r0
        push      r1
        addi      132,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	53
;----------------------------------------------------------------------
;  63 | user_DebugPrint(szBuf);                                                
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      132,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	54
;----------------------------------------------------------------------
;  64 | m_Variable.m_nDbgTxPos += 128;                                         
;  67 | else                                                                   
;----------------------------------------------------------------------
        ldiu      128,r0
        addi      @_m_Variable+352,r0   ; Unsigned
        sti       r0,@_m_Variable+352
        bu        L20
;*      Branch Occurs to L20 
L15:        
	.line	58
;----------------------------------------------------------------------
;  68 | if(m_Variable.m_nDbgTxPos == 0xFFFFFFFF)                               
;----------------------------------------------------------------------
        ldiu      @_m_Variable+352,r0
        cmpi      @CL5,r0
        bne       L20
;*      Branch Occurs to L20 
	.line	60
;----------------------------------------------------------------------
;  70 | if(nTxPos)                                                             
;----------------------------------------------------------------------
        ldi       *+fp(2),r0
        beq       L20
;*      Branch Occurs to L20 
	.line	62
;----------------------------------------------------------------------
;  72 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      132,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	63
;----------------------------------------------------------------------
;  73 | sprintf(szBuf2,"[TX:%02d] ",nTxPos); strcat(szBuf,szBuf2);             
;----------------------------------------------------------------------
        ldiu      @CL6,r1
        ldiu      *+fp(2),r2
        ldiu      644,r0
        push      r2
        addi      fp,r0
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      644,r1
        ldiu      fp,r0
        addi      fp,r1
        addi      132,r0
        push      r1
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	64
;----------------------------------------------------------------------
;  74 | for(i=0;i<nTxPos;i++) {sprintf(szBuf2,"%02X ",WORD_L(btTxBuf[i])); strc
;     | at(szBuf,szBuf2);}                                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        ldiu      255,r4
        cmpi      *+fp(2),r0
        bge       L19
;*      Branch Occurs to L19 
L18:        
        ldiu      fp,ar0
        ldiu      *+fp(1),ir0
        ldiu      644,r2
        addi      3,ar0
        ldiu      @CL3,r0
        and3      r4,*+ar0(ir0),r1
        addi      fp,r2
        push      r1
        push      r0
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      644,r1
        ldiu      fp,r0
        addi      fp,r1
        addi      132,r0
        push      r1
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        blt       L18
;*      Branch Occurs to L18 
L19:        
	.line	65
;----------------------------------------------------------------------
;  75 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL4,r1
        ldiu      fp,r0
        push      r1
        addi      132,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	66
;----------------------------------------------------------------------
;  76 | user_DebugPrint(szBuf);                                                
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      132,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
L20:        
	.line	69
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      709,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	79,000000010h,707



	.sect	".cinit"
	.field  	1,32
	.field  	_nOldKind$1+0,32
	.field  	0,32		; _nOldKind$1 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nRecRxPos$2+0,32
	.field  	0,32		; _nRecRxPos$2 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_LonWorkRead
	.sym	_LonWorkRead,_LonWorkRead,32,2,0
	.func	83
;******************************************************************************
;* FUNCTION NAME: _LonWorkRead                                                *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3,r4,ar0,ar1,fp,ar4,ir0,ir1,sp,st,rs,re,  *
;*                        rc                                                  *
;*   Regs Saved         : r4,ar4                                              *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 968 Auto + 2 SOE = 972 words      *
;******************************************************************************
_LonWorkRead:
	.bss	_nOldKind$1,1
	.sym	_nOldKind,_nOldKind$1,12,3,32
	.bss	_nRecRxPos$2,1
	.sym	_nRecRxPos,_nRecRxPos$2,4,3,32
	.bss	_btFtpOneRecRxBuf$3,1024
	.sym	_btFtpOneRecRxBuf,_btFtpOneRecRxBuf$3,60,3,32768,,1024
	.sym	_i,1,4,1,32
	.sym	_nTmp,2,4,1,32
	.sym	_pLnWkDp,3,24,1,32,.fake8
	.sym	_pNvsram,4,28,1,32
	.sym	_pLicVerDp,5,24,1,32,.fake42
	.sym	_nKind,6,12,1,32
	.sym	_nRxLen,7,12,1,32
	.sym	_btRxBuf,8,60,1,8192,,256
	.sym	_nTxPos,264,4,1,32
	.sym	_btTxBuf,265,60,1,4096,,128
	.sym	_szBuf,393,50,1,16384,,512
	.sym	_szBuf2,905,50,1,2048,,64
	.line	1
;----------------------------------------------------------------------
;  83 | void LonWorkRead()                                                     
;  85 | int i;                                                                 
;  86 | int nTmp;                                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      968,sp
        push      r4
        push      ar4
	.line	5
;----------------------------------------------------------------------
;  87 | PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;                                
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        sti       r0,*+fp(3)
	.line	6
;----------------------------------------------------------------------
;  88 | UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;                                 
;----------------------------------------------------------------------
        ldiu      @CL1,r0
        sti       r0,*+fp(4)
	.line	7
;----------------------------------------------------------------------
;  89 | PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //πˆ¿¸ ¡§∫∏ √≥∏
;     | Æ∏¶ ¿ß«ÿ ¿”¿«∑Œ ∏∏µÈæ˙¥Ÿ.                                              
;  90 | UCHAR nKind;                                                           
;  91 | static UCHAR nOldKind = 0;                                             
;  92 | UCHAR nRxLen;                                                          
;  93 | static int nRecRxPos = 0;                                              
;  94 | UCHAR btRxBuf[256];                                                    
;  95 | static UCHAR btFtpOneRecRxBuf[1024];                                   
;----------------------------------------------------------------------
        ldiu      @CL8,r0
        sti       r0,*+fp(5)
	.line	14
;----------------------------------------------------------------------
;  96 | int nTxPos = 0;                                                        
;  97 | UCHAR btTxBuf[128];                                                    
;  98 | char szBuf[512];                                                       
;  99 | char szBuf2[64];                                                       
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	19
;----------------------------------------------------------------------
; 101 | nKind = WORD_L(pLnWkDp->btKind);                                       
; 103 | switch(nKind)                                                          
; 105 | // FTP1~6 «¡∑Œ≈‰ƒ›                                                     
; 106 | case 1: case 2: case 3: case 4: case 5: case 6:                        
;----------------------------------------------------------------------
        ldiu      *+fp(3),ar0
        bud       L161
        ldiu      255,r0
        and3      r0,*ar0,r0
        sti       r0,*+fp(6)
;*      Branch Occurs to L161 
L23:        
	.line	25
;----------------------------------------------------------------------
; 107 | nRxLen = 0;                                                            
; 109 | // Ω√¿€                                                                
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(7)
	.line	28
;----------------------------------------------------------------------
; 110 | if(nKind == 1)                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(6),r0
        cmpi      1,r0
        bne       L35
;*      Branch Occurs to L35 
	.line	30
;----------------------------------------------------------------------
; 112 | nRecRxPos = 0;                                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_nRecRxPos$2+0
	.line	31
;----------------------------------------------------------------------
; 113 | nRxLen = LonWorkRx(nKind,btRxBuf);                                     
;----------------------------------------------------------------------
        ldiu      *+fp(6),r1
        ldiu      fp,r0
        addi      8,r0
        push      r0
        push      r1
        call      _LonWorkRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(7)
	.line	32
;----------------------------------------------------------------------
; 114 | if(nRxLen>6 && nRecRxPos<768)                                          
;----------------------------------------------------------------------
        cmpi      6,r0
        bls       L60
;*      Branch Occurs to L60 
        ldiu      @_nRecRxPos$2+0,r0
        cmpi      768,r0
        bge       L60
;*      Branch Occurs to L60 
	.line	34
;----------------------------------------------------------------------
; 116 | memcpy(&btFtpOneRecRxBuf[nRecRxPos],&btRxBuf[5],nRxLen-7);             
;----------------------------------------------------------------------
        ldiu      @CL9,r0
        ldiu      7,r1
        ldiu      fp,r2
        addi      @_nRecRxPos$2+0,r0    ; Unsigned
        subri     *+fp(7),r1            ; Unsigned
        addi      13,r2
        push      r1
        push      r2
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	35
;----------------------------------------------------------------------
; 117 | nTmp = (nRxLen-7);                                                     
;----------------------------------------------------------------------
        ldiu      7,r0
        subri     *+fp(7),r0            ; Unsigned
        sti       r0,*+fp(2)
	.line	36
;----------------------------------------------------------------------
; 118 | nRecRxPos += nTmp;                                                     
;----------------------------------------------------------------------
        addi      @_nRecRxPos$2+0,r0
        sti       r0,@_nRecRxPos$2+0
	.line	38
;----------------------------------------------------------------------
; 120 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        ldiu      393,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	39
;----------------------------------------------------------------------
; 121 | sprintf(szBuf2,"[%d,%3d,%c]",nKind,nRxLen,(char)btRxBuf[4]); strcat(szB
;     | uf,szBuf2);                                                            
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      @CL10,r1
        ldiu      905,r2
        ldiu      *ar0,r0
        push      r0
        ldiu      *+fp(7),r0
        push      r0
        ldiu      *+fp(6),r0
        push      r0
        push      r1
        addi      fp,r2
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      5,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	40
;----------------------------------------------------------------------
; 122 | if(nTmp < 128)                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        cmpi      128,r0
        bge       L30
;*      Branch Occurs to L30 
	.line	42
;----------------------------------------------------------------------
; 124 | for(i=0;i<nTmp;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,
;     | szBuf2);}                                                              
; 126 | else                                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        bge       L34
;*      Branch Occurs to L34 
L28:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r1
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r0
        ldiu      *+ar0(ir0),r2
        addi      fp,r1
        push      r2
        push      r0
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        blt       L28
;*      Branch Occurs to L28 
        bu        L34
;*      Branch Occurs to L34 
L30:        
	.line	46
;----------------------------------------------------------------------
; 128 | for(i=0;i<8;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szB
;     | uf2);}                                                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        bge       L32
;*      Branch Occurs to L32 
L31:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r2
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r0
        ldiu      *+ar0(ir0),r1
        addi      fp,r2
        push      r1
        push      r0
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        blt       L31
;*      Branch Occurs to L31 
L32:        
	.line	47
;----------------------------------------------------------------------
; 129 | strcat(szBuf,"..");                                                    
;----------------------------------------------------------------------
        ldiu      @CL12,r1
        ldiu      393,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	48
;----------------------------------------------------------------------
; 130 | for(i=120;i<128;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf
;     | ,szBuf2);}                                                             
;----------------------------------------------------------------------
        ldiu      120,r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        bge       L34
;*      Branch Occurs to L34 
L33:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r0
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r1
        ldiu      *+ar0(ir0),r2
        addi      fp,r0
        push      r2
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        blt       L33
;*      Branch Occurs to L33 
L34:        
	.line	50
;----------------------------------------------------------------------
; 132 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL4,r0
        ldiu      393,r1
        push      r0
        addi      fp,r1
        push      r1
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	51
;----------------------------------------------------------------------
; 133 | user_DebugPrint(szBuf);                                                
; 136 | else                                                                   
; 137 | // ¡ﬂ∞£ ∑πƒ⁄µÂ ºˆΩ≈                                                    
;----------------------------------------------------------------------
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L60
;*      Branch Occurs to L60 
L35:        
	.line	56
;----------------------------------------------------------------------
; 138 | if(nKind >= 2 && nKind <= 5)                                           
;----------------------------------------------------------------------
        ldiu      *+fp(6),r0
        cmpi      2,r0
        blo       L48
;*      Branch Occurs to L48 
        cmpi      5,r0
        bhi       L48
;*      Branch Occurs to L48 
	.line	58
;----------------------------------------------------------------------
; 140 | nRxLen = LonWorkRx(nKind,btRxBuf);                                     
;----------------------------------------------------------------------
        ldiu      fp,r0
        ldiu      *+fp(6),r1
        addi      8,r0
        push      r0
        push      r1
        call      _LonWorkRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(7)
	.line	59
;----------------------------------------------------------------------
; 141 | if(nRxLen>6 && nRecRxPos<768)                                          
;----------------------------------------------------------------------
        cmpi      6,r0
        bls       L60
;*      Branch Occurs to L60 
        ldiu      @_nRecRxPos$2+0,r0
        cmpi      768,r0
        bge       L60
;*      Branch Occurs to L60 
	.line	61
;----------------------------------------------------------------------
; 143 | memcpy(&btFtpOneRecRxBuf[nRecRxPos],&btRxBuf[5],nRxLen-7);             
;----------------------------------------------------------------------
        ldiu      @CL9,r0
        ldiu      7,r1
        ldiu      fp,r2
        addi      @_nRecRxPos$2+0,r0    ; Unsigned
        subri     *+fp(7),r1            ; Unsigned
        addi      13,r2
        push      r1
        push      r2
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	62
;----------------------------------------------------------------------
; 144 | nTmp = (nRxLen-7);                                                     
;----------------------------------------------------------------------
        ldiu      7,r0
        subri     *+fp(7),r0            ; Unsigned
        sti       r0,*+fp(2)
	.line	63
;----------------------------------------------------------------------
; 145 | nRecRxPos += nTmp;                                                     
;----------------------------------------------------------------------
        addi      @_nRecRxPos$2+0,r0
        sti       r0,@_nRecRxPos$2+0
	.line	65
;----------------------------------------------------------------------
; 147 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        ldiu      393,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	66
;----------------------------------------------------------------------
; 148 | sprintf(szBuf2,"[%d,%3d,%c]",nKind,nRxLen,(char)btRxBuf[4]); strcat(szB
;     | uf,szBuf2);                                                            
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      *ar0,r1
        push      r1
        ldiu      *+fp(7),r1
        push      r1
        ldiu      905,r2
        ldiu      *+fp(6),r1
        push      r1
        ldiu      @CL10,r0
        push      r0
        addi      fp,r2
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      5,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	67
;----------------------------------------------------------------------
; 149 | if(nTmp < 128)                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        cmpi      128,r0
        bge       L43
;*      Branch Occurs to L43 
	.line	69
;----------------------------------------------------------------------
; 151 | for(i=0;i<nTmp;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,
;     | szBuf2);}                                                              
; 153 | else                                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        bge       L47
;*      Branch Occurs to L47 
L41:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r0
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r1
        ldiu      *+ar0(ir0),r2
        addi      fp,r0
        push      r2
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        blt       L41
;*      Branch Occurs to L41 
        bu        L47
;*      Branch Occurs to L47 
L43:        
	.line	73
;----------------------------------------------------------------------
; 155 | for(i=0;i<8;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szB
;     | uf2);}                                                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        bge       L45
;*      Branch Occurs to L45 
L44:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r1
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r0
        ldiu      *+ar0(ir0),r2
        addi      fp,r1
        push      r2
        push      r0
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        blt       L44
;*      Branch Occurs to L44 
L45:        
	.line	74
;----------------------------------------------------------------------
; 156 | strcat(szBuf,"..");                                                    
;----------------------------------------------------------------------
        ldiu      @CL12,r1
        ldiu      393,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	75
;----------------------------------------------------------------------
; 157 | for(i=120;i<128;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf
;     | ,szBuf2);}                                                             
;----------------------------------------------------------------------
        ldiu      120,r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        bge       L47
;*      Branch Occurs to L47 
L46:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r0
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r1
        ldiu      *+ar0(ir0),r2
        addi      fp,r0
        push      r2
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        blt       L46
;*      Branch Occurs to L46 
L47:        
	.line	77
;----------------------------------------------------------------------
; 159 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL4,r0
        ldiu      393,r1
        push      r0
        addi      fp,r1
        push      r1
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	78
;----------------------------------------------------------------------
; 160 | user_DebugPrint(szBuf);                                                
; 163 | else                                                                   
; 164 | // ≥°                                                                  
;----------------------------------------------------------------------
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
        bu        L60
;*      Branch Occurs to L60 
L48:        
	.line	83
;----------------------------------------------------------------------
; 165 | if(nKind == 6)                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(6),r0
        cmpi      6,r0
        bne       L60
;*      Branch Occurs to L60 
	.line	85
;----------------------------------------------------------------------
; 167 | nRxLen = LonWorkRx(nKind,btRxBuf);                                     
;----------------------------------------------------------------------
        ldiu      fp,r0
        ldiu      *+fp(6),r1
        addi      8,r0
        push      r0
        push      r1
        call      _LonWorkRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(7)
	.line	86
;----------------------------------------------------------------------
; 168 | if(nRxLen>6 && nRecRxPos<768)                                          
;----------------------------------------------------------------------
        cmpi      6,r0
        bls       L60
;*      Branch Occurs to L60 
        ldiu      @_nRecRxPos$2+0,r0
        cmpi      768,r0
        bge       L60
;*      Branch Occurs to L60 
	.line	88
;----------------------------------------------------------------------
; 170 | memcpy(&btFtpOneRecRxBuf[nRecRxPos],&btRxBuf[5],nRxLen-7);             
;----------------------------------------------------------------------
        ldiu      @CL9,r0
        ldiu      7,r1
        ldiu      fp,r2
        addi      @_nRecRxPos$2+0,r0    ; Unsigned
        subri     *+fp(7),r1            ; Unsigned
        addi      13,r2
        push      r1
        push      r2
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	89
;----------------------------------------------------------------------
; 171 | nTmp = (nRxLen-7);                                                     
;----------------------------------------------------------------------
        ldiu      7,r0
        subri     *+fp(7),r0            ; Unsigned
        sti       r0,*+fp(2)
	.line	90
;----------------------------------------------------------------------
; 172 | nRecRxPos += nTmp;                                                     
;----------------------------------------------------------------------
        addi      @_nRecRxPos$2+0,r0
        sti       r0,@_nRecRxPos$2+0
	.line	92
;----------------------------------------------------------------------
; 174 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        ldiu      393,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	93
;----------------------------------------------------------------------
; 175 | sprintf(szBuf2,"[%d,%3d,%c]",nKind,nRxLen,(char)btRxBuf[4]); strcat(szB
;     | uf,szBuf2);                                                            
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      *ar0,r1
        push      r1
        ldiu      *+fp(7),r1
        push      r1
        ldiu      905,r2
        ldiu      *+fp(6),r1
        push      r1
        ldiu      @CL10,r0
        push      r0
        addi      fp,r2
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      5,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	94
;----------------------------------------------------------------------
; 176 | if(nTmp < 128)                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        cmpi      128,r0
        bge       L55
;*      Branch Occurs to L55 
	.line	96
;----------------------------------------------------------------------
; 178 | for(i=0;i<nTmp;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,
;     | szBuf2);}                                                              
; 180 | else                                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        bge       L59
;*      Branch Occurs to L59 
L53:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r1
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r0
        ldiu      *+ar0(ir0),r2
        addi      fp,r1
        push      r2
        push      r0
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        blt       L53
;*      Branch Occurs to L53 
        bu        L59
;*      Branch Occurs to L59 
L55:        
	.line	100
;----------------------------------------------------------------------
; 182 | for(i=0;i<8;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szB
;     | uf2);}                                                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        bge       L57
;*      Branch Occurs to L57 
L56:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r1
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r0
        ldiu      *+ar0(ir0),r2
        addi      fp,r1
        push      r2
        push      r0
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      8,r0
        blt       L56
;*      Branch Occurs to L56 
L57:        
	.line	101
;----------------------------------------------------------------------
; 183 | strcat(szBuf,"..");                                                    
;----------------------------------------------------------------------
        ldiu      @CL12,r1
        ldiu      393,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	102
;----------------------------------------------------------------------
; 184 | for(i=120;i<128;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf
;     | ,szBuf2);}                                                             
;----------------------------------------------------------------------
        ldiu      120,r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        bge       L59
;*      Branch Occurs to L59 
L58:        
        ldiu      5,ir0
        ldiu      fp,ar0
        ldiu      905,r0
        addi      *+fp(1),ir0
        addi      8,ar0
        ldiu      @CL11,r1
        ldiu      *+ar0(ir0),r2
        addi      fp,r0
        push      r2
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        blt       L58
;*      Branch Occurs to L58 
L59:        
	.line	104
;----------------------------------------------------------------------
; 186 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL4,r0
        ldiu      393,r1
        push      r0
        addi      fp,r1
        push      r1
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	105
;----------------------------------------------------------------------
; 187 | user_DebugPrint(szBuf);                                                
; 191 | // ±Ê¿Ã∞° 0~127±Ó¡ˆ ø¬¥Ÿ∏È µ•¿Ã≈Õ∏¶ ¿˙¿Â«—¥Ÿ.                          
;----------------------------------------------------------------------
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
L60:        
	.line	110
;----------------------------------------------------------------------
; 192 | if((nRxLen>6 && nRxLen<134))                                           
;----------------------------------------------------------------------
        ldiu      *+fp(7),r0
        cmpi      6,r0
        bls       L66
;*      Branch Occurs to L66 
        cmpi      134,r0
        bhs       L66
;*      Branch Occurs to L66 
	.line	112
;----------------------------------------------------------------------
; 194 | if(NVSRAM_WAYSIDEONBUF_SIZE > m_Variable.m_nNvsramPos)                 
;----------------------------------------------------------------------
        ldiu      @CL13,r0
        cmpi      @_m_Variable+348,r0
        bls       L64
;*      Branch Occurs to L64 
	.line	114
;----------------------------------------------------------------------
; 196 | user_DebugPrint("***FTP File receive... ^^;;***\r\n");                 
;----------------------------------------------------------------------
        ldiu      @CL14,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	115
;----------------------------------------------------------------------
; 197 | memcpy(&pNvsram[m_Variable.m_nNvsramPos],btFtpOneRecRxBuf,nRecRxPos);  
;----------------------------------------------------------------------
        ldiu      @_m_Variable+348,r0
        ldiu      @_nRecRxPos$2+0,r2
        ldiu      @CL9,r1
        addi      *+fp(4),r0            ; Unsigned
        push      r2
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	116
;----------------------------------------------------------------------
; 198 | m_Variable.m_nNvsramPos += nRecRxPos;                                  
; 200 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @_nRecRxPos$2+0,r0
        addi      @_m_Variable+348,r0   ; Unsigned
        sti       r0,@_m_Variable+348
        bu        L65
;*      Branch Occurs to L65 
L64:        
	.line	120
;----------------------------------------------------------------------
; 202 | MyPrintf("***FTP data buffer full..\r\n");                             
;----------------------------------------------------------------------
        ldiu      @CL15,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
L65:        
	.line	123
;----------------------------------------------------------------------
; 205 | m_Variable.m_bLnWkFtpEndFlag = TRUE;                                   
; 207 | else                                                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+349
        bu        L70
;*      Branch Occurs to L70 
L66:        
	.line	126
;----------------------------------------------------------------------
; 208 | if(nKind == 6)                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(6),r0
        cmpi      6,r0
        bne       L70
;*      Branch Occurs to L70 
	.line	128
;----------------------------------------------------------------------
; 210 | if(NVSRAM_WAYSIDEONBUF_SIZE > m_Variable.m_nNvsramPos)                 
;----------------------------------------------------------------------
        ldiu      @CL13,r0
        cmpi      @_m_Variable+348,r0
        bls       L69
;*      Branch Occurs to L69 
	.line	130
;----------------------------------------------------------------------
; 212 | user_DebugPrint("***FTP File receive End ^..^ ***\r\n");               
;----------------------------------------------------------------------
        ldiu      @CL16,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	131
;----------------------------------------------------------------------
; 213 | memcpy(&pNvsram[m_Variable.m_nNvsramPos],btFtpOneRecRxBuf,nRecRxPos);  
;----------------------------------------------------------------------
        ldiu      @_m_Variable+348,r0
        ldiu      @_nRecRxPos$2+0,r2
        ldiu      @CL9,r1
        addi      *+fp(4),r0            ; Unsigned
        push      r2
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	132
;----------------------------------------------------------------------
; 214 | m_Variable.m_nNvsramPos += nRecRxPos;                                  
; 216 | else                                                                   
;----------------------------------------------------------------------
        ldiu      @_nRecRxPos$2+0,r0
        addi      @_m_Variable+348,r0   ; Unsigned
        sti       r0,@_m_Variable+348
        bu        L70
;*      Branch Occurs to L70 
L69:        
	.line	136
;----------------------------------------------------------------------
; 218 | MyPrintf("***FTP data buffer full..\r\n");                             
;----------------------------------------------------------------------
        ldiu      @CL15,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
L70:        
	.line	140
;----------------------------------------------------------------------
; 222 | nOldKind = nKind;                                                      
;----------------------------------------------------------------------
        ldiu      *+fp(6),r0
        sti       r0,@_nOldKind$1+0
	.line	142
;----------------------------------------------------------------------
; 224 | break;                                                                 
; 226 | // ¿œπ› «¡∑Œ≈‰ƒ›(ºˆΩ≈)                                                 
; 227 | case 7:                                                                
;----------------------------------------------------------------------
        bu        L168
;*      Branch Occurs to L168 
	.line	146
;----------------------------------------------------------------------
; 228 | nRxLen = LonWorkRx(7,btRxBuf);                                         
;----------------------------------------------------------------------
L72:        
        addi      8,r0
        push      r0
        push      r1
        call      _LonWorkRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(7)
	.line	148
;----------------------------------------------------------------------
; 230 | if(m_Variable.m_nDbgTxPos == 0xFFFFFFFF)                               
;----------------------------------------------------------------------
        ldiu      @_m_Variable+352,r0
        cmpi      @CL5,r0
        bned      L76
	nop
        ldieq     393,ir0
        ldieq     0,r0
;*      Branch Occurs to L76 
	.line	150
;----------------------------------------------------------------------
; 232 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        sti       r0,*+fp(ir0)
	.line	151
;----------------------------------------------------------------------
; 233 | sprintf(szBuf2,"[RX:%02d] ",nRxLen); strcat(szBuf,szBuf2);             
;----------------------------------------------------------------------
        ldiu      905,r2
        ldiu      @CL17,r1
        addi      fp,r2
        ldiu      *+fp(7),r0
        push      r0
        push      r1
        push      r2
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	152
;----------------------------------------------------------------------
; 234 | for(i=0;i<nRxLen;i++) {sprintf(szBuf2,"%02X ",btRxBuf[i]); strcat(szBuf
;     | ,szBuf2);}                                                             
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        ldiu      *+fp(1),r0
        cmpi      *+fp(7),r0
        bhs       L75
;*      Branch Occurs to L75 
L74:        
        ldiu      fp,ar0
        ldiu      *+fp(1),ir0
        ldiu      905,r0
        addi      8,ar0
        ldiu      @CL3,r1
        ldiu      *+ar0(ir0),r2
        addi      fp,r0
        push      r2
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        ldiu      *+fp(1),r0
        cmpi      *+fp(7),r0
        blo       L74
;*      Branch Occurs to L74 
L75:        
	.line	153
;----------------------------------------------------------------------
; 235 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL4,r1
        ldiu      393,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	154
;----------------------------------------------------------------------
; 236 | user_DebugPrint(szBuf);                                                
;----------------------------------------------------------------------
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
L76:        
	.line	157
;----------------------------------------------------------------------
; 239 | if(nRxLen)                                                             
;----------------------------------------------------------------------
        ldi       *+fp(7),r0
        beqd      L168
	nop
        ldine     264,ir0
        ldine     0,r0
;*      Branch Occurs to L168 
	.line	159
;----------------------------------------------------------------------
; 241 | nTxPos = 0;                                                            
; 243 | switch(btRxBuf[1])                                                     
; 245 | // WAYSIDE ON ACK ¿¿¥‰                                                 
; 246 | case 0x02:                                                             
;----------------------------------------------------------------------
        bud       L143
        sti       r0,*+fp(ir0)
        ldiu      fp,ar0
        addi      9,ar0
;*      Branch Occurs to L143 
L78:        
	.line	166
;----------------------------------------------------------------------
; 248 | m_Variable.m_nLnWkWaySideOnRxOk = 1;                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+346
	.line	168
;----------------------------------------------------------------------
; 250 | MyPrintf("WAYSIDE ON Flage On. \r\n");                                 
;----------------------------------------------------------------------
        ldiu      @CL18,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	170
;----------------------------------------------------------------------
; 252 | break;                                                                 
; 254 | // FTP¿¸º€ ≥°                                                          
; 255 | case 0x06:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
L79:        
	.line	174
;----------------------------------------------------------------------
; 256 | if(m_Variable.m_nLnWkWaySideOnRxOk)                                    
;----------------------------------------------------------------------
        ldi       @_m_Variable+346,r0
        beq       L155
;*      Branch Occurs to L155 
	.line	176
;----------------------------------------------------------------------
; 258 | m_Variable.m_nLnWkWaySideOnRxOk--;                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     @_m_Variable+346,r0   ; Unsigned
        sti       r0,@_m_Variable+346
	.line	177
;----------------------------------------------------------------------
; 259 | m_Variable.m_bLnWkFtpEndFlag = TRUE;                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+349
	.line	179
;----------------------------------------------------------------------
; 261 | MyPrintf("FTP Sending END. \r\n");                                     
;----------------------------------------------------------------------
        ldiu      @CL19,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	181
;----------------------------------------------------------------------
; 263 | break;                                                                 
; 265 | // Ω√∞£ø‰√ª, MPU∞° DPRAMø° µ•¿Ã≈Õ∏¶ æ≤∞Ì ¿¸º€ ¿Œ≈Õ∑¥∆Æ∏¶ ¿¸º€«œ¡ˆæ ¿∏∏È
;     |  LIC_LONø°º≠ ¿¸º€«œ¡ˆ æ ¿Ω                                             
; 266 | case 0x08:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
	.line	185
;----------------------------------------------------------------------
; 267 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
L82:        
        sti       r0,*+fp(ir0)
	.line	187
;----------------------------------------------------------------------
; 269 | if(m_Variable.m_LIC_CNCS_TimSetFlag && m_Variable.m_nCncsRxCheck1msTime
;     | r)                                                                     
;----------------------------------------------------------------------
        ldi       @_m_Variable+427,r0
        beq       L155
;*      Branch Occurs to L155 
        ldi       @_m_Variable+429,r0
        beq       L155
;*      Branch Occurs to L155 
	.line	190
;----------------------------------------------------------------------
; 272 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        ldiu      264,ir1
        ldiu      265,ar0
        ldiu      2,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	191
;----------------------------------------------------------------------
; 273 | btTxBuf[nTxPos++] = 0x09; // Command Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir1),r0
        ldiu      9,r1
        addi      r0,r2
        addi3     r0,fp,ir1             ; Unsigned
        sti       r2,*+fp(ir0)
        sti       r1,*+ar0(ir1)
	.line	192
;----------------------------------------------------------------------
; 274 | btTxBuf[nTxPos++] = 0x00; // 0x00¿∏∑Œ º≥¡§                             
;----------------------------------------------------------------------
        ldiu      264,ir1
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        ldiu      0,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	193
;----------------------------------------------------------------------
; 275 | btTxBuf[nTxPos++] = 0x06; // ±Ê¿Ã                                      
; 277 | // Y.J ºˆ¡§                                                            
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        ldiu      6,r1
        sti       r1,*+ar0(ir0)
	.line	196
;----------------------------------------------------------------------
; 278 | btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.year;
;     |                                  // ≥‚ BCD                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        ldiu      1,r1
        addi      r0,r1
        sti       r1,*+fp(ir1)
        addi3     r0,fp,ir0             ; Unsigned
        ldiu      @_m_Variable+305,r0
        sti       r0,*+ar0(ir0)
	.line	197
;----------------------------------------------------------------------
; 279 | btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.month;
;     |                                  // ø˘                                 
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir1),r0
        ldiu      1,r1
        addi      r0,r1
        sti       r1,*+fp(ir0)
        addi3     r0,fp,ir0             ; Unsigned
        ldiu      @_m_Variable+304,r0
        sti       r0,*+ar0(ir0)
	.line	198
;----------------------------------------------------------------------
; 280 | btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.day;
;     |                                  // ¿œ                                 
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      *+fp(ir0),r0
        addi      r0,r1
        sti       r1,*+fp(ir1)
        addi3     r0,fp,ir0             ; Unsigned
        ldiu      @_m_Variable+303,r0
        sti       r0,*+ar0(ir0)
	.line	199
;----------------------------------------------------------------------
; 281 | btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.hour;
;     |                                  // Ω√                                 
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      *+fp(ir0),r0
        addi3     r0,fp,ir0             ; Unsigned
        addi      r0,r1
        sti       r1,*+fp(ir1)
        ldiu      @_m_Variable+302,r0
        sti       r0,*+ar0(ir0)
	.line	200
;----------------------------------------------------------------------
; 282 | btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.minute;
;     |                                  // ∫–                                 
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r1
        ldiu      1,r0
        addi      r1,r0
        sti       r0,*+fp(ir1)
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      @_m_Variable+301,r0
        sti       r0,*+ar0(ir0)
	.line	201
;----------------------------------------------------------------------
; 283 | btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.second;
;     |                                  // √                                  
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      *+fp(ir0),r0
        addi      r0,r1
        sti       r1,*+fp(ir1)
        addi3     r0,fp,ir0             ; Unsigned
        ldiu      @_m_Variable+300,r0
        sti       r0,*+ar0(ir0)
	.line	203
;----------------------------------------------------------------------
; 285 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      266,r0
        ldiu      264,ir0
        addi      fp,r0
        subi3     r1,*+fp(ir0),r1
        push      r1
        push      r0
        call      _Make1ByteBcc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      2,sp
        ldiu      *+fp(ir0),r1
        addi3     r1,fp,ir0             ; Unsigned
        addi      1,r1
        ldiu      265,ar0
        ldiu      264,ir1
        sti       r1,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	204
;----------------------------------------------------------------------
; 286 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r2
        addi3     r2,fp,ir0             ; Unsigned
        ldiu      1,r0
        addi      r2,r0
        sti       r0,*+fp(ir1)
        ldiu      3,r1
        sti       r1,*+ar0(ir0)
	.line	205
;----------------------------------------------------------------------
; 287 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        push      r0
        ldiu      265,r0
        addi      fp,r0
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	208
;----------------------------------------------------------------------
; 290 | MyPrintf("TIME Sending : ");                                           
;----------------------------------------------------------------------
        ldiu      @CL20,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	211
;----------------------------------------------------------------------
; 293 | break;                                                                 
; 295 | // ªÛ≈¬µ•¿Ã≈Õ ø‰√ª, MPU∞° DPRAMø° µ•¿Ã≈Õ∏¶ æ≤∞Ì ¿¸º€ ¿Œ≈Õ∑¥∆Æ∏¶ ¿¸º€«œ¡
;     | ˆæ ¿∏∏È LIC_LONø°º≠ ¿¸º€«œ¡ˆ æ ¿Ω                                      
; 296 | case 0x0A:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
L85:        
	.line	215
;----------------------------------------------------------------------
; 297 | m_Variable.m_nCarCnt = btRxBuf[4];                                     
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldi       *ar0,r0
        sti       r0,@_m_Variable+347
	.line	216
;----------------------------------------------------------------------
; 298 | if(m_Variable.m_nCarCnt < 1 && m_Variable.m_nCarCnt > 2) m_Variable.m_n
;     | CarCnt = 1;                                                            
;----------------------------------------------------------------------
        bne       L88
;*      Branch Occurs to L88 
        cmpi      2,r0
        bls       L88
;*      Branch Occurs to L88 
        ldiu      1,r0
        sti       r0,@_m_Variable+347
L88:        
	.line	217
;----------------------------------------------------------------------
; 299 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	219
;----------------------------------------------------------------------
; 301 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      1,r2
        ldiu      264,ir1
        ldiu      265,ar0
        ldiu      2,r1
        ldiu      *+fp(ir0),r0
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	220
;----------------------------------------------------------------------
; 302 | btTxBuf[nTxPos++] = 0x0B; // Command Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        ldiu      11,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	221
;----------------------------------------------------------------------
; 303 | btTxBuf[nTxPos++] = 0x00; // 0x00¿∏∑Œ º≥¡§                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      0,r1
        ldiu      *+fp(ir0),r0
        ldiu      1,r2
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	222
;----------------------------------------------------------------------
; 304 | btTxBuf[nTxPos++] = 0x05; // ±Ê¿Ã                                      
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r1
        ldiu      1,r2
        addi      r1,r2
        ldiu      5,r0
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	223
;----------------------------------------------------------------------
; 305 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[0]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+323,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir1
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r1
        addi      r1,r2
        sti       r2,*+fp(ir1)
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      265,ar0
        sti       r0,*+ar0(ir0)
	.line	224
;----------------------------------------------------------------------
; 306 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[1]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+324,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      265,ar0
        ldiu      *+fp(ir0),r1
        ldiu      264,ir1
        ldiu      1,r2
        addi      r1,r2
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	225
;----------------------------------------------------------------------
; 307 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[2]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+325,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      *+fp(ir0),r1
        ldiu      264,ir1
        addi3     r1,fp,ir0             ; Unsigned
        addi      1,r1
        ldiu      265,ar0
        sti       r1,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	226
;----------------------------------------------------------------------
; 308 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[3]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+326,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      *+fp(ir0),r1
        ldiu      1,r2
        ldiu      265,ar0
        addi      r1,r2
        ldiu      264,ir1
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	227
;----------------------------------------------------------------------
; 309 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[4]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+327,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        ldiu      264,ir0
        ldiu      265,ar0
        subi      1,sp
        ldiu      264,ir1
        ldiu      *+fp(ir0),r1
        ldiu      1,r2
        addi3     r1,fp,ir0             ; Unsigned
        addi      r1,r2
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	228
;----------------------------------------------------------------------
; 310 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[5]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+328,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        ldiu      264,ir1
        subi      1,sp
        ldiu      1,r1
        ldiu      *+fp(ir1),r2
        ldiu      264,ir0
        addi      r2,r1
        sti       r1,*+fp(ir0)
        addi3     r2,fp,ir0             ; Unsigned
        ldiu      265,ar0
        sti       r0,*+ar0(ir0)
	.line	229
;----------------------------------------------------------------------
; 311 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[6]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+329,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir1
        ldiu      264,ir0
        ldiu      265,ar0
        ldiu      *+fp(ir0),r1
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      1,r2
        addi      r1,r2
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	230
;----------------------------------------------------------------------
; 312 | btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[7]); // ªÛ≈¬
;     | µ•¿Ã≈Õ                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+330,r0
        push      r0
        call      _BitSwap
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      *+fp(ir0),r2
        ldiu      265,ar0
        addi3     r2,fp,ir0             ; Unsigned
        ldiu      264,ir1
        addi      r2,r1
        sti       r1,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	231
;----------------------------------------------------------------------
; 313 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      266,r1
        addi      fp,r1
        ldiu      264,ir0
        ldiu      1,r0
        subi3     r0,*+fp(ir0),r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        subi      2,sp
        ldiu      264,ir0
        ldiu      *+fp(ir0),r1
        ldiu      264,ir1
        ldiu      1,r2
        addi      r1,r2
        sti       r2,*+fp(ir1)
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      265,ar0
        sti       r0,*+ar0(ir0)
	.line	232
;----------------------------------------------------------------------
; 314 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        addi      r0,r2
        sti       r2,*+fp(ir1)
        addi3     r0,fp,ir0             ; Unsigned
        ldiu      3,r1
        sti       r1,*+ar0(ir0)
	.line	233
;----------------------------------------------------------------------
; 315 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        push      r0
        ldiu      265,r0
        addi      fp,r0
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	235
;----------------------------------------------------------------------
; 317 | memcpy(m_Variable.m_btSenseCommStBuf,m_Variable.m_btCommSt,8);         
;----------------------------------------------------------------------
        ldiu      @CL22,ar0
        ldiu      @CL21,ar1
        ldiu      *ar0++(1),r0
        rpts      6                     ; Fast MEMCPY(#3)
        sti       r0,*ar1++(1)
||      ldi       *ar0++(1),r0
        sti       r0,*ar1++(1)
	.line	237
;----------------------------------------------------------------------
; 319 | MyPrintf("Unit State Data Sending : ");                                
;----------------------------------------------------------------------
        ldiu      @CL23,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	239
;----------------------------------------------------------------------
; 321 | break;                                                                 
; 323 | //πˆ¡Øø‰√ª                                                             
; 324 | case 0x0C:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
	.line	243
;----------------------------------------------------------------------
; 325 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
L91:        
        sti       r0,*+fp(ir0)
	.line	244
;----------------------------------------------------------------------
; 326 | memset(btTxBuf,0x00,sizeof(btTxBuf));                                  
;----------------------------------------------------------------------
        ldiu      265,r1
        ldiu      0,r2
        addi      fp,r1
        ldiu      128,r0
        push      r0
        push      r2
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	246
;----------------------------------------------------------------------
; 328 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      264,ir1
        ldiu      1,r0
        ldiu      265,ar0
        ldiu      *+fp(ir0),r1
        addi      r1,r0
        sti       r0,*+fp(ir1)
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      2,r2
        sti       r2,*+ar0(ir0)
	.line	247
;----------------------------------------------------------------------
; 329 | btTxBuf[nTxPos++] = 0x0D; // Command Code                              
; 331 | // 2 : Firmware                                                        
; 332 | // 0 : Not used∏¶ √‚∑¬«œ∞Ì πˆ¿¸∞˙ ≥Ø¬•¥¬ √‚∑¬«œ¡ˆæ ¥¬¥Ÿ.               
; 333 | // 6 : πˆ¿¸¿¸º€(LIC -> CDT) ¡ﬂ¡ˆ                                       
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r2
        ldiu      1,r0
        addi      r2,r0
        ldiu      13,r1
        addi3     r2,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	253
;----------------------------------------------------------------------
; 335 | nTmp = MAX(1,WORD_L(btRxBuf[4]));                                      
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      255,r1
        and3      r1,*ar0,r1
        ldiu      1,r0
        cmpi3     r1,r0
        bls       L93
;*      Branch Occurs to L93 
        bu        L94
;*      Branch Occurs to L94 
L93:        
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
L94:        
        sti       r0,*+fp(2)
	.line	254
;----------------------------------------------------------------------
; 336 | nTmp = MIN((VER_BDD_MAX_CNT)+1,WORD_L(btRxBuf[4]));                    
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      255,r1
        addi      12,ar0
        ldiu      33,r0
        and3      r1,*ar0,r1
        cmpi3     r1,r0
        bhs       L96
;*      Branch Occurs to L96 
        bu        L97
;*      Branch Occurs to L97 
L96:        
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
L97:        
        sti       r0,*+fp(2)
	.line	255
;----------------------------------------------------------------------
; 337 | nTmp--;                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *+fp(2),r0
        sti       r0,*+fp(2)
	.line	257
;----------------------------------------------------------------------
; 339 | btTxBuf[nTxPos++] = m_Variable.LIC_VerList[nTmp][0] == NULL ? 6 : 2; //
;     |  2:πˆ¡Ø&µ•¿Ã∆Æ, 6:¡ﬂ¡ˆ                                                 
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      264,ir1
        ldiu      265,ar0
        ldiu      @CL24,ar1
        ldiu      *+fp(ir0),r0
        ldiu      *+fp(2),ir0
        addi      r0,r1
        mpyi      9,ir0
        sti       r1,*+fp(ir1)
        addi3     r0,fp,ir1             ; Unsigned
        ldi       *+ar1(ir0),r0
        bne       L99
;*      Branch Occurs to L99 
        bud       L100
	nop
	nop
        ldiu      6,r0
;*      Branch Occurs to L100 
L99:        
        ldiu      2,r0
L100:        
        sti       r0,*+ar0(ir1)
	.line	259
;----------------------------------------------------------------------
; 341 | btTxBuf[nTxPos++] = 31; // µ•¿Ã≈Õ±Ê¿Ã                                  
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      264,ir1
        ldiu      *+fp(ir0),r2
        ldiu      265,ar0
        ldiu      31,r0
        addi      r2,r1
        addi3     r2,fp,ir0             ; Unsigned
        sti       r1,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	261
;----------------------------------------------------------------------
; 343 | btTxBuf[nTxPos++] = btRxBuf[4]; // Index π¯»£                          
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      fp,ar0
        ldiu      1,r0
        ldiu      *+fp(ir0),r1
        ldiu      265,ar1
        addi      12,ar0
        addi      r1,r0
        addi3     r1,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        ldiu      *ar0,r0
        sti       r0,*+ar1(ir0)
	.line	262
;----------------------------------------------------------------------
; 344 | btTxBuf[nTxPos++] = m_Variable.LIC_VerList[nTmp][0] == NULL ? 6 : 4; //
;     |  Type                                                                  
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r0
        ldiu      *+fp(ir0),r1
        addi      r1,r0
        ldiu      *+fp(2),ir0
        mpyi      9,ir0
        sti       r0,*+fp(ir1)
        ldiu      @CL24,ar1
        ldiu      265,ar0
        ldi       *+ar1(ir0),r0
        bned      L102
        addi3     r1,fp,ir0             ; Unsigned
	nop
        ldine     4,r0
;*      Branch Occurs to L102 
        ldiu      6,r0
L102:        
        sti       r0,*+ar0(ir0)
	.line	264
;----------------------------------------------------------------------
; 346 | memcpy(&btTxBuf[nTxPos],&m_Variable.LIC_VerList[nTmp][0],strlen((char*)
;     | &m_Variable.LIC_VerList[nTmp][0]));                                    
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        mpyi      9,r0
        addi      @CL24,r0              ; Unsigned
        push      r0
        call      _strlen
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      *+fp(2),r2
        addi3     fp,*+fp(ir0),r1       ; Unsigned
        push      r0
        mpyi      9,r2
        addi      265,r1                ; Unsigned
        ldiu      @CL24,r0
        addi      r2,r0
        push      r0
        push      r1
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	265
;----------------------------------------------------------------------
; 347 | nTxPos = nTxPos+9;                                                     
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      9,r0
        ldiu      264,ir1
        addi3     r0,*+fp(ir0),r0
        sti       r0,*+fp(ir1)
	.line	267
;----------------------------------------------------------------------
; 349 | btTxBuf[nTxPos+0] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTm
;     | p)]>>12)&0x0F); // Production Version                                  
;----------------------------------------------------------------------
        ldiu      255,ir0
        and       *+fp(2),ir0
        ldiu      @CL25,ar0
        ldiu      -12,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir0
        ldiu      265,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	268
;----------------------------------------------------------------------
; 350 | btTxBuf[nTxPos+1] = '.'; // Production Version                         
;----------------------------------------------------------------------
        ldiu      264,ir0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      266,ar0
        ldiu      46,r0
        sti       r0,*+ar0(ir0)
	.line	269
;----------------------------------------------------------------------
; 351 | btTxBuf[nTxPos+2] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTm
;     | p)]>>8)&0x0F); // Production Version                                   
;----------------------------------------------------------------------
        ldiu      255,ir0
        and       *+fp(2),ir0
        ldiu      @CL25,ar0
        ldiu      -8,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      267,ar0
        sti       r0,*+ar0(ir0)
	.line	270
;----------------------------------------------------------------------
; 352 | btTxBuf[nTxPos+3] = '.'; // Production Version                         
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      268,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      46,r0
        sti       r0,*+ar0(ir0)
	.line	271
;----------------------------------------------------------------------
; 353 | btTxBuf[nTxPos+4] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTm
;     | p)]>>4)&0x0F); // Production Version                                   
;----------------------------------------------------------------------
        ldiu      255,ir0
        and       *+fp(2),ir0
        ldiu      @CL25,ar0
        ldiu      -4,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      269,ar0
        sti       r0,*+ar0(ir0)
	.line	272
;----------------------------------------------------------------------
; 354 | btTxBuf[nTxPos+5] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTm
;     | p)]&0x0F)); // Production Version                                      
;----------------------------------------------------------------------
        ldiu      255,ir0
        ldiu      @CL25,ar0
        and       *+fp(2),ir0
        ldiu      15,r0
        and3      r0,*+ar0(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      270,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	273
;----------------------------------------------------------------------
; 355 | btTxBuf[nTxPos+6] = '';                                                
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      271,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      0,r0
        sti       r0,*+ar0(ir0)
	.line	274
;----------------------------------------------------------------------
; 356 | nTxPos = nTxPos+9;                                                     
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      9,r0
        ldiu      264,ir1
        addi3     r0,*+fp(ir0),r0
        sti       r0,*+fp(ir1)
	.line	276
;----------------------------------------------------------------------
; 358 | btTxBuf[nTxPos+0] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)]>>28)&0xF);// '2': // Year                                      
;----------------------------------------------------------------------
        ldiu      255,ir0
        ldiu      @CL26,ar0
        and       *+fp(2),ir0
        ldiu      -28,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      265,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	277
;----------------------------------------------------------------------
; 359 | btTxBuf[nTxPos+1] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)]>>24)&0xF);// '0': // Year                                      
;----------------------------------------------------------------------
        ldiu      255,ir0
        and       *+fp(2),ir0
        ldiu      @CL26,ar0
        ldiu      -24,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      266,ar0
        sti       r0,*+ar0(ir0)
	.line	278
;----------------------------------------------------------------------
; 360 | btTxBuf[nTxPos+2] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)]>>20)&0xF);// '1': // Year                                      
;----------------------------------------------------------------------
        ldiu      255,ir0
        and       *+fp(2),ir0
        ldiu      @CL26,ar0
        ldiu      -20,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      267,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	279
;----------------------------------------------------------------------
; 361 | btTxBuf[nTxPos+3] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)]>>16)&0xF);// '2': // Year                                      
;----------------------------------------------------------------------
        ldiu      255,ir0
        and       *+fp(2),ir0
        ldiu      @CL26,ar0
        ldiu      -16,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      268,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	280
;----------------------------------------------------------------------
; 362 | btTxBuf[nTxPos+4] = '-';                                               
;----------------------------------------------------------------------
        ldiu      264,ir0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      269,ar0
        ldiu      45,r0
        sti       r0,*+ar0(ir0)
	.line	281
;----------------------------------------------------------------------
; 363 | btTxBuf[nTxPos+5] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)]>>12)&0xF);// '0': // Month                                     
;----------------------------------------------------------------------
        ldiu      255,ir0
        ldiu      @CL26,ar0
        and       *+fp(2),ir0
        ldiu      -12,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      270,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	282
;----------------------------------------------------------------------
; 364 | btTxBuf[nTxPos+6] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)]>>8)&0xF);// '1': // Month                                      
;----------------------------------------------------------------------
        ldiu      255,ir0
        ldiu      @CL26,ar0
        and       *+fp(2),ir0
        ldiu      -8,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir0
        ldiu      271,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	283
;----------------------------------------------------------------------
; 365 | btTxBuf[nTxPos+7] = '-';                                               
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      272,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      45,r0
        sti       r0,*+ar0(ir0)
	.line	284
;----------------------------------------------------------------------
; 366 | btTxBuf[nTxPos+8] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)]>>4)&0xF);// '0': // Day                                        
;----------------------------------------------------------------------
        ldiu      255,ir0
        ldiu      @CL26,ar0
        and       *+fp(2),ir0
        ldiu      -4,r0
        lsh3      r0,*+ar0(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      273,ar0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        sti       r0,*+ar0(ir0)
	.line	285
;----------------------------------------------------------------------
; 367 | btTxBuf[nTxPos+9] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L
;     | (nTmp)])&0xF);// '1' : // Day                                          
;----------------------------------------------------------------------
        ldiu      255,ir0
        ldiu      @CL26,ar0
        and       *+fp(2),ir0
        ldiu      15,r0
        and3      r0,*+ar0(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      264,ir0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      274,ar0
        sti       r0,*+ar0(ir0)
	.line	286
;----------------------------------------------------------------------
; 368 | btTxBuf[nTxPos+10] = '';                                               
;----------------------------------------------------------------------
        ldiu      264,ir0
        addi3     fp,*+fp(ir0),ir0      ; Unsigned
        ldiu      275,ar0
        ldiu      0,r0
        sti       r0,*+ar0(ir0)
	.line	287
;----------------------------------------------------------------------
; 369 | nTxPos = nTxPos+11;                                                    
;----------------------------------------------------------------------
        ldiu      264,ir1
        ldiu      264,ir0
        ldiu      11,r0
        addi3     r0,*+fp(ir0),r0
        sti       r0,*+fp(ir1)
	.line	289
;----------------------------------------------------------------------
; 371 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      266,r1
        addi      fp,r1
        subi3     r0,*+fp(ir0),r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        subi      2,sp
        ldiu      264,ir0
        ldiu      *+fp(ir0),r1
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      264,ir1
        addi      1,r1
        sti       r1,*+fp(ir1)
        ldiu      265,ar0
        sti       r0,*+ar0(ir0)
	.line	290
;----------------------------------------------------------------------
; 372 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        addi3     r0,fp,ir0             ; Unsigned
        addi      1,r0
        sti       r0,*+fp(ir1)
        ldiu      3,r1
        sti       r1,*+ar0(ir0)
	.line	292
;----------------------------------------------------------------------
; 374 | if(WORD_L(btRxBuf[4]) != 2)                                            
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
        cmpi      2,r0
        beq       L105
;*      Branch Occurs to L105 
	.line	294
;----------------------------------------------------------------------
; 376 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      265,r0
        ldiu      *+fp(ir0),r1
        addi      fp,r0
        push      r1
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
L105:        
	.line	297
;----------------------------------------------------------------------
; 379 | MyPrintf("Unit Ver Sending : ");                                       
;----------------------------------------------------------------------
        ldiu      @CL27,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
	.line	299
;----------------------------------------------------------------------
; 381 | break;                                                                 
; 383 | //µµæÓªÛ≈¬(Single or married A)                                        
; 384 | case 0x0E:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
L106:        
	.line	303
;----------------------------------------------------------------------
; 385 | m_Variable.m_btCttSignalA.BYTE = btRxBuf[4];                           
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      *ar0,r0
        sti       r0,@_m_Variable+425
	.line	305
;----------------------------------------------------------------------
; 387 | m_Variable.m_bCiFaultFlag = (btRxBuf[4]&0x10) ? TRUE : FALSE;          
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      16,r0
        tstb3     *ar0,r0
        beq       L108
;*      Branch Occurs to L108 
        bud       L109
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L109 
L108:        
        ldiu      0,r0
L109:        
        sti       r0,@_m_Variable+432
	.line	307
;----------------------------------------------------------------------
; 389 | MyPrintf("Atcive_CAB - Traction - Sp - All_Door_Close - Ci_CutOff = 0x[
;     | %02X] \r\n",btRxBuf[4]);                                               
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      12,ar0
        ldiu      @CL28,r0
        ldiu      *ar0,r1
        push      r1
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	309
;----------------------------------------------------------------------
; 391 | break;                                                                 
; 393 | // ø≠¬˜±∏º∫ ªÛ≈¬ ø‰√ª                                                  
; 394 | case 0x10:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
	.line	313
;----------------------------------------------------------------------
; 395 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
L111:        
        sti       r0,*+fp(ir0)
	.line	314
;----------------------------------------------------------------------
; 396 | memset(btTxBuf,0x00,sizeof(btTxBuf));                                  
;----------------------------------------------------------------------
        ldiu      128,r2
        ldiu      0,r1
        ldiu      265,r0
        push      r2
        addi      fp,r0
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	316
;----------------------------------------------------------------------
; 398 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      264,ir1
        ldiu      265,ar0
        ldiu      1,r0
        ldiu      *+fp(ir0),r2
        ldiu      2,r1
        addi      r2,r0
        addi3     r2,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	317
;----------------------------------------------------------------------
; 399 | btTxBuf[nTxPos++] = 0x11; // Command Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r2
        ldiu      1,r0
        addi      r2,r0
        ldiu      17,r1
        addi3     r2,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	318
;----------------------------------------------------------------------
; 400 | btTxBuf[nTxPos++] = 0x00; // Message Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r0
        ldiu      *+fp(ir0),r2
        addi      r2,r0
        ldiu      0,r1
        addi3     r2,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	319
;----------------------------------------------------------------------
; 401 | btTxBuf[nTxPos++] = 0x02; // ±Ê¿Ã                                      
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r2
        ldiu      1,r0
        addi3     r2,fp,ir0             ; Unsigned
        addi      r2,r0
        sti       r0,*+fp(ir1)
        ldiu      2,r1
        sti       r1,*+ar0(ir0)
	.line	320
;----------------------------------------------------------------------
; 402 | btTxBuf[nTxPos++] = WORD_H(m_Variable.m_TrainCofVal); // µ•¿Ã≈Õ        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        ldiu      1,r1
        addi      r0,r1
        sti       r1,*+fp(ir1)
        ldiu      @_m_Variable+337,r1
        ash       -8,r1
        addi3     r0,fp,ir0             ; Unsigned
        and       255,r1
        sti       r1,*+ar0(ir0)
	.line	321
;----------------------------------------------------------------------
; 403 | btTxBuf[nTxPos++] = WORD_L(m_Variable.m_TrainCofVal); // µ•¿Ã≈Õ        
;----------------------------------------------------------------------
        ldiu      255,r0
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir1),r1
        addi      r1,r2
        sti       r2,*+fp(ir0)
        addi3     r1,fp,ir0             ; Unsigned
        and       @_m_Variable+337,r0
        sti       r0,*+ar0(ir0)
	.line	322
;----------------------------------------------------------------------
; 404 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      266,r1
        addi      fp,r1
        ldiu      264,ir0
        ldiu      1,r0
        subi3     r0,*+fp(ir0),r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        subi      2,sp
        ldiu      264,ir0
        ldiu      *+fp(ir0),r1
        ldiu      1,r2
        addi      r1,r2
        ldiu      264,ir1
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      265,ar0
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	323
;----------------------------------------------------------------------
; 405 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        addi      r0,r2
        ldiu      3,r1
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	324
;----------------------------------------------------------------------
; 406 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        push      r0
        ldiu      265,r0
        addi      fp,r0
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	326
;----------------------------------------------------------------------
; 408 | MyPrintf("Door State[X] : ",m_Variable.m_TrainCofVal);                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+337,r1
        push      r1
        ldiu      @CL29,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	328
;----------------------------------------------------------------------
; 410 | break;                                                                 
; 412 | // CI ¿ßƒ° ø‰√ª                                                        
; 413 | case 0x12:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
	.line	332
;----------------------------------------------------------------------
; 414 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
L113:        
        sti       r0,*+fp(ir0)
	.line	333
;----------------------------------------------------------------------
; 415 | memset(btTxBuf,0x00,sizeof(btTxBuf));                                  
;----------------------------------------------------------------------
        ldiu      265,r2
        ldiu      0,r1
        addi      fp,r2
        ldiu      128,r0
        push      r0
        push      r1
        push      r2
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	335
;----------------------------------------------------------------------
; 417 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      264,ir1
        ldiu      1,r0
        ldiu      265,ar0
        ldiu      *+fp(ir0),r2
        addi      r2,r0
        sti       r0,*+fp(ir1)
        addi3     r2,fp,ir0             ; Unsigned
        ldiu      2,r1
        sti       r1,*+ar0(ir0)
	.line	336
;----------------------------------------------------------------------
; 418 | btTxBuf[nTxPos++] = 0x13; // Command Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        ldiu      1,r2
        ldiu      19,r1
        addi3     r0,fp,ir0             ; Unsigned
        addi      r0,r2
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	337
;----------------------------------------------------------------------
; 419 | btTxBuf[nTxPos++] = 0x00; // Message Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r1
        addi      r1,r2
        sti       r2,*+fp(ir1)
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      0,r0
        sti       r0,*+ar0(ir0)
	.line	338
;----------------------------------------------------------------------
; 420 | btTxBuf[nTxPos++] = 0x01; // ±Ê¿Ã                                      
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r0
        ldiu      *+fp(ir0),r2
        addi      r2,r0
        sti       r0,*+fp(ir1)
        addi3     r2,fp,ir0             ; Unsigned
        ldiu      1,r1
        sti       r1,*+ar0(ir0)
	.line	339
;----------------------------------------------------------------------
; 421 | if(m_Variable.m_nCarPos >= 1 && m_Variable.m_nCarPos <= 8)             
;----------------------------------------------------------------------
        ldi       @_m_Variable+338,r0
        ble       L116
;*      Branch Occurs to L116 
        cmpi      8,r0
        bgt       L116
;*      Branch Occurs to L116 
	.line	341
;----------------------------------------------------------------------
; 423 | btTxBuf[nTxPos++] = 0x00; // µ•¿Ã≈Õ                                    
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        ldiu      0,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	342
;----------------------------------------------------------------------
; 424 | btTxBuf[nTxPos++] = MASKBIT(1,m_Variable.m_nCarPos-1); // µ•¿Ã≈Õ       
; 426 | else                                                                   
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r0
        ldiu      1,r1
        ldiu      1,r3
        ldiu      *+fp(ir0),r2
        addi      r2,r3
        sti       r3,*+fp(ir1)
        addi3     r2,fp,ir0             ; Unsigned
        subri     @_m_Variable+338,r0
        ash3      r0,r1,r0
        sti       r0,*+ar0(ir0)
        bu        L117
;*      Branch Occurs to L117 
L116:        
	.line	346
;----------------------------------------------------------------------
; 428 | btTxBuf[nTxPos++] = 0x80; // µ•¿Ã≈Õ                                    
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      264,ir1
        ldiu      265,ar0
        ldiu      *+fp(ir0),r1
        ldiu      128,r0
        addi      r1,r2
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	347
;----------------------------------------------------------------------
; 429 | btTxBuf[nTxPos++] = 0x00; // µ•¿Ã≈Õ                                    
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r1
        ldiu      0,r0
        addi      r1,r2
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
L117:        
	.line	349
;----------------------------------------------------------------------
; 431 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      266,r1
        ldiu      1,r0
        ldiu      264,ir0
        addi      fp,r1
        subi3     r0,*+fp(ir0),r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      2,sp
        ldiu      265,ar0
        ldiu      264,ir1
        ldiu      *+fp(ir0),r1
        ldiu      1,r2
        addi      r1,r2
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	350
;----------------------------------------------------------------------
; 432 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r0
        ldiu      *+fp(ir0),r2
        ldiu      3,r1
        addi3     r2,fp,ir0             ; Unsigned
        addi      r2,r0
        sti       r0,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	351
;----------------------------------------------------------------------
; 433 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r1
        ldiu      265,r0
        addi      fp,r0
        push      r1
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	353
;----------------------------------------------------------------------
; 435 | MyPrintf("C/I Position[X] : ",MASKBIT(1,m_Variable.m_nCarPos-1));      
;----------------------------------------------------------------------
        ldiu      1,r2
        ldiu      1,r0
        subri     @_m_Variable+338,r0
        ash3      r0,r2,r0
        push      r0
        ldiu      @CL30,r1
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	355
;----------------------------------------------------------------------
; 437 | break;                                                                 
; 439 | // ¬˜∑Æπ¯»£ ø‰√ª                                                       
; 440 | case 0x14:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
	.line	359
;----------------------------------------------------------------------
; 441 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
L119:        
        sti       r0,*+fp(ir0)
	.line	360
;----------------------------------------------------------------------
; 442 | memset(btTxBuf,0x00,sizeof(btTxBuf));                                  
;----------------------------------------------------------------------
        ldiu      128,r2
        ldiu      0,r1
        ldiu      265,r0
        push      r2
        addi      fp,r0
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	362
;----------------------------------------------------------------------
; 444 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      264,ir1
        ldiu      265,ar0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        ldiu      2,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	363
;----------------------------------------------------------------------
; 445 | btTxBuf[nTxPos++] = 0x15; // Command Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        ldiu      1,r2
        ldiu      21,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	364
;----------------------------------------------------------------------
; 446 | btTxBuf[nTxPos++] = 0x00; // Message Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        ldiu      0,r1
        sti       r1,*+ar0(ir0)
	.line	365
;----------------------------------------------------------------------
; 447 | btTxBuf[nTxPos++] = 0x02; // ±Ê¿Ã                                      
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        addi3     r0,fp,ir0             ; Unsigned
        ldiu      1,r2
        addi      r0,r2
        sti       r2,*+fp(ir1)
        ldiu      2,r1
        sti       r1,*+ar0(ir0)
	.line	366
;----------------------------------------------------------------------
; 448 | btTxBuf[nTxPos++] = WORD_H(BCD_BIN(m_Variable.m_nCarNo));              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        push      r0
        call      _BCD_BIN
                                        ; Call Occurs
        ldiu      264,ir0
        subi      1,sp
        ldiu      265,ar0
        ldiu      *+fp(ir0),r1
        ldiu      264,ir1
        ash       -8,r0
        and       255,r0
        ldiu      1,r2
        addi      r1,r2
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	367
;----------------------------------------------------------------------
; 449 | btTxBuf[nTxPos++] = WORD_L(BCD_BIN(m_Variable.m_nCarNo));              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        push      r0
        call      _BCD_BIN
                                        ; Call Occurs
        ldiu      1,r2
        ldiu      264,ir1
        subi      1,sp
        ldiu      264,ir0
        ldiu      *+fp(ir1),r1
        addi      r1,r2
        sti       r2,*+fp(ir0)
        ldiu      265,ar0
        addi3     r1,fp,ir0             ; Unsigned
        and       255,r0
        sti       r0,*+ar0(ir0)
	.line	368
;----------------------------------------------------------------------
; 450 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      266,r1
        ldiu      264,ir0
        addi      fp,r1
        ldiu      1,r0
        subi3     r0,*+fp(ir0),r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        subi      2,sp
        ldiu      264,ir1
        ldiu      *+fp(ir1),r1
        ldiu      1,r2
        ldiu      264,ir0
        addi      r1,r2
        sti       r2,*+fp(ir0)
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      265,ar0
        sti       r0,*+ar0(ir0)
	.line	369
;----------------------------------------------------------------------
; 451 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        ldiu      1,r2
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        ldiu      3,r1
        sti       r1,*+ar0(ir0)
	.line	370
;----------------------------------------------------------------------
; 452 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r0
        push      r0
        ldiu      265,r0
        addi      fp,r0
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	372
;----------------------------------------------------------------------
; 454 | MyPrintf("Train NUM Sending[%X] : ",m_Variable.m_nCarNo);              
;----------------------------------------------------------------------
        ldiu      @CL31,r0
        ldiu      @_m_Variable+341,r1
        push      r1
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	374
;----------------------------------------------------------------------
; 456 | break;                                                                 
; 458 | // CI∞Ì¿Â≥≠ ¬˜∑Æ ¿ßƒ° ø‰√ª                                             
; 459 | case 0x16:                                                             
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
	.line	378
;----------------------------------------------------------------------
; 460 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
L121:        
        sti       r0,*+fp(ir0)
	.line	379
;----------------------------------------------------------------------
; 461 | memset(btTxBuf,0x00,sizeof(btTxBuf));                                  
;----------------------------------------------------------------------
        ldiu      128,r2
        ldiu      0,r1
        ldiu      265,r0
        push      r2
        addi      fp,r0
        push      r1
        push      r0
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	381
;----------------------------------------------------------------------
; 463 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      264,ir1
        ldiu      265,ar0
        ldiu      1,r2
        ldiu      *+fp(ir0),r1
        ldiu      2,r0
        addi      r1,r2
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	382
;----------------------------------------------------------------------
; 464 | btTxBuf[nTxPos++] = 0x17; // Command Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      *+fp(ir0),r0
        addi      r0,r1
        ldiu      23,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r1,*+fp(ir1)
        sti       r2,*+ar0(ir0)
	.line	383
;----------------------------------------------------------------------
; 465 | btTxBuf[nTxPos++] = 0x00; // Message Code                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      *+fp(ir0),r2
        addi      r2,r1
        sti       r1,*+fp(ir1)
        addi3     r2,fp,ir0             ; Unsigned
        ldiu      0,r0
        sti       r0,*+ar0(ir0)
	.line	384
;----------------------------------------------------------------------
; 466 | btTxBuf[nTxPos++] = 0x02; // ±Ê¿Ã                                      
; 467 | //if(m_Variable.m_btCiFaultVal != 0x8000 && m_Variable.m_btTestOtherCiF
;     | ault != 0x8000) //                                                     
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r2
        ldiu      1,r1
        addi      r2,r1
        sti       r1,*+fp(ir1)
        addi3     r2,fp,ir0             ; Unsigned
        ldiu      2,r0
        sti       r0,*+ar0(ir0)
	.line	386
;----------------------------------------------------------------------
; 468 | if(m_Variable.m_btCiFaultVal != 0x8000 ) //                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+340,r0
        cmpi      @CL32,r0
        beqd      L140
        ldieq     264,ir0
        ldieq     1,r2
        ldieq     264,ir1
;*      Branch Occurs to L140 
	.line	388
;----------------------------------------------------------------------
; 470 | btTxBuf[nTxPos++] = 0x00;                                              
; 471 | switch(m_Variable.m_TrainCofVal)                                       
; 485 |         // 2∑Æ                                                         
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r1
        ldiu      *+fp(ir0),r2
        ldiu      0,r0
        addi      r2,r1
        bud       L134
        addi3     r2,fp,ir0             ; Unsigned
        sti       r1,*+fp(ir1)
        sti       r0,*+ar0(ir0)
;*      Branch Occurs to L134 
	.line	404
;----------------------------------------------------------------------
; 486 | case 0: btTxBuf[nTxPos++] = 0xFC | m_Variable.m_btCiFaultVal ; break; /
;     | / µ•¿Ã≈Õ                                                               
; 487 |         // 4∑Æ                                                         
;----------------------------------------------------------------------
L124:        
        ldiu      252,r2
        ldiu      *+fp(ir0),r1
        ldiu      265,ar0
        addi      r1,r0
        addi3     r1,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        or        @_m_Variable+340,r2
        sti       r2,*+ar0(ir0)
        bu        L141
;*      Branch Occurs to L141 
	.line	406
;----------------------------------------------------------------------
; 488 | case 1: btTxBuf[nTxPos++] = 0xF0 | m_Variable.m_btCiFaultVal ; break; /
;     | / µ•¿Ã≈Õ                                                               
; 489 |         // 6∑Æ                                                         
;----------------------------------------------------------------------
L126:        
        ldiu      240,r0
        ldiu      *+fp(ir0),r2
        ldiu      265,ar0
        addi      r2,r1
        addi3     r2,fp,ir0             ; Unsigned
        sti       r1,*+fp(ir1)
        or        @_m_Variable+340,r0
        sti       r0,*+ar0(ir0)
        bu        L141
;*      Branch Occurs to L141 
	.line	408
;----------------------------------------------------------------------
; 490 | case 2: btTxBuf[nTxPos++] = 0xC0 | m_Variable.m_btCiFaultVal ; break; /
;     | / µ•¿Ã≈Õ                                                               
; 491 |         // 8∑Æ                                                         
;----------------------------------------------------------------------
L128:        
        ldiu      192,r0
        ldiu      *+fp(ir0),r2
        ldiu      265,ar0
        addi      r2,r1
        addi3     r2,fp,ir0             ; Unsigned
        sti       r1,*+fp(ir1)
        or        @_m_Variable+340,r0
        sti       r0,*+ar0(ir0)
        bu        L141
;*      Branch Occurs to L141 
	.line	410
;----------------------------------------------------------------------
; 492 | case 3: btTxBuf[nTxPos++] = 0x00 | m_Variable.m_btCiFaultVal ; break; /
;     | / µ•¿Ã≈Õ                                                               
; 493 | default:                                                               
;----------------------------------------------------------------------
L130:        
        ldiu      *+fp(ir0),r1
        ldiu      265,ar0
        addi      r1,r0
        addi3     r1,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        ldiu      @_m_Variable+340,r0
        sti       r0,*+ar0(ir0)
        bu        L141
;*      Branch Occurs to L141 
	.line	412
;----------------------------------------------------------------------
; 494 | btTxBuf[nTxPos++] = 0x00 | m_Variable.m_btCiFaultVal ; break; // µ•¿Ã≈Õ
; 496 | //btTxBuf[nTxPos++] = m_btCiFaultVal | m_btTestOtherCiFault;           
; 498 | else                                                                   
;----------------------------------------------------------------------
L132:        
        ldiu      *+fp(ir0),r1
        ldiu      265,ar0
        addi      r1,r0
        addi3     r1,fp,ir0             ; Unsigned
        sti       r0,*+fp(ir1)
        ldiu      @_m_Variable+340,r0
        sti       r0,*+ar0(ir0)
        bu        L141
;*      Branch Occurs to L141 
L134:        
	.line	389
        ldi       @_m_Variable+337,r0
        beqd      L124
        ldieq     264,ir0
        ldieq     1,r0
        ldieq     264,ir1
;*      Branch Occurs to L124 
        cmpi      1,r0
        beqd      L126
        ldieq     264,ir0
        ldieq     1,r1
        ldieq     264,ir1
;*      Branch Occurs to L126 
        cmpi      2,r0
        beqd      L128
        ldieq     264,ir0
        ldieq     1,r1
        ldieq     264,ir1
;*      Branch Occurs to L128 
        cmpi      3,r0
        beqd      L130
        ldieq     264,ir0
        ldieq     1,r0
        ldieq     264,ir1
;*      Branch Occurs to L130 
        bud       L132
        ldiu      264,ir0
        ldiu      1,r0
        ldiu      264,ir1
;*      Branch Occurs to L132 
	.line	418
;----------------------------------------------------------------------
; 500 | btTxBuf[nTxPos++] = 0x80;                                              
;----------------------------------------------------------------------
L140:        
        ldiu      265,ar0
        ldiu      *+fp(ir0),r0
        ldiu      128,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
	.line	419
;----------------------------------------------------------------------
; 501 | btTxBuf[nTxPos++] = 0x00;                                              
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      1,r2
        ldiu      *+fp(ir0),r0
        ldiu      0,r1
        addi      r0,r2
        addi3     r0,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r1,*+ar0(ir0)
L141:        
	.line	421
;----------------------------------------------------------------------
; 503 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      266,r1
        ldiu      1,r0
        ldiu      264,ir0
        addi      fp,r1
        subi3     r0,*+fp(ir0),r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        ldiu      264,ir0
        subi      2,sp
        ldiu      265,ar0
        ldiu      264,ir1
        ldiu      *+fp(ir0),r1
        ldiu      1,r2
        addi      r1,r2
        addi3     r1,fp,ir0             ; Unsigned
        sti       r2,*+fp(ir1)
        sti       r0,*+ar0(ir0)
	.line	422
;----------------------------------------------------------------------
; 504 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      *+fp(ir0),r1
        ldiu      1,r2
        addi      r1,r2
        sti       r2,*+fp(ir1)
        addi3     r1,fp,ir0             ; Unsigned
        ldiu      3,r0
        sti       r0,*+ar0(ir0)
	.line	423
;----------------------------------------------------------------------
; 505 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldiu      265,r0
        ldiu      *+fp(ir0),r1
        addi      fp,r0
        push      r1
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	425
;----------------------------------------------------------------------
; 507 | MyPrintf("Other C/I Fault Condition[%X] : ",m_Variable.m_btCiFaultVal);
;----------------------------------------------------------------------
        ldiu      @CL33,r1
        ldiu      @_m_Variable+340,r0
        push      r0
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	427
;----------------------------------------------------------------------
; 509 | break;                                                                 
;----------------------------------------------------------------------
        bu        L155
;*      Branch Occurs to L155 
	.line	161
L143:        
        ldiu      *ar0,r0
        cmpi      14,r0
        bgt       L151
;*      Branch Occurs to L151 
        beq       L106
;*      Branch Occurs to L106 
        cmpi      2,r0
        beq       L78
;*      Branch Occurs to L78 
        cmpi      6,r0
        beq       L79
;*      Branch Occurs to L79 
        cmpi      8,r0
        beqd      L82
	nop
        ldieq     264,ir0
        ldieq     0,r0
;*      Branch Occurs to L82 
        cmpi      10,r0
        beq       L85
;*      Branch Occurs to L85 
        cmpi      12,r0
        beqd      L91
	nop
        ldieq     264,ir0
        ldieq     0,r0
;*      Branch Occurs to L91 
        bu        L155
;*      Branch Occurs to L155 
L151:        
        cmpi      16,r0
        beqd      L111
	nop
        ldieq     264,ir0
        ldieq     0,r0
;*      Branch Occurs to L111 
        cmpi      18,r0
        beqd      L113
	nop
        ldieq     264,ir0
        ldieq     0,r0
;*      Branch Occurs to L113 
        cmpi      20,r0
        beqd      L119
	nop
        ldieq     264,ir0
        ldieq     0,r0
;*      Branch Occurs to L119 
        cmpi      22,r0
        beqd      L121
	nop
        ldieq     264,ir0
        ldieq     0,r0
;*      Branch Occurs to L121 
L155:        
	.line	430
;----------------------------------------------------------------------
; 512 | if(nTxPos)                                                             
;----------------------------------------------------------------------
        ldiu      264,ir0
        ldi       *+fp(ir0),r0
        beq       L168
;*      Branch Occurs to L168 
	.line	432
;----------------------------------------------------------------------
; 514 | if(m_Variable.m_nDbgTxPos == 0xFFFFFFFF)                               
;----------------------------------------------------------------------
        ldiu      @_m_Variable+352,r0
        cmpi      @CL5,r0
        bned      L168
	nop
        ldieq     393,ir0
        ldieq     0,r0
;*      Branch Occurs to L168 
	.line	434
;----------------------------------------------------------------------
; 516 | szBuf[0] = 0;                                                          
;----------------------------------------------------------------------
        sti       r0,*+fp(ir0)
	.line	435
;----------------------------------------------------------------------
; 517 | sprintf(szBuf2,"[TX:%02d] ",nTxPos); strcat(szBuf,szBuf2);             
;----------------------------------------------------------------------
        ldiu      @CL6,r1
        ldiu      264,ir0
        ldiu      905,r0
        ldiu      *+fp(ir0),r2
        addi      fp,r0
        push      r2
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	436
;----------------------------------------------------------------------
; 518 | for(i=0;i<nTxPos;i++) {sprintf(szBuf2,"%02X ",WORD_L(btTxBuf[i])); strc
;     | at(szBuf,szBuf2);}                                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        ldiu      264,ir0
        cmpi3     *+fp(ir0),r0
        bged      L159
	nop
        ldiu      265,ar4
        ldiu      255,r4
;*      Branch Occurs to L159 
L158:        
        ldiu      *+fp(1),ir0
        ldiu      905,r0
        addi      fp,ir0
        ldiu      @CL3,r1
        and3      r4,*+ar4(ir0),r2
        push      r2
        addi      fp,r0
        push      r1
        push      r0
        call      _sprintf
                                        ; Call Occurs
        subi      3,sp
        ldiu      905,r0
        addi      fp,r0
        push      r0
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        ldiu      264,ir0
        cmpi3     *+fp(ir0),r0
        blt       L158
;*      Branch Occurs to L158 
L159:        
	.line	437
;----------------------------------------------------------------------
; 519 | strcat(szBuf,"\r\n");                                                  
;----------------------------------------------------------------------
        ldiu      @CL4,r1
        ldiu      393,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _strcat
                                        ; Call Occurs
        subi      2,sp
	.line	438
;----------------------------------------------------------------------
; 520 | user_DebugPrint(szBuf);                                                
;----------------------------------------------------------------------
        ldiu      393,r0
        addi      fp,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	442
;----------------------------------------------------------------------
; 524 | break;                                                                 
;----------------------------------------------------------------------
        bu        L168
;*      Branch Occurs to L168 
L161:        
	.line	21
        ldiu      *+fp(6),r0
        cmpi      1,r0
        beq       L23
;*      Branch Occurs to L23 
        cmpi      2,r0
        beq       L23
;*      Branch Occurs to L23 
        cmpi      3,r0
        beq       L23
;*      Branch Occurs to L23 
        cmpi      4,r0
        beq       L23
;*      Branch Occurs to L23 
        cmpi      5,r0
        beq       L23
;*      Branch Occurs to L23 
        cmpi      6,r0
        beq       L23
;*      Branch Occurs to L23 
        cmpi      7,r0
        beqd      L72
	nop
        ldieq     fp,r0
        ldieq     7,r1
;*      Branch Occurs to L72 
L168:        
	.line	444
        pop       ar4
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      970,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	526,000001010h,968


	.sect	 ".text"

	.global	_LonWorkRx
	.sym	_LonWorkRx,_LonWorkRx,44,2,0
	.func	530
;******************************************************************************
;* FUNCTION NAME: _LonWorkRx                                                  *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,fp,ir0,ir1,sp,st                      *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 4 Auto + 0 SOE = 8 words          *
;******************************************************************************
_LonWorkRx:
	.sym	_nRxPos,-2,4,9,32
	.sym	_pRxBuf,-3,28,9,32
	.sym	_i,1,4,1,32
	.sym	_nRxLen,2,12,1,32
	.sym	_pBuf,3,28,1,32
	.sym	_pLnWkDp,4,24,1,32,.fake8
	.line	1
;----------------------------------------------------------------------
; 530 | UCHAR LonWorkRx(int nRxPos, UCHAR *pRxBuf)                             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      4,sp
	.line	2
;----------------------------------------------------------------------
; 532 | int i;                                                                 
; 533 | UCHAR nRxLen;                                                          
; 534 | UCHAR *pBuf;                                                           
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 535 | PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;                                
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        sti       r0,*+fp(4)
	.line	8
;----------------------------------------------------------------------
; 537 | if(nRxPos >= 1 && nRxPos <= 6)                                         
;----------------------------------------------------------------------
        ldi       *-fp(2),r0
        ble       L186
;*      Branch Occurs to L186 
        cmpi      6,r0
        bgt       L186
;*      Branch Occurs to L186 
	.line	10
;----------------------------------------------------------------------
; 539 | nRxLen = MIN(sizeof(LNWKFTPIT)-1,WORD_L(pLnWkDp->lfBuf[nRxPos-1].btLen)
;     | +6);                                                                   
;----------------------------------------------------------------------
        ldiu      1,ar0
        subri     *-fp(2),ar0
        ldiu      255,r0
        mpyi      200,ar0
        addi      *+fp(4),ar0           ; Unsigned
        ldiu      199,r1
        and       *+ar0(19),r0
        addi      6,r0                  ; Unsigned
        cmpi3     r0,r1
        bhs       L174
;*      Branch Occurs to L174 
        bud       L175
	nop
	nop
        ldiu      199,r0
;*      Branch Occurs to L175 
L174:        
        ldiu      1,ar0
        subri     *-fp(2),ar0
        mpyi      200,ar0
        addi      *+fp(4),ar0           ; Unsigned
        ldiu      255,r0
        and       *+ar0(19),r0
        addi      6,r0                  ; Unsigned
L175:        
        sti       r0,*+fp(2)
	.line	11
;----------------------------------------------------------------------
; 540 | if(nRxLen > 6)                                                         
;----------------------------------------------------------------------
        cmpi      6,r0
        bls       L184
;*      Branch Occurs to L184 
	.line	13
;----------------------------------------------------------------------
; 542 | pBuf = &pLnWkDp->lfBuf[nRxPos-1].btStx;                                
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0
        mpyi      200,r0
        addi      *+fp(4),r0            ; Unsigned
        addi      16,r0                 ; Unsigned
        sti       r0,*+fp(3)
	.line	14
;----------------------------------------------------------------------
; 543 | for(i=0;i<nRxLen;i++) pRxBuf[i] = WORD_L(pBuf[i]);                     
; 545 | //MyPrintf("[Len:%d,Pos:%d->",nRxLen,nRxPos);                          
; 546 | //for(i=0;i<nRxLen;i++) MyPrintf("%02X ",pRxBuf[i]);                   
; 547 | //MyPrintf("]\r\n");                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        ldiu      *+fp(1),r0
        cmpi      *+fp(2),r0
        ldiu      255,r1
        bhs       L178
;*      Branch Occurs to L178 
L177:        
        ldiu      *+fp(1),ar1
        ldiu      *+fp(3),ir0
        ldiu      *-fp(3),ir1
        ldiu      ar1,ar0
        and3      r1,*+ar1(ir0),r0
        sti       r0,*+ar0(ir1)
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        ldiu      *+fp(1),r0
        cmpi      *+fp(2),r0
        blo       L177
;*      Branch Occurs to L177 
L178:        
	.line	20
;----------------------------------------------------------------------
; 549 | if(pRxBuf[0] == STX && pRxBuf[nRxLen-1] == ETX)                        
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      *ar0,r0
        cmpi      2,r0
        bne       L182
;*      Branch Occurs to L182 
        ldiu      *+fp(2),ar0
        addi      *-fp(3),ar0           ; Unsigned
        ldiu      *-ar0(1),r0
        cmpi      3,r0
        bne       L182
;*      Branch Occurs to L182 
	.line	22
;----------------------------------------------------------------------
; 551 | return nRxLen;                                                         
; 553 | else                                                                   
;----------------------------------------------------------------------
        bud       L204
	nop
	nop
        ldiu      *+fp(2),r0
;*      Branch Occurs to L204 
L182:        
	.line	26
;----------------------------------------------------------------------
; 555 | return 0;                                                              
; 558 | else                                                                   
;----------------------------------------------------------------------
        bud       L204
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L204 
L184:        
	.line	31
;----------------------------------------------------------------------
; 560 | return 0;                                                              
; 563 | else                                                                   
;----------------------------------------------------------------------
        bud       L204
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L204 
L186:        
	.line	35
;----------------------------------------------------------------------
; 564 | if(nRxPos == 7)                                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        cmpi      7,r0
        bned      L202
        ldieq     255,r0
        ldieq     *+fp(4),ir0
        ldieq     1219,ar0
;*      Branch Occurs to L202 
	.line	37
;----------------------------------------------------------------------
; 566 | nRxLen = MIN(sizeof(LNWKGERIT),WORD_L(pLnWkDp->lgRxBuf.btLen)+6);      
;----------------------------------------------------------------------
        ldiu      200,r1
        and3      r0,*+ar0(ir0),r0
        addi      6,r0                  ; Unsigned
        cmpi3     r0,r1
        bhsd      L189
        ldihs     *+fp(4),ir0
        ldihs     1219,ar0
        ldihs     255,r0
;*      Branch Occurs to L189 
        bud       L190
	nop
	nop
        ldiu      200,r0
;*      Branch Occurs to L190 
L189:        
        and3      r0,*+ar0(ir0),r0
        addi      6,r0                  ; Unsigned
L190:        
        sti       r0,*+fp(2)
	.line	38
;----------------------------------------------------------------------
; 567 | if(nRxLen > 5)                                                         
;----------------------------------------------------------------------
        cmpi      5,r0
        bls       L200
;*      Branch Occurs to L200 
	.line	40
;----------------------------------------------------------------------
; 569 | pBuf = &pLnWkDp->lfBuf[nRxPos-1].btStx;                                
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0
        mpyi      200,r0
        addi      *+fp(4),r0            ; Unsigned
        addi      16,r0                 ; Unsigned
        sti       r0,*+fp(3)
	.line	41
;----------------------------------------------------------------------
; 570 | for(i=0;i<nRxLen;i++) pRxBuf[i] = WORD_L(pBuf[i]);                     
; 572 | //MyPrintf("[Len:%d,Pos:%d->",nRxLen,nRxPos);                          
; 573 | //for(i=0;i<nRxLen;i++) MyPrintf("%02X ",pRxBuf[i]);                   
; 574 | //MyPrintf("]\r\n");                                                   
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        ldiu      *+fp(1),r0
        cmpi      *+fp(2),r0
        ldiu      255,r1
        bhs       L193
;*      Branch Occurs to L193 
L192:        
        ldiu      *+fp(1),ar1
        ldiu      *+fp(3),ir0
        ldiu      *-fp(3),ir1
        ldiu      ar1,ar0
        and3      r1,*+ar1(ir0),r0
        sti       r0,*+ar0(ir1)
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        ldiu      *+fp(1),r0
        cmpi      *+fp(2),r0
        blo       L192
;*      Branch Occurs to L192 
L193:        
	.line	47
;----------------------------------------------------------------------
; 576 | if(pRxBuf[0] == STX && pRxBuf[nRxLen-1] == ETX && !Make1ByteBcc(&pRxBuf
;     | [1],nRxLen-2))                                                         
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      *ar0,r0
        cmpi      2,r0
        bne       L198
;*      Branch Occurs to L198 
        ldiu      *+fp(2),ar0
        addi      *-fp(3),ar0           ; Unsigned
        ldiu      *-ar0(1),r0
        cmpi      3,r0
        bned      L198
	nop
        ldieq     1,r1
        ldieq     2,r0
;*      Branch Occurs to L198 
        addi      *-fp(3),r1            ; Unsigned
        subri     *+fp(2),r0            ; Unsigned
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        cmpi      0,r0
        subi      2,sp
        bne       L198
;*      Branch Occurs to L198 
	.line	49
;----------------------------------------------------------------------
; 578 | return nRxLen;                                                         
; 580 | else                                                                   
;----------------------------------------------------------------------
        bud       L204
	nop
	nop
        ldiu      *+fp(2),r0
;*      Branch Occurs to L204 
L198:        
	.line	53
;----------------------------------------------------------------------
; 582 | return 0;                                                              
; 585 | else                                                                   
;----------------------------------------------------------------------
        bud       L204
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L204 
L200:        
	.line	58
;----------------------------------------------------------------------
; 587 | return 0;                                                              
; 590 | else                                                                   
;----------------------------------------------------------------------
        bud       L204
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L204 
L202:        
	.line	63
;----------------------------------------------------------------------
; 592 | return 0;                                                              
;----------------------------------------------------------------------
        bud       L204
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L204 
	.line	66
;----------------------------------------------------------------------
; 595 | return 0;                                                              
;----------------------------------------------------------------------
L204:        
	.line	67
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      6,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	596,000000000h,4


	.sect	 ".text"

	.global	_LonWorkTx
	.sym	_LonWorkTx,_LonWorkTx,32,2,0
	.func	600
;******************************************************************************
;* FUNCTION NAME: _LonWorkTx                                                  *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,fp,ir0,ir1,sp                         *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 579 Auto + 0 SOE = 583 words      *
;******************************************************************************
_LonWorkTx:
	.sym	_pTxBuf,-2,28,9,32
	.sym	_nLen,-3,12,9,32
	.sym	_i,1,4,1,32
	.sym	_szBuf,2,50,1,16384,,512
	.sym	_szBuf2,514,50,1,2048,,64
	.sym	_pBuf,578,28,1,32
	.sym	_pLnWkDp,579,24,1,32,.fake8
	.line	1
;----------------------------------------------------------------------
; 600 | void LonWorkTx(UCHAR *pTxBuf,UCHAR nLen)                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      579,sp
	.line	2
;----------------------------------------------------------------------
; 602 | int i;                                                                 
; 603 | char szBuf[512];                                                       
; 604 | char szBuf2[64];                                                       
; 606 | UCHAR *pBuf;                                                           
;----------------------------------------------------------------------
	.line	8
;----------------------------------------------------------------------
; 607 | PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;                                
;----------------------------------------------------------------------
        ldiu      579,ir0
        ldiu      @CL7,r0
        sti       r0,*+fp(ir0)
	.line	10
;----------------------------------------------------------------------
; 609 | pBuf = &pLnWkDp->lgTxBuf.btStx;                                        
;----------------------------------------------------------------------
        ldiu      579,ir1
        ldiu      1416,r0
        ldiu      578,ir0
        addi3     r0,*+fp(ir1),r0       ; Unsigned
        sti       r0,*+fp(ir0)
	.line	12
;----------------------------------------------------------------------
; 611 | memcpy(pBuf,pTxBuf,(int)nLen);                                         
;----------------------------------------------------------------------
        ldiu      *-fp(3),r1
        ldiu      *+fp(ir0),r0
        push      r1
        ldiu      *-fp(2),r1
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	13
;----------------------------------------------------------------------
; 612 | LNWK_TXINTREQ();                                                       
;----------------------------------------------------------------------
        ldiu      @CL34,ar0
        ldiu      1,r0
        ldiu      @CL34,ar1
        andn3     *ar0,r0,r0
        sti       r0,*ar1
	.line	14
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      581,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	613,000000000h,579



	.sect	".cinit"
	.field  	1,32
	.field  	_nDelayCnt$4+0,32
	.field  	0,32		; _nDelayCnt$4 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_LonInfo_1msLoop
	.sym	_LonInfo_1msLoop,_LonInfo_1msLoop,32,2,0
	.func	618
;******************************************************************************
;* FUNCTION NAME: _LonInfo_1msLoop                                            *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r4,ar0,fp,ir0,sp,st                           *
;*   Regs Saved         : r4                                                  *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 34 Auto + 1 SOE = 37 words        *
;******************************************************************************
_LonInfo_1msLoop:
	.bss	_nDelayCnt$4,1
	.sym	_nDelayCnt,_nDelayCnt$4,14,3,32
	.sym	_i,1,4,1,32
	.sym	_nTxPos,2,4,1,32
	.sym	_btTxBuf,3,60,1,1024,,32
	.line	1
;----------------------------------------------------------------------
; 618 | void LonInfo_1msLoop()                                                 
; 620 | int i;                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      34,sp
        push      r4
	.line	4
;----------------------------------------------------------------------
; 621 | int nTxPos = 0;                                                        
; 622 | UCHAR btTxBuf[32];                                                     
; 623 | static UINT nDelayCnt = 0;                                             
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	8
;----------------------------------------------------------------------
; 625 | if(m_Variable.m_nCarKindToLonCnt < 6 && !(nDelayCnt%2000))             
;----------------------------------------------------------------------
        ldiu      @_m_Variable+343,r0
        cmpi      6,r0
        bge       L214
;*      Branch Occurs to L214 
        ldiu      @_nDelayCnt$4+0,r0
        ldiu      2000,r1
        call      MOD_U30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L214
;*      Branch Occurs to L214 
	.line	10
;----------------------------------------------------------------------
; 627 | m_Variable.m_nCarKindToLonCnt++;                                       
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+343,r0
        sti       r0,@_m_Variable+343
	.line	12
;----------------------------------------------------------------------
; 629 | MyPrintf("Train NUM Sending[%X] : ",m_Variable.m_nCarNo);              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r1
        push      r1
        ldiu      @CL31,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	14
;----------------------------------------------------------------------
; 631 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	15
;----------------------------------------------------------------------
; 632 | btTxBuf[nTxPos++] = STX; // STX                                        
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      1,r1
        addi      3,ar0
        ldiu      r0,ir0
        addi      ir0,r1
        ldiu      2,r0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	16
;----------------------------------------------------------------------
; 633 | btTxBuf[nTxPos++] = 0xF0; // Command Code                              
;----------------------------------------------------------------------
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      ir0,r1
        sti       r1,*+fp(2)
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      240,r0
        sti       r0,*+ar0(ir0)
	.line	17
;----------------------------------------------------------------------
; 634 | btTxBuf[nTxPos++] = 0x00; // Message Code                              
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      1,r0
        addi      3,ar0
        ldiu      *+fp(2),ir0
        ldiu      0,r1
        addi      ir0,r0
        sti       r0,*+fp(2)
        sti       r1,*+ar0(ir0)
	.line	18
;----------------------------------------------------------------------
; 635 | btTxBuf[nTxPos++] = 0x02; // ±Ê¿Ã                                      
;----------------------------------------------------------------------
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      ir0,r1
        sti       r1,*+fp(2)
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      2,r0
        sti       r0,*+ar0(ir0)
	.line	19
;----------------------------------------------------------------------
; 636 | btTxBuf[nTxPos++] = WORD_H(m_Variable.m_nCarNo); // ¬˜∑Æπ¯»£ ¿¸¥ﬁ      
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        ldiu      @_m_Variable+341,r0
        ldiu      fp,ar0
        lsh       -8,r0
        addi      3,ar0
        sti       r1,*+fp(2)
        and       255,r0
        sti       r0,*+ar0(ir0)
	.line	20
;----------------------------------------------------------------------
; 637 | btTxBuf[nTxPos++] = WORD_L(m_Variable.m_nCarNo); // ¬˜∑Æπ¯»£ ¿¸¥ﬁ      
;----------------------------------------------------------------------
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        ldiu      255,r0
        addi      ir0,r1
        ldiu      fp,ar0
        and       @_m_Variable+341,r0
        addi      3,ar0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	21
;----------------------------------------------------------------------
; 638 | btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum   
;----------------------------------------------------------------------
        ldiu      fp,r0
        ldiu      1,r1
        addi      4,r0
        subri     *+fp(2),r1
        push      r1
        push      r0
        call      _Make1ByteBcc
                                        ; Call Occurs
        subi      2,sp
        ldiu      *+fp(2),ir0
        ldiu      1,r1
        addi      ir0,r1
        ldiu      fp,ar0
        addi      3,ar0
        sti       r1,*+fp(2)
        sti       r0,*+ar0(ir0)
	.line	22
;----------------------------------------------------------------------
; 639 | btTxBuf[nTxPos++] = ETX; // ETX                                        
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *+fp(2),ir0
        addi      ir0,r1
        ldiu      fp,ar0
        sti       r1,*+fp(2)
        addi      3,ar0
        ldiu      3,r0
        sti       r0,*+ar0(ir0)
	.line	23
;----------------------------------------------------------------------
; 640 | LonWorkTx(btTxBuf,nTxPos);                                             
;----------------------------------------------------------------------
        ldiu      *+fp(2),r1
        push      r1
        ldiu      fp,r0
        addi      3,r0
        push      r0
        call      _LonWorkTx
                                        ; Call Occurs
        subi      2,sp
	.line	25
;----------------------------------------------------------------------
; 642 | MyPrintf("[TX:%02d] ",nTxPos);                                         
;----------------------------------------------------------------------
        ldiu      *+fp(2),r1
        ldiu      @CL6,r0
        push      r1
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
	.line	26
;----------------------------------------------------------------------
; 643 | for(i=0;i<nTxPos;i++) MyPrintf("%02X ",WORD_L(btTxBuf[i]));            
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        ldiu      255,r4
        cmpi      *+fp(2),r0
        bge       L213
;*      Branch Occurs to L213 
L212:        
        ldiu      fp,ar0
        ldiu      *+fp(1),ir0
        addi      3,ar0
        ldiu      @CL3,r1
        and3      r4,*+ar0(ir0),r0
        push      r0
        push      r1
        call      _MyPrintf
                                        ; Call Occurs
        subi      2,sp
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *+fp(2),r0
        blt       L212
;*      Branch Occurs to L212 
L213:        
	.line	27
;----------------------------------------------------------------------
; 644 | MyPrintf("\r\n");                                                      
;----------------------------------------------------------------------
        ldiu      @CL4,r0
        push      r0
        call      _MyPrintf
                                        ; Call Occurs
        subi      1,sp
L214:        
	.line	30
;----------------------------------------------------------------------
; 647 | nDelayCnt++;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_nDelayCnt$4+0,r0    ; Unsigned
        sti       r0,@_nDelayCnt$4+0
	.line	31
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      36,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	648,000000010h,34


;******************************************************************************
;* STRINGS                                                                    *
;******************************************************************************
	.sect	".const"
SL1:	.byte	"MDS Falut Request : ",0
SL2:	.byte	"%02X ",0
SL3:	.byte	13,10,0
SL4:	.byte	"[TX:%02d] ",0
SL5:	.byte	"[%d,%3d,%c]",0
SL6:	.byte	"%02X",0
SL7:	.byte	"..",0
SL8:	.byte	"***FTP File receive... ^^;;***",13,10,0
SL9:	.byte	"***FTP data buffer full..",13,10,0
SL10:	.byte	"***FTP File receive End ^..^ ***",13,10,0
SL11:	.byte	"[RX:%02d] ",0
SL12:	.byte	"WAYSIDE ON Flage On. ",13,10,0
SL13:	.byte	"FTP Sending END. ",13,10,0
SL14:	.byte	"TIME Sending : ",0
SL15:	.byte	"Unit State Data Sending : ",0
SL16:	.byte	"Unit Ver Sending : ",0
SL17:	.byte	"Atcive_CAB - Traction - Sp - All_Door_Close - Ci_CutOff = 0"
	.byte	"x[%02X] ",13,10,0
SL18:	.byte	"Door State[X] : ",0
SL19:	.byte	"C/I Position[X] : ",0
SL20:	.byte	"Train NUM Sending[%X] : ",0
SL21:	.byte	"Other C/I Fault Condition[%X] : ",0
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

	.sect	".cinit"
	.field  	34,32
	.field  	CL1+0,32
	.field  	12582912,32
	.field  	SL1,32
	.field  	SL2,32
	.field  	SL3,32
	.field  	-1,32
	.field  	SL4,32
	.field  	11534336,32
	.field  	16776716,32
	.field  	_btFtpOneRecRxBuf$3,32
	.field  	SL5,32
	.field  	SL6,32
	.field  	SL7,32
	.field  	3145728,32
	.field  	SL8,32
	.field  	SL9,32
	.field  	SL10,32
	.field  	SL11,32
	.field  	SL12,32
	.field  	SL13,32
	.field  	SL14,32
	.field  	_m_Variable+323,32
	.field  	_m_Variable+307,32
	.field  	SL15,32
	.field  	_m_Variable,32
	.field  	_m_Variable+353,32
	.field  	_m_Variable+389,32
	.field  	SL16,32
	.field  	SL17,32
	.field  	SL18,32
	.field  	SL19,32
	.field  	SL20,32
	.field  	32768,32
	.field  	SL21,32
	.field  	10485760,32

	.sect	".text"
;******************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                              *
;******************************************************************************

	.global	_ConvHex2Asc

	.global	_Make1ByteBcc

	.global	_MyPrintf

	.global	_user_DebugPrint

	.global	_BitSwap

	.global	_m_Variable
	.global	_sprintf
	.global	_strcat
	.global	_memcpy
	.global	_memset
	.global	_strlen
	.global	_BCD_BIN
	.global	MOD_U30
