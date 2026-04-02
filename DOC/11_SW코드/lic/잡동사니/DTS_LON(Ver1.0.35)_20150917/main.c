//*****************************************************************************************
//	LIC-A0
//	Program By : 연준상
//	
//	버젼
//	1) Ver 1.00:2010/3/2 -> 
//							- 처음시작
//	2) Ver 1.01:2010/4/29 -> 
//							- LIC <-> PAC간 통신추가(PAC(SDR) <-> LIC(SD)), 미국가서 장덕수가 추가(뭐 추가했는지 모름)
//	3) Ver 1.02:2010/10/15 -> 
//							- 버젼이 추가되어 수정(with LON(에버론), On philadelphia)
//							- All door close관련하여 추가 및 확인(with LON(에버론), On philadelphia)
//							- UART통신 1체널의 전송 버퍼를 조정(On philadelphia)
//							- 덕수가 주석 처리해놓은 디버그용 루틴 복원
//	4) Ver 1.031:2010/11/29 ->
//							- 버젼을 3자리에서 4자리로 수정, "m_pBoardIdInfo" 테이블 내에서 수정
//							- LIC <-> PAC간 LIC버젼전송되었는 소스부분을 접점신호(DOOR)로 변경, "user_WithPacRs485Loop()" 함수 내에서 수정
//	5) Ver 1.032:2011/03/17 -> Modify BY Y.J 
//							- 시간 정보를 CNCS에서 받아서 처리하는 부분을 GIA서 받아서 처리하도록 수정.
//							- UTC 시간을 계산하는 내용 추가.
//							- PAC <-> PAC통신 프로토콜 수정.
//							- UTC 계산시 년도에 2000년 합산하여 계산하도록 수정.
//  6) Ver 1.033:2011/05/11 -> Modify By Y.J
//							- 고장 요청 시간을 Word에서 DWORD로 변경.
//							- 고장 완료시 통신 패킷 검사 오류 수정, 전송 실패 패킷을 재전송기능 검사 완료.
//							- Married B Car의 데이터 요청을 A Car가 완료된 후 하도록 수정함.
//  7)          :2011/05/14 -> Modify By Y.J
//							- CDT별 고장 데이터의 Block을 관리하도록 수정.
//							- CNCS에서 기록한 데이터 Block이외의 Index를 요구할 경우, 완료를 돌려주도록 수정.
//  8) Ver 1.0.34:2011/05/19 -> Modify By Y.J
//							- CDT 차량 번호 연산 오류 수정.
//  9) Ver 1.0.35(2012/05/16) -> Modify By 연준상
//							- 뎀버용으로 수정
//							- QT에서 시험 절차서 대로 실험 및 수정(WOOJIN,MELCO,QT)
//							- 디버그&모니터용 프로그램 수정하여 많은 데이터를 모니터 할 수 있도록 수정
//							- 파라메터값(차량구성,차량(CI)위치,CI고장비트)
//							- STATUS비트 전달에서 순간 트리거 신호도 Capture하여 수정할 수 있도록 수정
// 10) 150916_JDS			- CI 위치 정보와 고장 정보를 LIC MPU 프로그램이 프로토콜을 분석해서 알아서 전송(TEST 버전)
//*****************************************************************************************

#include "stdio.h"
#include "string.h"
#include "stdarg.h"
#include "def.h"
#include "Variable.h"
#include "LonInfo.h"
#include "debug3x.h"
#include "xr16l784.h"
#include "ds1647.h"
#include "LonInfo.h"
#include "MpuDebug.h"
#include "main.h"
#include "user.h"



