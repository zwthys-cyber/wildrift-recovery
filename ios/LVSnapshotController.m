#import "LVSnapshotController.h"

static NSString *previewLabel(NSString *code) {
    NSDictionary *labels = @{ @"setting_disabled": @"自动惩戒开关关闭",
        @"snapshot_unusable": @"快照不可用", @"local_actor_unusable": @"本机角色字段不完整或已死亡",
        @"local_actor_ambiguous": @"本机角色身份不唯一", @"skill_list_incomplete": @"技能列表不完整",
        @"smite_not_found": @"未找到惩戒技能 81110101", @"smite_ambiguous": @"惩戒技能身份不唯一",
        @"cooldown_unavailable": @"冷却节点或数值不可用", @"cooldown_locked": @"冷却节点已锁定",
        @"cooldown_active": @"惩戒仍在冷却", @"skill_casting": @"技能正在施法", @"stock_empty": @"技能库存已耗尽",
        @"nearby_enemy_hero_not_confirmed": @"未确认范围内有存活敌方英雄",
        @"no_eligible_target": @"没有满足类别、范围和血量条件的目标", @"original_rule_rejected": @"原程序规则未通过",
        @"eligible": @"目标条件符合", @"category_disabled": @"该类别开关关闭",
        @"classification_unavailable": @"角色类别未读到", @"not_monster": @"类别字段未标记为野怪",
        @"actor_values_unavailable": @"对象编号或位置不可用", @"outside_range": @"超出配置范围",
        @"health_unavailable": @"血量未读到", @"health_below_one": @"血量小于 1",
        @"above_threshold": @"血量高于原程序阈值", @"local_actor_unavailable": @"本机位置不可用" };
    return labels[code] ?: code ?: @"未知";
}

@interface LVSnapshotController ()
@property(nonatomic, strong) NSDictionary *snapshot;
@property(nonatomic, copy) NSString *sampledAt;
@property(nonatomic, strong) NSArray<NSArray<NSDictionary *> *> *rows;
@end

