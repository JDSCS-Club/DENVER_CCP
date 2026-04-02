// Page_Config.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PageConfig.h"
#include "CCPDlg.h"
//#include "config.h"
//#include "Sub_Touch.h"

#include <Pm.h>
#include "winioctl.h"

extern "C"
{
	BOOL WINAPI TouchCalibrate(void);
}
// CPageConfig 대화 상자입니다.

IMPLEMENT_DYNAMIC(CPageConfig, CDialog)

CPageConfig::CPageConfig(CWnd* pParent /*=NULL*/)
	: CDialog(CPageConfig::IDD, pParent)
{
	m_pParent	= (CCCPDlg *)pParent;
	m_pStatus	= &(m_pParent->m_Status);
	m_pBGDC		= m_pParent->m_dcPageBG[0].GetDC();
}

CPageConfig::~CPageConfig()
{
	//DeleteObject(m_hBmpBkgnd);
}

void CPageConfig::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);

	DDX_Control(pDX, IDC_BUTTON_SPEAKER, m_btnMenu[0]);
	DDX_Control(pDX, IDC_BUTTON_LCD, m_btnMenu[1]);
	DDX_Control(pDX, IDC_BUTTON_RESET, m_btnMenu[2]);
	DDX_Control(pDX, IDC_BUTTON_TOUCH, m_btnMenu[3]);
	DDX_Control(pDX, IDC_BUTTON_SIMULATION, m_btnMenu[4]);
	DDX_Control(pDX, IDC_BUTTON_SPARE6, m_btnMenu[5]);

	DDX_Control(pDX, IDC_BTN_SPK_CAB_SOFT, m_btnSpeaker[0]);
	DDX_Control(pDX, IDC_BTN_SPK_CAB_NORMAL, m_btnSpeaker[1]);
	DDX_Control(pDX, IDC_BTN_SPK_INT_SOFT, m_btnSpeaker[2]);
	DDX_Control(pDX, IDC_BTN_SPK_INT_NORMAL, m_btnSpeaker[3]);
	DDX_Control(pDX, IDC_BTN_SPK_EXT_SOFT, m_btnSpeaker[4]);
	DDX_Control(pDX, IDC_BTN_SPK_EXT_NORMAL, m_btnSpeaker[5]);
	DDX_Control(pDX, IDC_BTN_SPK_EXT_MUTE, m_btnSpeaker[6]);

	DDX_Control(pDX, IDC_BTN_LIGHT_DOWN, m_btnLight[0]);
	DDX_Control(pDX, IDC_BTN_LIGHT_UP, m_btnLight[1]);
	DDX_Control(pDX, IDC_LIGHT, m_stcLight);
	
	DDX_Control(pDX, IDC_BTN_RESET_OK, m_btnReset[0]);
	DDX_Control(pDX, IDC_BTN_RESET_CANCEL, m_btnReset[1]);

	DDX_Control(pDX, IDC_BTN_SIMULATION_10, m_btnSimulation[0]);
	DDX_Control(pDX, IDC_BTN_SIMULATION_20, m_btnSimulation[1]);
	DDX_Control(pDX, IDC_BTN_SIMULATION_30, m_btnSimulation[2]);	
}


BEGIN_MESSAGE_MAP(CPageConfig, CDialog)
	ON_WM_ERASEBKGND()
	ON_WM_ACTIVATE()
	ON_WM_PAINT()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BUTTON_SPEAKER, IDC_BUTTON_SPARE6,   &CPageConfig::OnClick_Menu)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_SPK_CAB_SOFT, IDC_BTN_SPK_CAB_NORMAL,   &CPageConfig::OnClick_CabSpeaker)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_SPK_INT_SOFT, IDC_BTN_SPK_INT_NORMAL,   &CPageConfig::OnClick_IntSpeaker)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_SPK_EXT_SOFT, IDC_BTN_SPK_EXT_MUTE,   &CPageConfig::OnClick_ExtSpeaker)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_LIGHT_DOWN, IDC_BTN_LIGHT_UP,   &CPageConfig::OnClick_Light)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_RESET_OK, IDC_BTN_RESET_CANCEL,   &CPageConfig::OnClick_Reset)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_SIMULATION_10, IDC_BTN_SIMULATION_30,   &CPageConfig::OnClick_Simulation)
END_MESSAGE_MAP()


// CPageConfig 메시지 처리기입니다.

