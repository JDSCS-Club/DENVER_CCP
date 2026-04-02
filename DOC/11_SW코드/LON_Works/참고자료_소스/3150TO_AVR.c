
#include <iom128v.h>
#include <macros.h>
#include <string.h>
#include "AVR128.h"
#include "lcd128.h"


void port_init(void)
{
 PORTA_Init;
 DDRA_Init;
 PORTB_Init;
 DDRB_Init; 
 PORTC_Init;
 DDRC_Init;
 PORTD_Init;
 DDRD_Init;
 PORTE_Init;
 DDRE_Init;
 PORTF_Init;
 DDRF_Init;
 
 
}




void Uart0_init(void)
{
UCSR0B = 0x00; //disable while setting baud rate
UCSR0A = 0x00;
UCSR0C = 0x06;
UBRR0L = 0x2F; //set baud rate lo 9600
UBRR0H = 0x00; //set baud rate hi
UCSR0B = 0x98;
}



void Uart1_init(void)
{
 UCSR1B = 0x00; //disable while setting baud rate
 UCSR1A = 0x00;
 UCSR1C = 0x06;
 UBRR1L = 0x2F; //set baud rate lo 9600
 UBRR1H = 0x00; //set baud rate hi
 UCSR1B = 0x98;
}

#pragma interrupt_handler Uart0_rx_Interrupt:19
void Uart0_rx_Interrupt(void)
{
 //uart has received a character in UDR
UART0_RX_DATA[UART0_RX_Count] = UDR0;
   if(UART0_RX_DATA[0] == STX)
   {
	UART0_RX_Count++;
	switch(UART0_RX_Count)
	{
		case 1: LED_50TOAVR_ON;//LED232_ON; 
			break;
		case 5: LED_50TOAVR_OFF;UART0_RX_Flag = ON; UART0_RX_Count = 0;
			break;
	}
   }
   else UART0_RX_Count = 0;
	
}


#pragma interrupt_handler adc_isr:22
void adc_isr(void)
{
 //conversion complete, read value (int) using...
  ADC_DATAS = ADC;
  adc_flagg = ON;
} 

#pragma interrupt_handler timer1_ovf_isr:15
void timer1_ovf_isr(void)
{
 //TIMER1 has overflowed
 TCNT1H = 0x00; //reload counter high value
 TCNT1L = 0x01; //reload counter low value
 TIME_flag = ON;
 
}

#pragma interrupt_handler timer3_ovf_isr:30
void timer3_ovf_isr(void)
{
 //TIMER3 has overflowed
 TCNT3H = 0x1F; //reload counter high value
 TCNT3L = 0x01; //reload counter low value
 TIME3_flag =ON;
}


#pragma interrupt_handler Uart1_rx_Interrupt:31
void Uart1_rx_Interrupt(void)
{
 //uart has received a character in UDR
 UART1_RX_DATA[UART1_RX_Count] = UDR1;
 
 if (UART1_RX_DATA[0] == STX)
 {
 	UART1_RX_Count++;
 	switch(UART1_RX_Count)
 	{
 		case 1: LED_Zig_ON;
 			    break;
		case 8: UART_RX_FL = ON;//if(UART1_RX_DATA[3] == 0xF0)
		            // UART1_RX_Count = 0;	
			    break;	
 		case 10:LED_Zig_OFF; UART1_RX_Flag = ON; UART1_RX_Count = 0;
 			    break;
 	}
 }
 else UART1_RX_Count = 0; 
}

void Uart0_TX_byte(unsigned char c)
{
 UDR0 = c;
 while(!(UCSR0A & (1<<UDRE0)));
 UCSR0A |= (1<<UDRE0);
}

void Uart0_TX_bytes(unsigned char Num)
 {
 BYTE C;
 LED_3150_ON;
 for(C=0; C<Num; C++) Uart0_TX_byte(UART0_TX_DATA[C]);
 LED_3150_OFF; 
 }

void Uart1_TX_byte(unsigned char c)
 {
 UDR1 = c;
 while(!(UCSR1A & (1<<UDRE1)));
 UCSR1A |= (1<<UDRE1);
 }

void Uart1_TX_bytes(unsigned char Num)
 {
 BYTE C;
 //LED422_ON;
 for(C=0; C<Num; C++) Uart1_TX_bytes(UART1_TX_DATA[C]);
 //LED422_OFF;
 }


