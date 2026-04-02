// Serial.cpp : 구현 파일입니다.
//
#include "stdafx.h"

#include "Serial.h"

// CSerial

IMPLEMENT_DYNCREATE(CSerial, CWinThread)

CSerial::CSerial()
{
	m_bReqTRIC = true;

	m_bInugurationFirst = true;
	m_bInugurationFinished = false;
	m_bInugurationFinishedTemp = !m_bInugurationFinished; 
}

CSerial::~CSerial()
{
	m_terminateEvent.SetEvent();
	CloseHandle( m_hComport );
}

BOOL CSerial::InitInstance()
{
	// TODO: 여기에서 각 스레드에 대한 초기화를 수행합니다.
	return TRUE;
}

int CSerial::ExitInstance()
{
	// TODO: 여기에서 각 스레드에 대한 정리를 수행합니다.
	return CWinThread::ExitInstance();
}

BEGIN_MESSAGE_MAP(CSerial, CWinThread)
END_MESSAGE_MAP()


// CSerial 메시지 처리기입니다.


int CSerial::Run()
{
	DWORD	dwEvent;
	DWORD	dwRead		= 0;
	DWORD	dwErrorFlags= 0;
	DWORD	nSum		= 0;		// buff에 들어있는 Data의 갯수
	DWORD	nLength		= 0;

	DWORD	dwReciveTime= 0;

	COMSTAT comstat;

	BYTE	szBuff[8192];	// 통신에 사용되는 buffer

	bool	bStx = false;
	bool	bEtx = false;
	DWORD	nStxIdx = 0;
	DWORD	nEtxIdx = 0;

	//DWORD	nTickCount = 0;

	bool	bDoorLast = false;
	bool	bDoorCurr = false;
	
	bool	bDataFault = false;

	//Event 설정
	if(!SetCommMask(m_hComport, EV_RXCHAR))
	{
		//_T("ThreadWatchComm 실행중 에러발생");
		return FALSE;
	}

	PurgeComm( m_hComport, PURGE_TXABORT|PURGE_TXCLEAR|PURGE_RXABORT|PURGE_RXCLEAR);

	ZeroMemory(szBuff, sizeof(szBuff));

	// 포트에서 데이타를 전송받았는지 확인하는 루틴
	while( m_bIsConnected )
	{
		dwRead = 0;
		dwEvent = 0;
		
		// 메세지 발생시까지 기다리기...
		BOOL bRet = WaitCommEvent(m_hComport, &dwEvent, NULL);

		if( (dwEvent & EV_RXCHAR) == EV_RXCHAR )
		{
			ClearCommError( m_hComport, &dwErrorFlags, &comstat);

			if( comstat.cbInQue == 0 ) continue;

			if( nSum + comstat.cbInQue > 2048 )
			{
				nSum = 0;
				bStx = bEtx = 0;
				ZeroMemory(szBuff, sizeof(szBuff));
			}
			
			if( !ReadFile( m_hComport, szBuff+nSum, comstat.cbInQue, &dwRead, NULL) )
			{
				continue;
			}

			nSum += dwRead;
			for(bStx=false, nStxIdx=0; nStxIdx<nSum; nStxIdx++)
			{
				if( szBuff[nStxIdx] == STX )
				{
					bStx = true;
					break;
				}
			}

			for(bEtx=false, nEtxIdx=nStxIdx+1; bStx && nEtxIdx<nSum; nEtxIdx++)
			{
				if( szBuff[nEtxIdx] == ETX )
				{
					dwReciveTime = GetTickCount();
					bEtx = true;
					break;
				}
			}

			if( bStx && bEtx && ( nStxIdx < nEtxIdx) )
			{
				BYTE *pBuff = &szBuff[nStxIdx];

				for(DWORD i=nStxIdx+1;i<nEtxIdx;i++)
				{
					switch(szBuff[i])
					{
					case '0':	case '1':	case '2':	case '3':	
					case '4':	case '5':	case '6':	case '7':	case '8':	case '9':	
					case 'A':	case 'B':	case 'C':	case 'D':	case 'E':	case 'F':		bDataFault = false;		break;
					default:																	bDataFault = true;		break;
					}

					if(bDataFault) break;
				}

 				if( bDataFault || !m_pPacket->SetHeader( &szBuff[nStxIdx+1] ) )
				{
					nSum = 0;
					bStx = bEtx = 0;
					ZeroMemory(szBuff, sizeof(szBuff));

					if( m_pPacket->GetSourceID() != ID_PAC_A &&
						m_pPacket->GetSourceID() != ID_PAC_B &&
						m_pPacket->GetSourceID() != ID_CCP_A &&
						m_pPacket->GetSourceID() != ID_CCP_B &&
						m_pPacket->GetSourceID() != ID_CNCS_A &&
						m_pPacket->GetSourceID() != ID_CNCS_B )
					{
						Flush(TRUE, TRUE);
					}

					continue;
				}

				if( ( ( m_pPacket->GetSourceID() == ID_PAC_A && m_pPacket->GetDestinationID() == ID_PAC_A ) ||
					( m_pPacket->GetSourceID() == ID_PAC_B && m_pPacket->GetDestinationID() == ID_PAC_B ) ) &&
					m_pPacket->GetCommandCode() == COMMAND_INFO_REQ )
				{
					BYTE D0 = ( m_pPacket->PAC.D0 & 0x03 );
					m_pPacket->SetPAC( szBuff + nStxIdx + 1 + SIZE_HEADER );
					if( m_pPacket->PAC.CCI == 0x10 )
					{
						m_pStatus->SetInuguration(true);
						m_bInugurationFinished = false;
						m_bInugurationFinishedTemp = m_bInugurationFinished;
					}
					else
					{
						if( m_pStatus->GetInuguration() )
						{
							m_bInugurationFinished = true;
							m_bInugurationFirst = true;
						}
						m_pStatus->SetInuguration(false);
					}

					int nCarCount = m_pPacket->GetCarCount();
					BOOL bCab = FALSE;
					int nHeadDir = 0;

					for(int i=0; i<nCarCount; i++)
					{
						CAR_DATA *pCarData = m_pPacket->GetCarData(i);
						
						UINT nCarNumber = pCarData->CARN;

						UINT nCarMarriedType = GetCarMarriedType(pCarData);

						if( nCarMarriedType == 2 )
						{
							if( CHECK_CABA(pCarData->DATA) )
							{
								if( bCab == FALSE)
								{
									bCab = TRUE;
									nHeadDir = 1;
								}
							}
						}
						else if( nCarMarriedType == 3 )
						{
							if( CHECK_CABB(pCarData->DATA) )
							{
								if( bCab == FALSE)
								{
									bCab = TRUE;
									nHeadDir = 2;
								}
							}
						}
					}

					//RETAILMSG(1, (_T("Inuguration : %d, %d, %d\n"), bCab, m_bInugurationFinished, m_bInugurationFinishedTemp));

					if( m_bInugurationFirst || (bCab && !m_bInugurationFinishedTemp  && m_bInugurationFinished))
					{
						//if( nHeadDir == 1 )
						//{
						if ( m_bInugurationFirst || !m_bInugurationFinishedTemp )
						{
							//RETAILMSG(1, (_T("Initial CI Index---------------------------------------------\n")));
	
							m_pPacket->PAC.CI_USER[0] = 1;
							m_pPacket->PAC.CI_USER[1] = 2;
							m_pPacket->PAC.CI_USER[2] = 3;
							m_pPacket->PAC.CI_USER[3] = 4;
							m_pPacket->PAC.CI_USER[4] = 5;
							m_pPacket->PAC.CI_USER[5] = 6;
							m_pPacket->PAC.CI_USER[6] = 7;
							m_pPacket->PAC.CI_USER[7] = 8;

							m_bInugurationFinishedTemp = true;
							m_bInugurationFirst = false;
						}

						// m_bInugurationFinishedTemp = m_bInugurationFinished;
						//}
						//else if( nHeadDir == 2 )
						//{
						//	m_pPacket->PAC.CI_USER[0] = 8;
						//	m_pPacket->PAC.CI_USER[1] = 7;
						//	m_pPacket->PAC.CI_USER[2] = 6;
						//	m_pPacket->PAC.CI_USER[3] = 5;
						//	m_pPacket->PAC.CI_USER[4] = 4;
						//	m_pPacket->PAC.CI_USER[5] = 3;
						//	m_pPacket->PAC.CI_USER[6] = 2;
						//	m_pPacket->PAC.CI_USER[7] = 1;
						//}
					}
					//else
					//{
					//	m_pPacket->PAC.CI[0]	= 1;
					//	m_pPacket->PAC.CI[1]	= 2;
					//	m_pPacket->PAC.CI[2]	= 1;
					//	m_pPacket->PAC.CI[3]	= 2;
					//	m_pPacket->PAC.CI[4]	= 1;
					//	m_pPacket->PAC.CI[5]	= 2;
					//	m_pPacket->PAC.CI[6]	= 1;
					//	m_pPacket->PAC.CI[7]	= 2;
					//}


					BOOL bZero = FALSE;
					BOOL bSameIndex = FALSE;
					//BOOL bCab = FALSE;

					if( nCarCount < 0x08 )
					{
						for( int i=0; i<nCarCount; i++)
						{
							if( m_pPacket->PAC.CI_LIC[i] == 0 )
							{
								bZero = TRUE;
								break;
							}
						}

						for( int i=0; i<nCarCount; i++)
						{
							for( int j=0; j<nCarCount; j++)
							{
								if( i == j ) continue;

								if( m_pPacket->PAC.CI_LIC[i] == m_pPacket->PAC.CI_LIC[j] )
								{
									bSameIndex = TRUE;
									break;
								}
							}

							if( bSameIndex )
							{
								break;
							}
						}
					}

					if( bZero || bSameIndex )
					{
						for(int i=0; i<8; i++)
						{
							m_pPacket->PAC.CI_USER[i] = (i+1);
						}

						m_pStatus->SetCI_Valid(false);
					}
					else
					{
						m_pStatus->SetCI_Valid(true);
					}

					for(UINT i=0; i<nCarCount && i != 0x10; i++)
					{
						UINT	nCarMarriedType;
						bool	bCarError = false;
						CString strCarNumber;

						CAR_DATA *pCarData = m_pPacket->GetCarData(i);

						if( i == m_pPacket->PAC.CAR_POS )
						{
							continue;
						}
					}

					//
					if( !m_pStatus->IsSetCabonKey() )
					{
						SYSTEMTIME tm;
						GetLocalTime(&tm);

						int nBackTrainNumber = 0;
						if(m_pPacket->PAC.TRAN_NO % 2)
						{
							nBackTrainNumber = m_pPacket->PAC.TRAN_NO - 1;
						}
						else
						{
							nBackTrainNumber = m_pPacket->PAC.TRAN_NO + 1;
						}
						m_pRoute->m_nBakTrainNumber = nBackTrainNumber;

						CString strOut;
						strOut.Format( _T("%4d:%2d:%2d TRAN_NO : %d, BAK_NO : %d \n"), tm.wHour, tm.wMinute, tm.wSecond, m_pPacket->PAC.TRAN_NO, nBackTrainNumber);
						RETAILMSG(1, (strOut));

						if( m_pRoute->GetTrainNumber() != m_pPacket->PAC.TRAN_NO )
							//|| D0 != ( m_pPacket->PAC.D0 & 0x03 ) )
						{
							RETAILMSG(1, (_T("Set route : %d, %d,  %d, %d\n"), m_pRoute->GetTrainNumber(), m_pPacket->PAC.TRAN_NO, D0, ( m_pPacket->PAC.D0 & 0x03 )) );
							m_pParent->PostMessage( WM_SET_ROUTE, m_pPacket->PAC.TRAN_NO, m_pPacket->PAC.CREW_ID );

							m_pRoute->SetTrainNumber( m_pPacket->PAC.TRAN_NO );
							m_pRoute->SetTripNumber(0, 0);
						}

						if( m_pRoute->GetCrewID() != m_pPacket->PAC.CREW_ID )
						{
							m_pParent->PostMessage( WM_SET_CREWID, m_pPacket->PAC.CREW_ID, 0 );
						}

						if( m_pRoute->IsSetRoute() )
						{
							if( m_pPacket->GetSimulation() && !m_pRoute->IsSimulate() )
							{
								m_pRoute->SetStartSimulationTime();
							}

							m_pRoute->SetSimulationStatus( m_pPacket->GetSimulation() );

							UINT nStationInx = m_pRoute->GetStationIndexByStationNo( m_pPacket->PAC.NOST );
							
							m_pRoute->SetAcualStationIdx( nStationInx ); 

							// = m_pRoute->GetStationIndexByStationNo( m_pPacket->PAC.NOST );
							//m_pPacket->PAC.TRIP;

						}
					}
				}
				else if( ( m_pPacket->GetSourceID() == ID_PAC_A || m_pPacket->GetSourceID() == ID_PAC_B ) &&
					( m_pPacket->GetDestinationID() == m_pStatus->GetCCPID() ) &&
					m_pPacket->GetCommandCode() == COMMAND_INFO_REQ )
				{
					SendToPAC( ::GetTickCount() );
					//m_pPacket->SetPAC( szBuff + nStxIdx + 1 + SIZE_HEADER );

				}
				else if( ( m_pPacket->GetSourceID() == ID_PAC_A || m_pPacket->GetSourceID() == ID_PAC_B ) &&
					( m_pPacket->GetDestinationID() == m_pStatus->GetCCPID() ) &&
					m_pPacket->GetCommandCode() == COMMAND_INFO_REQ )
				{
					SendToPAC_Version();
					//m_pPacket->SetPAC( szBuff + nStxIdx + 1 + SIZE_HEADER );

				}
				else
				if( ( m_pPacket->GetSourceID() == ID_LIC_A || m_pPacket->GetSourceID() == ID_LIC_B ) ||
					( m_pPacket->GetDestinationID() == ID_PAC_A && m_pPacket->GetDestinationID() == ID_PAC_B ) )
				{
					m_pPacket->SetLIC( szBuff + nStxIdx + 1 + SIZE_HEADER );
				}
				else
				if( ( m_pPacket->GetSourceID() == ID_CNCS_A || m_pPacket->GetSourceID() == ID_CNCS_B )&&
					( m_pPacket->GetDestinationID() == ID_PAC_A || m_pPacket->GetDestinationID() == ID_PAC_B ) &&
					m_pPacket->GetCommandCode() == COMMAND_INFO_ACK )
				{
					//m_pPacket->SetCNCS( szBuff + nStxIdx + 1 + SIZE_HEADER );

					if ( (m_pStatus->GetCCPID() == ID_CCP_A) && (m_pPacket->GetSourceID() == ID_CNCS_A) )
					{
						//bGpsStatus = m_pPacket->GetSourceID() == ID_CNCS_A;
						m_pPacket->SetCNCS( szBuff + nStxIdx + 1 + SIZE_HEADER/*, bGpsStatus*/);

						if( m_pStatus->IsSetCabonKey() && !m_pRoute->IsSimulate() )
						{
							bool bRet = m_pRoute->SearchTriggerPoint( m_pPacket->CNCS.LAT, m_pPacket->CNCS.LOT, true );
						}
					}
					else if ( (m_pStatus->GetCCPID() == ID_CCP_B) && (m_pPacket->GetSourceID() == ID_CNCS_B) )
					{
						//bGpsStatus = m_pPacket->GetSourceID() == ID_CNCS_B;
						m_pPacket->SetCNCS( szBuff + nStxIdx + 1 + SIZE_HEADER/*, bGpsStatus*/);

						if( m_pStatus->IsSetCabonKey() && !m_pRoute->IsSimulate() )
						{
							bool bRet = m_pRoute->SearchTriggerPoint( m_pPacket->CNCS.LAT, m_pPacket->CNCS.LOT, true );
						}
					}

				}

				//if( ( m_pPacket->GetSourceID() == ID_PAC_A || m_pPacket->GetSourceID() == ID_PAC_B )
				//	&&
				//	m_pPacket->GetCommandCode() == 0x10 )
				//{
				//	if( ( m_pPacket->GetDestinationID()  == ID_CCP_A ) || ( m_pPacket->GetDestinationID()  == ID_CCP_B ) )
				//	{
				//		m_pPacket->SetCalibration( szBuff + nStxIdx + 1 + SIZE_HEADER, m_pParent->m_Status.GetCCPID() );
				//
				//		m_pStatus->SetTouchCalibration_Master(m_pPacket->GetTouchCalibration_Master());
				//		m_pStatus->SetTouchCalibration_Slave(m_pPacket->GetTouchCalibration_Slave());

				//		if( m_pPacket->GetDestinationID()  == m_pParent->m_Status.GetCCPID() )
				//		{				
				//			m_pParent->m_dwTickRecv = ::GetTickCount();
				//			m_pParent->m_bActiveCalibration = FALSE;

				//			m_pPacket->SetPAC( szBuff + nStxIdx + 1 + SIZE_HEADER );

				//			if( m_pPacket->GetDoorL() == 2 || m_pPacket->GetDoorR() == 2 )	bDoorCurr = true;
				//			else															bDoorCurr = false;

				//			if( bDoorLast != bDoorCurr )	
				//			{
				//				if( bDoorCurr )	m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("DoorStatus Changed [OPEN]") );
				//				else			m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("DoorStatus Changed [CLOSE]") );
				//			}

				//			bDoorLast = bDoorCurr;

				//			UINT nCarCount = 0;

				//			if( m_pPacket->PAC.CCI <= 0x00 || m_pPacket->PAC.CCI > 0x0C )
				//			{
				//				nCarCount = 1;
				//			}
				//			else
				//			{
				//				nCarCount = m_pPacket->PAC.CCI;
				//			}

				//			for(int i=0; i<(int)nCarCount; i++)
				//			{
				//				m_pPacket->SetCarInfo(i, szBuff + nStxIdx + 1 + SIZE_HEADER + SIZE_PAC_DATA + ( SIZE_PAC_CARINFO * i ) );
				//			}


				//			if( m_pRoute->IsSetRoute() && !m_pStatus->IsSetCabonKey() )
				//			{
				//				if( m_pPacket->GetSimulation() )
				//				{
				//					if( !m_pRoute->IsSimulate() )
				//					{
				//						m_pRoute->StartSimulation();
				//					}
				//				}
				//				else
				//				{
				//					if( m_pRoute->IsSimulate() )
				//					{
				//						m_pRoute->StopSimulation();
				//					}
				//				}
				//			}

				//			SendToPAC(dwReciveTime);

				//			if( m_pStatus->IsUpdating() )
				//			{
				//				m_pStatus->SetUpdating( false );
				//			}

				//			m_pParent->PostMessage( WM_SET_CROSS_TIME, (WPARAM)m_pPacket->CNCS.LED_T, 1 );

				//			if( !m_pStatus->IsSetCabonKey()	)
				//			{
				//				if( m_pPacket->PAC.TRAN_NO == 0xFFFF )
				//				{
				//					 m_pPacket->PAC.TRAN_NO = 0x00;
				//				}

				//				if( m_pRoute->GetTrainNumber() != m_pPacket->PAC.TRAN_NO )
				//				{
				//					if( m_pStatus->IsDetectCabOff()	)
				//					{
				//						m_pStatus->SetDetectCabOff(false);
				//					}
				//					else
				//					{
				//						if( !m_pStatus->GetUsing() )
				//						{
				//							m_pStatus->SetUsing( true );
				//							m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SET TRAN : [TRUE]") );

				//							m_pParent->PostMessage( WM_SET_ROUTE, m_pPacket->PAC.TRAN_NO, m_pPacket->PAC.CREW_ID );
				//							
				//							m_pStatus->SetUsing( false );
				//							m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SET TRAN : [FALSE]") );
				//						}
				//						else
				//						{
				//							m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SET TRAN : [LOCKED]") );
				//						}
				//					}
				//				}

				//				if( m_pRoute->GetCrewID() != m_pPacket->PAC.CREW_ID )
				//				{
				//					m_pParent->PostMessage( WM_SET_CREWID, m_pPacket->PAC.CREW_ID, 0 );
				//				}
				//			}

				//			m_pPacket->SetCarData(nCarCount, m_pPacket->CAR_TEMP );
				//		}
				//	}
				//	else
				//	if( /*m_pPacket->GetSourceID() == ID_PAC_A &&*/ m_pPacket->GetDestinationID() == 0xFF )
				//	{
				//		UINT	nStation[4];

				//		nStation[0] = DEC_FROM_BCD4( szBuff[nStxIdx + 45], szBuff[nStxIdx + 46], szBuff[nStxIdx + 47], szBuff[nStxIdx + 48] );  
				//		nStation[1] = DEC_FROM_BCD4( szBuff[nStxIdx + 49], szBuff[nStxIdx + 50], szBuff[nStxIdx + 51], szBuff[nStxIdx + 52] );
				//		nStation[2] = DEC_FROM_BCD4( szBuff[nStxIdx + 53], szBuff[nStxIdx + 54], szBuff[nStxIdx + 55], szBuff[nStxIdx + 56] );
				//		nStation[3] = DEC_FROM_BCD4( szBuff[nStxIdx + 57], szBuff[nStxIdx + 58], szBuff[nStxIdx + 59], szBuff[nStxIdx + 60] );	

				//		if( m_pRoute->IsSetRoute() && !m_pStatus->IsSetCabonKey() )
				//		{
				//			if( !m_pStatus->GetUsing() )
				//			{
				//				m_pStatus->SetUsing( true );
				//				//m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SetTrafficInfo : [TRUE]") );

				//				m_pRoute->SetTrafficInfo( nStation );

				//				m_pStatus->SetUsing( false );
				//				//m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SetTrafficInfo : [FALSE]") );
				//			}
				//			else
				//			{
				//				m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SetTrafficInfo : [LOCKED]") );
				//			}
				//		}
				//	}
				//}
				//else
				//if( ( m_pPacket->GetSourceID() == ID_CNCS_A || m_pPacket->GetSourceID() == ID_CNCS_B )
				//	&&  
				//	( m_pPacket->GetDestinationID() == m_pStatus->GetCCPID() || m_pPacket->GetDestinationID() == 0x3F ) )
				//{
				//	//for(UINT i=nStxIdx; i<=nEtxIdx; i++)
				//	//{
				//	//	RETAILMSG(1, ( _T("%c"), szBuff[i] ) );
				//	//}
				//	//RETAILMSG(1, (_T("\r\n") ) );

				//	m_Update.ReadBuffer(m_pPacket->GetCommandCode(), szBuff + nStxIdx + 1 + SIZE_CSCNS_HEADER, m_pPacket->GetDataLength()  );
				//	
				//	SendToCNCS();

				//	if( m_pPacket->GetCommandCode() == 0xA2 )
				//	{
				//		if( !m_pStatus->IsUpdating() ) m_pStatus->SetUpdating( true );
				//	}
				//	else if( m_pPacket->GetCommandCode() == 0xB2 )
				//	{
				//		Sleep(500);
				//		m_pParent->PostMessage( WM_UPDATE );
				//	}
				//}
				//else
				//if( ( m_pPacket->GetSourceID() == ( m_pStatus->GetCCPID() == ID_CCP_A ? ID_CCP_B : ID_CCP_A ) )
				//	&&
				//	( m_pPacket->GetDestinationID()  == ID_PAC_A || m_pPacket->GetDestinationID()  == ID_PAC_B ) 
				//	&& 
				//	!m_pStatus->IsSetCabonKey() )
				//{
				//	if( !m_pStatus->GetUsing() )
				//	{
				//		m_pStatus->SetUsing( true );
				//		//m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SetSkipInfo : [TRUE]") );

				//		m_pPacket->SetSkipInfo( szBuff + nStxIdx);

				//		m_pRoute->ReSetSkipFlag( m_pPacket->PAC.SKIP );

				//		m_pStatus->SetUsing( false );
				//		//m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SetSkipInfo : [FALSE]") );
				//	}
				//	else
				//	{
				//		m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)_T("SetUsing - SetSkipInfo : [LOCKED]") );
				//	}
				//}

				nSum = 0;
				bStx = bEtx = 0;
				ZeroMemory(szBuff, sizeof(szBuff)); 
			}
			else if( bStx )
			{
				//RETAILMSG(1, (_T("Find STX : %d, %d, %d\n"), dwRead, nStxIdx, nEtxIdx));
				// nSum  += dwRead;
			}
			else
			{
				nSum = 0;
				bStx = bEtx = 0;
				ZeroMemory(szBuff, sizeof(szBuff));
				//RETAILMSG(1, (_T("Not Find : %d, %d, %d\n"), dwRead, nStxIdx, nEtxIdx));
			}
		}
		else
		if( ( (dwEvent & EV_RX80FULL) == EV_RX80FULL ) ||
			( (dwEvent & EV_ERR) == EV_ERR ) )
		{
			nSum = 0;
			bStx = bEtx = 0;
			ZeroMemory(szBuff, sizeof(szBuff));

			Flush(TRUE, TRUE);
		}

		Sleep(0);
	}

	return CWinThread::Run();
}

