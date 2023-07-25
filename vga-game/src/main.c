/*
  <this program makes a ATtiny212 output a vga signal to play tetris>
  Copyright (C) <2023>  <Samual Kim>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  Sam's Email: homerbob6@protonmail.com
*/

/**
 * This is a project thats makes a ATtiny212 output a vga signal to play tetris.
 * The microcontroller bit bangs a VGA signal to show the game.
 * Currently the game that is being made it tetris. in futuer many be space invaders
 * using a attiny212 microcontroller.
 * attiny212 has 2k of flash, 128 bytys of ram, 8 pins, and runs at 20 MHz
 * datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny202-402-AVR-MCU-with-Core-Independent-Peripherals_and-picoPower-40001969A.pdf
 * mcu is running 20 MHz and outputs a SVGA Signal 800 x 600 @ 60 Hz (pclock of 40 MHz).
 * one clock cycle is 2 horizonal pixles
 * timing info link: http://tinyvga.com/vga-timing/800x600@60Hz
 */

#include <avr/io.h>
#include <atomic.h>
#include <compiler.h>

// uncomment for some debug info
// #define DEBUG   // enables debuging
#define EXT_CLK // enables extranl clock

// pin defunitions
#define COLOR_PIN PIN7_bm
#define VSYNC_PIN PIN1_bm
#define HSYNC_PIN PIN6_bm

// this tetris verson had most of the game rules to the nitendo nes verson
#define DAS_INT 16 // delay auto shift, the time when press key and when it starts repeting the action, it is 16 frames
#define DAS 6

// init globle varbles
int8_t row;                  // the row that is being displayed
int8_t rowCycleCounter;      // what line of the row is being displayed
uint8_t buttonStatus;        // hold what button is pressed now and on the last frame
uint16_t patternMask;        // mask where the peice goes on playfeild
uint8_t frameCounter;        // what frame of the cycle it is on
uint8_t peiceCounter;        // how many piece have been put down
int8_t xPos = 3;             // the x pos of the piece, range is -2 to 8
int8_t yPos = 20;            // the y pos of piece, range is -1 to 20
uint8_t rotation = 0;        // the current rotation of the peice on board
uint8_t peice = 6;           // the current peice on board
uint8_t updateTime = 48;     // how many frames a cycle takes
uint8_t level;               // the level the game is on
int8_t DAScount;             // used to keep take when button needs to auto repete
int8_t buttonHoldCount;      // how many frames a button was being couniesly being pressed
uint16_t playFeild[21] = {}; // holds all the block on play feild (10*20 blocks), 21 to help with reseting the game
uint8_t scoreNum[6];         // hold the sorce in BCD format (unused)
uint8_t lineNum[3];          // hold the line cleared in BCD format (unused)
uint8_t nextPiece;           // the next pecie to be shown
uint8_t lineCleared;         // how many lines have ben cleared

// game pieces, bottom left is lsb, top right is msb (all peices are 4*4)
// using nintendo rotation system
/* I pieces
0000    0010    0000    0010
0000    0010    0000    0010
1111    0010    1111    0010
0000    0010    0000    0010
*/
/* o pieces
0000    0000    0000    0000
0110    0110    0110    0110
0110    0110    0110    0110
0000    0000    0000    0000
*/
/* J pieces
0000    0000    0000    0000
0000    0100    1000    0110
1110    0100    1110    0100
0010    1100    0000    0100
*/
/* L pieces
0000    0000    0000    0000
0000    1100    0010    0100
1110    0100    1110    0100
1000    0100    0000    0110
*/
/* S pieces
0000    0000    0000    0000
0000    0100    0000    0100
0110    0110    0110    0110
1100    0010    1100    0010
*/
/* T pieces
0000    0000    0000    0000
0000    0100    0100    0100
1110    1100    1110    0110
0100    0100    0000    0100
*/
/* Z pieces
0000    0000    0000    0000
0000    0010    0000    0010
1100    0110    1100    0110
0110    0100    0110    0100
*/

