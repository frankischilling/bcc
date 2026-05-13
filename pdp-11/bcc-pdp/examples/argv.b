/* argv.b - print the kbman predefined argv vector, one argument per line. */
pr(s) {
	extrn char, putchar;
	auto i, c;
	i = 0;
	while (1) {
		c = char(s, i);
		if (c == 0) return;
		if (c == '*e') return;
		putchar(c);
		i = i + 1;
	}
}

main() {
	extrn argv, pr, printn, putchar;
	auto i, n;
	n = argv[0];
	printn(n, 10);
	putchar('*n');
	i = 1;
	while (i <= n) {
		pr(argv[i]);
		putchar('*n');
		i = i + 1;
	}
}
