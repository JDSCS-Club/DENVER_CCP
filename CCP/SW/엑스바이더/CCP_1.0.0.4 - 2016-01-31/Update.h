#pragma once

#include "Packet.h"

#define	PATH_UPDATE				"\\NandFlash\\Update\\"
#define	PATH_BACKUP				"\\NandFlash\\Backup\\"
#define	FILENAME_VSERSION	("\\NandFlash\\ccp_ver.txt")

// CUpdate 명령 대상입니다.

class CUpdate : public CObject
{
public:
	CUpdate();
	virtual ~CUpdate();

protected:
	UINT	m_nUpdateIndex;
	UINT	m_nUpdateFrame;
	UINT	m_nVer[7];
	UINT	m_nUpdateVer[7];
	UINT	m_nFileSize[7];
	UINT	m_nFrameCount[7];
	char	*m_pReceiveFrame[7];
	char	m_szUpdateStatus[7][64];
	char	m_szUpdateFile[7][64];

public:
	void	GetVersion();
	void	GetVsersionStr(BYTE *szVser);

	void	SetVersion();

	void	ReadBuffer(BYTE byCommandCode, BYTE *byBuf, UINT nDataLen);
	UINT	WriteBuffer(BYTE byCommandCode, BYTE *byBuf);
	UINT	GetRequestCount(int nUpdateIndex);

	bool	LoadUpdateStatus(UINT nTargetIndex, UINT & nSaveUpdateVersion);
	void	SaveUpdateStatus(UINT nTargetIndex);
	void	InitUpdateFile(UINT nTargetIndex);
	void	UpdateFile( UINT nTargetIndex, UINT nUpdateFrame, BYTE *byBuf );
};


