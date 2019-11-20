;Program compiled by Great Cow BASIC (0.98.<<>> 2019-11-14 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F24K42, r=DEC
#include <P18F24K42.inc>
 CONFIG CP = OFF, LVP = OFF, WRTD = OFF, WDTE = OFF, MVECEN = OFF, MCLRE = INTMCLR, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
BGETC	EQU	13
BUFFER	EQU	769
BYTEVALUEOUTTONEXTION	EQU	16
COMPORT	EQU	17
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
GLCDBACKGROUND	EQU	18
GLCDBACKGROUND_H	EQU	19
GLCDFNTDEFAULT	EQU	20
GLCDFNTDEFAULTSIZE	EQU	21
GLCDFONTWIDTH	EQU	22
GLCD_YORDINATE	EQU	23
GLCD_YORDINATE_H	EQU	24
HSERRECEIVE	EQU	25
INCOMINGBYTEFROMNEXTION	EQU	26
NEXTIONNUMBERDATA	EQU	27
NEXTIONNUMBERDATA_E	EQU	30
NEXTIONNUMBERDATA_H	EQU	28
NEXTIONNUMBERDATA_U	EQU	29
NEXT_IN	EQU	31
NEXT_OUT	EQU	32
OUTSTATE	EQU	33
OUTVALUETEMP	EQU	34
PRINTLEN	EQU	35
PRINTLOCX	EQU	36
PRINTLOCX_H	EQU	37
PRINTLOCY	EQU	38
PRINTLOCY_H	EQU	39
SAVEFSR0H	EQU	40
SAVEFSR0L	EQU	41
SAVESYSBYTETEMPA	EQU	42
SAVESYSBYTETEMPB	EQU	43
SAVESYSBYTETEMPX	EQU	44
SAVESYSDIVLOOP	EQU	45
SAVESYSTEMP1	EQU	46
SERDATA	EQU	47
SERPRINTVAL	EQU	48
SERPRINTVALINT	EQU	52
SERPRINTVALINT_H	EQU	53
SERPRINTVAL_E	EQU	51
SERPRINTVAL_H	EQU	49
SERPRINTVAL_U	EQU	50
STR	EQU	711
STRINGOUTTONEXTION	EQU	728
STRINGPOINTER	EQU	54
SYSBSR	EQU	55
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPA_E	EQU	8
SYSCALCTEMPA_H	EQU	6
SYSCALCTEMPA_U	EQU	7
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSCHARCOUNT	EQU	56
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSLONGDIVMULTA	EQU	57
SYSLONGDIVMULTA_E	EQU	60
SYSLONGDIVMULTA_H	EQU	58
SYSLONGDIVMULTA_U	EQU	59
SYSLONGDIVMULTB	EQU	61
SYSLONGDIVMULTB_E	EQU	64
SYSLONGDIVMULTB_H	EQU	62
SYSLONGDIVMULTB_U	EQU	63
SYSLONGDIVMULTX	EQU	65
SYSLONGDIVMULTX_E	EQU	68
SYSLONGDIVMULTX_H	EQU	66
SYSLONGDIVMULTX_U	EQU	67
SYSLONGTEMPA	EQU	5
SYSLONGTEMPA_E	EQU	8
SYSLONGTEMPA_H	EQU	6
SYSLONGTEMPA_U	EQU	7
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSLONGTEMPX	EQU	0
SYSLONGTEMPX_E	EQU	3
SYSLONGTEMPX_H	EQU	1
SYSLONGTEMPX_U	EQU	2
SYSNEXTIONOBJECTHANDLER	EQU	69
SYSNEXTIONOBJECTHANDLER_H	EQU	70
SYSNEXTIONSTRINGDATAHANDLER	EQU	71
SYSNEXTIONSTRINGDATAHANDLER_H	EQU	72
SYSOUTSTRINGHANDLER	EQU	73
SYSOUTSTRINGHANDLER_H	EQU	74
SYSPRINTBUFFER	EQU	717
SYSPRINTBUFFLEN	EQU	75
SYSPRINTDATAHANDLER	EQU	76
SYSPRINTDATAHANDLER_H	EQU	77
SYSPRINTTEMP	EQU	78
SYSREPEATTEMP1	EQU	79
SYSSTATUS	EQU	15
SYSSTRDATA	EQU	80
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	706
SYSSTRINGPARAM2	EQU	701
SYSSTRINGPARAM3	EQU	696
SYSSTRINGPARAM4	EQU	691
SYSSTRINGPARAM5	EQU	686
SYSSTRINGPARAM6	EQU	681
SYSTEMP1	EQU	81
SYSTEMP1_E	EQU	84
SYSTEMP1_H	EQU	82
SYSTEMP1_U	EQU	83
SYSTEMP2	EQU	85
SYSVALTEMP	EQU	86
SYSVALTEMP_H	EQU	87
SYSW	EQU	14
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
TEMPPNT	EQU	88

;********************************************************************************

;Alias variables
AFSR0	EQU	16361
AFSR0_H	EQU	16362
SYSHSERRECEIVEBYTE	EQU	25
SYSSTR_0	EQU	711

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
	rcall	INITPPS
	rcall	INITUSART
	rcall	INITGLCD_NEXTION
;Enable interrupts
	bsf	INTCON0,GIE,ACCESS

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
;On Interrupt UART1ReceiveInterrupt Call readUSART
	banksel	PIE3
	bsf	PIE3,U1RXIE,BANKED
;Constants required for Buffer Ring
;#define BUFFER_SIZE 255
;#define bkbhit (next_in <> next_out)
;Declare the required variables
;Dim buffer( BUFFER_SIZE - 1 ) '
;Dim next_in as byte: next_in = 0
	clrf	NEXT_IN,ACCESS
;Dim next_out as byte: next_out = 0
	clrf	NEXT_OUT,ACCESS
;----- Declare the variables we need for this tutorial
;dim byteValueOutToNextion as byte
;dim inComingByteFromNextion as byte
;dim stringOutToNextion as string
;----- Set the LED as an output
;dir LED1 out
	bcf	TRISA,0,ACCESS
;Create a string for text component - this will state the type of microcontroller and the frequency of the microcontroller
;stringOutToNextion = "PIC"
	lfsr	1,STRINGOUTTONEXTION
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
;stringOutToNextion = stringOutToNextion + ChipNameStr + " @"+str(ChipMHz)+"Mhz"
	movlw	1
	movwf	SYSVALTEMP,ACCESS
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	lfsr	1,STRINGOUTTONEXTION
	clrf	SysStringLength,ACCESS
	lfsr	0,STRINGOUTTONEXTION
	call	SysCopyStringPart
	movlw	low StringTable107
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable107
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,STR
	call	SysCopyStringPart
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,STRINGOUTTONEXTION
	movffl	SysStringLength,INDF0
;Initialise page0
;displayPage0
	rcall	DISPLAYPAGE0
;Main loop, never exits
;do
SysDoLoop_S1
;Update the n0.val object
;byteValueOutToNextion = (byteValueOutToNextion + 1) % 101
	incf	BYTEVALUEOUTTONEXTION,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	movlw	101
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempX,BYTEVALUEOUTTONEXTION
;GLCDUpdateObject_Nextion( NUMBERCOMPONENT+".val",  byteValueOutToNextion )
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler_H,ACCESS
	movff	BYTEVALUEOUTTONEXTION,NEXTIONNUMBERDATA
	clrf	NEXTIONNUMBERDATA_H,ACCESS
	rcall	GLCDUPDATEOBJECT_NEXTION356
;wait 50 ms
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;react to incoming data, if bkbhit is TRUE then we have some serial data!
;do while bkbhit
SysDoLoop_S2
	movf	NEXT_OUT,W,ACCESS
	subwf	NEXT_IN,W,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E2
;Has a Nextion Touch Event happended.  bgetc is the next serial byte, so, we can test it.
;Once bgetc is tested the serial byte has been consumed and the next byte is availalbe in the buffer.
;if bgetc = TouchEvent then
	rcall	FN_BGETC
	movlw	101
	subwf	BGETC,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF1
;The next bgetc byte in the buffer is the originating Nextion page
;select case bgetc
	rcall	FN_BGETC
;Page 0 events... there are potenially a few, so we need to test the next byte to set which component caused the event
;case PAGE0
SysSelect1Case1
	movf	BGETC,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;The next bgetc byte in the buffer is the  component ID that caused the event
;select case bgetc
	rcall	FN_BGETC
;Page change pressed
;case SELECTPAGE1BUTTON
SysSelect2Case1
	decf	BGETC,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;Send an instruction to 'page' change the Nextion
;GLCDSendOpInstruction_Nextion( "page",  "page"+str(PAGE1) )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler_H,ACCESS
	movlw	1
	movwf	SYSVALTEMP,ACCESS
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM2
	clrf	SysStringLength,ACCESS
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,STR
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM2
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM2
	movwf	SysNEXTIONSTRINGDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM2
	movwf	SysNEXTIONSTRINGDATAHandler_H,ACCESS
	rcall	GLCDSENDOPINSTRUCTION_NEXTION
;Toggle LED pressed or released
;case TOGGLELEDBUTTON
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	BGETC,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;The next byte is the state of the TOGGLELEDBUTTON 0 or 1
;inComingByteFromNextion  = bgetc
	rcall	FN_BGETC
	movff	BGETC,INCOMINGBYTEFROMNEXTION
;Set the LED state to TOGGLELEDBUTTON state
;LED1 = inComingByteFromNextion
	bcf	LATA,0,ACCESS
	btfsc	INCOMINGBYTEFROMNEXTION,0,ACCESS
	bsf	LATA,0,ACCESS
;Tell the Nextion the LED is ON
;if inComingByteFromNextion = 1 then
	decf	INCOMINGBYTEFROMNEXTION,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF2
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp1,ACCESS
SysRepeatLoop1
;GLCDUpdateObject_Nextion( RADIOCOMPONENT+".bco",  [long]63488 )
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler_H,ACCESS
	clrf	NEXTIONNUMBERDATA,ACCESS
	movlw	248
	movwf	NEXTIONNUMBERDATA_H,ACCESS
	clrf	NEXTIONNUMBERDATA_U,ACCESS
	clrf	NEXTIONNUMBERDATA_E,ACCESS
	rcall	GLCDUPDATEOBJECT_NEXTION355
;GLCDUpdateObject_Nextion( RADIOCOMPONENT+".pco",  [long]63488 )
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler,ACCESS
	movlw	high SYSSTRINGPARAM1
	movwf	SysNEXTIONOBJECTHandler_H,ACCESS
	clrf	NEXTIONNUMBERDATA,ACCESS
	movlw	248
	movwf	NEXTIONNUMBERDATA_H,ACCESS
	clrf	NEXTIONNUMBERDATA_U,ACCESS
	clrf	NEXTIONNUMBERDATA_E,ACCESS
	rcall	GLCDUPDATEOBJECT_NEXTION355
;end Repeat
	decfsz	SysRepeatTemp1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;end if
ENDIF2
;end select
SysSelectEnd2
;Page 1 events... there is only one, so, just change page
;case PAGE1
	bra	SysSelectEnd1
SysSelect1Case2
	decf	BGETC,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
;displayPage0
	rcall	DISPLAYPAGE0
;end select
SysSelectEnd1
;end if
ENDIF1
;loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;Simply a method as we can call this more that once.
;Utility methods - these are required to support the Interrupt routines - no need to change
;PPS Tool version: 0.0.5.27
;PinManager data: v1.78
;Generated for 18F24K42
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18F24K42
;Template comment at the end of the config file
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: nexion_tutorial_18F24K42.gcb (179)
FN_BGETC
;wait while !(bkbhit)
SysWaitLoop1
	movff	NEXT_IN,SysBYTETempA
	movff	NEXT_OUT,SysBYTETempB
	rcall	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	comf	SysTemp1,W,ACCESS
	movwf	SysTemp2,ACCESS
	btfsc	SysTemp2,0,ACCESS
	bra	SysWaitLoop1
;bgetc = buffer(next_out)
	lfsr	0,BUFFER
	movf	NEXT_OUT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,BGETC
;next_out=(next_out+1) % BUFFER_SIZE
	incf	NEXT_OUT,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	setf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempX,NEXT_OUT
	return

;********************************************************************************

;Source: nexion_tutorial_18F24K42.gcb (156)
DISPLAYPAGE0
;Send an instruction to 'page' change the Nextion
;GLCDSendOpInstruction_Nextion( "page",  "page"+str(PAGE0) )
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	movwf	SysNEXTIONOBJECTHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysNEXTIONOBJECTHandler_H,ACCESS
	clrf	SYSVALTEMP,ACCESS
	clrf	SYSVALTEMP_H,ACCESS
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM4
	clrf	SysStringLength,ACCESS
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,STR
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM4
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM4
	movwf	SysNEXTIONSTRINGDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM4
	movwf	SysNEXTIONSTRINGDATAHandler_H,ACCESS
	rcall	GLCDSENDOPINSTRUCTION_NEXTION
;wait for display
;wait 750 ms
	movlw	238
	movwf	SysWaitTempMS,ACCESS
	movlw	2
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Update the page text
;GLCDUpdateObject_Nextion( TEXTCOMPONENT+".txt", stringOutToNextion  )
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM3
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM3
	movwf	SysNEXTIONOBJECTHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysNEXTIONOBJECTHandler_H,ACCESS
	movlw	low STRINGOUTTONEXTION
	movwf	SysNEXTIONSTRINGDATAHandler,ACCESS
	movlw	high STRINGOUTTONEXTION
	movwf	SysNEXTIONSTRINGDATAHandler_H,ACCESS
	bra	GLCDUPDATEOBJECT_NEXTION354

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	4
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	19
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

;Source: glcd_nextion.h (465)
GLCDSENDOPINSTRUCTION_NEXTION
;GLCD_NextionSerialPrint nextionobject
	movff	SysNEXTIONOBJECTHandler,SysPRINTDATAHandler
	movff	SysNEXTIONOBJECTHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialPrint " "
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM6
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM6
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialPrint nextionstringData
	movff	SysNEXTIONSTRINGDATAHandler,SysPRINTDATAHandler
	movff	SysNEXTIONSTRINGDATAHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	bra	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:STRING:, Source: glcd_nextion.h (429)
GLCDUPDATEOBJECT_NEXTION354
;GLCD_NextionSerialPrint nextionobject
	movff	SysNEXTIONOBJECTHandler,SysPRINTDATAHandler
	movff	SysNEXTIONOBJECTHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialPrint"="
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable57
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable57
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialSend 34
	movlw	34
	movwf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialPrint nextionstringData
	movff	SysNEXTIONSTRINGDATAHandler,SysPRINTDATAHandler
	movff	SysNEXTIONSTRINGDATAHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialSend 34
	movlw	34
	movwf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	bra	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:LONG:, Source: glcd_nextion.h (443)
GLCDUPDATEOBJECT_NEXTION355
;GLCD_NextionSerialPrint nextionobject
	movff	SysNEXTIONOBJECTHandler,SysPRINTDATAHandler
	movff	SysNEXTIONOBJECTHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialPrint"="
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable57
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable57
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialPrint nextionnumberData
	movff	NEXTIONNUMBERDATA,SERPRINTVAL
	movff	NEXTIONNUMBERDATA_H,SERPRINTVAL_H
	movff	NEXTIONNUMBERDATA_U,SERPRINTVAL_U
	movff	NEXTIONNUMBERDATA_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT674
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	bra	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:INTEGER:, Source: glcd_nextion.h (454)
GLCDUPDATEOBJECT_NEXTION356
;GLCD_NextionSerialPrint nextionobject
	movff	SysNEXTIONOBJECTHandler,SysPRINTDATAHandler
	movff	SysNEXTIONOBJECTHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialPrint"="
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable57
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable57
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H,ACCESS
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;GLCD_NextionSerialPrint nextionnumberData
	movff	NEXTIONNUMBERDATA,SERPRINTVALINT
	movff	NEXTIONNUMBERDATA_H,SERPRINTVALINT_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT673
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	bra	HSERSEND659

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (1252)
HSERPRINT670
;PrintLen = PrintData(0)
	movffl	SysPRINTDATAHandler,AFSR0
	movffl	SysPRINTDATAHandler_H,AFSR0_H
	movffl	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,ACCESS
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF10
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	PRINTLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	SysPRINTDATAHandler,W,ACCESS
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,ACCESS
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SERDATA
	rcall	HSERSEND660
;next
	movf	PRINTLEN,W,ACCESS
	subwf	SYSPRINTTEMP,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;End If
ENDIF10
;CR
	return

;********************************************************************************

;Overloaded signature: WORD:byte:, Source: usart.h (1303)
HSERPRINT672
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	clrf	OUTVALUETEMP,ACCESS
;If SerPrintVal >= 10000 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF22
;OutValueTemp = SerPrintVal / 10000 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND660
;Goto HSerPrintWord1000
	bra	HSERPRINTWORD1000
;End If
ENDIF22
;If SerPrintVal >= 1000 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF23
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND660
;Goto HSerPrintWord100
	bra	HSERPRINTWORD100
;End If
ENDIF23
;If SerPrintVal >= 100 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF24
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND660
;Goto HSerPrintWord10
	bra	HSERPRINTWORD10
;End If
ENDIF24
;If SerPrintVal >= 10 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF25
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND660
;End If
ENDIF25
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	addwf	SERPRINTVAL,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND659
;CR
	return

;********************************************************************************

;Overloaded signature: INTEGER:byte:, Source: usart.h (1351)
HSERPRINT673
;Dim SerPrintVal As Word
;If sign bit is on, print - sign and then negate
;If SerPrintValInt.15 = On Then
	btfss	SERPRINTVALINT_H,7,ACCESS
	bra	ELSE13_1
;HSerSend("-",comport )
	movlw	45
	movwf	SERDATA,ACCESS
	rcall	HSERSEND659
;SerPrintVal = -SerPrintValInt
	comf	SERPRINTVALINT,W,ACCESS
	movwf	SERPRINTVAL,ACCESS
	comf	SERPRINTVALINT_H,W,ACCESS
	movwf	SERPRINTVAL_H,ACCESS
	incf	SERPRINTVAL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SERPRINTVAL_H,F,ACCESS
;Sign bit off, so just copy value
;Else
	bra	ENDIF13
ELSE13_1
;SerPrintVal = SerPrintValInt
	movff	SERPRINTVALINT,SERPRINTVAL
	movff	SERPRINTVALINT_H,SERPRINTVAL_H
;End If
ENDIF13
;Use Print(word) to display value
;HSerPrint SerPrintVal,comport
	bra	HSERPRINT672

;********************************************************************************

;Overloaded signature: LONG:byte:, Source: usart.h (1369)
HSERPRINT674
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN,ACCESS
;Do
SysDoLoop_S3
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F,ACCESS
;SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTBUFFLEN,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SERPRINTVAL,SysLONGTempA
	movff	SERPRINTVAL_H,SysLONGTempA_H
	movff	SERPRINTVAL_U,SysLONGTempA_U
	movff	SERPRINTVAL_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysDivSub32
	movffl	SysLONGTempX,INDF0
;SerPrintVal = SysCalcTempA
	movff	SYSCALCTEMPA,SERPRINTVAL
	movff	SYSCALCTEMPA_H,SERPRINTVAL_H
	movff	SYSCALCTEMPA_U,SERPRINTVAL_U
	movff	SYSCALCTEMPA_E,SERPRINTVAL_E
;Loop While SerPrintVal <> 0
	movff	serprintval,SysLONGTempA
	movff	serprintval_H,SysLONGTempA_H
	movff	serprintval_U,SysLONGTempA_U
	movff	serprintval_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysDoLoop_S3
SysDoLoop_E3
;Display
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	incf	SYSPRINTBUFFLEN,W,ACCESS
	movwf	SYSPRINTTEMP,ACCESS
	movlw	1
	subwf	SYSPRINTBUFFLEN,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	decf	SYSPRINTTEMP,F,ACCESS
;HSerSend(SysPrintBuffer(SysPrintTemp) + 48, comport  )
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTTEMP,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	INDF0,W,ACCESS
	movwf	SERDATA,ACCESS
	rcall	HSERSEND660
;Next
	movf	SYSPRINTTEMP,W,ACCESS
	sublw	1
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;CR
	return

;********************************************************************************

;Overloaded signature: , Source: usart.h (927)
FN_HSERRECEIVE661
;Comport = 1
	movlw	1
	movwf	COMPORT,ACCESS
;HSerReceive( SerData )
	rcall	HSERRECEIVE665
;HSerReceive = SerData
	movff	SERDATA,HSERRECEIVE
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (954)
HSERRECEIVE665
;Needs comport to be set first by calling routines
;if comport = 1 Then
	decf	COMPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF9
;SerData = DefaultUsartReturnValue
	setf	SERDATA,ACCESS
;If set up to block, wait for data
;Wait Until USARTHasData
SysWaitLoop3
	banksel	PIR3
	btfss	PIR3,U1RXIF,BANKED
	bra	SysWaitLoop3
;U1RXEN = 1
;U1ERRIR=0
;if ( U1FERIF = 1 or U1RXFOIF = 1 ) then
;'UART1 error - restart
;ON_U1CON1 = 0
;ON_U1CON1 = 1
;else
;SerData = U1RXB
	movffl	U1RXB,SERDATA
;end if
;If USARTHasData Then
;SerData = U1RXB
;end if
;end if
ENDIF9
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (653)
HSERSEND659
;Registers/Bits determined by #samevar at top of library
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	banksel	PIR3
	btfss	PIR3,U1TXIF,BANKED
	bra	SysWaitLoop2
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	movffl	SERDATA,U1TXB
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (736)
HSERSEND660
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	decf	COMPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF21
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop4
	banksel	PIR3
	btfss	PIR3,U1TXIF,BANKED
	bra	SysWaitLoop4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	movffl	SERDATA,U1TXB
;end if
ENDIF21
	banksel	0
	return

;********************************************************************************

;Source: glcd_nextion.h (66)
INITGLCD_NEXTION
;Setup code for Nextion controllers
;dim PrintLocX, PrintLocY as word
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,ACCESS
	clrf	GLCD_YORDINATE_H,ACCESS
;PrintLocX = 0
	clrf	PRINTLOCX,ACCESS
	clrf	PRINTLOCX_H,ACCESS
;PrintLocY = 0
	clrf	PRINTLOCY,ACCESS
	clrf	PRINTLOCY_H,ACCESS
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;SendParam_Nextion ( "rest", true )  '  reset the device
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable49
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable49
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	movwf	SysOUTSTRINGHandler,ACCESS
	movlw	high SYSSTRINGPARAM3
	movwf	SysOUTSTRINGHandler_H,ACCESS
	setf	OUTSTATE,ACCESS
	rcall	SENDPARAM_NEXTION331
;Default Colours
;GLCDBACKGROUND = TFT_BLACK
	clrf	GLCDBACKGROUND,ACCESS
	clrf	GLCDBACKGROUND_H,ACCESS
;GLCDFontWidth = 6
	movlw	6
	movwf	GLCDFONTWIDTH,ACCESS
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,ACCESS
	return

;********************************************************************************

;Source: nexion_tutorial_18F24K42.gcb (194)
INITPPS
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	bcf	TRISC,6,ACCESS
;Dir PORTC.7 In    ' Make RX1 pin an input
	bsf	TRISC,7,ACCESS
;Module: UART1
;RC6PPS = 0x0013    'TX1 > RC6
	movlw	19
	banksel	RC6PPS
	movwf	RC6PPS,BANKED
;U1RXPPS = 0x0017    'RC7 > RX1
	movlw	23
	movwf	U1RXPPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: system.h (99)
INITSYS
;Set up internal oscillator
;Handle OSCCON1 register for parts that have this register
;asm showdebug OSCCON type is 100 'This is the routine to support OSCCON1 config addresss
;osccon type is 100
;OSCCON1 = 0x60 ' NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1,BANKED
;OSCCON3 = 0x00 ' CSWHOLD may proceed; SOSCPWR Low power
	clrf	OSCCON3,BANKED
;OSCEN = 0x00   ' MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
	clrf	OSCEN,BANKED
;OSCTUNE = 0x00 ' HFTUN 0
	clrf	OSCTUNE,BANKED
;The MCU is a ChipFamily16
;Section support many MCUs, 18FxxK40, 18FxxK42 etc etc all have NDIV3 bit
;asm showdebug OSCCON type is 101 ' ChipFamily16 and NDIV3 bit
;osccon type is 101
;Clear NDIV3:0
;NDIV3 = 0
	bcf	OSCCON1,NDIV3,BANKED
;NDIV2 = 0
	bcf	OSCCON1,NDIV2,BANKED
;NDIV1 = 0
	bcf	OSCCON1,NDIV1,BANKED
;NDIV0 = 0
	bcf	OSCCON1,NDIV0,BANKED
;OSCFRQ = 0b00000000   '1mhz
	clrf	OSCFRQ,BANKED
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	clrf	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;End clearing any ANSEL variants in the part
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
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

;Source: usart.h (454)
INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT,ACCESS
;Set baud rate for for 18fxxK42/K83 series UART
;U1BRGH=SPBRGH_TEMP
	banksel	U1BRGH
	clrf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	25
	movwf	U1BRGL,BANKED
;U1BRGS = BRGS1_SCRIPT
	bsf	U1CON0,U1BRGS,BANKED
;U1TXEN=1   'Enable TX1
	bsf	U1CON0,U1TXEN,BANKED
;U1RXEN=1   'Enable RX1
	bsf	U1CON0,U1RXEN,BANKED
;ON_U1CON1=1 'Enable USART1
	bsf	U1CON1,ON_U1CON1,BANKED
	banksel	0
	return

;********************************************************************************

Interrupt
;Use Automatic Context Save for K42 and K83 with MVECEN = OFF.  Interrupt priority not supported
;On Interrupt handlers
	banksel	PIE3
	btfss	PIE3,U1RXIE,BANKED
	bra	NotU1RXIF
	btfss	PIR3,U1RXIF,BANKED
	bra	NotU1RXIF
	banksel	0
	rcall	READUSART
	banksel	PIR3
	bcf	PIR3,U1RXIF,BANKED
	bra	INTERRUPTDONE
NotU1RXIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
	retfie	1
	banksel	0

;********************************************************************************

;Source: nexion_tutorial_18F24K42.gcb (169)
READUSART
;dim temppnt as byte
;buffer(next_in) = HSerReceive
	rcall	FN_HSERRECEIVE661
	lfsr	0,BUFFER
	movf	NEXT_IN,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	SYSHSERRECEIVEBYTE,INDF0
;temppnt = next_in
	movff	NEXT_IN,TEMPPNT
;next_in = ( next_in + 1 ) % BUFFER_SIZE
	incf	NEXT_IN,W,ACCESS
	movwf	SysTemp1,ACCESS
	movff	SysTemp1,SysBYTETempA
	setf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempX,NEXT_IN
;if ( next_in = next_out ) then  ' buffer is full so overflow
	movf	NEXT_OUT,W,ACCESS
	subwf	NEXT_IN,W,ACCESS
	btfsc	STATUS, Z,ACCESS
;next_in = temppnt
	movff	TEMPPNT,NEXT_IN
;end if
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: glcd_nextion.h (126)
SENDPARAM_NEXTION331
;GLCD_NextionSerialPrint outstring
	movff	SysOUTSTRINGHandler,SysPRINTDATAHandler
	movff	SysOUTSTRINGHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	rcall	HSERPRINT670
;if outstate = false then
	movf	OUTSTATE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE16_1
;GLCD_NextionSerialSend 44
	movlw	44
	movwf	SERDATA,ACCESS
	rcall	HSERSEND659
;else
	bra	ENDIF16
ELSE16_1
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;GLCD_NextionSerialSend 255
	setf	SERDATA,ACCESS
	rcall	HSERSEND659
;end if
ENDIF16
	return

;********************************************************************************

;Source: string.h (75)
FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT,ACCESS
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF5
;SysStrData = SysValTemp / 10000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;Goto SysValThousands
	bra	SYSVALTHOUSANDS
;End If
ENDIF5
;Thousands
;IF SysValTemp >= 1000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF6
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;Goto SysValHundreds
	bra	SYSVALHUNDREDS
;End If
ENDIF6
;Hundreds
;IF SysValTemp >= 100 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF7
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;Goto SysValTens
	bra	SYSVALTENS
;End If
ENDIF7
;Tens
;IF SysValTemp >= 10 Then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF8
SYSVALTENS
;SysStrData = SysValTemp / 10
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,ACCESS
	movwf	INDF0,ACCESS
;End If
ENDIF8
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,ACCESS
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,ACCESS
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movff	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

;Source: system.h (2613)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfseq SysByteTempA
	cpfseq	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2639)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysWordTempB, W
	movf	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	cpfseq	SYSWORDTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysWordTempB_H, W
	movf	SYSWORDTEMPB_H, W,ACCESS
