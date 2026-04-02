
#include "stdio.h"
#include "string.h"
#include "main.h"
#include "def.h"
#include "MpuDebug.h"
#include "Variable.h"
#include "LonInfo.h"
#include "xr16l784.h"
#include "user.h"
#include "ds1647.h"


VARIABLE_H m_Variable;

//******************************************************************************************
//	초기화
//******************************************************************************************
void user_Init()
{
	int i;
	int wCarNo = 0;
	UCHAR LL,LH,HL,HH;
	char szBuf[128];
	UCHAR *pDpram = (UCHAR *)DPRAM_BASE;

	PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //버전 정보 처리를 위해 임의로 만들었다.

	user_Variable_Init();
	
	// 초기화하기
	//timeGet(&m_tmCurTime);
	memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt)); //상태 데이타 저장 버퍼 
	memset(m_Variable.m_btOldCommSt,0x00,sizeof(m_Variable.m_btOldCommSt)); //상태 데이타 저장 버퍼 
	memset(m_Variable.m_btSenseCommStBuf,0x00,sizeof(m_Variable.m_btSenseCommStBuf)); //상태 데이타 저장 버퍼 
	
	memset(m_Variable.m_btExVersionTbl,0x0000,sizeof(m_Variable.m_btExVersionTbl));
	memset(m_Variable.m_btExVersion_DAYTbl,0x0000,sizeof(m_Variable.m_btExVersion_DAYTbl));

	m_Variable.m_LIC_CNCS_Tx_Flag = FALSE;
	m_Variable.m_LIC_CNCS_TX_DelyTime = 0;
	m_Variable.m_nLnWkTxFlag = FALSE;
	m_Variable.m_nFaultCnt = 0;
	m_Variable.m_Recving_Posi = 0;
	m_Variable.m_nCDT_FaultDataStFlag = FALSE;


	//memset(&m_Variable,0x00,sizeof(m_Variable));


	for(i=0;i<VER_BDD_MAX_CNT;i++)
	{

		if(WORD_L(pLicVerDp->VerCnt) == TRUE)
		{
			// 버전 정보가  '0' ~ '9' 숫가인지 확인 한다. --> 아니면 초기화 한다.(쓰레기 값이 들어 있는 걸로 판단)
			if( !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[0])) || !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[1])) ||
				!IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[2])) || !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chVer[3])) ||

				!IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[0])) || !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[1])) ||
				!IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[2])) || !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[3])) ||
				!IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[4])) || !IsNumAsc(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[5])))
			{
				memset(pLicVerDp->cvbBuf[i].chVer,'0',4);
				memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);
			}
			else
			{   //각 장치 버전 정보를 읽어온다.
				LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[0])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[1])));
				LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[2])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chVer[3])));
				m_Variable.m_btExVersionTbl[i] = MAKE_WORD(LH,LL);
				HH = 0x20;
				HL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[0])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[1])));
				LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[2])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[3])));
				LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[4])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[i].chBuildDate[5])));

				m_Variable.m_btExVersion_DAYTbl[i] = MAKE_DWORD(HH,HL,LH,LL);
			}
		}
		else //한번도 버전 정보 입력이 되지않을 경우 0 으로 초기화 한다.
		{
			pLicVerDp->VerCnt = TRUE;
			memset(pLicVerDp->cvbBuf[i].chVer,'0',4);
			memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);
		}
	}

	// LIC-MPU제어기 버젼 & 빌드데이트
	m_Variable.m_btExVersionTbl[5] = MAKE_WORD(
								MAKE_BYTE(ConvHex2Asc(GetFirmwareVersion(1)/1000%10),ConvHex2Asc(GetFirmwareVersion(1)/100%10)),
								MAKE_BYTE(ConvHex2Asc(GetFirmwareVersion(1)/10%10),ConvHex2Asc(GetFirmwareVersion(1)%10))
								);

	m_Variable.m_btExVersion_DAYTbl[5] = MAKE_DWORD(
								0x20,
								MAKE_BYTE(ConvHex2Asc(GetFirmwareVersion(2)/100000%10),ConvHex2Asc(GetFirmwareVersion(2)/10000%10)),
								MAKE_BYTE(ConvHex2Asc(GetFirmwareVersion(2)/1000%10),ConvHex2Asc(GetFirmwareVersion(2)/100%10)),
								MAKE_BYTE(ConvHex2Asc(GetFirmwareVersion(2)/10%10),ConvHex2Asc(GetFirmwareVersion(2)%10))
								);

	i = GetFirmwareVersion(1);
	sprintf(szBuf,"Lonwork Monitor Program, Version:%d.%d%d%d\r\n",i/1000%10,i/100%10,i/10%10,i%10);
	user_DebugPrint(szBuf);

     // 어드레스에 대한 초기 설정 값.
	if(DI_ADDRESS_A) 
	{
		m_Variable.m_chCarKindNum = LIC_DEV_NO;
		m_Variable.m_chCarKind = 'A';
        m_Variable.m_nCarNo = 0x4003;
		m_Variable.m_nCarPos = 1;
	}
	else if(DI_ADDRESS_B)
	{
		m_Variable.m_chCarKindNum = LIC_BAKDEV_NO;
		m_Variable.m_chCarKind = 'B';
        m_Variable.m_nCarNo = 0x4004;
		m_Variable.m_nCarPos = 2;
	}
}
//******************************************************************************************
//	변수 해더 초기화
//******************************************************************************************
void user_Variable_Init()
{
	memset(&m_Variable,0x00,sizeof(VARIABLE_H));

	m_Variable.m_TrainCofVal = 1;
	m_Variable.m_nCarPos = 0x8000;
	m_Variable.m_nCarPos_Re = 0x8000;
	m_Variable.m_btCiFaultVal = 0x8000;
	m_Variable.m_nCarNo = 0x8000;
	m_Variable.m_chCarKind = 'A';
	m_Variable.m_bLnWkFtpEndFlag = FALSE;
	m_Variable.m_nDbgTxPos = 0xFFFFFFFF;
	m_Variable.m_btTestOtherCiFault = 0x8000;
	m_Variable.m_bCiFaultFlag = FALSE;

	strcpy(&m_Variable.LIC_VerList[0][0],"CCP");
	strcpy(&m_Variable.LIC_VerList[1][0],"CRA-LICL");
	strcpy(&m_Variable.LIC_VerList[2][0],"CRA-VTX");
	strcpy(&m_Variable.LIC_VerList[3][0],"CRA-VOIP");
	strcpy(&m_Variable.LIC_VerList[4][0],"CRA-PAC");
	strcpy(&m_Variable.LIC_VerList[5][0],"CRA-LICM");
	strcpy(&m_Variable.LIC_VerList[6][0],"FDI1");
	strcpy(&m_Variable.LIC_VerList[7][0],"SDI1");
	strcpy(&m_Variable.LIC_VerList[8][0],"SDI2");
	strcpy(&m_Variable.LIC_VerList[9][0],"SDI3");
	strcpy(&m_Variable.LIC_VerList[10][0],"SDI4");
	strcpy(&m_Variable.LIC_VerList[11][0],"PII1");
	strcpy(&m_Variable.LIC_VerList[12][0],"PII2");
	strcpy(&m_Variable.LIC_VerList[13][0],"VRX1");
	strcpy(&m_Variable.LIC_VerList[14][0],"VRX2");
	strcpy(&m_Variable.LIC_VerList[15][0],"VRX3");
	strcpy(&m_Variable.LIC_VerList[16][0],"VRX4");
	strcpy(&m_Variable.LIC_VerList[17][0],"VRX5");
	strcpy(&m_Variable.LIC_VerList[18][0],"CRA-MAIN");
	strcpy(&m_Variable.LIC_VerList[19][0],"CRA-LAUN");
	strcpy(&m_Variable.LIC_VerList[20][0],"CRA-UP");
	strcpy(&m_Variable.LIC_VerList[21][0],"CRA-PP");
	strcpy(&m_Variable.LIC_VerList[22][0],"CRA-SP");
	strcpy(&m_Variable.LIC_VerList[23][0],"CRA-FTP");
	strcpy(&m_Variable.LIC_VerList[24][0],"CRA-CDT");
	m_Variable.LIC_VerList[25][0] = NULL;
			
}
//******************************************************************************************
//	Loop
//******************************************************************************************
void user_Loop()
{
	int i;

	LonWorkLoop();

	DebugLoop();
	
	user_WithCncsRs232Loop();
	
	user_WithPacRs485Loop();
	
}

//******************************************************************************************
//	LIC간 데이터 처리(ROTEM 요청으로 시험용)
//******************************************************************************************

