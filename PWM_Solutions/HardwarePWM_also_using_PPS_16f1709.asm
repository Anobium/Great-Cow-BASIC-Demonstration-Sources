;Program compiled by Great Cow BASIC (0.98.<<>> 2020-02-15 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1709, r=DEC
#include <P16F1709.inc>
 __CONFIG _CONFIG1, _CLKOUTEN_OFF & _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
BRIGHT	EQU	32
CCPCONCACHE	EQU	33
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
PRX_TEMP	EQU	34
PRX_TEMP_E	EQU	37
PRX_TEMP_H	EQU	35
PRX_TEMP_U	EQU	36
PWMCHANNEL	EQU	38
PWMDUTY	EQU	39
PWMDUTY_H	EQU	40
PWMFREQ	EQU	41
PWMRESOLUTION	EQU	42
PWMRESOLUTION_H	EQU	43
SYSBYTETEMPX	EQU	112
SYSDIVLOOP	EQU	116
SYSLONGDIVMULTA	EQU	44
SYSLONGDIVMULTA_E	EQU	47
SYSLONGDIVMULTA_H	EQU	45
SYSLONGDIVMULTA_U	EQU	46
SYSLONGDIVMULTB	EQU	48
SYSLONGDIVMULTB_E	EQU	51
SYSLONGDIVMULTB_H	EQU	49
SYSLONGDIVMULTB_U	EQU	50
SYSLONGDIVMULTX	EQU	52
SYSLONGDIVMULTX_E	EQU	55
SYSLONGDIVMULTX_H	EQU	53
SYSLONGDIVMULTX_U	EQU	54
SYSLONGTEMPA	EQU	117
SYSLONGTEMPA_E	EQU	120
SYSLONGTEMPA_H	EQU	118
SYSLONGTEMPA_U	EQU	119
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_E	EQU	124
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSLONGTEMPX	EQU	112
SYSLONGTEMPX_E	EQU	115
SYSLONGTEMPX_H	EQU	113
SYSLONGTEMPX_U	EQU	114
SYSTEMP1	EQU	56
SYSTEMP1_E	EQU	59
SYSTEMP1_H	EQU	57
SYSTEMP1_U	EQU	58
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
TIMERSELECTIONBITS	EQU	60
TX_PR	EQU	61
_PWMTIMERSELECTED	EQU	62

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITPWM

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program ia a demonstration of Hardare PWM, but, this also shows how to use PPS.
;''The PWM is set to be on PortA.0, you can choose but in this demo you can easily change this to portc.5 by changing the commands.
;'':
;''@author  EvanV
;''@licence GPL
;''@version 1.0a
;''@date    02.12.2015
;''********************************************************************************
;----- Configuration
;Set the PPS of the PWM and the RS232 ports.
;Intoff
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x00  'unlock PPS
	bcf	PPSLOCK,PPSLOCKED
;RC5PPS = 0x0C     'RC5->CCP1:CCP1
;RA0PPS = 0x0C;     'RA0->CCP1:CCP1
	movlw	12
	banksel	RA0PPS
	movwf	RA0PPS
;RXPPS=0x0D        'Peripheral input is RB5
	movlw	13
	banksel	RXPPS
	movwf	RXPPS
;RB7PPS=0x14       'Pin RB7 source is TX/CK
	movlw	20
	banksel	RB7PPS
	movwf	RB7PPS
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x01  'lock PPS
	bsf	PPSLOCK,PPSLOCKED
;DIR PORTC.5 out
	banksel	TRISC
	bcf	TRISC,5
;DIR PORTA.0 out
	bcf	TRISA,0
;----- Variables
;Dim BRIGHT as Byte
;----- Main body of program commences here.
;do
SysDoLoop_S1
;Turn up brightness over 2.5 seconds
;For Bright = 0 to 255
	movlw	255
	banksel	BRIGHT
	movwf	BRIGHT
SysForLoop1
	incf	BRIGHT,F
;HPWM 1, 40, Bright
	movlw	1
	movwf	PWMCHANNEL
	movlw	40
	movwf	PWMFREQ
	movf	BRIGHT,W
	movwf	PWMDUTY
	clrf	PWMDUTY_H
	call	HPWM22
	movf	PWMDUTY,W
	movwf	BRIGHT
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;next
	movlw	255
	subwf	BRIGHT,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Turn down brightness over 2.5 seconds
;For Bright = 255 to 0
	clrf	BRIGHT
SysForLoop2
	decf	BRIGHT,F
;HPWM 1, 40, Bright
	movlw	1
	movwf	PWMCHANNEL
	movlw	40
	movwf	PWMFREQ
	movf	BRIGHT,W
	movwf	PWMDUTY
	clrf	PWMDUTY_H
	call	HPWM22
	movf	PWMDUTY,W
	movwf	BRIGHT
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;next
	movf	BRIGHT,W
	sublw	0
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	142
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	1
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:BYTE:, Source: pwm.h (2688)
HPWM22
;Dim PRx_Temp as LONG
;Dim PRx_Temp_Cache as Long
;dim PWMDuty as word
;dim PWMResolution as word: PWMResolution = 255
	movlw	255
	movwf	PWMRESOLUTION
	clrf	PWMRESOLUTION_H
;If HPWM_FAST operation selected, only recalculate timer prescaler when
;needed. Gives faster operation, but uses extra byte of RAM and may cause
;problems if HPWM and PWMOn are used together in a program.
;(No issues using HPWM and PWMOff in the same program with HPWM_FAST.)
;Commence calculations of PMW parameters
;This figures out Postscaler required.  We can set to 1, 4 or 16 to set Tx_PR
;So, start with 1 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 4
;So, using 4 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 16
;So, using 16
;This simply set Tx_PR to 1,4 or 16
;Tx_PR = 1
	movlw	1
	movwf	TX_PR
;PRx_Temp = PWMOsc1 / PWMFreq
	movlw	232
	movwf	SysLONGTempA
	movlw	3
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	PWMFREQ,W
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempA,W
	movwf	PRX_TEMP
	movf	SysLONGTempA_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempA_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempA_E,W
	movwf	PRX_TEMP_E
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF3
;Tx_PR = 4
	movlw	4
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF3
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF4
;Tx_PR = 16
	movlw	16
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF4
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF5
;Tx_PR = 64
	movlw	64
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF5
;added to handle different timer sources
;added to support HPWM_CCPTimerN. Makes the code longer but more flexible
;user optimisation to reduce code.
CCPPWMSETUPCLOCKSOURCE
;select case _PWMTimerSelected
;case 2:
SysSelect1Case1
	movlw	2
	subwf	_PWMTIMERSELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;PR2 = PRx_Temp
	movf	PRX_TEMP,W
	movwf	PR2
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T2CKPS0 OFF
	bcf	T2CON,T2CKPS0
;SET T2CKPS1 OFF
	bcf	T2CON,T2CKPS1
;Set Prescaler bits
;if Tx_PR = 4  then SET T2CKPS0 ON
	movlw	4
	subwf	TX_PR,W
	btfsc	STATUS, Z
	bsf	T2CON,T2CKPS0
;if Tx_PR = 16 then SET T2CKPS1 ON
	movlw	16
	subwf	TX_PR,W
	btfsc	STATUS, Z
	bsf	T2CON,T2CKPS1
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T2CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T2CKPS0 ON: SET T2CKPS1 ON
	movlw	64
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF8
	bsf	T2CON,T2CKPS0
	bsf	T2CON,T2CKPS1
ENDIF8
;Set Clock Source, if required
;case 4:
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	4
	subwf	_PWMTIMERSELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;PR4 = PRx_Temp
	movf	PRX_TEMP,W
	banksel	PR4
	movwf	PR4
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T4CKPS0 OFF
	bcf	T4CON,T4CKPS0
;SET T4CKPS1 OFF
	bcf	T4CON,T4CKPS1
;Set Prescaler bits
;if Tx_PR = 4  then SET T4CKPS0 ON
	movlw	4
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF9
	banksel	T4CON
	bsf	T4CON,T4CKPS0
ENDIF9
;if Tx_PR = 16 then SET T4CKPS1 ON
	movlw	16
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF10
	banksel	T4CON
	bsf	T4CON,T4CKPS1
ENDIF10
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T4CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T4CKPS0 ON: SET T4CKPS1 ON
	movlw	64
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF11
	banksel	T4CON
	bsf	T4CON,T4CKPS0
	bsf	T4CON,T4CKPS1
ENDIF11
;Set Clock Source, if required
;case 6:
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	6
	subwf	_PWMTIMERSELECTED,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;PR6 = PRx_Temp
	movf	PRX_TEMP,W
	banksel	PR6
	movwf	PR6
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T6CKPS0 OFF
	bcf	T6CON,T6CKPS0
;SET T6CKPS1 OFF
	bcf	T6CON,T6CKPS1
;Set Prescaler bits
;if Tx_PR = 4  then SET T6CKPS0 ON
	movlw	4
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF12
	banksel	T6CON
	bsf	T6CON,T6CKPS0
ENDIF12
;if Tx_PR = 16 then SET T6CKPS1 ON
	movlw	16
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF13
	banksel	T6CON
	bsf	T6CON,T6CKPS1
ENDIF13
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T6CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T6CKPS0 ON: SET T6CKPS1 ON
	movlw	64
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF14
	banksel	T6CON
	bsf	T6CON,T6CKPS0
	bsf	T6CON,T6CKPS1
ENDIF14
;Set Clock Source, if required
;end Select
SysSelectEnd1
END_OF_CCPPWMSETUPCLOCKSOURCE
;this code can be optimised by using defines USE_HPWMCCP1|2|3|4|5
;and, you can define user setup and exit commands using AddHPWMCCPSetupN and  AddHPWMCCPExitN
;These can be used to FIX little errors!
SETUPTHECORRECTTIMERBITS
;ChipPWMTimerVariant some chips have variants on CCPTMRS0
;TimerSelectionBits =  (_PWMTimerSelected / 2 )-1
	bcf	STATUS,C
	banksel	_PWMTIMERSELECTED
	rrf	_PWMTIMERSELECTED,W
	movwf	SysTemp1
	decf	SysTemp1,W
	movwf	TIMERSELECTIONBITS
SETUPCCPPWMREGISTERS
;C1TSEL0 = TimerSelectionBits.0
	banksel	CCPTMRS
	bcf	CCPTMRS,C1TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF19
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL0
ENDIF19
;C1TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C1TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF20
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL1
ENDIF20
;Devices with more than one CCP
;if PWMChannel = 1 then
	banksel	PWMCHANNEL
	decf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF15
;ifndef BIT(CCP1FMT) Testing this bit is to identify the 2016 chip that use CCPR1H and CCPR1L for PWM
;PRx_Temp = PWMDuty * (PRx_Temp + 2)  'Correction
	movlw	2
	addwf	PRX_TEMP,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRX_TEMP_H,W
	movwf	SysTemp1_H
	movlw	0
	addwfc	PRX_TEMP_U,W
	movwf	SysTemp1_U
	movlw	0
	addwfc	PRX_TEMP_E,W
	movwf	SysTemp1_E
	movf	PWMDUTY,W
	movwf	SysLONGTempA
	movf	PWMDUTY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SysTemp1,W
	movwf	SysLONGTempB
	movf	SysTemp1_H,W
	movwf	SysLONGTempB_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempB_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	PRX_TEMP
	movf	SysLONGTempX_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	PRX_TEMP_E
;CCPR1L = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	CCPR1L
	movwf	CCPR1L
;If PWMDuty = 0 Then CCPR1L = 0  ' Assure OFF at Zero
	banksel	PWMDUTY
	movf	PWMDUTY,W
	movwf	SysWORDTempA
	movf	PWMDUTY_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF17
	banksel	CCPR1L
	clrf	CCPR1L
ENDIF17
;SET CCP1M3 ON
	banksel	CCP1CON
	bsf	CCP1CON,CCP1M3
;SET CCP1M2 ON
	bsf	CCP1CON,CCP1M2
;SET CCP1M1 OFF
	bcf	CCP1CON,CCP1M1
;SET CCP1M0 OFF
	bcf	CCP1CON,CCP1M0
;C1TSEL0 = TimerSelectionBits.0
	bcf	CCPTMRS,C1TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF21
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL0
ENDIF21
;C1TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C1TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF22
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL1
ENDIF22
;end if
ENDIF15
;if PWMChannel = 2 then
	movlw	2
	banksel	PWMCHANNEL
	subwf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF16
;PRx_Temp = PWMDuty * ( PRx_Temp + 2)  'Correction
	movlw	2
	addwf	PRX_TEMP,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRX_TEMP_H,W
	movwf	SysTemp1_H
	movlw	0
	addwfc	PRX_TEMP_U,W
	movwf	SysTemp1_U
	movlw	0
	addwfc	PRX_TEMP_E,W
	movwf	SysTemp1_E
	movf	PWMDUTY,W
	movwf	SysLONGTempA
	movf	PWMDUTY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SysTemp1,W
	movwf	SysLONGTempB
	movf	SysTemp1_H,W
	movwf	SysLONGTempB_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempB_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	PRX_TEMP
	movf	SysLONGTempX_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	PRX_TEMP_E
;CCPR2L = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	CCPR2L
	movwf	CCPR2L
;If PWMDuty = 0 Then CCPR2L = 0  ' Assure OFF at Zero
	banksel	PWMDUTY
	movf	PWMDUTY,W
	movwf	SysWORDTempA
	movf	PWMDUTY_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF18
	banksel	CCPR2L
	clrf	CCPR2L
ENDIF18
;SET CCP2M3 ON
	banksel	CCP2CON
	bsf	CCP2CON,CCP2M3
;SET CCP2M2 ON
	bsf	CCP2CON,CCP2M2
;SET CCP2M1 OFF
	bcf	CCP2CON,CCP2M1
;SET CCP2M0 OFF
	bcf	CCP2CON,CCP2M0
;C2TSEL0 = TimerSelectionBits.0
	bcf	CCPTMRS,C2TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF23
	banksel	CCPTMRS
	bsf	CCPTMRS,C2TSEL0
ENDIF23
;C2TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C2TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF24
	banksel	CCPTMRS
	bsf	CCPTMRS,C2TSEL1
ENDIF24
;end if
ENDIF16
	banksel	STATUS
	return

;********************************************************************************

;Source: pwm.h (188)
INITPWM
;_PWMTimerSelected = 2
	movlw	2
	movwf	_PWMTIMERSELECTED
;Dim PRx_Temp as LONG
;Script to calculate constants required for given Frequency and Duty Cycle
LEGACY_STARTOFFIXEDCCPPWMMODECODE
;You can disable all the legacy CCPPWM fixed mode code to reduce program size
;This section is Library code, so it generates ASM
;This section uses the constants defined the script above.
;Essentially, sets CCPCONCache with the bits set correctly.
;And, timer 2.  Remember timer 2 can be the timer for CCP/PWM but the other timers can be specified for certain parts.
;If CCP1CON does not exist then there is NO CCP1 so no point in setting, as all this is to set up the CCP1 using constants method
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	clrf	CCPCONCACHE
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	movlw	26
	movwf	PR2
;SET T2CON.T2CKPS0 OFF
	bcf	T2CON,T2CKPS0
;SET T2CON.T2CKPS1 OFF
	bcf	T2CON,T2CKPS1
;Set Duty cycle
;This is the legacy code to support only one CCPPWM channel
;CCPR1L = DutyCycleH
	movlw	13
	banksel	CCPR1L
	movwf	CCPR1L
;SET CCPCONCache.CCP1Y OFF
	banksel	CCPCONCACHE
	bcf	CCPCONCACHE,CCP1Y
;SET CCPCONCache.CCP1X ON
	bsf	CCPCONCACHE,CCP1X
;SET CCPCONCache.DC1B1 ON
	bsf	CCPCONCACHE,DC1B1
;SET CCPCONCache.DC1B0 OFF
	bcf	CCPCONCACHE,DC1B0
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	bsf	CCPCONCACHE,CCP1M3
	bsf	CCPCONCACHE,CCP1M2
	bcf	CCPCONCACHE,CCP1M1
	bcf	CCPCONCACHE,CCP1M0
;Enable Timer 2
;SET T2CON.TMR2ON ON
	bsf	T2CON,TMR2ON
;This is the end of script section, now we use the constants created to updated registers.
STARTOFFIXEDPWMMODECODE
;Set registers using the constants from script
;This is repeated for timer 2, 4 and 6 - and the two timer variants and the 9 PWM channels
;This uses the user defined constants to set the appropiate registers.
SETPWMDUTYCODE
;This section finally, sets the Duty using the constants from the script.
;This uses the user defined constants to set the appropiate registers.
REV2018_ENDOFFIXEDPWMMODECODE
;This is the end of the fixed PWM Mode handler
	return

;********************************************************************************

;Source: system.h (110)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;this code block sets the internal oscillator to 4
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;equates to OSCCON = OSCCON AND b'10000111' & OSCCON = OSCCON OR b'01101000'
;= 4Mhz
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 Off
	bcf	OSCCON,IRCF1
;Set IRCF0 On
	bsf	OSCCON,IRCF0
;Set SPLLEN Off
	bcf	OSCCON,SPLLEN
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;_complete_the_chip_setup_of_bsr,adcs,ansel_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;End clearing any ANSEL variants in the part
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
	return

;********************************************************************************

;Source: system.h (2703)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2757)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2932)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2597)
SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysCompEqual32
	btfss	SysByteTempX,0
	goto	ENDIF27
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF27
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	subwfb	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	subwfb	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	subwfb	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF28
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;End If
ENDIF28
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (2393)
SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF25
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
ENDIF25
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	call	SysCompLessThan32
	btfsc	SysByteTempX,0
	goto	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
