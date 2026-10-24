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

$(STAGE1): $(SRC) $(STAGE0) ../lib/libb.c ../lib/libb.h ../lib/btarget.h ../lib/binit.h ../lib/bunix.h ../lib/bformat.h
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
	bash tests/run.sh
	python3 tests/conformance.py
	python3 tests/limits.py
	@set -e; for stage in 1 2 3; do python3 ../tests/test_putchar_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_vector_extent.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_argv_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_global_storage.py --bootstrap --compiler build/stage$$stage/bbc; done
	@for stage in 1 2 3; do python3 ../tests/test_declarations.py --bootstrap --compiler build/stage$$stage/bbc || exit 1; done

	@for stage in 1 2 3; do python3 ../tests/test_unix_metadata.py --bootstrap --compiler build/stage$$stage/bbc || exit 1; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_number_formatting.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_read_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_docs_examples.py --bootstrap --compiler build/stage$$stage/bbc; done

clean:
	rm -rf $(BUILD)
	rm -f src/*.b.c
