#pragma once

#define	MAKE_BYTE(a)						(a & 0x0F )

#define	BYTE_SPLIT(a, b, c)					a =( (c & 0xF0) >> 4) + 0x30; b = (c & 0x0F) + 0x30; 
#define	SHORT_SPLIT(a, b, c, d, e)			a =( (e & 0xF000) >> 12) + 0x30; b =( (e & 0xF00) >>8) + 0x30; c =( (e & 0xF0) >>4) + 0x30; d =( (e & 0xF) ) + 0x30;

#define	DEC_FROM_BCD2(a, b )				( (a & 0x0F) * 10 + (b & 0x0F) ) 
#define	DEC_FROM_BCD4(a, b, c, d )			( (a & 0x0F) * 1000 + (b & 0x0F) * 100 + (c & 0x0F) * 10 + (d & 0x0F) ) 
#define	DEC_FROM_BCD6(a, b, c, d, e, f )	( (a & 0x0F) * 100000 + (b & 0x0F) * 10000 + (c & 0x0F) * 1000 + (d & 0x0F) * 100 + (e & 0x0F) * 10 + (f & 0x0F) ) 
#define	DEC_FROM_BCD8(a, b, c, d, e, f, g, h )	( (a & 0x0F) * 10000000 + (b & 0x0F) * 1000000 + (c & 0x0F) * 100000 + (d & 0x0F) * 10000 + (e & 0x0F) * 1000 + (f & 0x0F) * 100 + (g & 0x0F) * 10 + (h & 0x0F) ) 

#define	SIZE_HEADER				(12)
#define	SIZE_PAC_CARINFO		(22)

#define	SIZE_CSCNS_HEADER		(12)

// CAR DATA BYTE 1
#define MASK_CABA		0x01
#define MASK_HEADA		0x08
#define MASK_CABB		0x10
#define MASK_HEADB		0x80
#define	CHECK_CABA(a)		( (a[0] & MASK_CABA	) == MASK_CABA	 ? true : false)
#define	CHECK_HEADA(a)		( (a[0] & MASK_HEADA) == MASK_HEADA	? true : false)
#define	CHECK_CABB(a)		( (a[0] & MASK_CABB	) == MASK_CABB	 ? true : false)
#define	CHECK_HEADB(a)		( (a[0] & MASK_HEADB) == MASK_HEADB	? true : false)

// CAR DATA BYTE 2
#define MASK_WLRA		0x01
#define MASK_GPSA		0x02
#define MASK_VOIPCA		0x04
#define MASK_CCPA		0x08
#define MASK_WLRB		0x10
#define MASK_GPSB		0x20
#define MASK_VOIPCB		0x40
#define MASK_CCPB		0x80
#define	CHECK_WLRA(a)		( (a[1] & MASK_WLRA	) == MASK_WLRA	? true : false)
#define	CHECK_GPSA(a)		( (a[1] & MASK_GPSA	) == MASK_GPSA	? true : false)
#define	CHECK_VOPICA(a)		( (a[1] & MASK_VOIPCA	) == MASK_VOIPCA	? true : false)
#define	CHECK_CCPA(a)		( (a[1] & MASK_CCPA	) == MASK_CCPA	? true : false)
#define	CHECK_WLRB(a)		( (a[1] & MASK_WLRB	) == MASK_WLRB	? true : false)
#define	CHECK_GPSB(a)		( (a[1] & MASK_GPSB	) == MASK_GPSB	? true : false)
#define	CHECK_VOPICB(a)		( (a[1] & MASK_VOIPCB	) == MASK_VOIPCB	? true : false)
#define	CHECK_CCPB(a)		( (a[1] & MASK_CCPB	) == MASK_CCPB	? true : false)

// CAR DATA BYTE 3
#define MASK_CNCSA		0x01
#define MASK_VTXA		0x02
#define MASK_LICA		0x04
#define MASK_PACA		0x08
#define MASK_CNCSB		0x10
#define MASK_VTXB		0x20
#define MASK_LICB		0x40
#define MASK_PACB		0x80
#define	CHECK_CNCSA(a)		( (a[2] & MASK_CNCSA	) == MASK_CNCSA	? true : false)
#define	CHECK_VTXA(a)		( (a[2] & MASK_VTXA	) == MASK_VTXA	? true : false)
#define	CHECK_LICA(a)		( (a[2] & MASK_LICA	) == MASK_LICA	? true : false)
#define	CHECK_PACA(a)		( (a[2] & MASK_PACA	) == MASK_PACA	? true : false)
#define	CHECK_CNCSB(a)		( (a[2] & MASK_CNCSB	) == MASK_CNCSB	? true : false)
#define	CHECK_VTXB(a)		( (a[2] & MASK_VTXB	) == MASK_VTXB	? true : false)
#define	CHECK_LICB(a)		( (a[2] & MASK_LICB	) == MASK_LICB	? true : false)
#define	CHECK_PACB(a)		( (a[2] & MASK_PACB	) == MASK_PACB	? true : false)

