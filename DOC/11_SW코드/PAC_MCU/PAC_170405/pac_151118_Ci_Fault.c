#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "71x_lib.h"

// 130422 door close


////////////////////////////////////////////////////////////////////////////////

#define	CHECK_SET_H(a, b, c, d) ((a) & (b)) ? ((c) |= (d)) : ((c) &= ~(d))
#define	CHECK_SET_L(a, b, c, d) ((a) & (b)) ? ((c) &= ~(d)) : ((c) |= (d))

static	bool	Flash_Enable;
static	u8		A_FirmVer[3];
static	u8		A_FirmDate[3];
static	u8		Temp_H;
static	u8		Temp_L;
#define MP3_DEBUG_MSG				0
#define SERIAL_COUNT_CLEAR			0x00
#define NONE_SERIAL_EVENT			0x00
#define SERIAL_EVENT_PROGRESS		0x01
#define SERIAL_EVENT_EXECUTE		0x02

#define MP3_STATE_CLEAR				0x00
#define MP3_PLAY_STOP				0x00
#define MP3_PLAY_NORMAL				0x01
#define MP3_NOT_FILE				0x02
#define MP3_PLAY_FAIL				0x03
u8 pre_send_data;
u8 gByMP3RxState;
u8 gByRxCount;
u8 gByMP3RxData[20];
static u8 gByPACtoCNCS_MP3State;
static  u8 		gbyPreState;
static  u8      gbyMP3PlayFlag;
void Debug_msg(u8 ch)
{
	if(pre_send_data != ch){
		UART_ByteSend(UART0,&ch);
		pre_send_data = ch;
	}
}

int CheckCMDLine(char const *cmd)
{
	return !strncmp((char *)&gByMP3RxData[0], cmd, strlen(cmd));
}

void MP3_RxHandler(u8 rx_data){
	if((rx_data == '/')&&(gByMP3RxState==NONE_SERIAL_EVENT)){
		gByRxCount = SERIAL_COUNT_CLEAR;
		gByMP3RxState = SERIAL_EVENT_PROGRESS;
	}
	else if((rx_data == '!')&&(gByMP3RxState==SERIAL_EVENT_PROGRESS)){
		gByMP3RxState = SERIAL_EVENT_EXECUTE;
	}
	else{
		gByMP3RxData[gByRxCount++] = rx_data;
	}
}
void MP3_RxBuffClr(void){
	u8 cnt;

	for(cnt = 0; cnt < gByRxCount; cnt++){
		gByMP3RxData[cnt] = RESET;
	}

	gByMP3RxState = NONE_SERIAL_EVENT;
	gByRxCount = SERIAL_COUNT_CLEAR;
}
void MP3_SerialDataParsing(void)
{
#if !MP3_DEBUG_MSG
	u8 cnt;
#endif

	if(gByMP3RxState == SERIAL_EVENT_EXECUTE){
		if(CheckCMDLine("m play ok")){
			gByPACtoCNCS_MP3State = MP3_PLAY_NORMAL;
			UART_ByteSend(UART0,&gByMP3RxData[7]);
		#if MP3_DEBUG_MSG
			for(cnt = 0; cnt < gByRxCount; cnt++){
				UART_ByteSend(UART0,&gByMP3RxData[cnt]);
			}
		#endif
		}
		else if(CheckCMDLine("m play fail")){
			gByPACtoCNCS_MP3State = MP3_PLAY_FAIL;
			UART_ByteSend(UART0,&gByMP3RxData[7]);
		#if MP3_DEBUG_MSG
			for(cnt = 0; cnt < gByRxCount; cnt++){
				UART_ByteSend(UART0,&gByMP3RxData[cnt]);
			}
		#endif
		}
		else if(CheckCMDLine("m play stop")){
			UART_ByteSend(UART0,&gByMP3RxData[7]);
		#if MP3_DEBUG_MSG
			for(cnt = 0; cnt < gByRxCount; cnt++){
				UART_ByteSend(UART0,&gByMP3RxData[cnt]);
			}
		#endif
		}
		else if(CheckCMDLine("m not list")){
			gByPACtoCNCS_MP3State = MP3_NOT_FILE;
			UART_ByteSend(UART0,&gByMP3RxData[6]);
		#if MP3_DEBUG_MSG
			for(cnt = 0; cnt < gByRxCount; cnt++){
				UART_ByteSend(UART0,&gByMP3RxData[cnt]);
			}
		#endif
		}
		else if(CheckCMDLine("MP3 Init OK")){
			UART_ByteSend(UART0,&gByMP3RxData[4]);
		}
		else{
			for(cnt = 0; cnt < gByRxCount; cnt++){
				UART_ByteSend(UART0,&gByMP3RxData[cnt]);
			}
		}
		MP3_RxBuffClr();
	}
}

