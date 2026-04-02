;******************************************************************************
;* TMS320C3x/4x ANSI C Code Generator                            Version 5.11 *
;* Date/Time created: Sat Sep 19 09:27:36 2015                                *
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
;	c:\lang\tms320c3x\511\bin\ac30.exe xr16l784.c C:\Users\JANGDU~1\AppData\Local\Temp\xr16l784.if 
	.file	"xr16l784.c"
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
	.file	"xr16l784.h"
	.utag	.fake68,32
	.member	_btRxd,0,12,11,32
	.member	_btTxd,0,12,11,32
	.member	_btDll,0,12,11,32
	.eos
	.utag	.fake69,32
	.member	_btDlm,0,12,11,32
	.member	_btIer,0,12,11,32
	.eos
	.utag	.fake70,32
	.member	_btIir,0,12,11,32
	.member	_btFcr,0,12,11,32
	.eos
	.stag	.fake67,512
	.member	_CREG1,0,9,8,32,.fake68
	.member	_CREG2,32,9,8,32,.fake69
	.member	_CREG3,64,9,8,32,.fake70
	.member	_btLcr,96,12,8,32
	.member	_btMcr,128,12,8,32
	.member	_btLsr,160,12,8,32
	.member	_btMsr_U,192,12,8,32
	.member	_btScr,224,12,8,32
	.member	_btSp,256,60,8,256,,8
	.eos
	.sym	_XR16L784ST,0,8,13,512,.fake67
	.sym	_PXR16L784ST,0,24,13,32,.fake67
	.stag	.fake71,2048
	.member	_xr16Reg,0,56,8,2048,.fake67,4
	.eos
	.sym	_XR16L784BDY,0,8,13,2048,.fake71
	.sym	_PXR16L784BDY,0,24,13,32,.fake71
	.file	"xr16l784.c"

	.sect	".cinit"
	.field  	1,32
	.field  	_m_ucXr16l784TxBuf1+0,32
	.field  	16766975,32		; _m_ucXr16l784TxBuf1 @ 0

	.sect	".text"

	.global	_m_ucXr16l784TxBuf1
	.bss	_m_ucXr16l784TxBuf1,1
	.sym	_m_ucXr16l784TxBuf1,_m_ucXr16l784TxBuf1,28,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen1+0,32
	.field  	0,32		; _m_nXr16l784TxLen1 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen1
	.bss	_m_nXr16l784TxLen1,1
	.sym	_m_nXr16l784TxLen1,_m_nXr16l784TxLen1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen1Temp+0,32
	.field  	0,32		; _m_nXr16l784TxLen1Temp @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen1Temp
	.bss	_m_nXr16l784TxLen1Temp,1
	.sym	_m_nXr16l784TxLen1Temp,_m_nXr16l784TxLen1Temp,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxPos1+0,32
	.field  	0,32		; _m_nXr16l784TxPos1 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxPos1
	.bss	_m_nXr16l784TxPos1,1
	.sym	_m_nXr16l784TxPos1,_m_nXr16l784TxPos1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxRear1+0,32
	.field  	1,32		; _m_nXr16l784TxRear1 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxRear1
	.bss	_m_nXr16l784TxRear1,1
	.sym	_m_nXr16l784TxRear1,_m_nXr16l784TxRear1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxFront1+0,32
	.field  	0,32		; _m_nXr16l784TxFront1 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxFront1
	.bss	_m_nXr16l784TxFront1,1
	.sym	_m_nXr16l784TxFront1,_m_nXr16l784TxFront1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxLen1+0,32
	.field  	0,32		; _m_nXr16l784RxLen1 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxLen1
	.bss	_m_nXr16l784RxLen1,1
	.sym	_m_nXr16l784RxLen1,_m_nXr16l784RxLen1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxRear1+0,32
	.field  	1,32		; _m_nXr16l784RxRear1 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxRear1
	.bss	_m_nXr16l784RxRear1,1
	.sym	_m_nXr16l784RxRear1,_m_nXr16l784RxRear1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxFront1+0,32
	.field  	0,32		; _m_nXr16l784RxFront1 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxFront1
	.bss	_m_nXr16l784RxFront1,1
	.sym	_m_nXr16l784RxFront1,_m_nXr16l784RxFront1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxEnableDly1+0,32
	.field  	0,32		; _m_nXr16l784TxEnableDly1 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxEnableDly1
	.bss	_m_nXr16l784TxEnableDly1,1
	.sym	_m_nXr16l784TxEnableDly1,_m_nXr16l784TxEnableDly1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxStartEnableDly1+0,32
	.field  	0,32		; _m_nXr16l784TxStartEnableDly1 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxStartEnableDly1
	.bss	_m_nXr16l784TxStartEnableDly1,1
	.sym	_m_nXr16l784TxStartEnableDly1,_m_nXr16l784TxStartEnableDly1,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen2+0,32
	.field  	0,32		; _m_nXr16l784TxLen2 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen2
	.bss	_m_nXr16l784TxLen2,1
	.sym	_m_nXr16l784TxLen2,_m_nXr16l784TxLen2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen2Temp+0,32
	.field  	0,32		; _m_nXr16l784TxLen2Temp @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen2Temp
	.bss	_m_nXr16l784TxLen2Temp,1
	.sym	_m_nXr16l784TxLen2Temp,_m_nXr16l784TxLen2Temp,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxPos2+0,32
	.field  	0,32		; _m_nXr16l784TxPos2 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxPos2
	.bss	_m_nXr16l784TxPos2,1
	.sym	_m_nXr16l784TxPos2,_m_nXr16l784TxPos2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxRear2+0,32
	.field  	1,32		; _m_nXr16l784TxRear2 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxRear2
	.bss	_m_nXr16l784TxRear2,1
	.sym	_m_nXr16l784TxRear2,_m_nXr16l784TxRear2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxFront2+0,32
	.field  	0,32		; _m_nXr16l784TxFront2 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxFront2
	.bss	_m_nXr16l784TxFront2,1
	.sym	_m_nXr16l784TxFront2,_m_nXr16l784TxFront2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxLen2+0,32
	.field  	0,32		; _m_nXr16l784RxLen2 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxLen2
	.bss	_m_nXr16l784RxLen2,1
	.sym	_m_nXr16l784RxLen2,_m_nXr16l784RxLen2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxRear2+0,32
	.field  	1,32		; _m_nXr16l784RxRear2 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxRear2
	.bss	_m_nXr16l784RxRear2,1
	.sym	_m_nXr16l784RxRear2,_m_nXr16l784RxRear2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxFront2+0,32
	.field  	0,32		; _m_nXr16l784RxFront2 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxFront2
	.bss	_m_nXr16l784RxFront2,1
	.sym	_m_nXr16l784RxFront2,_m_nXr16l784RxFront2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxEnableDly2+0,32
	.field  	0,32		; _m_nXr16l784TxEnableDly2 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxEnableDly2
	.bss	_m_nXr16l784TxEnableDly2,1
	.sym	_m_nXr16l784TxEnableDly2,_m_nXr16l784TxEnableDly2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxStartEnableDly2+0,32
	.field  	0,32		; _m_nXr16l784TxStartEnableDly2 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxStartEnableDly2
	.bss	_m_nXr16l784TxStartEnableDly2,1
	.sym	_m_nXr16l784TxStartEnableDly2,_m_nXr16l784TxStartEnableDly2,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen3+0,32
	.field  	0,32		; _m_nXr16l784TxLen3 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen3
	.bss	_m_nXr16l784TxLen3,1
	.sym	_m_nXr16l784TxLen3,_m_nXr16l784TxLen3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen3Temp+0,32
	.field  	0,32		; _m_nXr16l784TxLen3Temp @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen3Temp
	.bss	_m_nXr16l784TxLen3Temp,1
	.sym	_m_nXr16l784TxLen3Temp,_m_nXr16l784TxLen3Temp,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxPos3+0,32
	.field  	0,32		; _m_nXr16l784TxPos3 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxPos3
	.bss	_m_nXr16l784TxPos3,1
	.sym	_m_nXr16l784TxPos3,_m_nXr16l784TxPos3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxRear3+0,32
	.field  	1,32		; _m_nXr16l784TxRear3 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxRear3
	.bss	_m_nXr16l784TxRear3,1
	.sym	_m_nXr16l784TxRear3,_m_nXr16l784TxRear3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxFront3+0,32
	.field  	0,32		; _m_nXr16l784TxFront3 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxFront3
	.bss	_m_nXr16l784TxFront3,1
	.sym	_m_nXr16l784TxFront3,_m_nXr16l784TxFront3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxLen3+0,32
	.field  	0,32		; _m_nXr16l784RxLen3 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxLen3
	.bss	_m_nXr16l784RxLen3,1
	.sym	_m_nXr16l784RxLen3,_m_nXr16l784RxLen3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxRear3+0,32
	.field  	1,32		; _m_nXr16l784RxRear3 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxRear3
	.bss	_m_nXr16l784RxRear3,1
	.sym	_m_nXr16l784RxRear3,_m_nXr16l784RxRear3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxFront3+0,32
	.field  	0,32		; _m_nXr16l784RxFront3 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxFront3
	.bss	_m_nXr16l784RxFront3,1
	.sym	_m_nXr16l784RxFront3,_m_nXr16l784RxFront3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxEnableDly3+0,32
	.field  	0,32		; _m_nXr16l784TxEnableDly3 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxEnableDly3
	.bss	_m_nXr16l784TxEnableDly3,1
	.sym	_m_nXr16l784TxEnableDly3,_m_nXr16l784TxEnableDly3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxStartEnableDly3+0,32
	.field  	0,32		; _m_nXr16l784TxStartEnableDly3 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxStartEnableDly3
	.bss	_m_nXr16l784TxStartEnableDly3,1
	.sym	_m_nXr16l784TxStartEnableDly3,_m_nXr16l784TxStartEnableDly3,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen4+0,32
	.field  	0,32		; _m_nXr16l784TxLen4 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen4
	.bss	_m_nXr16l784TxLen4,1
	.sym	_m_nXr16l784TxLen4,_m_nXr16l784TxLen4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxLen4Temp+0,32
	.field  	0,32		; _m_nXr16l784TxLen4Temp @ 0

	.sect	".text"

	.global	_m_nXr16l784TxLen4Temp
	.bss	_m_nXr16l784TxLen4Temp,1
	.sym	_m_nXr16l784TxLen4Temp,_m_nXr16l784TxLen4Temp,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxPos4+0,32
	.field  	0,32		; _m_nXr16l784TxPos4 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxPos4
	.bss	_m_nXr16l784TxPos4,1
	.sym	_m_nXr16l784TxPos4,_m_nXr16l784TxPos4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxRear4+0,32
	.field  	1,32		; _m_nXr16l784TxRear4 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxRear4
	.bss	_m_nXr16l784TxRear4,1
	.sym	_m_nXr16l784TxRear4,_m_nXr16l784TxRear4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxFront4+0,32
	.field  	0,32		; _m_nXr16l784TxFront4 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxFront4
	.bss	_m_nXr16l784TxFront4,1
	.sym	_m_nXr16l784TxFront4,_m_nXr16l784TxFront4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxLen4+0,32
	.field  	0,32		; _m_nXr16l784RxLen4 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxLen4
	.bss	_m_nXr16l784RxLen4,1
	.sym	_m_nXr16l784RxLen4,_m_nXr16l784RxLen4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxRear4+0,32
	.field  	1,32		; _m_nXr16l784RxRear4 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxRear4
	.bss	_m_nXr16l784RxRear4,1
	.sym	_m_nXr16l784RxRear4,_m_nXr16l784RxRear4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784RxFront4+0,32
	.field  	0,32		; _m_nXr16l784RxFront4 @ 0

	.sect	".text"

	.global	_m_nXr16l784RxFront4
	.bss	_m_nXr16l784RxFront4,1
	.sym	_m_nXr16l784RxFront4,_m_nXr16l784RxFront4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxEnableDly4+0,32
	.field  	0,32		; _m_nXr16l784TxEnableDly4 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxEnableDly4
	.bss	_m_nXr16l784TxEnableDly4,1
	.sym	_m_nXr16l784TxEnableDly4,_m_nXr16l784TxEnableDly4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_m_nXr16l784TxStartEnableDly4+0,32
	.field  	0,32		; _m_nXr16l784TxStartEnableDly4 @ 0

	.sect	".text"

	.global	_m_nXr16l784TxStartEnableDly4
	.bss	_m_nXr16l784TxStartEnableDly4,1
	.sym	_m_nXr16l784TxStartEnableDly4,_m_nXr16l784TxStartEnableDly4,4,2,32

	.sect	".cinit"
	.field  	1,32
	.field  	_pXr16Reg+0,32
	.field  	9437184,32		; _pXr16Reg @ 0

	.sect	".text"

	.global	_pXr16Reg
	.bss	_pXr16Reg,1
	.sym	_pXr16Reg,_pXr16Reg,24,2,32,.fake71
	.sect	 ".text"

	.global	_xr16l784_Init
	.sym	_xr16l784_Init,_xr16l784_Init,32,2,0
	.func	68