bool CSerial::OpenPort()
{
   // get a handle to the port
	m_hComport = CreateFile(TEXT("COM1:"),					// communication port string (COMX)
						 GENERIC_READ | GENERIC_WRITE,	// read/write types
						 0,								// comm devices must be opened with exclusive access
						 NULL,							// no security attributes
						 OPEN_EXISTING,					// comm devices must use OPEN_EXISTING
						 0,								// Async I/O
						 NULL);							// template must be 0 for comm devices

	DCB dcb;
  	GetCommState( m_hComport, &dcb);
	dcb.BaudRate = CBR_19200;
	dcb.ByteSize = 8;
	dcb.Parity = NOPARITY;
	dcb.StopBits = ONESTOPBIT;

	dcb.fOutxDsrFlow = FALSE;
	dcb.fOutxCtsFlow = FALSE;
	dcb.fRtsControl = RTS_CONTROL_ENABLE; // RTS_CONTROL_TOGGLE;
	//dcb.fRtsControl = RTS_CONTROL_TOGGLE;
	dcb.fDtrControl = DTR_CONTROL_ENABLE; // RTS_CONTROL_ENABLE;
	dcb.fInX = dcb.fOutX = 0;  // Xon, Xoff 사용.
	
	// Timeout 환경 설정.
	COMMTIMEOUTS CommTimeOuts;
	CommTimeOuts.ReadIntervalTimeout = 20;
	CommTimeOuts.ReadTotalTimeoutMultiplier = 10;
	CommTimeOuts.ReadTotalTimeoutConstant = 100;
	CommTimeOuts.WriteTotalTimeoutMultiplier = 10;
	CommTimeOuts.WriteTotalTimeoutConstant = 100; 

	//dcb.fOutxDsrFlow = FALSE;
	//dcb.fOutxCtsFlow = FALSE;
	//dcb.fRtsControl = RTS_CONTROL_ENABLE;
	//dcb.fDtrControl = DTR_CONTROL_ENABLE;
	//dcb.fInX = dcb.fOutX = 0;  // Xon, Xoff 사용.

	//COMMTIMEOUTS CommTimeOuts;
	//commtimeouts.readintervaltimeout = 10;
	//commtimeouts.readtotaltimeoutmultiplier = 10;
	//commtimeouts.readtotaltimeoutconstant = 10;
	//commtimeouts.writetotaltimeoutmultiplier = 10;
	//commtimeouts.writetotaltimeoutconstant = 10;

	if( !SetCommTimeouts( m_hComport, &CommTimeOuts))
	{
		CloseHandle(m_hComport);
		m_hComport = NULL;

		return FALSE;		
	}

	SetCommState( m_hComport, &dcb);
	SetupComm( m_hComport, 4096, 4096);
	SetCommMask( m_hComport, EV_RXCHAR);

	PurgeComm( m_hComport, PURGE_TXABORT|PURGE_TXCLEAR|PURGE_RXABORT|PURGE_RXCLEAR );

	m_bIsConnected = true;

	return true;
}