int main(void)
{
	u32		i;//, j;
	u8		temp8;//, temp10;
	u8 		cra_temp,crb_temp;
	//u16		temp16;

	Flash_Enable = true;

	A_FirmVer[0] = 0x00;
	A_FirmVer[1] = 0x02;
	A_FirmVer[2] = 0x34;

	A_FirmDate[0] = 0x13;
	A_FirmDate[1] = 0x05;
	A_FirmDate[2] = 0x01;

	Temp_H = 0x40;
	Temp_L = 0x01;

	Set_Var();

	////////////////////////////////

	RCCU_PCLK1Config (RCCU_DEFAULT);
	RCCU_PCLK2Config (RCCU_DEFAULT);
	RCCU_MCLKConfig (RCCU_DEFAULT);
	RCCU_PLL1Config (RCCU_PLL1_Mul_12, RCCU_Div_3) ;
	while(RCCU_FlagStatus(RCCU_PLL1_LOCK) == RESET);
	RCCU_RCLKSourceConfig (RCCU_PLL1_Output) ;
	APB_ClockConfig (APB1, ENABLE, I2C0_Periph|UART0_Periph|UART1_Periph|UART2_Periph|UART3_Periph );
	APB_ClockConfig (APB2, ENABLE, GPIO0_Periph|GPIO1_Periph|GPIO2_Periph|ADC12_Periph|TIM0_Periph|TIM1_Periph|TIM2_Periph|TIM3_Periph|EIC_Periph|XTI_Periph);

	for (i=0 ; i<0xFFFF ; i++);

	GPIO_Config(GPIO0, UART0_Rx_Pin, GPIO_IN_TRI_CMOS);
	GPIO_Config(GPIO0, UART0_Tx_Pin, GPIO_AF_PP);
	GPIO_Config(GPIO0, UART1_Rx_Pin, GPIO_IN_TRI_CMOS);
	GPIO_Config(GPIO0, UART1_Tx_Pin, GPIO_AF_PP);
	GPIO_Config(GPIO0, UART2_Rx_Pin, GPIO_IN_TRI_CMOS);
	GPIO_Config(GPIO0, UART2_Tx_Pin, GPIO_AF_PP);
	GPIO_Config(GPIO0, UART3_Rx_Pin, GPIO_IN_TRI_CMOS);
	GPIO_Config(GPIO0, UART3_Tx_Pin, GPIO_AF_PP);

	UART_OnOffConfig(UART0, ENABLE);
	UART_FifoConfig (UART0, DISABLE);
	UART_FifoReset(UART0, UART_RxFIFO);
	UART_LoopBackConfig(UART0, DISABLE);

	//UART_Config(UART0, 9600, UART_NO_PARITY, UART_1_StopBits, UARTM_8D);
	UART_Config(UART0, 38400, UART_NO_PARITY, UART_1_StopBits, UARTM_8D);
	UART_RxConfig(UART0, ENABLE);
	EIC_IRQChannelPriorityConfig(UART0_IRQChannel, 1);
	EIC_IRQChannelConfig(UART0_IRQChannel, ENABLE);
	EIC_IRQConfig(ENABLE);
	UART_ItConfig(UART0,UART_RxBufNotEmpty, ENABLE);

	UART_OnOffConfig(UART1, ENABLE);
	UART_FifoConfig (UART1, DISABLE);
	UART_FifoReset(UART1, UART_RxFIFO);
	UART_LoopBackConfig(UART1, DISABLE);
	UART_Config(UART1, 19200, UART_NO_PARITY, UART_1_StopBits, UARTM_8D);
	UART_RxConfig(UART1, ENABLE);
	EIC_IRQChannelPriorityConfig(UART1_IRQChannel, 1);
	EIC_IRQChannelConfig(UART1_IRQChannel, ENABLE);
	EIC_IRQConfig(ENABLE);
	UART_ItConfig(UART1,UART_RxBufNotEmpty, ENABLE);

	UART_OnOffConfig(UART2, ENABLE);
	UART_FifoConfig (UART2, DISABLE);
	UART_FifoReset(UART2, UART_RxFIFO);
	UART_LoopBackConfig(UART2, DISABLE);
	UART_Config(UART2, 19200, UART_NO_PARITY, UART_1_StopBits, UARTM_8D);
	UART_RxConfig(UART2, ENABLE);
	EIC_IRQChannelPriorityConfig(UART2_IRQChannel, 1);
	EIC_IRQChannelConfig(UART2_IRQChannel, ENABLE);
	EIC_IRQConfig(ENABLE);
	UART_ItConfig(UART2,UART_RxBufNotEmpty, ENABLE);

	UART_OnOffConfig(UART3, ENABLE);
	UART_FifoConfig (UART3, DISABLE);
	UART_FifoReset(UART3, UART_RxFIFO);
	UART_LoopBackConfig(UART3, DISABLE);
	//UART_Config(UART3, 9600, UART_NO_PARITY, UART_1_StopBits, UARTM_8D);
	UART_Config(UART3, 38400, UART_NO_PARITY, UART_1_StopBits, UARTM_8D);
	UART_RxConfig(UART3, ENABLE);
	EIC_IRQChannelPriorityConfig(UART3_IRQChannel, 1);
	EIC_IRQChannelConfig(UART3_IRQChannel, ENABLE);
	EIC_IRQConfig(ENABLE);
	UART_ItConfig(UART3,UART_RxBufNotEmpty, ENABLE);

	EIC_IRQChannelPriorityConfig(T1TIMI_IRQChannel, 1);
	EIC_IRQChannelConfig(T1TIMI_IRQChannel, ENABLE);
	EIC_IRQConfig(ENABLE);
	TIM_FlagClear(TIM1, TIM_TOF);
	TIM_Init(TIM1);
	TIM_PrescalerConfig(TIM1, 0x04);
	TIM_CounterConfig(TIM1, TIM_START);
	TIM_ITConfig(TIM1, TIM_TO_IT, DISABLE);

	EIC_IRQChannelPriorityConfig(T2TIMI_IRQChannel, 1);
	EIC_IRQChannelConfig(T2TIMI_IRQChannel, ENABLE);
	EIC_IRQConfig(ENABLE);
	TIM_FlagClear(TIM2, TIM_TOF);
	TIM_Init(TIM2);
	TIM_PrescalerConfig(TIM2,0x04);
	TIM_CounterConfig(TIM2, TIM_START);
	TIM_ITConfig(TIM2, TIM_TO_IT, DISABLE);

	if (Flash_Enable)
	{
		FLASH_DeInit();
		FLASH_WaitForLastOperation();
		FLASH_WriteProtectionCmd(FLASH_BANK1_SECTOR0, DISABLE);
		FLASH_WaitForLastOperation();
		FLASH_WaitForLastOperation();
		FLASH_WriteProtectionCmd(FLASH_BANK1_SECTOR0, DISABLE);
		FLASH_WaitForLastOperation();
	}

	/*
	WDG_ECITConfig (DISABLE);
	WDG_CntOnOffConfig (DISABLE);
	WDG_PeriodValueConfig (1000000000);
	EIC_IRQChannelPriorityConfig(WDG_IRQChannel, 1);
	EIC_IRQChannelConfig(WDG_IRQChannel, ENABLE);
	EIC_IRQConfig(ENABLE);
	WDG_ECITConfig (ENABLE);
	WDG_CntOnOffConfig (ENABLE);
	*/

	GPIO_Config (GPIO1, 0x6000, GPIO_AF_OD);
	I2C_Init (I2C0);
	I2C_FCLKConfig (I2C0);
	I2C_FlagClear(I2C0, I2C_ENDAD);
	I2C_OnOffConfig (I2C0, ENABLE);
	I2C_SpeedConfig (I2C0, 100000);
	I2C_AcknowledgeConfig (I2C0, ENABLE);

	GPIO_Config(GPIO1, 0x0003, GPIO_HI_AIN_TRI);
	ADC12_Init();
	ADC12_PrescalerConfig(500);
	ADC12_ModeConfig (ADC12_SINGLE);

	GPIO_Config(GPIO2, 0x02, GPIO_AF_PP);
	EMI_Config(EMI_BANK0, EMI_SIZE_16, EMI_15_WaitStates);
	EMI_Enable(EMI_BANK0, ENABLE);

	GPIO_Config(GPIO0, PO_P0_OUT, GPIO_OUT_PP);
	GPIO0->PD |= PO_RESET + PO_MP3_UPDATE;
	GPIO0->PD &= ~(PO_CL_TX + PO_TL_TX);

	GPIO_Config(GPIO1, PI_TEST, GPIO_IN_TRI_CMOS);
	GPIO_Config(GPIO1, PO_P12_P19 + PO_P10_P12, GPIO_OUT_PP);
	GPIO1->PD &= ~(PO_P12_P19 + PO_P10_P12);

	GPIO_Config(GPIO2, PI_P22_P29 + PI_PEI_ICALL, GPIO_IN_TRI_CMOS);
	GPIO_Config(GPIO2, PO_IO_SEL + PO_SCL_SEL_3, GPIO_OUT_PP);
	GPIO2->PD &= ~PO_IO_SEL;

	GPIO2->PD |= PO_SCL_SEL_3;
	GPIO1->PD |= PO_SCL_SEL_1;
	GPIO1->PD &= ~(PO_SCL_SEL_2 + PO_SCL_SEL_1);

	A_Port_In[0] = Port_RW_Data(1, 0);	// 0 0001
	A_Port_In[1] = Port_RW_Data(1, 1);	// 1 0010
	A_Port_In[2] = Port_RW_Data(1, 2);	// 2 0011
	A_Port_In[3] = Port_RW_Data(1, 3);	// 3 0100
	A_Port_In[4] = Port_RW_Data(1, 4);	// 4 0101
	A_Port_ST[0] = A_Port_In[0];
	A_Port_ST[1] = A_Port_In[1];
	A_Port_ST[2] = A_Port_In[2];
	A_Port_ST[3] = A_Port_In[3];
	A_Port_ST[4] = A_Port_In[4];

	temp8 = Port_RW_Data(2, 0);
	temp8 = Port_RW_Data(2, 1);
	temp8 = Port_RW_Data(2, 2);

	if ((A_Port_In[0] & PI_PAC_AB) != PI_PAC_AB)
    {
		T_Me_AB = 1;
		T_Me_ID = A_RID[VAPAC];
		CL_Tick = CL_TIME_MSUB;
    }
	else
	{
		T_Me_AB = 2;
		T_Me_ID = A_RID[VBPAC];
		CL_Tick = CL_TIME_SSUB;
	}

	//Debug_msg(0xB0);
	for (i=0 ; i<AS_FSYS ; i++){
		A_FSys[i] = (u8)(*(u32*)(0x400C1000 + (i * 4)));
		//Debug_msg(A_FSys[i]);
	}
	//Debug_msg(0xB1);
	for (i=0 ; i<AS_FVOL ; i++){
		A_FVol[i] = (u8)(*(u32*)(0x400C2000 + (i * 4)));
		//Debug_msg(A_FVol[i]);
	}
	/*
	Debug_msg(0xBA);
	Debug_msg(A_FSys[I_FIRMVER1]);
	Debug_msg(A_FSys[I_FIRMVER2]);
	Debug_msg(A_FSys[I_FIRMVER3]);
	Debug_msg(0xBC);
	Debug_msg(A_FVol[I_V_ANSSEC]);
	*/
	//program write시에 0xFF로 초기화됨.
	if ((!(A_FSys[I_FIRMVER1] == A_FirmVer[0] && A_FSys[I_FIRMVER2] == A_FirmVer[1] && A_FSys[I_FIRMVER3] == A_FirmVer[2])) || A_FVol[I_V_ANSSEC] > 5)
	{
		A_FSys[I_UPGRADE] = 0;
		A_FSys[I_FIRMVER1] = A_FirmVer[0];
		A_FSys[I_FIRMVER2] = A_FirmVer[1];
		A_FSys[I_FIRMVER3] = A_FirmVer[2];
		if (T_Me_AB == 2)
		{
			HexIncDec(&Temp_H, &Temp_L, 1);
		}
		A_FSys[I_CARNUM1] = Temp_H;
		A_FSys[I_CARNUM2] = Temp_L;
		A_FSys[I_DAYLIGHT] = 0;
		A_FSys[I_FILESIZE1] = 0;
		A_FSys[I_FILESIZE2] = 0;
		A_FSys[I_FILESIZE3] = 0;
		A_FSys[I_TOTCHKSUM] = 0;

		A_FVol[I_V_OCC] = 25;
		A_FVol[I_V_DPO] = 20;
		A_FVol[I_V_PEI] = 25;
		A_FVol[I_V_AUTO] = 10;
		A_FVol[I_V_TLIN] = 0;		// 0-6
		A_FVol[I_V_TLOUT] = 29;
		A_FVol[I_V_NORCSP] = 17;
		A_FVol[I_V_NORISP] = 17;
		A_FVol[I_V_NORESP] = 22;
		A_FVol[I_V_SOFTCSP] = 13;
		A_FVol[I_V_SOFTISP] = 13;
		A_FVol[I_V_SOFTESP] = 18;
		A_FVol[I_V_ANSSW] = 1;
		A_FVol[I_V_ANSSEC] = 5;
		A_FVol[I_V_I70H] = 0x05;	// ma 05
		A_FVol[I_V_I70L] = 0x00;
		A_FVol[I_V_I80H] = 0x06;	// ma 06
		A_FVol[I_V_I80L] = 0x00;
		A_FVol[I_V_O80] = 3;
		A_FVol[I_V_O85] = 6;

		if (Flash_Enable)
		{
			FLASH_EraseSector(FLASH_BANK1_SECTOR0);
			FLASH_WaitForLastOperation();

			for (i=0 ; i<AS_FSYS ; i++)
			{
				FLASH_WriteWord(0x000C1000 + (i * 4), (u32)(A_FSys[(u8)i]));
				FLASH_WaitForLastOperation();
			}

			FLASH_EraseSector(FLASH_BANK1_SECTOR1);
			FLASH_WaitForLastOperation();
			for (i=0 ; i<AS_FVOL ; i++)
			{
				FLASH_WriteWord(0x000C2000 + (i * 4), (u32)(A_FVol[(u8)i]));
				FLASH_WaitForLastOperation();
			}
			Debug_msg('F');
		}
		Debug_msg('S');
	}

	A_CarNum[0][0] = A_FSys[I_CARNUM1];
	A_CarNum[0][1] = A_FSys[I_CARNUM2];
	A_TL_CarNum[0][0] = A_FSys[I_CARNUM1];
	A_TL_CarNum[0][1] = A_FSys[I_CARNUM2];

/*
	Debug_msg(0x17);
	Debug_msg(A_CarNum[0][0]);
	Debug_msg(A_CarNum[0][1]);
	Debug_msg(A_TL_CarNum[0][0]);
	Debug_msg(A_TL_CarNum[0][1]);
*/
	
#if PAC_PROTOCOL_R10
	for(i=1;i<4;i++){
		A_CarNum[i][0] = 0;//A_CarNum[0][0];
		A_CarNum[i][1] = 0;//A_CarNum[0][1];
	}
	for(i=1;i<5;i++){
		A_TL_CarNum[i][0] = 0;//A_TL_CarNum[0][0];
		A_TL_CarNum[i][1] = 0;//A_TL_CarNum[0][1];
	}
#endif

	//for (i=0 ; i<AS_FSYS ; i++) A_ChkS_FSys[0] = A_ChkS_FSys[0] ^ A_FSys[i];
	for (i=0 ; i<AS_FVOL ; i++) A_ChkS_FVol[0] = A_ChkS_FVol[0] ^ A_FVol[i];

#if PAC_PROTOCOL_R10
	A_ChkS_FVol[1] = A_ChkS_FVol[0];
	A_ChkS_FVol[2] = A_ChkS_FVol[0];
	A_ChkS_FVol[3] = A_ChkS_FVol[0];
#endif
	//GPIO0->PD &= ~PO_MP3_UPDATE;	//---
	//while(1);						//---

	////////////////////////////////////////////////////////////////////////////

	CL_State = ST_CL_SEL_PAC;
	CL_TCnt = CL_Tick;
	TIM_ITConfig(TIM1, TIM_TO_IT, ENABLE);

	while (CL_State == ST_CL_SEL_PAC)
	{
		if (CL_OK_Packet)
		{
			Set_MS_State(SET_SUB);
			CL_State = ST_CL_POllING;
			break;
		}
	}

	for (i=1 ; i<10 ; i++)
	{
		Set_Vol_I2C(i);
	}

	////////////////////// LOOP ////////////////////////////////////////////////////

	while(1)
	{
		Device_Check();
		Port_Check();

		if ((T_State & F_CNCS_MODE) == F_CNCS_MODE)
		{
			/////////////// CNCS  ///////////////

			if (CL_OK_Packet)
			{
				CL_OK_Packet = false;
				CL_TCnt = CL_Tick;
				CL_Rx_Turn = true;
			}

			if (CL_Rx_Turn)
			{
				CL_Rx_Turn = false;

				if (CL_Rx_DstID == T_Me_ID)
				{
					///// +++++
				}
			}
		}
		else
		{
			/////////////// CL POLLING  ///////////////

			if (CL_OK_Packet)
			{
				CL_OK_Packet = false;
				CL_TCnt = CL_Tick;
				CL_Rx_Turn = true;

				if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)
				{
					if (T_Me_AB == 1)
					{
						if ((A_Port_ST[0] & PI_BCAB) == PI_BCAB && CL_Rx_SrcID == VBPAC && CL_Rx_SrcID != VAPAC)
						{
							Set_MS_State(SET_SUB);
						}
					}
					else
					{
						if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB && CL_Rx_SrcID == VAPAC && CL_Rx_SrcID != VBPAC)
						{
							Set_MS_State(SET_SUB);
						}
					}
				}
			}

			if (CL_Tx_Turn)
			{
				CL_Tx_Turn = false;

				if (CL_PollM_IDX == 6)
				{
					CL_Tx_ID = CL_Poll1_Arr[CL_Poll1_IDX];
				}
				else if (CL_PollM_IDX == 7)
				{
					CL_Tx_ID = CL_Poll2_Arr[CL_Poll2_IDX];
				}
				else if (CL_PollM_IDX == 8)
				{
					CL_Tx_ID = CL_Poll3_Arr[CL_Poll3_IDX];
				}
				else
				{
					CL_Tx_ID = CL_PollM_Arr[CL_PollM_IDX];
				}

				Make_Data(CL_Tx_ID);
				if (A_CLMsg_Num[CL_Tx_ID]++ >= 100) A_CLMsg_Num[CL_Tx_ID] = 0;
				CL_Send(T_Me_ID, A_RID[CL_Tx_ID], A_CLMsg_Num[CL_Tx_ID], 0x10, CL_Tx_Len);
			}

			if (CL_Rx_Turn)
			{
				CL_Rx_Turn = false;
				CL_Rx_ID = CL_Rx_SrcID;

				Read_CL_Data(CL_Rx_SrcID, CL_Rx_DstID);
			}
		}

		if ((T_State & F_COUPLING_MODE) != F_COUPLING_MODE)
		{
			/////////////// TL POLLING  ///////////////

			if ((T_State & F_PAC_MASTER) == F_PAC_MASTER)
			{
				TL_State = ST_TL_POLLING;
			}
			else
			{
				TL_State = ST_TL_WAIT;
			}

			if (TL_OK_Packet)
			{
				TL_OK_Packet = false;

				if (TL_State == ST_TL_WAIT) TL_TCnt = TL_Tick;

				if ((TL_Rx_Cmd & 0xC0) == 0xC0)		// coupling req
				{
					T_State |= F_COUPLING_MODE;
					P_Coupling_Old = A_Port_ST[0] & 0x0F;

					TL_State = ST_TL_COUPLING;
					TL_Tick = TL_TIME_COUPLING;
					TL_TCnt = TL_Tick;

					P_Coupling_ID = 0;
					Coupling_CMD = TLST_START;
					A_Port_Out[2] &= ~(PO_RS485_RA + PO_RS485_RB);
					Port_RW_Data(2, 2);
					TIM_ITConfig(TIM2, TIM_TO_IT, ENABLE);

					TL_Tx_Turn = false;
					TL_Rx_Turn = false;
				}
				else
				{
					TL_Rx_Turn = true;
				}
			}

			if (TL_Tx_Turn && (T_State & F_PAC_MASTER) == F_PAC_MASTER)	// && P_Coupling_ID > 1)
			{
				TL_Tx_Turn = false;

				if (P_Coupling_ID != TL_Poll_ID) TL_Chk_ID = TL_Poll_ID;

				if (P_Coupling_ID != TL_Poll_ID)
				{
					Make_Data(40);

					TL_Tx_Data[TL_Tx_Len++] = A_TL_CarNum[TL_Poll_ID][0];	// 74
					TL_Tx_Data[TL_Tx_Len++] = A_TL_CarNum[TL_Poll_ID][1];	// 75
					TL_Tx_Data[TL_Tx_Len++] = TL_Poll_ID;					// 76
					TL_Tx_Data[TL_Tx_Len++] = T_Cars_Err;					// 77

					TL_Send(P_Coupling_ID, TL_Poll_ID, TL_Tx_MCnt++, 0x20, TL_Tx_Len);
				}
			}

			if (TL_Rx_Turn)
			{
				u8	tempval, temploc;

				TL_Rx_Turn = false;

				if (P_Coupling_ID != TL_Rx_SrcID)
				{
					A_TL_CarNum[TL_Rx_SrcID][0] = TL_Rx_Data[62];
					A_TL_CarNum[TL_Rx_SrcID][1] = TL_Rx_Data[63];

					AP_Train_ST[TL_Rx_SrcID][0] = TL_Rx_Data[53];
					AP_Train_ST[TL_Rx_SrcID][1] = TL_Rx_Data[54];
					AP_Train_ST[TL_Rx_SrcID][2] = TL_Rx_Data[55];
				#if !PAC_PROTOCOL_R10
					cra_temp = (TL_Rx_Data[56] & 0x08)>>3;
					crb_temp = (TL_Rx_Data[56] & 0x80)>>7;
					if(TL_Rx_Data[53] & 0x80){//CRB Headbit en
						R_CI_Fault[((TL_Rx_SrcID-1)*2)+1] = cra_temp;
						R_CI_Fault[((TL_Rx_SrcID-1)*2)] = crb_temp;
					}
					else if(TL_Rx_Data[53] & 0x08){//CRA Headbit en
						R_CI_Fault[((TL_Rx_SrcID-1)*2)] = cra_temp;
						R_CI_Fault[((TL_Rx_SrcID-1)*2)+1] = crb_temp;
					}
					AP_Train_ST[TL_Rx_SrcID][3] = TL_Rx_Data[56] & 0x77;
				#else
					AP_Train_ST[TL_Rx_SrcID][3] = TL_Rx_Data[56];
				#endif
					AP_Train_ST[TL_Rx_SrcID][4] = TL_Rx_Data[57];
					AP_Train_ST[TL_Rx_SrcID][5] = TL_Rx_Data[58];
					AP_Train_ST[TL_Rx_SrcID][6] = TL_Rx_Data[59];
				#if PAC_PROTOCOL_R10
					cra_temp = (TL_Rx_Data[60] & 0x04)>>2;
					cra_temp = cra_temp | (TL_Rx_Data[60] & 0x08);
					crb_temp = (TL_Rx_Data[60] & 0x40)>>2;
					crb_temp = crb_temp | (TL_Rx_Data[60] & 0x80);
					AP_Train_ST[TL_Rx_SrcID][7] = (TL_Rx_Data[60] & 0x33);
					AP_Train_ST[TL_Rx_SrcID][8] = crb_temp | cra_temp;
					/*Debug_msg(0xA1);
					Debug_msg(TL_Rx_Data[61]);
					Debug_msg(TL_Rx_Data[53]);
					Debug_msg(TL_Rx_SrcID);*/

					cra_temp = (TL_Rx_Data[61] & 0x0F);
					crb_temp = ((TL_Rx_Data[61] & 0xF0)>>4);
					if(TL_Rx_Data[53] & 0x80){//CRB Headbit en
						AP_CID_LIC_Rx[((TL_Rx_SrcID-1)*2)+1] = cra_temp;
						AP_CID_LIC_Rx[(TL_Rx_SrcID-1)*2] = crb_temp;
					}
					else if(TL_Rx_Data[53] & 0x08){//CRA Headbit en
						AP_CID_LIC_Rx[(TL_Rx_SrcID-1)*2] = cra_temp;
						AP_CID_LIC_Rx[((TL_Rx_SrcID-1)*2)+1] = crb_temp;
					}
					/*
					if((TL_Rx_SrcID % 2)==1){// A rack
						cra_temp = (TL_Rx_Data[61] & 0x0F);
						AP_CID_LIC_Rx[TL_Rx_SrcID] = cra_temp;
						Debug_msg(0xA2);
						Debug_msg(cra_temp);
					}
					else{// B rack
						crb_temp = ((TL_Rx_Data[61] & 0xF0)>>4);
						AP_CID_LIC_Rx[TL_Rx_SrcID] = crb_temp;
						Debug_msg(0xA3);
						Debug_msg(crb_temp);
					}*/
				#else
					AP_Train_ST[TL_Rx_SrcID][7] = TL_Rx_Data[60];
					AP_Train_ST[TL_Rx_SrcID][8] = TL_Rx_Data[61];
				#endif
				}

				if ((T_State & F_PAC_MASTER) != F_PAC_MASTER)
				{
					if (P_Coupling_ID == 0)
					{
						Temp_H = A_CarNum[0][0];
						Temp_L = A_CarNum[0][1];

						if (T_Me_AB == 1)
						{
							HexIncDec(&Temp_H, &Temp_L, 1);
						}
						else
						{
							HexIncDec(&Temp_H, &Temp_L, 0);
						}

						if ((A_CarNum[0][0] == TL_Rx_Data[74] && A_CarNum[0][1] == TL_Rx_Data[75]) ||
							(Temp_H == TL_Rx_Data[74] && Temp_L == TL_Rx_Data[75]))
						{
							P_Coupling_ID = TL_Rx_Data[76];
							T_Train_Len = TL_Rx_Data[73];
							P_CCI = T_Train_Len;
							TL_CAB_ID = TL_Rx_SrcID;
							P_Coupling_Old = A_Port_ST[0] & 0x0F;
						}
					}

					if (P_Coupling_ID == TL_Rx_DstID) TL_CAB_ID = TL_Rx_SrcID;

					if (TL_Rx_SrcID == TL_CAB_ID)//CAB key insert train 이부분은 실행하지 않음.CAB key가 없는 경우에는 실행됨.
					{
						P_Broad_Device = TL_Rx_Data[0];
						AP_TrainNum[0] = TL_Rx_Data[1];
						AP_TrainNum[1] = TL_Rx_Data[2];
						AP_TrainNum[2] = TL_Rx_Data[3];
						AP_CrewID[0] = TL_Rx_Data[4];
						AP_CrewID[1] = TL_Rx_Data[5];
						AP_CrewID[2] = TL_Rx_Data[6];
						AP_TrigID[0] = TL_Rx_Data[7];
						AP_TrigID[1] = TL_Rx_Data[8];
						AP_TrigID[2] = TL_Rx_Data[9];
						P_St_Type = TL_Rx_Data[10];
						AP_St_Start[0] = TL_Rx_Data[11];
						AP_St_Start[1] = TL_Rx_Data[12];
						AP_St_Now[0] = TL_Rx_Data[13];
						AP_St_Now[1] = TL_Rx_Data[14];
						AP_St_Next[0] = TL_Rx_Data[15];
						AP_St_Next[1] = TL_Rx_Data[16];
						AP_St_Dest[0] = TL_Rx_Data[17];
						AP_St_Dest[1] = TL_Rx_Data[18];
						ESpk_State = TL_Rx_Data[19];
						CISpk_State = TL_Rx_Data[20];
						P_Disp_Msg = TL_Rx_Data[21];
						P_LED_MR = TL_Rx_Data[22];
						P_PR_Active = TL_Rx_Data[23];
						AP_PR_Msg[0] = TL_Rx_Data[24];
						AP_PR_Msg[1] = TL_Rx_Data[25];
						AP_PAC_Vec[0] = TL_Rx_Data[26];
						AP_PAC_Vec[1] = TL_Rx_Data[27];
						AP_FSDI_Vec[0] = TL_Rx_Data[28];
						AP_FSDI_Vec[1] = TL_Rx_Data[29];
						AP_DD_Vec1[0] = TL_Rx_Data[30];
						AP_DD_Vec1[1] = TL_Rx_Data[31];
						AP_DD_Vec2[0] = TL_Rx_Data[32];
						AP_DD_Vec2[1] = TL_Rx_Data[33];
						AP_PII_Vec[0] = TL_Rx_Data[34];
						AP_PII_Vec[1] = TL_Rx_Data[35];
						AP_PPL_Vec[0] = TL_Rx_Data[36];
						AP_PPL_Vec[1] = TL_Rx_Data[37];
						AP_PPD_Vec[0] = TL_Rx_Data[38];
						AP_PPD_Vec[1] = TL_Rx_Data[39];
						AP_SP_Vec[0] = TL_Rx_Data[40];
						AP_SP_Vec[1] = TL_Rx_Data[41];
						for (i=0 ; i<10 ; i++)
						{
							AP_St_Skip[i] = TL_Rx_Data[42 + i];
						}
						//P_Coupling_ID = TL_Rx_Data[52];

						for (i=0 ; i<8 ; i++)
						{
							AP_CID_Rx[i] = TL_Rx_Data[64 + i];
						}
					#if 0
						/*temploc = (0x03 << ((P_Coupling_ID - 1)*2));
						tempval = TL_Rx_Data[72] & ~(temploc);
						T_CI_Fault |= tempval;*/
						
						AP_CI_RFLT = TL_Rx_Data[72];
						/*Debug_msg(0xA1);
						Debug_msg(P_Coupling_ID);
						Debug_msg(TL_Rx_SrcID);
						Debug_msg(T_CI_Fault);*/
					#else
						//CAB이 없는 차의 CI Fault masking
						if(P_Coupling_ID == 0){
							temploc = (0x03 << ((P_Coupling_ID)*2));
						}
						else{
							temploc = (0x03 << ((P_Coupling_ID - 1)*2));
						}
						tempval = TL_Rx_Data[72] & (~(temploc));//타차의 CI Fault masking
						T_CI_Fault |= tempval;//자차와 타차의 or 연산.
					#endif
						T_Train_Len = TL_Rx_Data[73];

						T_Cars_Err = TL_Rx_Data[77];
						if (T_Cars_Err > 0)
						{
							for (i=1 ; i<5 ; i++)
							{
								temp8 = (1 << i);
								if ((T_Cars_Err & temp8) == temp8)
								{
									//AP_Train_ST[TL_Chk_ID][0] = ???
									AP_Train_ST[i][1] = 0xFF;
									AP_Train_ST[i][2] = 0xFF;
									AP_Train_ST[i][3] = 0x77;
									AP_Train_ST[i][4] = 0xFF;
									AP_Train_ST[i][5] = 0xFF;
									AP_Train_ST[i][6] = 0xBB;
									//Error 발생시 ?? 추가요.
									//
									//이전 normal state일 경우.
									AP_Train_ST[i][7] = 0x00;
									AP_Train_ST[i][8] = 0x99;
								}
							}
						}

						if (P_Coupling_ID == TL_Rx_DstID && (T_State & F_PAC_MAIN) == F_PAC_MAIN)
						{
							Make_Data(40);
							//for(i=0 ; i<0x2FFF ; i++);
							TL_Tx_Cmd = 0x21;
							if ((A_Port_ST[0] & 0x0F) != P_Coupling_Old) TL_Tx_Cmd |= TLST_START;
							TL_Send(P_Coupling_ID, TL_CAB_ID, TL_Tx_MCnt++, TL_Tx_Cmd, TL_Tx_Len);
						}
					}	// cab_id
				}

				if (((T_State & F_PAC_MASTER) == F_PAC_MASTER) && (P_Coupling_ID != TL_Rx_SrcID))	// 단지 업데이트
				{
					AP_Train_ST[TL_Rx_Data[52]][0] = TL_Rx_Data[53];
					AP_Train_ST[TL_Rx_Data[52]][1] = TL_Rx_Data[54];
					AP_Train_ST[TL_Rx_Data[52]][2] = TL_Rx_Data[55];
				#if !PAC_PROTOCOL_R10
					cra_temp = (TL_Rx_Data[56] & 0x08)>>3;
					crb_temp = (TL_Rx_Data[56] & 0x80)>>7;
					if(TL_Rx_Data[53] & 0x80){//CRB Headbit en
						R_CI_Fault[((TL_Rx_SrcID-1)*2)+1] = cra_temp;
						R_CI_Fault[((TL_Rx_SrcID-1)*2)] = crb_temp;
					}
					else if(TL_Rx_Data[53] & 0x08){//CRA Headbit en
						R_CI_Fault[((TL_Rx_SrcID-1)*2)] = cra_temp;
						R_CI_Fault[((TL_Rx_SrcID-1)*2)+1] = crb_temp;
					}
					AP_Train_ST[TL_Rx_Data[52]][3] = TL_Rx_Data[56] & 0x77;
				#else
					AP_Train_ST[TL_Rx_Data[52]][3] = TL_Rx_Data[56];
				#endif
					AP_Train_ST[TL_Rx_Data[52]][4] = TL_Rx_Data[57];
					AP_Train_ST[TL_Rx_Data[52]][5] = TL_Rx_Data[58];
					AP_Train_ST[TL_Rx_Data[52]][6] = TL_Rx_Data[59];
					
				#if PAC_PROTOCOL_R10
					//
					cra_temp = (TL_Rx_Data[60] & 0x04)>>2;
					cra_temp = cra_temp | (TL_Rx_Data[60] & 0x08);
					crb_temp = (TL_Rx_Data[60] & 0x40)>>2;
					crb_temp = crb_temp | (TL_Rx_Data[60] & 0x80);
					AP_Train_ST[TL_Rx_Data[52]][7] = (TL_Rx_Data[60] & 0x33);
					AP_Train_ST[TL_Rx_Data[52]][8] = crb_temp | cra_temp;
					/*Debug_msg(0xB1);
					Debug_msg(TL_Rx_Data[61]);
					Debug_msg(TL_Rx_Data[53]);
					Debug_msg(TL_Rx_SrcID);*/
					cra_temp = (TL_Rx_Data[61] & 0x0F);
					crb_temp = ((TL_Rx_Data[61] & 0xF0)>>4);
					if(TL_Rx_Data[53] & 0x80){//CRB Headbit en
						AP_CID_LIC_Rx[((TL_Rx_SrcID-1)*2)+1] = cra_temp;
						AP_CID_LIC_Rx[(TL_Rx_SrcID-1)*2] = crb_temp;
						//AP_CID_LIC_Rx[TL_Rx_SrcID] = cra_temp;
						//AP_CID_LIC_Rx[TL_Rx_SrcID-1] = crb_temp;
					}
					else if(TL_Rx_Data[53] & 0x08){//CRA Headbit en
						AP_CID_LIC_Rx[(TL_Rx_SrcID-1)*2] = cra_temp;
						AP_CID_LIC_Rx[((TL_Rx_SrcID-1)*2)+1] = crb_temp;
						//AP_CID_LIC_Rx[TL_Rx_SrcID-1] = cra_temp;
						//AP_CID_LIC_Rx[TL_Rx_SrcID] = crb_temp;
					}
					/*
					if((TL_Rx_Data[52] % 2)==1){// A rack
						cra_temp = (TL_Rx_Data[61] & 0x0F);
						AP_CID_LIC_Rx[TL_Rx_Data[52]] = cra_temp;
						Debug_msg(0xB2);
						Debug_msg(cra_temp);
					}
					else{// B rack
						crb_temp = ((TL_Rx_Data[61] & 0xF0)>>4);
						AP_CID_LIC_Rx[TL_Rx_Data[52]] = crb_temp;
						Debug_msg(0xB3);
						Debug_msg(crb_temp);
					}
					*/
				#else
					AP_Train_ST[TL_Rx_Data[52]][7] = TL_Rx_Data[60];
					AP_Train_ST[TL_Rx_Data[52]][8] = TL_Rx_Data[61];
				#endif
				
					A_TL_CarNum[TL_Rx_Data[52]][0] = TL_Rx_Data[62];
					A_TL_CarNum[TL_Rx_Data[52]][1] = TL_Rx_Data[63];

				#if 0	
					//CAB key insert시에 실행.CAB key가 없는 경우 실행되지 않음.
					/*temploc = (0x03 << ((TL_Rx_SrcID - 1)*2));//0x03
					T_CI_Fault = T_CI_Fault & ~(temploc);//0xFC
					tempval = TL_Rx_Data[72] & temploc;//0x03
					T_CI_Fault |= tempval;*/
					AP_CI_RFLT = TL_Rx_Data[72];
					/*Debug_msg(0xA2);
					Debug_msg(P_Coupling_ID);
					Debug_msg(TL_Rx_SrcID);
					Debug_msg(T_CI_Fault);*/
				#else
					//CAB이 존재하는 차량의 masking
					if(TL_Rx_SrcID == 0){
						temploc = (0x03 << ((TL_Rx_SrcID)*2));//0x03
					}
					else{
						temploc = (0x03 << ((TL_Rx_SrcID - 1)*2));//0x03
					}
					T_CI_Fault = T_CI_Fault & ~(temploc);//0xFC 자차의 data delete하고 타차의 CI Fault masking
					tempval = TL_Rx_Data[72] & temploc;//0x03 입력된 자차 CI Fault값을 갖는다.
					T_CI_Fault |= tempval;
				#endif
				}
			}	// rxturn
		}
		else
		{
			TL_State = ST_TL_COUPLING;

			/////////////// TL COUPLLING  ///////////////

			if (TL_OK_Packet)
			{
				TL_OK_Packet = false;

				TLC_State_ID = TL_Rx_DstID;
				TLC_Status = TL_Rx_MCnt;

				TL_Train_Len = TL_Rx_SrcID;
				TL_Car_Temp[0] = TL_Rx_Data[0];
				TL_Car_Temp[1] = TL_Rx_Data[1];

				if (TL_Rx_SrcID > 0)
				{
					A_TL_CarNum[TL_Rx_SrcID][0] = TL_Rx_Data[0];
					A_TL_CarNum[TL_Rx_SrcID][1] = TL_Rx_Data[1];
				}

				switch (TLC_Status)
				{
				case CS_CAB_WAIT:
					P_CCI = 0x20;
					T_State &= ~F_COUPLING_MODE;
					TL_Tick = TL_TIME_MAIN;
					TL_TCnt = TL_Tick;
					TL_State = ST_TL_WAIT;
					TIM_ITConfig(TIM2, TIM_TO_IT, DISABLE);
					break;

				case CS_COUPLING_START:
					T_Cars_Err = 0;
					P_CCI = 0x10;
					Coupling_CMD = TLST_START;
					TL_Train_Len = 0;
					TL_Coupling_ID = 0;
					TL_Car_Temp[0] = 0;
					TL_Car_Temp[1] = 0;

					HOC_State = 0;
					Pass_State = 0;

					TL_Tick = TL_TIME_COUPLING;
					TL_TCnt = TL_Tick;
					break;

				case CS_HOC_REQ:
					HOC_State |= B_HOC_REQ_EXIST;
					break;

				case CS_HOC_ACK:
					HOC_State |= B_HOC_ACK_EXIST;
					if ((Coupling_CMD & TL_PASS_TOKEN) == TL_PASS_TOKEN)
					{
						Coupling_CMD &= ~TLST_HOC;
						Coupling_CMD &= ~(TL_PASS_TOKEN + TL_TOKEN);
					}
					break;

				/*
				case CS_TOC_REQ:
					break;

				case CS_TOC_ACK:
					break;
				*/

				case CS_HOC_RB_REQ:
					HOC_State |= B_RB_HOC_REQ;
					break;

				case CS_HOC_RB_ACK:
					HOC_State |= B_RB_HOC_ACK;
					if ((Coupling_CMD & TL_PASS_TOKEN) == TL_PASS_TOKEN)
					{
						Coupling_CMD &= ~TLST_HOC;
						Coupling_CMD &= ~(TL_PASS_TOKEN + TL_TOKEN);
					}
					break;

				case CS_HOC_RA_REQ:
					HOC_State |= B_RA_HOC_REQ;
					break;

				case CS_HOC_RA_ACK:
					HOC_State |= B_RA_HOC_ACK;
					if ((Coupling_CMD & TL_PASS_TOKEN) == TL_PASS_TOKEN)
					{
						Coupling_CMD &= ~TLST_HOC;
						Coupling_CMD &= ~(TL_PASS_TOKEN + TL_TOKEN);
					}
					break;

				case CS_PASS_RB_TOKEN:
					Pass_State |= B_RB_PASS_REQ;
					break;

				case CS_PASS_RB_ACK:
					Pass_State |= B_RB_PASS_ACK;
					if ((Coupling_CMD & TL_PASS_TOKEN) == TL_PASS_TOKEN)
					{
						Coupling_CMD &= ~(TL_PASS_TOKEN + TL_TOKEN);
					}
					break;

				case CS_PASS_RA_TOKEN:
					Pass_State |= B_RA_PASS_REQ;
					break;

				case CS_PASS_RA_ACK:
					Pass_State |= B_RA_PASS_ACK;
					if ((Coupling_CMD & TL_PASS_TOKEN) == TL_PASS_TOKEN)
					{
						Coupling_CMD &= ~(TL_PASS_TOKEN + TL_TOKEN);
					}
					break;

				case CS_11KHZ:
					break;

				case CS_COUPLING_STOP:
					break;
				}
			}

			if (TL_Tx_Turn)
			{
				TL_Tx_Turn = false;

				TLC_State_ID++;

				switch (TLC_State_ID)
				{
				case 0x01:
					TLC_Status = CS_CAB_WAIT;
					break;


				case 0x02:
					TLC_Status = CS_COUPLING_START;
					T_Cars_Err = 0;
					P_CCI = 0x10;

					Coupling_CMD = TLST_START;
					TL_Train_Len = 0;
					TL_Coupling_ID = 0;
					TL_Car_Temp[0] = 0;
					TL_Car_Temp[1] = 0;

					HOC_State = 0;
					Pass_State = 0;
					break;
				case 0x03:
				case 0x04:
					if ((T_State & F_PAC_MASTER) == F_PAC_MASTER)
					{
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x05:
					if (TL_Train_Len > 0x0F)
					{
						TL_Train_Len = 0;
						TLC_State_ID = 0x00;
					}
					break;

					//////////////////////////////////////////////////////////////////////////

				case 0x06:
					T_State &= ~F_TRAIN_HEAD;
					Coupling_CMD &= ~TLST_HEAD;

					TLC_Status = CS_HOC_REQ;

					if ((T_Me_AB == 1 && (A_Port_ST[0] & PI_ACAB) == PI_ACAB) ||
						(T_Me_AB == 2 && (A_Port_ST[0] & PI_BCAB) == PI_BCAB))
					{
						A_Port_Out[2] |= PO_RS485_RB;	 // open
					}
					/*
					else if ((T_Me_AB == 1 && (A_Port_ST[0] & PI_BCAB) == PI_BCAB) ||
							 (T_Me_AB == 2 && (A_Port_ST[0] & PI_ACAB) == PI_ACAB))
					{
						A_Port_Out[2] |= PO_RS485_RA;	 // open
					}
					*/
					else
					{
						A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					}
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x07:
				case 0x08:
					if ((T_State & F_PAC_MASTER) == F_PAC_MASTER)
					{
						Coupling_CMD |= TLST_HEAD;
						T_State |= F_TRAIN_HEAD;


						Coupling_CMD |= (TLST_HOC + TLST_TMP_HOC);
						Coupling_CMD |= (TL_TOKEN + TL_PASS_TOKEN);
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					else
					{
						T_State &= ~F_TRAIN_HEAD;
					}
					break;
				case 0x09:
					if ((T_Me_AB == 1 && (A_Port_ST[0] & PI_ACAB) == PI_ACAB && (A_Port_ST[0] & PI_ACOUPLE) != PI_ACOUPLE) ||
						(T_Me_AB == 2 && (A_Port_ST[0] & PI_BCAB) == PI_BCAB && (A_Port_ST[0] & PI_BCOUPLE) != PI_BCOUPLE))
					{
						HOC_State |= B_HOC_REQ_EXIST;
					}
					//TLC_State_ID = 0x0D	//0x15;	// add add
					break;

					////////////////////////

				case 0x0A:
					TLC_Status = CS_HOC_ACK;

					A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x0B:
				case 0x0C:
					if ((T_Me_AB == 1 && (A_Port_ST[0] & PI_ACOUPLE) != PI_ACOUPLE) ||
						(T_Me_AB == 2 && (A_Port_ST[0] & PI_BCOUPLE) != PI_BCOUPLE))
					{
						if ((HOC_State & B_HOC_REQ_EXIST) == B_HOC_REQ_EXIST)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State |= F_TRAIN_HEAD;

							Coupling_CMD |= TLST_HOC;
							Coupling_CMD |= TL_TOKEN;
							HOC_State |= B_HOC_ACK_EXIST;
							TL_Coupling_ID = 1;
							TL_Train_Len = 1;
							Make_Data(41);
							TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
						}
					}
					break;
				case 0x0D:
					if ((HOC_State & B_HOC_ACK_EXIST) == B_HOC_ACK_EXIST)
					{
						TLC_State_ID = 0x1D;	//0x25;
					}
					//TLC_State_ID = 0x0D	//0x15;	// add add
					break;

					////////////////////////

/*
				case 0x0E:
					TLC_Status = CS_TOC_REQ;

					if (((CAB_State & CAB_ON) == CAB_ON) && T_CAB_CRAB == T_PAC_CRAB)
					{
						A_Port_Out[2] |= PO_RS485_RA;	 // open
					}
					else
					{
						A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					}
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x0F:
				case 0x10:
					if (((CAB_State & CAB_ON) == CAB_ON) && T_CAB_CRAB == T_PAC_CRAB)
					{
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x11:
					break;

					////////////////////////

				case 0x0A:	//0x12:
					TLC_Status = CS_TOC_ACK;

					A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x0B:	//0x13:
				case 0x0C:	//0x14:
					if (((Couple_State & TL_COUPLED) != TL_COUPLED) && ((HOC_State & B_HOC_REQ_EXIST) == B_HOC_REQ_EXIST))
					{
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x0D:	//0x15:
					if ((HOC_State & B_HOC_ACK_EXIST) == B_HOC_ACK_EXIST)
					{
						TLC_State_ID = 0x1D;	//0x25;
					}
					break;

*/
					//////////////////////////////////////////////////////////////////////////

				case 0x0E:	//0x16:
					TLC_Status = CS_HOC_RB_REQ;

					HOC_State = 0;

					if ((Coupling_CMD & TL_TOKEN) != TL_TOKEN)
					{
						A_Port_Out[2] |= PO_RS485_RB;	 // open
						A_Port_Out[2] &= ~PO_RS485_RA;	// close
					}

					if ((T_Me_AB == 1 && (A_Port_ST[0] & PI_ACAB) == PI_ACAB) ||
						(T_Me_AB == 2 && (A_Port_ST[0] & PI_BCAB) == PI_BCAB))
					{
						A_Port_Out[2] |= PO_RS485_RB;	 // open
					}
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x0F:	//0x17:
				case 0x10:	//0x18:
					if ((Coupling_CMD & TL_TOKEN) == TL_TOKEN)
					{
						Coupling_CMD |= TL_PASS_TOKEN;
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x11:	//0x19:
					break;

					////////////////////////

				case 0x12:	//0x1A:
					TLC_Status = CS_HOC_RB_ACK;

					A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x13:	//0x1B:
				case 0x14:	//0x1C:
					if ((HOC_State & B_RB_HOC_RPT_ACK) == B_RB_HOC_RPT_ACK)
					{
						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State &= ~F_TRAIN_HEAD;
						}

						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}

					if (((HOC_State & B_RB_HOC_REQ) == B_RB_HOC_REQ) && ((Coupling_CMD & TL_TOKEN) != TL_TOKEN) && ((Coupling_CMD & TLST_TMP_HOC) != TLST_TMP_HOC))
					{
						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State &= ~F_TRAIN_HEAD;
						}

						Coupling_CMD |= (TLST_TMP_HOC + TLST_HOC);
						Coupling_CMD |= TL_TOKEN;
						HOC_State |= (B_RB_HOC_ACK + B_RB_HOC_RPT_ACK);
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x15:	//0x1D:
					break;

					///////////////////////////////////////////////////////////////////////////

				case 0x16:	//0x1E:
					TLC_Status = CS_HOC_RA_REQ;

					if ((Coupling_CMD & TL_TOKEN) != TL_TOKEN)
					{
						A_Port_Out[2] &= ~PO_RS485_RB;	// close
						A_Port_Out[2] |= PO_RS485_RA;	 // open
					}

					if ((T_Me_AB == 1 && (A_Port_ST[0] & PI_ACAB) == PI_ACAB) ||
						(T_Me_AB == 2 && (A_Port_ST[0] & PI_BCAB) == PI_BCAB))
					{
						A_Port_Out[2] |= PO_RS485_RB;	 // open
					}
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x17:	//0x1F:
				case 0x18:	//0x20:
					if ((Coupling_CMD & TL_TOKEN) == TL_TOKEN)
					{
						Coupling_CMD |= TL_PASS_TOKEN;
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x19:	//0x21:
					break;

					////////////////////////

				case 0x1A:	//0x22:
					TLC_Status = CS_HOC_RA_ACK;

					A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x1B:	//0x23:
				case 0x1C:	//0x24:
					if ((HOC_State & B_RA_HOC_RPT_ACK) == B_RA_HOC_RPT_ACK)
					{
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);

						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State |= F_TRAIN_HEAD;
						}
					}

					if (((HOC_State & B_RA_HOC_REQ) == B_RA_HOC_REQ) && ((Coupling_CMD & TL_TOKEN) != TL_TOKEN) && ((Coupling_CMD & TLST_TMP_HOC) != TLST_TMP_HOC))
					{
						Coupling_CMD |= (TLST_TMP_HOC + TLST_HOC);
						Coupling_CMD |= TL_TOKEN;
						HOC_State |= (B_RA_HOC_ACK + B_RA_HOC_RPT_ACK);
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);

						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State |= F_TRAIN_HEAD;
						}
					}
					break;
				case 0x1D:	//0x25:
					if (((HOC_State & B_RB_HOC_ACK) == B_RB_HOC_ACK) || ((HOC_State & B_RA_HOC_ACK) == B_RA_HOC_ACK))
					{
						TLC_State_ID = 0x0D;	//0x15;
					}
					else
					{
						if ((Coupling_CMD & TL_TOKEN) == TL_TOKEN)
						{
							TL_Coupling_ID = 1;
							TL_Train_Len = 1;
						}
					}
					HOC_State = 0;
					break;

					///////////////////////////////////////////////////////////////////////////

				case 0x1E:	//0x26:
					TLC_Status = CS_PASS_RB_TOKEN;

					Pass_State = 0;

					if ((Coupling_CMD & TL_TOKEN) != TL_TOKEN && TL_Coupling_ID == 0)
					{
						A_Port_Out[2] &= ~PO_RS485_RB;	// close
						A_Port_Out[2] |= PO_RS485_RA;	 // open
					}
					else
					{
						A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					}
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x1F:	//0x27:
				case 0x20:	//0x28:
					if ((Coupling_CMD & TL_TOKEN) == TL_TOKEN)
					{
						Coupling_CMD |= TL_PASS_TOKEN;
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x21:	//0x29:
					break;

					////////////////////////

				case 0x22:	//0x2A:
					TLC_Status = CS_PASS_RB_ACK;

					A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x23:	//0x2B:
				case 0x24:	//0x2C:
					if ((Pass_State & B_RB_PASS_RPT_ACK) == B_RB_PASS_RPT_ACK)
					{
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);

						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State &= ~F_TRAIN_HEAD;
						}
					}

					if (((Pass_State & B_RB_PASS_REQ) == B_RB_PASS_REQ) && (TL_Coupling_ID == 0))
					{
						u8		carh, carl;

						TL_Train_Len++;

						carh = A_CarNum[0][0];
						carl = A_CarNum[0][1];

						if (TL_Car_Temp[0] == carh && TL_Car_Temp[1] == carl)
						{
							TL_Train_Len--;
						}

						if (T_Me_AB == 1)
						{
							HexIncDec(&carh, &carl, 1);
						}
						else
						{
							HexIncDec(&carh, &carl, 0);
						}

						if (TL_Car_Temp[0] == carh && TL_Car_Temp[1] == carl)
						{
							TL_Train_Len--;
						}

						TL_Coupling_ID = TL_Train_Len;

						Coupling_CMD |= TL_TOKEN;
						Pass_State |= (B_RB_PASS_ACK + B_RB_PASS_RPT_ACK);
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);

						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State &= ~F_TRAIN_HEAD;
						}
					}
					break;
				case 0x25:	//0x2D:
					break;

					///////////////////////////////////////////////////////////////////////////

				case 0x26:	//0x2E:
					TLC_Status = CS_PASS_RA_TOKEN;

					if ((Coupling_CMD & TL_TOKEN) != TL_TOKEN && TL_Coupling_ID == 0)
					{
						A_Port_Out[2] |= PO_RS485_RB;	 // open
						A_Port_Out[2] &= ~PO_RS485_RA;	// close
					}
					else
					{
						A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					}
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x27:	//0x2F:
				case 0x28:	//0x30:
					if ((Coupling_CMD & TL_TOKEN) == TL_TOKEN)
					{
						Coupling_CMD |= TL_PASS_TOKEN;
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}
					break;
				case 0x29:	//0x31:
					break;

				///////////////////////////////////////////////////////////////////////////

				case 0x2A:	//0x32:
					TLC_Status = CS_PASS_RA_ACK;

					A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					temp8 = Port_RW_Data(2, 2);
					break;
				case 0x2B:	//0x33:
				case 0x2C:	//0x34:
					if ((Pass_State & B_RA_PASS_RPT_ACK) == B_RA_PASS_RPT_ACK)
					{
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);

						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State |= F_TRAIN_HEAD;
						}
					}

					if (((Pass_State & B_RA_PASS_REQ) == B_RA_PASS_REQ) && (TL_Coupling_ID == 0))
					{
						u8		carh, carl;

						TL_Train_Len++;

						carh = A_CarNum[0][0];
						carl = A_CarNum[0][1];

						if (TL_Car_Temp[0] == carh && TL_Car_Temp[1] == carl)
						{
							TL_Train_Len--;
						}

						if (T_Me_AB == 1)
						{
							HexIncDec(&carh, &carl, 1);
						}
						else
						{
							HexIncDec(&carh, &carl, 0);
						}

						if (TL_Car_Temp[0] == carh && TL_Car_Temp[1] == carl)
						{
							TL_Train_Len--;
						}

						TL_Coupling_ID = TL_Train_Len;

						Coupling_CMD |= TL_TOKEN;
						Pass_State |= (B_RA_PASS_ACK + B_RA_PASS_RPT_ACK);
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);

						if ((Coupling_CMD & TLST_HEAD) != TLST_HEAD)
						{
							Coupling_CMD |= TLST_HEAD;
							T_State |= F_TRAIN_HEAD;
						}
					}
					break;
				case 0x2D:	//0x35:
					if (((Pass_State & B_RB_PASS_ACK) == B_RB_PASS_ACK) || ((Pass_State & B_RA_PASS_ACK) == B_RA_PASS_ACK))
					{
						TLC_State_ID = 0x1D;	//0x25;
					}
					else
					{
						if ((Coupling_CMD & TL_TOKEN) == TL_TOKEN)
						{
							//Coupling_CMD |= TLST_TOC;	// +++
						}
					}
					Pass_State = 0;
					break;

					///////////////////////////////////////////////////////////////////////////