#define	CHECK_CRA1(a)		( ( (a[1] & 0x0F) || (a[2] & 0x0F) ) ? true : false)
#define	CHECK_CRA2(a)		( ( (a[1] & 0xF0) || (a[2] & 0xF0) ) ? true : false)

// CAR DATA BYTE 4
#define MASK_PII2A		0x01
#define MASK_PII1A		0x02
#define MASK_FDIA		0x04
#define MASK_PII2B		0x10
#define MASK_PII1B		0x20
#define MASK_FDIB		0x40
#define	CHECK_PII2A(a)		( (a[3] & MASK_PII2A	) == MASK_PII2A	? true : false)
#define	CHECK_PII1A(a)		( (a[3] & MASK_PII1A	) == MASK_PII1A	? true : false)
#define	CHECK_FDIA(a)		( (a[3] & MASK_FDIA		) == MASK_FDIA	? true : false)
#define	CHECK_PII2B(a)		( (a[3] & MASK_PII2B	) == MASK_PII2B	? true : false)
#define	CHECK_PII1B(a)		( (a[3] & MASK_PII1B	) == MASK_PII1B	? true : false)
#define	CHECK_FDIB(a)		( (a[3] & MASK_FDIB		) == MASK_FDIB	? true : false)

// CAR DATA BYTE 5
#define MASK_SDI4A		0x01
#define MASK_SDI3A		0x02
#define MASK_SDI2A		0x04
#define MASK_SDI1A		0x08
#define MASK_SDI4B		0x10
#define MASK_SDI3B		0x20
#define MASK_SDI2B		0x40
#define MASK_SDI1B		0x80
#define	CHECK_SDI4A(a)		( (a[4] & MASK_SDI4A	) == MASK_SDI4A	? true : false)
#define	CHECK_SDI3A(a)		( (a[4] & MASK_SDI3A	) == MASK_SDI3A	? true : false)
#define	CHECK_SDI2A(a)		( (a[4] & MASK_SDI2A	) == MASK_SDI2A	? true : false)
#define	CHECK_SDI1A(a)		( (a[4] & MASK_SDI1A	) == MASK_SDI1A	? true : false)
#define	CHECK_SDI4B(a)		( (a[4] & MASK_SDI4B	) == MASK_SDI4B	? true : false)
#define	CHECK_SDI3B(a)		( (a[4] & MASK_SDI3B	) == MASK_SDI3B	? true : false)
#define	CHECK_SDI2B(a)		( (a[4] & MASK_SDI2B	) == MASK_SDI2B	? true : false)
#define	CHECK_SDI1B(a)		( (a[4] & MASK_SDI1B	) == MASK_SDI1B	? true : false)

// CAR DATA BYTE 6
#define MASK_PID14A		0x01
#define MASK_PID13A		0x02
#define MASK_PID12A		0x04
#define MASK_PID11A		0x08
#define MASK_PID14B		0x10
#define MASK_PID13B		0x20
#define MASK_PID12B		0x40
#define MASK_PID11B		0x80
#define	CHECK_PID14A(a)		( (a[5] & MASK_PID14A	) == MASK_PID14A	? true : false)
#define	CHECK_PID13A(a)		( (a[5] & MASK_PID13A	) == MASK_PID13A	? true : false)
#define	CHECK_PID12A(a)		( (a[5] & MASK_PID12A	) == MASK_PID12A	? true : false)
#define	CHECK_PID11A(a)		( (a[5] & MASK_PID11A	) == MASK_PID11A	? true : false)
#define	CHECK_PID14B(a)		( (a[5] & MASK_PID14B	) == MASK_PID14B	? true : false)
#define	CHECK_PID13B(a)		( (a[5] & MASK_PID13B	) == MASK_PID13B	? true : false)
#define	CHECK_PID12B(a)		( (a[5] & MASK_PID12B	) == MASK_PID12B	? true : false)
#define	CHECK_PID11B(a)		( (a[5] & MASK_PID11B	) == MASK_PID11B	? true : false)


// CAR DATA BYTE 7
#define MASK_PEI1A		0x01
#define MASK_PEI2A		0x02
#define MASK_PID21A		0x08
#define MASK_PEI1B		0x10
#define MASK_PEI2B		0x20
#define MASK_PID21B		0x80
#define	CHECK_PEI1A(a)		( (a[6] & MASK_PEI1A	) == MASK_PEI1A	? true : false)
#define	CHECK_PEI2A(a)		( (a[6] & MASK_PEI2A	) == MASK_PEI2A	? true : false)
#define	CHECK_PID21A(a)		( (a[6] & MASK_PID21A	) == MASK_PID21A	? true : false)
#define	CHECK_PEI1B(a)		( (a[6] & MASK_PEI1B	) == MASK_PEI1B	? true : false)
#define	CHECK_PEI2B(a)		( (a[6] & MASK_PEI2B	) == MASK_PEI2B	? true : false)
#define	CHECK_PID21B(a)		( (a[6] & MASK_PID21B	) == MASK_PID21B	? true : false)

