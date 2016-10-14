#include <stdio.h>
#include <sys/time.h>
int backImage[512 * 512];
int foreImage[512 * 512];
int newImage[512 * 512];
#define A(x) (((x) & 0xff000000) >> 24)
#define R(x) (((x) & 0x00ff0000) >> 16)
#define G(x) (((x) & 0x0000ff00) >> 8)
#define B(x) ((x) & 0x000000ff)

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
