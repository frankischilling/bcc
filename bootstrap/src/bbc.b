/*
 * bbc.b - B-written bootstrap compiler for the host C99 BCC path.
 *
 * This compiler accepts the practical host BCC surface used by examples,
 * while --strict keeps Thompson/B72-style extension rejection available.
 */

SRC; SRCLEN; POS; LINE; COL; STRICT; WANT_NCURSES;
TOK; TNUM; TTEXT;
OUT; FUNS; NFUNS; MAIN_NARGS; HAS_MAIN; GLOBS; NGLOBS;
VERBOSE;

fatal(msg) {
    extrn printf, exit;
    printf("bbc: %s at line %d*n", msg, LINE);
    exit(1);
}

slen(s) {
    auto n, c;
    n = 0;
    c = char(s, n);
    while ((c != 0) & (c != 4)) {
        n = n + 1;
        c = char(s, n);
    }
    return(n);
}

streq(a, b) {
    auto i, ca, cb;
    i = 0;
    while (1) {
        ca = char(a, i);
        cb = char(b, i);
        if (ca == 4) ca = 0;
        if (cb == 4) cb = 0;
        if (ca != cb) return(0);
        if (ca == 0) return(1);
        i = i + 1;
    }
}

scat(a, b) {
    auto la, lb, r, i;
    extrn malloc;
    la = slen(a);
    lb = slen(b);
    r = malloc(la + lb + 1);
    i = 0;
    while (i < la) {
        lchar(r, i, char(a, i));
        i = i + 1;
    }
    i = 0;
    while (i < lb) {
        lchar(r, la + i, char(b, i));
        i = i + 1;
    }
    lchar(r, la + lb, 0);
    return(r);
}

itoa(n) {
    auto buf, tmp, i, neg, d, j;
    extrn malloc;
    buf = malloc(64);
    tmp = malloc(64);
    i = 0;
    neg = 0;
    if (n < 0) {
        neg = 1;
        n = -n;
    }
    if (n == 0) {
        lchar(tmp, i, '0');
        i = i + 1;
    }
    while (n > 0) {
        d = n % 10;
        lchar(tmp, i, '0' + d);
        i = i + 1;
        n = n / 10;
    }
    j = 0;
    if (neg) {
        lchar(buf, j, '-');
        j = j + 1;
    }
    while (i > 0) {
        i = i - 1;
        lchar(buf, j, char(tmp, i));
        j = j + 1;
    }
    lchar(buf, j, 0);
    return(buf);
}

buf_new(cap) {
    auto b, p;
    extrn malloc;
    b = malloc(3 * &0[1]);
    p = malloc(cap);
    b[0] = p;
    b[1] = 0;
    b[2] = cap;
    lchar(p, 0, 0);
    return(b);
}

buf_grow(b, need) {
    auto old, oldcap, ncap, p, i;
    extrn malloc, free;
    old = b[0];
    oldcap = b[2];
    ncap = oldcap * 2;
    while (ncap <= need) ncap = ncap * 2;
    p = malloc(ncap);
    i = 0;
    while (i < b[1]) {
        lchar(p, i, char(old, i));
        i = i + 1;
    }
    lchar(p, i, 0);
    free(old);
    b[0] = p;
    b[2] = ncap;
}

buf_ch(b, c) {
    auto n;
    n = b[1];
    if (n + 2 >= b[2]) buf_grow(b, n + 2);
    lchar(b[0], n, c);
    b[1] = n + 1;
    lchar(b[0], b[1], 0);
}

buf_str(b, s) {
    auto i, c;
    i = 0;
    c = char(s, i);
    while ((c != 0) & (c != 4)) {
        buf_ch(b, c);
        i = i + 1;
        c = char(s, i);
    }
}

buf_num(b, n) {
    buf_str(b, itoa(n));
}

buf_take(b) {
    return(b[0]);
}

write_all(fd, data, n) {
    auto off, w;
    extrn write;
    off = 0;
    while (off < n) {
        w = write(fd, data + off, n - off);
        if (w <= 0) return(-1);
        off = off + w;
    }
    return(0);
}

read_file(path) {
    auto fd, cap, data, n, total;
    extrn malloc, openr, read, close;
    cap = 1048576;
    data = malloc(cap + 1);
    fd = openr(10, path);
    if (fd < 0) fatal("cannot open input");
    total = 0;
    n = read(10, data + total, cap - total);
    while (n > 0) {
        total = total + n;
        if (total >= cap) fatal("input too large");
        n = read(10, data + total, cap - total);
    }
    close(10);
    lchar(data, total, 0);
    SRC = data;
    SRCLEN = total;
    POS = 0;
    LINE = 1;
    COL = 1;
}

save_file(path, data, n) {
    auto fd;
    extrn openw, close;
    fd = openw(11, path);
    if (fd < 0) fatal("cannot open output");
    if (write_all(11, data, n) != 0) fatal("write failed");
    close(11);
}

peekc() {
    if (POS >= SRCLEN) return(0);
    return(char(SRC, POS));
}

getc1() {
    auto c;
    if (POS >= SRCLEN) return(0);
    c = char(SRC, POS);
    POS = POS + 1;
    if (c == 10) {
        LINE = LINE + 1;
        COL = 1;
    } else {
        COL = COL + 1;
    }
    return(c);
}

