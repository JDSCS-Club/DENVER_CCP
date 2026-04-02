;******************************************************************************
;* TMS320C3x/4x ANSI C Code Generator                            Version 5.11 *
;* Date/Time created: Sat Sep 19 09:27:38 2015                                *
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
;	c:\lang\tms320c3x\511\bin\ac30.exe user.c C:\Users\JANGDU~1\AppData\Local\Temp\user.if 
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
	.stag	.fake11,352
	.member	_btSoh,0,12,8,32
	.member	_chSrcDev,32,60,8,64,,2
	.member	_chDestDev,96,60,8,64,,2
	.member	_chMsgCnt,160,60,8,64,,2
	.member	_chCmdCode,224,60,8,64,,2
	.member	_chDataLen,288,60,8,64,,2
	.eos
	.sym	_PTCHD,0,8,13,352,.fake11
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
	.stag	.fake13,576
	.member	_phHdBuf,0,8,8,352,.fake11
	.member	_nDdata,352,60,8,64,,2
	.member	_nCRC,416,60,8,128,,4
	.member	_btEot,544,12,8,32
	.eos
	.sym	_PACSDR,0,8,13,576,.fake13
	.sym	_PPACSDR,0,24,13,32,.fake13
	.stag	.fake16,32
	.member	_sACab_ON,0,14,18,1
	.member	_sASp_1,1,14,18,1
	.member	_sASp_2,2,14,18,1
	.member	_sAHead_Bit,3,14,18,1
	.member	_sBCab_ON,4,14,18,1
	.member	_sBSp_1,5,14,18,1
	.member	_sBSp_2,6,14,18,1
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
	.stag	.fake34,7872
	.member	_phHdBuf,0,8,8,352,.fake11
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
	.sym	_PAC_PAC,0,8,13,7872,.fake34
	.sym	_PPAC_PAC,0,24,13,32,.fake34
	.stag	.fake35,4992
	.member	_phHdBuf,0,8,8,352,.fake11
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
	.sym	_CCP_PAC,0,8,13,4992,.fake35
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
	.member	_Atcive_Cab,0,14,18,1
	.member	_Traction,1,14,18,1
	.member	_EP_Mode,2,14,18,1
	.member	_All_Doors_Closed,3,14,18,1
	.member	_Sp_4,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake39,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake40
	.eos
	.stag	.fake36,768
	.member	_phHdBuf,0,8,8,352,.fake11
	.member	_DATA2,352,9,8,32,.fake37
	.member	_DATA1,384,9,8,32,.fake39
	.member	_CI_Index_Num,416,60,8,64,,2
	.member	_chCarn,480,252,8,128,,2,2
	.member	_nCRC,608,60,8,128,,4
	.member	_btEot,736,12,8,32
	.eos
	.sym	_LICSD,0,8,13,768,.fake36
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
	.stag	.fake44,10336
	.member	_VerCnt,0,13,8,32
	.member	_cvbBuf,32,56,8,10240,.fake43,32
	.member	_CarNum,10272,61,8,64,,2
	.eos
	.sym	_LIC_DPRAM_Ver,0,8,13,10336,.fake44
	.sym	_PLIC_DPRAM_Ver,0,24,13,32,.fake44
	.stag	.fake45,15168
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
	.member	_cvbBuf,1312,56,8,13760,.fake43,43
	.member	_chChkSum,15072,60,8,64,,2
	.member	_btEot,15136,12,8,32
	.eos
	.sym	_CNCS_LIC_SD,0,8,13,15168,.fake45
	.sym	_PCNCS_LIC_SD,0,24,13,32,.fake45
	.stag	.fake46,832
	.member	_phHdBuf,0,8,8,480,.fake41
	.member	_sCommand,480,60,8,64,,2
	.member	_sTEXT,544,60,8,128,,4
	.member	_chContactSignalBuf,672,60,8,64,,2
	.member	_chChkSum,736,60,8,64,,2
	.member	_btEot,800,12,8,32
	.eos
	.sym	_CNCS_LIC_T_F,0,8,13,832,.fake46
	.sym	_PCNCS_LIC_T_F,0,24,13,32,.fake46
	.stag	.fake47,768
	.member	_phHdBuf,0,8,8,480,.fake41
	.member	_sCommand,480,60,8,64,,2
	.member	_sTEXT,544,60,8,128,,4
	.member	_chChkSum,672,60,8,64,,2
	.member	_btEot,736,12,8,32
	.eos
	.sym	_CNCS_LIC_T_F_C,0,8,13,768,.fake47
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
	.member	_nCncs,0,14,18,1
	.member	_nVtx,1,14,18,1
	.member	_nLic,2,14,18,1
	.member	_nPac,3,14,18,1
	.member	_nWlr,4,14,18,1
	.member	_nGps,5,14,18,1
	.member	_nVoip,6,14,18,1
	.member	_nCcp,7,14,18,1
	.eos
	.utag	.fake58,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake59
	.eos
	.stag	.fake61,32
	.member	_nSdi4,0,14,18,1
	.member	_nSdi3,1,14,18,1
	.member	_nSdi2,2,14,18,1
	.member	_nSdi1,3,14,18,1
	.member	_nPii2,4,14,18,1
	.member	_nPii1,5,14,18,1
	.member	_nFdi,6,14,18,1
	.member	_sp_7,7,14,18,1
	.eos
	.utag	.fake60,32
	.member	_BYTE,0,12,11,32
	.member	_BIT,0,8,11,32,.fake61
	.eos
	.stag	.fake63,32
	.member	_nPid2_1,0,14,18,1
	.member	_nPid1_4,1,14,18,1
	.member	_nPid1_3,2,14,18,1
	.member	_nPid1_2,3,14,18,1
	.member	_nPid1_1,4,14,18,1
	.member	_sp_5,5,14,18,1
	.member	_sp_4,6,14,18,1
	.member	_sp_7,7,14,18,1
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
	.etag	_eCDT_TYPE,32
	.member	_eCDT_A,0,4,16,32
	.member	_eCDT_B,1,4,16,32
	.member	_eCDT_MAXIMUM,2,4,16,32
	.eos
	.stag	.fake68,96
	.member	_nTCnt,0,4,8,32
	.member	_nStPosi,32,4,8,32
	.member	_nEdPosi,64,4,8,32
	.eos
	.sym	_T_FAULT_INFO,0,8,13,96,.fake68
	.sym	_PFAULT_INFO,0,24,13,32,.fake68
	.file	"Variable.h"
	.stag	.fake71,32
	.member	_Atcive_Cab,0,14,18,1
	.member	_Traction,1,14,18,1
	.member	_EP_Mode,2,14,18,1
	.member	_All_Doors_Closed,3,14,18,1
	.member	_Ci_CutOff,4,14,18,1
	.member	_Sp_5,5,14,18,1
	.member	_Sp_6,6,14,18,1
	.member	_Sp_7,7,14,18,1
	.eos
	.utag	.fake70,32
	.member	_BYTE,0,14,11,32
	.member	_BIT,0,8,11,32,.fake71
	.eos
	.stag	.fake69,14016
	.member	_LIC_VerList,0,242,8,9216,,32,9
	.member	_m_nUart1RxOneByteGapDelayTime,9216,14,8,32
	.member	_m_nUart2RxOneByteGapDelayTime,9248,14,8,32
	.member	_m_nUart3RxOneByteGapDelayTime,9280,14,8,32
	.member	_m_nUserDebug1msTimer,9312,14,8,32
	.member	_m_nTest1msTimer,9344,14,8,32
	.member	_m_tmCurTime,9376,8,8,224,.fake7
	.member	_m_tmUtcTime,9600,8,8,224,.fake7
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
	.member	_m_btCttSignalA,13568,9,8,32,.fake70
	.member	_m_btCttSignalB,13600,12,8,32
	.member	_m_LIC_CNCS_TimSetFlag,13632,4,8,32
	.member	_m_LIC_GIA_TimSetFlag,13664,4,8,32
	.member	_m_nCncsRxCheck1msTimer,13696,14,8,32
	.member	_m_nGiaRxCheck1msTimer,13728,14,8,32
	.member	_m_btTestOtherCiFault,13760,12,8,32
	.member	_m_bCiFaultFlag,13792,4,8,32
	.member	_m_tFaultInfo,13824,56,8,192,.fake68,2
	.eos
	.sym	_VARIABLE_H,0,8,13,14016,.fake69
	.sym	_PVARIABLE_H,0,24,13,32,.fake69
	.file	"LonInfo.h"
	.file	"xr16l784.h"
	.utag	.fake73,32
	.member	_btRxd,0,12,11,32
	.member	_btTxd,0,12,11,32
	.member	_btDll,0,12,11,32
	.eos
	.utag	.fake74,32
	.member	_btDlm,0,12,11,32
	.member	_btIer,0,12,11,32
	.eos
	.utag	.fake75,32
	.member	_btIir,0,12,11,32
	.member	_btFcr,0,12,11,32
	.eos
	.stag	.fake72,512
	.member	_CREG1,0,9,8,32,.fake73
	.member	_CREG2,32,9,8,32,.fake74
	.member	_CREG3,64,9,8,32,.fake75
	.member	_btLcr,96,12,8,32
	.member	_btMcr,128,12,8,32
	.member	_btLsr,160,12,8,32
	.member	_btMsr_U,192,12,8,32
	.member	_btScr,224,12,8,32
	.member	_btSp,256,60,8,256,,8
	.eos
	.sym	_XR16L784ST,0,8,13,512,.fake72
	.sym	_PXR16L784ST,0,24,13,32,.fake72
	.stag	.fake76,2048
	.member	_xr16Reg,0,56,8,2048,.fake72,4
	.eos
	.sym	_XR16L784BDY,0,8,13,2048,.fake76
	.sym	_PXR16L784BDY,0,24,13,32,.fake76
	.file	"user.c"
	.sect	 ".text"

	.global	_user_Init
	.sym	_user_Init,_user_Init,32,2,0
	.func	19
;******************************************************************************
;* FUNCTION NAME: _user_Init                                                  *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3,r4,r5,ar0,fp,ir0,bk,sp,st               *
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
;  19 | void user_Init()                                                       
;  21 | int i;                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      136,sp
        push      r4
        push      r5
	.line	4
;----------------------------------------------------------------------
;  22 | int wCarNo = 0;                                                        
;  23 | UCHAR LL,LH,HL,HH;                                                     
;  24 | char szBuf[128];                                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	7
;----------------------------------------------------------------------
;  25 | UCHAR *pDpram = (UCHAR *)DPRAM_BASE;                                   
;----------------------------------------------------------------------
        ldiu      @CL1,r0
        sti       r0,*+fp(135)
	.line	9
;----------------------------------------------------------------------
;  27 | PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //¹öÀü Á¤º¸ Ã³¸
;     | ®¸¦ À§ÇØ ÀÓÀÇ·Î ¸¸µé¾ú´Ù.                                              
;----------------------------------------------------------------------
        ldiu      @CL2,r0
        sti       r0,*+fp(136)
	.line	11
;----------------------------------------------------------------------
;  29 | user_Variable_Init();                                                  
;  31 | // ÃÊ±âÈ­ÇÏ±â                                                          
;  32 | //timeGet(&m_tmCurTime);                                               
;----------------------------------------------------------------------
        call      _user_Variable_Init
                                        ; Call Occurs
	.line	15
;----------------------------------------------------------------------
;  33 | memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt)); //»óÅ
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
;  34 | memset(m_Variable.m_btOldCommSt,0x00,sizeof(m_Variable.m_btOldCommSt));
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
;  35 | memset(m_Variable.m_btSenseCommStBuf,0x00,sizeof(m_Variable.m_btSenseCo
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
;  37 | memset(m_Variable.m_btExVersionTbl,0x0000,sizeof(m_Variable.m_btExVersi
;     | onTbl));                                                               
;----------------------------------------------------------------------
        ldiu      36,r0
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
;  38 | memset(m_Variable.m_btExVersion_DAYTbl,0x0000,sizeof(m_Variable.m_btExV
;     | ersion_DAYTbl));                                                       
;----------------------------------------------------------------------
        ldiu      36,r0
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
;  40 | m_Variable.m_LIC_CNCS_Tx_Flag = FALSE;                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+331
	.line	23
;----------------------------------------------------------------------
;  41 | m_Variable.m_LIC_CNCS_TX_DelyTime = 0;                                 
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+332
	.line	24
;----------------------------------------------------------------------
;  42 | m_Variable.m_nLnWkTxFlag = FALSE;                                      
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+333
	.line	25
;----------------------------------------------------------------------
;  43 | m_Variable.m_nFaultCnt = 0;                                            
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+334
	.line	26
;----------------------------------------------------------------------
;  44 | m_Variable.m_Recving_Posi = 0;                                         
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+335
	.line	27
;----------------------------------------------------------------------
;  45 | m_Variable.m_nCDT_FaultDataStFlag = FALSE;                             
;  48 | //memset(&m_Variable,0x00,sizeof(m_Variable));                         
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+336
	.line	33
;----------------------------------------------------------------------
;  51 | for(i=0;i<VER_BDD_MAX_CNT;i++)                                         
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      32,r0
        bge       L19
;*      Branch Occurs to L19 
L2:        
	.line	36
;----------------------------------------------------------------------
;  54 | if(WORD_L(pLicVerDp->VerCnt) == TRUE)                                  
;  56 |         // ¹öÀü Á¤º¸°¡  '0' ~ '9' ¼ý°¡ÀÎÁö È®ÀÎ ÇÑ´Ù. --> ¾Æ´Ï¸é ÃÊ±âÈ­
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
	.line	39
;----------------------------------------------------------------------
;  57 | if( !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[0])) || !IsNumAsc(WORD_
;     | L(pLicVerDp->cvbBuf[i].chVer[1])) ||                                   
;  58 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[2])) || !IsNumAsc(W
;     | ORD_L(pLicVerDp->cvbBuf[i].chVer[3])) ||                               
;  60 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[0])) || !IsNu
;     | mAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[1])) ||                   
;  61 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[2])) || !IsNu
;     | mAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[3])) ||                   
;  62 |         !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[4])) || !IsNu
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
	.line	46
;----------------------------------------------------------------------
;  64 | memset(pLicVerDp->cvbBuf[i].chVer,'0',4);                              
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
	.line	47
;----------------------------------------------------------------------
;  65 | memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);                        
;  67 | else                                                                   
;  68 | {   //°¢ ÀåÄ¡ ¹öÀü Á¤º¸¸¦ ÀÐ¾î¿Â´Ù.                                    
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
	.line	51
;----------------------------------------------------------------------
;  69 | LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[0])),ConvA
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
	.line	52
;----------------------------------------------------------------------
;  70 | LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[2])),ConvA
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
	.line	53
;----------------------------------------------------------------------
;  71 | m_Variable.m_btExVersionTbl[i] = MAKE_WORD(LH,LL);                     
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
	.line	54
;----------------------------------------------------------------------
;  72 | HH = 0x20;                                                             
;----------------------------------------------------------------------
        ldiu      32,r0
        sti       r0,*+fp(6)
	.line	55
;----------------------------------------------------------------------
;  73 | HL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[0]))
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
	.line	56
;----------------------------------------------------------------------
;  74 | LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[2]))
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
	.line	57
;----------------------------------------------------------------------
;  75 | LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[4]))
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
	.line	59
;----------------------------------------------------------------------
;  77 | m_Variable.m_btExVersion_DAYTbl[i] = MAKE_DWORD(HH,HL,LH,LL);          
;  80 | else //ÇÑ¹øµµ ¹öÀü Á¤º¸ ÀÔ·ÂÀÌ µÇÁö¾ÊÀ» °æ¿ì 0 À¸·Î ÃÊ±âÈ­ ÇÑ´Ù.       
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
	.line	64
;----------------------------------------------------------------------
;  82 | pLicVerDp->VerCnt = TRUE;                                              
;----------------------------------------------------------------------
L17:        
        sti       r0,*ar0
	.line	65
;----------------------------------------------------------------------
;  83 | memset(pLicVerDp->cvbBuf[i].chVer,'0',4);                              
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
	.line	66
;----------------------------------------------------------------------
;  84 | memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);                        
;  88 | // LIC-MPUÁ¦¾î±â ¹öÁ¯ & ºôµåµ¥ÀÌÆ®                                     
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
	.line	33
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      32,r0
        blt       L2
;*      Branch Occurs to L2 
L19:        
	.line	71
;----------------------------------------------------------------------
;  89 | m_Variable.m_btExVersionTbl[5] = MAKE_WORD(                            
;  90 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(1)/1000%10),ConvHex2Asc(GetFirmwareVersion(1)
;     | /100%10)),                                                             
;  91 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(1)/10%10),ConvHex2Asc(GetFirmwareVersion(1)%1
;     | 0))                                                                    
;  92 |                                                         );             
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
        sti       r0,@_m_Variable+357
        subi      1,sp
	.line	76
;----------------------------------------------------------------------
;  94 | m_Variable.m_btExVersion_DAYTbl[5] = MAKE_DWORD(                       
;  95 |                                                         0x20,          
;  96 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(2)/100000%10),ConvHex2Asc(GetFirmwareVersion(
;     | 2)/10000%10)),                                                         
;  97 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(2)/1000%10),ConvHex2Asc(GetFirmwareVersion(2)
;     | /100%10)),                                                             
;  98 |                                                         MAKE_BYTE(ConvH
;     | ex2Asc(GetFirmwareVersion(2)/10%10),ConvHex2Asc(GetFirmwareVersion(2)%1
;     | 0))                                                                    
;  99 |                                                         );             
;----------------------------------------------------------------------
        ldiu      2,r0
        push      r0
        call      _GetFirmwareVersion
                                        ; Call Occurs
        ldiu      @CL8,r1
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
        or        @CL9,r0
        sti       r0,@_m_Variable+393
        subi      1,sp
	.line	83
;----------------------------------------------------------------------
; 101 | i = GetFirmwareVersion(1);                                             
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _GetFirmwareVersion
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(1)
	.line	84
;----------------------------------------------------------------------
; 102 | sprintf(szBuf,"Lonwork Monitor Program, Version:%d.%d%d%d\r\n",i/1000%1
;     | 0,i/100%10,i/10%10,i%10);                                              
;----------------------------------------------------------------------
        ldiu      1000,r1
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      100,r1
        ldiu      r0,ir0
        ldiu      *+fp(1),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      r0,bk
        ldiu      10,r1
        ldiu      *+fp(1),r0
        call      DIV_I30
                                        ; Call Occurs
        ldiu      10,r1
        call      MOD_I30
                                        ; Call Occurs
        ldiu      r0,r3
        ldiu      10,r1
        ldiu      *+fp(1),r0
        call      MOD_I30
                                        ; Call Occurs
        ldiu      fp,r1
        ldiu      @CL10,r2
        push      r0
        push      r3
        push      bk
        push      ir0
        addi      7,r1
        push      r2
        push      r1
        call      _sprintf
                                        ; Call Occurs
        subi      6,sp
	.line	85
;----------------------------------------------------------------------
; 103 | user_DebugPrint(szBuf);                                                
; 105 | // ¾îµå·¹½º¿¡ ´ëÇÑ ÃÊ±â ¼³Á¤ °ª.                                       
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      7,r0
        push      r0
        call      _user_DebugPrint
                                        ; Call Occurs
        subi      1,sp
	.line	88
;----------------------------------------------------------------------
; 106 | if(DI_ADDRESS_A)                                                       
;----------------------------------------------------------------------
        ldiu      @CL11,ar0
        ldiu      1,r0
        tstb3     *ar0,r0
        beqd      L26
	nop
        ldieq     @CL11,ar0
        ldieq     -1,r0
;*      Branch Occurs to L26 
	.line	90
;----------------------------------------------------------------------
; 108 | m_Variable.m_chCarKindNum = LIC_DEV_NO;                                
;----------------------------------------------------------------------
        ldiu      34,r0
        sti       r0,@_m_Variable+343
	.line	91
;----------------------------------------------------------------------
; 109 | m_Variable.m_chCarKind = 'A';                                          
;----------------------------------------------------------------------
        ldiu      65,r0
        sti       r0,@_m_Variable+341
	.line	92
;----------------------------------------------------------------------
; 110 | m_Variable.m_nCarNo = 0x4003;                                          
;----------------------------------------------------------------------
        ldiu      16387,r0
        sti       r0,@_m_Variable+340
        bu        L28
;*      Branch Occurs to L28 
	.line	94
;----------------------------------------------------------------------
; 112 | else if(DI_ADDRESS_B)                                                  
;----------------------------------------------------------------------
L26:        
        lsh3      r0,*ar0,r0
        tstb      1,r0
        beq       L28
;*      Branch Occurs to L28 
	.line	96
;----------------------------------------------------------------------
; 114 | m_Variable.m_chCarKindNum = LIC_BAKDEV_NO;                             
;----------------------------------------------------------------------
        ldiu      38,r0
        sti       r0,@_m_Variable+343
	.line	97
;----------------------------------------------------------------------
; 115 | m_Variable.m_chCarKind = 'B';                                          
;----------------------------------------------------------------------
        ldiu      66,r0
        sti       r0,@_m_Variable+341
	.line	98
;----------------------------------------------------------------------
; 116 | m_Variable.m_nCarNo = 0x4004;                                          
;----------------------------------------------------------------------
        ldiu      16388,r0
        sti       r0,@_m_Variable+340
L28:        
	.line	100
        pop       r5
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      138,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	118,000000030h,136


	.sect	 ".text"

	.global	_user_Variable_Init
	.sym	_user_Variable_Init,_user_Variable_Init,32,2,0
	.func	122
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
; 122 | void user_Variable_Init()                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 124 | memset(&m_Variable,0x00,sizeof(VARIABLE_H));                           
;----------------------------------------------------------------------
        ldiu      438,r2
        ldiu      0,r0
        ldiu      @CL12,r1
        push      r2
        push      r0
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	5
;----------------------------------------------------------------------
; 126 | m_Variable.m_TrainCofVal = 0x8000;                                     
;----------------------------------------------------------------------
        ldiu      @CL13,r0
        sti       r0,@_m_Variable+337
	.line	6
;----------------------------------------------------------------------
; 127 | m_Variable.m_nCarPos = 0x8000;                                         
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+338
	.line	7
;----------------------------------------------------------------------
; 128 | m_Variable.m_btCiFaultVal = 0x8000;                                    
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+339
	.line	8
;----------------------------------------------------------------------
; 129 | m_Variable.m_nCarNo = 0x8000;                                          
;----------------------------------------------------------------------
        ldiu      @CL14,r0
        sti       r0,@_m_Variable+340
	.line	9
;----------------------------------------------------------------------
; 130 | m_Variable.m_chCarKind = 'A';                                          
;----------------------------------------------------------------------
        ldiu      65,r0
        sti       r0,@_m_Variable+341
	.line	10
;----------------------------------------------------------------------
; 131 | m_Variable.m_bLnWkFtpEndFlag = FALSE;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+348
	.line	11
;----------------------------------------------------------------------
; 132 | m_Variable.m_nDbgTxPos = 0xFFFFFFFF;                                   
;----------------------------------------------------------------------
        ldiu      @CL15,r0
        sti       r0,@_m_Variable+351
	.line	12
;----------------------------------------------------------------------
; 133 | m_Variable.m_btTestOtherCiFault = 0x8000;                              
;----------------------------------------------------------------------
        ldiu      @CL16,r0
        sti       r0,@_m_Variable+430
	.line	13
;----------------------------------------------------------------------
; 134 | m_Variable.m_bCiFaultFlag = FALSE;                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+431
	.line	15
;----------------------------------------------------------------------
; 136 | strcpy(&m_Variable.LIC_VerList[0][0],"CCP");                           
;----------------------------------------------------------------------
        ldiu      @CL12,r1
        ldiu      @CL17,r0
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	16
;----------------------------------------------------------------------
; 137 | strcpy(&m_Variable.LIC_VerList[1][0],"CRA-LICL");                      
;----------------------------------------------------------------------
        ldiu      @CL19,r0
        ldiu      @CL18,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	17
;----------------------------------------------------------------------
; 138 | strcpy(&m_Variable.LIC_VerList[2][0],"CRA-VTX");                       
;----------------------------------------------------------------------
        ldiu      @CL21,r0
        ldiu      @CL20,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	18
;----------------------------------------------------------------------
; 139 | strcpy(&m_Variable.LIC_VerList[3][0],"CRA-VOIP");                      
;----------------------------------------------------------------------
        ldiu      @CL23,r0
        ldiu      @CL22,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	19
;----------------------------------------------------------------------
; 140 | strcpy(&m_Variable.LIC_VerList[4][0],"CRA-PAC");                       
;----------------------------------------------------------------------
        ldiu      @CL24,r1
        ldiu      @CL25,r0
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	20
;----------------------------------------------------------------------
; 141 | strcpy(&m_Variable.LIC_VerList[5][0],"CRA-LICM");                      
;----------------------------------------------------------------------
        ldiu      @CL27,r0
        push      r0
        ldiu      @CL26,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	21
