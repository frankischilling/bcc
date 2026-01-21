# String Operations

B's string handling is fundamentally different from modern languages. Strings are word arrays terminated with `*e` (EOT, ASCII 4) instead of null bytes. Character constants can pack up to 4 ASCII bytes into a single word (right-justified); strings themselves are typically packed 1-2 characters per 16-bit word. This page covers all aspects of string manipulation in the B programming language.

---

## String Fundamentals

### String Representation

B strings are stored as contiguous word arrays with `*e` termination:

```b
// Conceptual representation of "hi*e"
word string_array[] = {
    ('h' << 8) | 'i',    // Packed characters: 'h' + 'i'
    ('*' << 8) | 'e'     // Terminator: '*' + 'e'
};
```

**Key Characteristics:**
- **No null termination**: Uses `*e` (EOT, ASCII 4)
- **Character packing**: 1-2 characters per 16-bit word (string storage)
- **Word addressing**: Strings are word arrays, not byte arrays
- **Manual management**: No automatic bounds checking

### String Literals

```b
"hello world"        // Compiler adds *e automatically
"hello*e"           // Explicit *e termination
"multi
line"              // Multi-line strings supported
"escape*t"         // Tab character
```

---

## Character Operations

### Character Access Functions

```b
// Get character at string position
char(string_ptr, index) → character

// Set character at string position
lchar(string_ptr, index, new_char) → new_char
```