static const WORD crc16tab[256]= {
	0x0000,0x1021,0x2042,0x3063,0x4084,0x50a5,0x60c6,0x70e7,
	0x8108,0x9129,0xa14a,0xb16b,0xc18c,0xd1ad,0xe1ce,0xf1ef,
	0x1231,0x0210,0x3273,0x2252,0x52b5,0x4294,0x72f7,0x62d6,
	0x9339,0x8318,0xb37b,0xa35a,0xd3bd,0xc39c,0xf3ff,0xe3de,
	0x2462,0x3443,0x0420,0x1401,0x64e6,0x74c7,0x44a4,0x5485,
	0xa56a,0xb54b,0x8528,0x9509,0xe5ee,0xf5cf,0xc5ac,0xd58d,
	0x3653,0x2672,0x1611,0x0630,0x76d7,0x66f6,0x5695,0x46b4,
	0xb75b,0xa77a,0x9719,0x8738,0xf7df,0xe7fe,0xd79d,0xc7bc,
	0x48c4,0x58e5,0x6886,0x78a7,0x0840,0x1861,0x2802,0x3823,
	0xc9cc,0xd9ed,0xe98e,0xf9af,0x8948,0x9969,0xa90a,0xb92b,
	0x5af5,0x4ad4,0x7ab7,0x6a96,0x1a71,0x0a50,0x3a33,0x2a12,
	0xdbfd,0xcbdc,0xfbbf,0xeb9e,0x9b79,0x8b58,0xbb3b,0xab1a,
	0x6ca6,0x7c87,0x4ce4,0x5cc5,0x2c22,0x3c03,0x0c60,0x1c41,
	0xedae,0xfd8f,0xcdec,0xddcd,0xad2a,0xbd0b,0x8d68,0x9d49,
	0x7e97,0x6eb6,0x5ed5,0x4ef4,0x3e13,0x2e32,0x1e51,0x0e70,
	0xff9f,0xefbe,0xdfdd,0xcffc,0xbf1b,0xaf3a,0x9f59,0x8f78,
	0x9188,0x81a9,0xb1ca,0xa1eb,0xd10c,0xc12d,0xf14e,0xe16f,
	0x1080,0x00a1,0x30c2,0x20e3,0x5004,0x4025,0x7046,0x6067,
	0x83b9,0x9398,0xa3fb,0xb3da,0xc33d,0xd31c,0xe37f,0xf35e,
	0x02b1,0x1290,0x22f3,0x32d2,0x4235,0x5214,0x6277,0x7256,
	0xb5ea,0xa5cb,0x95a8,0x8589,0xf56e,0xe54f,0xd52c,0xc50d,
	0x34e2,0x24c3,0x14a0,0x0481,0x7466,0x6447,0x5424,0x4405,
	0xa7db,0xb7fa,0x8799,0x97b8,0xe75f,0xf77e,0xc71d,0xd73c,
	0x26d3,0x36f2,0x0691,0x16b0,0x6657,0x7676,0x4615,0x5634,
	0xd94c,0xc96d,0xf90e,0xe92f,0x99c8,0x89e9,0xb98a,0xa9ab,
	0x5844,0x4865,0x7806,0x6827,0x18c0,0x08e1,0x3882,0x28a3,
	0xcb7d,0xdb5c,0xeb3f,0xfb1e,0x8bf9,0x9bd8,0xabbb,0xbb9a,
	0x4a75,0x5a54,0x6a37,0x7a16,0x0af1,0x1ad0,0x2ab3,0x3a92,
	0xfd2e,0xed0f,0xdd6c,0xcd4d,0xbdaa,0xad8b,0x9de8,0x8dc9,
	0x7c26,0x6c07,0x5c64,0x4c45,0x3ca2,0x2c83,0x1ce0,0x0cc1,
	0xef1f,0xff3e,0xcf5d,0xdf7c,0xaf9b,0xbfba,0x8fd9,0x9ff8,
	0x6e17,0x7e36,0x4e55,0x5e74,0x2e93,0x3eb2,0x0ed1,0x1ef0
};

//*****************************************************************************************
//	변수 정의
//*****************************************************************************************

UINT m_nDebug1msTimer = 0;
int m_nDebugCnt = 0;

