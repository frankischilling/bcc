/* Host-word literals must survive all B compiler stages, including globals. */
minimum 9223372036854775808;
octal 01000000000000000000000;
values[] 9223372036854775808, 9223372036854775807, 18446744073709551615;
main() {
    extrn minimum,octal,values;
    auto want;
    want= -9223372036854775807-1;
    return(minimum!=want | octal!=want | values[0]!=want |
           values[1]!=9223372036854775807 | values[2]!= -1 |
           -9223372036854775808!=want | 9223372036854775808/-1!=want);
}