;******************************************************************************
;* FUNCTION NAME: _xr16l784_Init                                              *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,ir0                                    *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 5 Parm + 1 Auto + 0 SOE = 8 words          *
;******************************************************************************
_xr16l784_Init:
	.sym	_nChl,-2,4,9,32
	.sym	_nBps,-3,4,9,32
	.sym	_nDataBit,-4,4,9,32
	.sym	_nParityBit,-5,4,9,32
	.sym	_nStopBit,-6,4,9,32
	.sym	_nBpsBuf,1,13,1,32
	.line	1
;----------------------------------------------------------------------
;  68 | void xr16l784_Init(int nChl,int nBps,int nDataBit,int nParityBit,int nS
;     | topBit)                                                                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
;  70 | USHORT nBpsBuf = XR16L784_EXCLK/16/nBps;                               
;----------------------------------------------------------------------
        ldiu      @CL1,r0
        ldiu      *-fp(3),r1
        call      DIV_I30
                                        ; Call Occurs
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
;  72 | pXr16Reg->xr16Reg[nChl].btLcr = 0x83; // Divisor Latch Bit Set : DLAB =
;     |  1                                                                     
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ash       4,ar0
        addi      @_pXr16Reg+0,ar0      ; Unsigned
        ldiu      131,r0
        sti       r0,*+ar0(3)
	.line	6
;----------------------------------------------------------------------
;  73 | pXr16Reg->xr16Reg[nChl].CREG2.btDlm = WORD_H(nBpsBuf);  // Ex MHz / 16
;     | / bps                                                                  
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ash       4,ar0
        ldiu      *+fp(1),r0
        addi      @_pXr16Reg+0,ar0      ; Unsigned
        lsh       -8,r0
        and       255,r0
        sti       r0,*+ar0(1)
	.line	7
;----------------------------------------------------------------------
;  74 | pXr16Reg->xr16Reg[nChl].CREG1.btDll = WORD_L(nBpsBuf);                 
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ir0
        ldiu      *-fp(2),ar0
        ldiu      255,r0
        ash       4,ar0
        and       *+fp(1),r0
        sti       r0,*+ar0(ir0)
	.line	8
;----------------------------------------------------------------------
;  75 | pXr16Reg->xr16Reg[nChl].btLcr = (nDataBit&0x03) | (nParityBit&0x38) | (
;     | nStopBit&0x04); // Divisor Latch Bit Clear (Data:8bit, 1Stop, Even Pari
;     | ty)                                                                    
;----------------------------------------------------------------------
        ldiu      3,r2
        ldiu      4,r1
        ldiu      56,r0
        and       *-fp(5),r0
        ldiu      *-fp(2),ar0
        and       *-fp(4),r2
        ash       4,ar0
        or3       r2,r0,r0
        and       *-fp(6),r1
        addi      @_pXr16Reg+0,ar0      ; Unsigned
        or3       r0,r1,r0
        sti       r0,*+ar0(3)
	.line	9
;----------------------------------------------------------------------
;  76 | pXr16Reg->xr16Reg[nChl].CREG3.btFcr = 0x0;                             
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ash       4,ar0
        addi      @_pXr16Reg+0,ar0      ; Unsigned
        ldiu      0,r0
        sti       r0,*+ar0(2)
	.line	10
;----------------------------------------------------------------------
;  77 | pXr16Reg->xr16Reg[nChl].CREG2.btIer = 3;        // RX,Line INT : enable
;     | , TXD : enable                                                         
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ash       4,ar0
        addi      @_pXr16Reg+0,ar0      ; Unsigned
        ldiu      3,r0
        sti       r0,*+ar0(1)
	.line	11
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      3,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	78,000000000h,1


	.sect	 ".text"

	.global	_xr16l784_Rts
	.sym	_xr16l784_Rts,_xr16l784_Rts,32,2,0
	.func	84
;******************************************************************************
;* FUNCTION NAME: _xr16l784_Rts                                               *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,ar0,st                                           *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 1 Auto + 0 SOE = 5 words          *
;******************************************************************************
_xr16l784_Rts:
	.sym	_nChl,-2,4,9,32
	.sym	_nHl,-3,4,9,32
	.sym	_nBuf,1,12,1,32
	.line	1
;----------------------------------------------------------------------
;  84 | void xr16l784_Rts(int nChl,BOOL nHl)                                   
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
;  86 | UCHAR nBuf = 0x00;                                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
;  88 | nBuf = pXr16Reg->xr16Reg[nChl].btMcr&0xfd;                             
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ash       4,ar0
        addi      @_pXr16Reg+0,ar0      ; Unsigned
        ldiu      253,r0
        and       *+ar0(4),r0
        sti       r0,*+fp(1)
	.line	7
;----------------------------------------------------------------------
;  90 | nBuf |= nHl == XR16L784_RTS_H ? 0x00 : 0x02;                           
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        cmpi      1,r0
        bne       L6
;*      Branch Occurs to L6 
        bud       L7
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L7 
L6:        
        ldiu      2,r0
L7:        
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	8
;----------------------------------------------------------------------
;  91 | pXr16Reg->xr16Reg[nChl].btMcr = nBuf;                                  
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ash       4,ar0
        addi      @_pXr16Reg+0,ar0      ; Unsigned
        sti       r0,*+ar0(4)
	.line	9
        ldiu      *-fp(1),ar0
        ldiu      *fp,fp
        subi      3,sp
        bu        ar0
;*      Branch Occurs to ar0 
	.endfunc	92,000000000h,1


	.sect	 ".text"

	.global	_xr16l784_RtsDelayStartSend
	.sym	_xr16l784_RtsDelayStartSend,_xr16l784_RtsDelayStartSend,32,2,0
	.func	98
;******************************************************************************
;* FUNCTION NAME: _xr16l784_RtsDelayStartSend                                 *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,fp,sp,st                                      *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 4 Parm + 0 Auto + 0 SOE = 6 words          *
;******************************************************************************
_xr16l784_RtsDelayStartSend:
	.sym	_nChl,-2,4,9,32
	.sym	_pBuf,-3,28,9,32
	.sym	_nLen,-4,4,9,32
	.sym	_nTxStartEnableDly,-5,4,9,32
	.line	1
;----------------------------------------------------------------------
;  98 | void xr16l784_RtsDelayStartSend(int nChl,UCHAR *pBuf,int nLen,int nTxSt
;     | artEnableDly)                                                          
;----------------------------------------------------------------------
	.line	2
;----------------------------------------------------------------------
; 100 | switch(nChl)                                                           
; 102 | case XR16L784_1CHL:                                                    
; 103 |         //m_nXr16l784TxPos1 = 0;                                       
; 104 |         //m_nXr16l784TxLen1Temp = nLen;                                
; 105 |         //memcpy(m_ucXr16l784TxBuf1Temp,pBuf,nLen);                    
; 106 |         //m_nXr16l784TxStartEnableDly1 = nTxStartEnableDly;            
; 107 |         //XR16L784_TXEN(XR16L784_1CHL);                                
;----------------------------------------------------------------------
        bud       L16
        push      fp
        ldiu      sp,fp
	nop
;*      Branch Occurs to L16 
	.line	11
;----------------------------------------------------------------------
; 108 | break;                                                                 
; 109 | case XR16L784_2CHL:                                                    
; 110 | //m_nXr16l784TxPos2 = 0;                                               
;----------------------------------------------------------------------
L12:        
	.line	14
;----------------------------------------------------------------------
; 111 | m_nXr16l784TxLen2Temp = nLen;                                          
;----------------------------------------------------------------------
        ldiu      *-fp(4),r0
        sti       r0,@_m_nXr16l784TxLen2Temp+0
	.line	15
;----------------------------------------------------------------------
; 112 | memcpy(m_ucXr16l784TxBuf2Temp,pBuf,nLen);                              
;----------------------------------------------------------------------
        ldiu      @CL2,r1
        ldiu      *-fp(4),r0
        push      r0
        ldiu      *-fp(3),r0
        push      r0
        push      r1
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	16
;----------------------------------------------------------------------
; 113 | m_nXr16l784TxStartEnableDly2 = nTxStartEnableDly;                      
;----------------------------------------------------------------------
        ldiu      *-fp(5),r0
        sti       r0,@_m_nXr16l784TxStartEnableDly2+0
	.line	17
;----------------------------------------------------------------------
; 114 | XR16L784_TXEN(XR16L784_2CHL);                                          
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      1,r1
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
	.line	18
;----------------------------------------------------------------------
; 115 | break;                                                                 
; 116 | case XR16L784_3CHL:                                                    
; 117 | //m_nXr16l784TxPos3 = 0;                                               
;----------------------------------------------------------------------
        bu        L20
;*      Branch Occurs to L20 
L13:        
	.line	21
;----------------------------------------------------------------------
; 118 | m_nXr16l784TxLen3Temp = nLen;                                          
;----------------------------------------------------------------------
        ldiu      *-fp(4),r0
        sti       r0,@_m_nXr16l784TxLen3Temp+0
	.line	22
