// Packet.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "Packet.h"


// CPacket

CPacket::CPacket()
{
	m_bValidGPS		= false;
	m_bWLANConnect	= false;
	m_bWLANTrasnfer	= false;
	m_bTouchCalibration_Master	 = false;
	m_bTouchCalibration_Slave	 = false;

	m_byStateCCI	= 0x00;
}

CPacket::~CPacket()
{
}

bool CPacket::SetHeader( BYTE *byBuffer )
{
 	unsigned short CRC = 0, byCRC[4];
	UINT nCRCIndex = 0;
	m_bySourceID		= BYTE_MERGE( byBuffer[0], byBuffer[1] );
	m_byDestinationID	= BYTE_MERGE( byBuffer[2], byBuffer[3] );
	m_byMessageCount	= BYTE_MERGE( byBuffer[4], byBuffer[5] );
	m_byCommandCode		= BYTE_MERGE( byBuffer[6], byBuffer[7] );
	//m_unDataLength	= BYTE_MERGE( byBuffer[8], byBuffer[9] );	
	m_unDataLength		= HEX_FROM_BCD4( &byBuffer[8] );
	nCRCIndex = SIZE_HEADER + m_unDataLength * 2;

	if( nCRCIndex >= 8196 )
	{
		return false;
	}

	CRC = crc16( (char *)( byBuffer + 0 ), nCRCIndex );

	SHORT_SPLIT( byCRC[0], byCRC[1], byCRC[2], byCRC[3], CRC );

	if( byCRC[0] > 0x39 && byCRC[0] < 0x40 ) byCRC[0] += 7;
	if( byCRC[1] > 0x39 && byCRC[1] < 0x40 ) byCRC[1] += 7;
	if( byCRC[2] > 0x39 && byCRC[2] < 0x40 ) byCRC[2] += 7;
	if( byCRC[3] > 0x39 && byCRC[3] < 0x40 ) byCRC[3] += 7;

	if( byBuffer[nCRCIndex] == byCRC[0] && byBuffer[nCRCIndex+1] == byCRC[1] && 
		byBuffer[nCRCIndex+2] == byCRC[2] && byBuffer[nCRCIndex+3] == byCRC[3] ) 
	{
		return true;
	}
	
	//RETAILMSG(1, (_T("STX - SID : %X DID : %X\n"), m_bySourceID, m_byDestinationID ));
	//RETAILMSG(1, (_T("[SERIAL] INVALID CRC C \n") ));
	return false;
}	

//void CPacket::SetGIA( BYTE *byBuffer )
//{
//	bool bIsValidDate = false;
//
//	GIA.DATE[0]			= DEC_FROM_BCD2( byBuffer[0], byBuffer[1] );
//	GIA.DATE[1]			= DEC_FROM_BCD2( byBuffer[2], byBuffer[3] );
//	GIA.DATE[2]			= DEC_FROM_BCD2( byBuffer[4], byBuffer[5] );
//	GIA.DATE[3]			= DEC_FROM_BCD2( byBuffer[6], byBuffer[7] );
//	GIA.DATE[4]			= DEC_FROM_BCD2( byBuffer[8], byBuffer[9] );
//	GIA.DATE[5]			= DEC_FROM_BCD2( byBuffer[10], byBuffer[11] );
//
//	if(GIA.DATE[0] && GIA.DATE[1] && GIA.DATE[2]) 
//	{
//		SYSTEMTIME  stime;
//		// GetLocalTime(&stime);
//		
//		stime.wYear		= GIA.DATE[0] + 2000;  
//		stime.wMonth	= GIA.DATE[1];
//		stime.wDay		= GIA.DATE[2];
//		stime.wHour		= GIA.DATE[3];
//		stime.wMinute	= GIA.DATE[4];
//		stime.wSecond	= GIA.DATE[5];
//
//		//RETAILMSG(1, (_T("GPS : %d-%d-%d %d:%d:%d\n"), GIA.DATE[0], GIA.DATE[1], GIA.DATE[2], GIA.DATE[3], GIA.DATE[4], GIA.DATE[5]));
//	
//		//SetLocalTime(&stime);
//		//RETAILMSG(1, (_T("Set Local Time : %s\n"), CTime::GetCurrentTime().Format(_T("%Y-%m-%d %H:%M:%S"))));
//
//		COleDateTime odtGIA(stime);
//		odtGIA -= COleDateTimeSpan(0, -5, 0, 0);
//		
//		odtGIA.GetAsSystemTime(stime);
//		SetSystemTime(&stime);
//		
//		//RETAILMSG(1, (_T("Set System Time : %s\n\n"), COleDateTime::GetCurrentTime().Format(_T("%Y-%m-%d %H:%M:%S"))));
//	}
//
//	if( byBuffer[34] == '1' )
//	{
//		SetValidGPS(true);
//	}
//	else
//	{
//		SetValidGPS(false);
//	}
//
//	char	szLat[16] = {0, }, szLot[16] = {0, };
//	
//	sprintf( szLat, "%c%c%c%c.%c%c%c%c%c", byBuffer[13], byBuffer[14], byBuffer[15], byBuffer[16],
//										   byBuffer[17], byBuffer[18], byBuffer[19], byBuffer[20], byBuffer[21] );
//
//	sprintf( szLot, "%c%c%c%c%c.%c%c%c%c%c", byBuffer[24], byBuffer[25], byBuffer[26], byBuffer[27], byBuffer[28],
//											 byBuffer[29], byBuffer[30], byBuffer[31], byBuffer[32], byBuffer[33] );
//
//	GIA.LAT = atof( szLat );
//	GIA.LOT = atof( szLot );
//	
//}