const char *m_pBoardIdInfo[] =
{
	"Firmware:LIC-C3",
	"Version:1.035", // 버젼, 프로그램의 모든 부분에 참조, 반드시 버젼만 수정할 것
	"Date:2012/05/16",
	NULL
};

//*****************************************************************************************
//	메인 함수
//*****************************************************************************************
void main(void)
{
	int i;
	DATE_TIME_TYPE tmBuf;
	
	DINT;
	WDI_ACT;
	DspInit();
	Debug3xInit(TMS320C31);

	XR16L784_TXDIS(XR16L784_1CHL);
	XR16L784_TXDIS(XR16L784_2CHL);
	XR16L784_TXDIS(XR16L784_3CHL);
	XR16L784_TXDIS(XR16L784_4CHL);

	xr16l784_Init(XR16L784_1CHL,38400,XR16L784_DATA8,XR16L784_NONEPARITY,XR16L784_1STOPBIT); // 디버그용
	xr16l784_Init(XR16L784_2CHL,38400,XR16L784_DATA8,XR16L784_NONEPARITY,XR16L784_1STOPBIT); // LIC <-> CNCS
	xr16l784_Init(XR16L784_3CHL,19200,XR16L784_DATA8,XR16L784_NONEPARITY,XR16L784_1STOPBIT); // LIC <-> PAC
	//xr16l784_Init(XR16L784_4CHL,19200,XR16L784_DATA8,XR16L784_NONEPARITY,XR16L784_1STOPBIT); // LIC <-> PAC

	WDI_ACT;
	EINT;
	user_Init();
	
		
	while(1)
	{
		user_Loop();
		xr16l784_Loop();

		if(!XR16L784_INT_ST) xr16l784_Isr();
		
		if(m_nDebug1msTimer > 500)
		{
			m_nDebug1msTimer = 0;

			//xr16l784_RtsDelayStartSend(XR16L784_3CHL,(UCHAR *)"1234567",7,5);
		}
		
		m_nDebugCnt++;

	}
}
//*****************************************************************************************
//	MPU설정
//*****************************************************************************************
void DspInit(void)
{
	PRIMBUSREG = 0x10e8;
	EN_CACHE;

	// Timer 0
	TMR0_CTRL = 0x2c0 ; // 내부 클럭
	TMR0_PERD = 25000; // 100,000,000MHz / 4 / 25000(x) = 1000Hz(1000us)

	INT1_VECT			= OP_BR | (int)c_int02; // Ext Int 0	
	INT2_VECT			= OP_BR | (int)c_int03; // Ext Int 1	
	TINT0_VECT			= OP_BR | (int)c_int10; // Timer 0	
	
	//EI_INT0;
	EI_INT2;
	EI_TINT0;
	
	// XF0, XF1 출력 모드
	asm(" LDI 0066h,IOF");	
	
	BOOT2INT;
}



//*****************************************************************************************
//	BCD를 BIN로 바꾼다.
//*****************************************************************************************
WORD BCD_BIN(WORD nInput)
{
	WORD sNum = 0;

	sNum += ((nInput>>12)&0xf) * 1000;
	sNum += ((nInput>>8)&0xf) * 100;
	sNum += ((nInput>>4)&0xf) * 10;
	sNum += ((nInput)&0xf) * 1;
	return sNum;
}

//*****************************************************************************************
//	ASC를 HEX로 바꾼다.
//*****************************************************************************************
UCHAR ConvAsc2Hex(char chDat)
{
	int nBuf = 0;	
	if(chDat >= '0' && chDat <= '9') nBuf = chDat-'0';		
	else
	if(chDat >= 'a' && chDat <= 'f') nBuf = ((chDat-'a') + 10);		
	else
	if(chDat >= 'A' && chDat <= 'F') nBuf = ((chDat-'A') + 10);
	
	return nBuf;
}