is_alpha(c) {
    if ((c >= 'a') & (c <= 'z')) return(1);
    if ((c >= 'A') & (c <= 'Z')) return(1);
    if (c == '_') return(1);
    return(0);
}

is_digit(c) {
    return((c >= '0') & (c <= '9'));
}

is_xdigit(c) {
    if (is_digit(c)) return(1);
    if ((c >= 'a') & (c <= 'f')) return(1);
    if ((c >= 'A') & (c <= 'F')) return(1);
    return(0);
}

xval(c) {
    if (is_digit(c)) return(c - '0');
    if ((c >= 'a') & (c <= 'f')) return(c - 'a' + 10);
    if ((c >= 'A') & (c <= 'F')) return(c - 'A' + 10);
    return(0);
}

is_alnum(c) {
    if (is_alpha(c)) return(1);
    return(is_digit(c));
}

skip_ws() {
    auto c, d;
    c = peekc();
    while (1) {
        while ((c == 32) | (c == 9) | (c == 10) | (c == 13)) {
            getc1();
            c = peekc();
        }
        if (c == '/') {
            getc1();
            d = peekc();
            if (d == 42) {
                getc1();
                while (1) {
                    c = getc1();
                    if (c == 0) fatal("unterminated comment");
                    if ((c == 42) & (peekc() == '/')) {
                        getc1();
                        break;
                    }
                }
                c = peekc();
            } else if (d == '/') {
                if (STRICT) fatal("line comments are not strict B");
                while ((peekc() != 0) & (peekc() != 10)) getc1();
                c = peekc();
            } else {
                POS = POS - 1;
                COL = COL - 1;
                return(0);
            }
        } else {
            return(0);
        }
    }
}

new_text(start, n) {
    auto s, i;
    extrn malloc;
    s = malloc(n + 1);
    i = 0;
    while (i < n) {
        lchar(s, i, char(SRC, start + i));
        i = i + 1;
    }
    lchar(s, n, 0);
    return(s);
}

read_escape() {
    auto c;
    c = getc1();
    if (c == 'n') return(10);
    if (c == 't') return(9);
    if (c == 'e') return(4);
    if (c == '0') return(0);
    if (c == 42) return(42);
    if (c == '"') return('"');
    if (c == 39) return(39);
    return(c);
}

is_star_escape(c) {
    if (c == 'n') return(1);
    if (c == 't') return(1);
    if (c == 'e') return(1);
    if (c == '0') return(1);
    if (c == 42) return(1);
    if (c == '"') return(1);
    return(0);
}

scan_string() {
    auto b, c;
    b = buf_new(64);
    while (1) {
        c = getc1();
        if (c == 0) fatal("unterminated string");
        if (c == '"') break;
        if (c == 92) {
            if (STRICT) fatal("backslash escapes are not strict B");
            c = read_escape();
        }
        if ((c == 42) & is_star_escape(peekc())) c = read_escape();
        buf_ch(b, c);
    }
    TTEXT = buf_take(b);
    TOK = 3;
}

scan_char() {
    auto c, n, v;
    n = 0;
    v = 0;
    while (1) {
        c = getc1();
        if (c == 0) fatal("unterminated char constant");
        if (c == 39) break;
        if (c == 92) {
            if (STRICT) fatal("backslash escapes are not strict B");
            c = read_escape();
        }
        if ((c == 42) & is_star_escape(peekc())) c = read_escape();
        v = (v << 8) | c;
        n = n + 1;
        if (STRICT & (n > 2)) fatal("long char constant is not strict B");
        if (n > 4) fatal("character constant too long");
    }
    TNUM = v;
    TOK = 4;
}

keyword(s) {
    if (streq(s, "auto")) return(10);
    if (streq(s, "extrn")) return(11);
    if (streq(s, "if")) return(12);
    if (streq(s, "else")) return(13);
    if (streq(s, "while")) return(14);
    if (streq(s, "return")) return(15);
    if (streq(s, "goto")) return(16);
    if (streq(s, "switch")) return(17);
    if (streq(s, "case")) return(18);
    if (streq(s, "default")) return(19);
    if (streq(s, "break")) return(20);
    if (streq(s, "continue")) return(21);
    return(1);
}

