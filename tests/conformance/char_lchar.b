/* char/lchar conformance test
 * Tests byte access within words using char() and lchar()
 * These are critical B library functions for string manipulation
 */

main() {
    auto buf[10];
    auto i, c;

    /* Test 1: Basic lchar/char round-trip */
    lchar(buf, 0, 'H');
    lchar(buf, 1, 'e');
    lchar(buf, 2, 'l');
    lchar(buf, 3, 'l');
    lchar(buf, 4, 'o');
    lchar(buf, 5, '*e');

    if (char(buf, 0) != 'H') return(1);
    if (char(buf, 1) != 'e') return(2);
    if (char(buf, 2) != 'l') return(3);
    if (char(buf, 3) != 'l') return(4);
    if (char(buf, 4) != 'o') return(5);
    if (char(buf, 5) != '*e') return(6);

    /* Test 2: Overwrite characters */
    lchar(buf, 0, 'J');
    lchar(buf, 4, 'y');
    if (char(buf, 0) != 'J') return(7);
    if (char(buf, 4) != 'y') return(8);

    /* Test 3: Byte values 0-255 */
    lchar(buf, 0, 0);
    if (char(buf, 0) != 0) return(9);

    lchar(buf, 0, 255);
    if (char(buf, 0) != 255) return(10);

    lchar(buf, 0, 127);
    if (char(buf, 0) != 127) return(11);

    lchar(buf, 0, 128);
    if (char(buf, 0) != 128) return(12);

    /* Test 4: Sequential byte positions across word boundaries */
    i = 0;
    while (i < 20) {
        lchar(buf, i, i + 65);  /* 'A', 'B', 'C', ... */
        i =+ 1;
    }
    i = 0;
    while (i < 20) {
        if (char(buf, i) != i + 65) return(13);
        i =+ 1;
    }

    /* Test 5: lchar returns the character set */
    c = lchar(buf, 0, 'X');
    if (c != 'X') return(14);

    /* All tests passed */
    return(0);
}

