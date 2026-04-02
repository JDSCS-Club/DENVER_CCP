#include "def.h"
#include "user.h"
#include "xr16l784.h"

UCHAR *m_ucXr16l784TxBuf1 = (UCHAR *)NVSRAM_UARTMONFIFO_BASE;
//UCHAR *m_ucXr16l784TxBuf1[XR16L784_TXBUF_1CH_MAX];
//UCHAR m_ucXr16l784TxBuf1Temp[XR16L784_BUF_1CH_MAX];
UCHAR m_ucXr16l784RxBuf1[XR16L784_RXBUF_1CH_MAX];
int m_nXr16l784TxLen1 = 0;
int m_nXr16l784TxLen1Temp = 0;
int m_nXr16l784TxPos1 = 0;
int m_nXr16l784TxRear1 = 1;
int m_nXr16l784TxFront1 = 0;
int m_nXr16l784RxLen1 = 0;
int m_nXr16l784RxRear1 = 1;
int m_nXr16l784RxFront1 = 0;
int m_nXr16l784TxEnableDly1 = 0;
int m_nXr16l784TxStartEnableDly1 = 0;

UCHAR m_ucXr16l784TxBuf2[XR16L784_BUF_2CH_MAX];
UCHAR m_ucXr16l784TxBuf2Temp[XR16L784_BUF_2CH_MAX];
UCHAR m_ucXr16l784RxBuf2[XR16L784_BUF_2CH_MAX];
int m_nXr16l784TxLen2 = 0;
int m_nXr16l784TxLen2Temp = 0;
int m_nXr16l784TxPos2 = 0;
int m_nXr16l784TxRear2 = 1;
int m_nXr16l784TxFront2 = 0;
int m_nXr16l784RxLen2 = 0;
int m_nXr16l784RxRear2 = 1;
int m_nXr16l784RxFront2 = 0;
int m_nXr16l784TxEnableDly2 = 0;
int m_nXr16l784TxStartEnableDly2 = 0;

UCHAR m_ucXr16l784TxBuf3[XR16L784_BUF_3CH_MAX];
UCHAR m_ucXr16l784TxBuf3Temp[XR16L784_BUF_3CH_MAX];
UCHAR m_ucXr16l784RxBuf3[XR16L784_BUF_3CH_MAX];
int m_nXr16l784TxLen3 = 0;
int m_nXr16l784TxLen3Temp = 0;
int m_nXr16l784TxPos3 = 0;
int m_nXr16l784TxRear3 = 1;
int m_nXr16l784TxFront3 = 0;
int m_nXr16l784RxLen3 = 0;
int m_nXr16l784RxRear3 = 1;
int m_nXr16l784RxFront3 = 0;
int m_nXr16l784TxEnableDly3 = 0;
int m_nXr16l784TxStartEnableDly3 = 0;

UCHAR m_ucXr16l784TxBuf4[XR16L784_BUF_4CH_MAX];
UCHAR m_ucXr16l784TxBuf4Temp[XR16L784_BUF_4CH_MAX];
UCHAR m_ucXr16l784RxBuf4[XR16L784_BUF_4CH_MAX];
int m_nXr16l784TxLen4 = 0;
int m_nXr16l784TxLen4Temp = 0;
int m_nXr16l784TxPos4 = 0;
int m_nXr16l784TxRear4 = 1;
int m_nXr16l784TxFront4 = 0;
int m_nXr16l784RxLen4 = 0;
int m_nXr16l784RxRear4 = 1;
int m_nXr16l784RxFront4 = 0;
int m_nXr16l784TxEnableDly4 = 0;
int m_nXr16l784TxStartEnableDly4 = 0;

PXR16L784BDY pXr16Reg = (XR16L784BDY *)XR16L784_BASE;

