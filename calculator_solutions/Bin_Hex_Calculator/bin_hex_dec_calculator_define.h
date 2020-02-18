'Port directions cannot be set directly but
#STARTUP SetPortDir
'have to be called within a subroutine.
'#StartUp is only allowed in header files

'LCD connection settings
#DEFINE LCD_IO 4
#DEFINE LCD_SPEED FAST
#DEFINE LCD_NO_RW

'Port assignments
#DEFINE LCD_RS        PortA.0
#DEFINE LCD_Enable    PortA.1

#DEFINE LCD_DB4       PortA.2
#DEFINE LCD_DB5       PortC.0
#DEFINE LCD_DB6       PortC.1
#DEFINE LCD_DB7       PortC.2

'Pin 5
#DEFINE D_Clk         PortC.5
'Pin 3
#DEFINE D_Data        PortA.4
'Pin 6
#DEFINE D_Lat         PortC.4

'Pin 7 Button Rows (Or columns?)
#DEFINE Button_R1     PortC.3
'Pin 8
#DEFINE Button_R2     PortC.6
'Pin 9
#DEFINE Button_R3     PortC.7

#DEFINE Column_0      1
#DEFINE Column_1      2
#DEFINE Column_2      4
#DEFINE Column_3      8
#DEFINE Column_4      16
#DEFINE Column_5      32
#DEFINE Column_6      64
#DEFINE Column_7      128

#DEFINE Bt0           0
'The value used by pressing '0' within a numeric entry
'will be changed according the entry Mode.
'It will equall multiplication by:
'Multiply by 2  for binary Mode
'Multiply by 10 for decimal Mode
'Multiply by 16 for hexadecimal mode
#DEFINE Bt1           1
#DEFINE Bt2           2
#DEFINE Bt3           3
#DEFINE Bt4           4
#DEFINE Bt5           5
#DEFINE Bt6           6
#DEFINE Bt7           7
#DEFINE Bt8           8
#DEFINE Bt9           9
#DEFINE BtA           10
#DEFINE BtB           11
#DEFINE BtC           12
#DEFINE BtD           13
#DEFINE BtE           14
#DEFINE BtF           15

'Enter key
#DEFINE BtEn          16

'Operands from here *********************************

'Values here are operators
'which require two operands to
'be calculated
#DEFINE BtPl          17
#DEFINE BtMi          18
#DEFINE BtDi          19
#DEFINE BtMu          20
#DEFINE BtAn          21
#DEFINE BtModulo      22
#DEFINE BtOr          23
#DEFINE BtXor         24
'Values heres are operators
'which require two operands to
'be calculated

'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'For the correct functioning of those operators which
'take only a single operand, they must be given values
'greater than BtNot or they will not work.
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

'These operators work directly with
'a single operand
#DEFINE BtNot         25
#DEFINE BtRand        26

#DEFINE BtShiftL      27
#DEFINE BtShiftR      28
'These operators work directly with
'a single operand

#DEFINE BtMode        29
#DEFINE BtClr         30

#DEFINE Answer        31
'End of button values



#DEFINE M_Bin         1
#DEFINE M_Dec         2
#DEFINE M_Hex         3

#DEFINE Bit_16        1
#DEFINE Bit_32        2

#DEFINE NoAnimate     0
#DEFINE Animate       1

'Graphic symbol for Or
#DEFINE CG_Or         0
'Graphic symbol for Xor
#DEFINE CG_Xor        1
'Inverted Equals symbol for Not'
#DEFINE CG_Not        2
'PacMan moving forward
#DEFINE PacManFwd     3
'PacMan moving Back
#DEFINE PacManRev     4
'Blank 'Pill'
#DEFINE BlankPill     5
'Pill for PacMan
#DEFINE Pill          6

'Location of last used mode in EeProm'
#DEFINE EpMode        0
'Location of 16bit or 32bit mode in EeProm
#DEFINE Ep_Bit        1
'Location of Animate mode in EeProm
#DEFINE EP_Ani        2


Sub SetPortDir
    'Port directions
    Dir     Button_R1     Out
    Dir     Button_R2     Out
    Dir     Button_R3     Out

    Dir     LCD_RS        Out
    Dir     LCD_Enable    Out
    Dir     LCD_DB4       Out
    Dir     LCD_DB5       Out
    Dir     LCD_DB6       Out
    Dir     LCD_DB7       Out

    Dir     D_Clk         Out
    Dir     D_Data        In
    Dir     D_Lat         Out
End Sub
