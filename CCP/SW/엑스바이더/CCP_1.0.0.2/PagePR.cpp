// PagePR.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PagePR.h"
#include "DBCM.h"

// CPagePR 대화 상자입니다.

IMPLEMENT_DYNAMIC(CPagePR, CDialog)

CPagePR::CPagePR(CWnd* pParent /*=NULL*/)
	: CDialog(CPagePR::IDD, pParent)
{
   m_pParent = (CCCPDlg *)pParent;
}

CPagePR::~CPagePR()
{
}

void CPagePR::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);

	DDX_Control(pDX, IDC_ACTIVATE_ONE, m_btnActivate[0]);
	DDX_Control(pDX, IDC_ACTIVATE_TWO, m_btnActivate[1]);
	DDX_Control(pDX, IDC_ACTIVATE_THREE, m_btnActivate[2]);
	DDX_Control(pDX, IDC_ACTIVATE_FOUR, m_btnActivate[3]);
	DDX_Control(pDX, IDC_ACTIVATE_FIVE, m_btnActivate[4]);
	DDX_Control(pDX, IDC_ACTIVATE_SIX, m_btnActivate[5]);

	DDX_Control(pDX, IDC_MSG_SCROLL, m_scrScroll);
}


BEGIN_MESSAGE_MAP(CPagePR, CDialog)
	ON_WM_ERASEBKGND()
	ON_WM_PAINT()
	ON_WM_VSCROLL()
	ON_WM_ACTIVATE()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_ACTIVATE_ONE, IDC_ACTIVATE_SIX,   &CPagePR::OnClick_Activate)
END_MESSAGE_MAP()


BOOL CPagePR::OnInitDialog()
{
	CDialog::OnInitDialog();

	CPaintDC	dc(this);

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	h_instance = AfxGetInstanceHandle();

	m_dcBufferBG.MakeBitmap(644, 318, 8);

	m_btnActivate[0].SetWindowPos(NULL, 502, 37, 83, 38, TRUE);
    m_btnActivate[0].SetBitmapFromFile( _T(IDB_PR_ACTIVATE_UP), _T(IDB_PR_ACTIVATE_DN) );

	m_btnActivate[1].SetWindowPos(NULL, 502, 82, 83, 38, TRUE);
    m_btnActivate[1].SetBitmapFromFile( _T(IDB_PR_ACTIVATE_UP), _T(IDB_PR_ACTIVATE_DN) );

	m_btnActivate[2].SetWindowPos(NULL, 502, 127, 83, 38, TRUE);
    m_btnActivate[2].SetBitmapFromFile( _T(IDB_PR_ACTIVATE_UP), _T(IDB_PR_ACTIVATE_DN) );

	m_btnActivate[3].SetWindowPos(NULL, 502, 173, 83, 38, TRUE);
    m_btnActivate[3].SetBitmapFromFile( _T(IDB_PR_ACTIVATE_UP), _T(IDB_PR_ACTIVATE_DN) );

	m_btnActivate[4].SetWindowPos(NULL, 502, 217, 83, 38, TRUE);
    m_btnActivate[4].SetBitmapFromFile( _T(IDB_PR_ACTIVATE_UP), _T(IDB_PR_ACTIVATE_DN) );

	m_btnActivate[5].SetWindowPos(NULL, 502, 262, 83, 38, TRUE);
    m_btnActivate[5].SetBitmapFromFile( _T(IDB_PR_ACTIVATE_UP), _T(IDB_PR_ACTIVATE_DN) );

	return TRUE;  // return TRUE unless you set the focus to a control
	// 예외: OCX 속성 페이지는 FALSE를 반환해야 합니다.
}

BOOL CPagePR::OnEraseBkgnd(CDC* pDC)
{
	pDC->BitBlt(0, 0, 644, 318, m_pParent->m_dcPageBG[8].GetDC(), 0, 0, SRCCOPY);

	return 0;
}

void CPagePR::OnPaint()
{
	CPaintDC dc(this); // device context for painting

	CDC			*pDC = m_dcBufferBG.GetDC();

	pDC->BitBlt(0, 0, 644, 318, m_pParent->m_dcPageBG[8].GetDC(), 0, 0, SRCCOPY );

	pDC->SetBkColor( RGB(255, 255, 255) );
	pDC->SelectObject( &m_pParent->m_ftRoute );

	CRect	rect;

	for(int i=0; i<6; i++)
	{
		rect.SetRect(20, 37+(i*45), 100, 74+(i*45));
		pDC->DrawText(m_strCMNo[i], &rect, DT_LEFT | DT_VCENTER | DT_SINGLELINE);

		rect.SetRect(70, 37+(i*45), 500, 74+(i*45));
		pDC->DrawText(m_strCMText[i], &rect, DT_LEFT | DT_VCENTER | DT_SINGLELINE);
	}

	dc.BitBlt(0, 0, 644, 318, pDC, 0, 0, SRCCOPY );
}


void CPagePR::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		UINT	nCount = m_pParent->m_Route.GetCMCount();

		m_scrScroll.SetScrollRange(0, nCount-6);
		m_scrScroll.SetScrollPos(0);

		UpdatePR();
	}
}

void CPagePR::UpdatePR()
{
	CDBCM	*dbCM;
	UINT	nCMCount = 0, nCMIndex = 0;

	nCMIndex = m_scrScroll.GetScrollPos();

	//for(int i=0; i<6; i++)
	//{
	//	dbCM = m_pParent->m_Route.GetCMByIndex( nCMIndex+i );

	//	m_strCMNo[i].Format( _T("%02d"), ( nCMIndex+i+1 ) );
	//	m_strCMText[i] = dbCM->GetCMText();

	//	if( m_pParent->m_Route.GetSelectedCM() == (nCMIndex+i) )
	//	{
	//		m_btnActivate[i].SetPush(TRUE);
	//	}
	//	else
	//	{
	//		m_btnActivate[i].SetPush(FALSE);
	//	}
	//}

	for(int i=0; i<6; i++)
	{
		//dbCM = m_pParent->m_Route.GetCMByIndex( nCMIndex+i );

		m_strCMNo[i].Format( _T("%02d"), ( nCMIndex+i+1 ) );
		m_strCMText[i].Format( _T("CM MESSAGES%d"), ( nCMIndex+i+1 ) );

		if( m_pParent->m_Route.GetSelectedCM() == (nCMIndex+i) )
		{
			m_btnActivate[i].SetPush(TRUE);
		}
		else
		{
			m_btnActivate[i].SetPush(FALSE);
		}
	}

	Invalidate(false);
}

void CPagePR::OnClick_Activate(UINT	nID)
{
	UINT	nCMCount = 0, nCMIndex = 0;

	nCMCount = m_pParent->m_Route.GetCMCount();
	nCMIndex = (nID - IDC_ACTIVATE_ONE) + m_scrScroll.GetScrollPos();

	if( nCMIndex >= nCMCount ) return;

	if( m_pParent->m_Route.GetSelectedCM() == nCMIndex )
	{
		m_pParent->m_Route.SetCMIndex( -1 );
	}
	else 
	{
		m_pParent->m_Route.SetCMIndex( nCMIndex );
	}

	UpdatePR();

}

void CPagePR::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar)
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

	UpdatePR();

	Invalidate(false);

	CDialog::OnVScroll(nSBCode, nPos, pScrollBar);
}

void CPagePR::FreeResource()
{
	m_dcBufferBG.FreeResource();

	for(int i=0; i<6; i++) m_btnActivate[i].FreeResource();
}