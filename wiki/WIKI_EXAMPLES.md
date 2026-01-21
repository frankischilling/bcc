# Examples

This page contains practical examples demonstrating B programming language concepts, from basic programs to advanced techniques. Each example includes the B source code, explanation of key concepts, and the generated C output.

---

## Hello World

The classic "Hello World" program demonstrates basic output and program structure.

### B Source Code
```b
main() {
    printf("hello world*n");
}
```

### Key Concepts
- **Function Definition**: `main()` is the entry point
- **Library Functions**: `printf()` from `libb.a`
- **String Literals**: `"hello world*n"` with `*n` for newline

### Generated C Code
```c
#include <stdio.h>
typedef intptr_t word;
typedef uintptr_t uword;

static word b_printf(word s) {
    const char *str = (const char*)B_CPTR(s);
    return printf(str);
}

word main(void) {
    return b_printf((word)"hello world\n");
}
```

### Running the Program
```bash
$ ./bcc hello.b -o hello
$ ./hello
hello world
```

---

## Factorial Function

Demonstrates recursive functions and mathematical computation.

### B Source Code
```b
main() {
    auto n;
    n = 5;
    printf("factorial of %d is %d*n", n, factorial(n));
}

factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}
```

### Key Concepts
- **Function Parameters**: No type declarations needed
- **Recursion**: Functions can call themselves
- **Return Values**: Implicit word-sized return
- **Mathematical Operations**: Standard arithmetic operators

### Generated C Code
```c
#include <stdio.h>
typedef intptr_t word;
typedef uintptr_t uword;

static word b_printf(word fmt, ...) {
    /* Formatted print implementation */
}

word factorial(word n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

word main(void) {
    word n = 5;
    return b_printf((word)"factorial of %d is %d\n", n, factorial(n));
}
```

### Running the Program
```bash
$ ./bcc factorial.b -o factorial
$ ./factorial
factorial of 5 is 120
```

---

## Recursion: Printing Numbers Digit by Digit

This simplified version of the library `putnum` shows recursive digit output (works for `n > 0`):
```b
putnumb(n) {
    auto a;
    if (a = n/10)        /* assignment, not equality test */
        putnumb(a);      /* recursive */
    putchar(n%10 + '0');
}

main() {
    putnumb(1234);
    putchar('*n');
}
```

**How it works:** `a` receives the quotient `n/10`; if non-zero, recurse to print higher-order digits first. As recursion unwinds, each call prints its trailing digit, yielding the full number in order.

### Running the Program
```bash
$ ./bcc putnumb.b -o putnumb
$ ./putnumb
1234
```

---

## Argument Passing by Value vs Address (Swapping)

B uses call-by-value; to mutate caller variables you must pass addresses. This swap example illustrates the pattern:
```b
main() {
    auto a, b;

    a = 3;
    b = 7;

    putnum(a); putchar(' ');
    putnum(b); putchar('*n');

    flip(&a, &b);  /* pass addresses explicitly */

    putnum(a); putchar(' ');
    putnum(b); putchar('*n');
}

flip(x, y) {
    auto t;
    t = *x;
    *x = *y;
    *y = t;
}
```

Expected output:
```
3 7
7 3
```

**Key point:** a naive `flip(a, b)` only swaps copies; you must pass `&a` and `&b` and dereference inside `flip`.

---

## Calling Fortran/GMAP via `callf`

Use `callf` to invoke linked Fortran (or C shims) that expect addresses. This mirrors the classic B manual guidance:
```b
/* Fortran stub (or C shim) must be linked in, e.g.:
      subroutine fswap(a,b)
      integer a,b,t
      t = a
      a = b
      b = t
      return
      end
*/

flip(x, y) {
    callf("fswap", x, y);    /* pass addresses to Fortran */
}

main() {
    auto a, b;
    a = 3; b = 7;
    flip(&a, &b);
    printf("%d %d*n", a, b); /* prints: 7 3 */
}
```

**Notes:** scalars must be passed by address; constants require a temporary (`t=0; callf("ftime", &t)`); floating-point returns should be passed back via an output argument rather than a function return.

### Linking real Fortran: `B_CALLF_LIB` quickstart
1. Save `shim.f90`:
   ```fortran
         subroutine sin2(x,y)
         real(8) x
         integer(8) y
         y = nint(sin(x) * 10000.0d0)  ! scaled to fit B's 16-bit print range
         return
         end

         subroutine itimez(t)
         integer(8) t
         integer values(8)
         call date_and_time(values=values)
         t = values(5)*100 + values(6)   ! HHMM fits signed 16-bit
         return
         end
   ```
2. Build a shared lib: `gfortran -shared -fPIC shim.f90 -o libtssshim.so`
3. Run your B program with the library preloaded for `callf`:  
   `B_CALLF_LIB=./libtssshim.so ./your_program`

`callf` will then resolve `sin2`/`itimez` via `dlsym` (tries both `name` and `name_`).

---

## Canonical Programs from the B Tutorial (Sections 11–28)

> Adapted from Dennis Ritchie's B tutorial ([btut](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.html)). These are the reference examples used throughout the manual.

1. **echo_line_goto.b** (Section 11 — if/goto/labels) — Echo one line via labels and explicit goto.  
2. **echo_line_nested.b** (Section 13 — nested calls) — Echo one line using nested `putchar(getchar())`.  
3. **echo_line_while.b** (Section 14 — `while`, assignment in expressions) — Echo one line without the trailing newline.  
4. **split_words.b** (Section 15 — nested while, null statement, exit) — Print each word of a line on its own line.  
5. **min_if_else.b** (Section 16 — `else`) — Minimum of two numbers with if/else.  
6. **min_conditional.b** (Section 16 — `?:`) — Minimum using the conditional expression.  
7. **count_chars.b** (Section 17 — unary operators) — Count characters in a line with `++`.  
8. **prefix_postfix.b** (Section 17 — prefix vs postfix) — Show the difference between `++k` and `k++`.  
9. **pack_chars_basic.b** (Section 18 — bit operators) — Pack four 9-bit chars into one word with shifts and `|`.  
10. **pack_chars_assignops.b** (Section 19 — assignment operators) — Same as #9 using `=-` and `=|`.  
11. **vector_sum.b** (Section 20 — vectors) — Initialize a vector and sum its elements.  
12. **find_zero.b** (Section 20 — increment in subscript) — Find first zero element with `++i` in the subscript.  
13. **external_vector.b** (Section 21 — external vectors) — Access and print an extern vector with initialization.  
14. **pointer_trap.b** (Section 22 — addressing) — Show pointer aliasing when assigning arrays.  
15. **string_copy.b** (Section 23 — strings) — Copy a string using `char`/`lchar`.  
16. **line_copy.b** (Section 25 — `getstr`/`putstr`) — Copy one input line to output.  
17. **file_copy.b** (Section 28 — file I/O) — Copy a file with `openr`/`openw` + `getchar`/`putchar`.  
18. **io_prompt.b** (Section 28 — `flush`, `reread`) — Read command line via `reread`, prompt with `flush`, echo.  
19. **command_switch.b** (Section 26 — `switch`/`break`) — Simple command dispatcher with fall-through cases.  

---

### Complete Listings

#### echo_line_goto.b (Section 11)
```b
main() {
    auto c;
read:
    c = getchar();
    putchar(c);
    if (c != '*n') goto read;
}
```

