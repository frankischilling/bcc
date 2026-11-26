/* Runtime-owned B cells and checked word-array adapters. Include after the
 * primitive bodies, once in the linked runtime or once per inline module. */
#ifndef BCC_BPRIMITIVES_H
#define BCC_BPRIMITIVES_H
#ifndef B_BUILTIN_STORAGE
#define B_BUILTIN_STORAGE
#endif

static void __bcc_need_arguments(const char *name, size_t need, size_t count) {
    if (count >= need) return;
    fprintf(stderr, "bcc: %s needs at least %zu argument%s\n", name, need, need == 1 ? "" : "s");
    exit(1);
}

static word __bcc_primitive_char(size_t count, const word *arguments) {
    __bcc_need_arguments("char", 2, count);
    return b_char(arguments[0], arguments[1]);
}

static word __bcc_primitive_lchar(size_t count, const word *arguments) {
    __bcc_need_arguments("lchar", 3, count);
    return b_lchar(arguments[0], arguments[1], arguments[2]);
}

static word __bcc_primitive_getchar(size_t count, const word *arguments) {
    __bcc_need_arguments("getchar", 0, count);
    (void)arguments;
    return b_getchar();
}

static word __bcc_primitive_getchr(size_t count, const word *arguments) {
    __bcc_need_arguments("getchr", 0, count);
    (void)arguments;
    return b_getchr();
}

static word __bcc_primitive_putchr(size_t count, const word *arguments) {
    __bcc_need_arguments("putchr", 1, count);
    return b_putchr(arguments[0]);
}

static word __bcc_primitive_getstr(size_t count, const word *arguments) {
    __bcc_need_arguments("getstr", 1, count);
    return b_getstr(arguments[0]);
}

static word __bcc_primitive_putstr(size_t count, const word *arguments) {
    __bcc_need_arguments("putstr", 1, count);
    return b_putstr(arguments[0]);
}

static word __bcc_primitive_flush(size_t count, const word *arguments) {
    __bcc_need_arguments("flush", 0, count);
    (void)arguments;
    return b_flush();
}

static word __bcc_primitive_reread(size_t count, const word *arguments) {
    __bcc_need_arguments("reread", 0, count);
    (void)arguments;
    return b_reread();
}

static word __bcc_primitive_printn(size_t count, const word *arguments) {
    __bcc_need_arguments("printn", 2, count);
    return b_printn(arguments[0], arguments[1]);
}

static word __bcc_primitive_putnum(size_t count, const word *arguments) {
    __bcc_need_arguments("putnum", 1, count);
    return b_putnum(arguments[0]);
}

static word __bcc_primitive_print(size_t count, const word *arguments) {
    __bcc_need_arguments("print", 1, count);
    return b_print(arguments[0]);
}

static word __bcc_primitive_putchar(size_t count, const word *arguments) {
    __bcc_need_arguments("putchar", 1, count);
    return b_putchar(arguments[0]);
}

static word __bcc_primitive_abort(size_t count, const word *arguments) {
    __bcc_need_arguments("abort", 0, count);
    (void)arguments;
    return b_abort();
}

static word __bcc_primitive_free(size_t count, const word *arguments) {
    __bcc_need_arguments("free", 1, count);
    return b_free(arguments[0]);
}

static word __bcc_primitive_alloc(size_t count, const word *arguments) {
    __bcc_need_arguments("alloc", 1, count);
    return b_alloc(arguments[0]);
}

static word __bcc_primitive_open(size_t count, const word *arguments) {
    __bcc_need_arguments("open", 2, count);
    return b_open(arguments[0], arguments[1]);
}

static word __bcc_primitive_close(size_t count, const word *arguments) {
    __bcc_need_arguments("close", 1, count);
    return b_close(arguments[0]);
}

static word __bcc_primitive_read(size_t count, const word *arguments) {
    __bcc_need_arguments("read", 3, count);
    return b_read(arguments[0], arguments[1], arguments[2]);
}

static word __bcc_primitive_write(size_t count, const word *arguments) {
    __bcc_need_arguments("write", 3, count);
    return b_write(arguments[0], arguments[1], arguments[2]);
}

static word __bcc_primitive_creat(size_t count, const word *arguments) {
    __bcc_need_arguments("creat", 2, count);
    return b_creat(arguments[0], arguments[1]);
}

static word __bcc_primitive_seek(size_t count, const word *arguments) {
    __bcc_need_arguments("seek", 3, count);
    return b_seek(arguments[0], arguments[1], arguments[2]);
}

