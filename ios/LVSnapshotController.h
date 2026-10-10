#import <UIKit/UIKit.h>

@interface LVSnapshotController : UITableViewController
- (instancetype)initWithSnapshot:(NSDictionary *)snapshot sampledAt:(NSString *)sampledAt;
@end