void user_Lic2LicLoop()
{
	int nTxPos;
	UCHAR btBuf[128];
	UCHAR btTxBuf[128];
	int nRxLen;
	static int nRxPos = 0;
	static UCHAR nOldUart3RxOneByteGapDelayTime = 0;
	static UCHAR btRx3chBuf[256];
	
	m_Variable.m_bCiFaultFlag = m_Variable.m_btCttSignalA.BIT.Ci_CutOff ? TRUE : FALSE;
		
	if(m_Variable.m_nCarPos >= 1 && m_Variable.m_nCarPos <= 8) m_Variable.m_btCiFaultVal = MASKBIT(m_Variable.m_bCiFaultFlag,m_Variable.m_nCarPos-1);
	
	// 전송하기
	if(m_Variable.m_nTest1msTimer > 100) // 100ms 이후에는 지속적으로 A -> B 로 전송 한다.
	{
		m_Variable.m_nTest1msTimer = 0;
		
		if(m_Variable.m_chCarKind == 'A')
		{
			nTxPos = 0;
			btTxBuf[nTxPos++] = 0x02;
			btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;
			btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;
			btTxBuf[nTxPos++] = 0x03;
			
			xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)btTxBuf,nTxPos,1);
		}
	}
	
	// 수신 받기
	nRxLen = user_PacRx(btBuf,128);
	if(nRxLen)
	{
		if(!m_Variable.m_nUart3RxOneByteGapDelayTime) nRxPos = 0;
		nOldUart3RxOneByteGapDelayTime = m_Variable.m_nUart3RxOneByteGapDelayTime = 10;
		
		if(nRxPos + nRxLen < 250)
		{
			memcpy(&btRx3chBuf[nRxPos],btBuf,nRxLen);
			nRxPos += nRxLen;
		}
	}
	
	if(nOldUart3RxOneByteGapDelayTime && !m_Variable.m_nUart3RxOneByteGapDelayTime)
	{
		if(nRxPos >= 4)
		{
			if(btRx3chBuf[0] == 0x02 && btRx3chBuf[3] == 0x03 && btRx3chBuf[1] == btRx3chBuf[2])
			{
				m_Variable.m_btTestOtherCiFault = btRx3chBuf[1];

				nTxPos = 0;
				btTxBuf[nTxPos++] = 0x02;
				btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;
				btTxBuf[nTxPos++] = m_Variable.m_btCiFaultVal;
				btTxBuf[nTxPos++] = 0x03;
				
				xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)btTxBuf,nTxPos,10);
			}
		}
		
		nOldUart3RxOneByteGapDelayTime = m_Variable.m_nUart3RxOneByteGapDelayTime;
	}
}


//******************************************************************************************
//	Single car 인지, Married Car인지 리턴
//
//	Return
//	- 1 : Single
//	- 2 : Married
//	- 0 : 해당사항 없음 사용하지말것
//******************************************************************************************
int user_IsSingleOrMarried()
{
	return 1;
}

//******************************************************************************************
//	UART 통신 송수신 함수
//******************************************************************************************
int user_DebugRx(UCHAR *pBuf,int nRxBuffLen)
{
	return xr16l784_GetRxBuffer1Ch(pBuf,nRxBuffLen);
}

void user_DebugPrint(char *pTxBuf)
{
	xr16l784_Send(XR16L784_1CHL,(UCHAR *)pTxBuf,strlen(pTxBuf));
}


int user_CncsRx(UCHAR *pBuf,int nRxBuffLen)
{
	return xr16l784_GetRxBuffer2Ch(pBuf,nRxBuffLen);
}

void user_CncsTx(UCHAR *pTxBuf,int nTxLen)
{
	xr16l784_RtsDelayStartSend(XR16L784_2CHL,(UCHAR *)pTxBuf,nTxLen,10);
	//xr16l784_Send(XR16L784_2CHL,(UCHAR *)pTxBuf,nTxLen);
}



int user_PacRx(UCHAR *pBuf,int nRxBuffLen)
{
	return xr16l784_GetRxBuffer3Ch(pBuf,nRxBuffLen);
}

void user_PacTx(UCHAR *pTxBuf,int nTxLen)
{
	xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)pTxBuf,nTxLen,10);
}



//************************************************************************
// 비트를 수왑한다.
//************************************************************************
UCHAR BitSwap(UCHAR btDat)
{
	UCHAR btBuf = 0x00;
	
	btBuf |= MASKBIT(btDat&0x01?1:0,7);
	btBuf |= MASKBIT(btDat&0x02?1:0,6);
	btBuf |= MASKBIT(btDat&0x04?1:0,5);
	btBuf |= MASKBIT(btDat&0x08?1:0,4);
	btBuf |= MASKBIT(btDat&0x10?1:0,3);
	btBuf |= MASKBIT(btDat&0x20?1:0,2);
	btBuf |= MASKBIT(btDat&0x40?1:0,1);
	btBuf |= MASKBIT(btDat&0x80?1:0,0);
	
	return btBuf;
}

