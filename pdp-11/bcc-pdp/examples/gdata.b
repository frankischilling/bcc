msg[8] 'g','l','o','b','a','l','*n',0;

main() {
	auto i;
	i = 0;
	while (msg[i]) {
		putchar(msg[i]);
		i++;
	}
}