// the pattern of the games peices and how it is to be displayed
const uint16_t pattern[7][4] = {
    {0b0000000011110000, 0b0100010001000100, 0b0000000011110000, 0b0100010001000100}, // I piece
    {0b0000011001100000, 0b0000011001100000, 0b0000011001100000, 0b0000011001100000}, // O piece
    {0b0000000001110100, 0b0000001000100011, 0b0000000101110000, 0b0000011000100010}, // J piece
    {0b0000000001110001, 0b0000001100100010, 0b0000010001110000, 0b0000001000100110}, // L piece
    {0b0000000001100011, 0b0000001001100100, 0b0000000001100011, 0b0000001001100100}, // S piece
    {0b0000000001110010, 0b0000001000110010, 0b0000001001110000, 0b0000001001100010}, // T piece
    {0b0000000000110110, 0b0000010001100010, 0b0000000000110110, 0b0000010001100010}  // Z piece
                                                                                      // {0b0000100011101000, 0b0100010001001010, 0b0000100011101000, 0b1010010001000100}  // dick piece
};

// used to display number, this is for the score or the line count
/* segment format with what bit repersents them
    7777
    6  5
    4444
    3  2
    1111
*/
const uint8_t numberPattern[12] = {
    0b11101110, // 0
    0b00100100, // 1
    0b10111010, // 2
    0b10110110, // 3
    0b01110100, // 4
    0b11010110, // 5
    0b11011110, // 6
    0b10100100, // 7
    0b11111110, // 8
    0b11110100, // 9
    0b00100110, // L
    0b11011010  // E
};

// make the mask of where the peice goes on the feild. or the mask and the playfeild to get the the playfeild with the peice
uint16_t patternMaskMaker(int8_t xPos, int8_t peiceRow)
{
  // put bits in correct row
  uint16_t patternMask; //= ((pattern[peice][rotation] >> ((peiceRow)*4)) & 0xf);

  if (peiceRow < 0 || peiceRow > 3) // check to see if peiceRow is neg
  {
    patternMask = 0; // negaitve peiceRow with return 0
  }
  else
  {
    patternMask = ((pattern[peice][rotation] >> ((peiceRow)*4)) & 0xf);

    // move bit to right part of the row
    if (xPos < 0)
    {
      patternMask = patternMask >> (xPos * -1);
    }
    else
    {
      patternMask = patternMask << (xPos);
    }
  }
  return patternMask;
}

// you give the function the new xand y pos to check if they are vaild
// returns 0 if not vaild, return 1 if vaild
uint8_t validMove(int8_t newxPos, int8_t newyPos)
{
  for (int8_t i = 0; i < 4; i++)
  {
    uint16_t patternMask = (patternMaskMaker(newxPos + 2, i));
    if ((newyPos + i) < 0) // see if ypos is negitive
    {
      if ((patternMask & 0xffff)) // if part of the pice is below the game field, it not vaild
      {
        return 0;
      }
    }
    else if ((((playFeild[newyPos + i] << 2) | 0xf003) & patternMask))
    {
      return 0;
    }
  }
  return 1;
}

