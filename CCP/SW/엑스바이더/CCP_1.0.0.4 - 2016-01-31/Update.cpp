// Update.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "Update.h"



// CUpdate

CUpdate::CUpdate()
{
	m_nUpdateIndex = 0;

	for(int i=0; i<7; i++)
	{
		m_nVer[i]		= 0;
		m_nUpdateVer[i]	= 0;
		m_nFileSize[i]	= 0;
		m_nFrameCount[i]= 0;
		m_pReceiveFrame[i] = NULL;
	}

	strcpy( m_szUpdateStatus[0], "\\NandFlash\\Update_CCP.txt" );
	strcpy( m_szUpdateStatus[1], "\\NandFlash\\Update_DB1.txt" );
	strcpy( m_szUpdateStatus[2], "\\NandFlash\\Update_DB2.txt" );
	strcpy( m_szUpdateStatus[3], "\\NandFlash\\Update_DB3.txt" );
	strcpy( m_szUpdateStatus[4], "\\NandFlash\\Update_DB4.txt" );
	strcpy( m_szUpdateStatus[5], "\\NandFlash\\Update_DB5.txt" );
	strcpy( m_szUpdateStatus[6], "\\NandFlash\\Update_DB6.txt" );

	strcpy( m_szUpdateFile[0], "\\NandFlash\\Update\\AnCCP_MFC.exe" );
	strcpy( m_szUpdateFile[1], "\\NandFlash\\Update\\ccp_schedule.nod" );
	strcpy( m_szUpdateFile[2], "\\NandFlash\\Update\\ccp_station.nod" );
	strcpy( m_szUpdateFile[3], "\\NandFlash\\Update\\ccp_trigger.nod" );
	strcpy( m_szUpdateFile[4], "\\NandFlash\\Update\\ccp_trainline.nod" );
	strcpy( m_szUpdateFile[5], "\\NandFlash\\Update\\ccp_holiday.nod" );
	strcpy( m_szUpdateFile[6], "\\NandFlash\\Update\\ccp_config.nod" );
}

CUpdate::~CUpdate()
{
	for(int i=0; i<7; i++)
	{
		if( m_pReceiveFrame[i] != NULL ) delete m_pReceiveFrame[i];
	}
}

// 버전정보 예제
//CCP:10040401
//SEH:10040900
//STA:10040900
//TRI:10040900	
//TRL:10040900
//HOL:10040900
//CFG:10040900

// CUpdate 멤버 함수
void CUpdate::GetVersion()
{
	m_nVer[0] = m_nVer[1] = m_nVer[2]= m_nVer[3] = m_nVer[4] = m_nVer[5] = m_nVer[6] = 0;

	FILE	*file;
	char	buffer[64];
	CString strBuf;

	file = fopen( FILENAME_VSERSION, "r");

	if( file == NULL )
	{
		return;
	}

	ZeroMemory(buffer, 64);

	while( fgets(buffer, 64, file) )
	{
		_MBtoWC(buffer, strBuf);

		if( strBuf.Find( _T("CCP:") ) != -1 )
		{
			strBuf = strBuf.Mid( strBuf.Find( _T(":") ) + 1 );
			m_nVer[0] = _tstoi( strBuf.GetBuffer(0) );
		}
		else if( strBuf.Find( _T("SEH:") ) != -1 )
		{
			strBuf = strBuf.Mid( strBuf.Find( _T(":") ) + 1 );
			m_nVer[1] = _tstoi( strBuf.GetBuffer(0) );
		}
		else if( strBuf.Find( _T("STA:") ) != -1 )
		{
			strBuf = strBuf.Mid( strBuf.Find( _T(":") ) + 1 );
			m_nVer[2] = _tstoi( strBuf.GetBuffer(0) );
		}
		else if( strBuf.Find( _T("TRI:") ) != -1 )
		{
			strBuf = strBuf.Mid( strBuf.Find( _T(":") ) + 1 );
			m_nVer[3] = _tstoi( strBuf.GetBuffer(0) );
		}
		else if( strBuf.Find( _T("TRL:") ) != -1 )
		{
			strBuf = strBuf.Mid( strBuf.Find( _T(":") ) + 1 );
			m_nVer[4] = _tstoi( strBuf.GetBuffer(0) );
		}
		else if( strBuf.Find( _T("HOL:") ) != -1 )
		{
			strBuf = strBuf.Mid( strBuf.Find( _T(":") ) + 1 );
			m_nVer[5] = _tstoi( strBuf.GetBuffer(0) );
		}
		else if( strBuf.Find( _T("CFG:") ) != -1 )
		{
			strBuf = strBuf.Mid( strBuf.Find( _T(":") ) + 1 );
			m_nVer[6] = _tstoi( strBuf.GetBuffer(0) );
		}

		ZeroMemory(buffer, 64);
	}

	fclose(file);
}

