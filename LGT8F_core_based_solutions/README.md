32Mhz is twice as fast as a conventional arduino nano! Actually _even faster_ as many operations take less clock cycles than in the atmega328p.

# Features

- Fast_IO update
- Automatic prescaler setup
- Support of 0.125 to 32 Mhz
- Digital Analog Converter
- Voltage References
- Analog Comparator (page 224 of datasheet v1.0.4)
- Differential Amplifier
- Computation Accelerator (page 52 of datasheet v1.0.4)
- SoftwareSerial and Hardware Serial
- 2 to 6 high current 80ma IO pins
- [328p Arduino ISP](from [#brother-yan](https://github.com/brother-yan/LGTISP))

# Differences to original core 

- Support 32 Mhz and other clock speeds
- Differential Amplifier API
- Better Boards Menu
- Installation via Board Manager Urls
- SoftwareSerial @32Mhz
- [Huge resource](https://github.com/Edragon/LGT)

# Power consumption @ 5v

| Clock | Pro mini style w/o power LED | Pro mini style | Nano style |
| ----- | ---------------------------- | -------------- | ---------- |
| 32MHz | 12.7mA                       | 15.0mA         | 32.6mA     |
| 16MHz | 9.2mA                        | 11.5mA         | 27.8mA     |
| 8MHz  | 7.1mA                        | 9.4mA          | 25.4mA     |
| 4MHz  | 5.9mA                        | 8.2mA          | 23.3mA     |
| 2MHz  | 5.3mA                        | 7.6mA          | 23.4mA     |
| 1MHz  | 5.0mA                        | 7.3mA          | 22.8mA     |

# Example boards:

## LGT8F328P-LQFP32
../-
### [WAVGAT Pro Mini Pseudo Clone](https://github.com/dbuezas/lgt8fx/wiki/WAVGAT-Pro-Mini-Pseudo-Clone)

<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/WAVGAT_Pro_Mini_Clone.jpg" alt="Wavgat Pro Mini pseudo-clone" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/wavgat_back.jpg" alt="Wavgat Pro Mini pseudo-clone" width="200"/>

### Pro Mini style LQFP32

<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/pro_mini_LQFP32.png" alt="Pro Mini style" width="200"/>

### [Nano Style](https://github.com/dbuezas/lgt8fx/wiki/Nano-Style)

<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/nano_LQFP32.png" alt="Nano style" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/nano.jpg" alt="Nano style" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/nano_back.jpg" alt="Nano style" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/pinouts/svg/LGT8F328P-nano.png" alt="Nano style" width="200"/>
Like this pinout?

[Create](./docs/boards/pinouts) more pinouts for the other boards!

### Uno Style LQFP32

<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/uno_LQFP32.jpeg" alt="Uno style" width="200"/>

### [Wemos TTGO XI](https://github.com/dbuezas/lgt8fx/wiki/Wemos-TTGO-XI)

<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/TTGO_XI_8F328P-U_nano_V3.0_LQFP32.png" alt="Wemos Nano style" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/wemos.jpg" alt="Wemos Nano style" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/wemos back.jpg" alt="Wemos Nano style" width="200"/>

## LGT8F328P-SSOP20

### [Pro Mini Style SSOP20](https://github.com/dbuezas/lgt8fx/wiki/Pro-Mini-Style---SSOP20)

<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/ssop20.png" alt="Pro Mini simil" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/ssop20.jpg" alt="Pro Mini simil" width="200"/>
<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/ssop20_back.jpg" alt="Pro Mini simil" width="200"/>

## LGT8F328P-LQFP48

<img src="https://github.com/dbuezas/lgt8fx/blob/master/docs/boards/uno_LQFP48.png" alt="Uno style" width="200"/>

# Docs & links

- Check the [Wiki](https://github.com/dbuezas/lgt8fx/wiki) for more content by contribuitors
- And you may also find something in the closed [Issues](https://github.com/dbuezas/lgt8fx/issues?utf8=%E2%9C%93&q=is%3Aissue)
- Core is based on [Larduino_HSP v3.6c](https://github.com/Edragon/LGT/tree/master/HSP%20Patch%20File/Larduino_HSP_3.6c/Larduino_HSP_v3.6c) with fastIO backported from https://github.com/LGTMCU/Larduino_HSP
- And inspired from Ralph Bacon's video: https://youtu.be/Myfeqrl3QP0 (Check his channel, he's uploaded a lot of great videos)
- Great place to gather data about this boards: https://github.com/RalphBacon/LGT8F328P-Arduino-Clone-Chip-ATMega328P
- Datasheet [(Chinese) LGT8FX8P_databook_V1.04](./docs/LGT8FX8P_databook_v1.0.4.ch.pdf)
- Datasheet [(English) LGT8FX8P_databook_V1.04](./docs/LGT8FX8P_databook_v1.0.4.en.pdf) thanks to [#metallurge](https://github.com/RalphBacon/LGT8F328P-Arduino-Clone-Chip-ATMega328P/issues/2#issuecomment-517952757)
- Datasheet [(English) LGT8FX8P_databook_V1.05](https://github.com/watterott/LGT8F328P-Testing/raw/master/LGT8FX8P_databook_v1.0.5-English.pdf) By [Watterrott](https://github.com/watterott/LGT8F328P-Testing)
- [Instruction set clk vs avr](https://docs.google.com/spreadsheets/d/1EzwMkWOIMNDqnjpbzuchsLx5Zq_j927tvAPgvmSuP6M/edit?usp=sharing) By unknown, claim if you are the author
- [Work on the differential amplifier](./docs/differential-amplifier/readme.md)
- "Forbiden tech from China has arrived" https://www.avrfreaks.net/forum/forbiden-tech-china-has-arrived?page=all
- Larduino ISP for 328d https://github.com/Edragon/LGT/tree/master/Toolchain/ISP/LarduinoISP-master
- https://www.eevblog.com/forum/projects/anyone-here-interested-in-the-logic-green-avrs-lgt8f328p/
- http://coultersmithing.com/forums/viewtopic.php?f=6&t=1149


# Thanks

- [#dbuezas](https://github.com/dbuezas/lgt8fx/blob/master/readme.md) for doing 99.9999% of the work
