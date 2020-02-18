'_______________________________________________________________________
'
'
'                       Multitasking functions
'
'_______________________________________________________________________
'
'
'    multitasking routines for the Great Cow BASIC compiler
'    2009 Santiago Gonzalez and 2017 Evan Venn
'
'    This library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

'    You should have received a copy of the GNU Lesser General Public
'    License along with this library; if not, write to the Free Software
'    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
'
'_______________________________________________________________________
'
'
'Notes:
'
'¡¡¡¡¡ this library will use Timer0, don't use it in your program !!!!!.
'
'Actually a maximum of 16 Tasks and 8 LTasks are supported.
'
'The base time must be defined:
'
'#define base_time value

'where value is the desired value in us, for example:
'
'#define base_time 100      'for 100 us

'Maximum base_time value with 20 MHz clock is 13107.
'Maximum base_time value with 4 MHz clock is 65535.
'Maximum base_time value with other clocks: 65535/ChipMhz/4.
'
'
'The subroutine containing each task must be defined:
'
'#define Task1 Sub_name1
'#define Task2 Sub_name2
'#define LTask1 Sub_name3
'
'
'The period of each Task must be defined:
'
'#define Task1_us 500            'Task1 period is 500 us
'#define Task2_ms 10             'Task2 period is 10 ms
'#define LTask1_s 1              'LTask1 period is 1 s
'
'In the previous example, Sub_name1 will be executed every 500 us,
'   Sub_name2 every 10 ms and Sub_name3 every 1 S.
'
'Maximum value for Task period in us is: base_time*255
'
'For example, with a 100 us base_time,
'   maximum value for Tasks is: 100*255 = 25500 us => 25 ms
'
'LTask is for long period tasks,
'   a period is long or not depending on the base_time
'   When the needed period > base_time*255 then you need a LTask
'
'Maximun value for LTask period in us is: base_time*65535
'
'For example, with a 100 us base_time,
'   maximum value for LTasks is: 100*65535 = 6553500 us => 6553 ms => 6 s
'
'
'Task will be executed with the command: Do_Taskx,
'   for example  in a main loop:
'
'do
'    Do_Task2
'    Do_LTask1
'loop
'
'or any other way... for example:
'
'do
'    Do_Task2
'    if PORTB.0 on then Do_LTask1
'loop
'
'
'Is possible to execute a Task inside Interrupt subroutine:
'
'#define Run_Task1               'Run Task inside interrupt subroutine
'
'_______________________________________________________________________

'Initialisation routine
#STARTUP Init_Multitask


Sub Init_Multitask

    '2 bytes for 16 flags
    Dim flags As Word
    Dim value_tmr0 As Byte

    'use flags variable as temporary register
    flags = ChipMHz/4 * base_time

    If flags_H = 0 Then
        'calculate prescaler and initial timer0 counter
        TimerInitValue = 8

    Else
        TimerInitValue = 0

        Do While flags_H <> 0
            flags = flags / 2
            TimerInitValue++
        Loop
        TimerInitValue++

    End If
    value_tmr0 = 0
    value_tmr0 = value_tmr0 - flags
    flags = 0

    StartTimer 0

    ' Set the Timer start value
    SetTimer ( 0, value_tmr0 )


    #IFDEF Task1
        #IFDEF Task1_us
            time_Task1 = Task1_us/base_time
        #ENDIF
        #IFDEF Task1_ms
            time_Task1 = Task1_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task1 flags.0
    #ENDIF

    #IFDEF LTask1
        Dim time_LTask1 As Word
        Dim cont_LTask1 As Word
        #IFDEF LTask1_us
            time_LTask1 = LTask1_us/base_time
        #ENDIF
        #IFDEF LTask1_ms
            time_LTask1 = LTask1_ms*1000/base_time
        #ENDIF
        #IFDEF LTask1_s
            time_LTask1 = LTask1_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask1 Lflags.0
    #ENDIF

    'here only Task1 and LTask1 are defined
    Call init_rest_of_tasks
    'to show procedure, rest of task are defined
    'in: Sub init_rest_of_tasks

    On Interrupt Timer0Overflow Call Interr_Timer0

