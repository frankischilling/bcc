# B Programming Language Reference

This document provides comprehensive documentation for the B programming language as implemented by the **BCC compiler**. BCC targets the Thompson B dialect (PDP-11, 1972) while supporting modern host systems.

---

## Overview

**B** is a simple, typeless programming language developed by Ken Thompson at Bell Labs as the predecessor to C. B was designed for systems programming on early Unix systems and influenced the development of C.

**BCC** is a modern B compiler that transpiles B source code to C, then compiles with GCC. It faithfully implements historical B semantics while providing configurable word sizes and pointer modes for compatibility and portability.

---

## Language Characteristics

- **Untyped Language:** No built-in type system; all values are "words"
- **No Type Declarations:** Variables always hold machine words (integers)
- **Implicit Operations:** All operations act on word-sized values
- **Configurable Word Size:** `--word=host` (default), `--word=16` (PDP-11), or `--word=32`

### Memory Model

- **Word-Addressed (default):** Pointers refer to word boundaries, not bytes
- **Byte-Addressed (`--byteptr`):** Standard byte-addressed pointers (modern C semantics)
- **Character Packing:** Multi-character constants are packed into single words
- **String Termination:** Strings use `*e` (EOT, ASCII 4) as terminator, not null bytes

### Endianness

In word-addressed mode, `char()` and `lchar()` use little-endian byte packing:
- Byte 0 is stored at the least-significant position (LSB)
- This matches PDP-11 conventions
- Use `--byteptr` mode for maximum cross-platform portability

---

## Syntax and Features

### Program Structure

A B program consists of:
- External variable declarations (`extrn`) — **variables only, not functions**
- Function definitions
- Global variable definitions

```b
/* Block comments are supported */
// C++ style line comments are also supported

// External variable declarations (for variables defined in other files)
extrn shared_counter;

// Global variable definition
counter 0;

// Function definition
main() {
    // Function body
}
```

**Important:** The `extrn` keyword is only for variables. Functions are automatically visible across all source files in multi-file compilation.

### Comments

BCC supports two comment styles:

```b
/* Traditional block comments
   can span multiple lines */

// C++ style line comments (single line)
```

### Variable Declarations

**Auto Variables (local scope):**
```b
auto x;           // Single variable
auto y, z;        // Multiple variables
auto x 42;        // Variable with initializer
auto arr[10];     // Array (allocates 10 words)
auto vec[5] 1,2,3,4,5;  // Array with initialization
```

**External Variables (cross-file references):**
```b
extrn x;          // Declaration only (variable defined in another file)
```

**Global Variable Definitions:**
```b
x;                // Define global variable (initialized to 0)
x 42;             // Define with initialization
arr[10];          // Array definition
arr[5] 1,2,3,4,5; // Array with initialization
```

---

### Functions

Function definitions in B have a simple syntax:

```b
function_name(parameter1, parameter2) {
    auto local_var;
    // Function body
    return expression;
}
```
**Function Calls:**

```b
result = function_name(arg1, arg2);
putchar('A');
```

**Note:** Functions do not need `extrn` declarations. All functions are automatically visible across all source files.

---

### Expressions

#### Operators and Precedence

B's operator precedence (highest to lowest):

1. **Primary:** `x`, `123`, `"string"`, `(expr)`, `func(args)`, `arr[index]`
2. **Unary:** `-`, `!`, `~`, `*`, `&`, `++`, `--`
3. **Multiplicative:** `*`, `/`, `%`
4. **Additive:** `+`, `-`
5. **Shift:** `<<`, `>>`
6. **Relational:** `<`, `<=`, `>`, `>=`
7. **Equality:** `==`, `!=`
8. **Bitwise AND:** `&`
9. **Bitwise XOR:** `^`
10. **Bitwise OR:** `|`
11. **Ternary:** `? :`
12. **Assignment:** `=`, `=+`, `=-`, `=*`, `=/`, `=%`, `=<<`, `=>>`, `=&`, `=|`

---

#### Assignment Operators

