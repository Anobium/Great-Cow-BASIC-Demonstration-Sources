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
#startup Init_Multitask


Sub Init_Multitask

    dim flags as word                   '2 bytes for 16 flags
    dim value_tmr0 as byte

    flags = ChipMhz/4 * base_time       'use flags variable as temporary register

    if flags_H = 0 then                 'calculate prescaler and initial timer0 counter
      TimerInitValue = 8

    else
      TimerInitValue = 0

      do while flags_H <> 0
        flags = flags / 2
        TimerInitValue++
      loop
      TimerInitValue++

    End if
    value_tmr0 = 0
    value_tmr0 = value_tmr0 - flags
    flags = 0

    StartTimer 0

    ' Set the Timer start value
    SetTimer ( 0, value_tmr0 )


    #ifdef Task1
        #ifdef Task1_us
            time_Task1 = Task1_us/base_time
        #endif
        #ifdef Task1_ms
            time_Task1 = Task1_ms*1000/base_time
        #endif
        #define flag_Task1 flags.0
    #endif

    #ifdef LTask1
        dim time_LTask1 as word
        dim cont_LTask1 as word
        #ifdef LTask1_us
            time_LTask1 = LTask1_us/base_time
        #endif
        #ifdef LTask1_ms
            time_LTask1 = LTask1_ms*1000/base_time
        #endif
        #ifdef LTask1_s
            time_LTask1 = LTask1_s*1000000/base_time
        #endif
        #define flag_LTask1 Lflags.0
    #endif

    call init_rest_of_tasks     'here only Task1 and LTask1 are defined
                                'to show procedure, rest of task are defined
                                'in: Sub init_rest_of_tasks

    On Interrupt Timer0Overflow Call Interr_Timer0

End Sub


