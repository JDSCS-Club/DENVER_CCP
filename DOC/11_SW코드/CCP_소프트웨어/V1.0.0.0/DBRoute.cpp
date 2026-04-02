// DBRoute.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "DBRoute.h"
#include "windef.h"

#include <stdlib.h>
#include <stdio.h>


// CDBRoute

CDBRoute::CDBRoute()
{
	m_bIsSetRoute	= false;
	m_bSimulate		= false;
	m_bDetectFirstTP = false;
	m_bDirUp		= true;

	m_nActualStationIdx	= 0xFFFF;
	m_nActualTriggerIdx = 0xFFFF;
	m_nRecentTriggerIdx = 0xFFFF;

	m_nCrewID			= 0x00;
	m_nRouteNumber		= 0x00;
	m_nTrainNumber		= 0x00;

	m_nSimulationTime	= 10;

	m_nTP_RADIUS		= 40;

	memset( m_bySkipFlag, 0x30, sizeof(BYTE) * 20 );

	m_nTrafficInfo[0] = m_nTrafficInfo[1] = 
	m_nTrafficInfo[2] = m_nTrafficInfo[3] = 0xFFFF;

	m_bUseDisplaySchedule = false;

	m_nLastVCC			= 0xFFFF;

	m_nSelectedCM		= -1;
}

CDBRoute::~CDBRoute()
{
	m_arrRoute.RemoveAll();
}

void	CDBRoute::InitStation()
{
	m_nOriginStation_No = 0;
	m_strOriginStation_Name = _T("");
	m_strOrignStation_Code = _T("");
	m_nDestination_No  = 0;
	m_strDestination_Name = _T("");
	m_strDestination_Code = _T("");
}

// CDBRoute 멤버 함수
bool	CDBRoute::IsValidTrainNumber(UINT nTrainNo) 
{
	CCeSQLiteDB db;
	char szSQL[1024];
	int nRowCount = 0;

	sprintf( szSQL, "select count(*) from TRAIN_HEADERS where TRAIN_NUM = '%d' ", nTrainNo );

	db.open( DB_PATH );
	CCeSQLiteTable t = db.getTable( szSQL );

	nRowCount = t.getIntField( 0 );

	t.finalize();
	db.close();

	if( nRowCount > 0 )
	{
		return true;
	}

	return false; 
}

