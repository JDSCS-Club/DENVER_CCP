// CCPDlg.h : 헤더 파일
//

#pragma once

enum CAPTION
{
	CAPTION_HOME = 0,
	CAPTION_TRAIN,
	CAPTION_CREW,
	CAPTION_ROUTE,
	CAPTION_CONFIG,
	CAPTION_CHECK,
	CAPTION_HELP,
	CAPTION_PEI,
	CAPTION_MESSAGE,
	CAPTION_CM,
	CAPTION_INPUT_CREW,
	CAPTION_INPUT_TRAIN,
	CAPTION_CONFIG_LCD,
	CAPTION_CONFIG_SPEAKER,
	CAPTION_CONFIG_RESET,
	CAPTION_CONFIG_SIMULATON,
	CAPTION_CONFIG_CI,
	CAPTION_HELP_HONE,
	CAPTION_HELP_TRAIN,
	CAPTION_HELP_CREW,
	CAPTION_HELP_ROUTE,
	CAPTION_HELP_CONFIG,
	CAPTION_HELP_CHECK,
	CAPTION_HELP_PEI,
	CAPTION_HELP_MESSAGE,
	//
	CAPTION_PEI_CALL,
	CAPTION_INAUGRATION,
	CAPTION_INAUGRATION_COMLETE,
	CAPTION_CABON,
	CAPTION_CABON2,
	CAPTION_TRAIN_NUMBER,
	CAPTION_TRAIN_NUMBER_OK,
	CAPTION_TRAIN_NUMBER_FAIL,
	CAPTION_SIMULATION,
	CAPTION_CI,
	CAPTION_SIZE
};

#include "afxext.h"
#include "afxwin.h"

#include "Serial.h"
#include "DBRoute.h"
#include "DBSchedule.h"
#include "StatusVariable.h"
#include "Packet.h"

#include "BmpButton.h"
//#include "ImageTextButton.h"
#include "RichStatic.h"

#include "PageManager.h"
#include "PageRoute.h"
#include "PageNumber.h"
#include "PageHelp.h"
#include "PageConfig.h"
#include "PageCar.h"
#include "PageCI.h"
#include "PageMessage.h"
#include "PagePR.h"

#include "BmpDC.h"

class CPageRoute;
class CPageNumber;
class CPageConfig;
class CPageHelp;
class CPageMessage;
class CPagePEI;
class CPagePR;
class CPageCar;
class CPageCI;
class CSerial;
class CStatusVariable;
class CDBRoute;

// CCCPDlg 대화 상자
class CCCPDlg : public CDialog
{
// 생성입니다.
public:
	CCCPDlg(CWnd* pParent = NULL);	// 표준 생성자입니다.

// 대화 상자 데이터입니다.
	enum { IDD = IDD_CCP_DIALOG };


	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 지원입니다.

// 구현입니다.
protected:
	HICON m_hIcon;

	// 생성된 메시지 맵 함수
	virtual BOOL OnInitDialog();
#if defined(_DEVICE_RESOLUTION_AWARE) && !defined(WIN32_PLATFORM_WFSP)
	afx_msg void OnSize(UINT /*nType*/, int /*cx*/, int /*cy*/);
#endif
	DECLARE_MESSAGE_MAP()

public:
	CSerial			*m_pSerial;

	CDBRoute		m_Route;
	CPacket			m_Packet;
	CStatusVariable m_Status;

	HANDLE			m_hGPI;

	CBmpDC			m_dcMainBG;
	CBmpDC			m_dcPageBG[9];
	CBmpDC			m_dcCaptionBG;

	CBmpDC			m_dcBoxType1;
	CBmpDC			m_dcBoxType2;
	CBmpDC			m_dcBoxTypeUpdate;
	CBmpDC			m_dcMainText;
	CBmpDC			m_dcNumberPad;
	CBmpDC			m_dcSpeakerText;
	CBmpDC			m_dcLCDBar;
	CBmpDC			m_dcCar;
	CBmpDC			m_dcCarCI;
	CBmpDC			m_dcLED[4];

