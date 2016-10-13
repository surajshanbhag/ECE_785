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
  15              		.file	"alpha_time.c"
  16              		.text
  17              	.Ltext0:
  18              		.cfi_sections	.debug_frame
  19              		.comm	backImage,1048576,4
  20              		.comm	foreImage,1048576,4
  21              		.comm	newImage,1048576,4
  22              		.section	.rodata
  23              		.align	2
  24              	.LC0:
  25 0000 55736167 		.ascii	"Usage:%s foreground background outFile\012\000"
  25      653A2573 
  25      20666F72 
  25      6567726F 
  25      756E6420 
  26              		.align	2
  27              	.LC1:
  28 0028 726200   		.ascii	"rb\000"
  29 002b 00       		.align	2
  30              	.LC2:
  31 002c 776200   		.ascii	"wb\000"
  32 002f 00       		.align	2
  33              	.LC3:
  34 0030 4572726F 		.ascii	"Error with backImage\012\000"
  34      72207769 
  34      74682062 
  34      61636B49 
  34      6D616765 
  35 0046 0000     		.align	2
  36              	.LC4:
  37 0048 4572726F 		.ascii	"Error with foreImage\012\000"
  37      72207769 
  37      74682066 
  37      6F726549 
  37      6D616765 
  38 005e 0000     		.align	2
  39              	.LC5:
  40 0060 526F7574 		.ascii	"Routine took %ld %ld microseconds\012\000"
  40      696E6520 
  40      746F6F6B 
  40      20256C64 
  40      20256C64 
  41 0083 00       		.align	2
  42              	.LC6:
  43 0084 50726F62 		.ascii	"Problem opening a file\012\000"
  43      6C656D20 
  43      6F70656E 
  43      696E6720 
  43      61206669 
  44              		.text
  45              		.align	2
  46              		.global	main
  47              		.thumb
  48              		.thumb_func
  50              	main:
  51              	.LFB0:
  52              		.file 1 "alpha_time.c"
   1:alpha_time.c  **** void alphaBlend_c(void);//int *fgImage, int *bgImage, int *dstImage);
   2:alpha_time.c  **** 
   3:alpha_time.c  **** #include <stdio.h>
   4:alpha_time.c  **** #include <sys/time.h>
   5:alpha_time.c  **** #include <time.h>
   6:alpha_time.c  **** 
   7:alpha_time.c  **** int backImage[512 * 512];
   8:alpha_time.c  **** int foreImage[512 * 512];
   9:alpha_time.c  **** int newImage[512 * 512];
  10:alpha_time.c  **** #define fgImage foreImage
  11:alpha_time.c  **** #define bgImage backImage
  12:alpha_time.c  **** #define dstImage newImage
  13:alpha_time.c  **** int main(int argc, char**argv)
  14:alpha_time.c  **** {
  53              		.loc 1 14 0
  54              		.cfi_startproc
  55              		@ args = 0, pretend = 0, frame = 64
  56              		@ frame_needed = 1, uses_anonymous_args = 0
  57 0000 90B5     		push	{r4, r7, lr}
  58              	.LCFI0:
  59              		.cfi_def_cfa_offset 12
  60              		.cfi_offset 14, -4
  61              		.cfi_offset 7, -8
  62              		.cfi_offset 4, -12
  63 0002 91B0     		sub	sp, sp, #68
  64              	.LCFI1:
  65              		.cfi_def_cfa_offset 80
  66 0004 00AF     		add	r7, sp, #0
  67              	.LCFI2:
  68              		.cfi_def_cfa_register 7
  69 0006 7860     		str	r0, [r7, #4]
  70 0008 3960     		str	r1, [r7, #0]
  15:alpha_time.c  ****     FILE *fgFile, *bgFile, *outFile;
  16:alpha_time.c  ****     int result;
  17:alpha_time.c  ****     struct timeval oldTv, newTv;
  18:alpha_time.c  ****     struct timespec start, end;
  19:alpha_time.c  ****     unsigned long diff_1,diff_2;
  20:alpha_time.c  **** 
  21:alpha_time.c  ****     if(argc != 4){
  71              		.loc 1 21 0
  72 000a 7B68     		ldr	r3, [r7, #4]
  73 000c 042B     		cmp	r3, #4
  74 000e 12D0     		beq	.L2
  22:alpha_time.c  ****         fprintf(stderr, "Usage:%s foreground background outFile\n",argv[0]);
  75              		.loc 1 22 0
  76 0010 40F20003 		movw	r3, #:lower16:stderr
  77 0014 C0F20003 		movt	r3, #:upper16:stderr
  78 0018 1B68     		ldr	r3, [r3, #0]
  79 001a 1946     		mov	r1, r3
  80 001c 40F20003 		movw	r3, #:lower16:.LC0
  81 0020 C0F20003 		movt	r3, #:upper16:.LC0
  82 0024 3A68     		ldr	r2, [r7, #0]
  83 0026 1268     		ldr	r2, [r2, #0]
  84 0028 0846     		mov	r0, r1
  85 002a 1946     		mov	r1, r3
  86 002c FFF7FEFF 		bl	fprintf
  23:alpha_time.c  ****         return 1;
  87              		.loc 1 23 0
  88 0030 4FF00103 		mov	r3, #1
  89 0034 07E1     		b	.L3
  90              	.L2:
  24:alpha_time.c  ****     }
  25:alpha_time.c  ****     fgFile = fopen(argv[1], "rb");
  91              		.loc 1 25 0
  92 0036 3B68     		ldr	r3, [r7, #0]
  93 0038 03F10403 		add	r3, r3, #4
  94 003c 1B68     		ldr	r3, [r3, #0]
  95 003e 1A46     		mov	r2, r3
  96 0040 40F20003 		movw	r3, #:lower16:.LC1
  97 0044 C0F20003 		movt	r3, #:upper16:.LC1
  98 0048 1046     		mov	r0, r2
  99 004a 1946     		mov	r1, r3
 100 004c FFF7FEFF 		bl	fopen
 101 0050 0346     		mov	r3, r0
 102 0052 FB63     		str	r3, [r7, #60]
  26:alpha_time.c  ****     bgFile = fopen(argv[2], "rb");
 103              		.loc 1 26 0
 104 0054 3B68     		ldr	r3, [r7, #0]
 105 0056 03F10803 		add	r3, r3, #8
 106 005a 1B68     		ldr	r3, [r3, #0]
 107 005c 1A46     		mov	r2, r3
 108 005e 40F20003 		movw	r3, #:lower16:.LC1
 109 0062 C0F20003 		movt	r3, #:upper16:.LC1
 110 0066 1046     		mov	r0, r2
 111 0068 1946     		mov	r1, r3
 112 006a FFF7FEFF 		bl	fopen
 113 006e 0346     		mov	r3, r0
 114 0070 BB63     		str	r3, [r7, #56]
  27:alpha_time.c  ****     outFile = fopen(argv[3], "wb");
 115              		.loc 1 27 0
 116 0072 3B68     		ldr	r3, [r7, #0]
 117 0074 03F10C03 		add	r3, r3, #12
 118 0078 1B68     		ldr	r3, [r3, #0]
 119 007a 1A46     		mov	r2, r3
 120 007c 40F20003 		movw	r3, #:lower16:.LC2
 121 0080 C0F20003 		movt	r3, #:upper16:.LC2
 122 0084 1046     		mov	r0, r2
 123 0086 1946     		mov	r1, r3
 124 0088 FFF7FEFF 		bl	fopen
 125 008c 0346     		mov	r3, r0
 126 008e 7B63     		str	r3, [r7, #52]
  28:alpha_time.c  **** 
  29:alpha_time.c  ****     if(fgFile && bgFile && outFile){
 127              		.loc 1 29 0
 128 0090 FB6B     		ldr	r3, [r7, #60]
 129 0092 002B     		cmp	r3, #0
 130 0094 00F0C380 		beq	.L4
 131              		.loc 1 29 0 is_stmt 0 discriminator 1
 132 0098 BB6B     		ldr	r3, [r7, #56]
 133 009a 002B     		cmp	r3, #0
 134 009c 00F0BF80 		beq	.L4
 135 00a0 7B6B     		ldr	r3, [r7, #52]
 136 00a2 002B     		cmp	r3, #0
 137 00a4 00F0BB80 		beq	.L4
  30:alpha_time.c  ****         result = fread(backImage, 512*sizeof(int), 512, bgFile);
 138              		.loc 1 30 0 is_stmt 1
 139 00a8 40F20003 		movw	r3, #:lower16:backImage
 140 00ac C0F20003 		movt	r3, #:upper16:backImage
 141 00b0 1846     		mov	r0, r3
 142 00b2 4FF40061 		mov	r1, #2048
 143 00b6 4FF40072 		mov	r2, #512
 144 00ba BB6B     		ldr	r3, [r7, #56]
 145 00bc FFF7FEFF 		bl	fread
 146 00c0 0346     		mov	r3, r0
 147 00c2 3B63     		str	r3, [r7, #48]
  31:alpha_time.c  ****         if(result != 512){
 148              		.loc 1 31 0
 149 00c4 3B6B     		ldr	r3, [r7, #48]
 150 00c6 B3F5007F 		cmp	r3, #512
 151 00ca 14D0     		beq	.L5
  32:alpha_time.c  ****             fprintf(stderr, "Error with backImage\n");
 152              		.loc 1 32 0
 153 00cc 40F20003 		movw	r3, #:lower16:.LC3
 154 00d0 C0F20003 		movt	r3, #:upper16:.LC3
 155 00d4 40F20002 		movw	r2, #:lower16:stderr
 156 00d8 C0F20002 		movt	r2, #:upper16:stderr
 157 00dc 1268     		ldr	r2, [r2, #0]
 158 00de 1446     		mov	r4, r2
 159 00e0 1846     		mov	r0, r3
 160 00e2 4FF00101 		mov	r1, #1
 161 00e6 4FF01502 		mov	r2, #21
 162 00ea 2346     		mov	r3, r4
 163 00ec FFF7FEFF 		bl	fwrite
  33:alpha_time.c  ****             return 3;
 164              		.loc 1 33 0
 165 00f0 4FF00303 		mov	r3, #3
 166 00f4 A7E0     		b	.L3
 167              	.L5:
  34:alpha_time.c  ****         }
  35:alpha_time.c  ****         result = fread(foreImage, 512*sizeof(int), 512, fgFile);
 168              		.loc 1 35 0
 169 00f6 40F20003 		movw	r3, #:lower16:foreImage
 170 00fa C0F20003 		movt	r3, #:upper16:foreImage
 171 00fe 1846     		mov	r0, r3
 172 0100 4FF40061 		mov	r1, #2048
 173 0104 4FF40072 		mov	r2, #512
 174 0108 FB6B     		ldr	r3, [r7, #60]
 175 010a FFF7FEFF 		bl	fread
 176 010e 0346     		mov	r3, r0
 177 0110 3B63     		str	r3, [r7, #48]
  36:alpha_time.c  ****         if(result != 512){
 178              		.loc 1 36 0
 179 0112 3B6B     		ldr	r3, [r7, #48]
 180 0114 B3F5007F 		cmp	r3, #512
 181 0118 14D0     		beq	.L6
  37:alpha_time.c  ****             fprintf(stderr, "Error with foreImage\n");
 182              		.loc 1 37 0
 183 011a 40F20003 		movw	r3, #:lower16:.LC4
 184 011e C0F20003 		movt	r3, #:upper16:.LC4
 185 0122 40F20002 		movw	r2, #:lower16:stderr
 186 0126 C0F20002 		movt	r2, #:upper16:stderr
 187 012a 1268     		ldr	r2, [r2, #0]
 188 012c 1446     		mov	r4, r2
 189 012e 1846     		mov	r0, r3
 190 0130 4FF00101 		mov	r1, #1
 191 0134 4FF01502 		mov	r2, #21
 192 0138 2346     		mov	r3, r4
 193 013a FFF7FEFF 		bl	fwrite
  38:alpha_time.c  ****             return 4;
 194              		.loc 1 38 0
 195 013e 4FF00403 		mov	r3, #4
 196 0142 80E0     		b	.L3
 197              	.L6:
  39:alpha_time.c  ****         }
  40:alpha_time.c  ****         gettimeofday(&oldTv, NULL);
 198              		.loc 1 40 0
 199 0144 07F12003 		add	r3, r7, #32
 200 0148 1846     		mov	r0, r3
 201 014a 4FF00001 		mov	r1, #0
 202 014e FFF7FEFF 		bl	gettimeofday
  41:alpha_time.c  ****         alphaBlend_c();//&foreImage[0], &backImage[0], &newImage[0]);
 203              		.loc 1 41 0
 204 0152 FFF7FEFF 		bl	alphaBlend_c
  42:alpha_time.c  ****         gettimeofday(&newTv, NULL);
 205              		.loc 1 42 0
 206 0156 07F11803 		add	r3, r7, #24
 207 015a 1846     		mov	r0, r3
 208 015c 4FF00001 		mov	r1, #0
 209 0160 FFF7FEFF 		bl	gettimeofday
  43:alpha_time.c  **** 
  44:alpha_time.c  ****         clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
 210              		.loc 1 44 0
 211 0164 07F11003 		add	r3, r7, #16
 212 0168 4FF00200 		mov	r0, #2
 213 016c 1946     		mov	r1, r3
 214 016e FFF7FEFF 		bl	clock_gettime
  45:alpha_time.c  ****         alphaBlend_c();//&foreImage[0], &backImage[0], &newImage[0]);
 215              		.loc 1 45 0
 216 0172 FFF7FEFF 		bl	alphaBlend_c
  46:alpha_time.c  ****         clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
 217              		.loc 1 46 0
 218 0176 07F10803 		add	r3, r7, #8
 219 017a 4FF00200 		mov	r0, #2
 220 017e 1946     		mov	r1, r3
 221 0180 FFF7FEFF 		bl	clock_gettime
  47:alpha_time.c  **** 
  48:alpha_time.c  ****         diff_2 = 1000000000 * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
 222              		.loc 1 48 0
 223 0184 BA68     		ldr	r2, [r7, #8]
 224 0186 3B69     		ldr	r3, [r7, #16]
 225 0188 D21A     		subs	r2, r2, r3
 226 018a 4FF44A43 		mov	r3, #51712
 227 018e C3F69A33 		movt	r3, 15258
 228 0192 03FB02F2 		mul	r2, r3, r2
 229 0196 FB68     		ldr	r3, [r7, #12]
 230 0198 D218     		adds	r2, r2, r3
 231 019a 7B69     		ldr	r3, [r7, #20]
 232 019c D31A     		subs	r3, r2, r3
 233 019e FB62     		str	r3, [r7, #44]
  49:alpha_time.c  ****         diff_1 = ((newTv.tv_sec-oldTv.tv_sec)*1000000 + newTv.tv_usec-oldTv.tv_usec);
 234              		.loc 1 49 0
 235 01a0 BA69     		ldr	r2, [r7, #24]
 236 01a2 3B6A     		ldr	r3, [r7, #32]
 237 01a4 D21A     		subs	r2, r2, r3
 238 01a6 44F24023 		movw	r3, #16960
 239 01aa C0F20F03 		movt	r3, 15
 240 01ae 03FB02F2 		mul	r2, r3, r2
 241 01b2 FB69     		ldr	r3, [r7, #28]
 242 01b4 D218     		adds	r2, r2, r3
 243 01b6 7B6A     		ldr	r3, [r7, #36]
 244 01b8 D31A     		subs	r3, r2, r3
 245 01ba BB62     		str	r3, [r7, #40]
  50:alpha_time.c  ****         fprintf(stdout, "Routine took %ld %ld microseconds\n", diff_1,diff_2/1000);
 246              		.loc 1 50 0
 247 01bc 40F20003 		movw	r3, #:lower16:stdout
 248 01c0 C0F20003 		movt	r3, #:upper16:stdout
 249 01c4 1B68     		ldr	r3, [r3, #0]
 250 01c6 1946     		mov	r1, r3
 251 01c8 40F20003 		movw	r3, #:lower16:.LC5
 252 01cc C0F20003 		movt	r3, #:upper16:.LC5
 253 01d0 F86A     		ldr	r0, [r7, #44]
 254 01d2 44F6D352 		movw	r2, #19923
 255 01d6 C1F26202 		movt	r2, 4194
 256 01da A2FB00C2 		umull	ip, r2, r2, r0
 257 01de 4FEA9214 		lsr	r4, r2, #6
 258 01e2 0846     		mov	r0, r1
 259 01e4 1946     		mov	r1, r3
 260 01e6 BA6A     		ldr	r2, [r7, #40]
 261 01e8 2346     		mov	r3, r4
 262 01ea FFF7FEFF 		bl	fprintf
  51:alpha_time.c  ****         fwrite(newImage, 512*sizeof(int),512,outFile);
 263              		.loc 1 51 0
 264 01ee 40F20003 		movw	r3, #:lower16:newImage
 265 01f2 C0F20003 		movt	r3, #:upper16:newImage
 266 01f6 1846     		mov	r0, r3
 267 01f8 4FF40061 		mov	r1, #2048
 268 01fc 4FF40072 		mov	r2, #512
 269 0200 7B6B     		ldr	r3, [r7, #52]
 270 0202 FFF7FEFF 		bl	fwrite
  52:alpha_time.c  ****         fclose(fgFile);
 271              		.loc 1 52 0
 272 0206 F86B     		ldr	r0, [r7, #60]
 273 0208 FFF7FEFF 		bl	fclose
  53:alpha_time.c  ****         fclose(bgFile);
 274              		.loc 1 53 0
 275 020c B86B     		ldr	r0, [r7, #56]
 276 020e FFF7FEFF 		bl	fclose
  54:alpha_time.c  ****         fclose(outFile);
 277              		.loc 1 54 0
 278 0212 786B     		ldr	r0, [r7, #52]
 279 0214 FFF7FEFF 		bl	fclose
  55:alpha_time.c  ****         return 0;
 280              		.loc 1 55 0
 281 0218 4FF00003 		mov	r3, #0
 282 021c 13E0     		b	.L3
 283              	.L4:
  56:alpha_time.c  ****     }
  57:alpha_time.c  ****     fprintf(stderr, "Problem opening a file\n");
 284              		.loc 1 57 0
 285 021e 40F20003 		movw	r3, #:lower16:.LC6
 286 0222 C0F20003 		movt	r3, #:upper16:.LC6
 287 0226 40F20002 		movw	r2, #:lower16:stderr
 288 022a C0F20002 		movt	r2, #:upper16:stderr
 289 022e 1268     		ldr	r2, [r2, #0]
 290 0230 1446     		mov	r4, r2
 291 0232 1846     		mov	r0, r3
 292 0234 4FF00101 		mov	r1, #1
 293 0238 4FF01702 		mov	r2, #23
 294 023c 2346     		mov	r3, r4
 295 023e FFF7FEFF 		bl	fwrite
  58:alpha_time.c  ****     return 2;
 296              		.loc 1 58 0
 297 0242 4FF00203 		mov	r3, #2
 298              	.L3:
  59:alpha_time.c  **** }
 299              		.loc 1 59 0
 300 0246 1846     		mov	r0, r3
 301 0248 07F14407 		add	r7, r7, #68
 302 024c BD46     		mov	sp, r7
 303 024e 90BD     		pop	{r4, r7, pc}
 304              		.cfi_endproc
 305              	.LFE0:
 307              		.align	2
 308              		.global	alphaBlend_c
 309              		.thumb
 310              		.thumb_func
 312              	alphaBlend_c:
 313              	.LFB1:
  60:alpha_time.c  **** 
  61:alpha_time.c  **** #define type short 
  62:alpha_time.c  **** #define A(x) (type)(((x) & 0xff000000) >> 24)
  63:alpha_time.c  **** #define R(x) (type)(((x) & 0x00ff0000) >> 16)
  64:alpha_time.c  **** #define G(x) (type)(((x) & 0x0000ff00) >> 8)
  65:alpha_time.c  **** #define B(x) (type)((x) & 0x000000ff)
  66:alpha_time.c  **** 
  67:alpha_time.c  **** void alphaBlend_c(void)//int *__restrict fgImage,int *__restrict bgImage,int *__restrict dstImage)
  68:alpha_time.c  **** {
 314              		.loc 1 68 0
 315              		.cfi_startproc
 316              		@ args = 0, pretend = 0, frame = 8650784
 317              		@ frame_needed = 1, uses_anonymous_args = 0
 318              		@ link register save eliminated.
 319 0250 80B4     		push	{r7}
 320              	.LCFI3:
 321              		.cfi_def_cfa_offset 4
 322              		.cfi_offset 7, -4
 323 0252 ADF5040D 		sub	sp, sp, #8650752
 324              	.LCFI4:
 325              		.cfi_def_cfa_offset 8650756
 326 0256 89B0     		sub	sp, sp, #36
 327              	.LCFI5:
 328              		.cfi_def_cfa_offset 8650792
 329 0258 00AF     		add	r7, sp, #0
 330              	.LCFI6:
 331              		.cfi_def_cfa_register 7
  69:alpha_time.c  ****     /* int x, y;
  70:alpha_time.c  ****        for(y = 0; y < 512*512; y++){
  71:alpha_time.c  ****        int a_fg = A(fgImage[y]);
  72:alpha_time.c  ****        int dst_r = ((R(fgImage[y]) * a_fg) + (R(bgImage[y]) * (255-a_fg)))/256;
  73:alpha_time.c  ****        int dst_g = ((G(fgImage[y]) * a_fg) + (G(bgImage[y]) * (255-a_fg)))/256;
  74:alpha_time.c  ****        int dst_b = ((B(fgImage[y]) * a_fg) + (B(bgImage[y]) * (255-a_fg)))/256;
  75:alpha_time.c  ****        dstImage[y] =  0xff000000 |
  76:alpha_time.c  ****        (0x00ff0000 & (dst_r << 16)) |
  77:alpha_time.c  ****        (0x0000ff00 & (dst_g << 8)) |
  78:alpha_time.c  ****        (0x000000ff & (dst_b));
  79:alpha_time.c  ****        }nt x, y;
  80:alpha_time.c  ****            for(y = 0; y < 512; y++){
  81:alpha_time.c  ****                    for(x = 0; x < 512; x++){
  82:alpha_time.c  ****                                int a_fg = A(fgImage[(y*512)+x]);
  83:alpha_time.c  ****                                            int dst_r = ((R(fgImage[(y*512)+x]) * a_fg) + (R(bgImage
  84:alpha_time.c  ****                                                        int dst_g = ((G(fgImage[(y*512)+x]) * a_fg) 
  85:alpha_time.c  ****                                                                    int dst_b = ((B(fgImage[(y*512)+
  86:alpha_time.c  ****                                                                                dstImage[(y*512)+x] 
  87:alpha_time.c  ****                                                                                                (0x0
  88:alpha_time.c  ****                                                                                                    
  89:alpha_time.c  ****                                                                                                    
  90:alpha_time.c  ****                                                                                                    
  91:alpha_time.c  ****                                                                                                    
  92:alpha_time.c  **** 
  93:alpha_time.c  ****     int x=0, y=0;
 332              		.loc 1 93 0
 333 025a 4FF00003 		mov	r3, #0
 334 025e 07F50400 		add	r0, r7, #8650752
 335 0262 00F11800 		add	r0, r0, #24
 336 0266 0360     		str	r3, [r0, #0]
 337 0268 4FF00003 		mov	r3, #0
 338 026c 07F50401 		add	r1, r7, #8650752
 339 0270 01F11401 		add	r1, r1, #20
 340 0274 0B60     		str	r3, [r1, #0]
  94:alpha_time.c  ****     //int a_fg=0,a_fgM255=0;
  95:alpha_time.c  ****     //int r_fg=0,b_fg=0,g_fg=0,r_bg=0,g_bg=0,b_bg=0;
  96:alpha_time.c  ****     int dst_r=0,dst_b=0,dst_g=0;
 341              		.loc 1 96 0
 342 0276 4FF00003 		mov	r3, #0
 343 027a 07F50402 		add	r2, r7, #8650752
 344 027e 02F11002 		add	r2, r2, #16
 345 0282 1360     		str	r3, [r2, #0]
 346 0284 4FF00003 		mov	r3, #0
 347 0288 07F50400 		add	r0, r7, #8650752
 348 028c 00F10C00 		add	r0, r0, #12
 349 0290 0360     		str	r3, [r0, #0]
 350 0292 4FF00003 		mov	r3, #0
 351 0296 07F50401 		add	r1, r7, #8650752
 352 029a 01F10801 		add	r1, r1, #8
 353 029e 0B60     		str	r3, [r1, #0]
  97:alpha_time.c  ****     int dst_rf[512*512],dst_bf[512*512],dst_gf[512*512],dst_af[512*512];
  98:alpha_time.c  ****     char r_fg[512*512],b_fg[512*512],g_fg[512*512],a_fg[512*512],a_fgM255[512*512];
  99:alpha_time.c  ****     int r_bg[512*512],b_bg[512*512],g_bg[512*512];
 100:alpha_time.c  ****     int temp=0;
 354              		.loc 1 100 0
 355 02a0 4FF00003 		mov	r3, #0
 356 02a4 07F50402 		add	r2, r7, #8650752
 357 02a8 02F10402 		add	r2, r2, #4
 358 02ac 1360     		str	r3, [r2, #0]
 101:alpha_time.c  ****     int index=0;
 359              		.loc 1 101 0
 360 02ae 4FF00003 		mov	r3, #0
 361 02b2 07F50400 		add	r0, r7, #8650752
 362 02b6 00F11C00 		add	r0, r0, #28
 363 02ba 0360     		str	r3, [r0, #0]
 102:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 364              		.loc 1 102 0
 365 02bc 4FF00003 		mov	r3, #0
 366 02c0 07F50401 		add	r1, r7, #8650752
 367 02c4 01F11C01 		add	r1, r1, #28
 368 02c8 0B60     		str	r3, [r1, #0]
 369 02ca 26E0     		b	.L8
 370              	.L9:
 103:alpha_time.c  ****         a_fg[index]=A(fgImage[index]);
 371              		.loc 1 103 0 discriminator 2
 372 02cc 40F20003 		movw	r3, #:lower16:foreImage
 373 02d0 C0F20003 		movt	r3, #:upper16:foreImage
 374 02d4 07F50400 		add	r0, r7, #8650752
 375 02d8 00F11C00 		add	r0, r0, #28
 376 02dc 0268     		ldr	r2, [r0, #0]
 377 02de 53F82230 		ldr	r3, [r3, r2, lsl #2]
 378 02e2 4FEA1363 		lsr	r3, r3, #24
 379 02e6 DAB2     		uxtb	r2, r3
 380 02e8 07F55013 		add	r3, r7, #3407872
 381 02ec 03F12003 		add	r3, r3, #32
 382 02f0 A3F11C03 		sub	r3, r3, #28
 383 02f4 07F50400 		add	r0, r7, #8650752
 384 02f8 00F11C00 		add	r0, r0, #28
 385 02fc 0168     		ldr	r1, [r0, #0]
 386 02fe 5B18     		adds	r3, r3, r1
 387 0300 1A70     		strb	r2, [r3, #0]
 102:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 388              		.loc 1 102 0 discriminator 2
 389 0302 07F50401 		add	r1, r7, #8650752
 390 0306 01F11C01 		add	r1, r1, #28
 391 030a 0B68     		ldr	r3, [r1, #0]
 392 030c 03F10103 		add	r3, r3, #1
 393 0310 07F50402 		add	r2, r7, #8650752
 394 0314 02F11C02 		add	r2, r2, #28
 395 0318 1360     		str	r3, [r2, #0]
 396              	.L8:
 102:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 397              		.loc 1 102 0 is_stmt 0 discriminator 1
 398 031a 07F50403 		add	r3, r7, #8650752
 399 031e 03F11C03 		add	r3, r3, #28
 400 0322 1A68     		ldr	r2, [r3, #0]
 401 0324 4FF6FF73 		movw	r3, #65535
 402 0328 C0F20303 		movt	r3, 3
 403 032c 9A42     		cmp	r2, r3
 404 032e CDDD     		ble	.L9
 104:alpha_time.c  ****     }
 105:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 405              		.loc 1 105 0 is_stmt 1
 406 0330 4FF00003 		mov	r3, #0
 407 0334 07F50400 		add	r0, r7, #8650752
 408 0338 00F11C00 		add	r0, r0, #28
 409 033c 0360     		str	r3, [r0, #0]
 410 033e 5EE0     		b	.L10
 411              	.L11:
 106:alpha_time.c  ****         r_fg[index]=R(fgImage[index]);
 412              		.loc 1 106 0 discriminator 2
 413 0340 40F20003 		movw	r3, #:lower16:foreImage
 414 0344 C0F20003 		movt	r3, #:upper16:foreImage
 415 0348 07F50401 		add	r1, r7, #8650752
 416 034c 01F11C01 		add	r1, r1, #28
 417 0350 0A68     		ldr	r2, [r1, #0]
 418 0352 53F82230 		ldr	r3, [r3, r2, lsl #2]
 419 0356 03F47F03 		and	r3, r3, #16711680
 420 035a 4FEA2343 		asr	r3, r3, #16
 421 035e DAB2     		uxtb	r2, r3
 422 0360 07F58003 		add	r3, r7, #4194304
 423 0364 03F12003 		add	r3, r3, #32
 424 0368 A3F11C03 		sub	r3, r3, #28
 425 036c 07F50400 		add	r0, r7, #8650752
 426 0370 00F11C00 		add	r0, r0, #28
 427 0374 0168     		ldr	r1, [r0, #0]
 428 0376 5B18     		adds	r3, r3, r1
 429 0378 1A70     		strb	r2, [r3, #0]
 107:alpha_time.c  ****         g_fg[index]=G(fgImage[index]);
 430              		.loc 1 107 0 discriminator 2
 431 037a 40F20003 		movw	r3, #:lower16:foreImage
 432 037e C0F20003 		movt	r3, #:upper16:foreImage
 433 0382 07F50401 		add	r1, r7, #8650752
 434 0386 01F11C01 		add	r1, r1, #28
 435 038a 0A68     		ldr	r2, [r1, #0]
 436 038c 53F82230 		ldr	r3, [r3, r2, lsl #2]
 437 0390 03F47F43 		and	r3, r3, #65280
 438 0394 4FEA2323 		asr	r3, r3, #8
 439 0398 DAB2     		uxtb	r2, r3
 440 039a 07F56013 		add	r3, r7, #3670016
 441 039e 03F12003 		add	r3, r3, #32
 442 03a2 A3F11C03 		sub	r3, r3, #28
 443 03a6 07F50400 		add	r0, r7, #8650752
 444 03aa 00F11C00 		add	r0, r0, #28
 445 03ae 0168     		ldr	r1, [r0, #0]
 446 03b0 5B18     		adds	r3, r3, r1
 447 03b2 1A70     		strb	r2, [r3, #0]
 108:alpha_time.c  ****         b_fg[index]=B(fgImage[index]);
 448              		.loc 1 108 0 discriminator 2
 449 03b4 40F20003 		movw	r3, #:lower16:foreImage
 450 03b8 C0F20003 		movt	r3, #:upper16:foreImage
 451 03bc 07F50401 		add	r1, r7, #8650752
 452 03c0 01F11C01 		add	r1, r1, #28
 453 03c4 0A68     		ldr	r2, [r1, #0]
 454 03c6 53F82230 		ldr	r3, [r3, r2, lsl #2]
 455 03ca DAB2     		uxtb	r2, r3
 456 03cc 07F57013 		add	r3, r7, #3932160
 457 03d0 03F12003 		add	r3, r3, #32
 458 03d4 A3F11C03 		sub	r3, r3, #28
 459 03d8 07F50400 		add	r0, r7, #8650752
 460 03dc 00F11C00 		add	r0, r0, #28
 461 03e0 0168     		ldr	r1, [r0, #0]
 462 03e2 5B18     		adds	r3, r3, r1
 463 03e4 1A70     		strb	r2, [r3, #0]
 105:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 464              		.loc 1 105 0 discriminator 2
 465 03e6 07F50401 		add	r1, r7, #8650752
 466 03ea 01F11C01 		add	r1, r1, #28
 467 03ee 0B68     		ldr	r3, [r1, #0]
 468 03f0 03F10103 		add	r3, r3, #1
 469 03f4 07F50402 		add	r2, r7, #8650752
 470 03f8 02F11C02 		add	r2, r2, #28
 471 03fc 1360     		str	r3, [r2, #0]
 472              	.L10:
 105:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 473              		.loc 1 105 0 is_stmt 0 discriminator 1
 474 03fe 07F50403 		add	r3, r7, #8650752
 475 0402 03F11C03 		add	r3, r3, #28
 476 0406 1A68     		ldr	r2, [r3, #0]
 477 0408 4FF6FF73 		movw	r3, #65535
 478 040c C0F20303 		movt	r3, 3
 479 0410 9A42     		cmp	r2, r3
 480 0412 95DD     		ble	.L11
 109:alpha_time.c  ****     }
 110:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 481              		.loc 1 110 0 is_stmt 1
 482 0414 4FF00003 		mov	r3, #0
 483 0418 07F50400 		add	r0, r7, #8650752
 484 041c 00F11C00 		add	r0, r0, #28
 485 0420 0360     		str	r3, [r0, #0]
 486 0422 5DE0     		b	.L12
 487              	.L13:
 111:alpha_time.c  ****         r_bg[index]=R(bgImage[index]);
 488              		.loc 1 111 0 discriminator 2
 489 0424 40F20003 		movw	r3, #:lower16:backImage
 490 0428 C0F20003 		movt	r3, #:upper16:backImage
 491 042c 07F50401 		add	r1, r7, #8650752
 492 0430 01F11C01 		add	r1, r1, #28
 493 0434 0A68     		ldr	r2, [r1, #0]
 494 0436 53F82230 		ldr	r3, [r3, r2, lsl #2]
 495 043a 03F47F03 		and	r3, r3, #16711680
 496 043e 4FEA2343 		asr	r3, r3, #16
 497 0442 9BB2     		uxth	r3, r3
 498 0444 19B2     		sxth	r1, r3
 499 0446 07F12013 		add	r3, r7, #2097184
 500 044a A3F11C03 		sub	r3, r3, #28
 501 044e 07F50400 		add	r0, r7, #8650752
 502 0452 00F11C00 		add	r0, r0, #28
 503 0456 0268     		ldr	r2, [r0, #0]
 504 0458 43F82210 		str	r1, [r3, r2, lsl #2]
 112:alpha_time.c  ****         g_bg[index]=G(bgImage[index]);
 505              		.loc 1 112 0 discriminator 2
 506 045c 40F20003 		movw	r3, #:lower16:backImage
 507 0460 C0F20003 		movt	r3, #:upper16:backImage
 508 0464 07F50401 		add	r1, r7, #8650752
 509 0468 01F11C01 		add	r1, r1, #28
 510 046c 0A68     		ldr	r2, [r1, #0]
 511 046e 53F82230 		ldr	r3, [r3, r2, lsl #2]
 512 0472 03F47F43 		and	r3, r3, #65280
 513 0476 4FEA2323 		asr	r3, r3, #8
 514 047a 9BB2     		uxth	r3, r3
 515 047c 19B2     		sxth	r1, r3
 516 047e 07F12003 		add	r3, r7, #32
 517 0482 A3F11C03 		sub	r3, r3, #28
 518 0486 07F50400 		add	r0, r7, #8650752
 519 048a 00F11C00 		add	r0, r0, #28
 520 048e 0268     		ldr	r2, [r0, #0]
 521 0490 43F82210 		str	r1, [r3, r2, lsl #2]
 113:alpha_time.c  ****         b_bg[index]=B(bgImage[index]);
 522              		.loc 1 113 0 discriminator 2
 523 0494 40F20003 		movw	r3, #:lower16:backImage
 524 0498 C0F20003 		movt	r3, #:upper16:backImage
 525 049c 07F50401 		add	r1, r7, #8650752
 526 04a0 01F11C01 		add	r1, r1, #28
 527 04a4 0A68     		ldr	r2, [r1, #0]
 528 04a6 53F82230 		ldr	r3, [r3, r2, lsl #2]
 529 04aa 9BB2     		uxth	r3, r3
 530 04ac D9B2     		uxtb	r1, r3
 531 04ae 07F58013 		add	r3, r7, #1048576
 532 04b2 03F12003 		add	r3, r3, #32
 533 04b6 A3F11C03 		sub	r3, r3, #28
 534 04ba 07F50400 		add	r0, r7, #8650752
 535 04be 00F11C00 		add	r0, r0, #28
 536 04c2 0268     		ldr	r2, [r0, #0]
 537 04c4 43F82210 		str	r1, [r3, r2, lsl #2]
 110:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 538              		.loc 1 110 0 discriminator 2
 539 04c8 07F50401 		add	r1, r7, #8650752
 540 04cc 01F11C01 		add	r1, r1, #28
 541 04d0 0B68     		ldr	r3, [r1, #0]
 542 04d2 03F10103 		add	r3, r3, #1
 543 04d6 07F50402 		add	r2, r7, #8650752
 544 04da 02F11C02 		add	r2, r2, #28
 545 04de 1360     		str	r3, [r2, #0]
 546              	.L12:
 110:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 547              		.loc 1 110 0 is_stmt 0 discriminator 1
 548 04e0 07F50403 		add	r3, r7, #8650752
 549 04e4 03F11C03 		add	r3, r3, #28
 550 04e8 1A68     		ldr	r2, [r3, #0]
 551 04ea 4FF6FF73 		movw	r3, #65535
 552 04ee C0F20303 		movt	r3, 3
 553 04f2 9A42     		cmp	r2, r3
 554 04f4 96DD     		ble	.L13
 114:alpha_time.c  ****     }
 115:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 555              		.loc 1 115 0 is_stmt 1
 556 04f6 4FF00003 		mov	r3, #0
 557 04fa 07F50400 		add	r0, r7, #8650752
 558 04fe 00F11C00 		add	r0, r0, #28
 559 0502 0360     		str	r3, [r0, #0]
 560 0504 4FE1     		b	.L14
 561              	.L15:
 116:alpha_time.c  ****         dst_r = (r_fg[index] * a_fg[index]);
 562              		.loc 1 116 0 discriminator 2
 563 0506 07F58003 		add	r3, r7, #4194304
 564 050a 03F12003 		add	r3, r3, #32
 565 050e A3F11C03 		sub	r3, r3, #28
 566 0512 07F50401 		add	r1, r7, #8650752
 567 0516 01F11C01 		add	r1, r1, #28
 568 051a 0A68     		ldr	r2, [r1, #0]
 569 051c 9B18     		adds	r3, r3, r2
 570 051e 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 571 0520 1A46     		mov	r2, r3
 572 0522 07F55013 		add	r3, r7, #3407872
 573 0526 03F12003 		add	r3, r3, #32
 574 052a A3F11C03 		sub	r3, r3, #28
 575 052e 07F50400 		add	r0, r7, #8650752
 576 0532 00F11C00 		add	r0, r0, #28
 577 0536 0168     		ldr	r1, [r0, #0]
 578 0538 5B18     		adds	r3, r3, r1
 579 053a 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 580 053c 03FB02F3 		mul	r3, r3, r2
 581 0540 07F50401 		add	r1, r7, #8650752
 582 0544 01F11001 		add	r1, r1, #16
 583 0548 0B60     		str	r3, [r1, #0]
 117:alpha_time.c  ****         dst_r += (r_bg[index] * a_fgM255[index]);
 584              		.loc 1 117 0 discriminator 2
 585 054a 07F12013 		add	r3, r7, #2097184
 586 054e A3F11C03 		sub	r3, r3, #28
 587 0552 07F50400 		add	r0, r7, #8650752
 588 0556 00F11C00 		add	r0, r0, #28
 589 055a 0268     		ldr	r2, [r0, #0]
 590 055c 53F82220 		ldr	r2, [r3, r2, lsl #2]
 591 0560 07F54013 		add	r3, r7, #3145728
 592 0564 03F12003 		add	r3, r3, #32
 593 0568 A3F11C03 		sub	r3, r3, #28
 594 056c 07F50400 		add	r0, r7, #8650752
 595 0570 00F11C00 		add	r0, r0, #28
 596 0574 0168     		ldr	r1, [r0, #0]
 597 0576 5B18     		adds	r3, r3, r1
 598 0578 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 599 057a 03FB02F3 		mul	r3, r3, r2
 600 057e 07F50401 		add	r1, r7, #8650752
 601 0582 01F11001 		add	r1, r1, #16
 602 0586 0A68     		ldr	r2, [r1, #0]
 603 0588 D318     		adds	r3, r2, r3
 604 058a 07F50402 		add	r2, r7, #8650752
 605 058e 02F11002 		add	r2, r2, #16
 606 0592 1360     		str	r3, [r2, #0]
 118:alpha_time.c  ****         dst_r = dst_r/ 256;
 607              		.loc 1 118 0 discriminator 2
 608 0594 07F50400 		add	r0, r7, #8650752
 609 0598 00F11000 		add	r0, r0, #16
 610 059c 0368     		ldr	r3, [r0, #0]
 611 059e 03F1FF02 		add	r2, r3, #255
 612 05a2 002B     		cmp	r3, #0
 613 05a4 B8BF     		it	lt
 614 05a6 1346     		movlt	r3, r2
 615 05a8 4FEA2323 		asr	r3, r3, #8
 616 05ac 07F50401 		add	r1, r7, #8650752
 617 05b0 01F11001 		add	r1, r1, #16
 618 05b4 0B60     		str	r3, [r1, #0]
 119:alpha_time.c  ****         dst_g = (g_fg[index] * a_fg[index]);
 619              		.loc 1 119 0 discriminator 2
 620 05b6 07F56013 		add	r3, r7, #3670016
 621 05ba 03F12003 		add	r3, r3, #32
 622 05be A3F11C03 		sub	r3, r3, #28
 623 05c2 07F50400 		add	r0, r7, #8650752
 624 05c6 00F11C00 		add	r0, r0, #28
 625 05ca 0268     		ldr	r2, [r0, #0]
 626 05cc 9B18     		adds	r3, r3, r2
 627 05ce 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 628 05d0 1A46     		mov	r2, r3
 629 05d2 07F55013 		add	r3, r7, #3407872
 630 05d6 03F12003 		add	r3, r3, #32
 631 05da A3F11C03 		sub	r3, r3, #28
 632 05de 07F50400 		add	r0, r7, #8650752
 633 05e2 00F11C00 		add	r0, r0, #28
 634 05e6 0168     		ldr	r1, [r0, #0]
 635 05e8 5B18     		adds	r3, r3, r1
 636 05ea 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 637 05ec 03FB02F3 		mul	r3, r3, r2
 638 05f0 07F50401 		add	r1, r7, #8650752
 639 05f4 01F10801 		add	r1, r1, #8
 640 05f8 0B60     		str	r3, [r1, #0]
 120:alpha_time.c  ****         dst_g += (g_bg[index] * a_fgM255[index]);
 641              		.loc 1 120 0 discriminator 2
 642 05fa 07F12003 		add	r3, r7, #32
 643 05fe A3F11C03 		sub	r3, r3, #28
 644 0602 07F50400 		add	r0, r7, #8650752
 645 0606 00F11C00 		add	r0, r0, #28
 646 060a 0268     		ldr	r2, [r0, #0]
 647 060c 53F82220 		ldr	r2, [r3, r2, lsl #2]
 648 0610 07F54013 		add	r3, r7, #3145728
 649 0614 03F12003 		add	r3, r3, #32
 650 0618 A3F11C03 		sub	r3, r3, #28
 651 061c 07F50400 		add	r0, r7, #8650752
 652 0620 00F11C00 		add	r0, r0, #28
 653 0624 0168     		ldr	r1, [r0, #0]
 654 0626 5B18     		adds	r3, r3, r1
 655 0628 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 656 062a 03FB02F3 		mul	r3, r3, r2
 657 062e 07F50401 		add	r1, r7, #8650752
 658 0632 01F10801 		add	r1, r1, #8
 659 0636 0A68     		ldr	r2, [r1, #0]
 660 0638 D318     		adds	r3, r2, r3
 661 063a 07F50402 		add	r2, r7, #8650752
 662 063e 02F10802 		add	r2, r2, #8
 663 0642 1360     		str	r3, [r2, #0]
 121:alpha_time.c  ****         dst_g = dst_g / 256;
 664              		.loc 1 121 0 discriminator 2
 665 0644 07F50400 		add	r0, r7, #8650752
 666 0648 00F10800 		add	r0, r0, #8
 667 064c 0368     		ldr	r3, [r0, #0]
 668 064e 03F1FF02 		add	r2, r3, #255
 669 0652 002B     		cmp	r3, #0
 670 0654 B8BF     		it	lt
 671 0656 1346     		movlt	r3, r2
 672 0658 4FEA2323 		asr	r3, r3, #8
 673 065c 07F50401 		add	r1, r7, #8650752
 674 0660 01F10801 		add	r1, r1, #8
 675 0664 0B60     		str	r3, [r1, #0]
 122:alpha_time.c  ****         dst_b = (b_fg[index] * a_fg[index]);
 676              		.loc 1 122 0 discriminator 2
 677 0666 07F57013 		add	r3, r7, #3932160
 678 066a 03F12003 		add	r3, r3, #32
 679 066e A3F11C03 		sub	r3, r3, #28
 680 0672 07F50400 		add	r0, r7, #8650752
 681 0676 00F11C00 		add	r0, r0, #28
 682 067a 0268     		ldr	r2, [r0, #0]
 683 067c 9B18     		adds	r3, r3, r2
 684 067e 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 685 0680 1A46     		mov	r2, r3
 686 0682 07F55013 		add	r3, r7, #3407872
 687 0686 03F12003 		add	r3, r3, #32
 688 068a A3F11C03 		sub	r3, r3, #28
 689 068e 07F50400 		add	r0, r7, #8650752
 690 0692 00F11C00 		add	r0, r0, #28
 691 0696 0168     		ldr	r1, [r0, #0]
 692 0698 5B18     		adds	r3, r3, r1
 693 069a 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 694 069c 03FB02F3 		mul	r3, r3, r2
 695 06a0 07F50401 		add	r1, r7, #8650752
 696 06a4 01F10C01 		add	r1, r1, #12
 697 06a8 0B60     		str	r3, [r1, #0]
 123:alpha_time.c  ****         dst_b += (b_bg[index] * a_fgM255[index]);
 698              		.loc 1 123 0 discriminator 2
 699 06aa 07F58013 		add	r3, r7, #1048576
 700 06ae 03F12003 		add	r3, r3, #32
 701 06b2 A3F11C03 		sub	r3, r3, #28
 702 06b6 07F50400 		add	r0, r7, #8650752
 703 06ba 00F11C00 		add	r0, r0, #28
 704 06be 0268     		ldr	r2, [r0, #0]
 705 06c0 53F82220 		ldr	r2, [r3, r2, lsl #2]
 706 06c4 07F54013 		add	r3, r7, #3145728
 707 06c8 03F12003 		add	r3, r3, #32
 708 06cc A3F11C03 		sub	r3, r3, #28
 709 06d0 07F50400 		add	r0, r7, #8650752
 710 06d4 00F11C00 		add	r0, r0, #28
 711 06d8 0168     		ldr	r1, [r0, #0]
 712 06da 5B18     		adds	r3, r3, r1
 713 06dc 1B78     		ldrb	r3, [r3, #0]	@ zero_extendqisi2
 714 06de 03FB02F3 		mul	r3, r3, r2
 715 06e2 07F50401 		add	r1, r7, #8650752
 716 06e6 01F10C01 		add	r1, r1, #12
 717 06ea 0A68     		ldr	r2, [r1, #0]
 718 06ec D318     		adds	r3, r2, r3
 719 06ee 07F50402 		add	r2, r7, #8650752
 720 06f2 02F10C02 		add	r2, r2, #12
 721 06f6 1360     		str	r3, [r2, #0]
 124:alpha_time.c  ****         dst_b = dst_b / 256;
 722              		.loc 1 124 0 discriminator 2
 723 06f8 07F50400 		add	r0, r7, #8650752
 724 06fc 00F10C00 		add	r0, r0, #12
 725 0700 0368     		ldr	r3, [r0, #0]
 726 0702 03F1FF02 		add	r2, r3, #255
 727 0706 002B     		cmp	r3, #0
 728 0708 B8BF     		it	lt
 729 070a 1346     		movlt	r3, r2
 730 070c 4FEA2323 		asr	r3, r3, #8
 731 0710 07F50401 		add	r1, r7, #8650752
 732 0714 01F10C01 		add	r1, r1, #12
 733 0718 0B60     		str	r3, [r1, #0]
 125:alpha_time.c  ****         dst_rf[index] = dst_r << 16;
 734              		.loc 1 125 0 discriminator 2
 735 071a 07F50402 		add	r2, r7, #8650752
 736 071e 02F11002 		add	r2, r2, #16
 737 0722 1368     		ldr	r3, [r2, #0]
 738 0724 4FEA0341 		lsl	r1, r3, #16
 739 0728 07F5E803 		add	r3, r7, #7602176
 740 072c 03F12003 		add	r3, r3, #32
 741 0730 A3F11C03 		sub	r3, r3, #28
 742 0734 07F50400 		add	r0, r7, #8650752
 743 0738 00F11C00 		add	r0, r0, #28
 744 073c 0268     		ldr	r2, [r0, #0]
 745 073e 43F82210 		str	r1, [r3, r2, lsl #2]
 126:alpha_time.c  ****         dst_gf[index] = dst_g << 8;
 746              		.loc 1 126 0 discriminator 2
 747 0742 07F50401 		add	r1, r7, #8650752
 748 0746 01F10801 		add	r1, r1, #8
 749 074a 0B68     		ldr	r3, [r1, #0]
 750 074c 4FEA0321 		lsl	r1, r3, #8
 751 0750 07F5A803 		add	r3, r7, #5505024
 752 0754 03F12003 		add	r3, r3, #32
 753 0758 A3F11C03 		sub	r3, r3, #28
 754 075c 07F50400 		add	r0, r7, #8650752
 755 0760 00F11C00 		add	r0, r0, #28
 756 0764 0268     		ldr	r2, [r0, #0]
 757 0766 43F82210 		str	r1, [r3, r2, lsl #2]
 127:alpha_time.c  ****         dst_bf[index] = dst_b; 
 758              		.loc 1 127 0 discriminator 2
 759 076a 07F5C803 		add	r3, r7, #6553600
 760 076e 03F12003 		add	r3, r3, #32
 761 0772 A3F11C03 		sub	r3, r3, #28
 762 0776 07F50401 		add	r1, r7, #8650752
 763 077a 01F11C01 		add	r1, r1, #28
 764 077e 0A68     		ldr	r2, [r1, #0]
 765 0780 07F50400 		add	r0, r7, #8650752
 766 0784 00F10C00 		add	r0, r0, #12
 767 0788 0168     		ldr	r1, [r0, #0]
 768 078a 43F82210 		str	r1, [r3, r2, lsl #2]
 115:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 769              		.loc 1 115 0 discriminator 2
 770 078e 07F50401 		add	r1, r7, #8650752
 771 0792 01F11C01 		add	r1, r1, #28
 772 0796 0B68     		ldr	r3, [r1, #0]
 773 0798 03F10103 		add	r3, r3, #1
 774 079c 07F50402 		add	r2, r7, #8650752
 775 07a0 02F11C02 		add	r2, r2, #28
 776 07a4 1360     		str	r3, [r2, #0]
 777              	.L14:
 115:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 778              		.loc 1 115 0 is_stmt 0 discriminator 1
 779 07a6 07F50403 		add	r3, r7, #8650752
 780 07aa 03F11C03 		add	r3, r3, #28
 781 07ae 1A68     		ldr	r2, [r3, #0]
 782 07b0 4FF6FF73 		movw	r3, #65535
 783 07b4 C0F20303 		movt	r3, 3
 784 07b8 9A42     		cmp	r2, r3
 785 07ba 7FF7A4AE 		ble	.L15
 128:alpha_time.c  ****     }
 129:alpha_time.c  **** 
 130:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 786              		.loc 1 130 0 is_stmt 1
 787 07be 4FF00003 		mov	r3, #0
 788 07c2 07F50400 		add	r0, r7, #8650752
 789 07c6 00F11C00 		add	r0, r0, #28
 790 07ca 0360     		str	r3, [r0, #0]
 791 07cc AAE0     		b	.L16
 792              	.L17:
 131:alpha_time.c  ****         dstImage[index] =  0xff000000;
 793              		.loc 1 131 0 discriminator 2
 794 07ce 40F20003 		movw	r3, #:lower16:newImage
 795 07d2 C0F20003 		movt	r3, #:upper16:newImage
 796 07d6 07F50401 		add	r1, r7, #8650752
 797 07da 01F11C01 		add	r1, r1, #28
 798 07de 0A68     		ldr	r2, [r1, #0]
 799 07e0 4FF07F41 		mov	r1, #-16777216
 800 07e4 43F82210 		str	r1, [r3, r2, lsl #2]
 132:alpha_time.c  ****         temp =  (0x00ff0000 & dst_rf[index]);
 801              		.loc 1 132 0 discriminator 2
 802 07e8 07F5E803 		add	r3, r7, #7602176
 803 07ec 03F12003 		add	r3, r3, #32
 804 07f0 A3F11C03 		sub	r3, r3, #28
 805 07f4 07F50400 		add	r0, r7, #8650752
 806 07f8 00F11C00 		add	r0, r0, #28
 807 07fc 0268     		ldr	r2, [r0, #0]
 808 07fe 53F82230 		ldr	r3, [r3, r2, lsl #2]
 809 0802 03F47F03 		and	r3, r3, #16711680
 810 0806 07F50401 		add	r1, r7, #8650752
 811 080a 01F10401 		add	r1, r1, #4
 812 080e 0B60     		str	r3, [r1, #0]
 133:alpha_time.c  ****         dstImage[index] |= temp;
 813              		.loc 1 133 0 discriminator 2
 814 0810 40F20003 		movw	r3, #:lower16:newImage
 815 0814 C0F20003 		movt	r3, #:upper16:newImage
 816 0818 07F50400 		add	r0, r7, #8650752
 817 081c 00F11C00 		add	r0, r0, #28
 818 0820 0268     		ldr	r2, [r0, #0]
 819 0822 53F82220 		ldr	r2, [r3, r2, lsl #2]
 820 0826 07F50401 		add	r1, r7, #8650752
 821 082a 01F10401 		add	r1, r1, #4
 822 082e 0B68     		ldr	r3, [r1, #0]
 823 0830 42EA0301 		orr	r1, r2, r3
 824 0834 40F20003 		movw	r3, #:lower16:newImage
 825 0838 C0F20003 		movt	r3, #:upper16:newImage
 826 083c 07F50400 		add	r0, r7, #8650752
 827 0840 00F11C00 		add	r0, r0, #28
 828 0844 0268     		ldr	r2, [r0, #0]
 829 0846 43F82210 		str	r1, [r3, r2, lsl #2]
 134:alpha_time.c  ****         temp =  (0x0000ff00 & dst_gf[index]);
 830              		.loc 1 134 0 discriminator 2
 831 084a 07F5A803 		add	r3, r7, #5505024
 832 084e 03F12003 		add	r3, r3, #32
 833 0852 A3F11C03 		sub	r3, r3, #28
 834 0856 07F50401 		add	r1, r7, #8650752
 835 085a 01F11C01 		add	r1, r1, #28
 836 085e 0A68     		ldr	r2, [r1, #0]
 837 0860 53F82230 		ldr	r3, [r3, r2, lsl #2]
 838 0864 03F47F43 		and	r3, r3, #65280
 839 0868 07F50402 		add	r2, r7, #8650752
 840 086c 02F10402 		add	r2, r2, #4
 841 0870 1360     		str	r3, [r2, #0]
 135:alpha_time.c  ****         dstImage[index] |= temp;
 842              		.loc 1 135 0 discriminator 2
 843 0872 40F20003 		movw	r3, #:lower16:newImage
 844 0876 C0F20003 		movt	r3, #:upper16:newImage
 845 087a 07F50400 		add	r0, r7, #8650752
 846 087e 00F11C00 		add	r0, r0, #28
 847 0882 0268     		ldr	r2, [r0, #0]
 848 0884 53F82220 		ldr	r2, [r3, r2, lsl #2]
 849 0888 07F50401 		add	r1, r7, #8650752
 850 088c 01F10401 		add	r1, r1, #4
 851 0890 0B68     		ldr	r3, [r1, #0]
 852 0892 42EA0301 		orr	r1, r2, r3
 853 0896 40F20003 		movw	r3, #:lower16:newImage
 854 089a C0F20003 		movt	r3, #:upper16:newImage
 855 089e 07F50400 		add	r0, r7, #8650752
 856 08a2 00F11C00 		add	r0, r0, #28
 857 08a6 0268     		ldr	r2, [r0, #0]
 858 08a8 43F82210 		str	r1, [r3, r2, lsl #2]
 136:alpha_time.c  ****         temp =  (0x000000ff & dst_bf[index]);
 859              		.loc 1 136 0 discriminator 2
 860 08ac 07F5C803 		add	r3, r7, #6553600
 861 08b0 03F12003 		add	r3, r3, #32
 862 08b4 A3F11C03 		sub	r3, r3, #28
 863 08b8 07F50401 		add	r1, r7, #8650752
 864 08bc 01F11C01 		add	r1, r1, #28
 865 08c0 0A68     		ldr	r2, [r1, #0]
 866 08c2 53F82230 		ldr	r3, [r3, r2, lsl #2]
 867 08c6 DBB2     		uxtb	r3, r3
 868 08c8 07F50402 		add	r2, r7, #8650752
 869 08cc 02F10402 		add	r2, r2, #4
 870 08d0 1360     		str	r3, [r2, #0]
 137:alpha_time.c  ****         dstImage[index] |= temp;
 871              		.loc 1 137 0 discriminator 2
 872 08d2 40F20003 		movw	r3, #:lower16:newImage
 873 08d6 C0F20003 		movt	r3, #:upper16:newImage
 874 08da 07F50400 		add	r0, r7, #8650752
 875 08de 00F11C00 		add	r0, r0, #28
 876 08e2 0268     		ldr	r2, [r0, #0]
 877 08e4 53F82220 		ldr	r2, [r3, r2, lsl #2]
 878 08e8 07F50401 		add	r1, r7, #8650752
 879 08ec 01F10401 		add	r1, r1, #4
 880 08f0 0B68     		ldr	r3, [r1, #0]
 881 08f2 42EA0301 		orr	r1, r2, r3
 882 08f6 40F20003 		movw	r3, #:lower16:newImage
 883 08fa C0F20003 		movt	r3, #:upper16:newImage
 884 08fe 07F50400 		add	r0, r7, #8650752
 885 0902 00F11C00 		add	r0, r0, #28
 886 0906 0268     		ldr	r2, [r0, #0]
 887 0908 43F82210 		str	r1, [r3, r2, lsl #2]
 130:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 888              		.loc 1 130 0 discriminator 2
 889 090c 07F50401 		add	r1, r7, #8650752
 890 0910 01F11C01 		add	r1, r1, #28
 891 0914 0B68     		ldr	r3, [r1, #0]
 892 0916 03F10103 		add	r3, r3, #1
 893 091a 07F50402 		add	r2, r7, #8650752
 894 091e 02F11C02 		add	r2, r2, #28
 895 0922 1360     		str	r3, [r2, #0]
 896              	.L16:
 130:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 897              		.loc 1 130 0 is_stmt 0 discriminator 1
 898 0924 07F50403 		add	r3, r7, #8650752
 899 0928 03F11C03 		add	r3, r3, #28
 900 092c 1A68     		ldr	r2, [r3, #0]
 901 092e 4FF6FF73 		movw	r3, #65535
 902 0932 C0F20303 		movt	r3, 3
 903 0936 9A42     		cmp	r2, r3
 904 0938 7FF749AF 		ble	.L17
 138:alpha_time.c  ****     }
 139:alpha_time.c  **** }
 905              		.loc 1 139 0 is_stmt 1
 906 093c 07F12407 		add	r7, r7, #36
 907 0940 07F50407 		add	r7, r7, #8650752
 908 0944 BD46     		mov	sp, r7
 909 0946 80BC     		pop	{r7}
 910 0948 7047     		bx	lr
 911              		.cfi_endproc
 912              	.LFE1:
 914              	.Letext0:
 915              		.file 2 "/usr/lib/gcc/arm-linux-gnueabihf/4.6/include/stddef.h"
 916              		.file 3 "/usr/include/arm-linux-gnueabihf/bits/types.h"
 917              		.file 4 "/usr/include/stdio.h"
 918              		.file 5 "/usr/include/libio.h"
 919              		.file 6 "/usr/include/arm-linux-gnueabihf/bits/time.h"
 920              		.file 7 "/usr/include/time.h"
