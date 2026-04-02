NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   008C   0235 =    565. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       008C  __lit_start
       008C  _ID_VALUE1
       0091  _ID_VALUE2
       0096  _font
       0271  _hex
       02C1  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   02C1   01B4 =    436. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       02C1  __idata_start
       0475  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0476   0DB8 =   3512. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       023B  __text_start
       023B  __start
       025B  _exit
       025C  _busy
       029F  _control
       02CB  _goline
       0324  _position
       0375  _clear
       03DA  _Cput
       0426  _Sput
       044A  _Nput
       047C  _LCD_en
       04B7  _port_init
       04CD  _Uart0_init
       04DA  _Uart1_init
       04EB  _Uart0_rx_Interrupt
       052C  _adc_isr
       0540  _timer1_ovf_isr
       054F  _timer3_ovf_isr
       055E  _Uart1_rx_Interrupt
       05A8  _Uart0_TX_byte
       05AD  _Uart0_TX_bytes
       05C2  _Uart1_TX_byte
       05CE  _Uart1_TX_bytes
       05E1  _adc_init
       05E6  _ADC_PROCESS
       0608  _KEY_Scan
       0636  _KEY1_Function
       0652  _KEY2_Function
       066E  _KEY_Function
       068F  _LEVEL_CONVERT
       0715  _DATA_IDENTIFY
       0771  _init_devices
       07A8  _main
       08BB  _strlen
       08C7  mod8u
       08C9  div8u
       08CA  xdiv8u
       08DB  empy16s
       08EB  pop_gset2
       08EE  pop_gset3
       08F1  pop_gset4
       08F4  push_gset1
       08F7  pop_gset1
       08F8  pop
       090B  push_gset2
       090F  push_gset3
       0913  push_gset4
       0917  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0100   01B4 =    436. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0100  __data_start
       0100  _m_VERSION
       02B4  __data_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             bss   02B4   00E3 =    227. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       02B4  _T_COUNT
       02B4  __bss_start
       02B6  _SW_STATE2
       02B7  _SW_STATE1
       02B8  _IRSEND
       02B9  _RFID_COUNT
       02BA  _TIME3_flag
       02BB  _TIME_flag
       02BC  _adc_flagg
       02BD  _ADC_DATAS
       02BF  _HEX_DIS
       02C9  _KEY_Flag
       02CA  _UART_RX_FL
       02CB  _UART1_RX_Flag
       02CC  _UART0_RX_Flag
       02CD  _UART1_RX_Count
       02CE  _UART0_RX_Count
       02CF  _UART1_RX_DATA
       0301  _UART0_RX_DATA
       0333  _UART1_TX_DATA
       0365  _UART0_TX_DATA
       0397  __bss_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   007C =    124. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

C:\icc\lib\crtatmega.o	[ crtatmega.s ]
3150TO_AVR.o	[ _3150TO_AVR.c ]
<library>	[ strlen.s, div8u.s, emul16s.s, gpop2.s, gpop3.s, gpop4.s, gpush.s, gpush2.s, gpush3.s, gpush4.s ]

User Global Definitions

ram_end = 0x10ff
hwstk_size = 0x10

User Base Address Definitions

func_lit = 0x8c
data = 0x100
eeprom:1.4096


