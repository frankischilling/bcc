/*
 * libb.c - B Runtime Library Implementation
 * 
 * This file contains all runtime functions needed by B programs.
 * It is compiled separately and linked with generated B code.
 */

#include "libb.h"

/* ===== Global I/O State ===== */

int b_rd_fd = 0;     /* current input fd */
int b_wr_fd = 1;     /* current output fd */
word b_rd_unit = 0;  /* exposed to B if needed */
word b_wr_unit = -1;

static void __b_sync_rd(void) {
    if (b_rd_unit < 0) {
        if (b_rd_fd != 0 && b_rd_fd > 2) close(b_rd_fd);
        b_rd_fd = 0;
    } else if (b_rd_fd != (int)b_rd_unit) {
        b_rd_fd = (int)b_rd_unit;
    }
}

static void __b_sync_wr(void) {
    if (b_wr_unit < 0) {
        if (b_wr_fd != 1 && b_wr_fd > 2) close(b_wr_fd);
        b_wr_fd = 1;
    } else if (b_wr_fd != (int)b_wr_unit) {
        b_wr_fd = (int)b_wr_unit;
    }
}

/* ===== Basic I/O ===== */

word b_print(word x) {
    __b_sync_wr();
    char buf[64];
    int n = snprintf(buf, sizeof(buf), "%" PRIdPTR "\n", (intptr_t)x);
    if (n > 0) (void)write(b_wr_fd, buf, (size_t)n);
    return x;
}

word b_putchar(word c) {
    __b_sync_wr();
    unsigned char ch = (unsigned char)(c & 0xFF);
    (void)write(b_wr_fd, &ch, 1);
    return c;
}

word b_getchar(void) {
    __b_sync_rd();
    unsigned char c;
    ssize_t n = read(b_rd_fd, &c, 1);
    if (n == 1) return (word)c;
    if (b_rd_fd != 0) {
        close(b_rd_fd);
        b_rd_fd = 0;
        b_rd_unit = -1;
        return b_getchar();
    }
    return (word)004; /* EOT on EOF */
}

word b_putchr(word c) {
    __b_sync_wr();
    unsigned char ch = (unsigned char)(c & 0xFF);
    (void)write(b_wr_fd, &ch, 1);
    return c;
}

word b_getchr(void) {
    __b_sync_rd();
    unsigned char c;
    ssize_t n = read(b_rd_fd, &c, 1);
    if (n == 1) return (word)c;
    if (b_rd_fd != 0) {
        close(b_rd_fd);
        b_rd_fd = 0;
        b_rd_unit = -1;
        return b_getchr();
    }
    return (word)004;
}

word b_putstr(word s) {
    __b_sync_wr();
    word i = 0;
    for (;;) {
        word ch = b_char(s, i++);
        if (ch == 004 || ch == 0) break;
        b_putchar(ch);
    }
    return s;
}

word b_getstr(word buf) {
    __b_sync_rd();
    size_t i = 0;
    unsigned char c;
    for (;;) {
        ssize_t n = read(b_rd_fd, &c, 1);
        if (n == 1 && c != '\n' && c != '\r') {
            b_lchar(buf, (word)i, (word)c);
            i++;
            continue;
        }
        if (n == 1) break; /* newline */
        if (b_rd_fd != 0) {
            close(b_rd_fd);
            b_rd_fd = 0;
            b_rd_unit = -1;
            continue; /* retry on terminal */
        }
        break; /* EOF */
    }
    b_lchar(buf, (word)i, (word)004);
    return buf;
}

word b_flush(void) {
    __b_sync_wr();
    if (b_wr_fd == 1) {
        fflush(stdout);
    } else {
        fsync(b_wr_fd);
    }
    return 0;
}

/* ===== Exit/Control ===== */

word b_exit(word code) {
    exit((int)code);
    return 0;
}

word b_abort(void) {
    abort();
    return 0;
}

word b_free(word p) {
    free(B_CPTR(p));
    return 0;
}

/* ===== Memory Allocation ===== */

