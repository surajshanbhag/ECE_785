   1              		.syntax unified
   2              		.arch armv7-a
   3              		.eabi_attribute 27, 3
   4              		.eabi_attribute 28, 1
   5              		.fpu vfpv3-d16
   6              		.eabi_attribute 20, 1
   7              		.eabi_attribute 21, 1
   8              		.eabi_attribute 23, 3
   9              		.eabi_attribute 24, 1
  10              		.eabi_attribute 25, 1
  11              		.eabi_attribute 26, 2
  12              		.eabi_attribute 30, 6
  13              		.eabi_attribute 18, 4
  14              		.thumb
  15              		.file	"geometry.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.global	twopi
  20              		.section	.rodata
  21              		.align	3
  24              	twopi:
  25 0000 182D4454 		.word	1413754136
  26 0004 FB211940 		.word	1075388923
  27              		.global	two_over_pi
  28              		.align	3
  31              	two_over_pi:
  32 0008 83C8C96D 		.word	1841940611
  33 000c 305FE43F 		.word	1071931184
  34              		.global	halfpi
  35              		.align	3
  38              	halfpi:
  39 0010 182D4454 		.word	1413754136
  40 0014 FB21F93F 		.word	1073291771
  41              		.text
  42              		.align	2
  43              		.global	cos_32s
  44              		.thumb
  45              		.thumb_func
  47              	cos_32s:
  48              	.LFB0:
  49              		.file 1 "sincos.c"
   1:sincos.c      **** 
   2:sincos.c      **** 
   3:sincos.c      **** #include <math.h>
   4:sincos.c      **** #include <stdio.h>
   5:sincos.c      **** #include <stdlib.h>
   6:sincos.c      **** 
   7:sincos.c      **** #define TRUE 1
   8:sincos.c      **** #define FALSE 0
   9:sincos.c      **** 
  10:sincos.c      **** // Math constants we'll use
  11:sincos.c      **** #define DP_PI (3.1415926535897932384626433)	// pi
  12:sincos.c      **** double const twopi=2.0*DP_PI;			// pi times 2
  13:sincos.c      **** double const two_over_pi= 2.0/DP_PI;		// 2/pi
  14:sincos.c      **** double const halfpi=DP_PI/2.0;			// pi divided by 2
  15:sincos.c      **** 
  16:sincos.c      **** #if USE_TAN_APPROX
  17:sincos.c      **** double const threehalfpi=3.0*DP_PI/2.0;  		// pi times 3/2, used in tan routines
  18:sincos.c      **** double const four_over_pi=4.0/DP_PI;		// 4/pi, used in tan routines
  19:sincos.c      **** double const qtrpi=DP_PI/4.0;			// pi/4.0, used in tan routines
  20:sincos.c      **** double const sixthpi=DP_PI/6.0;			// pi/6.0, used in atan routines
  21:sincos.c      **** double const tansixthpi=tan(sixthpi);		// tan(pi/6), used in atan routines
  22:sincos.c      **** double const twelfthpi=DP_PI/12.0;			// pi/12.0, used in atan routines
  23:sincos.c      **** double const tantwelfthpi=tan(twelfthpi);	// tan(pi/12), used in atan routines
  24:sincos.c      **** #endif
  25:sincos.c      **** 
  26:sincos.c      **** // *********************************************************
  27:sincos.c      **** // ***
  28:sincos.c      **** // ***   Routines to compute sine and cosine to 3.2 digits
  29:sincos.c      **** // ***  of accuracy. 
  30:sincos.c      **** // ***
  31:sincos.c      **** // *********************************************************
  32:sincos.c      **** //
  33:sincos.c      **** //		cos_32s computes cosine (x)
  34:sincos.c      **** //
  35:sincos.c      **** //  Accurate to about 3.2 decimal digits over the range [0, pi/2].
  36:sincos.c      **** //  The input argument is in radians.
  37:sincos.c      **** //
  38:sincos.c      **** //  Algorithm:
  39:sincos.c      **** //		cos(x)= c1 + c2*x**2 + c3*x**4
  40:sincos.c      **** //   which is the same as:
  41:sincos.c      **** //		cos(x)= c1 + x**2(c2 + c3*x**2)
  42:sincos.c      **** //
  43:sincos.c      **** float cos_32s(float x)
  44:sincos.c      **** {
  50              		.loc 1 44 0
  51              		.cfi_startproc
  52              		@ args = 0, pretend = 0, frame = 24
  53              		@ frame_needed = 1, uses_anonymous_args = 0
  54              		@ link register save eliminated.
  55 0000 80B4     		push	{r7}
  56              	.LCFI0:
  57              		.cfi_def_cfa_offset 4
  58              		.cfi_offset 7, -4
  59 0002 87B0     		sub	sp, sp, #28
  60              	.LCFI1:
  61              		.cfi_def_cfa_offset 32
  62 0004 00AF     		add	r7, sp, #0
  63              	.LCFI2:
  64              		.cfi_def_cfa_register 7
  65 0006 87ED010A 		fsts	s0, [r7, #4]
  45:sincos.c      ****     const float c1= 0.99940307;
  66              		.loc 1 45 0
  67 000a 134B     		ldr	r3, .L2	@ float
  68 000c 7B61     		str	r3, [r7, #20]	@ float
  46:sincos.c      ****     const float c2=-0.49558072;
  69              		.loc 1 46 0
  70 000e 134B     		ldr	r3, .L2+4	@ float
  71 0010 3B61     		str	r3, [r7, #16]	@ float
  47:sincos.c      ****     const float c3= 0.03679168;
  72              		.loc 1 47 0
  73 0012 134B     		ldr	r3, .L2+8	@ float
  74 0014 FB60     		str	r3, [r7, #12]	@ float
  48:sincos.c      **** 
  49:sincos.c      ****     float x2;							// The input argument squared
  50:sincos.c      **** 
  51:sincos.c      ****     x2=x * x;
  75              		.loc 1 51 0
  76 0016 97ED017A 		flds	s14, [r7, #4]
  77 001a D7ED017A 		flds	s15, [r7, #4]
  78 001e 67EE277A 		fmuls	s15, s14, s15
  79 0022 C7ED027A 		fsts	s15, [r7, #8]
  52:sincos.c      ****     return (c1 + x2*(c2 + c3 * x2));
  80              		.loc 1 52 0
  81 0026 97ED037A 		flds	s14, [r7, #12]
  82 002a D7ED027A 		flds	s15, [r7, #8]
  83 002e 67EE277A 		fmuls	s15, s14, s15
  84 0032 97ED047A 		flds	s14, [r7, #16]
  85 0036 37EE877A 		fadds	s14, s15, s14
  86 003a D7ED027A 		flds	s15, [r7, #8]
  87 003e 67EE277A 		fmuls	s15, s14, s15
  88 0042 97ED057A 		flds	s14, [r7, #20]
  89 0046 77EE877A 		fadds	s15, s15, s14
  53:sincos.c      **** }
  90              		.loc 1 53 0
  91 004a B0EE670A 		fcpys	s0, s15
  92 004e 07F11C07 		add	r7, r7, #28
  93 0052 BD46     		mov	sp, r7
  94 0054 80BC     		pop	{r7}
  95 0056 7047     		bx	lr
  96              	.L3:
  97              		.align	2
  98              	.L2:
  99 0058 E1D87F3F 		.word	1065343201
 100 005c C2BCFDBE 		.word	-1090667326
 101 0060 DFB2163D 		.word	1024897759
 102              		.cfi_endproc
 103              	.LFE0:
 105              		.align	2
 106              		.global	cos_32
 107              		.thumb
 108              		.thumb_func
 110              	cos_32:
 111              	.LFB1:
  54:sincos.c      **** 
  55:sincos.c      **** //
  56:sincos.c      **** //  This is the main cosine approximation "driver"
  57:sincos.c      **** // It reduces the input argument's range to [0, pi/2],
  58:sincos.c      **** // and then calls the approximator. 
  59:sincos.c      **** // See the notes for an explanation of the range reduction.
  60:sincos.c      **** //
  61:sincos.c      **** float cos_32(float x){
 112              		.loc 1 61 0
 113              		.cfi_startproc
 114              		@ args = 0, pretend = 0, frame = 16
 115              		@ frame_needed = 1, uses_anonymous_args = 0
 116 0064 80B5     		push	{r7, lr}
 117              	.LCFI3:
 118              		.cfi_def_cfa_offset 8
 119              		.cfi_offset 14, -4
 120              		.cfi_offset 7, -8
 121 0066 84B0     		sub	sp, sp, #16
 122              	.LCFI4:
 123              		.cfi_def_cfa_offset 24
 124 0068 00AF     		add	r7, sp, #0
 125              	.LCFI5:
 126              		.cfi_def_cfa_register 7
 127 006a 87ED010A 		fsts	s0, [r7, #4]
  62:sincos.c      ****     int quad;						// what quadrant are we in?
  63:sincos.c      **** 
  64:sincos.c      ****     x=fmod(x, twopi);				// Get rid of values > 2* pi
 128              		.loc 1 64 0
 129 006e D7ED017A 		flds	s15, [r7, #4]
 130 0072 B7EEE76A 		fcvtds	d6, s15
 131 0076 40F20003 		movw	r3, #:lower16:twopi
 132 007a C0F20003 		movt	r3, #:upper16:twopi
 133 007e 93ED007B 		fldd	d7, [r3, #0]
 134 0082 B0EE460B 		fcpyd	d0, d6
 135 0086 B0EE471B 		fcpyd	d1, d7
 136 008a FFF7FEFF 		bl	fmod
 137 008e B0EE407B 		fcpyd	d7, d0
 138 0092 F7EEC77B 		fcvtsd	s15, d7
 139 0096 C7ED017A 		fsts	s15, [r7, #4]
  65:sincos.c      ****     if(x<0)x=-x;					// cos(-x) = cos(x)
 140              		.loc 1 65 0
 141 009a D7ED017A 		flds	s15, [r7, #4]
 142 009e F5EEC07A 		fcmpezs	s15
 143 00a2 F1EE10FA 		fmstat
 144 00a6 54BF     		ite	pl
 145 00a8 0023     		movpl	r3, #0
 146 00aa 0123     		movmi	r3, #1
 147 00ac DBB2     		uxtb	r3, r3
 148 00ae 002B     		cmp	r3, #0
 149 00b0 05D0     		beq	.L5
 150              		.loc 1 65 0 is_stmt 0 discriminator 1
 151 00b2 D7ED017A 		flds	s15, [r7, #4]
 152 00b6 F1EE677A 		fnegs	s15, s15
 153 00ba C7ED017A 		fsts	s15, [r7, #4]
 154              	.L5:
  66:sincos.c      ****     quad=(int) (x * two_over_pi);			// Get quadrant # (0 to 3) we're in
 155              		.loc 1 66 0 is_stmt 1
 156 00be D7ED017A 		flds	s15, [r7, #4]
 157 00c2 B7EEE76A 		fcvtds	d6, s15
 158 00c6 40F20003 		movw	r3, #:lower16:two_over_pi
 159 00ca C0F20003 		movt	r3, #:upper16:two_over_pi
 160 00ce 93ED007B 		fldd	d7, [r3, #0]
 161 00d2 26EE077B 		fmuld	d7, d6, d7
 162 00d6 FDEEC76B 		ftosizd	s13, d7
 163 00da 16EE903A 		fmrs	r3, s13	@ int
 164 00de FB60     		str	r3, [r7, #12]
  67:sincos.c      ****     switch (quad){
 165              		.loc 1 67 0
 166 00e0 FB68     		ldr	r3, [r7, #12]
 167 00e2 032B     		cmp	r3, #3
 168 00e4 4CD8     		bhi	.L6
 169 00e6 01A2     		adr	r2, .L11
 170 00e8 52F823F0 		ldr	pc, [r2, r3, lsl #2]
 171              		.align	2
 172              	.L11:
 173 00ec FD000000 		.word	.L7+1
 174 00f0 0B010000 		.word	.L8+1
 175 00f4 31010000 		.word	.L9+1
 176 00f8 57010000 		.word	.L10+1
 177              	.L7:
  68:sincos.c      ****         case 0: return  cos_32s(x);
 178              		.loc 1 68 0
 179 00fc 97ED010A 		flds	s0, [r7, #4]
 180 0100 FFF7FEFF 		bl	cos_32s
 181 0104 F0EE407A 		fcpys	s15, s0
 182 0108 3CE0     		b	.L12
 183              	.L8:
  69:sincos.c      ****         case 1: return -cos_32s(DP_PI-x);
 184              		.loc 1 69 0
 185 010a D7ED017A 		flds	s15, [r7, #4]
 186 010e B7EEE77A 		fcvtds	d7, s15
 187 0112 9FED1F6B 		fldd	d6, .L13
 188 0116 36EE477B 		fsubd	d7, d6, d7
 189 011a F7EEC77B 		fcvtsd	s15, d7
 190 011e B0EE670A 		fcpys	s0, s15
 191 0122 FFF7FEFF 		bl	cos_32s
 192 0126 F0EE407A 		fcpys	s15, s0
 193 012a F1EE677A 		fnegs	s15, s15
 194 012e 29E0     		b	.L12
 195              	.L9:
  70:sincos.c      ****         case 2: return -cos_32s(x-DP_PI);
 196              		.loc 1 70 0
 197 0130 D7ED017A 		flds	s15, [r7, #4]
 198 0134 B7EEE76A 		fcvtds	d6, s15
 199 0138 9FED157B 		fldd	d7, .L13
 200 013c 36EE477B 		fsubd	d7, d6, d7
 201 0140 F7EEC77B 		fcvtsd	s15, d7
 202 0144 B0EE670A 		fcpys	s0, s15
 203 0148 FFF7FEFF 		bl	cos_32s
 204 014c F0EE407A 		fcpys	s15, s0
 205 0150 F1EE677A 		fnegs	s15, s15
 206 0154 16E0     		b	.L12
 207              	.L10:
  71:sincos.c      ****         case 3: return  cos_32s(twopi-x);
 208              		.loc 1 71 0
 209 0156 40F20003 		movw	r3, #:lower16:twopi
 210 015a C0F20003 		movt	r3, #:upper16:twopi
 211 015e 93ED006B 		fldd	d6, [r3, #0]
 212 0162 D7ED017A 		flds	s15, [r7, #4]
 213 0166 B7EEE77A 		fcvtds	d7, s15
 214 016a 36EE477B 		fsubd	d7, d6, d7
 215 016e F7EEC77B 		fcvtsd	s15, d7
 216 0172 B0EE670A 		fcpys	s0, s15
 217 0176 FFF7FEFF 		bl	cos_32s
 218 017a F0EE407A 		fcpys	s15, s0
 219 017e 01E0     		b	.L12
 220              	.L6:
  72:sincos.c      ****     }
  73:sincos.c      ****     return 0.0;
 221              		.loc 1 73 0
 222 0180 DFED057A 		flds	s15, .L13+8
 223              	.L12:
  74:sincos.c      **** }
 224              		.loc 1 74 0
 225 0184 B0EE670A 		fcpys	s0, s15
 226 0188 07F11007 		add	r7, r7, #16
 227 018c BD46     		mov	sp, r7
 228 018e 80BD     		pop	{r7, pc}
 229              	.L14:
 230              		.align	3
 231              	.L13:
 232 0190 182D4454 		.word	1413754136
 233 0194 FB210940 		.word	1074340347
 234 0198 00000000 		.word	0
 235              		.cfi_endproc
 236              	.LFE1:
 238              		.align	2
 239              		.global	sin_32
 240              		.thumb
 241              		.thumb_func
 243              	sin_32:
 244              	.LFB2:
  75:sincos.c      **** //
  76:sincos.c      **** //   The sine is just cosine shifted a half-pi, so
  77:sincos.c      **** // we'll adjust the argument and call the cosine approximation.
  78:sincos.c      **** //
  79:sincos.c      **** float sin_32(float x){
 245              		.loc 1 79 0
 246              		.cfi_startproc
 247              		@ args = 0, pretend = 0, frame = 8
 248              		@ frame_needed = 1, uses_anonymous_args = 0
 249 019c 80B5     		push	{r7, lr}
 250              	.LCFI6:
 251              		.cfi_def_cfa_offset 8
 252              		.cfi_offset 14, -4
 253              		.cfi_offset 7, -8
 254 019e 82B0     		sub	sp, sp, #8
 255              	.LCFI7:
 256              		.cfi_def_cfa_offset 16
 257 01a0 00AF     		add	r7, sp, #0
 258              	.LCFI8:
 259              		.cfi_def_cfa_register 7
 260 01a2 87ED010A 		fsts	s0, [r7, #4]
  80:sincos.c      ****     return cos_32(halfpi-x);
 261              		.loc 1 80 0
 262 01a6 40F20003 		movw	r3, #:lower16:halfpi
 263 01aa C0F20003 		movt	r3, #:upper16:halfpi
 264 01ae 93ED006B 		fldd	d6, [r3, #0]
 265 01b2 D7ED017A 		flds	s15, [r7, #4]
 266 01b6 B7EEE77A 		fcvtds	d7, s15
 267 01ba 36EE477B 		fsubd	d7, d6, d7
 268 01be F7EEC77B 		fcvtsd	s15, d7
 269 01c2 B0EE670A 		fcpys	s0, s15
 270 01c6 FFF7FEFF 		bl	cos_32
 271 01ca F0EE407A 		fcpys	s15, s0
  81:sincos.c      **** }
 272              		.loc 1 81 0
 273 01ce B0EE670A 		fcpys	s0, s15
 274 01d2 07F10807 		add	r7, r7, #8
 275 01d6 BD46     		mov	sp, r7
 276 01d8 80BD     		pop	{r7, pc}
 277              		.cfi_endproc
 278              	.LFE2:
 280 01da 00BF     		.align	2
 281              		.global	cos_52s
 282              		.thumb
 283              		.thumb_func
 285              	cos_52s:
 286              	.LFB3:
  82:sincos.c      **** 
  83:sincos.c      **** // *********************************************************
  84:sincos.c      **** // ***
  85:sincos.c      **** // ***   Routines to compute sine and cosine to 5.2 digits
  86:sincos.c      **** // ***  of accuracy. 
  87:sincos.c      **** // ***
  88:sincos.c      **** // *********************************************************
  89:sincos.c      **** //
  90:sincos.c      **** //		cos_52s computes cosine (x)
  91:sincos.c      **** //
  92:sincos.c      **** //  Accurate to about 5.2 decimal digits over the range [0, pi/2].
  93:sincos.c      **** //  The input argument is in radians.
  94:sincos.c      **** //
  95:sincos.c      **** //  Algorithm:
  96:sincos.c      **** //		cos(x)= c1 + c2*x**2 + c3*x**4 + c4*x**6
  97:sincos.c      **** //   which is the same as:
  98:sincos.c      **** //		cos(x)= c1 + x**2(c2 + c3*x**2 + c4*x**4)
  99:sincos.c      **** //		cos(x)= c1 + x**2(c2 + x**2(c3 + c4*x**2))
 100:sincos.c      **** //
 101:sincos.c      **** float cos_52s(float x)
 102:sincos.c      **** {
 287              		.loc 1 102 0
 288              		.cfi_startproc
 289              		@ args = 0, pretend = 0, frame = 32
 290              		@ frame_needed = 1, uses_anonymous_args = 0
 291              		@ link register save eliminated.
 292 01dc 80B4     		push	{r7}
 293              	.LCFI9:
 294              		.cfi_def_cfa_offset 4
 295              		.cfi_offset 7, -4
 296 01de 89B0     		sub	sp, sp, #36
 297              	.LCFI10:
 298              		.cfi_def_cfa_offset 40
 299 01e0 00AF     		add	r7, sp, #0
 300              	.LCFI11:
 301              		.cfi_def_cfa_register 7
 302 01e2 87ED010A 		fsts	s0, [r7, #4]
 103:sincos.c      ****     const float c1= 0.9999932946;
 303              		.loc 1 103 0
 304 01e6 184B     		ldr	r3, .L17	@ float
 305 01e8 FB61     		str	r3, [r7, #28]	@ float
 104:sincos.c      ****     const float c2=-0.4999124376;
 306              		.loc 1 104 0
 307 01ea 184B     		ldr	r3, .L17+4	@ float
 308 01ec BB61     		str	r3, [r7, #24]	@ float
 105:sincos.c      ****     const float c3= 0.0414877472;
 309              		.loc 1 105 0
 310 01ee 184B     		ldr	r3, .L17+8	@ float
 311 01f0 7B61     		str	r3, [r7, #20]	@ float
 106:sincos.c      ****     const float c4=-0.0012712095;
 312              		.loc 1 106 0
 313 01f2 184B     		ldr	r3, .L17+12	@ float
 314 01f4 3B61     		str	r3, [r7, #16]	@ float
 107:sincos.c      **** 
 108:sincos.c      ****     float x2;							// The input argument squared
 109:sincos.c      **** 
 110:sincos.c      ****     x2=x * x;
 315              		.loc 1 110 0
 316 01f6 97ED017A 		flds	s14, [r7, #4]
 317 01fa D7ED017A 		flds	s15, [r7, #4]
 318 01fe 67EE277A 		fmuls	s15, s14, s15
 319 0202 C7ED037A 		fsts	s15, [r7, #12]
 111:sincos.c      ****     return (c1 + x2*(c2 + x2*(c3 + c4*x2)));
 320              		.loc 1 111 0
 321 0206 97ED047A 		flds	s14, [r7, #16]
 322 020a D7ED037A 		flds	s15, [r7, #12]
 323 020e 67EE277A 		fmuls	s15, s14, s15
 324 0212 97ED057A 		flds	s14, [r7, #20]
 325 0216 37EE877A 		fadds	s14, s15, s14
 326 021a D7ED037A 		flds	s15, [r7, #12]
 327 021e 67EE277A 		fmuls	s15, s14, s15
 328 0222 97ED067A 		flds	s14, [r7, #24]
 329 0226 37EE877A 		fadds	s14, s15, s14
 330 022a D7ED037A 		flds	s15, [r7, #12]
 331 022e 67EE277A 		fmuls	s15, s14, s15
 332 0232 97ED077A 		flds	s14, [r7, #28]
 333 0236 77EE877A 		fadds	s15, s15, s14
 112:sincos.c      **** }
 334              		.loc 1 112 0
 335 023a B0EE670A 		fcpys	s0, s15
 336 023e 07F12407 		add	r7, r7, #36
 337 0242 BD46     		mov	sp, r7
 338 0244 80BC     		pop	{r7}
 339 0246 7047     		bx	lr
 340              	.L18:
 341              		.align	2
 342              	.L17:
 343 0248 90FF7F3F 		.word	1065353104
 344 024c 86F4FFBE 		.word	-1090521978
 345 0250 0EEF293D 		.word	1026158350
 346 0254 B69EA6BA 		.word	-1163485514
 347              		.cfi_endproc
 348              	.LFE3:
 350              		.align	2
 351              		.global	cos_52
 352              		.thumb
 353              		.thumb_func
 355              	cos_52:
 356              	.LFB4:
 113:sincos.c      **** 
 114:sincos.c      **** //
 115:sincos.c      **** //  This is the main cosine approximation "driver"
 116:sincos.c      **** // It reduces the input argument's range to [0, pi/2],
 117:sincos.c      **** // and then calls the approximator. 
 118:sincos.c      **** // See the notes for an explanation of the range reduction.
 119:sincos.c      **** //
 120:sincos.c      **** float cos_52(float x){
 357              		.loc 1 120 0
 358              		.cfi_startproc
 359              		@ args = 0, pretend = 0, frame = 16
 360              		@ frame_needed = 1, uses_anonymous_args = 0
 361 0258 80B5     		push	{r7, lr}
 362              	.LCFI12:
 363              		.cfi_def_cfa_offset 8
 364              		.cfi_offset 14, -4
 365              		.cfi_offset 7, -8
 366 025a 84B0     		sub	sp, sp, #16
 367              	.LCFI13:
 368              		.cfi_def_cfa_offset 24
 369 025c 00AF     		add	r7, sp, #0
 370              	.LCFI14:
 371              		.cfi_def_cfa_register 7
 372 025e 87ED010A 		fsts	s0, [r7, #4]
 121:sincos.c      ****     int quad;						// what quadrant are we in?
 122:sincos.c      **** 
 123:sincos.c      ****     x=fmod(x, twopi);				// Get rid of values > 2* pi
 373              		.loc 1 123 0
 374 0262 D7ED017A 		flds	s15, [r7, #4]
 375 0266 B7EEE76A 		fcvtds	d6, s15
 376 026a 40F20003 		movw	r3, #:lower16:twopi
 377 026e C0F20003 		movt	r3, #:upper16:twopi
 378 0272 93ED007B 		fldd	d7, [r3, #0]
 379 0276 B0EE460B 		fcpyd	d0, d6
 380 027a B0EE471B 		fcpyd	d1, d7
 381 027e FFF7FEFF 		bl	fmod
 382 0282 B0EE407B 		fcpyd	d7, d0
 383 0286 F7EEC77B 		fcvtsd	s15, d7
 384 028a C7ED017A 		fsts	s15, [r7, #4]
 124:sincos.c      ****     if(x<0)x=-x;					// cos(-x) = cos(x)
 385              		.loc 1 124 0
 386 028e D7ED017A 		flds	s15, [r7, #4]
 387 0292 F5EEC07A 		fcmpezs	s15
 388 0296 F1EE10FA 		fmstat
 389 029a 54BF     		ite	pl
 390 029c 0023     		movpl	r3, #0
 391 029e 0123     		movmi	r3, #1
 392 02a0 DBB2     		uxtb	r3, r3
 393 02a2 002B     		cmp	r3, #0
 394 02a4 05D0     		beq	.L20
 395              		.loc 1 124 0 is_stmt 0 discriminator 1
 396 02a6 D7ED017A 		flds	s15, [r7, #4]
 397 02aa F1EE677A 		fnegs	s15, s15
 398 02ae C7ED017A 		fsts	s15, [r7, #4]
 399              	.L20:
 125:sincos.c      ****     quad=(int) (x * two_over_pi);			// Get quadrant # (0 to 3) we're in
 400              		.loc 1 125 0 is_stmt 1
 401 02b2 D7ED017A 		flds	s15, [r7, #4]
 402 02b6 B7EEE76A 		fcvtds	d6, s15
 403 02ba 40F20003 		movw	r3, #:lower16:two_over_pi
 404 02be C0F20003 		movt	r3, #:upper16:two_over_pi
 405 02c2 93ED007B 		fldd	d7, [r3, #0]
 406 02c6 26EE077B 		fmuld	d7, d6, d7
 407 02ca FDEEC76B 		ftosizd	s13, d7
 408 02ce 16EE903A 		fmrs	r3, s13	@ int
 409 02d2 FB60     		str	r3, [r7, #12]
 126:sincos.c      ****     switch (quad){
 410              		.loc 1 126 0
 411 02d4 FB68     		ldr	r3, [r7, #12]
 412 02d6 032B     		cmp	r3, #3
 413 02d8 4CD8     		bhi	.L21
 414 02da 01A2     		adr	r2, .L26
 415 02dc 52F823F0 		ldr	pc, [r2, r3, lsl #2]
 416              		.align	2
 417              	.L26:
 418 02e0 F1020000 		.word	.L22+1
 419 02e4 FF020000 		.word	.L23+1
 420 02e8 25030000 		.word	.L24+1
 421 02ec 4B030000 		.word	.L25+1
 422              	.L22:
 127:sincos.c      ****         case 0: return  cos_52s(x);
 423              		.loc 1 127 0
 424 02f0 97ED010A 		flds	s0, [r7, #4]
 425 02f4 FFF7FEFF 		bl	cos_52s
 426 02f8 F0EE407A 		fcpys	s15, s0
 427 02fc 3CE0     		b	.L27
 428              	.L23:
 128:sincos.c      ****         case 1: return -cos_52s(DP_PI-x);
 429              		.loc 1 128 0
 430 02fe D7ED017A 		flds	s15, [r7, #4]
 431 0302 B7EEE77A 		fcvtds	d7, s15
 432 0306 9FED206B 		fldd	d6, .L28
 433 030a 36EE477B 		fsubd	d7, d6, d7
 434 030e F7EEC77B 		fcvtsd	s15, d7
 435 0312 B0EE670A 		fcpys	s0, s15
 436 0316 FFF7FEFF 		bl	cos_52s
 437 031a F0EE407A 		fcpys	s15, s0
 438 031e F1EE677A 		fnegs	s15, s15
 439 0322 29E0     		b	.L27
 440              	.L24:
 129:sincos.c      ****         case 2: return -cos_52s(x-DP_PI);
 441              		.loc 1 129 0
 442 0324 D7ED017A 		flds	s15, [r7, #4]
 443 0328 B7EEE76A 		fcvtds	d6, s15
 444 032c 9FED167B 		fldd	d7, .L28
 445 0330 36EE477B 		fsubd	d7, d6, d7
 446 0334 F7EEC77B 		fcvtsd	s15, d7
 447 0338 B0EE670A 		fcpys	s0, s15
 448 033c FFF7FEFF 		bl	cos_52s
 449 0340 F0EE407A 		fcpys	s15, s0
 450 0344 F1EE677A 		fnegs	s15, s15
 451 0348 16E0     		b	.L27
 452              	.L25:
 130:sincos.c      ****         case 3: return  cos_52s(twopi-x);
 453              		.loc 1 130 0
 454 034a 40F20003 		movw	r3, #:lower16:twopi
 455 034e C0F20003 		movt	r3, #:upper16:twopi
 456 0352 93ED006B 		fldd	d6, [r3, #0]
 457 0356 D7ED017A 		flds	s15, [r7, #4]
 458 035a B7EEE77A 		fcvtds	d7, s15
 459 035e 36EE477B 		fsubd	d7, d6, d7
 460 0362 F7EEC77B 		fcvtsd	s15, d7
 461 0366 B0EE670A 		fcpys	s0, s15
 462 036a FFF7FEFF 		bl	cos_52s
 463 036e F0EE407A 		fcpys	s15, s0
 464 0372 01E0     		b	.L27
 465              	.L21:
 131:sincos.c      ****     }
 132:sincos.c      ****     return 0.0;
 466              		.loc 1 132 0
 467 0374 DFED067A 		flds	s15, .L28+8
 468              	.L27:
 133:sincos.c      **** }
 469              		.loc 1 133 0
 470 0378 B0EE670A 		fcpys	s0, s15
 471 037c 07F11007 		add	r7, r7, #16
 472 0380 BD46     		mov	sp, r7
 473 0382 80BD     		pop	{r7, pc}
 474              	.L29:
 475 0384 AFF30080 		.align	3
 476              	.L28:
 477 0388 182D4454 		.word	1413754136
 478 038c FB210940 		.word	1074340347
 479 0390 00000000 		.word	0
 480              		.cfi_endproc
 481              	.LFE4:
 483              		.align	2
 484              		.global	sin_52
 485              		.thumb
 486              		.thumb_func
 488              	sin_52:
 489              	.LFB5:
 134:sincos.c      **** //
 135:sincos.c      **** //   The sine is just cosine shifted a half-pi, so
 136:sincos.c      **** // we'll adjust the argument and call the cosine approximation.
 137:sincos.c      **** //
 138:sincos.c      **** float sin_52(float x){
 490              		.loc 1 138 0
 491              		.cfi_startproc
 492              		@ args = 0, pretend = 0, frame = 8
 493              		@ frame_needed = 1, uses_anonymous_args = 0
 494 0394 80B5     		push	{r7, lr}
 495              	.LCFI15:
 496              		.cfi_def_cfa_offset 8
 497              		.cfi_offset 14, -4
 498              		.cfi_offset 7, -8
 499 0396 82B0     		sub	sp, sp, #8
 500              	.LCFI16:
 501              		.cfi_def_cfa_offset 16
 502 0398 00AF     		add	r7, sp, #0
 503              	.LCFI17:
 504              		.cfi_def_cfa_register 7
 505 039a 87ED010A 		fsts	s0, [r7, #4]
 139:sincos.c      ****     return cos_52(halfpi-x);
 506              		.loc 1 139 0
 507 039e 40F20003 		movw	r3, #:lower16:halfpi
 508 03a2 C0F20003 		movt	r3, #:upper16:halfpi
 509 03a6 93ED006B 		fldd	d6, [r3, #0]
 510 03aa D7ED017A 		flds	s15, [r7, #4]
 511 03ae B7EEE77A 		fcvtds	d7, s15
 512 03b2 36EE477B 		fsubd	d7, d6, d7
 513 03b6 F7EEC77B 		fcvtsd	s15, d7
 514 03ba B0EE670A 		fcpys	s0, s15
 515 03be FFF7FEFF 		bl	cos_52
 516 03c2 F0EE407A 		fcpys	s15, s0
 140:sincos.c      **** }
 517              		.loc 1 140 0
 518 03c6 B0EE670A 		fcpys	s0, s15
 519 03ca 07F10807 		add	r7, r7, #8
 520 03ce BD46     		mov	sp, r7
 521 03d0 80BD     		pop	{r7, pc}
 522              		.cfi_endproc
 523              	.LFE5:
 525 03d2 00BF     		.align	2
 526              		.global	cos_73s
 527              		.thumb
 528              		.thumb_func
 530              	cos_73s:
 531              	.LFB6:
 141:sincos.c      **** 
 142:sincos.c      **** // *********************************************************
 143:sincos.c      **** // ***
 144:sincos.c      **** // ***   Routines to compute sine and cosine to 7.3 digits
 145:sincos.c      **** // ***  of accuracy. 
 146:sincos.c      **** // ***
 147:sincos.c      **** // *********************************************************
 148:sincos.c      **** //
 149:sincos.c      **** //		cos_73s computes cosine (x)
 150:sincos.c      **** //
 151:sincos.c      **** //  Accurate to about 7.3 decimal digits over the range [0, pi/2].
 152:sincos.c      **** //  The input argument is in radians.
 153:sincos.c      **** //
 154:sincos.c      **** //  Algorithm:
 155:sincos.c      **** //		cos(x)= c1 + c2*x**2 + c3*x**4 + c4*x**6 + c5*x**8
 156:sincos.c      **** //   which is the same as:
 157:sincos.c      **** //		cos(x)= c1 + x**2(c2 + c3*x**2 + c4*x**4 + c5*x**6)
 158:sincos.c      **** //		cos(x)= c1 + x**2(c2 + x**2(c3 + c4*x**2 + c5*x**4))
 159:sincos.c      **** //		cos(x)= c1 + x**2(c2 + x**2(c3 + x**2(c4 + c5*x**2)))
 160:sincos.c      **** //
 161:sincos.c      **** double cos_73s(double x)
 162:sincos.c      **** {
 532              		.loc 1 162 0
 533              		.cfi_startproc
 534              		@ args = 0, pretend = 0, frame = 56
 535              		@ frame_needed = 1, uses_anonymous_args = 0
 536              		@ link register save eliminated.
 537 03d4 80B4     		push	{r7}
 538              	.LCFI18:
 539              		.cfi_def_cfa_offset 4
 540              		.cfi_offset 7, -4
 541 03d6 8FB0     		sub	sp, sp, #60
 542              	.LCFI19:
 543              		.cfi_def_cfa_offset 64
 544 03d8 00AF     		add	r7, sp, #0
 545              	.LCFI20:
 546              		.cfi_def_cfa_register 7
 547 03da 87ED000B 		fstd	d0, [r7, #0]
 163:sincos.c      ****     const double c1= 0.999999953464;
 548              		.loc 1 163 0
 549 03de 26A3     		adr	r3, .L32
 550 03e0 D3E90023 		ldrd	r2, [r3]
 551 03e4 C7E90C23 		strd	r2, [r7, #48]
 164:sincos.c      ****     const double c2=-0.4999999053455;
 552              		.loc 1 164 0
 553 03e8 25A3     		adr	r3, .L32+8
 554 03ea D3E90023 		ldrd	r2, [r3]
 555 03ee C7E90A23 		strd	r2, [r7, #40]
 165:sincos.c      ****     const double c3= 0.0416635846769;
 556              		.loc 1 165 0
 557 03f2 25A3     		adr	r3, .L32+16
 558 03f4 D3E90023 		ldrd	r2, [r3]
 559 03f8 C7E90823 		strd	r2, [r7, #32]
 166:sincos.c      ****     const double c4=-0.0013853704264;
 560              		.loc 1 166 0
 561 03fc 24A3     		adr	r3, .L32+24
 562 03fe D3E90023 		ldrd	r2, [r3]
 563 0402 C7E90623 		strd	r2, [r7, #24]
 167:sincos.c      ****     const double c5= 0.000023233;  	// Note: this is a better coefficient than Hart's
 564              		.loc 1 167 0
 565 0406 24A3     		adr	r3, .L32+32
 566 0408 D3E90023 		ldrd	r2, [r3]
 567 040c C7E90423 		strd	r2, [r7, #16]
 168:sincos.c      ****     //   submitted by Steven Perkins 2/22/07
 169:sincos.c      **** 
 170:sincos.c      ****     double x2;							// The input argument squared
 171:sincos.c      **** 
 172:sincos.c      ****     x2=x * x;
 568              		.loc 1 172 0
 569 0410 97ED006B 		fldd	d6, [r7, #0]
 570 0414 97ED007B 		fldd	d7, [r7, #0]
 571 0418 26EE077B 		fmuld	d7, d6, d7
 572 041c 87ED027B 		fstd	d7, [r7, #8]
 173:sincos.c      ****     return (c1 + x2*(c2 + x2*(c3 + x2*(c4 + c5*x2))));
 573              		.loc 1 173 0
 574 0420 97ED046B 		fldd	d6, [r7, #16]
 575 0424 97ED027B 		fldd	d7, [r7, #8]
 576 0428 26EE077B 		fmuld	d7, d6, d7
 577 042c 97ED066B 		fldd	d6, [r7, #24]
 578 0430 37EE066B 		faddd	d6, d7, d6
 579 0434 97ED027B 		fldd	d7, [r7, #8]
 580 0438 26EE077B 		fmuld	d7, d6, d7
 581 043c 97ED086B 		fldd	d6, [r7, #32]
 582 0440 37EE066B 		faddd	d6, d7, d6
 583 0444 97ED027B 		fldd	d7, [r7, #8]
 584 0448 26EE077B 		fmuld	d7, d6, d7
 585 044c 97ED0A6B 		fldd	d6, [r7, #40]
 586 0450 37EE066B 		faddd	d6, d7, d6
 587 0454 97ED027B 		fldd	d7, [r7, #8]
 588 0458 26EE077B 		fmuld	d7, d6, d7
 589 045c 97ED0C6B 		fldd	d6, [r7, #48]
 590 0460 37EE067B 		faddd	d7, d7, d6
 174:sincos.c      **** }
 591              		.loc 1 174 0
 592 0464 B0EE470B 		fcpyd	d0, d7
 593 0468 07F13C07 		add	r7, r7, #60
 594 046c BD46     		mov	sp, r7
 595 046e 80BC     		pop	{r7}
 596 0470 7047     		bx	lr
 597              	.L33:
 598 0472 00BFAFF3 		.align	3
 598      0080
 599              	.L32:
 600 0478 0F2404E7 		.word	-419159025
 601 047c FFFFEF3F 		.word	1072693247
 602 0480 B4915D9A 		.word	-1705143884
 603 0484 FFFFDFBF 		.word	-1075838977
 604 0488 BE293EEB 		.word	-348247618
 605 048c ED54A53F 		.word	1067799789
 606 0490 95A4262B 		.word	723952789
 607 0494 AAB256BF 		.word	-1084837206
 608 0498 E0B25E9A 		.word	-1705069856
 609 049c 8F5CF83E 		.word	1056464015
 610              		.cfi_endproc
 611              	.LFE6:
 613              		.align	2
 614              		.global	cos_73
 615              		.thumb
 616              		.thumb_func
 618              	cos_73:
 619              	.LFB7:
 175:sincos.c      **** 
 176:sincos.c      **** //
 177:sincos.c      **** //  This is the main cosine approximation "driver"
 178:sincos.c      **** // It reduces the input argument's range to [0, pi/2],
 179:sincos.c      **** // and then calls the approximator. 
 180:sincos.c      **** // See the notes for an explanation of the range reduction.
 181:sincos.c      **** //
 182:sincos.c      **** double cos_73(double x){
 620              		.loc 1 182 0
 621              		.cfi_startproc
 622              		@ args = 0, pretend = 0, frame = 16
 623              		@ frame_needed = 1, uses_anonymous_args = 0
 624 04a0 80B5     		push	{r7, lr}
 625              	.LCFI21:
 626              		.cfi_def_cfa_offset 8
 627              		.cfi_offset 14, -4
 628              		.cfi_offset 7, -8
 629 04a2 84B0     		sub	sp, sp, #16
 630              	.LCFI22:
 631              		.cfi_def_cfa_offset 24
 632 04a4 00AF     		add	r7, sp, #0
 633              	.LCFI23:
 634              		.cfi_def_cfa_register 7
 635 04a6 87ED000B 		fstd	d0, [r7, #0]
 183:sincos.c      ****     int quad;						// what quadrant are we in?
 184:sincos.c      **** 
 185:sincos.c      ****     x=fmod(x, twopi);				// Get rid of values > 2* pi
 636              		.loc 1 185 0
 637 04aa 40F20003 		movw	r3, #:lower16:twopi
 638 04ae C0F20003 		movt	r3, #:upper16:twopi
 639 04b2 93ED007B 		fldd	d7, [r3, #0]
 640 04b6 97ED000B 		fldd	d0, [r7, #0]
 641 04ba B0EE471B 		fcpyd	d1, d7
 642 04be FFF7FEFF 		bl	fmod
 643 04c2 87ED000B 		fstd	d0, [r7, #0]
 186:sincos.c      ****     if(x<0)x=-x;					// cos(-x) = cos(x)
 644              		.loc 1 186 0
 645 04c6 97ED007B 		fldd	d7, [r7, #0]
 646 04ca B5EEC07B 		fcmpezd	d7
 647 04ce F1EE10FA 		fmstat
 648 04d2 54BF     		ite	pl
 649 04d4 0023     		movpl	r3, #0
 650 04d6 0123     		movmi	r3, #1
 651 04d8 DBB2     		uxtb	r3, r3
 652 04da 002B     		cmp	r3, #0
 653 04dc 05D0     		beq	.L35
 654              		.loc 1 186 0 is_stmt 0 discriminator 1
 655 04de 97ED007B 		fldd	d7, [r7, #0]
 656 04e2 B1EE477B 		fnegd	d7, d7
 657 04e6 87ED007B 		fstd	d7, [r7, #0]
 658              	.L35:
 187:sincos.c      ****     quad=(int)(x * two_over_pi);			// Get quadrant # (0 to 3) we're in
 659              		.loc 1 187 0 is_stmt 1
 660 04ea 40F20003 		movw	r3, #:lower16:two_over_pi
 661 04ee C0F20003 		movt	r3, #:upper16:two_over_pi
 662 04f2 93ED006B 		fldd	d6, [r3, #0]
 663 04f6 97ED007B 		fldd	d7, [r7, #0]
 664 04fa 26EE077B 		fmuld	d7, d6, d7
 665 04fe FDEEC76B 		ftosizd	s13, d7
 666 0502 16EE903A 		fmrs	r3, s13	@ int
 667 0506 FB60     		str	r3, [r7, #12]
 188:sincos.c      ****     switch (quad){
 668              		.loc 1 188 0
 669 0508 FB68     		ldr	r3, [r7, #12]
 670 050a 032B     		cmp	r3, #3
 671 050c 40D8     		bhi	.L36
 672 050e 01A2     		adr	r2, .L41
 673 0510 52F823F0 		ldr	pc, [r2, r3, lsl #2]
 674              		.align	2
 675              	.L41:
 676 0514 25050000 		.word	.L37+1
 677 0518 33050000 		.word	.L38+1
 678 051c 51050000 		.word	.L39+1
 679 0520 6F050000 		.word	.L40+1
 680              	.L37:
 189:sincos.c      ****         case 0: return  cos_73s(x);
 681              		.loc 1 189 0
 682 0524 97ED000B 		fldd	d0, [r7, #0]
 683 0528 FFF7FEFF 		bl	cos_73s
 684 052c B0EE407B 		fcpyd	d7, d0
 685 0530 30E0     		b	.L42
 686              	.L38:
 190:sincos.c      ****         case 1: return -cos_73s(DP_PI-x);
 687              		.loc 1 190 0
 688 0532 9FED1B6B 		fldd	d6, .L43
 689 0536 97ED007B 		fldd	d7, [r7, #0]
 690 053a 36EE477B 		fsubd	d7, d6, d7
 691 053e B0EE470B 		fcpyd	d0, d7
 692 0542 FFF7FEFF 		bl	cos_73s
 693 0546 B0EE407B 		fcpyd	d7, d0
 694 054a B1EE477B 		fnegd	d7, d7
 695 054e 21E0     		b	.L42
 696              	.L39:
 191:sincos.c      ****         case 2: return -cos_73s(x-DP_PI);
 697              		.loc 1 191 0
 698 0550 97ED006B 		fldd	d6, [r7, #0]
 699 0554 9FED127B 		fldd	d7, .L43
 700 0558 36EE477B 		fsubd	d7, d6, d7
 701 055c B0EE470B 		fcpyd	d0, d7
 702 0560 FFF7FEFF 		bl	cos_73s
 703 0564 B0EE407B 		fcpyd	d7, d0
 704 0568 B1EE477B 		fnegd	d7, d7
 705 056c 12E0     		b	.L42
 706              	.L40:
 192:sincos.c      ****         case 3: return  cos_73s(twopi-x);
 707              		.loc 1 192 0
 708 056e 40F20003 		movw	r3, #:lower16:twopi
 709 0572 C0F20003 		movt	r3, #:upper16:twopi
 710 0576 93ED006B 		fldd	d6, [r3, #0]
 711 057a 97ED007B 		fldd	d7, [r7, #0]
 712 057e 36EE477B 		fsubd	d7, d6, d7
 713 0582 B0EE470B 		fcpyd	d0, d7
 714 0586 FFF7FEFF 		bl	cos_73s
 715 058a B0EE407B 		fcpyd	d7, d0
 716 058e 01E0     		b	.L42
 717              	.L36:
 193:sincos.c      ****     }
 194:sincos.c      ****     return 0.0;
 718              		.loc 1 194 0
 719 0590 9FED057B 		fldd	d7, .L43+8
 720              	.L42:
 195:sincos.c      **** }
 721              		.loc 1 195 0
 722 0594 B0EE470B 		fcpyd	d0, d7
 723 0598 07F11007 		add	r7, r7, #16
 724 059c BD46     		mov	sp, r7
 725 059e 80BD     		pop	{r7, pc}
 726              	.L44:
 727              		.align	3
 728              	.L43:
 729 05a0 182D4454 		.word	1413754136
 730 05a4 FB210940 		.word	1074340347
 731 05a8 00000000 		.word	0
 732 05ac 00000000 		.word	0
 733              		.cfi_endproc
 734              	.LFE7:
 736              		.align	2
 737              		.global	sin_73
 738              		.thumb
 739              		.thumb_func
 741              	sin_73:
 742              	.LFB8:
 196:sincos.c      **** //
 197:sincos.c      **** //   The sine is just cosine shifted a half-pi, so
 198:sincos.c      **** // we'll adjust the argument and call the cosine approximation.
 199:sincos.c      **** //
 200:sincos.c      **** double sin_73(double x){
 743              		.loc 1 200 0
 744              		.cfi_startproc
 745              		@ args = 0, pretend = 0, frame = 8
 746              		@ frame_needed = 1, uses_anonymous_args = 0
 747 05b0 80B5     		push	{r7, lr}
 748              	.LCFI24:
 749              		.cfi_def_cfa_offset 8
 750              		.cfi_offset 14, -4
 751              		.cfi_offset 7, -8
 752 05b2 82B0     		sub	sp, sp, #8
 753              	.LCFI25:
 754              		.cfi_def_cfa_offset 16
 755 05b4 00AF     		add	r7, sp, #0
 756              	.LCFI26:
 757              		.cfi_def_cfa_register 7
 758 05b6 87ED000B 		fstd	d0, [r7, #0]
 201:sincos.c      ****     return cos_73(halfpi-x);
 759              		.loc 1 201 0
 760 05ba 40F20003 		movw	r3, #:lower16:halfpi
 761 05be C0F20003 		movt	r3, #:upper16:halfpi
 762 05c2 93ED006B 		fldd	d6, [r3, #0]
 763 05c6 97ED007B 		fldd	d7, [r7, #0]
 764 05ca 36EE477B 		fsubd	d7, d6, d7
 765 05ce B0EE470B 		fcpyd	d0, d7
 766 05d2 FFF7FEFF 		bl	cos_73
 767 05d6 B0EE407B 		fcpyd	d7, d0
 202:sincos.c      **** }
 768              		.loc 1 202 0
 769 05da B0EE470B 		fcpyd	d0, d7
 770 05de 07F10807 		add	r7, r7, #8
 771 05e2 BD46     		mov	sp, r7
 772 05e4 80BD     		pop	{r7, pc}
 773              		.cfi_endproc
 774              	.LFE8:
 776 05e6 00BF     		.align	2
 777              		.global	cos_121s
 778              		.thumb
 779              		.thumb_func
 781              	cos_121s:
 782              	.LFB9:
 203:sincos.c      **** 
 204:sincos.c      **** // *********************************************************
 205:sincos.c      **** // ***
 206:sincos.c      **** // ***   Routines to compute sine and cosine to 12.1 digits
 207:sincos.c      **** // ***  of accuracy. 
 208:sincos.c      **** // ***
 209:sincos.c      **** // *********************************************************
 210:sincos.c      **** //
 211:sincos.c      **** //		cos_121s computes cosine (x)
 212:sincos.c      **** //
 213:sincos.c      **** //  Accurate to about 12.1 decimal digits over the range [0, pi/2].
 214:sincos.c      **** //  The input argument is in radians.
 215:sincos.c      **** //
 216:sincos.c      **** //  Algorithm:
 217:sincos.c      **** //		cos(x)= c1 + c2*x**2 + c3*x**4 + c4*x**6 + c5*x**8 + c6*x**10 + c7*x**12
 218:sincos.c      **** //   which is the same as:
 219:sincos.c      **** //		cos(x)= c1 + x**2(c2 + c3*x**2 + c4*x**4 + c5*x**6 + c6*x**8 + c7*x**10)
 220:sincos.c      **** //		cos(x)= c1 + x**2(c2 + x**2(c3 + c4*x**2 + c5*x**4 + c6*x**6 + c7*x**8 ))
 221:sincos.c      **** //		cos(x)= c1 + x**2(c2 + x**2(c3 + x**2(c4 + c5*x**2 + c6*x**4 + c7*x**6 )))
 222:sincos.c      **** //		cos(x)= c1 + x**2(c2 + x**2(c3 + x**2(c4 + x**2(c5 + c6*x**2 + c7*x**4 ))))
 223:sincos.c      **** //		cos(x)= c1 + x**2(c2 + x**2(c3 + x**2(c4 + x**2(c5 + x**2(c6 + c7*x**2 )))))
 224:sincos.c      **** //
 225:sincos.c      **** double cos_121s(double x)
 226:sincos.c      **** {
 783              		.loc 1 226 0
 784              		.cfi_startproc
 785              		@ args = 0, pretend = 0, frame = 72
 786              		@ frame_needed = 1, uses_anonymous_args = 0
 787              		@ link register save eliminated.
 788 05e8 80B4     		push	{r7}
 789              	.LCFI27:
 790              		.cfi_def_cfa_offset 4
 791              		.cfi_offset 7, -4
 792 05ea 93B0     		sub	sp, sp, #76
 793              	.LCFI28:
 794              		.cfi_def_cfa_offset 80
 795 05ec 00AF     		add	r7, sp, #0
 796              	.LCFI29:
 797              		.cfi_def_cfa_register 7
 798 05ee 87ED000B 		fstd	d0, [r7, #0]
 227:sincos.c      ****     const double c1= 0.99999999999925182;
 799              		.loc 1 227 0
 800 05f2 33A3     		adr	r3, .L47
 801 05f4 D3E90023 		ldrd	r2, [r3]
 802 05f8 C7E91023 		strd	r2, [r7, #64]
 228:sincos.c      ****     const double c2=-0.49999999997024012;
 803              		.loc 1 228 0
 804 05fc 32A3     		adr	r3, .L47+8
 805 05fe D3E90023 		ldrd	r2, [r3]
 806 0602 C7E90E23 		strd	r2, [r7, #56]
 229:sincos.c      ****     const double c3= 0.041666666473384543;
 807              		.loc 1 229 0
 808 0606 32A3     		adr	r3, .L47+16
 809 0608 D3E90023 		ldrd	r2, [r3]
 810 060c C7E90C23 		strd	r2, [r7, #48]
 230:sincos.c      ****     const double c4=-0.001388888418000423;
 811              		.loc 1 230 0
 812 0610 31A3     		adr	r3, .L47+24
 813 0612 D3E90023 		ldrd	r2, [r3]
 814 0616 C7E90A23 		strd	r2, [r7, #40]
 231:sincos.c      ****     const double c5= 0.0000248010406484558;
 815              		.loc 1 231 0
 816 061a 31A3     		adr	r3, .L47+32
 817 061c D3E90023 		ldrd	r2, [r3]
 818 0620 C7E90823 		strd	r2, [r7, #32]
 232:sincos.c      ****     const double c6=-0.0000002752469638432;
 819              		.loc 1 232 0
 820 0624 30A3     		adr	r3, .L47+40
 821 0626 D3E90023 		ldrd	r2, [r3]
 822 062a C7E90623 		strd	r2, [r7, #24]
 233:sincos.c      ****     const double c7= 0.0000000019907856854;
 823              		.loc 1 233 0
 824 062e 30A3     		adr	r3, .L47+48
 825 0630 D3E90023 		ldrd	r2, [r3]
 826 0634 C7E90423 		strd	r2, [r7, #16]
 234:sincos.c      **** 
 235:sincos.c      ****     double x2;							// The input argument squared
 236:sincos.c      ****         x2=x * x;
 827              		.loc 1 236 0
 828 0638 97ED006B 		fldd	d6, [r7, #0]
 829 063c 97ED007B 		fldd	d7, [r7, #0]
 830 0640 26EE077B 		fmuld	d7, d6, d7
 831 0644 87ED027B 		fstd	d7, [r7, #8]
 237:sincos.c      ****         return (c1 + x2*(c2 + x2*(c3 + x2*(c4 + x2*(c5 + x2*(c6 + c7*x2))))));
 832              		.loc 1 237 0
 833 0648 97ED046B 		fldd	d6, [r7, #16]
 834 064c 97ED027B 		fldd	d7, [r7, #8]
 835 0650 26EE077B 		fmuld	d7, d6, d7
 836 0654 97ED066B 		fldd	d6, [r7, #24]
 837 0658 37EE066B 		faddd	d6, d7, d6
 838 065c 97ED027B 		fldd	d7, [r7, #8]
 839 0660 26EE077B 		fmuld	d7, d6, d7
 840 0664 97ED086B 		fldd	d6, [r7, #32]
 841 0668 37EE066B 		faddd	d6, d7, d6
 842 066c 97ED027B 		fldd	d7, [r7, #8]
 843 0670 26EE077B 		fmuld	d7, d6, d7
 844 0674 97ED0A6B 		fldd	d6, [r7, #40]
 845 0678 37EE066B 		faddd	d6, d7, d6
 846 067c 97ED027B 		fldd	d7, [r7, #8]
 847 0680 26EE077B 		fmuld	d7, d6, d7
 848 0684 97ED0C6B 		fldd	d6, [r7, #48]
 849 0688 37EE066B 		faddd	d6, d7, d6
 850 068c 97ED027B 		fldd	d7, [r7, #8]
 851 0690 26EE077B 		fmuld	d7, d6, d7
 852 0694 97ED0E6B 		fldd	d6, [r7, #56]
 853 0698 37EE066B 		faddd	d6, d7, d6
 854 069c 97ED027B 		fldd	d7, [r7, #8]
 855 06a0 26EE077B 		fmuld	d7, d6, d7
 856 06a4 97ED106B 		fldd	d6, [r7, #64]
 857 06a8 37EE067B 		faddd	d7, d7, d6
 238:sincos.c      **** }
 858              		.loc 1 238 0
 859 06ac B0EE470B 		fcpyd	d0, d7
 860 06b0 07F14C07 		add	r7, r7, #76
 861 06b4 BD46     		mov	sp, r7
 862 06b6 80BC     		pop	{r7}
 863 06b8 7047     		bx	lr
 864              	.L48:
 865 06ba 00BFAFF3 		.align	3
 865      0080
 866              	.L47:
 867 06c0 ADE5FFFF 		.word	-6739
 868 06c4 FFFFEF3F 		.word	1072693247
 869 06c8 D6D1F7FF 		.word	-536106
 870 06cc FFFFDFBF 		.word	-1075838977
 871 06d0 2C4DAC53 		.word	1403800876
 872 06d4 5555A53F 		.word	1067799893
 873 06d8 9C975195 		.word	-1789814884
 874 06dc 6BC156BF 		.word	-1084833429
 875 06e0 3CC92E89 		.word	-1993422532
 876 06e4 7A01FA3E 		.word	1056571770
 877 06e8 6324F3F2 		.word	-218946461
 878 06ec B47892BE 		.word	-1097697100
 879 06f0 455B78B5 		.word	-1250403515
 880 06f4 C819213E 		.word	1042356680
 881              		.cfi_endproc
 882              	.LFE9:
 884              		.align	2
 885              		.global	cos_121sm
 886              		.thumb
 887              		.thumb_func
 889              	cos_121sm:
 890              	.LFB10:
 239:sincos.c      **** 
 240:sincos.c      **** double cos_121sm(double x)
 241:sincos.c      **** {
 891              		.loc 1 241 0
 892              		.cfi_startproc
 893              		@ args = 0, pretend = 0, frame = 8
 894              		@ frame_needed = 1, uses_anonymous_args = 0
 895 06f8 80B5     		push	{r7, lr}
 896              	.LCFI30:
 897              		.cfi_def_cfa_offset 8
 898              		.cfi_offset 14, -4
 899              		.cfi_offset 7, -8
 900 06fa 82B0     		sub	sp, sp, #8
 901              	.LCFI31:
 902              		.cfi_def_cfa_offset 16
 903 06fc 00AF     		add	r7, sp, #0
 904              	.LCFI32:
 905              		.cfi_def_cfa_register 7
 906 06fe 87ED000B 		fstd	d0, [r7, #0]
 242:sincos.c      ****     if(abs(x) < 0.5)
 907              		.loc 1 242 0
 908 0702 97ED007B 		fldd	d7, [r7, #0]
 909 0706 FDEEC76B 		ftosizd	s13, d7
 910 070a 16EE903A 		fmrs	r3, s13	@ int
 911 070e 002B     		cmp	r3, #0
 912 0710 B8BF     		it	lt
 913 0712 5B42     		rsblt	r3, r3, #0
 914 0714 07EE903A 		fmsr	s15, r3	@ int
 915 0718 B8EEE76B 		fsitod	d6, s15
 916 071c B6EE007B 		fconstd	d7, #96
 917 0720 B4EEC76B 		fcmped	d6, d7
 918 0724 F1EE10FA 		fmstat
 919 0728 54BF     		ite	pl
 920 072a 0023     		movpl	r3, #0
 921 072c 0123     		movmi	r3, #1
 922 072e DBB2     		uxtb	r3, r3
 923 0730 002B     		cmp	r3, #0
 924 0732 0ED0     		beq	.L50
 243:sincos.c      ****     {
 244:sincos.c      ****         return 1-(x*x/2);
 925              		.loc 1 244 0
 926 0734 97ED006B 		fldd	d6, [r7, #0]
 927 0738 97ED007B 		fldd	d7, [r7, #0]
 928 073c 26EE077B 		fmuld	d7, d6, d7
 929 0740 B0EE006B 		fconstd	d6, #0
 930 0744 87EE067B 		fdivd	d7, d7, d6
 931 0748 B7EE006B 		fconstd	d6, #112
 932 074c 36EE477B 		fsubd	d7, d6, d7
 933 0750 03E0     		b	.L49
 934              	.L50:
 245:sincos.c      ****     }
 246:sincos.c      ****     else
 247:sincos.c      ****     {
 248:sincos.c      ****         cos_121s(x);
 935              		.loc 1 248 0
 936 0752 97ED000B 		fldd	d0, [r7, #0]
 937 0756 FFF7FEFF 		bl	cos_121s
 938              	.L49:
 249:sincos.c      ****     }
 250:sincos.c      **** 
 251:sincos.c      **** 
 252:sincos.c      **** 
 253:sincos.c      **** }
 939              		.loc 1 253 0
 940 075a B0EE470B 		fcpyd	d0, d7
 941 075e 07F10807 		add	r7, r7, #8
 942 0762 BD46     		mov	sp, r7
 943 0764 80BD     		pop	{r7, pc}
 944              		.cfi_endproc
 945              	.LFE10:
 947 0766 00BF     		.align	2
 948              		.global	cos_121
 949              		.thumb
 950              		.thumb_func
 952              	cos_121:
 953              	.LFB11:
 254:sincos.c      **** //
 255:sincos.c      **** //  This is the main cosine approximation "driver"
 256:sincos.c      **** // It reduces the input argument's range to [0, pi/2],
 257:sincos.c      **** // and then calls the approximator. 
 258:sincos.c      **** // See the notes for an explanation of the range reduction.
 259:sincos.c      **** //
 260:sincos.c      **** double cos_121(double x){
 954              		.loc 1 260 0
 955              		.cfi_startproc
 956              		@ args = 0, pretend = 0, frame = 16
 957              		@ frame_needed = 1, uses_anonymous_args = 0
 958 0768 80B5     		push	{r7, lr}
 959              	.LCFI33:
 960              		.cfi_def_cfa_offset 8
 961              		.cfi_offset 14, -4
 962              		.cfi_offset 7, -8
 963 076a 84B0     		sub	sp, sp, #16
 964              	.LCFI34:
 965              		.cfi_def_cfa_offset 24
 966 076c 00AF     		add	r7, sp, #0
 967              	.LCFI35:
 968              		.cfi_def_cfa_register 7
 969 076e 87ED000B 		fstd	d0, [r7, #0]
 261:sincos.c      ****     int quad;						// what quadrant are we in?
 262:sincos.c      **** 
 263:sincos.c      ****     x=fmod(x, twopi);				// Get rid of values > 2* pi
 970              		.loc 1 263 0
 971 0772 40F20003 		movw	r3, #:lower16:twopi
 972 0776 C0F20003 		movt	r3, #:upper16:twopi
 973 077a 93ED007B 		fldd	d7, [r3, #0]
 974 077e 97ED000B 		fldd	d0, [r7, #0]
 975 0782 B0EE471B 		fcpyd	d1, d7
 976 0786 FFF7FEFF 		bl	fmod
 977 078a 87ED000B 		fstd	d0, [r7, #0]
 264:sincos.c      ****     if(x<0)x=-x;					// cos(-x) = cos(x)
 978              		.loc 1 264 0
 979 078e 97ED007B 		fldd	d7, [r7, #0]
 980 0792 B5EEC07B 		fcmpezd	d7
 981 0796 F1EE10FA 		fmstat
 982 079a 54BF     		ite	pl
 983 079c 0023     		movpl	r3, #0
 984 079e 0123     		movmi	r3, #1
 985 07a0 DBB2     		uxtb	r3, r3
 986 07a2 002B     		cmp	r3, #0
 987 07a4 05D0     		beq	.L52
 988              		.loc 1 264 0 is_stmt 0 discriminator 1
 989 07a6 97ED007B 		fldd	d7, [r7, #0]
 990 07aa B1EE477B 		fnegd	d7, d7
 991 07ae 87ED007B 		fstd	d7, [r7, #0]
 992              	.L52:
 265:sincos.c      ****     quad=(int) (x * two_over_pi);			// Get quadrant # (0 to 3) we're in
 993              		.loc 1 265 0 is_stmt 1
 994 07b2 40F20003 		movw	r3, #:lower16:two_over_pi
 995 07b6 C0F20003 		movt	r3, #:upper16:two_over_pi
 996 07ba 93ED006B 		fldd	d6, [r3, #0]
 997 07be 97ED007B 		fldd	d7, [r7, #0]
 998 07c2 26EE077B 		fmuld	d7, d6, d7
 999 07c6 FDEEC76B 		ftosizd	s13, d7
 1000 07ca 16EE903A 		fmrs	r3, s13	@ int
 1001 07ce FB60     		str	r3, [r7, #12]
 266:sincos.c      ****     switch (quad){
 1002              		.loc 1 266 0
 1003 07d0 FB68     		ldr	r3, [r7, #12]
 1004 07d2 032B     		cmp	r3, #3
 1005 07d4 40D8     		bhi	.L53
 1006 07d6 01A2     		adr	r2, .L58
 1007 07d8 52F823F0 		ldr	pc, [r2, r3, lsl #2]
 1008              		.align	2
 1009              	.L58:
 1010 07dc ED070000 		.word	.L54+1
 1011 07e0 FB070000 		.word	.L55+1
 1012 07e4 19080000 		.word	.L56+1
 1013 07e8 37080000 		.word	.L57+1
 1014              	.L54:
 267:sincos.c      ****         case 0: return  cos_121s(x);
 1015              		.loc 1 267 0
 1016 07ec 97ED000B 		fldd	d0, [r7, #0]
 1017 07f0 FFF7FEFF 		bl	cos_121s
 1018 07f4 B0EE407B 		fcpyd	d7, d0
 1019 07f8 30E0     		b	.L59
 1020              	.L55:
 268:sincos.c      ****         case 1: return -cos_121s(DP_PI-x);
 1021              		.loc 1 268 0
 1022 07fa 9FED1B6B 		fldd	d6, .L60
 1023 07fe 97ED007B 		fldd	d7, [r7, #0]
 1024 0802 36EE477B 		fsubd	d7, d6, d7
 1025 0806 B0EE470B 		fcpyd	d0, d7
 1026 080a FFF7FEFF 		bl	cos_121s
 1027 080e B0EE407B 		fcpyd	d7, d0
 1028 0812 B1EE477B 		fnegd	d7, d7
 1029 0816 21E0     		b	.L59
 1030              	.L56:
 269:sincos.c      ****         case 2: return -cos_121s(x-DP_PI);
 1031              		.loc 1 269 0
 1032 0818 97ED006B 		fldd	d6, [r7, #0]
 1033 081c 9FED127B 		fldd	d7, .L60
 1034 0820 36EE477B 		fsubd	d7, d6, d7
 1035 0824 B0EE470B 		fcpyd	d0, d7
 1036 0828 FFF7FEFF 		bl	cos_121s
 1037 082c B0EE407B 		fcpyd	d7, d0
 1038 0830 B1EE477B 		fnegd	d7, d7
 1039 0834 12E0     		b	.L59
 1040              	.L57:
 270:sincos.c      ****         case 3: return  cos_121s(twopi-x);
 1041              		.loc 1 270 0
 1042 0836 40F20003 		movw	r3, #:lower16:twopi
 1043 083a C0F20003 		movt	r3, #:upper16:twopi
 1044 083e 93ED006B 		fldd	d6, [r3, #0]
 1045 0842 97ED007B 		fldd	d7, [r7, #0]
 1046 0846 36EE477B 		fsubd	d7, d6, d7
 1047 084a B0EE470B 		fcpyd	d0, d7
 1048 084e FFF7FEFF 		bl	cos_121s
 1049 0852 B0EE407B 		fcpyd	d7, d0
 1050 0856 01E0     		b	.L59
 1051              	.L53:
 271:sincos.c      ****     }
 272:sincos.c      ****     return 0.0;
 1052              		.loc 1 272 0
 1053 0858 9FED057B 		fldd	d7, .L60+8
 1054              	.L59:
 273:sincos.c      **** }
 1055              		.loc 1 273 0
 1056 085c B0EE470B 		fcpyd	d0, d7
 1057 0860 07F11007 		add	r7, r7, #16
 1058 0864 BD46     		mov	sp, r7
 1059 0866 80BD     		pop	{r7, pc}
 1060              	.L61:
 1061              		.align	3
 1062              	.L60:
 1063 0868 182D4454 		.word	1413754136
 1064 086c FB210940 		.word	1074340347
 1065 0870 00000000 		.word	0
 1066 0874 00000000 		.word	0
 1067              		.cfi_endproc
 1068              	.LFE11:
 1070              		.align	2
 1071              		.global	sin_121
 1072              		.thumb
 1073              		.thumb_func
 1075              	sin_121:
 1076              	.LFB12:
 274:sincos.c      **** //
 275:sincos.c      **** //   The sine is just cosine shifted a half-pi, so
 276:sincos.c      **** // we'll adjust the argument and call the cosine approximation.
 277:sincos.c      **** //
 278:sincos.c      **** double sin_121(double x){
 1077              		.loc 1 278 0
 1078              		.cfi_startproc
 1079              		@ args = 0, pretend = 0, frame = 8
 1080              		@ frame_needed = 1, uses_anonymous_args = 0
 1081 0878 80B5     		push	{r7, lr}
 1082              	.LCFI36:
 1083              		.cfi_def_cfa_offset 8
 1084              		.cfi_offset 14, -4
 1085              		.cfi_offset 7, -8
 1086 087a 82B0     		sub	sp, sp, #8
 1087              	.LCFI37:
 1088              		.cfi_def_cfa_offset 16
 1089 087c 00AF     		add	r7, sp, #0
 1090              	.LCFI38:
 1091              		.cfi_def_cfa_register 7
 1092 087e 87ED000B 		fstd	d0, [r7, #0]
 279:sincos.c      ****     if(abs(x) < 0.5)
 1093              		.loc 1 279 0
 1094 0882 97ED007B 		fldd	d7, [r7, #0]
 1095 0886 FDEEC76B 		ftosizd	s13, d7
 1096 088a 16EE903A 		fmrs	r3, s13	@ int
 1097 088e 002B     		cmp	r3, #0
 1098 0890 B8BF     		it	lt
 1099 0892 5B42     		rsblt	r3, r3, #0
 1100 0894 07EE903A 		fmsr	s15, r3	@ int
 1101 0898 B8EEE76B 		fsitod	d6, s15
 1102 089c B6EE007B 		fconstd	d7, #96
 1103 08a0 B4EEC76B 		fcmped	d6, d7
 1104 08a4 F1EE10FA 		fmstat
 1105 08a8 54BF     		ite	pl
 1106 08aa 0023     		movpl	r3, #0
 1107 08ac 0123     		movmi	r3, #1
 1108 08ae DBB2     		uxtb	r3, r3
 1109 08b0 002B     		cmp	r3, #0
 1110 08b2 02D0     		beq	.L63
 280:sincos.c      ****     {
 281:sincos.c      ****         return x;
 1111              		.loc 1 281 0
 1112 08b4 97ED007B 		fldd	d7, [r7, #0]
 1113 08b8 0FE0     		b	.L64
 1114              	.L63:
 282:sincos.c      ****     }
 283:sincos.c      ****     else
 284:sincos.c      ****     {
 285:sincos.c      ****         return cos_121(halfpi-x);
 1115              		.loc 1 285 0
 1116 08ba 40F20003 		movw	r3, #:lower16:halfpi
 1117 08be C0F20003 		movt	r3, #:upper16:halfpi
 1118 08c2 93ED006B 		fldd	d6, [r3, #0]
 1119 08c6 97ED007B 		fldd	d7, [r7, #0]
 1120 08ca 36EE477B 		fsubd	d7, d6, d7
 1121 08ce B0EE470B 		fcpyd	d0, d7
 1122 08d2 FFF7FEFF 		bl	cos_121
 1123 08d6 B0EE407B 		fcpyd	d7, d0
 1124              	.L64:
 286:sincos.c      ****     }
 287:sincos.c      **** }
 1125              		.loc 1 287 0
 1126 08da B0EE470B 		fcpyd	d0, d7
 1127 08de 07F10807 		add	r7, r7, #8
 1128 08e2 BD46     		mov	sp, r7
 1129 08e4 80BD     		pop	{r7, pc}
 1130              		.cfi_endproc
 1131              	.LFE12:
 1133 08e6 00BF     		.align	2
 1134              		.global	Calc_Distance
 1135              		.thumb
 1136              		.thumb_func
 1138              	Calc_Distance:
 1139              	.LFB13:
 1140              		.file 2 "geometry.c"
   1:geometry.c    **** #include "geometry.h"
   2:geometry.c    **** #include <math.h>
   3:geometry.c    **** #include <string.h>
   4:geometry.c    **** #include "sincos.c"
   5:geometry.c    **** #define PI 3.14159265f
   6:geometry.c    **** #define PI_OVER_180 (0.017453293) // (3.1415927/180.0)
   7:geometry.c    **** 
   8:geometry.c    **** extern const PT_T waypoints[];
   9:geometry.c    **** 
  10:geometry.c    **** 
  11:geometry.c    **** #define CALC_DIST (0)
  12:geometry.c    **** 
  13:geometry.c    **** #if 1 // Table holds precalculated sin/cos for p2. Table Lat/Lon values are in radians
  14:geometry.c    **** float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
 1141              		.loc 2 14 0
 1142              		.cfi_startproc
 1143              		@ args = 0, pretend = 0, frame = 8
 1144              		@ frame_needed = 1, uses_anonymous_args = 0
 1145 08e8 80B5     		push	{r7, lr}
 1146              	.LCFI39:
 1147              		.cfi_def_cfa_offset 8
 1148              		.cfi_offset 14, -4
 1149              		.cfi_offset 7, -8
 1150 08ea 2DED048B 		fstmfdd	sp!, {d8, d9}
 1151              	.LCFI40:
 1152              		.cfi_def_cfa_offset 24
 1153              		.cfi_offset 82, -16
 1154              		.cfi_offset 80, -24
 1155 08ee 82B0     		sub	sp, sp, #8
 1156              	.LCFI41:
 1157              		.cfi_def_cfa_offset 32
 1158 08f0 00AF     		add	r7, sp, #0
 1159              	.LCFI42:
 1160              		.cfi_def_cfa_register 7
 1161 08f2 7860     		str	r0, [r7, #4]
 1162 08f4 3960     		str	r1, [r7, #0]
  15:geometry.c    ****     // calculates distance in kilometers between locations (represented in radians)
  16:geometry.c    **** 
  17:geometry.c    ****     return acosFunc(p1->SinLat * p2->SinLat + 
 1163              		.loc 2 17 0
 1164 08f6 7B68     		ldr	r3, [r7, #4]
 1165 08f8 93ED017A 		flds	s14, [r3, #4]
 1166 08fc 3B68     		ldr	r3, [r7, #0]
 1167 08fe D3ED017A 		flds	s15, [r3, #4]
 1168 0902 67EE277A 		fmuls	s15, s14, s15
 1169 0906 B7EEE78A 		fcvtds	d8, s15
  18:geometry.c    ****             p1->CosLat * p2->CosLat*
 1170              		.loc 2 18 0
 1171 090a 7B68     		ldr	r3, [r7, #4]
 1172 090c 93ED027A 		flds	s14, [r3, #8]
 1173 0910 3B68     		ldr	r3, [r7, #0]
 1174 0912 D3ED027A 		flds	s15, [r3, #8]
 1175 0916 67EE277A 		fmuls	s15, s14, s15
 1176 091a B7EEE79A 		fcvtds	d9, s15
  19:geometry.c    ****             cosFunc(p2->Lon - p1->Lon)); // * 6371;
 1177              		.loc 2 19 0
 1178 091e 3B68     		ldr	r3, [r7, #0]
 1179 0920 93ED037A 		flds	s14, [r3, #12]
 1180 0924 7B68     		ldr	r3, [r7, #4]
 1181 0926 D3ED037A 		flds	s15, [r3, #12]
 1182 092a 77EE677A 		fsubs	s15, s14, s15
 1183 092e B7EEE77A 		fcvtds	d7, s15
 1184 0932 B0EE470B 		fcpyd	d0, d7
 1185 0936 FFF7FEFF 		bl	cos_121sm
 1186 093a B0EE407B 		fcpyd	d7, d0
  18:geometry.c    ****             p1->CosLat * p2->CosLat*
 1187              		.loc 2 18 0
 1188 093e 29EE077B 		fmuld	d7, d9, d7
  17:geometry.c    ****     return acosFunc(p1->SinLat * p2->SinLat + 
 1189              		.loc 2 17 0
 1190 0942 38EE077B 		faddd	d7, d8, d7
 1191 0946 B0EE470B 		fcpyd	d0, d7
 1192 094a FFF7FEFF 		bl	acos
 1193 094e B0EE407B 		fcpyd	d7, d0
 1194 0952 F7EEC77B 		fcvtsd	s15, d7
  20:geometry.c    **** }
 1195              		.loc 2 20 0
 1196 0956 B0EE670A 		fcpys	s0, s15
 1197 095a 07F10807 		add	r7, r7, #8
 1198 095e BD46     		mov	sp, r7
 1199 0960 BDEC048B 		fldmfdd	sp!, {d8, d9}
 1200 0964 80BD     		pop	{r7, pc}
 1201              		.cfi_endproc
 1202              	.LFE13:
 1204 0966 00BF     		.align	2
 1205              		.global	Calc_Bearing
 1206              		.thumb
 1207              		.thumb_func
 1209              	Calc_Bearing:
 1210              	.LFB14:
  21:geometry.c    **** float Calc_Bearing( PT_T * p1,  const PT_T * p2){
 1211              		.loc 2 21 0
 1212              		.cfi_startproc
 1213              		@ args = 0, pretend = 0, frame = 24
 1214              		@ frame_needed = 1, uses_anonymous_args = 0
 1215 0968 80B5     		push	{r7, lr}
 1216              	.LCFI43:
 1217              		.cfi_def_cfa_offset 8
 1218              		.cfi_offset 14, -4
 1219              		.cfi_offset 7, -8
 1220 096a 2DED048B 		fstmfdd	sp!, {d8, d9}
 1221              	.LCFI44:
 1222              		.cfi_def_cfa_offset 24
 1223              		.cfi_offset 82, -16
 1224              		.cfi_offset 80, -24
 1225 096e 86B0     		sub	sp, sp, #24
 1226              	.LCFI45:
 1227              		.cfi_def_cfa_offset 48
 1228 0970 00AF     		add	r7, sp, #0
 1229              	.LCFI46:
 1230              		.cfi_def_cfa_register 7
 1231 0972 7860     		str	r0, [r7, #4]
 1232 0974 3960     		str	r1, [r7, #0]
  22:geometry.c    ****     // calculates bearing in degrees between locations (represented in degrees)	
  23:geometry.c    ****     float term1=0.0, term2=0.0;
 1233              		.loc 2 23 0
 1234 0976 454B     		ldr	r3, .L68+12	@ float
 1235 0978 3B61     		str	r3, [r7, #16]	@ float
 1236 097a 444B     		ldr	r3, .L68+12	@ float
 1237 097c FB60     		str	r3, [r7, #12]	@ float
  24:geometry.c    ****     float angle=0.0;
 1238              		.loc 2 24 0
 1239 097e 434B     		ldr	r3, .L68+12	@ float
 1240 0980 7B61     		str	r3, [r7, #20]	@ float
  25:geometry.c    **** 
  26:geometry.c    ****     term1 = sineFunc(p1->Lon - p2->Lon)*p2->CosLat;
 1241              		.loc 2 26 0
 1242 0982 7B68     		ldr	r3, [r7, #4]
 1243 0984 93ED037A 		flds	s14, [r3, #12]
 1244 0988 3B68     		ldr	r3, [r7, #0]
 1245 098a D3ED037A 		flds	s15, [r3, #12]
 1246 098e 77EE677A 		fsubs	s15, s14, s15
 1247 0992 B7EEE77A 		fcvtds	d7, s15
 1248 0996 B0EE470B 		fcpyd	d0, d7
 1249 099a FFF7FEFF 		bl	sin_121
 1250 099e B0EE406B 		fcpyd	d6, d0
 1251 09a2 3B68     		ldr	r3, [r7, #0]
 1252 09a4 D3ED027A 		flds	s15, [r3, #8]
 1253 09a8 B7EEE77A 		fcvtds	d7, s15
 1254 09ac 26EE077B 		fmuld	d7, d6, d7
 1255 09b0 F7EEC77B 		fcvtsd	s15, d7
 1256 09b4 C7ED047A 		fsts	s15, [r7, #16]
  27:geometry.c    ****     term2 = p1->CosLat*p2->SinLat - 
 1257              		.loc 2 27 0
 1258 09b8 7B68     		ldr	r3, [r7, #4]
 1259 09ba 93ED027A 		flds	s14, [r3, #8]
 1260 09be 3B68     		ldr	r3, [r7, #0]
 1261 09c0 D3ED017A 		flds	s15, [r3, #4]
 1262 09c4 67EE277A 		fmuls	s15, s14, s15
 1263 09c8 B7EEE78A 		fcvtds	d8, s15
  28:geometry.c    ****         p1->SinLat*p2->CosLat*cosFunc(p1->Lon - p2->Lon);
 1264              		.loc 2 28 0
 1265 09cc 7B68     		ldr	r3, [r7, #4]
 1266 09ce 93ED017A 		flds	s14, [r3, #4]
 1267 09d2 3B68     		ldr	r3, [r7, #0]
 1268 09d4 D3ED027A 		flds	s15, [r3, #8]
 1269 09d8 67EE277A 		fmuls	s15, s14, s15
 1270 09dc B7EEE79A 		fcvtds	d9, s15
 1271 09e0 7B68     		ldr	r3, [r7, #4]
 1272 09e2 93ED037A 		flds	s14, [r3, #12]
 1273 09e6 3B68     		ldr	r3, [r7, #0]
 1274 09e8 D3ED037A 		flds	s15, [r3, #12]
 1275 09ec 77EE677A 		fsubs	s15, s14, s15
 1276 09f0 B7EEE77A 		fcvtds	d7, s15
 1277 09f4 B0EE470B 		fcpyd	d0, d7
 1278 09f8 FFF7FEFF 		bl	cos_121sm
 1279 09fc B0EE407B 		fcpyd	d7, d0
 1280 0a00 29EE077B 		fmuld	d7, d9, d7
  27:geometry.c    ****     term2 = p1->CosLat*p2->SinLat - 
 1281              		.loc 2 27 0
 1282 0a04 38EE477B 		fsubd	d7, d8, d7
 1283 0a08 F7EEC77B 		fcvtsd	s15, d7
 1284 0a0c C7ED037A 		fsts	s15, [r7, #12]
  29:geometry.c    ****     angle = atan2Func(term1, term2) * (180/PI);
 1285              		.loc 2 29 0
 1286 0a10 D7ED047A 		flds	s15, [r7, #16]
 1287 0a14 B7EEE76A 		fcvtds	d6, s15
 1288 0a18 D7ED037A 		flds	s15, [r7, #12]
 1289 0a1c B7EEE77A 		fcvtds	d7, s15
 1290 0a20 B0EE460B 		fcpyd	d0, d6
 1291 0a24 B0EE471B 		fcpyd	d1, d7
 1292 0a28 FFF7FEFF 		bl	atan2
 1293 0a2c B0EE406B 		fcpyd	d6, d0
 1294 0a30 9FED137B 		fldd	d7, .L68
 1295 0a34 26EE077B 		fmuld	d7, d6, d7
 1296 0a38 F7EEC77B 		fcvtsd	s15, d7
 1297 0a3c C7ED057A 		fsts	s15, [r7, #20]
  30:geometry.c    ****     if (angle < 0.0)
 1298              		.loc 2 30 0
 1299 0a40 D7ED057A 		flds	s15, [r7, #20]
 1300 0a44 F5EEC07A 		fcmpezs	s15
 1301 0a48 F1EE10FA 		fmstat
 1302 0a4c 54BF     		ite	pl
 1303 0a4e 0023     		movpl	r3, #0
 1304 0a50 0123     		movmi	r3, #1
 1305 0a52 DBB2     		uxtb	r3, r3
 1306 0a54 002B     		cmp	r3, #0
 1307 0a56 07D0     		beq	.L67
  31:geometry.c    ****         angle += 360;
 1308              		.loc 2 31 0
 1309 0a58 97ED057A 		flds	s14, [r7, #20]
 1310 0a5c DFED0A7A 		flds	s15, .L68+8
 1311 0a60 77EE277A 		fadds	s15, s14, s15
 1312 0a64 C7ED057A 		fsts	s15, [r7, #20]
 1313              	.L67:
  32:geometry.c    ****     return angle;
 1314              		.loc 2 32 0
 1315 0a68 7B69     		ldr	r3, [r7, #20]	@ float
 1316 0a6a 07EE903A 		fmsr	s15, r3
  33:geometry.c    **** }
 1317              		.loc 2 33 0
 1318 0a6e B0EE670A 		fcpys	s0, s15
 1319 0a72 07F11807 		add	r7, r7, #24
 1320 0a76 BD46     		mov	sp, r7
 1321 0a78 BDEC048B 		fldmfdd	sp!, {d8, d9}
 1322 0a7c 80BD     		pop	{r7, pc}
 1323              	.L69:
 1324 0a7e 00BF     		.align	3
 1325              	.L68:
 1326 0a80 00000000 		.word	0
 1327 0a84 DCA54C40 		.word	1078765020
 1328 0a88 0000B443 		.word	1135869952
 1329 0a8c 00000000 		.word	0
 1330              		.cfi_endproc
 1331              	.LFE14:
 1333              		.align	2
 1334              		.global	Calc_Closeness
 1335              		.thumb
 1336              		.thumb_func
 1338              	Calc_Closeness:
 1339              	.LFB15:
  34:geometry.c    **** 
  35:geometry.c    **** float Calc_Closeness( PT_T * p1,  const PT_T * p2) { 
 1340              		.loc 2 35 0
 1341              		.cfi_startproc
 1342              		@ args = 0, pretend = 0, frame = 8
 1343              		@ frame_needed = 1, uses_anonymous_args = 0
 1344 0a90 80B5     		push	{r7, lr}
 1345              	.LCFI47:
 1346              		.cfi_def_cfa_offset 8
 1347              		.cfi_offset 14, -4
 1348              		.cfi_offset 7, -8
 1349 0a92 2DED048B 		fstmfdd	sp!, {d8, d9}
 1350              	.LCFI48:
 1351              		.cfi_def_cfa_offset 24
 1352              		.cfi_offset 82, -16
 1353              		.cfi_offset 80, -24
 1354 0a96 82B0     		sub	sp, sp, #8
 1355              	.LCFI49:
 1356              		.cfi_def_cfa_offset 32
 1357 0a98 00AF     		add	r7, sp, #0
 1358              	.LCFI50:
 1359              		.cfi_def_cfa_register 7
 1360 0a9a 7860     		str	r0, [r7, #4]
 1361 0a9c 3960     		str	r1, [r7, #0]
  36:geometry.c    ****     // calculates closeness (decreases as distance increases) of locations
  37:geometry.c    **** 
  38:geometry.c    ****     return p1->SinLat * p2->SinLat + 
 1362              		.loc 2 38 0
 1363 0a9e 7B68     		ldr	r3, [r7, #4]
 1364 0aa0 93ED017A 		flds	s14, [r3, #4]
 1365 0aa4 3B68     		ldr	r3, [r7, #0]
 1366 0aa6 D3ED017A 		flds	s15, [r3, #4]
 1367 0aaa 67EE277A 		fmuls	s15, s14, s15
 1368 0aae B7EEE78A 		fcvtds	d8, s15
  39:geometry.c    ****         p1->CosLat * p2->CosLat*
 1369              		.loc 2 39 0
 1370 0ab2 7B68     		ldr	r3, [r7, #4]
 1371 0ab4 93ED027A 		flds	s14, [r3, #8]
 1372 0ab8 3B68     		ldr	r3, [r7, #0]
 1373 0aba D3ED027A 		flds	s15, [r3, #8]
 1374 0abe 67EE277A 		fmuls	s15, s14, s15
 1375 0ac2 B7EEE79A 		fcvtds	d9, s15
  40:geometry.c    ****         cosFunc(p2->Lon - p1->Lon);
 1376              		.loc 2 40 0
 1377 0ac6 3B68     		ldr	r3, [r7, #0]
 1378 0ac8 93ED037A 		flds	s14, [r3, #12]
 1379 0acc 7B68     		ldr	r3, [r7, #4]
 1380 0ace D3ED037A 		flds	s15, [r3, #12]
 1381 0ad2 77EE677A 		fsubs	s15, s14, s15
 1382 0ad6 B7EEE77A 		fcvtds	d7, s15
 1383 0ada B0EE470B 		fcpyd	d0, d7
 1384 0ade FFF7FEFF 		bl	cos_121sm
 1385 0ae2 B0EE407B 		fcpyd	d7, d0
  39:geometry.c    ****         p1->CosLat * p2->CosLat*
 1386              		.loc 2 39 0
 1387 0ae6 29EE077B 		fmuld	d7, d9, d7
  38:geometry.c    ****     return p1->SinLat * p2->SinLat + 
 1388              		.loc 2 38 0
 1389 0aea 38EE077B 		faddd	d7, d8, d7
 1390 0aee F7EEC77B 		fcvtsd	s15, d7
  41:geometry.c    **** }
 1391              		.loc 2 41 0
 1392 0af2 B0EE670A 		fcpys	s0, s15
 1393 0af6 07F10807 		add	r7, r7, #8
 1394 0afa BD46     		mov	sp, r7
 1395 0afc BDEC048B 		fldmfdd	sp!, {d8, d9}
 1396 0b00 80BD     		pop	{r7, pc}
 1397              		.cfi_endproc
 1398              	.LFE15:
 1400              		.section	.rodata
 1401              		.align	2
 1402              	.LC0:
 1403 0018 52656665 		.ascii	"Reference\000"
 1403      72656E63 
 1403      6500
 1404 0022 0000     		.align	2
 1405              	.LC1:
 1406 0024 454E4400 		.ascii	"END\000"
 1407              		.text
 1408 0b02 00BF     		.align	2
 1409              		.global	Find_Nearest_Waypoint
 1410              		.thumb
 1411              		.thumb_func
 1413              	Find_Nearest_Waypoint:
 1414              	.LFB16:
  42:geometry.c    **** 
  43:geometry.c    **** #endif
  44:geometry.c    **** 
  45:geometry.c    **** 
  46:geometry.c    **** void Find_Nearest_Waypoint(float cur_pos_lat, float cur_pos_lon, float * distance, float * bearing,
  47:geometry.c    ****         char  * * name) {
 1415              		.loc 2 47 0
 1416              		.cfi_startproc
 1417              		@ args = 0, pretend = 0, frame = 96
 1418              		@ frame_needed = 1, uses_anonymous_args = 0
 1419 0b04 80B5     		push	{r7, lr}
 1420              	.LCFI51:
 1421              		.cfi_def_cfa_offset 8
 1422              		.cfi_offset 14, -4
 1423              		.cfi_offset 7, -8
 1424 0b06 98B0     		sub	sp, sp, #96
 1425              	.LCFI52:
 1426              		.cfi_def_cfa_offset 104
 1427 0b08 00AF     		add	r7, sp, #0
 1428              	.LCFI53:
 1429              		.cfi_def_cfa_register 7
 1430 0b0a 87ED050A 		fsts	s0, [r7, #20]
 1431 0b0e C7ED040A 		fsts	s1, [r7, #16]
 1432 0b12 F860     		str	r0, [r7, #12]
 1433 0b14 B960     		str	r1, [r7, #8]
 1434 0b16 7A60     		str	r2, [r7, #4]
  48:geometry.c    ****     // cur_pos_lat and cur_pos_lon are in degrees
  49:geometry.c    ****     // distance is in kilometers
  50:geometry.c    ****     // bearing is in degrees
  51:geometry.c    **** 
  52:geometry.c    ****     int i=0, closest_i=0;
 1435              		.loc 2 52 0
 1436 0b18 4FF00003 		mov	r3, #0
 1437 0b1c FB65     		str	r3, [r7, #92]
 1438 0b1e 4FF00003 		mov	r3, #0
 1439 0b22 BB65     		str	r3, [r7, #88]
  53:geometry.c    ****     PT_T ref;
  54:geometry.c    ****     float d=0.0, b=0.0, c=0.0, closest_d=1E10, max_c=0;
 1440              		.loc 2 54 0
 1441 0b24 624B     		ldr	r3, .L75+4	@ float
 1442 0b26 3B65     		str	r3, [r7, #80]	@ float
 1443 0b28 614B     		ldr	r3, .L75+4	@ float
 1444 0b2a FB64     		str	r3, [r7, #76]	@ float
 1445 0b2c 604B     		ldr	r3, .L75+4	@ float
 1446 0b2e BB64     		str	r3, [r7, #72]	@ float
 1447 0b30 604B     		ldr	r3, .L75+8	@ float
 1448 0b32 7B64     		str	r3, [r7, #68]	@ float
 1449 0b34 5E4B     		ldr	r3, .L75+4	@ float
 1450 0b36 7B65     		str	r3, [r7, #84]	@ float
  55:geometry.c    **** 
  56:geometry.c    ****     *distance = 0;
 1451              		.loc 2 56 0
 1452 0b38 FB68     		ldr	r3, [r7, #12]
 1453 0b3a 5D4A     		ldr	r2, .L75+4	@ float
 1454 0b3c 1A60     		str	r2, [r3, #0]	@ float
  57:geometry.c    ****     *bearing = 0;
 1455              		.loc 2 57 0
 1456 0b3e BB68     		ldr	r3, [r7, #8]
 1457 0b40 5B4A     		ldr	r2, .L75+4	@ float
 1458 0b42 1A60     		str	r2, [r3, #0]	@ float
  58:geometry.c    ****     *name = '\0';
 1459              		.loc 2 58 0
 1460 0b44 7B68     		ldr	r3, [r7, #4]
 1461 0b46 4FF00002 		mov	r2, #0
 1462 0b4a 1A60     		str	r2, [r3, #0]
  59:geometry.c    **** 
  60:geometry.c    ****     ref.Lat = cur_pos_lat;
 1463              		.loc 2 60 0
 1464 0b4c 7B69     		ldr	r3, [r7, #20]	@ float
 1465 0b4e FB61     		str	r3, [r7, #28]	@ float
  61:geometry.c    ****     ref.Lon = cur_pos_lon;
 1466              		.loc 2 61 0
 1467 0b50 3B69     		ldr	r3, [r7, #16]	@ float
 1468 0b52 BB62     		str	r3, [r7, #40]	@ float
  62:geometry.c    ****     ref.SinLat = sineFunc(cur_pos_lat);
 1469              		.loc 2 62 0
 1470 0b54 D7ED057A 		flds	s15, [r7, #20]
 1471 0b58 B7EEE77A 		fcvtds	d7, s15
 1472 0b5c B0EE470B 		fcpyd	d0, d7
 1473 0b60 FFF7FEFF 		bl	sin_121
 1474 0b64 B0EE407B 		fcpyd	d7, d0
 1475 0b68 F7EEC77B 		fcvtsd	s15, d7
 1476 0b6c C7ED087A 		fsts	s15, [r7, #32]
  63:geometry.c    ****     ref.CosLat = cosFunc(cur_pos_lat);
 1477              		.loc 2 63 0
 1478 0b70 D7ED057A 		flds	s15, [r7, #20]
 1479 0b74 B7EEE77A 		fcvtds	d7, s15
 1480 0b78 B0EE470B 		fcpyd	d0, d7
 1481 0b7c FFF7FEFF 		bl	cos_121sm
 1482 0b80 B0EE407B 		fcpyd	d7, d0
 1483 0b84 F7EEC77B 		fcvtsd	s15, d7
 1484 0b88 C7ED097A 		fsts	s15, [r7, #36]
  64:geometry.c    **** 
  65:geometry.c    ****     strcpy(ref.Name, "Reference");
 1485              		.loc 2 65 0
 1486 0b8c 40F20003 		movw	r3, #:lower16:.LC0
 1487 0b90 C0F20003 		movt	r3, #:upper16:.LC0
 1488 0b94 07F11C02 		add	r2, r7, #28
 1489 0b98 02F11002 		add	r2, r2, #16
 1490 0b9c 1146     		mov	r1, r2
 1491 0b9e 1A46     		mov	r2, r3
 1492 0ba0 4FF00A03 		mov	r3, #10
 1493 0ba4 0846     		mov	r0, r1
 1494 0ba6 1146     		mov	r1, r2
 1495 0ba8 1A46     		mov	r2, r3
 1496 0baa FFF7FEFF 		bl	memcpy
  66:geometry.c    **** 
  67:geometry.c    ****     while (strcmp(waypoints[i].Name, "END")) {
 1497              		.loc 2 67 0
 1498 0bae 2AE0     		b	.L72
 1499              	.L74:
  68:geometry.c    **** #if CALC_DIST
  69:geometry.c    ****         getchar();
  70:geometry.c    ****         d = Calc_Distance(&ref, &(waypoints[i]) );
  71:geometry.c    ****         // b = Calc_Bearing(&ref, &(waypoints[i]) ); // Deletable!
  72:geometry.c    ****         // if we found a closer waypoint, remember it and display it
  73:geometry.c    ****         getchar();
  74:geometry.c    ****         if (d<closest_d) {
  75:geometry.c    ****             closest_d = d;
  76:geometry.c    ****             closest_i = i;
  77:geometry.c    ****         }
  78:geometry.c    **** #else
  79:geometry.c    ****         c = Calc_Closeness(&ref, &(waypoints[i]) );
 1500              		.loc 2 79 0
 1501 0bb0 FA6D     		ldr	r2, [r7, #92]
 1502 0bb2 1346     		mov	r3, r2
 1503 0bb4 4FEA8303 		lsl	r3, r3, #2
 1504 0bb8 9B18     		adds	r3, r3, r2
 1505 0bba 4FEAC303 		lsl	r3, r3, #3
 1506 0bbe 1A46     		mov	r2, r3
 1507 0bc0 40F20003 		movw	r3, #:lower16:waypoints
 1508 0bc4 C0F20003 		movt	r3, #:upper16:waypoints
 1509 0bc8 D318     		adds	r3, r2, r3
 1510 0bca 07F11C02 		add	r2, r7, #28
 1511 0bce 1046     		mov	r0, r2
 1512 0bd0 1946     		mov	r1, r3
 1513 0bd2 FFF7FEFF 		bl	Calc_Closeness
 1514 0bd6 87ED120A 		fsts	s0, [r7, #72]
  80:geometry.c    ****         //printf("\n%d,%f",i,c);
  81:geometry.c    ****         if (c>max_c) {
 1515              		.loc 2 81 0
 1516 0bda 97ED127A 		flds	s14, [r7, #72]
 1517 0bde D7ED157A 		flds	s15, [r7, #84]
 1518 0be2 B4EEE77A 		fcmpes	s14, s15
 1519 0be6 F1EE10FA 		fmstat
 1520 0bea D4BF     		ite	le
 1521 0bec 0023     		movle	r3, #0
 1522 0bee 0123     		movgt	r3, #1
 1523 0bf0 DBB2     		uxtb	r3, r3
 1524 0bf2 002B     		cmp	r3, #0
 1525 0bf4 03D0     		beq	.L73
  82:geometry.c    ****             max_c = c;
 1526              		.loc 2 82 0
 1527 0bf6 BB6C     		ldr	r3, [r7, #72]	@ float
 1528 0bf8 7B65     		str	r3, [r7, #84]	@ float
  83:geometry.c    ****             closest_i = i;
 1529              		.loc 2 83 0
 1530 0bfa FB6D     		ldr	r3, [r7, #92]
 1531 0bfc BB65     		str	r3, [r7, #88]
 1532              	.L73:
  84:geometry.c    ****         }
  85:geometry.c    **** #endif
  86:geometry.c    ****         i++;
 1533              		.loc 2 86 0
 1534 0bfe FB6D     		ldr	r3, [r7, #92]
 1535 0c00 03F10103 		add	r3, r3, #1
 1536 0c04 FB65     		str	r3, [r7, #92]
 1537              	.L72:
  67:geometry.c    ****     while (strcmp(waypoints[i].Name, "END")) {
 1538              		.loc 2 67 0 discriminator 1
 1539 0c06 FA6D     		ldr	r2, [r7, #92]
 1540 0c08 1346     		mov	r3, r2
 1541 0c0a 4FEA8303 		lsl	r3, r3, #2
 1542 0c0e 9B18     		adds	r3, r3, r2
 1543 0c10 4FEAC303 		lsl	r3, r3, #3
 1544 0c14 03F11002 		add	r2, r3, #16
 1545 0c18 40F20003 		movw	r3, #:lower16:waypoints
 1546 0c1c C0F20003 		movt	r3, #:upper16:waypoints
 1547 0c20 D318     		adds	r3, r2, r3
 1548 0c22 1846     		mov	r0, r3
 1549 0c24 40F20001 		movw	r1, #:lower16:.LC1
 1550 0c28 C0F20001 		movt	r1, #:upper16:.LC1
 1551 0c2c FFF7FEFF 		bl	strcmp
 1552 0c30 0346     		mov	r3, r0
 1553 0c32 002B     		cmp	r3, #0
 1554 0c34 BCD1     		bne	.L74
  87:geometry.c    ****     }
  88:geometry.c    **** 
  89:geometry.c    ****     // Finish calcuations for the closest point
  90:geometry.c    **** #if CALC_DIST
  91:geometry.c    **** #if 0
  92:geometry.c    ****     d = Calc_Distance(&ref, &(waypoints[closest_i]) );
  93:geometry.c    **** #else
  94:geometry.c    ****     d = closest_d; // optimization
  95:geometry.c    **** #endif
  96:geometry.c    ****     b = Calc_Bearing(&ref, &(waypoints[closest_i]) ); 
  97:geometry.c    **** #else
  98:geometry.c    ****     d = acosf(max_c)*6371; // finish distance calcuation
 1555              		.loc 2 98 0
 1556 0c36 97ED150A 		flds	s0, [r7, #84]
 1557 0c3a FFF7FEFF 		bl	acosf
 1558 0c3e B0EE407A 		fcpys	s14, s0
 1559 0c42 DFED1A7A 		flds	s15, .L75
 1560 0c46 67EE277A 		fmuls	s15, s14, s15
 1561 0c4a C7ED147A 		fsts	s15, [r7, #80]
  99:geometry.c    ****     b = Calc_Bearing(&ref, &(waypoints[closest_i]) );
 1562              		.loc 2 99 0
 1563 0c4e BA6D     		ldr	r2, [r7, #88]
 1564 0c50 1346     		mov	r3, r2
 1565 0c52 4FEA8303 		lsl	r3, r3, #2
 1566 0c56 9B18     		adds	r3, r3, r2
 1567 0c58 4FEAC303 		lsl	r3, r3, #3
 1568 0c5c 1A46     		mov	r2, r3
 1569 0c5e 40F20003 		movw	r3, #:lower16:waypoints
 1570 0c62 C0F20003 		movt	r3, #:upper16:waypoints
 1571 0c66 D318     		adds	r3, r2, r3
 1572 0c68 07F11C02 		add	r2, r7, #28
 1573 0c6c 1046     		mov	r0, r2
 1574 0c6e 1946     		mov	r1, r3
 1575 0c70 FFF7FEFF 		bl	Calc_Bearing
 1576 0c74 87ED130A 		fsts	s0, [r7, #76]
 100:geometry.c    **** #endif	
 101:geometry.c    ****     // return information to calling function about closest waypoint 
 102:geometry.c    ****     *distance = d;
 1577              		.loc 2 102 0
 1578 0c78 FB68     		ldr	r3, [r7, #12]
 1579 0c7a 3A6D     		ldr	r2, [r7, #80]	@ float
 1580 0c7c 1A60     		str	r2, [r3, #0]	@ float
 103:geometry.c    ****     *bearing = b;
 1581              		.loc 2 103 0
 1582 0c7e BB68     		ldr	r3, [r7, #8]
 1583 0c80 FA6C     		ldr	r2, [r7, #76]	@ float
 1584 0c82 1A60     		str	r2, [r3, #0]	@ float
 104:geometry.c    ****     *name = (char * ) (waypoints[closest_i].Name);
 1585              		.loc 2 104 0
 1586 0c84 BA6D     		ldr	r2, [r7, #88]
 1587 0c86 1346     		mov	r3, r2
 1588 0c88 4FEA8303 		lsl	r3, r3, #2
 1589 0c8c 9B18     		adds	r3, r3, r2
 1590 0c8e 4FEAC303 		lsl	r3, r3, #3
 1591 0c92 03F11002 		add	r2, r3, #16
 1592 0c96 40F20003 		movw	r3, #:lower16:waypoints
 1593 0c9a C0F20003 		movt	r3, #:upper16:waypoints
 1594 0c9e D218     		adds	r2, r2, r3
 1595 0ca0 7B68     		ldr	r3, [r7, #4]
 1596 0ca2 1A60     		str	r2, [r3, #0]
 105:geometry.c    **** }
 1597              		.loc 2 105 0
 1598 0ca4 07F16007 		add	r7, r7, #96
 1599 0ca8 BD46     		mov	sp, r7
 1600 0caa 80BD     		pop	{r7, pc}
 1601              	.L76:
 1602              		.align	2
 1603              	.L75:
 1604 0cac 0018C745 		.word	1170675712
 1605 0cb0 00000000 		.word	0
 1606 0cb4 F9021550 		.word	1343554297
 1607              		.cfi_endproc
 1608              	.LFE16:
 1610              	.Letext0:
 1611              		.file 3 "geometry.h"
