CC = gcc

CFLAGS = -g -Wall -Wextra -lrt -fforward-propagate -mfpu=neon -march=armv7-a -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8 -ffast-math -fsingle-precision-constant -fmodulo-sched -fmodulo-sched-allow-regmoves -fgcse-las -fgcse-after-reload -fwhole-program -funsafe-math-optimizations -fopt-info-vec-missed $(MACROS) -ftree-vectorize -ftree-vectorizer-verbose=7 -O3 
#CFLAGS = -g -Wall -Wextra -lrt -mfpu=neon -march=armv7-a -mcpu=cortex-a8 -mtune=cortex-a8 -ftree-vectorize -ftree-vectorizer-verbose=8 -O3
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
