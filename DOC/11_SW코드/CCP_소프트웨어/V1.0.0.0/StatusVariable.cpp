// StatusVariable.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "StatusVariable.h"


// CStatusVariable

CStatusVariable::CStatusVariable()
{
	m_hBLCOMPort		= NULL;
	m_byCabSpeaker		= 0;
	m_byIntSpeaker		= 0;
	m_byExtSpeaker		= 0;
	m_nBrightness		= 0;

	m_byCCPID			= ID_CCP_B;

	m_bIsUpdating		= false;
	m_bSetCabonKey		= false;
	m_bSetConducterKey	= false;
	m_nDetectCabOff		= 0;
	m_bInuguration		= false;
	m_bSetPEI			= false;
	m_bCheckPEI			= false;

	m_nSetCount_ID_A	= 0;
	m_nSetCount_ID_B	= 0;
	m_nSetCount_CAB_ON	= 0;
	m_nSetCount_CAB_OFF	= 0;
	m_nSetCount_CON_ON	= 0;
	m_nSetCount_CON_OFF	= 0;

//	m_nPEICarNo			= 0;	

	COSNT_Brightness[0] = 10;
	COSNT_Brightness[1] = 20;
	COSNT_Brightness[2] = 30;
	COSNT_Brightness[3] = 50;
	COSNT_Brightness[4] = 80;
	COSNT_Brightness[5] = 150;
	COSNT_Brightness[6] = 300;
	COSNT_Brightness[7] = 450;
	COSNT_Brightness[8] = 600;
	COSNT_Brightness[9] = 800;
	COSNT_Brightness[10] = 1000;

	m_bSetCrossTime = false;
	m_bSetTouchCalibration_Master	= false;
	m_bSetTouchCalibration_Slave	= false;

	m_bUsing	= false;


	VS_FIXEDFILEINFO vfi;
	CString strVersion("Ver : 00.00.00.00");

	DWORD dwHandle;
	BOOL bResult = FALSE;
	
	CString strFilePath = GetExecuteFilePath();

	if(!strFilePath.IsEmpty())
	{
		//HMODULE hModule = GetModuleHandle( _T("\\NandFlash\\AnCCP_MFC1.exe") );
		//DWORD dwLen = ::GetFileVersionInfoSize( _T("\\NandFlash\\AnCCP_MFC.exe"), &dwHandle);
		//HMODULE hModule = ::GetModuleHandle( strFilePath );
		DWORD dwLen = ::GetFileVersionInfoSize( (LPWSTR)(LPCWSTR)strFilePath, &dwHandle);

		FillMemory(&vfi, sizeof(VS_FIXEDFILEINFO), 0x00);
			
		if(dwLen)
		{
			LPSTR lpData = new CHAR[dwLen];

			if(GetFileVersionInfo(strFilePath.GetBuffer(0), dwHandle, dwLen, lpData))
			{
				UINT uLen;
				PVOID voidData;
				
				if(VerQueryValue(lpData, TEXT("\\"), &voidData, &uLen))
				{
					CopyMemory(&vfi, voidData, sizeof(VS_FIXEDFILEINFO));
					bResult = TRUE;
				}
			}

			delete [] lpData;
		}

		if( bResult )
		{
			sprintf( m_szVersion, "%d%d%d%d",  HIWORD(vfi.dwFileVersionMS), LOWORD(vfi.dwFileVersionMS), HIWORD(vfi.dwFileVersionLS), LOWORD(vfi.dwFileVersionLS) );
		}
	}

	CString strBuildDate;
	strBuildDate.LoadString(IDS_BUILDDATE);

	_WCtoMB( strBuildDate.GetBuffer(0), m_szBuildDate );

	OpenConPort();

	ReadBrightNess();

}

