#import <Foundation/Foundation.h>
#import "LVMachReader.h"
#import "LVCollect.h"
#import "LVSnapshot.h"
#import "LVHUDControl.h"
#include <sys/sysctl.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>

extern int proc_pidpath(int, void *, uint32_t);

static NSDictionary *processes(void) {
    int mib[] = { CTL_KERN, KERN_PROC, KERN_PROC_ALL };
    size_t bytes = 0;
    if (sysctl(mib, 3, NULL, &bytes, NULL, 0) || bytes > 32 * 1024 * 1024)
        return @{ @"error": @"process enumeration unavailable", @"errno": @(errno) };
    bytes += 16 * sizeof(struct kinfo_proc);
    struct kinfo_proc *list = calloc(1, bytes);
    if (!list) return @{ @"error": @"allocation failed" };
    if (sysctl(mib, 3, list, &bytes, NULL, 0)) {
        int e = errno; free(list);
        return @{ @"error": @"process enumeration failed", @"errno": @(e) };
    }
    NSMutableArray *apps = [NSMutableArray new];
    for (size_t i = 0; i < bytes / sizeof(*list); ++i) {
        pid_t pid = list[i].kp_proc.p_pid;
        if (pid <= 0 || pid == getpid()) continue;
        char path[4096] = {0};
        if (proc_pidpath(pid, path, sizeof(path)) <= 0) continue;
        NSString *p = [NSString stringWithUTF8String:path];
        if (![p containsString:@".app/"] || [p containsString:@"LVRecovery.app/"]) continue;
        [apps addObject:@{ @"pid": @(pid), @"name": p.lastPathComponent, @"path": p }];
    }
    free(list);
    return @{ @"processes": apps, @"uid": @(getuid()), @"helper_pid": @(getpid()) };
}

static pid_t parsePID(const char *value) {
    char *end = NULL;
    errno = 0;
    long pid = strtol(value, &end, 10);
    return !errno && end != value && !*end && pid > 0 && pid <= INT_MAX ? (pid_t)pid : 0;
}

int main(int argc, char **argv) {
    @autoreleasepool {
        NSDictionary *report;
        if (argc == 2 && !strcmp(argv[1], "list")) {
            report = processes();
        } else if ((argc == 3 || argc == 4) && !strcmp(argv[1], "probe")) {
            pid_t pid = parsePID(argv[2]);
            if (!pid) return 2;
            LVConfig config; lv_config_defaults(&config);
            LVMinimapSettings map; lv_minimap_defaults(&map);
            if (argc == 4 && (strnlen(argv[3], 16385) > 16384 || lv_config_parse(&config, argv[3], NULL) ||
                !lv_minimap_parse(&map, argv[3]))) return 2;
            LVMachReader *reader = [[LVMachReader alloc] initWithPID:pid];
            NSMutableDictionary *r = [@{ @"target_pid": @(pid), @"uid": @(getuid()),
                @"task_result": @(reader.connectionResult),
                @"task_message": [NSString stringWithUTF8String:mach_error_string(reader.connectionResult)] ?: @"unknown",
                @"self_test": [LVMachReader selfTest],
                @"game_app_version": @"7.3.0.2813", @"game_resource_version": @"7.3.19.51",
                @"game_version_source": @"user_reported" } mutableCopy];
            r[@"preview_config_source"] = argc == 4 ? @"app_settings_at_probe_start" : @"recovered_defaults";
            if (reader.connectionResult == KERN_SUCCESS) {
                NSDictionary *metadata = [reader imageMetadata];
                r[@"metadata"] = metadata;
                r[@"game_snapshot"] = LVReadTargetSnapshot(reader, metadata, &config, &map);
            }
            report = r;
        } else if (argc == 5 && !strcmp(argv[1], "hud-start")) {
            pid_t pid = parsePID(argv[2]);
            NSString *session = [NSString stringWithUTF8String:argv[3]];
            NSString *configText = [NSString stringWithUTF8String:argv[4]];
            LVConfig config; lv_config_defaults(&config);
            if (!pid || !LVHUDSessionValid(session) || !configText || strnlen(argv[4], 16385) > 16384 ||
                lv_config_parse(&config, argv[4], NULL)) return 2;
            report = LVHUDStart(pid, session, configText);
        } else if (argc == 3 && (!strcmp(argv[1], "hud-status") || !strcmp(argv[1], "hud-stop"))) {
            NSString *session = [NSString stringWithUTF8String:argv[2]];
            if (!LVHUDSessionValid(session)) return 2;
            report = !strcmp(argv[1], "hud-stop") ? LVHUDStop(session) : LVHUDStatus(session);
        } else if (argc == 4 && !strcmp(argv[1], "collect")) {
            pid_t pid = parsePID(argv[2]);
            NSString *directory = [NSString stringWithUTF8String:argv[3]];
            if (!pid || !directory) return 2;
            report = LVCollectInputs(pid, directory);
        } else {
            return 2;
        }
        NSData *json = [NSJSONSerialization dataWithJSONObject:report options:0 error:NULL];
        if (!json) return 3;
        if (fwrite(json.bytes, 1, json.length, stdout) != json.length) return 4;
        fputc('\n', stdout);
        return 0;
    }
}
