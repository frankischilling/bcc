STAGE0 ?= ../bcc
.DEFAULT_GOAL := test
.PHONY: test rebuild-test stage3 native-stage-test native-test native-rebuild-test

test: native-test

rebuild-test: native-rebuild-test

stage3:
	$(MAKE) -C ../bcc-b stage3 STAGE0="$(abspath $(STAGE0))"

NATIVE_COMPILER ?= $(STAGE0)
NATIVE_FLAGS ?=
NATIVE_TESTS := test_elfimage.py \
	test_x64.py \
	test_labels.py \
	test_ops.py \
	test_calls.py \
	test_data.py \
	test_resolver.py \
	test_runtime.py \
	test_argv.py \
	test_control.py \
	test_memory.py \
	test_scalar.py \
	test_arity.py \
	test_frontend.py \
	../pdp-11/bcc-pdp/bootstrap/test_source_reader.py

native-stage-test:
	@set -e; for test in $(NATIVE_TESTS); do python3 "$$test" $(NATIVE_FLAGS) --compiler "$(NATIVE_COMPILER)"; done

native-test: stage3
	$(MAKE) native-stage-test NATIVE_COMPILER="$(STAGE0)"
	@set -e; for stage in 1 2 3; do $(MAKE) native-stage-test NATIVE_COMPILER="../bcc-b/build/stage$$stage/bbc" NATIVE_FLAGS=--bootstrap; done

native-rebuild-test: stage3
	python3 test_rebuild.py --compiler $(STAGE0)
	@set -e; for stage in 1 2 3; do python3 test_rebuild.py --bootstrap --compiler ../bcc-b/build/stage$$stage/bbc; done
