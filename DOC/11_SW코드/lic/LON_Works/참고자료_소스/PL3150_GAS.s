	.module PL3150_GAS.c
	.area text(rom, con, rel)
	.dbfile E:\FW\HN_Device\GAS_ATMEGA8\PL3150_GAS.c
	.dbfunc e port_init _port_init fV
	.even
_port_init::
	.dbline -1
	.dbline 71
; //ICC-AVR application builder : 2006-11-07 오전 11:49:23
; // Target : M8
; // Crystal: 8.0000Mhz
; 
; #include <iom8v.h>
; #include <macros.h>
; 
; typedef unsigned char 	BYTE;
; typedef unsigned int 	WORD;
; typedef unsigned long 	DWORD;
; 
; #define	BIT0	0x01																																																						
; #define	BIT1	0x02																																																						
; #define	BIT2	0x04																																																						
; #define	BIT3	0x08																																																						
; #define	BIT4	0x10																																																						
; #define	BIT5	0x20																																																						
; #define	BIT6	0x40																																																						
; #define	BIT7	0x80		
; 
; #define LEVEL0     0x00
; #define LEVEL1     0x01
; 
; #define LEVEL2     0x02
; #define LEVEL3     0x03
; 
; #define LEVEL4     0x04
; #define LEVEL5     0x05
; #define LEVEL6     0x06
; #define LEVEL7     0x07
; #define LEVEL8     0x08
; #define LEVEL9     0x09
; #define LEVEL10    0x0A
; #define LEVEL11    0x0B
; #define LEVEL12    0x0C
; 
; #define LEVEL13    0x0D
; #define LEVEL14    0x0E
; #define LEVEL15    0x0F
; #define LEVEL16    0x1F
; #define LEVEL17    0x3F
; #define LEVEL18    0x7F
; #define LEVEL19    0xFF		
; 
; #define  GAS    0xE0
; #define  CDS    0xE1
; #define  TEMP   0xE2	
; 
; 
; #define	 GAS_SEN_DIS 	  PORTC = PORTC & ~BIT1
; #define	 GAS_SEN_EN       PORTC = PORTC |  BIT1
; 
; #define	 LED_ON 	   PORTD = PORTD & ~BIT5
; #define	 LED_OFF       PORTD = PORTD |  BIT5
; 
; BYTE  flag ;
; BYTE  flagg;
; BYTE  ADC_DATA[7];
; WORD  ADC_DATAS;
; BYTE  T_COUNT;
; BYTE  CDS_DATA;
; BYTE  GAS_DATA;
; BYTE  TEMPER_DATA;
; BYTE  TEMP_HIGH;
; BYTE  TEMP_LOW;
; BYTE  NO_COUNT;
; BYTE  ADC_COUNT;
; 
; 
; void port_init(void)
; {
	.dbline 72
;  PORTB = 0xFF;
	ldi R24,255
	out 0x18,R24
	.dbline 73
;  DDRB  = 0x07;
	ldi R24,7
	out 0x17,R24
	.dbline 74
;  PORTC = 0x7F; //m103 output only
	ldi R24,127
	out 0x15,R24
	.dbline 75
;  DDRC  = 0x32;
	ldi R24,50
	out 0x14,R24
	.dbline 76
;  PORTD = 0xFF;
	ldi R24,255
	out 0x12,R24
	.dbline 77
;  DDRD  = 0xFE;
	ldi R24,254
	out 0x11,R24
	.dbline -2
	.dbline 78
; }
L1:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e timer1_init _timer1_init fV
	.even
_timer1_init::
	.dbline -1
	.dbline 85
