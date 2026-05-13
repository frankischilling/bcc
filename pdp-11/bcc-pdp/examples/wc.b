/* wc.b - word/line/char count of stdin (kbman §8 putchar/getchar/printn).
 * Output: <lines> <words> <chars>\n */
main() {
	extrn getchar, putchar, printn;
	auto c, lines, words, chars, inword;
	lines = 0; words = 0; chars = 0; inword = 0;
	while (1) {
		c = getchar();
		if (c == '*e') goto done;
		chars = chars + 1;
		if (c == '*n') lines = lines + 1;
		if (c == ' ') {
			inword = 0;
		} else if (c == '*t') {
			inword = 0;
		} else if (c == '*n') {
			inword = 0;
		} else {
			if (inword == 0) words = words + 1;
			inword = 1;
		}
	}
done:
	printn(lines, 10); putchar(' ');
	printn(words, 10); putchar(' ');
	printn(chars, 10); putchar('*n');
}