End Sub


Sub Interr_Timer0
    TMR0IF = 0

    ' Set the Timer start value
    SetTimer ( 0, TMR0 + value_tmr0 )

    #IFDEF Task1
        'increment task counter
        cont_Task1 += 1
        If cont_Task1 >= time_Task1 Then
            'if task time reached
            'restart counter
            cont_Task1 = 0
            'set task flag
            flag_Task1 = 1
        End If
        #IFDEF Run_Task1
            Do_Task1
        #ENDIF
    #ENDIF

    #IFDEF Task2
        cont_Task2 += 1
        If cont_Task2 >= time_Task2 Then
            cont_Task2 = 0
            flag_Task2 = 1
        End If
        #IFDEF Run_Task2
            Do_Task2
        #ENDIF
    #ENDIF

    #IFDEF Task3
        cont_Task3 += 1
        If cont_Task3 >= time_Task3 Then
            cont_Task3 = 0
            flag_Task3 = 1
        End If
        #IFDEF Run_Task3
            Do_Task3
        #ENDIF
    #ENDIF

    #IFDEF Task4
        cont_Task4 += 1
        If cont_Task4 >= time_Task4 Then
            cont_Task4 = 0
            flag_Task4 = 1
        End If
        #IFDEF Run_Task4
            Do_Task4
        #ENDIF
    #ENDIF

    #IFDEF Task5
        cont_Task5 += 1
        If cont_Task5 >= time_Task5 Then
            cont_Task5 = 0
            flag_Task5 = 1
        End If
        #IFDEF Run_Task5
            Do_Task5
        #ENDIF
    #ENDIF

    #IFDEF Task6
        cont_Task6 += 1
        If cont_Task6 >= time_Task6 Then
            cont_Task6 = 0
            flag_Task6 = 1
        End If
        #IFDEF Run_Task6
            Do_Task6
        #ENDIF
    #ENDIF

    #IFDEF Task7
        cont_Task7 += 1
        If cont_Task7 >= time_Task7 Then
            cont_Task7 = 0
            flag_Task7 = 1
        End If
        #IFDEF Run_Task7
            Do_Task7
        #ENDIF
    #ENDIF

    #IFDEF Task8
        cont_Task8 += 1
        If cont_Task8 >= time_Task8 Then
            cont_Task8 = 0
            flag_Task8 = 1
        End If
        #IFDEF Run_Task8
            Do_Task8
        #ENDIF
    #ENDIF

    #IFDEF Task9
        'increment task counter
        cont_Task9 += 1
        If cont_Task9 >= time_Task9 Then
            'if task time reached
            'restart counter
            cont_Task9 = 0
            'set task flag
            flag_Task9 = 1
        End If
        #IFDEF Run_Task9
            Do_Task9
        #ENDIF
    #ENDIF

    #IFDEF Task10
        cont_Task10 += 1
        If cont_Task10 >= time_Task10 Then
            cont_Task10 = 0
            flag_Task10 = 1
        End If
        #IFDEF Run_Task10
            Do_Task10
        #ENDIF
    #ENDIF

    #IFDEF Task11
        cont_Task11 += 1
        If cont_Task11 >= time_Task11 Then
            cont_Task11 = 0
            flag_Task11 = 1
        End If
        #IFDEF Run_Task11
            Do_Task11
        #ENDIF
    #ENDIF

    #IFDEF Task12
        cont_Task12 += 1
        If cont_Task12 >= time_Task12 Then
            cont_Task12 = 0
            flag_Task12 = 1
        End If
        #IFDEF Run_Task12
            Do_Task12
        #ENDIF
    #ENDIF

    #IFDEF Task13
        cont_Task13 += 1
        If cont_Task13 >= time_Task13 Then
            cont_Task13 = 0
            flag_Task13 = 1
        End If
        #IFDEF Run_Task13
            Do_Task13
        #ENDIF
    #ENDIF

    #IFDEF Task14
        cont_Task14 += 1
        If cont_Task14 >= time_Task14 Then
            cont_Task14 = 0
            flag_Task14 = 1
        End If
        #IFDEF Run_Task14
            Do_Task14
        #ENDIF
    #ENDIF

    #IFDEF Task15
        cont_Task15 += 1
        If cont_Task15 >= time_Task15 Then
            cont_Task15 = 0
            flag_Task15 = 1
        End If
        #IFDEF Run_Task15
            Do_Task15
        #ENDIF
    #ENDIF

    #IFDEF Task16
        cont_Task16 += 1
        If cont_Task16 >= time_Task16 Then
            cont_Task16 = 0
            flag_Task16 = 1
        End If
        #IFDEF Run_Task16
            Do_Task16
        #ENDIF
    #ENDIF

    '--------------------------- LONG TASKs -------------------------

    #IFDEF LTask1
        movlw 1
        'increment LTask counter
        addwf   cont_LTask1,F
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask1_H,F
        SysCalcTempB_H = CONT_LTASK1_H
        SysCalcTempB = CONT_LTASK1
        SysCalcTempA_H = TIME_LTASK1_H
        SysCalcTempA = TIME_LTASK1
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            'if LTask time reached
            'restart counter
            cont_LTask1 = 0
            cont_LTask1_H = 0
            'set LTask flag
            flag_LTask1 = 1
        End If
        #IFDEF Run_LTask1
            Do_LTask1
        #ENDIF
    #ENDIF

    #IFDEF LTask2
        movlw 1
        addwf    cont_LTask2
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask2_H,F
        SysCalcTempB_H = CONT_LTASK2_H
        SysCalcTempB = CONT_LTASK2
        SysCalcTempA_H = TIME_LTASK2_H
        SysCalcTempA = TIME_LTASK2
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            cont_LTask2 = 0
            cont_LTask2_H = 0
            flag_LTask2 = 1
        End If
        #IFDEF Run_LTask2
            Do_LTask2
        #ENDIF
    #ENDIF

    #IFDEF LTask3
        movlw 1
        addwf    cont_LTask3
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask3_H,F
        SysCalcTempB_H = CONT_LTASK3_H
        SysCalcTempB = CONT_LTASK3
        SysCalcTempA_H = TIME_LTASK3_H
        SysCalcTempA = TIME_LTASK3
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            cont_LTask3 = 0
            cont_LTask3_H = 0
            flag_LTask3 = 1
        End If
        #IFDEF Run_LTask3
            Do_LTask3
        #ENDIF
    #ENDIF

    #IFDEF LTask4
        movlw 1
        addwf    cont_LTask4
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask4_H,F
        SysCalcTempB_H = CONT_LTASK4_H
        SysCalcTempB = CONT_LTASK4
        SysCalcTempA_H = TIME_LTASK4_H
        SysCalcTempA = TIME_LTASK4
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            cont_LTask4 = 0
            cont_LTask4_H = 0
            flag_LTask4 = 1
        End If
        #IFDEF Run_LTask4
            Do_LTask4
        #ENDIF
    #ENDIF

    #IFDEF LTask5
        movlw 1
        addwf    cont_LTask5
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask5_H,F
        SysCalcTempB_H = CONT_LTASK5_H
        SysCalcTempB = CONT_LTASK5
        SysCalcTempA_H = TIME_LTASK5_H
        SysCalcTempA = TIME_LTASK5
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            cont_LTask5 = 0
            cont_LTask5_H = 0
            flag_LTask5 = 1
        End If
        #IFDEF Run_LTask5
            Do_LTask5
        #ENDIF
    #ENDIF

    #IFDEF LTask6
        movlw 1
        addwf    cont_LTask6
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask6_H,F
        SysCalcTempB_H = CONT_LTASK6_H
        SysCalcTempB = CONT_LTASK6
        SysCalcTempA_H = TIME_LTASK6_H
        SysCalcTempA = TIME_LTASK6
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            cont_LTask6 = 0
            cont_LTask6_H = 0
            flag_LTask6 = 1
        End If
        #IFDEF Run_LTask6
            Do_LTask6
        #ENDIF
    #ENDIF

    #IFDEF LTask7
        movlw 1
        addwf    cont_LTask7
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask7_H,F
        SysCalcTempB_H = CONT_LTASK7_H
        SysCalcTempB = CONT_LTASK7
        SysCalcTempA_H = TIME_LTASK7_H
        SysCalcTempA = TIME_LTASK7
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            cont_LTask7 = 0
            cont_LTask7_H = 0
            flag_LTask7 = 1
        End If
        #IFDEF Run_LTask7
            Do_LTask7
        #ENDIF
    #ENDIF

    #IFDEF LTask8
        movlw 1
        addwf    cont_LTask8
        movlw 0
        btfsc STATUS,C
        addlw 1
        addwf cont_LTask8_H,F
        SysCalcTempB_H = CONT_LTASK8_H
        SysCalcTempB = CONT_LTASK8
        SysCalcTempA_H = TIME_LTASK8_H
        SysCalcTempA = TIME_LTASK8
        Call SysCompLessThan
        If SysCalcTempX.0 On  Then
            cont_LTask8 = 0
            cont_LTask8_H = 0
            flag_LTask8 = 1
        End If
        #IFDEF Run_LTask8
            Do_LTask8
        #ENDIF
    #ENDIF