; 
; //TIMER1 initialisation - prescale:1024
; // WGM: 0) Normal, TOP=0xFFFF
; // desired value: 1Sec
; // actual value:  1.000Sec (0.0%)
; void timer1_init(void)
; {
	.dbline 86
;  TCCR1B = 0x00; //stop
	clr R2
	out 0x2e,R2
	.dbline 87
;  TCNT1H = 0xCF; //reload counter high value
	ldi R24,207
	out 0x2d,R24
	.dbline 88
;  TCNT1L = 0x2C; //reload counter low value
	ldi R24,44
	out 0x2c,R24
	.dbline 95
;  //OCR1AH = 0x1E;
;  //OCR1AL = 0x84;
;  //OCR1BH = 0x1E;
;  //OCR1BL = 0x84;
;  //ICR1H  = 0x1E;
;  //ICR1L  = 0x84;
;  TCCR1A = 0x00;
	out 0x2f,R2
	.dbline -2
	.dbline 97
;  //TCCR1B = 0x05; //start Timer
; }
L2:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 16
	rjmp _timer1_ovf_isr
	.area text(rom, con, rel)
	.dbfile E:\FW\HN_Device\GAS_ATMEGA8\PL3150_GAS.c
	.dbfunc e timer1_ovf_isr _timer1_ovf_isr fV
	.even
_timer1_ovf_isr::
	st -y,R24
	in R24,0x3f
	st -y,R24
	.dbline -1
	.dbline 101
; 
; #pragma interrupt_handler timer1_ovf_isr:9
; void timer1_ovf_isr(void)
; {
	.dbline 103
;  //TIMER1 has overflowed
;  TCNT1H = 0xCF; //reload counter high value
	ldi R24,207
	out 0x2d,R24
	.dbline 104
;  TCNT1L = 0x2C; //reload counter low value
	ldi R24,44
	out 0x2c,R24
	.dbline 105
;  flag = 1;
	ldi R24,1
	sts _flag,R24
	.dbline -2
	.dbline 106
; }
L3:
	ld R24,y+
	out 0x3f,R24
	ld R24,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e uart0_init _uart0_init fV
	.even
_uart0_init::
	.dbline -1
	.dbline 114
; 
; //UART0 initialisation
; // desired baud rate: 9600
; // actual: baud rate:9615 (0.2%)
; // char size: 8 bit
; // parity: Disabled
; void uart0_init(void)
; {
	.dbline 115
;  UCSRB = 0x00; //disable while setting baud rate
	clr R2
	out 0xa,R2
	.dbline 116
;  UCSRA = 0x00;
	out 0xb,R2
	.dbline 117
;  UCSRC = 0x06;
	ldi R24,6
	out 0x20,R24
	.dbline 118
;  UBRRL = 0x33; //set baud rate lo
	ldi R24,51
	out 0x9,R24
	.dbline 119
;  UBRRH = 0x00; //set baud rate hi
	out 0x20,R2
	.dbline 120
;  UCSRB = 0x98;
	ldi R24,152
	out 0xa,R24
	.dbline -2
	.dbline 121
; }
L4:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 22
	rjmp _uart0_rx_isr
	.area text(rom, con, rel)
	.dbfile E:\FW\HN_Device\GAS_ATMEGA8\PL3150_GAS.c
	.dbfunc e uart0_rx_isr _uart0_rx_isr fV
	.even
_uart0_rx_isr::
	.dbline -1
	.dbline 125
; 
; #pragma interrupt_handler uart0_rx_isr:12
; void uart0_rx_isr(void)
; {
	.dbline -2
	.dbline 127
;  //uart has received a character in UDR
; }
L5:
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e adc_init _adc_init fV
	.even
_adc_init::
	.dbline -1
	.dbline 132
; 
; //ADC initialisation
; // Conversion time: 13uS
; void adc_init(void)
; {
	.dbline 133
;  ADCSR = 0x00; //disable adc
	clr R2
	out 0x6,R2
	.dbline 134
;  ADMUX = 0x00; //select adc input 0
	out 0x7,R2
	.dbline 135
;  ACSR  = 0x80;
	ldi R24,128
	out 0x8,R24
	.dbline 136
;  ADCSR = 0x0B;
	ldi R24,11
	out 0x6,R24
	.dbline -2
	.dbline 137
; }
L6:
	.dbline 0 ; func end
	ret
	.dbend
	.area vector(rom, abs)
	.org 28
	rjmp _adc_isr
	.area text(rom, con, rel)
	.dbfile E:\FW\HN_Device\GAS_ATMEGA8\PL3150_GAS.c
	.dbfunc e adc_isr _adc_isr fV
	.even
