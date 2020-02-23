;   FILE:           DisplayDevices.h
;   DATE:           3/11/2017
;   VERSION:        1.1a
;   AUTHOR:         Evan and PeteR
;
;    Description.
'    A support method for GCGB and GCB.
'    Edit this file to add more devices.  This is used by the I2C discovery routines.
'    Supports the hardware and software discovery routines.
'

;    This file is part of the Great Cow Basic compiler.
;
;    This demonstration code is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;

Sub DisplayDevices
  select case testid

      case 49
          Hserprint "DS2482_1Channel_1Wire Master"
      case 61
          Hserprint "HMC 5883L 3Axis Compass"
      case 65
          Hserprint "Serial_Expander_Device"
      case 73
          Hserprint "IC2/Serial_Expander_Device"
      case 75
          Hserprint "IC2/Serial_Expander_Device"
      case 77
          Hserprint "IC2/Serial_Expander_Device"
      case 79
          Hserprint "IC2/Serial_Expander_Device"
      case 97
          Hserprint "GCB Slave Device"
      case 113
          Hserprint "PCF8574T IC2/Serial_Expander_Device"    ' can be 113,115,117,119,121,123,125,127
      case 115
          Hserprint "PCF8574T IC2/Serial_Expander_Device"    ' can be 113,115,117,119,121,123,125,127
      case 127
          Hserprint "PCF8574T IC2/Serial_Expander_Device"    ' can be 113,115,117,119,121,123,125,127
      case 121
          Hserprint "IC2 OLED Display"
      case 145
         Hserprint "Maxim/Dallas device"
      case 147
         Hserprint "Maxim/Dallas device"
      case 149
         Hserprint "Maxim/Dallas device"
      case 151
         Hserprint "Maxim/Dallas device"
      case 153
         Hserprint "Maxim/Dallas device"
      case 155
         Hserprint "Maxim/Dallas device"
      case 157
         Hserprint "Maxim/Dallas device"
      case 159
         Hserprint "Maxim/Dallas device"
      case 161
          Hserprint "EEProm_Device_Device"
      case 163
          Hserprint "EEProm_Device_Device"
      case 165
          Hserprint "EEProm_Device_Device"
      case 167
          Hserprint "EEProm_Device_Device"
      case 169
          Hserprint "EEProm_Device_Device"
      case 171
          Hserprint "EEProm_Device_Device"
      case 173
          Hserprint "EEProm_Device_Device"
      case 175
          Hserprint "EEProm_Device_Device"
      case 193
          HSerPrint "TEA5767 FM Radio"
      case 199
          Hserprint "AXE033 I2C LCD Device"
      case 209
          Hserprint "DS1307_RTC_Device"
      case 223
          Hserprint "MCP7940x SRAM RTC device"
      case 237
          Hserprint "Bosch Sensortec device"
      case 239
          Hserprint "Bosch Sensortec device"
      case 249
          Hserprint "FRAM_Device"
      case else
          Hserprint "Unknown_Device"
  end select
end sub


