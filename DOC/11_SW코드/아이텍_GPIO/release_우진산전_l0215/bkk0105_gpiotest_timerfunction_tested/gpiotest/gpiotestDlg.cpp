// gpiotestDlg.cpp : implementation file
//

#include "stdafx.h"
#include "gpiotest.h"
#include "gpiotestDlg.h"
#include "windows.h"
#include "stdlib.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CgpiotestDlg dialog

CgpiotestDlg::CgpiotestDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CgpiotestDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CgpiotestDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);

	DDX_Control(pDX, IDC_EDITGPI, m_EditGPI );
	DDX_Control(pDX, IDC_EDITGPO, m_EditGPO );
	DDX_Control(pDX, IDC_EDITGPOR, m_EditGPOR );
	DDX_Control(pDX, IDC_COMBO_BLCOM, m_ComboBLCom);
}

BEGIN_MESSAGE_MAP(CgpiotestDlg, CDialog)
#if defined(_DEVICE_RESOLUTION_AWARE) && !defined(WIN32_PLATFORM_WFSP)
	ON_WM_SIZE()
#endif
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_GPIO_OPEN, &CgpiotestDlg::OnBnClickedGpioOpen)
	ON_BN_CLICKED(IDC_GPIO_READ, &CgpiotestDlg::OnBnClickedGpioRead)
	ON_BN_CLICKED(IDC_GPIO_WRITE, &CgpiotestDlg::OnBnClickedGpioWrite)
	ON_BN_CLICKED(IDC_BUTTON3, &CgpiotestDlg::OnBnClickedButton3)
	ON_BN_CLICKED(IDC_COMTEST, &CgpiotestDlg::OnBnClickedComtest)
	ON_BN_CLICKED(IDC_COMOPEN, &CgpiotestDlg::OnBnClickedComopen)
	ON_BN_CLICKED(IDC_COMCLOSE, &CgpiotestDlg::OnBnClickedComclose)
	ON_BN_CLICKED(IDC_COMTX, &CgpiotestDlg::OnBnClickedComtx)
	ON_BN_CLICKED(IDC_BUTTON_BLOPEN, &CgpiotestDlg::OnBnClickedButtonBlopen)
	ON_BN_CLICKED(IDC_BUTTON_BLAUTO, &CgpiotestDlg::OnBnClickedButtonBlauto)
	ON_BN_CLICKED(IDC_BUTTON_BLUP, &CgpiotestDlg::OnBnClickedButtonBlup)
	ON_BN_CLICKED(IDC_BUTTON_BLDOWN, &CgpiotestDlg::OnBnClickedButtonBldown)
	ON_BN_CLICKED(IDC_BUTTON_BLCLOSE, &CgpiotestDlg::OnBnClickedButtonBlclose)
	ON_BN_CLICKED(IDC_GPIO_RUN, &CgpiotestDlg::OnBnClickedGpioRun)
	ON_WM_TIMER()

	ON_BN_CLICKED(IDC_BUTTON_ALMACK, &CgpiotestDlg::OnBnClickedButtonAlmack)
END_MESSAGE_MAP()


// CgpiotestDlg message handlers

BOOL CgpiotestDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	// TODO: Add extra initialization here
	m_EditGPI.SetWindowText(L"00") ;
	m_EditGPO.SetWindowText(L"00") ;
	m_EditGPOR.SetWindowText(L"00") ;

	m_ComboBLCom.SetCurSel(0) ;
	return TRUE;  // return TRUE  unless you set the focus to a control
}

#if defined(_DEVICE_RESOLUTION_AWARE) && !defined(WIN32_PLATFORM_WFSP)
void CgpiotestDlg::OnSize(UINT /*nType*/, int /*cx*/, int /*cy*/)
{
	if (AfxIsDRAEnabled())
	{
		DRA::RelayoutDialog(
			AfxGetResourceHandle(), 
			this->m_hWnd, 
			DRA::GetDisplayMode() != DRA::Portrait ? 
			MAKEINTRESOURCE(IDD_GPIOTEST_DIALOG_WIDE) : 
			MAKEINTRESOURCE(IDD_GPIOTEST_DIALOG));
	}
}
#endif