void CPacket::SetPAC( BYTE *byBuffer )
{
	int nCarCount = 0;

	PAC.PAC_T	= BYTE_MERGE( byBuffer[0], byBuffer[1] );
	PAC.C_ID	= BYTE_MERGE( byBuffer[2], byBuffer[3] );
	PAC.D0		= BYTE_MERGE( byBuffer[4], byBuffer[5] );
	PAC.D1		= BYTE_MERGE( byBuffer[6], byBuffer[7] );
	PAC.D2		= BYTE_MERGE( byBuffer[8], byBuffer[9] );
	PAC.ODM		= DEC_FROM_BCD8( byBuffer[10], byBuffer[11], byBuffer[12], byBuffer[13], byBuffer[14], byBuffer[15], byBuffer[16], byBuffer[17] );
	PAC.ANS		= DEC_FROM_BCD2( byBuffer[18], byBuffer[19] );
	PAC.TRAN_NO	= DEC_FROM_BCD6( byBuffer[20], byBuffer[21], byBuffer[22], byBuffer[23], byBuffer[24], byBuffer[25] );
	PAC.CREW_ID	= DEC_FROM_BCD6( byBuffer[26], byBuffer[27], byBuffer[28], byBuffer[29], byBuffer[30], byBuffer[31] );
	memcpy( PAC.TRIP, (void *)(byBuffer + 32), sizeof(BYTE) * 6 );
	PAC.D3		= BYTE_MERGE( byBuffer[38], byBuffer[39] );
	PAC.STST	= DEC_FROM_BCD4( byBuffer[40], byBuffer[41], byBuffer[42], byBuffer[43] );
	PAC.NOST	= DEC_FROM_BCD4( byBuffer[44], byBuffer[45], byBuffer[46], byBuffer[47] );
	PAC.NEST	= DEC_FROM_BCD4( byBuffer[48], byBuffer[49], byBuffer[50], byBuffer[51] );
	PAC.DEST	= DEC_FROM_BCD4( byBuffer[52], byBuffer[53], byBuffer[54], byBuffer[55] );
	PAC.SPK[0]	= BYTE_MERGE( byBuffer[56], byBuffer[57] );
	PAC.SPK[1]	= BYTE_MERGE( byBuffer[58], byBuffer[59] );
	PAC.D4		= BYTE_MERGE( byBuffer[60], byBuffer[61] );
	PAC.D5		= BYTE_MERGE( byBuffer[62], byBuffer[63] );
	PAC.PR		= BYTE_MERGE( byBuffer[64], byBuffer[65] );
	
#define VCT_IDX	(66)
	PAC.PRVCT	= DEC_FROM_BCD4( byBuffer[VCT_IDX+ 0], byBuffer[VCT_IDX+ 1], byBuffer[VCT_IDX+ 2], byBuffer[VCT_IDX+ 3] );
	PAC.PACVCT	= DEC_FROM_BCD4( byBuffer[VCT_IDX+ 4], byBuffer[VCT_IDX+ 5], byBuffer[VCT_IDX+ 6], byBuffer[VCT_IDX+ 7] );
	PAC.CLRVCT	= DEC_FROM_BCD4( byBuffer[VCT_IDX+ 8], byBuffer[VCT_IDX+ 9], byBuffer[VCT_IDX+10], byBuffer[VCT_IDX+11] );
	PAC.FDIVCT1	= DEC_FROM_BCD4( byBuffer[VCT_IDX+12], byBuffer[VCT_IDX+13], byBuffer[VCT_IDX+14], byBuffer[VCT_IDX+15] );
	PAC.FDIVCT2	= DEC_FROM_BCD4( byBuffer[VCT_IDX+16], byBuffer[VCT_IDX+17], byBuffer[VCT_IDX+18], byBuffer[VCT_IDX+19] );
	PAC.PIIVCT	= DEC_FROM_BCD4( byBuffer[VCT_IDX+20], byBuffer[VCT_IDX+21], byBuffer[VCT_IDX+22], byBuffer[VCT_IDX+23] );
	PAC.PPLVCT	= DEC_FROM_BCD4( byBuffer[VCT_IDX+24], byBuffer[VCT_IDX+25], byBuffer[VCT_IDX+26], byBuffer[VCT_IDX+27] );
	PAC.PPVCT	= DEC_FROM_BCD4( byBuffer[VCT_IDX+28], byBuffer[VCT_IDX+29], byBuffer[VCT_IDX+30], byBuffer[VCT_IDX+31] );
	PAC.SPVCT	= DEC_FROM_BCD4( byBuffer[VCT_IDX+32], byBuffer[VCT_IDX+33], byBuffer[VCT_IDX+34], byBuffer[VCT_IDX+35] );

#define SKIP_IDX	(102)
	PAC.SKIP[0] = BYTE_MERGE( byBuffer[SKIP_IDX+ 0], byBuffer[SKIP_IDX+ 1] );
	PAC.SKIP[1] = BYTE_MERGE( byBuffer[SKIP_IDX+ 2], byBuffer[SKIP_IDX+ 3] );
	PAC.SKIP[2] = BYTE_MERGE( byBuffer[SKIP_IDX+ 4], byBuffer[SKIP_IDX+ 5] );
	PAC.SKIP[3] = BYTE_MERGE( byBuffer[SKIP_IDX+ 6], byBuffer[SKIP_IDX+ 7] );
	PAC.SKIP[4] = BYTE_MERGE( byBuffer[SKIP_IDX+ 8], byBuffer[SKIP_IDX+ 9] );
	PAC.SKIP[5] = BYTE_MERGE( byBuffer[SKIP_IDX+10], byBuffer[SKIP_IDX+11] );
	PAC.SKIP[6] = BYTE_MERGE( byBuffer[SKIP_IDX+12], byBuffer[SKIP_IDX+13] );
	PAC.SKIP[7] = BYTE_MERGE( byBuffer[SKIP_IDX+14], byBuffer[SKIP_IDX+15] );
	PAC.SKIP[8] = BYTE_MERGE( byBuffer[SKIP_IDX+16], byBuffer[SKIP_IDX+17] );
	PAC.SKIP[9] = BYTE_MERGE( byBuffer[SKIP_IDX+18], byBuffer[SKIP_IDX+19] );

#define CI_IDX	(122)
	PAC.CI[0]	= BYTE_MERGE( byBuffer[CI_IDX+ 0], byBuffer[CI_IDX+ 1] );
	PAC.CI[1]	= BYTE_MERGE( byBuffer[CI_IDX+ 2], byBuffer[CI_IDX+ 3] );
	PAC.CI[2]	= BYTE_MERGE( byBuffer[CI_IDX+ 4], byBuffer[CI_IDX+ 5] );
	PAC.CI[3]	= BYTE_MERGE( byBuffer[CI_IDX+ 6], byBuffer[CI_IDX+ 7] );
	PAC.CI[4]	= BYTE_MERGE( byBuffer[CI_IDX+ 8], byBuffer[CI_IDX+ 9] );
	PAC.CI[5]	= BYTE_MERGE( byBuffer[CI_IDX+10], byBuffer[CI_IDX+11] );
	PAC.CI[6]	= BYTE_MERGE( byBuffer[CI_IDX+12], byBuffer[CI_IDX+13] );
	PAC.CI[7]	= BYTE_MERGE( byBuffer[CI_IDX+14], byBuffer[CI_IDX+15] );

	//memcpy( PAC.CI_USER_INPUT, PAC.CI, sizeof(BYTE) * 8 );

	PAC.CI_FAULT= BYTE_MERGE( byBuffer[CI_IDX+16], byBuffer[CI_IDX+17] );

	PAC.CCI		= BYTE_MERGE(byBuffer[CI_IDX+18], byBuffer[CI_IDX+19] );
	PAC.CAR_POS = BYTE_MERGE(byBuffer[CI_IDX+20], byBuffer[CI_IDX+21] );

	if( PAC.CCI <= 0x00 || PAC.CCI > 0x08 )
	{
		nCarCount = 1;
	}
	else
	{
		nCarCount = PAC.CCI;
	}

#define CAR_IDX	(144)

	for(int i=0; i<(int)nCarCount; i++)
	{
		SetCarInfo(i, byBuffer + CAR_IDX + ( SIZE_PAC_CARINFO * i )  );
	}

	SetCarData(nCarCount, CAR_TEMP, PAC.CI_FAULT );

#define LIC_IDX (234)
	PAC.TL_LEN = BYTE_MERGE( byBuffer[LIC_IDX+ 0], byBuffer[LIC_IDX+ 1] );

	PAC.CI_LIC[0] = BYTE_MERGE( byBuffer[LIC_IDX+ 0], byBuffer[LIC_IDX+ 1] );
	PAC.CI_LIC[1] = BYTE_MERGE( byBuffer[LIC_IDX+ 2], byBuffer[LIC_IDX+ 3] );
	PAC.CI_LIC[2] = BYTE_MERGE( byBuffer[LIC_IDX+ 4], byBuffer[LIC_IDX+ 5] );
	PAC.CI_LIC[3] = BYTE_MERGE( byBuffer[LIC_IDX+ 6], byBuffer[LIC_IDX+ 7] );
	PAC.CI_LIC[4] = BYTE_MERGE( byBuffer[LIC_IDX+ 8], byBuffer[LIC_IDX+ 9] );
	PAC.CI_LIC[5] = BYTE_MERGE( byBuffer[LIC_IDX+ 10], byBuffer[LIC_IDX+ 11] );
	PAC.CI_LIC[6] = BYTE_MERGE( byBuffer[LIC_IDX+ 12], byBuffer[LIC_IDX+ 13] );
	PAC.CI_LIC[7] = BYTE_MERGE( byBuffer[LIC_IDX+ 14], byBuffer[LIC_IDX+ 15] );

}

