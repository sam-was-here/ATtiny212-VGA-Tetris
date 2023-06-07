# ATtiny212 VGA Tetris

This project uses an ATtiny212 microcontroller to output a VGA signal and play Tetris on a VGA monitor. The microcontroller generates the VGA signal by bit-banging the necessary signals. The game implemented is a version of Tetris, similar to the one found on the Nintendo NES. The game runs on an ATtiny212 microcontroller, which has 2k of flash, 128 bytes of RAM, 8 pins, and operates at 20 MHz.

## Hardware Requirements

To run this project, you will need the following:

- ATtiny212 microcontroller
- VGA monitor
- VGA cable
- Appropriate power supply for the microcontroller

## Pin Definitions

The following pin definitions are used in the code:

- COLOR_PIN: Pin 7 used for color output
- VSYNC_PIN: Pin 1 used for Vsync signal
- HSYNC_PIN: Pin 6 used for Hsync signal

## Game Controls

The game controls for Tetris are as follows:

- Button 1: Move the piece to the right
- Button 2: Rotate the piece
- Button 3: Move the piece to the left
- Button 4: Increase the drop speed of the piece

## How It Works

The ATtiny212 microcontroller generates a VGA signal with a resolution of 800 x 600 pixels at 60 Hz. It uses a clock frequency of 20 MHz and outputs the VGA signal by bit-banging the necessary signals. Each clock cycle corresponds to 2 horizontal pixels.

The game logic handles the Tetris gameplay, including piece movement, rotation, and collision detection. The game is rendered on the VGA monitor using the generated VGA signal.

## Additional Information

- [ATtiny212 Datasheet](http://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny202-402-AVR-MCU-with-Core-Independent-Peripherals_and-picoPower-40001969A.pdf)
- [AVR assembly instruction set](https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-InstructionSet-Manual-DS40002198.pdf)
- [VGA Timing Information](http://tinyvga.com/vga-timing/800x600@60Hz)
- [UPDI Programmer](https://github.com/ElTangas/jtag2updi)

## Images
![IMG_20230606_214637](https://github.com/sam-was-here/ATtiny212-VGA-Tetris/assets/102840190/99ce1e24-f863-4edf-a12d-522c3afe5c8f)
![IMG_20230606_214746](https://github.com/sam-was-here/ATtiny212-VGA-Tetris/assets/102840190/97aad25b-e29c-4dd3-8988-5a7ff15db940)


## Future Improvements

In the future, the project may be expanded to include other games, such as Space Invaders, using the ATtiny212 microcontroller.

