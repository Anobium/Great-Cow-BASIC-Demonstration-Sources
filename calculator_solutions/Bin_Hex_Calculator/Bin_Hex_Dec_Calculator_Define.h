#StartUp SetPortDir  'Port directions cannot be set directly but
                     'have to be called within a subroutine.
                     '#StartUp is only allowed in header files

'LCD connection settings
#Define LCD_IO 4
#Define LCD_SPEED FAST
#Define LCD_NO_RW

'Port assignments
#Define LCD_RS        PortA.0
#Define LCD_Enable    PortA.1

#Define LCD_DB4       PortA.2
#Define LCD_DB5       PortC.0
#Define LCD_DB6       PortC.1
#Define LCD_DB7       PortC.2

#Define D_Clk         PortC.5 'Pin 5
#Define D_Data        PortA.4 'Pin 3
#Define D_Lat         PortC.4 'Pin 6

#Define Button_R1     PortC.3 'Pin 7 Button Rows (Or columns?)
#Define Button_R2     PortC.6 'Pin 8
#Define Button_R3     PortC.7 'Pin 9

#Define Column_0      1
#Define Column_1      2
#Define Column_2      4
#Define Column_3      8
#Define Column_4      16
#Define Column_5      32
#Define Column_6      64
#Define Column_7      128

#Define Bt0           0 'This will be changed by Mode
#Define Bt1           1
#Define Bt2           2
#Define Bt3           3
#Define Bt4           4
#Define Bt5           5
#Define Bt6           6
#Define Bt7           7
#Define Bt8           8
#Define Bt9           9
#Define BtA           10
#Define BtB           11
#Define BtC           12
#Define BtD           13
#Define BtE           14
#Define BtF           15
#Define BtEn          16
#Define BtPl          17
#Define BtMi          18
#Define BtDi          19
#Define BtMu          20
#Define BtAn          21
#Define BtModulo      22
#Define BtOr          23
#Define BtXor         24
#Define BtNot         25
#Define BtRand        26
#Define BtMode        27
#Define BtClr         26

#Define Answer        29

#Define M_Bin         1
#Define M_Dec         2
#Define M_Hex         3

#Define Bit_16        1
#Define Bit_32        2

#Define NoAnimate     0
#Define Animate       1

#Define CG_Or         0 'Graphic symbol for Or
#Define CG_Xor        1 'Graphic symbol for Xor
#Define CG_Not        2 'Inverted Equals symbol for Not'
#Define PacManFwd     3 'PacMan moving forward
#Define PacManRev     4 'PacMan moving Back
#Define BlankPill     5 'Blank 'Pill'
#Define Pill          6 'Pill for PacMan

#Define EpMode        0 'Location of last used mode in EeProm'
#Define Ep_Bit        1 'Location of 16bit or 32bit mode in EeProm
#Define EP_Ani        2 'Location of Animate mode in EeProm

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