;----------------------------------------------------------------------
; 142 | strcpy(&m_Variable.LIC_VerList[6][0],"FDI1");                          
;----------------------------------------------------------------------
        ldiu      @CL29,r0
        push      r0
        ldiu      @CL28,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	22
;----------------------------------------------------------------------
; 143 | strcpy(&m_Variable.LIC_VerList[7][0],"SDI1");                          
;----------------------------------------------------------------------
        ldiu      @CL31,r0
        push      r0
        ldiu      @CL30,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	23
;----------------------------------------------------------------------
; 144 | strcpy(&m_Variable.LIC_VerList[8][0],"SDI2");                          
;----------------------------------------------------------------------
        ldiu      @CL33,r0
        push      r0
        ldiu      @CL32,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	24
;----------------------------------------------------------------------
; 145 | strcpy(&m_Variable.LIC_VerList[9][0],"SDI3");                          
;----------------------------------------------------------------------
        ldiu      @CL35,r0
        ldiu      @CL34,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	25
;----------------------------------------------------------------------
; 146 | strcpy(&m_Variable.LIC_VerList[10][0],"SDI4");                         
;----------------------------------------------------------------------
        ldiu      @CL37,r0
        ldiu      @CL36,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	26
;----------------------------------------------------------------------
; 147 | strcpy(&m_Variable.LIC_VerList[11][0],"PII1");                         
;----------------------------------------------------------------------
        ldiu      @CL39,r0
        ldiu      @CL38,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	27
;----------------------------------------------------------------------
; 148 | strcpy(&m_Variable.LIC_VerList[12][0],"PII2");                         
;----------------------------------------------------------------------
        ldiu      @CL41,r0
        push      r0
        ldiu      @CL40,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	28
;----------------------------------------------------------------------
; 149 | strcpy(&m_Variable.LIC_VerList[13][0],"VRX1");                         
;----------------------------------------------------------------------
        ldiu      @CL43,r0
        ldiu      @CL42,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	29
;----------------------------------------------------------------------
; 150 | strcpy(&m_Variable.LIC_VerList[14][0],"VRX2");                         
;----------------------------------------------------------------------
        ldiu      @CL45,r0
        push      r0
        ldiu      @CL44,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	30
;----------------------------------------------------------------------
; 151 | strcpy(&m_Variable.LIC_VerList[15][0],"VRX3");                         
;----------------------------------------------------------------------
        ldiu      @CL47,r0
        ldiu      @CL46,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	31
;----------------------------------------------------------------------
; 152 | strcpy(&m_Variable.LIC_VerList[16][0],"VRX4");                         
;----------------------------------------------------------------------
        ldiu      @CL49,r0
        ldiu      @CL48,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	32
;----------------------------------------------------------------------
; 153 | strcpy(&m_Variable.LIC_VerList[17][0],"VRX5");                         
;----------------------------------------------------------------------
        ldiu      @CL51,r0
        push      r0
        ldiu      @CL50,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	33
;----------------------------------------------------------------------
; 154 | strcpy(&m_Variable.LIC_VerList[18][0],"CRA-MAIN");                     
;----------------------------------------------------------------------
        ldiu      @CL53,r0
        push      r0
        ldiu      @CL52,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	34
;----------------------------------------------------------------------
; 155 | strcpy(&m_Variable.LIC_VerList[19][0],"CRA-LAUN");                     
;----------------------------------------------------------------------
        ldiu      @CL55,r0
        push      r0
        ldiu      @CL54,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	35
;----------------------------------------------------------------------
; 156 | strcpy(&m_Variable.LIC_VerList[20][0],"CRA-UP");                       
;----------------------------------------------------------------------
        ldiu      @CL57,r0
        ldiu      @CL56,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	36
;----------------------------------------------------------------------
; 157 | strcpy(&m_Variable.LIC_VerList[21][0],"CRA-PP");                       
;----------------------------------------------------------------------
        ldiu      @CL59,r0
        ldiu      @CL58,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	37
;----------------------------------------------------------------------
; 158 | strcpy(&m_Variable.LIC_VerList[22][0],"CRA-SP");                       
;----------------------------------------------------------------------
        ldiu      @CL61,r0
        ldiu      @CL60,r1
        push      r0
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	38
;----------------------------------------------------------------------
; 159 | strcpy(&m_Variable.LIC_VerList[23][0],"CRA-FTP");                      
;----------------------------------------------------------------------
        ldiu      @CL63,r0
        push      r0
        ldiu      @CL62,r1
        push      r1
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	39
;----------------------------------------------------------------------
; 160 | strcpy(&m_Variable.LIC_VerList[24][0],"CRA-CDT");                      
;----------------------------------------------------------------------
        ldiu      @CL64,r0
        ldiu      @CL65,r1
        push      r1
        push      r0
        call      _strcpy
                                        ; Call Occurs
        subi      2,sp
	.line	40
;----------------------------------------------------------------------
; 161 | m_Variable.LIC_VerList[25][0] = NULL;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+225
	.line	42
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      2,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	163,000000000h,0


	.sect	 ".text"

	.global	_user_Loop
	.sym	_user_Loop,_user_Loop,32,2,0
	.func	167
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
; 167 | void user_Loop()                                                       
; 169 | int i;                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	5
;----------------------------------------------------------------------
; 171 | LonWorkLoop();                                                         
;----------------------------------------------------------------------
        call      _LonWorkLoop
                                        ; Call Occurs
	.line	7
;----------------------------------------------------------------------
; 173 | DebugLoop();                                                           
;----------------------------------------------------------------------
        call      _DebugLoop
                                        ; Call Occurs
	.line	9
;----------------------------------------------------------------------
; 175 | user_WithCncsRs232Loop();                                              
;----------------------------------------------------------------------
        call      _user_WithCncsRs232Loop
                                        ; Call Occurs
	.line	11
;----------------------------------------------------------------------
; 177 | user_WithPacRs485Loop();                                               
;----------------------------------------------------------------------
        call      _user_WithPacRs485Loop
                                        ; Call Occurs
	.line	13
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	179,000000000h,1



	.sect	".cinit"
	.field  	1,32
	.field  	_nRxPos$1+0,32
	.field  	0,32		; _nRxPos$1 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nOldUart3RxOneByteGapDelayTime$2+0,32
	.field  	0,32		; _nOldUart3RxOneByteGapDelayTime$2 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_user_Lic2LicLoop
	.sym	_user_Lic2LicLoop,_user_Lic2LicLoop,32,2,0
	.func	185
;******************************************************************************
;* FUNCTION NAME: _user_Lic2LicLoop                                           *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,fp,ir0,sp,st                           *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 258 Auto + 0 SOE = 260 words      *
;******************************************************************************
_user_Lic2LicLoop:
	.bss	_nRxPos$1,1
	.sym	_nRxPos,_nRxPos$1,4,3,32
	.bss	_nOldUart3RxOneByteGapDelayTime$2,1
	.sym	_nOldUart3RxOneByteGapDelayTime,_nOldUart3RxOneByteGapDelayTime$2,12,3,32
	.bss	_btRx3chBuf$3,256
	.sym	_btRx3chBuf,_btRx3chBuf$3,60,3,8192,,256
	.sym	_nTxPos,1,4,1,32
	.sym	_btBuf,2,60,1,4096,,128
	.sym	_btTxBuf,130,60,1,4096,,128
	.sym	_nRxLen,258,4,1,32
	.line	1
;----------------------------------------------------------------------
; 185 | void user_Lic2LicLoop()                                                
; 187 | int nTxPos;                                                            
; 188 | UCHAR btBuf[128];                                                      
; 189 | UCHAR btTxBuf[128];                                                    
; 190 | int nRxLen;                                                            
; 191 | static int nRxPos = 0;                                                 
; 192 | static UCHAR nOldUart3RxOneByteGapDelayTime = 0;                       
; 193 | static UCHAR btRx3chBuf[256];                                          
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      258,sp
	.line	11
;----------------------------------------------------------------------
; 195 | m_Variable.m_bCiFaultFlag = m_Variable.m_btCttSignalA.BIT.Ci_CutOff ? T
;     | RUE : FALSE;                                                           
;----------------------------------------------------------------------
        ldiu      16,r0
        tstb      @_m_Variable+424,r0
        beq       L40
;*      Branch Occurs to L40 
        bud       L41
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L41 
L40:        
        ldiu      0,r0
L41:        
        sti       r0,@_m_Variable+431
	.line	13
;----------------------------------------------------------------------
; 197 | if(m_Variable.m_nCarPos >= 1 && m_Variable.m_nCarPos <= 8) m_Variable.m
;     | _btCiFaultVal = MASKBIT(m_Variable.m_bCiFaultFlag,m_Variable.m_nCarPos-
;     | 1);                                                                    
; 199 | // Àü¼ÛÇÏ±â                                                            
;----------------------------------------------------------------------
        ldi       @_m_Variable+338,r0
        ble       L44
;*      Branch Occurs to L44 
        cmpi      8,r0
        bgt       L44
;*      Branch Occurs to L44 
        ldiu      1,r0
        ldiu      1,r1
        and       @_m_Variable+431,r0
        subri     @_m_Variable+338,r1
        ash3      r1,r0,r0
        sti       r0,@_m_Variable+339
L44:        
	.line	16
;----------------------------------------------------------------------
; 200 | if(m_Variable.m_nTest1msTimer > 100) // 100ms ÀÌÈÄ¿¡´Â Áö¼ÓÀûÀ¸·Î A ->
;     | B ·Î Àü¼Û ÇÑ´Ù.                                                        
;----------------------------------------------------------------------
        ldiu      @_m_Variable+292,r0
        cmpi      100,r0
        bls       L47
;*      Branch Occurs to L47 
	.line	18
;----------------------------------------------------------------------
; 202 | m_Variable.m_nTest1msTimer = 0;                                        
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+292
	.line	20
;----------------------------------------------------------------------
; 204 | if(m_Variable.m_chCarKind == 'A')                                      
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        cmpi      65,r0
        bne       L47
;*      Branch Occurs to L47 
	.line	22
;----------------------------------------------------------------------
; 206 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	23
;----------------------------------------------------------------------
; 207 | btTxBuf[nTxPos++] = 0x02;                                              
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      2,r1
        ldiu      r0,ir0
        addi      130,ar0
        ldiu      1,r0
        addi      ir0,r0
        sti       r0,*+fp(1)
        sti       r1,*+ar0(ir0)
	.line	24
;----------------------------------------------------------------------
; 208 | btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;                         
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      1,r0
        addi      130,ar0
        ldiu      *+fp(1),ir0
        ldiu      @_m_Variable+339,r1
        addi      ir0,r0
        sti       r0,*+fp(1)
        sti       r1,*+ar0(ir0)
	.line	25
;----------------------------------------------------------------------
; 209 | btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;                         
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(1),ir0
        ldiu      fp,ar0
        addi      ir0,r0
        sti       r0,*+fp(1)
        addi      130,ar0
        ldiu      @_m_Variable+339,r1
        sti       r1,*+ar0(ir0)
	.line	26
;----------------------------------------------------------------------
; 210 | btTxBuf[nTxPos++] = 0x03;                                              
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(1),ir0
        ldiu      fp,ar0
        addi      ir0,r0
        addi      130,ar0
        ldiu      3,r1
        sti       r0,*+fp(1)
        sti       r1,*+ar0(ir0)
	.line	28
;----------------------------------------------------------------------
; 212 | xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)btTxBuf,nTxPos,1);   
; 216 | // ¼ö½Å ¹Þ±â                                                           
;----------------------------------------------------------------------
        ldiu      2,r2
        ldiu      1,r1
        push      r1
        ldiu      *+fp(1),r1
        push      r1
        ldiu      fp,r0
        addi      130,r0
        push      r0
        push      r2
        call      _xr16l784_RtsDelayStartSend
                                        ; Call Occurs
        subi      4,sp
L47:        
	.line	33
;----------------------------------------------------------------------
; 217 | nRxLen = user_PacRx(btBuf,128);                                        
;----------------------------------------------------------------------
        ldiu      128,r1
        ldiu      fp,r0
        push      r1
        addi      2,r0
        push      r0
        call      _user_PacRx
                                        ; Call Occurs
        ldiu      258,ir0
        subi      2,sp
        sti       r0,*+fp(ir0)
	.line	34
;----------------------------------------------------------------------
; 218 | if(nRxLen)                                                             
;----------------------------------------------------------------------
        ldi       *+fp(ir0),r0
        beq       L52
;*      Branch Occurs to L52 
	.line	36
;----------------------------------------------------------------------
; 220 | if(!m_Variable.m_nUart3RxOneByteGapDelayTime) nRxPos = 0;              
;----------------------------------------------------------------------
        ldi       @_m_Variable+290,r0
        bne       L50
;*      Branch Occurs to L50 
        ldiu      0,r0
        sti       r0,@_nRxPos$1+0
L50:        
	.line	37
;----------------------------------------------------------------------
; 221 | nOldUart3RxOneByteGapDelayTime = m_Variable.m_nUart3RxOneByteGapDelayTi
;     | me = 10;                                                               
;----------------------------------------------------------------------
        ldiu      10,r0
        sti       r0,@_m_Variable+290
        sti       r0,@_nOldUart3RxOneByteGapDelayTime$2+0
	.line	39
;----------------------------------------------------------------------
; 223 | if(nRxPos + nRxLen < 250)                                              
;----------------------------------------------------------------------
        ldiu      258,ir0
        ldiu      *+fp(ir0),r0
        addi      @_nRxPos$1+0,r0
        cmpi      250,r0
        bge       L52
;*      Branch Occurs to L52 
	.line	41
;----------------------------------------------------------------------
; 225 | memcpy(&btRx3chBuf[nRxPos],btBuf,nRxLen);                              
;----------------------------------------------------------------------
        ldiu      @CL66,r0
        ldiu      fp,r2
        ldiu      *+fp(ir0),r1
        addi      @_nRxPos$1+0,r0       ; Unsigned
        addi      2,r2
        push      r1
        push      r2
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	42
;----------------------------------------------------------------------
; 226 | nRxPos += nRxLen;                                                      
;----------------------------------------------------------------------
        ldiu      258,ir0
        ldiu      *+fp(ir0),r0
        addi      @_nRxPos$1+0,r0
        sti       r0,@_nRxPos$1+0
L52:        
	.line	46
;----------------------------------------------------------------------
; 230 | if(nOldUart3RxOneByteGapDelayTime && !m_Variable.m_nUart3RxOneByteGapDe
;     | layTime)                                                               
;----------------------------------------------------------------------
        ldi       @_nOldUart3RxOneByteGapDelayTime$2+0,r0
        beq       L60
;*      Branch Occurs to L60 
        ldi       @_m_Variable+290,r0
        bne       L60
;*      Branch Occurs to L60 
	.line	48
;----------------------------------------------------------------------
; 232 | if(nRxPos >= 4)                                                        
;----------------------------------------------------------------------
        ldiu      @_nRxPos$1+0,r0
        cmpi      4,r0
        blt       L59
;*      Branch Occurs to L59 
	.line	50
;----------------------------------------------------------------------
; 234 | if(btRx3chBuf[0] == 0x02 && btRx3chBuf[3] == 0x03 && btRx3chBuf[1] == b
;     | tRx3chBuf[2])                                                          
;----------------------------------------------------------------------
        ldiu      @_btRx3chBuf$3+0,r0
        cmpi      2,r0
        bne       L59
;*      Branch Occurs to L59 
        ldiu      @_btRx3chBuf$3+3,r0
        cmpi      3,r0
        bne       L59
;*      Branch Occurs to L59 
        ldiu      @_btRx3chBuf$3+1,r0
        cmpi      @_btRx3chBuf$3+2,r0
        bne       L59
;*      Branch Occurs to L59 
	.line	52
;----------------------------------------------------------------------
; 236 | m_Variable.m_btTestOtherCiFault = btRx3chBuf[1];                       
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+430
	.line	54
;----------------------------------------------------------------------
; 238 | nTxPos = 0;                                                            
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	55
;----------------------------------------------------------------------
; 239 | btTxBuf[nTxPos++] = 0x02;                                              
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      1,r1
        addi      130,ar0
        ldiu      r0,ir0
        addi      ir0,r1
        ldiu      2,r0
        sti       r1,*+fp(1)
        sti       r0,*+ar0(ir0)
	.line	56
;----------------------------------------------------------------------
; 240 | btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;                         
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      1,r1
        ldiu      *+fp(1),ir0
        addi      130,ar0
        addi      ir0,r1
        ldiu      @_m_Variable+339,r0
        sti       r1,*+fp(1)
        sti       r0,*+ar0(ir0)
	.line	57
;----------------------------------------------------------------------
; 241 | btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;                         
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      1,r1
        ldiu      *+fp(1),ir0
        addi      130,ar0
        addi      ir0,r1
        sti       r1,*+fp(1)
        ldiu      @_m_Variable+339,r0
        sti       r0,*+ar0(ir0)
	.line	58
;----------------------------------------------------------------------
; 242 | btTxBuf[nTxPos++] = 0x03;                                              
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *+fp(1),ir0
        addi      ir0,r1
        ldiu      3,r0
        ldiu      fp,ar0
        addi      130,ar0
        sti       r1,*+fp(1)
        sti       r0,*+ar0(ir0)
	.line	60
;----------------------------------------------------------------------
; 244 | xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)btTxBuf,nTxPos,10);  
;----------------------------------------------------------------------
        ldiu      10,r2
        push      r2
        ldiu      *+fp(1),r2
        push      r2
        ldiu      fp,r0
        addi      130,r0
        push      r0
        ldiu      2,r1
        push      r1
        call      _xr16l784_RtsDelayStartSend
                                        ; Call Occurs
        subi      4,sp
L59:        
	.line	64
;----------------------------------------------------------------------
; 248 | nOldUart3RxOneByteGapDelayTime = m_Variable.m_nUart3RxOneByteGapDelayTi
;     | me;                                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+290,r0
        sti       r0,@_nOldUart3RxOneByteGapDelayTime$2+0
L60:        
	.line	66
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      260,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	250,000000000h,258


	.sect	 ".text"

	.global	_user_IsSingleOrMarried
	.sym	_user_IsSingleOrMarried,_user_IsSingleOrMarried,36,2,0
	.func	261
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
; 261 | int user_IsSingleOrMarried()                                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 263 | return 1;                                                              
;----------------------------------------------------------------------
        ldiu      1,r0
	.line	4
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	264,000000000h,0


	.sect	 ".text"

	.global	_user_DebugRx
	.sym	_user_DebugRx,_user_DebugRx,36,2,0
	.func	269
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
; 269 | int user_DebugRx(UCHAR *pBuf,int nRxBuffLen)                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 271 | return xr16l784_GetRxBuffer1Ch(pBuf,nRxBuffLen);                       
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
	.endfunc	272,000000000h,0


	.sect	 ".text"

	.global	_user_DebugPrint
	.sym	_user_DebugPrint,_user_DebugPrint,32,2,0
	.func	274
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
; 274 | void user_DebugPrint(char *pTxBuf)                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 276 | xr16l784_Send(XR16L784_1CHL,(UCHAR *)pTxBuf,strlen(pTxBuf));           
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
	.endfunc	277,000000000h,0


	.sect	 ".text"

	.global	_user_CncsRx
	.sym	_user_CncsRx,_user_CncsRx,36,2,0
	.func	280
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
; 280 | int user_CncsRx(UCHAR *pBuf,int nRxBuffLen)                            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 282 | return xr16l784_GetRxBuffer2Ch(pBuf,nRxBuffLen);                       
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
	.endfunc	283,000000000h,0


	.sect	 ".text"

	.global	_user_CncsTx
	.sym	_user_CncsTx,_user_CncsTx,32,2,0
	.func	285
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
; 285 | void user_CncsTx(UCHAR *pTxBuf,int nTxLen)                             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 287 | xr16l784_RtsDelayStartSend(XR16L784_2CHL,(UCHAR *)pTxBuf,nTxLen,10);   
; 288 | //xr16l784_Send(XR16L784_2CHL,(UCHAR *)pTxBuf,nTxLen);                 
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
	.endfunc	289,000000000h,0


	.sect	 ".text"

	.global	_user_PacRx
	.sym	_user_PacRx,_user_PacRx,36,2,0
	.func	293
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
; 293 | int user_PacRx(UCHAR *pBuf,int nRxBuffLen)                             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 295 | return xr16l784_GetRxBuffer3Ch(pBuf,nRxBuffLen);                       
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
	.endfunc	296,000000000h,0


	.sect	 ".text"

	.global	_user_PacTx
	.sym	_user_PacTx,_user_PacTx,32,2,0
	.func	298
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
; 298 | void user_PacTx(UCHAR *pTxBuf,int nTxLen)                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 300 | xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)pTxBuf,nTxLen,10);   
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
	.endfunc	301,000000000h,0


	.sect	 ".text"

	.global	_BitSwap
	.sym	_BitSwap,_BitSwap,44,2,0
	.func	308
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
; 308 | UCHAR BitSwap(UCHAR btDat)                                             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 310 | UCHAR btBuf = 0x00;                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 312 | btBuf |= MASKBIT(btDat&0x01?1:0,7);                                    
;----------------------------------------------------------------------
        ldiu      1,r0
        tstb      *-fp(2),r0
        beq       L85
;*      Branch Occurs to L85 
        bu        L86
;*      Branch Occurs to L86 
L85:        
        ldiu      0,r0
L86:        
        and       1,r0
        ash       7,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	6
;----------------------------------------------------------------------
; 313 | btBuf |= MASKBIT(btDat&0x02?1:0,6);                                    
;----------------------------------------------------------------------
        ldiu      2,r0
        tstb      *-fp(2),r0
        beq       L88
;*      Branch Occurs to L88 
        bud       L89
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L89 
L88:        
        ldiu      0,r0
L89:        
        and       1,r0
        ash       6,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	7
;----------------------------------------------------------------------
; 314 | btBuf |= MASKBIT(btDat&0x04?1:0,5);                                    
;----------------------------------------------------------------------
        ldiu      4,r0
        tstb      *-fp(2),r0
        beq       L91
;*      Branch Occurs to L91 
        bud       L92
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L92 
L91:        
        ldiu      0,r0
L92:        
        and       1,r0
        ash       5,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	8
;----------------------------------------------------------------------
; 315 | btBuf |= MASKBIT(btDat&0x08?1:0,4);                                    
;----------------------------------------------------------------------
        ldiu      8,r0
        tstb      *-fp(2),r0
        beq       L94
;*      Branch Occurs to L94 
        bud       L95
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L95 
L94:        
        ldiu      0,r0
L95:        
        and       1,r0
        ash       4,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	9
;----------------------------------------------------------------------
; 316 | btBuf |= MASKBIT(btDat&0x10?1:0,3);                                    
;----------------------------------------------------------------------
        ldiu      16,r0
        tstb      *-fp(2),r0
        beq       L97
;*      Branch Occurs to L97 
        bud       L98
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L98 
L97:        
        ldiu      0,r0
L98:        
        and       1,r0
        ash       3,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 317 | btBuf |= MASKBIT(btDat&0x20?1:0,2);                                    
;----------------------------------------------------------------------
        ldiu      32,r0
        tstb      *-fp(2),r0
        beq       L100
;*      Branch Occurs to L100 
        bud       L101
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L101 
L100:        
        ldiu      0,r0
L101:        
        and       1,r0
        ash       2,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	11
;----------------------------------------------------------------------
; 318 | btBuf |= MASKBIT(btDat&0x40?1:0,1);                                    
;----------------------------------------------------------------------
        ldiu      64,r0
        tstb      *-fp(2),r0
        beq       L103
;*      Branch Occurs to L103 
        bud       L104
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L104 
L103:        
        ldiu      0,r0
L104:        
        and       1,r0
        ash       1,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	12
;----------------------------------------------------------------------
; 319 | btBuf |= MASKBIT(btDat&0x80?1:0,0);                                    
;----------------------------------------------------------------------
        ldiu      128,r0
        tstb      *-fp(2),r0
        beq       L106
;*      Branch Occurs to L106 
        bud       L107
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L107 
L106:        
        ldiu      0,r0
L107:        
        and       1,r0
        or        *+fp(1),r0
        sti       r0,*+fp(1)
	.line	14
;----------------------------------------------------------------------
; 321 | return btBuf;                                                          
;----------------------------------------------------------------------
	.line	15
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	322,000000000h,1



	.sect	".cinit"
	.field  	1,32
	.field  	_nRxPos$4+0,32
	.field  	0,32		; _nRxPos$4 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nOldUart2RxOneByteGapDelayTime$5+0,32
	.field  	0,32		; _nOldUart2RxOneByteGapDelayTime$5 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nTimeSendCnt$8+0,32
	.field  	0,32		; _nTimeSendCnt$8 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_user_WithCncsRs232Loop
	.sym	_user_WithCncsRs232Loop,_user_WithCncsRs232Loop,32,2,0
	.func	327
