/* Linux test shim: close the selected file, then report a delayed I/O error. */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
static int matches(int fd) {
    char link[80], name[4096];
    const char *target = getenv("BCC_FAIL_CLOSE");
    if (!target) return 0;
    snprintf(link, sizeof link, "/proc/self/fd/%d", fd);
    ssize_t n = readlink(link, name, sizeof name - 1);
    if (n < 0) return 0;
    name[n] = 0;
    return strcmp(name, target) == 0;
}
int fclose(FILE *f) {
    int bad = matches(fileno(f));
    int (*real)(FILE *) = dlsym(RTLD_NEXT, "fclose");
    int result = real(f);
    if (bad) { errno = EIO; return EOF; }
    return result;
}
int close(int fd) {
    int bad = matches(fd);
    int (*real)(int) = dlsym(RTLD_NEXT, "close");
    int result = real(fd);
    if (bad) { errno = EIO; return -1; }
    return result;
}
