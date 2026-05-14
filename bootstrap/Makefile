STAGE0 ?= ../bcc
SRC := src/bbc.b
BUILD := build
STAGE1 := $(BUILD)/stage1/bbc
STAGE2 := $(BUILD)/stage2/bbc
STAGE3 := $(BUILD)/stage3/bbc

.SUFFIXES:
.PHONY: all stage1 stage2 stage3 test clean

all: stage3

stage1: $(STAGE1)

$(STAGE1): $(SRC)
	mkdir -p $(BUILD)/stage1
	$(STAGE0) $(SRC) -o $(STAGE1)

stage2: $(STAGE2)

$(STAGE2): $(STAGE1) $(SRC)
	mkdir -p $(BUILD)/stage2
	$(STAGE1) $(SRC) -o $(STAGE2)

stage3: $(STAGE3)

$(STAGE3): $(STAGE2) $(SRC)
	mkdir -p $(BUILD)/stage3
	$(STAGE2) $(SRC) -o $(STAGE3)

test: stage3
	./tests/run.sh

clean:
	rm -rf $(BUILD)
	rm -f src/*.b.c