void CSerial::ClosePort()
{
	RETAILMSG(1, (_T("Close Port Events\n")));
	EscapeCommFunction(m_hComport, SETRTS);
	EscapeCommFunction(m_hComport, SETDTR);

	if(m_bIsConnected)
	{
		// 연결 상태를 FALSE로 설정
		m_bIsConnected = false;
		// 모든 Event Mask 삭제
		SetCommMask(m_hComport, 0);
		// 통신 Queue 초기화
		PurgeComm(m_hComport, PURGE_TXABORT | PURGE_TXCLEAR | PURGE_RXABORT | PURGE_RXCLEAR);

		CloseHandle(m_hComport);
		m_hComport = NULL;
	}

	//AfxEndThread(0);
}

void CSerial::Flush(BOOL bRx, BOOL bTx)
{
	if(bRx == TRUE)	PurgeComm(m_hComport, PURGE_RXABORT | PURGE_RXCLEAR);
	if(bTx == TRUE)	PurgeComm(m_hComport, PURGE_TXABORT | PURGE_TXCLEAR);
}


void CSerial::SetParent(CCCPDlg *pParent)
{
	m_pParent	= pParent;

	m_pRoute	= &(m_pParent->m_Route);
	m_pStatus	= &(m_pParent->m_Status);
	m_pPacket	= &(m_pParent->m_Packet);
}

