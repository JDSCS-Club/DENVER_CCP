// Page_Route.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PageRoute.h"

// CPageRoute 대화 상자입니다.

IMPLEMENT_DYNAMIC(CPageRoute, CDialog)

CPageRoute::CPageRoute(CWnd* pParent /*=NULL*/)
	: CDialog(CPageRoute::IDD, pParent)
{
	m_pParent = (CCCPDlg *)pParent;
	m_pBGDC		= m_pParent->m_dcPageBG[2].GetDC();
}

CPageRoute::~CPageRoute()
{
	//DeleteObject(m_hBmpBkgnd);
}

void CPageRoute::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_SCROLLBAR_ROUTE, m_scrScroll);
	DDX_Control(pDX, IDC_STOP_ONE, m_btnStop[0]);
	DDX_Control(pDX, IDC_STOP_TWO, m_btnStop[1]);
	DDX_Control(pDX, IDC_STOP_THREE, m_btnStop[2]);
	DDX_Control(pDX, IDC_STOP_FOUR, m_btnStop[3]);
	DDX_Control(pDX, IDC_STOP_FIVE, m_btnStop[4]);
	DDX_Control(pDX, IDC_STOP_SIX, m_btnStop[5]);
	DDX_Control(pDX, IDC_SKIP_ONE, m_btnSkip[0]);
	DDX_Control(pDX, IDC_SKIP_TWO, m_btnSkip[1]);
	DDX_Control(pDX, IDC_SKIP_THREE, m_btnSkip[2]);
	DDX_Control(pDX, IDC_SKIP_FOUR, m_btnSkip[3]);
	DDX_Control(pDX, IDC_SKIP_FIVE, m_btnSkip[4]);
	DDX_Control(pDX, IDC_SKIP_SIX, m_btnSkip[5]);
	DDX_Control(pDX, IDC_EXP_ONE, m_btnExpress[0]);
	DDX_Control(pDX, IDC_EXP_TWO, m_btnExpress[1]);
	DDX_Control(pDX, IDC_EXP_THREE, m_btnExpress[2]);
	DDX_Control(pDX, IDC_EXP_FOUR, m_btnExpress[3]);
	DDX_Control(pDX, IDC_EXP_FIVE, m_btnExpress[4]);
	DDX_Control(pDX, IDC_EXP_SIX, m_btnExpress[5]);
	DDX_Control(pDX, IDC_LOCAL_ONE, m_btnLocal[0]);
	DDX_Control(pDX, IDC_LOCAL_TWO, m_btnLocal[1]);
	DDX_Control(pDX, IDC_LOCAL_THREE, m_btnLocal[2]);
	DDX_Control(pDX, IDC_LOCAL_FOUR, m_btnLocal[3]);
	DDX_Control(pDX, IDC_LOCAL_FIVE, m_btnLocal[4]);
	DDX_Control(pDX, IDC_LOCAL_SIX, m_btnLocal[5]);
}

BEGIN_MESSAGE_MAP(CPageRoute, CDialog)
	ON_WM_ERASEBKGND()
	ON_WM_VSCROLL()
	ON_WM_ACTIVATE()
	ON_WM_PAINT()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_STOP_ONE, IDC_STOP_SIX,   &CPageRoute::OnClick_Stop)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_SKIP_ONE, IDC_SKIP_SIX,   &CPageRoute::OnClick_Skip)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_LOCAL_ONE, IDC_LOCAL_SIX,   &CPageRoute::OnClick_Local)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_EXP_ONE, IDC_EXP_SIX,   &CPageRoute::OnClick_Express)
END_MESSAGE_MAP()