//******************************************************************************************
//	LIC<->CNCS(RS232)
//******************************************************************************************
void user_WithCncsRs232Loop()
{
	int i;
	int nRxLen;
	UCHAR btBuf[256]; //수신 레지스트에서 읽어 오는 변수
	UCHAR sTimeBuf[10];//시간 전송 버퍼.
	int sPotoLen = 0; //블량 패킷 Index. 
	UCHAR sBcc = 0;
	static int nRxPos = 0; //수신 카운터.
	static UCHAR nOldUart2RxOneByteGapDelayTime = 0; //10ms 이상 수신이 않되면 수신 처리 한다.
	static UCHAR btRx2chBuf[512]; //수신 버퍼
	static UCHAR btTx2chBuf[512]; //전송 버퍼.
	static int nTimeSendCnt = 0;
	UCHAR LL,LH,HL,HH;

	int nBlkSize = 0;
	int nTempBlkEnd = 0;
	int sTxDataSize = 0; //수신아 데이타 size를 비료 하여 128이명 중간 작으면 마지막 프레임 이다.

	UCHAR btTxBuf[128];
	char szBuf[512];
	char szBuf2[64];


	UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;

	PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //버전 정보 처리를 위해 임의로 만들었다.
	PLIC_CNCS_HD pLic_Cncs;
	PCNCS_LIC_SD pCncsLicSd;

	PCNCS_LIC_T_F pCnsc_Lic_T_F;
	PCNCS_LIC_T_F_C pCncs_Lic_T_F_C = (CNCS_LIC_T_F_C *) btRx2chBuf;				// 고장 패킷 전송 완료 확인 프로토콜 추가(Y.J 2011-05-10)
	
	// Fault Block Information;
	PFAULT_INFO pInfo = NULL;

	// 수신
	nRxLen = user_CncsRx(btBuf,128);
	if(nRxLen)
	{
		if(!m_Variable.m_nUart2RxOneByteGapDelayTime) nRxPos = 0;
		m_Variable.m_nUart2RxOneByteGapDelayTime = 10;
		
		if(nRxPos + nRxLen < 511)
		{
			memcpy(&btRx2chBuf[nRxPos],btBuf,nRxLen);
			nRxPos += nRxLen;
		}
	}
	
	if(nOldUart2RxOneByteGapDelayTime && !m_Variable.m_nUart2RxOneByteGapDelayTime)
	{
		pCncsLicSd = (CNCS_LIC_SD *)btRx2chBuf;

		pCnsc_Lic_T_F = (CNCS_LIC_T_F *) btRx2chBuf;

		if(pCncsLicSd->phHdBuf.btSoh == SOH &&
		   pCncsLicSd->btEot == EOT &&
		   sizeof(CNCS_LIC_SD) == nRxPos &&
		   (TWOBYTE_ASC2HEX(pCncsLicSd->phHdBuf.chDestDev) == 0x11) && 
		   (TWOBYTE_ASC2HEX(pCncsLicSd->sCommand) == 0x09) &&  //CNCS가 시간 응답
		   !((Make1ByteBcc(&pCncsLicSd->phHdBuf.chSrcDev[0],nRxPos-4)^(TWOBYTE_ASC2HEX(pCncsLicSd->chChkSum)))))
		{

			
			m_Variable.m_tmCurTime.second = TWOBYTE_ASC2HEX(pCncsLicSd->sSecond);
			m_Variable.m_tmCurTime.minute = TWOBYTE_ASC2HEX(pCncsLicSd->sMinute);
			m_Variable.m_tmCurTime.hour   = TWOBYTE_ASC2HEX(pCncsLicSd->sHour);
			m_Variable.m_tmCurTime.day    = TWOBYTE_ASC2HEX(pCncsLicSd->sDay);
			m_Variable.m_tmCurTime.month  = TWOBYTE_ASC2HEX(pCncsLicSd->sMonth);
			m_Variable.m_tmCurTime.year   = TWOBYTE_ASC2HEX(pCncsLicSd->sYear); 

			//memset(&m_Variable.m_tmUtcTime, 0x00, sizeof(DATE_TIME_TYPE));

			if(m_Variable.m_LIC_CNCS_TimSetFlag = GetLocalTimeToUTC(&m_Variable.m_tmCurTime,0, &m_Variable.m_tmUtcTime))
			{
				m_Variable.m_tmUtcTime.year	    = ConvDec2Hex(m_Variable.m_tmUtcTime.year	);
				m_Variable.m_tmUtcTime.month    = ConvDec2Hex(m_Variable.m_tmUtcTime.month );
				m_Variable.m_tmUtcTime.day	    = ConvDec2Hex(m_Variable.m_tmUtcTime.day	);
				m_Variable.m_tmUtcTime.hour	    = ConvDec2Hex(m_Variable.m_tmUtcTime.hour	);
				m_Variable.m_tmUtcTime.minute	= ConvDec2Hex(m_Variable.m_tmUtcTime.minute);
				m_Variable.m_tmUtcTime.second	= ConvDec2Hex(m_Variable.m_tmUtcTime.second);

				m_Variable.m_nCncsRxCheck1msTimer = 2000;


			}
			

			for(i=0;i<VER_BDD_MAX_CNT;i++)
			{
				if(!MAKE_DWORD(0x00,m_Variable.m_tmUtcTime.year,m_Variable.m_tmUtcTime.month,m_Variable.m_tmUtcTime.day))
				{
					pLicVerDp->VerCnt = FALSE;
					memset(pLicVerDp->cvbBuf[i].chVer,'0',4);
					memset(pLicVerDp->cvbBuf[i].chBuildDate,'0',6);
					break;
				}
				else
				{
					pLicVerDp->VerCnt = TRUE;

					// 버전 입력
					pLicVerDp->cvbBuf[i].chVer[0] = '1';//pCncsLicSd->cvbBuf[i].chVer[0]; 
					pLicVerDp->cvbBuf[i].chVer[1] = '0';//pCncsLicSd->cvbBuf[i].chVer[1]; 
					pLicVerDp->cvbBuf[i].chVer[2] = '0';//pCncsLicSd->cvbBuf[i].chVer[2]; 
					pLicVerDp->cvbBuf[i].chVer[3] = '0';//pCncsLicSd->cvbBuf[i].chVer[3];


					// 만들어진 날짜 입력
					pLicVerDp->cvbBuf[i].chBuildDate[0] = '1';//pCncsLicSd->cvbBuf[i].chBuildDate[0];
					pLicVerDp->cvbBuf[i].chBuildDate[1] = '2';//pCncsLicSd->cvbBuf[i].chBuildDate[1];
					pLicVerDp->cvbBuf[i].chBuildDate[2] = '0';//pCncsLicSd->cvbBuf[i].chBuildDate[2];
					pLicVerDp->cvbBuf[i].chBuildDate[3] = '6';//pCncsLicSd->cvbBuf[i].chBuildDate[3];
					pLicVerDp->cvbBuf[i].chBuildDate[4] = '2';//pCncsLicSd->cvbBuf[i].chBuildDate[4];
					pLicVerDp->cvbBuf[i].chBuildDate[5] = '6';//pCncsLicSd->cvbBuf[i].chBuildDate[5];


				}
			}

			if(TWOBYTE_ASC2HEX(pCncsLicSd->sWaySide) == 0x01 && !m_Variable.m_LIC_CNCS_Tx_Flag) // wayside on 알림
			{
				m_Variable.m_nCDT_FaultDataStFlag = 1;

				//2011_03_03 수정 
				m_Variable.m_nFaultCnt = 0;						// 고장 갯수를 0으로 초기화.(Y.J 추가);
				memset((UCHAR *)NVSRAM_BASE,0x00,1024); // 고장 블럭을 "0" 으로 초시화 한다. 초기 위치 0부터 1024까지만 초기화 한다.
				ClearFltBlkInfo();						// 고장 정보를 Clear하는 부분.
				
				//memset(aaa_FaultBlkList, 0xFF, 1024);

				m_Variable.m_nNvsramPos = 0;	//전체 기록 구조 위치를 처음으로
				m_Variable.m_Recving_Posi = 0;	//현재 까지 전송한 위치를 처음으로
				m_Variable.m_nLnWkTxFlag = 0;	//고장 코드 구분을 0으로 초기화

				m_Variable.m_nLnWkTxFlag = TWOBYTE_ASC2HEX(pCncsLicSd->sDaType);

				// 고장 시간 요청 WORD -> DWORD로 변경.(2011.05.08)
				m_Variable.m_nDateTime2SecondCnt = MAKE_DWORD( MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[0]),ConvAsc2Hex(pCncsLicSd->sFaultTime[1])),
													MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[2]),ConvAsc2Hex(pCncsLicSd->sFaultTime[3])),
													MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[4]),ConvAsc2Hex(pCncsLicSd->sFaultTime[5])),
													MAKE_BYTE(ConvAsc2Hex(pCncsLicSd->sFaultTime[6]),ConvAsc2Hex(pCncsLicSd->sFaultTime[7])));


			}
		}
		else if(pCncs_Lic_T_F_C->phHdBuf.btSoh == SOH &&																			// 고장 시간 요청 WORD -> DWORD로 변경.(2011.05.11)
			pCncs_Lic_T_F_C->btEot == EOT &&
			sizeof(CNCS_LIC_T_F_C) == nRxPos &&
		   (TWOBYTE_ASC2HEX(pCncs_Lic_T_F_C->phHdBuf.chDestDev) == 0x11) &&
		   (TWOBYTE_ASC2HEX(pCncsLicSd->sCommand) == 0x07) &&  //고장 전송 확인 응답(CNCS-> LIC)
		   !((Make1ByteBcc(&pCncs_Lic_T_F_C->phHdBuf.chSrcDev[0],nRxPos-4)^(TWOBYTE_ASC2HEX(pCncs_Lic_T_F_C->chChkSum)))))
		{
			// Y.J 2011-05-10 요청한 고장 Index를 사용하여, 전송하도록 수정.
			sPotoLen = MAKE_WORD(MAKE_BYTE(ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[0]),ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[1])),
			                     MAKE_BYTE(ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[2]),ConvAsc2Hex(pCnsc_Lic_T_F->sTEXT[3])));
			if(sPotoLen)
			{
				// 재전송할 고장 블록 정보를 얻음.
				pInfo = GetFltBlkInfo(m_Variable.m_chCarKind);
				
				if(pInfo != NULL)
				{
					// 전송할 블록 위치로 이동.
					m_Variable.m_Recving_Posi = pInfo->nStPosi + ((sPotoLen-1) * 128);

					// 전송할 블록 크기를 구하는 부분.
					if(sPotoLen < pInfo->nTCnt) //  (sPotoLen*128) <= nTempBlkEnd)
					{
						nBlkSize = 128;
					}
					else if(sPotoLen == pInfo->nTCnt)
					{
						nBlkSize = (pInfo->nEdPosi - pInfo->nStPosi) % 128; // - ((sPotoLen - 1) * 128);
					}
					else
					{
						nBlkSize = 0;
					}

					if(nBlkSize < 0) nBlkSize = 0; 

					// 블록의 마지막 위치를 지정.
					nTempBlkEnd = pInfo->nEdPosi;
				}

				sTxDataSize = nBlkSize + 2;

				// 고장 데이터를 전송하는 부분.
				user_FaultDataTx(btTx2chBuf,sTxDataSize,TRUE,sPotoLen);
				user_CncsTx(btTx2chBuf,(sTxDataSize*2)+18);

				// 전송 후, 블록 위치를 마지막 위치로 복원.
				m_Variable.m_Recving_Posi = nTempBlkEnd;
			}
			else 
			//바로 종료 코드가 수신 될수 있다.
			{ 
				user_FtpEnd_CarNumFun();
			}
		}
	}
	else // 데이타 전송
	{
		if(m_Variable.m_nTxDbg1msTimer > 150) //150ms 마다 한번씩 실행 한다.
		{
			//고장 정보 전송.
			if(m_Variable.m_LIC_CNCS_Tx_Flag)
			{ 
				m_Variable.m_nTxDbg1msTimer = 0;

				m_Variable.m_LIC_CNCS_TX_DelyTime++;

				// 150*50  = 7500  = 7.5초 동안 고장 블럭 사이가 응답이 없으면, 종료 한다.
				if(m_Variable.m_LIC_CNCS_TX_DelyTime > 50){m_Variable.m_bLnWkFtpEndFlag = TRUE;}

				if((m_Variable.m_nNvsramPos !=  (m_Variable.m_Recving_Posi)) && (m_Variable.m_nNvsramPos >= (m_Variable.m_Recving_Posi+128)))
				{
					m_Variable.m_nFaultCnt++;
					if(m_Variable.m_nFaultCnt == 1) 
						SetFltBlkStPos(m_Variable.m_chCarKind, m_Variable.m_Recving_Posi);									// 첫번째 블록일 경우, 고장 정보의 시작 위치를 기록.

					sTxDataSize = 128 + 2;

					user_FaultDataTx(btTx2chBuf,sTxDataSize,FALSE,0);

					m_Variable.m_Recving_Posi += 128;

					user_CncsTx(btTx2chBuf,(sTxDataSize*2)+18);
				}
				else 
				//바로 종료 코드가 수신 될수 있다.
				if(m_Variable.m_bLnWkFtpEndFlag)
				{ 
					m_Variable.m_nFaultCnt++;
					//aaa_CarAFautlCnt = m_nFaultCnt;

					if(m_Variable.m_nFaultCnt == 1) 
						SetFltBlkStPos(m_Variable.m_chCarKind, m_Variable.m_Recving_Posi);									// 첫번째 블록일 경우, 고장 정보의 시작 위치를 기록.

					// 고장 정보를 저장하는 부분.					
					SetFltBlkEdInfo(m_Variable.m_chCarKind, m_Variable.m_nNvsramPos, m_Variable.m_nFaultCnt);

					sTxDataSize = (m_Variable.m_nNvsramPos - m_Variable.m_Recving_Posi) + 2;
					user_FaultDataTx(btTx2chBuf,sTxDataSize,TRUE,0);
					m_Variable.m_Recving_Posi += (sTxDataSize-2);

					// user_FtpEnd_CarNumFun();

					user_CncsTx(btTx2chBuf,(sTxDataSize*2)+18);

					m_Variable.m_LIC_CNCS_Tx_Flag = FALSE;
				} 				
			}
			else
			//시간 정보 요청. LIC -> CNCS 로 시간 정보를 요청 한다.(LIC는 열차 번호를 포함하여 전송 한다.)
			if(m_Variable.m_nTxDbg1msTimer > 1000)
			{ 
				m_Variable.m_nTxDbg1msTimer = 0;

				nTimeSendCnt++;
				nTimeSendCnt = nTimeSendCnt%255;

				pCnsc_Lic_T_F = (CNCS_LIC_T_F *) btTx2chBuf;

				sTxDataSize = 4;

				pCnsc_Lic_T_F->phHdBuf.btSoh =  0x01;
				pCnsc_Lic_T_F->phHdBuf.chSrcDev[0] =  ConvHex2Asc(BYTE_H(0x11));
				pCnsc_Lic_T_F->phHdBuf.chSrcDev[1] =  ConvHex2Asc(BYTE_L(0x11));
				pCnsc_Lic_T_F->phHdBuf.chDestDev[0] =  ConvHex2Asc(BYTE_H(0x15));
				pCnsc_Lic_T_F->phHdBuf.chDestDev[1] =  ConvHex2Asc(BYTE_L(0x15));

				pCnsc_Lic_T_F->phHdBuf.chMsgCnt[0] = ConvHex2Asc(BYTE_H(WORD_H(nTimeSendCnt)));
				pCnsc_Lic_T_F->phHdBuf.chMsgCnt[1] = ConvHex2Asc(BYTE_L(WORD_H(nTimeSendCnt)));
				pCnsc_Lic_T_F->phHdBuf.chMsgCnt[2] = ConvHex2Asc(BYTE_H(WORD_L(nTimeSendCnt)));
				pCnsc_Lic_T_F->phHdBuf.chMsgCnt[3] = ConvHex2Asc(BYTE_L(WORD_L(nTimeSendCnt)));

				pCnsc_Lic_T_F->phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(0x10));
				pCnsc_Lic_T_F->phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(0x10));

				pCnsc_Lic_T_F->phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(WORD_H(sTxDataSize))); // 길이
				pCnsc_Lic_T_F->phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(WORD_H(sTxDataSize))); // 길이
				pCnsc_Lic_T_F->phHdBuf.chDataLen[2] = ConvHex2Asc(BYTE_H(WORD_L(sTxDataSize))); // 길이
				pCnsc_Lic_T_F->phHdBuf.chDataLen[3] = ConvHex2Asc(BYTE_L(WORD_L(sTxDataSize))); // 길이

				pCnsc_Lic_T_F->sCommand[0] = ConvHex2Asc(BYTE_H(0x08));
				pCnsc_Lic_T_F->sCommand[1] = ConvHex2Asc(BYTE_L(0x08));

				pCnsc_Lic_T_F->sTEXT[0] = ConvHex2Asc(BYTE_H(WORD_H(m_Variable.m_nCarNo)));  //열차 번호 전송
				pCnsc_Lic_T_F->sTEXT[1] = ConvHex2Asc(BYTE_L(WORD_H(m_Variable.m_nCarNo)));  //열차 번호 전송
				pCnsc_Lic_T_F->sTEXT[2] = ConvHex2Asc(BYTE_H(WORD_L(m_Variable.m_nCarNo)));  //열차 번호 전송
				pCnsc_Lic_T_F->sTEXT[3] = ConvHex2Asc(BYTE_L(WORD_L(m_Variable.m_nCarNo)));  //열차 번호 전송

				pCnsc_Lic_T_F->chContactSignalBuf[0] = ConvHex2Asc(BYTE_H(m_Variable.m_btCttSignalA.BYTE));
				pCnsc_Lic_T_F->chContactSignalBuf[1] = ConvHex2Asc(BYTE_L(m_Variable.m_btCttSignalA.BYTE));

				sBcc = Make1ByteBcc(&pCnsc_Lic_T_F->phHdBuf.chSrcDev[0],(sTxDataSize*2)+14);

				pCnsc_Lic_T_F->chChkSum[0] = ConvHex2Asc(BYTE_H(sBcc));
				pCnsc_Lic_T_F->chChkSum[1] = ConvHex2Asc(BYTE_L(sBcc));

				pCnsc_Lic_T_F->btEot = 0x04; 

				user_CncsTx(&pCnsc_Lic_T_F->phHdBuf.btSoh,(sTxDataSize*2)+18);
			}
		}
	}

	nOldUart2RxOneByteGapDelayTime = m_Variable.m_nUart2RxOneByteGapDelayTime;
}

