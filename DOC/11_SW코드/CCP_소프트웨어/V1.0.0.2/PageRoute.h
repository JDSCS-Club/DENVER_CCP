#pragma once
#include "afxwin.h"
#include "BmpButton.h"
#include "CCPDlg.h"
#include "BmpDC.h"

class CCCPDlg;
// CPageRoute 대화 상자입니다.


class CPageRoute : public CDialog
{
	DECLARE_DYNAMIC(CPageRoute)

public:
	CPageRoute(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPageRoute();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_ROUTE };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()

private:
	HINSTANCE		h_instance; 
	CCCPDlg			*m_pParent;
	CDC				*m_pBGDC;
	CBmpDC			m_dcBufferBG;

	CString			m_strStationName[6];

	CBmpButton		m_btnStop[6];
	CBmpButton		m_btnSkip[6];
	CBmpButton		m_btnExpress[6];
	CBmpButton		m_btnLocal[6];

	CScrollBar		m_scrScroll;

private:
	void Init_ScrollBar();

	void OnClickExpress(int nBtnIndex);
	void OnClickLocal(int nBtnIndex);

	void UpdateStationNames();

	void SetTrafficType(bool bByPass, UINT nStationIndex);

public:	
	virtual BOOL OnInitDialog();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);

	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
	afx_msg void OnClick_Stop(UINT	nID);
	afx_msg void OnClick_Skip(UINT	nID);
	afx_msg void OnClick_Local(UINT	nID);
	afx_msg void OnClick_Express(UINT	nID);
	afx_msg void OnPaint();
	void FreeResource();
};
