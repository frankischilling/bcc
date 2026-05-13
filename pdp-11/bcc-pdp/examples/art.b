/* art.b - print an 8-line ASCII pyramid using only B primitives. */
main() {
	extrn putchar;
	auto row, sp, st;
	row = 1;
	while (row <= 8) {
		sp = 8 - row;
		while (sp > 0) { putchar(' '); sp = sp - 1; }
		st = 2 * row - 1;
		while (st > 0) { putchar('*'); st = st - 1; }
		putchar('*n');
		row = row + 1;
	}
}