void CStatusVariable::OpenConPort()
{
	CString buf, longbuf ;
	DCB PortDCB;

	longbuf = "" ;

	m_hBLCOMPort = CreateFile( _T("COM4:"), GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
	if (m_hBLCOMPort == INVALID_HANDLE_VALUE)
	{
//		buf.Format(L"%s : Unable to Open (%d) \n\r",lpszPort, nPort ) ;
//		MessageBox(buf);
		longbuf+=buf ;
	}else{
//		buf.Format(L"%s : Open OK! (%d) ",lpszPort, nPort ) ;
//		MessageBox(buf);
//		longbuf+=buf ;

		PortDCB.DCBlength = sizeof(DCB);
		GetCommState(m_hBLCOMPort, &PortDCB);
		PortDCB.BaudRate = 9600 ;
		//PortDCB.fBinary = TRUE;
		PortDCB.fParity = TRUE;
		//PortDCB.fOutxCtsFlow = FALSE;
		//PortDCB.fOutxDsrFlow = FALSE;
		//PortDCB.fDtrControl = DTR_CONTROL_ENABLE;
		//PortDCB.fDsrSensitivity = FALSE;
		//PortDCB.fTXContinueOnXoff = TRUE;
		//PortDCB.fOutX = FALSE;
		//PortDCB.fInX = FALSE;
		//PortDCB.fErrorChar = FALSE;
		//PortDCB.fNull = FALSE;
		//PortDCB.fRtsControl = RTS_CONTROL_ENABLE; 
		//PortDCB.fAbortOnError = FALSE;
		PortDCB.ByteSize = 8;
		PortDCB.Parity = NOPARITY;
		PortDCB.StopBits = ONESTOPBIT;
		if (!SetCommState (m_hBLCOMPort, &PortDCB))
		{
//			MessageBox(NULL,L"Unable to Config", MB_OK );
//			buf.Format(L"Config Fail \n\r" ) ;
//			longbuf+=buf ;
		}else{
//			buf.Format(L"Config OK, " ) ;
//			longbuf+=buf ;

			/// 타임-아웃을 설정한다.
			COMMTIMEOUTS CommTimeouts;
			GetCommTimeouts (m_hBLCOMPort, &CommTimeouts);
			CommTimeouts.ReadIntervalTimeout = MAXDWORD;
			CommTimeouts.ReadTotalTimeoutMultiplier = 0;
			CommTimeouts.ReadTotalTimeoutConstant = 0;
			CommTimeouts.WriteTotalTimeoutMultiplier = 10;
			CommTimeouts.WriteTotalTimeoutConstant = 1000;
			if (!SetCommTimeouts (m_hBLCOMPort, &CommTimeouts))
			{
//				buf.Format(L"Set Timeout Fail\n\r" ) ;
//				longbuf+=buf ;
			}else{
//				buf.Format(L"Set Timeout OK\n\r" ) ;
//				longbuf+=buf ;
			}
		}
	}
//	MessageBox(longbuf);
}

void CStatusVariable::BrightUp()
{
	int i ;
	unsigned char ComBuf[12], Bcc, BccASC ;
	DWORD dwNumBytesWritten = 0;

	// Send Key UP
	ComBuf[0] = 0x02 ;	ComBuf[1] = '4' ;
	ComBuf[2] = 'K' ;	ComBuf[3] = 'U' ;	// Key "Up"
	ComBuf[4] = '0' ;	ComBuf[5] = '0' ;

	Bcc = 0 ;
	for (i=1; i<6; i++)
		Bcc = Bcc + ComBuf[i] ;
	BccASC = (Bcc & 0xf0 ) >> 4 ;
	if (BccASC > 10 )
		ComBuf[6] = 'A'+BccASC-10 ;
	else
		ComBuf[6] = '0'+BccASC ;

	BccASC = (Bcc & 0xf ) ;
	if (BccASC > 10 )
		ComBuf[7] = 'A'+BccASC-10 ;
	else
		ComBuf[7] = '0'+BccASC ;

	ComBuf[8] = 0x03 ;
	WriteFile(m_hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);
}

void CStatusVariable::BrightDown()
{
	int i ;
	unsigned char ComBuf[12], Bcc, BccASC ;
	DWORD dwNumBytesWritten = 0;

	// Send Key Down
	ComBuf[0] = 0x02 ;	ComBuf[1] = '4' ;
	ComBuf[2] = 'K' ;	ComBuf[3] = 'D' ;	// Key "Down"
	ComBuf[4] = '0' ;	ComBuf[5] = '0' ;

	Bcc = 0 ;
	for (i=1; i<6; i++)
		Bcc = Bcc + ComBuf[i] ;
	BccASC = (Bcc & 0xf0 ) >> 4 ;
	if (BccASC > 10 )
		ComBuf[6] = 'A'+BccASC-10 ;
	else
		ComBuf[6] = '0'+BccASC ;

	BccASC = (Bcc & 0xf ) ;
	if (BccASC > 10 )
		ComBuf[7] = 'A'+BccASC-10 ;
	else
		ComBuf[7] = '0'+BccASC ;

	ComBuf[8] = 0x03 ;
	WriteFile(m_hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);
}

void CStatusVariable::ReadBrightNess()
{
	DWORD	dwErrorFlags= 0, dwRead = 0;

	int i ;
	unsigned char ComBuf[12], Bcc, BccASC ;
	DWORD dwNumBytesWritten = 0;

	PurgeComm(m_hBLCOMPort, PURGE_TXABORT | PURGE_TXCLEAR | PURGE_RXABORT | PURGE_RXCLEAR);

	// Send Key Down
	ComBuf[0] = 0x02 ;	ComBuf[1] = '4' ;
	ComBuf[2] = 'R' ;	ComBuf[3] = '0' ;	// Key "Down"
	ComBuf[4] = '0' ;	ComBuf[5] = '0' ;

	Bcc = 0 ;
	for (i=1; i<6; i++)
		Bcc = Bcc + ComBuf[i] ;
	BccASC = (Bcc & 0xf0 ) >> 4 ;
	if (BccASC > 10 )
		ComBuf[6] = 'A'+BccASC-10 ;
	else
		ComBuf[6] = '0'+BccASC ;

	BccASC = (Bcc & 0xf ) ;
	if (BccASC > 10 )
		ComBuf[7] = 'A'+BccASC-10 ;
	else
		ComBuf[7] = '0'+BccASC ;

	ComBuf[8] = 0x03 ;
	WriteFile(m_hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);

	Sleep(100);

	if( !ReadFile( m_hBLCOMPort, ComBuf, 9, &dwRead, NULL) )
	{
		return;
	}

	ComBuf[5] -= 0x30;

	if( ComBuf[5] >= 0 && ComBuf[5] <= 9 )
	{
		m_nBrightness = ComBuf[5];
	}
	
}

void CStatusVariable::CloseConPort()
{
	// Close Open COM Port
	if (m_hBLCOMPort != INVALID_HANDLE_VALUE){
		SetCommMask(m_hBLCOMPort, 0);
		PurgeComm(m_hBLCOMPort, PURGE_TXABORT | PURGE_TXCLEAR | PURGE_RXABORT | PURGE_RXCLEAR);
		CloseHandle(m_hBLCOMPort);
	}
}

CString CStatusVariable::GetExecuteFilePath()
{
	TCHAR szFileName[1024];
	//CString strVersion("0.0.0.0");

	//RETAILMSG(1, (_T("%d-%d\n"), _tcslen(szFileName), sizeof(TCHAR)));

	//if(!GetModuleFileName(NULL, szFileName, sizeof(szFileName))) //(DWORD)wcslen(szFileName)))
	//	TRACE("GetLastError() : %d\n", GetLastError());

	GetModuleFileName(NULL, szFileName, sizeof(szFileName));

	return CString(szFileName);
}

CStatusVariable::~CStatusVariable()
{
	CloseConPort();
}


// CStatusVariable 멤버 함수
void CStatusVariable::SetCabSpeaker(BYTE byCabSpeaker)
{
	m_byCabSpeaker = byCabSpeaker;
}

void CStatusVariable::SetIntSpeaker(BYTE byIntSpeaker)
{
	m_byIntSpeaker = byIntSpeaker;
}

void CStatusVariable::SetExtSpeaker(BYTE byExtSpeaker)
{
	m_byExtSpeaker = byExtSpeaker;
}

void CStatusVariable::SetBrightnessUpDown(bool bUp, CWnd *pWnd)
{
	if( 1 < m_nBrightness && !bUp )
	{
		m_nBrightness--;
		BrightDown();

		Sleep(50);
	}

	if( 9 > m_nBrightness && bUp)
	{
		m_nBrightness++;
		BrightUp();

		Sleep(50);
	}

	/*
	HDC hGetDC = pWnd->GetDC()->GetSafeHdc();

	if( 1 < m_nBrightness && !bUp )
	{
		m_nBrightness--;
		ExtEscape(hGetDC, DRVESC_SET_BRIGHTNESS, sizeof(int), (LPSTR)&COSNT_Brightness[m_nBrightness+1], 0, NULL);
	}

	if( 9 > m_nBrightness && bUp)
	{
		m_nBrightness++;
		ExtEscape(hGetDC, DRVESC_SET_BRIGHTNESS, sizeof(int), (LPSTR)&COSNT_Brightness[m_nBrightness+1], 0, NULL);
	}

	::DeleteDC( hGetDC );
	*/
}

void CStatusVariable::SetBrightness(UINT nBrightness, CWnd *pWnd)
{
	if( nBrightness > 9 ) return;

	if( nBrightness > m_nBrightness )
	{
		for(int i = 0; i< (nBrightness-m_nBrightness); i++)
		{
			BrightUp();

			Sleep(100);
		}
	}
	else
	if( m_nBrightness > nBrightness )
	{
		for(int i = 0; i< (m_nBrightness-nBrightness); i++)
		{
			BrightDown();

			Sleep(100);
		}
	}

	m_nBrightness = nBrightness;


	
	/*
	if( nBrightness > 9 ) return;
	
	m_nBrightness = nBrightness;

	HDC hGetDC = pWnd->GetDC()->GetSafeHdc();

	ExtEscape(hGetDC, DRVESC_SET_BRIGHTNESS, sizeof(int), (LPSTR)&COSNT_Brightness[m_nBrightness+1], 0, NULL);

	::DeleteDC( hGetDC );
	*/

}

BYTE CStatusVariable::GetIntSpeaker()
{
	return m_byIntSpeaker;
}

BYTE CStatusVariable::GetExtSpeaker()
{
	return m_byExtSpeaker;
}

BYTE CStatusVariable::GetSpeakerValue()
{
	BYTE	byRET = 0;

	if( m_byIntSpeaker == 0 )		byRET |= 0x40;
	else if( m_byIntSpeaker == 1 )	byRET |= 0x20;

	if( m_byExtSpeaker == 0 )		byRET |= 0x08;
	else if( m_byExtSpeaker == 1 )	byRET |= 0x04;
	else if( m_byExtSpeaker == 2 )	byRET |= 0x03;

	return byRET;
}



UINT CStatusVariable::GetBrightness()
{
	return m_nBrightness;
}
