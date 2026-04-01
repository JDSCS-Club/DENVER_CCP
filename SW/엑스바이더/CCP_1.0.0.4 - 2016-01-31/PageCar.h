#pragma once

#include "afxwin.h"
#include "BmpButton.h"
#include "CCPDlg.h"
#include "StatusVariable.h"
#include "BmpDC.h"


// CPageCar 대화 상자입니다.
class CCCPDlg;
class CStatusVariable;

class CPageCar : public CDialog
{
	DECLARE_DYNAMIC(CPageCar)

public:
	CPageCar(CWnd* pParent = NULL);   // 표준 생성자입니다.
	virtual ~CPageCar();

// 대화 상자 데이터입니다.
	enum { IDD = IDD_PAGE_PEI };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 지원입니다.

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();
	afx_msg void OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized);
	afx_msg LRESULT OnMsg_ChangeType(WPARAM wparam, LPARAM lparam);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	UINT GetCarMarriedType(CAR_DATA *pCarData);

private:
	HINSTANCE		h_instance; 
	CCCPDlg			*m_pParent;
	CStatusVariable	*m_pStatus;
	CPacket			*m_pPacket;

	UINT			m_nDisplayMode;		// 0 : CarList
										// 1 : Single 2 : Married A 3: Married B
	UINT			m_nDisplayType;		// 0 : CHECK	/ 1 : PEI

	UINT			m_nDisplayCarIndex;

	CBmpButton		m_BtnCar[12];

	CBmpButton		m_BtnSimulation;

	CFont			m_font;

	///////////////
	CBmpDC			m_dcArrow;
	CBmpDC			m_dcBG[5];
	CBmpDC			m_dcFDI1;
	CBmpDC			m_dcDPOA;
	//CBmpDC			m_dcTRIC1;
	CBmpDC			m_dcVOIPC1;
	CBmpDC			m_dcCCPA;
	CBmpDC			m_dcCRA;
	CBmpDC			m_dcPII1;
	CBmpDC			m_dcPID21;
	//
	CBmpDC			m_dcPII3;
	//CBmpDC			m_dcPID23;
	CBmpDC			m_dcDPHA;

	///////////////
	CBmpDC			m_dcFDI2;
	CBmpDC			m_dcDPOB;
	CBmpDC			m_dcVOIPC2;
	CBmpDC			m_dcCCPB;
	CBmpDC			m_dcCRB;
	CBmpDC			m_dcPII2;
	CBmpDC			m_dcPID22;
	//
	CBmpDC			m_dcPII4;
	//CBmpDC			m_dcPID24;
	CBmpDC			m_dcDPHB;

	///////////////
	CBmpDC			m_dcPID11;
	CBmpDC			m_dcPID12;
	CBmpDC			m_dcSDI1;
	CBmpDC			m_dcPEI1;
	//CBmpDC			m_dcCPO1;
	CBmpDC			m_dcSDI2;
	//
	CBmpDC			m_dcPID15;
	CBmpDC			m_dcPID16;
	CBmpDC			m_dcSDI5;
	CBmpDC			m_dcPEI4;
	//CBmpDC			m_dcCPO3;
	//CBmpDC			m_dcPEI5;
	CBmpDC			m_dcSDI6;

	///////////////
	CBmpDC			m_dcPID13;
	CBmpDC			m_dcPID14;
	CBmpDC			m_dcSDI3;
	CBmpDC			m_dcPEI2;
	//CBmpDC			m_dcCPO2;
	CBmpDC			m_dcPEI3;
	CBmpDC			m_dcSDI4;
	//
	CBmpDC			m_dcPID17;
	CBmpDC			m_dcPID18;
	CBmpDC			m_dcSDI7;
	//CBmpDC			m_dcCPO4;
	//CBmpDC			m_dcPEI6;
	CBmpDC			m_dcSDI8;

	CBmpDC			m_dcCI;
	//

	CBmpDC			m_dcPEICALL1;
	CBmpDC			m_dcPEICALL2;
	CBmpDC			m_dcPEICALL3;
	CBmpDC			m_dcPEICALL4;

	void UpdateCarList(bool bShow);
	afx_msg void OnClick_CarList(UINT nID);
	afx_msg void OnClick_Simulation();

public:
	//void DrawSingleCar(CDC *pDC, CAR_DATA *pCarData);
	void DrawMarriedACar(CDC *pDC, CAR_DATA *pCarData);
	void DrawMarriedBCar(CDC *pDC, CAR_DATA *pCarData);

	//void DrawPEISingleCar(CDC *pDC, CAR_DATA *pCarData);
	void DrawPEIMarriedACar(CDC *pDC, CAR_DATA *pCarData);
	void DrawPEIMarriedBCar(CDC *pDC, CAR_DATA *pCarData);

	//bool IsErrorSingleCar(CAR_DATA *pCarData);
	bool IsErrorMarriedACar(CAR_DATA *pCarData);
	bool IsErrorMarriedBCar(CAR_DATA *pCarData);

	//void setCarInfo(Car_Data_Info info_buf[]);
	afx_msg void OnPaint();
	//afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	//void OnUpdateScreen(Car_Data_Info info_buf[]);
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	void FreeResource();
	
	
};