B uses unique compound assignment operators where the operation is written **after** the `=` sign:

```b
x =+ 5;    // Equivalent to C's: x += 5    (add 5 to x)
x =- 3;    // Equivalent to C's: x -= 3    (subtract 3 from x)
x =* 2;    // Equivalent to C's: x *= 2    (multiply x by 2)
x =/ 4;    // Equivalent to C's: x /= 4    (divide x by 4)
x =% 3;    // Equivalent to C's: x %= 3    (modulus by 3)
x =& 0xFF; // Equivalent to C's: x &= 0xFF (bitwise AND)
x =| 0x80; // Equivalent to C's: x |= 0x80 (bitwise OR)
x =<< 2;   // Equivalent to C's: x <<= 2   (left shift)
x =>> 1;   // Equivalent to C's: x >>= 1   (right shift)
```

---

#### Relational Assignment Operators

B supports relational assignments:

```b
x =< y;    // x = (x <  y)
x => y;    // x = (x >  y)
x =<= y;   // x = (x <= y)
x =>= y;   // x = (x >= y)
x === y;   // x = (x == y)
x =!= y;   // x = (x != y)
```

---

## Control Structures

### Conditional Statements

```b
if (condition) {
    // then branch
}

if (condition) {
    // then branch
} else {
    // else branch
}
```

### Loops

**While Loop:**
```b
while (condition) {
    // loop body
}
```

**Note:** B does not have a `for` loop. Use `while` instead:
```b
auto i 0;
while (i < 10) {
    // loop body
    i =+ 1;
}
```

### Switch Statements

Switch statements have **fall-through** behavior by default (no `break` statement in B):

```b
switch (expression) {
case 1:
    // statements for case 1
    // falls through to case 2
case 2:
    // statements for case 2
}
```

### Goto and Labels

```b
goto label_name;

label_name:
    statement;
```

---

## Data Types and Literals

### Numeric Literals

```b
123     // Decimal
0123    // Octal (leading zero)
```

### Character Constants

```b
'A'        // Single character (ASCII value)
'AB'       // Two characters packed into one word
'ABCD'     // Four characters packed (word-size dependent)
```

### Escape Sequences

B uses `*` as the escape character (not backslash):

| Escape | Meaning              | ASCII |
|--------|----------------------|-------|
| `*n`   | Newline              | 10    |
| `*t`   | Tab                  | 9     |
| `*e`   | End-of-text (EOT)    | 4     |
| `*0`   | Null character       | 0     |
| `**`   | Literal asterisk     | 42    |
| `*'`   | Single quote         | 39    |
| `*"`   | Double quote         | 34    |

### String Literals

```b
"hello world"        // String literal (EOT terminated)
"hello*e"            // Explicit EOT termination
"line 1*nline 2"     // Embedded newline
"say *"hello*""      // Embedded quotes
```

---

## Arrays and Pointers

### Array Declaration and Access

```b
auto arr[10];    // Declare array of 10 words
arr[0] = 1;      // First element
arr[9] = 10;     // Last element (0-indexed)
```

### Pointer Operations

```b
auto p;          // Pointer variable
auto x 42;
p = &x;          // Address-of operator
value = *p;      // Dereference operator (value == 42)
```

### Word vs Byte Addressing

**Word Addressing (default):**
- Pointers store word indices
- `arr[i]` accesses the i-th word
- Compatible with original B semantics

**Byte Addressing (`--byteptr`):**
- Pointers store byte addresses
- Standard C pointer semantics
- Better for interop with C code

---

## Multi-File Compilation

BCC supports compiling multiple B source files into a single executable:

```bash
bcc lib.b main.b -o program
```

### Cross-File Visibility

- **Functions:** Automatically visible across all files (no declaration needed)
- **Variables:** Use `extrn` to access variables defined in other files

**File: lib.b**
```b
// Global variable definition
counter 0;

// Function definition
increment() {
    counter =+ 1;
    return counter;
}
```

