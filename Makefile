# Makefile for B compiler

CC = gcc
CFLAGS = -std=c99 -Wall -Wextra -O2
TARGET = bcc
SOURCES = src/util.c src/lexer.c src/parser.c src/sem.c src/arena.c src/emitter.c src/main.c
OBJECTS = $(SOURCES:.c=.o)
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

# Runtime library
LIBB_SRC = lib/libb.c
LIBB_HDR = lib/libb.h

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS) -lm

%.o: %.c src/bcc.h
	$(CC) $(CFLAGS) -c $< -o $@

# Test that libb compiles (for development)
test-libb: $(LIBB_SRC) $(LIBB_HDR)
	$(CC) $(CFLAGS) -c -I lib $(LIBB_SRC) -o /tmp/libb_test.o
	rm -f /tmp/libb_test.o
	@echo "libb compiles successfully"

clean:
	rm -f $(TARGET) $(OBJECTS) src/*.o parser_part.c emitter_part.c main_part.c
	rm -f /tmp/bcc_libb_*.o

install: $(TARGET)
	install -d $(BINDIR)
	install -m 755 $(TARGET) $(BINDIR)/$(TARGET)

.PHONY: all clean test-libb install

.PHONY: all clean test-libb