Sub Interr_Timer0
     TMR0IF = 0

    ' Set the Timer start value
    SetTimer ( 0, TMR0 + value_tmr0 )

    #ifdef Task1
        cont_Task1 += 1                   'increment task counter
        if cont_Task1 >= time_Task1 then  'if task time reached
            cont_Task1 = 0                'restart counter
            flag_Task1 = 1                'set task flag
        End if
        #ifdef Run_Task1
            Do_Task1
        #endif
    #endif

    #ifdef Task2
        cont_Task2 += 1
        if cont_Task2 >= time_Task2 then
            cont_Task2 = 0
            flag_Task2 = 1
        End if
        #ifdef Run_Task2
            Do_Task2
        #endif
    #endif

    #ifdef Task3
        cont_Task3 += 1
        if cont_Task3 >= time_Task3 then
            cont_Task3 = 0
            flag_Task3 = 1
        End if
        #ifdef Run_Task3
            Do_Task3
        #endif
    #endif

    #ifdef Task4
        cont_Task4 += 1
        if cont_Task4 >= time_Task4 then
            cont_Task4 = 0
            flag_Task4 = 1
        End if
        #ifdef Run_Task4
            Do_Task4
        #endif
    #endif

    #ifdef Task5
        cont_Task5 += 1
        if cont_Task5 >= time_Task5 then
            cont_Task5 = 0
            flag_Task5 = 1
        End if
        #ifdef Run_Task5
            Do_Task5
        #endif
    #endif

    #ifdef Task6
        cont_Task6 += 1
        if cont_Task6 >= time_Task6 then
            cont_Task6 = 0
            flag_Task6 = 1
        End if
        #ifdef Run_Task6
            Do_Task6
        #endif
    #endif

    #ifdef Task7
        cont_Task7 += 1
        if cont_Task7 >= time_Task7 then
            cont_Task7 = 0
            flag_Task7 = 1
        End if
        #ifdef Run_Task7
            Do_Task7
        #endif
    #endif

    #ifdef Task8
        cont_Task8 += 1
        if cont_Task8 >= time_Task8 then
            cont_Task8 = 0
            flag_Task8 = 1
        End if
        #ifdef Run_Task8
            Do_Task8
        #endif
    #endif

    #ifdef Task9
        cont_Task9 += 1                   'increment task counter
        if cont_Task9 >= time_Task9 then  'if task time reached
            cont_Task9 = 0                'restart counter
            flag_Task9 = 1                'set task flag
        End if
        #ifdef Run_Task9
            Do_Task9
        #endif
    #endif

    #ifdef Task10
        cont_Task10 += 1
        if cont_Task10 >= time_Task10 then
            cont_Task10 = 0
            flag_Task10 = 1
        End if
        #ifdef Run_Task10
            Do_Task10
        #endif
    #endif

    #ifdef Task11
        cont_Task11 += 1
        if cont_Task11 >= time_Task11 then
            cont_Task11 = 0
            flag_Task11 = 1
        End if
        #ifdef Run_Task11
            Do_Task11
        #endif
    #endif

    #ifdef Task12
        cont_Task12 += 1
        if cont_Task12 >= time_Task12 then
            cont_Task12 = 0
            flag_Task12 = 1
        End if
        #ifdef Run_Task12
            Do_Task12
        #endif
    #endif

    #ifdef Task13
        cont_Task13 += 1
        if cont_Task13 >= time_Task13 then
            cont_Task13 = 0
            flag_Task13 = 1
        End if
        #ifdef Run_Task13
            Do_Task13
        #endif
    #endif

    #ifdef Task14
        cont_Task14 += 1
        if cont_Task14 >= time_Task14 then
            cont_Task14 = 0
            flag_Task14 = 1
        End if
        #ifdef Run_Task14
            Do_Task14
        #endif
    #endif

    #ifdef Task15
        cont_Task15 += 1
        if cont_Task15 >= time_Task15 then
            cont_Task15 = 0
            flag_Task15 = 1
        End if
        #ifdef Run_Task15
            Do_Task15
        #endif
    #endif

    #ifdef Task16
        cont_Task16 += 1
        if cont_Task16 >= time_Task16 then
            cont_Task16 = 0
            flag_Task16 = 1
        End if
        #ifdef Run_Task16
            Do_Task16
        #endif
    #endif

    '--------------------------- LONG TASKs -------------------------

    #ifdef LTask1
        movlw 1
        addwf   cont_LTask1,F               'increment LTask counter
      movlw 0
      btfsc STATUS,C
      addlw 1
      addwf cont_LTask1_H,F
        SysCalcTempB_H = CONT_LTASK1_H
        SysCalcTempB = CONT_LTASK1
        SysCalcTempA_H = TIME_LTASK1_H
        SysCalcTempA = TIME_LTASK1
      call SysCompLessThan
        if SysCalcTempX.0 on  then          'if LTask time reached
            cont_LTask1 = 0                 'restart counter
            cont_LTask1_H = 0
            flag_LTask1 = 1                 'set LTask flag
        End if
        #ifdef Run_LTask1
            Do_LTask1
        #endif
    #endif

    #ifdef LTask2
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
      call SysCompLessThan
        if SysCalcTempX.0 on  then
            cont_LTask2 = 0
            cont_LTask2_H = 0
            flag_LTask2 = 1
        End if
        #ifdef Run_LTask2
            Do_LTask2
        #endif
    #endif

    #ifdef LTask3
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
      call SysCompLessThan
        if SysCalcTempX.0 on  then
            cont_LTask3 = 0
            cont_LTask3_H = 0
            flag_LTask3 = 1
        End if
        #ifdef Run_LTask3
            Do_LTask3
        #endif
    #endif

    #ifdef LTask4
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
      call SysCompLessThan
        if SysCalcTempX.0 on  then
            cont_LTask4 = 0
            cont_LTask4_H = 0
            flag_LTask4 = 1
        End if
        #ifdef Run_LTask4
            Do_LTask4
        #endif
    #endif

    #ifdef LTask5
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
      call SysCompLessThan
        if SysCalcTempX.0 on  then
            cont_LTask5 = 0
            cont_LTask5_H = 0
            flag_LTask5 = 1
        End if
        #ifdef Run_LTask5
            Do_LTask5
        #endif
    #endif

    #ifdef LTask6
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
      call SysCompLessThan
        if SysCalcTempX.0 on  then
            cont_LTask6 = 0
            cont_LTask6_H = 0
            flag_LTask6 = 1
        End if
        #ifdef Run_LTask6
            Do_LTask6
        #endif
    #endif

    #ifdef LTask7
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
      call SysCompLessThan
        if SysCalcTempX.0 on  then
            cont_LTask7 = 0
            cont_LTask7_H = 0
            flag_LTask7 = 1
        End if
        #ifdef Run_LTask7
            Do_LTask7
        #endif
    #endif

    #ifdef LTask8
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
      call SysCompLessThan
        if SysCalcTempX.0 on  then
            cont_LTask8 = 0
            cont_LTask8_H = 0
            flag_LTask8 = 1
        End if
        #ifdef Run_LTask8
            Do_LTask8
        #endif
    #endif
