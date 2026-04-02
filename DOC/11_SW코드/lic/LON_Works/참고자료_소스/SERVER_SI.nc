#pragma num_alias_table_entries 10
#pragma run_unconfigured
#include <io_types.h>
#include <control.h>	
#include <addrdefs.h>	
#include <netmgmt.h>
#include <msg_addr.h>
#include <status.h>	
//#include <string.h>

#define SI_EVK

#define OK      0x01
#define FAIL    0x00

//#define Domain_Id   0x30
#define Servercode    0x10
#define Domain_Id     0x20

extern system void _change_state(int state); 

char domain_certify;

eeprom char Domain_table[30];
eeprom char Domain_code[30];
eeprom char Domain_count;

//#define	TEMP_SENSOR_HBCORE	400L

//mtimer repeating TEMPSensorTxTimer = TEMP_SENSOR_HBCORE;

//char start_flag;

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

void SetDomain()
{
domain_struct domain;

	memset(&domain, 0, sizeof(domain));	
	memset(domain.id, Domain_Id, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 1;
	domain.node = 10;
	domain.subnet = 1;
	
	update_domain(&domain, 0);	

}

void return_data(char code, char u_code , char certify)
{
char cData[2];
	cData[0] = u_code;
	cData[1] = certify;
	
	//memset(cData, Temp_Domain, sizeof(cData));
	
	msg_out.code 		= code; // update domain
	msg_out.service 	= UNACKD_RPT;
	//msg_out.tag 		= mtag;

	msg_out.dest_addr.no_address = BROADCAST;
	msg_out.dest_addr.bcast.type = BROADCAST;
	msg_out.dest_addr.bcast.retry = 2;
	msg_out.dest_addr.bcast.domain = 0;	//primary domain broadcasting
	
	memcpy(msg_out.data, cData, sizeof(cData));
	//memcpy(msg_out.data, read_only_data.neuron_id, 1);
	
	msg_send();


}

void delay_func(unsigned long int dlay_value)
{
unsigned long int de_lay;
unsigned long int dumy;

for( de_lay = 0; de_lay <dlay_value; de_lay++) dumy++;

}


void certify_domain(char *msg)
{
char I;
char use_code;

domain_certify = OK;

for(I=0;I<30;I++)
  {
  if(Domain_table[I] == msg[1])
      {
      domain_certify = FAIL;
      use_code = Domain_code[I]; 
      }
  }

switch(domain_certify)
  {
  case OK : Domain_table[Domain_count] = msg[1];
            Domain_code[Domain_count] = msg[0];
            Domain_count++;
            return_data(msg[0],msg[0],OK); 
            SetLEDs(0x03, 0xFFu);    
            break;
  
  case FAIL : return_data(msg[0],use_code ,FAIL); 
              SetLEDs(0x0F, 0xFFu);
              break;
  }
  
}

when (msg_arrives)
{
	//message from gateway to install/uninstall
	int len;
	char certify_data[2];
	int nodeId;
	SetLEDs(0x01, 0xFFu);
	switch (msg_in.code)
	   {
	   case Servercode :  delay_func(10000);	                     
	                      memcpy(&certify_data, msg_in.data, 2);//Install request
			              certify_domain(certify_data);
			              break; 		
			
	   }
}

when (reset)
{
char count;
char flge; 
if(power_up())
	  {
 	  #ifdef SI_EVK
 	  _change_state(0x04); 
 	  #endif 
 	  SetDomain();
 	  } 	  

flge = 0;
for(count=0;count<30;count++)
   {
   if(Domain_table[count] != 0)     
     flge = 1;    
   }  
SetLEDs(0x00, 0xFFu);   
//if(flge == 0)
//   SetLEDs(0x01, 0xFFu);
//else
//   SetLEDs(0x02, 0xFFu);      
 	
}
/***
when ( timer_expires(TEMPSensorTxTimer) ) 
{  
unsigned Buttons_to;      

    Buttons_to = GetButtons();
    if(Buttons_to == 0x01)
       {    
       SetLEDs(Buttons_to, 0xFFu);
       Domain_table[Domain_count] = 0x40;
       Domain_code[Domain_count] = 0x11;
       Domain_count++;
       }
    
}
***/
