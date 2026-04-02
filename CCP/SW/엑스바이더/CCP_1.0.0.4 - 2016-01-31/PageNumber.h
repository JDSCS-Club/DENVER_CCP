#pragma once

//class CPageNumber;
#include "afxwin.h"
#include "RichStatic.h"
#include "BmpButton.h"

class CCCPDlg;
// CPageNumber 대화 상자입니다.

class CPageNumber : public CDialog
{
	DECLARE_DYNAMIC(CPageNumber)

public:
	CPageNumber(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPageNumber();


// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_NUMBER };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	//void	SetUseCrewID()		{	m_bUseCrewID = true; }
	//void	SetUseTrainNumber()	{ 	m_bUseCrewID = false; }
	void	SetUseMode( UINT nMode )	{	m_nUseMode = nMode; }

	virtual BOOL OnInitDialog();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnClick_Num(UINT in_nID);
	afx_msg void OnClick_Clear();
	afx_msg void OnClick_Enter();
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
	afx_msg LRESULT OnMsg_ChangeMode(WPARAM wparam, LPARAM lparam);
	void FreeResource();

private:
	HINSTANCE		h_instance;
	CCCPDlg			*m_pParent;
	CDC				*m_pBGDC;

	//bool			m_bUseCrewID;
	UINT			m_nUseMode;

	CBmpButton		m_btnNumber[10];
	CBmpButton		m_btnClear;
	CBmpButton		m_btnEnter;

	CRichStatic		m_stcNumber;
	CString			m_strNumber;

	void InitButton(void);
	

};


