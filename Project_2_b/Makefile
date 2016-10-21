CC = gcc
CFLAGS = -c -Wall -march=armv7-a -mfpu=neon -mcpu=cortex-a8 -mtune=cortex-a8 -O3 -ffast-math -fsingle-precision-constant -fno-tree-loop-vectorize -fno-tree-vectorize -fno-unroll-loops
#CFLAGS = -c -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8 -O3 -ggdb -ffast-math -fsingle-precision-constant -fno-tree-loop-vectorize -fno-tree-vectorize -fno-unroll-loops

all: alpha_time.o alpha_time.s
	$(CC) alpha_time.o -pg -g -static -lrt -lm -o alpha_time

alpha_time.s: alpha_time.c
	$(CC) $(CFLAGS) -S alpha_time.c -o $@

alpha_time_list.s: alpha_time.c
	$(CC) $(CFLAGS) -Wa,-adhln -g alpha_time.c -c > alpha_time_list.s

out.out: alpha_time.s
	$(CC) alpha_time.s -pg -g -static -lrt -lm -o $@

clean:
	rm -f test *.o  *.s out.out