End Sub

'Calculate ticks value from time value
Sub init_rest_of_tasks
    #IFDEF Task2
        #IFDEF Task2_us
            time_Task2 = Task2_us/base_time
        #ENDIF
        #IFDEF Task2_ms
            time_Task2 = Task2_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task2 flags.1
    #ENDIF

    #IFDEF Task3
        #IFDEF Task3_us
            time_Task3 = Task3_us/base_time
        #ENDIF
        #IFDEF Task3_ms
            time_Task3 = Task3_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task3 flags.2
    #ENDIF

    #IFDEF Task4
        #IFDEF Task4_us
            time_Task4 = Task4_us/base_time
        #ENDIF
        #IFDEF Task4_ms
            time_Task4 = Task4_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task4 flags.3
    #ENDIF

    #IFDEF Task5
        #IFDEF Task5_us
            time_Task5 = Task5_us/base_time
        #ENDIF
        #IFDEF Task5_ms
            time_Task5 = Task5_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task5 flags.4
    #ENDIF

    #IFDEF Task6
        #IFDEF Task6_us
            time_Task6 = Task6_us/base_time
        #ENDIF
        #IFDEF Task6_ms
            time_Task6 = Task6_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task6 flags.5
    #ENDIF

    #IFDEF Task7
        #IFDEF Task7_us
            time_Task7 = Task7_us/base_time
        #ENDIF
        #IFDEF Task7_ms
            time_Task7 = Task7_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task7 flags.6
    #ENDIF

    #IFDEF Task8
        #IFDEF Task8_us
            time_Task8 = Task8_us/base_time
        #ENDIF
        #IFDEF Task8_ms
            time_Task8 = Task8_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task8 flags.7
    #ENDIF

    #IFDEF Task9
        #IFDEF Task9_us
            time_Task9 = Task9_us/base_time
        #ENDIF
        #IFDEF Task9_ms
            time_Task9 = Task9_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task9 flags_H.0
    #ENDIF

    #IFDEF Task10
        #IFDEF Task10_us
            time_Task10 = Task10_us/base_time
        #ENDIF
        #IFDEF Task10_ms
            time_Task10 = Task10_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task10 flags_H.1
    #ENDIF

    #IFDEF Task11
        #IFDEF Task11_us
            time_Task11 = Task11_us/base_time
        #ENDIF
        #IFDEF Task11_ms
            time_Task11 = Task11_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task11 flags_H.2
    #ENDIF

    #IFDEF Task12
        #IFDEF Task12_us
            time_Task12 = Task12_us/base_time
        #ENDIF
        #IFDEF Task12_ms
            time_Task12 = Task12_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task12 flags_H.3
    #ENDIF

    #IFDEF Task13
        #IFDEF Task13_us
            time_Task13 = Task13_us/base_time
        #ENDIF
        #IFDEF Task13_ms
            time_Task13 = Task13_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task13 flags_H.4
    #ENDIF

    #IFDEF Task14
        #IFDEF Task14_us
            time_Task14 = Task14_us/base_time
        #ENDIF
        #IFDEF Task14_ms
            time_Task14 = Task14_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task14 flags_H.5
    #ENDIF

    #IFDEF Task15
        #IFDEF Task15_us
            time_Task15 = Task15_us/base_time
        #ENDIF
        #IFDEF Task15_ms
            time_Task15 = Task15_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task15 flags_H.6
    #ENDIF

    #IFDEF Task16
        #IFDEF Task16_us
            time_Task16 = Task16_us/base_time
        #ENDIF
        #IFDEF Task16_ms
            time_Task16 = Task16_ms*1000/base_time
        #ENDIF
        #DEFINE flag_Task16 flags_H.7
    #ENDIF

    '--------------------------- LONG TASKs -------------------------


    #IFDEF LTask2
        Dim time_LTask2 As Word
        Dim cont_LTask2 As Word
        #IFDEF LTask2_us
            time_LTask2 = LTask2_us/base_time
        #ENDIF
        #IFDEF LTask2_ms
            time_LTask2 = LTask2_ms*1000/base_time
        #ENDIF
        #IFDEF LTask2_s
            time_LTask2 = LTask2_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask2 Lflags.1
    #ENDIF

    #IFDEF LTask3
        Dim time_LTask3 As Word
        Dim cont_LTask3 As Word
        #IFDEF LTask3_us
            time_LTask3 = LTask3_us/base_time
        #ENDIF
        #IFDEF LTask3_ms
            time_LTask3 = LTask3_ms*1000/base_time
        #ENDIF
        #IFDEF LTask3_s
            time_LTask3 = LTask3_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask3 Lflags.2
    #ENDIF

    #IFDEF LTask4
        Dim time_LTask4 As Word
        Dim cont_LTask4 As Word
        #IFDEF LTask4_us
            time_LTask4 = LTask4_us/base_time
        #ENDIF
        #IFDEF LTask4_ms
            time_LTask4 = LTask4_ms*1000/base_time
        #ENDIF
        #IFDEF LTask4_s
            time_LTask4 = LTask4_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask4 Lflags.3
    #ENDIF

    #IFDEF LTask5
        Dim time_LTask5 As Word
        Dim cont_LTask5 As Word
        #IFDEF LTask5_us
            time_LTask5 = LTask5_us/base_time
        #ENDIF
        #IFDEF LTask5_ms
            time_LTask5 = LTask5_ms*1000/base_time
        #ENDIF
        #IFDEF LTask5_s
            time_LTask5 = LTask5_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask5 Lflags.4
    #ENDIF

    #IFDEF LTask6
        Dim time_LTask6 As Word
        Dim cont_LTask6 As Word
        #IFDEF LTask6_us
            time_LTask6 = LTask6_us/base_time
        #ENDIF
        #IFDEF LTask6_ms
            time_LTask6 = LTask6_ms*1000/base_time
        #ENDIF
        #IFDEF LTask6_s
            time_LTask6 = LTask6_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask6 Lflags.5
    #ENDIF

    #IFDEF LTask7
        Dim time_LTask7 As Word
        Dim cont_LTask7 As Word
        #IFDEF LTask7_us
            time_LTask7 = LTask7_us/base_time
        #ENDIF
        #IFDEF LTask7_ms
            time_LTask7 = LTask7_ms*1000/base_time
        #ENDIF
        #IFDEF LTask7_s
            time_LTask7 = LTask7_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask7 Lflags.6
    #ENDIF

    #IFDEF LTask8
        Dim time_LTask8 As Word
        Dim cont_LTask8 As Word
        #IFDEF LTask8_us
            time_LTask8 = LTask8_us/base_time
        #ENDIF
        #IFDEF LTask8_ms
            time_LTask8 = LTask8_ms*1000/base_time
        #ENDIF
        #IFDEF LTask8_s
            time_LTask8 = LTask8_s*1000000/base_time
        #ENDIF
        #DEFINE flag_LTask8 Lflags.7
    #ENDIF