// CPageRoute 메시지 처리기입니다.
BOOL CPageRoute::OnInitDialog()
{
	CDialog::OnInitDialog();

	CPaintDC	dc(this);

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	h_instance = AfxGetInstanceHandle();

	m_dcBufferBG.MakeBitmap(644, 318, 8);

	for(int i=0; i<6; i++)
	{
		m_btnStop[i].SetPushButton();
		m_btnStop[i].SetWindowPos(NULL, 245, 35+(i*46), 83, 39, TRUE);

		m_btnSkip[i].SetPushButton();
		m_btnSkip[i].SetWindowPos(NULL, 331, 35+(i*46), 83, 39, TRUE);

		m_btnExpress[i].SetWindowPos(NULL, 417, 35+(i*46), 83, 39, TRUE);

		m_btnLocal[i].SetWindowPos(NULL, 503, 35+(i*46), 83, 39, TRUE);
	}

	for(int i=0; i<6; i++)
	{
		m_btnStop[i].SetBitmapFromFile(_T(IDB_ROUTE_STOP_UP), _T(IDB_ROUTE_STOP_DN));
		m_btnSkip[i].SetBitmapFromFile(_T(IDB_ROUTE_SKIP_UP), _T(IDB_ROUTE_SKIP_DN));
		m_btnExpress[i].SetBitmapFromFile(_T(IDB_ROUTE_EXP_UP), _T(IDB_ROUTE_EXP_DN));
		m_btnLocal[i].SetBitmapFromFile(_T(IDB_ROUTE_LOCAL_UP), _T(IDB_ROUTE_LOCAL_DN));
	}
	
	return TRUE;  // return TRUE unless you set the focus to a control
	// 예외: OCX 속성 페이지는 FALSE를 반환해야 합니다.
}

BOOL CPageRoute::OnEraseBkgnd(CDC* pDC)
{
	pDC->BitBlt(0, 0, 644, 318, m_pBGDC, 0, 0, SRCCOPY);
	
	return 0;
}

void CPageRoute::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar)
{
	if( nSBCode	== SB_PAGEDOWN )
	{
		m_scrScroll.SetScrollPos( nPos + 6);
	}
	else
	if( nSBCode	== SB_PAGEUP )
	{
		m_scrScroll.SetScrollPos( nPos - 6);
	}
	else
	if( nSBCode	== SB_LINEDOWN )
	{
		m_scrScroll.SetScrollPos( nPos + 1);
	}
	else
	if( nSBCode	== SB_LINEUP )
	{
		m_scrScroll.SetScrollPos( nPos - 1);
	}
	else
	if( nSBCode	== SB_TOP )
	{
	}
	else
	if( nSBCode	== SB_THUMBTRACK )
	{
		m_scrScroll.SetScrollPos( nPos );
	}

	UpdateStationNames();

	CDialog::OnVScroll(nSBCode, nPos, pScrollBar);
}

void CPageRoute::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		UINT	nCount = m_pParent->m_Route.GetRouteCount();

		m_scrScroll.SetScrollRange(0, nCount-6);
		m_scrScroll.SetScrollPos(0);

		UpdateStationNames();
	}
}

void CPageRoute::UpdateStationNames()
{
	CDBSchedule	*dbSchedule;
	UINT	nScheduleCount = 0, nScheduleIndex = 0;

	nScheduleIndex = m_scrScroll.GetScrollPos();

	for(int i=0; i<6; i++)
	{
		dbSchedule = m_pParent->m_Route.GetStationByIndex( nScheduleIndex+i );
		if( dbSchedule == NULL ) continue;

		m_strStationName[i] = dbSchedule->GetStationName();

		if( dbSchedule->GetByPass() )
		{
			m_btnStop[i].SetPush(FALSE);
			m_btnSkip[i].SetPush(TRUE);
		}
		else
		{
			m_btnStop[i].SetPush(TRUE);
			m_btnSkip[i].SetPush(FALSE);

		}

		m_btnStop[i].RedrawWindow();
		m_btnSkip[i].RedrawWindow();
		m_btnLocal[i].RedrawWindow();
		m_btnExpress[i].RedrawWindow();
	}

	Invalidate(false);
}

void	CPageRoute::SetTrafficType(bool bByPass, UINT nStationIndex)
{
	CDBSchedule	*dbSchedule;
	UINT	nScheduleCount = 0, nScheduleIndex = 0;
	UINT	nRouteIndex =0;

	nScheduleIndex = m_scrScroll.GetScrollPos();
	nRouteIndex = ( nScheduleIndex + nStationIndex );

	if( nScheduleIndex == 0 && nStationIndex == 0 ) return;
	if( nRouteIndex == (m_pParent->m_Route.GetRouteCount() - 1)) return;

	dbSchedule = m_pParent->m_Route.GetStationByIndex( nScheduleIndex + nStationIndex );
	if( dbSchedule )
	{
		dbSchedule->SetByPass(bByPass);
	}

	UpdateStationNames();
}

