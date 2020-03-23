;Program compiled by Great Cow BASIC (0.98.<<>> 2020-02-29 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F25Q10, r=DEC
#include <P18F25Q10.inc>
 CONFIG CP = OFF, LVP = OFF, WRTD = OFF, WDTE = OFF, XINST = OFF, MCLRE = INTMCLR, CLKOUTEN = OFF, RSTOSC = LFINTOSC, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
SYSTEMP1	EQU	4
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
;''A most simple sample for GCGB and GCB.
;''------------------------------------------------------------------------
;''This program blinks the onboard LED of a microcontroller using the LFINT internal oscillator to give 31 Khz
;''
;''This sample file can be adapted to any of the supported microcontrollers
;''by simply changing the #chip creating and removing the comment.
;''
;''To make your programmer or your bootloader work, simply do the following.
;''
;''From within this IDE, select from the menu 'IDE Tools/GCB Tools/Edit Programmer Preferences' or press Ctrl-Alt-E.
;''this will show you the 'Programmer Preferences', select the 'Programmer' tab.
;''
;''
;''For further adventures with Great Cow BASIC .... Click button "view Demos" for 1000's of sample programs.
;''
;''
;''Enjoy.
;''
;''
;''************************************************************************
;----- Configuration
;#define testport porta.1
;dir testport out
	bcf	TRISA,1,ACCESS
;do
SysDoLoop_S1
;testport = !testport
	clrf	SysTemp1,ACCESS
	btfsc	PORTA,1,ACCESS
	incf	SysTemp1,F,ACCESS
	comf	SysTemp1,F,ACCESS
	bcf	LATA,1,ACCESS
	btfsc	SysTemp1,0,ACCESS
	bsf	LATA,1,ACCESS
;wait 100  ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
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
	movlw	1
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	1
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

;Source: system.h (110)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;this code block sets the internal oscillator to 0.031
;asm showdebug _ChipMHz_ is ChipMHz
;_chipmhz_ is 0.031
;Data from .dat file
;OSCCON1 = ChipLFINTOSCClockSourceRegisterValue
	movlw	80
	banksel	OSCCON1
	movwf	OSCCON1,BANKED
;Default value CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3,BANKED
;Default value LFOEN disabled; ADOEN disabled; SOSCEN enabled; EXTOEN disabled; HFOEN disabled;
;OSCEN = 0x00
	clrf	OSCEN,BANKED
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;_complete_the_chip_setup_of_bsr,adcs,ansel_and_other_key_setup_registers_or_register_bits
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	clrf	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;End clearing any ANSEL variants in the part
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	bcf	CM2CON0,C2EN,BANKED
;C1EN = 0
	bcf	CM1CON0,C1EN,BANKED
;Turn off all ports
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
