/* Runtime objects are reusable only inside a private, owned cache directory. */
#include "bcc.h"
#include <sys/stat.h>

static char temporary_object[8192];

static void discard_temporary(void) {
    if (temporary_object[0]) {
        unlink(temporary_object);
        temporary_object[0] = 0;
    }
}

static void remember_temporary(const char *path) {
    static int registered;
    discard_temporary();
    size_t length = strlen(path);
    if (length >= sizeof(temporary_object)) { unlink(path); dief("runtime object path is too long"); }
    memcpy(temporary_object, path, length + 1);
    if (!registered) {
        if (atexit(discard_temporary) != 0) {
            discard_temporary();
            dief("cannot register runtime object cleanup");
        }
        registered = 1;
    }
}

static int private_cache(char *path, size_t size) {
    const char *configured = getenv("BCC_CACHE_DIR");
    int n = configured && *configured
        ? snprintf(path, size, "%s", configured)
        : snprintf(path, size, "/tmp/bcc-libb-%lu", (unsigned long)geteuid());
    if (n < 0 || (size_t)n >= size) return 0;
    while (n > 1 && path[n - 1] == '/') path[--n] = 0;
    if (mkdir(path, 0700) == 0) {
        /* Only a directory created by this invocation may be adjusted. */
        if (chmod(path, 0700) != 0) return 0;
    } else if (errno != EEXIST) return 0;
    struct stat st;
    return lstat(path, &st) == 0 && S_ISDIR(st.st_mode) &&
           st.st_uid == geteuid() && (st.st_mode & 0777) == 0700;
}

static int trusted_object(const char *path) {
    struct stat st;
    return lstat(path, &st) == 0 && S_ISREG(st.st_mode) &&
           st.st_uid == geteuid() && !(st.st_mode & 077) &&
           st.st_nlink == 1 && st.st_size > 0 && access(path, R_OK) == 0;
}

/* Compile libb.c to libb.o if needed, returns path to libb.o */
char *compile_libb(const char *directory, int verbose, int byteptr, int word_bits) {
    static char libb_o_path[4096 + 128];
    char libb_c_path[4096], cache_dir[4096];
    int cache = private_cache(cache_dir, sizeof(cache_dir));
    
    int path_length = snprintf(libb_c_path, sizeof(libb_c_path), "%s/libb.c", directory);
    if (path_length < 0 || (size_t)path_length >= sizeof(libb_c_path))
        dief("runtime source path is too long");
    /* Include headers in the cache key so the compiler and runtime use the
     * same address model, including when multiple checkouts share /tmp. */
    uint64_t key = UINT64_C(14695981039346656037);
    const char *dependencies[] = {"libb.c", "libb.h", "btarget.h", "binit.h", "bcall.h", "bunix.h", "bformat.h", "bprimitives.h"};
    for (size_t i = 0; i < sizeof(dependencies) / sizeof(dependencies[0]); i++) {
        char path[8192];
        snprintf(path, sizeof(path), "%s/%s", directory, dependencies[i]);
        FILE *input = fopen(path, "rb");
        if (!input) dief("cannot read runtime dependency %s", path);
        int c;
        while ((c = fgetc(input)) != EOF) {
            key ^= (unsigned char)c;
            key *= UINT64_C(1099511628211);
        }
        if (ferror(input)) dief("cannot read runtime dependency %s", path);
        fclose(input);
    }
    if (cache)
        snprintf(libb_o_path, sizeof(libb_o_path), "%s/libb_%016" PRIx64 "_%d_%d_%d.o",
                 cache_dir, key, byteptr, word_bits, g_strict ? 1 : 0);
    
    /* Check if libb.c exists */
    if (access(libb_c_path, R_OK) != 0) {
        dief("libb.c not found at %s", libb_c_path);
    }
    
    int need_compile = !cache || !trusted_object(libb_o_path);
    
    if (need_compile) {
        if (verbose) fprintf(stderr, "Compiling runtime library...\n");
        
        char include_flag[8192];
        char byteptr_flag[64];
        char wordbits_flag[64];
        char strict_flag[64];
        
        snprintf(include_flag, sizeof(include_flag), "-I%s", directory);
        snprintf(byteptr_flag, sizeof(byteptr_flag), "-DB_BYTEPTR=%d", byteptr ? 1 : 0);
        snprintf(wordbits_flag, sizeof(wordbits_flag), "-DWORD_BITS=%d", word_bits);
        snprintf(strict_flag, sizeof(strict_flag), "-D__bcc_strict_runtime=%d", g_strict ? 1 : 0);
        
        char temporary[sizeof(libb_o_path) + 8];
        if (cache) snprintf(temporary, sizeof(temporary), "%s.XXXXXX", libb_o_path);
        else snprintf(temporary, sizeof(temporary), "/tmp/bcc-libb-XXXXXX");
        int fd = mkstemp(temporary);
        if (fd < 0 && cache) {
            cache = 0;
            snprintf(temporary, sizeof(temporary), "/tmp/bcc-libb-XXXXXX");
            fd = mkstemp(temporary);
        }
        if (fd < 0) dief("cannot create runtime object");
        if (fchmod(fd, 0600) != 0) {
            close(fd); unlink(temporary);
            dief("cannot protect runtime object");
        }
        if (close(fd) != 0) {
            unlink(temporary);
            dief("cannot close runtime object");
        }
        const char *argv[] = {
            "gcc", "-std=c99", "-O2", "-c",
            include_flag, byteptr_flag, wordbits_flag, strict_flag,
            libb_c_path, "-o", temporary, NULL
        };
        
        pid_t pid = fork();
        if (pid < 0) { unlink(temporary); dief("fork failed"); }
        if (pid == 0) { execvp("gcc", (char *const*)argv); _exit(127); }
        
        int st = 0;
        pid_t waited;
        do { waited = waitpid(pid, &st, 0); } while (waited < 0 && errno == EINTR);
        if (waited < 0 || !WIFEXITED(st) || WEXITSTATUS(st) != 0) {
            unlink(temporary);
            dief("Failed to compile libb.c");
        }
        if (!cache || rename(temporary, libb_o_path) != 0) {
            /* A blocked cache must not turn into a shared, untrusted fallback. */
            remember_temporary(temporary);
            return temporary_object;
        }
    }
    
    return libb_o_path;
}
