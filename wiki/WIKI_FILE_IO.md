# File I/O

B provides comprehensive file input/output operations through its runtime library. This page covers file handling, data persistence, and file system operations in the B programming language.

---

## File Operations Overview

B's file I/O is based on Unix system calls and provides both low-level and buffered file access. Files are identified by integer file descriptors, and operations follow Unix conventions.

### File Descriptors

```b
// Standard file descriptors
0  // stdin  (standard input)
1  // stdout (standard output)
2  // stderr (standard error)

// User files start from 3
auto fd = open("file.txt", 0);  // Returns 3, 4, 5, etc.
```

**File Descriptor Management:**
- Small integer values (0-255 typically)
- Must be closed when no longer needed
- Limited by system file descriptor table
- Inherited by child processes

---

## I/O Units and Redirection

Much of B's I/O is driven by the implicit input/output units used by `getchar`/`getstr` and `putchar`/`putstr`.

- There is one active input unit (`rd.unit`) and one active output unit (`wr.unit`). Defaults at program start: `rd.unit = 0` (terminal input) and `wr.unit = -1` (terminal output). Valid unit numbers are `-1` through `10`.
- `openr(u, "cat/file")` binds unit `u` to the given file for input and updates `rd.unit` so subsequent `getchar`/`getstr` read from that file. An empty string or negative unit restores terminal input. If the file is missing or reaches EOF, further reads produce `*e`.
- `openw(u, "cat/file")` binds unit `u` to the given file for output and updates `wr.unit` so `putchar`/`putstr`/`printf` write there. An empty string or negative unit restores terminal output.
- If a unit is already open, `openr`/`openw` close it first. Files are also closed this way on normal termination. Closing a unit in user code likewise returns it to the terminal.
- `flush()` forces the current output unit to write buffered data without adding a newline. This is how to print a prompt and then read a reply on the same line:
  ```b
  putstr("old or new?");
  flush();
  getstr(s);
  ```
- `reread()` makes the next read return the program's command line when called before the first `getchar`/`getstr`.

File name rules mirror the original B system: `"cat/file"`, `"/file"`, or `"file"` are accepted; names with `/` are treated as permanent files.

---

## Opening and Closing Files

### File Opening

```b
// Open existing file
open(filename, mode) → file_descriptor or -1

// Create new file
creat(filename, mode) → file_descriptor or -1

// Close file
close(file_descriptor) → 0 or -1
```

**Open Modes:**
- `0`: Read-only (`O_RDONLY`)
- `1`: Write-only (`O_WRONLY`)
- `2`: Read-write (`O_RDWR`)

**Create Modes:**
- Unix permission bits (typically 017 for executable files)
- `017` = `---x--x--x` (execute permissions for user/group/other)

**Examples:**
```b
// Open for reading
auto fd = open("input.txt", 0);
if (fd < 0) {
    printf("cannot open input.txt*n");
    return 1;
}

// Create for writing
auto out_fd = creat("output.txt", 017);
if (out_fd < 0) {
    printf("cannot create output.txt*n");
    close(fd);
    return 1;
}
```

### File Closing

```b
// Always close files when done
close(fd);

// Close multiple files
close(input_fd);
close(output_fd);
close(log_fd);
```

**Close Error Handling:**
```b
if (close(fd) < 0) {
    printf("warning: close failed*n");
    // Continue execution - close errors are usually not fatal
}
```

---

## Reading from Files

### Character Reading

```b
// Read single character
getc(fd) → character or -1

// Read raw byte
getchr() → character (global stdin only)
```

**Examples:**
```b
auto fd = open("file.txt", 0);
auto c;

while ((c = getc(fd)) >= 0) {
    // Process character c
    if (c == '*n') {
        // Handle newline
    }
}

close(fd);
```

### Word Reading

```b
// Read 16-bit word
getw(fd) → word or -1
```

**Word Format:**
- Big-endian byte order (PDP-11 format)
- 16-bit signed integer
- Returns -1 on EOF or error

**Examples:**
```b
// Read binary data
auto fd = open("data.bin", 0);
auto value;

while ((value = getw(fd)) >= 0) {
    printf("read value: %d*n", value);
}

close(fd);
```

### Block Reading

```b
// Read multiple bytes
read(fd, buffer, count) → bytes_read or -1
```

**Parameters:**
- `fd`: File descriptor
- `buffer`: Word array to store data
- `count`: Number of bytes to read

