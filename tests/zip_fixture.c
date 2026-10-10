#include "LVZip.h"
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char **argv) {
    if (argc != 4) return 2;
    int output = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0600);
    if (output < 0) return 3;
    static const unsigned char binary[] = {0, 255, 10, 128, 0, 42};
    LVZipEntry entries[] = {
        { .name = "manifest.json", .data = "{\"fixture\":true}\n", .length = 17 },
        { .name = "Bundle/Frameworks/UnityFramework", .source_path = argv[3] },
        { .name = "empty.dat" },
        { .name = "\xe6\xb5\x8b\xe8\xaf\x95.dat", .data = binary, .length = sizeof(binary) }
    };
    int expected = 0;
    uint64_t limit = 1024 * 1024;
    if (!strcmp(argv[1], "traversal")) { entries[1].name = "../outside"; expected = EINVAL; }
    else if (!strcmp(argv[1], "duplicate")) { entries[1].name = entries[0].name; expected = EINVAL; }
    else if (!strcmp(argv[1], "missing")) expected = ENOENT;
    else if (!strcmp(argv[1], "symlink")) expected = ELOOP;
    else if (!strcmp(argv[1], "directory")) expected = EINVAL;
    else if (!strcmp(argv[1], "large")) expected = EFBIG;
    else if (!strcmp(argv[1], "limit")) { limit = 100; expected = EFBIG; }
    else if (strcmp(argv[1], "valid")) { close(output); return 4; }
    int result = lv_zip_write(output, entries, 4, limit);
    int error = errno;
    close(output);
    if ((!expected && result == 0) || (expected && result == -1 && error == expected)) return 0;
    fprintf(stderr, "Unexpected ZIP result=%d errno=%d expected=%d\n", result, error, expected);
    return 1;
}
