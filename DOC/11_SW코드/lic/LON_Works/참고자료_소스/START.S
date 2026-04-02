	XDEF	START
	XREF	STKTOP
	XREF	_main
;***************************************************************
;	The reset vector will point to this code (START).
;	By the time we get here, A7 will have been initialized.
;***************************************************************
	SECTION	code
	.STK	"none"			; terminate call chain for -OG
START	MOVE.L	#STKTOP,A7		; set the stack pointer
	MOVE.L	#0,A6			; terminate call chain for -Og

	;***********************************************************
	;		Zero out uninitialized RAM.
	;***********************************************************
	MOVE.L	#`BASE(ram),A1		; A1 = base of region ram
	MOVE.L	#`SIZE(ram),D0		; D0 = size of region ram
	LSR.L	#2,D0			; compute size in longs
	BRA	ZDBF			; enter a fast loop
  ZLP:	CLR.L	(A1)+			; clear four bytes at a time
  ZDBF:	DBF	D0,ZLP			; up to 256K in inner loop
	SUB.L	#$10000,D0		; rest in outer loop
	BHS	ZLP

	;***********************************************************
	;		Invoke main() with no arguments.
	;***********************************************************
	JSR	_main			; "int" return value in D0
DONE	BRA	DONE			; loop if main ever returns

;**********************************************************************
;	RESET VECTOR: to supervisor program space at address 0.
;**********************************************************************
	SECTION	reset
	DC.L	STKTOP			; initial stack pointer
	DC.L	START			; initial execution address

;**********************************************************************
;	OTHER EXCEPTION VECTORS: to supervisor data space at address 8,
;	or 8 bytes beyond where the vector base register will point.
;	This table is commented out because no actual interrupt rou-
;	tines are provided.
;**********************************************************************
;	SECTION	vects
;	DC.L	BUSERROR,ADRERROR			; 0x08
;	DC.L	ILLEGAL,ZERODIV,CHK,TRAPV		; 0x10
;	DC.L	PRIVILEGE,TRACE,EMULA,EMULF		; 0x20
;	DC.L	RESVD,PROTO,FORMAT,UNINIT		; 0x30
;	DCB.L	8,RESVD					; 0x40
;	DC.L	SPURIOUS,AUTO1,AUTO2,AUTO3		; 0x60
;	DC.L	AUTO4,AUTO5,AUTO6,AUTO7			; 0x70
;	DC.L	TRAP0,TRAP1,TRAP2,TRAP3			; 0x80
;	DC.L	TRAP4,TRAP5,TRAP6,TRAP7			; 0x90
;	DC.L	TRAP8,TRAP9,TRAPA,TRAPB			; 0xa0
;	DC.L	TRAPC,TRAPD,TRAPE,TRAPF			; 0xb0
;	DC.L	FUNORD,FNEXACT,FZERODIV,FUNFLOW		; 0xc0
;	DC.L	FOPND,FOVFLOW,FSNAN,RESVD		; 0xd0
;	DCB.L	8,RESVD					; 0xe0
;	DCB.L	192,USER				; 0x100
