# BCC Test Suite

This document describes the BCC compiler test suite, including how to run tests, add new tests, and understand test results.

---

## Overview

The BCC test suite validates compiler correctness across multiple dimensions:

| Category | Purpose | Location |
|----------|---------|----------|
| **Compile** | Verify syntax/semantic analysis | `tests/compile/` |
| **Run** | Check runtime behavior and output | `tests/run/` |
| **Programs** | Test complete programs | `tests/programs/` |
| **AST** | Verify parser output | `tests/ast/` |
| **Multi-file** | Test multi-file compilation | `tests/multifile/` |

---

## Running Tests

### Run All Tests

```bash
./tests/run_tests.sh
```

### Verbose Output

```bash
./tests/run_tests.sh --verbose
# or
./tests/run_tests.sh -v
```

### Filter Tests

Run only tests matching a pattern:

```bash
./tests/run_tests.sh --filter arithmetic
./tests/run_tests.sh -f compile/
./tests/run_tests.sh -f multifile
```

### Sample Output

```
B Compiler Test Suite
=====================

=== Compile-only tests ===
PASS: compile/arrays
PASS: compile/char_constants
PASS: compile/comments
PASS: compile/control_flow
PASS: compile/empty_main
...

=== Run tests ===
PASS: run/arithmetic
PASS: run/array_sum
PASS: run/comparisons
PASS: run/exit_42
...

=== Program tests ===
PASS: programs/gcd
PASS: programs/primes
PASS: programs/sort

=== AST snapshot tests ===
PASS: ast/precedence
PASS: ast/simple

=== Multi-file tests ===
PASS: multifile/simple

=====================
Results: 28 passed, 0 failed, 0 skipped
```

---

## Test Categories

### 1. Compile-Only Tests (`tests/compile/`)

These tests verify that valid B code compiles without errors. They don't run the resulting executable.

**Directory:** `tests/compile/`

**Files:**
- `*.b` — B source file that should compile successfully
- `*.fail` — If present, the corresponding `.b` file should *fail* to compile

**Current Tests:**

| Test | Description |
|------|-------------|
| `empty_main.b` | Minimal valid program |
| `variables.b` | Variable declarations (auto, global, arrays) |
| `arrays.b` | Array declarations and access |
| `char_constants.b` | Character literals and escape sequences |
| `comments.b` | Block and line comments |
| `control_flow.b` | if/else/while statements |
| `expressions.b` | Operators and expression evaluation |
| `externs.b` | External variable declarations |
| `functions.b` | Function definitions and calls |
| `goto.b` | Labels and goto statements |
| `numbers.b` | Numeric literals (decimal, octal) |
| `strings.b` | String literals |
| `switch.b` | Switch/case statements |

**Example: `empty_main.b`**
```b
/* Empty main function */
main() {
}
```

**Example: `variables.b`**
```b
/* Variable declarations */
x;
y;
arr[10];

main() {
    auto a, b, c;
    auto vec[5];
    a = 1;
    b = 2;
    c = a + b;
    return(c);
}
```

---

### 2. Run Tests (`tests/run/`)

These tests compile and execute programs, verifying exit codes and/or output.

**Directory:** `tests/run/`

**Files:**
- `*.b` — B source file
- `*.exit` — Expected exit code (required)
- `*.out` — Expected stdout output (optional)
- `*.in` — Stdin input to provide (optional)

**Current Tests:**

| Test | Description | Exit Code |
|------|-------------|-----------|
| `arithmetic.b` | Basic arithmetic operations | 9 |
| `array_sum.b` | Array element summation | 15 |
| `comparisons.b` | Relational operators | 1 |
| `exit_42.b` | Return specific exit code | 42 |
| `exit_zero.b` | Return zero | 0 |
| `factorial.b` | Recursive factorial | 120 |
| `fib.b` | Fibonacci sequence | 55 |
| `goto_test.b` | Goto and labels | 42 |
| `hello.b` | Character output | 0 |
| `incr_decr.b` | Increment/decrement operators | 4 |
| `switch_test.b` | Switch statement | 3 |
| `ternary.b` | Ternary operator | 10 |
| `while_sum.b` | While loop summation | 55 |
| `word_semantics.b` | Word arithmetic edge cases | 0 |

**Example: `arithmetic.b`**
```b
main() {
    auto a, b;
    a = 10;
    b = 3;

    /* Test: 10 + 3 - 2 * 4 / 2 = 10 + 3 - 4 = 9 */
    return(a + b - 2 * 4 / 2);
}
```

**Example: `hello.b`**
```b
main() {
    putchar('H');
    putchar('i');
    putchar('!');
    putchar('*n');
    return(0);
}
```

With `hello.out`:
```
Hi!
```

---

### 3. Program Tests (`tests/programs/`)