next() {
    auto c, start, base, v, s, d;
    skip_ws();
    c = getc1();
    TTEXT = 0;
    TNUM = 0;
    if (c == 0) {
        TOK = 0;
        return(0);
    }
    if (is_alpha(c)) {
        start = POS - 1;
        while (is_alnum(peekc())) getc1();
        s = new_text(start, POS - start);
        TTEXT = s;
        TOK = keyword(s);
        return(0);
    }
    if (is_digit(c)) {
        base = 10;
        v = c - '0';
        if (c == '0') {
            if ((peekc() == 'x') | (peekc() == 'X')) {
                if (STRICT) fatal("hex literals are not strict B");
                getc1();
                base = 16;
                v = 0;
            } else {
                base = 8;
            }
        }
        while (((base == 16) & is_xdigit(peekc())) | ((base != 16) & is_digit(peekc()))) {
            if (base == 16) d = xval(getc1());
            else d = getc1() - '0';
            if ((base == 8) & (d >= 8)) fatal("bad octal digit");
            v = v * base + d;
        }
        TNUM = v;
        TOK = 2;
        return(0);
    }
    if (c == '"') {
        scan_string();
        return(0);
    }
    if (c == 39) {
        scan_char();
        return(0);
    }
    if (c == '(') { TOK = 30; return(0); }
    if (c == ')') { TOK = 31; return(0); }
    if (c == '{') { TOK = 32; return(0); }
    if (c == '}') { TOK = 33; return(0); }
    if (c == '[') { TOK = 34; return(0); }
    if (c == ']') { TOK = 35; return(0); }
    if (c == ',') { TOK = 36; return(0); }
    if (c == ';') { TOK = 37; return(0); }
    if (c == ':') { TOK = 38; return(0); }
    if (c == '?') { TOK = 39; return(0); }
    if (c == '+') {
        if (peekc() == '+') { getc1(); TOK = 51; return(0); }
        if (peekc() == '=') {
            if (STRICT) fatal("C-style compound assignment is not strict B");
            getc1(); TOK = 71; return(0);
        }
        TOK = 40; return(0);
    }
    if (c == '-') {
        if (peekc() == '-') { getc1(); TOK = 52; return(0); }
        if (peekc() == '=') {
            if (STRICT) fatal("C-style compound assignment is not strict B");
            getc1(); TOK = 72; return(0);
        }
        TOK = 41; return(0);
    }
    if (c == 42) {
        if (peekc() == '=') {
            if (STRICT) fatal("C-style compound assignment is not strict B");
            getc1(); TOK = 73; return(0);
        }
        TOK = 42; return(0);
    }
    if (c == '/') {
        if (peekc() == '=') {
            if (STRICT) fatal("C-style compound assignment is not strict B");
            getc1(); TOK = 74; return(0);
        }
        TOK = 43; return(0);
    }
    if (c == '%') {
        if (peekc() == '=') {
            if (STRICT) fatal("C-style compound assignment is not strict B");
            getc1(); TOK = 75; return(0);
        }
        TOK = 44; return(0);
    }
    if (c == '&') {
        if (peekc() == '=') {
            if (STRICT) fatal("C-style compound assignment is not strict B");
            getc1(); TOK = 76; return(0);
        }
        TOK = 45; return(0);
    }
    if (c == '|') {
        if (peekc() == '|') {
            if (STRICT) fatal("logical OR is not strict B");
            getc1(); TOK = 50; return(0);
        }
        if (peekc() == '=') {
            if (STRICT) fatal("C-style compound assignment is not strict B");
            getc1(); TOK = 77; return(0);
        }
        TOK = 46; return(0);
    }
    if (c == '!') {
        if (peekc() == '=') { getc1(); TOK = 61; return(0); }
        TOK = 47; return(0);
    }
    if (c == '<') {
        if (peekc() == '<') {
            getc1();
            if (peekc() == '=') {
                if (STRICT) fatal("C-style compound assignment is not strict B");
                getc1(); TOK = 78; return(0);
            }
            TOK = 48; return(0);
        }
        if (peekc() == '=') { getc1(); TOK = 60; return(0); }
        TOK = 58; return(0);
    }
    if (c == '>') {
        if (peekc() == '>') {
            getc1();
            if (peekc() == '=') {
                if (STRICT) fatal("C-style compound assignment is not strict B");
                getc1(); TOK = 79; return(0);
            }
            TOK = 49; return(0);
        }
        if (peekc() == '=') { getc1(); TOK = 63; return(0); }
        TOK = 62; return(0);
    }
    if (c == '=') {
        c = peekc();
        if (c == '+') { getc1(); TOK = 71; return(0); }
        if (c == '-') { getc1(); TOK = 72; return(0); }
        if (c == 42) { getc1(); TOK = 73; return(0); }
        if (c == '/') { getc1(); TOK = 74; return(0); }
        if (c == '%') { getc1(); TOK = 75; return(0); }
        if (c == '&') { getc1(); TOK = 76; return(0); }
        if (c == '|') { getc1(); TOK = 77; return(0); }
        if (c == '<') {
            getc1();
            if (peekc() == '<') { getc1(); TOK = 78; return(0); }
            if (peekc() == '=') { getc1(); TOK = 83; return(0); }
            TOK = 82; return(0);
        }
        if (c == '>') {
            getc1();
            if (peekc() == '>') { getc1(); TOK = 79; return(0); }
            if (peekc() == '=') { getc1(); TOK = 85; return(0); }
            TOK = 84; return(0);
        }
        if (c == '=') {
            getc1();
            if (peekc() == '=') { getc1(); TOK = 80; return(0); }
            TOK = 59;
            return(0);
        }
        if (c == '!') { getc1(); TOK = 81; return(0); }
        TOK = 70; return(0);
    }
    fatal("bad character");
}

expect(t) {
    if (TOK != t) fatal("unexpected token");
    next();
}

prec(op) {
    if (op == 36) return(1);
    if ((op >= 70) & (op <= 85)) return(2);
    if (op == 50) return(3);
    if (op == 46) return(4);
    if (op == 45) return(5);
    if ((op == 59) | (op == 61)) return(6);
    if ((op == 58) | (op == 60) | (op == 62) | (op == 63)) return(7);
    if ((op == 40) | (op == 41) | (op == 48) | (op == 49)) return(8);
    if ((op == 42) | (op == 43) | (op == 44)) return(9);
    return(0);
}

right_assoc(op) {
    if ((op >= 70) & (op <= 85)) return(1);
    return(0);
}

