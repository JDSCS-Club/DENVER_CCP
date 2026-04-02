#ifndef _DEF_H_
#define _DEF_H_

/*****************************************************************
	CPU Define
*******************************************************************/

// type define
typedef unsigned short	WORD;
typedef unsigned short	USHORT;
typedef unsigned char	BYTE;
typedef unsigned char	UCHAR;
typedef unsigned int	UINT;
typedef int	BOOL;
typedef unsigned long	DWORD;

#define OP_BR		0x60000000		// BR instruction OP CODE

// Bus Control
#define PRIMBUSREG		*(int *)0x808064 // Primary BUS Register

// Interrupt Vector
#define RINT0_VECT      *(int *)0x809fc6        // Serial port0 receive INT
#define TINT0_VECT      *(int *)0x809fc9        // Timer0 INT
#define INT0_VECT       *(int *)0x809fc1        // External INT 0
#define INT1_VECT       *(int *)0x809fc2        // External INT 1
#define INT2_VECT       *(int *)0x809fc3        // External INT 2
#define INT3_VECT       *(int *)0x809fc4        // External INT 3
#define DMA_VECT        *(int *)0x809fcB        // DMA  vector address

// Timer Define
#define TMR0_CTRL       *(int *)0x808020        // Timer0 control register
#define TMR0_CNT        *(int *)0x808024        // Timer0 counter register
#define TMR0_PERD       *(int *)0x808028        // Timer0 period register


// Serial Define
#define SP_GLOBAL_CON   (*((int *)0x808040))    // Global control register
#define FSX_DX_CLKX_CON (*((int *)0x808042))    // FSX/DX/CLKX port control
#define FSR_DR_CLKR_CON (*((int *)0x808043))    // FSR/DR/CLKR port control
#define RX_TIMER_CON    (*((int *)0x808044))    // R/X timer control reg
#define RX_TIMER_CNT    (*((int *)0x808045))    // R/X timer counter
#define RX_TIMER_PRD    (*((int *)0x808046))    // R/X timer period register
#define S_TXD           (*((int *)0x808048))    // Data transmit register
#define S_RXD           (*((int *)0x80804c))    // Data receive register


// DMA Control
#define DMA_GCR		(*((int *)0x808000))    // DMA global control register
#define DMA_SRC		(*((int *)0x808004))    // DMA source address register
#define DMA_DST		(*((int *)0x808006))    // DMA destination address register
#define DMA_CNT		(*((int *)0x808008))    // DMA transfer counter register


// Interrupt Enable, Disable
#define DINT		asm("	AND	0DFFFh, ST	")
#define EINT		asm("	OR	02000h, ST	")

#define DIS_CACHE	asm("   AND	0F7FFh, ST	")
#define EN_CACHE	asm("   OR	00800h, ST	")

#define DI_INT0		asm("	AND	0FFFEh, IE	")
#define EI_INT0		asm("	OR	00001h, IE	")

#define DI_INT1		asm("	AND	0FFFDh, IE	")
#define EI_INT1		asm("	OR	00002h, IE	")

#define DI_INT2		asm("	AND	0FFFBh, IE	")
#define EI_INT2		asm("	OR	00004h, IE	")

#define DI_INT3		asm("	AND	0FFFEh, IE	")
#define EI_INT3		asm("	OR	00008h, IE	")

// Timer 0
#define DI_TINT0	asm(" AND       0FEFFh, IE ")
#define EI_TINT0	asm(" OR        00100h, IE ")

// Timer 1
#define DI_TINT1	asm(" AND       0FDFFh, IE ")
#define EI_TINT1	asm(" OR        00200h, IE ")


/*****************************************************************
	CPU System I/O 변수.
*******************************************************************/
#define BOOT2INT ((*(int *)0x100000) = 0)

#define WDI_ACT (*(UCHAR *)0x002000 = 0x00)

#define LED_CS (*(UCHAR *)0x200000)
#define ERR_LED(x) {if((x)) {LED_CS = LED_CS & 0x02;} else {LED_CS = LED_CS | 0x01;}}
#define RUN_LED(x) {if((x)) {LED_CS = LED_CS & 0x01;} else {LED_CS = LED_CS | 0x02;}}
 
// DI/O 접점 Address
#define DI_ADDRESS_AB_CS 0x200001
#define DI_ADDRESS_A (((*(UCHAR *)DI_ADDRESS_AB_CS))&0x01)
#define DI_ADDRESS_B (((*(UCHAR *)DI_ADDRESS_AB_CS)>>1)&0x01)

// 통신 Interface Address
#define INT_ST_BASE 0x80B000

#define INT1_ST (((*(UCHAR *)INT_ST_BASE)>>2)&0x01)
#define INT2_ST (((*(UCHAR *)INT_ST_BASE)>>1)&0x01)
#define INT3_ST (((*(UCHAR *)INT_ST_BASE))&0x01)

#define XR16L784_INT_ST INT1_ST //XR16L784 래치  
#define LONWORK_INT_ST INT2_ST  //MPU <--> LON 통신 레치 신호
#define LNWK_TXINTREQ() ((*(UCHAR *)0xA00000) = (~(*(UCHAR *)0xA00000)&0x01)) // Lon TX 신호


#define XF0_SET			asm(" OR  00004h,IOF")
#define XF0_CLEAR		asm(" AND 0fffbh,IOF")

#define XF1_SET			asm(" OR  00040h,IOF")
#define XF1_CLEAR		asm(" AND 0ffbfh,IOF")


