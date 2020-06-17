'    Library to allow the TINYAVRrc  to work with the Great Cow BASOC
'    Copyright (C) 2020 Evan R. Venn

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


'Dim TCNT0 as word alias TCNT0H, TCNT0L
'Dim OCR0A as word alias OCR0AH, OCR0AL
'Dim OCR0B as word alias OCR0BH, OCR0BL
'Dim ICR0 as  word alias ICR0H,  ICR0L

#IF ChipFamily 121
  TINYAVRrc_Init
#ENDIF
'Sub to resolve oscillator
#startup TINYAVRrc_Init
Sub TINYAVRrc_Init
      'As Great Cow BASIC does not set the AVR frequency per chipfamily - set here.
      'Unlock the  frequency register where 0xD8 is the correct signature for the AVRrc chips
      CCP = 0xD8            'signature to CCP
      CLKMSR = 0            'use clock 00: Calibrated Internal 8 MHzOscillator
      CCP = 0xD8
      #IFDEF ChipMHz 8
        CLKPSR = 0
      #ENDIF
      #IFDEF ChipMHz 4
        CLKPSR = 1
      #ENDIF
      #IFDEF ChipMHz 2
        CLKPSR = 2
      #ENDIF
      #IFDEF ChipMHz 1
        CLKPSR = 3
      #ENDIF
      #IFDEF ChipMHz 0.5
        CLKPSR = 4
      #ENDIF
      #IFDEF ChipMHz 0.25
        CLKPSR = 5
      #ENDIF
      #IFDEF ChipMHz 0.125
        CLKPSR = 6
      #ENDIF
      #IFDEF ChipMHz 0.0625
        CLKPSR = 7
      #ENDIF
      #IFDEF ChipMHz 0.03125
        CLKPSR = 8
      #ENDIF
End Sub


;********************************************************************************

macro TinyAVRrcContextRestore
  ;Restore registers
    lds r17,SaveSysTemp2
  ;Restore SREG
    lds r21,SaveSREG
    out SREG,r21
  ;Restore SysValueCopy
    lds r21,SaveSysValueCopy
End macro

;********************************************************************************

macro TinyAVRrcContextSave
  ;Store SysValueCopy
    sts SaveSysValueCopy,r21
  ;Store SREG
    in r21,SREG
    sts SaveSREG,r21
  ;Store registers
    sts SaveSysTemp2,r17
End macro

;********************************************************************************
