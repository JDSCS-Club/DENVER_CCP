// CCPDlg.cpp : 구현 파일
//

#include "stdafx.h"
#include "CCP.h"
#include "CCPDlg.h"

#include "winioctl.h"
#include "winuser.h"

extern "C"
{
	BOOL WINAPI TouchCalibrate(void);
}

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#define TIMER_UPDATE_STATE				(1)
#define	TIMER_HARD_DETECT				(2)
#define	TIMER_SIMULATION				(3)
#define	TIMER_UPDATE_CAPTION			(4)
#define	TIMER_CROSS_TIME				(5)
#define	TIMER_SERIAL_THREAD				(6)
#define	TIMER_SERIAL_STATUS				(7)
#define	TIMER_AGENT						(8)
#define	TIMER_INVALID_PASSWORD			(9)

#define	TIMER_TEST						(999)

//
// EXS Driver IOCTLS
//
#define FILE_DEVICE_EXS			FILE_DEVICE_CONTROLLER

#define IOCTL_EXS_GET_CABON		CTL_CODE(FILE_DEVICE_EXS, 0, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define IOCTL_EXS_GET_CONKEY	CTL_CODE(FILE_DEVICE_EXS, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)    
#define IOCTL_EXS_GET_ADDR1		CTL_CODE(FILE_DEVICE_EXS, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)   
#define IOCTL_EXS_GET_ADDR2		CTL_CODE(FILE_DEVICE_EXS, 4, METHOD_BUFFERED, FILE_ANY_ACCESS)   

// CCCPDlg 대화 상자

CCCPDlg::CCCPDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCCPDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

	m_nCaptionIndex = 0;

	// 
	m_crStatus = GetSysColor(COLOR_WINDOWTEXT);

	m_lfStatus.lfHeight = -14;
	m_lfStatus.lfWidth = 0; 
	m_lfStatus.lfEscapement = 0; 
	m_lfStatus.lfOrientation = 0; 
	m_lfStatus.lfWeight = FW_BOLD; 
	m_lfStatus.lfItalic = FALSE; 
	m_lfStatus.lfUnderline = FALSE; 
	m_lfStatus.lfStrikeOut = FALSE; 
	m_lfStatus.lfOutPrecision = OUT_DEFAULT_PRECIS; 
	m_lfStatus.lfClipPrecision = CLIP_DEFAULT_PRECIS; 
	m_lfStatus.lfQuality = DEFAULT_QUALITY; 
	m_lfStatus.lfPitchAndFamily = DEFAULT_PITCH;
	wcscpy(m_lfStatus.lfFaceName, _T("MS Shell Dlg") );

    m_ftStatus.CreateFontIndirect(&m_lfStatus);

	//m_rectStatus[0].SetRect( 730, 137, 792, 154 );
	m_rectStatus[0].SetRect( 730, 70+80, 792, 87+80 );

	for(int i=0; i<14; i++)
	{
		m_rectStatus[i].SetRect( 730, m_rectStatus[0].top + (i*18), 
								 792, m_rectStatus[0].bottom + (i*18) );
	}


	//	
	m_crSchedule = GetSysColor(COLOR_WINDOWTEXT);

	memcpy( &m_lfSchedule, &m_lfStatus, sizeof(LOGFONTW) );

	m_lfSchedule.lfHeight = -26;
	m_ftSchedule.CreateFontIndirect(&m_lfSchedule);

	m_lfSchedule.lfHeight = -21;
	m_ftRoute.CreateFontIndirect(&m_lfSchedule);

	m_rectSchedule[ 0].SetRect(  12,  10, 338,  46 );
	m_rectSchedule[ 1].SetRect( 346,  10, 441,  46 );
	m_rectSchedule[ 2].SetRect( 449,  10, 505,  46 );
	m_rectSchedule[ 3].SetRect( 513,  10, 660,  46 );
	m_rectSchedule[ 4].SetRect( 660,  10, 787,  46 );
	m_rectSchedule[ 5].SetRect(  25, 127, 449, 163 );
	m_rectSchedule[ 6].SetRect( 455, 127, 553, 163 );
	m_rectSchedule[ 7].SetRect( 558, 127, 623, 163 );
	m_rectSchedule[ 8].SetRect(  25, 205, 449, 241 );
	m_rectSchedule[ 9].SetRect( 455, 205, 553, 241 );
	m_rectSchedule[10].SetRect( 558, 205, 623, 241 );
	m_rectSchedule[11].SetRect(  25, 283, 449, 319 );
	m_rectSchedule[12].SetRect( 455, 283, 553, 319 );
	m_rectSchedule[13].SetRect( 558, 283, 623, 319 );
	m_rectSchedule[14].SetRect( 656,  68, 792, 104 );
	m_rectSchedule[15].SetRect( 656, 104, 792, 140 );

	m_nCrossTime = 0;

	m_bReceiveState = TRUE;

	m_bActiveCalibration = FALSE;

	m_nPassword = 0;
}

void CCCPDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);

	DDX_Control(pDX, IDC_BTN_HOME,		m_btnMenu[0]);
	DDX_Control(pDX, IDC_BTN_TRAIN,		m_btnMenu[1]);
	DDX_Control(pDX, IDC_BTN_CREW,		m_btnMenu[2]);
	DDX_Control(pDX, IDC_BTN_ROUTE,		m_btnMenu[3]);
	DDX_Control(pDX, IDC_BTN_CONFIG,	m_btnMenu[4]);
	DDX_Control(pDX, IDC_BTN_CHECK,		m_btnMenu[5]);
	DDX_Control(pDX, IDC_BTN_HELP,		m_btnMenu[6]);
	DDX_Control(pDX, IDC_BTN_PEI,		m_btnMenu[7]);
	DDX_Control(pDX, IDC_BTN_CM,		m_btnMenu[8]);
}

BEGIN_MESSAGE_MAP(CCCPDlg, CDialog)
#if defined(_DEVICE_RESOLUTION_AWARE) && !defined(WIN32_PLATFORM_WFSP)
	ON_WM_SIZE()
#endif
	//}}AFX_MSG_MAP
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_HOME, IDC_BTN_CM,   &CCCPDlg::OnClick_Menu)
	ON_WM_ERASEBKGND()
	ON_WM_CLOSE()
	ON_WM_LBUTTONDOWN()
	ON_WM_TIMER()
	ON_MESSAGE(WM_FROM_PAGE_NUMBER, &CCCPDlg::OnMsg_FromPageNumber)
	ON_MESSAGE(WM_FROM_PAGE_CONFIG, &CCCPDlg::OnMsg_FromPageConfig)
	ON_MESSAGE(WM_CAPTION_SET, &CCCPDlg::OnMsg_CaptionSet)
	ON_MESSAGE(WM_TOUCH_LCD, &CCCPDlg::OnMsg_TouchLCD)
	ON_MESSAGE(WM_START_TOUCH_CAL, &CCCPDlg::OnMsg_StartTouchCalibration)
	ON_MESSAGE(WM_STOP_TOUCH_CAL, &CCCPDlg::OnMsg_StopTouchCalibration)
	ON_MESSAGE(WM_UPDATE, &CCCPDlg::OnMsg_Update)
	ON_MESSAGE(WM_SET_CROSS_TIME, &CCCPDlg::OnMsg_CrossTime)
	ON_MESSAGE(WM_SET_ROUTE, &CCCPDlg::OnMsg_SetRoute)
	ON_MESSAGE(WM_SET_CREWID, &CCCPDlg::OnMsg_SetCrewID)
	ON_WM_PAINT()
	ON_WM_DESTROY()
END_MESSAGE_MAP()


// CCCPDlg 메시지 처리기

BOOL CCCPDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// CheckMemoryUsage();

	// 이 대화 상자의 아이콘을 설정합니다. 응용 프로그램의 주 창이 대화 상자가 아닐 경우에는
	//  프레임워크가 이 작업을 자동으로 수행합니다.
	SetIcon(m_hIcon, TRUE);			// 큰 아이콘을 설정합니다.
	SetIcon(m_hIcon, FALSE);		// 작은 아이콘을 설정합니다.

	MoveWindow(0, 0, 800, 480, TRUE);
	SetWindowPos(&CWnd::wndTopMost,  0, 0, 800, 480, SWP_NOMOVE|SWP_NOSIZE);
	
	SetConfigDefault();
	ReadPassword();

	m_Route.LoadCM();

	InitButton();

	LoadBmp();

	m_hGPI = CreateFile(L"GPI1:", GENERIC_READ , FILE_SHARE_READ , NULL, OPEN_EXISTING, 0, 0);
	DetectHardware();

	InitTimer();

	// PAGES
	m_pPageNumber = new CPageNumber(this);
	if(m_pPageNumber->Create(CPageNumber::IDD, this)== FALSE) return false;

	m_pPageRoute = new CPageRoute(this); //2
	if(m_pPageRoute->Create(CPageRoute::IDD, this)== FALSE) return false;

	m_pPageConfig = new CPageConfig(this); //3
	if(m_pPageConfig->Create(CPageConfig::IDD, this)== FALSE) return false;

	m_pPageHelp = new CPageHelp(this);
	if(m_pPageHelp->Create(CPageHelp::IDD, this)== FALSE) return false;

	m_pPagePR = new CPagePR(this);
	if( m_pPagePR->Create(CPagePR::IDD, this) == FALSE ) return false;

	m_pPageCar = new CPageCar(this);
	if(m_pPageCar->Create(CPageCar::IDD, this)== FALSE) return false;

	m_pPageCI = new CPageCI(this);
	if(m_pPageCI->Create(CPageCI::IDD, this)== FALSE) return false;

	m_mgrPage.AddPage(PAGE_ID_HOME,		this);
	m_mgrPage.AddPage(PAGE_ID_TRAIN,	m_pPageNumber);
	m_mgrPage.AddPage(PAGE_ID_ROUTE,	m_pPageRoute);
	m_mgrPage.AddPage(PAGE_ID_CONFIG,	m_pPageConfig);
	m_mgrPage.AddPage(PAGE_ID_CHECK,	m_pPageCar);
	m_mgrPage.AddPage(PAGE_ID_HELP,		m_pPageHelp);	
	m_mgrPage.AddPage(PAGE_ID_CM,		m_pPagePR);
	m_mgrPage.AddPage(PAGE_ID_CI,		m_pPageCI);

	RedrawButton( PAGE_ID_HOME );

	wcscpy(m_arrCaption[CAPTION_HOME],					_T("In Service") );
	wcscpy(m_arrCaption[CAPTION_TRAIN],					_T("Enter Route Number") );	
	wcscpy(m_arrCaption[CAPTION_CREW],					_T("Enter Crew ID") );	
	wcscpy(m_arrCaption[CAPTION_ROUTE],					_T("STOPS") );
	wcscpy(m_arrCaption[CAPTION_CONFIG],				_T("CONFIG") );
	wcscpy(m_arrCaption[CAPTION_CHECK],					_T("CHECK") );
	wcscpy(m_arrCaption[CAPTION_HELP],					_T("HELP") );
	wcscpy(m_arrCaption[CAPTION_PEI],					_T("PEI") );
	wcscpy(m_arrCaption[CAPTION_MESSAGE],				_T("CAB TEXT MESSAGE") );
	wcscpy(m_arrCaption[CAPTION_CM],					_T("PRESET CUSTOM MESSAGES") );
	wcscpy(m_arrCaption[CAPTION_INPUT_TRAIN],			_T("Press Route to Enter Route Number") );	
	wcscpy(m_arrCaption[CAPTION_INPUT_CREW],			_T("Press CREW to Enter Crew ID") );	
	wcscpy(m_arrCaption[CAPTION_CONFIG_LCD],			_T("CONFIG / LCD DIMMER") );
	wcscpy(m_arrCaption[CAPTION_CONFIG_SPEAKER],		_T("CONFIG / SPEAKER VOLUME") );
	wcscpy(m_arrCaption[CAPTION_CONFIG_RESET],			_T("CONFIG / SYSTEM RESET") );
	wcscpy(m_arrCaption[CAPTION_CONFIG_SIMULATON],		_T("CONFIG / SIMULATION") );
	wcscpy(m_arrCaption[CAPTION_CONFIG_CI],				_T("CONFIG / C/I SETTING") );
	wcscpy(m_arrCaption[CAPTION_CONFIG_PASSWORD],		_T("Enter current password") );
	wcscpy(m_arrCaption[CAPTION_CONFIG_INVALID_PASSWORD],	_T("Password is Invalid") );
	wcscpy(m_arrCaption[CAPTION_CONFIG_NEW_PASSWORD],	_T("Enter new password") );

	wcscpy(m_arrCaption[CAPTION_HELP_HONE],				_T("HELP / HOME") );
	wcscpy(m_arrCaption[CAPTION_HELP_TRAIN],			_T("HELP / ROUTE") );			
	wcscpy(m_arrCaption[CAPTION_HELP_CREW],				_T("HELP / CREW") );				
	wcscpy(m_arrCaption[CAPTION_HELP_ROUTE],			_T("HELP / STOPS") );			
	wcscpy(m_arrCaption[CAPTION_HELP_CONFIG],			_T("HELP / CONFIG") );			
	wcscpy(m_arrCaption[CAPTION_HELP_CHECK],			_T("HELP / CHECK") );		
	wcscpy(m_arrCaption[CAPTION_HELP_PEI],				_T("HELP / PEI") );			
	wcscpy(m_arrCaption[CAPTION_HELP_MESSAGE],			_T("HELP / CUSTOM MESSAGES") );	

	wcscpy(m_arrCaption[CAPTION_PEI_CALL],				_T("HOME") );
	wcscpy(m_arrCaption[CAPTION_INAUGRATION],			_T("Inauguration in progress") );
	wcscpy(m_arrCaption[CAPTION_INAUGRATION_COMLETE],	_T("Inauguration complete") );
	wcscpy(m_arrCaption[CAPTION_CABON],					_T("Cab is not active") );
	wcscpy(m_arrCaption[CAPTION_CABON2],				_T("Please activate the cab to operate") );
	wcscpy(m_arrCaption[CAPTION_TRAIN_NUMBER],			_T("") );
	wcscpy(m_arrCaption[CAPTION_TRAIN_NUMBER_OK],		_T("Train number OK") );
	wcscpy(m_arrCaption[CAPTION_TRAIN_NUMBER_FAIL],		_T("Train number Is Invalid") );
	wcscpy(m_arrCaption[CAPTION_SIMULATION],			_T("Simulation in progress") );
	wcscpy(m_arrCaption[CAPTION_CI],					_T("Index number is Invalid") );

	// UpdateButtonState( m_mgrPage.GetCurrentPage() );

	return TRUE;  // 포커스를 컨트롤에 설정하지 않으면 TRUE를 반환합니다.
}

