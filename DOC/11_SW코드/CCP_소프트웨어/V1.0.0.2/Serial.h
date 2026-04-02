#pragma once

#include "CCP.h"
#include "CCPDlg.h"
#include "StatusVariable.h"
#include "Packet.h"
#include "Update.h"

#define		STX		(0x01)
#define		ETX		(0x04)

class CCCPDlg;
class CDBRoute;
class CStatusVariable;

// CSerial
class CSerial : public CWinThread
{
	DECLARE_DYNCREATE(CSerial)

protected:

	CSerial();           // 동적 만들기에 사용되는 protected 생성자입니다.
	virtual ~CSerial();

public:
	
	virtual BOOL InitInstance();
	virtual int ExitInstance();

	bool	OpenPort();
	void	ClosePort();
	void	Flush(BOOL bRx, BOOL bTx);
	void	SetParent(CCCPDlg *pParent);
	
	DWORD	ReadPort(BYTE* pBuff, DWORD nToRead);
	DWORD	WritePort(BYTE *pBuff, DWORD nToWrite);

	void	SendToPAC(DWORD dwReviceTime);
	void	SendToCNCS();

	CEvent	m_terminateEvent;

protected:

	DECLARE_MESSAGE_MAP()

	CCCPDlg		*m_pParent;

	CDBRoute	*m_pRoute;
	CStatusVariable	*m_pStatus;
	CPacket		*m_pPacket;
	CUpdate		m_Update;

	bool		m_bIsConnected;		// comport가 열렸는지 확인
	bool		m_bIsActive;

	HANDLE		m_hComport;			// open한 comport의 핸들
	HANDLE		m_hThread;			// 생성한 thread의 핸들
	DWORD		m_dwIdThread;		// 생성한 thread의 ID
	BYTE		m_bySendBuff[4096];
	UINT		m_nPortNumber;

	bool		m_bReqTRIC;

	//DWORD		nTickRecvPAC;

public:
	virtual int Run();
};


