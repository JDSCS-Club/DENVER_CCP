#pragma once

#define		PAGE_ID_HOME		0
#define		PAGE_ID_TRAIN		1
#define		PAGE_ID_CREW		2
#define		PAGE_ID_ROUTE		3
#define		PAGE_ID_CONFIG		4
#define		PAGE_ID_CHECK		5
#define		PAGE_ID_HELP		6
#define		PAGE_ID_PEI			7
#define		PAGE_ID_CM			8
#define		PAGE_ID_CI			9

// CMgrPage 명령 대상입니다.

class CPageManager : public CObject
{
private:
	CMap <UINT, UINT&, CDialog*, CDialog*> m_mapPage;

	UINT	m_nCurrentPage;

public:
	UINT	GetCurrentPage();
	void	AddPage(int nPageIndex, CDialog *pPage);
	bool	ShowPage(int nPageIndex);

	CPageManager();
	virtual ~CPageManager();

};


