#include "LVZip.h"
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <zlib.h>

typedef struct { int fd; uint64_t position, limit; } Writer;
static void u16(unsigned char *p, uint16_t v) { p[0] = v; p[1] = v >> 8; }
static void u32(unsigned char *p, uint32_t v) { u16(p, v); u16(p + 2, v >> 16); }
static int fail(int code) { errno = code; return -1; }
static int bytes(Writer *w, const void *data, size_t length) {
    if (length > w->limit - w->position) return fail(EFBIG);
    const unsigned char *p = data;
    size_t left = length;
    while (left) {
        size_t chunk = left > 65536 ? 65536 : left;
        ssize_t n = write(w->fd, p, chunk);
        if (n < 0) { if (errno == EINTR) continue; return -1; }
        if (!n) return fail(EIO);
        p += n; left -= (size_t)n; w->position += (size_t)n;
    }
    return 0;
}
static int name_valid(const char *name) {
    if (!name || !*name || *name == '/' || strlen(name) > 512 || strchr(name, '\\')) return 0;
    const char *p = name;
    while (*p) {
        const char *end = strchr(p, '/');
        size_t n = end ? (size_t)(end - p) : strlen(p);
        if (!n || (n == 1 && *p == '.') || (n == 2 && p[0] == '.' && p[1] == '.')) return 0;
        if (!end) return 1;
        p = end + 1;
    }
    return 0;
}
static int body(Writer *w, LVZipEntry *entry) {
    unsigned char buffer[65536];
    uLong crc = crc32(0L, Z_NULL, 0);
    uint64_t size = entry->length;
    int input = -1;
    if (entry->source_path) {
        if (entry->data || entry->length) return fail(EINVAL);
        input = open(entry->source_path, O_RDONLY | O_NOFOLLOW);
        if (input < 0) return -1;
        struct stat st;
        if (fstat(input, &st)) { int e = errno; close(input); return fail(e); }
        if (!S_ISREG(st.st_mode) || st.st_size < 0) { close(input); return fail(EINVAL); }
        size = (uint64_t)st.st_size;
    } else if (!entry->data && size) return fail(EINVAL);
    if (size > 1024ULL * 1024 * 1024) { if (input >= 0) close(input); return fail(EFBIG); }
    uint64_t offset = 0;
    int result = 0;
    while (offset < size) {
        size_t wanted = size - offset > sizeof(buffer) ? sizeof(buffer) : (size_t)(size - offset);
        const void *data = entry->data ? (const unsigned char *)entry->data + offset : buffer;
        if (input >= 0) {
            ssize_t n;
            do { n = read(input, buffer, wanted); } while (n < 0 && errno == EINTR);
            if (n <= 0) { result = fail(n ? errno : EIO); break; }
            wanted = (size_t)n;
        }
        if (bytes(w, data, wanted)) { result = -1; break; }
        crc = crc32(crc, data, (uInt)wanted);
        offset += wanted;
    }
    if (!result && input >= 0) {
        ssize_t n;
        do { n = read(input, buffer, 1); } while (n < 0 && errno == EINTR);
        if (n != 0) result = fail(n < 0 ? errno : EIO);
    }
    int saved = errno;
    if (input >= 0) close(input);
    if (result) return fail(saved);
    entry->written_size = (uint32_t)size;
    entry->crc32 = (uint32_t)crc;
    return 0;
}

int lv_zip_write(int fd, LVZipEntry *entries, size_t count, uint64_t limit) {
    if (fd < 0 || !entries || !count || count > 64 || !limit || limit > UINT32_MAX) return fail(EINVAL);
    uint32_t offsets[64];
    Writer w = { fd, 0, limit };
    for (size_t i = 0; i < count; ++i) {
        if (!name_valid(entries[i].name)) return fail(EINVAL);
        for (size_t j = 0; j < i; ++j)
            if (!strcmp(entries[i].name, entries[j].name)) return fail(EINVAL);
    }
    for (size_t i = 0; i < count; ++i) {
        LVZipEntry *e = &entries[i];
        offsets[i] = (uint32_t)w.position;
        unsigned char header[30] = {0};
        u32(header, 0x04034b50); u16(header + 4, 20); u16(header + 6, 0x808);
        u16(header + 12, 0x21); u16(header + 26, (uint16_t)strlen(e->name));
        if (bytes(&w, header, sizeof(header)) || bytes(&w, e->name, strlen(e->name)) || body(&w, e)) return -1;
        unsigned char descriptor[16];
        u32(descriptor, 0x08074b50); u32(descriptor + 4, e->crc32);
        u32(descriptor + 8, e->written_size); u32(descriptor + 12, e->written_size);
        if (bytes(&w, descriptor, sizeof(descriptor))) return -1;
    }
    uint32_t directory = (uint32_t)w.position;
    for (size_t i = 0; i < count; ++i) {
        LVZipEntry *e = &entries[i];
        unsigned char header[46] = {0};
        u32(header, 0x02014b50); u16(header + 4, 20); u16(header + 6, 20);
        u16(header + 8, 0x808); u16(header + 14, 0x21); u32(header + 16, e->crc32);
        u32(header + 20, e->written_size); u32(header + 24, e->written_size);
        u16(header + 28, (uint16_t)strlen(e->name)); u32(header + 42, offsets[i]);
        if (bytes(&w, header, sizeof(header)) || bytes(&w, e->name, strlen(e->name))) return -1;
    }
    uint32_t directory_size = (uint32_t)w.position - directory;
    unsigned char end[22] = {0};
    u32(end, 0x06054b50); u16(end + 8, (uint16_t)count); u16(end + 10, (uint16_t)count);
    u32(end + 12, directory_size); u32(end + 16, directory);
    return bytes(&w, end, sizeof(end));
}
