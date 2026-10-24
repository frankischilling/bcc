# Historical compiler tools use fixed scratch files. One lock covers separate
# Make processes and full-system staging, not just jobs in a single Make run.
ifeq ($(_BCC_NATIVE_LOCKED),)
.DEFAULT_GOAL := all
_BCC_GOALS := $(if $(MAKECMDGOALS),$(MAKECMDGOALS),all)
.PHONY: __bcc_locked $(_BCC_GOALS)
$(_BCC_GOALS): __bcc_locked ;
__bcc_locked:
	+flock "$(CURDIR)/.native-build.lock" $(MAKE) _BCC_NATIVE_LOCKED=1 $(_BCC_GOALS)
else
export _BCC_NATIVE_LOCKED

# bcc-pdp Makefile -- builds B compiler as PDP-11 a.out binaries
# (b00 + b01 + b1) using V1 cc under apout.
#
# The PDP-11 sources use the V1 C dialect (no #include, no void, K&R,
# 6-char identifier safe, no &&-in-assignment, etc).  Compiles via the
# actual 1972 cc binary running under apout.

.NOTPARALLEL:
# The historical cc and assembler use fixed scratch filenames.

V1     = ../unix-v1
APOUT  = $(V1)/tools/apout/apout
SRCDIR = src
BUILD  = build
AROOT  = $(BUILD)/aroot
CRT0   = $(BUILD)/crt0.o
TOOLCHAIN_INPUTS = $(subst :,\:,$(shell find $(V1)/fs/root $(V1)/fs/usr -type f 2>/dev/null))

RUN    = APOUT_ROOT=$(AROOT) $(APOUT)

# b00: lex + parse + raw IC.  b01: resolve IC.  b1: emit V1 as.  b: driver.
B00_SRCS = b00drv.c bstmt.c bexpr.c blex.c bemit0.c butil.c
B01_SRCS = b01drv.c blex1.c bsym.c butil.c
B1_SRCS = b1drv.c bcg.c bcgnew.c blex1.c blit.c butil.c
BDRV_SRCS = bdrv.c bsel.c

B00     = $(BUILD)/b00
B01     = $(BUILD)/b01
B1      = $(BUILD)/b1
BDRV    = $(BUILD)/b
LIBB    = runtime/libb.s
LIBRAW  = $(BUILD)/libb.raw.s

.PHONY: all clean aroot install test-run v1-run v1-smoke libb

all: $(B00) $(B01) $(B1) $(BDRV) $(LIBB)

libb: $(LIBB)

# Compile runtime/libb.b -> libb.s using the freshly built compiler.
$(LIBRAW): $(B00) $(B01) $(B1) runtime/libb.b
	@cp runtime/libb.b $(AROOT)/libb.b
	@rm -f $(AROOT)/libb.ic $(AROOT)/libb.r2 $(AROOT)/libb.s
	cd $(AROOT) && APOUT_ROOT=. $(abspath $(APOUT)) $(abspath $(B00)) -o libb.ic libb.b
	@test -f $(AROOT)/libb.ic || { echo "b00 failed (no libb.ic)"; exit 1; }
	cd $(AROOT) && APOUT_ROOT=. $(abspath $(APOUT)) $(abspath $(B01)) -i libb.ic -o libb.r2
	@test -f $(AROOT)/libb.r2 || { echo "b01 failed (no libb.r2)"; exit 1; }
	cd $(AROOT) && APOUT_ROOT=. $(abspath $(APOUT)) $(abspath $(B1)) -l -i libb.r2 -o libb.s
	@test -f $(AROOT)/libb.s || { echo "b1 failed (no libb.s)"; exit 1; }
	mv $(AROOT)/libb.s $@
	@rm -f $(AROOT)/libb.b $(AROOT)/libb.ic $(AROOT)/libb.r2
	@echo "built: $@"

$(LIBB): $(LIBRAW)
	sed -e 's/L\([0-9][0-9]*\)/B\1/g' -e 's/S\([0-9][0-9]*\)/C\1/g' $(LIBRAW) > $@

aroot: $(AROOT)/.stamp

$(APOUT): $(V1)/tools/apout/Makefile
	$(MAKE) -C $(V1)/tools/apout

$(V1)/tools/apout/Makefile:
	@echo "Missing Unix restoration. Run git submodule update --init pdp-11/unix-v1 from the repository root." >&2
	@exit 1

$(CRT0): $(APOUT) $(V1)/src/lib/crt0.s
	mkdir -p $(BUILD)/crt0-stage
	cp $(V1)/src/lib/crt0.s $(BUILD)/crt0-stage/crt0.s
	cd $(BUILD)/crt0-stage && APOUT_ROOT=$(abspath $(V1)/fs/root) $(abspath $(APOUT)) $(abspath $(V1)/fs/root/bin/as) crt0.s
	cp $(BUILD)/crt0-stage/a.out $@

