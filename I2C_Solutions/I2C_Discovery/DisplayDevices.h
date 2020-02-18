'   FILE:           DisplayDevices.h
'   DATE:           3/11/2017
'   VERSION:        1.1a
'   AUTHOR:         Evan and PeteR
'
'    Description.
'    A support method for GCGB and GCB.
'    Edit this file to add more devices.  This is used by the I2C discovery routines.
'    Supports the hardware and software discovery routines.
'

'    This file is part of the Great Cow Basic compiler.
'
'    This demonstration code is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'    GNU General Public License for more details.
'

Sub DisplayDevices
    Select Case testid

    Case 49
        HSerPrint "DS2482_1Channel_1Wire Master"
    Case 61
        HSerPrint "HMC 5883L 3Axis Compass"
    Case 65
        HSerPrint "Serial_Expander_Device"
    Case 73
        HSerPrint "IC2/Serial_Expander_Device"
    Case 75
        HSerPrint "IC2/Serial_Expander_Device"
    Case 77
        HSerPrint "IC2/Serial_Expander_Device"
    Case 79
        HSerPrint "IC2/Serial_Expander_Device"
    Case 97
        HSerPrint "GCB Slave Device"
    Case 113
        ' can be 113,115,117,119,121,123,125,127
        HSerPrint "PCF8574T IC2/Serial_Expander_Device"
    Case 115
        ' can be 113,115,117,119,121,123,125,127
        HSerPrint "PCF8574T IC2/Serial_Expander_Device"
    Case 127
        ' can be 113,115,117,119,121,123,125,127
        HSerPrint "PCF8574T IC2/Serial_Expander_Device"
    Case 121
        HSerPrint "IC2 OLED Display"
    Case 145
        HSerPrint "Maxim/Dallas device"
    Case 147
        HSerPrint "Maxim/Dallas device"
    Case 149
        HSerPrint "Maxim/Dallas device"
    Case 151
        HSerPrint "Maxim/Dallas device"
    Case 153
        HSerPrint "Maxim/Dallas device"
    Case 155
        HSerPrint "Maxim/Dallas device"
    Case 157
        HSerPrint "Maxim/Dallas device"
    Case 159
        HSerPrint "Maxim/Dallas device"
    Case 161
        HSerPrint "EEProm_Device_Device"
    Case 163
        HSerPrint "EEProm_Device_Device"
    Case 165
        HSerPrint "EEProm_Device_Device"
    Case 167
        HSerPrint "EEProm_Device_Device"
    Case 169
        HSerPrint "EEProm_Device_Device"
    Case 171
        HSerPrint "EEProm_Device_Device"
    Case 173
        HSerPrint "EEProm_Device_Device"
    Case 175
        HSerPrint "EEProm_Device_Device"
    Case 193
        HSerPrint "TEA5767 FM Radio"
    Case 199
        HSerPrint "AXE033 I2C LCD Device"
    Case 209
        HSerPrint "DS1307_RTC_Device"
    Case 223
        HSerPrint "MCP7940x SRAM RTC device"
    Case 237
        HSerPrint "Bosch Sensortec device"
    Case 239
        HSerPrint "Bosch Sensortec device"
    Case 249
        HSerPrint "FRAM_Device"
    Case Else
        HSerPrint "Unknown_Device"
    End Select
End Sub