word b_alloc(word nwords) {
    size_t bytes = (size_t)nwords * sizeof(word);
    void *p = malloc(bytes);
    if (!p) {
        fprintf(stderr, "alloc: out of memory\n");
        exit(1);
    }
    return B_PTR(p);
}

/* ===== Low-Level Memory Operations ===== */

word b_load(word addr) {
    return B_DEREF(addr);
}

void b_store(word addr, word v) {
#if B_BYTEPTR
    *(word*)(uword)addr = v;
#else
    *(word*)(uword)((uword)addr * sizeof(word)) = v;
#endif
}

/* ===== String/Character Operations ===== */

/*
 * B string access - byte packing within words.
 * In B_BYTEPTR=0 mode, bytes are packed into words with byte 0 at the LSB.
 */
word b_char(word s, word i) {
#if B_BYTEPTR
    const unsigned char *p = (const unsigned char*)B_CPTR(s);
    return (word)p[(size_t)i];
#else
    const uword W = (uword)sizeof(word);
    uword wi = (uword)i / W;
    uword bi = (uword)i % W;
    uword w  = (uword)b_load((word)(s + (word)wi));
    return (word)((w >> (bi * 8)) & 0xFF);
#endif
}

word b_lchar(word s, word i, word c) {
#if B_BYTEPTR
    unsigned char *p = (unsigned char*)B_CPTR(s);
    p[(size_t)i] = (unsigned char)(c & 0xFF);
    return c;
#else
    const uword W = (uword)sizeof(word);
    uword wi = (uword)i / W;
    uword bi = (uword)i % W;

    word addr = (word)(s + (word)wi);
    uword w   = (uword)b_load(addr);

    uword mask = (uword)0xFF << (bi * 8);
    w = (w & ~mask) | (((uword)c & 0xFF) << (bi * 8));

    b_store(addr, (word)w);
    return c;
#endif
}

/* Convert a B string (004-terminated) into a temporary NUL-terminated C string */
const char *__b_cstr(word s) {
    static char *slots[4];
    static size_t caps[4];
    static int next = 0;

    if (s == 0) return "";

    size_t len = 0;
    for (;; len++) {
        word ch = b_char(s, (word)len);
        if (ch == 004 || ch == 0) break;
    }

    int idx = next;
    next = (next + 1) & 3; /* simple ring buffer */

    size_t need = len + 1;
    if (need > caps[idx]) {
        size_t ncap = need < 64 ? 64 : need;
        char *nb = (char*)realloc(slots[idx], ncap);
        if (!nb) {
            fprintf(stderr, "cstr: out of memory\n");
            exit(1);
        }
        slots[idx] = nb;
        caps[idx] = ncap;
    }

    for (size_t i = 0; i < len; i++)
        slots[idx][i] = (char)(b_char(s, (word)i) & 0xFF);
    slots[idx][len] = 0;
    return slots[idx];
}

/* Duplicate a B string into a freshly allocated C string */
char *__b_dup_bstr(word s) {
    size_t cap = 64;
    char *buf = (char*)malloc(cap);
    if (!buf) {
        fprintf(stderr, "system: out of memory\n");
        exit(1);
    }

    size_t i = 0;
    for (;;) {
        word ch = b_char(s, (word)i);
        if (ch == 004 || ch == 0) break;
        if (i + 1 >= cap) {
            size_t ncap = cap * 2;
            char *nbuf = (char*)realloc(buf, ncap);
            if (!nbuf) {
                free(buf);
                fprintf(stderr, "system: out of memory\n");
                exit(1);
            }
            buf = nbuf;
            cap = ncap;
        }
        buf[i++] = (char)(ch & 0xFF);
    }
    buf[i] = 0;
    return buf;
}

void __b_bstr_to_cstr(word s, char *buf, size_t max) {
    size_t i = 0;
    while (i + 1 < max) {
        word ch = b_char(s, (word)i);
        if (ch == 004 || ch == 0) break;
        buf[i++] = (char)(ch & 0xFF);
    }
    buf[i] = 0;
}

