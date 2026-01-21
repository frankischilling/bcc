# Functions

B's function system provides the foundation for modular programming. This page covers function definition, calling conventions, parameter passing, and return values in the B programming language.

---

## Function Definition

### Basic Syntax

Functions in B are defined with a simple syntax:

```b
function_name(parameter1, parameter2, parameter3) {
    // function body
    return expression;
}
```

**Key Characteristics:**
- **No return type declarations**: All functions return word values
- **Parameter declarations**: Parameters are declared in the function header
- **Block body**: Function body is a statement block
- **Optional return**: Functions can return values or default to 0

### Parameter Declaration

Parameters are declared directly in the function header:

```b
// Function with parameters
add(x, y) {
    return x + y;
}

// Function with no parameters
get_input() {
    return getchar();
}

// Single parameter
print_number(n) {
    putchar(n + `0');
}
```

**Parameter Rules:**
- Parameters are automatically declared as `auto` variables
- Parameters have function scope
- No type declarations for parameters
- All parameters are word-sized integers

### Function Body

The function body is a statement block that can contain:
- Variable declarations (`auto`)
- Control structures (`if`, `while`, `switch`)
- Function calls
- Assignments and expressions
- `return` statements

```b
factorial(n) {
    auto result;
    result = 1;

    auto i;
    i = 1;

    while (i <= n) {
        result =* i;
        i =+ 1;
    }

    return result;
}
```

---

## Function Calls

### Call Syntax

Function calls use standard C-like syntax:

```b
result = function_name(arg1, arg2, arg3);
function_name();  // call with no arguments
```

**Call Semantics:**
- Arguments are evaluated left-to-right
- All arguments passed as word values
- No argument type checking
- Function must be declared before use

### Argument Passing

B uses **call-by-value** for all arguments:

```b
swap(a, b) {
    auto temp = a;
    a = b;
    b = temp;
}

main() {
    auto x = 10;
    auto y = 20;
    swap(x, y);
    // x and y unchanged - swap works on copies
}
```

**Important Notes:**
- Functions receive copies of argument values
- Modifying parameters doesn't affect caller's variables
- To modify caller's variables, use pointers

### Return Values

Functions can return values using the `return` statement:

```b
max(a, b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
    // Unreachable code
}

get_status() {
    if (operation_succeeded) {
        return 1;  // success
    }
    return 0;     // failure
}
```

**Return Rules:**
- `return` can take an expression or be bare
- Bare `return` returns 0 (or undefined in some implementations)
- Functions without `return` implicitly return 0
- All return values are word-sized

---

## Variable Scope and Lifetime

### Function Scope

Each function has its own scope containing:
- Parameters (treated as local variables)
- Auto-declared variables within the function
- Labels for goto statements

```b
outer_function() {
    auto x = 10;  // visible in outer_function

    inner_helper() {
        auto y = 20;  // visible only in inner_helper
        // x is visible here (nested scope)
        return x + y;
    }

    return inner_helper();  // returns 30
}
```

### Nested Functions

B allows function definitions inside other functions:

```b
calculator() {
    auto operation = `+';

    add(a, b) {
        return a + b;
    }

    subtract(a, b) {
        return a - b;
    }

    if (operation == `+') {
        return add(10, 5);
    } else {
        return subtract(10, 5);
    }
}
```

**Nested Function Rules:**
- Inner functions can access outer function's variables
- Inner functions are scoped to their containing function
- Functions can be recursive
- No forward declarations needed for nested functions

### Global Variables

Variables declared outside functions are global:

```b
auto global_counter = 0;  // global variable

increment() {
    global_counter =+ 1;
    return global_counter;
}

main() {
    increment();  // returns 1
    increment();  // returns 2
}
```

---

## Advanced Function Techniques

### Function Pointers and Callbacks

B supports function pointers through variable assignment:

```b
auto operation;  // can hold function references

add(a, b) { return a + b; }
multiply(a, b) { return a * b; }

set_operation(op) {
    if (op == 1) {
        operation = add;
    } else {
        operation = multiply;
    }
}

