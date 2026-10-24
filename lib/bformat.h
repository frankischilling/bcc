/* Shared formatting for the linked and inline host runtimes. */
#ifndef BCC_BFORMAT_H
#define BCC_BFORMAT_H
#ifndef __bcc_strict_runtime
#define __bcc_strict_runtime 0
#endif
#ifndef __bcc_format_linkage
#define __bcc_format_linkage
#endif

static word __bcc_format_putchar(word character) {
    word *cell = __bcc_binding_cell("putchar");
    return cell ? __bcc_call1(*cell, character) : b_putchar(character);
}

static word __bcc_format_char(word string, word index) {
    word *cell = __bcc_binding_cell("char");
    return cell ? __bcc_call2(*cell, string, index) : b_char(string, index);
}

static uword __bcc_format_unsigned(word value) {
#if WORD_BITS == 16
    return (uint16_t)value;
#elif WORD_BITS == 32
    return (uint32_t)value;
#else
    return (uword)value;
#endif
}

static void __bcc_format_digits(uword value, unsigned base, int uppercase) {
    char digits[sizeof(uword) * 8];
    size_t used = 0;
    do {
        unsigned digit = (unsigned)(value % base);
        digits[used++] = (char)(digit < 10 ? '0' + digit : (uppercase ? 'A' : 'a') + digit - 10);
        value /= base;
    } while (value);
    while (used) __bcc_format_putchar((word)digits[--used]);
}

static void __bcc_format_signed(word value, unsigned base) {
    value = WVAL(value);
    uword magnitude = (uword)value;
    if (value < 0) {
        __bcc_format_putchar('-');
        magnitude = (uword)0 - magnitude;
    }
    __bcc_format_digits(magnitude, base, 1);
}

__bcc_format_linkage word b_printn(word value, word base) {
    base = WVAL(base);
    if (base < 2 || base > 16) return -1;
    value = WVAL(value);
    word quotient, digit;
    if (value < 0) {
        __bcc_format_putchar('-');
        quotient = -(value / base);
        digit = -(value % base);
    } else {
        quotient = value / base;
        digit = value % base;
    }
    if (quotient) __bcc_library_call2("printn", b_printn, quotient, base);
    __bcc_format_putchar(digit < 10 ? digit + '0' : digit - 10 + 'A');
    return 0;
}

/* The reference printf supplies a magnitude to printn. The minimum signed
 * word has no positive counterpart, so retain the negative-number extension. */
static void __bcc_format_number(word value, unsigned base) {
    word *cell = __bcc_binding_cell("printn");
    if (!cell) { __bcc_format_signed(value, base); return; }
    value = WVAL(value);
    if (value < 0 && WNEG(value) >= 0) {
        __bcc_format_putchar('-');
        value = WNEG(value);
    }
    (void)__bcc_call2(*cell, value, (word)base);
}

struct __bcc_format_arguments {
    va_list *list;
    const word *words;
    size_t count, index;
};

static int __bcc_format_next(struct __bcc_format_arguments *arguments, word *value) {
    if (arguments->list) { *value = va_arg(*arguments->list, word); return 1; }
    if (arguments->index >= arguments->count) return 0;
    *value = arguments->words[arguments->index++];
    return 1;
}

static word __bcc_format_run(word fmt, struct __bcc_format_arguments *arguments) {
    word i = 0;
    for (;;) {
        word ch = __bcc_format_char(fmt, i++);
        if (ch == 004 || (!__bcc_strict_runtime && ch == 0)) break;
        if (ch != '%') { __bcc_format_putchar(ch); continue; }
        word code = __bcc_format_char(fmt, i++);
        if (code == 004 || (!__bcc_strict_runtime && code == 0)) { __bcc_format_putchar('%'); break; }
        int kind = (int)code;
#if !__bcc_strict_runtime
        if (code == '%') { __bcc_format_putchar('%'); continue; }
        if (code == 'z') {
            word modifier = __bcc_format_char(fmt, i);
            if (modifier == 'u' || modifier == 'd') {
                ++i;
                kind = modifier == 'u' ? 256 : 257;
            }
        }
#endif
        int recognized = kind == 'd' || kind == 'o' || kind == 'c' || kind == 's';
#if !__bcc_strict_runtime
        recognized = recognized || kind == 'u' || kind == 'p' || kind == 256 || kind == 257;
#endif
        if (!recognized) {
            /* B72's example prints '%' and revisits the following character.
               Do not fetch an argument for an unrecognized conversion. */
            __bcc_format_putchar('%');
            --i;
            continue;
        }
        word value;
        if (!__bcc_format_next(arguments, &value)) {
            fprintf(stderr, "bcc: printf argument list is too short\n");
            return -1;
        }
        switch (kind) {
        case 'd':
        case 257:
            __bcc_format_number(value, 10);
            break;
        case 'o':
#if __bcc_strict_runtime
            __bcc_format_number(value, 8);
#else
            if (WVAL(value) >= 0) __bcc_format_number(value, 8);
            else __bcc_format_digits(__bcc_format_unsigned(value), 8, 1);
#endif
            break;
        case 'u':
        case 256:
            __bcc_format_digits(__bcc_format_unsigned(value), 10, 1);
            break;
        case 'p':
            __bcc_format_putchar('0'); __bcc_format_putchar('x');
            __bcc_format_digits(__bcc_format_unsigned(value), 16, 0);
            break;
        case 'c':
            __bcc_format_putchar(value);
            break;
        case 's': {
            word j = 0;
            for (;;) {
                word c = __bcc_format_char(value, j++);
                if (c == 004 || (!__bcc_strict_runtime && c == 0)) break;
                __bcc_format_putchar(c);
            }
            break;
        }
        }
    }
    return 0;
}

static word __bcc_printf_words(size_t count, const word *words) {
    if (!count) return -1;
    struct __bcc_format_arguments arguments = {NULL, words + 1, count - 1, 0};
    return __bcc_format_run(words[0], &arguments);
}

__bcc_format_linkage word b_printf(word fmt, ...) {
    va_list list;
    va_start(list, fmt);
    struct __bcc_format_arguments arguments = {&list, NULL, 0, 0};
    word result = __bcc_format_run(fmt, &arguments);
    va_end(list);
    return result;
}

#endif
