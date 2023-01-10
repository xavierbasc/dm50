# DM50 calculator
The main features of the calculator are the following:
 
- The calculator firmware supports Reverse Polish Notation (RPN), and Computer Algebra System (CAS).
- Electronic schematics and designs of the boards are open source
- Free42 and C42 software adapted, available to be executed on the calculator
- Ultra low power ARM Cortex-M33  (based on the ARMv8-M architecture).
- 128-bit floating point precision implementation (IEEE 754-2008).
- Battery type CR2032 (life up to 5 years).
- USBC port, connects as USB mass storage device.
- Transflective memory LCD display (sharp).
- 6MB of internal flash storage formatted, accesible por USB.
 
# Hardware
For the development of the hardware, the KiCad tool has been used.
Below is the list of electronic components used to manufacture the board.
| Component | Ref | Buy it | Description |
| - | - | - | - |
| SoC Processor | STM32L476 VGT6 | - |  |
| Buzzer | SiP32431 | - | Buzzer |
 
The board can be ordered from pcbway, jlcpcb, etc.
 
In addition, 3D designs for the calculator case and keyboard are included.
[pending development]
# Bootloader
[pending development]
 
# Reference hardware and software
Comparison of the hardware used in the different reference calculators:
 
| Model | Year | Processor | Speed | Precision | RAM | Flash | Display | Battery | Standby
| - | - | - | - | - | - | - | - | - | - |
| [OpenRPNCalc](https://github.com/apoluekt/OpenRPNCalc) | 2021 | STM32L476 | 8 MHz | 10 | 128 KB | 1 MB | 400x240 | CR2032 | years |
| [NumWorks](https://www.numworks.com/resources/engineering/hardware/) | 2016 | STM32F730V8T6 | 216 MHz | ? | 256 KB | 6 MB | 320x240 | CR2032 | years |
| [DM42](https://www.swissmicros.com/product/dm42) | 2017 | STM32L476RG | 80 MHz | 34 | 128 KB | 6 MB | 400×240 | CR2032 | 3 years |
| [TI-Nspire CX II CAS](https://en.wikipedia.org/wiki/TI-Nspire_series#TI-Nspire_CX_II_and_TI-Nspire_CX_II_CAS) | 2013 | ARM9-26EJ-S | 396 MHz | 14 | 64 MB | 128 MB | 320x240 | 3.7L1230SP | ? |
| [HP Prime G2](https://en.wikipedia.org/wiki/HP_Prime) | 2019 | i. MX 6ULL | 528 MHz | 12 | 256 MB | 512 MB | 320×240 | EB-L1G6LLU | 46 days
 
Software adapted to be executed (as firmware) on the DM50 calculator:
| Software | Code |  Version | License | Detail | Download for DM50 | Version |
| - | - | - | - | - | - | - |
| [WP43](https://gitlab.com/rpncalculators/wp43) | [Gitlab](https://gitlab.com/rpncalculators/wp43) | [![version](https://gitlab.com/wpcalculators/wp43/-/badges/release.svg)](https://gitlab.com/wpcalculators/wp43/-/releases) | GPLv3 | Firmware for the WP43 pocket calculator (old WP43S project) | - | - |
| [C43](https://www.classic43.com) | [Gitlab](https://gitlab.com/rpncalculators/c43) |  [![version](https://gitlab.com/rpncalculators/c43/-/badges/release.svg)](https://gitlab.com/wpcalculators/wp43/-/releases) |  GPLv3 | C43 is a RPN Scientific Calculator (old WP43C project) | - | - |
| [Free42](https://github.com/thomasokken/free42) | [GitHub](https://github.com/thomasokken/free42) | v3.0.17 |  GPLv2 | Free42 is a software clone of the Hewlett-Packard 42S calculator | - | - |