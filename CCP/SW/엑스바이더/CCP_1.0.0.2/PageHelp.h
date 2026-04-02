#pragma once

#include "afxwin.h"
#include "RichStatic.h"
#include "BmpButton.h"
#include "CCPDlg.h"

#define	SHOW_MODE_MENU		1
#define	SHOW_MODE_HOME		2
#define	SHOW_MODE_TRAIN		3
#define	SHOW_MODE_CREW		4
#define	SHOW_MODE_ROUTE		5
#define	SHOW_MODE_CONFIG	6
#define	SHOW_MODE_CHECK		7
#define	SHOW_MODE_PEI		8
#define	SHOW_MODE_MESSAGE	9

#define	HELP_CONTENT_PATH		( "\\NandFlash\\help.txt" )


// CPageHelp 대화 상자입니다.
class CPageHelp : public CDialog
{
	DECLARE_DYNAMIC(CPageHelp)

public:
	CPageHelp(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPageHelp();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_HELP };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	afx_msg void OnClick_Menu(UINT	nID);

private:
	HINSTANCE		h_instance; 
	CCCPDlg			*m_pParent;
	//HBITMAP			m_hBmpBkgnd;
	CDC				*m_pBGDC;

	CBmpButton		m_btnHome;
	CBmpButton		m_btnTrain;
	CBmpButton		m_btnCrew;
	CBmpButton		m_btnRoute;
	CBmpButton		m_btnConfig;
	CBmpButton		m_btnCheck;
	CBmpButton		m_btnPei;
	CBmpButton		m_btnMessage;
	CRichStatic		m_stcVersion;

	CRichStatic		m_stcTitle;
	CEdit			m_edtContent;

	UINT			m_nShowMode;
	CString			m_strHelpContent;

	CBrush			m_brsEditBG;

	CFont			m_ftEdit;


	void	SetShowMode(UINT m_nShowMode); 
	void	LoadHelpData();
	
	BOOL GetFileVersion(LPWSTR lpFilePath, VS_FIXEDFILEINFO &rFi);
public:

};
