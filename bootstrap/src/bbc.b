/*
 * bbc.b - B-written bootstrap compiler for the host C99 BCC path.
 *
 * This compiler accepts the practical host BCC surface used by examples,
 * while --strict keeps Thompson/B72-style extension rejection available.
 */

SRC; SRCLEN; POS; LINE; COL; STRICT; WANT_NCURSES;
TOK; TNUM; TTEXT; TTEXTLEN;
HOIST; OUT; FUNS; NFUNS; MAIN_NARGS; HAS_MAIN; GLOBS; NGLOBS;
ALLFUNS; NALLFUNS; ALLGLOBS; NALLGLOBS;
EXTERNS[2048]; NEXTERNS; CURFUNC;
VERBOSE; LIBDIR; LOCALS; NLOCALS; LABELS; NLABELS; LABELPASS; PARAMCOUNT;

CWORDS[] "auto","break","case","char","const","continue","default",
    "do","double","else","enum","extern","float","for","goto","if",
    "inline","int","long","register","restrict","return","short","signed",
    "sizeof","static","struct","switch","typedef","union","unsigned",
    "void","volatile","while","_Alignas","_Alignof","_Atomic","_Bool",
    "_Complex","_Generic","_Imaginary","_Noreturn","_Static_assert",
    "_Thread_local",0;

c_reserved(name) {
    auto i;
    i = 0;
    while (CWORDS[i]) {
        if (streq(name,CWORDS[i])) return(1);
        i = i + 1;
    }
    return(0);
}

private_name(name) {
    auto i;
    i = 0;
    while (i < 6) {
        if (char(name,i) != char("__bbc_",i)) return(0);
        i = i + 1;
    }
    return(1);
}

fatal(msg) {
    auto number;
    extrn exit;
    /* Diagnostics must not follow openw's selected output file. */
    write_all(2, "bbc: ", 5);
    write_all(2, msg, slen(msg));
    write_all(2, " at line ", 9);
    number = itoa(LINE);
    write_all(2, number, slen(number));
    write_all(2, "*n", 1);
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
    if (n < 0) fatal("cannot read input");
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
    if (close(11) < 0) fatal("cannot close output");
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
    if ((c == '_') | (c == 8)) return(1);
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
    if (c == '(') return(123);
    if (c == ')') return(125);
    if (c == '0') return(0);
    if (c == 42) return(42);
    if (c == '"') return('"');
    if (c == 39) return(39);
    return(c);
}

is_star_escape(c) {
    if ((c == '(') | (c == ')') | (c == 39)) return(1);
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
    TTEXTLEN = b[1];
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
        if ((c == 42) & is_star_escape(peekc())) {
            if ((peekc() != 39) | (char(SRC, POS + 1) == 39)) c = read_escape();
        }
        v = (v << 8) | c;
        n = n + 1;
        if (STRICT & (n > 2)) fatal("long char constant is not strict B");
        if (n > 4) fatal("character constant too long");
    }
    if (n == 0) fatal("empty character constant");
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
    if (!STRICT & streq(s, "default")) return(19);
    if (!STRICT & streq(s, "break")) return(20);
    if (!STRICT & streq(s, "continue")) return(21);
    return(1);
}

encoded_name(s) {
    auto i,c,found,b,n;
    n=slen(s);found=0;i=0;
    while(i<n){if(char(s,i)==8)found=1;i++;}
    if(!found)return(0);
    b=buf_new(64);buf_str(b,"__bbc_bs_");i=0;
    while(i<n){
        c=char(s,i);
        buf_ch(b,char("0123456789abcdef",(c>>4)&15));
        buf_ch(b,char("0123456789abcdef",c&15));
        i++;
    }
    return(buf_take(b));
}

