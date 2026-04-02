#pragma run_unconfigured
#pragma num_alias_table_entries 10
#pragma specify_io_clock "10 MHz"


#include <io_types.h>
#include <control.h>	
#include <addrdefs.h>	
#include <netmgmt.h>
#include <msg_addr.h>
#include <status.h>	
//#include <string.h>	

#define SI_EVK

#define DATA_SIZE  6

#define GAS     0xE0
#define CDS     0xE1
#define TEMP    0xE2 
#define OK      0X01
#define FAIL    0X00

#define Domain_Id   0x30
#define Mycode      0x11
#define Servercode  0x10
#define domain_cl   0x3D
#define cancel      0x15
#define defult_domain 0x20



#define	TEMP_SENSOR_HBCORE	100L

extern system void _change_state(int state); 

//mtimer repeating TEMPSensorTxTimer = TEMP_SENSOR_HBCORE;

//network input SNVT_str_asc nviData;
network output SNVT_switch nvoGasd;
network output SNVT_lux  nvoCdsd;
network output SNVT_temp_p nvoTempd;

IO_8 sci baud(SCI_9600) iosci; 
IO_0 output bit iobuzzer = 1;
IO_1 output bit iotempup = 1;
IO_2 output bit iotest = 1;
IO_3 input bit ioisbutton ;

char szRxBufA[DATA_SIZE];
char szRxBufB[DATA_SIZE];
char obuffer[DATA_SIZE];
eeprom on_config ;

char gas_data;
char cds_data;
//unsigned int tempdata;
char flag;

int bufTog;

/***
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
***/
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
	     
	  else if(buffer[1] == TEMP) 
	          {
	          if(nvoTempd > 130)
	             io_out(iotempup , 0);
	          else
	             io_out(iotempup , 1);   
	       	  }   
	  
	  /***   	 
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
	  ***/
	  } 	
	
}

//when(nv_update_occurs(nviData))
//{
	//#pragma relaxed_casting_on
	//memcpy (obuffer, nviData.ascii, DATA_SIZE);
	//#pragma relaxed_casting_off
	
//	io_out_request(iosci, obuffer, DATA_SIZE);
//}

void ID_REQUEST(void)
{
//int i;
	char cData[2];
	cData[0] = Mycode;
	cData[1] = Domain_Id;
	
	//memset(cData, Temp_Domain, sizeof(cData));
	
	msg_out.code 		= Servercode; // update domain
	msg_out.service 	= UNACKD_RPT;
	//msg_out.tag 		= mtag;

	msg_out.dest_addr.no_address = BROADCAST;
	msg_out.dest_addr.bcast.type = BROADCAST;
	msg_out.dest_addr.bcast.retry = 0;
	msg_out.dest_addr.bcast.domain = 0;	//primary domain broadcasting
	
	memcpy(msg_out.data, cData, sizeof(cData));
	//memcpy(msg_out.data, read_only_data.neuron_id, 1);
	
	msg_send();
	io_out(iotest, 1);

}