// CAR DATA BYTE 8
#define MASK_PEICALL1A	0x01
#define MASK_PEICALL2A	0x02
#define MASK_PEICALL1B	0x10
#define MASK_PEICALL2B	0x20
#define	CHECK_PEICALL1A(a)		( (a[7] & MASK_PEICALL1A) == MASK_PEICALL1A ? true : false)
#define	CHECK_PEICALL2A(a)		( (a[7] & MASK_PEICALL2A) == MASK_PEICALL2A ? true : false)
#define	CHECK_PEICALL1B(a)		( (a[7] & MASK_PEICALL1B) == MASK_PEICALL1B ? true : false)
#define	CHECK_PEICALL2B(a)		( (a[7] & MASK_PEICALL2B) == MASK_PEICALL2B ? true : false)

// CAR DATA BYTE 9
#define MASK_DPOA	0x01
#define MASK_DPHA	0x08
#define MASK_DPOB	0x10
#define MASK_DPHB	0x80
#define	CHECK_DPOA(a)		( (a[8] & MASK_DPOA) == MASK_DPOA ? true : false)
#define	CHECK_DPHA(a)		( (a[8] & MASK_DPHA) == MASK_DPHA ? true : false)
#define	CHECK_DPOB(a)		( (a[8] & MASK_DPOB) == MASK_DPOB ? true : false)
#define	CHECK_DPHB(a)		( (a[8] & MASK_DPHB) == MASK_DPHB ? true : false)

#define CHECK_PEI_MARRIEDA(a)	( ( CHECK_PEICALL1A(a) || CHECK_PEICALL2A(a) ) ? true  : false )
#define CHECK_PEI_MARRIEDB(a)	( ( CHECK_PEICALL1B(a) || CHECK_PEICALL2B(a) ) ? true  : false )

