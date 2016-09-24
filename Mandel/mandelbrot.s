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
  13              		.eabi_attribute 34, 1
  14              		.eabi_attribute 18, 4
  15              		.thumb
  16              		.file	"mandelbrot.c"
  17              		.text
  18              	.Ltext0:
  19              		.cfi_sections	.debug_frame
  20              		.comm	minReal_int,4,4
  21              		.comm	minImag_int,4,4
  22              		.comm	size_int,4,4
  23              		.global	color_map
  24              		.data
  25              		.align	2
  28              	color_map:
  29 0000 00000000 		.word	0
  30 0004 00000000 		.word	0
  31 0008 00000000 		.word	0
  32 000c 0C000000 		.word	12
  33 0010 07000000 		.word	7
  34 0014 24000000 		.word	36
  35 0018 09000000 		.word	9
  36 001c 01000000 		.word	1
  37 0020 2F000000 		.word	47
  38 0024 04000000 		.word	4
  39 0028 04000000 		.word	4
  40 002c 49000000 		.word	73
  41 0030 00000000 		.word	0
  42 0034 07000000 		.word	7
  43 0038 64000000 		.word	100
  44 003c 0C000000 		.word	12
  45 0040 2C000000 		.word	44
  46 0044 8A000000 		.word	138
  47 0048 18000000 		.word	24
  48 004c 52000000 		.word	82
  49 0050 B1000000 		.word	177
  50 0054 39000000 		.word	57
  51 0058 7D000000 		.word	125
  52 005c D1000000 		.word	209
  53 0060 86000000 		.word	134
  54 0064 B5000000 		.word	181
  55 0068 E5000000 		.word	229
  56 006c D3000000 		.word	211
  57 0070 EC000000 		.word	236
  58 0074 F8000000 		.word	248
  59 0078 F1000000 		.word	241
  60 007c E9000000 		.word	233
  61 0080 BF000000 		.word	191
  62 0084 F8000000 		.word	248
  63 0088 C9000000 		.word	201
  64 008c 5F000000 		.word	95
  65 0090 FF000000 		.word	255
  66 0094 AA000000 		.word	170
  67 0098 00000000 		.word	0
  68 009c CC000000 		.word	204
  69 00a0 80000000 		.word	128
  70 00a4 00000000 		.word	0
  71 00a8 99000000 		.word	153
  72 00ac 57000000 		.word	87
  73 00b0 00000000 		.word	0
  74 00b4 00000000 		.word	0
  75 00b8 02000000 		.word	2
  76 00bc 03000000 		.word	3
  77              		.section	.rodata
  78              		.align	2
  79              	.LC0:
  80 0000 50330A00 		.ascii	"P3\012\000"
  81              		.align	2
  82              	.LC1:
  83 0004 25642025 		.ascii	"%d %d\012\000"
  83      640A00
  84 000b 00       		.align	2
  85              	.LC2:
  86 000c 25640A00 		.ascii	"%d\012\000"
  87              		.align	2
  88              	.LC3:
  89 0010 25642025 		.ascii	"%d %d %d \000"
  89      64202564 
  89      2000
  90 001a 0000     		.align	2
  91              	.LC4:
  92 001c 25642025 		.ascii	"%d %d %d\012\000"
  92      64202564 
  92      0A00
  93              		.text
  94              		.align	2
  95              		.global	saveImage
  96              		.thumb
  97              		.thumb_func
  99              	saveImage:
 100              	.LFB2:
 101              		.file 1 "mandelbrot.c"
   1:mandelbrot.c  **** /*
   2:mandelbrot.c  ****   @file: mandelbrot.c
   3:mandelbrot.c  ****   @author: Udai Muhammed (ufmuhamm)
   4:mandelbrot.c  ****   @description: a program that draws ASCII art work that represent Mandelbrot fractal (Second degre
   5:mandelbrot.c  ****   the user provide the minimum real domain and minimum imaginary domain, and the size of the side o
   6:mandelbrot.c  **** 
   7:mandelbrot.c  **** */
   8:mandelbrot.c  **** 
   9:mandelbrot.c  **** #include <stdio.h>
  10:mandelbrot.c  **** #include <stdlib.h>
  11:mandelbrot.c  **** #include <math.h>
  12:mandelbrot.c  **** #include <stdint.h>
  13:mandelbrot.c  **** #include <time.h>
  14:mandelbrot.c  **** 
  15:mandelbrot.c  **** #define WIDTH  (256)
  16:mandelbrot.c  **** #define HEIGHT (256)
  17:mandelbrot.c  **** 
  18:mandelbrot.c  **** // a scaling up factor for the double values to get more digits after the floating point
  19:mandelbrot.c  **** #define resol  (1000000000.0)
  20:mandelbrot.c  **** 
  21:mandelbrot.c  **** /* contrast will make gradual change in gray-scale more clear
  22:mandelbrot.c  ****  * the bigger the contrast the more clear the edges will become 
  23:mandelbrot.c  ****  */
  24:mandelbrot.c  **** #define CONTRAST (1)
  25:mandelbrot.c  **** 
  26:mandelbrot.c  **** // the gray-scale goes from 0-255 , but we stop iteration at 255/contrast
  27:mandelbrot.c  **** #define limit ( 255/CONTRAST )
  28:mandelbrot.c  **** 
  29:mandelbrot.c  **** #define N_TESTS (1)
  30:mandelbrot.c  **** 
  31:mandelbrot.c  **** //Global variables 
  32:mandelbrot.c  **** 
  33:mandelbrot.c  **** // the long integer value of the scaled up regular 
  34:mandelbrot.c  **** long minReal_int,minImag_int,size_int;  
  35:mandelbrot.c  **** 
  36:mandelbrot.c  **** /* this is the original color mapping 
  37:mandelbrot.c  ****  *  R    G    B
  38:mandelbrot.c  ****  *  66   30   15  # brown 3
  39:mandelbrot.c  ****  *  25   7    26  # dark violett
  40:mandelbrot.c  ****  *   9   1    47  # darkest blue
  41:mandelbrot.c  ****  *   4   4    73  # blue 5
  42:mandelbrot.c  ****  *   0   7    100 # blue 4
  43:mandelbrot.c  ****  *  12   44   138 # blue 3
  44:mandelbrot.c  ****  *  24   82   177 # blue 2
  45:mandelbrot.c  ****  *  57   125  209 # blue 1
  46:mandelbrot.c  ****  *  134  181  229 # blue 0
  47:mandelbrot.c  ****  *  211  236  248 # lightest blue
  48:mandelbrot.c  ****  *  241  233  191 # lightest yellow
  49:mandelbrot.c  ****  *  248  201  95  # light yellow
  50:mandelbrot.c  ****  *  255  170  0   # dirty yellow
  51:mandelbrot.c  ****  *  204  128  0   # brown 0
  52:mandelbrot.c  ****  *  153  87   0   # brown 1
  53:mandelbrot.c  ****  *  106  52   3   # brown 2
  54:mandelbrot.c  ****  */
  55:mandelbrot.c  **** 
  56:mandelbrot.c  **** int color_map[16][3] ={
  57:mandelbrot.c  ****   {0, 0, 0},
  58:mandelbrot.c  ****   {12, 7, 36},
  59:mandelbrot.c  ****   {9, 1, 47},
  60:mandelbrot.c  ****   {4, 4, 73},
  61:mandelbrot.c  ****   {0, 7, 100},
  62:mandelbrot.c  ****   {12, 44, 138},
  63:mandelbrot.c  ****   {24, 82, 177},
  64:mandelbrot.c  ****   {57, 125, 209},
  65:mandelbrot.c  ****   {134, 181, 229},
  66:mandelbrot.c  ****   {211, 236, 248},
  67:mandelbrot.c  ****   {241, 233, 191},
  68:mandelbrot.c  ****   {248, 201, 95},
  69:mandelbrot.c  ****   {255, 170, 0},
  70:mandelbrot.c  ****   {204, 128, 0},
  71:mandelbrot.c  ****   {153, 87, 0},
  72:mandelbrot.c  ****   {0, 2, 3}
  73:mandelbrot.c  **** };
  74:mandelbrot.c  **** 
  75:mandelbrot.c  **** 
  76:mandelbrot.c  **** void saveImage( unsigned char ***image, FILE *outputFile , unsigned char color)
  77:mandelbrot.c  **** {
 102              		.loc 1 77 0
 103              		.cfi_startproc
 104              		@ args = 0, pretend = 0, frame = 16
 105              		@ frame_needed = 1, uses_anonymous_args = 0
 106 0000 F0B5     		push	{r4, r5, r6, r7, lr}
 107              		.cfi_def_cfa_offset 20
 108              		.cfi_offset 4, -20
 109              		.cfi_offset 5, -16
 110              		.cfi_offset 6, -12
 111              		.cfi_offset 7, -8
 112              		.cfi_offset 14, -4
 113 0002 87B0     		sub	sp, sp, #28
 114              		.cfi_def_cfa_offset 48
 115 0004 02AF     		add	r7, sp, #8
 116              		.cfi_def_cfa 7, 40
 117 0006 F860     		str	r0, [r7, #12]
 118 0008 B960     		str	r1, [r7, #8]
 119 000a 1346     		mov	r3, r2
 120 000c FB71     		strb	r3, [r7, #7]
  78:mandelbrot.c  ****   // A Function that will take an array and save its components as pgm image file
  79:mandelbrot.c  ****   
  80:mandelbrot.c  ****   register int i,j;
  81:mandelbrot.c  ****   // necessary header for the pgm file 
  82:mandelbrot.c  ****   fprintf(outputFile,"P3\n");
 121              		.loc 1 82 0
 122 000e 40F20000 		movw	r0, #:lower16:.LC0
 123 0012 C0F20000 		movt	r0, #:upper16:.LC0
 124 0016 0121     		movs	r1, #1
 125 0018 0322     		movs	r2, #3
 126 001a BB68     		ldr	r3, [r7, #8]
 127 001c FFF7FEFF 		bl	fwrite
  83:mandelbrot.c  ****   fprintf(outputFile,"%d %d\n",WIDTH,HEIGHT);
 128              		.loc 1 83 0
 129 0020 B868     		ldr	r0, [r7, #8]
 130 0022 40F20001 		movw	r1, #:lower16:.LC1
 131 0026 C0F20001 		movt	r1, #:upper16:.LC1
 132 002a 4FF48072 		mov	r2, #256
 133 002e 4FF48073 		mov	r3, #256
 134 0032 FFF7FEFF 		bl	fprintf
  84:mandelbrot.c  ****   fprintf(outputFile,"%d\n",color);
 135              		.loc 1 84 0
 136 0036 FB79     		ldrb	r3, [r7, #7]	@ zero_extendqisi2
 137 0038 B868     		ldr	r0, [r7, #8]
 138 003a 40F20001 		movw	r1, #:lower16:.LC2
 139 003e C0F20001 		movt	r1, #:upper16:.LC2
 140 0042 1A46     		mov	r2, r3
 141 0044 FFF7FEFF 		bl	fprintf
  85:mandelbrot.c  **** 
  86:mandelbrot.c  ****   // just spit out the rows of the array one after one into the pgm file.
  87:mandelbrot.c  ****   for(j=0;j<HEIGHT;j++) 
 142              		.loc 1 87 0
 143 0048 0024     		movs	r4, #0
 144 004a 5AE0     		b	.L2
 145              	.L5:
  88:mandelbrot.c  ****     {
  89:mandelbrot.c  ****       for(i=0;i<WIDTH-1;i++)    
 146              		.loc 1 89 0
 147 004c 0025     		movs	r5, #0
 148 004e 2CE0     		b	.L3
 149              	.L4:
  90:mandelbrot.c  **** 	fprintf(outputFile,"%d %d %d ",image[i][j][0],image[i][j][1],image[i][j][2]);
 150              		.loc 1 90 0 discriminator 3
 151 0050 2B46     		mov	r3, r5
 152 0052 9B00     		lsls	r3, r3, #2
 153 0054 FA68     		ldr	r2, [r7, #12]
 154 0056 1344     		add	r3, r3, r2
 155 0058 1A68     		ldr	r2, [r3]
 156 005a 2346     		mov	r3, r4
 157 005c 9B00     		lsls	r3, r3, #2
 158 005e 1344     		add	r3, r3, r2
 159 0060 1B68     		ldr	r3, [r3]
 160 0062 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2
 161 0064 9E46     		mov	lr, r3
 162 0066 2B46     		mov	r3, r5
 163 0068 9B00     		lsls	r3, r3, #2
 164 006a FA68     		ldr	r2, [r7, #12]
 165 006c 1344     		add	r3, r3, r2
 166 006e 1A68     		ldr	r2, [r3]
 167 0070 2346     		mov	r3, r4
 168 0072 9B00     		lsls	r3, r3, #2
 169 0074 1344     		add	r3, r3, r2
 170 0076 1B68     		ldr	r3, [r3]
 171 0078 0133     		adds	r3, r3, #1
 172 007a 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2
 173 007c 1E46     		mov	r6, r3
 174 007e 2B46     		mov	r3, r5
 175 0080 9B00     		lsls	r3, r3, #2
 176 0082 FA68     		ldr	r2, [r7, #12]
 177 0084 1344     		add	r3, r3, r2
 178 0086 1A68     		ldr	r2, [r3]
 179 0088 2346     		mov	r3, r4
 180 008a 9B00     		lsls	r3, r3, #2
 181 008c 1344     		add	r3, r3, r2
 182 008e 1B68     		ldr	r3, [r3]
 183 0090 0233     		adds	r3, r3, #2
 184 0092 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2
 185 0094 0093     		str	r3, [sp]
 186 0096 B868     		ldr	r0, [r7, #8]
 187 0098 40F20001 		movw	r1, #:lower16:.LC3
 188 009c C0F20001 		movt	r1, #:upper16:.LC3
 189 00a0 7246     		mov	r2, lr
 190 00a2 3346     		mov	r3, r6
 191 00a4 FFF7FEFF 		bl	fprintf
  89:mandelbrot.c  **** 	fprintf(outputFile,"%d %d %d ",image[i][j][0],image[i][j][1],image[i][j][2]);
 192              		.loc 1 89 0 discriminator 3
 193 00a8 0135     		adds	r5, r5, #1
 194              	.L3:
  89:mandelbrot.c  **** 	fprintf(outputFile,"%d %d %d ",image[i][j][0],image[i][j][1],image[i][j][2]);
 195              		.loc 1 89 0 is_stmt 0 discriminator 1
 196 00aa FE2D     		cmp	r5, #254
 197 00ac D0DD     		ble	.L4
  91:mandelbrot.c  ****       fprintf(outputFile,"%d %d %d\n",image[WIDTH-1][j][0],image[WIDTH-1][j][1],image[WIDTH-1][j][2
 198              		.loc 1 91 0 is_stmt 1 discriminator 2
 199 00ae FB68     		ldr	r3, [r7, #12]
 200 00b0 03F57F73 		add	r3, r3, #1020
 201 00b4 1A68     		ldr	r2, [r3]
 202 00b6 2346     		mov	r3, r4
 203 00b8 9B00     		lsls	r3, r3, #2
 204 00ba 1344     		add	r3, r3, r2
 205 00bc 1B68     		ldr	r3, [r3]
 206 00be 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2
 207 00c0 1E46     		mov	r6, r3
 208 00c2 FB68     		ldr	r3, [r7, #12]
 209 00c4 03F57F73 		add	r3, r3, #1020
 210 00c8 1A68     		ldr	r2, [r3]
 211 00ca 2346     		mov	r3, r4
 212 00cc 9B00     		lsls	r3, r3, #2
 213 00ce 1344     		add	r3, r3, r2
 214 00d0 1B68     		ldr	r3, [r3]
 215 00d2 0133     		adds	r3, r3, #1
 216 00d4 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2
 217 00d6 1D46     		mov	r5, r3
 218 00d8 FB68     		ldr	r3, [r7, #12]
 219 00da 03F57F73 		add	r3, r3, #1020
 220 00de 1A68     		ldr	r2, [r3]
 221 00e0 2346     		mov	r3, r4
 222 00e2 9B00     		lsls	r3, r3, #2
 223 00e4 1344     		add	r3, r3, r2
 224 00e6 1B68     		ldr	r3, [r3]
 225 00e8 0233     		adds	r3, r3, #2
 226 00ea 1B78     		ldrb	r3, [r3]	@ zero_extendqisi2
 227 00ec 0093     		str	r3, [sp]
 228 00ee B868     		ldr	r0, [r7, #8]
 229 00f0 40F20001 		movw	r1, #:lower16:.LC4
 230 00f4 C0F20001 		movt	r1, #:upper16:.LC4
 231 00f8 3246     		mov	r2, r6
 232 00fa 2B46     		mov	r3, r5
 233 00fc FFF7FEFF 		bl	fprintf
  87:mandelbrot.c  ****     {
 234              		.loc 1 87 0 discriminator 2
 235 0100 0134     		adds	r4, r4, #1
 236              	.L2:
  87:mandelbrot.c  ****     {
 237              		.loc 1 87 0 is_stmt 0 discriminator 1
 238 0102 FF2C     		cmp	r4, #255
 239 0104 A2DD     		ble	.L5
  92:mandelbrot.c  ****     }
  93:mandelbrot.c  ****   
  94:mandelbrot.c  **** }
 240              		.loc 1 94 0 is_stmt 1
 241 0106 1437     		adds	r7, r7, #20
 242              		.cfi_def_cfa_offset 20
 243 0108 BD46     		mov	sp, r7
 244              		.cfi_def_cfa_register 13
 245              		@ sp needed
 246 010a F0BD     		pop	{r4, r5, r6, r7, pc}
 247              		.cfi_endproc
 248              	.LFE2:
 250              		.align	2
 251              		.global	testPoint
 252              		.thumb
 253              		.thumb_func
 255              	testPoint:
 256              	.LFB3:
  95:mandelbrot.c  **** 
  96:mandelbrot.c  **** //a function to retrun the number of iteration needed to either go of limit or for the point to div
  97:mandelbrot.c  **** unsigned int testPoint( long cReal, long cImag )
  98:mandelbrot.c  **** {
 257              		.loc 1 98 0
 258              		.cfi_startproc
 259              		@ args = 0, pretend = 0, frame = 48
 260              		@ frame_needed = 1, uses_anonymous_args = 0
 261              		@ link register save eliminated.
 262 010c 80B4     		push	{r7}
 263              		.cfi_def_cfa_offset 4
 264              		.cfi_offset 7, -4
 265 010e 8DB0     		sub	sp, sp, #52
 266              		.cfi_def_cfa_offset 56
 267 0110 00AF     		add	r7, sp, #0
 268              		.cfi_def_cfa_register 7
 269 0112 7860     		str	r0, [r7, #4]
 270 0114 3960     		str	r1, [r7]
  99:mandelbrot.c  ****   unsigned int dwell =0 ;
 271              		.loc 1 99 0
 272 0116 0023     		movs	r3, #0
 273 0118 FB62     		str	r3, [r7, #44]
 100:mandelbrot.c  ****   long double zReal_t,zImag_t, mag =0; // magnitude 
 274              		.loc 1 100 0
 275 011a 4FF00002 		mov	r2, #0
 276 011e 4FF00003 		mov	r3, #0
 277 0122 C7E90623 		strd	r2, [r7, #24]
 101:mandelbrot.c  ****   long zReal,zImag;
 102:mandelbrot.c  ****   
 103:mandelbrot.c  ****   zReal = cReal;
 278              		.loc 1 103 0
 279 0126 7B68     		ldr	r3, [r7, #4]
 280 0128 BB62     		str	r3, [r7, #40]
 104:mandelbrot.c  ****   zImag = cImag;
 281              		.loc 1 104 0
 282 012a 3B68     		ldr	r3, [r7]
 283 012c 7B62     		str	r3, [r7, #36]
 284              	.L8:
 105:mandelbrot.c  **** 
 106:mandelbrot.c  ****   while (1) {
 107:mandelbrot.c  ****     // Z = Z^2 + C
 108:mandelbrot.c  ****    
 109:mandelbrot.c  ****     zReal_t = zReal/resol* zReal/resol -  zImag/resol * zImag/resol + cReal/resol;
 285              		.loc 1 109 0
 286 012e BB6A     		ldr	r3, [r7, #40]
 287 0130 07EE903A 		fmsr	s15, r3	@ int
 288 0134 B8EEE77B 		fsitod	d7, s15
 289 0138 9FED496B 		fldd	d6, .L10
 290 013c 87EE066B 		fdivd	d6, d7, d6
 291 0140 BB6A     		ldr	r3, [r7, #40]
 292 0142 07EE903A 		fmsr	s15, r3	@ int
 293 0146 B8EEE77B 		fsitod	d7, s15
 294 014a 26EE077B 		fmuld	d7, d6, d7
 295 014e 9FED446B 		fldd	d6, .L10
 296 0152 87EE066B 		fdivd	d6, d7, d6
 297 0156 7B6A     		ldr	r3, [r7, #36]
 298 0158 07EE903A 		fmsr	s15, r3	@ int
 299 015c B8EEE77B 		fsitod	d7, s15
 300 0160 9FED3F5B 		fldd	d5, .L10
 301 0164 87EE055B 		fdivd	d5, d7, d5
 302 0168 7B6A     		ldr	r3, [r7, #36]
 303 016a 07EE903A 		fmsr	s15, r3	@ int
 304 016e B8EEE77B 		fsitod	d7, s15
 305 0172 25EE077B 		fmuld	d7, d5, d7
 306 0176 9FED3A5B 		fldd	d5, .L10
 307 017a 87EE057B 		fdivd	d7, d7, d5
 308 017e 36EE476B 		fsubd	d6, d6, d7
 309 0182 7B68     		ldr	r3, [r7, #4]
 310 0184 07EE903A 		fmsr	s15, r3	@ int
 311 0188 B8EEE77B 		fsitod	d7, s15
 312 018c 9FED345B 		fldd	d5, .L10
 313 0190 87EE057B 		fdivd	d7, d7, d5
 314 0194 36EE077B 		faddd	d7, d6, d7
 315 0198 87ED047B 		fstd	d7, [r7, #16]
 110:mandelbrot.c  ****     zImag_t = 2*zImag/resol*zReal/resol  + cImag/resol;
 316              		.loc 1 110 0
 317 019c 7B6A     		ldr	r3, [r7, #36]
 318 019e 5B00     		lsls	r3, r3, #1
 319 01a0 07EE903A 		fmsr	s15, r3	@ int
 320 01a4 B8EEE77B 		fsitod	d7, s15
 321 01a8 9FED2D6B 		fldd	d6, .L10
 322 01ac 87EE066B 		fdivd	d6, d7, d6
 323 01b0 BB6A     		ldr	r3, [r7, #40]
 324 01b2 07EE903A 		fmsr	s15, r3	@ int
 325 01b6 B8EEE77B 		fsitod	d7, s15
 326 01ba 26EE077B 		fmuld	d7, d6, d7
 327 01be 9FED286B 		fldd	d6, .L10
 328 01c2 87EE066B 		fdivd	d6, d7, d6
 329 01c6 3B68     		ldr	r3, [r7]
 330 01c8 07EE903A 		fmsr	s15, r3	@ int
 331 01cc B8EEE77B 		fsitod	d7, s15
 332 01d0 9FED235B 		fldd	d5, .L10
 333 01d4 87EE057B 		fdivd	d7, d7, d5
 334 01d8 36EE077B 		faddd	d7, d6, d7
 335 01dc 87ED027B 		fstd	d7, [r7, #8]
 111:mandelbrot.c  ****    
 112:mandelbrot.c  ****     mag = zReal_t * zReal_t + zImag_t *zImag_t;
 336              		.loc 1 112 0
 337 01e0 97ED046B 		fldd	d6, [r7, #16]
 338 01e4 97ED047B 		fldd	d7, [r7, #16]
 339 01e8 26EE076B 		fmuld	d6, d6, d7
 340 01ec 97ED025B 		fldd	d5, [r7, #8]
 341 01f0 97ED027B 		fldd	d7, [r7, #8]
 342 01f4 25EE077B 		fmuld	d7, d5, d7
 343 01f8 36EE077B 		faddd	d7, d6, d7
 344 01fc 87ED067B 		fstd	d7, [r7, #24]
 113:mandelbrot.c  ****     if (mag > (long double) 4.0  || dwell >= limit ) {
 345              		.loc 1 113 0
 346 0200 97ED067B 		fldd	d7, [r7, #24]
 347 0204 B1EE006B 		fconstd	d6, #16
 348 0208 B4EEC67B 		fcmped	d7, d6
 349 020c F1EE10FA 		fmstat
 350 0210 1CDC     		bgt	.L7
 351              		.loc 1 113 0 is_stmt 0 discriminator 1
 352 0212 FB6A     		ldr	r3, [r7, #44]
 353 0214 FE2B     		cmp	r3, #254
 354 0216 19D8     		bhi	.L7
 114:mandelbrot.c  ****       break;
 115:mandelbrot.c  ****     }
 116:mandelbrot.c  ****     zReal = zReal_t * resol; 
 355              		.loc 1 116 0 is_stmt 1
 356 0218 97ED047B 		fldd	d7, [r7, #16]
 357 021c 9FED106B 		fldd	d6, .L10
 358 0220 27EE067B 		fmuld	d7, d7, d6
 359 0224 FDEEC77B 		ftosizd	s15, d7
 360 0228 17EE903A 		fmrs	r3, s15	@ int
 361 022c BB62     		str	r3, [r7, #40]
 117:mandelbrot.c  ****     zImag = zImag_t * resol; 
 362              		.loc 1 117 0
 363 022e 97ED027B 		fldd	d7, [r7, #8]
 364 0232 9FED0B6B 		fldd	d6, .L10
 365 0236 27EE067B 		fmuld	d7, d7, d6
 366 023a FDEEC77B 		ftosizd	s15, d7
 367 023e 17EE903A 		fmrs	r3, s15	@ int
 368 0242 7B62     		str	r3, [r7, #36]
 118:mandelbrot.c  **** 
 119:mandelbrot.c  ****     dwell++;
 369              		.loc 1 119 0
 370 0244 FB6A     		ldr	r3, [r7, #44]
 371 0246 0133     		adds	r3, r3, #1
 372 0248 FB62     		str	r3, [r7, #44]
 120:mandelbrot.c  ****   }
 373              		.loc 1 120 0
 374 024a 70E7     		b	.L8
 375              	.L7:
 121:mandelbrot.c  ****   // contrast*dwell, will generate a gray-scle depending on the iteration number
 122:mandelbrot.c  ****   // the multiplication with contrast will make the gray-scale color more distinct for areas next t
 123:mandelbrot.c  ****   // 255-color will just invert the gray-scale color for the whole image so we make white dominante
 124:mandelbrot.c  ****   // get artistic with the coloring scheme here
 125:mandelbrot.c  ****   return dwell;//CONTRAST*dwell;
 376              		.loc 1 125 0
 377 024c FB6A     		ldr	r3, [r7, #44]
 126:mandelbrot.c  **** 
 127:mandelbrot.c  **** }
 378              		.loc 1 127 0
 379 024e 1846     		mov	r0, r3
 380 0250 3437     		adds	r7, r7, #52
 381              		.cfi_def_cfa_offset 4
 382 0252 BD46     		mov	sp, r7
 383              		.cfi_def_cfa_register 13
 384              		@ sp needed
 385 0254 5DF8047B 		ldr	r7, [sp], #4
 386              		.cfi_restore 7
 387              		.cfi_def_cfa_offset 0
 388 0258 7047     		bx	lr
 389              	.L11:
 390 025a 00BFAFF3 		.align	3
 390      0080
 391              	.L10:
 392 0260 00000000 		.word	0
 393 0264 65CDCD41 		.word	1104006501
 394              		.cfi_endproc
 395              	.LFE3:
 397              		.align	2
 398              		.global	drawFigure
 399              		.thumb
 400              		.thumb_func
 402              	drawFigure:
 403              	.LFB4:
 128:mandelbrot.c  **** 
 129:mandelbrot.c  **** 
 130:mandelbrot.c  **** 
 131:mandelbrot.c  **** // A function to iterate on all the points of the canvus and drawing the right letter
 132:mandelbrot.c  **** void drawFigure(unsigned char ***image, double minReal, double  minImag, double size )
 133:mandelbrot.c  **** {
 404              		.loc 1 133 0
 405              		.cfi_startproc
 406              		@ args = 0, pretend = 0, frame = 56
 407              		@ frame_needed = 1, uses_anonymous_args = 0
 408 0268 80B5     		push	{r7, lr}
 409              		.cfi_def_cfa_offset 8
 410              		.cfi_offset 7, -8
 411              		.cfi_offset 14, -4
 412 026a 8EB0     		sub	sp, sp, #56
 413              		.cfi_def_cfa_offset 64
 414 026c 00AF     		add	r7, sp, #0
 415              		.cfi_def_cfa_register 7
 416 026e F861     		str	r0, [r7, #28]
 417 0270 87ED040B 		fstd	d0, [r7, #16]
 418 0274 87ED021B 		fstd	d1, [r7, #8]
 419 0278 87ED002B 		fstd	d2, [r7]
 134:mandelbrot.c  **** 
 135:mandelbrot.c  ****   //iterate over all the points and draw them 
 136:mandelbrot.c  ****   unsigned char dwell;
 137:mandelbrot.c  ****   long cReal_int , cImag_int ;
 138:mandelbrot.c  ****   long i,j;
 139:mandelbrot.c  ****  
 140:mandelbrot.c  ****   // converting the double value to long int after scaling it up by resol (resolution)
 141:mandelbrot.c  ****   minReal_int = (long) resol * minReal;
 420              		.loc 1 141 0
 421 027c 97ED047B 		fldd	d7, [r7, #16]
 422 0280 9FED6D6B 		fldd	d6, .L17
 423 0284 27EE067B 		fmuld	d7, d7, d6
 424 0288 FDEEC77B 		ftosizd	s15, d7
 425 028c 17EE902A 		fmrs	r2, s15	@ int
 426 0290 40F20003 		movw	r3, #:lower16:minReal_int
 427 0294 C0F20003 		movt	r3, #:upper16:minReal_int
 428 0298 1A60     		str	r2, [r3]
 142:mandelbrot.c  ****   minImag_int = (long) resol * minImag;
 429              		.loc 1 142 0
 430 029a 97ED027B 		fldd	d7, [r7, #8]
 431 029e 9FED666B 		fldd	d6, .L17
 432 02a2 27EE067B 		fmuld	d7, d7, d6
 433 02a6 FDEEC77B 		ftosizd	s15, d7
 434 02aa 17EE902A 		fmrs	r2, s15	@ int
 435 02ae 40F20003 		movw	r3, #:lower16:minImag_int
 436 02b2 C0F20003 		movt	r3, #:upper16:minImag_int
 437 02b6 1A60     		str	r2, [r3]
 143:mandelbrot.c  ****   size_int = (long) resol * size ;
 438              		.loc 1 143 0
 439 02b8 97ED007B 		fldd	d7, [r7]
 440 02bc 9FED5E6B 		fldd	d6, .L17
 441 02c0 27EE067B 		fmuld	d7, d7, d6
 442 02c4 FDEEC77B 		ftosizd	s15, d7
 443 02c8 17EE902A 		fmrs	r2, s15	@ int
 444 02cc 40F20003 		movw	r3, #:lower16:size_int
 445 02d0 C0F20003 		movt	r3, #:upper16:size_int
 446 02d4 1A60     		str	r2, [r3]
 144:mandelbrot.c  **** 
 145:mandelbrot.c  ****   for (j=0; j < WIDTH ; j++)    {
 447              		.loc 1 145 0
 448 02d6 0023     		movs	r3, #0
 449 02d8 3B63     		str	r3, [r7, #48]
 450 02da A5E0     		b	.L13
 451              	.L16:
 146:mandelbrot.c  ****     //calculate the Imag part
 147:mandelbrot.c  ****     cImag_int  = minImag_int +  size_int *  ((float) (WIDTH-1) - j) /(float)(WIDTH-1) ;
 452              		.loc 1 147 0
 453 02dc 40F20003 		movw	r3, #:lower16:minImag_int
 454 02e0 C0F20003 		movt	r3, #:upper16:minImag_int
 455 02e4 1B68     		ldr	r3, [r3]
 456 02e6 07EE903A 		fmsr	s15, r3	@ int
 457 02ea B8EEE77A 		fsitos	s14, s15
 458 02ee 40F20003 		movw	r3, #:lower16:size_int
 459 02f2 C0F20003 		movt	r3, #:upper16:size_int
 460 02f6 1B68     		ldr	r3, [r3]
 461 02f8 07EE903A 		fmsr	s15, r3	@ int
 462 02fc F8EEE76A 		fsitos	s13, s15
 463 0300 3B6B     		ldr	r3, [r7, #48]
 464 0302 07EE903A 		fmsr	s15, r3	@ int
 465 0306 F8EEE77A 		fsitos	s15, s15
 466 030a 9FED4D6A 		flds	s12, .L17+8
 467 030e 76EE677A 		fsubs	s15, s12, s15
 468 0312 66EEA77A 		fmuls	s15, s13, s15
 469 0316 DFED4A6A 		flds	s13, .L17+8
 470 031a C7EEA67A 		fdivs	s15, s15, s13
 471 031e 77EE277A 		fadds	s15, s14, s15
 472 0322 FDEEE77A 		ftosizs	s15, s15
 473 0326 17EE903A 		fmrs	r3, s15	@ int
 474 032a FB62     		str	r3, [r7, #44]
 148:mandelbrot.c  ****     for (i=0 ; i < HEIGHT ; i++) {
 475              		.loc 1 148 0
 476 032c 0023     		movs	r3, #0
 477 032e 7B63     		str	r3, [r7, #52]
 478 0330 74E0     		b	.L14
 479              	.L15:
 480              	.LBB2:
 149:mandelbrot.c  ****       //calculate the Real part
 150:mandelbrot.c  ****       cReal_int = minReal_int+ size_int *  i / (float) (HEIGHT -1) ;
 481              		.loc 1 150 0 discriminator 3
 482 0332 40F20003 		movw	r3, #:lower16:minReal_int
 483 0336 C0F20003 		movt	r3, #:upper16:minReal_int
 484 033a 1B68     		ldr	r3, [r3]
 485 033c 07EE903A 		fmsr	s15, r3	@ int
 486 0340 B8EEE77A 		fsitos	s14, s15
 487 0344 40F20003 		movw	r3, #:lower16:size_int
 488 0348 C0F20003 		movt	r3, #:upper16:size_int
 489 034c 1B68     		ldr	r3, [r3]
 490 034e 7A6B     		ldr	r2, [r7, #52]
 491 0350 02FB03F3 		mul	r3, r2, r3
 492 0354 07EE903A 		fmsr	s15, r3	@ int
 493 0358 F8EEE77A 		fsitos	s15, s15
 494 035c DFED386A 		flds	s13, .L17+8
 495 0360 C7EEA67A 		fdivs	s15, s15, s13
 496 0364 77EE277A 		fadds	s15, s14, s15
 497 0368 FDEEE77A 		ftosizs	s15, s15
 498 036c 17EE903A 		fmrs	r3, s15	@ int
 499 0370 BB62     		str	r3, [r7, #40]
 151:mandelbrot.c  ****       dwell = testPoint(cReal_int,cImag_int);
 500              		.loc 1 151 0 discriminator 3
 501 0372 B86A     		ldr	r0, [r7, #40]
 502 0374 F96A     		ldr	r1, [r7, #44]
 503 0376 FFF7FEFF 		bl	testPoint
 504 037a 0346     		mov	r3, r0
 505 037c 87F82730 		strb	r3, [r7, #39]
 152:mandelbrot.c  ****       int mod = (dwell) %16;
 506              		.loc 1 152 0 discriminator 3
 507 0380 97F82730 		ldrb	r3, [r7, #39]	@ zero_extendqisi2
 508 0384 03F00F03 		and	r3, r3, #15
 509 0388 3B62     		str	r3, [r7, #32]
 153:mandelbrot.c  ****       image[i][j][0] = color_map[mod][0];//(short) 200 + dwell ;
 510              		.loc 1 153 0 discriminator 3
 511 038a 7B6B     		ldr	r3, [r7, #52]
 512 038c 9B00     		lsls	r3, r3, #2
 513 038e FA69     		ldr	r2, [r7, #28]
 514 0390 1344     		add	r3, r3, r2
 515 0392 1A68     		ldr	r2, [r3]
 516 0394 3B6B     		ldr	r3, [r7, #48]
 517 0396 9B00     		lsls	r3, r3, #2
 518 0398 1344     		add	r3, r3, r2
 519 039a 1868     		ldr	r0, [r3]
 520 039c 40F20002 		movw	r2, #:lower16:color_map
 521 03a0 C0F20002 		movt	r2, #:upper16:color_map
 522 03a4 396A     		ldr	r1, [r7, #32]
 523 03a6 0B46     		mov	r3, r1
 524 03a8 5B00     		lsls	r3, r3, #1
 525 03aa 0B44     		add	r3, r3, r1
 526 03ac 9B00     		lsls	r3, r3, #2
 527 03ae 1344     		add	r3, r3, r2
 528 03b0 1B68     		ldr	r3, [r3]
 529 03b2 DBB2     		uxtb	r3, r3
 530 03b4 0370     		strb	r3, [r0]
 154:mandelbrot.c  ****       image[i][j][1] = color_map[mod][1];//(short) 50 +  dwell  ; //log2(sqrt(cReal_int*cReal_int +
 531              		.loc 1 154 0 discriminator 3
 532 03b6 7B6B     		ldr	r3, [r7, #52]
 533 03b8 9B00     		lsls	r3, r3, #2
 534 03ba FA69     		ldr	r2, [r7, #28]
 535 03bc 1344     		add	r3, r3, r2
 536 03be 1A68     		ldr	r2, [r3]
 537 03c0 3B6B     		ldr	r3, [r7, #48]
 538 03c2 9B00     		lsls	r3, r3, #2
 539 03c4 1344     		add	r3, r3, r2
 540 03c6 1B68     		ldr	r3, [r3]
 541 03c8 581C     		adds	r0, r3, #1
 542 03ca 40F20002 		movw	r2, #:lower16:color_map
 543 03ce C0F20002 		movt	r2, #:upper16:color_map
 544 03d2 396A     		ldr	r1, [r7, #32]
 545 03d4 0B46     		mov	r3, r1
 546 03d6 5B00     		lsls	r3, r3, #1
 547 03d8 0B44     		add	r3, r3, r1
 548 03da 9B00     		lsls	r3, r3, #2
 549 03dc 0433     		adds	r3, r3, #4
 550 03de 1344     		add	r3, r3, r2
 551 03e0 1B68     		ldr	r3, [r3]
 552 03e2 DBB2     		uxtb	r3, r3
 553 03e4 0370     		strb	r3, [r0]
 155:mandelbrot.c  ****       image[i][j][2] = color_map[mod][2];//(short) 10 +  dwell  ;//sqrt(cReal_int*cReal_int + cImag
 554              		.loc 1 155 0 discriminator 3
 555 03e6 7B6B     		ldr	r3, [r7, #52]
 556 03e8 9B00     		lsls	r3, r3, #2
 557 03ea FA69     		ldr	r2, [r7, #28]
 558 03ec 1344     		add	r3, r3, r2
 559 03ee 1A68     		ldr	r2, [r3]
 560 03f0 3B6B     		ldr	r3, [r7, #48]
 561 03f2 9B00     		lsls	r3, r3, #2
 562 03f4 1344     		add	r3, r3, r2
 563 03f6 1B68     		ldr	r3, [r3]
 564 03f8 981C     		adds	r0, r3, #2
 565 03fa 40F20002 		movw	r2, #:lower16:color_map
 566 03fe C0F20002 		movt	r2, #:upper16:color_map
 567 0402 396A     		ldr	r1, [r7, #32]
 568 0404 0B46     		mov	r3, r1
 569 0406 5B00     		lsls	r3, r3, #1
 570 0408 0B44     		add	r3, r3, r1
 571 040a 9B00     		lsls	r3, r3, #2
 572 040c 0833     		adds	r3, r3, #8
 573 040e 1344     		add	r3, r3, r2
 574 0410 1B68     		ldr	r3, [r3]
 575 0412 DBB2     		uxtb	r3, r3
 576 0414 0370     		strb	r3, [r0]
 577              	.LBE2:
 148:mandelbrot.c  ****       //calculate the Real part
 578              		.loc 1 148 0 discriminator 3
 579 0416 7B6B     		ldr	r3, [r7, #52]
 580 0418 0133     		adds	r3, r3, #1
 581 041a 7B63     		str	r3, [r7, #52]
 582              	.L14:
 148:mandelbrot.c  ****       //calculate the Real part
 583              		.loc 1 148 0 is_stmt 0 discriminator 1
 584 041c 7B6B     		ldr	r3, [r7, #52]
 585 041e FF2B     		cmp	r3, #255
 586 0420 87DD     		ble	.L15
 145:mandelbrot.c  ****     //calculate the Imag part
 587              		.loc 1 145 0 is_stmt 1 discriminator 2
 588 0422 3B6B     		ldr	r3, [r7, #48]
 589 0424 0133     		adds	r3, r3, #1
 590 0426 3B63     		str	r3, [r7, #48]
 591              	.L13:
 145:mandelbrot.c  ****     //calculate the Imag part
 592              		.loc 1 145 0 is_stmt 0 discriminator 1
 593 0428 3B6B     		ldr	r3, [r7, #48]
 594 042a FF2B     		cmp	r3, #255
 595 042c 7FF756AF 		ble	.L16
 156:mandelbrot.c  ****       
 157:mandelbrot.c  ****     }
 158:mandelbrot.c  ****   }
 159:mandelbrot.c  **** }
 596              		.loc 1 159 0 is_stmt 1
 597 0430 3837     		adds	r7, r7, #56
 598              		.cfi_def_cfa_offset 8
 599 0432 BD46     		mov	sp, r7
 600              		.cfi_def_cfa_register 13
 601              		@ sp needed
 602 0434 80BD     		pop	{r7, pc}
 603              	.L18:
 604 0436 00BF     		.align	3
 605              	.L17:
 606 0438 00000000 		.word	0
 607 043c 65CDCD41 		.word	1104006501
 608 0440 00007F43 		.word	1132396544
 609              		.cfi_endproc
 610              	.LFE4:
 612              		.section	.rodata
 613 0026 0000     		.align	2
 614              	.LC5:
 615 0028 4D616E64 		.ascii	"Mandelbrot.pgm\000"
 615      656C6272 
 615      6F742E70 
 615      676D00
 616 0037 00       		.align	2
 617              	.LC6:
 618 0038 7700     		.ascii	"w\000"
 619 003a 0000     		.align	2
 620              	.LC7:
 621 003c 256C640A 		.ascii	"%ld\012\000"
 621      00
 622 0041 000000   		.text
 623              		.align	2
 624              		.global	main
 625              		.thumb
 626              		.thumb_func
 628              	main:
 629              	.LFB5:
 160:mandelbrot.c  **** 
 161:mandelbrot.c  **** 
 162:mandelbrot.c  **** int main () {
 630              		.loc 1 162 0
 631              		.cfi_startproc
 632              		@ args = 0, pretend = 0, frame = 56
 633              		@ frame_needed = 1, uses_anonymous_args = 0
 634 0444 90B5     		push	{r4, r7, lr}
 635              		.cfi_def_cfa_offset 12
 636              		.cfi_offset 4, -12
 637              		.cfi_offset 7, -8
 638              		.cfi_offset 14, -4
 639 0446 8FB0     		sub	sp, sp, #60
 640              		.cfi_def_cfa_offset 72
 641 0448 00AF     		add	r7, sp, #0
 642              		.cfi_def_cfa_register 7
 163:mandelbrot.c  ****   struct timespec start, end;
 164:mandelbrot.c  ****   long int diff=0;
 643              		.loc 1 164 0
 644 044a 0023     		movs	r3, #0
 645 044c 3B63     		str	r3, [r7, #48]
 165:mandelbrot.c  ****   clock_gettime(CLOCK_MONOTONIC, &start); 
 646              		.loc 1 165 0
 647 044e 07F10803 		add	r3, r7, #8
 648 0452 0120     		movs	r0, #1
 649 0454 1946     		mov	r1, r3
 650 0456 FFF7FEFF 		bl	clock_gettime
 166:mandelbrot.c  ****   double minReal,minImag,size;
 167:mandelbrot.c  ****   unsigned char ***image;
 168:mandelbrot.c  ****   unsigned short i,j;
 169:mandelbrot.c  ****   FILE *outf;
 170:mandelbrot.c  **** 
 171:mandelbrot.c  ****   /*  printf("Minimum real: ");
 172:mandelbrot.c  ****    *  flag = scanf("%lf",&minReal);
 173:mandelbrot.c  ****    *  if (!flag) {
 174:mandelbrot.c  ****    *    printf("Invalid input\n");
 175:mandelbrot.c  ****    *    return -1 ;
 176:mandelbrot.c  ****    *  }
 177:mandelbrot.c  ****    * 
 178:mandelbrot.c  ****    *  printf("Minimum imaginary: ");
 179:mandelbrot.c  ****    *  flag = scanf("%lf",&minImag);
 180:mandelbrot.c  ****    *  if (!flag) {
 181:mandelbrot.c  ****    *    printf("Invalid input\n");
 182:mandelbrot.c  ****    *    return -1 ;
 183:mandelbrot.c  ****    *  }
 184:mandelbrot.c  ****    *  
 185:mandelbrot.c  ****    *  printf("Size: ");
 186:mandelbrot.c  ****    *  flag = scanf("%lf",&size);
 187:mandelbrot.c  ****    *  if (!flag) {
 188:mandelbrot.c  ****    *    printf("Invalid input\n");
 189:mandelbrot.c  ****    *    return -1 ;
 190:mandelbrot.c  ****    *  }
 191:mandelbrot.c  ****    */
 192:mandelbrot.c  **** 
 193:mandelbrot.c  ****   minReal = -1.6;
 651              		.loc 1 193 0
 652 045a 47A3     		adr	r3, .L26
 653 045c D3E90023 		ldrd	r2, [r3]
 654 0460 C7E90A23 		strd	r2, [r7, #40]
 194:mandelbrot.c  ****   minImag = -.45;
 655              		.loc 1 194 0
 656 0464 46A3     		adr	r3, .L26+8
 657 0466 D3E90023 		ldrd	r2, [r3]
 658 046a C7E90823 		strd	r2, [r7, #32]
 195:mandelbrot.c  ****   size = .9 ; 
 659              		.loc 1 195 0
 660 046e 46A3     		adr	r3, .L26+16
 661 0470 D3E90023 		ldrd	r2, [r3]
 662 0474 C7E90623 		strd	r2, [r7, #24]
 196:mandelbrot.c  ****   
 197:mandelbrot.c  ****     // Computation begins --------------------------------------
 198:mandelbrot.c  ****     outf =fopen("Mandelbrot.pgm","w");
 663              		.loc 1 198 0
 664 0478 40F20000 		movw	r0, #:lower16:.LC5
 665 047c C0F20000 		movt	r0, #:upper16:.LC5
 666 0480 40F20001 		movw	r1, #:lower16:.LC6
 667 0484 C0F20001 		movt	r1, #:upper16:.LC6
 668 0488 FFF7FEFF 		bl	fopen
 669 048c 7861     		str	r0, [r7, #20]
 199:mandelbrot.c  ****     image = malloc(HEIGHT * sizeof(char **));
 670              		.loc 1 199 0
 671 048e 4FF48060 		mov	r0, #1024
 672 0492 FFF7FEFF 		bl	malloc
 673 0496 0346     		mov	r3, r0
 674 0498 3B61     		str	r3, [r7, #16]
 200:mandelbrot.c  ****     for(i=0; i < HEIGHT; i++)
 675              		.loc 1 200 0
 676 049a 0023     		movs	r3, #0
 677 049c FB86     		strh	r3, [r7, #54]	@ movhi
 678 049e 0CE0     		b	.L20
 679              	.L21:
 201:mandelbrot.c  ****       image[i] = malloc(WIDTH * sizeof(char *));
 680              		.loc 1 201 0 discriminator 3
 681 04a0 FB8E     		ldrh	r3, [r7, #54]
 682 04a2 9B00     		lsls	r3, r3, #2
 683 04a4 3A69     		ldr	r2, [r7, #16]
 684 04a6 D418     		adds	r4, r2, r3
 685 04a8 4FF48060 		mov	r0, #1024
 686 04ac FFF7FEFF 		bl	malloc
 687 04b0 0346     		mov	r3, r0
 688 04b2 2360     		str	r3, [r4]
 200:mandelbrot.c  ****     for(i=0; i < HEIGHT; i++)
 689              		.loc 1 200 0 discriminator 3
 690 04b4 FB8E     		ldrh	r3, [r7, #54]
 691 04b6 0133     		adds	r3, r3, #1
 692 04b8 FB86     		strh	r3, [r7, #54]	@ movhi
 693              	.L20:
 200:mandelbrot.c  ****     for(i=0; i < HEIGHT; i++)
 694              		.loc 1 200 0 is_stmt 0 discriminator 1
 695 04ba FB8E     		ldrh	r3, [r7, #54]
 696 04bc FF2B     		cmp	r3, #255
 697 04be EFD9     		bls	.L21
 202:mandelbrot.c  ****   
 203:mandelbrot.c  ****     for(i=0; i< HEIGHT; i++)
 698              		.loc 1 203 0 is_stmt 1
 699 04c0 0023     		movs	r3, #0
 700 04c2 FB86     		strh	r3, [r7, #54]	@ movhi
 701 04c4 18E0     		b	.L22
 702              	.L25:
 204:mandelbrot.c  ****       for(j=0; j < WIDTH; j++)
 703              		.loc 1 204 0
 704 04c6 0023     		movs	r3, #0
 705 04c8 BB86     		strh	r3, [r7, #52]	@ movhi
 706 04ca 0FE0     		b	.L23
 707              	.L24:
 205:mandelbrot.c  **** 	image[i][j] = malloc( 3 * sizeof(unsigned char));
 708              		.loc 1 205 0 discriminator 3
 709 04cc FB8E     		ldrh	r3, [r7, #54]
 710 04ce 9B00     		lsls	r3, r3, #2
 711 04d0 3A69     		ldr	r2, [r7, #16]
 712 04d2 1344     		add	r3, r3, r2
 713 04d4 1A68     		ldr	r2, [r3]
 714 04d6 BB8E     		ldrh	r3, [r7, #52]
 715 04d8 9B00     		lsls	r3, r3, #2
 716 04da D418     		adds	r4, r2, r3
 717 04dc 0320     		movs	r0, #3
 718 04de FFF7FEFF 		bl	malloc
 719 04e2 0346     		mov	r3, r0
 720 04e4 2360     		str	r3, [r4]
 204:mandelbrot.c  ****       for(j=0; j < WIDTH; j++)
 721              		.loc 1 204 0 discriminator 3
 722 04e6 BB8E     		ldrh	r3, [r7, #52]
 723 04e8 0133     		adds	r3, r3, #1
 724 04ea BB86     		strh	r3, [r7, #52]	@ movhi
 725              	.L23:
 204:mandelbrot.c  ****       for(j=0; j < WIDTH; j++)
 726              		.loc 1 204 0 is_stmt 0 discriminator 1
 727 04ec BB8E     		ldrh	r3, [r7, #52]
 728 04ee FF2B     		cmp	r3, #255
 729 04f0 ECD9     		bls	.L24
 203:mandelbrot.c  ****       for(j=0; j < WIDTH; j++)
 730              		.loc 1 203 0 is_stmt 1 discriminator 2
 731 04f2 FB8E     		ldrh	r3, [r7, #54]
 732 04f4 0133     		adds	r3, r3, #1
 733 04f6 FB86     		strh	r3, [r7, #54]	@ movhi
 734              	.L22:
 203:mandelbrot.c  ****       for(j=0; j < WIDTH; j++)
 735              		.loc 1 203 0 is_stmt 0 discriminator 1
 736 04f8 FB8E     		ldrh	r3, [r7, #54]
 737 04fa FF2B     		cmp	r3, #255
 738 04fc E3D9     		bls	.L25
 206:mandelbrot.c  **** 
 207:mandelbrot.c  ****     drawFigure(image,minReal,minImag,size);
 739              		.loc 1 207 0 is_stmt 1
 740 04fe 3869     		ldr	r0, [r7, #16]
 741 0500 97ED0A0B 		fldd	d0, [r7, #40]
 742 0504 97ED081B 		fldd	d1, [r7, #32]
 743 0508 97ED062B 		fldd	d2, [r7, #24]
 744 050c FFF7FEFF 		bl	drawFigure
 208:mandelbrot.c  ****     saveImage(image,outf,255);
 745              		.loc 1 208 0
 746 0510 3869     		ldr	r0, [r7, #16]
 747 0512 7969     		ldr	r1, [r7, #20]
 748 0514 FF22     		movs	r2, #255
 749 0516 FFF7FEFF 		bl	saveImage
 209:mandelbrot.c  ****     fclose(outf);
 750              		.loc 1 209 0
 751 051a 7869     		ldr	r0, [r7, #20]
 752 051c FFF7FEFF 		bl	fclose
 210:mandelbrot.c  ****     // Computation ends --------------------------------------
 211:mandelbrot.c  ****     clock_gettime(CLOCK_MONOTONIC, &end);
 753              		.loc 1 211 0
 754 0520 3B46     		mov	r3, r7
 755 0522 0120     		movs	r0, #1
 756 0524 1946     		mov	r1, r3
 757 0526 FFF7FEFF 		bl	clock_gettime
 212:mandelbrot.c  ****     diff = 1000000 * (end.tv_sec - start.tv_sec) +
 758              		.loc 1 212 0
 759 052a 3A68     		ldr	r2, [r7]
 760 052c BB68     		ldr	r3, [r7, #8]
 761 052e D11A     		subs	r1, r2, r3
 762 0530 0A46     		mov	r2, r1
 763 0532 5201     		lsls	r2, r2, #5
 764 0534 521A     		subs	r2, r2, r1
 765 0536 9301     		lsls	r3, r2, #6
 766 0538 9B1A     		subs	r3, r3, r2
 767 053a DB00     		lsls	r3, r3, #3
 768 053c 0B44     		add	r3, r3, r1
 769 053e 9B01     		lsls	r3, r3, #6
 770 0540 1846     		mov	r0, r3
 213:mandelbrot.c  ****          +      (end.tv_nsec - start.tv_nsec)/1000;
 771              		.loc 1 213 0
 772 0542 7A68     		ldr	r2, [r7, #4]
 773 0544 FB68     		ldr	r3, [r7, #12]
 774 0546 D11A     		subs	r1, r2, r3
 775 0548 44F6D353 		movw	r3, #19923
 776 054c C1F26203 		movt	r3, 4194
 777 0550 81FB0323 		smull	r2, r3, r1, r3
 778 0554 9A11     		asrs	r2, r3, #6
 779 0556 CB17     		asrs	r3, r1, #31
 780 0558 D31A     		subs	r3, r2, r3
 212:mandelbrot.c  ****     diff = 1000000 * (end.tv_sec - start.tv_sec) +
 781              		.loc 1 212 0
 782 055a 0344     		add	r3, r3, r0
 783 055c 3B63     		str	r3, [r7, #48]
 214:mandelbrot.c  ****     printf("%ld\n",diff);
 784              		.loc 1 214 0
 785 055e 40F20000 		movw	r0, #:lower16:.LC7
 786 0562 C0F20000 		movt	r0, #:upper16:.LC7
 787 0566 396B     		ldr	r1, [r7, #48]
 788 0568 FFF7FEFF 		bl	printf
 215:mandelbrot.c  ****   exit(0);
 789              		.loc 1 215 0
 790 056c 0020     		movs	r0, #0
 791 056e FFF7FEFF 		bl	exit
 792              	.L27:
 793 0572 00BFAFF3 		.align	3
 793      0080
 794              	.L26:
 795 0578 9A999999 		.word	-1717986918
 796 057c 9999F9BF 		.word	-1074161255
 797 0580 CDCCCCCC 		.word	-858993459
 798 0584 CCCCDCBF 		.word	-1076048692
 799 0588 CDCCCCCC 		.word	-858993459
 800 058c CCCCEC3F 		.word	1072483532
 801              		.cfi_endproc
 802              	.LFE5:
 804              	.Letext0:
 805              		.file 2 "/usr/lib/gcc/arm-linux-gnueabihf/4.9/include/stddef.h"
 806              		.file 3 "/usr/include/arm-linux-gnueabihf/bits/types.h"
 807              		.file 4 "/usr/include/stdio.h"
 808              		.file 5 "/usr/include/libio.h"
 809              		.file 6 "/usr/include/time.h"