/*
				case 0x2E:	//0x36:
					TLC_Status = CS_11KHZ;
					A_Port_Out[1] &= ~(PO_SEL_ISP + PO_SEL_ESP_R + PO_SEL_ESP_L);
					temp8 = Port_RW_Data(2, 1);

					Set_Vol_I2C(1);
					break;
				case 0x2F:	//0x37:
					if (((CAB_State & CAB_ON) == CAB_ON) && T_CAB_CRAB == T_PAC_CRAB)
					{
						PORT_State[POUT1_STATE] &= ~PO_SEL_PA_TL_IN;
						temp8 = Port_RW_Data(2, 1);
						A_Port_Out[2] |= PO_SEL_11K;
						temp8 = Port_RW_Data(2, 2);
					}
					break;
				case 0x30:	//0x38:
				case 0x31:	//0x39:
					if (((CAB_State & CAB_ON) == CAB_ON) && T_CAB_CRAB == T_PAC_CRAB)
					{
						Make_Data(41);
						TL_Send(TL_Train_Len, TLC_State_ID, TLC_Status, Coupling_CMD, TL_Tx_Len);
					}

					ADC12_ChannelSelect(ADC12_CHANNEL1);
					ADC12_ConversionStart();
					while (ADC12_FlagStatus(ADC12_DA1) == RESET);
					adval2 = ADC12_ConversionValue(ADC12_CHANNEL1);

					if ((PORT_State[PIN2_STATE] & PI_DETECT_11K) != PI_DETECT_11K)
					{
						T_11k_TF = true;
					}

					break;
				case 0x32:	//0x3A:
					if (((CAB_State & CAB_ON) == CAB_ON) && T_CAB_CRAB == T_PAC_CRAB)
					{
						A_Port_Out[2] &= ~PO_SEL_11K;
						temp8 = Port_RW_Data(2, 2);
					}
					//adval2 = (u16)(temp32 / 4);

					if ((adval2 & 0x800) == 0x800)
					{
						adval2 = 0x800 - (((~adval2) & 0xFFF) + 1);
					}
					else
					{
						adval2 += 0x800;
					}

					Set_Vol_I2C(9);
					break;
*/
					///////////////////////////////////////////////////////////////////////////

				case 0x2E:	//0x3B:
					TLC_Status = CS_COUPLING_STOP;

					A_Port_Out[2] &= ~(PO_RS485_RB + PO_RS485_RA);	// close
					temp8 = Port_RW_Data(2, 2);

					TLC_State_ID = 0;
					TLC_Status = 0;
					T_State &= ~F_COUPLING_MODE;

					if (TL_Train_Len > 1 && TL_Coupling_ID > 0)
					{
						if ((T_State & F_PAC_MASTER) == F_PAC_MASTER)
						{
							TL_State = ST_TL_POLLING;
							TL_Tick = TL_TIME_MAIN;
							TL_TCnt = TL_Tick;
							TL_Tx_Turn = true;
						}
						else
						{
							TL_State = ST_TL_WAIT;
							TL_Tick = TL_TIME_SUB;
							TL_TCnt = TL_Tick;
						}

						T_Train_Len = TL_Train_Len;
						P_Coupling_ID = TL_Coupling_ID;
						P_CCI = TL_Train_Len;
					}
					else
					{
						TL_State = ST_TL_WAIT;
						TL_CAB_ID = 0;
						T_Train_Len = 1;
						P_Coupling_ID = 1;
						P_CCI = 0x20;
						TIM_ITConfig(TIM2, TIM_TO_IT, DISABLE);
					}

					/*
					// test test
					P_Coupling_ID = 1;
					T_Train_Len = 2;
					A_TL_CarNum[2][0] = 0x04;
					A_TL_CarNum[2][1] = 0x03;
					if ((T_State & F_PAC_MASTER) == F_PAC_MASTER) TIM_ITConfig(TIM2, TIM_TO_IT, ENABLE);
					*/

					for (i=0 ; i<5 ; i++)
					{
						T_PEI_Play[i] = 0;
						AP_Train_ST[i][7] = 0;
					}

					break;
				case 0x2F:	//0x3C:
					break;
				}
			}
		}
		MP3_SerialDataParsing();
		temp8 = temp8;
	}
}

////////////////////////////////////////////////////////////////////////////////

static	void	Device_Check(void)
{
	int		i, j;
	u8		temp8;
	
	if ((T_State & F_CNCS_MODE) != F_CNCS_MODE)
	{
		//////////////////////////// MASTER Main + CRA or CRB CAB On

		if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)
		{
			if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB || (A_Port_ST[0] & PI_BCAB) == PI_BCAB)
			{
				TL_Tick = TL_TIME_MAIN;
				T_State |= F_PAC_MASTER;
			}
			else
			{
				T_State &= ~F_PAC_MASTER;
			}
		}
		else
		{
			T_State &= ~F_PAC_MASTER;
		}

		if ((T_State & F_PAC_MASTER) == F_PAC_MASTER)	// 마스터가 빠지는 경우
		{
			if ((A_Port_ST[0] & PI_ACAB) != PI_ACAB && (A_Port_ST[0] & PI_BCAB) != PI_BCAB)
			{
				T_State &= ~F_PAC_MASTER;
			}
			else
			{
				if (T_Me_AB == 1)
				{
					if ((A_Port_ST[0] & PI_BCAB) == PI_BCAB && (AP_Train_ST[0][2] & LIVE_BPAC) != LIVE_BPAC) T_State &= ~F_PAC_MASTER;
				}
				else
				{
					if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB && (AP_Train_ST[0][2] & LIVE_APAC) != LIVE_APAC) T_State &= ~F_PAC_MASTER;
				}
			}
		}
		else	// 마스터여야 하는 경우
		{
			if (T_Me_AB == 1)
			{
				if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB) T_State |= F_PAC_MASTER;
			}
			else
			{
				if ((A_Port_ST[0] & PI_BCAB) == PI_BCAB) T_State |= F_PAC_MASTER;
			}
		}

		//////////////////////////// Main

		if (((A_Port_ST[0] & PI_ACAB) == PI_ACAB) ||
			(((A_Port_ST[0] & PI_ACAB) != PI_ACAB && (A_Port_ST[0] & PI_BCAB) != PI_BCAB) && T_Me_AB == 1 && (T_State & F_PAC_MAIN) == F_PAC_MAIN)
			)
		{
			if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)		// 메인이 빠지는 경우
			{
				if (T_Me_AB == 2 && (AP_Train_ST[0][2] & LIVE_APAC) != LIVE_APAC) Set_MS_State(SET_SUB);
			}
			else
			{
				if (T_Me_AB == 1) Set_MS_State(SET_MAIN);
			}

			A_VDev_MS[AI_CCPM] = VACCP;
			A_VDev_MS[AI_CCPS] = VBCCP;
			A_VDev_MS[AI_VOIPCM] = VAVOIPC;
			A_VDev_MS[AI_VOIPCS] = VBVOIPC;
			P_PAC_Token |= P_VOIPA_MAIN;
			AP_Train_ST[0][0] |= AVOIPC_MAIN;
			P_PAC_Token &= ~P_VOIPB_MAIN;
			AP_Train_ST[0][0] &= ~AVOIPC_MAIN;
			A_VDev_MS[AI_CNCSM] = VACNCS;
			A_VDev_MS[AI_CNCSS] = VBCNCS;
			A_VDev_MS[AI_LICM] = VALIC;
			A_VDev_MS[AI_LICS] = VBLIC;
			
			if ((AP_Train_ST[0][1] & LIVE_ACCP) == LIVE_ACCP && (AP_Train_ST[0][1] & LIVE_BCCP) != LIVE_BCCP)
			{
				A_VDev_MS[AI_CCPM] = VBCCP;
				A_VDev_MS[AI_CCPS] = VACCP;
			}
			if ((AP_Train_ST[0][1] & LIVE_AVOIPC) == LIVE_AVOIPC && (AP_Train_ST[0][1] & LIVE_BVOIPC) != LIVE_BVOIPC)
			{
				A_VDev_MS[AI_VOIPCM] = VBVOIPC;
				A_VDev_MS[AI_VOIPCS] = VAVOIPC;
				P_PAC_Token &= ~P_VOIPA_MAIN;
				AP_Train_ST[0][0] &= ~AVOIPC_MAIN;
				P_PAC_Token |= P_VOIPB_MAIN;
				AP_Train_ST[0][0] |= BVOIPC_MAIN;
			}
			if ((AP_Train_ST[0][2] & LIVE_ACNCS) == LIVE_ACNCS && (AP_Train_ST[0][2] & LIVE_BCNCS) != LIVE_BCNCS)
			{
				A_VDev_MS[AI_CNCSM] = VBCNCS;
				A_VDev_MS[AI_CNCSS] = VACNCS;
			}
			if ((AP_Train_ST[0][2] & LIVE_ALIC) == LIVE_ALIC && (AP_Train_ST[0][2] & LIVE_BLIC) != LIVE_BLIC)
			{
				A_VDev_MS[AI_LICM] = VBLIC;
				A_VDev_MS[AI_LICS] = VALIC;
			}
		}
		if (((A_Port_ST[0] & PI_BCAB) == PI_BCAB) ||
			(((A_Port_ST[0] & PI_ACAB) != PI_ACAB && (A_Port_ST[0] & PI_BCAB) != PI_BCAB) && T_Me_AB == 2 && (T_State & F_PAC_MAIN) == F_PAC_MAIN)
			)
		{
			if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)	// 메인이 빠지는 경우
			{
				if (T_Me_AB == 1 && (AP_Train_ST[0][2] & LIVE_BPAC) != LIVE_BPAC) Set_MS_State(SET_SUB);
			}
			else	// 메인이 되야 하는 경우
			{
				if (T_Me_AB == 2) Set_MS_State(SET_MAIN);
			}

			A_VDev_MS[AI_CCPM] = VBCCP;
			A_VDev_MS[AI_CCPS] = VACCP;
			A_VDev_MS[AI_VOIPCM] = VBVOIPC;
			A_VDev_MS[AI_VOIPCS] = VAVOIPC;
			P_PAC_Token &= ~P_VOIPA_MAIN;
			AP_Train_ST[0][0] &= ~AVOIPC_MAIN;
			P_PAC_Token |= P_VOIPB_MAIN;
			AP_Train_ST[0][0] |= BVOIPC_MAIN;
			A_VDev_MS[AI_CNCSM] = VBCNCS;
			A_VDev_MS[AI_CNCSS] = VACNCS;
			A_VDev_MS[AI_LICM] = VBLIC;
			A_VDev_MS[AI_LICS] = VALIC;

			if ((AP_Train_ST[0][1] & LIVE_BCCP) == LIVE_BCCP && (AP_Train_ST[0][1] & LIVE_ACCP) != LIVE_ACCP)
			{
				A_VDev_MS[AI_CCPM] = VACCP;
				A_VDev_MS[AI_CCPS] = VBCCP;
			}
			if ((AP_Train_ST[0][1] & LIVE_BVOIPC) == LIVE_BVOIPC && (AP_Train_ST[0][1] & LIVE_AVOIPC) != LIVE_AVOIPC)
			{
				A_VDev_MS[AI_VOIPCM] = VAVOIPC;
				A_VDev_MS[AI_VOIPCS] = VBVOIPC;
				P_PAC_Token |= P_VOIPA_MAIN;
				AP_Train_ST[0][0] |= AVOIPC_MAIN;
				P_PAC_Token &= ~P_VOIPB_MAIN;
				AP_Train_ST[0][0] &= ~BVOIPC_MAIN;
			}
			if ((AP_Train_ST[0][2] & LIVE_BCNCS) == LIVE_BCNCS && (AP_Train_ST[0][2] & LIVE_ACNCS) != LIVE_ACNCS)
			{
				A_VDev_MS[AI_CNCSM] = VACNCS;
				A_VDev_MS[AI_CNCSS] = VBCNCS;
			}
			if ((AP_Train_ST[0][2] & LIVE_BLIC) == LIVE_BLIC && (AP_Train_ST[0][2] & LIVE_ALIC) != LIVE_ALIC)
			{
				A_VDev_MS[AI_LICM] = VALIC;
				A_VDev_MS[AI_LICS] = VBLIC;
			}
		}

		if (T_Me_AB == 1)
		{
			AP_Train_ST[0][2] &= ~LIVE_APAC;
		}
		else
		{
			AP_Train_ST[0][2] &= ~LIVE_BPAC;
		}
		
		// 0x40 0x80 중련x H 중련o L Main L None H
		// 중련o : 마스터o(LL) 마스터x(LH)
		// 중련x : main(HL) sub(HH)
		if (P_Coupling_ID > 1)								// 중련 o
		{
			if ((T_State & F_PAC_MASTER) == F_PAC_MASTER)	// 마스터 o	// Main
			{
				if ((A_Port_Out[1] & PO_VOIPC_MAIN) == PO_VOIPC_MAIN)
				{
					A_Port_Out[1] &= ~PO_VOIPC_MAIN;
					temp8 = Port_RW_Data(2, 1);
				}
			}
			else											// 마스터 x	// None
			{
				if ((A_Port_Out[1] & PO_VOIPC_MAIN) != PO_VOIPC_MAIN)
				{
					A_Port_Out[1] |= PO_VOIPC_MAIN;
					temp8 = Port_RW_Data(2, 1);
				}				
			}
		}
		else												// 중련 x
		{
			if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)		// main o	// Main
			{
				if ((A_Port_Out[1] & PO_VOIPC_MAIN) == PO_VOIPC_MAIN)
				{
					A_Port_Out[1] &= ~PO_VOIPC_MAIN;
					temp8 = Port_RW_Data(2, 1);
				}
			}
			else											// sub x	// None
			{
				if ((A_Port_Out[1] & PO_VOIPC_MAIN) != PO_VOIPC_MAIN)
				{
					A_Port_Out[1] |= PO_VOIPC_MAIN;
					temp8 = Port_RW_Data(2, 1);
				}				
			}
		}
		
		//////////////////////////// CNCS AUTO

		if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)	// AUTO가 빠지는 경우
		{
			if ((A_Port_ST[0] & PI_ACAB) != PI_ACAB && (A_Port_ST[0] & PI_BCAB) != PI_BCAB)
			{
				T_State &= ~F_CNCS_AUTO;
			}
			else if ((AP_Train_ST[0][2] & LIVE_ACNCS) == LIVE_ACNCS && (AP_Train_ST[0][2] & LIVE_BCNCS) == LIVE_BCNCS)
			{
				T_State &= ~F_CNCS_AUTO;
			}
			else
			{
				if (T_Me_AB == 1)
				{
					if ((AP_Train_ST[0][2] & LIVE_ACNCS) == LIVE_ACNCS)
					{
						T_State &= ~F_CNCS_AUTO;
					}
					if ((A_Port_ST[0] & PI_BCAB) == PI_BCAB && (AP_Train_ST[0][2] & LIVE_BCNCS) != LIVE_BCNCS)
					{
						T_State &= ~F_CNCS_AUTO;
					}
				}
				else
				{
					if ((AP_Train_ST[0][2] & LIVE_BCNCS) == LIVE_BCNCS)
					{
						T_State &= ~F_CNCS_AUTO;
					}
					if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB && (AP_Train_ST[0][2] & LIVE_ACNCS) != LIVE_ACNCS)
					{
						T_State &= ~F_CNCS_AUTO;
					}
				}
			}
		}
		else	// AUTO여야 하는 경우
		{
			if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB || (A_Port_ST[0] & PI_BCAB) == PI_BCAB)
			{
				if (T_Me_AB == 1)
				{
					if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB && (AP_Train_ST[0][2] & LIVE_ACNCS) != LIVE_ACNCS)
					{
						T_State |= F_CNCS_AUTO;
					}
					if ((A_Port_ST[0] & PI_BCAB) == PI_BCAB && (AP_Train_ST[0][2] & LIVE_ACNCS) != LIVE_ACNCS && (AP_Train_ST[0][2] & LIVE_BCNCS) == LIVE_BCNCS)
					{
						T_State |= F_CNCS_AUTO;
					}
				}
				else
				{
					if ((A_Port_ST[0] & PI_BCAB) == PI_BCAB && (AP_Train_ST[0][2] & LIVE_BCNCS) != LIVE_BCNCS)
					{
						T_State |= F_CNCS_AUTO;
					}
					if ((A_Port_ST[0] & PI_ACAB) == PI_ACAB && (AP_Train_ST[0][2] & LIVE_BCNCS) != LIVE_BCNCS && (AP_Train_ST[0][2] & LIVE_ACNCS) == LIVE_ACNCS)
					{
						T_State |= F_CNCS_AUTO;
					}
				}
			}
		}

		if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
		{
			if (T_Me_AB == 1)
			{
				AP_Train_ST[0][0] |= ACNCS_AUTO;
				AP_Train_ST[0][0] &= ~BCNCS_AUTO;
			}
			else
			{
				AP_Train_ST[0][0] &= ~ACNCS_AUTO;
				AP_Train_ST[0][0] |= BCNCS_AUTO;
			}
		}
		else
		{
			AP_Train_ST[0][0] &= ~ACNCS_AUTO;
			AP_Train_ST[0][0] &= ~BCNCS_AUTO;
		}

		//////////////////////////// ////////////////

		CL_PollM_Arr[0] = A_VDev_MS[AI_PACM];
		CL_PollM_Arr[1] = A_VDev_MS[AI_PACS];
		CL_PollM_Arr[2] = A_VDev_MS[AI_CCPM];
		CL_PollM_Arr[3] = A_VDev_MS[AI_CNCSM];
		CL_PollM_Arr[4] = A_VDev_MS[AI_LICM];
		CL_PollM_Arr[5] = A_VDev_MS[AI_VOIPCM];

		CL_Poll1_Arr[0] = A_VDev_MS[AI_CCPS];
		CL_Poll1_Arr[1] = A_VDev_MS[AI_CNCSS];
		CL_Poll1_Arr[2] = A_VDev_MS[AI_LICS];
		CL_Poll1_Arr[3] = A_VDev_MS[AI_VOIPCS];

		if (P_Coupling_ID == 0)
		{
			AP_Train_ST[0][0] |= A_HEADING;
			AP_Train_ST[0][0] &= ~B_HEADING;
			if ((T_State & F_COUPLING_MODE) != F_COUPLING_MODE)
			{
				if (T_Me_AB == 1)
				{
					T_State |= F_TRAIN_HEAD;
				}
				else
				{
					T_State &= ~F_TRAIN_HEAD;
				}
			}
			A_CarNum[1][0] = A_CarNum[0][0];
			A_CarNum[1][1] = A_CarNum[0][1];
			A_TL_CarNum[1][0] = A_CarNum[0][0];
			A_TL_CarNum[1][1] = A_CarNum[0][1];

			for (i=0 ; i<9 ; i++)
			{
				AP_Train_ST[1][i] = AP_Train_ST[0][i];
			}

			for (j=2 ; j<5 ; j++)
			{
				for (i=0 ; i<9 ; i++)
				{
					AP_Train_ST[j][i] = 0;
				}
			}
		}
		else
		{
			if (T_Me_AB == 1)
			{
				if ((T_State & F_TRAIN_HEAD) == F_TRAIN_HEAD)
				{
					AP_Train_ST[0][0] |= A_HEADING;
					AP_Train_ST[0][0] &= ~B_HEADING;
				}
				else
				{
					AP_Train_ST[0][0] &= ~A_HEADING;
					AP_Train_ST[0][0] |= B_HEADING;
				}
			}
			else
			{
				if ((T_State & F_TRAIN_HEAD) == F_TRAIN_HEAD)
				{
					AP_Train_ST[0][0] &= ~A_HEADING;
					AP_Train_ST[0][0] |= B_HEADING;
				}
				else
				{
					AP_Train_ST[0][0] |= A_HEADING;
					AP_Train_ST[0][0] &= ~B_HEADING;
				}
			}

			for (i=0 ; i<9 ; i++)
			{
				AP_Train_ST[P_Coupling_ID][i] = AP_Train_ST[0][i];
			}
			A_CarNum[P_Coupling_ID][0] = A_CarNum[0][0];
			A_CarNum[P_Coupling_ID][1] = A_CarNum[0][1];
			A_TL_CarNum[P_Coupling_ID][0] = A_CarNum[0][0];
			A_TL_CarNum[P_Coupling_ID][1] = A_CarNum[0][1];
		}
	}
	
	temp8 = temp8;
}

