# Data Types & Literals

B is a **typeless programming language** - all data is represented as machine "words". On the original PDP-11, words were 16-bit integers; modern implementations support configurable word sizes.

---

## Core Principle: Everything is a Word

```b
// In B, everything is a word (integer)
auto x;
x = 42;             // x holds the value 42

auto y;
y = `A';            // y holds 65 (ASCII value of 'A')

auto z;
z = "hi";           // z holds address of string
```

**Key Characteristics:**
- **Single Data Type**: All values are words
- **No Type System**: No type declarations or type checking
- **Implicit Operations**: All operations work on word-sized integers
- **Configurable Word Size**: Use `--word` flag to select word semantics

---

## Word Size Modes

The `bcc` compiler supports multiple word semantics via the `--word` flag:

### `--word=host` (default)
- Uses native host word size (typically 64-bit on modern systems)
- No arithmetic wraparound
- Best performance for new programs
- Large constants like `5242880` work correctly

### `--word=16`
- Emulates PDP-11 16-bit word semantics
- Arithmetic wraps at 16-bit boundaries (-32768 to 32767)
- `32767 + 1` wraps to `-32768`
- Bitwise operations mask to 16 bits
- Use for historical B programs expecting PDP-11 behavior

### `--word=32`
- Emulates 32-bit word semantics
- Arithmetic wraps at 32-bit boundaries
- Useful for programs written for 32-bit systems

**Example:**
```bash
# Modern 64-bit compilation (default)
./bcc program.b -o prog

# PDP-11 compatibility mode
./bcc --word=16 program.b -o prog

# 32-bit mode
./bcc --word=32 program.b -o prog
```

**When to use which:**
- **New programs**: Use `--word=host` (default)
- **Porting PDP-11 B code**: Use `--word=16`
- **Programs relying on overflow behavior**: Use appropriate `--word=N`

### Safe Arithmetic (16-bit/32-bit modes)

When using `--word=16` or `--word=32`, the compiler generates code using safe arithmetic macros that prevent **undefined behavior** in the host C compiler:

**Safety guarantees:**
- **No signed overflow UB**: Arithmetic uses unsigned intermediates
- **No shift UB**: Shift counts are masked to valid range (0-15 or 0-31)
- **Logical right shifts**: `-1 >> 1` gives `32767` in 16-bit mode (not `-1`)
- **Deterministic behavior**: Same results on all platforms

**Edge cases handled correctly:**
```
1 << 15      → -32768  (16-bit: sign bit set)
1 << 20      → 16      (16-bit: shift masked to 4)
-1 >> 1     → 32767   (16-bit: logical right shift)
32767 + 1   → -32768  (16-bit: overflow wrap)
-(-32768)   → -32768  (16-bit: negation of MIN)
```

**Testing word semantics:**
```bash
# Run specialized word semantics tests
./tests/test_word_semantics.sh
```

---

## Numeric Literals

B supports several numeric literal formats:

### Decimal (Default)
```b
123      // One hundred twenty-three
0        // Zero
-42      // Negative forty-two
```

### Octal (Leading Zero)
```b
012      // Octal 12 = decimal 10
077      // Octal 77 = decimal 63
```

### Hexadecimal (if supported)
```b
0x1A     // Hex 1A = decimal 26
0xFF     // Hex FF = decimal 255
0x8000   // Hex 8000 = decimal -32768 (two's complement)
```

**Implementation Notes:**
- Leading zero indicates octal
- No explicit hexadecimal support in original B
- Negative numbers use two's complement

---

## Character Constants

B packs character constants into words, supporting 1-2 characters per constant.

### Single Character
```b
`A'      // ASCII 65
`0'      // ASCII 48
` '      // ASCII 32 (space)
```

### Packed Characters (B Extension)
```b
`AB'     // Two characters packed: 'A' in high byte, 'B' in low byte
`Hi'     // Packed string "Hi"
```

**Packing Algorithm:**
```c
// Conceptual representation
word packed = (high_char << 8) | low_char;
```

