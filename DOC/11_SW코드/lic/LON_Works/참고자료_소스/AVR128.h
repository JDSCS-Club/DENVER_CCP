
/******************************************************************************/
/*  FILE        :AVR128.H                                                     */
/*  DATE        :04-09-2002                                                   */
/*  DESCRIPTION :Define Header By MAMMOTH TECHNOGY                            */
/*  CPU TYPE    :ATmega128 - 7.3728MHz                                        */
/******************************************************************************/
////////////////////////////////////////////////////////////////////////////////
typedef unsigned char	BYTE;
typedef unsigned int 	WORD;
typedef unsigned long 	DWORD;
////////////////////////////////////////////////////////////////////////////////
#define Inportb(Addr)       (*(BYTE *)(Addr))
#define Outportb(Addr,Data) (*(BYTE *)(Addr))=(Data)
////////////////////////////////////////////////////////////////////////////////
#define	BIT0	0x01																																																						
#define	BIT1	0x02																																																						
#define	BIT2	0x04																																																						
#define	BIT3	0x08																																																						
#define	BIT4	0x10																																																						
#define	BIT5	0x20																																																						
#define	BIT6	0x40																																																						
#define	BIT7	0x80	
																																																					
////////////////////////////////////////////////////////////////////////////////
#define ENTER   0x0D

////////////////////////////////////////////////////////////////////////////////
#define ON		0x01
#define OFF		0x00
#define OK		0x01
#define NG		0x00


////////////////////////////////////////////////////////////////////////////////
//extern void MfDelay10us(WORD DTime);
//extern void Delay1ms(WORD DTime);
////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :MCU Control Register MCUCR                                   */
/******************************************************************************/
//BIT7 : SRE, External SRAM Enable
//BIT6 : SRW, External SRAM Wait State
//BIT5 : SE, Sleep Enable
//BIT4,3 : SM1/SM2, Sleep Mode Select Bits 1 & 0
//SM1 SM0 : 0,0(Idle Mode) 0,1(Reserved) 1,0(Power-Down) 1,1(Power Save) 
//BIT2,1,0: Read Only by 0

#define  MCUCR_Init	  	   	 MCUCR = 0x00

#define  IVSEL_Enable		 MCUCR = MCUCR | BIT1
#define  IVCE_Enable		 MCUCR = MCUCR | BIT0

#define  Idle_Mode	  	   	 { MCUCR = MCUCR & ~BIT3; MCUCR = MCUCR & ~BIT4; }
#define  Power_Down	  	   	 { MCUCR = MCUCR & ~BIT3; MCUCR = MCUCR |  BIT4; }
#define  Power_Save	  	   	 { MCUCR = MCUCR |  BIT3; MCUCR = MCUCR |  BIT4; }

#define	 SE_Disable          MCUCR = MCUCR & ~BIT5
#define	 SE_Enable           MCUCR = MCUCR |  BIT5

#define	 SRW_Three_Waite     MCUCR = MCUCR & ~BIT6
#define	 SRW_One_Waite       MCUCR = MCUCR |  BIT6

#define	 SRE_Disable         MCUCR = MCUCR & ~BIT7
#define	 SRE_Enable          MCUCR = MCUCR |  BIT7

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :External Interrupt Register - EICRA, EICRB, EIMSK            */
/******************************************************************************/
//EICRA
//BIT7,6 : ISC31, ISC30, External Interrupt3 Sense Control
//BIT5,4 : ISC21, ISC20, External Interrupt3 Sense Control
//BIT3,2 : ISC11, ISC10, External Interrupt3 Sense Control
//BIT1,0 : ISC01, ISC00, External Interrupt3 Sense Control
//EICRB
//BIT7,6 : ISC71, ISC70, External Interrupt3 Sense Control
//BIT5,4 : ISC61, ISC60, External Interrupt3 Sense Control
//BIT3,2 : ISC51, ISC50, External Interrupt3 Sense Control
//BIT1,0 : ISC41, ISC40, External Interrupt3 Sense Control
//EIMSK
//BIT7   : INT7, External Interrupt Request7 Enable
//BIT6   : INT6, External Interrupt Request6 Enable
//BIT5   : INT5, External Interrupt Request5 Enable
//BIT4   : INT4, External Interrupt Request4 Enable
//BIT3   : INT3, External Interrupt Request3 Enable
//BIT2   : INT2, External Interrupt Request2 Enable
//BIT1   : INT1, External Interrupt Request1 Enable
//BIT0   : INT0, External Interrupt Request0 Enable

#define	ISC3_LOW_LEVEL		EICRA = EICRA | 0x00
#define	ISC3_RESERVED		EICRA = EICRA | 0x40
#define	ISC3_FALLING_EDGE	EICRA = EICRA | 0x80
#define	ISC3_RISING_EDGE	EICRA = EICRA | 0xC0