bool	CDBRoute::SetRoute(UINT nTrainNo, bool bUp)
{
	m_bDetectFirstTP	= false;

	m_bDirUp = bUp;

	m_arrRoute.RemoveAll();

	if( nTrainNo <= 0 ) return false;

	CCeSQLiteDB db;
	char szSQL[4096];

	sprintf( szSQL, "SELECT " );
	//sprintf( szSQL, "%s A.TRAIN_NUM, ", szSQL );
	//sprintf( szSQL, "%s A.TRAIN_TYPE, ", szSQL );
	//sprintf( szSQL, "%s A.DAYS_OP, ", szSQL );
	sprintf( szSQL, "%s A.ORIGIN_STATION, ", szSQL );
	sprintf( szSQL, "%s B.STATION_NAME, ", szSQL );
	sprintf( szSQL, "%s A.ORIGIN_CODE, ", szSQL );
	sprintf( szSQL, "%s C.DESTINATION_NAME, ", szSQL );
	sprintf( szSQL, "%s A.DESTINATION_STATION, ", szSQL );
	sprintf( szSQL, "%s D.STATION_NAME, ", szSQL );
	sprintf( szSQL, "%s A.DESTINATION_CODE, ", szSQL );
	sprintf( szSQL, "%s E.DESTINATION_NAME, ", szSQL );
	sprintf( szSQL, "%s A.BEFORE_WHOLE_TRAIN, ", szSQL );
	sprintf( szSQL, "%s A.AFTER_WHOLE_TRAIN ", szSQL );
	sprintf( szSQL, "%s FROM TRAIN_HEADERS A ", szSQL );
	sprintf( szSQL, "%s LEFT JOIN STATION_INFORMATION B ", szSQL );
	sprintf( szSQL, "%s ON A.ORIGIN_STATION = B.STATION_CODE ", szSQL );
	sprintf( szSQL, "%s LEFT JOIN DESTINATION_CODE C ", szSQL );
	sprintf( szSQL, "%s ON A.ORIGIN_CODE = C.DESTINATION_CODE ", szSQL );
	sprintf( szSQL, "%s LEFT JOIN STATION_INFORMATION D ", szSQL );
	sprintf( szSQL, "%s ON A.DESTINATION_STATION = D.STATION_CODE ", szSQL );
	sprintf( szSQL, "%s LEFT JOIN DESTINATION_CODE E ", szSQL );
	sprintf( szSQL, "%s ON A.DESTINATION_CODE = E.DESTINATION_CODE ", szSQL );
	sprintf( szSQL, "%s WHERE A.TRAIN_NUM = '%d' ", szSQL, nTrainNo );

	db.open( DB_PATH );
	CCeSQLiteTable t1 = db.getTable( szSQL );

	if( t1.numRows() == 0 )
	{
		t1.finalize();
		db.close();
		InitStation();
		return false;
	}

	t1.setRow(0);

	m_nOriginStation_No = t1.getIntField(0);
	m_strOriginStation_Name = t1.getCStringField(1);
	m_strOrignStation_Code = t1.getCStringField(3); 
	m_nDestination_No = t1.getIntField(4); 
	m_strDestination_Name = t1.getCStringField(5); 
	m_strDestination_Code = t1.getCStringField(7); 

	sprintf( szSQL, "SELECT " );
	sprintf( szSQL, "%s A.STATION_CODE, ", szSQL );
	sprintf( szSQL, "%s A.ARRIVAL_TIME, ", szSQL );
	sprintf( szSQL, "%s A.DEPARTURE_TIME, ", szSQL );
	sprintf( szSQL, "%s A.STATION_INFO, ", szSQL );
	sprintf( szSQL, "%s A.BYPASS, ", szSQL );
	sprintf( szSQL, "%s A.TURNING_POINT, ", szSQL );
	sprintf( szSQL, "%s B.STATION_NAME, ", szSQL );
	sprintf( szSQL, "%s B.CENTER_CITY, ", szSQL );
	sprintf( szSQL, "%s B.SECONDARY_STATION_NAME, ", szSQL );
	//sprintf( szSQL, "%s B.DESTINATION_CODE, ", szSQL );
	sprintf( szSQL, "%s B.TERMINUS, ", szSQL );
	sprintf( szSQL, "%s B.ALTERNATE, ", szSQL );
	sprintf( szSQL, "%s C.DESTINATION_NAME, ", szSQL );
	sprintf( szSQL, "%s C.DESTINATION_DIRECTION, ", szSQL );

	for(int i=1; i<=9; i++)
	{
		sprintf( szSQL, "%s TP%d.AUDIO_INDEX, ", szSQL, i);
		sprintf( szSQL, "%s TP%d.FDI_C_VECTOR_INDEX, ", szSQL, i);
		sprintf( szSQL, "%s TP%d.FDI_VECTOR_INDEX, ", szSQL, i);
		sprintf( szSQL, "%s TP%d.FDI_ALT_VECTOR_INDEX, ", szSQL, i);
		sprintf( szSQL, "%s TP%d.PII_INDEX, ", szSQL, i);
		sprintf( szSQL, "%s TP%d.PP_DEST_INDEX, ", szSQL, i);
		sprintf( szSQL, "%s TP%d.PP_INDEX, ", szSQL, i);
		
		if( i < 9 )
		{
			sprintf( szSQL, "%s TP%d.SP_INDEX, ", szSQL, i);	
		}
		else
		{
			sprintf( szSQL, "%s TP%d.SP_INDEX ", szSQL, i);
		}
	}

	sprintf( szSQL, "%s FROM TRAIN_ROUTES A ", szSQL );
	sprintf( szSQL, "%s LEFT JOIN STATION_INFORMATION B ", szSQL );
	sprintf( szSQL, "%s ON A.STATION_CODE = B.STATION_CODE ", szSQL );
	sprintf( szSQL, "%s LEFT JOIN DESTINATION_CODE C ", szSQL );
	sprintf( szSQL, "%s ON B.DESTINATION_CODE = C.DESTINATION_CODE  ", szSQL );

	for(int i=1; i<=9; i++)
	{
		sprintf( szSQL, "%s LEFT JOIN ANNOUNCEMENT_INDEX TP%d ", szSQL, i );
		sprintf( szSQL, "%s ON A.TP%i_ANNOUNCEMENT = TP%i.ANNOUNCEMENT_INDEX+'%d' ", szSQL, i, i, ( bUp ? 0 : 1 ));
	}

	sprintf( szSQL, "%s WHERE A.TRAIN_NUM = '%d' ", szSQL, nTrainNo );
	sprintf( szSQL, "%s ORDER BY A.SUBINDEX %s ", szSQL, ( bUp ? "ASC" : "DESC" ) );

	CCeSQLiteTable t2 = db.getTable( szSQL );
	if( t2.numRows() == 0 )
	{
		t2.finalize();
		db.close();
		InitStation();
		return false;
	}

	for(int i=0; i<t2.numRows(); i++)
	{
		t2.setRow(i);

		CDBSchedule dbSchedule;
		dbSchedule.SetStationCode( t2.getIntField(0) );
		dbSchedule.SetArrivalTime( t2.getIntField(1) );
		dbSchedule.SetDepartureTime( t2.getIntField(2) );
		dbSchedule.SetStationInfo( t2.getIntField(3) );
		dbSchedule.SetByPass( t2.getIntField(4) ? true : false  );
		dbSchedule.SetTurningPoint( t2.getIntField(5) ? true : false );
		dbSchedule.SetStationName( t2.getCStringField(6) );
		dbSchedule.SetCenterCity( t2.getIntField(7) ? true : false );
		dbSchedule.SetSecondaryName( t2.getCStringField(8) );
		dbSchedule.SetTerminus( t2.getIntField(9) ? true : false );
		dbSchedule.SetAlternate( t2.getIntField(10) ? true : false );
		dbSchedule.SetDestinationName( t2.getCStringField(11) );
		dbSchedule.SetDestinationDirection(  t2.getIntField(12) ? true : false );

		for( int idx1=0; idx1<9; idx1++)
		{
			for(int idx2=0; idx2<8; idx2++)
			{
				dbSchedule.SetVector( idx1, idx2, t2.getIntField(13 + ( idx1 * 8 ) + idx2 ) );

				RETAILMSG(1, (_T("%d-"), t2.getIntField(13 + ( i * 8 ) + idx2 ) ) );
			}

			RETAILMSG(1, (_T("\n") ) );
		}



		sprintf( szSQL, "SELECT " );
		sprintf( szSQL, "%s A.TRIGGER_POINT, ", szSQL );
		sprintf( szSQL, "%s A.LONGITUDE, ", szSQL );
		sprintf( szSQL, "%s A.LATITUDE ", szSQL );
		sprintf( szSQL, "%s FROM TRAIN_TRIGGER A ", szSQL );
		sprintf( szSQL, "%s WHERE A.TRIGGER_POINT > %d AND A.TRIGGER_POINT < %d ", 
				szSQL, 
				(dbSchedule.GetStationCode() * 10),
				( ( dbSchedule.GetStationCode() + 1 ) * 10) );

		CCeSQLiteTable t3 = db.getTable( szSQL );

		for(int j=0; j<t3.numRows(); j++)
		{
			t3.setRow(j);

			CDBTrigger dbTrigger;
			dbTrigger.SetData( dbSchedule.GetStationCode(), 
								( t3.getIntField(0) % 10 ), 
								t3.getFloatField(1), 
								t3.getFloatField(2) );


			dbSchedule.m_arrTrigger.Add( dbTrigger );
		}


		m_arrRoute.Add( dbSchedule );

		t3.finalize();

	}

	t1.finalize();
	t2.finalize();
	db.close();

	if( m_arrRoute.GetCount() )
	{
		m_nActualStationIdx = GetDepartureStationIndex();
		m_nActualTriggerIdx = m_nRecentTriggerIdx = 0;

		SetTripNumber(0, 0);

		//SetSkipFlag();

		m_bIsSetRoute = true;
		return true;
	}


	//m_nActualStationIdx = GetDepartureStationIndex();
	//m_nActualTriggerIdx = m_nRecentTriggerIdx = 0;

	//SetTripNumber(0, 0);

	//SetSkipFlag();

	return false;
}

