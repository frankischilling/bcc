# BCC - B Programming Language Compiler

A faithful implementation of Ken Thompson's B programming language compiler from Bell Labs, based on the 1969 B language specification.

## Overview

BCC is a complete B compiler written in C99 that faithfully implements Ken Thompson's PDP-11 B language specification from 1969. B is an untyped systems programming language where everything is a machine word, with explicit operations for indirection, address-of, and pointer arithmetic.

This implementation includes:
- Full B language compiler matching PDP-11 B semantics
- Complete runtime library (`libb.a`) with all original functions
- Authentic B syntax including compound assignments (`=+`, `=-`, etc.)
- Word-based memory model with configurable pointer addressing modes
- Historical accuracy to the original 1969 B specification

## Features

### Core B Language Support
- **Untyped language**: Single universal data type (PDP-11 word = 16 bits)
- **Lvalue/Rvalue distinction**: Explicit address-of (`&`) and indirection (`*`) operators
- **Auto variable declarations**: Local variables with `auto`
- **External declarations**: Global variables with `extrn`
- **Function definitions**: `name(args) { ... }` syntax
- **Control structures**: `if`/`else`, `while`, `break`/`continue`, `switch`/`case` (fall-through by default)
- **Arrays (vectors)**: `name[size]` with word-addressed indexing
- **Goto and labels**: Unrestricted control flow
- **Truth values**: Relational/equality operators return 1 (true) or 0 (false)

### B-Specific Features
- **Compound assignments**: `=+`, `=-`, `=*`, `=/`, `=%`, `=&`, `=|`, `=<<`, `=>>` (value op variable)
- **String literals**: `*e` terminated (EOT marker), not null-terminated
- **Character handling**: `char(base, offset)` and `lchar(base, offset, value)` for byte access
- **Escape sequences**: `*n` (newline), `*t` (tab), `*e` (end), `*0` (null), `**` (asterisk)
- **Word packing**: Multi-character constants packed into single words
- **Pointer arithmetic**: Explicit word-based addressing with configurable modes

### Standard Library (`libb.a`)
Complete implementation of B's runtime library including:
- I/O functions: `putchar`, `getchar`, `print`, `printf`, etc.
- File operations: `open`, `close`, `read`, `write`, `creat`, `seek`
- Process control: `fork`, `wait`, `execl`, `execv`
- System calls: `chdir`, `chmod`, `chown`, `link`, `unlink`, etc.
- String manipulation and utility functions

### Compiler Options
- `-S`: Emit C code to stdout
- `--asm`: Emit assembly code to stdout
- `-c`: Compile to object file
- `-E`: Emit C code to file
- `-g`: Include debug information
- `-Wall`: Enable all warnings (default)
- `-Werror`: Treat warnings as errors
- `--byteptr`: Use byte-addressed pointers
- `--dump-tokens`: Show tokenized input
- `--dump-ast`: Show parsed AST
- `--dump-c`: Emit generated C code
- `--no-line`: Disable #line directives
- `--verbose-errors`: Use descriptive error messages instead of 2-letter codes

## Installation

### Prerequisites
- GCC or compatible C99 compiler
- GNU Make
- Unix-like system (Linux, macOS, BSD)

### Building
```bash
git clone <repository-url>
cd bcc
make
```

The `bcc` executable will be created in the root directory.

## Usage

### Basic Compilation
```bash
# Compile B source to executable
./bcc program.b -o program

# Compile to object file
./bcc -c program.b

# Emit C code
./bcc -S program.b

# Emit assembly code
./bcc --asm program.b
```

### B Language Example
```b
main() {
    auto i;
    i = 0;
    while (i < 10) {
        print(i);
        i =+ 1;
    }
}

print(n) {
    putchar(n + '0');
    putchar('*n');
}
```

## Documentation

This implementation is based on Dennis Ritchie's B language reference manual.

**📖 B Language Wiki**: See [`WIKI_HOME.md`](WIKI_HOME.md) for the complete B programming language wiki homepage.

**📚 Language Reference**: See [`B_LANGUAGE.md`](B_LANGUAGE.md) for comprehensive B language documentation, syntax, and examples.