End Sub

Sub init_rest_of_tasks          'Calculate ticks value from time value
    #ifdef Task2
        #ifdef Task2_us
            time_Task2 = Task2_us/base_time
        #endif
        #ifdef Task2_ms
            time_Task2 = Task2_ms*1000/base_time
        #endif
        #define flag_Task2 flags.1
    #endif

    #ifdef Task3
        #ifdef Task3_us
            time_Task3 = Task3_us/base_time
        #endif
        #ifdef Task3_ms
            time_Task3 = Task3_ms*1000/base_time
        #endif
        #define flag_Task3 flags.2
    #endif

    #ifdef Task4
        #ifdef Task4_us
            time_Task4 = Task4_us/base_time
        #endif
        #ifdef Task4_ms
            time_Task4 = Task4_ms*1000/base_time
        #endif
        #define flag_Task4 flags.3
    #endif

    #ifdef Task5
        #ifdef Task5_us
            time_Task5 = Task5_us/base_time
        #endif
        #ifdef Task5_ms
            time_Task5 = Task5_ms*1000/base_time
        #endif
        #define flag_Task5 flags.4
    #endif

    #ifdef Task6
        #ifdef Task6_us
            time_Task6 = Task6_us/base_time
        #endif
        #ifdef Task6_ms
            time_Task6 = Task6_ms*1000/base_time
        #endif
        #define flag_Task6 flags.5
    #endif

    #ifdef Task7
        #ifdef Task7_us
            time_Task7 = Task7_us/base_time
        #endif
        #ifdef Task7_ms
            time_Task7 = Task7_ms*1000/base_time
        #endif
        #define flag_Task7 flags.6
    #endif

    #ifdef Task8
        #ifdef Task8_us
            time_Task8 = Task8_us/base_time
        #endif
        #ifdef Task8_ms
            time_Task8 = Task8_ms*1000/base_time
        #endif
        #define flag_Task8 flags.7
    #endif

    #ifdef Task9
        #ifdef Task9_us
            time_Task9 = Task9_us/base_time
        #endif
        #ifdef Task9_ms
            time_Task9 = Task9_ms*1000/base_time
        #endif
        #define flag_Task9 flags_H.0
    #endif

    #ifdef Task10
        #ifdef Task10_us
            time_Task10 = Task10_us/base_time
        #endif
        #ifdef Task10_ms
            time_Task10 = Task10_ms*1000/base_time
        #endif
        #define flag_Task10 flags_H.1
    #endif

    #ifdef Task11
        #ifdef Task11_us
            time_Task11 = Task11_us/base_time
        #endif
        #ifdef Task11_ms
            time_Task11 = Task11_ms*1000/base_time
        #endif
        #define flag_Task11 flags_H.2
    #endif

    #ifdef Task12
        #ifdef Task12_us
            time_Task12 = Task12_us/base_time
        #endif
        #ifdef Task12_ms
            time_Task12 = Task12_ms*1000/base_time
        #endif
        #define flag_Task12 flags_H.3
    #endif

    #ifdef Task13
        #ifdef Task13_us
            time_Task13 = Task13_us/base_time
        #endif
        #ifdef Task13_ms
            time_Task13 = Task13_ms*1000/base_time
        #endif
        #define flag_Task13 flags_H.4
    #endif

    #ifdef Task14
        #ifdef Task14_us
            time_Task14 = Task14_us/base_time
        #endif
        #ifdef Task14_ms
            time_Task14 = Task14_ms*1000/base_time
        #endif
        #define flag_Task14 flags_H.5
    #endif

    #ifdef Task15
        #ifdef Task15_us
            time_Task15 = Task15_us/base_time
        #endif
        #ifdef Task15_ms
            time_Task15 = Task15_ms*1000/base_time
        #endif
        #define flag_Task15 flags_H.6
    #endif

    #ifdef Task16
        #ifdef Task16_us
            time_Task16 = Task16_us/base_time
        #endif
        #ifdef Task16_ms
            time_Task16 = Task16_ms*1000/base_time
        #endif
        #define flag_Task16 flags_H.7
    #endif

    '--------------------------- LONG TASKs -------------------------


    #ifdef LTask2
        dim time_LTask2 as word
        dim cont_LTask2 as word
        #ifdef LTask2_us
            time_LTask2 = LTask2_us/base_time
        #endif
        #ifdef LTask2_ms
            time_LTask2 = LTask2_ms*1000/base_time
        #endif
        #ifdef LTask2_s
            time_LTask2 = LTask2_s*1000000/base_time
        #endif
        #define flag_LTask2 Lflags.1
    #endif

    #ifdef LTask3
        dim time_LTask3 as word
        dim cont_LTask3 as word
        #ifdef LTask3_us
            time_LTask3 = LTask3_us/base_time
        #endif
        #ifdef LTask3_ms
            time_LTask3 = LTask3_ms*1000/base_time
        #endif
        #ifdef LTask3_s
            time_LTask3 = LTask3_s*1000000/base_time
        #endif
        #define flag_LTask3 Lflags.2
    #endif

    #ifdef LTask4
        dim time_LTask4 as word
        dim cont_LTask4 as word
        #ifdef LTask4_us
            time_LTask4 = LTask4_us/base_time
        #endif
        #ifdef LTask4_ms
            time_LTask4 = LTask4_ms*1000/base_time
        #endif
        #ifdef LTask4_s
            time_LTask4 = LTask4_s*1000000/base_time
        #endif
        #define flag_LTask4 Lflags.3
    #endif

    #ifdef LTask5
        dim time_LTask5 as word
        dim cont_LTask5 as word
        #ifdef LTask5_us
            time_LTask5 = LTask5_us/base_time
        #endif
        #ifdef LTask5_ms
            time_LTask5 = LTask5_ms*1000/base_time
        #endif
        #ifdef LTask5_s
            time_LTask5 = LTask5_s*1000000/base_time
        #endif
        #define flag_LTask5 Lflags.4
    #endif

    #ifdef LTask6
        dim time_LTask6 as word
        dim cont_LTask6 as word
        #ifdef LTask6_us
            time_LTask6 = LTask6_us/base_time
        #endif
        #ifdef LTask6_ms
            time_LTask6 = LTask6_ms*1000/base_time
        #endif
        #ifdef LTask6_s
            time_LTask6 = LTask6_s*1000000/base_time
        #endif
        #define flag_LTask6 Lflags.5
    #endif

    #ifdef LTask7
        dim time_LTask7 as word
        dim cont_LTask7 as word
        #ifdef LTask7_us
            time_LTask7 = LTask7_us/base_time
        #endif
        #ifdef LTask7_ms
            time_LTask7 = LTask7_ms*1000/base_time
        #endif
        #ifdef LTask7_s
            time_LTask7 = LTask7_s*1000000/base_time
        #endif
        #define flag_LTask7 Lflags.6
    #endif

    #ifdef LTask8
        dim time_LTask8 as word
        dim cont_LTask8 as word
        #ifdef LTask8_us
            time_LTask8 = LTask8_us/base_time
        #endif
        #ifdef LTask8_ms
            time_LTask8 = LTask8_ms*1000/base_time
        #endif
        #ifdef LTask8_s
            time_LTask8 = LTask8_s*1000000/base_time
        #endif
        #define flag_LTask8 Lflags.7
    #endif