// doing game logic function
void gameLogic()
{
  frameCounter++;
  // checks for user inputs
  buttonStatus = buttonStatus << 4; // holdes states of button from this and last frame
  uint8_t adcRNG = ADC0.RESL;       // hold adc value, lower 8 bits, used to RND
  uint8_t adcRead = ADC0.RESH;      // hold adc value, holds top 2 bits, used to see what button is pressed
  // adcRead = adcRead << 2;

  // adcRNG = adcRNG & 0xf;
  // uint8_t adcRNG = ADC0.RESL;       // hold adc value, and lower it resolution
  // uint8_t adcRead = adcRNG >> 4;    // hold adc value, and lower it resolution
  // adcRNG = adcRNG & 0xf;

// adcRead holds the top 4 bits of the ADC, (bits are not in order)
  // puts 2 bit of data in adcRead to get the right button data
  asm volatile(
      "BST %0,7\n"
      "BLD %1,3\n"
      "BST %0,6\n"
      "BLD %1,2\n"
      : "+r"((uint8_t)(adcRNG)), "+r"((uint8_t)(adcRead)));
  uint8_t buttonStatusMask = 0; // hold state of current button state

  if (adcRead == 0) // rotate button
  {
    buttonStatusMask = 2;
  }
  if (adcRead == 2) // down button
  {
    buttonStatusMask = 4;
  }
  if ((adcRead > 14)) // right button
  {
    buttonStatusMask = 1;
  }
  if (adcRead == 10) // left button
  {
    buttonStatusMask = 8;
  }

  buttonStatus = buttonStatus | buttonStatusMask;
  int8_t value; // hold the result from validMove to move the piece
  // if (buttonStatusMask)
  //   buttonHoldCount++;

  switch (buttonStatus) //((buttonStatus & 0xf) & ~(buttonStatus >> 4)) //& ~(buttonStatus >> 8))
  {
  case 1: // press right button
    value = validMove(xPos + 1, yPos);
    xPos = xPos + value;
    DAScount = 16;
    break;
  case 8: // press left button
    value = validMove(xPos - 1, yPos);
    xPos = xPos - value;
    DAScount = 16;
    break;
  case 2: // press rotate button
    rotation++;
    rotation = rotation & 3;
    if (validMove(xPos, yPos) == 0) //    if (validMove(xPos, yPos) != 1)
    {
      rotation = rotation + 3;
      rotation = rotation & 3;
    }
    break;
  case 4: // press down button
    frameCounter = updateTime + 1;
    DAScount = 6;
    break;
  case 0x11:
    // hold down button, it will move over every 6 frames
    if (DAScount == 0)
    {
      DAScount = 6;
      value = validMove(xPos + 1, yPos);
      xPos = xPos + value;
    }
    break;
  case 0x44:
    // hold down button, it will drop down every other frame
    if (frameCounter > 0 && DAScount == 0)
    {
      frameCounter = updateTime + 1;
    }
    break;
  case 0x88:
    // hold down button, it will move over every 6 frames
    if (DAScount == 0)
    {
      DAScount = 6;
      value = validMove(xPos - 1, yPos);
      xPos = xPos - value;
    }
    break;
  case 0x22:
  default:
    DAScount = -1;
    // buttonHoldCount--;
  }

  if (DAScount > 0)
  {
    DAScount--;
  }

  // cycle is down
  if (frameCounter > updateTime)
  {
    frameCounter = 0;
    peiceCounter++;
    value = validMove(xPos, yPos - 1);
    yPos = yPos - value;
    if (!value) // when piece cant move down
    {
      DAScount = -1;
      // updatePlayField(xPos, yPos);

      // update the play feild
      uint16_t patternMask;
      for (int8_t i = 0; i <= 3; i++)
      {
        if (yPos + i > 20) // prevenct messing with data outside of playfeild
          break;
        patternMask = patternMaskMaker(xPos, i);
        playFeild[yPos + i] = playFeild[yPos + i] | patternMask;
      }

      // check if playfeild has any full rows
      int8_t i, count = yPos; // i is for for loop and count is what row to put it on
      for (i = yPos; i <= 20; i++)
      {
        // when row is full, go to begining of loop
        if ((playFeild[i] & 0x03ff) == 0x03ff) // when
        {
          lineCleared = lineCleared + 1;
          continue;
        }
        // put i pointer into count pointer
        playFeild[count] = (playFeild[count] & ~0x03ff) | (playFeild[i] & 0x03ff);
        count++; // update count pointer
      }
      // return i - count;

      // finds out what level it is on
      level = lineCleared / 10;

      // change game speed based on what level
      // if (level < 9)
      // {
      //   updateTime = 48 - level * 5;
      // }
      // else if (level == 9)
      // {
      //   updateTime = 6;
      // }
      // else if (level <= 12)
      // {
      //   updateTime = 5;
      // }
      // else if (level <= 15)
      // {
      //   updateTime = 4;
      // }
      // else if (level <= 18)
      // {
      //   updateTime = 3;
      // }
      // else if (level <= 28)
      // {
      //   updateTime = 2;
      // }
      // else
      // {
      //   updateTime = 1;
      // }
      // if (level < 9)
      // {
      //   updateTime = 48 - level * 5;
      // }
      // if (level >= 9){
      //   // level = level +1;
      //   updateTime = 9 - ((level) / 3);
      //   // level = level -1;
      // }
      // if (level > 21){
      //   updateTime = updateTime +1;
      // }

      if (level == 9)
      {
        updateTime = 6;
      }
      if (level > 9) // 10 - 12
      {
        updateTime = 5;
      }
      if (level > 12) // 13 - 15
      {
        updateTime = 4;
      }
      if (level > 15) // 16 - 18
      {
        updateTime = 3;
      }
      if (level > 18) // 19 - 28
      {
        updateTime = 2;
      }
      if (level > 28) // 29 +
      {
        updateTime = 1;
      }

      // setup piece for next cylce
      xPos = 3;
      yPos = 20; // yPos = i;
      peice = nextPiece;
      // if (peice > 6){
      //   peice = peice - 7;
      rotation = peiceCounter & 3;
      nextPiece = (((peiceCounter)) ^ adcRNG) & 7;
      if (nextPiece == 7)
      {
        nextPiece = (((peiceCounter)) ^ (adcRNG + 1)) & 7;
      }

      // game over, reset microcontroller
      if (playFeild[20] != 0)
      {
        ccp_write_io((void *)&(RSTCTRL.SWRR), 1); // reset the microcontroller
      }
    }
  }
  // if ((peiceCounter >> 2) == 7)
  // {
  //   peiceCounter = 0;
  // }
  // status = 0;
  rowCycleCounter = 29;
#ifdef DEBUG
  // playFeild[14] = (playFeild[14]) | (((buttonStatus & 0xf)) << 10);
  // playFeild[8] = (playFeild[8] & 0x03ff) | (validMove(xPos + 1, yPos) << 10) | (validMove(xPos, yPos + 1) << 11); // display y value
  // playFeild[9] = (playFeild[9] & 0x03ff) | (validMove(xPos - 1, yPos) << 10) | (validMove(xPos, yPos - 1) << 11); // display y value
  // playFeild[10] = (playFeild[10] & 0x03ff) | (yPos << 10);                                                        // display y value
  // playFeild[11] = (playFeild[11] & 0x03ff) | (xPos << 10);
  playFeild[12] = (playFeild[12] & 0x03ff) | ((adcRead & 0b00001111) << 10);  // display x value
  playFeild[13] = (playFeild[13] & 0x03ff) | ((adcRNG & 0b00001111) << (10)); // display x value
#endif

  TCD0.INTCTRL = 1 << TCD_OVF_bp; // turn on the hsync interput
}

