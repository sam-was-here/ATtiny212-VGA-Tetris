
.pio/build/ATtiny212/firmware.elf:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	19 c0       	rjmp	.+50     	; 0x34 <__ctors_end>
   2:	33 c0       	rjmp	.+102    	; 0x6a <__bad_interrupt>
   4:	32 c0       	rjmp	.+100    	; 0x6a <__bad_interrupt>
   6:	31 c0       	rjmp	.+98     	; 0x6a <__bad_interrupt>
   8:	30 c0       	rjmp	.+96     	; 0x6a <__bad_interrupt>
   a:	2f c0       	rjmp	.+94     	; 0x6a <__bad_interrupt>
   c:	2e c0       	rjmp	.+92     	; 0x6a <__bad_interrupt>
   e:	2d c0       	rjmp	.+90     	; 0x6a <__bad_interrupt>
  10:	2c c0       	rjmp	.+88     	; 0x6a <__bad_interrupt>
  12:	2b c0       	rjmp	.+86     	; 0x6a <__bad_interrupt>
  14:	2a c0       	rjmp	.+84     	; 0x6a <__bad_interrupt>
  16:	eb c1       	rjmp	.+982    	; 0x3ee <__vector_11>
  18:	c2 c1       	rjmp	.+900    	; 0x39e <__vector_12>
  1a:	27 c0       	rjmp	.+78     	; 0x6a <__bad_interrupt>
  1c:	48 c2       	rjmp	.+1168   	; 0x4ae <__vector_14>
  1e:	25 c0       	rjmp	.+74     	; 0x6a <__bad_interrupt>
  20:	24 c0       	rjmp	.+72     	; 0x6a <__bad_interrupt>
  22:	23 c0       	rjmp	.+70     	; 0x6a <__bad_interrupt>
  24:	22 c0       	rjmp	.+68     	; 0x6a <__bad_interrupt>
  26:	21 c0       	rjmp	.+66     	; 0x6a <__bad_interrupt>
  28:	20 c0       	rjmp	.+64     	; 0x6a <__bad_interrupt>
  2a:	1f c0       	rjmp	.+62     	; 0x6a <__bad_interrupt>
  2c:	1e c0       	rjmp	.+60     	; 0x6a <__bad_interrupt>
  2e:	1d c0       	rjmp	.+58     	; 0x6a <__bad_interrupt>
  30:	1c c0       	rjmp	.+56     	; 0x6a <__bad_interrupt>
  32:	1b c0       	rjmp	.+54     	; 0x6a <__bad_interrupt>

00000034 <__ctors_end>:
  34:	11 24       	eor	r1, r1
  36:	1f be       	out	0x3f, r1	; 63
  38:	cf ef       	ldi	r28, 0xFF	; 255
  3a:	cd bf       	out	0x3d, r28	; 61
  3c:	df e3       	ldi	r29, 0x3F	; 63
  3e:	de bf       	out	0x3e, r29	; 62

00000040 <__do_copy_data>:
  40:	1f e3       	ldi	r17, 0x3F	; 63
  42:	a0 e8       	ldi	r26, 0x80	; 128
  44:	bf e3       	ldi	r27, 0x3F	; 63
  46:	e8 ef       	ldi	r30, 0xF8	; 248
  48:	f5 e0       	ldi	r31, 0x05	; 5
  4a:	02 c0       	rjmp	.+4      	; 0x50 <__do_copy_data+0x10>
  4c:	05 90       	lpm	r0, Z+
  4e:	0d 92       	st	X+, r0
  50:	a2 38       	cpi	r26, 0x82	; 130
  52:	b1 07       	cpc	r27, r17
  54:	d9 f7       	brne	.-10     	; 0x4c <__do_copy_data+0xc>

00000056 <__do_clear_bss>:
  56:	2f e3       	ldi	r18, 0x3F	; 63
  58:	a2 e8       	ldi	r26, 0x82	; 130
  5a:	bf e3       	ldi	r27, 0x3F	; 63
  5c:	01 c0       	rjmp	.+2      	; 0x60 <.do_clear_bss_start>

0000005e <.do_clear_bss_loop>:
  5e:	1d 92       	st	X+, r1

00000060 <.do_clear_bss_start>:
  60:	a4 3b       	cpi	r26, 0xB4	; 180
  62:	b2 07       	cpc	r27, r18
  64:	e1 f7       	brne	.-8      	; 0x5e <.do_clear_bss_loop>
  66:	d4 d1       	rcall	.+936    	; 0x410 <main>
  68:	a9 c2       	rjmp	.+1362   	; 0x5bc <_exit>

0000006a <__bad_interrupt>:
  6a:	ca cf       	rjmp	.-108    	; 0x0 <__vectors>

0000006c <patternMaskMaker>:

