/* Tokenize B source with eight-character names and 16-bit numeric values. */
tok 0;
tval 0;
tstr 0;
tstrbuf[130];
tstrlen 0;
tnam[5];

peekc 0;
pushd 0;
savtok 0;
savval 0;
savstr 0;
savnam[5];

inpfd 0;

kwn[20];
kwt[20];
kwc 0;

stkend 0;

lexini(fd) {
    extrn inpfd, peekc, pushd, savtok, lineno;

    inpfd = fd;
    peekc = -1;
    pushd = 0;
    savtok = -1;
    lineno = 1;
    kwinit();
}

kwadd(s, t) {
    extrn kwn, kwt, kwc;

    kwn[kwc] = s;
    kwt[kwc] = t;
    kwc = kwc + 1;
}

kwinit() {
    extrn kwc, extflg;

    if (kwc) return;
    kwadd("auto", 10);
    kwadd("extrn", 11);
    kwadd("if", 12);
    kwadd("else", 13);
    kwadd("while", 14);
    kwadd("return", 15);
    kwadd("goto", 16);

    if (extflg) {
        kwadd("break", 17);
        kwadd("continue", 18);
    }
    kwadd("switch", 19);
    kwadd("case", 20);
}

gtch() {
    extrn peekc, inpfd, lineno;

    auto c;
    auto b 1;
    if (peekc >= 0) {
        c = peekc;
        peekc = -1;
        goto gotc;
    }
    c = read(inpfd, b, 1);
    if (c < 0) fatal("cannot read source");
    if (c == 0) return(-1);
    c = char(b,0) & 0377;
    gotc:

    if (c == '*n') lineno = lineno + 1;
    return(c);
}

unch(c) {
    extrn peekc, lineno;

    peekc = c;
    if (c == '*n') lineno = lineno - 1;
}

isltr(c) {
    if (c >= 'a') if (c <= 'z') return(1);
    if (c >= 'A') if (c <= 'Z') return(1);
    if (c == '_' | c == 8) return(1);
    return(0);
}

isdig(c) {
    if (c >= '0') if (c <= '9') return(1);
    return(0);
}

isaln(c) {
    if (isltr(c)) return(1);
    if (isdig(c)) return(1);
    return(0);
}

isws(c) {
    if (c == ' ') return(1);
    if (c == '*t') return(1);
    if (c == '*n') return(1);
    if (c == 13) return(1);
    return(0);
}

streq(a,b) {
    extrn char;
    auto i,x,y;
    i=0;
    while (1) {
        x=char(a,i);y=char(b,i);
        if (x==4) x=0;if (y==4) y=0;
        if (x!=y) return(0);
        if (x==0) return(1);
        i++;
    }
}
kwlook(s) {
    extrn kwn, kwt, kwc;

    auto i;
    i = 0;
    while (i < kwc) {
        if (streq(s, kwn[i])) return(kwt[i]);
        i = i + 1;
    }
    return(1);
}

pushtok() {
    extrn tok, tval, tstr, tnam, savtok, savval, savstr, savnam;

    auto i;
    savtok = tok;
    savval = tval;
    savstr = tstr;
    i = 0;
    while (i <= 8) {
        lchar(savnam,i,char(tnam,i));
        i = i + 1;
    }
}

rdesc() {
    auto c;
    c = gtch();
    if (c == 'n') return('*n');
    if (c == 't') return('*t');
    if (c == '0') return(0);
    if (c == 'e') return(4);
    if (c == '(') return('{');
    if (c == ')') return('}');
    if (c == '**') return('**');
    if (c == '*'') return('*'');
    if (c == '"') return('"');
    return(c);
}

lexnam(c) {
    extrn tnam;

    auto i;
    i = 0;
    while (isaln(c)) {
        if (i >= 8) fatal("identifier too long");
        lchar(tnam,i,c);
        i = i + 1;
        c = gtch();
    }
    lchar(tnam,i,0);
    unch(c);
}

lexnum(c) {
    extrn tval;

    auto base;
    tval = norm16(0);
    base = 10;
    if (c == '0') base = 8;
    if (base == 8) {
        c = gtch();
        while (isdig(c)) {
            tval = norm16(tval * 8 + (c - '0'));
            c = gtch();
        }
        unch(c);
        return;
    }
    tval = norm16(c - '0');
    c = gtch();
    while (isdig(c)) {
        tval = norm16(tval * 10 + (c - '0'));
        c = gtch();
    }
    unch(c);
}

