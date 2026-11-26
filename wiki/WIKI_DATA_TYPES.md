# Words and literals

B has no declared integer, character, pointer, or Boolean types. It uses
words, interpreted by each operation. Zero is false in a condition;
nonzero is true. Relational operations produce zero or one.

The PDP-11 compiler uses 16-bit words. Host BCC supports `--word=host`,
`--word=16`, and `--word=32`; the B-written bootstrap currently uses
host-sized storage only. Choosing strict syntax does not by itself select
16-bit arithmetic. See [CLI options](../docs/cli.md) and
[addressing limits](WIKI_ARRAYS_POINTERS.md).

## Names

A B72 name has at most eight characters. Its first character is a letter,
underscore, or ASCII backspace (byte 8); later characters can also be digits.
Backspace is part of the name, not an instruction to erase the preceding byte.
Different byte sequences remain different names. The compiler encodes these
names for the host toolchain without exposing control bytes as C identifiers.

The original scan states this alphabet in
[section 2.2](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.pdf#page=7).

## Numbers

Decimal constants have no prefix. A leading zero selects octal: `010` is
eight. The historical scanner also accepts digits 8 and 9 while accumulating
in base eight: `09` is 9, and `018` is 16. A negative value uses unary minus, as in `-17`. Hexadecimal `0x`
constants are a host compatibility extension, not B72 syntax.

BCC wraps arithmetic at the selected width, including host-sized words and
the bootstrap. Both shifts fill vacated bits with zero; a right shift does
not preserve a negative operand's sign bit. Arithmetic results remain signed
words for comparisons. Increment, decrement, and compound assignment evaluate
the destination once. A shift by exactly the word width produces zero.
Do not mistake every tested edge case for a historical language guarantee:
Thompson's reference leaves some negative division/remainder and
out-of-range shift cases undefined. In particular, portable programs should
not divide by zero or depend on an out-of-range shift.

## Characters

A character constant has one or two characters. A two-character constant
places the first character in the high byte. `putchar('AB')` therefore emits
A followed by B. This numeric packing differs from the little-endian packed
string representation.

B escapes use an asterisk: `*n` newline, `*t` tab, `*0` NUL, `**` asterisk,
`*'` apostrophe, `*"` double quote, `*(` left brace, and `*)` right brace.
Use B escapes for special characters in strict programs. A backslash is
literal there: `"\n"` contains backslash and `n`, while `"*n"` contains a newline.

<!-- bcc-example {"stdout":"AB 16706\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn putchar, printf;
    putchar('AB');
    printf(" %d*n",'AB');
    return(0);
}
```

## Strings and EOF

A string literal produces the address of writable packed characters ending
with character 004. An embedded NUL is data, not that terminator. Equal
literals at different source locations have separate storage; repeatedly
evaluating one literal refers to the same storage.

`getchar()` returns character 004 at end of input. A zero byte read from the
input is still a byte. Unix argument strings and the output buffer of
`ctime` instead use NUL termination; do not treat every pointer as a B string.
See [string operations](WIKI_STRING_OPERATIONS.md) for examples.

Sources: sections 2, 3, 4, and 8 of the
[PDP-11 reference](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html).
