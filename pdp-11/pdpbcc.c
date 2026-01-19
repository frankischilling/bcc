/*
 * Minimal skeleton for a B compiler in early PDP-11 C (2nd-ed / 1972-ish).
 * Notes:
 *   - no preprocessor (#define, #include, etc.)
 *   - no struct (in the earlier compiler)
 *   - pointer declarations use [] (e.g. char s[];) instead of char *s;
 */

 strlen(s)
 char s[];
 {
     int n;
     n = 0;
     while (s[n])
         n++;
     return n;
 }
 
 out(fd, s)
 char s[];
 {
     extern write;
     write(fd, s, strlen(s));
 }
 
 outc(fd, c)
 {
     extern write;
     char b[1];
     b[0] = c;
     write(fd, b, 1);
 }
 
 char ibuf[512];
 int ip, ilen;
 int unch;
 
 getch()
 {
     extern read;
     if (ip >= ilen) {
         ilen = read(0, ibuf, 512);
         ip = 0;
         if (ilen <= 0)
             return -1;
     }
     return ibuf[ip++] & 0377;
 }
 
 ungetch(c)
 {
     unch = c;
 }
 
 next_char()
 {
     int c;
     if (unch != -1) {
         c = unch;
         unch = -1;
         return c;
     }
     return getch();
 }
 
 /* Token state (no struct) */
 int curkind;
 int curnum;
 char curtext[64];
 
 nexttok()
 {
     int c;
 
     for (;;) {
         c = next_char();
         if (c < 0) {
             curkind = 0;   /* EOF */
             return;
         }
         if (c == ' ' || c == '\t' || c == '\n' || c == '\r')
             continue;
 
         curkind = 4;      /* “op” / single-char token */
         curtext[0] = c;
         curtext[1] = 0;
         return;
     }
 }
 
 emit_header()
 {
     out(1, ".text\n.globl _main\n_main:\n");
     out(1, "mov r5,-(sp)\n");
     out(1, "mov sp,r5\n");
 }
 
 emit_footer()
 {
     out(1, "clr r0\n");
     out(1, "mov (sp)+,r5\n");
     out(1, "rts pc\n");
 }
 
 parse_program()
 {
     nexttok();
     while (curkind != 0)
         nexttok();
 }
 
 main(argc, argv)
 int argv[];
 {
     extern exit;
 
     ip = 0;
     ilen = 0;
     unch = -1;
 
     emit_header();
     parse_program();
     emit_footer();
     exit(0);
 }
 