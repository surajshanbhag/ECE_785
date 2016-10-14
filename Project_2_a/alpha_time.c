#include <stdio.h>
#include <sys/time.h>
int backImage[512 * 512];
int foreImage[512 * 512];
int newImage[512 * 512];
#define A(x) (((x) & 0xff000000) >> 24)
#define R(x) (((x) & 0x00ff0000) >> 16)
#define G(x) (((x) & 0x0000ff00) >> 8)
#define B(x) ((x) & 0x000000ff)

#if macro == 11
void alphaBlend_c(unsigned char *__restrict fgImage,unsigned char *__restrict bgImage,unsigned char *__restrict dstImage)
//void alphaBlend_c(int *__restrict fgImage, int *__restrict bgImage, int *__restrict dstImage)
{
    int index;
    int dst_r[4],dst_g[4],dst_b[4]; 
    int r_fg[4],g_fg[4],b_fg[4]; 
    int r_bg[4],g_bg[4],b_bg[4]; 
    int a_fg[4];
    int temp1,temp2;
    printf("11");
//#pragma vector aligned
    for(index = 0; index < 512*512*8/4 ;index=index+16){
        a_fg[0] = A(fgImage[index]);
        a_fg[1] = A(fgImage[index+1]);
        a_fg[2] = A(fgImage[index+2]);
        a_fg[3] = A(fgImage[index+3]);

        r_fg[0] = R(fgImage[index]);
        r_fg[1] = R(fgImage[index+1]);
        r_fg[2] = R(fgImage[index+2]);
        r_fg[3] = R(fgImage[index+3]);

        g_fg[0] = G(fgImage[index]);
        g_fg[1] = G(fgImage[index+1]);
        g_fg[2] = G(fgImage[index+2]);
        g_fg[3] = G(fgImage[index+3]);

        b_fg[0] = B(fgImage[index]);
        b_fg[1] = B(fgImage[index+1]);
        b_fg[2] = B(fgImage[index+2]);
        b_fg[3] = B(fgImage[index+3]);

        r_bg[0] = R(bgImage[index]);
        r_bg[1] = R(bgImage[index+1]);
        r_bg[2] = R(bgImage[index+2]);
        r_bg[3] = R(bgImage[index+3]);

        g_bg[0] = G(bgImage[index]);
        g_bg[1] = G(bgImage[index+1]);
        g_bg[2] = G(bgImage[index+2]);
        g_bg[3] = G(bgImage[index+3]);

        b_bg[0] = B(bgImage[index]);
        b_bg[1] = B(bgImage[index+1]);
        b_bg[2] = B(bgImage[index+2]);
        b_bg[3] = B(bgImage[index+3]);

        dst_r[0] = ( (r_fg[0] * a_fg[0]) +(r_bg[0]*(255-a_fg[0])) )>>8;
        dst_r[1] = ( (r_fg[1] * a_fg[1]) +(r_bg[1]*(255-a_fg[1])) )>>8;
        dst_r[2] = ( (r_fg[2] * a_fg[2]) +(r_bg[2]*(255-a_fg[2])) )>>8;
        dst_r[3] = ( (r_fg[3] * a_fg[3]) +(r_bg[3]*(255-a_fg[3])) )>>8;

        dst_g[0] = ( (g_fg[0] * a_fg[0]) +(g_bg[0]*(255-a_fg[0])) )>>8;
        dst_g[1] = ( (g_fg[1] * a_fg[1]) +(g_bg[1]*(255-a_fg[1])) )>>8;
        dst_g[2] = ( (g_fg[2] * a_fg[2]) +(g_bg[2]*(255-a_fg[2])) )>>8;
        dst_g[3] = ( (g_fg[3] * a_fg[3]) +(g_bg[3]*(255-a_fg[3])) )>>8;

        dst_b[0] = ( (b_fg[0] * a_fg[0]) +(b_bg[0]*(255-a_fg[0])) )>>8;
        dst_b[1] = ( (b_fg[1] * a_fg[1]) +(b_bg[1]*(255-a_fg[1])) )>>8;
        dst_b[2] = ( (b_fg[2] * a_fg[2]) +(b_bg[2]*(255-a_fg[2])) )>>8;
        dst_b[3] = ( (b_fg[3] * a_fg[3]) +(b_bg[3]*(255-a_fg[3])) )>>8;

        dstImage[index] =  0xff;
        dstImage[index+1] =  0xff;
        dstImage[index+2] =  0xff;
        dstImage[index+3] =  0xff;

        dstImage[index] =  (0x000000ff & dst_b[0]);
        dstImage[index+1] =  (0x000000ff & dst_b[1]);
        dstImage[index+2] = (0x000000ff & dst_b[2]);
        dstImage[index+3] =  (0x000000ff & dst_b[3]);

        dstImage[index] =  (0x0000ff00 & (dst_g[0]<<8) );
        dstImage[index+1] =  (0x0000ff00 & (dst_g[1]<<8) );
        dstImage[index+2] = (0x0000ff00 & (dst_g[2]<<8) );
        dstImage[index+3] =  (0x0000ff00 & (dst_g[3]<<8) );

        dstImage[index] =  (0x00ff0000 & (dst_r[0]<<16) );
        dstImage[index+1] =  (0x00ff0000 & (dst_r[1]<<16) );
        dstImage[index+2] = (0x00ff0000 & (dst_r[2]<<16) );
        dstImage[index+3] =  (0x00ff0000 & (dst_r[3]<<16) );
    }
}
#endif
#if macro == 10
void alphaBlend_c(unsigned char *__restrict fgImage,unsigned char *__restrict bgImage,unsigned char *__restrict dstImage)
{
    int index;
    int a_fg,dst_r,dst_g,dst_b; 
    int temp1,temp2;
    printf("2");
#pragma vector aligned
    for(index = 0; index < 512*512; index++){
        dstImage[index] =  0xff;
        a_fg = fgImage[index];
        temp1 = (fgImage[index+1] * a_fg);
        temp2 = (bgImage[index+1] * (255-a_fg));
        dst_r = ( temp1 + temp2 )>>8;
        dstImage[index+1] =  (0x000000ff & dst_r);
        temp1 = (fgImage[index+2] * a_fg);
        temp2 = (bgImage[index+2] * (255-a_fg));
        dst_g = ( temp1 + temp2 )>>8;
        dstImage[index+2] =  (0x000000ff & dst_g);
        temp1 = (fgImage[index+3] * a_fg);
        temp2 = (bgImage[index+3] * (255-a_fg));
        dst_b = ( temp1 + temp2 )>>8;
        dstImage[index+3] =  (0x000000ff & dst_b);
    }
}
#endif
#if macro == 9
void alphaBlend_c(unsigned char *__restrict fgImage,unsigned char *__restrict bgImage,unsigned char *__restrict dstImage)
{
    int index;
    int a_fg,dst_r,dst_g,dst_b; 
    int temp;
    printf("2");
#pragma vector aligned

    for(index = 0; index < 512*512; index++){
        a_fg = fgImage[index];
        dst_r = ((fgImage[index+1] * a_fg) + (bgImage[index+1] * (255-a_fg)))>>8;
        dst_g = ((fgImage[index+2] * a_fg) + (bgImage[index+2] * (255-a_fg)))>>8;
        dst_b = ((fgImage[index+3] * a_fg) + (bgImage[index+3] * (255-a_fg)))>>8;
        dstImage[index] =  0xff;
        dstImage[index+1] =  (0x000000ff & dst_r);
        dstImage[index+2] =  (0x000000ff & dst_g);
        dstImage[index+3] =  (0x000000ff & dst_b);
    }
}
#endif
#if macro == 8
void alphaBlend_c(int *__restrict fgImage, int *__restrict bgImage, int *__restrict dstImage)
{
    int index;
    int a_fg,dst_r,dst_g,dst_b; 
    printf("2");
    for(index = 0; index < 512*512; index++){
        a_fg = A(fgImage[index]);
        dst_r = ((R(fgImage[index]) * a_fg) + (R(bgImage[index]) * (255-a_fg)))>>8;
        dst_g = ((G(fgImage[index]) * a_fg) + (G(bgImage[index]) * (255-a_fg)))>>8;
        dst_b = ((B(fgImage[index]) * a_fg) + (B(bgImage[index]) * (255-a_fg)))>>8;
        dstImage[index] =  0xff000000 |
            (0x00ff0000 & (dst_r << 16)) |
            (0x0000ff00 & (dst_g << 8)) |
            (0x000000ff & (dst_b));
    }
}