#if defined(_DEVICE_RESOLUTION_AWARE) && !defined(WIN32_PLATFORM_WFSP)
void CCCPDlg::OnSize(UINT /*nType*/, int /*cx*/, int /*cy*/)
{
	if (AfxIsDRAEnabled())
	{
		DRA::RelayoutDialog(
			AfxGetResourceHandle(), 
			this->m_hWnd, 
			DRA::GetDisplayMode() != DRA::Portrait ? 
			MAKEINTRESOURCE(IDD_CCP_DIALOG_WIDE) : 
			MAKEINTRESOURCE(IDD_CCP_DIALOG));
	}
}
#endif

void CCCPDlg::InitSerial(void)
{
	m_pSerial = (CSerial *) AfxBeginThread(	RUNTIME_CLASS(CSerial), 
										THREAD_PRIORITY_ABOVE_NORMAL,
										0,
										CREATE_SUSPENDED );

	if( m_pSerial )
	{
		m_pSerial->m_bAutoDelete = TRUE;

		m_pSerial->SetParent(this);

		if( m_pSerial->OpenPort()  )
		{
			m_pSerial->Flush(TRUE, TRUE);
			m_pSerial->ResumeThread();
		}
	}

	m_dwTickRecv = ::GetTickCount();
}

void CCCPDlg::InitButton(void)
{
	//m_btnMenu[0].SetPushButton();
	m_btnMenu[0].SetWindowPos(NULL, 0, 423, 100, 57, TRUE);   
    m_btnMenu[0].SetBitmapFromFile(_T(IDB_MAIN_HOME_UP), _T(IDB_MAIN_HOME_DN));
 
	//m_btnMenu[1].SetPushButton();
    m_btnMenu[1].SetWindowPos(NULL, 88*1, 423, 100, 57, TRUE);
	m_btnMenu[1].SetBitmapFromFile(_T(IDB_MAIN_TRAIN_UP), _T(IDB_MAIN_TRAIN_DN));

	//m_btnMenu[2].SetPushButton();
    m_btnMenu[2].SetWindowPos(NULL, 88*2, 423, 100, 57, TRUE);
	m_btnMenu[2].SetBitmapFromFile(_T(IDB_MAIN_CREW_UP), _T(IDB_MAIN_CREW_DN));

	//m_btnMenu[3].SetPushButton();
    m_btnMenu[3].SetWindowPos(NULL, 88*3, 423, 100, 57, TRUE);
	m_btnMenu[3].SetBitmapFromFile(_T(IDB_MAIN_ROUTE_UP), _T(IDB_MAIN_ROUTE_DN));

	//m_btnMenu[4].SetPushButton();
    m_btnMenu[4].SetWindowPos(NULL, 88*4, 423, 100, 57, TRUE);
	m_btnMenu[4].SetBitmapFromFile(_T(IDB_MAIN_CONFIG_UP), _T(IDB_MAIN_CONFIG_DN));
    
	//m_btnMenu[5].SetPushButton();
    m_btnMenu[5].SetWindowPos(NULL, 88*5, 423, 100, 57, TRUE);
	m_btnMenu[5].SetBitmapFromFile(_T(IDB_MAIN_CHECK_UP), _T(IDB_MAIN_CHECK_DN));

	//m_btnMenu[7].SetPushButton();
    //m_btnMenu[7].SetWindowPos(NULL, 88*7, 423, 100, 57, TRUE);
	m_btnMenu[7].SetWindowPos(NULL, 88*6, 423, 100, 57, TRUE);
	m_btnMenu[7].SetBitmapFromFile( _T(IDB_MAIN_PEI_UP), _T(IDB_MAIN_PEI_DN), _T(IDB_MAIN_PEI_OR) );

    //m_btnMenu[8].SetWindowPos(NULL, 88*8, 423, 100, 57, TRUE);
	m_btnMenu[8].SetWindowPos(NULL, 88*7, 423, 100, 57, TRUE);
	m_btnMenu[8].SetBitmapFromFile( _T(IDB_MAIN_PR_UP), _T(IDB_MAIN_PR_DN));

	//m_btnMenu[6].SetPushButton();
	//m_btnMenu[6].SetWindowPos(NULL, 88*6, 423, 100, 57, TRUE);
	m_btnMenu[6].SetWindowPos(NULL, 88*8, 423, 100, 57, TRUE);
	m_btnMenu[6].SetBitmapFromFile(_T(IDB_MAIN_HELP_UP), _T(IDB_MAIN_HELP_DN));
}

void CCCPDlg::InitTimer(void)
{
	SetTimer(TIMER_UPDATE_STATE, 1000, NULL);
	SetTimer(TIMER_HARD_DETECT, 100, NULL);
	SetTimer(TIMER_UPDATE_CAPTION, 1000, NULL);
	SetTimer(TIMER_SERIAL_THREAD, 3000, NULL);
	//SetTimer(TIMER_SERIAL_STATUS, 5000, NULL);
	SetTimer(TIMER_AGENT, 5000, NULL);

	// FOR TEST
	//m_Route.SetTrainNumber( 200 );
	//m_Route.SetCrewID( 8 );
	//m_Route.SetRoute();
	//StartSimulation();

	// FOR TEST
	//SetTimer(TIMER_TEST, 500, NULL);
	
	// FOR TEST
	SetTimer( TIMER_CROSS_TIME, 10000, NULL );
}

void CCCPDlg::DeinitTimer(void)
{
	KillTimer(TIMER_UPDATE_STATE);
	KillTimer(TIMER_HARD_DETECT);
	KillTimer(TIMER_UPDATE_CAPTION);
	KillTimer(TIMER_CROSS_TIME);
	KillTimer(TIMER_SERIAL_STATUS);

	// FOR TEST
	//KillTimer(TIMER_SIMULATION);
	//KillTimer(TIMER_TEST);
}

void CCCPDlg::LoadBmp(void)
{
	CPaintDC	dc(this);

	m_dcBoxType1.SetBitmap( _T("\\NandFlash\\res\\BG_BOX_TYPE1.bmp") );

	m_dcBoxType2.SetBitmap( _T("\\NandFlash\\res\\BG_BOX_TYPE2.bmp") );

	m_dcBoxTypeUpdate.SetBitmap( _T("\\NandFlash\\res\\BG_BOX_TYPE_UPDATE.bmp") );

	m_dcMainText.SetBitmap( _T("\\NandFlash\\res\\BG_MAIN_TEXT.bmp") );

	m_dcNumberPad.SetBitmap( _T("\\NandFlash\\res\\BG_NUMBER_PAD.bmp") );

	m_dcSpeakerText.SetBitmap( _T("\\NandFlash\\res\\BG_SPEAKER_TEXT.bmp") );

	m_dcLCDBar.SetBitmap( _T("\\NandFlash\\res\\BG_LCD_BAR.bmp") );

	m_dcCar.SetBitmap( _T("\\NandFlash\\res\\BG_CAR.bmp") );

	m_dcCarCI.SetBitmap( _T("\\NandFlash\\res\\ci_car_bg.bmp") );

	m_dcLED[0].SetBitmap( _T("\\NandFlash\\res\\LED_GREEN_B.bmp") );
	m_dcLED[1].SetBitmap( _T("\\NandFlash\\res\\LED_GREEN_W.bmp") );
	m_dcLED[2].SetBitmap( _T("\\NandFlash\\res\\LED_RED_B.bmp") );
	m_dcLED[3].SetBitmap( _T("\\NandFlash\\res\\LED_RED_W.bmp") );

	m_dcMainBG.MakeBitmap(800, 480, 8);

	m_dcPageBG[0].MakeBitmap(644, 318, 8);
	m_dcPageBG[1].MakeBitmap(644, 318, 8);
	m_dcPageBG[2].MakeBitmap(644, 318, 8);
	m_dcPageBG[3].MakeBitmap(644, 318, 8);
	m_dcPageBG[4].MakeBitmap(644, 318, 8);
	m_dcPageBG[5].MakeBitmap(644, 318, 8);
	m_dcPageBG[6].MakeBitmap(644, 318, 8);
	m_dcPageBG[7].MakeBitmap(644, 364, 8);
	m_dcPageBG[8].MakeBitmap(644, 318, 8);

	MakeBG( m_dcMainBG.GetDC() );
	MakeBaseBG( m_dcPageBG[0].GetDC() );
	MakeNumberBG( m_dcPageBG[1].GetDC() );
	MakeRouteBG( m_dcPageBG[2].GetDC() );
	MakeConfigSpeakerBG( m_dcPageBG[3].GetDC() );
	MakeConfigLCDBG( m_dcPageBG[4].GetDC() );
	MakeCarBG( m_dcPageBG[5].GetDC() );
	MakeCIBG( m_dcPageBG[6].GetDC() );
	MakeUpdateBG( m_dcPageBG[7].GetDC() );
	MakePRBG( m_dcPageBG[8].GetDC() );


	m_dcBufferBG.CreateCompatibleDC( &dc );
	m_bmpBufferBG.CreateBitmap(800, 480, 1, 8, NULL);
	m_dcBufferBG.SelectObject( &m_bmpBufferBG );

	m_dcCaptionBG.SetBitmap( _T("\\NandFlash\\res\\CAPTION_BOX.bmp") );

	LOGFONT lf;
	lf.lfHeight = 30;
	lf.lfWidth = 0; 
	lf.lfEscapement = 0; 
	lf.lfOrientation = 0; 
	lf.lfWeight = FW_EXTRABOLD; 
	lf.lfItalic = FALSE; 
	lf.lfUnderline = FALSE; 
	lf.lfStrikeOut = FALSE; 
	lf.lfOutPrecision = OUT_DEFAULT_PRECIS; 
	lf.lfClipPrecision = CLIP_DEFAULT_PRECIS; 
	lf.lfQuality = DEFAULT_QUALITY; 
	lf.lfPitchAndFamily = DEFAULT_PITCH;

    wcscpy_s(lf.lfFaceName, 32, TEXT("Tahoma"));
    
	m_ftCaption.CreateFontIndirect(&lf);
}

