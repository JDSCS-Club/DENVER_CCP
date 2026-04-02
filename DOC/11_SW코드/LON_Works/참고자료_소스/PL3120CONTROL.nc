#pragma num_alias_table_entries 2
#pragma specify_io_clock "10 MHz"

#include <io_types.h>	
//#include <control.h>
//#include <status.h>	
//#include <string.h>	

IO_8 sci baud(SCI_19200) iosci; 
IO_0 output bit iobuzzer = 1;

IO_3 input  bit ioButton1;

#define DATA_SIZE 13
//#define DATA_SIZEFIN 13
#define Cont_Lev1  0x01
#define Cont_Lev2  0x02
#define Cont_Lev3  0x03
#define Cont_Lev4  0x04
#define Cont_Lev5  0x05


#define LEVEL0     0x00
#define LEVEL1     0x01
#define LEVEL2     0x02
#define LEVEL3     0x03
#define LEVEL4     0x04
#define LEVEL5     0x05
#define LEVEL6     0x06
#define LEVEL7     0x07
#define LEVEL8     0x08
#define LEVEL9     0x09
#define LEVEL10    0x0A
#define LEVEL11    0x0B
#define LEVEL12    0x0C
#define LEVEL13    0x0D
#define LEVEL14    0x0E
#define LEVEL15    0x0F
#define LEVEL16    0x1F
#define LEVEL17    0x3F
#define LEVEL18    0x7F
#define LEVEL19    0xFF			

//#define	TEMP_SENSOR_HBCORE	500L

//mtimer repeating TEMPSensorTxTimer = TEMP_SENSOR_HBCORE;

//network input SNVT_switch nvilampvalue;
network output SNVT_str_asc nvofigudata;
network input SNVT_str_asc nvifigudata;
network input SNVT_switch nviGasdata;
network input SNVT_lux nviCdsdata;
network input SNVT_temp_p  nviTempdata;



network output SNVT_switch nvoGason;
network output SNVT_switch nvotempon;
network output SNVT_switch nvolight;



char szRxBufA[DATA_SIZE];
char szRxBufB[DATA_SIZE];
char obuffer[DATA_SIZE];
char comm_data[DATA_SIZE];

char GAS_level;
char TEMP_level;
char CDS_level;


char temp = 0x55;

int bufTog;


//  I/O declarations for MiniGizmo buttons
//
//  The buttons are connected to a 74HC165 8-bit parallel-in/serial-out
//  shift register. Data is shifted on IO.4 (clock) and IO.5 (data),
//  with a latch on IO.6 (low-active to capture parallel input).
//  The MG_BUTTONS_DEBOUNCE macro determines how many times the buttons
//  are read for debouncing.
//  See GetButtons() for example use
IO_4 input bitshift numbits(8) clockedge(-) ioButtons;
IO_6 output bit ioButtonLd = 1;
#define MG_BUTTONS_DEBOUNCE 3

unsigned GetButtons(void) {
    unsigned Debounce, Buttons;
    Buttons = 0xFF;
    for (Debounce = 0; Debounce < MG_BUTTONS_DEBOUNCE; ++Debounce) {
        // capture parallel lines:
        io_out(ioButtonLd, 0);
        // deactivate capture. The 74HC165 requires no more than 100ns for
        // capture; we cannot beat this even with a 40MHz Smart Transceiver
        // or Neuron Chip. No need to consider load pulse timing, therefore:
        io_out(ioButtonLd, 1);
        // take a sample and debounce:
        Buttons &= (unsigned)io_in(ioButtons);
    }
    return ~Buttons;
}

void processRxData(char buffer[DATA_SIZE]) 
{
	//#pragma relaxed_casting_on
	//memcpy (nvoData.ascii, buffer, DATA_SIZE);	
	//#pragma relaxed_casting_off
	int i;
	char temp;
	//unsigned long temp;
	for (i=0; i<DATA_SIZE; i++) nvofigudata.ascii[i] = buffer[i];	
	
	//temp = nvoData.ascii[1];
	//gas_data = nvoData.ascii[0];
	//gas_data |= temp <<8;
	//if(buffer[0] == 0x40 && buffer[12] == 0x0A)	 
	//    {
	//    if(buffer[1] == 0x11 && buffer[11] == 0x51)	 	                   
	//     SetLEDs(0x55, 0xFFu);  
	 //   }        
	//else
	//    SetLEDs(0xFF, 0xFFu);                                                     
	  
	
}

when(nv_update_occurs(nvifigudata))
{
    
	#pragma relaxed_casting_on
	memcpy (obuffer, nvifigudata.ascii, DATA_SIZE);
	#pragma relaxed_casting_off	
		
	io_out_request(iosci, obuffer, DATA_SIZE);	
	            
	                                       
}

