/* B Compiler - THOMPSON_B_PDP11_1972 Dialect (kbman/btut)
 *
 * Targets: Compile the language used in kbman/btut examples and what early libb.a-style programs expect.
 *
 * CORE MODEL:
 * - Typeless word language (PDP-11 word = 16 bits)
 * - Arrays are word vectors; pointers/indexing are word-based
 * - Strings are sequences of characters terminated by *e (EOT / ASCII 4)
 * - Escape introducer is * (not \)
 *
 * LEXICAL:
 * - Comments: / * ... * /
 * - Identifiers: [A-Za-z_][A-Za-z0-9_]*
 * - Numbers: decimal; leading 0 = octal
 * - Character constants: '...' with *n *t *e *0 etc; packed into word(s) as needed
 * - String constants: "..." with * escapes, compiler ensures *e termination
 *
 * DECLARATIONS & PROGRAM STRUCTURE:
 * - auto locals (and vectors auto v[10];)
 * - extrn for externals (usable inside functions as in btut examples)
 * - Function definitions: name(a,b){ ... }
 * - Top-level external initializers like: v[10] 'hi!', 1, 2, 3, 0777; s1 "hello";
 *
 * STATEMENTS:
 * - expression statements
 * - blocks { ... }
 * - if (...) ... [else ...]
 * - while (...) ...
 * - goto label; and label: statement;
 * - switch (...) { case K: ... default: ... }
 * - break (at least for switch; you can later decide whether you want loop-break too)
 *
 * EXPRESSIONS/OPERATORS:
 * - Unary: - ! * & ++ --
 * - Binary: + - * / % << >> & | < <= > >= == !=
 * - Assignment: = =+ =- =* =/ =% =& =| =<< =>>
 * - Conditional: ?:
 * - Logical composition is done with & and | (no && / ||, no short-circuit promise)
 *
 * EXPLICIT NON-GOALS (for now):
 * - No types, no structs, no floats
 * - No for, no do/while
 * - No && / ||
 * - Anything beyond btut/kbman goes into an "Extensions" doc behind a flag
 *
 * BASELINE DIALECT FEATURES:
 * - Keywords: auto, extrn, if, else, while, goto, switch, case, default, break, return
 * - Operators: = + - * / % & | << >> < <= > >= == !=
 * - Assignment ops: = =+ =- =* =/ =% =& =| =<< =>>
 * - Unary: ++ --
 * - Conditional: ?:
 * - Character constants with escapes (*n *t *e etc.)
 * - String constants (terminate with *e)
 * - Decimal/octal numbers, identifiers
 * - Comments: / * * /
 * - Functions with parameters
 *
 * EXTENSIONS (not in baseline, future work):
 * - Relational assignments (=< => etc.)
 * - Advanced operators beyond kbman/btut
 *
 * Unix V1 Runtime Contract:
 * 1. Single-byte I/O only: read(0, &c, 1) / write(1, &c, 1)
 * 2. Identifier storage as int name[] (one char per word), NOT char*
 * 3. Use putnm() + nmeq() for string operations only
 */

buf(op, i, v)
{
	static b[512];
	if(op == 1)
		b[i] = v;
	if(op == 2)
		return(b);
	return(b[i]);
}