void CCCPDlg::UnloadBmp(void)
{
	for(int i=0; i<9; i++) m_btnMenu[i].FreeResource();

	m_dcMainBG.FreeResource();

	for(int i=0; i<9; i++) m_dcPageBG[i].FreeResource();

	m_dcCaptionBG.FreeResource();

	m_dcBoxType1.FreeResource();
	m_dcBoxType2.FreeResource();
	m_dcBoxTypeUpdate.FreeResource();
	m_dcMainText.FreeResource();
	m_dcNumberPad.FreeResource();
	m_dcSpeakerText.FreeResource();
	m_dcLCDBar.FreeResource();
	m_dcCar.FreeResource();
	m_dcCarCI.FreeResource();
	m_dcLED[0].FreeResource();
	m_dcLED[1].FreeResource();
	m_dcLED[2].FreeResource();
	m_dcLED[3].FreeResource();

	m_dcBufferBG.DeleteDC();
	m_bmpBufferBG.DeleteObject();

	m_ftStatus.DeleteObject();
	m_ftSchedule.DeleteObject();
	m_ftRoute.DeleteObject();
	m_ftCaption.DeleteObject();
}

void CCCPDlg::MakeBG(CDC *pDC)
{
	CRect	rect;
	CPen	pen, *oldPen;
	CBrush	brush;

	rect.SetRect(0, 0, 800, 480);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(3, 3, 645, 52);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	rect.SetRect(651, 3, 797, 52);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	rect.SetRect(3, 58, 645, 374);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//rect.SetRect(651, 125, 797, 420);
	rect.SetRect(651, 58, 797, 420);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	rect.SetRect(11, 10, 339, 46);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	rect.SetRect(345, 10, 442, 46);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	rect.SetRect(448, 10, 506, 46);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	// TRAIN
	rect.SetRect(656, 68, 792, 104);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	// CREW
	rect.SetRect(656, 104, 792, 140);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	//
	pen.CreatePen(PS_SOLID, 1, RGB(122,123,100));
	oldPen = pDC->SelectObject( &pen );

	for(int i=0; i<3; i++)
	{
		rect.SetRect( 22, 126+(i*78), 449, 163+(i*78));
		pDC->Rectangle(&rect);
		rect.SetRect(454, 126+(i*78), 552, 163+(i*78));
		pDC->Rectangle(&rect);
		rect.SetRect(557, 126+(i*78), 623, 163+(i*78));
		pDC->Rectangle(&rect);
	}

	//
	brush.DeleteObject();
	brush.CreateSolidBrush( RGB(188, 188, 188) );

	for(int i=0; i<14; i++)
	{
		CString str;

		//rect.SetRect(656, 137+(i*18), 792, 154+(i*18));
		rect.SetRect(656, 70+(i*18)+80, 792, 87+(i*18)+80 );


		if( ( i & 0x01 ) == 0x00 )
		{
			pDC->FillRect(&rect, &brush);
		}

		pDC->SelectObject( &m_ftStatus ); 
		pDC->SetTextColor(m_crStatus);
		pDC->SetBkMode(TRANSPARENT);

		rect.left += 2;

			 if( i ==  0 ) str = _T("GPS : ");
		else if( i ==  1 ) str = _T("WLAN : ");
		else if( i ==  2 ) str = _T("LIC : ");
		else if( i ==  3 ) str = _T("PAC : ");
		else if( i ==  4 ) str = _T("CNCS : ");
		else if( i ==  5 ) str = _T("VTX : ");
		else if( i ==  6 ) str = _T("LED PIS : ");
		else if( i ==  7 ) str = _T("LCD PIS : ");
		else if( i ==  8 ) str = _T("ESPK : ");
		else if( i ==  9 ) str = _T("CAB KEY : ");
		else if( i == 10 ) str = _T("CON KEY : ");
		else if( i == 11 ) str = _T("FORWARD : ");
		else if( i == 12 ) str = _T("REVERSE : ");
		else if( i == 13 ) str = _T("DOOR :  ");

		pDC->DrawText(str, &rect, DT_LEFT | DT_VCENTER | DT_SINGLELINE);
	}

	for(int i=0; i<3; i++)
	{
		pDC->BitBlt(23, 105+(i*78), m_dcMainText.Width(), 18, m_dcMainText.GetDC(), 0, 0+(i*18), SRCCOPY);
	}

	pDC->SelectObject( oldPen );

	brush.DeleteObject();
	pen.DeleteObject();
}	

void CCCPDlg::MakeBaseBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	brush.DeleteObject();
}

void CCCPDlg::MakeNumberBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	pDC->BitBlt(20, 34, 7, m_dcNumberPad.Height(), m_dcNumberPad.GetDC(), 0, 0, SRCCOPY);

	for(int i=0; i<23; i++)
	{
		if( i == 22 )
			pDC->BitBlt(27+(i*10), 34, 10, m_dcNumberPad.Height(), m_dcNumberPad.GetDC(), 17, 0, SRCCOPY);
		else
			pDC->BitBlt(27+(i*10), 34, 10, m_dcNumberPad.Height(), m_dcNumberPad.GetDC(), 7, 0, SRCCOPY);
	}

	brush.DeleteObject();
}	

void CCCPDlg::MakeRouteBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;
	CPen	pen, *oldPen;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	pDC->BitBlt(19, 15, m_dcMainText.Width(), 18, m_dcMainText.GetDC(), 0, 0, SRCCOPY);

	// 
	pen.CreatePen(PS_SOLID, 1, RGB(122,123,100));
	oldPen = pDC->SelectObject( &pen );

	for(int i=0; i<6; i++)
	{
		rect.SetRect(20, 36+(i*46), 241, 73+(i*46));
		pDC->Rectangle(&rect);
	}

	pDC->SelectObject( oldPen );

	brush.DeleteObject();
	pen.DeleteObject();
}

void CCCPDlg::MakeConfigSpeakerBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );
	pDC->FillRect(&rect, &brush);
	brush.DeleteObject();

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	rect.SetRect(10, 16, 633, 106);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);
	rect.SetRect(10, 114, 633, 204);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);
	rect.SetRect(10, 211, 632, 301);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	brush.CreateSolidBrush( RGB(254, 218, 76) );

	rect.SetRect(21, 23, 621, 58);
	pDC->FillRect(&rect, &brush);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	rect.SetRect(21, 122, 621, 156);
	pDC->FillRect(&rect, &brush);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	rect.SetRect(21, 219, 621, 255);
	pDC->FillRect(&rect, &brush);
	DrawBoxType2(pDC, m_dcBoxType2.GetDC(), &rect);

	//
	pDC->BitBlt(240, 32, m_dcSpeakerText.Width(), 21, m_dcSpeakerText.GetDC(), 0, 0, SRCCOPY);
	pDC->BitBlt(206, 130, m_dcSpeakerText.Width(), 21, m_dcSpeakerText.GetDC(), 0, 21, SRCCOPY);
	pDC->BitBlt(206, 227, m_dcSpeakerText.Width(), 21, m_dcSpeakerText.GetDC(), 0, 42, SRCCOPY);
}

void CCCPDlg::MakeConfigLCDBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );
	pDC->FillRect(&rect, &brush);
	brush.DeleteObject();

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	rect.SetRect(10, 141, 633, 193);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	for(int i=0; i<100; i++)
	{
		if( i == 0 )
			pDC->BitBlt(71+(i*5), 145, m_dcLCDBar.Width(), m_dcLCDBar.Height(), m_dcLCDBar.GetDC(), 0, 0, SRCCOPY);
		else if( i == 99 )
			pDC->BitBlt(71+(i*5), 145, m_dcLCDBar.Width(), m_dcLCDBar.Height(), m_dcLCDBar.GetDC(), 10, 0, SRCCOPY);
		else
			pDC->BitBlt(71+(i*5), 145, m_dcLCDBar.Width(), m_dcLCDBar.Height(), m_dcLCDBar.GetDC(), 5, 0, SRCCOPY);
	}
}

void CCCPDlg::MakeCarBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	CPen	pen;
	CString strCarNumber;

	pDC->SetBkMode(TRANSPARENT);
	pDC->SelectObject( &m_ftRoute ); 
	pDC->SetTextColor( RGB(188, 188, 188) );

	for(int i=0; i<3; i++)
	{
		for(int y=0; y<4; y++)
		{
			rect.SetRect( 12+(y*160),  25+(i*80), 152+(y*160),  65+(i*80) );
			strCarNumber.Format(_T("Car #%04d"), (i*4 + y + 1) );

			pDC->BitBlt(12+(y*160), 25+(i*80), 144, 51, m_dcCar.GetDC(), 0, 0, SRCCOPY);
			pDC->DrawText(strCarNumber, rect, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
		}
	}
}

void CCCPDlg::MakeMessageBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;
	CPen	pen, *oldPen;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	// pDC->BitBlt(19, 15, m_dcMainText.Width(), 18, m_dcMainText.GetDC(), 0, 0, SRCCOPY);

	// 
	pen.CreatePen(PS_SOLID, 1, RGB(122,123,100));
	oldPen = pDC->SelectObject( &pen );

	for(int i=0; i<6; i++)
	{
		rect.SetRect(15, 37+(i*45), 57, 74+(i*45));
		pDC->Rectangle(&rect);

		rect.SetRect(61, 37+(i*45), 327, 74+(i*45));
		pDC->Rectangle(&rect);
	}

	pDC->SelectObject( oldPen );
	pen.DeleteObject();
}

void CCCPDlg::MakeUpdateBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;

	rect.SetRect(0, 0, 644, 364);
	brush.CreateSolidBrush( RGB(255, 0, 0) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 363);
	DrawBoxType1(pDC, m_dcBoxTypeUpdate.GetDC(), &rect);

	brush.DeleteObject();
}

void CCCPDlg::MakePRBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;
	CPen	pen, *oldPen;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	// pDC->BitBlt(19, 15, m_dcMainText.Width(), 18, m_dcMainText.GetDC(), 0, 0, SRCCOPY);

	// 
	pen.CreatePen(PS_SOLID, 1, RGB(122,123,100));
	oldPen = pDC->SelectObject( &pen );

	for(int i=0; i<6; i++)
	{
		rect.SetRect(15, 37+(i*45), 57, 74+(i*45));
		pDC->Rectangle(&rect);

		rect.SetRect(61, 37+(i*45), 500, 74+(i*45));
		pDC->Rectangle(&rect);
	}

	pDC->SelectObject( oldPen );
	pen.DeleteObject();
}