;cpfseq SysWordTempA_H
	cpfseq	SYSWORDTEMPA_H,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2693)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	movf	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	cpfseq	SYSLONGTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysLongTempB_H, W
	movf	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	cpfseq	SYSLONGTEMPA_H,ACCESS
;return
	return
;Test upper, exit if false
;movf SysLongTempB_U, W
	movf	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	cpfseq	SYSLONGTEMPA_U,ACCESS
;return
	return
;Test exp, exit if false
;movf SysLongTempB_E, W
	movf	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	cpfseq	SYSLONGTEMPA_E,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2810)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (1043)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movff INDF0, SysCalcTempA
	movffl	INDF0,SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movffl	SYSCALCTEMPA,INDF1
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
	movffl	PREINC0,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (2389)
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

;Source: system.h (2457)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
;Avoid division by zero
;if SysDivMultB = 0 then
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF17
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF17
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysDivMultA Left
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
;Rotate SysDivMultX Left
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF18
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF18
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv16Start
	bra	SYSDIV16START
;SysWordTempA = SysDivMultA
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
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
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX,ACCESS
	clrf	SYSLONGDIVMULTX_H,ACCESS
	clrf	SYSLONGDIVMULTX_U,ACCESS
	clrf	SYSLONGDIVMULTX_E,ACCESS
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movff	SYSLONGDIVMULTB,SysLONGTempA
	movff	SYSLONGDIVMULTB_H,SysLONGTempA_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempA_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF19
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF19
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	rlcf	SYSLONGDIVMULTA,F,ACCESS
	rlcf	SYSLONGDIVMULTA_H,F,ACCESS
	rlcf	SYSLONGDIVMULTA_U,F,ACCESS
	rlcf	SYSLONGDIVMULTA_E,F,ACCESS
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,ACCESS
	rlcf	SYSLONGDIVMULTX_H,F,ACCESS
	rlcf	SYSLONGDIVMULTX_U,F,ACCESS
	rlcf	SYSLONGDIVMULTX_E,F,ACCESS
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	subwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	subwfb	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	subwfb	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	subwfb	SYSLONGDIVMULTX_E,F,ACCESS
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF20
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,ACCESS
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
;End If
ENDIF20
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	bra	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movff	SYSLONGDIVMULTA,SYSLONGTEMPA
	movff	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (1240)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movffl	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movffl	TABLAT,INDF1
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
	movffl	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	2,114,48


StringTable2
	db	2,110,48


StringTable3
	db	2,116,51


StringTable4
	db	3,80,73,67


StringTable6
	db	2,32,64


StringTable7
	db	3,77,104,122


StringTable8
	db	4,46,118,97,108


StringTable9
	db	4,112,97,103,101


StringTable10
	db	4,46,98,99,111


StringTable11
	db	4,46,112,99,111


StringTable12
	db	4,46,116,120,116


StringTable36
	db	1,45


StringTable49
	db	4,114,101,115,116


StringTable57
	db	1,61


StringTable58
	db	1,32


StringTable107
	db	8,49,56,70,50,52,75,52,50


;********************************************************************************


 END