End Sub


#ifdef Task1
    Sub Do_Task1
        if flag_Task1 on then
            set flag_Task1 off
            call Task1
        End if
    End Sub
#endif

#ifdef Task2
    Sub Do_Task2
        if flag_Task2 on then
            set flag_Task2 off
            call Task2
        End if
    End Sub
#endif

#ifdef Task3
    Sub Do_Task3
        if flag_Task3 on then
            set flag_Task3 off
            call Task3
        End if
    End Sub
#endif

#ifdef Task4
    Sub Do_Task4
        if flag_Task4 on then
            set flag_Task4 off
            call Task4
        End if
    End Sub
#endif

#ifdef Task5
    Sub Do_Task5
        if flag_Task5 on then
            set flag_Task5 off
            call Task5
        End if
    End Sub
#endif

#ifdef Task6
    Sub Do_Task6
        if flag_Task6 on then
            set flag_Task6 off
            call Task6
        End if
    End Sub
#endif

#ifdef Task7
    Sub Do_Task7
        if flag_Task7 on then
            set flag_Task7 off
            call Task7
        End if
    End Sub
#endif

#ifdef Task8
    Sub Do_Task8
        if flag_Task8 on then
            set flag_Task8 off
            call Task8
        End if
    End Sub
#endif

#ifdef Task9
    Sub Do_Task9
        if flag_Task9 on then
            set flag_Task9 off
            call Task9
        End if
    End Sub
