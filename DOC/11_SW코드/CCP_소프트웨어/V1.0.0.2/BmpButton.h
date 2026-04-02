#pragma once

#include "BmpDC.h"

// CBmpButton

class CBmpButton : public CBitmapButton
{
	DECLARE_DYNAMIC(CBmpButton)

public:
	CBmpButton();
	virtual ~CBmpButton();

protected:
	DECLARE_MESSAGE_MAP()


public:
	virtual void DrawItem(LPDRAWITEMSTRUCT /*lpDrawItemStruct*/);
	BOOL SetBitmapFromFile(TCHAR *img1, TCHAR *img2, TCHAR *img3 = NULL );
	BOOL SetBitmapFromFile(TCHAR *img1, TCHAR *img2, CDC *pDC);
	void ShowCaption()	{ m_bIsShowCaption = true; }
	void SetPushButton();
	void SetPush(BOOL bSetPush);

private:
	UINT	m_nImageHeight;
	UINT	m_nImageWidth;
	UINT	m_nImageCount;
	UINT	m_nTextAlign;

	CFont	m_font;
	CFont	m_ftCaption;
    LOGFONT m_lf;

	//CBitmap m_bmp_up;
	//CBitmap m_bmp_dn;	
	
	CBmpDC	m_dcBG;
	CBmpDC	m_dcUP, m_dcDN, m_dcUP2;

    BOOL    m_bIsShowCaption;
	BOOL	m_bIsPushButton;
	BOOL	m_bIsTwoState;
	BOOL	m_bSetPush;
	BOOL	m_bShowAlternate;

	CString	strTitle[2];

   COLORREF    m_clrCptnUpDwn;
   COLORREF    m_clrCptnDisabled;

   int		m_nTextOffsetX;
   int		m_nTextOffsetY;
public:
	void	SetShowCaption(bool bShowCaption)
	{
		m_bIsShowCaption = bShowCaption;
	}

	void	SetTwoState(bool bIsTwoState)
	{
		m_bIsTwoState = bIsTwoState;
	}

	void	SetAlternate(bool bSetAlternate)
	{
		m_bShowAlternate = bSetAlternate;
		Invalidate(FALSE);
	}

	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);

	void SetTextPosition(UINT nAlign)
	{
		m_nTextAlign = nAlign;
	}

	void SetButtonText(const CString &string )
	{
		strTitle[0] = string;
	}

	void SetButtonText2(const CString &string )
	{
		strTitle[1] = string;
	}

	void SetFont(CString srtFontName, int nFontSize)
	{
		m_lf.lfOrientation	= 0 ;
		m_lf.lfEscapement		= 0 ;

		m_lf.lfHeight			= nFontSize;
		
		m_lf.lfItalic  = FALSE;
		m_lf.lfUnderline = FALSE;
		m_lf.lfStrikeOut = FALSE;

		m_lf.lfCharSet		= DEFAULT_CHARSET;
		m_lf.lfQuality		= DEFAULT_QUALITY;
		m_lf.lfOutPrecision	= OUT_DEFAULT_PRECIS;
		m_lf.lfPitchAndFamily	= DEFAULT_PITCH;
		_tcscpy(m_lf.lfFaceName, srtFontName);
	
		//Normal Font
		m_lf.lfWeight			= FW_BOLD;	
		//m_ftCaption.CreateFontIndirect( &lfCtrl);
	}

	void SetFont(LOGFONT &lfCtrl, int nFontSize)
	{
		//lfCtrl.lfOrientation	= 0 ;
		//lfCtrl.lfEscapement		= 0 ;

		m_lf.lfHeight			= nFontSize;
		
		//lfCtrl.lfItalic  = FALSE;
		//lfCtrl.lfUnderline = FALSE;
		//lfCtrl.lfStrikeOut = FALSE;

		//lfCtrl.lfCharSet		= DEFAULT_CHARSET;
		//lfCtrl.lfQuality		= DEFAULT_QUALITY;
		//lfCtrl.lfOutPrecision	= OUT_DEFAULT_PRECIS;
		//lfCtrl.lfPitchAndFamily	= DEFAULT_PITCH;
		//_tcscpy(lfCtrl.lfFaceName, srtFontName);
	
		//Normal Font
		m_lf.lfWeight			= FW_BOLD;	
	}

	void SetTextColor(const COLORREF &clrUpDwn,const COLORREF &clrDisabled)
	{
		m_clrCptnUpDwn    = clrUpDwn;
		m_clrCptnDisabled = clrDisabled;
	}

	void SetButtonNumber( int nNumber )
	{
		strTitle[0].Format(_T("%d"), nNumber);
	}

	void SetTextOffset( int nTextOffsetX, int nTextOffsetY  )
	{
		m_nTextOffsetX = nTextOffsetX;
		m_nTextOffsetY = nTextOffsetY;
	}

	BOOL IsSetPush()
	{
		return m_bSetPush;
	}

	void FreeResource();
	afx_msg void OnPaint();
};


