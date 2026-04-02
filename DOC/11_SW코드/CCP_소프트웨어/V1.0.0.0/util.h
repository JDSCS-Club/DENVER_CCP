#pragma once

#include "TCHAR.h"
#include "Windows.h"

char *_WCtoMB(TCHAR *wc);

void _WCtoMB(TCHAR *wc, char *mb);

void _MBtoWC(char *mb, CString &strDest);