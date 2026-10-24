/*
 * libb.c - B Runtime Library Implementation
 * 
 * This file contains all runtime functions needed by B programs.
 * It is compiled separately and linked with generated B code.
 */

#define B_TARGET_DEFINE
#define B_INIT_DEFINE
#define B_CALL_DEFINE
#include "libb.h"
#include "bunix.h"

/* Global I/O State */

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

/* Basic I/O */

word b_print(word x) {
    __b_sync_wr();
    char buf[64];
    int n = snprintf(buf, sizeof(buf), "%" PRIdPTR "\n", (intptr_t)x);
    if (n > 0) (void)write(b_wr_fd, buf, (size_t)n);
    return x;
}

word b_putchar(word c) {
    __b_sync_wr();
    /* Packed character pairs are written high byte first. */
    unsigned char bytes[2] = {(unsigned char)((uword)c >> 8), (unsigned char)c};
    size_t start = bytes[0] ? 0 : 1;
    (void)write(b_wr_fd, bytes + start, 2 - start);
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
        word ch = __bcc_library_call2("char", b_char, s, i++);
        if (ch == 004 || (!__bcc_strict_runtime && ch == 0)) break;
        __bcc_library_call1("putchar", b_putchar, ch);
    }
    return s;
}

word b_getstr(word buf) {
    word i = 0;
    for (;;) {
        word c = __bcc_library_call0("getchar", b_getchar);
        if (c == 004 || c == '\n' || (!__bcc_strict_runtime && c == '\r')) break;
        __bcc_library_call3("lchar", b_lchar, buf, i++, c);
    }
    __bcc_library_call3("lchar", b_lchar, buf, i, 004);
    return __bcc_strict_runtime ? i : buf;
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

/* Exit/Control */

word b_exit(word code) {
    exit((int)code);
    return 0;
}

word b_abort(void) {
    abort();
    return 0;
}

word b_free(word p) {
    void *host = B_CPTR(p);
    B_FORGET(host);
    free(host);
    return 0;
}

/* Memory Allocation */

word b_alloc(word nwords) {
    nwords = WVAL(nwords);
    if (nwords < 0 || (uword)nwords > SIZE_MAX / sizeof(word)) {
        fprintf(stderr, "alloc: invalid size\n");
        exit(1);
    }
    size_t bytes = nwords ? (size_t)nwords * sizeof(word) : sizeof(word);
    void *p = malloc(bytes);
    if (!p) {
        fprintf(stderr, "alloc: out of memory\n");
        exit(1);
    }
    return B_PTR_N(p, bytes);
}

/* Low-Level Memory Operations */

word b_load(word addr) {
    return B_DEREF(addr);
}

void b_store(word addr, word v) { B_DEREF(addr) = WVAL(v); }

/* String/Character Operations */

/*
 * B string access - byte packing within words.
 * In B_BYTEPTR=0 mode, bytes are packed into words with byte 0 at the LSB.
 */
word b_char(word s, word i) {
#if B_BYTEPTR && WORD_BITS != 16
    const unsigned char *p = (const unsigned char*)B_CPTR(s);
    return (word)p[(size_t)i];
#else
    const uword W = (uword)B_WORD_BYTES;
    uword wi = (uword)i / W;
    uword bi = (uword)i % W;
    uword w  = (uword)B_INDEX(s, wi);
    return (word)((w >> (bi * 8)) & 0xFF);
#endif
}

word b_lchar(word s, word i, word c) {
#if B_BYTEPTR && WORD_BITS != 16
    unsigned char *p = (unsigned char*)B_CPTR(s);
    p[(size_t)i] = (unsigned char)(c & 0xFF);
    return c;
#else
    const uword W = (uword)B_WORD_BYTES;
    uword wi = (uword)i / W;
    uword bi = (uword)i % W;

    word addr = B_ADDR(B_INDEX(s, wi));
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
    size_t W = B_WORD_BYTES;
    size_t total = n + 1;  /* +1 for 004 terminator */
    size_t words = (total + W - 1) / W;

    word bp = b_alloc((word)words);

    for (size_t i = 0; i < n; i++) {
        b_lchar(bp, (word)i, (word)(unsigned char)s[i]);
    }
    b_lchar(bp, (word)n, (word)004);
    return bp;
}

/* Printf Family */

#include "bformat.h"

word b_putnum(word n) {
    __bcc_library_call2("printn", b_printn, n, (word)10);
    return n;
}

/* Command Line Arguments */

static int __b_argc;
static char **__b_argv;
static word *__b_argvb;
word b_argv_vector;

void __b_setargs(int argc, char **argv) {
    __b_argc = argc;
    __b_argv = argv;

    __b_argvb = (word*)malloc(sizeof(word) * ((size_t)argc + 1));
    if (!__b_argvb) {
        fprintf(stderr, "argv: out of memory\n");
        exit(1);
    }

    /* Keep argv(i) EOT strings separate from the native NUL-string vector. */
    word *vector = (word*)malloc(sizeof(word) * ((size_t)argc + 1));
    if (!vector) { fprintf(stderr, "argv: out of memory\n"); exit(1); }
    vector[0] = WVAL(argc);
    for (int i = 0; i < argc; i++) {
        __b_argvb[i] = __b_pack_cstr(argv[i]);
        vector[i + 1] = __b_pack_cstr(argv[i]);
        b_lchar(vector[i + 1], (word)strlen(argv[i]), 0);
    }
    b_argv_vector = B_PTR_N(vector, sizeof(word) * ((size_t)argc + 1));
}

word __b_argvalues(void) {
    return __b_argc ? B_PTR_N(__b_argvb, sizeof(word) * (size_t)__b_argc) : 0;
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
    if (__b_argc <= 1) return 0;

    /* A pipe can block before its reader starts. Stage the replay in an
       anonymous seekable file instead, preserving empty argument fields. */
    FILE *stream = tmpfile();
    if (!stream) {
        fprintf(stderr, "reread: cannot create replay file\n");
        exit(1);
    }
    for (int i = 0; i < __b_argc; ++i) {
        size_t length = strlen(__b_argv[i]);
        if (fwrite(__b_argv[i], 1, length, stream) != length ||
            fputc(i + 1 < __b_argc ? ' ' : '\n', stream) == EOF)
            goto failed;
    }
    if (fflush(stream) != 0 || fseek(stream, 0, SEEK_SET) != 0) goto failed;
    int descriptor = dup(fileno(stream));
    if (descriptor < 0) goto failed;
    fclose(stream);
    __b_sync_rd();
    if (b_rd_fd != 0) close(b_rd_fd);
    b_rd_fd = descriptor;
    b_rd_unit = (word)descriptor;
    return 0;

failed:
    fclose(stream);
    fprintf(stderr, "reread: cannot stage command line\n");
    exit(1);
}

/* File I/O */

word b_open(word name, word mode) {
    const char *p = __b_cstr(name);
    int flags = (mode == 0) ? O_RDONLY : O_WRONLY;
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
#if WORD_BITS == 16
    if (n < 0) return -1;
    unsigned char *bytes = malloc(n ? (size_t)n : 1);
    if (!bytes) return -1;
    ssize_t count = read((int)fd, bytes, (size_t)n);
    for (ssize_t i = 0; i < count; i++) b_lchar(buf, (word)i, bytes[i]);
    free(bytes);
    return WVAL(count);
#else
    char *p = (char*)B_CPTR(buf);
    return (word)read((int)fd, p, (size_t)n);
#endif
}

word b_write(word fd, word buf, word n) {
#if WORD_BITS == 16
    if (n < 0) return -1;
    unsigned char *bytes = malloc(n ? (size_t)n : 1);
    if (!bytes) return -1;
    for (word i = 0; i < n; i++) bytes[i] = (unsigned char)b_char(buf, i);
    ssize_t count = write((int)fd, bytes, (size_t)n);
    free(bytes);
    return WVAL(count);
#else
    return (word)write((int)fd, B_CPTR(buf), (size_t)n);
#endif
}

word b_creat(word name, word mode) {
    const char *p = __b_cstr(name);
    return (word)creat(p, __bcc_unix_mode(mode, 0));
}

word b_seek(word fd, word offset, word whence) {
    off_t r = lseek((int)fd, (off_t)offset, (int)whence);
    return (r < 0) ? (word)-1 : (word)0;
}

/* Process Control */

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

/* B72 section 8 passes exactly count argument strings, including arg0. */
word b_execv(word path, word argv, word count) {
    if (count < 0 || count > 255 || (count && !argv)) return -1;
    char *name = __b_dup_bstr(path);
    if (!name) return -1;
    char *arguments[256];
    word *values = count ? (word*)B_CPTR(argv) : NULL;
    size_t n = (size_t)count, i = 0;
    for (; i < n; i++) {
        if (!values[i]) break;
        arguments[i] = __b_dup_bstr(values[i]);
        if (!arguments[i]) break;
    }
    if (i == n) {
        arguments[n] = NULL;
        execv(name, arguments);
    }
    while (i) free(arguments[--i]);
    free(name);
    return -1;
}

word b_execl(word path, ...) {
    char *name = __b_dup_bstr(path);
    if (!name) return -1;
    char *arguments[256];
    size_t n = 0;
    int complete = 0;
    va_list ap;
    va_start(ap, path);
    while (n < 255) {
        word value = va_arg(ap, word);
        if (!value) { complete = 1; break; }
        arguments[n] = __b_dup_bstr(value);
        if (!arguments[n]) break;
        n++;
    }
    va_end(ap);
    if (complete) {
        arguments[n] = NULL;
        execv(name, arguments);
    }
    while (n) free(arguments[--n]);
    free(name);
    return -1;
}

word b_system(word cmd) {
    /* Split arguments without invoking a shell or expanding their contents. */
    char *line = __b_dup_bstr(cmd);
    if (!line) return -1;
    char *argv[128];
    size_t argc = 0;
    char *p = line, *q = line;
    while (*p) {
        while (*p && isspace((unsigned char)*p)) p++;
        if (!*p) break;
        if (argc + 1 >= sizeof(argv)/sizeof(argv[0])) { free(line); return -1; }
        argv[argc++] = q;
        int quote = 0;
        while (*p && (quote || !isspace((unsigned char)*p))) {
            unsigned char c = (unsigned char)*p++;
            if (c == '\\' && quote != '\'') {
                if (!*p) { free(line); return -1; }
                *q++ = *p++;
            } else if (c == '\'' || c == '"') {
                if (!quote) quote = c;
                else if (quote == c) quote = 0;
                else *q++ = (char)c;
            } else *q++ = (char)c;
        }
        if (quote) { free(line); return -1; }
        if (*p) p++;
        *q++ = 0;
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
    pid_t w;
    do { w = waitpid(pid, &st, 0); } while (w < 0 && errno == EINTR);
    free(line);
    if (w < 0) return -1;
    return (word)st;
}

/* Time/Delay */

word b_usleep(word usec) {
    usleep((useconds_t)usec);
    return 0;
}

/* Unix V1 counts 60 Hz ticks since 1971, high word first (time(II)). */
word b_time(word tvp) {
    struct timespec now;
    if (clock_gettime(CLOCK_REALTIME, &now) != 0) return -1;
    if (tvp) {
        uint64_t elapsed = (uint64_t)now.tv_sec - UINT64_C(31536000);
        uint32_t ticks = (uint32_t)(elapsed * 60 + (uint64_t)now.tv_nsec * 60 / 1000000000);
        word *tv = (word*)B_CPTR(tvp);
        tv[0] = WVAL(ticks >> 16);
        tv[1] = WVAL(ticks & 65535);
    }
    return 0;
}

/* B72 section 8 specifies a caller-owned, 16-byte date buffer. */
word b_ctime(word tvp, word date) {
    if (!tvp || !date) return -1;
    word *tv = (word*)B_CPTR(tvp);
    uint32_t ticks = ((uint32_t)(uint16_t)tv[0] << 16) | (uint16_t)tv[1];
    unsigned days = ticks / 5184000U;
    unsigned seconds = ticks / 60U % 86400U;
    unsigned year = 1971, month = 0;
    while (days >= (year % 4 == 0 ? 366U : 365U)) {
        days -= year % 4 == 0 ? 366U : 365U;
        year++;
    }
    static const unsigned lengths[] = {31,28,31,30,31,30,31,31,30,31,30,31};
    static const char *months[] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
    for (;;) {
        unsigned length = lengths[month] + (month == 1 && year % 4 == 0);
        if (days < length) break;
        days -= length;
        month++;
    }
    char text[16];
    snprintf(text, sizeof(text), "%s %2u %02u:%02u:%02u", months[month], days + 1,
             seconds / 3600, seconds / 60 % 60, seconds % 60);
    for (size_t i = 0; i < sizeof(text); i++) b_lchar(date, (word)i, (word)(unsigned char)text[i]);
    return 0;
}

/* System Functions */

word b_getuid(void) {
    return (word)getuid();
}

word b_setuid(word uid) {
    return (word)setuid((uid_t)uid);
}

word b_chdir(word path) {
    const char *p = __b_cstr(path);
    return (word)chdir(p);
}

word b_chmod(word path, word mode) {
    const char *p = __b_cstr(path);
    return (word)chmod(p, __bcc_unix_mode(mode, 0));
}

word b_chown(word path, word owner) {
    const char *p = __b_cstr(path);
    return (word)chown(p, (uid_t)owner, (gid_t)-1);
}

word b_link(word old, word new) {
    const char *o = __b_cstr(old);
    const char *n = __b_cstr(new);
    return (word)link(o, n);
}

word b_unlink(word path) {
    const char *p = __b_cstr(path);
    return (word)unlink(p);
}

word b_stat(word path, word bufp) {
    if (!bufp) { errno = EFAULT; return -1; }
    const char *p = __b_cstr(path);
    struct stat st;
    if (stat(p, &st) != 0) return -1;
    __bcc_unix_stat((word*)B_CPTR(bufp), &st);
    return 0;
}

word b_fstat(word fd, word bufp) {
    if (!bufp) { errno = EFAULT; return -1; }
    struct stat st;
    if (fstat((int)fd, &st) != 0) return -1;
    __bcc_unix_stat((word*)B_CPTR(bufp), &st);
    return 0;
}

word b_makdir(word path, word mode) {
    const char *p = __b_cstr(path);
    return (word)mkdir(p, __bcc_unix_mode(mode, 1));
}

word b_mkdir(word path, word mode) { return b_makdir(path, mode); }

/* Terminal I/O */

word b_gtty(word fd, word ttstat) {
    if (!ttstat) { errno = EFAULT; return -1; }
    struct termios t;
    if (tcgetattr((int)fd, &t) < 0) return -1;

    word *vec = (word*)B_CPTR(ttstat);
    vec[0] = (word)t.c_iflag;
    vec[1] = (word)t.c_oflag;
    vec[2] = (word)t.c_lflag;
    return 0;
}

word b_stty(word fd, word ttstat) {
    if (!ttstat) { errno = EFAULT; return -1; }
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

/* Dynamic Function Calls */

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

/* Math/Compatibility Helpers */

word sx64(word x) {
    return (word)(int16_t)(x & 0xFFFF);
}

/* Helper Functions for Complex Lvalue Operations */

/* All helper functions use safe W* macros to avoid host-C undefined behavior */
word b_preinc(word *p) { return (*p = WADD(*p, 1)); }
word b_predec(word *p) { return (*p = WSUB(*p, 1)); }
word b_postinc(word *p) { word old = WVAL(*p); *p = WADD(*p, 1); return old; }
word b_postdec(word *p) { word old = WVAL(*p); *p = WSUB(*p, 1); return old; }
word b_add_assign(word *p, word v) { return (*p = WADD(*p, v)); }
word b_sub_assign(word *p, word v) { return (*p = WSUB(*p, v)); }
word b_mul_assign(word *p, word v) { return (*p = WMUL(*p, v)); }
word b_div_assign(word *p, word v) { return (*p = WDIV(*p, v)); }
word b_mod_assign(word *p, word v) { return (*p = WMOD(*p, v)); }
word b_lsh_assign(word *p, word v) { return (*p = WSHL(*p, v)); }
word b_rsh_assign(word *p, word v) { return (*p = WSHR(*p, v)); }
word b_and_assign(word *p, word v) { return (*p = WAND(*p, v)); }
word b_or_assign(word *p, word v) { return (*p = WOR(*p, v)); }
word b_xor_assign(word *p, word v) { return (*p = WXOR(*p, v)); }

/* Initialization */

void __b_init(void) {
    if (!__bcc_runtime_initialized) {
        setvbuf(stdout, NULL, _IONBF, 0);
        __bcc_runtime_initialized = 1;
    }
    __bcc_run_initializers();
}


#include "bprimitives.h"
