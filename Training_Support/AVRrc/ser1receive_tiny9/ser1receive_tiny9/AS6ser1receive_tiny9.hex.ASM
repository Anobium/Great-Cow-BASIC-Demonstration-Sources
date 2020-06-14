
D:\Great-Cow-BASIC-Demonstration-Sources.git\trunk\Training_Support\AVRrc\ser1receive_tiny9\ser1receive_tiny9\Release\ser1receive_tiny9.hex:     file format ihex

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .sec1         00000012  00000000  00000000  00000011  2**0
                  CONTENTS, ALLOC, LOAD
  1 .sec2         000000d0  00000014  00000014  0000004f  2**0
                  CONTENTS, ALLOC, LOAD

D:\Great-Cow-BASIC-Demonstration-Sources.git\trunk\Training_Support\AVRrc\ser1receive_tiny9\ser1receive_tiny9\Release\ser1receive_tiny9.hex:     file format ihex

Contents of section .sec1:
 0000 09c01895 18951895 18951895 18951895  ................
 0010 1895                                 ..              

Disassembly of section .sec1:

00000000 <.sec1>:
   0:	09 c0       	rjmp	.+18     	;  0x14
   2:	18 95       	reti
   4:	18 95       	reti
   6:	18 95       	reti
   8:	18 95       	reti
   a:	18 95       	reti
   c:	18 95       	reti
   e:	18 95       	reti
  10:	18 95       	reti

D:\Great-Cow-BASIC-Demonstration-Sources.git\trunk\Training_Support\AVRrc\ser1receive_tiny9\ser1receive_tiny9\Release\ser1receive_tiny9.hex:     file format ihex

