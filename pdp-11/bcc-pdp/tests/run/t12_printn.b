/* t12 -- printn from libb.b (kbman §9.1).  Output: 255\n377\n */
main() {
	extrn putchar, printn;
	printn(255, 10);  putchar('*n');
	printn(255, 8);   putchar('*n');
}
