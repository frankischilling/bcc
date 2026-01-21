/* String handling conformance test
 * Tests B string conventions:
 * - *e (EOT) termination
 * - char/lchar byte access
 * - String literals
 */

/* String length */
b_strlen(s) {
    auto len;
    len = 0;
    while (char(s, len) != '*e')
        len =+ 1;
    return(len);
}

/* String compare */
b_strcmp(s1, s2) {
    auto i, c1, c2;
    i = 0;
    while (1) {
        c1 = char(s1, i);
        c2 = char(s2, i);
        if (c1 != c2)
            return(c1 - c2);
        if (c1 == '*e')
            return(0);
        i =+ 1;
    }
}

/* String copy */
b_strcpy(dest, src) {
    auto i, c;
    i = 0;
    while ((c = char(src, i)) != '*e') {
        lchar(dest, i, c);
        i =+ 1;
    }
    lchar(dest, i, '*e');
    return(dest);
}

/* String concatenate */
b_strcat(dest, src) {
    auto i, j, c;
    i = b_strlen(dest);
    j = 0;
    while ((c = char(src, j)) != '*e') {
        lchar(dest, i, c);
        i =+ 1;
        j =+ 1;
    }
    lchar(dest, i, '*e');
    return(dest);
}

/* Find character in string */
b_strchr(s, c) {
    auto i, ch;
    i = 0;
    while ((ch = char(s, i)) != '*e') {
        if (ch == c)
            return(i);
        i =+ 1;
    }
    return(-1);
}

main() {
    auto buf[20], buf2[20];

    /* Test 1: String literal length */
    if (b_strlen("hello") != 5) return(1);

    /* Test 2: Empty string */
    if (b_strlen("") != 0) return(2);

    /* Test 3: String with escape */
    if (b_strlen("ab*ncd") != 5) return(3);

    /* Test 4-5: strcmp equal strings */
    if (b_strcmp("hello", "hello") != 0) return(4);
    if (b_strcmp("", "") != 0) return(5);

    /* Test 6-7: strcmp different strings */
    if (b_strcmp("abc", "abd") >= 0) return(6);
    if (b_strcmp("abd", "abc") <= 0) return(7);

    /* Test 8: strcmp different lengths */
    if (b_strcmp("ab", "abc") >= 0) return(8);
    if (b_strcmp("abc", "ab") <= 0) return(9);

    /* Test 10: strcpy basic */
    b_strcpy(buf, "test");
    if (b_strcmp(buf, "test") != 0) return(10);

    /* Test 11: strcpy preserves terminator */
    if (b_strlen(buf) != 4) return(11);

    /* Test 12: strcpy empty string */
    b_strcpy(buf, "");
    if (b_strlen(buf) != 0) return(12);

    /* Test 13: strcat basic */
    b_strcpy(buf, "hello");
    b_strcat(buf, " world");
    if (b_strcmp(buf, "hello world") != 0) return(13);

    /* Test 14: strcat to empty */
    b_strcpy(buf, "");
    b_strcat(buf, "test");
    if (b_strcmp(buf, "test") != 0) return(14);

    /* Test 15: strcat empty */
    b_strcpy(buf, "test");
    b_strcat(buf, "");
    if (b_strcmp(buf, "test") != 0) return(15);

    /* Test 16-17: strchr found */
    b_strcpy(buf, "hello");
    if (b_strchr(buf, 'e') != 1) return(16);
    if (b_strchr(buf, 'o') != 4) return(17);

    /* Test 18: strchr not found */
    if (b_strchr(buf, 'x') != -1) return(18);

    /* Test 19: strchr first char */
    if (b_strchr(buf, 'h') != 0) return(19);

    /* Test 20: Build string manually */
    lchar(buf, 0, 'A');
    lchar(buf, 1, 'B');
    lchar(buf, 2, 'C');
    lchar(buf, 3, '*e');
    if (b_strcmp(buf, "ABC") != 0) return(20);

    /* Test 21: Modify string in place */
    b_strcpy(buf, "hello");
    lchar(buf, 0, 'H');
    if (b_strcmp(buf, "Hello") != 0) return(21);

    /* Test 22: Multiple string operations */
    b_strcpy(buf, "one");
    b_strcpy(buf2, "two");
    b_strcat(buf, " ");
    b_strcat(buf, buf2);
    if (b_strcmp(buf, "one two") != 0) return(22);

    return(0);
}