void CSerial::SendToPAC(DWORD dwReviceTime)
{
	CDBSchedule	*dbStation = NULL;
	DWORD	dwRead = 0;

	m_bySendBuff[0] = STX;
	BYTE_SPLIT( m_bySendBuff[1], m_bySendBuff[2], m_pStatus->GetCCPID() );			// SourceID
	BYTE_SPLIT( m_bySendBuff[3], m_bySendBuff[4], m_pPacket->GetSourceID() );		// DestinationID
	BYTE_SPLIT( m_bySendBuff[5], m_bySendBuff[6], m_pPacket->GetMessageCount() );	// MessageCount
	BYTE_SPLIT( m_bySendBuff[7], m_bySendBuff[8], COMMAND_INFO_ACK );				// CommandCode
	SHORT_SPLIT( m_bySendBuff[9], m_bySendBuff[10], m_bySendBuff[11], m_bySendBuff[12], 64 );
	//BYTE_SPLIT( m_bySendBuff[9], m_bySendBuff[10], 70 );							// DataLength

	BYTE_SPLIT( m_bySendBuff[13], m_bySendBuff[14], m_pPacket->PAC.PAC_T );			// PAC_T

	if( m_pPacket->PAC.CCI == 0x10 )
	{
		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+15 );
		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+21 );
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetTrainNumber(), m_bySendBuff+15 );		// Train Number
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetCrewID(), m_bySendBuff+21 );			// CREW ID
	}
	else
	{
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetTrainNumber(), m_bySendBuff+15 );		// Train Number
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetCrewID(), m_bySendBuff+21 );			// CREW ID
	}

	if( m_pStatus->IsSetCabonKey() )
	{
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetTripNumber(), m_bySendBuff+27 );
	}
	else if( m_pStatus->IsDetectCabOff() )
	{
		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+27 );
	}
	else
	{
		if(m_pPacket->IsStateCCI(m_pPacket->PAC.CCI))
		{
			memcpy( m_bySendBuff+27, m_pPacket->PAC.TRIP, sizeof(BYTE) * 6 );
		}
		else
		{
			m_pStatus->SetDetectCabOff(true);
		}
		
		m_pPacket->SetStateCCI(m_pPacket->PAC.CCI);
	}

	BYTE_SPLIT( m_bySendBuff[33], m_bySendBuff[34], m_pPacket->PAC.D1 );			// D1

	m_pPacket->DEC_TO_BCD4( m_pRoute->GetOriginStationNo(), m_bySendBuff+35 );

	dbStation = m_pRoute->GetActualStation();
	if( dbStation )
	{
		m_pPacket->DEC_TO_BCD4( dbStation->GetStationCode(), m_bySendBuff+39 );
	}
	else
	{
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+39 );
	}

	dbStation = m_pRoute->GetNextStation();
	if( dbStation )
	{
		m_pPacket->DEC_TO_BCD4( dbStation->GetStationCode(), m_bySendBuff+43 );
	}
	else
	{
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+43 );
	}

	m_pPacket->DEC_TO_BCD4( m_pRoute->GetDestinationStationNo(), m_bySendBuff+47 );

	// m_pStatus->
	BYTE_SPLIT( m_bySendBuff[51], m_bySendBuff[52], m_pStatus->GetSpeakerValueEsp() /*m_pPacket->PAC.SPK[0]*/);
	BYTE_SPLIT( m_bySendBuff[53], m_bySendBuff[54], m_pStatus->GetSpeakerValueInt() /*m_pPacket->PAC.SPK[1]*/);

	m_pPacket->DEC_TO_BCD8( 0, m_bySendBuff+55 );

	BYTE D2 = 0x00;

	if( m_pRoute->IsSimulate() ) D2 |= 0x80;

	D2 |= ( m_pStatus->GetCrossTime() % 2 == 1 ? 3 : 0 );


	//BYTE_SPLIT( m_bySendBuff[61], m_bySendBuff[62], m_pPacket->PAC.D2 );
	BYTE_SPLIT( m_bySendBuff[63], m_bySendBuff[64], D2 );

	BYTE_SPLIT( m_bySendBuff[65], m_bySendBuff[66], m_pPacket->PAC.D3 );

	if( m_pRoute->GetSelectedCM() >= 0 && ( m_pStatus->GetCrossTime() % 2 == 1 ) )
	{
		CDBCM	*dbCM = m_pParent->m_Route.GetCMByIndex( m_pRoute->GetSelectedCM() );

		if( dbCM != NULL)
		{
			BYTE_SPLIT( m_bySendBuff[67], m_bySendBuff[68], 0x9F );
			m_pPacket->DEC_TO_BCD4( dbCM->GetCMNo(), m_bySendBuff+69 );
		}
		else
		{
			BYTE_SPLIT( m_bySendBuff[67], m_bySendBuff[68], 0x00 );
			m_pPacket->DEC_TO_BCD4( 0x00, m_bySendBuff+69 );
		}
	}
	else
	{
		BYTE_SPLIT( m_bySendBuff[67], m_bySendBuff[68], 0x00 );
		m_pPacket->DEC_TO_BCD4( 0x00, m_bySendBuff+69 );
	}

	dbStation = m_pRoute->GetActualStation();
	if( dbStation && m_pStatus->IsSetCabonKey() && !m_pStatus->m_bChangingRoute )
	{
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 0 ), m_bySendBuff+73 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 1 ), m_bySendBuff+77 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 2 ), m_bySendBuff+81 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 3 ), m_bySendBuff+85 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 4 ), m_bySendBuff+89 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 5 ), m_bySendBuff+93 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 6 ), m_bySendBuff+97 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI()-1, 7 ), m_bySendBuff+101 );

		RETAILMSG(1, (_T("#TRIP : %06d - %04d - %04d - %04d - %04d - %04d - %04d - %04d - %04d \r\n"), m_pRoute->GetTripNumber(), 
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 0 ),
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 1 ),
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 2 ),
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 3 ),
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 4 ),
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 5 ),
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 6 ),
																						dbStation->GetVector( m_pRoute->GetTPI()-1, 7 ) ) );
	}
	else
	{
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+73 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+77 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+81 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+85 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+89 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+93 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+97 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+101 );
	}

	//memcpy(m_bySendBuff+103, m_pPacket->PAC.SKIP, sizeof(BYTE) * 20 );
	memset(m_bySendBuff+105, 0x30, sizeof(BYTE) * 20 );

	if( m_pStatus->IsSetCabonKey() )
	{
		//if( !m_pStatus->GetInuguration() )
		//{
		//	BOOL bZero = TRUE;
		//	UINT nCarCount = m_pPacket->GetCarCount();

		//	for(UINT i=0; i<nCarCount; i++)
		//	{
		//		if( m_pPacket->PAC.CI[i] != 0x00 )
		//		{
		//			bZero = FALSE;
		//			break;
		//		}
		//	}

		//	if( bZero )
		//	{
		//		for(UINT i=0; i<nCarCount; i++)
		//		{
		//			m_pPacket->PAC.CI_USER[i] = (i+1);
		//		}

		//		for(int i=nCarCount; i<8; i++)
		//		{
		//			m_pPacket->PAC.CI_USER[i] = 0x00;
		//		}
		//	}
		//}

		BYTE_SPLIT( m_bySendBuff[125], m_bySendBuff[126], m_pPacket->PAC.CI_USER[0] );
		BYTE_SPLIT( m_bySendBuff[127], m_bySendBuff[128], m_pPacket->PAC.CI_USER[1] );
		BYTE_SPLIT( m_bySendBuff[129], m_bySendBuff[130], m_pPacket->PAC.CI_USER[2] );
		BYTE_SPLIT( m_bySendBuff[131], m_bySendBuff[132], m_pPacket->PAC.CI_USER[3] );
		BYTE_SPLIT( m_bySendBuff[133], m_bySendBuff[134], m_pPacket->PAC.CI_USER[4] );
		BYTE_SPLIT( m_bySendBuff[135], m_bySendBuff[136], m_pPacket->PAC.CI_USER[5] );
		BYTE_SPLIT( m_bySendBuff[137], m_bySendBuff[138], m_pPacket->PAC.CI_USER[6] );
		BYTE_SPLIT( m_bySendBuff[139], m_bySendBuff[140], m_pPacket->PAC.CI_USER[7] );
	}
	else
	{
		BYTE_SPLIT( m_bySendBuff[125], m_bySendBuff[126], m_pPacket->PAC.CI[0] );
		BYTE_SPLIT( m_bySendBuff[127], m_bySendBuff[128], m_pPacket->PAC.CI[1] );
		BYTE_SPLIT( m_bySendBuff[129], m_bySendBuff[130], m_pPacket->PAC.CI[2] );
		BYTE_SPLIT( m_bySendBuff[131], m_bySendBuff[132], m_pPacket->PAC.CI[3] );
		BYTE_SPLIT( m_bySendBuff[133], m_bySendBuff[134], m_pPacket->PAC.CI[4] );
		BYTE_SPLIT( m_bySendBuff[135], m_bySendBuff[136], m_pPacket->PAC.CI[5] );
		BYTE_SPLIT( m_bySendBuff[137], m_bySendBuff[138], m_pPacket->PAC.CI[6] );
		BYTE_SPLIT( m_bySendBuff[139], m_bySendBuff[140], m_pPacket->PAC.CI[7] );
	}

	//SYSTEMTIME tm;
	//GetLocalTime(&tm);

	//m_pPacket->DEC_TO_BCD2( tm.wYear % 100, m_bySendBuff+139 );
	//m_pPacket->DEC_TO_BCD2( tm.wMonth, m_bySendBuff+141 );
	//m_pPacket->DEC_TO_BCD2( tm.wDay, m_bySendBuff+143 );
	//m_pPacket->DEC_TO_BCD2( tm.wHour, m_bySendBuff+145 );
	//m_pPacket->DEC_TO_BCD2( tm.wMinute, m_bySendBuff+147 );
	//m_pPacket->DEC_TO_BCD2( tm.wSecond, m_bySendBuff+149 );

	//for(int i=1; i<150; i++)
	for(int i=1; i<=140; i++)
	{	
		if( m_bySendBuff[i] > 0x39 && m_bySendBuff[i] < 0x40 )
		{
			m_bySendBuff[i] += 7;
		}
	}

	unsigned short CRC, byCRC[4];
	CRC = m_pPacket->crc16( (char *)( m_bySendBuff + 1 ), 140 );

	SHORT_SPLIT( byCRC[0], byCRC[1], byCRC[2], byCRC[3], CRC );

	if( byCRC[0] > 0x39 && byCRC[0] < 0x40 ) byCRC[0] += 7;
	if( byCRC[1] > 0x39 && byCRC[1] < 0x40 ) byCRC[1] += 7;
	if( byCRC[2] > 0x39 && byCRC[2] < 0x40 ) byCRC[2] += 7;
	if( byCRC[3] > 0x39 && byCRC[3] < 0x40 ) byCRC[3] += 7;
	
	m_bySendBuff[141] = (BYTE)byCRC[0];
	m_bySendBuff[142] = (BYTE)byCRC[1];
	m_bySendBuff[143] = (BYTE)byCRC[2];
	m_bySendBuff[144] = (BYTE)byCRC[3];

	m_bySendBuff[145] = 0x04;
	
	Sleep(5); 

	EscapeCommFunction(m_hComport, CLRRTS);

	Sleep(1); 

	WriteFile(m_hComport, m_bySendBuff, 146, &dwRead, NULL);

	Sleep(9);	// Scope로 Time 조정.

	EscapeCommFunction(m_hComport, SETRTS);
}

