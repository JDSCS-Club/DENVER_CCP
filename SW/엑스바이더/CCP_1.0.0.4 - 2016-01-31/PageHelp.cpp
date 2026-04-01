// Page_Help.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PageHelp.h"
#include "CCPDlg.h"

// CPageHelp 대화 상자입니다.
IMPLEMENT_DYNAMIC(CPageHelp, CDialog)

CPageHelp::CPageHelp(CWnd* pParent /*=NULL*/)
	: CDialog(CPageHelp::IDD, pParent)
{
	m_pParent = (CCCPDlg *)pParent;
	m_pBGDC		= m_pParent->m_dcPageBG[0].GetDC();
}

CPageHelp::~CPageHelp()
{
	m_ftEdit.DeleteObject();
}

void CPageHelp::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_BTN_HOME, m_btnHome);
	DDX_Control(pDX, IDC_BTN_TRAIN, m_btnTrain);
	DDX_Control(pDX, IDC_BTN_CREW, m_btnCrew);
	DDX_Control(pDX, IDC_BTN_ROUTE, m_btnRoute);
	DDX_Control(pDX, IDC_BTN_CONFIG, m_btnConfig);
	DDX_Control(pDX, IDC_BTN_CHECK, m_btnCheck);
	DDX_Control(pDX, IDC_BTN_PEI, m_btnPei);
	DDX_Control(pDX, IDC_BTN_MESSAGE, m_btnMessage);
	DDX_Control(pDX, IDC_APP_VERSION, m_stcVersion);
	DDX_Control(pDX, IDC_HELP_EDIT, m_edtContent);
	DDX_Control(pDX, IDC_HELP_TITLE, m_stcTitle);
}


BEGIN_MESSAGE_MAP(CPageHelp, CDialog)
	ON_WM_ERASEBKGND()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_HOME, IDC_BTN_MESSAGE,   &CPageHelp::OnClick_Menu)
	ON_WM_SHOWWINDOW()
	ON_WM_ACTIVATE()
	ON_WM_CTLCOLOR()
END_MESSAGE_MAP()

// CPageHelp 메시지 처리기입니다.
BOOL CPageHelp::OnInitDialog()
{
	CDialog::OnInitDialog();

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	m_brsEditBG.CreateSolidBrush(RGB(255,255,255));

	h_instance = AfxGetInstanceHandle();
	//m_hBmpBkgnd = SHLoadDIBitmap( _T(IDB_DEFAULT_BG));

	m_btnHome.SetWindowPos(NULL, 52-2, 113-57, 263, 40, TRUE);
	m_btnHome.SetBitmapFromFile(_T(IDB_HELP_HOME_UP), _T(IDB_HELP_HOME_DN));

	m_btnTrain.SetWindowPos(NULL, 52-2, 169-57, 263, 40, TRUE);
	m_btnTrain.SetBitmapFromFile(_T(IDB_HELP_TRAIN_UP), _T(IDB_HELP_TRAIN_DN));

    m_btnCrew.SetWindowPos(NULL, 52-2, 226-57, 263, 40, TRUE);
	m_btnCrew.SetBitmapFromFile(_T(IDB_HELP_CREW_UP), _T(IDB_HELP_CREW_DN));

    m_btnRoute.SetWindowPos(NULL, 52-2, 283-57, 263, 40, TRUE);
	m_btnRoute.SetBitmapFromFile(_T(IDB_HELP_ROUTE_UP), _T(IDB_HELP_ROUTE_DN));

    m_btnConfig.SetWindowPos(NULL, 335-2, 113-57, 263, 40, TRUE);
	m_btnConfig.SetBitmapFromFile(_T(IDB_HELP_CONFIG_UP), _T(IDB_HELP_CONFIG_DN));

    m_btnCheck.SetWindowPos(NULL, 335-2, 169-57, 263, 40, TRUE);
	m_btnCheck.SetBitmapFromFile(_T(IDB_HELP_CHECK_UP), _T(IDB_HELP_CHECK_DN));

    m_btnPei.SetWindowPos(NULL, 335-2, 226-57, 263, 40, TRUE);
    m_btnPei.SetBitmapFromFile(_T(IDB_HELP_PEI_UP), _T(IDB_HELP_PEI_DN));

	m_btnMessage.SetWindowPos(NULL, 335-2, 283-57, 263, 40, TRUE);
    m_btnMessage.SetBitmapFromFile(_T(IDB_HELP_FORM_UP), _T(IDB_HELP_FORM_DN));

	m_stcVersion.SetFontSize(15);
	m_stcVersion.SetFontBold(TRUE);
	m_stcVersion.SetBkColor(RGB(255, 255, 255));

	m_stcTitle.SetFontSize(20);
	m_stcTitle.SetFontBold(TRUE);
	m_stcTitle.SetBkColor(RGB(255, 255, 255));

	LOGFONT	lfFont;

	lfFont.lfHeight = 22;
	lfFont.lfWidth = 0; 
	lfFont.lfEscapement = 0; 
	lfFont.lfOrientation = 0; 
	lfFont.lfWeight = FW_NORMAL; 
	lfFont.lfItalic = FALSE; 
	lfFont.lfUnderline = FALSE; 
	lfFont.lfStrikeOut = FALSE; 
	lfFont.lfOutPrecision = OUT_DEFAULT_PRECIS; 
	lfFont.lfClipPrecision = CLIP_DEFAULT_PRECIS; 
	lfFont.lfQuality = DEFAULT_QUALITY; 
	lfFont.lfPitchAndFamily = DEFAULT_PITCH;


    m_ftEdit.CreateFontIndirect(&lfFont);

	m_edtContent.SetFont(&m_ftEdit);
    
	VS_FIXEDFILEINFO vfi;
	CString strVersion("SW Ver : 00.00.00.00");

	if(GetFileVersion(_T("\\NandFlash\\AnCCP_MFC.exe"), vfi))
	{
		strVersion.Format(_T("SW Ver : %02d.%02d.%02d.%02d"), HIWORD(vfi.dwFileVersionMS), LOWORD(vfi.dwFileVersionMS), HIWORD(vfi.dwFileVersionLS), LOWORD(vfi.dwFileVersionLS));
	}

	m_stcVersion.SetWindowTextW(strVersion); 

	LoadHelpData();

	SetShowMode(SHOW_MODE_MENU);

	return TRUE;  // return TRUE unless you set the focus to a control
	// 예외: OCX 속성 페이지는 FALSE를 반환해야 합니다.
}

