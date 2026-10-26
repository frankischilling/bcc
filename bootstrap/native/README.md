# Host-native image construction

`elfimage.b` packages existing x86-64 instruction bytes and data into a Linux
ELF64 executable. It is written in B and invokes no assembler or linker while
writing the image. It does not translate B source to machine instructions,
resolve symbols, apply relocations, or rebuild the compiler.

The writer is still built through BCC's C-output path and uses its host
runtime. This is one piece of the native backend, not a self-hosted host
compiler. The executable it produces has no interpreter or C runtime unless
the supplied instruction bytes implement one themselves.

## Build and use

From the repository root:

```sh
make
mkdir -p bootstrap/build/native
./bcc --strict --pedantic --word=host bootstrap/native/elfimage.b -o bootstrap/build/native/elfimage
bootstrap/build/native/elfimage code.bin data.bin 4096 0 > candidate.elf
```

The arguments are the instruction file, initialized-data file, zero-filled
storage size, and entry offset within the instructions. Sizes and offsets are
decimal. The instruction file must be nonempty and the entry offset must be
inside it. The two input files must be seekable. Each input and the zero-filled
storage size is limited to 16 MiB. The writer supports BCC's host and 32-bit
word models, not the PDP-11's 16-bit model.

Use a fresh output path and check the exit status before making it executable.
A failed write or close leaves an incomplete or untrusted output that the
caller must discard. Do not redirect over either input: the shell would
truncate that file before the writer starts. The writer does not set file
permissions or install the result.

## Layout

- The image base is `0x400000`; instructions start at `0x401000`.
- The first load segment contains the headers and instructions, with read
  and execute permissions.
- Initialized data begins at the next 4 KiB boundary after the instructions.
  Its address is `0x400000 + align_up(4096 + code_size, 4096)`. The second load
  segment has read and write permissions and includes the zero-filled tail.
- A `PT_GNU_STACK` header requests a non-executable stack.
- There are no section headers, dynamic linker, symbol table, or relocations.

Instruction bytes must already use these addresses or suitable relative
addressing. The writer checks file sizes and header values, not whether the
supplied instructions are valid or safe to run. Inputs must remain unchanged
during the two-pass read; changing their sizes is rejected, but same-length
concurrent edits are not detected.

