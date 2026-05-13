/* printfdemo.b - every printf format spec from kbman §9.3.
 * Output:  d=42 o=52 c=A s=hello*n
 */
main() {
	extrn printf;
	printf("d=%d o=%o c=%c s=%s*n", 42, 42, 'A', "hello");
}