HANDLE hGPI, hGPO ;

void CgpiotestDlg::OnBnClickedGpioOpen()
{
	// TODO: Add your control notification handler code here
	hGPI = CreateFile(L"GPI1:", GENERIC_READ , FILE_SHARE_READ , NULL, OPEN_EXISTING, 0, 0);
	if ( hGPI == INVALID_HANDLE_VALUE ){
		MessageBox(NULL,L"TestGPIO : Error Opening GPIO Driver\n",MB_OK ) ;
	}
	hGPO = CreateFile(L"GPO1:", GENERIC_READ|GENERIC_WRITE , FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, 0);
	if ( hGPO == INVALID_HANDLE_VALUE ){
		MessageBox(NULL,L"TestGPIO : Error Opening GPIO Driver\n",MB_OK ) ;
	}
}

void CgpiotestDlg::OnBnClickedGpioRead()
{
	unsigned char rBuf ;
	CString buf ;
	DWORD dwByte ;

	// TODO: Add your control notification handler code here
	if ( ReadFile(hGPI, &rBuf, 1, &dwByte,NULL) == FALSE )
		MessageBox(NULL,L"Read Error", MB_OK );
	else{
		rBuf = rBuf & 0xff ;
		buf.Format(L"%2X", (unsigned char)rBuf) ;
		m_EditGPI.SetWindowText(buf) ;
//		buf.Format(L"Read Data=%2X ",(char)rBuf ) ;
//		MessageBox(buf);
	}
}

void CgpiotestDlg::OnBnClickedGpioWrite()
{
	// TODO: Add your control notification handler code here
	unsigned char wBuf, rBuf, uMSB, uLSB ;
	char winBuf[6] ;
	CString buf ;
	DWORD dwByte ;

	m_EditGPO.GetWindowTextW(buf) ;
	buf.MakeUpper() ;

	strncpy_s(winBuf,6,CT2A(buf),3) ;
	winBuf[2] = '\0' ; 

	uMSB = winBuf[0] ;
	if ( uMSB >='0' && uMSB <='9')
		uMSB = uMSB -'0' ;
	else if ( uMSB >='A' && uMSB <='F')
		uMSB = uMSB -'A'+10 ;
	else
		uMSB = 0 ;

	uLSB = winBuf[1] ;
	if ( uLSB >='0' && uLSB <='9')
		uLSB = uLSB -'0' ;
	else if ( uLSB >='A' && uLSB <='F')
		uLSB = uLSB -'A'+10 ;
	else
		uLSB = 0 ;

	wBuf = uMSB*16+uLSB ;

	if ( WriteFile(hGPO, &wBuf, 1, &dwByte,NULL) == FALSE )
		MessageBox(NULL,L"Write Error", MB_OK );
	else{
		ReadFile(hGPO, &rBuf, 1, &dwByte,NULL) ;
		rBuf = rBuf & 0xff ;
		buf.Format(L"%2X", (unsigned char)rBuf) ;
		m_EditGPOR.SetWindowText(buf) ;
//		buf.Format(L"Read (%2X) After Write (%2X) ", (unsigned char)rBuf, (unsigned char)wBuf ) ;
//		MessageBox(buf);
	}

}

unsigned char uGPO_shift ;

void CgpiotestDlg::OnBnClickedGpioRun()
{
	SetTimer(1, 1000, 0 ) ;
	uGPO_shift = 0x80 ;
}

void CgpiotestDlg::OnTimer(UINT nIDEvent)
{
	unsigned char wBuf, rBuf ;
	CString buf ;
	DWORD dwByte ;

	if ( nIDEvent == 1 ){
		OnBnClickedGpioRead() ;

		wBuf = uGPO_shift ;
		uGPO_shift = uGPO_shift >> 1 ;
		if ( uGPO_shift == 0 )
			uGPO_shift = 0x80 ;

		WriteFile(hGPO, &wBuf, 1, &dwByte,NULL) ;
		ReadFile(hGPO, &rBuf, 1, &dwByte,NULL) ;
		rBuf = rBuf & 0xff ;
		buf.Format(L"%2X", (unsigned char)rBuf) ;
		m_EditGPOR.SetWindowText(buf) ;
	}
}

