CC = gcc 
CFLAGS = -c -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8 -O3 -mword-relocations -ftree-vectorize -ffast-math -fsingle-precision-constant
#CFLAGS = -c -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8 -O3 -mneon-for-64bits
all: mandelbrot.out mandelbrot.s

mandelbrot.out:mandelbrot.o
	$(CC) mandelbrot.o -lrt -lm -o $@

mandelbrot.s: mandelbrot.c
	$(CC) -Wa,-adhln -g mandelbrot.c -c > mandelbrot.s

clean:
	rm -f *.o 
	rm -f mandelbrot.out
	rm -f *~
