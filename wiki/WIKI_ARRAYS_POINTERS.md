# Arrays and pointers

B stores word values without declared types. A value may be used as an
integer, an address, or a callable value. The operation, rather than a type
annotation, determines how it is interpreted.

## Cells, vectors, and initializers

These declarations do different things:

```text
x 10,20,30;       external cells; x reads 10, (&x)[1] reads 20
v[3] 10,20,30;   external vector; v contains its first element's address
auto n;          one automatic cell
auto a 3;        automatic vector with three elements
```

`auto n 3;` does not initialize a scalar to three. Assign scalars in a
separate statement. Vector extents are element counts. A vector also has a
pointer cell, and assigning to that cell changes where indexing starts.
Automatic contents must be initialized before reading them.

<!-- bcc-example {"stdout":"10 20 30\n","native":true,"bootstrap":true} -->
```b
x 10,20,30;
main() {
    extrn x, printf;
    printf("%d %d %d*n",x,(&x)[1],(&x)[2]);
    return(0);
}
```

## Word addressing

In word-addressed modes, `p+1` advances one word, and `p[i]` refers to the
same cell as `*(p+i)`. `&x` gives the address of the cell named `x`; `*p`
reads or writes the addressed cell. Indexing a vector is not a bounds check.

<!-- bcc-example {"stdout":"42 1\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn printf;
    auto a 3, p;
    a[0]=10; a[1]=20; a[2]=30;
    p=a+1;
    *p=42;
    printf("%d %d*n",a[1],&a[2]-&a[1]);
    return(0);
}
```

The native PDP-11 compiler uses word addresses for data and byte code-entry
values for functions and labels. The host `--word=16` mode translates B
addresses to registered host storage; it does not reproduce a PDP-11 memory
image. Host strict mode also defaults to word addressing. The B-written
bootstrap's strict mode uses host-sized words and word addresses.

Host compatibility mode defaults to byte addresses. In that mode `p+1`
advances one byte but `p[i]` still indexes words. That is not ordinary C
pointer arithmetic. Do not switch pointer modes without checking arithmetic
on addresses. The host `--word=32` mode can truncate native pointer values
when used in arithmetic and is not a complete 32-bit address-space model.

## Packed bytes and lifetime

Use `char(base,index)` and `lchar(base,index,value)` for packed byte access;
word subscripts do not select individual characters. See
[strings](WIKI_STRING_OPERATIONS.md).

An automatic vector belongs to the current function invocation. Do not
return a pointer to it or use its address after that invocation ends.
`alloc(n)` and `free(p)` are host extensions for longer-lived storage, not
portable replacements for a historical B library interface. The translated
16-bit mode detects some invalid addresses, but that is not a general memory
safety guarantee.

See sections 3, 6, 7, and 12 of the
[PDP-11 reference](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
and the [conformance notes](HISTORICAL_CONFORMANCE.md).
