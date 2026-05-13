main() {
	auto v[3], x, i;
	v[0] = 'E';
	v[1] = 'X';
	v[2] = '*n';
	x = 1;
	x =^ 3;
	if ((x == 2) && (0 || 1)) {
		putchar(v[0]);
		putchar(v[1]);
	}
	i = 0;
	while (i < 5) {
		i++;
		if (i == 2) continue;
		if (i == 4) break;
		putchar('0' + i);
	}
	putchar(v[2]);
}
