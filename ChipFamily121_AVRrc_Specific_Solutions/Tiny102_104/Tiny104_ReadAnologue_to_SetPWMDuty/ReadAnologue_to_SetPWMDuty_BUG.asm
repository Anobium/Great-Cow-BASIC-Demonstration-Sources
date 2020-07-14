;Program compiled by Great Cow BASIC (0.98.<<>> 2020-07-07 (Windows 64 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: TINY104
;Assembler header file
.INCLUDE "tn104def.inc"

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
.EQU	ADCTEMP=64
.EQU	ADCTEMP_H=65
.EQU	ADREADPORT=66
.EQU	READAD=67

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBYTETEMPX=r16
.DEF	SYSDIVMULTA=r24
.DEF	SYSDIVMULTA_H=r25
.DEF	SYSDIVMULTB=r30
.DEF	SYSDIVMULTB_H=r31
.DEF	SYSDIVMULTX=r18
.DEF	SYSDIVMULTX_H=r19
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMP10US=r27
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSWORDTEMPX=r16
.DEF	SYSWORDTEMPX_H=r17
.DEF	SYSTEMP1=r20

;********************************************************************************

;Alias variables
#define	SYSREADADBYTE	67

;********************************************************************************

;Vectors
;Interrupt vectors
.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
.ORG	1
	reti	;INT0
.ORG	2
	reti	;PCINT0
.ORG	3
	reti	;PCINT1
.ORG	4
	reti	;TIM0_CAPT
.ORG	5
	reti	;TIM0_OVF
.ORG	6
	reti	;TIM0_COMPA
.ORG	7
	reti	;TIM0_COMPB
.ORG	8
	reti	;ANA_COMP
.ORG	9
	reti	;WDT
.ORG	10
	reti	;VLM
.ORG	11
	reti	;ADC
.ORG	13
	reti	;USART_RX
.ORG	14
	reti	;USART_UDRE
.ORG	15
	reti	;USART_TX

;********************************************************************************

;Start of program memory page 0
.ORG	17
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS
;Automatic pin direction setting
	sbi	DDRB,2

;Start of the main program
;''A demonstration program for GCB
;''---------------------------------------------------------------------------------
;'' This program shows how to read the ADC, and then to set PWM duty%
;''
;'' Change TCCR0B to change the frequency.  OCR0AL controls the DUTY
;''
;''@author  Evan Venn
;''@licence GPL
;''@version 1.0
;''@date    28/06/2020
;''********************************************************************************
;Dir PortB.1 out          ' OCR0A - this is required
	sbi	DDRB,1
;Set up ADC
;#define AD_Delay 2 10us
;Set up PWM
;COM0A1 = 1: COM0A0 = 0                       ' Set OC0A1 Low for a port that is PULLED HIGH, examine COM0A1 and COM0A0 for other options
	in	SysValueCopy,TCCR0A
	sbr	SysValueCopy,1<<COM0A1
	out	TCCR0A,SysValueCopy
	in	SysValueCopy,TCCR0A
	cbr	SysValueCopy,1<<COM0A0
	out	TCCR0A,SysValueCopy
;WGM00  = 1: WGM01 = 1                        ' Set OC0A1 Low , Fast 10bit PWM mode
	in	SysValueCopy,TCCR0A
	sbr	SysValueCopy,1<<WGM00
	out	TCCR0A,SysValueCopy
	in	SysValueCopy,TCCR0A
	sbr	SysValueCopy,1<<WGM01
	out	TCCR0A,SysValueCopy
;WGM02  = 1: TCCR0B = TCCR0B or 2             ' Fast PWM with OCR0A as TOP;  clkI/O/8 (From prescaler)
	in	SysValueCopy,TCCR0B
	sbr	SysValueCopy,1<<WGM02
	out	TCCR0B,SysValueCopy
	ldi	SysTemp1,2
	in	SysTemp2,TCCR0B
	or	SysTemp2,SysTemp1
	out	TCCR0B,SysTemp2
;Dim adcTemp as word
;Main loop
;Do Forever
SysDoLoop_S1:
;adcTemp =  ReadAD( AN7 ) * 4
	ldi	SysValueCopy,7
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD2
	lds	SysWORDTempA,SYSREADADBYTE
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,4
	ldi	SysWORDTempB_H,0
	rcall	SysMultSub16
	sts	ADCTEMP,SysWORDTempX
	sts	ADCTEMP_H,SysWORDTempX_H
;OCR0AH = adcTemp_h '  Copy result to PWM duty, always copy High byte first
	lds	SysValueCopy,ADCTEMP_H
	out	OCR0AH,SysValueCopy
;OCR0AL = adcTemp   '  Copy result to PWM duty
	lds	SysValueCopy,ADCTEMP
	out	OCR0AL,SysValueCopy
;PulseOut portb.2, 50 ms
;Macro Source: stdbasic.h (185)
;Set Pin On
	sbi	PORTB,2
;Wait Time
	ldi	SysWaitTempMS,50
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Set Pin Off
	cbi	PORTB,2
;wait 100 ms
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

Delay_10US:
D10US_START:
	ldi	DELAYTEMP,25
DelayUS0:
	dec	DELAYTEMP
	brne	DelayUS0
	rjmp	PC + 1
	dec	SysWaitTemp10US
	brne	D10US_START
	ret

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,127
DMS_OUTER:
	ldi	DELAYTEMP,20
DMS_INNER:
	dec	DELAYTEMP
	brne	DMS_INNER
	dec	DELAYTEMP2
	brne	DMS_OUTER
	dec	SysWaitTempMS
	brne	DMS_START
	dec	SysWaitTempMS_H
	brne	DMS_START
	ret

;********************************************************************************

;Source: system.h (109)
INITSYS:
;Set the AVR frequency for chipfamily 121 - assumes internal OSC
;Only sets internal therfore is 12mhz, the default setting is selected, NO OSC will be set.
;Unlock the  frequency register where 0xD8 is the correct signature for the AVRrc chips
;CCP = 0xD8            'signature to CCP
	ldi	SysValueCopy,216
	out	CCP,SysValueCopy
;CLKMSR = 0            'use clock 00: Calibrated Internal 8 MHzOscillator
	ldi	SysValueCopy,0
	out	CLKMSR,SysValueCopy
;CCP = 0xD8            'signature to CCP
	ldi	SysValueCopy,216
	out	CCP,SysValueCopy
;CLKPSR = 0            '8mhz
	ldi	SysValueCopy,0
	out	CLKPSR,SysValueCopy
;Turn off all ports
;PORTA = 0
	ldi	SysValueCopy,0
	out	PORTA,SysValueCopy
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (1690)
FN_READAD2:
;ADFM should configured to ensure LEFT justified
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (367)
;Select channel by setting ADMUX
;ADMUX = ADReadPort
	lds	SysValueCopy,ADREADPORT
	out	ADMUX,SysValueCopy
;ADLAR = ADLeftAdjust
	sbi	ADCSRB,ADLAR
;Set conversion clock to MediumSpeed
;SET ADPS2 On
	sbi	ADCSRA,ADPS2
;SET ADPS1 Off
	cbi	ADCSRA,ADPS1
;Wait AD_Delay   'Execute the acquisition Delay
	ldi	SysWaitTemp10US,2
	rcall	Delay_10US
;Set ADEN On     'Take reading
	sbi	ADCSRA,ADEN
;Set ADSC On
	sbi	ADCSRA,ADSC
;Wait While ADSC On
SysWaitLoop1:
	sbic	ADCSRA,ADSC
	rjmp	SysWaitLoop1
;Set ADEN Off
	cbi	ADCSRA,ADEN
;ReadAD = ADCH
	in	SysValueCopy,ADCH
	sts	READAD,SysValueCopy
	ret

;********************************************************************************

;Source: system.h (2935)
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

;Source: system.h (2337)
SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	mov	SYSDIVMULTA,SYSWORDTEMPA
	mov	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysDivMultB = SysWordTempB
	mov	SYSDIVMULTB,SYSWORDTEMPB
	mov	SYSDIVMULTB_H,SYSWORDTEMPB_H
;SysDivMultX = 0
	ldi	SYSDIVMULTX,0
	ldi	SYSDIVMULTX_H,0
MUL16LOOP:
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	sbrs	SYSDIVMULTB,0
	rjmp	ENDIF1
	mov	SysTemp2,SYSDIVMULTX
	add	SysTemp2,SYSDIVMULTA
	mov	SYSDIVMULTX,SysTemp2
	mov	SysTemp2,SYSDIVMULTX_H
	adc	SysTemp2,SYSDIVMULTA_H
	mov	SYSDIVMULTX_H,SysTemp2
ENDIF1:
;Set C Off
	clc
;rotate SysDivMultB right
	ror	SYSDIVMULTB_H
	ror	SYSDIVMULTB
;Set C Off
	clc
;rotate SysDivMultA left
	rol	SYSDIVMULTA
	rol	SYSDIVMULTA_H
;if SysDivMultB > 0 then goto MUL16LOOP
	mov	SysWORDTempB,SYSDIVMULTB
	mov	SysWORDTempB_H,SYSDIVMULTB_H
	ldi	SysWORDTempA,0
	ldi	SysWORDTempA_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	MUL16LOOP
;SysWordTempX = SysDivMultX
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************