The format follows the [ELF header](https://gabi.xinuos.com/elf/02-eheader.html)
and [program loading](https://gabi.xinuos.com/elf/07-pheader.html) specifications.
The x86-64 machine identifier and stack-header value are also defined in the
[Linux ELF interface](https://github.com/torvalds/linux/blob/master/include/uapi/linux/elf.h).
This is a modern target format, not a historical B or PDP-11 executable format.

## Checks

```sh
python3 bootstrap/native/test_elfimage.py
python3 bootstrap/native/test_elfimage.py --close-faults
make -C bootstrap native-test
```

The tests compare every output byte with an independent layout calculation,
check page boundaries and invalid inputs, and exercise delayed close failures
when requested. On Linux x86-64 they also execute fixtures that exit with a
known status, write initialized data, and read and modify zero-filled storage.
The writer runs with an empty tool-search path. Execution checks are reported
as skipped on other architectures; header comparisons still run.

`native-test` also builds and tests the writer through all three B-written
bootstrap stages. Those stages still emit C. Matching their image output is
useful evidence, but it is not the missing B-to-native backend.

## Instruction encoder

`x64.b` is a B library that emits a limited set of x86-64 instruction forms.
Concatenate it with an emitter's B source, compile that emitter with the seed
toolchain, and run it to produce instruction bytes for `elfimage.b`. This
removes an assembler from that construction step. It does not yet compile
ordinary B expressions or statements into native code.

The encoder requires 64-bit B words. Register IDs follow the instruction
encoding: RAX, RCX, RDX, RBX, RSP, RBP, RSI, RDI are 0 through 7; R8 through
R15 are 8 through 15. A byte operand uses the corresponding low-byte register,
including SPL, BPL, SIL and DIL, not AH, CH, DH or BH.

Call `xstart(fd)` before emitting anything. It takes ownership of the output
descriptor. `xtell()` reports bytes emitted, including bytes still buffered;
`xfinish()` flushes and closes the descriptor, checking both operations.
Invalid operands and I/O failures terminate with a nonzero status. Discard
failed output. Internal byte, prefix, and ModRM helpers are not checked public
interfaces.

The supported interfaces are:

- `xmovim(reg,value)` and `xmov(dst,src)` for 64-bit immediate and register moves.
- `xload(dst,base,disp)`, `xstore(base,disp,src)`, and `xlea(dst,base,disp)` for
  memory operations. Displacements are signed 32-bit values and always occupy
  four bytes, including zero. RSP and R12 bases receive the required SIB byte.
- `xloadb` and `xstoreb` have the same argument order as their word counterparts.
  A byte load zero-extends to 64 bits. `xmovzx(dst,src)` zero-extends a low-byte
  register.
- `xbin(kind,dst,src)` uses kinds 0 through 6 for add, or, and, subtract, xor,
  compare, and test. `xmul(dst,src)` emits the two-register signed multiply.
- `xunary(kind,reg)` uses 0 for not, 1 for negate, and 2 for signed divide.
  Division uses RDX:RAX; `xcqo()` sign-extends RAX into that pair.
- `xshift(kind,reg,count)` and `xshiftc(kind,reg)` use 0 for left shift, 1 for
  logical right shift, and 2 for arithmetic right shift. The latter takes its
  count from CL. Immediate counts are bytes, 0 through 255; processor masking
  applies. These are instruction encodings, not a choice of B shift semantics.
- `xstack(kind,reg)` uses 0 for push and 1 for pop.
- `xjump(kind,reg)` emits an indirect call (0) or jump (1). `xrel(kind,disp)`
  emits their relative forms. Relative displacements are signed 32-bit values
  measured from the end of the instruction.
- `xjcc(condition,disp)` and `xset(condition,reg)` use the processor's condition
  codes 0 through 15: overflow, not-overflow, below, above-or-equal, equal,
  not-equal, below-or-equal, above, sign, not-sign, parity, not-parity, less,
  greater-or-equal, less-or-equal, greater.
- `xret()` emits a near return and `xsys()` emits a syscall instruction.

The library does not resolve labels, allocate registers, impose a calling
convention, or validate runtime memory addresses. Indexed and RIP-relative
addressing, floating-point/vector instructions, and assembly-text parsing are
not implemented. The eventual compiler backend must supply those pieces it
needs and enforce its language semantics above these machine operations.

Encoding rules were checked against AMD's Architecture Programmer's Manual,
Volume 3, revision 3.36, especially the REX and operand-addressing sections
([manufacturer manual mirror](https://www.scs.stanford.edu/~zyedidia/docs/x86/amd-manual-v3.pdf)).
The [GNU assembler's encoding selectors](https://www.sourceware.org/binutils/docs-2.35/as/i386_002dMnemonics.html)
let the independent test oracle request the same fixed-width forms.

```sh
python3 bootstrap/native/test_x64.py
python3 bootstrap/native/test_x64.py --close-faults
```

Tests compare register combinations, displacement boundaries, byte-register
forms, conditions, shifts, and branches with the reference assembler. Separate
fixtures use the B encoder and B ELF writer to build executables that exercise
arithmetic, memory, calls, conditions, stack operations, and Linux syscalls.
The assembler is used only for the comparison, not to construct those fixtures.

## Code labels

`labels.b` adds two-pass numeric label resolution to `x64.b`. Concatenate both
files with the emitter's source. Labels range from 0 through 4095; label zero
and a label at byte offset zero are both valid. Different labels may name the
same offset.

For each pass, open a fresh output, call `xstart(fd)`, then `xlblbeg(pass)`.
Emit the program, call `xlblend()`, and finish with `xfinish()`. Pass 1 records
label positions and writes placeholder branch displacements. Discard that
output. Pass 2 emits the resolved instructions. Only a successful second-pass
output is a candidate for the ELF writer.

- `xmark(id)` defines a label at the current byte offset.
- `xbranch(kind,id)` emits a relative call (0) or jump (1).
- `xcond(condition,id)` emits a conditional jump using the encoder's condition
  numbers. Calls and jumps occupy five bytes; conditional jumps occupy six.

Forward and backward references use the same interface. Undefined or duplicate
labels, invalid pass ordering, changed label positions, and a changed total
size are errors. After finishing both passes, another pass 1 starts a fresh
layout and clears the old labels. As with the instruction encoder, discard
output after any error.

The emitter must supply the same program in both passes. These checks validate
its layout, not every instruction or operand: changing an instruction without
changing its size may not be detected. There is no branch shortening, named
symbol table, data relocation, register allocator, or B calling convention in
this module. It is not a source-language compiler or a general linker.

```sh
python3 bootstrap/native/test_labels.py
```

The checks compare forward and backward branch bytes, use every condition code
and all 4,096 label IDs, reject inconsistent layouts, and reuse the resolver
for a second program. Linux x86-64 checks also execute a forward call, a backward
loop, and a jump across more than one output-buffer block. Construction uses
the B encoder and ELF writer with an empty tool-search path. `native-test`
runs these checks through the host seed and all three B bootstrap stages.

## Word operations

`ops.b` selects instructions for individual 64-bit BCC word operations. It uses
`x64.b` and `labels.b`; it does not parse expressions, evaluate lvalues, or
implement assignments and function calls. This is a host-target component,
not a change to the PDP-11's 16-bit arithmetic.

`xbinary(op,base,fail)` takes its left operand in RCX and right operand in RAX,
and leaves the result in RAX. It may change RCX, RDX, R8, and flags. The other
general-purpose registers and RSP are preserved. Operator numbers match the
native intermediate records:

- The character codes for `+`, `-`, `*`, `/`, `%`, `&`, `|`, `^`, `<`, and `>`.
- 100 for `==`, 101 for `!=`, 102 for `<=`, and 103 for `>=`.
- 104 for `<<` and 105 for `>>`.

For shifts and division, reserve two unused label IDs, `base` and `base+1`.
The base must be between 0 and 4094. Division and remainder also need a
caller-defined `fail` label outside that pair. A zero divisor branches there;
the selector does not print a diagnostic or choose an exit status. Other
binary operations do not use these label arguments.

`xunop(op)` takes and returns its value in RAX and may change flags. It handles
negation (45), logical NOT (33), and bitwise complement (126). XOR and bitwise
complement are BCC extensions, not operators in the strict PDP-11 B72 dialect.

Addition, subtraction, multiplication, and negation wrap to 64 bits. Comparisons
are signed. Division truncates toward zero; the minimum signed word divided
by -1 wraps to that minimum, with remainder zero. Guards keep this case and
a zero divisor from reaching an invalid hardware division.

Right shifts fill with zeros. A shift by 64 returns zero; other counts use
their low six bits, matching BCC's existing host extension. The negative and
overlarge-count behavior is not a historical guarantee: [Thompson's manual](https://cm-bell-labs.github.io/who/dmr/kbman.html)
leaves those cases undefined. The selector preserves the current host policy
rather than copying the experimental PDP-11 VM's different extension.

```sh
python3 bootstrap/native/test_ops.py
```

The tests compare ordinary B expressions with an independent arithmetic oracle,
then execute B-built images for every supported operator across boundary values.
They also check register and stack preservation, division overflow and zero-divisor handling,
label limits, and rejected operators. The normal native test target repeats
them through all three B bootstrap stages. These checks do not establish a
complete expression compiler or runtime.


## Source frontend

An experimental [64-bit record frontend](frontend/README.md) reuses the
B-written parser with target-specific numeric helpers. It emits unresolved
records, not native code, and retains the parser's short-name and storage
limits. The complete host source-to-native pipeline remains unfinished.

## Function parameter metadata

`arity.b` reads declared parameter counts from the frontend's unresolved
`Adef`, `Aarg`, and `Aend` records. Read these records before the PDP-11 resolver:
that pass drops declarations for unused parameters. A future host backend
needs their counts to implement BCC's zero-filled missing arguments, even when
a function never names those arguments in its body.

Concatenate `src/buffered_io.b`, `src/decimal16.b`, `src/diagnostics.b`, and
`src/ic.b` from `pdp-11/bcc-pdp/bootstrap`, then `arity.b` and the caller's B
source. The library works with 16-bit, 32-bit, and host words.

Call `arscan(fd,visit)` with a readable descriptor and a callback. Each complete
function calls `visit(name,count)` in input order. The name is a temporary
NUL-terminated string, not an EOT-terminated B string; copy it if it must survive
the callback. The callback must return zero. `arscan` returns the number of
complete functions and leaves the descriptor open for its caller to close.

The reader checks eight-character names, consecutive parameter indices starting
at zero, and function boundaries. It rejects nested or unfinished functions,
extra fields in these records, nonzero callback results, and counts above
32767. Errors terminate the program, so callers must discard partial results.
Other record types are ignored. This is a metadata reader, not a complete record
validator, symbol table, or calling-convention implementation. Repeated function
names are not resolved here.

The library shares the IC reader's global state. Calls may run sequentially,
but a callback must not start another scan or reset that reader. Its 1040-byte
line buffer accepts the existing frontend's largest string records.

```sh
python3 bootstrap/native/test_arity.py
```

Tests include unused arguments from real frontend output, malformed boundaries,
parameter and function count limits, callback failures, and repeated scans.
The bootstrap native test target repeats them through all three B stages.

## Scalar record lowering

`scalar.b` lowers straight-line expression records from the wide frontend to
x86-64 instructions. It connects the frontend's accumulator-and-stack records
to `x64.b`, `labels.b`, and `ops.b`. The result stays in RAX, and successful
lowering leaves the runtime stack at its starting position.

After starting an instruction and label pass, call `xrinit(base,limit,fail)`.
The half-open label range `[base,limit)` belongs to this expression lowerer;
`fail` is a separate label supplied by the caller for division by zero. All
labels must fit the label library's 0 through 4095 range. Each divide,
remainder, or shift uses two labels from the reserved range. Call the same
sequence in both emission passes.

Pass each NUL-terminated record line to `xrline(buf)`, then call `xrendex()`
to check that a value exists and all pushed operands have been consumed.
Supported records are `n`, `ps`, `bin`, `binc`, `uo`, and `uon`. The numeric
constant reader accepts signed 64-bit decimal values and rejects overflow
instead of wrapping malformed records. Source literals have already been
normalized by the frontend. Operator behavior follows `ops.b`.

The frontend's `binc` and `uon` label operands describe internal boolean
materialization. This lowerer checks those operands but uses SETcc instead
of those branches. They are not general branch targets. The caller must not
jump to them or overlap its own labels with the reserved lowering range.

The lowerer rejects unsupported records, missing operands, trailing fields,
an unfinished expression stack, and more than 4096 saved operands. Failure can
leave partial output; discard it. It requires 64-bit words and the shared IC
reader and diagnostic helpers used by the parameter reader. It shares their
global parsing state and is not reentrant.

This module does not lower function definitions, returns, calls, variables,
pointers, assignments, or control flow. A caller must provide the surrounding
function and runtime code. The tests supply that surrounding code only for
isolated expressions; this is not a general B source-to-executable command.

```sh
python3 bootstrap/native/test_scalar.py
```

The tests feed real frontend output into the B lowerer and ELF writer, execute
the resulting images on Linux x86-64, and compare complete 64-bit results with
both ordinary compiled B and independent arithmetic expectations. After the
seed build, the frontend, lowerer, and image writer run with an empty tool-search
path. Their existing host runtime dependency has not been removed. They also
check stack restoration, division faults, malformed records, numeric bounds,
label exhaustion, and wrong-width builds. Other hosts skip native execution
rather than treating it as verified.

## Local storage and pointer records

`memory.b` extends scalar lowering with local cells, automatic vectors,
word-addressed pointers, assignment, compound updates, and prefix/postfix
increments. Include it after `scalar.b` and use the same instruction emitter,
label range, and diagnostic helpers.

Call `xmframe(count)` to emit a frame with 0 through 8191 local cells. It saves
RBP, uses RBP as the frame base, allocates eight bytes per cell below it, and
zeroes those cells. This initialization is a host-backend choice, not a promise
about historical automatic storage. `xmleave()` restores RSP and RBP without
changing the result in RAX; the caller supplies any return instruction.

For each record, call `xmline(buf)`. It returns one for a handled record and
zero for another tag. A caller can pass unhandled lines to `xrline`, which
rejects unsupported records. The memory records are:

- `lc offset`: form the word address of a local cell.
- `vi slot dataoffset`: initialize a vector pointer cell. Offsets use the
  resolver's downward-counting layout; elements themselves have increasing
  addresses.
- `dr`: load a word through the address in RAX.
- `ix`: add the index in RAX to a saved word address.
- `as`: store RAX through a saved word address, retaining the assigned value.
- `po flag` and `pi flag`: postfix and prefix updates. Zero decrements; one
  increments. Other flags are rejected.
- `ca op` and `cac op label label`: compound updates. The captured destination
  remains on the evaluation stack while the operation is performed. Boolean
  label fields follow the scalar lowerer's rules.

The module shares scalar operand tracking. Call `xrendex()` when an expression
is complete. Frame offsets and record fields are checked, but runtime pointers
are not bounds-checked. The caller must provide valid storage. Memory operations
may change RAX, RCX, RDX, R8, and flags; frame entry and exit also manipulate RBP
and RSP. Arithmetic faults branch to the caller's fault label. That handler
must terminate or unwind the frame, not resume inside the failed expression.

These records cover local storage only. Arguments, global symbols, strings,
function calls, and computed labels remain outside this module. The control
module below handles structured branches. The tests supply a frame and
reporting harness; there is still no general native source compiler command.

```sh
python3 bootstrap/native/test_memory.py
```

Tests pass real source through the B frontend, resolver, memory lowerer, and
image writer, then compare native results with compiled B and independent
expected values. They cover captured indexed lvalues, vector addressing,
compound operators, word boundaries, frame restoration, maximum frame size,
and malformed records. The instruction-building steps run with an empty
tool-search path after their seeded build.

## Structured control flow

`control.b` adds `lb`, `jm`, `bf`, `rt`, `tq`, `tc`, and `te` records. These
cover statement labels and branches, early returns, and conditional expressions.
Together with scalar and memory lowering, they can execute the wide frontend's
if/else and while-loop bodies. `control.b` also uses `switch.b` for switch
dispatch and handles computed jumps; see the section below.

Call `xcfscan(fd)` before emitting instructions. It reads control-label fields,
assigns dense encoder IDs, and returns their count. Source label numbers can
range from 0 through 32767; at most 4093 distinct labels are accepted. The scan
leaves the descriptor open. Reopen or rewind it before each emission pass.
Other records are ignored during this scan and must be validated by the later
lowering modules.

Reserve IDs 0 through count-1 for these mapped labels. Initialize scalar
lowering with a disjoint operation-label range, then call `xcfbeg(returnid)`
for each emission pass. The return label must be outside both ranges and
must differ from the arithmetic-fault label. For a single body, the tests use
`xrinit(count,4094,4095)` and `xcfbeg(4094)`. More program labels leave fewer
labels for division and shift operations; exhausting either range is an error.

During the active body, pass lines to `xcfline(buf)`. It returns one for a
handled control record and zero for another tag. The caller can then try
`xmline` and finally `xrline`. Statement labels, jumps, conditional branches,
and returns require an empty operand stack. A conditional branch also needs
a value to test.

Conditional expressions may have saved outer operands. The lowerer records
the depth at `tq`, checks the true arm at `tc`, and checks the false arm at
`te`. Both arms must produce a value at the same depth. Conditional-arm labels
and ordinary statement labels are kept separate, so an ordinary jump cannot
enter halfway through a conditional expression. Undefined, duplicate, and
unfinished labels are rejected by the scan, lowering state, or label emitter.

Call `xcfend()` after the body. It checks stack balance and unfinished
conditionals, emits zero for falling through the body, and marks the return
label. An explicit `rt` jumps past that fallback and retains RAX. The caller
then emits frame restoration and a return or entry-point exit sequence.
This fallback is a backend choice, not a historical guarantee about a function
that returns no value.

The module shares parser and scalar state and is not reentrant. Do not begin
a second body before ending the first, or rescan while a body is active. A
failed check can leave partial output that must be discarded. This is still
an intermediate-record library, not a complete native compiler or arbitrary
control-flow verifier.

```sh
python3 bootstrap/native/test_control.py
```

Tests execute real frontend/resolver output with nested loops, early returns,
conditional side effects, saved operands, and unselected faulting branches.
They compare full results with compiled B and independent expectations, check
frame restoration, and reject invalid label kinds, stack merges, missing
labels, capacity overflow, and API sequences. The surrounding executable
harness is test code; it does not add calls, globals, switch, or computed goto
to the compiler.

## Native function calls

`calls.b` constructs a host-native call convention for B functions. It keeps
arguments in contiguous word cells, retains extra arguments, and zero-fills
missing declared parameters. Zero filling follows BCC's existing host policy;
it is not a guarantee taken from the historical PDP-11 manual.

`xfpro(id,params,locals)` emits an aligned eight-byte declared-arity header,
marks the function entry label, and opens a local frame. The callable value
is the byte address of that entry, not the word address of a data cell. The
header is immediately before it. `xfarg(index)` produces a declared parameter's
word address in RAX; dereference it to read the value. `xfargc()` loads the
actual argument count. `xfend()` restores the frame and emits the return;
it requires a result value and a balanced operand stack. A control-flow body
can use `xcfend()` before `xfend()`.

The frame layout is:

- RBP+0: saved RBP.
- RBP+8: return address.
- RBP+16: actual argument count.
- RBP+24 onward: contiguous argument cells, including padding when needed.

This prefix and register convention are implementation details of the new
host backend. They do not reproduce a PDP-11 process image or the host C ABI.

Before `xcall(n)`, push the captured callable value and then each argument in
source order using the scalar stack records. The call copies those values into
a fresh block sized for the larger of the actual and declared counts, with at
least one parameter cell. It calls the saved value, restores the caller's stack,
and leaves the result in RAX. The call helper uses checked, fixed-size local
branches rather than consuming three global labels per call site. This lets
the constructor process its own call-heavy source within the label budget. The helper accepts up to 4095 actual arguments and
32767 declared parameters; these machine-level bounds do not enlarge the
frontend's own limits.

RBX and RBP must be preserved by every callee. The call helper borrows RBX only
after checking null and arity-header errors, and restores it after return.
Other scratch registers and flags may change. `xfline(buf)` handles the `ar`
and `cl` record forms and returns zero for another tag. A caller can combine it
with control, memory, and scalar lowering.

A callable must point to a function using this convention and carrying a valid
header. The null and arity checks are not general pointer validation; this does
not make arbitrary integers safe to call or provide C interoperability. Invalid
API sequences, counts, stack state, and label capacity fail with partial output
that the caller must discard.

```sh
python3 bootstrap/native/test_calls.py
```

The tests include a B-written [function-program constructor](fixtures/calls/README.md).
It reads declared arities and local-frame metadata, resolves source-function
names to writable cells, and emits code and function-cell data in two passes.
Real source programs exercise recursion, indirect and nested calls, captured
callees, mutable function cells, unused formal padding, extra arguments, and
by-value isolation. Focused instruction fixtures also test maximum call blocks,
actual-count metadata, invalid headers, and API errors.

That constructor is test code, not an installed compiler command. Its entry
point reports binary results for comparison by default; its optional `run`
argument instead exits with the return value from `main`. It binds the initial runtime primitives and predefined `argv` vector, but rejects
entry parameters. It does
not supply a general installed compiler command, multi-file linking, or the
remaining library. A separate rebuild test below checks a fixed point for
this restricted tool set, including its B-written command driver. Tests run instruction construction with an empty
tool-search path after seeding, but the seed-built tools still use the existing
host runtime.


## Static data

`data/layout.b` assigns eight-byte cells to global definitions, function
variables, and string occurrences. `data/output.b` writes the initial bytes. `data/labels.b` tracks mutable
label cells separately from named external objects.
These are host-native components, not changes to PDP-11 word sizes.

The rules follow sections 7.1 through 7.3 of
[Thompson's manual](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html):
a named initializer holds the address of that symbol's cell, not its value;
a vector has a writable pointer cell followed by the larger of its declared
size and initializer list; a function variable holds its callable value.
Forward references and cycles are resolved after layout. This implements the
specified address-initializer semantics rather than preserving the loader
limitation noted in the manual's implementation appendix.

Each string occurrence gets its own writable, word-aligned storage, including
embedded zero bytes and the final EOT byte. Padding bytes and uninitialized
cells are zeroed. Function entry values remain byte addresses; data addresses
are divided by eight for B pointer arithmetic.

- `xdscan(fd)` resets and collects layout from resolved records. It returns
  the total word count and leaves the descriptor open.
- `xdfind(name)` returns a symbol index or minus one. `xdoffs`, `xdsizes`,
  and `xdkinds` contain its word offset, allocated words, and kind (scalar,
  vector, or function). `xdladdr` and `xdlens` describe literal occurrences.
- `xdemit(fd,out,base,entry,label)` rereads the same unchanged record stream and
  writes data at the supplied aligned byte base. The `entry` callback returns the
  callable byte address for a function name; `label` returns the byte address
  for a source label ID. Both descriptors remain open.
- `xdaddr(name)` and `xdlit(index)` return word addresses using `xdbase`.
  Code emission sets that base after its first layout pass.

The caller must retain the input between scans and discard partial output on
failure. Output is buffered in 4 KB blocks; short or failed writes are errors.
Limits are 1,024 named objects, 512 string occurrences, 128 initializers per
definition, 8,190 declared vector elements, 4,096 label cells, and 16 MiB of total data. These
module bounds do not enlarge the frontend, resolver, or code-label budgets.

`test_data.py` checks exact bytes, forward and cyclic references, literal
separation, numeric boundaries, table limits, and write failures. The
whole-program fixtures in `test_calls.py` also execute globals, pointer-cell
mutation, packed strings, and function-address initializers. Construction runs
with an empty tool-search path after the tools have been seeded. The existing
C-backed host runtime still runs those tools; this is not a native compiler
fixed point.

```sh
python3 bootstrap/native/test_data.py
python3 bootstrap/native/test_calls.py
```


## Host resolver storage

The [host resolver seed builder](resolver/build.py) uses the same symbol and
record-rewriting code as the PDP-11 resolver, with a separate B storage module.
It allows 1,024 symbols and 8,191 buffered initializer-record bytes. The native
configuration remains at 200 symbols and 2,047 bytes. Names still have eight
characters, and local counts and record indices retain their existing bounds.
The host configuration rejects 16-bit and 32-bit word modes before reading input.

This is enough to resolve the expanded constructor's own source and a
128-element initializer list of full-width integers. The native rebuild test
below checks self-compilation separately. The runtime remains incomplete,
and the constructor's separate function-metadata table still has 200 slots.

```sh
python3 bootstrap/native/resolver/build.py /tmp/bcc-resolver
python3 bootstrap/native/test_resolver.py
```

The Python builder is a seed convenience. The resolver itself is B source;
its ordinary record-processing path does not launch other tools.


## Switch dispatch and computed goto

`switch.b` accompanies `control.b`. It lowers `swb`, `swc`, and `swx`, with
up to 16 nested switches and 32 cases per switch, matching the shared frontend.
The selector is pushed only while the hidden dispatch chain is searching.
A matching case or the unmatched exit removes it before entering ordinary
statement code. Fallthrough skips the comparisons, so it does not pop a second
selector. Calls and returns inside a case therefore use the normal stack layout.
Comparison order follows the source records; the manual leaves that order
unspecified, so this is an implementation choice. Dispatch labels have a separate label kind: an ordinary statement jump cannot
silently enter a dispatch chain with no selector on the stack.

`xcfline` also handles `gor`. It requires a value and an empty expression stack,
rejects a null destination through the configured fault branch, and jumps to
the byte address in RAX. This is not general pointer validation. A valid target
is a label in the currently executing function. Arbitrary addresses and jumps
into another function do not establish a valid execution frame.

`la` loads a word pointer to a mutable label cell. Dereferencing the cell gets
the code byte address, while taking its address permits assignment through a
pointer. `lv` supplies the initial code address during data emission. Cells are
distinct even when adjacent labels happen to name the same code location, and
their values persist across calls. The test constructor connects these data
records to the control library's code labels.

The control and whole-program tests check nested dispatch, matched and
unmatched cases, fallthrough, wide case values, recursion, calls and returns,
source jumps into and out of cases, saved and mutated label values, null jumps,
label-table collisions, and malformed record sequences. The modules still do
not provide a complete native host runtime or normal program startup.

## Native runtime primitives

The [runtime guide](runtime/README.md#primitives) describes the direct Linux
primitives, counted call frame, error handling, and pathname limits.

## Runtime import selection

[Import selection](runtime/README.md#import-selection) supplies primitive
providers and entry data only when referenced names lack source definitions.
Source overrides and writable function cells retain their usual behavior.

## Entry argument vector

The [argument packer](runtime/README.md#argument-vector) copies Linux arguments
into aligned B storage and preserves the separate environment pointer.

## Native tool fixed point

```sh
python3 bootstrap/native/test_rebuild.py
make -C bootstrap native-rebuild-test
```

The rebuild test seeds four tools through the existing C-output compiler:
the wide frontend, host resolver, call-test constructor, and ELF image writer.
It then builds native versions of those tools and a fifth B-written command
driver. The driver is compiled through the native passes, not the C backend.
The native tools rebuild all five sources twice more. Raw records,
resolved records, instruction bytes, static data, and complete executables must
match at every native stage. The test also checks the ELF segment layout,
executes the source-program cases through the final native tools, rejects
malformed input, and prints source and artifact hashes.

After seeding, every compiler pass runs as a native executable with an empty
tool-search path. No GCC, assembler, or linker is invoked. The native programs
use the B-maintained instruction and runtime modules, with direct Linux
syscalls rather than a linked C runtime. Python coordinates the regression test and compares its output. A separate
check invokes the B-written driver to rebuild each tool, including itself,
and requires the same executable bytes. The driver runs the passes without
Python or a shell. Native execution requires Linux x86-64.

This is a fixed point for the experimental five-tool subset, not a claim that
the installed `bcc`, `bccasm`, or PDP-11 commands have been replaced. The
constructor remains a fixture with bounded tables and incomplete library
coverage. A matching rebuild also cannot prove the seed trustworthy or the
language implementation complete. The separate conformance tests still matter.

CI runs this rebuild in its own GCC/Clang seed lanes, alongside rather than
after the longer native-construction suites. The existing B-bootstrap gate
requires both sets of checks and the bootstrap regressions to succeed.
Native-construction checks run in independent host/stage-1/stage-2/stage-3
jobs for each seed compiler. They share the `native-stage-test` Make target;
`native-test` still runs every stage locally. This separates the work without
removing a seed, test command, or close-failure check. Short aggregate gates
use lightweight runners; compiler and real-kernel jobs keep full VM runners.


### Try the verified native tools

On Linux x86-64, `--output` saves the final native executables, their exact B
sources, and a hash manifest after all checks pass. The destination must not
exist. The manifest is written last, so a failed export without that file is
not a verified bundle. These hashes record integrity, not authenticity.

From the repository root:

```sh
set -e
make
tools="$PWD/bootstrap/build/native-verified"
python3 bootstrap/native/test_rebuild.py --output "$tools"
"$tools/driver" examples/hello.b -o hello-native
./hello-native
```

The example writes `Hello, World` and a newline using the B-written formatting
library. Use a new output name: `-o` refuses to replace an existing path.
No C compiler, assembler, linker, or external `chmod` is used after the export.
Python is needed to seed and check this bundle, not to invoke the exported
driver. Its compiler passes are B-maintained native executables. Keep the
executables and the bundled `sources/*.b` runtime providers together. If you invoke the constructor
directly, use a fresh directory: it writes `imports` and `layout` in its working
directory. Prefer `-o` for safe named output. If you use shell redirection
instead, keep its destination separate from input files: the shell truncates
it before the driver can check it.


## B-written command driver

The [driver guide](driver/README.md) covers the shell-free compilation pipeline,
private scratch directory, library dependencies, error handling, and limits.

## Native character and formatted I/O

The [B library guide](lib/README.md) describes strict formatting, character
pairs, string termination, writable callbacks, and counted process replacement.
