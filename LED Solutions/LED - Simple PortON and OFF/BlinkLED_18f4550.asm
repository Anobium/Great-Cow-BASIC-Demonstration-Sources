;Program compiled by Great Cow BASIC (0.98.<<>> 2017-09-16)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F4550, r=DEC
#include <P18F4550.inc>
 CONFIG LVP = OFF, MCLRE = OFF, WDT = OFF, FOSC = INTOSCIO_EC

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
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program blink one LED on PORTD.2 using the ON and OFF commands.
;''The LED must be attached via appropiate resistors.
;''
;''@author 	EvanV plus works of others
;''@licence	GPL
;''@version	1.0a
;''@date   	31.01.2015
;''********************************************************************************
;----- Configuration
;----- Define Hardware settings
;Dir PORTD.2 Out
	bcf	TRISD,2,ACCESS
;----- Variables
;none specified in the example. All byte variables are defined upon use.
;----- Main body of program commences here.
START
;Set PORTD.2 ON   'turn LED on
	bsf	LATD,2,ACCESS
;Wait 100 Ms      'wait 100 milliseconds
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set PORTD.2 OFF  'turn LED off
	bcf	LATD,2,ACCESS
;Wait 900 Ms      'wait 900 milliseconds
	movlw	132
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Goto Start         'jump back to the start of the program
	bra	START
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	4
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	19
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
;OSCCON = OSCCON AND b'10001111'
	movlw	143
	andwf	OSCCON,F,ACCESS
;OSCCON = OSCCON OR b'01000000'
	movlw	64
	iorwf	OSCCON,F,ACCESS
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;SET PCFG3 ON
	bsf	ADCON1,PCFG3,ACCESS
;SET PCFG2 ON
	bsf	ADCON1,PCFG2,ACCESS
;SET PCFG1 ON
	bsf	ADCON1,PCFG1,ACCESS
;SET PCFG0 ON
	bsf	ADCON1,PCFG0,ACCESS
;CMCON = 7
	movlw	7
	movwf	CMCON,ACCESS
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTD = 0
	clrf	PORTD,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	return

;********************************************************************************


 END
