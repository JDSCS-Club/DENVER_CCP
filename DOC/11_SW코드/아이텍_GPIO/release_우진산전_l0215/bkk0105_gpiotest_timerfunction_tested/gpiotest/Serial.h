/*
 * @file	Serial.h
 * @brief	Serial≈ÎΩ≈
 * @author	Kang, Se-UK ( wine0327@nate.com )
 */

#pragma once

#include "Queue.h"
#include "UseMessage.h"

#define ASCII_LF     0x0a
#define ASCII_CR     0x0d
#define ASCII_XON    0x11
#define ASCII_XOFF   0x13

class CSerial
{
	HANDLE hPort;
	HWND hMainWnd;

	HANDLE hThreadComm;
	CQueue queue;

public:
	CSerial();
	~CSerial();

	bool OpenPort(HWND hwnd, int port, int baud);
	bool ClosePort();
	DWORD WriteComm(BYTE *pBuff);
	DWORD ReadComm(BYTE *pBuff);

protected:
	static bool ThreadComm(CSerial* pSerial);
};