static word __bcc_primitive_openr(size_t count, const word *arguments) {
    __bcc_need_arguments("openr", 2, count);
    return b_openr(arguments[0], arguments[1]);
}

static word __bcc_primitive_openw(size_t count, const word *arguments) {
    __bcc_need_arguments("openw", 2, count);
    return b_openw(arguments[0], arguments[1]);
}

static word __bcc_primitive_fork(size_t count, const word *arguments) {
    __bcc_need_arguments("fork", 0, count);
    (void)arguments;
    return b_fork();
}

static word __bcc_primitive_wait(size_t count, const word *arguments) {
    __bcc_need_arguments("wait", 0, count);
    (void)arguments;
    return b_wait();
}

static word __bcc_primitive_execv(size_t count, const word *arguments) {
    __bcc_need_arguments("execv", 3, count);
    return b_execv(arguments[0], arguments[1], arguments[2]);
}

static word __bcc_primitive_chdir(size_t count, const word *arguments) {
    __bcc_need_arguments("chdir", 1, count);
    return b_chdir(arguments[0]);
}

static word __bcc_primitive_chmod(size_t count, const word *arguments) {
    __bcc_need_arguments("chmod", 2, count);
    return b_chmod(arguments[0], arguments[1]);
}

static word __bcc_primitive_chown(size_t count, const word *arguments) {
    __bcc_need_arguments("chown", 2, count);
    return b_chown(arguments[0], arguments[1]);
}

static word __bcc_primitive_link(size_t count, const word *arguments) {
    __bcc_need_arguments("link", 2, count);
    return b_link(arguments[0], arguments[1]);
}

static word __bcc_primitive_unlink(size_t count, const word *arguments) {
    __bcc_need_arguments("unlink", 1, count);
    return b_unlink(arguments[0]);
}

static word __bcc_primitive_stat(size_t count, const word *arguments) {
    __bcc_need_arguments("stat", 2, count);
    return b_stat(arguments[0], arguments[1]);
}

static word __bcc_primitive_fstat(size_t count, const word *arguments) {
    __bcc_need_arguments("fstat", 2, count);
    return b_fstat(arguments[0], arguments[1]);
}

static word __bcc_primitive_time(size_t count, const word *arguments) {
    __bcc_need_arguments("time", 1, count);
    return b_time(arguments[0]);
}

static word __bcc_primitive_ctime(size_t count, const word *arguments) {
    __bcc_need_arguments("ctime", 2, count);
    return b_ctime(arguments[0], arguments[1]);
}

static word __bcc_primitive_getuid(size_t count, const word *arguments) {
    __bcc_need_arguments("getuid", 0, count);
    (void)arguments;
    return b_getuid();
}

static word __bcc_primitive_setuid(size_t count, const word *arguments) {
    __bcc_need_arguments("setuid", 1, count);
    return b_setuid(arguments[0]);
}

static word __bcc_primitive_makdir(size_t count, const word *arguments) {
    __bcc_need_arguments("makdir", 2, count);
    return b_makdir(arguments[0], arguments[1]);
}

static word __bcc_primitive_mkdir(size_t count, const word *arguments) {
    __bcc_need_arguments("mkdir", 2, count);
    return b_mkdir(arguments[0], arguments[1]);
}

static word __bcc_primitive_intr(size_t count, const word *arguments) {
    __bcc_need_arguments("intr", 1, count);
    return b_intr(arguments[0]);
}

static word __bcc_primitive_gtty(size_t count, const word *arguments) {
    __bcc_need_arguments("gtty", 2, count);
    return b_gtty(arguments[0], arguments[1]);
}

static word __bcc_primitive_stty(size_t count, const word *arguments) {
    __bcc_need_arguments("stty", 2, count);
    return b_stty(arguments[0], arguments[1]);
}

static word __bcc_primitive_system(size_t count, const word *arguments) {
    __bcc_need_arguments("system", 1, count);
    return b_system(arguments[0]);
}

static word __bcc_primitive_usleep(size_t count, const word *arguments) {
    __bcc_need_arguments("usleep", 1, count);
    return b_usleep(arguments[0]);
}

static word __bcc_primitive_argc(size_t count, const word *arguments) {
    __bcc_need_arguments("argc", 0, count);
    (void)arguments;
    return b_argc();
}

