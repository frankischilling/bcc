/* fib.b - recursive Fibonacci, prints fib(0..15) using printn (libb). */
fib(n) {
	if (n < 2)
		return(n);
	return(fib(n - 1) + fib(n - 2));
}

main() {
	extrn putchar, printn, fib;
	auto i;
	i = 0;
	while (i <= 15) {
		printn(fib(i), 10);
		putchar(' ');
		i = i + 1;
	}
	putchar('*n');
}
