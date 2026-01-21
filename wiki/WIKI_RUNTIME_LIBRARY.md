# Runtime Library (libb.a)

B programs rely on a comprehensive runtime library (`libb.a`) that provides essential operating system interfaces, I/O operations, string manipulation, and mathematical functions. This page documents the complete B runtime library as implemented by Ken Thompson's original system.

---

## Overview

The B runtime library serves as the interface between B programs and the Unix operating system. All functions are automatically available to B programs without explicit declarations.

**Key Characteristics:**
- Functions are prefixed with `b_` in the generated C code
- All parameters and return values are `word` (16-bit integer) type
- Error handling through return codes and condition flags
- Direct Unix system call integration

---

## Input/Output Functions

### Character I/O

```b
// Output character to stdout
putchar(c) → c
putstr(string_ptr) → string_ptr

// Input character from stdin
getchar() → character or EOF
getstr(buffer_ptr) → buffer_ptr
```

**Examples:**
```b
putchar(`A');           // Output 'A'
putchar(42 + `0');      // Output '4' (42 in ASCII)
auto ch = getchar();    // Read next character
putstr("hello");        // Output "hello"
auto buf 20; getstr(buf); putstr(buf); // Echo a line into the buffer
```

**Error Handling:**
- `getchar()` returns `*e` (EOT, ASCII 4) on EOF
- No error returns for `putchar()`

### Formatted Output

```b
// Print formatted string with arguments
printf(format_string, arg1, arg2, ...) → 0

// Print number followed by newline
print(number) → number
```

**Format Specifiers:**
- `%d` - Signed decimal integer
- `%o` - Unsigned octal integer
- `%c` - Character
- `%s` - String (terminated by `*e`)

**Examples:**
```b
printf("hello world*n");              // Simple string
printf("value: %d*n", 42);            // Formatted number
printf("char: %c octal: %o*n", 'A', 65); // Multiple formats
print(123);                           // Print 123 followed by newline
```

### Buffered I/O (Advanced)

```b
// File operations (simplified interface)
fopen(name, mode) → file_descriptor
fcreat(name) → file_descriptor
fclose(fd) → status

// Character I/O with files
getc(fd) → character
putc(fd, c) → c

// Word I/O with files
getw(fd) → word
putw(fd, w) → w

// Buffer control
flush(fd) → 0
```

**Mode Values:**
- `fopen()`: 0 = read, 1 = write
- File descriptors are Unix file descriptors

---

## String Manipulation

### Character Access

```b
// Get character at string position
char(string_ptr, index) → character

// Set character at string position
lchar(string_ptr, index, new_char) → new_char
```

**String Representation:**
- Strings are word arrays
- Character constants can pack up to 4 ASCII bytes into one word (right-justified)
- Terminated with `*e` (EOT)

**Examples:**
```b
auto str 10;
lchar(str, 0, 'H');
lchar(str, 1, 'i');
lchar(str, 2, '*e');         // Terminate string

auto first = char(str, 0);   // Gets 'H'
auto second = char(str, 1);  // Gets 'i'
```

### String Building

**Common Patterns:**
```b
// String length
strlen(s) {
    auto len = 0;
    while (char(s, len) != '*e') {
        len =+ 1;
    }
    return len;
}

// String copy
strcpy(dest, src) {
    auto i = 0;
    auto c;
    while ((c = char(src, i)) != '*e') {
        lchar(dest, i, c);
        i =+ 1;
    }
    lchar(dest, i, '*e');
    return dest;
}

// String comparison
strcmp(s1, s2) {
    auto i = 0;
    auto c1, c2;
    while (1) {
        c1 = char(s1, i);
        c2 = char(s2, i);
        if (c1 != c2) return c1 - c2;
        if (c1 == '*e') return 0;
        i =+ 1;
    }
}
```

---

## File Operations

### File Descriptors

```b
// Open existing file
open(name_string, mode) → fd or -1

// Create new file
creat(name_string, mode) → fd or -1

// Close file
close(fd) → 0 or -1

// Seek in file
seek(fd, offset, whence) → new_position or -1

// Read from file
read(fd, buffer, count) → bytes_read or -1

// Write to file
write(fd, buffer, count) → bytes_written or -1
```

**Mode Values:**
- `open()`: 0 = read-only, 1 = write-only, 2 = read-write
- `creat()`: Unix file permissions (typically 017 for executable)
- `seek()` whence: 0 = SEEK_SET, 1 = SEEK_CUR, 2 = SEEK_END

**Examples:**
```b
// Read from file
auto fd = open("input.txt", 0);
if (fd < 0) {
    printf("cannot open file*n");
    return 1;
}

auto buffer 100;
auto n = read(fd, buffer, 50);
close(fd);
```

### Buffered I/O

```b
// Buffered file operations
auto fd = fopen("file.txt", 0);    // Open for reading
auto ch = getc(fd);                // Read character
putc(fd, 'X');                     // Write character

auto word = getw(fd);              // Read word
putw(fd, 12345);                   // Write word

flush(fd);                         // Flush buffers
fclose(fd);                        // Close file
```

---

## Process Control

### Process Creation

```b
// Create child process
fork() → pid (parent) or 0 (child)

// Wait for child process
wait() → child_pid

// Execute program
execl(path, arg0, arg1, ..., 0) → -1 (error only)

// Execute with argument array
execv(path, argv_array) → -1 (error only)
```

**Process ID Convention:**
- `fork()` returns 0 to child, child's PID to parent
- `wait()` returns child's PID, stores exit status in `wait_status`

**Examples:**
```b
auto pid = fork();
if (pid == 0) {
    // Child process
    execl("/bin/ls", "ls", 0);
} else {
    // Parent process
    auto child_pid = wait();
    printf("child %d exited*n", child_pid);
}
```

### Exit and Termination

```b
// Exit program with status
exit(status) → (does not return)
```

---

## Memory Management

### Dynamic Allocation

```b
// Allocate memory
alloc(word_count) → pointer or 0

// Memory remains allocated until program termination
// No corresponding free() function in B
```

**Memory Model:**
- Allocates in word units
- Memory persists for program lifetime
- No garbage collection or deallocation
- Returns pointer to allocated block

**Examples:**
```b
// Allocate array
auto size = 100;
auto array = alloc(size);

// Use as regular array
auto i = 0;
while (i < size) {
    array[i] = i * i;
    i =+ 1;
}

// Allocate string buffer
auto buffer = alloc(256);
strcpy(buffer, "hello world");
```

---

## System Calls

### File System

```b
// Change directory
chdir(path) → 0 or -1

// Get current user ID
getuid() → uid

// Set user ID
setuid(uid) → 0 or -1

// Delete file
unlink(path) → 0 or -1

// Create directory
makdir(path, mode) → 0 or -1
```

### File Information

```b
// Get file status
stat(path, buffer) → 0 or -1

// Get file status by descriptor
fstat(fd, buffer) → 0 or -1

// Change permissions
chmod(path, mode) → 0 or -1

// Change ownership
chown(path, uid) → 0 or -1

// Create hard link
link(old_path, new_path) → 0 or -1
```

---

## Time and Date

### Time Functions

```b
// Get current time
time(buffer) → 0

// Format time for printing
ctime(buffer) → formatted_string_pointer

// Delay execution (microseconds)
usleep(microseconds) → 0
```

**Time Buffer Format:**
- `buffer[0]`: Low 16 bits of Unix timestamp
- `buffer[1]`: High 16 bits of Unix timestamp

**Examples:**
```b
auto timebuf 2;
time(timebuf);                    // Get current time
auto time_str = ctime(timebuf);   // Format as string
printf("current time: %s", time_str);

// Animation delay
usleep(30000);                    // Wait 30ms (30000 microseconds)
```

### Time Formatting

`ctime()` produces strings in format: `"Oct 9 17:32:24\n"`

### Delay Function

`usleep(microseconds)` pauses execution for the specified number of microseconds. Useful for:
- Animation timing (e.g., the spinning donut example)
- Rate limiting
- Polling with delays

**Limitations:**
- No year information (wraps every ~2 years)
- Fixed format, no customization
- Includes trailing newline

---

## Mathematical Functions

### Arithmetic Support

B provides basic arithmetic operations as part of the language, but for advanced math:

```b
// Note: B's math library is limited
// Most mathematical functions are not available in original B
// Modern implementations may add them
```

**Available Operations:**
- Basic arithmetic: `+`, `-`, `*`, `/`, `%`
- Bitwise operations: `&`, `|`, `^`, `<<`, `>>`
- Comparison: `==`, `!=`, `<`, `<=`, `>`, `>=`

### Compatibility Helpers

```b
// Sign-extend lower 16 bits to full word size
sx64(value) → sign_extended_value
```

**Usage:**
`sx64(x)` extracts the lower 16 bits of `x` and sign-extends them to the full word size. This is essential for porting 16-bit algorithms (like the spinning donut) to 64-bit hosts.

**Examples:**
```b
sx64(32767);    // Returns 32767
sx64(32768);    // Returns -32768 (sign bit set in 16-bit)
sx64(-1);       // Returns -1
sx64(65535);    // Returns -1 (0xFFFF sign-extended)
```

**Use Cases:**
- Fixed-point arithmetic from 16-bit era code
- Algorithms expecting 16-bit overflow behavior
- Porting PDP-11 B programs to modern systems

---

## Terminal Control

### Terminal Modes

```b
// Get terminal characteristics
gtty(fd, buffer) → 0 or -1

// Set terminal characteristics
stty(fd, buffer) → 0 or -1
```

**Buffer Format:**
- `buffer[0]`: Input flags (c_iflag)
- `buffer[1]`: Output flags (c_oflag)
- `buffer[2]`: Local flags (c_lflag)

### Interrupt Handling

```b
// Set up interrupt signal handling
intr(mode) → 0
```

**Mode Values:**
- `mode != 0`: Install SIGINT handler
- `mode == 0`: Restore default SIGINT behavior

---

## Print Functions

### Number Formatting

```b
// Print decimal number without newline
putnum(number) → number

// Print number in specified base
printn(number, base) → number

// Print number with newline
print(number) → number
```

**Base Values:**
- `8`: Octal
- `10`: Decimal
- `16`: Hexadecimal (if supported)

**Behavior:**
- `putnum` prints decimal digits only (no trailing newline)
- Negative inputs print a leading `-`
- Zero still prints `0`

**Examples:**
```b
putnum(-42); putchar('*n');   // Print "-42" then newline via putchar
putnum(0);                    // Print "0"
printn(42, 10);      // Print "42"
printn(42, 8);       // Print "52" (42 in octal)
printn(42, 16);      // Print "2A" (42 in hex)
```

---

## Error Handling

### Return Code Convention

Most functions follow Unix conventions:
- `0`: Success
- `-1`: Error (check `errno` equivalent)

### File Operations

```b
// Check for file errors
auto fd = open("file.txt", 0);
if (fd < 0) {
    printf("cannot open file*n");
    return 1;
}
```

### System Calls

```b
// Handle system call errors
if (chdir("/tmp") < 0) {
    printf("cannot change directory*n");
    return 1;
}
```

---

## Library Organization

### Function Categories

1. **Core I/O**: `putchar`, `getchar`, `print`, `printf`
2. **File I/O**: `open`, `close`, `read`, `write`, `creat`, `seek`
3. **Buffered I/O**: `fopen`, `fclose`, `getc`, `putc`, `getw`, `putw`
4. **String Operations**: `char`, `lchar`
5. **Process Control & Interop**: `fork`, `wait`, `execl`, `execv`, `system`, `callf`, `exit`
6. **Memory Management**: `alloc`
7. **File System**: `chdir`, `chmod`, `chown`, `link`, `unlink`, `stat`
8. **System Info**: `getuid`, `setuid`, `time`, `ctime`
9. **Terminal Control**: `gtty`, `stty`, `intr`

### Implementation Notes

**B to C Translation:**
- All functions prefixed with `b_` in generated code
- Parameters converted from B words to appropriate C types
- Return values converted back to B words
- Error handling mapped to B conventions
- I/O redirection helpers `openr`/`openw`/`flush` switch the default input/output units used by `getchar`/`putchar`/`getstr`/`putstr`

**System Dependencies:**
- Unix-specific system calls
- PDP-11 word size assumptions
- Terminal control assumes Unix tty interface

---

## Complete Function Reference

### Alphabetical Index

| Function | Signature | Description |
|----------|-----------|-------------|
| `alloc` | `(n) → ptr` | Allocate n words |
| `char` | `(s, i) → c` | Get char at string position |
| `chdir` | `(path) → 0/-1` | Change directory |
| `chmod` | `(path, mode) → 0/-1` | Change file permissions |
| `chown` | `(path, uid) → 0/-1` | Change file ownership |
| `close` | `(fd) → 0/-1` | Close file descriptor |
| `creat` | `(name, mode) → fd` | Create file |
| `ctime` | `(buf) → str` | Format time as string |
| `execl` | `(path, ...) → -1` | Execute with arg list |
| `execv` | `(path, argv) → -1` | Execute with arg array |
| `exit` | `(status) → noreturn` | Exit program |
| `callf` | `(name, a1...a10) → status` | Call Fortran/GMAP/C routine by name (addresses only; up to 10 args; tries `name` then `name_`) |
| `fclose` | `(fd) → 0/-1` | Close buffered file |
| `flush` | `(fd) → 0` | Flush file buffers |
| `fopen` | `(name, mode) → fd` | Open buffered file |
| `fork` | `() → pid/0` | Create child process |
| `fstat` | `(fd, buf) → 0/-1` | Get file status by fd |
| `fcreat` | `(name) → fd` | Create buffered file |
| `getc` | `(fd) → c/-1` | Read buffered character |
| `getchar` | `() → c/*e` | Read stdin character |
| `getchr` | `() → c/4` | Read raw character |
| `getstr` | `(buf) → buf` | Read line into B string buffer |
| `getuid` | `() → uid` | Get user ID |
| `getw` | `(fd) → w/-1` | Read buffered word |
| `gtty` | `(fd, buf) → 0/-1` | Get terminal modes |
| `intr` | `(mode) → 0` | Set interrupt handling |
| `lchar` | `(s, i, c) → c` | Set char at string position |
| `link` | `(old, new) → 0/-1` | Create hard link |
| `makdir` | `(path, mode) → 0/-1` | Create directory |
| `open` | `(name, mode) → fd` | Open file |
| `openr` | `(fd, name) → fd` | Open read-only (dup to fd if provided) |
| `openw` | `(fd, name) → fd` | Open write/truncate (dup to fd if provided) |
| `print` | `(n) → n` | Print number with newline |
| `printf` | `(fmt, ...) → 0` | Formatted output |
| `printn` | `(n, base) → n` | Print number in base |
| `putnum` | `(n) → n` | Print decimal number (no newline) |
| `putc` | `(fd, c) → c/-1` | Write buffered character |
| `putchar` | `(c) → c` | Write stdout character |
| `putchr` | `(c) → c` | Write raw character |
| `putstr` | `(s) → s` | Write B string |
| `putw` | `(fd, w) → w/-1` | Write buffered word |
| `read` | `(fd, buf, n) → count` | Read from file |
| `seek` | `(fd, off, wh) → pos` | Seek in file |
| `setuid` | `(uid) → 0/-1` | Set user ID |
| `stat` | `(path, buf) → 0/-1` | Get file status |
| `stime` | `(buf) → 0` | Set system time |
| `stty` | `(fd, buf) → 0/-1` | Set terminal modes |
| `system` | `(cmd) → status` | Execute command line without a shell; returns raw wait status (`(rc>>8)&0377` for exit code) |
| `B_CALLF_LIB` | env var | `:`-separated `.so` list to preload for `callf` symbol lookup (loaded with `dlopen` RTLD_GLOBAL) |
| `time` | `(buf) → 0` | Get current time |
| `unlink` | `(path) → 0/-1` | Delete file |
| `wait` | `() → pid` | Wait for child process |
| `write` | `(fd, buf, n) → count` | Write to file |

### Fortran interop quickstart
```bash
# 1) Write a shim (example in repo: shim.f90)
gfortran -shared -fPIC shim.f90 -o libtssshim.so

# 2) Run B code with the library preloaded for callf:
B_CALLF_LIB=./libtssshim.so ./your_program

# 3) Call from B using string names + addresses:
callf("sin2", &x, &y);
callf("itimez", &t);
```

---

## Usage Examples

### File Processing Program

```b
main() {
    auto infile = open("input.txt", 0);
    auto outfile = creat("output.txt", 017);

    if (infile < 0 || outfile < 0) {
        printf("cannot open files*n");
        return 1;
    }

    auto buffer 256;
    auto n;

    while ((n = read(infile, buffer, 256)) > 0) {
        write(outfile, buffer, n);
    }

    close(infile);
    close(outfile);

    printf("file copied*n");
}
```

### Redirecting Standard I/O

```b
main() {
    openr(5, "input.txt");   // getchar/getstr now read from input.txt
    openw(6, "output.txt");  // putchar/putstr now write to output.txt

    auto c;
    while ((c = getchar()) != '*e')
        putchar(c);

    flush();  // ensure output is written
}
```

### Directory Listing

```b
main() {
    // Simple directory listing using execl
    auto pid = fork();

    if (pid == 0) {
        // Child process
        execl("/bin/ls", "ls", "-l", 0);
        printf("exec failed*n");
        exit(1);
    } else {
        // Parent process
        wait();
        printf("listing complete*n");
    }
}
```

### String Processing

```b
main() {
    auto input 100;
    auto output 100;

    printf("enter string: ");
    // Read input (simplified - real implementation would loop)
    auto i = 0;
    auto c;
    while ((c = getchar()) != '*n' && i < 99) {
        lchar(input, i++, c);
    }
    lchar(input, i, '*e');

    // Convert to uppercase
    i = 0;
    while ((c = char(input, i)) != '*e') {
        if (c >= 'a' && c <= 'z') {
            c = c + ('A' - 'a');
        }
        lchar(output, i, c);
        i =+ 1;
    }
    lchar(output, i, '*e');

    printf("result: %s*n", output);
}
```

---

## Implementation Details

### Function Binding

In the BCC compiler, B function calls are translated to C function calls with the `b_` prefix:

```b
putchar('A');
```

Compiles to:
```c
b_putchar('A');
```

### Parameter Conversion

B words are converted to appropriate C types:
- Character operations: `word` → `char`
- File descriptors: `word` → `int`
- Pointers: `word` → appropriate pointer type
- String operations: B string pointers → C string pointers

### Error Handling

B runtime functions follow these conventions:
- Return `0` for success
- Return `-1` for failure
- File I/O returns actual counts or `-1`
- Character input returns `*e` (4) for EOF

---

## Historical Notes

### Original Implementation

The original `libb.a` was written in PDP-11 assembly language and provided the runtime support for B programs during early Unix development (1969-1972).

### Evolution

As B evolved toward C, the runtime library became the basis for C's standard library, with many functions carrying over directly.

### Modern Extensions

Modern B implementations may include additional functions not present in the original library, while maintaining backward compatibility.

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [String Operations](WIKI_STRING_OPERATIONS.md)
- [I/O Functions](WIKI_IO_FUNCTIONS.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
- [File I/O](WIKI_FILE_IO.md)
- [Data Types & Literals](WIKI_DATA_TYPES.md)
- [Control Structures](WIKI_CONTROL_STRUCTURES.md)
- [Functions](WIKI_FUNCTIONS.md)
- [Arrays & Pointers](WIKI_ARRAYS_POINTERS.md)
- [Examples](WIKI_EXAMPLES.md)
