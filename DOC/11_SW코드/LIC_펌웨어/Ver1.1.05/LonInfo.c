
#include "def.h"
#include "Variable.h"
#include "LonInfo.h"


extern VARIABLE_H m_Variable;
//******************************************************************************************
//	LONWORK 읽어서 처리 및 전송
//******************************************************************************************
void LonWorkLoop()
{
	int i;
	int nTxPos = 0;
	UCHAR btTxBuf[128];
	UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;
	char szBuf[512];
	char szBuf2[64];
	
	if(m_Variable.m_nCDT_FaultDataStFlag == 1)
	{
		m_Variable.m_nCDT_FaultDataStFlag = 0;

		m_Variable.m_LIC_CNCS_Tx_Flag = TRUE;
		m_Variable.m_nTxDbg1msTimer = 0;

		nTxPos = 0;
		btTxBuf[nTxPos++] = STX;  // STX
		btTxBuf[nTxPos++] = 0x01; // Command Code
		btTxBuf[nTxPos++] = 0x00; // 0x00으로 설정
		btTxBuf[nTxPos++] = 0x06; // 길이
		btTxBuf[nTxPos++] = m_Variable.m_nLnWkTxFlag; // 스테이션(Recently):0x01, 기지창(Historycal):0x02
		btTxBuf[nTxPos++] = 0x00; // 
		btTxBuf[nTxPos++] = WORD_H(DWORD_H(m_Variable.m_nDateTime2SecondCnt)); // 시간(HH)
		btTxBuf[nTxPos++] = WORD_L(DWORD_H(m_Variable.m_nDateTime2SecondCnt)); // 시간(HL)
		btTxBuf[nTxPos++] = WORD_H(DWORD_L(m_Variable.m_nDateTime2SecondCnt)); // 시간(LH)
		btTxBuf[nTxPos++] = WORD_L(DWORD_L(m_Variable.m_nDateTime2SecondCnt)); // 시간(LL)
		btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
		btTxBuf[nTxPos++] = ETX; // ETX
		LonWorkTx(btTxBuf,nTxPos);

		MyPrintf("LonMDS Falut Request : ",nTxPos);
		//for(i=0;i<nTxPos;i++) MyPrintf("%02X ",WORD_L(btTxBuf[i]));
		//MyPrintf("\r\n");
	}

	// NVSRAM에 저장된 내용을 RS232로 전송하여 디버깅한다.
	if(m_Variable.m_bLnWkDbgTxFlag)
	{
		m_Variable.m_bLnWkDbgTxFlag = FALSE;
		m_Variable.m_nDbgTxPos = 0;
		m_Variable.m_nTxDbg1msTimer = 0;
	}
	
	if(m_Variable.m_nDbgTxPos < m_Variable.m_nNvsramPos) //m_nDbgTxPos = 0xFFFFFFFF 로 항상 큰 값을 가지고 있다가 전송하라는 명령에 위해 0으로 클리어 된다.
	{
		if(m_Variable.m_nTxDbg1msTimer > 200)
		{
			m_Variable.m_nTxDbg1msTimer = 0;
			szBuf[0] = 0;
			for(i=0;i<(MIN(128,(UINT)(m_Variable.m_nNvsramPos-m_Variable.m_nDbgTxPos)));i++) {sprintf(szBuf2,"%02X ",pNvsram[m_Variable.m_nDbgTxPos+i]); strcat(szBuf,szBuf2);}
			strcat(szBuf,"\r\n");
			user_DebugPrint(szBuf);
			m_Variable.m_nDbgTxPos += 128;
		}
	}
	else
	if(m_Variable.m_nDbgTxPos == 0xFFFFFFFF)
	{
		if(nTxPos)
		{
			szBuf[0] = 0;
			sprintf(szBuf2,"[TX:%02d] ",nTxPos); strcat(szBuf,szBuf2);
			for(i=0;i<nTxPos;i++) {sprintf(szBuf2,"%02X ",WORD_L(btTxBuf[i])); strcat(szBuf,szBuf2);}
			strcat(szBuf,"\r\n");
			user_DebugPrint(szBuf);			
		}
	}
}
//******************************************************************************************
//	LonWorkRead
//******************************************************************************************

