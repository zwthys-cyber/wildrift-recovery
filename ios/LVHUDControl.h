#import <Foundation/Foundation.h>
#include <sys/types.h>
#include "LVHUDTelemetry.h"

// Commands are confined to the bundled LVHUD and one random session token.
NSDictionary *LVHUDStart(pid_t target, NSString *session, NSString *config);
NSDictionary *LVHUDStatus(NSString *session);
NSDictionary *LVHUDStop(NSString *session);
BOOL LVHUDSessionValid(NSString *session);
NSString *LVHUDNotification(NSString *session, BOOL stopping);
NSString *LVHUDExecutablePath(void);
NSString *LVHUDMetricNotification(NSString *session, size_t index);
