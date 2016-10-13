CC = gcc

CFLAGS = -g -Wall -Wextra -lrt -fforward-propagate -mfpu=neon -march=armv7-a -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8 -ftree-vectorize -ffast-math -fsingle-precision-constant -fmodulo-sched -fmodulo-sched-allow-regmoves -fgcse-las -fgcse-after-reload -fwhole-program -funsafe-math-optimizations -freciprocal-math -O -O1 -O2 -O3 -ftree-vectorizer-verbose=7
SOURCES=$(wildcard ./*.c)
OBJECTS=$(subst src,obj,$(SOURCES:.c=.o))

BIN = ./alpha.out


all:$(BIN) alpha_time.s

$(BIN): $(OBJECTS)
	@echo $(info [${OBJECTS}])
	$(CC) -g $(CFLAGS) -o $(BIN) $(OBJECTS)

alpha_time.s: alpha_time.c
	$(CC) -Wa,-adhln -g $< -c > $@

$(OBJECTS): %.o : %.c
	$(CC) -g $(CFLAGS) -c $< -o $@

clean:
	rm -f $(BIN) *.o *.s