UCHAR d_MDSinputData = 0; // MDS 입력 값을 확인 한다.
UCHAR d_CIShiftFlag = 0;  // MDS Flage 정보 

UCHAR d_BufChack[10];

void LonWorkRead()
{
	int i;
	int nTmp;
	PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;
	UCHAR *pNvsram = (UCHAR *)NVSRAM_BASE;
	PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //버전 정보 처리를 위해 임의로 만들었다.
	UCHAR nKind;
	static UCHAR nOldKind = 0;
	UCHAR nRxLen;
	static int nRecRxPos = 0;
	UCHAR btRxBuf[256];
	static UCHAR btFtpOneRecRxBuf[1024];
	int nTxPos = 0;
	UCHAR btTxBuf[128];
	char szBuf[512];
	char szBuf2[64];
	
	nKind = WORD_L(pLnWkDp->btKind); 

	switch(nKind)
	{
	// FTP1~6 프로토콜
	case 1: case 2: case 3: case 4: case 5: case 6:
		nRxLen = 0;
		
		// 시작
		if(nKind == 1)
		{
			nRecRxPos = 0;
			nRxLen = LonWorkRx(nKind,btRxBuf);
			if(nRxLen>6 && nRecRxPos<768)
			{
				memcpy(&btFtpOneRecRxBuf[nRecRxPos],&btRxBuf[5],nRxLen-7);
				nTmp = (nRxLen-7);
				nRecRxPos += nTmp;
				
				szBuf[0] = 0;
				sprintf(szBuf2,"[%d,%3d,%c]",nKind,nRxLen,(char)btRxBuf[4]); strcat(szBuf,szBuf2);
				if(nTmp < 128)
				{
					for(i=0;i<nTmp;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
				}
				else
				{
					for(i=0;i<8;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
					strcat(szBuf,"..");
					for(i=120;i<128;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
				}
				strcat(szBuf,"\r\n");
				user_DebugPrint(szBuf);
			}
		}
		else
		// 중간 레코드 수신
		if(nKind >= 2 && nKind <= 5)
		{
			nRxLen = LonWorkRx(nKind,btRxBuf);
			if(nRxLen>6 && nRecRxPos<768)
			{
				memcpy(&btFtpOneRecRxBuf[nRecRxPos],&btRxBuf[5],nRxLen-7);
				nTmp = (nRxLen-7);
				nRecRxPos += nTmp;

				szBuf[0] = 0;
				sprintf(szBuf2,"[%d,%3d,%c]",nKind,nRxLen,(char)btRxBuf[4]); strcat(szBuf,szBuf2);
				if(nTmp < 128)
				{
					for(i=0;i<nTmp;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
				}
				else
				{
					for(i=0;i<8;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
					strcat(szBuf,"..");
					for(i=120;i<128;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
				}
				strcat(szBuf,"\r\n");
				user_DebugPrint(szBuf);
			}
		}
		else
		// 끝
		if(nKind == 6)
		{
			nRxLen = LonWorkRx(nKind,btRxBuf);
			if(nRxLen>6 && nRecRxPos<768)
			{
				memcpy(&btFtpOneRecRxBuf[nRecRxPos],&btRxBuf[5],nRxLen-7);
				nTmp = (nRxLen-7);
				nRecRxPos += nTmp;

				szBuf[0] = 0;
				sprintf(szBuf2,"[%d,%3d,%c]",nKind,nRxLen,(char)btRxBuf[4]); strcat(szBuf,szBuf2);
				if(nTmp < 128)
				{
					for(i=0;i<nTmp;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
				}
				else
				{
					for(i=0;i<8;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
					strcat(szBuf,"..");
					for(i=120;i<128;i++) {sprintf(szBuf2,"%02X",btRxBuf[i+5]); strcat(szBuf,szBuf2);}
				}
				strcat(szBuf,"\r\n");
				user_DebugPrint(szBuf);
			}
		}

		// 길이가 0~127까지 온다면 데이터를 저장한다.
		if((nRxLen>6 && nRxLen<134))
		{
			if(NVSRAM_WAYSIDEONBUF_SIZE > m_Variable.m_nNvsramPos)
			{
				user_DebugPrint("***FTP File receive... ^^;;***\r\n");
				memcpy(&pNvsram[m_Variable.m_nNvsramPos],btFtpOneRecRxBuf,nRecRxPos);
				m_Variable.m_nNvsramPos += nRecRxPos;
			}
			else
			{
				MyPrintf("***FTP data buffer full..\r\n");
			}
				
			m_Variable.m_bLnWkFtpEndFlag = TRUE;
		}
		else
		if(nKind == 6)
		{
			if(NVSRAM_WAYSIDEONBUF_SIZE > m_Variable.m_nNvsramPos)
			{
				user_DebugPrint("***FTP File receive End ^..^ ***\r\n");
				memcpy(&pNvsram[m_Variable.m_nNvsramPos],btFtpOneRecRxBuf,nRecRxPos);
				m_Variable.m_nNvsramPos += nRecRxPos;
			}
			else
			{
				MyPrintf("***FTP data buffer full..\r\n");
			}
		}
							
		nOldKind = nKind;
		
		break;
			
	// 일반 프로토콜(수신)
	case 7:
		nRxLen = LonWorkRx(7,btRxBuf);

		if(m_Variable.m_nDbgTxPos == 0xFFFFFFFF)
		{
			/*
			szBuf[0] = 0;
			sprintf(szBuf2,"[RX:%02d] ",nRxLen); strcat(szBuf,szBuf2);
			for(i=0;i<nRxLen;i++) {sprintf(szBuf2,"%02X ",btRxBuf[i]); strcat(szBuf,szBuf2);}
			strcat(szBuf,"\r\n");
			user_DebugPrint(szBuf);
			*/

		}
		
		if(nRxLen)
		{
			nTxPos = 0;

			switch(btRxBuf[1])
			{
			// WAYSIDE ON ACK 응답
			case 0x02: 

				m_Variable.m_nLnWkWaySideOnRxOk = 1;

				//MyPrintf("WAYSIDE ON Flage On. \r\n");

				break;
				
			// FTP전송 끝
			case 0x06: 
				if(m_Variable.m_nLnWkWaySideOnRxOk)
				{
					m_Variable.m_nLnWkWaySideOnRxOk--; 
					m_Variable.m_bLnWkFtpEndFlag = TRUE; 

					//MyPrintf("FTP Sending END. \r\n");
				}
				break;
				
			// 시간요청, MPU가 DPRAM에 데이터를 쓰고 전송 인터럽트를 전송하지않으면 LIC_LON에서 전송하지 않음
			case 0x08:
				nTxPos = 0;

				if(m_Variable.m_LIC_CNCS_TimSetFlag && m_Variable.m_nCncsRxCheck1msTimer)
				{

					btTxBuf[nTxPos++] = STX; // STX
					btTxBuf[nTxPos++] = 0x09; // Command Code
					btTxBuf[nTxPos++] = 0x00; // 0x00으로 설정
					btTxBuf[nTxPos++] = 0x06; // 길이
					
					// Y.J 수정
					btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.year;							// 년 BCD
					btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.month;							// 월
					btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.day;								// 일
					btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.hour;							// 시
					btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.minute; 							// 분
					btTxBuf[nTxPos++] = m_Variable.m_tmUtcTime.second; 							// 초
					
					btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
					btTxBuf[nTxPos++] = ETX; // ETX
					LonWorkTx(btTxBuf,nTxPos);

					nTxPos = 0;
					//MyPrintf("TIME Sending : ");

				}
				break;
				
			// 상태데이터 요청, MPU가 DPRAM에 데이터를 쓰고 전송 인터럽트를 전송하지않으면 LIC_LON에서 전송하지 않음
			case 0x0A:
				m_Variable.m_nCarCnt = btRxBuf[4];
				if(m_Variable.m_nCarCnt < 1 && m_Variable.m_nCarCnt > 2) m_Variable.m_nCarCnt = 1;
				nTxPos = 0;

				btTxBuf[nTxPos++] = STX; // STX
				btTxBuf[nTxPos++] = 0x0B; // Command Code
				btTxBuf[nTxPos++] = 0x00; // 0x00으로 설정
				btTxBuf[nTxPos++] = 0x05; // 길이
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[0]); // 상태 데이터
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[1]); // 상태 데이터
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[2]); // 상태 데이터
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[3]); // 상태 데이터
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[4]); // 상태 데이터
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[5]); // 상태 데이터
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[6]); // 상태 데이터
				btTxBuf[nTxPos++] = BitSwap(m_Variable.m_btSenseCommStBuf[7]); // 상태 데이터
				btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
				btTxBuf[nTxPos++] = ETX; // ETX
				LonWorkTx(btTxBuf,nTxPos);		
				
				memcpy(m_Variable.m_btSenseCommStBuf,m_Variable.m_btCommSt,8);

				memcpy(d_BufChack, m_Variable.m_btSenseCommStBuf, 8);

				nTxPos = 0;
				//MyPrintf("Unit State Data Sending : ");

				break;
				
			//버젼요청
			case 0x0C:
				nTxPos = 0;
				memset(btTxBuf,0x00,sizeof(btTxBuf));

				btTxBuf[nTxPos++] = STX; // STX
				btTxBuf[nTxPos++] = 0x0D; // Command Code

				// 2 : Firmware
				// 0 : Not used를 출력하고 버전과 날짜는 출력하지않는다.
				// 6 : 버전전송(LIC -> CDT) 중지

				nTmp = MAX(1,WORD_L(btRxBuf[4]));
				nTmp = MIN((VER_BDD_MAX_CNT)+1,WORD_L(btRxBuf[4]));
				nTmp--;

				btTxBuf[nTxPos++] = m_Variable.LIC_VerList[nTmp][0] == NULL ? 6 : 2; // 2:버젼&데이트, 6:중지
				
				btTxBuf[nTxPos++] = 31; // 데이터길이
				
				btTxBuf[nTxPos++] = btRxBuf[4]; // Index 번호
				btTxBuf[nTxPos++] = m_Variable.LIC_VerList[nTmp][0] == NULL ? 6 : 4; // Type

				memcpy(&btTxBuf[nTxPos],&m_Variable.LIC_VerList[nTmp][0],strlen((char*)&m_Variable.LIC_VerList[nTmp][0]));
				nTxPos = nTxPos+9;

				btTxBuf[nTxPos+0] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTmp)]>>12)&0x0F); // Production Version
				btTxBuf[nTxPos+1] = '.'; // Production Version
				btTxBuf[nTxPos+2] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTmp)]>>8)&0x0F); // Production Version
				btTxBuf[nTxPos+3] = '.'; // Production Version
				btTxBuf[nTxPos+4] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTmp)]>>4)&0x0F); // Production Version
				btTxBuf[nTxPos+5] = ConvHex2Asc((m_Variable.m_btExVersionTbl[WORD_L(nTmp)]&0x0F)); // Production Version
				btTxBuf[nTxPos+6] = '';
				nTxPos = nTxPos+9;

				btTxBuf[nTxPos+0] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)]>>28)&0xF);// '2': // Year
				btTxBuf[nTxPos+1] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)]>>24)&0xF);// '0': // Year
				btTxBuf[nTxPos+2] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)]>>20)&0xF);// '1': // Year
				btTxBuf[nTxPos+3] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)]>>16)&0xF);// '2': // Year
				btTxBuf[nTxPos+4] = '-';
				btTxBuf[nTxPos+5] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)]>>12)&0xF);// '0': // Month
				btTxBuf[nTxPos+6] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)]>>8)&0xF);// '1': // Month
				btTxBuf[nTxPos+7] = '-';
				btTxBuf[nTxPos+8] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)]>>4)&0xF);// '0': // Day
				btTxBuf[nTxPos+9] = ConvHex2Asc((m_Variable.m_btExVersion_DAYTbl[WORD_L(nTmp)])&0xF);// '1' : // Day
				btTxBuf[nTxPos+10] = '';
				nTxPos = nTxPos+11;

				btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
				btTxBuf[nTxPos++] = ETX; // ETX

				if(WORD_L(btRxBuf[4]) != 2)
				{
					LonWorkTx(btTxBuf,nTxPos);
				}

				MyPrintf("Unit Ver Sending : ");

				break;

			//도어상태(Single or married A)
			case 0x0E:
				m_Variable.m_btCttSignalA.BYTE = btRxBuf[4];

				m_Variable.m_bCiFaultFlag = (btRxBuf[4]&0x10) ? TRUE : FALSE; 

				d_MDSinputData = btRxBuf[4];
				d_CIShiftFlag = m_Variable.m_bCiFaultFlag;

				//MyPrintf("Ci_CutOff - All_Door_Close - Sp -  - Traction - Atcive_CAB = 0x[%02X] \r\n",btRxBuf[4]);

				break;
				
			// 열차구성 상태 요청
			case 0x10:
				nTxPos = 0;
				memset(btTxBuf,0x00,sizeof(btTxBuf));

				btTxBuf[nTxPos++] = STX; // STX
				btTxBuf[nTxPos++] = 0x11; // Command Code
				btTxBuf[nTxPos++] = 0x00; // Message Code
				btTxBuf[nTxPos++] = 0x02; // 길이
				btTxBuf[nTxPos++] = WORD_H(m_Variable.m_TrainCofVal); // 데이터
				btTxBuf[nTxPos++] = WORD_L(m_Variable.m_TrainCofVal); // 데이터
				btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
				btTxBuf[nTxPos++] = ETX; // ETX
				LonWorkTx(btTxBuf,nTxPos);

				nTxPos = 0;
				//MyPrintf("Door State[%X] : ",m_Variable.m_TrainCofVal);

				break;
				
			// CI 위치 요청
			case 0x12:
				nTxPos = 0;
				memset(btTxBuf,0x00,sizeof(btTxBuf));

				btTxBuf[nTxPos++] = STX; // STX
				btTxBuf[nTxPos++] = 0x13; // Command Code
				btTxBuf[nTxPos++] = 0x00; // Message Code
				btTxBuf[nTxPos++] = 0x01; // 길이
				if(m_Variable.m_nCarPos >= 1 && m_Variable.m_nCarPos <= 8)
				{
					btTxBuf[nTxPos++] = 0x00; // 데이터
					btTxBuf[nTxPos++] = MASKBIT(1,m_Variable.m_nCarPos-1); // 데이터
				}
				else
				{
					btTxBuf[nTxPos++] = 0x80; // 데이터
					btTxBuf[nTxPos++] = 0x00; // 데이터
				}
				btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
				btTxBuf[nTxPos++] = ETX; // ETX
				LonWorkTx(btTxBuf,nTxPos);

				nTxPos = 0;
				//MyPrintf("C/I Position[%X] : ",MASKBIT(1,m_Variable.m_nCarPos-1));

				break;
			
			// 차량번호 요청
			case 0x14:
				nTxPos = 0;
				memset(btTxBuf,0x00,sizeof(btTxBuf));

				btTxBuf[nTxPos++] = STX; // STX
				btTxBuf[nTxPos++] = 0x15; // Command Code
				btTxBuf[nTxPos++] = 0x00; // Message Code
				btTxBuf[nTxPos++] = 0x02; // 길이
				btTxBuf[nTxPos++] = WORD_H(BCD_BIN(m_Variable.m_nCarNo));
				btTxBuf[nTxPos++] = WORD_L(BCD_BIN(m_Variable.m_nCarNo));
				btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
				btTxBuf[nTxPos++] = ETX; // ETX
				LonWorkTx(btTxBuf,nTxPos);

				nTxPos = 0;
				//MyPrintf("Train NUM Sending[%X] : ",m_Variable.m_nCarNo);

				break;

			// CI고장난 차량 위치 요청
			case 0x16:
				nTxPos = 0;
				memset(btTxBuf,0x00,sizeof(btTxBuf));

				btTxBuf[nTxPos++] = STX; // STX
				btTxBuf[nTxPos++] = 0x17; // Command Code
				btTxBuf[nTxPos++] = 0x00; // Message Code
				btTxBuf[nTxPos++] = 0x02; // 길이
				//if(m_Variable.m_btCiFaultVal != 0x8000 && m_Variable.m_btTestOtherCiFault != 0x8000) //
				if(m_Variable.m_btCiFaultVal != 0x8000 ) //
				{
					btTxBuf[nTxPos++] = 0x00;
					switch(m_Variable.m_TrainCofVal)
					{
						/*
					// 2량
					case 0: btTxBuf[nTxPos++] = 0xFC | m_Variable.m_btCiFaultVal | m_Variable.m_btTestOtherCiFault; break; // 데이터
					// 4량
					case 1: btTxBuf[nTxPos++] = 0xF0 | m_Variable.m_btCiFaultVal | m_Variable.m_btTestOtherCiFault; break; // 데이터
					// 6량
					case 2: btTxBuf[nTxPos++] = 0xC0 | m_Variable.m_btCiFaultVal | m_Variable.m_btTestOtherCiFault; break; // 데이터
					// 8량
					case 3: btTxBuf[nTxPos++] = 0x00 | m_Variable.m_btCiFaultVal | m_Variable.m_btTestOtherCiFault; break; // 데이터
					default:
							btTxBuf[nTxPos++] = 0x00 | m_Variable.m_btCiFaultVal | m_Variable.m_btTestOtherCiFault; break; // 데이터
						*/
						// 2량
					case 0: btTxBuf[nTxPos++] = 0xFC | m_Variable.m_btCiFaultVal ; break; // 데이터
						// 4량
					case 1: btTxBuf[nTxPos++] = 0xF0 | m_Variable.m_btCiFaultVal ; break; // 데이터
						// 6량
					case 2: btTxBuf[nTxPos++] = 0xC0 | m_Variable.m_btCiFaultVal ; break; // 데이터
						// 8량
					case 3: btTxBuf[nTxPos++] = 0x00 | m_Variable.m_btCiFaultVal ; break; // 데이터
					default:
						btTxBuf[nTxPos++] = 0x00 | m_Variable.m_btCiFaultVal ; break; // 데이터
					}
					//btTxBuf[nTxPos++] = m_btCiFaultVal | m_btTestOtherCiFault;
				}
				else
				{
					btTxBuf[nTxPos++] = 0x80;
					btTxBuf[nTxPos++] = 0x00;
				}
				btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
				btTxBuf[nTxPos++] = ETX; // ETX
				LonWorkTx(btTxBuf,nTxPos);

				nTxPos = 0;
				//MyPrintf("Other C/I Fault Condition[%X] : ",m_Variable.m_btCiFaultVal);

				break;
			}

			
			if(nTxPos)
			{
				if(m_Variable.m_nDbgTxPos == 0xFFFFFFFF)
				{
					szBuf[0] = 0;
					sprintf(szBuf2,"[TX:%02d] ",nTxPos); strcat(szBuf,szBuf2);
					for(i=0;i<nTxPos;i++) {sprintf(szBuf2,"%02X ",WORD_L(btTxBuf[i])); strcat(szBuf,szBuf2);}
					strcat(szBuf,"\r\n");
					user_DebugPrint(szBuf);
				}			
			}
			
		}
		break;
	}
}
//******************************************************************************************
//	LonWorkRx
//******************************************************************************************
UCHAR LonWorkRx(int nRxPos, UCHAR *pRxBuf)
{
	int i;
	UCHAR nRxLen;
	UCHAR *pBuf;
	PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;

	if(nRxPos >= 1 && nRxPos <= 6)
	{
		nRxLen = MIN(sizeof(LNWKFTPIT)-1,WORD_L(pLnWkDp->lfBuf[nRxPos-1].btLen)+6);
		if(nRxLen > 6)
		{
			pBuf = &pLnWkDp->lfBuf[nRxPos-1].btStx;
			for(i=0;i<nRxLen;i++) pRxBuf[i] = WORD_L(pBuf[i]);

			//MyPrintf("[Len:%d,Pos:%d->",nRxLen,nRxPos);
			//for(i=0;i<nRxLen;i++) MyPrintf("%02X ",pRxBuf[i]);
			//MyPrintf("]\r\n");

			if(pRxBuf[0] == STX && pRxBuf[nRxLen-1] == ETX)
			{
				return nRxLen;
			}
			else
			{
				return 0;
			}
		}
		else
		{
			return 0;
		}
	}
	else
		if(nRxPos == 7)
		{
			nRxLen = MIN(sizeof(LNWKGERIT),WORD_L(pLnWkDp->lgRxBuf.btLen)+6);
			if(nRxLen > 5)
			{
				pBuf = &pLnWkDp->lfBuf[nRxPos-1].btStx;
				for(i=0;i<nRxLen;i++) pRxBuf[i] = WORD_L(pBuf[i]);

				//MyPrintf("[Len:%d,Pos:%d->",nRxLen,nRxPos);
				//for(i=0;i<nRxLen;i++) MyPrintf("%02X ",pRxBuf[i]);
				//MyPrintf("]\r\n");

				if(pRxBuf[0] == STX && pRxBuf[nRxLen-1] == ETX && !Make1ByteBcc(&pRxBuf[1],nRxLen-2))
				{
					return nRxLen;
				}
				else
				{
					return 0;
				}
			}
			else
			{
				return 0;
			}
		}
		else
		{
			return 0;
		}

		return 0;
}
//******************************************************************************************
//	LonWorkTx
//******************************************************************************************
void LonWorkTx(UCHAR *pTxBuf,UCHAR nLen)
{
	int i;
	char szBuf[512];
	char szBuf2[64];

	UCHAR *pBuf;
	PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;

	pBuf = &pLnWkDp->lgTxBuf.btStx;

	memcpy(pBuf,pTxBuf,(int)nLen);
	LNWK_TXINTREQ();
}