BOOL CPageHelp::GetFileVersion(LPWSTR lpFilePath, VS_FIXEDFILEINFO &rFi)
{
	DWORD dwHandle;
	BOOL bResult = FALSE;
	
	HMODULE hModule = GetModuleHandle(lpFilePath);
	DWORD dwLen = ::GetFileVersionInfoSize(lpFilePath, &dwHandle);

	FillMemory(&rFi, sizeof(VS_FIXEDFILEINFO), 0x00);
		
	if(dwLen)
	{
		LPSTR lpData = new CHAR[dwLen];

		if(GetFileVersionInfo(lpFilePath, dwHandle, dwLen, lpData))
		{
			UINT uLen;
			PVOID voidData;
			
			if(VerQueryValue(lpData, TEXT("\\"), &voidData, &uLen))
			{
				CopyMemory(&rFi, voidData, sizeof(VS_FIXEDFILEINFO));
				bResult = TRUE;
			}
		}

		delete [] lpData;
	}

	return bResult;
}

void	CPageHelp::LoadHelpData()
{
	FILE	*file;
	char	buffer[512];
	CString	strBuffer;

	file = fopen( HELP_CONTENT_PATH, "r");

	if( file == NULL )
	{
		return;
	}

	ZeroMemory(buffer, 512);

	while( fgets(buffer, 512, file) )
	{
		_MBtoWC(buffer, strBuffer);

		strBuffer.Trim();
		strBuffer.Append( _T("\r\n") );
		
		m_strHelpContent.Append(strBuffer);

		ZeroMemory(buffer, 512);
	}

	fclose(file);
}

BOOL CPageHelp::OnEraseBkgnd(CDC* pDC)
{
	pDC->BitBlt(0, 0, 644, 318, m_pBGDC, 0, 0, SRCCOPY);
	return 0;
}

void CPageHelp::OnClick_Menu(UINT	nID)
{
 		 if( nID == IDC_BTN_HOME )		SetShowMode(SHOW_MODE_HOME);	
	else if( nID == IDC_BTN_TRAIN )		SetShowMode(SHOW_MODE_TRAIN);
	else if( nID == IDC_BTN_CREW )		SetShowMode(SHOW_MODE_CREW);
	else if( nID == IDC_BTN_ROUTE )		SetShowMode(SHOW_MODE_ROUTE);
	else if( nID == IDC_BTN_CONFIG )	SetShowMode(SHOW_MODE_CONFIG);
	else if( nID == IDC_BTN_CHECK )		SetShowMode(SHOW_MODE_CHECK);
	else if( nID == IDC_BTN_PEI )		SetShowMode(SHOW_MODE_PEI);
	else if( nID == IDC_BTN_MESSAGE )
	{
		SetShowMode(SHOW_MODE_MESSAGE);
		return;
	}
}