c_op(op) {
    if (op == 40) return("+");
    if (op == 41) return("-");
    if (op == 42) return("**");
    if (op == 43) return("/");
    if (op == 44) return("%");
    if (op == 45) return("&");
    if (op == 46) return("|");
    if (op == 47) return("!");
    if (op == 50) return("||");
    if (op == 48) return("<<");
    if (op == 49) return(">>");
    if (op == 58) return("<");
    if (op == 60) return("<=");
    if (op == 62) return(">");
    if (op == 63) return(">=");
    if (op == 59) return("==");
    if (op == 61) return("!=");
    if (op == 70) return("=");
    if (op == 71) return("+=");
    if (op == 72) return("-=");
    if (op == 73) return("**=");
    if (op == 74) return("/=");
    if (op == 75) return("%=");
    if (op == 76) return("&=");
    if (op == 77) return("|=");
    if (op == 78) return("<<=");
    if (op == 79) return(">>=");
    return("?");
}

rel_assign_op(op) {
    if (op == 82) return("<");
    if (op == 83) return("<=");
    if (op == 84) return(">");
    if (op == 85) return(">=");
    if (op == 80) return("==");
    if (op == 81) return("!=");
    return(0);
}

c_escape_to(b, s) {
    auto i, c;
    i = 0;
    while (i < slen(s)) {
        c = char(s, i);
        if (c == 10) {
            buf_ch(b, 92); buf_ch(b, 'n');
        } else if (c == 9) {
            buf_ch(b, 92); buf_ch(b, 't');
        } else if (c == 13) {
            buf_ch(b, 92); buf_ch(b, 'r');
        } else if (c == '"') {
            buf_ch(b, 92); buf_ch(b, '"');
        } else if (c == 92) {
            buf_ch(b, 92); buf_ch(b, 92);
        } else if (c == 0) {
            buf_ch(b, 92); buf_ch(b, '0');
        } else {
            buf_ch(b, c);
        }
        i = i + 1;
    }
}

