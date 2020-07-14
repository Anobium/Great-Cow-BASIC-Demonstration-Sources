;Program compiled by Great Cow BASIC (0.98.<<>> 2020-07-07 (Windows 64 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: TINY10
;Assembler header file
.INCLUDE "tn10def.inc"

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
.EQU	SERDLYCNT=68
.EQU	STXDATABYTE=69

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBYTETEMPX=r16
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMP10US=r27
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29

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
	reti	;TIM0_CAPT
.ORG	4
	reti	;TIM0_OVF
.ORG	5
	reti	;TIM0_COMPA
.ORG	6
	reti	;TIM0_COMPB
.ORG	7
	reti	;ANA_COMP
.ORG	8
	reti	;WDT
.ORG	9
	reti	;VLM
.ORG	10
	reti	;ADC

;********************************************************************************

;Start of program memory page 0
.ORG	12
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS
	rcall	STX1PINSETUP

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
;''@date    11/06/2020
;''********************************************************************************
;BUG... out of registers - work around is
;sub wait
;
;end sub
;----- Config Serial UART :
;----- Include library
;#define SER1_BAUD 9600     ; baudrate must be defined
;#define SER1_DATABITS 8    ; databits optional (default = 8)
;#define SER1_STOPBITS 1    ; stopbits optional (default = 1)
;#define SER1_INVERT Off    ; inverted polarity optional (default = Off)
;Config I/O ports for transmitting:
;#define SER1_TXPORT PORTB  ; I/O port (without .bit) must be defined
;#define SER1_TXPIN 2       ; portbit  must be defined
;Dir PortB.0 out
	sbi	DDRB,0
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
	ldi	SysValueCopy,2
	mov	SysTemp2,SysValueCopy
	in	SysTemp1,TCCR0B
	or	SysTemp1,SysTemp2
	out	TCCR0B,SysTemp1
;To resolve bug
;TCCR0B.0=0
;TCCR0B.1=1
;TCCR0B.2=0
;factorise ADCL to give full duty as the ADC reading is 0-255 and we need 0-1023
;#Define MAXFACTOR = 13       '8 may work for a perfect POT setup... mine is not perfect...
;#Define MAXADC    = 1023
;Dim adcTemp as word
;Main loop
;Do Forever
SysDoLoop_S1:
;factorise ADC to give full dity
;adcTemp =  ( ReadAD( AN1 ) )
	ldi	SysValueCopy,1
	sts	ADREADPORT,SysValueCopy
	rcall	FN_READAD27
	lds	SysValueCopy,SYSREADADBYTE
	sts	ADCTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	ADCTEMP_H,SysValueCopy
;Ser1Send adcTemp
	lds	SysValueCopy,ADCTEMP
	sts	STXDATABYTE,SysValueCopy
	rcall	SER1SEND
;if adcTemp > MAXADC then adcTemp = MAXADC
	lds	SysWORDTempB,ADCTEMP
	lds	SysWORDTempB_H,ADCTEMP_H
	ldi	SysWORDTempA,255
	ldi	SysWORDTempA_H,3
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF1
	ldi	SysValueCopy,255
	sts	ADCTEMP,SysValueCopy
	ldi	SysValueCopy,3
	sts	ADCTEMP_H,SysValueCopy
ENDIF1:
;OCR0AL = adcTemp   '  Copy result to PWM duty
	lds	SysValueCopy,ADCTEMP
	out	OCR0AL,SysValueCopy
;OCR0AH = adcTemp_h '  Copy result to PWM duty
	lds	SysValueCopy,ADCTEMP_H
	out	OCR0AH,SysValueCopy
;PulseOutInv portb.2, 50 ms
;wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
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
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (1690)
FN_READAD27:
;ADFM should configured to ensure LEFT justified
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (367)
;Select channel by setting ADMUX
;ADMUX = ADReadPort
	lds	SysValueCopy,ADREADPORT
	out	ADMUX,SysValueCopy
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
;ReadAD = ADCL
	in	SysValueCopy,ADCL
	sts	READAD,SysValueCopy
	ret

;********************************************************************************

;Source: SoftSerialCh1.h (172)
SER1SEND:
;*** Code for sending a byte is here!
;*** Code for PIC:
;*** Code for AVR:
;** AVR; send to channel:
;lds R23,STxDataByte               ;load DataByte to register
	lds	R23,STXDATABYTE
;ldi R26,SER1_DATABITS+2           ;load number of DataBits to register (1 start + N data + 1 stop)
	ldi	R26,8+2
;com R23                           ;invert DataBits and set Carry to 1
	com	R23
STX1LOOP:
;10 cycle loop + delay per byte
;brcc STx1One                     ;jump to STxOne if Carry=0  [ASM]             cycle 1
	brcc	STX1ONE
;Set SER1_TXPORT,SER1_TXPIN Off ;set pin LOW if Carry=1 (translated to: cbi)  cycle 2,3
	cbi	PORTB,2
STX1ONE:
;brcs STx1Done                    ;jump to STxDone if Carry=1                   cycle 4,5
	brcs	STX1DONE
;Set SER1_TXPORT,SER1_TXPIN On  ;set pin HIGH if Carry=0 (translated to: cbi) cycle -
	sbi	PORTB,2
STX1DONE:
;--- start short delay --------
;ldi R24, STX1_DELAY            ;load delaycounter to register [ASM]          cycle 6
	ldi	R24, 18
STX1DELAY:
;delay-loop = (3 cycle * delaycounter) -1
;dec R24                        ;decrement delaycounter
	dec	R24
;brne STx1Delay                  ;loop to STxDelay until delaycounter=0
	brne	STX1DELAY
;--- end short delay ----------
;--- start long delay --------
;Sub_SerLongDelay(STX1_DELAYH)  ;process long delay
	ldi	SysValueCopy,1
	sts	SERDLYCNT,SysValueCopy
	rcall	SUB_SERLONGDELAY
;--- end long delay ----------
;lsr R23                         ;shift next DataBit to Carry  [ASM]  cycle 7
	lsr	R23
;dec R26                         ;decrement bitcounter [ASM]          cycle 8
	dec	R26
;brne STx1Loop                    ;jump to STxLoop and transmit next bit until bitcounter=0  [ASM] cycle 9,10
	brne	STX1LOOP
;* Add additional stopbit
	ret

;********************************************************************************

;Source: SoftSerialCh1.h (155)
STX1PINSETUP:
;*** Process pin-direction and -polarity for sending on programmstart:
;Dir SER1_TXPORT.SER1_TXPIN Out       '... make it output
	sbi	DDRB,2
;Set SER1_TXPORT.SER1_TXPIN On      '... set HIGH to make the first startbit recognizable
	sbi	PORTB,2
;#ifdef PIC
;nop                                'otherwise the first 2 bytes are garbage !?
;#endif
	ret

;********************************************************************************

;Source: softserial.h (84)
SUB_SERLONGDELAY:
;Dim  SerDlyCntI As Byte
;Calling & returning from Sub:  4 cycles
;loading TxCntDly            :  1 cycles
;--- start outer loop --------------
;lds R25, SerDlyCnt
	lds	R25, SERDLYCNT
;ldi R25, SRX1_DELAYH
STXDELAYH:
;ldi R24, 253           ;number of inner delay-loops [GCB]         ;outer loop cycle 1
	ldi	R24, 253
;--- start inner loop --------------
STXDELAYI:
;dec R24              ;decrement inner delaycounter              ;inner loop cycle 1
	dec	R24
;brne STxDelayI        ;loop to STxDelayI until delaycounter = 0  ;inner loop cycle 2,3
	brne	STXDELAYI
;nop                  ;last loop:  no jump -1 cycles; nop +1 cycle
	nop
;--- end inner loop -----------------
;dec R25               ;decrement outer delaycounter               ;outer loop cycle 2
	dec	R25
;nop                                                               ;outer loop cycle 3
	nop
;nop                                                               ;outer loop cycle 4
	nop
;brne STxDelayH          ;loop to STxDelayH until delaycounter = 0   ;outer loop cycle 5,6
	brne	STXDELAYH
;--- end outer loop ---------------
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


