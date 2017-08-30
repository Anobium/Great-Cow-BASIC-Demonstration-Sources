;Program compiled by Great Cow BASIC (0.98.00 RC01 2017-08-25)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F26K22, r=DEC
#include <P18F26K22.inc>
 CONFIG LVP = OFF, MCLRE = INTMCLR, WDTEN = OFF, FOSC = INTIO67

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS

;Start of the main program
;''
;''  This lesson will introduce shifting instructions as well as bit-oriented skip operations to
;''  move the LED display.
;''
;''  LEDs rotate from right to left at a rate of 1.0s.
;''
;''
;''************************************************************************
;''
;''  PIC: 18f26k22
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 29.8.17
;''
;----- Configuration
;dir portb out
	clrf	TRISB,ACCESS
;portb = 0b10000000
	movlw	128
	movwf	PORTB,ACCESS
;do
SysDoLoop_S1
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set C off
	bcf	STATUS,C,ACCESS
;Rotate portb right
	rrcf	PORTB,F,ACCESS
;if C = 1 then portb.7 = 1
	btfsc	STATUS,C,ACCESS
	bsf	LATB,7,ACCESS
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	108
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	11
	movwf	DELAYTEMP,ACCESS
DMS_INNER
	decfsz	DELAYTEMP, F,ACCESS
	bra	DMS_INNER
	decfsz	DELAYTEMP2, F,ACCESS
	bra	DMS_OUTER
	decfsz	SysWaitTempMS, F,ACCESS
	bra	DMS_START
	decfsz	SysWaitTempMS_H, F,ACCESS
	bra	DMS_START
	return

;********************************************************************************

INITSYS
;nop             ' This is the routine for the OSCCON config
	nop
;OSCCON = OSCCON OR b'01110000'
	movlw	112
	iorwf	OSCCON,F,ACCESS
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;#IFDEF bit(C2ON): C2ON = 0: #ENDIF
	bcf	CM2CON,C2ON,ACCESS
;#IFDEF bit(C1ON): C1ON = 0: #ENDIF
	bcf	CM1CON,C1ON,ACCESS
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************


 END
