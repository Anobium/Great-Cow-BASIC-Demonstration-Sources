;Program compiled by Great Cow BASIC (0.98.<<>> 2020-06-02 (Windows 64 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18446, r=DEC
#include <P16F18446.inc>
 __CONFIG _CONFIG1, _FCMEN_ON & _CSWEN_ON & _CLKOUTEN_OFF & _RSTOSC_HFINT1 & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _STVREN_ON & _PPS1WAY_ON & _ZCDDIS_OFF & _BORV_LO & _BOREN_ON & _LPBOREN_OFF & _PWRTS_OFF & _MCLRE_ON
 __CONFIG _CONFIG3, _WDTCCS_SC & _WDTCWS_WDTCWS_7 & _WDTE_OFF & _WDTCPS_WDTCPS_31
 __CONFIG _CONFIG4, _LVP_ON & _WRTSAF_OFF & _WRTD_OFF & _WRTC_OFF & _WRTB_OFF & _WRTAPP_OFF & _SAFEN_OFF & _BBEN_OFF & _BBSIZE_BB512
 __CONFIG _CONFIG5, _CP_OFF

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
INC_VAL	EQU	32
INC_VAL_E	EQU	35
INC_VAL_H	EQU	33
INC_VAL_U	EQU	34
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116

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

;Start of the main program
;'' Great Cow BASIC demonstration
;''
;'' This demonstration a frequency generator with the a range of  0hz to  40000Hz(40kHz)
;''
;'' This program uses two CLC module, the NCO module, the CLKREF module to calculate the frequency and Timer6 for the duty.
;''
;''
;'' There is one yellow LED available on the MPLAB® Xpress PIC16F18446 board that can be turned ON
;'' and OFF.
;''
;''
;''@author  Evan R. Venn
;''@licence GPL
;''@version 1.00
;''@date    05/07/2020
;''********************************************************************
;PMD_Initialize();
	call	PMD_INITIALIZE
;PIN_MANAGER_Initialize();
	call	PIN_MANAGER_INITIALIZE
;TMR6_Initialize();
	call	TMR6_INITIALIZE
;CLC1_Initialize();
	call	CLC1_INITIALIZE
;NCO1_Initialize( 0 );
	clrf	INC_VAL
	clrf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;CLC2_Initialize();
	call	CLC2_INITIALIZE
;CLKREF_Initialize();
	call	CLKREF_INITIALIZE
;----- Main body of program commences here.
;40000 Hz = 0x0147AE
;NCO1_Initialize 0x0147AE
	movlw	174
	movwf	INC_VAL
	movlw	71
	movwf	INC_VAL_H
	movlw	1
	movwf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;Do
SysDoLoop_S1
;1Hz
;NCO1_Initialize 0x000003
	movlw	3
	movwf	INC_VAL
	clrf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;10Hz
;NCO1_Initialize 0x000015
	movlw	21
	movwf	INC_VAL
	clrf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;100hz
;NCO1_Initialize 0x0000D2
	movlw	210
	movwf	INC_VAL
	clrf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;1000 Hz
;NCO1_Initialize 0x000831
	movlw	49
	movwf	INC_VAL
	movlw	8
	movwf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;2000 Hz
;NCO1_Initialize 0x001062
	movlw	98
	movwf	INC_VAL
	movlw	16
	movwf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;5000 Hz
;NCO1_Initialize 0x0028F5
	movlw	245
	movwf	INC_VAL
	movlw	40
	movwf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;10000 Hz
;NCO1_Initialize 0x0051EC
	movlw	236
	movwf	INC_VAL
	movlw	81
	movwf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;20000 Hz
;NCO1_Initialize 0x00A3D7
	movlw	215
	movwf	INC_VAL
	movlw	163
	movwf	INC_VAL_H
	clrf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;40000 Hz
;NCO1_Initialize 0x0147AE
	movlw	174
	movwf	INC_VAL
	movlw	71
	movwf	INC_VAL_H
	movlw	1
	movwf	INC_VAL_U
	clrf	INC_VAL_E
	call	NCO1_INITIALIZE
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	call	Delay_S
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;Configuration bits: selected in the GUI
;CONFIG1
;CONFIG2
;CONFIG3
;CONFIG4
;CONFIG5
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: FrequencyGenerator_16F18xxx.gcb (178)
CLC1_INITIALIZE
;Set the CLC1 to the options selected in the User Interface
;LC1G1POL not_inverted; LC1G2POL inverted; LC1G3POL not_inverted; LC1G4POL inverted; LC1POL not_inverted;
;CLC1POL = 0x0A;
	movlw	10
	banksel	CLC1POL
	movwf	CLC1POL
;LC1D1S NCO1_OUT;
;CLC1SEL0 = 0x1A;
	movlw	26
	movwf	CLC1SEL0
;LC1D2S TMR6_OUT;
;CLC1SEL1 = 0x12;
	movlw	18
	movwf	CLC1SEL1
;LC1D3S CLC2_OUT;
;CLC1SEL2 = 0x21;
	movlw	33
	movwf	CLC1SEL2
;LC1D4S TMR6_OUT;
;CLC1SEL3 = 0x12;
	movlw	18
	movwf	CLC1SEL3
;LC1G1D3N disabled; LC1G1D2N disabled; LC1G1D4N disabled; LC1G1D1T enabled; LC1G1D3T disabled; LC1G1D2T disabled; LC1G1D4T disabled; LC1G1D1N disabled;
;CLC1GLS0 = 0x02;
	movlw	2
	movwf	CLC1GLS0
;LC1G2D2N disabled; LC1G2D1N disabled; LC1G2D4N disabled; LC1G2D3N disabled; LC1G2D2T disabled; LC1G2D1T disabled; LC1G2D4T disabled; LC1G2D3T disabled;
;CLC1GLS1 = 0x00;
	clrf	CLC1GLS1
;LC1G3D1N disabled; LC1G3D2N disabled; LC1G3D3N disabled; LC1G3D4N disabled; LC1G3D1T disabled; LC1G3D2T disabled; LC1G3D3T enabled; LC1G3D4T disabled;
;CLC1GLS2 = 0x20;
	movlw	32
	movwf	CLC1GLS2
;LC1G4D1N disabled; LC1G4D2N disabled; LC1G4D3N disabled; LC1G4D4N disabled; LC1G4D1T disabled; LC1G4D2T disabled; LC1G4D3T disabled; LC1G4D4T disabled;
;CLC1GLS3 = 0x00;
	clrf	CLC1GLS3
;LC1EN enabled; INTN disabled; INTP disabled; MODE 2-input D flip-flop with R;
;CLC1CON = 0x85;
	movlw	133
	movwf	CLC1CON
	banksel	STATUS
	return

;********************************************************************************

;Source: FrequencyGenerator_16F18xxx.gcb (230)
CLC2_INITIALIZE
;Set the CLC2 to the options selected in the User Interface
;LC2G1POL not_inverted; LC2G2POL not_inverted; LC2G3POL not_inverted; LC2G4POL not_inverted; LC2POL not_inverted;
;CLC2POL = 0x00;
	banksel	CLC2POL
	clrf	CLC2POL
;LC2D1S TMR6_OUT;
;CLC2SEL0 = 0x12;
	movlw	18
	movwf	CLC2SEL0
;LC2D2S CLC1_OUT;
;CLC2SEL1 = 0x20;
	movlw	32
	movwf	CLC2SEL1
;LC2D3S CLC1_OUT;
;CLC2SEL2 = 0x20;
	movlw	32
	movwf	CLC2SEL2
;LC2D4S CLC1_OUT;
;CLC2SEL3 = 0x20;
	movlw	32
	movwf	CLC2SEL3
;LC2G1D3N disabled; LC2G1D2N disabled; LC2G1D4N disabled; LC2G1D1T enabled; LC2G1D3T disabled; LC2G1D2T disabled; LC2G1D4T disabled; LC2G1D1N disabled;
;CLC2GLS0 = 0x02;
	movlw	2
	movwf	CLC2GLS0
;LC2G2D2N disabled; LC2G2D1N disabled; LC2G2D4N disabled; LC2G2D3N disabled; LC2G2D2T enabled; LC2G2D1T disabled; LC2G2D4T disabled; LC2G2D3T disabled;
;CLC2GLS1 = 0x08;
	movlw	8
	movwf	CLC2GLS1
;LC2G3D1N disabled; LC2G3D2N disabled; LC2G3D3N disabled; LC2G3D4N disabled; LC2G3D1T disabled; LC2G3D2T disabled; LC2G3D3T disabled; LC2G3D4T disabled;
;CLC2GLS2 = 0x00;
	clrf	CLC2GLS2
;LC2G4D1N disabled; LC2G4D2N disabled; LC2G4D3N disabled; LC2G4D4N disabled; LC2G4D1T disabled; LC2G4D2T disabled; LC2G4D3T disabled; LC2G4D4T disabled;
;CLC2GLS3 = 0x00;
	clrf	CLC2GLS3
;LC2EN enabled; INTN disabled; INTP disabled; MODE AND-OR;
;CLC2CON = 0x80;
	movlw	128
	movwf	CLC2CON
	banksel	STATUS
	return

;********************************************************************************

;Source: FrequencyGenerator_16F18xxx.gcb (256)
CLKREF_INITIALIZE
;CLKRCLK FOSC;
;CLKRCLK = 0x00;
	banksel	CLKRCLK
	clrf	CLKRCLK
;CLKRDC 50% Duty Cycle; CLKRDIV BaseClock/32; CLKREN enabled;
;CLKRCON = 0x95;
	movlw	149
	movwf	CLKRCON
	banksel	STATUS
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	14
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	189
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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

;Source: system.h (109)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;asm showdebug OSCCON type is default
;OSCCON1 = 0x60
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE
;asm showdebug The MCU is a chip family ChipFamily
;asm showdebug OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F18855 MCU family
;OSCFRQ = 0b00000110
	movlw	6
	movwf	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Commence clearing any ANSELx variants in the part, if the ANSEL regsier/bit exists
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;End  clearing ANSEL
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN
;C1EN = 0
	bcf	CM1CON0,C1EN
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

;Source: FrequencyGenerator_16F18xxx.gcb (206)
NCO1_INITIALIZE
;Set the NCO to the options selected in the GUI
;EN disabled; POL active_hi; PFM FDC_mode;
;NCO1CON = 0x00;
	banksel	NCO1CON
	clrf	NCO1CON
;CKS CLKR; PWS 1_clk;
;NCO1CLK = 0x06;
	movlw	6
	movwf	NCO1CLK
;
;NCO1ACCU = 0x00;
	clrf	NCO1ACCU
;
;NCO1ACCH = 0x00;
	clrf	NCO1ACCH
;
;NCO1ACCL = 0x00;
	clrf	NCO1ACCL
;
;NCO1INCU = [BYTE]INC_VAL_U
	banksel	INC_VAL_U
	movf	INC_VAL_U,W
	banksel	NCO1INCU
	movwf	NCO1INCU
;
;NCO1INCH = [BYTE]INC_VAL_H
	banksel	INC_VAL_H
	movf	INC_VAL_H,W
	banksel	NCO1INCH
	movwf	NCO1INCH
;
;NCO1INCL = [BYTE]INC_VAL
	banksel	INC_VAL
	movf	INC_VAL,W
	banksel	NCO1INCL
	movwf	NCO1INCL
;Enable NCO
;NCO1EN = 1
	bsf	NCO1CON,NCO1EN
	banksel	STATUS
	return

;********************************************************************************

;Source: FrequencyGenerator_16F18xxx.gcb (97)
PIN_MANAGER_INITIALIZE
;/**
;LATx registers
;
;LATA = 0x00;
	clrf	LATA
;LATB = 0x00;
	clrf	LATB
;LATC = 0x00;
	clrf	LATC
;/**
;TRISx registers
;
;TRISA = 0x3B;
	movlw	59
	movwf	TRISA
;TRISB = 0xF0;
	movlw	240
	movwf	TRISB
;TRISC = 0xF7;
	movlw	247
	movwf	TRISC
;/**
;ANSELx registers
;
;ANSELC = 0xFF;
	movlw	255
	banksel	ANSELC
	movwf	ANSELC
;ANSELB = 0xF0;
	movlw	240
	movwf	ANSELB
;ANSELA = 0x37;
	movlw	55
	movwf	ANSELA
;/**
;WPUx registers
;
;WPUB = 0x00;
	clrf	WPUB
;WPUA = 0x00;
	clrf	WPUA
;WPUC = 0x00;
	clrf	WPUC
;/**
;ODx registers
;
;ODCONA = 0x00;
	clrf	ODCONA
;ODCONB = 0x00;
	clrf	ODCONB
;ODCONC = 0x00;
	clrf	ODCONC
;/**
;SLRCONx registers
;
;SLRCONA = 0x37;
	movlw	55
	movwf	SLRCONA
;SLRCONB = 0xF0;
	movlw	240
	movwf	SLRCONB
;SLRCONC = 0xFF;
	movlw	255
	movwf	SLRCONC
;/**
;INLVLx registers
;
;INLVLA = 0x3F;
	movlw	63
	movwf	INLVLA
;INLVLB = 0xF0;
	movlw	240
	movwf	INLVLB
;INLVLC = 0xFF;
	movlw	255
	movwf	INLVLC
;RC3PPS = 0x02;   //RC3->CLC2:CLC2OUT;
	movlw	2
	movwf	RC3PPS
;RA2PPS = 0x01;   //RA2->CLC1:CLC1OUT;
	movlw	1
	movwf	RA2PPS
	banksel	STATUS
	return

;********************************************************************************

;Source: FrequencyGenerator_16F18xxx.gcb (77)
PMD_INITIALIZE
;CLKRMD CLKR enabled; SYSCMD SYSCLK enabled; FVRMD FVR enabled; IOCMD IOC enabled; NVMMD NVM enabled;
;PMD0 = 0x00;
	banksel	PMD0
	clrf	PMD0
;TMR0MD TMR0 enabled; TMR1MD TMR1 enabled; TMR4MD TMR4 enabled; TMR5MD TMR5 enabled; TMR2MD TMR2 enabled; TMR3MD TMR3 enabled; TMR6MD TMR6 enabled;
;PMD1 = 0x00;
	clrf	PMD1
;NCO1MD NCO1 enabled;
;PMD2 = 0x00;
	clrf	PMD2
;ZCDMD ZCD enabled; CMP1MD CMP1 enabled; ADCMD ADC enabled; CMP2MD CMP2 enabled; DAC1MD DAC1 enabled;
;PMD3 = 0x00;
	clrf	PMD3
;CCP2MD CCP2 enabled; CCP1MD CCP1 enabled; CCP4MD CCP4 enabled; CCP3MD CCP3 enabled; PWM6MD PWM6 enabled; PWM7MD PWM7 enabled;
;PMD4 = 0x00;
	clrf	PMD4
;CWG2MD CWG2 enabled; CWG1MD CWG1 enabled;
;PMD5 = 0x00;
	clrf	PMD5
;U1MD EUSART1 enabled; MSSP1MD MSSP1 enabled; MSSP2MD MSSP2 enabled;
;PMD6 = 0x00;
	clrf	PMD6
;CLC3MD CLC3 enabled; CLC4MD CLC4 enabled; DSM1MD DSM enabled; SMT1MD SMT1 enabled; CLC1MD CLC1 enabled; CLC2MD CLC2 enabled;
;PMD7 = 0x00;
	clrf	PMD7
	banksel	STATUS
	return

;********************************************************************************

;Source: FrequencyGenerator_16F18xxx.gcb (153)
TMR6_INITIALIZE
;Set TMR6 to the options selected in the User Interface
;T6CS CLKR;
;T6CLKCON = 0x08;
	movlw	8
	banksel	T6CLKCON
	movwf	T6CLKCON
;T6PSYNC Not Synchronized; T6MODE Starts at T6ON = 1 and TMR6_ers = 1; T6CKPOL Rising Edge; T6CKSYNC Synchronized;
;T6HLT = 0x21;
	movlw	33
	movwf	T6HLT
;T6RSEL CLC1_out;
;T6RST = 0x0D;
	movlw	13
	movwf	T6RST
;T6PR 9;
;T6PR = 0x09;
	movlw	9
	movwf	T6PR
;TMR6 0;
;T6TMR = 0x00;
	clrf	T6TMR
;Clearing IF flag.
;TMR6IF = 0;
	banksel	PIR4
	bcf	PIR4,TMR6IF
;T6CKPS 1:1; T6OUTPS 1:1; TMR6ON on;
;T6CON = 0x80;
	movlw	128
	banksel	T6CON
	movwf	T6CON
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144
;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
