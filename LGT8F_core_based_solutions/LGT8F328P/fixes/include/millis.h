'
'    millis() function for Great Cow BASIC
'
'  Copyright (C) 2018-2020 Chris Roper
'  This library is free software; you can redistribute it and/or
'  modify it under the terms of the GNU Lesser General Public
'  License as published by the Free Software Foundation; either
'  version 2.1 of the License, or (at your option) any later version.

'  This library is distributed in the hope that it will be useful,
'  but WITHOUT ANY WARRANTY; without even the implied warranty of
'  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
'  See the GNU Lesser General Public License for more details.

'  You should have received a copy of the GNU Lesser General Public
'  License along with this library; if not, write to the Free Software
'  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
'  MA 02110-1301  USA

'Changes:
'Changes:
' 30/12/2018: Initial test release - 8 Bit TIMER0, 16Mhz Clock - ChrisR
' 02/01/2019: 8 Bit TIMER0, 1Mhz - 32Mhz Clock support - ChrisR
' 04/01/2019: Add PIC support for 16Bit Timer0 - EvanV / ChrisR
' 06/01/2019: Add  support for 16Bit Timer0 no postscaler - EvanV
' 04/04/2019: Add AVR support - 16mhz only
' 09/10/2020: Add AVR support - 32..1 mhz

'***********************************************************

'Subroutines:
' MsCtr_Int_Hdlr
' Init_MsCtr_Int
' Millis(void)
'
' A constant is used to  set Tmr0InitVal. When folks have issues we can tell people to change this in the user program when the oscillator is not correctly setup.
#define Millis_Default_Timer0_value 6

'**************  Timer 0 Notes ***********************
' PIC Timer0 is a free running timer on midrange and
' baseline PICs. On these chips timer 0 always runs
' and cannot be stopped.   However on most 18Fxxx PICs,
' timer 0 can be started or stopped via the T0CON.7 Bit.
' Therefore, on these chips The timer MUST be started with
' StartTimer 0.
'
' On most 18F or Enhanced Core 16F PICS, Timer 0 can be either an 8-Bit ' or 16-Bit timer.  On these chips this is determined by TC0CON.6
' (T08BIT). The timer defaults to 8-bit.
'
' On AVR.  8bit timer.
'*********************************************************
'



#script

  Tmr0InitVal = Millis_Default_Timer0_value
  16BITTimer0 = 0
  if bit(T016BIT) then
      16BITTimer0 = 1
  end if
;check Frequency
  MillisErrorHandler = 0

  if ChipMHz=64 then
    MillisErrorHandler=1
    Tmr0InitVal = 6
  end if
  if ChipMHz=48 then
    MillisErrorHandler=1
    Tmr0InitVal = 68
  end if
  if ChipMHz=32 then
    MillisErrorHandler=1
    if AVR then
        Tmr0InitVal = 131
    end if
  end if
  if ChipMHz=16 then
    MillisErrorHandler=1
  end if
  if ChipMHz=8 then
    MillisErrorHandler=1
    if AVR then
        Tmr0InitVal = 131
    end if
  end if
  if ChipMHz=4 then
    MillisErrorHandler=1
    if AVR then
        Tmr0InitVal = 193
    end if
  end if
  if ChipMHz=2 then
    MillisErrorHandler=1
  end if
  if ChipMHz=1 then
    MillisErrorHandler=1
    if AVR then
        Tmr0InitVal = 131
    end if
  end if

  if MillisErrorHandler = 0 Then
      Warning ChipMHz
      Warning "Millis() does not support the selected Chip Frequency"
      Warning "Contact us on the Great Cow BASIC forum for more information"
  End if

;Check family
  'This check could be removed
  MillisErrorHandler = 0
  if ChipFamily=100 then  'AVR core version V0E class microcontrollers
    MillisErrorHandler=1
  End if
  if ChipFamily=110 then    'AVR core version V1E class microcontrollers
    MillisErrorHandler=1
  End if
  if ChipFamily=120 then   'AVR core version V2E class microcontrollers
    MillisErrorHandler=1
  end if
  if ChipFamily=122 then   'AVR core version V2E class microcontrollers
    MillisErrorHandler=1
  end if
  if ChipFamily=130 then   'AVR core version V3E class microcontrollers but essentially the mega32u6 only
    MillisErrorHandler=1
  end if
  if ChipFamily=12 then
    MillisErrorHandler=1
  end if
  if ChipFamily=14 then
    MillisErrorHandler=1
  end if
  if ChipFamily=15 then
    MillisErrorHandler=1
  end if
  if ChipFamily=16 then
      MillisErrorHandler=1
  end if

  if MillisErrorHandler = 0 Then
      Warning ChipFamily
      Warning "Millis() does not support the selected Chip Family"
  End if