static word __bcc_primitive_argv(size_t count, const word *arguments) {
    __bcc_need_arguments("argv", 1, count);
    return b_argv(arguments[0]);
}

static word __bcc_primitive_printf(size_t count, const word *arguments) {
    __bcc_need_arguments("printf", 1, count);
    return __bcc_printf_words(count, arguments);
}

static word __bcc_primitive_exit(size_t count, const word *arguments) {
    return b_exit(count ? arguments[0] : 0);
}

static word __bcc_primitive_execl(size_t count, const word *arguments) {
    __bcc_need_arguments("execl", 1, count);
    B_FRAME;
    word values[255];
    size_t used = 0;
    for (size_t i = 1; i < count; ++i) {
        if (!arguments[i]) {
            word vector = used ? B_LOCAL_PTR_N(values, used * sizeof(word)) : 0;
            return b_execv(arguments[0], vector, (word)used);
        }
        if (used == 255) return -1;
        values[used++] = arguments[i];
    }
    return -1; /* No terminating zero within the supplied arguments. */
}

static word __bcc_primitive_callf(size_t count, const word *arguments) {
    __bcc_need_arguments("callf", 1, count);
    if (count > 11) return -1;
    word values[10] = {0};
    for (size_t i = 1; i < count; ++i) values[i - 1] = arguments[i];
    return b_callf_dispatch((int)(count - 1), arguments[0],
        values[0], values[1], values[2], values[3], values[4],
        values[5], values[6], values[7], values[8], values[9]);
}

