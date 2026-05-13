# PDP-11 B Examples

These programs use the strict 1972 kbman subset accepted by `bcc-pdp`.
They run on the host via `tools/run-apout.sh` (under apout) or inside
SIMH Unix V1 after `tools/install_v1.sh`.

```sh
make test-run B=examples/hello.b           # host (apout)
make v1-run    B=examples/printn.b         # SIMH V1
```

## kbman manual reproductions (§9)

| File | kbman § | What it does |
|---|---|---|
| `printn.b` | §9.1 | Print 12345 in base 10 then base 8.  Output: `12345\n30071\n` |
| `e.b` | §9.2 | Compute `e - 2` to ~200 decimal digits, 50 chars per line, groups of 5.  Slow under apout (minutes). |
| `printfdemo.b` | §9.3 | `printf("d=%d o=%o c=%c s=%s\n", 42, 42, 'A', "hello")` - exercises every conversion. |

## V1 utility ports

| File | What | Args |
|---|---|---|
| `cat.b` | concat stdin or argv files to stdout | files |
| `copy.b` | copy one file to another | from to |
| `echo.b` | print argv args separated by spaces | strings |
| `argv.b` | print argv count and each argument | strings |
| `wc.b` | count lines/words/chars on stdin | (stdin) |
| `cmp.b` | byte-compare two files (exit 0 same, 1 differ) | f1 f2 |

## Pedagogical demos

| File | What | Args |
|---|---|---|
| `hello.b` | classic "hello\n" via 6 putchar | none |
| `count.b` | older I/O demo | (stdin) |
| `gdata.b` | global vector init | none |
| `fact.b` | factorial via recursion + libb printn | n (default 5) |
| `fib.b` | fib(0..15) via recursion | none |
| `sieve.b` | Sieve of Eratosthenes ≤ 100 | none |
| `art.b` | 8-line ASCII pyramid | none |

## Notes on writing 1972-conformant B

- **No `~ ^ && || break continue`.**  Use `0-x-1` for bitwise NOT,
  combinations of `&`/`|` for XOR, single `&`/`|` for logical AND/OR
  (kbman §4.8/4.9), `goto endlabel;` to escape a `while`.
- **`switch` has no parens** around the controlling rvalue: `switch n {...}`.
- **Cases fall through** - there is no `break`.  Exit a switch by `goto
  end;` or by reaching the end of the switch body.
- **`goto rvalue;`** - a label may be assigned to a variable (`p = lab;`)
  and then jumped to (`goto p;`).  See `tests/run/t15_compgoto.b`.
- **Compound assigns** are kbman style: `x =+ 1`, not `x += 1`.  All 16
  forms work, including the comparison ones (`x === y` is "set x to (x ==
  y)", i.e. 0 or 1).
- **Simple defns have no `=`**: `name 42;` (not `name = 42;`).  Vector
  defns: `tab[3] foo, bar, baz;` initializes to addresses of foo/bar/baz.
- **Pointer model is byte-addressed.**  See [../README.md](../README.md)
  for the kbman §12 deviation note.
- **Extensions are opt-in** with `b -x` or `B0FLAGS=-x tools/run-apout.sh`.
  Extension mode accepts `~`, `^`, `=^`, `&&`, `||`, `break`, `continue`,
  and bracketed auto vectors such as `auto v[3]`.
