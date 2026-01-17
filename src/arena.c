/* arena.c - arena-based memory allocator */

#include "bcc.h"

/* ===================== Arena Implementation ===================== */

Arena *arena_new(void) {
    Arena *arena = (Arena*)malloc(sizeof(Arena));
    if (!arena) dief("out of memory");

    arena->first_chunk = NULL;
    arena->current_chunk = NULL;
    return arena;
}

static ArenaChunk *arena_new_chunk(size_t cap) {
    ArenaChunk *c = malloc(sizeof(*c) + cap);
    if (!c) dief("out of memory");
    c->next = NULL;
    c->used = 0;
    c->cap  = cap;
    return c;
}

void arena_free(Arena *arena) {
    if (!arena) return;

    ArenaChunk *chunk = arena->first_chunk;
    while (chunk) {
        ArenaChunk *next = chunk->next;
        free(chunk);
        chunk = next;
    }

    free(arena);
}

void arena_reset(Arena *arena) {
    if (!arena) return;

    ArenaChunk *chunk = arena->first_chunk;
    while (chunk) {
        ArenaChunk *next = chunk->next;
        free(chunk);
        chunk = next;
    }

    arena->first_chunk = NULL;
    arena->current_chunk = NULL;
}

void *arena_alloc(Arena *arena, size_t size) {
    if (!arena) dief("arena_alloc: NULL arena");

    /* align to pointer size (good enough for your use) */
    size = (size + sizeof(void*) - 1) & ~(sizeof(void*) - 1);

    if (!arena->current_chunk || arena->current_chunk->used + size > arena->current_chunk->cap) {
        size_t cap = (size > ARENA_CHUNK_SIZE) ? size : ARENA_CHUNK_SIZE;
        ArenaChunk *c = arena_new_chunk(cap);
        if (arena->current_chunk) arena->current_chunk->next = c;
        else arena->first_chunk = c;
        arena->current_chunk = c;
    }

    void *p = arena->current_chunk->data + arena->current_chunk->used;
    arena->current_chunk->used += size;
    return p;
}

char *arena_sdup(Arena *arena, const char *s) {
    if (!s) return NULL;
    size_t len = strlen(s);
    char *dup = (char*)arena_alloc(arena, len + 1);
    memcpy(dup, s, len + 1);
    return dup;
}

char *arena_xstrdup_range(Arena *arena, const char *s, size_t a, size_t b) {
    size_t n = (b > a) ? (b - a) : 0;
    char *p = (char*)arena_alloc(arena, n + 1);
    memcpy(p, s + a, n);
    p[n] = 0;
    return p;
}

char *arena_fmt(Arena *arena, const char *fmt_s, ...) {
    va_list ap, ap2;
    va_start(ap, fmt_s);
    va_copy(ap2, ap);
    int n = vsnprintf(NULL, 0, fmt_s, ap);
    va_end(ap);
    if (n < 0) dief("arena_fmt: vsnprintf failed");

    char *buf = (char*)arena_alloc(arena, (size_t)n + 1);
    vsnprintf(buf, (size_t)n + 1, fmt_s, ap2);
    va_end(ap2);
    return buf;
}

/* Arena marking for backtracking */
ArenaMark arena_mark(Arena *arena) {
    if (!arena) dief("arena_mark: NULL arena");
    ArenaMark mark = {arena->current_chunk, arena->current_chunk ? arena->current_chunk->used : 0};
    return mark;
}

void arena_rewind(Arena *arena, ArenaMark mark) {
    if (!arena) dief("arena_rewind: NULL arena");

    /* Free chunks after the marked chunk */
    ArenaChunk *chunk = mark.chunk ? mark.chunk->next : arena->first_chunk;
    while (chunk) {
        ArenaChunk *next = chunk->next;
        free(chunk);
        chunk = next;
    }

    /* Restore the marked chunk's state */
    if (mark.chunk) {
        mark.chunk->next = NULL;
        mark.chunk->used = mark.used;
        arena->current_chunk = mark.chunk;
    } else {
        arena->first_chunk = NULL;
        arena->current_chunk = NULL;
    }
}