**File: main.b**
```b
// Access variable from lib.b
extrn counter;

main() {
    printf("Before: %d*n", counter);
    increment();  // No extrn needed for functions
    printf("After: %d*n", counter);
}
```

---

## Advanced Features

### Comma-Separated Initializers

B supports comma-separated initializers for external variables:

```b
// Scalar initialization
x 42;

// Array initialization
arr[5] 1, 2, 3, 4, 5;

// Blob initialization (contiguous words)
data { 10, 20, 30, 40 };
```

### Vector Operations

Arrays in B are word-addressed by default:

```b
auto vec[100];
vec[0] = 1;        // First element
vec[99] = 100;     // Last element
```

### Function Parameters

Functions can take parameters:

```b
print_number(n) {
    putchar(n + '0');
}

main() {
    print_number(5);
}
```

---

## Runtime Library

BCC provides a comprehensive runtime library with these functions:

### Input/Output

| Function | Description |
|----------|-------------|
| `putchar(c)` | Output one character |
| `getchar()` | Read one character (returns -1 on EOF) |
| `print(n)` | Print integer value |
| `printf(fmt, ...)` | Formatted output (supports `%d`, `%o`, `%c`, `%s`) |
| `printn(n, base)` | Print integer in given base |

### Character/String Functions

| Function | Description |
|----------|-------------|
| `char(str, i)` | Get byte at index `i` from word array `str` |
| `lchar(str, i, c)` | Set byte at index `i` in word array `str` to `c` |

### Memory

| Function | Description |
|----------|-------------|
| `getvec(n)` | Allocate `n` words of memory |
| `rlsevec(ptr, n)` | Release allocated memory |

### File I/O

| Function | Description |
|----------|-------------|
| `open(name, mode)` | Open file (mode: 0=read, 1=write) |
| `close(fd)` | Close file descriptor |
| `read(fd, buf, n)` | Read up to `n` bytes |
| `write(fd, buf, n)` | Write `n` bytes |
| `creat(name, mode)` | Create file with permissions |
| `seek(fd, offset, whence)` | Seek in file |

### Process Control

| Function | Description |
|----------|-------------|
| `exit(code)` | Terminate program |
| `fork()` | Create child process |
| `wait()` | Wait for child process |
| `execl(path, arg0, ..., 0)` | Execute program |
| `execv(path, argv)` | Execute with argument vector |

### System Functions

| Function | Description |
|----------|-------------|
| `time(tvp)` | Get current time |
| `getuid()` | Get user ID |
| `chdir(path)` | Change directory |
| `unlink(path)` | Delete file |

### Time/Delay

| Function | Description |
|----------|-------------|
| `usleep(microseconds)` | Sleep for specified microseconds |

### Math/Compatibility Helpers

| Function | Description |
|----------|-------------|
| `sx64(x)` | Sign-extend 16-bit value to word size |

---

## Implementation Details

### Word Semantics Modes

BCC supports configurable word sizes via the `--word` flag:

#### `--word=host` (default)
- Uses native host word size (typically 64-bit)
- No arithmetic wraparound
- Best performance
- Recommended for new programs

#### `--word=16`
- Emulates PDP-11 16-bit word semantics
- Arithmetic wraps at 16-bit boundaries (-32768 to 32767)
- `32767 + 1` wraps to `-32768`
- Use for historical B programs

#### `--word=32`
- Emulates 32-bit word semantics
- Arithmetic wraps at 32-bit boundaries

### Affected Operations

When using `--word=16` or `--word=32`, these operations wrap:
- Binary arithmetic: `+`, `-`, `*`, `/`, `%`, `<<`, `>>`, `&`, `|`
- Unary negation: `-x`
- Increment/decrement: `++`, `--`
- Compound assignments: `=+`, `=-`, `=*`, `=/`, `=%`, `=<<`, `=>>`, `=&`, `=|`

### Pointer Models

**Word Addressing (default):**
- Pointers store word indices
- `ptr[i]` accesses word at index `i`
- Original B semantics