**Return Values:**
- `> 0`: Number of bytes actually read
- `0`: End of file
- `-1`: Error

**Examples:**
```b
auto buffer 256;
auto fd = open("large_file.txt", 0);

auto bytes_read;
while ((bytes_read = read(fd, buffer, 512)) > 0) {
    // Process buffer[0] through buffer[bytes_read-1]
    process_data(buffer, bytes_read);
}

if (bytes_read < 0) {
    printf("read error*n");
}

close(fd);
```

---

## Writing to Files

### Character Writing

```b
// Write single character
putc(fd, character) → character or -1

// Write raw byte
putchr(character) → character (global stdout only)
```

**Examples:**
```b
auto fd = creat("output.txt", 017);

putc(fd, 'H');
putc(fd, 'e');
putc(fd, 'l');
putc(fd, 'l');
putc(fd, 'o');
putc(fd, '*n');

close(fd);
```

### Word Writing

```b
// Write 16-bit word
putw(fd, word) → word or -1
```

**Word Storage:**
- Big-endian byte order
- 16-bit signed integer
- Returns written word or -1 on error

**Examples:**
```b
// Write binary data
auto fd = creat("data.bin", 017);

putw(fd, 12345);
putw(fd, -999);
putw(fd, 0);

close(fd);
```

### Block Writing

```b
// Write multiple bytes
write(fd, buffer, count) → bytes_written or -1
```

**Parameters:**
- `fd`: File descriptor
- `buffer`: Word array containing data
- `count`: Number of bytes to write

**Return Values:**
- `>= 0`: Number of bytes actually written
- `-1`: Error

**Examples:**
```b
auto data 4;  // 4 words = 8 bytes
auto fd = creat("hello.txt", 017);

if (write(fd, data, 8) != 8) {
    printf("write error*n");
}

close(fd);
```

---

## File Positioning

### Seek Operations

```b
// Position file pointer
seek(fd, offset, whence) → new_position or -1
```

**Whence Values:**
- `0`: SEEK_SET (from beginning of file)
- `1`: SEEK_CUR (from current position)
- `2`: SEEK_END (from end of file)

**Examples:**
```b
auto fd = open("file.txt", 2);  // Read-write

// Seek to beginning
seek(fd, 0, 0);

// Seek to position 100
seek(fd, 100, 0);

// Seek 50 bytes forward from current position
seek(fd, 50, 1);

// Seek to end of file
seek(fd, 0, 2);

// Seek 10 bytes before end
seek(fd, -10, 2);
```

### Position Queries

B doesn't provide a direct way to query current position, but you can use seek:

```b
// Get current position (seek to current + 0)
auto current_pos = seek(fd, 0, 1);

// Get file size (seek to end, then back)
auto size = seek(fd, 0, 2);     // Go to end, returns size
seek(fd, current_pos, 0);       // Go back to original position
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

**Buffering Benefits:**
- Automatic buffering for efficiency
- Character-at-a-time operations are practical
- Reduced system call overhead
- Better performance for text processing

**Examples:**
```b
// Buffered text processing
auto in_fd = fopen("input.txt", 0);
auto out_fd = fcreat("output.txt");

// Copy with buffering
auto c;
while ((c = getc(in_fd)) >= 0) {
    if (c >= 'a' && c <= 'z') {
        c = c + ('A' - 'a');  // Convert to uppercase
    }
    putc(out_fd, c);
}

fclose(in_fd);
fclose(out_fd);
```

### Buffer Management

```b
// Force buffer write
flush(fd);

// Automatic flushing on:
// - Buffer full
// - Newline written (for terminal output)
// - File closed
// - Program termination
```

---

## File Status and Information

### File Status

```b
// Get file status
stat(filename, buffer) → 0 or -1

// Get status by descriptor
fstat(fd, buffer) → 0 or -1
```

**Status Buffer Format:**
B fills a word array with file information. The exact format depends on the system, but typically includes:
- File size
- Permissions
- Modification time
- File type information

**Examples:**
```b
auto stat_buf 20;  // Sufficient size for stat info

if (stat("myfile.txt", stat_buf) == 0) {
    printf("file exists*n");
} else {
    printf("file not found*n");
}
```

### File Permissions

```b
// Change file permissions
chmod(path, mode) → 0 or -1

// Change file ownership
chown(path, uid) → 0 or -1
```

**Permission Bits:**
- Unix permission format
- `017` = `---x--x--x` (execute for all)
- `077` = `rwxrwxrwx` (read/write/execute for all)

---

## Directory Operations

### Directory Management

```b
// Change current directory
chdir(path) → 0 or -1