#define	ISC2_LOW_LEVEL		EICRA = EICRA | 0x00
#define	ISC2_RESERVED		EICRA = EICRA | 0x10
#define	ISC2_FALLING_EDGE	EICRA = EICRA | 0x20
#define	ISC2_RISING_EDGE	EICRA = EICRA | 0x30

#define	ISC1_LOW_LEVEL		EICRA = EICRA | 0x00
#define	ISC1_RESERVED		EICRA = EICRA | 0x04
#define	ISC1_FALLING_EDGE	EICRA = EICRA | 0x08
#define	ISC1_RISING_EDGE	EICRA = EICRA | 0x0C

#define	ISC0_LOW_LEVEL		EICRA = EICRA | 0x00
#define	ISC0_RESERVED		EICRA = EICRA | 0x01
#define	ISC0_FALLING_EDGE	EICRA = EICRA | 0x02
#define	ISC0_RISING_EDGE	EICRA = EICRA | 0x03

#define	ISC7_LOW_LEVEL		EICRB = EICRB | 0x00
#define	ISC7_RESERVED		EICRB = EICRB | 0x40
#define	ISC7_FALLING_EDGE	EICRB = EICRB | 0x80
#define	ISC7_RISING_EDGE	EICRB = EICRB | 0xC0

#define	ISC6_LOW_LEVEL		EICRB = EICRB | 0x00
#define	ISC6_RESERVED		EICRB = EICRB | 0x10
#define	ISC6_FALLING_EDGE	EICRB = EICRB | 0x20
#define	ISC6_RISING_EDGE	EICRB = EICRB | 0x30

#define	ISC5_LOW_LEVEL		EICRB = EICRB | 0x00
#define	ISC5_RESERVED		EICRB = EICRB | 0x04
#define	ISC5_FALLING_EDGE	EICRB = EICRB | 0x08
#define	ISC5_RISING_EDGE	EICRB = EICRB | 0x0C

#define	ISC4_LOW_LEVEL		EICRB = EICRB | 0x00
#define	ISC4_RESERVED		EICRB = EICRB | 0x01
#define	ISC4_FALLING_EDGE	EICRB = EICRB | 0x02
#define	ISC4_RISING_EDGE	EICRB = EICRB | 0x03

#define INT7_ENABLE			EIMSK = EIMSK |  BIT7
#define INT7_DISABLE		EIMSK = EIMSK & ~BIT7
#define INT6_ENABLE			EIMSK = EIMSK |  BIT6
#define INT6_DISABLE		EIMSK = EIMSK & ~BIT6
#define INT5_ENABLE			EIMSK = EIMSK |  BIT5
#define INT5_DISABLE		EIMSK = EIMSK & ~BIT5
#define INT4_ENABLE			EIMSK = EIMSK |  BIT4
#define INT4_DISABLE		EIMSK = EIMSK & ~BIT4
#define INT3_ENABLE			EIMSK = EIMSK |  BIT3
#define INT3_DISABLE		EIMSK = EIMSK & ~BIT3
#define INT2_ENABLE			EIMSK = EIMSK |  BIT2
#define INT2_DISABLE		EIMSK = EIMSK & ~BIT2
#define INT1_ENABLE			EIMSK = EIMSK |  BIT1
#define INT1_DISABLE		EIMSK = EIMSK & ~BIT1
#define INT0_ENABLE			EIMSK = EIMSK |  BIT0
#define INT0_DISABLE		EIMSK = EIMSK & ~BIT0

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Timer/Counter Interrupt Register - TIMSK, ETIMSK             */
/******************************************************************************/
//TIMSK
//BIT7 : OCIE2, Timer/Counter2 Output Compare Interrupt Enable
//BIT6 : TOIE2, Timer/Counter2 Overflow Interrupt Enable
//BIT5 : TICIE1, Timer/Counter1 Input Capture Interrupt Enable
//BIT4 : OCIE1A, Timer/Counter1 Output CompareA Interrupt Enable
//BIT3 : OCIE1B, Timer/Counter1 Output CompareB Interrupt Enable
//BIT2 : TOIE1, Timer/Counter1 Overflow Interrupt Enable
//BIT1 : OCIE0, Timer/Counter0 Output Compare Interrupt Enable
//BIT0 : TOIE0, Timer/Counter0 Overflow Interrupt Enable
//ETIMSK
//BIT7,6:Not Use!
//BIT5 : TICIE3, Timer/Counter3 Input Capture Interrupt Enable
//BIT4 : OCIE3A, Timer/Counter3 Output CompareA Interrupt Enable
//BIT3 : OCIE3B, Timer/Counter3 Output CompareB Interrupt Enable
//BIT2 : TOIE3, Timer/Counter1 Overflow Interrupt Enable
//BIT1 : OCIE3C, Timer/Counter3 Output CompareC Interrupt Enable
//BIT0 : OCIE1C, Timer/Counter1 Output CompareC Interrupt Enable

#define  TIMSK_Init	  	   	 TIMSK = 0x00
#define  ETIMSK_Init		 ETIMSK = 0x00

#define	 OCIE2_Disable       TIMSK = TIMSK & ~BIT7
#define	 OCIE2_Enable        TIMSK = TIMSK |  BIT7

