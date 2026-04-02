;******************************************************************************
;* TMS320C3x/4x ANSI C Code Generator                            Version 5.11 *
;* Date/Time created: Thu Sep 17 04:53:26 2015                                *
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
;	c:\lang\tms320c3x\511\bin\ac30.exe main.c C:\Users\JDS\AppData\Local\Temp\main.if 
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
	.stag	.fake69,14048
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
	.member	_m_btCttSignalA,13600,9,8,32,.fake70
	.member	_m_btCttSignalB,13632,12,8,32
	.member	_m_LIC_CNCS_TimSetFlag,13664,4,8,32
	.member	_m_LIC_GIA_TimSetFlag,13696,4,8,32
	.member	_m_nCncsRxCheck1msTimer,13728,14,8,32
	.member	_m_nGiaRxCheck1msTimer,13760,14,8,32
	.member	_m_btTestOtherCiFault,13792,12,8,32
	.member	_m_bCiFaultFlag,13824,4,8,32
	.member	_m_tFaultInfo,13856,56,8,192,.fake68,2
	.eos
	.sym	_VARIABLE_H,0,8,13,14048,.fake69
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
	.func	109
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
; 109 | void main(void)                                                        
; 111 | int i;                                                                 
; 112 | DATE_TIME_TYPE tmBuf;                                                  
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      8,sp
	.line	6
;----------------------------------------------------------------------
; 114 | DINT;                                                                  
;----------------------------------------------------------------------
	AND	0DFFFh, ST	
	.line	7
;----------------------------------------------------------------------
; 115 | WDI_ACT;                                                               
;----------------------------------------------------------------------
        ldiu      8192,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	8
;----------------------------------------------------------------------
; 116 | DspInit();                                                             
;----------------------------------------------------------------------
        call      _DspInit
                                        ; Call Occurs
	.line	9
;----------------------------------------------------------------------
; 117 | Debug3xInit(TMS320C31);                                                
;----------------------------------------------------------------------
        ldiu      31,r0
        push      r0
        call      _Debug3xInit
                                        ; Call Occurs
        subi      1,sp
	.line	11
