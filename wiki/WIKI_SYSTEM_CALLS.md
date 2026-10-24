# Unix interfaces

The host runtime translates B values into host library calls. The native
PDP-11 runtime invokes the restored kernel. Neither the existence of a
wrapper nor a passing fast-emulator test establishes complete historical
syscall compatibility.

Use the [runtime guide](WIKI_RUNTIME_LIBRARY.md) for arguments, time, status
records, and terminal limitations, and [file I/O](WIKI_FILE_IO.md) for
byte counts and permission bits.

## Process calls

`fork()` returns zero in the child and the child's process ID in the parent,
or a negative result on failure. `wait()` takes no arguments and returns a
child process ID, not a status vector. Do not infer a particular virtual-memory
implementation, such as copy-on-write, from B's interface.

`execv(path,vector,count)` requires a count and includes the new program's
argument zero in that count. `execl(path,arg0,...,0)` uses a zero sentinel.
Success replaces the process; returning indicates failure. Host environment
and descriptor inheritance follow the host operating system, rather than
reproducing an original PDP-11 process image.

The historical spelling for directory creation is `mkdir(path,mode)`.
`makdir` remains available as a project alias. Host privilege and filesystem
checks still apply. `exit()` is the historical no-argument form; an explicit
host exit status is an extension.

## Avoid modern API assumptions

- `time` uses two words of 60 Hz ticks since 1971, not modern epoch seconds.
- `ctime` writes a caller-owned 16-byte buffer, not a returned C string.
- `stat` and `fstat` use the documented B-cell record, not `struct stat`.
- Host `gtty`/`stty` currently expose host flags, not the V1 control-word ABI.
- No general B wrappers for pipes, shared memory, sockets, or arbitrary
  signal handlers are promised by this runtime.

The language library list is section 8 of
[Thompson's reference](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html).
The [historical source guide](HISTORICAL_CONFORMANCE.md) distinguishes that
baseline from other B environments and later Unix interfaces.
