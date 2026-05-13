/* echo.b - print argv args, separated by spaces, terminated by newline.
 * Uses kbman §8 predefined argv vector. */
prnt(s) {
	extrn putchar, char;
	auto i, c;
	i = 0;
	while (1) {
		c = char(s, i);
		if (c == 0) return;
		if (c == 4) return;       /* *e EOT */
		putchar(c);
		i = i + 1;
	}
}

main() {
	extrn argv, prnt, putchar;
	auto i, n;
	n = argv[0];
	i = 1;
	while (i <= n) {
		prnt(argv[i]);
		if (i < n) putchar(' ');
		i = i + 1;
	}
	putchar('*n');
}
