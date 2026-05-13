digits[10] 0,0,0,0,0,0,0,0,0,0;

main() {
	auto c, i;
	while ((c = getchar()) != '*e') {
		if (c >= '0') if (c <= '9')
			digits[c - '0']++;
	}
	i = 0;
	while (i < 10) {
		putchar('0' + i);
		putchar(':');
		putchar('0' + digits[i]);
		putchar('*n');
		i++;
	}
}
