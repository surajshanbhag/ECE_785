#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <sys/time.h>
#include <arm_neon.h>
#include <arm_acle.h>

int backImage[512 * 512];
int foreImage[512 * 512];
int newImage[512 * 512];
#define A(x) (((x) & 0xff000000) >> 24)
#define R(x) (((x) & 0x00ff0000) >> 16)
#define G(x) (((x) & 0x0000ff00) >> 8)
#define B(x) ((x) & 0x000000ff)

void alphaBlend_c(int *fgImage, int *bgImage, int *dstImage)
{
    uint8x8x4_t fg,bg,ds;
    uint8x8_t aM255;
    uint16x8_t temp;
    int a;
    int index=0;
    for(index =0; index<512*512/8;index++)
    {
        fg=vld4_u8(&fgImage[index*8]);
        bg=vld4_u8(&bgImage[index*8]);
        aM255=vdup_n_u8(255);
        ds.val[0]=aM255;
        aM255=vsub_u8(aM255,fg.val[0]);

        temp=vmull_u8(fg.val[0],fg.val[1]);
        temp=vmlal_u8(temp,aM255,bg.val[1]);
        temp=vshrq_n_u16(temp,8);
        ds.val[1]=vmovn_u16(temp);

        temp=vmull_u8(fg.val[0],fg.val[2]);
        temp=vmlal_u8(temp,aM255,bg.val[2]);
        temp=vshrq_n_u16(temp,8);
        ds.val[2]=vmovn_u16(temp);

        temp=vmull_u8(fg.val[0],fg.val[3]);
        temp=vmlal_u8(temp,aM255,bg.val[3]);
        temp=vshrq_n_u16(temp,8);
        ds.val[3]=vmovn_u16(temp);

        vst4_u8(&dstImage[index*8],ds);
    }
}

int main(int argc, char**argv)
{
    FILE *fgFile, *bgFile, *outFile;
    int result;
    struct timeval oldTv, newTv;

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
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
        //alphaBlend_c((int8_t)&foreImage[0],(int8_t) &backImage[0],(int8_t) &newImage[0]);
        gettimeofday(&newTv, NULL);
        fprintf(stdout, "Routine took %d microseconds\n", (int)(newTv.tv_usec - oldTv.tv_usec));
        fwrite(newImage, 512*sizeof(int),512,outFile);
        fclose(fgFile);
        fclose(bgFile);
        fclose(outFile);
        return 0;
    }
    fprintf(stderr, "Problem opening a file\n");
    return 2;
}