void CPacket::SetCNCS( BYTE *byBuffer )
{
	char szPosition[16] = { 0, };
	int nCarCount = 0;

	CNCS.CNCS_T	= BYTE_MERGE( byBuffer[0], byBuffer[1] );
	CNCS.D0		= BYTE_MERGE( byBuffer[2], byBuffer[3] );
	CNCS.D1		= BYTE_MERGE( byBuffer[4], byBuffer[5] );
	CNCS.LED_T	= BYTE_MERGE( byBuffer[6], byBuffer[7] );
	CNCS.D2		= BYTE_MERGE( byBuffer[48], byBuffer[49] );

#define DATE_IDX	(50)
	CNCS.DATE[0]= BYTE_MERGE( byBuffer[DATE_IDX+ 0], byBuffer[DATE_IDX+ 1] );
	CNCS.DATE[1]= BYTE_MERGE( byBuffer[DATE_IDX+ 2], byBuffer[DATE_IDX+ 3] );
	CNCS.DATE[2]= BYTE_MERGE( byBuffer[DATE_IDX+ 4], byBuffer[DATE_IDX+ 5] );
	CNCS.DATE[3]= BYTE_MERGE( byBuffer[DATE_IDX+ 6], byBuffer[DATE_IDX+ 7] );
	CNCS.DATE[4]= BYTE_MERGE( byBuffer[DATE_IDX+ 8], byBuffer[DATE_IDX+ 9] );
	CNCS.DATE[5]= BYTE_MERGE( byBuffer[DATE_IDX+10], byBuffer[DATE_IDX+11] );

	// GPS 수신 시간 정보.
	
	CTime tmCurrent = CTime::GetCurrentTime();
	CTime tmGps = CTime(CNCS.DATE[0] + 2000, CNCS.DATE[1], CNCS.DATE[2], CNCS.DATE[3], CNCS.DATE[4], CNCS.DATE[5]);
	CTimeSpan tms = tmCurrent - tmGps;

	if ( 5 < abs(tms.GetTotalSeconds()) )
	{
		SYSTEMTIME  stime;
		tmGps.GetAsSystemTime(stime);
		SetLocalTime(&stime);
	}

	// 차량의 GPS 수신 상태를 나타내는 부분.
	BOOL bGps = (CNCS.D2 & 0x80);
	//RETAILMSG(1, (_T("%d : %d, %d\n"), bGps, bGpsStatus, (CNCS.D2 & 0x80)));

	if ( bGps )
	{
		SetValidGPS(true);

		memset( szPosition, 0x00, sizeof(char) * 16 );
		memcpy( szPosition, &byBuffer[DATE_IDX+12], sizeof(char) * 10 );
		CNCS.LAT = (float)strtod(szPosition, NULL) * 0.00001f;
		
		//RETAILMSG(1, (_T("LAT : %s %f\n"), szPosition, CNCS.LAT));
		memset( szPosition, 0x00, sizeof(char) * 16 );
		memcpy( szPosition, &byBuffer[DATE_IDX+24], sizeof(char) * 10 );
		CNCS.LOT = (float)strtod(szPosition, NULL) * -0.00001f;

		//RETAILMSG(1, (_T("LON : %s, %f\n"), szPosition, CNCS.LOT));
	}
	else
	{
		SetValidGPS(false);
	}

	Sleep(0);
}