void CCCPDlg::MakeCIBG(CDC *pDC)
{
	CRect	rect;
	CBrush	brush;

	rect.SetRect(0, 0, 644, 318);
	brush.CreateSolidBrush( RGB(255, 255, 255) );

	pDC->FillRect(&rect, &brush);

	//
	rect.SetRect(1, 1, 643, 317);
	DrawBoxType1(pDC, m_dcBoxType1.GetDC(), &rect);

	//
	CPen	pen;
	CString strCarNumber;

	pDC->SetBkMode(TRANSPARENT);
	pDC->SelectObject( &m_ftRoute ); 
	pDC->SetTextColor( RGB(188, 188, 188) );

	for(int i=0; i<2; i++)
	{
		for(int y=0; y<4; y++)
		{
			rect.SetRect( 12+(y*160), 38+(i*105), 152+(y*160),  78+(i*105) );
			strCarNumber.Format(_T("Car #%04d"), (i*4 + y + 1) );

			pDC->BitBlt(12+(y*160), 25+(i*105), 146, 74, m_dcCarCI.GetDC(), 0, 0, SRCCOPY);
			pDC->DrawText(strCarNumber, rect, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
		}
	}
}

void CCCPDlg::DrawBoxType1(CDC *pDestDC, CDC *pSrcDC, CRect *pRect)
{
	CPen pen, *oldPen;
	pen.CreatePen(PS_SOLID, 3, RGB(188,188,188));
	oldPen = pDestDC->SelectObject( &pen );

	//
	pDestDC->MoveTo( pRect->left + 11, pRect->top);
	pDestDC->LineTo( pRect->right - 11, pRect->top);

	pDestDC->MoveTo( pRect->left, pRect->top + 11);
	pDestDC->LineTo( pRect->left, pRect->bottom - 11);

	pDestDC->MoveTo( pRect->left + 11, pRect->bottom-1);
	pDestDC->LineTo( pRect->right - 11, pRect->bottom-1);

	pDestDC->MoveTo( pRect->right-1, pRect->top + 11);
	pDestDC->LineTo( pRect->right-1, pRect->bottom - 11);

	//
	pDestDC->BitBlt( pRect->left-1, pRect->top-1, 12, 12, pSrcDC, 0, 0, SRCCOPY);
	pDestDC->BitBlt( pRect->right-12+1, pRect->top-1, 12, 12, pSrcDC, 12, 0, SRCCOPY);
	pDestDC->BitBlt( pRect->left-1, pRect->bottom-12+1, 12, 12, pSrcDC, 24, 0, SRCCOPY);
	pDestDC->BitBlt( pRect->right-12+1, pRect->bottom-12+1, 12, 12, pSrcDC, 36, 0, SRCCOPY);

	pDestDC->SelectObject( oldPen );
	pen.DeleteObject();
}

void CCCPDlg::DrawBoxType2(CDC *pDestDC, CDC *pSrcDC, CRect *pRect)
{
	CPen pen, *oldPen;

	pen.CreatePen(PS_SOLID, 1, RGB(188,188,188));
	
	oldPen = pDestDC->SelectObject( &pen);

	//
	pDestDC->MoveTo( pRect->left + 2, pRect->top);
	pDestDC->LineTo( pRect->right - 2, pRect->top);

	pDestDC->MoveTo( pRect->left, pRect->top + 2);
	pDestDC->LineTo( pRect->left, pRect->bottom - 2);

	pDestDC->MoveTo( pRect->left + 2, pRect->bottom-1);
	pDestDC->LineTo( pRect->right - 2, pRect->bottom-1);

	pDestDC->MoveTo( pRect->right-1, pRect->top + 2);
	pDestDC->LineTo( pRect->right-1, pRect->bottom - 2);

	//
	pDestDC->BitBlt( pRect->left, pRect->top, 2, 2, pSrcDC, 0, 0, SRCCOPY);

	pDestDC->BitBlt( pRect->right-2, pRect->top, 2, 2, pSrcDC, 2, 0, SRCCOPY);

	pDestDC->BitBlt( pRect->left, pRect->bottom-2, 2, 2, pSrcDC, 4, 0, SRCCOPY);

	pDestDC->BitBlt( pRect->right-2, pRect->bottom-2, 2, 2, pSrcDC, 6, 0, SRCCOPY);

	pDestDC->SelectObject( oldPen);

	pen.DeleteObject();
}

void CCCPDlg::DrawCaptoinBG(CDC *pDestDC, CDC *pSrcDC, CRect *pRect)
{
	CPen		pen, *oldPen;
	CRect		rect;
	CBrush		brush;
	COLORREF	color;

	//UINT nCaptionBGIndex = m_mgrPage.GetCurrentPage() & 0x07;
	UINT nCaptionBGIndex = 0;

	switch( m_mgrPage.GetCurrentPage() )
	{
		case PAGE_ID_HOME:
			nCaptionBGIndex = 0;
			color = RGB(253, 102, 0);
			break;
		case PAGE_ID_TRAIN:
			nCaptionBGIndex = 1;
			color = RGB(204, 152, 254);
			break;
		case PAGE_ID_CREW:
			nCaptionBGIndex = 2;
			color = RGB(252, 156, 204);
			break;
		case PAGE_ID_ROUTE:
		case PAGE_ID_HELP:
			nCaptionBGIndex = 3;
			color = RGB(153, 204, 254);
			break;
		case PAGE_ID_CONFIG:
		case PAGE_ID_CI:
		case PAGE_ID_PASSWORD_CHECK:
		case PAGE_ID_PASSWORD_NEW:
		case PAGE_ID_PASSWORD_VOL:
		case PAGE_ID_PASSWORD_CI:
			nCaptionBGIndex = 4;
			color = RGB(254, 202, 2);
			break;
		case PAGE_ID_CHECK:
			nCaptionBGIndex = 5;
			color = RGB(254, 254, 0);
			break;
		case PAGE_ID_PEI:
			nCaptionBGIndex = 7;
			color = RGB(253, 0, 0);
			break;
		case PAGE_ID_CM:
			nCaptionBGIndex = 6;
			color = RGB(158, 215, 0);
			break;
	}


	pDestDC->FillSolidRect(pRect, color);

	//
	pen.CreatePen(PS_SOLID, 3, RGB(188,188,188));
	oldPen = pDestDC->SelectObject( &pen );

	pDestDC->MoveTo( pRect->left + 11, pRect->top+1);
	pDestDC->LineTo( pRect->right - 11, pRect->top+1);

	pDestDC->MoveTo( pRect->left+1, pRect->top + 11);
	pDestDC->LineTo( pRect->left+1, pRect->bottom - 11);

	pDestDC->MoveTo( pRect->left + 11, pRect->bottom-2);
	pDestDC->LineTo( pRect->right - 11, pRect->bottom-2);

	pDestDC->MoveTo( pRect->right-2, pRect->top + 11);
	pDestDC->LineTo( pRect->right-2, pRect->bottom - 11);

	//
	pDestDC->BitBlt( pRect->left, pRect->top, 12, 12, pSrcDC, 0, 0+(nCaptionBGIndex*12), SRCCOPY);

	pDestDC->BitBlt( pRect->right-12, pRect->top, 12, 12, pSrcDC, 12, 0+(nCaptionBGIndex*12), SRCCOPY);

	pDestDC->BitBlt( pRect->left, pRect->bottom-12, 12, 12, pSrcDC, 24, 0+(nCaptionBGIndex*12), SRCCOPY);

	pDestDC->BitBlt( pRect->right-12, pRect->bottom-12, 12, 12, pSrcDC, 36, 0+(nCaptionBGIndex*12), SRCCOPY);

	pDestDC->SelectObject( oldPen );
	pen.DeleteObject();
}


void CCCPDlg::UpdateSchedule(void)
{
	//CDBSchedule	*dbStation;
	CDBSchedule	*dbCurrentStation, *dbNextStation;

	if( m_Route.IsSetRoute() )
	{
		//dbStation		= m_Route.GetLastStation();
		dbCurrentStation = m_Route.GetActualStation();
		dbNextStation = m_Route.GetNextStation();

		// TITLE
		m_strSchedule[0] = m_Route.GetDestinationName();
		m_Route.GetArriveTime(m_strSchedule[1], 3);

		m_Route.GetDelayTime( m_strSchedule[2] );

//		m_strSchedule[3].Format( _T("%s %06d"), m_Route.GetDestinationCode(), m_Route.GetTrainNumber() );
		m_strSchedule[3].Format( _T("LINE : %s"), m_Route.GetDestinationCode() );
		m_strSchedule[14].Format( _T("R : %06d"), m_Route.GetTrainNumber() );
		m_strSchedule[15].Format( _T("C : %06d"), m_Route.GetCrewID() );

		m_strSchedule[5] = m_Route.GetOriginStationName();
		m_Route.GetArriveTime(m_strSchedule[6], 0);

		m_Route.GetDelayTime( m_strSchedule[7] );

		m_strSchedule[8] = dbCurrentStation->GetStationName();
		m_Route.GetArriveTime(m_strSchedule[9], 1);

		m_Route.GetDelayTime( m_strSchedule[10] );

		if( dbNextStation == NULL )
		{
			m_strSchedule[11] = m_strSchedule[12] = m_strSchedule[13] = _T("");
		}
		else
		{
			m_strSchedule[11] = dbNextStation->GetStationName();
			m_Route.GetArriveTime(m_strSchedule[12], 2);

			m_Route.GetDelayTime( m_strSchedule[13] );
		}
	}
	else
	{
		for(int i=0; i<16; i++)
		{
			m_strSchedule[i] = _T("");
		}
	}

	SYSTEMTIME tm;
	GetLocalTime(&tm);

	if(	tm.wHour >= 12 )			
	{	
		m_strSchedule[4].Format(_T("%.2d:%.2d PM"), ( tm.wHour == 12 ?  12 : tm.wHour - 12 ), 
													tm.wMinute );
	}
	else
	{
		m_strSchedule[4].Format(_T("%.2d:%.2d AM"), ( tm.wHour == 0 ? 12 : tm.wHour ), 
													tm.wMinute);
	}

	CRect rt(10, 9, 10+785, 9+36);	// STATUS AREA
	InvalidateRect(&rt, false);

	if( m_Status.IsUpdating() )
	{
		rt.SetRect(2, 57, 646, 420);
		InvalidateRect(&rt, false);
	}
	else
	if( m_mgrPage.GetCurrentPage() == PAGE_ID_HOME )
	{
		//rt.SetRect(20, 100, 630, 330);	// Schedule AREA
		rt.SetRect(2, 57, 646, 420);
		InvalidateRect(&rt, false);
	}
}

void CCCPDlg::UpdateStatus(void)
{
	if(	m_Status.GetExtSpeaker() == 0 )			m_strStatus[8] = _T("SOFT");
	else if(	m_Status.GetExtSpeaker() == 1 )	m_strStatus[8] = _T("NORMAL");
	else if(	m_Status.GetExtSpeaker() == 2 )	m_strStatus[8] = _T("MUTE");
		
	if(	m_Status.IsSetCabonKey() )				m_strStatus[9] = _T("ON");
	else										m_strStatus[9] = _T("OFF");

	if(	m_Status.IsSetConductorKey() )			m_strStatus[10] = _T("ON");
	else										m_strStatus[10] = _T("OFF");

	if( !m_bReceiveState )
	{
		for(int i=0; i<8; i++)
		{
			m_strStatus[i] = _T("--");
		}

		for(int i=11; i<14; i++)
		{
			m_strStatus[i] = _T("--");
		}
	}
	else
	{
		if( m_Packet.GetGPS() == 1 )			m_strStatus[0] = _T("OK");
		else									m_strStatus[0] = _T("FAIL");
										
		if(	m_Packet.GetWLAN() == 1 )			m_strStatus[1] = _T("OK");
		else									m_strStatus[1] = _T("FAIL");

		if(	m_Packet.GetLIC() == 1 )			m_strStatus[2] = _T("OK");
		else									m_strStatus[2] = _T("FAIL");

		if(	m_Packet.GetPAC() == 1 )			m_strStatus[3] = _T("OK");
		else									m_strStatus[3] = _T("FAIL");

		if(	m_Packet.GetCNCS() == 1 )			m_strStatus[4] = _T("OK");
		else									m_strStatus[4] = _T("FAIL");

		if(	m_Packet.GetVTX() == 1 )			m_strStatus[5] = _T("OK");
		else									m_strStatus[5] = _T("FAIL");

		if(	m_Packet.GetLEDPIS() == 1 )			m_strStatus[6] = _T("OK");
		else									m_strStatus[6] = _T("FAIL");

		if(	m_Packet.GetLCDPIS() == 1 )			m_strStatus[7] = _T("OK");
		else									m_strStatus[7] = _T("FAIL");

		if( m_Status.IsSetCabonKey() )
		{
			if( m_Packet.GetForward() == 2 && m_Packet.GetReverse() == 2 )
			{
				m_strStatus[11] = _T("OFF");
				m_strStatus[12] = _T("OFF");
			}
			else
			{
				if(	m_Packet.GetForward() == 2)	m_strStatus[11] = _T("ON");
				else							m_strStatus[11] = _T("OFF");

				if(	m_Packet.GetReverse() == 2)	m_strStatus[12] = _T("ON");
				else							m_strStatus[12] = _T("OFF");
			}
		}
		else
		{
			m_strStatus[11] = _T("OFF");
			m_strStatus[12] = _T("OFF");
		}

		if(	m_Packet.GetDoor() == 2 )
		{
			m_strStatus[13] = _T("CLOSED");
		}
		else									
		{
			m_strStatus[13] = _T("OPEN");
		}
	}

	Sleep(100);

	CRect rt(656, 57, 656+136, 57+350);	// STATUS AREA
	InvalidateRect(&rt, false);
}

void CCCPDlg::DetectHardware(void)
{
	bool	bChangeOffCab = false;
	bool	bChangeOffCon = false;
	bool	bChangingCabOn = false;

	unsigned char rBuf ;
	DWORD dwByte ;

	//m_Status.SetCabonKey( true );
	//m_Status.SetConducterKey( true );

	//m_Status.SetCCPID( ID_CCP_A );

	//return;

	if ( ReadFile(m_hGPI, &rBuf, 1, &dwByte,NULL) == FALSE )
	{
		return;
	}

	rBuf = rBuf & 0xff ;
	
	if( ( rBuf & 0x01 ) == 0x01 )
	{
		m_Status.SetCCPID( ID_CCP_A );
	}
	else if( ( rBuf & 0x02 ) == 0x02 )
	{
		m_Status.SetCCPID( ID_CCP_B );
	}
	else
	{
		m_Status.SetCCPID( ID_CCP_B );	
	}

	if( ( rBuf & 0x04 ) == 0x04 )
	{
		if( !m_Status.IsSetCabonKey( ) )
		{
			//m_Route.SetTrainNumber();
			m_Route.SetCrewID();
			//m_Route.SetRoute(0);

			m_Status.SetBrightness( 9, this);

			bChangingCabOn = true;
		}

		m_Status.SetCabonKey( true );

		if( m_Status.IsSetCabonKey( ) && bChangingCabOn )
		{
			if( m_Route.IsSetRoute() )
			{
				Sleep(1000);

				KillTimer(TIMER_UPDATE_STATE);

				if(m_Route.m_nBakTrainNumber != 0 )
				{
					SendMessage(WM_FROM_PAGE_NUMBER, PARAM_SET_TRAINNUMBER, m_Route.m_nBakTrainNumber );
				}
				else
				{
					SendMessage(WM_FROM_PAGE_NUMBER, PARAM_SET_TRAINNUMBER, m_Route.GetTrainNumber() );
				}


				SetTimer(TIMER_UPDATE_STATE, 100, NULL);
			}
		}
	}
	else
	{
		if( m_Status.IsSetCabonKey( ) )
		{
			bChangeOffCab = true;
		}

		m_Status.SetCabonKey( false );
	}

	if( ( rBuf & 0x08 ) == 0x08 )
	{
		if( !m_Status.IsSetConductorKey( ) ) 
		{
			m_Status.SetBrightness( 9, this);
		}

		m_Status.SetConducterKey( true );
	}
	else
	{
		if( m_Status.IsSetConductorKey( ) ) 
		{
			bChangeOffCon = true;
		}

		m_Status.SetConducterKey( false );
	}

	// FOR TEST COMMENT
	if( bChangeOffCab ||
		bChangeOffCon && !m_Status.IsSetCabonKey( ) )
	{
		m_Status.SetDetectCabOff(true);

		SetConfigDefault();

		m_mgrPage.ShowPage(PAGE_ID_HOME);

		if( m_Route.IsSimulate() )
		{
			StopSimulation();
		}

		//m_Route.SetTrainNumber();
		m_Route.SetCrewID();

		m_Route.SetTripNumber(0, 0);

		m_Status.SetUsing( true );
		SendMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - CAB/CON OFF : [TRUE]") );

		//m_Route.SetRoute(0);

		m_Status.SetUsing( false );
		SendMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - CAB/CON OFF : [FALSE]") );
	}
}

bool CCCPDlg::UpdateCaption(UINT nCaptionIndex)
{
	static int nFlickTick;

	CString strCaption;

	if( m_Status.IsUpdating() )
	{
		return true;
	}

	m_nCaptionIndex = nCaptionIndex;

	if( nCaptionIndex == CAPTION_CONFIG_INVALID_PASSWORD )
	{
		strCaption = m_arrCaption[CAPTION_CONFIG_INVALID_PASSWORD];

		CPen	pen, *oldPen;
		CRect	rect(2, 379, 644, 420);

		DrawCaptoinBG(m_dcMainBG.GetDC(), m_dcCaptionBG.GetDC(), &rect);

		pen.CreatePen(PS_SOLID, 1, RGB(122,123,100));

		m_dcMainBG.GetDC()->SetBkMode(TRANSPARENT);
		m_dcMainBG.GetDC()->SelectObject(&m_ftCaption);
		oldPen = m_dcMainBG.GetDC()->SelectObject(&pen);

		m_dcMainBG.GetDC()->DrawText(strCaption, strCaption.GetLength(), CRect(2+5, 379+5, 641, 379+37), DT_CENTER | DT_SINGLELINE | DT_VCENTER);
		
		m_dcMainBG.GetDC()->SelectObject(oldPen);
		pen.DeleteObject();

		CRect rt(2, 379, 644, 420);	// CAPTION AREA
		InvalidateRect(&rt, false);

		return false;
	}
	else 	if( nCaptionIndex == CAPTION_CI )
	{
		strCaption = m_arrCaption[CAPTION_CI];

		{
		CPen		pen, *oldPen;
		//CRect		rect;
		CBrush		brush;
		COLORREF	color;

		color = RGB(253, 0, 0);
		CRect rect(2, 379, 644, 420);	// CAPTION AREA

		int nCaptionBGIndex = 7;
		m_dcMainBG.GetDC()->FillSolidRect(&rect, color);

		//
		pen.CreatePen(PS_SOLID, 3, RGB(188,188,188));
		oldPen = m_dcMainBG.GetDC()->SelectObject( &pen );

		m_dcMainBG.GetDC()->MoveTo( rect.left + 11, rect.top+1);
		m_dcMainBG.GetDC()->LineTo( rect.right - 11, rect.top+1);

		m_dcMainBG.GetDC()->MoveTo( rect.left+1, rect.top + 11);
		m_dcMainBG.GetDC()->LineTo( rect.left+1, rect.bottom - 11);

		m_dcMainBG.GetDC()->MoveTo( rect.left + 11, rect.bottom-2);
		m_dcMainBG.GetDC()->LineTo( rect.right - 11, rect.bottom-2);

		m_dcMainBG.GetDC()->MoveTo( rect.right-2, rect.top + 11);
		m_dcMainBG.GetDC()->LineTo( rect.right-2, rect.bottom - 11);

		//
		m_dcMainBG.GetDC()->BitBlt( rect.left, rect.top, 12, 12, m_dcCaptionBG.GetDC(), 0, 0+(nCaptionBGIndex*12), SRCCOPY);

		m_dcMainBG.GetDC()->BitBlt( rect.right-12, rect.top, 12, 12, m_dcCaptionBG.GetDC(), 12, 0+(nCaptionBGIndex*12), SRCCOPY);

		m_dcMainBG.GetDC()->BitBlt( rect.left, rect.bottom-12, 12, 12, m_dcCaptionBG.GetDC(), 24, 0+(nCaptionBGIndex*12), SRCCOPY);

		m_dcMainBG.GetDC()->BitBlt( rect.right-12, rect.bottom-12, 12, 12, m_dcCaptionBG.GetDC(), 36, 0+(nCaptionBGIndex*12), SRCCOPY);

		m_dcMainBG.GetDC()->SelectObject( oldPen );
		pen.DeleteObject();
		}

		//
		CPen	pen, *oldPen;
		CRect	rect(2, 379, 644, 420);

		pen.CreatePen(PS_SOLID, 1, RGB(122,123,100));

		m_dcMainBG.GetDC()->SetBkMode(TRANSPARENT);
		m_dcMainBG.GetDC()->SelectObject(&m_ftCaption);
		oldPen = m_dcMainBG.GetDC()->SelectObject(&pen);

		m_dcMainBG.GetDC()->DrawText(strCaption, strCaption.GetLength(), CRect(2+5, 379+5, 641, 379+37), DT_CENTER | DT_SINGLELINE | DT_VCENTER);
		
		m_dcMainBG.GetDC()->SelectObject(oldPen);
		pen.DeleteObject();

		CRect rt(2, 379, 644, 420);	// CAPTION AREA
		InvalidateRect(&rt, false);

		return false;
	}

	if( nCaptionIndex == CAPTION_TRAIN_NUMBER_FAIL )
	{
		strCaption = m_arrCaption[CAPTION_CABON + (nFlickTick & 0x01) ];
	}

	//
	bool	bIsSetPEI = false;
	bool	bDetectPEI = false;
	UINT nCarCount = m_Packet.GetCarCount();

	for(UINT i=0; i<nCarCount; i++)
	{
		UINT	nPEINo = 0;
		UINT	nCurrentPEICar = m_Status.GetPEICarNo();
		CString strCarNumber;

		CAR_DATA *pCarData = m_Packet.GetCarData(i);

		if( (pCarData->CARN & 0x01) == 0x01 )	// Married A
		{
			if( CHECK_PEICALL1A(pCarData->DATA) )
			{
				if( !m_Status.FindPEICarNo( pCarData->CARN * 10 + 1) )
				{
					m_Status.AddPEICarNo( pCarData->CARN * 10 + 1 );
					bIsSetPEI = true;
				}

				bDetectPEI = true;
			}
			
			if( CHECK_PEICALL2A(pCarData->DATA) )
			{
				if( !m_Status.FindPEICarNo( pCarData->CARN * 10 + 2) )
				{
					m_Status.AddPEICarNo( pCarData->CARN * 10 + 2 );
					bIsSetPEI = true;
				}

				bDetectPEI = true;
			}
		}
		else
		if( (pCarData->CARN & 0x01) == 0x00 )	// Married B
		{
			if( CHECK_PEICALL1B(pCarData->DATA) )
			{
				if( !m_Status.FindPEICarNo( pCarData->CARN * 10 + 3) )
				{
					m_Status.AddPEICarNo( pCarData->CARN * 10 + 3 );
					bIsSetPEI = true;
				}

				bDetectPEI = true;
			}
			
			if( CHECK_PEICALL2B(pCarData->DATA) )
			{
				if( !m_Status.FindPEICarNo( pCarData->CARN * 10 + 4) )
				{
					m_Status.AddPEICarNo( pCarData->CARN * 10 + 4 );
					bIsSetPEI = true;
				}

				bDetectPEI = true;
			}
		}
	}

	if( bIsSetPEI )
	{
		//CDC *dcBtn = m_btnMenu[7].GetDC();

		//if(  dcBtn )
		//{
		//	dcBtn->DeleteDC();
		//	m_btnMenu[7].FreeResource();
		//}

		//m_btnMenu[7].SetBitmapFromFile( _T(IDB_MAIN_PEI_UP), _T(IDB_MAIN_PEI_OR));

		m_Status.SetPEI(true);
		m_Status.SetCheckPEI(false);
	}

	if( !bDetectPEI || m_Status.GetCheckPEI() )
	{
		if( m_Status.IsSetPEI() )
		{
			//CDC *dcBtn = m_btnMenu[7].GetDC();

			//if(  dcBtn )
			//{
			//	dcBtn->DeleteDC();
			//	m_btnMenu[7].FreeResource();
			//}

			//m_btnMenu[7].SetBitmapFromFile( _T(IDB_MAIN_PEI_UP), _T(IDB_MAIN_PEI_DN));
			//m_btnMenu[7].SetPush(false);

			m_btnMenu[7].SetAlternate( false );
			m_btnMenu[7].Invalidate(false);

			RedrawButton( m_mgrPage.GetCurrentPage() );
		}

		if( !bDetectPEI )
		{
			m_Status.SetPEI(false);
			m_Status.SetCheckPEI(false);
		}
	}

	//

	if( m_Status.IsSetPEI() && !m_Status.GetCheckPEI() )
	{
		UINT nCarNumber = m_Status.GetPEICarNo() / 10;

		//if( nCarNumber & 0x01 )
		//{	
		//	nCarNumber++;
		//}
		//else
		//{
		//	nCarNumber--;
		//}

		strCaption.Format(_T("Passenger Emergency Intercom #%d Call"), nCarNumber );

		//m_btnMenu[7].SetPush( (nFlickTick & 1) );

		m_btnMenu[7].SetAlternate( (nFlickTick & 1) );
		m_btnMenu[7].Invalidate(false);
	}
	else if( m_Packet.PAC.CCI == 0x10 || m_Status.GetInuguration() )
	{
		if( m_Packet.PAC.CCI == 0x10 )
		{
			m_Status.SetInuguration(true);

			m_mgrPage.ShowPage(PAGE_ID_HOME);
			RedrawButton(PAGE_ID_HOME);

			strCaption = m_arrCaption[CAPTION_INAUGRATION];

			//if( m_Route.IsSimulate() )
			{
				//StopSimulation();
			}
		}
		else if( m_Status.GetInuguration() )
		{
			m_Status.SetInuguration(false);

			strCaption = m_arrCaption[CAPTION_INAUGRATION_COMLETE];

			SetTimer(TIMER_UPDATE_CAPTION, 5000, NULL);
		}
	}
	else if( !m_Status.IsSetCabonKey() )
	{
		strCaption = m_arrCaption[CAPTION_CABON + (nFlickTick & 0x01) ];
	}
	else if( nCaptionIndex == CAPTION_TRAIN_NUMBER_OK )
	{
		strCaption = m_arrCaption[CAPTION_TRAIN_NUMBER_OK];
	}
	else if( nCaptionIndex == CAPTION_TRAIN_NUMBER_FAIL )
	{
		strCaption = m_arrCaption[CAPTION_TRAIN_NUMBER_FAIL];
	}
	else if( !m_Route.GetTrainNumber() )
	{
		if( m_mgrPage.GetCurrentPage() == PAGE_ID_TRAIN )
		{
			strCaption = m_arrCaption[CAPTION_TRAIN];
		}
		else
		{
			strCaption = m_arrCaption[CAPTION_INPUT_TRAIN];
		}
	}
	//else if( !m_Route.GetCrewID() )
	//{
	//
	//	//else
	//	//{
	//	//	strCaption = m_arrCaption[CAPTION_INPUT_CREW];
	//	//}
	//}
	else if( m_Route.IsSimulate() )
	{
		strCaption = m_arrCaption[CAPTION_SIMULATION];
	}
	else
	{
		if( m_mgrPage.GetCurrentPage() == PAGE_ID_CREW )
		{
			strCaption = m_arrCaption[CAPTION_CREW];
		}
		else
		if( m_nCaptionIndex == CAPTION_TRAIN )
		{
			strCaption.Format( _T("Train Number : %d"), m_Route.GetTrainNumber() );
		}
		else 
		if( m_nCaptionIndex == CAPTION_CREW )
		{
			strCaption.Format( _T("Crew ID : %d"), m_Route.GetCrewID() );
		}
		else
		{
			strCaption = m_arrCaption[m_nCaptionIndex];
		}
	}

	//

	CPen	pen, *oldPen;
	CRect	rect(2, 379, 644, 420);

	DrawCaptoinBG(m_dcMainBG.GetDC(), m_dcCaptionBG.GetDC(), &rect);

	pen.CreatePen(PS_SOLID, 1, RGB(122,123,100));

	m_dcMainBG.GetDC()->SetBkMode(TRANSPARENT);
    m_dcMainBG.GetDC()->SelectObject(&m_ftCaption);
	oldPen = m_dcMainBG.GetDC()->SelectObject(&pen);

	m_dcMainBG.GetDC()->DrawText(strCaption, strCaption.GetLength(), CRect(2+5, 379+5, 641, 379+37), DT_CENTER | DT_SINGLELINE | DT_VCENTER);
	
	m_dcMainBG.GetDC()->SelectObject(oldPen);
	pen.DeleteObject();

	CRect rt(2, 379, 644, 420);	// CAPTION AREA
	InvalidateRect(&rt, false);

	nFlickTick++;

	return true;
}

void CCCPDlg::UpdateButtonState( int nPageIndex )
{
	m_btnMenu[0].SetPush( nPageIndex == PAGE_ID_HOME );
	m_btnMenu[1].SetPush( nPageIndex == PAGE_ID_TRAIN );
	m_btnMenu[2].SetPush( nPageIndex == PAGE_ID_CREW );
	m_btnMenu[3].SetPush( nPageIndex == PAGE_ID_ROUTE );
	m_btnMenu[4].SetPush( nPageIndex == PAGE_ID_CONFIG );
	m_btnMenu[5].SetPush( nPageIndex == PAGE_ID_CHECK );
	m_btnMenu[6].SetPush( nPageIndex == PAGE_ID_HELP );
	m_btnMenu[7].SetPush( nPageIndex == PAGE_ID_PEI );
	m_btnMenu[8].SetPush( nPageIndex == PAGE_ID_CM );
}

void CCCPDlg::OnClick_Menu(UINT	nID)
{
	if( m_Status.GetInuguration() || m_Status.IsUpdating() )
	{
		m_mgrPage.ShowPage(PAGE_ID_HOME);
		RedrawButton(PAGE_ID_HOME);
		return;
	}

	if( !m_Status.IsSetCabonKey() )
	{
		if( m_Status.IsSetConductorKey() )
		{
			if( nID != IDC_BTN_HOME &&
				nID != IDC_BTN_CHECK &&
				nID != IDC_BTN_HELP &&
				nID != IDC_BTN_PEI )
			{
				return;
			}
		}
		else
		{
			return;
		}
	}

		 if( nID == IDC_BTN_HOME )		m_mgrPage.ShowPage(PAGE_ID_HOME);
	else if( nID == IDC_BTN_TRAIN )		m_mgrPage.ShowPage(PAGE_ID_TRAIN);
	else if( nID == IDC_BTN_CREW )		m_mgrPage.ShowPage(PAGE_ID_CREW);
	else if( nID == IDC_BTN_ROUTE )		m_mgrPage.ShowPage(PAGE_ID_ROUTE);
	else if( nID == IDC_BTN_CONFIG )
	{
		m_pPageConfig->SetChangeDirect( SUB_MODE_MENU );
		m_mgrPage.ShowPage(PAGE_ID_CONFIG);
	}
	else if( nID == IDC_BTN_CHECK )		m_mgrPage.ShowPage(PAGE_ID_CHECK);
	else if( nID == IDC_BTN_HELP )		m_mgrPage.ShowPage(PAGE_ID_HELP);
	else if( nID == IDC_BTN_PEI )
	{
		//if( m_Status.IsSetPEI() )
		//{
		//	m_Status.SetCheckPEI(true);
		//}
		
		m_mgrPage.ShowPage(PAGE_ID_PEI);
	}
	else if( nID == IDC_BTN_CM )		m_mgrPage.ShowPage(PAGE_ID_CM);

	// UpdateButtonState( m_mgrPage.GetCurrentPage() );
	UpdateCaption( nID - IDC_BTN_HOME );

	RedrawButton( m_mgrPage.GetCurrentPage() );
}

void CCCPDlg::RedrawButton(int nPageIndex)
{
	for( int i=0; i<9; i++)
	{
		if( nPageIndex == i )
		{
			m_btnMenu[i].SetPush(true);
		}
		else
		{
			m_btnMenu[i].SetPush(false);
		}

		m_btnMenu[i].Invalidate(false);
	}
}

BOOL CCCPDlg::OnEraseBkgnd(CDC* pDC)
{
	return 0;
}

void CCCPDlg::OnLButtonDown(UINT nFlags, CPoint point)
{
	static int nCount = 0;
	CRect app_exit(650, 140, 710, 180);
	
	if(app_exit.PtInRect(point) ) 
	{
		nCount++;
	}
	else
	{
		nCount = 0;
	}

	if ( 5 < nCount)
	{
		EndDialog(0);

		m_pSerial->SuspendThread();
		m_pSerial->ClosePort();
	}

	RedrawButton( m_mgrPage.GetCurrentPage() );

	CDialog::OnLButtonDown(nFlags, point);
}

void CCCPDlg::OnClose()
{

}

void CCCPDlg::OnTimer(UINT_PTR nIDEvent)
{
	static BOOL bOldReciveStatue = m_bReceiveState;;

	if( nIDEvent == TIMER_UPDATE_STATE )
	{
		//if( m_Status.IsSetCabonKey() )
		//{
			if( m_Status.GetTouchCalibration_Master() )
			{
		//		//RETAILMSG(1, (_T("START OnMsg_StartTouchCalibration MASTER \n") ) );
		//		SendMessage( WM_WRITE_LOG, (WPARAM)_T("START OnMsg_StartTouchCalibration MASTER \n") );

				OnMsg_StartTouchCalibration(NULL, NULL);
			}
		//}
		//else
		//{
			if( m_Status.GetTouchCalibration_Slave() )
			{
		//		//RETAILMSG(1, (_T("START OnMsg_StartTouchCalibration SLAVE \n") ) );
		//		SendMessage( WM_WRITE_LOG, (WPARAM)_T("START OnMsg_StartTouchCalibration SLAVE  \n") );

				OnMsg_StartTouchCalibration(NULL, NULL);
			}
		//}

		//if( m_Status.IsSetCabonKey() )
		//{
		//	if( m_Status.GetTouchCalibration_Master() )
		//	{
		//		//RETAILMSG(1, (_T("START OnMsg_StartTouchCalibration MASTER \n") ) );
		//		SendMessage( WM_WRITE_LOG, (WPARAM)_T("START OnMsg_StartTouchCalibration MASTER \n") );

		//		OnMsg_StartTouchCalibration(NULL, NULL);
		//	}
		//}
		//else
		//{
		//	if( m_Status.GetTouchCalibration_Slave() )
		//	{
		//		//RETAILMSG(1, (_T("START OnMsg_StartTouchCalibration SLAVE \n") ) );
		//		SendMessage( WM_WRITE_LOG, (WPARAM)_T("START OnMsg_StartTouchCalibration SLAVE  \n") );

		//		OnMsg_StartTouchCalibration(NULL, NULL);
		//	}
		//}

		KillTimer(TIMER_UPDATE_STATE);

		//RETAILMSG(1, (_T("START UpdateSchedule\r\n") ) );
		UpdateSchedule();
		//RETAILMSG(1, (_T("START UpdateStatus\r\n") ) );
		UpdateStatus();
		//RETAILMSG(1, (_T("FINISH\r\n") ) );

		// FOR TEST
		//CheckMemoryUsage();

		SetTimer(TIMER_UPDATE_STATE, 1000, NULL);
	}	
	else
	if( nIDEvent == TIMER_HARD_DETECT )
	{
		KillTimer(TIMER_HARD_DETECT);

		DetectHardware();

		if( m_Status.IsSetCabonKey() || m_Status.IsSetConductorKey() ) 
		{
			m_dwTickTouch = ::GetTickCount();
		}
		else
		{
			if( ( ::GetTickCount() - m_dwTickTouch ) > 15000 && !m_Status.IsUpdating() )
			{
				m_Status.SetBrightness( 1, this);
			}
		}
		
		SetTimer(TIMER_HARD_DETECT, 500, NULL);
    }
	else
	if( nIDEvent == TIMER_SIMULATION )
	{	
		KillTimer(TIMER_SIMULATION);

		if( m_Route.IsSimulate() )
		{
			m_Route.IncreaseActualStationIdx();
		}

		 UINT	nSimulationTime = m_Route.GetSimulationTime() * 1000;

		SetTimer(TIMER_SIMULATION, nSimulationTime, NULL);
	}
	else
	if( nIDEvent == TIMER_UPDATE_CAPTION )
	{	
		KillTimer(TIMER_UPDATE_CAPTION);

		if( UpdateCaption(m_nCaptionIndex) )
		{
			SetTimer(TIMER_UPDATE_CAPTION, 1000, NULL);
		}
	}
	else
	if( nIDEvent == TIMER_CROSS_TIME )
	{	
		static int step;

		//if( (step & 0x01) == 0x00 )
		//{
		//	m_Status.SetCrossTime( false );
		//}
		//else
		//{
		//	m_Status.SetCrossTime( true );
		//}

		m_Status.SetCrossTime( ++step );

		// FOR TEST
		//m_pSerial->SendToPAC( GetTickCount() );
	}
	else
	if( nIDEvent == TIMER_SERIAL_THREAD )
	{
		KillTimer( TIMER_SERIAL_THREAD );

		InitSerial();
	}
	else
	if( nIDEvent == TIMER_SERIAL_STATUS )
	{
		DWORD dwTick = ::GetTickCount();
		DWORD dwDelay = 0;

		// KillTimer(TIMER_SERIAL_STATUS);

		if( m_Status.IsSetCabonKey() )
		{
			dwDelay =  5000;
		}
		else
		{
			dwDelay = 60000;
		}
		
		m_bReceiveState = ( ( dwTick - m_dwTickRecv ) < dwDelay );

		if( !m_bReceiveState  && m_bActiveCalibration )											// Calibration이 실행된 후, 통신이 되지 않을 경우, 다시한번만 통신포트를 초기화함.
		{
			m_pSerial->SuspendThread();

			m_pSerial->ClosePort();
			m_pSerial->OpenPort();

			m_pSerial->Flush(TRUE, TRUE);

			m_pSerial->ResumeThread();			

			m_bActiveCalibration = FALSE;														// Calibration으로 인한 통신포트 초기화를 막음.
			// m_dwTickRecv = dwTick;															// 통신 버퍼에 신규 데이터가 들어와 시간이 갱신되도록 초기화를 막음.

			// RETAILMSG(1, ( _T("m_bActiveCalibration - SERIAL-THREAD : RESET\n") ) );
		}

		// 항상 상태를 동기화 시킴.
		bOldReciveStatue = m_bReceiveState;

		//if( ( dwTick - m_dwTickRecv ) > dwDelay )
		//{
		//	m_pSerial->SuspendThread();

		//	m_pSerial->ClosePort();
		//	m_pSerial->OpenPort();

		//	m_pSerial->Flush(TRUE, TRUE);

		//	m_pSerial->ResumeThread();			

		//	m_dwTickRecv = dwTick;

		//	WriteLog( _T("SERIAL-THREAD : RESET") );
		//}

		// SetTimer(TIMER_SERIAL_STATUS, 1000, NULL);

		////DWORD dwTick = ::GetTickCount();
		////DWORD dwDelay = 0;

		////KillTimer(TIMER_SERIAL_STATUS);

		////if( m_Status.IsSetCabonKey() )
		////{
		////	dwDelay = 3000;
		////}
		////else
		////{
		////	dwDelay = 60000;
		////}

		////if( ( dwTick - m_dwTickRecv ) > dwDelay )
		////{
		////	m_pSerial->SuspendThread();

		////	m_pSerial->ClosePort();
		////	m_pSerial->OpenPort();

		////	m_pSerial->Flush(TRUE, TRUE);

		////	m_pSerial->ResumeThread();			

		////	m_dwTickRecv = dwTick;

		////	WriteLog( _T("SERIAL-THREAD : RESET") );
		////}

		////SetTimer(TIMER_SERIAL_STATUS, 1000, NULL);
	}
	else
	if( nIDEvent == TIMER_AGENT )
	{
		KillTimer(TIMER_AGENT);

		TCHAR* cmdline = _T("\\NandFlash\\CCP_Agent.exe"); 

		if( CreateProcess(cmdline, NULL, NULL, NULL, FALSE, 0, NULL, NULL, NULL, NULL) )
		{
			//WriteLog( _T("CCPAgent : RUN Success") );
		}
		else
		{
			//WriteLog( _T("CCPAgent : RUN Fail") );	
		}
	}
	else
	if( nIDEvent == TIMER_INVALID_PASSWORD )
	{
		KillTimer( TIMER_INVALID_PASSWORD );

		//SendMessage( WM_CAPTION_SET, m_nCaptionIndex );
		SetTimer(TIMER_UPDATE_CAPTION, 1000, NULL);
	}
	else
	if( nIDEvent == TIMER_TEST )
	{	
		static int step;

		KillTimer(TIMER_TEST);

		CAR_DATA car;
		car.CARN = 4001;
		memset(car.DATA, 0x00, sizeof(BYTE) * 8);

		car.DATA[0] = 0x09;
		car.DATA[1] = 0x00;
		car.DATA[2] = 0x00;
		car.DATA[3] = 0x00;
		car.DATA[4] = 0x00;
		car.DATA[5] = 0x00;
		car.DATA[6] = 0x00;
		car.DATA[7] = 0x00;
		car.DATA[8] = 0x00;

		m_Packet.SetCarData(1, &car, 0x00);

		//step++;

		// FOR TEST
		m_pSerial->SendToPAC( GetTickCount() );

		SetTimer(TIMER_TEST, 1000, NULL);
		
	}

	CDialog::OnTimer(nIDEvent);
}


LRESULT CCCPDlg::OnMsg_FromPageNumber(WPARAM wparam, LPARAM lparam)
{
	CString strLog;

	if( wparam == PARAM_SET_TRAINNUMBER )
	{
		//if(m_bChangingRoute)
		//{
		//	Sleep(2000);
		//}
		m_Route.m_bIsSetRoute = false;
		
		if(m_Status.m_bChangingRoute)
		{
			return 0;
		}
		else
		{
			m_Status.m_bChangingRoute = true;
		}

		if( m_Route.IsValidTrainNumber(lparam)  )
		{
			CCeSQLiteDB db;
			char szSQL[1024];
			int nACABDIR = 0;

			sprintf( szSQL, "select ACABDIR from TRAIN_HEADERS where TRAIN_NUM = '%d' ", lparam );

			db.open( DB_PATH );
			CCeSQLiteTable t = db.getTable( szSQL );

			nACABDIR = t.getIntField( 0 );

			t.finalize();
			db.close();

			bool bDirUP = true;
	
			bDirUP = lparam % 2;

			if( nACABDIR )
			{
				bDirUP = true;
			}
			else
			{
				bDirUP = false;
			}

			//if( m_Status.GetCCPID() == ID_CCP_A )
			//{
			//	if( nACABDIR )
			//	{
			//		bDirUP = true;
			//	}
			//	else
			//	{
			//		bDirUP = false;
			//	}
			//}
			//else 
			//{
			//	if( nACABDIR )
			//	{
			//		bDirUP = false;
			//	}
			//	else
			//	{
			//		bDirUP = true;
			//	}
			//}

			if( m_Route.SetRoute(lparam, bDirUP) )
			{
				m_Route.SetTrainNumber( lparam );
				m_Route.SetCrewID();

				if( m_Route.IsSimulate() )
				{
					StopSimulation();
				}

				KillTimer(TIMER_UPDATE_CAPTION);

				UpdateCaption(CAPTION_TRAIN_NUMBER_OK);

				SendMessage(WM_PAINT);

				Sleep(1000);

				m_mgrPage.ShowPage(PAGE_ID_HOME);
				RedrawButton(PAGE_ID_HOME);

				UpdateCaption( CAPTION_HOME );

				SetTimer(TIMER_UPDATE_CAPTION, 2000, NULL);

				m_Route.m_nBakTrainNumber = lparam;
			}
			else
			{
				KillTimer(TIMER_UPDATE_CAPTION);

				UpdateCaption(CAPTION_TRAIN_NUMBER_FAIL);

				SendMessage(WM_PAINT);

				Sleep(1000);

				SetTimer(TIMER_UPDATE_CAPTION, 2000, NULL);
			}
		}
		else
		{
			KillTimer(TIMER_UPDATE_CAPTION);

			UpdateCaption(CAPTION_TRAIN_NUMBER_FAIL);

			SendMessage(WM_PAINT);

			Sleep(1000);

			SetTimer(TIMER_UPDATE_CAPTION, 2000, NULL);
		}

		m_Status.m_bChangingRoute = false;
	}
	else if( wparam == PARAM_SET_CREWID )
	{
		m_Route.SetCrewID( lparam );

		m_mgrPage.ShowPage(PAGE_ID_HOME);
		RedrawButton(PAGE_ID_HOME);
		UpdateCaption( CAPTION_HOME );
	}
	else if( wparam == PARAM_PASSWORD_CHECK )
	{
		if( lparam != m_nPassword )
		{
			KillTimer( TIMER_UPDATE_CAPTION );
			SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_INVALID_PASSWORD);
			SetTimer( TIMER_INVALID_PASSWORD, 2000, NULL );
		}
		else
		{
			m_pPageConfig->SetChangeDirect( SUB_MODE_MENU );
			m_mgrPage.ShowPage(PAGE_ID_PASSWORD_NEW);
			SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_NEW_PASSWORD);
		}
	}
	else if( wparam == PARAM_PASSWORD_NEW )
	{
		SavePassword( (UINT)lparam );
		m_pPageConfig->SetChangeDirect( SUB_MODE_MENU );
		m_mgrPage.ShowPage(PAGE_ID_CONFIG);
		SendMessage(WM_CAPTION_SET, CAPTION_CONFIG);
	}
	else if( wparam == PARAM_PASSWORD_VOL )
	{
		if( lparam == m_nPassword )
		{
			m_pPageConfig->SetChangeDirect( SUB_MODE_SPEAKER );
			m_mgrPage.ShowPage(PAGE_ID_CONFIG);
		}
		else
		{
			KillTimer( TIMER_UPDATE_CAPTION );
			SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_INVALID_PASSWORD);
			SetTimer( TIMER_INVALID_PASSWORD, 2000, NULL );;
		}
	}
	else if( wparam == PARAM_PASSWORD_CI )
	{
		if( lparam == m_nPassword )
		{
			m_mgrPage.ShowPage(PAGE_ID_CI);
			SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_CI);
		}
		else
		{
			KillTimer( TIMER_UPDATE_CAPTION );
			SendMessage(WM_CAPTION_SET, CAPTION_CI);
			SetTimer( TIMER_INVALID_PASSWORD, 2000, NULL );;
		}
	}

	return 0;
}