// CDT별 고장 정보를 삭제하는 부분.
void ClearFltBlkInfo()
{
	memset(&m_Variable.m_tFaultInfo, 0x00, sizeof(m_Variable.m_tFaultInfo));			// 고장 정보 삭제.
}

// CDT별 고장 정보의 시작 위치를 지정.
void SetFltBlkStPos(char chCarKind, int nStPosi)
{
	PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);

	if(pInfo != NULL) 
		pInfo->nStPosi = nStPosi;								// 고장 시작 위치를 저장.
}

// CDT별 고장 정보를 관리하는 부분.
void SetFltBlkEdInfo(char chCarKind, int nEndPosi, int nFltTCnt)
{
	PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);

	if(pInfo != NULL) 
	{
		pInfo->nTCnt = nFltTCnt;									// 고장 전체 갯수를 기록.
		pInfo->nEdPosi = nEndPosi;									// 고장 마지막 위치를 저장.
	}
}

// CDT 고장 정보를 돌려주는 부분.
PFAULT_INFO GetFltBlkInfo(char chCarKind)
{
	int nIdx = chCarKind - 'A';

	if(nIdx < eCDT_MAXIMUM)
		return &m_Variable.m_tFaultInfo[nIdx];

	return NULL;
}

// CDT 고장 정보의  시작위치를 돌려주는 부분.
int GetFltBlkStPos(char chCarKind)
{
	int nStPos = -1;
	PFAULT_INFO pInfo = GetFltBlkInfo(chCarKind);

	if(pInfo != NULL) 
		nStPos = pInfo->nStPosi;

	return nStPos;
}

void user_FaultDataTx(UCHAR *pTxBuf,UCHAR nLen,UCHAR nEndFlag,int nFltIdx)
{
	UCHAR sTempData = 0;
	PLIC_CNCS_HD pLic_Cncs;
	UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;

	pLic_Cncs =(LIC_CNCS_HD *) pTxBuf;

	pLic_Cncs->phHdBuf.btSoh = 0x01;
	pLic_Cncs->phHdBuf.chSrcDev[0] =  ConvHex2Asc(BYTE_H(0x11));
	pLic_Cncs->phHdBuf.chSrcDev[1] =  ConvHex2Asc(BYTE_L(0x11));
	pLic_Cncs->phHdBuf.chDestDev[0] =  ConvHex2Asc(BYTE_H(0x15));
	pLic_Cncs->phHdBuf.chDestDev[1] =  ConvHex2Asc(BYTE_L(0x15));

	// 고장 인덱스를 신규로 생성(Y.J 수정)
	if(!nFltIdx) nFltIdx = m_Variable.m_nFaultCnt;

	pLic_Cncs->phHdBuf.chMsgCnt[0] = ConvHex2Asc(BYTE_H(WORD_H(nFltIdx)));
	pLic_Cncs->phHdBuf.chMsgCnt[1] = ConvHex2Asc(BYTE_L(WORD_H(nFltIdx)));
	pLic_Cncs->phHdBuf.chMsgCnt[2] = ConvHex2Asc(BYTE_H(WORD_L(nFltIdx)));
	pLic_Cncs->phHdBuf.chMsgCnt[3] = ConvHex2Asc(BYTE_L(WORD_L(nFltIdx)));

	pLic_Cncs->phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(0x10));
	pLic_Cncs->phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(0x10));

	pLic_Cncs->phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(WORD_H(nLen)));
	pLic_Cncs->phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(WORD_H(nLen)));
	pLic_Cncs->phHdBuf.chDataLen[2] = ConvHex2Asc(BYTE_H(WORD_L(nLen)));
	pLic_Cncs->phHdBuf.chDataLen[3] = ConvHex2Asc(BYTE_L(WORD_L(nLen)));

	if(nEndFlag)
	{
		pLic_Cncs->sCommand[0] = ConvHex2Asc(BYTE_H(0x06));//고장 정보 수신 끝.
		pLic_Cncs->sCommand[1] = ConvHex2Asc(BYTE_L(0x06));//고장 정보 수신 끝.
	}
	else
	{
		pLic_Cncs->sCommand[0] = ConvHex2Asc(BYTE_H(0x04));//고장 정보 수신 중.
		pLic_Cncs->sCommand[1] = ConvHex2Asc(BYTE_L(0x04));//고장 정보 수신 중.
	}

	pLic_Cncs->sCarKind[0] = ConvHex2Asc(BYTE_H(m_Variable.m_chCarKind));
	pLic_Cncs->sCarKind[1] = ConvHex2Asc(BYTE_L(m_Variable.m_chCarKind));

	FunConvHexAsc(&pNvsram[m_Variable.m_Recving_Posi],(char *)pLic_Cncs->sTextDataAsc,(nLen-2));

	sTempData = Make1ByteBcc(&pLic_Cncs->phHdBuf.chSrcDev[0],(nLen*2)+14);

	pLic_Cncs->sTextDataAsc[((nLen-2)*2)] = ConvHex2Asc(BYTE_H(sTempData));
	pLic_Cncs->sTextDataAsc[((nLen-2)*2)+1] = ConvHex2Asc(BYTE_L(sTempData));

	pLic_Cncs->sTextDataAsc[((nLen-2)*2)+2] = 0x04;

	m_Variable.m_LIC_CNCS_TX_DelyTime = 0;
}