void CPacket::SetLIC( BYTE *byBuffer )
{
	LIC.D0		= BYTE_MERGE( byBuffer[0], byBuffer[1] );
	LIC.CARN	= DEC_FROM_BCD4( byBuffer[4], byBuffer[5], byBuffer[6], byBuffer[7] );
}

void CPacket::SetCalibration( BYTE *byBuffer, BYTE byCCPID )
{
	UINT nCNCSIndex = m_unDataLength * 2;

	BYTE fromCNCS = CPacket::BYTE_MERGE( byBuffer[nCNCSIndex-4], byBuffer[nCNCSIndex-3] );
	//RETAILMSG(1, (_T("SetCalibration : %08X\n"), &byBuffer[nCNCSIndex-4]));

	m_bTouchCalibration_Master = ( ( 0x08 & fromCNCS ) == 0x08 && ( byCCPID == ID_CCP_A ) );

	m_bTouchCalibration_Slave = ( ( 0x20 & fromCNCS ) == 0x20 && ( byCCPID == ID_CCP_B )  );

	//RETAILMSG(1, (_T("Calibration[%02X] :  %d, %d\n"), fromCNCS, m_bTouchCalibration_Master, m_bTouchCalibration_Slave));
}

void CPacket::SetCarInfo(UINT nCarIndex, BYTE *byBuffer )
{
	CAR_DATA *car_data = &CAR_TEMP[nCarIndex];

	car_data->DATA[0]	= BYTE_MERGE( byBuffer[0], byBuffer[1] );
	car_data->DATA[1]	= BYTE_MERGE( byBuffer[2], byBuffer[3] );
	car_data->DATA[2]	= BYTE_MERGE( byBuffer[4], byBuffer[5] );
	car_data->DATA[3]	= BYTE_MERGE( byBuffer[6], byBuffer[7] );
	car_data->DATA[4]	= BYTE_MERGE( byBuffer[8], byBuffer[9] );
	car_data->DATA[5]	= BYTE_MERGE( byBuffer[10], byBuffer[11] );
	car_data->DATA[6]	= BYTE_MERGE( byBuffer[12], byBuffer[13] );
	car_data->DATA[7]	= BYTE_MERGE( byBuffer[14], byBuffer[15] );
	car_data->DATA[8]	= BYTE_MERGE( byBuffer[16], byBuffer[17] );
	car_data->CARN		= DEC_FROM_BCD4( byBuffer[18], byBuffer[19], byBuffer[20], byBuffer[21] );
}

