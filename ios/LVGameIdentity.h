#import <Foundation/Foundation.h>

#define LV_GAME_EXECUTABLE @"wildrift"
#define LV_GAME_BUNDLE_ID @"com.riotgames.league.wildrift"

/* Validate the selected installed international application at each boundary. */
static inline BOOL LVGameMatchesExecutablePath(NSString *path) {
    if (![path isKindOfClass:NSString.class] ||
        ![path hasSuffix:@"/wildrift.app/wildrift"] ||
        !([path hasPrefix:@"/private/var/containers/Bundle/Application/"] ||
          [path hasPrefix:@"/var/containers/Bundle/Application/"])) return NO;
    NSString *bundle = path.stringByDeletingLastPathComponent;
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:
        [bundle stringByAppendingPathComponent:@"Info.plist"]];
    return [info[@"CFBundleIdentifier"] isEqualToString:LV_GAME_BUNDLE_ID] &&
           [info[@"CFBundleExecutable"] isEqualToString:LV_GAME_EXECUTABLE];
}
