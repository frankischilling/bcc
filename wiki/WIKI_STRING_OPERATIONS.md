# Packed strings

B strings are packed bytes terminated by character 004. `char(s,i)` reads
byte `i`, and `lchar(s,i,c)` replaces that byte with the low eight bits of
`c` and returns the original `c` value. Indexes begin at zero.
`lchar` requires enough writable storage; it does not grow the destination.

<!-- bcc-example {"stdout":"cat\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn lchar, printf;
    auto s 2;
    lchar(s,0,'c'); lchar(s,1,'a'); lchar(s,2,'t');
    lchar(s,3,004);
    printf("%s*n",s);
    return(0);
}
```

Two words hold four bytes on the PDP-11 and in host 16-bit mode. Host-sized
words may hold more. Reserve space for the terminator as well as the text;
use byte helpers rather than relying on the host's physical cell layout.

## NUL is not the B terminator

Strict host formatting and the native runtime preserve embedded NUL bytes.
Host compatibility string-output helpers stop at either NUL or 004 to
support older host programs. The distinction is observable:

<!-- bcc-example {"stdout":"A\u0000B\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn printf;
    printf("%s*n","A*0B");
    return(0);
}
```

This output contains four bytes: A, NUL, B, newline. A terminal may not show
the NUL, so the test compares bytes rather than a screenshot.

Unix argument strings and `ctime` output are NUL-terminated, not ordinary B
strings. Walk those buffers with `char` until NUL or copy them to a buffer
ending in 004 before using strict `%s`. File `read` returns a byte count and
does not append either terminator.

String literals are writable. The compiler keeps separate storage for
separate literal occurrences, even when their text matches. Modifying one
literal does not change another equal literal elsewhere in the source.

There is no built-in string length or concatenation operator. Write loops
using `char` and `lchar`, with explicit bounds supplied by the caller.
Do not copy an unbounded string into an automatic vector.

See [formatted I/O](WIKI_IO_FUNCTIONS.md) and sections 2.2 and 8 of the
[PDP-11 reference](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html).
