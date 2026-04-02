// Page_Message.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PageMessage.h"

// CPageMessage 대화 상자입니다

IMPLEMENT_DYNAMIC(CPageMessage, CDialog)

CPageMessage::CPageMessage(CWnd* pParent /*=NULL*/)
	: CDialog(CPageMessage::IDD, pParent)
{
   m_pParent = (CCCPDlg *)pParent;
}

CPageMessage::~CPageMessage()
{

}

void CPageMessage::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);

	DDX_Control(pDX, IDC_CLEAR_ONE, m_btnClear[0]);
	DDX_Control(pDX, IDC_CLEAR_TWO, m_btnClear[1]);
	DDX_Control(pDX, IDC_CLEAR_THREE, m_btnClear[2]);
	DDX_Control(pDX, IDC_CLEAR_FOUR, m_btnClear[3]);
	DDX_Control(pDX, IDC_CLEAR_FIVE, m_btnClear[4]);
	DDX_Control(pDX, IDC_CLEAR_SIX, m_btnClear[5]);

	DDX_Control(pDX, IDC_REPRINT_ONE, m_btnReprint[0]);
	DDX_Control(pDX, IDC_REPRINT_TWO, m_btnReprint[1]);
	DDX_Control(pDX, IDC_REPRINT_THREE, m_btnReprint[2]);
	DDX_Control(pDX, IDC_REPRINT_FOUR, m_btnReprint[3]);
	DDX_Control(pDX, IDC_REPRINT_FIVE, m_btnReprint[4]);
	DDX_Control(pDX, IDC_REPRINT_SIX, m_btnReprint[5]);

	DDX_Control(pDX, IDC_MSG_SCROLL, m_scrScroll);
}

BEGIN_MESSAGE_MAP(CPageMessage, CDialog)
	ON_WM_ERASEBKGND()
	ON_WM_PAINT()
	ON_WM_VSCROLL()
	ON_WM_ACTIVATE()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_CLEAR_ONE, IDC_CLEAR_SIX,   &CPageMessage::OnClick_Clear)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_REPRINT_ONE, IDC_REPRINT_SIX,   &CPageMessage::OnClick_RePrint)
END_MESSAGE_MAP()

BOOL CPageMessage::OnInitDialog()
{
	CDialog::OnInitDialog();

	CPaintDC	dc(this);

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	h_instance = AfxGetInstanceHandle();

	m_dcBufferBG.MakeBitmap(644, 318, 8);

	m_hBmpPrint[0] = SHLoadDIBitmap( _T(IDB_MSG_PRINTED_UP) );
	m_hBmpPrint[1] = SHLoadDIBitmap( _T(IDB_MSG_PRINTED_DN) );

	m_btnClear[0].SetWindowPos(NULL, 416, 37, 83, 38, TRUE);
    m_btnClear[0].SetBitmapFromFile( _T(IDB_MSG_CLEAR_UP), _T(IDB_MSG_CLEAR_DN) );

	m_btnClear[1].SetWindowPos(NULL, 416, 82, 83, 38, TRUE);
    m_btnClear[1].SetBitmapFromFile( _T(IDB_MSG_CLEAR_UP),  _T(IDB_MSG_CLEAR_DN) );

	m_btnClear[2].SetWindowPos(NULL, 416, 127, 83, 38, TRUE);
    m_btnClear[2].SetBitmapFromFile( _T(IDB_MSG_CLEAR_UP),  _T(IDB_MSG_CLEAR_DN) );

	m_btnClear[3].SetWindowPos(NULL, 416, 172, 83, 38, TRUE);
    m_btnClear[3].SetBitmapFromFile( _T(IDB_MSG_CLEAR_UP),  _T(IDB_MSG_CLEAR_DN) );

	m_btnClear[4].SetWindowPos(NULL, 416, 217, 83, 38, TRUE);
    m_btnClear[4].SetBitmapFromFile( _T(IDB_MSG_CLEAR_UP),  _T(IDB_MSG_CLEAR_DN) );

	m_btnClear[5].SetWindowPos(NULL, 416, 262, 83, 38, TRUE);
    m_btnClear[5].SetBitmapFromFile( _T(IDB_MSG_CLEAR_UP),  _T(IDB_MSG_CLEAR_DN) );

	m_btnReprint[0].SetWindowPos(NULL, 502, 37, 83, 38, TRUE);
    m_btnReprint[0].SetBitmapFromFile( _T(IDB_MSG_REPRINT_UP), _T(IDB_MSG_REPRINT_DN) );

	m_btnReprint[1].SetWindowPos(NULL, 502, 82, 83, 38, TRUE);
    m_btnReprint[1].SetBitmapFromFile( _T(IDB_MSG_REPRINT_UP), _T(IDB_MSG_REPRINT_DN) );

	m_btnReprint[2].SetWindowPos(NULL, 502, 127, 83, 38, TRUE);
    m_btnReprint[2].SetBitmapFromFile( _T(IDB_MSG_REPRINT_UP), _T(IDB_MSG_REPRINT_DN) );

	m_btnReprint[3].SetWindowPos(NULL, 502, 173, 83, 38, TRUE);
    m_btnReprint[3].SetBitmapFromFile( _T(IDB_MSG_REPRINT_UP), _T(IDB_MSG_REPRINT_DN) );

	m_btnReprint[4].SetWindowPos(NULL, 502, 217, 83, 38, TRUE);
    m_btnReprint[4].SetBitmapFromFile( _T(IDB_MSG_REPRINT_UP), _T(IDB_MSG_REPRINT_DN) );

	m_btnReprint[5].SetWindowPos(NULL, 502, 262, 83, 38, TRUE);
    m_btnReprint[5].SetBitmapFromFile( _T(IDB_MSG_REPRINT_UP), _T(IDB_MSG_REPRINT_DN) );

	return TRUE;  // return TRUE unless you set the focus to a control
	// 예외: OCX 속성 페이지는 FALSE를 반환해야 합니다.
}

