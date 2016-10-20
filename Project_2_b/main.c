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

#define alpha 3
#define red 0
#define green 1
#define blue 2

void alphaBlend_c(const uint8_t *fgImage,const uint8_t *bgImage,uint8_t *dstImage)
{
    uint8x8x4_t fg,bg,ds;
    uint8x8_t aM255;
    uint16x8_t temp;
    int index=0;
    for(index =0; index<512*512*4;index=index+32)
    {
        fg=vld4_u8(&fgImage[index]);
        bg=vld4_u8(&bgImage[index]);
        aM255=vdup_n_u8(0xff);
        ds.val[alpha]=aM255;
        aM255=vsub_u8(aM255,fg.val[alpha]);
        //* Combined code into one single line */
        ds.val[red]=vmovn_u16(vshrq_n_u16(vmlal_u8(vmull_u8(fg.val[alpha],fg.val[red]),aM255,bg.val[red]),8));
        ds.val[green]=vmovn_u16(vshrq_n_u16(vmlal_u8(vmull_u8(fg.val[alpha],fg.val[green]),aM255,bg.val[green]),8));
        ds.val[blue]=vmovn_u16(vshrq_n_u16(vmlal_u8(vmull_u8(fg.val[blue],fg.val[blue]),aM255,bg.val[blue]),8));

        /* above code when split into multiple instruction */
/*
        temp=vmull_u8(fg.val[alpha],fg.val[red]);
        temp=vmlal_u8(temp,aM255,bg.val[red]);
        temp=vshrq_n_u16(temp,8);
        ds.val[red]=vmovn_u16(temp);

        temp=vmull_u8(fg.val[alpha],fg.val[green]);
        temp=vmlal_u8(temp,aM255,bg.val[green]);
        temp=vshrq_n_u16(temp,8);
        ds.val[green]=vmovn_u16(temp);

        temp=vmull_u8(fg.val[alpha],fg.val[blue]);
        temp=vmlal_u8(temp,aM255,bg.val[blue]);
        temp=vshrq_n_u16(temp,8);
        ds.val[blue]=vmovn_u16(temp);
*/
        vst4_u8(&dstImage[index],ds);
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
        alphaBlend_c((uint8_t*)&foreImage[0], (uint8_t*)&backImage[0],(uint8_t*) &newImage[0]);
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

