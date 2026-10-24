/* Shared formatting for the linked and inline host runtimes. */
#ifndef BCC_BFORMAT_H
#define BCC_BFORMAT_H
#ifndef __bcc_strict_runtime
#define __bcc_strict_runtime 0
#endif
#ifndef __bcc_format_linkage
#define __bcc_format_linkage
#endif

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
    while (used) b_putchar((word)digits[--used]);
}

static void __bcc_format_signed(word value, unsigned base) {
    value = WVAL(value);
    uword magnitude = (uword)value;
    if (value < 0) {
        b_putchar('-');
        magnitude = (uword)0 - magnitude;
    }
    __bcc_format_digits(magnitude, base, 1);
}

__bcc_format_linkage word b_printn(word value, word base) {
    base = WVAL(base);
    if (base < 2 || base > 16) return -1;
    __bcc_format_signed(value, (unsigned)base);
    return 0;
}

__bcc_format_linkage word b_printf(word fmt, ...) {
    va_list args;
    va_start(args, fmt);
    word i = 0;
    for (;;) {
        word ch = b_char(fmt, i++);
        if (ch == 004 || (!__bcc_strict_runtime && ch == 0)) break;
        if (ch != '%') { b_putchar(ch); continue; }
        word code = b_char(fmt, i++);
        if (code == 004 || (!__bcc_strict_runtime && code == 0)) { b_putchar('%'); break; }
        int kind = (int)code;
#if !__bcc_strict_runtime
        if (code == '%') { b_putchar('%'); continue; }
        if (code == 'z') {
            word modifier = b_char(fmt, i);
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
            b_putchar('%');
            --i;
            continue;
        }
        word value = va_arg(args, word);
        switch (kind) {
        case 'd':
        case 257:
            __bcc_format_signed(value, 10);
            break;
        case 'o':
#if __bcc_strict_runtime
            __bcc_format_signed(value, 8);
#else
            __bcc_format_digits(__bcc_format_unsigned(value), 8, 1);
#endif
            break;
        case 'u':
        case 256:
            __bcc_format_digits(__bcc_format_unsigned(value), 10, 1);
            break;
        case 'p':
            b_putchar('0'); b_putchar('x');
            __bcc_format_digits(__bcc_format_unsigned(value), 16, 0);
            break;
        case 'c':
            b_putchar(value);
            break;
        case 's': {
            word j = 0;
            for (;;) {
                word c = b_char(value, j++);
                if (c == 004 || (!__bcc_strict_runtime && c == 0)) break;
                b_putchar(c);
            }
            break;
        }
        }
    }
    va_end(args);
    return 0;
}

#endif