#### echo_line_nested.b (Section 13)
```b
main() {
read:
    if (putchar(getchar()) != '*n')
        goto read;
}
```

#### echo_line_while.b (Section 14)
```b
main() {
    auto c;
    while ((c = getchar()) != '*n')
        putchar(c);
}
```

#### split_words.b (Section 15)
```b
main() {
    auto c;
    while (1) {
        while ((c = getchar()) != ' ')
            if (putchar(c) == '*n') exit();

        putchar('*n');

        while ((c = getchar()) == ' ');
        if (putchar(c) == '*n') exit();
    }
}
```

#### min_if_else.b (Section 16)
```b
main() {
    auto a, b, x;
    a = 5;
    b = 9;

    if (a < b)
        x = a;
    else
        x = b;

    putnum(x);
    putchar('*n');
}
```

#### min_conditional.b (Section 16)
```b
main() {
    auto a, b, x;
    a = 5;
    b = 9;

    x = a < b ? a : b;

    putnum(x);
    putchar('*n');
}
```

#### count_chars.b (Section 17)
```b
main() {
    auto k;
    k = 0;
    while (getchar() != '*n')
        ++k;
    putnum(k);
    putchar('*n');
}
```

#### prefix_postfix.b (Section 17)
```b
main() {
    auto k, x;

    k = 5;
    x = ++k;
    putnum(x); putchar(' ');
    putnum(k); putchar('*n');

    k = 5;
    x = k++;
    putnum(x); putchar(' ');
    putnum(k); putchar('*n');
}
```

#### pack_chars_basic.b (Section 18)
```b
main() {
    auto c, i;
    c = 0;
    i = 36;

    while ((i = i - 9) >= 0)
        c = c | getchar() << i;

    putnum(c);
    putchar('*n');
}
```

#### pack_chars_assignops.b (Section 19)
```b
main() {
    auto c, i;

    c = 0;
    i = 36;
    while ((i =- 9) >= 0)
        c =| getchar() << i;

    putnum(c);
    putchar('*n');
}
```

#### vector_sum.b (Section 20)
```b
main() {
    auto v[10], i, sum;

    i = 0;
    while (i <= 10) {
        v[i] = i;
        i++;
    }

    sum = 0;
    i = 0;
    while (i <= 10)
        sum =+ v[i++];

    putnum(sum);
    putchar('*n');
}
```

#### find_zero.b (Section 20)
```b
main() {
    auto v[10], i;

    v[0] = 0;
    i = -1;
    while (v[++i]);
    putnum(i);
    putchar('*n');
}
```

#### external_vector.b (Section 21)
```b
main() {
    extrn v;
    auto i;

    i = 0;
    while (i <= 10) {
        putnum(v[i]);
        putchar(' ');
        i++;
    }
    putchar('*n');
}

v[10] 'hi!', 1, 2, 3, 0777;
```

#### pointer_trap.b (Section 22)
```b
main() {
    auto u[2], v[2];

    u[0] = 1;
    v[0] = 9;

    u = v;
    v[0] = 99;

    putnum(u[0]);
    putchar('*n');
}
```

#### string_copy.b (Section 23)
```b
strcopy(s1, s2) {
    auto i;
    i = 0;
    while (lchar(s1,i,char(s2,i)) != '*e')
        i++;
}

main() {
    extrn s1, s2, s3;
    strcopy(s3, s2);
    putstr(s3);
    putchar('*n');
}

s1 "hello";
s2 "world";
s3[10];
```

#### line_copy.b (Section 25)
```b
main() {
    auto s[80];
    putstr(getstr(s));
    putchar('*n');
}
```

#### file_copy.b (Section 28)
```b
main() {
    auto c;
    openr(5, "infile");
    openw(6, "outfile");

    while ((c = getchar()) != '*e')
        putchar(c);
}
```

#### io_prompt.b (Section 28)
```b
main() {
    auto s[80];
    reread();
    getstr(s);

    putstr("command: ");
    putstr(s);
    putchar('*n');

    putstr("type a line: ");
    flush();
    getstr(s);
}
```

#### command_switch.b (Section 26)
```b
main() {
    auto c;
    putchar('>');
    c = getchar();

    switch (c) {
    case 'p': case 'P':
        putstr("print");
        putchar('*n');
        break;

    case 's': case 'S':
        putstr("substitute");
        putchar('*n');
        putstr("print");
        putchar('*n');
        break;

    case 'd': case 'D':
        putstr("delete");
        putchar('*n');
        break;

    case '*n':
        break;

    default:
        putstr("error");
        putchar('*n');
    }
}
```

#### rule110.b (Rule 110 Cellular Automaton)
```b
// -*- mode: simpc -*-

word_size;

display(base, n) {
    extrn printf;
    auto i;

    i  = 0;
    while (i < n) {
        if (base[i]) printf("#"); else printf(".");
        i  += 1;
    }
    printf("\n");
}

next(base, n) {
    auto i, state;

    state = base[0] | base[1] << 1;
    i  = 2;
    while (i < n) {
        state <<= 1;
        state  |= base[i];
        state  &= 7;
        base[i - 1] = (110>>state)&1;
        i += 1;
    }
}

main() {
    extrn malloc, memset;
    auto base, n;

    word_size = &0[1]; /* trick to obtain the word size */
    n    = 100;
    base = malloc(word_size*n);
    memset(base, 0, word_size*n);
    base[n - 2] = 1;

    display(base, n);
    auto i;
    i = 0;
    while (i < n - 3) {
        next(base, n);
        display(base, n);
        i += 1;
    }
}
```


```b
/* Drive TSS SYSTEM? by writing to output unit -1 */
main() {
    extrn wr.unit;
    auto opts, fname;

    opts = "(w)";
    fname = "file";

    wr.unit = -1;                    // send output to TSS SYSTEM? unit
    printf("./rj %s ident;%s*n", opts, fname);
}
```

---

## TSS System Call Smoke Test

Minimal check that `system` executes a command line and how to decode the wait status:
```b
main() {
    auto rc, ec;
    rc = system("/bin/echo hello TSS*n");
    ec = (rc >> 8) & 0377;
    printf("wait status=%d, exit=%d*n", rc, ec);
}
```

Expected output:
```
hello TSS
wait status=0, exit=0
```

## Character Processing

Demonstrates string manipulation and character operations.

### B Source Code
```b
main() {
    auto s;
    s = "hello world*e";

    auto up 100;
    auto rev 100;

    printf("original: %s*n", s);
    printf("length: %d*n", length(s));

    to_upper(s, up);
    printf("uppercase: %s*n", up);

    reverse(s, rev);
    printf("reversed: %s*n", rev);
}

length(s) {
    auto i;
    i = 0;
    while (char(s, i) != '*e') {
        i =+ 1;
    }
    return i;
}

to_upper(src, dst) {
    auto i;
    auto c;

    i = 0;
    while ((c = char(src, i)) != '*e') {
        if (c >= `a' && c <= `z')
            c = c - (`a' - `A');
        lchar(dst, i, c);
        i =+ 1;
    }
    lchar(dst, i, '*e');
}

