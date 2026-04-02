#include "stdafx.h"

#include "util.h"

char *_WCtoMB(TCHAR *wc)
{
	char	*mb = new char[1024];

	WideCharToMultiByte( CP_ACP, 0, wc, -1, mb, 1024, NULL, NULL );

	return mb;
}

void _WCtoMB(TCHAR *wc, char *mb)
{
	WideCharToMultiByte( CP_ACP, 0, wc, -1, mb, 1024, NULL, NULL );
}

void _MBtoWC(char *mb, CString &strDest)
{
	TCHAR	*wc = new TCHAR[1024];

	MultiByteToWideChar( CP_ACP , 0, mb, -1, wc, 1024);

	strDest.Format(_T("%s"), wc);

	delete wc;
	
	return;
}