void adc_init(void)
{
 ADCSRA = 0x00; //disable adc
 ADMUX = 0x00; //select adc input 0 
 ADCSRA = 0x00;
}
 
ADC_PROCESS(void)
{
    WORD TEMP_DATA = 0x0000;
	BYTE IRD;
	//LED_3150_ON;
    ADCSRA = 0x9E;     
    ADMUX = 0x42;
    SEI();     
    adc_flagg = OFF;
    ADCSRA|=0x40;     
    while(!(adc_flagg));
    ADCSRA&=0xBF;  
    CLI();
	TEMP_DATA = ADC_DATAS & 0x03FF;
    IRD = TEMP_DATA >> 2; 
	ADCSRA = 0x00;	
	//LED_IRSEN_ON;
	SEI();
	return IRD;
    
}

void KEY_Scan(void)
{
 	int delay;
	
	
	if(!(KEY1))
	{ 
	    
		for( delay = 0; delay <10000; delay++) asm("NOP");
		if(!(KEY1)) KEY_Flag = 1;
		while(!(KEY1)) asm("NOP");
		
	}
	else if(!(KEY2))
	{
	   
		for(delay=0; delay<10000; delay++) asm("NOP");
		if(!(KEY2)) KEY_Flag = 2;
		while(!(KEY2)) asm("NOP");
		
	}	
	/**
	else if(!(KEY3)) 
	{
	    
		for(delay=0; delay<10000; delay++) asm("NOP");
		if(!(KEY3)) KEY_Flag = 3;
		while(!(KEY3)) asm("NOP");
		
	}
	else if(!(KEY4))
	{
		
		for(delay=0; delay<10000; delay++) asm("NOP");
		if(!(KEY4)) KEY_Flag = 4;
		while(!(KEY4)) asm("NOP");
		
	}
	else if(!(KEY5))
	{
		
		for(delay=0; delay<10000; delay++) asm("NOP");
		if(!(KEY5)) KEY_Flag = 5;
		while(!(KEY5)) asm("NOP");
		
	}
	***/
	else KEY_Flag = 0;
}

void KEY1_Function()
{
    //clear(CS1+CS2);
 	goline(7);
	Sput("KEY 1 PUSH");
	if(SW_STATE1 == OFF)
	   {
	   UART0_TX_DATA[2] = S_ON;
	   SW_STATE1 = ON;
	   }
	else
	   {
	   UART0_TX_DATA[2] = S_OFF; 
	   SW_STATE1 = OFF;
	   }
	UART0_TX_DATA[1] = SW1;	
	//UART0_TX_DATA[2] = S_ON;	
	Uart0_TX_bytes(4);
	
	
}

void KEY2_Function()
{
    //clear(CS1+CS2);
 	goline(7);
	Sput("KEY 2 PUSH");
	if(SW_STATE2 == OFF)
	   {
	   UART0_TX_DATA[2] = S_ON;
	   SW_STATE2 = ON;
	   }
	else
	   {
	   UART0_TX_DATA[2] = S_OFF; 
	   SW_STATE2 = OFF;
	   }
	UART0_TX_DATA[1] = SW2;	
	//UART0_TX_DATA[2] = S_ON;	
	Uart0_TX_bytes(4);
	
}
/***
void KEY3_Function()
{
 	goline(0);
	Sput("KEY 3 PUSH");	
}

void KEY4_Function()
{
 	goline(0);
	Sput("KEY 4 PUSH");
}

void KEY5_Function()
{
 	goline(0);
	Sput("KEY 5 PUSH");
}
***/
void KEY_Function(void)
{
	switch(KEY_Flag)
	{
	case 1:  KEY1_Function(); KEY_Flag = 0;
		break;
	case 2:  KEY2_Function(); KEY_Flag = 0;
		break;
	/***
	case 3: clear(CS1+CS2); KEY3_Function(); KEY_Flag = 0;
		break;
	case 4: clear(CS1+CS2); KEY4_Function(); KEY_Flag = 0;
		break;
	case 5: clear(CS1+CS2); KEY5_Function(); KEY_Flag = 0;
		break;
	**/	
	case 0: KEY_Flag = 0;
		break;			
	}
} 

