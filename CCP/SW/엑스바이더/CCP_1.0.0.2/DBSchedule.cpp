// DBSchedule.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "DBSchedule.h"

// CDBSchedule

CDBSchedule::CDBSchedule()
{
	m_nStationCode = 0;
	m_nArrivalTime = 0;
	m_nDepartureTime = 0;
	m_nStationInfo  = 0;
	m_bByPass = false;
	m_bTurningPoint = false;

	m_bCenterCity = false;
	m_bTerminus = false;
	m_bAlternate = false;

	m_nDestinationCode  = 0;
	m_bDestinationDirection = false;

	memset( m_nTP, 0, sizeof(UINT) * 9 * 8 );

	m_byTrafficSetType = 0;
}

CDBSchedule::~CDBSchedule()
{
}


// CDBSchedule 멤버 함수

CDBSchedule &CDBSchedule::operator=(const CDBSchedule& DBSchedule)
{
	m_nStationCode = DBSchedule.m_nStationCode;
	m_nArrivalTime = DBSchedule.m_nArrivalTime;
	m_nDepartureTime = DBSchedule.m_nDepartureTime;
	m_nStationInfo  = DBSchedule.m_nStationInfo;
	m_bByPass = DBSchedule.m_bByPass;
	m_bTurningPoint = DBSchedule.m_bTurningPoint;

	m_strStationName = DBSchedule.m_strStationName;
	m_bCenterCity = DBSchedule.m_bCenterCity;
	m_strSecondaryName = DBSchedule.m_strSecondaryName;
	m_bTerminus = DBSchedule.m_bTerminus;
	m_bAlternate = DBSchedule.m_bAlternate;

	m_nDestinationCode  = DBSchedule.m_nDestinationCode;
	m_strDestinationName = DBSchedule.m_strDestinationName;
	m_bDestinationDirection = DBSchedule.m_bDestinationDirection;

	memcpy( &m_nTP, &DBSchedule.m_nTP, sizeof(UINT) * 9 * 8 );

    return *this;
}