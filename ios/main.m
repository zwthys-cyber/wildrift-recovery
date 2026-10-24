#import <UIKit/UIKit.h>
#import "LVMachReader.h"
#import "LVHelper.h"
#import "LVSnapshotController.h"
#import "LVHUDControl.h"
#import "LVMinimapSettings.h"
#include "LVConfig.h"
#include <string.h>

static NSDictionary *LVWithEntry(NSDictionary *source, NSString *key, id value) {
    NSMutableDictionary *result = [source mutableCopy];
    result[key] = value;
    return result;
}

static NSString *LVLabel(const char *key) {
    static NSDictionary *labels;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        labels = @{
            @"drawBox": @"实体框", @"drawRay": @"实体射线", @"drawMinimap": @"小地图绘制",
            @"showMinimapBorder": @"小地图头像边框", @"drawSkillPanel": @"技能面板",
            @"hideSmallSkills": @"隐藏小技能", @"hideEntityAvatar": @"隐藏实体头像",
            @"drawWards": @"眼位绘制", @"drawMonsters": @"野怪绘制",
            @"hideMonsterHealth": @"隐藏野怪血量", @"showMonsterRespawn": @"野怪刷新倒计时",
            @"autoSmite": @"自动惩戒", @"smiteRequireEnemy": @"有敌人时触发",
            @"autoMercury": @"自动水银", @"showMercuryMarker": @"显示水银触点",
            @"showSmiteRange": @"显示惩戒范围", @"showSmiteMarker": @"显示惩戒触点",
            @"smiteRedBuff": @"红 Buff", @"smiteBlueBuff": @"蓝 Buff", @"smiteDragon": @"龙",
            @"smiteHealthThreshold": @"惩戒血量", @"smiteRange": @"检测范围",
            @"smiteRangeCenterX": @"范围中心左右", @"smiteRangeCenterY": @"范围中心上下",
            @"smiteTouchX": @"惩戒触点 X", @"smiteTouchY": @"惩戒触点 Y",
            @"mercuryTouchX": @"水银触点 X", @"mercuryTouchY": @"水银触点 Y",
            @"godViewEnabled": @"视角调整", @"godViewValue": @"视角数值",
            @"forcedDrawCamp": @"绘制阵营（0 自动／1 蓝／2 红）", @"minimapScale": @"地图缩放",
            @"minimapAvatarSpacing": @"头像间隔", @"minimapOffsetX": @"地图左右",
            @"minimapOffsetY": @"地图上下", @"minimapWindowScale": @"窗口缩放",
            @"minimapWindowOffsetX": @"窗口左右", @"minimapWindowOffsetY": @"窗口上下",
            @"minimapAvatarSize": @"地图头像大小", @"minimapHealthTextSize": @"地图血量文字大小",
            @"minimapAvatarBorderSize": @"头像边框大小", @"entityOffsetX": @"实体左右",
            @"entityOffsetY": @"实体上下", @"entityBoxWidthScale": @"实体框宽度",
            @"entityBoxHeightScale": @"实体框高度", @"entityAvatarSize": @"实体头像大小",
            @"entityHealthTextSize": @"实体血量文字大小", @"monsterHealthTextSize": @"野怪血量文字大小",
            @"entitySkillIconSize": @"实体技能图标大小", @"skillPanelOffsetX": @"技能面板左侧（点，0 自动）",
            @"skillPanelOffsetY": @"技能面板顶部（点，0 自动）", @"skillPanelSize": @"技能面板大小",
            @"friendlyColor": @"友方颜色", @"enemyColor": @"敌方颜色", @"wardColor": @"眼位颜色",
            @"wardVisionRangeBrightness": @"眼位范围亮度", @"neutralColor": @"中立单位颜色"
        };
    });
    NSString *name = [NSString stringWithUTF8String:key];
    return labels[name] ?: name;
}