;----------------------------------------------------------------------
; 119 | memcpy(m_ucXr16l784TxBuf3Temp,pBuf,nLen);                              
;----------------------------------------------------------------------
        ldiu      @CL3,r1
        ldiu      *-fp(4),r0
        push      r0
        ldiu      *-fp(3),r0
        push      r0
        push      r1
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	23
;----------------------------------------------------------------------
; 120 | m_nXr16l784TxStartEnableDly3 = nTxStartEnableDly;                      
;----------------------------------------------------------------------
        ldiu      *-fp(5),r0
        sti       r0,@_m_nXr16l784TxStartEnableDly3+0
	.line	24
;----------------------------------------------------------------------
; 121 | XR16L784_TXEN(XR16L784_3CHL);                                          
;----------------------------------------------------------------------
        ldiu      2,r0
        ldiu      1,r1
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
	.line	25
;----------------------------------------------------------------------
; 122 | break;                                                                 
; 123 | case XR16L784_4CHL:                                                    
; 124 | //m_nXr16l784TxPos4 = 0;                                               
;----------------------------------------------------------------------
        bu        L20
;*      Branch Occurs to L20 
L14:        
	.line	28
;----------------------------------------------------------------------
; 125 | m_nXr16l784TxLen4Temp = nLen;                                          
;----------------------------------------------------------------------
        ldiu      *-fp(4),r0
        sti       r0,@_m_nXr16l784TxLen4Temp+0
	.line	29
;----------------------------------------------------------------------
; 126 | memcpy(m_ucXr16l784TxBuf4Temp,pBuf,nLen);                              
;----------------------------------------------------------------------
        ldiu      @CL4,r1
        ldiu      *-fp(4),r0
        push      r0
        ldiu      *-fp(3),r0
        push      r0
        push      r1
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	30
;----------------------------------------------------------------------
; 127 | m_nXr16l784TxStartEnableDly4 = nTxStartEnableDly;                      
;----------------------------------------------------------------------
        ldiu      *-fp(5),r0
        sti       r0,@_m_nXr16l784TxStartEnableDly4+0
	.line	31
;----------------------------------------------------------------------
; 128 | XR16L784_TXEN(XR16L784_4CHL);                                          
;----------------------------------------------------------------------
        ldiu      3,r0
        ldiu      1,r1
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
	.line	32
;----------------------------------------------------------------------
; 129 | break;                                                                 
;----------------------------------------------------------------------
        bu        L20
;*      Branch Occurs to L20 
	.line	3
L16:        
        ldi       *-fp(2),r0
        beq       L20
;*      Branch Occurs to L20 
        cmpi      1,r0
        beq       L12
;*      Branch Occurs to L12 
        cmpi      2,r0
        beq       L13
;*      Branch Occurs to L13 
        cmpi      3,r0
        beq       L14
;*      Branch Occurs to L14 
L20:        
	.line	34
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	131,000000000h,0


	.sect	 ".text"

	.global	_xr16l784_Send
	.sym	_xr16l784_Send,_xr16l784_Send,32,2,0
	.func	137
;******************************************************************************
;* FUNCTION NAME: _xr16l784_Send                                              *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,st                                *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 3 Parm + 2 Auto + 0 SOE = 7 words          *
;******************************************************************************
_xr16l784_Send:
	.sym	_nChl,-2,4,9,32
	.sym	_pTxBuf,-3,28,9,32
	.sym	_nLen,-4,4,9,32
	.sym	_i,1,4,1,32
	.sym	_k,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 137 | void xr16l784_Send(int nChl,UCHAR *pTxBuf,int nLen)                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 139 | int i;                                                                 
; 140 | int k;                                                                 
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 142 | if(!nLen) return;                                                      
; 144 | switch(nChl)                                                           
; 146 | case XR16L784_1CHL:                                                    
;----------------------------------------------------------------------
        ldi       *-fp(4),r0
        beq       L69
;*      Branch Occurs to L69 
        bu        L65
;*      Branch Occurs to L65 
L24:        
	.line	11
;----------------------------------------------------------------------
; 147 | nLen = MIN(XR16L784_TXBUF_1CH_MAX,nLen);                               
;----------------------------------------------------------------------
        ldiu      9500,r0
        cmpi      *-fp(4),r0
        bge       L26
;*      Branch Occurs to L26 
        bu        L27
;*      Branch Occurs to L27 
L26:        
        ldiu      *-fp(4),r0
L27:        
        sti       r0,*-fp(4)
	.line	13
;----------------------------------------------------------------------
; 149 | if(((m_nXr16l784TxFront1 + 1) % XR16L784_TXBUF_1CH_MAX) == m_nXr16l784T
;     | xRear1)                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxFront1+0,r0
        ldiu      9500,r1
        call      MOD_I30
                                        ; Call Occurs
        cmpi      @_m_nXr16l784TxRear1+0,r0
        bne       L29
;*      Branch Occurs to L29 
	.line	15
;----------------------------------------------------------------------
; 151 | pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar1
        ldiu      *-fp(2),ar0
        ldiu      @_pXr16Reg+0,ir0
        ldiu      *ar1++(1),r0
        ash       4,ar0
        sti       ar1,*-fp(3)
        sti       r0,*+ar0(ir0)
	.line	16
;----------------------------------------------------------------------
; 152 | nLen--;                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(4),r0
        sti       r0,*-fp(4)
L29:        
	.line	19
;----------------------------------------------------------------------
; 155 | for(k=0;k<nLen;k++)                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        bge       L69
;*      Branch Occurs to L69 
L30:        
	.line	21
;----------------------------------------------------------------------
; 157 | i = (m_nXr16l784TxRear1 + 1) % XR16L784_TXBUF_1CH_MAX;                 
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxRear1+0,r0
        ldiu      9500,r1
        call      MOD_I30
                                        ; Call Occurs
        sti       r0,*+fp(1)
	.line	22