//**********************************************************************************
//	XR16L784 珥덇린???⑥닔
// 
//**********************************************************************************
void xr16l784_Init(int nChl,int nBps,int nDataBit,int nParityBit,int nStopBit)
{
	USHORT nBpsBuf = XR16L784_EXCLK/16/nBps;
	
	pXr16Reg->xr16Reg[nChl].btLcr = 0x83; // Divisor Latch Bit Set : DLAB = 1
	pXr16Reg->xr16Reg[nChl].CREG2.btDlm = WORD_H(nBpsBuf);	// Ex MHz / 16 / bps
	pXr16Reg->xr16Reg[nChl].CREG1.btDll = WORD_L(nBpsBuf);
	pXr16Reg->xr16Reg[nChl].btLcr = (nDataBit&0x03) | (nParityBit&0x38) | (nStopBit&0x04); // Divisor Latch Bit Clear (Data:8bit, 1Stop, Even Parity)
	pXr16Reg->xr16Reg[nChl].CREG3.btFcr = 0x0;
	pXr16Reg->xr16Reg[nChl].CREG2.btIer = 3;	// RX,Line INT : enable, TXD : enable
}

//**********************************************************************************
//	XR16L784 RTS ?쒖뼱 ?⑥닔
// 
//**********************************************************************************
void xr16l784_Rts(int nChl,BOOL nHl)
{
	UCHAR nBuf = 0x00;

	nBuf = pXr16Reg->xr16Reg[nChl].btMcr&0xfd;
	
	nBuf |= nHl == XR16L784_RTS_H ? 0x00 : 0x02;
	pXr16Reg->xr16Reg[nChl].btMcr = nBuf;
}

//**********************************************************************************
//	XR16L784 ?곗씠???꾩넚 ?⑥닔
// 
//**********************************************************************************
void xr16l784_RtsDelayStartSend(int nChl,UCHAR *pBuf,int nLen,int nTxStartEnableDly)
{
	switch(nChl)
	{
	case XR16L784_1CHL:
		//m_nXr16l784TxPos1 = 0;
		//m_nXr16l784TxLen1Temp = nLen;
		//memcpy(m_ucXr16l784TxBuf1Temp,pBuf,nLen);
		//m_nXr16l784TxStartEnableDly1 = nTxStartEnableDly;
		//XR16L784_TXEN(XR16L784_1CHL);
		break;
	case XR16L784_2CHL:
		//m_nXr16l784TxPos2 = 0;
		m_nXr16l784TxLen2Temp = nLen;
		memcpy(m_ucXr16l784TxBuf2Temp,pBuf,nLen);
		m_nXr16l784TxStartEnableDly2 = nTxStartEnableDly;
		//XR16L784_TXEN(XR16L784_2CHL);
		break;
	case XR16L784_3CHL:
		//m_nXr16l784TxPos3 = 0;
		m_nXr16l784TxLen3Temp = nLen;
		memcpy(m_ucXr16l784TxBuf3Temp,pBuf,nLen);
		m_nXr16l784TxStartEnableDly3 = nTxStartEnableDly;
		//XR16L784_TXEN(XR16L784_3CHL);
		break;
	case XR16L784_4CHL:
		//m_nXr16l784TxPos4 = 0;
		m_nXr16l784TxLen4Temp = nLen;
		memcpy(m_ucXr16l784TxBuf4Temp,pBuf,nLen);
		m_nXr16l784TxStartEnableDly4 = nTxStartEnableDly;
		//XR16L784_TXEN(XR16L784_4CHL);
		break;
	}
}

