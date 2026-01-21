# Arrays & Pointers

B's array and pointer system is built on word-addressed memory. This page covers array declarations, pointer operations, memory addressing, and the unique characteristics of B's memory model.

---

## Memory Model Fundamentals

### Word-Addressed Memory

B uses **word-addressed memory** (unlike byte-addressed systems):

```b
// In B, memory is addressed by words (16-bit units)
// Arrays and pointers work with word indices, not byte offsets

auto arr 10;    // 10 words of storage
arr[5] = 42;     // Access word at index 5
```

**Key Characteristics:**
- **Word Size**: 16 bits (2 bytes)
- **Pointer Units**: Words, not bytes
- **Array Indexing**: Word-based offsets
- **Pointer Arithmetic**: Word-sized steps

### Word vs Byte Addressing

```b
// B (word-addressed):
auto ptr;
ptr = &variable;         // ptr holds word index
ptr = ptr + 1;           // moves to next word (16-bit step)

// Equivalent in bytes would be:
// ptr = ptr + 2;        // byte systems: +2 for 16-bit values
```

---

## Array Declarations

### Static Arrays

Arrays are declared with size specifications:

```b
// Fixed-size arrays
auto numbers 100;       // 100 words
auto buffer 256;        // 256 words

// Array with initialization
auto data 5;
```

### Dynamic Arrays

B supports dynamic allocation through the runtime library:

```b
auto size = 50;
auto dynamic_array = alloc(size);  // Allocate 'size' words
dynamic_array[0] = 42;             // Use like regular array
```

### Multi-dimensional Arrays

B doesn't have true multi-dimensional arrays, but simulates them:

```b
// Simulated 2D array (3x4)
auto matrix 12;  // 3*4 = 12 elements

// Access element at [i][j]
auto index = i * 4 + j;
matrix[index] = value;

// Or use a function
get_matrix(matrix, i, j) {
    return matrix[i * 4 + j];
}

set_matrix(matrix, i, j, value) {
    matrix[i * 4 + j] = value;
}
```

---

## Lvalues and Rvalues

B has a crucial distinction between **lvalues** (locations that can be assigned to) and **rvalues** (values that can be read):

### Lvalue Contexts
An lvalue represents a memory location that can be assigned to:

```b
auto x;              // x is an lvalue
arr[5] = 42;         // arr[5] is an lvalue
*ptr = 100;          // *ptr is an lvalue
```

### Rvalue Contexts
An rvalue represents a value that can be read:

```b
auto y;
y = x;               // x produces an rvalue
y = arr[5];          // arr[5] produces an rvalue
y = *ptr;            // *ptr produces an rvalue
```

### Address-of Operator (&)
The `&` operator converts an lvalue to an rvalue containing its address:

```b
auto x;
auto ptr;
ptr = &x;            // &x produces the address of x (rvalue)
```

### Indirection Operator (*)
The `*` operator converts an address (rvalue) to an lvalue:

```b
auto ptr;
auto value;
ptr = &x;            // ptr holds address of x
*ptr = 42;           // *ptr is lvalue, assigns to x
value = *ptr;        // *ptr is rvalue, reads from x
```

---

## Pointer Operations

### Address-of Operator

The `&` operator gets the address of a variable:

```b
auto x = 42;
auto ptr = &x;        // ptr now holds address of x
*ptr = 100;           // x is now 100
```

### Dereference Operator

The `*` operator accesses the value at an address:

```b
auto value = *ptr;    // Get value at ptr
*ptr = *ptr + 1;      // Increment value at ptr
```

### Pointer Arithmetic

Pointers support arithmetic operations:

```b
auto arr 10;
auto ptr = &arr[0];   // Point to first element

ptr = ptr + 1;        // Point to arr[1]
ptr = ptr - 1;        // Point to arr[0]

auto offset = 5;
ptr = &arr[0] + offset;  // Point to arr[5]
```

**Pointer Arithmetic Rules:**
- `+` and `-` work in word units
- Pointers can be compared (`==`, `!=`, `<`, `>`)
- Pointer subtraction gives word distance
- No bounds checking

---

## Array-Pointer Relationship

### Arrays as Pointers

