CC = gcc

#CFLAGS = -Wall -Wextra -lrt #-march=armv7-a -mfloat-abi=hard -mcpu=cortex-a8 -mtune=cortex-a8

SOURCES=$(wildcard ./*.c)
OBJECTS=$(subst src,obj,$(SOURCES:.c=.o))

BIN = ./alpha.out


all:$(BIN)

$(BIN): $(OBJECTS)
	@echo $(info [${OBJECTS}])
	$(CC) -g $(CFLAGS) -o $(BIN) $(OBJECTS)

$(OBJECTS): %.o : %.c
	$(CC) -g $(CFLAGS) -c $< -o $@

clean:
	rm -f $(BIN) *.o 