void LEVEL_CONVERT(BYTE LEVEL_V)
{
 BYTE LEVEL;
 goline(6);
if(LEVEL_V>= 200)
      Sput("LIGHT LEVEL 15");
    else if(LEVEL_V >=190 && LEVEL_V < 200)
	        Sput("LIGHT LEVEL 14");           
    else if(LEVEL_V >=180 && LEVEL_V < 190)
            Sput("LIGHT LEVEL 13");  
    else if(LEVEL_V >=170 && LEVEL_V < 180)
            Sput("LIGHT LEVEL 12");  
    else if(LEVEL_V >=160 && LEVEL_V < 170)
            Sput("LIGHT LEVEL 11"); 
    else if(LEVEL_V >=150 && LEVEL_V < 160)
            Sput("LIGHT LEVEL 10"); 
    else if(LEVEL_V >=140 && LEVEL_V < 150)
            Sput("LIGHT LEVEL  9");        
    else if(LEVEL_V >=130 && LEVEL_V < 140)
            Sput("LIGHT LEVEL  8"); 
    else if(LEVEL_V >=120 && LEVEL_V < 130)
            Sput("LIGHT LEVEL  7"); 
    else if(LEVEL_V >=110 && LEVEL_V < 120)
            Sput("LIGHT LEVEL  6");  
    else if(LEVEL_V >=100 && LEVEL_V < 110)
            Sput("LIGHT LEVEL  5");     
    else if(LEVEL_V >=90 && LEVEL_V < 100)
            Sput("LIGHT LEVEL  4");     
    else if(LEVEL_V >=80 && LEVEL_V  < 90)
            Sput("LIGHT LEVEL  3");                 
    else if(LEVEL_V >=70 && LEVEL_V < 80)
            Sput("LIGHT LEVEL  2");        
    else if(LEVEL_V >=60 && LEVEL_V < 70)
            Sput("LIGHT LEVEL  1");   
    else if(LEVEL_V >=50 && LEVEL_V < 60)
            Sput("LIGHT LEVEL  0");   
    
}
 
DATA_IDENTIFY(void)
{
BYTE TEMP1 = ID_OK;
BYTE TEMP2 = ID_OK;

if(UART1_RX_DATA[3] == 0x0F)
	    {
		BYTE i;		
		
	    for(i=0;i<5;i++)
	       {		   
		   if(ID_VALUE1[i] != UART1_RX_DATA[i+4])		      
		      {TEMP1 = ID_FAIL;LED_Zig_OFF;} 		      	     
		   }		
		
	    for(i=0;i<5;i++)
	       {
		   if(ID_VALUE2[i] != UART1_RX_DATA[i+4])		      
		      TEMP2 = ID_FAIL;   
		   }	
		
	    if(TEMP1 == ID_FAIL )
	       {  
		   if(TEMP2 == ID_FAIL )
		       {
	           goline(3);
               Sput("DATA FAIL");
			   return ID_FAIL;
	           }
		   else
		       { 
		       goline(3);
               Sput("DATA OK  ");
			   return ID_OK;			 
		       }	
		   }   	   
	    else if(TEMP1 == ID_OK)	    
		   {	
		     goline(3);
             Sput("DATA OK  ");
			 return ID_OK;
		   }
		
	    }	

}



void init_devices(void)
{
 //stop errant interrupts until set up
 CLI(); //disable all interrupts
 XDIV  = 0x00; //xtal divider
 XMCRA = 0x00; //external memory
 port_init();
 Uart0_init();  //38400
 Uart1_init();  //38400
 adc_init();
 UART0_RX_Flag = UART1_RX_Flag = OFF;
 UART1_RX_Count = UART1_RX_Count = 0; 
 UART_RX_FL = OFF;
 UART0_TX_DATA[0]= STX;
 UART0_TX_DATA[3]= ETX;
 adc_flagg = OFF;
 TIME_flag = OFF;
 TIME3_flag = OFF;
 T_COUNT = 0;
 RFID_COUNT =0;
 SW_STATE1 = OFF;
 SW_STATE2 = OFF;

 MCUCR = 0x00;
 EICRA = 0x00; //extended ext ints
 EICRB = 0x00; //extended ext ints
 EIMSK = 0x00;
 TIMSK = 0x00; //timer interrupt sources
 ETIMSK = 0x00; //extended timer interrupt sources 
 SEI(); //re-enable interrupts
 //all peripherals are now initialized
 
 
}