#endif
#if macro == 7
void alphaBlend_c(void)
{
    int y;
    short f_a[512*512];
    short f_r[512*512];
    short f_g[512*512];
    short f_b[512*512];
    short b_r[512*512];
    short b_g[512*512];
    short b_b[512*512];
    for(y = 0; y < 512*512; y++){
        f_a[y] = A(foreImage[y]);
    }
    for(y = 0; y < 512*512; y++){
        f_r[y] = R(foreImage[y]);
    }
    for(y = 0; y < 512*512; y++){
        f_g[y] = G(foreImage[y]);
    }
    for(y = 0; y < 512*512; y++){
        f_b[y] = B(foreImage[y]);
    }
    for(y = 0; y < 512*512; y++){
        b_r[y] = R(backImage[y]);
        b_g[y] = G(backImage[y]);
        b_b[y] = B(backImage[y]);
    }
    for(y = 0; y < 512*512; y++){
        newImage[y] = 0xff000000;
    }
    for(y = 0; y < 512*512; y++){
        newImage[y] |= ((f_a[y]*(f_r[y]-b_r[y])+b_r[y]*255)/256)>>16;
        newImage[y] |= ((f_a[y]*(f_g[y]-b_g[y])+b_g[y]*255)/256)>>8;
        newImage[y] |= ((f_a[y]*(f_b[y]-b_b[y])+b_b[y]*255)/256);
    }
/*
    for(y = 0; y < 512*512; y++){
        dst_r[y] = ((R(foreImage[y]) * a_fg[y]) + (R(backImage[y]) * (255-a_fg[y])))/256;
    }
    for(y = 0; y < 512*512; y++){
        dst_g[y] = ((G(foreImage[y]) * a_fg[y]) + (R(backImage[y]) * (255-a_fg[y])))/256;
    }
    for(y = 0; y < 512*512; y++){
        dst_b[y] = ((B(foreImage[y]) * a_fg[y]) + (R(backImage[y]) * (255-a_fg[y])))/256;
    }
    for(y = 0; y < 512*512; y++){
        dstImage[y] =  0xff000000 |
            (0x00ff0000 & (dst_r[y] << 16)) |
            (0x0000ff00 & (dst_g[y] << 8)) |
            (0x000000ff & (dst_b[y]));
    }*/
}
#endif