bool	CDBRoute::StartSimulation()
{
	if(	IsSetRoute() && m_arrRoute.GetCount() )
	{
		m_bSimulate = true;
		//SetUpDown( true );

		SYSTEMTIME tm;
		GetLocalTime(&tm);

		m_tmSimulation = CTime( tm );

		m_nActualStationIdx = 0;
		m_nActualTriggerIdx = m_nRecentTriggerIdx = 5;
		SetTripNumber(m_nActualStationIdx, m_nActualTriggerIdx);		

		
		return true;
	}

	return false;
}

bool	CDBRoute::StopSimulation()
{
	if(	m_bSimulate )
	{
		m_bSimulate = false;
		
		return true;
	}

	return false;
}

bool	CDBRoute::IncreaseActualStationIdx()
{
	CDBSchedule	dbSchedule, *dbSchedule_Next;
	UINT		nRouteCount = m_arrRoute.GetCount();

	if( GetUpDown() )	// 상행	3-5-6
	{
			 if( m_nActualTriggerIdx == 3 )	m_nActualTriggerIdx = m_nRecentTriggerIdx = 5;	
		else if( m_nActualTriggerIdx == 5 )	m_nActualTriggerIdx = m_nRecentTriggerIdx = 6;	
		else if( m_nActualTriggerIdx == 6 )
		{
			m_nActualTriggerIdx = m_nRecentTriggerIdx = 3;

			m_nActualStationIdx = GetNextStationIndex();
		}
	}
	else				// 하행 7-5-4
	{
			 if( m_nActualTriggerIdx == 7 )	m_nActualTriggerIdx = m_nRecentTriggerIdx = 5;	
		else if( m_nActualTriggerIdx == 5 )	m_nActualTriggerIdx = m_nRecentTriggerIdx = 4;	
		else if( m_nActualTriggerIdx == 4 ) 
		{
			m_nActualTriggerIdx = m_nRecentTriggerIdx = 7;

			m_nActualStationIdx = GetNextStationIndex();	
		}
	}

	if( GetLastStationIndex() == m_nActualStationIdx 
		&&
		( m_nActualTriggerIdx == 6 ||  m_nActualTriggerIdx == 4 ) )
	{
		if( IsSimulate() )	
		{
			SetRoute( GetTrainNumber(), ( GetUpDown() ? false : true ) );
			StartSimulation();
		}

		m_nActualStationIdx = 0;
		m_nActualTriggerIdx = m_nRecentTriggerIdx = 5;

		SetTripNumber(m_nActualStationIdx, m_nActualTriggerIdx);
		
		return true;
	}

	if( m_nActualTriggerIdx == 4 ||  m_nActualTriggerIdx == 6 )
	{
		SetTripNumber( ( GetNextStationIndex() - 1 ), m_nActualTriggerIdx);
	}
	else
	{
		SetTripNumber(m_nActualStationIdx, m_nActualTriggerIdx);
	}

	return true;
}

