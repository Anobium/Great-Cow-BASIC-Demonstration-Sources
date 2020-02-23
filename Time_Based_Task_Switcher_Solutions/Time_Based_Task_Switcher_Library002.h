'_______________________________________________________________________
'
'
'                       Multitasking functions (30-07-2011)
'
'_______________________________________________________________________
'
'
'    multitasking routines for the GCBASIC compiler
'    2009 Santiago Gonzalez
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
'  Notes:
'
'  ¡¡¡¡¡ this library will use Timer0, don'  t use it in your program !!!!!.
'
'  Actually a maximum of 16 Tasks and 8 LTasks are supported.
'
'  The base time must be defined:
'
'      #define base_time value
'
'  where value is the desired value in us, for example:
'
'      #define base_time 100      '  for 100 us

'  For PIC mcus:
'      Maximum base_time value with 20 MHz clock is 13107.
'      Maximum base_time value with 4 MHz clock is 65535.
'      Maximum base_time value with other clocks: 65535/ChipMhz/4.
'
'
'  The subroutine containing each task must be defined:
'
'      #define Task1 Sub_name1
'      #define Task2 Sub_name2
'      #define LTask1 Sub_name3
'
'
'  The period of each Task must be defined:
'
'      #define Task1_us 500            '  Task1 period is 500 us
'      #define Task2_ms 10             '  Task2 period is 10 ms
'      #define LTask1_s 1              '  LTask1 period is 1 s
'
'  In the previous example, Sub_name1 will be executed every 500 us,
'      Sub_name2 every 10 ms and Sub_name3 every 1 S.
'
'  Maximum value for Task period in us is: base_time*255
'
'  For example, with a 100 us base_time,
'      maximum value for Tasks is: 100*255 = 25500 us => 25 ms
'
'  LTask is for long period tasks,
'      a period is long or not depending on the base_time
'      When the needed period > base_time*255 then you need a LTask
'
'  Maximun value for LTask period in us is: base_time*65535
'
'  For example, with a 100 us base_time,
'      maximum value for LTasks is: 100*65535 = 6553500 us => 6553 ms => 6 s
'
'
'  Task will be executed with the command: Do_Taskx,
'  for example  in a main loop:
'
'      do
'          Do_Task2
'          Do_LTask1
'      loop
'
'  or any other way... for example:
'
'      do
'          Do_Task2
'          if PORTB.0 on then Do_LTask1
'      loop
'
'
'  Is possible to execute a Task inside Interrupt subroutine:
'
'      #define Run_Task1               'Run Task inside interrupt subroutine
'________________________________________________________________________
'
'
'-SOFTWARE PWM:
'
'  There are 8 predefined pwm channels.  For use them, prodeed this way:
'
'  Define pwm resolution for all channels (0-255), for example:
'
'      #define pwm_res 20
'
'
'  Define outputs for each used channels:
'
'      #define pwm1_out PORTB.0
'
'
'  Set the duty ( 0 to pwm_res range ):
'
'      pwm1_duty = 10
'
'________________________________________________________________________




#startup Init_Multitask     'Initialisation routine