#if macro == 6
void alphaBlend_c(void)
{
    int index;
    int dst_r,dst_g,dst_b; 
    int r_fg,g_fg,b_fg,r_bg,g_bg,b_bg;
    int a_fg[512*512];
    printf("4");
    for(index = 0; index < 512*512; index++){
        a_fg[index] = ((unsigned char *)(&foreImage[index]))[0];
        r_fg = ((unsigned char *)(&foreImage[index]))[1];
        r_bg = ((unsigned char *)(&backImage[index]))[0];
        dst_r = ((r_fg * a_fg[index]) + (r_bg * (255-a_fg[index])))/256;
        newImage[index] =  0xff000000 | (0x00ff0000 & (dst_r << 16));
    }
    for(index = 0; index < 512*512; index++){
        g_fg = ((unsigned char *)(&foreImage[index]))[2];
        g_bg = ((unsigned char *)(&backImage[index]))[1];
        dst_g = ((g_fg * a_fg[index]) + (g_bg * (255-a_fg[index])))/256;
        newImage[index] |= (0x0000ff00 & (dst_g << 8));
    }
    for(index = 0; index < 512*512; index++){
        b_fg = ((unsigned char *)(&foreImage[index]))[3];
        b_bg = ((unsigned char *)(&backImage[index]))[2];
        dst_b = ((b_fg * a_fg[index]) + (b_bg * (255-a_fg[index])))/256;
        newImage[index] |= (0x000000ff & (dst_b));
    }
}
#endif
#if macro == 5
void alphaBlend_c(void)
{
    int index;
    int a_fg,dst_r,dst_g,dst_b; 
    int r_fg,g_fg,b_fg,r_bg,g_bg,b_bg;
    printf("4");
    for(index = 0; index < 512*512; index++){
        a_fg = ((unsigned char *)(&foreImage[index]))[0];
        r_fg = ((unsigned char *)(&foreImage[index]))[1];
        g_fg = ((unsigned char *)(&foreImage[index]))[2];
        b_fg = ((unsigned char *)(&foreImage[index]))[3];
        r_bg = ((unsigned char *)(&backImage[index]))[0];
        g_bg = ((unsigned char *)(&backImage[index]))[1];
        b_bg = ((unsigned char *)(&backImage[index]))[2];
        dst_r = ((r_fg * a_fg) + (r_bg * (255-a_fg)))/256;
        dst_g = ((g_fg * a_fg) + (g_bg * (255-a_fg)))/256;
        dst_b = ((b_fg * a_fg) + (b_bg * (255-a_fg)))/256;
        newImage[index] =  0xff000000 |
            (0x00ff0000 & (dst_r << 16)) |
            (0x0000ff00 & (dst_g << 8)) |
            (0x000000ff & (dst_b));
    }
}
#endif
#if macro == 4
void alphaBlend_c(void)
{
    int index;
    int a_fg,dst_r,dst_g,dst_b; 
    int r_fg,g_fg,b_fg,r_bg,g_bg,b_bg;
    printf("4");
    for(index = 0; index < 512*512; index++){
        a_fg = A(foreImage[index]);
        r_fg = R(foreImage[index]);
        b_fg = G(foreImage[index]);
        g_fg = B(foreImage[index]);
        r_bg = R(backImage[index]);
        b_bg = G(backImage[index]);
        g_bg = B(backImage[index]);
        dst_r = ((r_fg * a_fg) + (r_bg * (255-a_fg)))/256;
        dst_g = ((g_fg * a_fg) + (g_bg * (255-a_fg)))/256;
        dst_b = ((b_fg * a_fg) + (b_bg * (255-a_fg)))/256;
        newImage[index] =  0xff000000 |
            (0x00ff0000 & (dst_r << 16)) |
            (0x0000ff00 & (dst_g << 8)) |
            (0x000000ff & (dst_b));
    }
}
#endif
#if macro == 3
void alphaBlend_c(void)
{
    int index;
    int a_fg,dst_r,dst_g,dst_b; 
    printf("3");
    for(index = 0; index < 512*512; index++){
        a_fg = A(foreImage[index]);
        dst_r = ((R(foreImage[index]) * a_fg) + (R(backImage[index]) * (255-a_fg)))/256;
        dst_g = ((G(foreImage[index]) * a_fg) + (G(backImage[index]) * (255-a_fg)))/256;
        dst_b = ((B(foreImage[index]) * a_fg) + (B(backImage[index]) * (255-a_fg)))/256;
        newImage[index] =  0xff000000 |
            (0x00ff0000 & (dst_r << 16)) |
            (0x0000ff00 & (dst_g << 8)) |
            (0x000000ff & (dst_b));
    }
}
#endif
#if macro == 2
void alphaBlend_c(int *__restrict fgImage, int *__restrict bgImage, int *__restrict dstImage)
{
    int index;
    int a_fg,dst_r,dst_g,dst_b; 
    printf("2");
    for(index = 0; index < 512*512; index++){
        a_fg = A(fgImage[index]);
        dst_r = ((R(fgImage[index]) * a_fg) + (R(bgImage[index]) * (255-a_fg)))/256;
        dst_g = ((G(fgImage[index]) * a_fg) + (G(bgImage[index]) * (255-a_fg)))/256;
        dst_b = ((B(fgImage[index]) * a_fg) + (B(bgImage[index]) * (255-a_fg)))/256;
        dstImage[index] =  0xff000000 |
            (0x00ff0000 & (dst_r << 16)) |
            (0x0000ff00 & (dst_g << 8)) |
            (0x000000ff & (dst_b));
    }
}
#endif
#if macro == 1
void alphaBlend_c(int *__restrict fgImage, int *__restrict bgImage, int *__restrict dstImage)
{
    int x, y;
    int a_fg,dst_r,dst_g,dst_b; 
    printf("1");
    for(y = 0; y < 512; y++){
        for(x = 0; x < 512; x++){
            a_fg = A(fgImage[(y*512)+x]);
            dst_r = ((R(fgImage[(y*512)+x]) * a_fg) + (R(bgImage[(y*512)+x]) * (255-a_fg)))/256;
            dst_g = ((G(fgImage[(y*512)+x]) * a_fg) + (G(bgImage[(y*512)+x]) * (255-a_fg)))/256;
            dst_b = ((B(fgImage[(y*512)+x]) * a_fg) + (B(bgImage[(y*512)+x]) * (255-a_fg)))/256;
            dstImage[(y*512)+x] =  0xff000000 |
                (0x00ff0000 & (dst_r << 16)) |
                (0x0000ff00 & (dst_g << 8)) |
                (0x000000ff & (dst_b));
        }
    }
}
#endif
#if macro == 0
void alphaBlend_c(int *fgImage, int *bgImage, int *dstImage)
{
    int x, y;
    printf("0");
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
    }
}
#endif
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
#if macro == 0
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
#elif macro == 1
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
#elif macro == 2
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
#elif macro == 8
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
#elif macro == 11
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
#elif macro == 9
        alphaBlend_c((unsigned char*)&foreImage[0], (unsigned char*)&backImage[0], (unsigned char*)&newImage[0]);
#elif macro == 10
        alphaBlend_c((unsigned char*)&foreImage[0], (unsigned char*)&backImage[0], (unsigned char*)&newImage[0]);
#elif macro >= 3
        alphaBlend_c();
#endif
        gettimeofday(&newTv, NULL);
        fprintf(stdout, "Routine took %ld microseconds\n", (long)((newTv.tv_sec-oldTv.tv_sec)*1000000+(newTv.tv_usec - oldTv.tv_usec)));
        fwrite(newImage, 512*sizeof(int),512,outFile);
        fclose(fgFile);
        fclose(bgFile);
        fclose(outFile);
        return 0;
    }
    fprintf(stderr, "Problem opening a file\n");
    return 2;
}