//******************************************************************************************
//	1ms Loop
//******************************************************************************************
void LonInfo_1msLoop()
{
	int i;
	int nTxPos = 0;
	UCHAR btTxBuf[32];
	static UINT nDelayCnt = 0;

	if(m_Variable.m_nCarKindToLonCnt < 6 && !(nDelayCnt%2000))
	{
		m_Variable.m_nCarKindToLonCnt++;

		MyPrintf("Train NUM Sending[%X] : ",m_Variable.m_nCarNo);

		nTxPos = 0;
		btTxBuf[nTxPos++] = STX; // STX
		btTxBuf[nTxPos++] = 0xF0; // Command Code
		btTxBuf[nTxPos++] = 0x00; // Message Code
		btTxBuf[nTxPos++] = 0x02; // 길이
		btTxBuf[nTxPos++] = WORD_H(m_Variable.m_nCarNo); // 차량번호 전달
		btTxBuf[nTxPos++] = WORD_L(m_Variable.m_nCarNo); // 차량번호 전달
		btTxBuf[nTxPos++] = Make1ByteBcc(&btTxBuf[1],nTxPos-1); // Check Sum
		btTxBuf[nTxPos++] = ETX; // ETX
		LonWorkTx(btTxBuf,nTxPos);

		MyPrintf("[TX:%02d] ",nTxPos);
		for(i=0;i<nTxPos;i++) MyPrintf("%02X ",WORD_L(btTxBuf[i]));
		MyPrintf("\r\n");
	}

	nDelayCnt++;
}