void CSerial::SendToPAC_Version()
{
	DWORD	dwRead = 0;

	m_bySendBuff[0] = STX;
	BYTE_SPLIT( m_bySendBuff[1], m_bySendBuff[2], m_pStatus->GetCCPID() );			// SourceID
	BYTE_SPLIT( m_bySendBuff[3], m_bySendBuff[4], m_pPacket->GetSourceID() );		// DestinationID
	BYTE_SPLIT( m_bySendBuff[5], m_bySendBuff[6], m_pPacket->GetMessageCount() );	// MessageCount
	BYTE_SPLIT( m_bySendBuff[7], m_bySendBuff[8], COMMAND_INFO_ACK_VER );				// CommandCode
	SHORT_SPLIT( m_bySendBuff[9], m_bySendBuff[10], m_bySendBuff[11], m_bySendBuff[12], 13 );

	memcpy(m_bySendBuff+13, m_pStatus->GetBuildDate(), sizeof(char) * 6 );		//DATE

	memcpy(m_bySendBuff+19, m_pStatus->GetVersion(), sizeof(char) * 6 );		//VERSION

	memcpy(m_bySendBuff+25, m_pStatus->GetBuildDate(), sizeof(char) * 6 );

	strncpy( (char *)m_bySendBuff+31, "100001", sizeof(char) * 6 );

	m_bySendBuff[37] = '0';
	m_bySendBuff[38] = '1';

	for(int i=1; i<=38; i++)
	{	
		if( m_bySendBuff[i] > 0x39 && m_bySendBuff[i] < 0x40 )
		{
			m_bySendBuff[i] += 7;
		}
	}

	unsigned short CRC, byCRC[4];
	CRC = m_pPacket->crc16( (char *)( m_bySendBuff + 1 ), 38 );

	SHORT_SPLIT( byCRC[0], byCRC[1], byCRC[2], byCRC[3], CRC );

	if( byCRC[0] > 0x39 && byCRC[0] < 0x40 ) byCRC[0] += 7;
	if( byCRC[1] > 0x39 && byCRC[1] < 0x40 ) byCRC[1] += 7;
	if( byCRC[2] > 0x39 && byCRC[2] < 0x40 ) byCRC[2] += 7;
	if( byCRC[3] > 0x39 && byCRC[3] < 0x40 ) byCRC[3] += 7;
	
	m_bySendBuff[39] = (BYTE)byCRC[0];
	m_bySendBuff[40] = (BYTE)byCRC[1];
	m_bySendBuff[41] = (BYTE)byCRC[2];
	m_bySendBuff[42] = (BYTE)byCRC[3];

	m_bySendBuff[43] = 0x04;

	Sleep(5); 

	EscapeCommFunction(m_hComport, CLRRTS);

	Sleep(1); 

	WriteFile(m_hComport, m_bySendBuff, 44, &dwRead, NULL);

	Sleep(9);	// Scope로 Time 조정.

	EscapeCommFunction(m_hComport, SETRTS);

}

