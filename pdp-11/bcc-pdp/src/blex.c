/* blex.c -- lexer.  Strict 1972 kbman conformance.
 *
 * Tokens (all defined as literal ints in switches below):
 *   0   T_EOF
 *   1   T_NAME
 *   2   T_NUM
 *   3   T_STR
 *   4   T_CHAR
 *  10   T_AUTO   11 T_EXTRN  12 T_IF   13 T_ELSE  14 T_WHILE
 *  15   T_RET    16 T_GOTO   17 T_BREAK 18 T_CONT 19 T_SWITCH  20 T_CASE
 * 100 T_EQ 101 T_NE 102 T_LE 103 T_GE
 * 104 T_SHL 105 T_SHR 106 T_INC 107 T_DEC
 * 130 T_AEQ (base; +0..6 for + - * / % & | ; +8..9 for << >>;
 *            +10..15 for == != < <= > >=)
 * single-char punct uses its ASCII value: ( ) { } [ ] ; , : ? + - * / % ! < > = &
 *
 * Post-1972 extensions require b00 -x:
 *   keywords break, continue
 *   operators ~ ^ && || =^
 *
 * Identifier limit NAMELEN = 8.  V1 as truncates linker symbols to 7
 * chars after the _ prefix, so all globals here use unique 6-char-stable
 * prefixes.
 *
 * Builtin globals visible to other passes:
 *   tok      -- current token id
 *   tval     -- numeric value for T_NUM/T_CHAR
 *   tstr     -- literal id for T_STR
 *   tnam     -- identifier text (9-byte char array for T_NAME)
 *   lineno   -- line counter (defined in butil.c)
 */

tok 0;
tval 0;
tstr 0;
tstrbuf[260];      /* current string literal bytes, terminated by *e=4 */
tstrlen 0;         /* number of bytes in tstrbuf */
tnam[5];           /* 5 ints = 10 bytes -- 8 chars + null + slack */

peekc 0;       /* set to -1 in lexini (V1 cc rejects negative global init) */
pushd 0;
savtok 0;      /* sentinel -1 set by lexini */
savval 0;
savstr 0;
savnam[5];

inpfd 0;

kwn[20];          /* int pointers to keyword strings */
kwt[20];          /* int tokens */
kwc 0;

lexini(fd) {
	extern inpfd, peekc, pushd, savtok, lineno;
	int inpfd, peekc, pushd, savtok, lineno;
	inpfd = fd;
	peekc = -1;
	pushd = 0;
	savtok = -1;
	lineno = 1;
	kwinit();
}

kwadd(s, t) char s[]; {
	extern kwn, kwt, kwc;
	int kwn[], kwt[], kwc;
	kwn[kwc] = s;
	kwt[kwc] = t;
	kwc = kwc + 1;
}

kwinit() {
	extern kwc;
	int kwc;
	if (kwc) return;
	kwadd("auto",     10);   /* T_AUTO   */
	kwadd("extrn",    11);   /* T_EXTRN  */
	kwadd("if",       12);   /* T_IF     */
	kwadd("else",     13);   /* T_ELSE   */
	kwadd("while",    14);   /* T_WHILE  */
	kwadd("return",   15);   /* T_RET    */
	kwadd("goto",     16);   /* T_GOTO   */
	kwadd("break",    17);   /* T_BREAK  */
	kwadd("continue", 18);   /* T_CONT   */
	kwadd("switch",   19);   /* T_SWITCH */
	kwadd("case",     20);   /* T_CASE   */
}

gtch() {
	extern peekc, inpfd, lineno;
	int peekc, inpfd, lineno;
	int c;
	char b[2];
	if (peekc >= 0) {
		c = peekc;
		peekc = -1;
		return (c);
	}
	if (read(inpfd, b, 1) <= 0) return (-1);
	c = b[0] & 0377;
	if (c == '\n') lineno = lineno + 1;
	return (c);
}

unch(c) {
	extern peekc, lineno;
	int peekc, lineno;
	peekc = c;
	if (c == '\n') lineno = lineno - 1;
}

