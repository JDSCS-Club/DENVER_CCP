#ifndef _LonInfo_H_
#define _LonInfo_H_


void LonWorkLoop();
void LonWorkRead();
UCHAR LonWorkRx(int nRxPos, UCHAR *pRxBuf);
void LonWorkTx(UCHAR *pTxBuf,UCHAR nLen);
void LonInfo_1msLoop();


#endif