/*
// CAR DATA BYTE 1
#define MASK_VTX1		0x01
#define MASK_CNCS1		0x02
#define MASK_PAC1		0x04
#define MASK_LIC1		0x08
#define MASK_WLR1		0x10
#define MASK_GPS1		0x20
#define MASK_PAC2		0x40
#define MASK_HEADER		0x80

#define	CHECK_VTX1(a)		( (a[0] & MASK_VTX1	) == MASK_VTX1	? true : false)
#define	CHECK_CNCS1(a)		( (a[0] & MASK_CNCS1) == MASK_CNCS1	? true : false)
#define	CHECK_PAC1(a)		( (a[0] & MASK_PAC1) == MASK_PAC1	? true : false)
#define	CHECK_LIC1(a)		( (a[0] & MASK_LIC1	) == MASK_LIC1	? true : false)
#define	CHECK_WLR1(a)		( (a[0] & MASK_WLR1	) == MASK_WLR1	? true : false)
#define	CHECK_GPS1(a)		( (a[0] & MASK_GPS1	) == MASK_GPS1	? true : false)
#define	CHECK_PAC2(a)		( (a[0] & MASK_PAC2) == MASK_PAC2	? true : false)
#define	CHECK_HEADER(a)		( (a[0] & MASK_HEADER) == MASK_HEADER	? true : false)

#define	CHECK_CRA(a)		( (a[0] & 0x3F) ? true : false)


// CAR DATA BYTE 2
#define MASK_DPOA		0x01
#define MASK_DPOB		0x02
#define MASK_CCPA		0x04
#define MASK_CCPB		0x08
#define MASK_VOIPC1		0x10
#define MASK_VOIPC2		0x20
#define MASK_CABA		0x40
#define MASK_CABB		0x80

#define	CHECK_DPOA(a)		( (a[1] & MASK_DPOA	) == MASK_DPOA	 ? true : false)
#define	CHECK_DPOB(a)		( (a[1] & MASK_DPOB	) == MASK_DPOB	 ? true : false)
#define	CHECK_CCPA(a)		( (a[1] & MASK_CCPA	) == MASK_CCPA	 ? true : false)
#define	CHECK_CCPB(a)		( (a[1] & MASK_CCPB	) == MASK_CCPB	 ? true : false)
#define	CHECK_VOIPC1(a)		( (a[1] & MASK_VOIPC1) == MASK_VOIPC1	 ? true : false)
#define	CHECK_VOIPC2(a)		( (a[1] & MASK_VOIPC2) == MASK_VOIPC2	 ? true : false)
#define	CHECK_CABA(a)		( (a[1] & MASK_CABA	) == MASK_CABA	 ? true : false)
#define	CHECK_CABB(a)		( (a[1] & MASK_CABB	) == MASK_CABB	 ? true : false)

// CAR DATA BYTE 3
#define MASK_DPH1		0x01
#define MASK_DPH2		0x02
#define MASK_VTX2		0x04
#define MASK_CNCS2		0x08
#define MASK_LIC2		0x10
#define MASK_WLR2		0x20
#define MASK_GPS2		0x40

#define	CHECK_DPH1(a)		( (a[2] & MASK_DPH1) == MASK_DPH1 ? true : false)
#define	CHECK_DPH2(a)		( (a[2] & MASK_DPH2) == MASK_DPH2 ? true : false)
#define	CHECK_VTX2(a)		( (a[2] & MASK_VTX2) == MASK_VTX2 ? true : false)
#define	CHECK_CNCS2(a)		( (a[2] & MASK_CNCS2) == MASK_CNCS2 ? true : false)
#define	CHECK_LIC2(a)		( (a[2] & MASK_LIC2) == MASK_LIC2 ? true : false)
#define	CHECK_WLR2(a)		( (a[2] & MASK_WLR2) == MASK_WLR2 ? true : false)
#define CHECK_GPS2(a)		( (a[2] & MASK_GPS2) == MASK_GPS2 ? true : false)

#define	CHECK_CRB(a)		( ( (a[0] & MASK_PAC2) == MASK_PAC2	|| ( a[2] & 0x7C ) ) ? true : false)

// CAR DATA BYTE 4
#define MASK_PEI1		0x01
#define MASK_PEI2		0x02
#define MASK_PEI3		0x04
#define MASK_PEI4		0x08
//#define MASK_PEI5		0x20
//#define MASK_PEI6		0x08
#define MASK_FDI1		0x40
#define MASK_FDI2		0x80

#define	CHECK_PEI1(a)		( (a[3] & MASK_PEI1) == MASK_PEI1 ? true : false)
#define	CHECK_PEI2(a)		( (a[3] & MASK_PEI2) == MASK_PEI2 ? true : false)
#define	CHECK_PEI3(a)		( (a[3] & MASK_PEI3) == MASK_PEI3 ? true : false)
#define	CHECK_PEI4(a)		( (a[3] & MASK_PEI4) == MASK_PEI4 ? true : false)
//#define	CHECK_PEI5(a)		( (a[3] & MASK_PEI5) == MASK_PEI5 ? true : false)
//#define	CHECK_PEI6(a)		( (a[3] & MASK_PEI6) == MASK_PEI6 ? true : false)
#define	CHECK_FDI1(a)		( (a[3] & MASK_FDI1) == MASK_FDI1 ? true : false)
#define	CHECK_FDI2(a)		( (a[3] & MASK_FDI2) == MASK_FDI2 ? true : false)

// CAR DATA BYTE 5
#define MASK_PEICALL1	0x01
#define MASK_PEICALL2	0x02
#define MASK_PEICALL3	0x04
#define MASK_PEICALL4	0x08
//#define MASK_PEICALL5	0x20
//#define MASK_PEICALL6	0x08

#define	CHECK_PEICALL1(a)		( (a[4] & MASK_PEICALL1) == MASK_PEICALL1 ? true : false)
#define	CHECK_PEICALL2(a)		( (a[4] & MASK_PEICALL2) == MASK_PEICALL2 ? true : false)
#define	CHECK_PEICALL3(a)		( (a[4] & MASK_PEICALL3) == MASK_PEICALL3 ? true : false)
#define	CHECK_PEICALL4(a)		( (a[4] & MASK_PEICALL4) == MASK_PEICALL4 ? true : false)
//#define	CHECK_PEICALL5(a)		( (a[4] & MASK_PEICALL5) == MASK_PEICALL5 ? true : false)
//#define	CHECK_PEICALL6(a)		( (a[4] & MASK_PEICALL6) == MASK_PEICALL6 ? true : false)

// CAR DATA BYTE 6
#define MASK_SDI1		0x01
#define MASK_SDI2		0x02
#define MASK_SDI3		0x04
#define MASK_SDI4		0x08
#define MASK_SDI5		0x10
#define MASK_SDI6		0x20
#define MASK_SDI7		0x40
#define MASK_SDI8		0x80

#define	CHECK_SDI1(a)		( (a[5] & MASK_SDI1) == MASK_SDI1 ? true : false)
#define	CHECK_SDI2(a)		( (a[5] & MASK_SDI2) == MASK_SDI2 ? true : false)
#define	CHECK_SDI3(a)		( (a[5] & MASK_SDI3) == MASK_SDI3 ? true : false)
#define	CHECK_SDI4(a)		( (a[5] & MASK_SDI4) == MASK_SDI4 ? true : false)
#define	CHECK_SDI5(a)		( (a[5] & MASK_SDI5) == MASK_SDI5 ? true : false)
#define	CHECK_SDI6(a)		( (a[5] & MASK_SDI6) == MASK_SDI6 ? true : false)
#define	CHECK_SDI7(a)		( (a[5] & MASK_SDI7) == MASK_SDI7 ? true : false)
#define	CHECK_SDI8(a)		( (a[5] & MASK_SDI8) == MASK_SDI8 ? true : false)

// CAR DATA BYTE 7
#define MASK_PID11		0x01
#define MASK_PID12		0x02
#define MASK_PID13		0x04
#define MASK_PID14		0x08
#define MASK_PID15		0x10
#define MASK_PID16		0x20
#define MASK_PID17		0x40
#define MASK_PID18		0x80

#define	CHECK_PID11(a)		( (a[6] & MASK_PID11) == MASK_PID11 ? true : false)
#define	CHECK_PID12(a)		( (a[6] & MASK_PID12) == MASK_PID12 ? true : false)
#define	CHECK_PID13(a)		( (a[6] & MASK_PID13) == MASK_PID13 ? true : false)
#define	CHECK_PID14(a)		( (a[6] & MASK_PID14) == MASK_PID14 ? true : false)
#define	CHECK_PID15(a)		( (a[6] & MASK_PID15) == MASK_PID15 ? true : false)
#define	CHECK_PID16(a)		( (a[6] & MASK_PID16) == MASK_PID16 ? true : false)
#define	CHECK_PID17(a)		( (a[6] & MASK_PID17) == MASK_PID17 ? true : false)
#define	CHECK_PID18(a)		( (a[6] & MASK_PID18) == MASK_PID18 ? true : false)

// CAR DATA BYTE 8
#define MASK_PID21		0x01
#define MASK_PID22		0x02
//#define MASK_PID23		0x04
//#define MASK_PID24		0x08
#define MASK_PII1		0x10
#define MASK_PII2		0x20
#define MASK_PII3		0x40
#define MASK_PII4		0x80

#define	CHECK_PID21(a)		( (a[7] & MASK_PID21	) == MASK_PID21	 ? true : false)
#define	CHECK_PID22(a)		( (a[7] & MASK_PID22	) == MASK_PID22	 ? true : false)
//#define	CHECK_PID23(a)		( (a[7] & MASK_PID23	) == MASK_PID23	 ? true : false)
//#define	CHECK_PID24(a)		( (a[7] & MASK_PID24	) == MASK_PID24	 ? true : false)
#define	CHECK_PII1(a)		( (a[7] & MASK_PII1	) == MASK_PII1	 ? true : false)
#define	CHECK_PII2(a)		( (a[7] & MASK_PII2	) == MASK_PII2	 ? true : false)
#define	CHECK_PII3(a)		( (a[7] & MASK_PII3	) == MASK_PII3	 ? true : false)
#define	CHECK_PII4(a)		( (a[7] & MASK_PII4	) == MASK_PII4	 ? true : false)

#define CHECK_PEI_SINGLE(a)		( ( CHECK_PEICALL1(a) || CHECK_PEICALL2(a) ) ? true  : false )
#define CHECK_PEI_MARRIEDA(a)	( ( CHECK_PEICALL1(a) || CHECK_PEICALL2(a) ) ? true  : false )
#define CHECK_PEI_MARRIEDB(a)	( ( CHECK_PEICALL3(a) || CHECK_PEICALL4(a) ) ? true  : false )
*/
// CPacket 명령 대상입니다.

