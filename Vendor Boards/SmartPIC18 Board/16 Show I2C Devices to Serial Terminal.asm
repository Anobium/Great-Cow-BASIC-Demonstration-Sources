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
COMPORT	EQU	10
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
DEVICEID	EQU	11
DISPLAYNEWLINE	EQU	12
HEX	EQU	3849
HI2CACKPOLLSTATE	EQU	13
HI2CCURRENTMODE	EQU	14
HI2CWAITMSSPTIMEOUT	EQU	15
HSERPRINTCRLFCOUNT	EQU	16
I2CBYTE	EQU	17
PRINTLEN	EQU	18
SERDATA	EQU	19
STRINGPOINTER	EQU	20
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSDIVLOOP	EQU	4
SYSPRINTDATAHANDLER	EQU	21
SYSPRINTDATAHANDLER_H	EQU	22
SYSPRINTTEMP	EQU	23
SYSREPEATTEMP1	EQU	24
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	3853
SYSSTRINGTEMP	EQU	25
SYSTEMP1	EQU	26
SYSVALTEMP	EQU	27
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
SYSHEX_0	EQU	3849
SYSHEX_1	EQU	3850
SYSHEX_2	EQU	3851

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
	rcall	INITUSART
	rcall	HIC2INIT
;Automatic pin direction setting
	bsf	TRISB,0,ACCESS

;Start of the main program
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
;#define SWITCH_DOWN         0
;#define SWITCH_UP           1
;#define SWITCH      PORTB.0
;#define USART_BAUD_RATE 19200
;#define USART_TX_BLOCKING
;SCKP = 1
	bsf	BAUD1CON,SCKP,ACCESS
;----- Define Hardware settings for hwi2c
;#define HI2C_BAUD_RATE 400
;#define HI2C_DATA PORTC.4
;#define HI2C_CLOCK PORTC.3
;Dir HI2C_DATA in
	bsf	TRISC,4,ACCESS
;Dir HI2C_CLOCK in
	bsf	TRISC,3,ACCESS
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE,BANKED
	rcall	HI2CMODE

;----- Main body of program commences here.
;dim DeviceID as byte
;Dim DISPLAYNEWLINE as Byte
;do
SysDoLoop_S1
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;HSerPrint "Hardware I2C "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;HSerPrint "   "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;for DeviceID = 0 to 15
	setf	DEVICEID,BANKED
SysForLoop1
	incf	DEVICEID,F,BANKED
;HSerPrint hex(deviceID)
	movff	DEVICEID,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;HSerPrint " "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;next
	movlw	15
	subwf	DEVICEID,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;for DeviceID = 0 to 255
	setf	DEVICEID,BANKED
SysForLoop2
	incf	DEVICEID,F,BANKED
;DisplayNewLine = DeviceID % 16
	movff	DEVICEID,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempX,DISPLAYNEWLINE
;if DisplayNewLine = 0 Then
	movf	DISPLAYNEWLINE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF2
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;HserPrint hex(DeviceID)
	movff	DEVICEID,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;if DisplayNewLine > 0 then
	movf	DISPLAYNEWLINE,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF5
;HSerPrint " "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;end if
ENDIF5
;end if
ENDIF2
;HSerPrint " "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;HI2CStart
	rcall	HI2CSTART

;if HI2CWaitMSSPTimeout <> True then
	incf	HI2CWAITMSSPTIMEOUT,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE3_1
;HI2CSend ( deviceID )
	movff	DEVICEID,I2CBYTE
	rcall	HI2CSEND

;if HI2CAckPollState = false then
	movf	HI2CACKPOLLSTATE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE6_1
;HI2CSend ( 0 )
	clrf	I2CBYTE,BANKED
	rcall	HI2CSEND

;HSerPrint   hex(deviceID)
	movff	DEVICEID,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;Else
	bra	ENDIF6
ELSE6_1
;HSerPrint "--"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;end if
ENDIF6
;HI2CStop
	rcall	HI2CSTOP

;Else
	bra	ENDIF3
ELSE3_1
;HSerPrint "! "
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
	rcall	HSERPRINT238

;end if
ENDIF3
;next
	movlw	255
	subwf	DEVICEID,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;HSerPrint   "End of Search"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT238

;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;wait while switch = On
SysWaitLoop1
	btfsc	PORTB,0,ACCESS
	bra	SysWaitLoop1
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;----- Support methods.  Subroutines and Functions
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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS

	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
	return

;********************************************************************************

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0,BANKED
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF7
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF7
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop3
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF9
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF9
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

HI2CMODE
;set SSPSTAT.SMP on
	bsf	SSPSTAT,SMP,ACCESS
;set SSPCON1.CKP on
	bsf	SSPCON1,CKP,ACCESS
;set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;If HI2CCurrentMode = Master Then
	movlw	12
	subwf	HI2CCURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF14
;set SSPCON1.SSPM3 on
	bsf	SSPCON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 off
	bcf	SSPCON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 off
	bcf	SSPCON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 off
	bcf	SSPCON1,SSPM0,ACCESS
;SSPADD = HI2C_BAUD_TEMP And 127
	movlw	9
	movwf	SSPADD,ACCESS
;end if
ENDIF14
;if HI2CCurrentMode = Slave then
	movf	HI2CCURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF15
;set SSPCON1.SSPM3 off
	bcf	SSPCON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 on
	bsf	SSPCON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 on
	bsf	SSPCON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 off
	bcf	SSPCON1,SSPM0,ACCESS
