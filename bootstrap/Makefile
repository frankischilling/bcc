STAGE0 ?= ../bcc
SRC := src/bbc.b
BUILD := build
STAGE1 := $(BUILD)/stage1/bbc
STAGE2 := $(BUILD)/stage2/bbc
STAGE3 := $(BUILD)/stage3/bbc

.SUFFIXES:
.PHONY: all stage1 stage2 stage3 test native-test native-stage-test native-rebuild-test clean

all: stage3

stage1: $(STAGE1)

$(STAGE1): $(SRC) $(STAGE0) ../lib/libb.c ../lib/libb.h ../lib/btarget.h ../lib/binit.h ../lib/bcall.h ../lib/bunix.h ../lib/bformat.h ../lib/bprimitives.h
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
	python3 tests/input_errors.py
	@set -e; for stage in 1 2 3; do python3 ../tests/test_intr_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_output_errors.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_switch_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_tty_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_external_scope.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_putchar_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_vector_extent.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_seek_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_char_storage.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_argv_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_global_storage.py --bootstrap --compiler build/stage$$stage/bbc; done
	@for stage in 1 2 3; do python3 ../tests/test_declarations.py --bootstrap --compiler build/stage$$stage/bbc || exit 1; done

	@for stage in 1 2 3; do python3 ../tests/test_unix_metadata.py --bootstrap --compiler build/stage$$stage/bbc || exit 1; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_number_formatting.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_open_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_read_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_docs_examples.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_mkdir_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_label_cells.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_library_names.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_allocation_sizes.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_function_cells.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_parameter_layout.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_word_arithmetic.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_reread_runtime.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_call_frames.py --bootstrap --compiler build/stage$$stage/bbc; done

	@set -e; for stage in 1 2 3; do python3 ../tests/test_library_bindings.py --bootstrap --compiler build/stage$$stage/bbc; done
	@set -e; for stage in 1 2 3; do python3 ../tests/test_identifier_bytes.py --bootstrap --compiler build/stage$$stage/bbc; done

NATIVE_COMPILER ?= $(STAGE0)
NATIVE_FLAGS ?=
NATIVE_TESTS := native/test_elfimage.py \
	native/test_x64.py \
	native/test_labels.py \
	native/test_ops.py \
	native/test_calls.py \
	native/test_data.py \
	native/test_resolver.py \
	native/test_runtime.py \
	native/test_argv.py \
	native/test_control.py \
	native/test_memory.py \
	native/test_scalar.py \
	native/test_arity.py \
	native/test_frontend.py \
	../pdp-11/bcc-pdp/bootstrap/test_source_reader.py

native-stage-test:
	@set -e; for test in $(NATIVE_TESTS); do python3 "$$test" $(NATIVE_FLAGS) --compiler "$(NATIVE_COMPILER)"; done

native-test: stage3
	$(MAKE) native-stage-test NATIVE_COMPILER="$(STAGE0)"
	@set -e; for stage in 1 2 3; do $(MAKE) native-stage-test NATIVE_COMPILER="build/stage$$stage/bbc" NATIVE_FLAGS=--bootstrap; done

native-rebuild-test: stage3
	python3 native/test_rebuild.py --compiler $(STAGE0)
	@set -e; for stage in 1 2 3; do python3 native/test_rebuild.py --bootstrap --compiler build/stage$$stage/bbc; done

clean:
	rm -rf $(BUILD)
	rm -f src/*.b.c
