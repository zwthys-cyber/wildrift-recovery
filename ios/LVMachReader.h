#import <Foundation/Foundation.h>
#include <mach/mach.h>

// Read adapter only. A denied task port remains a denied task port.
@interface LVMachReader : NSObject
@property(nonatomic, readonly) mach_port_t task;
@property(nonatomic, readonly) kern_return_t connectionResult;
- (instancetype)initWithPID:(pid_t)pid;
- (BOOL)readAddress:(uint64_t)address into:(void *)buffer length:(size_t)length;
- (NSDictionary *)imageMetadata;
+ (NSDictionary *)selfTest;
@end
