#import <Foundation/Foundation.h>
/* A bounded local trace in a root-owned per-session directory. Never a dump. */
BOOL LVHUDWriteTrace(NSString *session, NSDictionary *trace);
NSDictionary *LVHUDReadTrace(NSString *session);
void LVHUDRemoveTrace(NSString *session);