Larger, more comprehensive programs that test multiple compiler features together.

**Directory:** `tests/programs/`

**Files:**
- `*.b` — B source file
- `*.exit` — Expected exit code
- `*.out` — Expected output (optional)
- `*.in` — Input data (optional)

**Current Tests:**

| Test | Description |
|------|-------------|
| `gcd.b` | Greatest common divisor |
| `primes.b` | Prime number sieve |
| `sort.b` | Array sorting |

**Example: `primes.b`**
```b
/* Print primes up to 50 */

isprime(n) {
    auto i;
    if (n < 2) return(0);
    if (n == 2) return(1);
    if (n % 2 == 0) return(0);
    i = 3;
    while (i * i <= n) {
        if (n % i == 0)
            return(0);
        i = i + 2;
    }
    return(1);
}

printnum(n) {
    if (n >= 10)
        printnum(n / 10);
    putchar('0' + n % 10);
}

main() {
    auto i, count;
    count = 0;
    i = 2;
    while (i <= 50) {
        if (isprime(i)) {
            printnum(i);
            putchar(' ');
            count = count + 1;
        }
        i = i + 1;
    }
    putchar('*n');
    return(count);
}
```

---

### 4. AST Snapshot Tests (`tests/ast/`)

These tests verify the parser produces the correct Abstract Syntax Tree.

**Directory:** `tests/ast/`

**Files:**
- `*.b` — B source file
- `*.ast` — Expected AST output (golden file)

**How It Works:**
1. Compile with `--dump-ast` flag
2. Compare output to golden `.ast` file
3. Any difference = test failure

**Current Tests:**

| Test | Description |
|------|-------------|
| `simple.b` | Basic variable and arithmetic |
| `precedence.b` | Operator precedence |

**Example: `simple.b`**
```b
main() {
    auto x;
    x = 1 + 2;
    return(x);
}
```

**Expected `simple.ast`:**
```
AST:
Top level 0:
  FUNC main
  BLOCK
    AUTO
    EXPR
      ASSIGN =
        VAR x
        BINARY +
          NUM 1
          NUM 2
    RETURN
      VAR x
```

---

### 5. Multi-File Tests (`tests/multifile/`)

These tests verify that multiple B source files can be compiled and linked together.

**Directory:** `tests/multifile/<test_name>/`

**Files:**
- `*.b` — Multiple B source files (all compiled together)
- `expected.exit` — Expected exit code
- `expected.out` — Expected output (optional)
- `input.in` — Input data (optional)

**Current Tests:**

| Test | Description |
|------|-------------|
| `simple/` | Basic cross-file function calls |

**Example: `simple/lib.b`**
```b
/* Library file */
add(a, b) {
    return(a + b);
}

mul(a, b) {
    return(a * b);
}
```

**Example: `simple/main.b`**
```b
/* Main file - uses lib.b */
main() {
    auto x, y;
    x = add(3, 4);   /* 7 */
    y = mul(x, 2);   /* 14 */
    return(y);
}
```

---

## Adding New Tests

### Adding a Compile Test

1. Create `tests/compile/mytest.b` with valid B code
2. Run `./tests/run_tests.sh -f compile/mytest`

For expected-failure tests:
1. Create `tests/compile/bad_syntax.b` with invalid code
2. Create `tests/compile/bad_syntax.fail` (empty file)

### Adding a Run Test

1. Create `tests/run/mytest.b`
2. Create `tests/run/mytest.exit` with expected exit code
3. (Optional) Create `tests/run/mytest.out` with expected output
4. (Optional) Create `tests/run/mytest.in` with input data

**Example:**
```bash
# Create test file
cat > tests/run/double.b << 'EOF'
main() {
    auto x;
    x = 21;
    return(x * 2);
}
EOF

# Create expected exit code
echo "42" > tests/run/double.exit

# Run test
./tests/run_tests.sh -f run/double
```

### Adding a Program Test

Same as run tests, but in `tests/programs/`:

1. Create `tests/programs/myprogram.b`
2. Create `tests/programs/myprogram.exit`
3. (Optional) Create `tests/programs/myprogram.out`

### Adding an AST Test

1. Create `tests/ast/mytest.b`
2. Generate golden file:
   ```bash
   ./bcc tests/ast/mytest.b --dump-ast > tests/ast/mytest.ast
   ```
3. Review and verify the `.ast` file is correct

### Adding a Multi-File Test

1. Create directory `tests/multifile/mytest/`
2. Add multiple `.b` files
3. Create `tests/multifile/mytest/expected.exit`
4. (Optional) Create `tests/multifile/mytest/expected.out`

---

## Test Script Reference

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All tests passed |
| 1 | One or more tests failed |

### Environment Variables

The test script uses these paths:
- `BCC` — Path to compiler (default: `../bcc` relative to script)
- Temporary files are created in `/tmp/`