//*****************************************************************************************
// 뎀버에서는 한 종류의 카만 있어 바로 종료한다.
//*****************************************************************************************
void user_FtpEnd_CarNumFun()
{
	m_Variable.m_bLnWkFtpEndFlag = FALSE;

	m_Variable.m_LIC_CNCS_Tx_Flag = FALSE; //고장 정보 마지막 블럭 이므로 전송 끝.
	m_Variable.m_nNvsramPos = 0;
	m_Variable.m_Recving_Posi = 0;
	m_Variable.m_nLnWkWaySideOnRxOk = 0;
	m_Variable.m_nFaultCnt = 0;
	//m_chCarKind = 'A';
	m_Variable.m_nLnWkTxFlag = 0;

	/*
	// Single car일 경우
	if(BYTE_L(m_wCarNo>>8) == 0x07)
	{
		m_LIC_CNCS_Tx_Flag = FALSE; //고장 정보 마지막 블럭 이므로 전송 끝.
		m_nNvsramPos = 0;
		nRecving_Posi = 0;
		m_nLnWkWaySideOnRxOk = 0;
		m_nFaultCnt = 0;
		m_chCarKind = 'A';
		m_nLnWkTxFlag = 0;
	}
	else
	// Married car일 경우 
	if(BYTE_L(m_wCarNo>>8) == 0x08)
	{
		if(WORD_L(m_chCarKind) == 'A')
		{
			m_nLnWkWaySideOnRxOk = 0;
			m_nFaultCnt = 0;
			m_chCarKind = 'B';

			m_LIC_CNCS_Tx_Flag = FALSE; //고장 정보 마지막 블럭 이므로 전송 끝.

			m_nCDT_FaultDataStFlag = 10;
		}
		else
		{
			m_nNvsramPos = 0;
			nRecving_Posi = 0;
			m_nLnWkWaySideOnRxOk = 0;
			m_nFaultCnt = 0;
			m_chCarKind = 'A';
			m_nLnWkTxFlag = 0;

			m_LIC_CNCS_Tx_Flag = FALSE; //고장 정보 마지막 블럭 이므로 전송 끝.
		}
	}
	*/
}