void CUpdate::SetVersion()
{
	GetVersion();

	FILE	*file;
	char	buffer[64];
	CString strBuf;

	file = fopen( FILENAME_VSERSION, "w+");

	if( file == NULL )
	{
		return;
	}

	if( m_pReceiveFrame[0] != NULL && GetRequestCount(0) == 0 )
	{
		sprintf( buffer, "CCP:%08d\n", m_nUpdateVer[0] ); 
	}
	else
	{
		sprintf( buffer, "CCP:%08d\n", m_nVer[0] ); 
	}
	fputs( buffer, file );
	
	if( m_pReceiveFrame[1] != NULL && GetRequestCount(1) == 0 )
	{
		sprintf( buffer, "SEH:%08d\n", m_nUpdateVer[1] ); 
	}
	else
	{
		sprintf( buffer, "SEH:%08d\n", m_nVer[1] ); 
	}
	fputs( buffer, file );

	if( m_pReceiveFrame[2] != NULL && GetRequestCount(2) == 0 )
	{
		sprintf( buffer, "STA:%08d\n", m_nUpdateVer[2] ); 
	}
	else
	{
		sprintf( buffer, "STA:%08d\n", m_nVer[2] ); 
	}
	fputs( buffer, file );

	if( m_pReceiveFrame[3] != NULL && GetRequestCount(3) == 0 )
	{
		sprintf( buffer, "TRI:%08d\n", m_nUpdateVer[3] ); 
	}
	else
	{
		sprintf( buffer, "TRI:%08d\n", m_nVer[3] ); 
	}
	fputs( buffer, file );

	if( m_pReceiveFrame[4] != NULL && GetRequestCount(4) == 0 )
	{
		sprintf( buffer, "TRL:%08d\n", m_nUpdateVer[4] ); 
	}
	else
	{
		sprintf( buffer, "TRL:%08d\n", m_nVer[4] ); 
	}
	fputs( buffer, file );

	if( m_pReceiveFrame[5] != NULL && GetRequestCount(5) == 0 )
	{
		sprintf( buffer, "HOL:%08d\n", m_nUpdateVer[5] ); 
	}
	else
	{
		sprintf( buffer, "HOL:%08d\n", m_nVer[5] ); 
	}
	fputs( buffer, file );

	if( m_pReceiveFrame[6] != NULL && GetRequestCount(6) == 0 )
	{
		sprintf( buffer, "CFG:%08d\n", m_nUpdateVer[6] ); 
	}
	else
	{
		sprintf( buffer, "CFG:%08d\n", m_nVer[6] ); 
	}
	fputs( buffer, file );

	fclose(file);
}


void CUpdate::GetVsersionStr(BYTE *szVer)
{
	GetVersion();

	sprintf( (char *)szVer, "%08d%08d%08d%08d%08d%08d%08d", m_nVer[0], m_nVer[1], m_nVer[2], m_nVer[3], 
															m_nVer[4], m_nVer[5], m_nVer[6] );
}

