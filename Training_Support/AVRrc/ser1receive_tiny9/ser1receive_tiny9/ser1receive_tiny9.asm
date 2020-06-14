;Program compiled by Great Cow BASIC (0.98.<<>> 2020-06-07 (Windows 64 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: TINY9
;Assembler header file
.INCLUDE "tn9def.inc"

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
.EQU	MYSTRING=64
.EQU	SERDLYCNT=84
.EQU	STRINGPOINTER=85
.EQU	STXDATABYTE=86

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPX=r16
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSSTRINGB=r28
.DEF	SYSSTRINGB_H=r29
.DEF	SYSSTRINGLENGTH=r25
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30

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

;********************************************************************************

;Start of program memory page 0
.ORG	10
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
;''This program uses the SoftSerial library for serial sending and receiving.
;'' SoftSerial uses ASM routines for minimal overhead.
;'' Ser1Receive stops programm execution until a startbit-impulse is detected.
;'' See other samples how to realize timeouts or interrupt-driven receiving.
;'':
;''@author  Evan Venn
;''@licence GPL
;''@version 1.0
;''@date    11/06/2020
;''********************************************************************************
;----- Configuration
;----- Include library
;----- Config Serial UART :
;#define SER1_BAUD 600    ; baudrate must be defined
;#define SER1_DATABITS 8    ; databits optional (default = 8)
;#define SER1_STOPBITS 1    ; stopbits optional (default = 1)
;#define SER1_INVERT Off    ; inverted polarity optional (default = Off)
;Config I/O ports for transmitting:
;#define SER1_TXPORT PORTB  ; I/O port (without .bit) must be defined
;#define SER1_TXPIN 1       ; portbit  must be defined
;Config I/O ports for receiving:
;NOTE:  RX is commented out until we have resolved the LDS/STS issue
;#define SER1_RXPORT PORTB  ; I/O port (without .bit) must be defined
;#define SER1_RXPIN 2       ; portbit  must be defined
;#define SER1_RXNOWAIT Off  ; don't wait for stopbit optional (default = Off)
;----- Variables
;Dim RecByte As Byte
;Dim myString as String * 19
;myString = "Please send a byte!"
	ldi	SysStringB,low(MYSTRING)
	ldi	SysStringB_H,high(MYSTRING)
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	rcall	SysReadString
;----- Main body of program commences here.
;/*
;Repeat 2
;Ser1Send 10   'new line in Terminal
;Ser1Send 13
;end Repeat
;Repeat 20
;Ser1Print myString  'send a text
;Ser1Send myString( 19 )
;Ser1Send 10   'new line in Terminal
;Ser1Send 13
;End Repeat
;*/
;dir portb.0 out
	sbi	DDRB,0
;Do
SysDoLoop_S1:
;pulseout portb.0, 100 ms
;Macro Source: stdbasic.h (185)
;Set Pin On
	sbi	PORTB,0
;Wait Time
	ldi	SysWaitTempMS,100
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Set Pin Off
	cbi	PORTB,0
;wait 100 ms
;Ser1Send "."
	ldi	SysValueCopy,46
	sts	STXDATABYTE,SysValueCopy
	rcall	SER1SEND
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;
;Do Forever
;
;RecByte = Ser1Receive      'receive one byte - wait until detecting startbit
;Ser1Send  13               'new line in Terminal
;Ser1Send  10               '
;Ser1Print "You sent: "  'send a text
;Ser1Send RecByte           'send the sign representing the byte
;
;Loop
;Sub to resolve oscillator
;#startup Init
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,111
DMS_OUTER:
	ldi	DELAYTEMP,2
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
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Commence clearing any ANSELx variants in the part, if the ANSEL regsier/bit exists
;End  clearing ANSEL
;Turn off all ports
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
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
	cbi	PORTB,1
STX1ONE:
;brcs STx1Done                    ;jump to STxDone if Carry=1                   cycle 4,5
	brcs	STX1DONE
;Set SER1_TXPORT,SER1_TXPIN On  ;set pin HIGH if Carry=0 (translated to: cbi) cycle -
	sbi	PORTB,1
STX1DONE:
;--- start short delay --------
;ldi R24, STX1_DELAY            ;load delaycounter to register [ASM]          cycle 6
	ldi	R24, 40
STX1DELAY:
;delay-loop = (3 cycle * delaycounter) -1
;dec R24                        ;decrement delaycounter
	dec	R24
;brne STx1Delay                  ;loop to STxDelay until delaycounter=0
	brne	STX1DELAY
;--- end short delay ----------
;--- start long delay --------
;Sub_SerLongDelay(STX1_DELAYH)  ;process long delay
	ldi	SysValueCopy,2
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
	sbi	DDRB,1
;Set SER1_TXPORT.SER1_TXPIN On      '... set HIGH to make the first startbit recognizable
	sbi	PORTB,1
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

;Source: system.h (1300)
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Dim SysCalcTempX As Byte
;Get length
;lpm SysCalcTempA, Z+
;Instance 1
;added 0x4000 to address PROGMEM by setting the one bit
;SYSREADA_H.6  = 1
	sbr	 SYSREADA_H,1<<6
	ld	SysCalcTempX, z
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysStringReadCheck
	rjmp	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;lpm SysCalcTempA, Z+
;Instance 2
	ld	SysCalcTempX, z
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;cpi SysCalcTempA, 0
	cpi	SYSCALCTEMPA, 0
;brne SysStringRead
	brne	SYSSTRINGREAD
;ret
	ret
;Copy
SYSSTRINGREAD:
;Copy char
;lpm SysCalcTempX, Z+
;Instance 3
	ld	SysCalcTempX, z
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempX
	st	Y+, SYSCALCTEMPX
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringRead
	brne	SYSSTRINGREAD
	ret

;********************************************************************************

SysStringTables:

StringTable1:
.DB	19,80,108,101,97,115,101,32,115,101,110,100,32,97,32,98,121,116,101,33


StringTable2:
.DB	1,46


;********************************************************************************