// trigger at the begining of every scanline
ISR(TCD0_OVF_vect)
{
  if (TCA0.SINGLE.CNT < 600)
  {
    if (TCA0.SINGLE.CNT == 0)
    {
      rowCycleCounter = 0;
    }
    if ((rowCycleCounter) <= (1))
    {
      if (rowCycleCounter == 0)
      {
        rowCycleCounter = 30;
        if (row == 0)
        {
          row = 20;
        }
        // else
        // {
        row = row - 1; // (1 & TCA0.SINGLE.CNT >>2);
        // }
        patternMask = patternMaskMaker(xPos, row - yPos);
      }
    }
    else
    {
      uint16_t feildDisplay = playFeild[row] | (patternMask);
      uint8_t i = 0; // used for asm for loop, for some reson it not set to 0
      // VPORTA_OUT = 0;
      // display the block and takes 15 clock cycles or 30 pixes
      asm volatile(
          "SBI 0x01, 7\n"      // turn on output to make boarder    (1 cycle)
          "CLR %1\n"           // clear i to 0   (1 cycle)
          "loop: CPI %1, 10\n" // compare i (in for loop) with 10   (1 cycle)
          "BREQ next\n"        // check if i = 10, if so will break from loop   (1 cycle for false)

          // rotate right for lower feildDisplay
          "BST %A0, 0\n" // move bit 0 into t flag    (1 cycle)
          "LSR %A0\n"    // right shift lower feildDisplay    (1 cycle)
          "BLD %A0, 7\n" // put t reginer in to lower feildDisplay bit 7  (1 cycle)

          "cbi 0x01, 7\n"   // turn off output (looks nicer)    (1 cycle)
          "OUT 0x01, %A0\n" // set porta to feildDisplayL, bit 7 is the only output   (1 cycle)

          // right shift upper feildDisplay and put bit 0 in lower feildDisplay bit 7
          "BST %B0, 0\n" // move bit 0 into t flag    (1 cycle)
          "LSR %B0\n"    // right shift upper feildDisplay    (1 cycle)
          "BLD %A0, 7\n" // put t reginer in to lower feildDisplay bit 7    (1 cycle)

          "INC %1\n"    // inc i    (1 cycle)
          "rjmp loop\n" // go to begin of loop  (3 cycle)
          "next: NOP\n" // go here when done with loop, put a contional here

          "cbi 0x01, 7\n" // turn off output (looks nicer)    (1 cycle)
          "SBI 0x01, 7\n" // turn on output to make boarder    (1 cycle)

          // add delay and starts ADC and sets ACD Mux
          "ldi	r30, 0x00\n" // loacation of register high
          "ldi	r31, 0x06\n" // loacation of register low
          "ldi	%1, 0x01\n"  // put 1 in i register
          "std	Z+8, %1\n"   // put 1 in ADC0.COMMAND
          "ldi	%1, 0x02\n"  // put 2 in i register
          "std	Z+6, %1\n"   // put 2 in ADC0.MUXPOS

          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          "OUT 0x01, %1\n" // put i in the output, i will be a (2 or 10) and will turn off diplay and enable vsync output, saveing 4 bytes of flash
          // "cbi 0x01, 7\n" // turn off output (looks nicer)    (1 cycle)
          : "+r"((uint16_t)(feildDisplay)), "=r"((uint8_t)(i)));
      // VPORTA_OUT = 0; // turn pixle on screen, is 2 and not 0 because to save flash and turn on vsync output
#ifdef DEBUG
      // i = 4;
      asm volatile(
          // // "SBI 0x01, 7\n"      // turn on output to make boarder    (1 cycle)
          "CLR %1\n"           // clear i to 0   (1 cycle)
          "loop2: CPI %1, 6\n" // compare i (in for loop) with 10   (1 cycle)
          "BREQ next2\n"       // check if i = 10, if so will break from loop   (1 cycle for false)

          // rotate right for lower feildDisplay
          "BST %A0, 0\n" // move bit 0 into t flag    (1 cycle)
          "LSR %A0\n"    // right shift lower feildDisplay    (1 cycle)
          "BLD %A0, 7\n" // put t reginer in to lower feildDisplay bit 7  (1 cycle)

          "cbi 0x01, 7\n"   // turn off output (looks nicer)    (1 cycle)
          "OUT 0x01, %A0\n" // set porta to feildDisplayL, bit 7 is the only output   (1 cycle)

          // right shift upper feildDisplay and put bit 0 in lower feildDisplay bit 7
          "BST %B0, 0\n" // move bit 0 into t flag    (1 cycle)
          "LSR %B0\n"    // right shift upper feildDisplay    (1 cycle)
          "BLD %A0, 7\n" // put t reginer in to lower feildDisplay bit 7    (1 cycle)

          "INC %1\n"       // inc i    (1 cycle)
          "rjmp loop2\n"   // go to begin of loop  (3 cycle)
          "next2: NOP\n"   // go here when done with loop
          "INC %1\n"       // inc i    (1 cycle)
          "INC %1\n"       // inc i    (1 cycle)
          "INC %1\n"       // inc i    (1 cycle)
          "INC %1\n"       // inc i    (1 cycle)
          "OUT 0x01, %1\n" // put i in the output, i will be a (2 or 10) and will turn off diplay and enable vsync output, saveing 4 bytes of flash

          // "cbi 0x01, 7\n" // turn off output (looks nicer)    (1 cycle)
          // "SBI 0x01, 7\n" // turn on output to make boarder    (1 cycle)

          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          // "NOP\n"
          // "cbi 0x01, 7\n" // turn off output (looks nicer)    (1 cycle)
          : "+r"((uint16_t)(feildDisplay)), "=r"((uint8_t)(i)));
      // VPORTA_OUT = 0;
#endif
    }
    rowCycleCounter--;
  }
  TCD0.INTFLAGS = TCD_OVF_bm;
}