static NSString *LVImplementationNote(const char *rawKey) {
    NSString *key=@(rawKey);
    if ([key isEqualToString:@"drawMinimap"]) return @"敌人头像已获当前场景实机确认";
    if ([key isEqualToString:@"drawSkillPanel"]) return @"显示大招与召唤师技能；普通技能冷却已获训练场实机验证";
    if ([key hasPrefix:@"skillPanel"]) return @"已接入敌方技能面板；修改后重新启动悬浮窗";
    if ([key isEqualToString:@"hideSmallSkills"]) return @"面板已固定隐藏普通小技能";
    if ([key isEqualToString:@"drawWards"]) return @"已实现；眼位出现和销毁仍需实机确认";
    if ([key isEqualToString:@"drawMonsters"]) return @"显示当前可读且存活的野怪；新版待实机确认";
    if ([key isEqualToString:@"hideMonsterHealth"]) return @"仅隐藏野怪血量文字，保留标记";
    if ([key isEqualToString:@"autoSmite"]) return @"仅判断预览，不会释放技能";
    if ([key isEqualToString:@"autoMercury"]) return @"仅恢复规则，尚未接入实际操作";
    if ([key hasPrefix:@"godView"]) return @"仅保存配置；只读版本不修改游戏视角";
    if ([key hasPrefix:@"entity"] || [key hasPrefix:@"skillPanel"] ||
        [@[@"drawBox",@"drawRay",@"drawSkillPanel",@"hideSmallSkills",@"hideEntityAvatar",
           @"showMonsterRespawn",@"wardVisionRangeBrightness",@"showMercuryMarker",@"showSmiteRange",@"showSmiteMarker"] containsObject:key])
        return @"尚未实现，当前仅保存配置";
    return nil;
}

static NSInteger LVGroup(const LVField *field) {
    NSString *key = [NSString stringWithUTF8String:field->key];
    if ([key hasPrefix:@"smite"] || [key isEqualToString:@"autoSmite"] || [key hasPrefix:@"showSmite"]) return 2;
    if ([key hasPrefix:@"mercury"] || [key isEqualToString:@"autoMercury"] || [key hasPrefix:@"showMercury"]) return 3;
    if ([key hasPrefix:@"minimap"]) return 4;
    if ([key hasPrefix:@"entity"] || [key hasPrefix:@"skillPanel"] || [key isEqualToString:@"monsterHealthTextSize"]) return 5;
    if ([key hasPrefix:@"godView"] || field->type == LV_COLOR || [key isEqualToString:@"wardVisionRangeBrightness"]) return 6;
    return 1;
}

@interface LVController : UITableViewController <UIDocumentPickerDelegate> {
    LVConfig _config;
}
@property(nonatomic, strong) NSArray<NSArray<NSNumber *> *> *groups;
@property(nonatomic, strong) NSDictionary *diagnostics;
@property(nonatomic, copy) NSString *probeStatus;
@property(nonatomic, copy) NSString *hudStatus;
@property(nonatomic) BOOL probing;
@end