Contents of section .sec2:
 0014 50e05ebf 5fe55dbf 1ed031d0 c0e4d0e0  P.^._.]...1.....
 0024 eeecf0e0 39d0089a 109ad4e6 e0e007d0  ....9...........
 0034 10985ee2 56ab12d0 f7cf8895 fecfe395  ..^.V...........
 0044 afe692e0 9a95f1f7 aa95d9f7 da95c1f7  ................
 0054 ea95b1f7 089550e0 52b90895 76a3aae0  ......P.R...v...
 0064 709508f4 119808f0 119a88e2 8a95f1f7  p...............
 0074 52e054ab 07d07695 aa9599f7 0895099a  R.T...v.........
 0084 119a0895 94a38def 8a95f1f7 00009a95  ................
 0094 00000000 c1f70895 f0640081 602fe395  .........d..`/..
 00a4 09f4f395 699306c0 0081602f e39509f4  ....i.....`/....
 00b4 f395960f 603009f4 08950081 e39509f4  ....`0..........
 00c4 f3950993 6a95c9f7 08951350 6c656173  ....j......Pleas
 00d4 65207365 6e642061 20627974 6521012e  e send a byte!..

Disassembly of section .sec2:

00000014 <.sec2>:
  14:	50 e0       	ldi	r21, 0x00	; 0
  16:	5e bf       	out	0x3e, r21	; 62
  18:	5f e5       	ldi	r21, 0x5F	; 95
  1a:	5d bf       	out	0x3d, r21	; 61
  1c:	1e d0       	rcall	.+60     	;  0x5a
  1e:	31 d0       	rcall	.+98     	;  0x82
  20:	c0 e4       	ldi	r28, 0x40	; 64
  22:	d0 e0       	ldi	r29, 0x00	; 0
  24:	ee ec       	ldi	r30, 0xCE	; 206
  26:	f0 e0       	ldi	r31, 0x00	; 0
  28:	39 d0       	rcall	.+114    	;  0x9c
  2a:	08 9a       	sbi	0x01, 0	; 1
  2c:	10 9a       	sbi	0x02, 0	; 2
  2e:	d4 e6       	ldi	r29, 0x64	; 100
  30:	e0 e0       	ldi	r30, 0x00	; 0
  32:	07 d0       	rcall	.+14     	;  0x42
  34:	10 98       	cbi	0x02, 0	; 2
  36:	5e e2       	ldi	r21, 0x2E	; 46
  38:	56 ab       	std	Z+54, r21	; 0x36
  3a:	12 d0       	rcall	.+36     	;  0x60
  3c:	f7 cf       	rjmp	.-18     	;  0x2c
  3e:	88 95       	sleep
  40:	fe cf       	rjmp	.-4      	;  0x3e
  42:	e3 95       	inc	r30
  44:	af e6       	ldi	r26, 0x6F	; 111
  46:	92 e0       	ldi	r25, 0x02	; 2
  48:	9a 95       	dec	r25
  4a:	f1 f7       	brne	.-4      	;  0x48
  4c:	aa 95       	dec	r26
  4e:	d9 f7       	brne	.-10     	;  0x46
  50:	da 95       	dec	r29
  52:	c1 f7       	brne	.-16     	;  0x44
  54:	ea 95       	dec	r30
  56:	b1 f7       	brne	.-20     	;  0x44
  58:	08 95       	ret
  5a:	50 e0       	ldi	r21, 0x00	; 0
  5c:	52 b9       	out	0x02, r21	; 2
  5e:	08 95       	ret
  60:	76 a3       	std	Z+38, r23	; 0x26
  62:	aa e0       	ldi	r26, 0x0A	; 10
  64:	70 95       	com	r23
  66:	08 f4       	brcc	.+2      	;  0x6a
  68:	11 98       	cbi	0x02, 1	; 2
  6a:	08 f0       	brcs	.+2      	;  0x6e
  6c:	11 9a       	sbi	0x02, 1	; 2
  6e:	88 e2       	ldi	r24, 0x28	; 40
  70:	8a 95       	dec	r24
  72:	f1 f7       	brne	.-4      	;  0x70
  74:	52 e0       	ldi	r21, 0x02	; 2
  76:	54 ab       	std	Z+52, r21	; 0x34
  78:	07 d0       	rcall	.+14     	;  0x88
  7a:	76 95       	lsr	r23
  7c:	aa 95       	dec	r26
  7e:	99 f7       	brne	.-26     	;  0x66
  80:	08 95       	ret
  82:	09 9a       	sbi	0x01, 1	; 1
  84:	11 9a       	sbi	0x02, 1	; 2
  86:	08 95       	ret
  88:	94 a3       	std	Z+36, r25	; 0x24
  8a:	8d ef       	ldi	r24, 0xFD	; 253
  8c:	8a 95       	dec	r24
  8e:	f1 f7       	brne	.-4      	;  0x8c
  90:	00 00       	nop
  92:	9a 95       	dec	r25
  94:	00 00       	nop
  96:	00 00       	nop
  98:	c1 f7       	brne	.-16     	;  0x8a
  9a:	08 95       	ret
  9c:	f0 64       	ori	r31, 0x40	; 64
  9e:	00 81       	ld	r16, Z
  a0:	60 2f       	mov	r22, r16
  a2:	e3 95       	inc	r30
  a4:	09 f4       	brne	.+2      	;  0xa8
  a6:	f3 95       	inc	r31
  a8:	69 93       	st	Y+, r22
  aa:	06 c0       	rjmp	.+12     	;  0xb8
  ac:	00 81       	ld	r16, Z
  ae:	60 2f       	mov	r22, r16
  b0:	e3 95       	inc	r30
  b2:	09 f4       	brne	.+2      	;  0xb6
  b4:	f3 95       	inc	r31
  b6:	96 0f       	add	r25, r22
  b8:	60 30       	cpi	r22, 0x00	; 0
  ba:	09 f4       	brne	.+2      	;  0xbe
  bc:	08 95       	ret
  be:	00 81       	ld	r16, Z
  c0:	e3 95       	inc	r30
  c2:	09 f4       	brne	.+2      	;  0xc6
  c4:	f3 95       	inc	r31
  c6:	09 93       	st	Y+, r16
  c8:	6a 95       	dec	r22
  ca:	c9 f7       	brne	.-14     	;  0xbe
  cc:	08 95       	ret
  ce:	13 50       	subi	r17, 0x03	; 3
  d0:	6c 65       	ori	r22, 0x5C	; 92
  d2:	61 73       	andi	r22, 0x31	; 49
  d4:	65 20       	and	r6, r5
  d6:	73 65       	ori	r23, 0x53	; 83
  d8:	6e 64       	ori	r22, 0x4E	; 78
  da:	20 61       	ori	r18, 0x10	; 16
  dc:	20 62       	ori	r18, 0x20	; 32
  de:	79 74       	andi	r23, 0x49	; 73
  e0:	65 21       	and	r22, r5
  e2:	01 2e       	mov	r0, r17
