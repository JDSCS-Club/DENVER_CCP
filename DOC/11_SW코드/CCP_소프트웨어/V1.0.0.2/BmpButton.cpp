// MyBmpButton.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "BmpButton.h"


// CBmpButton

IMPLEMENT_DYNAMIC(CBmpButton, CBitmapButton)

CBmpButton::CBmpButton()
{
	m_lf.lfHeight = 25;
	m_lf.lfWidth = 0; 
	m_lf.lfEscapement = 0; 
	m_lf.lfOrientation = 0; 
	m_lf.lfWeight = FW_BOLD; 
	m_lf.lfItalic = FALSE; 
	m_lf.lfUnderline = FALSE; 
	m_lf.lfStrikeOut = FALSE; 
	m_lf.lfCharSet = JOHAB_CHARSET; 
	m_lf.lfOutPrecision = OUT_DEFAULT_PRECIS; 
	m_lf.lfClipPrecision = CLIP_DEFAULT_PRECIS; 
	m_lf.lfQuality = DEFAULT_QUALITY; 
	m_lf.lfPitchAndFamily = DEFAULT_PITCH; 

    //m_font.CreateFontIndirect(&m_lf);
	
	m_lf.lfHeight = 30;

	//m_ftCaption.CreateFontIndirect(&m_lf);

    m_bIsShowCaption = FALSE;
	m_bIsPushButton	 = FALSE;
	m_bIsTwoState	 = FALSE;
	m_bSetPush		= FALSE;
	m_bShowAlternate = FALSE;

	m_nTextAlign = DT_CENTER | DT_VCENTER | DT_SINGLELINE;

	m_clrCptnUpDwn		= RGB(0, 0, 0);
	m_clrCptnDisabled	= RGB(0, 0, 0);

	m_nTextOffsetX = 0;
	m_nTextOffsetY = 0;

}

CBmpButton::~CBmpButton()
{
	strTitle[0].ReleaseBuffer();
	strTitle[1].ReleaseBuffer();

	m_font.DeleteObject();
	m_ftCaption.DeleteObject();

	//m_bmp_dn.Detach();
	//m_bmp_up.Detach();

	//DeleteObject(m_bmp_dn);
	//DeleteObject(m_bmp_up);

	m_dcUP.FreeResource();
	m_dcDN.FreeResource();

	m_dcBG.FreeResource();
}

BEGIN_MESSAGE_MAP(CBmpButton, CBitmapButton)
	//ON_WM_ERASEBKGND()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONDBLCLK()
	ON_WM_PAINT()
END_MESSAGE_MAP()

// CBmpButton 메시지 처리기입니다.
void CBmpButton::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) 
{
	CRect rc;
	GetClientRect(rc);
	CFont *oldFont;
	
	CDC *pDC = CDC::FromHandle(lpDrawItemStruct->hDC);

	if( m_bSetPush )
	{
		if( m_bShowAlternate )
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP2.GetDC(), 0, 0, SRCCOPY);
		}
		else
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcDN.GetDC(), 0, 0, SRCCOPY);
		}
	}
	else
	if( !m_bIsTwoState )
	{
		if( ( lpDrawItemStruct->itemState & ( ODS_SELECTED | ODS_FOCUS ) ) == ( ODS_SELECTED | ODS_FOCUS ) )
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcDN.GetDC(), 0, 0, SRCCOPY);
		}
		else
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP.GetDC(), 0, 0, SRCCOPY);
		}
	}
	else
	{
		if( m_bShowAlternate )
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP2.GetDC(), 0, 0, SRCCOPY);
		}
		else
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP.GetDC(), 0, 0, SRCCOPY);
		}
	}

    if (m_bIsShowCaption)
	{
		m_ftCaption.CreateFontIndirect( &m_lf);

		m_dcBG.GetDC()->SetBkMode(TRANSPARENT);

		if(ODS_DISABLED & lpDrawItemStruct->itemState)
		{
			m_dcBG.GetDC()->SetTextColor( m_clrCptnDisabled );
		}
		else if(ODS_SELECTED & lpDrawItemStruct->itemState)
		{
			m_dcBG.GetDC()->SetTextColor( m_clrCptnUpDwn );
		}
		else
		{
			m_dcBG.GetDC()->SetTextColor( m_clrCptnUpDwn );
		}
		
		oldFont = m_dcBG.GetDC()->SelectObject(&m_ftCaption);

		rc.top += m_nTextOffsetX;
		rc.right += m_nTextOffsetY;

		if( m_bIsTwoState )
		{
			CRect rect[2];
			rect[0] = rect[1] = rc;
			rect[0].bottom -= ( rc.Height() / 2);
			rect[0].bottom += 5; rect[0].top += 5;

			rect[1].top += ( rc.Height() / 2);
			rect[1].bottom -= 5; rect[1].top -= 5;

			m_dcBG.GetDC()->DrawText(strTitle[0],rect[0], m_nTextAlign);
			m_dcBG.GetDC()->DrawText(strTitle[1],rect[1], m_nTextAlign);
		}
		else
		{
			m_dcBG.GetDC()->DrawText(strTitle[0],rc, m_nTextAlign);
		}


		m_dcBG.GetDC()->SelectObject( oldFont );

		m_ftCaption.DeleteObject();
	}

    pDC->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcBG.GetDC(), 0, 0, SRCCOPY);

	CDC::DeleteTempMap();
	pDC = NULL;
}