;******************************************************************************
;* FUNCTION NAME: _user_WithCncsRs232Loop                                     *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r3,r4,r5,ar0,ar1,fp,ir0,ir1,sp,st          *
;*   Regs Saved         : r4,r5                                               *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 988 Auto + 2 SOE = 992 words      *
;******************************************************************************
_user_WithCncsRs232Loop:
	.bss	_nRxPos$4,1
	.sym	_nRxPos,_nRxPos$4,4,3,32
	.bss	_nOldUart2RxOneByteGapDelayTime$5,1
	.sym	_nOldUart2RxOneByteGapDelayTime,_nOldUart2RxOneByteGapDelayTime$5,12,3,32
	.bss	_btRx2chBuf$6,512
	.sym	_btRx2chBuf,_btRx2chBuf$6,60,3,16384,,512
	.bss	_btTx2chBuf$7,512
	.sym	_btTx2chBuf,_btTx2chBuf$7,60,3,16384,,512
	.bss	_nTimeSendCnt$8,1
	.sym	_nTimeSendCnt,_nTimeSendCnt$8,4,3,32
	.sym	_i,1,4,1,32
	.sym	_nRxLen,2,4,1,32
	.sym	_btBuf,3,60,1,8192,,256
	.sym	_sTimeBuf,259,60,1,320,,10
	.sym	_sPotoLen,269,4,1,32
	.sym	_sBcc,270,12,1,32
	.sym	_LL,271,12,1,32
	.sym	_LH,272,12,1,32
	.sym	_HL,273,12,1,32
	.sym	_HH,274,12,1,32
	.sym	_nBlkSize,275,4,1,32
	.sym	_nTempBlkEnd,276,4,1,32
	.sym	_sTxDataSize,277,4,1,32
	.sym	_btTxBuf,278,60,1,4096,,128
	.sym	_szBuf,406,50,1,16384,,512
	.sym	_szBuf2,918,50,1,2048,,64
	.sym	_pNvsram,982,28,1,32
	.sym	_pLicVerDp,983,24,1,32,.fake44
	.sym	_pLic_Cncs,984,24,1,32,.fake42
	.sym	_pCncsLicSd,985,24,1,32,.fake45
	.sym	_pCnsc_Lic_T_F,986,24,1,32,.fake46
	.sym	_pCncs_Lic_T_F_C,987,24,1,32,.fake47
	.sym	_pInfo,988,24,1,32,.fake68
	.line	1
;----------------------------------------------------------------------
; 327 | void user_WithCncsRs232Loop()                                          
; 329 | int i;                                                                 
; 330 | int nRxLen;                                                            
; 331 | UCHAR btBuf[256]; //¼ö½Å ·¹Áö½ºÆ®¿¡¼­ ÀÐ¾î ¿À´Â º¯¼ö                   
; 332 | UCHAR sTimeBuf[10];//½Ã°£ Àü¼Û ¹öÆÛ.                                   
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      988,sp
        push      r4
        push      r5
	.line	7
;----------------------------------------------------------------------
; 333 | int sPotoLen = 0; //ºí·® ÆÐÅ¶ Index.                                   
;----------------------------------------------------------------------
        ldiu      269,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	8
;----------------------------------------------------------------------
; 334 | UCHAR sBcc = 0;                                                        
; 335 | static int nRxPos = 0; //¼ö½Å Ä«¿îÅÍ.                                  
; 336 | static UCHAR nOldUart2RxOneByteGapDelayTime = 0; //10ms ÀÌ»ó ¼ö½ÅÀÌ ¾Êµ
;     | Ç¸é ¼ö½Å Ã³¸® ÇÑ´Ù.                                                    
; 337 | static UCHAR btRx2chBuf[512]; //¼ö½Å ¹öÆÛ                              
; 338 | static UCHAR btTx2chBuf[512]; //Àü¼Û ¹öÆÛ.                             
; 339 | static int nTimeSendCnt = 0;                                           
; 340 | UCHAR LL,LH,HL,HH;                                                     
;----------------------------------------------------------------------
        ldiu      270,ir0
        sti       r0,*+fp(ir0)
	.line	16
;----------------------------------------------------------------------
; 342 | int nBlkSize = 0;                                                      
;----------------------------------------------------------------------
        ldiu      275,ir0
        sti       r0,*+fp(ir0)
	.line	17
;----------------------------------------------------------------------
; 343 | int nTempBlkEnd = 0;                                                   
;----------------------------------------------------------------------
        ldiu      276,ir0
        sti       r0,*+fp(ir0)
	.line	18
;----------------------------------------------------------------------
; 344 | int sTxDataSize = 0; //¼ö½Å¾Æ µ¥ÀÌÅ¸ size¸¦ ºñ·á ÇÏ¿© 128ÀÌ¸í Áß°£ ÀÛÀ¸
;     | ¸é ¸¶Áö¸· ÇÁ·¹ÀÓ ÀÌ´Ù.                                                 
; 346 | UCHAR btTxBuf[128];                                                    
; 347 | char szBuf[512];                                                       
; 348 | char szBuf2[64];                                                       
;----------------------------------------------------------------------
        ldiu      277,ir0
        sti       r0,*+fp(ir0)
	.line	25
;----------------------------------------------------------------------
; 351 | UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;                                 
;----------------------------------------------------------------------
        ldiu      982,ir0
        ldiu      @CL67,r0
        sti       r0,*+fp(ir0)
	.line	27
;----------------------------------------------------------------------
; 353 | PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //¹öÀü Á¤º¸ Ã³¸
;     | ®¸¦ À§ÇØ ÀÓÀÇ·Î ¸¸µé¾ú´Ù.                                              
; 354 | PLIC_CNCS_HD pLic_Cncs;                                                
; 355 | PCNCS_LIC_SD pCncsLicSd;                                               
; 357 | PCNCS_LIC_T_F pCnsc_Lic_T_F;                                           
;----------------------------------------------------------------------
        ldiu      983,ir0
        ldiu      @CL2,r0
        sti       r0,*+fp(ir0)
	.line	32
;----------------------------------------------------------------------
; 358 | PCNCS_LIC_T_F_C pCncs_Lic_T_F_C = (CNCS_LIC_T_F_C *) btRx2chBuf;
;     |                          // °íÀå ÆÐÅ¶ Àü¼Û ¿Ï·á È®ÀÎ ÇÁ·ÎÅäÄÝ Ãß°¡(Y.J 
;     | 2011-05-10)                                                            
; 360 | // Fault Block Information;                                            
;----------------------------------------------------------------------
        ldiu      987,ir0
        ldiu      @CL68,r0
        sti       r0,*+fp(ir0)
	.line	35
;----------------------------------------------------------------------
; 361 | PFAULT_INFO pInfo = NULL;                                              
; 363 | // ¼ö½Å                                                                
;----------------------------------------------------------------------
        ldiu      988,ir0
        ldiu      0,r0
        sti       r0,*+fp(ir0)
	.line	38
;----------------------------------------------------------------------
; 364 | nRxLen = user_CncsRx(btBuf,128);                                       
;----------------------------------------------------------------------
        ldiu      128,r1
        ldiu      fp,r0
        push      r1
        addi      3,r0
        push      r0
        call      _user_CncsRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(2)
	.line	39
;----------------------------------------------------------------------
; 365 | if(nRxLen)                                                             
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L115
;*      Branch Occurs to L115 
	.line	41
;----------------------------------------------------------------------
; 367 | if(!m_Variable.m_nUart2RxOneByteGapDelayTime) nRxPos = 0;              
;----------------------------------------------------------------------
        ldi       @_m_Variable+289,r0
        bne       L113
;*      Branch Occurs to L113 
        ldiu      0,r0
        sti       r0,@_nRxPos$4+0
L113:        
	.line	42
;----------------------------------------------------------------------
; 368 | m_Variable.m_nUart2RxOneByteGapDelayTime = 10;                         
;----------------------------------------------------------------------
        ldiu      10,r0
        sti       r0,@_m_Variable+289
	.line	44
;----------------------------------------------------------------------
; 370 | if(nRxPos + nRxLen < 511)                                              
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$4+0,r0
        cmpi      511,r0
        bged      L115
        ldilt     @CL68,r0
        ldilt     fp,r1
        ldilt     *+fp(2),r2
;*      Branch Occurs to L115 
	.line	46
;----------------------------------------------------------------------
; 372 | memcpy(&btRx2chBuf[nRxPos],btBuf,nRxLen);                              
;----------------------------------------------------------------------
        addi      @_nRxPos$4+0,r0       ; Unsigned
        addi      3,r1
        push      r2
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	47
;----------------------------------------------------------------------
; 373 | nRxPos += nRxLen;                                                      
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$4+0,r0
        sti       r0,@_nRxPos$4+0
L115:        
	.line	51
;----------------------------------------------------------------------
; 377 | if(nOldUart2RxOneByteGapDelayTime && !m_Variable.m_nUart2RxOneByteGapDe
;     | layTime)                                                               
;----------------------------------------------------------------------
        ldi       @_nOldUart2RxOneByteGapDelayTime$5+0,r0
        beq       L155
;*      Branch Occurs to L155 
        ldi       @_m_Variable+289,r0
        bne       L155
;*      Branch Occurs to L155 
	.line	53
;----------------------------------------------------------------------
; 379 | pCncsLicSd = (CNCS_LIC_SD *)btRx2chBuf;                                
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      @CL68,r0
        sti       r0,*+fp(ir0)
	.line	55
;----------------------------------------------------------------------
; 381 | pCnsc_Lic_T_F = (CNCS_LIC_T_F *) btRx2chBuf;                           
;----------------------------------------------------------------------
        ldiu      986,ir0
        sti       r0,*+fp(ir0)
	.line	57
;----------------------------------------------------------------------
; 383 | if(pCncsLicSd->phHdBuf.btSoh == SOH &&                                 
; 384 |    pCncsLicSd->btEot == EOT &&                                         
; 385 |    sizeof(CNCS_LIC_SD) == nRxPos &&                                    
; 386 |    (TWOBYTE_ASC2HEX(pCncsLicSd->phHdBuf.chDestDev) == 0x11) &&         
; 387 |    (TWOBYTE_ASC2HEX(pCncsLicSd->sCommand) == 0x09) &&  //CNCS°¡ ½Ã°£ ÀÀ
;     | ´ä                                                                     
; 388 |    !((Make1ByteBcc(&pCncsLicSd->phHdBuf.chSrcDev[0],nRxPos-4)^(TWOBYTE_
;     | ASC2HEX(pCncsLicSd->chChkSum)))))                                      
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *ar0,r0
        cmpi      1,r0
        bne       L135
;*      Branch Occurs to L135 
        ldiu      *+fp(ir0),ir0
        ldiu      473,ar0
        ldiu      *+ar0(ir0),r0
        cmpi      4,r0
        bne       L135
;*      Branch Occurs to L135 
        ldiu      474,r0
        cmpi      @_nRxPos$4+0,r0
        bne       L135
;*      Branch Occurs to L135 
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(3),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        cmpi      17,r0
        subi      1,sp
        bne       L135
;*      Branch Occurs to L135 
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(15),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        bne       L135
;*      Branch Occurs to L135 
        ldiu      1,r1
        ldiu      985,ir0
        ldiu      4,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$4+0,r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        ldiu      985,ir0
        subi      2,sp
        ldiu      471,ar0
        ldiu      *+fp(ir0),ir0
        ldiu      *+ar0(ir0),r1
        ldiu      r0,r5
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      985,ir0
        ldiu      472,ar0
        ldiu      *+fp(ir0),ir0
        ldiu      *+ar0(ir0),r1
        ldiu      r0,r4
        ash       4,r4
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        xor3      r5,r0,r0
        subi      1,sp
        bne       L135
;*      Branch Occurs to L135 
	.line	66
;----------------------------------------------------------------------
; 392 | m_Variable.m_tmCurTime.second = TWOBYTE_ASC2HEX(pCncsLicSd->sSecond);  
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(27),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        sti       r0,@_m_Variable+293
        subi      1,sp
	.line	67
;----------------------------------------------------------------------
; 393 | m_Variable.m_tmCurTime.minute = TWOBYTE_ASC2HEX(pCncsLicSd->sMinute);  
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(25),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(26),r1
        ldiu      r0,r4
        push      r1
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+294
        subi      1,sp
	.line	68
;----------------------------------------------------------------------
; 394 | m_Variable.m_tmCurTime.hour   = TWOBYTE_ASC2HEX(pCncsLicSd->sHour);    
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(23),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(24),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+295
        subi      1,sp
	.line	69
;----------------------------------------------------------------------
; 395 | m_Variable.m_tmCurTime.day    = TWOBYTE_ASC2HEX(pCncsLicSd->sDay);     
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(21),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(22),r1
        ldiu      r0,r4
        ash       4,r4
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+296
        subi      1,sp
	.line	70
;----------------------------------------------------------------------
; 396 | m_Variable.m_tmCurTime.month  = TWOBYTE_ASC2HEX(pCncsLicSd->sMonth);   
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(19),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(20),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+297
        subi      1,sp
	.line	71
;----------------------------------------------------------------------
; 397 | m_Variable.m_tmCurTime.year   = TWOBYTE_ASC2HEX(pCncsLicSd->sYear);    
; 399 | //memset(&m_Variable.m_tmUtcTime, 0x00, sizeof(DATE_TIME_TYPE));       
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(17),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        sti       r0,@_m_Variable+298
        subi      1,sp
	.line	75
;----------------------------------------------------------------------
; 401 | if(m_Variable.m_LIC_CNCS_TimSetFlag = GetLocalTimeToUTC(&m_Variable.m_t
;     | mCurTime, -5, &m_Variable.m_tmUtcTime))                                
;----------------------------------------------------------------------
        ldiu      @CL69,r2
        ldiu      @CL70,r1
        ldiu      -5,r0
        push      r2
        push      r0
        push      r1
        call      _GetLocalTimeToUTC
                                        ; Call Occurs
        cmpi      0,r0
        beqd      L126
	nop
        sti       r0,@_m_Variable+426
        subi      3,sp
;*      Branch Occurs to L126 
	.line	77
;----------------------------------------------------------------------
; 403 | m_Variable.m_tmUtcTime.year         = ConvDec2Hex(m_Variable.m_tmUtcTim
;     | e.year   );                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+305,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+305
        subi      1,sp
	.line	78
;----------------------------------------------------------------------
; 404 | m_Variable.m_tmUtcTime.month    = ConvDec2Hex(m_Variable.m_tmUtcTime.mo
;     | nth );                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+304,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+304
        subi      1,sp
	.line	79
;----------------------------------------------------------------------
; 405 | m_Variable.m_tmUtcTime.day          = ConvDec2Hex(m_Variable.m_tmUtcTim
;     | e.day    );                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+303,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+303
        subi      1,sp
	.line	80
;----------------------------------------------------------------------
; 406 | m_Variable.m_tmUtcTime.hour         = ConvDec2Hex(m_Variable.m_tmUtcTim
;     | e.hour   );                                                            
;----------------------------------------------------------------------
        ldiu      @_m_Variable+302,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+302
        subi      1,sp
	.line	81
;----------------------------------------------------------------------
; 407 | m_Variable.m_tmUtcTime.minute   = ConvDec2Hex(m_Variable.m_tmUtcTime.mi
;     | nute);                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+301,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+301
        subi      1,sp
	.line	82
;----------------------------------------------------------------------
; 408 | m_Variable.m_tmUtcTime.second   = ConvDec2Hex(m_Variable.m_tmUtcTime.se
;     | cond);                                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+300,r0
        push      r0
        call      _ConvDec2Hex
                                        ; Call Occurs
        sti       r0,@_m_Variable+300
        subi      1,sp
	.line	84
;----------------------------------------------------------------------
; 410 | m_Variable.m_nCncsRxCheck1msTimer = 2000;                              
;----------------------------------------------------------------------
        ldiu      2000,r0
        sti       r0,@_m_Variable+428
L126:        
	.line	88
;----------------------------------------------------------------------
; 414 | for(i=0;i<VER_BDD_MAX_CNT;i++)                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      32,r0
        bge       L131
;*      Branch Occurs to L131 
L127:        
	.line	90
;----------------------------------------------------------------------
; 416 | if(!MAKE_DWORD(0x00,m_Variable.m_tmUtcTime.year,m_Variable.m_tmUtcTime.
;     | month,m_Variable.m_tmUtcTime.day))                                     
;----------------------------------------------------------------------
        ldiu      255,r1
        ldiu      255,r0
        ldiu      255,r2
        and       @_m_Variable+305,r1
        and       @_m_Variable+304,r0
        and       @_m_Variable+303,r2
        ash       16,r1
        ash       8,r0
        or3       r1,r0,r0
        or3       r0,r2,r0
        bne       L130
;*      Branch Occurs to L130 
	.line	92
;----------------------------------------------------------------------
; 418 | pLicVerDp->VerCnt = FALSE;                                             
;----------------------------------------------------------------------
        ldiu      983,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	93
;----------------------------------------------------------------------
; 419 | memset(pLicVerDp->cvbBuf[i].chVer,'0',4);                              
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
	.line	94
;----------------------------------------------------------------------
; 420 | memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);                        
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      983,ir0
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
	.line	95
;----------------------------------------------------------------------
; 421 | break;                                                                 
; 423 | else                                                                   
;----------------------------------------------------------------------
        bu        L131
;*      Branch Occurs to L131 
L130:        
	.line	99
;----------------------------------------------------------------------
; 425 | pLicVerDp->VerCnt = TRUE;                                              
; 427 | // ¹öÀü ÀÔ·Â                                                           
;----------------------------------------------------------------------
        ldiu      983,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      1,r0
        sti       r0,*ar0
	.line	102
;----------------------------------------------------------------------
; 428 | pLicVerDp->cvbBuf[i].chVer[0] = '1';//pCncsLicSd->cvbBuf[i].chVer[0];  
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      49,r0
        sti       r0,*+ar0(1)
	.line	103
;----------------------------------------------------------------------
; 429 | pLicVerDp->cvbBuf[i].chVer[1] = '0';//pCncsLicSd->cvbBuf[i].chVer[1];  
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      48,r0
        sti       r0,*+ar0(2)
	.line	104
;----------------------------------------------------------------------
; 430 | pLicVerDp->cvbBuf[i].chVer[2] = '0';//pCncsLicSd->cvbBuf[i].chVer[2];  
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      48,r0
        sti       r0,*+ar0(3)
	.line	105
;----------------------------------------------------------------------
; 431 | pLicVerDp->cvbBuf[i].chVer[3] = '0';//pCncsLicSd->cvbBuf[i].chVer[3];  
; 434 | // ¸¸µé¾îÁø ³¯Â¥ ÀÔ·Â                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      48,r0
        sti       r0,*+ar0(4)
	.line	109
;----------------------------------------------------------------------
; 435 | pLicVerDp->cvbBuf[i].chBuildDate[0] = '1';//pCncsLicSd->cvbBuf[i].chBui
;     | ldDate[0];                                                             
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      49,r0
        sti       r0,*+ar0(5)
	.line	110
;----------------------------------------------------------------------
; 436 | pLicVerDp->cvbBuf[i].chBuildDate[1] = '2';//pCncsLicSd->cvbBuf[i].chBui
;     | ldDate[1];                                                             
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      50,r0
        sti       r0,*+ar0(6)
	.line	111
;----------------------------------------------------------------------
; 437 | pLicVerDp->cvbBuf[i].chBuildDate[2] = '0';//pCncsLicSd->cvbBuf[i].chBui
;     | ldDate[2];                                                             
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      48,r0
        sti       r0,*+ar0(7)
	.line	112
;----------------------------------------------------------------------
; 438 | pLicVerDp->cvbBuf[i].chBuildDate[3] = '6';//pCncsLicSd->cvbBuf[i].chBui
;     | ldDate[3];                                                             
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      54,r0
        sti       r0,*+ar0(8)
	.line	113
;----------------------------------------------------------------------
; 439 | pLicVerDp->cvbBuf[i].chBuildDate[4] = '2';//pCncsLicSd->cvbBuf[i].chBui
;     | ldDate[4];                                                             
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      50,r0
        sti       r0,*+ar0(9)
	.line	114
;----------------------------------------------------------------------
; 440 | pLicVerDp->cvbBuf[i].chBuildDate[5] = '6';//pCncsLicSd->cvbBuf[i].chBui
;     | ldDate[5];                                                             
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        mpyi      10,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      54,r0
        sti       r0,*+ar0(10)
	.line	88
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      32,r0
        blt       L127
;*      Branch Occurs to L127 
L131:        
	.line	120
;----------------------------------------------------------------------
; 446 | if(TWOBYTE_ASC2HEX(pCncsLicSd->sWaySide) == 0x01 && !m_Variable.m_LIC_C
;     | NCS_Tx_Flag) // wayside on ¾Ë¸²                                        
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(29),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        bne       L172
;*      Branch Occurs to L172 
        ldi       @_m_Variable+331,r0
        bne       L172
;*      Branch Occurs to L172 
	.line	122
;----------------------------------------------------------------------
; 448 | m_Variable.m_nCDT_FaultDataStFlag = 1;                                 
; 450 | //2011_03_03 ¼öÁ¤                                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+336
	.line	125
;----------------------------------------------------------------------
; 451 | m_Variable.m_nFaultCnt = 0;
;     |  // °íÀå °¹¼ö¸¦ 0À¸·Î ÃÊ±âÈ­.(Y.J Ãß°¡);                               
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+334
	.line	126
;----------------------------------------------------------------------
; 452 | memset((UCHAR *)NVSRAM_BASE,0x00,1024); // °íÀå ºí·°À» "0" À¸·Î ÃÊ½ÃÈ­
;     | ÇÑ´Ù. ÃÊ±â À§Ä¡ 0ºÎÅÍ 1024±îÁö¸¸ ÃÊ±âÈ­ ÇÑ´Ù.                          
;----------------------------------------------------------------------
        ldiu      1024,r2
        ldiu      @CL71,r1
        push      r2
        push      r0
        push      r1
        call      _memset
                                        ; Call Occurs
        subi      3,sp
	.line	127
;----------------------------------------------------------------------
; 453 | ClearFltBlkInfo();                                              // °íÀå
;     |  Á¤º¸¸¦ ClearÇÏ´Â ºÎºÐ.                                                
; 455 | //memset(aaa_FaultBlkList, 0xFF, 1024);                                
;----------------------------------------------------------------------
        call      _ClearFltBlkInfo
                                        ; Call Occurs
	.line	131
;----------------------------------------------------------------------
; 457 | m_Variable.m_nNvsramPos = 0;    //ÀüÃ¼ ±â·Ï ±¸Á¶ À§Ä¡¸¦ Ã³À½À¸·Î       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+347
	.line	132
;----------------------------------------------------------------------
; 458 | m_Variable.m_Recving_Posi = 0;  //ÇöÀç ±îÁö Àü¼ÛÇÑ À§Ä¡¸¦ Ã³À½À¸·Î     
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+335
	.line	133
;----------------------------------------------------------------------
; 459 | m_Variable.m_nLnWkTxFlag = 0;   //°íÀå ÄÚµå ±¸ºÐÀ» 0À¸·Î ÃÊ±âÈ­        
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+333
	.line	135
;----------------------------------------------------------------------
; 461 | m_Variable.m_nLnWkTxFlag = TWOBYTE_ASC2HEX(pCncsLicSd->sDaType);       
; 463 | // °íÀå ½Ã°£ ¿äÃ» WORD -> DWORD·Î º¯°æ.(2011.05.08)                    
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(31),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        sti       r0,@_m_Variable+333
	.line	138
;----------------------------------------------------------------------
; 464 | m_Variable.m_nDateTime2SecondCnt = MAKE_DWORD( MAKE_BYTE(ConvAsc2Hex(pC
;     | ncsLicSd->sFaultTime[0]),ConvAsc2Hex(pCncsLicSd->sFaultTime[1])),      
; 465 | 
;     |  MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[2]),ConvAsc2Hex(pCncsLicS
;     | d->sFaultTime[3])),                                                    
; 466 | 
;     |  MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[4]),ConvAsc2Hex(pCncsLicS
;     | d->sFaultTime[5])),                                                    
; 467 | 
;     |  MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[6]),ConvAsc2Hex(pCncsLicS
;     | d->sFaultTime[7])));                                                   
;----------------------------------------------------------------------
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(33),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(34),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(36),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
        and       15,r0
        or3       r4,r0,r1
        subi      1,sp
        and       255,r1
        ldiu      *+fp(ir0),ar0
        ash       16,r1
        ldiu      *+ar0(37),r0
        or3       r5,r1,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r5
        ldiu      *+ar0(38),r0
        ash       4,r5
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
        subi      1,sp
        and       15,r0
        or3       r5,r0,r1
        ldiu      *+fp(ir0),ar0
        and       255,r1
        ldiu      *+ar0(39),r0
        ash       8,r1
        or3       r4,r1,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
        ldiu      985,ir0
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
        sti       r0,@_m_Variable+349
        subi      1,sp
        bu        L172
