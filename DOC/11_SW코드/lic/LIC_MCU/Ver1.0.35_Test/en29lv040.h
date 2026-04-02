#include "def.h"


#ifndef _EN29LV040_H_
#define _EN29LV040_H_

#define EN29LV040_BASE 0x400000
#define EN29LV040_SIZE 0x80000

/***********************************************************************************
	Function
************************************************************************************/
void en29_Init();
void en29_AllErase();
void en29_WriteByte(UINT nAddr,UCHAR nDat);
void en29_SectorErase(UINT nAddr);
UCHAR en29_ReadByte(UINT nAddr);

#endif