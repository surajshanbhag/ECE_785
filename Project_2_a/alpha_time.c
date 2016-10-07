void alphaBlend_c(int *fgImage, int *bgImage, int *dstImage);

#include <stdio.h>
#include <sys/time.h>
#include <time.h>

int backImage[512 * 512];
int foreImage[512 * 512];
int newImage[512 * 512];

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
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
        gettimeofday(&newTv, NULL);

        clock_gettime(CLOCK_MONOTONIC, &start);
        alphaBlend_c(&foreImage[0], &backImage[0], &newImage[0]);
        clock_gettime(CLOCK_MONOTONIC, &end);

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

#define A(x) (((x) & 0xff000000) >> 24)
#define R(x) (((x) & 0x00ff0000) >> 16)
#define G(x) (((x) & 0x0000ff00) >> 8)
#define B(x) ((x) & 0x000000ff)

void alphaBlend_c(int *fgImage, int *bgImage, int *dstImage)
{
    int x, y;
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
