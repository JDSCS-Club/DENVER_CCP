#pragma once

class CTP	: public CObject
{

public:

	UINT	TP_INDEX;
	double	TP_LAT;
	double	TP_LOT;
	bool	TP_ANNOUNCED;

	CTP()
	{
		TP_INDEX = 0;
		TP_LAT = TP_LOT = 0.0;
		TP_ANNOUNCED = false;
	}

	CTP(const CTP& cTP)
	{
		TP_INDEX	= cTP.TP_INDEX;
		TP_LAT		= cTP.TP_LAT;
		TP_LOT		= cTP.TP_LOT;
		TP_ANNOUNCED = cTP.TP_ANNOUNCED;
	}

	virtual ~CTP()
	{
	}

	CTP &operator=(const CTP& CTP)
	{
		TP_INDEX		= CTP.TP_INDEX;
		TP_LAT			= CTP.TP_LAT;
		TP_LOT			= CTP.TP_LOT;
		TP_ANNOUNCED	= CTP.TP_ANNOUNCED;

		return *this;
	}
};

typedef CArray<CTP, CTP &>	ARY_TP;

// CDBTrigger 명령 대상입니다.

class CDBTrigger : public CObject
{
public:
	ARY_TP		m_arrTP;

	CDBTrigger();
	virtual ~CDBTrigger();

	CDBTrigger &operator=(const CDBTrigger& DBTrigger);

	UINT		GetStationNo();
	void		SetData(UINT nStationNo, UINT nTriggerIdx, double dblLat, double dblLot);
	void		SetAnnounced(UINT nTP_Index);
	
protected:
	UINT		m_nStationNo;
};