//**********************************************************************************
//	XR16L784 ?곗씠???꾩넚 ?⑥닔
// 
//**********************************************************************************
void xr16l784_Send(int nChl,UCHAR *pTxBuf,int nLen)
{
	int i;
	int k;

	if(!nLen) return;
		
	switch(nChl)
	{
	case XR16L784_1CHL:
		nLen = MIN(XR16L784_TXBUF_1CH_MAX,nLen);

		if(((m_nXr16l784TxFront1 + 1) % XR16L784_TXBUF_1CH_MAX) == m_nXr16l784TxRear1) 
		{	
			pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;
			nLen--;
		}
		
		for(k=0;k<nLen;k++)
		{
			i = (m_nXr16l784TxRear1 + 1) % XR16L784_TXBUF_1CH_MAX;
			if(m_nXr16l784TxFront1 != i)
			{
				m_ucXr16l784TxBuf1[m_nXr16l784TxRear1] = *pTxBuf++;
				m_nXr16l784TxRear1 = i;
			}
		}		
		break;
		
	case XR16L784_2CHL:
		nLen = MIN(XR16L784_BUF_2CH_MAX,nLen);

		if(((m_nXr16l784TxFront2 + 1) % XR16L784_BUF_2CH_MAX) == m_nXr16l784TxRear2) 
		{	
			pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;
			nLen--;
		}
		
		for(k=0;k<nLen;k++)
		{
			i = (m_nXr16l784TxRear2 + 1) % XR16L784_BUF_2CH_MAX;
			if(m_nXr16l784TxFront2 != i)
			{
				m_ucXr16l784TxBuf2[m_nXr16l784TxRear2] = *pTxBuf++;
				m_nXr16l784TxRear2 = i;
			}
		}		
		break;
	case XR16L784_3CHL:
		nLen = MIN(XR16L784_BUF_3CH_MAX,nLen);

		if(((m_nXr16l784TxFront3 + 1) % XR16L784_BUF_3CH_MAX) == m_nXr16l784TxRear3) 
		{	
			pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;
			nLen--;
		}
		
		for(k=0;k<nLen;k++)
		{
			i = (m_nXr16l784TxRear3 + 1) % XR16L784_BUF_3CH_MAX;
			if(m_nXr16l784TxFront3 != i)
			{
				m_ucXr16l784TxBuf3[m_nXr16l784TxRear3] = *pTxBuf++;
				m_nXr16l784TxRear3 = i;
			}
		}		
		break;
	case XR16L784_4CHL:
		nLen = MIN(XR16L784_BUF_4CH_MAX,nLen);

		if(((m_nXr16l784TxFront4 + 1) % XR16L784_BUF_4CH_MAX) == m_nXr16l784TxRear4) 
		{	
			pXr16Reg->xr16Reg[nChl].CREG1.btTxd = *pTxBuf++;
			nLen--;
		}
		
		for(k=0;k<nLen;k++)
		{
			i = (m_nXr16l784TxRear4 + 1) % XR16L784_BUF_4CH_MAX;
			if(m_nXr16l784TxFront4 != i)
			{
				m_ucXr16l784TxBuf4[m_nXr16l784TxRear4] = *pTxBuf++;
				m_nXr16l784TxRear4 = i;
			}
		}		
		break;
	}
}

//**********************************************************************************
//	XR16L784??RX踰꾪띁??由ы꽩 ?⑥닔
//	1) nChl : 체널
//	2) pRxBuf : 수신받을 버퍼
//	3) nRxLen : 수신버퍼 크기
//**********************************************************************************
int xr16l784_GetRxBuffer(int nChl,UCHAR *pBuf,int nRxBuffLen)
{
	int i;
	int *pRr = NULL;
	int *pFr = NULL;
	UCHAR *pRxBuf = NULL;
	int nBufPos;
	int nBufMax = 0;
	
	switch(nChl)
	{
	case XR16L784_1CHL:
		nBufMax = XR16L784_RXBUF_1CH_MAX;
		pRr = &m_nXr16l784RxRear1;
		pFr = &m_nXr16l784RxFront1;
		pRxBuf = m_ucXr16l784RxBuf1;
		break;
	case XR16L784_2CHL:
		nBufMax = XR16L784_BUF_2CH_MAX;
		pRr = &m_nXr16l784RxRear2;
		pFr = &m_nXr16l784RxFront2;
		pRxBuf = m_ucXr16l784RxBuf2;
		break;
	case XR16L784_3CHL:
		nBufMax = XR16L784_BUF_3CH_MAX;
		pRr = &m_nXr16l784RxRear3;
		pFr = &m_nXr16l784RxFront3;
		pRxBuf = m_ucXr16l784RxBuf3;
		break;
	case XR16L784_4CHL:
		nBufMax = XR16L784_BUF_4CH_MAX;
		pRr = &m_nXr16l784RxRear4;
		pFr = &m_nXr16l784RxFront4;
		pRxBuf = m_ucXr16l784RxBuf4;
		break;
	default:
		return 0;
	}	

	nBufPos = 0;
	while(1)
	{
		i = (*pFr+1)%nBufMax;
		if(i != *pRr) {pBuf[nBufPos++] = pRxBuf[i]; if(nBufPos >= nRxBuffLen) break;} else break;
		*pFr = i;
	}
	return nBufPos;
}

