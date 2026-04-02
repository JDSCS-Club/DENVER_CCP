// Serial.cpp : 구현 파일입니다.
//
#include "stdafx.h"

#include "Serial.h"

// CSerial

IMPLEMENT_DYNCREATE(CSerial, CWinThread)

CSerial::CSerial()
{
	m_bReqTRIC = true;
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
					m_pPacket->SetPAC( szBuff + 1 + SIZE_HEADER );
				}
				else if( ( m_pPacket->GetSourceID() == ID_PAC_A || m_pPacket->GetDestinationID() == ID_PAC_B ) &&
					( m_pPacket->GetDestinationID() == m_pStatus->GetCCPID() ) &&
					m_pPacket->GetCommandCode() == COMMAND_INFO_REQ )
				{
					SendToPAC( ::GetTickCount() );
					//m_pPacket->SetPAC( szBuff + 1 + SIZE_HEADER );

				}
				else
				if( ( m_pPacket->GetSourceID() == ID_LIC_A || m_pPacket->GetSourceID() == ID_LIC_B ) ||
					( m_pPacket->GetDestinationID() == ID_PAC_A && m_pPacket->GetDestinationID() == ID_PAC_B ) )
				{
					//m_pPacket->SetPAC( szBuff + 1 + SIZE_HEADER );
				}
				else
				if( ( m_pPacket->GetSourceID() == ID_CNCS_A || m_pPacket->GetSourceID() == ID_CNCS_B )&&
					( m_pPacket->GetDestinationID() == ID_PAC_A || m_pPacket->GetDestinationID() == ID_PAC_B ) &&
					m_pPacket->GetCommandCode() == COMMAND_INFO_ACK )
				{
					m_pPacket->SetCNCS( szBuff + 1 + SIZE_HEADER );
				}

				//if( ( m_pPacket->GetSourceID() == ID_PAC_A || m_pPacket->GetSourceID() == ID_PAC_B )
				//	&&
				//	m_pPacket->GetCommandCode() == 0x10 )
				//{
				//	if( ( m_pPacket->GetDestinationID()  == ID_CCP_A ) || ( m_pPacket->GetDestinationID()  == ID_CCP_B ) )
				//	{
				//		m_pPacket->SetCalibration( szBuff + 1 + SIZE_HEADER, m_pParent->m_Status.GetCCPID() );
				//
				//		m_pStatus->SetTouchCalibration_Master(m_pPacket->GetTouchCalibration_Master());
				//		m_pStatus->SetTouchCalibration_Slave(m_pPacket->GetTouchCalibration_Slave());

				//		if( m_pPacket->GetDestinationID()  == m_pParent->m_Status.GetCCPID() )
				//		{				
				//			m_pParent->m_dwTickRecv = ::GetTickCount();
				//			m_pParent->m_bActiveCalibration = FALSE;

				//			m_pPacket->SetPAC( szBuff + 1 + SIZE_HEADER );

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
				//				m_pPacket->SetCarInfo(i, szBuff + 1 + SIZE_HEADER + SIZE_PAC_DATA + ( SIZE_PAC_CARINFO * i ) );
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

				//		nStation[0] = DEC_FROM_BCD4( szBuff[45], szBuff[46], szBuff[47], szBuff[48] );  
				//		nStation[1] = DEC_FROM_BCD4( szBuff[49], szBuff[50], szBuff[51], szBuff[52] );
				//		nStation[2] = DEC_FROM_BCD4( szBuff[53], szBuff[54], szBuff[55], szBuff[56] );
				//		nStation[3] = DEC_FROM_BCD4( szBuff[57], szBuff[58], szBuff[59], szBuff[60] );	

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

				//	m_Update.ReadBuffer(m_pPacket->GetCommandCode(), szBuff + 1 + SIZE_CSCNS_HEADER, m_pPacket->GetDataLength()  );
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

				//		m_pPacket->SetSkipInfo( szBuff );

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
	BYTE_SPLIT( m_bySendBuff[9], m_bySendBuff[10], 70 );							// DataLength

	BYTE_SPLIT( m_bySendBuff[11], m_bySendBuff[12], m_pPacket->PAC.PAC_T );			// PAC_T

	if( m_pPacket->PAC.CCI == 0x10 )
	{
		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+13 );
		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+19 );
	}
	else
	{
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetTrainNumber(), m_bySendBuff+13 );		// Train Number
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetCrewID(), m_bySendBuff+19 );			// CREW ID
	}

	if( m_pStatus->IsSetCabonKey() )
	{
		m_pPacket->DEC_TO_BCD6( m_pRoute->GetTripNumber(), m_bySendBuff+25 );
	}
	else if( m_pStatus->IsDetectCabOff() )
	{
		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+25 );
	}
	else
	{
		if(m_pPacket->IsStateCCI(m_pPacket->PAC.CCI))
		{
			memcpy( m_bySendBuff+25, m_pPacket->PAC.TRIP, sizeof(BYTE) * 6 );
		}
		else
		{
			m_pStatus->SetDetectCabOff(true);
		}
		
		m_pPacket->SetStateCCI(m_pPacket->PAC.CCI);
	}

	BYTE_SPLIT( m_bySendBuff[31], m_bySendBuff[32], m_pPacket->PAC.D1 );			// D1

	m_pPacket->DEC_TO_BCD4( m_pRoute->GetOriginStationNo(), m_bySendBuff+33 );

	dbStation = m_pRoute->GetActualStation();
	if( dbStation )
	{
		m_pPacket->DEC_TO_BCD4( dbStation->GetStationCode(), m_bySendBuff+37 );
	}
	else
	{
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+37 );
	}

	dbStation = m_pRoute->GetNextStation();
	if( dbStation )
	{
		m_pPacket->DEC_TO_BCD4( dbStation->GetStationCode(), m_bySendBuff+41 );
	}
	else
	{
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+41 );
	}

	m_pPacket->DEC_TO_BCD4( m_pRoute->GetDestinationStationNo(), m_bySendBuff+45 );

	BYTE_SPLIT( m_bySendBuff[49], m_bySendBuff[50], m_pPacket->PAC.SPK[0]);
	BYTE_SPLIT( m_bySendBuff[51], m_bySendBuff[52], m_pPacket->PAC.SPK[1]);

	m_pPacket->DEC_TO_BCD8( 0, m_bySendBuff+53 );

	//BYTE_SPLIT( m_bySendBuff[61], m_bySendBuff[62], m_pPacket->PAC.D2 );
	m_bySendBuff[61] = 0x33;
	m_bySendBuff[62] = 0x30;
	BYTE_SPLIT( m_bySendBuff[63], m_bySendBuff[64], m_pPacket->PAC.D3 );

	BYTE_SPLIT( m_bySendBuff[65], m_bySendBuff[66], m_pPacket->PAC.PR );
	m_pPacket->DEC_TO_BCD4( m_pPacket->PAC.PRVCT, m_bySendBuff+67 );

	dbStation = m_pRoute->GetActualStation();
	if( dbStation )
	{
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 0 ), m_bySendBuff+71 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 1 ), m_bySendBuff+75 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 2 ), m_bySendBuff+79 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 3 ), m_bySendBuff+83 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 4 ), m_bySendBuff+87 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 5 ), m_bySendBuff+91 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 6 ), m_bySendBuff+95 );
		m_pPacket->DEC_TO_BCD4( dbStation->GetVector( m_pRoute->GetTPI(), 7 ), m_bySendBuff+99 );

		RETAILMSG(1, (_T("#TRIP : %06d - %04d - %04d - %04d - %04d - %04d - %04d \r\n"), m_pRoute->GetTripNumber(), 
																						dbStation->GetVector( m_pRoute->GetTPI(), 0 ),
																						dbStation->GetVector( m_pRoute->GetTPI(), 1 ),
																						dbStation->GetVector( m_pRoute->GetTPI(), 2 ),
																						dbStation->GetVector( m_pRoute->GetTPI(), 3 ),
																						dbStation->GetVector( m_pRoute->GetTPI(), 4 ),
																						dbStation->GetVector( m_pRoute->GetTPI(), 5 ),
																						dbStation->GetVector( m_pRoute->GetTPI(), 6 ),
																						dbStation->GetVector( m_pRoute->GetTPI(), 7 ) ) );
	}
	else
	{
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+71 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+75 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+79 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+83 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+87 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+91 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+95 );
		m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+99 );
	}


	//memcpy(m_bySendBuff+103, m_pPacket->PAC.SKIP, sizeof(BYTE) * 20 );
	memset(m_bySendBuff+103, 0x30, sizeof(BYTE) * 20 );

	if( m_pStatus->IsSetCabonKey() )
	{
		if( !m_pStatus->GetInuguration() )
		{
			BOOL bZero = TRUE;
			UINT nCarCount = m_pPacket->GetCarCount();

			for(int i=0; i<nCarCount; i++)
			{
				if( m_pPacket->PAC.CI[i] != 0x00 )
				{
					bZero = FALSE;
					break;
				}
			}

			if( bZero )
			{
				for(int i=0; i<nCarCount; i++)
				{
					m_pPacket->PAC.CI_USER[i] = (i+1);
				}

				for(int i=nCarCount; i<8; i++)
				{
					m_pPacket->PAC.CI_USER[i] = 0x00;
				}
			}
		}


		BYTE_SPLIT( m_bySendBuff[123], m_bySendBuff[124], m_pPacket->PAC.CI_USER[0] );
		BYTE_SPLIT( m_bySendBuff[125], m_bySendBuff[126], m_pPacket->PAC.CI_USER[1] );
		BYTE_SPLIT( m_bySendBuff[127], m_bySendBuff[128], m_pPacket->PAC.CI_USER[2] );
		BYTE_SPLIT( m_bySendBuff[129], m_bySendBuff[130], m_pPacket->PAC.CI_USER[3] );
		BYTE_SPLIT( m_bySendBuff[131], m_bySendBuff[132], m_pPacket->PAC.CI_USER[4] );
		BYTE_SPLIT( m_bySendBuff[133], m_bySendBuff[134], m_pPacket->PAC.CI_USER[5] );
		BYTE_SPLIT( m_bySendBuff[135], m_bySendBuff[136], m_pPacket->PAC.CI_USER[6] );
		BYTE_SPLIT( m_bySendBuff[137], m_bySendBuff[138], m_pPacket->PAC.CI_USER[7] );
	}
	else
	{
		BYTE_SPLIT( m_bySendBuff[123], m_bySendBuff[124], m_pPacket->PAC.CI[0] );
		BYTE_SPLIT( m_bySendBuff[125], m_bySendBuff[126], m_pPacket->PAC.CI[1] );
		BYTE_SPLIT( m_bySendBuff[127], m_bySendBuff[128], m_pPacket->PAC.CI[2] );
		BYTE_SPLIT( m_bySendBuff[129], m_bySendBuff[130], m_pPacket->PAC.CI[3] );
		BYTE_SPLIT( m_bySendBuff[131], m_bySendBuff[132], m_pPacket->PAC.CI[4] );
		BYTE_SPLIT( m_bySendBuff[133], m_bySendBuff[134], m_pPacket->PAC.CI[5] );
		BYTE_SPLIT( m_bySendBuff[135], m_bySendBuff[136], m_pPacket->PAC.CI[6] );
		BYTE_SPLIT( m_bySendBuff[137], m_bySendBuff[138], m_pPacket->PAC.CI[7] );
	}

	SYSTEMTIME tm;
	GetLocalTime(&tm);

	m_pPacket->DEC_TO_BCD2( tm.wYear % 100, m_bySendBuff+139 );
	m_pPacket->DEC_TO_BCD2( tm.wMonth, m_bySendBuff+141 );
	m_pPacket->DEC_TO_BCD2( tm.wDay, m_bySendBuff+143 );
	m_pPacket->DEC_TO_BCD2( tm.wHour, m_bySendBuff+145 );
	m_pPacket->DEC_TO_BCD2( tm.wMinute, m_bySendBuff+147 );
	m_pPacket->DEC_TO_BCD2( tm.wSecond, m_bySendBuff+149 );

	for(int i=1; i<150; i++)
	{	
		if( m_bySendBuff[i] > 0x39 && m_bySendBuff[i] < 0x40 )
		{
			m_bySendBuff[i] += 7;
		}
	}

	unsigned short CRC, byCRC[4];
	CRC = m_pPacket->crc16( (char *)( m_bySendBuff + 1 ), 150 );

	SHORT_SPLIT( byCRC[0], byCRC[1], byCRC[2], byCRC[3], CRC );

	if( byCRC[0] > 0x39 && byCRC[0] < 0x40 ) byCRC[0] += 7;
	if( byCRC[1] > 0x39 && byCRC[1] < 0x40 ) byCRC[1] += 7;
	if( byCRC[2] > 0x39 && byCRC[2] < 0x40 ) byCRC[2] += 7;
	if( byCRC[3] > 0x39 && byCRC[3] < 0x40 ) byCRC[3] += 7;
	
	m_bySendBuff[151] = byCRC[0];
	m_bySendBuff[152] = byCRC[1];
	m_bySendBuff[153] = byCRC[2];
	m_bySendBuff[154] = byCRC[3];

	m_bySendBuff[155] = 0x04;
	
	Sleep(5); 

	EscapeCommFunction(m_hComport, CLRRTS);

	Sleep(1); 

	WriteFile(m_hComport, m_bySendBuff, 156, &dwRead, NULL);

	Sleep(9);	// Scope로 Time 조정)

	EscapeCommFunction(m_hComport, SETRTS);