void CPageMessage::OnClick_Clear(UINT	nID)
{
		 if( nID == IDC_CLEAR_ONE )		SetMessageFlag(0, 0);
	else if( nID == IDC_CLEAR_TWO )		SetMessageFlag(0, 1);
	else if( nID == IDC_CLEAR_THREE )	SetMessageFlag(0, 2);
	else if( nID == IDC_CLEAR_FOUR )	SetMessageFlag(0, 3);
	else if( nID == IDC_CLEAR_FIVE )	SetMessageFlag(0, 4);
	else if( nID == IDC_CLEAR_SIX )		SetMessageFlag(0, 5);

	Invalidate(false);
}

void CPageMessage::OnClick_RePrint(UINT	nID)
{
		 if( nID == IDC_REPRINT_ONE )	SetMessageFlag(1, 0);
	else if( nID == IDC_REPRINT_TWO )	SetMessageFlag(1, 1);
	else if( nID == IDC_REPRINT_THREE )	SetMessageFlag(1, 2);
	else if( nID == IDC_REPRINT_FOUR )	SetMessageFlag(1, 3);
	else if( nID == IDC_REPRINT_FIVE )	SetMessageFlag(1, 4);
	else if( nID == IDC_REPRINT_SIX )	SetMessageFlag(1, 5);

	Invalidate(false);
}

void CPageMessage::SetMessageFlag(UINT	nFlagType, UINT	nMessageIndex )
{
	CDBMessageElement	*dbElement;
	UINT				nPageIndex = 0;
	
	dbElement = m_pParent->m_Message.GetElement( m_scrScroll.GetScrollPos() + nMessageIndex );
	if( dbElement )
	{
		if( nFlagType == 0 )
		{
			dbElement->SetFlagClear(1);
		}
		else if( nFlagType == 1 )
		{
			dbElement->SetFlagPrint(1);
		}
	}

	UpdateMessage();
}

BOOL CPageMessage::OnEraseBkgnd(CDC* pDC)
{
	pDC->BitBlt(0, 0, 644, 318, m_pParent->m_dcPageBG[6].GetDC(), 0, 0, SRCCOPY);

	return 0;
}