BOOL CPageConfig::OnInitDialog()
{
	CDialog::OnInitDialog();

	CPaintDC dc(this);

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	m_pParent = (CCCPDlg	*)GetParent();

	if( m_pParent == NULL ) return FALSE;

	h_instance = AfxGetInstanceHandle();

	// SUB_MODE_MENU
	m_btnMenu[0].SetWindowPos(NULL, 28-2, 84-57, 287, 72, TRUE);
	m_btnMenu[0].SetBitmapFromFile(_T(IDB_CONFIG_SPEAKER_UP), _T(IDB_CONFIG_SPEAKER_DN));
    
	m_btnMenu[1].SetWindowPos(NULL, 335-2, 84-57, 287, 72, TRUE);
	m_btnMenu[1].SetBitmapFromFile(_T(IDB_CONFIG_LCD_UP), _T(IDB_CONFIG_LCD_DN));
    
    m_btnMenu[2].SetWindowPos(NULL, 28-2, 180-57, 287, 72, TRUE);
	m_btnMenu[2].SetBitmapFromFile(_T(IDB_CONFIG_SYSTEM_UP), _T(IDB_CONFIG_SYSTEM_DN));

    m_btnMenu[3].SetWindowPos(NULL, 335-2, 180-57, 287, 72, TRUE);
	m_btnMenu[3].SetBitmapFromFile(_T(IDB_CONFIG_SPARE4_UP), _T(IDB_CONFIG_SPARE4_DN));

    m_btnMenu[4].SetWindowPos(NULL, 28-2, 276-57, 287, 72, TRUE);
	m_btnMenu[4].SetBitmapFromFile(_T(IDB_CONFIG_CI_UP), _T(IDB_CONFIG_CI_DN));

    m_btnMenu[5].SetWindowPos(NULL, 335-2, 276-57, 287, 72, TRUE);
	m_btnMenu[5].SetBitmapFromFile(_T(IDB_CONFIG_SPARE6_UP), _T(IDB_CONFIG_SPARE6_UP));

	// SUB_MODE_SPEAKER'
	m_btnSpeaker[0].SetPushButton();
	m_btnSpeaker[0].SetWindowPos(NULL, 21, 64, 180, 45, SWP_NOZORDER);
	m_btnSpeaker[0].SetBitmapFromFile(_T(IDB_SPEAKER_SOFT_UP), _T(IDB_SPEAKER_SOFT_DN));

	m_btnSpeaker[1].SetPushButton();
	m_btnSpeaker[1].SetWindowPos(NULL, 232, 64, 180, 45, SWP_NOZORDER);
	m_btnSpeaker[1].SetBitmapFromFile(_T(IDB_SPEAKER_NORMAL_UP), _T(IDB_SPEAKER_NORMAL_DN));

	m_btnSpeaker[2].SetPushButton();
	m_btnSpeaker[2].SetWindowPos(NULL, 21, 163, 180, 45, SWP_NOZORDER);
	m_btnSpeaker[2].SetBitmapFromFile(_T(IDB_SPEAKER_SOFT_UP), _T(IDB_SPEAKER_SOFT_DN));

	m_btnSpeaker[3].SetPushButton();
	m_btnSpeaker[3].SetWindowPos(NULL, 232, 163, 180, 45, SWP_NOZORDER);
	m_btnSpeaker[3].SetBitmapFromFile(_T(IDB_SPEAKER_NORMAL_UP), _T(IDB_SPEAKER_NORMAL_DN));

	m_btnSpeaker[4].SetPushButton();
	m_btnSpeaker[4].SetWindowPos(NULL, 21, 261, 180, 45, SWP_NOZORDER);
	m_btnSpeaker[4].SetBitmapFromFile(_T(IDB_SPEAKER_SOFT_UP), _T(IDB_SPEAKER_SOFT_DN));

	m_btnSpeaker[5].SetPushButton();
	m_btnSpeaker[5].SetWindowPos(NULL, 232, 261, 180, 45, SWP_NOZORDER);
	m_btnSpeaker[5].SetBitmapFromFile(_T(IDB_SPEAKER_NORMAL_UP), _T(IDB_SPEAKER_NORMAL_DN));

	m_btnSpeaker[6].SetPushButton();
	m_btnSpeaker[6].SetWindowPos(NULL, 423, 261, 180, 45, SWP_NOZORDER);
	m_btnSpeaker[6].SetBitmapFromFile(_T(IDB_SPEAKER_MUTE_UP), _T(IDB_SPEAKER_MUTE_DN));

	// SUB_MODE_LCD
	m_btnLight[0].SetWindowPos(NULL, 24, 145, 42, 44, TRUE);
	m_btnLight[0].SetBitmapFromFile(_T(IDB_LCD_LEFT_UP), _T(IDB_LCD_LEFT_DN) );
    
	m_btnLight[1].SetWindowPos(NULL, 577, 145, 42, 44, TRUE);
	m_btnLight[1].SetBitmapFromFile(_T(IDB_LCD_RIGHT_UP), _T(IDB_LCD_RIGHT_DN) );

	m_stcLight.SetFontSize(50);
	m_stcLight.SetFontBold(TRUE);
	m_stcLight.SetBkColor(RGB(255, 255, 255));
	m_stcLight.SetWindowPos(NULL, 144, 25, 137+144, 47+25, SWP_NOZORDER);

	m_dcProgressBar[0].SetBitmap(_T(IDB_PROGRESS_NON) );
	m_dcProgressBar[1].SetBitmap(_T(IDB_PROGRESS_BAR) );
	
	m_stcLight.SetWindowText(_T("100%") );

	// SUB_MODE_RESET
	m_btnReset[0].SetWindowPos(NULL, 25, 122, 287, 72, TRUE);
	m_btnReset[0].SetBitmapFromFile(_T(IDB_CONFIG_RESET_OK_UP), _T(IDB_CONFIG_RESET_OK_DN));

	m_btnReset[1].SetWindowPos(NULL, 332, 122, 287, 72, TRUE);
	m_btnReset[1].SetBitmapFromFile(_T(IDB_CONFIG_RESET_CANCEL_UP), _T(IDB_CONFIG_RESET_CANCEL_DN));

	// SUB_MODE_SIMULATION
	m_btnSimulation[0].SetPushButton();
	m_btnSimulation[0].SetWindowPos(NULL, 40, 120, 148, 45, TRUE);
	m_btnSimulation[0].SetBitmapFromFile( _T(IDB_10SEC_UP), _T(IDB_10SEC_DN) );

	m_btnSimulation[1].SetPushButton();
	m_btnSimulation[1].SetWindowPos(NULL, 250, 120, 148, 45, TRUE);
	m_btnSimulation[1].SetBitmapFromFile( _T(IDB_20SEC_UP), _T(IDB_20SEC_DN) );

	m_btnSimulation[2].SetPushButton();
	m_btnSimulation[2].SetWindowPos(NULL, 460, 120, 148, 45, TRUE);
	m_btnSimulation[2].SetBitmapFromFile( _T(IDB_30SEC_UP), _T(IDB_30SEC_DN) );

	SetSubMode( SUB_MODE_MENU );

	return TRUE;  // return TRUE unless you set the focus to a control
}