word __b_pack_cstr(const char *s) {
    size_t n = strlen(s);
    size_t W = sizeof(word);
    size_t total = n + 1;  /* +1 for 004 terminator */
    size_t words = (total + W - 1) / W;

    word bp = b_alloc((word)words);

    for (size_t i = 0; i < n; i++) {
        b_lchar(bp, (word)i, (word)(unsigned char)s[i]);
    }
    b_lchar(bp, (word)n, (word)004);
    return bp;
}

/* ===== Printf Family ===== */

static void b_printn_u(word n, word base) {
    word a = (word)((uword)n / (uword)base);
    if (a) b_printn_u(a, base);
    b_putchar((word)((uword)n % (uword)base) + '0');
}

word b_printf(word fmt, ...) {
    va_list ap;
    va_start(ap, fmt);

    word i = 0;
    for (;;) {
        word ch = b_char(fmt, i++);
        if (ch == 004 || ch == 0) break;
        if (ch != '%') {
            b_putchar(ch);
            continue;
        }

        word code = b_char(fmt, i++);
        if (code == 004) break;

        word arg = va_arg(ap, word);

        switch ((int)code) {
        case 'd': {
#if WORD_BITS == 16
            int16_t v = (int16_t)arg;
            if (v < 0) { b_putchar('-'); v = (int16_t)-v; }
            if (v) b_printn_u((word)(uword)(uint16_t)v, 10);
#elif WORD_BITS == 32
            int32_t v = (int32_t)arg;
            if (v < 0) { b_putchar('-'); v = -v; }
            if (v) b_printn_u((word)(uword)(uint32_t)v, 10);
#else
            word v = arg;
            if (v < 0) { b_putchar('-'); v = -v; }
            if (v) b_printn_u((word)(uword)v, 10);
#endif
            else b_putchar('0');
            break;
        }
        case 'o': {
#if WORD_BITS == 16
            uint16_t v = (uint16_t)arg;
#elif WORD_BITS == 32
            uint32_t v = (uint32_t)arg;
#else
            uword v = (uword)arg;
#endif
            if (v) b_printn_u((word)(uword)v, 8);
            else b_putchar('0');
            break;
        }
        case 'u': {
            uword v = (uword)arg;
            if (v) b_printn_u((word)v, 10);
            else b_putchar('0');
            break;
        }
        case 'p': {
            uword v = (uword)arg;
            b_putchar('0'); b_putchar('x');
            int started = 0;
            for (int shift = (int)(sizeof(uword)*8 - 4); shift >= 0; shift -= 4) {
                int nib = (int)((v >> shift) & 0xF);
                if (!started && nib == 0 && shift > 0) continue;
                started = 1;
                b_putchar((word)(nib < 10 ? ('0' + nib) : ('a' + nib - 10)));
            }
            if (!started) b_putchar('0');
            break;
        }
        case 'z': {
            word mod = b_char(fmt, i++);
            if (mod == 'u') {
                uword v = (uword)arg;
                if (v) b_printn_u((word)v, 10);
                else b_putchar('0');
            } else if (mod == 'd') {
                long v = (long)arg;
                if (v < 0) { b_putchar('-'); v = -v; }
                if (v) b_printn_u((word)(uword)v, 10);
                else b_putchar('0');
            } else {
                b_putchar('%'); b_putchar('z'); b_putchar(mod);
            }
            break;
        }
        case 'c':
            b_putchar(arg);
            break;
        case 's': {
            word j = 0;
            for (;;) {
                word sc = b_char(arg, j++);
                if (sc == 004 || sc == 0) break;
                b_putchar(sc);
            }
            break;
        }
        default:
            b_putchar('%'); b_putchar(code);
            break;
        }
    }

    va_end(ap);
    return 0;
}

word b_printn(word n, word base) {
    if (base == 10 && (int16_t)n < 0) {
        b_putchar('-');
        n = (word)(-(int16_t)n);
    }
    b_printn_u(n, base);
    return n;
}

