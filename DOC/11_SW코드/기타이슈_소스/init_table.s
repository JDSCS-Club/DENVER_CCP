; IMAL 2005-10-12
; The following table entry is needed to make
; the IAR start-up-sequence to copy from the
; a segment (often in ROM) to a segment in RAM

    RSEG INTVEC_RAM:ROOT
    RSEG INTVEC:ROOT

/* Structure of an element in the segment initialization table
 * in segment INITTAB. Used for both zero-initialization and copying. */
; typedef struct
; {
;   long   Size;                  /* Number of bytes to initialize */
;   char*  Dst;                   /* Destination. If Dst==Src, then init to 0 */
;   char*  Src;                   /* Source address. Usually in ROM. */
; } InitBlock_Type;

    RSEG INITTAB:CODE:ROOT(2) ; 2^2 4 bytes alignment
    DATA
    DCD       sfe(INTVEC) - sfb(INTVEC)     ;       size of the segment
    DCD       sfb(INTVEC_RAM)               ;       start address of where to copy to
    DCD       sfb(INTVEC)                   ;       start address of where to copy from

    END
