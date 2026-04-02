NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0026   045C =   1116. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0013  __start
       0013  __text_start
       0032  _exit
       0033  _port_init
       0040  _timer1_init
       0048  _timer1_ovf_isr
       0056  _uart0_init
       0061  _uart0_rx_isr
       0062  _adc_init
       006A  _adc_isr
       007E  _ADC_CONVER
       010A  _LEVEL_CONVERT
       0182  _init_devices
       019B  _RS232_Send_Byte
       01A0  _RS232_Send_Bytes
       01B1  _main
       0225  pop_gset2
       0227  push_gset1
       022A  pop_gset1
       022B  pop
       023E  push_gset2
       0241  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   0060   0013 =     19. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  _ADC_COUNT
       0060  __bss_start
       0061  _NO_COUNT
       0062  _TEMP_LOW
       0063  _TEMP_HIGH
       0064  _TEMPER_DATA
       0065  _GAS_DATA
       0066  _CDS_DATA
       0067  _T_COUNT
       0068  _ADC_DATAS
       006A  _ADC_DATA
       0071  _flagg
       0072  _flag
       0073  __bss_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   001E =     30. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtAVR.o	[ crtavr.s ]
PL3150_GAS.o	[ PL3150_GAS.c ]
<library>	[ gpop2.s, gpush.s, gpush2.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x26
data = 0x60
eeprom:1.512

