// MgrPage.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "CCPDlg.h"
#include "PageManager.h"


// CPageManager

CPageManager::CPageManager()
{
	m_nCurrentPage = 0;
}

CPageManager::~CPageManager()
{
}


// CPageManager 멤버 함수
UINT	CPageManager::GetCurrentPage()
{
	return ( m_nCurrentPage );
}

void	CPageManager::AddPage(int nPageIndex, CDialog *pPage)
{
	UINT	nIndex = nPageIndex;

	m_mapPage.SetAt(nIndex, pPage);
}

bool	CPageManager::ShowPage(int nPageIndex)
{
	UINT nIndex = 0;

	CDialog* pDialog = NULL;

	if( m_nCurrentPage == PAGE_ID_CREW || 
		m_nCurrentPage == PAGE_ID_PASSWORD_CHECK || m_nCurrentPage == PAGE_ID_PASSWORD_NEW || 
		m_nCurrentPage == PAGE_ID_PASSWORD_VOL || m_nCurrentPage == PAGE_ID_PASSWORD_CI )
	{
		nIndex = PAGE_ID_TRAIN;
	}
	else
	if( m_nCurrentPage == PAGE_ID_PEI )
	{
		nIndex = PAGE_ID_CHECK;
	}
	else
	{
		nIndex = m_nCurrentPage;
	}

	m_mapPage.Lookup(nIndex, pDialog);

	if( nIndex > 0 )	pDialog->ShowWindow(SW_HIDE);

	if( nPageIndex == PAGE_ID_CREW || 
		nPageIndex == PAGE_ID_PASSWORD_CHECK || nPageIndex == PAGE_ID_PASSWORD_NEW || 
		nPageIndex == PAGE_ID_PASSWORD_VOL || nPageIndex == PAGE_ID_PASSWORD_CI )
	{
		nIndex = PAGE_ID_TRAIN;
	}
	else
	if( nPageIndex == PAGE_ID_PEI )
	{
		nIndex = PAGE_ID_CHECK;
	}
	else
	{
		nIndex = nPageIndex;
	}

	m_mapPage.Lookup(nIndex, pDialog);

	if( nPageIndex == PAGE_ID_TRAIN )
	{
		pDialog->SendMessage(WM_CHANGE_NUMBER_MODE, PARAM_SET_TRAINNUMBER);
	}
	else 
	if( nPageIndex == PAGE_ID_CREW )
	{
		pDialog->SendMessage(WM_CHANGE_NUMBER_MODE, PARAM_SET_CREWID);
	}
	else 
	if( nPageIndex == PAGE_ID_PASSWORD_CHECK )
	{
		pDialog->SendMessage(WM_CHANGE_NUMBER_MODE, PARAM_PASSWORD_CHECK);
	}
	else 
	if( nPageIndex == PAGE_ID_PASSWORD_NEW )
	{
		pDialog->SendMessage(WM_CHANGE_NUMBER_MODE, PARAM_PASSWORD_NEW);
	}
	else 
	if( nPageIndex == PAGE_ID_PASSWORD_VOL )
	{
		pDialog->SendMessage(WM_CHANGE_NUMBER_MODE, PARAM_PASSWORD_VOL);
	}
	else 
	if( nPageIndex == PAGE_ID_PASSWORD_CI )
	{
		pDialog->SendMessage(WM_CHANGE_NUMBER_MODE, PARAM_PASSWORD_CI);
	}
	else
	if( nPageIndex == PAGE_ID_CHECK )
	{
		pDialog->SendMessage(WM_CHANGE_CAR_TYPE, PARAM_SET_CHECK);
	}
	else 
	if( nPageIndex == PAGE_ID_PEI )
	{
		pDialog->SendMessage(WM_CHANGE_CAR_TYPE, PARAM_SET_PEI);
	}

	pDialog->ShowWindow(SW_SHOW);

	m_nCurrentPage = nPageIndex;

	return true;
}