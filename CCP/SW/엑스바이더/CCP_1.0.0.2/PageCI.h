#pragma once

#include "afxwin.h"
#include "BmpButton.h"
#include "CCPDlg.h"
#include "StatusVariable.h"
#include "BmpDC.h"


// CPageCI 대화 상자입니다.
class CCCPDlg;
class CStatusVariable;

class CPageCI : public CDialog
{
	DECLARE_DYNAMIC(CPageCI)

public:
	CPageCI(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPageCI();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_CI };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	UINT GetCarMarriedType(CAR_DATA *pCarData);

private:
	HINSTANCE		h_instance; 
	CCCPDlg			*m_pParent;
	CStatusVariable	*m_pStatus;
	CPacket			*m_pPacket;

	UINT			m_nDisplayCarIndex;
	BYTE			m_byCI[8];
	CBmpButton		m_BtnCar[8];
	CBmpButton		m_btnAuto;
	CBmpButton		m_btnNumber[9];
	CBmpButton		m_btnApply;
	CFont			m_font;

	void UpdateCarList(bool bShow);
	afx_msg void OnClick_CarList(UINT nID);
	afx_msg void OnClick_Number(UINT nID);
	afx_msg void OnBnClickedBtnAuto();
	afx_msg void OnBnClickedBtnApply();	

public:
	//void setCarInfo(Car_Data_Info info_buf[]);
	afx_msg void OnPaint();
	//afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	//void OnUpdateScreen(Car_Data_Info info_buf[]);
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	void FreeResource();
};
