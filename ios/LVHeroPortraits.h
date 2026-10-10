#import <UIKit/UIKit.h>

/* Bundled official portraits, indexed by exact Wild Rift resource ID. */
@interface LVHeroPortraits : NSObject
- (instancetype)initWithDirectory:(NSString *)directory;
- (UIImage *)imageForResourceID:(int32_t)resourceID;
@property(nonatomic, readonly) NSUInteger availableCount;
@end