Sub Init_Multitask
    #ifndef base_time
        #define base_time 1000
    #endif

    #script
        If PIC Then
            'Dim timer0_val as byte

            MipsPic = ChipMHz/4
            TMR0PresPic = 0
            T0TOP_Pic = MipsPic*base_time/2

            if T0TOP_Pic > 255 then
                TMR0PresPic = 1
                T0TOP_Pic = MipsPic*base_time/4
                if T0TOP_Pic > 255 then
                    TMR0PresPic = 2
                    T0TOP_Pic = MipsPic*base_time/8
                    if T0TOP_Pic > 255 then
                        TMR0PresPic = 3
                        T0TOP_Pic = MipsPic*base_time/16
                        if T0TOP_Pic > 255 then
                            TMR0PresPic = 4
                            T0TOP_Pic = MipsPic*base_time/32
                            if T0TOP_Pic > 255 then
                                TMR0PresPic = 5
                                T0TOP_Pic = MipsPic*base_time/64
                                if T0TOP_Pic > 255 then
                                    TMR0PresPic = 6
                                    T0TOP_Pic = MipsPic*base_time/128
                                    if T0TOP_Pic > 255 then
                                        TMR0PresPic = 7
                                        T0TOP_Pic = MipsPic*base_time/256
                                    end if
                                end if
                            end if
                        end if
                    end if
                end if
            end if
            timer0_val = 255 - T0TOP_Pic
      End If

      If AVR Then
            TMR0PresAvr = 1
            T0TOP_Avr = ChipMHz*base_time

            if T0TOP_Avr > 255 then
                TMR0PresAvr = 2
                T0TOP_Avr = ChipMHz*base_time/8
                if T0TOP_Avr > 255 then
                    TMR0PresAvr = 3
                    T0TOP_Avr = ChipMHz*base_time/64
                    if T0TOP_Avr > 255 then
                        TMR0PresAvr = 4
                        T0TOP_Avr = ChipMHz*base_time/256
                        if T0TOP_Avr > 255 then
                            TMR0PresAvr = 5
                            T0TOP_Avr = ChipMHz*base_time/1024
                        end if
                    end if
                end if
            end if
        End If
    #endscript

    #ifdef PIC
        #ifdef var(OPTION_REG)
            OPTION_REG = 192 and OPTION_REG
            OPTION_REG = TMR0PresPic or OPTION_REG
        #endif
        #ifdef var(T0CON)
            T0CON = 192
            T0CON = TMR0PresPic or T0CON
        #endif
        On Interrupt Timer0Overflow Call Interr_Timer0
    #endif

    #ifdef AVR
        #ifdef Var(OCR0)
            OCR0  = T0TOP_Avr
            TCCR0 = 64 + TMR0PresAvr ' CTC mode: TOP = OCR0
        #endif
        #ifdef Var(OCR0A)
            OCR0A  = T0TOP_Avr
            TCCR0A = 2  ' CTC mode: TOP = OCR0A
            TCCR0B = TMR0PresAvr
        #endif
            On Interrupt Timer0Match1 Call Interr_Timer0
    #endif



    #ifdef Task1
        #ifdef Task1_us
            time_Task1 = Task1_us/base_time
        #endif
        #ifdef Task1_ms
            time_Task1 = Task1_ms*1000/base_time
        #endif
        #define flag_Task1 mtsk_flags.0
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
        #define flag_LTask1 Lmtsk_flags.0
    #endif

    call init_rest_of_tasks     'here only Task1 and LTask1 are defined
                                'to show procedure, rest of task are defined
                                'in: Sub init_rest_of_tasks
End Sub


