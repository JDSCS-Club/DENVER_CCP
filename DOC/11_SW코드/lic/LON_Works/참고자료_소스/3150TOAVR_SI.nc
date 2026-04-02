#pragma num_alias_table_entries 10
#pragma specify_io_clock "10 MHz"
#pragma run_unconfigured

#include <io_types.h>	
#include <control.h>	
#include <addrdefs.h>	
#include <netmgmt.h>
#include <msg_addr.h>
#include <status.h>	

#define SI_EVK

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

#define Domain_Id     0x30
#define defult_domain 0x20
#define Mycode        0x11
#define Servercode    0x10
#define OK            0x01
#define FAIL          0x00
#define cancel        0x15

extern system void _change_state(int state);

network input SNVT_switch nviGaslcd;
network input SNVT_lux  nviCdslcd;
network input SNVT_temp_p nvitemplcd;

//network input SNVT_str_asc nviContData;
network output SNVT_switch nvoRfid;
network output SNVT_switch nvoIrd;
network output SNVT_switch nvosw1;
network output SNVT_switch nvosw2;

eeprom on_config;

char szRxBufA[DATA_SIZE];
char szRxBufB[DATA_SIZE];
char obuffer[DATA_SIZE];
char com_data[DATA_SIZE];

int bufTog;

IO_8 sci baud(SCI_9600) iosci; 
IO_1 output bit ioLED_RFID = 1;
IO_2 output bit ioLED_IR   = 1;
IO_0 output bit ioLED_SW   = 1;

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
	//io_out(ioLED_SW, 1);
	obuffer[0] = 0x02;obuffer[1] = GAS;obuffer[2] = nviGaslcd.value;
	obuffer[3] = 0xFF;obuffer[4] = 0x03;
	
	io_out_request(iosci, obuffer, DATA_SIZE_rx);
	//io_out(ioLED_SW, 0);
}

when(nv_update_occurs(nviCdslcd))
{
	//#pragma relaxed_casting_on
	//memcpy (obuffer, nviLcdupData.ascii, DATA_SIZE_rx);
	//#pragma relaxed_casting_off
	//io_out(ioLED_IR, 1);
	obuffer[0] = 0x02;obuffer[1] = CDS;obuffer[2] = nviCdslcd;
	obuffer[3] = 0xFF;obuffer[4] = 0x03;
	
	io_out_request(iosci, obuffer, DATA_SIZE_rx);
	//io_out(ioLED_IR, 0);
}

when(nv_update_occurs(nvitemplcd))
{
    unsigned long TEMP_P;
    //char TEMP_r;
	//#pragma relaxed_casting_on
	//memcpy (obuffer, nviLcdupData.ascii, DATA_SIZE_rx);
	//#pragma relaxed_casting_off
	//io_out(ioLED_RFID, 1);
	TEMP_P = nvitemplcd & 0xFF00;
	obuffer[2] = TEMP_P >> 8;
	TEMP_P = nvitemplcd & 0x00FF;	
	obuffer[3] = TEMP_P;
	obuffer[0] = 0x02;obuffer[1] = TEMP;
	obuffer[4] = 0x03;
	
	io_out_request(iosci, obuffer, DATA_SIZE_rx);
	//io_out(ioLED_RFID, 0);
}




when(io_in_ready(iosci) == DATA_SIZE)
{
 	// Switch to the other buffer and keep the RX count  rx_count =
	io_in_request(iosci, (bufTog) ? szRxBufA : szRxBufB, sizeof(szRxBufA));
 
 	bufTog ^= 1; // toggle this
 
 	
	processRxData((bufTog) ? szRxBufA : szRxBufB); 
}

