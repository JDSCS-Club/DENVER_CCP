#pragma once

#include "Packet.h"

#define DRVESC_GET_BRIGHTNESS		(0x00020300)
#define DRVESC_SET_BRIGHTNESS		(DRVESC_GET_BRIGHTNESS + 1)
#define DRVESC_ON_BRIGHTNESS		(DRVESC_GET_BRIGHTNESS + 2)
#define DRVESC_OFF_BRIGHTNESS		(DRVESC_GET_BRIGHTNESS + 3)


// CStatusVariable 명령 대상입니다.

class CStatusVariable : public CObject
{
private:
	HANDLE	m_hBLCOMPort;
	BYTE	m_byCabSpeaker;
	BYTE	m_byIntSpeaker;
	BYTE	m_byExtSpeaker;
	UINT	m_nBrightness;

	BYTE	m_byCCPID;
	bool	m_bIsUpdating;
	bool	m_bSetCabonKey;
	bool	m_bSetConducterKey;
	UINT	m_nDetectCabOff;
	bool	m_bInuguration;
	bool	m_bSetPEI;
	bool	m_bCheckPEI;

	int		m_nSetCount_ID_A;
	int		m_nSetCount_ID_B;
	int		m_nSetCount_CAB_ON;
	int		m_nSetCount_CAB_OFF;
	int		m_nSetCount_CON_ON;
	int		m_nSetCount_CON_OFF;

	//UINT	m_nPEICarNo;
	CArray<UINT, UINT>	m_arrPEICar;

	int		COSNT_Brightness[11];

	bool	m_bSetCrossTime;
	bool	m_bSetTouchCalibration_Master;
	bool	m_bSetTouchCalibration_Slave;

	char	m_szVersion[16];
	char	m_szBuildDate[16];

	bool	m_bUsing;
public:
	CAR_DATA	m_CarData[12];

	CStatusVariable();
	CString GetExecuteFilePath();

	virtual ~CStatusVariable();

	void	OpenConPort();
	void	BrightUp();
	void	BrightDown();
	void	ReadBrightNess();
	void	CloseConPort();

	void	SetCabSpeaker(BYTE byCabSpeaker);
	void	SetIntSpeaker(BYTE byIntSpeaker);
	void	SetExtSpeaker(BYTE byExtSpeaker);
	void	SetBrightnessUpDown(bool bUp, CWnd *pWnd);
	void	SetBrightness(UINT nBrightness, CWnd *pWnd);

	void	SetCCPID(BYTE byCCPID)				
	{ 
		if( byCCPID == ID_CCP_A )
		{
			m_nSetCount_ID_A++;
			m_nSetCount_ID_B = 0;

			if( m_nSetCount_ID_A >=3 )
			{
				m_nSetCount_ID_A = 3;
				m_byCCPID = ID_CCP_A; 
			}
		}
		else
		{
			m_nSetCount_ID_B++;
			m_nSetCount_ID_A = 0;

			if( m_nSetCount_ID_B >=3 )
			{
				m_nSetCount_ID_B = 3;
				m_byCCPID = ID_CCP_B; 
			}
		}
	}

	void	SetUpdating(bool bIsUpdating)		{ m_bIsUpdating = bIsUpdating; }
	void	SetCabonKey(bool bSetCabonKey)		
	{
		if( bSetCabonKey )
		{
			m_nSetCount_CAB_ON++;
			m_nSetCount_CAB_OFF = 0;

			if( m_nSetCount_CAB_ON >=3 )
			{
				m_nSetCount_CAB_ON = 3;
				m_bSetCabonKey = true; 
			}
		}
		else
		{
			m_nSetCount_CAB_OFF++;
			m_nSetCount_CAB_ON = 0;

			if( m_nSetCount_CAB_OFF >=3 )
			{
				m_nSetCount_CAB_OFF = 3;
				m_bSetCabonKey = false; 
			}
		}
	}
	void	SetDetectCabOff(bool bDetectCabOff)	
	{
		if( bDetectCabOff )
		{
			m_nDetectCabOff = 5;
		}
		else
		{
			if( m_nDetectCabOff > 0 ) m_nDetectCabOff--;
		}
	}

