CC = gcc
CFLAGS = -c -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8 -O3 -ggdb -ffast-math -fsingle-precision-constant -fno-tree-loop-vectorize -fno-tree-vectorize -fno-unroll-loops

test: main.o
	$(CC) main.o -pg -g -static -lrt -lm -o $@

main_list.s: main.c
	$(CC) $(CFLAGS) -Wa,-adhln -g main.c -c > main_list.s

clean:
	rm -f test *.o  *.s