	CDC				m_dcBufferBG;
	CBitmap			m_bmpBufferBG;

	CPageNumber		*m_pPageNumber;
	CPageRoute		*m_pPageRoute;
	CPageConfig		*m_pPageConfig;
	CPageHelp		*m_pPageHelp;
	CPageCar		*m_pPageCar;
	CPageCI			*m_pPageCI;
	CPagePR			*m_pPagePR;

	CPageManager	m_mgrPage;

	CBmpButton		m_btnMenu[9];

	TCHAR			m_arrCaption[35][64];
	UINT			m_nCaptionIndex;
	CFont			m_ftCaption;

	CString			m_strStatus[14];
	CRect			m_rectStatus[14];
	LOGFONT			m_lfStatus;
	CFont			m_ftStatus;
	COLORREF		m_crStatus;

	CString			m_strSchedule[16];
	CRect			m_rectSchedule[16];
	LOGFONT			m_lfSchedule;
	CFont			m_ftSchedule;
	CFont			m_ftRoute;
	COLORREF		m_crSchedule;

	DWORD			m_dwTickTouch;
	UINT			m_nCrossTime;

	DWORD			m_dwTickRecv;

	BOOL			m_bReceiveState;
	BOOL			m_bActiveCalibration;								// Calibration이 실행된 경우,

public:
	void InitSerial(void);
	void InitButton(void);
	void InitTimer(void);
	void DeinitTimer(void);

	void LoadBmp(void);
	void UnloadBmp(void);

	void MakeBG(CDC *pDC);
	void MakeBaseBG(CDC *pDC);
	void MakeNumberBG(CDC *pDC);
	void MakeRouteBG(CDC *pDC);
	void MakeConfigSpeakerBG(CDC *pDC);
	void MakeConfigLCDBG(CDC *pDC);
	void MakeCarBG(CDC *pDC);
	void MakeMessageBG(CDC *pDC);
	void MakeUpdateBG(CDC *pDC);
	void MakePRBG(CDC *pDC);
	void MakeCIBG(CDC *pDC);

	void DrawBoxType1(CDC *pDestDC, CDC *pSrcDC, CRect *pRect);	
	void DrawBoxType2(CDC *pDestDC, CDC *pSrcDC, CRect *pRect);	
	void DrawCaptoinBG(CDC *pDestDC, CDC *pSrcDC, CRect *pRect);

	void UpdateSchedule(void);
	void UpdateStatus(void);
	bool UpdateCaption(UINT nCaptionIndex);

	void DetectHardware(void);
	
	void UpdateButtonState( int nPageIndex );

	afx_msg void OnClick_Menu(UINT	nID);
	void RedrawButton(int nPageIndex);
	
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnClose();
	afx_msg void OnTimer(UINT_PTR nIDEvent);

	afx_msg LRESULT OnMsg_FromPageNumber(WPARAM wparam, LPARAM lparam);
	afx_msg LRESULT OnMsg_FromPageConfig(WPARAM wparam, LPARAM lparam);
	afx_msg LRESULT OnMsg_CaptionSet(WPARAM wparam, LPARAM lparam);
	afx_msg LRESULT OnMsg_TouchLCD(WPARAM wparam, LPARAM lparam);
	afx_msg LRESULT OnMsg_StartTouchCalibration(WPARAM wparam, LPARAM lparam);
	afx_msg LRESULT OnMsg_StopTouchCalibration(WPARAM wparam, LPARAM lparam);

	afx_msg LRESULT OnMsg_Update(WPARAM wparam, LPARAM lparam);
	afx_msg LRESULT OnMsg_CrossTime(WPARAM wparam, LPARAM lparam);

	afx_msg LRESULT OnMsg_SetRoute(WPARAM wparam, LPARAM lparam);
	afx_msg LRESULT OnMsg_SetCrewID(WPARAM wparam, LPARAM lparam);

	//
	void CheckMemoryUsage();
	afx_msg void OnPaint();

	bool StartSimulation( );
	void StopSimulation( );

	void SetConfigDefault( );
	afx_msg void OnDestroy();
};