//******************************************************************************************
//	LIC <-> PAC(RS485)
//******************************************************************************************
int d_CI_Fault = 0;
int d_CI_Index = 0;
int d_MDSFaulgTestBuf[10];
void user_WithPacRs485Loop()
{
	int i;
	int nRxLen;
	int nCciCnt = 0;
	UCHAR btTmp;
	UCHAR btTmpBuf[100];
	UCHAR btBuf[300];

	UCHAR nMasterCarNum = 0; 

	static int nRxPos = 0;
	static UCHAR nOldUart3RxOneByteGapDelayTime = 0;
	static UCHAR btRx3chBuf[300];

	static UCHAR sCarNumBCD_H = 0;
	static UCHAR sCarNumBCD_L = 0;


	UCHAR sAdd1 = 0;
	UCHAR sAdd2 = 0;
	UCHAR sAdd3 = 0;


	PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;

	PPACSDR pPaSdrBuf;
	LICSD lsLicSdBuf;
	PPAC_PAC pPa_PaBuf;

	PCCP_PAC pCcp_Pac;

	PCRA_STATION pPac_Pac_Sta;

	PCOMMSTATUS_PA pCommStatus;
	PCOMMSTATUS_LIC pCommStatus_Lic; 


	// 수신
	nRxLen = user_PacRx(btBuf,128);
	if(nRxLen)
	{
		if(!m_Variable.m_nUart3RxOneByteGapDelayTime) nRxPos = 0;
		m_Variable.m_nUart3RxOneByteGapDelayTime = 3;
		
		if(nRxPos + nRxLen < 300)
		{
			memcpy(&btRx3chBuf[nRxPos],btBuf,nRxLen);
			nRxPos += nRxLen;
			
		}
	}
	
	if(nOldUart3RxOneByteGapDelayTime && !m_Variable.m_nUart3RxOneByteGapDelayTime)
	{
		
		if(nRxPos >= 10)
		{
			pPaSdrBuf = (PACSDR *)btRx3chBuf;

			pPa_PaBuf = (PAC_PAC *)btRx3chBuf;

			
			pCcp_Pac = (CCP_PAC *)btRx3chBuf;

			//PAC -> LIC 부분 프로토콜을 분리 한다.
			if(
				WORD_L(pPaSdrBuf->phHdBuf.btSoh) == SOH &&
				WORD_L(pPaSdrBuf->btEot) == EOT &&
				sizeof(PACSDR) == nRxPos &&
				(TWOBYTE_ASC2HEX(pPaSdrBuf->phHdBuf.chDestDev) == m_Variable.m_chCarKindNum)&&

				ConvAsc2Hex(pPaSdrBuf->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&pPaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&
				ConvAsc2Hex(pPaSdrBuf->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&pPaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&
				ConvAsc2Hex(pPaSdrBuf->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&pPaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&
				ConvAsc2Hex(pPaSdrBuf->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&pPaSdrBuf->phHdBuf.chSrcDev[0],nRxPos-6))))
			{
				switch(TWOBYTE_ASC2HEX(pPaSdrBuf->phHdBuf.chCmdCode))
				{
				case REQ_CMD: //PAC -> LIC

					lsLicSdBuf.phHdBuf.btSoh = SOH;
					lsLicSdBuf.phHdBuf.chSrcDev[0] = ConvHex2Asc(BYTE_H(m_Variable.m_chCarKindNum));
					lsLicSdBuf.phHdBuf.chSrcDev[1] = ConvHex2Asc(BYTE_L(m_Variable.m_chCarKindNum));
					lsLicSdBuf.phHdBuf.chDestDev[0] = pPaSdrBuf->phHdBuf.chSrcDev[0];
					lsLicSdBuf.phHdBuf.chDestDev[1] = pPaSdrBuf->phHdBuf.chSrcDev[1];
					lsLicSdBuf.phHdBuf.chMsgCnt[0] = pPaSdrBuf->phHdBuf.chMsgCnt[0];
					lsLicSdBuf.phHdBuf.chMsgCnt[1] = pPaSdrBuf->phHdBuf.chMsgCnt[1];
					lsLicSdBuf.phHdBuf.chCmdCode[0] = ConvHex2Asc(BYTE_H(RPY_CMD));
					lsLicSdBuf.phHdBuf.chCmdCode[1] = ConvHex2Asc(BYTE_L(RPY_CMD));
					lsLicSdBuf.phHdBuf.chDataLen[0] = ConvHex2Asc(BYTE_H(((sizeof(LICSD)-16)/2)));
					lsLicSdBuf.phHdBuf.chDataLen[1] = ConvHex2Asc(BYTE_L(((sizeof(LICSD)-16)/2)));

					lsLicSdBuf.DATA1.BIT.All_Doors_Closed = m_Variable.m_btCttSignalA.BIT.All_Doors_Closed;
					lsLicSdBuf.DATA1.BIT.EP_Mode = m_Variable.m_btCttSignalA.BIT.EP_Mode;
					lsLicSdBuf.DATA1.BIT.Traction = m_Variable.m_btCttSignalA.BIT.Traction;
					lsLicSdBuf.DATA1.BIT.Atcive_Cab = m_Variable.m_btCttSignalA.BIT.Atcive_Cab;
				
					lsLicSdBuf.DATA2.BIT.CI_Fault = m_Variable.m_bCiFaultFlag;
					lsLicSdBuf.DATA2.BIT.DST = 0;

					lsLicSdBuf.DATA1.BYTE = ConvHex2Asc(BYTE_L(lsLicSdBuf.DATA1.BYTE));

					lsLicSdBuf.DATA2.BYTE = ConvHex2Asc(BYTE_L(lsLicSdBuf.DATA2.BYTE));

					lsLicSdBuf.CI_Index_Num[0] = ConvHex2Asc(BYTE_H(m_Variable.m_nCarPos));
					lsLicSdBuf.CI_Index_Num[1] = ConvHex2Asc(BYTE_L(m_Variable.m_nCarPos));

					lsLicSdBuf.chCarn[0][0] = ConvHex2Asc(BYTE_H(WORD_H(m_Variable.m_nCarNo))); // Car Number(-.백자리)
					lsLicSdBuf.chCarn[0][1] = ConvHex2Asc(BYTE_L(WORD_H(m_Variable.m_nCarNo)));
					lsLicSdBuf.chCarn[1][0] = ConvHex2Asc(BYTE_H(m_Variable.m_nCarNo)); // Car Number(십자리,일자리)
					lsLicSdBuf.chCarn[1][1] = ConvHex2Asc(BYTE_L(m_Variable.m_nCarNo));

					btTmp = crc16_ccitt(&lsLicSdBuf.phHdBuf.chSrcDev[0],sizeof(LICSD)-6);
					lsLicSdBuf.nCRC[0] = ConvHex2Asc(BYTE_H(WORD_H(btTmp)));
					lsLicSdBuf.nCRC[1] = ConvHex2Asc(BYTE_L(WORD_H(btTmp)));
					lsLicSdBuf.nCRC[2] = ConvHex2Asc(BYTE_H(WORD_L(btTmp)));
					lsLicSdBuf.nCRC[3] = ConvHex2Asc(BYTE_L(WORD_L(btTmp)));
					lsLicSdBuf.btEot = EOT;
					
					user_PacTx((UCHAR *)&lsLicSdBuf,sizeof(LICSD));

					break;
				default:
					break;

				}
			}
			else
			if(WORD_L(pPa_PaBuf->phHdBuf.btSoh) == SOH &&  // PAC <-> PAC 에서 상태 정보를 추출한다.
				    WORD_L(pPa_PaBuf->btEot) == EOT &&
				    sizeof(PAC_PAC) == nRxPos &&
					//(TWOBYTE_ASC2HEX(pPa_PaBuf->phHdBuf.chSrcDev) == PAC_DEV_NO) && 
				    //(TWOBYTE_ASC2HEX(pPa_PaBuf->phHdBuf.chDestDev) == PAC_DEV_NO) && 

				    ConvAsc2Hex(pPa_PaBuf->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&
					ConvAsc2Hex(pPa_PaBuf->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&
					ConvAsc2Hex(pPa_PaBuf->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))&&
					ConvAsc2Hex(pPa_PaBuf->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&pPa_PaBuf->phHdBuf.chSrcDev[0],nRxPos-6)))
				    )
			{
					memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt));
					
					pCommStatus_Lic = (COMMSTATUS_LIC *)m_Variable.m_btCommSt;

					m_Variable.m_TrainCofVal = TWOBYTE_ASC2HEX(pPa_PaBuf->sCCI); //// 차량 중련 상태 정보를 전달. 

					if(m_Variable.m_TrainCofVal == 0x10 || m_Variable.m_TrainCofVal == 0x20)
					{
						m_Variable.m_TrainCofVal = 0x01;
					}

					m_Variable.m_btCiFaultVal = TWOBYTE_ASC2HEX(pPa_PaBuf->sCI_Fault); //CI 고장 정보.

					
					FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[0][9][0],&sCarNumBCD_H,1);
					FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[0][10][0],&sCarNumBCD_L,1);

					nMasterCarNum = MAKE_WORD(sCarNumBCD_H,sCarNumBCD_L);

					MyPrintf("Master CarNum : [%X].\r\n",nMasterCarNum);

					for(i=0;i<(WORD_L(m_Variable.m_TrainCofVal));i++)
					{


						 FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[i][9][0],&sCarNumBCD_H,1);
						 FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[i][10][0],&sCarNumBCD_L,1);

						//8량 전체 프로토콜에서 열번을 이용하여 현재 자신의 위치를 확인 한다.

						 MyPrintf("CarNum : [%X].\r\n",MAKE_WORD(sCarNumBCD_H,sCarNumBCD_L));

						if(BCD_BIN(DWORD_L(m_Variable.m_nCarNo)) == BCD_BIN(MAKE_WORD(sCarNumBCD_H,sCarNumBCD_L)) || 
						   BCD_BIN(DWORD_L(m_Variable.m_nCarNo)) == BCD_BIN(MAKE_WORD(sCarNumBCD_H,sCarNumBCD_L))+1 ||
						   BCD_BIN(DWORD_L(m_Variable.m_nCarNo)) == BCD_BIN(MAKE_WORD(sCarNumBCD_H,sCarNumBCD_L))-1) 
						{

							
							//자신의 위치를 확인 하고 상태 값을 읽어 온다.
							FunConvAscHex((char *)&pPa_PaBuf->phCRA_Sta[i][0][0],btTmpBuf,22);

							pPac_Pac_Sta = (CRA_STATION *) btTmpBuf;


							/*
							//선두 차량이 A 또는 B 이냐에 따라 위치 계산 방식이 달라 진다..
							if((BCD_BIN(nMasterCarNum)%2) == 0 )
							{
								if(m_Variable.m_chCarKind == 'A')      {m_Variable.m_nCarPos = (i*2)+2;}
								else if(m_Variable.m_chCarKind == 'B') {m_Variable.m_nCarPos = (i*2)+1;}
							}
							else
							{
								if(m_Variable.m_chCarKind == 'A')      {m_Variable.m_nCarPos = (i*2)+1;}
								else if(m_Variable.m_chCarKind == 'B') {m_Variable.m_nCarPos = (i*2)+2;}
							}
							

							m_Variable.m_nCarPos_Re = m_Variable.m_nCarPos; //150916_JDS 

							

							//150916_JDS
							//????????????????? 2013_5_2일 확인
							//m_Variable.m_nCarPos_Re =MAKE_WORD(ConvAsc2Hex(pPa_PaBuf->sCI_Index[m_Variable.m_nCarPos][0]),
							//	                            ConvAsc2Hex(pPa_PaBuf->sCI_Index[m_Variable.m_nCarPos][1]));
							//if( m_Variable.m_nCarPos !=  m_Variable.m_nCarPos_Re && m_Variable.m_nCarPos_Re)
							//{
							//	m_Variable.m_nCarPos =  m_Variable.m_nCarPos_Re; 
							//}
							
							
							/*
							MyPrintf("%02X - %02X - %02X - %02X - %02X - %02X - %02X - %02X - - %02X - %02X - %02X \r\n ",
								btTmpBuf[0],btTmpBuf[1],btTmpBuf[2],btTmpBuf[3],btTmpBuf[4],
								btTmpBuf[5],btTmpBuf[6],btTmpBuf[7],btTmpBuf[8],btTmpBuf[9],
								btTmpBuf[10]);
							*/

							/*
							if(m_Variable.m_TrainCofVal)
							{
								m_Variable.m_TrainCofVal =m_Variable.m_TrainCofVal - 1; // 우진 프로토콜 값이 1 더 크다.

								m_Variable.m_TrainCofVal = MIN(3,m_Variable.m_TrainCofVal);
							}

							
							MyPrintf("PAC - PAC / TrainCofVal : %02X -- CiFault : %02X -- CarPos : %02X -- CarPosRe : %02X  \r\n ",
								m_Variable.m_TrainCofVal,m_Variable.m_btCiFaultVal,m_Variable.m_nCarPos,m_Variable.m_nCarPos_Re);
							*/


							if(m_Variable.m_chCarKind == 'A')
							{
				
								
									pCommStatus_Lic->BYTE_1.BIT.nCcp = pPac_Pac_Sta->CRA_2.BIT.sACCP1;
									pCommStatus_Lic->BYTE_3.BIT.nCncs = pPac_Pac_Sta->CRA_3.BIT.sACNCS;
									//pCommStatus_Lic->BYTE_1.BIT.nGps = pPac_Pac_Sta->CRA_2.BIT.sAGPS;
									pCommStatus_Lic->BYTE_1.BIT.nLic = pPac_Pac_Sta->CRA_3.BIT.sALIC;
									pCommStatus_Lic->BYTE_1.BIT.nPac = pPac_Pac_Sta->CRA_3.BIT.sAPAC;
									pCommStatus_Lic->BYTE_1.BIT.nVoip = pPac_Pac_Sta->CRA_2.BIT.sAVOIP;
									pCommStatus_Lic->BYTE_1.BIT.nVtx = pPac_Pac_Sta->CRA_3.BIT.sAVTX;
									//pCommStatus_Lic->BYTE_1.BIT.nWlr = pPac_Pac_Sta->CRA_2.BIT.sAWLR;


									pCommStatus_Lic->BYTE_1.BIT.nFdi = pPac_Pac_Sta->CRA_4.BIT.sAFDI;
									pCommStatus_Lic->BYTE_2.BIT.nPii1 = pPac_Pac_Sta->CRA_4.BIT.sAPII1;
									pCommStatus_Lic->BYTE_2.BIT.nPii2 = pPac_Pac_Sta->CRA_4.BIT.sAPII2;
									pCommStatus_Lic->BYTE_1.BIT.nSdi1 = pPac_Pac_Sta->CRA_5.BIT.sASDI1;
									pCommStatus_Lic->BYTE_2.BIT.nSdi2 = pPac_Pac_Sta->CRA_5.BIT.sASDI2;
									pCommStatus_Lic->BYTE_2.BIT.nSdi3 = pPac_Pac_Sta->CRA_5.BIT.sASDI3;
									pCommStatus_Lic->BYTE_2.BIT.nSdi4 = pPac_Pac_Sta->CRA_5.BIT.sASDI4;

									pCommStatus_Lic->BYTE_2.BIT.nPid1_1 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_1;
									pCommStatus_Lic->BYTE_2.BIT.nPid1_2 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_2;
									pCommStatus_Lic->BYTE_2.BIT.nPid1_3 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_3;
									pCommStatus_Lic->BYTE_3.BIT.nPid1_4 = pPac_Pac_Sta->CRA_6.BIT.sAPID1_4;
									pCommStatus_Lic->BYTE_3.BIT.nPid2_1 = pPac_Pac_Sta->CRA_7.BIT.sAPID2_1;

									//pCommStatus_Lic->BYTE_4.BIT.nDph = pPac_Pac_Sta->CRA_9.BIT.sADPH;
									//pCommStatus_Lic->BYTE_4.BIT.nDpo = pPac_Pac_Sta->CRA_9.BIT.sADPO;
									//pCommStatus_Lic->BYTE_4.BIT.nPei1 = pPac_Pac_Sta->CRA_7.BIT.sAPEI1;
									//pCommStatus_Lic->BYTE_4.BIT.nPei2 = pPac_Pac_Sta->CRA_7.BIT.sAPEI2;

									
								
								//pCommStatus_Lic->BYTE_1.BYTE = d_MDSFaulgTestBuf[0];
								//pCommStatus_Lic->BYTE_2.BYTE = d_MDSFaulgTestBuf[1];
								//pCommStatus_Lic->BYTE_3.BYTE = d_MDSFaulgTestBuf[2];
								//pCommStatus_Lic->BYTE_4.BYTE = d_MDSFaulgTestBuf[3];
								

									
								
									break;
							}
							else if(m_Variable.m_chCarKind == 'B') //프로토콜에는 MA 열차 번호만 있으므로 MB는 스스로 인식 해야 한다.
							{
								/*
									pCommStatus_Lic->BYTE_1.BIT.nCcp = pPac_Pac_Sta->CRA_2.BIT.sBCCP1;
									pCommStatus_Lic->BYTE_1.BIT.nCncs = pPac_Pac_Sta->CRA_3.BIT.sBCNCS;
									pCommStatus_Lic->BYTE_1.BIT.nGps = pPac_Pac_Sta->CRA_2.BIT.sBGPS;
									pCommStatus_Lic->BYTE_1.BIT.nLic = pPac_Pac_Sta->CRA_3.BIT.sBLIC;
									pCommStatus_Lic->BYTE_1.BIT.nPac = pPac_Pac_Sta->CRA_3.BIT.sBPAC;
									pCommStatus_Lic->BYTE_1.BIT.nVoip = pPac_Pac_Sta->CRA_2.BIT.sBVOIP;
									pCommStatus_Lic->BYTE_1.BIT.nVtx = pPac_Pac_Sta->CRA_3.BIT.sBVTX;
									pCommStatus_Lic->BYTE_1.BIT.nWlr = pPac_Pac_Sta->CRA_2.BIT.sBWLR;


									pCommStatus_Lic->BYTE_2.BIT.nFdi = pPac_Pac_Sta->CRA_4.BIT.sBFDI;
									pCommStatus_Lic->BYTE_2.BIT.nPii1 = pPac_Pac_Sta->CRA_4.BIT.sBPII1;
									pCommStatus_Lic->BYTE_2.BIT.nPii2 = pPac_Pac_Sta->CRA_4.BIT.sBPII2;
									pCommStatus_Lic->BYTE_2.BIT.nSdi1 = pPac_Pac_Sta->CRA_5.BIT.sBSDI1;
									pCommStatus_Lic->BYTE_2.BIT.nSdi2 = pPac_Pac_Sta->CRA_5.BIT.sBSDI2;
									pCommStatus_Lic->BYTE_2.BIT.nSdi3 = pPac_Pac_Sta->CRA_5.BIT.sBSDI3;
									pCommStatus_Lic->BYTE_2.BIT.nSdi4 = pPac_Pac_Sta->CRA_5.BIT.sBSDI4;

									pCommStatus_Lic->BYTE_3.BIT.nPid1_1 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_1;
									pCommStatus_Lic->BYTE_3.BIT.nPid1_2 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_2;
									pCommStatus_Lic->BYTE_3.BIT.nPid1_3 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_3;
									pCommStatus_Lic->BYTE_3.BIT.nPid1_4 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_4;
									pCommStatus_Lic->BYTE_3.BIT.nPid2_1 = pPac_Pac_Sta->CRA_7.BIT.sBPID2_1;

									pCommStatus_Lic->BYTE_4.BIT.nDph = pPac_Pac_Sta->CRA_9.BIT.sBDPH;
									pCommStatus_Lic->BYTE_4.BIT.nDpo = pPac_Pac_Sta->CRA_9.BIT.sBDPO;
									pCommStatus_Lic->BYTE_4.BIT.nPei1 = pPac_Pac_Sta->CRA_7.BIT.sBPEI1;
									pCommStatus_Lic->BYTE_4.BIT.nPei2 = pPac_Pac_Sta->CRA_7.BIT.sBPEI2;
									*/
								pCommStatus_Lic->BYTE_1.BIT.nCcp = pPac_Pac_Sta->CRA_2.BIT.sBCCP1;
								pCommStatus_Lic->BYTE_3.BIT.nCncs = pPac_Pac_Sta->CRA_3.BIT.sBCNCS;
								//pCommStatus_Lic->BYTE_1.BIT.nGps pPac_Pac_Sta->CRA_2.BIT.sBGPS;
								pCommStatus_Lic->BYTE_1.BIT.nLic = pPac_Pac_Sta->CRA_3.BIT.sBLIC;
								pCommStatus_Lic->BYTE_1.BIT.nPac = pPac_Pac_Sta->CRA_3.BIT.sBPAC;
								pCommStatus_Lic->BYTE_1.BIT.nVoip = pPac_Pac_Sta->CRA_2.BIT.sBVOIP;
								pCommStatus_Lic->BYTE_1.BIT.nVtx = pPac_Pac_Sta->CRA_3.BIT.sBVTX;
								//pCommStatus_Lic->BYTE_1.BIT.nWlr pPac_Pac_Sta->CRA_2.BIT.sBWLR;


								pCommStatus_Lic->BYTE_1.BIT.nFdi = pPac_Pac_Sta->CRA_4.BIT.sBFDI;
								pCommStatus_Lic->BYTE_2.BIT.nPii1 = pPac_Pac_Sta->CRA_4.BIT.sBPII1;
								pCommStatus_Lic->BYTE_2.BIT.nPii2 = pPac_Pac_Sta->CRA_4.BIT.sBPII2;
								pCommStatus_Lic->BYTE_1.BIT.nSdi1 = pPac_Pac_Sta->CRA_5.BIT.sBSDI1;
								pCommStatus_Lic->BYTE_2.BIT.nSdi2 = pPac_Pac_Sta->CRA_5.BIT.sBSDI2;
								pCommStatus_Lic->BYTE_2.BIT.nSdi3 = pPac_Pac_Sta->CRA_5.BIT.sBSDI3;
								pCommStatus_Lic->BYTE_2.BIT.nSdi4 = pPac_Pac_Sta->CRA_5.BIT.sBSDI4;

								pCommStatus_Lic->BYTE_2.BIT.nPid1_1 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_1;
								pCommStatus_Lic->BYTE_2.BIT.nPid1_2 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_2;
								pCommStatus_Lic->BYTE_2.BIT.nPid1_3 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_3;
								pCommStatus_Lic->BYTE_3.BIT.nPid1_4 = pPac_Pac_Sta->CRA_6.BIT.sBPID1_4;
								pCommStatus_Lic->BYTE_3.BIT.nPid2_1 = pPac_Pac_Sta->CRA_7.BIT.sBPID2_1;

								//pCommStatus_Lic->BYTE_4.BIT.nDph = pPac_Pac_Sta->CRA_9.BIT.sBDPH;
								//pCommStatus_Lic->BYTE_4.BIT.nDpo = pPac_Pac_Sta->CRA_9.BIT.sBDPO;
								//pCommStatus_Lic->BYTE_4.BIT.nPei1 = pPac_Pac_Sta->CRA_7.BIT.sBPEI1;
								//pCommStatus_Lic->BYTE_4.BIT.nPei2 = pPac_Pac_Sta->CRA_7.BIT.sBPEI2;

									break;
							}

						}
						
					}

			}
			else
				if(WORD_L(pCcp_Pac->phHdBuf.btSoh) == SOH &&  // CCP -> PAC 에서 상태 정보를 추출한다.
					WORD_L(pCcp_Pac->btEot) == EOT &&
					sizeof(CCP_PAC) == nRxPos &&
					((TWOBYTE_ASC2HEX(pCcp_Pac->phHdBuf.chSrcDev) == CCP_DEV_NO)||(TWOBYTE_ASC2HEX(pCcp_Pac->phHdBuf.chSrcDev) == CCP_BAKDEV_NO)) &&
					//(TWOBYTE_ASC2HEX(pCcp_Pac->phHdBuf.chDestDev) == PAC_DEV_NO)&&

					ConvAsc2Hex(pCcp_Pac->nCRC[0]) == BYTE_H(WORD_H(crc16_ccitt(&pCcp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))&&
					ConvAsc2Hex(pCcp_Pac->nCRC[1]) == BYTE_L(WORD_H(crc16_ccitt(&pCcp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))&&
					ConvAsc2Hex(pCcp_Pac->nCRC[2]) == BYTE_H(WORD_L(crc16_ccitt(&pCcp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))&&
					ConvAsc2Hex(pCcp_Pac->nCRC[3]) == BYTE_L(WORD_L(crc16_ccitt(&pCcp_Pac->phHdBuf.chSrcDev[0],nRxPos-6)))
					)
			{

					if(m_Variable.m_chCarKind == 'A')
					{
						m_Variable.m_nCarPos_Re = MAKE_WORD(ConvAsc2Hex(pCcp_Pac->sCI_Index[0][0]),
						                                    ConvAsc2Hex(pCcp_Pac->sCI_Index[0][1]));

						if(m_Variable.m_nCarPos_Re)
						{
							//m_Variable.m_nCarPos = m_Variable.m_nCarPos_Re; //150916_JDS
						}

					}
					else if(m_Variable.m_chCarKind == 'B')
					{
						m_Variable.m_nCarPos_Re = MAKE_WORD(ConvAsc2Hex(pCcp_Pac->sCI_Index[1][0]),
															ConvAsc2Hex(pCcp_Pac->sCI_Index[1][1]));

						if(m_Variable.m_nCarPos_Re)
						{
							//m_Variable.m_nCarPos = m_Variable.m_nCarPos_Re; //150916_JDS
						}

					}

					/*
					sAdd1 = MAKE_WORD(ConvAsc2Hex(pCcp_Pac->sCI_Index[0][0]),
						              ConvAsc2Hex(pCcp_Pac->sCI_Index[0][1]));

					sAdd2 = MAKE_WORD(ConvAsc2Hex(pCcp_Pac->sCI_Index[1][0]),
						ConvAsc2Hex(pCcp_Pac->sCI_Index[1][1]));


					sAdd3 = MAKE_WORD(ConvAsc2Hex(pCcp_Pac->sCI_Index[2][0]),
						ConvAsc2Hex(pCcp_Pac->sCI_Index[2][1]));

					//FunConvAscHex((char *)&pCcp_Pac->sCCP_Date[0][0],btTmpBuf,12);

					//memcpy(&m_Variable.m_tmCurTime.second,btTmpBuf,6);


				  // m_Variable.m_nCarPos_Re = MAKE_WORD(ConvAsc2Hex(pCcp_Pac->sCI_Index[m_Variable.m_nCarPos][0]),
				//                                   ConvAsc2Hex(pCcp_Pac->sCI_Index[m_Variable.m_nCarPos][1]));

					//MyPrintf("CCP -> PAC SD DATA : %02X  : %02X  : %02X  \r\n ",sAdd1,sAdd2,sAdd3);
					*/



			}
		
		}
	}

	nOldUart3RxOneByteGapDelayTime = m_Variable.m_nUart3RxOneByteGapDelayTime;
}