End Sub


#IFDEF Task1
Sub Do_Task1
    If flag_Task1 On Then
        Set flag_Task1 Off
        Call Task1
    End If
End Sub
#ENDIF

#IFDEF Task2
Sub Do_Task2
    If flag_Task2 On Then
        Set flag_Task2 Off
        Call Task2
    End If
End Sub
#ENDIF

#IFDEF Task3
Sub Do_Task3
    If flag_Task3 On Then
        Set flag_Task3 Off
        Call Task3
    End If
End Sub
#ENDIF

#IFDEF Task4
Sub Do_Task4
    If flag_Task4 On Then
        Set flag_Task4 Off
        Call Task4
    End If
End Sub
#ENDIF

#IFDEF Task5
Sub Do_Task5
    If flag_Task5 On Then
        Set flag_Task5 Off
        Call Task5
    End If
End Sub
#ENDIF

#IFDEF Task6
Sub Do_Task6
    If flag_Task6 On Then
        Set flag_Task6 Off
        Call Task6
    End If
End Sub
#ENDIF

#IFDEF Task7
Sub Do_Task7
    If flag_Task7 On Then
        Set flag_Task7 Off
        Call Task7
    End If
End Sub
#ENDIF

#IFDEF Task8
Sub Do_Task8
    If flag_Task8 On Then
        Set flag_Task8 Off
        Call Task8
    End If
