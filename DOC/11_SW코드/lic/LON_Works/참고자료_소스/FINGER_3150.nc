#pragma num_alias_table_entries 2
#pragma specify_io_clock "10 MHz"
//#pragma enable_io_pullups

#include <io_types.h>	
//#include <control.h>
//#include <status.h>	
//#include <string.h>	

IO_8 sci baud(SCI_19200) iosci; 
IO_0 output bit iobuzzer = 1;

IO_3 input  bit ioButton1;	// the one next to LED1
//IO_6 input  bit ioButton2;	// the one next to LED2
IO_1 output bit ioLED1 = 1;
IO_2 output bit ioLED2 = 1;
IO_0 output bit ioLED3 = 1;


#define DATA_SIZE  13
//#define DATA_SIZEFIN  13


//#define	TEMP_SENSOR_HBCORE	1000L

//mtimer repeating TEMPSensorTxTimer = TEMP_SENSOR_HBCORE;

network input SNVT_str_asc nvitrdata;
network output SNVT_str_asc nvotrdata;
network output SNVT_switch nvolampvalu;


char szRxBufA[DATA_SIZE];
char szRxBufB[DATA_SIZE];
char obuffer[DATA_SIZE];
char comm_data[DATA_SIZE];
char count =0;


char temp = 0x55;

int bufTog;

//unsigned PreviousLEDs = 0;

//IO_2 output bitshift numbits(8) ioLEDs;
//IO_1 output bit ioLEDLd = 0;


//void SetLEDs(unsigned LEDs, unsigned Mask) {
	// We may only want to set some LEDs, indicated by Mask. Bits outside the
	// mask are added from the previous pattern:
//	LEDs |= PreviousLEDs & ~Mask;
//	PreviousLEDs = LEDs;

	// LEDs are driven active low - the SetLEDs function handles the inversion
	// so that the application developer may think in positive logic:
//	io_out(ioLEDs, ~LEDs);
	// strobe:
//	io_out(ioLEDLd, 0);
//	io_out(ioLEDLd, 1);
//}

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
    int i;
	//#pragma relaxed_casting_on
	//memcpy (nvotrdata.ascii, buffer, DATA_SIZE);	
	//#pragma relaxed_casting_off
	
	//char temp;
	//unsigned long temp;
	for (i=0; i<DATA_SIZE; i++) comm_data[i] = nvotrdata.ascii[i] = buffer[i];	
	
	//nvolampvalu.state = 1;
	//nvolampvalu.value = 200;
	
	//temp = nvoData.ascii[1];
	//gas_data = nvoData.ascii[0];
	//gas_data |= temp <<8;
	
	if(comm_data[0] == 0x40 && comm_data[12] == 0x0A)	
	   {
	    switch(comm_data[10])
	      {
	      case 0x61 : io_out(ioLED1, 0);
	                  //io_out(ioLED2, 1);
	                 // io_out(ioLED3, 1);
	                  nvolampvalu.state = 1;
	                  nvolampvalu.value = 200;
	                  break;	      
	      case 0x69 : io_out(ioLED2, 0);
	                  //io_out(ioLED3, 1);
	                  //io_out(ioLED1, 1);	       
	                  nvolampvalu.state = 0;
	                  nvolampvalu.value = 0;
	                  break;	      
	      case 0x62 : io_out(ioLED3, 0);
	                  //io_out(ioLED2, 1);
	                  //io_out(ioLED1, 1);	       
	                  //nvolampvalu.state = 0;
	                  //nvolampvalu.value = 0;
	                  break;	     
	      }
	   }	      	             
	else 
	   {	    
	    io_out(ioLED3, 0); 
	    io_out(ioLED2, 1);
	    io_out(ioLED1, 1);	       
	    nvolampvalu.state = 0;
	    nvolampvalu.value = 0;
	                               
	   }
	
}

when(nv_update_occurs(nvitrdata))
{
	#pragma relaxed_casting_on
	memcpy (obuffer, nvitrdata.ascii, DATA_SIZE);
	#pragma relaxed_casting_off
	
	io_out_request(iosci, obuffer, DATA_SIZE);
	
	//if(obuffer[0] == 0x40 && obuffer[12] == 0x0A) 
	//    {   
	//    temp = ~temp;            
	    //SetLEDs(temp, 0xFFu);
	 //   }
	//else
	//    SetLEDs(0xFF, 0xFFu);                       
	
}

