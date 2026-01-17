# Makefile for B compiler

CC = gcc
CFLAGS = -std=c99 -Wall -Wextra -O2
TARGET = bcc
SOURCES = src/util.c src/lexer.c src/parser.c src/sem.c src/arena.c src/emitter.c src/main.c
OBJECTS = $(SOURCES:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS)

%.o: %.c src/bcc.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) $(OBJECTS) src/*.o parser_part.c emitter_part.c main_part.c

.PHONY: all clean