#define	 TOIE2_Disable       TIMSK = TIMSK & ~BIT6
#define	 TOIE2_Enable        TIMSK = TIMSK |  BIT6

#define	 TICIE1_Disable      TIMSK = TIMSK & ~BIT5
#define	 TICIE1_Enable       TIMSK = TIMSK |  BIT5

#define	 OCIE1A_Disable      TIMSK = TIMSK & ~BIT4
#define	 OCIE1A_Enable       TIMSK = TIMSK |  BIT4

#define	 OCIE1B_Disable      TIMSK = TIMSK & ~BIT3
#define	 OCIE1B_Enable       TIMSK = TIMSK |  BIT3

#define	 TOIE1_Disable       TIMSK = TIMSK & ~BIT2
#define	 TOIE1_Enable        TIMSK = TIMSK |  BIT2

#define	 OCIE0_Disable       TIMSK = TIMSK & ~BIT1
#define	 OCIE0_Enable        TIMSK = TIMSK |  BIT1

#define	 TOIE0_Disable       TIMSK = TIMSK & ~BIT0
#define	 TOIE0_Enable        TIMSK = TIMSK |  BIT0

#define	 TICIE3_Disable      ETIMSK = ETIMSK & ~BIT5
#define	 TICIE3_Enable       ETIMSK = ETIMSK |  BIT5

#define	 OCIE3A_Disable      ETIMSK = ETIMSK & ~BIT4
#define	 OCIE3A_Enable       ETIMSK = ETIMSK |  BIT4

#define	 OCIE3B_Disable      ETIMSK = ETIMSK & ~BIT3
#define	 OCIE3B_Enable       ETIMSK = ETIMSK |  BIT3

#define	 TOIE3_Disable       ETIMSK = ETIMSK & ~BIT2
#define	 TOIE3_Enable        ETIMSK = ETIMSK |  BIT2

#define	 OCIE3C_Disable      ETIMSK = ETIMSK & ~BIT1
#define	 OCIE3C_Enable       ETIMSK = ETIMSK |  BIT1

#define	 OCIE1C_Disable      ETIMSK = ETIMSK & ~BIT0
#define	 OCIE1C_Enable       ETIMSK = ETIMSK |  BIT0

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Timer/Counter Interrupt Flag Register - TIFR, ETIFR          */
/******************************************************************************/
//TIFR
//BIT7 : OCF2, Output Compare Flag 2
//BIT6 : TOV2, Overflow Flag 2
//BIT5 : ICF1, Input Capture Flag 1
//BIT4 : OCF1A, Output Compare Flag 1A
//BIT3 : OCF1B, Output Compare Flag 1B
//BIT2 : TOV1, Overflow Flag 1
//BIT1 : OCF0, Output Compare Flag 0
//BIT0 : TOV0, Overflow Flag0
//ETIFR
//BIT5 : ICF3, Input Capture Flag 3
//BIT4 : OCF3A, Output Compare Flag 3A
//BIT3 : OCF3B, Output Compare Flag 3B
//BIT2 : TOV3, Overflow Flag 3
//BIT1 : OCF3C, Output Compare Flag 3C
//BIT0 : OCF1C, Output Compare Flag 1C

#define  TIFR_Init	  	   	 TIFR  = 0x00
#define  ETIFR_Init	  	   	 ETIFR  = 0x00

#define	 OCF2_Clear       	 TIFR = TIFR & ~BIT7
#define	 TOV2_Clear       	 TIFR = TIFR & ~BIT6
#define	 ICF1_Clear       	 TIFR = TIFR & ~BIT5
#define	 OCF1A_Clear       	 TIFR = TIFR & ~BIT4
#define	 OCF1B_Clear       	 TIFR = TIFR & ~BIT3
#define	 TOV1_Clear       	 TIFR = TIFR & ~BIT2
#define	 OCF0_Clear       	 TIFR = TIFR & ~BIT1
#define	 TOV0_Clear       	 TIFR = TIFR & ~BIT0

#define	 ICF3_Clear       	 ETIFR = ETIFR & ~BIT5
#define	 OCF3A_Clear       	 ETIFR = ETIFR & ~BIT4
#define	 OCF3B_Clear       	 ETIFR = ETIFR & ~BIT3
#define	 TOV3_Clear       	 ETIFR = ETIFR & ~BIT2
#define	 OCF3C_Clear       	 ETIFR = ETIFR & ~BIT1
#define	 OCF1C_Clear       	 ETIFR = ETIFR & ~BIT0

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Timer/Counter0 Control Register - TCCR0                      */
/******************************************************************************/
//BIT7     : FOC0, Force Ouput Compare
//BIT6,3   : WGM00, WGM01, Waveform Generation Mode
//BIT5,4   : COM01,COM00 Compare Output Mode Bit1 & Bit0
//BIT2,1,0 : Clock Select Bits 2,1 & 0

#define  TCCR0_Init		     TCCR0  = 0x00

