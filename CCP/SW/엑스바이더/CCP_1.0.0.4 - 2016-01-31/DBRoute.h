#pragma once

#include "CeSQLite.h"
#include "DBSchedule.h"
#include "DBCM.h"
// CDBRoute 명령 대상입니다.

#define	DB_PATH		( "\\NandFlash\\ccp_db\\DVDB.dat" )

class CDBRoute : public CObject
{
public:
	CDBRoute();
	virtual ~CDBRoute();

public:
	void		SetLogParent(CWnd *pParent)
	{
		m_pParent = pParent;
	}

	bool		IsSetRoute()		{	return m_bIsSetRoute;	}
	bool		IsSimulate()		{	return m_bSimulate;		}
	bool		IsDetectFirstTP()	{	return m_bDetectFirstTP;	}

	void		SetEmptyRoute()		{	m_bIsSetRoute = false;	}
	void		SetCrewID(UINT	nCreID = 0x00 )	{	m_nCrewID = nCreID;	}
	void		SetTrainNumber(UINT	nTrainNumber = 0x00 )	
				{	
					m_nTrainNumber = nTrainNumber;		
				}

	void		SetSimulationTime(UINT nSimulationTime )	
				{	
					m_nSimulationTime = nSimulationTime; 
				}

	void		SetSimulationStatus( bool bSimulate )
				{
					m_bSimulate = bSimulate;
				}

	UINT		GetSimulationTime()	{ return m_nSimulationTime; }
	UINT		GetTrainNumber()	{ return m_nTrainNumber; }
	UINT		GetCrewID()			{ return m_nCrewID; }

	void		InitStation();
	bool		IsValidTrainNumber(UINT nTrainNo);
	bool		SetRoute(UINT nTrainNo, bool bUp = true );
	//void		SetUpDown(bool bUp){ m_bDirUp = bUp; };
	bool		GetUpDown() { return m_bDirUp; };

	UINT		GetTPI() { return m_nActualTriggerIdx; };
	UINT		GetRouteCount() { return m_arrRoute.GetCount(); }
	void		SetDetectFirstTP()	{	m_bDetectFirstTP = true; }	

	double		distance(double LAT1, double LOT1, double LAT2, double LOT2);
	double		deg2rad(double deg);
	double		rad2deg(double rad);

	bool		StartSimulation();
	bool		SetStartSimulationTime();
	bool		StopSimulation();
	bool		IncreaseActualStationIdx();

	CDBSchedule	*GetStationByIndex(UINT	nStationIndex);
	UINT		GetStationIndexByStationNo(UINT	nStationNo);
	CDBSchedule *GetDepartureStation();
	UINT		GetDepartureStationIndex();
	CDBSchedule *GetActualStation();
	CDBSchedule *GetNextStation();
	UINT		GetNextStationIndex();

	CDBSchedule *GetLastStation();
	UINT		GetLastStationIndex();
	void		SetTripNumber(UINT m_nActualStationIdx, UINT nActualTriggerIdx);
	UINT		GetTripNumber();
	void		SetAcualStationIdx( UINT nActualStationIdx );
	UINT		GetActualStationIdx();

	UINT		GetOriginStationNo(){ return ( m_bDirUp ? m_nOriginStation_No : m_nOriginStation_No ); }
	CString		GetOriginStationName(){ return ( m_bDirUp ? m_strOriginStation_Name : m_strOriginStation_Name ); }
	CString		GetOriginStationCode(){ return ( m_bDirUp ? m_strOrignStation_Code : m_strOrignStation_Code ); }
	UINT		GetDestinationStationNo(){ return ( m_bDirUp ? m_nDestination_No : m_nDestination_No ); }
	CString		GetDestinationName(){ return ( m_bDirUp ? m_strDestination_Name : m_strDestination_Name ); }
	CString		GetDestinationCode(){ return ( m_bDirUp ? m_strDestination_Code : m_strDestination_Code ); }

	void		LoadCM();
	UINT		GetCMCount(){ return m_arrCM.GetCount(); }
	CDBCM		*GetCMByIndex(UINT nPRIndex);
	void		SetCMIndex(int nCMIndex) { m_nSelectedCM = nCMIndex; }
	int			GetSelectedCM() { return m_nSelectedCM; };
	
	void		GetDelayTime(CString &strDelay);
	void		GetArriveTime(CString &strDelay, int nType);
	bool		SearchTriggerPoint( double dblLAT, double dblLOT, bool bOpenDoor );
	
protected:
	CWnd		*m_pParent;
	
	bool		m_bSimulate;
	bool		m_bDetectFirstTP;
	bool		m_bDirUp;

	UINT		m_nActualStationIdx;
	UINT		m_nActualTriggerIdx;
	UINT		m_nRecentTriggerIdx;

	UINT		m_nCrewID;
	UINT		m_nRouteNumber;
	UINT		m_nTrainNumber;

	UINT		m_nTRIPNumber;
	UINT		m_nSimulationTime;

	UINT		m_nTP_RADIUS;

	UINT		m_nTrafficInfo[4];

	bool		m_bUseDisplaySchedule;
	CString		m_strDiplaySchedule[3];

	CTime		m_tmSimulation;

	// 노선정보
	UINT		m_nOriginStation_No;
	CString		m_strOriginStation_Name;
	CString		m_strOrignStation_Code;
	UINT		m_nDestination_No;
	CString		m_strDestination_Name;
	CString		m_strDestination_Code;

	CArray<CDBSchedule, CDBSchedule &>	m_arrRoute;

	//bool		m_bHaveVCC;		// Via Center City
	//bool		m_bHaveDNS;		// Dual Name Station;
	//UINT		m_nFirstVCC;
	UINT		m_nLastVCC;

	// PR
	CArray<CDBCM, CDBCM &>	m_arrCM;
	int			m_nSelectedCM;

	
	

public:
	bool		m_bIsSetRoute;
	BYTE		m_bySkipFlag[20];

	UINT		m_nBakTrainNumber;
};	


