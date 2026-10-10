#import "LVMachReader.h"
#include <mach-o/loader.h>
#include <unistd.h>
#include <stdint.h>

// This MIG routine is exported on iOS; the public SDK omits mach_vm.h.
extern kern_return_t mach_vm_read_overwrite(mach_port_t, uint64_t, uint64_t,
                                           uint64_t, uint64_t *);

@implementation LVMachReader {
    BOOL _ownsPort;
}
- (instancetype)initWithPID:(pid_t)pid {
    self = [super init];
    if (self) {
        if (pid == getpid()) {
            _task = mach_task_self();
            _connectionResult = KERN_SUCCESS;
        } else if (pid > 0) {
            _connectionResult = task_for_pid(mach_task_self(), pid, &_task);
            _ownsPort = _connectionResult == KERN_SUCCESS;
        } else {
            _connectionResult = KERN_INVALID_ARGUMENT;
        }
    }
    return self;
}
- (void)dealloc {
    if (_ownsPort && MACH_PORT_VALID(_task)) mach_port_deallocate(mach_task_self(), _task);
}
- (BOOL)readAddress:(uint64_t)address into:(void *)buffer length:(size_t)length {
    if (!buffer || !length || length > 1024 * 1024) return NO;
    memset(buffer, 0, length);
    if (!MACH_PORT_VALID(_task) || address > UINT64_MAX - length) return NO;
    uint64_t read = 0;
    kern_return_t result = mach_vm_read_overwrite(_task, address, length,
                                                 (uint64_t)(uintptr_t)buffer, &read);
    if (result == KERN_SUCCESS && read == length) return YES;
    memset(buffer, 0, length);
    return NO;
}
+ (NSDictionary *)selfTest {
    uint64_t marker = 0x4c564c4f4c4d3133ULL, copy = 0;
    LVMachReader *reader = [[self alloc] initWithPID:getpid()];
    BOOL pass = [reader readAddress:(uint64_t)(uintptr_t)&marker into:&copy length:sizeof(copy)] && copy == marker;
    return @{ @"pid": @(getpid()), @"uid": @(getuid()), @"self_read_ok": @(pass),
              @"task_result": @(reader.connectionResult) };
}
- (NSString *)readString:(uint64_t)address {
    if (!address || address > UINT64_MAX - 4096) return @"";
    NSMutableData *bytes = [NSMutableData new];
    // Read bounded chunks without crossing even a 4 KiB page subdivision.
    for (NSUInteger i = 0; i < 4096;) {
        char buffer[256];
        size_t count = MIN(sizeof(buffer), MIN(4096 - i, 4096 - ((address + i) & 4095)));
        if (![self readAddress:address + i into:buffer length:count]) return @"";
        const char *end = memchr(buffer, 0, count);
        [bytes appendBytes:buffer length:end ? (NSUInteger)(end - buffer) : count];
        if (end) return [[NSString alloc] initWithData:bytes encoding:NSUTF8StringEncoding] ?: @"";
        i += count;
    }
    return @"";
}
- (NSDictionary *)imageMetadata {
    if (!MACH_PORT_VALID(_task)) return @{ @"error": @"task port unavailable" };
    struct task_dyld_info dyld = {0};
    mach_msg_type_number_t count = TASK_DYLD_INFO_COUNT;
    kern_return_t result = task_info(_task, TASK_DYLD_INFO, (task_info_t)&dyld, &count);
    if (result != KERN_SUCCESS) return @{ @"task_info_result": @(result) };
    struct { uint32_t version, count; uint64_t array; } header = {0};
    if (![self readAddress:dyld.all_image_info_addr into:&header length:sizeof(header)] ||
        header.count > 4096 || !header.array || header.array > UINT64_MAX - header.count * 24ULL)
        return @{ @"error": @"dyld image list unreadable or invalid" };
    NSMutableArray *images = [NSMutableArray new];
    for (uint32_t i = 0; i < header.count; ++i) {
        struct { uint64_t loadAddress, path, modified; } info = {0};
        if (![self readAddress:header.array + i * sizeof(info) into:&info length:sizeof(info)]) break;
        NSString *path = [self readString:info.path];
        if (![path containsString:@".app/"]) continue;
        struct mach_header_64 mh = {0};
        if (![self readAddress:info.loadAddress into:&mh length:sizeof(mh)] ||
            mh.magic != MH_MAGIC_64 || mh.ncmds > 8192 || mh.sizeofcmds > 1024 * 1024) continue;
        NSMutableDictionary *item = [@{ @"path": path,
            @"load_address": [NSString stringWithFormat:@"0x%llx", (unsigned long long)info.loadAddress],
            @"cpu_type": @(mh.cputype), @"cpu_subtype": @(mh.cpusubtype) } mutableCopy];
        NSMutableData *commands = [NSMutableData dataWithLength:mh.sizeofcmds];
        if (mh.sizeofcmds && [self readAddress:info.loadAddress + sizeof(mh) into:commands.mutableBytes length:commands.length]) {
            const uint8_t *p = commands.bytes;
            size_t offset = 0;
            for (uint32_t j = 0; j < mh.ncmds; ++j) {
                if (offset + sizeof(struct load_command) > commands.length) break;
                const struct load_command *cmd = (const void *)(p + offset);
                if (cmd->cmdsize < sizeof(*cmd) || cmd->cmdsize > commands.length - offset) break;
                if (cmd->cmd == LC_UUID && cmd->cmdsize >= sizeof(struct uuid_command)) {
                    NSUUID *uuid = [[NSUUID alloc] initWithUUIDBytes:((const struct uuid_command *)cmd)->uuid];
                    item[@"uuid"] = uuid.UUIDString;
                }
                if (cmd->cmd == LC_ENCRYPTION_INFO_64 && cmd->cmdsize >= sizeof(struct encryption_info_command_64))
                    item[@"cryptid"] = @(((const struct encryption_info_command_64 *)cmd)->cryptid);
                offset += cmd->cmdsize;
            }
        }
        [images addObject:item];
    }
    return @{ @"images": images, @"dyld_version": @(header.version) };
}
@end
