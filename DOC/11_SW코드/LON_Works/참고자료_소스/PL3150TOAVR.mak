CC = iccavr
CFLAGS =  -IC:\icc\include\ -e -DATMEGA  -l -g -Mavr_enhanced 
ASFLAGS = $(CFLAGS)  -Wa-g
LFLAGS =  -LC:\icc\lib\ -g -ucrtatmega.o -bfunc_lit:0x8c.0x20000 -dram_end:0x10ff -bdata:0x100.0x10ff -dhwstk_size:16 -beeprom:1.4096 -fihx_coff -S2
FILES = 3150TO_AVR.o 

PL3150TOAVR:	$(FILES)
	$(CC) -o PL3150TOAVR $(LFLAGS) @PL3150TOAVR.lk  -lcatmega
3150TO_AVR.o: C:/icc/include/iom128v.h C:/icc/include/macros.h C:/icc/include/string.h C:/icc/include/_const.h E:\FW\HN_Device\PLAVR128/AVR128.h E:\FW\HN_Device\PLAVR128/lcd128.h
3150TO_AVR.o:	E:\FW\HN_Device\PLAVR128\3150TO_AVR.c
	$(CC) -c $(CFLAGS) E:\FW\HN_Device\PLAVR128\3150TO_AVR.c