void CPacket::SetSkipInfo( BYTE *byBuffer )
{
	for(int i = 89, j = 0; i < 109; i++, j++ )
	{
		if( ( byBuffer[i] & 0x30 ) == 0x30  )	PAC.SKIP[j] =  byBuffer[i] - 0x30;
		else								
		{
			PAC.SKIP[j] =  byBuffer[i] - 0x37;
		}
	}
}

BYTE CPacket::BYTE_MERGE( BYTE byHigh, BYTE byLow )
{
	if( ( byHigh & 0x30 ) == 0x30  )	byHigh -= 0x30;
	else								
	{
		byHigh -= 0x37;
	}

	if( ( byLow & 0x30 ) == 0x30  )		byLow -= 0x30;
	else								
	{
		byLow -= 0x37;
	}

	byHigh <<= 4;

	return (byHigh | byLow);
}

void CPacket::DEC_TO_BCD2(UINT DEC, BYTE *BCD)
{
	CString strDEC;
	strDEC.Format(_T("%02d"), DEC);

	for(int i=0; i<2; i++)	BCD[i] = (BYTE)strDEC.GetAt(i);
}

void CPacket::DEC_TO_BCD4(UINT DEC, BYTE *BCD)
{
	CString strDEC;
	strDEC.Format(_T("%04d"), DEC);

	for(int i=0; i<4; i++)	BCD[i] = (BYTE)strDEC.GetAt(i);
}