void CPageMessage::OnPaint()
{

	CPaintDC dc(this); // device context for painting

	CDC			*pDC = m_dcBufferBG.GetDC();

	pDC->BitBlt(0, 0, 644, 318, m_pParent->m_dcPageBG[6].GetDC(), 0, 0, SRCCOPY );
	
	CRect	rect;
	CDC dcPrint[2];

	dcPrint[0].CreateCompatibleDC(&dc);
	dcPrint[1].CreateCompatibleDC(&dc);

	dcPrint[0].SelectObject( m_hBmpPrint[0] );
	dcPrint[1].SelectObject( m_hBmpPrint[1] );

	CDBMessageElement	*dbElement;
	UINT	nMessageCount = 0, nMessageIndex = 0;

	nMessageIndex = m_scrScroll.GetScrollPos();

	pDC->SetBkColor( RGB(255, 255, 255) );
	pDC->SelectObject( &m_pParent->m_ftRoute );

	for(int i=0; i<6; i++)
	{
		dbElement = m_pParent->m_Message.GetElement( nMessageIndex + i );

		if( dbElement )
		{
			if( dbElement->GetFlagPrint() == 2 )
			{
				pDC->BitBlt( 331, 37 + (45 * i), 83, 38, &dcPrint[1], 0, 0, SRCCOPY);
			}
			else
			{
				pDC->BitBlt( 331, 37 + (45 * i), 83, 38, &dcPrint[0], 0, 0, SRCCOPY);
			}
		}
		else
		{
			pDC->BitBlt( 331, 37 + (45 * i), 83, 38, &dcPrint[0], 0, 0, SRCCOPY);
		}

		rect.SetRect(17, 37+(i*45), 55, 74+(i*45));
		pDC->DrawText(m_strMessageNo[i], &rect, DT_LEFT | DT_VCENTER | DT_SINGLELINE);

		rect.SetRect(63, 37+(i*45), 325, 74+(i*45));
		pDC->DrawText(m_strMessage[i], &rect, DT_LEFT | DT_VCENTER | DT_SINGLELINE);
	}

	dc.BitBlt(0, 0, 644, 318, pDC, 0, 0, SRCCOPY );

	dcPrint[0].DeleteDC();
	dcPrint[1].DeleteDC();
}


void CPageMessage::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		m_scrScroll.SetScrollPos(0);
		
		UpdateMessage();
	}
}

void CPageMessage::UpdateMessage()
{
	CDBMessageElement	*dbElement;
	UINT	nMessageCount = 0, nMessageIndex = 0;
	CString	strElement, strMessage;

	nMessageCount = m_pParent->m_Message.GetCount();
	m_scrScroll.SetScrollRange(0, nMessageCount-6);

	nMessageIndex = m_scrScroll.GetScrollPos();

	int i = 0;
	for(; i < 6 && nMessageCount ; i++)
	{
		dbElement = m_pParent->m_Message.GetElement( nMessageIndex + i );

		if( dbElement )
		{
			m_strMessageNo[i].Format(_T("%d"),  (nMessageIndex + i + 1) );

			dbElement->GetDate( strElement );

			m_strMessage[i].Format( _T("20%s/%s/%s %s:%s:%s"),
								strElement.Mid(0, 2), strElement.Mid(2, 2), strElement.Mid(4, 2), 
								strElement.Mid(6, 2), strElement.Mid(8, 2), strElement.Mid(10, 2) );
		}
		else
		{
			m_strMessageNo[i] = _T("");
			m_strMessage[i] = _T("");
		}
	}

	for(; i < 6 ; i++)
	{
		m_strMessageNo[i] = _T("");
		m_strMessage[i] = _T("");
	}

	Invalidate(false);
}

void CPageMessage::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar)
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

	UpdateMessage();
	Invalidate(false);

	CDialog::OnVScroll(nSBCode, nPos, pScrollBar);
}

void CPageMessage::FreeResource()
{
	m_dcBufferBG.FreeResource();

	DeleteObject(m_hBmpPrint[0]);
	DeleteObject(m_hBmpPrint[1]);

	m_dcPrint[0].DeleteDC();
	m_dcPrint[1].DeleteDC();

	for(int i=0; i<6; i++) m_btnClear[i].FreeResource();
	for(int i=0; i<6; i++) m_btnReprint[i].FreeResource();
}