void CSerial::SendToCNCS()
{
	UINT nLength, nCSIndex;

	m_bySendBuff[0] = STX;

	BYTE_SPLIT( m_bySendBuff[1], m_bySendBuff[2], m_pStatus->GetCCPID() );				// SourceID
	BYTE_SPLIT( m_bySendBuff[3], m_bySendBuff[4], m_pPacket->GetSourceID() );			// DestinationID
	BYTE_SPLIT( m_bySendBuff[5], m_bySendBuff[6], m_pPacket->GetMessageCount() );		// MessageCount
	BYTE_SPLIT( m_bySendBuff[7], m_bySendBuff[8], ( m_pPacket->GetCommandCode() + 1 ) );	// CommandCode

	nLength = m_Update.WriteBuffer( m_pPacket->GetCommandCode(),  &m_bySendBuff[13] );
	nCSIndex = 13 + ( nLength * 2 );

	m_pPacket->HEX_TO_BCD4( nLength, &m_bySendBuff[9] );

	// MAKE CHECK SUM

	BYTE CS = 0;

	for(UINT i=1; i < nCSIndex; i++)
	{	
		if( m_bySendBuff[i] > 0x39 && m_bySendBuff[i] < 0x40 )
		{
			m_bySendBuff[i] += 7;
		}

		CS ^= m_bySendBuff[i];
	}

	BYTE_SPLIT( m_bySendBuff[nCSIndex], m_bySendBuff[nCSIndex+1],	CS );

	if( m_bySendBuff[nCSIndex] > 0x39 && m_bySendBuff[nCSIndex] < 0x40 ) m_bySendBuff[nCSIndex] += 7;
	if( m_bySendBuff[nCSIndex+1] > 0x39 && m_bySendBuff[nCSIndex+1] < 0x40 ) m_bySendBuff[nCSIndex+1] += 7;

	// MAKE CHECK SUM

	// IDX : 47
	m_bySendBuff[nCSIndex+2] = ETX;

	// END OF MAKING BUFFER

	if( m_pPacket->GetDestinationID() != 0x3F )
	{
		EscapeCommFunction(m_hComport, CLRRTS);
		//EscapeCommFunction(m_hComport, CLRDTR);

		DWORD	dwWrite = 0;

		WriteFile(m_hComport, m_bySendBuff, (nCSIndex+3), &dwWrite, NULL);
		
		Sleep(9); 

		EscapeCommFunction(m_hComport, SETRTS);
		//EscapeCommFunction(m_hComport, SETDTR);
	}
}

UINT CSerial::GetCarMarriedType(CAR_DATA *pCarData)
{
	if( pCarData )
	{
		if( (pCarData->CARN & 0x01) == 0x01 )	// Married A
		{
			return 2;
		}
		else
		if( (pCarData->CARN & 0x01) == 0x00 )	// Married B
		{
			return 3;
		}
		else
		{
			return 2;
		}
	}

	return 0;

}