LRESULT CCCPDlg::OnMsg_FromPageConfig(WPARAM wparam, LPARAM lparam)
{
	if( wparam == PARAM_SET_CAB_SPEAKER)
	{
		m_Status.SetCabSpeaker( (BYTE)lparam );
	}
	if( wparam == PARAM_SET_INT_SPEAKER )
	{
		m_Status.SetIntSpeaker( (BYTE)lparam );
	}
	else if( wparam == PARAM_SET_EXT_SPEAKER )
	{
		m_Status.SetExtSpeaker( (BYTE)lparam );
	}
	else if( wparam == PARAM_SET_BRIGHT )
	{
		if( lparam == PARAM_BRIGHT_UP )
		{
			m_Status.SetBrightnessUpDown(true, this);
		}
		else
		{
			m_Status.SetBrightnessUpDown(false, this);
		}
	}
	else if( wparam	== PARAM_SET_SIMULATION_TIME )
	{
		m_Route.SetSimulationTime( lparam );
	}
	else if( wparam	== PARAM_CONFIG_RESET )
	{
		SetConfigDefault();

		m_Route.SetCMIndex( -1 );

		if( m_Route.IsSimulate() )
		{
			StopSimulation();
		}

		m_Route.SetTrainNumber(0);
		m_Route.SetCrewID();

		if( m_Status.GetUsing() )
		{
			for(int i=0; i<50; i++)
			{
				Sleep(100);

				if( !m_Status.GetUsing() ) break;
			}
		}

		m_Status.SetUsing( true );
		SendMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - CONFIG RESET : [TRUE]") );

		m_Route.SetRoute( 0 );

		m_Status.SetUsing( false );
		SendMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - CONFIG RESET : [FALSE]") );
	}

	return 0;
}

