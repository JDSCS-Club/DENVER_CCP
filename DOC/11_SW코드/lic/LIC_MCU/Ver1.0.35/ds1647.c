/**********************************************************************
 * Details:
 *
 * Porgram By Yeon Jun Sang
 *
 *	DS1646 consists of 8 8-bit registers for 
 *	control and time keeping. The date and time registers are in BCD format, 
 *	arranged as shown below:
 *
 *                        Data
 *   Address    |  D7 D6 D5 D4 D3 D2 D1 D0 |  Function
 *   ---------+--------------------------+----------------------
 *   0x7ffff    |  -- -- -- -- -- -- -- -- |  Year     (00-0x99)
 *   0x7fffe    |   0  0  0 -- -- -- -- -- |  Month    (01-0x12)
 *   0x7fffd    |   0  0 -- -- -- -- -- -- |  Day      (01-0x31)
 *   0x7fffc    |   0 FT  0  0  0 -- -- -- |  Weekday  (01-0x7)
 *   0x7fffb    |  KS  0 -- -- -- -- -- -- |  Hour     (00-0x23)
 *   0x7fffa    |   0 -- -- -- -- -- -- -- |  Minutes  (00-0x59)
 *   0x7fff9    |  ST -- -- -- -- -- -- -- |  Seconds  (00-0x59)
 *   0x7fff8    |   W  R  S -- -- -- -- -- |  Control
 *   ---------+--------------------------+----------------------
 *   Key:  ST = Stop Bit     R = Read Bit      FT = Frequency Test
 *          W = Write Bit    S = Sign Bit      KS = Kick Start
 *
 *   The addresses are really the offset from the start of the battery-backed
 *   ram base. The DS1646 does not use interrupts in any way.
 *
 */

#include "ds1647.h"

PDS1647BDY m_pDs1647 = (DS1647BDY *)(DS1647_BASE + DS1647_SPEC_OFFSET);

int m_nTimeInitFlag = FALSE;

/**********************************************************************************
	DS1647초기화
***********************************************************************************/
void timeInit()
{
	m_pDs1647->Ctrl.CtrlBit.W = 0;
	m_pDs1647->Ctrl.CtrlBit.R = 0;
		
	m_nTimeInitFlag = TRUE;
}

/**********************************************************************************
	ASCII를 HEX로 바꾼다.
***********************************************************************************/
UCHAR timeAsc2Hex(char Ch)
{
	if((char)Ch >= 'a' && (char)Ch <= 'f') return Ch - 'a' + 10;
	else
		if((char)Ch >= 'A' && (char)Ch <= 'F') return Ch - 'A' + 10;
		else
			if((char)Ch >= '0' && (char)Ch <= '9') return Ch - '0';
			else return 0;
}

/**********************************************************************************
	DS1647를 시작비트를 시작시킨다.
***********************************************************************************/
void timeStart()
{
	if(!m_nTimeInitFlag) timeInit();

	m_pDs1647->Ctrl.CtrlBit.W = 1;	
	m_pDs1647->Second.SecBit.Osc = 0;
	m_pDs1647->Ctrl.CtrlBit.W = 0;
}

/**********************************************************************************
	DS1647에서 시간을 얻어온다.
***********************************************************************************/
int timeGet(DATE_TIME_PTR pTmSt)
{
	m_pDs1647->Ctrl.CtrlBit.R = 1;	

	pTmSt->second = m_pDs1647->Second.B8 & 0x7F;
	pTmSt->minute = m_pDs1647->Minute.B8 & 0xff;
	pTmSt->hour =  m_pDs1647->Hour.B8 & 0xff;
	pTmSt->day =   m_pDs1647->Date.B8 & 0xff;
	pTmSt->month=  m_pDs1647->Month.B8 & 0xff;
	pTmSt->year =  m_pDs1647->Year.B8 & 0xff;
	pTmSt->weekday = m_pDs1647->Day.B8 & 0xff;

	m_pDs1647->Ctrl.CtrlBit.R = 0;
	
	return TRUE;
}

/**********************************************************************************
	시간을 설정한다.
	Type => timeSet("MTDDYYHHMN");
***********************************************************************************/
int timeSet(char *pTmDat)
{
	if(!strlen(pTmDat) || strlen(pTmDat) > 10)
	{
		return FALSE;
	}
	
	m_pDs1647->Ctrl.CtrlBit.W = 1;	

	m_pDs1647->Month.B8 = timeAsc2Hex(pTmDat[0])<<4 | timeAsc2Hex(pTmDat[1]);
	m_pDs1647->Date.B8 = timeAsc2Hex(pTmDat[2])<<4 | timeAsc2Hex(pTmDat[3]);
	m_pDs1647->Year.B8 = timeAsc2Hex(pTmDat[4])<<4 | timeAsc2Hex(pTmDat[5]);
	m_pDs1647->Hour.B8 = timeAsc2Hex(pTmDat[6])<<4 | timeAsc2Hex(pTmDat[7]);
	m_pDs1647->Minute.B8 = timeAsc2Hex(pTmDat[8])<<4 | timeAsc2Hex(pTmDat[9]);
	
	m_pDs1647->Ctrl.CtrlBit.W = 0;
	
	return TRUE;
}

/**********************************************************************************
	시간을 설정한다.
***********************************************************************************/
int timeStSet(DATE_TIME_TYPE dtDat)
{
	m_pDs1647->Ctrl.CtrlBit.W = 1;	

	m_pDs1647->Second.B8 = (m_pDs1647->Second.B8&0x80) | (dtDat.second & 0x7F);
	m_pDs1647->Minute.B8 = dtDat.minute;
	m_pDs1647->Hour.B8 = dtDat.hour;
	m_pDs1647->Date.B8 = dtDat.day;
	m_pDs1647->Month.B8 = dtDat.month;
	m_pDs1647->Year.B8 = dtDat.year;
	
	m_pDs1647->Ctrl.CtrlBit.W = 0;
	
	return TRUE;
}