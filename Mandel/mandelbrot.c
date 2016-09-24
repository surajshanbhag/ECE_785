/*
  @file: mandelbrot.c
  @author: Udai Muhammed (ufmuhamm)
  @description: a program that draws ASCII art work that represent Mandelbrot fractal (Second degree). 
  the user provide the minimum real domain and minimum imaginary domain, and the size of the side of the square where we will plot the fractal

*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <time.h>

#define WIDTH  (256)
#define HEIGHT (256)

// a scaling up factor for the double values to get more digits after the floating point
#define resol  (1000000000.0)

/* contrast will make gradual change in gray-scale more clear
 * the bigger the contrast the more clear the edges will become 
 */
#define CONTRAST (1)

// the gray-scale goes from 0-255 , but we stop iteration at 255/contrast
#define limit ( 255/CONTRAST )

#define N_TESTS (1)

//Global variables 

// the long integer value of the scaled up regular 
long minReal_int,minImag_int,size_int;  

/* this is the original color mapping 
 *  R    G    B
 *  66   30   15  # brown 3
 *  25   7    26  # dark violett
 *   9   1    47  # darkest blue
 *   4   4    73  # blue 5
 *   0   7    100 # blue 4
 *  12   44   138 # blue 3
 *  24   82   177 # blue 2
 *  57   125  209 # blue 1
 *  134  181  229 # blue 0
 *  211  236  248 # lightest blue
 *  241  233  191 # lightest yellow
 *  248  201  95  # light yellow
 *  255  170  0   # dirty yellow
 *  204  128  0   # brown 0
 *  153  87   0   # brown 1
 *  106  52   3   # brown 2
 */

int color_map[16][3] ={
  {0, 0, 0},
  {12, 7, 36},
  {9, 1, 47},
  {4, 4, 73},
  {0, 7, 100},
  {12, 44, 138},
  {24, 82, 177},
  {57, 125, 209},
  {134, 181, 229},
  {211, 236, 248},
  {241, 233, 191},
  {248, 201, 95},
  {255, 170, 0},
  {204, 128, 0},
  {153, 87, 0},
  {0, 2, 3}
};


void saveImage( unsigned char ***image, FILE *outputFile , unsigned char color)
{
  // A Function that will take an array and save its components as pgm image file
  
  register int i,j;
  // necessary header for the pgm file 
  fprintf(outputFile,"P3\n");
  fprintf(outputFile,"%d %d\n",WIDTH,HEIGHT);
  fprintf(outputFile,"%d\n",color);

  // just spit out the rows of the array one after one into the pgm file.
  for(j=0;j<HEIGHT;j++) 
    {
      for(i=0;i<WIDTH-1;i++)    
	fprintf(outputFile,"%d %d %d ",image[i][j][0],image[i][j][1],image[i][j][2]);
      fprintf(outputFile,"%d %d %d\n",image[WIDTH-1][j][0],image[WIDTH-1][j][1],image[WIDTH-1][j][2]);
    }
  
}

//a function to retrun the number of iteration needed to either go of limit or for the point to diverge
unsigned int testPoint( long cReal, long cImag )
{
  unsigned int dwell =0 ;
  long double zReal_t,zImag_t, mag =0; // magnitude 
  long zReal,zImag;
  
  zReal = cReal;
  zImag = cImag;

  while (1) {
    // Z = Z^2 + C
   
    zReal_t = zReal/resol* zReal/resol -  zImag/resol * zImag/resol + cReal/resol;
    zImag_t = 2*zImag/resol*zReal/resol  + cImag/resol;
   
    mag = zReal_t * zReal_t + zImag_t *zImag_t;
    if (mag > (long double) 4.0  || dwell >= limit ) {
      break;
    }
    zReal = zReal_t * resol; 
    zImag = zImag_t * resol; 

    dwell++;
  }
  // contrast*dwell, will generate a gray-scle depending on the iteration number
  // the multiplication with contrast will make the gray-scale color more distinct for areas next to each other 
  // 255-color will just invert the gray-scale color for the whole image so we make white dominante
  // get artistic with the coloring scheme here
  return dwell;//CONTRAST*dwell;

}



// A function to iterate on all the points of the canvus and drawing the right letter
void drawFigure(unsigned char ***image, double minReal, double  minImag, double size )
{

  //iterate over all the points and draw them 
  unsigned char dwell;
  long cReal_int , cImag_int ;
  long i,j;
 
  // converting the double value to long int after scaling it up by resol (resolution)
  minReal_int = (long) resol * minReal;
  minImag_int = (long) resol * minImag;
  size_int = (long) resol * size ;

  for (j=0; j < WIDTH ; j++)    {
    //calculate the Imag part
    cImag_int  = minImag_int +  size_int *  ((float) (WIDTH-1) - j) /(float)(WIDTH-1) ;
    for (i=0 ; i < HEIGHT ; i++) {
      //calculate the Real part
      cReal_int = minReal_int+ size_int *  i / (float) (HEIGHT -1) ;
      dwell = testPoint(cReal_int,cImag_int);
      int mod = (dwell) %16;
      image[i][j][0] = color_map[mod][0];//(short) 200 + dwell ;
      image[i][j][1] = color_map[mod][1];//(short) 50 +  dwell  ; //log2(sqrt(cReal_int*cReal_int + cImag_int*cImag_int)) ;
      image[i][j][2] = color_map[mod][2];//(short) 10 +  dwell  ;//sqrt(cReal_int*cReal_int + cImag_int*cImag_int);
      
    }
  }
}


int main () {
  struct timespec start, end;
  long int diff=0;
  clock_gettime(CLOCK_MONOTONIC, &start); 
  double minReal,minImag,size;
  unsigned char ***image;
  unsigned short i,j;
  FILE *outf;

  /*  printf("Minimum real: ");
   *  flag = scanf("%lf",&minReal);
   *  if (!flag) {
   *    printf("Invalid input\n");
   *    return -1 ;
   *  }
   * 
   *  printf("Minimum imaginary: ");
   *  flag = scanf("%lf",&minImag);
   *  if (!flag) {
   *    printf("Invalid input\n");
   *    return -1 ;
   *  }
   *  
   *  printf("Size: ");
   *  flag = scanf("%lf",&size);
   *  if (!flag) {
   *    printf("Invalid input\n");
   *    return -1 ;
   *  }
   */

  minReal = -1.6;
  minImag = -.45;
  size = .9 ; 
  
    // Computation begins --------------------------------------
    outf =fopen("Mandelbrot.pgm","w");
    image = malloc(HEIGHT * sizeof(char **));
    for(i=0; i < HEIGHT; i++)
      image[i] = malloc(WIDTH * sizeof(char *));
  
    for(i=0; i< HEIGHT; i++)
      for(j=0; j < WIDTH; j++)
	image[i][j] = malloc( 3 * sizeof(unsigned char));

    drawFigure(image,minReal,minImag,size);
    saveImage(image,outf,255);
    fclose(outf);
    // Computation ends --------------------------------------
    clock_gettime(CLOCK_MONOTONIC, &end);
    diff = 1000000 * (end.tv_sec - start.tv_sec) +
         +      (end.tv_nsec - start.tv_nsec)/1000;
    printf("%ld\n",diff);
  exit(0);
}