$(AROOT)/.stamp: $(CRT0) tools/build-apout-root.sh runtime/bmain.s runtime/brt.s $(TOOLCHAIN_INPUTS)
	tools/build-apout-root.sh
	touch $@

# Common build helper: copy named srcs into aroot, run V1 cc, mv a.out.
# V1 cc's exit code is unreliable -- ignore it and test for a.out instead.
$(B00): $(AROOT)/.stamp $(addprefix $(SRCDIR)/,$(B00_SRCS))
	@for f in $(B00_SRCS); do cp $(SRCDIR)/$$f $(AROOT)/$$f; done
	@rm -f $(AROOT)/a.out
	-cd $(AROOT) && APOUT_ROOT=. $(abspath $(APOUT)) ./bin/cc $(B00_SRCS)
	@test -f $(AROOT)/a.out || { echo "cc failed (no a.out for b00)"; exit 1; }
	mv $(AROOT)/a.out $@
	@for f in $(B00_SRCS); do rm -f $(AROOT)/$${f%.c}.o $(AROOT)/$$f; done
	@echo "built: $(B00)"

$(B1): $(AROOT)/.stamp $(addprefix $(SRCDIR)/,$(B1_SRCS))
	@for f in $(B1_SRCS); do cp $(SRCDIR)/$$f $(AROOT)/$$f; done
	@rm -f $(AROOT)/a.out
	-cd $(AROOT) && APOUT_ROOT=. $(abspath $(APOUT)) ./bin/cc $(B1_SRCS)
	@test -f $(AROOT)/a.out || { echo "cc failed (no a.out for b1)"; exit 1; }
	mv $(AROOT)/a.out $@
	@for f in $(B1_SRCS); do rm -f $(AROOT)/$${f%.c}.o $(AROOT)/$$f; done
	@echo "built: $(B1)"

$(B01): $(AROOT)/.stamp $(addprefix $(SRCDIR)/,$(B01_SRCS))
	@for f in $(B01_SRCS); do cp $(SRCDIR)/$$f $(AROOT)/$$f; done
	@rm -f $(AROOT)/a.out
	-cd $(AROOT) && APOUT_ROOT=. $(abspath $(APOUT)) ./bin/cc $(B01_SRCS)
	@test -f $(AROOT)/a.out || { echo "cc failed (no a.out for b01)"; exit 1; }
	mv $(AROOT)/a.out $@
	@for f in $(B01_SRCS); do rm -f $(AROOT)/$${f%.c}.o $(AROOT)/$$f; done
	@echo "built: $(B01)"

$(BDRV): $(AROOT)/.stamp $(addprefix $(SRCDIR)/,$(BDRV_SRCS))
	@for f in $(BDRV_SRCS); do cp $(SRCDIR)/$$f $(AROOT)/$$f; done
	@rm -f $(AROOT)/a.out
	-cd $(AROOT) && APOUT_ROOT=. $(abspath $(APOUT)) ./bin/cc $(BDRV_SRCS)
	@test -f $(AROOT)/a.out || { echo "cc failed (no a.out for bdrv)"; exit 1; }
	mv $(AROOT)/a.out $@
	@for f in $(BDRV_SRCS); do rm -f $(AROOT)/$${f%.c}.o $(AROOT)/$$f; done
	@echo "built: $(BDRV)"

clean:
	rm -rf $(BUILD)

install: all
	tools/install_v1.sh

# End-to-end: compile a .b, assemble + link with runtime, run via apout.
B ?= tests/run/t01_hello.b
test-run: all
	tools/run-apout.sh $(B)

# End-to-end inside SIMH Unix V1: install compiler, rebuild disk images,
# boot, compile B with /bin/b, then run ./a.out.
v1-run v1-smoke: all
	tools/v1-run.sh $(B)

.PHONY: v1-selfhost
v1-selfhost: all
	tools/v1-run.sh $(B) --selfhost

$(V1)/tools/pdp11: $(V1)/tools/simh/makefile
	$(MAKE) -C $(V1)/tools

$(V1)/tools/simh/makefile:
	@echo "Missing SIMH source. Run git submodule update --init --recursive pdp-11/unix-v1 from the repository root." >&2
	@exit 1

v1-run v1-smoke v1-selfhost: $(V1)/tools/pdp11

$(V1)/tools/mkfs: $(V1)/tools/mkfs.c
	$(MAKE) -C $(V1)/tools mkfs

v1-run v1-smoke v1-selfhost: $(V1)/tools/mkfs

endif