_adc_isr::
	st -y,R2
	st -y,R3
	st -y,R24
	in R2,0x3f
	st -y,R2
	.dbline -1
	.dbline 141
; 
; #pragma interrupt_handler adc_isr:15
; void adc_isr(void)
; {
	.dbline 143
;  //conversion complete, read value (int) using...
;   ADC_DATAS = ADC;
	in R2,0x4
	in R3,0x5
	sts _ADC_DATAS+1,R3
	sts _ADC_DATAS,R2
	.dbline 144
;   flagg = 1;
	ldi R24,1
	sts _flagg,R24
	.dbline -2
	.dbline 145
; }
L7:
	ld R2,y+
	out 0x3f,R2
	ld R24,y+
	ld R3,y+
	ld R2,y+
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e ADC_CONVER _ADC_CONVER fV
;          TEP_H -> R20
;      TEMP_DATA -> R22,R23
;           COMM -> R16
	.even
_ADC_CONVER::
	rcall push_gset2
	.dbline -1
	.dbline 148
; 
; void ADC_CONVER(BYTE COMM)
; {
	.dbline 152
;     WORD  TEMP_DATA;
; 	BYTE  TEP_H;
; 	
; 	ADC_COUNT++;
	lds R24,_ADC_COUNT
	subi R24,255    ; addi 1
	sts _ADC_COUNT,R24
	.dbline 154
; 	
; 	switch(COMM)
	mov R20,R16
	clr R21
	cpi R20,224
	ldi R30,0
	cpc R21,R30
	breq L12
	cpi R20,225
	ldi R30,0
	cpc R21,R30
	breq L16
	cpi R20,226
	ldi R30,0
	cpc R21,R30
	brne X1
	rjmp L20
X1:
	rjmp L9
X0:
	.dbline 155
; 	  {
L12:
	.dbline 156
; 	  case GAS :  ADCSRA = 0x9E;     
	ldi R24,158
	out 0x6,R24
	.dbline 157
;                   ADMUX = 0x40;
	ldi R24,64
	out 0x7,R24
	.dbline 158
;                   SEI();     
	sei
	.dbline 159
;                   flagg = 0;
	clr R2
	sts _flagg,R2
	.dbline 160
;                   ADCSRA|=0x40;     
	sbi 0x6,6
L13:
	.dbline 161
L14:
	.dbline 161
;                   while(!(flagg));
	lds R2,_flagg
	tst R2
	breq L13
	.dbline 162
;                   ADCSRA&=0xBF;  
	in R24,0x6
	andi R24,191
	out 0x6,R24
	.dbline 163
;                   CLI();
	cli
	.dbline 164
; 	              TEMP_DATA = ADC_DATAS & 0x03FC;
	lds R22,_ADC_DATAS
	lds R23,_ADC_DATAS+1
	andi R22,252
	andi R23,3
	.dbline 165
;                   GAS_DATA = TEMP_DATA >> 2; 
	movw R2,R22
	lsr R3
	ror R2
	lsr R3
	ror R2
	sts _GAS_DATA,R2
	.dbline 166
; 	              ADCSRA = 0x00;
	clr R2
	out 0x6,R2
	.dbline 167
; 	              TEMP_DATA = 0x0000;	
	clr R22
	clr R23
	.dbline 168
; 			      SEI();
	sei
	.dbline 169
; 			      break;
	rjmp L10
L16:
	.dbline 170
; 	  case CDS :  ADCSRA = 0x9E;     
	ldi R24,158
	out 0x6,R24
	.dbline 171
;                   ADMUX = 0x42; // ADC 2 AD CONVERTER
	ldi R24,66
	out 0x7,R24
	.dbline 172
;                   SEI();     
	sei
	.dbline 173
;                   flagg = 0;
	clr R2
	sts _flagg,R2
	.dbline 174
;                   ADCSRA|=0x40;     
	sbi 0x6,6
L17:
	.dbline 175
L18:
	.dbline 175
;                   while(!(flagg));
	lds R2,_flagg
	tst R2
	breq L17
	.dbline 176
;                   ADCSRA&=0xBF;  
	in R24,0x6
	andi R24,191
	out 0x6,R24
	.dbline 177
;                   CLI();
	cli
	.dbline 178
; 	              TEMP_DATA = ADC_DATAS & 0x03FC;
	lds R22,_ADC_DATAS
	lds R23,_ADC_DATAS+1
	andi R22,252
	andi R23,3
	.dbline 179
;                   CDS_DATA = TEMP_DATA >> 2; 
	movw R2,R22
	lsr R3
	ror R2
	lsr R3
	ror R2
	sts _CDS_DATA,R2
	.dbline 180
; 	              ADCSRA = 0x00;	
	clr R2
	out 0x6,R2
	.dbline 181
; 	              TEMP_DATA = 0x0000;
	clr R22
	clr R23
	.dbline 182
; 	              SEI();
	sei
	.dbline 183
; 			      break;
	rjmp L10
L20:
	.dbline 184
; 	  case TEMP : ADCSRA = 0x9E;     
	ldi R24,158
	out 0x6,R24
	.dbline 185
;                   ADMUX = 0x43;
	ldi R24,67
	out 0x7,R24
	.dbline 186
;                   SEI();     
	sei
	.dbline 187
;                   flagg = 0;
	clr R2
	sts _flagg,R2
	.dbline 188
;                   ADCSRA|=0x40;     
	sbi 0x6,6
L21:
	.dbline 189
L22:
	.dbline 189
;                   while(!(flagg));
	lds R2,_flagg
	tst R2
	breq L21
	.dbline 190
;                   ADCSRA&=0xBF;  
	in R24,0x6
	andi R24,191
	out 0x6,R24
	.dbline 191
;                   CLI();
	cli
	.dbline 192
; 	              TEMP_DATA = ADC_DATAS & 0x03FF;
	lds R22,_ADC_DATAS
	lds R23,_ADC_DATAS+1
	andi R23,3
	.dbline 193
; 	              TEP_H  =  TEMP_DATA & 0x0300;
	mov R20,R22
	andi R20,0
	andi R21,3
	.dbline 194
; 	              TEMP_HIGH = TEP_H >> 8;
	mov R2,R20
	clr R3
	mov R2,R3
	clr R3
	sbrc R2,7
	com R3
	sts _TEMP_HIGH,R2
	.dbline 195
; 	              TEMP_LOW  =  TEMP_DATA & 0x00FF;	     
	movw R24,R22
	andi R25,0
	sts _TEMP_LOW,R24
	.dbline 196
; 	              ADCSRA = 0x00;
	clr R2
	out 0x6,R2
	.dbline 197
; 	              TEMP_DATA = 0x0000;	
	clr R22
	clr R23
	.dbline 198
;                   SEI();
	sei
	.dbline 199
; 			      ADC_COUNT = 0;
	sts _ADC_COUNT,R2
	.dbline 200
; 			      break;
L9:
L10:
	.dbline -2
	.dbline 202
; 	  }	   
; }
L8:
	rcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r TEP_H 20 c
	.dbsym r TEMP_DATA 22 i
	.dbsym r COMM 16 c
	.dbend
	.dbfunc e LEVEL_CONVERT _LEVEL_CONVERT fI
