#import "LVHelper.h"
#include <spawn.h>
#include <sys/wait.h>
#include <poll.h>
#include <signal.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

// Persona APIs documented by TrollStore's Root Helpers section / TSUtil.m.
extern int posix_spawnattr_set_persona_np(const posix_spawnattr_t *, uid_t, uint32_t);
extern int posix_spawnattr_set_persona_uid_np(const posix_spawnattr_t *, uid_t);
extern int posix_spawnattr_set_persona_gid_np(const posix_spawnattr_t *, uid_t);

NSDictionary *LVRunProbe(NSArray<NSString *> *arguments) {
    BOOL collecting = arguments.count == 3 && [arguments[0] isEqualToString:@"collect"];
    BOOL hudStart = arguments.count == 4 && [arguments[0] isEqualToString:@"hud-start"];
    BOOL hudControl = arguments.count == 2 &&
        ([arguments[0] isEqualToString:@"hud-status"] || [arguments[0] isEqualToString:@"hud-stop"]);
    if (!((arguments.count == 1 && [arguments[0] isEqualToString:@"list"]) ||
          ((arguments.count == 2 || arguments.count == 3) && [arguments[0] isEqualToString:@"probe"]) || collecting || hudStart || hudControl))
        return @{ @"error": @"unsupported helper command" };
    if (!collecting && arguments.count == 3 &&
        [arguments[2] lengthOfBytesUsingEncoding:NSUTF8StringEncoding] > 16384)
        return @{ @"error": @"probe configuration exceeds limit" };
    if (hudStart && [arguments[3] lengthOfBytesUsingEncoding:NSUTF8StringEncoding] > 16384)
        return @{ @"error": @"HUD configuration exceeds limit" };
    NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"LVProbe"];
    const char *argv[6] = { path.fileSystemRepresentation, NULL, NULL, NULL, NULL, NULL };
    for (NSUInteger i = 0; i < arguments.count; ++i) argv[i + 1] = arguments[i].UTF8String;
    int descriptors[2];
    if (pipe(descriptors)) return @{ @"error": @"pipe failed", @"errno": @(errno) };
    posix_spawnattr_t attrs;
    posix_spawn_file_actions_t actions;
    int error = posix_spawnattr_init(&attrs);
    if (error) { close(descriptors[0]); close(descriptors[1]); return @{ @"error": @"spawn attributes failed", @"code": @(error) }; }
    error = posix_spawn_file_actions_init(&actions);
    if (error) {
        posix_spawnattr_destroy(&attrs); close(descriptors[0]); close(descriptors[1]);
        return @{ @"error": @"spawn actions failed", @"code": @(error) };
    }
    error = posix_spawnattr_set_persona_np(&attrs, 99, 1);
    if (!error) error = posix_spawnattr_set_persona_uid_np(&attrs, 0);
    if (!error) error = posix_spawnattr_set_persona_gid_np(&attrs, 0);
    if (!error) error = posix_spawn_file_actions_adddup2(&actions, descriptors[1], STDOUT_FILENO);
    if (!error) error = posix_spawn_file_actions_adddup2(&actions, descriptors[1], STDERR_FILENO);
    if (!error) error = posix_spawn_file_actions_addclose(&actions, descriptors[0]);
    if (!error) error = posix_spawn_file_actions_addclose(&actions, descriptors[1]);
    pid_t child = 0;
    if (!error) error = posix_spawn(&child, path.fileSystemRepresentation, &actions, &attrs, (char *const *)argv, NULL);
    posix_spawn_file_actions_destroy(&actions);
    posix_spawnattr_destroy(&attrs);
    close(descriptors[1]);
    if (error) {
        close(descriptors[0]);
        return @{ @"error": @"root probe could not start", @"spawn_error": @(error) };
    }
    if (fcntl(descriptors[0], F_SETFL, O_NONBLOCK) < 0) {
        int pipeError = errno;
        kill(child, SIGKILL);
        while (waitpid(child, NULL, 0) < 0 && errno == EINTR) {}
        close(descriptors[0]);
        return @{ @"error": @"nonblocking probe pipe failed", @"errno": @(pipeError) };
    }
    NSMutableData *output = [NSMutableData new];
    NSTimeInterval deadline = NSProcessInfo.processInfo.systemUptime + (collecting ? 120 : (hudStart ? 15 : 8));
    BOOL exited = NO, eof = NO, timedOut = NO;
    int status = 0;
    while (!exited || !eof) {
        if (NSProcessInfo.processInfo.systemUptime >= deadline) { timedOut = YES; break; }
        struct pollfd pfd = { .fd = descriptors[0], .events = POLLIN | POLLHUP };
        poll(&pfd, 1, 100);
        char buffer[4096];
        ssize_t readCount;
        while ((readCount = read(descriptors[0], buffer, sizeof(buffer))) > 0) {
            [output appendBytes:buffer length:(NSUInteger)readCount];
            if (output.length > 1024 * 1024) { timedOut = YES; break; }
        }
        if (readCount == 0) eof = YES;
        if (!exited) {
            pid_t result = waitpid(child, &status, WNOHANG);
            if (result == child || (result < 0 && errno != EINTR)) exited = YES;
        }
        if (timedOut) break;
    }
    if (!exited) {
        kill(child, SIGKILL);
        while (waitpid(child, &status, 0) < 0 && errno == EINTR) {}
    }
    close(descriptors[0]);
    if (timedOut) return @{ @"error": @"probe timed out or exceeded output limit" };
    if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
        return @{ @"error": @"probe exited unexpectedly", @"wait_status": @(status) };
    id parsed = [NSJSONSerialization JSONObjectWithData:output options:0 error:NULL];
    if (![parsed isKindOfClass:NSDictionary.class]) return @{ @"error": @"invalid probe response" };
    return parsed;
}