### Color Output

| Color | Meaning |
|-------|---------|
| Green | PASS |
| Red | FAIL |
| Yellow | SKIP |

---

## Debugging Failed Tests

### Verbose Mode

Run with `-v` to see detailed failure information:

```bash
./tests/run_tests.sh -v -f run/mytest
```

### Manual Testing

```bash
# Compile manually
./bcc tests/run/mytest.b -o /tmp/mytest

# Run and check exit code
/tmp/mytest
echo $?

# Check output
/tmp/mytest > /tmp/out.txt
diff tests/run/mytest.out /tmp/out.txt
```

### AST Debugging

```bash
# Dump AST
./bcc tests/ast/mytest.b --dump-ast

# Compare with expected
diff tests/ast/mytest.ast <(./bcc tests/ast/mytest.b --dump-ast)
```

### Generated C Code

```bash
# Keep generated C file
./bcc tests/run/mytest.b -o /tmp/mytest --emit-c

# Inspect generated code
cat tests/run/mytest.b.c
```

---

## Test Coverage

### Language Features Tested

| Feature | Compile | Run | Program |
|---------|---------|-----|---------|
| Variables | ✓ | ✓ | ✓ |
| Arrays | ✓ | ✓ | ✓ |
| Functions | ✓ | ✓ | ✓ |
| Arithmetic | ✓ | ✓ | ✓ |
| Comparisons | ✓ | ✓ | ✓ |
| If/Else | ✓ | ✓ | ✓ |
| While | ✓ | ✓ | ✓ |
| Switch | ✓ | ✓ | |
| Goto | ✓ | ✓ | |
| Strings | ✓ | ✓ | |
| Comments | ✓ | | |
| Multi-file | | | ✓ |
| Word semantics | | ✓ | |

### Runtime Functions Tested

| Function | Tested |
|----------|--------|
| `putchar()` | ✓ |
| `getchar()` | Partial |
| `printf()` | Partial |
| `print()` | ✓ |

---

## Word Semantics Tests

### Specialized Test Script

A dedicated test script validates word arithmetic edge cases across different modes:

```bash
./tests/test_word_semantics.sh
```

### Test Coverage

The word semantics tests verify that the compiler handles arithmetic edge cases correctly, avoiding host-C undefined behavior:

| Test Case | 16-bit | 32-bit | Host |
|-----------|--------|--------|------|
| Large shift counts (masked) | ✓ | ✓ | ✓ |
| `1 << 15` = -32768 | ✓ | | |
| `1 << 31` = -2147483648 | | ✓ | |
| `-1 >> 1` = positive (logical) | ✓ | | |
| Overflow wrapping | ✓ | ✓ | |
| Negation of MIN value | ✓ | | |
| Compound shift assignments | ✓ | ✓ | ✓ |
| Bitwise AND/OR | ✓ | ✓ | ✓ |

### Basic Word Semantics Test

The `run/word_semantics.b` test validates basic arithmetic operations:

```b
/* Tests: shifts, bitwise ops, arithmetic, compound assignments */
main() {
    auto a, b, r;
    
    /* Shift operations */
    a = 1;
    r = a << 4;           /* Should be 16 */
    if (r != 16) return(2);
    
    /* Bitwise operations */
    a = 255;
    b = 15;
    r = a & b;            /* Should be 15 */
    if (r != 15) return(4);
    
    /* Compound shift assignments */
    a = 1;
    a =<< 3;              /* Should be 8 */
    if (a != 8) return(8);
    
    return(0);
}
```

### 16-bit Mode Tests

Run specific 16-bit tests:

```bash
# Test overflow wrapping
./bcc --word=16 test.b -o test

# In 16-bit mode:
# 32767 + 1 = -32768 (overflow wrap)
# 1 << 15 = -32768 (sign bit set)
# -1 >> 1 = 32767 (logical right shift)
```

### Safety Guarantees

The word semantics implementation guarantees:

1. **No undefined behavior**: All operations are well-defined in the generated C
2. **Deterministic results**: Same output on all platforms/compilers
3. **Historical accuracy**: Matches PDP-11 B behavior in 16-bit mode
4. **Large shift protection**: Shift counts masked to valid range

---

## Continuous Integration

To integrate with CI systems:

```bash
# Run tests and capture exit code
./tests/run_tests.sh
EXIT_CODE=$?

# Exit code is 0 for success, 1 for failure
exit $EXIT_CODE
```

### GitHub Actions Example

```yaml
name: Test
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build
        run: make
      - name: Run Tests
        run: ./tests/run_tests.sh
```

---

## See Also

- [BCC Compiler README](README.md)
- [B Language Reference](B_LANGUAGE.md)
- [Examples](WIKI_EXAMPLES.md)