void CUpdate::ReadBuffer(BYTE byCommandCode, BYTE *byBuf, UINT nDataLen)
{
	UINT	nTarget = 0;
	UINT	nTargetIndex = 0;

	char	szVer[32];

	if( byCommandCode == 0xA0 )	// Version Check
	{
	}
	else
	if( byCommandCode == 0xA2 )	// Ready
	{
		UINT	nSaveUpdateVersion = 0;

		nTarget	= CPacket::BYTE_MERGE(byBuf[0], byBuf[1]);

		if( nTarget == 0xA6 )	nTargetIndex = 0;
		else if( nTarget == 0xA8 )	nTargetIndex = 1;
		else if( nTarget == 0xAA )	nTargetIndex = 2;
		else if( nTarget == 0xAC )	nTargetIndex = 3;
		else if( nTarget == 0xAE )	nTargetIndex = 4;
		else if( nTarget == 0xC0 )	nTargetIndex = 5;
		else if( nTarget == 0xC2 )	nTargetIndex = 6;
		else return;

		RETAILMSG(1, (_T("UPDATE - READY TARGET : %d\n"), nTargetIndex ) );

		m_nFileSize[nTargetIndex] = CPacket::HEX_FROM_BCD8( &byBuf[2] );

		m_nFrameCount[nTargetIndex] = CPacket::HEX_FROM_BCD8( &byBuf[10] );

		if( m_pReceiveFrame[nTargetIndex] != NULL)
		{
			delete m_pReceiveFrame[nTargetIndex];
		}

		m_pReceiveFrame[nTargetIndex] = new char[ m_nFrameCount[nTargetIndex] ];
		memset( m_pReceiveFrame[nTargetIndex], '0', sizeof(char) * m_nFrameCount[nTargetIndex] );

		if( LoadUpdateStatus( nTargetIndex, nSaveUpdateVersion ) )
		{
			m_nUpdateVer[nTargetIndex] = nSaveUpdateVersion;
		}
		else
		{
			m_nUpdateVer[nTargetIndex] = m_nVer[nTargetIndex];
		}

	}
	else
	if( byCommandCode == 0xB0 )	// Update Complete
	{
		UINT nSaveUpdateVersion = 0;
		UINT nReciveUpdateVer = 0;

		nTarget	= CPacket::BYTE_MERGE(byBuf[0], byBuf[1]);

		if( nTarget == 0xA6 )		nTargetIndex = 0;
		else if( nTarget == 0xA8 )	nTargetIndex = 1;
		else if( nTarget == 0xAA )	nTargetIndex = 2;
		else if( nTarget == 0xAC )	nTargetIndex = 3;
		else if( nTarget == 0xAE )	nTargetIndex = 4;
		else if( nTarget == 0xC0 )	nTargetIndex = 5;
		else if( nTarget == 0xC2 )	nTargetIndex = 6;
		else return;

		strncpy( szVer, (char *)&byBuf[2], sizeof(char) * 8 );
		szVer[8] = NULL;

		nReciveUpdateVer = atoi( szVer );

		if( nReciveUpdateVer != m_nUpdateVer[nTargetIndex] )
		{
			// Update Frame 초기화
			memset( m_pReceiveFrame[nTargetIndex], '0', sizeof(char) * m_nFrameCount[nTargetIndex] );

			m_nUpdateVer[nTargetIndex] = nReciveUpdateVer;

			InitUpdateFile( nTargetIndex );
			SaveUpdateStatus( nTargetIndex );
		}
		else if( nReciveUpdateVer == m_nVer[nTargetIndex] )
		{
			// Update Frame 초기화
			memset( m_pReceiveFrame[nTargetIndex], '1', sizeof(char) * m_nFrameCount[nTargetIndex] );

			m_nUpdateVer[nTargetIndex] = nReciveUpdateVer;
		}

		m_nUpdateIndex = nTargetIndex;
	}
	else
	if( byCommandCode == 0xA6 )	// Update CCP
	{
		m_nUpdateFrame = CPacket::HEX_FROM_BCD8( byBuf );

		UpdateFile( 0, m_nUpdateFrame, byBuf + 8 );
	}
	else
	if( byCommandCode == 0xA8 )	// Update DB1
	{
		m_nUpdateFrame = CPacket::HEX_FROM_BCD8( byBuf );

		UpdateFile( 1, m_nUpdateFrame, byBuf + 8 );
	}
	else
	if( byCommandCode == 0xAA )	// Update DB2
	{
		m_nUpdateFrame = CPacket::HEX_FROM_BCD8( byBuf );

		UpdateFile( 2, m_nUpdateFrame, byBuf + 8 );
	}
	else
	if( byCommandCode == 0xAC )	// Update DB3
	{
		m_nUpdateFrame = CPacket::HEX_FROM_BCD8( byBuf );

		UpdateFile( 3, m_nUpdateFrame, byBuf + 8 );
	}
	else
	if( byCommandCode == 0xAE )	// Update DB4
	{
		m_nUpdateFrame = CPacket::HEX_FROM_BCD8( byBuf );

		UpdateFile( 4, m_nUpdateFrame, byBuf + 8 );
	}
	else
	if( byCommandCode == 0xC0 )	// Update DB5
	{
		m_nUpdateFrame = CPacket::HEX_FROM_BCD8( byBuf );

		UpdateFile( 5, m_nUpdateFrame, byBuf + 8 );
	}
	else
	if( byCommandCode == 0xC2 )	// Update DB6
	{
		m_nUpdateFrame = CPacket::HEX_FROM_BCD8( byBuf );

		UpdateFile( 6, m_nUpdateFrame, byBuf + 8 );
	}
	else
	if( byCommandCode == 0xB2 )	// RESET
	{
		SetVersion();

		if( m_pReceiveFrame[0] != NULL && GetRequestCount(0) == 0 )
		{
			DeleteFile( _T("\\NandFlash\\Update_CCP.txt") );
		}

		if( m_pReceiveFrame[1] != NULL && GetRequestCount(1) == 0 )
		{
			DeleteFile( _T("\\NandFlash\\Update_DB1.txt") );
		}

		if( m_pReceiveFrame[2] != NULL && GetRequestCount(2) == 0 )
		{
			DeleteFile( _T("\\NandFlash\\Update_DB2.txt") );
		}

		if( m_pReceiveFrame[3] != NULL && GetRequestCount(3) == 0 )
		{
			DeleteFile( _T("\\NandFlash\\Update_DB3.txt") );
		}

		if( m_pReceiveFrame[4] != NULL && GetRequestCount(4) == 0 )
		{
			DeleteFile( _T("\\NandFlash\\Update_DB4.txt") );
		}

		if( m_pReceiveFrame[5] != NULL && GetRequestCount(5) == 0 )
		{
			DeleteFile( _T("\\NandFlash\\Update_DB5.txt") );
		}

		if( m_pReceiveFrame[6] != NULL && GetRequestCount(6) == 0 )
		{
			DeleteFile( _T("\\NandFlash\\Update_DB6.txt") );
		}
	}
}