#define  FOC0_LOW		  	 TCCR0 = TCCR0 & ~BIT7
#define  FOC0_HIGH		  	 TCCR0 = TCCR0 |  BIT7

#define  WGM0_NORMAL		 TCCR0 = TCCR0 | 0x00  
#define  WGM0_PWM			 TCCR0 = TCCR0 | 0x40 
#define  WGM0_CTC			 TCCR0 = TCCR0 | 0x08 
#define  WGM0_FAST_PWM		 TCCR0 = TCCR0 | 0x48 

#define  COM0_TIMER			 TCCR0 = TCCR0 | 0x00  
#define  COM0_TOGGLE		 TCCR0 = TCCR0 | 0x10 
#define  COM0_CLEAR			 TCCR0 = TCCR0 | 0x20 
#define  COM0_SET			 TCCR0 = TCCR0 | 0x30 

#define  CS0_STOP			 TCCR0 = TCCR0 | 0x00
#define  CS0_CK				 TCCR0 = TCCR0 | 0x01
#define  CS0_CK8			 TCCR0 = TCCR0 | 0x02
#define  CS0_CK32			 TCCR0 = TCCR0 | 0x03
#define  CS0_CK64			 TCCR0 = TCCR0 | 0x04
#define  CS0_CK128			 TCCR0 = TCCR0 | 0x05
#define  CS0_CK256			 TCCR0 = TCCR0 | 0x06
#define  CS0_CK1024			 TCCR0 = TCCR0 | 0x07

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Timer/Counter1 Control Register - TCCR1A, TCCR1B, TCCR1C     */
/******************************************************************************/
//TCCR1A
//BIT7,6   : COM1A1, COM1A0, Compare Output Mode
//BIT5,4   : COM1B1, COM1B0, Compare Output Mode
//BIT3,2   : COM1C1, COM1C0, Compare Output Mode
//BIT1,0   : WGM11, WGM10, Waveform Generation Mode
//TCCR1B
//BIT7     : ICNC1, Input Capture Noise Canceler
//BIT6	   : ICES1, Input Capture Edge Select
//BIT5     : Not Use!
//BIT4,3   : WGM13, WGM11, Waveform Generation Mode
//BIT2,1,0 : Clock Select Bits 2,1 & 0
//TCCR1C
//BIT7     : FOC1A, Force Ouput Compare
//BIT6     : FOC1B, Force Ouput Compare
//BIT5     : FOC1C, Force Ouput Compare
//BIT4,3,2,1,0: Not Use!

#define  TCCR1A_Init		 TCCR1A  = 0x00
#define  TCCR1B_Init		 TCCR1B  = 0x00
#define  TCCR1C_Init		 TCCR1C  = 0x00

#define  COM1A_TIMER		 TCCR1A = TCCR1A | 0x00  
#define  COM1A_TOGGLE		 TCCR1A = TCCR1A | 0x40 
#define  COM1A_CLEAR		 TCCR1A = TCCR1A | 0x80 
#define  COM1A_SET			 TCCR1A = TCCR1A | 0xC0 

#define  COM1B_TIMER		 TCCR1A = TCCR1A | 0x00  
#define  COM1B_TOGGLE		 TCCR1A = TCCR1A | 0x10 
#define  COM1B_CLEAR		 TCCR1A = TCCR1A | 0x20 
#define  COM1B_SET			 TCCR1A = TCCR1A | 0x30 

#define  COM1C_TIMER		 TCCR1A = TCCR1A | 0x00  
#define  COM1C_TOGGLE		 TCCR1A = TCCR1A | 0x04 
#define  COM1C_CLEAR		 TCCR1A = TCCR1A | 0x08 
#define  COM1C_SET			 TCCR1A = TCCR1A | 0x0C 

#define  WGM1_NORMAL		 TCCR1A = TCCR1A | 0x00; TCCR1B = TCCR1B | 0x00; 
#define  WGM1_PWM_8Bit		 TCCR1A = TCCR1A | 0x01; TCCR1B = TCCR1B | 0x00;
#define  WGM1_PWM_9Bit		 TCCR1A = TCCR1A | 0x02; TCCR1B = TCCR1B | 0x00;
#define  WGM1_PWM_10Bit		 TCCR1A = TCCR1A | 0x03; TCCR1B = TCCR1B | 0x00;
#define  WGM1_CTC1			 TCCR1A = TCCR1A | 0x00; TCCR1B = TCCR1B | 0x08;
#define  WGM1_FAST_PWM_8BIT	 TCCR1A = TCCR1A | 0x01; TCCR1B = TCCR1B | 0x08;
#define  WGM1_FAST_PWM_9BIT	 TCCR1A = TCCR1A | 0x02; TCCR1B = TCCR1B | 0x08;
#define  WGM1_FAST_PWM_10BIT TCCR1A = TCCR1A | 0x03; TCCR1B = TCCR1B | 0x08;
#define  WGM1_PWM_FREQ1		 TCCR1A = TCCR1A | 0x00; TCCR1B = TCCR1B | 0x10;
#define  WGM1_PWM_FREQ2		 TCCR1A = TCCR1A | 0x01; TCCR1B = TCCR1B | 0x10;
#define  WGM1_PWM_CORRECT1	 TCCR1A = TCCR1A | 0x02; TCCR1B = TCCR1B | 0x10;
#define  WGM1_PWM_CORRECT2	 TCCR1A = TCCR1A | 0x03; TCCR1B = TCCR1B | 0x10;
#define  WGM1_CTC2			 TCCR1A = TCCR1A | 0x00; TCCR1B = TCCR1B | 0x18;
#define  WGM1_RESERVED		 TCCR1A = TCCR1A | 0x01; TCCR1B = TCCR1B | 0x18;
#define  WGM1_FAST_PWM1		 TCCR1A = TCCR1A | 0x02; TCCR1B = TCCR1B | 0x18;
#define  WGM1_FAST_PWM2		 TCCR1A = TCCR1A | 0x03; TCCR1B = TCCR1B | 0x18;