;end if
ENDIF15
;if HI2CCurrentMode = Slave10 then
	movlw	3
	subwf	HI2CCURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF16
;set SSPCON1.SSPM3 off
	bcf	SSPCON1,SSPM3,ACCESS
;set SSPCON1.SSPM2 on
	bsf	SSPCON1,SSPM2,ACCESS
;set SSPCON1.SSPM1 on
	bsf	SSPCON1,SSPM1,ACCESS
;set SSPCON1.SSPM0 on
	bsf	SSPCON1,SSPM0,ACCESS
;end if
ENDIF16
;set SSPCON1.SSPEN on
	bsf	SSPCON1,SSPEN,ACCESS
	return

;********************************************************************************

HI2CSEND
RETRYHI2CSEND
;SET SSPCON1.WCOL OFF
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = I2CByte
	movff	I2CBYTE,SSPBUF
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP

;if ACKSTAT =  1 then
	btfss	SSP1CON2,ACKSTAT,ACCESS
	bra	ELSE19_1
;HI2CAckPollState = true
	setf	HI2CACKPOLLSTATE,BANKED
;else
	bra	ENDIF19
ELSE19_1
;HI2CAckPollState = false
	clrf	HI2CACKPOLLSTATE,BANKED
;end if
ENDIF19
;If SSPCON1.WCOL = On Then
	btfss	SSPCON1,WCOL,ACCESS
	bra	ENDIF20
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	movf	HI2CCURRENTMODE,W,BANKED
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	RETRYHI2CSEND
;End If
ENDIF20
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	movf	HI2CCURRENTMODE,W,BANKED
	sublw	10
	btfsc	STATUS, C,ACCESS
	bsf	SSPCON1,CKP,ACCESS
	return

;********************************************************************************

HI2CSTART
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,BANKED
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE17_1
;Set SEN On
	bsf	SSP1CON2,SEN,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP

;Else
	bra	ENDIF17
ELSE17_1
;Wait Until SSPSTAT.S = On
SysWaitLoop3
	btfss	SSPSTAT,S,ACCESS
	bra	SysWaitLoop3
;End If
ENDIF17
	return

;********************************************************************************

HI2CSTOP
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W,BANKED
	sublw	10
	btfsc	STATUS, C,ACCESS
	bra	ELSE18_1
;wait while R_NOT_W = 1   'wait for completion of activities
SysWaitLoop4
	btfsc	SSP1STAT,R_NOT_W,ACCESS
	bra	SysWaitLoop4
;Set SSPCON2.PEN On
	bsf	SSPCON2,PEN,ACCESS
;HI2CWaitMSSP
	rcall	HI2CWAITMSSP

;Else
	bra	ENDIF18
ELSE18_1
;Wait Until SSPSTAT.P = On
SysWaitLoop5
	btfss	SSPSTAT,P,ACCESS
	bra	SysWaitLoop5
;End If
ENDIF18
	return

;********************************************************************************

HI2CWAITMSSP
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT,BANKED
HI2CWAITMSSPWAIT
;HI2CWaitMSSPTimeout++
	incf	HI2CWAITMSSPTIMEOUT,F,BANKED
;if HI2CWaitMSSPTimeout < 255 then
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF23
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	btfss	PIR1,SSP1IF,ACCESS
	bra	HI2CWAITMSSPWAIT
;SSP1IF = 0
	bcf	PIR1,SSP1IF,ACCESS
;exit Sub
	return
;if SSPIF = 0 then goto HI2CWaitMSSPWait
	btfss	PIR1,SSPIF,ACCESS
	bra	HI2CWAITMSSPWAIT
;SSPIF = 0
	bcf	PIR1,SSPIF,ACCESS
;exit Sub
	return
;end if
ENDIF23
	return

;********************************************************************************

HIC2INIT
;HI2CCurrentMode = 0
	clrf	HI2CCURRENTMODE,BANKED
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT238
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF11
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
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

;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;End If
ENDIF11
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

;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND

;wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF10
;Wait While TX1IF = Off
SysWaitLoop2
	btfss	PIR1,TX1IF,ACCESS
	bra	SysWaitLoop2
;TXREG1 = SerData
	movff	SERDATA,TXREG1
;end if
ENDIF10
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

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;SPBRG1 = SPBRGL_TEMP
	movlw	207
	movwf	SPBRG1,ACCESS
;SPBRGH1 = SPBRGH_TEMP
	clrf	SPBRGH1,ACCESS
;BAUDCON1.BRG16 = BRG16_TEMP
	bsf	BAUDCON1,BRG16,ACCESS
;TX1STA.BRGH = BRGH_TEMP
	bsf	TX1STA,BRGH,ACCESS
;TXSTA1.BRGH = BRGH_TEMP
	bsf	TXSTA1,BRGH,ACCESS
;Set SYNC1 Off
	bcf	TX1STA,SYNC1,ACCESS
;Set SPEN1 On
	bsf	RC1STA,SPEN1,ACCESS
;Set CREN1 On
	bsf	RC1STA,CREN1,ACCESS
;Set TXEN1 On
	bsf	TX1STA,TXEN1,ACCESS
	return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
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
SYSSTRINGREADCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGREAD
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
	db	13,72,97,114,100,119,97,114,101,32,73,50,67,32


StringTable2
	db	3,32,32,32


StringTable3
	db	1,32


StringTable4
	db	2,45,45


StringTable5
	db	2,33,32


StringTable6
	db	13,69,110,100,32,111,102,32,83,101,97,114,99,104


;********************************************************************************


 END