UINT CUpdate::GetRequestCount(int nUpdateIndex)
{
	UINT nRequestCount = 0;

	for(UINT i=0; i<m_nFrameCount[nUpdateIndex]; i++)
	{
		if( m_pReceiveFrame[nUpdateIndex][i] != '1' )
		{
			nRequestCount++;
		}
	}

	return nRequestCount;

}

UINT CUpdate::WriteBuffer(BYTE byCommandCode, BYTE *byBuf)
{
	UINT nBufferLength = 0;

	if( byCommandCode == 0xA0 )	// Version Check
	{
		GetVsersionStr( byBuf );
		nBufferLength = 28;
	}
	else
	if( byCommandCode == 0xA2 )	// Ready
	{
	}
	else
	if( byCommandCode == 0xB0 && m_pReceiveFrame[m_nUpdateIndex] )	// Update Complete
	{
		UINT nRequestCount = 0;

		for(UINT i=0; i<m_nFrameCount[m_nUpdateIndex]; i++)
		{
			if( m_pReceiveFrame[m_nUpdateIndex][i] != '1' )
			{
				CPacket::HEX_TO_BCD8( i, (byBuf + ( (nRequestCount+1) * 8 ) ) );

				nRequestCount++;

				if( nRequestCount > 59 ) break;
			}
		}

		CPacket::HEX_TO_BCD8( nRequestCount, byBuf );

		nBufferLength = ( nRequestCount + 1 ) * 4;
	}
	else
	if( byCommandCode == 0xA6 )	// Update CCP
	{
		CPacket::HEX_TO_BCD8( m_nUpdateFrame, byBuf );

		nBufferLength = 4;
	}
	else
	if( byCommandCode == 0xA8 )	// Update DB1
	{
		CPacket::HEX_TO_BCD8( m_nUpdateFrame, byBuf );

		nBufferLength = 4;
	}
	else
	if( byCommandCode == 0xAA )	// Update DB2
	{
		CPacket::HEX_TO_BCD8( m_nUpdateFrame, byBuf );

		nBufferLength = 4;
	}
	else
	if( byCommandCode == 0xAC )	// Update DB3
	{
		CPacket::HEX_TO_BCD8( m_nUpdateFrame, byBuf );

		nBufferLength = 4;
	}
	else
	if( byCommandCode == 0xAE )	// Update DB4
	{
		CPacket::HEX_TO_BCD8( m_nUpdateFrame, byBuf );

		nBufferLength = 4;
	}
	else
	if( byCommandCode == 0xC0 )	// Update DB5
	{
		CPacket::HEX_TO_BCD8( m_nUpdateFrame, byBuf );

		nBufferLength = 4;
	}
	else
	if( byCommandCode == 0xC2 )	// Update DB6
	{
		CPacket::HEX_TO_BCD8( m_nUpdateFrame, byBuf );

		nBufferLength = 4;
	}
	else
	if( byCommandCode == 0xB2 )	// RESET
	{
	}

	return nBufferLength;
}