main() {
    set_operation(1);
    auto result = operation(5, 3);  // calls add(5, 3) -> 8
}
```

### Callback Patterns

Functions commonly use callbacks for processing:

```b
process_string(callback) {
    auto c;
    while ((c = getchar()) != '*e') {
        callback(c);
    }
}

print_char(c) {
    putchar(c);
}

main() {
    process_string(print_char);
}
```

### Error Handling with Functions

```b
validate_input(value, error_handler) {
    if (value < 0) {
        error_handler("negative value");
        return 0;
    }
    if (value > 100) {
        error_handler("value too large");
        return 0;
    }
    return 1;  // valid
}

report_error(message) {
    printf("error: %s*n", message);
}

main() {
    auto input = get_number();
    if (!validate_input(input, report_error)) {
        return 1;  // exit with error
    }
    // continue processing
}
```

---

## Built-in Functions

B provides essential built-in functions through `libb.a`:

### Input/Output
```b
putchar(c)        // Output character
getchar()         // Input character
print(n)          // Print number
printf(fmt, ...)  // Formatted output
```

### String Operations
```b
char(s, i)        // Get character at index
lchar(s, i, c)    // Set character at index
```

### File Operations
```b
open(name, mode)      // Open file
close(fd)             // Close file
read(fd, buf, n)      // Read from file
write(fd, buf, n)     // Write to file
creat(name, mode)     // Create file
seek(fd, offset, whence)  // Seek in file
```

### System Functions
```b
fork()          // Create process
wait()          // Wait for process
exec(path, ...) // Execute program
exit(status)    // Exit program
```

### Memory Management
```b
alloc(n)        // Allocate n words
```

---

## Function Implementation Details

### Calling Convention

B's calling convention (as compiled to C):

```c
// B function call: result = add(5, 3)
// Compiles to C: result = b_add(5, 3)

