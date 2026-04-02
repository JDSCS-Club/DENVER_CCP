#include "def.h"

#ifndef _DS1647_H_
#define _DS1647_H_

#define DS1647_BASE 0xC00000
#define DS1647_SPEC_OFFSET 0x7FFF8

typedef union
{
	struct
	{
		int   : 6; // LSB Bit
		int R : 1;
		int W : 1; // MSB Bit
	} CtrlBit;
	
	struct
	{
		int Sec : 7;
		int Osc : 1;
	} SecBit;
	
	struct
	{
		int Day : 3;
		int SPare2 : 3;
		int FT : 1;
		int Spare1 : 1;
	} DayBit;
	
	UCHAR B8;
} DS1647ONELTP, *PDS1647ONELTP;

typedef struct
{
	DS1647ONELTP Ctrl;
	DS1647ONELTP Second;
	DS1647ONELTP Minute;
	DS1647ONELTP Hour;
	DS1647ONELTP Day;
	DS1647ONELTP Date;
	DS1647ONELTP Month;
	DS1647ONELTP Year;
} DS1647BDY, *PDS1647BDY;

typedef struct
{
	UCHAR second;
	UCHAR minute;
	UCHAR hour;
	UCHAR day;
	UCHAR month;
	UCHAR year;
	UCHAR weekday;
} DATE_TIME_TYPE, *DATE_TIME_PTR;

void timeInit();
UCHAR timeAsc2Hex(char Ch);
void timeStart();
int timeGet(DATE_TIME_PTR pTmSt);
int timeSet(char *pTmDat);
int timeStSet(DATE_TIME_TYPE dtDat);

#endif