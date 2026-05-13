/* libb.b - kbman §8 library functions written in B itself.
 * Compiled to libb.s by passes b0+b1, then assembled and linked into
 * every B program by /bin/b.
 *
 * Provides: printn (kbman §9.1), printf (kbman §9.3), getstr.
 */

/* printn(n, b) - print non-negative n in base b, 2 <= b <= 16.
 * kbman §9.1 verbatim, with handling for negative n. */
printn(n, b) {
	extrn putchar;
	auto a;

	if (n < 0) {
		putchar('-');
		n = -n;
	}
	if (a = n / b)
		printn(a, b);
	a = n % b;
	if (a < 10)
		putchar(a + '0');
	else
		putchar(a - 10 + 'A');
}

/* getstr(s) - read chars from stdin into byte-string s; stop on newline or
 * EOF.  Terminate with *e (04).  Returns count read. */
getstr(s) {
	extrn getchar, lchar;
	auto i, c;
	i = 0;
	while (1) {
		c = getchar();
		if (c == '*e') {
			lchar(s, i, 4);          /* *e */
			return(i);
		}
		if (c == '*n') {
			lchar(s, i, 4);
			return(i);
		}
		lchar(s, i, c);
		i = i + 1;
	}
}

/* printf(fmt, x1..x9) - kbman §9.3.  Format directives:
 *   %d  decimal     %o  octal     %c  char     %s  string     %%  literal %
 * Calling convention: cgcll reverses the pushed args so leftmost ends up
 * at TOS.  Arg layout in callee (r5 frame):  fmt at r5+4, x1 at r5+6,
 * x2 at r5+8, ...  Walking adx=&x1 by +2 advances to next user arg.
 * (Pointer step is 2 bytes - byte-addressed model, kbman §12 deviation.)
 */
printf(fmt, x1, x2, x3, x4, x5, x6, x7, x8, x9) {
	extrn printn, char, putchar;
	auto adx, x, c, i, j;

	i = 0;
	adx = &x1;
loop:
	while ((c = char(fmt, i)) != '%') {
		if (c == '*e')
			return;
		if (c == 0)                          /* C-string null term safety */
			return;
		putchar(c);
		i = i + 1;
	}
	i = i + 1;                                /* past '%' */
	x = *adx;
	adx = adx + 2;                            /* args grow upward, byte step */

	c = char(fmt, i);
	i = i + 1;

	if (c == 'd') {
		printn(x, 10);
		goto loop;
	}
	if (c == 'o') {
		printn(x, 8);
		goto loop;
	}
	if (c == 'c') {
		putchar(x);
		goto loop;
	}
	if (c == 's') {
		j = 0;
		while ((c = char(x, j)) != '*e') {
			if (c == 0) goto loop;       /* C-string null term safety */
			putchar(c);
			j = j + 1;
		}
		goto loop;
	}
	/* unrecognized %X: print '%' literally and back up */
	putchar('%');
	i = i - 1;
	adx = adx - 2;
	goto loop;
}
