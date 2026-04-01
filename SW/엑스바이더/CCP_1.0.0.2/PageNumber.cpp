// Page_Train_Crew.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PageNumber.h"

#include "CCPDlg.h"

// CPageNumber 대화 상자입니다.

IMPLEMENT_DYNAMIC(CPageNumber, CDialog)

CPageNumber::CPageNumber(CWnd* pParent /*=NULL*/)
	: CDialog(CPageNumber::IDD, pParent)
{
	m_bUseCrewID = false;

	m_pParent = (CCCPDlg *)pParent;
	m_pBGDC		= m_pParent->m_dcPageBG[1].GetDC();
}

CPageNumber::~CPageNumber()
{
	//DeleteObject(m_hBmpBkgnd);
}

void CPageNumber::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_BUTTON_1, m_btnNumber[1]);
	DDX_Control(pDX, IDC_BUTTON_2, m_btnNumber[2]);
	DDX_Control(pDX, IDC_BUTTON_3, m_btnNumber[3]);
	DDX_Control(pDX, IDC_BUTTON_4, m_btnNumber[4]);
	DDX_Control(pDX, IDC_BUTTON_5, m_btnNumber[5]);
	DDX_Control(pDX, IDC_BUTTON_6, m_btnNumber[6]);
	DDX_Control(pDX, IDC_BUTTON_7, m_btnNumber[7]);
	DDX_Control(pDX, IDC_BUTTON_8, m_btnNumber[8]);
	DDX_Control(pDX, IDC_BUTTON_9, m_btnNumber[9]);
	DDX_Control(pDX, IDC_BUTTON_0, m_btnNumber[0]);
	DDX_Control(pDX, IDC_BUTTON_CLEAR, m_btnClear);
	DDX_Control(pDX, IDC_BUTTON_ENTER, m_btnEnter);
	DDX_Control(pDX, IDC_STATIC_TEXT, m_stcNumber);
}


BEGIN_MESSAGE_MAP(CPageNumber, CDialog)
	ON_WM_ERASEBKGND()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BUTTON_1, IDC_BUTTON_0,   &CPageNumber::OnClick_Num)
	ON_BN_CLICKED(IDC_BUTTON_CLEAR, &CPageNumber::OnClick_Clear)
	ON_BN_CLICKED(IDC_BUTTON_ENTER, &CPageNumber::OnClick_Enter)
	ON_WM_ACTIVATE()
	ON_MESSAGE(WM_CHANGE_NUMBER_MODE, &CPageNumber::OnMsg_ChangeMode)
END_MESSAGE_MAP()


// CPageNumber 메시지 처리기입니다.

BOOL CPageNumber::OnInitDialog()
{	
	CDialog::OnInitDialog();

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	h_instance = AfxGetInstanceHandle();

	InitButton();

	return TRUE;  // return TRUE unless you set the focus to a control
	// 예외: OCX 속성 페이지는 FALSE를 반환해야 합니다.
}