;*      Branch Occurs to L172 
L135:        
	.line	146
;----------------------------------------------------------------------
; 472 | else if(pCncs_Lic_T_F_C->phHdBuf.btSoh == SOH &&
;     |                                                                        
;     |                                           		// °íÀå ½Ã°£ ¿äÃ» WORD -> D
;     | WORD·Î º¯°æ.(2011.05.11)                                               
; 473 |         pCncs_Lic_T_F_C->btEot == EOT &&                               
; 474 |         sizeof(CNCS_LIC_T_F_C) == nRxPos &&                            
; 475 |    (TWOBYTE_ASC2HEX(pCncs_Lic_T_F_C->phHdBuf.chDestDev) == 0x11) &&    
; 476 |    (TWOBYTE_ASC2HEX(pCncsLicSd->sCommand) == 0x07) &&  //°íÀå Àü¼Û È®ÀÎ
;     |  ÀÀ´ä(CNCS-> LIC)                                                      
; 477 |    !((Make1ByteBcc(&pCncs_Lic_T_F_C->phHdBuf.chSrcDev[0],nRxPos-4)^(TWO
;     | BYTE_ASC2HEX(pCncs_Lic_T_F_C->chChkSum)))))                            
; 479 |         // Y.J 2011-05-10 ¿äÃ»ÇÑ °íÀå Index¸¦ »ç¿ëÇÏ¿©, Àü¼ÛÇÏµµ·Ï ¼öÁ¤
;     | .                                                                      
;----------------------------------------------------------------------
        ldiu      987,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *ar0,r0
        cmpi      1,r0
        bne       L172
;*      Branch Occurs to L172 
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(23),r0
        cmpi      4,r0
        bne       L172
;*      Branch Occurs to L172 
        ldiu      24,r0
        cmpi      @_nRxPos$4+0,r0
        bne       L172
;*      Branch Occurs to L172 
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(3),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      987,ir0
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
        cmpi      17,r0
        subi      1,sp
        bne       L172
;*      Branch Occurs to L172 
        ldiu      985,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(15),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      985,ir0
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
        bne       L172
;*      Branch Occurs to L172 
        ldiu      1,r1
        ldiu      987,ir0
        ldiu      4,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$4+0,r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        ldiu      987,ir0
        subi      2,sp
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(21),r1
        ldiu      r0,r5
        push      r1
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      987,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(22),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        xor3      r5,r0,r0
        subi      1,sp
        bne       L172
;*      Branch Occurs to L172 
	.line	154
;----------------------------------------------------------------------
; 480 | sPotoLen = MAKE_WORD(MAKE_BYTE(ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[0]),Con
;     | vAsc2Hex(pCnsc_Lic_T_F->sTEXT[1])),                                    
; 481 |                      MAKE_BYTE(ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[2]),Con
;     | vAsc2Hex(pCnsc_Lic_T_F->sTEXT[3])));                                   
;----------------------------------------------------------------------
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(17),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(18),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      986,ir0
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
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(20),r0
        push      r0
        ash       4,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      269,ir0
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        subi      1,sp
        or3       r5,r0,r0
        and       65535,r0
        sti       r0,*+fp(ir0)
	.line	156
;----------------------------------------------------------------------
; 482 | if(sPotoLen)                                                           
; 484 |         // ÀçÀü¼ÛÇÒ °íÀå ºí·Ï Á¤º¸¸¦ ¾òÀ½.                             
;----------------------------------------------------------------------
        ldi       *+fp(ir0),r0
        beq       L154
;*      Branch Occurs to L154 
	.line	159
;----------------------------------------------------------------------
; 485 | pInfo = GetFltBlkInfo(m_Variable.m_chCarKind);                         
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        ldiu      988,ir0
        sti       r0,*+fp(ir0)
	.line	161
;----------------------------------------------------------------------
; 487 | if(pInfo != NULL)                                                      
; 489 |         // Àü¼ÛÇÒ ºí·Ï À§Ä¡·Î ÀÌµ¿.                                    
;----------------------------------------------------------------------
        ldi       *+fp(ir0),r0
        beq       L153
;*      Branch Occurs to L153 
	.line	164
;----------------------------------------------------------------------
; 490 | m_Variable.m_Recving_Posi = pInfo->nStPosi + ((sPotoLen-1) * 128);     
; 492 | // Àü¼ÛÇÒ ºí·Ï Å©±â¸¦ ±¸ÇÏ´Â ºÎºÐ.                                     
;----------------------------------------------------------------------
        ldiu      269,ir1
        ldiu      1,r0
        ldiu      *+fp(ir0),ar0
        subi3     r0,*+fp(ir1),r0
        mpyi      128,r0
        addi      *+ar0(1),r0
        sti       r0,@_m_Variable+335
	.line	167
;----------------------------------------------------------------------
; 493 | if(sPotoLen < pInfo->nTCnt) //  (sPotoLen*128) <= nTempBlkEnd)         
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        cmpi3     *ar0,*+fp(ir1)
        bged      L146
	nop
        ldige     988,ir0
        ldige     269,ir1
;*      Branch Occurs to L146 
	.line	169
;----------------------------------------------------------------------
; 495 | nBlkSize = 128;                                                        
;----------------------------------------------------------------------
        ldiu      275,ir0
        ldiu      128,r0
        sti       r0,*+fp(ir0)
        bu        L150
;*      Branch Occurs to L150 
	.line	171
;----------------------------------------------------------------------
; 497 | else if(sPotoLen == pInfo->nTCnt)                                      
;----------------------------------------------------------------------
L146:        
        ldiu      *+fp(ir0),ar0
        cmpi3     *ar0,*+fp(ir1)
        bned      L149
	nop
        ldine     275,ir0
        ldine     0,r0
;*      Branch Occurs to L149 
	.line	173
;----------------------------------------------------------------------
; 499 | nBlkSize = (pInfo->nEdPosi - pInfo->nStPosi) % 128; // - ((sPotoLen - 1
;     | ) * 128);                                                              
; 501 | else                                                                   
;----------------------------------------------------------------------
        ldiu      988,ir1
        ldiu      *+fp(ir0),ir0
        ldiu      2,ar0
        ldiu      *+fp(ir1),ar1
        subi3     *+ar1,*+ar0(ir0),r1
        ldiu      r1,r0
        ldiu      275,ir1
        ash       -6,r0
        lsh       @CL72,r0
        addi3     r0,r1,r0
        andn      127,r0
        subri     r1,r0
        sti       r0,*+fp(ir1)
        bu        L150
;*      Branch Occurs to L150 
	.line	177
;----------------------------------------------------------------------
; 503 | nBlkSize = 0;                                                          
;----------------------------------------------------------------------
L149:        
        sti       r0,*+fp(ir0)
L150:        
	.line	180
;----------------------------------------------------------------------
; 506 | if(nBlkSize < 0) nBlkSize = 0;                                         
; 508 | // ºí·ÏÀÇ ¸¶Áö¸· À§Ä¡¸¦ ÁöÁ¤.                                          
;----------------------------------------------------------------------
        ldiu      275,ir0
        ldi       *+fp(ir0),r0
        bge       L152
;*      Branch Occurs to L152 
        ldiu      0,r0
        sti       r0,*+fp(ir0)
L152:        
	.line	183
;----------------------------------------------------------------------
; 509 | nTempBlkEnd = pInfo->nEdPosi;                                          
;----------------------------------------------------------------------
        ldiu      988,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      276,ir0
        ldiu      *+ar0(2),r0
        sti       r0,*+fp(ir0)
L153:        
	.line	186
;----------------------------------------------------------------------
; 512 | sTxDataSize = nBlkSize + 2;                                            
; 514 | // °íÀå µ¥ÀÌÅÍ¸¦ Àü¼ÛÇÏ´Â ºÎºÐ.                                        
;----------------------------------------------------------------------
        ldiu      2,r0
        ldiu      275,ir0
        ldiu      277,ir1
        addi3     r0,*+fp(ir0),r0
        sti       r0,*+fp(ir1)
	.line	189
;----------------------------------------------------------------------
; 515 | user_FaultDataTx(btTx2chBuf,sTxDataSize,TRUE,sPotoLen);                
;----------------------------------------------------------------------
        ldiu      269,ir0
        ldiu      1,r2
        ldiu      @CL73,r3

        ldiu      *+fp(ir1),r0
||      ldiu      *+fp(ir0),r1

        push      r1
        push      r2
        push      r0
        push      r3
        call      _user_FaultDataTx
                                        ; Call Occurs
        subi      4,sp
	.line	190
;----------------------------------------------------------------------
; 516 | user_CncsTx(btTx2chBuf,(sTxDataSize*2)+18);                            
; 518 | // Àü¼Û ÈÄ, ºí·Ï À§Ä¡¸¦ ¸¶Áö¸· À§Ä¡·Î º¹¿ø.                            
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      2,r1
        mpyi3     r1,*+fp(ir0),r1
        addi      18,r1
        push      r1
        ldiu      @CL73,r0
        push      r0
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
	.line	193
;----------------------------------------------------------------------
; 519 | m_Variable.m_Recving_Posi = nTempBlkEnd;                               
; 521 | else                                                                   
; 522 | //¹Ù·Î Á¾·á ÄÚµå°¡ ¼ö½Å µÉ¼ö ÀÖ´Ù.                                     
;----------------------------------------------------------------------
        ldiu      276,ir0
        ldiu      *+fp(ir0),r0
        sti       r0,@_m_Variable+335
        bu        L172
;*      Branch Occurs to L172 
L154:        
	.line	198
;----------------------------------------------------------------------
; 524 | user_FtpEnd_CarNumFun();                                               
; 528 | else // µ¥ÀÌÅ¸ Àü¼Û                                                    
;----------------------------------------------------------------------
        call      _user_FtpEnd_CarNumFun
                                        ; Call Occurs
        bu        L172
;*      Branch Occurs to L172 
L155:        
	.line	204
;----------------------------------------------------------------------
; 530 | if(m_Variable.m_nTxDbg1msTimer > 150) //150ms ¸¶´Ù ÇÑ¹ø¾¿ ½ÇÇà ÇÑ´Ù.   
; 532 |         //°íÀå Á¤º¸ Àü¼Û.                                              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+350,r0
        cmpi      150,r0
        bls       L172
;*      Branch Occurs to L172 
	.line	207
;----------------------------------------------------------------------
; 533 | if(m_Variable.m_LIC_CNCS_Tx_Flag)                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+331,r0
        beq       L168
;*      Branch Occurs to L168 
	.line	209
;----------------------------------------------------------------------
; 535 | m_Variable.m_nTxDbg1msTimer = 0;                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+350
	.line	211
;----------------------------------------------------------------------
; 537 | m_Variable.m_LIC_CNCS_TX_DelyTime++;                                   
; 539 | // 150*50  = 7500  = 7.5ÃÊ µ¿¾È °íÀå ºí·° »çÀÌ°¡ ÀÀ´äÀÌ ¾øÀ¸¸é, Á¾·á ÇÑ
;     | ´Ù.                                                                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+332,r0
        sti       r0,@_m_Variable+332
	.line	214
;----------------------------------------------------------------------
; 540 | if(m_Variable.m_LIC_CNCS_TX_DelyTime > 50){m_Variable.m_bLnWkFtpEndFlag
;     |  = TRUE;}                                                              
;----------------------------------------------------------------------
        cmpi      50,r0
        ble       L159
;*      Branch Occurs to L159 
        ldiu      1,r0
        sti       r0,@_m_Variable+348
L159:        
	.line	216
;----------------------------------------------------------------------
; 542 | if((m_Variable.m_nNvsramPos !=  (m_Variable.m_Recving_Posi)) && (m_Vari
;     | able.m_nNvsramPos >= (m_Variable.m_Recving_Posi+128)))                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+347,r0
        cmpi      @_m_Variable+335,r0
        beqd      L164
	nop
        ldine     128,r0
        ldine     @_m_Variable+347,r1
;*      Branch Occurs to L164 
        addi      @_m_Variable+335,r0   ; Unsigned
        cmpi3     r0,r1
        blo       L164
;*      Branch Occurs to L164 
	.line	218
;----------------------------------------------------------------------
; 544 | m_Variable.m_nFaultCnt++;                                              
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+334,r0
        sti       r0,@_m_Variable+334
	.line	219
;----------------------------------------------------------------------
; 545 | if(m_Variable.m_nFaultCnt == 1)                                        
;----------------------------------------------------------------------
        cmpi      1,r0
        bne       L163
;*      Branch Occurs to L163 
	.line	220
;----------------------------------------------------------------------
; 546 | SetFltBlkStPos(m_Variable.m_chCarKind, m_Variable.m_Recving_Posi);
;     |                                                                  // Ã¹¹
;     | øÂ° ºí·ÏÀÏ °æ¿ì, °íÀå Á¤º¸ÀÇ ½ÃÀÛ À§Ä¡¸¦ ±â·Ï.                         
;----------------------------------------------------------------------
        ldiu      @_m_Variable+335,r0
        push      r0
        ldiu      @_m_Variable+341,r0
        push      r0
        call      _SetFltBlkStPos
                                        ; Call Occurs
        subi      2,sp
L163:        
	.line	222
;----------------------------------------------------------------------
; 548 | sTxDataSize = 128 + 2;                                                 
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      130,r0
        sti       r0,*+fp(ir0)
	.line	224
;----------------------------------------------------------------------
; 550 | user_FaultDataTx(btTx2chBuf,sTxDataSize,FALSE,0);                      
;----------------------------------------------------------------------
        ldiu      0,r1
        ldiu      @CL73,r2
        ldiu      *+fp(ir0),r3
        ldiu      0,r0
        push      r1
        push      r0
        push      r3
        push      r2
        call      _user_FaultDataTx
                                        ; Call Occurs
        subi      4,sp
	.line	226
;----------------------------------------------------------------------
; 552 | m_Variable.m_Recving_Posi += 128;                                      
;----------------------------------------------------------------------
        ldiu      128,r0
        addi      @_m_Variable+335,r0
        sti       r0,@_m_Variable+335
	.line	228
;----------------------------------------------------------------------
; 554 | user_CncsTx(btTx2chBuf,(sTxDataSize*2)+18);                            
; 556 | else                                                                   
; 557 | //¹Ù·Î Á¾·á ÄÚµå°¡ ¼ö½Å µÉ¼ö ÀÖ´Ù.                                     
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      2,r1
        mpyi3     r1,*+fp(ir0),r1
        addi      18,r1
        ldiu      @CL73,r0
        push      r1
        push      r0
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
        bu        L172
;*      Branch Occurs to L172 
L164:        
	.line	232
;----------------------------------------------------------------------
; 558 | if(m_Variable.m_bLnWkFtpEndFlag)                                       
;----------------------------------------------------------------------
        ldi       @_m_Variable+348,r0
        beq       L172
;*      Branch Occurs to L172 
	.line	234
;----------------------------------------------------------------------
; 560 | m_Variable.m_nFaultCnt++;                                              
; 561 | //aaa_CarAFautlCnt = m_nFaultCnt;                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+334,r0
        sti       r0,@_m_Variable+334
	.line	237
;----------------------------------------------------------------------
; 563 | if(m_Variable.m_nFaultCnt == 1)                                        
;----------------------------------------------------------------------
        cmpi      1,r0
        bne       L167
;*      Branch Occurs to L167 
	.line	238
;----------------------------------------------------------------------
; 564 | SetFltBlkStPos(m_Variable.m_chCarKind, m_Variable.m_Recving_Posi);
;     |                                                                  // Ã¹¹
;     | øÂ° ºí·ÏÀÏ °æ¿ì, °íÀå Á¤º¸ÀÇ ½ÃÀÛ À§Ä¡¸¦ ±â·Ï.                         
; 566 | // °íÀå Á¤º¸¸¦ ÀúÀåÇÏ´Â ºÎºÐ.                                          
;----------------------------------------------------------------------
        ldiu      @_m_Variable+335,r0
        push      r0
        ldiu      @_m_Variable+341,r0
        push      r0
        call      _SetFltBlkStPos
                                        ; Call Occurs
        subi      2,sp
L167:        
	.line	241
;----------------------------------------------------------------------
; 567 | SetFltBlkEdInfo(m_Variable.m_chCarKind, m_Variable.m_nNvsramPos, m_Vari
;     | able.m_nFaultCnt);                                                     
;----------------------------------------------------------------------
        ldiu      @_m_Variable+334,r1
        ldiu      @_m_Variable+347,r0
        push      r1
        push      r0
        ldiu      @_m_Variable+341,r0
        push      r0
        call      _SetFltBlkEdInfo
                                        ; Call Occurs
        subi      3,sp
	.line	243
;----------------------------------------------------------------------
; 569 | sTxDataSize = (m_Variable.m_nNvsramPos - m_Variable.m_Recving_Posi) + 2
;     | ;                                                                      
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      @_m_Variable+335,r0
        subri     @_m_Variable+347,r0   ; Unsigned
        addi      2,r0                  ; Unsigned
        sti       r0,*+fp(ir0)
	.line	244
;----------------------------------------------------------------------
; 570 | user_FaultDataTx(btTx2chBuf,sTxDataSize,TRUE,0);                       
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      0,r1
        ldiu      *+fp(ir0),r3
        ldiu      @CL73,r2
        push      r1
        push      r0
        push      r3
        push      r2
        call      _user_FaultDataTx
                                        ; Call Occurs
        subi      4,sp
	.line	245
;----------------------------------------------------------------------
; 571 | m_Variable.m_Recving_Posi += (sTxDataSize-2);                          
; 573 | // user_FtpEnd_CarNumFun();                                            
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      *+fp(ir0),r0
        addi      @_m_Variable+335,r0
        subi      2,r0
        sti       r0,@_m_Variable+335
	.line	249
;----------------------------------------------------------------------
; 575 | user_CncsTx(btTx2chBuf,(sTxDataSize*2)+18);                            
;----------------------------------------------------------------------
        ldiu      2,r1
        mpyi3     r1,*+fp(ir0),r1
        ldiu      @CL73,r0
        addi      18,r1
        push      r1
        push      r0
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
	.line	251
;----------------------------------------------------------------------
; 577 | m_Variable.m_LIC_CNCS_Tx_Flag = FALSE;                                 
; 580 | else                                                                   
; 581 | //½Ã°£ Á¤º¸ ¿äÃ». LIC -> CNCS ·Î ½Ã°£ Á¤º¸¸¦ ¿äÃ» ÇÑ´Ù.(LIC´Â ¿­Â÷ ¹øÈ£
;     | ¸¦ Æ÷ÇÔÇÏ¿© Àü¼Û ÇÑ´Ù.)                                                
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+331
        bu        L172
;*      Branch Occurs to L172 
L168:        
	.line	256
;----------------------------------------------------------------------
; 582 | if(m_Variable.m_nTxDbg1msTimer > 1000)                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+350,r0
        cmpi      1000,r0
        bls       L172
;*      Branch Occurs to L172 
	.line	258
;----------------------------------------------------------------------
; 584 | m_Variable.m_nTxDbg1msTimer = 0;                                       
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+350
	.line	260
;----------------------------------------------------------------------
; 586 | nTimeSendCnt++;                                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_nTimeSendCnt$8+0,r0
        sti       r0,@_nTimeSendCnt$8+0
	.line	261
;----------------------------------------------------------------------
; 587 | nTimeSendCnt = nTimeSendCnt%255;                                       
;----------------------------------------------------------------------
        ldiu      255,r1
        call      MOD_I30
                                        ; Call Occurs
        sti       r0,@_nTimeSendCnt$8+0
	.line	263
;----------------------------------------------------------------------
; 589 | pCnsc_Lic_T_F = (CNCS_LIC_T_F *) btTx2chBuf;                           
;----------------------------------------------------------------------
        ldiu      986,ir0
        ldiu      @CL73,r0
        sti       r0,*+fp(ir0)
	.line	265
;----------------------------------------------------------------------
; 591 | sTxDataSize = 4;                                                       
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      4,r0
        sti       r0,*+fp(ir0)
	.line	267
;----------------------------------------------------------------------
; 593 | pCnsc_Lic_T_F->phHdBuf.btSoh =  0x01;                                  
;----------------------------------------------------------------------
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      1,r0
        sti       r0,*ar0
	.line	268
;----------------------------------------------------------------------
; 594 | pCnsc_Lic_T_F->phHdBuf.chSrcDev[0] =  ConvHex2Asc(BYTE_H(0x11));       
;----------------------------------------------------------------------
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(1)
	.line	269
;----------------------------------------------------------------------
; 595 | pCnsc_Lic_T_F->phHdBuf.chSrcDev[1] =  ConvHex2Asc(BYTE_L(0x11));       
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(2)
	.line	270
;----------------------------------------------------------------------
; 596 | pCnsc_Lic_T_F->phHdBuf.chDestDev[0] =  ConvHex2Asc(BYTE_H(0x15));      
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(3)
	.line	271
;----------------------------------------------------------------------
; 597 | pCnsc_Lic_T_F->phHdBuf.chDestDev[1] =  ConvHex2Asc(BYTE_L(0x15));      
;----------------------------------------------------------------------
        ldiu      5,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(4)
	.line	273
