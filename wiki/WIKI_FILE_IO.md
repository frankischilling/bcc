# File I/O

Descriptor operations use byte counts, even though B pointers count words
in strict mode. A successful short read or write is possible; callers that
need an entire block must loop until the requested bytes are transferred or
an error/end-of-file occurs.

- `open(name,mode)` opens an existing file. Use 0 for reading; every nonzero
  B word requests write-only access. Mode 2 is not a read/write extension.
  Opening does not create or truncate the file, and starts at offset zero.
- `creat(name,mode)` creates or truncates a file and returns its descriptor.
- `close(fd)` closes a descriptor.
- `read(fd,buf,count)` returns the bytes read, zero at EOF, or -1 on error.
- `write(fd,buf,count)` returns the bytes written or -1 on error.
- `seek(fd,offset,whence)` returns zero or -1. Origins 0, 1, and 2 mean the
  beginning, current position, and end of the file. In the 16-bit model,
  absolute offsets use all 16 bits: values from 32768 through 65535 remain
  usable, and the bit pattern of -1 means 65535. Relative displacements are
  signed. Wider word models keep the host's offset representation.

The host wrapper does not emulate the V1 kernel's 16-bit file-position wrap
or block-device addressing units. File sizes and other host behavior still
come from `lseek`. The [June 1972 seek page](https://www.tuhs.org/Archive/Distributions/Research/Dennis_v2/v2man.pdf)
describes the three origins and the historical 16-bit absolute address range.

`read` does not append a terminator. It leaves bytes beyond the returned
count unchanged, including after EOF, a zero-length request, or an error.
`write` does not stop at NUL or 004. Allocate enough packed storage for the
byte count and check errors before using the buffer.

<!-- bcc-example {"stdout":"OK\n","native":true,"bootstrap":true} -->
```b
main() {
    extrn creat, write, close, open, read, char, unlink, printf;
    auto fd, buf 2;
    fd=creat("iotest",016);
    if(fd<0) return(1);
    if(write(fd,"ABC",3)!=3) return(2);
    if(close(fd)<0) return(3);
    fd=open("iotest",0);
    if(fd<0) return(4);
    if(read(fd,buf,3)!=3) return(5);
    if(char(buf,0)!='A' | char(buf,1)!='B' | char(buf,2)!='C') return(6);
    close(fd);
    if(unlink("iotest")!=0) return(7);
    printf("OK*n");
    return(0);
}
```

## Permission modes

For host `creat`, `chmod`, and `mkdir`/`makdir`, values through octal 077 use the V1
permission layout: 040 set-user-ID, 020 execute, 010 owner-read, 004
owner-write, 002 other-read, and 001 other-write. For example, 016 maps to
host file permissions 0644, subject to the host umask. Directory read access
also maps to search access. Larger modes retain POSIX-mode compatibility;
that extension is not a historical PDP-11 permission encoding.

Native operations use the restored kernel's own permission checks. Host
user identities, umask, ownership rules, and filesystem semantics still
apply to host programs.

## Host unit redirection

`openr(unit,name)` and `openw(unit,name)` redirect the host character-input
and character-output helpers using descriptor duplication. They are host
compatibility facilities, not a claim that every historical B environment
used this interface. Opening output truncates the named file. `flush()`
requests output synchronization. See the runtime source for error handling;
these helpers are not interchangeable with buffered C `FILE` streams.

The runtime does not supply `fopen`, `fclose`, `getc`, `putc`, `getw`, or
`putw` as B library functions. Host interoperability is a separate facility,
not implicit access to arbitrary C APIs.

See [runtime boundaries](WIKI_RUNTIME_LIBRARY.md) and the
[V1 system-call manual](https://www.tuhs.org/cgi-bin/utree.pl?file=V1/man/man2).
