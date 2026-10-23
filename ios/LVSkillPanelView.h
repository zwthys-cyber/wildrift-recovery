#import <UIKit/UIKit.h>
@class LVHeroPortraits;
@interface LVSkillPanelView : UIView
@property(nonatomic,copy) NSArray<NSDictionary *> *heroes;
@property(nonatomic,copy) NSString *statusReason;
@property(nonatomic,strong) LVHeroPortraits *portraitStore;
@property(nonatomic) CGFloat displayScale;
@end