@implementation LVSnapshotController
- (instancetype)initWithSnapshot:(NSDictionary *)snapshot sampledAt:(NSString *)sampledAt {
    self = [super initWithStyle:UITableViewStyleInsetGrouped];
    if (self) {
        _snapshot = snapshot;
        _sampledAt = sampledAt;
        NSDictionary *skills = snapshot[@"local_skills"];
        NSDictionary *preview = snapshot[@"smite_preview"];
        NSMutableArray *previewRows = [NSMutableArray new];
        if (preview) { [previewRows addObject:preview]; [previewRows addObjectsFromArray:preview[@"candidates"] ?: @[]]; }
        _rows = @[previewRows, snapshot[@"actors"] ?: @[], skills[@"summoner"][@"skills"] ?: @[],
            skills[@"all"][@"skills"] ?: @[]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad]; self.title = @"对局快照";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 4; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rows[section].count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!section) return @"惩戒判断预览";
    NSString *title = @[@"惩戒判断预览", @"角色与场景对象", @"本机召唤师技能", @"本机全部技能"][section];
    return [NSString stringWithFormat:@"%@（%lu）", title, (unsigned long)self.rows[section].count];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (!section) return @"仅模拟判断，不会点击游戏。采用检测开始时的配置。范围按原始 X/Z 定点坐标比较，跨平台比例与 iOS 实际伤害仍需核对；原生技能可用条件尚未完整恢复。";
    if (section == 1) return [NSString stringWithFormat:@"采样时间：%@。这是一次采样，数值不会自动刷新；返回后重新检测可更新。类别来自游戏缓存字段。", self.sampledAt ?: @"未知"];
    NSDictionary *list = self.snapshot[@"local_skills"][section == 2 ? @"summoner" : @"all"];
    NSString *state = list[@"result"];
    if (!self.rows[section].count) return [state isEqual:@"ready"] ? @"当前技能列表为空。" : @"尚未读到技能列表，请导出诊断报告。";
    if (![state isEqual:@"ready"]) return @"部分技能字段未读到，请导出诊断报告。冷却为零不代表可以释放。";
    return @"冷却来自游戏技能接口；锁定时该接口也会返回零，不能据此判断可释放。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines = 0; cell.detailTextLabel.numberOfLines = 0;
    NSDictionary *row = self.rows[path.section][path.row];
    if (!path.section) {
        if (!path.row) {
            cell.textLabel.text = [row[@"would_trigger_in_simulation"] boolValue] ? @"模拟：满足原程序规则" : @"模拟：尚不满足触发条件";
            NSMutableArray *details = [NSMutableArray new];
            for (NSString *block in row[@"blockers"]) [details addObject:previewLabel(block)];
            [details addObject:[NSString stringWithFormat:@"原程序血量阈值 %@ · iOS 实际伤害待核对", row[@"original_rule_threshold"] ?: @0]];
            [details addObject:[NSString stringWithFormat:@"范围换算 %.3f · 比例待核对", [row[@"range_world_xz_assumed"] doubleValue]]];
            [details addObject:[NSString stringWithFormat:@"范围内敌方英雄 %@ · 字段待确认的敌方对象 %@", row[@"nearby_enemy_hero_count"] ?: @0, row[@"unconfirmed_enemy_object_count"] ?: @0]];
            [details addObject:[NSString stringWithFormat:@"匹配原目标清单 %@ · 满足目标条件 %@", row[@"recognized_target_count"] ?: @0, row[@"eligible_target_count"] ?: @0]];
            if (row[@"chosen_object_id"]) [details addObject:[NSString stringWithFormat:@"模拟选中对象 %@", row[@"chosen_object_id"]]];
            cell.detailTextLabel.text = [details componentsJoinedByString:@"\n"];
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"候选资源 %@ · %@", row[@"resource_id"], previewLabel(row[@"status"])];
            NSMutableArray *details = [NSMutableArray new];
            if (row[@"object_id"]) [details addObject:[NSString stringWithFormat:@"对象编号 %@", row[@"object_id"]]];
            if (row[@"health"]) [details addObject:[NSString stringWithFormat:@"血量 %.2f", [row[@"health"] doubleValue]]];
            if ([row[@"distance_read_ok"] boolValue]) [details addObject:[NSString stringWithFormat:@"X/Z 距离 %.3f", [row[@"distance_world_xz"] doubleValue]]];
            cell.detailTextLabel.text = [details componentsJoinedByString:@"\n"];
        }
    } else if (path.section == 1) {
        NSString *resource = [row[@"values_read_ok"] boolValue] ? [row[@"resource_id"] description] : @"未读到";
        cell.textLabel.text = [NSString stringWithFormat:@"%@资源 %@", [row[@"is_local"] boolValue] ? @"本机 · " : @"", resource];
        NSMutableArray *details = [NSMutableArray new];
        [details addObject:[row[@"values_read_ok"] boolValue] ? [NSString stringWithFormat:@"阵营 %@", row[@"camp"]] : @"阵营未读到"];
        [details addObject:[row[@"health_read_ok"] boolValue] ? [NSString stringWithFormat:@"血量 %.2f", [row[@"health"] doubleValue]] : @"血量未读到"];
        if ([row[@"object_id_read_ok"] boolValue]) [details addObject:[NSString stringWithFormat:@"对象编号 %@", row[@"object_id"]]];
        NSArray *position = row[@"position"];
        if ([row[@"position_read_ok"] boolValue] && position.count == 3)
            [details addObject:[NSString stringWithFormat:@"位置 %.2f, %.2f, %.2f", [position[0] doubleValue], [position[1] doubleValue], [position[2] doubleValue]]];
        else [details addObject:@"位置未读到"];
        if ([row[@"classification_read_ok"] boolValue]) {
            NSMutableArray *classes = [NSMutableArray new];
            for (NSArray *pair in @[@[@"is_hero", @"英雄"], @[@"is_monster", @"野怪"], @[@"is_soldier", @"小兵"],
                @[@"is_building", @"建筑"], @[@"is_red_blue_buff", @"红蓝 Buff"]])
                if ([row[pair[0]] boolValue]) [classes addObject:pair[1]];
            [details addObject:classes.count ? [classes componentsJoinedByString:@"、"] : @"其他场景对象"];
        } else [details addObject:@"类别未读到"];
        cell.detailTextLabel.text = [details componentsJoinedByString:@"\n"];
    } else {
        cell.textLabel.text = [row[@"values_read_ok"] boolValue] ? [NSString stringWithFormat:@"技能 %@ · 等级 %@", row[@"resource_id"], row[@"level"]] : @"技能属性未读到";
        NSMutableArray *details = [NSMutableArray new];
        [details addObject:[row[@"cooldown_read_ok"] boolValue] ?
            [NSString stringWithFormat:@"剩余冷却 %.3f 秒%@", [row[@"cooldown_seconds"] doubleValue], [row[@"cd_locked"] boolValue] ? @" · 已锁定" : @""] : @"冷却未读到"];
        [details addObject:[row[@"stock_read_ok"] boolValue] ? [NSString stringWithFormat:@"库存 %@ / %@", row[@"stock_current"], row[@"stock_maximum"]] : @"库存未读到"];
        [details addObject:[row[@"cast_state_read_ok"] boolValue] ? [NSString stringWithFormat:@"施法状态 0x%x%@", [row[@"cast_state_raw"] unsignedIntValue], [row[@"state_is_casting"] boolValue] ? @" · 正在施法" : @""] : @"施法状态未读到"];
        [details addObject:[row[@"slot_state_read_ok"] boolValue] ? [NSString stringWithFormat:@"技能槽状态 0x%x", [row[@"slot_state_raw"] unsignedIntValue]] : @"技能槽状态未读到"];
        cell.detailTextLabel.text = [details componentsJoinedByString:@"\n"];
    }
    return cell;
}
@end