void CPageRoute::OnClick_Stop(UINT	nID)
{
		 if( nID == IDC_STOP_ONE )		SetTrafficType(false, 0);
	else if( nID == IDC_STOP_TWO )		SetTrafficType(false, 1);
	else if( nID == IDC_STOP_THREE )	SetTrafficType(false, 2);
	else if( nID == IDC_STOP_FOUR )		SetTrafficType(false, 3);
	else if( nID == IDC_STOP_FIVE )		SetTrafficType(false, 4);
	else if( nID == IDC_STOP_SIX )		SetTrafficType(false, 5);

	//m_pParent->m_Route.SetSkipFlag();
}

void CPageRoute::OnClick_Skip(UINT	nID)
{
		 if( nID == IDC_SKIP_ONE )		SetTrafficType(true, 0);
	else if( nID == IDC_SKIP_TWO )		SetTrafficType(true, 1);
	else if( nID == IDC_SKIP_THREE )	SetTrafficType(true, 2);
	else if( nID == IDC_SKIP_FOUR )		SetTrafficType(true, 3);
	else if( nID == IDC_SKIP_FIVE )		SetTrafficType(true, 4);
	else if( nID == IDC_SKIP_SIX )		SetTrafficType(true, 5);

	//m_pParent->m_Route.SetSkipFlag();	
}

void CPageRoute::OnClick_Local(UINT	nID)
{

	CDBSchedule	*dbSchedule;
	UINT	nScheduleIndex = 0;

		 if( nID == IDC_LOCAL_ONE )		nScheduleIndex = 0;
	else if( nID == IDC_LOCAL_TWO )		nScheduleIndex = 1;
	else if( nID == IDC_LOCAL_THREE )	nScheduleIndex = 2;
	else if( nID == IDC_LOCAL_FOUR )	nScheduleIndex = 3;
	else if( nID == IDC_LOCAL_FIVE )	nScheduleIndex = 4;
	else if( nID == IDC_LOCAL_SIX )		nScheduleIndex = 5;
	
	nScheduleIndex += m_scrScroll.GetScrollPos() ;

	for(UINT i=0; i<=nScheduleIndex; i++)
	{
		dbSchedule = m_pParent->m_Route.GetStationByIndex( i );

		if( dbSchedule )
		{
			dbSchedule->SetByPass(false);
		}
	}

	UpdateStationNames();

	//m_pParent->m_Route.SetSkipFlag();
}

void CPageRoute::OnClick_Express(UINT	nID)
{
	CDBSchedule	*dbSchedule;
	UINT	nScheduleIndex = 0;

		 if( nID == IDC_EXP_ONE )	nScheduleIndex = 0;
	else if( nID == IDC_EXP_TWO )	nScheduleIndex = 1;
	else if( nID == IDC_EXP_THREE )	nScheduleIndex = 2;
	else if( nID == IDC_EXP_FOUR )	nScheduleIndex = 3;
	else if( nID == IDC_EXP_FIVE )	nScheduleIndex = 4;
	else if( nID == IDC_EXP_SIX )	nScheduleIndex = 5;
	
	nScheduleIndex += m_scrScroll.GetScrollPos();

	for(UINT i=1; i<=nScheduleIndex - 1; i++)
	{
		dbSchedule = m_pParent->m_Route.GetStationByIndex( i );

		if( dbSchedule )
		{
			dbSchedule->SetByPass(true);
		}
	}

	UpdateStationNames();

	//m_pParent->m_Route.SetSkipFlag();
}

void CPageRoute::OnPaint()
{
	CPaintDC	dc(this); // device context for painting
	CRect		rect;
	CDC			*pDC = m_dcBufferBG.GetDC();

	pDC->BitBlt(0, 0, 644, 318, m_pBGDC, 0, 0, SRCCOPY );

	pDC->SelectObject( &m_pParent->m_ftRoute );

	for(int i=0; i<6; i++)
	{
		rect.SetRect(22, 36+(i*46), 239, 73+(i*46));
		pDC->DrawText(m_strStationName[i], &rect, DT_LEFT | DT_VCENTER | DT_SINGLELINE);
	}

	dc.BitBlt(0, 0, 800, 480, pDC, 0, 0, SRCCOPY );
}

void CPageRoute::FreeResource()
{
	m_dcBufferBG.FreeResource();

	for(int i=0; i<6; i++)
	{
		m_btnStop[i].FreeResource();
		m_btnSkip[i].FreeResource();
		m_btnExpress[i].FreeResource();
		m_btnLocal[i].FreeResource();
	}
}