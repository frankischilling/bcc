# I/O Functions

B provides comprehensive input/output capabilities through its runtime library, supporting character I/O, formatted output, file operations, and buffered I/O. This page covers all aspects of I/O in the B programming language.

> The behavior here follows Sections 27–28 of Dennis Ritchie's original B tutorial ([btut](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.html)), which describes the core I/O model: character I/O (`getchar`/`putchar`), string I/O (`getstr`/`putstr`), formatted output (`printf`), file redirection (`openr`/`openw`), unit variables (`rd.unit`/`wr.unit`), `flush` for prompts, and `reread` for command-line input.

## I/O Essentials (quick map)
- `getchar` / `putchar`: read/write one character on the current input/output unit (`*e` on EOF from files or terminal).
- `getstr` / `putstr`: line/string I/O built on `getchar`/`putchar` (`*n` replaced by `*e` on input).
- `printf`: formatted output (Section 27); implemented via `putchar`.
- `openr(unit, name)` / `openw(unit, name)`: bind `rd.unit` / `wr.unit` to a file and redirect subsequent `getchar`/`putchar`.
- `rd.unit` / `wr.unit`: external variables holding the active units (defaults `0` input, `-1` output).
- `flush()`: force current output unit to write without adding a newline (useful for prompts).
- `reread()`: before the first read, makes `getchar`/`getstr` return the program’s command line.

---

## Character I/O

### Basic Character Output

```b
// Output single character to stdout
putchar(character) → character
putstr(string_ptr) → string_ptr
flush() → 0
```

