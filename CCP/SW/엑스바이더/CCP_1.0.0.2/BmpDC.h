#pragma once

class CBmpDC
{
public:
	CBmpDC(void);
	~CBmpDC(void);


private:
	bool	m_bInit;
	CDC		m_DC;
	CBitmap	m_BMP, *oldBmp;
	BITMAP	m_bmp;


public:
	bool	IsInit()
	{
		return m_bInit;
	}

	bool	SetBitmap(TCHAR *wszBitmap)
	{
		m_bInit = true;

		m_BMP.DeleteObject();

		if( !m_BMP.Attach( SHLoadDIBitmap(wszBitmap) ) ) return false;
	
		if( !m_DC.CreateCompatibleDC(NULL) ) return false;

		oldBmp = m_DC.SelectObject( &m_BMP );

		m_BMP.GetBitmap(&m_bmp);

		return true;
	}

	bool	SetBitmap(TCHAR *wszBitmap, CDC *pDC)
	{
		m_bInit = true;

		m_BMP.DeleteObject();

		if( !m_BMP.Attach( SHLoadDIBitmap(wszBitmap) ) ) return false;
	
		if( !m_DC.CreateCompatibleDC(pDC) ) return false;

		oldBmp = m_DC.SelectObject( &m_BMP );

		m_BMP.GetBitmap(&m_bmp);

		return true;
	}

	bool	MakeBitmap(INT nWidth, UINT nHeight, UINT nDepth)
	{
		m_bInit = true;

		if( !m_DC.CreateCompatibleDC(NULL) ) return false;

		if( !m_BMP.CreateBitmap(nWidth, nHeight, 1, nDepth, NULL) ) return false;

		oldBmp = m_DC.SelectObject( &m_BMP );

		m_bmp.bmWidth = nWidth;
		m_bmp.bmHeight = nHeight;
	
		return true;
	}

	bool	MakeBitmap(INT nWidth, UINT nHeight, UINT nDepth, CDC *pDC)
	{
		m_bInit = true;

		if( !m_DC.CreateCompatibleDC(pDC) ) return false;

		if( !m_BMP.CreateBitmap(nWidth, nHeight, 1, nDepth, NULL) ) return false;

		oldBmp = m_DC.SelectObject( &m_BMP );

		m_bmp.bmWidth = nWidth;
		m_bmp.bmHeight = nHeight;
	
		return true;
	}

	UINT	Width()	{ return m_bmp.bmWidth; }
	UINT	Height()	{ return m_bmp.bmHeight;	}
	CDC		*GetDC()	{ return &m_DC; }
	void	FreeResource();
};
