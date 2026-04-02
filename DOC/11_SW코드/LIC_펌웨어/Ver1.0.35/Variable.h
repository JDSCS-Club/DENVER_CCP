#include "def.h"
#include "user.h"

#ifndef _Variable_H_
#define _Variable_H_


//2011_03_03 수정 

typedef struct
{
	char LIC_VerList[VER_BDD_MAX_CNT][9];

	UINT m_nUart1RxOneByteGapDelayTime;
	UINT m_nUart2RxOneByteGapDelayTime;
	UINT m_nUart3RxOneByteGapDelayTime;

	UINT m_nUserDebug1msTimer;

	UINT m_nTest1msTimer;

	DATE_TIME_TYPE m_tmCurTime;  // 현재 시간 정보에 대하여 수신 변수.
	DATE_TIME_TYPE m_tmUtcTime;  // 그리니치 천문대 시간으로 다시 설정.  

	//RACK_DI m_RackDi;

	UCHAR m_btCommSt[8]; //LIC가 MDS로 전송할  각 장치 상태 정보 값을 가지고 있는 부분.
	UCHAR m_btOldCommSt[8]; // 상태 버퍼의 이전값을 저장한다.
	UCHAR m_btSenseCommStBuf[8]; // 상태값에서 1이 감지되었을 경우 다음 상태를 읽어 오기전까지 상태값을 가져오도록 저장하는 버퍼

	int m_LIC_CNCS_Tx_Flag; //고장 기록 중이라는 플레그/ LIC<-> CNCS전송시 사용한다.
	int m_LIC_CNCS_TX_DelyTime;
	int m_nLnWkTxFlag ; //고장 기록 시작 플레그.
	int m_nFaultCnt ; //고장 전송 카운터
	int m_Recving_Posi ; //시험중이면서 고장 기록이 증가 하면 CNCS로 데이타 전송 한다.
	int m_nCDT_FaultDataStFlag;//고장 기록을 시작 Flag

	int m_TrainCofVal; // 차량의 중련 상태(0:2,1:4,2:6,3:8), 0x8000은 초기환 되지 않은 값을 나타냄
	int m_nCarPos; // 현재 차량 위치(1~8호차 해당함), 0x8000은 초기환 되지 않은 값을 나타냄
	int m_nCarPos_Re;
	int m_btCiFaultVal; // C/I고장이 발생하면 고장난 호차의 해당 비트를 SET한다.(BIT7~0, 8~1호차를 의미함), 0x8000은 초기환 되지 않은 값을 나타냄
	USHORT m_nCarNo; //  차량번호, 0x8000은 초기환 되지 않은 값을 나타냄

	//int m_TrainCofVal = 0x0000; // 차량의 중련 상태(0:2,1:4,2:6,3:8), 0x8000은 초기환 되지 않은 값을 나타냄
	//int m_nCarPos = 0x0001; // 현재 차량 위치(1~8호차 해당함), 0x8000은 초기환 되지 않은 값을 나타냄
	//int m_btCiFaultVal = 0x8000; // C/I고장이 발생하면 고장난 호차의 해당 비트를 SET한다.(BIT7~0, 8~1호차를 의미함), 0x8000은 초기환 되지 않은 값을 나타냄
	//USHORT m_nCarNo = 0000; //  차량번호, 0x8000은 초기환 되지 않은 값을 나타냄

	char m_chCarKind; // 차량번호 교환시 반드시 차량 종류도 교환할 것
	int m_nCarKindToLonCnt; // 처음에 5회 동안 LON에 차량번호를 전달한다.
	char m_chCarKindNum; //

	BOOL m_bLnWkDbgTxFlag; //고장 기록 확인 비거깅 플레그. 
	UCHAR m_nLnWkWaySideOnRxOk; //고장 수집 완료 플레드. 
	UCHAR m_nCarCnt; // 차량 갯수
	UINT m_nNvsramPos ;
	BOOL m_bLnWkFtpEndFlag;
	UINT m_nDateTime2SecondCnt; // 히스토리컬 전송시 원하는 시간(2000년 1월 1일 0시 0분 0초부터 초 갯수, CNCS로 부터 데이터를 수신받아 Wayside On시 전송한다.)

	UINT m_nTxDbg1msTimer;
	UINT m_nDbgTxPos; 

	USHORT m_btExVersionTbl[VER_BDD_MAX_CNT+4]; // 각 장치 버전 정보 
	USHORT m_btExVersion_DAYTbl[VER_BDD_MAX_CNT+4]; // 각 장치 빌드 날짜

	union{
		unsigned int BYTE;
		struct
		{
			UINT Atcive_Cab:1;			/*    Bit 0     */
			UINT Traction:1;			/*    Bit 1     */
			UINT EP_Mode:1;				/*    Bit 2     */
			UINT All_Doors_Closed:1;	/*    Bit 3     */
			UINT Ci_CutOff:1;           		/*    Bit 4     */
			UINT Sp_5:1;           		/*    Bit 5     */
			UINT Sp_6:1;           		/*    Bit 6     */
			UINT Sp_7:1;           		 /*    Bit 7     */
		}BIT;
	}m_btCttSignalA;

	//UCHAR m_btCttSignalA; // 컨텍트 신호 Married car일때 A or Single car
	UCHAR m_btCttSignalB; // 컨텍트 신호 Married car일때 B

	int m_LIC_CNCS_TimSetFlag; //CNCS랑 통신이 이루어진후 
	int m_LIC_GIA_TimSetFlag; //GIA랑 통신이 이루어진후 					// Y.J (2011.03.02 수정.)

	UINT m_nCncsRxCheck1msTimer; // CNCS와 데이터 수신 여부를 판단하기 위한 타이머
	UINT m_nGiaRxCheck1msTimer; // Gia와 데이터 수신 여부를 판단하기 위한 타이머

	UCHAR m_btTestOtherCiFault; //0x8000 CI 차량 업체가 초기 값으로 지정.
	BOOL m_bCiFaultFlag ; //CI 상태를 전달. 고장 발생시 0x10; 

	//2011_05_13 추가.
	T_FAULT_INFO m_tFaultInfo[eCDT_MAXIMUM];
}VARIABLE_H,*PVARIABLE_H;

//******************************************************************************************
//	초기화
//******************************************************************************************

#endif