isltr(c) {
	if (c >= 'a') if (c <= 'z') return (1);
	if (c >= 'A') if (c <= 'Z') return (1);
	if (c == '_') return (1);
	return (0);
}

isdig(c) {
	if (c >= '0') if (c <= '9') return (1);
	return (0);
}

isaln(c) {
	if (isltr(c)) return (1);
	if (isdig(c)) return (1);
	return (0);
}

isws(c) {
	if (c == ' ') return (1);
	if (c == '\t') return (1);
	if (c == '\n') return (1);
	if (c == '\r') return (1);
	return (0);
}

streq(a, b) char a[]; char b[]; {
	int i;
	i = 0;
	while (1) {
		if (a[i] == 0) break;
		if (b[i] == 0) break;
		if (a[i] != b[i]) return (0);
		i = i + 1;
	}
	if (a[i] != 0) return (0);
	if (b[i] != 0) return (0);
	return (1);
}

kwlook(s) char s[]; {
	extern kwn, kwt, kwc;
	int kwn[], kwt[], kwc;
	int i;
	i = 0;
	while (i < kwc) {
		if (streq(s, kwn[i])) return (kwt[i]);
		i = i + 1;
	}
	return (1);   /* T_NAME */
}

pushtok() {
	extern tok, tval, tstr, tnam, savtok, savval, savstr, savnam;
	int  tok, tval, tstr, savtok, savval, savstr;
	char tnam[], savnam[];
	int i;
	savtok = tok;
	savval = tval;
	savstr = tstr;
	i = 0;
	while (i <= 8) {
		savnam[i] = tnam[i];
		i = i + 1;
	}
}

rdesc() {
	int c;
	c = gtch();
	if (c == 'n')  return ('\n');
	if (c == 't')  return ('\t');
	if (c == '0')  return (0);
	if (c == 'e')  return (4);     /* B *e EOT */
	if (c == '(')  return ('{');
	if (c == ')')  return ('}');
	if (c == '*')  return ('*');
	if (c == '\'') return ('\'');
	if (c == '"')  return ('"');
	return (c);
}

/* Read one identifier into tnam.  Caller has already read first char c. */
lexnam(c) {
	extern tnam;
	char tnam[];
	int i;
	i = 0;
	while (isaln(c)) {
		if (i < 8) {
			tnam[i] = c;
			i = i + 1;
		}
		c = gtch();
	}
	tnam[i] = 0;
	unch(c);
}

/* Read decimal or octal number, leave result in tval. */
lexnum(c) {
	extern tval;
	int tval;
	int base;
	tval = 0;
	base = 10;
	if (c == '0') base = 8;
	if (base == 8) {
		c = gtch();
		while (isdig(c)) {
			tval = tval * 8 + (c - '0');
			c = gtch();
		}
		unch(c);
		return;
	}
	tval = c - '0';
	c = gtch();
	while (isdig(c)) {
		tval = tval * 10 + (c - '0');
		c = gtch();
	}
	unch(c);
}

/* Read char constant 'c' or 'cc' (B multi-char).  Result in tval.
 * Accept `x' too, matching the spelling in several kbman examples. */
lexchr(endc) {
	extern tval;
	int tval;
	int c, endc;
	tval = 0;
	c = gtch();
	while (1) {
		if (c == '\'') break;
		if (c == endc) break;
		if (c < 0) break;
		if (c == '*') c = rdesc();
		tval = (tval << 8) | (c & 0377);
		c = gtch();
	}
}

/* Read string literal, leave raw bytes in tstrbuf/tstrlen. */
lexstr() {
	extern tstrbuf, tstrlen;
	char tstrbuf[];
	int tstrlen;
	int c, n;
	n = 0;
	c = gtch();
	while (1) {
		if (c == '"') break;
		if (c < 0) break;
		if (c == '*') c = rdesc();
		tstrbuf[n] = c;
		n = n + 1;
		c = gtch();
	}
	tstrbuf[n] = 4;          /* *e EOT terminator */
	n = n + 1;
	tstrlen = n;
}

