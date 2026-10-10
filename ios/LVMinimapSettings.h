#import <UIKit/UIKit.h>
#include "LVMinimap.h"
LVMinimapSettings LVLoadMinimapSettings(void);
NSString *LVMinimapSettingsText(void);
NSDictionary *LVMinimapSettingsDictionary(const LVMinimapSettings *settings);
@interface LVMinimapSettingsController : UITableViewController
@end