;----------------------------------------------------------------------
; 158 | if(m_nXr16l784TxFront1 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxFront1+0,r0
        cmpi      *+fp(1),r0
        beq       L32
;*      Branch Occurs to L32 
	.line	24
;----------------------------------------------------------------------
; 160 | m_ucXr16l784TxBuf1[m_nXr16l784TxRear1] = *pTxBuf++;                    
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      @_m_ucXr16l784TxBuf1+0,ir0
        ldiu      @_m_nXr16l784TxRear1+0,ar1
        ldiu      *ar0++(1),r0
        sti       ar0,*-fp(3)
        sti       r0,*+ar1(ir0)
	.line	25
;----------------------------------------------------------------------
; 161 | m_nXr16l784TxRear1 = i;                                                
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxRear1+0
L32:        
	.line	19
        ldiu      1,r0
        addi      *+fp(2),r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        blt       L30
;*      Branch Occurs to L30 
	.line	28
;----------------------------------------------------------------------
; 164 | break;                                                                 
; 166 | case XR16L784_2CHL:                                                    
;----------------------------------------------------------------------
        bu        L69
;*      Branch Occurs to L69 
L34:        
	.line	31
;----------------------------------------------------------------------
; 167 | nLen = MIN(XR16L784_BUF_2CH_MAX,nLen);                                 
;----------------------------------------------------------------------
        ldiu      512,r0
        cmpi      *-fp(4),r0
        bge       L36
;*      Branch Occurs to L36 
        bu        L37
;*      Branch Occurs to L37 
L36:        
        ldiu      *-fp(4),r0
L37:        
        sti       r0,*-fp(4)
	.line	33
;----------------------------------------------------------------------
; 169 | if(((m_nXr16l784TxFront2 + 1) % XR16L784_BUF_2CH_MAX) == m_nXr16l784TxR
;     | ear2)                                                                  
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxFront2+0,r0
        ldiu      r0,r1
        ash       -8,r1
        lsh       @CL5,r1
        addi3     r1,r0,r1
        andn      511,r1
        subri     r0,r1
        cmpi      @_m_nXr16l784TxRear2+0,r1
        bne       L39
;*      Branch Occurs to L39 
	.line	35
;----------------------------------------------------------------------
; 171 | pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar1
        ldiu      *-fp(2),ar0
        ldiu      @_pXr16Reg+0,ir0
        ldiu      *ar1++(1),r0
        ash       4,ar0
        sti       ar1,*-fp(3)
        sti       r0,*+ar0(ir0)
	.line	36
;----------------------------------------------------------------------
; 172 | nLen--;                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(4),r0
        sti       r0,*-fp(4)
L39:        
	.line	39
;----------------------------------------------------------------------
; 175 | for(k=0;k<nLen;k++)                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        bge       L69
;*      Branch Occurs to L69 
L40:        
	.line	41
;----------------------------------------------------------------------
; 177 | i = (m_nXr16l784TxRear2 + 1) % XR16L784_BUF_2CH_MAX;                   
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxRear2+0,r0
        ldiu      r0,r1
        ash       -8,r1
        lsh       @CL5,r1
        addi3     r1,r0,r1
        andn      511,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	42
;----------------------------------------------------------------------
; 178 | if(m_nXr16l784TxFront2 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxFront2+0,r0
        cmpi      *+fp(1),r0
        beq       L42
;*      Branch Occurs to L42 
	.line	44
;----------------------------------------------------------------------
; 180 | m_ucXr16l784TxBuf2[m_nXr16l784TxRear2] = *pTxBuf++;                    
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      @_m_nXr16l784TxRear2+0,ir0
        ldiu      @CL6,ar1
        ldiu      *ar0++(1),r0
        sti       ar0,*-fp(3)
        sti       r0,*+ar1(ir0)
	.line	45
;----------------------------------------------------------------------
; 181 | m_nXr16l784TxRear2 = i;                                                
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxRear2+0
L42:        
	.line	39
        ldiu      1,r0
        addi      *+fp(2),r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        blt       L40
;*      Branch Occurs to L40 
	.line	48
;----------------------------------------------------------------------
; 184 | break;                                                                 
; 185 | case XR16L784_3CHL:                                                    
;----------------------------------------------------------------------
        bu        L69
;*      Branch Occurs to L69 
L44:        
	.line	50
;----------------------------------------------------------------------
; 186 | nLen = MIN(XR16L784_BUF_3CH_MAX,nLen);                                 
;----------------------------------------------------------------------
        ldiu      256,r0
        cmpi      *-fp(4),r0
        bge       L46
;*      Branch Occurs to L46 
        bu        L47
;*      Branch Occurs to L47 
L46:        
        ldiu      *-fp(4),r0
L47:        
        sti       r0,*-fp(4)
	.line	52
;----------------------------------------------------------------------
; 188 | if(((m_nXr16l784TxFront3 + 1) % XR16L784_BUF_3CH_MAX) == m_nXr16l784TxR
;     | ear3)                                                                  
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxFront3+0,r0
        ldiu      r0,r1
        ash       -7,r1
        lsh       @CL7,r1
        addi3     r1,r0,r1
        andn      255,r1
        subri     r0,r1
        cmpi      @_m_nXr16l784TxRear3+0,r1
        bne       L49
;*      Branch Occurs to L49 
	.line	54
;----------------------------------------------------------------------
; 190 | pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar1
        ldiu      *-fp(2),ar0
        ldiu      @_pXr16Reg+0,ir0
        ldiu      *ar1++(1),r0
        ash       4,ar0
        sti       ar1,*-fp(3)
        sti       r0,*+ar0(ir0)
	.line	55
;----------------------------------------------------------------------
; 191 | nLen--;                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(4),r0
        sti       r0,*-fp(4)
L49:        
	.line	58
;----------------------------------------------------------------------
; 194 | for(k=0;k<nLen;k++)                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        bge       L69
;*      Branch Occurs to L69 
L50:        
	.line	60
;----------------------------------------------------------------------
; 196 | i = (m_nXr16l784TxRear3 + 1) % XR16L784_BUF_3CH_MAX;                   
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxRear3+0,r0
        ldiu      r0,r1
        ash       -7,r1
        lsh       @CL7,r1
        addi3     r1,r0,r1
        andn      255,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	61
;----------------------------------------------------------------------
; 197 | if(m_nXr16l784TxFront3 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxFront3+0,r0
        cmpi      *+fp(1),r0
        beq       L52
;*      Branch Occurs to L52 
	.line	63
;----------------------------------------------------------------------
; 199 | m_ucXr16l784TxBuf3[m_nXr16l784TxRear3] = *pTxBuf++;                    
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      @_m_nXr16l784TxRear3+0,ir0
        ldiu      @CL8,ar1
        ldiu      *ar0++(1),r0
        sti       ar0,*-fp(3)
        sti       r0,*+ar1(ir0)
	.line	64
;----------------------------------------------------------------------
; 200 | m_nXr16l784TxRear3 = i;                                                
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxRear3+0
L52:        
	.line	58
        ldiu      1,r0
        addi      *+fp(2),r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        blt       L50
;*      Branch Occurs to L50 
	.line	67
;----------------------------------------------------------------------
; 203 | break;                                                                 
; 204 | case XR16L784_4CHL:                                                    
;----------------------------------------------------------------------
        bu        L69
;*      Branch Occurs to L69 
L54:        
	.line	69
;----------------------------------------------------------------------
; 205 | nLen = MIN(XR16L784_BUF_4CH_MAX,nLen);                                 
;----------------------------------------------------------------------
        ldiu      8,r0
        cmpi      *-fp(4),r0
        bge       L56
;*      Branch Occurs to L56 
        bu        L57
;*      Branch Occurs to L57 
L56:        
        ldiu      *-fp(4),r0
L57:        
        sti       r0,*-fp(4)
	.line	71
;----------------------------------------------------------------------
; 207 | if(((m_nXr16l784TxFront4 + 1) % XR16L784_BUF_4CH_MAX) == m_nXr16l784TxR
;     | ear4)                                                                  
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxFront4+0,r0
        ldiu      r0,r1
        ash       -2,r1
        lsh       @CL9,r1
        addi3     r1,r0,r1
        andn      7,r1
        subri     r0,r1
        cmpi      @_m_nXr16l784TxRear4+0,r1
        bne       L59
;*      Branch Occurs to L59 
	.line	73
;----------------------------------------------------------------------
; 209 | pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;                       
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      *-fp(2),ar1
        ldiu      @_pXr16Reg+0,ir0
        ldiu      *ar0++(1),r0
        ash       4,ar1
        sti       ar0,*-fp(3)
        sti       r0,*+ar1(ir0)
	.line	74
;----------------------------------------------------------------------
; 210 | nLen--;                                                                
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(4),r0
        sti       r0,*-fp(4)
L59:        
	.line	77
;----------------------------------------------------------------------
; 213 | for(k=0;k<nLen;k++)                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        bge       L69
;*      Branch Occurs to L69 
L60:        
	.line	79
;----------------------------------------------------------------------
; 215 | i = (m_nXr16l784TxRear4 + 1) % XR16L784_BUF_4CH_MAX;                   
;----------------------------------------------------------------------
        ldiu      1,r1
        addi      @_m_nXr16l784TxRear4+0,r1
        ldiu      r1,r0
        ash       -2,r0
        lsh       @CL9,r0
        addi3     r0,r1,r0
        andn      7,r0
        subri     r1,r0
        sti       r0,*+fp(1)
	.line	80
;----------------------------------------------------------------------
; 216 | if(m_nXr16l784TxFront4 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxFront4+0,r0
        cmpi      *+fp(1),r0
        beq       L62
;*      Branch Occurs to L62 
	.line	82
;----------------------------------------------------------------------
; 218 | m_ucXr16l784TxBuf4[m_nXr16l784TxRear4] = *pTxBuf++;                    
;----------------------------------------------------------------------
        ldiu      *-fp(3),ar0
        ldiu      @_m_nXr16l784TxRear4+0,ir0
        ldiu      @CL10,ar1
        ldiu      *ar0++(1),r0
        sti       ar0,*-fp(3)
        sti       r0,*+ar1(ir0)
	.line	83
;----------------------------------------------------------------------
; 219 | m_nXr16l784TxRear4 = i;                                                
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxRear4+0
L62:        
	.line	77
        ldiu      1,r0
        addi      *+fp(2),r0
        sti       r0,*+fp(2)
        cmpi      *-fp(4),r0
        blt       L60
;*      Branch Occurs to L60 
	.line	86
;----------------------------------------------------------------------
; 222 | break;                                                                 
;----------------------------------------------------------------------
        bu        L69
;*      Branch Occurs to L69 
L65:        
	.line	8
        ldi       *-fp(2),r0
        beq       L24
;*      Branch Occurs to L24 
        cmpi      1,r0
        beq       L34
;*      Branch Occurs to L34 
        cmpi      2,r0
        beq       L44
;*      Branch Occurs to L44 
        cmpi      3,r0
        beq       L54
;*      Branch Occurs to L54 
L69:        
	.line	88
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      4,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	224,000000000h,2


	.sect	 ".text"

	.global	_xr16l784_GetRxBuffer
	.sym	_xr16l784_GetRxBuffer,_xr16l784_GetRxBuffer,36,2,0
	.func	232
;******************************************************************************
;* FUNCTION NAME: _xr16l784_GetRxBuffer                                       *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,ir1,st                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 3 Parm + 6 Auto + 0 SOE = 11 words         *
;******************************************************************************
_xr16l784_GetRxBuffer:
	.sym	_nChl,-2,4,9,32
	.sym	_pBuf,-3,28,9,32
	.sym	_nRxBuffLen,-4,4,9,32
	.sym	_i,1,4,1,32
	.sym	_pRr,2,20,1,32
	.sym	_pFr,3,20,1,32
	.sym	_pRxBuf,4,28,1,32
	.sym	_nBufPos,5,4,1,32
	.sym	_nBufMax,6,4,1,32
	.line	1
;----------------------------------------------------------------------
; 232 | int xr16l784_GetRxBuffer(int nChl,UCHAR *pBuf,int nRxBuffLen)          
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      6,sp
	.line	2
;----------------------------------------------------------------------
; 234 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 235 | int *pRr = NULL;                                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 236 | int *pFr = NULL;                                                       
;----------------------------------------------------------------------
        sti       r0,*+fp(3)
	.line	6
;----------------------------------------------------------------------
; 237 | UCHAR *pRxBuf = NULL;                                                  
; 238 | int nBufPos;                                                           
;----------------------------------------------------------------------
        sti       r0,*+fp(4)
	.line	8
;----------------------------------------------------------------------
; 239 | int nBufMax = 0;                                                       
; 241 | switch(nChl)                                                           
; 243 | case XR16L784_1CHL:                                                    
;----------------------------------------------------------------------
        bud       L78
        sti       r0,*+fp(6)
	nop
	nop
;*      Branch Occurs to L78 
L72:        
	.line	13
;----------------------------------------------------------------------
; 244 | nBufMax = XR16L784_RXBUF_1CH_MAX;                                      
;----------------------------------------------------------------------
        ldiu      64,r0
        sti       r0,*+fp(6)
	.line	14
;----------------------------------------------------------------------
; 245 | pRr = &m_nXr16l784RxRear1;                                             
;----------------------------------------------------------------------
        ldiu      @CL11,r0
        sti       r0,*+fp(2)
	.line	15
;----------------------------------------------------------------------
; 246 | pFr = &m_nXr16l784RxFront1;                                            
;----------------------------------------------------------------------
        ldiu      @CL12,r0
        sti       r0,*+fp(3)
	.line	16
;----------------------------------------------------------------------
; 247 | pRxBuf = m_ucXr16l784RxBuf1;                                           
;----------------------------------------------------------------------
        ldiu      @CL13,r0
        sti       r0,*+fp(4)
	.line	17
;----------------------------------------------------------------------
; 248 | break;                                                                 
; 249 | case XR16L784_2CHL:                                                    
;----------------------------------------------------------------------
        bu        L83
;*      Branch Occurs to L83 
L73:        
	.line	19
;----------------------------------------------------------------------
; 250 | nBufMax = XR16L784_BUF_2CH_MAX;                                        
;----------------------------------------------------------------------
        ldiu      512,r0
        sti       r0,*+fp(6)
	.line	20
;----------------------------------------------------------------------
; 251 | pRr = &m_nXr16l784RxRear2;                                             
;----------------------------------------------------------------------
        ldiu      @CL14,r0
        sti       r0,*+fp(2)
	.line	21
;----------------------------------------------------------------------
; 252 | pFr = &m_nXr16l784RxFront2;                                            
;----------------------------------------------------------------------
        ldiu      @CL15,r0
        sti       r0,*+fp(3)
	.line	22
;----------------------------------------------------------------------
; 253 | pRxBuf = m_ucXr16l784RxBuf2;                                           
;----------------------------------------------------------------------
        ldiu      @CL16,r0
        sti       r0,*+fp(4)
	.line	23
;----------------------------------------------------------------------
; 254 | break;                                                                 
; 255 | case XR16L784_3CHL:                                                    
;----------------------------------------------------------------------
        bu        L83
;*      Branch Occurs to L83 
L74:        
	.line	25
;----------------------------------------------------------------------
; 256 | nBufMax = XR16L784_BUF_3CH_MAX;                                        
;----------------------------------------------------------------------
        ldiu      256,r0
        sti       r0,*+fp(6)
	.line	26
;----------------------------------------------------------------------
; 257 | pRr = &m_nXr16l784RxRear3;                                             
;----------------------------------------------------------------------
        ldiu      @CL17,r0
        sti       r0,*+fp(2)
	.line	27
;----------------------------------------------------------------------
; 258 | pFr = &m_nXr16l784RxFront3;                                            
;----------------------------------------------------------------------
        ldiu      @CL18,r0
        sti       r0,*+fp(3)
	.line	28
;----------------------------------------------------------------------
; 259 | pRxBuf = m_ucXr16l784RxBuf3;                                           
;----------------------------------------------------------------------
        ldiu      @CL19,r0
        sti       r0,*+fp(4)
	.line	29
;----------------------------------------------------------------------
; 260 | break;                                                                 
; 261 | case XR16L784_4CHL:                                                    
;----------------------------------------------------------------------
        bu        L83
;*      Branch Occurs to L83 
L75:        
	.line	31
;----------------------------------------------------------------------
; 262 | nBufMax = XR16L784_BUF_4CH_MAX;                                        
;----------------------------------------------------------------------
        ldiu      8,r0
        sti       r0,*+fp(6)
	.line	32
;----------------------------------------------------------------------
; 263 | pRr = &m_nXr16l784RxRear4;                                             
;----------------------------------------------------------------------
        ldiu      @CL20,r0
        sti       r0,*+fp(2)
	.line	33
;----------------------------------------------------------------------
; 264 | pFr = &m_nXr16l784RxFront4;                                            
;----------------------------------------------------------------------
        ldiu      @CL21,r0
        sti       r0,*+fp(3)
	.line	34
;----------------------------------------------------------------------
; 265 | pRxBuf = m_ucXr16l784RxBuf4;                                           
;----------------------------------------------------------------------
        ldiu      @CL22,r0
        sti       r0,*+fp(4)
	.line	35
;----------------------------------------------------------------------
; 266 | break;                                                                 
; 267 | default:                                                               
;----------------------------------------------------------------------
        bu        L83
;*      Branch Occurs to L83 
L76:        
	.line	37
;----------------------------------------------------------------------
; 268 | return 0;                                                              
;----------------------------------------------------------------------
        bud       L89
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L89 
	.line	10
L78:        
        ldi       *-fp(2),r0
        beq       L72
;*      Branch Occurs to L72 
        cmpi      1,r0
        beq       L73
;*      Branch Occurs to L73 
        cmpi      2,r0
        beq       L74
;*      Branch Occurs to L74 
        cmpi      3,r0
        beq       L75
;*      Branch Occurs to L75 
        bu        L76
;*      Branch Occurs to L76 
L83:        
	.line	40
;----------------------------------------------------------------------
; 271 | nBufPos = 0;                                                           
; 272 | while(1)                                                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(5)
L84:        
	.line	43
;----------------------------------------------------------------------
; 274 | i = (*pFr+1)%nBufMax;                                                  
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(3),ar0
        ldiu      *+fp(6),r1
        addi3     r0,*ar0,r0
        call      MOD_I30
                                        ; Call Occurs
        sti       r0,*+fp(1)
	.line	44
;----------------------------------------------------------------------
; 275 | if(i != *pRr) {pBuf[nBufPos++] = pRxBuf[i]; if(nBufPos >= nRxBuffLen) b
;     | reak;} else break;                                                     
;----------------------------------------------------------------------
        ldiu      *+fp(2),ar0
        cmpi3     *ar0,r0
        beq       L88
;*      Branch Occurs to L88 
        ldiu      r0,ar1
        ldiu      *+fp(4),ir0
        ldiu      *+fp(5),ar0
        ldiu      *-fp(3),ir1
        ldiu      1,r0
        ldiu      *+ar1(ir0),r1
        addi      ar0,r0
        sti       r0,*+fp(5)
        sti       r1,*+ar0(ir1)
        ldiu      *+fp(5),r0
        cmpi      *-fp(4),r0
        bge       L88
;*      Branch Occurs to L88 
        bud       L84
        ldiu      *+fp(3),ar0
        ldiu      *+fp(1),r0
        sti       r0,*ar0
;*      Branch Occurs to L84 
	.line	44
	.line	45
;----------------------------------------------------------------------
; 276 | *pFr = i;                                                              
;----------------------------------------------------------------------
	.line	46
L88:        
	.line	47
;----------------------------------------------------------------------
; 278 | return nBufPos;                                                        
;----------------------------------------------------------------------
        ldiu      *+fp(5),r0
L89:        
	.line	48
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      8,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	279,000000000h,6


	.sect	 ".text"

	.global	_xr16l784_GetRxBuffer1Ch
	.sym	_xr16l784_GetRxBuffer1Ch,_xr16l784_GetRxBuffer1Ch,36,2,0
	.func	281
;******************************************************************************
;* FUNCTION NAME: _xr16l784_GetRxBuffer1Ch                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,ir1,st                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 2 Auto + 0 SOE = 6 words          *
;******************************************************************************
_xr16l784_GetRxBuffer1Ch:
	.sym	_pBuf,-2,28,9,32
	.sym	_nRxBuffLen,-3,4,9,32
	.sym	_i,1,4,1,32
	.sym	_nBufPos,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 281 | int xr16l784_GetRxBuffer1Ch(UCHAR *pBuf,int nRxBuffLen)                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 283 | int i;                                                                 
; 284 | int nBufPos;                                                           
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 286 | nBufPos = 0;                                                           
; 287 | while(1)                                                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
L92:        
	.line	9
;----------------------------------------------------------------------
; 289 | i = (m_nXr16l784RxFront1+1)%XR16L784_RXBUF_1CH_MAX;                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxFront1+0,r0
        ldiu      r0,r1
        ash       -5,r1
        lsh       @CL23,r1
        addi3     r1,r0,r1
        andn      63,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 290 | if(i != m_nXr16l784RxRear1) {if(nBufPos >= nRxBuffLen) break; pBuf[nBuf
;     | Pos++] = m_ucXr16l784RxBuf1[i]; } else break;                          
;----------------------------------------------------------------------
        ldiu      r1,r0
        cmpi      @_m_nXr16l784RxRear1+0,r0
        beq       L97
;*      Branch Occurs to L97 
        ldiu      *+fp(2),r0
        cmpi      *-fp(3),r0
        bge       L97
;*      Branch Occurs to L97 
        ldiu      r0,ar0
        ldiu      r1,ir0
        ldiu      @CL13,ar1
        ldiu      *-fp(2),ir1
        ldiu      1,r0
        ldiu      *+ar1(ir0),r1
        bud       L96
        addi      ar0,r0
        sti       r0,*+fp(2)
        sti       r1,*+ar0(ir1)
;*      Branch Occurs to L96 
	.line	10
L96:        
	.line	11
;----------------------------------------------------------------------
; 291 | m_nXr16l784RxFront1 = i;                                               
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784RxFront1+0
	.line	12
        bu        L92
;*      Branch Occurs to L92 
L97:        
	.line	13
;----------------------------------------------------------------------
; 293 | return nBufPos;                                                        
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	14
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      4,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	294,000000000h,2


	.sect	 ".text"

	.global	_xr16l784_GetRxBuffer2Ch
	.sym	_xr16l784_GetRxBuffer2Ch,_xr16l784_GetRxBuffer2Ch,36,2,0
	.func	296
;******************************************************************************
;* FUNCTION NAME: _xr16l784_GetRxBuffer2Ch                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,ir1,st                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 2 Auto + 0 SOE = 6 words          *
;******************************************************************************
_xr16l784_GetRxBuffer2Ch:
	.sym	_pBuf,-2,28,9,32
	.sym	_nRxBuffLen,-3,4,9,32
	.sym	_i,1,4,1,32
	.sym	_nBufPos,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 296 | int xr16l784_GetRxBuffer2Ch(UCHAR *pBuf,int nRxBuffLen)                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 298 | int i;                                                                 
; 299 | int nBufPos;                                                           
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 301 | nBufPos = 0;                                                           
; 302 | while(1)                                                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
L101:        
	.line	9
;----------------------------------------------------------------------
; 304 | i = (m_nXr16l784RxFront2+1)%XR16L784_BUF_2CH_MAX;                      
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxFront2+0,r0
        ldiu      r0,r1
        ash       -8,r1
        lsh       @CL5,r1
        addi3     r1,r0,r1
        andn      511,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 305 | if(i != m_nXr16l784RxRear2) {if(nBufPos >= nRxBuffLen) break; pBuf[nBuf
;     | Pos++] = m_ucXr16l784RxBuf2[i]; } else break;                          
;----------------------------------------------------------------------
        ldiu      r1,r0
        cmpi      @_m_nXr16l784RxRear2+0,r0
        beq       L106
;*      Branch Occurs to L106 
        ldiu      *+fp(2),r0
        cmpi      *-fp(3),r0
        bge       L106
;*      Branch Occurs to L106 
        ldiu      r0,ar0
        ldiu      r1,ir0
        ldiu      @CL16,ar1
        ldiu      *-fp(2),ir1
        ldiu      1,r0
        ldiu      *+ar1(ir0),r1
        bud       L105
        addi      ar0,r0
        sti       r0,*+fp(2)
        sti       r1,*+ar0(ir1)
;*      Branch Occurs to L105 
	.line	10
L105:        
	.line	11
;----------------------------------------------------------------------
; 306 | m_nXr16l784RxFront2 = i;                                               
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784RxFront2+0
	.line	12
        bu        L101
;*      Branch Occurs to L101 
L106:        
	.line	13
;----------------------------------------------------------------------
; 308 | return nBufPos;                                                        
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	14
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      4,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	309,000000000h,2


	.sect	 ".text"

	.global	_xr16l784_GetRxBuffer3Ch
	.sym	_xr16l784_GetRxBuffer3Ch,_xr16l784_GetRxBuffer3Ch,36,2,0
	.func	311
;******************************************************************************
;* FUNCTION NAME: _xr16l784_GetRxBuffer3Ch                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,ir1,st                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 2 Auto + 0 SOE = 6 words          *
;******************************************************************************
_xr16l784_GetRxBuffer3Ch:
	.sym	_pBuf,-2,28,9,32
	.sym	_nRxBuffLen,-3,4,9,32
	.sym	_i,1,4,1,32
	.sym	_nBufPos,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 311 | int xr16l784_GetRxBuffer3Ch(UCHAR *pBuf,int nRxBuffLen)                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 313 | int i;                                                                 
; 314 | int nBufPos;                                                           
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 316 | nBufPos = 0;                                                           
; 317 | while(1)                                                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
L110:        
	.line	9
;----------------------------------------------------------------------
; 319 | i = (m_nXr16l784RxFront3+1)%XR16L784_BUF_3CH_MAX;                      
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxFront3+0,r0
        ldiu      r0,r1
        ash       -7,r1
        lsh       @CL7,r1
        addi3     r1,r0,r1
        andn      255,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 320 | if(i != m_nXr16l784RxRear3) {if(nBufPos >= nRxBuffLen) break; pBuf[nBuf
;     | Pos++] = m_ucXr16l784RxBuf3[i]; } else break;                          
;----------------------------------------------------------------------
        ldiu      r1,r0
        cmpi      @_m_nXr16l784RxRear3+0,r0
        beq       L115
;*      Branch Occurs to L115 
        ldiu      *+fp(2),r0
        cmpi      *-fp(3),r0
        bge       L115
;*      Branch Occurs to L115 
        ldiu      r0,ar0
        ldiu      r1,ir0
        ldiu      @CL19,ar1
        ldiu      *-fp(2),ir1
        ldiu      1,r0
        ldiu      *+ar1(ir0),r1
        bud       L114
        addi      ar0,r0
        sti       r0,*+fp(2)
        sti       r1,*+ar0(ir1)
;*      Branch Occurs to L114 
	.line	10
L114:        
	.line	11
;----------------------------------------------------------------------
; 321 | m_nXr16l784RxFront3 = i;                                               
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784RxFront3+0
	.line	12
        bu        L110
;*      Branch Occurs to L110 
L115:        
	.line	13
;----------------------------------------------------------------------
; 323 | return nBufPos;                                                        
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	14
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      4,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	324,000000000h,2


	.sect	 ".text"

	.global	_xr16l784_GetRxBuffer4Ch
	.sym	_xr16l784_GetRxBuffer4Ch,_xr16l784_GetRxBuffer4Ch,36,2,0
	.func	326
;******************************************************************************
;* FUNCTION NAME: _xr16l784_GetRxBuffer4Ch                                    *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,ir1,st                            *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 2 Parm + 2 Auto + 0 SOE = 6 words          *
;******************************************************************************
_xr16l784_GetRxBuffer4Ch:
	.sym	_pBuf,-2,28,9,32
	.sym	_nRxBuffLen,-3,4,9,32
	.sym	_i,1,4,1,32
	.sym	_nBufPos,2,4,1,32
	.line	1
;----------------------------------------------------------------------
; 326 | int xr16l784_GetRxBuffer4Ch(UCHAR *pBuf,int nRxBuffLen)                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 328 | int i;                                                                 
; 329 | int nBufPos;                                                           
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 331 | nBufPos = 0;                                                           
; 332 | while(1)                                                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
L119:        
	.line	9
;----------------------------------------------------------------------
; 334 | i = (m_nXr16l784RxFront4+1)%XR16L784_BUF_4CH_MAX;                      
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxFront4+0,r0
        ldiu      r0,r1
        ash       -2,r1
        lsh       @CL9,r1
        addi3     r1,r0,r1
        andn      7,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 335 | if(i != m_nXr16l784RxRear4) {if(nBufPos >= nRxBuffLen) break; pBuf[nBuf
;     | Pos++] = m_ucXr16l784RxBuf4[i]; } else break;                          
;----------------------------------------------------------------------
        ldiu      r1,r0
        cmpi      @_m_nXr16l784RxRear4+0,r0
        beq       L124
;*      Branch Occurs to L124 
        ldiu      *+fp(2),r0
        cmpi      *-fp(3),r0
        bge       L124
;*      Branch Occurs to L124 
        ldiu      r0,ar0
        ldiu      r1,ir0
        ldiu      @CL22,ar1
        ldiu      *-fp(2),ir1
        ldiu      1,r0
        ldiu      *+ar1(ir0),r1
        bud       L123
        addi      ar0,r0
        sti       r0,*+fp(2)
        sti       r1,*+ar0(ir1)
;*      Branch Occurs to L123 
	.line	10
L123:        
	.line	11
;----------------------------------------------------------------------
; 336 | m_nXr16l784RxFront4 = i;                                               
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784RxFront4+0
	.line	12
        bu        L119
;*      Branch Occurs to L119 
L124:        
	.line	13
;----------------------------------------------------------------------
; 338 | return nBufPos;                                                        
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	14
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      4,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	339,000000000h,2


	.sect	 ".text"

	.global	_xr16l784_Isr
	.sym	_xr16l784_Isr,_xr16l784_Isr,32,2,0
	.func	346
;******************************************************************************
;* FUNCTION NAME: _xr16l784_Isr                                               *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,ar0,ar1,ir0,st                                *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 3 Auto + 0 SOE = 5 words          *
;******************************************************************************
_xr16l784_Isr:
	.sym	_i,1,4,1,32
	.sym	_nSt,2,12,1,32
	.sym	_nRxd,3,12,1,32
	.line	1
;----------------------------------------------------------------------
; 346 | void xr16l784_Isr()                                                    
; 348 | int i;                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
	.line	4
;----------------------------------------------------------------------
; 349 | UCHAR nSt = 0;                                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 350 | UCHAR nRxd = 0;                                                        
; 352 | // -- 1 Channel --                                                     
;----------------------------------------------------------------------
        sti       r0,*+fp(3)
	.line	8
;----------------------------------------------------------------------
; 353 | nSt = pXr16Reg->xr16Reg[XR16L784_1CHL].CREG3.btIir;                    
; 355 | // TX                                                                  
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ar0
        ldiu      *+ar0(2),r0
        sti       r0,*+fp(2)
	.line	11
;----------------------------------------------------------------------
; 356 | if(nSt&0x02)                                                           
;----------------------------------------------------------------------
        ldiu      2,r0
        tstb      *+fp(2),r0
        beq       L131
;*      Branch Occurs to L131 
	.line	13
;----------------------------------------------------------------------
; 358 | i = (m_nXr16l784TxFront1+1) % XR16L784_TXBUF_1CH_MAX;                  
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxFront1+0,r0
        ldiu      9500,r1
        call      MOD_I30
                                        ; Call Occurs
        sti       r0,*+fp(1)
	.line	14
;----------------------------------------------------------------------
; 359 | if(i != m_nXr16l784TxRear1)                                            
;----------------------------------------------------------------------
        cmpi      @_m_nXr16l784TxRear1+0,r0
        beq       L130
;*      Branch Occurs to L130 
	.line	16
;----------------------------------------------------------------------
; 361 | pXr16Reg->xr16Reg[XR16L784_1CHL].CREG1.btTxd = m_ucXr16l784TxBuf1[i];  
;----------------------------------------------------------------------
        ldiu      r0,ar1
        ldiu      @_m_ucXr16l784TxBuf1+0,ir0
        ldiu      @_pXr16Reg+0,ar0
        ldiu      *+ar1(ir0),r0
        sti       r0,*ar0
	.line	17
;----------------------------------------------------------------------
; 362 | m_nXr16l784TxFront1 = i;                                               
; 364 | else                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxFront1+0
        bu        L131
;*      Branch Occurs to L131 
L130:        
	.line	21
;----------------------------------------------------------------------
; 366 | m_nXr16l784TxEnableDly1 = XR16L784_TXENABLEDLYCNT;                     
; 369 | // RX                                                                  
;----------------------------------------------------------------------
        ldiu      3,r0
        sti       r0,@_m_nXr16l784TxEnableDly1+0
L131:        
	.line	25
;----------------------------------------------------------------------
; 370 | if(nSt&0x04)                                                           
;----------------------------------------------------------------------
        ldiu      4,r0
        tstb      *+fp(2),r0
        beq       L135
;*      Branch Occurs to L135 
	.line	27
;----------------------------------------------------------------------
; 372 | if(!(pXr16Reg->xr16Reg[XR16L784_1CHL].btLsr & 0x0c))                   
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ar0
        ldiu      12,r0
        tstb      *+ar0(5),r0
        bne       L135
;*      Branch Occurs to L135 
	.line	29
;----------------------------------------------------------------------
; 374 | nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_1CHL].CREG1.btRxd);           
;----------------------------------------------------------------------
        ldiu      255,r0
        and3      r0,*ar0,r0
        sti       r0,*+fp(3)
	.line	30
;----------------------------------------------------------------------
; 375 | i = (m_nXr16l784RxRear1+1)%XR16L784_RXBUF_1CH_MAX;                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxRear1+0,r0
        ldiu      r0,r1
        ash       -5,r1
        lsh       @CL23,r1
        addi3     r1,r0,r1
        andn      63,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	31
;----------------------------------------------------------------------
; 376 | if(m_nXr16l784RxFront1 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxFront1+0,r0
        cmpi      *+fp(1),r0
        beq       L135
;*      Branch Occurs to L135 
	.line	33
;----------------------------------------------------------------------
; 378 | m_ucXr16l784RxBuf1[m_nXr16l784RxRear1] = nRxd;                         
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxRear1+0,ir0
        ldiu      @CL13,ar0
        ldiu      *+fp(3),r0
        sti       r0,*+ar0(ir0)
	.line	34
;----------------------------------------------------------------------
; 379 | m_nXr16l784RxRear1 = (m_nXr16l784RxRear1+1)%XR16L784_RXBUF_1CH_MAX;
;     |                                                                        
; 384 | // -- 2 Channel --                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxRear1+0,r0
        ldiu      r0,r1
        ash       -5,r1
        lsh       @CL23,r1
        addi3     r1,r0,r1
        andn      63,r1
        subri     r0,r1
        sti       r1,@_m_nXr16l784RxRear1+0
L135:        
	.line	40
;----------------------------------------------------------------------
; 385 | nSt = pXr16Reg->xr16Reg[XR16L784_2CHL].CREG3.btIir;                    
; 386 | // TX                                                                  
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ar0
        ldiu      *+ar0(18),r0
        sti       r0,*+fp(2)
	.line	42
;----------------------------------------------------------------------
; 387 | if(nSt&0x02)                                                           
;----------------------------------------------------------------------
        ldiu      2,r0
        tstb      *+fp(2),r0
        beq       L139
;*      Branch Occurs to L139 
	.line	44
;----------------------------------------------------------------------
; 389 | i = (m_nXr16l784TxFront2+1) % XR16L784_BUF_2CH_MAX;                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxFront2+0,r0
        ldiu      r0,r1
        ash       -8,r1
        lsh       @CL5,r1
        addi3     r1,r0,r1
        andn      511,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	45
;----------------------------------------------------------------------
; 390 | if(i != m_nXr16l784TxRear2)                                            
;----------------------------------------------------------------------
        ldiu      r1,r0
        cmpi      @_m_nXr16l784TxRear2+0,r0
        beq       L138
;*      Branch Occurs to L138 
	.line	47
;----------------------------------------------------------------------
; 392 | pXr16Reg->xr16Reg[XR16L784_2CHL].CREG1.btTxd = m_ucXr16l784TxBuf2[i];  
;----------------------------------------------------------------------
        ldiu      r0,ir0
        ldiu      @CL6,ar0
        ldiu      @_pXr16Reg+0,ar1
        ldiu      *+ar0(ir0),r0
        sti       r0,*+ar1(16)
	.line	48
;----------------------------------------------------------------------
; 393 | m_nXr16l784TxFront2 = i;                                               
; 395 | else                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxFront2+0
        bu        L139
;*      Branch Occurs to L139 
L138:        
	.line	52
;----------------------------------------------------------------------
; 397 | m_nXr16l784TxEnableDly2 = XR16L784_TXENABLEDLYCNT;                     
; 400 | // RX                                                                  
;----------------------------------------------------------------------
        ldiu      3,r0
        sti       r0,@_m_nXr16l784TxEnableDly2+0
L139:        
	.line	56
;----------------------------------------------------------------------
; 401 | if(nSt&0x04)                                                           
;----------------------------------------------------------------------
        ldiu      4,r0
        tstb      *+fp(2),r0
        beq       L143
;*      Branch Occurs to L143 
	.line	58
;----------------------------------------------------------------------
; 403 | if(!(pXr16Reg->xr16Reg[XR16L784_2CHL].btLsr & 0x0c))                   
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ar0
        ldiu      12,r0
        tstb      *+ar0(21),r0
        bne       L143
;*      Branch Occurs to L143 
	.line	60
;----------------------------------------------------------------------
; 405 | nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_2CHL].CREG1.btRxd);           
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *+ar0(16),r0
        sti       r0,*+fp(3)
	.line	61
;----------------------------------------------------------------------
; 406 | i = (m_nXr16l784RxRear2+1)%XR16L784_BUF_2CH_MAX;                       
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxRear2+0,r0
        ldiu      r0,r1
        ash       -8,r1
        lsh       @CL5,r1
        addi3     r1,r0,r1
        andn      511,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	62
;----------------------------------------------------------------------
; 407 | if(m_nXr16l784RxFront2 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxFront2+0,r0
        cmpi      *+fp(1),r0
        beq       L143
;*      Branch Occurs to L143 
	.line	64
;----------------------------------------------------------------------
; 409 | m_ucXr16l784RxBuf2[m_nXr16l784RxRear2] = nRxd;                         
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxRear2+0,ir0
        ldiu      @CL16,ar0
        ldiu      *+fp(3),r0
        sti       r0,*+ar0(ir0)
	.line	65
;----------------------------------------------------------------------
; 410 | m_nXr16l784RxRear2 = (m_nXr16l784RxRear2+1)%XR16L784_BUF_2CH_MAX;
;     |                                                                        
; 415 | // -- 3 Channel --                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxRear2+0,r0
        ldiu      r0,r1
        ash       -8,r1
        lsh       @CL5,r1
        addi3     r1,r0,r1
        andn      511,r1
        subri     r0,r1
        sti       r1,@_m_nXr16l784RxRear2+0
L143:        
	.line	71
;----------------------------------------------------------------------
; 416 | nSt = pXr16Reg->xr16Reg[XR16L784_3CHL].CREG3.btIir;                    
; 417 | // TX                                                                  
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ar0
        ldiu      *+ar0(34),r0
        sti       r0,*+fp(2)
	.line	73
;----------------------------------------------------------------------
; 418 | if(nSt&0x02)                                                           
;----------------------------------------------------------------------
        ldiu      2,r0
        tstb      *+fp(2),r0
        beq       L147
;*      Branch Occurs to L147 
	.line	75
;----------------------------------------------------------------------
; 420 | i = (m_nXr16l784TxFront3+1) % XR16L784_BUF_3CH_MAX;                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784TxFront3+0,r0
        ldiu      r0,r1
        ash       -7,r1
        lsh       @CL7,r1
        addi3     r1,r0,r1
        andn      255,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	76
;----------------------------------------------------------------------
; 421 | if(i != m_nXr16l784TxRear3)                                            
;----------------------------------------------------------------------
        ldiu      r1,r0
        cmpi      @_m_nXr16l784TxRear3+0,r0
        beq       L146
;*      Branch Occurs to L146 
	.line	78
;----------------------------------------------------------------------
; 423 | pXr16Reg->xr16Reg[XR16L784_3CHL].CREG1.btTxd = m_ucXr16l784TxBuf3[i];  
;----------------------------------------------------------------------
        ldiu      r0,ir0
        ldiu      @CL8,ar0
        ldiu      @_pXr16Reg+0,ar1
        ldiu      *+ar0(ir0),r0
        sti       r0,*+ar1(32)
	.line	79
;----------------------------------------------------------------------
; 424 | m_nXr16l784TxFront3 = i;                                               
; 426 | else                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxFront3+0
        bu        L147
;*      Branch Occurs to L147 
L146:        
	.line	83
;----------------------------------------------------------------------
; 428 | m_nXr16l784TxEnableDly3 = XR16L784_TXENABLEDLYCNT;                     
; 431 | // RX                                                                  
;----------------------------------------------------------------------
        ldiu      3,r0
        sti       r0,@_m_nXr16l784TxEnableDly3+0
L147:        
	.line	87
;----------------------------------------------------------------------
; 432 | if(nSt&0x04)                                                           
;----------------------------------------------------------------------
        ldiu      4,r0
        tstb      *+fp(2),r0
        beq       L151
;*      Branch Occurs to L151 
	.line	89
;----------------------------------------------------------------------
; 434 | if(!(pXr16Reg->xr16Reg[XR16L784_3CHL].btLsr & 0x0c))                   
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ar0
        ldiu      12,r0
        tstb      *+ar0(37),r0
        bne       L151
;*      Branch Occurs to L151 
	.line	91
;----------------------------------------------------------------------
; 436 | nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_3CHL].CREG1.btRxd);           
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *+ar0(32),r0
        sti       r0,*+fp(3)
	.line	92
