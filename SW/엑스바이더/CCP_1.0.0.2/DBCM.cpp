#include "StdAfx.h"
#include "DBCM.h"

CDBCM::CDBCM(void)
{
	m_nCMNo = 0;
	m_strCMText = _T("");
}

CDBCM::~CDBCM(void)
{
}

bool	CDBCM::SetData(UINT nCMNo, CString strCMText)
{
	m_nCMNo = nCMNo;
	m_strCMText = strCMText;

	return true;
}

CDBCM &CDBCM::operator=(const CDBCM& DBConfig)
{
	m_nCMNo		= DBConfig.m_nCMNo;
	m_strCMText = DBConfig.m_strCMText;

	return *this;
}