void CPacket::DEC_TO_BCD6(UINT DEC, BYTE *BCD)
{
	CString strDEC;
	strDEC.Format(_T("%06d"), DEC);

	for(int i=0; i<6; i++)	BCD[i] = (BYTE)strDEC.GetAt(i);
}

void CPacket::DEC_TO_BCD8(UINT DEC, BYTE *BCD)
{
	CString strDEC;
	strDEC.Format(_T("%08d"), DEC);

	for(int i=0; i<8; i++)	BCD[i] = (BYTE)strDEC.GetAt(i);
}


BYTE CPacket::DEC_FROM_BCD(BYTE BCD)
{
	if( ( BCD & 0x30 ) == 0x30  )	BCD -= 0x30;
	else								
	{
		BCD -= 0x37;
	}

	return BCD;
}

void CPacket::HEX_TO_BCD4(UINT HEX, BYTE *BCD)
{
	CString strHEX;
	strHEX.Format(_T("%04X"), HEX);

	for(int i=0; i<4; i++)
	{
		BCD[i] = (BYTE)strHEX.GetAt(i);
	}
}

void CPacket::HEX_TO_BCD8(UINT HEX, BYTE *BCD)
{
	CString strHEX;
	strHEX.Format(_T("%08X"), HEX);

	for(int i=0; i<8; i++)
	{
		BCD[i] = (BYTE)strHEX.GetAt(i);
	}
}

UINT CPacket::HEX_FROM_BCD4(BYTE *BCD)
{
	UINT nRet = 0;

	nRet += DEC_FROM_BCD( *(BCD + 0 ) ) << 12;
	nRet += DEC_FROM_BCD( *(BCD + 1 ) ) << 8;
	nRet += DEC_FROM_BCD( *(BCD + 2 ) ) << 4;
	nRet += DEC_FROM_BCD( *(BCD + 3 ) );

	return nRet;
}

UINT CPacket::HEX_FROM_BCD8(BYTE *BCD)
{
	UINT nRet = 0;

	nRet += DEC_FROM_BCD( *(BCD + 0 ) ) << 28;
	nRet += DEC_FROM_BCD( *(BCD + 1 ) ) << 24;
	nRet += DEC_FROM_BCD( *(BCD + 2 ) ) << 20;
	nRet += DEC_FROM_BCD( *(BCD + 3 ) ) << 16;
	nRet += DEC_FROM_BCD( *(BCD + 4 ) ) << 12;
	nRet += DEC_FROM_BCD( *(BCD + 5 ) ) << 8;
	nRet += DEC_FROM_BCD( *(BCD + 6 ) ) << 4;
	nRet += DEC_FROM_BCD( *(BCD + 7 ) );

	return nRet;
}
