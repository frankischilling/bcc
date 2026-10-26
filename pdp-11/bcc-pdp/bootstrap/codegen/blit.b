/* Stream literal occurrences into separate writable assembly data blocks. */
nstr 0;

litinl(len, bytes) {
    extrn nstr;
    auto id, j, b;
    id = nstr;
    if (id >= 32767) fatal("string pool full");
    nstr = nstr + 1;
    bouts("*n.text*n");
    bouts("*tjmp*tL");spref();
    outd(id);
    outc('*n');
    spref();
    outd(id);
    bouts(":*n*t.byte*t");
    j = 0;
    while (j < len) {
        {
            if (j) outc(',');
            b = char(bytes, j) & 0377;
            outd(b);
            outc('.');
            j = j + 1;
        }
    }
    outc('*n');
    bouts("*t.even*n");
    bouts("L");spref();
    outd(id);
    bouts(":*n");
    return(id);
}