int main(void)
{
  // make all pin by defual as inputs with pull ups
  // for (uint8_t i = 0; i < 8; i++)
  // {
  //   *((uint8_t *)&PORTA + 0x10 + i) |= 1 << PORT_PULLUPEN_bp;
  // }
  // make currently unsed pin as pullups
  PORTA.PIN0CTRL = PORT_PULLUPEN_bm;
  PORTA.PIN3CTRL = PORT_PULLUPEN_bm;

  // set up v sync counter
  // TCA0.SINGLE.CMP0 = 600; /* Compare Register 0: 0x258 */
  TCA0.SINGLE.CMP1 = 601; /* Compare Register 1: 0x259 */
  TCA0.SINGLE.CMP2 = 605; /* Compare Register 2: 0x25d */
  // TCA0.SINGLE.CNT = 0x0; /* Count: 0x0 */
  TCA0.SINGLE.CTRLB = 0 << TCA_SINGLE_ALUPD_bp       /* Auto Lock Update: disabled */
                      | 0 << TCA_SINGLE_CMP0EN_bp    /* Compare 0 Enable: enabled */
                      | 1 << TCA_SINGLE_CMP1EN_bp    /* Compare 1 Enable: enabled */
                      | 1 << TCA_SINGLE_CMP2EN_bp    /* Compare 2 Enable: enabled */
                      | TCA_SINGLE_WGMODE_NORMAL_gc; /*  */
  // TCA0.SINGLE.CTRLC = 0 << TCA_SINGLE_CMP0OV_bp /* Compare 0 Waveform Output Value: disabled */
  //		 | 0 << TCA_SINGLE_CMP1OV_bp /* Compare 1 Waveform Output Value: disabled */
  //		 | 0 << TCA_SINGLE_CMP2OV_bp; /* Compare 2 Waveform Output Value: disabled */
  // TCA0.SINGLE.DBGCTRL = 0 << TCA_SINGLE_DBGRUN_bp; /* Debug Run: disabled */
  TCA0.SINGLE.EVCTRL = 1 << TCA_SINGLE_CNTEI_bp /* Count on Event Input: enabled */
                       | TCA_SINGLE_EVACT_POSEDGE_gc /* Count on positive edge event */;
  TCA0.SINGLE.INTCTRL = 0 << TCA_SINGLE_CMP0_bp   /* Compare 0 Interrupt: enabled */
                        | 1 << TCA_SINGLE_CMP1_bp /* Compare 1 Interrupt: enabled */
                        | 1 << TCA_SINGLE_CMP2_bp /* Compare 2 Interrupt: enabled */
                        | 0 << TCA_SINGLE_OVF_bp; /* Overflow Interrupt: enabled */
  TCA0.SINGLE.PER = 627;                          // should be 627 or 628
  TCA0.SINGLE.CTRLA = TCA_SINGLE_CLKSEL_DIV1_gc   /* System Clock */
                      | 1 << TCA_SINGLE_ENABLE_bp /* Module Enable: enabled */;

  // Enable Protected register, peripheral must be disabled (ENABLE=0, in TCD.CTRLA).
  // set up hscyn counter/pin
  TCD0.CMPASET = 420;                    /* Compare A Set: 420 */
  TCD0.CMPACLR = 484;                    /* Compare A Clear: 484 */
  TCD0.CMPBSET = 400;                    /* Compare B Set: 400 */
  TCD0.CMPBCLR = 528;                    /* Compare B Clear: 528 */
  TCD0.EVCTRLB = TCD_CFG_NEITHER_gc      /* Neither Filter nor Asynchronous Event is enabled */
                 | TCD_ACTION_CAPTURE_gc /* Event trigger a fault and capture */
                 | TCD_EDGE_RISE_HIGH_gc /* The rising edge or high level of event generates retrigger or fault action */
                 | 0 << TCD_TRIGEI_bp;   /* Trigger event enable: disabled */

  ccp_write_io((void *)&(TCD0.FAULTCTRL),
               1 << TCD_CMPAEN_bp       /* Compare A enable: enabled */
                   | 0 << TCD_CMPA_bp   /* Compare A value: disabled */
                   | 0 << TCD_CMPB_bp   /* Compare B value: disabled */
                   | 0 << TCD_CMPBEN_bp /* Compare B enable: disabled */
                   | 0 << TCD_CMPC_bp   /* Compare C value: disabled */
                   | 0 << TCD_CMPCEN_bp /* Compare C enable: disabled */
                   | 0 << TCD_CMPD_bp   /* Compare D vaule: disabled */
                   | 0 << TCD_CMPDEN_bp /* Compare D enable: disabled */);

  TCD0.INTCTRL = 1 << TCD_OVF_bp; /* Overflow interrupt enable: enabled */

  // while ((TCD0.STATUS & TCD_ENRDY_bm) == 0)
  //   ; // Wait for Enable Ready to be high.

  TCD0.CTRLA = 1 << TCD_ENABLE_bp      /* Enable: enabled */
               | TCD_CLKSEL_SYSCLK_gc  /*  */
               | TCD_CNTPRES_DIV1_gc   /* Sync clock divided by 1 */
               | TCD_SYNCPRES_DIV1_gc; /*  */

  // set up interputs
  // ccp_write_io((void *)&(CPUINT.CTRLA),
  //              0 << CPUINT_CVT_bp         /* Compact Vector Table: enabled */
  //                  | 0 << CPUINT_IVSEL_bp /* Interrupt Vector Select: enabled */
  //                  | 0 << CPUINT_LVL0RR_bp /* Round-robin Scheduling Enable: disabled */);

  // CPUINT.LVL0PRI = 0x0 << CPUINT_LVL0PRI_gp; /* Interrupt Level Priority: 0x0 */

  // CPUINT.LVL1VEC = 0x0 << CPUINT_LVL1VEC_gp; /* Interrupt Vector with High Priority: 0x0 */

  ENABLE_INTERRUPTS();

  // set up events,
  EVSYS.SYNCCH0 = EVSYS_SYNCCH0_PORTA_PIN6_gc;  /* Synchronous Event from Pin PA6 */
  EVSYS.SYNCCH1 = EVSYS_SYNCCH1_PORTB_PIN0_gc;  /* Synchronous Event from Pin PB0 */
  EVSYS.SYNCUSER0 = EVSYS_SYNCUSER0_SYNCCH0_gc; /* Synchronous Event Channel 0 */

  // setting up ADC now happens in TCD0 OVF int to save space
  // set up adc/button pin
  // PORTA.PIN2CTRL = 0x4; // set pin 2 to disable digital input
  ADC0.CTRLA = 0b00000011;
  // ADC0.CTRLB = 1;
  ADC0.CTRLC = 0b01010010;
  // ADC0.CTRLD = 0b00010000;
  SLPCTRL.CTRLA = 1; // enable sleep
                     // this part of the adc set up is done in TCD0 OVF int to save space and waste time there
                     // ADC0.MUXPOS = 0x02; // adc0 input is pin 2
                     // ADC0.COMMAND = 1;   // adc start running

  // set up clock
  ccp_write_io((void *)&(CLKCTRL.MCLKCTRLB),
               CLKCTRL_PDIV_6X_gc /* 6 */
                   | 0 << CLKCTRL_PEN_bp /* Prescaler enable: disabled */);
  // change clock to extranl

#ifdef EXT_CLK
  ccp_write_io((void *)&(CLKCTRL.MCLKCTRLA),
               CLKCTRL_CLKSEL_EXTCLK_gc /* External Clock (EXTCLK) */
                   | 0 << CLKCTRL_CLKOUT_bp /* System clock out: disabled */);
// 	while (CLKCTRL.MCLKSTATUS & CLKCTRL_SOSC_bm) {
// }
#endif

  while (1)
  {
    // go to sleep
    asm volatile(
        "SLEEP\n");
  }
}

