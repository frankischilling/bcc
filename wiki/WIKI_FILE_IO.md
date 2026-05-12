# File I/O

BCC's runtime exposes Unix-style descriptor I/O plus Thompson-style unit redirection for `getchar`, `getstr`, `putchar`, `putstr`, and `printf`.

---

## Current API

| Function | Signature | Description |
|----------|-----------|-------------|
| `open` | `(name, mode) -> fd/-1` | Open a file descriptor |
| `creat` | `(name, mode) -> fd/-1` | Create or truncate a file |
| `close` | `(fd) -> 0/-1` | Close a file descriptor |
| `read` | `(fd, buffer, count) -> count/-1` | Read bytes into a buffer |
| `write` | `(fd, buffer, count) -> count/-1` | Write bytes from a buffer |
| `seek` | `(fd, offset, whence) -> 0/-1` | Reposition a descriptor |
| `openr` | `(unit, name) -> unit/-1` | Redirect the current input unit |
| `openw` | `(unit, name) -> unit/-1` | Redirect the current output unit |
| `flush` | `() -> 0` | Flush the current output unit |
| `reread` | `() -> 0` | Read command-line text on the next input operation |

Current BCC does not provide separate `getc`, `putc`, `getw`, `putw`, `fopen`, `fcreat`, or `fclose` runtime functions.

---

## Descriptor I/O

Use descriptor I/O when you need explicit file handles.

```b
main() {
    auto fd;
    fd = open("input.txt", 0);
    if (fd < 0) {
        printf("cannot open input.txt*n");
        return 1;
    }

    auto buffer 256;
    auto n;
    n = read(fd, buffer, 256);
    if (n < 0) {
        printf("read failed*n");
        close(fd);
        return 1;
    }

    printf("read %d bytes*n", n);
    close(fd);
    return 0;
}
```

### Modes

| Mode | Meaning |
|------|---------|
| `0` | Read-only |
| `1` | Write-only |
| `2` | Read/write, where supported by the host |

`creat(name, mode)` uses Unix permission bits such as `0666` or `0644`.

---

## Writing

```b
main() {
    auto fd;
    fd = creat("output.txt", 0666);
    if (fd < 0) {
        printf("cannot create output.txt*n");
        return 1;
    }

    auto text;
    text = "hello from B*n";
    write(fd, text, 13);
    close(fd);
    return 0;
}
```

B strings are terminated by `*e`, but `write` takes an explicit byte count and does not stop at the terminator.

---

## Unit Redirection

`openr` and `openw` redirect the implicit units used by character and string I/O.

```b
main() {
    if (openr(3, "input.txt") < 0) {
        printf("cannot open input.txt*n");
        return 1;
    }

    if (openw(4, "upper.txt") < 0) {
        printf("cannot create upper.txt*n");
        return 1;
    }

    auto c;
    while ((c = getchar()) != '*e') {
        if (c >= 'a' & c <= 'z') {
            c =+ 'A' - 'a';
        }
        putchar(c);
    }

    flush();
    openr(-1, "");
    openw(-1, "");
    return 0;
}
```

Passing a negative unit or an empty filename restores terminal input or output.

---

## Seeking

```b
auto fd;
fd = open("data.bin", 0);

seek(fd, 0, 0);    // beginning
seek(fd, 10, 0);   // byte offset 10
seek(fd, 0, 2);    // end

close(fd);
```

`whence` follows Unix `lseek`: `0` for beginning, `1` for current position, and `2` for end.

---

## EOF

Descriptor reads return `0` at EOF and `-1` on error:

```b
auto n;
while ((n = read(fd, buffer, 256)) > 0) {
    process(buffer, n);
}
```

Unit character input returns `*e` at EOF:

```b
auto c;
while ((c = getchar()) != '*e') {
    putchar(c);
}
```
