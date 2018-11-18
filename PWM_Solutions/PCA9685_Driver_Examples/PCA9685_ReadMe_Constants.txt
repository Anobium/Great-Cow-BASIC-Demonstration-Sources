; Solution Specific constants can be replaced by user constants

    #define PCA9685_ADDRESS_1 0x80
    '#define PCA9685_ADDRESS_2 0x82
    '#define PCA9685_ADDRESS_3 0x84
    '#define PCA9685_ADDRESS_4 0x86


    ' Set the frequency using the Great Cow BASIC PWM constant
    #define PWM_Freq 38
    '  Range is 24-1526
      '#define PWM_Freq 1526
      '#define PWM_Freq 24


' Public methods

'    PCA9685_SetFreqency ( frequency_wordvalue[, I2C_Device_Address] ) a value from 24 to 1526
'    PCA9685_SetPrescaler ( byte_value[, I2C_Device_Address])
'    PCA9685_SetChannelDuty(  channel as byte , duty as word[, I2C_Device_Address] )  where duty is 0 to 100%
'    PCA9685_SetChannelOnOnly ( channel as byte , OnValue as word[, I2C_Device_Address] ) where Onvalue is 0 to 4095
'    PCA9685_SetChannelOffOnly ( channel as byte , OffValue as word[, I2C_Device_Address] ) where Offvalue is 0 to 4095
'    PCA9685_WriteChannel( channel as byte, OnValue as word, OffValue  as word[, I2C_Device_Address] ) ranges of 0 to 4095

'      PCA9685_EnableServoMode
'      PCA9685_SetServoAnglePulseLimits
'      PCA9685_GetServoAnglePulseLimits
'      PCA9685_SetServoAngleLimits
'      PCA9685_GetServoAngleLimits
'      PCA9685_SetChannelAngle

' Key Constants
'        PCA9685_ADDRESS_1  device address
'        PWM_DUTY           default pwm