void CgpiotestDlg::OnBnClickedButton3()
{
	// TODO: Add your control notification handler code here
	CloseHandle(hGPO) ;
	CloseHandle(hGPI) ;
	KillTimer(1) ;

}

void CgpiotestDlg::OnBnClickedComtest()
{
	CString buf, longbuf ;
	HANDLE hPort;
	wchar_t lpszPort[6];
	int nPort, i, j, nFirstEnabledPort ;
	DCB PortDCB;
	char ComBuf[12] ;
	DWORD dwNumBytesWritten = 0;

	m_ComboBLCom.ResetContent();
	nFirstEnabledPort = -1 ;
	longbuf = "" ;
	// COM Port Open Test
	for ( nPort =1; nPort < 10 ; nPort++ ){
		wsprintf(lpszPort, L"COM%d:\0", nPort);
		hPort = CreateFile(lpszPort, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
		if (hPort == INVALID_HANDLE_VALUE)
		{
			buf.Format(L"%s : Unable to Open (%d) \n\r",lpszPort, nPort ) ;
//			MessageBox(buf);
			longbuf+=buf ;
		}else{
			buf.Format(L"%s : Open OK! (%d) ",lpszPort, nPort ) ;
//			MessageBox(buf);
			longbuf+=buf ;

			PortDCB.DCBlength = sizeof(DCB);
			GetCommState(hPort, &PortDCB);
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
			if (!SetCommState (hPort, &PortDCB))
			{
//				MessageBox(NULL,L"Unable to Config", MB_OK );
				buf.Format(L"Config Fail \n\r" ) ;
				longbuf+=buf ;
			}else{
				buf.Format(L"Config OK, " ) ;
				longbuf+=buf ;

				/// 타임-아웃을 설정한다.
				COMMTIMEOUTS CommTimeouts;
				GetCommTimeouts (hPort, &CommTimeouts);
				CommTimeouts.ReadIntervalTimeout = MAXDWORD;
				CommTimeouts.ReadTotalTimeoutMultiplier = 0;
				CommTimeouts.ReadTotalTimeoutConstant = 0;
				CommTimeouts.WriteTotalTimeoutMultiplier = 10;
				CommTimeouts.WriteTotalTimeoutConstant = 1000;
				if (!SetCommTimeouts (hPort, &CommTimeouts))
				{
					buf.Format(L"Set Timeout Fail\n\r" ) ;
					longbuf+=buf ;
					break;
				}

				// LoopBack Test
				ComBuf[0] = 'L' ;	ComBuf[1] = 'O' ;
				ComBuf[2] = 'O' ;	ComBuf[3] = 'P' ;
				ComBuf[4] = 'T' ;	ComBuf[5] = 'E' ;
				ComBuf[6] = 'S' ;	ComBuf[7] = 'T' ;
				WriteFile(hPort, ComBuf, 8, &dwNumBytesWritten, NULL);
				buf.Format(L"W%d",(int)dwNumBytesWritten ) ;
				longbuf+=buf ;

				for (i=0;i<10000;i++) 
					j = i ;

				ReadFile(hPort, ComBuf, 8, &dwNumBytesWritten, NULL);
				buf.Format(L"R%d",(int)dwNumBytesWritten ) ;
				longbuf+=buf ;

				buf.Format(L"\n\r" ) ;
				longbuf+=buf ;
			}
		}

		// Close Open COM Port
		if (hPort != INVALID_HANDLE_VALUE){
			buf.Format(L"COM%d",(int)nPort ) ;
			if ( nFirstEnabledPort == -1 )
				nFirstEnabledPort = nPort ;
			m_ComboBLCom.AddString(buf);
			SetCommMask(hPort, 0);
			PurgeComm(hPort, PURGE_TXABORT | PURGE_TXCLEAR | PURGE_RXABORT | PURGE_RXCLEAR);
			CloseHandle(hPort);
		}else{
			buf.Format(L"----") ;
			m_ComboBLCom.AddString(buf);
		}
	}
	if ( nFirstEnabledPort != -1 )
		m_ComboBLCom.SetCurSel(nFirstEnabledPort-1);
	else
		m_ComboBLCom.SetCurSel(0);
	MessageBox(longbuf);
}

HANDLE hCOMPort;
HANDLE hBLCOMPort;

void CgpiotestDlg::OnBnClickedComopen()
{
	SetTimer(1, 1000, 0 ) ;
	uGPO_shift = 0x80 ;
/*
	CString buf, longbuf ;
	wchar_t lpszPort[6];
	int nPort ;
	DCB PortDCB;

	nPort = 7; 
	longbuf = "" ;
	wsprintf(lpszPort, L"COM%d:\0", nPort);
	hCOMPort = CreateFile(lpszPort, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
	if (hCOMPort == INVALID_HANDLE_VALUE)
	{
		buf.Format(L"%s : Unable to Open (%d) \n\r",lpszPort, nPort ) ;
//		MessageBox(buf);
		longbuf+=buf ;
	}else{
		buf.Format(L"%s : Open OK! (%d) ",lpszPort, nPort ) ;
//		MessageBox(buf);
		longbuf+=buf ;

		PortDCB.DCBlength = sizeof(DCB);
		GetCommState(hCOMPort, &PortDCB);
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
		if (!SetCommState (hCOMPort, &PortDCB))
		{
//			MessageBox(NULL,L"Unable to Config", MB_OK );
			buf.Format(L"Config Fail \n\r" ) ;
			longbuf+=buf ;
		}else{
			buf.Format(L"Config OK, " ) ;
			longbuf+=buf ;

			/// 타임-아웃을 설정한다.
			COMMTIMEOUTS CommTimeouts;
			GetCommTimeouts (hCOMPort, &CommTimeouts);
			CommTimeouts.ReadIntervalTimeout = MAXDWORD;
			CommTimeouts.ReadTotalTimeoutMultiplier = 0;
			CommTimeouts.ReadTotalTimeoutConstant = 0;
			CommTimeouts.WriteTotalTimeoutMultiplier = 10;
			CommTimeouts.WriteTotalTimeoutConstant = 1000;
			if (!SetCommTimeouts (hCOMPort, &CommTimeouts))
			{
				buf.Format(L"Set Timeout Fail\n\r" ) ;
				longbuf+=buf ;
			}else{
				buf.Format(L"Set Timeout OK\n\r" ) ;
				longbuf+=buf ;
			}
		}
	}
	MessageBox(longbuf);
*/
}

void CgpiotestDlg::OnBnClickedComclose()
{
	// Close Open COM Port
	if (hCOMPort != INVALID_HANDLE_VALUE){
		SetCommMask(hCOMPort, 0);
		PurgeComm(hCOMPort, PURGE_TXABORT | PURGE_TXCLEAR | PURGE_RXABORT | PURGE_RXCLEAR);
		CloseHandle(hCOMPort);
	}
}

void CgpiotestDlg::OnBnClickedComtx()
{
	int i ;
	unsigned char ComBuf[12], Bcc, BccASC ;
	DWORD dwNumBytesWritten = 0;

	// Send Key Down
	ComBuf[0] = 0x02 ;	ComBuf[1] = '4' ;
	ComBuf[2] = 'A' ;	ComBuf[3] = '0' ;	// Alarm Acknowledge
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
	WriteFile(hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);

/*
	char ComBuf[12] ;
	DWORD dwNumBytesWritten = 0;

	// LoopBack Test
	ComBuf[0] = 'C' ;	ComBuf[1] = 'O' ;
	ComBuf[2] = 'M' ;	ComBuf[3] = ' ' ;
	ComBuf[4] = 'T' ;	ComBuf[5] = 'E' ;
	ComBuf[6] = 'S' ;	ComBuf[7] = 'T' ;ComBuf[8] = ' ' ;
	WriteFile(hCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);
*/
}

void CgpiotestDlg::OnBnClickedButtonBlopen()
{
	CString buf, longbuf ;
	wchar_t lpszPort[6];
	int nPort ;
	DCB PortDCB;

	nPort = m_ComboBLCom.GetCurSel()+1; 
	longbuf = "" ;
	wsprintf(lpszPort, L"COM%d:\0", nPort);
	hBLCOMPort = CreateFile(lpszPort, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
	if (hBLCOMPort == INVALID_HANDLE_VALUE)
	{
		buf.Format(L"%s : Unable to Open (%d) \n\r",lpszPort, nPort ) ;
//		MessageBox(buf);
		longbuf+=buf ;
	}else{
		buf.Format(L"%s : Open OK! (%d) ",lpszPort, nPort ) ;
//		MessageBox(buf);
		longbuf+=buf ;

		PortDCB.DCBlength = sizeof(DCB);
		GetCommState(hBLCOMPort, &PortDCB);
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
		if (!SetCommState (hBLCOMPort, &PortDCB))
		{
//			MessageBox(NULL,L"Unable to Config", MB_OK );
			buf.Format(L"Config Fail \n\r" ) ;
			longbuf+=buf ;
		}else{
			buf.Format(L"Config OK, " ) ;
			longbuf+=buf ;

			/// 타임-아웃을 설정한다.
			COMMTIMEOUTS CommTimeouts;
			GetCommTimeouts (hBLCOMPort, &CommTimeouts);
			CommTimeouts.ReadIntervalTimeout = MAXDWORD;
			CommTimeouts.ReadTotalTimeoutMultiplier = 0;
			CommTimeouts.ReadTotalTimeoutConstant = 0;
			CommTimeouts.WriteTotalTimeoutMultiplier = 10;
			CommTimeouts.WriteTotalTimeoutConstant = 1000;
			if (!SetCommTimeouts (hBLCOMPort, &CommTimeouts))
			{
				buf.Format(L"Set Timeout Fail\n\r" ) ;
				longbuf+=buf ;
			}else{
				buf.Format(L"Set Timeout OK\n\r" ) ;
				longbuf+=buf ;
			}
		}
	}
//	MessageBox(longbuf);
}

void CgpiotestDlg::OnBnClickedButtonBlauto()
{
	int i ;
	unsigned char ComBuf[12], Bcc, BccASC ;
	DWORD dwNumBytesWritten = 0;

	// Send Key AUTO
	ComBuf[0] = 0x02 ;	ComBuf[1] = '4' ;
	ComBuf[2] = 'K' ;	ComBuf[3] = 'A' ;	// Key "Auto"
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
	WriteFile(hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);
}

void CgpiotestDlg::OnBnClickedButtonBlup()
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
	WriteFile(hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);
}

void CgpiotestDlg::OnBnClickedButtonBldown()
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
	WriteFile(hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);
}

void CgpiotestDlg::OnBnClickedButtonBlclose()
{
	// Close Open COM Port
	if (hBLCOMPort != INVALID_HANDLE_VALUE){
		SetCommMask(hBLCOMPort, 0);
		PurgeComm(hBLCOMPort, PURGE_TXABORT | PURGE_TXCLEAR | PURGE_RXABORT | PURGE_RXCLEAR);
		CloseHandle(hBLCOMPort);
	}
}

void CgpiotestDlg::OnBnClickedButtonAlmack()
{
	int i ;
	unsigned char ComBuf[12], Bcc, BccASC ;
	DWORD dwNumBytesWritten = 0;

	// Send Key Down
	ComBuf[0] = 0x02 ;	ComBuf[1] = '4' ;
	ComBuf[2] = 'A' ;	ComBuf[3] = '0' ;	// Alarm Acknowledge
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
	WriteFile(hBLCOMPort, ComBuf, 9, &dwNumBytesWritten, NULL);
}
