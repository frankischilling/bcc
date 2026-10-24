# Functions

A B function definition consists of a name, a parenthesized parameter list,
and one statement. A block is common, but is not required. Definitions are
external: B72 has no nested function definitions or closures.

These rules follow sections 4.1, 5.6, 6, and 7.3 of Thompson's
[*Users' Reference to B*](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html).
For build commands and dialect switches, see the [CLI guide](../docs/cli.md).

## Parameters and results

Arguments pass word values. Changing a parameter does not change the caller's
variable. Passing an address lets a function modify the addressed storage.
Argument evaluation order is unspecified; do not rely on side effects in
separate arguments happening in a particular order.

A value-returning statement has parentheses: `return(value);`. `return;` is
also valid, but callers must not depend on its result. Reaching the end of a
body likewise does not provide a portable result. BCC's host C backend uses
zero for a bare return; that is an implementation choice, not a B72 guarantee.

<!-- bcc-example {"stdout":"42\n","native":true,"bootstrap":true} -->
```b
add(x,y) return(x+y);
main() {
    extrn add, printf;
    printf("%d*n",add(19,23));
    return(0);
}
```

Declare external names used by a function with `extrn`. Parameters and
automatic names belong to that function. In strict mode, braces do not create
C-style block scope for these names. An automatic vector declaration sets up
its pointer when execution reaches the declaration; its storage belongs to
the function invocation. Recursive calls have separate automatic storage.

<!-- bcc-example {"stdout":"120\n","native":true,"bootstrap":true} -->
```b
fact(n) {
    extrn fact;
    if(n<2) return(1);
    return(n*fact(n-1));
}
main() {
    extrn fact, printf;
    printf("%d*n",fact(5));
    return(0);
}
```

## Parameter storage

Declared parameters occupy consecutive word cells in declaration order.
Taking the first parameter's address and indexing that block reaches the
following declared parameters. Writing through such an address changes the
parameter, not the caller's original variable. Recursive calls have separate
blocks. See the [parameter-cell example](../examples/b72/parameter_cells.b).

The host and bootstrap use an explicit parameter block instead of relying
on how a C compiler spills argument registers. In translated 16-bit mode,
the block is registered as one object so free-list fragmentation cannot
separate its cells. All supplied arguments are retained, including those beyond
the declared parameter names. A count or format string must tell the function
how many cells it may read; see the [counted-argument example](../examples/b72/counted_arguments.b).
This supports the argument-walking pattern in the reference's section 9.3.

The host and bootstrap zero-fill missing declared parameters of source functions. The first two optional host `main` parameters still receive the command-line
count and argument vector; additional declared parameters are zero.
These are safety and compatibility extensions, not historical guarantees; native programs
must not rely on missing arguments having a particular value. Function values
remain opaque B values, not ordinary C function pointers. Rebuild all B objects
when changing compiler versions because the host call interface can change.

## Function values

A function value can be stored in a variable, passed as an argument, or
selected by an expression before a call. Treat it as an opaque callable
value, not as an integer address to modify arithmetically.

<!-- bcc-example {"stdout":"42\n","native":true,"bootstrap":true} -->
```b
inc(x) return(x+1);
apply(f,x) return(f(x));
main() {
    extrn inc, apply, printf;
    auto f;
    f=inc;
    printf("%d*n",apply(f,41));
    return(0);
}
```

A source-defined function name has an assignable cell containing its function
value. The host, bootstrap, and native compilers support replacement through
the name or its address, and a saved copy of the previous value still calls
the original body. See the [runnable function-cell example](../examples/b72/function_cells.b).
Cells are initialized once, not each time the function is called.

The host and bootstrap do not yet give every built-in runtime name this
same writable-cell interface. A B definition can replace a library name in
source-level calls, but internal bundled-runtime calls still use their own
helpers. The native runtime supports those writable library cells and
interposition too. Keep this distinction separate from source-function cells.

BCC does not promise C ABI compatibility for arbitrary B function values.
Use documented host interoperability facilities where needed, and keep those
programs separate from B72 conformance examples. See the
[conformance notes](HISTORICAL_CONFORMANCE.md) for remaining backend differences.