**Examples:**
```b
auto str 20;
lchar(str, 0, `H');
lchar(str, 1, `i');
lchar(str, 2, `*e');         // Terminate

auto first;
first = char(str, 0);         // Gets 'H'

auto second;
second = char(str, 1);        // Gets 'i'
```

### Pointer Modes and Byte Packing

The behavior of `char()` and `lchar()` depends on the pointer mode:

**Byte-Addressed Mode (`--byteptr`, default):**
- Bytes are accessed directly from memory
- `char(str, i)` reads byte at address `str + i`
- Works naturally with C strings

**Word-Addressed Mode (no `--byteptr`):**
- Bytes are packed into words with byte 0 at the LSB
- Multiple bytes share each word (e.g., 8 bytes per 64-bit word)
- `char(str, i)` extracts byte `i` from the packed words
- Matches original PDP-11 B behavior

**Endianness Note:**
In word-addressed mode, bytes are packed with byte 0 at the least-significant position (PDP-11/little-endian convention). The implementation operates on word values, not memory layout, so behavior is consistent regardless of host endianness—as long as all access goes through `char()`/`lchar()`.

### Character Packing

B packs 1-2 characters into each 16-bit word for strings (character constants may include up to 4 ASCII bytes):

```b
// Single character in a word
auto ch;
ch = `A';                   // 0x0041 (ASCII 'A' in low byte)

// Packed characters
auto packed;
packed = `Hi';              // 0x4869 ('H' high byte, 'i' low byte)

// Extracting packed characters
auto high;
high = packed >> 8;         // 'H' (72)

auto low;
low = packed & 255;         // 'i' (105)
```

---

## String Manipulation Patterns

### String Length

```b
strlen(s) {
    auto len;
    len = 0;
    while (char(s, len) != '*e') {
        len =+ 1;
    }
    return len;
}
```

### String Copy

```b
strcpy(dest, src) {
    auto i;
    i = 0;
    auto c;
    while ((c = char(src, i)) != '*e') {
        lchar(dest, i, c);
        i =+ 1;
    }
    lchar(dest, i, '*e');
    return dest;
}
```

### String Comparison

```b
strcmp(s1, s2) {
    auto i;
    i = 0;
    auto c1, c2;
    while (1) {
        c1 = char(s1, i);
        c2 = char(s2, i);
        if (c1 != c2) return c1 - c2;
        if (c1 == '*e') return 0;  // Equal
        i =+ 1;
    }
}
```

### String Concatenation

```b
strcat(dest, src) {
    auto dest_len;
    dest_len = strlen(dest);
    auto i;
    i = 0;
    auto c;
    while ((c = char(src, i)) != '*e') {
        lchar(dest, dest_len + i, c);
        i =+ 1;
    }
    lchar(dest, dest_len + i, '*e');
    return dest;
}
```

### Substring Extraction

```b
substring(dest, src, start, length) {
    auto i;
    i = 0;
    while (i < length) {
        auto c;
        c = char(src, start + i);
        if (c == '*e') break;
        lchar(dest, i, c);
        i =+ 1;
    }
    lchar(dest, i, '*e');
    return dest;
}
```

---

## Advanced String Techniques

### String Building with Buffers

```b
// Dynamic string building
auto buffer[256];
auto pos;
    pos = 0;

append_char(buffer, pos_ptr, ch) {
    lchar(buffer, *pos_ptr, ch);
    *pos_ptr =+ 1;
}

append_string(buffer, pos_ptr, str) {
    auto i;
    i = 0;
    auto c;
    while ((c = char(str, i)) != '*e') {
        lchar(buffer, *pos_ptr, c);
        *pos_ptr =+ 1;
        i =+ 1;
    }
}

terminate_string(buffer, pos) {
    lchar(buffer, pos, '*e');
}

// Usage
auto buf[100];
auto pos;
    pos = 0;
append_string(buf, &pos, "Hello ");
append_string(buf, &pos, "World");
append_char(buf, &pos, `!');
terminate_string(buf, pos);
// buf now contains "Hello World!*e"
```

### Number to String Conversion

```b
// Integer to string
utoa(num, buffer) {
    if (num == 0) {
        lchar(buffer, 0, `0');
        lchar(buffer, 1, `*e');
        return buffer;
    }

    auto temp[10];  // Enough for 16-bit
    auto i;
    i = 0;
    auto negative;
    negative = 0;

    if (num < 0) {
        negative = 1;
        num = -num;
    }

    while (num > 0) {
        temp[i++] = `0' + (num % 10);
        num =/ 10;
    }

    auto pos;
    pos = 0;
    if (negative) {
        lchar(buffer, pos++, `-');
    }

    while (i > 0) {
        lchar(buffer, pos++, temp[--i]);
    }
    lchar(buffer, pos, '*e');
    return buffer;
}
```

### String Tokenization

```b
// Simple word tokenizer (B-style - limited by B's string handling)
tokenize(text, buffer, delimiters) {
    auto word_start;
    word_start = 0;
    auto i;
    i = 0;
    auto word_count;
    word_count = 0;

    while (char(text, i) != '*e') {
        auto c;
        c = char(text, i);

        // Check if delimiter
        auto is_delim;
        is_delim = 0;
        auto j;
        j = 0;
        while (char(delimiters, j) != '*e') {
            if (c == char(delimiters, j)) {
                is_delim = 1;
                break;
            }
            j =+ 1;
        }

        if (is_delim) {
            if (i > word_start) {
                // Copy word to buffer
                auto k;
                k = 0;
                while (word_start + k < i) {
                    lchar(buffer, word_count * 20 + k, char(text, word_start + k));
                    k =+ 1;
                }
                lchar(buffer, word_count * 20 + k, '*e');
                word_count =+ 1;
                if (word_count >= 10) break;  // Max 10 words
            }
            word_start = i + 1;
        }

        i =+ 1;
    }

    // Handle final word
    if (i > word_start && word_count < 10) {
        auto k;
        k = 0;
        while (word_start + k < i) {
            lchar(buffer, word_count * 20 + k, char(text, word_start + k));
            k =+ 1;
        }
        lchar(buffer, word_count * 20 + k, '*e');
        word_count =+ 1;
    }

    return word_count;
}
```

---

## Character Classification

### Character Testing Functions

```b
is_digit(c) {
    return c >= `0' && c <= `9';
}

is_alpha(c) {
    return (c >= `a' && c <= `z') || (c >= `A' && c <= `Z');
}

is_alnum(c) {
    return is_alpha(c) || is_digit(c);
}

is_space(c) {
    return c == ` ' || c == `*t' || c == `*n' || c == `*r';
}

is_upper(c) {
    return c >= `A' && c <= `Z';
}

is_lower(c) {
    return c >= `a' && c <= `z';
}
```

### Case Conversion

```b
to_upper(c) {
    if (is_lower(c)) {
        return c + (`A' - `a');
    }
    return c;
}

to_lower(c) {
    if (is_upper(c)) {
        return c + (`a' - `A');
    }
    return c;
}

toggle_case(c) {
    if (is_upper(c)) return to_lower(c);
    if (is_lower(c)) return to_upper(c);
    return c;
}
```

### String Case Conversion

```b
str_upper(str) {
    auto i;
    i = 0;
    auto c;
    while ((c = char(str, i)) != '*e') {
        lchar(str, i, to_upper(c));
        i =+ 1;
    }
    return str;
}

str_lower(str) {
    auto i;
    i = 0;
    auto c;
    while ((c = char(str, i)) != '*e') {
        lchar(str, i, to_lower(c));
        i =+ 1;
    }
    return str;
}
```

---

## String Searching

### Character Search

```b
strchr(str, ch) {
    auto i;
    i = 0;
    auto c;
    while ((c = char(str, i)) != '*e') {
        if (c == ch) return i;
        i =+ 1;
    }
    return -1;  // Not found
}

strrchr(str, ch) {
    auto len;
    len = strlen(str);
    auto i;
    i = len - 1;
    while (i >= 0) {
        if (char(str, i) == ch) return i;
        i =- 1;
    }
    return -1;  // Not found
}
```

### Substring Search

```b
strstr(haystack, needle) {
    auto h_len;
    h_len = strlen(haystack);
    auto n_len;
    n_len = strlen(needle);

    if (n_len == 0) return 0;
    if (n_len > h_len) return -1;

    auto i;
    i = 0;
    while (i <= h_len - n_len) {
        auto j;
    j = 0;
        auto found;
    found = 1;

        while (j < n_len) {
            if (char(haystack, i + j) != char(needle, j)) {
                found = 0;
                break;
            }
            j =+ 1;
        }

        if (found) return i;
        i =+ 1;
    }

    return -1;  // Not found
}
```

---

## Memory Operations

### Block Copy Functions

```b
memcpy(dest, src, count) {
    auto i;
    i = 0;
    while (i < count) {
        lchar(dest, i, char(src, i));
        i =+ 1;
    }
    return dest;
}

memmove(dest, src, count) {
    // Handle overlapping regions
    if (dest < src) {
        // Copy forward
        auto i;
    i = 0;
        while (i < count) {
            lchar(dest, i, char(src, i));
            i =+ 1;
        }
    } else {
        // Copy backward
        auto i;
        i = count - 1;
        while (i >= 0) {
            lchar(dest, i, char(src, i));
            i =- 1;
        }
    }
    return dest;
}
```

### Memory Comparison

```b
memcmp(s1, s2, count) {
    auto i;
    i = 0;
    while (i < count) {
        auto c1;
        c1 = char(s1, i);
        auto c2;
        c2 = char(s2, i);
        if (c1 != c2) return c1 - c2;
        i =+ 1;
    }
    return 0;  // Equal
}
```

---

## Formatted Output

### Printf-Style Formatting

B's `printf` function supports basic formatting:

```b
printf("Hello, %s!*n", name);
printf("Count: %d, Value: %o*n", count, value);
printf("Character: %c*n", ch);
```

**Format Implementation:**
```b
// Conceptual printf implementation
printf(fmt, ...) {
    auto s;
    s = fmt;
    auto arg_index;
    arg_index = 0;

    while (*s) {
        if (*s != '%') {
            putchar(*s);
            s++;
            continue;
        }

        s++;  // Skip '%'
        switch (*s) {
        case 'd':
            // Print decimal
            break;
        case 'o':
            // Print octal
            break;
        case 'c':
            // Print character
            break;
        case 's':
            // Print string until *e
            break;
        }
        s++;
    }
}
```

### Number Formatting

```b
// Print number in any base
print_base(n, base) {
    if (n == 0) {
        putchar('0');
        return;
    }

    if (n < 0 && base == 10) {
        putchar('-');
        n = -n;
    }

    // Convert to digits (in reverse)
    auto digits[16];
    auto i;
    i = 0;

    while (n > 0) {
        digits[i++] = (n % base) + '0';
        n =/ base;
    }

    // Print in correct order
    while (i > 0) {
        putchar(digits[--i]);
    }
}
```

---

## Complete Examples

### Text Processing Program

```b
// Word frequency counter
main() {
    auto buffer[1024];
    auto word_count[256];    // Simple hash table
    auto max_words;
    max_words = 256;

    printf("Enter text (end with Ctrl+D):*n");

    // Read all input
    auto pos;
    pos = 0;
    auto c;
    while ((c = getchar()) >= 0 && pos < 1024) {
        buffer[pos++] = c;
    }
    lchar(buffer, pos, '*e');

    // Tokenize and count
    count_words(buffer, word_count, max_words);

    // Display results
    printf("*nWord frequencies:*n");
    display_frequencies(word_count, max_words);
}

count_words(text, counts, max_words) {
    auto i;
    i = 0;
    auto word_start;
    word_start = -1;

    while (char(text, i) != '*e') {
        auto c;
    c = char(text, i);

        if (is_alpha(c)) {
            if (word_start == -1) {
                word_start = i;
            }
        } else {
            if (word_start != -1) {
                // Found word end
                auto word_len;
    word_len = i - word_start;
                if (word_len < 20) {  // Reasonable word length
                    // Extract word
                    auto word[20];
                    substring(word, text, word_start, word_len);

                    // Convert to lowercase for counting
                    str_lower(word);

                    // Count this word
                    auto hash;
    hash = simple_hash(word);
                    counts[hash % max_words] =+ 1;
                }
                word_start = -1;
            }
        }

        i =+ 1;
    }
}

simple_hash(word) {
    auto hash;
    hash = 0;
    auto i;
    i = 0;
    auto c;
    while ((c = char(word, i)) != '*e') {
        hash = hash * 31 + c;
        i =+ 1;
    }
    return hash;
}

display_frequencies(counts, max_words) {
    auto i;
    i = 0;
    while (i < max_words) {
        if (counts[i] > 0) {
            printf("Slot %d: %d*n", i, counts[i]);
        }
        i =+ 1;
    }
}
```

### Simple Text Editor Commands

```b
// Basic line editor commands
process_command(cmd, buffer) {
    // Commands: p (print), d (delete), i (insert), q (quit)

    auto cmd_char;
    cmd_char = char(cmd, 0);

    if (cmd_char == `p') {
        printf("%s*n", buffer);
    } else if (cmd_char == `d') {
        // Delete all text
        lchar(buffer, 0, `*e');
        printf("Buffer cleared*n");
    } else if (cmd_char == `i') {
        printf("Enter text to insert: ");
        auto insert_pos;
    insert_pos = strlen(buffer);
        auto pos;
    pos = insert_pos;
        auto c;
        while ((c = getchar()) != `*n' && c != `*e') {
            lchar(buffer, pos++, c);
        }
        lchar(buffer, pos, `*e');
        printf("Text inserted*n");
    } else if (cmd_char == `q') {
        return 1;  // Quit
    } else {
        printf("Unknown command*n");
    }

    return 0;  // Continue
}

line_editor() {
    auto buffer[1024];
    lchar(buffer, 0, '*e');  // Empty buffer

    printf("Simple Line Editor*n");
    printf("Commands: p (print), d (delete), i (insert), q (quit)*n");

    while (1) {
        printf("> ");
        auto cmd[10];
        read_line(cmd, 10);

        if (process_command(cmd, buffer)) {
            break;  // Quit
        }
    }
}

read_line(buffer, max_len) {
    auto i;
    i = 0;
    auto c;
    while (i < max_len - 1 && (c = getchar()) != '*n' && c != '*e') {
        lchar(buffer, i++, c);
    }
    lchar(buffer, i, '*e');
    return i;
}
```

---

## Performance Considerations

### String Operation Efficiency

**Character Access:**
- `char()`/`lchar()`: Direct array access, very fast
- Packed characters: May require bit operations
- Word boundaries: Aligned access for best performance

**String Traversal:**
- Length operations: O(n) - must scan to `*e`
- Copy operations: O(n) - character-by-character
- Search operations: O(n*m) for substring search

### Memory Usage

**String Storage:**
- 1-2 characters per word (8-16 bits per character)
- Overhead: One word for `*e` termination
- No length prefix: Requires scanning for length

**Buffer Management:**
- Fixed-size buffers prevent overflow
- Dynamic allocation via `alloc()`
- Manual memory management required

### Optimization Techniques

**Avoid Repeated Length Calculations:**
```b
// Bad: strlen called multiple times
if (strlen(s) > 0 && char(s, strlen(s) - 1) == 'x')

// Good: calculate once
auto len;
    len = strlen(s);
if (len > 0 && char(s, len - 1) == 'x')
```

**Use Buffer Pre-allocation:**
```b
// Pre-allocate for multiple operations
auto temp[256];
utoa(number, temp);
// Use temp...
utoa(another, temp);
// Reuse buffer
```

---

## Error Handling

### Bounds Checking

```b
safe_char(str, index) {
    auto len;
    len = strlen(str);
    if (index < 0 || index >= len) {
        printf("String index out of bounds*n");
        return '*e';
    }
    return char(str, index);
}

safe_lchar(str, index, c) {
    auto len;
    len = strlen(str);
    if (index < 0 || index > len) {  // Allow writing terminator
        printf("String index out of bounds*n");
        return '*e';
    }
    return lchar(str, index, c);
}
```

### Buffer Overflow Prevention

```b
strncpy(dest, src, max_len) {
    auto i;
    i = 0;
    auto c;
    while (i < max_len - 1 && (c = char(src, i)) != '*e') {
        lchar(dest, i, c);
        i =+ 1;
    }
    lchar(dest, i, '*e');
    return dest;
}
```

---

## Differences from C Strings

| Feature | B Strings | C Strings |
|---------|-----------|-----------|
| Termination | `*e` (EOT) | `\0` (NUL) |
| Character Packing (strings) | 1-2 per word | 1 per byte |
| Memory Model | Word-addressed | Byte-addressed |
| Length Operation | O(n) scan | O(1) if cached |
| Library Functions | `char`/`lchar` | `str*` functions |
| Buffer Management | Manual | Library assisted |

---

## Function Reference

### Character Operations
| Function | Signature | Description |
|----------|-----------|-------------|
| `char` | `(s, i) → c` | Get character at index |
| `lchar` | `(s, i, c) → c` | Set character at index |

### Output Functions
| Function | Signature | Description |
|----------|-----------|-------------|
| `putchar` | `(c) → c` | Output character |
| `printf` | `(fmt, ...) → 0` | Formatted output |
| `print` | `(n) → n` | Print number |

### Input Functions
| Function | Signature | Description |
|----------|-----------|-------------|
| `getchar` | `() → c/*e` | Input character |
| `getchr` | `() → c/4` | Raw input character |

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [Runtime Library](WIKI_RUNTIME_LIBRARY.md)
- [I/O Functions](WIKI_IO_FUNCTIONS.md)
- [File I/O](WIKI_FILE_IO.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
- [Data Types & Literals](WIKI_DATA_TYPES.md)
- [Arrays & Pointers](WIKI_ARRAYS_POINTERS.md)
- [Examples](WIKI_EXAMPLES.md)