CDBSchedule	*CDBRoute::GetStationByIndex(UINT	nStationIndex)
{
	if( !IsSetRoute() || nStationIndex == 0xFFFF )
	{
		return NULL;
	}

	UINT	nRouteCount = m_arrRoute.GetCount();

	if(	nRouteCount > nStationIndex )
	{
		return &m_arrRoute.ElementAt( nStationIndex );
	}

	return NULL;
}

UINT	CDBRoute::GetStationIndexByStationNo(UINT	nStationNo)
{
	CDBSchedule dbSchedule;
	if( !IsSetRoute() )
	{
		return 0xFFFF;
	}

	for(int i=0; i<m_arrRoute.GetCount(); i++)
	{
		dbSchedule = m_arrRoute.ElementAt( i );

		if( dbSchedule.GetStationCode() == nStationNo )
		{
			return i;
		}
	}

	return 0xFFFF;
}

CDBSchedule *CDBRoute::GetDepartureStation()
{
	if( !IsSetRoute() || m_nActualStationIdx == 0xFFFF )
	{
		return NULL;
	}

	CDBSchedule	dbSchedule;

	for(int i=0; i<m_arrRoute.GetCount(); i++)
	{
		dbSchedule = m_arrRoute.ElementAt( i );

		if( !dbSchedule.GetByPass() )
		{
			return &m_arrRoute.ElementAt( i );
		}
	}

	return NULL;
}