;----------------------------------------------------------------------
; 119 | XR16L784_TXDIS(XR16L784_1CHL);                                         
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
; 120 | XR16L784_TXDIS(XR16L784_2CHL);                                         
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
; 121 | XR16L784_TXDIS(XR16L784_3CHL);                                         
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
; 122 | XR16L784_TXDIS(XR16L784_4CHL);                                         
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
; 124 | xr16l784_Init(XR16L784_1CHL,38400,XR16L784_DATA8,XR16L784_NONEPARITY,XR
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
; 125 | xr16l784_Init(XR16L784_2CHL,38400,XR16L784_DATA8,XR16L784_NONEPARITY,XR
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
; 126 | xr16l784_Init(XR16L784_3CHL,19200,XR16L784_DATA8,XR16L784_NONEPARITY,XR
;     | 16L784_1STOPBIT); // LIC <-> PAC                                       
; 127 | //xr16l784_Init(XR16L784_4CHL,19200,XR16L784_DATA8,XR16L784_NONEPARITY,
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
; 129 | WDI_ACT;                                                               
;----------------------------------------------------------------------
        ldiu      8192,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	22
;----------------------------------------------------------------------
; 130 | EINT;                                                                  
;----------------------------------------------------------------------
	OR	02000h, ST	
	.line	23
;----------------------------------------------------------------------
; 131 | user_Init();                                                           
; 134 | while(1)                                                               
;----------------------------------------------------------------------
        call      _user_Init
                                        ; Call Occurs
L2:        
	.line	28
;----------------------------------------------------------------------
; 136 | user_Loop();                                                           
;----------------------------------------------------------------------
        call      _user_Loop
                                        ; Call Occurs
	.line	29
;----------------------------------------------------------------------
; 137 | xr16l784_Loop();                                                       
;----------------------------------------------------------------------
        call      _xr16l784_Loop
                                        ; Call Occurs
	.line	31
;----------------------------------------------------------------------
; 139 | if(!XR16L784_INT_ST) xr16l784_Isr();                                   
;----------------------------------------------------------------------
        ldiu      @CL2,ar0
        ldiu      -2,r0
        lsh3      r0,*ar0,r0
        tstb      1,r0
        calleq    _xr16l784_Isr
                                        ; Call Occurs
	.line	33
;----------------------------------------------------------------------
; 141 | if(m_nDebug1msTimer > 500)                                             
;----------------------------------------------------------------------
        ldiu      @_m_nDebug1msTimer+0,r0
        cmpi      500,r0
        bls       L4
;*      Branch Occurs to L4 
	.line	35
;----------------------------------------------------------------------
; 143 | m_nDebug1msTimer = 0;                                                  
; 145 | //xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)"1234567",7,5);    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,@_m_nDebug1msTimer+0
L4:        
	.line	40
;----------------------------------------------------------------------
; 148 | m_nDebugCnt++;                                                         
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nDebugCnt+0,r0
        sti       r0,@_m_nDebugCnt+0
	.line	42
        bu        L2
;*      Branch Occurs to L2 
	.line	43
	.endfunc	151,000000000h,8


	.sect	 ".text"

	.global	_DspInit
	.sym	_DspInit,_DspInit,32,2,0
	.func	155
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
; 155 | void DspInit(void)                                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	3
;----------------------------------------------------------------------
; 157 | PRIMBUSREG = 0x10e8;                                                   
;----------------------------------------------------------------------
        ldiu      @CL3,ar0
        ldiu      4328,r0
        sti       r0,*ar0
	.line	4
;----------------------------------------------------------------------
; 158 | EN_CACHE;                                                              
; 160 | // Timer 0                                                             
;----------------------------------------------------------------------
   OR	00800h, ST	
	.line	7
;----------------------------------------------------------------------
; 161 | TMR0_CTRL = 0x2c0 ; // 내부 클럭                                       
;----------------------------------------------------------------------
        ldiu      @CL4,ar0
        ldiu      704,r0
        sti       r0,*ar0
	.line	8
;----------------------------------------------------------------------
; 162 | TMR0_PERD = 25000; // 100,000,000MHz / 4 / 25000(x) = 1000Hz(1000us)   
;----------------------------------------------------------------------
        ldiu      @CL5,ar0
        ldiu      25000,r0
        sti       r0,*ar0
	.line	10
;----------------------------------------------------------------------
; 164 | INT1_VECT                       = OP_BR | (int)c_int02; // Ext Int 0
;     |                                                                        
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        ldiu      @CL6,ar0
        or        @CL8,r0
        sti       r0,*ar0
	.line	11
;----------------------------------------------------------------------
; 165 | INT2_VECT                       = OP_BR | (int)c_int03; // Ext Int 1
;     |                                                                        
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        ldiu      @CL9,ar0
        or        @CL10,r0
        sti       r0,*ar0
	.line	12
;----------------------------------------------------------------------
; 166 | TINT0_VECT                      = OP_BR | (int)c_int10; // Timer 0
;     |                                                                        
; 168 | //EI_INT0;                                                             
;----------------------------------------------------------------------
        ldiu      @CL7,r0
        ldiu      @CL11,ar0
        or        @CL12,r0
        sti       r0,*ar0
	.line	15
;----------------------------------------------------------------------
; 169 | EI_INT2;                                                               
;----------------------------------------------------------------------
	OR	00004h, IE	
	.line	16
;----------------------------------------------------------------------
; 170 | EI_TINT0;                                                              
; 172 | // XF0, XF1 출력 모드                                                  
;----------------------------------------------------------------------
 OR        00100h, IE 
	.line	19
;----------------------------------------------------------------------
; 173 | asm(" LDI 0066h,IOF");                                                 
;----------------------------------------------------------------------
 LDI 0066h,IOF
	.line	21
;----------------------------------------------------------------------
; 175 | BOOT2INT;                                                              
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
	.endfunc	176,000000000h,0


	.sect	 ".text"

	.global	_BCD_BIN
	.sym	_BCD_BIN,_BCD_BIN,45,2,0
	.func	183
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
; 183 | WORD BCD_BIN(WORD nInput)                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 185 | WORD sNum = 0;                                                         
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	5
;----------------------------------------------------------------------
; 187 | sNum += ((nInput>>12)&0xf) * 1000;                                     
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        lsh       -12,r0
        and       15,r0
        mpyi      1000,r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	6
;----------------------------------------------------------------------
; 188 | sNum += ((nInput>>8)&0xf) * 100;                                       
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        lsh       -8,r0
        and       15,r0
        mpyi      100,r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	7
;----------------------------------------------------------------------
; 189 | sNum += ((nInput>>4)&0xf) * 10;                                        
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        lsh       -4,r0
        and       15,r0
        mpyi      10,r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	8
;----------------------------------------------------------------------
; 190 | sNum += ((nInput)&0xf) * 1;                                            
;----------------------------------------------------------------------
        ldiu      15,r0
        and       *-fp(2),r0
        addi      *+fp(1),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	9
;----------------------------------------------------------------------
; 191 | return sNum;                                                           
;----------------------------------------------------------------------
	.line	10
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	192,000000000h,1


	.sect	 ".text"

	.global	_ConvAsc2Hex
	.sym	_ConvAsc2Hex,_ConvAsc2Hex,44,2,0
	.func	197
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
; 197 | UCHAR ConvAsc2Hex(char chDat)                                          
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 199 | int nBuf = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 200 | if(chDat >= '0' && chDat <= '9') nBuf = chDat-'0';                     
; 201 | else                                                                   
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
; 202 | if(chDat >= 'a' && chDat <= 'f') nBuf = ((chDat-'a') + 10);
;     |                                                                        
; 203 | else                                                                   
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
; 204 | if(chDat >= 'A' && chDat <= 'F') nBuf = ((chDat-'A') + 10);            
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
; 206 | return nBuf;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	11
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	207,000000000h,1


	.sect	 ".text"

	.global	_FunConvAscHex
	.sym	_FunConvAscHex,_FunConvAscHex,36,2,0
	.func	212
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
; 212 | int FunConvAscHex(char *InchData,UCHAR *OuthexData,int Len)            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
        push      r4
        push      ar4
	.line	2
;----------------------------------------------------------------------
; 214 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 215 | int sCnt = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 216 | for(i=0;i<Len; )                                                       
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      *-fp(4),r0
        bge       L27
;*      Branch Occurs to L27 
L26:        
	.line	7
;----------------------------------------------------------------------
; 218 | OuthexData[sCnt] = (ConvAsc2Hex(InchData[i++])<<4)&0xF0;               
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
; 219 | OuthexData[sCnt] |= ConvAsc2Hex(InchData[i++])&0x0F;                   
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
; 221 | sCnt++;                                                                
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
; 223 | return sCnt;                                                           
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
	.endfunc	224,000001010h,2


	.sect	 ".text"

	.global	_IsNumAsc
	.sym	_IsNumAsc,_IsNumAsc,36,2,0
	.func	229
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
; 229 | BOOL IsNumAsc(char nCh)                                                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 231 | if(nCh >= '0' && nCh <= '9') return TRUE;                              
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
; 232 | return FALSE;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
L34:        
	.line	5
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      2,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	233,000000000h,0


	.sect	 ".text"

	.global	_ConvAsc2Dec
	.sym	_ConvAsc2Dec,_ConvAsc2Dec,36,2,0
	.func	238
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
; 238 | int ConvAsc2Dec(char nCh)                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 240 | int nBuf = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 241 | if(nCh >= '0' && nCh <= '9') nBuf = nCh-'0'; else return 0;            
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
; 242 | return nBuf;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
L41:        
	.line	6
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	243,000000000h,1


	.sect	 ".text"

	.global	_ConvHex2Asc
	.sym	_ConvHex2Asc,_ConvHex2Asc,34,2,0
	.func	248
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
; 248 | char ConvHex2Asc(UCHAR btCh)                                           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 250 | char chBuf = '0';                                                      
;----------------------------------------------------------------------
        ldiu      48,r0
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 251 | if(btCh >= 0 && btCh <= 9) chBuf = btCh+'0';                           
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
; 252 | else if(btCh >= 10 && btCh <= 15) chBuf = (btCh-10)+'A';               
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
; 253 | return chBuf;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(1),r0
	.line	7
        ldiu      *-fp(1),r1
        ldiu      *fp,fp
        subi      3,sp
        bu        r1
;*      Branch Occurs to r1 
	.endfunc	254,000000000h,1


	.sect	 ".text"

	.global	_ConvDec2Hex
	.sym	_ConvDec2Hex,_ConvDec2Hex,36,2,0
	.func	258
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
; 258 | int ConvDec2Hex(char nCh)                                              
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 260 | return ((((nCh / 0x10) & 0x0F) << 4) | ((nCh % 0x10) & 0x0F));         
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
	.endfunc	261,000000000h,0


	.sect	 ".text"

	.global	_FunConvHexAsc
	.sym	_FunConvHexAsc,_FunConvHexAsc,36,2,0
	.func	263
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
; 263 | int FunConvHexAsc(UCHAR *InhexData,char *OUTAscData,int Len)           
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
        push      r4
        push      r5
	.line	2
;----------------------------------------------------------------------
; 265 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 266 | int sCnt = 0;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 267 | for(i=0;i<Len;i++)                                                     
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
; 269 | OUTAscData[sCnt++] = ConvHex2Asc(BYTE_H(InhexData[i]));                
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
; 270 | OUTAscData[sCnt++] = ConvHex2Asc(BYTE_L(InhexData[i]));                
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
; 272 | return sCnt;                                                           
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
	.endfunc	273,000000030h,2


	.sect	 ".text"

	.global	_Dec2Str
	.sym	_Dec2Str,_Dec2Str,32,2,0
	.func	277
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
; 277 | void Dec2Str(char *pBuf,int nDat)                                      
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      34,sp
	.line	2
;----------------------------------------------------------------------
; 279 | int i;                                                                 
; 280 | int nPos;                                                              
; 281 | char szBuf[32];                                                        
;----------------------------------------------------------------------
	.line	7
;----------------------------------------------------------------------
; 283 | nPos=0;                                                                
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	8
;----------------------------------------------------------------------
; 284 | szBuf[nPos++] = (nDat/1000000000%10)+'0';                              
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
; 285 | szBuf[nPos++] = (nDat/100000000%10)+'0';                               
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
; 286 | szBuf[nPos++] = (nDat/10000000%10)+'0';                                
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
; 287 | szBuf[nPos++] = (nDat/1000000%10)+'0';                                 
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
; 288 | szBuf[nPos++] = (nDat/100000%10)+'0';                                  
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
; 289 | szBuf[nPos++] = (nDat/10000%10)+'0';                                   
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
; 290 | szBuf[nPos++] = (nDat/1000%10)+'0';                                    
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
; 291 | szBuf[nPos++] = (nDat/100%10)+'0';                                     
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
; 292 | szBuf[nPos++] = (nDat/10%10)+'0';                                      
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
; 293 | szBuf[nPos++] = (nDat%10)+'0';                                         
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
; 294 | szBuf[nPos] = NULL;                                                    
;----------------------------------------------------------------------
        ldiu      fp,ar0
        addi      3,ar0
        ldiu      *+fp(2),ir0
        ldiu      0,r0
        sti       r0,*+ar0(ir0)
	.line	20
;----------------------------------------------------------------------
; 296 | for(i=0;i<nPos;i++) if(szBuf[i]!='0') break;                           
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
; 297 | i = MIN(i,nPos-1);                                                     
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
; 299 | StrCpy(pBuf,&szBuf[i]);                                                
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
	.endfunc	300,000000000h,34


	.sect	 ".text"

	.global	_StrCat
	.sym	_StrCat,_StrCat,32,2,0
	.func	305
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
; 305 | void StrCat(char *dest, const char *src)                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 307 | char *r1 = dest - 1;                                                   
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
L70:        
	.line	4
;----------------------------------------------------------------------
; 308 | while (*++r1);                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldi       *++ar0(1),r0
        sti       ar0,*+fp(1)
        bne       L70
;*      Branch Occurs to L70 
L71:        
	.line	5
;----------------------------------------------------------------------
; 309 | while ((*r1++ = *src++) != 0);                                         
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
	.endfunc	310,000000000h,1


	.sect	 ".text"

	.global	_StrLen
	.sym	_StrLen,_StrLen,36,2,0
	.func	315
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
; 315 | int StrLen(const char *string)                                         
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 317 | const char *r1 = string - 1;                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
L75:        
	.line	4
;----------------------------------------------------------------------
; 318 | while (*++r1);                                                         
;----------------------------------------------------------------------
        ldiu      *+fp(1),ar0
        ldi       *++ar0(1),r0
        sti       ar0,*+fp(1)
        bne       L75
;*      Branch Occurs to L75 
	.line	5
;----------------------------------------------------------------------
; 319 | return r1 - string;                                                    
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        subri     *+fp(1),r0            ; Unsigned
	.line	6
        ldiu      *-fp(1),ar0
        ldiu      *fp,fp
        subi      3,sp
        bu        ar0
;*      Branch Occurs to ar0 
	.endfunc	320,000000000h,1


	.sect	 ".text"

	.global	_StrCpy
	.sym	_StrCpy,_StrCpy,32,2,0
	.func	325
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
; 325 | void StrCpy(char *dest, const char *src)                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 327 | char *result = dest;                                                   
;----------------------------------------------------------------------
        ldiu      *-fp(2),r0
        sti       r0,*+fp(1)
L80:        
	.line	4
;----------------------------------------------------------------------
; 328 | while ((*dest++ = *src++) != 0);                                       
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
	.endfunc	329,000000000h,1


	.sect	 ".text"

	.global	_StrCmp
	.sym	_StrCmp,_StrCmp,36,2,0
	.func	334
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
; 334 | int StrCmp(const char *string1, const char *string2)                   
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 336 | char *r1 = (char *)string1 - 1;                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(2),r0            ; Unsigned
        sti       r0,*+fp(1)
	.line	4
;----------------------------------------------------------------------
; 337 | char *r2 = (char *)string2 - 1;                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        subri     *-fp(3),r0            ; Unsigned
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 338 | char cp = TRUE;                                                        
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(3)
L84:        
	.line	7
;----------------------------------------------------------------------
; 340 | while ( (*++r2 == (cp = *++r1)) && cp );                               
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
; 342 | return *r1 - *r2;                                                      
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
	.endfunc	343,000000000h,3


	.sect	 ".text"

	.global	_MyPrintf
	.sym	_MyPrintf,_MyPrintf,32,2,0
	.func	348
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
; 348 | void MyPrintf(char * format, ... )                                     
; 350 | va_list args;                                                          
; 351 | char szBuf[256];                                                       
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      257,sp
	.line	6
;----------------------------------------------------------------------
; 353 | va_start(args, format);                                                
;----------------------------------------------------------------------
        ldiu      fp,r0
        addi      -2,r0
        sti       r0,*+fp(1)
	.line	7
;----------------------------------------------------------------------
; 354 | vsprintf(szBuf, format, args);                                         
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
; 356 | xr16l784_Send(XR16L784_1CHL,(UCHAR *)szBuf,strlen(szBuf));             
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
	.endfunc	357,000000000h,257


	.sect	 ".text"

	.global	_FirmwareVersionStrCmp
	.sym	_FirmwareVersionStrCmp,_FirmwareVersionStrCmp,36,2,0
	.func	362
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
; 362 | BOOL FirmwareVersionStrCmp(char *pObj,char *pSrc,int nLen)             
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 364 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 365 | BOOL bFlag = TRUE;                                                     
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 366 | for(i=0;i<nLen;i++) if(pObj[i] != pSrc[i]) {bFlag = FALSE; break;}     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      *-fp(4),r0
        bge       L96
;*      Branch Occurs to L96 
L93:        
        ldiu      *+fp(1),ar0
        ldiu      *-fp(3),ir0
        ldiu      *-fp(2),ir1
        ldiu      ar0,ar1
        cmpi3     *+ar0(ir0),*+ar1(ir1)
        beq       L95
;*      Branch Occurs to L95 
        ldiu      0,r0
        sti       r0,*+fp(2)
        bu        L96
;*      Branch Occurs to L96 
L95:        
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *-fp(4),r0
        blt       L93
;*      Branch Occurs to L93 
L96:        
	.line	6
;----------------------------------------------------------------------
; 367 | return bFlag;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	7
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      4,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	368,000000000h,2


	.sect	 ".text"

	.global	_GetFirmwareVersion
	.sym	_GetFirmwareVersion,_GetFirmwareVersion,36,2,0
	.func	375
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
; 375 | int GetFirmwareVersion(UCHAR nVerBuildData)                            
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
        push      r4
	.line	2
;----------------------------------------------------------------------
; 377 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 378 | int nVer = 100;                                                        
; 379 | char *pVersionString;                                                  
;----------------------------------------------------------------------
        ldiu      100,r0
        sti       r0,*+fp(2)
	.line	7
;----------------------------------------------------------------------
; 381 | for(i=0;i<128;i++)                                                     
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        bge       L109
;*      Branch Occurs to L109 
L100:        
	.line	9
;----------------------------------------------------------------------
; 383 | pVersionString = (char *)m_pBoardIdInfo[i];                            
;----------------------------------------------------------------------
        ldiu      *+fp(1),ir0
        ldiu      @CL19,ar0
        ldi       *+ar0(ir0),r0
        sti       r0,*+fp(3)
	.line	10
;----------------------------------------------------------------------
; 384 | if(pVersionString == NULL) break;                                      
;----------------------------------------------------------------------
        beq       L109
;*      Branch Occurs to L109 
	.line	12
;----------------------------------------------------------------------
; 386 | if(WORD_L(nVerBuildData) == 1)                                         
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(2),r0
        cmpi      1,r0
        bne       L105
;*      Branch Occurs to L105 
	.line	14
;----------------------------------------------------------------------
; 388 | if(FirmwareVersionStrCmp("Version",pVersionString,7))                  
;----------------------------------------------------------------------
        ldiu      7,r0
        push      r0
        ldiu      *+fp(3),r1
        ldiu      @CL20,r0
        push      r1
        push      r0
        call      _FirmwareVersionStrCmp
                                        ; Call Occurs
        cmpi      0,r0
        subi      3,sp
        beq       L108
;*      Branch Occurs to L108 
	.line	16
;----------------------------------------------------------------------
; 390 | nVer = ConvAsc2Dec(pVersionString[8])*1000+ConvAsc2Dec(pVersionString[1
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
; 391 | break;                                                                 
;----------------------------------------------------------------------
        bu        L109
;*      Branch Occurs to L109 
L105:        
	.line	20
;----------------------------------------------------------------------
; 394 | else if(WORD_L(nVerBuildData) == 2)                                    
;----------------------------------------------------------------------
        ldiu      255,r0
        and       *-fp(2),r0
        cmpi      2,r0
        bne       L108
;*      Branch Occurs to L108 
	.line	22
;----------------------------------------------------------------------
; 396 | if(FirmwareVersionStrCmp("Date",pVersionString,4))                     
;----------------------------------------------------------------------
        ldiu      4,r0
        ldiu      @CL21,r1
        push      r0
        ldiu      *+fp(3),r0
        push      r0
        push      r1
        call      _FirmwareVersionStrCmp
                                        ; Call Occurs
        cmpi      0,r0
        subi      3,sp
        beq       L108
;*      Branch Occurs to L108 
	.line	24
;----------------------------------------------------------------------
; 398 | nVer = ConvAsc2Dec(pVersionString[7])*100000+ConvAsc2Dec(pVersionString
;     | [8])*10000+ConvAsc2Dec(pVersionString[10])*1000+                       
; 399 |        ConvAsc2Dec(pVersionString[11])*100+ConvAsc2Dec(pVersionString[1
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
; 400 | break;                                                                 
;----------------------------------------------------------------------
        bu        L109
;*      Branch Occurs to L109 
L108:        
	.line	7
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      128,r0
        blt       L100
;*      Branch Occurs to L100 
L109:        
	.line	31
;----------------------------------------------------------------------
; 405 | return nVer;                                                           
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	32
        ldiu      *-fp(1),bk
        pop       r4
        ldiu      *fp,fp
        subi      5,sp
        bu        bk
;*      Branch Occurs to bk 
	.endfunc	406,000000010h,3


	.sect	 ".text"

	.global	_Make1ByteBcc
	.sym	_Make1ByteBcc,_Make1ByteBcc,44,2,0
	.func	411
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
; 411 | UCHAR Make1ByteBcc(UCHAR *pDat,int nLen)                               
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 413 | int i;                                                                 
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 414 | UCHAR btBcc = 0x00;                                                    
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 415 | for(i=0;i<nLen;i++)     btBcc ^= pDat[i];                              
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        bge       L114
;*      Branch Occurs to L114 
L113:        
        ldiu      *-fp(2),ir0
        ldiu      *+fp(1),ar0
        ldiu      *+ar0(ir0),r0
        xor       *+fp(2),r0
        sti       r0,*+fp(2)
        ldiu      1,r0
        addi      *+fp(1),r0
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        blt       L113
;*      Branch Occurs to L113 
L114:        
	.line	6
;----------------------------------------------------------------------
; 416 | return btBcc;                                                          
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	7
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      4,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	417,000000000h,2


	.sect	 ".text"

	.global	_MakeBcc
	.sym	_MakeBcc,_MakeBcc,32,2,0
	.func	422
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
; 422 | void MakeBcc(UCHAR *pDat,int nLen)                                     
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      1,sp
	.line	2
;----------------------------------------------------------------------
; 424 | int i;                                                                 
;----------------------------------------------------------------------
	.line	5
;----------------------------------------------------------------------
; 426 | pDat[nLen] = pDat[nLen+1] = 0x00;                                      
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
; 428 | for(i=0;i<nLen;i++)     pDat[nLen + (i&0x01)] ^= pDat[i];              
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        bge       L119
;*      Branch Occurs to L119 
L118:        
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
        blt       L118
;*      Branch Occurs to L118 
L119:        
	.line	8
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      3,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	429,000000000h,1


	.sect	 ".text"

	.global	_IsBccOk
	.sym	_IsBccOk,_IsBccOk,36,2,0
	.func	435
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
; 435 | int IsBccOk(UCHAR *pDat,int nLen)                                      
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      3,sp
	.line	2
;----------------------------------------------------------------------
; 437 | int i;                                                                 
; 438 | UCHAR nBCC[2];                                                         
;----------------------------------------------------------------------
	.line	6
;----------------------------------------------------------------------
; 440 | nBCC[0] = nBCC[1] = 0x00;                                              
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
; 442 | for(i=0;i<nLen;i++)                                                    
;----------------------------------------------------------------------
        sti       r0,*+fp(1)
        ldiu      255,r1
        ldiu      1,r2
        cmpi      *-fp(3),r0
        bge       L123
;*      Branch Occurs to L123 
L122:        
	.line	10
;----------------------------------------------------------------------
; 444 | nBCC[(i&0x01)] ^= WORD_L(pDat[i]);                                     
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
        blt       L122
;*      Branch Occurs to L122 
L123:        
	.line	13
;----------------------------------------------------------------------
; 447 | if(nBCC[0] != WORD_L(pDat[nLen]) || nBCC[1] != WORD_L(pDat[nLen+1]))   
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      255,r0
        ldiu      *-fp(2),ir0
        addi      2,ar0
        ldiu      *-fp(3),ar1
        ldiu      *ar0,r1
        and3      r0,*+ar1(ir0),r0
        cmpi3     r0,r1
        bne       L125
;*      Branch Occurs to L125 
        ldiu      fp,ar0
        ldiu      255,r0
        addi      3,ar0
        addi      *-fp(2),ar1           ; Unsigned
        ldiu      *ar0,r1
        and       *+ar1(1),r0
        cmpi3     r0,r1
        beq       L127
;*      Branch Occurs to L127 
L125:        
	.line	15
;----------------------------------------------------------------------
; 449 | return FALSE;                                                          
; 451 | else                                                                   
;----------------------------------------------------------------------
        bud       L128
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L128 
L127:        
	.line	19
;----------------------------------------------------------------------
; 453 | return TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
L128:        
	.line	21
        ldiu      *-fp(1),ir1
        ldiu      *fp,fp
        subi      5,sp
        bu        ir1
;*      Branch Occurs to ir1 
	.endfunc	455,000000000h,3


	.sect	 ".text"

	.global	_crc16_ccitt
	.sym	_crc16_ccitt,_crc16_ccitt,45,2,0
	.func	461
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
; 461 | WORD crc16_ccitt(UCHAR *buf, int len)                                  
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      2,sp
	.line	2
;----------------------------------------------------------------------
; 463 | WORD counter;                                                          
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 464 | WORD crc = 0xFFFF;                                                     
;----------------------------------------------------------------------
        ldiu      @CL22,r0
        sti       r0,*+fp(2)
	.line	5
;----------------------------------------------------------------------
; 465 | for( counter = 0; counter < len; counter++)                            
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
        cmpi      *-fp(3),r0
        bhs       L132
;*      Branch Occurs to L132 
L131:        
	.line	6
;----------------------------------------------------------------------
; 466 | crc = (crc<<8) ^ crc16tab[((crc>>8)^buf[counter])&0x00FF];             
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
        ldiu      *-fp(2),ir0
        ldiu      *+fp(1),ar0
        ldiu      r0,r1
        ldiu      @CL23,ar1
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
        blo       L131
;*      Branch Occurs to L131 
L132:        
	.line	7
;----------------------------------------------------------------------
; 467 | return crc;                                                            
;----------------------------------------------------------------------
        ldiu      *+fp(2),r0
	.line	8
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      4,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	468,000000000h,2



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
	.func	474
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
; 474 | BOOL gm_SysTimeToRtc(DATE_TIME_PTR pTime,UINT nSysTime)                
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
        addi      19,sp
	.line	2
;----------------------------------------------------------------------
; 476 | BOOL bSec;                                                             
;----------------------------------------------------------------------
	.line	4
;----------------------------------------------------------------------
; 477 | int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };       
; 478 | int nTemp;                                                             
;----------------------------------------------------------------------
        ldiu      @CL24,ar1
        ldiu      fp,ar0
        addi      2,ar0
        ldiu      *ar1++(1),r0
        rpts      10                    ; Fast MEMCPY(#3)
        sti       r0,*ar0++(1)
||      ldi       *ar1++(1),r0
        sti       r0,*ar0++(1)
	.line	6
;----------------------------------------------------------------------
; 479 | unsigned int nDays,nTotalSecond = nSysTime,nFrontSec,nRearSec;         
;----------------------------------------------------------------------
        ldiu      *-fp(3),r0
        sti       r0,*+fp(16)
	.line	7
;----------------------------------------------------------------------
; 480 | int nBaseYear = 2000;                                                  
;----------------------------------------------------------------------
        ldiu      2000,r0
        sti       r0,*+fp(19)
	.line	9
;----------------------------------------------------------------------
; 482 | bSec = FALSE;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	10
;----------------------------------------------------------------------
; 483 | nRearSec = nFrontSec = 0;                                              
;----------------------------------------------------------------------
        sti       r0,*+fp(17)
        sti       r0,*+fp(18)
	.line	11
;----------------------------------------------------------------------
; 484 | for(nTemp = nBaseYear; nTemp <= 2245 ;nTemp++)                         
;----------------------------------------------------------------------
        ldiu      *+fp(19),r0
        sti       r0,*+fp(14)
        cmpi      2245,r0
        bgt       L144
;*      Branch Occurs to L144 
L136:        
	.line	13
;----------------------------------------------------------------------
; 486 | nDays = 365;                                                           
;----------------------------------------------------------------------
        ldiu      365,r0
        sti       r0,*+fp(15)
	.line	14
;----------------------------------------------------------------------
; 487 | if((!(nTemp % 4) && (nTemp % 100)) || !(nTemp % 400)) nDays += 1;      
;----------------------------------------------------------------------
        ldiu      *+fp(14),r0
        ldiu      r0,r1
        ash       -1,r1
        lsh       @CL25,r1
        addi3     r1,r0,r1
        andn      3,r1
        subri     r0,r1
        bne       L138
;*      Branch Occurs to L138 
        ldiu      100,r1
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L139
;*      Branch Occurs to L139 
L138:        
        ldiu      *+fp(14),r0
        ldiu      400,r1
        call      MOD_I30
                                        ; Call Occurs
        cmpi      0,r0
        bne       L140
;*      Branch Occurs to L140 
L139:        
        ldiu      1,r0
        addi      *+fp(15),r0           ; Unsigned
        sti       r0,*+fp(15)
L140:        
	.line	15
;----------------------------------------------------------------------
; 488 | nRearSec = nFrontSec;                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(17),r0
        sti       r0,*+fp(18)
	.line	16
;----------------------------------------------------------------------
; 489 | nFrontSec += nDays*24*60*60;                                           
;----------------------------------------------------------------------
        ldiu      *+fp(15),r0
        mpyi      24,r0
        mpyi      60,r0
        mpyi      60,r0
        addi      *+fp(17),r0           ; Unsigned
        sti       r0,*+fp(17)
	.line	17
;----------------------------------------------------------------------
; 490 | if(ISRANGE_LOW(nTotalSecond,nRearSec,nFrontSec))                       
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        cmpi      *+fp(18),r0
        blo       L143
;*      Branch Occurs to L143 
        cmpi      *+fp(17),r0
        bhs       L143
;*      Branch Occurs to L143 
	.line	19
;----------------------------------------------------------------------
; 492 | pTime->year = BIN2BCD(nTemp-nBaseYear);                                
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
; 493 | nTotalSecond -= nRearSec;                                              
;----------------------------------------------------------------------
        ldiu      *+fp(18),r0
        subri     *+fp(16),r0           ; Unsigned
        sti       r0,*+fp(16)
	.line	21
;----------------------------------------------------------------------
; 494 | bSec = TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(1)
	.line	22
;----------------------------------------------------------------------
; 495 | break;                                                                 
;----------------------------------------------------------------------
        bu        L144
;*      Branch Occurs to L144 
L143:        
	.line	11
        ldiu      1,r0
        addi      *+fp(14),r0
        sti       r0,*+fp(14)
        cmpi      2245,r0
        ble       L136
;*      Branch Occurs to L136 
L144:        
	.line	26
;----------------------------------------------------------------------
; 499 | if(!bSec) return FALSE;                                                
;----------------------------------------------------------------------
        ldi       *+fp(1),r0
        bne       L146
;*      Branch Occurs to L146 
        bud       L156
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L156 
L146:        
	.line	28
;----------------------------------------------------------------------
; 501 | bSec = FALSE;                                                          
;----------------------------------------------------------------------
        ldiu      0,r0
        sti       r0,*+fp(1)
	.line	29
;----------------------------------------------------------------------
; 502 | nDays = 0;                                                             
;----------------------------------------------------------------------
        sti       r0,*+fp(15)
	.line	30
;----------------------------------------------------------------------
; 503 | nRearSec = nFrontSec = 0;                                              
;----------------------------------------------------------------------
        sti       r0,*+fp(17)
        sti       r0,*+fp(18)
	.line	31
;----------------------------------------------------------------------
; 504 | for(nTemp=0;nTemp<11;nTemp++)                                          
;----------------------------------------------------------------------
        sti       r0,*+fp(14)
        cmpi      11,r0
        bge       L151
;*      Branch Occurs to L151 
L147:        
	.line	33
;----------------------------------------------------------------------
; 506 | nDays += days[nTemp];                                                  
;----------------------------------------------------------------------
        ldiu      fp,ar0
        ldiu      *+fp(14),ir0
        addi      2,ar0
        ldiu      *+ar0(ir0),r0
        addi      *+fp(15),r0           ; Unsigned
        sti       r0,*+fp(15)
	.line	34
;----------------------------------------------------------------------
; 507 | nRearSec = nFrontSec;                                                  
;----------------------------------------------------------------------
        ldiu      *+fp(17),r0
        sti       r0,*+fp(18)
	.line	35
;----------------------------------------------------------------------
; 508 | nFrontSec = nDays*24*60*60;                                            
;----------------------------------------------------------------------
        ldiu      *+fp(15),r0
        mpyi      24,r0
        mpyi      60,r0
        mpyi      60,r0
        sti       r0,*+fp(17)
	.line	36
;----------------------------------------------------------------------
; 509 | if(ISRANGE_LOW(nTotalSecond,nRearSec,nFrontSec))                       
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        cmpi      *+fp(18),r0
        blo       L150
;*      Branch Occurs to L150 
        cmpi      *+fp(17),r0
        bhs       L150
;*      Branch Occurs to L150 
	.line	38
;----------------------------------------------------------------------
; 511 | pTime->month = BIN2BCD(nTemp+1);                                       
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
; 512 | nTotalSecond -= nRearSec;                                              
;----------------------------------------------------------------------
        ldiu      *+fp(18),r0
        subri     *+fp(16),r0           ; Unsigned
        sti       r0,*+fp(16)
	.line	40
;----------------------------------------------------------------------
; 513 | bSec = TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
        sti       r0,*+fp(1)
	.line	41
;----------------------------------------------------------------------
; 514 | break;                                                                 
;----------------------------------------------------------------------
        bu        L151
;*      Branch Occurs to L151 
L150:        
	.line	31
        ldiu      1,r0
        addi      *+fp(14),r0
        sti       r0,*+fp(14)
        cmpi      11,r0
        blt       L147
;*      Branch Occurs to L147 
L151:        
	.line	45
;----------------------------------------------------------------------
; 518 | if(!bSec) return FALSE;                                                
;----------------------------------------------------------------------
        ldi       *+fp(1),r0
        bned      L154
	nop
        ldine     *+fp(16),r0
        ldine     @CL26,r1
;*      Branch Occurs to L154 
        bud       L156
	nop
	nop
        ldiu      0,r0
;*      Branch Occurs to L156 
	.line	47
;----------------------------------------------------------------------
; 520 | nTemp = nTotalSecond/(24*60*60);                                       
;----------------------------------------------------------------------
L154:        
        call      DIV_U30
                                        ; Call Occurs
        sti       r0,*+fp(14)
	.line	48
;----------------------------------------------------------------------
; 521 | pTime->day = BIN2BCD(nTemp+1);                                         
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
; 522 | nTotalSecond %= (24*60*60);                                            
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        ldiu      @CL26,r1
        call      MOD_U30
                                        ; Call Occurs
        sti       r0,*+fp(16)
	.line	51
;----------------------------------------------------------------------
; 524 | nTemp = nTotalSecond/(60*60);                                          
;----------------------------------------------------------------------
        ldiu      3600,r1
        call      DIV_U30
                                        ; Call Occurs
        sti       r0,*+fp(14)
	.line	52
;----------------------------------------------------------------------
; 525 | pTime->hour = BIN2BCD(nTemp);                                          
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
; 526 | nTotalSecond %= (60*60);                                               
;----------------------------------------------------------------------
        ldiu      *+fp(16),r0
        ldiu      3600,r1
        call      MOD_U30
                                        ; Call Occurs
        sti       r0,*+fp(16)
	.line	55
;----------------------------------------------------------------------
; 528 | nTemp = nTotalSecond/60;                                               
;----------------------------------------------------------------------
        ldiu      60,r1
        call      DIV_U30
                                        ; Call Occurs
        sti       r0,*+fp(14)
	.line	56
;----------------------------------------------------------------------
; 529 | pTime->minute = BIN2BCD(nTemp);                                        
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
; 530 | nTotalSecond %= 60;                                                    
;----------------------------------------------------------------------
        ldiu      60,r1
        ldiu      *+fp(16),r0
        call      MOD_U30
                                        ; Call Occurs
        sti       r0,*+fp(16)
	.line	59
;----------------------------------------------------------------------
; 532 | pTime->second = BIN2BCD(nTotalSecond);                                 
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
; 534 | return TRUE;                                                           
;----------------------------------------------------------------------
        ldiu      1,r0
L156:        
	.line	62
        ldiu      *-fp(1),ir0
        ldiu      *fp,fp
        subi      21,sp
        bu        ir0
;*      Branch Occurs to ir0 
	.endfunc	535,000000000h,19


	.sect	 ".text"

	.global	_Delay
	.sym	_Delay,_Delay,36,2,0
	.func	541
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
; 541 | int Delay(int nCnt)                                                    
;----------------------------------------------------------------------
        push      fp
        ldiu      sp,fp
	.line	2
	.line	3
;----------------------------------------------------------------------
; 543 | while(nCnt--) WDI_ACT;                                                 
;----------------------------------------------------------------------
        ldiu      1,r1
        ldiu      *-fp(2),r0
        subri     r0,r1
        cmpi      0,r0
        beqd      L160
        ldiu      0,r2
        ldiu      8192,ar0
        sti       r1,*-fp(2)
;*      Branch Occurs to L160 
L159:        
        sti       r2,*ar0
        ldiu      1,r1
        ldiu      *-fp(2),r0
        subri     r0,r1
        cmpi      0,r0
        sti       r1,*-fp(2)
        bne       L159
;*      Branch Occurs to L159 
L160:        
	.line	4
;----------------------------------------------------------------------
; 544 | return 0;                                                              
;----------------------------------------------------------------------
        ldiu      0,r0
	.line	5
        ldiu      *-fp(1),ar0
        ldiu      *fp,fp
        subi      2,sp
        bu        ar0
;*      Branch Occurs to ar0 
	.endfunc	545,000000000h,0



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
	.func	551
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
; 551 | void c_int02()                                                         
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
; 553 | xr16l784_Isr();                                                        
;----------------------------------------------------------------------
        call      _xr16l784_Isr
                                        ; Call Occurs
	.line	4
;----------------------------------------------------------------------
; 554 | nInt_01_Cnt++;                                                         
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
	.endfunc	556,0003f07ffh,0



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
	.func	562
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
; 562 | void c_int03()                                                         
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
; 564 | LonWorkRead();                                                         
;----------------------------------------------------------------------
        call      _LonWorkRead
                                        ; Call Occurs
	.line	4
;----------------------------------------------------------------------
; 565 | nInt_02_Cnt++;                                                         
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
	.endfunc	566,0003f07ffh,0



	.sect	".cinit"
	.field  	1,32
	.field  	_nRunLedCnt$2+0,32
	.field  	0,32		; _nRunLedCnt$2 @ 0

	.sect	".text"
	.sect	 ".text"

	.global	_c_int10
	.sym	_c_int10,_c_int10,32,2,0
	.func	571
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
; 571 | void c_int10(void)                                                     
; 573 | static int nRunLedCnt=0;                                               
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
; 575 | xr16l784_1msLoop();                                                    
;----------------------------------------------------------------------
        call      _xr16l784_1msLoop
                                        ; Call Occurs
	.line	6
;----------------------------------------------------------------------
; 576 | user_1msLoop();                                                        
;----------------------------------------------------------------------
        call      _user_1msLoop
                                        ; Call Occurs
	.line	7
;----------------------------------------------------------------------
; 577 | LonInfo_1msLoop();                                                     
;----------------------------------------------------------------------
        call      _LonInfo_1msLoop
                                        ; Call Occurs
	.line	8
;----------------------------------------------------------------------
; 578 | Debug_1msLoop();                                                       
;----------------------------------------------------------------------
        call      _Debug_1msLoop
                                        ; Call Occurs
	.line	10
;----------------------------------------------------------------------
; 580 | m_nDebug1msTimer++;                                                    
;----------------------------------------------------------------------
        ldiu      1,r0
        addi      @_m_nDebug1msTimer+0,r0 ; Unsigned
        sti       r0,@_m_nDebug1msTimer+0
	.line	12
;----------------------------------------------------------------------
; 582 | WDI_ACT;                                                               
;----------------------------------------------------------------------
        ldiu      8192,ar0
        ldiu      0,r0
        sti       r0,*ar0
	.line	14
;----------------------------------------------------------------------
; 584 | RUN_LED(nRunLedCnt&0x20 ? 1 : 0);                                      
;----------------------------------------------------------------------
        ldiu      32,r0
        tstb      @_nRunLedCnt$2+0,r0
        beqd      L172
        ldieq     2,r0
        ldieq     @CL27,ar1
        ldieq     @CL27,ar0
;*      Branch Occurs to L172 
        ldiu      1,r0
        ldiu      @CL27,ar1
        ldiu      @CL27,ar0
        and3      r0,*ar1,r0
        sti       r0,*ar0
        bu        L174
;*      Branch Occurs to L174 
	.line	14
L172:        
        or3       r0,*ar1,r0
        sti       r0,*ar0
	.line	15
;----------------------------------------------------------------------
; 585 | ERR_LED(0);                                                            
;----------------------------------------------------------------------
        bu        L174
;*      Branch Occurs to L174 
L174:        
	.line	15
        ldiu      1,r0
        ldiu      @CL27,ar1
        ldiu      @CL27,ar0
        or3       r0,*ar1,r0
        sti       r0,*ar0
	.line	17
;----------------------------------------------------------------------
; 587 | nRunLedCnt++;                                                          
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
	.endfunc	588,0003f07ffh,0


;******************************************************************************
;* STRINGS                                                                    *
;******************************************************************************
	.sect	".const"
SL1:	.byte	"Firmware:LIC-C3",0
SL2:	.byte	"Version:1.035",0
SL3:	.byte	"Date:2012/05/16",0
SL4:	.byte	"Version",0
SL5:	.byte	"Date",0
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

	.sect	".cinit"
	.field  	27,32
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
	.field  	_m_pBoardIdInfo,32
	.field  	SL4,32
	.field  	SL5,32
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

	.global	_vsprintf

	.global	_strlen

	.global	_Debug_1msLoop

	.global	_xr16l784_Send

	.global	_xr16l784_Loop

	.global	_xr16l784_Rts

	.global	_xr16l784_Isr

	.global	_LonInfo_1msLoop

	.global	_LonWorkRead

	.global	_xr16l784_Init

	.global	_xr16l784_1msLoop

	.global	_user_Init

	.global	_user_Loop

	.global	_user_1msLoop
	.global	_Debug3xInit
	.global	MOD_I30
	.global	DIV_I30
	.global	DIV_U30
	.global	MOD_U30
