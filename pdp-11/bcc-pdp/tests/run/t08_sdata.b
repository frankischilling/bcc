msg[3] 'O','K','*n';

main() {
	extrn msg, putchar;
	auto i;
	i = 0;
	while (i < 3) {
		putchar(msg[i]);
		i++;
	}
	return(0);
}
