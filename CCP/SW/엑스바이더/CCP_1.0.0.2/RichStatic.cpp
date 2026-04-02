// RichStatic.cpp : implementation file
//

#include "stdafx.h"
#include "RichStatic.h"


// CRichStatic
#define SS_TYPEMASK         0x0000001FL

IMPLEMENT_DYNAMIC(CRichStatic, CStatic)

CRichStatic::CRichStatic()
{
    m_crText = GetSysColor(COLOR_WINDOWTEXT);
    m_hBackBrush = NULL;

    m_cr3DHiliteColor =	RGB(255,255,255);
	m_hwndBrush = ::CreateSolidBrush(GetSysColor(COLOR_3DFACE));
}

CRichStatic::~CRichStatic()
{
	// Clean up
	m_font.DeleteObject();
	::DeleteObject(m_hwndBrush);

	// Stop Checking complaining
	if (m_hBackBrush)
		::DeleteObject(m_hBackBrush);
}

BEGIN_MESSAGE_MAP(CRichStatic, CStatic)
    ON_WM_PAINT()
    ON_WM_ERASEBKGND()
    ON_WM_SYSCOLORCHANGE()
END_MESSAGE_MAP()

// CRichStatic message handlers
void CRichStatic::UpdateSurface()
{
	CRect (rc);
	GetWindowRect(rc);
	RedrawWindow();

	GetParent()->ScreenToClient(rc);
	GetParent()->InvalidateRect(rc,TRUE);
	GetParent()->UpdateWindow();
}

void CRichStatic::ReconstructFont()
{
	m_font.DeleteObject();

//	m_lf.lfHeight = 18;
	m_lf.lfWidth = 0; 
	m_lf.lfEscapement = 0; 
	m_lf.lfOrientation = 0; 
	m_lf.lfWeight = FW_BOLD; 
	m_lf.lfItalic = FALSE; 
	m_lf.lfUnderline = FALSE; 
	m_lf.lfStrikeOut = FALSE; 
	//m_lf.lfCharSet = JOHAB_CHARSET; 
	m_lf.lfOutPrecision = OUT_DEFAULT_PRECIS; 
	m_lf.lfClipPrecision = CLIP_DEFAULT_PRECIS; 
	m_lf.lfQuality = DEFAULT_QUALITY; 
	m_lf.lfPitchAndFamily = DEFAULT_PITCH;

    m_font.CreateFontIndirect(&m_lf);
}

