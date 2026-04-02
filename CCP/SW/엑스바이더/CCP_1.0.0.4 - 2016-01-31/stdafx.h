// stdafx.h : 자주 사용하지만 자주 변경되지는 않는
// 표준 시스템 포함 파일 및 프로젝트 관련 포함 파일이
// 들어 있는 포함 파일입니다.

#pragma once

#pragma comment(linker, "/nodefaultlib:libc.lib")
#pragma comment(linker, "/nodefaultlib:libcd.lib")

// 참고 - 이 값은 대상 Windows CE OS 버전과 밀접한 관련은 없습니다.
#define WINVER _WIN32_WCE

#ifndef VC_EXTRALEAN
#define VC_EXTRALEAN		// 거의 사용되지 않는 내용은 Windows 헤더에서 제외합니다.
#endif

#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS	// 일부 CString 생성자는 명시적으로 선언됩니다.
#ifdef _CE_DCOM
#define _ATL_APARTMENT_THREADED
#endif

// MFC의 공통 부분과 무시 가능한 경고 메시지에 대한 숨기기를 해제합니다.
#define _AFX_ALL_WARNINGS

#include <ceconfig.h>
#if defined(WIN32_PLATFORM_PSPC) || defined(WIN32_PLATFORM_WFSP)
#define SHELL_AYGSHELL
#endif

#include <afxwin.h>         // MFC 핵심 및 표준 구성 요소입니다.
#include <afxext.h>         // MFC 확장입니다.

#ifndef _AFX_NO_OLE_SUPPORT
#include <afxdtctl.h>		// Internet Explorer 4 공용 컨트롤에 대한 MFC 지원입니다.
#endif


#include <afxdisp.h>        // MFC 자동화 클래스입니다.

#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// Windows 공용 컨트롤에 대한 MFC 지원입니다.
#endif // _AFX_NO_AFXCMN_SUPPORT



#if defined(WIN32_PLATFORM_PSPC) || defined(WIN32_PLATFORM_WFSP)
#ifndef _DEVICE_RESOLUTION_AWARE
#define _DEVICE_RESOLUTION_AWARE
#endif
#endif

#ifdef _DEVICE_RESOLUTION_AWARE
#include "DeviceResolutionAware.h"
#endif


#if (_WIN32_WCE < 0x500) && ( defined(WIN32_PLATFORM_PSPC) || defined(WIN32_PLATFORM_WFSP) )
	#pragma comment(lib, "ccrtrtti.lib")
	#ifdef _X86_	
		#if defined(_DEBUG)
			#pragma comment(lib, "libcmtx86d.lib")
		#else
			#pragma comment(lib, "libcmtx86.lib")
		#endif
	#endif
#endif

#pragma warning(disable:4996)	//	_CRT_SECURE_NO_WARNINGS

#include <altcecrt.h>

#include "afxmt.h"

#include "util.h"
#include "bmpfile.h"
#include <afx.h>

// FORM_TO PAGE NUMBER
#define	PARAM_SET_TRAINNUMBER		0
#define	PARAM_SET_CREWID			1
#define PARAM_PASSWORD_CHECK		2
#define PARAM_PASSWORD_NEW			3
#define	PARAM_PASSWORD_VOL			4
#define PARAM_PASSWORD_CI			5

// FROM PAGE CONFIG
#define PARAM_SET_CAB_SPEAKER		0
#define	PARAM_SET_INT_SPEAKER		1
#define	PARAM_SET_EXT_SPEAKER		2
#define	PARAM_SET_BRIGHT			3
#define	PARAM_SET_SIMULATION_TIME	4
#define	PARAM_CONFIG_RESET			5

// PARAM_SET_BRIGHT - PARAM
#define PARAM_BRIGHT_UP				0
#define PARAM_BRIGHT_DOWN			1

// TO PAGE CAR
#define	PARAM_SET_CHECK				0
#define	PARAM_SET_PEI				1

// USER MESSAGE
#define	WM_CHANGE_NUMBER_MODE		(WM_USER+1)
#define	WM_CHANGE_CAR_TYPE			(WM_USER+2)

#define	WM_FROM_PAGE_NUMBER			(WM_USER+11)
#define	WM_FROM_PAGE_CONFIG			(WM_USER+12)

#define	WM_CAPTION_SET				(WM_USER+21)

#define	WM_WRITE_LOG				(WM_USER+31)

//#define	WM_REFRESH_MESSAGE			(WM_USER+32)

#define WM_TOUCH_LCD				(WM_USER+33)

#define WM_START_TOUCH_CAL			(WM_USER+34)
#define WM_STOP_TOUCH_CAL			(WM_USER+35)

#define WM_UPDATE					(WM_USER+41)

#define WM_SET_CROSS_TIME			(WM_USER+51)
#define WM_SET_ROUTE				(WM_USER+52)
#define WM_SET_CREWID				(WM_USER+53)

// DEVICE ID 
#define	ID_PAC_A					0x21
#define	ID_PAC_B					0x25

#define	ID_CCP_A					0x11
#define	ID_CCP_B					0x12

#define	ID_CNCS_A					0x24
#define	ID_CNCS_B					0x28

#define	ID_LIC_A					0x22
#define	ID_LIC_B					0x26

#define	COMMAND_INFO_REQ			0x10
#define	COMMAND_INFO_ACK			0x11

#define COMMAND_INFO_VER			0x12
#define COMMAND_INFO_ACK_VER		0x13