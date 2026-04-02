#pragma once
#include "afxwin.h"
#include "BmpButton.h"
#include "RichStatic.h"
#include "CCPDlg.h"

class CCCPDlg;
// CPagePR 대화 상자입니다.

class CPagePR : public CDialog
{
	DECLARE_DYNAMIC(CPagePR)

public:
	CPagePR(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPagePR();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_PR };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);

	afx_msg void OnPaint();
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
	afx_msg void OnClick_Activate(UINT	nID);

	void UpdatePR();
	void FreeResource();

private:

	HINSTANCE	h_instance; 
	CCCPDlg		*m_pParent;
	CBmpDC		m_dcBufferBG;

	CString		m_strCMNo[6];
	CString		m_strCMText[6];

	CBmpButton	m_btnActivate[6];

	CScrollBar	m_scrScroll;
};