// vsync on
ISR(TCA0_CMP1_vect)
{
  VPORTA.DIR = VSYNC_PIN | COLOR_PIN; // enable the vsync output (PIN7_bm is to save flash in main)
  TCA0.SINGLE.INTFLAGS = TCA_SINGLE_CMP1_bm;
}

// vsync off
ISR(TCA0_CMP2_vect)
{
  TCD0.INTCTRL = 0;       // turn off the hsync interput
  VPORTA.DIR = COLOR_PIN; // disable the vsync output
  TCA0.SINGLE.INTFLAGS = TCA_SINGLE_CMP2_bm;
  gameLogic(); // starts doing the game logic
}

// ------------ unused commented out functions ------------------

// // updates the play feild
// int clearCheck()
// {
//   int8_t i, count = 0; // i is for for loop and count is what row to put it on
//   for (i = 0; i < 20; i++)
//   {

//     if ((playFeild[i] & 0x03ff) == 0x03ff)
//     {
//       continue;
//     }

//     playFeild[count] = (playFeild[count] & ~0x03ff) | (playFeild[i] & 0x03ff);
//     count++;
//   }
//   return i - count;
// }
// // updates the play feild
// void updatePlayField(int8_t newxPos, int8_t newyPos)
// {
//   uint16_t patternMask;
//   for (int8_t i = 0; i <= 3; i++)
//   {
//     if (newyPos + i > 19) // prevenct messing with data outside of playfeild
//       break;
//     patternMask = patternMaskMaker(newxPos, i);
//     playFeild[newyPos + i] = playFeild[newyPos + i] | patternMask;
//   }