void CPageNumber::InitButton(void)
{
	m_stcNumber.SetFontSize(43);
	m_stcNumber.SetFontBold(TRUE);
	m_stcNumber.SetBkColor(RGB(214, 214, 214));
    m_stcNumber.MoveWindow(40, 42, 210, 60);

    m_btnNumber[1].MoveWindow(281-2, 34, 102, 53, TRUE);
    m_btnNumber[2].MoveWindow(400-2, 34, 102, 53, TRUE);
    m_btnNumber[3].MoveWindow(519-2, 34, 102, 53, TRUE);
    m_btnNumber[4].MoveWindow(281-2, 101, 102, 53, TRUE);
    m_btnNumber[5].MoveWindow(400-2, 101, 102, 53, TRUE);
    m_btnNumber[6].MoveWindow(519-2, 101, 102, 53, TRUE);
    m_btnNumber[7].MoveWindow(281-2, 168, 102, 53, TRUE);
    m_btnNumber[8].MoveWindow(400-2, 168, 102, 53, TRUE);
    m_btnNumber[9].MoveWindow(519-2, 168, 102, 53, TRUE);
    m_btnNumber[0].MoveWindow(400-2, 234, 102, 53, TRUE);

	for(int i=0; i<10; i++)
	{
		m_btnNumber[i].SetBitmapFromFile(_T(IDB_NUMBER_UP), _T(IDB_NUMBER_DN) );
		m_btnNumber[i].SetShowCaption(TRUE);
		m_btnNumber[i].SetTextColor( RGB(128, 0, 128), RGB(128, 0, 128) );
	}

    m_btnClear.MoveWindow(281-2, 234, 102, 53, TRUE);
    m_btnClear.SetBitmapFromFile(_T(IDB_NUMBER_UP), _T(IDB_NUMBER_DN) );
	m_btnClear.SetTextColor( RGB(128, 0, 128), RGB(128, 0, 128) );
    m_btnClear.SetShowCaption(TRUE);

    m_btnEnter.MoveWindow(519-2, 234, 102, 53, TRUE);
    m_btnEnter.SetBitmapFromFile(_T(IDB_NUMBER_UP), _T(IDB_NUMBER_DN) );
	m_btnEnter.SetTextColor( RGB(128, 0, 128), RGB(128, 0, 128) );
    m_btnEnter.SetShowCaption(TRUE);
}

BOOL CPageNumber::OnEraseBkgnd(CDC* pDC)
{
	pDC->BitBlt(0, 0, 644, 318, m_pBGDC, 0, 0, SRCCOPY);	

	m_strNumber= "000000";
	m_stcNumber.SetWindowTextW(_T("000000"));

	return 0;
}

void CPageNumber::OnClick_Num(UINT nID)
{
		 if( nID == IDC_BUTTON_1 )	m_strNumber += _T("1");
	else if( nID == IDC_BUTTON_2 )	m_strNumber += _T("2");
	else if( nID == IDC_BUTTON_3 )	m_strNumber += _T("3");
	else if( nID == IDC_BUTTON_4 )	m_strNumber += _T("4");
	else if( nID == IDC_BUTTON_5 )	m_strNumber += _T("5");
	else if( nID == IDC_BUTTON_6 )	m_strNumber += _T("6");
	else if( nID == IDC_BUTTON_7 )	m_strNumber += _T("7");
	else if( nID == IDC_BUTTON_8 )	m_strNumber += _T("8");
	else if( nID == IDC_BUTTON_9 )	m_strNumber += _T("9");
	else if( nID == IDC_BUTTON_0 )	m_strNumber += _T("0");

	m_strNumber= m_strNumber.Right(6);
	m_stcNumber.SetWindowTextW(m_strNumber);
}

void CPageNumber::OnClick_Clear()
{
	m_strNumber= _T("000000");
	m_stcNumber.SetWindowTextW(m_strNumber);
}

void CPageNumber::OnClick_Enter()
{
	if(	m_bUseCrewID )
	{
		m_pParent->SendMessage(WM_FROM_PAGE_NUMBER, PARAM_SET_CREWID, _tstoi( m_strNumber ) );
	}
	else
	{
		m_pParent->SendMessage(WM_FROM_PAGE_NUMBER, PARAM_SET_TRAINNUMBER, _tstoi( m_strNumber ) );
	}
}


void CPageNumber::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		OnClick_Clear();
	}
}

LRESULT CPageNumber::OnMsg_ChangeMode(WPARAM wparam, LPARAM lparam)
{
		 if( wparam == PARAM_SET_TRAINNUMBER )	SetUseTrainNumber();
	else if( wparam == PARAM_SET_CREWID )		SetUseCrewID();

	return 0;
}

void CPageNumber::FreeResource()
{
	for(int i=0; i<10; i++) m_btnNumber[i].FreeResource();

	m_btnClear.FreeResource();
	m_btnEnter.FreeResource();
}