In B, arrays and pointers are closely related:

```b
auto arr 5;

// These are equivalent:
arr[2] = 42;              // Array access
*(arr + 2) = 42;          // Pointer access

// Array name is equivalent to &arr[0]
auto ptr = arr;           // ptr points to first element
auto first = *arr;        // Get first element
```

### Function Parameters

Arrays are passed as pointers to functions:

```b
sum_array(arr, size) {
    auto sum = 0;
    auto i = 0;
    while (i < size) {
        sum =+ *arr;      // Dereference current element
        arr = arr + 1;    // Move to next element
        i =+ 1;
    }
    return sum;
}

main() {
    auto data 3;
    auto total = sum_array(data, 3);  // Passes pointer to data[0]
}
```

---

## Advanced Pointer Techniques

### Pointer to Pointer

B supports multiple levels of indirection:

```b
auto x = 42;
auto ptr1 = &x;       // Pointer to x
auto ptr2 = &ptr1;    // Pointer to ptr1

**ptr2 = 100;         // Equivalent to x = 100
*ptr2 = &x;           // Redundant but valid
```

### Function Pointers

Pointers can hold function addresses:

```b
add(a, b) { return a + b; }
subtract(a, b) { return a - b; }

main() {
    auto operation = add;
    auto result = operation(10, 5);    // Calls add(10, 5)

    operation = subtract;
    result = operation(10, 5);         // Calls subtract(10, 5)
}
```

### Dynamic Memory Management

```b
// Allocate memory
auto buffer_size = 100;
auto buffer = alloc(buffer_size);

// Use as array
auto i = 0;
while (i < buffer_size) {
    buffer[i] = i * i;
    i =+ 1;
}

// Pass to function
process_data(buffer, buffer_size);

// Deallocate (B has no free - memory is managed by runtime)
// In practice, allocated memory persists until program end
```

---

## String Handling

### String Storage

Strings are word arrays terminated with `*e` (EOT):

```b
// String literal (compiler adds *e)
"hello world"

// Manual string creation
auto str 20;
str[0] = `H'; str[1] = `i'; str[2] = `*e';
```

### String Operations

B provides built-in string functions:

```b
// Get character at index
auto ch = char(string, index);

// Set character at index
lchar(string, index, new_char);

// String copying
copy_string(dest, src) {
    auto i = 0;
    auto c;
    while ((c = char(src, i)) != '*e') {
        lchar(dest, i, c);
        i =+ 1;
    }
    lchar(dest, i, '*e');  // Terminate
}
```

### String Pointers

```b
auto greeting = "hello";
auto ptr = greeting;       // Points to 'h'
auto first_char = *ptr;    // Gets 'h'
ptr = ptr + 1;             // Points to 'e'
```

---

## Memory Layout and Addressing

### Array Memory Layout

```b
auto arr 5;

/*
Memory layout (word addresses):
arr[0] -> 10    (address: arr + 0)
arr[1] -> 20    (address: arr + 1)
arr[2] -> 30    (address: arr + 2)
arr[3] -> 40    (address: arr + 3)
arr[4] -> 50    (address: arr + 4)
*/
```

### Pointer Representation

```b
// Conceptual representation
auto ptr = &variable;
// ptr holds a word index into memory
// Actual access: memory[ptr]
```

### Address Calculation

```b
auto arr 10;
auto ptr = &arr[0];        // ptr = base_address
auto element_ptr = ptr + 5; // Points to arr[5]

// Manual array access simulation
get_element(base, index) {
    return *(base + index);
}

set_element(base, index, value) {
    *(base + index) = value;
}
```

---

## Common Patterns and Idioms

### Array Traversal

```b
// Method 1: Array indexing
sum_with_indexing(arr, size) {
    auto sum = 0;
    auto i = 0;
    while (i < size) {
        sum =+ arr[i];
        i =+ 1;
    }
    return sum;
}

// Method 2: Pointer arithmetic
sum_with_pointers(arr, size) {
    auto sum = 0;
    auto ptr = arr;        // Start at beginning
    auto end = arr + size; // End marker

    while (ptr < end) {
        sum =+ *ptr;
        ptr = ptr + 1;     // Next word
    }
    return sum;
}
```