BOOL CBmpButton::SetBitmapFromFile(TCHAR *bitmapid1, TCHAR *bitmapid2, TCHAR *bitmapid3 )
{
	if( m_dcUP.IsInit() )	m_dcUP.FreeResource();
	if( m_dcDN.IsInit() )	m_dcDN.FreeResource();

	m_dcUP.SetBitmap( bitmapid1 );
	m_dcDN.SetBitmap( bitmapid2 );
	m_dcUP2.SetBitmap( bitmapid3 );

	m_nImageWidth = m_dcUP.Width();
	m_nImageHeight = m_dcUP.Height();

	if( !m_dcBG.IsInit() )
	{
		m_dcBG.MakeBitmap(m_dcUP.Width(), m_dcUP.Height(), 16);
	}

	GetWindowText(strTitle[0]);

	SetWindowPos( NULL, 0,0, m_nImageWidth, m_nImageHeight, SWP_NOMOVE|SWP_NOOWNERZORDER);

	return TRUE;
}

void CBmpButton::SetPushButton()
{
	m_bIsPushButton = TRUE;
}

void CBmpButton::SetPush(BOOL bSetPush)
{
	m_bSetPush = bSetPush;
	Invalidate(FALSE);
}

void CBmpButton::OnLButtonDown(UINT nFlags, CPoint point)
{
	// TODO: 여기에 메시지 처리기 코드를 추가 및/또는 기본값을 호출합니다.
	//CWnd	*pParent = GetParent();
	//pParent->SendNotifyMessageW(BN

	if( m_bIsPushButton )
	{
		//::SendMessage( ::GetParent( GetSafeHwnd() ),
		//				WM_COMMAND,
		//				(WPARAM)MAKELONG(::GetDlgCtrlID(  GetSafeHwnd() ), BN_CLICKED),
		//				(LPARAM)GetSafeHwnd() );
	}

	CBitmapButton::OnLButtonDown(nFlags, point);
}

void CBmpButton::OnLButtonDblClk(UINT nFlags, CPoint point)
{
	// TODO: 여기에 메시지 처리기 코드를 추가 및/또는 기본값을 호출합니다.
	if( m_bIsPushButton )
	{
	}
	else
	{
		CBitmapButton::OnLButtonDblClk(nFlags, point);
	}
}

void CBmpButton::FreeResource()
{
	strTitle[0].ReleaseBuffer();
	strTitle[1].ReleaseBuffer();

	m_font.DeleteObject();
	m_ftCaption.DeleteObject();

	//m_bmp_dn.Detach();
	//m_bmp_up.Detach();

	//DeleteObject(m_bmp_dn);
	//DeleteObject(m_bmp_up);

	m_dcUP.FreeResource();
	m_dcUP2.FreeResource();
	m_dcDN.FreeResource();

	m_dcBG.FreeResource();
}
void CBmpButton::OnPaint()
{
	CPaintDC dc(this); // device context for painting
	// TODO: 여기에 메시지 처리기 코드를 추가합니다.
	// 그리기 메시지에 대해서는 CBitmapButton::OnPaint()을(를) 호출하지 마십시오.
	CRect rc;
	GetClientRect(rc);
	CFont *oldFont;
	
	CDC *pDC = &dc;

	//if( m_bSetPush )
	//{
	//	m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcDN.GetDC(), 0, 0, SRCCOPY);
	//}
	//else
	//{
	//	m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP.GetDC(), 0, 0, SRCCOPY);
	//}

	if( m_bSetPush )
	{
		if( m_bShowAlternate )
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP2.GetDC(), 0, 0, SRCCOPY);
		}
		else
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcDN.GetDC(), 0, 0, SRCCOPY);
		}
	}
	else
	{
		if( m_bShowAlternate )
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP2.GetDC(), 0, 0, SRCCOPY);
		}
		else
		{
			m_dcBG.GetDC()->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcUP.GetDC(), 0, 0, SRCCOPY);
		}
	}

    if (m_bIsShowCaption)
	{
		m_ftCaption.CreateFontIndirect( &m_lf);

		m_dcBG.GetDC()->SetBkMode(TRANSPARENT);

		m_dcBG.GetDC()->SetTextColor( m_clrCptnUpDwn );
		
		oldFont = m_dcBG.GetDC()->SelectObject(&m_ftCaption);

		rc.top += m_nTextOffsetX;
		rc.right += m_nTextOffsetY;

		if( m_bIsTwoState )
		{
			CRect rect[2];
			rect[0] = rect[1] = rc;
			rect[0].bottom -= ( rc.Height() / 2);
			rect[0].bottom += 5; rect[0].top += 5;

			rect[1].top += ( rc.Height() / 2);
			rect[1].bottom -= 5; rect[1].top -= 5;

			m_dcBG.GetDC()->DrawText(strTitle[0],rect[0], m_nTextAlign);
			m_dcBG.GetDC()->DrawText(strTitle[1],rect[1], m_nTextAlign);
		}
		else
		{
			m_dcBG.GetDC()->DrawText(strTitle[0],rc, m_nTextAlign);
		}

		m_dcBG.GetDC()->SelectObject( oldFont );

		m_ftCaption.DeleteObject();
	}

    pDC->BitBlt(0, 0, m_nImageWidth, m_nImageHeight, m_dcBG.GetDC(), 0, 0, SRCCOPY);

	CDC::DeleteTempMap();
	pDC = NULL;
}
