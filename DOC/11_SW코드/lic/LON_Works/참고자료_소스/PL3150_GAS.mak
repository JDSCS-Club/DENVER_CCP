CC = iccavr
CFLAGS =  -IC:\icc\include\ -e  -l -g -Mavr_enhanced_small -Wa-W 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -LC:\icc\lib\ -g -Wl-W -bfunc_lit:0x26.0x2000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:16 -beeprom:1.512 -fihx_coff -S2
FILES = PL3150_GAS.o 

PL3150_GAS:	$(FILES)
	$(CC) -o PL3150_GAS $(LFLAGS) @PL3150_GAS.lk 
PL3150_GAS.o: C:/icc/include/iom8v.h C:/icc/include/macros.h
PL3150_GAS.o:	E:\FW\HN_Device\GAS_ATMEGA8\PL3150_GAS.c
	$(CC) -c $(CFLAGS) E:\FW\HN_Device\GAS_ATMEGA8\PL3150_GAS.c
