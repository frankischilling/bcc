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

The historical language also gives a function name an assignable cell
containing its function value. The native PDP-11 compiler implements those
cells, including address-based replacement and runtime-function replacement.
The host C backend and B-written bootstrap do not yet implement that complete
model. Calling a saved function value is supported; assigning a new value to
a function's defining name is not a portable cross-backend operation here.

BCC does not promise C ABI compatibility for arbitrary B function values.
Use documented host interoperability facilities where needed, and keep those
programs separate from B72 conformance examples. See the
[conformance notes](HISTORICAL_CONFORMANCE.md) for remaining backend differences.
