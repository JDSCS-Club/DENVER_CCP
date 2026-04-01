#pragma once

class CDBCM
{
public:
	CDBCM(void);
	virtual ~CDBCM(void);

	CDBCM &operator=(const CDBCM& DBHoliday);

protected:
	// [PR번호] [PR 텍스트][LF+CR]
	UINT	m_nCMNo;
	CString	m_strCMText;

public:
	bool		SetData(UINT nCMNo, CString strCMText);
	UINT		GetCMNo(void)	{ return m_nCMNo; }
	CString		GetCMText(void)	{ return m_strCMText; }

};
