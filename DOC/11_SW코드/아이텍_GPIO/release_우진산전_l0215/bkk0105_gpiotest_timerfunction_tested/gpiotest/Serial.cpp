/*
 * @file	Serial.cpp
 * @brief	Serial통신
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */

#include "stdafx.h"
#include "Serial.h"

/*
 * CSerial()
 * 초기화
 * 
 * @param	...
 * @return	...
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */
CSerial::CSerial() : hPort(0), hMainWnd(0), hThreadComm(0)
{
	int i ;
	queue.Clear();

	// COM Port Check
	for ( i=0 ; i< 16 ; i++ ){

	}

}

/*
 * ~CSerial()
 * 소멸
 * 
 * @param	...
 * @return	...
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */
CSerial::~CSerial()
{
}

/*
 * OpenPort()
 * 지정한 포트를 연다. (WINCE)
 * Win CE는 nonoverlapped I/O만 지원된다.
 * 
 * @param	[hwnd] 프로그램의 핸들
 *			[port] 포트 번호
 *			[baud] 포트 속도
 * @return	...
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */
bool CSerial::OpenPort(HWND hwnd, int nPort, int nBaud)
{
	hMainWnd = hwnd;

	/// 포트를 연다.
	wchar_t lpszPort[6];
	wsprintf(lpszPort, L"COM%d:\0", nPort);
	hPort = CreateFile(lpszPort, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
	if (hPort == INVALID_HANDLE_VALUE)
	{
		MessageBox(hMainWnd, TEXT("Unable to open the serial port"), TEXT("Error"), MB_OK);
		return false;
	}

	/// 시리얼 포트를 설정한다.
	DCB PortDCB;
	PortDCB.DCBlength = sizeof(DCB);
	GetCommState(hPort, &PortDCB);
	PortDCB.BaudRate = nBaud;
	//PortDCB.fBinary = TRUE;
	PortDCB.fParity = TRUE;
	//PortDCB.fOutxCtsFlow = FALSE;
	//PortDCB.fOutxDsrFlow = FALSE;
	//PortDCB.fDtrControl = DTR_CONTROL_ENABLE;
	//PortDCB.fDsrSensitivity = FALSE;
	//PortDCB.fTXContinueOnXoff = TRUE;
	//PortDCB.fOutX = FALSE;
	//PortDCB.fInX = FALSE;
	//PortDCB.fErrorChar = FALSE;
	//PortDCB.fNull = FALSE;
	//PortDCB.fRtsControl = RTS_CONTROL_ENABLE; 
	//PortDCB.fAbortOnError = FALSE;
	PortDCB.ByteSize = 8;
	PortDCB.Parity = NOPARITY;
	PortDCB.StopBits = ONESTOPBIT;
	if (!SetCommState (hPort, &PortDCB))
	{
		MessageBox(hMainWnd, TEXT("Unable to configure the serial port"), TEXT("Error"), MB_OK);
		return false;
	}

	/// 타임-아웃을 설정한다.
	COMMTIMEOUTS CommTimeouts;
	GetCommTimeouts (hPort, &CommTimeouts);
	CommTimeouts.ReadIntervalTimeout = MAXDWORD;
	CommTimeouts.ReadTotalTimeoutMultiplier = 0;
	CommTimeouts.ReadTotalTimeoutConstant = 0;
	CommTimeouts.WriteTotalTimeoutMultiplier = 10;
	CommTimeouts.WriteTotalTimeoutConstant = 1000;
	if (!SetCommTimeouts (hPort, &CommTimeouts))
	{
		MessageBox(hMainWnd, TEXT("Unable to set the time-out parameters"), TEXT("Error"), MB_OK);
		return false;
	}

	/// 시리얼 통신에 이벤트를 받기 위해 쓰레드를 돌린다.
	/*DWORD dwThreadID;
	hThreadComm = CreateThread(0, 0, (LPTHREAD_START_ROUTINE)ThreadComm, this, 0, &dwThreadID);
	if (!hThreadComm)
	{
		ClosePort();
		return false;
	}*/

	return true;
}

/*
 * ClosePort()
 * 포트를 닫는다.
 * 
 * @param	...
 * @return	...
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */
bool CSerial::ClosePort()
{
	if (hPort == INVALID_HANDLE_VALUE)
		return false;

	SetCommMask(hPort, 0);
	PurgeComm(hPort, PURGE_TXABORT | PURGE_TXCLEAR | PURGE_RXABORT | PURGE_RXCLEAR);
	CloseHandle(hPort);

	return true;
}

/*
 * WriteComm()
 * 시리얼 포트에 데이터를 전송 한다. (WINCE)
 * Win CE는 nonoverlapped I/O만 지원된다.
 * 
 * @param	[pBuff] 전송할 데이터의 주소
 * @return	...
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */
DWORD CSerial::WriteComm(BYTE *pBuff)
{
	DWORD dwNumBytesWritten = 0;

	if (hPort != INVALID_HANDLE_VALUE)
	{
		WriteFile(hPort, pBuff, 1, &dwNumBytesWritten, NULL);
	}

	return dwNumBytesWritten;
}

/*
 * ReadComm()
 * 시리얼 포트로부터 데이터를 전송 받는다. (WINCE)
 * Win CE는 nonoverlapped I/O만 지원된다.
 * 
 * @param	[pBuff]   전송 받을 데이터의 주소
 *			[nToRead] 전송 받을 데이터의 바이트 수
 * @return	...
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */
DWORD CSerial::ReadComm(BYTE *pBuff)
{
	DWORD dwBytesTransferred;

	ReadFile(hPort, pBuff, 1, &dwBytesTransferred, NULL);

	return dwBytesTransferred;
}

/*
 * ThreadComm()
 * 시리얼 통신에 이벤트를 받기 위한 쓰레드
 * 
 * @param	...
 * @return	...
 * @author	kang, Se-Uk ( wine0327@nate.com )
 */
bool CSerial::ThreadComm(CSerial* pSerial)
{
	BYTE Byte[1024];
	DWORD dwBytesTransferred;

	SetCommMask(pSerial->hPort, EV_RXCHAR | EV_CTS | EV_DSR | EV_RLSD | EV_RING);

	while (pSerial->hPort != INVALID_HANDLE_VALUE) 
	{
		DWORD dwCommModemStatus;
		WaitCommEvent(pSerial->hPort, &dwCommModemStatus, 0);

		SetCommMask (pSerial->hPort, EV_RXCHAR | EV_CTS | EV_DSR | EV_RING);

		if (dwCommModemStatus & EV_RXCHAR)
		{
			do 
			{
				dwBytesTransferred = pSerial->ReadComm(Byte);
				if (BUFF_SIZE - pSerial->queue.GetSize() > (int)dwBytesTransferred)
				{
					for (DWORD i=0; i<dwBytesTransferred; i++)  pSerial->queue.PutByte(Byte[i]);
				}
				else
				{
					MessageBox(pSerial->hMainWnd, TEXT("Unable to write the queue"), TEXT("Error"), MB_OK);
				}
			} while (dwBytesTransferred);

			MessageBox(pSerial->hMainWnd, TEXT("OK"), TEXT("Receive"), MB_OK);
		}
	}

	pSerial->hThreadComm = NULL;
	return true;
}