LRESULT CCCPDlg::OnMsg_CaptionSet(WPARAM wparam, LPARAM lparam)
{
	UpdateCaption( wparam );

	return 0;
}

LRESULT CCCPDlg::OnMsg_TouchLCD(WPARAM wparam, LPARAM lparam)
{

	m_dwTickTouch = ::GetTickCount();

	m_Status.SetBrightness( m_Status.GetBrightness(), this);

	return 0;
}

LRESULT CCCPDlg::OnMsg_StartTouchCalibration(WPARAM wparam, LPARAM lparam)
{
	m_pSerial->SuspendThread();

	TouchCalibrate();

	RedrawWindow();		

	if( m_Status.IsSetCabonKey() )
	{
		m_Status.SetTouchCalibration_Master( false );
		m_Packet.SetTouchCalibration_Master( false );
	}
	else
	{
		m_Status.SetTouchCalibration_Slave( false );
		m_Packet.SetTouchCalibration_Slave( false );
	}

	m_pSerial->ClosePort();
	m_pSerial->OpenPort();

	m_pSerial->Flush(TRUE, TRUE);

	m_pSerial->ResumeThread();
	
	m_dwTickRecv = ::GetTickCount();															// Calibration이 실행되었음을 마킹.
	m_bActiveCalibration = TRUE;

	return 0;
}