//*****************************************************************************************
//	여러개의 ASC를 HEX로 바꾼다.
//*****************************************************************************************
int FunConvAscHex(char *InchData,UCHAR *OuthexData,int Len)
{
	int i;
	int sCnt = 0;
	for(i=0;i<Len; )
	{
		OuthexData[sCnt] = (ConvAsc2Hex(InchData[i++])<<4)&0xF0;
		OuthexData[sCnt] |= ConvAsc2Hex(InchData[i++])&0x0F;

		sCnt++;
	}
	return sCnt;
}

//*****************************************************************************************
//	숫자 ASC인가?
//*****************************************************************************************
BOOL IsNumAsc(char nCh)
{
	if(nCh >= '0' && nCh <= '9') return TRUE;
	return FALSE;
}

//*****************************************************************************************
//	ASC를 DEC로 바꾼다.
//*****************************************************************************************
int ConvAsc2Dec(char nCh)
{
	int nBuf = 0;	
	if(nCh >= '0' && nCh <= '9') nBuf = nCh-'0'; else return 0;
	return nBuf;
}

//*****************************************************************************************
//	HEX를 ASC로 바꾼다.
//*****************************************************************************************
char ConvHex2Asc(UCHAR btCh)
{
	char chBuf = '0';
	if(btCh >= 0 && btCh <= 9) chBuf = btCh+'0';
	else if(btCh >= 10 && btCh <= 15) chBuf = (btCh-10)+'A';
	return chBuf;
}
//*****************************************************************************************
//	DEC를 HEX로 바꾼다.
//*****************************************************************************************
int ConvDec2Hex(char nCh)
{
	return ((((nCh / 0x10) & 0x0F) << 4) | ((nCh % 0x10) & 0x0F));
}

int FunConvHexAsc(UCHAR *InhexData,char *OUTAscData,int Len)
{
	int i;
	int sCnt = 0;
	for(i=0;i<Len;i++)
	{
		OUTAscData[sCnt++] = ConvHex2Asc(BYTE_H(InhexData[i]));
		OUTAscData[sCnt++] = ConvHex2Asc(BYTE_L(InhexData[i]));
	}
	return sCnt;
}
//*****************************************************************************************
// Decimal의 10자리 문자로 바꾼다.
//*****************************************************************************************
void Dec2Str(char *pBuf,int nDat)
{
	int i;
	int nPos;
	char szBuf[32];
	
	nPos=0;
	szBuf[nPos++] = (nDat/1000000000%10)+'0';
	szBuf[nPos++] = (nDat/100000000%10)+'0';
	szBuf[nPos++] = (nDat/10000000%10)+'0';
	szBuf[nPos++] = (nDat/1000000%10)+'0';
	szBuf[nPos++] = (nDat/100000%10)+'0';
	szBuf[nPos++] = (nDat/10000%10)+'0';
	szBuf[nPos++] = (nDat/1000%10)+'0';
	szBuf[nPos++] = (nDat/100%10)+'0';
	szBuf[nPos++] = (nDat/10%10)+'0';
	szBuf[nPos++] = (nDat%10)+'0';
	szBuf[nPos] = NULL;
	
	for(i=0;i<nPos;i++) if(szBuf[i]!='0') break;
	i = MIN(i,nPos-1);
	
	StrCpy(pBuf,&szBuf[i]);
}

//*****************************************************************************************
//	문자를 뒤에 붙인다.
//*****************************************************************************************
void StrCat(char *dest, const char *src)
{
   char *r1 = dest - 1;
   while (*++r1);
   while ((*r1++ = *src++) != 0);
}

//*****************************************************************************************
//	문자 길이 구하기
//*****************************************************************************************
int StrLen(const char *string)
{
   const char *r1 = string - 1;
   while (*++r1);
   return r1 - string;
}

//*****************************************************************************************
//	문자 복사
//*****************************************************************************************
void StrCpy(char *dest, const char *src)
{
   char *result = dest;
   while ((*dest++ = *src++) != 0);
}