// Generated C function:
word b_add(word a, word b) {
    return (word)((uword)a + (uword)b);
}
```

**Key Aspects:**
- All parameters passed as `word` (uintptr_t)
- Return value is `word`
- Arithmetic wraps at 16-bit boundaries
- Function names prefixed with `b_` in generated code

### Stack Frame Layout

Function activation records contain:
- Return address
- Previous frame pointer
- Local variables
- Parameters
- Temporary values

### Recursion Support

B fully supports recursion:

```b
fibonacci(n) {
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

main() {
    print(fibonacci(10));  // Prints 55
}
```

**Recursion Notes:**
- Each call creates new stack frame
- Parameters and locals are separate per call
- Deep recursion limited by stack size
- No tail call optimization

---

## Common Patterns and Idioms

### Constructor Pattern

```b
make_point(x, y) {
    // Return a "structure" as multiple values
    // B doesn't have structs, so use an array
    auto point 2;
    point[0] = x;
    point[1] = y;
    return point;
}
```

### Method Dispatch

```b
shape_area(shape_type, dimension1, dimension2) {
    if (shape_type == 1) {  // circle
        return 314 * dimension1 * dimension1 / 100;  // pi * r^2 approximation
    }
    if (shape_type == 2) {  // rectangle
        return dimension1 * dimension2;
    }
    return 0;  // unknown shape
}

main() {
    auto circle_area = shape_area(1, 5, 0);    // circle with radius 5
    auto rect_area = shape_area(2, 10, 20);    // 10x20 rectangle
}
```

### State Machine with Functions

```b
// State functions
init_state() {
    printf("initializing*n");
    return 1;  // next state
}

process_state() {
    printf("processing*n");
    return 2;  // next state
}

cleanup_state() {
    printf("cleaning up*n");
    return 0;  // done
}

// State machine dispatcher
run_state_machine() {
    auto state = 0;
    auto state_functions[3];

    state_functions[0] = init_state;
    state_functions[1] = process_state;
    state_functions[2] = cleanup_state;

    while (state < 3) {
        state = state_functions[state]();
    }
}
```

---

## Best Practices

### Function Design

**Single Responsibility:**
```b
// Good: one clear purpose
validate_age(age) {
    return age >= 0 && age <= 150;
}

// Avoid: multiple responsibilities
process_person(name, age, salary) {
    // validation, calculation, output all mixed
}
```

**Parameter Validation:**
```b
divide(a, b) {
    if (b == 0) {
        printf("division by zero*n");
        return 0;
    }
    return a / b;
}
```

**Meaningful Names:**
```b
// Good
calculate_total(price, tax_rate) {
    return price + (price * tax_rate / 100);
}

// Avoid single letters for non-trivial functions
f(a, b) {
    return a + (a * b / 100);
}
```

### Error Handling

**Consistent Return Codes:**
```b
// Use negative values for errors, positive for success
FILE_OPEN_ERROR = -1;
FILE_READ_ERROR = -2;

open_file(name) {
    auto fd = open(name, 0);  // read mode
    if (fd < 0) {
        return FILE_OPEN_ERROR;
    }
    return fd;  // success: return file descriptor
}
```

**Error Propagation:**
```b
process_file(name) {
    auto fd = open_file(name);
    if (fd < 0) {
        return fd;  // propagate error
    }

    // process file...
    close(fd);
    return 0;  // success
}
```

---

## Differences from C Functions

| Feature | B | C |
|---------|---|----|
| Return Types | Always word | Explicit types |
| Parameter Types | Always word | Explicit types |
| Prototypes | Not needed | Required for safety |
| Nested Functions | Allowed | Not standard |
| Default Arguments | No | Yes (C99+) |
| Function Pointers | Variables can hold functions | Explicit function pointers |
| Recursion | Supported | Supported |
| Variable Arguments | Limited (via arrays) | Full support |

---

## Examples

### Complete Programs

**String Length Function:**
```b
strlen(s) {
    auto i = 0;
    while (char(s, i) != '*e') {
        i =+ 1;
    }
    return i;
}

main() {
    auto str[20];
    // ... fill str ...
    auto len = strlen(str);
    printf("length: %d*n", len);
}
```

**Array Processing:**
```b
sum_array(arr, size) {
    auto sum = 0;
    auto i = 0;
    while (i < size) {
        sum =+ arr[i];
        i =+ 1;
    }
    return sum;
}

average_array(arr, size) {
    if (size == 0) return 0;
    return sum_array(arr, size) / size;
}

main() {
    auto data[5];
    data[0] = 10;
    data[1] = 20;
    data[2] = 30;
    data[3] = 40;
    data[4] = 50;

    auto avg = average_array(data, 5);
    printf("average: %d*n", avg);
}
```

**Simple Calculator:**
```b
calculate(op, a, b) {
    if (op == `+') return a + b;
    if (op == `-') return a - b;
    if (op == `*') return a * b;
    if (op == `/') {
        if (b == 0) return 0;  // error
        return a / b;
    }
    return 0;  // invalid operation
}

main() {
    auto result = calculate('+', 10, 5);    // 15
    result = calculate('*', result, 2);     // 30
    print(result);
}
```

---

## Performance Considerations

### Function Call Overhead
- Each function call involves stack manipulation
- Parameter passing copies values
- Return address management
- Frame pointer updates

### Optimization Opportunities
- Inline small functions manually
- Use global variables to avoid parameter passing
- Minimize function nesting depth
- Consider table-driven approaches over function dispatch

### Memory Usage
- Each function call allocates stack space
- Local variables consume stack space
- Recursion can exhaust stack quickly
- Global variables don't consume stack space

---

## References

- [B Reference Manual - Functions](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- [B Tutorial - Program Structure](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf)
- [Users' Reference to B (1972)](https://www.bell-labs.com/usr/dmr/www/kbman.html)

---

## See Also

- [B Programming Language Reference](B_LANGUAGE.md)
- [Runtime Library](WIKI_RUNTIME_LIBRARY.md)
- [I/O Functions](WIKI_IO_FUNCTIONS.md)
- [File I/O](WIKI_FILE_IO.md)
- [System Calls](WIKI_SYSTEM_CALLS.md)
- [String Operations](WIKI_STRING_OPERATIONS.md)
- [Data Types & Literals](WIKI_DATA_TYPES.md)
- [Control Structures](WIKI_CONTROL_STRUCTURES.md)
- [Arrays & Pointers](WIKI_ARRAYS_POINTERS.md)
- [Examples](WIKI_EXAMPLES.md)