**Examples:**
```b
putchar(`A');              // Output 'A'
putchar(65);               // Output 'A' (ASCII value)
putchar(`H'); putchar(`i'); putchar('*n');  // Output "Hi" + newline
putchar('hi!');            // Outputs "hi!" (multi-byte character constant)
putstr("hello");           // Outputs "hello"
putstr("prompt?"); flush(); getstr(buf);    // Prompt and read same line
```

**Implementation Notes:**
- Returns the character written
- Emits each non-zero byte packed into the word (so multi-character constants print multiple bytes)
- No error indication
- Buffers output for efficiency

### Basic Character Input

```b
// Input single character from stdin
getchar() → character or EOF
```

**Examples:**
```b
auto c = getchar();        // Read one character
if (c == '*e') {           // Check for end-of-file
    // Handle EOF
}
```

**EOF Handling:**
- Returns `*e` (EOT, ASCII 4) on end-of-file
- No distinction between EOF and valid character 4
- Input is buffered by the terminal

### Raw Character I/O

```b
// Raw character output (bypasses buffering)
putchr(character) → character

// Raw character input (bypasses buffering)
getchr() → character or EOF
getstr(buffer_ptr) → buffer_ptr
```

**Differences from Standard I/O:**
- `putchr`/`getchr`: Direct system calls, unbuffered
- `putchar`/`getchar`: Buffered through stdio
- Raw I/O is slower but more predictable

---

## Formatted Output

### Print Functions

```b
// Print decimal number without newline
putnum(number) → number

// Print number with automatic newline
print(number) → number

// Print formatted string with arguments
printf(format_string, arg1, arg2, ...) → 0

// Print number in specified base
printn(number, base) → number
```

**Format Specifiers (printf):**
- `%d` - Signed decimal integer
- `%o` - Unsigned octal integer
- `%c` - Single character
- `%s` - String (terminated by `*e`)

**Number Output Notes:**
- `putnum` prints decimal digits only and does not add a newline
- `print` appends a newline after the decimal number
- `printn` emits digits in the requested base without a newline

**Examples:**
```b
putnum(-42);                  // Output: "-42"
putnum(0); putchar('*n');     // Output: "0\n" (newline added manually)
print(42);                    // Output: "42\n"
printf("hello*n");            // Output: "hello\n"
printf("value: %d*n", 123);   // Output: "value: 123\n"
printf("char: %c*n", `A');    // Output: "char: A\n"
printf("octal: %o*n", 42);    // Output: "octal: 52\n"
printn(42, 8);               // Output: "52" (octal)
printn(42, 16);              // Output: "2A" (hexadecimal)
```

### String Output

```b
// Print null-terminated string (B style: *e terminated)
printf("%s*n", string_ptr);
```

**String Format:**
- Strings are word arrays
- Terminated by `*e` (EOT), not `\0`
- Character constants can pack up to 4 ASCII bytes into one word (right-justified)

---

## File I/O

### File Operations

```b
// Open existing file
open(filename, mode) → file_descriptor or -1
openr(fd, filename) → fd/-1   // open read-only (dup to fd if provided)
openw(fd, filename) → fd/-1   // open write/truncate (dup to fd if provided)
flush() → 0                   // flush current output unit

// Create new file
creat(filename, mode) → file_descriptor or -1

// Close file
close(file_descriptor) → 0 or -1

// Get file status
stat(filename, buffer) → 0 or -1
fstat(fd, buffer) → 0 or -1
```

**File Modes:**
- `open()`: 0 = read-only, 1 = write-only, 2 = read-write
- `creat()`: Unix permission bits (typically 017 for executable)
- File descriptors are small integers (0, 1, 2, ...)

**Unit Switching (openr/openw):**
- `openr(u, "path")` sets the current input unit to `u` (or resets to terminal when `u<0` or name is empty)
- `openw(u, "path")` sets the current output unit to `u` (or resets to terminal when `u<0` or name is empty)
- Subsequent `getchar`/`putchar`/`getstr`/`putstr` use the redirected units
- Files already assigned to the unit are closed first

**Examples:**
```b
// Open file for reading
auto fd = open("data.txt", 0);
if (fd < 0) {
    printf("cannot open file*n");
    return 1;
}

// Create file for writing
auto out_fd = creat("output.txt", 017);

// Close files
close(fd);
close(out_fd);

// Redirect standard I/O
openr(5, "input.txt");
openw(6, "output.txt");
while ((c = getchar()) != '*e')
    putchar(c);
flush();  // ensure output is written
```

### File Reading and Writing

```b
// Read from file
read(fd, buffer, count) → bytes_read or -1

// Write to file
write(fd, buffer, count) → bytes_written or -1

// Seek in file
seek(fd, offset, whence) → new_position or -1
```

**Seek Whence Values:**
- `0`: SEEK_SET (from beginning)
- `1`: SEEK_CUR (from current position)
- `2`: SEEK_END (from end)

**Examples:**
```b
auto buffer 256;
auto fd = open("file.txt", 0);

// Read up to 256 bytes
auto n = read(fd, buffer, 256);
if (n < 0) {
    printf("read error*n");
}

// Write data
auto data 4;
write(fd, data, 8);  // Write 8 bytes (4 words)

// Seek to beginning
seek(fd, 0, 0);

close(fd);
```

---

## Buffered I/O

### Buffered File Operations

```b
// Open buffered file
fopen(filename, mode) → file_descriptor or -1

// Create buffered file
fcreat(filename) → file_descriptor or -1

// Close buffered file
fclose(fd) → 0 or -1

// Flush buffers
flush(fd) → 0
```

**Differences from Raw File I/O:**
- Buffered I/O uses stdio-like buffering
- More efficient for character-at-a-time operations
- Automatic buffering management
- `fcreat()` uses default mode (017)

### Character Buffered I/O

```b
// Read buffered character
getc(fd) → character or -1

// Write buffered character
putc(fd, character) → character or -1
```

**Buffering Behavior:**
- Characters are buffered until newline or flush
- `flush()` forces buffer write to disk
- More efficient than raw I/O for text processing

### Word Buffered I/O

```b
// Read buffered word
getw(fd) → word or -1

// Write buffered word
putw(fd, word) → word or -1
```

**Word I/O Notes:**
- Words are 16-bit values
- Big-endian byte order (PDP-11 format)
- Useful for binary data transfer

---

## I/O Programming Patterns

### Text File Processing

```b
// Copy text file
copy_file(in_name, out_name) {
    auto in_fd = open(in_name, 0);
    auto out_fd = creat(out_name, 017);

    if (in_fd < 0 || out_fd < 0) {
        printf("cannot open files*n");
        return 1;
    }

    auto buffer 256;
    auto n;

    while ((n = read(in_fd, buffer, 256)) > 0) {
        write(out_fd, buffer, n);
    }

    close(in_fd);
    close(out_fd);
    return 0;
}
```

### Character-by-Character Processing

```b
// Count characters, words, lines
count_stats(filename) {
    auto fd = open(filename, 0);
    if (fd < 0) return;

    auto chars = 0;
    auto words = 0;
    auto lines = 0;
    auto in_word = 0;
    auto c;

    while ((c = getc(fd)) >= 0) {
        chars =+ 1;

        if (c == '*n') {
            lines =+ 1;
        }

        if (c == ` ' || c == `*t' || c == `*n') {
            if (in_word) {
                words =+ 1;
                in_word = 0;
            }
        } else {
            in_word = 1;
        }
    }

    if (in_word) words =+ 1;  // Count final word

    printf("chars: %d, words: %d, lines: %d*n", chars, words, lines);
    close(fd);
}
```

### Interactive Input

```b
// Simple calculator
calculator() {
    printf("enter expression (a op b): ");

    auto a = read_number();
    auto op = getchar();  // Skip whitespace
    while (op == ` ' || op == `*t') op = getchar();
    auto b = read_number();

    auto result;
    if (op == `+') result = a + b;
    else if (op == `-') result = a - b;
    else if (op == `*') result = a * b;
    else if (op == `/') {
        if (b == 0) {
            printf("division by zero*n");
            return;
        }
        result = a / b;
    } else {
        printf("invalid operator*n");
        return;
    }

    printf("result: %d*n", result);
}

read_number() {
    auto num = 0;
    auto c;

    // Skip whitespace
    while ((c = getchar()) == ` ' || c == `*t');

    // Read digits
    while (c >= `0' && c <= `9') {
        num = num * 10 + (c - `0');
        c = getchar();
    }

    return num;
}
```

---

## Error Handling

### File Operation Errors

```b
// Proper error checking
auto fd = open("file.txt", 0);
if (fd < 0) {
    printf("error: cannot open file.txt*n");
    return 1;
}

// File operations can also fail
auto n = read(fd, buffer, 100);
if (n < 0) {
    printf("error: read failed*n");
    close(fd);
    return 1;
}
```

### End-of-File Detection

```b
// Character input EOF
auto c;
while ((c = getchar()) != '*e') {
    // Process character
}

// File reading EOF
auto n;
while ((n = read(fd, buffer, 256)) > 0) {
    // Process buffer
}
if (n < 0) {
    printf("read error*n");
}
```

### Buffer Overflow Prevention

```b
// Safe string input
read_line(buffer, max_len) {
    auto i = 0;
    auto c;

    while (i < max_len - 1 && (c = getchar()) != '*n' && c != '*e') {
        buffer[i++] = c;
    }
    buffer[i] = '*e';  // Terminate

    return i;  // Return length
}
```

---

## Advanced I/O Techniques

### Binary Data Handling

```b
// Write/read binary structures
write_record(fd, data, size) {
    return write(fd, data, size * 2);  // 2 bytes per word
}

read_record(fd, data, size) {
    return read(fd, data, size * 2) / 2;  // Return words read
}

// Example: simple database record
auto record 4;  // ID, value1, value2, flags
write_record(fd, record, 4);
```

### File Positioning

```b
// Random access file operations
update_record(fd, record_num, data) {
    auto offset = record_num * 8;  // 4 words * 2 bytes/word
    seek(fd, offset, 0);          // Seek to record
    write(fd, data, 8);           // Write record
}

read_record(fd, record_num, data) {
    auto offset = record_num * 8;
    seek(fd, offset, 0);
    return read(fd, data, 8) == 8;  // Success if 8 bytes read
}
```

### Terminal Control

```b
// Get terminal settings
get_terminal_mode(buffer) {
    return gtty(0, buffer);  // 0 = stdin
}

// Set terminal settings
set_terminal_mode(buffer) {
    return stty(0, buffer);
}

// Raw mode example
enable_raw_mode() {
    auto mode 3;
    if (gtty(0, mode) == 0) {
        // Modify mode for raw input
        mode[2] = mode[2] & ~010;  // Clear ECHO bit
        stty(0, mode);
    }
}
```

---

## Performance Considerations

### Buffering Strategies

**When to Use Buffered I/O:**
- Character-at-a-time input/output
- Text processing
- Interactive programs
- Small data transfers

**When to Use Raw I/O:**
- Binary data transfer
- Large block operations
- Predictable timing requirements
- Memory-constrained systems

### File Access Patterns

**Sequential Access (Optimal):**
```b
// Read entire file sequentially
while ((n = read(fd, buffer, 1024)) > 0) {
    process(buffer, n);
}
```

**Random Access:**
```b
// Seek to specific record
seek(fd, record_index * record_size, 0);
read(fd, record_buffer, record_size);
```

### Memory Usage

**Buffer Size Trade-offs:**
- Larger buffers: Better performance, more memory
- Smaller buffers: Less memory, more system calls
- Typical sizes: 256-1024 bytes for general use

---

## Implementation Details

### Character Encoding

**ASCII Character Set:**
- 7-bit ASCII (0-127)
- B supports full 8-bit character values
- High bit may be set for special purposes

**String Termination:**
- B strings: `*e` (EOT, ASCII 4)
- C strings: `\0` (NUL, ASCII 0)
- Conversion required when interfacing with C libraries

### Byte Order

**PDP-11 Endianness:**
- Big-endian word storage
- High byte first, low byte second
- Important for binary file compatibility

### File Descriptor Management

**Standard File Descriptors:**
- `0`: stdin (standard input)
- `1`: stdout (standard output)
- `2`: stderr (standard error)

**File Descriptor Limits:**
- Small integer values (typically 0-19)
- Limited by system configuration
- Should be closed when no longer needed

---

## Common Pitfalls

### Forgetting to Close Files

```b
// Bad: file descriptor leak
open_and_process(name) {
    auto fd = open(name, 0);
    // Process file
    // Forgot to close!
}

// Good: proper cleanup
open_and_process(name) {
    auto fd = open(name, 0);
    if (fd < 0) return;

    // Process file

    close(fd);  // Always close
}
```

### Ignoring I/O Errors

```b
// Bad: no error checking
write(fd, buffer, 100);

// Good: check return value
if (write(fd, buffer, 100) != 100) {
    printf("write error*n");
}
```

### Buffer Overflow

```b
// Bad: potential overflow
auto buffer 10;
read(fd, buffer, 100);  // Reads 100 bytes into 20-byte buffer

// Good: size checking
auto buffer 10;
auto n = read(fd, buffer, 20);  // Respect buffer size
```

---

## Complete Examples

### Text File Word Counter

```b
// Count words in a text file
word_count(filename) {
    auto fd = open(filename, 0);
    if (fd < 0) {
        printf("cannot open %s*n", filename);
        return 0;
    }

    auto words = 0;
    auto in_word = 0;
    auto c;

    while ((c = getc(fd)) >= 0) {
        if (c == ` ' || c == `*t' || c == `*n') {
            if (in_word) {
                words =+ 1;
                in_word = 0;
            }
        } else {
            in_word = 1;
        }
    }

    if (in_word) words =+ 1;  // Count final word

    close(fd);
    return words;
}

main() {
    auto count = word_count("document.txt");
    printf("word count: %d*n", count);
}
```

### Simple Database

```b
// Record structure: [id, name_ptr, age, salary]
// Name stored separately as string

create_record(id, name, age, salary) {
    // Allocate record (4 words)
    auto record = alloc(4);

    record[0] = id;
    record[1] = alloc_string(name);  // Store name separately
    record[2] = age;
    record[3] = salary;

    return record;
}

alloc_string(s) {
    // Copy string and return pointer
    auto len = strlen(s) + 1;  // +1 for *e
    auto copy = alloc((len + 1) / 2);  // Word allocation

    strcpy(copy, s);
    return copy;
}

strlen(s) {
    auto len = 0;
    while (char(s, len) != '*e') len =+ 1;
    return len;
}

strcpy(dest, src) {
    auto i = 0;
    auto c;
    while ((c = char(src, i)) != '*e') {
        lchar(dest, i, c);
        i =+ 1;
    }
    lchar(dest, i, '*e');
}

save_record(fd, record) {
    // Write record (8 bytes = 4 words)
    write(fd, record, 8);
}

load_record(fd, record) {
    // Read record
    return read(fd, record, 8) == 8;
}

main() {
    auto db_fd = creat("database.db", 017);

    // Create and save records
    auto rec1 = create_record(1, "Alice", 25, 50000);
    auto rec2 = create_record(2, "Bob", 30, 60000);

    save_record(db_fd, rec1);
    save_record(db_fd, rec2);

    close(db_fd);

    // Read back records
    auto read_fd = open("database.db", 0);
    auto buffer 4;

    while (load_record(read_fd, buffer)) {
        printf("ID: %d, Age: %d, Salary: %d*n",
               buffer[0], buffer[2], buffer[3]);
    }

    close(read_fd);
}
```

---

## Function Reference

### Character I/O
| Function | Signature | Description |
|----------|-----------|-------------|
| `putchar` | `(c) → c` | Output character to stdout |
| `getchar` | `() → c/*e` | Input character from stdin |
| `putchr` | `(c) → c` | Raw character output |
| `getchr` | `() → c/4` | Raw character input |

### Formatted Output
| Function | Signature | Description |
|----------|-----------|-------------|
| `putnum` | `(n) → n` | Print decimal number (no newline) |
| `print` | `(n) → n` | Print number with newline |
| `printf` | `(fmt, ...) → 0` | Formatted output |
| `printn` | `(n, base) → n` | Print number in base |

### File Operations
| Function | Signature | Description |
|----------|-----------|-------------|
| `open` | `(name, mode) → fd/-1` | Open file |
| `creat` | `(name, mode) → fd/-1` | Create file |
| `close` | `(fd) → 0/-1` | Close file |
| `read` | `(fd, buf, n) → count/-1` | Read from file |
| `write` | `(fd, buf, n) → count/-1` | Write to file |
| `seek` | `(fd, off, wh) → pos/-1` | Seek in file |

### Buffered I/O
| Function | Signature | Description |
|----------|-----------|-------------|
| `fopen` | `(name, mode) → fd/-1` | Open buffered file |
| `fcreat` | `(name) → fd/-1` | Create buffered file |
| `fclose` | `(fd) → 0/-1` | Close buffered file |
| `getc` | `(fd) → c/-1` | Read buffered character |
| `putc` | `(fd, c) → c/-1` | Write buffered character |
| `getw` | `(fd) → w/-1` | Read buffered word |
| `putw` | `(fd, w) → w/-1` | Write buffered word |
| `flush` | `(fd) → 0` | Flush buffers |

### File Information
| Function | Signature | Description |
|----------|-----------|-------------|
| `stat` | `(path, buf) → 0/-1` | Get file status |
| `fstat` | `(fd, buf) → 0/-1` | Get file status by descriptor |

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [Runtime Library](WIKI_RUNTIME_LIBRARY.md)
- [File I/O](WIKI_FILE_IO.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
- [String Operations](WIKI_STRING_OPERATIONS.md)
- [Data Types & Literals](WIKI_DATA_TYPES.md)
- [Control Structures](WIKI_CONTROL_STRUCTURES.md)
- [Functions](WIKI_FUNCTIONS.md)
- [Arrays & Pointers](WIKI_ARRAYS_POINTERS.md)
- [Examples](WIKI_EXAMPLES.md)
