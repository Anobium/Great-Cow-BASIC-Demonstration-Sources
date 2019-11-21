;Program compiled by Great Cow BASIC (0.98.<<>> 2019-11-14 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1705, r=DEC
#include <P16F1705.inc>
 __CONFIG _CONFIG1, _CLKOUTEN_OFF & _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
BGETC	EQU	32
BUFFER	EQU	8945
BYTEVALUEOUTTONEXTION	EQU	33
COMPORT	EQU	34
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
GLCDBACKGROUND	EQU	35
GLCDBACKGROUND_H	EQU	36
GLCDFNTDEFAULT	EQU	37
GLCDFNTDEFAULTSIZE	EQU	38
GLCDFONTWIDTH	EQU	39
GLCD_YORDINATE	EQU	40
GLCD_YORDINATE_H	EQU	41
HSERRECEIVE	EQU	42
INCOMINGBYTEFROMNEXTION	EQU	43
NEXTIONNUMBERDATA	EQU	44
NEXTIONNUMBERDATA_E	EQU	47
NEXTIONNUMBERDATA_H	EQU	45
NEXTIONNUMBERDATA_U	EQU	46
NEXT_IN	EQU	48
NEXT_OUT	EQU	49
OUTSTATE	EQU	50
OUTVALUETEMP	EQU	51
PRINTLEN	EQU	52
PRINTLOCX	EQU	53
PRINTLOCX_H	EQU	54
PRINTLOCY	EQU	55
PRINTLOCY_H	EQU	56
SAVEFSR0H	EQU	57
SAVEFSR0L	EQU	58
SAVEPCLATH	EQU	59
SAVESYSBYTETEMPA	EQU	60
SAVESYSBYTETEMPB	EQU	61
SAVESYSBYTETEMPX	EQU	62
SAVESYSDIVLOOP	EQU	63
SAVESYSTEMP1	EQU	64
SERDATA	EQU	65
SERPRINTVAL	EQU	66
SERPRINTVALINT	EQU	70
SERPRINTVALINT_H	EQU	71
SERPRINTVAL_E	EQU	69
SERPRINTVAL_H	EQU	67
SERPRINTVAL_U	EQU	68
STR	EQU	8887
STRINGOUTTONEXTION	EQU	8904
STRINGPOINTER	EQU	72
SYSBSR	EQU	73
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHARCOUNT	EQU	74
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLONGDIVMULTA	EQU	75
SYSLONGDIVMULTA_E	EQU	78
SYSLONGDIVMULTA_H	EQU	76
SYSLONGDIVMULTA_U	EQU	77
SYSLONGDIVMULTB	EQU	79
SYSLONGDIVMULTB_E	EQU	82
SYSLONGDIVMULTB_H	EQU	80
SYSLONGDIVMULTB_U	EQU	81
SYSLONGDIVMULTX	EQU	83
SYSLONGDIVMULTX_E	EQU	86
SYSLONGDIVMULTX_H	EQU	84
SYSLONGDIVMULTX_U	EQU	85
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
SYSNEXTIONOBJECTHANDLER	EQU	87
SYSNEXTIONOBJECTHANDLER_H	EQU	88
SYSNEXTIONSTRINGDATAHANDLER	EQU	89
SYSNEXTIONSTRINGDATAHANDLER_H	EQU	90
SYSOUTSTRINGHANDLER	EQU	91
SYSOUTSTRINGHANDLER_H	EQU	92
SYSPRINTBUFFER	EQU	8893
SYSPRINTBUFFLEN	EQU	93
SYSPRINTDATAHANDLER	EQU	94
SYSPRINTDATAHANDLER_H	EQU	95
SYSPRINTTEMP	EQU	96
SYSREPEATTEMP1	EQU	97
SYSSTATUS	EQU	127
SYSSTRDATA	EQU	98
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	8882
SYSSTRINGPARAM2	EQU	8877
SYSTEMP1	EQU	99
SYSTEMP1_E	EQU	102
SYSTEMP1_H	EQU	100
SYSTEMP1_U	EQU	101
SYSTEMP2	EQU	103
SYSVALTEMP	EQU	104
SYSVALTEMP_H	EQU	105
SYSW	EQU	126
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TEMPPNT	EQU	106

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSHSERRECEIVEBYTE	EQU	42
SYSSTR_0	EQU	1111

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
Interrupt

;********************************************************************************

;Save Context
	movwf	SysW
	swapf	STATUS,W
	movwf	SysSTATUS
	movf	BSR,W
	banksel	STATUS
	movwf	SysBSR
;Store system variables
	movf	FSR0L,W
	movwf	SaveFSR0L
	movf	SysTemp1,W
	movwf	SaveSysTemp1
	movf	FSR0H,W
	movwf	SaveFSR0H
	movf	SysByteTempA,W
	movwf	SaveSysByteTempA
	movf	SysByteTempB,W
	movwf	SaveSysByteTempB
	movf	SysByteTempX,W
	movwf	SaveSysByteTempX
	movf	SysDivLoop,W
	movwf	SaveSysDivLoop
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	banksel	PIE1
	btfss	PIE1,RCIE
	goto	NotRCIF
	banksel	PIR1
	btfss	PIR1,RCIF
	goto	NotRCIF
	call	READUSART
	bcf	PIR1,RCIF
	goto	INTERRUPTDONE
NotRCIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	banksel	SAVEFSR0L
	movf	SaveFSR0L,W
	movwf	FSR0L
	movf	SaveSysTemp1,W
	movwf	SysTemp1
	movf	SaveFSR0H,W
	movwf	FSR0H
	movf	SaveSysByteTempA,W
	movwf	SysByteTempA
	movf	SaveSysByteTempB,W
	movwf	SysByteTempB
	movf	SaveSysByteTempX,W
	movwf	SysByteTempX
	movf	SaveSysDivLoop,W
	movwf	SysDivLoop
	movf	SavePCLATH,W
	movwf	PCLATH
	movf	SysBSR,W
	movwf	BSR
	swapf	SysSTATUS,W
	movwf	STATUS
	swapf	SysW,F
	swapf	SysW,W
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	61
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITPPS
	call	INITUSART
	call	INITGLCD_NEXTION
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE

;Start of the main program
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program demonstrates the using Great Cow BASIC to update the Nextion display.
;''
;''Enjoy.
;''
;''
;''@author     Evan Venn
;''@licence    GPL
;''@version    1.00
;''@date       18.11.2019
;''********************************************************************************
;----- Configuration
;Chip Settings.
;----- Set up the Nextion GLCD
;#define GLCD_TYPE GLCD_TYPE_Nextion
;Change the width and height to match the rotation in the Nextion Editor
;#define GLCD_WIDTH  800   'could be 320 | 400 | 272 | 480 but any valid dimension will work.
;#define GLCD_HEIGHT 480  'could be 240 | 480 | 800 but any valid dimension will work.
;----- End of set up for Nextion GLCD
;----- Set up for Hardware Serial
;VERY IMPORTANT!!
;The Nextion MUST be setup for 9600 bps.
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_DELAY 0
;----- Main program
;Ensure this CONSTANTS SHOULD BE CORRECT and they match for Nextion project components in the tutorial... but, bect check
;#define RADIOCOMPONENT         "r0"          'This is the component objname of the Nextion component, this value may be different in your project
;#define NUMBERCOMPONENT        "n0"          'This is the component objname of the Nextion component, this value may be different in your project
;#define TEXTCOMPONENT          "t3"          'This is the component objname of the Nextion component, this value may be different in your project
;#define TOGGLELEDBUTTON        6             'This is the component ID of the Nextion component, this value may be different in your project
;#define SELECTPAGE1BUTTON      1             'This is the component ID of the Nextion component, this value may be different in your project
;Statics that should not change.
;#define PAGE0           0
;#define PAGE1           1
;#define TOUCHEVENT      0x65
;The microcontroller LED
;#define LED1            porta.0
;----- Setup the Interrupt Handler - this should NOT be changed
;This manages the serial buffer on the bytes coming from the Nextion
;On Interrupt UsartRX1Ready Call readUSART
	banksel	PIE1
	bsf	PIE1,RCIE
;Constants required for Buffer Ring
;#define BUFFER_SIZE 255
;#define bkbhit (next_in <> next_out)
;Declare the required variables
;Dim buffer( BUFFER_SIZE - 1 ) '
;Dim next_in as byte: next_in = 0
	banksel	NEXT_IN
	clrf	NEXT_IN
;Dim next_out as byte: next_out = 0
	clrf	NEXT_OUT
;----- Declare the variables we need for this tutorial
;dim byteValueOutToNextion as byte
;dim inComingByteFromNextion as byte
;dim stringOutToNextion as string
;----- Set the LED as an output
;dir LED1 out
	banksel	TRISA
	bcf	TRISA,0
;Create a string for text component - this will state the type of microcontroller and the frequency of the microcontroller
;stringOutToNextion = "PIC"
	movlw	low STRINGOUTTONEXTION
	movwf	FSR1L
	movlw	high STRINGOUTTONEXTION
	movwf	FSR1H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	banksel	STATUS
	call	SysReadString
;stringOutToNextion = stringOutToNextion + ChipNameStr + " @"+str(ChipMHz)+"Mhz"
	movlw	32
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low STRINGOUTTONEXTION
	movwf	FSR1L
	movlw	high STRINGOUTTONEXTION
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low STRINGOUTTONEXTION
	movwf	FSR0L
	movlw	high STRINGOUTTONEXTION
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low StringTable107
	movwf	SysStringA
	movlw	(high StringTable107) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low STRINGOUTTONEXTION
	movwf	FSR0L
	movlw	high STRINGOUTTONEXTION
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Initialise page0
;displayPage0
	call	DISPLAYPAGE0
;Main loop, never exits
;do
SysDoLoop_S1
;Update the n0.val object
;byteValueOutToNextion = (byteValueOutToNextion + 1) % 101
	incf	BYTEVALUEOUTTONEXTION,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	101
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempX,W
	movwf	BYTEVALUEOUTTONEXTION
;GLCDUpdateObject_Nextion( NUMBERCOMPONENT+".val",  byteValueOutToNextion )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler_H
	movf	BYTEVALUEOUTTONEXTION,W
	movwf	NEXTIONNUMBERDATA
	clrf	NEXTIONNUMBERDATA_H
	call	GLCDUPDATEOBJECT_NEXTION356
;wait 50 ms
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;react to incoming data, if bkbhit is TRUE then we have some serial data!
;do while bkbhit
SysDoLoop_S2
	movf	NEXT_OUT,W
	subwf	NEXT_IN,W
	btfsc	STATUS, Z
	goto	SysDoLoop_E2
;Has a Nextion Touch Event happended.  bgetc is the next serial byte, so, we can test it.
;Once bgetc is tested the serial byte has been consumed and the next byte is availalbe in the buffer.
;if bgetc = TouchEvent then
	call	FN_BGETC
	movlw	101
	subwf	BGETC,W
	btfss	STATUS, Z
	goto	ENDIF1
;The next bgetc byte in the buffer is the originating Nextion page
;select case bgetc
	call	FN_BGETC
;Page 0 events... there are potenially a few, so we need to test the next byte to set which component caused the event
;case PAGE0
SysSelect1Case1
	movf	BGETC,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
;The next bgetc byte in the buffer is the  component ID that caused the event
;select case bgetc
	call	FN_BGETC
;Page change pressed
;case SELECTPAGE1BUTTON
SysSelect2Case1
	decf	BGETC,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;Send an instruction to 'page' change the Nextion
;GLCDSendOpInstruction_Nextion( "page",  "page"+str(PAGE1) )
	movlw	low StringTable9
	movwf	SysNEXTIONOBJECTHandler
	movlw	(high StringTable9) | 128
	movwf	SysNEXTIONOBJECTHandler_H
	movlw	1
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable9
	movwf	SysStringA
	movlw	(high StringTable9) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONSTRINGDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONSTRINGDATAHandler_H
	call	GLCDSENDOPINSTRUCTION_NEXTION
;Toggle LED pressed or released
;case TOGGLELEDBUTTON
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	BGETC,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;The next byte is the state of the TOGGLELEDBUTTON 0 or 1
;inComingByteFromNextion  = bgetc
	call	FN_BGETC
	movf	BGETC,W
	movwf	INCOMINGBYTEFROMNEXTION
;Set the LED state to TOGGLELEDBUTTON state
;LED1 = inComingByteFromNextion
	banksel	LATA
	bcf	LATA,0
	banksel	INCOMINGBYTEFROMNEXTION
	btfss	INCOMINGBYTEFROMNEXTION,0
	goto	ENDIF3
	banksel	LATA
	bsf	LATA,0
ENDIF3
;Tell the Nextion the LED is ON
;if inComingByteFromNextion = 1 then
	banksel	INCOMINGBYTEFROMNEXTION
	decf	INCOMINGBYTEFROMNEXTION,W
	btfss	STATUS, Z
	goto	ENDIF2
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp1
SysRepeatLoop1
;GLCDUpdateObject_Nextion( RADIOCOMPONENT+".bco",  [long]63488 )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler_H
	clrf	NEXTIONNUMBERDATA
	movlw	248
	movwf	NEXTIONNUMBERDATA_H
	clrf	NEXTIONNUMBERDATA_U
	clrf	NEXTIONNUMBERDATA_E
	call	GLCDUPDATEOBJECT_NEXTION355
;GLCDUpdateObject_Nextion( RADIOCOMPONENT+".pco",  [long]63488 )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low StringTable11
	movwf	SysStringA
	movlw	(high StringTable11) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler_H
	clrf	NEXTIONNUMBERDATA
	movlw	248
	movwf	NEXTIONNUMBERDATA_H
	clrf	NEXTIONNUMBERDATA_U
	clrf	NEXTIONNUMBERDATA_E
	call	GLCDUPDATEOBJECT_NEXTION355
;end Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;end if
ENDIF2
;end select
SysSelectEnd2
;Page 1 events... there is only one, so, just change page
;case PAGE1
	goto	SysSelectEnd1
SysSelect1Case2
	decf	BGETC,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;displayPage0
	call	DISPLAYPAGE0
;end select
SysSelectEnd1
;end if
ENDIF1
;loop
	goto	SysDoLoop_S2
SysDoLoop_E2
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;Simply a method as we can call this more that once.
;Utility methods - these are required to support the Interrupt routines - no need to change
;PPS Tool version: 0.0.5.27
;PinManager data: v1.78
;Generated for 16F1705
;
;Template comment at the start of the config file
;
;#define PPSToolPart 16F1705
;Template comment at the end of the config file
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: nexion_tutorial_16f1705.gcb (179)
FN_BGETC
;wait while !(bkbhit)
SysWaitLoop1
	movf	NEXT_IN,W
	movwf	SysBYTETempA
	movf	NEXT_OUT,W
	movwf	SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	comf	SysTemp1,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	SysWaitLoop1
;bgetc = buffer(next_out)
	movlw	low(BUFFER)
	addwf	NEXT_OUT,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(BUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	BGETC
;next_out=(next_out+1) % BUFFER_SIZE
	incf	NEXT_OUT,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	255
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempX,W
	movwf	NEXT_OUT
	return

;********************************************************************************

;Source: nexion_tutorial_16f1705.gcb (156)
DISPLAYPAGE0
;Send an instruction to 'page' change the Nextion
;GLCDSendOpInstruction_Nextion( "page",  "page"+str(PAGE0) )
	movlw	low StringTable9
	movwf	SysNEXTIONOBJECTHandler
	movlw	(high StringTable9) | 128
	movwf	SysNEXTIONOBJECTHandler_H
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low SYSSTRINGPARAM2
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM2
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable9
	movwf	SysStringA
	movlw	(high StringTable9) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low SYSSTRINGPARAM2
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM2
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysNEXTIONSTRINGDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysNEXTIONSTRINGDATAHandler_H
	call	GLCDSENDOPINSTRUCTION_NEXTION
;wait for display
;wait 750 ms
	movlw	238
	movwf	SysWaitTempMS
	movlw	2
	movwf	SysWaitTempMS_H
	call	Delay_MS
;Update the page text
;GLCDUpdateObject_Nextion( TEXTCOMPONENT+".txt", stringOutToNextion  )
	movlw	low SYSSTRINGPARAM2
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM2
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable3
	movwf	SysStringA
	movlw	(high StringTable3) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low StringTable12
	movwf	SysStringA
	movlw	(high StringTable12) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low SYSSTRINGPARAM2
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM2
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysNEXTIONOBJECTHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysNEXTIONOBJECTHandler_H
	movlw	low STRINGOUTTONEXTION
	movwf	SysNEXTIONSTRINGDATAHandler
	movlw	high STRINGOUTTONEXTION
	movwf	SysNEXTIONSTRINGDATAHandler_H
	goto	GLCDUPDATEOBJECT_NEXTION354

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

;Source: glcd_nextion.h (465)
GLCDSENDOPINSTRUCTION_NEXTION
;GLCD_NextionSerialPrint nextionobject
	movf	SysNEXTIONOBJECTHandler,W
	movwf	SysPRINTDATAHandler
	movf	SysNEXTIONOBJECTHandler_H,W
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialPrint " "
	movlw	low StringTable58
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable58) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialPrint nextionstringData
	movf	SysNEXTIONSTRINGDATAHandler,W
	movwf	SysPRINTDATAHandler
	movf	SysNEXTIONSTRINGDATAHandler_H,W
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	goto	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:STRING:, Source: glcd_nextion.h (429)
GLCDUPDATEOBJECT_NEXTION354
;GLCD_NextionSerialPrint nextionobject
	movf	SysNEXTIONOBJECTHandler,W
	movwf	SysPRINTDATAHandler
	movf	SysNEXTIONOBJECTHandler_H,W
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialPrint"="
	movlw	low StringTable57
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable57) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialSend 34
	movlw	34
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialPrint nextionstringData
	movf	SysNEXTIONSTRINGDATAHandler,W
	movwf	SysPRINTDATAHandler
	movf	SysNEXTIONSTRINGDATAHandler_H,W
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialSend 34
	movlw	34
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	goto	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:LONG:, Source: glcd_nextion.h (443)
GLCDUPDATEOBJECT_NEXTION355
;GLCD_NextionSerialPrint nextionobject
	movf	SysNEXTIONOBJECTHandler,W
	movwf	SysPRINTDATAHandler
	movf	SysNEXTIONOBJECTHandler_H,W
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialPrint"="
	movlw	low StringTable57
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable57) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialPrint nextionnumberData
	movf	NEXTIONNUMBERDATA,W
	movwf	SERPRINTVAL
	movf	NEXTIONNUMBERDATA_H,W
	movwf	SERPRINTVAL_H
	movf	NEXTIONNUMBERDATA_U,W
	movwf	SERPRINTVAL_U
	movf	NEXTIONNUMBERDATA_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	movwf	COMPORT
	call	HSERPRINT674
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	goto	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:INTEGER:, Source: glcd_nextion.h (454)
GLCDUPDATEOBJECT_NEXTION356
;GLCD_NextionSerialPrint nextionobject
	movf	SysNEXTIONOBJECTHandler,W
	movwf	SysPRINTDATAHandler
	movf	SysNEXTIONOBJECTHandler_H,W
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialPrint"="
	movlw	low StringTable57
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable57) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;GLCD_NextionSerialPrint nextionnumberData
	movf	NEXTIONNUMBERDATA,W
	movwf	SERPRINTVALINT
	movf	NEXTIONNUMBERDATA_H,W
	movwf	SERPRINTVALINT_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT673
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	goto	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (1251)
HSERPRINT670
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	ENDIF12
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SERDATA
	call	HSERSEND660