/*****************************************************************
	CPU 메모리 변수.
*******************************************************************/
//로직 회로 내부 메모리 구조.
#define DPRAM_BASE 0xB00000
#define DPRAM (*(UCHAR *)DPRAM_BASE)
#define DPRAM_SIZE 0x2000


//NVSRAM 메모리 구조.
#define NVSRAM_BASE 0xC00000
#define NVSRAM (*(UCHAR *)NVSRAM_BASE)
#define NVSRAM_WAYSIDEONBUF_SIZE 0x300000 //고장 저장 용량을 최대 3M Byte로 지정.
#define NVSRAM_UARTMONFIFO_BASE 0xFFD7FF //9740
#define NVSRAM_VER 0xFFFE0C
#define NVSRAM_VER_SIZE 500

//  NVSRAM_BASE Memory Structure
//  0xC00000     
//    ~~~ 고장 데이타 최대 저장 용량 지정. 3MByte
//  0xF00000  : 
//     ~~~~   --> 사용 가능 공간. 
//     ~~~~   --> 사용 가능 공간.
//  0xFFD7FF  : 9740 Size 디버깅 통신 채널 1ch 
//  0xFFFE0C  : 500 Size 버전 정보 조정 위치

/*****************************************************************
	변수 값 디폴트 선언.
*******************************************************************/
#define STX 0x02
#define ETX 0x03

#define SOH 0x01
#define EOT 0x04

#define ACK 0x06
#define NAK 0x15

#define GIA_DEV_NO		0x13

#define PAC_DEV_NO		0x21
#define PAC_BAKDEV_NO	0x25

#define CCP_DEV_NO      0x11
#define CCP_BAKDEV_NO   0x12

#define LIC_DEV_NO		0x22
#define LIC_BAKDEV_NO   0x26

#define CNCS_DEV_NUM_A 0x24
#define CNCS_DEV_NUM_B 0x28


#define REQ_CMD			0x10
#define RPY_CMD			0x11

#define TRUE		1
#define FALSE		0

#define NULL 0

#define LIC_33_Ver 0x1000
#define VER_BDD_MAX_CNT		25

/*
#define LW_WAYSIDE_ON_REQ	0x01
#define LW_WAYSIDE_ON_ACK	0x02
#define LW_FTP_TX			0x05
#define LW_FTP_TX_END		0x06
#define LW_CARNO			0x07
#define LW_TIME_REQ			0x08
#define LW_TIME_TX			0x09
#define LW_COMMST_REQ		0x0A
#define LW_COMMST_TX		0x0B
#define LW_VERSION_REQ		0x0C
#define LW_VERSION_TX		0x0D
*/


/*****************************************************************
	변수 타입 컴버전.
*******************************************************************/

#define ISRANGE_LOW(X,MIN,MAX)	((X) >= (MIN) && (X) < (MAX))
#define IS_ASCNUMBER(x) ((x) >= '0' && (x) <= '9')
#define IS_ASCHEX(x) (((x) >= '0' && (x) <= '9') || ((x) >= 'A' && (x) <= 'F') || ((x) >= 'a' && (x) <= 'f'))
#define IS_ASCALPHABET(x)  (((x) >= 'A' && (x) <= 'Z') || ((x) >= 'a' && (x) <= 'z'))
#define IS_ASCSPEC(x)  ((x) == '?')

#define TWOBYTE_ASC2HEX(x) (MAKE_BYTE(ConvAsc2Hex(x[0]),ConvAsc2Hex(x[1])))
#define TWOBYTE_ASC2DEC(x) ((ConvAsc2Dec(x[0]) * 10) + ConvAsc2Dec(x[1]))


#define HEXA2BIN(H) (((H)>>4)*10+((H)&0x0f))
#define BIN2HEXA(B)	((((B)/10)<<4)|((B)%10))
#define BCD2BIN(H)  HEXA2BIN(H)
#define BIN2BCD(B)  BIN2HEXA(B)

#define SWAPBYTE(x) (((x)&0x0f)<<4|((x)&0xf0)>>4)


#define HI_NIBBLE(x) 	((BYTE)((x) >> 4))
#define LO_NIBBLE(x) 	((BYTE)((x) & 0x0f))

#define HI_BYTE(x)		((BYTE)(((x) >> 8) & 0xff))
#define LO_BYTE(x)		((BYTE)((x) & 0xff))


#define MAKE_DWORD(HH,HL,LH,LL)	((UINT)(((HH)<<24) | (((HL)&0xff)<<16) | (((LH)&0xff)<<8) | ((LL)&0xff)))
#define MAKE_UINT(H,L)	((UINT)((((H)&0xffff)<<16) | ((L)&0xffff)))
#define MAKE_WORD(H,L) ((((H) << 8) | ((L) & 0xff)) & 0xffff)
#define MAKE_BYTE(H,L) ((((H) << 4) | ((L) & 0x0f)) & 0xff)

#define BYTE_H(HL) (((HL)>>4) & 0xf)
#define BYTE_L(HL) ((HL) & 0xf)

#define WORD_H(HL) (((HL)>>8) & 0x0ff)
#define WORD_L(HL) ((HL) & 0x0ff)

#define DWORD_H(HL) (((HL)>>16) & 0xffff)
#define DWORD_L(HL) ((HL) & 0xffff)

#define MIN(a,b) (a) < (b) ? (a) : (b)
#define MAX(a,b) (a) > (b) ? (a) : (b)
	
#define MASKBIT(b,x) (((b)&1)<<(x))

#endif