;----------------------------------------------------------------------
; 437 | i = (m_nXr16l784RxRear3+1)%XR16L784_BUF_3CH_MAX;                       
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxRear3+0,r0
        ldiu      r0,r1
        ash       -7,r1
        lsh       @CL7,r1
        addi3     r1,r0,r1
        andn      255,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	93
;----------------------------------------------------------------------
; 438 | if(m_nXr16l784RxFront3 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxFront3+0,r0
        cmpi      *+fp(1),r0
        beq       L151
;*      Branch Occurs to L151 
	.line	95
;----------------------------------------------------------------------
; 440 | m_ucXr16l784RxBuf3[m_nXr16l784RxRear3] = nRxd;                         
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxRear3+0,ir0
        ldiu      @CL19,ar0
        ldiu      *+fp(3),r0
        sti       r0,*+ar0(ir0)
	.line	96
;----------------------------------------------------------------------
; 441 | m_nXr16l784RxRear3 = (m_nXr16l784RxRear3+1)%XR16L784_BUF_3CH_MAX;
;     |                                                                        
; 446 | // -- 4 Channel --                                                     
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxRear3+0,r1
        ldiu      1,r0
        addi      r0,r1
        ldiu      r1,r0
        ash       -7,r0
        lsh       @CL7,r0
        addi3     r0,r1,r0
        andn      255,r0
        subri     r1,r0
        sti       r0,@_m_nXr16l784RxRear3+0
L151:        
	.line	102
;----------------------------------------------------------------------
; 447 | nSt = pXr16Reg->xr16Reg[XR16L784_4CHL].CREG3.btIir;                    
; 448 | // TX                                                                  
;----------------------------------------------------------------------
        ldiu      @_pXr16Reg+0,ar0
        ldiu      *+ar0(50),r0
        sti       r0,*+fp(2)
	.line	104
;----------------------------------------------------------------------
; 449 | if(nSt&0x02)                                                           
;----------------------------------------------------------------------
        ldiu      2,r0
        tstb      *+fp(2),r0
        beq       L155
;*      Branch Occurs to L155 
	.line	106
;----------------------------------------------------------------------
; 451 | i = (m_nXr16l784TxFront4+1) % XR16L784_BUF_4CH_MAX;                    
;----------------------------------------------------------------------
        ldiu      1,r1
        addi      @_m_nXr16l784TxFront4+0,r1
        ldiu      r1,r0
        ash       -2,r0
        lsh       @CL9,r0
        addi3     r0,r1,r0
        andn      7,r0
        subri     r1,r0
        sti       r0,*+fp(1)
	.line	107
;----------------------------------------------------------------------
; 452 | if(i != m_nXr16l784TxRear4)                                            
;----------------------------------------------------------------------
        cmpi      @_m_nXr16l784TxRear4+0,r0
        beq       L154
;*      Branch Occurs to L154 
	.line	109
;----------------------------------------------------------------------
; 454 | pXr16Reg->xr16Reg[XR16L784_4CHL].CREG1.btTxd = m_ucXr16l784TxBuf4[i];  
;----------------------------------------------------------------------
        ldiu      @CL10,ar1
        ldiu      r0,ir0
        ldiu      *+ar1(ir0),r0
        sti       r0,*+ar0(48)
	.line	110
;----------------------------------------------------------------------
; 455 | m_nXr16l784TxFront4 = i;                                               
; 457 | else                                                                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        sti       r0,@_m_nXr16l784TxFront4+0
        bu        L155
;*      Branch Occurs to L155 
L154:        
	.line	114
;----------------------------------------------------------------------
; 459 | m_nXr16l784TxEnableDly4 = XR16L784_TXENABLEDLYCNT;                     
; 462 | // RX                                                                  
;----------------------------------------------------------------------
        ldiu      3,r0
        sti       r0,@_m_nXr16l784TxEnableDly4+0
L155:        
	.line	118
;----------------------------------------------------------------------
; 463 | if(nSt&0x04)                                                           
;----------------------------------------------------------------------
        ldiu      4,r0
        tstb      *+fp(2),r0
        beqd      L159
	nop
        ldine     @_pXr16Reg+0,ar0
        ldine     12,r0
;*      Branch Occurs to L159 
	.line	120
;----------------------------------------------------------------------
; 465 | if(!(pXr16Reg->xr16Reg[XR16L784_4CHL].btLsr & 0x0c))                   
;----------------------------------------------------------------------
        tstb      *+ar0(53),r0
        bne       L159
;*      Branch Occurs to L159 
	.line	122
;----------------------------------------------------------------------
; 467 | nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_4CHL].CREG1.btRxd);           
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *+ar0(48),r0
        sti       r0,*+fp(3)
	.line	123