typedef	struct _PAC_DATA
{
	_PAC_DATA()
	{
		memset(TRIP, 0x30, sizeof(BYTE) * 6 );
		memset(SKIP, 0x30, sizeof(BYTE) * 20 );
		memset(CI, 0x00, sizeof(BYTE) * 8 );
		memset(CI_USER, 0x00, sizeof(BYTE) * 8 );
		memset(CI_USER_INPUT, 0x00, sizeof(BYTE) * 8 );
		memset(CI_LIC, 0x00, sizeof(BYTE) * 8 );
	}

	BYTE	PAC_T;
	BYTE	C_ID;
	BYTE	D0;
	BYTE	D1;
	UINT	ODM;
	BYTE	ANS;
	UINT	TRAN_NO;
	UINT	CREW_ID;
	BYTE	TRIP[6];
	BYTE	D2;
	UINT	STST;
	UINT	NOST;
	UINT	NEST;
	UINT	DEST;
	UINT	SPK[2];
	BYTE	D3;
	BYTE	D4;
	BYTE	D5;
	BYTE	PR;
	UINT	PRVCT;
	UINT	CLRVCT;
	UINT	PACVCT;
	UINT	FDIVCT1;
	UINT	FDIVCT2;
	UINT	PIIVCT;
	UINT	PPLVCT;
	UINT	PPVCT;
	UINT	SPVCT;
	BYTE	SKIP[20];
	BYTE	CI[8];
	BYTE	CI_USER[8];
	BYTE	CI_USER_INPUT[8];
	BYTE	CI_FAULT;
	BYTE	CCI;
	BYTE	CAR_POS;
	BYTE	TL_LEN;
	BYTE	CI_LIC[8];
}	PAC_DATA;

