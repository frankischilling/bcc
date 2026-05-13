/* sieve.b - Sieve of Eratosthenes for primes <= LIM, printed on one line. */
LIM 100;
flags[100];

main() {
	extrn flags, LIM, putchar, printn;
	auto i, j, first;

	i = 0;
	while (i < LIM) {
		flags[i] = 1;
		i = i + 1;
	}
	flags[0] = 0;
	flags[1] = 0;

	i = 2;
	while (i < LIM) {
		if (flags[i]) {
			j = i + i;
			while (j < LIM) {
				flags[j] = 0;
				j = j + i;
			}
		}
		i = i + 1;
	}

	first = 1;
	i = 2;
	while (i < LIM) {
		if (flags[i]) {
			if (first == 0) putchar(' ');
			first = 0;
			printn(i, 10);
		}
		i = i + 1;
	}
	putchar('*n');
}