;----------------------------------------------------------------------
; 468 | i = (m_nXr16l784RxRear4+1)%XR16L784_BUF_4CH_MAX;                       
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nXr16l784RxRear4+0,r0
        ldiu      r0,r1
        ash       -2,r1
        lsh       @CL9,r1
        addi3     r1,r0,r1
        andn      7,r1
        subri     r0,r1
        sti       r1,*+fp(1)
	.line	124
;----------------------------------------------------------------------
; 469 | if(m_nXr16l784RxFront4 != i)                                           
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784RxFront4+0,r0
        cmpi      *+fp(1),r0
        beqd      L159
        ldine     @_m_nXr16l784RxRear4+0,ir0
        ldine     @CL22,ar0
        ldine     *+fp(3),r0
;*      Branch Occurs to L159 
	.line	126
;----------------------------------------------------------------------
; 471 | m_ucXr16l784RxBuf4[m_nXr16l784RxRear4] = nRxd;                         
;----------------------------------------------------------------------
        sti       r0,*+ar0(ir0)
	.line	127
;----------------------------------------------------------------------
; 472 | m_nXr16l784RxRear4 = (m_nXr16l784RxRear4+1)%XR16L784_BUF_4CH_MAX;
;     |                                                                        
;----------------------------------------------------------------------
        ldiu      1,r1
        addi      @_m_nXr16l784RxRear4+0,r1
        ldiu      r1,r0
        ash       -2,r0
        lsh       @CL9,r0
        addi3     r0,r1,r0
        andn      7,r0
        subri     r1,r0
        sti       r0,@_m_nXr16l784RxRear4+0
