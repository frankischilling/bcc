/* t13 -- printf from libb.b (kbman §9.3) - every format spec.
 * Output: d=42 o=52 c=A s=hello\n
 */
main() {
	extrn printf;
	printf("d=%d o=%o c=%c s=%s*n", 42, 42, 'A', "hello");
}
