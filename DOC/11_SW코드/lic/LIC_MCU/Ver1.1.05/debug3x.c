#include "debug3x.h"

unsigned long _glDebugAddr;
unsigned long _glDebugData;

#define DEBUG_3X_ID_VALUE 0x12345678

/***********************************************************************
	TMS320C3X의 동기 통신의 인터럽트 서비스 루틴.
	인터럽트사용이 다른 목적으로 사용하려한다면 오로지 다운로더및
	ROM에 쓰기 기능만 된다.
************************************************************************/
void c_int06()
{
	unsigned long nRXData;
	unsigned long nTXData;
	
	nRXData = *(unsigned long *)0x80804c;
    
	switch(nRXData >> 24)
	{
		case 0x00:
			nTXData = *(unsigned long *)nRXData;
			break;            
            
		case 0x1D:
			nTXData = DEBUG_3X_ID_VALUE;
			break;
					
		case 0x88:
			nTXData = 0x12345678;
			break;			
			
		case 0xAD:
			_glDebugAddr = nRXData & 0xffffff;
			nTXData = _glDebugAddr;
			break;

		case 0xD1:
			_glDebugData = (nRXData << 16) & 0xffff0000;
			nTXData = _glDebugData;
			break;            
            
		case 0xD0:
			_glDebugData |= (nRXData & 0xffff);
			nTXData = _glDebugData;
			break;            

		case 0x33:
			*(unsigned long *)_glDebugAddr = _glDebugData;
			break;            
            
		default:
			nTXData = 0xffffffff;
			break;
	}
    
	*(unsigned long *)0x808048 = nTXData;
}


/************************************************************************
	DSP의 모니터를 하기위해 수행해 인터럽트벡터및 인터럽트 서비스 루틴을
	설정하기 위한 루틴.
	
	#include "debug3x.h"
	
	main()
	{
		(1) 전체 인터럽트를 disable 시킨다.
		(2) DSP를 주변 장치들을 초기화 한다.
		(3) Debug3xInit(TMS320C31); // TMS320C31를 모니터할때 사용
			Debug3xInit(TMS320C32); // TMS320C32를 모니터할때 사용
			Debug3xInit(TMS320C33); // TMS320C33를 모니터할때 사용
		(4) 전체 인터럽트를 enable 시킨다.
		
		(5) while(1){..} 원하는 프로그램을 수행한다.
	}
*************************************************************************/
void Debug3xInit(unsigned char nKind)
{
	int nTemp;
	
	*(unsigned long *)0x808042 = 0x111;
	*(unsigned long *)0x808040 = 0x0e3c0000;
	nTemp = *(unsigned long *)0x80804c;
	
	switch(nKind)
	{
	default:
	/******************************************************
		TMS320C31,33에서 수행할때 먼저 설정 해야한다.
	*******************************************************/
	case TMS320C31:
	case TMS320C33:
		(*(unsigned long *)0x809fc6) = 0x60000000 | (int)c_int06;
		break;
		
	/******************************************************
		TMS320C32에서 수행할때 먼저 설정 해야한다.
	*******************************************************/
	case TMS320C32:
		(*(unsigned long *)0x87fe06) = 0x60000000 | (int)c_int06;
		
		// 인터럽트 벡터를 다시 구성한다.
		asm("   LDI     87feh, IF ");
		asm("   LSH     10h, IF ");     // 0x87fe0000 <---------------
		break;
	}
	
	// 인터럽트를 활성화 시킨다.
	asm("	OR	0020h,IE");
}
