void alphaBlend_c(void);//int *fgImage, int *bgImage, int *dstImage);

#include <stdio.h>
#include <sys/time.h>
#include <time.h>

int backImage[512 * 512];
int foreImage[512 * 512];
int newImage[512 * 512];
#define fgImage foreImage
#define bgImage backImage
#define dstImage newImage
int main(int argc, char**argv)
{
    FILE *fgFile, *bgFile, *outFile;
    int result;
    struct timeval oldTv, newTv;
    struct timespec start, end;
    unsigned long diff_1,diff_2;

    if(argc != 4){
        fprintf(stderr, "Usage:%s foreground background outFile\n",argv[0]);
        return 1;
    }
    fgFile = fopen(argv[1], "rb");
    bgFile = fopen(argv[2], "rb");
    outFile = fopen(argv[3], "wb");

    if(fgFile && bgFile && outFile){
        result = fread(backImage, 512*sizeof(int), 512, bgFile);
        if(result != 512){
            fprintf(stderr, "Error with backImage\n");
            return 3;
        }
        result = fread(foreImage, 512*sizeof(int), 512, fgFile);
        if(result != 512){
            fprintf(stderr, "Error with foreImage\n");
            return 4;
        }
        gettimeofday(&oldTv, NULL);
        alphaBlend_c();//&foreImage[0], &backImage[0], &newImage[0]);
        gettimeofday(&newTv, NULL);

        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
        alphaBlend_c();//&foreImage[0], &backImage[0], &newImage[0]);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);

        diff_2 = 1000000000 * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
        diff_1 = ((newTv.tv_sec-oldTv.tv_sec)*1000000 + newTv.tv_usec-oldTv.tv_usec);
        fprintf(stdout, "Routine took %ld %ld microseconds\n", diff_1,diff_2/1000);
        fwrite(newImage, 512*sizeof(int),512,outFile);
        fclose(fgFile);
        fclose(bgFile);
        fclose(outFile);
        return 0;
    }
    fprintf(stderr, "Problem opening a file\n");
    return 2;
}

#define type short 
#define A(x) (type)(((x) & 0xff000000) >> 24)
#define R(x) (type)(((x) & 0x00ff0000) >> 16)
#define G(x) (type)(((x) & 0x0000ff00) >> 8)
#define B(x) (type)((x) & 0x000000ff)

void alphaBlend_c(void)//int *__restrict fgImage,int *__restrict bgImage,int *__restrict dstImage)
{
    /* int x, y;
       for(y = 0; y < 512*512; y++){
       int a_fg = A(fgImage[y]);
       int dst_r = ((R(fgImage[y]) * a_fg) + (R(bgImage[y]) * (255-a_fg)))/256;
       int dst_g = ((G(fgImage[y]) * a_fg) + (G(bgImage[y]) * (255-a_fg)))/256;
       int dst_b = ((B(fgImage[y]) * a_fg) + (B(bgImage[y]) * (255-a_fg)))/256;
       dstImage[y] =  0xff000000 |
       (0x00ff0000 & (dst_r << 16)) |
       (0x0000ff00 & (dst_g << 8)) |
       (0x000000ff & (dst_b));
       }nt x, y;
           for(y = 0; y < 512; y++){
                   for(x = 0; x < 512; x++){
                               int a_fg = A(fgImage[(y*512)+x]);
                                           int dst_r = ((R(fgImage[(y*512)+x]) * a_fg) + (R(bgImage[(y*512)+x]) * (255-a_fg)))/256;
                                                       int dst_g = ((G(fgImage[(y*512)+x]) * a_fg) + (G(bgImage[(y*512)+x]) * (255-a_fg)))/256;
                                                                   int dst_b = ((B(fgImage[(y*512)+x]) * a_fg) + (B(bgImage[(y*512)+x]) * (255-a_fg)))/256;
                                                                               dstImage[(y*512)+x] =  0xff000000 |
                                                                                               (0x00ff0000 & (dst_r << 16)) |
                                                                                                               (0x0000ff00 & (dst_g << 8)) |
                                                                                                                               (0x000000ff & (dst_b));
                                                                                                                                       }
                                                                                                                                           }1*/

    int x=0, y=0;
    //int a_fg=0,a_fgM255=0;
    //int r_fg=0,b_fg=0,g_fg=0,r_bg=0,g_bg=0,b_bg=0;
    int dst_r=0,dst_b=0,dst_g=0;
    int dst_rf[512*512],dst_bf[512*512],dst_gf[512*512],dst_af[512*512];
    char r_fg[512*512],b_fg[512*512],g_fg[512*512],a_fg[512*512],a_fgM255[512*512];
    int r_bg[512*512],b_bg[512*512],g_bg[512*512];
    int temp=0;
    int index=0;
    for(index = 0; index < 512*512; index++){
        a_fg[index]=A(fgImage[index]);
    }
    for(index = 0; index < 512*512; index++){
        r_fg[index]=R(fgImage[index]);
        g_fg[index]=G(fgImage[index]);
        b_fg[index]=B(fgImage[index]);
    }
    for(index = 0; index < 512*512; index++){
        r_bg[index]=R(bgImage[index]);
        g_bg[index]=G(bgImage[index]);
        b_bg[index]=B(bgImage[index]);
    }
    for(index = 0; index < 512*512; index++){
        dst_r = (r_fg[index] * a_fg[index]);
        dst_r += (r_bg[index] * a_fgM255[index]);
        dst_r = dst_r/ 256;
        dst_g = (g_fg[index] * a_fg[index]);
        dst_g += (g_bg[index] * a_fgM255[index]);
        dst_g = dst_g / 256;
        dst_b = (b_fg[index] * a_fg[index]);
        dst_b += (b_bg[index] * a_fgM255[index]);
        dst_b = dst_b / 256;
        dst_rf[index] = dst_r << 16;
        dst_gf[index] = dst_g << 8;
        dst_bf[index] = dst_b; 
    }

    for(index = 0; index < 512*512; index++){
        dstImage[index] =  0xff000000;
        temp =  (0x00ff0000 & dst_rf[index]);
        dstImage[index] |= temp;
        temp =  (0x0000ff00 & dst_gf[index]);
        dstImage[index] |= temp;
        temp =  (0x000000ff & dst_bf[index]);
        dstImage[index] |= temp;
    }
}