BOOL CPageConfig::OnEraseBkgnd(CDC* pDC)
{	
	if( m_nSubMode == SUB_MODE_SPEAKER )
	{
		pDC->BitBlt(0, 0, 644, 318, m_pParent->m_dcPageBG[3].GetDC(), 0, 0, SRCCOPY);
	}
	else if( m_nSubMode == SUB_MODE_LCD )
	{
		pDC->BitBlt(0, 0, 644, 318, m_pParent->m_dcPageBG[4].GetDC(), 0, 0, SRCCOPY);
	}
	else
	{
		pDC->BitBlt(0, 0, 644, 318, m_pBGDC, 0, 0, SRCCOPY);
	}

	return 0;
}

void CPageConfig::OnPaint()
{
	CPaintDC dc(this); // device context for painting

	if( m_nSubMode == SUB_MODE_LCD )
	{
		UINT i=0;

		for(; i <= m_pStatus->GetBrightness(); i++)
		{
			dc.BitBlt( (i*50)+71, 149, 50, 36, m_dcProgressBar[1].GetDC(), 0, 0, SRCCOPY);
		}

		for(i = m_pStatus->GetBrightness()+1; i <= 9; i++)
		{
			dc.BitBlt( (i*50)+71, 149, 50, 36, m_dcProgressBar[0].GetDC(), 0, 0, SRCCOPY);
		}

	}
}

