# Experimental instruction format

This describes the implementation in this directory. It is not a historical
B format or a stable external interface. The seed encoder and execution
engine must change together.

## Words and addresses

Files contain little-endian 16-bit words. Instruction addresses are word
offsets from the start of the instruction file; the first instruction is at
zero. The current code limit is 32,700 words. Heap addresses also count
words, but address a separate 8,192-word file. Heap address zero is invalid.

The accumulator holds one B word. The operand stack grows down from heap
address 8,192. Calls, local variables, and temporary operands share this
stack. A floor separates it from globals and startup allocations.

## Instructions

Operands listed after an opcode are subsequent words in the instruction
file. All other operands come from the accumulator or stack.

| Opcode | Following words | Effect |
| --- | --- | --- |
| 0 | none | Flush all dirty heap pages and return the accumulator. |
| 1 | value | Load a constant. |
| 2 | address | Load a heap word. |
| 3 | address | Store the accumulator without changing it. |
| 4 | value | Add a constant. |
| 5 | value | Signed less-than comparison with a constant. |
| 6 | target | Jump. |
| 7 | target | Jump when the accumulator is zero. |
| 8 | none | Push the accumulator. |
| 9 | operation | Pop the left operand and combine it with the accumulator. |
| 10 | argument count | Call the saved callee below the pushed arguments. |
| 11 | local word count | Reserve a local frame. |
| 12 | none | Restore the caller's frame and instruction address. |
| 13 | local offset | Load the address at frame pointer minus one minus offset. |
| 14 | argument offset | Load the address at frame pointer plus three plus offset. |
| 15 | none | Dereference the accumulator. |
| 16 | none | Pop a destination address and store the accumulator. |
| 17 | none | Jump to the instruction address in the accumulator. |
| 18 | operation | Apply a unary operation. |
| 19 | delta | Post-increment the cell addressed by the accumulator. |
| 20 | delta | Pre-increment that cell. |
| 21 | operation | Pop an address, combine its value with the accumulator, and store the result. |
| 22 | pointer offset, storage offset | Initialize a local vector's pointer cell. |
| 23 | none | Load the top operand without removing it. |
| 24 | none | Drop the top operand. |
| 26 | floor | Set the initial heap allocation floor, at least 16. |
| 28 | address, count, data words | Copy the following words into the heap. |

Unused opcodes are rejected. The engine checks negative or out-of-range
instruction addresses, truncated operands, heap bounds, and stack exhaustion.
Those checks do not make compiled programs a security sandbox.

Binary operations use the character codes for `+ - * / % & | ^ < >`.
The additional codes are 100 for equality, 101 for inequality, 102 for
less-than-or-equal, 103 for greater-than-or-equal, 104 for left shift, and
105 for logical right shift. Unary operations use `-`, `!`, and 126 for
bitwise complement. Division and remainder by zero are diagnosed.

## Calls and cells

The caller pushes the callee entry value, evaluates and pushes arguments in
source order, then emits opcode 10. The engine reverses the argument words
so the first argument has the lowest address. A zero-argument call receives
one zero word, matching the native backend's current missing-first-argument
convention. It then saves the cleanup count, return address, and old frame
pointer. Locals are below the new frame; arguments are above it.

A B function name addresses a writable heap cell containing its entry
address. A label name similarly addresses a cell containing its instruction
address. Reassigning the cell changes subsequent indirect calls or jumps;
the encoder does not substitute immutable code addresses for B cells.

## Primitive entry values

Values 32701 through 32712 select, in order: read, write, open, creat, close,
char, lchar, exit, unlink, seek, putchar, and getchar. They are handled at the
native boundary rather than interpreted as instruction addresses.

32713 returns the virtual argument count. 32714 reads one byte of a virtual
argument. 32715 allocates words above the static-data floor. These three
operations are for startup, not additional public B library functions.
The seed encoder uses them to construct strings and the counted external
`argv` vector, then calls `main` with the count and the first string-pointer
slot. The instruction filename serves as the virtual program name.

## Switches

The encoder preserves the native resolver's forward-linked dispatch chain.
A switch pushes its selector and jumps to dispatch. Each case compares a
copy of that saved selector. A match removes the saved value before entering
the body; an unmatched switch removes it at the final dispatch node.
Ordinary fall-through jumps around the dispatch nodes and their cleanup.
This matters when a case returns, jumps out, or is entered by a direct goto.