;----------------------------------------------------------------------
; 599 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[0] = ConvHex2Asc(BYTE_H(WORD_H(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      @_nTimeSendCnt$8+0,r0
        ash       -8,r0
        and       255,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(5)
	.line	274
;----------------------------------------------------------------------
; 600 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[1] = ConvHex2Asc(BYTE_L(WORD_H(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      @_nTimeSendCnt$8+0,r0
        ash       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(6)
	.line	275
;----------------------------------------------------------------------
; 601 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[2] = ConvHex2Asc(BYTE_H(WORD_L(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      255,r0
        and       @_nTimeSendCnt$8+0,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(7)
	.line	276
;----------------------------------------------------------------------
; 602 | pCnsc_Lic_T_F->phHdBuf.chMsgCnt[3] = ConvHex2Asc(BYTE_L(WORD_L(nTimeSen
;     | dCnt)));                                                               
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_nTimeSendCnt$8+0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(8)
	.line	278
;----------------------------------------------------------------------
; 604 | pCnsc_Lic_T_F->phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(0x10));       
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(9)
	.line	279
;----------------------------------------------------------------------
; 605 | pCnsc_Lic_T_F->phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(0x10));       
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(10)
	.line	281
;----------------------------------------------------------------------
; 607 | pCnsc_Lic_T_F->phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(WORD_H(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      -8,r0
        ash3      r0,*+fp(ir0),r0
        and       255,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(11)
	.line	282
;----------------------------------------------------------------------
; 608 | pCnsc_Lic_T_F->phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(WORD_H(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      -8,r0
        ash3      r0,*+fp(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(12)
	.line	283
;----------------------------------------------------------------------
; 609 | pCnsc_Lic_T_F->phHdBuf.chDataLen[2] = ConvHex2Asc(BYTE_H(WORD_L(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      255,r0
        and3      r0,*+fp(ir0),r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(13)
	.line	284
;----------------------------------------------------------------------
; 610 | pCnsc_Lic_T_F->phHdBuf.chDataLen[3] = ConvHex2Asc(BYTE_L(WORD_L(sTxData
;     | Size))); // ±æÀÌ                                                       
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      15,r0
        and3      r0,*+fp(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(14)
	.line	286
;----------------------------------------------------------------------
; 612 | pCnsc_Lic_T_F->sCommand[0] = ConvHex2Asc(BYTE_H(0x08));                
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(15)
	.line	287
;----------------------------------------------------------------------
; 613 | pCnsc_Lic_T_F->sCommand[1] = ConvHex2Asc(BYTE_L(0x08));                
;----------------------------------------------------------------------
        ldiu      8,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(16)
	.line	289
;----------------------------------------------------------------------
; 615 | pCnsc_Lic_T_F->sTEXT[0] = ConvHex2Asc(BYTE_H(WORD_H(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+340,r0
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(17)
	.line	290
;----------------------------------------------------------------------
; 616 | pCnsc_Lic_T_F->sTEXT[1] = ConvHex2Asc(BYTE_L(WORD_H(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      @_m_Variable+340,r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(18)
	.line	291
;----------------------------------------------------------------------
; 617 | pCnsc_Lic_T_F->sTEXT[2] = ConvHex2Asc(BYTE_H(WORD_L(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      255,r0
        and       @_m_Variable+340,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(19)
	.line	292
;----------------------------------------------------------------------
; 618 | pCnsc_Lic_T_F->sTEXT[3] = ConvHex2Asc(BYTE_L(WORD_L(m_Variable.m_nCarNo
;     | )));  //¿­Â÷ ¹øÈ£ Àü¼Û                                                 
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+340,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(20)
	.line	294
;----------------------------------------------------------------------
; 620 | pCnsc_Lic_T_F->chContactSignalBuf[0] = ConvHex2Asc(BYTE_H(m_Variable.m_
;     | btCttSignalA.BYTE));                                                   
;----------------------------------------------------------------------
        ldiu      @_m_Variable+424,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(21)
	.line	295
;----------------------------------------------------------------------
; 621 | pCnsc_Lic_T_F->chContactSignalBuf[1] = ConvHex2Asc(BYTE_L(m_Variable.m_
;     | btCttSignalA.BYTE));                                                   
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+424,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(22)
	.line	297
;----------------------------------------------------------------------
; 623 | sBcc = Make1ByteBcc(&pCnsc_Lic_T_F->phHdBuf.chSrcDev[0],(sTxDataSize*2)
;     | +14);                                                                  
;----------------------------------------------------------------------
        ldiu      986,ir1
        ldiu      1,r1
        ldiu      277,ir0
        ldiu      2,r0
        mpyi3     r0,*+fp(ir0),r0
        addi3     r1,*+fp(ir1),r1       ; Unsigned
        addi      14,r0
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        ldiu      270,ir0
        subi      2,sp
        sti       r0,*+fp(ir0)
	.line	299
;----------------------------------------------------------------------
; 625 | pCnsc_Lic_T_F->chChkSum[0] = ConvHex2Asc(BYTE_H(sBcc));                
;----------------------------------------------------------------------
        ldiu      -4,r0
        lsh3      r0,*+fp(ir0),r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      986,ir0
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(23)
	.line	300
;----------------------------------------------------------------------
; 626 | pCnsc_Lic_T_F->chChkSum[1] = ConvHex2Asc(BYTE_L(sBcc));                
;----------------------------------------------------------------------
        ldiu      270,ir0
        ldiu      15,r0
        and3      r0,*+fp(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      986,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        sti       r0,*+ar0(24)
	.line	302
;----------------------------------------------------------------------
; 628 | pCnsc_Lic_T_F->btEot = 0x04;                                           
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      4,r0
        sti       r0,*+ar0(25)
	.line	304
;----------------------------------------------------------------------
; 630 | user_CncsTx(&pCnsc_Lic_T_F->phHdBuf.btSoh,(sTxDataSize*2)+18);         
;----------------------------------------------------------------------
        ldiu      277,ir0
        ldiu      2,r0
        mpyi3     r0,*+fp(ir0),r0
        addi      18,r0
        ldiu      986,ir1
        push      r0
        ldiu      *+fp(ir1),r0
        push      r0
        call      _user_CncsTx
                                        ; Call Occurs
        subi      2,sp
L172:        
	.line	309
;----------------------------------------------------------------------
; 635 | nOldUart2RxOneByteGapDelayTime = m_Variable.m_nUart2RxOneByteGapDelayTi
;     | me;                                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+289,r0
        sti       r0,@_nOldUart2RxOneByteGapDelayTime$5+0
	.line	310
        pop       r5
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      990,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	636,000000030h,988


	.sect	 ".text"

	.global	_ClearFltBlkInfo
	.sym	_ClearFltBlkInfo,_ClearFltBlkInfo,32,2,0
	.func	639
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
; 639 | void ClearFltBlkInfo()                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 641 | memset(&m_Variable.m_tFaultInfo, 0x00, sizeof(m_Variable.m_tFaultInfo))
;     | ;                        // °íÀå Á¤º¸ »èÁ¦.                            
;----------------------------------------------------------------------
        ldiu      6,r2
        ldiu      0,r0
        ldiu      @CL74,r1
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
	.endfunc	642,000000000h,0


	.sect	 ".text"

	.global	_SetFltBlkStPos
	.sym	_SetFltBlkStPos,_SetFltBlkStPos,32,2,0
	.func	645
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
	.sym	_pInfo,1,24,1,32,.fake68
	.line	1
;----------------------------------------------------------------------
; 645 | void SetFltBlkStPos(char chCarKind, int nStPosi)                       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 647 | PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 649 | if(pInfo != NULL)                                                      
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L180
;*      Branch Occurs to L180 
	.line	6
;----------------------------------------------------------------------
; 650 | pInfo->nStPosi = nStPosi;
;     |                  // °íÀå ½ÃÀÛ À§Ä¡¸¦ ÀúÀå.                             
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      *-fp(3),r0
        sti       r0,*+ar0(1)
L180:        
	.line	7
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	651,000000000h,1


	.sect	 ".text"

	.global	_SetFltBlkEdInfo
	.sym	_SetFltBlkEdInfo,_SetFltBlkEdInfo,32,2,0
	.func	654
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
	.sym	_pInfo,1,24,1,32,.fake68
	.line	1
;----------------------------------------------------------------------
; 654 | void SetFltBlkEdInfo(char chCarKind, int nEndPosi, int nFltTCnt)       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 656 | PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 658 | if(pInfo != NULL)                                                      
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L184
;*      Branch Occurs to L184 
	.line	7
;----------------------------------------------------------------------
; 660 | pInfo->nTCnt = nFltTCnt;
;     |                          // °íÀå ÀüÃ¼ °¹¼ö¸¦ ±â·Ï.                     
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      *-fp(4),r0
        sti       r0,*ar0
	.line	8
;----------------------------------------------------------------------
; 661 | pInfo->nEdPosi = nEndPosi;
;     |                          // °íÀå ¸¶Áö¸· À§Ä¡¸¦ ÀúÀå.                   
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldiu      *-fp(3),r0
        sti       r0,*+ar0(2)
L184:        
	.line	10
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	663,000000000h,1


	.sect	 ".text"

	.global	_GetFltBlkInfo
	.sym	_GetFltBlkInfo,_GetFltBlkInfo,104,2,0,.fake68
	.func	666
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
; 666 | PFAULT_INFO GetFltBlkInfo(char chCarKind)                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 668 | int nIdx = chCarKind - 'A';                                            
;----------------------------------------------------------------------
        ldiu      65,r0
        subri     *-fp(2),r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 670 | if(nIdx < eCDT_MAXIMUM)                                                
;----------------------------------------------------------------------
        cmpi      2,r0
        bge       L188
;*      Branch Occurs to L188 
	.line	6
;----------------------------------------------------------------------
; 671 | return &m_Variable.m_tFaultInfo[nIdx];                                 
;----------------------------------------------------------------------
        bud       L189
	nop
        mpyi      3,r0
        addi      @CL74,r0              ; Unsigned
;*      Branch Occurs to L189 
L188:        
	.line	8
;----------------------------------------------------------------------
; 673 | return NULL;                                                           
;----------------------------------------------------------------------
        ldiu      0,r0
L189:        
	.line	9
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	674,000000000h,1


	.sect	 ".text"

	.global	_GetFltBlkStPos
	.sym	_GetFltBlkStPos,_GetFltBlkStPos,36,2,0
	.func	677
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
	.sym	_pInfo,2,24,1,32,.fake68
	.line	1
;----------------------------------------------------------------------
; 677 | int GetFltBlkStPos(char chCarKind)                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 679 | int nStPos = -1;                                                       
;----------------------------------------------------------------------
        ldiu      -1,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 680 | PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);                          
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        push      r0
        call      _GetFltBlkInfo
                                        ; Call Occurs
        subi      1,sp
        sti       r0,*+fp(2)
	.line	6
;----------------------------------------------------------------------
; 682 | if(pInfo != NULL)                                                      
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L193
;*      Branch Occurs to L193 
	.line	7
;----------------------------------------------------------------------
; 683 | nStPos = pInfo->nStPosi;                                               
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      *+ar0(1),r0
        sti       r0,*+fp(1)
L193:        
	.line	9
;----------------------------------------------------------------------
; 685 | return nStPos;                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	10
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      4,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	686,000000000h,2


	.sect	 ".text"

	.global	_user_FaultDataTx
	.sym	_user_FaultDataTx,_user_FaultDataTx,32,2,0
	.func	688
;******************************************************************************
;* FUNCTION NAME: _user_FaultDataTx                                           *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,ar0,fp,sp,st                               *
;*   Regs Saved         :                                                     *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 4 Parm + 3 Auto + 0 SOE = 9 words          *
;******************************************************************************
_user_FaultDataTx:
	.sym	_pTxBuf,-2,28,9,32
	.sym	_nLen,-3,12,9,32
	.sym	_nEndFlag,-4,12,9,32
	.sym	_nFltIdx,-5,4,9,32
	.sym	_sTempData,1,12,1,32
	.sym	_pLic_Cncs,2,24,1,32,.fake42
	.sym	_pNvsram,3,28,1,32
	.line	1
;----------------------------------------------------------------------
; 688 | void user_FaultDataTx(UCHAR *pTxBuf,UCHAR nLen,UCHAR nEndFlag,int nFltI
;     | dx)                                                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 690 | UCHAR sTempData = 0;                                                   
; 691 | PLIC_CNCS_HD pLic_Cncs;                                                
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 692 | UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;                                 
;----------------------------------------------------------------------
        ldiu      @CL67,r0
        sti       r0,*+fp(3)
	.line	7
;----------------------------------------------------------------------
; 694 | pLic_Cncs =(LIC_CNCS_HD *) pTxBuf;                                     
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        sti       r0,*+fp(2)
	.line	9
;----------------------------------------------------------------------
; 696 | pLic_Cncs->phHdBuf.btSoh = 0x01;                                       
;----------------------------------------------------------------------
        ldiu      r0,ar0
        ldiu      1,r0
        sti       r0,*ar0
	.line	10
;----------------------------------------------------------------------
; 697 | pLic_Cncs->phHdBuf.chSrcDev[0] =  ConvHex2Asc(BYTE_H(0x11));           
;----------------------------------------------------------------------
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(1)
	.line	11
;----------------------------------------------------------------------
; 698 | pLic_Cncs->phHdBuf.chSrcDev[1] =  ConvHex2Asc(BYTE_L(0x11));           
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(2)
	.line	12
;----------------------------------------------------------------------
; 699 | pLic_Cncs->phHdBuf.chDestDev[0] =  ConvHex2Asc(BYTE_H(0x15));          
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(3)
	.line	13
;----------------------------------------------------------------------
; 700 | pLic_Cncs->phHdBuf.chDestDev[1] =  ConvHex2Asc(BYTE_L(0x15));          
; 702 | // °íÀå ÀÎµ¦½º¸¦ ½Å±Ô·Î »ý¼º(Y.J ¼öÁ¤)                                 
;----------------------------------------------------------------------
        ldiu      5,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(4)
	.line	16
;----------------------------------------------------------------------
; 703 | if(!nFltIdx) nFltIdx = m_Variable.m_nFaultCnt;                         
;----------------------------------------------------------------------
        ldi       *-fp(5),r0
        bne       L198
;*      Branch Occurs to L198 
        ldiu      @_m_Variable+334,r0
        sti       r0,*-fp(5)
L198:        
	.line	18
;----------------------------------------------------------------------
; 705 | pLic_Cncs->phHdBuf.chMsgCnt[0] = ConvHex2Asc(BYTE_H(WORD_H(nFltIdx))); 
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
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(5)
	.line	19
;----------------------------------------------------------------------
; 706 | pLic_Cncs->phHdBuf.chMsgCnt[1] = ConvHex2Asc(BYTE_L(WORD_H(nFltIdx))); 
;----------------------------------------------------------------------
        ldiu      *-fp(5),r0
        ash       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(6)
	.line	20
;----------------------------------------------------------------------
; 707 | pLic_Cncs->phHdBuf.chMsgCnt[2] = ConvHex2Asc(BYTE_H(WORD_L(nFltIdx))); 
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(5),r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(7)
	.line	21
;----------------------------------------------------------------------
; 708 | pLic_Cncs->phHdBuf.chMsgCnt[3] = ConvHex2Asc(BYTE_L(WORD_L(nFltIdx))); 
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *-fp(5),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(8)
	.line	23
;----------------------------------------------------------------------
; 710 | pLic_Cncs->phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(0x10));           
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(9)
	.line	24
;----------------------------------------------------------------------
; 711 | pLic_Cncs->phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(0x10));           
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(10)
	.line	26
;----------------------------------------------------------------------
; 713 | pLic_Cncs->phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(WORD_H(nLen)));   
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
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(11)
	.line	27
;----------------------------------------------------------------------
; 714 | pLic_Cncs->phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(WORD_H(nLen)));   
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(12)
	.line	28
;----------------------------------------------------------------------
; 715 | pLic_Cncs->phHdBuf.chDataLen[2] = ConvHex2Asc(BYTE_H(WORD_L(nLen)));   
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(3),r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(13)
	.line	29
;----------------------------------------------------------------------
; 716 | pLic_Cncs->phHdBuf.chDataLen[3] = ConvHex2Asc(BYTE_L(WORD_L(nLen)));   
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *-fp(3),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(14)
	.line	31
;----------------------------------------------------------------------
; 718 | if(nEndFlag)                                                           
;----------------------------------------------------------------------
        ldi       *-fp(4),r0
        beq       L200
;*      Branch Occurs to L200 
	.line	33
;----------------------------------------------------------------------
; 720 | pLic_Cncs->sCommand[0] = ConvHex2Asc(BYTE_H(0x06));//°íÀå Á¤º¸ ¼ö½Å ³¡.
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(15)
	.line	34
;----------------------------------------------------------------------
; 721 | pLic_Cncs->sCommand[1] = ConvHex2Asc(BYTE_L(0x06));//°íÀå Á¤º¸ ¼ö½Å ³¡.
; 723 | else                                                                   
;----------------------------------------------------------------------
        ldiu      6,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(16)
        bu        L201
;*      Branch Occurs to L201 
L200:        
	.line	38
;----------------------------------------------------------------------
; 725 | pLic_Cncs->sCommand[0] = ConvHex2Asc(BYTE_H(0x04));//°íÀå Á¤º¸ ¼ö½Å Áß.
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(15)
	.line	39
;----------------------------------------------------------------------
; 726 | pLic_Cncs->sCommand[1] = ConvHex2Asc(BYTE_L(0x04));//°íÀå Á¤º¸ ¼ö½Å Áß.
;----------------------------------------------------------------------
        ldiu      4,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(16)
L201:        
	.line	42
;----------------------------------------------------------------------
; 729 | pLic_Cncs->sCarKind[0] = ConvHex2Asc(BYTE_H(m_Variable.m_chCarKind));  
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(17)
	.line	43
;----------------------------------------------------------------------
; 730 | pLic_Cncs->sCarKind[1] = ConvHex2Asc(BYTE_L(m_Variable.m_chCarKind));  
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+341,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      *+fp(2),ar0
        sti       r0,*+ar0(18)
	.line	45
;----------------------------------------------------------------------
; 732 | FunConvHexAsc(&pNvsram[m_Variable.m_Recving_Posi],(char *)pLic_Cncs->sT
;     | extDataAsc,(nLen-2));                                                  
;----------------------------------------------------------------------
        ldiu      19,r2
        ldiu      @_m_Variable+335,r1
        addi      *+fp(3),r1            ; Unsigned
        ldiu      2,r0
        addi      *+fp(2),r2            ; Unsigned
        subri     *-fp(3),r0            ; Unsigned
        push      r0
        push      r2
        push      r1
        call      _FunConvHexAsc
                                        ; Call Occurs
        subi      3,sp
	.line	47
;----------------------------------------------------------------------
; 734 | sTempData = Make1ByteBcc(&pLic_Cncs->phHdBuf.chSrcDev[0],(nLen*2)+14); 
;----------------------------------------------------------------------
        ldiu      1,r1
        addi      *+fp(2),r1            ; Unsigned
        ldiu      *-fp(3),r0
        mpyi      2,r0
        addi      14,r0                 ; Unsigned
        push      r0
        push      r1
        call      _Make1ByteBcc
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(1)
	.line	49
;----------------------------------------------------------------------
; 736 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)] = ConvHex2Asc(BYTE_H(sTempData));
;----------------------------------------------------------------------
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      2,ar0
        subri     *-fp(3),ar0           ; Unsigned
        mpyi      2,ar0
        addi      *+fp(2),ar0           ; Unsigned
        sti       r0,*+ar0(19)
	.line	50
;----------------------------------------------------------------------
; 737 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)+1] = ConvHex2Asc(BYTE_L(sTempData)
;     | );                                                                     
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
        addi      *+fp(2),ar0           ; Unsigned
        sti       r0,*+ar0(20)
	.line	52
;----------------------------------------------------------------------
; 739 | pLic_Cncs->sTextDataAsc[((nLen-2)*2)+2] = 0x04;                        
;----------------------------------------------------------------------
        ldiu      2,ar0
        subri     *-fp(3),ar0           ; Unsigned
        mpyi      2,ar0
        addi      *+fp(2),ar0           ; Unsigned
        ldiu      4,r0
        sti       r0,*+ar0(21)
	.line	54
;----------------------------------------------------------------------
; 741 | m_Variable.m_LIC_CNCS_TX_DelyTime = 0;                                 
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+332
	.line	55
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      5,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	742,000000000h,3


	.sect	 ".text"

	.global	_user_FtpEnd_CarNumFun
	.sym	_user_FtpEnd_CarNumFun,_user_FtpEnd_CarNumFun,32,2,0
	.func	747
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
; 747 | void user_FtpEnd_CarNumFun()                                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 749 | m_Variable.m_bLnWkFtpEndFlag = FALSE;                                  
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+348
	.line	5
;----------------------------------------------------------------------
; 751 | m_Variable.m_LIC_CNCS_Tx_Flag = FALSE; //°íÀå Á¤º¸ ¸¶Áö¸· ºí·° ÀÌ¹Ç·Î À
;     | ü¼Û ³¡.                                                                
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+331
	.line	6
;----------------------------------------------------------------------
; 752 | m_Variable.m_nNvsramPos = 0;                                           
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+347
	.line	7
;----------------------------------------------------------------------
; 753 | m_Variable.m_Recving_Posi = 0;                                         
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+335
	.line	8
;----------------------------------------------------------------------
; 754 | m_Variable.m_nLnWkWaySideOnRxOk = 0;                                   
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+345
	.line	9
;----------------------------------------------------------------------
; 755 | m_Variable.m_nFaultCnt = 0;                                            
; 756 | //m_chCarKind = 'A';                                                   
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+334
	.line	11
;----------------------------------------------------------------------
; 757 | m_Variable.m_nLnWkTxFlag = 0;                                          
;----------------------------------------------------------------------
        sti       r0,@_m_Variable+333
	.line	52
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	798,000000000h,0



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
	.field  	_nRxPos$9+0,32
	.field  	0,32		; _nRxPos$9 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_nOldUart3RxOneByteGapDelayTime$10+0,32
	.field  	0,32		; _nOldUart3RxOneByteGapDelayTime$10 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_sCarNumBCD_H$12+0,32
	.field  	0,32		; _sCarNumBCD_H$12 @ 0

	.sect	".text"

	.sect	".cinit"
	.field  	1,32
	.field  	_sCarNumBCD_L$13+0,32
	.field  	0,32		; _sCarNumBCD_L$13 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_user_WithPacRs485Loop
	.sym	_user_WithPacRs485Loop,_user_WithPacRs485Loop,32,2,0
	.func	805
;******************************************************************************
;* FUNCTION NAME: _user_WithPacRs485Loop                                      *
;*                                                                            *
;*   Architecture       : TMS320C30                                           *
;*   Calling Convention : Stack Parameter Convention                          *
;*   Function Uses Regs : r0,r1,r2,r4,ar0,ar1,fp,ir0,ir1,sp,st                *
;*   Regs Saved         : r4                                                  *
;*   Stack Frame        : Full (w/ debug)                                     *
;*   Total Frame Size   : 2 Call + 0 Parm + 435 Auto + 1 SOE = 438 words      *
;******************************************************************************
_user_WithPacRs485Loop:
	.bss	_nRxPos$9,1
	.sym	_nRxPos,_nRxPos$9,4,3,32
	.bss	_nOldUart3RxOneByteGapDelayTime$10,1
	.sym	_nOldUart3RxOneByteGapDelayTime,_nOldUart3RxOneByteGapDelayTime$10,12,3,32
	.bss	_btRx3chBuf$11,300
	.sym	_btRx3chBuf,_btRx3chBuf$11,60,3,9600,,300
	.bss	_sCarNumBCD_H$12,1
	.sym	_sCarNumBCD_H,_sCarNumBCD_H$12,12,3,32
	.bss	_sCarNumBCD_L$13,1
	.sym	_sCarNumBCD_L,_sCarNumBCD_L$13,12,3,32
	.sym	_i,1,4,1,32
	.sym	_nRxLen,2,4,1,32
	.sym	_nCciCnt,3,4,1,32
	.sym	_btTmp,4,12,1,32
	.sym	_btTmpBuf,5,60,1,3200,,100
	.sym	_btBuf,105,60,1,9600,,300
	.sym	_pLnWkDp,405,24,1,32,.fake10
	.sym	_pPaSdrBuf,406,24,1,32,.fake13
	.sym	_lsLicSdBuf,407,8,1,768,.fake36
	.sym	_pPa_PaBuf,431,24,1,32,.fake34
	.sym	_pCcp_Pac,432,24,1,32,.fake35
	.sym	_pPac_Pac_Sta,433,24,1,32,.fake14
	.sym	_pCommStatus,434,24,1,32,.fake49
	.sym	_pCommStatus_Lic,435,24,1,32,.fake57
	.line	1
;----------------------------------------------------------------------
; 805 | void user_WithPacRs485Loop()                                           
; 807 | int i;                                                                 
; 808 | int nRxLen;                                                            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      435,sp
        push      r4
	.line	5
;----------------------------------------------------------------------
; 809 | int nCciCnt = 0;                                                       
; 810 | UCHAR btTmp;                                                           
; 811 | UCHAR btTmpBuf[100];                                                   
; 812 | UCHAR btBuf[300];                                                      
; 813 | static int nRxPos = 0;                                                 
; 814 | static UCHAR nOldUart3RxOneByteGapDelayTime = 0;                       
; 815 | static UCHAR btRx3chBuf[300];                                          
; 817 | static UCHAR sCarNumBCD_H = 0;                                         
; 818 | static UCHAR sCarNumBCD_L = 0;                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(3)
	.line	16
;----------------------------------------------------------------------
; 820 | PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;                                
; 822 | PPACSDR pPaSdrBuf;                                                     
; 823 | LICSD lsLicSdBuf;                                                      
; 824 | PPAC_PAC pPa_PaBuf;                                                    
; 826 | PCCP_PAC pCcp_Pac;                                                     
; 828 | PCRA_STATION pPac_Pac_Sta;                                             
; 830 | PCOMMSTATUS_PA pCommStatus;                                            
; 831 | PCOMMSTATUS_LIC pCommStatus_Lic;                                       
; 834 | // ¼ö½Å                                                                
;----------------------------------------------------------------------
        ldiu      405,ir0
        ldiu      @CL75,r0
        sti       r0,*+fp(ir0)
	.line	31
;----------------------------------------------------------------------
; 835 | nRxLen = user_PacRx(btBuf,128);                                        
;----------------------------------------------------------------------
        ldiu      128,r1
        ldiu      fp,r0
        push      r1
        addi      105,r0
        push      r0
        call      _user_PacRx
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(2)
	.line	32
;----------------------------------------------------------------------
; 836 | if(nRxLen)                                                             
;----------------------------------------------------------------------
        cmpi      0,r0
        beq       L212
;*      Branch Occurs to L212 
	.line	34
;----------------------------------------------------------------------
; 838 | if(!m_Variable.m_nUart3RxOneByteGapDelayTime) nRxPos = 0;              
;----------------------------------------------------------------------
        ldi       @_m_Variable+290,r0
        bne       L210
;*      Branch Occurs to L210 
        ldiu      0,r0
        sti       r0,@_nRxPos$9+0
L210:        
	.line	35
;----------------------------------------------------------------------
; 839 | m_Variable.m_nUart3RxOneByteGapDelayTime = 3;                          
;----------------------------------------------------------------------
        ldiu      3,r0
        sti       r0,@_m_Variable+290
	.line	37
;----------------------------------------------------------------------
; 841 | if(nRxPos + nRxLen < 300)                                              
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$9+0,r0
        cmpi      300,r0
        bged      L212
        ldilt     @CL76,r0
        ldilt     fp,r1
        ldilt     *+fp(2),r2
;*      Branch Occurs to L212 
	.line	39
;----------------------------------------------------------------------
; 843 | memcpy(&btRx3chBuf[nRxPos],btBuf,nRxLen);                              
;----------------------------------------------------------------------
        addi      @_nRxPos$9+0,r0       ; Unsigned
        addi      105,r1
        push      r2
        push      r1
        push      r0
        call      _memcpy
                                        ; Call Occurs
        subi      3,sp
	.line	40
;----------------------------------------------------------------------
; 844 | nRxPos += nRxLen;                                                      
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        addi      @_nRxPos$9+0,r0
        sti       r0,@_nRxPos$9+0
L212:        
	.line	45
;----------------------------------------------------------------------
; 849 | if(nOldUart3RxOneByteGapDelayTime && !m_Variable.m_nUart3RxOneByteGapDe
;     | layTime)                                                               
;----------------------------------------------------------------------
        ldi       @_nOldUart3RxOneByteGapDelayTime$10+0,r0
        beq       L268
;*      Branch Occurs to L268 
        ldi       @_m_Variable+290,r0
        bne       L268
;*      Branch Occurs to L268 
	.line	48
;----------------------------------------------------------------------
; 852 | if(nRxPos >= 10)                                                       
;----------------------------------------------------------------------
        ldiu      @_nRxPos$9+0,r0
        cmpi      10,r0
        blt       L268
;*      Branch Occurs to L268 
	.line	50
;----------------------------------------------------------------------
; 854 | pPaSdrBuf = (PACSDR *)btRx3chBuf;                                      
;----------------------------------------------------------------------
        ldiu      406,ir0
        ldiu      @CL76,r0
        sti       r0,*+fp(ir0)
	.line	52
;----------------------------------------------------------------------
; 856 | pPa_PaBuf = (PAC_PAC *)btRx3chBuf;                                     
;----------------------------------------------------------------------
        ldiu      431,ir0
        sti       r0,*+fp(ir0)
	.line	55
;----------------------------------------------------------------------
; 859 | pCcp_Pac = (CCP_PAC *)btRx3chBuf;                                      
; 861 | //PAC -> LIC ºÎºÐ ÇÁ·ÎÅäÄÝÀ» ºÐ¸® ÇÑ´Ù.                                
; 862 | if(                                                                    
;----------------------------------------------------------------------
        ldiu      432,ir0
        sti       r0,*+fp(ir0)
	.line	59
;----------------------------------------------------------------------
; 863 | WORD_L(pPaSdrBuf->phHdBuf.btSoh) == SOH &&                             
; 864 | WORD_L(pPaSdrBuf->btEot) == EOT &&                                     
; 865 | sizeof(PACSDR) == nRxPos &&                                            
; 866 | (TWOBYTE_ASC2HEX(pPaSdrBuf->phHdBuf.chDestDev) == m_Variable.m_chCarKin
;     | dNum)&&                                                                
; 868 | ConvAsc2Hex(pPaSdrBuf->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&pPaSdrBuf
;     | ->phHdBuf.chSrcDev[0],nRxPos-6)))&&                                    
; 869 | ConvAsc2Hex(pPaSdrBuf->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&pPaSdrBuf
;     | ->phHdBuf.chSrcDev[0],nRxPos-6)))&&                                    
; 870 | ConvAsc2Hex(pPaSdrBuf->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&pPaSdrBuf
;     | ->phHdBuf.chSrcDev[0],nRxPos-6)))&&                                    
; 871 | ConvAsc2Hex(pPaSdrBuf->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&pPaSdrBuf
;     | ->phHdBuf.chSrcDev[0],nRxPos-6))))                                     
; 873 | switch(TWOBYTE_ASC2HEX(pPaSdrBuf->phHdBuf.chCmdCode))                  
; 875 | case REQ_CMD: //PAC -> LIC                                             
;----------------------------------------------------------------------
        ldiu      406,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
        cmpi      1,r0
        bne       L231
;*      Branch Occurs to L231 
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and       *+ar0(17),r0
        cmpi      4,r0
        bne       L231
;*      Branch Occurs to L231 
        ldiu      18,r0
        cmpi      @_nRxPos$9+0,r0
        bne       L231
;*      Branch Occurs to L231 
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(3),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      406,ir0
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
        cmpi      @_m_Variable+343,r0
        subi      1,sp
        bne       L231
;*      Branch Occurs to L231 
        ldiu      1,r1
        ldiu      406,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      406,ir0
        ldiu      r0,r4
        subi      2,sp
        lsh       -8,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(13),r0
        lsh       -4,r4
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L231
;*      Branch Occurs to L231 
        ldiu      1,r1
        ldiu      406,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        subi      2,sp
        ldiu      406,ir0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(14),r0
        lsh       -8,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L231
;*      Branch Occurs to L231 
        ldiu      1,r1
        ldiu      406,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      406,ir0
        subi      2,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(15),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L231
;*      Branch Occurs to L231 
        ldiu      1,r1
        ldiu      406,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      406,ir0
        subi      2,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(16),r0
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L231
;*      Branch Occurs to L231 
        bud       L228
        ldiu      406,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(7),r0
;*      Branch Occurs to L228 
	.line	73
;----------------------------------------------------------------------
; 877 | lsLicSdBuf.phHdBuf.btSoh = SOH;                                        
;----------------------------------------------------------------------
L225:        
        sti       r0,*+fp(ir0)
	.line	74
;----------------------------------------------------------------------
; 878 | lsLicSdBuf.phHdBuf.chSrcDev[0] = ConvHex2Asc(BYTE_H(m_Variable.m_chCarK
;     | indNum));                                                              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+343,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      408,ir0
        sti       r0,*+fp(ir0)
	.line	75
;----------------------------------------------------------------------
; 879 | lsLicSdBuf.phHdBuf.chSrcDev[1] = ConvHex2Asc(BYTE_L(m_Variable.m_chCarK
;     | indNum));                                                              
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+343,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      409,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	76
;----------------------------------------------------------------------
; 880 | lsLicSdBuf.phHdBuf.chDestDev[0] = pPaSdrBuf->phHdBuf.chSrcDev[0];      
;----------------------------------------------------------------------
        ldiu      406,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      410,ir0
        ldiu      *+ar0(1),r0
        sti       r0,*+fp(ir0)
	.line	77
;----------------------------------------------------------------------
; 881 | lsLicSdBuf.phHdBuf.chDestDev[1] = pPaSdrBuf->phHdBuf.chSrcDev[1];      
;----------------------------------------------------------------------
        ldiu      406,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      411,ir0
        ldiu      *+ar0(2),r0
        sti       r0,*+fp(ir0)
	.line	78
;----------------------------------------------------------------------
; 882 | lsLicSdBuf.phHdBuf.chMsgCnt[0] = pPaSdrBuf->phHdBuf.chMsgCnt[0];       
;----------------------------------------------------------------------
        ldiu      406,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      412,ir0
        ldiu      *+ar0(5),r0
        sti       r0,*+fp(ir0)
	.line	79
;----------------------------------------------------------------------
; 883 | lsLicSdBuf.phHdBuf.chMsgCnt[1] = pPaSdrBuf->phHdBuf.chMsgCnt[1];       
;----------------------------------------------------------------------
        ldiu      406,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      413,ir0
        ldiu      *+ar0(6),r0
        sti       r0,*+fp(ir0)
	.line	80
;----------------------------------------------------------------------
; 884 | lsLicSdBuf.phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(RPY_CMD));        
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      414,ir0
        sti       r0,*+fp(ir0)
	.line	81
;----------------------------------------------------------------------
; 885 | lsLicSdBuf.phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(RPY_CMD));        
;----------------------------------------------------------------------
        ldiu      1,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      415,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	82
;----------------------------------------------------------------------
; 886 | lsLicSdBuf.phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(((sizeof(LICSD)-16
;     | )/2)));                                                                
;----------------------------------------------------------------------
        ldiu      0,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      416,ir0
        sti       r0,*+fp(ir0)
	.line	83
;----------------------------------------------------------------------
; 887 | lsLicSdBuf.phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(((sizeof(LICSD)-16
;     | )/2)));                                                                
;----------------------------------------------------------------------
        ldiu      4,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      417,ir0
        sti       r0,*+fp(ir0)
	.line	85
;----------------------------------------------------------------------
; 889 | lsLicSdBuf.DATA1.BIT.All_Doors_Closed = m_Variable.m_btCttSignalA.BIT.A
;     | ll_Doors_Closed;                                                       
;----------------------------------------------------------------------
        ldiu      8,r0
        and       @_m_Variable+424,r0
        lsh       -3,r0
        and       1,r0
        ldiu      419,ir0
        ash       3,r0
        ldiu      *+fp(ir0),r1
        andn      8,r1
        ldiu      419,ir1
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	86
;----------------------------------------------------------------------
; 890 | lsLicSdBuf.DATA1.BIT.EP_Mode = m_Variable.m_btCttSignalA.BIT.EP_Mode;  
;----------------------------------------------------------------------
        ldiu      4,r0
        ldiu      *+fp(ir0),r1
        and       @_m_Variable+424,r0
        andn      4,r1
        lsh       -2,r0
        and       1,r0
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	87
;----------------------------------------------------------------------
; 891 | lsLicSdBuf.DATA1.BIT.Traction = m_Variable.m_btCttSignalA.BIT.Traction;
;----------------------------------------------------------------------
        ldiu      2,r1
        ldiu      *+fp(ir0),r0
        and       @_m_Variable+424,r1
        lsh       -1,r1
        and       1,r1
        ash       1,r1
        andn      2,r0
        or3       r0,r1,r0
        sti       r0,*+fp(ir1)
	.line	88
;----------------------------------------------------------------------
; 892 | lsLicSdBuf.DATA1.BIT.Atcive_Cab = m_Variable.m_btCttSignalA.BIT.Atcive_
;     | Cab;                                                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(ir0),r1
        andn      1,r1
        and       @_m_Variable+424,r0
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	90
;----------------------------------------------------------------------
; 894 | lsLicSdBuf.DATA2.BIT.CI_Fault = m_Variable.m_bCiFaultFlag;             
;----------------------------------------------------------------------
        ldiu      418,ir0
        ldiu      1,r0
        ldiu      *+fp(ir0),r1
        and       @_m_Variable+431,r0
        ash       2,r0
        andn      4,r1
        ldiu      418,ir1
        or3       r1,r0,r0
        sti       r0,*+fp(ir1)
	.line	91
;----------------------------------------------------------------------
; 895 | lsLicSdBuf.DATA2.BIT.DST = 0;                                          
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),r0
        andn      8,r0
        sti       r0,*+fp(ir1)
	.line	93
;----------------------------------------------------------------------
; 897 | lsLicSdBuf.DATA1.BYTE = ConvHex2Asc(BYTE_L(lsLicSdBuf.DATA1.BYTE));    
;----------------------------------------------------------------------
        ldiu      419,ir0
        ldiu      15,r0
        and3      r0,*+fp(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      419,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	95
;----------------------------------------------------------------------
; 899 | lsLicSdBuf.DATA2.BYTE = ConvHex2Asc(BYTE_L(lsLicSdBuf.DATA2.BYTE));    
;----------------------------------------------------------------------
        ldiu      418,ir0
        ldiu      15,r0
        and3      r0,*+fp(ir0),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      418,ir0
        sti       r0,*+fp(ir0)
	.line	97
;----------------------------------------------------------------------
; 901 | lsLicSdBuf.CI_Index_Num[0] = ConvHex2Asc(BYTE_H(m_Variable.m_nCarPos));
;----------------------------------------------------------------------
        ldiu      @_m_Variable+338,r0
        ash       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      420,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	98
;----------------------------------------------------------------------
; 902 | lsLicSdBuf.CI_Index_Num[1] = ConvHex2Asc(BYTE_L(m_Variable.m_nCarPos));
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+338,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      421,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	100
;----------------------------------------------------------------------
; 904 | lsLicSdBuf.chCarn[0][0] = ConvHex2Asc(BYTE_H(WORD_H(m_Variable.m_nCarNo
;     | ))); // Car Number(-.¹éÀÚ¸®)                                           
;----------------------------------------------------------------------
        ldiu      @_m_Variable+340,r0
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      422,ir0
        sti       r0,*+fp(ir0)
	.line	101
;----------------------------------------------------------------------
; 905 | lsLicSdBuf.chCarn[0][1] = ConvHex2Asc(BYTE_L(WORD_H(m_Variable.m_nCarNo
;     | )));                                                                   
;----------------------------------------------------------------------
        ldiu      @_m_Variable+340,r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      423,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	102
;----------------------------------------------------------------------
; 906 | lsLicSdBuf.chCarn[1][0] = ConvHex2Asc(BYTE_H(m_Variable.m_nCarNo)); //
;     | Car Number(½ÊÀÚ¸®,ÀÏÀÚ¸®)                                              
;----------------------------------------------------------------------
        ldiu      @_m_Variable+340,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      424,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	103
;----------------------------------------------------------------------
; 907 | lsLicSdBuf.chCarn[1][1] = ConvHex2Asc(BYTE_L(m_Variable.m_nCarNo));    
;----------------------------------------------------------------------
        ldiu      15,r0
        and       @_m_Variable+340,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      425,ir0
        sti       r0,*+fp(ir0)
	.line	105
;----------------------------------------------------------------------
; 909 | btTmp = crc16_ccitt(&lsLicSdBuf.phHdBuf.chSrcDev[0],sizeof(LICSD)-6);  
;----------------------------------------------------------------------
        ldiu      18,r1
        ldiu      408,r0
        push      r1
        addi      fp,r0
        push      r0
        call      _crc16_ccitt
                                        ; Call Occurs
        subi      2,sp
        sti       r0,*+fp(4)
	.line	106
;----------------------------------------------------------------------
; 910 | lsLicSdBuf.nCRC[0] = ConvHex2Asc(BYTE_H(WORD_H(btTmp)));               
;----------------------------------------------------------------------
        lsh       -8,r0
        and       255,r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      426,ir0
        sti       r0,*+fp(ir0)
	.line	107
;----------------------------------------------------------------------
; 911 | lsLicSdBuf.nCRC[1] = ConvHex2Asc(BYTE_L(WORD_H(btTmp)));               
;----------------------------------------------------------------------
        ldiu      *+fp(4),r0
        lsh       -8,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        subi      1,sp
        ldiu      427,ir0
        sti       r0,*+fp(ir0)
	.line	108
;----------------------------------------------------------------------
; 912 | lsLicSdBuf.nCRC[2] = ConvHex2Asc(BYTE_H(WORD_L(btTmp)));               
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *+fp(4),r0
        lsh       -4,r0
        and       15,r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      428,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	109
;----------------------------------------------------------------------
; 913 | lsLicSdBuf.nCRC[3] = ConvHex2Asc(BYTE_L(WORD_L(btTmp)));               
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *+fp(4),r0
        push      r0
        call      _ConvHex2Asc
                                        ; Call Occurs
        ldiu      429,ir0
        subi      1,sp
        sti       r0,*+fp(ir0)
	.line	110
;----------------------------------------------------------------------
; 914 | lsLicSdBuf.btEot = EOT;                                                
;----------------------------------------------------------------------
        ldiu      430,ir0
        ldiu      4,r0
        sti       r0,*+fp(ir0)
	.line	112
;----------------------------------------------------------------------
; 916 | user_PacTx((UCHAR *)&lsLicSdBuf,sizeof(LICSD));                        
;----------------------------------------------------------------------
        ldiu      24,r0
        push      r0
        ldiu      407,r0
        addi      fp,r0
        push      r0
        call      _user_PacTx
                                        ; Call Occurs
        subi      2,sp
	.line	114
;----------------------------------------------------------------------
; 918 | break;                                                                 
; 919 | default:                                                               
;----------------------------------------------------------------------
        bu        L268
;*      Branch Occurs to L268 
	.line	116
;----------------------------------------------------------------------
; 920 | break;                                                                 
; 924 | else                                                                   
;----------------------------------------------------------------------
	.line	69
L228:        
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      406,ir0
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
        beqd      L225
        subi      1,sp
        ldieq     407,ir0
        ldieq     1,r0
;*      Branch Occurs to L225 
        bu        L268
;*      Branch Occurs to L268 
L231:        
	.line	121
;----------------------------------------------------------------------
; 925 | if(WORD_L(pPa_PaBuf->phHdBuf.btSoh) == SOH &&  // PAC <-> PAC ¿¡¼­ »óÅÂ
;     |  Á¤º¸¸¦ ÃßÃâÇÑ´Ù.                                                      
; 926 |                 (TWOBYTE_ASC2HEX(pPa_PaBuf->phHdBuf.chDataLen)+16) >= (
;     | nRxPos) &&                                                             
; 927 |                 WORD_L(btRx3chBuf[nRxPos-1]) == EOT &&                 
; 928 |             //WORD_L(pPa_PaBuf->btEot) == EOT &&                       
; 929 |             //sizeof(PAC_PAC) == nRxPos &&                             
; 930 |                 //(TWOBYTE_ASC2HEX(pPa_PaBuf->phHdBuf.chSrcDev) == PAC_
;     | DEV_NO) &&                                                             
; 931 |             //(TWOBYTE_ASC2HEX(pPa_PaBuf->phHdBuf.chDestDev) == PAC_DEV
;     | _NO) &&                                                                
; 932 |                 //ConvAsc2Hex(pPa_PaBuf->nCRC[0]) == BYTE_H(WORD_H(crc1
;     | 6_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                  
; 933 |                 //ConvAsc2Hex(pPa_PaBuf->nCRC[1]) == BYTE_L(WORD_H(crc1
;     | 6_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                  
; 934 |                 //ConvAsc2Hex(pPa_PaBuf->nCRC[2]) == BYTE_H(WORD_L(crc1
;     | 6_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&                  
; 935 |                 //ConvAsc2Hex(pPa_PaBuf->nCRC[3]) == BYTE_L(WORD_L(crc1
;     | 6_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))                    
; 937 |             ConvAsc2Hex(WORD_L(btRx3chBuf[nRxPos-5])) == BYTE_H(WORD_H(
;     | crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&              
; 938 |                 ConvAsc2Hex(WORD_L(btRx3chBuf[nRxPos-4])) == BYTE_L(WOR
;     | D_H(crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&          
; 939 |                 ConvAsc2Hex(WORD_L(btRx3chBuf[nRxPos-3])) == BYTE_H(WOR
;     | D_L(crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&          
; 940 |                 ConvAsc2Hex(WORD_L(btRx3chBuf[nRxPos-2])) == BYTE_L(WOR
;     | D_L(crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))            
; 941 |             )                                                          
;----------------------------------------------------------------------
        ldiu      431,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
        cmpi      1,r0
        bne       L259
;*      Branch Occurs to L259 
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(9),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      431,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(10),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        addi      16,r0                 ; Unsigned
        cmpi      @_nRxPos$9+0,r0
        subi      1,sp
        blo       L259
;*      Branch Occurs to L259 
        ldiu      1,ir0
        ldiu      @CL76,ar0
        subri     @_nRxPos$9+0,ir0
        ldiu      255,r0
        and3      r0,*+ar0(ir0),r0
        cmpi      4,r0
        bne       L259
;*      Branch Occurs to L259 
        ldiu      1,r1
        ldiu      431,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      5,ir0
        ldiu      r0,r4
        lsh       -8,r4
        ldiu      @CL76,ar0
        subri     @_nRxPos$9+0,ir0
        subi      2,sp
        and       255,r4
        ldiu      255,r0
        lsh       -4,r4
        and       15,r4
        and3      r0,*+ar0(ir0),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L259
;*      Branch Occurs to L259 
        ldiu      1,r1
        ldiu      431,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      @CL76,ar0
        ldiu      4,ir0
        ldiu      255,r1
        ldiu      r0,r4
        subri     @_nRxPos$9+0,ir0
        subi      2,sp
        lsh       -8,r4
        and       15,r4
        and3      r1,*+ar0(ir0),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L259
;*      Branch Occurs to L259 
        ldiu      1,r1
        ldiu      431,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      3,ir0
        ldiu      @CL76,ar0
        ldiu      r0,r4
        subi      2,sp
        subri     @_nRxPos$9+0,ir0
        and       255,r4
        ldiu      255,r1
        lsh       -4,r4
        and       15,r4
        and3      r1,*+ar0(ir0),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L259
;*      Branch Occurs to L259 
        ldiu      1,r1
        ldiu      431,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      2,ir0
        ldiu      @CL76,ar0
        subri     @_nRxPos$9+0,ir0
        ldiu      255,r1
        ldiu      15,r4
        subi      2,sp
        and       r0,r4
        and3      r1,*+ar0(ir0),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L259
;*      Branch Occurs to L259 
	.line	139
;----------------------------------------------------------------------
; 943 | memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt));      
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
	.line	141
;----------------------------------------------------------------------
; 945 | pCommStatus_Lic = (COMMSTATUS_LIC *)m_Variable.m_btCommSt;             
;----------------------------------------------------------------------
        ldiu      435,ir0
        ldiu      @CL3,r0
        sti       r0,*+fp(ir0)
	.line	143
;----------------------------------------------------------------------
; 947 | m_Variable.m_TrainCofVal = TWOBYTE_ASC2HEX(pPa_PaBuf->sCCI); //// Â÷·®
;     | Áß·Ã »óÅÂ Á¤º¸¸¦ Àü´Þ.                                                 
;----------------------------------------------------------------------
        ldiu      431,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(149),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      431,ir0
        subi      1,sp
        ldiu      *+fp(ir0),ar0
        ldiu      r0,r4
        ldiu      *+ar0(150),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+337
        subi      1,sp
	.line	145
;----------------------------------------------------------------------
; 949 | if(m_Variable.m_TrainCofVal == 0x10 || m_Variable.m_TrainCofVal == 0x20
;     | )                                                                      
;----------------------------------------------------------------------
        cmpi      16,r0
        beq       L240
;*      Branch Occurs to L240 
        cmpi      32,r0
        bne       L241
;*      Branch Occurs to L241 
L240:        
	.line	147
;----------------------------------------------------------------------
; 951 | m_Variable.m_TrainCofVal = 0x01;                                       
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,@_m_Variable+337
L241:        
	.line	150
;----------------------------------------------------------------------
; 954 | m_Variable.m_btCiFaultVal = TWOBYTE_ASC2HEX(pPa_PaBuf->sCI_Fault); //CI
;     |  °íÀå Á¤º¸.                                                            
;----------------------------------------------------------------------
        ldiu      431,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(147),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      431,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(148),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        sti       r0,@_m_Variable+339
        subi      1,sp
	.line	152
;----------------------------------------------------------------------
; 956 | for(i=0;i<WORD_L(m_Variable.m_TrainCofVal);i++)                        
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        ldiu      255,r0
        and       @_m_Variable+337,r0
        ldiu      *+fp(1),r1
        cmpi3     r0,r1
        bge       L268
;*      Branch Occurs to L268 
L242:        
	.line	156
;----------------------------------------------------------------------
; 960 | FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[i][9][0],&sCarNumBCD_H,1); 
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      431,ir0
        ldiu      1,r2
        ldiu      @CL77,r1
        mpyi      22,r0
        addi3     r0,*+fp(ir0),r0       ; Unsigned
        push      r2
        addi      169,r0                ; Unsigned
        push      r1
        push      r0
        call      _FunConvAscHex
                                        ; Call Occurs
        subi      3,sp
	.line	157
;----------------------------------------------------------------------
; 961 | FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[i][10][0],&sCarNumBCD_L,1);
; 963 | //8·® ÀüÃ¼ ÇÁ·ÎÅäÄÝ¿¡¼­ ¿­¹øÀ» ÀÌ¿ëÇÏ¿© ÇöÀç ÀÚ½ÅÀÇ À§Ä¡¸¦ È®ÀÎ ÇÑ´Ù.  
;----------------------------------------------------------------------
        ldiu      431,ir0
        ldiu      *+fp(1),r0
        ldiu      1,r2
        ldiu      @CL78,r1
        mpyi      22,r0
        addi3     r0,*+fp(ir0),r0       ; Unsigned
        addi      171,r0                ; Unsigned
        push      r2
        push      r1
        push      r0
        call      _FunConvAscHex
                                        ; Call Occurs
        subi      3,sp
	.line	160
;----------------------------------------------------------------------
; 964 | if(DWORD_L(m_Variable.m_nCarNo) == MAKE_WORD(sCarNumBCD_H,sCarNumBCD_L)
;     | )                                                                      
; 966 |         // CI À§Ä¡ Á¤º¸ È®ÀÎ.                                          
;----------------------------------------------------------------------
        ldiu      255,r1
        ldiu      @_sCarNumBCD_H$12+0,r0
        and       @_sCarNumBCD_L$13+0,r1
        ash       8,r0
        or3       r0,r1,r0
        ldiu      @_m_Variable+340,r1
        and       65535,r0
        and       65535,r1
        cmpi3     r0,r1
        bne       L257
;*      Branch Occurs to L257 
	.line	163
;----------------------------------------------------------------------
; 967 | if(m_Variable.m_chCarKind == 'A')      {m_Variable.m_nCarPos = (i*2)+1;
;     | }                                                                      
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        cmpi      65,r0
        bne       L245
;*      Branch Occurs to L245 
        ldiu      *+fp(1),r0
        mpyi      2,r0
        addi      1,r0
        sti       r0,@_m_Variable+338
        bu        L247
;*      Branch Occurs to L247 
L245:        
	.line	164
;----------------------------------------------------------------------
; 968 | else if(m_Variable.m_chCarKind == 'B') {m_Variable.m_nCarPos = (i*2)+2;
;     | }                                                                      
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        cmpi      66,r0
        bne       L247
;*      Branch Occurs to L247 
        ldiu      *+fp(1),r0
        mpyi      2,r0
        addi      2,r0
        sti       r0,@_m_Variable+338
L247:        
	.line	166
;----------------------------------------------------------------------
; 970 | m_Variable.m_nCarPos =MAKE_WORD(ConvAsc2Hex(pPa_PaBuf->sCI_Index[m_Vari
;     | able.m_nCarPos][0]),                                                   
; 971 |                                     ConvAsc2Hex(pPa_PaBuf->sCI_Index[m_
;     | Variable.m_nCarPos][1]));                                              
; 974 | // MyPrintf("PAC - PAC / TrainCofVal : %02X -- CiFault : %02X -- CarPos
;     |  : %02X \r\n ",m_Variable.m_TrainCofVal,m_Variable.m_btCiFaultVal,m_Var
;     | iable.m_nCarPos);                                                      
; 984 | //ÀÚ½ÅÀÇ À§Ä¡¸¦ È®ÀÎ ÇÏ°í »óÅÂ °ªÀ» ÀÐ¾î ¿Â´Ù.                         
;----------------------------------------------------------------------
        ldiu      @_m_Variable+338,r0
        ldiu      431,ir0
        ash       1,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(131),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      431,ir0
        ldiu      r0,r4
        ldiu      @_m_Variable+338,r0
        ash       8,r4
        subi      1,sp
        ash       1,r0
        addi3     r0,*+fp(ir0),ar0      ; Unsigned
        ldiu      *+ar0(132),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       255,r0
        or3       r4,r0,r0
        and       65535,r0
        subi      1,sp
        sti       r0,@_m_Variable+338
	.line	181
;----------------------------------------------------------------------
; 985 | FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[i][0][0],btTmpBuf,22);     
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
        ldiu      431,ir0
        mpyi      22,r0
        addi3     r0,*+fp(ir0),r0       ; Unsigned
        ldiu      22,r2
        push      r2
        addi      151,r0                ; Unsigned
        ldiu      fp,r1
        addi      5,r1
        push      r1
        push      r0
        call      _FunConvAscHex
                                        ; Call Occurs
        subi      3,sp
	.line	183
;----------------------------------------------------------------------
; 987 | pPac_Pac_Sta = (CRA_STATION *) btTmpBuf;                               
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      fp,r0
        addi      5,r0
        sti       r0,*+fp(ir0)
	.line	186
;----------------------------------------------------------------------
; 990 | if(m_Variable.m_TrainCofVal)                                           
;----------------------------------------------------------------------
        ldi       @_m_Variable+337,r0
        beq       L252
;*      Branch Occurs to L252 
	.line	188
;----------------------------------------------------------------------
; 992 | m_Variable.m_TrainCofVal =m_Variable.m_TrainCofVal - 1; // ¿ìÁø ÇÁ·ÎÅäÄ
;     | Ý °ªÀÌ 1 ´õ Å©´Ù.                                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     @_m_Variable+337,r0
        sti       r0,@_m_Variable+337
	.line	190
;----------------------------------------------------------------------
; 994 | m_Variable.m_TrainCofVal = MIN(3,m_Variable.m_TrainCofVal);            
;----------------------------------------------------------------------
        ldiu      3,r0
        cmpi      @_m_Variable+337,r0
        bge       L250
;*      Branch Occurs to L250 
        bu        L251
;*      Branch Occurs to L251 
L250:        
        ldiu      @_m_Variable+337,r0
L251:        
        sti       r0,@_m_Variable+337
L252:        
	.line	194
;----------------------------------------------------------------------
; 998 | if(m_Variable.m_chCarKind == 'A')                                      
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        cmpi      65,r0
        bne       L255
;*      Branch Occurs to L255 
	.line	197
;----------------------------------------------------------------------
; 1001 | pCommStatus_Lic->BYTE_1.BIT.nCcp = pPac_Pac_Sta->CRA_2.BIT.sACCP1;     
;----------------------------------------------------------------------
        ldiu      433,ir1
        ldiu      435,ir0
        ldiu      8,r0
        ldiu      *+fp(ir1),ar1
        ldiu      *+fp(ir0),ar0
        and       *+ar1(1),r0
        ldiu      *ar0,r1
        lsh       -3,r0
        andn      128,r1
        and       1,r0
        ash       7,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	198
;----------------------------------------------------------------------
; 1002 | pCommStatus_Lic->BYTE_1.BIT.nCncs = pPac_Pac_Sta->CRA_3.BIT.sACNCS;    
;----------------------------------------------------------------------
        ldiu      435,ir1
        ldiu      433,ir0
        ldiu      1,r1
        ldiu      *+fp(ir1),ar0
        ldiu      *+fp(ir0),ar1
        ldiu      *ar0,r0
        and       *+ar1(2),r1
        andn      1,r0
        or3       r0,r1,r0
        sti       r0,*ar0
	.line	199
;----------------------------------------------------------------------
; 1003 | pCommStatus_Lic->BYTE_1.BIT.nGps = pPac_Pac_Sta->CRA_2.BIT.sAGPS;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      2,r0
        and       *+ar1(1),r0
        lsh       -1,r0
        ldiu      *+fp(ir1),ar0
        and       1,r0
        ldiu      *ar0,r1
        ash       5,r0
        andn      32,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	200
;----------------------------------------------------------------------
; 1004 | pCommStatus_Lic->BYTE_1.BIT.nLic = pPac_Pac_Sta->CRA_3.BIT.sALIC;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      4,r0
        and       *+ar1(2),r0
        lsh       -2,r0
        and       1,r0
        ldiu      *+fp(ir1),ar0
        ash       2,r0
        ldiu      *ar0,r1
        andn      4,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	201
;----------------------------------------------------------------------
; 1005 | pCommStatus_Lic->BYTE_1.BIT.nPac = pPac_Pac_Sta->CRA_3.BIT.sAPAC;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      8,r0
        ldiu      435,ir0
        and       *+ar0(2),r0
        lsh       -3,r0
        and       1,r0
        ldiu      *+fp(ir0),ar0
        ash       3,r0
        ldiu      *ar0,r1
        andn      8,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	202
;----------------------------------------------------------------------
; 1006 | pCommStatus_Lic->BYTE_1.BIT.nVoip = pPac_Pac_Sta->CRA_2.BIT.sAVOIP;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      4,r0
        and       *+ar0(1),r0
        ldiu      435,ir0
        lsh       -2,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ash       6,r0
        ldiu      *ar0,r1
        andn      64,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	203
;----------------------------------------------------------------------
; 1007 | pCommStatus_Lic->BYTE_1.BIT.nVtx = pPac_Pac_Sta->CRA_3.BIT.sAVTX;      
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      2,r0
        ldiu      *+fp(ir0),ar1
        ldiu      *+fp(ir1),ar0
        and       *+ar1(2),r0
        lsh       -1,r0
        and       1,r0
        ldiu      *ar0,r1
        andn      2,r1
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	204
;----------------------------------------------------------------------
; 1008 | pCommStatus_Lic->BYTE_1.BIT.nWlr = pPac_Pac_Sta->CRA_2.BIT.sAWLR;      
;----------------------------------------------------------------------
        ldiu      1,r0
        ldiu      *+fp(ir0),ar1
        ldiu      *+fp(ir1),ar0
        and       *+ar1(1),r0
        ldiu      *ar0,r1
        ash       4,r0
        andn      16,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	207
;----------------------------------------------------------------------
; 1011 | pCommStatus_Lic->BYTE_2.BIT.nFdi = pPac_Pac_Sta->CRA_4.BIT.sAFDI;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      4,r0
        and       *+ar0(3),r0
        ldiu      435,ir0
        lsh       -2,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ldiu      *+ar0(1),r1
        ash       6,r0
        andn      64,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	208
;----------------------------------------------------------------------
; 1012 | pCommStatus_Lic->BYTE_2.BIT.nPii1 = pPac_Pac_Sta->CRA_4.BIT.sAPII1;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      2,r0
        ldiu      *+fp(ir0),ar0
        ldiu      435,ir0
        and       *+ar0(3),r0
        ldiu      *+fp(ir0),ar0
        lsh       -1,r0
        ldiu      *+ar0(1),r1
        and       1,r0
        andn      32,r1
        ash       5,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	209
;----------------------------------------------------------------------
; 1013 | pCommStatus_Lic->BYTE_2.BIT.nPii2 = pPac_Pac_Sta->CRA_4.BIT.sAPII2;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      1,r0
        ldiu      *+fp(ir0),ar1
        ldiu      *+fp(ir1),ar0
        and       *+ar1(3),r0
        ldiu      *+ar0(1),r1
        ash       4,r0
        andn      16,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	210
;----------------------------------------------------------------------
; 1014 | pCommStatus_Lic->BYTE_2.BIT.nSdi1 = pPac_Pac_Sta->CRA_5.BIT.sASDI1;    
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      8,r0
        and       *+ar0(4),r0
        ldiu      435,ir0
        lsh       -3,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ldiu      *+ar0(1),r1
        ash       3,r0
        andn      8,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	211
;----------------------------------------------------------------------
; 1015 | pCommStatus_Lic->BYTE_2.BIT.nSdi2 = pPac_Pac_Sta->CRA_5.BIT.sASDI2;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      4,r0
        and       *+ar0(4),r0
        ldiu      435,ir0
        lsh       -2,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ldiu      *+ar0(1),r1
        andn      4,r1
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	212
;----------------------------------------------------------------------
; 1016 | pCommStatus_Lic->BYTE_2.BIT.nSdi3 = pPac_Pac_Sta->CRA_5.BIT.sASDI3;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar1
        ldiu      2,r0
        and       *+ar1(4),r0
        lsh       -1,r0
        ldiu      *+fp(ir1),ar0
        and       1,r0
        ldiu      *+ar0(1),r1
        ash       1,r0
        andn      2,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	213
;----------------------------------------------------------------------
; 1017 | pCommStatus_Lic->BYTE_2.BIT.nSdi4 = pPac_Pac_Sta->CRA_5.BIT.sASDI4;    
;----------------------------------------------------------------------
        ldiu      *+fp(ir1),ar0
        ldiu      *+fp(ir0),ar1
        ldiu      1,r1
        and       *+ar1(4),r1
        ldiu      *+ar0(1),r0
        andn      1,r0
        or3       r0,r1,r0
        sti       r0,*+ar0(1)
	.line	215
;----------------------------------------------------------------------
; 1019 | pCommStatus_Lic->BYTE_3.BIT.nPid1_1 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_1;
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      8,r0
        and       *+ar1(5),r0
        lsh       -3,r0
        ldiu      *+fp(ir1),ar0
        and       1,r0
        ldiu      *+ar0(2),r1
        andn      16,r1
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	216
;----------------------------------------------------------------------
; 1020 | pCommStatus_Lic->BYTE_3.BIT.nPid1_2 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_2;
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      4,r0
        and       *+ar1(5),r0
        lsh       -2,r0
        and       1,r0
        ldiu      *+fp(ir1),ar0
        ash       3,r0
        ldiu      *+ar0(2),r1
        andn      8,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	217
;----------------------------------------------------------------------
; 1021 | pCommStatus_Lic->BYTE_3.BIT.nPid1_3 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_3;
;----------------------------------------------------------------------
        ldiu      *+fp(ir1),ar0
        ldiu      2,r0
        ldiu      *+fp(ir0),ar1
        ldiu      *+ar0(2),r1
        and       *+ar1(5),r0
        andn      4,r1
        lsh       -1,r0
        and       1,r0
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	218
;----------------------------------------------------------------------
; 1022 | pCommStatus_Lic->BYTE_3.BIT.nPid1_4 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_4;
;----------------------------------------------------------------------
        ldiu      *+fp(ir1),ar0
        ldiu      *+fp(ir0),ar1
        ldiu      *+ar0(2),r1
        ldiu      1,r0
        andn      2,r1
        and       *+ar1(5),r0
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	219
;----------------------------------------------------------------------
; 1023 | pCommStatus_Lic->BYTE_3.BIT.nPid2_1 = pPac_Pac_Sta->CRA_7.BIT.sAPID2_1;
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      8,r0
        and       *+ar1(6),r0
        lsh       -3,r0
        ldiu      *+fp(ir1),ar0
        and       1,r0
        ldiu      *+ar0(2),r1
        andn      1,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	221
;----------------------------------------------------------------------
; 1025 | pCommStatus_Lic->BYTE_4.BIT.nDph = pPac_Pac_Sta->CRA_9.BIT.sADPH;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      8,r0
        and       *+ar0(8),r0
        ldiu      435,ir0
        lsh       -3,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ash       7,r0
        ldiu      *+ar0(3),r1
        andn      128,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(3)
	.line	222
;----------------------------------------------------------------------
; 1026 | pCommStatus_Lic->BYTE_4.BIT.nDpo = pPac_Pac_Sta->CRA_9.BIT.sADPO;      
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir1),ar0
        ldiu      *+fp(ir0),ar1
        ldiu      1,r0
        and       *+ar1(8),r0
        ldiu      *+ar0(3),r1
        ash       4,r0
        andn      16,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(3)
	.line	223