reverse(src, dst) {
    auto len;
    auto i;

    len = length(src);
    i = 0;

    while (i < len) {
        lchar(dst, i, char(src, len - 1 - i));
        i =+ 1;
    }
    lchar(dst, i, '*e');
}
```

### Key Concepts
- **String Handling**: B-style strings with `*e` termination
- **Character Access**: `char()` and `lchar()` functions
- **Array Operations**: Word arrays for string storage
- **Loop Constructs**: `while` loops for iteration
- **Function Calls**: Passing arrays between functions

### Generated C Code
```c
#include <stdio.h>
typedef intptr_t word;
typedef uintptr_t uword;

#define B_CPTR(w) ((uword)(w))

static word b_char(word s, word i) {
    return ((char*)B_CPTR(s))[i];
}

static word b_lchar(word s, word i, word c) {
    ((char*)B_CPTR(s))[i] = c;
    return s;
}

word length(word s) {
    word i = 0;
    while (b_char(s, i) != 4) {  // *e = ASCII 4 (EOT)
        i = i + 1;
    }
    return i;
}

word to_upper(word s) {
    word result[100];
    word i = 0;
    word c;

    while ((c = b_char(s, i)) != 4) {
        if (c >= 'a' && c <= 'z') {
            c = c - ('a' - 'A');
        }
        b_lchar(result, i, c);
        i = i + 1;
    }
    b_lchar(result, i, 4);
    return (word)result;
}

word length(word s) {
    word i = 0;
    while (b_char(s, i) != 4) {  // *e = ASCII 4 (EOT)
        i = i + 1;
    }
    return i;
}

word to_upper(word src, word dst) {
    word i = 0;
    word c;

    while ((c = b_char(src, i)) != 4) {
        if (c >= 'a' && c <= 'z') {
            c = c - ('a' - 'A');
        }
        b_lchar(dst, i, c);
        i = i + 1;
    }
    b_lchar(dst, i, 4);
}

word reverse(word src, word dst) {
    word len = length(src);
    word i = 0;

    while (i < len) {
        b_lchar(dst, i, b_char(src, len - 1 - i));
        i = i + 1;
    }
    b_lchar(dst, i, 4);
}

word main(void) {
    word s = (word)"hello world*e";  // String literal address
    word up[100];
    word rev[100];

    b_printf((word)"original: %s\n", s);
    b_printf((word)"length: %d\n", length(s));

    to_upper(s, up);
    b_printf((word)"uppercase: %s\n", up);

    reverse(s, rev);
    b_printf((word)"reversed: %s\n", rev);
    return 0;
}
```

### Running the Program
```bash
$ ./bcc char_proc.b -o char_proc
$ ./char_proc
original: hello world
length: 11
uppercase: HELLO WORLD
reversed: dlrow olleh
```

---

## Array Operations

Demonstrates vector (array) operations and manipulation.

### B Source Code
```b
main() {
    auto numbers 10;
    auto size;
    size = 0;

    // Fill array
    while (size < 10) {
        numbers[size] = size * size;
        size =+ 1;
    }

    printf("array contents:*n");
    print_array(numbers, size);

    printf("sum: %d*n", sum_array(numbers, size));
    printf("max: %d*n", max_array(numbers, size));
    printf("average: %d*n", average_array(numbers, size));

    reverse_array(numbers, size);
    printf("reversed:*n");
    print_array(numbers, size);
}

print_array(arr, size) {
    auto i;
    i = 0;
    while (i < size) {
        printf("  [%d] = %d*n", i, arr[i]);
        i =+ 1;
    }
}

sum_array(arr, size) {
    auto sum;
    sum = 0;
    auto i;
    i = 0;
    while (i < size) {
        sum =+ arr[i];
        i =+ 1;
    }
    return sum;
}

max_array(arr, size) {
    if (size == 0) return 0;

    auto max;
    max = arr[0];
    auto i;
    i = 1;
    while (i < size) {
        if (arr[i] > max) {
            max = arr[i];
        }
        i =+ 1;
    }
    return max;
}

average_array(arr, size) {
    if (size == 0) return 0;
    return sum_array(arr, size) / size;
}

reverse_array(arr, size) {
    auto i;
    i = 0;
    auto j;
    j = size - 1;
    while (i < j) {
        auto temp;
        temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
        i =+ 1;
        j =- 1;
    }
}
```

### Key Concepts
- **Array Declaration**: `auto numbers 10;` creates vector of size 10
- **Array Indexing**: `arr[i]` accesses elements (0-based)
- **Pass by Reference**: Arrays are passed by reference automatically
- **Array Bounds**: No automatic bounds checking in B
- **Multiple Functions**: Modular design with separate functions

### Generated C Code
```c
#include <stdio.h>
typedef intptr_t word;
typedef uintptr_t uword;

word print_array(word arr, word size) {
    word i = 0;
    while (i < size) {
        word *array_ptr = (word*)B_CPTR(arr);
        b_printf((word)"  [%d] = %d\n", i, array_ptr[i]);
        i = i + 1;
    }
    return 0;
}

word sum_array(word arr, word size) {
    word sum = 0;
    word i = 0;
    word *array_ptr = (word*)B_CPTR(arr);

    while (i < size) {
        sum = sum + array_ptr[i];
        i = i + 1;
    }
    return sum;
}

word main(void) {
    word numbers[10];
    word size = 0;

    // Fill array
    while (size < 10) {
        numbers[size] = size * size;
        size = size + 1;
    }

    b_printf((word)"array contents:\n");
    print_array((word)numbers, size);

    b_printf((word)"sum: %d\n", sum_array((word)numbers, size));
    return 0;
}
```

### Running the Program
```bash
$ ./bcc arrays.b -o arrays
$ ./arrays
array contents:
  [0] = 0
  [1] = 1
  [2] = 4
  [3] = 9
  [4] = 16
  [5] = 25
  [6] = 36
  [7] = 49
  [8] = 64
  [9] = 81
sum: 285
max: 81
average: 28
reversed:
  [0] = 81
  [1] = 64
  [2] = 49
  [3] = 36
  [4] = 25
  [5] = 16
  [6] = 9
  [7] = 4
  [8] = 1
  [9] = 0
```

---

## Control Flow Examples

### Conditional Processing

```b
main() {
    auto score;
    score = 85;

    if (score >= 90) {
        printf("grade: A*n");
    } else if (score >= 80) {
        printf("grade: B*n");
    } else if (score >= 70) {
        printf("grade: C*n");
    } else {
        printf("grade: F*n");
    }
}
```

### Loop Constructs

```b
main() {
    auto i;
    i = 0;

    // While loop
    printf("while loop:*n");
    while (i < 5) {
        printf("  i = %d*n", i);
        i =+ 1;
    }

    // Do-while equivalent (using while)
    printf("countdown:*n");
    i = 5;
    while (i > 0) {
        printf("  %d*n", i);
        i =- 1;
    }
    printf("  blast off!*n");
}
```

---

## Control Flow Example

```b
main() {
    auto choice;
    choice = 2;

    printf("menu choice: %d*n", choice);

    if (choice == 1)
        printf("option 1 selected*n");
    else if (choice == 2)
        printf("option 2 selected*n");
    else if (choice == 3)
        printf("option 3 selected*n");
    else
        printf("invalid choice*n");
}
```

**Key Concepts:**
- **If-Else Chains**: Multi-way branching using conditional statements
- **Comparison Operators**: `==` for equality testing
- **Logical Flow**: Sequential evaluation of conditions

---

## File I/O Example

```b
main() {
    auto fd;
    auto buf 100;
    auto n;

    fd = creat("example.txt", 0644);
    if (fd < 0) {
        printf("cannot create file*n");
        return 1;
    }

    write(fd, "Hello*n", 6);
    close(fd);

    fd = open("example.txt", 0);
    if (fd < 0) {
        printf("cannot open file*n");
        return 1;
    }

    n = read(fd, buf, 99);
    if (n < 0) {
        printf("read error*n");
        close(fd);
        return 1;
    }

    /* terminate so %s printing is safe in a B-style *e string world */
    lchar(buf, n, '*e');

    printf("read %d bytes: %s*n", n, buf);
    close(fd);
    return 0;
}
```

---

## Function Examples

### Function with Multiple Parameters

```b
main() {
    printf("area of rectangle: %d*n", rectangle_area(10, 5));
    printf("area of circle: %d*n", circle_area(7));
}