word b_putnum(word n) {
    b_printn(n, (word)10);
    return n;
}

/* ===== Command Line Arguments ===== */

static int __b_argc;
static char **__b_argv;
static word *__b_argvb;

void __b_setargs(int argc, char **argv) {
    __b_argc = argc;
    __b_argv = argv;

    __b_argvb = (word*)malloc(sizeof(word) * (size_t)argc);
    if (!__b_argvb) {
        fprintf(stderr, "argv: out of memory\n");
        exit(1);
    }

    for (int i = 0; i < argc; i++) {
        __b_argvb[i] = __b_pack_cstr(argv[i]);
    }
}

word b_argc(void) {
    return (word)__b_argc;
}

word b_argv(word i) {
    int idx = (int)i;
    if (idx < 0 || idx >= __b_argc) return 0;
    return __b_argvb[idx];
}

word b_reread(void) {
    if (__b_argc <= 1) {
        return 0;
    }

    size_t total = 1;
    for (int i = 0; i < __b_argc; i++) {
        total += strlen(__b_argv[i]);
        if (i + 1 < __b_argc) total += 1;
    }
    
    char *buf = (char*)malloc(total + 1);
    if (!buf) {
        fprintf(stderr, "reread: out of memory\n");
        exit(1);
    }
    
    size_t pos = 0;
    for (int i = 0; i < __b_argc; i++) {
        size_t len = strlen(__b_argv[i]);
        memcpy(buf + pos, __b_argv[i], len);
        pos += len;
        if (i + 1 < __b_argc) buf[pos++] = ' ';
    }
    buf[pos++] = '\n';
    buf[pos] = '\0';
    
    int p[2];
    if (pipe(p) != 0) {
        free(buf);
        fprintf(stderr, "reread: pipe failed\n");
        exit(1);
    }
    ssize_t wn = write(p[1], buf, pos);
    (void)wn;
    close(p[1]);
    free(buf);
    
    if (b_rd_fd != 0 && b_rd_fd != p[0]) close(b_rd_fd);
    b_rd_fd = p[0];
    b_rd_unit = (word)0;
    __b_sync_rd();
    return 0;
}

/* ===== File I/O ===== */

word b_open(word name, word mode) {
    const char *p = (const char*)B_CPTR(name);
    int flags = ((int)mode == 0) ? O_RDONLY : O_WRONLY;
    return (word)open(p, flags);
}

word b_openr(word fd, word name) {
    char buf[512];
    __b_bstr_to_cstr(name, buf, sizeof(buf));
    int target = (int)fd;
    if (target < 0 || buf[0] == '\0') {
        b_rd_fd = 0; b_rd_unit = -1; return 0;
    }
    int newfd = open(buf, O_RDONLY);
    if (b_rd_fd != 0 && b_rd_fd != target) close(b_rd_fd);
    if (newfd < 0) { b_rd_fd = -1; b_rd_unit = (word)target; return -1; }
    if (newfd != target) {
        if (dup2(newfd, target) < 0) { close(newfd); return -1; }
        close(newfd);
        newfd = target;
    }
    b_rd_fd = newfd;
    b_rd_unit = (word)target;
    return (word)newfd;
}

word b_openw(word fd, word name) {
    char buf[512];
    __b_bstr_to_cstr(name, buf, sizeof(buf));
    int target = (int)fd;
    if (target < 0 || buf[0] == '\0') {
        b_wr_fd = 1; b_wr_unit = -1; return 1;
    }
    int newfd = open(buf, O_WRONLY | O_CREAT | O_TRUNC, 0666);
    if (newfd < 0) return -1;
    if (b_wr_fd != 1 && b_wr_fd != target && b_wr_fd != newfd) close(b_wr_fd);
    if (newfd != target) {
        if (dup2(newfd, target) < 0) { close(newfd); return -1; }
        close(newfd);
        newfd = target;
    }
    b_wr_fd = newfd;
    b_wr_unit = (word)target;
    return (word)newfd;
}

