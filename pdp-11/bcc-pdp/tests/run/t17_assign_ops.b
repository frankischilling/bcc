/* t17 -- exercise all 16 kbman §4.11 compound assignment operators
 *   = =| =& === =!= =< =<= => =>= =<< =>> =+ =- =% =* =/
 *
 * For each op: set x to a known LHS, apply op with known RHS, compare
 * to expected, emit '+' on pass / '-' on fail.  Output: 16 '+' + newline.
 */
chk(act, exp) {
	extrn putchar;
	if (act == exp) putchar('+');
	else            putchar('-');
}

main() {
	extrn putchar, chk;
	auto x;

	x = 5;             chk(x, 5);                /* =          */
	x = 0;  x =| 6;    chk(x, 6);                /* =| (or)    */
	x = 7;  x =& 6;    chk(x, 6);                /* =& (and)   */
	x = 4;  x === 4;   chk(x, 1);                /* === (==)   */
	x = 4;  x =!= 4;   chk(x, 0);                /* =!= (!=)   */
	x = 1;  x =< 9;    chk(x, 1);                /* =<         */
	x = 9;  x =<= 9;   chk(x, 1);                /* =<=        */
	x = 9;  x => 1;    chk(x, 1);                /* =>         */
	x = 1;  x =>= 9;   chk(x, 0);                /* =>=        */
	x = 1;  x =<< 3;   chk(x, 8);                /* =<<        */
	x = 16; x =>> 2;   chk(x, 4);                /* =>>        */
	x = 5;  x =+ 7;    chk(x, 12);               /* =+         */
	x = 10; x =- 3;    chk(x, 7);                /* =-         */
	x = 5;  x =% 3;    chk(x, 2);                /* =%         */
	x = 6;  x =* 7;    chk(x, 42);               /* =*         */
	x = 20; x =/ 4;    chk(x, 5);                /* =/         */

	putchar('*n');
}
