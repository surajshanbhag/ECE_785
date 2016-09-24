#include "geometry.h"
#include <math.h>
#include <string.h>
#include "sincos.c"
#define PI 3.14159265f
#define PI_OVER_180 (0.017453293) // (3.1415927/180.0)

extern const PT_T waypoints[];


#define CALC_DIST (0)

#if 1 // Table holds precalculated sin/cos for p2. Table Lat/Lon values are in radians
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
    // calculates distance in kilometers between locations (represented in radians)

    return acosFunc(p1->SinLat * p2->SinLat + 
            p1->CosLat * p2->CosLat*
            cosFunc(p2->Lon - p1->Lon)); // * 6371;
}
float Calc_Bearing( PT_T * p1,  const PT_T * p2){
    // calculates bearing in degrees between locations (represented in degrees)	
    float term1=0.0, term2=0.0;
    float angle=0.0;

    term1 = sineFunc(p1->Lon - p2->Lon)*p2->CosLat;
    term2 = p1->CosLat*p2->SinLat - 
        p1->SinLat*p2->CosLat*cosFunc(p1->Lon - p2->Lon);
    angle = atan2Func(term1, term2) * (180/PI);
    if (angle < 0.0)
        angle += 360;
    return angle;
}

float Calc_Closeness( PT_T * p1,  const PT_T * p2) { 
    // calculates closeness (decreases as distance increases) of locations

    return p1->SinLat * p2->SinLat + 
        p1->CosLat * p2->CosLat*
        cosFunc(p2->Lon - p1->Lon);
}

#endif


void Find_Nearest_Waypoint(float cur_pos_lat, float cur_pos_lon, float * distance, float * bearing, 
        char  * * name) {
    // cur_pos_lat and cur_pos_lon are in degrees
    // distance is in kilometers
    // bearing is in degrees

    int i=0, closest_i=0;
    PT_T ref;
    float d=0.0, b=0.0, c=0.0, closest_d=1E10, max_c=0;

    *distance = 0;
    *bearing = 0;
    *name = '\0';

    ref.Lat = cur_pos_lat;
    ref.Lon = cur_pos_lon;
    ref.SinLat = sineFunc(cur_pos_lat);
    ref.CosLat = cosFunc(cur_pos_lat);

    strcpy(ref.Name, "Reference");

    while (strcmp(waypoints[i].Name, "END")) {
#if CALC_DIST
        getchar();
        d = Calc_Distance(&ref, &(waypoints[i]) );
        // b = Calc_Bearing(&ref, &(waypoints[i]) ); // Deletable!
        // if we found a closer waypoint, remember it and display it
        getchar();
        if (d<closest_d) {
            closest_d = d;
            closest_i = i;
        }
#else
        c = Calc_Closeness(&ref, &(waypoints[i]) );
        //printf("\n%d,%f",i,c);
        if (c>max_c) {
            max_c = c;
            closest_i = i;
        }
#endif
        i++;
    }

    // Finish calcuations for the closest point
#if CALC_DIST
#if 0
    d = Calc_Distance(&ref, &(waypoints[closest_i]) );
#else
    d = closest_d; // optimization
#endif
    b = Calc_Bearing(&ref, &(waypoints[closest_i]) ); 
#else
    d = acosf(max_c)*6371; // finish distance calcuation
    b = Calc_Bearing(&ref, &(waypoints[closest_i]) );
#endif	
    // return information to calling function about closest waypoint 
    *distance = d;
    *bearing = b;
    *name = (char * ) (waypoints[closest_i].Name);
}
