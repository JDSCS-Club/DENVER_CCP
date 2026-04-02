#pragma num_alias_table_entries 10
#pragma run_unconfigured

#include <io_types.h>	
#include <control.h>	
#include <addrdefs.h>	
#include <netmgmt.h>
#include <msg_addr.h>
#include <status.h>	


#define SI_EVK

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

#define OK         0X01
#define FAIL       0X00

#define Domain_Id   0x30
#define Mycode      0x11
#define Servercode  0x10
#define domain_cl   0x3D
#define cancel      0x15
#define defult_domain  0x20

#define	TEMP_SENSOR_HBCORE	100L	

extern system void _change_state(int state); 

network input SNVT_switch nviGasonoff;
network input SNVT_switch nviLightdim;
network input SNVT_switch nviAironoff;

network input SNVT_switch nviAcceon;
network input SNVT_switch nviIrsenon;
network input SNVT_switch nviSw1on;
network input SNVT_switch nviSw2on;
	

IO_0 output bit ioLED_GAS = 1;
IO_4 output bit ioLED_TEMP = 1;
IO_5 output bit ioLED_Certify = 1;
IO_6 output bit ioLED_IR = 1;
IO_7 output bit ioLED_SW1 = 1;
IO_9 output bit ioLED_SW2 = 1;

char light_value;
char curr_light;

eeprom on_config ;


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

CONV_LEVEL(char LEVEL_V)
{
 char LEVEL;
 
 if(LEVEL_V>= 200)
      LEVEL = LEVEL0;
    else if(LEVEL_V >=190 && LEVEL_V < 200)
	        LEVEL = LEVEL1;          
    else if(LEVEL_V >=180 && LEVEL_V < 190)
            LEVEL = LEVEL2;  
    else if(LEVEL_V >=170 && LEVEL_V < 180)
            LEVEL = LEVEL3;  
    else if(LEVEL_V >=160 && LEVEL_V < 170)
            LEVEL = LEVEL4; 
    else if(LEVEL_V >=150 && LEVEL_V < 160)
            LEVEL = LEVEL5;
    else if(LEVEL_V >=140 && LEVEL_V < 150)
            LEVEL = LEVEL6;      
    else if(LEVEL_V >=130 && LEVEL_V < 140)
            LEVEL = LEVEL7;
    else if(LEVEL_V >=120 && LEVEL_V < 130)
            LEVEL = LEVEL8; 
    else if(LEVEL_V >=110 && LEVEL_V < 120)
            LEVEL = LEVEL9;
    else if(LEVEL_V >=100 && LEVEL_V < 110)
            LEVEL = LEVEL10;     
    else if(LEVEL_V >=90 && LEVEL_V < 100)
            LEVEL = LEVEL11;   
    else if(LEVEL_V >=80 && LEVEL_V  < 90)
            LEVEL = LEVEL12;                 
    else if(LEVEL_V >=70 && LEVEL_V < 80)
            LEVEL = LEVEL13;        
    else if(LEVEL_V >=60 && LEVEL_V < 70)
            LEVEL = LEVEL14;
    else if(LEVEL_V >=50 && LEVEL_V < 60)
            LEVEL = LEVEL15;
              
    return LEVEL;
}



when(nv_update_occurs(nviGasonoff))
{
if(nviGasonoff.state)
   {
   if(nviGasonoff.value == 200)
       io_out(ioLED_GAS, 0);
   } 
else
       io_out(ioLED_GAS, 1);    
	
}

when(nv_update_occurs(nviLightdim))
{

light_value = nviLightdim.value;
curr_light = CONV_LEVEL(light_value);

 switch (curr_light)
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

when(nv_update_occurs(nviAironoff))
{
if(nviAironoff.state)
   {
   if(nviAironoff.value == 200)
       io_out(ioLED_TEMP, 0);
   } 
else
       io_out(ioLED_TEMP, 1);    
	
}

when(nv_update_occurs(nviAcceon))
{
if(nviAcceon.state)
   {
   if(nviAcceon.value == 200)
       io_out(ioLED_Certify, 0);
   } 
else
       io_out(ioLED_Certify, 1); 
          	
}

when(nv_update_occurs(nviIrsenon))
{
if(nviIrsenon.state)
   {
   if(nviIrsenon.value == 200)
       io_out(ioLED_IR, 0);
   } 
else
       io_out(ioLED_IR, 1);
	
}

when(nv_update_occurs(nviSw1on))
{
if(nviSw1on.state)
   {
   if(nviSw1on.value == 200)
       io_out(ioLED_SW1, 0);
   } 
else
       io_out(ioLED_SW1, 1);
	
}

when(nv_update_occurs(nviSw2on))
{
if(nviSw2on.state)
   {
   if(nviSw2on.value == 200)
       io_out(ioLED_SW2, 0);
   } 
else
       io_out(ioLED_SW2, 1);
	
}

void SetDomain()
{
domain_struct domain;
	memset(&domain, 0, sizeof(domain));	
	memset(domain.id, Domain_Id, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 1;
	domain.node = 5;
	domain.subnet = 1;
	
	update_domain(&domain, 0);	

}

void deful_domain(void) 
{
domain_struct domain;
	memset(&domain, 0, sizeof(domain));	
	memset(domain.id, defult_domain, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 1;
	domain.node = 100;
	domain.subnet = 2;
	
	update_domain(&domain, 0);	
}

void SetNvConfig()
{
	nv_struct	nv;
	
    nv = *(access_nv(0));
	nv.nv_selector_hi = 0x0A;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 0);
	
	nv = *(access_nv(1));
	nv.nv_selector_hi = 0x0B;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 1);
	
	nv = *(access_nv(2));
	nv.nv_selector_hi = 0x0C;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 2);		
	
	nv = *(access_nv(3));
	nv.nv_selector_hi = 0x04;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 3);
	
	nv = *(access_nv(4));
	nv.nv_selector_hi = 0x05;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 4);
	
	nv = *(access_nv(5));
	nv.nv_selector_hi = 0x06;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 5);
	
	nv = *(access_nv(6));
	nv.nv_selector_hi = 0x07;
	nv.nv_selector_lo = 0x00;
	nv.nv_addr_index = 0;
	update_nv(&nv, 6);
	
	

}


void dete_domain(char *msg)
{
if(msg[0] == Mycode || msg[1] == OK)
   {     
   SetDomain();
   //SetAddress();
   SetNvConfig();
   on_config = 1;
   }   
 
}

when (msg_arrives)
{
	//message from gateway to install/uninstall
	int len;
	char certify_data[2];
	int nodeId;
		
	switch (msg_in.code)
	   {
		case Mycode : memcpy(&certify_data, msg_in.data, 2);//Install request	
			          dete_domain(certify_data);
		              break;
		case cancel : on_config = 0;go_unconfigured();
		              break;             
			
	   }
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
 	SetLEDs(0x00, 0xFFu); 
 	
    nviGasonoff.state = 0;nviGasonoff.value = 0;
 	nviLightdim.state = 0;nviLightdim.value = 0;
 	nviAironoff.state = 0;nviAironoff.value = 0;
 	nviAcceon.state = 0;nviAcceon.value = 0;
 	nviIrsenon.state = 0;nviIrsenon.value = 0;
 	nviSw1on.state = 0;nviSw1on.value = 0;
 	nviSw2on.state = 0;nviSw2on.value = 0;
 	
}