static	void	Port_Check(void)
{
	int		i, j;
	u8		tempbit, tempbitIO, tempbitST, tempbitCH;
	u8		temp8, peih, peil, temppei;	//, temp10

	A_Port_In[0] = Port_RW_Data(1, 0);	// 0 0001
	A_Port_In[1] = Port_RW_Data(1, 1);	// 1 0010
	A_Port_In[2] = Port_RW_Data(1, 2);	// 2 0011
	A_Port_In[3] = Port_RW_Data(1, 3);	// 3 0100
	A_Port_In[4] = Port_RW_Data(1, 4);	// 4 0101

	//A_Port_Out[1] &= ~(PO_EXT_PA_OUT + PO_INT_PA_OUT);
	//Port_RW_Data(2, 1);

	for (i=0 ; i<5 ; i++)
	{
		for (j=0 ; j<8 ; j++)
		{
			tempbit = (1 << j);
			tempbitIO = A_Port_In[i] & tempbit;
			tempbitST = A_Port_ST[i] & tempbit;
			tempbitCH = A_Port_Chatt[i] & tempbit;
			if (A_Port_Flag[i][j] > 0) A_Port_Flag[i][j]--;
			if (A_Port_Flag[i][j] == 0)	// 채터링 중이 아닌
			{
				if (tempbitIO != tempbitST)		// 비교한 값이 틀리면
				{
					if (tempbitIO > 0)			// H
					{
						A_Port_Chatt[i] |= tempbit;
					}
					else						// L
					{
						A_Port_Chatt[i] &= ~tempbit;
					}
					A_Port_Flag[i][j] = 0xFF;
				}
			}
			else if (A_Port_Flag[i][j] == 1)	// 채터링 중
			{
				if (tempbitIO == tempbitCH)		// 비교한 값이 같으면
				{
					if (tempbitIO > 0)			// H
					{
						A_Port_ST[i] |= tempbit;
					}
					else						// L
					{
						A_Port_ST[i] &= ~tempbit;
					}
					A_Port_Flag[i][j] = 0;
				}
			}
		}	// j
	}	// i

	// CAB
		// CRA
			// LL	HH
			// LH	HL
			// HL	LH
			// HH	LL
		// CRB
			// LL	HH
			// LH	LH
			// HL	HL
			// HH	LL

	// Couple
		// CRA
			// CC	HH
			// OC	LH
			// CO	HL
			// OO	LL
		// CRB
			// CC	HH
			// OC	HL
			// CO	LH
			// OO	LL

	if ((T_State & F_COUPLING_MODE) != F_COUPLING_MODE)
	{
		if ((T_State & F_PAC_MASTER) == F_PAC_MASTER)
		{
			if (((P_Coupling_Old & PI_ACAB) == PI_ACAB && (A_Port_ST[0] & PI_ACAB) != PI_ACAB) ||
				((P_Coupling_Old & PI_BCAB) == PI_BCAB && (A_Port_ST[0] & PI_BCAB) != PI_BCAB))
			{
				if ((A_Port_ST[0] & PI_ACAB) != PI_ACAB)
				{
					P_Coupling_Old &= ~PI_ACAB;
				}
				if ((A_Port_ST[0] & PI_BCAB) != PI_BCAB)
				{
					P_Coupling_Old &= ~PI_BCAB;
				}

				TL_State = ST_TL_WAIT;
				TL_Tick = TL_TIME_SUB;
				TL_Tx_Turn = false;
				TIM_ITConfig(TIM2, TIM_TO_IT, DISABLE);

				P_CCI = 0x01;
				P_Coupling_ID = 0;
				T_Train_Len = 1;
				for (i=2 ; i<5 ; i++)
				{
					for (j=0 ; j<9 ; j++)
					{
						AP_Train_ST[i][j] = 0;
					}
				}
				for (i=1 ; i<5 ; i++)
				{
					A_TL_CarNum[i][0] = 0;
					A_TL_CarNum[i][1] = 0;
				}
			}
			if (P_Coupling_ID == 0 || (A_Port_ST[0] & 0x0F) != P_Coupling_Old)
			{
				if ((T_Me_AB == 1 && (A_Port_ST[0] & PI_ACAB) == PI_ACAB) ||
					(T_Me_AB == 2 && (A_Port_ST[0] & PI_BCAB) == PI_BCAB))
				{
					T_State |= F_COUPLING_MODE;
					P_Coupling_Old = A_Port_ST[0] & 0x0F;

					TL_State = ST_TL_COUPLING;
					TL_Tick = TL_TIME_COUPLING;
					TL_TCnt = TL_Tick;

					P_Coupling_ID = 0;
					Coupling_CMD = TLST_START;
					A_Port_Out[2] &= ~(PO_RS485_RA + PO_RS485_RB);
					Port_RW_Data(2, 2);
					TIM_ITConfig(TIM2, TIM_TO_IT, ENABLE);
				}
			}
		}
	}

	// 0 0001
	CHECK_SET_H(A_Port_ST[0], PI_ACAB, P_IOport, P_PAC_ACAB);
	CHECK_SET_H(A_Port_ST[0], PI_BCAB, P_IOport, P_PAC_BCAB);
	CHECK_SET_H(A_Port_ST[0], PI_ACOUPLE, P_IOport, P_PAC_ACOUPLE);
	CHECK_SET_H(A_Port_ST[0], PI_BCOUPLE, P_IOport, P_PAC_BCOUPLE);
	CHECK_SET_L(A_Port_ST[0], PI_FORWARD, P_IOport, P_PAC_FORWARD);
	CHECK_SET_L(A_Port_ST[0], PI_REVERSE, P_IOport, P_PAC_REVERSE);
	CHECK_SET_L(A_Port_ST[0], PI_DOOR_CLOSE, P_IOport, P_PAC_DOOR);

	CHECK_SET_H(A_Port_ST[0], PI_ACAB, AP_Train_ST[0][0], ACAB_ON);
	CHECK_SET_H(A_Port_ST[0], PI_BCAB, AP_Train_ST[0][0], BCAB_ON);

	// 1 0010	A_Port_ST[1] 에서 처리

	// 2 0011
	Chk_LiveCall(PI_PEI1_LIVE, &AP_Train_ST[0][6], LIVE_APEI1, 0, &AP_Train_ST[0][7], LIVE_APEI1);
	Chk_LiveCall(PI_PEI2_LIVE, &AP_Train_ST[0][6], LIVE_APEI2, 1, &AP_Train_ST[0][7], LIVE_APEI2);
	Chk_LiveCall(PI_PEI3_LIVE, &AP_Train_ST[0][6], LIVE_BPEI1, 2, &AP_Train_ST[0][7], LIVE_BPEI1);
	Chk_LiveCall(PI_PEI4_LIVE, &AP_Train_ST[0][6], LIVE_BPEI2, 3, &AP_Train_ST[0][7], LIVE_BPEI2);

	Chk_LiveCall(PI_DPO1_LIVE, &AP_Train_ST[0][8], LIVE_ADPO, 4, &T_DPO_Call, F_CALL_DPO1);
	Chk_LiveCall(PI_DPO2_LIVE, &AP_Train_ST[0][8], LIVE_BDPO, 5, &T_DPO_Call, F_CALL_DPO2);
	Chk_LiveCall(PI_DPH1_LIVE, &AP_Train_ST[0][8], LIVE_ADPH, 6, &T_DPO_Call, F_CALL_DPH1);
	Chk_LiveCall(PI_DPH2_LIVE, &AP_Train_ST[0][8], LIVE_BDPH, 7, &T_DPO_Call, F_CALL_DPH2);

	// 3 0100	A_Port_ST[3] 에서 처리

	////////////////////////////////////////////////////////////////////////////

	if (CL_State == ST_CL_POllING)
	{
		/*	VOL TEST
		A_Port_Out[0] |= PO_SEL_PA_TL_OUT;
		A_Port_Out[0] &= ~(PO_SEL_AUTO + PO_SEL_PEI + PO_SEL_DPO + PO_SEL_OCC);
		temp8 = Port_RW_Data(2, 0);
		A_Port_Out[1] |= (PO_SEL_CSP + PO_SEL_ISP + PO_SEL_ESP_R + PO_SEL_ESP_L);
		temp8 = Port_RW_Data(2, 1);
		*/

		if ((A_Port_ST[4] & PI_OCC_INT) != PI_OCC_INT)
		{
			P_Broad_Device |= P_PAC_OCC_I;
		}
		else
		{
			P_Broad_Device &= ~P_PAC_OCC_I;
		}
		if ((A_Port_ST[4] & PI_DPO_INT) != PI_DPO_INT)
		{
			P_Broad_Device |= P_PAC_DPO_I;
		}
		else
		{
			P_Broad_Device &= ~P_PAC_DPO_I;
		}
		if ((A_Port_ST[4] & PI_PEI_INT) != PI_PEI_INT)
		{
			P_Broad_Device |= P_PAC_PEI_I;
		}
		else
		{
			P_Broad_Device &= ~P_PAC_PEI_I;
		}

		// PEI 리스트
		if (T_PEI_Cnt == 0 && (TP_Broad_Device & F_PEI_ING) != F_PEI_ING)
		{
			if (T_PEI_Num > 4 || T_PEI_Num == 0) T_PEI_Num = 1;

			if (AP_Train_ST[T_PEI_Num][7] - T_PEI_Play[T_PEI_Num] > 0)
			{
				peih = A_TL_CarNum[T_PEI_Num][0];
				peil = A_TL_CarNum[T_PEI_Num][1];
				/*
				Debug_msg(T_PEI_Num);
				Debug_msg(peih);
				Debug_msg(peil);
				Debug_msg(AP_Train_ST[T_PEI_Num][7]);
				*/
				//temp10 = (A_TL_CarNum[T_PEI_Num][1] >> 4) * 10;
				//temp10 += A_TL_CarNum[T_PEI_Num][1] & 0x0F;

				TP_Broad_Device &= ~F_IC_ING;
				
				if ((TP_Broad_Device & F_PEI_AB) != F_PEI_AB)		// 홀수 탐색
				{
					TP_Broad_Device |= F_PEI_AB;

					if ((AP_Train_ST[T_PEI_Num][7] & 0x0F) > 0 && (T_PEI_Play[T_PEI_Num] & 0x0F) == 0)
					{
						TP_Broad_Device |= F_PEI_ING;
						P_Broad_Device |= P_PAC_PEI_B;

						A_Port_Out[0] &= ~PO_SEL_PEI;
						temp8 = Port_RW_Data(2, 0);

						if ((A_TL_CarNum[T_PEI_Num][1] % 2) == 0)	// 짝수
						{
							HexIncDec(&peih, &peil, 0);
						}

						T_PEI_Name[0] = 0x30;
						T_PEI_Name[1] = 0x30;
						T_PEI_Name[2] = 0x30;
						T_PEI_Name[3] = (peih & 0x0F) + 0x30;
						T_PEI_Name[4] = (peil >> 4) + 0x30;
						T_PEI_Name[5] = (peil & 0x0F) + 0x30;

						temppei = '/';
						UART_ByteSend(UART3, &temppei);//stx
						temppei = 'p';
						UART_ByteSend(UART3, &temppei);//pac header
						temppei = ' ';
						UART_ByteSend(UART3, &temppei);//space

						UART_ByteSend(UART3, &T_PEI_Name[0]);
						UART_ByteSend(UART3, &T_PEI_Name[1]);
						UART_ByteSend(UART3, &T_PEI_Name[2]);
						UART_ByteSend(UART3, &T_PEI_Name[3]);
						UART_ByteSend(UART3, &T_PEI_Name[4]);
						UART_ByteSend(UART3, &T_PEI_Name[5]);

						temppei = '!';
						UART_ByteSend(UART3, &temppei);//etx
						//Debug_msg('P');
						
						T_PEI_Cnt = 0x5FFF;
						
						gbyMP3PlayFlag= 1;

						A_Port_Out[1] |= PO_SEL_CSP;
						temp8 = Port_RW_Data(2, 1);
					}
					T_PEI_Play[T_PEI_Num] |= (AP_Train_ST[T_PEI_Num][7] & 0x0F); 
				}
				else										// 짝수 탐색
				{
					TP_Broad_Device &= ~F_PEI_AB;

					if ((AP_Train_ST[T_PEI_Num][7] & 0xF0) > 0 && (T_PEI_Play[T_PEI_Num] & 0xF0) == 0)
					{
						TP_Broad_Device |= F_PEI_ING;
						P_Broad_Device |= P_PAC_PEI_B;

						A_Port_Out[0] &= ~PO_SEL_PEI;
						temp8 = Port_RW_Data(2, 0);

						if ((A_TL_CarNum[T_PEI_Num][1] % 2) != 0)	// 홀수
						{
							HexIncDec(&peih, &peil, 1);
						}

						T_PEI_Name[0] = 0x30;
						T_PEI_Name[1] = 0x30;
						T_PEI_Name[2] = 0x30;
						T_PEI_Name[3] = (peih & 0x0F) + 0x30;
						T_PEI_Name[4] = (peil >> 4) + 0x30;
						T_PEI_Name[5] = (peil & 0x0F) + 0x30;

						temppei = '/';
						UART_ByteSend(UART3, &temppei);//stx
						temppei = 'p';
						UART_ByteSend(UART3, &temppei);//pac header
						temppei = ' ';
						UART_ByteSend(UART3, &temppei);//space

						UART_ByteSend(UART3, &T_PEI_Name[0]);
						UART_ByteSend(UART3, &T_PEI_Name[1]);
						UART_ByteSend(UART3, &T_PEI_Name[2]);
						UART_ByteSend(UART3, &T_PEI_Name[3]);
						UART_ByteSend(UART3, &T_PEI_Name[4]);
						UART_ByteSend(UART3, &T_PEI_Name[5]);

						temppei = '!';
						UART_ByteSend(UART3, &temppei);//etx
						//Debug_msg('P');

						T_PEI_Cnt = 0x5FFF;
						gbyMP3PlayFlag= 1;

						A_Port_Out[1] |= PO_SEL_CSP;
						temp8 = Port_RW_Data(2, 1);
					}
					T_PEI_Play[T_PEI_Num] |= (AP_Train_ST[T_PEI_Num][7] & 0xF0); 
					T_PEI_Num++;
				}
			}
			else
			{
				T_PEI_Num++;
			}
		}

		// PEI 중일때 처리
		if ((TP_Broad_Device & F_PEI_ING) == F_PEI_ING)
		{
			if (T_PEI_Cnt > 0) T_PEI_Cnt--;
			if (T_PEI_Cnt == 1)
			{
				if ((A_Port_ST[3] & PI_MP3_MUTE) != PI_MP3_MUTE)
				{
					T_PEI_Cnt = 0;
					TP_Broad_Device &= ~F_PEI_ING;

					A_Port_Out[1] &= ~PO_SEL_CSP;
					temp8 = Port_RW_Data(2, 1);

					P_Broad_Device &= ~P_PAC_PEI_B;

					A_Port_Out[0] |= PO_SEL_PEI;
					temp8 = Port_RW_Data(2, 0);
					
					T_IC_Cnt = 0;
				}
				else
				{
					T_PEI_Cnt = 0xFFF;
				}
			}
		}
		else
		{
			// IC 눌렸을 때
			if ((A_Port_ST[1] & PI_IC_VOICE) != PI_IC_VOICE)
			{
				if (T_IC_Cnt == 0 && (TP_Broad_Device & F_IC_ING) != F_IC_ING)
				{
					TP_Broad_Device |= F_IC_ING;

					A_Port_Out[0] &= ~PO_SEL_PEI;
					temp8 = Port_RW_Data(2, 0);

					temppei = '/';
					UART_ByteSend(UART3, &temppei);//stx
					temppei = 'p';
					UART_ByteSend(UART3, &temppei);//pac header
					temppei = ' ';
					UART_ByteSend(UART3, &temppei);//space

					UART_ByteSend(UART3, &T_IC_Name[0]);
					UART_ByteSend(UART3, &T_IC_Name[1]);
					UART_ByteSend(UART3, &T_IC_Name[2]);
					UART_ByteSend(UART3, &T_IC_Name[3]);
					UART_ByteSend(UART3, &T_IC_Name[4]);
					UART_ByteSend(UART3, &T_IC_Name[5]);

					temppei = '!';
					UART_ByteSend(UART3, &temppei);//etx

					T_IC_Cnt = 0x1FFF;

					A_Port_Out[1] |= PO_SEL_CSP;
					temp8 = Port_RW_Data(2, 1);
				}
			}
		}

		if ((TP_Broad_Device & F_IC_ING) == F_IC_ING)
		{
			if (T_IC_Cnt > 0) T_IC_Cnt--;
			if (T_IC_Cnt == 1)
			{
				if ((A_Port_ST[3] & PI_MP3_MUTE) != PI_MP3_MUTE)
				{
					T_IC_Cnt = 0;
					TP_Broad_Device &= ~F_IC_ING;

					A_Port_Out[1] &= ~PO_SEL_CSP;
					temp8 = Port_RW_Data(2, 1);

					A_Port_Out[0] |= PO_SEL_PEI;
					temp8 = Port_RW_Data(2, 0);
				}
				else
				{
					T_IC_Cnt = 0x1FFF;
				}
			}			
		}
		
		// INT SPK
		if ((A_Port_ST[1] & PI_INT_PA_IN) != PI_INT_PA_IN)
		{
			if ((A_Port_Out[1] & PO_SEL_ISP) != PO_SEL_ISP)
			{
				A_Port_Out[1] |= PO_SEL_ISP;
				temp8 = Port_RW_Data(2, 1);
				//Debug_msg(1);
			}
		}
		else
		{
			if ((A_Port_Out[1] & PO_SEL_ISP) == PO_SEL_ISP)
			{
				A_Port_Out[1] &= ~PO_SEL_ISP;
				temp8 = Port_RW_Data(2, 1);
			}
		}
		// EXT SPK
		if ((A_Port_ST[1] & PI_EXT_PA_IN) != PI_EXT_PA_IN)
		{
			if ((A_Port_Out[1] & PO_SEL_ESP_R) != PO_SEL_ESP_R)
			{
				A_Port_Out[1] |= PO_SEL_ESP_R;
				temp8 = Port_RW_Data(2, 1);
			}
			if ((A_Port_Out[1] & PO_SEL_ESP_L) != PO_SEL_ESP_L)
			{
				A_Port_Out[1] |= PO_SEL_ESP_L;
				temp8 = Port_RW_Data(2, 1);
			}
		}
		else
		{
			if ((A_Port_Out[1] & PO_SEL_ESP_R) == PO_SEL_ESP_R)
			{
				A_Port_Out[1] &= ~PO_SEL_ESP_R;
				temp8 = Port_RW_Data(2, 1);
			}
			if ((A_Port_Out[1] & PO_SEL_ESP_L) == PO_SEL_ESP_L)
			{
				A_Port_Out[1] &= ~PO_SEL_ESP_L;
				temp8 = Port_RW_Data(2, 1);
			}
		}
		
		// OCC
		if ((T_Broad & F_OCC_ING) == F_OCC_ING)
		{
			if (TC_Broad[0] == 10)
			{
			#if PAC_PROTOCOL_R10
				if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
				{
					A_Port_Out[0] &= ~PO_SEL_AUTO;
					A_Port_Out[0] |= PO_SEL_PA_TL_OUT + PO_SEL_OCC + PO_SEL_DPO;
					temp8 = Port_RW_Data(2, 0);
					//Debug_msg('2');
				}
				TC_Broad[0] = 11;
			#else
				Set_Vol_I2C(1);
				if ((T_Broad & F_OCC_OUT) == F_OCC_OUT)
				{
					A_Port_Out[0] &= ~PO_SEL_OCC;
					A_Port_Out[0] |= PO_SEL_PA_TL_OUT + PO_SEL_DPO + PO_SEL_AUTO;
				}
				else
				{
					A_Port_Out[0] &= ~PO_SEL_PA_TL_OUT;
					A_Port_Out[0] |= PO_SEL_OCC + PO_SEL_DPO + PO_SEL_AUTO;
				}
				temp8 = Port_RW_Data(2, 0);
				TC_Broad[0] = 11;
			#endif
				//Debug_msg('#');
			#if PAC_PROTOCOL_R10
				P_Broad_Occ |= P_PAC_CNCS_PLAY;
			#endif
			}
			if (TC_Broad[0] == 20)
			{
			#if PAC_PROTOCOL_R10
				if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
				{
					if ((CISpk_State & ISP_MUTE) != ISP_MUTE)
					{
						A_Port_Out[1] &= ~PO_INT_PA_OUT;
					}
					if ((ESpk_State & ESP_MUTE_R) != ESP_MUTE_R && (ESpk_State & ESP_MUTE_L) != ESP_MUTE_L)
					{
						A_Port_Out[1] &= ~PO_EXT_PA_OUT;
					}
					temp8 = Port_RW_Data(2, 1);
					//Debug_msg('3');
				}
				Set_Vol_I2C(1);
				TC_Broad[0] = 21;
			#else
				A_Port_Out[1] &= ~PO_INT_PA_OUT;
				A_Port_Out[1] |= PO_EXT_PA_OUT;
				temp8 = Port_RW_Data(2, 1);
				TC_Broad[0] = 21;
			#endif
				//Debug_msg('$');
			}
			if (TC_Broad[0] == 30)
			{
			#if PAC_PROTOCOL_R10
				if ((P_CNCS_PA & P_CNCS_READY) != P_CNCS_READY)
				{
					P_Broad_Device &= ~(P_PAC_AUTO_B | P_PAC_OCC_B);
					if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
					{
						A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
						A_Port_Out[1] &= ~(PO_SEL_ISP + PO_SEL_ESP_R + PO_SEL_ESP_L);
						temp8 = Port_RW_Data(2, 1);
						//Debug_msg('4');
					}
					//Debug_msg('%');
					TC_Broad[0] = 32;
				}
			#else
				if ((T_Broad & F_OCC_OUT) == F_OCC_OUT)
				{
					if ((A_Port_ST[4] & PI_OCC_PA_MAIN) == PI_OCC_PA_MAIN)
					{
						A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
						A_Port_Out[1] &= ~(PO_SEL_ISP + PO_SEL_ESP_R + PO_SEL_ESP_L);
						temp8 = Port_RW_Data(2, 1);
						P_Broad_Device &= ~P_PAC_OCC_B;
						TC_Broad[0] = 32;
						//Debug_msg('%');
					}
					//Debug_msg('^');
				}
				else
				{
					if ((A_Port_ST[4] & PI_OCC_PA_SUB) == PI_OCC_PA_SUB)
					{
						A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
						A_Port_Out[1] &= ~(PO_SEL_ISP + PO_SEL_ESP_R + PO_SEL_ESP_L);
						temp8 = Port_RW_Data(2, 1);
						P_Broad_Device &= ~P_PAC_OCC_B;
						TC_Broad[0] = 32;
						//Debug_msg('&');
					}
					//Debug_msg('*');
				}
			#endif
			}
			if (TC_Broad[0] == 31) TC_Broad[0] = 30;
			if (TC_Broad[0] == 40)
			{
			#if PAC_PROTOCOL_R10
				if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
				{
					A_Port_Out[0] &= ~PO_SEL_PA_TL_OUT;
					A_Port_Out[0] |= PO_SEL_AUTO;
					temp8 = Port_RW_Data(2, 0);
					//Debug_msg('5');
				}
				T_Broad &= ~F_AUTO_START;
				T_Broad &= ~F_AUTO_ING;
				T_Broad &= ~F_OCC_OUT;
				T_Broad &= ~F_OCC_START;
				T_Broad &= ~F_OCC_ING;

				P_Broad_Occ &= ~P_PAC_CNCS_PLAY;
				TC_Broad[0] = 0;
				//Debug_msg('^');
			#else
				if ((T_Broad & F_OCC_OUT) == F_OCC_OUT)
				{
					A_Port_Out[0] &= ~PO_SEL_PA_TL_OUT;
					A_Port_Out[0] |= PO_SEL_OCC;
					temp8 = Port_RW_Data(2, 0);
				}
				T_Broad &= ~F_OCC_OUT;
				T_Broad &= ~F_OCC_START;
				T_Broad &= ~F_OCC_ING;
				TC_Broad[0] = 0;
				//Debug_msg('(');
			#endif
			}
		}
		// DPO
		//DPO PTT ON => a,...,a,b,a,..,a,c,a,....,a,d,a,d,..,a,d,e
		else if ((T_Broad & F_DPO_ING) == F_DPO_ING)
		{
			if (TC_Broad[1] == 10)
			{
				if ((T_Broad & F_DPO_OUT) == F_DPO_OUT)
				{
					A_Port_Out[0] &= ~PO_SEL_DPO;
					A_Port_Out[0] |= PO_SEL_PA_TL_OUT + PO_SEL_OCC + PO_SEL_AUTO;
				}
				else
				{
					A_Port_Out[0] &= ~PO_SEL_PA_TL_OUT;
					A_Port_Out[0] |= PO_SEL_OCC + PO_SEL_DPO + PO_SEL_AUTO;
				}
				temp8 = Port_RW_Data(2, 0);
				TC_Broad[1] = 11;
				//Debug_msg('b');
			}
			if (TC_Broad[1] == 20)
			{
				if ((A_Port_ST[1] & PI_DPO_ISP) != PI_DPO_ISP)
				{
					A_Port_Out[1] &= ~PO_INT_PA_OUT;
					Set_Vol_I2C(1);
				}
				if ((A_Port_ST[1] & PI_DPO_ESP) != PI_DPO_ESP)
				{
					A_Port_Out[1] &= ~PO_EXT_PA_OUT;
				}
				temp8 = Port_RW_Data(2, 1);
				TC_Broad[1] = 21;
				//Debug_msg('c');
			}
			if (TC_Broad[1] == 30)
			{
				if ((A_Port_ST[1] & PI_DPO_ISP) == PI_DPO_ISP && (A_Port_ST[1] & PI_DPO_ESP) == PI_DPO_ESP)
				{
					P_Broad_Device &= ~P_PAC_DPO_B;
					A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
					A_Port_Out[1] &= ~(PO_SEL_ISP + PO_SEL_ESP_R + PO_SEL_ESP_L);
					temp8 = Port_RW_Data(2, 1);
					TC_Broad[1] = 32;
				}
				//Debug_msg('d');
			}
			if (TC_Broad[1] == 31) TC_Broad[1] = 30;
			if (TC_Broad[1] == 40)
			{
				if ((T_Broad & F_DPO_OUT) == F_DPO_OUT)
				{
					A_Port_Out[0] &= ~PO_SEL_PA_TL_OUT;
					A_Port_Out[0] |= PO_SEL_DPO;
					temp8 = Port_RW_Data(2, 0);
				}
				T_Broad &= ~F_DPO_OUT;
				T_Broad &= ~F_DPO_START;
				T_Broad &= ~F_DPO_ING;
				TC_Broad[1] = 0;
				//Debug_msg('e');

			}
		}
		// AUTO
		else if ((T_Broad & F_AUTO_ING) == F_AUTO_ING)
		{
			if (TC_Broad[2] == 10)
			{
				if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
				{
					A_Port_Out[0] &= ~PO_SEL_AUTO;
					A_Port_Out[0] |= PO_SEL_PA_TL_OUT + PO_SEL_OCC + PO_SEL_DPO;
					temp8 = Port_RW_Data(2, 0);
					//Debug_msg('2');
				}
			#if PAC_PROTOCOL_R10
				P_Broad_Occ |= P_PAC_CNCS_PLAY;
			#else
				P_Broad_Device |= P_PAC_CNCS_PLAY;
			#endif
				TC_Broad[2] = 11;
			}
			if (TC_Broad[2] == 20)
			{
				if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
				{
					if ((CISpk_State & ISP_MUTE) != ISP_MUTE)
					{
						A_Port_Out[1] &= ~PO_INT_PA_OUT;
					}
					if ((ESpk_State & ESP_MUTE_R) != ESP_MUTE_R && (ESpk_State & ESP_MUTE_L) != ESP_MUTE_L)
					{
						A_Port_Out[1] &= ~PO_EXT_PA_OUT;
					}
					temp8 = Port_RW_Data(2, 1);
					//Debug_msg('3');
				}
				Set_Vol_I2C(1);
				TC_Broad[2] = 21;
			}
			if (TC_Broad[2] == 30)
			{
				if ((P_CNCS_PA & P_CNCS_READY) != P_CNCS_READY)
				{
					P_Broad_Device &= ~P_PAC_AUTO_B;
					if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
					{
						A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
						A_Port_Out[1] &= ~(PO_SEL_ISP + PO_SEL_ESP_R + PO_SEL_ESP_L);
						temp8 = Port_RW_Data(2, 1);
						//Debug_msg('4');
					}
					TC_Broad[2] = 32;
				}
			}
			if (TC_Broad[2] == 31) TC_Broad[2] = 30;
			if (TC_Broad[2] == 40)
			{
				if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO)
				{
					A_Port_Out[0] &= ~PO_SEL_PA_TL_OUT;
					A_Port_Out[0] |= PO_SEL_AUTO;
					temp8 = Port_RW_Data(2, 0);
					//Debug_msg('5');
				}
				T_Broad &= ~F_AUTO_START;
				T_Broad &= ~F_AUTO_ING;
			#if PAC_PROTOCOL_R10
				P_Broad_Occ &= ~P_PAC_CNCS_PLAY;
			#else
				P_Broad_Device &= ~P_PAC_CNCS_PLAY;
			#endif
				TC_Broad[2] = 0;
			}
		}

		// 방송 판별

	#if PAC_PROTOCOL_R10
		//if ((A_Port_ST[4] & PI_OCC_PA_MAIN) != PI_OCC_PA_MAIN || (A_Port_ST[4] & PI_OCC_PA_SUB) != PI_OCC_PA_SUB)
		//if ((P_CNCS_PA & P_CNCS_OCC_PA) == P_CNCS_OCC_PA)
		if ((P_CNCS_PA & (P_CNCS_OCC_PA | P_CNCS_READY)) == (P_CNCS_OCC_PA | P_CNCS_READY))//(P_CNCS_READY | P_CNCS_OCC_PA)
		{
		#if !PAC_PROTOCOL_R10
			if ((A_Port_ST[4] & PI_OCC_PA_MAIN) != PI_OCC_PA_MAIN)
			{
				T_Broad |= F_OCC_OUT;
				//Debug_msg('!');
			}
		#endif	
			P_Broad_Device |= (P_PAC_OCC_B |P_PAC_AUTO_B);
			T_Broad |= F_OCC_START;
			//Debug_msg('@');
		}
		else if (((A_Port_ST[1] & PI_DPO_ISP) != PI_DPO_ISP) || ((A_Port_ST[1] & PI_DPO_ESP) != PI_DPO_ESP))
	#else
		if ((A_Port_ST[1] & PI_DPO_ISP) != PI_DPO_ISP || (A_Port_ST[1] & PI_DPO_ESP) != PI_DPO_ESP)
	#endif
		{
			if ((T_State & F_PAC_MAIN) == F_PAC_MAIN && T_DPO_Call > 0)
			{
				T_Broad |= F_DPO_OUT;
			}
			P_Broad_Device |= P_PAC_DPO_B;
			T_Broad |= F_DPO_START;

		#if PAC_PROTOCOL_R10
			if(((P_CNCS_PA & (P_CNCS_OCC_PA | P_CNCS_READY)) != (P_CNCS_OCC_PA | P_CNCS_READY))&&((P_Broad_Occ & P_PAC_CNCS_PLAY) == P_PAC_CNCS_PLAY)){
				T_Broad &= ~F_AUTO_START;
				T_Broad &= ~F_AUTO_ING;
				P_Broad_Occ &= ~P_PAC_CNCS_PLAY;

				P_Broad_Priorit = Broad_Priority_tick;//수동방송이 우선순위가 높음.(자동방송에만 적용.)
			}
		#endif
			//Debug_msg('a');
		}
		//else if ((T_State & F_CNCS_AUTO) == F_CNCS_AUTO && (P_CNCS_PA & P_CNCS_READY) == P_CNCS_READY)
		else if (((T_State & F_CNCS_AUTO) == F_CNCS_AUTO) && ((P_CNCS_PA & (P_CNCS_OCC_PA | P_CNCS_READY)) == P_CNCS_READY))
		{
			P_Broad_Device |= P_PAC_AUTO_B;
			T_Broad |= F_AUTO_START;
			//Debug_msg('1');
			//Debug_msg('R');
			
			if(P_Broad_Priorit != RESET){
				T_Broad &= ~F_AUTO_START;
				T_Broad &= ~F_AUTO_ING;
				P_Broad_Occ &= ~P_PAC_CNCS_PLAY;
			}
		}
		else if ((A_Port_ST[1] & PI_INT_PA_IN) != PI_INT_PA_IN || (A_Port_ST[1] & PI_EXT_PA_IN) != PI_EXT_PA_IN)
		{
		#if PAC_PROTOCOL_R10
			if((P_CNCS_PA & P_CNCS_OCC_PA) == P_CNCS_OCC_PA){
				P_Broad_Device |= P_PAC_OCC_B;
				//Debug_msg('o');
			}
			else if((P_CNCS_PA & P_CNCS_READY) == P_CNCS_READY){
				P_Broad_Device |= P_PAC_AUTO_B;
				//Debug_msg('o');
			}
			else{
				P_Broad_Device &= ~(P_PAC_OCC_B | P_PAC_AUTO_B);
				//T_Broad |= F_AUTO_START;
				//Debug_msg('6');
				//Debug_msg('t');
			}
		#else
			P_Broad_Device |= P_PAC_AUTO_B;
		#endif
		}
		else if ((A_Port_ST[1] & PI_INT_PA_IN) == PI_INT_PA_IN && (A_Port_ST[1] & PI_EXT_PA_IN) == PI_EXT_PA_IN)
		{
			P_Broad_Device &= ~P_PAC_AUTO_B;

			//Debug_msg('r');
		}

		// OCC
		if ((T_Broad & F_OCC_START) == F_OCC_START)
		{
			if ((T_Broad & F_OCC_ING) != F_OCC_ING)
			{
				T_Broad |= F_OCC_ING;

				A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
				temp8 = Port_RW_Data(2, 1);
				T_Broad &= ~(F_DPO_OUT + F_DPO_START + F_DPO_ING + F_AUTO_START + F_AUTO_ING);

				TC_Broad[0] = 1;
				TC_Broad[1] = 0;
				TC_Broad[2] = 0;
			}
		}
		// DPO
		else if ((T_Broad & F_DPO_START) == F_DPO_START)
		{
			if ((T_Broad & F_DPO_ING) != F_DPO_ING)
			{
				T_Broad |= F_DPO_ING;

				A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
				temp8 = Port_RW_Data(2, 1);
				T_Broad &= ~(F_AUTO_START + F_AUTO_ING);

				TC_Broad[0] = 0;
				TC_Broad[1] = 1;
				TC_Broad[2] = 0;
			}
		}
		// AUTO
		else if ((T_Broad & F_AUTO_START) == F_AUTO_START)
		{
			if ((T_Broad & F_AUTO_ING) != F_AUTO_ING)
			{
				T_Broad |= F_AUTO_ING;

				A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
				temp8 = Port_RW_Data(2, 1);

				TC_Broad[0] = 0;
				TC_Broad[1] = 0;
				TC_Broad[2] = 1;
				//Debug_msg(6);
			}

		}

		/*
		if ((A_Port_ST[1] & PI_PEI_CLEAR) != PI_PEI_CLEAR)
		{
			for (i=0 ; i<5 ; i++)
			{
				T_PEI_Play[i] = AP_Train_ST[i][7];
			}
		}
		*/

		if ((A_Port_ST[1] & PI_DPO_CANCEL) != PI_DPO_CANCEL)
		{
			for (i=0 ; i<5 ; i++)
			{
				AP_Train_ST[i][7] = 0;
				T_PEI_Play[i] = 0;
			}
		}
/*		//6
		T_Broad |= F_AUTO_ING;
		
		A_Port_Out[1] |= (PO_INT_PA_OUT + PO_EXT_PA_OUT);
		temp8 = Port_RW_Data(2, 1);
		
		TC_Broad[0] = 0;
		TC_Broad[1] = 0;
		TC_Broad[2] = 1;
		//2
		A_Port_Out[0] &= ~PO_SEL_AUTO;
		A_Port_Out[0] |= PO_SEL_PA_TL_OUT + PO_SEL_OCC + PO_SEL_DPO;
		temp8 = Port_RW_Data(2, 0);
		P_Broad_Device |= P_PAC_CNCS_PLAY;
		//3
		A_Port_Out[1] &= ~PO_INT_PA_OUT;
		A_Port_Out[1] &= ~PO_EXT_PA_OUT;
		temp8 = Port_RW_Data(2, 1);
		Set_Vol_I2C(1);
		//1
		A_Port_Out[1] |= PO_SEL_ISP;
		temp8 = Port_RW_Data(2, 1);*/
	}
	temp8 = temp8;

	////////////////////////////////////////////////////////////////////////////
}

