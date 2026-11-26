/* Model a foreign cache owner without changing any real file ownership. */
#include "bcc.h"
#include <sys/stat.h>
#include <fcntl.h>

int g_strict = 1;

void dief(const char *format, ...) {
    va_list ap;
    va_start(ap, format);
    vfprintf(stderr, format, ap);
    va_end(ap);
    exit(1);
}

int lstat(const char *path, struct stat *st) {
    int result = fstatat(AT_FDCWD, path, st, AT_SYMLINK_NOFOLLOW);
    const char *cache = getenv("BCC_CACHE_DIR");
    if (result == 0 && cache && strcmp(path, cache) == 0)
        st->st_uid = geteuid() + 1;
    return result;
}

int main(int argc, char **argv) {
    if (argc != 2) return 2;
    puts(compile_libb(argv[1], 0, 0, 0));
    return 0;
}