//
//	dbStation = m_pRoute->GetActualStation();
//	m_pPacket->DEC_TO_BCD4( dbStation->GetArriveStationNo(), m_bySendBuff+63 );
//
//	dbStation = m_pRoute->GetNextStation();
//	m_pPacket->DEC_TO_BCD4( dbStation->GetArriveStationNo(), m_bySendBuff+67 );
//
//	dbStation = m_pRoute->GetActualStation();
//	m_pPacket->DEC_TO_BCD4( dbStation->GetLastStationNo(), m_bySendBuff+71 );

//	BYTE *pLength = NULL;
//	int nLength = { 0x00, };
//
//	CDBSchedule	*dbStation = NULL;
//	CDBSchedule	*dbNextStation = NULL;
//
//	dbStation = m_pRoute->GetActualStation();
//	dbNextStation = m_pRoute->GetNextStation();
//
//	m_bySendBuff[0] = STX;
//
//	BYTE_SPLIT( m_bySendBuff[1], m_bySendBuff[2], m_pStatus->GetCCPID() );			// SourceID
//	BYTE_SPLIT( m_bySendBuff[3], m_bySendBuff[4], m_pPacket->GetSourceID() );		// DestinationID
//	BYTE_SPLIT( m_bySendBuff[5], m_bySendBuff[6], m_pPacket->GetMessageCount() );	// MessageCount
//	BYTE_SPLIT( m_bySendBuff[7], m_bySendBuff[8], ( m_bReqTRIC ? 0x1A :0x11 ) );	// CommandCode
//	
//	pLength = &m_bySendBuff[9];
//	//BYTE_SPLIT( m_bySendBuff[9], m_bySendBuff[10], 0x36 );							// DataLength
//	nLength = 11;
//
//	BYTE_SPLIT( m_bySendBuff[11], m_bySendBuff[12], m_pPacket->PAC.PAC_T );			// PAC_T
//	//BYTE_SPLIT( m_bySendBuff[13], m_bySendBuff[14], m_pPacket->PAC.CCP_M );		// CCP_M
//	BYTE_SPLIT( m_bySendBuff[13], m_bySendBuff[14], 0x08 );							// CCP_M
//	BYTE_SPLIT( m_bySendBuff[15], m_bySendBuff[16], m_pPacket->PAC.CNCS_T );		// CNCS_T
//
//	m_pPacket->PAC.D0 = m_pPacket->PAC.D0 & 0xF7;
//
//	if( m_pRoute->IsSimulate() )
//	{
//		m_pPacket->PAC.D0 |= 0x08;
//	}
//
//	if( m_pStatus->IsSetCabonKey() )
//	{
//		m_pPacket->PAC.D0 |= ( m_pStatus->GetCCPID() == ID_CCP_A ? 0x20 : 0x40);
//	}
//
//	BYTE_SPLIT( m_bySendBuff[17], m_bySendBuff[18], m_pPacket->PAC.D0 );			// D0
//
//	BYTE	MASK_D1 = 0;
//
//	m_pPacket->PAC.D1 = dbStation->GetRouteNo();
//
//	if( m_pStatus->IsSetConductorKey() )
//	{
//		MASK_D1 = ( m_pStatus->GetCCPID() == ID_CCP_A ? 0x20 : 0x40 );
//	}
//	else
//	{
//		MASK_D1 = 0;
//	}
//
//	m_pPacket->PAC.D1 |= MASK_D1;
//	BYTE_SPLIT( m_bySendBuff[19], m_bySendBuff[20], m_pPacket->PAC.D1 );			// D1
//
//	if( m_pPacket->PAC.CCI == 0x10 )
//	{
//		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+21 );
//	}
//	else
//	{
//		m_pPacket->DEC_TO_BCD6( m_pRoute->GetTrainNumber(), m_bySendBuff+21 );	// Train Number
//	}
//
//	//if( m_pStatus->IsSetCabonKey() || m_pStatus->IsSetConductorKey() )
//	//{
//	//	if( m_pRoute->IsSetRoute() )
//	//	{
//	//		m_pPacket->DEC_TO_BCD6( m_pRoute->GetTrainNumber(), m_bySendBuff+21 );	// Train Number
//	//	}
//	//	else
//	//	{
//	//		m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+21 );							// Train Number
//	//	}
//	//}
//	//else
//	//{
//	//	m_pPacket->DEC_TO_BCD6( 0, m_bySendBuff+21 );								// Train Number
//	//}
//	
//	m_pPacket->DEC_TO_BCD6( m_pRoute->GetCrewID(), m_bySendBuff+27 );				// CREW ID
//
//	BYTE_SPLIT( m_bySendBuff[33], m_bySendBuff[34], m_pPacket->PAC.DS );			// DS
//	BYTE_SPLIT( m_bySendBuff[35], m_bySendBuff[36], m_pPacket->PAC.NOWD );			// NOWD
//	BYTE_SPLIT( m_bySendBuff[37], m_bySendBuff[38], m_pPacket->PAC.NEXD );			// NEXD
//
//	// 39 ~ 44 TRIGGER ID
//
//	if( m_pStatus->IsSetCabonKey() )
//	{
//		m_pPacket->DEC_TO_BCD4( m_pRoute->GetTripNumber(), m_bySendBuff+39 );
//
//		char szTP[4];
//
//		if( m_pRoute->IsSimulate() )
//		{
//			sprintf(szTP, "%02d", m_pRoute->GetTPNumber() );
//		}
//		else
//		{
//			if( m_pRoute->GetAcutalTriggerIndex() == 5 &&
//				( m_pPacket->GetDoorL() != 2 && m_pPacket->GetDoorR() != 2 ) )
//			{
//				sprintf(szTP, "00" );
//			}
//			else
//			{
//				sprintf(szTP, "%02d", m_pRoute->GetTPNumber() );
//			}
//		}
//
//		memcpy( m_bySendBuff + 43, szTP, sizeof(char) * 2 );
//	}
//	else if( m_pStatus->IsDetectCabOff() )
//	{
//		FillMemory( m_bySendBuff+39, sizeof(BYTE) * 6, 0x30 );
//		m_pStatus->SetDetectCabOff(false);
//	}
//	else
//	{
//		if(m_pPacket->IsStateCCI(m_pPacket->PAC.CCI))
//		{
//			memcpy( m_bySendBuff+39, m_pPacket->PAC.TRIP, sizeof(BYTE) * 6 );
//		}
//		else
//		{
//			m_pStatus->SetDetectCabOff(true);
//		}
//		
//		m_pPacket->SetStateCCI(m_pPacket->PAC.CCI);
//	}
//
//	m_pPacket->DEC_TO_BCD4( m_pPacket->PAC.CARN, m_bySendBuff+45 );					// CARN
//
//	if( dbStation->GetTrafficType() == 'S' )		m_pPacket->PAC.D2 = 0x80;	
//	else if( dbStation->GetTrafficType() == 'E' )	m_pPacket->PAC.D2 = 0x40;
//	else if( dbStation->GetTrafficType() == 'F' )	m_pPacket->PAC.D2 = 0xC0;
//
//	if( dbStation->GetLEDMark() == 1 )				m_pPacket->PAC.D2 |= 0x01;
//	else if( dbStation->GetLEDMark() == 2 )			m_pPacket->PAC.D2 |= 0x02;
//	else if( dbStation->GetLEDMark() == 3 )			m_pPacket->PAC.D2 |= 0x04;
//	else if( dbStation->GetLEDMark() == 4 )			m_pPacket->PAC.D2 |= 0x08;
//
//	switch( dbStation->GetLedDestination( m_pStatus->GetCrossTime() ) )
//	{
//		case CDBSchedule::eLED_DESTINATION_VIA_CENTER_CITY:
//		{
//			if( dbStation->GetUpDown() == 'N'  && m_pRoute->GetAcutalTriggerIndex() > 5 )
//			{
//				if( dbNextStation->GetLedDestination( m_pStatus->GetCrossTime() ) == CDBSchedule::eLED_DESTINATION_VIA_CENTER_CITY )
//				{
//					m_pPacket->PAC.D2 |= 0x10;
//				}
//			}
//			else if( dbStation->GetUpDown() == 'S'  && m_pRoute->GetAcutalTriggerIndex() < 5 )
//			{
//				if( dbNextStation->GetLedDestination( m_pStatus->GetCrossTime() ) == CDBSchedule::eLED_DESTINATION_VIA_CENTER_CITY )
//				{
//					m_pPacket->PAC.D2 |= 0x10;
//				}
//			}
//			else
//			{
//				m_pPacket->PAC.D2 |= 0x10;
//			}
//			
//			break;
//		}
//		case CDBSchedule::eLED_DESTINATION_MASK_NAME:			m_pPacket->PAC.D2 |= 0x20;		break;
//	}
//
//	if( !m_pRoute->IsSetRoute() )
//	{
//		m_pPacket->PAC.D2 = 0x01;
//	}
//
//	BYTE_SPLIT( m_bySendBuff[49], m_bySendBuff[50], m_pPacket->PAC.D2 );			// D2
//
//	m_pPacket->DEC_TO_BCD4( 0, m_bySendBuff+51 );									// D3 -> SET : 0
//
//	BYTE_SPLIT( m_bySendBuff[55], m_bySendBuff[56], m_pPacket->PAC.DTI );			// DTI
//
//	BYTE bySPK = m_pStatus->GetSpeakerValue();
//
//	UINT nSPK[2];
//	nSPK[0] = m_pRoute->GetStationSPK() / 10;
//	nSPK[1] = m_pRoute->GetStationSPK() % 10;
//
//	if( nSPK[0] == 1 )		// ISPK MUTE
//	{
//		bySPK &= 0x0F;
//		bySPK |= 0x10; 
//	}
//
//	if( nSPK[1] == 0 )	bySPK |= 0x80;
//	else if( nSPK[1] == 1 )	bySPK |= 0x81;			// LEFT SPK / RIGHT MUTE
//	else if( nSPK[1] == 2 )	bySPK |= 0x82;		// LEFT MUTE / RIGHT SPK
//	else if( nSPK[1] == 3 )	bySPK |= 0x83;		// LEFT MUTE / RIGHT MUTE
//	else if( nSPK[1] == 4 ) bySPK |= 0x00;		// PAC SPEAKER CONTROL FLAG
//
//	BYTE_SPLIT( m_bySendBuff[57], m_bySendBuff[58],	bySPK );	// SPK
//
//	dbStation = m_pRoute->GetDepartureStation();
//	m_pPacket->DEC_TO_BCD4( dbStation->GetArriveStationNo(), m_bySendBuff+59 );
//
//	dbStation = m_pRoute->GetActualStation();
//	m_pPacket->DEC_TO_BCD4( dbStation->GetArriveStationNo(), m_bySendBuff+63 );
//
//	dbStation = m_pRoute->GetNextStation();
//	m_pPacket->DEC_TO_BCD4( dbStation->GetArriveStationNo(), m_bySendBuff+67 );
//
//	dbStation = m_pRoute->GetActualStation();
//	m_pPacket->DEC_TO_BCD4( dbStation->GetLastStationNo(), m_bySendBuff+71 );
//
//	BYTE_SPLIT( m_bySendBuff[75], m_bySendBuff[76],	m_pPacket->PAC.D4 );		// D4
//	
//	memcpy(m_bySendBuff+77, szDate, 12);
//	
//	memcpy(m_bySendBuff+89, m_pRoute->m_bySkipFlag, sizeof(BYTE) * 20 );
//
//	memcpy(m_bySendBuff+109, m_pStatus->GetVersion(), sizeof(char) * 4 );		//VERSION
//
//	memcpy(m_bySendBuff+113, m_pStatus->GetBuildDate(), sizeof(char) * 6 );		//DATE
//
//	// Calc DataLength
//	BYTE_SPLIT( *pLength, *(pLength+1), ((119 - nLength) / 2) );							// DataLength
//
//	// MAKE CHECK SUM
//	BYTE CS = 0;
//
//	for(int i=1; i<119; i++)
//	{	
//		if( m_bySendBuff[i] > 0x39 && m_bySendBuff[i] < 0x40 )
//		{
//			m_bySendBuff[i] += 7;
//		}
//
//		CS ^= m_bySendBuff[i];
//	}
//
//	BYTE_SPLIT( m_bySendBuff[119], m_bySendBuff[120],	CS );
//
//	if( m_bySendBuff[119] > 0x39 && m_bySendBuff[119] < 0x40 ) m_bySendBuff[119] += 7;
//	if( m_bySendBuff[120] > 0x39 && m_bySendBuff[120] < 0x40 ) m_bySendBuff[120] += 7;
//
//	m_bySendBuff[121] = ETX;
////RETAILMSG(1, (_T("SendToPAC 1-2(%d)\n"), GetTickCount() - lTickCount));
//
//	DWORD	dwRead = 0;
//
//	Sleep(5); 
//
//	EscapeCommFunction(m_hComport, CLRRTS);
//	//EscapeCommFunction(m_hComport, CLRDTR);
//
//	Sleep(1); 
//
//	//RETAILMSG(1, (_T("Send Time Gap : %d\n"), GetTickCount() - dwReviceTime));
//	if((GetTickCount() - dwReviceTime) < 20)
//		WriteFile(m_hComport, m_bySendBuff, 122, &dwRead, NULL);
//	//else
//	//	RETAILMSG(1, (_T("\tRise Send Time Gap : %d\n"), GetTickCount() - dwReviceTime));
//
//	Sleep(9);	// Scope로 Time 조정)
//	// Sleep(32);	// Scope로 Time 조정)
//
//	EscapeCommFunction(m_hComport, SETRTS);
//	//EscapeCommFunction(m_hComport, SETDTR);
//
//	if( m_bReqTRIC )	m_bReqTRIC = false;
//
//	//CString strLog;
//	//strLog.Format( _T("[TX] MC : %02X, LEN : %d "), m_pPacket->GetMessageCount(), ( dwRead >> 1 ) );
//
//	//m_pParent->PostMessage( WM_WRITE_LOG, (WPARAM)&strLog, 1 );
//
//	//for(UINT i=0; i<=116; i++)
//	//{
//	//	RETAILMSG(1, ( _T("%c"), m_bySendBuff[i] ) );
//	//}
//	//RETAILMSG(1, (_T("\r\n") ) );
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
