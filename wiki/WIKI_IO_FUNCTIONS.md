# Character and formatted output

Declare library names with `extrn` in the function that uses them. Host BCC
recognizes some runtime names implicitly for compatibility, but examples in
this guide use explicit declarations.

`getchar()` returns a byte or 004 at end of input. `putchar(c)` writes the
high byte first if it is nonzero, then the low byte. Thus a packed character
pair can produce two output bytes; `putchar(0)` produces one NUL byte.
Output return values are not a portable way to detect a successful write.
Use descriptor `write` when checking the returned byte count matters.

## Historical formatting

Strict host mode and the native runtime support these B72 conversions:

- `%d`: signed decimal.
- `%o`: signed octal, including a minus sign for negative values.
- `%c`: `putchar` character output, including packed pairs.
- `%s`: packed bytes ending at 004, not NUL.

An unknown conversion prints `%` and processes the following character
again without consuming an argument. This is not C's `%%` rule: `%%d`
prints a percent sign followed by the decimal argument. A trailing percent
sign is printed literally. Supply one word argument for each recognized
conversion; the runtime cannot diagnose missing variadic arguments.

<!-- bcc-example {"stdout":"-17 -21 AB hi\n%7\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn printf;
    printf("%d %o %c %s*n",-17,-17,'AB',"hi");
    printf("%%d*n",7);
    return(0);
}
```

`printn(n,base)` prints a number without a newline. The reference example's
domain is nonnegative integers in bases two through ten. BCC extends it to
negative values and bases through sixteen, using uppercase letters for
hexadecimal digits. Invalid bases return -1 without printing anything;
success returns zero. The implementation handles the most-negative word
without negating it in signed arithmetic.

## Host compatibility formatting

Without strict mode, the host runtime retains these additional behaviors:

- `%o` prints the unsigned word representation.
- `%u` and `%zu` print unsigned decimal; `%zd` prints signed decimal.
- `%p` prints `0x` followed by lowercase hexadecimal.
- `%%` prints one percent sign.
- Format strings and `%s` stop at either NUL or 004.

There is no general C `printf` implementation here: field widths, precision,
floating-point formats, `%x`, and arbitrary length modifiers are not
supported. `%zu` and `%zd` consume B words, not independently typed C values.
The strict-mode choice is compiled into the linked or inline runtime, and
runtime caching distinguishes the two modes.

## Additional helpers

`putstr(s)` writes a string without a newline. Strict mode preserves embedded
NULs; host compatibility mode stops at NUL or 004. `putchr(c)` writes only
the low byte. `print(n)` is a host convenience that adds a newline;
`putnum(n)` writes decimal without one.

The native helper and strict host `getstr(buf)` return the number of characters
stored, excluding the final 004. Compatibility host mode retains its buffer
return value and treats carriage return as a line terminator. Strict mode keeps
carriage return as data and stops on newline or 004. This helper is a project
interface, not an entry in the January 1972 library list.

`getstr(buf)` has no length parameter. It cannot prevent a too-long input
line from overrunning its destination. Prefer a bounded `getchar`/`lchar`
loop for input you do not control. Its return and carriage-return behavior
currently differ between the host and native runtimes, so do not rely on
those differences as historical guarantees.

See [file I/O](WIKI_FILE_IO.md) for descriptor operations and
[strings](WIKI_STRING_OPERATIONS.md) for buffer sizes. The formatting baseline
is section 9 of the
[PDP-11 reference](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html),
not the host C library's formatting rules.