//******************************************************************************************
//	UTC 시간을 구하는 부분.
//*****************************************************************************************
BOOL GetLocalTimeToUTC( DATE_TIME_PTR pLocal, int nHour, DATE_TIME_PTR pUTC )
{
	// 시간을 계산하는 부분.
	int nHourT = pLocal->hour - nHour;
	int nDayT = pLocal->day;
	int nLastDays = GetDaysOfMonth( pLocal->month, pLocal->year );													
	int nMonthT = pLocal->month;
	int nYearT = 2000 + pLocal->year;

	// 시간 정보를 구하는 부분.
	if(nHourT < 0 ) {
		nHourT += 24;
		nDayT += -1;
	}
	else if( 24 <= nHourT ) {
		nHourT -= 24;
		nDayT += 1;
	}

	// 일자를 구하는 부분.
	// 시간을 계산하여 일자를 변경해야하는 경우.
	if(nDayT < 1)																										
	{
		nDayT = GetDaysOfMonth( nMonthT, nYearT );
		
		if(--nMonthT < 1)
		{
			nYearT--;
			nMonthT = 12;
		}
	}
	else if(nLastDays < nDayT)
	{
		nDayT = 1;
		
		if(12 < ++nMonthT)
		{
			nYearT++;
			nMonthT = 1;
		}
	}

	// 계산된 시분초 정보를 UTC 시간으로 이동시키는 부분.
	pUTC->second = pLocal->second;
	pUTC->minute = pLocal->minute;
	pUTC->hour = nHourT;
	pUTC->day = nDayT;
	pUTC->month = nMonthT;
	pUTC->year = nYearT - 2000;

	return      (( 10 <= pUTC->year ) &&																		// 10년 이상
				(( 1 <= pUTC->month ) && ( pUTC->month <= 12 )) &&											// 월
				(( 1 <= pUTC->day )   && ( pUTC->day <= GetDaysOfMonth(nMonthT, nYearT) )) && 				// 일
				(( 0 <= pUTC->hour )  && ( pUTC->hour < 24 ))   && 											// 시
				(( 0 <= pUTC->minute) && ( pUTC->minute < 60 )) &&											// 분
				(( 0 <= pUTC->second) && ( pUTC->second < 60 )));											// 초
}