'        PCA9685_ALL_CHANNELS   address all channels
'        PCA9685_LED0, PCA9685_LED1 etc to PCA9685_LED15   address a specific channel
'        PCA9685_LED_ON                                    set channel on
'        PCA9685_LED_OFF                                   set channel off
'        PCA9685_INTERNAL_CLOCK_FREQUENCY                  set to 25000000 change if you use an external clock
'

    ' Let's make a big long hideous list of all the register names and pin names!

     #define PCA9685_MODE1         0x00
     #define PCA9685_RESTART       0x80 ' Has something to do with sleep mode. I don't
                                '  really get it.
     #define PCA9685_EXTCLK        0x40 ' Write to '1' to disable internal clock. Cannot
                                '  be reset to '0' without power cycle or reset.
     #define PCA9685_AI            0x20 ' Set to '1' to enable autoincrement register
                                '  during write operations. Defaults to '0'.
     #define PCA9685_SLEEP         0x10 ' Set to '0' to leave sleep and enable internal
                                '  oscillator. Defaults to '1' on boot.
     #define PCA9685_SUB1          0x08 ' Set to '1' to allow part to respond to address
     #define PCA9685_SUB2          0x04 '  in SUBADRx registers. Defaults to '0'.
     #define PCA9685_SUB3          0x02
     #define PCA9685_ALLCALL       0x01 ' Set to '1' to allow part to respond to address
                                '  in ALLCALL register. Defaults to '1'.

     #define PCA9685_MODE2         0x01
     #define PCA9685_INVRT         0x10 ' Write to '1' to invert output (i.e., a when the
                                '  pin is ON, the output will be low, or the
                                '  open-drain transistor will be off).
     #define PCA9685_OCH           0x08 ' '0' (default) is update PWM behavior on I2C STOP
                                ' '1' is update on I2C ACK
     #define PCA9685_OUTDRV        0x04 ' '0' is open-drain mode, '1' (default) is
                                '  totem-pole drive.
     #define PCA9685_OUTNE1        0x02 ' These bits affect behavior when OE is high and
     #define PCA9685_OUTNE0        0x01 '  the outputs are disabled.
                                ' 00 - Output is '0'
                                ' 01 - Output is '1' in totem-pole mode
                                '      Output is Hi-z in open drain mode
                                ' 1x - Output is Hi-z

    ' The SUBADR registers allow you to set a second (or third, or fourth) I2C
    ' address that the PCA9685 will respond to. Thus, you can set up multiple
    ' "subnets" on the I2C bus. These power up to 0xe2, 0xe4 and 0xe6, but can't
    ' be used until the SUBx bits in MODE1 are set.
    #define PCA9685_SUBADR1       0x02

    #define PCA9685_SUBADR2       0x03

    #define PCA9685_SUBADR3       0x04

    ' This register powers up with a value of 0xE0, allowing the user to access
    ' *all* PCA9685 devices on the bus by writing to address 0x70. This function
    ' is enabled by default, but can be disabled by clearing the ALLCALL bit in
    ' MODE1.
    #define PCA9685_ALLCALLADR    0x05

    ' Each channel has two 12-bit registers associated with it: ON and OFF. The
    ' PCA9685 has an internal 12-bit register which counts from 0-4095 and then
    ' overflows. When the ON register matches that counter, the pin asserts. When
    ' the OFF register matches, the pin de-asserts.
    #define PCA9685_LED0          0x06
    #define PCA9685_LED0_ON_L     0x06
    #define PCA9685_LED0_ON_H     0x07
    #define PCA9685_LED0_OFF_L    0x08
    #define PCA9685_LED0_OFF_H    0x09

    #define PCA9685_LED1          0x0a
    #define PCA9685_LED1_ON_L     0x0a
    #define PCA9685_LED1_ON_H     0x0b
    #define PCA9685_LED1_OFF_L    0x0c
    #define PCA9685_LED1_OFF_H    0x0d

    #define PCA9685_LED2          0x0e
    #define PCA9685_LED2_ON_L     0x0e
    #define PCA9685_LED2_ON_H     0x0f
    #define PCA9685_LED2_OFF_L    0x10
    #define PCA9685_LED2_OFF_H    0x11

    #define PCA9685_LED3          0x12
    #define PCA9685_LED3_ON_L     0x12
    #define PCA9685_LED3_ON_H     0x13
    #define PCA9685_LED3_OFF_L    0x14
    #define PCA9685_LED3_OFF_H    0x15

    #define PCA9685_LED4          0x16
    #define PCA9685_LED4_ON_L     0x16
    #define PCA9685_LED4_ON_H     0x17
    #define PCA9685_LED4_OFF_L    0x18
    #define PCA9685_LED4_OFF_H    0x19

    #define PCA9685_LED5          0x1a
    #define PCA9685_LED5_ON_L     0x1a
    #define PCA9685_LED5_ON_H     0x1b
    #define PCA9685_LED5_OFF_L    0x1c
    #define PCA9685_LED5_OFF_H    0x1d

    #define PCA9685_LED6          0x1e
    #define PCA9685_LED6_ON_L     0x1e
    #define PCA9685_LED6_ON_H     0x1f
    #define PCA9685_LED6_OFF_L    0x20
    #define PCA9685_LED6_OFF_H    0x21

    #define PCA9685_LED7          0x22
    #define PCA9685_LED7_ON_L     0x22
    #define PCA9685_LED7_ON_H     0x23
    #define PCA9685_LED7_OFF_L    0x24
    #define PCA9685_LED7_OFF_H    0x25

    #define PCA9685_LED8          0x26
    #define PCA9685_LED8_ON_L     0x26
    #define PCA9685_LED8_ON_H     0x27
    #define PCA9685_LED8_OFF_L    0x28
    #define PCA9685_LED8_OFF_H    0x29

    #define PCA9685_LED9          0x2a
    #define PCA9685_LED9_ON_L     0x2a
    #define PCA9685_LED9_ON_H     0x2b
    #define PCA9685_LED9_OFF_L    0x2c
    #define PCA9685_LED9_OFF_H    0x2d

    #define PCA9685_LED10         0x2e
    #define PCA9685_LED10_ON_L    0x2e
    #define PCA9685_LED10_ON_H    0x2f
    #define PCA9685_LED10_OFF_L   0x30
    #define PCA9685_LED10_OFF_H   0x31

    #define PCA9685_LED11         0x32
    #define PCA9685_LED11_ON_L    0x32
    #define PCA9685_LED11_ON_H    0x33
    #define PCA9685_LED11_OFF_L   0x34
    #define PCA9685_LED11_OFF_H   0x35

    #define PCA9685_LED12         0x36
    #define PCA9685_LED12_ON_L    0x36
    #define PCA9685_LED12_ON_H    0x37
    #define PCA9685_LED12_OFF_L   0x38
    #define PCA9685_LED12_OFF_H   0x39

    #define PCA9685_LED13         0x3a
    #define PCA9685_LED13_ON_L    0x3a
    #define PCA9685_LED13_ON_H    0x3b
    #define PCA9685_LED13_OFF_L   0x3c
    #define PCA9685_LED13_OFF_H   0x3d

    #define PCA9685_LED14         0x3e
    #define PCA9685_LED14_ON_L    0x3e
    #define PCA9685_LED14_ON_H    0x3f
    #define PCA9685_LED14_OFF_L   0x40
    #define PCA9685_LED14_OFF_H   0x41

    #define PCA9685_LED15         0x42
    #define PCA9685_LED15_ON_L    0x42
    #define PCA9685_LED15_ON_H    0x43
    #define PCA9685_LED15_OFF_L   0x44
    #define PCA9685_LED15_OFF_H   0x45

    ' These registers allow the user to load *all* the corresponding registers at
    ' the same time. This is useful for resetting all registers to zero or to a
    ' common brightness.
    #define PCA9685_ALL_LED_ON_L  0xfa
    #define PCA9685_ALL_LED_ON_H  0xfb
    #define PCA9685_ALL_LED_OFF_L 0xfc
    #define PCA9685_ALL_LED_OFF_H 0xfd

    #define PCA9685_ALL_CHANNELS  0xfa

    ' The PRE_SCALE register allows the user to set the PWM frequency. The
    ' equation for determining this value is
    '  PRE_SCALE = ((f_clk)/(4096*f_pwm))-1
    ' Of course, only positive integers are allowed, and futhermore, a minimum
    ' value of 3 is enforced on the value in this register.
    ' f_clk is, by default, 25MHz; external clocks can be applied.
    #define PCA9685_PRE_SCALE     0xfe


    ' Library specific constants to support ease of use
    #define PCA9685_LED_ON   0x1000
    #define PCA9685_LED_OFF  0x0000

    #define PCA9685_INTERNAL_CLOCK_FREQUENCY 25000000

    ' Servo angle calculation constants
    '  We want to give the user the ability to specify an angle (range 0 to 180)
    '  and have a servo simply move to that angle. Thus, we need two constants
    '  to do the scaling math: MIN_WIDTH and MAX_WIDTH. A pulse of MIN_WIDTH
    '  corresponds to an angle of 0, and MAX_WIDTH of 180. These values can vary
    '  across servo models; the defaults here are a swag.
    '  Servos expect a pulse train of varying duty cycle and 50Hz frequency; to
    '  get that frequency, we want to set the prescaler to 121, which makes the
    '  numbers below each represent ~4.5us per count.
