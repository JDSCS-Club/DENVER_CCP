#pragma once
#include "afxwin.h"

#include "BmpButton.h"
#include "RichStatic.h"
#include "BmpDC.h"

#include "CCPDlg.h"
#include "StatusVariable.h"

#define	SUB_MODE_MENU		0
#define	SUB_MODE_SPEAKER	1
#define	SUB_MODE_LCD		2
#define	SUB_MODE_RESET		3
#define	SUB_MODE_TOUCH		4
#define	SUB_MODE_SIMULATION	5
#define	SUB_MODE_SPARE		6

class CCCPDlg;

// CPageConfig 대화 상자입니다.

class CPageConfig : public CDialog
{
	DECLARE_DYNAMIC(CPageConfig)

public:
	CPageConfig(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPageConfig();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_CONFIG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);

private:
	CCCPDlg		*m_pParent;
	CStatusVariable		*m_pStatus;

	HINSTANCE h_instance; 
	//HBITMAP  m_hBmpBkgnd;
	//HBITMAP	 m_hBmpBkgnd_Speaker;
	//HBITMAP	 m_hBmpBkgnd_LCD;
	//HBITMAP	 m_hBmpBkgnd_Reset;
	CDC			*m_pBGDC;

	UINT		m_nSubMode;
	UINT		m_nChangeDirect;

	// SUB_MODE_MENU
	CBmpButton	m_btnMenu[6];

	// SUB_MODE_SPEAKER
	CBmpButton	m_btnSpeaker[7];

	// SUB_MODE_LCD
	//int			m_nBrightness[11];
	//int			m_nBrightValue;

	CRichStatic	 m_stcLight;
	CBmpButton	m_btnLight[2];
	CBmpDC		m_dcProgressBar[2];

	// SUB_MODE_RESET
	CBmpButton	 m_btnReset[2];

	// SUB_MODE_SIMULATION
	CBmpButton	 m_btnSimulation[3];


public:
	void SetSubMode(UINT nSubMode);
	afx_msg void OnClick_Menu(UINT	nID);
	afx_msg void OnClick_CabSpeaker(UINT	nID);
	afx_msg void OnClick_IntSpeaker(UINT	nID);
	afx_msg void OnClick_ExtSpeaker(UINT	nID);
	afx_msg void OnClick_Light(UINT	nID);
	afx_msg void OnClick_Reset(UINT	nID);
	afx_msg void OnClick_Touch();
	afx_msg void OnClick_Calibration();
	afx_msg void OnClick_Simulation(UINT	nID);

	void SetChangeDirect( UINT nSubMode ) { m_nChangeDirect = nSubMode; }
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
	void SetVariableToControl();
	afx_msg void OnPaint();
	void FreeResource();
};