;----------------------------------------------------------------------
; 1027 | pCommStatus_Lic->BYTE_4.BIT.nPei1 = pPac_Pac_Sta->CRA_7.BIT.sAPEI1;    
;----------------------------------------------------------------------
        ldiu      *+fp(ir1),ar0
        ldiu      *+ar0(3),r0
        ldiu      *+fp(ir0),ar1
        ldiu      1,r1
        andn      1,r0
        and       *+ar1(6),r1
        or3       r0,r1,r0
        sti       r0,*+ar0(3)
	.line	224
;----------------------------------------------------------------------
; 1028 | pCommStatus_Lic->BYTE_4.BIT.nPei2 = pPac_Pac_Sta->CRA_7.BIT.sAPEI2;    
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      2,r0
        and       *+ar0(6),r0
        ldiu      435,ir0
        lsh       -1,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ldiu      *+ar0(3),r1
        ash       1,r0
        andn      2,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(3)
	.line	228
;----------------------------------------------------------------------
; 1032 | break;                                                                 
;----------------------------------------------------------------------
        bu        L268
;*      Branch Occurs to L268 
L255:        
	.line	230
;----------------------------------------------------------------------
; 1034 | else if(m_Variable.m_chCarKind == 'B') //ÇÁ·ÎÅäÄÝ¿¡´Â MA ¿­Â÷ ¹øÈ£¸¸ ÀÖ
;     | À¸¹Ç·Î MB´Â ½º½º·Î ÀÎ½Ä ÇØ¾ß ÇÑ´Ù.                                     
;----------------------------------------------------------------------
        ldiu      @_m_Variable+341,r0
        cmpi      66,r0
        bne       L257