word b_close(word fd) {
    int cfd = (int)fd;
    word r = (word)close(cfd);
    if (r == 0) {
        if (cfd == b_rd_fd || cfd == (int)b_rd_unit) { b_rd_fd = 0; b_rd_unit = -1; }
        if (cfd == b_wr_fd || cfd == (int)b_wr_unit) { b_wr_fd = 1; b_wr_unit = -1; }
    }
    return r;
}

word b_read(word fd, word buf, word n) {
    char *p = (char*)B_CPTR(buf);
    if ((size_t)n < sizeof(word)) memset(p, 0, sizeof(word));
    return (word)read((int)fd, p, (size_t)n);
}

word b_write(word fd, word buf, word n) {
    const char *p = (const char*)B_CPTR(buf);
    return (word)write((int)fd, p, (size_t)n);
}

word b_creat(word name, word mode) {
    const char *p = (const char*)B_CPTR(name);
    return (word)creat(p, (mode_t)mode);
}

word b_seek(word fd, word offset, word whence) {
    off_t r = lseek((int)fd, (off_t)offset, (int)whence);
    return (r < 0) ? (word)-1 : (word)0;
}

/* ===== Process Control ===== */

word b_fork(void) {
    return (word)fork();
}

static word __b_wait_status;

word b_wait(void) {
    int st = 0;
    pid_t pid = wait(&st);
    __b_wait_status = (word)st;
    return (word)pid;
}

word b_execl(word path, ...) {
    const char *p = (const char*)B_CPTR(path);

    char *argv[64];
    int i = 0;
    argv[i++] = (char*)p;

    va_list ap;
    va_start(ap, path);
    for (; i < 63; ) {
        word w = va_arg(ap, word);
        if (w == 0) break;
        argv[i++] = (char*)B_CPTR(w);
    }
    va_end(ap);

    argv[i] = NULL;
    execv(p, argv);
    return -1;
}

word b_execv(word path, word argv) {
    const char *p = (const char*)B_CPTR(path);
    word *av = (word*)B_CPTR(argv);

    char *cargv[256];
    int i = 0;
    for (; i < 255 && av[i] != 0; i++)
        cargv[i] = (char*)B_CPTR(av[i]);
    cargv[i] = NULL;

    execv(p, cargv);
    return -1;
}

word b_system(word cmd) {
    char *line = __b_dup_bstr(cmd);
    if (!line) return -1;

    char *argv[128];
    size_t argc = 0;
    char *p = line;

    while (*p) {
        while (*p && isspace((unsigned char)*p)) p++;
        if (!*p) break;
        if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free(line); return -1; }
        argv[argc++] = p;
        while (*p && !isspace((unsigned char)*p)) p++;
        if (*p) { *p = 0; p++; }
    }

    if (argc == 0) { free(line); return -1; }
    argv[argc] = NULL;

    pid_t pid = fork();
    if (pid == 0) {
        execvp(argv[0], argv);
        _exit(127);
    }
    if (pid < 0) { free(line); return -1; }

    int st = 0;
    pid_t w = waitpid(pid, &st, 0);
    free(line);
    if (w < 0) return -1;
    return (word)st;
}

/* ===== Time/Delay ===== */

word b_usleep(word usec) {
    usleep((useconds_t)usec);
    return 0;
}

word b_time(word tvp) {
    time_t now = time(NULL);
    if (tvp) {
        uint16_t lo = (uint16_t)(now & 0xFFFF);
        uint16_t hi = (uint16_t)((now >> 16) & 0xFFFF);
        word *tv = (word*)B_CPTR(tvp);
        tv[0] = (word)(uword)lo;
        tv[1] = (word)(uword)hi;
    }
    return 0;
}