**Source Documentation**:
- [B Reference Manual](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- [B Tutorial](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf)
- [Unix v1 Manual](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf)

**Original Sources**:
- `src/docs.MD`: Scanned original B language manual from 1972

## Technical Architecture

### Compiler Pipeline

BCC follows a traditional multi-stage compiler architecture with the following pipeline:

1. **Lexical Analysis** (`src/lexer.c`)
   - Single-pass tokenization with look-ahead
   - B-specific escape sequences (`*e`, `*n`, `*t`, etc.)
   - Character packing for multi-character constants
   - Position tracking for error reporting

2. **Syntax Analysis** (`src/parser.c`)
   - Recursive descent parser with Pratt precedence climbing
   - B's unique expression precedence (assignment ops bind right-to-left)
   - AST construction with arena allocation
   - Support for B's comma-separated initializers

3. **Semantic Analysis** (`src/sem.c`)
   - Single-pass symbol table construction
   - Lexical scoping with nested symbol tables
   - Automatic variable lifetime analysis
   - Implicit extern variable handling
   - Function signature validation

4. **Code Generation** (`src/emitter.c`)
   - AST-to-C transpilation strategy
   - B-to-C operator mapping (e.g., `=+` → `+=`)
   - Runtime library integration (`libb.a` functions)
   - Pointer model abstraction (word vs byte addressing)

5. **Host Compilation**
   - Generated C code compiled with GCC
   - Runtime library linking
   - Executable generation

### Memory Management

**Arena-Based Allocation**
- Custom arena allocator (`src/arena.c`) for compilation phase
- 64KB chunks with linked allocation strategy
- Zero-overhead deallocation (entire arena freed at once)
- Mark/rewind support for backtracking during parsing
- Separation of compilation and runtime memory

**Memory Layout**
- Compilation arena: AST nodes, symbols, strings
- Host malloc: Parser state, file I/O buffers
- Generated code uses standard C allocation

### Key Technical Features

#### B-Specific Syntax Handling
- **Assignment Operators**: `=+`, `=-`, `=*`, `=/` (value op variable)
- **String Literals**: `*e` termination instead of null bytes
- **Character Constants**: Packed up to 4 ASCII characters into a word (right-justified, zero-filled)
- **Array Syntax**: `name[constant]` with word-addressed semantics
- **Comma-Separated Initializers**: B-style external variable initialization

#### Expression Precedence
B's operator precedence follows a specific hierarchy (high to low):
```
Postfix: () [] * & ++ --
Unary: * & ++ --
Multiplicative: * / %
Additive: + -
Shifts: << >>
Relational: < <= > >=
Equality: == !=
Bitwise AND: &
Bitwise OR: |
Assignment: = =+ =- =* =/ =% =& =| =<< =>>
```

#### Symbol Table Architecture
- **Hierarchical Scoping**: Global → Function → Block scope nesting
- **Symbol Kinds**: Variables, Functions, Labels
- **Implicit Statics**: Undeclared variables become file-scoped statics
- **Extern Resolution**: Runtime linking of external declarations

#### Code Generation Strategy
- **Transpilation Approach**: B AST → C source code → Native executable
- **Runtime Library**: Comprehensive `libb.a` with 40+ functions
- **Pointer Models**: Configurable word vs byte addressing (`--byteptr`)
- **Helper Functions**: Complex operations (assignments, increments) use C helper functions

#### Error Handling System
- **Dual Error Formats**: Historic 2-letter codes vs verbose messages
- **Source Context**: Error location with caret pointing to problematic token
- **Error Codes**: Based on original B compiler diagnostics
- **Fatal Errors**: Immediate termination with cleanup

### Implementation Challenges & Solutions

#### Historical Accuracy
- **Precedence Matching**: Verified against B manual specifications
- **Character Packing**: Implemented B's word-packing for character constants
- **String Handling**: `*e` termination with proper runtime support
- **Library Compatibility**: Function signatures match original `libb.a`

#### Memory Efficiency
- **Arena Allocation**: Eliminates per-AST-node free operations
- **String Interning**: Compilation-time string deduplication
- **Lazy Code Generation**: AST preserved until final emission

#### Performance Considerations
- **Single-Pass Design**: Lexing → Parsing → Semantics → Codegen in one pass
- **Minimal AST**: Only essential information retained
- **GCC Optimization**: Leverages host compiler optimizations
- **Memory Reuse**: Arena reset between compilation units

### Testing & Validation

#### Test Coverage
- **Language Features**: Comprehensive B syntax validation
- **Library Functions**: Runtime library testing
- **Edge Cases**: Boundary conditions and error paths
- **Historical Compatibility**: Comparison with known B programs

#### Validation Methods
- **AST Dumping**: Internal representation verification (`--dump-ast`)
- **Code Emission**: Generated C code inspection (`--dump-c`)
- **Token Stream**: Lexical analysis validation (`--dump-tokens`)
- **Runtime Testing**: Executable behavior validation
- **Cross-Platform**: Testing across different Unix-like systems

## Build System & Development

### Makefile Structure
```makefile
# Main targets
all: bcc
test: run_test_suite
clean: remove_objects

# Compilation
CC = gcc
CFLAGS = -std=c99 -Wall -Wextra -O2
LDFLAGS = -lm

# Object files
OBJS = lexer.o parser.o sem.o emitter.o util.o arena.o main.o
```

### Development Workflow
1. **Modify Source**: Edit `.c` and `.h` files in `src/`
2. **Build**: `make` to compile the compiler
3. **Test**: `make test` or manual testing with B programs
4. **Debug**: Use dump flags to inspect compilation phases
5. **Validate**: Compare output with expected B behavior

### Code Organization
```
src/
├── bcc.h          # Main header with type definitions
├── main.c         # Command-line interface and compilation driver
├── lexer.c        # Lexical analysis and tokenization
├── parser.c       # Syntax analysis and AST construction
├── sem.c          # Semantic analysis and symbol table
├── emitter.c      # Code generation to C
├── util.c         # Utilities, error handling, arena management
├── arena.c        # Memory allocation system
├── docs.MD        # Original B language documentation
└── create_parser.c # Parser generation utilities
```

### Header Dependencies
- `bcc.h`: Core types, enums, function declarations
- System headers: `stdio.h`, `stdlib.h`, `stdint.h`, `inttypes.h`, etc.
- POSIX headers: `unistd.h`, `sys/wait.h`, `fcntl.h`, etc.

### Build Dependencies
- **Required**: GCC, GNU Make, standard C library
- **Optional**: GCC-specific features for optimization
- **Testing**: Unix-like shell for test execution

### Release Process
1. **Version Tagging**: Semantic versioning for releases
2. **Testing**: Full test suite validation
3. **Documentation**: README updates and changelog
4. **Distribution**: Source tarball with Makefile
5. **Verification**: Bootstrap testing where possible

## Project Structure

```
bcc/
├── README.md              # Compiler documentation
├── WIKI_HOME.md           # B programming language wiki homepage
├── B_LANGUAGE.md          # B programming language reference
├── WIKI_DATA_TYPES.md     # Data types and literals guide
├── WIKI_CONTROL_STRUCTURES.md  # Control structures guide
├── WIKI_FUNCTIONS.md      # Functions guide
├── WIKI_ARRAYS_POINTERS.md     # Arrays and pointers guide
├── WIKI_RUNTIME_LIBRARY.md     # Runtime library guide
├── WIKI_IO_FUNCTIONS.md        # I/O functions guide
├── WIKI_EXAMPLES.md            # Programming examples
├── WIKI_FILE_IO.md             # File I/O guide
├── WIKI_STRING_OPERATIONS.md   # String operations guide
├── WIKI_SYSTEM_CALLS.md        # System calls guide
├── Makefile            # Build system
├── bcc                 # Compiled compiler executable
├── src/                # Source code
│   ├── bcc.h          # Main header file
│   ├── main.c         # Program entry point
│   ├── lexer.c        # Lexical analyzer
│   ├── parser.c       # Syntax parser
│   ├── sem.c          # Semantic analyzer
│   ├── emitter.c      # Code generator
│   ├── util.c         # Utilities and error handling
│   ├── arena.c        # Memory allocator
│   ├── docs.MD        # Original B documentation
│   └── create_parser.c # Parser utilities
├── *.b                # B language test files
├── *.c                # Generated C code examples
└── test*              # Compiled test executables
```

### Key Files Description

**Core Compiler**
- `src/main.c`: Command-line argument parsing, compilation orchestration
- `src/lexer.c`: Tokenization with B-specific escape sequences
- `src/parser.c`: Recursive descent parsing with B precedence rules
- `src/sem.c`: Symbol table management and semantic validation
- `src/emitter.c`: C code generation with runtime library integration

**Support Infrastructure**
- `src/util.c`: Error handling, string utilities, arena management
- `src/arena.c`: Region-based memory allocation
- `src/bcc.h`: Type definitions, function prototypes, constants

**Documentation & Testing**
- `README.md`: Comprehensive project documentation
- `src/docs.MD`: Scanned original B language manual
- `*.b` files: Test programs demonstrating B features
- `Makefile`: GNU Make build configuration

### Build Configuration

The Makefile provides a simple build system:

```makefile
CC = gcc
CFLAGS = -std=c99 -Wall -Wextra -O2
TARGET = bcc
SOURCES = src/util.c src/lexer.c src/parser.c src/sem.c src/arena.c src/emitter.c src/main.c
OBJECTS = $(SOURCES:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS)

%.o: %.c src/bcc.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) $(OBJECTS) src/*.o
```

**Build Requirements**
- GCC 4.8+ or C99-compatible compiler
- GNU Make
- Standard C library with POSIX extensions
- Unix-like environment for runtime library functions

**Build Process**
1. Compile individual source files to object files
2. Link objects into final `bcc` executable
3. No external dependencies required
4. Clean rebuild with `make clean && make`

### Development Tools

#### Debugging Support
- `--dump-tokens`: Raw token stream inspection
- `--dump-ast`: Abstract syntax tree visualization
- `--dump-c`: Generated C code examination
- `--verbose-errors`: Detailed error diagnostics

#### Build System
- **Makefile**: Standard GNU Make build process
- **Dependency Tracking**: Automatic header dependency resolution
- **Clean Targets**: Comprehensive cleanup support

### Future Development Directions

#### Bootstrap Goals
- **Self-Hosting**: B compiler written in B
- **Minimal Runtime**: B execution environment
- **Cross-Compilation**: B-on-B for historical systems

#### Historical Compatibility
- **Unix V1-V7**: Targeting specific historical Unix versions
- **PDP-11 Emulation**: Native architecture compatibility
- **Library Recreation**: Complete `libb.a` reconstruction

#### Advanced Features
- **Optimization**: Constant folding, dead code elimination
- **Debugging**: Source-level debugging support
- **Profiling**: Performance analysis tools

## TODO / Roadmap

### Historical Accuracy
- [ ] Verify expression precedence matches B exactly
- [ ] Implement all B library functions with correct signatures
- [ ] Test against original Unix v1 B programs
- [ ] Validate character packing/unpacking behavior
- [ ] Verify vector operations edge cases

### B Compiler in B
- [ ] Bootstrap: Write a B compiler in B
- [ ] Self-hosting capability
- [ ] Minimal runtime for B-in-B execution

### Historical Unix Compatibility
- [ ] Target Unix V1 (1971) - Test on recovered systems
- [ ] Target Unix V4 (1973) - Run on emulated V4 tape contents
- [ ] Target Unix V6 (1975) - Popular for historical study
- [ ] Target Unix V7 (1979) - "Ancestor of modern Unix"

### Inspiration
The B-in-B and historical Unix goals are inspired by [aap/b](https://github.com/aap/b), which successfully implements a B compiler that can run on historical Unix systems.

## Advanced Features

### Pointer Models

BCC supports two pointer addressing modes to match different B implementations:

**Word Addressing (Default)**
```c
#define B_DEREF(p)   (*(word*)(uword)((uword)(p) * sizeof(word)))
#define B_ADDR(x)    B_PTR(&(x))
```
- Pointers store word indices, not byte addresses
- Array access: `arr[i]` → `*(arr + i)`
- Compatible with original B's memory model

**Byte Addressing (`--byteptr`)**
```c
#define B_DEREF(p)   (*(word*)(uword)(p))
#define B_ADDR(x)    B_PTR(&(x))
```
- Standard byte-addressed pointers
- Array access: `arr[i]` → `*((word*)arr + i)`
- Matches modern C pointer semantics

### Switch Statement Implementation

B's switch statements have fall-through behavior by default (no break statements exist in B). Switch statements are compiled to efficient C `for` loops with computed goto:

```b
switch (expr) {
case 1: stmt1;
case 2: stmt2;
}
```

Becomes:
```c
for (;;) {
    word __sw = expr;
    goto __bsw0_dispatch;

    __bsw0_case1: /* case 1 code - falls through */
    __bsw0_case2: /* case 2 code - falls through */

    __bsw0_dispatch:
        if (__sw == 1) goto __bsw0_case1;
        if (__sw == 2) goto __bsw0_case2;
        goto __bsw0_end;

    __bsw0_end:
        break;
}
```

### External Variable Initialization

B supports complex external variable initialization:

```b
/* Scalar with value */
name 42;

/* Vector with size */
name[10];

/* Vector with initialization */
name[5] 1, 2, 3, 4, 5;

/* Blob initialization */
name { 1, 2, 3 };
```

Compiled to appropriate C declarations and initialization functions.

### Library Function Integration

All B library functions are automatically prefixed with `b_` and linked at runtime:

```b
print(42);  // Calls b_print(42)
getchar();  // Calls b_getchar()
```

### Error Recovery & Diagnostics

**Two-Tier Error System**
- **Historic Mode**: `ex filename:line` (compatible with original B)
- **Verbose Mode**: `filename:line:col: error: expression syntax`

**Error Categories**
- `ex`: Expression syntax errors
- `sx`: Statement syntax errors
- `lv`: Lvalue required errors
- `un`: Undefined name errors
- `rd`: Redefinition errors
- And more matching original B diagnostics

## Technical Specifications

### Language Limits
- **Identifier Length**: Unlimited (arena allocated)
- **Expression Nesting**: Limited by C stack/recursion
- **Array Dimensions**: Single dimension vectors
- **Function Parameters**: Unlimited (vector stored)
- **String Literals**: `*e` terminated, no null termination

### Memory Usage
- **Arena Size**: 64KB chunks, grows dynamically
- **Symbol Table**: Hierarchical with parent pointers
- **AST Nodes**: Compact representation with unions
- **String Storage**: Interned in compilation arena

### Performance Characteristics
- **Compilation Speed**: Linear in source size (single pass)
- **Memory Usage**: Proportional to source complexity
- **Generated Code**: GCC-optimized native executables
- **Runtime Performance**: Equivalent to compiled C code

### Platform Support
- **Architecture**: x86_64, ARM64, and other GCC-supported platforms
- **Operating System**: Linux, macOS, BSD variants, Unix-like systems
- **C Compiler**: GCC 4.8+ or compatible C99 compiler
- **Memory**: 64-bit address space required

## Development Philosophy

### Historical Fidelity
- **Source Accuracy**: Based on 1969 B language specification
- **Library Compatibility**: Function signatures match original `libb.a`
- **Error Messages**: Historic diagnostic format preserved
- **Semantics**: B's unique evaluation rules maintained

### Modern Implementation
- **Memory Safety**: Arena allocation prevents leaks
- **Error Handling**: Comprehensive error reporting with context
- **Cross-Platform**: Portable C99 implementation
- **Maintainability**: Clean separation of compilation phases

### Bootstrap Vision
The ultimate goal is a self-hosting B compiler:
1. **Stage 1**: C implementation (current)
2. **Stage 2**: B compiler written in B
3. **Stage 3**: Self-hosted B-in-B compiler
4. **Stage 4**: Historical Unix compatibility

This follows the tradition of early compiler bootstrapping, where complex systems were built by successive refinement from simpler implementations.

## Troubleshooting

### Common Issues

**Compilation Errors**
- Check B syntax against language specification
- Verify all variables are declared (`auto` or `extrn`)
- Ensure proper brace matching and semicolon usage

**Runtime Errors**
- Check array bounds (B doesn't bounds-check)
- Verify pointer operations use correct addressing mode
- Confirm library function usage matches specifications

**Library Linkage**
- Ensure `libb.a` functions are available
- Check pointer model consistency (`--byteptr` flag)
- Verify external variable declarations

### Debugging Techniques
```bash
# Examine tokenization
./bcc --dump-tokens program.b

# View parse tree
./bcc --dump-ast program.b

# Inspect generated C code
./bcc --dump-c program.b

# Verbose error messages
./bcc --verbose-errors program.b
```

### Performance Tuning
- Use GCC optimization flags when compiling generated code
- Consider pointer model based on access patterns
- Profile memory usage for large programs

## Implementation Details

### Lexical Analysis (`lexer.c`)

**Token Recognition**
- **Keywords**: `auto`, `extrn`, `if`, `else`, `while`, `switch`, `case`, `goto`, `return`
- **Operators**: Full B operator set including compound assignments (`=+`, `=-`, `=*`, etc.)
- **Literals**: Integer constants, character constants (packed into words), strings (`*e` terminated)
- **Identifiers**: Alphabetic followed by alphanumerics
- **Comments**: Block comments `/* ... */` (inherited from BCPL)

**Escape Sequences**
B supports escape sequences in strings and characters:
- `*e`: End marker (EOT, ASCII 4)
- `*n`: Newline (ASCII 10)
- `*t`: Tab (ASCII 9)
- `*0`: Null (ASCII 0)
- `*(`, `*)`: Literal parentheses
- `**`: Literal asterisk
- `*'"`: Literal quotes

**Position Tracking**
- Line and column counting for error reporting
- Filename association for multi-file error messages

### Parser Implementation (`parser.c`)

**Grammar Coverage**
- **Expressions**: Full precedence climbing with B's operator hierarchy
- **Statements**: Block, if/else, while, switch/case, goto/label, return
- **Declarations**: Auto variables, extern declarations, function definitions
- **Lvalues/Rvalues**: Proper handling of address-of (`&`) and indirection (`*`)

**AST Structure**
```c
typedef enum {
    EX_NUM, EX_STR, EX_VAR, EX_CALL, EX_INDEX,
    EX_UNARY, EX_BINARY, EX_ASSIGN, EX_TERNARY, EX_COMMA
} ExprKind;

typedef enum {
    ST_EMPTY, ST_BLOCK, ST_AUTO, ST_IF, ST_WHILE,
    ST_RETURN, ST_EXPR, ST_GOTO, ST_LABEL, ST_SWITCH, ST_CASE
} StmtKind;
```

**Key B Semantics**
- **Lvalue contexts**: Variables, `*expr`, `arr[index]` can be assigned to
- **Rvalue contexts**: All expressions produce word values
- **Address-of**: `&var` produces address (word) of variable
- **Indirection**: `*addr` treats addr as pointer and dereferences it

**Parsing Strategy**
- **Top-Down**: Recursive descent with backtracking prevention
- **Pratt Parsing**: Expression parsing with precedence climbing
- **Single Pass**: AST construction during parsing
- **Error Recovery**: Fatal errors with detailed location reporting

### Semantic Analysis (`sem.c`)

**Symbol Management**
- **Scope Hierarchy**: Global → Function → Block nesting
- **Symbol Types**: Variables (auto/extern), Functions, Labels
- **Lifetime Analysis**: Variable visibility and lifetime tracking
- **Forward References**: Function declarations before definitions

**B Type System**
- **Untyped Language**: Everything is a machine word (PDP-11: 16 bits)
- **No Type Checking**: All operations are valid on words
- **Lvalue/Rvalue Distinction**: What can be assigned to vs. what produces values
- **Pointer Semantics**: Addresses are just words, explicit indirection required

**Static Analysis**
- **Undeclared Variables**: Converted to implicit externs
- **Duplicate Declarations**: Detected and reported
- **Label Resolution**: Goto/label connectivity validation
- **Constant Folding**: Compile-time expression evaluation where possible

### Code Generation (`emitter.c`)

**C Transpilation Strategy**
- **Direct Mapping**: B constructs → equivalent C constructs
- **Runtime Wrappers**: Complex operations use helper functions
- **Library Integration**: Automatic `b_` prefixing for runtime functions
- **Pointer Abstraction**: Configurable word/byte addressing modes

**Generated Code Structure**
```c
// Includes and type definitions
#include <stdio.h>
// ... runtime headers ...

typedef intptr_t word;
typedef uintptr_t uword;

// Runtime library functions
static word b_print(word x) { /* ... */ }

// User code
word main(void) {
    __b_init();  // Initialize globals
    return __b_user_main();
}
```

**Optimization Considerations**
- **GCC Leverage**: Host compiler optimizations applied to generated code
- **Helper Functions**: Complex operations (lvalue assignments) use optimized C functions
- **Inline Expansion**: Simple operations inlined for performance

### Runtime Library (`libb.a` Implementation)

**Core Functions**
- **I/O**: `putchar`, `getchar`, `printf` with `%d`, `%o`, `%c`, `%s` formatting
- **Memory**: `alloc(size)` for dynamic word allocation
- **Character Access**: `char(base, offset)` reads, `lchar(base, offset, value)` writes bytes
- **File I/O**: `open`, `close`, `read`, `write`, `creat`, `seek`
- **Process Control**: `fork`, `wait`, `execl`, `execv`
- **System Calls**: `chdir`, `chmod`, `link`, `unlink`, etc.

**B-Specific Features**
- **String Handling**: `*e` (EOT) termination, not null bytes
- **Word Semantics**: All operations work on PDP-11 word values
- **Character Packing**: Multi-character constants packed into words
- **Pointer Models**: Configurable word vs byte addressing modes

## Testing

### Test Suite
The compiler includes comprehensive test files:
- `mixed_test.b`: Full language feature coverage
- `bitwise_test.b`: Bitwise operator validation
- `switch_test.b`: Switch/case statement testing
- Various example programs demonstrating B idioms

### Testing Methodology
- **Unit Testing**: Individual language features
- **Integration Testing**: Complete program compilation and execution
- **Regression Testing**: Historical B program compatibility
- **Cross-Platform**: Validation across different Unix-like systems

Run the test suite:
```bash
make test
```

### Validation Tools
- **AST Inspection**: `--dump-ast` for parse tree verification
- **Code Review**: `--dump-c` for generated C examination
- **Token Analysis**: `--dump-tokens` for lexical correctness
- **Error Testing**: Both error format modes validation

## Error Messages

BCC supports two error message formats:

**Historic format (default):**
```
ex program.b:15
    x = ;
        ^
```

**Verbose format (`--verbose-errors`):**
```
program.b:15:7: error: expression syntax
    x = ;
        ^
```

## Contributing

Contributions are welcome! Areas of particular interest:
- Historical accuracy improvements
- Additional test cases
- Documentation enhancements
- Performance optimizations

Please ensure all changes maintain compatibility with the original B specification.

## License

This project is licensed under the GNU General Public License v3.0 (GPL-3.0).

## References

### Primary Sources
- [B Reference Manual - Nokia/Bell Labs](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- [B Tutorial - Bell Labs](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf)
- [Unix Programmer's Manual v1](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/man71.pdf)

### Historical Unix
- [Unix Heritage Society](https://www.tuhs.org/)
- [Unix V4 Tape Contents](https://www.tuhs.org/Archive/Applications/Dennis_Tapes/Gao_Analysis/v4_dist/setup.pdf)
- [Mike Taylor's libb.a Analysis](https://www.miketaylor.org.uk/tech/libb-a.html)

### Inspiration
- [aap/b - B compiler for historical Unix](https://github.com/aap/b)

## Authors

Developed as a faithful recreation of Ken Thompson's original B compiler from Bell Labs, based on the 1969 B language.

---

*"B was a programming language I designed in 1972 for the nascent Unix operating system... It was a stripped-down version of BCPL with no types at all."*
- Ken Thompson