#define  ICNC1_DISABLE	 	 TCCR1B = TCCR1B & ~BIT7
#define  ICNC1_ENABLE	  	 TCCR1B = TCCR1B |  BIT7
#define  ICES1_FALLING	  	 TCCR1B = TCCR1B & ~BIT6
#define  ICES1_RISING	  	 TCCR1B = TCCR1B |  BIT6

#define  CS1_STOP			 TCCR1B = TCCR1B | 0x00
#define  CS1_CK				 TCCR1B = TCCR1B | 0x01
#define  CS1_CK8			 TCCR1B = TCCR1B | 0x02
#define  CS1_CK64			 TCCR1B = TCCR1B | 0x03
#define  CS1_CK256			 TCCR1B = TCCR1B | 0x04
#define  CS1_CK1024			 TCCR1B = TCCR1B | 0x05
#define  CS1_EX_FALLING		 TCCR1B = TCCR1B | 0x06
#define  CS1_EX_RISING		 TCCR1B = TCCR1B | 0x07

#define  FOC1A_LOW		  	 TCCR1C = TCCR1C & ~BIT7
#define  FOC1A_HIGH		  	 TCCR1C = TCCR1C |  BIT7
#define  FOC1B_LOW		  	 TCCR1C = TCCR1C & ~BIT6
#define  FOC1B_HIGH		  	 TCCR1C = TCCR1C |  BIT6
#define  FOC1C_LOW		  	 TCCR1C = TCCR1C & ~BIT5
#define  FOC1C_HIGH		  	 TCCR1C = TCCR1C |  BIT5

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Timer/Counter2 Control Register - TCCR2                      */
/******************************************************************************/
//BIT7     : FOC0, Force Ouput Compare
//BIT6,3   : WGM00, WGM01, Waveform Generation Mode
//BIT5,4   : COM01,COM00 Compare Output Mode Bit1 & Bit0
//BIT2,1,0 : Clock Select Bits 2,1 & 0

#define  TCCR2_Init		     TCCR2  = 0x00

#define  FOC2_LOW		  	 TCCR2 = TCCR2 & ~BIT7
#define  FOC2_HIGH		  	 TCCR2 = TCCR2 |  BIT7

#define  WGM2_NORMAL		 TCCR2 = TCCR2 | 0x00  
#define  WGM2_PWM			 TCCR2 = TCCR2 | 0x40 
#define  WGM2_CTC			 TCCR2 = TCCR2 | 0x08 
#define  WGM2_FAST_PWM		 TCCR2 = TCCR2 | 0x48 

#define  COM2_TIMER			 TCCR2 = TCCR2 | 0x00  
#define  COM2_TOGGLE		 TCCR2 = TCCR2 | 0x10 
#define  COM2_CLEAR			 TCCR2 = TCCR2 | 0x20 
#define  COM2_SET			 TCCR2 = TCCR2 | 0x30 

#define  CS2_STOP			 TCCR2 = TCCR2 | 0x00
#define  CS2_CK				 TCCR2 = TCCR2 | 0x01
#define  CS2_CK8			 TCCR2 = TCCR2 | 0x02
#define  CS2_CK32			 TCCR2 = TCCR2 | 0x03
#define  CS2_CK64			 TCCR2 = TCCR2 | 0x04
#define  CS2_CK128			 TCCR2 = TCCR2 | 0x05
#define  CS2_CK256			 TCCR2 = TCCR2 | 0x06
#define  CS2_CK1024			 TCCR2 = TCCR2 | 0x07

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Timer/Counter3 Control Register - TCCR3A, TCCR3B, TCCR3C     */
/******************************************************************************/
//TCCR3A
//BIT7,6   : COM3A1, COM3A0, Compare Output Mode
//BIT5,4   : COM3B1, COM3B0, Compare Output Mode
//BIT3,2   : COM3C1, COM3C0, Compare Output Mode
//BIT1,0   : WGM31, WGM30, Waveform Generation Mode
//TCCR1B
//BIT7     : ICNC3, Input Capture Noise Canceler
//BIT6	   : ICES3, Input Capture Edge Select
//BIT5     : Not Use!
//BIT4,3   : WGM33, WGM31, Waveform Generation Mode
//BIT2,1,0 : Clock Select Bits 2,1 & 0
//TCCR1C
//BIT7     : FOC3A, Force Ouput Compare
//BIT6     : FOC3B, Force Ouput Compare
//BIT5     : FOC3C, Force Ouput Compare
//BIT4,3,2,1,0: Not Use!

