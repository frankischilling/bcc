# Control Structures

B provides essential control flow constructs for conditional execution, loops, and multi-way branching. This page covers B's control structures in detail, including syntax, semantics, and implementation notes.

---

## Conditional Execution

### If Statement

B's `if` statement evaluates a condition and executes code conditionally:

```b
if (condition) {
    // statements executed if condition is non-zero (true)
}
```

**Condition Evaluation:**
- Any non-zero value is considered "true"
- Zero is considered "false"
- All data types are treated as integers for condition evaluation

### If-Else Statement

```b
if (condition) {
    // executed when condition is true
} else {
    // executed when condition is false
}
```

**Key Points:**
- `else` binds to the nearest preceding `if`
- Nesting works as expected
- No boolean type - conditions are integer expressions

---

## Loops

### While Loop

B's `while` loop repeatedly executes a block while a condition remains true:

```b
while (condition) {
    // loop body - executed while condition is non-zero
}
```

**Execution Flow:**
1. Evaluate condition
2. If condition is zero (false), exit loop
3. If condition is non-zero (true), execute body and repeat

### Loop Control

`break` and `continue` are available to control loops directly.

**Typical Patterns:**
```b
// Counter-controlled loop
auto i = 0;
while (i < 10) {
    // do something
    i =+ 1;
}

// Condition-controlled loop
auto done = 0;
while (!done) {
    // do something
    if (some_condition) break;
    if (skip_condition) continue;
}
```

---

## Multi-Way Branching

### Switch Statement

B's `switch` statement provides multi-way branching based on value comparison:

```b
switch (expression) {
case constant1:
    // statements for constant1
case constant2:
    // statements for constant2
    // execution falls through by default
}
```

**Important Characteristics:**
- **Fall-through behavior**: Execution continues to next case unless you use `break`
- **Integer constants only**: Case labels must be constant integer expressions
- **Default case**: Optional `default:` case executes when no other case matches

### Switch Implementation

B's switch is compiled differently than C's:

```b
// B switch statement
switch (x) {
case 1:
    stmt1;
case 2:
    stmt2;
default:
    stmt_default;
}
```

**Compiled as:**
```c
// Generated C code
for (;;) {
    word __sw = x;
    goto __bsw0_dispatch;

    __bsw0_case1: /* case 1 code */ goto __bsw0_end;
    __bsw0_case2: /* case 2 code */ goto __bsw0_end;
    __bsw0_default: /* default case code */ goto __bsw0_end;

    __bsw0_dispatch:
        if (__sw == 1) goto __bsw0_case1;
        if (__sw == 2) goto __bsw0_case2;
        goto __bsw0_default;

    __bsw0_end:
        break;
}
```

**Switch Semantics:**
- Cases are checked in source code order
- Fall-through occurs naturally unless you `break`
- To exit switch, use `break` or modify the control variable

### Practical Switch Usage

```b
// Character classification
auto c = getchar();
switch (c) {
case `a':
case `e':
case `i':
case `o':
case `u':
    vowel = 1;
case ` ':
case `*t':
case `*n':
    whitespace = 1;
    break;
default:
    other = 1;
}
```

**Exit Strategies:**
```b
switch (choice) {
case 1:
    handle_one();
    break;
case 2:
    handle_two();
    break;
default:
    error();
}
```

---

## Goto and Labels

### Unconditional Jump

B supports `goto` statements for direct jumps to labeled statements:

```b
goto label_name;

// ... code ...

label_name:
statement;
```

**Label Syntax:**
- Labels are identifiers followed by a colon
- Labels must be unique within a function
- Execution continues at the labeled statement

### Goto Use Cases

**Error Handling:**
```b
if (error_condition) {
    cleanup();
    goto error_exit;
}

// normal processing

error_exit:
return -1;
```

**Loop Control (simulating break/continue):**
```b
auto i = 0;
loop_start:
    if (i >= 10) goto loop_end;

    // loop body
    if (some_condition) goto loop_start;  // continue
    if (error_condition) goto loop_end;  // break

    i =+ 1;
    goto loop_start;
loop_end:
```

**State Machines:**
```b
state_machine:
    switch (state) {
    case STATE_INIT:
        initialize();
        state = STATE_PROCESS;
        goto state_machine;
    case STATE_PROCESS:
        process_data();
        if (done) state = STATE_CLEANUP;
        goto state_machine;
    case STATE_CLEANUP:
        cleanup();
        goto exit;
    }
exit:
```

---

## Control Flow Patterns

### Common Idioms

**Infinite Loop:**
```b
while (1) {
    // infinite loop
    if (should_exit) goto exit_loop;
}
exit_loop:
```

**Do-While Equivalent:**
```b
loop_body:
    // do something
    if (condition) goto loop_body;
```

**For Loop Simulation:**
```b
auto i = 0;          // initialization
while (i < 10) {     // condition
    // loop body
    i =+ 1;          // increment
}
```