when(nv_update_occurs(nviGasdata))
{
switch(GAS_level)
  {
  case Cont_Lev1 : if(nviGasdata.value >= 25)
                      {
                      nvoGason.value = 200; 
                      nvoGason.state = 1;                      
                      }
                   else 
                      {
                      nvoGason.value = 0;
                      nvoGason.state = 0;                      
                      }  
                   break;
  case Cont_Lev2 : if(nviGasdata.value >= 35)
                      {
                      nvoGason.value = 200; 
                      nvoGason.state = 1;                      
                      }
                   else 
                      {
                      nvoGason.value = 0;
                      nvoGason.state = 0;                      
                      }  
                   break;   
 
  }
}

when(nv_update_occurs(nviCdsdata))
{
unsigned long temp_1;
unsigned long temp_2;

switch(CDS_level)
   {
   case Cont_Lev1 : temp_1 = nviCdsdata;
                    temp_2 = temp_1 * 10; 
                    nvolight.value = (temp_2 / 12);
                    nvolight.state = 1;
                    break;
   case Cont_Lev2 : temp_1 = nviCdsdata;
                    temp_2 = temp_1 * 10; 
                    nvolight.value = (temp_2 / 15);
                    nvolight.state = 1;
   }
 


}

when(nv_update_occurs(nviTempdata))
{
switch(TEMP_level)
   {
   case Cont_Lev1 : if(nviTempdata >= 130)
                      {
                      nvotempon.state = 1;
                      nvotempon.value = 200; 
                      }
                     else 
                      {
                      nvotempon.state = 0;
                      nvotempon.value = 0; 
                      }  
                     break;   
   
   case Cont_Lev2 : if(nviTempdata >= 170)
                      {
                      nvotempon.state = 1;
                      nvotempon.value = 200; 
                      }
                     else 
                      {
                      nvotempon.state = 0;
                      nvotempon.value = 0; 
                      }  
                     break;    
   
  
   }


}




when (io_changes(ioButton1))
{
unsigned Buttons_to; 

Buttons_to = GetButtons();

switch(Buttons_to)
  {
  case 0x01 : GAS_level = Cont_Lev1;
              break;
  case 0x02 : GAS_level = Cont_Lev2;
              break;
  case 0x04 : TEMP_level = Cont_Lev1;
              break;            
  case 0x08 : TEMP_level = Cont_Lev2;
              break;            
  case 0x10 : CDS_level = Cont_Lev1;
              break;
  case 0x20 : CDS_level = Cont_Lev2;
              break;            
  //default : GAS_level = Cont_Lev5;
  }
}




when(io_in_ready(iosci) == DATA_SIZE)
{
 	// Switch to the other buffer and keep the RX count  rx_count =
	io_in_request(iosci, (bufTog) ? szRxBufA : szRxBufB, sizeof(szRxBufA));
 
 	bufTog ^= 1; // toggle this
 
 	
	processRxData((bufTog) ? szRxBufA : szRxBufB); 
}

when (reset)
{
	bufTog = 0;	
 	io_in_request(iosci, szRxBufA, DATA_SIZE);
 	//SetLEDs(0x00, 0xFFu); 
    io_out(iobuzzer, 1);
 	//iobuzzer = 1;
 	GAS_level = Cont_Lev1;
 	CDS_level = Cont_Lev1;
 	TEMP_level = Cont_Lev1;
 	nvoGason.state = 0;
    nvoGason.value = 0; 
    nvotempon.state = 0;
    nvotempon.value = 0;
}


/**
when ( timer_expires(TEMPSensorTxTimer) ) 
{  
unsigned Buttons_to; 
      

    Buttons_to = GetButtons();
    if(Buttons_to == 0x01)
       {    
       //SetLEDs(Buttons_to, 0xFFu);
       
       obuffer[0] = 0x40;obuffer[1] = 0x11;obuffer[2] = 0x00;
	   obuffer[3] = 0x00;obuffer[4] = 0x00;obuffer[5] = 0x00;
	   obuffer[6] = 0x00;obuffer[7] = 0x00;obuffer[8] = 0x00;
	   obuffer[9] = 0x00;obuffer[10] = 0x00;obuffer[11] = 0x51;obuffer[12] = 0x0a;  
	   #pragma relaxed_casting_off	
		
	   io_out_request(iosci, obuffer, DATA_SIZEFIN); 
       }
    if(Buttons_to == 0x02)
       {    
       //SetLEDs(Buttons_to, 0xFFu);
       
       obuffer[0] = 0x40;obuffer[1] = 0x05;obuffer[2] = 0x06;
	   obuffer[3] = 0x00;obuffer[4] = 0x00;obuffer[5] = 0x00;
	   obuffer[6] = 0x00;obuffer[7] = 0x00;obuffer[8] = 0x00;
	   obuffer[9] = 0x00;obuffer[10] = 0x00;obuffer[11] = 0x4B;obuffer[12] = 0x0a;  
	   #pragma relaxed_casting_off	
		
	   io_out_request(iosci, obuffer, DATA_SIZEFIN); 
       }   
    
}
***/



