#pragma once

#include "DBTrigger.h"

// CDBSchedule 명령 대상입니다.
class CDBSchedule : public CObject
{
public:
	CDBSchedule();
	virtual ~CDBSchedule();

	 CDBSchedule &operator=(const CDBSchedule& DBScheduleObject);

public:
	void	SetStationCode(UINT nVal){ m_nStationCode = nVal; }
	void	SetArrivalTime(int nVal){ m_nArrivalTime = nVal; }
	void	SetDepartureTime(int nVal){ m_nDepartureTime = nVal; }
	void	SetStationInfo(UINT nVal){ m_nStationInfo = nVal; }
	void	SetByPass(bool bVal){ m_bByPass = bVal; }
	void	SetTurningPoint(bool bVal){ m_bTurningPoint = bVal; }
	void	SetStationName(CString strVal){ m_strStationName = strVal; }
	void	SetCenterCity(bool bVal){ m_bCenterCity = bVal; }
	void	SetSecondaryName(CString strVal){ m_strSecondaryName = strVal; }
	void	SetTerminus(bool bVal){ m_bTerminus = bVal; }
	void	SetAlternate(bool bVal){ m_bAlternate = bVal; }
	void	SetDestinationCode(UINT nVal){ m_nDestinationCode = nVal; }
	void	SetDestinationName(CString strVal){ m_strDestinationName = strVal; }
	void	SetDestinationDirection(bool bVal){ m_bDestinationDirection = bVal; }
	void	SetVector(UINT nIndex1, UINT nIndex2, UINT nTP)
	{
		if( nIndex1 >= 9 || nIndex2 >= 8) return;
		m_nTP[nIndex1][nIndex2] = nTP;
	}
	void	SetUpDown( BOOL bUpDown )	{ m_bUpDown = bUpDown; }
	//void	SetTrafficType(BYTE	byTrafficType)	{ m_byTrafficType = byTrafficType; }
	//void	SetTrafficSetType(BYTE	byTrafficSetType)
	//{	
	//	if( m_byTrafficSetType == byTrafficSetType )
	//	{
	//		m_byTrafficSetType = 'N';
	//	}
	//	else
	//	{
	//		m_byTrafficSetType = byTrafficSetType;
	//	}
	//}
	bool	IsSetArrive();
	void	SetCurrentTime();


	UINT	GetStationCode(){ return m_nStationCode;}
	int		GetArrivalTime(){ return m_nArrivalTime;}
	int		GetDepartureTime(){ return m_nDepartureTime;}
	UINT	GetStationInfo(){ return m_nStationInfo;}
	bool	GetByPass(){ return m_bByPass;}
	bool	GetTurningPoint(){ return m_bTurningPoint;}
	CString	GetStationName(){ return m_strStationName;}
	bool	GetCenterCity(){ return m_bCenterCity;}
	CString	GetSecondaryName(){ return m_strSecondaryName;}
	bool	GetTerminus(){ return m_bTerminus;}
	bool	GetAlternate(){ return m_bAlternate;}
	UINT	GetDestinationCode(){ return m_nDestinationCode;}
	CString	GetDestinationName(){ return m_strDestinationName;}
	bool	GetDestinationDirection(){ return m_bDestinationDirection;}
	UINT	GetVector(UINT nIndex1, UINT nIndex2)
	{ 
		if( nIndex1 >= 9 || nIndex2 >= 8) return 0;
		return m_nTP[nIndex1][nIndex2];
	}
	BOOL	GetUpDown(void)				{ return m_bUpDown; }
	//BYTE	GetTrafficType(void)		{ return m_byTrafficType; }
	//BYTE	GetTrafficSetType(void)		{ return m_byTrafficSetType; }
	
	double	GetLAT(UINT nTPIndex);
	double	GetLOT(UINT nTPIndex);


protected:
//	DB 정보
	UINT		m_nStationCode;
	int			m_nArrivalTime;
	int			m_nDepartureTime;
	UINT		m_nStationInfo;
	bool		m_bByPass;
	bool		m_bTurningPoint;

	CString		m_strStationName;
	bool		m_bCenterCity;
	CString		m_strSecondaryName;
	bool		m_bTerminus;
	bool		m_bAlternate;

	bool		m_bSetArrive;
	CTime		m_timeArrive;

	UINT		m_nDestinationCode;
	CString		m_strDestinationName;
	bool		m_bDestinationDirection;

	//UINT		m_nTP[8][9];
	UINT		m_nTP[10][9];
// 운영정보
	BOOL		m_bUpDown;
	BYTE		m_byTrafficType;
	BYTE		m_byTrafficSetType;
public:

	CArray<CTP, CTP &>	m_arrTrigger;

	
};