// make the mask of where the peice goes on the feild. or the mask and the playfeild to get the the playfeild with the peice
uint16_t patternMaskMaker(int8_t xPos, int8_t peiceRow)
{
  // put bits in correct row
  uint16_t patternMask = ((pattern[peice][rotation] >> ((peiceRow)*4)) & 0xf);
  6c:	20 91 82 3f 	lds	r18, 0x3F82	; 0x803f82 <__data_end>
  70:	30 e0       	ldi	r19, 0x00	; 0
  72:	e0 91 84 3f 	lds	r30, 0x3F84	; 0x803f84 <rotation>
  76:	22 0f       	add	r18, r18
  78:	33 1f       	adc	r19, r19
  7a:	22 0f       	add	r18, r18
  7c:	33 1f       	adc	r19, r19
  7e:	e2 0f       	add	r30, r18
  80:	f3 2f       	mov	r31, r19
  82:	f1 1d       	adc	r31, r1
  84:	ee 0f       	add	r30, r30
  86:	ff 1f       	adc	r31, r31
  88:	e0 54       	subi	r30, 0x40	; 64
  8a:	fa 47       	sbci	r31, 0x7A	; 122
  8c:	20 81       	ld	r18, Z
  8e:	31 81       	ldd	r19, Z+1	; 0x01
  90:	94 e0       	ldi	r25, 0x04	; 4
  92:	69 02       	muls	r22, r25
  94:	a0 01       	movw	r20, r0
  96:	11 24       	eor	r1, r1
  98:	02 c0       	rjmp	.+4      	; 0x9e <patternMaskMaker+0x32>
  9a:	36 95       	lsr	r19
  9c:	27 95       	ror	r18
  9e:	4a 95       	dec	r20
  a0:	e2 f7       	brpl	.-8      	; 0x9a <patternMaskMaker+0x2e>
  a2:	2f 70       	andi	r18, 0x0F	; 15
  a4:	33 27       	eor	r19, r19

  if (peiceRow < 0 || peiceRow > 3) // check to see if peiceRow is neg
  a6:	64 30       	cpi	r22, 0x04	; 4
  a8:	b0 f4       	brcc	.+44     	; 0xd6 <patternMaskMaker+0x6a>
  {
    patternMask = 0; // negaitve peiceRow with return 0
  }
  // move bit to right part of the row
  else if (xPos < 0)
  aa:	88 23       	and	r24, r24
  ac:	44 f0       	brlt	.+16     	; 0xbe <patternMaskMaker+0x52>
  {
    patternMask = patternMask >> (xPos * -1);
  }
  else
  {
    patternMask = patternMask << (xPos);
  ae:	a9 01       	movw	r20, r18
  b0:	02 c0       	rjmp	.+4      	; 0xb6 <patternMaskMaker+0x4a>
  b2:	44 0f       	add	r20, r20
  b4:	55 1f       	adc	r21, r21
  b6:	8a 95       	dec	r24
  b8:	e2 f7       	brpl	.-8      	; 0xb2 <patternMaskMaker+0x46>
  ba:	ca 01       	movw	r24, r20
  bc:	08 95       	ret
    patternMask = 0; // negaitve peiceRow with return 0
  }
  // move bit to right part of the row
  else if (xPos < 0)
  {
    patternMask = patternMask >> (xPos * -1);
  be:	99 27       	eor	r25, r25
  c0:	81 95       	neg	r24
  c2:	0c f4       	brge	.+2      	; 0xc6 <patternMaskMaker+0x5a>
  c4:	90 95       	com	r25
  c6:	a9 01       	movw	r20, r18
  c8:	02 c0       	rjmp	.+4      	; 0xce <patternMaskMaker+0x62>
  ca:	56 95       	lsr	r21
  cc:	47 95       	ror	r20
  ce:	8a 95       	dec	r24
  d0:	e2 f7       	brpl	.-8      	; 0xca <patternMaskMaker+0x5e>
  d2:	ca 01       	movw	r24, r20
  d4:	08 95       	ret
  // put bits in correct row
  uint16_t patternMask = ((pattern[peice][rotation] >> ((peiceRow)*4)) & 0xf);

  if (peiceRow < 0 || peiceRow > 3) // check to see if peiceRow is neg
  {
    patternMask = 0; // negaitve peiceRow with return 0
  d6:	90 e0       	ldi	r25, 0x00	; 0
  d8:	80 e0       	ldi	r24, 0x00	; 0
  else
  {
    patternMask = patternMask << (xPos);
  }
  return patternMask;
}
  da:	08 95       	ret

000000dc <validMove>:

// you give the function the new xand y pos to check if they are vaild
// returns 0 if not vaild, return 1 if vaild
uint8_t validMove(int8_t newxPos, int8_t newyPos)
{
  dc:	1f 93       	push	r17
  de:	cf 93       	push	r28
  e0:	df 93       	push	r29
  e2:	18 2f       	mov	r17, r24
  e4:	d6 2f       	mov	r29, r22
  for (int8_t i = 0; i < 4; i++)
  e6:	c0 e0       	ldi	r28, 0x00	; 0
  e8:	03 c0       	rjmp	.+6      	; 0xf0 <validMove+0x14>
  {
    uint16_t patternMask = (patternMaskMaker(newxPos + 2, i));
    if ((newyPos + i) < 0)
    {
      if ((patternMask & 0xffff))
  ea:	89 2b       	or	r24, r25
  ec:	49 f5       	brne	.+82     	; 0x140 <validMove+0x64>

// you give the function the new xand y pos to check if they are vaild
// returns 0 if not vaild, return 1 if vaild
uint8_t validMove(int8_t newxPos, int8_t newyPos)
{
  for (int8_t i = 0; i < 4; i++)
  ee:	cf 5f       	subi	r28, 0xFF	; 255
  f0:	c4 30       	cpi	r28, 0x04	; 4
  f2:	0c f5       	brge	.+66     	; 0x136 <validMove+0x5a>
  {
    uint16_t patternMask = (patternMaskMaker(newxPos + 2, i));
  f4:	6c 2f       	mov	r22, r28
  f6:	82 e0       	ldi	r24, 0x02	; 2
  f8:	81 0f       	add	r24, r17
  fa:	b8 df       	rcall	.-144    	; 0x6c <patternMaskMaker>
    if ((newyPos + i) < 0)
  fc:	2c 2f       	mov	r18, r28
  fe:	0c 2e       	mov	r0, r28
 100:	00 0c       	add	r0, r0
 102:	33 0b       	sbc	r19, r19
 104:	2d 0f       	add	r18, r29
 106:	31 1d       	adc	r19, r1
 108:	d7 fd       	sbrc	r29, 7
 10a:	3a 95       	dec	r19
 10c:	33 23       	and	r19, r19
 10e:	6c f3       	brlt	.-38     	; 0xea <validMove+0xe>
      if ((patternMask & 0xffff))
      {
        return 0;
      }
    }
    else if ((((playFeild[newyPos + i] << 2) | 0xf003) & patternMask))
 110:	22 0f       	add	r18, r18
 112:	33 1f       	adc	r19, r19
 114:	f9 01       	movw	r30, r18
 116:	e8 57       	subi	r30, 0x78	; 120
 118:	f0 4c       	sbci	r31, 0xC0	; 192
 11a:	20 81       	ld	r18, Z
 11c:	31 81       	ldd	r19, Z+1	; 0x01
 11e:	22 0f       	add	r18, r18
 120:	33 1f       	adc	r19, r19
 122:	22 0f       	add	r18, r18
 124:	33 1f       	adc	r19, r19
 126:	23 60       	ori	r18, 0x03	; 3
 128:	30 6f       	ori	r19, 0xF0	; 240
 12a:	82 23       	and	r24, r18
 12c:	93 23       	and	r25, r19
 12e:	89 2b       	or	r24, r25
 130:	f1 f2       	breq	.-68     	; 0xee <validMove+0x12>
    {
      return 0;
 132:	80 e0       	ldi	r24, 0x00	; 0
 134:	01 c0       	rjmp	.+2      	; 0x138 <validMove+0x5c>
    }
  }
  return 1;
 136:	81 e0       	ldi	r24, 0x01	; 1
}
 138:	df 91       	pop	r29
 13a:	cf 91       	pop	r28
 13c:	1f 91       	pop	r17
 13e:	08 95       	ret
    uint16_t patternMask = (patternMaskMaker(newxPos + 2, i));
    if ((newyPos + i) < 0)
    {
      if ((patternMask & 0xffff))
      {
        return 0;
 140:	80 e0       	ldi	r24, 0x00	; 0
 142:	fa cf       	rjmp	.-12     	; 0x138 <validMove+0x5c>

00000144 <gameLogic>:
  return 1;
}

// doing game logic function
void gameLogic()
{
 144:	ef 92       	push	r14
 146:	ff 92       	push	r15
 148:	0f 93       	push	r16
 14a:	1f 93       	push	r17
 14c:	cf 93       	push	r28
 14e:	df 93       	push	r29
  frameCounter++;
 150:	20 91 87 3f 	lds	r18, 0x3F87	; 0x803f87 <frameCounter>
 154:	2f 5f       	subi	r18, 0xFF	; 255
 156:	20 93 87 3f 	sts	0x3F87, r18	; 0x803f87 <frameCounter>
  // checks for user inputs
  buttonStatus = buttonStatus << 4; // holdes states of button from this and last frame
 15a:	80 91 86 3f 	lds	r24, 0x3F86	; 0x803f86 <buttonStatus>
 15e:	82 95       	swap	r24
 160:	80 7f       	andi	r24, 0xF0	; 240
  uint8_t adcRead = ADC0.RESL >> 4; // hold adc value, and lower it resolution
 162:	90 91 10 06 	lds	r25, 0x0610	; 0x800610 <__TEXT_REGION_LENGTH__+0x700610>
 166:	92 95       	swap	r25
 168:	9f 70       	andi	r25, 0x0F	; 15
  uint8_t buttonStatusMask = 0;     // hold state of current button state

  if (adcRead == 0) // button 0 is pressed
 16a:	e9 f0       	breq	.+58     	; 0x1a6 <gameLogic+0x62>
{
  frameCounter++;
  // checks for user inputs
  buttonStatus = buttonStatus << 4; // holdes states of button from this and last frame
  uint8_t adcRead = ADC0.RESL >> 4; // hold adc value, and lower it resolution
  uint8_t buttonStatusMask = 0;     // hold state of current button state
 16c:	30 e0       	ldi	r19, 0x00	; 0

  if (adcRead == 0) // button 0 is pressed
  {
    buttonStatusMask = 8;
  }
  if (adcRead == 8 || adcRead == 7)
 16e:	49 ef       	ldi	r20, 0xF9	; 249
 170:	49 0f       	add	r20, r25
 172:	42 30       	cpi	r20, 0x02	; 2
 174:	d0 f0       	brcs	.+52     	; 0x1aa <gameLogic+0x66>
  {
    buttonStatusMask = 1;
  }
  if ((adcRead > 14))
 176:	9f 30       	cpi	r25, 0x0F	; 15
 178:	08 f0       	brcs	.+2      	; 0x17c <gameLogic+0x38>
  {
    buttonStatusMask = 4;
 17a:	34 e0       	ldi	r19, 0x04	; 4
  }
  if (adcRead == 10)
 17c:	9a 30       	cpi	r25, 0x0A	; 10
 17e:	b9 f0       	breq	.+46     	; 0x1ae <gameLogic+0x6a>
  {
    buttonStatusMask = 2;
  }

  buttonStatus = buttonStatus | buttonStatusMask;
 180:	83 2b       	or	r24, r19
 182:	80 93 86 3f 	sts	0x3F86, r24	; 0x803f86 <buttonStatus>
  int8_t value; // hold the result from validMove to move the piece
  // if (buttonStatusMask)
  //   buttonHoldCount++;

  switch (buttonStatus) //((buttonStatus & 0xf) & ~(buttonStatus >> 4)) //& ~(buttonStatus >> 8))
 186:	88 30       	cpi	r24, 0x08	; 8
 188:	09 f4       	brne	.+2      	; 0x18c <gameLogic+0x48>
 18a:	7e c0       	rjmp	.+252    	; 0x288 <gameLogic+0x144>
 18c:	90 f4       	brcc	.+36     	; 0x1b2 <gameLogic+0x6e>
 18e:	82 30       	cpi	r24, 0x02	; 2
 190:	09 f4       	brne	.+2      	; 0x194 <gameLogic+0x50>
 192:	88 c0       	rjmp	.+272    	; 0x2a4 <gameLogic+0x160>
 194:	84 30       	cpi	r24, 0x04	; 4
 196:	09 f4       	brne	.+2      	; 0x19a <gameLogic+0x56>
 198:	97 c0       	rjmp	.+302    	; 0x2c8 <gameLogic+0x184>
 19a:	81 30       	cpi	r24, 0x01	; 1
 19c:	21 f1       	breq	.+72     	; 0x1e6 <gameLogic+0xa2>
      xPos = xPos - value;
    }
    break;
  case 0x22:
  default:
    DAScount = -1;
 19e:	8f ef       	ldi	r24, 0xFF	; 255
 1a0:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
 1a4:	2d c0       	rjmp	.+90     	; 0x200 <gameLogic+0xbc>
  uint8_t adcRead = ADC0.RESL >> 4; // hold adc value, and lower it resolution
  uint8_t buttonStatusMask = 0;     // hold state of current button state

  if (adcRead == 0) // button 0 is pressed
  {
    buttonStatusMask = 8;
 1a6:	38 e0       	ldi	r19, 0x08	; 8
 1a8:	e2 cf       	rjmp	.-60     	; 0x16e <gameLogic+0x2a>
  }
  if (adcRead == 8 || adcRead == 7)
  {
    buttonStatusMask = 1;
 1aa:	31 e0       	ldi	r19, 0x01	; 1
 1ac:	e4 cf       	rjmp	.-56     	; 0x176 <gameLogic+0x32>
  {
    buttonStatusMask = 4;
  }
  if (adcRead == 10)
  {
    buttonStatusMask = 2;
 1ae:	32 e0       	ldi	r19, 0x02	; 2
 1b0:	e7 cf       	rjmp	.-50     	; 0x180 <gameLogic+0x3c>
  buttonStatus = buttonStatus | buttonStatusMask;
  int8_t value; // hold the result from validMove to move the piece
  // if (buttonStatusMask)
  //   buttonHoldCount++;

  switch (buttonStatus) //((buttonStatus & 0xf) & ~(buttonStatus >> 4)) //& ~(buttonStatus >> 8))
 1b2:	84 34       	cpi	r24, 0x44	; 68
 1b4:	09 f4       	brne	.+2      	; 0x1b8 <gameLogic+0x74>
 1b6:	8f c0       	rjmp	.+286    	; 0x2d6 <gameLogic+0x192>
 1b8:	88 38       	cpi	r24, 0x88	; 136
 1ba:	09 f4       	brne	.+2      	; 0x1be <gameLogic+0x7a>
 1bc:	97 c0       	rjmp	.+302    	; 0x2ec <gameLogic+0x1a8>
 1be:	81 31       	cpi	r24, 0x11	; 17
 1c0:	71 f7       	brne	.-36     	; 0x19e <gameLogic+0x5a>
    frameCounter = updateTime + 1;
    DAScount = 6;
    break;
  case 0x11:
    // hold down button, it will move over every 6 frames
    if (DAScount == 0)
 1c2:	80 91 85 3f 	lds	r24, 0x3F85	; 0x803f85 <DAScount>
 1c6:	81 11       	cpse	r24, r1
 1c8:	1b c0       	rjmp	.+54     	; 0x200 <gameLogic+0xbc>
    {
      DAScount = 6;
 1ca:	86 e0       	ldi	r24, 0x06	; 6
 1cc:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
      value = validMove(xPos + 1, yPos);
 1d0:	c0 91 80 3f 	lds	r28, 0x3F80	; 0x803f80 <__data_start>
 1d4:	60 91 81 3f 	lds	r22, 0x3F81	; 0x803f81 <yPos>
 1d8:	81 e0       	ldi	r24, 0x01	; 1
 1da:	8c 0f       	add	r24, r28
 1dc:	7f df       	rcall	.-258    	; 0xdc <validMove>
      xPos = xPos + value;
 1de:	8c 0f       	add	r24, r28
 1e0:	80 93 80 3f 	sts	0x3F80, r24	; 0x803f80 <__data_start>
 1e4:	0d c0       	rjmp	.+26     	; 0x200 <gameLogic+0xbc>
  //   buttonHoldCount++;

  switch (buttonStatus) //((buttonStatus & 0xf) & ~(buttonStatus >> 4)) //& ~(buttonStatus >> 8))
  {
  case 1:
    value = validMove(xPos + 1, yPos);
 1e6:	c0 91 80 3f 	lds	r28, 0x3F80	; 0x803f80 <__data_start>
 1ea:	60 91 81 3f 	lds	r22, 0x3F81	; 0x803f81 <yPos>
 1ee:	81 e0       	ldi	r24, 0x01	; 1
 1f0:	8c 0f       	add	r24, r28
 1f2:	74 df       	rcall	.-280    	; 0xdc <validMove>
    xPos = xPos + value;
 1f4:	8c 0f       	add	r24, r28
 1f6:	80 93 80 3f 	sts	0x3F80, r24	; 0x803f80 <__data_start>
    DAScount = 16;
 1fa:	80 e1       	ldi	r24, 0x10	; 16
 1fc:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
  default:
    DAScount = -1;
    // buttonHoldCount--;
  }

  if (DAScount > 0)
 200:	80 91 85 3f 	lds	r24, 0x3F85	; 0x803f85 <DAScount>
 204:	18 16       	cp	r1, r24
 206:	1c f4       	brge	.+6      	; 0x20e <gameLogic+0xca>
  {
    DAScount--;
 208:	81 50       	subi	r24, 0x01	; 1
 20a:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
  }

  // cycle is down
  if (frameCounter > updateTime)
 20e:	80 91 87 3f 	lds	r24, 0x3F87	; 0x803f87 <frameCounter>
 212:	81 33       	cpi	r24, 0x31	; 49
 214:	08 f4       	brcc	.+2      	; 0x218 <gameLogic+0xd4>
 216:	b0 c0       	rjmp	.+352    	; 0x378 <gameLogic+0x234>
  {
    frameCounter = 0;
 218:	10 92 87 3f 	sts	0x3F87, r1	; 0x803f87 <frameCounter>
    peiceCounter++;
 21c:	d0 91 83 3f 	lds	r29, 0x3F83	; 0x803f83 <peiceCounter>
 220:	df 5f       	subi	r29, 0xFF	; 255
 222:	d0 93 83 3f 	sts	0x3F83, r29	; 0x803f83 <peiceCounter>
    value = validMove(xPos, yPos - 1);
 226:	c0 91 81 3f 	lds	r28, 0x3F81	; 0x803f81 <yPos>
 22a:	6f ef       	ldi	r22, 0xFF	; 255
 22c:	6c 0f       	add	r22, r28
 22e:	e0 90 80 3f 	lds	r14, 0x3F80	; 0x803f80 <__data_start>
 232:	8e 2d       	mov	r24, r14
 234:	53 df       	rcall	.-346    	; 0xdc <validMove>
    yPos = yPos - value;
 236:	c8 1b       	sub	r28, r24
 238:	c0 93 81 3f 	sts	0x3F81, r28	; 0x803f81 <yPos>
    if (!value) // when piece cant move down
 23c:	81 11       	cpse	r24, r1
 23e:	9c c0       	rjmp	.+312    	; 0x378 <gameLogic+0x234>
    {
      DAScount = -1;
 240:	8f ef       	ldi	r24, 0xFF	; 255
 242:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
      // updatePlayField(xPos, yPos);

      // update the play feild
      uint16_t patternMask;
      for (int8_t i = 0; i <= 3; i++)
 246:	f1 2c       	mov	r15, r1
 248:	23 e0       	ldi	r18, 0x03	; 3
 24a:	2f 15       	cp	r18, r15
 24c:	0c f4       	brge	.+2      	; 0x250 <gameLogic+0x10c>
 24e:	60 c0       	rjmp	.+192    	; 0x310 <gameLogic+0x1cc>
      {
        if (yPos + i > 19) // prevenct messing with data outside of playfeild
 250:	0f 2d       	mov	r16, r15
 252:	0f 2c       	mov	r0, r15
 254:	00 0c       	add	r0, r0
 256:	11 0b       	sbc	r17, r17
 258:	0c 0f       	add	r16, r28
 25a:	11 1d       	adc	r17, r1
 25c:	c7 fd       	sbrc	r28, 7
 25e:	1a 95       	dec	r17
 260:	04 31       	cpi	r16, 0x14	; 20
 262:	11 05       	cpc	r17, r1
 264:	0c f0       	brlt	.+2      	; 0x268 <gameLogic+0x124>
 266:	74 c0       	rjmp	.+232    	; 0x350 <gameLogic+0x20c>
          break;
        patternMask = patternMaskMaker(xPos, i);
 268:	6f 2d       	mov	r22, r15
 26a:	8e 2d       	mov	r24, r14
 26c:	ff de       	rcall	.-514    	; 0x6c <patternMaskMaker>
        playFeild[yPos + i] = playFeild[yPos + i] | patternMask;
 26e:	00 0f       	add	r16, r16
 270:	11 1f       	adc	r17, r17
 272:	f8 01       	movw	r30, r16
 274:	e8 57       	subi	r30, 0x78	; 120
 276:	f0 4c       	sbci	r31, 0xC0	; 192
 278:	20 81       	ld	r18, Z
 27a:	31 81       	ldd	r19, Z+1	; 0x01
 27c:	82 2b       	or	r24, r18
 27e:	93 2b       	or	r25, r19
 280:	80 83       	st	Z, r24
 282:	91 83       	std	Z+1, r25	; 0x01
      DAScount = -1;
      // updatePlayField(xPos, yPos);

      // update the play feild
      uint16_t patternMask;
      for (int8_t i = 0; i <= 3; i++)
 284:	f3 94       	inc	r15
 286:	e0 cf       	rjmp	.-64     	; 0x248 <gameLogic+0x104>
    value = validMove(xPos + 1, yPos);
    xPos = xPos + value;
    DAScount = 16;
    break;
  case 8:
    value = validMove(xPos - 1, yPos);
 288:	c0 91 80 3f 	lds	r28, 0x3F80	; 0x803f80 <__data_start>
 28c:	60 91 81 3f 	lds	r22, 0x3F81	; 0x803f81 <yPos>
 290:	8f ef       	ldi	r24, 0xFF	; 255
 292:	8c 0f       	add	r24, r28
 294:	23 df       	rcall	.-442    	; 0xdc <validMove>
    xPos = xPos - value;
 296:	c8 1b       	sub	r28, r24
 298:	c0 93 80 3f 	sts	0x3F80, r28	; 0x803f80 <__data_start>
    DAScount = 16;
 29c:	80 e1       	ldi	r24, 0x10	; 16
 29e:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
 2a2:	ae cf       	rjmp	.-164    	; 0x200 <gameLogic+0xbc>
    break;
  case 2:
    rotation++;
 2a4:	c0 91 84 3f 	lds	r28, 0x3F84	; 0x803f84 <rotation>
 2a8:	cf 5f       	subi	r28, 0xFF	; 255
    rotation = rotation & 3;
 2aa:	c3 70       	andi	r28, 0x03	; 3
 2ac:	c0 93 84 3f 	sts	0x3F84, r28	; 0x803f84 <rotation>
    if (validMove(xPos, yPos) == 0) //    if (validMove(xPos, yPos) != 1)
 2b0:	60 91 81 3f 	lds	r22, 0x3F81	; 0x803f81 <yPos>
 2b4:	80 91 80 3f 	lds	r24, 0x3F80	; 0x803f80 <__data_start>
 2b8:	11 df       	rcall	.-478    	; 0xdc <validMove>
 2ba:	81 11       	cpse	r24, r1
 2bc:	a1 cf       	rjmp	.-190    	; 0x200 <gameLogic+0xbc>
    {
      rotation = rotation + 3;
 2be:	cd 5f       	subi	r28, 0xFD	; 253
      rotation = rotation & 3;
 2c0:	c3 70       	andi	r28, 0x03	; 3
 2c2:	c0 93 84 3f 	sts	0x3F84, r28	; 0x803f84 <rotation>
 2c6:	9c cf       	rjmp	.-200    	; 0x200 <gameLogic+0xbc>
    }
    break;
  case 4:
    frameCounter = updateTime + 1;
 2c8:	81 e3       	ldi	r24, 0x31	; 49
 2ca:	80 93 87 3f 	sts	0x3F87, r24	; 0x803f87 <frameCounter>
    DAScount = 6;
 2ce:	86 e0       	ldi	r24, 0x06	; 6
 2d0:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
 2d4:	95 cf       	rjmp	.-214    	; 0x200 <gameLogic+0xbc>
      xPos = xPos + value;
    }
    break;
  case 0x44:
    // hold down button, it will drop down every other frame
    if (frameCounter > 0 && DAScount == 0)
 2d6:	22 23       	and	r18, r18
 2d8:	09 f4       	brne	.+2      	; 0x2dc <gameLogic+0x198>
 2da:	92 cf       	rjmp	.-220    	; 0x200 <gameLogic+0xbc>
 2dc:	80 91 85 3f 	lds	r24, 0x3F85	; 0x803f85 <DAScount>
 2e0:	81 11       	cpse	r24, r1
 2e2:	8e cf       	rjmp	.-228    	; 0x200 <gameLogic+0xbc>
    {
      frameCounter = updateTime + 1;
 2e4:	81 e3       	ldi	r24, 0x31	; 49
 2e6:	80 93 87 3f 	sts	0x3F87, r24	; 0x803f87 <frameCounter>
 2ea:	8a cf       	rjmp	.-236    	; 0x200 <gameLogic+0xbc>
    }
    break;
  case 0x88:
    // hold down button, it will move over every 6 frames
    if (DAScount == 0)
 2ec:	80 91 85 3f 	lds	r24, 0x3F85	; 0x803f85 <DAScount>
 2f0:	81 11       	cpse	r24, r1
 2f2:	86 cf       	rjmp	.-244    	; 0x200 <gameLogic+0xbc>
    {
      DAScount = 6;
 2f4:	86 e0       	ldi	r24, 0x06	; 6
 2f6:	80 93 85 3f 	sts	0x3F85, r24	; 0x803f85 <DAScount>
      value = validMove(xPos - 1, yPos);
 2fa:	c0 91 80 3f 	lds	r28, 0x3F80	; 0x803f80 <__data_start>
 2fe:	60 91 81 3f 	lds	r22, 0x3F81	; 0x803f81 <yPos>
 302:	8f ef       	ldi	r24, 0xFF	; 255
 304:	8c 0f       	add	r24, r28
 306:	ea de       	rcall	.-556    	; 0xdc <validMove>
      xPos = xPos - value;
 308:	c8 1b       	sub	r28, r24
 30a:	c0 93 80 3f 	sts	0x3F80, r28	; 0x803f80 <__data_start>
 30e:	78 cf       	rjmp	.-272    	; 0x200 <gameLogic+0xbc>
      DAScount = -1;
      // updatePlayField(xPos, yPos);

      // update the play feild
      uint16_t patternMask;
      for (int8_t i = 0; i <= 3; i++)
 310:	4c 2f       	mov	r20, r28
 312:	01 c0       	rjmp	.+2      	; 0x316 <gameLogic+0x1d2>
        playFeild[yPos + i] = playFeild[yPos + i] | patternMask;
      }

      // check if playfeild has any full rows
      int8_t i, count = yPos; // i is for for loop and count is what row to put it on
      for (i = yPos; i < 20; i++)
 314:	cf 5f       	subi	r28, 0xFF	; 255
 316:	c4 31       	cpi	r28, 0x14	; 20
 318:	ec f4       	brge	.+58     	; 0x354 <gameLogic+0x210>
      {
        // when row is full, go to begining of loop
        if ((playFeild[i] & 0x03ff) == 0x03ff) // when
 31a:	ec 2f       	mov	r30, r28
 31c:	ee 0f       	add	r30, r30
 31e:	ff 0b       	sbc	r31, r31
 320:	e8 57       	subi	r30, 0x78	; 120
 322:	f0 4c       	sbci	r31, 0xC0	; 192
 324:	80 81       	ld	r24, Z
 326:	91 81       	ldd	r25, Z+1	; 0x01
 328:	93 70       	andi	r25, 0x03	; 3
 32a:	8f 3f       	cpi	r24, 0xFF	; 255
 32c:	23 e0       	ldi	r18, 0x03	; 3
 32e:	92 07       	cpc	r25, r18
 330:	89 f3       	breq	.-30     	; 0x314 <gameLogic+0x1d0>
        {
          continue;
        }
        // put i pointer into count pointer
        playFeild[count] = (playFeild[count] & ~0x03ff) | (playFeild[i] & 0x03ff);
 332:	e4 2f       	mov	r30, r20
 334:	ee 0f       	add	r30, r30
 336:	ff 0b       	sbc	r31, r31
 338:	e8 57       	subi	r30, 0x78	; 120
 33a:	f0 4c       	sbci	r31, 0xC0	; 192
 33c:	20 81       	ld	r18, Z
 33e:	31 81       	ldd	r19, Z+1	; 0x01
 340:	22 27       	eor	r18, r18
 342:	3c 7f       	andi	r19, 0xFC	; 252
 344:	82 2b       	or	r24, r18
 346:	93 2b       	or	r25, r19
 348:	80 83       	st	Z, r24
 34a:	91 83       	std	Z+1, r25	; 0x01
        count++; // update count pointer
 34c:	4f 5f       	subi	r20, 0xFF	; 255
 34e:	e2 cf       	rjmp	.-60     	; 0x314 <gameLogic+0x1d0>

      // update the play feild
      uint16_t patternMask;
      for (int8_t i = 0; i <= 3; i++)
      {
        if (yPos + i > 19) // prevenct messing with data outside of playfeild
 350:	4c 2f       	mov	r20, r28
 352:	e1 cf       	rjmp	.-62     	; 0x316 <gameLogic+0x1d2>
        count++; // update count pointer
      }
      // return i - count;

      // setup piece for next cylce
      xPos = 3;
 354:	83 e0       	ldi	r24, 0x03	; 3
 356:	80 93 80 3f 	sts	0x3F80, r24	; 0x803f80 <__data_start>
      yPos = i; // yPos = i;
 35a:	c0 93 81 3f 	sts	0x3F81, r28	; 0x803f81 <yPos>
      peice = (peiceCounter >> 2);
 35e:	8d 2f       	mov	r24, r29
 360:	86 95       	lsr	r24
 362:	86 95       	lsr	r24
 364:	80 93 82 3f 	sts	0x3F82, r24	; 0x803f82 <__data_end>
      if (peice > 6)
 368:	87 30       	cpi	r24, 0x07	; 7
 36a:	18 f0       	brcs	.+6      	; 0x372 <gameLogic+0x22e>
        peice = peice - 7;
 36c:	87 50       	subi	r24, 0x07	; 7
 36e:	80 93 82 3f 	sts	0x3F82, r24	; 0x803f82 <__data_end>
      rotation = peiceCounter & 3;
 372:	d3 70       	andi	r29, 0x03	; 3
 374:	d0 93 84 3f 	sts	0x3F84, r29	; 0x803f84 <rotation>
    }
  }
  if ((peiceCounter >> 2) == 7)
 378:	80 91 83 3f 	lds	r24, 0x3F83	; 0x803f83 <peiceCounter>
 37c:	86 95       	lsr	r24
 37e:	86 95       	lsr	r24
 380:	87 30       	cpi	r24, 0x07	; 7
 382:	51 f0       	breq	.+20     	; 0x398 <gameLogic+0x254>
  {
    peiceCounter = 0;
  }
  // status = 0;
  rowCycleCounter = 29;
 384:	8d e1       	ldi	r24, 0x1D	; 29
 386:	80 93 b3 3f 	sts	0x3FB3, r24	; 0x803fb3 <rowCycleCounter>
  playFeild[10] = (playFeild[10] & 0x03ff) | (yPos << 10);                                                        // display y value
  playFeild[11] = (playFeild[11] & 0x03ff) | (xPos << 10);
  playFeild[12] = (playFeild[12] & 0x03ff) | ((adcRead & 0b00001111) << 10);        // display x value
  playFeild[13] = (playFeild[13] & 0x03ff) | ((adcRead & ~0b00001111) << (10 - 4)); // display x value
#endif
}
 38a:	df 91       	pop	r29
 38c:	cf 91       	pop	r28
 38e:	1f 91       	pop	r17
 390:	0f 91       	pop	r16
 392:	ff 90       	pop	r15
 394:	ef 90       	pop	r14
 396:	08 95       	ret
      rotation = peiceCounter & 3;
    }
  }
  if ((peiceCounter >> 2) == 7)
  {
    peiceCounter = 0;
 398:	10 92 83 3f 	sts	0x3F83, r1	; 0x803f83 <peiceCounter>
 39c:	f3 cf       	rjmp	.-26     	; 0x384 <gameLogic+0x240>

0000039e <__vector_12>:
  TCA0.SINGLE.INTFLAGS = TCA_SINGLE_CMP1_bm;
}

// vsync off
ISR(TCA0_CMP2_vect)
{
 39e:	1f 92       	push	r1
 3a0:	0f 92       	push	r0
 3a2:	0f b6       	in	r0, 0x3f	; 63
 3a4:	0f 92       	push	r0
 3a6:	11 24       	eor	r1, r1
 3a8:	2f 93       	push	r18
 3aa:	3f 93       	push	r19
 3ac:	4f 93       	push	r20
 3ae:	5f 93       	push	r21
 3b0:	6f 93       	push	r22
 3b2:	7f 93       	push	r23
 3b4:	8f 93       	push	r24
 3b6:	9f 93       	push	r25
 3b8:	af 93       	push	r26
 3ba:	bf 93       	push	r27
 3bc:	ef 93       	push	r30
 3be:	ff 93       	push	r31
  VPORTA.DIR = COLOR_PIN; // disable the vsync output
 3c0:	80 e8       	ldi	r24, 0x80	; 128
 3c2:	80 b9       	out	0x00, r24	; 0
  TCA0.SINGLE.INTFLAGS = TCA_SINGLE_CMP2_bm;
 3c4:	80 e4       	ldi	r24, 0x40	; 64
 3c6:	80 93 0b 0a 	sts	0x0A0B, r24	; 0x800a0b <__TEXT_REGION_LENGTH__+0x700a0b>
  gameLogic(); // starts doing the game logic
 3ca:	bc de       	rcall	.-648    	; 0x144 <gameLogic>
}
 3cc:	ff 91       	pop	r31
 3ce:	ef 91       	pop	r30
 3d0:	bf 91       	pop	r27
 3d2:	af 91       	pop	r26
 3d4:	9f 91       	pop	r25
 3d6:	8f 91       	pop	r24
 3d8:	7f 91       	pop	r23
 3da:	6f 91       	pop	r22
 3dc:	5f 91       	pop	r21
 3de:	4f 91       	pop	r20
 3e0:	3f 91       	pop	r19
 3e2:	2f 91       	pop	r18
 3e4:	0f 90       	pop	r0
 3e6:	0f be       	out	0x3f, r0	; 63
 3e8:	0f 90       	pop	r0
 3ea:	1f 90       	pop	r1
 3ec:	18 95       	reti

000003ee <__vector_11>:
  }
}

// vsync on
ISR(TCA0_CMP1_vect)
{
 3ee:	1f 92       	push	r1
 3f0:	0f 92       	push	r0
 3f2:	0f b6       	in	r0, 0x3f	; 63
 3f4:	0f 92       	push	r0
 3f6:	11 24       	eor	r1, r1
 3f8:	8f 93       	push	r24
  VPORTA.DIR = VSYNC_PIN | COLOR_PIN; // enable the vsync output (PIN7_bm is to save flash in main)
 3fa:	82 e8       	ldi	r24, 0x82	; 130
 3fc:	80 b9       	out	0x00, r24	; 0
  TCA0.SINGLE.INTFLAGS = TCA_SINGLE_CMP1_bm;
 3fe:	80 e2       	ldi	r24, 0x20	; 32
 400:	80 93 0b 0a 	sts	0x0A0B, r24	; 0x800a0b <__TEXT_REGION_LENGTH__+0x700a0b>
}
 404:	8f 91       	pop	r24
 406:	0f 90       	pop	r0
 408:	0f be       	out	0x3f, r0	; 63
 40a:	0f 90       	pop	r0
 40c:	1f 90       	pop	r1
 40e:	18 95       	reti

00000410 <main>:
  // for (uint8_t i = 0; i < 8; i++)
  // {
  //   *((uint8_t *)&PORTA + 0x10 + i) |= 1 << PORT_PULLUPEN_bp;
  // }
  // make currently unsed pin as pullups
  PORTA.PIN0CTRL = PORT_PULLUPEN_bm;
 410:	e0 e0       	ldi	r30, 0x00	; 0
 412:	f4 e0       	ldi	r31, 0x04	; 4
 414:	08 e0       	ldi	r16, 0x08	; 8
 416:	00 8b       	std	Z+16, r16	; 0x10
  PORTA.PIN3CTRL = PORT_PULLUPEN_bm;
 418:	03 8b       	std	Z+19, r16	; 0x13

  // set up v sync counter
  TCA0.SINGLE.CMP0 = 600; /* Compare Register 0: 0x258 */
 41a:	e0 e0       	ldi	r30, 0x00	; 0
 41c:	fa e0       	ldi	r31, 0x0A	; 10
 41e:	88 e5       	ldi	r24, 0x58	; 88
 420:	92 e0       	ldi	r25, 0x02	; 2
 422:	80 a7       	std	Z+40, r24	; 0x28
 424:	91 a7       	std	Z+41, r25	; 0x29
  TCA0.SINGLE.CMP1 = 601; /* Compare Register 1: 0x259 */
 426:	89 e5       	ldi	r24, 0x59	; 89
 428:	92 e0       	ldi	r25, 0x02	; 2
 42a:	82 a7       	std	Z+42, r24	; 0x2a
 42c:	93 a7       	std	Z+43, r25	; 0x2b
  TCA0.SINGLE.CMP2 = 605; /* Compare Register 2: 0x25d */
 42e:	8d e5       	ldi	r24, 0x5D	; 93
 430:	92 e0       	ldi	r25, 0x02	; 2
 432:	84 a7       	std	Z+44, r24	; 0x2c
 434:	95 a7       	std	Z+45, r25	; 0x2d
  // TCA0.SINGLE.CNT = 0x0; /* Count: 0x0 */
  TCA0.SINGLE.CTRLB = 0 << TCA_SINGLE_ALUPD_bp       /* Auto Lock Update: disabled */
 436:	80 e6       	ldi	r24, 0x60	; 96
 438:	81 83       	std	Z+1, r24	; 0x01
                      | TCA_SINGLE_WGMODE_NORMAL_gc; /*  */
  // TCA0.SINGLE.CTRLC = 0 << TCA_SINGLE_CMP0OV_bp /* Compare 0 Waveform Output Value: disabled */
  //		 | 0 << TCA_SINGLE_CMP1OV_bp /* Compare 1 Waveform Output Value: disabled */
  //		 | 0 << TCA_SINGLE_CMP2OV_bp; /* Compare 2 Waveform Output Value: disabled */
  // TCA0.SINGLE.DBGCTRL = 0 << TCA_SINGLE_DBGRUN_bp; /* Debug Run: disabled */
  TCA0.SINGLE.EVCTRL = 1 << TCA_SINGLE_CNTEI_bp /* Count on Event Input: enabled */
 43a:	11 e0       	ldi	r17, 0x01	; 1
 43c:	11 87       	std	Z+9, r17	; 0x09
                       | TCA_SINGLE_EVACT_POSEDGE_gc /* Count on positive edge event */;
  TCA0.SINGLE.INTCTRL = 0 << TCA_SINGLE_CMP0_bp   /* Compare 0 Interrupt: enabled */
 43e:	82 87       	std	Z+10, r24	; 0x0a
                        | 1 << TCA_SINGLE_CMP1_bp /* Compare 1 Interrupt: enabled */
                        | 1 << TCA_SINGLE_CMP2_bp /* Compare 2 Interrupt: enabled */
                        | 0 << TCA_SINGLE_OVF_bp; /* Overflow Interrupt: enabled */
  TCA0.SINGLE.PER = 627;                          // should be 627 or 628
 440:	83 e7       	ldi	r24, 0x73	; 115
 442:	92 e0       	ldi	r25, 0x02	; 2
 444:	86 a3       	std	Z+38, r24	; 0x26
 446:	97 a3       	std	Z+39, r25	; 0x27
  TCA0.SINGLE.CTRLA = TCA_SINGLE_CLKSEL_DIV1_gc   /* System Clock */
 448:	10 83       	st	Z, r17
                      | 1 << TCA_SINGLE_ENABLE_bp /* Module Enable: enabled */;

  // Enable Protected register, peripheral must be disabled (ENABLE=0, in TCD.CTRLA).
  // set up hscyn counter/pin
  TCD0.CMPASET = 420;                    /* Compare A Set: 420 */
 44a:	c0 e8       	ldi	r28, 0x80	; 128
 44c:	da e0       	ldi	r29, 0x0A	; 10
 44e:	84 ea       	ldi	r24, 0xA4	; 164
 450:	91 e0       	ldi	r25, 0x01	; 1
 452:	88 a7       	std	Y+40, r24	; 0x28
 454:	99 a7       	std	Y+41, r25	; 0x29
  TCD0.CMPACLR = 484;                    /* Compare A Clear: 484 */
 456:	84 ee       	ldi	r24, 0xE4	; 228
 458:	91 e0       	ldi	r25, 0x01	; 1
 45a:	8a a7       	std	Y+42, r24	; 0x2a
 45c:	9b a7       	std	Y+43, r25	; 0x2b
  TCD0.CMPBSET = 400;                    /* Compare B Set: 400 */
 45e:	80 e9       	ldi	r24, 0x90	; 144
 460:	91 e0       	ldi	r25, 0x01	; 1
 462:	8c a7       	std	Y+44, r24	; 0x2c
 464:	9d a7       	std	Y+45, r25	; 0x2d
  TCD0.CMPBCLR = 528;                    /* Compare B Clear: 528 */
 466:	80 e1       	ldi	r24, 0x10	; 16
 468:	92 e0       	ldi	r25, 0x02	; 2
 46a:	8e a7       	std	Y+46, r24	; 0x2e
 46c:	9f a7       	std	Y+47, r25	; 0x2f
  TCD0.EVCTRLB = TCD_CFG_NEITHER_gc      /* Neither Filter nor Asynchronous Event is enabled */
 46e:	84 e1       	ldi	r24, 0x14	; 20
 470:	89 87       	std	Y+9, r24	; 0x09
                 | TCD_ACTION_CAPTURE_gc /* Event trigger a fault and capture */
                 | TCD_EDGE_RISE_HIGH_gc /* The rising edge or high level of event generates retrigger or fault action */
                 | 0 << TCD_TRIGEI_bp;   /* Trigger event enable: disabled */

  ccp_write_io((void *)&(TCD0.FAULTCTRL),
 472:	60 e1       	ldi	r22, 0x10	; 16
 474:	70 e0       	ldi	r23, 0x00	; 0
 476:	82 e9       	ldi	r24, 0x92	; 146
 478:	9a e0       	ldi	r25, 0x0A	; 10
 47a:	9a d0       	rcall	.+308    	; 0x5b0 <ccp_write_io>
                   | 0 << TCD_CMPBEN_bp /* Compare B enable: disabled */
                   | 0 << TCD_CMPC_bp   /* Compare C value: disabled */
                   | 0 << TCD_CMPCEN_bp /* Compare C enable: disabled */
                   | 0 << TCD_CMPD_bp   /* Compare D vaule: disabled */
                   | 0 << TCD_CMPDEN_bp /* Compare D enable: disabled */);
  TCD0.INTCTRL = 1 << TCD_OVF_bp      /* Overflow interrupt enable: enabled */
 47c:	1c 87       	std	Y+12, r17	; 0x0c
                 | 0 << TCD_TRIGA_bp  /* Trigger A interrupt enable: enabled */
                 | 0 << TCD_TRIGB_bp; /* Trigger B interrupt enable: enabled */
  // while ((TCD0.STATUS & TCD_ENRDY_bm) == 0)
  //   ; // Wait for Enable Ready to be high.

  TCD0.CTRLA = 1 << TCD_ENABLE_bp      /* Enable: enabled */
 47e:	81 e6       	ldi	r24, 0x61	; 97
 480:	88 83       	st	Y, r24

  // CPUINT.LVL0PRI = 0x0 << CPUINT_LVL0PRI_gp; /* Interrupt Level Priority: 0x0 */

  // CPUINT.LVL1VEC = 0x0 << CPUINT_LVL1VEC_gp; /* Interrupt Vector with High Priority: 0x0 */

  ENABLE_INTERRUPTS();
 482:	78 94       	sei
  // set up clock
  ccp_write_io((void *)&(CLKCTRL.MCLKCTRLB),
 484:	60 e1       	ldi	r22, 0x10	; 16
 486:	70 e0       	ldi	r23, 0x00	; 0
 488:	81 e6       	ldi	r24, 0x61	; 97
 48a:	90 e0       	ldi	r25, 0x00	; 0
 48c:	91 d0       	rcall	.+290    	; 0x5b0 <ccp_write_io>
               CLKCTRL_PDIV_6X_gc /* 6 */
                   | 0 << CLKCTRL_PEN_bp /* Prescaler enable: disabled */);
  // atmel_start_init();

  // set up events,
  EVSYS.SYNCCH0 = EVSYS_SYNCCH0_PORTA_PIN6_gc;  /* Synchronous Event from Pin PA6 */
 48e:	e0 e8       	ldi	r30, 0x80	; 128
 490:	f1 e0       	ldi	r31, 0x01	; 1
 492:	83 e1       	ldi	r24, 0x13	; 19
 494:	82 87       	std	Z+10, r24	; 0x0a
  EVSYS.SYNCCH1 = EVSYS_SYNCCH1_PORTB_PIN0_gc;  /* Synchronous Event from Pin PB0 */
 496:	03 87       	std	Z+11, r16	; 0x0b
  EVSYS.SYNCUSER0 = EVSYS_SYNCUSER0_SYNCCH0_gc; /* Synchronous Event Channel 0 */
 498:	12 a3       	std	Z+34, r17	; 0x22

  // setting up ADC now happens in TCD0 OVF int to save space
  // set up adc/button pin
  // PORTA.PIN2CTRL = 0x4; // set pin 2 to disable digital input
  ADC0.CTRLA = 0b00000111;
 49a:	e0 e0       	ldi	r30, 0x00	; 0
 49c:	f6 e0       	ldi	r31, 0x06	; 6
 49e:	87 e0       	ldi	r24, 0x07	; 7
 4a0:	80 83       	st	Z, r24
  // ADC0.CTRLB = 1;
  ADC0.CTRLC = 0b01010011;
 4a2:	83 e5       	ldi	r24, 0x53	; 83
 4a4:	82 83       	std	Z+2, r24	; 0x02
  // ADC0.CTRLD = 0b00010000;
  SLPCTRL.CTRLA = 1; // enable sleep
 4a6:	10 93 50 00 	sts	0x0050, r17	; 0x800050 <__TEXT_REGION_LENGTH__+0x700050>
  // ADC0.COMMAND = 1;   // adc start running

  while (1)
  {
    // go to sleep
    asm volatile(
 4aa:	88 95       	sleep
 4ac:	fe cf       	rjmp	.-4      	; 0x4aa <main+0x9a>

000004ae <__vector_14>:
#endif
}

// trigger at the begining of every scanline
ISR(TCD0_OVF_vect)
{
 4ae:	1f 92       	push	r1
 4b0:	0f 92       	push	r0
 4b2:	0f b6       	in	r0, 0x3f	; 63
 4b4:	0f 92       	push	r0
 4b6:	11 24       	eor	r1, r1
 4b8:	2f 93       	push	r18
 4ba:	3f 93       	push	r19
 4bc:	4f 93       	push	r20
 4be:	5f 93       	push	r21
 4c0:	6f 93       	push	r22
 4c2:	7f 93       	push	r23
 4c4:	8f 93       	push	r24
 4c6:	9f 93       	push	r25
 4c8:	af 93       	push	r26
 4ca:	bf 93       	push	r27
 4cc:	ef 93       	push	r30
 4ce:	ff 93       	push	r31
  if (TCA0.SINGLE.CNT < 600)
 4d0:	80 91 20 0a 	lds	r24, 0x0A20	; 0x800a20 <__TEXT_REGION_LENGTH__+0x700a20>
 4d4:	90 91 21 0a 	lds	r25, 0x0A21	; 0x800a21 <__TEXT_REGION_LENGTH__+0x700a21>
 4d8:	88 35       	cpi	r24, 0x58	; 88
 4da:	92 40       	sbci	r25, 0x02	; 2
 4dc:	08 f0       	brcs	.+2      	; 0x4e0 <__vector_14+0x32>
 4de:	38 c0       	rjmp	.+112    	; 0x550 <next+0x1e>
  {
    if (TCA0.SINGLE.CNT == 0)
 4e0:	80 91 20 0a 	lds	r24, 0x0A20	; 0x800a20 <__TEXT_REGION_LENGTH__+0x700a20>
 4e4:	90 91 21 0a 	lds	r25, 0x0A21	; 0x800a21 <__TEXT_REGION_LENGTH__+0x700a21>
 4e8:	89 2b       	or	r24, r25
 4ea:	11 f4       	brne	.+4      	; 0x4f0 <__vector_14+0x42>
    {
      rowCycleCounter = 0;
 4ec:	10 92 b3 3f 	sts	0x3FB3, r1	; 0x803fb3 <rowCycleCounter>
    }
    if ((rowCycleCounter) <= (1))
 4f0:	80 91 b3 3f 	lds	r24, 0x3FB3	; 0x803fb3 <rowCycleCounter>
 4f4:	82 30       	cpi	r24, 0x02	; 2
 4f6:	0c f4       	brge	.+2      	; 0x4fa <__vector_14+0x4c>
 4f8:	3f c0       	rjmp	.+126    	; 0x578 <next+0x46>
        patternMask = patternMaskMaker(xPos, row - yPos);
      }
    }
    else
    {
      uint16_t feildDisplay = playFeild[row] | (patternMask);
 4fa:	e0 91 b2 3f 	lds	r30, 0x3FB2	; 0x803fb2 <row>
 4fe:	ee 0f       	add	r30, r30
 500:	ff 0b       	sbc	r31, r31
 502:	e8 57       	subi	r30, 0x78	; 120
 504:	f0 4c       	sbci	r31, 0xC0	; 192
 506:	80 81       	ld	r24, Z
 508:	91 81       	ldd	r25, Z+1	; 0x01
 50a:	20 91 b0 3f 	lds	r18, 0x3FB0	; 0x803fb0 <patternMask>
 50e:	30 91 b1 3f 	lds	r19, 0x3FB1	; 0x803fb1 <patternMask+0x1>
 512:	82 2b       	or	r24, r18
 514:	93 2b       	or	r25, r19
      uint8_t i = 0; // used for asm for loop, for some reson it not set to 0
      // VPORTA_OUT = 0;
      // display the block and takes 15 clock cycles or 30 pixes
      asm volatile(
 516:	0f 9a       	sbi	0x01, 7	; 1
 518:	22 27       	eor	r18, r18

0000051a <loop>:
 51a:	2a 30       	cpi	r18, 0x0A	; 10
 51c:	51 f0       	breq	.+20     	; 0x532 <next>
 51e:	80 fb       	bst	r24, 0
 520:	86 95       	lsr	r24
 522:	87 f9       	bld	r24, 7
 524:	0f 98       	cbi	0x01, 7	; 1
 526:	81 b9       	out	0x01, r24	; 1
 528:	90 fb       	bst	r25, 0
 52a:	96 95       	lsr	r25
 52c:	87 f9       	bld	r24, 7
 52e:	23 95       	inc	r18
 530:	f4 cf       	rjmp	.-24     	; 0x51a <loop>

00000532 <next>:
 532:	00 00       	nop
 534:	0f 98       	cbi	0x01, 7	; 1
 536:	0f 9a       	sbi	0x01, 7	; 1
 538:	e0 e0       	ldi	r30, 0x00	; 0
 53a:	f6 e0       	ldi	r31, 0x06	; 6
 53c:	21 e0       	ldi	r18, 0x01	; 1
 53e:	20 87       	std	Z+8, r18	; 0x08
 540:	22 e0       	ldi	r18, 0x02	; 2
 542:	26 83       	std	Z+6, r18	; 0x06
 544:	21 b9       	out	0x01, r18	; 1
          // "cbi 0x01, 7\n" // turn off output (looks nicer)    (1 cycle)
          : "+r"((uint16_t)(feildDisplay)), "=r"((uint8_t)(i)));
      VPORTA_OUT = 0;
#endif
    }
    rowCycleCounter--;
 546:	80 91 b3 3f 	lds	r24, 0x3FB3	; 0x803fb3 <rowCycleCounter>
 54a:	81 50       	subi	r24, 0x01	; 1
 54c:	80 93 b3 3f 	sts	0x3FB3, r24	; 0x803fb3 <rowCycleCounter>
  }
  TCD0.INTFLAGS = TCD_OVF_bm;
 550:	81 e0       	ldi	r24, 0x01	; 1
 552:	80 93 8d 0a 	sts	0x0A8D, r24	; 0x800a8d <__TEXT_REGION_LENGTH__+0x700a8d>
}
 556:	ff 91       	pop	r31
 558:	ef 91       	pop	r30
 55a:	bf 91       	pop	r27
 55c:	af 91       	pop	r26
 55e:	9f 91       	pop	r25
 560:	8f 91       	pop	r24
 562:	7f 91       	pop	r23
 564:	6f 91       	pop	r22
 566:	5f 91       	pop	r21
 568:	4f 91       	pop	r20
 56a:	3f 91       	pop	r19
 56c:	2f 91       	pop	r18
 56e:	0f 90       	pop	r0
 570:	0f be       	out	0x3f, r0	; 63
 572:	0f 90       	pop	r0
 574:	1f 90       	pop	r1
 576:	18 95       	reti
    {
      rowCycleCounter = 0;
    }
    if ((rowCycleCounter) <= (1))
    {
      if (rowCycleCounter == 0)
 578:	81 11       	cpse	r24, r1
 57a:	e5 cf       	rjmp	.-54     	; 0x546 <next+0x14>
      {
        rowCycleCounter = 30;
 57c:	8e e1       	ldi	r24, 0x1E	; 30
 57e:	80 93 b3 3f 	sts	0x3FB3, r24	; 0x803fb3 <rowCycleCounter>
        if (row == 0)
 582:	80 91 b2 3f 	lds	r24, 0x3FB2	; 0x803fb2 <row>
 586:	81 11       	cpse	r24, r1
 588:	03 c0       	rjmp	.+6      	; 0x590 <next+0x5e>
        {
          row = 20;
 58a:	84 e1       	ldi	r24, 0x14	; 20
 58c:	80 93 b2 3f 	sts	0x3FB2, r24	; 0x803fb2 <row>
        }
        // else
        // {
        row = row - 1; // (1 & TCA0.SINGLE.CNT >>2);
 590:	60 91 b2 3f 	lds	r22, 0x3FB2	; 0x803fb2 <row>
 594:	61 50       	subi	r22, 0x01	; 1
 596:	60 93 b2 3f 	sts	0x3FB2, r22	; 0x803fb2 <row>
        // }
        patternMask = patternMaskMaker(xPos, row - yPos);
 59a:	80 91 81 3f 	lds	r24, 0x3F81	; 0x803f81 <yPos>
 59e:	68 1b       	sub	r22, r24
 5a0:	80 91 80 3f 	lds	r24, 0x3F80	; 0x803f80 <__data_start>
 5a4:	63 dd       	rcall	.-1338   	; 0x6c <patternMaskMaker>
 5a6:	80 93 b0 3f 	sts	0x3FB0, r24	; 0x803fb0 <patternMask>
 5aa:	90 93 b1 3f 	sts	0x3FB1, r25	; 0x803fb1 <patternMask+0x1>
 5ae:	cb cf       	rjmp	.-106    	; 0x546 <next+0x14>

000005b0 <ccp_write_io>:
 5b0:	dc 01       	movw	r26, r24
 5b2:	28 ed       	ldi	r18, 0xD8	; 216
 5b4:	20 93 34 00 	sts	0x0034, r18	; 0x800034 <__TEXT_REGION_LENGTH__+0x700034>
 5b8:	6c 93       	st	X, r22
 5ba:	08 95       	ret

000005bc <_exit>:
 5bc:	f8 94       	cli

000005be <__stop_program>:
 5be:	ff cf       	rjmp	.-2      	; 0x5be <__stop_program>