;next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;End If
ENDIF12
;CR
	return

;********************************************************************************

;Overloaded signature: WORD:byte:, Source: usart.h (1302)
HSERPRINT672
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;If SerPrintVal >= 10000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF24
;OutValueTemp = SerPrintVal / 10000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND660
;Goto HSerPrintWord1000
	goto	HSERPRINTWORD1000
;End If
ENDIF24
;If SerPrintVal >= 1000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF25
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND660
;Goto HSerPrintWord100
	goto	HSERPRINTWORD100
;End If
ENDIF25
;If SerPrintVal >= 100 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF26
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND660
;Goto HSerPrintWord10
	goto	HSERPRINTWORD10
;End If
ENDIF26
;If SerPrintVal >= 10 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF27
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	call	HSERSEND660
;End If
ENDIF27
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	call	HSERSEND659
;CR
	return

;********************************************************************************

;Overloaded signature: INTEGER:byte:, Source: usart.h (1350)
HSERPRINT673
;Dim SerPrintVal As Word
;If sign bit is on, print - sign and then negate
;If SerPrintValInt.15 = On Then
	btfss	SERPRINTVALINT_H,7
	goto	ELSE15_1
;HSerSend("-",comport )
	movlw	45
	movwf	SERDATA
	call	HSERSEND659