typedef	struct _PAC_CARDATA
{
	_PAC_CARDATA()
	{
		memset(DATA, 0x00, sizeof(BYTE) * 9 );

		CARN = 0;
		CI  = 0;
		bErrCI = FALSE;
	}

	BYTE	DATA[9];
	UINT	CARN;
	UINT	CI;
	BOOL	bErrCI;
}	CAR_DATA;

typedef	struct _CNCS_DATA
{
	_CNCS_DATA()
	{
		memset(DATE, 0x30, sizeof(BYTE) * 6 );
	}

	BYTE	CNCS_T;
	BYTE	D0;
	BYTE	D1;
	BYTE	LED_T;
	BYTE	D2;
	BYTE	DATE[6];
	double	LAT;
	double	LOT;
}	CNCS_DATA;

typedef	struct _LIC_DATA
{
	_LIC_DATA()
	{
		D0	= 0x00;
		CARN = 0;
	}

	BYTE	D0;
	UINT	CARN;
}	LIC_DATA;

static const unsigned short crc16tab[256]= {
	0x0000,0x1021,0x2042,0x3063,0x4084,0x50a5,0x60c6,0x70e7,
	0x8108,0x9129,0xa14a,0xb16b,0xc18c,0xd1ad,0xe1ce,0xf1ef,
	0x1231,0x0210,0x3273,0x2252,0x52b5,0x4294,0x72f7,0x62d6,
	0x9339,0x8318,0xb37b,0xa35a,0xd3bd,0xc39c,0xf3ff,0xe3de,
	0x2462,0x3443,0x0420,0x1401,0x64e6,0x74c7,0x44a4,0x5485,
	0xa56a,0xb54b,0x8528,0x9509,0xe5ee,0xf5cf,0xc5ac,0xd58d,
	0x3653,0x2672,0x1611,0x0630,0x76d7,0x66f6,0x5695,0x46b4,
	0xb75b,0xa77a,0x9719,0x8738,0xf7df,0xe7fe,0xd79d,0xc7bc,
	0x48c4,0x58e5,0x6886,0x78a7,0x0840,0x1861,0x2802,0x3823,
	0xc9cc,0xd9ed,0xe98e,0xf9af,0x8948,0x9969,0xa90a,0xb92b,
	0x5af5,0x4ad4,0x7ab7,0x6a96,0x1a71,0x0a50,0x3a33,0x2a12,
	0xdbfd,0xcbdc,0xfbbf,0xeb9e,0x9b79,0x8b58,0xbb3b,0xab1a,
	0x6ca6,0x7c87,0x4ce4,0x5cc5,0x2c22,0x3c03,0x0c60,0x1c41,
	0xedae,0xfd8f,0xcdec,0xddcd,0xad2a,0xbd0b,0x8d68,0x9d49,
	0x7e97,0x6eb6,0x5ed5,0x4ef4,0x3e13,0x2e32,0x1e51,0x0e70,
	0xff9f,0xefbe,0xdfdd,0xcffc,0xbf1b,0xaf3a,0x9f59,0x8f78,
	0x9188,0x81a9,0xb1ca,0xa1eb,0xd10c,0xc12d,0xf14e,0xe16f,
	0x1080,0x00a1,0x30c2,0x20e3,0x5004,0x4025,0x7046,0x6067,
	0x83b9,0x9398,0xa3fb,0xb3da,0xc33d,0xd31c,0xe37f,0xf35e,
	0x02b1,0x1290,0x22f3,0x32d2,0x4235,0x5214,0x6277,0x7256,
	0xb5ea,0xa5cb,0x95a8,0x8589,0xf56e,0xe54f,0xd52c,0xc50d,
	0x34e2,0x24c3,0x14a0,0x0481,0x7466,0x6447,0x5424,0x4405,
	0xa7db,0xb7fa,0x8799,0x97b8,0xe75f,0xf77e,0xc71d,0xd73c,
	0x26d3,0x36f2,0x0691,0x16b0,0x6657,0x7676,0x4615,0x5634,
	0xd94c,0xc96d,0xf90e,0xe92f,0x99c8,0x89e9,0xb98a,0xa9ab,
	0x5844,0x4865,0x7806,0x6827,0x18c0,0x08e1,0x3882,0x28a3,
	0xcb7d,0xdb5c,0xeb3f,0xfb1e,0x8bf9,0x9bd8,0xabbb,0xbb9a,
	0x4a75,0x5a54,0x6a37,0x7a16,0x0af1,0x1ad0,0x2ab3,0x3a92,
	0xfd2e,0xed0f,0xdd6c,0xcd4d,0xbdaa,0xad8b,0x9de8,0x8dc9,
	0x7c26,0x6c07,0x5c64,0x4c45,0x3ca2,0x2c83,0x1ce0,0x0cc1,
	0xef1f,0xff3e,0xcf5d,0xdf7c,0xaf9b,0xbfba,0x8fd9,0x9ff8,
	0x6e17,0x7e36,0x4e55,0x5e74,0x2e93,0x3eb2,0x0ed1,0x1ef0
};
  