next() {
    auto c, start, base, v, s, d, encoded;
    skip_ws();
    if ((POS < SRCLEN) & (peekc() == 0)) fatal("NUL byte outside a literal");
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
        if (STRICT & (POS - start > 8)) fatal("B72 names cannot exceed 8 characters");
        s = new_text(start, POS - start);
        TTEXT = s;
        TOK = keyword(s);
        if (TOK == 1) {
            encoded=encoded_name(s);
            if(encoded)TTEXT=encoded;
            else if (private_name(s)) TTEXT = scat("__bbc_user_",s);
            else if (c_reserved(s)) TTEXT = scat("__bbc_id_",s);
        }
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
        if (c == '!') {
            if (POS+1 < SRCLEN) if (char(SRC,POS+1) == '=') {
                getc1(); getc1(); TOK = 81; return(0);
            }
        }
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
    if ((op == 48) | (op == 49)) return(8);
    if ((op == 40) | (op == 41)) return(9);
    if ((op == 42) | (op == 43) | (op == 44)) return(10);
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

word_op(op) {
    if (op == 40) return("WADD");
    if (op == 41) return("WSUB");
    if (op == 42) return("WMUL");
    if (op == 43) return("WDIV");
    if (op == 44) return("WMOD");
    if (op == 48) return("WSHL");
    if (op == 49) return("WSHR");
    return(0);
}

update_op(op) {
    if (op == 71) return("b_add_assign");
    if (op == 72) return("b_sub_assign");
    if (op == 73) return("b_mul_assign");
    if (op == 74) return("b_div_assign");
    if (op == 75) return("b_mod_assign");
    if (op == 76) return("b_and_assign");
    if (op == 77) return("b_or_assign");
    if (op == 78) return("b_lsh_assign");
    if (op == 79) return("b_rsh_assign");
    return(0);
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

c_escape_n(b, s, n) {
    auto i, c;
    i = 0;
    while (i < n) {
        c = char(s, i);
        buf_ch(b, 92);
        buf_ch(b, '0' + ((c >> 6) & 7));
        buf_ch(b, '0' + ((c >> 3) & 7));
        buf_ch(b, '0' + (c & 7));
        i = i + 1;
    }
}

c_escape_to(b, s) {
    c_escape_n(b, s, slen(s));
}

emit_c_quoted_eot(s) {
    emit("*"");
    c_escape_n(OUT, s, TTEXTLEN);
    buf_ch(OUT, 92);
    buf_ch(OUT, '0');
    buf_ch(OUT, '0');
    buf_ch(OUT, '4');
    emit("*"");
}

has_extern(name) {
    auto i;
    i = 0;
    while (i < NEXTERNS) {
        if (streq(EXTERNS[i], name)) return(1);
        i = i + 1;
    }
    return(0);
}

add_extern(name) {
    if (has_extern(name)) return(0);
    if (has_local(name) | label_id(name)) fatal("external declaration conflicts with local name");
    if (NEXTERNS >= 2048) fatal("too many external names");
    EXTERNS[NEXTERNS] = name;
    NEXTERNS = NEXTERNS + 1;
}

label_id(name) {
    auto i;
    i = 0;
    while (i < NLABELS) {
        if (streq(LABELS[i], name)) return(i + 1);
        i = i + 1;
    }
    return(0);
}

add_label(name) {
    if (label_id(name)) fatal("duplicate label");
    if (has_local(name)) fatal("label conflicts with local variable");
    if (STRICT & has_extern(name)) fatal("label conflicts with external name");
    if (NLABELS >= 2048) fatal("too many labels");
    LABELS[NLABELS] = name;
    NLABELS = NLABELS + 1;
}

has_local(name) {
    auto i;
    i = 0;
    while (i < NLOCALS) {
        if (streq(LOCALS[i], name)) return(1);
        i = i + 1;
    }
    return(0);
}

add_local(name) {
    if (STRICT & has_local(name)) fatal("duplicate local name");
    if (STRICT & has_extern(name)) fatal("local variable conflicts with external name");
    if (label_id(name)) fatal("local variable conflicts with label");
    if (NLOCALS >= 2048) fatal("too many local names");
    LOCALS[NLOCALS] = name;
    NLOCALS = NLOCALS + 1;
}

has_function(name) {
    auto i;
    i = 0;
    while (i < NFUNS) {
        if (streq(FUNS[i * 2], name)) return(1);
        i = i + 1;
    }
    return(0);
}

c_name(name) {
    auto i;
    if (!is_alpha(char(name, 0))) return(0);
    i = 1;
    while (i < slen(name)) {
        if (!is_alnum(char(name, i))) return(0);
        i = i + 1;
    }
    return(1);
}

storage_name(name) {
    return(scat("__bbc_local_",name));
}

local_name(name) {
    auto i;
    i=NLOCALS-1;
    while(i>=0) {
        if(streq(LOCALS[i],name)) {
            if(i<PARAMCOUNT)
                return(scat(scat("__bbc_parameters[",itoa(i)),"]"));
            return(storage_name(name));
        }
        i = i - 1;
    }
    return(storage_name(name));
}

global_name(name) {
    return(scat("__bbc_global_",name));
}

function_name(name) {
    if (streq(name, "main")) return("__b_user_main");
    return(scat("__bbc_function_",name));
}

binding_name(name) {
    if(streq(name,"__bbc_id_char"))return("char");
    return(name);
}

call_name(name) {
    if (has_local(name)) return(name);
    if (streq(name, "main")) return("__b_user_main");
    if (has_function(name)) return(function_name(name));
    if (streq(name, "char") | streq(name, "__bbc_id_char")) return("b_char");
    if (streq(name, "lchar")) return("b_lchar");
    if (streq(name, "getchar")) return("b_getchar");
    if (streq(name, "getchr")) return("b_getchr");
    if (streq(name, "putchr")) return("b_putchr");
    if (streq(name, "getstr")) return("b_getstr");
    if (streq(name, "putstr")) return("b_putstr");
    if (streq(name, "flush")) return("b_flush");
    if (streq(name, "reread")) return("b_reread");
    if (streq(name, "printf")) return("b_printf");
    if (streq(name, "printn")) return("b_printn");
    if (streq(name, "putnum")) return("b_putnum");
    if (streq(name, "print")) return("b_print");
    if (streq(name, "putchar")) return("b_putchar");
    if (streq(name, "exit")) return("b_exit");
    if (streq(name, "abort")) return("b_abort");
    if (streq(name, "free")) return("b_free");
    if (streq(name, "alloc")) return("b_alloc");
    if (streq(name, "open")) return("b_open");
    if (streq(name, "close")) return("b_close");
    if (streq(name, "read")) return("b_read");
    if (streq(name, "write")) return("b_write");
    if (streq(name, "creat")) return("b_creat");
    if (streq(name, "seek")) return("b_seek");
    if (streq(name, "openr")) return("b_openr");
    if (streq(name, "openw")) return("b_openw");
    if (streq(name, "fork")) return("b_fork");
    if (streq(name, "wait")) return("b_wait");
    if (streq(name, "execl")) return("b_execl");
    if (streq(name, "execv")) return("b_execv");
    if (streq(name, "chdir")) return("b_chdir");
    if (streq(name, "chmod")) return("b_chmod");
    if (streq(name, "chown")) return("b_chown");
    if (streq(name, "link")) return("b_link");
    if (streq(name, "unlink")) return("b_unlink");
    if (streq(name, "stat")) return("b_stat");
    if (streq(name, "fstat")) return("b_fstat");
    if (streq(name, "time")) return("b_time");
    if (streq(name, "ctime")) return("b_ctime");
    if (streq(name, "getuid")) return("b_getuid");
    if (streq(name, "setuid")) return("b_setuid");
    if (streq(name, "makdir")) return("b_makdir");
    if (streq(name, "mkdir")) return("b_mkdir");
    if (streq(name, "intr")) return("b_intr");
    if (streq(name, "gtty")) return("b_gtty");
    if (streq(name, "stty")) return("b_stty");
    if (streq(name, "system")) return("b_system");
    if (streq(name, "usleep")) return("b_usleep");
    if (streq(name, "callf")) return("b_callf_dispatch");
    if (streq(name, "argc")) return("b_argc");
    if (streq(name, "argv")) return("b_argv");
    return(name);
}

wrap_malloc(name) {
    if (has_function(name) | has_global(name) | has_local(name)) return(0);
    if (streq(name, "malloc")) return(1);
    if (streq(name, "calloc")) return(1);
    if (streq(name, "realloc")) return(1);
    if (streq(name, "newwin")) return(1);
    if (streq(name, "new_panel")) return(1);
    return(0);
}

wrap_arg_cptr(name, idx) {
    if (has_function(name) | has_global(name) | has_local(name)) return(0);
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
    if (has_function(name) | has_global(name) | has_local(name)) return(0);
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
    auto b, s, name, arg, narg, i;
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
        buf_str(b, "({static union {word align; unsigned char bytes[((");
        buf_num(b, TTEXTLEN + 1);
        buf_str(b, "+sizeof(word)-1)/sizeof(word))**sizeof(word)];} __s={.bytes={");
        i = 0;
        while (i < TTEXTLEN) {
            buf_num(b, char(TTEXT, i));
            buf_ch(b, ',');
            i = i + 1;
        }
        buf_str(b, "4}}; B_PTR_N(__s.bytes,sizeof(__s.bytes));})");
        next();
        return(buf_take(b));
    }
    if (TOK == 1) {
        name = TTEXT;
        next();
        if (STRICT & !LABELPASS & (CURFUNC != 0)) {
            if ((TOK == 30) & !has_local(name) & !label_id(name)) add_extern(name);
            if (!has_local(name) & !label_id(name) & !has_extern(name))
                if (!streq(name, CURFUNC)) fatal("undefined internal name");
        }
        if (label_id(name)) {
            buf_str(b, "__bbc_label_value_");
            buf_num(b, label_id(name));
        } else if (has_global(name) & !has_local(name)) {
            buf_str(b, global_name(name)); buf_str(b, "[0]");
        } else if ((TOK != 30) & streq(name, "argv") & !has_local(name) & !has_global(name) & !has_function(name)) {
            buf_str(b, "b_argv_vector");
        } else if ((TOK != 30) & !has_local(name) & has_function(name)) {
            buf_str(b, global_name(name)); buf_str(b, "[0]");
        } else if ((TOK != 30) & !has_local(name) & !has_global(name) & !streq(call_name(name), name)) {
            buf_str(b, "(**__bcc_binding_cell(*"");c_escape_to(b,binding_name(name));
            buf_str(b, "*"))");
        } else if (has_local(name)) {
            buf_ch(b, '('); buf_str(b, local_name(name)); buf_ch(b, ')');
        } else buf_str(b, name);
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

source_call(target, arguments, count) {
    auto b,i;
    b=buf_new(256);
    buf_str(b,"({word __callee=(");buf_str(b,target);
    buf_str(b,");word __args[");
    if(count)buf_num(b,count);else buf_ch(b,'1');
    buf_str(b,"]={");
    if(count)buf_str(b,arguments);else buf_ch(b,'0');
    buf_str(b,"}; word __builtin_result; __bcc_try_builtin(__callee,");
    buf_num(b,count);buf_str(b,",__args,&__builtin_result)?__builtin_result:__bcc_is_source_function(__callee)?__bcc_invoke_source(__callee,");
    buf_num(b,count);buf_str(b,",__args):((word(**)())B_FUNCTION_CPTR(__callee))(");
    i=0;
    while(i<count){
        if(i)buf_ch(b,',');
        buf_str(b,"__args[");buf_num(b,i);buf_ch(b,']');i++;
    }
    buf_str(b,");})");
    return(buf_take(b));
}

library_call(name, arguments, count) {
    auto b;
    b=buf_new(128);
    buf_str(b,"**__bcc_binding_cell(*"");
    c_escape_to(b,binding_name(name));buf_str(b,"*" )");
    return(source_call(buf_take(b),arguments,count));
}

postfix() {
    auto lhs, b, first, name, cname, idx, arg, narg, fmt, wcstr, target, raw, library;
    lhs = primary();
    while (1) {
        if (TOK == 30) {
            name = lhs;
            cname = call_name(name);
            if(has_function(name) | has_local(name) | has_global(name) | !c_name(name)) {
                if(has_function(name))target=scat(global_name(name),"[0]");else target=name;
                b=buf_new(256);narg=0;next();
                while(TOK!=31){
                    if(narg)buf_ch(b,',');
                    buf_str(b,expr(2));narg++;
                    if(TOK!=36)break;
                    next();
                }
                expect(31);
                lhs=source_call(target,buf_take(b),narg);
                continue;
            }
            library=0;
            if(!streq(cname,name)) if(slen(cname)>2)
                if((char(cname,0)=='b') & (char(cname,1)=='_')) library=1;
            raw=0;if(library)raw=buf_new(256);
            b = buf_new(256);
            if (wrap_malloc(name)) buf_str(b, "B_PTR(");
            if (has_function(name)) {
                buf_str(b, "((word(**)())B_FUNCTION_CPTR(");
                buf_str(b, global_name(name)); buf_str(b, "[0]))");
            } else if (has_local(name) | has_global(name) | !c_name(name)) {
                buf_str(b, "((word(**)())B_FUNCTION_CPTR(");
                buf_str(b, name);
                buf_str(b, "))");
            } else buf_str(b, cname);
            buf_ch(b, '(');
            next();
            first = 1;
            narg = 0;
            fmt = 0;
            while (TOK != 31) {
                if (!first) buf_str(b, ", ");
                if (!has_function(name) & streq(name, "fprintf") & (narg == 1) & (TOK == 3)) fmt = TTEXT;
                arg = expr(2);
                if(raw){if(narg)buf_ch(raw,',');buf_str(raw,arg);}
                wcstr = wrap_arg_cstr(name, narg);
                if (!has_function(name) & streq(name, "fprintf") & (narg == 1)) wcstr = 1;
                if (!has_function(name) & streq(name, "fprintf") & (narg >= 2) & fmt_arg_is_s(fmt, narg - 2)) wcstr = 1;
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
            if ((narg == 0) & streq(cname, "b_exit")) buf_str(b, "0");
            buf_ch(b, ')');
            if (wrap_malloc(name)) buf_ch(b, ')');
            lhs = buf_take(b);
            if(library)lhs=library_call(name,buf_take(raw),narg);
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
            if (TOK == 51) buf_str(b, "b_postinc(&(");
            else buf_str(b, "b_postdec(&(");
            buf_str(b, lhs);
            buf_str(b, "))");
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
            buf_str(b, "b_preinc(&(");
            buf_str(b, e);
            buf_str(b, "))");
        } else if (op == 52) {
            buf_str(b, "b_predec(&(");
            buf_str(b, e);
            buf_str(b, "))");
        } else if (op == 41) {
            buf_str(b, "WNEG(");
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
        if ((op == 45) | (op == 46)) {
            buf_str(b, "({word __left=(");
            buf_str(b, lhs);
            buf_str(b, "); word __right=(");
            buf_str(b, rhs);
            buf_str(b, "); __left ");
            buf_str(b, c_op(op));
            buf_str(b, " __right;})");
        } else if (word_op(op) | update_op(op)) {
            if (update_op(op)) {
                buf_str(b, update_op(op)); buf_str(b, "(&(");
                buf_str(b, lhs); buf_str(b, "), ");
            } else {
                buf_str(b, word_op(op)); buf_ch(b, '(');
                buf_str(b, lhs); buf_str(b, ", ");
            }
            buf_str(b, rhs); buf_ch(b, ')');
        } else if (rel) {
            buf_str(b, "({word **__dest=&(");
            buf_str(b, lhs);
            buf_str(b, "); word __rhs=(");
            buf_str(b, rhs);
            buf_str(b, "); **__dest=(**__dest ");
            buf_str(b, rel);
            buf_str(b, " __rhs);})");
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
    auto name, size, saved;
    expect(10);
    while (1) {
        if (TOK != 1) fatal("expected auto name");
        name = TTEXT;
        add_local(name);
        name = storage_name(name);
        next(); size = 0;
        if (TOK == 34) {
            if (STRICT) fatal("bracketed auto vector is not strict B");
            next(); size = expr(1); expect(35);
        } else if ((TOK == 2) | (TOK == 4)) {
            size = itoa(TNUM); next();
        }
        saved = OUT;
        if (STRICT & LABELPASS & (HOIST != 0)) OUT = HOIST;
        if (!STRICT | (LABELPASS & (HOIST != 0))) {
            if (size) {
                emit("word __"); emit(name); emit("_store[");
                emit(size); emitln("];");
            }
            emit("word "); emit(name); emitln(" = 0;");
        }
        OUT = saved;
        if (!STRICT | !LABELPASS) {
            if (size) {
                emit(name); emit(" = B_PTR(__"); emit(name); emitln("_store);");
            } else emitln(";");
        }
        if (TOK != 36) break;
        next();
    }
    expect(37);
}

extrn_stmt() {
    expect(11);
    while (1) {
        if (TOK != 1) fatal("expected extrn name");
        if (STRICT & (CURFUNC != 0)) add_extern(TTEXT);
        next();
        if (TOK != 36) break;
        next();
    }
    expect(37);
}

block_item() {
    if (!STRICT & (TOK == 10)) auto_decl();
    else if (!STRICT & (TOK == 11)) extrn_stmt();
    else stmt();
}

block() {
    auto scope;
    scope=NLOCALS;
    expect(32);
    emitln("{");
    while (TOK != 33) block_item();
    expect(33);
    emitln("}");
    if(!STRICT) NLOCALS=scope;
}

stmt() {
    auto e, name, psave, lsave, csave, i, scope;
    if (TOK == 32) {
        block();
        return(0);
    }
    if ((TOK == 10) | (TOK == 11)) {
        scope=NLOCALS;
        emitln("{");
        while ((TOK == 10) | (TOK == 11)) {
            if (TOK == 10) auto_decl(); else extrn_stmt();
        }
        stmt();
        emitln("}");
        if(!STRICT) NLOCALS=scope;
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
            if (STRICT) fatal("return value requires parentheses");
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
        e = expr(1);
        expect(37);
        emit("switch (");
        emit(e);
        emitln(") {");
        i = 0;
        while (i < NLABELS) {
            emit("case "); emit(itoa(i + 1));
            emit(": goto __bbc_label_"); emit(itoa(i + 1)); emitln(";");
            i = i + 1;
        }
        emitln("default: abort();");
        emitln("}");
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
            if (LABELPASS) add_label(name);
            emit("__bbc_label_");
            emit(itoa(label_id(name)));
            emitln(":;");
            stmt();
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
    if (has_function(name)) fatal("duplicate function");
    if (NFUNS >= 1024) fatal("too many functions");
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
    if (has_global(name)) fatal("duplicate global");
    if (NGLOBS >= 2048) fatal("too many globals");
    GLOBS[NGLOBS] = name;
    NGLOBS = NGLOBS + 1;
}

scan_functions() {
    auto name, n;
    extrn free;
    NFUNS = 0; NGLOBS = 0; MAIN_NARGS = 0; HAS_MAIN = 0;
    NLOCALS = 0; NLABELS = 0; LABELPASS = 1; PARAMCOUNT = 0;
    NEXTERNS = 0; CURFUNC = 0;
    OUT = buf_new(1024);
    next();
    while (TOK != 0) {
        if (TOK == 11) { extrn_stmt(); }
        else if (TOK == 10) {
            fatal("top-level auto not supported");
        } else {
            if(TOK!=1) fatal("expected definition");
            name = TTEXT; next();
            if (TOK == 30) {
                NLOCALS = 0; NLABELS = 0; NEXTERNS = 0; CURFUNC = name;
                n = 0; next();
                while (TOK != 31) {
                    if(TOK!=1) fatal("expected parameter");
                    add_local(TTEXT); n = n + 1; next();
                    if (TOK != 36) break;
                    next();
                    if (TOK == 31) fatal("expected parameter");
                }
                expect(31);
                add_fun(name, n);
                if(streq(name,"main")) { MAIN_NARGS=n; HAS_MAIN=1; }
                stmt();
                NLOCALS = 0; NLABELS = 0; NEXTERNS = 0; CURFUNC = 0;
            } else {
                add_global(name);
                while ((TOK != 37)&(TOK != 0)) next();
                expect(37);
            }
        }
    }
    LABELPASS = 0;
    POS = 0; LINE = 1; COL = 1;
    free(OUT[0]);
    free(OUT);
    OUT = 0;
    return(0);
}

emit_prototypes() {
    auto i;
    i = 0;
    while (i < NFUNS) {
        emit("word ");
        emit(function_name(FUNS[i * 2]));
        emitln("(void);");
        emit("extern word "); emit(global_name(FUNS[i * 2])); emitln("[];");
        i = i + 1;
    }
    i = 0;
    while (i < NGLOBS) {
        emit("extern word ");
        emit(global_name(GLOBS[i]));
        emitln("[];");
        i = i + 1;
    }
    emitln("");
}

/* A bare external initializer names a cell's address, not its value. */
global_ival() {
    auto name;
    if (TOK != 1) return(expr(2));
    name = TTEXT;
    next();
    if (streq(name, "argv") & !has_global(name) & !has_function(name))
        name = "b_argv_vector";
    else if (has_global(name) | has_function(name)) name = scat(global_name(name), "[0]");
    else if(!streq(call_name(name),name)) {
        auto b;
        b=buf_new(128);buf_str(b,"B_ADDR(**__bcc_binding_cell(*"");
        c_escape_to(b,binding_name(name));buf_str(b,"*"))");
        return(buf_take(b));
    } else name = call_name(name);
    return(scat(scat("B_ADDR(", name), ")"));
}

emit_global_storage(name, size, values, count, vector) {
    if (vector) {
        emit("typedef char __bbc_extent_"); emit(name);
        emit("[(("); emit(size); emitln(") >= 0) ? 1 : -1];");
        emit("static word __"); emit(name); emit("_store[("); emit(size);
        emit(") > "); if (count) emit(itoa(count)); else emit("1");
        emit(" ? ("); emit(size); emit(") : ");
        if (count) emit(itoa(count)); else emit("1");
        emitln("];");
    }
    emit("word "); emit(global_name(name)); emit("[");
    if (vector | !count) emit("1"); else emit(itoa(count));
    emitln("];");
    emit("static struct __bcc_library_binding __bbc_data_");emit(name);emit("={*"");
    c_escape_to(OUT,binding_name(name));emit("*",");emit(global_name(name));emitln(",0,0};");
    emit("static void __attribute__((constructor(101))) __bbc_bind_");emit(name);
    emit("(void){__bcc_register_binding(&__bbc_data_");emit(name);emitln(");}");
    if (!vector & !count) return(0);
    emit("static void __attribute__((constructor(102))) __bbc_init_");
    emit(name); emitln("(void) {");
    if (vector) {
        emit(global_name(name)); emit("[0] = B_PTR(__"); emit(name); emitln("_store);");
    }
    if (count) {
        emit("word __bbc_values[] = {"); emit(values); emitln("};");
        emit("for (int __i=0; __i<"); emit(itoa(count)); emit("; __i++) ");
        if (vector) { emit("__"); emit(name); emit("_store"); }
        else emit(global_name(name));
        emitln("[__i] = __bbc_values[__i];");
    }
    emitln("}");
}

/* Collect the project's definitions before lowering its individual files. */
scan_project(inputs, count) {
    auto i, j, k;
    extrn malloc;
    ALLFUNS = malloc(2048 * &0[1]);
    ALLGLOBS = malloc(2048 * &0[1]);
    NALLFUNS = 0;
    NALLGLOBS = 0;
    i = 0;
    while (i < count) {
        read_file(inputs[i]);
        FUNS = malloc(2048 * &0[1]); GLOBS = malloc(2048 * &0[1]);
        LOCALS = malloc(2048 * &0[1]); LABELS = malloc(2048 * &0[1]);
        scan_functions();
        j = 0;
        while (j < NFUNS) {
            k = 0;
            while (k < NALLFUNS) {
                if (streq(ALLFUNS[2*k],FUNS[2*j])) fatal("duplicate external function");
                k = k + 1;
            }
            if (NALLFUNS>=1024) fatal("too many functions");
            ALLFUNS[2 * NALLFUNS] = FUNS[2 * j];
            ALLFUNS[2 * NALLFUNS + 1] = FUNS[2 * j + 1];
            NALLFUNS = NALLFUNS + 1; j = j + 1;
        }
        j = 0;
        while (j < NGLOBS) {
            k = 0;
            while (k < NALLGLOBS) {
                if(streq(ALLGLOBS[k],GLOBS[j])) fatal("duplicate external variable");
                k = k + 1;
            }
            if(NALLGLOBS>=2048) fatal("too many globals");
            ALLGLOBS[NALLGLOBS] = GLOBS[j];
            NALLGLOBS = NALLGLOBS + 1; j = j + 1;
        }
        i = i + 1;
    }
    i = 0;
    while (i < NALLFUNS) {
        j = 0;
        while (j < NALLGLOBS) {
            if(streq(ALLFUNS[2*i],ALLGLOBS[j])) fatal("conflicting external definition");
            j = j + 1;
        }
        i = i + 1;
    }
}

merge_project() {
    auto i;
    i = 0;
    while (i < NALLFUNS) {
        if (!has_function(ALLFUNS[2 * i])) add_fun(ALLFUNS[2 * i], ALLFUNS[2 * i + 1]);
        i = i + 1;
    }
    i = 0;
    while (i < NALLGLOBS) {
        if (!has_global(ALLGLOBS[i])) add_global(ALLGLOBS[i]);
        i = i + 1;
    }
}

global_or_func() {
    auto name, n, first, p, size, init, braced;
    NEXTERNS = 0; CURFUNC = 0;
    NLOCALS = 0;
    NLABELS = 0;
    PARAMCOUNT = 0;
    if (TOK != 1) fatal("expected top-level name");
    name = TTEXT;
    next();
    if (TOK == 30) {
        CURFUNC = name;
        NLOCALS = 0;
        NLABELS = 0;
        next();
        emit("word "); emit(global_name(name));
        emit("[1] = {B_FUNCTION("); emit(function_name(name)); emitln(")};");
        emit("static struct __bcc_source_function __bbc_node_");emit(name);
        emit("={(void**)");emit(function_name(name));emitln(",0,0};");
        emit("static struct __bcc_library_binding __bbc_binding_");emit(name);emit("={*"");
        c_escape_to(OUT,binding_name(name));emit("*",");emit(global_name(name));emitln(",0,0};");
        emit("static void __attribute__((constructor(101))) __bbc_register_");emit(name);
        emit("(void){__bcc_register_function(&__bbc_node_");emit(name);emit(");");
        emit("__bcc_register_binding(&__bbc_binding_");emit(name);emitln(");}");
        emit("word ");
        emit(function_name(name));
        emit("(");
        first = 1;
        n = 0;
        while (TOK != 31) {
            if (TOK != 1) fatal("expected parameter");
            p = TTEXT;
            add_local(p);
            first = 0;
            n = n + 1;
            next();
            if (TOK == 36) {
                next();
                if (TOK == 31) fatal("expected parameter");
            } else break;
        }
        expect(31);
        emit("void) ");
        func_body();
        emitln("");
        return(0);
    }
    size="0"; braced=0;
    if (TOK == 34) {
        braced = 1; next();
        if (TOK != 35) {
            if (TOK == 1) fatal("vector size must be constant");
            size = expr(1);
        }
        expect(35);
    }
    init = buf_new(128); n = 0;
    first = TOK == 32;
    if (first) next();
    while (TOK != 37) {
        if (first & (TOK == 33)) break;
        p = global_ival();
        if(n) buf_str(init,", ");
        buf_str(init, p); n = n + 1;
        if (TOK != 36) break;
        next();
    }
    if (first) expect(33);
    emit_global_storage(name, size, buf_take(init), n, braced);
    expect(37);
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

/* First collect labels using the same statement parser, then emit with
 * all forward references known. Token state is restored exactly. */
func_body() {
    auto p, l, c, t, text, num, len, saved, locals;
    extrn free;
    p = POS; l = LINE; c = COL;
    t = TOK; text = TTEXT; num = TNUM; len = TTEXTLEN;
    locals = NLOCALS;
    PARAMCOUNT = locals;
    saved = OUT;
    OUT = buf_new(1024);
    NLABELS = 0;
    NEXTERNS = 0;
    LABELPASS = 1;
    HOIST = buf_new(1024);
    emit_body();
    free(OUT[0]); free(OUT);
    OUT = saved;
    POS = p; LINE = l; COL = c;
    TOK = t; TTEXT = text; TNUM = num; TTEXTLEN = len;
    NLOCALS = locals;
    NEXTERNS = 0;
    LABELPASS = 0;
    emit_body();
    free(HOIST[0]); free(HOIST); HOIST = 0;
}

emit_body() {
    auto braced, i;
    braced = TOK == 32;
    if (braced) expect(32);
    emitln("{");
    if (!LABELPASS & (PARAMCOUNT > 0)) {
        emitln("size_t __count=__bcc_current_call?__bcc_current_call->count:0;");
        emit("if(__count<");emit(itoa(PARAMCOUNT));emit(")__count=");emit(itoa(PARAMCOUNT));emitln(";");
        emitln("word __bbc_parameters[__count];");
        emitln("for(size_t __i=0;__i<__count;__i++) __bbc_parameters[__i]=__bcc_current_call && __i<__bcc_current_call->count?__bcc_current_call->arguments[__i]:0;");
    }
    if (STRICT & !LABELPASS & (HOIST != 0)) emit(buf_take(HOIST));
    if (!LABELPASS) {
        i=1;
        while (i<=NLABELS) {
            emit("static word __bbc_label_value_"); emit(itoa(i));
            emit(" = "); emit(itoa(i)); emitln(";");
            i=+1;
        }
    }
    if (braced) {
        while (TOK != 33) block_item();
        expect(33);
    } else stmt();
    emitln("return 0;");
    emitln("}");
}

emit_header() {
    emitln("#include <stdio.h>");
    emitln("#include <stdlib.h>");
    emitln("#include <stdint.h>");
    if (WANT_NCURSES) {
        emitln("#include <ncurses.h>");
        emitln("#include <panel.h>");
    }
    if (STRICT) emitln("#define __bcc_strict_runtime 1");
    else emitln("#define __bcc_strict_runtime 0");
    if (STRICT) emitln("#define B_BYTEPTR 0");
    else emitln("#define B_BYTEPTR 1");
    emitln("#define WORD_BITS 0");
    emitln("#include *"libb.h*"");
    emitln("");
}

emit_main_wrapper() {
    if (!HAS_MAIN) return(0);
    emitln("int main(int argc, char ****argv) {");
    emitln("    __b_setargs(argc, argv);");
    emitln("    __b_init();");
    emit("    return (int)__bcc_call");emit(itoa(MAIN_NARGS>2?2:MAIN_NARGS));emit("(");
    emit(global_name("main")); emit("[0]");
    if (MAIN_NARGS >= 1) emit(", (word)argc");
    if (MAIN_NARGS >= 2) emit(", __b_argvalues()");
    emitln(");");
    emitln("}");
}

compile_to_c(inpath) {
    extrn malloc;
    read_file(inpath);
    FUNS = malloc(2048 * &0[1]);
    GLOBS = malloc(2048 * &0[1]);
    LOCALS = malloc(2048 * &0[1]);
    LABELS = malloc(2048 * &0[1]);
    NLABELS = 0;
    LABELPASS = 0;
    NLOCALS = 0;
    scan_functions();
    merge_project();
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

/* Quote one argument for the runtime's shell-free command parser. */
cmdarg(b, s) {
    auto i, c;
    buf_ch(b, 047);
    i = 0;
    while (i < slen(s)) {
        c = char(s, i);
        if (c == 047) {
            buf_ch(b, 047);
            buf_ch(b, 0134);
            buf_ch(b, 047);
            buf_ch(b, 047);
        } else buf_ch(b, c);
        i = i + 1;
    }
    buf_ch(b, 047);
}

runtime_dir(prog) {
    auto i, last, b;
    i = 0;
    last = -1;
    while (i < slen(prog)) {
        if (char(prog, i) == '/') last = i;
        i = i + 1;
    }
    b = buf_new(128);
    i = 0;
    while (i <= last) {
        buf_ch(b, char(prog, i));
        i = i + 1;
    }
    buf_str(b, "../../../lib");
    return(buf_take(b));
}

build_cmd(cfiles, nc, out, extras, nextra) {
    auto b, i;
    b = buf_new(4096);
    buf_str(b, "gcc -std=c99 -O2 -Wno-implicit-function-declaration -I ");
    cmdarg(b, LIBDIR);
    if (STRICT) buf_str(b, " -D__bcc_strict_runtime=1 -DB_BYTEPTR=0 -DWORD_BITS=0 -o ");
    else buf_str(b, " -D__bcc_strict_runtime=0 -DB_BYTEPTR=1 -DWORD_BITS=0 -o ");
    cmdarg(b, out);
    i = 0;
    while (i < nc) {
        buf_ch(b, ' ');
        cmdarg(b, cfiles[i]);
        i = i + 1;
    }
    buf_ch(b, ' ');
    cmdarg(b, scat(LIBDIR, "/libb.c"));
    buf_str(b, " -ldl -lm");
    i = 0;
    while (i < nextra) {
        buf_ch(b, ' ');
        cmdarg(b, extras[i]);
        i = i + 1;
    }
    return(buf_take(b));
}

usage() {
    extrn printf;
    printf("usage: bbc [-S] [--emit-c] [--keep-c] [-v] [--libdir path] input.b ... [-o out]*n");
}

main() {
    auto ac, i, emit_stdout, emit_c, keep_c, out, inputs, ninputs, cfiles, nc;
    auto a, csrc, cname, cmd, rc, extras, nextra;
    extrn argc, argv, malloc, system, unlink;
    ac = argc();
    LIBDIR = runtime_dir(argv(0));
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
            if(nextra>=256) fatal("too many compiler options");
            extras[nextra] = scat("-l", argv(i));
            nextra = nextra + 1;
        } else if (streq(a, "-X")) {
            i = i + 1;
            if (i >= ac) fatal("missing -X value");
            if(nextra>=256) fatal("too many compiler options");
            extras[nextra] = argv(i);
            nextra = nextra + 1;
        } else if (streq(a, "--libdir")) {
            i = i + 1;
            if (i >= ac) fatal("missing --libdir value");
            LIBDIR = argv(i);
        } else if (streq(a, "-o")) {
            i = i + 1;
            if (i >= ac) fatal("missing -o value");
            out = argv(i);
        } else if (streq(a, "--dump-tokens")) {
            fatal("--dump-tokens is not implemented");
        } else if (streq(a, "--dump-ast")) {
            fatal("--dump-ast is not implemented");
        } else {
            if(ninputs>=256) fatal("too many input files");
            inputs[ninputs] = a;
            ninputs = ninputs + 1;
        }
        i = i + 1;
    }
    if (ninputs == 0) {
        usage();
        return(2);
    }
    scan_project(inputs,ninputs);
    nc = 0;
    i = 0;
    while (i < ninputs) {
        csrc = compile_to_c(inputs[i]);
        if (emit_stdout) {
            if (write_all(1, csrc, slen(csrc)) != 0)
                fatal("cannot write standard output");
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