;SerPrintVal = -SerPrintValInt
	comf	SERPRINTVALINT,W
	movwf	SERPRINTVAL
	comf	SERPRINTVALINT_H,W
	movwf	SERPRINTVAL_H
	incf	SERPRINTVAL,F
	btfsc	STATUS,Z
	incf	SERPRINTVAL_H,F
;Sign bit off, so just copy value
;Else
	goto	ENDIF15
ELSE15_1
;SerPrintVal = SerPrintValInt
	movf	SERPRINTVALINT,W
	movwf	SERPRINTVAL
	movf	SERPRINTVALINT_H,W
	movwf	SERPRINTVAL_H
;End If
ENDIF15
;Use Print(word) to display value
;HSerPrint SerPrintVal,comport
	goto	HSERPRINT672

;********************************************************************************

;Overloaded signature: LONG:byte:, Source: usart.h (1368)
HSERPRINT674
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S3
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SERPRINTVAL,W
	movwf	SysLONGTempA
	movf	SERPRINTVAL_H,W
	movwf	SysLONGTempA_H
	movf	SERPRINTVAL_U,W
	movwf	SysLONGTempA_U
	movf	SERPRINTVAL_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempX,W
	movwf	INDF0
;SerPrintVal = SysCalcTempA
	movf	SYSCALCTEMPA,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPA_H,W
	movwf	SERPRINTVAL_H
	movf	SYSCALCTEMPA_U,W
	movwf	SERPRINTVAL_U
	movf	SYSCALCTEMPA_E,W
	movwf	SERPRINTVAL_E