;*      Branch Occurs to L257 
	.line	232
;----------------------------------------------------------------------
; 1036 | pCommStatus_Lic->BYTE_1.BIT.nCcp = pPac_Pac_Sta->CRA_2.BIT.sBCCP1;     
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      435,ir1
        ldiu      128,r0
        ldiu      *+fp(ir0),ar1
        ldiu      *+fp(ir1),ar0
        and       *+ar1(1),r0
        ldiu      *ar0,r1
        lsh       -7,r0
        andn      128,r1
        and       1,r0
        ash       7,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	233
;----------------------------------------------------------------------
; 1037 | pCommStatus_Lic->BYTE_1.BIT.nCncs = pPac_Pac_Sta->CRA_3.BIT.sBCNCS;    
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      16,r0
        ldiu      *+fp(ir1),ar0
        and       *+ar1(2),r0
        ldiu      *ar0,r1
        lsh       -4,r0
        andn      1,r1
        and       1,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	234
;----------------------------------------------------------------------
; 1038 | pCommStatus_Lic->BYTE_1.BIT.nGps = pPac_Pac_Sta->CRA_2.BIT.sBGPS;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      32,r0
        and       *+ar1(1),r0
        lsh       -5,r0
        and       1,r0
        ldiu      *+fp(ir1),ar0
        ash       5,r0
        ldiu      *ar0,r1
        andn      32,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	235
;----------------------------------------------------------------------
; 1039 | pCommStatus_Lic->BYTE_1.BIT.nLic = pPac_Pac_Sta->CRA_3.BIT.sBLIC;      
;----------------------------------------------------------------------
        ldiu      64,r0
        ldiu      *+fp(ir0),ar1
        ldiu      *+fp(ir1),ar0
        and       *+ar1(2),r0
        ldiu      *ar0,r1
        lsh       -6,r0
        andn      4,r1
        and       1,r0
        ash       2,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	236
;----------------------------------------------------------------------
; 1040 | pCommStatus_Lic->BYTE_1.BIT.nPac = pPac_Pac_Sta->CRA_3.BIT.sBPAC;      
;----------------------------------------------------------------------
        ldiu      128,r0
        ldiu      *+fp(ir0),ar0
        ldiu      435,ir0
        and       *+ar0(2),r0
        ldiu      *+fp(ir0),ar0
        ldiu      *ar0,r1
        lsh       -7,r0
        andn      8,r1
        and       1,r0
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	237
;----------------------------------------------------------------------
; 1041 | pCommStatus_Lic->BYTE_1.BIT.nVoip = pPac_Pac_Sta->CRA_2.BIT.sBVOIP;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      64,r0
        ldiu      435,ir0
        and       *+ar0(1),r0
        lsh       -6,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ldiu      *ar0,r1
        andn      64,r1
        ash       6,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	238
;----------------------------------------------------------------------
; 1042 | pCommStatus_Lic->BYTE_1.BIT.nVtx = pPac_Pac_Sta->CRA_3.BIT.sBVTX;      
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar1
        ldiu      32,r0
        and       *+ar1(2),r0
        lsh       -5,r0
        ldiu      *+fp(ir1),ar0
        and       1,r0
        ldiu      *ar0,r1
        ash       1,r0
        andn      2,r1
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	239
;----------------------------------------------------------------------
; 1043 | pCommStatus_Lic->BYTE_1.BIT.nWlr = pPac_Pac_Sta->CRA_2.BIT.sBWLR;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      16,r0
        ldiu      435,ir0
        and       *+ar0(1),r0
        ldiu      *+fp(ir0),ar0
        lsh       -4,r0
        ldiu      *ar0,r1
        and       1,r0
        andn      16,r1
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*ar0
	.line	242
;----------------------------------------------------------------------
; 1046 | pCommStatus_Lic->BYTE_2.BIT.nFdi = pPac_Pac_Sta->CRA_4.BIT.sBFDI;      
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      64,r0
        ldiu      *+fp(ir1),ar0
        ldiu      *+fp(ir0),ar1
        ldiu      *+ar0(1),r1
        and       *+ar1(3),r0
        lsh       -6,r0
        and       1,r0
        ash       6,r0
        andn      64,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	243
;----------------------------------------------------------------------
; 1047 | pCommStatus_Lic->BYTE_2.BIT.nPii1 = pPac_Pac_Sta->CRA_4.BIT.sBPII1;    
;----------------------------------------------------------------------
        ldiu      32,r0
        ldiu      *+fp(ir0),ar0
        ldiu      435,ir0
        and       *+ar0(3),r0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(1),r1
        andn      32,r1
        lsh       -5,r0
        and       1,r0
        ash       5,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	244
;----------------------------------------------------------------------
; 1048 | pCommStatus_Lic->BYTE_2.BIT.nPii2 = pPac_Pac_Sta->CRA_4.BIT.sBPII2;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      16,r0
        ldiu      435,ir0
        and       *+ar0(3),r0
        lsh       -4,r0
        and       1,r0
        ldiu      *+fp(ir0),ar0
        ash       4,r0
        ldiu      *+ar0(1),r1
        andn      16,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	245
;----------------------------------------------------------------------
; 1049 | pCommStatus_Lic->BYTE_2.BIT.nSdi1 = pPac_Pac_Sta->CRA_5.BIT.sBSDI1;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      435,ir0
        ldiu      128,r0
        and       *+ar0(4),r0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(1),r1
        andn      8,r1
        lsh       -7,r0
        and       1,r0
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	246
;----------------------------------------------------------------------
; 1050 | pCommStatus_Lic->BYTE_2.BIT.nSdi2 = pPac_Pac_Sta->CRA_5.BIT.sBSDI2;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      64,r0
        and       *+ar0(4),r0
        lsh       -6,r0
        ldiu      435,ir0
        and       1,r0
        ldiu      *+fp(ir0),ar0
        ash       2,r0
        ldiu      *+ar0(1),r1
        andn      4,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	247
;----------------------------------------------------------------------
; 1051 | pCommStatus_Lic->BYTE_2.BIT.nSdi3 = pPac_Pac_Sta->CRA_5.BIT.sBSDI3;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar1
        ldiu      32,r0
        ldiu      *+fp(ir1),ar0
        and       *+ar1(4),r0
        ldiu      *+ar0(1),r1
        lsh       -5,r0
        andn      2,r1
        and       1,r0
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	248
;----------------------------------------------------------------------
; 1052 | pCommStatus_Lic->BYTE_2.BIT.nSdi4 = pPac_Pac_Sta->CRA_5.BIT.sBSDI4;    
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      16,r0
        ldiu      *+fp(ir1),ar0
        and       *+ar1(4),r0
        ldiu      *+ar0(1),r1
        lsh       -4,r0
        andn      1,r1
        and       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(1)
	.line	250
;----------------------------------------------------------------------
; 1054 | pCommStatus_Lic->BYTE_3.BIT.nPid1_1 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_1;
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      128,r0
        ldiu      435,ir0
        and       *+ar0(5),r0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(2),r1
        lsh       -7,r0
        andn      16,r1
        and       1,r0
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	251
;----------------------------------------------------------------------
; 1055 | pCommStatus_Lic->BYTE_3.BIT.nPid1_2 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_2;
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      64,r0
        ldiu      *+fp(ir0),ar0
        ldiu      435,ir0
        and       *+ar0(5),r0
        ldiu      *+fp(ir0),ar0
        lsh       -6,r0
        ldiu      *+ar0(2),r1
        andn      8,r1
        and       1,r0
        ash       3,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	252
;----------------------------------------------------------------------
; 1056 | pCommStatus_Lic->BYTE_3.BIT.nPid1_3 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_3;
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      32,r0
        and       *+ar0(5),r0
        ldiu      435,ir0
        lsh       -5,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ash       2,r0
        ldiu      *+ar0(2),r1
        andn      4,r1
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	253
;----------------------------------------------------------------------
; 1057 | pCommStatus_Lic->BYTE_3.BIT.nPid1_4 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_4;
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar1
        ldiu      16,r0
        and       *+ar1(5),r0
        ldiu      *+fp(ir1),ar0
        lsh       -4,r0
        ldiu      *+ar0(2),r1
        andn      2,r1
        and       1,r0
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	254
;----------------------------------------------------------------------
; 1058 | pCommStatus_Lic->BYTE_3.BIT.nPid2_1 = pPac_Pac_Sta->CRA_7.BIT.sBPID2_1;
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar1
        ldiu      *+fp(ir1),ar0
        ldiu      128,r0
        ldiu      *+ar0(2),r1
        and       *+ar1(6),r0
        andn      1,r1
        lsh       -7,r0
        and       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(2)
	.line	256
;----------------------------------------------------------------------
; 1060 | pCommStatus_Lic->BYTE_4.BIT.nDph = pPac_Pac_Sta->CRA_9.BIT.sBDPH;      
;----------------------------------------------------------------------
        ldiu      128,r0
        ldiu      *+fp(ir1),ar0
        ldiu      *+fp(ir0),ar1
        ldiu      *+ar0(3),r1
        and       *+ar1(8),r0
        andn      128,r1
        lsh       -7,r0
        and       1,r0
        ash       7,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(3)
	.line	257
;----------------------------------------------------------------------
; 1061 | pCommStatus_Lic->BYTE_4.BIT.nDpo = pPac_Pac_Sta->CRA_9.BIT.sBDPO;      
;----------------------------------------------------------------------
        ldiu      *+fp(ir0),ar0
        ldiu      16,r0
        and       *+ar0(8),r0
        ldiu      435,ir0
        lsh       -4,r0
        ldiu      *+fp(ir0),ar0
        and       1,r0
        ldiu      *+ar0(3),r1
        andn      16,r1
        ash       4,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(3)
	.line	258
;----------------------------------------------------------------------
; 1062 | pCommStatus_Lic->BYTE_4.BIT.nPei1 = pPac_Pac_Sta->CRA_7.BIT.sBPEI1;    
;----------------------------------------------------------------------
        ldiu      433,ir1
        ldiu      *+fp(ir1),ar1
        ldiu      16,r0
        ldiu      *+fp(ir0),ar0
        and       *+ar1(6),r0
        ldiu      *+ar0(3),r1
        lsh       -4,r0
        andn      1,r1
        and       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(3)
	.line	259
;----------------------------------------------------------------------
; 1063 | pCommStatus_Lic->BYTE_4.BIT.nPei2 = pPac_Pac_Sta->CRA_7.BIT.sBPEI2;    
;----------------------------------------------------------------------
        ldiu      433,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      32,r0
        ldiu      435,ir0
        and       *+ar0(6),r0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(3),r1
        lsh       -5,r0
        andn      2,r1
        and       1,r0
        ash       1,r0
        or3       r1,r0,r0
        sti       r0,*+ar0(3)
	.line	262
