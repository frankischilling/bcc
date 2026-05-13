/* cat.b - concatenate stdin (or argv files) to stdout.  V1 utility port. */
buf[64];          /* 128-byte read buffer (vector size = 64 words) */

cpfd(fd) {
	extrn read, write, buf;
	auto n;
	while (1) {
		n = read(fd, buf, 128);
		if (n <= 0) return;
		write(1, buf, n);
	}
}

main() {
	extrn argv, open, close, cpfd, write;
	auto i, n, fd;
	n = argv[0];
	if (n == 0) {
		cpfd(0);
		return;
	}
	i = 1;
	while (i <= n) {
		fd = open(argv[i], 0);
		if (fd < 0) {
			write(2, "cat: open*n", 11);
			return;
		}
		cpfd(fd);
		close(fd);
		i = i + 1;
	}
}
