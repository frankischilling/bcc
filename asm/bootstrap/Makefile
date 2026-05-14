CC ?= gcc
AS ?= as
CFLAGS ?= -O2
LDFLAGS ?= -lm

STAGE = stage1
TARGET = $(STAGE)/bccasm
RUNTIME = $(STAGE)/lib/runtime.o

ASM_SOURCES = \
	../generated/util.s \
	../generated/lexer.s \
	../generated/parser.s \
	../generated/sem.s \
	../generated/arena.s \
	../generated/emitter.s \
	../generated/main.s

OBJECTS = \
	$(STAGE)/obj/util.o \
	$(STAGE)/obj/lexer.o \
	$(STAGE)/obj/parser.o \
	$(STAGE)/obj/sem.o \
	$(STAGE)/obj/arena.o \
	$(STAGE)/obj/emitter.o \
	$(STAGE)/obj/main.o

all: $(TARGET) $(RUNTIME)

bootstrap: all check

check: all
	BCC="$(CURDIR)/$(TARGET)" ../check.sh

$(TARGET): $(OBJECTS) | $(STAGE)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS) $(LDFLAGS)

$(STAGE)/obj/%.o: ../generated/%.s | $(STAGE)/obj
	$(AS) -o $@ $<

$(RUNTIME): ../runtime.s | $(STAGE)/lib
	$(AS) -o $@ $<

$(STAGE):
	mkdir -p $@

$(STAGE)/obj:
	mkdir -p $@

$(STAGE)/lib:
	mkdir -p $@
	ln -sf ../../../../lib/libb.h $@/libb.h

clean:
	rm -rf $(STAGE)

.PHONY: all bootstrap check clean