;----------------------------------------------------------------------
; 1066 | break;                                                                 
; 1074 | else                                                                   
;----------------------------------------------------------------------
        bu        L268
;*      Branch Occurs to L268 
L257:        
	.line	152
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        ldiu      255,r0
        ldiu      *+fp(1),r1
        and       @_m_Variable+337,r0
        cmpi3     r0,r1
        blt       L242
;*      Branch Occurs to L242 
        bu        L268
;*      Branch Occurs to L268 
L259:        
	.line	271
;----------------------------------------------------------------------
; 1075 | if(WORD_L(pCcp_Pac->phHdBuf.btSoh) == SOH &&  // CCP -> PAC ¿¡¼­ »óÅÂ Á
;     | ¤º¸¸¦ ÃßÃâÇÑ´Ù.                                                        
; 1076 |         WORD_L(pCcp_Pac->btEot) == EOT &&                              
; 1077 |         sizeof(CCP_PAC) == nRxPos &&                                   
; 1078 |         (TWOBYTE_ASC2HEX(pCcp_Pac->phHdBuf.chSrcDev) == CCP_DEV_NO) && 
; 1079 |         (TWOBYTE_ASC2HEX(pCcp_Pac->phHdBuf.chDestDev) == PAC_DEV_NO)&& 
; 1081 |         ConvAsc2Hex(pCcp_Pac->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&pC
;     | cp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))&&                              
; 1082 |         ConvAsc2Hex(pCcp_Pac->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&pC
;     | cp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))&&                              
; 1083 |         ConvAsc2Hex(pCcp_Pac->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&pC
;     | cp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))&&                              
; 1084 |         ConvAsc2Hex(pCcp_Pac->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&pC
;     | cp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))                                
; 1085 |         )                                                              
; 1088 |         //FunConvAscHex((char *)&pCcp_Pac->sCCP_Date[0][0],btTmpBuf,12)
;     | ;                                                                      
; 1090 |         //memcpy(&m_Variable.m_tmCurTime.second,btTmpBuf,6);           
;----------------------------------------------------------------------
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and3      r0,*ar0,r0
        cmpi      1,r0
        bne       L268
;*      Branch Occurs to L268 
        ldiu      *+fp(ir0),ar0
        ldiu      255,r0
        and       *+ar0(155),r0
        cmpi      4,r0
        bne       L268
;*      Branch Occurs to L268 
        ldiu      156,r0
        cmpi      @_nRxPos$9+0,r0
        bne       L268
;*      Branch Occurs to L268 
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(1),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      432,ir0
        subi      1,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(2),r0
        ash       4,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        and       15,r0
        or3       r4,r0,r0
        and       255,r0
        cmpi      17,r0
        subi      1,sp
        bne       L268
;*      Branch Occurs to L268 
        ldiu      432,ir0
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(3),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        ldiu      432,ir0
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
        cmpi      33,r0
        subi      1,sp
        bne       L268
;*      Branch Occurs to L268 
        ldiu      1,r1
        ldiu      432,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      432,ir0
        ldiu      r0,r4
        subi      2,sp
        lsh       -8,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(151),r0
        lsh       -4,r4
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L268
;*      Branch Occurs to L268 
        ldiu      1,r0
        ldiu      432,ir0
        ldiu      6,r2
        addi3     r0,*+fp(ir0),r1       ; Unsigned
        ldiu      @_nRxPos$9+0,r0
        subi      r2,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        subi      2,sp
        ldiu      432,ir0
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        lsh       -8,r4
        ldiu      *+ar0(152),r0
        and       15,r4
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L268
;*      Branch Occurs to L268 
        ldiu      1,r1
        ldiu      432,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      432,ir0
        subi      2,sp
        ldiu      r0,r4
        ldiu      *+fp(ir0),ar0
        and       255,r4
        ldiu      *+ar0(153),r0
        lsh       -4,r4
        push      r0
        and       15,r4
        call      _ConvAsc2Hex
                                        ; Call Occurs
        cmpi3     r4,r0
        subi      1,sp
        bne       L268
;*      Branch Occurs to L268 
        ldiu      1,r1
        ldiu      432,ir0
        ldiu      6,r0
        addi3     r1,*+fp(ir0),r1       ; Unsigned
        subri     @_nRxPos$9+0,r0
        push      r0
        push      r1
        call      _crc16_ccitt
                                        ; Call Occurs
        ldiu      432,ir0
        subi      2,sp
        ldiu      *+fp(ir0),ar0
        ldiu      *+ar0(154),r0
        push      r0
        call      _ConvAsc2Hex
                                        ; Call Occurs
        subi      1,sp
L268:        
	.line	297
;----------------------------------------------------------------------
; 1101 | nOldUart3RxOneByteGapDelayTime = m_Variable.m_nUart3RxOneByteGapDelayTi
;     | me;                                                                    
;----------------------------------------------------------------------
        ldiu      @_m_Variable+290,r0
        sti       r0,@_nOldUart3RxOneByteGapDelayTime$10+0
	.line	298
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      437,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	1102,000000010h,435


	.sect	 ".text"

	.global	_GetLocalTimeToUTC
	.sym	_GetLocalTimeToUTC,_GetLocalTimeToUTC,36,2,0
	.func	1107
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
; 1107 | BOOL GetLocalTimeToUTC( DATE_TIME_PTR pLocal, int nHour, DATE_TIME_PTR
;     | pUTC )                                                                 
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      5,sp
        push      r4
	.line	2
;----------------------------------------------------------------------
; 1109 | // ½Ã°£À» °è»êÇÏ´Â ºÎºÐ.                                               
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 1110 | int nHourT = pLocal->hour - nHour;                                     
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      *-fp(3),r0
        subri     *+ar0(2),r0           ; Unsigned
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 1111 | int nDayT = pLocal->day;                                               
;----------------------------------------------------------------------
        ldiu      *+ar0(3),r0
        sti       r0,*+fp(2)
	.line	6
;----------------------------------------------------------------------
; 1112 | int nLastDays = GetDaysOfMonth( pLocal->month, pLocal->year );
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
; 1113 | int nMonthT = pLocal->month;                                           
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      *+ar0(4),r0
        sti       r0,*+fp(4)
	.line	8
;----------------------------------------------------------------------
; 1114 | int nYearT = 2000 + pLocal->year;                                      
; 1116 | // ½Ã°£ Á¤º¸¸¦ ±¸ÇÏ´Â ºÎºÐ.                                            
;----------------------------------------------------------------------
        ldiu      2000,r0
        addi      *+ar0(5),r0           ; Unsigned
        sti       r0,*+fp(5)
	.line	11
;----------------------------------------------------------------------
; 1117 | if(nHourT < 0 ) {                                                      
;----------------------------------------------------------------------
        ldi       *+fp(1),r0
        bge       L273
;*      Branch Occurs to L273 
	.line	12
;----------------------------------------------------------------------
; 1118 | nHourT += 24;                                                          
;----------------------------------------------------------------------
        ldiu      24,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
	.line	13
;----------------------------------------------------------------------
; 1119 | nDayT += -1;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *+fp(2),r0
        sti       r0,*+fp(2)
        bu        L275
;*      Branch Occurs to L275 
L273:        
	.line	15
;----------------------------------------------------------------------
; 1121 | else if( 24 <= nHourT ) {                                              
;----------------------------------------------------------------------
        ldiu      24,r0
        cmpi      *+fp(1),r0
        bgt       L275
;*      Branch Occurs to L275 
	.line	16
;----------------------------------------------------------------------
; 1122 | nHourT -= 24;                                                          
;----------------------------------------------------------------------
        subri     *+fp(1),r0
        sti       r0,*+fp(1)
	.line	17
;----------------------------------------------------------------------
; 1123 | nDayT += 1;                                                            
; 1126 | // ÀÏÀÚ¸¦ ±¸ÇÏ´Â ºÎºÐ.                                                 
; 1127 | // ½Ã°£À» °è»êÇÏ¿© ÀÏÀÚ¸¦ º¯°æÇØ¾ßÇÏ´Â °æ¿ì.                           
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      *+fp(2),r0
        sti       r0,*+fp(2)
L275:        
	.line	22
;----------------------------------------------------------------------
; 1128 | if(nDayT < 1)
;     |                                                                        
;     |                                                                        
;     |                                                                        
;----------------------------------------------------------------------
        ldi       *+fp(2),r0
        bgt       L278
;*      Branch Occurs to L278 
	.line	24
;----------------------------------------------------------------------
; 1130 | nDayT = GetDaysOfMonth( nMonthT, nYearT );                             
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
; 1132 | if(--nMonthT < 1)                                                      
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *+fp(4),r0
        bgtd      L281
        sti       r0,*+fp(4)
	nop
        ldile     1,r0
;*      Branch Occurs to L281 
	.line	28
;----------------------------------------------------------------------
; 1134 | nYearT--;                                                              
;----------------------------------------------------------------------
        subri     *+fp(5),r0
        sti       r0,*+fp(5)
	.line	29
;----------------------------------------------------------------------
; 1135 | nMonthT = 12;                                                          
;----------------------------------------------------------------------
        ldiu      12,r0
        sti       r0,*+fp(4)
        bu        L281
;*      Branch Occurs to L281 
L278:        
	.line	32
;----------------------------------------------------------------------
; 1138 | else if(nLastDays < nDayT)                                             
;----------------------------------------------------------------------
        ldiu      *+fp(3),r0
        cmpi      *+fp(2),r0
        bge       L281
;*      Branch Occurs to L281 
	.line	34
;----------------------------------------------------------------------
; 1140 | nDayT = 1;                                                             
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(2)
	.line	36
;----------------------------------------------------------------------
; 1142 | if(12 < ++nMonthT)                                                     
;----------------------------------------------------------------------
        ldiu      12,r1
        addi      *+fp(4),r0
        cmpi3     r0,r1
        bged      L281
        sti       r0,*+fp(4)
	nop
        ldilt     1,r0
;*      Branch Occurs to L281 
	.line	38
;----------------------------------------------------------------------
; 1144 | nYearT++;                                                              
;----------------------------------------------------------------------
        addi      *+fp(5),r0
        sti       r0,*+fp(5)
	.line	39
;----------------------------------------------------------------------
; 1145 | nMonthT = 1;                                                           
; 1149 | // °è»êµÈ ½ÃºÐÃÊ Á¤º¸¸¦ UTC ½Ã°£À¸·Î ÀÌµ¿½ÃÅ°´Â ºÎºÐ.                  
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(4)
L281:        
	.line	44
;----------------------------------------------------------------------
; 1150 | pUTC->second = pLocal->second;                                         
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar0
        ldiu      *-fp(4),ar1
        ldiu      *ar0,r0
        sti       r0,*ar1
	.line	45
;----------------------------------------------------------------------
; 1151 | pUTC->minute = pLocal->minute;                                         
;----------------------------------------------------------------------
        ldiu      *-fp(2),ar1
        ldiu      *-fp(4),ar0
        ldiu      *+ar1(1),r0
        sti       r0,*+ar0(1)
	.line	46
;----------------------------------------------------------------------
; 1152 | pUTC->hour = nHourT;                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      *+fp(1),r0
        sti       r0,*+ar0(2)
	.line	47
;----------------------------------------------------------------------
; 1153 | pUTC->day = nDayT;                                                     
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      *+fp(2),r0
        sti       r0,*+ar0(3)
	.line	48
;----------------------------------------------------------------------
; 1154 | pUTC->month = nMonthT;                                                 
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      *+fp(4),r0
        sti       r0,*+ar0(4)
	.line	49
;----------------------------------------------------------------------
; 1155 | pUTC->year = nYearT - 2000;                                            
; 1157 | return      (( 10 <= pUTC->year ) &&
;     |                                                                        
;     |                                   // 10³â ÀÌ»ó                         
; 1158 |                         (( 1 <= pUTC->month ) && ( pUTC->month <= 12 ))
;     |  &&                                                                    
;     |                   // ¿ù                                                
; 1159 |                         (( 1 <= pUTC->day )   && ( pUTC->day <= GetDays
;     | OfMonth(nMonthT, nYearT) )) &&                           // ÀÏ         
; 1160 |                         (( 0 <= pUTC->hour )  && ( pUTC->hour < 24 ))
;     |  &&                                                                    
;     |                   // ½Ã                                                
; 1161 |                         (( 0 <= pUTC->minute) && ( pUTC->minute < 60 ))
;     |  &&                                                                    
;     |                   // ºÐ                                                
;----------------------------------------------------------------------
        ldiu      2000,r0
        ldiu      *-fp(4),ar0
        subri     *+fp(5),r0            ; Unsigned
        sti       r0,*+ar0(5)
	.line	56
;----------------------------------------------------------------------
; 1162 | (( 0 <= pUTC->second) && ( pUTC->second < 60 )));
;     |                                                                  // ÃÊ 
;----------------------------------------------------------------------
        ldiu      *-fp(4),ar0
        ldiu      10,r0
        cmpi      *+ar0(5),r0
        ldiu      0,r4
        bhi       L292
;*      Branch Occurs to L292 
        ldiu      1,r0
        cmpi      *+ar0(4),r0
        bhi       L292
;*      Branch Occurs to L292 
        ldiu      *+ar0(4),r0
        cmpi      12,r0
        bhi       L292
;*      Branch Occurs to L292 
        ldiu      1,r0
        cmpi      *+ar0(3),r0
        bhi       L292
;*      Branch Occurs to L292 
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
        bhi       L292
;*      Branch Occurs to L292 
        ldiu      0,r0
        cmpi      *+ar0(2),r0
        bhi       L292
;*      Branch Occurs to L292 
        ldiu      *+ar0(2),r0
        cmpi      24,r0
        bhs       L292
;*      Branch Occurs to L292 
        ldiu      0,r0
        cmpi3     *+ar0,r0
        bhi       L292
;*      Branch Occurs to L292 
        ldiu      *+ar0(1),r0
        cmpi      60,r0
        bhs       L292
;*      Branch Occurs to L292 
        ldiu      0,r0
        cmpi3     *ar0,r0
        bhi       L292
;*      Branch Occurs to L292 
        ldiu      *ar0,r0
        cmpi      60,r0
        ldilo     1,r4
L292:        
	.line	57
        ldiu      r4,r0
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      7,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	1163,000000010h,5


	.sect	 ".text"

	.global	_IsLeapYear
	.sym	_IsLeapYear,_IsLeapYear,36,2,0
	.func	1168
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
; 1168 | int IsLeapYear( int nYear )
;     |                  // À±³â Á¤º¸¸¦ ±¸ÇÏ´Â ºÎºÐ.                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 1170 | if( nYear % 400 == 0 )                                                 
;----------------------------------------------------------------------
        ldiu      400,r1
        ldiu      *-fp(2),r0
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L297
;*      Branch Occurs to L297 
	.line	4
;----------------------------------------------------------------------
; 1171 | return 1;                                                              
;----------------------------------------------------------------------
        bud       L302
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L302 
L297:        
	.line	6
;----------------------------------------------------------------------
; 1173 | if( nYear % 100 == 0 )                                                 
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        ldiu      100,r1
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L299
;*      Branch Occurs to L299 
	.line	7
;----------------------------------------------------------------------
; 1174 | return 0;                                                              
;----------------------------------------------------------------------
        bud       L302
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L302 
L299:        
	.line	9
;----------------------------------------------------------------------
; 1176 | if( nYear % 4 == 0 )                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(2),r1
        ldiu      r1,r0
        ash       -1,r0
        lsh       @CL79,r0
        addi3     r0,r1,r0
        andn      3,r0
        subri     r1,r0
        bne       L301
;*      Branch Occurs to L301 
	.line	10
;----------------------------------------------------------------------
; 1177 | return 1;                                                              
;----------------------------------------------------------------------
        bud       L302
	nop
	nop
        ldiu      1,r0
;*      Branch Occurs to L302 
L301:        
	.line	12
;----------------------------------------------------------------------
; 1179 | return 0;                                                              
;----------------------------------------------------------------------
        ldiu      0,r0
L302:        
	.line	13
        ldiu      *-fp(1),ar1
        ldiu      *fp,fp
        subi      2,sp
        bu        ar1
;*      Branch Occurs to ar1 
	.endfunc	1180,000000000h,0


	.sect	 ".text"

	.global	_GetDaysOfMonth
	.sym	_GetDaysOfMonth,_GetDaysOfMonth,36,2,0
	.func	1182
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
; 1182 | int GetDaysOfMonth( int nMonth, int nYear )
;     |  // ´ÞÀÇ ¸¶Áö¸· ÀÏÀÚ¸¦ ±¸ÇÏ´Â ºÎºÐ.                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	4
;----------------------------------------------------------------------
; 1185 | int nDays = 0;                                                         
; 1187 | switch( nMonth )                                                       
; 1189 | case 1 :
;     |                                  // 31À» ¸¶Áö¸· ³¯´Þ                   
; 1190 | case 3 :                                                               
; 1191 | case 5 :                                                               
; 1192 | case 7 :                                                               
; 1193 | case 8 :                                                               
; 1194 | case 10 :                                                              
; 1195 | case 12 :                                                              
;----------------------------------------------------------------------
        bud       L310
        addi      1,sp
        ldiu      0,r0
        sti       r0,*+fp(1)
;*      Branch Occurs to L310 
L305:        
	.line	15
;----------------------------------------------------------------------
; 1196 | nDays = 31;                                                            
;----------------------------------------------------------------------
        ldiu      31,r0
        sti       r0,*+fp(1)
	.line	16
;----------------------------------------------------------------------
; 1197 | break;                                                                 
; 1198 | case 2 :                                                               
;----------------------------------------------------------------------
        bu        L312
;*      Branch Occurs to L312 
L306:        
	.line	18
;----------------------------------------------------------------------
; 1199 | nDays = 28;                                                            
;----------------------------------------------------------------------
        ldiu      28,r0
        sti       r0,*+fp(1)
	.line	19
;----------------------------------------------------------------------
; 1200 | if( IsLeapYear( nYear ) )
;     |          // À±³âÀ» °è»êÇÏ¿©, À±´ÞÀÏ °æ¿ì, +1                           
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        push      r0
        call      _IsLeapYear
                                        ; Call Occurs
        cmpi      0,r0
        subi      1,sp
        beq       L312
;*      Branch Occurs to L312 
	.line	20
;----------------------------------------------------------------------
; 1201 | nDays += 1;                                                            
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
	.line	21
;----------------------------------------------------------------------
; 1202 | break;                                                                 
; 1203 | case 4 :
;     |                                  // 30À» ¸¶Áö¸· ³¯´Þ                   
; 1204 | case 6 :                                                               
; 1205 | case 9 :                                                               
; 1206 | case 11 :                                                              
;----------------------------------------------------------------------
        bu        L312
;*      Branch Occurs to L312 
L308:        
	.line	26
;----------------------------------------------------------------------
; 1207 | nDays = 30;                                                            
;----------------------------------------------------------------------
        ldiu      30,r0
        sti       r0,*+fp(1)
	.line	27
;----------------------------------------------------------------------
; 1208 | break;                                                                 
;----------------------------------------------------------------------
        bu        L312
;*      Branch Occurs to L312 
L310:        
	.line	6
        ldiu      1,r0
        ldiu      *-fp(2),ir0
        subri     ir0,r0
        cmpi      11,r0
        bhi       L312
;*      Branch Occurs to L312 
        subi      1,ir0
        ldiu      @CL80,ar0
        ldiu      *+ar0(ir0),r0
        bu        r0

	.sect	".text"
SW0:	.word	L305	; 1
	.word	L306	; 2
	.word	L305	; 3
	.word	L308	; 4
	.word	L305	; 5
	.word	L308	; 6
	.word	L305	; 7
	.word	L305	; 8
	.word	L308	; 9
	.word	L305	; 10
	.word	L308	; 11
	.word	L305	; 12
	.sect	".text"
;*      Branch Occurs to r0 
L312:        
	.line	30
;----------------------------------------------------------------------
; 1211 | return nDays;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	31
        ldiu      *-fp(1),bk
        ldiu      *fp,fp
        subi      3,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	1212,000000000h,1


	.sect	 ".text"

	.global	_user_CarNoForCarKindToLon
	.sym	_user_CarNoForCarKindToLon,_user_CarNoForCarKindToLon,32,2,0
	.func	1218
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
; 1218 | void user_CarNoForCarKindToLon()                                       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 1220 | m_Variable.m_nCarKindToLonCnt = 0;                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_Variable+342
	.line	4
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	1221,000000000h,0


	.sect	 ".text"

	.global	_user_1msLoop
	.sym	_user_1msLoop,_user_1msLoop,32,2,0
	.func	1227
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
; 1227 | void user_1msLoop()                                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 1229 | m_Variable.m_nTxDbg1msTimer++;                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+350,r0   ; Unsigned
        sti       r0,@_m_Variable+350
	.line	4
;----------------------------------------------------------------------
; 1230 | m_Variable.m_nUserDebug1msTimer++;                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+291,r0   ; Unsigned
        sti       r0,@_m_Variable+291
	.line	6
;----------------------------------------------------------------------
; 1232 | m_Variable.m_nTest1msTimer++;                                          
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_Variable+292,r0   ; Unsigned
        sti       r0,@_m_Variable+292
	.line	9
;----------------------------------------------------------------------
; 1235 | if(m_Variable.m_nUart2RxOneByteGapDelayTime) m_Variable.m_nUart2RxOneBy
;     | teGapDelayTime--;                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+289,r0
        beq       L320
;*      Branch Occurs to L320 
        ldiu      1,r0
        subri     @_m_Variable+289,r0   ; Unsigned
        sti       r0,@_m_Variable+289
L320:        
	.line	10
;----------------------------------------------------------------------
; 1236 | if(m_Variable.m_nUart3RxOneByteGapDelayTime) m_Variable.m_nUart3RxOneBy
;     | teGapDelayTime--;                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+290,r0
        beq       L322
;*      Branch Occurs to L322 
        ldiu      1,r0
        subri     @_m_Variable+290,r0   ; Unsigned
        sti       r0,@_m_Variable+290
L322:        
	.line	12
;----------------------------------------------------------------------
; 1238 | if(m_Variable.m_nGiaRxCheck1msTimer) m_Variable.m_nGiaRxCheck1msTimer--
;     | ;                                                                      
;----------------------------------------------------------------------
        ldi       @_m_Variable+429,r0
        beq       L324
;*      Branch Occurs to L324 
        ldiu      1,r0
        subri     @_m_Variable+429,r0   ; Unsigned
        sti       r0,@_m_Variable+429
L324:        
	.line	14
;----------------------------------------------------------------------
; 1240 | if(m_Variable.m_nCncsRxCheck1msTimer) m_Variable.m_nCncsRxCheck1msTimer
;     | --;                                                                    
;----------------------------------------------------------------------
        ldi       @_m_Variable+428,r0
        beq       L326
;*      Branch Occurs to L326 
        ldiu      1,r0
        subri     @_m_Variable+428,r0   ; Unsigned
        sti       r0,@_m_Variable+428
L326:        
	.line	18
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	1244,000000000h,0



	.global	_m_Variable
	.bss	_m_Variable,438
	.sym	_m_Variable,_m_Variable,8,2,14016,.fake69
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
	.bss	CL79,1
	.bss	CL80,1

	.sect	".cinit"
	.field  	80,32
	.field  	CL1+0,32
	.field  	11534336,32
	.field  	16776716,32
	.field  	_m_Variable+307,32
	.field  	_m_Variable+315,32
	.field  	_m_Variable+323,32
	.field  	_m_Variable+352,32
	.field  	_m_Variable+388,32
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
	.field  	_btRx3chBuf$3,32
	.field  	12582912,32
	.field  	_btRx2chBuf$6,32
	.field  	_m_Variable+300,32
	.field  	_m_Variable+293,32
	.field  	12582912,32
	.field  	-25,32
	.field  	_btTx2chBuf$7,32
	.field  	_m_Variable+432,32
	.field  	11534336,32
	.field  	_btRx3chBuf$11,32
	.field  	_sCarNumBCD_H$12,32
	.field  	_sCarNumBCD_L$13,32
	.field  	-30,32
	.field  	SW0,32

	.sect	".text"
;******************************************************************************
;* UNDEFINED EXTERNAL REFERENCES                                              *
;******************************************************************************

	.global	_sprintf

	.global	_memset

	.global	_strcpy

	.global	_strlen

	.global	_ConvDec2Hex

	.global	_IsNumAsc

	.global	_ConvHex2Asc

	.global	_ConvAsc2Hex

	.global	_GetFirmwareVersion

	.global	_Make1ByteBcc

	.global	_FunConvAscHex

	.global	_FunConvHexAsc

	.global	_crc16_ccitt

	.global	_DebugLoop

	.global	_xr16l784_RtsDelayStartSend

	.global	_xr16l784_Send

	.global	_xr16l784_GetRxBuffer2Ch

	.global	_xr16l784_GetRxBuffer1Ch

	.global	_xr16l784_GetRxBuffer3Ch

	.global	_LonWorkLoop
	.global	MOD_I30
	.global	DIV_I30
	.global	_memcpy