End Sub
#ENDIF

#IFDEF Task9
Sub Do_Task9
    If flag_Task9 On Then
        Set flag_Task9 Off
        Call Task9
    End If
End Sub
#ENDIF

#IFDEF Task10
Sub Do_Task10
    If flag_Task10 On Then
        Set flag_Task10 Off
        Call Task10
    End If
End Sub
#ENDIF

#IFDEF Task11
Sub Do_Task11
    If flag_Task11 On Then
        Set flag_Task11 Off
        Call Task11
    End If
End Sub
#ENDIF

#IFDEF Task12
Sub Do_Task12
    If flag_Task12 On Then
        Set flag_Task12 Off
        Call Task12
    End If
End Sub
#ENDIF

#IFDEF Task13
Sub Do_Task13
    If flag_Task13 On Then
        Set flag_Task13 Off
        Call Task13
    End If
End Sub
#ENDIF

#IFDEF Task14
Sub Do_Task14
    If flag_Task14 On Then
        Set flag_Task14 Off
        Call Task14
    End If
End Sub
#ENDIF

#IFDEF Task15
Sub Do_Task15
    If flag_Task15 On Then
        Set flag_Task15 Off
        Call Task15
    End If
End Sub
#ENDIF

#IFDEF Task16
Sub Do_Task16
    If flag_Task16 On Then
        Set flag_Task16 Off
        Call Task16
    End If