static	u8		Port_RW_Data(u8 gbn, u8 sel)
{
	u16		temp16;

	GPIO2->PD &= ~PO_IO_SEL;

	if (gbn == 1)	// read
	{
		switch (sel)
		{
		case 0:
			GPIO2->PD |= PO_IO_SEL_0;
			break;

		case 1:
			GPIO2->PD |= PO_IO_SEL_1;
			break;

		case 2:
			GPIO2->PD |= PO_IO_SEL_1 + PO_IO_SEL_0;
			break;

		case 3:
			GPIO2->PD |= PO_IO_SEL_2;
			break;

		case 4:
			GPIO2->PD |= PO_IO_SEL_2 + PO_IO_SEL_0;
			break;
		}

		temp16 = GPIO2->PD;
		GPIO2->PD &= ~PO_IO_SEL;
		return (u8)((temp16 >> 2) & 0xFF);
	}
	else		// write
	{
		GPIO1->PD &= ~PO_P12_P19;
		switch (sel)
		{
		case 0:
			temp16 = A_Port_Out[0];
			GPIO1->PD |= (temp16 << 2);
			GPIO2->PD |= PO_IO_SEL_3 + PO_IO_SEL_0;
			break;

		case 1:
			temp16 = A_Port_Out[1];
			GPIO1->PD |= (temp16 << 2);
			GPIO2->PD |= PO_IO_SEL_3 + PO_IO_SEL_1;
			break;

		case 2:
			temp16 = A_Port_Out[2];
			GPIO1->PD |= (temp16 << 2);
			GPIO2->PD |= PO_IO_SEL_3 + PO_IO_SEL_1 + PO_IO_SEL_0;
			break;
		}
		GPIO2->PD &= ~PO_IO_SEL;
		return 0;
	}
}

////////////////////////////////////////////////////////////////////////////////

void	Tim1_ISR(void)
{
	CL_Timer();
	TIM_FlagClear(TIM1, TIM_TOF);
}
void	Tim2_ISR(void)
{
	TL_Timer();
	TIM_FlagClear(TIM2, TIM_TOF);
}

void	CL_Timer(void)
{
	u8		i;
	u16		tempans;

	if (CL_TCnt > 0) CL_TCnt--;

	if (T_Ans_Cnt > 0) T_Ans_Cnt--;
	if (T_Ans_Cnt == 0)
	{
		if ((P_Broad_Device & 0x0F) == 0)
		{
			T_Ans_Cnt = ANS_TICK_CNT;

			ADC12_ChannelSelect(ADC12_CHANNEL0);
			ADC12_ConversionStart();
			tempans = ADC12_ConversionValue(ADC12_CHANNEL0);

			if ((tempans & 0x800) == 0x800)
			{
				tempans = 0x800 - (((~tempans) & 0xFFF) + 1);
			}
			else
			{
				tempans += 0x800;
			}

			if (AI_Ans >= A_FVol[I_V_ANSSEC] * 5 || AI_Ans >= 25) AI_Ans = 0;

			A_Ans_Val[AI_Ans] = tempans;
			AI_Ans++;
		}
	}

	for (i=0 ; i<8 ; i++)
	{
		if (A_DeadCnt[i] > 0) A_DeadCnt[i]++;
	}

	for (i=0 ; i<3 ; i++)
	{
		if (TC_Broad[i] > 0) TC_Broad[i]++;
	}

	if (CL_TCnt == 0)
	{
		if (CL_State == ST_CL_SEL_PAC)
		{
			Set_MS_State(SET_MAIN);
			CL_State = ST_CL_POllING;
		}

		if (CL_State == ST_CL_POllING)
		{
			if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)
			{
				if (CL_Tx_ID == CL_Rx_ID)
				{
					A_ErrDevs[CL_Tx_ID] = 0;

					switch (CL_Tx_ID)
					{
					case VACCP:		AP_Train_ST[0][1] &= ~LIVE_ACCP;	break;
					case VBCCP:		AP_Train_ST[0][1] &= ~LIVE_BCCP;	break;
					case VAVOIPC:	AP_Train_ST[0][1] &= ~LIVE_AVOIPC;	break;
					case VBVOIPC:	AP_Train_ST[0][1] &= ~LIVE_BVOIPC;	break;
					case VAPAC:		AP_Train_ST[0][2] &= ~LIVE_APAC;	break;
					case VBPAC:		AP_Train_ST[0][2] &= ~LIVE_BPAC;	break;
					case VACNCS:	AP_Train_ST[0][2] &= ~LIVE_ACNCS;	break;
					case VBCNCS:	AP_Train_ST[0][2] &= ~LIVE_BCNCS;	break;
					case VALIC:		AP_Train_ST[0][2] &= ~LIVE_ALIC;	break;
					case VBLIC:		AP_Train_ST[0][2] &= ~LIVE_BLIC;	break;
					case VAVTX:		AP_Train_ST[0][2] &= ~LIVE_AVTX;	break;
					case VBVTX:		AP_Train_ST[0][2] &= ~LIVE_BVTX;	break;
					case VAPII1:	AP_Train_ST[0][3] &= ~LIVE_APII1;	break;
					case VBPII1:	AP_Train_ST[0][3] &= ~LIVE_BPII1;	break;
					case VAPII2:	AP_Train_ST[0][3] &= ~LIVE_APII2;	break;
					case VBPII2:	AP_Train_ST[0][3] &= ~LIVE_BPII2;	break;
					case VAFDI:		AP_Train_ST[0][3] &= ~LIVE_AFDI;	break;
					case VBFDI:		AP_Train_ST[0][3] &= ~LIVE_BFDI;	break;
					case VASDI1:	AP_Train_ST[0][4] &= ~LIVE_ASDI1;	break;
					case VASDI2:	AP_Train_ST[0][4] &= ~LIVE_ASDI2;	break;
					case VASDI3:	AP_Train_ST[0][4] &= ~LIVE_ASDI3;	break;
					case VASDI4:	AP_Train_ST[0][4] &= ~LIVE_ASDI4;	break;
					case VBSDI1:	AP_Train_ST[0][4] &= ~LIVE_BSDI1;	break;
					case VBSDI2:	AP_Train_ST[0][4] &= ~LIVE_BSDI2;	break;
					case VBSDI3:	AP_Train_ST[0][4] &= ~LIVE_BSDI3;	break;
					case VBSDI4:	AP_Train_ST[0][4] &= ~LIVE_BSDI4;	break;
					case VAPID11:	AP_Train_ST[0][5] &= ~LIVE_APID11;	break;
					case VAPID12:	AP_Train_ST[0][5] &= ~LIVE_APID12;	break;
					case VAPID13:	AP_Train_ST[0][5] &= ~LIVE_APID13;	break;
					case VAPID14:	AP_Train_ST[0][5] &= ~LIVE_APID14;	break;
					case VBPID11:	AP_Train_ST[0][5] &= ~LIVE_BPID11;	break;
					case VBPID12:	AP_Train_ST[0][5] &= ~LIVE_BPID12;	break;
					case VBPID13:	AP_Train_ST[0][5] &= ~LIVE_BPID13;	break;
					case VBPID14:	AP_Train_ST[0][5] &= ~LIVE_BPID14;	break;
					case VAPID21:	AP_Train_ST[0][6] &= ~LIVE_APID21;	break;
					case VBPID21:	AP_Train_ST[0][6] &= ~LIVE_BPID21;	break;
					}
				}
				else
				{
					if (A_ErrDevs[CL_Tx_ID]++ > 1)
					{
						A_ErrDevs[CL_Tx_ID] = 2;

						switch (CL_Tx_ID)
						{
						case VAPAC:		AP_Train_ST[0][2] |= LIVE_APAC;		break;
						case VBPAC:		AP_Train_ST[0][2] |= LIVE_BPAC;		break;
						case VACCP:		AP_Train_ST[0][1] |= LIVE_ACCP;		break;
						case VBCCP:		AP_Train_ST[0][1] |= LIVE_BCCP;		break;
						case VAVOIPC:
						#if 1 // VoIP protocol 확인후 삭제.
							if(gVAVOIPC){//정상 동작 확인.
								AP_Train_ST[0][1] &= ~LIVE_AVOIPC;
							}
							else{
								AP_Train_ST[0][1] |= LIVE_AVOIPC;
							}
						#else
							AP_Train_ST[0][1] |= LIVE_AVOIPC;
						#endif
							break;
						case VBVOIPC:	
						#if 1 // VoIP protocol 확인후 삭제.	
							if(gVBVOIPC){//정상 동작 확인.
								AP_Train_ST[0][1] &= ~LIVE_BVOIPC;
							}
							else{
								AP_Train_ST[0][1] |= LIVE_BVOIPC;	
							}
						#else
							AP_Train_ST[0][1] |= LIVE_BVOIPC;	
						#endif
							break;
						case VACNCS:
										AP_Train_ST[0][2] |= LIVE_ACNCS;
										AP_Train_ST[0][1] |= LIVE_AWLR;
										AP_Train_ST[0][1] |= LIVE_AGPS;
										if (A_VDev_MS[AI_CNCSM] == VACNCS){
											P_CNCS_PA = 0;
											//Debug_msg(0x0A);
										}
										break;
						case VBCNCS:
										AP_Train_ST[0][2] |= LIVE_BCNCS;
										AP_Train_ST[0][1] |= LIVE_BWLR;
										AP_Train_ST[0][1] |= LIVE_BGPS;
										if (A_VDev_MS[AI_CNCSM] == VBCNCS){
											P_CNCS_PA = 0;
											//Debug_msg(0x0B);
										}
										break;
						case VALIC:		AP_Train_ST[0][2] |= LIVE_ALIC;		break;
						case VBLIC:		AP_Train_ST[0][2] |= LIVE_BLIC;		break;
						case VAVTX:		AP_Train_ST[0][2] |= LIVE_AVTX;		break;
						case VBVTX:		AP_Train_ST[0][2] |= LIVE_BVTX;		break;
						case VAPII1:	AP_Train_ST[0][3] |= LIVE_APII1;	break;
						case VBPII1:	AP_Train_ST[0][3] |= LIVE_BPII1;	break;
						case VAPII2:	AP_Train_ST[0][3] |= LIVE_APII2;	break;
						case VBPII2:	AP_Train_ST[0][3] |= LIVE_BPII2;	break;
						case VAFDI:		AP_Train_ST[0][3] |= LIVE_AFDI;		break;
						case VBFDI:		AP_Train_ST[0][3] |= LIVE_BFDI;		break;
						case VASDI1:	AP_Train_ST[0][4] |= LIVE_ASDI1;	break;
						case VASDI2:	AP_Train_ST[0][4] |= LIVE_ASDI2;	break;
						case VASDI3:	AP_Train_ST[0][4] |= LIVE_ASDI3;	break;
						case VASDI4:	AP_Train_ST[0][4] |= LIVE_ASDI4;	break;
						case VBSDI1:	AP_Train_ST[0][4] |= LIVE_BSDI1;	break;
						case VBSDI2:	AP_Train_ST[0][4] |= LIVE_BSDI2;	break;
						case VBSDI3:	AP_Train_ST[0][4] |= LIVE_BSDI3;	break;
						case VBSDI4:	AP_Train_ST[0][4] |= LIVE_BSDI4;	break;
						case VAPID11:	AP_Train_ST[0][5] |= LIVE_APID11;	break;
						case VAPID12:	AP_Train_ST[0][5] |= LIVE_APID12;	break;
						case VAPID13:	AP_Train_ST[0][5] |= LIVE_APID13;	break;
						case VAPID14:	AP_Train_ST[0][5] |= LIVE_APID14;	break;
						case VBPID11:	AP_Train_ST[0][5] |= LIVE_BPID11;	break;
						case VBPID12:	AP_Train_ST[0][5] |= LIVE_BPID12;	break;
						case VBPID13:	AP_Train_ST[0][5] |= LIVE_BPID13;	break;
						case VBPID14:	AP_Train_ST[0][5] |= LIVE_BPID14;	break;
						case VAPID21:	AP_Train_ST[0][6] |= LIVE_APID21;	break;
						case VBPID21:	AP_Train_ST[0][6] |= LIVE_BPID21;	break;
						}
					}
				}
				CL_Rx_ID = 0xFF;
			}
			else
			{
				Set_MS_State(SET_MAIN);		// ???
			}
		}

		if (CL_State == ST_CL_POllING)
		{
			CL_PollM_IDX++;
			if (CL_PollM_IDX > 8) CL_PollM_IDX = 0;

			if (CL_PollM_IDX == 6)
			{
				CL_Poll1_IDX++;
				if (CL_Poll1_IDX > 9) CL_Poll1_IDX = 0;
			}
			if (CL_PollM_IDX == 7)
			{
				CL_Poll2_IDX++;
				if (CL_Poll2_IDX > 9) CL_Poll2_IDX = 0;
			}
			if (CL_PollM_IDX == 8)
			{
				CL_Poll3_IDX++;
				if (CL_Poll3_IDX > 9) CL_Poll3_IDX = 0;
			}
		}

		if ((T_State & F_PAC_MAIN) == F_PAC_MAIN) CL_Tx_Turn = true;

		if (CL_PollM_Arr[CL_PollM_IDX] == VACNCS || CL_PollM_Arr[CL_PollM_IDX] == VBCNCS ||
			CL_Poll1_Arr[CL_Poll1_IDX] == VACNCS || CL_Poll1_Arr[CL_Poll1_IDX] == VBCNCS ||
			CL_PollM_Arr[CL_PollM_IDX] == VACCP || CL_PollM_Arr[CL_PollM_IDX] == VBCCP ||
			CL_Poll1_Arr[CL_Poll1_IDX] == VACCP || CL_Poll1_Arr[CL_Poll1_IDX] == VBCCP ||
			CL_PollM_Arr[CL_PollM_IDX] == VAVOIPC || CL_PollM_Arr[CL_PollM_IDX] == VBVOIPC ||
			CL_Poll1_Arr[CL_Poll1_IDX] == VAVOIPC || CL_Poll1_Arr[CL_Poll1_IDX] == VBVOIPC
			)
		{
			CL_TCnt = 10;
		}
		else
		{
			CL_TCnt = CL_Tick;
		}
	}	// CL_TCnt = 0

	if (TL_Mode_Send)
	{
		switch (TL_State_Send)
		{
		case 0:
			TL_State_Send++;
			break;

		case 1:
			TL_Tx_State = TTX_ST_DUMMY1;
			TIM_ITConfig(TIM2, TIM_TO_IT, DISABLE);
			UART_RxConfig(UART2, DISABLE);
			GPIO0->PD |= PO_TL_TX;
			TL_State_Send++;
			break;

		case 2:
			UART2->IER |= 0x0002;
			TL_State_Send++;
			break;

		case 3:
			break;
		}
	}
	if(P_Broad_Priorit>0){
		P_Broad_Priorit--;
	}
}

void	TL_Timer(void)
{
	//int		i;//, j;
	u8		temp8;
	//u16		temp16;

	if (TL_TCnt > 0) TL_TCnt--;

	if (TL_TCnt == 0)
	{
		if (TL_State == ST_TL_POLLING)
		{
			temp8 = (1 << TL_Rx_SrcID);

			if (TL_Chk_ID == TL_Rx_SrcID)
			{
				A_ErrCars[TL_Chk_ID] = 0;
				T_Cars_Err &= ~temp8;
			}
			else
			{
				A_ErrCars[TL_Chk_ID]++;

				if (A_ErrCars[TL_Chk_ID] > 7)
				{
					A_ErrCars[TL_Chk_ID] = 7;
					T_Cars_Err |= temp8;
					//AP_Train_ST[TL_Chk_ID][0] = ???
					AP_Train_ST[TL_Chk_ID][1] = 0xFF;
					AP_Train_ST[TL_Chk_ID][2] = 0xFF;
					AP_Train_ST[TL_Chk_ID][3] = 0x77;
					AP_Train_ST[TL_Chk_ID][4] = 0xFF;
					AP_Train_ST[TL_Chk_ID][5] = 0xFF;
					AP_Train_ST[TL_Chk_ID][6] = 0xBB;
					AP_Train_ST[TL_Chk_ID][7] = 0x00;
					AP_Train_ST[TL_Chk_ID][8] = 0x99;
				}
			}

			TL_Poll_ID++;
			if (TL_Poll_ID > T_Train_Len) TL_Poll_ID = 1;
			TL_Tx_Turn = true;
			TL_Rx_SrcID = 0;
		}

		if (TL_State == ST_TL_WAIT)
		{
			P_Coupling_ID = 0;
			P_CCI = 0x01;
			TIM_ITConfig(TIM2, TIM_TO_IT, DISABLE);
		}

		if (TL_State == ST_TL_COUPLING)
		{
			TL_Tx_Turn = true;
		}

		TL_TCnt = TL_Tick;
	}
}

/*
void	PAC_Reboot(void)
{
	pFunction Jump_To_Application;

	Jump_To_Application = (pFunction) (0x40004000);
	Jump_To_Application();
}
*/

////////////////////////////////////////////////////////////////////////////////

