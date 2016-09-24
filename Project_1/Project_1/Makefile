CC = gcc
CFLAGS = -c -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8 -ftree-vectorize -ffast-math -fsingle-precision-constant -O3
all: sg  geometry_list.s

sg: main.o geometry.o CMAN_coords.o
	$(CC) main.o geometry.o CMAN_coords.o -lrt -lm -o $@

geometry_list.s: geometry.c
	$(CC) -Wa,-adhln -g geometry.c -c > geometry_list.s

clean:
	rm -f *.o sg *.s