L159:        
	.line	131
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      5,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	476,000000000h,3


	.sect	 ".text"

	.global	_xr16l784_Loop
	.sym	_xr16l784_Loop,_xr16l784_Loop,32,2,0
	.func	482
;******************************************************************************
;* FUNCTION NAME: _xr16l784_Loop                                              *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs :                                                     *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_xr16l784_Loop:
	.line	1
;----------------------------------------------------------------------
; 482 | void xr16l784_Loop()                                                   
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	484,000000000h,0


	.sect	 ".text"

	.global	_xr16l784_1msLoop
	.sym	_xr16l784_1msLoop,_xr16l784_1msLoop,32,2,0
	.func	490
;******************************************************************************
;* FUNCTION NAME: _xr16l784_1msLoop                                           *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,fp,sp,st                                   *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 0 Auto + 0 SOE = 2 words          *
;******************************************************************************
_xr16l784_1msLoop:
	.line	1
;----------------------------------------------------------------------
; 490 | void xr16l784_1msLoop()                                                
; 492 | // Send TX delay enable                                                
; 493 | //if(m_nXr16l784TxStartEnableDly1 == 1) xr16l784_Send(XR16L784_1CHL,m_u
;     | cXr16l784TxBuf1Temp,m_nXr16l784TxLen1Temp);                            
; 494 | //if(m_nXr16l784TxStartEnableDly1) m_nXr16l784TxStartEnableDly1--;     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	6
;----------------------------------------------------------------------
; 495 | if(m_nXr16l784TxStartEnableDly2 == 1) xr16l784_Send(XR16L784_2CHL,m_ucX
;     | r16l784TxBuf2Temp,m_nXr16l784TxLen2Temp);                              
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxStartEnableDly2+0,r0
        cmpi      1,r0
        bned      L166
        ldieq     @_m_nXr16l784TxLen2Temp+0,r2
        ldieq     @CL2,r0
        ldieq     1,r1