lexchr(endc) {
    extrn tval;

    auto c, n;
    tval = norm16(0);
    n = 0;
    c = gtch();
    while (1) {
        if (c == '*'') goto chrend;
        if (c == endc) goto chrend;
        if (c < 0) fatal("unterminated character constant");
        if (c == '**') c = rdesc();
        if (c < 0) fatal("unterminated character constant");
        if (n >= 2) fatal("character constant too long");
        tval = norm16((tval << 8) | (c & 0377));
        n = n + 1;
        c = gtch();
    }
    chrend:
    if (n == 0) fatal("empty character constant");
}

lexstr() {
    extrn tstrbuf, tstrlen;

    auto c, n;
    n = 0;
    c = gtch();
    while (1) {
        if (c == '"') goto strend;
        if (c < 0) fatal("unterminated string literal");
        if (c == '**') c = rdesc();
        if (c < 0) fatal("unterminated string literal");
        if (n >= 255) fatal("string literal too long");
        lchar(tstrbuf,n,c);
        n = n + 1;
        c = gtch();
    }
    strend:
    lchar(tstrbuf,n,4);
    n = n + 1;
    tstrlen = n;
}

lexeq() {
    extrn extflg;

    auto c, c2;
    c = gtch();
    if (c == '+') return(130);
    if (c == '-') return(131);
    if (c == '**') return(132);
    if (c == '/') return(133);
    if (c == '%') return(134);
    if (c == '&') return(135);
    if (c == '|') return(136);
    if (c == '^') {
        if (!extflg) fatal("=^ removed in strict 1972 mode");
        return(137);
    }
    if (c == '=') {
        c2 = gtch();
        if (c2 == '=') return(140);
        unch(c2);
        return(100);
    }
    if (c == '!') {
        c2 = gtch();
        if (c2 == '=') return(141);
        fatal("expected = after =!");
    }
    if (c == '<') {
        c2 = gtch();
        if (c2 == '<') return(138);
        if (c2 == '=') return(143);
        unch(c2);
        return(142);
    }
    if (c == '>') {
        c2 = gtch();
        if (c2 == '>') return(139);
        if (c2 == '=') return(145);
        unch(c2);
        return(144);
    }
    unch(c);
    return('=');
}

gettok() {
    extrn tok, tval, tstr, tnam, savtok, savval, savstr, savnam, pushd, extflg;

    auto c, i, n;

    if (pushd) {
        pushd = 0;
        return;
    }
    if (savtok >= 0) {
        tok = savtok;
        tval = savval;
        tstr = savstr;
        i = 0;
        while (i <= 8) {
            lchar(tnam,i,char(savnam,i));
            i = i + 1;
        }
        savtok = -1;
        return;
    }
    again:
    c = gtch();
    while (isws(c)) c = gtch();
    if (c < 0) { tok = 0; return; }

    if (isltr(c)) {
        lexnam(c);
        tok = kwlook(tnam);
        return;
    }
    if (isdig(c)) {
        lexnum(c);
        tok = 2;
        return;
    }
    if (c == '*'') {
        lexchr('*'');
        tok = 4;
        return;
    }
    if (c == '`') {
        lexchr('`');
        tok = 4;
        return;
    }
    if (c == '"') {
        lexstr();
        tok = 3;
        return;
    }

    if (c == '+') {
        c = gtch();
        if (c == '+') { tok = 106; return; }
        unch(c);
        tok = '+';
        return;
    }
    if (c == '-') {
        c = gtch();
        if (c == '-') { tok = 107; return; }
        unch(c);
        tok = '-';
        return;
    }
    if (c == '/') {
        c = gtch();
        if (c == '**') {
            while (1) {
                c = gtch();
                if (c < 0) fatal("unterminated comment");
                if (c == '**') {
                    c = gtch();
                    if (c == '/') goto again;
                    unch(c);
                }
            }
        }
        unch(c);
        tok = '/';
        return;
    }
    if (c == '&') {
        c = gtch();
        if (c == '&') {
            if (!extflg) fatal("&& removed in strict 1972 mode");
            tok = 108;
            return;
        }
        unch(c);
        tok = '&';
        return;
    }
    if (c == '|') {
        c = gtch();
        if (c == '|') {
            if (!extflg) fatal("|| removed in strict 1972 mode");
            tok = 109;
            return;
        }
        unch(c);
        tok = '|';
        return;
    }
    if (c == '!') {
        c = gtch();
        if (c == '=') { tok = 101; return; }
        unch(c);
        tok = '!';
        return;
    }
    if (c == '<') {
        c = gtch();
        if (c == '=') { tok = 102; return; }
        if (c == '<') { tok = 104; return; }
        unch(c);
        tok = '<';
        return;
    }
    if (c == '>') {
        c = gtch();
        if (c == '=') { tok = 103; return; }
        if (c == '>') { tok = 105; return; }
        unch(c);
        tok = '>';
        return;
    }
    if (c == '=') {
        tok = lexeq();
        return;
    }

    if (c == '~') {
        if (!extflg) fatal("~ removed in strict 1972 mode");
        tok = c;
        return;
    }
    if (c == '^') {
        if (!extflg) fatal("^ removed in strict 1972 mode");
        tok = c;
        return;
    }

    if (c == '(') { tok = c; return; }
    if (c == ')') { tok = c; return; }
    if (c == '{') { tok = c; return; }
    if (c == '}') { tok = c; return; }
    if (c == '[') { tok = c; return; }
    if (c == ']') { tok = c; return; }
    if (c == ';') { tok = c; return; }
    if (c == ',') { tok = c; return; }
    if (c == ':') { tok = c; return; }
    if (c == '?') { tok = c; return; }
    if (c == '**') { tok = c; return; }
    if (c == '%') { tok = c; return; }

    fatal("lexer: unexpected character");
}

norm16(v) {
    v=v&65535;
    if (v&32768) v=v|(-32768);
    return(v);
}