#define  TCCR3A_Init		 TCCR3A  = 0x00
#define  TCCR3B_Init		 TCCR3B  = 0x00
#define  TCCR3C_Init		 TCCR3C  = 0x00

#define  COM3A_TIMER		 TCCR3A = TCCR3A | 0x00  
#define  COM3A_TOGGLE		 TCCR3A = TCCR3A | 0x40 
#define  COM3A_CLEAR		 TCCR3A = TCCR3A | 0x80 
#define  COM3A_SET			 TCCR3A = TCCR3A | 0xC0 

#define  COM3B_TIMER		 TCCR3A = TCCR3A | 0x00  
#define  COM3B_TOGGLE		 TCCR3A = TCCR3A | 0x10 
#define  COM3B_CLEAR		 TCCR3A = TCCR3A | 0x20 
#define  COM3B_SET			 TCCR3A = TCCR3A | 0x30 

#define  COM3C_TIMER		 TCCR3A = TCCR3A | 0x00  
#define  COM3C_TOGGLE		 TCCR3A = TCCR3A | 0x04 
#define  COM3C_CLEAR		 TCCR3A = TCCR3A | 0x08 
#define  COM3C_SET			 TCCR3A = TCCR3A | 0x0C 

#define  WGM3_NORMAL		 TCCR3A = TCCR3A | 0x00; TCCR3B = TCCR3B | 0x00; 
#define  WGM3_PWM_8Bit		 TCCR3A = TCCR3A | 0x01; TCCR3B = TCCR3B | 0x00;
#define  WGM3_PWM_9Bit		 TCCR3A = TCCR3A | 0x02; TCCR3B = TCCR3B | 0x00;
#define  WGM3_PWM_10Bit		 TCCR3A = TCCR3A | 0x03; TCCR3B = TCCR3B | 0x00;
#define  WGM3_CTC1			 TCCR3A = TCCR3A | 0x00; TCCR3B = TCCR3B | 0x08;
#define  WGM3_FAST_PWM_8BIT	 TCCR3A = TCCR3A | 0x01; TCCR3B = TCCR3B | 0x08;
#define  WGM3_FAST_PWM_9BIT	 TCCR3A = TCCR3A | 0x02; TCCR3B = TCCR3B | 0x08;
#define  WGM3_FAST_PWM_10BIT TCCR3A = TCCR3A | 0x03; TCCR3B = TCCR3B | 0x08;
#define  WGM3_PWM_FREQ1		 TCCR3A = TCCR3A | 0x00; TCCR3B = TCCR3B | 0x10;
#define  WGM3_PWM_FREQ2		 TCCR3A = TCCR3A | 0x01; TCCR3B = TCCR3B | 0x10;
#define  WGM3_PWM_CORRECT1	 TCCR3A = TCCR3A | 0x02; TCCR3B = TCCR3B | 0x10;
#define  WGM3_PWM_CORRECT2	 TCCR3A = TCCR3A | 0x03; TCCR3B = TCCR3B | 0x10;
#define  WGM3_CTC2			 TCCR3A = TCCR3A | 0x00; TCCR3B = TCCR3B | 0x18;
#define  WGM3_RESERVED		 TCCR3A = TCCR3A | 0x01; TCCR3B = TCCR3B | 0x18;
#define  WGM3_FAST_PWM1		 TCCR3A = TCCR3A | 0x02; TCCR3B = TCCR3B | 0x18;
#define  WGM3_FAST_PWM2		 TCCR3A = TCCR3A | 0x03; TCCR3B = TCCR3B | 0x18;

#define  ICNC3_DISABLE	 	 TCCR3B = TCCR3B & ~BIT7
#define  ICNC3_ENABLE	  	 TCCR3B = TCCR3B |  BIT7
#define  ICES3_FALLING	  	 TCCR3B = TCCR3B & ~BIT6
#define  ICES3_RISING	  	 TCCR3B = TCCR3B |  BIT6

#define  CS3_STOP			 TCCR3B = TCCR3B | 0x00
#define  CS3_CK				 TCCR3B = TCCR3B | 0x01
#define  CS3_CK8			 TCCR3B = TCCR3B | 0x02
#define  CS3_CK64			 TCCR3B = TCCR3B | 0x03
#define  CS3_CK256			 TCCR3B = TCCR3B | 0x04
#define  CS3_CK1024			 TCCR3B = TCCR3B | 0x05
#define  CS3_EX_FALLING		 TCCR3B = TCCR3B | 0x06
#define  CS3_EX_RISING		 TCCR3B = TCCR3B | 0x07