UINT CDBRoute::GetDepartureStationIndex()
{
	CDBSchedule	dbSchedule;

	for(int i=0; i<m_arrRoute.GetCount(); i++)
	{
		dbSchedule = m_arrRoute.ElementAt( i );

		if( !dbSchedule.GetByPass() )
		{
			return i;
		}
	}

	return 0xFFFF;
}

CDBSchedule *CDBRoute::GetActualStation()
{
	if( !IsSetRoute() || m_nActualStationIdx == 0xFFFF )
	{
		return NULL;
	}

	if(	m_arrRoute.GetCount() )
	{
		return &m_arrRoute.ElementAt( m_nActualStationIdx );
	}

	return NULL;
}

CDBSchedule *CDBRoute::GetNextStation()
{
	if( !IsSetRoute() || m_nActualStationIdx == 0xFFFF )
	{
		return NULL;
	}

	CDBSchedule	dbSchedule;

	for(int i=m_nActualStationIdx+1; i<m_arrRoute.GetCount(); i++)
	{
		dbSchedule = m_arrRoute.ElementAt( i );

		if( !dbSchedule.GetByPass() )
		{
			return &m_arrRoute.ElementAt( i );
		}
	}

	return NULL;
}

UINT	CDBRoute::GetNextStationIndex()
{
	if( !IsSetRoute() || m_nActualStationIdx == 0xFFFF )
	{
		return 0xFFFF;
	}

	CDBSchedule	dbSchedule;

	for(int i=m_nActualStationIdx+1; i<m_arrRoute.GetCount(); i++)
	{
		dbSchedule = m_arrRoute.ElementAt( i );

		if( !dbSchedule.GetByPass() )
		{
			return i;
		}
	}

	return 0x00;
}

CDBSchedule *CDBRoute::GetLastStation()
{	
	if( !IsSetRoute() || m_nActualStationIdx == 0xFFFF )
	{
		return NULL;
	}

	//CDBSchedule	*dbSchedule = GetStationByIndex( m_nActualStationIdx );

	//UINT nLastStationIdx = GetStationIndexByStationNo( dbSchedule->GetLastStationNo() );

	return GetStationByIndex( m_arrRoute.GetCount()-1 );
	
}

UINT	CDBRoute::GetLastStationIndex()
{	
	if( !IsSetRoute() || m_nActualStationIdx == 0xFFFF )
	{
		return 0xFFFF;
	}

	CDBSchedule	dbSchedule;

	for(int i=m_arrRoute.GetCount()-1; i>= 0; i--)
	{
		dbSchedule = m_arrRoute.ElementAt( i );

		if( !dbSchedule.GetByPass() )
		{
			return i;
		}
	}

	return 0xFFFF;
}

void CDBRoute::SetTripNumber(UINT m_nActualStationIdx, UINT nActualTriggerIdx)
{
	UINT nRet = 0;
	CString strLog;

	if( m_nActualStationIdx == 0xFFFF )
	{
		m_nTRIPNumber = 0;

		strLog.Format( _T("## TRIP NUMBER = %d "), m_nTRIPNumber );
	}
	else
	if( m_nActualStationIdx == 0 && nActualTriggerIdx == 0 )
	{
		m_nTRIPNumber = 0;

		strLog.Format( _T("## TRIP NUMBER = %d"), m_nTRIPNumber );
	}
	else
	{
		CDBSchedule	*dbSchedule = GetStationByIndex(m_nActualStationIdx);
		if( dbSchedule )
		{
			m_nTRIPNumber = dbSchedule->GetStationCode() * 10 + nActualTriggerIdx ;
			strLog.Format( _T("## TRIP NUMBER = %d - %s"), m_nTRIPNumber, dbSchedule->GetStationName().GetBuffer(0) );
		}
	}

	RETAILMSG(1, (_T("%s\n"), strLog ) );
}

