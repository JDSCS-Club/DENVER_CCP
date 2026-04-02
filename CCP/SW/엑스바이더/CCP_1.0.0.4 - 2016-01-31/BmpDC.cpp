#include "StdAfx.h"
#include "BmpDC.h"

CBmpDC::CBmpDC(void)
{
	m_bInit = false;
	oldBmp = NULL;
}

CBmpDC::~CBmpDC(void)
{
	m_DC.SelectObject( oldBmp );

	m_BMP.DeleteObject();
	m_DC.DeleteDC();
}

void CBmpDC::FreeResource(void)
{
	if( m_DC.GetSafeHdc() && oldBmp != NULL ) m_DC.SelectObject( oldBmp );

	if( m_BMP.GetSafeHandle() ) m_BMP.DeleteObject();
	
	if( m_DC.GetSafeHdc() ) m_DC.DeleteDC();

	m_bInit = false;
}
