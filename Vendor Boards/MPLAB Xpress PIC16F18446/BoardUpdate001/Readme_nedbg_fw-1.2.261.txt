Upgrade procedure:
1. Install Atmel Studio:
http://www.microchip.com/mplab/avr-support/atmel-studio-7

2. Use the command line tool atfw.exe bundled with Atmel Studio to upgrade the firmware:

atfw.exe -t nedbg -a nedbg_fw-1.2.261.zip

Default location for atfw.exe:
C:\Program Files (x86)\Atmel\Studio\7.0\atbackend\atfw.exe

3. unplug / re-plug (power toggle) the board