;Loop While SerPrintVal <> 0
	movf	serprintval,W
	movwf	SysLONGTempA
	movf	serprintval_H,W
	movwf	SysLONGTempA_H
	movf	serprintval_U,W
	movwf	SysLONGTempA_U
	movf	serprintval_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysCompEqual32
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S3
SysDoLoop_E3
;Display
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	incf	SYSPRINTBUFFLEN,W
	movwf	SYSPRINTTEMP
	movlw	1
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
SysForLoop2
	decf	SYSPRINTTEMP,F
;HSerSend(SysPrintBuffer(SysPrintTemp) + 48, comport  )
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTTEMP,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	INDF0,W
	movwf	SERDATA
	call	HSERSEND660
;Next
	movf	SYSPRINTTEMP,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;CR
	return

;********************************************************************************

;Overloaded signature: , Source: usart.h (927)
FN_HSERRECEIVE661
;Comport = 1
	movlw	1
	movwf	COMPORT
;HSerReceive( SerData )
	call	HSERRECEIVE665
;HSerReceive = SerData
	movf	SERDATA,W
	movwf	HSERRECEIVE
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (954)
HSERRECEIVE665
;Needs comport to be set first by calling routines
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF9
;SerData = DefaultUsartReturnValue
	movlw	255
	movwf	SERDATA