;          LEVEL -> R20
;        LEVEL_V -> R16
	.even
_LEVEL_CONVERT::
	rcall push_gset1
	.dbline -1
	.dbline 205
; 
; LEVEL_CONVERT(BYTE LEVEL_V)
; {
	.dbline 207
;  BYTE LEVEL;
; if(LEVEL_V>= 200)
	cpi R16,200
	brlo L25
	.dbline 208
;       LEVEL = LEVEL0;
	clr R20
	rjmp L26
L25:
	.dbline 209
;     else if(LEVEL_V >=190 && LEVEL_V < 200)
	cpi R16,190
	brlo L27
	cpi R16,200
	brsh L27
	.dbline 210
;         LEVEL = LEVEL1;    
	ldi R20,1
	rjmp L28
L27:
	.dbline 211
;     else if(LEVEL_V >=180 && LEVEL_V < 190)
	cpi R16,180
	brlo L29
	cpi R16,190
	brsh L29
	.dbline 212
;         LEVEL = LEVEL2;  
	ldi R20,2
	rjmp L30
L29:
	.dbline 213
;     else if(LEVEL_V >=170 && LEVEL_V < 180)
	cpi R16,170
	brlo L31
	cpi R16,180
	brsh L31
	.dbline 214
;         LEVEL = LEVEL3;  
	ldi R20,3
	rjmp L32
L31:
	.dbline 215
;     else if(LEVEL_V >=160 && LEVEL_V < 170)
	cpi R16,160
	brlo L33
	cpi R16,170
	brsh L33
	.dbline 216
;         LEVEL = LEVEL4;  
	ldi R20,4
	rjmp L34
L33:
	.dbline 217
;     else if(LEVEL_V >=150 && LEVEL_V < 160)
	cpi R16,150
	brlo L35
	cpi R16,160
	brsh L35
	.dbline 218
;         LEVEL = LEVEL5;
	ldi R20,5
	rjmp L36
L35:
	.dbline 219
;     else if(LEVEL_V >=140 && LEVEL_V < 150)
	cpi R16,140
	brlo L37
	cpi R16,150
	brsh L37
	.dbline 220
;         LEVEL = LEVEL6;       
	ldi R20,6
	rjmp L38
L37:
	.dbline 221
;     else if(LEVEL_V >=130 && LEVEL_V < 140)
	cpi R16,130
	brlo L39
	cpi R16,140
	brsh L39
	.dbline 222
;         LEVEL = LEVEL7; 
	ldi R20,7
	rjmp L40
L39:
	.dbline 223
;     else if(LEVEL_V >=120 && LEVEL_V < 130)
	cpi R16,120
	brlo L41
	cpi R16,130
	brsh L41
	.dbline 224
;         LEVEL = LEVEL8; 
	ldi R20,8
	rjmp L42
L41:
	.dbline 225
;     else if(LEVEL_V >=110 && LEVEL_V < 120)
	cpi R16,110
	brlo L43
	cpi R16,120
	brsh L43
	.dbline 226
;         LEVEL = LEVEL9;  
	ldi R20,9
	rjmp L44
L43:
	.dbline 227
;     else if(LEVEL_V >=100 && LEVEL_V < 110)
	cpi R16,100
	brlo L45
	cpi R16,110
	brsh L45
	.dbline 228
;         LEVEL = LEVEL10;     
	ldi R20,10
	rjmp L46
L45:
	.dbline 229
;     else if(LEVEL_V >=90 && LEVEL_V < 100)
	cpi R16,90
	brlo L47
	cpi R16,100
	brsh L47
	.dbline 230
;         LEVEL = LEVEL11;     
	ldi R20,11
	rjmp L48
L47:
	.dbline 231
;     else if(LEVEL_V >=80 && LEVEL_V  < 90)
	cpi R16,80
	brlo L49
	cpi R16,90
	brsh L49
	.dbline 232
;         LEVEL = LEVEL12;                  
	ldi R20,12
	rjmp L50
L49:
	.dbline 233
;     else if(LEVEL_V >=70 && LEVEL_V < 80)
	cpi R16,70
	brlo L51
	cpi R16,80
	brsh L51
	.dbline 234
;         LEVEL = LEVEL13;         
	ldi R20,13
	rjmp L52
L51:
	.dbline 235
;     else if(LEVEL_V >=60 && LEVEL_V < 70)
	cpi R16,60
	brlo L53
	cpi R16,70
	brsh L53
	.dbline 236
;         LEVEL = LEVEL14;   
	ldi R20,14
	rjmp L54
L53:
	.dbline 237
;     else if(LEVEL_V >=50 && LEVEL_V < 60)
	cpi R16,50
	brlo L55
	cpi R16,60
	brsh L55
	.dbline 238
;         LEVEL = LEVEL15; 
	ldi R20,15
	rjmp L56
L55:
	.dbline 239
;     else if(LEVEL_V >=40 && LEVEL_V < 50)
	cpi R16,40
	brlo L57
	cpi R16,50
	brsh L57
	.dbline 240
;         LEVEL = LEVEL16;  
	ldi R20,31
	rjmp L58
L57:
	.dbline 241
;     else if(LEVEL_V >=30 && LEVEL_V < 40)
	cpi R16,30
	brlo L59
	cpi R16,40
	brsh L59
	.dbline 242
;         LEVEL = LEVEL17;  
	ldi R20,63
	rjmp L60
L59:
	.dbline 243
;      else if(LEVEL_V >=20 && LEVEL_V < 30)
	cpi R16,20
	brlo L61
	cpi R16,30
	brsh L61
	.dbline 244
;         LEVEL = LEVEL18;                                              
	ldi R20,127
	rjmp L62
L61:
	.dbline 245
;     else if( LEVEL_V < 20)
	cpi R16,20
	brsh L63
	.dbline 246
;         LEVEL = LEVEL19;           
	ldi R20,255
L63:
L62:
L60:
L58:
L56:
L54:
L52:
L50:
L48:
L46:
L44:
L42:
L40:
L38:
L36:
L34:
L32:
L30:
L28:
L26:
	.dbline 248
; 
;     return LEVEL;
	mov R16,R20
	clr R17
	.dbline -2
L24:
	rcall pop_gset1
	.dbline 0 ; func end
	ret
	.dbsym r LEVEL 20 c
	.dbsym r LEVEL_V 16 c
	.dbend
	.dbfunc e init_devices _init_devices fV
	.even
_init_devices::
	.dbline -1
	.dbline 253
; }
; 
; //call this routine to initialise all peripherals
; void init_devices(void)
; {
	.dbline 255
;  //stop errant interrupts until set up
;  CLI(); //disable all interrupts
	cli
	.dbline 256
;  port_init();
	rcall _port_init
	.dbline 257
;  timer1_init();
	rcall _timer1_init
	.dbline 258
;  uart0_init();
	rcall _uart0_init
	.dbline 259
;  adc_init();
	rcall _adc_init
	.dbline 261
; 
;  MCUCR = 0x00;
	clr R2
	out 0x35,R2
	.dbline 262
;  GICR  = 0x00;
	out 0x3b,R2
	.dbline 263
;  TIMSK = 0x05; //timer interrupt sources
	ldi R24,5
	out 0x39,R24
	.dbline 265
;  
;  flag = 0; 
	sts _flag,R2
	.dbline 266
;  GAS_SEN_EN;
	sbi 0x15,1
	.dbline 267
;  T_COUNT = 0;
	sts _T_COUNT,R2
	.dbline 268
;  NO_COUNT = 0;
	sts _NO_COUNT,R2
	.dbline 269
;  ADC_DATA[0] = 0x02;
	ldi R24,2
	sts _ADC_DATA,R24
	.dbline 270
;  ADC_DATA[5] = 0x03;
	ldi R24,3
	sts _ADC_DATA+5,R24
	.dbline 272
;  
;  SEI(); //re-enable interrupts
	sei
	.dbline -2
	.dbline 274
;  //all peripherals are now initialised
; }
L65:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e RS232_Send_Byte _RS232_Send_Byte fV
;           DATA -> R16
	.even
