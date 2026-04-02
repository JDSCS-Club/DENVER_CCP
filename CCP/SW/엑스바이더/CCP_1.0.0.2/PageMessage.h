#pragma once
#include "afxwin.h"
//#include <afxtempl.h>
#include "BmpButton.h"
#include "RichStatic.h"
#include "CCPDlg.h"

class CCCPDlg;
// CPageMessage 대화 상자입니다.

class CPageMessage : public CDialog
{
	DECLARE_DYNAMIC(CPageMessage)

public:
	CPageMessage(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPageMessage();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_MESSAGE };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnClick_Clear(UINT nID);
	afx_msg void OnClick_RePrint(UINT nID);

	afx_msg void OnPaint();
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);

	void UpdateMessage();
	void FreeResource();

private:
	
	void SetMessageFlag(UINT nFlagType, UINT	nMessageIndex );

	HINSTANCE	h_instance; 
	CCCPDlg		*m_pParent;
	CBmpDC		m_dcBufferBG;

	HBITMAP		m_hBmpPrint[2];
	CDC			m_dcPrint[2];

	CString		m_strMessage[6];
	CString		m_strMessageNo[6];

	CBmpButton	m_btnClear[6];	
	CBmpButton	m_btnReprint[6];

	CScrollBar	m_scrScroll;
};