;If set up to block, wait for data
;Wait Until USARTHasData
SysWaitLoop3
	btfss	PIR1,RCIF
	goto	SysWaitLoop3
;Get a byte from FIFO
;If USARTHasData Then
	btfss	PIR1,RCIF
	goto	ENDIF10
;SerData = RCREG1
	banksel	RCREG1
	movf	RCREG1,W
	banksel	SERDATA
	movwf	SERDATA
;End if
ENDIF10
;IF OERR then
	banksel	RC1STA
	btfss	RC1STA,OERR
	goto	ENDIF11
;Set CREN off
	bcf	RC1STA,CREN
;Set CREN On
	bsf	RC1STA,CREN
;END IF
ENDIF11
;end if
ENDIF9
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (653)
HSERSEND659
;Registers/Bits determined by #samevar at top of library
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR1,TXIF
	goto	SysWaitLoop2
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (736)
HSERSEND660
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF23
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop4
	btfss	PIR1,TXIF
	goto	SysWaitLoop4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
;end if
ENDIF23
	banksel	STATUS
	return

;********************************************************************************

;Source: glcd_nextion.h (66)
INITGLCD_NEXTION
;Setup code for Nextion controllers
;dim PrintLocX, PrintLocY as word
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;PrintLocX = 0
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
;PrintLocY = 0
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;SendParam_Nextion ( "rest", true )  '  reset the device
	movlw	low StringTable49
	movwf	SysOUTSTRINGHandler
	movlw	(high StringTable49) | 128
	movwf	SysOUTSTRINGHandler_H
	movlw	255
	movwf	OUTSTATE
	call	SENDPARAM_NEXTION331