word b_ctime(word tvp) {
    static word bufw[32];
    word *tv = (word*)B_CPTR(tvp);
    time_t t = (time_t)((uint16_t)tv[0]) | ((time_t)((uint16_t)tv[1]) << 16);

    const char *cs = ctime(&t);
    if (!cs) return 0;

    size_t i = 0;
    while (cs[i] && cs[i] != '\n' && i < 63) {
        b_lchar(B_PTR(bufw), (word)i, (word)(unsigned char)cs[i]);
        i++;
    }
    b_lchar(B_PTR(bufw), (word)i, 004);
    return B_PTR(bufw);
}

/* ===== System Functions ===== */

word b_getuid(void) {
    return (word)getuid();
}

word b_setuid(word uid) {
    return (word)setuid((uid_t)uid);
}

word b_chdir(word path) {
    const char *p = (const char*)B_CPTR(path);
    return (word)chdir(p);
}

word b_chmod(word path, word mode) {
    const char *p = (const char*)B_CPTR(path);
    return (word)chmod(p, (mode_t)mode);
}

word b_chown(word path, word owner) {
    const char *p = (const char*)B_CPTR(path);
    return (word)chown(p, (uid_t)owner, (gid_t)-1);
}

word b_link(word old, word new) {
    const char *o = (const char*)B_CPTR(old);
    const char *n = (const char*)B_CPTR(new);
    return (word)link(o, n);
}

word b_unlink(word path) {
    const char *p = (const char*)B_CPTR(path);
    return (word)unlink(p);
}

word b_stat(word path, word bufp) {
    const char *p = (const char*)B_CPTR(path);
    struct stat st;
    if (stat(p, &st) != 0) return -1;
    if (bufp) {
        unsigned char *b = (unsigned char*)B_CPTR(bufp);
        for (int i = 0; i < 20*(int)sizeof(word); i++) b[i] = 0;
        size_t n = sizeof(st);
        if (n > 20*sizeof(word)) n = 20*sizeof(word);
        memcpy(b, &st, n);
    }
    return 0;
}

word b_fstat(word fd, word bufp) {
    struct stat st;
    if (fstat((int)fd, &st) != 0) return -1;
    if (bufp) {
        unsigned char *b = (unsigned char*)B_CPTR(bufp);
        for (int i = 0; i < 20*(int)sizeof(word); i++) b[i] = 0;
        size_t n = sizeof(st);
        if (n > 20*sizeof(word)) n = 20*sizeof(word);
        memcpy(b, &st, n);
    }
    return 0;
}

word b_makdir(word path, word mode) {
    const char *p = (const char*)B_CPTR(path);
    return (word)mkdir(p, (mode_t)mode);
}

/* ===== Terminal I/O ===== */

word b_gtty(word fd, word ttstat) {
    struct termios t;
    if (tcgetattr((int)fd, &t) < 0) return -1;

    word *vec = (word*)B_CPTR(ttstat);
    vec[0] = (word)t.c_iflag;
    vec[1] = (word)t.c_oflag;
    vec[2] = (word)t.c_lflag;
    return 0;
}

word b_stty(word fd, word ttstat) {
    struct termios t;
    if (tcgetattr((int)fd, &t) < 0) return -1;

    word *vec = (word*)B_CPTR(ttstat);
    t.c_iflag = (tcflag_t)vec[0];
    t.c_oflag = (tcflag_t)vec[1];
    t.c_lflag = (tcflag_t)vec[2];
    return (word)tcsetattr((int)fd, TCSANOW, &t);
}

static volatile sig_atomic_t __b_got_intr = 0;
static void __b_sigint(int sig) { (void)sig; __b_got_intr = 1; }

word b_intr(word on) {
    if (on) {
        __b_got_intr = 0;
        if (signal(SIGINT, __b_sigint) == SIG_ERR) return -1;
    } else {
        if (signal(SIGINT, SIG_DFL) == SIG_ERR) return -1;
    }
    return 0;
}

/* ===== Dynamic Function Calls ===== */