_RS232_Send_Byte::
	.dbline -1
	.dbline 278
; 
; // TX 1 BYTE PROGRAM
; void RS232_Send_Byte(BYTE DATA)
;  { 	
L68:
	.dbline 280
L69:
	.dbline 280
; // PORTB = 0x00;
;  while(!(UCSRA & 0x20));
	sbis 0xb,5
	rjmp L68
	.dbline 281
;  UDR = DATA;
	out 0xc,R16
	.dbline 282
;  UCSRA |= 0x20; 
	sbi 0xb,5
	.dbline -2
	.dbline 284
;  //PORTB = 0xFF;
;  }
L67:
	.dbline 0 ; func end
	ret
	.dbsym r DATA 16 c
	.dbend
	.dbfunc e RS232_Send_Bytes _RS232_Send_Bytes fV
;              C -> R20
;            Num -> R22
	.even
_RS232_Send_Bytes::
	rcall push_gset2
	mov R22,R16
	.dbline -1
	.dbline 289
;      
; 
; // TX BYTES PGM
; void RS232_Send_Bytes(BYTE Num)
; {
	.dbline 292
	clr R20
	rjmp L75
L72:
	.dbline 292
	ldi R24,<_ADC_DATA
	ldi R25,>_ADC_DATA
	mov R30,R20
	clr R31
	add R30,R24
	adc R31,R25
	ldd R16,z+0
	rcall _RS232_Send_Byte
L73:
	.dbline 292
	inc R20
L75:
	.dbline 292
; BYTE C;
; //LED422_ON;
; for(C=0; C<Num; C++) RS232_Send_Byte(ADC_DATA[C]);  
	cp R20,R22
	brlo L72
	.dbline -2
	.dbline 294
; //LED422_OFF;
; }
L71:
	rcall pop_gset2
	.dbline 0 ; func end
	ret
	.dbsym r C 20 c
	.dbsym r Num 22 c
	.dbend
	.dbfunc e main _main fV
	.even