#endscript

#startup Init_MsCtr_Int   ' Initialize Hardware Counter and Interrupt

'This will be called when the Timer overflows
dim MsCtr_ as long

Sub MsCtr_Int_Hdlr
  dim MsCtr_ as Long

  asm ShowDebug Call_SetTimer_Millis_macro
  SetTimer_Millis  Tmr0InitVal   ' Reset Inital Counter valueue

  MsCtr_ = MsCtr_ + 1
End Sub


Sub Init_MsCtr_Int
  ' Add the handler for the interrupt
  On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
  MsCtr_ = 0
  Millis = 0

'
'  #define PS_0_0 0        ' no clock source
'  #define PS_0_1 1
'  #define PS_0_8 2
'  #define PS_0_64 3
'  #define PS_0_256 4
'  #define PS_0_1024 5

  #ifdef AVR

    #IFDEF ChipMHz 32
      ' Set prescaler to 256, Preload and then start the timer
      InitTimer0 Osc, PS_0_256
    #endif

    #IFDEF ChipMHz 16
      ' Set prescaler to 64, Preload and then start the timer
      InitTimer0 Osc, PS_0_64
    #endif

    #IFDEF ChipMHz 8
      ' Set prescaler to 64, Preload and then start the timer
      InitTimer0 Osc, PS_0_64
    #endif

    #IFDEF ChipMHz 4
      ' Set prescaler to 64, Preload and then start the timer
      InitTimer0 Osc, PS_0_64
    #endif

    #IFDEF ChipMHz 2
      ' Set prescaler to 8, Preload and then start the timer
      InitTimer0 Osc, PS_0_8
    #endif

    #IFDEF ChipMHz 1
      ' Set prescaler to 8, Preload and then start the timer
      InitTimer0 Osc, PS_0_8
    #endif

  #endif

  #ifdef PIC
    #IFDEF ChipFamily 14
      ' Set prescaler
      #IFDEF ChipMHz 16
        InitTimer0 Osc, PS0_4
      #endif

      #IFDEF ChipMHz 8
        InitTimer0 Osc, PS0_8
      #endif

      #IFDEF ChipMHz 4
        InitTimer0 Osc, PS0_4
      #endif

      #IFDEF ChipMHz 2
        InitTimer0 Osc, PS0_2
      #endif

      #IFDEF ChipMHz 1
        PSA = 1 ' PSA = 1 Prescaler is assigned to WDT
        InitTimer0 Osc, PS0_1
      #endif
    #ENDIF

    #IFDEF ChipFamily 15, 16

       #IFDEF ChipMHz 64

          #if 16BITTimer0 = 0
            asm ShowDebug 8bit / 16bit No Postscaler @ 48
            InitTimer0 Osc, PS0_64
          #endif

          #if 16BITTimer0 = 1
            asm ShowDebug 16bit capable, but running in 8bit mode
            InitTimer0 Osc, PRE0_64 + TMR0_FOSC4 ,  POST0_1
          #endif
        #endif


       #IFDEF ChipMHz 48

          #if 16BITTimer0 = 0
            asm ShowDebug 8bit / 16bit No Postscaler @ 48
            InitTimer0 Osc, PS0_64
          #endif

          #if 16BITTimer0 = 1
            asm ShowDebug 16bit capable, but running in 8bit mode
            InitTimer0 Osc, PRE0_64 + TMR0_FOSC4 ,  POST0_1
          #endif
        #endif

      #IFDEF ChipMHz 32

        #if 16BITTimer0 = 0
          asm ShowDebug 8bit / 16bit No Postscaler
          InitTimer0 Osc, PS0_32
        #endif

        #if 16BITTimer0 = 1
          asm ShowDebug 16bit capable, but running in 8bit mode
          InitTimer0 Osc, PRE0_32 + TMR0_FOSC4 ,  POST0_1
        #endif
      #endif

      #IFDEF ChipMHz 16

        #if 16BITTimer0 = 0
          asm ShowDebug 8bit / 16bit No Postscaler
          InitTimer0 Osc, PS0_16
        #endif

        #if 16BITTimer0 = 1
          asm ShowDebug 16bit capable, but running in 8bit mode
          InitTimer0 Osc, PRE0_16 + TMR0_FOSC4 ,  POST0_1
        #endif
      #endif

      #IFDEF ChipMHz 8

        #if 16BITTimer0 = 0
          asm ShowDebug 8bit / 16bit No Postscaler
          InitTimer0 Osc, PS0_8
        #endif

        #if 16BITTimer0 = 1
          asm ShowDebug 16bit capable, but running in 8bit mode
          InitTimer0 Osc, PRE0_8 + TMR0_FOSC4 ,  POST0_1
        #endif
      #endif

       #IFDEF ChipMHz 4

        #if 16BITTimer0 = 0
          asm ShowDebug 8bit / 16bit No Postscaler
          InitTimer0 Osc, PS0_4
        #endif

        #if 16BITTimer0 = 1
          asm ShowDebug 16bit capable, but running in 8bit mode
          InitTimer0 Osc, PRE0_4 + TMR0_FOSC4 ,  POST0_1
        #endif
      #endif

      #IFDEF ChipMHz 2

        #if 16BITTimer0 = 0
          asm ShowDebug 8bit / 16bit No Postscaler
          InitTimer0 Osc, PS0_2
        #endif

        #if 16BITTimer0 = 1
          asm ShowDebug 16bit capable, but running in 8bit mode
          InitTimer0 Osc, PRE0_2 + TMR0_FOSC4 ,  POST0_1
        #endif
      #endif

      #IFDEF ChipMHz 1

        #if 16BITTimer0 = 0
          asm ShowDebug 8bit / 16bit No Postscaler
          InitTimer0 Osc, PS0_1
        #endif

        #if 16BITTimer0 = 1
          asm ShowDebug 16bit capable, but running in 8bit mode
          InitTimer0 Osc, PRE0_1 + TMR0_FOSC4 ,  POST0_1
        #endif
      #endif
    #endif
  #ENDIF

  asm ShowDebug  Call_SetTimer_Millis_macro
  SetTimer_Millis Tmr0InitVal

  asm ShowDebug Call_StartTimer_Millis_macro
  StartTimer_Millis