rectangle_area(width, height) {
    return width * height;
}

circle_area(radius) {
    // Approximate pi as 3
    return 3 * radius * radius;
}
```

### Recursive Functions

```b
main() {
    printf("fibonacci(10) = %d*n", fibonacci(10));
    printf("gcd(48, 18) = %d*n", gcd(48, 18));
}

fibonacci(n) {
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

gcd(a, b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}
```

---

## Advanced Examples

### Simple Calculator

```b
main() {
    auto op;
    op = `+';
    auto a;
    a = 10;
    auto b;
    b = 5;

    printf("%d %c %d = ", a, op, b);

    if (op == `+')
        printf("%d", a + b);
    else if (op == `-')
        printf("%d", a - b);
    else if (op == `*')
        printf("%d", a * b);
    else if (op == `/') {
        if (b != 0) printf("%d", a / b);
        else printf("division by zero");
    } else
        printf("unknown operator");

    printf("*n");
}
```

### Prime Number Checker

```b
main() {
    auto n;
    n = 17;
    if (is_prime(n)) {
        printf("%d is prime*n", n);
    } else {
        printf("%d is not prime*n", n);
    }
}

is_prime(n) {
    if (n <= 1) return 0;
    if (n <= 3) return 1;
    if (n % 2 == 0 || n % 3 == 0) return 0;

    auto i;
    i = 5;
    while (i * i <= n) {
        if (n % i == 0 || n % (i + 2) == 0) {
            return 0;
        }
        i =+ 6;
    }
    return 1;
}
```

### String Tokenization

```b
main() {
    auto s;
    s = "hello world from b*e";

    printf("original: %s*n", s);
    printf("words:*n");
    print_words(s);
}

print_words(s) {
    auto i;
    auto c;
    auto inword;

    i = 0;
    inword = 0;

    while ((c = char(s, i)) != '*e') {
        if (c != ` ' && c != `*t' && c != `*n') {
            if (!inword) {
                printf("  ");
                inword = 1;
            }
            putchr(c);
        } else {
            if (inword) {
                printf("*n");
                inword = 0;
            }
        }
        i =+ 1;
    }

    if (inword)
        printf("*n");
}
```

---

## Error Handling Examples

### Safe Array Access

```b
main() {
    auto arr 5;
    auto index;
    index = 10;  // Out of bounds!

    // Safe access with bounds checking
    if (safe_set(arr, 5, index, 42)) {
        printf("set arr[%d] = %d*n", index, 42);
    } else {
        printf("index %d out of bounds*n", index);
    }

    auto value;
    if (safe_get(arr, 5, 2, &value)) {
        printf("arr[2] = %d*n", value);
    }
}

safe_set(arr, size, index, value) {
    if (index < 0 || index >= size) {
        return 0;  // Error
    }
    arr[index] = value;
    return 1;  // Success
}

safe_get(arr, size, index, result) {
    if (index < 0 || index >= size) {
        return 0;  // Error
    }
    *result = arr[index];
    return 1;  // Success
}
```

### File Operation Error Handling

```b
main() {
    auto filename 20;
    filename[0]=`d'; filename[1]=`a'; filename[2]=`t'; filename[3]=`a';
    filename[4]=`.'; filename[5]=`t'; filename[6]=`x'; filename[7]=`t';
    filename[8]='*e';
    auto buffer 100;

    if (!safe_write_file(filename, "hello world*n", 12)) {
        printf("failed to write file*n");
        return 1;
    }

    if (!safe_read_file(filename, buffer, 100)) {
        printf("failed to read file*n");
        return 1;
    }

    printf("file contents: %s", buffer);
    return 0;
}

safe_write_file(filename, data, size) {
    auto fd;
    fd = creat(filename, 0644);
    if (fd < 0) return 0;

    if (write(fd, data, size) != size) {
        close(fd);
        return 0;
    }

    if (close(fd) < 0) return 0;
    return 1;
}

safe_read_file(filename, buffer, max_size) {
    auto fd;
    fd = open(filename, 0);
    if (fd < 0) return 0;

    auto bytes_read;
    bytes_read = read(fd, buffer, max_size);
    close(fd);

    if (bytes_read < 0) return 0;

    // Null-terminate for safety
    if (bytes_read < max_size) {
        buffer[bytes_read] = 0;
    }

    return 1;
}
```

---

## Brainfuck Interpreter (REPL) - credit @ luxluth 

Demonstrates byte-addressed pointers, interactive I/O, and simple control flow by interpreting Brainfuck code.

### B Source Code
```b
STDIN;
BUF_LEN;
MEMORY_LEN;

main() {
  extrn malloc, memset, read, printf, getchar, atoi, fflush;
  auto memory, cursor, input_buf, stop, addr_buf, W;

  MEMORY_LEN = 30000; STDIN = 0; BUF_LEN = 512;

  W      = &0[1];          /* byte stride in byte-pointer mode */
  cursor = 0; stop = 0;

  memory    = malloc(MEMORY_LEN*W);
  addr_buf  = malloc(5);
  input_buf = malloc(BUF_LEN);

  memset(memory, 0, MEMORY_LEN*W);
  memset(addr_buf, 0, 5);
  memset(input_buf, 0, BUF_LEN);

  while (!stop) {
    auto cmdslen; cmdslen = 0;
    auto input_cursor; input_cursor = 0;

    printf("# ");
    fflush(0);
    cmdslen = read(STDIN, input_buf, BUF_LEN);
    if (cmdslen > 0) {
      *(input_buf + cmdslen - 1) = 0;  /* strip newline */
      cmdslen -= 1;
    } else { stop = 1; }

    while (input_cursor < cmdslen) {
      auto cmd, fullfilled; fullfilled = 0;
      cmd = *(input_buf + input_cursor) & 0xFF;

      if ((!fullfilled) & (cmd == '>')) { if (cursor < MEMORY_LEN) cursor += 1; fullfilled = 1; }
      if ((!fullfilled) & (cmd == '<')) { if (cursor > 0) cursor -= 1; fullfilled = 1; }
      if ((!fullfilled) & (cmd == '+')) { memory[cursor] = (memory[cursor] == 255) ? 0 : memory[cursor] + 1; fullfilled = 1; }
      if ((!fullfilled) & (cmd == '-')) { memory[cursor] = memory[cursor] ? memory[cursor] - 1 : 255; fullfilled = 1; }
      if ((!fullfilled) & (cmd == '.')) { printf("%c", memory[cursor]); fflush(0); fullfilled = 1; }
      if (cmd == ',') { memory[cursor] = getchar(); fullfilled = 1; }

      if (cmd == '[') {
        if (!memory[cursor]) {
          auto stack, jumped; stack = 1; jumped = 0; input_cursor += 1;
          while((!jumped) & (input_cursor < cmdslen)) {
            cmd = *(input_buf + input_cursor) & 0xFF;
            if (cmd == '[') stack += 1;
            if (cmd == ']') { stack -= 1; if (stack == 0) { jumped = 1; input_cursor -= 1; } }
            input_cursor += 1;
          }
        }
        fullfilled = 1;
      }

      if ((!fullfilled) & (cmd == ']')) {
        if (memory[cursor]) {
          auto stack, jumped; stack = 1; jumped = 0; input_cursor -= 1;
          while((!jumped) & (input_cursor >= 0)) {
            cmd = *(input_buf + input_cursor) & 0xFF;
            if (cmd == ']') stack += 1;
            if (cmd == '[') { stack -= 1; if (stack == 0) jumped = 1; }
            input_cursor -= 1;
          }
        }
        fullfilled = 1;
      }

      if ((!fullfilled) & (cmd == '#')) { cursor = 0; memset(memory, 0, MEMORY_LEN*W); }

      if ((!fullfilled) & (cmd == '$') & (cmdslen == 1)) {
        printf("MEMORY ADDRESS (0-29999): ");
        auto addr_len, addr; addr_len = read(STDIN, addr_buf, 5);
        if (addr_len > 0) {
          *(addr_buf + addr_len - 1) = 0;
          addr = atoi(addr_buf);
          printf("MEMORY(+%d) -> %d*n", addr, memory[addr]);
        }
      }

      input_cursor += 1;
    }

    printf("*n");  /* prompt spacer */
  }
}
```

### How to use it
- Build: `./bcc test.b -o test` (byte-pointer mode is default).
- At the prompt `# `, paste a Brainfuck program (e.g., classic Hello World) and press Enter.
- Special commands: `#` resets memory/cursor; `$` inspects a cell (prompts for an address).

### Notes on pointer model
- The compiler emits byte-addressed lvalues in B_BYTEPTR mode (`B_DEREF`/`B_INDEX` as byte lvalues), so buffers like `input_buf` and `memory` are safe to index and assign without word-stride bugs.
- `W = &0[1];` evaluates to 1 in byte mode; multiply by `W` to size byte buffers consistently.

---

## Performance and Optimization Examples

### Efficient Array Summation

```b
main() {
    auto data 1000;
    auto i;
    i = 0;

    // Initialize array
    while (i < 1000) {
        data[i] = i;
        i =+ 1;
    }

    // Efficient summation
    auto sum;
    sum = 0;
    i = 0;
    while (i < 1000) {
        sum =+ data[i];
        i =+ 1;
    }

    printf("sum = %d*n", sum);
}
```

### Loop Unrolling Example

```b
main() {
    auto arr 8;
    arr[0] = 1; arr[1] = 2; arr[2] = 3; arr[3] = 4;
    arr[4] = 5; arr[5] = 6; arr[6] = 7; arr[7] = 8;

    // Manual loop unrolling for small arrays
    auto sum;
    sum = arr[0] + arr[1] + arr[2] + arr[3] + arr[4] + arr[5] + arr[6] + arr[7];

    printf("sum = %d*n", sum);
}
```

---

## Ncurses Graphics

Demonstrates creating interactive terminal graphics using ncurses. This example shows how B can interface with C libraries for advanced functionality.

### B Source Code
```b
// Simple ncurses demo - draws a moving character
main() {
    extrn initscr, noecho, cbreak, curs_set, timeout, keypad, stdscr;
    extrn endwin, echo, getch, mvaddch, refresh, clear;

    // Initialize ncurses
    initscr();
    noecho();
    cbreak();
    curs_set(0);
    timeout(100);
    keypad(stdscr, 1);

    auto x, y, dx, dy;
    x = 10; y = 5;
    dx = 1; dy = 1;

    auto ch;
    while ((ch = getch()) != 'q') {
        clear();

        // Draw border
        auto i;
        for (i = 0; i < 80; i++) {
            mvaddch(0, i, '#');
            mvaddch(24, i, '#');
        }
        for (i = 0; i < 25; i++) {
            mvaddch(i, 0, '#');
            mvaddch(i, 79, '#');
        }

        // Draw moving character
        mvaddch(y, x, '@');

        // Update position
        x = x + dx;
        y = y + dy;

        // Bounce off walls
        if (x <= 1 | x >= 78) dx = 0 - dx;
        if (y <= 1 | y >= 23) dy = 0 - dy;

        refresh();
    }

    // Cleanup
    endwin();
    echo();
    curs_set(1);
}
```

### Key Concepts
- **External Library Integration**: Using ncurses functions via `extrn` declarations
- **Terminal Graphics**: Direct screen manipulation for interactive programs
- **Event Loop**: Real-time input handling and animation
- **Resource Management**: Proper initialization and cleanup of ncurses

### Compilation
```bash
$ ./bcc ncurses_demo.b -o demo -l ncurses
$ ./demo  # Press 'q' to quit
```

### Notes
- Requires ncurses development libraries to be installed
- Demonstrates B's ability to interface with complex C libraries
- Shows real-time interactive programming capabilities

---

## Langton's Ant

Langton's Ant is a cellular automaton on a grid where an "ant" moves and changes the grid according to simple rules, creating complex emergent patterns. This demonstrates toroidal (wrap-around) grids, state machines, and algorithmic pattern generation.

### B Source Code
```b
/* https://en.wikipedia.org/wiki/Langton%27s_ant */
width;
height;
board;
x;
y;
r;

mod(n, b) return ((n%b + b)%b);

get(b, xn, yn) {
	xn = mod(xn, width);
	yn = mod(yn, height);
	return (b[xn+yn*width]);
}
set(b, xn, yn, v) {
	xn = mod(xn, width);
	yn = mod(yn, height);
	b[xn+yn*width] = v;
}

print() {
	extrn printf;
	auto xn, yn;

	xn = 0; while (xn <= width) {
		printf("##");
		xn += 1;
	}
	printf("\n");

	yn = 0; while (yn < height) {
		printf("#");
		xn = 0; while (xn < width) {
			if ((xn == mod(x, width)) & (yn == mod(y, height))) {
				printf("▒▒");
			} else {
				if (get(board, xn,yn)) {
					printf("██");
				} else {
					printf("  ");
				}
			}
			xn += 1;
		}
		printf("#\n");
		yn += 1;
	}

	xn = 0; while (xn <= width) {
		printf("##");
		xn += 1;
	}
	printf("\n");
}

step() {
	extrn printf;
	auto c;
	c = get(board, x, y);
	if (c) r++; else r--;
	set(board, x, y, !c);
	switch mod(r, 4) {
	case 0: y++; goto out;
	case 1: x++; goto out;
	case 2: y--; goto out;
	case 3: x--; goto out;
	}
out:
}

main() {
	extrn malloc, memset, printf, usleep;
	auto size;
	width  = 25;
	height = 15;
	size = width*height*(&0[1]);

	board = malloc(size);
	memset(board, 0, size);

	r = 0;
	x = 15;
	y = 7;

	while (1) {
		print();
		step();
		printf("%c[%dA", 27, height+2);
		usleep(50000);
	}
}
```

### Key Concepts
- **Toroidal Grid**: Wrap-around boundaries using modular arithmetic
- **State Machine**: Ant direction controlled by rotation counter
- **Emergent Complexity**: Simple rules create highway patterns
- **Real-time Visualization**: Animated terminal display with ant position

### Compilation and Running
```bash
$ ./bcc langton.b -o langton
$ ./langton  # Watch the ant create highways - use Ctrl+C to exit
```

### Explanation
Langton's Ant starts at the center of a grid. When on a white square, it turns right, flips the square to black, and moves forward. When on a black square, it turns left, flips to white, and moves forward. After about 10,000 steps, it enters a "highway" pattern where it builds a straight road and moves perpetually.

The ant's position is shown as `▒▒`, black squares as `██`, and white squares as spaces.

---

## Conway's Game of Life

A complete implementation of Conway's Game of Life - a cellular automaton simulation. This demonstrates complex algorithms, dynamic memory allocation, and real-time graphics using ANSI escape sequences.

**Note**: There's also an ncurses-based version that provides interactive controls and better graphics. See the examples/gol.b file for the ncurses implementation.

### B Source Code
```b
width;
height;
W;
board1;
board2;
board;
next;

mod(n, b) return ((n%b + b)%b);

get(b, x, y) {
	x = mod(x, width);
	y = mod(y, height);
	return (b[x+y*width]);
}
set(b, x, y, v) {
	x = mod(x, width);
	y = mod(y, height);
	b[x+y*width] = v;
}

count_neighbours(b, x, y) {
	auto count; count = 0;
	auto dy; dy = -1; while (dy <= 1) {
		auto dx; dx = -1; while (dx <= 1) {
			if (dx != 0 | dy != 0) count += get(b, x+dx, y+dy);
			dx += 1;
		}
		dy += 1;
	}
	return (count);
}

print() {
	extrn printf;
	auto x, y;

	x = 0; while (x <= width) {
		printf("##");
		x += 1;
	}
	printf("\n");

	y = 0; while (y < height) {
		printf("#");
		x = 0; while (x < width) {
			printf(get(*board, x,y) ? "██" : "  ");
			x += 1;
		}
		printf("#\n");
		y += 1;
	}

	x = 0; while (x <= width) {
		printf("##");
		x += 1;
	}
	printf("\n");
}

step() {
	extrn printf;
	auto y; y = 0; while (y < height) {
		auto x; x = 0; while (x < width) {
			auto a, n, r;
			n = count_neighbours(*board, x, y);
			a = get(*board, x,y);
			r = a ? n == 2 | n == 3 : n==3;
			set(*next, x, y, r);
			x += 1;
		}
		y += 1;
	}

	auto tmp;
	tmp = board;
	board = next;
	next = tmp;
}

main() {
	extrn malloc, memset, printf, usleep;
	auto size;
	width  = 25;
	height = 15;
	size = width*height*(&0[1]);

	board1 = malloc(size);
	board2 = malloc(size);
	memset(board1, 0, size);
	memset(board2,  0, size);
	board = &board1;
	next = &board2;

	// Initialize with some patterns
	set(*board, 3, 2, 1);
	set(*board, 4, 3, 1);
	set(*board, 2, 4, 1);
	set(*board, 3, 4, 1);
	set(*board, 4, 4, 1);

	while (1) {
		print();
		step();
		printf("%c[%dA", 27, height+2);
		usleep(150000);
	}
}
```

### Key Concepts
- **Dynamic Memory Allocation**: `malloc()` and pointer arithmetic for game boards
- **Modular Arithmetic**: Toroidal (wrap-around) grid boundaries
- **Algorithm Implementation**: Complex neighbor counting and state transition rules
- **Real-time Animation**: ANSI escape sequences for screen updates
- **Pointer Manipulation**: Double buffering with board swapping

### Compilation and Running
```bash
$ ./bcc gol.b -o gol
$ ./gol  # Runs the simulation - use Ctrl+C to exit
```

### Ncurses Version with Interactive Controls
For a more advanced version with ncurses graphics, mouse support, and interactive controls:

```bash
$ cd /home/frank/bcc && ./bcc examples/gol.b -o gol -l ncurses -l panel
$ ./gol  # Interactive simulation with keyboard/mouse controls
```

The ncurses version provides:
- Interactive pause/play controls (`s` key)
- Speed adjustment (`i`/`k` keys)
- Mouse clicking to toggle cells
- Information panel showing current state
- Better graphics with proper terminal handling

### Explanation
This implements Conway's Game of Life with:
- 25x15 toroidal grid
- Double buffering for smooth animation
- ANSI escape sequences to redraw the screen
- Glider pattern initialization
- 150ms delay between generations

The simulation shows how simple rules can create complex emergent behavior!

---

## Spinning ASCII Donut

A 3D spinning donut rendered in ASCII art. This example demonstrates:
- Fixed-point arithmetic for 3D rotation and projection
- Z-buffer for hidden surface removal
- Terminal animation with ANSI cursor control
- The `sx64()` function for 16-bit sign extension
- The `usleep()` function for timing

### B Source Code
```b
/* donut.b - Spinning ASCII donut animation
 * Based on a1k0n's donut algorithm
 * Uses fixed-point arithmetic and sx64() for 16-bit sign extension.
 */

b[2000];z[2000];A;B;C;D;E;F;G;H;I;J;
K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;

main() {
    A = C = 1024;
    B = D = 0;
    
    while (1) {
        /* Clear buffers */
        E = 0;
        while (E < 2000) {
            b[E] = 32;
            z[E++] = 127;
        }
        
        /* Render torus */
        E = G = 0;
        F = 1024;
        while (G++ < 90) {
            H = I = 0;
            J = 1024;
            while (I++ < 324) {
                M = F + 2048;
                Z = J * M >> 10;
                P = B * E >> 10;
                Q = H * M >> 10;
                R = P - (A * Q >> 10);
                S = A * E >> 10;
                T = 5120 + S + sx64(B * Q >> 10);
                if (T < 1) T = 1;
                U = F * H >> 10;
                X = 40 + 30 * (sx64(D * Z >> 10) - sx64(C * R >> 10)) / T;
                Y = 12 + 15 * (sx64(D * R >> 10) + sx64(C * Z >> 10)) / T;
                N = sx64((-B * U - D * ((-sx64(A * U) >> 10) + P) - J * (F * C >> 10) >> 10) - S >> 7);
                O = X + 80 * Y;
                V = sx64(T - 5120 >> 4);
                if (22 > Y & Y > 0 & X > 0 & 80 > X & V < z[O]) {
                    z[O] = V;
                    b[O] = *(".,-~:;=!*#$@" + (N > 0 ? N : 0));
                }
                L = J; J -= 5 * H >> 8; H += 5 * L >> 8;
                L = 3145728 - J * J - H * H >> 11;
                J = sx64(J * L >> 10);
                H = sx64(H * L >> 10);
            }
            L = F; F -= 9 * E >> 7; E += 9 * L >> 7;
            L = 3145728 - F * F - E * E >> 11;
            F = sx64(F * L >> 10);
            E = sx64(E * L >> 10);
        }
        
        /* Output frame */
        K = -1;
        while (1761 > ++K) putchar(K % 80 ? b[K] : 10);
        
        /* Rotate view */
        L = B; B -= 5 * A >> 7; A += 5 * L >> 7;
        L = 3145728 - B * B - A * A >> 11;
        B = sx64(B * L >> 10);
        A = sx64(A * L >> 10);
        L = D; D -= 5 * C >> 8; C += 5 * L >> 8;
        L = 3145728 - D * D - C * C >> 11;
        D = sx64(D * L >> 10);
        C = sx64(C * L >> 10);
        
        usleep(30000);
        printf("%c[23A", 27);
    }
}
```

### How to Run
```bash
./bcc examples/donut.b -o donut
./donut
# Press Ctrl+C to stop
```

### Key Functions Used

**`sx64(value)`**: Sign-extends the lower 16 bits to full word size. Essential for this algorithm which uses 16-bit fixed-point arithmetic that can produce values outside the 16-bit signed range.

**`usleep(microseconds)`**: Pauses execution for animation timing. 30000 microseconds = 30ms per frame ≈ 33 FPS.

### Sample Output
```
                             $@@$$@@$$$@@$                                 
                         $$$$$###########$$$$$                             
                       $####**!!!!!!!!!!!**###$$                           
                     ####**!===============!**####                         
                   *##**!!!!==;;:::::::;;=!!!!!*###*                       
                  !****!!!!=;:~--,,.,,-~~:;=!!!!*****                      
                 =****!!!=;;:-,........,--:;;=!!!****=                     
                 !***!!!==;:--...........-~:;=!!!!***!                     
                 !***!!!=;;:-,..       ..,-:;==!!!**!!                     
                ;!!**!!!==;:-,.         ~;==!!!***!!!=:                    
                 =!!!****!*!!!==       =!!********!!!=                     
                 ;=!!!*****#*#####***########****!!==;                     
                 -;=!!****####$$$$$@@@$$$$###****!!=;-                     
                  ~:=!!****###$$$$@@@@$$$$##***!!==;-                      
                   ,:;=!!****###$$$$$$$###****!!=;:-                       
                     -:;=!!!*****######****!!!=;:-                         
                       -:;;==!!!*******!!!==;::-                           
                         .-~::;;=======;;::~-.                             
                             ..,,-----,,,.                                 
```

---

## Rule 110 Cellular Automaton

Rule 110 is a one-dimensional cellular automaton that exhibits complex behavior from simple rules. Each cell is either 0 or 1, and the next generation is determined by the current cell and its two neighbors according to Rule 110's lookup table. This automaton is Turing-complete and can simulate any computation.

### B Source Code
```b
// -*- mode: simpc -*-

word_size;

display(base, n) {
    extrn printf;
    auto i;

    i  = 0;
    while (i < n) {
        if (base[i]) printf("#"); else printf(".");
        i  += 1;
    }
    printf("\n");
}

next(base, n) {
    auto i, state;

    state = base[0] | base[1] << 1;
    i  = 2;
    while (i < n) {
        state <<= 1;
        state  |= base[i];
        state  &= 7;
        base[i - 1] = (110>>state)&1;
        i += 1;
    }
}

main() {
    extrn malloc, memset;
    auto base, n;

    word_size = &0[1]; /* trick to obtain the word size */
    n    = 100;
    base = malloc(word_size*n);
    memset(base, 0, word_size*n);
    base[n - 2] = 1;

    display(base, n);
    auto i;
    i = 0;
    while (i < n - 3) {
        next(base, n);
        display(base, n);
        i += 1;
    }
}
```

### Key Concepts
- **Cellular Automata**: Rule-based evolution of discrete states
- **Bit Manipulation**: Efficient state transitions using bitwise operations
- **Lookup Tables**: Rule 110 encoded as a bit pattern `(110>>state)&1`
- **Dynamic Memory**: Runtime allocation with `malloc` and initialization with `memset`
- **Word Size Detection**: Using `&0[1]` to get the size of a word at runtime

### Compilation and Running
```bash
./bcc examples/rule110.b -o rule110
./rule110
```

### Explanation
This program simulates Rule 110 with a 100-cell grid, starting with a single "1" cell near the right edge. Each generation evolves according to Rule 110:

| Current Pattern | 111 | 110 | 101 | 100 | 011 | 010 | 001 | 000 |
|-----------------|-----|-----|-----|-----|-----|-----|-----|-----|
| Next State      | 0   | 1   | 1   | 0   | 1   | 1   | 1   | 0   |

The automaton displays complex, seemingly random patterns that are actually deterministic and can perform universal computation!

---

## Command Line Arguments

Demonstrates accessing command line arguments in B programs using main function parameters.

### B Source Code
```b
main(argc, argv) {
    extrn printf;

    auto first, i;
    first = 1;
    i = 1;
    while (i < argc) {
        if (!first) printf(" ");
        printf("%s", argv[i++]);
        first = 0;
    }
    printf("\n");
}
```

### Key Concepts
- **Main Function Parameters**: `main(argc, argv)` receives command line arguments
- **Argument Count**: `argc` contains the number of arguments
- **Argument Array**: `argv` is a pointer to the argument strings array
- **Array Indexing**: `argv[i]` accesses individual arguments
- **Library Functions**: `printf()` for formatted output

### Generated C Code
```c
static word b_printf(word fmt, ...);

word __b_user_main(word argc, word argv)
{
  word first = 0;
  word i = 0;
  (first = (word)1);
  (i = (word)1);
  while ((i < argc))
  {
    if ((!first))
    {
      b_printf((word)" ");
    }
    b_printf((word)"%s", B_INDEX(argv, i));
    i = (word)((uword)i + (uword)((word)1));
    (first = (word)0);
  }
  b_printf((word)"\n");
  return 0;
}

int main(int argc, char **argv){
    __b_setargs(argc, argv);
    __b_init();
    return (int)__b_user_main((word)argc, B_PTR(__b_argvb));
}
```

### Running the Program
```bash
$ ./bcc args.b -o args
$ ./args hello world
hello world
$ ./args one two three
one two three
```

### Explanation
The program iterates through command line arguments starting from index 1 (skipping the program name), printing each argument separated by spaces. The `first` flag ensures no leading space is printed.

---

## Duff's Device

Demonstrates the famous Duff's device optimization technique using switch statement fallthrough to unroll loops. This example shows advanced control flow with case statements inside loops.

### B Source Code
```b
// https://en.wikipedia.org/wiki/Duff%27s_device
duffs_device(s) {
    extrn putchar;
    auto n, count, i;
    count = 0;
    // Count characters in B string (terminated by *e = 004)
    while (char(s, count) != 004) count =+ 1;
    n = (count + 7) / 8;
    i = 0;  // character index
    switch count%8 {
    case 0: while(1) { putchar(char(s, i++));
    case 7:            putchar(char(s, i++));
    case 6:            putchar(char(s, i++));
    case 5:            putchar(char(s, i++));
    case 4:            putchar(char(s, i++));
    case 3:            putchar(char(s, i++));
    case 2:            putchar(char(s, i++));
    case 1:            putchar(char(s, i++));
                       putchar('|');
                       putchar('\n');
                       if (--n <= 0) return;
            }
    }
}

main() {
    duffs_device("The quick brown fox jumps over the lazy dog.");
}
```

### Key Concepts
- **Switch Statement Fallthrough**: Case statements fall through to subsequent cases without `break`
- **Loop Unrolling**: Duff's device unrolls loops by 8 iterations for efficiency
- **Case Labels in Loops**: Advanced control flow with case statements inside while loops
- **String Processing**: Manual character-by-character string processing using `char()` function
- **Optimization Technique**: Demonstrates a classic compiler optimization pattern

### Generated C Code
```c
static word duffs_device(word s)
{
  word n = 0;
  word count = 0;
  word i = 0;
  while (b_char(s, count) != (word)4) {
    count = (word)((uword)count + (uword)((word)1));
  }
  n = (word)((uword)((uword)count + (uword)((word)7)) / (uword)((word)8));
  for(;;) {
    word __sw = (word)((uword)count % (uword)((word)8));
    goto __bsw1_dispatch;
    {
      __bsw1_case0:
        ;
      while (((word)1))
      {
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        __bsw1_case7:
          ;
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        __bsw1_case6:
          ;
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        __bsw1_case5:
          ;
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        __bsw1_case4:
          ;
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        __bsw1_case3:
          ;
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        __bsw1_case2:
          ;
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        __bsw1_case1:
          ;
        b_putchar(b_char(s, i));
        i = (word)((uword)i + (uword)((word)1));
        b_putchar(((word)124));
        b_putchar(((word)10));
        if ((--(n) <= ((word)0)))
          return;
      }
    }
    goto __bsw1_end;
    __bsw1_dispatch:
      if (__sw == (word)0) goto __bsw1_case0;
      if (__sw == (word)7) goto __bsw1_case1;
      if (__sw == (word)6) goto __bsw1_case2;
      if (__sw == (word)5) goto __bsw1_case3;
      if (__sw == (word)4) goto __bsw1_case4;
      if (__sw == (word)3) goto __bsw1_case5;
      if (__sw == (word)2) goto __bsw1_case6;
      if (__sw == (word)1) goto __bsw1_case7;
    __bsw1_end:
      break;
  }
  return duffs_device(B_PTR(__b_str0));
}
```

### Running the Program
```bash
$ ./bcc duffs_device.b -o duffs_device
$ ./duffs_device
The |
quick br|
own fox |
jumps ov|
er the l|
azy dog.|
```

### Explanation
Duff's device uses a switch statement to determine how many iterations to unroll in the first pass, then uses fallthrough to handle the remaining iterations in chunks. The string "The quick brown fox jumps over the lazy dog." (44 characters) is processed 6 times in 8-character chunks, with each chunk followed by "|" and newline. Since 44 % 8 = 4, it starts at case 4 and processes 4+4=8 characters per iteration.

---

## External Library Integration

**New Feature**: B programs can now use any C library through the `-l` and `-X` compiler flags. This enables integration with modern libraries like raylib, SDL, ncurses, or any custom C library.

### Raylib Graphics Example
```b
// raylib_demo.b - Bouncing rectangles animation
W;

OBJ_X; OBJ_Y; OBJ_DX; OBJ_DY; OBJ_C; SIZE_OF_OBJ;
OBJS_COUNT;
OBJS;

COLORS_COUNT 6;
OBJ_COLORS [6]
    // B originally does not support hex literals actually.
    0xFF1818FF,
    0xFF18FF18,
    0xFFFF1818,
    0xFFFFFF18,
    0xFFFF18FF,
    0xFF18FFFF;

update_obj(obj) {
    auto nx, ny;

    nx = obj[OBJ_X] + obj[OBJ_DX];
    if (nx < 0 | nx + 100 >= GetScreenWidth()) {
        obj[OBJ_DX] = -obj[OBJ_DX];
        obj[OBJ_C] += 1;
        obj[OBJ_C] %= COLORS_COUNT;
    } else {
        obj[OBJ_X] = nx;
    }

    ny = obj[OBJ_Y] + obj[OBJ_DY];
    if (ny < 0 | ny + 100 >= GetScreenHeight()) {
        obj[OBJ_DY] = -obj[OBJ_DY];
        obj[OBJ_C] += 1;
        obj[OBJ_C] %= COLORS_COUNT;
    } else {
        obj[OBJ_Y] = ny;
    }
}

draw_obj(obj) DrawRectangle(obj[OBJ_X], obj[OBJ_Y], 100, 100, OBJ_COLORS[obj[OBJ_C]]);

main() {
    W = &0[1];

    auto i;
    i = 0;
    OBJ_X       = i++;
    OBJ_Y       = i++;
    OBJ_DX      = i++;
    OBJ_DY      = i++;
    OBJ_C       = i++;
    SIZE_OF_OBJ = i++;

    OBJS_COUNT = 10;
    OBJS = malloc(W*SIZE_OF_OBJ*OBJS_COUNT);
    i = 0; while (i < OBJS_COUNT) {
        OBJS[i*SIZE_OF_OBJ + OBJ_X]  = rand()%500;
        OBJS[i*SIZE_OF_OBJ + OBJ_Y]  = rand()%500;
        OBJS[i*SIZE_OF_OBJ + OBJ_DX] = rand()%10;
        OBJS[i*SIZE_OF_OBJ + OBJ_DY] = rand()%10;
        OBJS[i*SIZE_OF_OBJ + OBJ_C]  = rand()%COLORS_COUNT;
        ++i;
    }

    auto paused;
    paused = 0;

    InitWindow(800, 600, "Hello, from B");
    SetTargetFPS(60);
    while (!WindowShouldClose()) {
        if (IsKeyPressed(32)) {
            paused = !paused;
        }

        if (!paused) {
            i = 0; while (i < OBJS_COUNT) {
                update_obj(&OBJS[(i++)*SIZE_OF_OBJ]);
            }
        }

        BeginDrawing();
        ClearBackground(0xFF181818);
        i = 0; while (i < OBJS_COUNT) {
            draw_obj(&OBJS[(i++)*SIZE_OF_OBJ]);
        }
        EndDrawing();
    }
}
```

### Compilation with External Libraries
```bash
# Compile with raylib (using pkg-config)
pkg-config --libs --cflags raylib
./bcc raylib_demo.b -o demo -l raylib

# Multiple libraries
./bcc program.b -o program -l ncurses -l panel -l m

# Custom includes and defines
./bcc program.b -o program -X -I/usr/local/include -X -DVERSION=1.2 -l customlib

# Optimization flags
./bcc optimized.b -o optimized -X -O3 -X -march=native -l graphics_lib

# Legacy method (still supported)
./bcc program.b -o program -X -lraylib -X -lm
```

### Key Features
- **`-l LIB`**: Links with C library LIB
- **`-X FLAG`**: Passes any flag directly to GCC
- **Full C Compatibility**: Use any installed C library
- **Custom Build Options**: Include paths, defines, optimization flags

### Popular Libraries
- **Graphics**: raylib, SDL2, OpenGL
- **Audio**: PortAudio, OpenAL
- **Networking**: libcurl, sockets
- **Math**: BLAS, LAPACK
- **Databases**: SQLite, PostgreSQL client

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [Data Types & Literals](WIKI_DATA_TYPES.md)
- [Control Structures](WIKI_CONTROL_STRUCTURES.md)
- [Functions](WIKI_FUNCTIONS.md)
- [Arrays & Pointers](WIKI_ARRAYS_POINTERS.md)
- [Runtime Library](WIKI_RUNTIME_LIBRARY.md)
- [File I/O](WIKI_FILE_IO.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
