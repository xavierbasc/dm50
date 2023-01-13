# DM50 calculator
The main features of the calculator are the following:

 - The calculator firmware supports Reverse Polish Notation (RPN).
 - Electronic schematics and designs of the boards are open source.
 - WP43, C43 and Free42 software adapted, available to be executed on the calculator.
 - Ultra low power ARM Cortex-M4.
 - 128-bit floating point precision implementation (IEEE 754-2008).
 - Battery type CR2032 (life up to 5 years).
 - USBC port, connects as USB mass storage device.
 - 6MB of internal flash storage formatted, accesible por USB.
 - Graphic LCD Display FSTN (transflective memory LCD is high cost).

# Hardware
Below is the list of electronic components used to manufacture the board.
| Component | Ref | Buy it | Description |
| - | - | - | - |
| SoC Processor | STM32L476VGT6 | [Arrow](https://www.arrow.com/en/products/stm32l476vgt6/stmicroelectronics) | SoC Processor (V = 100/104 pins, G = 1Mbyte Flash, T = LQFP 100-pin, 6 = -40°C to 85°C)|
| Display | NHD-C12864B2Z-RN-FBW | [Arrow](https://www.digikey.es/es/products/detail/newhaven-display-intl/NHD-C12864B2Z-RN-FBW/1885690) | Graphic LCD Display Module Reflective Black (Gray - Inverted) FSTN - Film Super-Twisted Nematic Parallel 128x64 |
| Flash 8MB | 25R6435F | - | Serial NOR FLASH ROM, 64Mbit (8M x 8), 80MHZ, 8-SOP package |
| Power display | TPS61222DCK | [Arrow](https://www.arrow.com/en/products/tps61222dckr) | 5V Output, Low Input Voltage Boost Converter With 5.5μA Quiescent Current |
| Power by USB (5V) | LD3985 | - | Micropower Low-Dropout Voltage Regulator |
| Transistor | MMBT3904L | - | 200 mA, 40 V NPN Bipolar Junction Transistor |
| USB Protection | USBLC6-2SC6 | - | Electrostatic discharges (ESD) protection of USB. |
| IC Power | SiP32431  | - | battery > micro VDD |

For the development of the hardware, the KiCad tool has been used.
The board can be ordered from PCBWay, JLCPCB, etc.
In addition, 3D designs for the calculator case and keyboard are included.
[pending development]

# Interfaces

### Development/debug interface
The processor SoC provides a Serial Wire JTAG Debugging (SWJ-DP) port.
This is a standard ARM CoreSight debug port that combines a JTAG-DP (5-pin) interface and a SW-DP (2-pin) interface.

### LPUART
It is the universal low-power asynchronous transceiver interface provided by the SoC processor.
Connector terminals:
* VDD: Power Supply
* RX: Receiver Data line
* TX:Transmitter Data line
* GND: Ground

# SoCs Comparative
General comparison, taking the maximum specifications between all the SOCs of each family.

| Serie | OFF * | ON | RAM | Flash |
| - | :-: | :-: | :-: | :-: |
| STM32L4 | 8 nA | 28 μA/MHz | 320KB | 64KB - 1MB |
| STM32L4+ | 8 nA | 28 μA/MHz | 320KB | 512KB - 2MB |
| STM32L5 | 17 nA | 62 µA/MHz | 256KB | 256KB - 512KB |
| STM32U5 | 110 nA | 19 µA/MHz | 768KB | 1MB - 2MB |
(*) Power Off with backup registers without real-time clock.

The most appropriate SoC, from the STM32L4 family, has been chosen in order to lower the cost, and STM32U5 and STM32L5 series have a higher consumption than STM32L4.

The series STM32L4 are available in different lines: STM32L4x1 (Access line), STM32L4x2 (USB Device), STM32L4x3 (USB Device, LCD), STM32L4x5 (USB OTG) and STM32L4x6 (USB OTG, LCD).

# Reference hardware and software
Comparison of the hardware used in the different reference calculators:
 
| Model | Year | Processor | Speed | Precision | RAM | Flash | Display | Battery | Standby
| - | :-: | - | -: | :-: | -: | -: | - | - | -: |
| [OpenRPNCalc](https://github.com/apoluekt/OpenRPNCalc) | 2021 | STM32L476 | 8MHz | 10 | 128KB | 1MB | 400x240 | CR2032 | years |
| [NumWorks](https://www.numworks.com/resources/engineering/hardware/) | 2016 | STM32F730V8T6 | 216MHz | ? | 256KB | 6MB | 320x240 | CR2032 | years |
| [DM42](https://www.swissmicros.com/product/dm42) | 2017 | STM32L476RG | 80MHz | 34 | 128KB | 6MB | 400×240 | CR2032 | 3 years |
| [TI-Nspire CX II CAS](https://en.wikipedia.org/wiki/TI-Nspire_series#TI-Nspire_CX_II_and_TI-Nspire_CX_II_CAS) | 2013 | ARM9-26EJ-S | 396MHz | 14 | 64MB | 128MB | 320x240 | 3.7L1230SP | ? |
| [HP Prime G2](https://en.wikipedia.org/wiki/HP_Prime) | 2019 | i. MX 6ULL | 528MHz | 12 | 256MB | 512MB | 320×240 | EB-L1G6LLU | 46 days
 
Software adapted to be executed (as firmware) on the DM50 calculator:
| Software | Code |  Version | License | Detail | Download for DM50 | Version |
| - | - | - | - | - | - | - |
| [WP43](https://gitlab.com/rpncalculators/wp43) | [Gitlab](https://gitlab.com/rpncalculators/wp43) | [![version](https://gitlab.com/wpcalculators/wp43/-/badges/release.svg)](https://gitlab.com/wpcalculators/wp43/-/releases) | GPLv3 | Firmware for the WP43 pocket calculator (old WP43S project) | - | - |
| [C43](https://www.classic43.com) | [Gitlab](https://gitlab.com/rpncalculators/c43) |  [![version](https://gitlab.com/rpncalculators/c43/-/badges/release.svg)](https://gitlab.com/wpcalculators/wp43/-/releases) |  GPLv3 | C43 is a RPN Scientific Calculator (old WP43C project) | - | - |
| [Free42](https://github.com/thomasokken/free42) | [GitHub](https://github.com/thomasokken/free42) | v3.0.17 |  GPLv2 | Free42 is a software clone of the Hewlett-Packard 42S calculator | - | - |

# To Do
Main pending tasks:
1. ~~Reference hardware and software~~.
2. Hardware design. SCH & PCB. Use components supported by PCBWay and JLCPCB.
3. Memory map publication.
4. Bootloader with ability to load new firmware from FAT-USB drive.
5. 3D designs (if required).
6. WP43. Create firmware image.
7. C43. Create firmware image.
8. Free42. Create firmware image.
9. New features.