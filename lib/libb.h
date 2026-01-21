/*
 * libb.h - B Runtime Library Interface
 * 
 * This header provides declarations for the B runtime library functions.
 * Generated C files include this header to access runtime functions.
 */

#ifndef LIBB_H
#define LIBB_H

#define _DEFAULT_SOURCE 1
#define _XOPEN_SOURCE 700
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdarg.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <signal.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <ctype.h>
#include <dlfcn.h>
#include <math.h>
#include <stddef.h>

/* Undefine common macros that might conflict with B variable names */
#undef TRUE
#undef FALSE
#undef TCSAFLUSH
#undef FIONREAD
#undef TIOCGWINSZ

/* Word type definitions */
typedef intptr_t  word;
typedef uintptr_t uword;

/*
 * Endianness check: char()/lchar() in B_BYTEPTR=0 mode pack bytes with
 * byte 0 at the LSB (PDP-11/little-endian convention).
 */
#if !defined(__BYTE_ORDER__) || __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
  #if !B_BYTEPTR
    #warning "B_BYTEPTR=0 mode uses little-endian byte packing; results may differ on big-endian hosts"
  #endif
#endif

/*
 * Word size emulation:
 *   WORD_BITS=0   -> host native (no wrapping)
 *   WORD_BITS=16  -> wrap arithmetic like PDP-11 16-bit words
 *   WORD_BITS=32  -> wrap arithmetic at 32 bits
 */
#ifndef WORD_BITS
#define WORD_BITS 0
#endif

#if WORD_BITS == 16
  #define WORD_MASK 0xFFFFU
  #define WVAL(x) ((word)(int16_t)((x) & WORD_MASK))
#elif WORD_BITS == 32
  #define WORD_MASK 0xFFFFFFFFU
  #define WVAL(x) ((word)(int32_t)((x) & WORD_MASK))
#else
  #define WORD_MASK (~(uword)0)
  #define WVAL(x) (x)
#endif

/*
 * Pointer model macros:
 *   B_BYTEPTR=1  -> pointers are byte addresses
 *   B_BYTEPTR=0  -> pointers are word addresses (Thompson B)
 */
#ifndef B_BYTEPTR
#define B_BYTEPTR 1
#endif

#if B_BYTEPTR
  #define B_DEREF(p)   (*(word*)(uword)(p))
  #define B_ADDR(x)    B_PTR(&(x))
  #define B_INDEX(a,i) (*(word*)((uword)(a) + (uword)(i) * sizeof(word)))
  #define B_PTR(p)     ((word)(uword)(p))
  #define B_CPTR(p)    ((void*)(uword)(p))
#else
  #define B_DEREF(p)   (*(word*)(uword)((uword)(p) * sizeof(word)))
  #define B_ADDR(x)    B_PTR(&(x))
  #define B_INDEX(a,i) B_DEREF((a) + (i))
  #define B_PTR(p)     ((word)((uword)(p) / sizeof(word)))
  #define B_CPTR(p)    ((void*)((uword)(p) * sizeof(word)))
#endif

#define B_STR(s)     B_PTR((const char*)(s))

/* ===== Runtime Library Function Declarations ===== */

/* I/O state (shared globals) */
extern int b_rd_fd;
extern int b_wr_fd;
extern word b_rd_unit;
extern word b_wr_unit;

/* Basic I/O */
word b_print(word x);
word b_putchar(word c);
word b_getchar(void);
word b_putchr(word c);
word b_getchr(void);
word b_putstr(word s);
word b_getstr(word buf);
word b_flush(void);

/* Exit/control */
word b_exit(word code);
word b_abort(void);
word b_free(word p);

/* Memory allocation */
word b_alloc(word nwords);

/* String/character operations */
word b_char(word s, word i);
word b_lchar(word s, word i, word c);
const char *__b_cstr(word s);
char *__b_dup_bstr(word s);
void __b_bstr_to_cstr(word s, char *buf, size_t max);
word __b_pack_cstr(const char *s);

/* Printf family */
word b_printf(word fmt, ...);
word b_printn(word n, word base);
word b_putnum(word n);

/* Command line arguments */
void __b_setargs(int argc, char **argv);
word b_argc(void);
word b_argv(word i);
word b_reread(void);

/* File I/O */
word b_open(word name, word mode);
word b_openr(word fd, word name);
word b_openw(word fd, word name);
word b_close(word fd);
word b_read(word fd, word buf, word n);
word b_write(word fd, word buf, word n);
word b_creat(word name, word mode);
word b_seek(word fd, word offset, word whence);

/* Process control */
word b_fork(void);
word b_wait(void);
word b_execl(word path, ...);
word b_execv(word path, word argv);
word b_system(word cmd);

/* Time/delay */
word b_usleep(word usec);
word b_time(word tvp);
word b_ctime(word tvp);

/* System functions */
word b_getuid(void);
word b_setuid(word uid);
word b_chdir(word path);
word b_chmod(word path, word mode);
word b_chown(word path, word owner);
word b_link(word old, word new);
word b_unlink(word path);
word b_stat(word path, word bufp);
word b_fstat(word fd, word bufp);
word b_makdir(word path, word mode);

/* Terminal I/O */
word b_gtty(word fd, word ttstat);
word b_stty(word fd, word ttstat);
word b_intr(word on);

/* Dynamic function calls */
word b_callf_dispatch(int nargs, word name, ...);

/* Math/compatibility helpers */
word sx64(word x);

/* Helper functions for complex lvalue operations */
word b_preinc(word *p);
word b_predec(word *p);
word b_postinc(word *p);
word b_postdec(word *p);
word b_add_assign(word *p, word v);
word b_sub_assign(word *p, word v);
word b_mul_assign(word *p, word v);
word b_div_assign(word *p, word v);
word b_mod_assign(word *p, word v);
word b_lsh_assign(word *p, word v);
word b_rsh_assign(word *p, word v);
word b_and_assign(word *p, word v);
word b_or_assign(word *p, word v);
word b_xor_assign(word *p, word v);

/* Low-level memory operations */
word b_load(word addr);
void b_store(word addr, word v);

/* Initialization (called by main wrapper) */
void __b_init(void);

#endif /* LIBB_H */

