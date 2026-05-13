/* e.b - kbman §9.2.  Print the constant e-2 to about 200 decimal digits.
 * Scaled down from the manual's 4000 (uses v[200] instead of v[2000]).
 * Output: 50 chars per line, in groups of 5.  Slow under apout. */
v[200];
n 200;

main() {
	extrn putchar, n, v;
	auto i, c, col, a;

	i = col = 0;
	while (i < n) {
		v[i] = 1;
		i = i + 1;
	}
	while (col < 2 * n) {
		a = n + 1;
		c = 0;
		i = 0;
		while (i < n) {
			c =+ v[i] * 10;
			v[i] = c % a;
			c =/ a;
			a = a - 1;
			i = i + 1;
		}
		putchar(c + '0');
		col = col + 1;
		if (col % 5 == 0) {
			if (col % 50 == 0) putchar('*n');
			else               putchar(' ');
		}
	}
	putchar('*n');
}
