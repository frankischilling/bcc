CC ?= gcc
AS ?= as
PYTHON ?= python3
CFLAGS ?= -O2
LDFLAGS ?= -lm
TARGET = bccasm
ASM_SOURCES = $(addprefix generated/,$(addsuffix .s,util lexer parser sem arena emitter main))
OBJECTS = $(ASM_SOURCES:.s=.o)

all: check-snapshots $(TARGET) runtime

check-snapshots:
	$(PYTHON) regenerate.py --check

regenerate:
	$(PYTHON) regenerate.py --cc "$(CC)"

check: all
	bash check.sh

bootstrap:
	$(MAKE) -C bootstrap bootstrap

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS) $(LDFLAGS)

# Generated programs use the same runtime as the C-source compiler.
runtime:
	mkdir -p lib
	cp --remove-destination ../lib/libb.c ../lib/libb.h ../lib/btarget.h ../lib/binit.h ../lib/bunix.h lib/

%.o: %.s
	$(AS) -o $@ $<

clean:
	rm -f $(TARGET) $(OBJECTS) bccasm.o runtime.o lib/runtime.o

.PHONY: all check bootstrap clean regenerate check-snapshots runtime