#define BCC_PRIMITIVE(name, body) \
    B_BUILTIN_STORAGE word __bcc_builtin_##name; \
    static struct __bcc_builtin_record __bcc_primitive_record_##name = \
        {#name, &__bcc_builtin_##name, 0, __bcc_primitive_##name, NULL, 0, NULL, NULL};
BCC_PRIMITIVE(char, b_char)
BCC_PRIMITIVE(lchar, b_lchar)
BCC_PRIMITIVE(getchar, b_getchar)
BCC_PRIMITIVE(getchr, b_getchr)
BCC_PRIMITIVE(putchr, b_putchr)
BCC_PRIMITIVE(getstr, b_getstr)
BCC_PRIMITIVE(putstr, b_putstr)
BCC_PRIMITIVE(flush, b_flush)
BCC_PRIMITIVE(reread, b_reread)
BCC_PRIMITIVE(printn, b_printn)
BCC_PRIMITIVE(putnum, b_putnum)
BCC_PRIMITIVE(print, b_print)
BCC_PRIMITIVE(putchar, b_putchar)
BCC_PRIMITIVE(abort, b_abort)
BCC_PRIMITIVE(free, b_free)
BCC_PRIMITIVE(alloc, b_alloc)
BCC_PRIMITIVE(open, b_open)
BCC_PRIMITIVE(close, b_close)
BCC_PRIMITIVE(read, b_read)
BCC_PRIMITIVE(write, b_write)
BCC_PRIMITIVE(creat, b_creat)
BCC_PRIMITIVE(seek, b_seek)
BCC_PRIMITIVE(openr, b_openr)
BCC_PRIMITIVE(openw, b_openw)
BCC_PRIMITIVE(fork, b_fork)
BCC_PRIMITIVE(wait, b_wait)
BCC_PRIMITIVE(execv, b_execv)
BCC_PRIMITIVE(chdir, b_chdir)
BCC_PRIMITIVE(chmod, b_chmod)
BCC_PRIMITIVE(chown, b_chown)
BCC_PRIMITIVE(link, b_link)
BCC_PRIMITIVE(unlink, b_unlink)
BCC_PRIMITIVE(stat, b_stat)
BCC_PRIMITIVE(fstat, b_fstat)
BCC_PRIMITIVE(time, b_time)
BCC_PRIMITIVE(ctime, b_ctime)
BCC_PRIMITIVE(getuid, b_getuid)
BCC_PRIMITIVE(setuid, b_setuid)
BCC_PRIMITIVE(makdir, b_makdir)
BCC_PRIMITIVE(mkdir, b_mkdir)
BCC_PRIMITIVE(intr, b_intr)
BCC_PRIMITIVE(gtty, b_gtty)
BCC_PRIMITIVE(stty, b_stty)
BCC_PRIMITIVE(system, b_system)
BCC_PRIMITIVE(usleep, b_usleep)
BCC_PRIMITIVE(argc, b_argc)
BCC_PRIMITIVE(argv, b_argv)
BCC_PRIMITIVE(printf, b_printf)
BCC_PRIMITIVE(exit, b_exit)
BCC_PRIMITIVE(execl, b_execl)
BCC_PRIMITIVE(callf, b_callf_dispatch)
#undef BCC_PRIMITIVE

static void __attribute__((constructor(101))) __bcc_initialize_builtins(void) {
#define BCC_PRIMITIVE(name, body) do { \
    struct __bcc_builtin_record *record = &__bcc_primitive_record_##name; \
    if (!record->registered) { \
        record->code = B_FUNCTION(body); \
        if (!__bcc_builtin_##name) __bcc_builtin_##name = record->code; \
        (void)B_PTR_N(&__bcc_builtin_##name, sizeof(word)); \
        word *provided = __bcc_source_binding(#name); \
        if (provided) record->cell = provided; \
        unsigned code_hash = __bcc_builtin_code_hash(record->code); \
        unsigned name_hash = __bcc_builtin_name_hash(#name); \
        record->code_next = __bcc_builtin_codes[code_hash]; \
        __bcc_builtin_codes[code_hash] = record; \
        record->name_next = __bcc_builtin_names[name_hash]; \
        __bcc_builtin_names[name_hash] = record; \
        record->registered = 1; \
        record->next = __bcc_builtin_functions; \
        __bcc_builtin_functions = record; \
    } \
} while (0)
    BCC_PRIMITIVE(char, b_char);
    BCC_PRIMITIVE(lchar, b_lchar);
    BCC_PRIMITIVE(getchar, b_getchar);
    BCC_PRIMITIVE(getchr, b_getchr);
    BCC_PRIMITIVE(putchr, b_putchr);
    BCC_PRIMITIVE(getstr, b_getstr);
    BCC_PRIMITIVE(putstr, b_putstr);
    BCC_PRIMITIVE(flush, b_flush);
    BCC_PRIMITIVE(reread, b_reread);
    BCC_PRIMITIVE(printn, b_printn);
    BCC_PRIMITIVE(putnum, b_putnum);
    BCC_PRIMITIVE(print, b_print);
    BCC_PRIMITIVE(putchar, b_putchar);
    BCC_PRIMITIVE(abort, b_abort);
    BCC_PRIMITIVE(free, b_free);
    BCC_PRIMITIVE(alloc, b_alloc);
    BCC_PRIMITIVE(open, b_open);
    BCC_PRIMITIVE(close, b_close);
    BCC_PRIMITIVE(read, b_read);
    BCC_PRIMITIVE(write, b_write);
    BCC_PRIMITIVE(creat, b_creat);
    BCC_PRIMITIVE(seek, b_seek);
    BCC_PRIMITIVE(openr, b_openr);
    BCC_PRIMITIVE(openw, b_openw);
    BCC_PRIMITIVE(fork, b_fork);
    BCC_PRIMITIVE(wait, b_wait);
    BCC_PRIMITIVE(execv, b_execv);
    BCC_PRIMITIVE(chdir, b_chdir);
    BCC_PRIMITIVE(chmod, b_chmod);
    BCC_PRIMITIVE(chown, b_chown);
    BCC_PRIMITIVE(link, b_link);
    BCC_PRIMITIVE(unlink, b_unlink);
    BCC_PRIMITIVE(stat, b_stat);
    BCC_PRIMITIVE(fstat, b_fstat);
    BCC_PRIMITIVE(time, b_time);
    BCC_PRIMITIVE(ctime, b_ctime);
    BCC_PRIMITIVE(getuid, b_getuid);
    BCC_PRIMITIVE(setuid, b_setuid);
    BCC_PRIMITIVE(makdir, b_makdir);
    BCC_PRIMITIVE(mkdir, b_mkdir);
    BCC_PRIMITIVE(intr, b_intr);
    BCC_PRIMITIVE(gtty, b_gtty);
    BCC_PRIMITIVE(stty, b_stty);
    BCC_PRIMITIVE(system, b_system);
    BCC_PRIMITIVE(usleep, b_usleep);
    BCC_PRIMITIVE(argc, b_argc);
    BCC_PRIMITIVE(argv, b_argv);
    BCC_PRIMITIVE(printf, b_printf);
    BCC_PRIMITIVE(exit, b_exit);
    BCC_PRIMITIVE(execl, b_execl);
    BCC_PRIMITIVE(callf, b_callf_dispatch);
#undef BCC_PRIMITIVE
}

#endif