### Parameter Passing Techniques

```b
// Pass by reference (using pointers)
swap(ptr1, ptr2) {
    auto temp = *ptr1;
    *ptr1 = *ptr2;
    *ptr2 = temp;
}

main() {
    auto a = 10;
    auto b = 20;
    swap(&a, &b);      // a and b are swapped
}

// Return multiple values
get_min_max(arr, size, min_ptr, max_ptr) {
    if (size == 0) return;

    auto min_val = arr[0];
    auto max_val = arr[0];
    auto i = 1;

    while (i < size) {
        if (arr[i] < min_val) min_val = arr[i];
        if (arr[i] > max_val) max_val = arr[i];
        i =+ 1;
    }

    *min_ptr = min_val;
    *max_ptr = max_val;
}
```

### Linked Data Structures

```b
// Simple linked list node
// Structure: [value, next_pointer]
// Since B has no structs, we use arrays

create_node(value, next) {
    auto node = alloc(2);    // Allocate 2 words
    node[0] = value;         // Value
    node[1] = next;          // Next pointer
    return node;
}

get_value(node) {
    return node[0];
}

get_next(node) {
    return node[1];
}

set_next(node, next) {
    node[1] = next;
}

// Usage
main() {
    auto head = create_node(10, 0);    // First node
    head = create_node(20, head);      // Prepend second node

    // Traverse
    auto current = head;
    while (current != 0) {
        print(get_value(current));
        current = get_next(current);
    }
}
```

---

## Implementation Details

### Compilation Strategy

**Array Declaration:**
```b
auto arr[5];
// Compiles to: word arr[5];
```

**Pointer Operations:**
```b
auto ptr = &x;
// Compiles to: word ptr = B_ADDR(x);
```

**Array Access:**
```b
arr[i]
// Compiles to: B_INDEX(arr, i)
// Which becomes: *(word*)((uword)arr + (uword)i * sizeof(word))
```

### Memory Safety

**B's Approach:**
- No bounds checking on arrays
- Pointer arithmetic is unchecked
- Memory corruption possible
- Manual memory management

**Runtime Library Support:**
- `alloc(n)` for dynamic allocation
- No corresponding `free()` function
- Memory persists until program termination

### Word vs Byte Addressing

**B's Word-Addressed Model:**
```c
// Conceptual C equivalent
#define B_DEREF(p)   (*(word*)((uintptr_t)(p) * sizeof(word)))
#define B_INDEX(a,i) (*(word*)((uintptr_t)(a) * sizeof(word) + (uintptr_t)(i) * sizeof(word)))
```

**Byte-Addressed Alternative:**
```c
// With --byteptr flag
#define B_DEREF(p)   (*(word*)(uintptr_t)(p))
#define B_INDEX(a,i) (*(word*)((uintptr_t)(a) + (uintptr_t)(i) * sizeof(word)))
```

---

## Best Practices

### Array Usage

**Bounds Checking:**
```b
safe_array_access(arr, size, index) {
    if (index < 0 || index >= size) {
        printf("array index out of bounds*n");
        return 0;
    }
    return arr[index];
}
```

**Array Initialization:**
```b
// Prefer explicit initialization
auto buffer 100;  // Initialize to zeros

// Or use a loop
initialize_array(arr, size, value) {
    auto i = 0;
    while (i < size) {
        arr[i] = value;
        i =+ 1;
    }
}
```

### Pointer Safety

**Null Pointer Checks:**
```b
safe_dereference(ptr) {
    if (ptr == 0) {
        printf("null pointer dereference*n");
        return 0;
    }
    return *ptr;
}
```

**Pointer Validation:**
```b
is_valid_pointer(ptr, base, size) {
    return ptr >= base && ptr < base + size;
}
```

### Memory Management

**Allocation Patterns:**
```b
// Fixed-size allocation
auto buffer = alloc(1024);

// Dynamic sizing
get_buffer(requested_size) {
    if (requested_size <= 0) requested_size = 1;
    if (requested_size > 10000) requested_size = 10000;  // Reasonable limit
    return alloc(requested_size);
}
```

---

## Common Pitfalls

### Word vs Byte Confusion