bool CUpdate::LoadUpdateStatus(UINT nTargetIndex, UINT & nSaveUpdateVersion)
{
	FILE	*file;
	char	buffer[512];

	file = fopen( m_szUpdateStatus[nTargetIndex], "r");

	if( file == NULL )
	{
		return false;
	}
	else
	{
		fgets(buffer, 512, file);

		nSaveUpdateVersion = atoi( buffer ); 

		fread( m_pReceiveFrame[nTargetIndex], sizeof(char), m_nFrameCount[nTargetIndex], file );

		fclose( file );
	}

	return true;
}

void CUpdate::SaveUpdateStatus(UINT nTargetIndex)
{
	FILE	*file;
	char	buffer[512];

	file = fopen( m_szUpdateStatus[nTargetIndex], "w+");

	if( file == NULL )
	{
		return;
	}

	sprintf( buffer, "%d\n", m_nUpdateVer[nTargetIndex] );
	
	fputs( buffer, file );
	
	fwrite( m_pReceiveFrame[nTargetIndex], sizeof(char), m_nFrameCount[nTargetIndex], file );

	fclose( file );

	return;
}

void CUpdate::InitUpdateFile( UINT nTargetIndex )
{
	BOOL bIsUpdateDir = FALSE;
	BOOL bIsBackupDir = FALSE;

	if( GetFileAttributes( _T(PATH_UPDATE) ) != 0xFFFFFFFF )
	{
		bIsUpdateDir = TRUE;
	}
	else
	{
		bIsUpdateDir = CreateDirectory(_T(PATH_UPDATE), NULL);
	}

	if( !bIsUpdateDir ) return;

	if( GetFileAttributes( _T(PATH_BACKUP) ) != 0xFFFFFFFF )
	{
		bIsBackupDir = TRUE;
	}
	else
	{
		bIsBackupDir = CreateDirectory(_T(PATH_BACKUP), NULL);
	}

	if( !bIsBackupDir ) return;

	FILE	*file;
	char	*szBuffer = new char[ m_nFileSize[nTargetIndex] ];

	memset( szBuffer, 0, m_nFileSize[nTargetIndex] );

	file = fopen( m_szUpdateFile[nTargetIndex], "w+");

	fseek( file, 0, SEEK_SET );

	fwrite( szBuffer, sizeof(char), m_nFileSize[nTargetIndex], file ); 

	fclose( file );

	delete szBuffer;
}

void CUpdate::UpdateFile( UINT nTargetIndex, UINT nUpdateFrame, BYTE *byBuf )
{
	FILE *file;
	BYTE byFileBuf[256];
	UINT nWriteCount = 512;

	if( m_nUpdateVer[nTargetIndex] == m_nVer[nTargetIndex] )
	{
		return;
	}

	file = fopen( m_szUpdateFile[nTargetIndex], "r+b");

	fseek( file, 256 * nUpdateFrame, SEEK_SET );

	//RETAILMSG(1, (_T("nTargetIndex %d nUpdateFrame %d POS %d \n"), nTargetIndex, nUpdateFrame, (256 * nUpdateFrame) ) );

	if( ( nUpdateFrame + 1 ) >= m_nFrameCount[nTargetIndex] )
	{
		nWriteCount = ( m_nFileSize[nTargetIndex] - ( nUpdateFrame * 256 ) ) * 2;
	}

	for(UINT i=0, j=0; i<nWriteCount; i+=2, j++)
	{
		byFileBuf[j] = CPacket::BYTE_MERGE(byBuf[i], byBuf[i+1]);	
	}

	fwrite( byFileBuf, sizeof(BYTE), nWriteCount / 2, file );

	fclose( file );

	m_pReceiveFrame[m_nUpdateIndex][nUpdateFrame] = '1';

	SaveUpdateStatus( nTargetIndex );
}
