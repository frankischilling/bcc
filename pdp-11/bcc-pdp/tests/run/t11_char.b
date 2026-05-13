/* t11 -- char(s,i) byte get on a string literal.  Output: hello\n */
main() {
	extrn putchar, char;
	auto s, i;
	s = "hello";
	i = 0;
	while (i < 5) {
		putchar(char(s, i));
		i = i + 1;
	}
	putchar('*n');
}