```b
// Incorrect assumption
auto arr 10;
auto ptr = &arr[0];
ptr = ptr + 1;  // Moves 1 word, not 1 byte!

// Correct understanding
// ptr now points to arr[1], not arr[0] + 1 byte
```

### Array Size Confusion

```b
auto arr 5;     // 5 words = 10 bytes
auto size = 5;   // But size is in words, not bytes
```

### Pointer Arithmetic Errors

```b
auto arr 10;
auto ptr = arr;

// This moves 1 word (correct)
ptr = ptr + 1;

// This moves 1 word from original base (may be wrong)
ptr = arr + 1;
```

---

## Performance Considerations

### Array Access

**Direct indexing is fastest:**
```b
// Fastest
arr[i] = value;
```

**Pointer arithmetic alternatives:**
```b
// Slightly slower due to pointer operations
*(arr + i) = value;
```

### Memory Access Patterns

**Sequential access is optimal:**
```b
// Good: sequential word access
auto i = 0;
while (i < size) {
    sum =+ arr[i];
    i =+ 1;
}
```

**Random access may be slower:**
```b
// Potentially slower: random access
sum =+ arr[0] + arr[10] + arr[5];
```

### Memory Usage

**Static arrays:**
- Compile-time allocation
- No runtime overhead
- Fixed size

**Dynamic allocation:**
- Runtime allocation via `alloc()`
- Flexible sizing
- No deallocation (persists until program end)

---

## Examples

### Complete Array Processing Program

```b
// Array utilities
reverse_array(arr, size) {
    auto start = 0;
    auto end = size - 1;

    while (start < end) {
        // Swap elements
        auto temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;

        start =+ 1;
        end =- 1;
    }
}

find_max(arr, size) {
    if (size == 0) return 0;

    auto max_val = arr[0];
    auto i = 1;

    while (i < size) {
        if (arr[i] > max_val) {
            max_val = arr[i];
        }
        i =+ 1;
    }

    return max_val;
}

main() {
    auto data 5;

    printf("original: ");
    auto i = 0;
    while (i < 5) {
        printf("%d ", data[i]);
        i =+ 1;
    }
    printf("*n");

    reverse_array(data, 5);

    printf("reversed: ");
    i = 0;
    while (i < 5) {
        printf("%d ", data[i]);
        i =+ 1;
    }
    printf("*n");

    auto max = find_max(data, 5);
    printf("maximum: %d*n", max);
}
```

### String Manipulation

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

    lchar(dest, i, '*e');  // Terminate
    return dest;
}

// String comparison
strcmp(s1, s2) {
    auto i = 0;
    auto c1, c2;

    while (1) {
        c1 = char(s1, i);
        c2 = char(s2, i);

        if (c1 != c2) {
            return c1 - c2;
        }

        if (c1 == '*e') {
            return 0;  // Strings equal
        }

        i =+ 1;
    }
}

main() {
    auto str1 20;
    auto str2 20;

    strcpy(str1, "hello");
    strcpy(str2, "world");

    auto len1 = strlen(str1);
    auto len2 = strlen(str2);

    printf("len1: %d, len2: %d*n", len1, len2);

    auto cmp = strcmp(str1, str2);
    if (cmp == 0) {
        printf("strings are equal*n");
    } else if (cmp < 0) {
        printf("str1 < str2*n");
    } else {
        printf("str1 > str2*n");
    }
}
```

---

## Differences from Modern Systems

| Feature | B | C/Modern Languages |
|---------|---|-------------------|
| Addressing | Word-based | Byte-based |
| Arrays | Fixed-size | Variable-size |
| Pointer Arithmetic | Word steps | Byte steps |
| Bounds Checking | None | Optional |
| Memory Management | Manual alloc | malloc/free |
| String Termination | `*e` (EOT) | `\0` (NUL) |

---

## References

- [B Reference Manual - Arrays and Pointers](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/kbman.html)
- [B Tutorial - Memory and Data](https://www.nokia.com/bell-labs/about/dennis-m-ritchie/btut.pdf)
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
- [Functions](WIKI_FUNCTIONS.md)
- [Examples](WIKI_EXAMPLES.md)