**Byte Addressing (`--byteptr`):**
- Pointers store byte addresses
- Standard C pointer semantics
- Better portability

### Scope Rules

- **Global Scope:** Functions and global variables
- **Function Scope:** Parameters and auto variables
- **Block Scope:** Variables declared within compound statements

### Error Handling

B has minimal runtime error checking:

- **No Bounds Checking:** Array access can overflow
- **No Null Pointer Checks:** Invalid pointer dereference crashes
- **No Type Safety:** All values are words

---

## Compiler Usage

### Basic Compilation

```bash
bcc program.b -o program    # Compile and link
./program                   # Run
```

### Multi-File Compilation

```bash
bcc lib.b main.b -o program
```

### Compiler Flags

| Flag | Description |
|------|-------------|
| `-o FILE` | Output executable name |
| `-c` | Compile only (no link) |
| `--emit-c` | Keep generated C files alongside sources |
| `--keep-c` | Keep temporary C files |
| `--word=N` | Word size: `host`, `16`, or `32` |
| `--byteptr` | Use byte-addressed pointers |
| `-v` | Verbose output |

---

## Historical Context

### Development Timeline

- **1969:** B development begins
- **1971:** B in active use at Bell Labs
- **1972:** B runs on Unix v1, PDP-11
- **1973:** B used for Unix v4 development
- **1974–1975:** B evolves toward C
- **1978:** C supersedes B for Unix development

### Key Innovations

- **Single Data Type:** Simplifies compiler design
- **Word Addressing:** Efficient on PDP-11
- **Compact Syntax:** Influenced C
- **Comprehensive Runtime Library:** Provided rich system interface

### Evolution to C

B directly influenced C's development:

- **Type System:** C added a type system to B's typeless roots
- **Syntax:** Many B constructs carried into C
- **Libraries:** B's runtime became C’s standard library
- **Philosophy:** B's simplicity deeply informed C’s design principles

---

## Examples

### Hello World

```b
main() {
    printf("hello, world*n");
}
```

### Factorial

```b
fact(n) {
    if (n <= 1) return 1;
    return n * fact(n - 1);
}

main() {
    auto i 1;
    while (i <= 10) {
        printf("%d! = %d*n", i, fact(i));
        i =+ 1;
    }
}
```

### Fibonacci

```b
fib(n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

main() {
    auto i 0;
    while (i < 15) {
        printf("fib(%d) = %d*n", i, fib(i));
        i =+ 1;
    }
}
```

### Character Processing

```b
// Convert lowercase to uppercase
main() {
    auto c;
    while ((c = getchar()) != '*e') {
        if (c >= 'a' & c <= 'z') {
            c =- ('a' - 'A');
        }
        putchar(c);
    }
}
```

### Array Operations

```b
main() {
    auto arr[10], i;

    // Fill array with squares
    i = 0;
    while (i < 10) {
        arr[i] = i * i;
        i =+ 1;
    }

    // Print array
    i = 0;
    while (i < 10) {
        printf("%d: %d*n", i, arr[i]);
        i =+ 1;
    }
}
```

### Prime Number Check

```b
is_prime(n) {
    auto i;
    if (n < 2) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;
    
    i = 3;
    while (i * i <= n) {
        if (n % i == 0) return 0;
        i =+ 2;
    }
    return 1;
}

main() {
    auto n 2;
    printf("Primes under 50:*n");
    while (n < 50) {
        if (is_prime(n)) {
            printf("%d ", n);
        }
        n =+ 1;
    }
    printf("*n");
}
```

---

## References

### Primary Sources

- *Users' Reference to B* — Ken Thompson, Bell Labs (1972)
- *B Reference Manual* — Bell Labs
- *Unix Programmer's Manual v1*

### See Also

- [BCC Compiler README](README.md)
- [Runtime Library Reference](WIKI_RUNTIME_LIBRARY.md)
- [Data Types & Literals](WIKI_DATA_TYPES.md)
- [Examples](WIKI_EXAMPLES.md)
- [File I/O](WIKI_FILE_IO.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