#define  FOC3A_LOW		  	 TCCR3C = TCCR3C & ~BIT7
#define  FOC3A_HIGH		  	 TCCR3C = TCCR3C |  BIT7
#define  FOC3B_LOW		  	 TCCR3C = TCCR3C & ~BIT6
#define  FOC3B_HIGH		  	 TCCR3C = TCCR3C |  BIT6
#define  FOC3C_LOW		  	 TCCR3C = TCCR3C & ~BIT5
#define  FOC3C_HIGH		  	 TCCR3C = TCCR3C |  BIT5

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Port-A                                                       */
/******************************************************************************/
//PA0 : 1, 0, Output (LCD, data D0)
//PA1 : 1, 0, Output (LCD, data D1)
//PA2 : 1, 0, Output (LCD, data D2)
//PA3 : 1, 0, Output (LCD, data D3)
//PA4 : 1, 0, Output (LCD, data D4)
//PA5 : 1, 0, Output (LCD, data D5)
//PA6 : 1, 0, Output (LCD, data D6)
//PA7 : 1, 0, Output (LCD, data D7)


#define	 DDRA_Init		 	 DDRA  = 0xFF  
#define	 PORTA_Init			 PORTA = 0x00 

#define  LCD_D0				 (PINA & BIT0)
#define  LCD_D1				 (PINA & BIT1)
#define  LCD_D2				 (PINA & BIT2)
#define  LCD_D3				 (PINA & BIT3)
#define  LCD_D4				 (PINA & BIT4)
#define  LCD_D5				 (PINA & BIT5)
#define  LCD_D6				 (PINA & BIT6)
#define  LCD_D7				 (PINA & BIT7)

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Port-B                                                       */
/******************************************************************************/
//PB0 : 0, 1, Output (LCD Light adj)
//PB1 : 0, 1, Output (LCD Cammand Signal)
//PB2 : 1, 1, Output (LCD Read/Write Signal) 
//PB3 : 1, 1, Output (LCD Enable) 
//PB4 : 1, 0, Input  (KEY1 Input)
//PB5 : 1, 0, Input  (KEY2 Input)
//PB6 : 1, 0, Input  (KEY3 Input)
//PB7 : 0, 1, Input  (KEY4 Input)
 
#define	 DDRB_Init		 	 DDRB  = 0xFF
#define	 PORTB_Init			 PORTB = 0xFF

//#define	 LED_TRIGER_ON 		 PORTB = PORTB & ~BIT0
//#define	 LED_TRIGER_OFF 	 PORTB = PORTB |  BIT0
#define  LCD_RESET		   PORTB = PORTB & ~BIT0
#define	 LCD_CMD 		   PORTB = PORTB & ~BIT1
#define	 LCD_DATA 		   PORTB = PORTB |  BIT1
#define	 LCD_WRITE 		   PORTB = PORTB & ~BIT2
#define	 LCD_READ 		   PORTB = PORTB |  BIT2
#define	 LCD_DISENABLE 	   PORTB = PORTB & ~BIT3
#define	 LCD_ENABLE 	   PORTB = PORTB |  BIT3
#define  KEY1			   (PINB & BIT4)
#define  KEY2			   (PINB & BIT5)
#define  KEY3			   (PINB & BIT6)
#define  KEY4			   (PINB & BIT7)


////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Port-C                                                       */
/******************************************************************************/
//PC0 : 1, 0, Output (Reserve)
//PC1 : 1, 0, Output (Reserve)
//PC2 : 1, 0, Output (Reserve)
//PC3 : 1, 0, Output (Reserve)
//PC4 : 1, 0, Output (Reserve)
//PC5 : 1, 0, Output (Reserve)
//PC6 : 1, 0, Output (Reserve)
//PC7 : 1, 0, Output (Reserve)
// LED define
#define	 DDRC_Init		 	   DDRC  = 0xFF 
#define	 PORTC_Init			   PORTC = 0xFF
#define  LED_Zig_ON            PORTC = PORTC & ~BIT0
#define  LED_Zig_OFF           PORTC = PORTC |  BIT0
#define  LED_3150_ON           PORTC = PORTC & ~BIT1
#define  LED_3150_OFF          PORTC = PORTC |  BIT1
#define  LED_DATAMATCH_ON      PORTC = PORTC & ~BIT2
#define  LED_DATAMATCH_OFF     PORTC = PORTC |  BIT2
#define  LED_IRSEN_ON          PORTC = PORTC & ~BIT3
#define  LED_IRSEN_OFF         PORTC = PORTC |  BIT3
#define  LED_50TOAVR_ON        PORTC = PORTC & ~BIT4
#define  LED_50TOAVR_OFF       PORTC = PORTC |  BIT4

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Port-D                                                       */
/******************************************************************************/
//PD0 : 1, 0, Output  (Reserve)
//PD1 : 1, 0, Output  (Reserve)
//PD2 : 1, 0, Input   (RXD1, RS422 Recive Data)
//PD3 : 1, 1, Output  (TXD1, RS422 Transmite Data)
//PD4 : 1, 0, Output  (Reserve)
//PD5 : 1, 0, Output  (Reserve)
//PD6 : 1, 0, Output  (Reserve)
//PD7 : 1, 0, Output  (Reserve)
 
