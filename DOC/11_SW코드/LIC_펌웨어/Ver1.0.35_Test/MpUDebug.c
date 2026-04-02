
#include "main.h"
#include "def.h"
#include "Variable.h"
#include "xr16l784.h"
#include "user.h"
#include "ds1647.h"
#include "MpuDebug.h"


extern VARIABLE_H m_Variable;
//******************************************************************************************
//	디버그 수신 루프
//******************************************************************************************
void DebugLoop()
{
	int i,j;
	int sIndex = 0;
	char szBuf1[256];
	char szBuf2[256];
	UCHAR btBuf[256];
	UCHAR sTemp[10];
	int nRxLen;
	static int nRxPos = 0;
	static UCHAR nOldUart1RxOneByteGapDelayTime = 0;
	static UCHAR btRxBuf[256];
	DATE_TIME_TYPE tmBuf;
	PLNWKDP pLnWkDp = (LNWKDP *)DPRAM_BASE;
	PLIC_DPRAM_Ver pLicVerDp = (LIC_DPRAM_Ver *)NVSRAM_VER; //버전 정보 처리를 위해 임의로 만들었다.
	PCOMMSTATUS_LIC pCommStatus_Lic;  //장치 Status 
	UCHAR HH,HL,LH,LL;
	
	// 수신
	nRxLen = user_DebugRx(btBuf,128);
	if(nRxLen)
	{
		if(!m_Variable.m_nUart1RxOneByteGapDelayTime) nRxPos = 0;
		nOldUart1RxOneByteGapDelayTime = m_Variable.m_nUart1RxOneByteGapDelayTime = 10;
		
		if(nRxPos + nRxLen < 250)
		{
			memcpy(&btRxBuf[nRxPos],btBuf,nRxLen);
			nRxPos += nRxLen;
		}
	}
	
	if(nOldUart1RxOneByteGapDelayTime && !m_Variable.m_nUart1RxOneByteGapDelayTime)
	{
		strncpy(szBuf1,(char *)btRxBuf,MIN(32,nRxPos));
		szBuf1[32] = NULL;
		//for(i=0;i<strlen(szBuf1);i++) if(!IS_ASCALPHABET(szBuf1[i]) && !IS_ASCSPEC(szBuf1[i])) {szBuf1[i] = NULL; break;}
			
		if(btRxBuf[0] == '\r' || btRxBuf[0] == '\n')
		{
			MyPrintf((char *)"->\r\n");
		}
		else
		if(!strncmp(szBuf1,"Time",4))
		{
			if(IS_ASCNUMBER(btRxBuf[5])  && IS_ASCNUMBER(btRxBuf[6]) && 
				IS_ASCNUMBER(btRxBuf[7]) && IS_ASCNUMBER(btRxBuf[8]) &&
				IS_ASCNUMBER(btRxBuf[9]) && IS_ASCNUMBER(btRxBuf[10])&&
				IS_ASCNUMBER(btRxBuf[11])&& IS_ASCNUMBER(btRxBuf[12])&&
				IS_ASCNUMBER(btRxBuf[13])&& IS_ASCNUMBER(btRxBuf[14])&&
				IS_ASCNUMBER(btRxBuf[15])&& IS_ASCNUMBER(btRxBuf[16]))
			{
				tmBuf.second = MAKE_BYTE(ConvAsc2Hex(btRxBuf[15]),ConvAsc2Hex(btRxBuf[16]));
				tmBuf.minute = MAKE_BYTE(ConvAsc2Hex(btRxBuf[13]),ConvAsc2Hex(btRxBuf[14]));
				tmBuf.hour   = MAKE_BYTE(ConvAsc2Hex(btRxBuf[11]),ConvAsc2Hex(btRxBuf[12]));
				tmBuf.day    = MAKE_BYTE(ConvAsc2Hex(btRxBuf[9]),ConvAsc2Hex(btRxBuf[10]));
				tmBuf.month  = MAKE_BYTE(ConvAsc2Hex(btRxBuf[7]),ConvAsc2Hex(btRxBuf[8]));
				tmBuf.year   = MAKE_BYTE(ConvAsc2Hex(btRxBuf[5]),ConvAsc2Hex(btRxBuf[6]));
				tmBuf.weekday = 0;

				m_Variable.m_tmCurTime.second = HEXA2BIN(tmBuf.second);
				m_Variable.m_tmCurTime.minute = HEXA2BIN(tmBuf.minute);
				m_Variable.m_tmCurTime.hour = HEXA2BIN(tmBuf.hour);
				m_Variable.m_tmCurTime.day = HEXA2BIN(tmBuf.day);
				m_Variable.m_tmCurTime.month = HEXA2BIN(tmBuf.month);
				m_Variable.m_tmCurTime.year = HEXA2BIN(tmBuf.year);

				memset(&m_Variable.m_tmUtcTime, 0x00, sizeof(DATE_TIME_TYPE));
				
				if(m_Variable.m_LIC_CNCS_TimSetFlag = GetLocalTimeToUTC(&m_Variable.m_tmCurTime, -7, &m_Variable.m_tmUtcTime))
				{
					m_Variable.m_tmUtcTime.year	    = ConvDec2Hex(m_Variable.m_tmUtcTime.year	);
					m_Variable.m_tmUtcTime.month	= ConvDec2Hex(m_Variable.m_tmUtcTime.month );
					m_Variable.m_tmUtcTime.day		= ConvDec2Hex(m_Variable.m_tmUtcTime.day	);
					m_Variable.m_tmUtcTime.hour	    = ConvDec2Hex(m_Variable.m_tmUtcTime.hour	);
					m_Variable.m_tmUtcTime.minute	= ConvDec2Hex(m_Variable.m_tmUtcTime.minute);
					m_Variable.m_tmUtcTime.second	= ConvDec2Hex(m_Variable.m_tmUtcTime.second);
				
					m_Variable.m_nCncsRxCheck1msTimer = 100000;
				}
				
				m_Variable.m_tmUtcTime.year	    = ConvDec2Hex(m_Variable.m_tmUtcTime.year	);
				m_Variable.m_tmUtcTime.month	= ConvDec2Hex(m_Variable.m_tmUtcTime.month );
				m_Variable.m_tmUtcTime.day		= ConvDec2Hex(m_Variable.m_tmUtcTime.day	);
				m_Variable.m_tmUtcTime.hour	    = ConvDec2Hex(m_Variable.m_tmUtcTime.hour	);
				m_Variable.m_tmUtcTime.minute	= ConvDec2Hex(m_Variable.m_tmUtcTime.minute);
				m_Variable.m_tmUtcTime.second	= ConvDec2Hex(m_Variable.m_tmUtcTime.second);				

				sprintf(btBuf,"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%02X[minute],%02X[second] \r\n",
					BIN2HEXA(m_Variable.m_tmUtcTime.year),
					BIN2HEXA(m_Variable.m_tmUtcTime.month),
					BIN2HEXA(m_Variable.m_tmUtcTime.day),
					BIN2HEXA(m_Variable.m_tmUtcTime.hour),
					BIN2HEXA(m_Variable.m_tmUtcTime.minute),
					BIN2HEXA(m_Variable.m_tmUtcTime.second));

				user_DebugPrint((char *)btBuf);
			}		
			else
			{
				user_DebugPrint("Not Date&time format \r\n");
			}
		}
		else
		if(!strncmp(szBuf1,"t",1))
		{
			sprintf(btBuf,"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%02X[minute],%02X[second] \r\n",
				BIN2HEXA(m_Variable.m_tmUtcTime.year),
				BIN2HEXA(m_Variable.m_tmUtcTime.month),
				BIN2HEXA(m_Variable.m_tmUtcTime.day),
				BIN2HEXA(m_Variable.m_tmUtcTime.hour),
				BIN2HEXA(m_Variable.m_tmUtcTime.minute),
				BIN2HEXA(m_Variable.m_tmUtcTime.second));
			user_DebugPrint((char *)btBuf);
		}
		else
		if(!strncmp(szBuf1,"Version",7))
		{
			i = GetFirmwareVersion(1);
			
			memcpy(sTemp,&pLnWkDp->btVerH,2);
			j = MAKE_WORD(sTemp[0],sTemp[1]);
			
			sprintf(btBuf,"LIC-MPU Version:%d.%d%d%d,Build Date:20%06d, LIC-LON Version:%d.%d%d%d,Build Date:%08X\r\n",
				i/1000%10,
				i/100%10,
				i/10%10,
				i%10,
				GetFirmwareVersion(2),
				BYTE_H(WORD_H(j)),
				BYTE_L(WORD_H(j)),
				BYTE_H(WORD_L(j)),
				BYTE_L(WORD_L(j)),
				MAKE_DWORD(pLnWkDp->btBuildDateHH,pLnWkDp->btBuildDateHL,pLnWkDp->btBuildDateLH,pLnWkDp->btBuildDateLL));

			user_DebugPrint((char *)btBuf);

			memset(btBuf,0x00,256);

			//2011_03_03 수정 
			for(i=0;i<VER_BDD_MAX_CNT;i++) //CNCS로 부터 받은 버전 정보 표출 하는 부분 추가 
			{
				if(WORD_L(m_Variable.LIC_VerList[i][0]) == NULL) break;
				memset(btBuf,0x00,256);
				strncpy((char *)btBuf,(char *)&m_Variable.LIC_VerList[i][0],strlen((char*)&m_Variable.LIC_VerList[i][0]));
				sprintf(&btBuf[strlen((char*)&btBuf)],":");
				strncpy((char *)&btBuf[strlen((char*)&btBuf)],(char *)&pLicVerDp->cvbBuf[i].chVer[0],4);
				sprintf(&btBuf[strlen((char*)&btBuf)],":");
				strncpy((char *)&btBuf[strlen((char*)&btBuf)],(char *)&pLicVerDp->cvbBuf[i].chBuildDate[0],6);
				sprintf(&btBuf[strlen((char*)&btBuf)],"\r\n");
				
				
				user_DebugPrint((char *)btBuf);
			}
			
			MyPrintf("\r\n\r\n");
		}
		else
		if(!strncmp(szBuf1,"Recent",6)) //고장 기록을 시작 한다. 
		{
			m_Variable.m_nLnWkTxFlag = 1;
			user_DebugPrint("Recent fault read start send \r\n");
		}
		else
		if(!strncmp(szBuf1,"Historical",10))
		{
			m_Variable.m_nLnWkTxFlag = 2; 
			gm_SysTimeToRtc(&tmBuf,m_Variable.m_nDateTime2SecondCnt);
			sprintf(btBuf,"Historical read start send, Historical start time : %08XH, Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%02X[minute],%02X[second] \r\n",
				m_Variable.m_nDateTime2SecondCnt,
				tmBuf.year,
				tmBuf.month,
				tmBuf.day,
				tmBuf.hour,
				tmBuf.minute,
				tmBuf.second);
			user_DebugPrint((char *)btBuf);
		}
		else
		if(!strncmp(szBuf1,"Rxinfo",6))
		{
			if(!m_Variable.m_nNvsramPos)
			{
				sprintf(btBuf,"Total byte : %d, Packet count : %d, window count : %d, remaind packet : %d, m_nLnWkWaySideOnRxOk : %d, m_bLnWkFtpEndFlag : %d, Historical start time : %08XH \r\n",
					0,0,0,0,
					m_Variable.m_nLnWkWaySideOnRxOk,
					m_Variable.m_bLnWkFtpEndFlag,
					m_Variable.m_nDateTime2SecondCnt);
			}
			else
			{
				sprintf(btBuf,"Total byte : %d, Packet count : %d, window count : %d, remaind packet : %d, m_nLnWkWaySideOnRxOk : %d, m_bLnWkFtpEndFlag : %d, Historical start time : %08XH \r\n",
					m_Variable.m_nNvsramPos,
					((m_Variable.m_nNvsramPos-1)/128)+1,
					((m_Variable.m_nNvsramPos-1)/128/6)+1,
					m_Variable.m_nNvsramPos%128,
					m_Variable.m_nLnWkWaySideOnRxOk,
					m_Variable.m_bLnWkFtpEndFlag,
					m_Variable.m_nDateTime2SecondCnt);
			}
			user_DebugPrint((char *)btBuf);
		}
		else
		if(!strncmp(szBuf1,"LnWayClr",8))
		{
			m_Variable.m_nLnWkWaySideOnRxOk = 0;
			user_DebugPrint("'m_nLnWkWaySideOnRxOk' Clear OK \r\n");
		}
		else
		if(!strncmp(szBuf1,"LnFtpClr",8))
		{
			m_Variable.m_bLnWkFtpEndFlag = FALSE;
			user_DebugPrint("'m_bLnWkFtpEndFlag' Clear OK \r\n");
		}
		else
		if(!strncmp(szBuf1,"HisStTm",7))
		{
			if(IS_ASCHEX(btRxBuf[8]) && IS_ASCHEX(btRxBuf[9]) && 
				IS_ASCHEX(btRxBuf[10]) && IS_ASCHEX(btRxBuf[11]) &&
				IS_ASCHEX(btRxBuf[12]) && IS_ASCHEX(btRxBuf[13]) &&
				IS_ASCHEX(btRxBuf[14]) && IS_ASCHEX(btRxBuf[15]))
			{
				m_Variable.m_nDateTime2SecondCnt = MAKE_DWORD(
					MAKE_BYTE(ConvAsc2Hex(btRxBuf[8]),ConvAsc2Hex(btRxBuf[9])),
					MAKE_BYTE(ConvAsc2Hex(btRxBuf[10]),ConvAsc2Hex(btRxBuf[11])),
					MAKE_BYTE(ConvAsc2Hex(btRxBuf[12]),ConvAsc2Hex(btRxBuf[13])),
					MAKE_BYTE(ConvAsc2Hex(btRxBuf[14]),ConvAsc2Hex(btRxBuf[15])));

				
				gm_SysTimeToRtc(&tmBuf,m_Variable.m_nDateTime2SecondCnt);
				sprintf(btBuf,"Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%02X[minute],%02X[second], Setting OK \r\n",
					tmBuf.year,
					tmBuf.month,
					tmBuf.day,
					tmBuf.hour,
					tmBuf.minute,
					tmBuf.second
					);
				user_DebugPrint((char *)btBuf);
			}		
			else
			{
				user_DebugPrint("No format \r\n");
			}
		}
		else
		if(!strncmp(szBuf1,"CarNoSet",8))
		{
			if(IS_ASCNUMBER(btRxBuf[9]) && IS_ASCNUMBER(btRxBuf[10]) && IS_ASCNUMBER(btRxBuf[11]) && IS_ASCNUMBER(btRxBuf[12]))
			{
				m_Variable.m_nCarNo = ConvAsc2Dec(btRxBuf[9])*1000 + ConvAsc2Dec(btRxBuf[10])*100 + ConvAsc2Dec(btRxBuf[11])*10 + ConvAsc2Dec(btRxBuf[12]);
				m_Variable.m_chCarKind = m_Variable.m_nCarNo&0x01 ? 'A' : 'B';
				MyPrintf("Car Number = %d,%c Car \r\n",m_Variable.m_nCarNo,m_Variable.m_chCarKind);
			}
			else
			{
				MyPrintf("Invalid syntax\r\n");
			}	
			
			user_CarNoForCarKindToLon();	
		}
		else
		if(!strncmp(szBuf1,"WaySideON",9))
		{
			m_Variable.m_nCDT_FaultDataStFlag = 1;
			m_Variable.m_Recving_Posi = 0;
			
			gm_SysTimeToRtc(&tmBuf,m_Variable.m_nDateTime2SecondCnt);
			sprintf(btBuf,"m_nCDT_FaultDataStFlag  = %d,%s, Date&Time : 20%02X[year],%02X[month],%02X[day],%02X[hour],%02X[minute],%02X[second]\r\n",m_Variable.m_nCDT_FaultDataStFlag,m_Variable.m_nLnWkTxFlag == 2 ? "Historical" : "Recently",
					tmBuf.year,
					tmBuf.month,
					tmBuf.day,
					tmBuf.hour,
					tmBuf.minute,
					tmBuf.second
				);
			user_DebugPrint((char *)btBuf);
		}
		else
		if(!strncmp(szBuf1,"CommStSet",9))
		{
			if( IS_ASCHEX(btRxBuf[10]) &&IS_ASCHEX(btRxBuf[11]) && 
				IS_ASCHEX(btRxBuf[12]) &&IS_ASCHEX(btRxBuf[13]) &&
				IS_ASCHEX(btRxBuf[14]) &&IS_ASCHEX(btRxBuf[15]) && 
				IS_ASCHEX(btRxBuf[16]) &&IS_ASCHEX(btRxBuf[17]))
			{

				FunConvAscHex((char *)&btRxBuf[10],sTemp,8);

				memset(m_Variable.m_btCommSt,0x00,sizeof(m_Variable.m_btCommSt));
				pCommStatus_Lic = (COMMSTATUS_LIC *)m_Variable.m_btCommSt;

				pCommStatus_Lic->BYTE_1.BYTE = sTemp[0];
				pCommStatus_Lic->BYTE_2.BYTE = sTemp[1];
				pCommStatus_Lic->BYTE_3.BYTE = sTemp[2];
				pCommStatus_Lic->BYTE_4.BYTE = sTemp[3];

				MyPrintf("CommStSet =  %02X-%02X-%02X-%02X \r\n",
				m_Variable.m_btCommSt[0],
				m_Variable.m_btCommSt[1],
				m_Variable.m_btCommSt[2],
				m_Variable.m_btCommSt[3]);
				
				for(i=0;i<8;i++)
				{
					if(!(m_Variable.m_btOldCommSt[i]&0x01) && (m_Variable.m_btCommSt[i]&0x01)) m_Variable.m_btSenseCommStBuf[i] |= 0x01;
					if(!(m_Variable.m_btOldCommSt[i]&0x02) && (m_Variable.m_btCommSt[i]&0x02)) m_Variable.m_btSenseCommStBuf[i] |= 0x02;
					if(!(m_Variable.m_btOldCommSt[i]&0x04) && (m_Variable.m_btCommSt[i]&0x04)) m_Variable.m_btSenseCommStBuf[i] |= 0x04;
					if(!(m_Variable.m_btOldCommSt[i]&0x08) && (m_Variable.m_btCommSt[i]&0x08)) m_Variable.m_btSenseCommStBuf[i] |= 0x08;
					if(!(m_Variable.m_btOldCommSt[i]&0x10) && (m_Variable.m_btCommSt[i]&0x10)) m_Variable.m_btSenseCommStBuf[i] |= 0x10;
					if(!(m_Variable.m_btOldCommSt[i]&0x20) && (m_Variable.m_btCommSt[i]&0x20)) m_Variable.m_btSenseCommStBuf[i] |= 0x20;
					if(!(m_Variable.m_btOldCommSt[i]&0x40) && (m_Variable.m_btCommSt[i]&0x40)) m_Variable.m_btSenseCommStBuf[i] |= 0x40;
					if(!(m_Variable.m_btOldCommSt[i]&0x80) && (m_Variable.m_btCommSt[i]&0x80)) m_Variable.m_btSenseCommStBuf[i] |= 0x80;
				}
				
				memcpy(m_Variable.m_btOldCommSt,m_Variable.m_btCommSt,8);
			}
			else
			{
				MyPrintf("Invalid syntax\r\n");
			}
		}
		else
		if(!strncmp(szBuf1,"TrainConf",9))
		{
			if(IS_ASCNUMBER(btRxBuf[10]))
			{
				m_Variable.m_TrainCofVal = MIN(3,ConvAsc2Hex(btRxBuf[10]));
				MyPrintf("TrainConf value = %02X \r\n",m_Variable.m_TrainCofVal);
			}
			else
			{
				MyPrintf("Invalid syntax\r\n");
			}
		}
		else
		if(!strncmp(szBuf1,"CarPosSet",9))
		{
			if(IS_ASCNUMBER(btRxBuf[10]))
			{
				if(ConvAsc2Dec(btRxBuf[10]) >= 1 && ConvAsc2Dec(btRxBuf[10]) <= 8)
				{
					m_Variable.m_nCarPos = ConvAsc2Dec(btRxBuf[10]);
					MyPrintf("CarPosVal = %02X \r\n",m_Variable.m_nCarPos);
				}
				else
				{
					MyPrintf("Invalid syntax [%d]\r\n",ConvAsc2Dec(btRxBuf[10]));
				}
			}
			else
			{
				MyPrintf("Invalid syntax\r\n");
			}
		}
		else
		if(!strncmp(szBuf1,"CiFaultSet",10))
		{
			if( IS_ASCNUMBER(btRxBuf[11]) && IS_ASCNUMBER(btRxBuf[12]))
			{
				m_Variable.m_btCiFaultVal = MAKE_WORD(ConvAsc2Hex(btRxBuf[11]),ConvAsc2Hex(btRxBuf[12]));
				MyPrintf("CiFault Val = %02X \r\n",m_Variable.m_btCiFaultVal);
			}
			else
			{
				MyPrintf("Invalid syntax\r\n");
			}
		}
		else
		if(!strncmp(szBuf1,"VerSet",6))
		{

			if( IS_ASCNUMBER(btRxBuf[7]) && IS_ASCNUMBER(btRxBuf[8]) && 

				IS_ASCNUMBER(btRxBuf[10]) && IS_ASCNUMBER(btRxBuf[11]) &&
				IS_ASCNUMBER(btRxBuf[12]) && IS_ASCNUMBER(btRxBuf[13]) &&

				IS_ASCNUMBER(btRxBuf[15]) && IS_ASCNUMBER(btRxBuf[16]) &&
				IS_ASCNUMBER(btRxBuf[17]) && IS_ASCNUMBER(btRxBuf[18]) && 
				IS_ASCNUMBER(btRxBuf[19]) && IS_ASCNUMBER(btRxBuf[20])
				)
			{
				sIndex = ConvAsc2Dec(btRxBuf[7])*10 + ConvAsc2Dec(btRxBuf[8]);
				sIndex = MIN(VER_BDD_MAX_CNT,sIndex);

				pLicVerDp->cvbBuf[sIndex].chVer[0] = btRxBuf[10];
				pLicVerDp->cvbBuf[sIndex].chVer[1] = btRxBuf[11];
				pLicVerDp->cvbBuf[sIndex].chVer[2] = btRxBuf[12];
				pLicVerDp->cvbBuf[sIndex].chVer[3] = btRxBuf[13];

				pLicVerDp->cvbBuf[sIndex].chBuildDate[0]=btRxBuf[15];
				pLicVerDp->cvbBuf[sIndex].chBuildDate[1]=btRxBuf[16];
				pLicVerDp->cvbBuf[sIndex].chBuildDate[2]=btRxBuf[17];
				pLicVerDp->cvbBuf[sIndex].chBuildDate[3]=btRxBuf[18];
				pLicVerDp->cvbBuf[sIndex].chBuildDate[4]=btRxBuf[19];
				pLicVerDp->cvbBuf[sIndex].chBuildDate[5]=btRxBuf[20];

				LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[0])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[1])));
				LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[2])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chVer[3])));
				m_Variable.m_btExVersionTbl[sIndex] = MAKE_WORD(LH,LL);
				HH = 0x20;
				HL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[0])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[1])));
				LH = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[2])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[3])));
				LL = MAKE_BYTE(ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[4])),ConvAsc2Hex(WORD_L(pLicVerDp->cvbBuf[sIndex].chBuildDate[5])));
				m_Variable.m_btExVersion_DAYTbl[sIndex] = MAKE_DWORD(HH,HL,LH,LL);
				
				memset(btBuf,0x00,256);
				memcpy(btBuf,&m_Variable.LIC_VerList[sIndex][0],strlen((char*)&m_Variable.LIC_VerList[sIndex][0]));
				sprintf(&btBuf[strlen((char*)&btBuf)],":");
				memcpy(&btBuf[strlen((char*)&btBuf)],&pLicVerDp->cvbBuf[sIndex].chVer[0],4);
				sprintf(&btBuf[strlen((char*)&btBuf)],":");
				memcpy(&btBuf[strlen((char*)&btBuf)],&pLicVerDp->cvbBuf[sIndex].chBuildDate[0],6);
				sprintf(&btBuf[strlen((char*)&btBuf)],"\r\n");
				
				user_DebugPrint((char *)btBuf);

			}
			else
			{
				user_DebugPrint("Syntax error\r\n");
			}

		}
		else		
		if(!strncmp(szBuf1,"?",1))
		{
			MyPrintf("[ENTER]      : Move next line after out '->' \r\n");
			MyPrintf("'?'          : Help \r\n");
			MyPrintf("'Time'       : Date&time setting , 'Time=YYMMDDHHMNSS', 'EX)Time=120102030405' \r\n");
			MyPrintf("'t'          : Date&time read \r\n");
			MyPrintf("'Version     : Version \r\n");
			MyPrintf("'Recent'     : Recently faults start \r\n");
			MyPrintf("'Historical' : Historical data start \r\n");
			MyPrintf("'Rxinfo'     : Recieve info \r\n");
			MyPrintf("'LnWayClr'   : 'm_nLnWkWaySideOnRxOk' variable clear \r\n");
			MyPrintf("'LnFtpClr'   : 'm_bLnWkFtpEndFlag' variable clear \r\n");
			MyPrintf("'HisStTm'    : Historical data start time set(2000/1/1 0:0:0 ~ total second), HisStTm=XXXXXXXX, 'EX)HisStTm=0000000F' \r\n");
			MyPrintf("'CarNoSet'   : Car number set. CarNoSet=XXXX, EX)CarNoSet=4001 -> [%d[0x%X],%c CAR]\r\n",m_Variable.m_nCarNo,m_Variable.m_nCarNo,m_Variable.m_chCarKind);
			MyPrintf("'TrainConf'  : Train Configuration. TrainConf=X(X : 0~3[2,4,6,8Car]) => [0x%X]\r\n",m_Variable.m_TrainCofVal);
			MyPrintf("'CarPosSet'  : Car index position. CarPosSet=X(X:1~8) 'EX)CarPosSet=1' => [0x%X]\r\n",m_Variable.m_nCarPos);
			MyPrintf("'CiFaultSet' : Other C/I Fault. CiFaultSet=XX 'EX)CiFaultSet=00' => [0x%02X]\r\n",m_Variable.m_btCiFaultVal);
			MyPrintf("'WaySideON'  : WaySide_ON \r\n");
			MyPrintf("'CommStSet'  : Comm Status. CommStSet=XXXXXXXX  'EX) CommStSet=FF7F1F53' => [0x%02X,0x%02X,0x%02X,0x%02X]\r\n",WORD_L(m_Variable.m_btCommSt[0]),WORD_L(m_Variable.m_btCommSt[1]),WORD_L(m_Variable.m_btCommSt[2]),WORD_L(m_Variable.m_btCommSt[3]));
			MyPrintf("'VerSet'     : Each unit version set. VerSet=XX(incdex):XXXX(Ver):XXXXXX(BuildDate) \r\n");
			MyPrintf("\r\n");
		}
		else
		{
			user_DebugPrint("Syntax error\r\n");
		}

		nOldUart1RxOneByteGapDelayTime = m_Variable.m_nUart1RxOneByteGapDelayTime;
	}
}


//******************************************************************************************
//	1ms Loop
//******************************************************************************************
void Debug_1msLoop()
{
		if(m_Variable.m_nUart1RxOneByteGapDelayTime) m_Variable.m_nUart1RxOneByteGapDelayTime--;

}
