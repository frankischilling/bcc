/* Translate 16-bit B addresses to host storage. Host mode uses native pointers. */
#ifndef BCC_BTARGET_H
#define BCC_BTARGET_H

#if WORD_BITS == 16
typedef struct {
    uintptr_t host;
    size_t words;
    unsigned base;
    size_t frame;
} b_target_region;

#ifdef B_TARGET_DEFINE
b_target_region __b_regions[65536];
unsigned char *__b_addresses[65536];
size_t __b_region_count;
size_t __b_frame_serial, __b_current_frame;
#else
extern b_target_region __b_regions[65536];
extern unsigned char *__b_addresses[65536];
extern size_t __b_region_count;
extern size_t __b_frame_serial, __b_current_frame;
#endif

static inline void __b_address_error(const char *reason) {
    fprintf(stderr, "bcc: 16-bit address space: %s\n", reason);
    exit(1);
}

static inline word __b_target_ptr(const void *pointer, size_t bytes, size_t frame) {
    uintptr_t host = (uintptr_t)pointer;
    const unsigned units = B_BYTEPTR ? 2 : 1;
    if (!pointer) return 0;
    if (bytes > 65535U / units * sizeof(word)) __b_address_error("object is too large");
    size_t words = (bytes + sizeof(word) - 1) / sizeof(word);
    if (!words) words = 1;
    for (size_t i = 0; i < __b_region_count; i++) {
        b_target_region *r = &__b_regions[i];
        if (r->words && host >= r->host && host - r->host < r->words * sizeof(word)) {
            size_t offset = host - r->host;
            if (offset % sizeof(word) >= units)
                __b_address_error("pointer into host word padding");
            if (words > r->words - offset / sizeof(word))
                __b_address_error("overlapping storage registration");
            return WVAL(r->base + (offset / sizeof(word)) * units + offset % sizeof(word));
        }
    }
    unsigned count = (unsigned)words * units;
    unsigned base = 1, run = 0;
    for (unsigned address = 1; address < 65536; address++) {
        if (__b_addresses[address]) { run = 0; base = address + 1; }
        else if (++run == count) break;
    }
    if (run != count) __b_address_error("storage exhausted");
    size_t index;
    for (index = 0; index < __b_region_count; index++)
        if (!__b_regions[index].words) break;
    if (index == __b_region_count) __b_region_count++;
    __b_regions[index] = (b_target_region){host, words, base, frame};
    for (unsigned i = 0; i < count; i++)
        __b_addresses[base + i] = (unsigned char*)pointer + (i / units) * sizeof(word) + i % units;
    return WVAL(base);
}

static inline void *__b_target_cptr(word pointer) {
    unsigned address = (unsigned)((uword)pointer & 0xffffU);
    if (!address) return NULL;
    if (!__b_addresses[address]) __b_address_error("invalid address");
    return __b_addresses[address];
}

static inline void __b_target_forget(void *pointer) {
    const unsigned units = B_BYTEPTR ? 2 : 1;
    for (size_t i = 0; i < __b_region_count; i++) {
        b_target_region *r = &__b_regions[i];
        if (r->words && r->host == (uintptr_t)pointer) {
            for (size_t j = 0; j < r->words * units; j++)
                __b_addresses[r->base + j] = NULL;
            r->words = 0;
            return;
        }
    }
}

typedef struct { size_t id, parent; } b_target_frame;
static inline b_target_frame __b_target_enter(void) {
    b_target_frame frame = {++__b_frame_serial, __b_current_frame};
    __b_current_frame = frame.id;
    return frame;
}

static inline void __b_target_leave(b_target_frame *frame) {
    for (size_t i = 0; i < __b_region_count; i++)
        if (__b_regions[i].words && __b_regions[i].frame == frame->id)
            __b_target_forget((void*)__b_regions[i].host);
    __b_current_frame = frame->parent;
}

#define B_FRAME b_target_frame __b_frame __attribute__((cleanup(__b_target_leave))) = __b_target_enter()
#define B_LOCAL_PTR_N(p,n) __b_target_ptr((p),(n),__b_current_frame)
#define B_PTR_N(p,n) __b_target_ptr((p),(n),0)
#define B_PTR(p) B_PTR_N((p),sizeof(word))
#define B_CPTR(p) __b_target_cptr(p)
#define B_DEREF(p) (*(word*)B_CPTR(p))
#define B_INDEX(a,i) B_DEREF(WADD((a),(uword)(i) * (B_BYTEPTR ? 2 : 1)))
#define B_FORGET(p) __b_target_forget(p)
#else
#if B_BYTEPTR
#define B_PTR(p) ((word)(uword)(p))
#define B_CPTR(p) ((void*)(uword)(p))
#define B_INDEX(a,i) (*(word*)((uword)(a) + (uword)(i) * sizeof(word)))
#else
#define B_PTR(p) ((word)((uword)(p) / sizeof(word)))
#define B_CPTR(p) ((void*)((uword)(p) * sizeof(word)))
#define B_INDEX(a,i) B_DEREF((a) + (i))
#endif
#define B_PTR_N(p,n) B_PTR(p)
#define B_DEREF(p) (*(word*)B_CPTR(p))
#define B_FORGET(p) ((void)(p))
#define B_LOCAL_PTR_N(p,n) B_PTR(p)
#define B_FRAME ((void)0)
#endif

#define B_ADDR(x) B_PTR(&(x))
#define B_STR(s) B_PTR(s)
#define B_WORD_BYTES (WORD_BITS == 16 ? 2 : sizeof(word))

/* Divide magnitudes to avoid signed MIN/-1 overflow. Negative results use
 * truncation toward zero; kbman requires exact divisible results (4.3). */
static inline word __b_word_div(word a, word b) {
    a = WVAL(a); b = WVAL(b);
    uword left = a < 0 ? -(uword)a : (uword)a;
    uword right = b < 0 ? -(uword)b : (uword)b;
    uword quotient = left / right;
    return (word)WVAL((a < 0) != (b < 0) ? -quotient : quotient);
}

static inline word __b_word_mod(word a, word b) {
    a = WVAL(a); b = WVAL(b);
    uword left = a < 0 ? -(uword)a : (uword)a;
    uword right = b < 0 ? -(uword)b : (uword)b;
    uword remainder = left % right;
    return (word)WVAL(a < 0 ? -remainder : remainder);
}

#endif