UINT CDBRoute::GetTripNumber()
{
	return m_nTRIPNumber;
}

void CDBRoute::LoadCM()
{
	CCeSQLiteDB db;
	char szSQL[1024];

	//sprintf( szSQL, "SELECT " );
	//sprintf( szSQL, "%s CM_VECTOR, ", szSQL );
	//sprintf( szSQL, "%s CM_MESSAGE ", szSQL );
	//sprintf( szSQL, "%s FROM CUSTOM_MESSAGES ", szSQL );
	//sprintf( szSQL, "%s ORDER BY CM_VECTOR ASC ", szSQL );

	sprintf( szSQL, "SELECT " );
	sprintf( szSQL, "%s CCP_TEXT, ", szSQL );
	sprintf( szSQL, "%s VECTOR_NUMBER ", szSQL );
	sprintf( szSQL, "%s FROM PR_MESSAGE ", szSQL );
	//sprintf( szSQL, "%s ORDER BY PR_MESSAGE.INDEX ASC ", szSQL );

	db.open( DB_PATH );
	CCeSQLiteTable t1 = db.getTable( szSQL );

	if( t1.numRows() == 0 )
	{
		t1.finalize();
		db.close();
		return;
	}

	for(int i=0; i<t1.numRows(); i++)
	{
		t1.setRow(i);

		CDBCM	dbCM;
		dbCM.SetData( t1.getIntField(0), t1.getCStringField(1) );

		m_arrCM.Add(dbCM);
	}	
}

CDBCM	*CDBRoute::GetCMByIndex(UINT nCMIndex)
{
	UINT	nCMCount = m_arrCM.GetCount();

	if(	nCMCount > nCMIndex )
	{
		return &m_arrCM.ElementAt( nCMIndex );
	}

	return NULL;
}

//
//bool	CDBRoute::UseCM(UINT nCMIndex)
//{
//	CDBCM dbCM;
//	for( int i=0; i<m_arrCM.GetCount(); i++)
//	{
//		dbCM = m_arrCM.ElementAt( i );
//
//		if( dbTPForPR.GetTPNo() == nCMIndex &&
//			dbTPForPR.GetDisplayPR() )
//		{
//			return true;
//		}
//	}
//
//	return false;
//}

void CDBRoute::GetDelayTime(CString &strDelay)
{
	if( !IsSetRoute() )
	{
		strDelay = _T("");
		return;
	}

	strDelay = _T("+ 0");

	if( IsSimulate() )	return;
	else
	{
		if( m_bDetectFirstTP )
		{
		}
		else
		{
			strDelay = _T("---");
		}
	}
}


void CDBRoute::GetArriveTime(CString &strDelay, int nType)
{
	if( !IsSetRoute() )
	{
		strDelay = _T("");
		return;
	}

	CDBSchedule	*dbSchedule[4];

	dbSchedule[0] = GetDepartureStation();
	dbSchedule[1] = GetActualStation();
	dbSchedule[2] = GetNextStation();
	dbSchedule[3] = GetLastStation();

	if( dbSchedule[nType] == NULL ) return;

	UINT nTime = 0;
	if( GetUpDown() )
	{
		nTime = abs( dbSchedule[nType]->GetArrivalTime() );
	}
	else
	{
		nTime = abs( dbSchedule[nType]->GetDepartureTime() );
	}
	
	CTimeSpan ts( nTime );
	

	if( IsSimulate() )
	{
		CTime tmArrive = m_tmSimulation + ts;
		strDelay.Format( _T("%02d:%02d"), tmArrive.GetHour(), tmArrive.GetMinute() );
	}
	else
	{
		if( m_bDetectFirstTP )
		{
		}
		else
		{
			strDelay = _T("--:--");
		}
	}
}