End Sub

'Return the current ms as Millis
Function Millis as Long
  dim Millis, MsCtr_ as long
  'disable interrupts while we read millis or we might get an
  'inconsistent value (e.g. in the middle of a write to millis)
  IntOff
    Millis = MsCtr_
  IntOn
End Function

'Code taken from timer.h
macro SetTimer_Millis ( In TMRValueMillis As Word)

    #ifdef PIC
        #ifndef Var(TMR0H)
         ' Handle chips withOUT TMR0H
           TMR0 = TMRValueMillis
        #endif

        #ifdef Var(TMR0H)
         ' Handle chips with TMR0H

           #ifdef TMR0_16BIT
              TMR0H = TMRValueMillis_H
              TMR0L = TMRValueMillis
           #endif


           #ifndef TMR0_16BIT
              ' USe default 8-bit mode
               TMR0L = TMRValueMillis
           #endif

        #endif
    #endif

    #ifdef AVR
        TCNT0 = TMRValueMillis
    #endif

End macro

'Code taken from timer.h
macro StartTimer_Millis

  #ifdef PIC
     #ifdef bit(TMR0ON)
        Set TMR0ON on
     #endif


     #ifdef bit(T0EN)
        Set T0EN on
     #endif
  #endif


  #ifdef AVR
     'Need to set clock select bits to 0 (Stops Timer)
      #ifndef Var(TCCR0B)
        #ifdef Var(TCCR0)
          TCCR0 = TMR0_TMP
        #endif
     #endif

     #ifdef Var(TCCR0B)
        TCCR0B = TCCR0B And 248 Or TMR0_TMP
     #endif
  #endif

End macro



Sub SetMillis ( in localCurMs   as long, out localLstMs as long )
  IntOff
  localLstMs = localCurMs
  IntOn
End Sub
