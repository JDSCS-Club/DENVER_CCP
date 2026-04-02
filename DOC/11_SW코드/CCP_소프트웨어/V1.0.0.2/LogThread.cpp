// LogThread.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "LogThread.h"

#define	PATH_LOGDIR	"\\NandFlash\\LOG\\"

// CLogThread

IMPLEMENT_DYNCREATE(CLogThread, CWinThread)

CLogThread::CLogThread()
{
	m_bIsLogDir = FALSE;

	if( GetFileAttributes( _T(PATH_LOGDIR) ) != 0xFFFFFFFF )
	{
		m_bIsLogDir = TRUE;
	}
	else
	{
		m_bIsLogDir = CreateDirectory(_T(PATH_LOGDIR), NULL);
	}

	CFileStatus fs;
	bool bSetFile = false;
	
	for(int i=1; i<999999; i++)
	{
		m_strFileName = _T(PATH_LOGDIR);
		m_strFileName.AppendFormat(_T("CCP_%06d.txt"), i);

		if(!CFile::GetStatus(m_strFileName, fs))
		{
			bSetFile = true;
			break;
		}
	}

	if( !bSetFile )
	{
		m_strFileName = _T(PATH_LOGDIR);
		m_strFileName.AppendFormat(_T("CCP_1000000.txt") );		
	}

	if(m_stdFile.Open(m_strFileName, CFile::modeCreate | CFile::modeReadWrite | CFile::modeNoTruncate | CFile::shareDenyWrite))
		m_stdFile.SeekToEnd();
}

CLogThread::~CLogThread()
{
	if(m_stdFile.m_hFile != CFile::hFileNull ) m_stdFile.Close();
}

BOOL CLogThread::InitInstance()
{
	m_strArray.RemoveAll();

	return TRUE;
}

int CLogThread::ExitInstance()
{
	m_strArray.RemoveAll();

	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(CLogThread, CWinThread)
END_MESSAGE_MAP()


// CLogThread 메시지 처리기입니다.

void CLogThread::AddLog(const CString &in_strLog)
{
	//CString		strLog;
	//char		szLog[1024];
	//CTime		time = CTime::GetCurrentTime();
	//
	//strLog.Format(_T("[%02d:%02d:%02d] %s\r\n"),  time.GetHour(), time.GetMinute(), time.GetSecond(), in_strLog  );

	//ZeroMemory(szLog, 1024);
	//WideCharToMultiByte( CP_ACP, 0, strLog.GetBuffer(0), -1, szLog, 1024, NULL, NULL );

	//if(m_stdFile.m_hFile != CFile::hFileNull ) 
	//{
	//	m_stdFile.Write(szLog, strlen(szLog));
	//	m_stdFile.Flush();
	//}
}

int CLogThread::Run()
{
	CTime		time;
	CString		strFileName;
	CString		strLog;
	char		*szLog;
	CStdioFile	stdFiile;

	// TODO: 여기에 특수화된 코드를 추가 및/또는 기본 클래스를 호출합니다.
	while( m_bIsLogDir )
	{
		Sleep(33);

		if( !m_strArray.GetCount() ) continue;

		strLog = m_strArray.GetAt(0);
		m_strArray.RemoveAt(0);

		time = CTime::GetCurrentTime();

		szLog = _WCtoMB( strLog.GetBuffer(0) );

		if( stdFiile.Open(m_strFileName, CFile::modeCreate | CFile::modeReadWrite | CFile::modeNoTruncate | CFile::shareDenyWrite) )
		{
			stdFiile.SeekToEnd();
			stdFiile.Write(szLog, strlen(szLog));
			stdFiile.Close();
		}

		delete szLog;
	}

	m_strArray.RemoveAll();

	AfxEndThread(0);

	return CWinThread::Run();
}

void CLogThread::SetExit()
{
	m_bIsLogDir = false;

	m_strArray.RemoveAll();

	AfxEndThread(0);
}