void CRichStatic::OnPaint()
{
	CPaintDC dc(this); // device context for painting

	DWORD dwFlags = 0;

	CRect rc;
	GetClientRect(rc);
	CString strText;
	GetWindowText(strText);
	CBitmap bmp;

	///////////////////////////////////////////////////////
	// Set up for double buffering...
	//
	CDC* pDCMem;
	CBitmap*	pOldBitmap = NULL;

	pDCMem = new CDC;
	pDCMem->CreateCompatibleDC(&dc);
	bmp.CreateCompatibleBitmap(&dc,rc.Width(),rc.Height());
	pOldBitmap = pDCMem->SelectObject(&bmp);

	UINT nMode = pDCMem->SetBkMode(TRANSPARENT);

	COLORREF crText = pDCMem->SetTextColor(m_crText);
	CFont *pOldFont = pDCMem->SelectObject(&m_font);

	// Fill in backgound if not transparent

	CBrush br;
	
	if (m_hBackBrush != NULL)
		br.Attach(m_hBackBrush);
	else
		br.Attach(m_hwndBrush);
			
	pDCMem->FillRect(rc,&br);

	br.Detach();

	// If the text is flashing turn the text color on
	// then to the color of the window background.

	LOGBRUSH lb;
	ZeroMemory(&lb,sizeof(lb));

	// Stop Checking complaining
	if (m_hBackBrush) ::GetObject(m_hBackBrush,sizeof(lb),&lb);

	// Something to do with flashing
	if (!m_bState && m_Type == Text) pDCMem->SetTextColor(lb.lbColor);

	DWORD style = GetStyle();
	
	switch (style & SS_TYPEMASK)
	{
		case SS_RIGHT: 
			dwFlags = DT_RIGHT | DT_WORDBREAK| DT_SINGLELINE; 
			break; 
		
		case SS_CENTER: 
			dwFlags = SS_CENTER | DT_WORDBREAK | DT_SINGLELINE;
			break;

		case SS_LEFTNOWORDWRAP: 
			dwFlags = DT_LEFT; 
			break;

		default: // treat other types as left
			case SS_LEFT: 
				dwFlags = DT_LEFT | DT_WORDBREAK | DT_SINGLELINE; 
				break;
	}	

	// If the text centered make an assumtion that
	// the will want to center verticly as well
	if (style & SS_CENTERIMAGE)
	{
		dwFlags = DT_CENTER | DT_VCENTER; 
	}

	pDCMem->DrawText(strText,rc,dwFlags);

	// Restore DC's State
	pDCMem->SetBkMode(nMode);
	pDCMem->SelectObject(pOldFont);
	pDCMem->SetTextColor(crText);


	dc.BitBlt(0,0,rc.Width(),rc.Height(),pDCMem,0,0,SRCCOPY);

	// continue DC restore 
	pDCMem->SelectObject(pOldBitmap);

	bmp.DeleteObject();

	pDCMem->DeleteDC();
	delete pDCMem;
}

BOOL CRichStatic::OnEraseBkgnd(CDC* pDC)
{
    return 0;
}

void CRichStatic::PreSubclassWindow()
{
    CStatic::PreSubclassWindow();

	CFont* cf = GetFont();
	if(cf !=NULL)
	{
		cf->GetObject(sizeof(m_lf),&m_lf);
	}
	else
	{
		GetObject(GetStockObject(SYSTEM_FONT),sizeof(m_lf),&m_lf);
	}

	ReconstructFont();
}

BOOL CRichStatic::PreCreateWindow(CREATESTRUCT& cs)
{
    return CStatic::PreCreateWindow(cs);
}

void CRichStatic::OnSysColorChange() 
{
	if (m_hwndBrush) ::DeleteObject(m_hwndBrush);

	m_hwndBrush = ::CreateSolidBrush(GetSysColor(COLOR_3DFACE));
	
	UpdateSurface();
}

CRichStatic& CRichStatic::SetBkColor(COLORREF crBkgnd, COLORREF crBkgndHigh , BackFillMode mode)
{
	m_crLoColor = crBkgnd;
	m_crHiColor = crBkgndHigh;

	m_fillmode = mode;

	if (m_hBackBrush)
		::DeleteObject(m_hBackBrush);

	
	if (m_fillmode == Normal)
		m_hBackBrush = ::CreateSolidBrush(crBkgnd);

	UpdateSurface();

	return *this;
}

CRichStatic& CRichStatic::SetTextColor(COLORREF crText)
{
	m_crText = crText;
	
	UpdateSurface();
    return *this;
}

CRichStatic& CRichStatic::SetText(const CString& strText)
{
	if(IsWindow(this->GetSafeHwnd())) 
	{
		SetWindowText(strText);
		UpdateSurface();
	}

    return *this;
}

CRichStatic& CRichStatic::SetFontBold(BOOL bBold)
{
	m_lf.lfWeight = bBold ? FW_BOLD : FW_NORMAL;
	ReconstructFont();
	UpdateSurface();

    return *this;
}

CRichStatic& CRichStatic::SetFontSize(int nSize)
{
	CFont cf;
	LOGFONT lf;

	cf.CreatePointFont(nSize * 10, m_lf.lfFaceName);
	cf.GetLogFont(&lf);

	m_lf.lfHeight = lf.lfHeight;

	ReconstructFont();
	UpdateSurface();

    return *this;
}