class CPacket : public CObject
{

private:
	//
	UINT	m_nType;	// FROM PAC / GIA / TRIC Data / TRIC List / CNCS

	// HEADER
	BYTE	m_bySourceID;
	BYTE	m_byDestinationID;
	BYTE	m_byMessageCount;
	BYTE	m_byCommandCode;
	UINT	m_unDataLength;

	bool	m_bValidGPS;
	bool	m_bWLANConnect;
	bool	m_bWLANTrasnfer;
	bool	m_bTouchCalibration_Master;
	bool	m_bTouchCalibration_Slave;

	// PAC CCI State
	BYTE	m_byStateCCI;

public:
	// GIA DATA
	//GIA_DATA	GIA;

	// PAC DATA
	PAC_DATA	PAC;
	CAR_DATA	CAR_TEMP[4];
	CAR_DATA	CAR[8];
	CNCS_DATA	CNCS;
	LIC_DATA	LIC;

	// PAC CCI State
	BYTE	GetStateCCI()	{ return m_byStateCCI; };

	void	SetStateCCI( BYTE	byNewCCI )		
	{ 
		m_byStateCCI = byNewCCI;
	};

	BOOL	IsStateCCI( BYTE	byNewCCI )		
	{ 
		return (m_byStateCCI == byNewCCI);
	};

	CPacket();
	virtual ~CPacket();

	bool	SetHeader( BYTE *byBuffer );

	void	SetPAC( BYTE *byBuffer );
	void	SetCNCS( BYTE *byBuffer );
	void	SetLIC( BYTE *byBuffer );

	void	SetCalibration( BYTE *byBuffer, BYTE byCCPID );
	void	SetCarInfo( UINT nCarIndex, BYTE *byBuffer );

	void	SetTricData( BYTE *byBuffer );
	void	SetTricList( BYTE *byBuffer );

	void	SetSkipInfo( BYTE *byBuffer );

	BYTE	GetSourceID()		{ return m_bySourceID; };
	BYTE	GetDestinationID()	{ return m_byDestinationID; };
	BYTE	GetMessageCount()	{ return m_byMessageCount; }
	BYTE	GetCommandCode()	{ return m_byCommandCode; }
	UINT	GetDataLength()		{ return m_unDataLength; };

	void	SetValidGPS( bool	bValidGPS )
	{
		m_bValidGPS = bValidGPS;
	}

	void	SetWLANConnect( bool bWLANConnect )
	{
		m_bWLANConnect = bWLANConnect;
	}

	void	SetWLANTransfer( bool bWLANTrasnfer )
	{
		m_bWLANTrasnfer = bWLANTrasnfer;
	}

	void	SetTouchCalibration_Master( bool bInit)	{ m_bTouchCalibration_Master = bInit; }
	void	SetTouchCalibration_Slave( bool bInit)	{ m_bTouchCalibration_Slave = bInit; }

	bool	GetValidGPS()		{ return m_bValidGPS; }
	bool	GetWLANConnect()	{ return m_bWLANConnect; }
	bool	GetWLANTransfer()	{ return m_bWLANTrasnfer; }
	bool	GetTouchCalibration_Master()	{ return m_bTouchCalibration_Master; }
	bool	GetTouchCalibration_Slave()		{ return m_bTouchCalibration_Slave; }

	static	BYTE	BYTE_MERGE( BYTE byHigh, BYTE byLow );
	static	void	DEC_TO_BCD2(UINT DEC, BYTE *BCD);
	static	void	DEC_TO_BCD4(UINT DEC, BYTE *BCD);
	static	void	DEC_TO_BCD6(UINT DEC, BYTE *BCD);
	static	void	DEC_TO_BCD8(UINT DEC, BYTE *BCD);
	static	BYTE	DEC_FROM_BCD(BYTE BCD);

	static	void	HEX_TO_BCD4(UINT HEX, BYTE *BCD);
	static	void	HEX_TO_BCD8(UINT HEX, BYTE *BCD);
	static	UINT	HEX_FROM_BCD4(BYTE *BCD);
	static	UINT	HEX_FROM_BCD8(BYTE *BCD);

