;Program compiled by Great Cow BASIC (0.98.04 RC01 2018-10-20 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F45K80, r=DEC
#include <P18F45K80.inc>
 CONFIG MCLRE = ON, WDTEN = OFF, FOSC = INTIO2

;********************************************************************************

;Set aside memory locations for variables
BYTENUMBER	EQU	14
CCOUNT	EQU	15
CHARCODE	EQU	16
CHARCOL	EQU	17
CHARCOLS	EQU	19
CHARCOL_H	EQU	18
CHARLOCX	EQU	20
CHARLOCX_H	EQU	21
CHARLOCY	EQU	22
CHARLOCY_H	EQU	23
CHARROW	EQU	24
CHARROWS	EQU	26
CHARROW_H	EQU	25
COL	EQU	27
COMPORT	EQU	28
CURRCHARCOL	EQU	29
CURRCHARROW	EQU	30
CURRCHARVAL	EQU	31
CURRCOL	EQU	32
CURRPAGE	EQU	33
DDF_X	EQU	34
DDF_X_H	EQU	35
DDF_Y	EQU	36
DDF_Y_H	EQU	37
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
DRAWLINE	EQU	38
DRAWLINE_H	EQU	39
FF	EQU	40
FF_H	EQU	41
FILLCIRCLEXX	EQU	42
FILLCIRCLEYY	EQU	43
GLCDBACKGROUND	EQU	44
GLCDBACKGROUND_H	EQU	45
GLCDBITNO	EQU	46
GLCDCHANGE	EQU	47
GLCDCOLOUR	EQU	48
GLCDCOLOUR_H	EQU	49
GLCDDATATEMP	EQU	50
GLCDFNTDEFAULT	EQU	51
GLCDFNTDEFAULTSIZE	EQU	52
GLCDFONTWIDTH	EQU	53
GLCDFOREGROUND	EQU	54
GLCDFOREGROUND_H	EQU	55
GLCDPRINTLEN	EQU	56
GLCDPRINTLOC	EQU	57
GLCDPRINTLOC_H	EQU	58
GLCDPRINT_STRING_COUNTER	EQU	59
GLCDREADBYTE_NT7108C	EQU	60
GLCDTEMP	EQU	61
GLCDTEMP_H	EQU	62
GLCDX	EQU	63
GLCDY	EQU	64
GLCD_COUNT	EQU	65
GLCD_YORDINATE	EQU	66
GLCD_YORDINATE_H	EQU	67
HEX	EQU	3522
INXRADIUS	EQU	68
INXRADIUS_H	EQU	69
LCDBYTE	EQU	70
LCDVALUE	EQU	71
LCDVALUE_E	EQU	74
LCDVALUE_H	EQU	72
LCDVALUE_U	EQU	73
LINECOLOUR	EQU	75
LINECOLOUR_H	EQU	76
LINEDIFFX	EQU	77
LINEDIFFX_H	EQU	78
LINEDIFFX_X2	EQU	79
LINEDIFFX_X2_H	EQU	80
LINEDIFFY	EQU	81
LINEDIFFY_H	EQU	82
LINEDIFFY_X2	EQU	83
LINEDIFFY_X2_H	EQU	84
LINEERR	EQU	85
LINEERR_H	EQU	86
LINESTEPX	EQU	87
LINESTEPX_H	EQU	88
LINESTEPY	EQU	89
LINESTEPY_H	EQU	90
LINEX1	EQU	91
LINEX1_H	EQU	92
LINEX2	EQU	93
LINEX2_H	EQU	94
LINEY1	EQU	95
LINEY1_H	EQU	96
LINEY2	EQU	97
LINEY2_H	EQU	98
LONGNUMBER	EQU	99
LONGNUMBER_E	EQU	102
LONGNUMBER_H	EQU	100
LONGNUMBER_U	EQU	101
OUTSTRING	EQU	3605
PAD	EQU	3564
PRINTLEN	EQU	103
PRINTLOCX	EQU	104
PRINTLOCX_H	EQU	105
PRINTLOCY	EQU	106
PRINTLOCY_H	EQU	107
RADIUSERR	EQU	108
RADIUSERR_H	EQU	109
ROW	EQU	110
SERDATA	EQU	111
STR	EQU	3526
STRINGLOCX	EQU	112
STRINGPOINTER	EQU	113
SYSARRAYTEMP1	EQU	114
SYSARRAYTEMP2	EQU	115
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPA_E	EQU	8
SYSCALCTEMPA_H	EQU	6
SYSCALCTEMPA_U	EQU	7
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSCHARCOUNT	EQU	116
SYSCHARSHANDLER	EQU	117
SYSCHARSHANDLER_H	EQU	118
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSINTEGERTEMPA	EQU	5
SYSINTEGERTEMPA_H	EQU	6
SYSINTEGERTEMPB	EQU	9
SYSINTEGERTEMPB_H	EQU	10
SYSINTEGERTEMPX	EQU	0
SYSINTEGERTEMPX_H	EQU	1
SYSLCDPRINTDATAHANDLER	EQU	119
SYSLCDPRINTDATAHANDLER_H	EQU	120
SYSLONGDIVMULTA	EQU	121
SYSLONGDIVMULTA_E	EQU	124
SYSLONGDIVMULTA_H	EQU	122
SYSLONGDIVMULTA_U	EQU	123
SYSLONGDIVMULTB	EQU	125
SYSLONGDIVMULTB_E	EQU	128
SYSLONGDIVMULTB_H	EQU	126
SYSLONGDIVMULTB_U	EQU	127
SYSLONGDIVMULTX	EQU	129
SYSLONGDIVMULTX_E	EQU	132
SYSLONGDIVMULTX_H	EQU	130
SYSLONGDIVMULTX_U	EQU	131
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
SYSPRINTBUFFER	EQU	3532
SYSPRINTBUFFLEN	EQU	133
SYSPRINTDATAHANDLER	EQU	134
SYSPRINTDATAHANDLER_H	EQU	135
SYSPRINTTEMP	EQU	136
SYSREPEATTEMP1	EQU	137
SYSSIGNBYTE	EQU	13
SYSSTRDATA	EQU	138
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	3543
SYSSTRINGTEMP	EQU	139
SYSSTRLEN	EQU	140
SYSSYSINSTRING3HANDLER	EQU	141
SYSSYSINSTRING3HANDLER_H	EQU	142
SYSSYSINSTRINGHANDLER	EQU	143
SYSSYSINSTRINGHANDLER_H	EQU	144
SYSTEMP1	EQU	145
SYSTEMP1_E	EQU	148
SYSTEMP1_H	EQU	146
SYSTEMP1_U	EQU	147
SYSTEMP2	EQU	149
SYSTEMP2_H	EQU	150
SYSTEMP3	EQU	151
SYSTEMP3_H	EQU	152
SYSVALTEMP	EQU	153
SYSVALTEMP_H	EQU	154
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWAITTEMPUS	EQU	5
SYSWAITTEMPUS_H	EQU	6
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
WORDNUMBER	EQU	155
WORDNUMBER_H	EQU	156
XCHAR	EQU	157
XOFFSET	EQU	158
XOFFSET_H	EQU	159
XRADIUS	EQU	160
XRADIUS_H	EQU	161
YCALC1	EQU	162
YCALC1_H	EQU	163
YCALC2	EQU	164
YCALC2_H	EQU	165
YOFFSET	EQU	166
YOFFSET_H	EQU	167
YORDINATE	EQU	168

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
SYSHEX_0	EQU	3522
SYSHEX_1	EQU	3523
SYSHEX_2	EQU	3524
SYSPAD_0	EQU	3564
SYSSTR_0	EQU	3526

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
	call	INITSYS
	call	INITUSART
	call	INITGLCD_NT7108C

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a GLCD demonstration multifunctional capabilities for the NT7108C GLCD controllers.
;''
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''@author  EvanV
;''@licence GPL
;''@version 1.1
;''@date    24.11.18
;''********************************************************************************
;#define GLCD_TYPE GLCD_TYPE_NT7108C               ' Specify the GLCD type
;#define GLCDDirection 0                           ' Flip the GLCD   0 do not flip, 1 flip
;#define LED_GLCD_HEIGHT GLCD_HEIGHT
;Setup the device
;#define GLCD_CS1 PORTC.1    'D12 to actually since CS1, CS2 can be reversed on some devices
;#define GLCD_CS2 PORTC.0
;#define GLCD_DATA_PORT PORTD
;#define GLCD_RS PORTe.0
;#define GLCD_Enable PORTe.2
;#define GLCD_RW PORTc.3
;#define GLCD_RESET PORTC.2
;USART settings
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;HSerPrintStringCRLF "Test"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTSTRINGCRLF
;#define NT7108CReadDelay   7   ; 5 normal usage, 5 for 32 mhz!
;#define NT7108CWriteDelay  7     ; 1 normal usage, 0 works
;#define NT7108CClockDelay  7     ; 1 normal usage, 0 works
;#define GLCDDirection      0     ; 0 normal mode
;Optionally change the font, by uncommenting the next two lines
;#define GLCD_OLED_FONT
;GLCDfntDefaultsize= 1    'this demo with the GLCD_TYPE_NT7108C only supports GLCDfntDefaultsize= 1, as the text is all in the incorrect position
;change to LED height, this, avoids set the 4 LED signals if your device uses the bottom row to control LEDs
;#define LED_GLCD_HEIGHT GLCD_HEIGHT
;Dim BYTENUMBER, CCOUNT as Byte
;CCount = 0
	clrf	CCOUNT,BANKED
;dim longNumber as long
;longNumber = 4294967290 ' max value = 4294967296
	movlw	250
	movwf	LONGNUMBER,BANKED
	setf	LONGNUMBER_H,BANKED
	setf	LONGNUMBER_U,BANKED
	setf	LONGNUMBER_E,BANKED
;dim wordNumber as Word
;dim outString as string
;wordNumber = 0
	clrf	WORDNUMBER,BANKED
	clrf	WORDNUMBER_H,BANKED
;byteNumber = 0
	clrf	BYTENUMBER,BANKED
;GLCDPrint ( 0,   0, "Great Cow BASIC 2018")                          ; Print some text
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( 0,   16, "@Evan R. Venn")                                ; Print some text
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	16
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;wait 3 s
	movlw	3
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;GLCDCLS
	call	GLCDCLS_NT7108C
;Prepare the static components of the screen
;GLCDPrint ( 2,   1, "PrintStr")                                ; Print some text
	movlw	2
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( 64,  1, "LAT@")                                    ; Print some more text
	movlw	64
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( 88,  1, ChipMhz)                                   ; Print chip speed
	movlw	88
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	64
	movwf	LCDVALUE,BANKED
	clrf	LCDVALUE_H,BANKED
	clrf	LCDVALUE_U,BANKED
	clrf	LCDVALUE_E,BANKED
	call	GLCDPRINT5
;GLCDPrint ( 100, 1, "Mhz")                                     ; Print some text
	movlw	100
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	1
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDDrawString( 2,10,"DrawStr")                                 ; Draw some text
	movlw	2
	movwf	STRINGLOCX,BANKED
	movlw	10
	movwf	CHARLOCY,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	GLCDDRAWSTRING
;box 0,0,GLCD_WIDTH-1, LED_GLCD_HEIGHT-1                        ; Draw a box
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	clrf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	127
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	63
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX
;box GLCD_WIDTH-5, LED_GLCD_HEIGHT-5,GLCD_WIDTH-1, LED_GLCD_HEIGHT-1    ; Draw a box
	movlw	123
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	59
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	127
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	63
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX
;Circle( 44,41,15)                                              ; Draw a circle
	movlw	44
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	41
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	15
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	movff	GLCD_YORDINATE,YORDINATE
	rcall	CIRCLE
;line LED_GLCD_HEIGHT,31,0,31                                   ; Draw a line
	movlw	64
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	31
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	clrf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	31
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	LINE
;DO forever
SysDoLoop_S1
;for CCount = 32 to 127
	movlw	31
	movwf	CCOUNT,BANKED
SysForLoop1
	incf	CCOUNT,F,BANKED
;GLCDPrint ( LED_GLCD_HEIGHT ,  36,  hex(longNumber_E ) )    ; Print a HEX string
	movlw	64
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	36
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	LONGNUMBER_E,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( 76 ,  36,  hex(longNumber_U ) )                 ; Print a HEX string
	movlw	76
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	36
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	LONGNUMBER_U,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( 88 ,  36,  hex(longNumber_H ) )                 ; Print a HEX string
	movlw	88
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	36
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	LONGNUMBER_H,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( 100 ,  36, hex(longNumber   ) )                 ; Print a HEX string
	movlw	100
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	36
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	LONGNUMBER,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( 112 ,  36, "h" )                                ; Print a HEX string
	movlw	112
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	36
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( LED_GLCD_HEIGHT ,  44, pad(str(wordNumber), 5 ) )           ; Print a padded string
	movlw	64
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	44
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	WORDNUMBER,SYSVALTEMP
	movff	WORDNUMBER_H,SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	5
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler_H,BANKED
	call	FN_PAD
	movlw	low PAD
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;GLCDPrint ( LED_GLCD_HEIGHT ,  52, pad(str(byteNumber), 3 ) )           ; Print a padded string
	movlw	64
	movwf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	52
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movff	BYTENUMBER,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler_H,BANKED
	call	FN_PAD
	movlw	low PAD
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	call	GLCDPRINT3
;box (46,9,56,19)                                            ; Draw a Box
	movlw	46
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	9
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	56
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	19
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	BOX
;GLCDDrawChar(48, 10, CCount )                               ; Draw a character
	movlw	48
	movwf	CHARLOCX,BANKED
	clrf	CHARLOCX_H,BANKED
	movlw	10
	movwf	CHARLOCY,BANKED
	clrf	CHARLOCY_H,BANKED
	movff	CCOUNT,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	GLCDDRAWCHAR
;outString = str( CCount )                                   ; Prepare a string
	movff	CCOUNT,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,OUTSTRING
	lfsr	0,STR
	call	SysCopyString
;GLCDDrawString(LED_GLCD_HEIGHT, 10, pad(outString,3) )       ; Draw a string
	movlw	64
	movwf	STRINGLOCX,BANKED
	movlw	10
	movwf	CHARLOCY,BANKED
	movlw	low OUTSTRING
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high OUTSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	3
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRING3Handler_H,BANKED
	call	FN_PAD
	movlw	low PAD
	movwf	SysCHARSHandler,BANKED
	movlw	high PAD
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	GLCDDRAWSTRING
;filledbox 3,43,11,51, wordNumber                            ; Draw a filled box
	movlw	3
	movwf	LINEX1,BANKED
	movlw	43
	movwf	LINEY1,BANKED
	movlw	11
	movwf	LINEX2,BANKED
	movlw	51
	movwf	LINEY2,BANKED
	movff	WORDNUMBER,LINECOLOUR
	movff	WORDNUMBER_H,LINECOLOUR_H
	rcall	FILLEDBOX_NT7108C
;FilledCircle( 44,41,9, longNumber xor 1)                    ; Draw a filled box
	movlw	44
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	41
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	9
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movlw	1
	xorwf	LONGNUMBER,W,BANKED
	movwf	LINECOLOUR,BANKED
	movff	LONGNUMBER_H,LINECOLOUR_H
	rcall	FILLEDCIRCLE
;line 0,63,LED_GLCD_HEIGHT,31                                ; Draw a line
	clrf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	63
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	64
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	31
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	LINE
;Do some simple maths
;longNumber = longNumber + 7 : wordNumber = wordNumber + 3 : byteNumber++
	movlw	7
	addwf	LONGNUMBER,F,BANKED
	movlw	0
	addwfc	LONGNUMBER_H,F,BANKED
	movlw	0
	addwfc	LONGNUMBER_U,F,BANKED
	movlw	0
	addwfc	LONGNUMBER_E,F,BANKED
	movlw	3
	addwf	WORDNUMBER,F,BANKED
	movlw	0
	addwfc	WORDNUMBER_H,F,BANKED
	incf	BYTENUMBER,F,BANKED
;NEXT
	movlw	127
	subwf	CCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
ENDIF1
SysForLoopEnd1
;LOOP
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
TABLEFOROLEDFONT2
INDEXFOROLEDEXTENDEDFONT1
DATAFOROLEDFONT1
TABLEFOROLEDEXTENDEDFONT2
;#define KS0108ReadDelay   9     ; 2 normal usage, 3 for 32 mhz!
;#define KS0108WriteDelay  1     ; 1 normal usage, 0 works
;#define KS0108ClockDelay  1     ; 1 normal usage, 0 works
;#define GLCDDirection     0     ; 0 normal mode
;#define NT7108CReadDelay    7      ; = 7 normal usage, 5 or above is OK at 32 mhz!
;#define NT7108CWriteDelay   7      ; = 7 normal usage you may get away with other lower values
;#define NT7108CClockDelay   7      ; = 7 normal usage you may get away with other lower values
;#define GLCDDirection     0     ; 0 normal mode
;#define InitGLCD_ILI9341 nop
;#define ST7920ReadDelay = 20
;#define ST7920WriteDelay = 2
;#define ILI9326_DataPort GLCD_DataPort
;#define ILI9326_GLCD_RST GLCD_RST
;#define ILI9326_GLCD_CS  GLCD_CS
;#define ILI9326_GLCD_RS  GLCD_RS
;#define ILI9326_GLCD_WR  GLCD_WR
;#define ILI9326_GLCD_RD  GLCD_RD
;#define tinyDelay nop:nop
;#define ILI9481_GLCD_RST GLCD_RST
;#define ILI9481_GLCD_CS GLCD_CS
;#define ILI9481_GLCD_RS GLCD_RS
;#define ILI9481_GLCD_WR GLCD_WR
;#define ILI9481_GLCD_RD GLCD_RD
;#define ILI9481_GLCD_DB0 GLCD_DB0
;#define ILI9481_GLCD_DB1 GLCD_DB1
;#define ILI9481_GLCD_DB2 GLCD_DB2
;#define ILI9481_GLCD_DB3 GLCD_DB3
;#define ILI9481_GLCD_DB4 GLCD_DB4
;#define ILI9481_GLCD_DB5 GLCD_DB5
;#define ILI9481_GLCD_DB6 GLCD_DB6
;#define ILI9481_GLCD_DB7 GLCD_DB7
;#define ILI9481_GLCD_RST GLCD_RST
;#define ILI9481_GLCD_CS GLCD_CS
;#define ILI9481_GLCD_RS GLCD_RS
;#define ILI9481_GLCD_WR GLCD_WR
;#define HX8347_GLCD_RST GLCD_RST
;#define HX8347_GLCD_CS GLCD_CS
;#define HX8347_GLCD_RS GLCD_RS
;#define HX8347_GLCD_WR GLCD_WR
;#define HX8347_GLCD_RD GLCD_RD
;#define HX8347_GLCD_DB0 GLCD_DB0
;#define HX8347_GLCD_DB1 GLCD_DB1
;#define HX8347_GLCD_DB2 GLCD_DB2
;#define HX8347_GLCD_DB3 GLCD_DB3
;#define HX8347_GLCD_DB4 GLCD_DB4
;#define HX8347_GLCD_DB5 GLCD_DB5
;#define HX8347_GLCD_DB6 GLCD_DB6
;#define HX8347_GLCD_DB7 GLCD_DB7
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

BOX
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF18
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
	movff	LINEX1_H,GLCDTEMP_H
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	movff	GLCDTEMP_H,LINEX2_H
;End If
ENDIF18
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF19
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
	movff	LINEY1_H,GLCDTEMP_H
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	movff	GLCDTEMP_H,LINEY2_H
;End If
ENDIF19
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	subwf	LINEX1,W,BANKED
	movwf	DRAWLINE,BANKED
	movlw	0
	subwfb	LINEX1_H,W,BANKED
	movwf	DRAWLINE_H,BANKED
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd9
ENDIF20
SysForLoop9
	incf	DRAWLINE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,BANKED
;PSet DrawLine, LineY1, LineColour
	movff	DRAWLINE,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;PSet DrawLine, LineY2, LineColour
	movff	DRAWLINE,GLCDX
	movff	LINEY2,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop9
ENDIF21
SysForLoopEnd9
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	movlw	1
	subwf	LINEY1,W,BANKED
	movwf	DRAWLINE,BANKED
	movlw	0
	subwfb	LINEY1_H,W,BANKED
	movwf	DRAWLINE_H,BANKED
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd10
ENDIF22
SysForLoop10
	incf	DRAWLINE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,BANKED
;PSet LineX1, DrawLine, LineColour
	movff	LINEX1,GLCDX
	movff	DRAWLINE,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;PSet LineX2, DrawLine, LineColour
	movff	LINEX2,GLCDX
	movff	DRAWLINE,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop10
ENDIF23
SysForLoopEnd10
	return

;********************************************************************************

CIRCLE
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	movff	INXRADIUS,XRADIUS
	movff	INXRADIUS_H,XRADIUS_H
;radiusErr = -(xradius/2)
	movff	XRADIUS,SysINTEGERTempA
	movff	XRADIUS_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysDivSubINT
	movff	SysINTEGERTempA,SysTemp1
	movff	SysINTEGERTempA_H,SysTemp1_H
	comf	SysTemp1,W,BANKED
	movwf	RADIUSERR,BANKED
	comf	SysTemp1_H,W,BANKED
	movwf	RADIUSERR_H,BANKED
	incf	RADIUSERR,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	RADIUSERR_H,F,BANKED
;Do While xradius >=  yordinate
SysDoLoop_S3
	movff	xradius,SysINTEGERTempA
	movff	xradius_H,SysINTEGERTempA_H
	movff	yordinate,SysINTEGERTempB
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	YORDINATE,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	movf	YORDINATE,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	movf	XRADIUS,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	YORDINATE,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	movf	YORDINATE,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	GLCDX,BANKED
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;yordinate ++
	incf	YORDINATE,F,BANKED
;If radiusErr < 0 Then
	movff	RADIUSERR,SysINTEGERTempA
	movff	RADIUSERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE24_1
;radiusErr = radiusErr + 2 * yordinate + 1
	movf	YORDINATE,W,BANKED
	mullw	2
	movf	PRODL,W,ACCESS
	addwf	RADIUSERR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	RADIUSERR_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	RADIUSERR,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	RADIUSERR_H,BANKED
;else
	bra	ENDIF24
ELSE24_1
;xradius --
	movlw	1
	subwf	XRADIUS,F,BANKED
	movlw	0
	subwfb	XRADIUS_H,F,BANKED
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	movf	XRADIUS,W,BANKED
	subwf	YORDINATE,W,BANKED
	movwf	SysTemp1,BANKED
	clrf	SysTemp2,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	SysTemp2,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movff	SysTemp3,SysINTEGERTempA
	movff	SysTemp3_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movf	SysINTEGERTempX,W,ACCESS
	addwf	RADIUSERR,F,BANKED
	movf	SysINTEGERTempX_H,W,ACCESS
	addwfc	RADIUSERR_H,F,BANKED
;end if
ENDIF24
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	129
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	40
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

FILLEDBOX_NT7108C
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF34
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
;LineX1 = LineX2
	movff	LINEX2,LINEX1
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
;End If
ENDIF34
;If LineY1 > LineY2 Then
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF35
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
;LineY1 = LineY2
	movff	LINEY2,LINEY1
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
;End If
ENDIF35
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	decf	LINEX1,W,BANKED
	movwf	DRAWLINE,BANKED
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd14
ENDIF36
SysForLoop14
	incf	DRAWLINE,F,BANKED
;For GLCDTemp = LineY1 To LineY2
	decf	LINEY1,W,BANKED
	movwf	GLCDTEMP,BANKED
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd15
ENDIF37
SysForLoop15
	incf	GLCDTEMP,F,BANKED
;PSet DrawLine, GLCDTemp, LineColour
	movff	DRAWLINE,GLCDX
	movff	GLCDTEMP,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_NT7108C
;Next
	movf	LINEY2,W,BANKED
	subwf	GLCDTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop15
ENDIF38
SysForLoopEnd15
;Next
	movf	LINEX2,W,BANKED
	subwf	DRAWLINE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop14
ENDIF39
SysForLoopEnd14
	return

;********************************************************************************

FILLEDCIRCLE
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	movf	XRADIUS,W,BANKED
	sublw	1
	movwf	FF,BANKED
	clrf	SysTemp1,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	FF_H,BANKED
;ddF_x = 1
	movlw	1
	movwf	DDF_X,BANKED
	clrf	DDF_X_H,BANKED
;ddF_y = -2 * xradius
	movff	XRADIUS,SysINTEGERTempA
	movff	XRADIUS_H,SysINTEGERTempA_H
	movlw	254
	movwf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movff	SysINTEGERTempX,DDF_Y
	movff	SysINTEGERTempX_H,DDF_Y_H
;FillCircleXX = 0
	clrf	FILLCIRCLEXX,BANKED
;FillCircleYY = xradius
	movff	XRADIUS,FILLCIRCLEYY
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	YCALC2,BANKED
	movf	XRADIUS_H,W,BANKED
	addwfc	YOFFSET_H,W,BANKED
	movwf	YCALC2_H,BANKED
;YCalc1 = yoffset-xradius
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	YCALC1,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	YOFFSET_H,W,BANKED
	movwf	YCALC1_H,BANKED
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	movff	XOFFSET,LINEX1
	movff	XOFFSET_H,LINEX1_H
	movff	YCALC1,LINEY1
	movff	YCALC1_H,LINEY1_H
	movff	XOFFSET,LINEX2
	movff	XOFFSET_H,LINEX2_H
	movff	YCALC2,LINEY2
	movff	YCALC2_H,LINEY2_H
	call	LINE
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S4
	movf	FILLCIRCLEYY,W,BANKED
	subwf	FILLCIRCLEXX,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	SysDoLoop_E4
;if ff >= 0 then
	movff	FF,SysINTEGERTempA
	movff	FF_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF25
;FillCircleYY--
	decf	FILLCIRCLEYY,F,BANKED
;ddF_y += 2
	movlw	2
	addwf	DDF_Y,F,BANKED
	movlw	0
	addwfc	DDF_Y_H,F,BANKED
;ff += ddF_y
	movf	DDF_Y,W,BANKED
	addwf	FF,F,BANKED
	movf	DDF_Y_H,W,BANKED
	addwfc	FF_H,F,BANKED
;end if
ENDIF25
;FillCircleXX++
	incf	FILLCIRCLEXX,F,BANKED
;ddF_x += 2
	movlw	2
	addwf	DDF_X,F,BANKED
	movlw	0
	addwfc	DDF_X_H,F,BANKED
;ff += ddF_x
	movf	DDF_X,W,BANKED
	addwf	FF,F,BANKED
	movf	DDF_X_H,W,BANKED
	addwfc	FF_H,F,BANKED
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEYY,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEXX,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEYY,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	call	LINE
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEYY,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEXX,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEYY,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	call	LINE
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,BANKED
	addwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEXX,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	XOFFSET,W,BANKED
	addwf	FILLCIRCLEYY,W,BANKED
	movwf	LINEX2,BANKED
	clrf	SysTemp1,BANKED
	movf	XOFFSET_H,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEXX,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	call	LINE
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEXX,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	YOFFSET_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEYY,W,BANKED
	subwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEXX,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	YOFFSET_H,W,BANKED
	movwf	LINEY2_H,BANKED
	rcall	LINE
;loop
	bra	SysDoLoop_S4
SysDoLoop_E4
	return

;********************************************************************************

GLCDCHARCOL3
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL3
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL3
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL3
	db	112,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	db	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	db	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	db	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	db	144,16,120,56,120,136,24,136,0,0,0,32,120

;********************************************************************************

GLCDCHARCOL4
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL4
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL4
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL4
	db	112,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	db	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	db	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	db	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	db	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68

;********************************************************************************

GLCDCHARCOL5
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL5
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL5
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL5
	db	112,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	db	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	db	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	db	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	db	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	db	66

;********************************************************************************

GLCDCHARCOL6
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL6
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL6
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL6
	db	112,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	db	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	db	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	db	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	db	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68

;********************************************************************************

GLCDCHARCOL7
	movlw	113
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL7
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL7
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL7
	db	112,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	db	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	db	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	db	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	db	120,136,120,136,0,0,0,16,120

;********************************************************************************

GLCDCLS_NT7108C
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;fix for  not clearing screen
;Set GLCD_CS1 On
	bsf	LATC,1,ACCESS
;Set GLCD_CS2 Off
	bcf	LATC,0,ACCESS
;for GLCD_Count = 1 to 2
	clrf	GLCD_COUNT,BANKED
SysForLoop11
	incf	GLCD_COUNT,F,BANKED
;For CurrPage = 0 to 7
	setf	CURRPAGE,BANKED
SysForLoop12
	incf	CURRPAGE,F,BANKED
;Set page
;Set GLCD_RS Off
	bcf	LATE,0,ACCESS
;GLCDWriteByte b'10111000' Or CurrPage
	movlw	184
	iorwf	CURRPAGE,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Clear columns
;For CurrCol = 0 to 63
	setf	CURRCOL,BANKED
SysForLoop13
	incf	CURRCOL,F,BANKED
;Select column
;Set GLCD_RS Off
	bcf	LATE,0,ACCESS
;GLCDWriteByte 64 Or CurrCol
	movlw	64
	iorwf	CURRCOL,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Clear
;Set GLCD_RS On
	bsf	LATE,0,ACCESS
;GLCDWriteByte 0
	clrf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Next
	movlw	63
	subwf	CURRCOL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop13
ENDIF31
SysForLoopEnd13
;Next
	movlw	7
	subwf	CURRPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
ENDIF32
SysForLoopEnd12
;Set GLCD_CS1 Off
	bcf	LATC,1,ACCESS
;Set GLCD_CS2 On
	bsf	LATC,0,ACCESS
;next
	movlw	2
	subwf	GLCD_COUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop11
ENDIF33
SysForLoopEnd11
;Set GLCD_CS1 OFF
	bcf	LATC,1,ACCESS
;Set GLCD_CS2 Off
	bcf	LATC,0,ACCESS
	return

;********************************************************************************

GLCDDRAWCHAR
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;invert colors if required
;if LineColour <> GLCDForeground  then
	movff	LINECOLOUR,SysWORDTempA
	movff	LINECOLOUR_H,SysWORDTempA_H
	movff	GLCDFOREGROUND,SysWORDTempB
	movff	GLCDFOREGROUND_H,SysWORDTempB_H
	call	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF9
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND,BANKED
	clrf	GLCDBACKGROUND_H,BANKED
;GLCDForeground = 0
	clrf	GLCDFOREGROUND,BANKED
	clrf	GLCDFOREGROUND_H,BANKED
;end if
ENDIF9
;dim CharCol, CharRow as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F,BANKED
;CharCol=0
	clrf	CHARCOL,BANKED
	clrf	CHARCOL_H,BANKED
;if CharCode>=178 and CharCode<=202 then
	movff	CHARCODE,SysBYTETempA
	movlw	178
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	CHARCODE,SysBYTETempB
	movlw	202
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF10
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,BANKED
	movlw	0
	subwfb	CHARLOCY_H,F,BANKED
;end if
ENDIF10
;For CurrCharCol = 1 to 5
	clrf	CURRCHARCOL,BANKED
SysForLoop5
	incf	CURRCHARCOL,F,BANKED
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect1Case1
	decf	CURRCHARCOL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL3
	movwf	CURRCHARVAL,BANKED
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	CURRCHARCOL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL4
	movwf	CURRCHARVAL,BANKED
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	CURRCHARCOL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL5
	movwf	CURRCHARVAL,BANKED
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	CURRCHARCOL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL6
	movwf	CURRCHARVAL,BANKED
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	CURRCHARCOL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd1
	movff	CHARCODE,SYSSTRINGA
	rcall	GLCDCHARCOL7
	movwf	CURRCHARVAL,BANKED
;End Select
SysSelectEnd1
;CharRow=0
	clrf	CHARROW,BANKED
	clrf	CHARROW_H,BANKED
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW,BANKED
SysForLoop6
	incf	CURRCHARROW,F,BANKED
;CharColS=0
	clrf	CHARCOLS,BANKED
;For Col=1 to GLCDfntDefaultsize
	clrf	COL,BANKED
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd7
ENDIF11
SysForLoop7
	incf	COL,F,BANKED
;CharRowS=0
	clrf	CHARROWS,BANKED
;For Row=1 to GLCDfntDefaultsize
	clrf	ROW,BANKED
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd8
ENDIF12
SysForLoop8
	incf	ROW,F,BANKED
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,BANKED
	bra	ELSE13_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
	movf	CHARCOL,W,BANKED
	addwf	CHARLOCX,W,BANKED
	movwf	SysTemp1,BANKED
	movf	CHARCOLS,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	GLCDX,BANKED
	movf	CHARROW,W,BANKED
	addwf	CHARLOCY,W,BANKED
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_NT7108C
;Else
	bra	ENDIF13
ELSE13_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
	movf	CHARCOL,W,BANKED
	addwf	CHARLOCX,W,BANKED
	movwf	SysTemp1,BANKED
	movf	CHARCOLS,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	GLCDX,BANKED
	movf	CHARROW,W,BANKED
	addwf	CHARLOCY,W,BANKED
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,BANKED
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_NT7108C
;End if
ENDIF13
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	CHARLOCX,W,BANKED
	movwf	GLCDX,BANKED
	movf	CHARROW,W,BANKED
	addwf	CHARLOCY,W,BANKED
	movwf	SysTemp1,BANKED
	movf	CHARROWS,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	GLCDY,BANKED
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	rcall	PSET_NT7108C
;CharRowS +=1
	incf	CHARROWS,F,BANKED
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	subwf	ROW,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
ENDIF14
SysForLoopEnd8
;CharColS +=1
	incf	CHARCOLS,F,BANKED
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	subwf	COL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
ENDIF15
SysForLoopEnd7
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,BANKED
;CharRow +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	addwf	CHARROW,F,BANKED
	movlw	0
	addwfc	CHARROW_H,F,BANKED
;Next
	movlw	8
	subwf	CURRCHARROW,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
ENDIF16
SysForLoopEnd6
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	addwf	CHARCOL,F,BANKED
	movlw	0
	addwfc	CHARCOL_H,F,BANKED
;Next
	movlw	5
	subwf	CURRCHARCOL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
ENDIF17
SysForLoopEnd5
;Restore
;GLCDBackground = 0
	clrf	GLCDBACKGROUND,BANKED
	clrf	GLCDBACKGROUND_H,BANKED
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND,BANKED
	clrf	GLCDFOREGROUND_H,BANKED
	return

;********************************************************************************

GLCDDRAWSTRING
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	movff	STRINGLOCX,GLCDPRINTLOC
	clrf	GLCDPRINTLOC_H,BANKED
;for xchar = 1 to Chars(0)
	clrf	XCHAR,BANKED
	movff	SysCHARSHandler,AFSR0
	movff	SysCHARSHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
ENDIF7
SysForLoop4
	incf	XCHAR,F,BANKED
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movf	XCHAR,W,BANKED
	addwf	SysCHARSHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysCHARSHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,CHARCODE
	rcall	GLCDDRAWCHAR
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	GLCDPRINTLOC,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	GLCDPRINTLOC,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDPRINTLOC_H,BANKED
;next
	movff	SysCHARSHandler,AFSR0
	movff	SysCHARSHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	XCHAR,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
ENDIF8
SysForLoopEnd4
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:
GLCDPRINT3
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	movff	SysLCDPRINTDATAHandler,AFSR0
	movff	SysLCDPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	return
ENDIF2
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER,BANKED
	movlw	1
	subwf	GLCDPRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
ENDIF3
SysForLoop2
	incf	GLCDPRINT_STRING_COUNTER,F,BANKED
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W,BANKED
	addwf	SysLCDPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	GLCDDRAWCHAR
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	GLCDPRINTLOC,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	GLCDPRINTLOC,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDPRINTLOC_H,BANKED
;Next
	movf	GLCDPRINTLEN,W,BANKED
	subwf	GLCDPRINT_STRING_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
ENDIF4
SysForLoopEnd2
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:
GLCDPRINT5
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN,BANKED
;Do
SysDoLoop_S2
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F,BANKED
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTBUFFLEN,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	LCDVALUE,SysLONGTempA
	movff	LCDVALUE_H,SysLONGTempA_H
	movff	LCDVALUE_U,SysLONGTempA_U
	movff	LCDVALUE_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempX,INDF0
;LCDValue = SysCalcTempA
	movff	SYSCALCTEMPA,LCDVALUE
	movff	SYSCALCTEMPA_H,LCDVALUE_H
	movff	SYSCALCTEMPA_U,LCDVALUE_U
	movff	SYSCALCTEMPA_E,LCDVALUE_E
;Loop While LCDValue <> 0
	movff	lcdvalue,SysLONGTempA
	movff	lcdvalue_H,SysLONGTempA_H
	movff	lcdvalue_U,SysLONGTempA_U
	movff	lcdvalue_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysDoLoop_S2
SysDoLoop_E2
;Display
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
	incf	SYSPRINTBUFFLEN,W,BANKED
	movwf	GLCDPRINT_STRING_COUNTER,BANKED
	movlw	1
	subwf	SYSPRINTBUFFLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
ENDIF5
SysForLoop3
	decf	GLCDPRINT_STRING_COUNTER,F,BANKED
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	lfsr	0,SYSPRINTBUFFER
	movf	GLCDPRINT_STRING_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	INDF0,W,ACCESS
	movwf	CHARCODE,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	rcall	GLCDDRAWCHAR
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	addwf	GLCDPRINTLOC,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	GLCDPRINTLOC_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	GLCDPRINTLOC,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	GLCDPRINTLOC_H,BANKED
;Next
	movf	GLCDPRINT_STRING_COUNTER,W,BANKED
	sublw	1
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
ENDIF6
SysForLoopEnd3
	return

;********************************************************************************

FN_GLCDREADBYTE_NT7108C
;Set data port direction
;dir GLCD_DATA_PORT in
	setf	TRISD,ACCESS
;Set LCD data direction
;Set GLCD_RW On
	bsf	LATC,3,ACCESS
;Read
;Set GLCD_ENABLE On
	bsf	LATE,2,ACCESS
;Wait NT7108CClockDelay  US
	movlw	37
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
;Get input data
;Set GLCD_ENABLE Off
	bcf	LATE,2,ACCESS
;Wait NT7108CReadDelay  US
	movlw	37
	movwf	DELAYTEMP,ACCESS
DelayUS4
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS4
;GLCDReadByte = GLCD_DATA_PORT
	movff	PORTD,GLCDREADBYTE_NT7108C
	return

;********************************************************************************

GLCDWRITEBYTE_NT7108C
;Set LCD data direction
;Set GLCD_RW Off
	bcf	LATC,3,ACCESS
;Set data port direction
;dir GLCD_DATA_PORT out
	clrf	TRISD,ACCESS
;Set output data
;GLCD_DATA_PORT = LCDByte
	movff	LCDBYTE,PORTD
;Latch data
;Wait NT7108CWriteDelay us
	movlw	37
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
;Set GLCD_ENABLE On
	bsf	LATE,2,ACCESS
;Wait NT7108CClockDelay us
	movlw	37
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
;Set GLCD_ENABLE Off
	bcf	LATE,2,ACCESS
;Wait NT7108CWriteDelay us
	return

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
	bra	ENDIF59
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF59
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop16
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop16
ENDIF60
SysForLoopEnd16
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF61
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF61
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

HSERPRINTSTRINGCRLF
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF69
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd20
ENDIF70
SysForLoop20
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
	bra	SysForLoop20
ENDIF71
SysForLoopEnd20
;End If
ENDIF69
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	bra	HSERSEND

;********************************************************************************

HSERSEND
;Block before sending (if needed)
;Send byte
;Registers/Bits determined by #samevar at top of file
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF74
;HSerSendBlocker
;Wait While TXIF = Off
SysWaitLoop1
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop1
;asm showdebug TXREG equals SerData below will assign SerData to TXREG or TXREG1 or U1TXB  via the #samevar
;txreg equals serdata below will assign serdata to txreg | txreg1 | txreg via the #samevar
;
;TXREG = SerData
	movff	SERDATA,TXREG
;Add USART_DELAY After all bits are shifted out
;Wait until TRMT = 1
SysWaitLoop2
	btfss	TXSTA1,TRMT,ACCESS
	bra	SysWaitLoop2
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;exit sub
	return
;end if
ENDIF74
	return

;********************************************************************************

INITGLCD_NT7108C
;Setup code for NT7108C controllers
;Timing for 32 mhz device - typically you can use the defaults and not state these constants
;Set pin directions
;Dir GLCD_RS Out
	bcf	TRISE,0,ACCESS
;Dir GLCD_RW Out
	bcf	TRISC,3,ACCESS
;Dir GLCD_ENABLE Out
	bcf	TRISE,2,ACCESS
;Dir GLCD_CS1 Out
	bcf	TRISC,1,ACCESS
;Dir GLCD_CS2 Out
	bcf	TRISC,0,ACCESS
;Dir GLCD_RESET Out
	bcf	TRISC,2,ACCESS
;Reset
;Set GLCD_RESET Off
	bcf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Set GLCD_RESET On
	bsf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Select both chips
;Set GLCD_CS1 Off
	bcf	LATC,1,ACCESS
;Set GLCD_CS2 Off
	bcf	LATC,0,ACCESS
;Reset
;Set GLCD_RESET Off
	bcf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Set GLCD_RESET On
	bsf	LATC,2,ACCESS
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Set on
;Set GLCD_RS Off
	bcf	LATE,0,ACCESS
;GLCDWriteByte 63
	movlw	63
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Set Z to 0
;GLCDWriteByte 192
	movlw	192
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Deselect chips
;Set GLCD_CS1 Off
	bcf	LATC,1,ACCESS
;Set GLCD_CS2 Off
	bcf	LATC,0,ACCESS
;Colours
;GLCDBackground = 0
	clrf	GLCDBACKGROUND,BANKED
	clrf	GLCDBACKGROUND_H,BANKED
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND,BANKED
	clrf	GLCDFOREGROUND_H,BANKED
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH,BANKED
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,BANKED
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,BANKED
;Clear screen
;GLCDCLS_NT7108C
	bra	GLCDCLS_NT7108C

;********************************************************************************

INITSYS
;asm ShowDebug ChipIntOSCCONFormat is ChipIntOSCCONFormat
;1 is 1
;The section now handles two true table for frequency
;Supports 18f2425 (type1 max frq of 8mhz) classes and 18f26k22 (type2 max frq of 16mhz) classes
;Assumes that testing the ChipMaxMHz >= 48 is a valid test for type2 microcontrollers
;Supports IntOsc MaxMhz of 64 and not 64 ... there may be others true tables that GCB needs to support
;asm showdebug OSCCON type is 104' NoBit(SPLLEN) And NoBit(IRCF3) Or Bit(INTSRC)) and ifdef Bit(HFIOFS)
;osccon type is 104
;[canskip] IRCF2, IRCF1, IRCF0, SPLLEN = b'1111'
	bsf	OSCCON,IRCF2,ACCESS
	bsf	OSCCON,IRCF1,ACCESS
	bsf	OSCCON,IRCF0,ACCESS
	bsf	OSCTUNE,PLLEN,ACCESS
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
;End clearing any ANSEL variants in the part
;For 18f devices
;Set ANSEL0 off
	banksel	ANCON0
	bcf	ANCON0,ANSEL0,BANKED
;Set ANSEL1 off
	bcf	ANCON0,ANSEL1,BANKED
;Set ANSEL2 off
	bcf	ANCON0,ANSEL2,BANKED
;Set ANSEL3 off
	bcf	ANCON0,ANSEL3,BANKED
;Set ANSEL4 off
	bcf	ANCON0,ANSEL4,BANKED
;Set ANSEL5 off
	bcf	ANCON0,ANSEL5,BANKED
;Set ANSEL6 off
	bcf	ANCON0,ANSEL6,BANKED
;Set ANSEL7 off
	bcf	ANCON0,ANSEL7,BANKED
;Set ANSEL8 off
	bcf	ANCON1,ANSEL8,BANKED
;Set ANSEL9 off
	bcf	ANCON1,ANSEL9,BANKED
;Set ANSEL10 off
	bcf	ANCON1,ANSEL10,BANKED
;Set ANSEL11 off
	bcf	ANCON1,ANSEL11,BANKED
;Set ANSEL12 off
	bcf	ANCON1,ANSEL12,BANKED
;Set ANSEL13 off
	bcf	ANCON1,ANSEL13,BANKED
;Set ANSEL14 off
	bcf	ANCON1,ANSEL14,BANKED
;Turn off all ports
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTD = 0
	clrf	PORTD,ACCESS
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
;Set baud rate
;SPBRG1 = SPBRGL_TEMP
	movlw	129
	movwf	SPBRG1,ACCESS
;SPBRGH1 = SPBRGH_TEMP
	movlw	6
	movwf	SPBRGH1,ACCESS
;BAUDCON1.BRG16 = BRG16_TEMP
	bsf	BAUDCON1,BRG16,ACCESS
;TXSTA1.BRGH = BRGH_TEMP
	bsf	TXSTA1,BRGH,ACCESS
;Enable async mode
;Set SYNC1 Off
	bcf	TXSTA1,SYNC1,ACCESS
;Set SPEN1 On
	bsf	RCSTA1,SPEN1,ACCESS
;Enable TX and RX
;Set CREN1 On
	bsf	RCSTA1,CREN1,ACCESS
;Set TXEN1 On
	bsf	TXSTA1,TXEN1,ACCESS
	return

;********************************************************************************

LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	clrf	LINEDIFFX,BANKED
	clrf	LINEDIFFX_H,BANKED
;LineDiffY = 0
	clrf	LINEDIFFY,BANKED
	clrf	LINEDIFFY_H,BANKED
;LineStepX = 0
	clrf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;LineStepY = 0
	clrf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2,BANKED
	clrf	LINEDIFFX_X2_H,BANKED
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2,BANKED
	clrf	LINEDIFFY_X2_H,BANKED
;LineErr = 0
	clrf	LINEERR,BANKED
	clrf	LINEERR_H,BANKED
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	movwf	LINEDIFFX,BANKED
	movf	LINEX1_H,W,BANKED
	subwfb	LINEX2_H,W,BANKED
	movwf	LINEDIFFX_H,BANKED
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	movwf	LINEDIFFY,BANKED
	movf	LINEY1_H,W,BANKED
	subwfb	LINEY2_H,W,BANKED
	movwf	LINEDIFFY_H,BANKED
;if (LineDiffX > 0) then
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE26_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;else
	bra	ENDIF26
ELSE26_1
;LineStepX = -1
	setf	LINESTEPX,BANKED
	setf	LINESTEPX_H,BANKED
;end if
ENDIF26
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	rcall	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE27_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;else
	bra	ENDIF27
ELSE27_1
;LineStepY = -1
	setf	LINESTEPY,BANKED
	setf	LINESTEPY_H,BANKED
;end if
ENDIF27
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	rcall	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFX
	movff	SysINTEGERTempX_H,LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movff	LINESTEPY,SysINTEGERTempA
	movff	LINESTEPY_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	rcall	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFY
	movff	SysINTEGERTempX_H,LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFX_X2
	movff	SysINTEGERTempX_H,LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movff	LINEDIFFY,SysINTEGERTempA
	movff	LINEDIFFY_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFY_X2
	movff	SysINTEGERTempX_H,LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	rcall	SysCompLessThanINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE28_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFX_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S5
	movff	linex1,SysWORDTempA
	movff	linex1_H,SysWORDTempA_H
	movff	linex2,SysWORDTempB
	movff	linex2_H,SysWORDTempB_H
	rcall	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_NT7108C
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE29_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF29
ELSE29_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	SysTemp3,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movf	SysTemp3,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp3_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;end if
ENDIF29
;loop
	bra	SysDoLoop_S5
SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_NT7108C
;else
	bra	ENDIF28
ELSE28_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFY_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineY1 <>  LineY2)
SysDoLoop_S6
	movff	liney1,SysWORDTempA
	movff	liney1_H,SysWORDTempA_H
	movff	liney2,SysWORDTempB
	movff	liney2_H,SysWORDTempB_H
	rcall	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_NT7108C
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	rcall	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE30_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF30
ELSE30_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	SysTemp3,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	SysTemp3_H,BANKED
	movf	SysTemp3,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp3_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;end if
