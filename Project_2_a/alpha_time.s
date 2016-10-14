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
  16              		.file	"alpha_time.c"
  17              		.text
  18              	.Ltext0:
  19              		.cfi_sections	.debug_frame
  20              		.comm	backImage,1048576,4
  21              		.comm	foreImage,1048576,4
  22              		.comm	newImage,1048576,4
  23              		.align	2
  24              		.global	alphaBlend_c
  25              		.thumb
  26              		.thumb_func
  28              	alphaBlend_c:
  29              	.LFB0:
  30              		.file 1 "alpha_time.c"
   1:alpha_time.c  **** #include <stdio.h>
   2:alpha_time.c  **** #include <sys/time.h>
   3:alpha_time.c  **** int backImage[512 * 512];
   4:alpha_time.c  **** int foreImage[512 * 512];
   5:alpha_time.c  **** int newImage[512 * 512];
   6:alpha_time.c  **** #define A(x) (((x) & 0xff000000) >> 24)
   7:alpha_time.c  **** #define R(x) (((x) & 0x00ff0000) >> 16)
   8:alpha_time.c  **** #define G(x) (((x) & 0x0000ff00) >> 8)
   9:alpha_time.c  **** #define B(x) ((x) & 0x000000ff)
  10:alpha_time.c  **** 
  11:alpha_time.c  **** #if macro == 10
  12:alpha_time.c  **** void alphaBlend_c(unsigned char *__restrict fgImage,unsigned char *__restrict bgImage,unsigned char
  13:alpha_time.c  **** {
  14:alpha_time.c  ****     int index;
  15:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
  16:alpha_time.c  ****     int temp1,temp2;
  17:alpha_time.c  ****     printf("2");
  18:alpha_time.c  **** #pragma vector aligned
  19:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
  20:alpha_time.c  ****         dstImage[index] =  0xff;
  21:alpha_time.c  ****         a_fg = fgImage[index];
  22:alpha_time.c  ****         temp1 = (fgImage[index+1] * a_fg);
  23:alpha_time.c  ****         temp2 = (bgImage[index+1] * (255-a_fg));
  24:alpha_time.c  ****         dst_r = ( temp1 + temp2 )>>8;
  25:alpha_time.c  ****         dstImage[index+1] =  (0x000000ff & dst_r);
  26:alpha_time.c  ****         temp1 = (fgImage[index+2] * a_fg);
  27:alpha_time.c  ****         temp2 = (bgImage[index+2] * (255-a_fg));
  28:alpha_time.c  ****         dst_g = ( temp1 + temp2 )>>8;
  29:alpha_time.c  ****         dstImage[index+2] =  (0x000000ff & dst_g);
  30:alpha_time.c  ****         temp1 = (fgImage[index+3] * a_fg);
  31:alpha_time.c  ****         temp2 = (bgImage[index+3] * (255-a_fg));
  32:alpha_time.c  ****         dst_b = ( temp1 + temp2 )>>8;
  33:alpha_time.c  ****         dstImage[index+3] =  (0x000000ff & dst_b);
  34:alpha_time.c  ****     }
  35:alpha_time.c  **** }
  36:alpha_time.c  **** #endif
  37:alpha_time.c  **** #if macro == 9
  38:alpha_time.c  **** void alphaBlend_c(unsigned char *__restrict fgImage,unsigned char *__restrict bgImage,unsigned char
  39:alpha_time.c  **** {
  40:alpha_time.c  ****     int index;
  41:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
  42:alpha_time.c  ****     int temp;
  43:alpha_time.c  ****     printf("2");
  44:alpha_time.c  **** #pragma vector aligned
  45:alpha_time.c  **** 
  46:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
  47:alpha_time.c  ****         a_fg = fgImage[index];
  48:alpha_time.c  ****         dst_r = ((fgImage[index+1] * a_fg) + (bgImage[index+1] * (255-a_fg)))>>8;
  49:alpha_time.c  ****         dst_g = ((fgImage[index+2] * a_fg) + (bgImage[index+2] * (255-a_fg)))>>8;
  50:alpha_time.c  ****         dst_b = ((fgImage[index+3] * a_fg) + (bgImage[index+3] * (255-a_fg)))>>8;
  51:alpha_time.c  ****         dstImage[index] =  0xff;
  52:alpha_time.c  ****         dstImage[index+1] =  (0x000000ff & dst_r);
  53:alpha_time.c  ****         dstImage[index+2] =  (0x000000ff & dst_g);
  54:alpha_time.c  ****         dstImage[index+3] =  (0x000000ff & dst_b);
  55:alpha_time.c  ****     }
  56:alpha_time.c  **** }
  57:alpha_time.c  **** #endif
  58:alpha_time.c  **** #if macro == 8
  59:alpha_time.c  **** void alphaBlend_c(int *__restrict fgImage, int *__restrict bgImage, int *__restrict dstImage)
  60:alpha_time.c  **** {
  61:alpha_time.c  ****     int index;
  62:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
  63:alpha_time.c  ****     printf("2");
  64:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
  65:alpha_time.c  ****         a_fg = A(fgImage[index]);
  66:alpha_time.c  ****         dst_r = ((R(fgImage[index]) * a_fg) + (R(bgImage[index]) * (255-a_fg)))>>8;
  67:alpha_time.c  ****         dst_g = ((G(fgImage[index]) * a_fg) + (G(bgImage[index]) * (255-a_fg)))>>8;
  68:alpha_time.c  ****         dst_b = ((B(fgImage[index]) * a_fg) + (B(bgImage[index]) * (255-a_fg)))>>8;
  69:alpha_time.c  ****         dstImage[index] =  0xff000000 |
  70:alpha_time.c  ****             (0x00ff0000 & (dst_r << 16)) |
  71:alpha_time.c  ****             (0x0000ff00 & (dst_g << 8)) |
  72:alpha_time.c  ****             (0x000000ff & (dst_b));
  73:alpha_time.c  ****     }
  74:alpha_time.c  **** }
  75:alpha_time.c  **** 
  76:alpha_time.c  **** #endif
  77:alpha_time.c  **** #if macro == 7
  78:alpha_time.c  **** void alphaBlend_c(void)
  79:alpha_time.c  **** {
  80:alpha_time.c  ****     int y;
  81:alpha_time.c  ****     short f_a[512*512];
  82:alpha_time.c  ****     short f_r[512*512];
  83:alpha_time.c  ****     short f_g[512*512];
  84:alpha_time.c  ****     short f_b[512*512];
  85:alpha_time.c  ****     short b_r[512*512];
  86:alpha_time.c  ****     short b_g[512*512];
  87:alpha_time.c  ****     short b_b[512*512];
  88:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
  89:alpha_time.c  ****         f_a[y] = A(foreImage[y]);
  90:alpha_time.c  ****     }
  91:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
  92:alpha_time.c  ****         f_r[y] = R(foreImage[y]);
  93:alpha_time.c  ****     }
  94:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
  95:alpha_time.c  ****         f_g[y] = G(foreImage[y]);
  96:alpha_time.c  ****     }
  97:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
  98:alpha_time.c  ****         f_b[y] = B(foreImage[y]);
  99:alpha_time.c  ****     }
 100:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
 101:alpha_time.c  ****         b_r[y] = R(backImage[y]);
 102:alpha_time.c  ****         b_g[y] = G(backImage[y]);
 103:alpha_time.c  ****         b_b[y] = B(backImage[y]);
 104:alpha_time.c  ****     }
 105:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
 106:alpha_time.c  ****         newImage[y] = 0xff000000;
 107:alpha_time.c  ****     }
 108:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
 109:alpha_time.c  ****         newImage[y] |= ((f_a[y]*(f_r[y]-b_r[y])+b_r[y]*255)/256)>>16;
 110:alpha_time.c  ****         newImage[y] |= ((f_a[y]*(f_g[y]-b_g[y])+b_g[y]*255)/256)>>8;
 111:alpha_time.c  ****         newImage[y] |= ((f_a[y]*(f_b[y]-b_b[y])+b_b[y]*255)/256);
 112:alpha_time.c  ****     }
 113:alpha_time.c  **** /*
 114:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
 115:alpha_time.c  ****         dst_r[y] = ((R(foreImage[y]) * a_fg[y]) + (R(backImage[y]) * (255-a_fg[y])))/256;
 116:alpha_time.c  ****     }
 117:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
 118:alpha_time.c  ****         dst_g[y] = ((G(foreImage[y]) * a_fg[y]) + (R(backImage[y]) * (255-a_fg[y])))/256;
 119:alpha_time.c  ****     }
 120:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
 121:alpha_time.c  ****         dst_b[y] = ((B(foreImage[y]) * a_fg[y]) + (R(backImage[y]) * (255-a_fg[y])))/256;
 122:alpha_time.c  ****     }
 123:alpha_time.c  ****     for(y = 0; y < 512*512; y++){
 124:alpha_time.c  ****         dstImage[y] =  0xff000000 |
 125:alpha_time.c  ****             (0x00ff0000 & (dst_r[y] << 16)) |
 126:alpha_time.c  ****             (0x0000ff00 & (dst_g[y] << 8)) |
 127:alpha_time.c  ****             (0x000000ff & (dst_b[y]));
 128:alpha_time.c  ****     }*/
 129:alpha_time.c  **** }
 130:alpha_time.c  **** #endif
 131:alpha_time.c  **** 
 132:alpha_time.c  **** #if macro == 6
 133:alpha_time.c  **** void alphaBlend_c(void)
 134:alpha_time.c  **** {
 135:alpha_time.c  ****     int index;
 136:alpha_time.c  ****     int dst_r,dst_g,dst_b; 
 137:alpha_time.c  ****     int r_fg,g_fg,b_fg,r_bg,g_bg,b_bg;
 138:alpha_time.c  ****     int a_fg[512*512];
 139:alpha_time.c  ****     printf("4");
 140:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 141:alpha_time.c  ****         a_fg[index] = ((unsigned char *)(&foreImage[index]))[0];
 142:alpha_time.c  ****         r_fg = ((unsigned char *)(&foreImage[index]))[1];
 143:alpha_time.c  ****         r_bg = ((unsigned char *)(&backImage[index]))[0];
 144:alpha_time.c  ****         dst_r = ((r_fg * a_fg[index]) + (r_bg * (255-a_fg[index])))/256;
 145:alpha_time.c  ****         newImage[index] =  0xff000000 | (0x00ff0000 & (dst_r << 16));
 146:alpha_time.c  ****     }
 147:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 148:alpha_time.c  ****         g_fg = ((unsigned char *)(&foreImage[index]))[2];
 149:alpha_time.c  ****         g_bg = ((unsigned char *)(&backImage[index]))[1];
 150:alpha_time.c  ****         dst_g = ((g_fg * a_fg[index]) + (g_bg * (255-a_fg[index])))/256;
 151:alpha_time.c  ****         newImage[index] |= (0x0000ff00 & (dst_g << 8));
 152:alpha_time.c  ****     }
 153:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 154:alpha_time.c  ****         b_fg = ((unsigned char *)(&foreImage[index]))[3];
 155:alpha_time.c  ****         b_bg = ((unsigned char *)(&backImage[index]))[2];
 156:alpha_time.c  ****         dst_b = ((b_fg * a_fg[index]) + (b_bg * (255-a_fg[index])))/256;
 157:alpha_time.c  ****         newImage[index] |= (0x000000ff & (dst_b));
 158:alpha_time.c  ****     }
 159:alpha_time.c  **** }
 160:alpha_time.c  **** #endif
 161:alpha_time.c  **** #if macro == 5
 162:alpha_time.c  **** void alphaBlend_c(void)
 163:alpha_time.c  **** {
 164:alpha_time.c  ****     int index;
 165:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
 166:alpha_time.c  ****     int r_fg,g_fg,b_fg,r_bg,g_bg,b_bg;
 167:alpha_time.c  ****     printf("4");
 168:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 169:alpha_time.c  ****         a_fg = ((unsigned char *)(&foreImage[index]))[0];
 170:alpha_time.c  ****         r_fg = ((unsigned char *)(&foreImage[index]))[1];
 171:alpha_time.c  ****         g_fg = ((unsigned char *)(&foreImage[index]))[2];
 172:alpha_time.c  ****         b_fg = ((unsigned char *)(&foreImage[index]))[3];
 173:alpha_time.c  ****         r_bg = ((unsigned char *)(&backImage[index]))[0];
 174:alpha_time.c  ****         g_bg = ((unsigned char *)(&backImage[index]))[1];
 175:alpha_time.c  ****         b_bg = ((unsigned char *)(&backImage[index]))[2];
 176:alpha_time.c  ****         dst_r = ((r_fg * a_fg) + (r_bg * (255-a_fg)))/256;
 177:alpha_time.c  ****         dst_g = ((g_fg * a_fg) + (g_bg * (255-a_fg)))/256;
 178:alpha_time.c  ****         dst_b = ((b_fg * a_fg) + (b_bg * (255-a_fg)))/256;
 179:alpha_time.c  ****         newImage[index] =  0xff000000 |
 180:alpha_time.c  ****             (0x00ff0000 & (dst_r << 16)) |
 181:alpha_time.c  ****             (0x0000ff00 & (dst_g << 8)) |
 182:alpha_time.c  ****             (0x000000ff & (dst_b));
 183:alpha_time.c  ****     }
 184:alpha_time.c  **** }
 185:alpha_time.c  **** #endif
 186:alpha_time.c  **** #if macro == 4
 187:alpha_time.c  **** void alphaBlend_c(void)
 188:alpha_time.c  **** {
 189:alpha_time.c  ****     int index;
 190:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
 191:alpha_time.c  ****     int r_fg,g_fg,b_fg,r_bg,g_bg,b_bg;
 192:alpha_time.c  ****     printf("4");
 193:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 194:alpha_time.c  ****         a_fg = A(foreImage[index]);
 195:alpha_time.c  ****         r_fg = R(foreImage[index]);
 196:alpha_time.c  ****         b_fg = G(foreImage[index]);
 197:alpha_time.c  ****         g_fg = B(foreImage[index]);
 198:alpha_time.c  ****         r_bg = R(backImage[index]);
 199:alpha_time.c  ****         b_bg = G(backImage[index]);
 200:alpha_time.c  ****         g_bg = B(backImage[index]);
 201:alpha_time.c  ****         dst_r = ((r_fg * a_fg) + (r_bg * (255-a_fg)))/256;
 202:alpha_time.c  ****         dst_g = ((g_fg * a_fg) + (g_bg * (255-a_fg)))/256;
 203:alpha_time.c  ****         dst_b = ((b_fg * a_fg) + (b_bg * (255-a_fg)))/256;
 204:alpha_time.c  ****         newImage[index] =  0xff000000 |
 205:alpha_time.c  ****             (0x00ff0000 & (dst_r << 16)) |
 206:alpha_time.c  ****             (0x0000ff00 & (dst_g << 8)) |
 207:alpha_time.c  ****             (0x000000ff & (dst_b));
 208:alpha_time.c  ****     }
 209:alpha_time.c  **** }
 210:alpha_time.c  **** #endif
 211:alpha_time.c  **** #if macro == 3
 212:alpha_time.c  **** void alphaBlend_c(void)
 213:alpha_time.c  **** {
 214:alpha_time.c  ****     int index;
 215:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
 216:alpha_time.c  ****     printf("3");
 217:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 218:alpha_time.c  ****         a_fg = A(foreImage[index]);
 219:alpha_time.c  ****         dst_r = ((R(foreImage[index]) * a_fg) + (R(backImage[index]) * (255-a_fg)))/256;
 220:alpha_time.c  ****         dst_g = ((G(foreImage[index]) * a_fg) + (G(backImage[index]) * (255-a_fg)))/256;
 221:alpha_time.c  ****         dst_b = ((B(foreImage[index]) * a_fg) + (B(backImage[index]) * (255-a_fg)))/256;
 222:alpha_time.c  ****         newImage[index] =  0xff000000 |
 223:alpha_time.c  ****             (0x00ff0000 & (dst_r << 16)) |
 224:alpha_time.c  ****             (0x0000ff00 & (dst_g << 8)) |
 225:alpha_time.c  ****             (0x000000ff & (dst_b));
 226:alpha_time.c  ****     }
 227:alpha_time.c  **** }
 228:alpha_time.c  **** #endif
 229:alpha_time.c  **** #if macro == 2
 230:alpha_time.c  **** void alphaBlend_c(int *__restrict fgImage, int *__restrict bgImage, int *__restrict dstImage)
 231:alpha_time.c  **** {
 232:alpha_time.c  ****     int index;
 233:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
 234:alpha_time.c  ****     printf("2");
 235:alpha_time.c  ****     for(index = 0; index < 512*512; index++){
 236:alpha_time.c  ****         a_fg = A(fgImage[index]);
 237:alpha_time.c  ****         dst_r = ((R(fgImage[index]) * a_fg) + (R(bgImage[index]) * (255-a_fg)))/256;
 238:alpha_time.c  ****         dst_g = ((G(fgImage[index]) * a_fg) + (G(bgImage[index]) * (255-a_fg)))/256;
 239:alpha_time.c  ****         dst_b = ((B(fgImage[index]) * a_fg) + (B(bgImage[index]) * (255-a_fg)))/256;
 240:alpha_time.c  ****         dstImage[index] =  0xff000000 |
 241:alpha_time.c  ****             (0x00ff0000 & (dst_r << 16)) |
 242:alpha_time.c  ****             (0x0000ff00 & (dst_g << 8)) |
 243:alpha_time.c  ****             (0x000000ff & (dst_b));
 244:alpha_time.c  ****     }
 245:alpha_time.c  **** }
 246:alpha_time.c  **** #endif
 247:alpha_time.c  **** #if macro == 1
 248:alpha_time.c  **** void alphaBlend_c(int *__restrict fgImage, int *__restrict bgImage, int *__restrict dstImage)
 249:alpha_time.c  **** {
 250:alpha_time.c  ****     int x, y;
 251:alpha_time.c  ****     int a_fg,dst_r,dst_g,dst_b; 
 252:alpha_time.c  ****     printf("1");
 253:alpha_time.c  ****     for(y = 0; y < 512; y++){
 254:alpha_time.c  ****         for(x = 0; x < 512; x++){
 255:alpha_time.c  ****             a_fg = A(fgImage[(y*512)+x]);
 256:alpha_time.c  ****             dst_r = ((R(fgImage[(y*512)+x]) * a_fg) + (R(bgImage[(y*512)+x]) * (255-a_fg)))/256;
 257:alpha_time.c  ****             dst_g = ((G(fgImage[(y*512)+x]) * a_fg) + (G(bgImage[(y*512)+x]) * (255-a_fg)))/256;
 258:alpha_time.c  ****             dst_b = ((B(fgImage[(y*512)+x]) * a_fg) + (B(bgImage[(y*512)+x]) * (255-a_fg)))/256;
 259:alpha_time.c  ****             dstImage[(y*512)+x] =  0xff000000 |
 260:alpha_time.c  ****                 (0x00ff0000 & (dst_r << 16)) |
 261:alpha_time.c  ****                 (0x0000ff00 & (dst_g << 8)) |
 262:alpha_time.c  ****                 (0x000000ff & (dst_b));
 263:alpha_time.c  ****         }
 264:alpha_time.c  ****     }
 265:alpha_time.c  **** }
 266:alpha_time.c  **** #endif
 267:alpha_time.c  **** #if macro == 0
 268:alpha_time.c  **** void alphaBlend_c(int *fgImage, int *bgImage, int *dstImage)
 269:alpha_time.c  **** {
  31              		.loc 1 269 0
  32              		.cfi_startproc
  33              		@ args = 0, pretend = 0, frame = 40
  34              		@ frame_needed = 1, uses_anonymous_args = 0
  35 0000 80B5     		push	{r7, lr}
  36              		.cfi_def_cfa_offset 8
  37              		.cfi_offset 7, -8
  38              		.cfi_offset 14, -4
  39 0002 8AB0     		sub	sp, sp, #40
  40              		.cfi_def_cfa_offset 48
  41 0004 00AF     		add	r7, sp, #0
  42              		.cfi_def_cfa_register 7
  43 0006 F860     		str	r0, [r7, #12]
  44 0008 B960     		str	r1, [r7, #8]
  45 000a 7A60     		str	r2, [r7, #4]
 270:alpha_time.c  ****     int x, y;
 271:alpha_time.c  ****     printf("0");
  46              		.loc 1 271 0
  47 000c 3020     		movs	r0, #48
  48 000e FFF7FEFF 		bl	putchar
 272:alpha_time.c  ****     for(y = 0; y < 512; y++){
  49              		.loc 1 272 0
  50 0012 0023     		movs	r3, #0
  51 0014 3B62     		str	r3, [r7, #32]
  52 0016 9DE0     		b	.L2
  53              	.L5:
 273:alpha_time.c  ****         for(x = 0; x < 512; x++){
  54              		.loc 1 273 0
  55 0018 0023     		movs	r3, #0
  56 001a 7B62     		str	r3, [r7, #36]
  57 001c 92E0     		b	.L3
  58              	.L4:
  59              	.LBB2:
 274:alpha_time.c  ****             int a_fg = A(fgImage[(y*512)+x]);
  60              		.loc 1 274 0 discriminator 3
  61 001e 3B6A     		ldr	r3, [r7, #32]
  62 0020 5A02     		lsls	r2, r3, #9
  63 0022 7B6A     		ldr	r3, [r7, #36]
  64 0024 1344     		add	r3, r3, r2
  65 0026 9B00     		lsls	r3, r3, #2
  66 0028 FA68     		ldr	r2, [r7, #12]
  67 002a 1344     		add	r3, r3, r2
  68 002c 1B68     		ldr	r3, [r3]
  69 002e 1B0E     		lsrs	r3, r3, #24
  70 0030 FB61     		str	r3, [r7, #28]
 275:alpha_time.c  ****             int dst_r = ((R(fgImage[(y*512)+x]) * a_fg) + (R(bgImage[(y*512)+x]) * (255-a_fg)))/256
  71              		.loc 1 275 0 discriminator 3
  72 0032 3B6A     		ldr	r3, [r7, #32]
  73 0034 5A02     		lsls	r2, r3, #9
  74 0036 7B6A     		ldr	r3, [r7, #36]
  75 0038 1344     		add	r3, r3, r2
  76 003a 9B00     		lsls	r3, r3, #2
  77 003c FA68     		ldr	r2, [r7, #12]
  78 003e 1344     		add	r3, r3, r2
  79 0040 1B68     		ldr	r3, [r3]
  80 0042 03F47F03 		and	r3, r3, #16711680
  81 0046 1B14     		asrs	r3, r3, #16
  82 0048 FA69     		ldr	r2, [r7, #28]
  83 004a 02FB03F2 		mul	r2, r2, r3
  84 004e 3B6A     		ldr	r3, [r7, #32]
  85 0050 5902     		lsls	r1, r3, #9
  86 0052 7B6A     		ldr	r3, [r7, #36]
  87 0054 0B44     		add	r3, r3, r1
  88 0056 9B00     		lsls	r3, r3, #2
  89 0058 B968     		ldr	r1, [r7, #8]
  90 005a 0B44     		add	r3, r3, r1
  91 005c 1B68     		ldr	r3, [r3]
  92 005e 03F47F03 		and	r3, r3, #16711680
  93 0062 1B14     		asrs	r3, r3, #16
  94 0064 F969     		ldr	r1, [r7, #28]
  95 0066 C1F1FF01 		rsb	r1, r1, #255
  96 006a 01FB03F3 		mul	r3, r1, r3
  97 006e 1344     		add	r3, r3, r2
  98 0070 03F1FF02 		add	r2, r3, #255
  99 0074 002B     		cmp	r3, #0
 100 0076 B4BF     		ite	lt
 101 0078 1346     		movlt	r3, r2
 102 007a 1B46     		movge	r3, r3
 103 007c 1B12     		asrs	r3, r3, #8
 104 007e BB61     		str	r3, [r7, #24]
 276:alpha_time.c  ****             int dst_g = ((G(fgImage[(y*512)+x]) * a_fg) + (G(bgImage[(y*512)+x]) * (255-a_fg)))/256
 105              		.loc 1 276 0 discriminator 3
 106 0080 3B6A     		ldr	r3, [r7, #32]
 107 0082 5A02     		lsls	r2, r3, #9
 108 0084 7B6A     		ldr	r3, [r7, #36]
 109 0086 1344     		add	r3, r3, r2
 110 0088 9B00     		lsls	r3, r3, #2
 111 008a FA68     		ldr	r2, [r7, #12]
 112 008c 1344     		add	r3, r3, r2
 113 008e 1B68     		ldr	r3, [r3]
 114 0090 03F47F43 		and	r3, r3, #65280
 115 0094 1B12     		asrs	r3, r3, #8
 116 0096 FA69     		ldr	r2, [r7, #28]
 117 0098 02FB03F2 		mul	r2, r2, r3
 118 009c 3B6A     		ldr	r3, [r7, #32]
 119 009e 5902     		lsls	r1, r3, #9
 120 00a0 7B6A     		ldr	r3, [r7, #36]
 121 00a2 0B44     		add	r3, r3, r1
 122 00a4 9B00     		lsls	r3, r3, #2
 123 00a6 B968     		ldr	r1, [r7, #8]
 124 00a8 0B44     		add	r3, r3, r1
 125 00aa 1B68     		ldr	r3, [r3]
 126 00ac 03F47F43 		and	r3, r3, #65280
 127 00b0 1B12     		asrs	r3, r3, #8
 128 00b2 F969     		ldr	r1, [r7, #28]
 129 00b4 C1F1FF01 		rsb	r1, r1, #255
 130 00b8 01FB03F3 		mul	r3, r1, r3
 131 00bc 1344     		add	r3, r3, r2
 132 00be 03F1FF02 		add	r2, r3, #255
 133 00c2 002B     		cmp	r3, #0
 134 00c4 B4BF     		ite	lt
 135 00c6 1346     		movlt	r3, r2
 136 00c8 1B46     		movge	r3, r3
 137 00ca 1B12     		asrs	r3, r3, #8
 138 00cc 7B61     		str	r3, [r7, #20]
 277:alpha_time.c  ****             int dst_b = ((B(fgImage[(y*512)+x]) * a_fg) + (B(bgImage[(y*512)+x]) * (255-a_fg)))/256
 139              		.loc 1 277 0 discriminator 3
 140 00ce 3B6A     		ldr	r3, [r7, #32]
 141 00d0 5A02     		lsls	r2, r3, #9
 142 00d2 7B6A     		ldr	r3, [r7, #36]
 143 00d4 1344     		add	r3, r3, r2
 144 00d6 9B00     		lsls	r3, r3, #2
 145 00d8 FA68     		ldr	r2, [r7, #12]
 146 00da 1344     		add	r3, r3, r2
 147 00dc 1B68     		ldr	r3, [r3]
 148 00de DBB2     		uxtb	r3, r3
 149 00e0 FA69     		ldr	r2, [r7, #28]
 150 00e2 02FB03F2 		mul	r2, r2, r3
 151 00e6 3B6A     		ldr	r3, [r7, #32]
 152 00e8 5902     		lsls	r1, r3, #9
 153 00ea 7B6A     		ldr	r3, [r7, #36]
 154 00ec 0B44     		add	r3, r3, r1
 155 00ee 9B00     		lsls	r3, r3, #2
 156 00f0 B968     		ldr	r1, [r7, #8]
 157 00f2 0B44     		add	r3, r3, r1
 158 00f4 1B68     		ldr	r3, [r3]
 159 00f6 DBB2     		uxtb	r3, r3
 160 00f8 F969     		ldr	r1, [r7, #28]
 161 00fa C1F1FF01 		rsb	r1, r1, #255
 162 00fe 01FB03F3 		mul	r3, r1, r3
 163 0102 1344     		add	r3, r3, r2
 164 0104 03F1FF02 		add	r2, r3, #255
 165 0108 002B     		cmp	r3, #0
 166 010a B4BF     		ite	lt
 167 010c 1346     		movlt	r3, r2
 168 010e 1B46     		movge	r3, r3
 169 0110 1B12     		asrs	r3, r3, #8
 170 0112 3B61     		str	r3, [r7, #16]
 278:alpha_time.c  ****             dstImage[(y*512)+x] =  0xff000000 |
 171              		.loc 1 278 0 discriminator 3
 172 0114 3B6A     		ldr	r3, [r7, #32]
 173 0116 5A02     		lsls	r2, r3, #9
 174 0118 7B6A     		ldr	r3, [r7, #36]
 175 011a 1344     		add	r3, r3, r2
 176 011c 9B00     		lsls	r3, r3, #2
 177 011e 7A68     		ldr	r2, [r7, #4]
 178 0120 1344     		add	r3, r3, r2
 279:alpha_time.c  ****                 (0x00ff0000 & (dst_r << 16)) |
 179              		.loc 1 279 0 discriminator 3
 180 0122 BA69     		ldr	r2, [r7, #24]
 181 0124 1204     		lsls	r2, r2, #16
 182 0126 02F47F01 		and	r1, r2, #16711680
 280:alpha_time.c  ****                 (0x0000ff00 & (dst_g << 8)) |
 183              		.loc 1 280 0 discriminator 3
 184 012a 7A69     		ldr	r2, [r7, #20]
 185 012c 1202     		lsls	r2, r2, #8
 279:alpha_time.c  ****                 (0x00ff0000 & (dst_r << 16)) |
 186              		.loc 1 279 0 discriminator 3
 187 012e 92B2     		uxth	r2, r2
 188 0130 1143     		orrs	r1, r1, r2
 189              		.loc 1 280 0 discriminator 3
 190 0132 3A69     		ldr	r2, [r7, #16]
 191 0134 D2B2     		uxtb	r2, r2
 192 0136 0A43     		orrs	r2, r2, r1
 193 0138 42F07F42 		orr	r2, r2, #-16777216
 278:alpha_time.c  ****             dstImage[(y*512)+x] =  0xff000000 |
 194              		.loc 1 278 0 discriminator 3
 195 013c 1A60     		str	r2, [r3]
 196              	.LBE2:
 273:alpha_time.c  ****             int a_fg = A(fgImage[(y*512)+x]);
 197              		.loc 1 273 0 discriminator 3
 198 013e 7B6A     		ldr	r3, [r7, #36]
 199 0140 0133     		adds	r3, r3, #1
 200 0142 7B62     		str	r3, [r7, #36]
 201              	.L3:
 273:alpha_time.c  ****             int a_fg = A(fgImage[(y*512)+x]);
 202              		.loc 1 273 0 is_stmt 0 discriminator 1
 203 0144 7B6A     		ldr	r3, [r7, #36]
 204 0146 B3F5007F 		cmp	r3, #512
 205 014a FFF668AF 		blt	.L4
 272:alpha_time.c  ****         for(x = 0; x < 512; x++){
 206              		.loc 1 272 0 is_stmt 1 discriminator 2
 207 014e 3B6A     		ldr	r3, [r7, #32]
 208 0150 0133     		adds	r3, r3, #1
 209 0152 3B62     		str	r3, [r7, #32]
 210              	.L2:
 272:alpha_time.c  ****         for(x = 0; x < 512; x++){
 211              		.loc 1 272 0 is_stmt 0 discriminator 1
 212 0154 3B6A     		ldr	r3, [r7, #32]
 213 0156 B3F5007F 		cmp	r3, #512
 214 015a FFF65DAF 		blt	.L5
 281:alpha_time.c  ****                 (0x000000ff & (dst_b));
 282:alpha_time.c  ****         }
 283:alpha_time.c  ****     }
 284:alpha_time.c  **** }
 215              		.loc 1 284 0 is_stmt 1
 216 015e 2837     		adds	r7, r7, #40
 217              		.cfi_def_cfa_offset 8
 218 0160 BD46     		mov	sp, r7
 219              		.cfi_def_cfa_register 13
 220              		@ sp needed
 221 0162 80BD     		pop	{r7, pc}
 222              		.cfi_endproc
 223              	.LFE0:
 225              		.section	.rodata
 226              		.align	2
 227              	.LC0:
 228 0000 55736167 		.ascii	"Usage:%s foreground background outFile\012\000"
 228      653A2573 
 228      20666F72 
 228      6567726F 
 228      756E6420 
 229              		.align	2
 230              	.LC1:
 231 0028 726200   		.ascii	"rb\000"
 232 002b 00       		.align	2
 233              	.LC2:
 234 002c 776200   		.ascii	"wb\000"
 235 002f 00       		.align	2
 236              	.LC3:
 237 0030 4572726F 		.ascii	"Error with backImage\012\000"
 237      72207769 
 237      74682062 
 237      61636B49 
 237      6D616765 
 238 0046 0000     		.align	2
 239              	.LC4:
 240 0048 4572726F 		.ascii	"Error with foreImage\012\000"
 240      72207769 
 240      74682066 
 240      6F726549 
 240      6D616765 
 241 005e 0000     		.align	2
 242              	.LC5:
 243 0060 526F7574 		.ascii	"Routine took %ld microseconds\012\000"
 243      696E6520 
 243      746F6F6B 
 243      20256C64 
 243      206D6963 
 244 007f 00       		.align	2
 245              	.LC6:
 246 0080 50726F62 		.ascii	"Problem opening a file\012\000"
 246      6C656D20 
 246      6F70656E 
 246      696E6720 
 246      61206669 
 247              		.text
 248              		.align	2
 249              		.global	main
 250              		.thumb
 251              		.thumb_func
 253              	main:
 254              	.LFB1:
 285:alpha_time.c  **** #endif
 286:alpha_time.c  **** int main(int argc, char**argv)
 287:alpha_time.c  **** {
 255              		.loc 1 287 0
 256              		.cfi_startproc
 257              		@ args = 0, pretend = 0, frame = 40
 258              		@ frame_needed = 1, uses_anonymous_args = 0
 259 0164 80B5     		push	{r7, lr}
 260              		.cfi_def_cfa_offset 8
 261              		.cfi_offset 7, -8
 262              		.cfi_offset 14, -4
 263 0166 8AB0     		sub	sp, sp, #40
 264              		.cfi_def_cfa_offset 48
 265 0168 00AF     		add	r7, sp, #0
 266              		.cfi_def_cfa_register 7
 267 016a 7860     		str	r0, [r7, #4]
 268 016c 3960     		str	r1, [r7]
 288:alpha_time.c  ****     FILE *fgFile, *bgFile, *outFile;
 289:alpha_time.c  ****     int result;
 290:alpha_time.c  ****     struct timeval oldTv, newTv;
 291:alpha_time.c  **** 
 292:alpha_time.c  ****     if(argc != 4){
 269              		.loc 1 292 0
 270 016e 7B68     		ldr	r3, [r7, #4]
 271 0170 042B     		cmp	r3, #4
 272 0172 10D0     		beq	.L7
 293:alpha_time.c  ****         fprintf(stderr, "Usage:%s foreground background outFile\n",argv[0]);
 273              		.loc 1 293 0
 274 0174 40F20003 		movw	r3, #:lower16:stderr
 275 0178 C0F20003 		movt	r3, #:upper16:stderr
 276 017c 1A68     		ldr	r2, [r3]
 277 017e 3B68     		ldr	r3, [r7]
 278 0180 1B68     		ldr	r3, [r3]
 279 0182 1046     		mov	r0, r2
 280 0184 40F20001 		movw	r1, #:lower16:.LC0
 281 0188 C0F20001 		movt	r1, #:upper16:.LC0
 282 018c 1A46     		mov	r2, r3
 283 018e FFF7FEFF 		bl	fprintf
 294:alpha_time.c  ****         return 1;
 284              		.loc 1 294 0
 285 0192 0123     		movs	r3, #1
 286 0194 C6E0     		b	.L12
 287              	.L7:
 295:alpha_time.c  ****     }
 296:alpha_time.c  ****     fgFile = fopen(argv[1], "rb");
 288              		.loc 1 296 0
 289 0196 3B68     		ldr	r3, [r7]
 290 0198 0433     		adds	r3, r3, #4
 291 019a 1B68     		ldr	r3, [r3]
 292 019c 1846     		mov	r0, r3
 293 019e 40F20001 		movw	r1, #:lower16:.LC1
 294 01a2 C0F20001 		movt	r1, #:upper16:.LC1
 295 01a6 FFF7FEFF 		bl	fopen
 296 01aa 7862     		str	r0, [r7, #36]
 297:alpha_time.c  ****     bgFile = fopen(argv[2], "rb");
 297              		.loc 1 297 0
 298 01ac 3B68     		ldr	r3, [r7]
 299 01ae 0833     		adds	r3, r3, #8
 300 01b0 1B68     		ldr	r3, [r3]
 301 01b2 1846     		mov	r0, r3
 302 01b4 40F20001 		movw	r1, #:lower16:.LC1
 303 01b8 C0F20001 		movt	r1, #:upper16:.LC1
 304 01bc FFF7FEFF 		bl	fopen
 305 01c0 3862     		str	r0, [r7, #32]
 298:alpha_time.c  ****     outFile = fopen(argv[3], "wb");
 306              		.loc 1 298 0
 307 01c2 3B68     		ldr	r3, [r7]
 308 01c4 0C33     		adds	r3, r3, #12
 309 01c6 1B68     		ldr	r3, [r3]
 310 01c8 1846     		mov	r0, r3
 311 01ca 40F20001 		movw	r1, #:lower16:.LC2
 312 01ce C0F20001 		movt	r1, #:upper16:.LC2
 313 01d2 FFF7FEFF 		bl	fopen
 314 01d6 F861     		str	r0, [r7, #28]
 299:alpha_time.c  **** 
 300:alpha_time.c  ****     if(fgFile && bgFile && outFile){
 315              		.loc 1 300 0
 316 01d8 7B6A     		ldr	r3, [r7, #36]
 317 01da 002B     		cmp	r3, #0
 318 01dc 00F09480 		beq	.L9
 319              		.loc 1 300 0 is_stmt 0 discriminator 1
 320 01e0 3B6A     		ldr	r3, [r7, #32]
 321 01e2 002B     		cmp	r3, #0
 322 01e4 00F09080 		beq	.L9
 323              		.loc 1 300 0 discriminator 2
 324 01e8 FB69     		ldr	r3, [r7, #28]
 325 01ea 002B     		cmp	r3, #0
 326 01ec 00F08C80 		beq	.L9
 301:alpha_time.c  ****         result = fread(backImage, 512*sizeof(int), 512, bgFile);
 327              		.loc 1 301 0 is_stmt 1
 328 01f0 40F20000 		movw	r0, #:lower16:backImage
 329 01f4 C0F20000 		movt	r0, #:upper16:backImage
 330 01f8 4FF40061 		mov	r1, #2048
 331 01fc 4FF40072 		mov	r2, #512
 332 0200 3B6A     		ldr	r3, [r7, #32]
 333 0202 FFF7FEFF 		bl	fread
 334 0206 0346     		mov	r3, r0
 335 0208 BB61     		str	r3, [r7, #24]
 302:alpha_time.c  ****         if(result != 512){
 336              		.loc 1 302 0
 337 020a BB69     		ldr	r3, [r7, #24]
 338 020c B3F5007F 		cmp	r3, #512
 339 0210 0ED0     		beq	.L10
 303:alpha_time.c  ****             fprintf(stderr, "Error with backImage\n");
 340              		.loc 1 303 0
 341 0212 40F20003 		movw	r3, #:lower16:stderr
 342 0216 C0F20003 		movt	r3, #:upper16:stderr
 343 021a 1B68     		ldr	r3, [r3]
 344 021c 40F20000 		movw	r0, #:lower16:.LC3
 345 0220 C0F20000 		movt	r0, #:upper16:.LC3
 346 0224 0121     		movs	r1, #1
 347 0226 1522     		movs	r2, #21
 348 0228 FFF7FEFF 		bl	fwrite
 304:alpha_time.c  ****             return 3;
 349              		.loc 1 304 0
 350 022c 0323     		movs	r3, #3
 351 022e 79E0     		b	.L12
 352              	.L10:
 305:alpha_time.c  ****         }
 306:alpha_time.c  ****         result = fread(foreImage, 512*sizeof(int), 512, fgFile);
 353              		.loc 1 306 0
 354 0230 40F20000 		movw	r0, #:lower16:foreImage
 355 0234 C0F20000 		movt	r0, #:upper16:foreImage
 356 0238 4FF40061 		mov	r1, #2048
 357 023c 4FF40072 		mov	r2, #512
 358 0240 7B6A     		ldr	r3, [r7, #36]
 359 0242 FFF7FEFF 		bl	fread
 360 0246 0346     		mov	r3, r0
 361 0248 BB61     		str	r3, [r7, #24]
 307:alpha_time.c  ****         if(result != 512){
 362              		.loc 1 307 0
 363 024a BB69     		ldr	r3, [r7, #24]
 364 024c B3F5007F 		cmp	r3, #512
 365 0250 0ED0     		beq	.L11
 308:alpha_time.c  ****             fprintf(stderr, "Error with foreImage\n");
 366              		.loc 1 308 0
 367 0252 40F20003 		movw	r3, #:lower16:stderr
 368 0256 C0F20003 		movt	r3, #:upper16:stderr
 369 025a 1B68     		ldr	r3, [r3]
 370 025c 40F20000 		movw	r0, #:lower16:.LC4
 371 0260 C0F20000 		movt	r0, #:upper16:.LC4
 372 0264 0121     		movs	r1, #1
 373 0266 1522     		movs	r2, #21
 374 0268 FFF7FEFF 		bl	fwrite
 309:alpha_time.c  ****             return 4;
 375              		.loc 1 309 0
 376 026c 0423     		movs	r3, #4
 377 026e 59E0     		b	.L12
 378              	.L11:
 310:alpha_time.c  ****         }
 311:alpha_time.c  ****         gettimeofday(&oldTv, NULL);
 379              		.loc 1 311 0
 380 0270 07F11003 		add	r3, r7, #16
 381 0274 1846     		mov	r0, r3
 382 0276 0021     		movs	r1, #0
 383 0278 FFF7FEFF 		bl	gettimeofday
 312:alpha_time.c  **** #if macro == 0
 313:alpha_time.c  ****         alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
 384              		.loc 1 313 0
 385 027c 40F20000 		movw	r0, #:lower16:foreImage
 386 0280 C0F20000 		movt	r0, #:upper16:foreImage
 387 0284 40F20001 		movw	r1, #:lower16:backImage
 388 0288 C0F20001 		movt	r1, #:upper16:backImage
 389 028c 40F20002 		movw	r2, #:lower16:newImage
 390 0290 C0F20002 		movt	r2, #:upper16:newImage
 391 0294 FFF7FEFF 		bl	alphaBlend_c
 314:alpha_time.c  **** #elif macro == 1
 315:alpha_time.c  ****         alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
 316:alpha_time.c  **** #elif macro == 2
 317:alpha_time.c  ****         alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
 318:alpha_time.c  **** #elif macro == 8
 319:alpha_time.c  ****         alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
 320:alpha_time.c  **** #elif macro == 9
 321:alpha_time.c  ****         alphaBlend_c((unsigned char*)&foreImage[0], (unsigned char*)&backImage[0], (unsigned char*)
 322:alpha_time.c  **** #elif macro == 10
 323:alpha_time.c  ****         alphaBlend_c((unsigned char*)&foreImage[0], (unsigned char*)&backImage[0], (unsigned char*)
 324:alpha_time.c  **** #elif macro >= 3
 325:alpha_time.c  ****         alphaBlend_c();
 326:alpha_time.c  **** #endif
 327:alpha_time.c  ****         gettimeofday(&newTv, NULL);
 392              		.loc 1 327 0
 393 0298 07F10803 		add	r3, r7, #8
 394 029c 1846     		mov	r0, r3
 395 029e 0021     		movs	r1, #0
 396 02a0 FFF7FEFF 		bl	gettimeofday
 328:alpha_time.c  ****         fprintf(stdout, "Routine took %ld microseconds\n", (long)((newTv.tv_sec-oldTv.tv_sec)*10000
 397              		.loc 1 328 0
 398 02a4 40F20003 		movw	r3, #:lower16:stdout
 399 02a8 C0F20003 		movt	r3, #:upper16:stdout
 400 02ac 1868     		ldr	r0, [r3]
 401 02ae BA68     		ldr	r2, [r7, #8]
 402 02b0 3B69     		ldr	r3, [r7, #16]
 403 02b2 D11A     		subs	r1, r2, r3
 404 02b4 0A46     		mov	r2, r1
 405 02b6 5201     		lsls	r2, r2, #5
 406 02b8 521A     		subs	r2, r2, r1
 407 02ba 9301     		lsls	r3, r2, #6
 408 02bc 9B1A     		subs	r3, r3, r2
 409 02be DB00     		lsls	r3, r3, #3
 410 02c0 0B44     		add	r3, r3, r1
 411 02c2 9B01     		lsls	r3, r3, #6
 412 02c4 1946     		mov	r1, r3
 413 02c6 FA68     		ldr	r2, [r7, #12]
 414 02c8 7B69     		ldr	r3, [r7, #20]
 415 02ca D31A     		subs	r3, r2, r3
 416 02cc 0B44     		add	r3, r3, r1
 417 02ce 40F20001 		movw	r1, #:lower16:.LC5
 418 02d2 C0F20001 		movt	r1, #:upper16:.LC5
 419 02d6 1A46     		mov	r2, r3
 420 02d8 FFF7FEFF 		bl	fprintf
 329:alpha_time.c  ****         fwrite(newImage, 512*sizeof(int),512,outFile);
 421              		.loc 1 329 0
 422 02dc 40F20000 		movw	r0, #:lower16:newImage
 423 02e0 C0F20000 		movt	r0, #:upper16:newImage
 424 02e4 4FF40061 		mov	r1, #2048
 425 02e8 4FF40072 		mov	r2, #512
 426 02ec FB69     		ldr	r3, [r7, #28]
 427 02ee FFF7FEFF 		bl	fwrite
 330:alpha_time.c  ****         fclose(fgFile);
 428              		.loc 1 330 0
 429 02f2 786A     		ldr	r0, [r7, #36]
 430 02f4 FFF7FEFF 		bl	fclose
 331:alpha_time.c  ****         fclose(bgFile);
 431              		.loc 1 331 0
 432 02f8 386A     		ldr	r0, [r7, #32]
 433 02fa FFF7FEFF 		bl	fclose
 332:alpha_time.c  ****         fclose(outFile);
 434              		.loc 1 332 0
 435 02fe F869     		ldr	r0, [r7, #28]
 436 0300 FFF7FEFF 		bl	fclose
 333:alpha_time.c  ****         return 0;
 437              		.loc 1 333 0
 438 0304 0023     		movs	r3, #0
 439 0306 0DE0     		b	.L12
 440              	.L9:
 334:alpha_time.c  ****     }
 335:alpha_time.c  ****     fprintf(stderr, "Problem opening a file\n");
 441              		.loc 1 335 0
 442 0308 40F20003 		movw	r3, #:lower16:stderr
 443 030c C0F20003 		movt	r3, #:upper16:stderr
 444 0310 1B68     		ldr	r3, [r3]
 445 0312 40F20000 		movw	r0, #:lower16:.LC6
 446 0316 C0F20000 		movt	r0, #:upper16:.LC6
 447 031a 0121     		movs	r1, #1
 448 031c 1722     		movs	r2, #23
 449 031e FFF7FEFF 		bl	fwrite
 336:alpha_time.c  ****     return 2;
 450              		.loc 1 336 0
 451 0322 0223     		movs	r3, #2
 452              	.L12:
 337:alpha_time.c  **** }
 453              		.loc 1 337 0 discriminator 1
 454 0324 1846     		mov	r0, r3
 455 0326 2837     		adds	r7, r7, #40
 456              		.cfi_def_cfa_offset 8
 457 0328 BD46     		mov	sp, r7
 458              		.cfi_def_cfa_register 13
 459              		@ sp needed
 460 032a 80BD     		pop	{r7, pc}
 461              		.cfi_endproc
 462              	.LFE1:
 464              	.Letext0:
 465              		.file 2 "/usr/lib/gcc/arm-linux-gnueabihf/4.9/include/stddef.h"
 466              		.file 3 "/usr/include/arm-linux-gnueabihf/bits/types.h"
 467              		.file 4 "/usr/include/stdio.h"
 468              		.file 5 "/usr/include/libio.h"
 469              		.file 6 "/usr/include/arm-linux-gnueabihf/bits/time.h"