static	void	Make_Data(u8 vid)
{
	int		i;
	u16	 	cnt = 0;
	u8 		cra_temp,crb_temp;

	if (vid == 40)		// 0
	{
		TL_Tx_Len = 0;

		TL_Tx_Data[cnt++] = P_Broad_Device;		//0
		TL_Tx_Data[cnt++] = AP_TrainNum[0];
		TL_Tx_Data[cnt++] = AP_TrainNum[1];
		TL_Tx_Data[cnt++] = AP_TrainNum[2];
		TL_Tx_Data[cnt++] = AP_CrewID[0];
		TL_Tx_Data[cnt++] = AP_CrewID[1];
		TL_Tx_Data[cnt++] = AP_CrewID[2];
		TL_Tx_Data[cnt++] = AP_TrigID[0];
		TL_Tx_Data[cnt++] = AP_TrigID[1];
		TL_Tx_Data[cnt++] = AP_TrigID[2];
		TL_Tx_Data[cnt++] = P_St_Type;			//10
		TL_Tx_Data[cnt++] = AP_St_Start[0];
		TL_Tx_Data[cnt++] = AP_St_Start[1];
		TL_Tx_Data[cnt++] = AP_St_Now[0];
		TL_Tx_Data[cnt++] = AP_St_Now[1];
		TL_Tx_Data[cnt++] = AP_St_Next[0];
		TL_Tx_Data[cnt++] = AP_St_Next[1];
		TL_Tx_Data[cnt++] = AP_St_Dest[0];
		TL_Tx_Data[cnt++] = AP_St_Dest[1];
		TL_Tx_Data[cnt++] = ESpk_State;
		TL_Tx_Data[cnt++] = CISpk_State;		//20
		TL_Tx_Data[cnt++] = P_Disp_Msg;
		TL_Tx_Data[cnt++] = P_LED_MR;
		TL_Tx_Data[cnt++] = P_PR_Active;
		TL_Tx_Data[cnt++] = AP_PR_Msg[0];
		TL_Tx_Data[cnt++] = AP_PR_Msg[1];
		TL_Tx_Data[cnt++] = AP_PAC_Vec[0];
		TL_Tx_Data[cnt++] = AP_PAC_Vec[1];
		TL_Tx_Data[cnt++] = AP_FSDI_Vec[0];
		TL_Tx_Data[cnt++] = AP_FSDI_Vec[1];
		TL_Tx_Data[cnt++] = AP_DD_Vec1[0];		//30
		TL_Tx_Data[cnt++] = AP_DD_Vec1[1];
		TL_Tx_Data[cnt++] = AP_DD_Vec2[0];
		TL_Tx_Data[cnt++] = AP_DD_Vec2[1];
		TL_Tx_Data[cnt++] = AP_PII_Vec[0];
		TL_Tx_Data[cnt++] = AP_PII_Vec[1];
		TL_Tx_Data[cnt++] = AP_PPL_Vec[0];
		TL_Tx_Data[cnt++] = AP_PPL_Vec[1];
		TL_Tx_Data[cnt++] = AP_PPD_Vec[0];
		TL_Tx_Data[cnt++] = AP_PPD_Vec[1];
		TL_Tx_Data[cnt++] = AP_SP_Vec[0];		//40
		TL_Tx_Data[cnt++] = AP_SP_Vec[1];
		for (i=0 ; i<10 ; i++)
		{
			TL_Tx_Data[cnt++] = AP_St_Skip[i];
		}
		TL_Tx_Data[cnt++] = P_Coupling_ID;		//52
		TL_Tx_Data[cnt++] = AP_Train_ST[0][0];
		TL_Tx_Data[cnt++] = AP_Train_ST[0][1];
		TL_Tx_Data[cnt++] = AP_Train_ST[0][2];
	#if !PAC_PROTOCOL_R10
		cra_temp = ((AP_CI_AFLT & 0x01)<<3);
		crb_temp = ((AP_CI_BFLT & 0x01)<<7);
		TL_Tx_Data[cnt++] = AP_Train_ST[0][3] | crb_temp | cra_temp;
	#else
		TL_Tx_Data[cnt++] = AP_Train_ST[0][3];
	#endif
		TL_Tx_Data[cnt++] = AP_Train_ST[0][4];
		TL_Tx_Data[cnt++] = AP_Train_ST[0][5];
		TL_Tx_Data[cnt++] = AP_Train_ST[0][6];
	#if PAC_PROTOCOL_R10
		cra_temp = (AP_Train_ST[0][8] & 0x01) << 2;
		cra_temp = cra_temp | (AP_Train_ST[0][8] & 0x08);
		
		crb_temp = (AP_Train_ST[0][8] & 0x10) << 2;
		crb_temp = crb_temp | (AP_Train_ST[0][8] & 0x80);
	
		TL_Tx_Data[cnt++] = AP_Train_ST[0][7] | crb_temp | cra_temp;	//60
		
		cra_temp = (AP_CID_ALIC_Tx & 0x0F);
		crb_temp = ((AP_CID_BLIC_Tx & 0x0F)<<4);
		TL_Tx_Data[cnt++] = crb_temp | cra_temp;	//61
	#else
		TL_Tx_Data[cnt++] = AP_Train_ST[0][7];	//60
		TL_Tx_Data[cnt++] = AP_Train_ST[0][8];
	#endif
		TL_Tx_Data[cnt++] = A_CarNum[0][0];
		TL_Tx_Data[cnt++] = A_CarNum[0][1];
		//Debug_msg(0x12);
		for (i=0 ; i<8 ; i++)
		{
		#if PAC_PROTOCOL_R10
			TL_Tx_Data[cnt++] = AP_CID_Tx[i];
		#else
			TL_Tx_Data[cnt++] = AP_CID_Rx[i];
		#endif
			//Debug_msg(TL_Tx_Data[cnt-1]);
		}
		
	#if 0
		TL_Tx_Data[cnt++] = AP_CI_FLT;
	#else
		TL_Tx_Data[cnt++] = T_CI_Fault;			//72
	#endif
	
		TL_Tx_Data[cnt++] = T_Train_Len;		//73

		TL_Tx_Len = cnt;
	}
	else if (vid == 41)		// 1
	{
		TL_Tx_Len = 0;

		Coupling_CMD |= TLST_START;

		TL_Tx_Data[cnt++] = A_CarNum[0][0];
		TL_Tx_Data[cnt++] = A_CarNum[0][1];

		if ((A_Port_In[0] & PI_PAC_AB) != PI_PAC_AB)
		{
			TL_Tx_Data[cnt++] = 0xA0;
		}
		else
		{
			TL_Tx_Data[cnt++] = 0xB0;
		}

		TL_Tx_Len = cnt;
	}
	else
	{
		CL_Tx_Len = 0;

		switch (vid)
		{
		case VAPAC:
		case VBPAC:
			if ((T_State & F_PAC_MAIN) == F_PAC_MAIN && A_VDev_MS[AI_PACM] == vid)	// 내가 메인 메인에게 전체패킷
			{
				CL_Tx_Data[cnt++] = P_PAC_Token;		//0
				CL_Tx_Data[cnt++] = P_Coupling_ID;
				CL_Tx_Data[cnt++] = P_IOport;	//열차 진행 방향 0x40데이터를 추가.(CCP에서 전달 받음.)
				CL_Tx_Data[cnt++] = P_Broad_Device;
			#if PAC_PROTOCOL_R10
				CL_Tx_Data[cnt++] = P_Broad_Occ;
			#endif
				CL_Tx_Data[cnt++] = AP_POdo[0];
				CL_Tx_Data[cnt++] = AP_POdo[1];
				CL_Tx_Data[cnt++] = AP_POdo[2];
				CL_Tx_Data[cnt++] = AP_POdo[3];
				CL_Tx_Data[cnt++] = P_Ans_Vol;
				CL_Tx_Data[cnt++] = AP_TrainNum[0];		//10
				CL_Tx_Data[cnt++] = AP_TrainNum[1];
				CL_Tx_Data[cnt++] = AP_TrainNum[2];
				CL_Tx_Data[cnt++] = AP_CrewID[0];
				CL_Tx_Data[cnt++] = AP_CrewID[1];
				CL_Tx_Data[cnt++] = AP_CrewID[2];
				CL_Tx_Data[cnt++] = AP_TrigID[0];
				CL_Tx_Data[cnt++] = AP_TrigID[1];
				CL_Tx_Data[cnt++] = AP_TrigID[2];
				CL_Tx_Data[cnt++] = P_St_Type;
				CL_Tx_Data[cnt++] = AP_St_Start[0];		//20
				CL_Tx_Data[cnt++] = AP_St_Start[1];
				CL_Tx_Data[cnt++] = AP_St_Now[0];
				CL_Tx_Data[cnt++] = AP_St_Now[1];
				CL_Tx_Data[cnt++] = AP_St_Next[0];
				CL_Tx_Data[cnt++] = AP_St_Next[1];
				CL_Tx_Data[cnt++] = AP_St_Dest[0];
				CL_Tx_Data[cnt++] = AP_St_Dest[1];
				CL_Tx_Data[cnt++] = ESpk_State;
				CL_Tx_Data[cnt++] = CISpk_State;
				CL_Tx_Data[cnt++] = P_Disp_Msg;			//30
				CL_Tx_Data[cnt++] = P_LED_MR;
				CL_Tx_Data[cnt++] = P_PR_Active;
				CL_Tx_Data[cnt++] = AP_PR_Msg[0];
				CL_Tx_Data[cnt++] = AP_PR_Msg[1];
				CL_Tx_Data[cnt++] = AP_PAC_Vec[0];
				CL_Tx_Data[cnt++] = AP_PAC_Vec[1];
				CL_Tx_Data[cnt++] = AP_FSDI_Vec[0];
				CL_Tx_Data[cnt++] = AP_FSDI_Vec[1];
				CL_Tx_Data[cnt++] = AP_DD_Vec1[0];
				CL_Tx_Data[cnt++] = AP_DD_Vec1[1];		//40
				CL_Tx_Data[cnt++] = AP_DD_Vec2[0];
				CL_Tx_Data[cnt++] = AP_DD_Vec2[1];
				CL_Tx_Data[cnt++] = AP_PII_Vec[0];
				CL_Tx_Data[cnt++] = AP_PII_Vec[1];
				CL_Tx_Data[cnt++] = AP_PPL_Vec[0];
				CL_Tx_Data[cnt++] = AP_PPL_Vec[1];
				CL_Tx_Data[cnt++] = AP_PPD_Vec[0];
				CL_Tx_Data[cnt++] = AP_PPD_Vec[1];
				CL_Tx_Data[cnt++] = AP_SP_Vec[0];
				CL_Tx_Data[cnt++] = AP_SP_Vec[1];		//50
				for (i=0 ; i<10 ; i++)
				{
					CL_Tx_Data[cnt++] = AP_St_Skip[i];	//60
				}
				if((T_State & F_PAC_MASTER) == F_PAC_MASTER){
					for (i=0 ; i<8 ; i++)
					{						
						CL_Tx_Data[cnt++] = AP_CID_Tx[i];
					}
				}
				else{
					for (i=0 ; i<8 ; i++)
					{						
						CL_Tx_Data[cnt++] = AP_CID_Rx[i];
					}
				}
			#if 0
				//if(P_Coupling_ID != 0){// married car
				//if(P_Coupling_ID > 1){// married car
				if(T_Train_Len>1){
					for(i=0;i<8;i++){
						if(R_CI_Fault[i] == 1){
							AP_CI_FLT |= (0x01 << i);
						}
						else{
							AP_CI_FLT &= (~(0x01 << i));
						}
					}
					CL_Tx_Data[cnt++] = AP_CI_RFLT|AP_CI_FLT;
					//Debug_msg(0xC1);
					//Debug_msg(CL_Tx_Data[cnt-1]);
				}
				else{//single car
					CL_Tx_Data[cnt++] = T_CI_Fault;
					//Debug_msg(0xC2);
					//Debug_msg(CL_Tx_Data[cnt-1]);
				}
			#else
				CL_Tx_Data[cnt++] = T_CI_Fault;
			#endif
				CL_Tx_Data[cnt++] = P_CCI;
			#if PAC_PROTOCOL_R10	
				/*Debug_msg(0x0A);
				for(i=0,P_Posi_Index=0;i<5;i++){
					Debug_msg(A_TL_CarNum[i][0]);
					Debug_msg(A_TL_CarNum[i][1]);
				}*/
				for(i=1,P_Posi_Index=0;i<5;i++){
					//if((0x40==A_TL_CarNum[i][0])&&(0x22== A_TL_CarNum[i][1])){
					if((A_CarNum[0][0]==A_TL_CarNum[i][0])&&(A_CarNum[0][1]== A_TL_CarNum[i][1])){
						P_Posi_Index = i;
					//Debug_msg(0x0B);
					//Debug_msg(P_Posi_Index);
						break;
					}

				}
				CL_Tx_Data[cnt++] = P_Posi_Index;
			#endif	
				for (i=1 ; i<5 ; i++)
				{
					CL_Tx_Data[cnt++] = AP_Train_ST[i][0];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][1];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][2];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][3];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][4];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][5];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][6];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][7];
					CL_Tx_Data[cnt++] = AP_Train_ST[i][8];

					CL_Tx_Data[cnt++] = A_TL_CarNum[i][0];
					CL_Tx_Data[cnt++] = A_TL_CarNum[i][1];
				}
				/*
				Debug_msg(0x19);
				Debug_msg(A_CarNum[0][0]);
				Debug_msg(A_CarNum[0][1]);
				Debug_msg(A_TL_CarNum[0][0]);
				Debug_msg(A_TL_CarNum[0][1]);
				*/
				CL_Tx_Data[cnt++] = T_Train_Len;
			#if PAC_PROTOCOL_R10
				for (i=0 ; i<8 ; i++)
				{
					CL_Tx_Data[cnt++] = AP_CID_LIC_Rx[i];
					//CL_Tx_Data[cnt++] = AP_CID_Rx[i];//send to LIC car line data
				}
			#endif
			}
			else
			{
				CL_Tx_Data[cnt++] = P_Ans_Vol;
				CL_Tx_Data[cnt++] = P_Broad_Device;
			#if PAC_PROTOCOL_R10
				CL_Tx_Data[cnt++] = P_Broad_Occ;
			#endif
			}
			CL_Tx_Len = cnt;
			break;
			/*
			CL_Tx_Data[cnt++] = A_FirmVer[0];
			CL_Tx_Data[cnt++] |= A_FirmVer[1];
			CL_Tx_Data[cnt++] = A_FirmVer[2];

			CL_Tx_Data[cnt] = T_Date[0];
			CL_Tx_Data[cnt] <<= 4;
			CL_Tx_Data[cnt++] |= T_Date[1];
			CL_Tx_Data[cnt] = T_Date[2];
			CL_Tx_Data[cnt] <<= 4;
			CL_Tx_Data[cnt++] |= T_Date[3];
			CL_Tx_Data[cnt] = T_Date[4];
			CL_Tx_Data[cnt] <<= 4;
			CL_Tx_Data[cnt++] |= T_Date[5];

			CL_Tx_Len = cnt;
			*/

		case VACCP:
		case VBCCP:
		case VAVTX:
		case VBVTX:
		case VAVOIPC:
		case VBVOIPC:
		case VALIC:
		case VBLIC:
		case VACNCS:
		case VBCNCS:
		case VAPII1:
		case VAPII2:
		case VBPII1:
		case VBPII2:
		case VAFDI:
		case VBFDI:
		case VASDI1:
		case VASDI2:
		case VASDI3:
		case VASDI4:
		case VBSDI1:
		case VBSDI2:
		case VBSDI3:
		case VBSDI4:
		case VAPID11:
		case VAPID12:
		case VAPID13:
		case VAPID14:
		case VBPID11:
		case VBPID12:
		case VBPID13:
		case VBPID14:
		case VAPID21:
		case VBPID21:
			CL_Tx_Data[cnt++] = P_Broad_Device;
		#if PAC_PROTOCOL_R10
			CL_Tx_Data[cnt++] = P_Broad_Occ;
		#endif

			CL_Tx_Len = cnt;
		//====================================================
		//VoIP protocol 확인후 삭제.
			if(vid == VAVOIPC){
				if(gByAVoIPComm == 0){
					gByAVoIPComm = 1;
				}
				else{
					gVAVOIPC = 0;					
				}
			}
			if(vid == VBVOIPC){
				if(gByBVoIPComm == 0){
					gByBVoIPComm = 1;
				}
				else{
					gVBVOIPC = 0;					
				}
			}
		//====================================================
			
			break;
		}
	}

}
static 	void Car_Number_Process(u8 vvsid)
{
	u32		i;
	u8		carh, carl;
	

#if PAC_PROTOCOL_R10
	if (CL_Rx_Data[CL_Rx_Index-2] == 0 && CL_Rx_Data[CL_Rx_Index-1] == 0)
	{
	}
#else
	if (CL_Rx_Data[2] == 0 && CL_Rx_Data[3] == 0)
	{
	}
#endif
	else
	{
		AI_CarNum++;
		if (AI_CarNum > 3) AI_CarNum = 0;

	
	#if PAC_PROTOCOL_R10
		if (vvsid == VACNCS)
	#else
		if (vvsid == VALIC)
	#endif
		{
			if (T_Me_AB == 1)
			{
			#if PAC_PROTOCOL_R10
				A_CarNum[AI_CarNum][0] = CL_Rx_Data[CL_Rx_Index-2];
				A_CarNum[AI_CarNum][1] = CL_Rx_Data[CL_Rx_Index-1];
			#else
				A_CarNum[AI_CarNum][0] = CL_Rx_Data[2];
				A_CarNum[AI_CarNum][1] = CL_Rx_Data[3];
			#endif
			}
			else
			{
			#if PAC_PROTOCOL_R10
				carh = CL_Rx_Data[CL_Rx_Index-2];
				carl = CL_Rx_Data[CL_Rx_Index-1];
			#else
				carh = CL_Rx_Data[2];
				carl = CL_Rx_Data[3];
			#endif
				HexIncDec(&carh, &carl, 1);
				A_CarNum[AI_CarNum][0] = carh;
				A_CarNum[AI_CarNum][1] = carl;
			}
		}
		else
		{
			if (T_Me_AB == 1)
			{
			#if PAC_PROTOCOL_R10
				carh = CL_Rx_Data[CL_Rx_Index-2];
				carl = CL_Rx_Data[CL_Rx_Index-1];
			#else
				carh = CL_Rx_Data[2];
				carl = CL_Rx_Data[3];
			#endif

				HexIncDec(&carh, &carl, 0);
				A_CarNum[AI_CarNum][0] = carh;
				A_CarNum[AI_CarNum][1] = carl;
			}
			else
			{
			#if PAC_PROTOCOL_R10
				A_CarNum[AI_CarNum][0] = CL_Rx_Data[CL_Rx_Index-2];
				A_CarNum[AI_CarNum][1] = CL_Rx_Data[CL_Rx_Index-1];
			#else
				A_CarNum[AI_CarNum][0] = CL_Rx_Data[2];
				A_CarNum[AI_CarNum][1] = CL_Rx_Data[3];
			#endif
			}
		}

		if ((A_CarNum[0][0] != A_CarNum[AI_CarNum][0]) || (A_CarNum[0][1] != A_CarNum[AI_CarNum][1]))
		{
			//if (A_CarNum[1][0] == A_CarNum[2][0] && A_CarNum[2][0] == A_CarNum[3][0] &&
			//	A_CarNum[1][1] == A_CarNum[2][1] && A_CarNum[2][1] == A_CarNum[3][1])
			if (A_CarNum[2][0] == A_CarNum[3][0] && A_CarNum[2][1] == A_CarNum[3][1])
			{
				A_CarNum[0][0] = A_CarNum[1][0];
				A_CarNum[0][1] = A_CarNum[1][1];
				A_TL_CarNum[0][0] = A_CarNum[1][0];
				A_TL_CarNum[0][1] = A_CarNum[1][1];

				A_FSys[I_CARNUM1] = A_CarNum[0][0];
				A_FSys[I_CARNUM2] = A_CarNum[0][1];



				if (Flash_Enable)
				{
				#if PAC_PROTOCOL_R10
					FLASH_EraseSector(FLASH_BANK1_SECTOR0);
					FLASH_WaitForLastOperation();
					for (i=0 ; i<AS_FSYS ; i++)
					//for (i=4 ; i<6 ; i++)
					{
						FLASH_WriteWord(0x000C1000 + (i * 4), (u32)A_FSys[(u8)i]);
						FLASH_WaitForLastOperation();
					}
				#else
					FLASH_EraseSector(FLASH_BANK1_SECTOR1);
					FLASH_WaitForLastOperation();
					for (i=0 ; i<AS_FVOL ; i++)
					{
						FLASH_WriteWord(0x000C2000 + (i * 4), (u32)A_FVol[(u8)i]);
						FLASH_WaitForLastOperation();
					}
				#endif
				}
				/*
				Debug_msg(0x18);
				Debug_msg(A_CarNum[0][0]);
				Debug_msg(A_CarNum[0][1]);
				Debug_msg(A_FSys[I_CARNUM1]);
				Debug_msg(A_FSys[I_CARNUM2]);
				temp8 = (u8)(*(u32*)(0x000C1000 + (0 * 4)));
				Debug_msg(temp8);
				temp8 = (u8)(*(u32*)(0x000C1000 + (1 * 4)));
				Debug_msg(temp8);
				temp8 = (u8)(*(u32*)(0x000C1000 + (2 * 4)));
				Debug_msg(temp8);
				temp8 = (u8)(*(u32*)(0x000C1000 + (3 * 4)));
				Debug_msg(temp8);
				temp8 = (u8)(*(u32*)(0x000C1000 + (4 * 4)));
				Debug_msg(temp8);
				temp8 = (u8)(*(u32*)(0x000C1000 + (5 * 4)));
				Debug_msg(temp8);
				temp8 = (u8)(*(u32*)(0x000C1000 + (6 * 4)));
				Debug_msg(temp8);
				*/
			}
			
		}
		/*
		Debug_msg(0x16);
		Debug_msg(A_CarNum[0][0]);
		Debug_msg(A_CarNum[0][1]);
		Debug_msg(A_CarNum[1][0]);
		Debug_msg(A_CarNum[1][1]);
		Debug_msg(A_CarNum[2][0]);
		Debug_msg(A_CarNum[2][1]);
		Debug_msg(A_CarNum[3][0]);
		Debug_msg(A_CarNum[3][1]);
		*/
	}
}
static	void	Read_CL_Data(u8 vsid, u8 vdid)
{
	u32		i;
	u8		tempid, temp8;
	//u8		carh, carl;

	switch (vsid)
	{
	case VALIC:		// ???
	case VBLIC:
		// LIC가 죽은 T_CI_Fault는 어케 처리하나?
		tempid = P_Coupling_ID;
		if (tempid == 0) tempid = 1;
		tempid = (tempid - 1) * 2;
		
		if ((AP_Train_ST[P_Coupling_ID][0] & A_HEADING) == A_HEADING)	// 4001 4002
		{
			if (vsid == VBLIC) tempid = tempid + 1;
		}
		else		// 4002 4001
		{
			if (vsid == VALIC) tempid = tempid + 1;
		}

	#if PAC_PROTOCOL_R10
		if(vsid == VALIC){
			AP_CID_ALIC_Tx = CL_Rx_Data[1];
		#if 0	
			if ((CL_Rx_Data[0] & P_LIC_CIFAULT) == P_LIC_CIFAULT){
				AP_CI_AFLT = 1;
			}
			else{
				AP_CI_AFLT = 0;
			}
		#endif
		}
		else{
			AP_CID_BLIC_Tx = CL_Rx_Data[1];
		#if 0	
			if ((CL_Rx_Data[0] & P_LIC_CIFAULT) == P_LIC_CIFAULT){
				AP_CI_BFLT = 1;
			}
			else{
				AP_CI_BFLT = 0;
			}
		#endif
		}
		AP_CID_LIC_Rx[tempid] = CL_Rx_Data[1];
	#else
		AP_CID_Rx[tempid] = CL_Rx_Data[1];
	#endif	

		//car line통신 시 처리.
		if ((CL_Rx_Data[0] & P_LIC_CIFAULT) == P_LIC_CIFAULT)
		{
			if(T_Train_Len == 1){
				T_CI_Fault = (T_CI_Fault & 0x03) | (1 << tempid);
			}
			else{
				T_CI_Fault |= (1 << tempid);
			}
		}
		else
		{
			if(T_Train_Len == 1){
				T_CI_Fault = (T_CI_Fault & 0x03) & (~(1 << tempid));
			}
			else{
				T_CI_Fault &= ~(1 << tempid);
			}
		}
		
		if (vsid != A_VDev_MS[AI_LICM]) break;
	#if !(PAC_PROTOCOL_R10)
		Car_Number_Process(vsid);
	#endif
		break;

	case VAPAC:
	case VBPAC:

		if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)
		{
			if ((T_State & F_CNCS_AUTO) != F_CNCS_AUTO)
			{
				if ((vsid == VAPAC && vdid == VBPAC) || (vsid == VBPAC && vdid == VAPAC))
				{
				#if PAC_PROTOCOL_R10
					if ((CL_Rx_Data[1] & P_PAC_CNCS_PLAY) == P_PAC_CNCS_PLAY)
					{
						P_Broad_Occ |= P_PAC_CNCS_PLAY;
					}
					else
					{
						P_Broad_Occ &= ~P_PAC_CNCS_PLAY;
					}
					//Debug_msg(0xAA);
				#else
					if ((CL_Rx_Data[1] & P_PAC_CNCS_PLAY) == P_PAC_CNCS_PLAY)
					{
						P_Broad_Device |= P_PAC_CNCS_PLAY;
					}
					else
					{
						P_Broad_Device &= ~P_PAC_CNCS_PLAY;
					}
				#endif
				}
			}
		}
		else
		{
			if ((vsid == VAPAC && vdid == VAPAC) || (vsid == VBPAC && vdid == VBPAC))
			{
				//Debug_msg(0xAB);
				P_Coupling_ID = CL_Rx_Data[1];
			#if PAC_PROTOCOL_R10
				if (P_Coupling_ID == 0 || P_Coupling_ID == 1) temp8 = 72;
				if (P_Coupling_ID == 2) temp8 = 83;
				if (P_Coupling_ID == 3) temp8 = 94;
				if (P_Coupling_ID == 4) temp8 = 105;
				T_Train_Len = CL_Rx_Data[116];
			#else
				if (P_Coupling_ID == 0 || P_Coupling_ID == 1) temp8 = 70;
				if (P_Coupling_ID == 2) temp8 = 81;
				if (P_Coupling_ID == 3) temp8 = 92;
				if (P_Coupling_ID == 4) temp8 = 103;
				T_Train_Len = CL_Rx_Data[114];
			#endif
				AP_Train_ST[0][0] = CL_Rx_Data[temp8+0];
				AP_Train_ST[0][1] = CL_Rx_Data[temp8+1];
				AP_Train_ST[0][2] = CL_Rx_Data[temp8+2];
				AP_Train_ST[0][3] = CL_Rx_Data[temp8+3];
				AP_Train_ST[0][4] = CL_Rx_Data[temp8+4];
				AP_Train_ST[0][5] = CL_Rx_Data[temp8+5];
				AP_Train_ST[0][6] = CL_Rx_Data[temp8+6];
				AP_Train_ST[0][7] = CL_Rx_Data[temp8+7];
				AP_Train_ST[0][8] = CL_Rx_Data[temp8+8];

				if (T_Me_AB == 1)
				{
					if ((AP_Train_ST[0][0] & A_HEADING) == A_HEADING)
					{
						T_State |= F_TRAIN_HEAD;
					}
					else
					{
						T_State &= ~F_TRAIN_HEAD;
					}
				}
				else
				{
					if ((AP_Train_ST[0][0] & B_HEADING) == B_HEADING)
					{
						T_State |= F_TRAIN_HEAD;
					}
					else
					{
						T_State &= ~F_TRAIN_HEAD;
					}
				}
			}

			if (T_Me_AB == 1)
			{
				if (vdid != VAPAC) break;
				Make_Data(VAPAC);
				for(i=0 ; i<0x2FFF ; i++);
				if (A_CLMsg_Num[VAPAC]++ >= 100) A_CLMsg_Num[VAPAC] = 0;
				CL_Send(0x21, 0x25, A_CLMsg_Num[VAPAC], 0x11, CL_Tx_Len);
			}
			else
			{
				if (vdid != VBPAC) break;
				for(i=0 ; i<0x2FFF ; i++);
				if (A_CLMsg_Num[VBPAC]++ >= 100) A_CLMsg_Num[VBPAC] = 0;
				Make_Data(VBPAC);
				CL_Send(0x25, 0x21, A_CLMsg_Num[VBPAC], 0x11, CL_Tx_Len);
			}
		}
		break;

	case VACCP:
	case VBCCP:
		if (vsid != A_VDev_MS[AI_CCPM]) break;

		if (P_Coupling_ID == 0 || (T_State & F_PAC_MASTER) == F_PAC_MASTER)
		{
		#if PAC_PROTOCOL_R10
			if((CL_Rx_Data[0] & P_CCP_TRAIN_DIRECT)==P_CCP_TRAIN_DIRECT){
				P_IOport |= P_TRAIN_DIRECT;//1 : 열차 상향 방향.
			}
			else{
				P_IOport &= ~P_TRAIN_DIRECT;//0 : 열차 하향 방향.
			}
		#endif	
			AP_TrainNum[0] = CL_Rx_Data[1];
			AP_TrainNum[1] = CL_Rx_Data[2];
			AP_TrainNum[2] = CL_Rx_Data[3];
			AP_CrewID[0] = CL_Rx_Data[4];
			AP_CrewID[1] = CL_Rx_Data[5];
			AP_CrewID[2] = CL_Rx_Data[6];
			AP_TrigID[0] = CL_Rx_Data[7];
			AP_TrigID[1] = CL_Rx_Data[8];
			AP_TrigID[2] = CL_Rx_Data[9];
			P_St_Type &= ~0x7F;
			P_St_Type |= CL_Rx_Data[10];
			AP_St_Start[0] = CL_Rx_Data[11];
			AP_St_Start[1] = CL_Rx_Data[12];
			AP_St_Now[0] = CL_Rx_Data[13];
			AP_St_Now[1] = CL_Rx_Data[14];
			AP_St_Next[0] = CL_Rx_Data[15];
			AP_St_Next[1] = CL_Rx_Data[16];
			AP_St_Dest[0] = CL_Rx_Data[17];
			AP_St_Dest[1] = CL_Rx_Data[18];
			ESpk_State = CL_Rx_Data[19];
			CISpk_State = CL_Rx_Data[20];
			AP_COdo[0] = CL_Rx_Data[21];
			AP_COdo[1] = CL_Rx_Data[22];
			AP_COdo[2] = CL_Rx_Data[23];
			AP_COdo[3] = CL_Rx_Data[24];
			P_Disp_Msg = CL_Rx_Data[25];
			P_LED_MR = CL_Rx_Data[26];
			P_PR_Active = CL_Rx_Data[27];
			AP_PR_Msg[0] = CL_Rx_Data[28];
			AP_PR_Msg[1] = CL_Rx_Data[29];
			AP_PAC_Vec[0] = CL_Rx_Data[30];
			AP_PAC_Vec[1] = CL_Rx_Data[31];
			AP_FSDI_Vec[0] = CL_Rx_Data[32];
			AP_FSDI_Vec[1] = CL_Rx_Data[33];
			AP_DD_Vec1[0] = CL_Rx_Data[34];
			AP_DD_Vec1[1] = CL_Rx_Data[35];
			AP_DD_Vec2[0] = CL_Rx_Data[36];
			AP_DD_Vec2[1] = CL_Rx_Data[37];
			AP_PII_Vec[0] = CL_Rx_Data[38];
			AP_PII_Vec[1] = CL_Rx_Data[39];
			AP_PPL_Vec[0] = CL_Rx_Data[40];
			AP_PPL_Vec[1] = CL_Rx_Data[41];
			AP_PPD_Vec[0] = CL_Rx_Data[42];
			AP_PPD_Vec[1] = CL_Rx_Data[43];
			AP_SP_Vec[0] = CL_Rx_Data[44];
			AP_SP_Vec[1] = CL_Rx_Data[45];
			for (i=0 ; i<10 ; i++) AP_St_Skip[i] = CL_Rx_Data[46 + i];

			for (i=0 ; i<8 ; i++) {
				AP_CID_Tx[i] = CL_Rx_Data[56 + i];

			}
			if ((ESpk_State & ESP_NORMAL) == ESP_NORMAL && (ESpk_ST_Me & ESP_NORMAL) != ESP_NORMAL)
			{
				Set_Vol_I2C(2);
				Set_Vol_I2C(3);
				ESpk_ST_Me |= ESP_NORMAL;
				ESpk_ST_Me &= ~ESP_SOFT;
			}
			if ((ESpk_State & ESP_SOFT) == ESP_SOFT && (ESpk_ST_Me & ESP_SOFT) != ESP_SOFT)
			{
				Set_Vol_I2C(2);
				Set_Vol_I2C(3);
				ESpk_ST_Me &= ~ESP_NORMAL;
				ESpk_ST_Me |= ESP_SOFT;
			}
			if ((CISpk_State & ISP_NORMAL) == ISP_NORMAL && (CISpk_ST_Me & ISP_NORMAL) != ISP_NORMAL)
			{
				Set_Vol_I2C(1);
				CISpk_ST_Me |= ISP_NORMAL;
				CISpk_ST_Me &= ~ISP_SOFT;
			}
			if ((CISpk_State & ISP_SOFT) == ISP_SOFT && (CISpk_ST_Me & ISP_SOFT) != ISP_SOFT)
			{
				Set_Vol_I2C(1);
				CISpk_ST_Me &= ~ISP_NORMAL;
				CISpk_ST_Me |= ISP_SOFT;
			}
			if ((CISpk_State & CSP_NORMAL) == CSP_NORMAL && (CISpk_ST_Me & CSP_NORMAL) != CSP_NORMAL)
			{
				Set_Vol_I2C(4);
				CISpk_ST_Me |= CSP_NORMAL;
				CISpk_ST_Me &= ~CSP_SOFT;
			}
			if ((CISpk_State & CSP_SOFT) == CSP_SOFT && (CISpk_ST_Me & CSP_SOFT) != CSP_SOFT)
			{
				Set_Vol_I2C(4);
				CISpk_ST_Me &= ~CSP_NORMAL;
				CISpk_ST_Me |= CSP_SOFT;
			}
		}
		break;

	case VACNCS:
	case VBCNCS:

		if (vsid == VACNCS)
		{
		#if PAC_PROTOCOL_R10
			if ((CL_Rx_Data[1] & 0x01) != 0x01)
		#else
			if ((CL_Rx_Data[1] & 0x04) != 0x04)
		#endif
			{
				AP_Train_ST[0][1] |= LIVE_AWLR;
			}
			else
			{
				AP_Train_ST[0][1] &= ~LIVE_AWLR;
			}
		#if PAC_PROTOCOL_R10
			if ((CL_Rx_Data[24] & 0x80) != 0x80)
		#else
			if ((CL_Rx_Data[23] & 0x80) != 0x80)
		#endif
			{
				AP_Train_ST[0][1] |= LIVE_AGPS;
			}
			else
			{
				AP_Train_ST[0][1] &= ~LIVE_AGPS;
			}
		}
		else
		{
		#if PAC_PROTOCOL_R10
			if ((CL_Rx_Data[1] & 0x01) != 0x01)
		#else
			if ((CL_Rx_Data[1] & 0x04) != 0x04)
		#endif
			{
				AP_Train_ST[0][1] |= LIVE_BWLR;
			}
			else
			{
				AP_Train_ST[0][1] &= ~LIVE_BWLR;
			}
		#if PAC_PROTOCOL_R10
			if ((CL_Rx_Data[24] & 0x80) != 0x80)
		#else
			if ((CL_Rx_Data[23] & 0x80) != 0x80)
		#endif
			{
				AP_Train_ST[0][1] |= LIVE_BGPS;
			}
			else
			{
				AP_Train_ST[0][1] &= ~LIVE_BGPS;
			}
		}

		if (vsid != A_VDev_MS[AI_CNCSM]) break;

		P_CNCS_PA = CL_Rx_Data[2];

	#if PAC_PROTOCOL_R10
		if ((CL_Rx_Data[24] & 0x01) == 0x01)
	#else
		if ((CL_Rx_Data[23] & 0x01) == 0x01)
	#endif
		{
			P_St_Type |= 0x80;
		}
		else
		{
			P_St_Type &= ~0x80;
		}

		AI_ChkS_FVol++;
		if (AI_ChkS_FVol > 3) AI_ChkS_FVol = 1;
		A_ChkS_FVol[AI_ChkS_FVol] = 0;

		for (i=0 ; i<AS_FVOL ; i++) A_ChkS_FVol[AI_ChkS_FVol] ^= CL_Rx_Data[i+4];

		if ((A_ChkS_FVol[0] != A_ChkS_FVol[1]) && (A_ChkS_FVol[1] == A_ChkS_FVol[2]) && (A_ChkS_FVol[2] == A_ChkS_FVol[3]))
		{
			A_ChkS_FVol[0] = A_ChkS_FVol[1];
			
		#if PAC_PROTOCOL_R10
			for (i=0 ; i<AS_FVOL ; i++)	A_FVol[i] = CL_Rx_Data[i+4];

			
			if (Flash_Enable)
			{
				FLASH_EraseSector(FLASH_BANK1_SECTOR1);
				FLASH_WaitForLastOperation();

				for (i=0 ; i<AS_FVOL ; i++)
				{
					FLASH_WriteWord(0x000C2000 + (i * 4), (u32)A_FVol[i]);
					FLASH_WaitForLastOperation();
				}
				/*
				Debug_msg(0xca);
				Debug_msg(A_FVol[12]);
				Debug_msg(A_FVol[13]);
				Debug_msg(A_FVol[14]);
				*/
			}
			//temp8 = (u8)(*(u32*)(0x400C2000 + (13 * 4)));
			//Debug_msg(temp8);
		#endif

			for (i=1 ; i<10 ; i++) Set_Vol_I2C(i);
		}

	#if (PAC_PROTOCOL_R10)
		//Debug_msg(CL_Rx_Data[CL_Rx_Index-2]);
		//Debug_msg(CL_Rx_Data[CL_Rx_Index-1]);
		Car_Number_Process(vsid);
	#endif
		break;

	case VAVOIPC:
	case VBVOIPC:
		if (vsid != A_VDev_MS[AI_VOIPCM])
		{
			break;
		}

		//P_VOIPC_0 = CL_Rx_Data[0];
		temp8 = temp8;
		break;

	case VAVTX:
	case VBVTX:
	case VAPII1:
	case VAPII2:
	case VBPII1:
	case VBPII2:
	case VAFDI:
	case VBFDI:
	case VASDI1:
	case VASDI2:
	case VASDI3:
	case VASDI4:
	case VBSDI1:
	case VBSDI2:
	case VBSDI3:
	case VBSDI4:
	case VAPID11:
	case VAPID12:
	case VAPID13:
	case VAPID14:
	case VBPID11:
	case VBPID12:
	case VBPID13:
	case VBPID14:
	case VAPID21:
	case VBPID21:
		break;
	}
}

