#ifndef LV_ZIP_H
#define LV_ZIP_H
#include <stddef.h>
#include <stdint.h>

typedef struct {
    const char *name;
    const char *source_path; // Regular file, or NULL for memory data.
    const void *data;
    size_t length;
    uint32_t written_size, crc32;
} LVZipEntry;

// Streaming stored ZIP with CRC32, UTF-8 names, and data descriptors.
// Caller owns fd and must discard the entire output if this returns -1.
// No ZIP64, symlink inputs, traversal names, or files over 1 GiB.
int lv_zip_write(int fd, LVZipEntry *, size_t count, uint64_t maximum_bytes);
#endif