;*      Branch Occurs to L166 
        push      r2
        push      r0
        push      r1
        call      _xr16l784_Send
                                        ; Call Occurs
        subi      3,sp
L166:        
	.line	7
;----------------------------------------------------------------------
; 496 | if(m_nXr16l784TxStartEnableDly2) m_nXr16l784TxStartEnableDly2--;       
;----------------------------------------------------------------------
        ldi       @_m_nXr16l784TxStartEnableDly2+0,r0
        beq       L168
;*      Branch Occurs to L168 
        ldiu      1,r0
        subri     @_m_nXr16l784TxStartEnableDly2+0,r0
        sti       r0,@_m_nXr16l784TxStartEnableDly2+0
L168:        
	.line	8
;----------------------------------------------------------------------
; 497 | if(m_nXr16l784TxStartEnableDly3 == 1) xr16l784_Send(XR16L784_3CHL,m_ucX
;     | r16l784TxBuf3Temp,m_nXr16l784TxLen3Temp);                              
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxStartEnableDly3+0,r0
        cmpi      1,r0
        bned      L170
        ldieq     @_m_nXr16l784TxLen3Temp+0,r1
        ldieq     @CL3,r0
        ldieq     2,r2
;*      Branch Occurs to L170 
        push      r1
        push      r0
        push      r2
        call      _xr16l784_Send
                                        ; Call Occurs
        subi      3,sp
L170:        
	.line	9
;----------------------------------------------------------------------
; 498 | if(m_nXr16l784TxStartEnableDly3) m_nXr16l784TxStartEnableDly3--;       
;----------------------------------------------------------------------
        ldi       @_m_nXr16l784TxStartEnableDly3+0,r0
        beq       L172
;*      Branch Occurs to L172 
        ldiu      1,r0
        subri     @_m_nXr16l784TxStartEnableDly3+0,r0
        sti       r0,@_m_nXr16l784TxStartEnableDly3+0
L172:        
	.line	10
;----------------------------------------------------------------------
; 499 | if(m_nXr16l784TxStartEnableDly4 == 1) xr16l784_Send(XR16L784_4CHL,m_ucX
;     | r16l784TxBuf4Temp,m_nXr16l784TxLen4Temp);                              
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxStartEnableDly4+0,r0
        cmpi      1,r0
        bned      L174
        ldieq     @_m_nXr16l784TxLen4Temp+0,r0
        ldieq     @CL4,r1
        ldieq     3,r2
;*      Branch Occurs to L174 
        push      r0
        push      r1
        push      r2
        call      _xr16l784_Send
                                        ; Call Occurs
        subi      3,sp
L174:        
	.line	11
;----------------------------------------------------------------------
; 500 | if(m_nXr16l784TxStartEnableDly4) m_nXr16l784TxStartEnableDly4--;       
; 502 | // TX Delay Disable                                                    
;----------------------------------------------------------------------
        ldi       @_m_nXr16l784TxStartEnableDly4+0,r0
        beq       L176
;*      Branch Occurs to L176 
        ldiu      1,r0
        subri     @_m_nXr16l784TxStartEnableDly4+0,r0
        sti       r0,@_m_nXr16l784TxStartEnableDly4+0
L176:        
	.line	14
;----------------------------------------------------------------------
; 503 | if(m_nXr16l784TxEnableDly1 == 1) XR16L784_TXDIS(XR16L784_1CHL);        
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxEnableDly1+0,r0
        cmpi      1,r0
        bned      L178
	nop
        ldieq     0,r1
        ldieq     0,r0
;*      Branch Occurs to L178 
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
L178:        
	.line	15
;----------------------------------------------------------------------
; 504 | if(m_nXr16l784TxEnableDly1) m_nXr16l784TxEnableDly1--;                 
;----------------------------------------------------------------------
        ldi       @_m_nXr16l784TxEnableDly1+0,r0
        beq       L180
;*      Branch Occurs to L180 
        ldiu      1,r0
        subri     @_m_nXr16l784TxEnableDly1+0,r0
        sti       r0,@_m_nXr16l784TxEnableDly1+0
L180:        
	.line	16
;----------------------------------------------------------------------
; 505 | if(m_nXr16l784TxEnableDly2 == 1) XR16L784_TXDIS(XR16L784_2CHL);        
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxEnableDly2+0,r0
        cmpi      1,r0
        bned      L182
	nop
        ldieq     0,r1
        ldieq     1,r0
;*      Branch Occurs to L182 
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
L182:        
	.line	17
;----------------------------------------------------------------------
; 506 | if(m_nXr16l784TxEnableDly2) m_nXr16l784TxEnableDly2--;                 
;----------------------------------------------------------------------
        ldi       @_m_nXr16l784TxEnableDly2+0,r0
        beq       L184
;*      Branch Occurs to L184 
        ldiu      1,r0
        subri     @_m_nXr16l784TxEnableDly2+0,r0
        sti       r0,@_m_nXr16l784TxEnableDly2+0
L184:        
	.line	18
;----------------------------------------------------------------------
; 507 | if(m_nXr16l784TxEnableDly3 == 1) XR16L784_TXDIS(XR16L784_3CHL);        
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxEnableDly3+0,r0
        cmpi      1,r0
        bned      L186
	nop
        ldieq     0,r0
        ldieq     2,r1
;*      Branch Occurs to L186 
        push      r0
        push      r1
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
L186:        
	.line	19
;----------------------------------------------------------------------
; 508 | if(m_nXr16l784TxEnableDly3) m_nXr16l784TxEnableDly3--;                 
;----------------------------------------------------------------------
        ldi       @_m_nXr16l784TxEnableDly3+0,r0
        beq       L188
;*      Branch Occurs to L188 
        ldiu      1,r0
        subri     @_m_nXr16l784TxEnableDly3+0,r0
        sti       r0,@_m_nXr16l784TxEnableDly3+0
L188:        
	.line	20
;----------------------------------------------------------------------
; 509 | if(m_nXr16l784TxEnableDly4 == 1) XR16L784_TXDIS(XR16L784_4CHL);        
;----------------------------------------------------------------------
        ldiu      @_m_nXr16l784TxEnableDly4+0,r0
        cmpi      1,r0
        bned      L190
	nop
        ldieq     0,r1
        ldieq     3,r0
;*      Branch Occurs to L190 
        push      r1
        push      r0
        call      _xr16l784_Rts
                                        ; Call Occurs
        subi      2,sp
L190:        
	.line	21
;----------------------------------------------------------------------
; 510 | if(m_nXr16l784TxEnableDly4) m_nXr16l784TxEnableDly4--;                 
;----------------------------------------------------------------------
        ldi       @_m_nXr16l784TxEnableDly4+0,r0
        beq       L192
;*      Branch Occurs to L192 
        ldiu      1,r0
        subri     @_m_nXr16l784TxEnableDly4+0,r0
        sti       r0,@_m_nXr16l784TxEnableDly4+0
L192:        
	.line	22
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	511,000000000h,0



	.global	_m_ucXr16l784TxBuf2
	.bss	_m_ucXr16l784TxBuf2,512
	.sym	_m_ucXr16l784TxBuf2,_m_ucXr16l784TxBuf2,60,2,16384,,512

	.global	_m_ucXr16l784TxBuf3
	.bss	_m_ucXr16l784TxBuf3,256
	.sym	_m_ucXr16l784TxBuf3,_m_ucXr16l784TxBuf3,60,2,8192,,256

	.global	_m_ucXr16l784TxBuf4
	.bss	_m_ucXr16l784TxBuf4,8
	.sym	_m_ucXr16l784TxBuf4,_m_ucXr16l784TxBuf4,60,2,256,,8

	.global	_m_ucXr16l784TxBuf2Temp
	.bss	_m_ucXr16l784TxBuf2Temp,512
	.sym	_m_ucXr16l784TxBuf2Temp,_m_ucXr16l784TxBuf2Temp,60,2,16384,,512

	.global	_m_ucXr16l784TxBuf3Temp
	.bss	_m_ucXr16l784TxBuf3Temp,256
	.sym	_m_ucXr16l784TxBuf3Temp,_m_ucXr16l784TxBuf3Temp,60,2,8192,,256

	.global	_m_ucXr16l784TxBuf4Temp
	.bss	_m_ucXr16l784TxBuf4Temp,8
	.sym	_m_ucXr16l784TxBuf4Temp,_m_ucXr16l784TxBuf4Temp,60,2,256,,8

	.global	_m_ucXr16l784RxBuf1
	.bss	_m_ucXr16l784RxBuf1,64
	.sym	_m_ucXr16l784RxBuf1,_m_ucXr16l784RxBuf1,60,2,2048,,64

	.global	_m_ucXr16l784RxBuf2
	.bss	_m_ucXr16l784RxBuf2,512
	.sym	_m_ucXr16l784RxBuf2,_m_ucXr16l784RxBuf2,60,2,16384,,512

	.global	_m_ucXr16l784RxBuf3
	.bss	_m_ucXr16l784RxBuf3,256
	.sym	_m_ucXr16l784RxBuf3,_m_ucXr16l784RxBuf3,60,2,8192,,256

	.global	_m_ucXr16l784RxBuf4
	.bss	_m_ucXr16l784RxBuf4,8
	.sym	_m_ucXr16l784RxBuf4,_m_ucXr16l784RxBuf4,60,2,256,,8
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

	.sect	".cinit"
	.field  	23,32
	.field  	CL1+0,32
	.field  	921600,32
	.field  	_m_ucXr16l784TxBuf2Temp,32
	.field  	_m_ucXr16l784TxBuf3Temp,32
	.field  	_m_ucXr16l784TxBuf4Temp,32
	.field  	-23,32
	.field  	_m_ucXr16l784TxBuf2,32
	.field  	-24,32
	.field  	_m_ucXr16l784TxBuf3,32
	.field  	-29,32
	.field  	_m_ucXr16l784TxBuf4,32
	.field  	_m_nXr16l784RxRear1,32
	.field  	_m_nXr16l784RxFront1,32
	.field  	_m_ucXr16l784RxBuf1,32
	.field  	_m_nXr16l784RxRear2,32
	.field  	_m_nXr16l784RxFront2,32
	.field  	_m_ucXr16l784RxBuf2,32
	.field  	_m_nXr16l784RxRear3,32
	.field  	_m_nXr16l784RxFront3,32
	.field  	_m_ucXr16l784RxBuf3,32
	.field  	_m_nXr16l784RxRear4,32
	.field  	_m_nXr16l784RxFront4,32
	.field  	_m_ucXr16l784RxBuf4,32
	.field  	-26,32

	.sect	".text"
;******************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                              *
;******************************************************************************
	.global	DIV_I30
	.global	_memcpy
	.global	MOD_I30