bufp(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

bufn(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

peekc(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

lineno(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

obuf(op, i, v)
{
	static b[512];
	if(op == 1)
		b[i] = v;
	if(op == 2)
		return(b);
	return(b[i]);
}

obufp(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

tok(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

tokname(op, i, v)
{
	static b[32];
	if(op == 1)
		b[i] = v;
	if(op == 2)
		return(b);
	return(b[i]);
}

toknum(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

tokop(op, v)
{
	static x;
	if(op)
		x = v;
	return(x);
}

getch()
{
	int c, n;

	if(peekc(0, 0)) {
		c = peekc(0, 0);
		peekc(1, 0);
		return(c);
	}

	n = read(0, &c, 1);
	if(n <= 0)
		return(-1);

	return(c & 0377);
}

ungetch(c)
{
	peekc(1, c);
}

flush()
{
}

putch(c)
{
	int x;

	x = c;
	write(1, &x, 1);
}

putstr(s)
char s[];
{
	while(s[0]) {
		putch(s[0]);
		s = s + 1;
	}
}

putnl()
{
	putch(012);
}

putnum(n)
{
	int d[12];
	int i, neg;

	if(n == 0) {
		putch(060);
		return;
	}
	neg = 0;
	if(n < 0) {
		neg = 1;
		n = -n;
	}
	i = 0;
	while(n > 0) {
		d[i] = 060 + (n % 10);
		i = i + 1;
		n = n / 10;
	}
	if(neg)
		putch(055);
	while(i > 0) {
		i = i - 1;
		putch(d[i]);
	}
}

putoct(n)
{
	int d[12];
	int i;

	if(n == 0) {
		putch(060);
		return;
	}
	i = 0;
	while(n != 0) {
		d[i] = 060 + (n & 7);
		i = i + 1;
		n = (n >> 3) & 017777;
	}
	while(i > 0) {
		i = i - 1;
		putch(d[i]);
	}
}

error(s)
char s[];
{
	int nl[1];

	flush();
	write(2, "error: ", 7);
	while(s[0]) {
		write(2, s, 1);
		s = s + 1;
	}
	nl[0] = 012;
	write(2, nl, 1);
	exit(1);
}

streq(a, b)
char a[], b[];
{
	while(((a[0] == 0) == 0) & ((b[0] == 0) == 0) & (a[0] == b[0])) {
		a = a + 1;
		b = b + 1;
	}
	return(a[0] == b[0]);
}

putnm(s)
int s[];
{
	while(s[0]) {
		putch(s[0]);
		s = s + 1;
	}
}

nmeq(a, b)
int a[];
char b[];
{
	while(((b[0] == 0) == 0) & (a[0] == (b[0] & 0377))) {
		a = a + 1;
		b = b + 1;
	}
	return(a[0] == (b[0] & 0377));
}

keyw(s)
int s[];
{
	if(nmeq(s, "auto")) return(28);
	if(nmeq(s, "extrn")) return(29);
	if(nmeq(s, "if")) return(30);
	if(nmeq(s, "else")) return(31);
	if(nmeq(s, "while")) return(32);
	if(nmeq(s, "return")) return(33);
	if(nmeq(s, "goto")) return(35);
	if(nmeq(s, "switch")) return(36);
	if(nmeq(s, "case")) return(37);
	if(nmeq(s, "default")) return(38);
	if(nmeq(s, "break")) return(39);
	return(1);
}

isalph(c)
{
	if(c >= 0141 & c <= 0172) return(1);
	if(c >= 0101 & c <= 0132) return(1);
	if(c == 0137) return(1);
	return(0);
}

isdigt(c)
{
	if(c >= 060 & c <= 071) return(1);
	return(0);
}

isalnu(c)
{
	if(isalph(c)) return(1);
	if(isdigt(c)) return(1);
	return(0);
}

gettok()
{
	int c, c2, i, n;

skip:
	c = getch();
	while(c == 040 | c == 011 | c == 012 | c == 015) {
		if(c == 012)
			lineno(1, lineno(0, 0) + 1);
		c = getch();
	}

	if(c < 0) {
		tok(1, 0);
		return(0);
	}

	if(c == 057) {
		c2 = getch();
		if(c2 == 052) {
cmt:
			c = getch();
			if(c < 0) goto skip;
			if(c == 012) lineno(1, lineno(0, 0) + 1);
			if(c == 052) {
				c2 = getch();
				if(c2 == 057) goto skip;
				ungetch(c2);
			}
			goto cmt;
		}
		ungetch(c2);
		tok(1, 17);
		return(17);
	}

	if(isalph(c)) {
		i = 0;
		while(isalnu(c) & i < 31) {
			tokname(1, i, c);
			i = i + 1;
			c = getch();
		}
		tokname(1, i, 0);
		ungetch(c);
		n = keyw(tokname(2, 0, 0));
		tok(1, n);
		return(n);
	}

	if(isdigt(c)) {
		n = 0;
		if(c == 060) {
			c = getch();
			while(c >= 060 & c <= 067) {
				n = n * 8 + (c - 060);
				c = getch();
			}
		} else {
			while(isdigt(c)) {
				n = n * 10 + (c - 060);
				c = getch();
			}
		}
		ungetch(c);
		toknum(1, n);
		tok(1, 2);
		return(2);
	}

	if(c == 047) {
		n = 0;
chloop:
		c = getch();
		if(c == 047 | c < 0) goto chdone;
		if(c == 052) {
			c = getch();
			if(c == 0145) c = 004;
			else if(c == 0156) c = 012;
			else if(c == 0164) c = 011;
			else if(c == 060) c = 0;
		}
		n = (n << 8) | (c & 0377);
		goto chloop;
chdone:
		toknum(1, n);
		tok(1, 3);
		return(3);
	}

	if(c == 042) {
		i = 0;
strloop:
		c = getch();
		if(c == 042 | c < 0 | i >= 31) goto strdone;
		if(c == 052) {
			c = getch();
			if(c == 0145) c = 004;
			else if(c == 0156) c = 012;
			else if(c == 0164) c = 011;
			else if(c == 060) c = 0;
		}
		tokname(1, i, c);
		i = i + 1;
		goto strloop;
strdone:
		tokname(1, i, 0);
		tok(1, 4);
		return(4);
	}

	if(c == 073) { tok(1, 5); return(5); }
	if(c == 0173) { tok(1, 6); return(6); }
	if(c == 0175) { tok(1, 7); return(7); }
	if(c == 050) { tok(1, 8); return(8); }
	if(c == 051) { tok(1, 9); return(9); }
	if(c == 0133) { tok(1, 10); return(10); }
	if(c == 0135) { tok(1, 11); return(11); }
	if(c == 054) { tok(1, 12); return(12); }   /* , */
	if(c == 072) { tok(1, 40); return(40); }   /* : */
	if(c == 077) { tok(1, 41); return(41); }   /* ? */

	if(c == 053) {                             /* + or ++ */
		c2 = getch();
		if(c2 == 053) { tok(1, 42); return(42); }  /* ++ */
		ungetch(c2);
		tok(1, 14);
		return(14);
	}
	if(c == 055) {                             /* - or -- */
		c2 = getch();
		if(c2 == 055) { tok(1, 43); return(43); }  /* -- */
		ungetch(c2);
		tok(1, 15);
		return(15);
	}
	if(c == 052) { tok(1, 16); return(16); }
	if(c == 045) { tok(1, 18); return(18); }
	if(c == 046) { tok(1, 19); return(19); }
	if(c == 0174) { tok(1, 20); return(20); }

	if(c == 041) {
		c = getch();
		if(c == 075) { tok(1, 25); return(25); }
		ungetch(c);
		tok(1, 21);
		return(21);
	}

	if(c == 074) {
		c = getch();
		if(c == 075) { tok(1, 26); return(26); }
		ungetch(c);
		tok(1, 22);
		return(22);
	}

	if(c == 076) {
		c = getch();
		if(c == 075) { tok(1, 27); return(27); }
		ungetch(c);
		tok(1, 23);
		return(23);
	}

	if(c == 075) {
		c = getch();
		if(c == 075) { tok(1, 24); return(24); }
		if(c == 053) { tokop(1, 14); tok(1, 34); return(34); }
		if(c == 055) { tokop(1, 15); tok(1, 34); return(34); }
		if(c == 052) { tokop(1, 16); tok(1, 34); return(34); }
		if(c == 057) { tokop(1, 17); tok(1, 34); return(34); }
		if(c == 045) { tokop(1, 18); tok(1, 34); return(34); }
		ungetch(c);
		tok(1, 13);
		return(13);
	}

	error("bad char");
	tok(1, 0);
	return(0);
}

main()
{
	int t;

	lineno(1, 1);
	bufp(1, 0);
	bufn(1, 0);
	peekc(1, 0);
	obufp(1, 0);

	while(gettok() != 0) {
		t = tok(0, 0);
		putstr("tok=");
		putnum(t);
		if(t == 1 | t == 4) {
			putstr(" name=");
			putnm(tokname(2, 0, 0));
		}
		if(t == 2 | t == 3) {
			putstr(" num=");
			putnum(toknum(0, 0));
		}
		putnl();
	}
	flush();
	exit(0);
}
