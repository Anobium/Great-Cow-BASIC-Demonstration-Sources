;Program compiled by Great Cow BASIC (0.98.<<>> 2018-10-20 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F25K50, r=DEC
#include <P18F25K50.inc>
 CONFIG LVP = OFF, MCLRE = OFF, WDTEN = OFF, FOSC = INTOSCIO, CPUDIV = NOCLKDIV

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT	EQU	10
COMPORT	EQU	11
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
GCBBUILDSTR	EQU	1901
GCBBUILDTIMESTR	EQU	1944
HEX	EQU	1897
HSERPRINTCRLFCOUNT	EQU	12
MEMDATA	EQU	13
OUTVALUETEMP	EQU	16
PEEK	EQU	17
PRINTLEN	EQU	18
READAD10	EQU	19
READAD10_H	EQU	21
SAVEDELAYTEMP2	EQU	22
SAVEFSR0H	EQU	23
SAVEFSR0L	EQU	24
SAVEFSR1H	EQU	25
SAVEFSR1L	EQU	26
SAVESYSBYTETEMPA	EQU	27
SAVESYSBYTETEMPB	EQU	28
SAVESYSBYTETEMPX	EQU	29
SAVESYSDIVLOOP	EQU	30
SAVESYSSTRINGA	EQU	31
SAVESYSSTRINGLENGTH	EQU	32
SAVESYSTEMP1	EQU	33
SAVESYSTEMP1_H	EQU	34
SAVESYSTEMP2	EQU	35
SAVESYSWAITTEMPMS	EQU	36
SAVESYSWAITTEMPMS_H	EQU	37
SERDATA	EQU	38
SERPRINTVAL	EQU	39
STRINGPOINTER	EQU	40
SYSBSR	EQU	41
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPX	EQU	0
SYSDIVLOOP	EQU	4
SYSPRINTDATAHANDLER	EQU	42
SYSPRINTDATAHANDLER_H	EQU	43
SYSPRINTTEMP	EQU	44
SYSREPEATTEMP1	EQU	45
SYSSTATUS	EQU	15
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	1917
SYSSTRINGPARAM2	EQU	1907
SYSSTRINGTEMP	EQU	46
SYSTEMP1	EQU	47
SYSTEMP1_H	EQU	48
SYSTEMP2	EQU	49
SYSVALTEMP	EQU	50
SYSW	EQU	14
SYSWAITTEMP10US	EQU	5
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
USBBMREQUESTTYPE	EQU	51
USBBUFFERSTAT	EQU	52
USBCURRBYTE	EQU	53
USBCURRCONFIGURATION	EQU	54
USBCURRENDPOINT	EQU	55
USBDESCINDEX	EQU	56
USBDESCSIZEIN	EQU	57
USBDESCSTART	EQU	58
USBDESCTYPE	EQU	59
USBHASDATA	EQU	60
USBLASTCONTROL	EQU	61
USBNEWADDRESS	EQU	62
USBPID	EQU	63
USBRAM	EQU	1024
USBSIZE	EQU	64
USBSTATE	EQU	65
USBTEMPBUFFER	EQU	1927
USBTEMPBYTE	EQU	66
USBTEMPSTRING	EQU	2005
USB_CNT_POINTER	EQU	67
VERSIONSTRING	EQU	1964
_USBINVALUE	EQU	68
_USBINVALUE_H	EQU	69

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
MEMADR	EQU	4073
MEMADR_H	EQU	4074
SYSHEX_0	EQU	1897
SYSHEX_1	EQU	1898
SYSHEX_2	EQU	1899
SYSREADAD10WORD	EQU	19
SYSREADAD10WORD_H	EQU	21
SYSUSBTEMPBUFFER_0	EQU	1927
SYSUSBTEMPBUFFER_1	EQU	1928
SYSUSBTEMPBUFFER_2	EQU	1929
SYSUSBTEMPBUFFER_3	EQU	1930
SYSUSBTEMPBUFFER_6	EQU	1933
SYSUSBTEMPSTRING_0	EQU	2005
USBREQUEST	EQU	1928
USB_IN0_ADDR	EQU	1030
USB_IN0_ADDR_H	EQU	1031
USB_IN0_CNT	EQU	1029
USB_IN0_STAT	EQU	1028
USB_OUT0_ADDR	EQU	1026
USB_OUT0_ADDR_H	EQU	1027
USB_OUT0_CNT	EQU	1025
USB_OUT0_STAT	EQU	1024

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	bra	INTERRUPT

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUSART
	rcall	INITUSB
;Enable interrupts
	bsf	INTCON,GIE,ACCESS
	bsf	INTCON,PEIE,ACCESS

;Start of the main program
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''
;''Demonstration of the Great Cow BASIC capabilities for LibK/WinUSB library
;''
;''Connect the 18f25K50 to the USB
;''  D- to portc.4
;''  D+ to portc.5
;''  Cap between port.c3 and 0V
;''  You can provide supply voltage via the USB, or, you can prpoved local voltage.
;''
;'' LEDs to ports c.7, b.5 and b.4 via suitable resistors.  They are KeepAlive LED and two LEDs for remote control
;'' POTS to ports a.0, a.1, a.3 and a.3,  you will read those remotely
;'' A serrial terminal at 115200bps can be connected to portc.6
;''
;'' Use the Windows application to control!
;''
;''
;''
;''
;''This program is the very first program for Great Cow BASICUSB
;''
;''@author     HughC and EvanV
;''@licence    GPL
;''@version    1.0
;''@date       29/10/2018
;''********************************************************************************
;----- Configuration
;----- Constants for the usb.h
;Define a name - 30 chars max long
;#define USB_PRODUCT_NAME versionString
;#define USB_PRODUCT_NAME  "CDC USB v1.4.2"
;#define USB_VID 0x04D8      'Should not be changed unless you have your own Vendor Identity - this VID is allocate to Great Cow BASIC Lib/WinUSB Solutions.
;#define USB_PID 0x000A      'Should not be changed unless you have your own Vendor Identity - this PID is allocate to Great Cow BASIC Lib/WinUSB Solutions.
;#define USB_REV 0x0001      'You MUST obtain a REV number from https://github.com/Anobium/GreatCowBASICpidcodes1209_2006 to develop your own Open Source USB solutions
;#define USBDeviceReadPortb5LEDStatus  130
;#define USBDeviceSetPortb5StatusOn    131
;#define USBDeviceSetPortb5StatusOff   132
;#define USBDeviceReadADCValues        133
;#define USBDeviceReadPortb4LEDStatus  134
;#define USBDeviceSetPortb4StatusOn    135
;#define USBDeviceSetPortb4StatusOff   136
;------ Version Control - optional
;Include the GCBVersionNumber.cnt to increment versionString and create the build time string called GCBBuildTimeStr.
;versionString a string is created automatically.
;GCBBuildTimeStr is a string that is also created automatically.
;use "GCBVersionNumber.cnt" as this will create a local copy of the versionString tracker.
;if you use <GCBVersionNumber.cnt> this is a system wide versionString tracker.
;dim versionString as string * 40
;versionString = "Build"+GCBBuildStr
	rcall	FN_GCBBUILDSTR
	lfsr	1,VERSIONSTRING
	clrf	SysStringLength,ACCESS
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,GCBBUILDSTR
	rcall	SysCopyStringPart
	lfsr	0,VERSIONSTRING
	movff	SysStringLength, INDF0
;versionString = versionString + "@"+GCBBuildTimeStr
	rcall	FN_GCBBUILDTIMESTR
	lfsr	1,VERSIONSTRING
	clrf	SysStringLength,ACCESS
	lfsr	0,VERSIONSTRING
	rcall	SysCopyStringPart
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,GCBBUILDTIMESTR
	rcall	SysCopyStringPart
	lfsr	0,VERSIONSTRING
	movff	SysStringLength, INDF0
;HSerPrint "USB CGB  "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT273
;HSerPrint versionString
	movlw	low VERSIONSTRING
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high VERSIONSTRING
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT273
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;------ End of Version Control - optional
;Define USB specific callback handlers
;MANDATED to handle you solution
;#define USB_SETUP_HANDLER           SetupHandler_CallBack
;optional callback handlers for error and descriptor call.
;#define USB_ERROR_HANDLER           ErrorHandler_CallBack
;#define USB_DESCRIPTOR_HANDLER      DescriptorHandler_CallBack
;Solution specific configuration
;----- Define Hardware settings
;USART
;#define USART_BAUD_RATE 115200
;#define USART_BLOCKING
;ADC
;#define ADSpeed LowSpeed
;------ Ports
;Dir PORTB.4 out
	bcf	TRISB,4,ACCESS
;Dir PORTB.5 out
	bcf	TRISB,5,ACCESS
;Dir PORTc.7 out
	bcf	TRISC,7,ACCESS
;----- Main body of program commences here
;Do
SysDoLoop_S1
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
;----- Support methods.  User call backs
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

DESCRIPTORHANDLER_CALLBACK
;HSerPrint "Desc: "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT273
;HSerPrint USBDescType
	movff	USBDESCTYPE,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT274
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	bra	HSERPRINTCRLF

;********************************************************************************

Delay_10US
D10US_START
	movlw	39
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	179
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	21
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

ERRORHANDLER_CALLBACK
;HSerPrint "Error: "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT273
;HSerPrint Hex(UEIR)
	movff	UEIR,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT273
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	bra	HSERPRINTCRLF

;********************************************************************************

FN_GCBBUILDSTR
;GCBBuildStr="10"
	lfsr	1,GCBBUILDSTR
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	bra	SysReadString

;********************************************************************************

FN_GCBBUILDTIMESTR
;GCBBuildTimeStr="10-30-2018 21:08:27"
	lfsr	1,GCBBUILDTIMESTR
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	bra	SysReadString

;********************************************************************************

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0,BANKED
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF48
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF48
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop7
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
ENDIF49
SysForLoopEnd7
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF50
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF50
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT273
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF34
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
ENDIF35
SysForLoop6
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND
;next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
ENDIF36
SysForLoopEnd6
;End If
ENDIF34
;CR
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT274
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF51
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;End If
ENDIF51
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	movff	SysByteTempX,SysTemp2
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp2,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF52
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;End If
ENDIF52
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;CR
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;end Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

HSERSEND
;Block before sending (if needed)
;Send byte
;Registers/Bits determined by #samevar at top of file
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
;HSerSendBlocker
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop3
;asm showdebug TXREG equals SerData below will assign SerData to TXREG or TXREG1 or U1TXB  via the #samevar
;txreg equals serdata below will assign serdata to txreg | txreg1 | txreg via the #samevar
;
;TXREG = SerData
	movff	SERDATA,TXREG
;Add USART_DELAY After all bits are shifted out
;Wait until TRMT = 1
SysWaitLoop4
	btfss	TXSTA,TRMT,ACCESS
	bra	SysWaitLoop4
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;exit sub
	return
;end if
ENDIF33
	return

;********************************************************************************

INITSYS
;The section now handles two true table for frequency
;Supports 18f2425 (type1 max frq of 8mhz) classes and 18f26k22 (type2 max frq of 16mhz) classes
;Assumes that testing the ChipMaxMHz >= 48 is a valid test for type2 microcontrollers
;Supports IntOsc MaxMhz of 64 and not 64 ... there may be others true tables that GCB needs to support
;asm showdebug OSCCON type is 104' NoBit(SPLLEN) And NoBit(IRCF3) Or Bit(INTSRC)) and ifdef Bit(HFIOFS)
;osccon type is 104
;asm showdebug The chip mhz is 48, therefore probably an 18f USB part
;the chip mhz is 48, therefore probably an 18f usb part
;[canskip] IRCF2, IRCF1, IRCF0 = b'111'   ;'111' for ChipMHz 48
	bsf	OSCCON,IRCF2,ACCESS
	bsf	OSCCON,IRCF1,ACCESS
	bsf	OSCCON,IRCF0,ACCESS
;Set SPLLMULT On
	bsf	OSCTUNE,SPLLMULT,ACCESS
;Set PLLEN On
	bsf	OSCCON2,PLLEN,ACCESS
;Wait for PLL to stabilize
;wait while (PLLRDY = 0)
SysWaitLoop2
	btfss	OSCCON2,PLLRDY,ACCESS
	bra	SysWaitLoop2
;Clear BSR on 18F chips
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;End clearing any ANSEL variants in the part
;Comparator register bits for 12F510,16F506, PIC16F1535 classes
;C2ON = 0
	bcf	CM2CON0,C2ON,ACCESS
;C1ON = 0
	bcf	CM1CON0,C1ON,ACCESS
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

INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	movlw	103
	movwf	SPBRG,ACCESS
;SPBRGH = SPBRGH_TEMP
	clrf	SPBRGH,ACCESS
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16,ACCESS
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH,ACCESS
;Enable async mode
;Set SYNC Off
	bcf	TXSTA,SYNC,ACCESS
;SPEN=1
	bsf	RCSTA,SPEN,ACCESS
;Enable TX and RX
;CREN=1
	bsf	RCSTA,CREN,ACCESS
;Set TXEN On
	bsf	TXSTA,TXEN,ACCESS
;PIC USART 2 Init
	return

;********************************************************************************

INITUSB
;Time for PLL to stabilise
;Wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Add interrupt handlers
;UIE = 127
	movlw	127
	movwf	UIE,ACCESS
;UEIE = b'10011111'
	movlw	159
	movwf	UEIE,ACCESS
;On Interrupt USB Call USBInterruptHandler
	bsf	PIE3,USBIE,ACCESS
;Set up USB module
;Set UCFG.FSEN On
	bsf	UCFG,FSEN,ACCESS
;Set UCFG.UTRDIS Off
	bcf	UCFG,UTRDIS,ACCESS
;Set UCFG.UPUEN On
	bsf	UCFG,UPUEN,ACCESS
;USBResetEndpoints
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S2
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E2
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;Disable endpoints
;UEP0 = 0
	clrf	UEP0,ACCESS
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	movwf	USB_IN0_ADDR,BANKED
	movlw	4
	movwf	USB_IN0_ADDR_H,BANKED
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	4
	movwf	USB_OUT0_ADDR_H,BANKED
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;UEP0 = b'00010110'
	movlw	22
	movwf	UEP0,ACCESS
;Clear interrupt flags
;UIR = 0
	clrf	UIR,ACCESS
;UEIR = 0
	clrf	UEIR,ACCESS
;UADDR = 0
	clrf	UADDR,ACCESS
;USBState = USB_STATE_POWERED
	banksel	USBSTATE
	clrf	USBSTATE,BANKED
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION,BANKED
;Enable
;Set UCON.USBEN On
	bsf	UCON,USBEN,ACCESS
	return

;********************************************************************************

Interrupt
;Save Context
	movff	WREG,SysW
	movff	STATUS,SysSTATUS
	movff	BSR,SysBSR
;Store system variables
	movff	SysTemp1,SaveSysTemp1
	movff	SysByteTempA,SaveSysByteTempA
	movff	SysByteTempB,SaveSysByteTempB
	movff	FSR0L,SaveFSR0L
	movff	FSR0H,SaveFSR0H
	movff	SysByteTempX,SaveSysByteTempX
	movff	SysDivLoop,SaveSysDivLoop
	movff	SysTemp2,SaveSysTemp2
	movff	FSR1L,SaveFSR1L
	movff	FSR1H,SaveFSR1H
	movff	SysStringLength,SaveSysStringLength
	movff	SysWaitTempMS,SaveSysWaitTempMS
	movff	SysWaitTempMS_H,SaveSysWaitTempMS_H
	movff	DelayTemp2,SaveDelayTemp2
	movff	SysTemp1_H,SaveSysTemp1_H
	movff	SysStringA,SaveSysStringA
;On Interrupt handlers
	btfss	PIE3,USBIE,ACCESS
	bra	NotUSBIF
	btfss	PIR3,USBIF,ACCESS
	bra	NotUSBIF
	rcall	USBINTERRUPTHANDLER
	bcf	PIR3,USBIF,ACCESS
	bra	INTERRUPTDONE
NotUSBIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	movff	SaveSysTemp1,SysTemp1
	movff	SaveSysByteTempA,SysByteTempA
	movff	SaveSysByteTempB,SysByteTempB
	movff	SaveFSR0L,FSR0L
	movff	SaveFSR0H,FSR0H
	movff	SaveSysByteTempX,SysByteTempX
	movff	SaveSysDivLoop,SysDivLoop
	movff	SaveSysTemp2,SysTemp2
	movff	SaveFSR1L,FSR1L
	movff	SaveFSR1H,FSR1H
	movff	SaveSysStringLength,SysStringLength
	movff	SaveSysWaitTempMS,SysWaitTempMS
	movff	SaveSysWaitTempMS_H,SysWaitTempMS_H
	movff	SaveDelayTemp2,DelayTemp2
	movff	SaveSysTemp1_H,SysTemp1_H
	movff	SaveSysStringA,SysStringA
	movff	SysW,WREG
	movff	SysSTATUS,STATUS
	movff	SysBSR,BSR
	retfie	0

;********************************************************************************

FN_PEEK
;FSR0H = MemAdr_H
	movff	MEMADR_H,FSR0H
;FSR0L = MemAdr
	movff	MEMADR,FSR0L
;PEEK = INDF0
	movff	INDF0,PEEK
	return

;********************************************************************************

POKE
;Dim MemAdr As Word Alias FSR0H, FSR0L
;FSR0H = MemAdr_H
;FSR0L = MemAdr
;INDF0 = MemData
	movff	MEMDATA,INDF0
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD1022
;Always RIGHT justified
;SET ADFM ON
	bsf	ADCON2,ADFM,ACCESS
;A differential ADC
;Do conversion
;LLReadAD 0
;Set up A/D
;Make necessary ports analog
;Code for PICs with older A/D (No ANSEL register)
;Code for 16F193x chips (and others?) with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect7Case1
	movf	ADREADPORT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case2
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd7
SysSelect7Case2
	decf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case3
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd7
SysSelect7Case3
	movlw	2
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case4
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd7
SysSelect7Case4
	movlw	3
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case5
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.5 On
	bra	SysSelectEnd7
SysSelect7Case5
	movlw	4
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case6
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 12: Set ANSELB.0 On
	bra	SysSelectEnd7
SysSelect7Case6
	movlw	12
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case7
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 10: Set ANSELB.1 On
	bra	SysSelectEnd7
SysSelect7Case7
	movlw	10
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case8
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 8: Set ANSELB.2 On
	bra	SysSelectEnd7
SysSelect7Case8
	movlw	8
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case9
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 9: Set ANSELB.3 On
	bra	SysSelectEnd7
SysSelect7Case9
	movlw	9
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case10
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 11: Set ANSELB.4 On
	bra	SysSelectEnd7
SysSelect7Case10
	movlw	11
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case11
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd7
SysSelect7Case11
	movlw	13
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case12
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELC.2 On
	bra	SysSelectEnd7
SysSelect7Case12
	movlw	14
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case13
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 15: Set ANSELC.3 On
	bra	SysSelectEnd7
SysSelect7Case13
	movlw	15
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case14
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 16: Set ANSELC.4 On
	bra	SysSelectEnd7
SysSelect7Case14
	movlw	16
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case15
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 17: Set ANSELC.5 On
	bra	SysSelectEnd7
SysSelect7Case15
	movlw	17
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case16
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 18: Set ANSELC.6 On
	bra	SysSelectEnd7
SysSelect7Case16
	movlw	18
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case17
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 19: Set ANSELC.7 On
	bra	SysSelectEnd7
SysSelect7Case17
	movlw	19
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd7
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;End Select  'End Select #1
SysSelectEnd7
;ANSEL0/ANSEL
;Code for PICs with newer A/D (with ANSEL register)
;Code for 18F4431, uses ANSEL0 and ANSEL1
;Set Auto or Single Convert Mode
;Set conversion clock - improved to handle ADCS2
;SET ADCS2 OFF
	bcf	ADCON2,ADCS2,ACCESS
;SET ADCS1 ON
	bsf	ADCON2,ADCS1,ACCESS
;SET ADCS0 OFF
	bcf	ADCON2,ADCS0,ACCESS
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0,ACCESS
;SET CHS1 OFF
	bcf	ADCON0,CHS1,ACCESS
;SET CHS2 OFF
	bcf	ADCON0,CHS2,ACCESS
;SET CHS3 OFF
	bcf	ADCON0,CHS3,ACCESS
;SET CHS4 OFF
	bcf	ADCON0,CHS4,ACCESS
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfsc	ADREADPORT,0,BANKED
	bsf	ADCON0,CHS0,ACCESS
ENDIF43
;IF ADReadPort.1 On Then Set CHS1 On
	btfsc	ADREADPORT,1,BANKED
	bsf	ADCON0,CHS1,ACCESS
ENDIF44
;IF ADReadPort.2 On Then Set CHS2 On
	btfsc	ADREADPORT,2,BANKED
	bsf	ADCON0,CHS2,ACCESS
ENDIF45
;If ADReadPort.3 On Then Set CHS3 On
	btfsc	ADREADPORT,3,BANKED
	bsf	ADCON0,CHS3,ACCESS
ENDIF46
;If ADReadPort.4 On Then Set CHS4 On
	btfsc	ADREADPORT,4,BANKED
	bsf	ADCON0,CHS4,ACCESS
ENDIF47
;***  'Special section for 16F1688x Chips ***
;Enable A/D
;SET ADON ON
	bsf	ADCON0,ADON,ACCESS
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	rcall	Delay_10US
;Read A/D
;SET GO_NOT_DONE ON
	bsf	ADCON0,GO_NOT_DONE,ACCESS
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop5
	btfsc	ADCON0,GO_NOT_DONE,ACCESS
	bra	SysWaitLoop5
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;Clear whatever ANSEL variants the chip has
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;Write output
;ReadAD10 = ADRESL
	movff	ADRESL,READAD10
	banksel	READAD10_H
	clrf	READAD10_H,BANKED
;ReadAD10_H = ADRESH
	movff	ADRESH,READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
	return

;********************************************************************************

SETUPHANDLER_CALLBACK
;Select Case USBRequest
;Response to control request: Transfer USBDeviceReadPortb4LEDStatus, send status of port
;Case USBDeviceReadPortb4LEDStatus
SysSelect6Case1
	movlw	134
	banksel	USBREQUEST
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
;USBBufferWrite( PORTB.4 )
	banksel	_USBINVALUE
	clrf	_USBINVALUE,BANKED
	btfsc	PORTB,4,ACCESS
	incf	_USBINVALUE,F,BANKED
ENDIF37
	rcall	USBBUFFERWRITE14
	bcf	LATB,4,ACCESS
	btfsc	_USBINVALUE,0,BANKED
	bsf	LATB,4,ACCESS
ENDIF38
;Response to control request: Transfer USBDeviceSetPortb4StatusOn, turn on LED
;Case USBDeviceSetPortb4StatusOn
	bra	SysSelectEnd6
SysSelect6Case2
	movlw	135
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
;Set PORTB.4 On
	bsf	LATB,4,ACCESS
;Response to control request: Transfer USBDeviceSetPortb4StatusOff, turn off LED
;Case USBDeviceSetPortb4StatusOff
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	136
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
;Set PORTB.4 Off
	bcf	LATB,4,ACCESS
;Response to control request: Transfer USBDeviceReadPortb5LEDStatus, send status of port
;Case USBDeviceReadPortb5LEDStatus
	bra	SysSelectEnd6
SysSelect6Case4
	movlw	130
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
;USBBufferWrite( PORTB.5 )
	banksel	_USBINVALUE
	clrf	_USBINVALUE,BANKED
	btfsc	PORTB,5,ACCESS
	incf	_USBINVALUE,F,BANKED
ENDIF39
	rcall	USBBUFFERWRITE14
	bcf	LATB,5,ACCESS
	btfsc	_USBINVALUE,0,BANKED
	bsf	LATB,5,ACCESS
ENDIF40
;Response to control request: Transfer USBDeviceSetPortb5StatusOn, turn on LED
;Case USBDeviceSetPortb5StatusOn
	bra	SysSelectEnd6
SysSelect6Case5
	movlw	131
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case6
;Set PORTB.5 On
	bsf	LATB,5,ACCESS
;Response to control request: Transfer USBDeviceSetPortb5StatusOff, turn off LED
;Case USBDeviceSetPortb5StatusOff
	bra	SysSelectEnd6
SysSelect6Case6
	movlw	132
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case7
;Set PORTB.5 Off
	bcf	LATB,5,ACCESS
;Response to control request: Transfer USBDeviceReadADCValues, send back ADC readings
;Case USBDeviceReadADCValues
	bra	SysSelectEnd6
SysSelect6Case7
	movlw	133
	subwf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case8
;USBBufferWrite( ReadAD10(AN0) )
	banksel	ADREADPORT
	clrf	ADREADPORT,BANKED
	rcall	FN_READAD1022
	movff	SYSREADAD10WORD,_USBINVALUE
	movff	SYSREADAD10WORD_H,_USBINVALUE_H
	rcall	USBBUFFERWRITE15
;USBBufferWrite( ReadAD10(AN1) )
	movlw	1
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1022
	movff	SYSREADAD10WORD,_USBINVALUE
	movff	SYSREADAD10WORD_H,_USBINVALUE_H
	rcall	USBBUFFERWRITE15
;USBBufferWrite( ReadAD10(AN2) )
	movlw	2
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1022
	movff	SYSREADAD10WORD,_USBINVALUE
	movff	SYSREADAD10WORD_H,_USBINVALUE_H
	rcall	USBBUFFERWRITE15
;USBBufferWrite( ReadAD10(AN3) )
	movlw	3
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1022
	movff	SYSREADAD10WORD,_USBINVALUE
	movff	SYSREADAD10WORD_H,_USBINVALUE_H
	rcall	USBBUFFERWRITE15
;Response to control request: Transfer 255, keep alive
;Case USBDeviceKeepAlive
	bra	SysSelectEnd6
SysSelect6Case8
	incf	USBREQUEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case9
;USBBufferWrite( USBDeviceKeepAlive )
	banksel	_USBINVALUE
	setf	_USBINVALUE,BANKED
	rcall	USBBUFFERWRITE14
;PORTc.7 = !PORTc.7
	clrf	SysTemp2,BANKED
	btfsc	PORTC,7,ACCESS
	incf	SysTemp2,F,BANKED
ENDIF41
	comf	SysTemp2,F,BANKED
	bcf	LATC,7,ACCESS
	btfsc	SysTemp2,0,BANKED
	bsf	LATC,7,ACCESS
ENDIF42
;Handle the others via the serial port as we do not know what they are
;Case Else
	bra	SysSelectEnd6
SysSelect6Case9
;HSerPrint "Req "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT273
;HSerPrint USBTempBuffer(1)
	movff	SYSUSBTEMPBUFFER_1,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT274
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;End Select
SysSelectEnd6
	banksel	0
	return

;********************************************************************************

SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movff INDF0, SysCalcTempA
	movff	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movff	SYSCALCTEMPA, INDF1
;goto SysCopyStringCheck
	bra	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;Copy character
;movff PREINC0, PREINC1
	movff	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C,ACCESS
;rlf SysByteTempA, F
	rlcf	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	rlcf	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
	btfsc	STATUS, C,ACCESS
;goto Div8NotNeg
	bra	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	bra	SYSDIV8START
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
;goto SysStringReadCheck
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;TBLRD*+
	tblrd*+
;movf TABLAT, W
	movf	TABLAT, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F,ACCESS
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
;Copy
SYSSTRINGREAD
;Copy char
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movff	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	14,67,68,67,32,85,83,66,32,118,49,46,52,46,50


StringTable3
	db	5,66,117,105,108,100


StringTable4
	db	1,64


StringTable5
	db	9,85,83,66,32,67,71,66,32,32


StringTable6
	db	7,69,114,114,111,114,58,32


StringTable7
	db	4,82,101,113,32


StringTable8
	db	6,68,101,115,99,58,32


StringTable9
	db	15,71,114,101,97,116,32,67,111,119,32,66,65,83,73,67


StringTable13
	db	0


StringTable20
	db	2,49,48


StringTable21
	db	19,49,48,45,51,48,45,50,48,49,56,32,50,49,58,48,56,58,50,55


;********************************************************************************

;Overloaded signature: BYTE:
USBBUFFERWRITE14
;Increment the buffer counter
;USB_IN0_CNT++
	banksel	USB_IN0_CNT
	incf	USB_IN0_CNT,F,BANKED
;Poke USB_IN0_ADDR+USB_CNT_POINTER, _USBinValue
	banksel	USB_CNT_POINTER
	movf	USB_CNT_POINTER,W,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	_USBINVALUE,MEMDATA
	banksel	0
	rcall	POKE
;Increment the data pointer
;USB_CNT_POINTER++
	incf	USB_CNT_POINTER,F,BANKED
	return

;********************************************************************************

;Overloaded signature: WORD:
USBBUFFERWRITE15
;Increment the buffer counter
;USB_IN0_CNT++
	banksel	USB_IN0_CNT
	incf	USB_IN0_CNT,F,BANKED
;Poke USB_IN0_ADDR+USB_CNT_POINTER,    _USBinValue
	banksel	USB_CNT_POINTER
	movf	USB_CNT_POINTER,W,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	_USBINVALUE,MEMDATA
	banksel	0
	rcall	POKE
;Increment the buffer counter
;USB_IN0_CNT++
	banksel	USB_IN0_CNT
	incf	USB_IN0_CNT,F,BANKED
;Poke USB_IN0_ADDR+USB_CNT_POINTER+ 1, _USBinValue_H
	banksel	USB_CNT_POINTER
	movf	USB_CNT_POINTER,W,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movlw	0
	banksel	USB_IN0_ADDR_H
	addwfc	USB_IN0_ADDR_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	_USBINVALUE_H,MEMDATA
	rcall	POKE
;Increment the data pointer
;USB_CNT_POINTER = USB_CNT_POINTER + 2
	movlw	2
	addwf	USB_CNT_POINTER,F,BANKED
	return

;********************************************************************************

USBCONFIGDESCRIPTOR
	movlw	18
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBCONFIGDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBCONFIGDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBCONFIGDESCRIPTOR
	db	18,9,2,18,0,1,1,0,128,25,9,4,1,0,0,2,2,1

;********************************************************************************

USBDEVICEDESCRIPTOR
	movlw	19
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBDEVICEDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBDEVICEDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBDEVICEDESCRIPTOR
	db	18,18,1,0,2,2,0,0,64,216,4,10,0,1,0,0,0,1,1

;********************************************************************************

USBDEVICEQUALDESCRIPTOR
	movlw	10
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBDEVICEQUALDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBDEVICEQUALDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBDEVICEQUALDESCRIPTOR
	db	10,10,6,0,2,2,0,0,64,1

;********************************************************************************

USBINTERRUPTHANDLER
;Event that should be handled by library?
;Reset
;If URSTIF Then
	btfss	UIR,URSTIF,ACCESS
	bra	ENDIF2
;USBResetEndpoints
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S3
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E3
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;Disable endpoints
;UEP0 = 0
	clrf	UEP0,ACCESS
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	movwf	USB_IN0_ADDR,BANKED
	movlw	4
	movwf	USB_IN0_ADDR_H,BANKED
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	4
	movwf	USB_OUT0_ADDR_H,BANKED
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;UEP0 = b'00010110'
	movlw	22
	movwf	UEP0,ACCESS
;UADDR = 0
	clrf	UADDR,ACCESS
;Clear interrupt flags
;UEIR = 0
	clrf	UEIR,ACCESS
;UIR = 0
	clrf	UIR,ACCESS
;SUSPND = 0
	bcf	UCON,SUSPND,ACCESS
;Wait for single ended zero to clear
;Wait While UCON.SE0
SysWaitLoop1
	btfsc	UCON,SE0,ACCESS
	bra	SysWaitLoop1
;USBLastControl = USB_NONE
	banksel	USBLASTCONTROL
	setf	USBLASTCONTROL,BANKED
;USBState = USB_STATE_DEFAULT
	movlw	1
	movwf	USBSTATE,BANKED
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION,BANKED
;End If
ENDIF2
;Error
;If UERRIF Then
	btfss	UIR,UERRIF,ACCESS
	bra	ENDIF3
;USB_ERROR_HANDLER
	rcall	ERRORHANDLER_CALLBACK
;UEIR = 0
	clrf	UEIR,ACCESS
;UERRIF = 0
	bcf	UIR,UERRIF,ACCESS
;End If
ENDIF3
;Activity on D+/D-
;If ACTVIF Then
	btfss	UIR,ACTVIF,ACCESS
	bra	ENDIF4
;If activity detected, switch from suspend to normal
;SUSPND = 0
	bcf	UCON,SUSPND,ACCESS
;Clear ACTVIF
;Do While ACTVIF
;Set ACTVIF Off
	bcf	UIR,ACTVIF,ACCESS
;Loop
;End If
ENDIF4
;Transfer complete
;If TRNIF Then
	btfss	UIR,TRNIF,ACCESS
	bra	ENDIF5
;Determine transfer that has occurred
;USBCurrEndpoint = (USTAT And 0x78) / 8
	movlw	120
	andwf	USTAT,W,ACCESS
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,USBCURRENDPOINT
;If USTAT.DIR Then
	btfss	USTAT,DIR,ACCESS
	bra	ELSE9_1
;In
;USBBufferStat = USB_IN0_STAT
	movff	USB_IN0_STAT,USBBUFFERSTAT
;Else
	bra	ENDIF9
ELSE9_1
;Setup/Out
;USBBufferStat = USB_OUT0_STAT
	movff	USB_OUT0_STAT,USBBUFFERSTAT
;USB_OUT0_STAT.UOWN = 0
	banksel	USB_OUT0_STAT
	bcf	USB_OUT0_STAT,7,BANKED
;End If
ENDIF9
;Get PID (is multiplied by 4)
;USBPID = USBBufferStat And 0x3C
	movlw	60
	banksel	USBBUFFERSTAT
	andwf	USBBUFFERSTAT,W,BANKED
	movwf	USBPID,BANKED
;Select Case USBPID
;Case USB_PID_OUT
SysSelect1Case1
	movlw	4
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Out transfer
;HSerPrint "OUT"
;HSerPrintCRLF
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT.UOWN = 1
	bsf	USB_OUT0_STAT,7,BANKED
;Case USB_PID_IN
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	36
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;In transfer completed
;HSerPrint "IN"
;HSerPrintCRLF
;Select Case USBLastControl
;Set address completed
;Case USB_SET_ADDRESS
SysSelect2Case1
	movlw	5
	subwf	USBLASTCONTROL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;UADDR = USBNewAddress
	movff	USBNEWADDRESS,UADDR
;USBState = USB_STATE_ADDRESS
	movlw	2
	movwf	USBSTATE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Continue responding to Get Descriptor
;Case USB_GET_DESCRIPTOR
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	USBLASTCONTROL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;USBSendDescriptor
	rcall	USBSENDDESCRIPTOR
;Case Else
	bra	SysSelectEnd2
SysSelect2Case3
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;End Select
SysSelectEnd2
;Case USB_PID_SETUP
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	52
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Setup transfer
;Copy data to buffer
;For USBCurrByte = 0 to 7
	setf	USBCURRBYTE,BANKED
SysForLoop1
	incf	USBCURRBYTE,F,BANKED
;USBTempBuffer(USBCurrByte) = Peek(USB_OUT0_ADDR + USBCurrByte)
	movf	USBCURRBYTE,W,BANKED
	banksel	USB_OUT0_ADDR
	addwf	USB_OUT0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_OUT0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	banksel	0
	rcall	FN_PEEK
	lfsr	0,USBTEMPBUFFER
	movf	USBCURRBYTE,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	PEEK,INDF0
;Next
	movlw	7
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
ENDIF10
SysForLoopEnd1
;Stop any outgoing transmissions
;USB_IN0_STAT = 8
	movlw	8
	banksel	USB_IN0_STAT
	movwf	USB_IN0_STAT,BANKED
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;USBProcessSetup
	banksel	0
	rcall	USBPROCESSSETUP
;USBDumpControlIn
;HSerPrint "S"
;HSerPrintCRLF
;Case Else
	bra	SysSelectEnd1
SysSelect1Case4
;HSerPrint "PID Err "
;HSerPrint USBPID
;HSerPrintCRLF
;End Select
SysSelectEnd1
;USBHasData = True
	banksel	USBHASDATA
	setf	USBHASDATA,BANKED
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;End If
ENDIF5
;Idle
;If IDLEIF Then
	btfsc	UIR,IDLEIF,ACCESS
;IDLEIF = 0
	bcf	UIR,IDLEIF,ACCESS
;End If
ENDIF6
;Stalled
;If STALLIF Then
	btfsc	UIR,STALLIF,ACCESS
;STALLIF = 0
	bcf	UIR,STALLIF,ACCESS
;End If
ENDIF7
;Start of frame
;If SOFIF Then
	btfsc	UIR,SOFIF,ACCESS
;SOFIF = 0
	bcf	UIR,SOFIF,ACCESS
;End If
ENDIF8
	return

;********************************************************************************

USBPROCESSSETUP
;Buffer format:
;0:bmRequestType 1:bRequest 3-2:wValue 5-4:wIndex 7-6:wLength
;USBbmRequestType = USBTempBuffer(0) And 0x7F
	movlw	127
	banksel	SYSUSBTEMPBUFFER_0
	andwf	SYSUSBTEMPBUFFER_0,W,BANKED
	banksel	USBBMREQUESTTYPE
	movwf	USBBMREQUESTTYPE,BANKED
;Re-enable input processing
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;Device requests
;If USBbmRequestType = 0 Then
	movf	USBBMREQUESTTYPE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE11_1
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Select Case USBTempBuffer(1)
;Case USB_GET_STATUS
;Case USB_CLEAR_FEATURE
;Case USB_SET_FEATURE
;Case USB_SET_ADDRESS
SysSelect3Case1
	movlw	5
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;USBLastControl = USB_SET_ADDRESS
	movlw	5
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL,BANKED
;USBNewAddress = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBNEWADDRESS
;Send empty DATA1 packet
;USBSendDATA1Ack
	rcall	USBSENDDATA1ACK
;Case USB_GET_DESCRIPTOR
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	6
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;USBLastControl = USB_GET_DESCRIPTOR
	movlw	6
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL,BANKED
;USBDescType = USBTempBuffer(3)
	movff	SYSUSBTEMPBUFFER_3,USBDESCTYPE
;USBDescIndex = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBDESCINDEX
;USBDescSizeIn = USBTempBuffer(6)
	movff	SYSUSBTEMPBUFFER_6,USBDESCSIZEIN
;USBDescStart = 0
	clrf	USBDESCSTART,BANKED
;USBSendDescriptor
	rcall	USBSENDDESCRIPTOR
;Case USB_SET_DESCRIPTOR
;Case USB_GET_CONFIGURATION
;Case USB_SET_CONFIGURATION
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	9
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case4
;USBCurrConfiguration = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBCURRCONFIGURATION
;If USBCurrConfiguration = 0 Then
	banksel	USBCURRCONFIGURATION
	movf	USBCURRCONFIGURATION,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE12_1
;USBState = USB_STATE_ADDRESS
	movlw	2
	movwf	USBSTATE,BANKED
;Else
	bra	ENDIF12
ELSE12_1
;USBState = USB_STATE_CONFIGURED
	movlw	3
	movwf	USBSTATE,BANKED
;End If
ENDIF12
;USBSendData1Ack
	rcall	USBSENDDATA1ACK
;Unknown case - send to the User Handler
;Case Else
	bra	SysSelectEnd3
SysSelect3Case4
;Call the user callback
;USB_SETUP_HANDLER
	banksel	0
	rcall	SETUPHANDLER_CALLBACK
;End Select
SysSelectEnd3
;Else
	bra	ENDIF11
ELSE11_1
;USBDumpControlIn    'method to assist in debuggin
;clear the pointer.  If the pointer has been incremented then we know what to do!
;the is the number of buffer bytes to be sent
;USB_IN0_CNT = 0
	banksel	USB_IN0_CNT
	clrf	USB_IN0_CNT,BANKED
;point to the output buffer
;USB_CNT_POINTER = 0
	banksel	USB_CNT_POINTER
	clrf	USB_CNT_POINTER,BANKED
;Call the user callback
;USB_SETUP_HANDLER
	rcall	SETUPHANDLER_CALLBACK
;if USB_IN0_CNT = 0 then
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE13_1
;No data added to the output buffer - just send an ACK
;USBSendData1Ack
	banksel	0
	rcall	USBSENDDATA1ACK
;else
	bra	ENDIF13
ELSE13_1
;Data is thee output buffer - send the data
;USBStartSend
;If USB_IN0_STAT.6 Then
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE14_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT,BANKED
;Else
	bra	ENDIF14
ELSE14_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT,BANKED
;End If
ENDIF14
;end if
ENDIF13
;End If
ENDIF11
	banksel	0
	return

;********************************************************************************

USBSENDDATA1ACK
;USB_IN0_CNT = 0
	banksel	USB_IN0_CNT
	clrf	USB_IN0_CNT,BANKED
;USB_IN0_STAT = 0xC8
	movlw	200
	movwf	USB_IN0_STAT,BANKED
	banksel	0
	return

;********************************************************************************

USBSENDDESCRIPTOR
;Descriptor types:
;1: Device
;2: Configuration
;4: Interface
;5: Endpoint
;3: String
;To send, need to copy into EP0 IN buffer
;Take ownership
;USB_IN0_STAT.UOWN = 0
	banksel	USB_IN0_STAT
	bcf	USB_IN0_STAT,7,BANKED
;Select Case USBDescType
;Device
;Case 1
SysSelect4Case1
	banksel	USBDESCTYPE
	decf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;Copy bytes into buffer
;ReadTable USB_DEVICE_DESCRIPTOR, 1, USBSize
	movlw	18
	movwf	USBSIZE,BANKED
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF15
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE16_1
;USBSize = 0
	clrf	USBSIZE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF16
ELSE16_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
;End If
ENDIF16
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
ENDIF17
SysForLoop2
	incf	USBCURRBYTE,F,BANKED
;ReadTable USB_DEVICE_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBDEVICEDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
ENDIF18
SysForLoopEnd2
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
;Configuration
;Case 2
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;Copy bytes into buffer
;ReadTable USB_CONFIG_DESCRIPTOR, 0, USBSize
	movlw	18
	movwf	USBSIZE,BANKED
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF19
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE20_1
;USBSize = 0
	clrf	USBSIZE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF20
ELSE20_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
;End If
ENDIF20
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
ENDIF21
SysForLoop3
	incf	USBCURRBYTE,F,BANKED
;ReadTable USB_CONFIG_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBCONFIGDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
ENDIF22
SysForLoopEnd3
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
;Device Qualifier
;Case 6
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	6
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;Copy bytes into buffer
;ReadTable USBDeviceQualDescriptor, 0, USBSize
	movlw	10
	movwf	USBSIZE,BANKED
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF23
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE24_1
;USBSize = 0
	clrf	USBSIZE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF24
ELSE24_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
;End If
ENDIF24
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
ENDIF25
SysForLoop4
	incf	USBCURRBYTE,F,BANKED
;ReadTable USBDeviceQualDescriptor, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBDEVICEQUALDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
ENDIF26
SysForLoopEnd4
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
;String
;Case 3
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
;If USBDescIndex = 0 Then
	movf	USBDESCINDEX,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE27_1
;Assume that these aren't continued over
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Language ID
;Poke USB_IN0_ADDR, 4
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movlw	4
	movwf	MEMDATA,BANKED
	rcall	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
;Poke USB_IN0_ADDR + 2, 0x09
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	9
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
;Poke USB_IN0_ADDR + 3, 0x04
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	4
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
;USB_IN0_CNT = 4
	movlw	4
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
;Else
	bra	ENDIF27
ELSE27_1
;Get requested string
;Select Case USBDescIndex
;Vendor name
;Case 1: USBTempString = USB_VENDOR_NAME
SysSelect5Case1
	decf	USBDESCINDEX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
;Product name
;Case 2: USBTempString = USB_PRODUCT_NAME
	bra	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	USBDESCINDEX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
;Other
;Case Else: USBTempString = ""
	bra	SysSelectEnd5
SysSelect5Case3
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
;End Select
SysSelectEnd5
;Format string into unicode string descriptor
;USB_IN0_CNT = 2 + (USBTempString(0) * 2)
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movlw	2
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
;If USBDescStart > USB_IN0_CNT Then
	banksel	USBDESCSTART
	movf	USBDESCSTART,W,BANKED
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ELSE29_1
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USBLastControl = USB_NONE
	banksel	USBLASTCONTROL
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF29
ELSE29_1
;USB_IN0_CNT -= USBDescStart
	banksel	USBDESCSTART
	movf	USBDESCSTART,W,BANKED
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,F,BANKED
;End If
ENDIF29
;Poke USB_IN0_ADDR, USB_IN0_CNT
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movff	USB_IN0_CNT,MEMDATA
	banksel	0
	call	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	call	POKE
;For USBCurrByte = 1 to USBTempString(0)
	clrf	USBCURRBYTE,BANKED
	movlw	1
	banksel	SYSUSBTEMPSTRING_0
	subwf	SYSUSBTEMPSTRING_0,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
ENDIF30
SysForLoop5
	banksel	USBCURRBYTE
	incf	USBCURRBYTE,F,BANKED
;USBTempByte = USBTempString(USBCurrByte)
	lfsr	0,USBTEMPSTRING
	movf	USBCURRBYTE,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,USBTEMPBYTE
;Poke USB_IN0_ADDR + (USBCurrByte * 2), USBTempByte
	movf	USBCURRBYTE,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	call	POKE
;Poke USB_IN0_ADDR + (USBCurrByte * 2 + 1), 0
	movf	USBCURRBYTE,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	incf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	banksel	MEMDATA
	clrf	MEMDATA,BANKED
	call	POKE
;Next
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	banksel	USBCURRBYTE
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
ENDIF31
SysForLoopEnd5
;If USB_IN0_CNT > USBDescSizeIn Then USB_IN0_CNT = USBDescSizeIn
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSIZEIN
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USB_IN0_CNT
ENDIF32
;USBDescStart += USB_IN0_CNT
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSTART
	addwf	USBDESCSTART,F,BANKED
;End If
ENDIF27
;Interface
;Case 4
;Endpoint
;Case 5
;Other
;Case Else
	bra	SysSelectEnd4
SysSelect4Case5
;USB_DESCRIPTOR_HANDLER
	call	DESCRIPTORHANDLER_CALLBACK
;Exit Sub
	return
;End Select
SysSelectEnd4
;USBStartSend
;If USB_IN0_STAT.6 Then
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE28_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT,BANKED
;Else
	bra	ENDIF28
ELSE28_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT,BANKED
;End If
ENDIF28
	banksel	0
	return

;********************************************************************************


 END