ENDIF30
;loop
	bra	SysDoLoop_S6
SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEY1,GLCDY
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	rcall	PSET_NT7108C
;end if
ENDIF28
	return

;********************************************************************************

FN_PAD
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSSTRLEN,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE62_1
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	lfsr	1,PAD
	movlw	low StringTable63
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable63
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd17
ENDIF63
SysForLoop17
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop17
ENDIF64
SysForLoopEnd17
;For SysStringTemp = SysCharCount+1 to SysStrLen
	incf	SYSCHARCOUNT,W,BANKED
	movwf	SysTemp1,BANKED
	decf	SysTemp1,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
	incf	SYSCHARCOUNT,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movff	SYSSTRLEN,SysBYTETempA
	rcall	SysCompLessThan
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd18
ENDIF65
SysForLoop18
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString3(1)
	movlw	1
	addwf	SysSYSINSTRING3Handler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRING3Handler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,POSTINC0
;Next
	movf	SYSSTRLEN,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop18
ENDIF66
SysForLoopEnd18
;set new length to PAD
;Pad(0) = SysStrLen
	movff	SYSSTRLEN,SYSPAD_0
;else
	bra	ENDIF62
ELSE62_1
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
	clrf	SYSSTRINGTEMP,BANKED
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd19
ENDIF67
SysForLoop19
	incf	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,PAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,POSTINC0