LRESULT CCCPDlg::OnMsg_StopTouchCalibration(WPARAM wparam, LPARAM lparam)
{
	keybd_event(VK_ESCAPE, 0, 0, 0);
	keybd_event(VK_ESCAPE, 0, KEYEVENTF_KEYUP, 0);	

	return 0;
}

LRESULT CCCPDlg::OnMsg_Update(WPARAM wparam, LPARAM lparam)
{
	CWnd *wndAgent = (CWnd *)FindWindow(_T("CCPAgent"), NULL);

	if( !wndAgent )
	{
		TCHAR* cmdline = _T("\\NandFlash\\CCP_Agent.exe"); 
		CreateProcess(cmdline, NULL, NULL, NULL, FALSE, 0, NULL, NULL, NULL, NULL);

		Sleep(2000);

		wndAgent = (CWnd *)FindWindow(_T("CCPAgent"), NULL);
	}

	if( wndAgent )
	{
		wndAgent->SendMessage(WM_USER);

		EndDialog(0);

		m_pSerial->SuspendThread();
		m_pSerial->ClosePort();
	}

	return 0;
}

LRESULT CCCPDlg::OnMsg_CrossTime(WPARAM wparam, LPARAM lparam)
{
	CString strLog;

	if( wparam == 0 )
	{
		KillTimer( TIMER_CROSS_TIME );
		m_nCrossTime = 0;

		strLog.Format( _T("TIMER_CROSS_TIME %d "), m_nCrossTime );
		SendMessage( WM_WRITE_LOG, (WPARAM)&strLog, 1 );
		
	}
	else
	{
		if( wparam == m_nCrossTime )
		{
			return 0;
		}
		else
		{
			m_nCrossTime = wparam;

			KillTimer( TIMER_CROSS_TIME );

			SetTimer( TIMER_CROSS_TIME, m_nCrossTime * 1000, NULL );

			strLog.Format( _T("TIMER_CROSS_TIME %d "), m_nCrossTime );
			SendMessage( WM_WRITE_LOG, (WPARAM)&strLog, 1 );
		}
	}

	return 0;
}