//*****************************************************************************************
//	문자 비교
//*****************************************************************************************
int StrCmp(const char *string1, const char *string2)
{
   char *r1 = (char *)string1 - 1;
   char *r2 = (char *)string2 - 1;
   char cp = TRUE;

   while ( (*++r2 == (cp = *++r1)) && cp );

   return *r1 - *r2;
}

//**************************************************************************************
//  디버깅용 전송
//**************************************************************************************
void MyPrintf(char * format, ... )
{
	va_list args;
	char szBuf[256];

	va_start(args, format);
	vsprintf(szBuf, format, args);
	
	xr16l784_Send(XR16L784_1CHL,(UCHAR *)szBuf,strlen(szBuf));
}

//*****************************************************************************************
// Firmware 버젼 String를 비교하여 맞는지 검사
//*****************************************************************************************
BOOL FirmwareVersionStrCmp(char *pObj,char *pSrc,int nLen)
{
	int i;
	BOOL bFlag = TRUE;
	for(i=0;i<nLen;i++) if(pObj[i] != pSrc[i]) {bFlag = FALSE; break;}
	return bFlag;
}

//*****************************************************************************************
//	Version찾아서 버젼값으로 얻기
//  nVerBuildData = 1 //버전 정보
//  nVerBuildData = 2 //날짜 정보
//*****************************************************************************************
int GetFirmwareVersion(UCHAR nVerBuildData)
{
	int i;
	int nVer = 100;
	char *pVersionString;

	for(i=0;i<128;i++)
	{
		pVersionString = (char *)m_pBoardIdInfo[i];
		if(pVersionString == NULL) break;

		if(WORD_L(nVerBuildData) == 1)
		{
			if(FirmwareVersionStrCmp("Version",pVersionString,7))
			{
				nVer = ConvAsc2Dec(pVersionString[8])*1000+ConvAsc2Dec(pVersionString[10])*100+ConvAsc2Dec(pVersionString[11])*10+ConvAsc2Dec(pVersionString[12]);
				break;
			}
		}
		else if(WORD_L(nVerBuildData) == 2)
		{
			if(FirmwareVersionStrCmp("Date",pVersionString,4))
			{
				nVer = ConvAsc2Dec(pVersionString[7])*100000+ConvAsc2Dec(pVersionString[8])*10000+ConvAsc2Dec(pVersionString[10])*1000+
				       ConvAsc2Dec(pVersionString[11])*100+ConvAsc2Dec(pVersionString[13])*10+ConvAsc2Dec(pVersionString[14]);
				break;
			}
		}
	}

	return nVer;
}

//**********************************************************************************
//	1Byte BCC 체크를 만든다.
//**********************************************************************************
UCHAR Make1ByteBcc(UCHAR *pDat,int nLen)
{
	int i;
	UCHAR btBcc = 0x00;
	for(i=0;i<nLen;i++)	btBcc ^= pDat[i];
	return btBcc;
}

//*****************************************************************************************
//	BCC 체크를 만든다. BCC를 만들어 pDat에 저장한다.
//*****************************************************************************************
void MakeBcc(UCHAR *pDat,int nLen)
{
	int i;
	
	pDat[nLen] = pDat[nLen+1] = 0x00;

	for(i=0;i<nLen;i++)	pDat[nLen + (i&0x01)] ^= pDat[i];
}

//*****************************************************************************************
//	BCC가 정상적으로 되었는가 검사
//	return : OK : TRUE, NG : FALSE
//*****************************************************************************************
int IsBccOk(UCHAR *pDat,int nLen)
{	
	int i;
	UCHAR nBCC[2];
	
	nBCC[0] = nBCC[1] = 0x00;

	for(i=0;i<nLen;i++)
	{
		nBCC[(i&0x01)] ^= WORD_L(pDat[i]);
	}
	
	if(nBCC[0] != WORD_L(pDat[nLen]) || nBCC[1] != WORD_L(pDat[nLen+1]))
	{
		return FALSE;
	}
	else
	{
		return TRUE;
	}
}