// Create directory
makdir(path, mode) → 0 or -1
```

**Examples:**
```b
// Change to home directory
if (chdir("/usr/me") < 0) {
    printf("cannot change directory*n");
}

// Create a directory
if (makdir("my_dir", 0755) < 0) {
    printf("cannot create directory*n");
}
```

### Path Handling

B handles Unix-style paths:
```b
"/usr/bin/b"     // Absolute path
"../include"     // Relative path
"file.txt"       // Current directory
"~/documents"    // Home directory (if supported)
```

---

## Error Handling

### File Operation Errors

```b
// Check all file operations
auto fd = open("file.txt", 0);
if (fd < 0) {
    printf("open failed*n");
    return 1;
}

auto n = read(fd, buffer, 100);
if (n < 0) {
    printf("read failed*n");
    close(fd);
    return 1;
}

if (close(fd) < 0) {
    printf("close failed*n");
    // Close errors are usually not fatal
}
```

### EOF Detection

```b
// Character input EOF
auto c;
while ((c = getc(fd)) >= 0) {
    // Process c
}

// Block input EOF
auto n;
while ((n = read(fd, buffer, 256)) > 0) {
    // Process buffer[0..n-1]
}
if (n < 0) {
    printf("read error*n");
}
```

### Resource Management

```b
// Proper resource cleanup
auto cleanup() {
    if (fd1 >= 0) close(fd1);
    if (fd2 >= 0) close(fd2);
    if (fd3 >= 0) close(fd3);
}

auto main() {
    auto fd1 = -1, fd2 = -1, fd3 = -1;

    fd1 = open("file1", 0);
    if (fd1 < 0) {
        printf("cannot open file1*n");
        cleanup();
        return 1;
    }

    fd2 = open("file2", 0);
    if (fd2 < 0) {
        printf("cannot open file2*n");
        cleanup();
        return 1;
    }

    // Use files...

    cleanup();
    return 0;
}
```

---

## File I/O Patterns

### Text File Processing

```b
// Count lines, words, characters
count_file_stats(filename) {
    auto fd = open(filename, 0);
    if (fd < 0) return;

    auto lines = 0, words = 0, chars = 0;
    auto in_word = 0;
    auto c;

    while ((c = getc(fd)) >= 0) {
        chars =+ 1;

        if (c == '*n') {
            lines =+ 1;
        }

        if (c == ' ' || c == '*t' || c == '*n') {
            if (in_word) {
                words =+ 1;
                in_word = 0;
            }
        } else {
            in_word = 1;
        }
    }

    if (in_word) words =+ 1;

    close(fd);

    printf("lines: %d, words: %d, chars: %d*n", lines, words, chars);
}
```

### Binary File Operations

```b
// Write/read structured data
struct Person {
    auto id;
    auto age;
    auto salary;
};

write_person(fd, person) {
    putw(fd, person[0]);  // id
    putw(fd, person[1]);  // age
    putw(fd, person[2]);  // salary
}

read_person(fd, person) {
    person[0] = getw(fd);  // id
    person[1] = getw(fd);  // age
    person[2] = getw(fd);  // salary
    return person[0] >= 0; // Return true if read succeeded
}

// Usage
auto db_fd = creat("database.db", 017);
auto person 3;
person[0] = 1; person[1] = 25; person[2] = 50000;
write_person(db_fd, person);
close(db_fd);

// Read back
auto read_fd = open("database.db", 0);
if (read_person(read_fd, person)) {
    printf("ID: %d, Age: %d, Salary: %d*n",
           person[0], person[1], person[2]);
}
close(read_fd);
```

### File Copying

```b
// Efficient file copy
copy_file(src_name, dst_name) {
    auto src_fd = open(src_name, 0);
    if (src_fd < 0) {
        printf("cannot open source*n");
        return 1;
    }

    auto dst_fd = creat(dst_name, 017);
    if (dst_fd < 0) {
        printf("cannot create destination*n");
        close(src_fd);
        return 1;
    }

    auto buffer 256;
    auto n;

    while ((n = read(src_fd, buffer, 512)) > 0) {
        if (write(dst_fd, buffer, n) != n) {
            printf("write error*n");
            close(src_fd);
            close(dst_fd);
            return 1;
        }
    }

    if (n < 0) {
        printf("read error*n");
        close(src_fd);
        close(dst_fd);
        return 1;
    }

    close(src_fd);
    close(dst_fd);
    return 0;
}
```

### Log File Management

```b
// Simple logging system
auto log_fd = -1;

