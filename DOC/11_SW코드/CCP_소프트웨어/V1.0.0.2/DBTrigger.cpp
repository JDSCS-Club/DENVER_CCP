// DBTrigger.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "DBTrigger.h"

#include <stdio.h>
#include <math.h>


// CDBTrigger

CDBTrigger::CDBTrigger()
{
	m_nStationNo	= 0;
}

CDBTrigger::~CDBTrigger()
{
}


// CDBTrigger 멤버 함수
void	CDBTrigger::SetData(UINT nStationNo, UINT nTriggerIdx, double dblLat, double dblLot)
{
	m_nStationNo		= nStationNo;

	CTP	cTP;

	cTP.TP_INDEX = nTriggerIdx;
	cTP.TP_LAT = dblLat;
	cTP.TP_LOT = dblLot;

	m_arrTP.Add( cTP );

	return;
}

CDBTrigger &CDBTrigger::operator=(const CDBTrigger& DBTrigger)
{
	m_nStationNo	= DBTrigger.m_nStationNo;

	m_arrTP.Copy( DBTrigger.m_arrTP );

	return *this;
}

UINT CDBTrigger::GetStationNo()
{
	return m_nStationNo;
}

void CDBTrigger::SetAnnounced(UINT nTP_Index)
{
	for(int i=0; i<m_arrTP.GetCount(); i++)
	{
		if( m_arrTP.ElementAt(i).TP_INDEX == nTP_Index )
		{
			m_arrTP.ElementAt(i).TP_ANNOUNCED = true;
		}
	}
}