	void	SetConducterKey(bool bSetConducterKey)
	{ 
		if( bSetConducterKey )
		{
			m_nSetCount_CON_ON++;
			m_nSetCount_CON_OFF = 0;

			if( m_nSetCount_CON_ON >=3 )
			{
				m_nSetCount_CON_ON = 3;
				m_bSetConducterKey = true; 
			}
		}
		else
		{
			m_nSetCount_CON_OFF++;
			m_nSetCount_CON_ON = 0;

			if( m_nSetCount_CON_OFF >=3 )
			{
				m_nSetCount_CON_OFF = 3;
				m_bSetConducterKey = false; 
			}
		}
	}
	void	SetInuguration(bool bInuguration)	
	{ 
		m_bInuguration = bInuguration; 
	}
	void	SetPEI(bool bSetPEI, UINT	nPEICarNo = 0)
	{
		m_bSetPEI = bSetPEI; 
		
		if( !bSetPEI )
		{
			if( m_arrPEICar.GetCount() )	m_arrPEICar.RemoveAll();
		}
	}

	void	AddPEICarNo( UINT nPEICarNo )
	{
		m_arrPEICar.Add( nPEICarNo );
	}

	void	SetCheckPEI( bool bCheckPEI )	{ m_bCheckPEI = bCheckPEI; };
	void	SetCrossTime( bool bSetCrossTime )	{ m_bSetCrossTime = bSetCrossTime; }
	void	SetTouchCalibration_Master( bool bSetTouch )	{ m_bSetTouchCalibration_Master = bSetTouch; }
	void	SetTouchCalibration_Slave( bool bSetTouch )	{ m_bSetTouchCalibration_Slave = bSetTouch; }

	void	SetUsing( bool bUsing )	{ m_bUsing = bUsing; }

	BYTE	GetIntSpeaker();
	BYTE	GetExtSpeaker();
	BYTE	GetSpeakerValue();
	UINT	GetBrightness();

	BYTE	GetCCPID()		{ return m_byCCPID; }
	bool	IsUpdating()	{ return m_bIsUpdating; }
	bool	IsSetCabonKey()	{ return m_bSetCabonKey; }
	bool	IsSetConductorKey()	{ return m_bSetConducterKey; }
	bool	IsDetectCabOff()	{ return (m_nDetectCabOff > 0 ? true : false); }
	int		GetDetectCabOff()	{ return m_nDetectCabOff; }
	bool	GetInuguration(){ return m_bInuguration; }
	bool	IsSetPEI()		{ return m_bSetPEI; }
	UINT	GetPEICarNo()	
	{
		if( m_arrPEICar.GetCount() )
		{
			return m_arrPEICar.ElementAt( m_arrPEICar.GetCount() - 1 );
		}
		else
		{
			return 0;
		}

		return 0;
	}

	bool	FindPEICarNo( UINT nCarNo )
	{
		bool	nRet = false;

		for(int i=0; i<m_arrPEICar.GetCount(); i++)
		{
			if( m_arrPEICar.ElementAt(i) == nCarNo )
			{
				nRet = true;
				break;
			}
		}

		return nRet;
	}

	bool	GetCheckPEI	()	{ return m_bCheckPEI; }
	bool	GetCrossTime()	{ return m_bSetCrossTime; }
	bool	GetTouchCalibration_Master()	{ return m_bSetTouchCalibration_Master; };
	bool	GetTouchCalibration_Slave()		{ return m_bSetTouchCalibration_Slave; };

	char	*GetVersion()	{ return m_szVersion; };

	char	*GetBuildDate()	{ return m_szBuildDate; };

	bool	GetUsing()		{ return m_bUsing; }

};