void main(void)
{
int count;


init_devices();
//LCD_en();



LED_Zig_ON;
LED_3150_ON;
for(count=0; count <10000; count++) asm("NOP");

LCD_en();

goline(0);
Sput("PL3150 TO AVR");

LED_Zig_OFF;
LED_3150_OFF;

TCCR1B = 0x00; //stop
TCNT1H = 0x00; //reload counter high value
TCNT1L = 0x01; //reload counter low value
TCCR1B = 0x04; //start Timer
TIMSK  = 0x04; // Timer 1 인터럽트시작. 

while(1)
{
 KEY_Scan();
 KEY_Function();

if(UART1_RX_Flag)
 	{	
	//CLI(); //disable all interrupts
	UART1_RX_Flag = OFF;
	
	//clear(CS1+CS2);
	goline(2);
    Sput("RFID RECEVE    ");
	
	UART0_TX_DATA[2] = DATA_IDENTIFY();	
	
	if(UART0_TX_DATA[2]==ID_OK)
	   LED_DATAMATCH_ON;
	else
	  LED_DATAMATCH_OFF; 
	  UART0_TX_DATA[1]= RFID;  
	  Uart0_TX_bytes(4);
    TCCR3B = 0x00; //stop
    TCNT3H = 0x1F; //setup
    TCNT3L = 0x01;
    TCCR3A = 0x00;
    TCCR3B = 0x04; //start Timer
	  ETIMSK = 0x04;
	  SEI(); //re-enable interrupts 
	     
 	}
	
if(UART_RX_FL)
  {
  UART_RX_FL = OFF;
  if(UART1_RX_DATA[3] == 0xF0)
    {	
	UART1_RX_Count = 0;
	goline(2);
    Sput("RFID ID RECEVE");
	}
  }  
  	
if(UART0_RX_Flag)
  {
  WORD TEMP_VALUE; 
    
  UART0_RX_Flag = OFF;
  
  switch(UART0_RX_DATA[1])
     {	 
	 case GAS : if(UART0_RX_DATA[2] >= 25)
	                {
	                goline(4);
                    Sput("GAS SENSING");
					}
				 else
				   	{
	                goline(4);
                    Sput("GAS NO SENSING");
					}
				 break;				 
	 case TEMP : TEMP_VALUE = UART0_RX_DATA[3];
	             TEMP_VALUE |= (unsigned int)UART0_RX_DATA[2] <<8;					 
				 if(TEMP_VALUE >= 130)
				    {	 	
					goline(5);
                    Sput("TEMP UP AIRCON ON ");
					}
			     else
				    {	 	
					goline(5);
                    Sput("TEMP DW AIRCON OFF");
					}	
		         break;			
	 case CDS : LEVEL_CONVERT(UART0_RX_DATA[2]);
	             break;
	 
	 }					
  
  }
if(TIME3_flag)
  {
  TIME3_flag = OFF;
  RFID_COUNT++; 
  if(RFID_COUNT >= 2)
      {
	  TCCR3B = 0x00;
	  ETIMSK = 0x00;
	  RFID_COUNT = 0;
	  UART0_TX_DATA[1]= RFID; 
	  UART0_TX_DATA[2]= ID_FAIL;  
	  Uart0_TX_bytes(4);
    LED_DATAMATCH_OFF;	  
	  }
   }  
	
if(TIME_flag == ON)
  { 
  T_COUNT++;
  TIME_flag = 0;
  //if(T_COUNT >= 1)
  //   {
	 
	 TCCR1B = 0x00; //stop
	 //LED_Zig_ON;
	 T_COUNT = 0; TIME_flag = OFF; 
   IRSEND = ADC_PROCESS();	 
	 if(IRSEND >= 30)
	    {		
		  //clear(CS1+CS2);	    
	    LED_IRSEN_ON;
		  goline(1);
      Sput("IR SENSING");
		  UART0_TX_DATA[0] = STX;
		  UART0_TX_DATA[1] = IRSEN;        
		  UART0_TX_DATA[2] = IR_OK;
		  UART0_TX_DATA[3] = ETX;		
	    Uart0_TX_bytes(4);	
		  }
     else
	    {
		goline(1);
    Sput("           ");
	  LED_IRSEN_OFF;	
		UART0_TX_DATA[0] = STX;
		UART0_TX_DATA[1] = IRSEN;        
		UART0_TX_DATA[2] = IR_NO;
		UART0_TX_DATA[3] = ETX;		
	  Uart0_TX_bytes(4);	
		}	
	 //TCNT1H = 0x02; //reload counter high value
   //TCNT1L = 0x01;		 
	 TCCR1B = 0x04; 
	 //LED_Zig_OFF; 
	 //LED_3150_OFF;
   //  }
  }	 
    



}




}