#define	 DDRD_Init		 	 DDRD  = 0x8B 
#define	 PORTD_Init			 PORTD = 0xFF

#define  KEY6			   (PIND & BIT4)
#define  KEY7			   (PIND & BIT5)
#define  KEY8			   (PIND & BIT6)



////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Port-E                                                       */
/******************************************************************************/
//PE0 : 1, 0, Input  (RXD0, RS232 Recive Data)
//PE1 : 1, 1, Output (TXD0, RS232 Transmite Data)
//PE2 : 1, 1, Output (LED223, Serial RS232 LED On/Off Signal)
//PE3 : 1, 1, Output (LED422, Seria; RS422 LED On/Off Signal)
//PE4 : 1, 0, Output (LED1, Status LED1 On/Off Signal)
//PE5 : 1, 0, Output (LED2, Status LED2 On/Off Signal)
//PE6 : 1, 0, Output (Reserve)
//PE7 : 1, 0, Output (Reserve)

#define	 DDRE_Init		 	 DDRE  = 0xFE
#define	 PORTE_Init			 PORTE = 0xFF 



////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Port-F                                                       */
/******************************************************************************/
//PF0 : 1, 0, Output (LCD, LCD Chip Select 1)
//PF1 : 1, 0, Output (LCD, LCD Chip Select 2)
//PF2 : 1, 0, Output (LCD, LCD Reset)
//PF3 : 1, 0, Output (Reserve)
//PF4 : 0, 0, JTAG Mode (TCK)
//PF5 : 0, 0, JTAG Mode (TMS)
//PF6 : 0, 0, JTAG Mode (TDO)
//PF7 : 0, 0, JTAG Mode (TDI)

#define	 DDRF_Init		 	 DDRF  = 0x03
#define	 PORTF_Init			 PORTF = 0xF0 

#define  LCD_CS1_ON			 PORTF = PORTF |  BIT0
#define  LCD_CS1_OFF		 PORTF = PORTF & ~BIT0
#define  LCD_CS2_ON			 PORTF = PORTF |  BIT1
#define  LCD_CS2_OFF 		 PORTF = PORTF & ~BIT1
//#define  LCD_RESET			 PORTF = PORTF & ~BIT2


////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Port-G                                                       */
/******************************************************************************/
//PG0 : 1, 0, Output (Not Used!!) 
//PG1 : 1, 0, Output (Not Used!!)
//PG2 : 1, 0, Output (Not Used!!)
//PG3 : 1, 1, Input  (KEY5 Input)
//PG4 : 1, 1, Output (Not Used!!)
//PG5 : 0, 0, Do not exist!!
//PG6 : 0, 0, Do not exist!!
//PG7 : 0, 0, Do not exist!!

#define	 DDRG_Init		 	 DDRG  = 0x17 
#define	 PORTG_Init			 PORTG = 0x08

#define  KEY5				 (PING & BIT3)

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Softwear Version                                             */
/******************************************************************************/
BYTE m_VERSION[21]="Zigbee MainBoard V1.0";

////////////////////////////////////////////////////////////////////////////////
/******************************************************************************/
/*  DESCRIPTION :Internal SRAM Define                                         */
/******************************************************************************/
BYTE UART0_TX_DATA[50], UART1_TX_DATA[50];
BYTE UART0_RX_DATA[50], UART1_RX_DATA[50];
BYTE UART0_RX_Count, 	UART1_RX_Count;
BYTE UART0_RX_Flag, 	UART1_RX_Flag;
BYTE UART_RX_FL;
BYTE KEY_Flag;
BYTE HEX_DIS[10];
WORD ADC_DATAS;
BYTE adc_flagg;
BYTE TIME_flag;
BYTE TIME3_flag;
BYTE RFID_COUNT;
BYTE IRSEND;
BYTE SW_STATE1;
BYTE SW_STATE2;
WORD T_COUNT;


const char ID_VALUE1[5] = {0x14 , 0x4B, 0xF4 , 0xEE , 0x45};
const char ID_VALUE2[5] = {0x54 , 0xC7, 0x1F , 0xC6 , 0x4A};

#define STX			0x02
#define ETX			0x03 
#define ID_OK		0x33 
#define ID_FAIL		0x66 
#define IR_OK		0x55
#define IR_NO		0x77
#define RFID		0xA1
#define IRSEN		0xA2
#define SW1         0xA3
#define SW2         0xA4
#define S_ON        0xD0
#define S_OFF       0xDD
#define GAS         0xE0
#define CDS         0xE1
#define TEMP        0xE2








////////////////////////////////////////////////////////////////////////////////