;Next
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop19
ENDIF68
SysForLoopEnd19
;PAD(0) = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SYSPAD_0
;End If
ENDIF62
	return

;********************************************************************************

PSET_NT7108C
;GLCDY = GLCDY and GLCD_HEIGHT - 1
	movlw	63
	andwf	GLCDY,F,BANKED
;GLCDX = GLCDX and GLCD_WIDTH - 1
	movlw	127
	andwf	GLCDX,F,BANKED
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;Select screen half
;If GLCDX.6 = Off Then Set GLCD_CS2 On:Set GLCD_CS1 off
	btfsc	GLCDX,6,BANKED
	bra	ENDIF40
	bsf	LATC,0,ACCESS
	bcf	LATC,1,ACCESS
ENDIF40
;If GLCDX.6 = On Then Set GLCD_CS1 On: GLCDX -= 64: Set GLCD_CS2 off
	btfss	GLCDX,6,BANKED
	bra	ENDIF41
	bsf	LATC,1,ACCESS
	movlw	64
	subwf	GLCDX,F,BANKED
	bcf	LATC,0,ACCESS
ENDIF41
;Select page
;CurrPage = GLCDY / 8
	movff	GLCDY,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,CURRPAGE
;Set GLCD_RS Off
	bcf	LATE,0,ACCESS