;Default Colours
;GLCDBACKGROUND = TFT_BLACK
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDFontWidth = 6
	movlw	6
	movwf	GLCDFONTWIDTH
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
	return

;********************************************************************************

;Source: nexion_tutorial_16f1705.gcb (193)
INITPPS
;Module: EUSART
;RXPPS = 0x0015    'RC5 > RX
	movlw	21
	banksel	RXPPS
	movwf	RXPPS
;RC4PPS = 0x0014    'TX > RC4
	movlw	20
	banksel	RC4PPS
	movwf	RC4PPS
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (99)
INITSYS
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;equates to OSCCON = OSCCON AND b'10000111' & OSCCON = OSCCON OR b'11110000'
;= 32Mhz
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
;Set SPLLEN On
	bsf	OSCCON,SPLLEN
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
;PORTC = 0
	clrf	PORTC
	return

;********************************************************************************

;Source: usart.h (454)
INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	movlw	64
	banksel	SPBRG
	movwf	SPBRG
;SPBRGH = SPBRGH_TEMP
	movlw	3
	movwf	SP1BRGH
;BRG16 = BRG16_TEMP
	bsf	BAUD1CON,BRG16
;BRGH = BRGH_TEMP
	bsf	TX1STA,BRGH
;Enable async and TX mode for most non K42
;Set SYNC Off
	bcf	TX1STA,SYNC