/*
   for(index = 0; index < 512*512; index++){
   a_fg = A(fgImage[index]);
   a_fgM255 = 255-a_fg;
   r_fg = R(fgImage[index]); 
   g_fg = G(fgImage[index]); 
   b_fg = B(fgImage[index]); 
   r_bg = R(bgImage[index]); 
   g_bg = G(bgImage[index]); 
   b_bg = B(bgImage[index]); 
   dst_r = (r_fg * a_fg);
   dst_r += (r_bg * a_fgM255);
   dst_r = dst_r/ 256;
   dst_g = (g_fg * a_fg);
   dst_g += (g_bg * a_fgM255);
   dst_g = dst_g / 256;
   dst_b = (b_fg * a_fg);
   dst_b += (b_bg * a_fgM255);
   dst_b = dst_b / 256;
   dst_rf[index] = dst_r << 16;
   dst_gf[index] = dst_g << 8;
   dst_bf[index] = dst_b; 
   }
   for(index = 0; index < 512; index++){
   dstImage[index] =  0xff000000;
   temp =  (0x00ff0000 & dst_rf[index]);
   dstImage[index] |= temp;
   temp =  (0x0000ff00 & dst_gf[index]);
   dstImage[index] |= temp;
   temp =  (0x000000ff & dst_bf[index]);
   dstImage[index] |= temp;
   }
   */




/*
   void alphaBlend_c(void)//int *__restrict fgImage,int *__restrict bgImage,int *__restrict dstImage)
   {
   int x, y;
   type a_fg,a_fgM255,dst_r,dst_b,dst_g;
   type r_fg,b_fg,g_fg,r_bg,g_bg,b_bg;
//int dst_rf[512*512],dst_bf[512*512],dst_gf[512*512];
int dst_rf,dst_bf,dst_gf;
int temp;
int index;
for(y = 0; y < 512; y++){
for(x = 0; x < 512; x++){
index=(y*512)+x;
a_fg = A(fgImage[index]);
a_fgM255 = 255-a_fg;
r_fg = R(fgImage[index]); 
g_fg = G(fgImage[index]); 
b_fg = B(fgImage[index]); 
r_bg = R(bgImage[index]); 
g_bg = G(bgImage[index]); 
b_bg = B(bgImage[index]); 
dst_r = (r_fg * a_fg);
dst_r += (r_bg * a_fgM255);
dst_r = dst_r/ 256;
dst_g = (g_fg * a_fg);
dst_g = (g_bg * a_fgM255);
dst_g = dst_g / 256;
dst_b = (b_fg * a_fg);
dst_b = (b_bg * a_fgM255);
dst_b = dst_b / 256;
dst_rf = (int)dst_r;
dst_rf = dst_rf << 16;
dst_gf = (int)dst_g;
dst_gf = dst_gf << 8;
dst_bf = (int)dst_b; 
// dst_rf[index] = dst_r << 16;
//dst_gf[index] = dst_g << 8;
//dst_bf[index] = dst_b; 
dstImage[index] =  0xff000000;
temp =  (0x00ff0000 & dst_rf);
dstImage[index] |= temp;
temp =  (0x0000ff00 & dst_gf);
dstImage[index] |= temp;
temp =  (0x000000ff & dst_bf);
dstImage[index] |= temp;
}
}
}*/
