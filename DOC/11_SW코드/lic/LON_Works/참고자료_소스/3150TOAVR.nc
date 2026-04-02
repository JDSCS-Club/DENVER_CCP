#pragma num_alias_table_entries 2
#pragma specify_io_clock "10 MHz"

#include <io_types.h>	
//#include <control.h>
//#include <status.h>	
//#include <string.h>	

IO_8 sci baud(SCI_9600) iosci; 
IO_1 output bit ioLED_RFID = 1;
IO_2 output bit ioLED_IR   = 1;
IO_0 output bit ioLED_SW   = 1;

#define DATA_SIZE 4
#define DATA_SIZE_rx 5

#define STX			0x02
#define ETX			0x03 
#define ID_OK		0x33 
#define ID_FAIL		0x66 
#define IR_OK		0x55
#define RFID		0xA1
#define IRSEN		0xA2
#define SW1         0xA3
#define SW2         0xA4
#define S_ON        0xD0
#define S_OFF       0xDD
#define GAS         0xE0
#define CDS         0xE1
#define TEMP        0xE2

network input SNVT_switch nviGaslcd;
network input SNVT_lux  nviCdslcd;
network input SNVT_temp_p nvitemplcd;

//network input SNVT_str_asc nviContData;
network output SNVT_switch nvoRfid;
network output SNVT_switch nvoIrd;
network output SNVT_switch nvosw1;
network output SNVT_switch nvosw2;

char szRxBufA[DATA_SIZE];
char szRxBufB[DATA_SIZE];
char obuffer[DATA_SIZE];
char com_data[DATA_SIZE];

int bufTog;

void processRxData(char buffer[DATA_SIZE]) 
{
	//#pragma relaxed_casting_on
	//memcpy (nvoData.ascii, buffer, DATA_SIZE);	
	//#pragma relaxed_casting_off
	int i;
	for (i=0; i<DATA_SIZE; i++) com_data[i] = buffer[i];//nvoSensData.ascii[i] = buffer[i];	
	
	//io_out(ioLED_RFID, 0);    
	//io_out(ioLED_IR, 0);
	//io_out(ioLED_SW, 0);
	
	if(com_data[0] == STX && com_data[3] == ETX)	
	   {	   
	    switch(com_data[1])
	       {
	       case RFID : if(com_data[2] == ID_OK)
	                     {
	                     nvoRfid.state = 1;
	                     nvoRfid.value = 200;
	                     io_out(ioLED_RFID, 0);
	                     }
	                   else
	                     {
	                     nvoRfid.state = 0;
	                     nvoRfid.value = 0;
	                     io_out(ioLED_RFID, 1);	
	                     }                  
	                   break;
	                  	      
	       case IRSEN :if(com_data[2] == IR_OK)
	                     {
	                     nvoIrd.state = 1;
	                     nvoIrd.value = 200;
	                     io_out(ioLED_IR, 0);
	                     }
	                   else
	                     {
	                     nvoIrd.state = 0;
	                     nvoIrd.value = 0;
	                     io_out(ioLED_IR, 1);
	                     }	                  
	                   break; 
	       case SW1 : if(com_data[2] == S_ON)
	                     {
	                     nvosw1.state = 1;
	                     nvosw1.value = 200;
	                     io_out(ioLED_SW, 0);
	                     }
	                   else
	                     {
	                     nvosw1.state = 0;
	                     nvosw1.value = 0;
	                     io_out(ioLED_SW, 1);	
	                     }                  
	                   break;  	                       
	                  
	       case SW2 : if(com_data[2] == S_ON)
	                     {
	                     nvosw2.state = 1;
	                     nvosw2.value = 200;
	                     io_out(ioLED_SW, 0);
	                     }
	                   else
	                     {
	                     nvosw2.state = 0;
	                     nvosw2.value = 0;
	                     io_out(ioLED_SW, 1);
	                     }	                  
	                   break;  	                             	                 	      
	      
	       }
	   //com_data[0] = 0;com_data[3] = 0;  
	       
	   }	      	             
	
	
}

when(nv_update_occurs(nviGaslcd))
{
	//#pragma relaxed_casting_on
	//memcpy (obuffer, nviLcdupData.ascii, DATA_SIZE_rx);
	//#pragma relaxed_casting_off
	obuffer[0] = 0x02;obuffer[1] = GAS;obuffer[2] = nviGaslcd.value;
	obuffer[3] = 0xFF;obuffer[4] = 0x03;
	
	io_out_request(iosci, obuffer, DATA_SIZE_rx);
}

when(nv_update_occurs(nviCdslcd))
{
	//#pragma relaxed_casting_on
	//memcpy (obuffer, nviLcdupData.ascii, DATA_SIZE_rx);
	//#pragma relaxed_casting_off
	obuffer[0] = 0x02;obuffer[1] = CDS;obuffer[2] = nviCdslcd;
	obuffer[3] = 0xFF;obuffer[4] = 0x03;
	
	io_out_request(iosci, obuffer, DATA_SIZE_rx);
}

when(nv_update_occurs(nvitemplcd))
{
    unsigned long TEMP_P;
    //char TEMP_r;
	//#pragma relaxed_casting_on
	//memcpy (obuffer, nviLcdupData.ascii, DATA_SIZE_rx);
	//#pragma relaxed_casting_off
	TEMP_P = nvitemplcd & 0xFF00;
	obuffer[2] = TEMP_P >> 8;
	TEMP_P = nvitemplcd & 0x00FF;	
	obuffer[3] = TEMP_P;
	obuffer[0] = 0x02;obuffer[1] = TEMP;
	obuffer[4] = 0x03;
	
	io_out_request(iosci, obuffer, DATA_SIZE_rx);
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
 	nvosw2.state = 0;
    nvosw2.value = 0;
    nvosw1.state = 0;
	nvosw1.value = 0;
	nvoIrd.state = 0;
	nvoIrd.value = 0;   
	nvoRfid.state = 0;
    nvoRfid.value = 0;                 
    
 	
}



