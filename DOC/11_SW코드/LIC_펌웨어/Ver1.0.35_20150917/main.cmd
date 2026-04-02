/****************************************************************/
/* C31 Linker Command File										*/
/****************************************************************/

	/********************************/
	/*	Specify the Input Files	*/
	/********************************/
	start.obj
	debug3x.obj
	xr16l784.obj
	en29lv040.obj
	LonInfo.obj
	MpuDebug.obj
	user.obj
	main.obj

	/********************************/
	/*	Specify Linker Options	*/
	/********************************/
	-o main.out
	-m main.map
	-c
	-stack	0xD00
	-l rts30.lib
			     
	/****************************************/
	/* Specify the Memory Configuration	*/
	/****************************************/
	MEMORY
	{
		FROM	:	origin = 0400000h	length = 0080000h
		IRAM0	:	origin = 0800000h	length = 0008000h
		/*RAM0	:	org = 0x809800		len = 0x800*/			/* RAM BLOCK 0 */
		/*RAM1	:	org = 0x809c00		len = 0x400*/			/* RAM BLOCK 1 */
    }

	/************************************/
	/*	Specify the Output Sections		*/
	/************************************/
	SECTIONS {		
		.text : > IRAM0
		.cinit : { } > IRAM0
		.const : { } > IRAM0
		.data  : { } > IRAM0
		.stack : { } > IRAM0
		.bss   : { } > IRAM0
 		/*.sysmem: { } > IRAM0*/
       }

/****************************/
/*	End of Command File		*/
/****************************/
