#import "LVCollect.h"
#import "LVGameIdentity.h"
#import "LVMachReader.h"
#include "LVZip.h"
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>

extern int proc_pidpath(int, void *, uint32_t);

static NSString *canonical(NSString *path) {
    char buffer[PATH_MAX];
    return realpath(path.fileSystemRepresentation, buffer) ? [NSString stringWithUTF8String:buffer] : nil;
}
static NSDictionary *failure(NSString *message) { return @{ @"error": message, @"errno": @(errno) }; }

static NSDictionary *collectInputs(pid_t pid, NSString *documents, BOOL engineOnly) {
    // Restrict output to this app's verified Documents container.
    NSString *output = canonical(documents);
    if (!output || ![output.lastPathComponent isEqualToString:@"Documents"] ||
        ![output hasPrefix:@"/private/var/mobile/Containers/Data/Application/"])
        return failure(@"invalid recovery Documents directory");
    NSString *container = output.stringByDeletingLastPathComponent;
    NSUUID *containerID = [[NSUUID alloc] initWithUUIDString:container.lastPathComponent];
    NSDictionary *containerInfo = [NSDictionary dictionaryWithContentsOfFile:
        [container stringByAppendingPathComponent:@".com.apple.mobile_container_manager.metadata.plist"]];
    if (!containerID || ![containerInfo[@"MCMMetadataIdentifier"] isEqualToString:@"local.wildrift.recovery"])
        return failure(@"destination container identity could not be verified");
    struct stat destination;
    if (stat(output.fileSystemRepresentation, &destination) || !S_ISDIR(destination.st_mode) || destination.st_uid != 501)
        return failure(@"destination is not the recovery app Documents directory");

    char executable[4096] = {0};
    if (pid <= 0 || proc_pidpath(pid, executable, sizeof(executable)) <= 0) return failure(@"selected game process is unavailable");
    NSString *main = canonical([NSString stringWithUTF8String:executable]);
    NSString *bundle = main.stringByDeletingLastPathComponent;
    if (!LVGameMatchesExecutablePath(main))
        return failure(@"selected process is not the international Wild Rift application");
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[bundle stringByAppendingPathComponent:@"Info.plist"]];
    if (![info[@"CFBundleExecutable"] isEqualToString:LV_GAME_EXECUTABLE]) return failure(@"game bundle executable identity mismatch");

    LVMachReader *reader = [[LVMachReader alloc] initWithPID:pid];
    if (reader.connectionResult != KERN_SUCCESS)
        return @{ @"error": @"game task port unavailable", @"task_result": @(reader.connectionResult) };
    NSDictionary *metadata = [reader imageMetadata];
    NSArray *images = metadata[@"images"];
    NSString *unityPath = nil;
    NSDictionary *unityImage = nil;
    NSString *enginePath = nil;
    NSDictionary *engineImage = nil;
    for (NSDictionary *image in images) {
        if ([image[@"path"] hasSuffix:@"/Frameworks/UnityFramework.framework/UnityFramework"]) {
            unityPath = canonical(image[@"path"]); unityImage = image;
        } else if ([image[@"path"] hasSuffix:@"/Frameworks/FEProj.framework/FEProj"]) {
            enginePath = canonical(image[@"path"]); engineImage = image;
        }
    }
    NSString *prefix = [bundle stringByAppendingString:@"/"];
    if (!engineOnly && (!unityPath || ![unityPath hasPrefix:prefix]))
        return failure(@"loaded UnityFramework file could not be located within the game bundle");
    if (engineOnly && (!enginePath || ![enginePath hasPrefix:prefix]))
        return failure(@"loaded FEProj file could not be located within the game bundle");

    NSMutableArray<NSDictionary *> *files = [NSMutableArray new];
    NSMutableArray<NSString *> *missing = [NSMutableArray new];
    NSMutableArray *candidates = [NSMutableArray new];
    if (!engineOnly) [candidates addObjectsFromArray:@[
        @{ @"relative": @"Info.plist", @"role": @"bundle_info" },
        @{ @"relative": LV_GAME_EXECUTABLE, @"role": @"main_executable" },
        @{ @"relative": [unityPath substringFromIndex:prefix.length], @"role": @"unity_framework" },
        @{ @"relative": @"Frameworks/UnityFramework.framework/Info.plist", @"role": @"framework_info" }
    ]];
    if (enginePath && [enginePath hasPrefix:prefix]) [candidates addObjectsFromArray:@[
        @{ @"relative": [enginePath substringFromIndex:prefix.length], @"role": @"native_engine" },
        @{ @"relative": @"Frameworks/FEProj.framework/Info.plist", @"role": @"native_engine_info" }
    ]];
    // Metadata locations vary. Search only the selected read-only app bundle,
    // with finite traversal and file limits; skip symlinks and unrelated data.
    __block NSUInteger searchErrors = 0;
    NSDirectoryEnumerator *enumerator = engineOnly ? nil : [NSFileManager.defaultManager enumeratorAtURL:[NSURL fileURLWithPath:bundle]
        includingPropertiesForKeys:@[NSURLIsRegularFileKey, NSURLIsSymbolicLinkKey]
        options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:^BOOL(NSURL *url, NSError *error) { ++searchErrors; return YES; }];
    NSUInteger visited = 0;
    NSTimeInterval searchDeadline = NSProcessInfo.processInfo.systemUptime + 15;
    BOOL searchComplete = YES;
    for (NSURL *url in enumerator) {
        if (++visited > 50000 || NSProcessInfo.processInfo.systemUptime > searchDeadline) { searchComplete = NO; break; }
        NSNumber *link = nil;
        [url getResourceValue:&link forKey:NSURLIsSymbolicLinkKey error:NULL];
        if (link.boolValue) { [enumerator skipDescendants]; continue; }
        if (![url.lastPathComponent isEqualToString:@"global-metadata.dat"]) continue;
        NSString *path = canonical(url.path);
        if (!path || ![path hasPrefix:prefix]) continue;
        [candidates addObject:@{ @"relative": [path substringFromIndex:prefix.length], @"role": @"il2cpp_metadata" }];
        if (candidates.count >= 32) { searchComplete = NO; break; }
    }
    searchComplete = searchComplete && enumerator != nil && searchErrors == 0;
    uint64_t total = 0;
    NSMutableSet *seen = [NSMutableSet new];
    for (NSDictionary *candidate in candidates) {
        NSString *relative = candidate[@"relative"];
        NSString *path = canonical([bundle stringByAppendingPathComponent:relative]);
        if (!path || ![path hasPrefix:prefix]) { [missing addObject:relative]; continue; }
        if ([seen containsObject:path]) continue;
        struct stat st;
        if (lstat(path.fileSystemRepresentation, &st) || !S_ISREG(st.st_mode) || st.st_size < 0 || st.st_size > 1024LL * 1024 * 1024) {
            [missing addObject:relative]; continue;
        }
        [seen addObject:path];
        total += (uint64_t)st.st_size;
        if (total > 1900ULL * 1024 * 1024) return failure(@"selected files exceed the 1.9 GiB collection limit");
        [files addObject:@{ @"source_path": path, @"archive_path": [@"Bundle/" stringByAppendingString:relative],
            @"role": candidate[@"role"], @"size": @((uint64_t)st.st_size) }];
    }
    if (!engineOnly && ![seen containsObject:unityPath]) return failure(@"UnityFramework is not a readable regular file");
    BOOL hasEngine = enginePath && [seen containsObject:enginePath];
    if (engineOnly && !hasEngine) return failure(@"FEProj is not a readable regular file");
    BOOL hasMetadata = NO;
    for (NSDictionary *file in files) if ([file[@"role"] isEqualToString:@"il2cpp_metadata"]) hasMetadata = YES;
    NSDictionary *manifest = @{ @"format": @"lvlolm-ios-inputs", @"format_version": @1,
        @"collector_version": @"0.8.0", @"collection_scope": engineOnly ? @"native_engine_only" : @"unity_metadata_and_engine",
        @"target_pid": @(pid), @"helper_uid": @(getuid()),
        @"user_reported_app_version": @"7.3.0.2813", @"user_reported_resource_version": @"not provided",
        @"bundle_identifier": info[@"CFBundleIdentifier"] ?: @"", @"app_version": info[@"CFBundleShortVersionString"] ?: @"",
        @"build_version": info[@"CFBundleVersion"] ?: @"", @"device_images": images ?: @[],
        @"files": files, @"missing_files": missing, @"metadata_found": @(hasMetadata),
        @"native_engine_found": @(hasEngine), @"native_engine_uuid": engineImage[@"uuid"] ?: @"",
        @"metadata_search_performed": @(!engineOnly),
        @"metadata_search_complete": @(searchComplete), @"metadata_search_errors": @(searchErrors), @"bundle_entries_visited": @(visited),
        @"collection_mode": @"unchanged on-disk files; no decryption or memory dump" };
    NSData *json = [NSJSONSerialization dataWithJSONObject:manifest options:NSJSONWritingPrettyPrinted error:NULL];
    if (!json || json.length > 1024 * 1024) return failure(@"collection manifest could not be generated");

    NSString *template = [output stringByAppendingPathComponent:@".lvlolm-inputs-XXXXXX"];
    char temp[PATH_MAX];
    if (strlen(template.fileSystemRepresentation) >= sizeof(temp)) return failure(@"output path exceeds limit");
    strcpy(temp, template.fileSystemRepresentation);
    int fd = mkstemp(temp);
    if (fd < 0) return failure(@"cannot create the collection archive");
    LVZipEntry entries[33] = {0};
    entries[0] = (LVZipEntry){ .name = "manifest.json", .data = json.bytes, .length = json.length };
    for (NSUInteger i = 0; i < files.count; ++i)
        entries[i + 1] = (LVZipEntry){ .name = [files[i][@"archive_path"] UTF8String], .source_path = [files[i][@"source_path"] fileSystemRepresentation] };
    int result = lv_zip_write(fd, entries, files.count + 1, 2ULL * 1024 * 1024 * 1024);
    if (!result && (fchown(fd, destination.st_uid, (gid_t)-1) || fchmod(fd, 0600) || fsync(fd))) result = -1;
    int saved = errno;
    if (close(fd) && !result) { result = -1; saved = errno; }
    NSString *archive = [output stringByAppendingPathComponent:engineOnly ? @"lvlolm-ios-engine.zip" : @"lvlolm-ios-inputs.zip"];
    if (!result && rename(temp, archive.fileSystemRepresentation)) { result = -1; saved = errno; }
    if (result) { unlink(temp); errno = saved; return failure(@"game file collection failed"); }
    return @{ @"success": @YES, @"archive_path": archive, @"files_collected": @(files.count),
        @"metadata_found": @(hasMetadata), @"metadata_search_complete": @(searchComplete),
        @"metadata_search_performed": @(!engineOnly), @"collection_scope": manifest[@"collection_scope"],
        @"native_engine_found": @(hasEngine), @"native_engine_uuid": engineImage[@"uuid"] ?: @"",
        @"unity_uuid": unityImage[@"uuid"] ?: @"", @"helper_uid": @(getuid()),
        @"collection_mode": manifest[@"collection_mode"] };
}

NSDictionary *LVCollectInputs(pid_t pid, NSString *documents) { return collectInputs(pid, documents, NO); }
NSDictionary *LVCollectEngineInputs(pid_t pid, NSString *documents) { return collectInputs(pid, documents, YES); }
