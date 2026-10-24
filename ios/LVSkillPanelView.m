#import "LVSkillPanelView.h"
#import "LVHeroPortraits.h"

static NSString *summonerSpellName(NSDictionary *skill) {
    /* International ENUM_SUMMON_SKILL_TYPE values recovered from original
       metadata; see analysis/international-spell-ids.json. */
    NSDictionary *names=@{ @81010101:@"疾跑", @81020101:@"雪球", @81030101:@"治疗",
        @81041011:@"清晰术", @81050101:@"屏障", @81060101:@"虚弱", @81090101:@"闪现",
        @81100101:@"引燃", @81110101:@"惩戒", @81140101:@"自动惩戒",
        @89030101:@"雪球", @89040101:@"雪球", @89050101:@"雪球" };
    NSString *name=names[skill[@"resource_id"]];
    if(name) return name;
    return [NSString stringWithFormat:@"S%@",skill[@"slot_index"]];
}

@implementation LVSkillPanelView
- (void)setHeroes:(NSArray<NSDictionary *> *)heroes { _heroes=[heroes copy] ?: @[];[self setNeedsDisplay]; }
- (void)setStatusReason:(NSString *)reason { _statusReason=[reason copy];[self setNeedsDisplay]; }
- (void)drawRect:(CGRect)rect {
    (void)rect;
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGFloat scale=MAX(.7,MIN(1.8,self.displayScale));
    NSDictionary *header=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10*scale],
        NSForegroundColorAttributeName:UIColor.whiteColor};
    NSString *title=[self.statusReason isEqualToString:@"partial"] ? @"敌方技能 · 部分数据" : @"敌方技能 · 当前冷却";
    if(!self.heroes.count) title=[self.statusReason isEqualToString:@"ready"] ? @"敌方技能 · 暂无敌方英雄" : @"敌方技能 · 数据不可用";
    [title drawAtPoint:CGPointMake(6,3) withAttributes:header];
    CGFloat top=19*scale;
    CGFloat rowHeight=MIN(30*scale,MAX(12,(self.bounds.size.height-top)/MAX(1,self.heroes.count)));
    for(NSUInteger i=0;i<MIN((NSUInteger)16,self.heroes.count);++i) {
        NSDictionary *hero=self.heroes[i];CGFloat y=top+i*rowHeight;
        CGFloat avatar=MIN(22*scale,rowHeight-2);
        UIImage *portrait=[self.portraitStore imageForResourceID:[hero[@"resource_id"] intValue]];
        if(portrait) [portrait drawInRect:CGRectMake(4,y,avatar,avatar)];
        else {
            NSString *identity=[NSString stringWithFormat:@"%@",hero[@"resource_id"] ?: @"?"];
            [identity drawAtPoint:CGPointMake(4,y) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:7*scale],
                NSForegroundColorAttributeName:UIColor.whiteColor}];
        }
        NSArray *skills=hero[@"display_skills"] ?: hero[@"skills"];
        if(!skills.count) {
            NSString *message=[hero[@"result"] isEqualToString:@"changed_during_read"] ? @"数据变化中" :
                ([hero[@"hidden_regular_count"] unsignedIntegerValue]>0 ? @"已隐藏普通技能" : @"暂无可读技能");
            [message drawAtPoint:CGPointMake(avatar+10,y+3) withAttributes:header];continue;
        }
        NSUInteger columns=MIN((NSUInteger)8,skills.count);
        CGFloat left=avatar+10,width=(self.bounds.size.width-left-4)/columns;
        for(NSUInteger j=0;j<columns;++j) {
            CGFloat x=left+j*width;
            if(j==7 && skills.count>8) {
                [[NSString stringWithFormat:@"+%lu",(unsigned long)(skills.count-7)]
                    drawAtPoint:CGPointMake(x,y+4) withAttributes:header];continue;
            }
            NSDictionary *skill=skills[j];
            NSString *role=skill[@"role"];
            NSString *label=[NSString stringWithFormat:@"#%@",skill[@"slot_index"]];
            if([role isEqualToString:@"summoner"])label=summonerSpellName(skill);
            else if([role isEqualToString:@"ultimate"])label=@"R";
            else if([role isEqualToString:@"regular"])label=[NSString stringWithFormat:@"%d技能",[skill[@"configured_index"] intValue]+1];
            NSString *value=@"?";UIColor *color=UIColor.lightGrayColor;
            if([skill[@"ambiguous"] boolValue]) value=@"?";
            else if([skill[@"level"] intValue]==0) value=@"未学";
            else if([skill[@"cooldown_read_ok"] boolValue]) {
                if([skill[@"cooldown_locked"] boolValue]) value=@"锁定";
                else {
                    int64_t fixed=[skill[@"cooldown_fixed"] longLongValue];
                    int64_t seconds=fixed/16384+(fixed%16384!=0);
                    value=!seconds && ![skill[@"cooldown_zero_verified"] boolValue] ? @"待核" :
                        (seconds>999 ? @"999+s" : [NSString stringWithFormat:@"%llds",(long long)seconds]);
                    color=seconds ? UIColor.yellowColor : UIColor.whiteColor;
                }
            }
            CGFloat font=MAX(6,MIN(9*scale,width/3.5));
            [label drawAtPoint:CGPointMake(x,y) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],
                NSForegroundColorAttributeName:UIColor.lightGrayColor}];
            [value drawAtPoint:CGPointMake(x,y+MIN(12*scale,rowHeight*.45)) withAttributes:@{
                NSFontAttributeName:[UIFont monospacedDigitSystemFontOfSize:font weight:UIFontWeightSemibold],
                NSForegroundColorAttributeName:color}];
        }
    }
    CGContextSetStrokeColorWithColor(context,[UIColor colorWithWhite:1 alpha:.2].CGColor);
    CGContextSetLineWidth(context,.5);CGContextStrokeRect(context,CGRectInset(self.bounds,.5,.5));
}
@end