void CPageHelp::SetShowMode(UINT nShowMode)
{
	m_nShowMode = nShowMode;

	if(m_nShowMode == SHOW_MODE_MENU )
	{
		m_btnHome.ShowWindow(SW_SHOW);
		m_btnTrain.ShowWindow(SW_SHOW);
		m_btnCrew.ShowWindow(SW_SHOW);
		m_btnRoute.ShowWindow(SW_SHOW);
		m_btnConfig.ShowWindow(SW_SHOW);
		m_btnCheck.ShowWindow(SW_SHOW);
		m_btnPei.ShowWindow(SW_SHOW);
		m_btnMessage.ShowWindow(SW_SHOW);
		m_stcVersion.ShowWindow(SW_SHOW);

		m_stcTitle.ShowWindow(SW_HIDE);
		m_edtContent.ShowWindow(SW_HIDE);
	}
	else
	{
		int	nStartIdx = 0, nFinishIdx = 0;
		CString	strFind;
		if( m_nShowMode == SHOW_MODE_HOME )
		{
			strFind = _T("#HOME");
			m_stcTitle.SetWindowText( _T("HOME") );

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_HONE);
		}
		else 
		if( m_nShowMode == SHOW_MODE_TRAIN )
		{
			strFind = _T("#ROUTE");
			m_stcTitle.SetWindowText( _T("ROUTE") );

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_TRAIN);
		}
		else 
		if( m_nShowMode == SHOW_MODE_CREW )
		{
			strFind = _T("#CREW");
			m_stcTitle.SetWindowText( _T("CREW") );

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_CREW);
		}
		else 
		if( m_nShowMode == SHOW_MODE_ROUTE )
		{
			strFind = _T("#STOPS");
			m_stcTitle.SetWindowText( _T("STOPS") );

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_ROUTE);
		}
		else 
		if( m_nShowMode == SHOW_MODE_CONFIG )
		{
			strFind = _T("#CONFIG");
			m_stcTitle.SetWindowText( _T("CONFIG") );

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_CONFIG);
		}
		else 
		if( m_nShowMode == SHOW_MODE_CHECK )
		{
			strFind = _T("#CHECK");
			m_stcTitle.SetWindowText( _T("CHECK") );

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_CHECK);
		}
		else 
		if( m_nShowMode == SHOW_MODE_PEI )
		{
			strFind = _T("#PEI");
			m_stcTitle.SetWindowText( _T("PEI") );

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_PEI);
		}
		else 
		if( m_nShowMode == SHOW_MODE_MESSAGE )
		{
			strFind = _T("#CM");
			m_stcTitle.SetWindowText(_T("CM"));

			m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_HELP_MESSAGE);
		}

		nStartIdx = m_strHelpContent.Find( strFind );
		nStartIdx += _tcslen( strFind );

		nFinishIdx = m_strHelpContent.Find( _T("#"), nStartIdx );

		CString strContent = m_strHelpContent.Mid( nStartIdx, nFinishIdx - nStartIdx );

		m_edtContent.SetWindowText( strContent );

		m_btnHome.ShowWindow(SW_HIDE);
		m_btnTrain.ShowWindow(SW_HIDE);
		m_btnCrew.ShowWindow(SW_HIDE);
		m_btnRoute.ShowWindow(SW_HIDE);
		m_btnConfig.ShowWindow(SW_HIDE);
		m_btnCheck.ShowWindow(SW_HIDE);
		m_btnPei.ShowWindow(SW_HIDE);
		m_btnMessage.ShowWindow(SW_HIDE);
		m_stcVersion.ShowWindow(SW_HIDE);

		m_stcTitle.ShowWindow(SW_SHOW);
		m_edtContent.ShowWindow(SW_SHOW);
	}
}

void CPageHelp::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		SetShowMode(SHOW_MODE_MENU);	
	}
}

HBRUSH CPageHelp::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
	HBRUSH hbr = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);

	pDC->SetBkColor(RGB(255, 255, 255));
    pDC->SetTextColor(RGB(0, 0,0));   
	
	return (HBRUSH)m_brsEditBG;
}