//******************************************************************************************
//	달의 마지막 일자 정보를 구하는 부분.
//******************************************************************************************
int IsLeapYear( int nYear ) 								// 윤년 정보를 구하는 부분.
{
  if( nYear % 400 == 0 )
   return 1;

  if( nYear % 100 == 0 )
   return 0;

  if( nYear % 4 == 0 )
   return 1;

  return 0;
}

int GetDaysOfMonth( int nMonth, int nYear ) 				// 달의 마지막 일자를 구하는 부분.
{
	/* 달의 일수를 저장하는 변수 */
	int nDays = 0;

	switch( nMonth )
	{
	case 1 :												// 31을 마지막 날달
	case 3 :
	case 5 :
	case 7 :
	case 8 :
	case 10 :
	case 12 :		
		nDays = 31;
		break;
	case 2 :
		nDays = 28;
		if( IsLeapYear( nYear ) )							// 윤년을 계산하여, 윤달일 경우, +1
			nDays += 1;
		break;
	case 4 :												// 30을 마지막 날달
	case 6 :
	case 9 :
	case 11 : 
		nDays = 30;
		break;
	}

	return nDays;
}

//******************************************************************************************
//	차량번호를 LON에게 전달하여 A카인지 B카인지 알려준다.
// 이 함수를 호출하면 5회 반복하여 보내준다.
//******************************************************************************************
void user_CarNoForCarKindToLon()
{
	m_Variable.m_nCarKindToLonCnt = 0;
}

//******************************************************************************************
//	1ms Loop
//******************************************************************************************

void user_1msLoop()
{	
	m_Variable.m_nTxDbg1msTimer++;
	m_Variable.m_nUserDebug1msTimer++;

	m_Variable.m_nTest1msTimer++;


	if(m_Variable.m_nUart2RxOneByteGapDelayTime) m_Variable.m_nUart2RxOneByteGapDelayTime--;
	if(m_Variable.m_nUart3RxOneByteGapDelayTime) m_Variable.m_nUart3RxOneByteGapDelayTime--;
		
	if(m_Variable.m_nGiaRxCheck1msTimer) m_Variable.m_nGiaRxCheck1msTimer--;

	if(m_Variable.m_nCncsRxCheck1msTimer) m_Variable.m_nCncsRxCheck1msTimer--;

	

}