void CPageConfig::SetSubMode(UINT nSubMode)
{
	// HIDE ALL
	for(int i=0; i<6; i++)
	{
		m_btnMenu[i].ShowWindow(SW_HIDE);
	}

	for(int i=0; i<7; i++)
	{
		m_btnSpeaker[i].ShowWindow(SW_HIDE);
	}

	m_stcLight.ShowWindow(SW_HIDE);
	
	for(int i=0; i<2; i++)
	{
		m_btnLight[i].ShowWindow(SW_HIDE);
	}

	for(int i=0; i<2; i++)
	{
		m_btnReset[i].ShowWindow(SW_HIDE);
	}

	for(int i=0; i<3; i++)
	{
		m_btnSimulation[i].ShowWindow(SW_HIDE);
	}
	// HIDE ALL

	if( nSubMode == SUB_MODE_MENU )
	{
		for(int i=0; i<6; i++)
		{
			m_btnMenu[i].ShowWindow(SW_SHOW);
		}
	}
	else
	if( nSubMode == SUB_MODE_SPEAKER )
	{
		for(int i=0; i<7; i++)
		{
			m_btnSpeaker[i].ShowWindow(SW_SHOW);
		}

		m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_SPEAKER);
	}
	else
	if( nSubMode == SUB_MODE_LCD )
	{
		m_stcLight.ShowWindow(SW_SHOW);

		for(int i=0; i<2; i++)
		{
			m_btnLight[i].ShowWindow(SW_SHOW);
		}

		m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_LCD);

		OnClick_Light(0x00);
	}
	else
	if( nSubMode == SUB_MODE_RESET )
	{
		for(int i=0; i<2; i++)
		{
			m_btnReset[i].ShowWindow(SW_SHOW);
		}

		m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_RESET);
	}
	else
	if( nSubMode == SUB_MODE_TOUCH )
	{
	}
	else
	if( nSubMode == SUB_MODE_SIMULATION )
	{
		for(int i=0; i<3; i++)
		{
			m_btnSimulation[i].ShowWindow(SW_SHOW);
		}

		m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_SIMULATON);
	}
	else
	if( nSubMode == SUB_MODE_SPARE )
	{
	}

	m_nSubMode = nSubMode;

	RedrawWindow();
}

void CPageConfig::OnClick_Menu(UINT	nID)
{
	if( nID == IDC_BUTTON_SPEAKER )
	{
		SetSubMode( SUB_MODE_SPEAKER );
	}
	else if( nID == IDC_BUTTON_LCD )	
	{	
		SetSubMode( SUB_MODE_LCD );   
	}
	else if( nID == IDC_BUTTON_RESET )
	{
		SetSubMode( SUB_MODE_RESET );    
	}
	else if( nID == IDC_BUTTON_TOUCH )   
	{
		SetSubMode( SUB_MODE_SIMULATION );
	}
	else if( nID == IDC_BUTTON_SIMULATION )
	{
		m_pParent->m_mgrPage.ShowPage(PAGE_ID_CI);
		m_pParent->SendMessage(WM_CAPTION_SET, CAPTION_CONFIG_CI);
	}
	else if( nID == IDC_BUTTON_SPARE6 )    
	{
	}
	
}

void CPageConfig::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		SetSubMode( SUB_MODE_MENU );

		SetVariableToControl();
	}
}

void CPageConfig::SetVariableToControl()
{
	if( m_pParent->m_Status.GetIntSpeaker() == 0 )
	{
		OnClick_IntSpeaker( IDC_BTN_SPK_INT_SOFT );
	}
	else
	{
		OnClick_IntSpeaker( IDC_BTN_SPK_INT_NORMAL);
	}

	if( m_pParent->m_Status.GetExtSpeaker() == 0 )
	{
		OnClick_ExtSpeaker( IDC_BTN_SPK_EXT_SOFT );
	}
	else if( m_pParent->m_Status.GetExtSpeaker() == 1 )
	{
		OnClick_ExtSpeaker( IDC_BTN_SPK_EXT_NORMAL );
	}
	else if( m_pParent->m_Status.GetExtSpeaker() == 2 )
	{
		OnClick_ExtSpeaker( IDC_BTN_SPK_EXT_MUTE );
	}

	if( m_pParent->m_Route.GetSimulationTime() == 10 )
	{
		OnClick_Simulation(IDC_BTN_SIMULATION_10);
	}
	else if( m_pParent->m_Route.GetSimulationTime() == 20 )
	{
		OnClick_Simulation(IDC_BTN_SIMULATION_20);
	}
	else if( m_pParent->m_Route.GetSimulationTime() == 30 )
	{
		OnClick_Simulation(IDC_BTN_SIMULATION_30);
	}
}