init_logging(filename) {
    log_fd = creat(filename, 017);
    if (log_fd < 0) {
        printf("cannot create log file*n");
        return 1;
    }
    return 0;
}

log_message(level, message) {
    if (log_fd < 0) return;

    // Write timestamp (simplified)
    auto time_val 2;
    time(time_val);
    auto time_str = ctime(time_val);

    // Write log entry
    printf_to_fd(log_fd, "[%s] %s: %s*n",
                time_str, level, message);
}

close_logging() {
    if (log_fd >= 0) {
        close(log_fd);
        log_fd = -1;
    }
}

// Printf to file descriptor (simplified)
printf_to_fd(fd, fmt, arg1, arg2, arg3) {
    // Very basic implementation
    auto s = fmt;
    auto arg_num = 0;

    while (*s) {
        if (*s == '%') {
            s++;
            if (*s == 's') {
                // Print string argument
                auto str = arg1; // Simplified
                while (*str) {
                    putc(fd, *str++);
                }
            } else if (*s == 'd') {
                // Print number argument
                // (Simplified - would need itoa)
                putc(fd, 'N');
                putc(fd, 'U');
                putc(fd, 'M');
            }
        } else {
            putc(fd, *s);
        }
        s++;
    }
}
```

---

## Performance Considerations

### Buffering Strategies

**When to Use Buffered I/O:**
- Text file processing
- Character-at-a-time operations
- Interactive I/O
- Small data transfers

**When to Use Raw I/O:**
- Binary data transfer
- Large block operations
- Predictable timing requirements
- Memory-constrained systems

### File Access Patterns

**Sequential Access:**
```b
// Optimal: read from start to end
while ((n = read(fd, buf, 4096)) > 0) {
    process(buf, n);
}
```

**Random Access:**
```b
// Less optimal: frequent seeking
seek(fd, record_num * 100, 0);
read(fd, record, 100);
```

### Memory Usage

**Buffer Size Trade-offs:**
- Larger buffers: Better performance, more memory
- Smaller buffers: Less memory, more system calls
- Recommended: 256-4096 bytes for general use

---

## System Integration

### Unix File System

B's file I/O is tightly integrated with Unix:

**File Permissions:**
- Respects Unix permission model
- Umask affects created files
- Owner/group/other permissions

**Special Files:**
```b
// Device files
open("/dev/tty", 2);     // Terminal
open("/dev/null", 1);    // Bit bucket

// Pipes and sockets (if supported)
// Standard Unix file operations work
```

### Process File Descriptors

**Inheritance:**
- Child processes inherit open file descriptors
- `fork()` preserves file positions
- `exec*()` functions can redirect I/O

**Standard Streams:**
- `0`: stdin (keyboard input)
- `1`: stdout (screen output)
- `2`: stderr (error output)

---

## Complete Examples

### Database Implementation

```b
// Simple record-based database
create_database(filename) {
    return creat(filename, 017);
}

add_record(fd, id, name, value) {
    putw(fd, id);

    // Write name (null-terminated for simplicity)
    auto i = 0;
    auto c;
    while ((c = char(name, i)) != '*e') {
        putc(fd, c);
        i =+ 1;
    }
    putc(fd, 0);  // Null terminator

    putw(fd, value);
}

find_record(fd, search_id) {
    seek(fd, 0, 0);  // Start from beginning

    while (1) {
        auto id = getw(fd);
        if (id < 0) return 0;  // EOF or error

        // Skip name
        auto c;
        while ((c = getc(fd)) != 0 && c >= 0);

        if (c < 0) return 0;  // Error

        auto value = getw(fd);
        if (value < 0) return 0;  // Error

        if (id == search_id) {
            return value;  // Found!
        }
    }
}

