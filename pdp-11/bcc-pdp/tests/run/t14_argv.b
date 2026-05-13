/* t14 -- access predefined argv vector.  argv[0] = argc, argv[1..n] = strings.
 * Print each arg on its own line.  Run: tools/run-apout.sh t14_argv.b alpha beta
 * Output (for "alpha beta"): alpha\nbeta\n
 */
prnt(s) {
	extrn putchar, char;
	auto i, c;
	i = 0;
	while (1) {
		c = char(s, i);
		if (c == 0) return;        /* C-string terminated for V1 argv */
		if (c == 4) return;        /* *e EOT (B convention) */
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
		putchar('*n');
		i = i + 1;
	}
}
