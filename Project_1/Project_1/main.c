/*----------------------------------------------------------------------------
 *----------------------------------------------------------------------------*/
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include "geometry.h"

#define TEST1_LAT (45.0)
#define TEST1_LON (79.0)

#define N_TESTS (1000)
#define PI (3.141592653589793)
/*----------------------------------------------------------------------------
  MAIN function
 *----------------------------------------------------------------------------*/
int main (int argc,char* argv[]) {
    float dist, bearing, cur_pos_lat, cur_pos_lon;
    char * name;
    struct timespec start, end;
    unsigned long diff, total=0, min=1234567890;
    int t=0,n=0;


    //cur_pos_lat = TEST1_LAT;
    //cur_pos_lon = TEST1_LON;


    cur_pos_lat = atof(argv[1]);
    cur_pos_lon = atof(argv[2]);

    for (n=0; n<N_TESTS; n++) {
        clock_gettime(CLOCK_MONOTONIC, &start);
        Find_Nearest_Waypoint(cur_pos_lat, cur_pos_lon,
                &dist, &bearing, &name);
        clock_gettime(CLOCK_MONOTONIC, &end);
        /* printf("Closest waypoint is %s. %f km away at bearing %f degrees\n",
           name, dist, bearing);
           */
        diff = 1000000000 * (end.tv_sec - start.tv_sec) +
            end.tv_nsec - start.tv_nsec;
        //	  printf("%2d: %8lu ns\n", n, diff);
        total += diff;
        if (diff < min)
            min = diff;
    }
    printf("%2.2f;%2.2f;",cur_pos_lat,cur_pos_lon);
    printf("%6.10lf;%5.10lf;%s;",dist,bearing,name);
    printf("%5.4lf;%9ld;", total/(1000.0*N_TESTS),(total/N_TESTS));
    printf("%5.4lf;%9ld\n",  min/1000.0,min);

/* Using data as degrees and changing to radians*/

    cur_pos_lat = atof(argv[1])*PI/180;
    cur_pos_lon = atof(argv[2])*PI/180;

    for (n=0; n<N_TESTS; n++) {
        clock_gettime(CLOCK_MONOTONIC, &start);
        Find_Nearest_Waypoint(cur_pos_lat, cur_pos_lon,
                &dist, &bearing, &name);
        clock_gettime(CLOCK_MONOTONIC, &end);
        /* printf("Closest waypoint is %s. %f km away at bearing %f degrees\n",
           name, dist, bearing);
           */
        diff = 1000000000 * (end.tv_sec - start.tv_sec) +
            end.tv_nsec - start.tv_nsec;
        //	  printf("%2d: %8lu ns\n", n, diff);
        total += diff;
        if (diff < min)
            min = diff;
    }
    printf("%2.2f;%2.2f;",cur_pos_lat,cur_pos_lon);
    printf("%6.10f;%5.10f;%s;",dist,bearing,name);
    printf("%5.4f;%9ld;", total/(1000.0*N_TESTS),(total/N_TESTS));
    printf("%5.4f;%9ld\n",  min/1000.0,min);
    exit(0);
}

