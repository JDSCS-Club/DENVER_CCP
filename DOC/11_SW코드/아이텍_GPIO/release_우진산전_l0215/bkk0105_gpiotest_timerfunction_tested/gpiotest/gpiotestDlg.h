// gpiotestDlg.h : header file
//

#pragma once

// CgpiotestDlg dialog
class CgpiotestDlg : public CDialog
{
// Construction
public:
	CgpiotestDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	enum { IDD = IDD_GPIOTEST_DIALOG };

	CEdit m_EditGPI ;
	CEdit m_EditGPO ;
	CEdit m_EditGPOR ;

	CComboBox m_ComboBLCom ;

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
#if defined(_DEVICE_RESOLUTION_AWARE) && !defined(WIN32_PLATFORM_WFSP)
	afx_msg void OnSize(UINT /*nType*/, int /*cx*/, int /*cy*/);
#endif
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedGpioOpen();
	afx_msg void OnBnClickedGpioRead();
	afx_msg void OnBnClickedGpioWrite();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedComtest();
	afx_msg void OnBnClickedComopen();
	afx_msg void OnBnClickedComclose();
	afx_msg void OnBnClickedComtx();
	afx_msg void OnBnClickedButtonBlopen();
	afx_msg void OnBnClickedButtonBlauto();
	afx_msg void OnBnClickedButtonBlup();
	afx_msg void OnBnClickedButtonBldown();
	afx_msg void OnBnClickedButtonBlclose();
	afx_msg void OnBnClickedGpioRun();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnBnClickedButtonAlmack();
};