#endif

#ifdef Task10
    Sub Do_Task10
        if flag_Task10 on then
            set flag_Task10 off
            call Task10
        End if
    End Sub
#endif

#ifdef Task11
    Sub Do_Task11
        if flag_Task11 on then
            set flag_Task11 off
            call Task11
        End if
    End Sub
#endif

#ifdef Task12
    Sub Do_Task12
        if flag_Task12 on then
            set flag_Task12 off
            call Task12
        End if
    End Sub
#endif

#ifdef Task13
    Sub Do_Task13
        if flag_Task13 on then
            set flag_Task13 off
            call Task13
        End if
    End Sub
#endif

#ifdef Task14
    Sub Do_Task14
        if flag_Task14 on then
            set flag_Task14 off
            call Task14
        End if
    End Sub
#endif

#ifdef Task15
    Sub Do_Task15
        if flag_Task15 on then
            set flag_Task15 off
            call Task15
        End if
    End Sub
#endif

#ifdef Task16
    Sub Do_Task16
        if flag_Task16 on then
            set flag_Task16 off
            call Task16
        End if
    End Sub
#endif

    '--------------------------- LONG TASKs -------------------------

#ifdef LTask1
    Sub Do_LTask1
        if flag_LTask1 on then
            set flag_LTask1 off
            call LTask1
        End if
    End Sub
#endif


#ifdef LTask2
    Sub Do_LTask2
        if flag_LTask2 on then
            set flag_LTask2 off
            call LTask2
        End if
    End Sub
#endif

#ifdef LTask3
    Sub Do_LTask3
        if flag_LTask3 on then
            set flag_LTask3 off
            call LTask3
        End if
    End Sub
#endif

#ifdef LTask4
    Sub Do_LTask4
        if flag_LTask4 on then
            set flag_LTask4 off
            call LTask4
        End if
    End Sub
#endif

#ifdef LTask5
    Sub Do_LTask5
        if flag_LTask5 on then
            set flag_LTask5 off
            call LTask5
        End if
    End Sub
#endif

#ifdef LTask6
    Sub Do_LTask6
        if flag_LTask6 on then
            set flag_LTask6 off
            call LTask6
        End if
    End Sub
#endif

#ifdef LTask7
    Sub Do_LTask7
        if flag_LTask7 on then
            set flag_LTask7 off
            call LTask7
        End if
    End Sub
#endif

#ifdef LTask8
    Sub Do_LTask8
        if flag_LTask8 on then
            set flag_LTask8 off
            call LTask8
        End if
    End Sub
#endif