////////////////////////////////////////////////////////////////////////////////

static	void	Set_Vol_I2C(u8 sel)
{
	u8		i;
	u8		I2C_Val;
	u16		temp70, temp80;

	GPIO2->PD &= ~PO_SCL_SEL_3;
	GPIO1->PD &= ~(PO_SCL_SEL_2 + PO_SCL_SEL_1 + PO_SCL_SEL_0);

	switch (sel)
	{
	case 1:		// ISP	0001

		if ((CISpk_State & ISP_NORMAL) == ISP_NORMAL)
		{
			I2C_Val = A_FVol[I_V_NORISP];
		}
		else
		{
			I2C_Val = A_FVol[I_V_SOFTISP];
		}

		if (A_FVol[I_V_ANSSW] > 0)
		{
			temp70 = A_FVol[I_V_I70H];
			temp70 <<= 8;
			temp70 |= A_FVol[I_V_I70L];
			temp80 = A_FVol[I_V_I80H];
			temp80 <<= 8;
			temp80 |= A_FVol[I_V_I80L];

			if (A_FVol[I_V_ANSSEC] > 5) A_FVol[I_V_ANSSEC] = 5;
			for (i=0 ; i<A_FVol[I_V_ANSSEC]*5 ; i++)
			{
				T_Ans_Avr += A_Ans_Val[i];
			}

			T_Ans_Avr = T_Ans_Avr / (A_FVol[I_V_ANSSEC]*5);

			if (T_Ans_Avr > temp80)			// 입력 80db 출력 85dbm
			{
				I2C_Val += A_FVol[I_V_O85];
			}
			else if (T_Ans_Avr > temp70)	// 입력 70db 출력 80dbm
			{
				I2C_Val += A_FVol[I_V_O80];
			}
		}
		P_Ans_Vol = I2C_Val;
		GPIO1->PD |= PO_SCL_SEL_0;
		break;

	case 2:		// ESP L	0010
		if ((ESpk_State & ESP_NORMAL) == ESP_NORMAL)
		{
			I2C_Val = A_FVol[I_V_NORESP];
		}
		else
		{
			I2C_Val = A_FVol[I_V_SOFTESP];
		}

		GPIO1->PD |= PO_SCL_SEL_1;
		break;

	case 3:		// ESP R	0011
		if ((ESpk_State & ESP_NORMAL) == ESP_NORMAL)
		{
			I2C_Val = A_FVol[I_V_NORESP];
		}
		else
		{
			I2C_Val = A_FVol[I_V_SOFTESP];
		}

		GPIO1->PD |= PO_SCL_SEL_1 + PO_SCL_SEL_0;
		break;

	case 4:		// CSP	0100
		if ((CISpk_State & CSP_NORMAL) == CSP_NORMAL)
		{
			I2C_Val = A_FVol[I_V_NORCSP];
		}
		else
		{
			I2C_Val = A_FVol[I_V_SOFTCSP];
		}
		GPIO1->PD |= PO_SCL_SEL_2;
		break;

	case 5:		// TL OUT	0101
		I2C_Val = A_FVol[I_V_TLOUT];
		GPIO1->PD |= PO_SCL_SEL_2 + PO_SCL_SEL_0;
		break;

	case 6:		// TL IN	0110	// 11k
		I2C_Val = 25;
		GPIO2->PD |= PO_SCL_SEL_3;
		break;

	case 7:		// OCC IN	0111
		I2C_Val = A_FVol[I_V_OCC];
		GPIO1->PD |= PO_SCL_SEL_2 + PO_SCL_SEL_1 + PO_SCL_SEL_0;
		break;

	case 8:		// DPO IN	1000
		I2C_Val = A_FVol[I_V_DPO];
		GPIO2->PD |= PO_SCL_SEL_3;
		break;

	case 9:		// PEI IN	1001
		I2C_Val = A_FVol[I_V_PEI];
		GPIO2->PD |= PO_SCL_SEL_3;
		GPIO1->PD |= PO_SCL_SEL_0;
		break;
	}

	if (I2C_Val > 31) I2C_Val = 31;

	I2C_STARTGenerate (I2C0, ENABLE);
	while(!I2C_CheckEvent(I2C0,I2C_EVENT_MASTER_MODE_SELECT));
	I2C_AddressSend (I2C0, 0x9A, I2C_Mode7, I2C_TX);
	while(!I2C_CheckEvent(I2C0, I2C_EVENT_MASTER_MODE_SELECTED));
	I2C_FlagClear( I2C0, I2C_ENDAD );
	I2C_ByteSend (I2C0, I2C_Val + 0xA0);
	while(!I2C_CheckEvent(I2C0, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
	I2C_STOPGenerate (I2C0, ENABLE);

	GPIO2->PD &= ~PO_SCL_SEL_3;
	GPIO1->PD &= ~(PO_SCL_SEL_2 + PO_SCL_SEL_1 + PO_SCL_SEL_0);
}

static	void	Set_MS_State(u8 state)
{
	//int		i, j;
	u8		temp8;

	switch (state)
	{
	case SET_MAIN:
		GPIO0->PD |= PO_MP3_UPDATE;

		CL_OK_Packet = false;
		CL_Rx_Turn = false;
		CL_Tx_Turn = true;

		CL_Tick = CL_TIME_MAIN;
		CL_TCnt = CL_Tick;

		T_State |= F_PAC_MAIN;

		/*
		for (i=0 ; i<5 ; i++)
			for (j=0 ; j<9 ; j++)
				AP_Train_ST[i][j] = 0;
		*/

		P_PAC_Token = 0;
		if (T_Me_AB == 1)
		{
			A_VDev_MS[AI_PACM] = VAPAC;
			A_VDev_MS[AI_PACS] = VBPAC;
			P_PAC_Token = P_PACA_TOKEN;
			AP_Train_ST[0][2] &= ~LIVE_APAC;
			P_PAC_Token |= P_PACA_TOKEN;
			AP_Train_ST[0][2] |= LIVE_BPAC;
		}
		else
		{
			A_VDev_MS[AI_PACM] = VBPAC;
			A_VDev_MS[AI_PACS] = VAPAC;
			P_PAC_Token = P_PACB_TOKEN;
			AP_Train_ST[0][2] &= ~LIVE_BPAC;
			P_PAC_Token |= P_PACB_TOKEN;
			AP_Train_ST[0][2] |= LIVE_APAC;
		}

		TL_State = ST_TL_WAIT;
		TL_Tick = TL_TIME_SUB;
		TL_TCnt = TL_Tick;
		TL_OK_Packet = false;
		TL_Rx_Turn = false;
		TL_Tx_Turn = false;

		A_Port_Out[0] = 0x8F;
		A_Port_Out[1] = 0xF0;
		A_Port_Out[2] = 0x00;
		temp8 = Port_RW_Data(2, 0);
		temp8 = Port_RW_Data(2, 1);
		temp8 = Port_RW_Data(2, 2);
		P_Broad_Device = 0;
	#if PAC_PROTOCOL_R10
		P_Broad_Occ = 0;
	#endif
		CISpk_State = ISP_NORMAL + CSP_NORMAL;
		CISpk_ST_Me = ISP_NORMAL + CSP_NORMAL;
		ESpk_State = ESP_NORMAL;
		ESpk_ST_Me = ESP_NORMAL;
		break;

	case SET_SUB:
		if ((T_State & F_CNCS_MODE) == F_CNCS_MODE)
		{
			GPIO0->PD &= ~PO_MP3_UPDATE;
		}
		else
		{
			GPIO0->PD |= PO_MP3_UPDATE;
		}

		CL_OK_Packet = false;
		CL_Rx_Turn = false;
		CL_Tx_Turn = false;

		T_State &= ~F_PAC_MAIN;

		/*
		for (i=0 ; i<5 ; i++)
			for (j=0 ; j<9 ; j++)
				AP_Train_ST[i][j] = 0;
		*/

		if (T_Me_AB == 1)
		{
			CL_Tick = CL_TIME_MSUB;
			P_PAC_Token &= ~P_PACA_TOKEN;
		}
		else
		{
			CL_Tick = CL_TIME_SSUB;
			P_PAC_Token &= ~P_PACB_TOKEN;
		}
		CL_TCnt = CL_Tick;

		TL_State = ST_TL_WAIT;
		TL_Tick = TL_TIME_SUB;
		TL_TCnt = TL_Tick;
		TL_OK_Packet = false;
		TL_Rx_Turn = false;
		TL_Tx_Turn = false;

		P_PAC_Token = 0;
		A_Port_Out[0] = 0x8F;
		A_Port_Out[1] = 0xF0;
		A_Port_Out[2] = 0x00;
		temp8 = Port_RW_Data(2, 0);
		temp8 = Port_RW_Data(2, 1);
		temp8 = Port_RW_Data(2, 2);
		temp8 = temp8;
		P_Broad_Device = 0;
	#if PAC_PROTOCOL_R10
		P_Broad_Occ = 0;
	#endif
		CISpk_State = ISP_NORMAL + CSP_NORMAL;
		CISpk_ST_Me = ISP_NORMAL + CSP_NORMAL;
		ESpk_State = ESP_NORMAL;
		ESpk_ST_Me = ESP_NORMAL;
		break;
	}
}

////////////////////////////////////////////////////////////////////////////////

static	void	Chk_LiveCall(u8 PIN_NUM, u8 *comm_status, u8 ERR_LOC, u8 chk_num, u8 *call_var, u8 CALL_VAL)
{
	// 죽어 있었어 계속 죽어 있었어
	// 살았어 살면 살아 있다는 플래그 올려
	if ((A_Port_ST[2] & PIN_NUM) != PIN_NUM)	// 살아
	{
		*comm_status &= ~ERR_LOC;

		if ((T_LiveFlag & PIN_NUM) != PIN_NUM)
		{
			T_LiveFlag |= PIN_NUM;
			A_DeadCnt[chk_num] = 0;
		}
		else
		{
			//if (A_DeadCnt[chk_num] > 6 && A_DeadCnt[chk_num] < 14)
			if (A_DeadCnt[chk_num] >= 6 && A_DeadCnt[chk_num] < 50)
			{
				if (chk_num < 4)
				{
					*call_var |= CALL_VAL;
				}
				else
				{
					if ((*call_var & CALL_VAL) == CALL_VAL)
					{
						*call_var &= ~CALL_VAL;
					}
					else
					{
						*call_var |= CALL_VAL;
					}
				}
				A_DeadCnt[chk_num] = 0;
			}
		}
	}
	else		// 죽어
	{
		if ((T_LiveFlag & PIN_NUM) == PIN_NUM)	// 살아 있다가 죽었음
		{
			*comm_status &= ~ERR_LOC;
			if (A_DeadCnt[chk_num] == 0) A_DeadCnt[chk_num] = 1;
			if (A_DeadCnt[chk_num] > 200)//이전 13
			{
				T_LiveFlag &= ~PIN_NUM;
				A_DeadCnt[chk_num] = 0;
				*comm_status |= ERR_LOC;
			}
		}
		else
		{
			*comm_status |= ERR_LOC;
		}
	}
}

	/*
	if ((PORT_State[PIN3_STATE] & PI_DPH1_LIVE) != PI_DPH1_LIVE) // 살아있다
	{
		T_Status_Comm[0][2] &= ~LIVE_ADPH;
		if ((live_flag & PI_DPH1_LIVE) != PI_DPH1_LIVE)
		{
			live_flag |= PI_DPH1_LIVE;
			dead_cnt[2] = 0;
		}
		else
		{
			if (dead_cnt[2] > 7 && dead_cnt[2] < 13)
			{
				Intercom_Call |= CALL_DPH1;
				dead_cnt[2] = 0;
			}
		}
	}
	else	// 죽어
	{
		if ((live_flag & PI_DPH1_LIVE) == PI_DPH1_LIVE)
		{
			dead_cnt[2]++;
			if (dead_cnt[2] > 13)
			{
				live_flag &= ~PI_DPH1_LIVE;
				dead_cnt[2] = 0;
				T_Status_Comm[0][2] |= LIVE_ADPH;
			}
		}
		else
		{
			T_Status_Comm[0][2] |= LIVE_ADPH;
		}
	}
	*/

////////////////////////////////////////////////////////////////////////////////

void	CL_RxTxISR(void)
{
	if ((UART1->SR & 0x0001) != 0x0000)
	{
		CL_RxHandler((u8)(UART1->RxBUFR & 0x00FF));
	}

	if (((UART1->SR & 0x0002) != 0x0000)&&((UART1->IER & 0x0002) != 0))
	{
		CL_TxHandler();
	}
}

////////////////////////////////////////////////////////////////////////////////

void	CL_RxHandler(u8 rx_data)
{
	u8  temp8;

	CL_TCnt = CL_Tick;

	if ( rx_data == 0x01 )
	{
		CL_Rx_State = CRX_ST_STX;
	}
	else if ( rx_data == 0x04 )
	{
		CL_Rx_State = CRX_ST_ETX;
	}
	else if (!((rx_data >= 0x30 && rx_data <= 0x39) || (rx_data >= 0x41 && rx_data <= 0x46)))
	{
		CL_Rx_State = CRX_ST_NONE;
	}

	switch (CL_Rx_State)
	{
	case CRX_ST_NONE:
		break;

	case CRX_ST_STX:
		//CL_Rx_ChkSum = 0;
		CL_Rx_Index = 0;
		CL_Rx_16Data = 0;
		CL_Rx_State = CRX_ST_SRC1;
		break;

	case CRX_ST_SRC1:
		CL_Rx_CRC16 = CRC_Check(0xFFFF, rx_data);
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_SRC2;
		break;

	case CRX_ST_SRC2:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);

//====================================================
//VoIP protocol확인 후 삭제.
		if((temp8 == 0x13)&&(gByAVoIPComm)){			
			gVAVOIPC = 1;
			gByAVoIPComm = 0;
		}
		
		if((temp8 == 0x14)&&(gByBVoIPComm)){
			gVBVOIPC = 1;
			gByBVoIPComm = 0;
		}
//====================================================

		CL_Rx_State = CRX_ST_DST1;
		CL_Receive(temp8, CRX_ST_SRC2);
		CL_Rx_Tmp_ID = temp8;
		break;

	case CRX_ST_DST1:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_DST2;
		break;

	case CRX_ST_DST2:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);
		CL_Rx_State = CRX_ST_MCNT1;
		CL_Receive(temp8, CRX_ST_DST2);
		break;

	case CRX_ST_MCNT1:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_MCNT2;
		break;

	case CRX_ST_MCNT2:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);
		CL_Rx_State = CRX_ST_CMD1;
		CL_Receive(temp8, CRX_ST_MCNT2);
		break;

	case CRX_ST_CMD1:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_CMD2;
		break;

	case CRX_ST_CMD2:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);
		CL_Rx_State = CRX_ST_1LEN1;
		CL_Receive(temp8, CRX_ST_CMD2);
		CL_Rx_Tmp_Cmd = temp8;
		break;

	case CRX_ST_1LEN1:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_1LEN2;
		break;

	case CRX_ST_1LEN2:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);
		CL_Rx_Len = temp8;

		// ??? ???
		if ((T_State & F_CNCS_MODE) == F_CNCS_MODE ||
			(CL_Rx_Tmp_ID == 0x21 && CL_Rx_Tmp_Cmd == 0x1B) ||
			(CL_Rx_Tmp_ID == 0x22 && CL_Rx_Tmp_Cmd == 0x1B) )
		{
			CL_Rx_State = CRX_ST_2LEN1;
			CL_Receive(CL_Rx_Len, CRX_ST_1LEN2);
		}
		else
		{
		#if PAC_PROTOCOL_R10
			CL_Rx_State = CRX_ST_2LEN1;
			CL_Receive(CL_Rx_Len, CRX_ST_1LEN2);
		#else
			CL_Rx_State = CRX_ST_DATA1;
			CL_Receive(CL_Rx_Len, CRX_ST_1LEN2);
			if ( CL_Rx_Len == 0 )
			{
				CL_Rx_State = CRX_ST_CHKSUM1;
			}
		#endif
		}
		break;

	case CRX_ST_2LEN1:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_2LEN2;
		break;

	case CRX_ST_2LEN2:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);
		if ( CL_Rx_Len > 1536 )
		{
			CL_Rx_State = CRX_ST_NONE;
		}
		else
		{
			CL_Rx_State = CRX_ST_DATA1;
			CL_Receive(temp8, CRX_ST_2LEN2);
			if ( CL_Rx_Len == 0 )
			{
				CL_Rx_State = CRX_ST_CHKSUM1;
			}
		}
		break;

	case CRX_ST_DATA1:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_DATA2;
		break;

	case CRX_ST_DATA2:
		CL_Rx_CRC16 = CRC_Check(CL_Rx_CRC16, rx_data);
		if ( CL_Rx_Index < 1536 )
		{
			CL_Rx_16Data |= rx_data;
			temp8 = Asc16ToByte(CL_Rx_16Data);
			CL_Receive(temp8, CRX_ST_DATA2);
		}

		if (--CL_Rx_Len == 0)
		{
			CL_Rx_State = CRX_ST_CHKSUM1;
		}
		else
		{
			CL_Rx_State = CRX_ST_DATA1;
		}
		break;

	case CRX_ST_CHKSUM1:
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_CHKSUM2;
		break;

	case CRX_ST_CHKSUM2:
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);
		CL_Rx_CRCTemp = temp8;
		CL_Rx_CRCTemp <<= 8;
		CL_Rx_State = CRX_ST_CHKSUM3;
		break;

	case CRX_ST_CHKSUM3:
		CL_Rx_16Data = rx_data;
		CL_Rx_16Data <<= 8;
		CL_Rx_State = CRX_ST_CHKSUM4;
		break;

	case CRX_ST_CHKSUM4:
		CL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(CL_Rx_16Data);
		CL_Rx_CRCTemp |= temp8;
		CL_Rx_State = CRX_ST_ETX;
		if (CL_Rx_CRC16 == CL_Rx_CRCTemp)
		{
			CL_Receive(temp8, CRX_ST_CHKSUM4);
		}
		break;

	case CRX_ST_ETX:
		CL_Rx_State = CRX_ST_NONE;
		break;

	default:
		CL_Rx_State = CRX_ST_NONE;
		break;
	}

}

void	CL_Receive(u8 rx_data, u8 state)
{
	switch (state)
	{
	case CRX_ST_SRC2:
		CL_Rx_SrcID = A_VID[rx_data];
		break;
	case CRX_ST_DST2:
		CL_Rx_DstID = A_VID[rx_data];

		if ((T_State & F_PAC_MAIN) == F_PAC_MAIN)
		{
			if (CL_Rx_SrcID == VAPAC && CL_Rx_DstID != VBPAC)
			{
				T_State &= ~F_PAC_MAIN;
				Set_MS_State(SET_SUB);
			}
		}
		break;
	case CRX_ST_MCNT2:
		CL_Rx_MCnt = rx_data;
		break;
	case CRX_ST_CMD2:
		CL_Rx_Cmd = rx_data;
		// ???
		/*
		if ((A_Port_In[0] & PI_PAC_AB) == PI_PAC_AB && CL_Rx_SrcID == VAPAC && CL_Rx_Cmd == 0x10)
		{
			T_State &= ~F_CNCS_MODE;
		}
		*/
		break;
	case CRX_ST_1LEN2:
		CL_Rx_Len = rx_data;
		CL_Rx_Index = 0;
		break;
	case CRX_ST_2LEN2:
		CL_Rx_Len <<= 8;
		CL_Rx_Len |= rx_data;
		//CL_Rx_Len = rx_data;
		CL_Rx_Index = 0;
		break;
	case CRX_ST_DATA2:
		CL_Rx_Data[CL_Rx_Index++] = rx_data;
		break;
	case CRX_ST_CHKSUM4:
		CL_Rx_Data[CL_Rx_Index] = 0x00;
		//CL_Rx_ChkSum = rx_data;
		CL_OK_Packet = true;
		break;
	}
}

////////////////////////////////////////////////////////////////////////////////

void	CL_TxHandler(void)
{
	u16	 	i;

	switch (CL_Tx_State)
	{
	case CTX_ST_NONE:
		for (i=0 ; i<0x7F ; i++);
		GPIO0->PD &= ~PO_CL_TX;
		UART1->IER &= (~0x0002);
		UART_RxConfig(UART1, ENABLE);
		TIM_ITConfig(TIM1, TIM_TO_IT, ENABLE);
		break;

	case CTX_ST_STX:
		UART1->TxBUFR = 0x01;
		CL_Tx_Index = 0;
		CL_Tx_State = CTX_ST_DATA;
		break;

	case CTX_ST_DATA:
		UART1->TxBUFR = CL_Tx_Packet[CL_Tx_Index++];
		if ( CL_Tx_Index == CL_Tx_Len )
		{
			CL_Tx_State = CTX_ST_ETX;
		}
		else
		{
			CL_Tx_State = CTX_ST_DATA;
		}
		break;

	case CTX_ST_ETX:
		UART1->TxBUFR = 0x04;
		//UART0->TxBUFR = 0x04;
		CL_Tx_State  = CTX_ST_NONE;
		break;

	default:
		CL_Tx_State = CTX_ST_NONE;
		break;
	}
}

////////////////////////////////////////////////////////////////////////////////

void CL_Send(u8 SrcID, u8 DstID, u8 MCnt, u8 Cmd, u16 arrLen)
{
	u16		i;
	u16		cnt = 0, temp8;

	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, SrcID);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, SrcID);
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, DstID);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, DstID);
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, MCnt);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, MCnt);
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, Cmd);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, Cmd);
#if PAC_PROTOCOL_R10
	temp8 = (u8)((arrLen & 0xFF00)>>8);
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, temp8);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, temp8);
	temp8 = (u8)(arrLen & 0x00FF);
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, temp8);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, temp8);
#else
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, arrLen);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, arrLen);
#endif
	for (i=0 ; i<arrLen ; i++)
	{
		CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, CL_Tx_Data[i]);
		CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, CL_Tx_Data[i]);
	}

	CL_Tx_CRC16 = CRC_Check(0xFFFF, CL_Tx_Packet[0]);
	for (i=1 ; i<cnt ; i++)
	{
		CL_Tx_CRC16 = CRC_Check(CL_Tx_CRC16, CL_Tx_Packet[i]);
	}
	temp8 = CL_Tx_CRC16 >> 8;
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, temp8);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, temp8);
	temp8 = CL_Tx_CRC16 & 0xFF;
	CL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, temp8);
	CL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, temp8);

#if PAC_PROTOCOL_R10
	CL_Tx_Len =  (arrLen * 2) + 16;
#else
	CL_Tx_Len =  (arrLen * 2) + 14;