//*******************************************************************************************
//	crc16_ccitt
//	
//*******************************************************************************************
WORD crc16_ccitt(UCHAR *buf, int len)
{
	WORD counter;
	WORD crc = 0xFFFF;
	for( counter = 0; counter < len; counter++)
		crc = (crc<<8) ^ crc16tab[((crc>>8)^buf[counter])&0x00FF];
	return crc;
}

//*******************************************************************************************
//	인천 MMI에서 사용
//	초로환산한 시간을 년/월/일/시/분/초로 바꿔준다.
//*******************************************************************************************
BOOL gm_SysTimeToRtc(DATE_TIME_PTR pTime,UINT nSysTime)
{
	BOOL bSec;
	int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }; 
	int nTemp;
	unsigned int nDays,nTotalSecond = nSysTime,nFrontSec,nRearSec;
	int nBaseYear = 2000;

	bSec = FALSE;
	nRearSec = nFrontSec = 0;
	for(nTemp = nBaseYear; nTemp <= 2245 ;nTemp++)
	{
		nDays = 365;
		if((!(nTemp % 4) && (nTemp % 100)) || !(nTemp % 400)) nDays += 1;
		nRearSec = nFrontSec;
		nFrontSec += nDays*24*60*60;
		if(ISRANGE_LOW(nTotalSecond,nRearSec,nFrontSec))
		{
			pTime->year = BIN2BCD(nTemp-nBaseYear);
			nTotalSecond -= nRearSec;
			bSec = TRUE;
			break;
		}
	}

	if(!bSec) return FALSE;

	bSec = FALSE;
	nDays = 0;
	nRearSec = nFrontSec = 0;
	for(nTemp=0;nTemp<11;nTemp++) 
	{
		nDays += days[nTemp];
		nRearSec = nFrontSec;
		nFrontSec = nDays*24*60*60;
		if(ISRANGE_LOW(nTotalSecond,nRearSec,nFrontSec))
		{
			pTime->month = BIN2BCD(nTemp+1);
			nTotalSecond -= nRearSec;
			bSec = TRUE;
			break;
		}
	}

	if(!bSec) return FALSE;

	nTemp = nTotalSecond/(24*60*60);
	pTime->day = BIN2BCD(nTemp+1);
	nTotalSecond %= (24*60*60);

	nTemp = nTotalSecond/(60*60);
	pTime->hour = BIN2BCD(nTemp);
	nTotalSecond %= (60*60);

	nTemp = nTotalSecond/60;
	pTime->minute = BIN2BCD(nTemp);
	nTotalSecond %= 60;

	pTime->second = BIN2BCD(nTotalSecond);
	
	return TRUE;
}


//*****************************************************************************************
//	지연
//*****************************************************************************************
int Delay(int nCnt)
{
	while(nCnt--) WDI_ACT;	
	return 0;
}

//*****************************************************************************************
//	Interrupt 0
//*****************************************************************************************
UCHAR nInt_01_Cnt = 0;
void c_int02()
{
	xr16l784_Isr();
	nInt_01_Cnt++;

}

//*****************************************************************************************
//	Interrupt 1
//*****************************************************************************************
UCHAR nInt_02_Cnt = 0;
void c_int03()
{
	LonWorkRead();
	nInt_02_Cnt++;
}

//*****************************************************************************************
//	Timer0(1ms)
//*****************************************************************************************
void c_int10(void)
{
	static int nRunLedCnt=0;
	
	xr16l784_1msLoop();
	user_1msLoop();
	LonInfo_1msLoop();
	Debug_1msLoop();
	
	m_nDebug1msTimer++;

	WDI_ACT;

	RUN_LED(nRunLedCnt&0x20 ? 1 : 0);
	ERR_LED(0);

	nRunLedCnt++;
}