emit_c_quoted_eot(s) {
    emit("*"");
    c_escape_to(OUT, s);
    buf_ch(OUT, 92);
    buf_ch(OUT, '0');
    buf_ch(OUT, '0');
    buf_ch(OUT, '4');
    emit("*"");
}

call_name(name) {
    if (streq(name, "char")) return("b_char");
    if (streq(name, "lchar")) return("b_lchar");
    if (streq(name, "printf")) return("b_printf");
    if (streq(name, "printn")) return("b_printn");
    if (streq(name, "putchar")) return("b_putchar");
    if (streq(name, "getchar")) return("b_getchar");
    if (streq(name, "exit")) return("b_exit");
    if (streq(name, "free")) return("b_free");
    if (streq(name, "openr")) return("b_openr");
    if (streq(name, "openw")) return("b_openw");
    if (streq(name, "close")) return("b_close");
    if (streq(name, "read")) return("b_read");
    if (streq(name, "write")) return("b_write");
    if (streq(name, "creat")) return("b_creat");
    if (streq(name, "system")) return("b_system");
    if (streq(name, "unlink")) return("b_unlink");
    if (streq(name, "argc")) return("b_argc");
    if (streq(name, "argv")) return("b_argv");
    return(name);
}

wrap_malloc(name) {
    if (streq(name, "malloc")) return(1);
    if (streq(name, "calloc")) return(1);
    if (streq(name, "realloc")) return(1);
    if (streq(name, "newwin")) return(1);
    if (streq(name, "new_panel")) return(1);
    return(0);
}

wrap_arg_cptr(name, idx) {
    if (streq(name, "memset") & (idx == 0)) return(1);
    if (streq(name, "memcpy") & ((idx == 0) | (idx == 1))) return(1);
    if (streq(name, "memmove") & ((idx == 0) | (idx == 1))) return(1);
    if (streq(name, "realloc") & (idx == 0)) return(1);
    if (streq(name, "tcgetattr") & (idx == 1)) return(1);
    if (streq(name, "tcsetattr") & (idx == 2)) return(1);
    if (streq(name, "ioctl") & (idx == 2)) return(1);
    if (streq(name, "new_panel") & (idx == 0)) return(1);
    if (streq(name, "wattron") & (idx == 0)) return(1);
    if (streq(name, "wattroff") & (idx == 0)) return(1);
    if (streq(name, "box") & (idx == 0)) return(1);
    if (streq(name, "mvwaddstr") & (idx == 0)) return(1);
    if (streq(name, "werase") & (idx == 0)) return(1);
    if (streq(name, "wmove") & (idx == 0)) return(1);
    if (streq(name, "waddch") & (idx == 0)) return(1);
    if (streq(name, "show_panel") & (idx == 0)) return(1);
    if (streq(name, "hide_panel") & (idx == 0)) return(1);
    if (streq(name, "getmouse") & (idx == 0)) return(1);
    return(0);
}

wrap_arg_cstr(name, idx) {
    if (streq(name, "strlen") & (idx == 0)) return(1);
    if (streq(name, "atoi") & (idx == 0)) return(1);
    if (streq(name, "mvwaddstr") & (idx == 3)) return(1);
    return(0);
}

fmt_arg_is_s(fmt, want) {
    auto i, n, c;
    if (!fmt) return(0);
    i = 0;
    n = 0;
    while (i < slen(fmt)) {
        c = char(fmt, i);
        if (c == '%') {
            i = i + 1;
            c = char(fmt, i);
            if (c == '%') {
            } else {
                while ((c == '-') | (c == '+') | (c == ' ') | (c == '#') | (c == '0')) {
                    i = i + 1;
                    c = char(fmt, i);
                }
                while ((c >= '0') & (c <= '9')) {
                    i = i + 1;
                    c = char(fmt, i);
                }
                if (c == '.') {
                    i = i + 1;
                    c = char(fmt, i);
                    while ((c >= '0') & (c <= '9')) {
                        i = i + 1;
                        c = char(fmt, i);
                    }
                }
                if (n == want) return(c == 's');
                n = n + 1;
            }
        }
        i = i + 1;
    }
    return(0);
}

primary() {
    auto b, s, name, arg, narg;
    b = buf_new(128);
    if (TOK == 2) {
        buf_str(b, "((word)");
        buf_num(b, TNUM);
        buf_ch(b, ')');
        next();
        return(buf_take(b));
    }
    if (TOK == 4) {
        buf_str(b, "((word)");
        buf_num(b, TNUM);
        buf_ch(b, ')');
        next();
        return(buf_take(b));
    }
    if (TOK == 3) {
        buf_str(b, "__b_pack_cstr(*"");
        c_escape_to(b, TTEXT);
        buf_str(b, "*")");
        next();
        return(buf_take(b));
    }
    if (TOK == 1) {
        name = TTEXT;
        buf_str(b, name);
        next();
        return(buf_take(b));
    }
    if (TOK == 30) {
        next();
        s = expr(1);
        expect(31);
        buf_ch(b, '(');
        buf_str(b, s);
        buf_ch(b, ')');
        return(buf_take(b));
    }
    fatal("bad primary expression");
}

postfix() {
    auto lhs, b, first, name, cname, idx, arg, narg, fmt, wcstr;
    lhs = primary();
    while (1) {
        if (TOK == 30) {
            name = lhs;
            cname = call_name(name);
            b = buf_new(256);
            if (wrap_malloc(name)) buf_str(b, "B_PTR(");
            buf_str(b, cname);
            buf_ch(b, '(');
            next();
            first = 1;
            narg = 0;
            fmt = 0;
            while (TOK != 31) {
                if (!first) buf_str(b, ", ");
                if (streq(name, "fprintf") & (narg == 1) & (TOK == 3)) fmt = TTEXT;
                arg = expr(2);
                wcstr = wrap_arg_cstr(name, narg);
                if (streq(name, "fprintf") & (narg == 1)) wcstr = 1;
                if (streq(name, "fprintf") & (narg >= 2) & fmt_arg_is_s(fmt, narg - 2)) wcstr = 1;
                if (wrap_arg_cptr(name, narg)) buf_str(b, "B_CPTR(");
                if (wcstr) buf_str(b, "__b_cstr(");
                buf_str(b, arg);
                if (wrap_arg_cptr(name, narg) | wcstr) buf_ch(b, ')');
                first = 0;
                narg = narg + 1;
                if (TOK == 36) {
                    next();
                } else {
                    break;
                }
            }
            expect(31);
            buf_ch(b, ')');
            if (wrap_malloc(name)) buf_ch(b, ')');
            lhs = buf_take(b);
        } else if (TOK == 34) {
            next();
            idx = expr(1);
            expect(35);
            b = buf_new(256);
            buf_str(b, "B_INDEX(");
            buf_str(b, lhs);
            buf_str(b, ", ");
            buf_str(b, idx);
            buf_ch(b, ')');
            lhs = buf_take(b);
        } else if ((TOK == 51) | (TOK == 52)) {
            b = buf_new(128);
            buf_ch(b, '(');
            buf_str(b, lhs);
            if (TOK == 51) buf_str(b, "++");
            else buf_str(b, "--");
            buf_ch(b, ')');
            next();
            lhs = buf_take(b);
        } else {
            return(lhs);
        }
    }
}

unary() {
    auto op, e, b;
    if ((TOK == 41) | (TOK == 47) | (TOK == 42) | (TOK == 45) | (TOK == 51) | (TOK == 52)) {
        op = TOK;
        next();
        e = unary();
        b = buf_new(128);
        if (op == 42) {
            buf_str(b, "B_DEREF(");
            buf_str(b, e);
            buf_ch(b, ')');
        } else if (op == 45) {
            buf_str(b, "B_ADDR(");
            buf_str(b, e);
            buf_ch(b, ')');
        } else if (op == 51) {
            buf_str(b, "(++");
            buf_str(b, e);
            buf_ch(b, ')');
        } else if (op == 52) {
            buf_str(b, "(--");
            buf_str(b, e);
            buf_ch(b, ')');
        } else {
            buf_ch(b, '(');
            buf_str(b, c_op(op));
            buf_str(b, e);
            buf_ch(b, ')');
        }
        return(buf_take(b));
    }
    return(postfix());
}

expr(minp) {
    auto lhs, op, p, rhs, b, rel;
    lhs = unary();
    while (1) {
        if ((TOK == 39) & (minp <= 3)) {
            next();
            rhs = expr(1);
            expect(38);
            b = buf_new(256);
            buf_ch(b, '(');
            buf_str(b, lhs);
            buf_str(b, " ? ");
            buf_str(b, rhs);
            buf_str(b, " : ");
            buf_str(b, expr(1));
            buf_ch(b, ')');
            lhs = buf_take(b);
            continue;
        }
        op = TOK;
        p = prec(op);
        if (p < minp) return(lhs);
        next();
        if (right_assoc(op)) rhs = expr(p);
        else rhs = expr(p + 1);
        b = buf_new(256);
        rel = rel_assign_op(op);
        if (rel) {
            buf_ch(b, '(');
            buf_str(b, lhs);
            buf_str(b, " = (");
            buf_str(b, lhs);
            buf_ch(b, ' ');
            buf_str(b, rel);
            buf_ch(b, ' ');
            buf_str(b, rhs);
            buf_str(b, "))");
        } else {
            buf_ch(b, '(');
            buf_str(b, lhs);
            buf_ch(b, ' ');
            buf_str(b, c_op(op));
            buf_ch(b, ' ');
            buf_str(b, rhs);
            buf_ch(b, ')');
        }
        lhs = buf_take(b);
    }
}

emit(s) {
    buf_str(OUT, s);
}

emitln(s) {
    emit(s);
    buf_ch(OUT, 10);
}

auto_decl() {
    auto first, name, size;
    expect(10);
    first = 1;
    emit("word ");
    while (1) {
        if (TOK != 1) fatal("expected auto name");
        name = TTEXT;
        next();
        if (!first) emit(", ");
        if (TOK == 34) {
            next();
            size = expr(1);
            expect(35);
            emit("__");
            emit(name);
            emit("_store[");
            emit(size);
            emit("]; word ");
            emit(name);
            emit(" = B_PTR(__");
            emit(name);
            emit("_store)");
        } else if (TOK == 2) {
            emit("__");
            emit(name);
            emit("_store[");
            emit(itoa(TNUM));
            emit("]; word ");
            emit(name);
            emit(" = B_PTR(__");
            emit(name);
            emit("_store)");
            next();
        } else {
            emit(name);
            emit(" = 0");
        }
        first = 0;
        if (TOK == 36) {
            next();
        } else {
            break;
        }
    }
    expect(37);
    emitln(";");
}

extrn_stmt() {
    expect(11);
    while (TOK != 37) {
        if (TOK == 0) fatal("bad extrn");
        next();
    }
    next();
}

block() {
    expect(32);
    emitln("{");
    while (TOK != 33) stmt();
    expect(33);
    emitln("}");
}

stmt() {
    auto e, name, psave, lsave, csave;
    if (TOK == 32) {
        block();
        return(0);
    }
    if (TOK == 10) {
        auto_decl();
        return(0);
    }
    if (TOK == 11) {
        extrn_stmt();
        return(0);
    }
    if (TOK == 12) {
        next();
        expect(30);
        e = expr(1);
        expect(31);
        emit("if (");
        emit(e);
        emit(") ");
        stmt();
        if (TOK == 13) {
            next();
            emit("else ");
            stmt();
        }
        return(0);
    }
    if (TOK == 14) {
        next();
        expect(30);
        e = expr(1);
        expect(31);
        emit("while (");
        emit(e);
        emit(") ");
        stmt();
        return(0);
    }
    if (TOK == 15) {
        next();
        emit("return");
        if (TOK == 30) {
            next();
            e = expr(1);
            expect(31);
            emit(" (");
            emit(e);
            emit(")");
        } else if (TOK != 37) {
            e = expr(1);
            emit(" (");
            emit(e);
            emit(")");
        } else if (TOK == 37) {
            emit(" (0)");
        }
        expect(37);
        emitln(";");
        return(0);
    }
    if (TOK == 16) {
        next();
        if (TOK != 1) fatal("expected label");
        emit("goto ");
        emit(TTEXT);
        emitln(";");
        next();
        expect(37);
        return(0);
    }
    if (TOK == 17) {
        next();
        if (TOK == 30) {
            next();
            e = expr(1);
            expect(31);
        } else {
            e = expr(1);
        }
        emit("switch ((int)(");
        emit(e);
        emit(")) ");
        stmt();
        return(0);
    }
    if (TOK == 18) {
        next();
        e = expr(1);
        expect(38);
        emit("case (int)(");
        emit(e);
        emitln("):");
        return(0);
    }
    if (TOK == 19) {
        next();
        expect(38);
        emitln("default:");
        return(0);
    }
    if (TOK == 20) {
        next();
        expect(37);
        emitln("break;");
        return(0);
    }
    if (TOK == 21) {
        next();
        expect(37);
        emitln("continue;");
        return(0);
    }
    if (TOK == 37) {
        next();
        emitln(";");
        return(0);
    }
    if (TOK == 1) {
        name = TTEXT;
        psave = POS;
        lsave = LINE;
        csave = COL;
        next();
        if (TOK == 38) {
            next();
            emit(name);
            emitln(":");
            return(0);
        }
        POS = psave;
        LINE = lsave;
        COL = csave;
        TOK = 1;
        TTEXT = name;
    }
    e = expr(1);
    expect(37);
    emit(e);
    emitln(";");
}

add_fun(name, nargs) {
    FUNS[NFUNS * 2] = name;
    FUNS[NFUNS * 2 + 1] = nargs;
    NFUNS = NFUNS + 1;
}

has_global(name) {
    auto i;
    i = 0;
    while (i < NGLOBS) {
        if (streq(GLOBS[i], name)) return(1);
        i = i + 1;
    }
    return(0);
}

add_global(name) {
    if (has_global(name)) return(0);
    GLOBS[NGLOBS] = name;
    NGLOBS = NGLOBS + 1;
}

scan_functions() {
    auto name, n, depth;
    NFUNS = 0;
    NGLOBS = 0;
    MAIN_NARGS = 0;
    HAS_MAIN = 0;
    depth = 0;
    next();
    while (TOK != 0) {
        if ((TOK == 11) & (depth == 0)) {
            while ((TOK != 37) & (TOK != 0)) next();
            if (TOK == 37) next();
        } else if (TOK == 32) {
            depth = depth + 1;
            next();
        } else if (TOK == 33) {
            depth = depth - 1;
            next();
        } else if ((TOK == 1) & (depth == 0)) {
            name = TTEXT;
            next();
		if (TOK == 30) {
                n = 0;
                next();
                while (TOK != 31) {
                    if (TOK == 1) {
                        n = n + 1;
                        next();
                    }
                    if (TOK == 36) next();
                    else if (TOK != 31) next();
                }
                if (TOK == 31) next();
                if (streq(name, "main")) {
                    MAIN_NARGS = n;
                    HAS_MAIN = 1;
                }
                add_fun(name, n);
                if (TOK != 32) {
                    while ((TOK != 37) & (TOK != 0)) next();
                    if (TOK == 37) next();
                }
            } else {
                add_global(name);
            }
        } else {
            next();
        }
    }
    POS = 0; LINE = 1; COL = 1;
}

emit_prototypes() {
    auto i, j;
    i = 0;
    while (i < NFUNS) {
        emit("word ");
        if (streq(FUNS[i * 2], "main")) emit("__b_user_main");
        else emit(FUNS[i * 2]);
        emit("(");
        j = 0;
        while (j < FUNS[i * 2 + 1]) {
            if (j) emit(", ");
            emit("word");
            j = j + 1;
        }
        emitln(");");
        i = i + 1;
    }
    i = 0;
    while (i < NGLOBS) {
        emit("word ");
        emit(GLOBS[i]);
        emitln(";");
        i = i + 1;
    }
    emitln("");
}

global_or_func() {
    auto name, n, first, p, size, init, empty;
    if (TOK != 1) fatal("expected top-level name");
    name = TTEXT;
    next();
    if (TOK == 30) {
        next();
        emit("word ");
        if (streq(name, "main")) emit("__b_user_main");
        else emit(name);
        emit("(");
        first = 1;
        n = 0;
        while (TOK != 31) {
            if (TOK != 1) fatal("expected parameter");
            p = TTEXT;
            if (!first) emit(", ");
            emit("word ");
            emit(p);
            first = 0;
            n = n + 1;
            next();
            if (TOK == 36) next();
            else break;
        }
        expect(31);
        emit(") ");
        func_body();
        emitln("");
        return(0);
    }
    if (TOK == 34) {
        next();
        empty = 0;
        if (TOK == 35) {
            empty = 1;
            next();
        } else {
            size = expr(1);
            expect(35);
        }
        emit("static word __");
        emit(name);
        emit("_store");
        if (!empty) {
            emit("[");
            emit(size);
            emit("]");
        }
        if (TOK == 32) {
            next();
            if (empty) emit("[]");
            emit(" = {");
            first = 1;
            while (TOK != 33) {
                init = expr(2);
                if (!first) emit(", ");
                emit(init);
                first = 0;
                if (TOK == 36) next();
                else break;
            }
            expect(33);
            emitln("};");
        } else if (TOK != 37) {
            emit(" = {");
            first = 1;
            while (TOK != 37) {
                init = expr(2);
                if (!first) emit(", ");
                emit(init);
                first = 0;
                if (TOK == 36) next();
                else break;
            }
            emitln("};");
        } else {
            emitln(";");
        }
        emit("word ");
        emit(name);
        emit(" = B_PTR(__");
        emit(name);
        emitln("_store);");
        expect(37);
        return(0);
    }
    if (TOK == 3) {
        emit("static const unsigned char __");
        emit(name);
        emit("_str[] = ");
        emit_c_quoted_eot(TTEXT);
        emitln(";");
        emit("word ");
        emit(name);
        emit(" = B_PTR(__");
        emit(name);
        emitln("_str);");
        next();
        expect(37);
        return(0);
    }
    emit("word ");
    emit(name);
    if (TOK != 37) {
        init = expr(1);
        emit(" = ");
        emit(init);
    }
    expect(37);
    emitln(";");
}

parse_program() {
    next();
    while (TOK != 0) {
        if (TOK == 11) {
            extrn_stmt();
        } else if (TOK == 10) {
            fatal("top-level auto not supported");
        } else {
            global_or_func();
        }
    }
}

func_body() {
    if (TOK == 32) {
        expect(32);
        emitln("{");
        while (TOK != 33) stmt();
        emitln("return 0;");
        expect(33);
        emitln("}");
    } else {
        emitln("{");
        stmt();
        emitln("return 0;");
        emitln("}");
    }
}

emit_header() {
    emitln("#include <stdio.h>");
    emitln("#include <stdlib.h>");
    emitln("#include <stdint.h>");
    if (WANT_NCURSES) {
        emitln("#include <ncurses.h>");
        emitln("#include <panel.h>");
    }
    emitln("#define B_BYTEPTR 1");
    emitln("#define WORD_BITS 0");
    emitln("#include *"libb.h*"");
    emitln("");
}

emit_main_wrapper() {
    if (!HAS_MAIN) return(0);
    emitln("int main(int argc, char ****argv) {");
    emitln("    __b_setargs(argc, argv);");
    if (MAIN_NARGS == 0) {
        emitln("    return (int)__b_user_main();");
    } else if (MAIN_NARGS == 1) {
        emitln("    return (int)__b_user_main((word)argc);");
    } else {
        emitln("    word **__bbc_argvv = (word**)malloc(sizeof(word) ** (size_t)argc);");
        emitln("    for (int __i = 0; __i < argc; __i++) __bbc_argvv[__i] = b_argv((word)__i);");
        emitln("    return (int)__b_user_main((word)argc, B_PTR(__bbc_argvv));");
    }
    emitln("}");
}

compile_to_c(inpath) {
    extrn malloc;
    read_file(inpath);
    FUNS = malloc(2048 * &0[1]);
    GLOBS = malloc(2048 * &0[1]);
    scan_functions();
    OUT = buf_new(1048576);
    emit_header();
    emit_prototypes();
    parse_program();
    emit_main_wrapper();
    return(buf_take(OUT));
}

ends_b(s) {
    auto n;
    n = slen(s);
    if (n < 2) return(0);
    if (char(s, n - 2) != '.') return(0);
    if (char(s, n - 1) != 'b') return(0);
    return(1);
}

make_c_name(s, idx) {
    auto b;
    b = buf_new(128);
    if (ends_b(s)) {
        buf_str(b, s);
        buf_str(b, ".c");
    } else {
        buf_str(b, "/tmp/bbc_boot_");
        buf_num(b, idx);
        buf_str(b, ".c");
    }
    return(buf_take(b));
}

build_cmd(cfiles, nc, out, extras, nextra) {
    auto b, i;
    b = buf_new(4096);
    buf_str(b, "gcc -std=c99 -O2 -Wno-implicit-function-declaration -I/home/frank/bcc/lib -DB_BYTEPTR=1 -DWORD_BITS=0 -o ");
    buf_str(b, out);
    i = 0;
    while (i < nc) {
        buf_ch(b, ' ');
        buf_str(b, cfiles[i]);
        i = i + 1;
    }
    buf_str(b, " /home/frank/bcc/lib/libb.c -ldl -lm");
    i = 0;
    while (i < nextra) {
        buf_ch(b, ' ');
        buf_str(b, extras[i]);
        i = i + 1;
    }
    return(buf_take(b));
}

usage() {
    extrn printf;
    printf("usage: bbc [-S] [--emit-c] [--keep-c] [-v] input.b ... [-o out]*n");
}

main() {
    auto ac, i, emit_stdout, emit_c, keep_c, out, inputs, ninputs, cfiles, nc;
    auto a, csrc, cname, cmd, rc, extras, nextra;
    extrn argc, argv, malloc, system, unlink;
    ac = argc();
    emit_stdout = 0;
    emit_c = 0;
    keep_c = 0;
    VERBOSE = 0;
    STRICT = 0;
    WANT_NCURSES = 0;
    out = "a.out";
    inputs = malloc(256 * &0[1]);
    cfiles = malloc(256 * &0[1]);
    extras = malloc(256 * &0[1]);
    ninputs = 0;
    nextra = 0;
    i = 1;
    while (i < ac) {
        a = argv(i);
        if (streq(a, "-S")) {
            emit_stdout = 1;
        } else if (streq(a, "--emit-c")) {
            emit_c = 1;
            keep_c = 1;
        } else if (streq(a, "--keep-c")) {
            keep_c = 1;
        } else if (streq(a, "-v")) {
            VERBOSE = 1;
        } else if (streq(a, "--strict")) {
            STRICT = 1;
        } else if (streq(a, "--pedantic")) {
            STRICT = 1;
        } else if (streq(a, "-l")) {
            i = i + 1;
            if (i >= ac) fatal("missing -l value");
            if (streq(argv(i), "ncurses") | streq(argv(i), "panel")) WANT_NCURSES = 1;
            extras[nextra] = scat("-l", argv(i));
            nextra = nextra + 1;
        } else if (streq(a, "-X")) {
            i = i + 1;
            if (i >= ac) fatal("missing -X value");
            extras[nextra] = argv(i);
            nextra = nextra + 1;
        } else if (streq(a, "-o")) {
            i = i + 1;
            if (i >= ac) fatal("missing -o value");
            out = argv(i);
        } else if (streq(a, "--dump-tokens")) {
            fatal("--dump-tokens is not implemented");
        } else if (streq(a, "--dump-ast")) {
            fatal("--dump-ast is not implemented");
        } else {
            inputs[ninputs] = a;
            ninputs = ninputs + 1;
        }
        i = i + 1;
    }
    if (ninputs == 0) {
        usage();
        return(2);
    }
    nc = 0;
    i = 0;
    while (i < ninputs) {
        csrc = compile_to_c(inputs[i]);
        if (emit_stdout) {
            write_all(1, csrc, slen(csrc));
        } else {
            cname = make_c_name(inputs[i], i);
            save_file(cname, csrc, slen(csrc));
            cfiles[nc] = cname;
            nc = nc + 1;
        }
        i = i + 1;
    }
    if (emit_stdout) return(0);
    if (emit_c) return(0);
    cmd = build_cmd(cfiles, nc, out, extras, nextra);
    rc = system(cmd);
    if (!keep_c) {
        i = 0;
        while (i < nc) {
            unlink(cfiles[i]);
            i = i + 1;
        }
    }
    if (rc != 0) return(1);
    return(0);
}