@implementation LVController
- (NSURL *)configURL {
    NSURL *directory = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    return [directory URLByAppendingPathComponent:@"dynamic_draw_lolm.ini"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Wild Rift 国际服";
    lv_config_defaults(&_config);
    NSData *saved = [NSData dataWithContentsOfURL:self.configURL];
    if (saved.length && saved.length <= LV_CONFIG_MAX_INPUT) {
        NSString *text = [[NSString alloc] initWithData:saved encoding:NSUTF8StringEncoding];
        if (text) lv_config_parse(&_config, text.UTF8String, NULL);
    }
    NSMutableArray *groups = [NSMutableArray new];
    for (int i = 0; i < 7; ++i) [groups addObject:[NSMutableArray new]];
    for (NSUInteger i = 0; i < LV_CONFIG_FIELD_COUNT; ++i) {
        if (!strcmp(lv_fields[i].key,"hideSmallSkills")) continue;
        [groups[LVGroup(&lv_fields[i])] addObject:@(i)];
    }
    self.groups = groups;
    self.probeStatus = @"尚未检测";
    self.hudStatus = @"尚未检查悬浮窗";
    self.diagnostics = @{ @"game_app_version": @"7.3.0.2813", @"game_resource_version": @"7.3.19.51",
        @"recovery_app_version": NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"] ?: @"unknown",
        @"game_version_source": @"user_reported",
        @"original_sha256": @"e385f312ecbb5e575d2709a15a3b0157aa6fb37b52299075d9665f14df6fd111",
        @"restored_config_fields": @57, @"game_integration_ready": @NO };
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
}
- (NSString *)configText {
    size_t n = lv_config_serialize(&_config, NULL, 0);
    NSMutableData *bytes = [NSMutableData dataWithLength:n];
    lv_config_serialize(&_config, bytes.mutableBytes, n);
    return [[NSString alloc] initWithBytes:bytes.bytes length:n - 1 encoding:NSUTF8StringEncoding];
}
- (NSString *)runtimeConfigText { return [self.configText stringByAppendingString:LVMinimapSettingsText()]; }
- (BOOL)save {
    NSError *error = nil;
    BOOL ok = [[self.configText dataUsingEncoding:NSUTF8StringEncoding] writeToURL:self.configURL options:NSDataWritingAtomic error:&error];
    if (!ok) [self alert:@"配置未保存" message:error.localizedDescription ?: @"无法写入配置文件"];
    return ok;
}
- (void)alert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 8; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 7) return 1;
    return section ? self.groups[section].count : 13;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"恢复与检测", @"绘制配置", @"惩戒配置", @"水银配置", @"小地图配置", @"实体与技能配置", @"视角与颜色配置", @"iOS 小地图对齐"][section];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (!section) return @"进入训练模式后检测，再启动只读悬浮窗并切回游戏。悬浮窗显示实时数据与模拟判断，不会自动点击。停止请返回本应用。修改配置后重新启动悬浮窗可更新设置。";
    if (section == 4) return @"本机叠加位置请使用「iOS 小地图对齐」。";
    return nil;
}
- (NSString *)fieldText:(NSUInteger)index {
    const float *v = _config.values[index];
    if (lv_fields[index].type == LV_COLOR) return [NSString stringWithFormat:@"%.4f,%.4f,%.4f,%.4f", v[0], v[1], v[2], v[3]];
    if (lv_fields[index].type == LV_INT) return [NSString stringWithFormat:@"%d", (int)v[0]];
    return [NSString stringWithFormat:@"%.4f", v[0]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.numberOfLines = 2;
    cell.detailTextLabel.numberOfLines = 2;
    if (path.section == 7) {
        cell.textLabel.text = @"对齐游戏原有小地图";
        cell.detailTextLabel.text = @"位置、大小、方向、本机定位点及信息面板开关";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (!path.section) {
        cell.textLabel.text = @[@"57 项配置已恢复", @"适配文件版本", @"运行读取自检", @"检测游戏并读取对局", @"导入安卓配置", @"导出配置", @"导出诊断报告", @"导出适配文件", @"查看对局与技能快照", @"启动／更新只读悬浮窗", @"检查悬浮窗状态", @"停止悬浮窗", @"补充导出原生引擎"][path.row];
        cell.detailTextLabel.text = @[@"默认值与数值范围已从安卓程序提取", @"国际服：7.3.0 (2813)", @"检查自身内存读取接口", self.probeStatus ?: @"尚未检测", @"选择 dynamic_draw_lolm.ini", @"保存或分享 INI 文件", @"分享检测结果、快照及悬浮窗状态", @"先检测游戏，再收集框架、元数据及原生引擎；文件可能较大", @"显示最近一次采样；重新检测可更新", @"先检测 wildrift；原小地图标记平滑移动，每 0.15 秒采样", self.hudStatus ?: @"尚未检查", @"结束本应用启动的只读悬浮窗", @"只补充 FEProj 适配文件；游戏停在大厅即可，无需再打一局"][path.row];
        if (path.row < 2) cell.selectionStyle = UITableViewCellSelectionStyleNone;
        else cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    NSUInteger index = self.groups[path.section][path.row].unsignedIntegerValue;
    cell.textLabel.text = LVLabel(lv_fields[index].key);
    NSString *note=LVImplementationNote(lv_fields[index].key);
    cell.detailTextLabel.text=note;
    if (lv_fields[index].type == LV_BOOL) {
        UISwitch *control = [UISwitch new];
        control.on = _config.values[index][0] != 0;
        control.tag = index;
        [control addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = control;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.detailTextLabel.text = note ? [NSString stringWithFormat:@"%@ · %@",[self fieldText:index],note] : [self fieldText:index];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (void)toggle:(UISwitch *)control {
    LVConfig before = _config;
    lv_config_set(&_config, (size_t)control.tag, control.on ? "1" : "0", NULL);
    if (![self save]) { _config = before; control.on = _config.values[control.tag][0] != 0; }
}
- (void)edit:(NSUInteger)index {
    const LVField *f = &lv_fields[index];
    NSString *message = f->type == LV_COLOR ? @"按红、绿、蓝、透明度顺序输入 4 个数，用逗号分隔。通常使用 0–1。" :
        (f->has_bounds ? [NSString stringWithFormat:@"范围 %.4g–%.4g，超出范围会自动调整。", f->minimum, f->maximum] : @"输入数值");
    if (!strcmp(f->key, "smiteHealthThreshold")) message = @"可选 600、1000 或 1400；其他数值会恢复为 1000。";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:LVLabel(f->key) message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
        field.text = [self fieldText:index];
        field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        field.autocorrectionType = UITextAutocorrectionTypeNo;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        LVConfig before = self->_config;
        if (lv_config_set(&self->_config, index, alert.textFields.firstObject.text.UTF8String, NULL)) {
            [self alert:@"数值无效" message:@"请输入有效数字，颜色需要 4 个逗号分隔的数值。"];
            return;
        }
        if (![self save]) self->_config = before;
        [self.tableView reloadData];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)reset {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恢复原始默认值" message:@"将替换当前的 57 项配置。" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"恢复" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        LVConfig before = self->_config;
        lv_config_defaults(&self->_config);
        if (![self save]) self->_config = before;
        [self.tableView reloadData];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)shareData:(NSData *)data name:(NSString *)name {
    NSURL *url = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:name];
    NSError *error = nil;
    if (!data || ![data writeToURL:url options:NSDataWritingAtomic error:&error]) {
        [self alert:@"导出失败" message:error.localizedDescription ?: @"未能生成文件"];
        return;
    }
    [self shareURL:url];
}
- (void)shareURL:(NSURL *)url {
    UIActivityViewController *share = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
    share.popoverPresentationController.sourceView = self.view;
    share.popoverPresentationController.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds), 1, 1);
    [self presentViewController:share animated:YES completion:nil];
}
- (void)collectInputs:(BOOL)engineOnly {
    if (self.probing) return;
    NSDictionary *probe = self.diagnostics[@"target_probe"];
    NSNumber *pid = probe[@"target_pid"];
    if (![pid isKindOfClass:NSNumber.class] || ![probe[@"task_result"] isKindOfClass:NSNumber.class] || [probe[@"task_result"] intValue] != 0) {
        [self alert:@"先检测游戏" message:@"请先打开游戏，再点“检测游戏并读取对局”并选择游戏进程。检测成功后即可导出适配文件。"];
        return;
    }
    NSURL *documents = self.configURL.URLByDeletingLastPathComponent;
    NSError *directoryError = nil;
    if (![NSFileManager.defaultManager createDirectoryAtURL:documents withIntermediateDirectories:YES attributes:nil error:&directoryError]) {
        [self alert:@"导出未完成" message:directoryError.localizedDescription ?: @"无法准备导出目录"];
        return;
    }
    self.probing = YES;
    self.probeStatus = engineOnly ? @"正在导出原生引擎，请保持此应用在前台…" : @"正在收集游戏框架、元数据及原生引擎，请保持此应用在前台…";
    [self.tableView reloadData];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSDictionary *result = LVRunProbe(@[engineOnly ? @"collect-engine" : @"collect", pid.stringValue, documents.path]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.probing = NO;
            self.diagnostics = LVWithEntry(self.diagnostics, engineOnly ? @"engine_collection" : @"input_collection", result);
            NSURL *archive = [documents URLByAppendingPathComponent:engineOnly ? @"lvlolm-ios-engine.zip" : @"lvlolm-ios-inputs.zip"];
            if ([result[@"success"] boolValue] && [NSFileManager.defaultManager fileExistsAtPath:archive.path]) {
                self.probeStatus = engineOnly ? @"原生引擎已导出，请分享 lvlolm-ios-engine.zip" :
                    ([result[@"metadata_found"] boolValue] ? @"适配文件已导出，包含框架与元数据" : @"框架已导出；未找到标准元数据文件");
                [self.tableView reloadData];
                [self shareURL:archive];
            } else {
                self.probeStatus = @"适配文件导出失败；可导出诊断报告查看原因";
                [self.tableView reloadData];
                [self alert:@"导出未完成" message:@"请重新打开游戏并检测进程后重试。若仍失败，请导出诊断报告。"];
            }
        });
    });
}
- (void)startProbe {
    if (self.probing) return;
    self.probing = YES;
    self.probeStatus = @"正在读取进程列表…";
    [self.tableView reloadData];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSDictionary *result = LVRunProbe(@[@"list"]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.probing = NO;
            if (![result[@"processes"] isKindOfClass:NSArray.class] || ![result[@"processes"] count]) {
                self.probeStatus = @"未能列出目标进程";
                self.diagnostics = LVWithEntry(self.diagnostics, @"enumeration", result);
                [self.tableView reloadData];
                [self alert:@"无法选择游戏" message:@"请先打开游戏。若游戏已打开，请导出诊断报告以检查辅助程序的运行结果。"];
                return;
            }
            UIAlertController *picker = [UIAlertController alertControllerWithTitle:@"选择游戏进程" message:@"读取访问权限、程序元数据和对局快照。" preferredStyle:UIAlertControllerStyleActionSheet];
            for (NSDictionary *item in result[@"processes"]) {
                NSString *title = [NSString stringWithFormat:@"%@ · PID %@", item[@"name"], item[@"pid"]];
                [picker addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { [self probePID:item[@"pid"]]; }]];
            }
            [picker addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { self.probeStatus = @"尚未选择进程"; [self.tableView reloadData]; }]];
            picker.popoverPresentationController.sourceView = self.view;
            picker.popoverPresentationController.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds), 1, 1);
            [self presentViewController:picker animated:YES completion:nil];
        });
    });
}
- (void)probePID:(NSNumber *)pid {
    if (self.probing) return;
    self.probing = YES;
    self.probeStatus = @"正在检测并读取对局…";
    [self.tableView reloadData];
    NSString *configText = self.runtimeConfigText;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSDictionary *result = LVRunProbe(@[@"probe", pid.stringValue, configText]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.probing = NO;
            self.diagnostics = LVWithEntry(self.diagnostics, @"target_probe", result);
            self.diagnostics = LVWithEntry(self.diagnostics, @"snapshot_sampled_at", [NSISO8601DateFormatter.new stringFromDate:NSDate.date]);
            BOOL connected = [result[@"task_result"] isKindOfClass:NSNumber.class] && [result[@"task_result"] intValue] == 0;
            NSDictionary *snapshot = result[@"game_snapshot"];
            NSString *state = snapshot[@"result"];
            if (!connected) self.probeStatus = @"尚未获得游戏访问权限";
            else if ([state isEqual:@"ready"] || [state isEqual:@"partial"])
                self.probeStatus = [NSString stringWithFormat:@"已采样 %@ 个角色；%@", snapshot[@"read_actor_count"] ?: @0,
                    [state isEqual:@"ready"] ? @"请导出报告核对数据" : @"部分字段未能读取，请导出报告"];
            else if ([state isEqual:@"not_in_battle"]) self.probeStatus = @"访问成功；尚未找到对局对象";
            else if ([state isEqual:@"uuid_mismatch"]) self.probeStatus = @"游戏框架版本不同；请重新导出适配文件";
            else self.probeStatus = @"访问成功；快照未完成，请导出诊断报告";
            [self.tableView reloadData];
            [self alert:@"检测完成" message:connected ? self.probeStatus : @"当前系统未允许访问所选进程，或辅助程序未能启动。请导出诊断报告查看原因。"];
        });
    });
}
- (void)exportDiagnostics {
    NSMutableDictionary *report = [self.diagnostics mutableCopy];
    report[@"ios_version"] = UIDevice.currentDevice.systemVersion;
    report[@"probe_status"] = self.probeStatus;
    report[@"hud_status"] = self.hudStatus;
    LVMinimapSettings mapSettings = LVLoadMinimapSettings();
    report[@"current_minimap_calibration"] = LVMinimapSettingsDictionary(&mapSettings);
    [self shareData:[NSJSONSerialization dataWithJSONObject:report options:NSJSONWritingPrettyPrinted error:NULL] name:@"lvlolm-diagnostics.json"];
}
- (void)hudAction:(NSString *)action {
    if (self.probing) return;
    NSString *session = [NSUserDefaults.standardUserDefaults stringForKey:@"LVHUDSession"];
    BOOL starting = [action isEqual:@"start"], exporting = [action isEqual:@"export"];
    NSNumber *pid = self.diagnostics[@"target_probe"][@"target_pid"];
    if (starting && (![pid isKindOfClass:NSNumber.class] ||
        ![self.diagnostics[@"target_probe"][@"task_result"] isKindOfClass:NSNumber.class] ||
        [self.diagnostics[@"target_probe"][@"task_result"] intValue] != 0)) {
        [self alert:@"先检测游戏" message:@"进入训练模式，检测并选择 wildrift 后再启动悬浮窗。"];
        return;
    }
    if (!LVHUDSessionValid(session)) {
        if (!starting) { self.hudStatus = @"尚未启动悬浮窗"; if (exporting) [self exportDiagnostics]; else [self.tableView reloadData]; return; }
        session = NSUUID.UUID.UUIDString;
        [NSUserDefaults.standardUserDefaults setObject:session forKey:@"LVHUDSession"];
    }
    NSString *configText = self.runtimeConfigText;
    self.probing = YES; self.hudStatus = starting ? @"正在启动悬浮窗…" : @"正在检查悬浮窗…";
    [self.tableView reloadData];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSDictionary *result;
        if (starting) {
            NSDictionary *stopped = LVRunProbe(@[@"hud-stop", session]);
            if (stopped[@"error"] || [stopped[@"running"] boolValue]) result = @{ @"error": @"previous HUD did not stop", @"stop_result": stopped };
            else {
                // Give each launch its own telemetry namespace, and save its
                // stop token before spawning so a reopened app can stop it.
                NSString *launchSession = NSUUID.UUID.UUIDString;
                [NSUserDefaults.standardUserDefaults setObject:launchSession forKey:@"LVHUDSession"];
                result = LVRunProbe(@[@"hud-start", pid.stringValue, launchSession, configText]);
            }
        } else result = LVRunProbe(@[[action isEqual:@"stop"] ? @"hud-stop" : @"hud-status", session]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.probing = NO;
            self.diagnostics = LVWithEntry(self.diagnostics, @"hud", result);
            if (starting) self.diagnostics = LVWithEntry(self.diagnostics, @"hud_launch", result);
            self.diagnostics = LVWithEntry(self.diagnostics, @"hud_checked_at", [NSISO8601DateFormatter.new stringFromDate:NSDate.date]);
            if (result[@"error"]) self.hudStatus = @"悬浮窗操作未完成，请导出诊断报告";
            else if ([result[@"running"] boolValue]) {
                NSDictionary *sampling = result[@"sampling"];
                if (starting) self.hudStatus = @"已提交显示请求；请切回游戏核对";
                else if (![sampling[@"available"] boolValue]) self.hudStatus = @"进程运行；尚未取得完整采样，请导出报告";
                else if (![sampling[@"fresh"] boolValue]) self.hudStatus = @"进程运行；采样已有超过 3 秒未更新，请导出报告";
                else if (![sampling[@"latest_snapshot_usable"] boolValue]) self.hudStatus = @"采样持续更新；最近一次游戏读取不可用，请导出报告";
                else self.hudStatus = [NSString stringWithFormat:@"采样 %@ 次、%@ 个对象；画面请在游戏中核对", sampling[@"frames_completed"], sampling[@"read_actor_count"]];
            }
            else self.hudStatus = @"悬浮窗未运行";
            [self.tableView reloadData];
            if (exporting) [self exportDiagnostics];
            else [self alert:@"悬浮窗" message:self.hudStatus];
        });
    });
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    if (path.section == 7) {
        [tableView deselectRowAtIndexPath:path animated:YES];
        [self.navigationController pushViewController:[[LVMinimapSettingsController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
        return;
    }
    [tableView deselectRowAtIndexPath:path animated:YES];
    if (path.section) {
        NSUInteger index = self.groups[path.section][path.row].unsignedIntegerValue;
        if (lv_fields[index].type != LV_BOOL) [self edit:index];
        return;
    }
    if (path.row == 2) {
        NSDictionary *result = [LVMachReader selfTest];
        self.diagnostics = LVWithEntry(self.diagnostics, @"self_test", result);
        [self alert:@"读取自检" message:[result[@"self_read_ok"] boolValue] ? @"自身内存读取通过。游戏进程权限需要单独检测。" : @"自身读取失败，请导出诊断报告。"];
    } else if (path.row == 3) {
        [self startProbe];
    } else if (path.row == 4) {
        UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"] inMode:UIDocumentPickerModeImport];
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    } else if (path.row == 5) {
        [self shareData:[self.configText dataUsingEncoding:NSUTF8StringEncoding] name:@"dynamic_draw_lolm.ini"];
    } else if (path.row == 6) {
        [self hudAction:@"export"];
    } else if (path.row == 7) {
        [self collectInputs:NO];
    } else if (path.row == 8) {
        NSDictionary *snapshot = self.diagnostics[@"target_probe"][@"game_snapshot"];
        if (![snapshot isKindOfClass:NSDictionary.class] || ![snapshot[@"actors"] count]) {
            [self alert:@"尚无对局快照" message:@"进入训练模式，先点“检测游戏并读取对局”。"];
            return;
        }
        LVSnapshotController *controller = [[LVSnapshotController alloc] initWithSnapshot:snapshot sampledAt:self.diagnostics[@"snapshot_sampled_at"]];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (path.row == 9) {
        [self hudAction:@"start"];
    } else if (path.row == 10) {
        [self hudAction:@"status"];
    } else if (path.row == 11) {
        [self hudAction:@"stop"];
    } else if (path.row == 12) {
        [self collectInputs:YES];
    }
}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    NSURL *url = urls.firstObject;
    if (!url) return;
    BOOL scoped = [url startAccessingSecurityScopedResource];
    NSNumber *size = nil;
    [url getResourceValue:&size forKey:NSURLFileSizeKey error:NULL];
    NSData *data = size && size.unsignedLongLongValue <= LV_CONFIG_MAX_INPUT ? [NSData dataWithContentsOfURL:url] : nil;
    if (scoped) [url stopAccessingSecurityScopedResource];
    NSString *text = data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
    LVParseReport report = {0};
    LVConfig candidate = _config;
    if (!text || memchr(data.bytes, 0, data.length) || lv_config_parse(&candidate, text.UTF8String, &report) || !report.recognized) {
        [self alert:@"配置无法导入" message:@"请选择不超过 1 MB 的 UTF-8 INI 文件，内容需包含有效配置项，格式版本为 1。当前配置未改动。"];
        return;
    }
    LVConfig before = _config;
    _config = candidate;
    if (![self save]) { _config = before; return; }
    [self.tableView reloadData];
    [self alert:@"配置已导入" message:[NSString stringWithFormat:@"读取 %zu 项配置，调整 %zu 项范围，忽略 %zu 个未知字段。", report.recognized, report.clamped, report.unknown]];
}
@end

@interface LVApp : UIResponder <UIApplicationDelegate>
@property(nonatomic, strong) UIWindow *window;
@end
@implementation LVApp
- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(NSDictionary *)options {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    LVController *controller = [[LVController alloc] initWithStyle:UITableViewStyleInsetGrouped];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
    navigation.navigationBar.prefersLargeTitles = YES;
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
    return YES;
}
@end

int main(int argc, char **argv) {
    @autoreleasepool { return UIApplicationMain(argc, argv, nil, NSStringFromClass(LVApp.class)); }
}