word b_callf_dispatch(int nargs, word name, ...) {
    static int __b_callf_dl_done = 0;
    if (!__b_callf_dl_done) {
        __b_callf_dl_done = 1;
        const char *env = getenv("B_CALLF_LIB");
        if (env && *env) {
            const char *p = env;
            while (*p) {
                const char *start = p;
                while (*p && *p != ':') p++;
                size_t len = (size_t)(p - start);
                if (len) {
                    char *path = (char*)malloc(len + 1);
                    if (path) {
                        memcpy(path, start, len);
                        path[len] = '\0';
                        (void)dlopen(path, RTLD_NOW | RTLD_GLOBAL);
                        free(path);
                    }
                }
                if (*p == ':') p++;
            }
        }
    }
    if (nargs < 0 || nargs > 10) return -1;
    if (name == 0) return -1;
 
    char sym[256];
    __b_bstr_to_cstr(name, sym, sizeof(sym));
 
    void *fn = dlsym(RTLD_DEFAULT, sym);
    if (!fn) {
        size_t len = strlen(sym);
        if (len + 2 < sizeof(sym)) {
            sym[len] = '_'; sym[len + 1] = '\0';
            fn = dlsym(RTLD_DEFAULT, sym);
            sym[len] = '\0';
        }
    }
    if (!fn) return -1;
 
    void *args[10] = {0};
    va_list ap;
    va_start(ap, name);
    for (int i = 0; i < nargs && i < 10; i++) {
        word w = va_arg(ap, word);
        args[i] = B_CPTR(w);
    }
    va_end(ap);
 
    word r = 0;
    switch (nargs) {
    case 0: r = ((word (*)(void))fn)(); break;
    case 1: r = ((word (*)(void*))fn)(args[0]); break;
    case 2: r = ((word (*)(void*, void*))fn)(args[0], args[1]); break;
    case 3: r = ((word (*)(void*, void*, void*))fn)(args[0], args[1], args[2]); break;
    case 4: r = ((word (*)(void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3]); break;
    case 5: r = ((word (*)(void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4]); break;
    case 6: r = ((word (*)(void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5]); break;
    case 7: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6]); break;
    case 8: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]); break;
    case 9: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]); break;
    case 10: r = ((word (*)(void*, void*, void*, void*, void*, void*, void*, void*, void*, void*))fn)(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]); break;
    default: return -1;
    }
    return r;
}

/* ===== Math/Compatibility Helpers ===== */

word sx64(word x) {
    return (word)(int16_t)(x & 0xFFFF);
}

/* ===== Helper Functions for Complex Lvalue Operations ===== */

word b_preinc(word *p) { return (*p = WVAL((uword)*p + 1)); }
word b_predec(word *p) { return (*p = WVAL((uword)*p - 1)); }
word b_postinc(word *p) { word old = WVAL(*p); *p = WVAL((uword)*p + 1); return old; }
word b_postdec(word *p) { word old = WVAL(*p); *p = WVAL((uword)*p - 1); return old; }
word b_add_assign(word *p, word v) { return (*p = WVAL((uword)*p + (uword)v)); }
word b_sub_assign(word *p, word v) { return (*p = WVAL((uword)*p - (uword)v)); }
word b_mul_assign(word *p, word v) { return (*p = WVAL((uword)*p * (uword)v)); }
word b_div_assign(word *p, word v) { return (*p = WVAL((uword)*p / (uword)v)); }
word b_mod_assign(word *p, word v) { return (*p = WVAL((uword)*p % (uword)v)); }
word b_lsh_assign(word *p, word v) { return (*p = WVAL((uword)*p << (uword)v)); }
word b_rsh_assign(word *p, word v) { return (*p = WVAL((uword)*p >> (uword)v)); }
word b_and_assign(word *p, word v) { return (*p = WVAL((uword)*p & (uword)v)); }
word b_or_assign(word *p, word v) { return (*p = WVAL((uword)*p | (uword)v)); }
word b_xor_assign(word *p, word v) { return (*p = WVAL((uword)*p ^ (uword)v)); }

/* ===== Initialization ===== */

void __b_init(void) {
    setvbuf(stdout, NULL, _IONBF, 0);
}

