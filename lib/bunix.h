/* Unix V1 metadata represented in B word cells on a modern host. */
#ifndef BCC_BUNIX_H
#define BCC_BUNIX_H

/* V1 absolute offsets use all 16 bits; relative displacements are signed. */
static inline word __bcc_unix_seek(word fd, word offset, word origin) {
    off_t position = (off_t)offset;
#if WORD_BITS == 16
    if (origin == SEEK_SET) position = (off_t)(uint16_t)offset;
#endif
    return lseek((int)fd, position, (int)origin) < 0 ? (word)-1 : (word)0;
}

static inline mode_t __bcc_unix_mode(word value, int directory) {
    /* Larger modes retain the existing POSIX-mode compatibility interface. */
    if ((uword)value > 077) return (mode_t)value;
    mode_t mode = 0;
    if (value & 040) mode |= S_ISUID;
    if (value & 020) mode |= S_IXUSR | S_IXGRP | S_IXOTH;
    if (value & 010) mode |= S_IRUSR | (directory ? S_IXUSR : 0);
    if (value & 004) mode |= S_IWUSR;
    if (value & 002) mode |= S_IRGRP | S_IROTH | (directory ? S_IXGRP | S_IXOTH : 0);
    if (value & 001) mode |= S_IWGRP | S_IWOTH;
    return mode;
}

static inline uint16_t __bcc_unix_flags(const struct stat *st) {
    uint16_t flags = 0120000; /* allocated and modified, per stat(II), November 1971 */
    int directory = S_ISDIR(st->st_mode);
    if (directory) flags |= 040000;
    if (st->st_size > 4096) flags |= 010000;
    if (st->st_mode & S_ISUID) flags |= 040;
    if (!directory && (st->st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) flags |= 020;
    if (st->st_mode & S_IRUSR) flags |= 010;
    if (st->st_mode & S_IWUSR) flags |= 004;
    if (st->st_mode & S_IROTH) flags |= 002;
    if (st->st_mode & S_IWOTH) flags |= 001;
    return flags;
}

static inline uint32_t __bcc_unix_ticks(time_t seconds, long nanoseconds) {
    uint64_t elapsed = (uint64_t)seconds - UINT64_C(31536000);
    return (uint32_t)(elapsed * 60 + (uint64_t)nanoseconds * 60 / 1000000000);
}

static inline void __bcc_unix_stat(word *buffer, const struct stat *st) {
    /* stat(II) writes 34 bytes on the PDP-11, not the full 20-word allowance. */
    for (unsigned i = 0; i < 17; ++i) buffer[i] = 0;
    buffer[0] = WVAL((uint16_t)st->st_ino);
    buffer[1] = WVAL(__bcc_unix_flags(st));
    buffer[2] = WVAL(((uint16_t)(st->st_uid & 255) << 8) | (st->st_nlink & 255));
    buffer[3] = WVAL((uint16_t)st->st_size);
    /* Host block addresses are not V1 disk addresses. Leave those slots zero.
       Status-change time is the portable substitute for unavailable birth time. */
#if defined(__APPLE__)
    uint32_t created = __bcc_unix_ticks(st->st_ctimespec.tv_sec, st->st_ctimespec.tv_nsec);
    uint32_t modified = __bcc_unix_ticks(st->st_mtimespec.tv_sec, st->st_mtimespec.tv_nsec);
#else
    uint32_t created = __bcc_unix_ticks(st->st_ctim.tv_sec, st->st_ctim.tv_nsec);
    uint32_t modified = __bcc_unix_ticks(st->st_mtim.tv_sec, st->st_mtim.tv_nsec);
#endif
    buffer[12] = WVAL(created >> 16);
    buffer[13] = WVAL(created & 65535);
    buffer[14] = WVAL(modified >> 16);
    buffer[15] = WVAL(modified & 65535);
}

#endif
