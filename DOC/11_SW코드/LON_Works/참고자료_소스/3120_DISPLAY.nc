#pragma num_alias_table_entries 2

#include <io_types.h>	


network input SNVT_switch nviGasonoff;
network input SNVT_switch nviLightdim;
network input SNVT_switch nviAironoff;
network input SNVT_switch nviAcceon;
network input SNVT_switch nviIrsenon;
network input SNVT_switch nviSw1on;
network input SNVT_switch nviSw2on;

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

IO_0 output bit ioLED_GAS = 1;
IO_4 output bit ioLED_TEMP = 1;
IO_5 output bit ioLED_Certify = 1;
IO_6 output bit ioLED_IR = 1;
IO_7 output bit ioLED_SW1 = 1;
IO_9 output bit ioLED_SW2 = 1;

char light_value;
char curr_light;


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


when (reset)
{
	
 	SetLEDs(0x00, 0xFFu); 
 	
    nviGasonoff.state = 0;nviGasonoff.value = 0;
 	nviLightdim.state = 0;nviLightdim.value = 0;
 	nviAironoff.state = 0;nviAironoff.value = 0;
 	nviAcceon.state = 0;nviAcceon.value = 0;
 	nviIrsenon.state = 0;nviIrsenon.value = 0;
 	nviSw1on.state = 0;nviSw1on.value = 0;
 	nviSw2on.state = 0;nviSw2on.value = 0;
 	
}

