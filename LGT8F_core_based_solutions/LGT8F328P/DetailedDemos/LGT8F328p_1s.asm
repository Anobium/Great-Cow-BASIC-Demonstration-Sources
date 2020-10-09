;Program compiled by Great Cow BASIC (0.98.07 RC26 2020-10-07 (Windows 64 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: LGT8F328P
;Assembler header file
.INCLUDE "lgt8f328pdef.inc"

;SREG bit names (for AVR Assembler compatibility, GCBASIC uses different names)
#define C 0
#define H 5
#define I 7
#define N 2
#define S 4
#define T 6
#define V 3
#define Z 1

;********************************************************************************

;Set aside memory locations for variables
.EQU	CURMS=256
.EQU	CURMS_H=257
.EQU	LSTMS=258
.EQU	LSTMS_H=259
.EQU	MILLIS=260
.EQU	MILLIS_E=263
.EQU	MILLIS_H=261
.EQU	MILLIS_U=262
.EQU	MSCTR_=264
.EQU	MSCTR__E=267
.EQU	MSCTR__H=265
.EQU	MSCTR__U=266
.EQU	SAVESREG=268
.EQU	SAVESYSTEMP2=269
.EQU	SAVESYSVALUECOPY=270
.EQU	SYSINTSTATESAVE0=271
.EQU	TMR0_TMP=272
.EQU	TMRPRES=273
.EQU	TMRSOURCE=274

;********************************************************************************

;Register variables
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSVALUECOPY=r21
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSTEMP1=r1
.DEF	SYSTEMP1_H=r2
.DEF	SYSTEMP2=r3
.DEF	SYSTEMP3=r4
.DEF	SYSTEMP4=r16

;********************************************************************************

;Vectors
;Interrupt vectors
.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
.ORG	2
	reti	;INT0
.ORG	4
	reti	;INT1
.ORG	6
	reti	;PCINT0
.ORG	8
	reti	;PCINT1
.ORG	10
	reti	;PCINT2
.ORG	12
	reti	;WDT
.ORG	14
	reti	;TIMER2_COMPA
.ORG	16
	reti	;TIMER2_COMPB
.ORG	18
	reti	;TIMER2_OVF
.ORG	20
	reti	;TIMER1_CAPT
.ORG	22
	reti	;TIMER1_COMPA
.ORG	24
	reti	;TIMER1_COMPB
.ORG	26
	reti	;TIMER1_OVF
.ORG	28
	reti	;TIMER0_COMPA
.ORG	30
	reti	;TIMER0_COMPB
.ORG	32
	rjmp	IntTIMER0_OVF ;TIMER0_OVF
.ORG	34
	reti	;SPI_STC
.ORG	36
	reti	;USART_RX
.ORG	38
	reti	;USART_UDRE
.ORG	40
	reti	;USART_TX
.ORG	42
	reti	;ADC
.ORG	44
	reti	;EE_READY
.ORG	46
	reti	;ANALOG_COMP
.ORG	48
	reti	;TWI
.ORG	50
	reti	;SPM_READY
.ORG	54
	reti	;PICI3_READY
.ORG	56
	reti	;PICI4_READY
.ORG	58
	reti	;TIMER3_INT

;********************************************************************************

;Start of program memory page 0
.ORG	60
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Family122 specific init
	ldi	SysValueCopy,0
	out	MCUSR,SysValueCopy
	ldi	SysValueCopy,128
	sts	PMCR,SysValueCopy
	ldi	SysValueCopy,19
	sts	PMCR,SysValueCopy
;Call initialisation routines
	rcall	INITSYS
	rcall	INIT_MSCTR_INT
;Enable interrupts
	sei

;Start of the main program
;#define LED PORTB.5       ' Define the LED Pin
;#define LEDRate 1000      ' Flash rate in mS
;Setup
;Dir LED Out               ' Make the LED Pin an Output
	sbi	DDRB,5
;LED = 0
	cbi	PORTB,5
;Dim CurMs, LstMs as word  ' declare working variables
;Main                    ' This loop runs over and over forever.
;LstMs = 0
	ldi	SysValueCopy,0
	sts	LSTMS,SysValueCopy
	sts	LSTMS_H,SysValueCopy
;CurMs = 0
	ldi	SysValueCopy,0
	sts	CURMS,SysValueCopy
	sts	CURMS_H,SysValueCopy
;Main                    ' This loop runs over and over forever.
;Do
SysDoLoop_S1:
;CurMs = millis()
	rcall	FN_MILLIS
	lds	SysValueCopy,MILLIS
	sts	CURMS,SysValueCopy
	lds	SysValueCopy,MILLIS_H
	sts	CURMS_H,SysValueCopy
;if CurMs - LstMs >= LEDRate then  ' required Time has Elapsed
	lds	SysTemp2,CURMS
	lds	SysTemp3,LSTMS
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CURMS_H
	lds	SysTemp3,LSTMS_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF1
;LED = !LED                      ' So Toggle state of LED
	clr	SysTemp2
	sbic	PINB,5
	inc	SysTemp2
	com	SysTemp2
	cbi	PORTB,5
	sbrc	SYSTEMP2,0
	sbi	PORTB,5
;LstMs = CurMs                   ' And Record Toggle Time
	lds	SysValueCopy,CURMS
	sts	LSTMS,SysValueCopy
	lds	SysValueCopy,CURMS_H
	sts	LSTMS_H,SysValueCopy
;end if
ENDIF1:
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;END
	rjmp	BASPROGRAMEND
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

;Source: system.h (116)
INITSYS:
;MCUSR - IO Special Function Registers Control
;MCUSR = 0
	ldi	SysValueCopy,0
	out	MCUSR,SysValueCopy
;WDT clock by 32KHz IRC
;PMCR = 0x80
	ldi	SysValueCopy,128
	sts	PMCR,SysValueCopy
;PMCR = 0x13
	ldi	SysValueCopy,19
	sts	PMCR,SysValueCopy
;Set the frequency - assumes internal OSC
;CLKPCE = 1
	lds	SysValueCopy,CLKPR
	sbr	SysValueCopy,1<<CLKPCE
	sts	CLKPR,SysValueCopy
;CLKPR = 0            '32mhz
	ldi	SysValueCopy,0
	sts	CLKPR,SysValueCopy
;'enable 1KB E2PROM for LGT8F328P
;ECCR = 0x80
	ldi	SysValueCopy,128
	out	ECCR,SysValueCopy
;ECCR = 0x4C
	ldi	SysValueCopy,76
	out	ECCR,SysValueCopy
;Turn off all ports
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
;PORTC = 0
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
;PORTD = 0
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
;PORTE = 0
	ldi	SysValueCopy,0
	out	PORTE,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: timer.h (1410)
INITTIMER0181:
;Just need to buffer TMR0Pres
;(And change it for external clock)
;TMRPres, TMRSource now shared and local - WMR
;TMR0_TMP now used as shadow register    - WMR
;If TMRSource = Ext Then
	lds	SysCalcTempA,TMRSOURCE
	cpi	SysCalcTempA,2
	brne	ENDIF2
;TMRPres = AVR_EXT_TMR_0_RE
	ldi	SysValueCopy,7
	sts	TMRPRES,SysValueCopy
;End If
ENDIF2:
;TMR0_TMP = TMRPres
	lds	SysValueCopy,TMRPRES
	sts	TMR0_TMP,SysValueCopy
	ret

;********************************************************************************

;Source: millis.h (164)
INIT_MSCTR_INT:
;Add the handler for the interrupt
;On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
	lds	SysValueCopy,TIMSK0
	sbr	SysValueCopy,1<<TOIE0
	sts	TIMSK0,SysValueCopy
;MsCtr_ = 0
	ldi	SysValueCopy,0
	sts	MSCTR_,SysValueCopy
	sts	MSCTR__H,SysValueCopy
	sts	MSCTR__U,SysValueCopy
	sts	MSCTR__E,SysValueCopy
;Millis = 0
	rcall	FN_MILLIS
;
;#define PS_0_0 0        ' no clock source
;#define PS_0_1 1
;#define PS_0_8 2
;#define PS_0_64 3
;#define PS_0_256 4
;#define PS_0_1024 5
;Set prescaler to 256, Preload and then start the timer
;InitTimer0 Osc, PS_0_256
	ldi	SysValueCopy,1
	sts	TMRSOURCE,SysValueCopy
	ldi	SysValueCopy,4
	sts	TMRPRES,SysValueCopy
	rcall	INITTIMER0181
;asm ShowDebug  Call_SetTimer_Millis_macro
;SetTimer_Millis Tmr0InitVal
;Macro Source: millis.h (365)
;TCNT0 = TMRValueMillis
	ldi	SysValueCopy,131
	out	TCNT0,SysValueCopy
;asm ShowDebug Call_StartTimer_Millis_macro
;StartTimer_Millis
;Macro Source: millis.h (397)
;Need to set clock select bits to 0 (Stops Timer)
;TCCR0B = TCCR0B And 248 Or TMR0_TMP
	ldi	SysTemp4,248
	in	SysTemp3,TCCR0B
	and	SysTemp3,SysTemp4
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,TMR0_TMP
	or	SysTemp3,SysTemp2
	out	TCCR0B,SysTemp3
	ret

;********************************************************************************

IntTIMER0_OVF:
	rcall	SysIntContextSave
	rcall	MSCTR_INT_HDLR
	cbi	TIFR0,TOV0
	rjmp	SysIntContextRestore

;********************************************************************************

;Source: millis.h (355)
FN_MILLIS:
;dim Millis, MsCtr_ as long
;disable interrupts while we read millis or we might get an
;inconsistent value (e.g. in the middle of a write to millis)
;IntOff
	lds	SysValueCopy,SYSINTSTATESAVE0
	cbr	SysValueCopy,1<<0
	brbc	I,PC + 2
	sbr	SysValueCopy,1<<0
	sts	SYSINTSTATESAVE0,SysValueCopy
	cli
;Millis = MsCtr_
	lds	SysValueCopy,MSCTR_
	sts	MILLIS,SysValueCopy
	lds	SysValueCopy,MSCTR__H
	sts	MILLIS_H,SysValueCopy
	lds	SysValueCopy,MSCTR__U
	sts	MILLIS_U,SysValueCopy
	lds	SysValueCopy,MSCTR__E
	sts	MILLIS_E,SysValueCopy
;IntOn
	lds	SysBitTest,SYSINTSTATESAVE0
	sbrc	SysBitTest,0
	sei
	ret

;********************************************************************************

;Source: millis.h (154)
MSCTR_INT_HDLR:
;dim MsCtr_ as Long
;asm ShowDebug Call_SetTimer_Millis_macro
;SetTimer_Millis  Tmr0InitVal   ' Reset Inital Counter valueue
;Macro Source: millis.h (365)
;TCNT0 = TMRValueMillis
	ldi	SysValueCopy,131
	out	TCNT0,SysValueCopy
;MsCtr_ = MsCtr_ + 1
	lds	SysTemp2,MSCTR_
	inc	SysTemp2
	sts	MSCTR_,SysTemp2
	lds	SysTemp2,MSCTR__H
	brne	PC + 2
	inc	SysTemp2
	sts	MSCTR__H,SysTemp2
	lds	SysTemp2,MSCTR__U
	brne	PC + 2
	inc	SysTemp2
	sts	MSCTR__U,SysTemp2
	lds	SysTemp2,MSCTR__E
	brne	PC + 2
	inc	SysTemp2
	sts	MSCTR__E,SysTemp2
	ret

;********************************************************************************

;Source: system.h (3000)
SYSCOMPLESSTHAN16:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test High, exit false if more
;cp SysWordTempB_H,SysWordTempA_H
	cp	SYSWORDTEMPB_H,SYSWORDTEMPA_H
;brlo SCLT16False
	brlo	SCLT16FALSE
;Test high, exit true if less
;cp SysWordTempA_H,SysWordTempB_H
	cp	SYSWORDTEMPA_H,SYSWORDTEMPB_H
;brlo SCLT16True
	brlo	SCLT16TRUE
;Test Low, exit if more or equal
;cp SysWordTempA,SysWordTempB
	cp	SYSWORDTEMPA,SYSWORDTEMPB
;brlo SCLT16True
	brlo	SCLT16TRUE
;ret
	ret
SCLT16TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT16FALSE:
	ret

;********************************************************************************

SysIntContextRestore:
;Restore registers
	lds	SysTemp2,SaveSysTemp2
;Restore SREG
	lds	SysValueCopy,SaveSREG
	out	SREG,SysValueCopy
;Restore SysValueCopy
	lds	SysValueCopy,SaveSysValueCopy
	reti

;********************************************************************************

SysIntContextSave:
;Store SysValueCopy
	sts	SaveSysValueCopy,SysValueCopy
;Store SREG
	in	SysValueCopy,SREG
	sts	SaveSREG,SysValueCopy
;Store registers
	sts	SaveSysTemp2,SysTemp2
	ret

;********************************************************************************