void SetDomain()
{
domain_struct domain;

	memset(&domain, 0, sizeof(domain));	
	memset(domain.id, Domain_Id, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 1;
	domain.node = 103;
	domain.subnet = 2;
	
	update_domain(&domain, 0);	

}

void deful_domain(void) 
{
domain_struct domain;
	memset(&domain, 0, sizeof(domain));	
	memset(domain.id, defult_domain, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 1;
	domain.node = 1;
	domain.subnet = 1;
	
	update_domain(&domain, 0);	
}

void domain_clear()
{
    domain_struct domain;
    
    char cData[2];
	cData[0] = Mycode;
	cData[1] = Domain_Id;
	
	//memset(cData, Temp_Domain, sizeof(cData));
	
	msg_out.code 		= domain_cl; // update domain
	msg_out.service 	= UNACKD_RPT;
	//msg_out.tag 		= mtag;

	msg_out.dest_addr.no_address = BROADCAST;
	msg_out.dest_addr.bcast.type = BROADCAST;
	msg_out.dest_addr.bcast.retry = 2;
	msg_out.dest_addr.bcast.domain = 0;	//primary domain broadcasting
	
	memcpy(msg_out.data, cData, sizeof(cData));
	//memcpy(msg_out.data, read_only_data.neuron_id, 1);	
	msg_send();
	io_out(iotest, 1);
	
	memset(&domain, 0, sizeof(domain));	
	memset(domain.id, 0, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 0;
	domain.node = 0;
	domain.subnet = 0;
	
	update_domain(&domain, 0);	
	

}

void SetAddress()
{
	address_struct	adr;
    /****
    memset(&adr, 0, sizeof(adr));
	adr = *(access_address(0));
	adr.sn.type = SUBNET_NODE;
	adr.sn.domain = 0;
	adr.sn.node = 2;	
	adr.sn.retry = 1;
	adr.sn.subnet = 1;	
	update_address(&adr, 0);	
     **/ 
  
	//set address table for gateway (1/120)
	memset(&adr, 0, sizeof(adr));
	adr = *(access_address(0));
	adr.gp.type = UNBOUND;
	adr.gp.size = 3;
	adr.gp.domain = 0;
	adr.gp.member = 2;	
	//adr.gp.rpt_timer = 0;	
	adr.gp.retry = 3;	
	adr.gp.group = 1;	
	update_address(&adr, 0);
	
	memset(&adr, 1, sizeof(adr));
	adr = *(access_address(1));
	adr.gp.type = UNBOUND;
	adr.gp.size = 3;
	adr.gp.domain = 0;
	adr.gp.member = 2;
	//adr.gp.rpt_timer = 0;		
	adr.gp.retry = 3;		
	adr.gp.group = 2;	
	update_address(&adr, 1);

	memset(&adr, 2, sizeof(adr));
	adr = *(access_address(2));	
	adr.gp.type = UNBOUND;
	adr.gp.size = 3;
	adr.gp.domain = 0;
	adr.gp.member = 2;
	//adr.gp.rpt_timer = 0;		
	adr.gp.retry = 3;	
	adr.gp.group = 3;	
	update_address(&adr, 2);	
	
	
}

void SetNvConfig()
{
	nv_struct	nv;

	//set nvoStatus : (nv#:1)
	nv = *(access_nv(0));
	nv.nv_selector_hi = 0x01;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 0);
	
	nv = *(access_nv(1));
	nv.nv_selector_hi = 0x02;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 1);
	
	nv = *(access_nv(2));
	nv.nv_selector_hi = 0x03;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 2);
	

}
void answer_cancel(void)
{
char cData[2];
	cData[0] = 0xFF;
	cData[1] = Domain_Id;
	
	//memset(cData, Temp_Domain, sizeof(cData));
	
	msg_out.code 		= cancel; // update domain
	msg_out.service 	= UNACKD_RPT;
	//msg_out.tag 		= mtag;

	msg_out.dest_addr.no_address = BROADCAST;
	msg_out.dest_addr.bcast.type = BROADCAST;
	msg_out.dest_addr.bcast.retry = 3;
	msg_out.dest_addr.bcast.domain = 0;	//primary domain broadcasting
	
	memcpy(msg_out.data, cData, sizeof(cData));
	//memcpy(msg_out.data, read_only_data.neuron_id, 1);
	
	msg_send();	
	    
    
}


void dete_domain(char *msg)
{
if(msg[0] == Mycode || msg[1] == OK)
   {  
   io_out(iotempup , 0);
   io_out(iotest, 1);
   SetDomain();
   SetAddress();
   SetNvConfig();
   on_config = 1;
   }
else
   {
   //io_out(iotempup , 0);    
   //io_out(iotest, 1);    
   }
}

when (msg_arrives)
{
	//message from gateway to install/uninstall
	int len;
	char certify_data[2];
	int nodeId;	
	//io_out(iotest, 0);
	switch (msg_in.code)
	   {
	   case Mycode :  //io_out(iotempup , 0); 
	                  memcpy(&certify_data, msg_in.data, 2);//Install request
			          dete_domain(certify_data);
			          break;
	   case cancel :  io_out(iotest, 0);
	                  answer_cancel(); on_config = 0;go_unconfigured();
		               break;           	           		
			
	   }
}

when(io_in_ready(iosci) == DATA_SIZE)
{
 	// Switch to the other buffer and keep the RX count  rx_count =
	io_in_request(iosci, (bufTog) ? szRxBufA : szRxBufB, sizeof(szRxBufA));
 
 	bufTog ^= 1; // toggle this
 
 	
	processRxData((bufTog) ? szRxBufA : szRxBufB); 
}


when (io_changes(ioisbutton))
{
unsigned Buttons_to;
unsigned long int de_lay;
unsigned long int dumy;
//char temp_bu;
//io_out(iotest, 0);       
Buttons_to = GetButtons(); 

switch(Buttons_to)
      {
      case 0x80 : io_out(iotest, 0); 
                  for( de_lay = 0; de_lay <1000; de_lay++) dumy++; 
                  ID_REQUEST();   
                  break; 
      //case 0x01 : io_out(iotest, 0); // SI CANCEL 
      //            domain_clear();   
      //            break;                       
      
      }

//for( de_lay = 0; de_lay <1000; de_lay++) dumy++;		
while(!(io_in(ioisbutton)));       
//io_out(iotest, 1);      

}

when (reset)
{
    if (power_up())
	{	
	#ifdef SI_EVK
 	_change_state(0x04); 
 	#endif 
 	if(!(on_config))
 	     deful_domain(); 	
    //SetAddress();
    //SetNvConfig(); 	
 	}
	bufTog = 0;	
 	io_in_request(iosci, szRxBufA, DATA_SIZE);
 	//SetLEDs(0x00, 0xFFu); 
    io_out(iobuzzer, 1);
 	//iobuzzer = 1;
 	flag = 0; 	
}

//when ( timer_expires(TEMPSensorTxTimer) ) 
//{  
//unsigned Buttons_to; 
      

//    Buttons_to = GetButtons();
//    if(Buttons_to != 0x00)    
//       SetLEDs(Buttons_to, 0xFFu);
    
//}