//   clearCheck();
// }

// this move the pices depening on move
// 0 - down
// 1 - left
// 2 - right
// 3 - rotate
// uint8_t move(uint8_t move)
// {
//   int8_t value = 0;
//   // if (move == 0)
//   // {
//   //       value = validMove(xPos, yPos - 1);
//   //   yPos = yPos + value;
//   // }
//   // if (move == 1)
//   // {
//   //       value = validMove(xPos - 1, yPos);
//   //   xPos = xPos - value;
//   // }
//   // if (move == 2)
//   // {
//   //       value = validMove(xPos + 1, yPos);
//   //   xPos = xPos + value;
//   // }
//   // if (move == 3)
//   // {
//   //       rotation++;
//   //   rotation = rotation & 3;
//   //   value = validMove(xPos, yPos);
//   //   if (!value)
//   //   {
//   //     rotation = rotation + 3;
//   //     rotation = rotation & 3;
//   //   }
//   // }
//   switch (move)
//   {
//   case 0:
//     value = validMove(xPos, yPos - 1);
//     yPos = yPos + value;
//     break;
//   case 1:
//     if (validMove(xPos - 1, yPos) == 1)
//     {
//       xPos = xPos - 1;
//     }
//     break;
//   case 2:
//     if (validMove(xPos + 1, yPos) == 1)
//     {
//       xPos = xPos + 1;
//     }
//     break;
//   case 3:
//     rotation++;
//     rotation = rotation & 3;
//     value = validMove(xPos, yPos);
//     if (value == 0)
//     {
//       rotation = rotation + 3;
//       rotation = rotation & 3;
//     }
//   }
//   return value;
// }