int xr16l784_GetRxBuffer1Ch(UCHAR *pBuf,int nRxBuffLen)
{
	int i;
	int nBufPos;

	nBufPos = 0;
	while(1)
	{
		i = (m_nXr16l784RxFront1+1)%XR16L784_RXBUF_1CH_MAX;
		if(i != m_nXr16l784RxRear1) {if(nBufPos >= nRxBuffLen) break; pBuf[nBufPos++] = m_ucXr16l784RxBuf1[i]; } else break;
		m_nXr16l784RxFront1 = i;
	}
	return nBufPos;
}

int xr16l784_GetRxBuffer2Ch(UCHAR *pBuf,int nRxBuffLen)
{
	int i;
	int nBufPos;

	nBufPos = 0;
	while(1)
	{
		i = (m_nXr16l784RxFront2+1)%XR16L784_BUF_2CH_MAX;
		if(i != m_nXr16l784RxRear2) {if(nBufPos >= nRxBuffLen) break; pBuf[nBufPos++] = m_ucXr16l784RxBuf2[i]; } else break;
		m_nXr16l784RxFront2 = i;
	}
	return nBufPos;
}

int xr16l784_GetRxBuffer3Ch(UCHAR *pBuf,int nRxBuffLen)
{
	int i;
	int nBufPos;

	nBufPos = 0;
	while(1)
	{
		i = (m_nXr16l784RxFront3+1)%XR16L784_BUF_3CH_MAX;
		if(i != m_nXr16l784RxRear3) {if(nBufPos >= nRxBuffLen) break; pBuf[nBufPos++] = m_ucXr16l784RxBuf3[i]; } else break;
		m_nXr16l784RxFront3 = i;
	}
	return nBufPos;
}

int xr16l784_GetRxBuffer4Ch(UCHAR *pBuf,int nRxBuffLen)
{
	int i;
	int nBufPos;

	nBufPos = 0;
	while(1)
	{
		i = (m_nXr16l784RxFront4+1)%XR16L784_BUF_4CH_MAX;
		if(i != m_nXr16l784RxRear4) {if(nBufPos >= nRxBuffLen) break; pBuf[nBufPos++] = m_ucXr16l784RxBuf4[i]; } else break;
		m_nXr16l784RxFront4 = i;
	}
	return nBufPos;
}


