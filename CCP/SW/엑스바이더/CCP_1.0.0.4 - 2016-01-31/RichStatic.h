#pragma once


// CRichStatic

class CRichStatic : public CStatic
{
	DECLARE_DYNAMIC(CRichStatic)

public:
	static enum FlashType {None, Text, Background };
	static enum BackFillMode { Normal, Gradient };

	CRichStatic();
	virtual ~CRichStatic();

    virtual CRichStatic& SetBkColor(COLORREF crBkgnd, COLORREF crBkgndHigh = 0, BackFillMode mode = Normal);
	virtual CRichStatic& SetTextColor(COLORREF crText);
	virtual CRichStatic& SetText(const CString& strText);
	virtual CRichStatic& SetFontBold(BOOL bBold);
    virtual CRichStatic& SetFontSize(int nSize);

protected:
    void UpdateSurface();
	void ReconstructFont();

    COLORREF		m_crText;
    COLORREF		m_cr3DHiliteColor;
    HBRUSH			m_hwndBrush;
	HBRUSH			m_hBackBrush;
    CFont			m_font;
    LOGFONT         m_lf;
    BOOL			m_bState;
    FlashType		m_Type;
    BackFillMode	m_fillmode;
    COLORREF		m_crHiColor;
	COLORREF		m_crLoColor;

    afx_msg void OnPaint();
    afx_msg BOOL OnEraseBkgnd(CDC* pDC);
    afx_msg void OnSysColorChange();

	DECLARE_MESSAGE_MAP()
    virtual void PreSubclassWindow();
    virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
};