LRESULT CCCPDlg::OnMsg_SetRoute(WPARAM wparam, LPARAM lparam)
{
	//if(m_bChangingRoute)
	//{
	//	Sleep(2000);
	//}

	if(m_Status.m_bChangingRoute)
	{
		return 0;
	}
	else
	{
		m_Status.m_bChangingRoute = TRUE;
	}

	KillTimer(TIMER_UPDATE_STATE);

	m_Route.m_bIsSetRoute = false;

	if( m_Route.IsValidTrainNumber(wparam) )
	{
		CCeSQLiteDB db;
		char szSQL[1024];
		int nACABDIR = 0;

		sprintf( szSQL, "select ACABDIR from TRAIN_HEADERS where TRAIN_NUM = '%d' ", wparam );

		db.open( DB_PATH );
		CCeSQLiteTable t = db.getTable( szSQL );

		nACABDIR = t.getIntField( 0 );

		t.finalize();
		db.close();

		bool bDirUP = true;

		bDirUP = wparam % 2;

		if( nACABDIR )
		{
			bDirUP = true;
		}
		else
		{
			bDirUP = false;
		}

		//if( m_Route.SetRoute( wparam, bDirUP ) )
		if( m_Route.SetRoute( wparam, bDirUP ) )
		{
			m_Route.SetTrainNumber( wparam );
		}
	}
	else
	if( wparam == 0 )
	{
		if( m_Route.SetRoute( wparam ) )
		{
			m_Route.SetTrainNumber( wparam );
		}
		m_Route.m_nBakTrainNumber = 0;
	}

	if( m_Route.GetCrewID() != lparam )
	{
		m_Route.SetCrewID( lparam );
	}

	SetTimer(TIMER_UPDATE_STATE, 100, NULL);

	m_Status.m_bChangingRoute = false;
	
	return 0;
}

LRESULT CCCPDlg::OnMsg_SetCrewID(WPARAM wparam, LPARAM lparam)
{
	if( m_Route.GetCrewID() != wparam )
	{
		m_Route.SetCrewID( wparam );
	}

	return 0;
}

void CCCPDlg::ReadPassword()
{
	FILE	*file;
	char	buffer[512];
	CString	strBuffer;

	file = fopen( PASSWORD_PATH, "r");

	if( file == NULL )
	{
		m_nPassword = 0;
		return;
	}

	ZeroMemory(buffer, 512);

	fgets(buffer, 512, file);

	fclose(file);

	m_nPassword = atoi( buffer );
}

void CCCPDlg::SavePassword( UINT nNewPassword )
{
	FILE	*file;
	char	buffer[512];
	CString	strBuffer;

	file = fopen( PASSWORD_PATH, "w");

	if( file == NULL )
	{
		return;
	}
	
	m_nPassword = nNewPassword;

	sprintf( buffer, "%d", nNewPassword );

	fputs(buffer, file);

	fclose(file);
}

void CCCPDlg::CheckMemoryUsage()
{
	MEMORYSTATUS Memory;
	GlobalMemoryStatus(&Memory);

	RETAILMSG(1, (_T("MEMORY USAGE :%d %d %d\n"), Memory.dwTotalPhys, (Memory.dwTotalPhys- Memory.dwAvailPhys),  Memory.dwMemoryLoad ) );
}

void CCCPDlg::OnPaint()
{
	CFont *oldFont;

	CPaintDC dc(this); // device context for painting

	m_dcBufferBG.BitBlt(0, 0, m_dcMainBG.Width(), m_dcMainBG.Height(), m_dcMainBG.GetDC(), 0, 0, SRCCOPY );
	
	oldFont = m_dcBufferBG.SelectObject(&m_ftStatus); 
	m_dcBufferBG.SetTextColor(m_crStatus);
	m_dcBufferBG.SetBkMode(TRANSPARENT);

	for(int i=0; i<14; i++)
	{
		m_dcBufferBG.DrawText(m_strStatus[i], &m_rectStatus[i], DT_RIGHT | DT_VCENTER | DT_SINGLELINE);
	}

	m_dcBufferBG.SelectObject(&oldFont); 
	
	m_dcBufferBG.SetTextColor(m_crSchedule);

	for(int i=0; i<16; i++)
	{
		UINT nFormat;

		if( i == 3 )	oldFont = m_dcBufferBG.SelectObject(&m_ftRoute); 
		else			oldFont = m_dcBufferBG.SelectObject(&m_ftSchedule); 

		if( i == 1 || i == 2 || i == 4 || i == 6 || i == 7 || i == 9 || i == 10 || i == 12 || i == 13 )
		{
			nFormat = DT_CENTER | DT_VCENTER | DT_SINGLELINE;
		}
		else
		{
			nFormat = DT_LEFT | DT_VCENTER | DT_SINGLELINE;
		}

		m_dcBufferBG.DrawText(m_strSchedule[i], &m_rectSchedule[i], nFormat);

		m_dcBufferBG.SelectObject(&oldFont); 
	}

	//if( m_Packet.GetValidGPS() ) && m_Packet.GetGPS() == 1 )
	if( m_Packet.GetValidGPS() )							
	{
		//m_dcBufferBG.BitBlt(728, 139, m_dcLED[0].Width(), m_dcLED[0].Height(), m_dcLED[0].GetDC(), 0, 0, SRCCOPY );
		m_dcBufferBG.BitBlt(728, 139+13, m_dcLED[0].Width(), m_dcLED[0].Height(), m_dcLED[0].GetDC(), 0, 0, SRCCOPY );
	}
	else
	{
		//m_dcBufferBG.BitBlt(728, 139, m_dcLED[2].Width(), m_dcLED[2].Height(), m_dcLED[2].GetDC(), 0, 0, SRCCOPY );
		m_dcBufferBG.BitBlt(728, 139+13, m_dcLED[2].Width(), m_dcLED[2].Height(), m_dcLED[2].GetDC(), 0, 0, SRCCOPY );
	}
	

	if( m_Packet.GetWLANConnect() )
	{
		//m_dcBufferBG.BitBlt(720, 157, m_dcLED[1].Width(), m_dcLED[1].Height(), m_dcLED[1].GetDC(), 0, 0, SRCCOPY );
		m_dcBufferBG.BitBlt(720, 157+13, m_dcLED[1].Width(), m_dcLED[1].Height(), m_dcLED[1].GetDC(), 0, 0, SRCCOPY );
	}
	else
	{
		//m_dcBufferBG.BitBlt(720, 157, m_dcLED[3].Width(), m_dcLED[3].Height(), m_dcLED[3].GetDC(), 0, 0, SRCCOPY );
		m_dcBufferBG.BitBlt(720, 157+13, m_dcLED[3].Width(), m_dcLED[3].Height(), m_dcLED[3].GetDC(), 0, 0, SRCCOPY );
	}
	
	if( m_Packet.GetWLANTransfer() )
	{
		//m_dcBufferBG.BitBlt(736, 157, m_dcLED[1].Width(), m_dcLED[1].Height(), m_dcLED[1].GetDC(), 0, 0, SRCCOPY );
		m_dcBufferBG.BitBlt(736, 157+13, m_dcLED[1].Width(), m_dcLED[1].Height(), m_dcLED[1].GetDC(), 0, 0, SRCCOPY );
	}
	else
	{
		//m_dcBufferBG.BitBlt(736, 157, m_dcLED[3].Width(), m_dcLED[3].Height(), m_dcLED[3].GetDC(), 0, 0, SRCCOPY );
		m_dcBufferBG.BitBlt(736, 157+13, m_dcLED[3].Width(), m_dcLED[3].Height(), m_dcLED[3].GetDC(), 0, 0, SRCCOPY );
	}
	

	if( m_Status.IsUpdating() )
	{
		m_dcBufferBG.BitBlt(2, 57, m_dcPageBG[7].Width(), m_dcPageBG[7].Height(), m_dcPageBG[7].GetDC(), 0, 0, SRCCOPY );

		oldFont = m_dcBufferBG.SelectObject(&m_ftCaption);

		m_dcBufferBG.DrawText(_T("Upgrading in progress..."), CRect(0, 0, 644, 420), DT_CENTER | DT_VCENTER | DT_SINGLELINE);

		m_dcBufferBG.SelectObject(&oldFont);

		SetConfigDefault();

		m_mgrPage.ShowPage(PAGE_ID_HOME);
		RedrawButton(PAGE_ID_HOME);
	}

	dc.BitBlt(0, 0, 800, 480, &m_dcBufferBG, 0, 0, SRCCOPY );

	//CRect app_exit(650, 140, 710, 180);
	//dc.Rectangle(app_exit);
}

bool CCCPDlg::StartSimulation( )
{
	if( m_Route.StartSimulation() )
	{
		KillTimer(TIMER_SIMULATION);
		
		UINT	nSimulationTime = m_Route.GetSimulationTime() * 1000;

		SetTimer(TIMER_SIMULATION, nSimulationTime, NULL);

		//SetTimer(TIMER_SIMULATION, 10000, NULL);

		return true;
	}

	return false;
}

void CCCPDlg::StopSimulation( )
{
	m_Route.StopSimulation();

	m_Route.SetTripNumber(0, 0);

	KillTimer(TIMER_SIMULATION);
}

void CCCPDlg::SetConfigDefault( )
{
	m_Status.SetCabSpeaker(1);
	m_Status.SetIntSpeaker(1);
	m_Status.SetExtSpeaker(1);
	m_Status.SetBrightness(9, this);
	m_Route.SetSimulationTime(20);

	//HDC hGetDC = ::GetDC(m_hWnd);

	//int nBright = 1000;
	//
	//ExtEscape(hGetDC, DRVESC_SET_BRIGHTNESS, sizeof(int), (LPSTR)&nBright, 0, NULL);

	//::DeleteDC( hGetDC );
}


void CCCPDlg::OnDestroy()
{
	CDialog::OnDestroy();

	for(int i=0; i<14; i++)	m_strStatus[i].ReleaseBuffer();
	for(int i=0; i<16; i++)	m_strSchedule[i].ReleaseBuffer();

	DeinitTimer();

	UnloadBmp();

	CloseHandle( m_hGPI );
	m_hGPI = NULL;

	m_pPageNumber->FreeResource();
	m_pPageRoute->FreeResource();
	m_pPageConfig->FreeResource();
	m_pPageCar->FreeResource();
	m_pPagePR->FreeResource();

	m_pPageNumber->DestroyWindow();
	m_pPageRoute->DestroyWindow();
	m_pPageConfig->DestroyWindow();
	m_pPageHelp->DestroyWindow();
	m_pPageCar->DestroyWindow();
	m_pPagePR->DestroyWindow();

	delete	m_pPageNumber;
	delete	m_pPageRoute;
	delete	m_pPageConfig;
	delete	m_pPageHelp;
	delete	m_pPageCar;
	delete	m_pPagePR;

	m_pPageNumber = NULL;
	m_pPageRoute = NULL;
	m_pPageConfig = NULL;
	m_pPageHelp = NULL;
	m_pPageCar = NULL;
	m_pPagePR = NULL;

	m_pSerial->SuspendThread();
	m_pSerial->ClosePort();
	m_pSerial->Flush(TRUE, TRUE);
	m_pSerial->ResumeThread();	

	Sleep(1000);

	if(m_pSerial)
	{
		m_pSerial->Delete();
	}
	
	CDialog::OnClose();
}
