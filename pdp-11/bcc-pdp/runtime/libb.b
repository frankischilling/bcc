/* libb.b - kbman §8 library functions written in B itself.
 * Compiled to libb.s by passes b00, b01, and b1, then assembled and linked into
 * every B program by /bin/b.
 *
 * Provides printn, printf, getstr, and ctime.
 */

/* printn(n, b) - print non-negative n in base b, 2 <= b <= 16.
 * Based on kbman §9.1, with negative-number and base-16 extensions. */
printn(n, b) {
    extrn putchar;
    auto a;
    if ((b < 2) | (b > 16)) return(-1);
    if (n < 0) {
        putchar('-');
        /* Divide before negating so the most-negative word still fits. */
        a = -(n / b);
        if (a) printn(a, b);
        a = -(n % b);
    } else {
        a = n / b;
        if (a) printn(a, b);
        a = n % b;
    }
    if (a < 10) putchar(a + '0');
    else putchar(a - 10 + 'A');
    return(0);
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
 * x2 at r5+8, ...  Walking adx=&x1 by +1 advances to next user arg.
 * B pointers count words; each physical PDP-11 word is two bytes.
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
	adx = adx + 1;                            /* args grow upward, one B word per argument */

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
	adx = adx - 1;
	goto loop;
}

/* Unsigned comparison of two 16-bit words. */
__ctge(a, b) {
    if (a < 0) {
        if (b >= 0) return(1);
    } else {
        if (b < 0) return(0);
    }
    return(a >= b);
}

__ctdig(dst, pos, n) {
    extrn lchar;
    lchar(dst, pos, '0' + n / 10);
    lchar(dst, pos + 1, '0' + n % 10);
}

__ctmon[12] 31,28,31,30,31,30,31,31,30,31,30,31;

/* B72 section 8: 60 Hz time, high word first, and 16 output bytes.
 * Subtract whole days/minutes without needing a 32-bit B arithmetic type. */
ctime(tv, dst) {
    extrn __ctge, __ctdig, __ctmon, char, lchar;
    auto hi, lo, days, mins, year, month, n, s, i;
    hi = tv[0];
    lo = tv[1];
    days = 0;
    while ((hi < 0) | (hi > 79) | ((hi == 79) & __ctge(lo, 6656))) {
        if (!__ctge(lo, 6656)) hi = hi - 1;
        lo = lo - 6656;
        hi = hi - 79;
        days = days + 1;
    }
    mins = 0;
    while ((hi != 0) | __ctge(lo, 3600)) {
        if (!__ctge(lo, 3600)) hi = hi - 1;
        lo = lo - 3600;
        mins = mins + 1;
    }
    year = 1971;
    n = 365;
    while (days >= n) {
        days = days - n;
        year = year + 1;
        n = 365;
        if (year % 4 == 0) n = 366;
    }
    month = 0;
    n = __ctmon[month];
    while (days >= n) {
        days = days - n;
        month = month + 1;
        n = __ctmon[month];
        if ((month == 1) & (year % 4 == 0)) n = n + 1;
    }
    s = "JanFebMarAprMayJunJulAugSepOctNovDec";
    i = 0;
    while (i < 3) {
        lchar(dst, i, char(s, month * 3 + i));
        i = i + 1;
    }
    lchar(dst, 3, ' ');
    __ctdig(dst, 4, days + 1);
    if (days < 9) lchar(dst, 4, ' ');
    lchar(dst, 6, ' ');
    __ctdig(dst, 7, mins / 60);
    lchar(dst, 9, ':');
    __ctdig(dst, 10, mins % 60);
    lchar(dst, 12, ':');
    __ctdig(dst, 13, lo / 60);
    lchar(dst, 15, 0);
    return(0);
}
