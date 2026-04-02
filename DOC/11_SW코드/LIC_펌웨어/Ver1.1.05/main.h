#include "def.h"
#include "ds1647.h"

#ifndef _MAIN_H_
#define _MAIN_H_


void c_int02(void);
void c_int03(void);
void c_int10(void);
void DspInit(void);

int ConvDec2Hex(char nCh);
BOOL IsNumAsc(char nCh);
int ConvAsc2Dec(char nCh);
char ConvHex2Asc(UCHAR btCh);
UCHAR ConvAsc2Hex(char chDat);
void Dec2Str(char *pBuf,int nDat);
void StrCat(char *dest, const char *src);
int StrLen(const char *string);
void StrCpy(char *dest, const char *src);
int StrCmp(const char *string1, const char *string2);
BOOL FirmwareVersionStrCmp(char *pObj,char *pSrc,int nLen);
int GetFirmwareVersion(UCHAR nVerBuildData);
void PortOut(int nKind,BOOL nHl);
UCHAR Make1ByteBcc(UCHAR *pDat,int nLen);
void MakeBcc(UCHAR *pDat,int nLen);
int IsBccOk(UCHAR *pDat,int nLen);
int Delay(int nCnt);
BOOL gm_SysTimeToRtc(DATE_TIME_PTR pTime,UINT nSysTime);
void MyPrintf(char * format, ... );

int FunConvAscHex(char *InchData,UCHAR *OuthexData,int Len);
int FunConvHexAsc(UCHAR *InhexData,char *OUTAscData,int Len);

WORD crc16_ccitt(UCHAR *buf, int len);

void MyPrintf_TxAuto(UCHAR *format,int nLen );


#endif