_main::
	.dbline -1
	.dbline 297
; 
; void main(void)
; {
	.dbline 298
; init_devices();
	rcall _init_devices
	.dbline 300
; 
; GAS_SEN_EN;
	sbi 0x15,1
	.dbline 302
; 
; TCCR1B = 0x00; //stop
	clr R2
	out 0x2e,R2
	.dbline 303
; TCNT1H = 0xCF; //reload counter high value
	ldi R24,207
	out 0x2d,R24
	.dbline 304
; TCNT1L = 0x20; //reload counter low value
	ldi R24,32
	out 0x2c,R24
	.dbline 305
; TCCR1B = 0x03; //start Timer
	ldi R24,3
	out 0x2e,R24
	.dbline 306
; TIMSK  = 0x04; // Timer 1 인터럽트시작.
	ldi R24,4
	out 0x39,R24
	.dbline 310
; 
; //RS232_Send_Bytes(4);
; 
;   for(;;)
L77:
	.dbline 311
;   {  
	.dbline 313
;   
;   if(flag == 1) 
	lds R24,_flag
	cpi R24,1
	brne L81
	.dbline 314
;     {   
	.dbline 315
; 	T_COUNT++;
	lds R24,_T_COUNT
	subi R24,255    ; addi 1
	sts _T_COUNT,R24
	.dbline 316
; 	flag =0;
	clr R2
	sts _flag,R2
	.dbline 317
;     }
L81:
	.dbline 319
;   
;   if(T_COUNT >= 6)
	lds R24,_T_COUNT
	cpi R24,6
	brlo L77
	.dbline 320
;     {	
	.dbline 321
; 	NO_COUNT++;
	lds R24,_NO_COUNT
	subi R24,255    ; addi 1
	sts _NO_COUNT,R24
	.dbline 322
; 	TCCR1B = 0x00; //stop
	clr R2
	out 0x2e,R2
	.dbline 323
; 	LED_ON;		
	cbi 0x12,5
	.dbline 324
; 	switch(NO_COUNT)
	mov R20,R24
	clr R21
	cpi R20,1
	ldi R30,0
	cpc R21,R30
	breq L88
	cpi R20,2
	ldi R30,0
	cpc R21,R30
	breq L93
	cpi R20,3
	ldi R30,0
	cpc R21,R30
	breq L98
	rjmp L85
X2:
	.dbline 325
; 	   {
L88:
	.dbline 326
; 	   case 1 : ADC_CONVER(GAS);
	ldi R16,224
	rcall _ADC_CONVER
	.dbline 327
; 	            ADC_DATA[1] = GAS;    
	ldi R24,224
	sts _ADC_DATA+1,R24
	.dbline 328
; 	            ADC_DATA[2] = GAS_DATA; 
	lds R2,_GAS_DATA
	sts _ADC_DATA+2,R2
	.dbline 329
; 	            ADC_DATA[3] = 0xFF;     
	ldi R24,255
	sts _ADC_DATA+3,R24
	.dbline 330
; 	            ADC_DATA[4] = LEVEL_CONVERT(GAS_DATA); 
	mov R16,R2
	rcall _LEVEL_CONVERT
	sts _ADC_DATA+4,R16
	.dbline 331
; 	            break;
	rjmp L86
L93:
	.dbline 332
; 	   case 2 : ADC_CONVER(CDS);	           
	ldi R16,225
	rcall _ADC_CONVER
	.dbline 333
; 	            ADC_DATA[1] = CDS;    
	ldi R24,225
	sts _ADC_DATA+1,R24
	.dbline 334
; 	            ADC_DATA[2] = CDS_DATA; 
	lds R2,_CDS_DATA
	sts _ADC_DATA+2,R2
	.dbline 335
; 	            ADC_DATA[3] = 0xFF;     
	ldi R24,255
	sts _ADC_DATA+3,R24
	.dbline 336
; 	            ADC_DATA[4] = LEVEL_CONVERT(CDS_DATA); 
	mov R16,R2
	rcall _LEVEL_CONVERT
	sts _ADC_DATA+4,R16
	.dbline 337
; 	            break;
	rjmp L86
L98:
	.dbline 338
; 	   case 3 : ADC_CONVER(TEMP);
	ldi R16,226
	rcall _ADC_CONVER
	.dbline 339
; 	            ADC_DATA[1] = TEMP;    
	ldi R24,226
	sts _ADC_DATA+1,R24
	.dbline 340
; 	            ADC_DATA[2] = TEMP_HIGH; 
	lds R2,_TEMP_HIGH
	sts _ADC_DATA+2,R2
	.dbline 341
; 	            ADC_DATA[3] = TEMP_LOW;     
	lds R2,_TEMP_LOW
	sts _ADC_DATA+3,R2
	.dbline 342
; 	            ADC_DATA[4] = 0xFF; 
	ldi R24,255
	sts _ADC_DATA+4,R24
	.dbline 343
; 				NO_COUNT = 0;
	clr R2
	sts _NO_COUNT,R2
	.dbline 344
; 	            break;		
L85:
L86:
	.dbline 347
	ldi R16,6
	rcall _RS232_Send_Bytes
	.dbline 348
	clr R2
	sts _flag,R2
	.dbline 349
	sts _T_COUNT,R2
	.dbline 350
	sbi 0x12,5
	.dbline 351
	ldi R24,3
	out 0x2e,R24
	.dbline 352
	.dbline 354
	.dbline 310
	.dbline 310
	rjmp L77
X3:
	.dbline -2
L76:
	.dbline 0 ; func end
	ret
	.dbend
	.area bss(ram, con, rel)
	.dbfile E:\FW\HN_Device\GAS_ATMEGA8\PL3150_GAS.c
_ADC_COUNT::
	.blkb 1
	.dbsym e ADC_COUNT _ADC_COUNT c
_NO_COUNT::
	.blkb 1
	.dbsym e NO_COUNT _NO_COUNT c
_TEMP_LOW::
	.blkb 1
	.dbsym e TEMP_LOW _TEMP_LOW c
_TEMP_HIGH::
	.blkb 1
	.dbsym e TEMP_HIGH _TEMP_HIGH c
_TEMPER_DATA::
	.blkb 1
	.dbsym e TEMPER_DATA _TEMPER_DATA c
_GAS_DATA::
	.blkb 1
	.dbsym e GAS_DATA _GAS_DATA c
_CDS_DATA::
	.blkb 1
	.dbsym e CDS_DATA _CDS_DATA c
_T_COUNT::
	.blkb 1
	.dbsym e T_COUNT _T_COUNT c
_ADC_DATAS::
	.blkb 2
	.dbsym e ADC_DATAS _ADC_DATAS i
_ADC_DATA::
	.blkb 7
	.dbsym e ADC_DATA _ADC_DATA A[7:7]c
_flagg::
	.blkb 1
	.dbsym e flagg _flagg c
_flag::
	.blkb 1
	.dbsym e flag _flag c