Sub Interr_Timer0

    #ifdef PIC
        TMR0 = TMR0 + timer0_val              'init timer0 counter
    #endif

    #ifdef pwm_res
        dim cont_pwm as byte
        cont_pwm += 1
        if cont_pwm >= pwm_res then cont_pwm = 0

        #ifdef pwm1_out
          dim pwm1_duty as byte

          if cont_pwm >= pwm1_duty then
              pwm1_out = 0
          else
              pwm1_out = 1
          End if
      #endif

      #ifdef pwm2_out
          dim pwm2_duty as byte

          if cont_pwm >= pwm2_duty then
              pwm2_out = 0
          else
              pwm2_out = 1
          End if
      #endif

      #ifdef pwm3_out
          dim pwm3_duty as byte

          if cont_pwm >= pwm3_duty then
              pwm3_out = 0
          else
              pwm3_out = 1
          End if
      #endif

      #ifdef pwm4_out
          dim pwm4_duty as byte

          if cont_pwm >= pwm4_duty then
              pwm4_out = 0
          else
              pwm4_out = 1
          End if
      #endif

      #ifdef pwm5_out
          dim pwm5_duty as byte

          if cont_pwm >= pwm5_duty then
              pwm5_out = 0
          else
              pwm5_out = 1
          End if
      #endif

      #ifdef pwm6_out
          dim pwm6_duty as byte

          if cont_pwm >= pwm6_duty then
              pwm6_out = 0
          else
              pwm6_out = 1
          End if
      #endif

      #ifdef pwm7_out
          dim pwm7_duty as byte

          if cont_pwm >= pwm7_duty then
              pwm7_out = 0
          else
              pwm7_out = 1
          End if
      #endif

      #ifdef pwm8_out
          dim pwm8_duty as byte

          if cont_pwm >= pwm8_duty then
              pwm8_out = 0
          else
              pwm8_out = 1
          End if
      #endif

      #ifdef pwm9_out
          dim pwm9_duty as byte

          if cont_pwm >= pwm9_duty then
              pwm9_out = 0
          else
              pwm9_out = 1
          End if
      #endif

  #endif

    #ifdef Task1
        cont_Task1 += 1                   'increment task counter
        if cont_Task1 >= time_Task1 then   'if task time reached
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
        if cont_Task9 >= time_Task9 then   'if task time reached
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
        dim time_LTask1 as word
        dim cont_LTask1 as word

        cont_LTask1 += 1               'increment LTask counter
      if cont_LTask1 >= time_LTask1 then
            cont_LTask1 = 0
            flag_LTask1 = 1
        End if
        #ifdef Run_LTask1
            Do_LTask1
        #endif
    #endif

    #ifdef LTask2
        dim time_LTask2 as word
        dim cont_LTask2 as word

        cont_LTask2 += 1
      if cont_LTask2 >= time_LTask2 then
            cont_LTask2 = 0
            flag_LTask2 = 1
        End if
        #ifdef Run_LTask2
            Do_LTask2
        #endif
    #endif

    #ifdef LTask3
        dim time_LTask3 as word
        dim cont_LTask3 as word

        cont_LTask3 += 1
      if cont_LTask3 >= time_LTask3 then
            cont_LTask3 = 0
            flag_LTask3 = 1
        End if
        #ifdef Run_LTask3
            Do_LTask3
        #endif
    #endif

    #ifdef LTask4
        dim time_LTask4 as word
        dim cont_LTask4 as word

        cont_LTask4 += 1
      if cont_LTask4 >= time_LTask4 then
            cont_LTask4 = 0
            flag_LTask4 = 1
        End if
        #ifdef Run_LTask4
            Do_LTask4
        #endif
    #endif

    #ifdef LTask5
        dim time_LTask5 as word
        dim cont_LTask5 as word

        cont_LTask5 += 1
      if cont_LTask5 >= time_LTask5 then
            cont_LTask5 = 0
            flag_LTask5 = 1
        End if
        #ifdef Run_LTask5
            Do_LTask5
        #endif
    #endif

    #ifdef LTask6
        dim time_LTask6 as word
        dim cont_LTask6 as word

        cont_LTask6 += 1
      if cont_LTask6 >= time_LTask6 then
            cont_LTask6 = 0
            flag_LTask6 = 1
        End if
        #ifdef Run_LTask6
            Do_LTask6
        #endif
    #endif

    #ifdef LTask7
        dim time_LTask7 as word
        dim cont_LTask7 as word

        cont_LTask7 += 1
      if cont_LTask7 >= time_LTask7 then
            cont_LTask7 = 0
            flag_LTask7 = 1
        End if
        #ifdef Run_LTask7
            Do_LTask7
        #endif
    #endif

    #ifdef LTask8
        dim time_LTask8 as word
        dim cont_LTask8 as word

        cont_LTask8 += 1
      if cont_LTask8 >= time_LTask8 then
            cont_LTask8 = 0
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
        #define flag_Task2 mtsk_flags.1
    #endif

    #ifdef Task3
        #ifdef Task3_us
            time_Task3 = Task3_us/base_time
        #endif
        #ifdef Task3_ms
            time_Task3 = Task3_ms*1000/base_time
        #endif
        #define flag_Task3 mtsk_flags.2
    #endif

    #ifdef Task4
        #ifdef Task4_us
            time_Task4 = Task4_us/base_time
        #endif
        #ifdef Task4_ms
            time_Task4 = Task4_ms*1000/base_time
        #endif
        #define flag_Task4 mtsk_flags.3
    #endif

    #ifdef Task5
        #ifdef Task5_us
            time_Task5 = Task5_us/base_time
        #endif
        #ifdef Task5_ms
            time_Task5 = Task5_ms*1000/base_time
        #endif
        #define flag_Task5 mtsk_flags.4
    #endif

    #ifdef Task6
        #ifdef Task6_us
            time_Task6 = Task6_us/base_time
        #endif
        #ifdef Task6_ms
            time_Task6 = Task6_ms*1000/base_time
        #endif
        #define flag_Task6 mtsk_flags.5
    #endif

    #ifdef Task7
        #ifdef Task7_us
            time_Task7 = Task7_us/base_time
        #endif
        #ifdef Task7_ms
            time_Task7 = Task7_ms*1000/base_time
        #endif
        #define flag_Task7 mtsk_flags.6
    #endif

    #ifdef Task8
        #ifdef Task8_us
            time_Task8 = Task8_us/base_time
        #endif
        #ifdef Task8_ms
            time_Task8 = Task8_ms*1000/base_time
        #endif
        #define flag_Task8 mtsk_flags.7
    #endif

    #ifdef Task9
        #ifdef Task9_us
            time_Task9 = Task9_us/base_time
        #endif
        #ifdef Task9_ms
            time_Task9 = Task9_ms*1000/base_time
        #endif
        #define flag_Task9 mtsk_flags_H.0
    #endif

    #ifdef Task10
        #ifdef Task10_us
            time_Task10 = Task10_us/base_time
        #endif
        #ifdef Task10_ms
            time_Task10 = Task10_ms*1000/base_time
        #endif
        #define flag_Task10 mtsk_flags_H.1
    #endif

    #ifdef Task11
        #ifdef Task11_us
            time_Task11 = Task11_us/base_time
        #endif
        #ifdef Task11_ms
            time_Task11 = Task11_ms*1000/base_time
        #endif
        #define flag_Task11 mtsk_flags_H.2
    #endif

    #ifdef Task12
        #ifdef Task12_us
            time_Task12 = Task12_us/base_time
        #endif
        #ifdef Task12_ms
            time_Task12 = Task12_ms*1000/base_time
        #endif
        #define flag_Task12 mtsk_flags_H.3
    #endif

    #ifdef Task13
        #ifdef Task13_us
            time_Task13 = Task13_us/base_time
        #endif
        #ifdef Task13_ms
            time_Task13 = Task13_ms*1000/base_time
        #endif
        #define flag_Task13 mtsk_flags_H.4
    #endif

    #ifdef Task14
        #ifdef Task14_us
            time_Task14 = Task14_us/base_time
        #endif
        #ifdef Task14_ms
            time_Task14 = Task14_ms*1000/base_time
        #endif
        #define flag_Task14 mtsk_flags_H.5
    #endif

    #ifdef Task15
        #ifdef Task15_us
            time_Task15 = Task15_us/base_time
        #endif
        #ifdef Task15_ms
            time_Task15 = Task15_ms*1000/base_time
        #endif
        #define flag_Task15 mtsk_flags_H.6
    #endif

    #ifdef Task16
        #ifdef Task16_us
            time_Task16 = Task16_us/base_time
        #endif
        #ifdef Task16_ms
            time_Task16 = Task16_ms*1000/base_time
        #endif
        #define flag_Task16 mtsk_flags_H.7
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
        #define flag_LTask2 Lmtsk_flags.1
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
        #define flag_LTask3 Lmtsk_flags.2
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
        #define flag_LTask4 Lmtsk_flags.3
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
        #define flag_LTask5 Lmtsk_flags.4
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
        #define flag_LTask6 Lmtsk_flags.5
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
        #define flag_LTask7 Lmtsk_flags.6
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
        #define flag_LTask8 Lmtsk_flags.7
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