	void	SetCarData( UINT nCarCount, CAR_DATA *CarData, BYTE CI_FAULT )
	{
		CAR_DATA *pCarData = NULL;
		UINT nCarIndex = 0;

		for(UINT i=0; i<nCarCount; i++)
		{
			pCarData = (CarData + i);

			if( pCarData == NULL ) continue;

			memcpy(&CAR[nCarIndex].DATA, pCarData->DATA, sizeof(BYTE)*9 );
			CAR[nCarIndex].CARN = pCarData->CARN;

			memcpy(&CAR[nCarIndex+1].DATA, pCarData->DATA, sizeof(BYTE)*9 );
			CAR[nCarIndex+1].CARN = pCarData->CARN;

			if( ( CAR[nCarIndex].CARN & 0x01 ) == 0x01 )
			{
				if( CHECK_HEADA( CAR[nCarIndex].DATA ) )
				{
					CAR[nCarIndex+1].CARN++;
				}
				else
				{
					CAR[nCarIndex].CARN++;
				}
			}
			else
			{
				if( CHECK_HEADA( CAR[nCarIndex].DATA ) )
				{
					CAR[nCarIndex].CARN--;
				}
				else
				{
					CAR[nCarIndex+1].CARN--;
				}
			}

			nCarIndex += 2;
		}

		for(UINT i=0; i<nCarIndex; i++)
		{
			if( ( CI_FAULT & ( 0x01 << i ) ) == ( 0x01 << i ) )
			{
				CAR[i].bErrCI = TRUE;
			}
			else
			{
				CAR[i].bErrCI = FALSE;
			}
		}

		for(UINT i=nCarIndex; i < 8; i++)
		{
			CAR_DATA CAR_NULL;
			memcpy(&CAR[i], &CAR_NULL, sizeof(CAR_DATA) );
		}

	}

	void	SetCI(UINT nCarIndex, UINT nCINumber)
	{
		if( nCarIndex >= 8 ) return;

		CAR[nCarIndex].CI = nCINumber;
	}

	// 0 : --, 1 : OK, 2 : FAIL
	UINT	GetGPS()			
	{ 
		if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( CHECK_GPSA(CAR[i].DATA) || CHECK_GPSB(CAR[i].DATA) ) return 2;
		}
		
		return 1; 
	}

	UINT	GetWLAN()		
	{ 
		if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( CHECK_WLRA(CAR[i].DATA) || CHECK_WLRB(CAR[i].DATA) ) return 2;
		}
		
		return 1; 	
	}

	UINT	GetLIC()		
	{ 
		if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( CHECK_LICA(CAR[i].DATA) || CHECK_LICB(CAR[i].DATA) ) return 2;
		}
		
		return 1; 	
	}

	UINT	GetCNCS()		
	{ 
			if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( CHECK_CNCSA(CAR[i].DATA) || CHECK_CNCSB(CAR[i].DATA) ) return 2;
		}
		
		return 1;
	}
	
	UINT	GetVTX()		
	{		
		if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( CHECK_VTXA(CAR[i].DATA) || CHECK_VTXB(CAR[i].DATA) ) return 2;
		}
		
		return 1; 
	}

	UINT	GetPAC()		
	{ 		
		if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( CHECK_PACA(CAR[i].DATA) || CHECK_PACB(CAR[i].DATA) ) return 2;
		}
		
		return 1;
	}

	UINT	GetLEDPIS()		
	{ 		
		if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( ( ( CAR[i].DATA[3] & 0x77 )	!= 0) ||
				( ( CAR[i].DATA[4]		)	!= 0) )
				return 2; 
		}
		
		return 1;
	}

	UINT	GetLCDPIS()		
	{ 		
		if(	!GetCarCount() ) return 0;

		for(int i=0; i<(int)GetCarCount(); i++)
		{
			if( ( ( CAR[i].DATA[5]		)	!= 0) ||
				( ( CAR[i].DATA[6] & 0x88 )	!= 0)	)
				return 2; 
		}
		
		return 1;
	}

	bool	GetSimulation()	
	{ 
		if( ( PAC.D3 & 0x80) == 0x80 )	return true;
		
		return false;
	}

	UINT	GetForward()	
	{ 		
		if(	!GetCarCount() ) return 0;

		if( ( PAC.D0 & 0x20) == 0x20 )	return 2;
		else							return 0;

		return 1;
	}

	UINT	GetReverse()	
	{ 		
		if(	!GetCarCount() ) return 0;

		if( ( PAC.D0 & 0x10) == 0x10 )	return 2;
		else							return 0;
		
		return 1;
	}

	UINT	GetDoor()		
	{ 		
		if(	!GetCarCount() ) return 0;

		if( ( PAC.D0 & 0x80) == 0x80 )	return 2;
		else							return 0;
		
		return 1;
	}

	UINT	GetCarCount()	
	{
		UINT nCarCount = 0;

		for(UINT i=0; i<8; i++)
		{
			if( CAR[i].CARN == 0 )
			{
				break;
			}
			
			nCarCount++;
		}

		return nCarCount;
	}

	CAR_DATA	*GetCarData(UINT nCarIndex)
	{
		if( nCarIndex >= 8 ) return NULL;

		return &CAR[nCarIndex];
	}

	unsigned short crc16(const char *buf, int len)
	{
		register int counter;
		register unsigned short crc = 0xFFFF;
		for( counter = 0; counter < len; counter++)
		{
			crc = (crc<<8) ^ crc16tab[((crc>>8) ^ *(char *)buf++)&0x00FF];
		}
		return crc;
	}
};