// SUB_MODE_SPEAKER
void CPageConfig::OnClick_CabSpeaker(UINT	nID)
{
	if( nID == IDC_BTN_SPK_CAB_SOFT )
	{
		m_btnSpeaker[0].SetPush(TRUE);
		m_btnSpeaker[1].SetPush(FALSE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_CAB_SPEAKER, 0);
	}
	else
	if( nID == IDC_BTN_SPK_CAB_NORMAL )
	{
		m_btnSpeaker[0].SetPush(FALSE);
		m_btnSpeaker[1].SetPush(TRUE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_CAB_SPEAKER, 1);
	}
}

void CPageConfig::OnClick_IntSpeaker(UINT	nID)
{
	if( nID == IDC_BTN_SPK_INT_SOFT )
	{
		m_btnSpeaker[2].SetPush(TRUE);
		m_btnSpeaker[3].SetPush(FALSE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_INT_SPEAKER, 0);
	}
	else
	if( nID == IDC_BTN_SPK_INT_NORMAL )
	{
		m_btnSpeaker[2].SetPush(FALSE);
		m_btnSpeaker[3].SetPush(TRUE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_INT_SPEAKER, 1);
	}
}


void CPageConfig::OnClick_ExtSpeaker(UINT	nID)
{
	if( nID == IDC_BTN_SPK_EXT_SOFT )
	{
		m_btnSpeaker[4].SetPush(TRUE);
		m_btnSpeaker[5].SetPush(FALSE);
		m_btnSpeaker[6].SetPush(FALSE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_EXT_SPEAKER, 0);
	}
	else
	if( nID == IDC_BTN_SPK_EXT_NORMAL )
	{
		m_btnSpeaker[4].SetPush(FALSE);
		m_btnSpeaker[5].SetPush(TRUE);
		m_btnSpeaker[6].SetPush(FALSE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_EXT_SPEAKER, 1);
	}
	else
	if( nID == IDC_BTN_SPK_EXT_MUTE )
	{
		m_btnSpeaker[4].SetPush(FALSE);
		m_btnSpeaker[5].SetPush(FALSE);
		m_btnSpeaker[6].SetPush(TRUE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_EXT_SPEAKER, 2);
	}
}

void CPageConfig::OnClick_Light(UINT	nID)
{
	if( nID == IDC_BTN_LIGHT_DOWN )
	{
		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_BRIGHT, PARAM_BRIGHT_DOWN);
	}
	else 
	if( nID == IDC_BTN_LIGHT_UP )
	{
		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_BRIGHT, PARAM_BRIGHT_UP);
	}

	CString strBrightness;
	strBrightness.Format(_T("%d %%"), ( m_pStatus->GetBrightness()*10+10 ) );
	m_stcLight.SetWindowTextW(strBrightness);

	RedrawWindow();
}

void CPageConfig::OnClick_Reset(UINT	nID)
{
	if( nID == IDC_BTN_RESET_OK )
	{
		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_CONFIG_RESET);

		SetVariableToControl();
	}

	SetSubMode( SUB_MODE_MENU );
}

void CPageConfig::OnClick_Simulation(UINT	nID)
{
	if( nID == IDC_BTN_SIMULATION_10 )
	{
		m_btnSimulation[0].SetPush(TRUE);
		m_btnSimulation[1].SetPush(FALSE);
		m_btnSimulation[2].SetPush(FALSE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_SIMULATION_TIME, 10);
	}
	else
	if( nID == IDC_BTN_SIMULATION_20 )
	{
		m_btnSimulation[0].SetPush(FALSE);
		m_btnSimulation[1].SetPush(TRUE);
		m_btnSimulation[2].SetPush(FALSE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_SIMULATION_TIME, 20);
	}
	else
	if( nID == IDC_BTN_SIMULATION_30 )
	{
		m_btnSimulation[0].SetPush(FALSE);
		m_btnSimulation[1].SetPush(FALSE);
		m_btnSimulation[2].SetPush(TRUE);

		m_pParent->SendMessage(WM_FROM_PAGE_CONFIG, PARAM_SET_SIMULATION_TIME, 30);
	}
}

void CPageConfig::FreeResource()
{
	for(int i=0; i<6; i++) m_btnMenu[i].FreeResource();
	for(int i=0; i<7; i++) m_btnSpeaker[i].FreeResource();
	for(int i=0; i<2; i++) m_btnLight[i].FreeResource();
	for(int i=0; i<2; i++) m_dcProgressBar[i].FreeResource();
	for(int i=0; i<2; i++) m_btnReset[i].FreeResource();
	for(int i=0; i<3; i++) m_btnSimulation[i].FreeResource();
}