;GLCDWriteByte b'10111000' Or CurrPage
	movlw	184
	iorwf	CURRPAGE,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Select column
;Set GLCD_RS Off
	bcf	LATE,0,ACCESS
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Dummy read first
;Set GLCD_RS On
	bsf	LATE,0,ACCESS
;GLCDDataTemp = GLCDReadByte
	rcall	FN_GLCDREADBYTE_NT7108C
	movff	GLCDREADBYTE_NT7108C,GLCDDATATEMP
;Select column
;Set GLCD_RS Off
	bcf	LATE,0,ACCESS
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Read current data
;Set GLCD_RS On
	bsf	LATE,0,ACCESS
;GLCDDataTemp = GLCDReadByte
	rcall	FN_GLCDREADBYTE_NT7108C
	movff	GLCDREADBYTE_NT7108C,GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	movlw	7
	andwf	GLCDY,W,BANKED
	movwf	GLCDBITNO,BANKED
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,BANKED
	bra	ELSE42_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE,BANKED
;Set C On
	bsf	STATUS,C,ACCESS
;Else
	bra	ENDIF42
ELSE42_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE,BANKED
;Set C Off
	bcf	STATUS,C,ACCESS
;End If
ENDIF42
;Repeat GLCDBitNo
	movff	GLCDBITNO,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;Rotate GLCDChange Left
	rlcf	GLCDCHANGE,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0,BANKED
	bra	ELSE43_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W,BANKED
	andwf	GLCDCHANGE,W,BANKED
	movwf	GLCDDATATEMP,BANKED
