/* fact.b - factorial.  argv[1] is number; default to 5. */
fact(n) {
	if (n <= 1) return(1);
	return(n * fact(n - 1));
}

atoi(s) {
	extrn char;
	auto i, n, c;
	i = 0; n = 0;
	while (1) {
		c = char(s, i);
		if (c < '0') return(n);
		if (c > '9') return(n);
		n = n * 10 + c - '0';
		i = i + 1;
	}
}

main() {
	extrn argv, fact, atoi, printn, putchar;
	auto n;
	if (argv[0] >= 1) n = atoi(argv[1]);
	else              n = 5;
	printn(fact(n), 10);
	putchar('*n');
}