void SetDomain(void)
{
    domain_struct domain;
	memset(&domain, 0, sizeof(domain));	
	memset(domain.id, Domain_Id, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 1;
	domain.node = 2;
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
	domain.node = 104;
	domain.subnet = 2;
	
	update_domain(&domain, 0);	
}

void domain_clear(void)
{
    domain_struct domain;
    memset(&domain, 0, sizeof(domain));	
	memset(domain.id, 0, 1);
	memset(domain.key, 0xFF, 8); //AUTHENTICATION
	
	domain.len = 0;
	domain.node = 0;
	domain.subnet = 0;
	
	update_domain(&domain, 0);	
}


void SetAddress(void)
{
	address_struct	adr;
	address_struct	adr_1;

	//set address table for gateway (1/120)
	
	memset(&adr, 0, sizeof(adr));
	adr = *(access_address(0));
	adr.gp.type = UNBOUND;
	//adr.gp.size = 1;
	adr.gp.domain = 0;	
	//adr.gp.member = 2;		
	//adr.gp.retry = 4;	
	adr.gp.group = 1;	
	update_address(&adr, 0);
	
	memset(&adr, 1, sizeof(adr));
	adr = *(access_address(1));
	adr.gp.type = UNBOUND;
	//adr.gp.size = 1;
	adr.gp.domain = 0;
	//adr.gp.member = 2;		
	//adr.gp.retry = 4;		
	adr.gp.group = 2;	
	update_address(&adr, 1);

	memset(&adr, 2, sizeof(adr));
	adr = *(access_address(2));
	adr.gp.type = UNBOUND;
	//adr.gp.size = 1;
	adr.gp.domain = 0;
	//adr.gp.member = 2;		
	//adr.gp.retry = 4;		
	adr.gp.group = 3;	
	update_address(&adr, 2);
	
	memset(&adr_1, 0, sizeof(adr));
	adr_1 = *(access_address(0));
	adr_1.sn.type = SUBNET_NODE;
	adr_1.sn.domain = 0;
	adr_1.sn.node = 5;	
	adr_1.sn.retry = 2;
	adr_1.sn.subnet = 1;	
	update_address(&adr_1, 0);
	
    memset(&adr_1, 1, sizeof(adr));
	adr_1 = *(access_address(1));
	adr_1.sn.type = SUBNET_NODE;
	adr_1.sn.domain = 0;
	adr_1.sn.node = 5;	
	adr_1.sn.retry = 2;
	adr_1.sn.subnet = 1;	
	update_address(&adr_1, 1);
	
	memset(&adr_1, 2, sizeof(adr));
	adr_1 = *(access_address(2));
	adr_1.sn.type = SUBNET_NODE;
	adr_1.sn.domain = 0;
	adr_1.sn.node = 5;	
	adr_1.sn.retry = 2;
	adr_1.sn.subnet = 1;	
	update_address(&adr_1, 2);
	
	memset(&adr_1, 3, sizeof(adr));
	adr_1 = *(access_address(3));
	adr_1.sn.type = SUBNET_NODE;
	adr_1.sn.domain = 0;
	adr_1.sn.node = 5;	
	adr_1.sn.retry = 2;
	adr_1.sn.subnet = 1;	
	update_address(&adr_1, 3);  
	
	
	
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
   io_out(ioLED_SW, 1);
   SetDomain();
   SetAddress();
   SetNvConfig();
   on_config = 1;
   }
else
   //io_out(ioLED_RFID, 1);
   //io_out(ioLED_SW, 1);
   io_out(ioLED_IR, 1);	    
 
}

when (msg_arrives)
{
	//message from gateway to install/uninstall
	int len;
	char certify_data[2];
	int nodeId;
	io_out(ioLED_RFID, 1);	
	switch (msg_in.code)
	   {
		case Mycode : //io_out(ioLED_SW, 1);
		              memcpy(&certify_data, msg_in.data, 2);//Install request	
			          dete_domain(certify_data);
		              break;
		case cancel :  io_out(ioLED_SW, 1);on_config = 0;go_unconfigured();
		               break;             
			
	   }
}

when (reset)
{
   if(power_up())
	  {
 	  #ifdef SI_EVK
 	  _change_state(0x04); 
 	  #endif 
 	  if(!(on_config))
 	     deful_domain(); 	   	   
 	  //SetDomain();
 	  //SetAddress();
      //SetNvConfig();
 	  }
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