//**********************************************************************************
//	XR16L784 ?명꽣?쏀듃 ?⑥닔
// 
//**********************************************************************************
void xr16l784_Isr()
{
	int i;
	UCHAR nSt = 0;
	UCHAR nRxd = 0;
	
	// -- 1 Channel --
	nSt = pXr16Reg->xr16Reg[XR16L784_1CHL].CREG3.btIir;

	// TX
	if(nSt&0x02)
	{
		i = (m_nXr16l784TxFront1+1) % XR16L784_TXBUF_1CH_MAX;
		if(i != m_nXr16l784TxRear1)
		{
			pXr16Reg->xr16Reg[XR16L784_1CHL].CREG1.btTxd = m_ucXr16l784TxBuf1[i];
			m_nXr16l784TxFront1 = i;
		}
		else
		{
			m_nXr16l784TxEnableDly1 = XR16L784_TXENABLEDLYCNT;
		}		
	}
	// RX
	if(nSt&0x04)
	{
		if(!(pXr16Reg->xr16Reg[XR16L784_1CHL].btLsr & 0x0c))
		{
			nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_1CHL].CREG1.btRxd);
			i = (m_nXr16l784RxRear1+1)%XR16L784_RXBUF_1CH_MAX;
			if(m_nXr16l784RxFront1 != i)
			{
				m_ucXr16l784RxBuf1[m_nXr16l784RxRear1] = nRxd;
				m_nXr16l784RxRear1 = (m_nXr16l784RxRear1+1)%XR16L784_RXBUF_1CH_MAX;	
			}
		}
	}

	// -- 2 Channel --
	nSt = pXr16Reg->xr16Reg[XR16L784_2CHL].CREG3.btIir;
	// TX
	if(nSt&0x02)
	{
		i = (m_nXr16l784TxFront2+1) % XR16L784_BUF_2CH_MAX;
		if(i != m_nXr16l784TxRear2)
		{
			pXr16Reg->xr16Reg[XR16L784_2CHL].CREG1.btTxd = m_ucXr16l784TxBuf2[i];
			m_nXr16l784TxFront2 = i;
		}
		else
		{
			m_nXr16l784TxEnableDly2 = XR16L784_TXENABLEDLYCNT;
		}		
	}
	// RX
	if(nSt&0x04)
	{
		if(!(pXr16Reg->xr16Reg[XR16L784_2CHL].btLsr & 0x0c))
		{
			nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_2CHL].CREG1.btRxd);
			i = (m_nXr16l784RxRear2+1)%XR16L784_BUF_2CH_MAX;
			if(m_nXr16l784RxFront2 != i)
			{
				m_ucXr16l784RxBuf2[m_nXr16l784RxRear2] = nRxd;
				m_nXr16l784RxRear2 = (m_nXr16l784RxRear2+1)%XR16L784_BUF_2CH_MAX;	
			}
		}
	}

	// -- 3 Channel --
	nSt = pXr16Reg->xr16Reg[XR16L784_3CHL].CREG3.btIir;
	// TX
	if(nSt&0x02)
	{
		i = (m_nXr16l784TxFront3+1) % XR16L784_BUF_3CH_MAX;
		if(i != m_nXr16l784TxRear3)
		{
			pXr16Reg->xr16Reg[XR16L784_3CHL].CREG1.btTxd = m_ucXr16l784TxBuf3[i];
			m_nXr16l784TxFront3 = i;
		}
		else
		{
			m_nXr16l784TxEnableDly3 = XR16L784_TXENABLEDLYCNT;
		}		
	}
	// RX
	if(nSt&0x04)
	{
		if(!(pXr16Reg->xr16Reg[XR16L784_3CHL].btLsr & 0x0c))
		{
			nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_3CHL].CREG1.btRxd);
			i = (m_nXr16l784RxRear3+1)%XR16L784_BUF_3CH_MAX;
			if(m_nXr16l784RxFront3 != i)
			{
				m_ucXr16l784RxBuf3[m_nXr16l784RxRear3] = nRxd;
				m_nXr16l784RxRear3 = (m_nXr16l784RxRear3+1)%XR16L784_BUF_3CH_MAX;	
			}
		}
	}

	// -- 4 Channel --
	nSt = pXr16Reg->xr16Reg[XR16L784_4CHL].CREG3.btIir;
	// TX
	if(nSt&0x02)
	{
		i = (m_nXr16l784TxFront4+1) % XR16L784_BUF_4CH_MAX;
		if(i != m_nXr16l784TxRear4)
		{
			pXr16Reg->xr16Reg[XR16L784_4CHL].CREG1.btTxd = m_ucXr16l784TxBuf4[i];
			m_nXr16l784TxFront4 = i;
		}
		else
		{
			m_nXr16l784TxEnableDly4 = XR16L784_TXENABLEDLYCNT;
		}		
	}
	// RX
	if(nSt&0x04)
	{
		if(!(pXr16Reg->xr16Reg[XR16L784_4CHL].btLsr & 0x0c))
		{
			nRxd = WORD_L(pXr16Reg->xr16Reg[XR16L784_4CHL].CREG1.btRxd);
			i = (m_nXr16l784RxRear4+1)%XR16L784_BUF_4CH_MAX;
			if(m_nXr16l784RxFront4 != i)
			{
				m_ucXr16l784RxBuf4[m_nXr16l784RxRear4] = nRxd;
				m_nXr16l784RxRear4 = (m_nXr16l784RxRear4+1)%XR16L784_BUF_4CH_MAX;	
			}
		}
	}
}