/* Handle '=' followed by operator.  Per kbman 1972 §4.11 there are 16
 * assignment forms: =  =| =& === =!= =< =<= => =>= =<< =>> =+ =- =% =* =/
 * Token map:
 *   100        T_EQ      (==, not assign)
 *   130..136   =+ =- =* =/ =% =& =|
 *   137        =^ (extension mode only)
 *   138..139   =<< =>>
 *   140..145   === =!= =< =<= => =>=
 */
lexeq() {
	extern extflg;
	int extflg;
	int c, c2;
	c = gtch();
	if (c == '+') return (130);
	if (c == '-') return (131);
	if (c == '*') return (132);
	if (c == '/') return (133);
	if (c == '%') return (134);
	if (c == '&') return (135);
	if (c == '|') return (136);
	if (c == '^') {
		if (!extflg) fatal("=^ removed in strict 1972 mode");
		return (137);
	}
	if (c == '=') {
		c2 = gtch();
		if (c2 == '=') return (140);   /* === */
		unch(c2);
		return (100);                  /* == */
	}
	if (c == '!') {
		c2 = gtch();
		if (c2 == '=') return (141);   /* =!= */
		fatal("expected = after =!");
	}
	if (c == '<') {
		c2 = gtch();
		if (c2 == '<') return (138);   /* =<< */
		if (c2 == '=') return (143);   /* =<= */
		unch(c2);
		return (142);                  /* =<  */
	}
	if (c == '>') {
		c2 = gtch();
		if (c2 == '>') return (139);   /* =>> */
		if (c2 == '=') return (145);   /* =>= */
		unch(c2);
		return (144);                  /* =>  */
	}
	unch(c);
	return ('=');
}

gettok() {
	extern tok, tval, tstr, tnam, savtok, savval, savstr, savnam, pushd, extflg;
	int  tok, tval, tstr, savtok, savval, savstr, pushd, extflg;
	char tnam[], savnam[];
	int c, i, n;

	if (pushd) {
		pushd = 0;
		return;
	}
	if (savtok >= 0) {
		tok  = savtok;
		tval = savval;
		tstr = savstr;
		i = 0;
		while (i <= 8) {
			tnam[i] = savnam[i];
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
		tok = 2;     /* T_NUM */
		return;
	}
	if (c == '\'') {
		lexchr('\'');
		tok = 4;     /* T_CHAR */
		return;
	}
	if (c == '`') {
		lexchr('`');
		tok = 4;     /* T_CHAR */
		return;
	}
	if (c == '"') {
		lexstr();
		tok = 3;     /* T_STR */
		return;
	}

	if (c == '+') {
		c = gtch();
		if (c == '+') { tok = 106; return; }   /* T_INC */
		unch(c);
		tok = '+';
		return;
	}
	if (c == '-') {
		c = gtch();
		if (c == '-') { tok = 107; return; }   /* T_DEC */
		unch(c);
		tok = '-';
		return;
	}
	if (c == '/') {
		c = gtch();
		if (c == '*') {
			while (1) {
				c = gtch();
				if (c < 0) fatal("unterminated comment");
				if (c == '*') {
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
		if (c == '=') { tok = 101; return; }   /* T_NE */
		unch(c);
		tok = '!';
		return;
	}
	if (c == '<') {
		c = gtch();
		if (c == '=') { tok = 102; return; }   /* T_LE */
		if (c == '<') { tok = 104; return; }   /* T_SHL */
		unch(c);
		tok = '<';
		return;
	}
	if (c == '>') {
		c = gtch();
		if (c == '=') { tok = 103; return; }   /* T_GE */
		if (c == '>') { tok = 105; return; }   /* T_SHR */
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

	/* single-char punct: ( ) { } [ ] ; , : ? * % */
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
	if (c == '*') { tok = c; return; }
	if (c == '%') { tok = c; return; }

	fatal("lexer: unexpected character");
}