;Set TXEN On
	bsf	TX1STA,TXEN
;SPEN=1
	bsf	RC1STA,SPEN
;Enable TX and RX
;CREN=1
	bsf	RC1STA,CREN
	banksel	STATUS
	return

;********************************************************************************

;Source: nexion_tutorial_16f1705.gcb (169)
READUSART
;dim temppnt as byte
;buffer(next_in) = HSerReceive
	call	FN_HSERRECEIVE661
	movlw	low(BUFFER)
	addwf	NEXT_IN,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(BUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	SYSHSERRECEIVEBYTE,W
	movwf	INDF0
;temppnt = next_in
	movf	NEXT_IN,W
	movwf	TEMPPNT
;next_in = ( next_in + 1 ) % BUFFER_SIZE
	incf	NEXT_IN,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	255
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempX,W
	movwf	NEXT_IN
;if ( next_in = next_out ) then  ' buffer is full so overflow
	movf	NEXT_OUT,W
	subwf	NEXT_IN,W
	btfss	STATUS, Z
	goto	ENDIF4
;next_in = temppnt
	movf	TEMPPNT,W
	movwf	NEXT_IN
;end if
ENDIF4
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: glcd_nextion.h (126)
SENDPARAM_NEXTION331
;GLCD_NextionSerialPrint outstring
	movf	SysOUTSTRINGHandler,W
	movwf	SysPRINTDATAHandler
	movf	SysOUTSTRINGHandler_H,W
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT670
;if outstate = false then
	movf	OUTSTATE,F
	btfss	STATUS, Z
	goto	ELSE18_1
;GLCD_NextionSerialSend 44
	movlw	44
	movwf	SERDATA
	call	HSERSEND659
;else
	goto	ENDIF18
ELSE18_1
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;GLCD_NextionSerialSend 255
	movlw	255
	movwf	SERDATA
	call	HSERSEND659
;end if
ENDIF18
	return

;********************************************************************************

;Source: string.h (75)
FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF5
;SysStrData = SysValTemp / 10000
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF5
;Thousands
;IF SysValTemp >= 1000 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF6
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF6
;Hundreds
;IF SysValTemp >= 100 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF7
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF7
;Tens
;IF SysValTemp >= 10 Then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF8
SYSVALTENS
;SysStrData = SysValTemp / 10
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF8
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSVALTEMP,W
	movwf	INDF0
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;Str(0) = SysCharCount
	movf	SYSCHARCOUNT,W
	banksel	SYSSTR_0
	movwf	SYSSTR_0
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (2613)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2639)
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

