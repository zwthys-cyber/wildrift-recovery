#import "LVGameIdentity.h"
#import "LVHUDControl.h"
#import "LVHUDTrace.h"
#include <mach-o/dyld.h>
#include <notify.h>
#include <spawn.h>
#include <poll.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <errno.h>
#include <limits.h>

extern int proc_pidpath(int, void *, uint32_t);
static const uint64_t HUD_MARKER = UINT64_C(0x4c56485500000000);

BOOL LVHUDSessionValid(NSString *session) {
    return [session isKindOfClass:NSString.class] && session.length == 36 &&
        [[NSUUID alloc] initWithUUIDString:session] != nil;
}
NSString *LVHUDNotification(NSString *session, BOOL stopping) {
    return [NSString stringWithFormat:@"local.wildrift.recovery.hud.%@.%@", session.lowercaseString,
        stopping ? @"stop" : @"state"];
}
NSString *LVHUDMetricNotification(NSString *session, size_t index) {
    static const char *const names[LV_HUD_METRIC_WORDS] = {
        "owner", "sequence", "frames", "time", "data", "cooldown", "stock", "reserved", "mapdetail"
    };
    if (!LVHUDSessionValid(session) || index >= LV_HUD_METRIC_WORDS) return nil;
    return [NSString stringWithFormat:@"local.wildrift.recovery.hud.%@.metrics.%s", session.lowercaseString, names[index]];
}
static NSDictionary *samplingStatus(NSString *session, pid_t pid) {
    int tokens[LV_HUD_METRIC_WORDS];
    for (size_t i = 0; i < LV_HUD_METRIC_WORDS; ++i) tokens[i] = -1;
    uint32_t code = 0;
    for (size_t i = 0; i < LV_HUD_METRIC_WORDS && !code; ++i)
        code = notify_register_check(LVHUDMetricNotification(session, i).UTF8String, &tokens[i]);
    LVHUDMetrics metrics = {0}; BOOL complete = NO;
    for (unsigned attempt = 0; !code && !complete && attempt < 3; ++attempt) {
        uint64_t words[LV_HUD_METRIC_WORDS] = {0}, ownerAfter = 0, sequenceAfter = 0;
        code = notify_get_state(tokens[LV_HUD_OWNER], &words[LV_HUD_OWNER]);
        if (!code) code = notify_get_state(tokens[LV_HUD_SEQUENCE], &words[LV_HUD_SEQUENCE]);
        if (code) break;
        if (!words[LV_HUD_SEQUENCE] || (words[LV_HUD_SEQUENCE] & 1)) continue;
        for (size_t i = LV_HUD_FRAMES; i < LV_HUD_METRIC_WORDS && !code; ++i)
            code = notify_get_state(tokens[i], &words[i]);
        if (!code) code = notify_get_state(tokens[LV_HUD_SEQUENCE], &sequenceAfter);
        if (!code) code = notify_get_state(tokens[LV_HUD_OWNER], &ownerAfter);
        if (code) break;
        if (ownerAfter != words[LV_HUD_OWNER] || sequenceAfter != words[LV_HUD_SEQUENCE]) continue;
        uint64_t now = (uint64_t)(NSProcessInfo.processInfo.systemUptime * 1000.0);
        complete = lv_hud_metrics_decode(words, (uint32_t)pid, now, &metrics) != 0;
    }
    for (size_t i = 0; i < LV_HUD_METRIC_WORDS; ++i) if (tokens[i] >= 0) notify_cancel(tokens[i]);
    if (code) return @{ @"available": @NO, @"reason": @"metrics_notification_failed", @"notify_code": @(code) };
    if (!complete) return @{ @"available": @NO, @"reason": @"no_complete_sample_or_incompatible_hud" };
    NSMutableDictionary *report = [@{ @"available": @YES, @"protocol_version": @LV_HUD_METRIC_VERSION,
        @"frames_completed": @(metrics.frames), @"heartbeat_age_seconds": @(metrics.age_seconds),
        @"fresh": @(metrics.fresh != 0), @"freshness_limit_seconds": @3,
        @"last_result": [NSString stringWithUTF8String:lv_hud_result_name(metrics.result)],
        @"latest_snapshot_usable": @(metrics.snapshot_usable != 0),
        @"read_actor_count": @(metrics.actor_count), @"skipped_actor_count": @(metrics.skipped_count),
        @"orientation_raw": @(metrics.orientation), @"cooldown_read_ok": @(metrics.cooldown_ok != 0),
        @"stock_read_ok": @(metrics.stock_ok != 0),
        @"minimap_enabled": @(metrics.minimap_enabled != 0), @"minimap_projection_ready": @(metrics.map_projection_ok != 0),
        @"manual_minimap_projection": @(metrics.map_manual != 0),
        @"confirmed_enemy_hero_count": @(metrics.enemy_count), @"prepared_enemy_marker_count": @(metrics.enemy_markers),
        @"unplaced_enemy_count": @(metrics.enemy_unplaced),
        @"displayed_enemy_marker_count": @(metrics.displayed_markers),
        @"health_ring_enemy_marker_count": @(metrics.health_ring_markers),
        @"edge_clamped_enemy_marker_count": @(metrics.edge_clamped_markers),
        @"scope": @"Last HUD sample assigned to views; separate from target_probe snapshot. Enemy marker count means prepared coordinates, not proof of visibility or alignment. Fresh heartbeat does not prove screen visibility, orientation correctness or touch passthrough." } mutableCopy];
    if (metrics.cooldown_ok) [report addEntriesFromDictionary:@{ @"smite_cooldown_fixed": @(metrics.cooldown_fixed),
        @"smite_cooldown_seconds": @((double)metrics.cooldown_fixed / 16384.0) }];
    if (metrics.stock_ok) [report addEntriesFromDictionary:@{ @"smite_stock_current": @(metrics.stock_current), @"smite_stock_maximum": @(metrics.stock_maximum) }];
    return report;
}
NSString *LVHUDExecutablePath(void) {
    char buffer[PATH_MAX]; uint32_t size = sizeof(buffer);
    if (_NSGetExecutablePath(buffer, &size)) return nil;
    NSString *path = [[NSString stringWithUTF8String:buffer] stringByResolvingSymlinksInPath];
    return [path.stringByDeletingLastPathComponent stringByAppendingPathComponent:@"LVHUD"];
}
NSDictionary *LVHUDStatus(NSString *session) {
    if (!LVHUDSessionValid(session)) return @{ @"error": @"invalid HUD session" };
    int token = 0; uint64_t state = 0;
    uint32_t code = notify_register_check(LVHUDNotification(session, NO).UTF8String, &token);
    if (!code) { code = notify_get_state(token, &state); notify_cancel(token); }
    if (code) return @{ @"error": @"HUD state unavailable", @"notify_code": @(code) };
    pid_t pid = (pid_t)(state & UINT32_MAX);
    char path[PATH_MAX] = {0};
    BOOL running = (state & UINT64_C(0xffffffff00000000)) == HUD_MARKER && pid > 0 &&
        proc_pidpath(pid, path, sizeof(path)) > 0 &&
        [[[NSString stringWithUTF8String:path] stringByResolvingSymlinksInPath] isEqualToString:LVHUDExecutablePath()];
    NSMutableDictionary *report=[@{ @"running": @(running), @"hud_pid": running ? @(pid) : @0,
        @"mode": @"read_only_live_hud", @"simulation_only": @YES,
        @"visible_on_device_verified": @NO, @"touch_backend_available": @NO,
        @"sampling": running ? samplingStatus(session, pid) : @{ @"available": @NO, @"reason": @"hud_not_running" } } mutableCopy];
    NSDictionary *trace=LVHUDReadTrace(session);
    if(trace && (!running || [trace[@"producer_pid"] intValue]==pid)) report[@"coordinate_trace"]=trace;
    return report;
}
NSDictionary *LVHUDStop(NSString *session) {
    if (!LVHUDSessionValid(session)) return @{ @"error": @"invalid HUD session" };
    NSDictionary *before = LVHUDStatus(session);
    if (before[@"error"]) return before;
    uint32_t code = notify_post(LVHUDNotification(session, YES).UTF8String);
    if (code) return @{ @"error": @"HUD stop notification failed", @"notify_code": @(code) };
    /* Poll only our session's state. No stored PID is ever used for killing. */
    for (unsigned i = 0; i < 20; ++i) {
        NSDictionary *status = LVHUDStatus(session);
        if (status[@"error"]) return status;
        if (![status[@"running"] boolValue]) {
            LVHUDRemoveTrace(session);
            return @{ @"stop_requested": @YES, @"running": @NO, @"prior_status": before };
        }
        usleep(50000);
    }
    return @{ @"stop_requested": @YES, @"running": @YES, @"prior_status": before };
}
NSDictionary *LVHUDStart(pid_t target, NSString *session, NSString *config) {
    if (getuid() != 0) return @{ @"error": @"HUD launcher requires the root helper" };
    if (!LVHUDSessionValid(session) || target <= 0 || !config ||
        [config lengthOfBytesUsingEncoding:NSUTF8StringEncoding] > 16384)
        return @{ @"error": @"invalid HUD launch arguments" };
    NSDictionary *existing = LVHUDStatus(session);
    if (existing[@"error"]) return existing;
    if ([existing[@"running"] boolValue]) return existing;
    char targetPath[PATH_MAX] = {0};
    if (proc_pidpath(target, targetPath, sizeof(targetPath)) <= 0 ||
        !LVGameMatchesExecutablePath([NSString stringWithUTF8String:targetPath]))
        return @{ @"error": @"HUD target must be the selected international Wild Rift process" };
    NSString *path = LVHUDExecutablePath();
    if (!path) return @{ @"error": @"HUD executable path unavailable" };
    int fds[2];
    if (pipe(fds)) return @{ @"error": @"HUD startup pipe failed", @"errno": @(errno) };
    /* Keep the handshake descriptor above stdin/out/err and reserve fd 3. */
    int writeFD = fcntl(fds[1], F_DUPFD_CLOEXEC, 10); close(fds[1]);
    if (writeFD < 0) { close(fds[0]); return @{ @"error": @"HUD pipe duplication failed", @"errno": @(errno) }; }
    posix_spawnattr_t attrs; posix_spawn_file_actions_t actions;
    int error = posix_spawnattr_init(&attrs);
    if (error) { close(fds[0]); close(writeFD); return @{ @"error": @"HUD spawn attributes failed", @"code": @(error) }; }
    error = posix_spawn_file_actions_init(&actions);
    if (error) { posix_spawnattr_destroy(&attrs); close(fds[0]); close(writeFD);
        return @{ @"error": @"HUD spawn actions failed", @"code": @(error) }; }
    if (!error) error = posix_spawnattr_setpgroup(&attrs, 0);
    if (!error) error = posix_spawnattr_setflags(&attrs, POSIX_SPAWN_SETPGROUP);
    if (!error) error = posix_spawn_file_actions_addclose(&actions, fds[0]);
    if (!error) error = posix_spawn_file_actions_adddup2(&actions, writeFD, 3);
    if (!error) error = posix_spawn_file_actions_addclose(&actions, writeFD);
    if (!error) error = posix_spawn_file_actions_addopen(&actions, STDIN_FILENO, "/dev/null", O_RDONLY, 0);
    if (!error) error = posix_spawn_file_actions_addopen(&actions, STDOUT_FILENO, "/dev/null", O_WRONLY, 0);
    if (!error) error = posix_spawn_file_actions_addopen(&actions, STDERR_FILENO, "/dev/null", O_WRONLY, 0);
    NSString *pidString = [NSString stringWithFormat:@"%d", target];
    const char *args[] = {path.fileSystemRepresentation, pidString.UTF8String, session.UTF8String, config.UTF8String, NULL};
    pid_t child = 0;
    if (!error) error = posix_spawn(&child, path.fileSystemRepresentation, &actions, &attrs, (char *const *)args, NULL);
    posix_spawn_file_actions_destroy(&actions); posix_spawnattr_destroy(&attrs); close(writeFD);
    if (error) { close(fds[0]); return @{ @"error": @"HUD could not start", @"spawn_error": @(error) }; }
    int flags = fcntl(fds[0], F_GETFL);
    BOOL failed = flags < 0 || fcntl(fds[0], F_SETFL, flags | O_NONBLOCK) < 0;
    NSMutableData *data = [NSMutableData new]; BOOL eof = NO;
    NSTimeInterval deadline = NSProcessInfo.processInfo.systemUptime + 6;
    while (!failed && !eof && NSProcessInfo.processInfo.systemUptime < deadline) {
        struct pollfd pollFD = {.fd = fds[0], .events = POLLIN | POLLHUP}; poll(&pollFD, 1, 100);
        char buffer[1024]; ssize_t n;
        while ((n = read(fds[0], buffer, sizeof(buffer))) > 0) {
            [data appendBytes:buffer length:(NSUInteger)n];
            if (data.length > 8192) { failed = YES; break; }
        }
        if (!n) eof = YES;
        else if (n < 0 && errno != EAGAIN && errno != EINTR) failed = YES;
    }
    close(fds[0]);
    NSDictionary *reply = eof && !failed ? [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] : nil;
    if (![reply isKindOfClass:NSDictionary.class] || ![reply[@"running"] boolValue]) {
        /* Only this newly spawned child is eligible for termination. */
        int status = 0; pid_t result = waitpid(child, &status, WNOHANG);
        if (!result) { kill(child, SIGKILL); while (waitpid(child, &status, 0) < 0 && errno == EINTR) {} }
        return [reply isKindOfClass:NSDictionary.class] ? reply :
            @{ @"error": @"HUD startup handshake failed", @"wait_status": @(status) };
    }
    /* The root HUD deliberately outlives this short-lived helper. */
    return reply;
}
