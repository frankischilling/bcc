# Control flow

Strict B72 has `if`, `else`, `while`, `switch`, `case`, `goto`, and `return`.
A body can be a single statement or a block. Declarations prefix the
statement that follows them, so a declaration can also begin an unbraced
function or control-flow body.

## Conditions and loops

Conditions treat zero as false. Use parentheses around the condition of
`if` and `while`. An `else` belongs to the nearest unmatched `if`.

<!-- bcc-example {"stdout":"15\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn printf;
    auto i, sum;
    i=1; sum=0;
    while(i<=5) {
        sum=+i;
        i=+1;
    }
    printf("%d*n",sum);
    return(0);
}
```

The spelling `=+` means add and assign; `+=` is a compatibility spelling.
The same distinction applies to other compound assignments. Adjacent `=*`
is multiplication assignment, whereas `= *p` assigns the indirect value.

## Switch and branches

A switch transfers to a matching `case` in its body. Cases fall through
unless execution branches or returns. This dialect has no `break`,
`continue`, or `default` statement, so explicit labels are useful.

<!-- bcc-example {"stdout":"two\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn printf;
    auto n;
    n=2;
    switch n {
    case 1: printf("one*n"); goto done;
    case 2: printf("two*n"); goto done;
    }
    printf("other*n");
 done: return(0);
}
```

`goto` accepts a label value, not just a literal label name. A label belongs
to its function; do not branch into another function or keep a label value
after its invocation returns. Label cells are writable and retain their values across invocations of the
function. The host, bootstrap, and native backends check this behavior.
See the [runnable label-cell example](../examples/b72/label_cells.b).

A value return is `return(value);`, including the parentheses. A bare
`return;` is valid when the caller does not depend on a result.

Host compatibility syntax includes additional statements. Some constructs,
such as `break` and `default`, also occur in historical B on other systems;
calling them extensions to this PDP-11 baseline does not mean they were
invented recently. See the [source comparison](HISTORICAL_CONFORMANCE.md).

Source: sections 5 and 6 of the
[PDP-11 reference](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html).
