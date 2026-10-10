#import "LVMinimapSettings.h"

static NSString *settingsKey = @"LVMinimapCalibrationV1";
static NSString *rectPresetKey = @"LVMinimapRectPresetVersion";
static const NSInteger rectPresetVersion = 2;
static NSString *settingsText(const LVMinimapSettings *s) {
    char buffer[1024]; size_t n = lv_minimap_serialize(s, buffer, sizeof(buffer));
    return n && n <= sizeof(buffer) ? [NSString stringWithUTF8String:buffer] : nil;
}
LVMinimapSettings LVLoadMinimapSettings(void) {
    LVMinimapSettings s; lv_minimap_defaults(&s);
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    id text = [defaults objectForKey:settingsKey];
    BOOL loaded = [text isKindOfClass:NSString.class] && lv_minimap_parse(&s, [text UTF8String]);
    if ([defaults integerForKey:rectPresetKey] < rectPresetVersion) {
        if (loaded && lv_minimap_migrate_legacy_rect(&s))
            [defaults setObject:settingsText(&s) forKey:settingsKey];
        [defaults setInteger:rectPresetVersion forKey:rectPresetKey];
    }
    return s;
}
NSString *LVMinimapSettingsText(void) { LVMinimapSettings s = LVLoadMinimapSettings(); return settingsText(&s); }
NSDictionary *LVMinimapSettingsDictionary(const LVMinimapSettings *s) {
    NSMutableDictionary *out = [NSMutableDictionary new];
    for (size_t i = 0; i < LV_MINIMAP_FIELDS; ++i) out[@(lv_minimap_fields[i].key)] = @(s->values[i]);
    return out;
}
@interface LVMinimapSettingsController ()
@property(nonatomic) LVMinimapSettings settings;
@end
@implementation LVMinimapSettingsController
- (void)viewDidLoad {
    [super viewDidLoad]; self.title = @"对齐游戏小地图"; self.settings = LVLoadMinimapSettings();
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
        initWithTitle:@"应用推荐对齐" style:UIBarButtonItemStylePlain target:self action:@selector(applyRecommendedRect)];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return LV_MINIMAP_FIELDS; }
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"信息面板（中央及地图下方文字）和本机“＋”默认隐藏，各有独立开关。只显示敌方标记时，可关闭对齐框、信息面板和本机定位点。需要核对坐标时打开本机定位点，用青色十字对照本机头像。“应用推荐对齐”只更改左／上／宽／高，其他设置保留。坐标从横屏左上角起算，位置和大小用屏幕百分比。方向 -1 按阵营选择，亦可填 0、90、180、270。默认读取游戏映射参数；手动映射仅供读取失败时校准。修改后回到首页启动／更新悬浮窗。";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = @(lv_minimap_fields[path.row].label); cell.textLabel.numberOfLines = 2;
    if (path.row == LV_MAP_MANUAL || path.row == LV_MAP_REFERENCES || path.row == LV_HUD_INFO_PANEL || path.row == LV_MAP_LOCAL_POINT) {
        UISwitch *control = [UISwitch new]; control.on = _settings.values[path.row] != 0; control.tag = path.row;
        [control addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = control; cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", _settings.values[path.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (void)save {
    [NSUserDefaults.standardUserDefaults setObject:settingsText(&_settings) forKey:settingsKey];
    [NSUserDefaults.standardUserDefaults setInteger:rectPresetVersion forKey:rectPresetKey];
}
- (void)applyRecommendedRect {
    if (lv_minimap_apply_recommended_rect(&_settings)) { [self save]; [self.tableView reloadData]; }
}
- (void)toggle:(UISwitch *)control {
    if (lv_minimap_set(&_settings, control.tag, control.on ? "1" : "0")) [self save];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [tableView deselectRowAtIndexPath:path animated:YES];
    if (path.row == LV_MAP_MANUAL || path.row == LV_MAP_REFERENCES || path.row == LV_HUD_INFO_PANEL || path.row == LV_MAP_LOCAL_POINT) return;
    const LVMinimapField *field = &lv_minimap_fields[path.row];
    NSString *message = path.row == LV_MAP_ROTATION ? @"-1 为按阵营自动选择；其余可选 0、90、180、270。" :
        [NSString stringWithFormat:@"范围 %.2f–%.2f。小地图右边和下边需要在屏幕内。", field->minimum, field->maximum];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@(field->label) message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *input) {
        input.text = [NSString stringWithFormat:@"%.4f", self->_settings.values[path.row]];
        input.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (lv_minimap_set(&self->_settings, path.row, alert.textFields.firstObject.text.UTF8String)) {
            [self save]; [self.tableView reloadData];
        } else {
            UIAlertController *error = [UIAlertController alertControllerWithTitle:@"数值无效" message:@"请输入范围内的数字；方向只能使用列出的选项。" preferredStyle:UIAlertControllerStyleAlert];
            [error addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:error animated:YES completion:nil];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
