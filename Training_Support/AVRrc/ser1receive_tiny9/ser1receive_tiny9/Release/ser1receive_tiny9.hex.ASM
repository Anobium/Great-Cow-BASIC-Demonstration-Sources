
D:\Great-Cow-BASIC-Demonstration-Sources.git\trunk\Training_Support\AVRrc\ser1receive_tiny9\ser1receive_tiny9\Release\ser1receive_tiny9.hex:     file format ihex

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .sec1         00000012  00000000  00000000  00000011  2**0
                  CONTENTS, ALLOC, LOAD
  1 .sec2         000000ee  00000014  00000014  0000004f  2**0
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
 0014 50e05ebf 5fe55dbf 1cd04bd0 c0e4d0e0  P.^._.]...K.....
 0024 eeeef0e0 49d052e0 5aab5ae0 56ab33d0  ....I.R.Z.Z.V.3.
 0034 5de056ab 30d01aa3 1a951aab b1f750e4  ].V.0.........P.
 0044 57ab50e0 58ab08d0 53a356ab 24d08895  W.P.X...S.V.$...
 0054 fecf50e0 52b90895 a7a3b8a3 5c9154ab  ..P.R.......\.T.
 0064 64a36623 b9f050e0 59ab64a3 613090f0  d.f#..P.Y.d.a0..
 0074 19a31395 19ab17a3 29a3120f a12f18a3  ........)..../..
 0084 30e0131f b12f5c91 56ab05d0 69a3c4a3  0..../\.V...i...
 0094 6c1770f3 089576a3 aae07095 08f41198  l.p...v...p.....
 00a4 08f0119a 8fe18a95 f1f77695 aa95b1f7  ..........v.....
 00b4 0895099a 119a0895 f0640081 602fe395  .........d..`/..
 00c4 09f4f395 699306c0 0081602f e39509f4  ....i.....`/....
 00d4 f395960f 603009f4 08950081 e39509f4  ....`0..........
 00e4 f3950993 6a95c9f7 08951350 6c656173  ....j......Pleas
 00f4 65207365 6e642061 20627974 6521      e send a byte!  

Disassembly of section .sec2:

00000014 <.sec2>:
  14:	50 e0       	ldi	r21, 0x00	; 0
  16:	5e bf       	out	0x3e, r21	; 62
  18:	5f e5       	ldi	r21, 0x5F	; 95
  1a:	5d bf       	out	0x3d, r21	; 61
  1c:	1c d0       	rcall	.+56     	;  0x56
  1e:	4b d0       	rcall	.+150    	;  0xb6
  20:	c0 e4       	ldi	r28, 0x40	; 64
  22:	d0 e0       	ldi	r29, 0x00	; 0
  24:	ee ee       	ldi	r30, 0xEE	; 238
  26:	f0 e0       	ldi	r31, 0x00	; 0
  28:	49 d0       	rcall	.+146    	;  0xbc
  2a:	52 e0       	ldi	r21, 0x02	; 2
  2c:	5a ab       	std	Y+50, r21	; 0x32
  2e:	5a e0       	ldi	r21, 0x0A	; 10
  30:	56 ab       	std	Z+54, r21	; 0x36
  32:	33 d0       	rcall	.+102    	;  0x9a
  34:	5d e0       	ldi	r21, 0x0D	; 13
  36:	56 ab       	std	Z+54, r21	; 0x36
  38:	30 d0       	rcall	.+96     	;  0x9a
  3a:	1a a3       	std	Y+34, r17	; 0x22
  3c:	1a 95       	dec	r17
  3e:	1a ab       	std	Y+50, r17	; 0x32
  40:	b1 f7       	brne	.-20     	;  0x2e
  42:	50 e4       	ldi	r21, 0x40	; 64
  44:	57 ab       	std	Z+55, r21	; 0x37
  46:	50 e0       	ldi	r21, 0x00	; 0
  48:	58 ab       	std	Y+48, r21	; 0x30
  4a:	08 d0       	rcall	.+16     	;  0x5c
  4c:	53 a3       	std	Z+35, r21	; 0x23
  4e:	56 ab       	std	Z+54, r21	; 0x36
  50:	24 d0       	rcall	.+72     	;  0x9a
  52:	88 95       	sleep
  54:	fe cf       	rjmp	.-4      	;  0x52
  56:	50 e0       	ldi	r21, 0x00	; 0
  58:	52 b9       	out	0x02, r21	; 2
  5a:	08 95       	ret
  5c:	a7 a3       	std	Z+39, r26	; 0x27
  5e:	b8 a3       	std	Y+32, r27	; 0x20
  60:	5c 91       	ld	r21, X
  62:	54 ab       	std	Z+52, r21	; 0x34
  64:	64 a3       	std	Z+36, r22	; 0x24
  66:	66 23       	and	r22, r22
  68:	b9 f0       	breq	.+46     	;  0x98
  6a:	50 e0       	ldi	r21, 0x00	; 0
  6c:	59 ab       	std	Y+49, r21	; 0x31
  6e:	64 a3       	std	Z+36, r22	; 0x24
  70:	61 30       	cpi	r22, 0x01	; 1
  72:	90 f0       	brcs	.+36     	;  0x98
  74:	19 a3       	std	Y+33, r17	; 0x21
  76:	13 95       	inc	r17
  78:	19 ab       	std	Y+49, r17	; 0x31
  7a:	17 a3       	std	Z+39, r17	; 0x27
  7c:	29 a3       	std	Y+33, r18	; 0x21
  7e:	12 0f       	add	r17, r18
  80:	a1 2f       	mov	r26, r17
  82:	18 a3       	std	Y+32, r17	; 0x20
  84:	30 e0       	ldi	r19, 0x00	; 0
  86:	13 1f       	adc	r17, r19
  88:	b1 2f       	mov	r27, r17
  8a:	5c 91       	ld	r21, X
  8c:	56 ab       	std	Z+54, r21	; 0x36
  8e:	05 d0       	rcall	.+10     	;  0x9a
  90:	69 a3       	std	Y+33, r22	; 0x21
  92:	c4 a3       	std	Z+36, r28	; 0x24
  94:	6c 17       	cp	r22, r28
  96:	70 f3       	brcs	.-36     	;  0x74
  98:	08 95       	ret
  9a:	76 a3       	std	Z+38, r23	; 0x26
  9c:	aa e0       	ldi	r26, 0x0A	; 10
  9e:	70 95       	com	r23
  a0:	08 f4       	brcc	.+2      	;  0xa4
  a2:	11 98       	cbi	0x02, 1	; 2
  a4:	08 f0       	brcs	.+2      	;  0xa8
  a6:	11 9a       	sbi	0x02, 1	; 2
  a8:	8f e1       	ldi	r24, 0x1F	; 31
  aa:	8a 95       	dec	r24
  ac:	f1 f7       	brne	.-4      	;  0xaa
  ae:	76 95       	lsr	r23
  b0:	aa 95       	dec	r26
  b2:	b1 f7       	brne	.-20     	;  0xa0
  b4:	08 95       	ret
  b6:	09 9a       	sbi	0x01, 1	; 1
  b8:	11 9a       	sbi	0x02, 1	; 2
  ba:	08 95       	ret
  bc:	f0 64       	ori	r31, 0x40	; 64
  be:	00 81       	ld	r16, Z
  c0:	60 2f       	mov	r22, r16
  c2:	e3 95       	inc	r30
  c4:	09 f4       	brne	.+2      	;  0xc8
  c6:	f3 95       	inc	r31
  c8:	69 93       	st	Y+, r22
  ca:	06 c0       	rjmp	.+12     	;  0xd8
  cc:	00 81       	ld	r16, Z
  ce:	60 2f       	mov	r22, r16
  d0:	e3 95       	inc	r30
  d2:	09 f4       	brne	.+2      	;  0xd6
  d4:	f3 95       	inc	r31
  d6:	96 0f       	add	r25, r22
  d8:	60 30       	cpi	r22, 0x00	; 0
  da:	09 f4       	brne	.+2      	;  0xde
  dc:	08 95       	ret
  de:	00 81       	ld	r16, Z
  e0:	e3 95       	inc	r30
  e2:	09 f4       	brne	.+2      	;  0xe6
  e4:	f3 95       	inc	r31
  e6:	09 93       	st	Y+, r16
  e8:	6a 95       	dec	r22
  ea:	c9 f7       	brne	.-14     	;  0xde
  ec:	08 95       	ret
  ee:	13 50       	subi	r17, 0x03	; 3
  f0:	6c 65       	ori	r22, 0x5C	; 92
  f2:	61 73       	andi	r22, 0x31	; 49
  f4:	65 20       	and	r6, r5
  f6:	73 65       	ori	r23, 0x53	; 83
  f8:	6e 64       	ori	r22, 0x4E	; 78
  fa:	20 61       	ori	r18, 0x10	; 16
  fc:	20 62       	ori	r18, 0x20	; 32
  fe:	79 74       	andi	r23, 0x49	; 73
 100:	65 21       	and	r22, r5