//**********************************************************************************
//	XR16L784 硫붿씤 猷⑦봽 ?⑥닔
// 
//**********************************************************************************
void xr16l784_Loop()
{
}

//**********************************************************************************
//	XR16L784 1ms 猷⑦봽 ?⑥닔
// 
//**********************************************************************************
void xr16l784_1msLoop()
{
	// Send TX delay enable 
	//if(m_nXr16l784TxStartEnableDly1 == 1) xr16l784_Send(XR16L784_1CHL,m_ucXr16l784TxBuf1Temp,m_nXr16l784TxLen1Temp);
	//if(m_nXr16l784TxStartEnableDly1) m_nXr16l784TxStartEnableDly1--;
	if(m_nXr16l784TxStartEnableDly2) m_nXr16l784TxStartEnableDly2--;
	if(m_nXr16l784TxStartEnableDly2 == 1)
	{
		XR16L784_TXEN(XR16L784_2CHL);
		xr16l784_Send(XR16L784_2CHL,m_ucXr16l784TxBuf2Temp,m_nXr16l784TxLen2Temp);
	}

	if(m_nXr16l784TxStartEnableDly3) m_nXr16l784TxStartEnableDly3--;
	if(m_nXr16l784TxStartEnableDly3 == 1) 
	{
		XR16L784_TXEN(XR16L784_3CHL);
		xr16l784_Send(XR16L784_3CHL,m_ucXr16l784TxBuf3Temp,m_nXr16l784TxLen3Temp);
	}
	
	if(m_nXr16l784TxStartEnableDly4) m_nXr16l784TxStartEnableDly4--;
	if(m_nXr16l784TxStartEnableDly4 == 1)
	{
		XR16L784_TXEN(XR16L784_4CHL);
		xr16l784_Send(XR16L784_4CHL,m_ucXr16l784TxBuf4Temp,m_nXr16l784TxLen4Temp);
	}
	

	// TX Delay Disable
	if(m_nXr16l784TxEnableDly1 == 1) XR16L784_TXDIS(XR16L784_1CHL);
	if(m_nXr16l784TxEnableDly1) m_nXr16l784TxEnableDly1--;
	if(m_nXr16l784TxEnableDly2 == 1) XR16L784_TXDIS(XR16L784_2CHL);
	if(m_nXr16l784TxEnableDly2) m_nXr16l784TxEnableDly2--;
	if(m_nXr16l784TxEnableDly3 == 1) XR16L784_TXDIS(XR16L784_3CHL);
	if(m_nXr16l784TxEnableDly3) m_nXr16l784TxEnableDly3--;
	if(m_nXr16l784TxEnableDly4 == 1) XR16L784_TXDIS(XR16L784_4CHL);
	if(m_nXr16l784TxEnableDly4) m_nXr16l784TxEnableDly4--;
}

