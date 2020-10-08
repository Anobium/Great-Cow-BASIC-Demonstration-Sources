'    Library to allow the Arduino Duemilanove (mega328) to work with GCBASIC
'    Copyright (C) 2010-2020 Hugh Considine

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


#chip lgt8fx8p, 32

'Startup routine
#startup lgt8fx8p, 90

'A/D speed
'Need to slow down due to high clock speed
#define ADSpeed LowSpeed

'Analog inputs
'Analog 0 to 5 = AN0 to AN5 in GCBASIC
#define ANALOG_0 PORTC.0
#define ANALOG_1 PORTC.1
#define ANALOG_2 PORTC.2
#define ANALOG_3 PORTC.3
#define ANALOG_4 PORTC.4
#define ANALOG_5 PORTC.5
#define RESET portc.6

'Digital pins
#define DIGITAL_0 PORTD.0
#define DIGITAL_1 PORTD.1
#define DIGITAL_2 PORTD.2
#define DIGITAL_3 PORTD.3
#define DIGITAL_4 PORTD.4

#define DIGITAL_5 PORTD.5
#define DIGITAL_6 PORTD.6
#define DIGITAL_7 PORTD.7
#define DIGITAL_8 PORTB.0

#define DIGITAL_9 PORTB.1
#define DIGITAL_10 PORTB.2
#define DIGITAL_11 PORTB.3
#define DIGITAL_12 PORTB.4
#define DIGITAL_13 PORTB.5
#define DIGITAL_14 PORTB.6
#define DIGITAL_15 PORTB.6

#define DIGITAL_16 PORTE.0
#define DIGITAL_17 PORTE.1
#define DIGITAL_18 PORTE.2
#define DIGITAL_19 PORTE.3
#define DIGITAL_20 PORTE.4
#define DIGITAL_21 PORTE.5
#define DIGITAL_22 PORTE.6




'''@hide
Sub lgt8fx8p
  'Set UART pin directions
  Dir PORTD.0 In
  Dir PORTD.1 Out
End Sub