### Escape Sequences
B uses `*` as escape character (different from C's `\`):

```b
'*e'     // EOT (End of Transmission) - ASCII 4
'*n'     // Newline - ASCII 10
'*t'     // Tab - ASCII 9
'*0'     // Null character - ASCII 0
'*( '    // Left parenthesis
'*) '    // Right parenthesis
'** '    // Asterisk
'*' '    // Single quote
'*" '    // Double quote
```

**Complete Escape Table:**
| Escape | Character | ASCII | Purpose |
|--------|-----------|-------|---------|
| `*e` | `\004` | 4 | End of Transmission (EOT) |
| `*n` | `\n` | 10 | Newline |
| `*t` | `\t` | 9 | Horizontal Tab |
| `*0` | `\0` | 0 | Null |
| `*(` | `(` | 40 | Left parenthesis |
| `*)` | `)` | 41 | Right parenthesis |
| `**` | `*` | 42 | Asterisk |
| `*' ` | `'` | 39 | Single quote |
| `*" ` | `"` | 34 | Double quote |

---

## String Literals

Strings in B are word arrays terminated with `*e` (EOT).

### Basic Strings
```b
"hello world"        // String array: ['h','e','l','l','o',' ','w','o','r','l','d','*e']
"hi"                 // Packed: "hi*e"
```

### Multi-line Strings
```b
"line 1*nline 2"     // Contains actual newlines
"tab*t here"         // Contains actual tabs
```

### String Storage
Strings are stored as contiguous word arrays:
```b
// Conceptual storage for "hi"
word string_array[] = {
    ('h' << 8) | 'i',    // Packed characters
    ('*' << 8) | 'e'     // EOT terminator
};
```

---

## Array Literals

B supports comma-separated initializers for arrays:

```b
// Vector declaration
auto arr 5;

// Blob (contiguous memory) with initialization
data { 10, 20, 30, 40 };
```

**Array Bounds:**
- Arrays are word-addressed by default
- Size can be determined at runtime
- No bounds checking at runtime

---

## Pointer Literals

Pointers are word values containing addresses:

```b
auto ptr;            // Can hold any address
ptr = &variable;     // Address-of operator
value = *ptr;        // Dereference operator
```

**Pointer Arithmetic:**
```b
ptr = ptr + 1;       // Word-addressed: adds 2 bytes
ptr = ptr - 1;       // Word-addressed: subtracts 2 bytes
```

---

## Special Values

### Null/Zero Values
```b
auto x;
x = 0;               // Zero/null value

auto ptr;
ptr = 0;             // Null pointer
```

### Boolean Values
B treats any non-zero value as true:
```b
if (x) { /* true if x != 0 */ }
if (!x) { /* true if x == 0 */ }
```

### End-of-File Marker
```b
auto EOF;
EOF = '*e';           // EOT character (ASCII 4)

auto EOF2;
EOF2 = 4;             // Same as above
```

---

## Implementation Details

### Word Size and Range
- **Size**: 16 bits
- **Signed Range**: -32,768 to +32,767
- **Unsigned Range**: 0 to 65,535
- **Two's Complement**: Negative numbers

### Character Packing
```c
// How B packs characters into words
uint16_t pack_chars(char high, char low) {
    return ((uint8_t)high << 8) | (uint8_t)low;
}

char get_high(uint16_t word) {
    return (char)(word >> 8);
}

char get_low(uint16_t word) {
    return (char)(word & 0xFF);
}
```

### String Termination
```b
// B string termination
"hello*e"    // Explicit EOT
"hello"      // Compiler adds *e automatically
```

### Array Initialization
```b
// Compiler generates:
word arr[5] = {1, 2, 3, 4, 5};
word arr_ptr = &arr[0];  // Pointer to first element
```

---

## Common Patterns

### Character Processing
```b
auto c;
while ((c = getchar()) != '*e') {
    if (c >= `a' && c <= `z') {
        c = c + (`A' - `a');  // Convert to uppercase
    }
    putchar(c);
}
```

### String Building
```b
auto str[100];
auto i;
i = 0;
str[i++] = 'H';
str[i++] = 'i';
str[i++] = '*e';      // Terminate string
```

### Array Operations
```b
auto vec[10];
auto i = 0;
while (i < 10) {
    vec[i] = i * i;   // Fill with squares
    i = i + 1;
}
```

---

## Differences from C

| Feature | B | C |
|---------|---|----|
| Character literals | Packed 1-2 chars | Single char |
| String termination | `*e` (EOT) | `\0` (NUL) |
| Type system | Typeless | Rich types |
| Array bounds | Word-addressed | Byte-addressed |
| Numeric literals | Octal with 0 prefix | Multiple bases |

---

## Examples

### Complete Character Processing Program
```b
main() {
    auto buf[100];
    auto i;
    i = 0;
    auto c;

    // Read characters into buffer
    while ((c = getchar()) != '*e' && i < 100) {
        buf[i++] = c;
    }
    buf[i] = '*e';  // Terminate string

    // Process buffer (convert to uppercase)
    i = 0;
    while (buf[i] != '*e') {
        c = buf[i];
        if (c >= `a' && c <= `z') {
            buf[i] = c + (`A' - `a');
        }
        i = i + 1;
    }

    // Output result
    i = 0;
    while (buf[i] != '*e') {
        putchar(buf[i++]);
    }
}
```

### Packed Character Operations
```b
main() {
    auto packed;
    packed = `Hi';         // Pack "Hi" into one word

    auto high;
    high = packed >> 8;    // Extract 'H'

    auto low;
    low = packed & 255;    // Extract 'i'

    putchar(high);         // Output 'H'
    putchar(low);          // Output 'i'
    putchar('*n');         // Newline
}
```

---

## References

- [B Reference Manual - Character Handling](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- [B Tutorial - Data Representation](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf)
- [Users' Reference to B (1972)](https://www.bell-labs.com/usr/dmr/www/kbman.html)

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [Runtime Library](WIKI_RUNTIME_LIBRARY.md)
- [I/O Functions](WIKI_IO_FUNCTIONS.md)
- [File I/O](WIKI_FILE_IO.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
- [String Operations](WIKI_STRING_OPERATIONS.md)
- [Control Structures](WIKI_CONTROL_STRUCTURES.md)
- [Functions](WIKI_FUNCTIONS.md)
- [Arrays & Pointers](WIKI_ARRAYS_POINTERS.md)
- [Examples](WIKI_EXAMPLES.md)
