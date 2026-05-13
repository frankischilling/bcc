/* t21 -- kbman getchar returns *e at EOF. */
main() {
	if (getchar() == '*e') putchar('E');
	else putchar('!');
	putchar('*n');
}