**Early Return Pattern:**
```b
if (error_check()) {
    cleanup();
    return -1;
}
// continue with normal processing
```

### Error Handling

**Simple Error Handling:**
```b
if (operation_failed) {
    error_code = -1;
    goto cleanup;
}

cleanup:
    free_resources();
    return error_code;
```

**Nested Error Handling:**
```b
auto result = do_operation1();
if (result < 0) goto error;

result = do_operation2();
if (result < 0) goto error;

// success path
return 0;

error:
    undo_operation1();
    return result;
```

---

## Implementation Notes

### Compilation Strategy

**If Statements:**
- Direct compilation to C if-else
- Condition expressions evaluated as integers
- Short-circuit evaluation not guaranteed

**While Loops:**
- Direct mapping to C while loops
- Loop depth tracking for semantic analysis
- No continue/break transformations needed

**Switch Statements:**
- Complex transformation to C for loops with goto
- Case label management with unique identifiers
- Fall-through preservation

### Semantic Analysis

**Scope Rules:**
- Labels have function scope
- Goto targets must exist in same function
- Forward jumps to labels are allowed

**Control Flow Validation:**
- Switch statements must be within functions
- Labels must be unique within functions
- Goto targets must be valid labels

### Runtime Behavior

**Condition Evaluation:**
```b
// All of these are false (zero):
if (0) { /* not executed */ }
if (`*0') { /* not executed */ }

// All of these are true (non-zero):
if (1) { /* executed */ }
if (-1) { /* executed */ }
if (`A') { /* executed */ }
```

**Loop Termination:**
- Loops terminate when condition evaluates to zero
- No implicit loop variable management
- Manual increment/decrement required

---

## Differences from C

| Feature | B | C |
|---------|---|----|
| Boolean Type | No (integer conditions) | `_Bool` type |
| Break/Continue | No | Yes |
| Default Case | No | Yes |
| Fall-through | Always | Until break |
| Short-circuit &&/|| | No | Yes |
| Switch Scope | Function | Block |

---

## Examples

### Complete Programs

**Number Classification:**
```b
main() {
    auto n = 42;

    if (n < 0) {
        printf("negative*n");
    } else {
        if (n == 0) {
            printf("zero*n");
        } else {
            printf("positive*n");
        }
    }
}
```

**Simple Calculator:**
```b
main() {
    auto op = `+';
    auto a = 10;
    auto b = 5;
    auto result;

    switch (op) {
    case `+':
        result = a + b;
        goto compute_done;
    case `-':
        result = a - b;
        goto compute_done;
    case `*':
        result = a * b;
        goto compute_done;
    case `/':
        if (b == 0) {
            printf("division by zero*n");
            return 1;
        }
        result = a / b;
        goto compute_done;
    }

compute_done:
    printf("result: %d*n", result);
}
```

**Text Processing Loop:**
```b
main() {
    auto c;
    auto count = 0;

    while ((c = getchar()) != '*e') {
        if (c == ` ') {
            count =+ 1;
        } else {
            if (count > 0) {
                putchar(` ');
                count = 0;
            }
            putchar(c);
        }
    }
}
```

---

## Best Practices

### Control Structure Guidelines

**Use Meaningful Conditions:**
```b
// Good: clear intent
if (error_code != 0) {
    handle_error();
}

// Avoid: confusing
if (!(!error_code)) {
    handle_error();
}
```

**Limit Switch Complexity:**
```b
// Prefer simple switches
switch (command) {
case CMD_READ:
    read_data();
    goto done;
case CMD_WRITE:
    write_data();
    goto done;
}
done:
```

**Use Goto Sparingly:**
- Reserve goto for error handling and state machines
- Avoid spaghetti code with excessive gotos
- Prefer structured control flow when possible

### Performance Considerations

**Condition Evaluation:**
- Simple integer comparisons are fastest
- Complex expressions in conditions may impact performance
- Function calls in conditions should be avoided when possible

**Switch Optimization:**
- Compiler generates efficient dispatch tables
- Case order doesn't affect performance
- Consider if-else chains for small case sets

---

## References

- [B Reference Manual - Control Flow](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- [B Tutorial - Program Structure](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf)
- [Users' Reference to B (1972)](https://www.bell-labs.com/usr/dmr/www/kbman.html)

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [Runtime Library](WIKI_RUNTIME_LIBRARY.md)
- [I/O Functions](WIKI_IO_FUNCTIONS.md)
- [File I/O](WIKI_FILE_IO.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
- [String Operations](WIKI_STRING_OPERATIONS.md)
- [Data Types & Literals](WIKI_DATA_TYPES.md)
- [Functions](WIKI_FUNCTIONS.md)
- [Arrays & Pointers](WIKI_ARRAYS_POINTERS.md)
- [Examples](WIKI_EXAMPLES.md)
