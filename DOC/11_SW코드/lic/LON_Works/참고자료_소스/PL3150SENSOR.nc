#pragma num_alias_table_entries 2
#pragma specify_io_clock "10 MHz"

#include <io_types.h>	
//#include <control.h>
//#include <status.h>	
//#include <string.h>	

IO_8 sci baud(SCI_9600) iosci; 
IO_0 output bit iobuzzer = 1;

#define DATA_SIZE 6

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

#define GAS   0xE0
#define CDS   0xE1
#define TEMP  0xE2 

#define	TEMP_SENSOR_HBCORE	100L

//mtimer repeating TEMPSensorTxTimer = TEMP_SENSOR_HBCORE;

//network input SNVT_str_asc nviData;
network output SNVT_switch nvoGasd;
//network output SNVT_lev_cont nvoCdsd;
network output SNVT_lux  nvoCdsd;
network output SNVT_temp_p nvoTempd;

char szRxBufA[DATA_SIZE];
char szRxBufB[DATA_SIZE];
char obuffer[DATA_SIZE];

char gas_data;
char cds_data;

int bufTog;

unsigned PreviousLEDs = 0;

IO_2 output bitshift numbits(8) ioLEDs;
IO_1 output bit ioLEDLd = 0;

void SetLEDs(unsigned LEDs, unsigned Mask) {
	// We may only want to set some LEDs, indicated by Mask. Bits outside the
	// mask are added from the previous pattern:
	LEDs |= PreviousLEDs & ~Mask;
	PreviousLEDs = LEDs;

	// LEDs are driven active low - the SetLEDs function handles the inversion
	// so that the application developer may think in positive logic:
	io_out(ioLEDs, ~LEDs);
	// strobe:
	io_out(ioLEDLd, 0);
	io_out(ioLEDLd, 1);
}

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
	signed long temp;
	signed long tempp;	
	//for (i=0; i<DATA_SIZE; i++) nvosensingd.ascii[i] = buffer[i];	
	switch(buffer[1])
	   {
	   case GAS : nvoGasd.value = buffer[2];
	              nvoGasd.state = 1;
	              break;
	   case CDS : nvoCdsd = buffer[2];
	              break;   
	   case TEMP : nvoTempd = buffer[3];
	               temp = buffer[2]; //<< 8;
	               nvoTempd |= temp << 8;
	               //nvoTempd |= tempp;	               
	               break;  
	   }                                
	//temp = nvoData.ascii[1];
	//gas_data = nvoData.ascii[0];
	//gas_data |= temp <<8;
	if(buffer[0] == 0x02 && buffer[5] == 0x03)
	  {	 
	  if(buffer[1] == GAS)
	     {
	     gas_data =  buffer[2];	
	     if(gas_data >= 25)	     	   
	       io_out(iobuzzer, 0);
	     else
	       io_out(iobuzzer, 1);
	     }
	     
	  else if(buffer[1] == CDS) 
	     cds_data =  buffer[4];   	     
	     	 
	  switch (cds_data)
	    {
	    case LEVEL3 : SetLEDs(0xFF, 0xFFu);
	                 break;
	    case LEVEL4 : SetLEDs(0xFE, 0xFFu);
	                 break;    
	    case LEVEL5 : SetLEDs(0xFC, 0xFFu);
	                 break;
	    case LEVEL6 : SetLEDs(0xF8, 0xFFu);
	                 break;     
	    case LEVEL7 : SetLEDs(0xF0, 0xFFu);
	                 break;
	    case LEVEL8 : SetLEDs(0xE0, 0xFFu);
	                 break;    
	    case LEVEL9 : SetLEDs(0xC0, 0xFFu);
	                 break;
	    case LEVEL10 : SetLEDs(0x80, 0xFFu);
	                 break;   
	    case LEVEL11 : SetLEDs(0x00, 0xFFu);
	                 break;
	    case LEVEL12 : SetLEDs(0x00, 0xFFu);
	                 break;    
	    case LEVEL13 : SetLEDs(0x00, 0xFFu);
	                 break;
	    case LEVEL14 : SetLEDs(0x00, 0xFFu);
	                 break;  
	    }                                                        
	  
	  }   	  
	
	//if(nvoData.ascii[0] >= 0x60)
	//  {
	//  if(nvoData.ascii[1]== 0x77)
	//     SetLEDs(0xFE, 0xFFu);//iobuzzer = 1;
	//  }
}

//when(nv_update_occurs(nviData))
//{
	//#pragma relaxed_casting_on
	//memcpy (obuffer, nviData.ascii, DATA_SIZE);
	//#pragma relaxed_casting_off
	
//	io_out_request(iosci, obuffer, DATA_SIZE);
//}

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
 	SetLEDs(0x00, 0xFFu); 
    io_out(iobuzzer, 1);
 	//iobuzzer = 1;
 	
}


//when ( timer_expires(TEMPSensorTxTimer) ) 
//{  
//unsigned Buttons_to; 
      

//    Buttons_to = GetButtons();
//    if(Buttons_to != 0x00)    
//       SetLEDs(Buttons_to, 0xFFu);
    
//}




