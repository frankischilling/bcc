# UNIX Programmer's Manual - Section III: Subroutines

**Library Routines - UNIX First Edition (November 1971)**

## Overview

Section III documents the standard library routines - functions that provide higher-level interfaces to system calls and common programming utilities. These routines are typically found in `/lib/libc.a` (the C library archive).

## Major Library Categories

### String Manipulation
- `strcmp` - compare strings
- `strcpy` - copy strings
- `strlen` - string length
- `strcat` - concatenate strings

### Character Classification
- `isalpha` - alphabetic character test
- `isdigit` - digit test
- `isspace` - whitespace test
- `toupper/tolower` - case conversion

### Mathematical Functions
- `sin`, `cos`, `tan` - trigonometric functions
- `exp`, `log`, `pow` - exponential/logarithmic
- `sqrt` - square root
- `abs` - absolute value

### I/O and Formatting
- `printf` - formatted output
- `scanf` - formatted input
- `sprintf` - string formatting
- `fopen`, `fclose` - stream I/O

### Memory Management
- `malloc`, `free` - dynamic memory allocation
- `calloc`, `realloc` - memory utilities

## Implementation Notes

- Library routines are typically written in assembly or C
- Many wrap system calls with error handling
- Some provide buffered I/O for efficiency
- Routines follow K&R C calling conventions

## Header Files

Early UNIX used minimal header files:
- `<stdio.h>` - I/O definitions
- `<ctype.h>` - character classification
- `<math.h>` - mathematical functions

## Historical Development

- Many routines were written by K. Thompson and D.M. Ritchie
- Library evolved alongside the C language
- Some functions were later standardized in ANSI C
- Performance was critical due to limited PDP-11 resources

## Usage Examples

```c
/* String manipulation example */
char s1[100], s2[100];
strcpy(s1, "hello");
strcat(s1, " world");
if (strcmp(s1, s2) == 0) {
    printf("strings equal\n");
}
```

## Related Sections

- **Section II**: System calls that library routines often wrap
- **Section I**: Commands that use these library functions
- **Section VII**: Implementation details and algorithms