#endif

	CL_Tx_State = CTX_ST_STX;
	TIM_ITConfig(TIM1, TIM_TO_IT, DISABLE);

	if ((T_State & F_CNCS_MODE) == F_CNCS_MODE)
	{
		for (i=0 ; i<0x7FF ; i++);
	}
	UART_RxConfig(UART1, DISABLE);
	GPIO0->PD |= PO_CL_TX;
	for (i=0 ; i<0xFF ; i++);
	UART1->IER |= 0x0002;
}

////////////////////////////////////////////////////////////////////////////////

void	TL_RxTxISR(void)
{
	if ((UART2->SR & 0x0001) != 0x0000)
	{
		TL_RxHandler((u8)(UART2->RxBUFR & 0x00FF));
	}

	if (((UART2->SR & 0x0002) != 0x0000)&&((UART2->IER & 0x0002) != 0))
	{
		TL_TxHandler();
	}
}

////////////////////////////////////////////////////////////////////////////////

void	TL_RxHandler(u8 rx_data)
{
	u8  temp8;

	//UART_ByteSend(UART0, &rx_data);		// test test

	if ( rx_data == 0x01 )
	{
		TL_Rx_State = TRX_ST_STX;
	}
	else if ( rx_data == 0x04 )
	{
		TL_Rx_State = TRX_ST_NONE;
	}
	else if (!((rx_data >= 0x30 && rx_data <= 0x39) || (rx_data >= 0x41 && rx_data <= 0x46)))
	{
		TL_Rx_State = TRX_ST_NONE;
	}

	switch (TL_Rx_State)
	{
	case TRX_ST_NONE:
		break;

	case TRX_ST_STX:
		//TL_Rx_ChkSum = 0;
		TL_Rx_Index = 0;
		TL_Rx_16Data = 0;
		TL_Rx_State = TRX_ST_SRC1;
		break;

	case TRX_ST_SRC1:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(0xFFFF, rx_data);
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_SRC2;
		break;

	case TRX_ST_SRC2:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(TL_Rx_16Data);
		TL_Rx_State = TRX_ST_DST1;
		TL_Receive(temp8, TRX_ST_SRC2);
		break;

	case TRX_ST_DST1:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_DST2;
		break;

	case TRX_ST_DST2:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(TL_Rx_16Data);
		TL_Rx_State = TRX_ST_MCNT1;
		TL_Receive(temp8, TRX_ST_DST2);
		break;

	case TRX_ST_MCNT1:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_MCNT2;
		break;

	case TRX_ST_MCNT2:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(TL_Rx_16Data);
		TL_Rx_State = TRX_ST_CMD1;
		TL_Receive(temp8, TRX_ST_MCNT2);
		break;

	case TRX_ST_CMD1:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_CMD2;
		break;

	case TRX_ST_CMD2:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(TL_Rx_16Data);
		TL_Rx_State = TRX_ST_LEN1;
		TL_Receive(temp8, TRX_ST_CMD2);
		break;

	case TRX_ST_LEN1:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_LEN2;
		break;

	case TRX_ST_LEN2:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(TL_Rx_16Data);
		TL_Rx_Len = temp8;
		if ( TL_Rx_Len > 256 )
		{
			TL_Rx_State = TRX_ST_NONE;
		}
		else
		{
			if ( TL_Rx_Len > 0 )
			{
				TL_Rx_Index = 0;
				TL_Rx_State = TRX_ST_DATA1;
				TL_Receive(TL_Rx_Len, TRX_ST_LEN2);
			}
			else
			{
				TL_Rx_State = TRX_ST_CHKSUM1;
			}
		}
		break;

	case TRX_ST_DATA1:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_DATA2;
		break;

	case TRX_ST_DATA2:
		//TL_Rx_ChkSum ^= rx_data;
		TL_Rx_CRC16 = CRC_Check(TL_Rx_CRC16, rx_data);
		if ( TL_Rx_Index < 256 )
		{
			TL_Rx_16Data |= rx_data;
			temp8 = Asc16ToByte(TL_Rx_16Data);
			TL_Receive(temp8, TRX_ST_DATA2);
		}

		if (--TL_Rx_Len == 0)
		{
			TL_Rx_State = TRX_ST_CHKSUM1;
		}
		else
		{
			TL_Rx_State = TRX_ST_DATA1;
		}
		break;

	case TRX_ST_CHKSUM1:
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_CHKSUM2;
		break;

	case TRX_ST_CHKSUM2:
		TL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(TL_Rx_16Data);
		TL_Rx_CRCTemp = temp8;
		TL_Rx_CRCTemp <<= 8;
		TL_Rx_State = TRX_ST_CHKSUM3;
		break;

	case TRX_ST_CHKSUM3:
		TL_Rx_16Data = rx_data;
		TL_Rx_16Data <<= 8;
		TL_Rx_State = TRX_ST_CHKSUM4;
		break;

	case TRX_ST_CHKSUM4:
		TL_Rx_16Data |= rx_data;
		temp8 = Asc16ToByte(TL_Rx_16Data);
		TL_Rx_CRCTemp |= temp8;
		TL_Rx_State = TRX_ST_ETX;
		if (TL_Rx_CRC16 == TL_Rx_CRCTemp)
		{
			TL_Receive(temp8, TRX_ST_CHKSUM4);
		}
		break;

	case TRX_ST_ETX:
		TL_Rx_State = TRX_ST_NONE;
		break;

	default:
		TL_Rx_State = TRX_ST_NONE;
		break;
	}

}

void	TL_Receive(u8 rx_data, u8 state)
{
	if (TL_State == ST_TL_WAIT)
	{
		TL_TCnt = TL_Tick;
	}

	switch (state)
	{
	case TRX_ST_SRC2:
		TL_Rx_SrcID = rx_data;
		break;
	case TRX_ST_DST2:
		TL_Rx_DstID = rx_data;
		break;
	case TRX_ST_MCNT2:
		TL_Rx_MCnt = rx_data;
		break;
	case TRX_ST_CMD2:
		TL_Rx_Cmd = rx_data;
		break;
	case TRX_ST_LEN2:
		TL_Rx_Len = rx_data;
		TL_Rx_Index = 0;
		break;
	case TRX_ST_DATA2:
		TL_Rx_Data[TL_Rx_Index++] = rx_data;
		break;
	case TRX_ST_CHKSUM4:
		TL_Rx_Data[TL_Rx_Index] = 0x00;
		//TL_Rx_ChkSum = rx_data;
		TL_OK_Packet = true;
		break;
	}
}

////////////////////////////////////////////////////////////////////////////////

void	TL_TxHandler(void)
{
	u16	 i;

	switch (TL_Tx_State)
	{
	case TTX_ST_NONE:
		for (i=0 ; i<0x7F ; i++);
		GPIO0->PD &= ~PO_TL_TX;
		UART2->IER &= (~0x0002);
		UART_RxConfig(UART2, ENABLE);
		TIM_ITConfig(TIM2, TIM_TO_IT, ENABLE);
		TL_Mode_Send = false;
		break;

	case TTX_ST_DUMMY1:
		UART2->TxBUFR = 0x34;
		TL_Tx_State = TTX_ST_DUMMY2;
		break;

	case TTX_ST_DUMMY2:
		UART2->TxBUFR = 0x01;
		TL_Tx_State = TTX_ST_DUMMY3;
		break;

	case TTX_ST_DUMMY3:
		UART2->TxBUFR = 0x34;
		TL_Tx_State = TTX_ST_DUMMY4;
		break;

	case TTX_ST_DUMMY4:
		UART2->TxBUFR = 0x34;
		TL_Tx_State = TTX_ST_DUMMY5;
		break;

	case TTX_ST_DUMMY5:
		UART2->TxBUFR = 0x01;
		TL_Tx_State = TTX_ST_STX;
		break;

	case TTX_ST_STX:
		UART2->TxBUFR = 0x01;
		TL_Tx_State = TTX_ST_DATA;
		TL_Tx_Index = 0;
		break;

	case TTX_ST_DATA:
		UART2->TxBUFR = TL_Tx_Packet[TL_Tx_Index++];
		if ( TL_Tx_Index == TL_Tx_Len )
		{
			TL_Tx_State = TTX_ST_ETX;
		}
		else
		{
			TL_Tx_State = TTX_ST_DATA;
		}
		break;

	case TTX_ST_ETX:
		UART2->TxBUFR = 0x04;
		TL_Tx_State  = TTX_ST_EDUMMY;
		break;

	case TTX_ST_EDUMMY:
		UART2->TxBUFR = 0x0D;
		TL_Tx_State = TTX_ST_NONE;
		break;

	default:
		TL_Tx_State = TTX_ST_NONE;
		break;
	}
}

////////////////////////////////////////////////////////////////////////////////

void TL_Send(u8 SrcID, u8 DstID, u8 MCnt, u8 Cmd, u16 arrLen)
{
	u16		i;
	u8		cnt = 0, temp8;

	if (++TL_Tx_MCnt == 100) TL_Tx_MCnt = 0;

	TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, SrcID);
	TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, SrcID);
	TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, DstID);
	TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, DstID);
	TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, MCnt);
	TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, MCnt);
	TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, Cmd);
	TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, Cmd);
	TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, arrLen);
	TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, arrLen);

	for (i=0 ; i<arrLen ; i++)
	{
		TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, TL_Tx_Data[i]);
		TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, TL_Tx_Data[i]);
	}

	TL_Tx_CRC16 = CRC_Check(0xFFFF, TL_Tx_Packet[0]);
	for (i=1 ; i<cnt ; i++)
	{
		TL_Tx_CRC16 = CRC_Check(TL_Tx_CRC16, TL_Tx_Packet[i]);
	}
	temp8 = TL_Tx_CRC16 >> 8;
	TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, temp8);
	TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, temp8);
	temp8 = TL_Tx_CRC16 & 0xFF;
	TL_Tx_Packet[cnt++] = ByteToAsc(HBYTE, temp8);
	TL_Tx_Packet[cnt++] = ByteToAsc(LBYTE, temp8);

	TL_Tx_Len =  (arrLen * 2) + 14;

	TL_State_Send = 0;
	TL_Mode_Send = true;

	/*
	for(i=0 ; i<0xFFF ; i++);

	TL_Tx_State = TTX_ST_DUMMY1;
	TIM_ITConfig(TIM2, TIM_TO_IT, DISABLE);
	UART_RxConfig(UART2, DISABLE);
	GPIO0->PD |= PO_TL_TX;
	for (i=0 ; i<0x1FF ; i++);
	UART2->IER |= 0x0002;
	*/
}

////////////////////////////////////////////////////////////////////////////////

static	void	HexIncDec(u8 *high, u8 *low, u8 gbn)	// 0:dec, 1:inc
{
	u8		temp8, temp10;

	temp10 = (*low >> 4) * 10;
	temp10 += (*low & 0x0F);
	if (gbn == 1)
	{
		temp10++;
		temp8 = (temp10 / 10) * 16;
		temp8 += temp10 % 10;
		if (temp8 == 0xA0)
		{
			(*high)++;
			temp8 = 0;
		}
	}
	else
	{
		if (temp10 == 0)
		{
			(*high)--;
			temp10 = 0x64;
		}
		temp10--;
		temp8 = (temp10 / 10) * 16;
		temp8 += temp10 % 10;
	}
	*low = temp8;
}

u16	CRC_Check(u16 seed, u8 val)
{
	u16		crc;
	crc = (seed << 8) ^ CRC_Table[((seed >> 8) ^ val) & 0x00FF];
	return crc;
}

u8	ByteToAsc(u8 sel, u8 c)
{
	u8	temp;

	switch (sel)
	{
	case HBYTE:
		temp = c & 0xF0;
		temp >>= 4;
		break;

	case LBYTE:
		temp = c & 0x0F;
		break;
	}

	if ( temp > 9 )
	{
		temp += 55;
	}
	else
	{
		temp += 48;
	}
	return temp;
}

u8	Asc16ToByte(u16 c)
{
	u8	temp, temp2;
	temp = (u8)((c & 0xFF00) >> 8);
	if (temp > 64)
	{
		temp -= 55;
	}
	else
	{
		temp -= 48;
	}
	temp = (u8)(temp << 4);
	temp2 = (u8)(c & 0x00FF);
	if (temp2 > 64)
	{
		temp2 -= 55;
	}
	else
	{
		temp2 -= 48;
	}
	temp |= temp2;
	return temp;
}

//GPIO_BitWrite(GPIO2, 0x0F, ~GPIO_BitRead(GPIO2, 0x0F));

////////////////////////////////////////////////////////////////////////////////

void	Set_Var(void)
{
	int		i, j;

	u8		temp8;
	u16		temp16;
	temp8 = 0;
	temp16 = 0;
	temp8 = temp8;
	temp16 = temp16;

	//u8		temps8;
	//u8		tempd8;

	////////////////////////////////

	for (i=0 ; i<5 ; i++)
	{
		A_Port_ST[i] = 0;
		A_Port_Chatt[i] = 0;
		A_Port_In[i] = 0;
	}
	for (i=0 ; i<5 ; i++)
		for (j=0 ; j<8 ; j++)
			A_Port_Flag[i][j] = 0;

	A_Port_Out[0] = 0x8F;
	A_Port_Out[1] = 0xF0;
	A_Port_Out[2] = 0x00;

	T_LiveFlag = 0;
	for (i=0 ; i<8 ; i++)
	{
		A_DeadCnt[i] = 0;
	}

	for (i=0 ; i<AS_FSYS ; i++) A_FSys[i] = 0;
	for (i=0 ; i<AS_FVOL ; i++) A_FVol[i] = 0;
	//for (i=0 ; i<4 ; i++) A_ChkS_FSys[i] = 0;
	for (i=0 ; i<4 ; i++) A_ChkS_FVol[i] = 0;
	//AI_ChkS_FSys = 0;
	AI_ChkS_FVol = 0;

	////////////////////////////////

	T_State = 0;

	T_Me_AB = 1;	// 1:cra 2:crb
	T_Me_ID = 0;
	for (i=0 ; i<4 ; i++)
	{
		A_CarNum[i][0] = 0;
		A_CarNum[i][1] = 0;
	}
	for (i=0 ; i<5 ; i++)
	{
		A_TL_CarNum[i][0] = 0;
		A_TL_CarNum[i][1] = 0;
	}
	AI_CarNum = 0;
	T_Train_Len = 1;
	TL_Coupling_ID = 0;

	////////////////////////////////

	CL_Tick = CL_TIME_MAIN;
	TL_Tick = TL_TIME_SUB;

	CL_TCnt = CL_Tick;
	TL_TCnt = TL_Tick;

	CL_Tx_ID = 0;
	CL_Rx_ID = 0xFF;

	for (i=0 ; i<37 ; i++) A_ErrDevs[i] = 0;
	for (i=0 ; i<5 ; i++) A_ErrCars[i] = 0;
	T_Cars_Err = 0;

	////////////////////////////////

	CL_State = 0;
	TL_State = 0;

	for (i=0 ; i<10 ; i++) A_VDev_MS[i] = 0;
	A_VDev_MS[AI_PACM] = VAPAC;
	A_VDev_MS[AI_CCPM] = VACCP;
	A_VDev_MS[AI_CNCSM] = VACNCS;
	A_VDev_MS[AI_LICM] = VALIC;
	A_VDev_MS[AI_VOIPCM] = VAVOIPC;
	A_VDev_MS[AI_PACS] = VBPAC;
	A_VDev_MS[AI_CCPS] = VBCCP;
	A_VDev_MS[AI_CNCSS] = VBCNCS;
	A_VDev_MS[AI_LICS] = VBLIC;
	A_VDev_MS[AI_VOIPCS] = VBVOIPC;

	A_RID[VAPAC] = 0x21;
	A_RID[VACCP] = 0x11;
	A_RID[VAVOIPC] = 0x13;
	A_RID[VALIC] = 0x22;
	A_RID[VAVTX] = 0x23;
	A_RID[VACNCS] = 0x24;

	A_RID[VAFDI] = 0x31;
	A_RID[VASDI1] = 0x41;
	A_RID[VASDI2] = 0x42;
	A_RID[VASDI3] = 0x43;
	A_RID[VASDI4] = 0x44;
	A_RID[VAPII1] = 0x51;
	A_RID[VAPII2] = 0x52;
	A_RID[VAPID11] = 0x61;
	A_RID[VAPID12] = 0x62;
	A_RID[VAPID13] = 0x63;
	A_RID[VAPID14] = 0x64;
	A_RID[VAPID21] = 0x71;

	A_RID[VBPAC] = 0x25;
	A_RID[VBCCP] = 0x12;
	A_RID[VBVOIPC] = 0x14;
	A_RID[VBLIC] = 0x26;
	A_RID[VBVTX] = 0x27;
	A_RID[VBCNCS] = 0x28;

	A_RID[VBFDI] = 0x32;
	A_RID[VBSDI1] = 0x45;
	A_RID[VBSDI2] = 0x46;
	A_RID[VBSDI3] = 0x47;
	A_RID[VBSDI4] = 0x48;
	A_RID[VBPII1] = 0x53;
	A_RID[VBPII2] = 0x54;
	A_RID[VBPID11] = 0x65;
	A_RID[VBPID12] = 0x66;
	A_RID[VBPID13] = 0x67;
	A_RID[VBPID14] = 0x68;
	A_RID[VBPID21] = 0x78;
	A_RID[37] = 0;

	for (i=0 ; i<0xFF ; i++) A_VID[i] = 0;

	A_VID[0x21] = VAPAC;
	A_VID[0x11] = VACCP;
	A_VID[0x13] = VAVOIPC;
	A_VID[0x22] = VALIC;
	A_VID[0x23] = VAVTX;
	A_VID[0x24] = VACNCS;

	A_VID[0x31] = VAFDI;
	A_VID[0x41] = VASDI1;
	A_VID[0x42] = VASDI2;
	A_VID[0x43] = VASDI3;
	A_VID[0x44] = VASDI4;
	A_VID[0x51] = VAPII1;
	A_VID[0x52] = VAPII2;
	A_VID[0x61] = VAPID11;
	A_VID[0x62] = VAPID12;
	A_VID[0x63] = VAPID13;
	A_VID[0x64] = VAPID14;
	A_VID[0x71] = VAPID21;

	A_VID[0x25] = VBPAC;
	A_VID[0x12] = VBCCP;
	A_VID[0x14] = VBVOIPC;
	A_VID[0x26] = VBLIC;
	A_VID[0x27] = VBVTX;
	A_VID[0x28] = VBCNCS;

	A_VID[0x32] = VBFDI;
	A_VID[0x45] = VBSDI1;
	A_VID[0x46] = VBSDI2;
	A_VID[0x47] = VBSDI3;
	A_VID[0x48] = VBSDI4;
	A_VID[0x53] = VBPII1;
	A_VID[0x54] = VBPII2;
	A_VID[0x65] = VBPID11;
	A_VID[0x66] = VBPID12;
	A_VID[0x67] = VBPID13;
	A_VID[0x68] = VBPID14;
	A_VID[0x78] = VBPID21;

	CL_Rx_Turn = false;
	CL_Tx_Turn = false;

	for (i=0 ; i<37 ; i++) A_CLMsg_Num[i] = 0;

	CL_PollM_IDX = 0;
	CL_Poll1_IDX = 0;
	CL_Poll2_IDX = 0;
	CL_Poll3_IDX = 0;

	CL_PollM_Arr[0] = VAPAC;
	CL_PollM_Arr[1] = VBPAC;
	CL_PollM_Arr[2] = VACCP;
	CL_PollM_Arr[3] = VACNCS;
	CL_PollM_Arr[4] = VALIC;
	CL_PollM_Arr[5] = VAVOIPC;
	CL_PollM_Arr[6] = 0;
	CL_PollM_Arr[7] = 0;
	CL_PollM_Arr[8] = 0;

	CL_Poll1_Arr[0] = VBCCP;
	CL_Poll1_Arr[1] = VBCNCS;
	CL_Poll1_Arr[2] = VBLIC;
	CL_Poll1_Arr[3] = VBVOIPC;
	CL_Poll1_Arr[4] = VAVTX;
	CL_Poll1_Arr[5] = VBVTX;
	CL_Poll1_Arr[6] = VAFDI;
	CL_Poll1_Arr[7] = VBFDI;
	CL_Poll1_Arr[8] = VAPID21;
	CL_Poll1_Arr[9] = VBPID21;

	CL_Poll2_Arr[0] = VASDI1;
	CL_Poll2_Arr[1] = VASDI2;
	CL_Poll2_Arr[2] = VASDI3;
	CL_Poll2_Arr[3] = VASDI4;
	CL_Poll2_Arr[4] = VAPII1;
	CL_Poll2_Arr[5] = VAPII2;
	CL_Poll2_Arr[6] = VAPID11;
	CL_Poll2_Arr[7] = VAPID12;
	CL_Poll2_Arr[8] = VAPID13;
	CL_Poll2_Arr[9] = VAPID14;

	CL_Poll3_Arr[0] = VBSDI1;
	CL_Poll3_Arr[1] = VBSDI2;
	CL_Poll3_Arr[2] = VBSDI3;
	CL_Poll3_Arr[3] = VBSDI4;
	CL_Poll3_Arr[4] = VBPII1;
	CL_Poll3_Arr[5] = VBPII2;
	CL_Poll3_Arr[6] = VBPID11;
	CL_Poll3_Arr[7] = VBPID12;
	CL_Poll3_Arr[8] = VBPID13;
	CL_Poll3_Arr[9] = VBPID14;

	////////////////////////////////

	T_Ans_11k = 0;

	for (i=0 ; i<25 ; i++) A_Ans_Val[i] = 0;
	AI_Ans = 0;
	T_Ans_Avr = 0;

	T_Ans_Cnt = ANS_TICK_CNT;

	//TE_State = 0;
	//TB_State = 0;
	TP_Broad_Device = 0;
	T_Broad = 0;
	TC_Broad[0] = 0;
	TC_Broad[1] = 0;
	TC_Broad[2] = 0;

	T_DPO_Call = 0;

	T_PEI_Cnt = 0;
	for (i=0 ; i<6 ; i++) T_PEI_Name[i] = 0;
	for (i=0 ; i<5 ; i++) T_PEI_Play[i] = 0;

	T_PEI_Num = 0;
	
	T_IC_Cnt = 0;
	T_IC_Name[0] = 0x39;
	T_IC_Name[1] = 0x30;
	T_IC_Name[2] = 0x30;
	T_IC_Name[3] = 0x30;
	T_IC_Name[4] = 0x30;
	T_IC_Name[5] = 0x30;
	
	ESpk_State = ESP_NORMAL;
	ESpk_ST_Me = ESP_NORMAL;
	CISpk_State = ISP_NORMAL + CSP_NORMAL;
	CISpk_ST_Me = ISP_NORMAL + CSP_NORMAL;

	////////////////////////////////

	P_PAC_Token = 0;

	P_Coupling_ID = 0;
	P_Coupling_Old = 0;
	P_IOport = 0;
	P_Broad_Device = 0;
#if PAC_PROTOCOL_R10
	P_Broad_Occ = 0;
#endif
	for (i=0 ; i<4 ; i++)
	{
		AP_POdo[i] = 0;
		AP_COdo[i] = 0;
	}
	P_Ans_Vol = 0;
	for (i=0 ; i<3 ; i++)
	{
		AP_TrainNum[i] = 0;
		AP_CrewID[i] = 0;
		AP_TrigID[i] = 0;
	}
	P_St_Type = 0;
	//P_Spk_ST = 0;
	//P_Spk_Old = 0;
	P_Disp_Msg = 0;
	P_LED_MR = 0;
	P_PR_Active = 0;
	for (i=0 ; i<2 ; i++)
	{
		AP_St_Start[i] = 0;
		AP_St_Now[i] = 0;
		AP_St_Next[i] = 0;
		AP_St_Dest[i] = 0;
		AP_PR_Msg[i] = 0;
		AP_PAC_Vec[i] = 0;
		AP_FSDI_Vec[i] = 0;
		AP_DD_Vec1[i] = 0;
		AP_DD_Vec2[i] = 0;
		AP_PII_Vec[i] = 0;
		AP_PPL_Vec[i] = 0;
		AP_PPD_Vec[i] = 0;
		AP_SP_Vec[i] = 0;
	}
	for (i=0 ; i<10 ; i++) AP_St_Skip[i] = 0;
	for (i=0 ; i<8 ; i++)
	{
		AP_CID_Rx[i] = 0;
		AP_CID_Tx[i] = 0;
		AP_CID_LIC_Rx[i] = 0;
		R_CI_Fault[i] = 0;
	}
	AP_CID_ALIC_Tx = 0;
	AP_CID_BLIC_Tx = 0;
	AP_CI_AFLT = 0;
	AP_CI_BFLT = 0;
	AP_CI_FLT = 0;
	AP_CI_RFLT = 0;
	T_CI_Fault = 0;
	P_CCI = 1;

	for (i=0 ; i<5 ; i++)
		for (j=0 ; j<9 ; j++)
			AP_Train_ST[i][j] = 0;

	//P_VOIPC_0 = 0;
	P_LIC_0 = 0;
	P_CNCS_PA = 0;

	////////////////////////////////

	//Stt_State = STT_LOGO;

	TL_Train_Len = 0;
	TL_Coupling_ID = 0;

	TL_Car_Temp[0] = 0;
	TL_Car_Temp[1] = 0;
	temps8 = 0;
	tempd8 = 0;

	TLC_State_ID = 0;
	TLC_Status = 0;

	HOC_State = 0;

	Pass_State = 0;

	Coupling_CMD = 0xC0;

	TL_CAB_ID = 0;
	TL_Poll_ID = 1;
	TL_Chk_ID = 0;

	TL_Rx_Turn = false;
	TL_Tx_Turn = false;

	////////////////////////////////

	for (i=0 ; i<256 ; i++)
	{
		temp16 = (i << 8);
		for (j=0 ; j<8 ; j++)
		{
			if (temp16 & 0x8000)
			{
				temp16 = (temp16 << 1) ^ 0x1021;
			}
			else
			{
				temp16 = temp16 << 1;
			}
			CRC_Table[i] = temp16;
		}
	}

	CL_Rx_SrcID = 0;
	CL_Rx_DstID = 0;
	CL_Rx_MCnt = 0;
	CL_Rx_Cmd = 0;
	CL_Rx_Len = 0;
	for (i=0 ; i<512 ; i++) CL_Rx_Data[i] = 0;
	//CL_Rx_ChkSum = 0;
	CL_Rx_CRC16 = 0;
	CL_Rx_CRCTemp = 0;

	CL_Rx_Tmp_ID = 0;
	CL_Rx_Tmp_Cmd = 0;

	CL_Rx_State = 0;
	CL_Rx_16Data = 0;
	CL_Rx_Index = 0;
	CL_OK_Packet = false;

	CL_Tx_Len = 0;
#if PAC_PROTOCOL_R10
	for (i=0 ; i<256 ; i++) CL_Tx_Data[i] = 0;
#else	
	for (i=0 ; i<256 ; i++) CL_Tx_Data[i] = 0;
#endif
	for (i=0 ; i<512 ; i++) CL_Tx_Packet[i] = 0;
	CL_Tx_CRC16 = 0;
	CL_Tx_State = 0;
	CL_Tx_Index = 0;

	TL_Rx_SrcID = 0;
	TL_Rx_DstID = 0;
	TL_Rx_MCnt = 0;
	TL_Rx_Cmd = 0;
	TL_Rx_Len = 0;
	for (i=0 ; i<256 ; i++) TL_Rx_Data[i] = 0;
	TL_Rx_CRC16 = 0;
	TL_Rx_CRCTemp = 0;

	TL_Rx_State = 0;
	TL_Rx_16Data = 0;
	TL_Rx_Index = 0;
	TL_OK_Packet = false;

	TL_Tx_SrcID = 0;
	TL_Tx_DstID = 0;
	TL_Tx_MCnt = 0;
	TL_Tx_Cmd = 0;
	TL_Tx_Len = 0;
	for (i=0 ; i<128 ; i++) TL_Tx_Data[i] = 0;
	for (i=0 ; i<256 ; i++) TL_Tx_Packet[i] = 0;

	TL_Tx_State = 0;
	TL_Tx_Index = 0;

	TL_Mode_Send = false;
	TL_State_Send = 0;
}