when(io_in_ready(iosci) == DATA_SIZE)
{
 	// Switch to the other buffer and keep the RX count  rx_count =
	io_in_request(iosci, (bufTog) ? szRxBufA : szRxBufB, sizeof(szRxBufA));
 
 	bufTog ^= 1; // toggle this
 
 	
	processRxData((bufTog) ? szRxBufA : szRxBufB); 
}

/***
when (io_changes(ioButton1))
{
    //#pragma relaxed_casting_on
	//memcpy (obuffer, nvitrdata.ascii, DATA_SIZE);
	//#pragma relaxed_casting_off
	//comm_data[0] = 0x40;comm_data[1] = 0x11;comm_data[2] = 0x00;
	//comm_data[3] = 0x00;comm_data[4] = 0x00;comm_data[5] = 0x00;
	//comm_data[6] = 0x00;comm_data[7] = 0x00;comm_data[8] = 0x00;
	//comm_data[9] = 0x00;comm_data[10] = 0x00;comm_data[11] = 0x51;comm_data[12] = 0x0A;
	//#pragma relaxed_casting_on
	//memcpy (obuffer, comm_data, DATA_SIZE);
	//#pragma relaxed_casting_off
    //io_out_request(iosci, obuffer, DATA_SIZE);
	//SetLEDs(0x01, 0xFFu); 
	io_out(ioLED2, 0);
	nvolampvalu.state = 0;
	nvolampvalu.value = 0;

}

when (io_changes(ioButton2))
{    
    //#pragma relaxed_casting_on
	//memcpy (obuffer, nvitrdata.ascii, DATA_SIZE);
	//#pragma relaxed_casting_off
	comm_data[0] = 0x40;comm_data[1] = 0x02;comm_data[2] = 0x00;
	comm_data[3] = 0x00;comm_data[4] = 0x00;comm_data[5] = 0x00;
	comm_data[6] = 0x00;comm_data[7] = 0x00;comm_data[8] = 0x00;
	comm_data[9] = 0x00;comm_data[10] = 0x00;comm_data[11] = 0x42;comm_data[12] = 0x0A;
	#pragma relaxed_casting_on
	memcpy (obuffer, comm_data, DATA_SIZE);
	#pragma relaxed_casting_off
    io_out_request(iosci, obuffer, DATA_SIZE);
	//SetLEDs(0x02, 0xFFu); 

}
***/


when (reset)
{
	bufTog = 0;	
 	io_in_request(iosci, szRxBufA, DATA_SIZE);
 	//SetLEDs(0x00, 0xFFu); 
    io_out(iobuzzer, 1);
    nvolampvalu.state = 0;
	nvolampvalu.value = 0;
 	//iobuzzer = 1;
}



//when ( timer_expires(TEMPSensorTxTimer) ) 
when (io_changes(ioButton1))
{  
unsigned Buttons_to; 
//unsigned pre_Buttons; 
//char count;
    io_out(ioLED2, 1);
	io_out(ioLED3, 1);
	io_out(ioLED1, 1);
	nvolampvalu.state = 0;
	nvolampvalu.value = 0;	
    
    Buttons_to = GetButtons();  
       
      
    obuffer[0] = 0x40;
	obuffer[3] = 0x00;obuffer[4] = 0x00;obuffer[5] = 0x00;
	obuffer[6] = 0x00;obuffer[7] = 0x00;obuffer[8] = 0x00;
	obuffer[9] = 0x00;obuffer[10] = 0x00;obuffer[12] = 0x0a;  
      
     
    switch(Buttons_to)
      {
      case 0x01 : obuffer[1] = 0x11;obuffer[2] = 0x00; obuffer[11] = 0x51;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;      
      case 0x02 : obuffer[1] = 0x05;obuffer[2] = 0x01; obuffer[11] = 0x46;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;            
      case 0x04 : obuffer[1] = 0x05;obuffer[2] = 0x02; obuffer[11] = 0x47;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;      
      case 0x08 : obuffer[1] = 0x05;obuffer[2] = 0x03; obuffer[11] = 0x48;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;        
      case 0x10 : obuffer[1] = 0x05;obuffer[2] = 0x04; obuffer[11] = 0x49;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;      
      case 0x20 : obuffer[1] = 0x05;obuffer[2] = 0x05; obuffer[11] = 0x4A;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;      
      case 0x40 : obuffer[1] = 0x05;obuffer[2] = 0x06; obuffer[11] = 0x4B;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;      
      case 0x80 : obuffer[1] = 0x17;obuffer[2] = 0x00; obuffer[11] = 0x57;
                  io_out_request(iosci, obuffer, DATA_SIZE);
                  break;      
       
      }    
   
}