main() {
    auto db_fd = create_database("records.db");

    // Add some records
    add_record(db_fd, 1, "Alice", 100);
    add_record(db_fd, 2, "Bob", 200);
    add_record(db_fd, 3, "Charlie", 300);

    close(db_fd);

    // Search for a record
    db_fd = open("records.db", 0);
    auto value = find_record(db_fd, 2);
    if (value) {
        printf("Found Bob's value: %d*n", value);
    } else {
        printf("Record not found*n");
    }

    close(db_fd);
}
```

### Configuration File Parser

```b
// Simple key=value parser
parse_config(filename) {
    auto fd = open(filename, 0);
    if (fd < 0) return;

    auto line 256;
    auto line_pos = 0;
    auto c;

    while ((c = getc(fd)) >= 0) {
        if (c == '*n' || line_pos >= 255) {
            // Process complete line
            lchar(line, line_pos, '*e');

            if (line_pos > 0) {
                process_config_line(line);
            }

            line_pos = 0;
        } else {
            lchar(line, line_pos++, c);
        }
    }

    // Process final line if any
    if (line_pos > 0) {
        lchar(line, line_pos, '*e');
        process_config_line(line);
    }

    close(fd);
}

process_config_line(line) {
    // Find equals sign
    auto i = 0;
    auto equals_pos = -1;

    while (char(line, i) != '*e') {
        if (char(line, i) == '=') {
            equals_pos = i;
            break;
        }
        i =+ 1;
    }

    if (equals_pos <= 0) return;  // Invalid line

    // Extract key and value
auto key 50;
auto value 100;

    substring(key, line, 0, equals_pos);
    substring(value, line, equals_pos + 1,
              strlen(line) - equals_pos - 1);

    // Trim whitespace
    trim(key);
    trim(value);

    printf("Config: %s = %s*n", key, value);
}

trim(str) {
    // Remove leading/trailing whitespace
    auto len = strlen(str);
    if (len == 0) return;

    // Trim trailing
    auto end = len - 1;
    while (end >= 0 && is_space(char(str, end))) {
        lchar(str, end--, 0);
    }

    // Trim leading
    auto start = 0;
    while (start < len && is_space(char(str, start))) {
        start =+ 1;
    }

    if (start > 0) {
        // Shift string left
        auto i = 0;
        while (start < len) {
            lchar(str, i++, char(str, start++));
        }
        lchar(str, i, '*e');
    }
}

is_space(c) {
    return c == ' ' || c == '*t' || c == '*n';
}
```

---

## Function Reference

### Basic File Operations
| Function | Signature | Description |
|----------|-----------|-------------|
| `open` | `(name, mode) → fd/-1` | Open existing file |
| `creat` | `(name, mode) → fd/-1` | Create new file |
| `close` | `(fd) → 0/-1` | Close file descriptor |

### Data Transfer
| Function | Signature | Description |
|----------|-----------|-------------|
| `read` | `(fd, buf, n) → count/-1` | Read bytes from file |
| `write` | `(fd, buf, n) → count/-1` | Write bytes to file |
| `seek` | `(fd, off, wh) → pos/-1` | Position file pointer |

### Character I/O
| Function | Signature | Description |
|----------|-----------|-------------|
| `getc` | `(fd) → c/-1` | Read buffered character |
| `putc` | `(fd, c) → c/-1` | Write buffered character |

### Word I/O
| Function | Signature | Description |
|----------|-----------|-------------|
| `getw` | `(fd) → w/-1` | Read buffered word |
| `putw` | `(fd, w) → w/-1` | Write buffered word |

### Buffered Operations
| Function | Signature | Description |
|----------|-----------|-------------|
| `fopen` | `(name, mode) → fd/-1` | Open buffered file |
| `fcreat` | `(name) → fd/-1` | Create buffered file |
| `fclose` | `(fd) → 0/-1` | Close buffered file |
| `flush` | `(fd) → 0` | Flush file buffers |

### File Information
| Function | Signature | Description |
|----------|-----------|-------------|
| `stat` | `(path, buf) → 0/-1` | Get file status |
| `fstat` | `(fd, buf) → 0/-1` | Get file status by fd |
| `chmod` | `(path, mode) → 0/-1` | Change permissions |
| `chown` | `(path, uid) → 0/-1` | Change ownership |

### Directory Operations
| Function | Signature | Description |
|----------|-----------|-------------|
| `chdir` | `(path) → 0/-1` | Change directory |
| `makdir` | `(path, mode) → 0/-1` | Create directory |
| `unlink` | `(path) → 0/-1` | Delete file |
| `link` | `(old, new) → 0/-1` | Create hard link |

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [Runtime Library](WIKI_RUNTIME_LIBRARY.md)
- [I/O Functions](WIKI_IO_FUNCTIONS.md)
- [String Operations](WIKI_STRING_OPERATIONS.md)
- [Examples](WIKI_EXAMPLES.md)
