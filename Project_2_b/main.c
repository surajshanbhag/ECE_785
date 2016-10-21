#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
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
    //int16x8_t temp;
    int index=0;
    for(index =0; index<512*512*4/32;index++)
    {
        fg=vld4_u8(&fgImage[index*32]);
        bg=vld4_u8(&bgImage[index*32]);
        aM255=vdup_n_u8(0xff);
        ds.val[alpha]=aM255;
        aM255=vsub_u8(aM255,fg.val[alpha]);
        // Combined code into one single line 
        //
        ds.val[red]=(vqshrn_n_u16(vmlal_u8(vmull_u8(fg.val[alpha],fg.val[red]),aM255,bg.val[red]),8));
        ds.val[green]=(vqshrn_n_u16(vmlal_u8(vmull_u8(fg.val[alpha],fg.val[green]),aM255,bg.val[green]),8));
        ds.val[blue]=(vqshrn_n_u16(vmlal_u8(vmull_u8(fg.val[blue],fg.val[blue]),aM255,bg.val[blue]),8));

        // above code when split into multiple instruction 
        /*
           temp=vmull_u8(fg.val[alpha],fg.val[red]);
           temp=vmlal_u8(temp,aM255,bg.val[red]);
           ds.val[red]=vqshrn_n_u16(temp,8);

           temp=vmull_u8(fg.val[alpha],fg.val[green]);
           temp=vmlal_u8(temp,aM255,bg.val[green]);
           ds.val[green]=vqshrn_n_u16(temp,8);

           temp=vmull_u8(fg.val[alpha],fg.val[blue]);
           temp=vmlal_u8(temp,aM255,bg.val[blue]);
           ds.val[blue]=vqshrn_n_u16(temp,8);
           */
        vst4_u8(&dstImage[index*32],ds);
    }
}

int main(int argc, char**argv)
{
    FILE *fgFile, *bgFile, *outFile;
    int result;
    struct timeval oldTv, newTv;
    long int diff,min=LONG_MAX;
    int i;
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
        for(i=0;i<1000;i++)
        {
            gettimeofday(&oldTv, NULL);
            alphaBlend_c((uint8_t*)&foreImage[0], (uint8_t*)&backImage[0],(uint8_t*) &newImage[0]);
            gettimeofday(&newTv, NULL);
            diff=(long int)((newTv.tv_sec-oldTv.tv_sec)*1000000+(newTv.tv_usec - oldTv.tv_usec));
            if(min > diff)
                min=diff;

        }
        fprintf(stdout, "Routine took %ld microseconds\n",min);
        fwrite(newImage, 512*sizeof(int),512,outFile);
        fclose(fgFile);
        fclose(bgFile);
        fclose(outFile);
        return 0;
    }
    fprintf(stderr, "Problem opening a file\n");
    return 2;
}

