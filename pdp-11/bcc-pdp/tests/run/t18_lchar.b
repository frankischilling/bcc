/* t18 -- lchar(s,i,c) byte set then read back.  Output: HELLO\n */
buf[3];

main() {
	extrn putchar, char, lchar, buf;
	auto i;

	lchar(buf, 0, 'H');
	lchar(buf, 1, 'E');
	lchar(buf, 2, 'L');
	lchar(buf, 3, 'L');
	lchar(buf, 4, 'O');

	i = 0;
	while (i < 5) {
		putchar(char(buf, i));
		i = i + 1;
	}
	putchar('*n');
}
