CC ?= gcc
AS ?= as
CFLAGS ?= -O2
LDFLAGS ?= -lm

TARGET = bccasm
ASM_SOURCES = \
	generated/util.s \
	generated/lexer.s \
	generated/parser.s \
	generated/sem.s \
	generated/arena.s \
	generated/emitter.s \
	generated/main.s
OBJECTS = $(ASM_SOURCES:.s=.o)
RUNTIME = runtime.o

all: $(TARGET) lib/runtime.o

check: all
	./check.sh

bootstrap:
	$(MAKE) -C bootstrap bootstrap

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS) $(LDFLAGS)

lib/runtime.o: $(RUNTIME) | lib
	cp $(RUNTIME) $@

$(RUNTIME): runtime.s
	$(AS) -o $@ $<

lib:
	mkdir -p lib
	ln -sf ../../lib/libb.h lib/libb.h

%.o: %.s
	$(AS) -o $@ $<

clean:
	rm -f $(TARGET) $(OBJECTS) bccasm.o runtime.o lib/runtime.o

.PHONY: all check bootstrap clean