;Else
	bra	ENDIF43
ELSE43_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W,BANKED
	iorwf	GLCDCHANGE,W,BANKED
	movwf	GLCDDATATEMP,BANKED
;End If
ENDIF43
;Select correct column again
;Set GLCD_RS Off
	bcf	LATE,0,ACCESS
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	GLCDWRITEBYTE_NT7108C
;Write data back
;Set GLCD_RS On
	bsf	LATE,0,ACCESS
;GLCDWriteByte GLCDDataTemp
	movff	GLCDDATATEMP,LCDBYTE
	rcall	GLCDWRITEBYTE_NT7108C
;Set GLCD_CS1 Off
	bcf	LATC,1,ACCESS
;Set GLCD_CS2 Off
	bcf	LATC,0,ACCESS
	return

;********************************************************************************

FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT,BANKED
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
	bra	ENDIF55
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValThousands
	bra	SYSVALTHOUSANDS
;End If
ENDIF55
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
	bra	ENDIF56
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValHundreds
	bra	SYSVALHUNDREDS
;End If
ENDIF56
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
	bra	ENDIF57
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValTens
	bra	SYSVALTENS
;End If
ENDIF57
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
	bra	ENDIF58
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
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;End If
ENDIF58
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,BANKED
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movff	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

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

SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE52_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF53
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF53
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W,ACCESS
	movwf	SYSDIVMULTA,ACCESS
	comf	SYSINTEGERTEMPA_H,W,ACCESS
	movwf	SYSDIVMULTA_H,ACCESS
	incf	SYSDIVMULTA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSDIVMULTA_H,F,ACCESS
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W,ACCESS
	movwf	SYSINTEGERTEMPA,ACCESS
	comf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSINTEGERTEMPA_H,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempB = SysDivMultA
	movff	SYSDIVMULTA,SYSINTEGERTEMPB
	movff	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
;+A
;Else
	bra	ENDIF52
ELSE52_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
ENDIF54
;End If
ENDIF52
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W,ACCESS
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W,ACCESS
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W,ACCESS
;bnc SCLTIntTrue
	bnc	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W,ACCESS
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
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
	bra	ENDIF72
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF72
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
	bra	ENDIF73
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF73
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
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
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
	bra	ENDIF50
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF50
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,BANKED
	rlcf	SYSLONGDIVMULTX_H,F,BANKED
	rlcf	SYSLONGDIVMULTX_U,F,BANKED
	rlcf	SYSLONGDIVMULTX_E,F,BANKED
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	subwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	subwfb	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	subwfb	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	subwfb	SYSLONGDIVMULTX_E,F,BANKED
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,BANKED
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF51
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,BANKED
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
;End If
ENDIF51
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

SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF47
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF47
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF48
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF48
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF49
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;End If
ENDIF49
	return

;********************************************************************************

SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;X = LowA * LowB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
	movff	PRODL, SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movff	PRODH, SYSWORDTEMPX_H
;HighX += LowA * HighB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;HighX += HighA * LowB
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;PRODL = HighA * HighB
;movf SysWordTempA_H, F
	movf	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF44
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF44
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF45
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF45
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF46
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
ENDIF46
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
	db	4,84,101,115,116


StringTable2
	db	20,71,114,101,97,116,32,67,111,119,32,66,65,83,73,67,32,50,48,49,56


StringTable3
	db	13,64,69,118,97,110,32,82,46,32,86,101,110,110


StringTable4
	db	8,80,114,105,110,116,83,116,114


StringTable5
	db	4,76,65,84,64


StringTable6
	db	3,77,104,122


StringTable7
	db	7,68,114,97,119,83,116,114


StringTable8
	db	1,104


StringTable38
	db	1,32


StringTable63
	db	0


;********************************************************************************


 END