;Source: system.h (2693)
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

;Source: system.h (2810)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (1043)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysCopyStringCheck
	goto	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
SYSSTRINGCOPY
;Increment pointers
;addfsr 0, 1
	addfsr	0, 1
;addfsr 1, 1
	addfsr	1, 1
;Copy character
;movf INDF0, W
	movf	INDF0, W
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringCopy
	goto	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (2389)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;return
	return
;Main calc routine
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	rlf	SYSBYTETEMPX, F
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0
;btfsc STATUS, C
	btfsc	STATUS, C
;goto Div8NotNeg
	goto	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv8Start
	goto	SYSDIV8START
	return

;********************************************************************************

;Source: system.h (2457)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF19
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF19
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF20
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF20
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (2533)
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
	goto	ENDIF21
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF21
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
	goto	ENDIF22
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
ENDIF22
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

;Source: system.h (1240)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy
SYSSTRINGREAD
;Get char
;call SysStringTables
	call	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	addfsr	1,1
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
	goto	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	2
	retlw	114	;r
	retlw	48	;0


StringTable2
	retlw	2
	retlw	110	;n
	retlw	48	;0


StringTable3
	retlw	2
	retlw	116	;t
	retlw	51	;3


StringTable4
	retlw	3
	retlw	80	;P
	retlw	73	;I
	retlw	67	;C


StringTable6
	retlw	2
	retlw	32	; 
	retlw	64	;


StringTable7
	retlw	3
	retlw	77	;M
	retlw	104	;h
	retlw	122	;z


StringTable8
	retlw	4
	retlw	46	;.
	retlw	118	;v
	retlw	97	;a
	retlw	108	;l


StringTable9
	retlw	4
	retlw	112	;p
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e


StringTable10
	retlw	4
	retlw	46	;.
	retlw	98	;b
	retlw	99	;c
	retlw	111	;o


StringTable11
	retlw	4
	retlw	46	;.
	retlw	112	;p
	retlw	99	;c
	retlw	111	;o


StringTable12
	retlw	4
	retlw	46	;.
	retlw	116	;t
	retlw	120	;x
	retlw	116	;t


StringTable36
	retlw	1
	retlw	45	;-


StringTable49
	retlw	4
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t


StringTable57
	retlw	1
	retlw	61	; (equals)


StringTable58
	retlw	1
	retlw	32	; 


StringTable107
	retlw	7
	retlw	49	;1
	retlw	54	;6
	retlw	70	;F
	retlw	49	;1
	retlw	55	;7
	retlw	48	;0
	retlw	53	;5


;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