End Sub
#ENDIF

'--------------------------- LONG TASKs -------------------------

#IFDEF LTask1
Sub Do_LTask1
    If flag_LTask1 On Then
        Set flag_LTask1 Off
        Call LTask1
    End If
End Sub
#ENDIF


#IFDEF LTask2
Sub Do_LTask2
    If flag_LTask2 On Then
        Set flag_LTask2 Off
        Call LTask2
    End If
End Sub
#ENDIF

#IFDEF LTask3
Sub Do_LTask3
    If flag_LTask3 On Then
        Set flag_LTask3 Off
        Call LTask3
    End If
End Sub
#ENDIF

#IFDEF LTask4
Sub Do_LTask4
    If flag_LTask4 On Then
        Set flag_LTask4 Off
        Call LTask4
    End If
End Sub
#ENDIF

#IFDEF LTask5
Sub Do_LTask5
    If flag_LTask5 On Then
        Set flag_LTask5 Off
        Call LTask5
    End If
End Sub
#ENDIF

#IFDEF LTask6
Sub Do_LTask6
    If flag_LTask6 On Then
        Set flag_LTask6 Off
        Call LTask6
    End If
End Sub
#ENDIF

#IFDEF LTask7
Sub Do_LTask7
    If flag_LTask7 On Then
        Set flag_LTask7 Off
        Call LTask7
    End If
End Sub
#ENDIF

#IFDEF LTask8
Sub Do_LTask8
    If flag_LTask8 On Then
        Set flag_LTask8 Off
        Call LTask8
    End If
End Sub
#ENDIF


