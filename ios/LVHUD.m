/* Plugin bootstrap and global-window hosting adapted from Lessica/TrollSpeed
   a609be260c8261ead36509c3bc4ded8479da9c40 (MIT). See TrollSpeed-LICENSE.txt.
   This HUD has no input-event generator or target memory write interface. */
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LVMachReader.h"
#import "LVSnapshot.h"
#import "LVHUDControl.h"
#import "LVHeroPortraits.h"
#import "LVHUDTrace.h"
#include "LVMinimapMotion.h"
#include <notify.h>
#include <dlfcn.h>
#include <unistd.h>
#include <limits.h>
#include <errno.h>
#include <math.h>
#include <stdbool.h>

extern int proc_pidpath(int, void *, uint32_t);
@interface UIApplication (LVHUDPrivate)
- (void)_accessibilityInit;
- (void)__completeAndRunAsPlugin;
@end
@interface UIWindow (LVHUDPrivate)
- (unsigned int)_contextId;
@end
@protocol LVHUDOrientationUpdate <NSObject>
- (long long)orientation;
@end
@interface NSObject (LVHUDPrivate)
- (void)registerWindowWithContextID:(unsigned int)context atLevel:(double)level;
- (void)setHandler:(void (^)(id update))handler;
- (long long)activeInterfaceOrientation;
- (void)invalidate;
@end

static int stateToken = -1, stopToken = -1;
static int metricTokens[LV_HUD_METRIC_WORDS] = {-1, -1, -1, -1, -1, -1, -1, -1, -1};
static NSString *hudSession;
static LVMachReader *hudReader;
static NSDictionary *hudMetadata;
static NSString *targetIdentity;
static pid_t targetPID;
static LVConfig hudConfig;
static LVMinimapSettings hudMapSettings;
static NSMutableArray *coordinateSamples;
static NSString *coordinateBattle;
static double lastCoordinateSampleAt;
static void recordCoordinateTrace(NSDictionary *snapshot) {
    double now=NSProcessInfo.processInfo.systemUptime;
    if(now-lastCoordinateSampleAt<1) return;
    lastCoordinateSampleAt=now;
    NSString *result=snapshot[@"result"];
    if(![result isEqual:@"ready"] && ![result isEqual:@"partial"]) return;
    NSString *battle=snapshot[@"trace"][@"drive_instance"];
    if(![coordinateBattle isEqual:battle]) { coordinateBattle=battle; coordinateSamples=[NSMutableArray new]; }
    NSMutableArray *heroes=[NSMutableArray new]; BOOL truncated=NO;
    NSArray *keys=@[@"object_id",@"resource_id",@"camp",@"is_local",@"position_read_ok",@"position",
        @"health_read_ok",@"health",@"minimap_health_fraction_read_ok",@"minimap_health_fraction",@"coordinate_candidates",
        @"native_health_fraction_read_ok",@"native_health_status",@"native_current_health",@"native_max_health",@"native_health_fraction",
        @"logic_position_read_ok",@"logic_position_status",@"logic_position"];
    for(NSDictionary *actor in snapshot[@"actors"]) {
        if(![actor[@"classification_read_ok"] boolValue] || ![actor[@"is_hero"] boolValue]) continue;
        if(heroes.count==16) { truncated=YES; break; }
        NSMutableDictionary *entry=[NSMutableDictionary new];
        for(NSString *key in keys) if(actor[key]) entry[key]=actor[key];
        [heroes addObject:entry];
    }
    if(!heroes.count) return;
    NSDictionary *map=snapshot[@"minimap"];
    [coordinateSamples addObject:@{ @"sampled_at":[NSISO8601DateFormatter.new stringFromDate:NSDate.date],
        @"uptime_seconds":@(now), @"result":result, @"read_attempts":snapshot[@"snapshot_read_attempts"] ?: @0,
        @"local_camp":map[@"local_camp"] ?: @0, @"map_reason":map[@"reason"] ?: @"missing",
        @"current_enemy_markers":map[@"current_enemy_marker_count"] ?: @0,
        @"outside_map_enemies":map[@"outside_map_enemy_count"] ?: @0,
        @"health_cache":map[@"health_cache"] ?: @{}, @"native_health":map[@"native_health"] ?: @{},
        @"logic_positions":map[@"logic_positions"] ?: @{},
        @"hero_list_truncated":@(truncated), @"heroes":heroes }];
    if(coordinateSamples.count>32) [coordinateSamples removeObjectAtIndex:0];
    NSMutableDictionary *trace=[@{ @"format_version":@1, @"session":hudSession.lowercaseString,
        @"producer_pid":@(getpid()), @"profile_uuid":@LV_TARGET_UUID, @"sample_interval_seconds":@1,
        @"sample_limit":@32, @"hero_limit":@16, @"samples":coordinateSamples,
        @"scope":@"Bounded numeric observations through vision changes. Identity-matched native logic coordinates may be used for drawing; candidate and last-position fields are diagnostic only. No full-memory dump, history marker or predicted coordinate." } mutableCopy];
    while(coordinateSamples.count>1 &&
        [NSJSONSerialization dataWithJSONObject:trace options:0 error:NULL].length>512*1024) {
        [coordinateSamples removeObjectAtIndex:0]; trace[@"byte_budget_trimmed"]=@YES;
    }
    LVHUDWriteTrace(hudSession,trace);
}
static BOOL handshakeClosed = NO;
static NSDictionary *mapCalibration(void) {
    NSMutableDictionary *settings = [NSMutableDictionary new];
    for (size_t i = 0; i < LV_MINIMAP_FIELDS; ++i)
        settings[@(lv_minimap_fields[i].key)] = @(hudMapSettings.values[i]);
    return settings;
}
static NSDictionary *displayGeometry(void) {
    UIScreen *screen = UIScreen.mainScreen;
    return @{ @"bounds_size_points": @[@(screen.bounds.size.width), @(screen.bounds.size.height)],
        @"native_bounds_size_pixels": @[@(screen.nativeBounds.size.width), @(screen.nativeBounds.size.height)],
        @"scale": @(screen.scale), @"native_scale": @(screen.nativeScale),
        @"scope": @"HUD screen dimensions at launch; attachment crops are not screen bounds" };
}

static void acknowledge(NSDictionary *report) {
    if (handshakeClosed) return;
    NSData *data = [NSJSONSerialization dataWithJSONObject:report options:0 error:NULL];
    if (data && data.length <= 8192) {
        const unsigned char *bytes = data.bytes; size_t remaining = data.length;
        while (remaining) {
            ssize_t n = write(3, bytes, remaining);
            if (n > 0) { bytes += n; remaining -= (size_t)n; }
            else if (n < 0 && errno == EINTR) continue;
            else break;
        }
    }
    close(3); handshakeClosed = YES;
}
static void clearState(void) {
    /* Only cancel this process's registrations. Metrics are accepted only for
       a running, identity-checked HUD; a stopped process cannot supply a live
       sample. Each new launch has a separate random notification namespace. */
    for (size_t i = 0; i < LV_HUD_METRIC_WORDS; ++i)
        if (metricTokens[i] >= 0) { notify_cancel(metricTokens[i]); metricTokens[i] = -1; }
    if (stateToken >= 0) {
        uint64_t state = 0;
        if (!notify_get_state(stateToken, &state) && (state & UINT32_MAX) == (uint32_t)getpid()) notify_set_state(stateToken, 0);
        notify_cancel(stateToken); stateToken = -1;
    }
    if (stopToken >= 0) { notify_cancel(stopToken); stopToken = -1; }
}
static uint32_t initializeMetrics(void) {
    uint32_t code = 0;
    for (size_t i = 0; i < LV_HUD_METRIC_WORDS && !code; ++i) {
        code = notify_register_check(LVHUDMetricNotification(hudSession, i).UTF8String, &metricTokens[i]);
        if (!code) code = notify_set_state(metricTokens[i], 0);
    }
    if (!code) code = notify_set_state(metricTokens[LV_HUD_OWNER],
        ((uint64_t)LV_HUD_METRIC_VERSION << 32) | (uint32_t)getpid());
    return code;
}
static void publishMetrics(NSDictionary *snapshot, uint64_t frames, unsigned orientation) {
    uint64_t state = 0;
    if (stateToken < 0 || notify_get_state(stateToken, &state) || (uint32_t)state != (uint32_t)getpid()) return;
    LVHUDMetrics metrics = { .owner_pid = (uint32_t)getpid(), .frames = frames,
        .completed_at_ms = (uint64_t)(NSProcessInfo.processInfo.systemUptime * 1000.0),
        .result = lv_hud_result_from_name([snapshot[@"result"] UTF8String]),
        .actor_count = [snapshot[@"read_actor_count"] unsignedShortValue],
        .skipped_count = [snapshot[@"skipped_actor_count"] unsignedShortValue], .orientation = orientation };
    metrics.minimap_enabled = hudConfig.values[lv_config_index("drawMinimap")][0] != 0;
    NSDictionary *map = snapshot[@"minimap"];
    metrics.edge_clamped_markers=[map[@"edge_clamped_enemy_count"] unsignedShortValue];
    for (NSDictionary *marker in map[@"markers"]) if (![marker[@"is_local"] boolValue]) {
        ++metrics.displayed_markers;
        if([marker[@"health_fraction_read_ok"] boolValue]) ++metrics.health_ring_markers;
    }
    if (metrics.result == LV_HUD_READY || metrics.result == LV_HUD_PARTIAL) {
        metrics.enemy_count = [map[@"confirmed_enemy_hero_count"] unsignedShortValue];
        metrics.enemy_unplaced = [map[@"current_unplaced_enemy_count"] unsignedShortValue];
        metrics.map_projection_ok = [map[@"current_projection_ready"] boolValue]; metrics.map_manual = [map[@"manual_projection"] boolValue];
        metrics.enemy_markers = [map[@"current_enemy_marker_count"] unsignedShortValue];
        for (NSDictionary *skill in snapshot[@"local_skills"][@"summoner"][@"skills"]) {
            if (![skill[@"values_read_ok"] boolValue] || [skill[@"resource_id"] unsignedIntValue] != 81110101) continue;
            metrics.cooldown_ok = [skill[@"cooldown_read_ok"] boolValue];
            metrics.stock_ok = [skill[@"stock_read_ok"] boolValue];
            metrics.cooldown_fixed = [skill[@"cooldown_fixed"] longLongValue];
            metrics.stock_current = [skill[@"stock_current"] intValue];
            metrics.stock_maximum = [skill[@"stock_maximum"] intValue]; break;
        }
    }
    uint64_t words[LV_HUD_METRIC_WORDS];
    if (!lv_hud_metrics_encode(&metrics, words)) return;
    uint32_t code = notify_set_state(metricTokens[LV_HUD_SEQUENCE], words[LV_HUD_SEQUENCE] - 1);
    if (!code) code = notify_set_state(metricTokens[LV_HUD_OWNER], words[LV_HUD_OWNER]);
    for (size_t i = LV_HUD_FRAMES; i < LV_HUD_METRIC_WORDS && !code; ++i)
        code = notify_set_state(metricTokens[i], words[i]);
    if (!code) notify_set_state(metricTokens[LV_HUD_SEQUENCE], words[LV_HUD_SEQUENCE]);
    /* A failed publication stays odd, so it cannot be mistaken for fresh data. */
}
static NSString *blockLabel(NSString *code) {
    NSDictionary *labels = @{ @"setting_disabled": @"预览开关关闭", @"cooldown_active": @"惩戒冷却中",
        @"stock_empty": @"惩戒库存耗尽", @"nearby_enemy_hero_not_confirmed": @"范围内无已确认敌方英雄",
        @"no_eligible_target": @"无符合目标", @"cooldown_locked": @"惩戒已锁定", @"skill_casting": @"正在施法",
        @"cooldown_unavailable": @"冷却不可用", @"smite_not_found": @"未找到惩戒", @"skill_list_incomplete": @"技能数据不完整" };
    return labels[code] ?: @"数据或条件未满足";
}

@interface LVHUDWindow : UIWindow
@end
@implementation LVHUDWindow
+ (BOOL)_isSystemWindow { return YES; }
- (BOOL)_isWindowServerHostingManaged { return NO; }
- (BOOL)_ignoresHitTest { return YES; }
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event { return nil; }
@end

@interface LVMinimapView : UIView {
    LVMinimapMotion _motion;
    CADisplayLink *_displayLink;
}
@property(nonatomic, copy) NSArray<NSDictionary *> *markers;
@property(nonatomic) BOOL references;
@property(nonatomic) CGFloat markerSize;
@property(nonatomic, strong) LVHeroPortraits *portraitStore;
@property(nonatomic, copy) NSDictionary<NSNumber *, UIImage *> *portraitImages;
@end
@implementation LVMinimapView
- (void)stopAnimation { [_displayLink invalidate]; _displayLink = nil; _motion.active = 0; }
- (void)advanceAnimation:(CADisplayLink *)link {
    [self setNeedsDisplay];
    if (!lv_minimap_motion_active(&_motion, NSProcessInfo.processInfo.systemUptime)) [self stopAnimation];
}
- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) [self stopAnimation];
}
- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (!self.window) [self stopAnimation];
}
- (void)setMarkers:(NSArray<NSDictionary *> *)markers {
    _markers = [markers copy] ?: @[];
    NSMutableDictionary *images = [NSMutableDictionary new];
    LVMinimapMarker targets[LV_TARGET_MAX_ACTORS]; size_t count = _markers.count;
    if (count <= LV_TARGET_MAX_ACTORS) {
        for (size_t i = 0; i < count; ++i) {
            NSDictionary *m = _markers[i];
            targets[i] = (LVMinimapMarker){ .object_id=[m[@"object_id"] unsignedIntValue],
                .resource_id=[m[@"resource_id"] intValue], .ordinal=[m[@"ordinal"] unsignedIntValue],
                .is_local=[m[@"is_local"] boolValue], .u=[m[@"u"] doubleValue], .v=[m[@"v"] doubleValue],
                .health_fraction_ok=[m[@"health_fraction_read_ok"] boolValue],
                .health_fraction=[m[@"health_fraction"] doubleValue], .edge_clamped=[m[@"edge_clamped"] boolValue] };
            if (!targets[i].is_local) {
                UIImage *image = [self.portraitStore imageForResourceID:targets[i].resource_id];
                if (image) images[@(targets[i].resource_id)] = image;
            }
        }
        lv_minimap_motion_update(&_motion, targets, count, NSProcessInfo.processInfo.systemUptime,
            LV_MINIMAP_SAMPLE_INTERVAL_SECONDS);
    } else lv_minimap_motion_clear(&_motion);
    self.portraitImages = images;
    if (!_motion.active || self.hidden || !self.window) [self stopAnimation];
    else if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(advanceAnimation:)];
        _displayLink.preferredFramesPerSecond = 60;
        [_displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.references) {
        CGContextSetStrokeColorWithColor(context, [UIColor.cyanColor colorWithAlphaComponent:0.7].CGColor);
        CGContextSetLineWidth(context, 1); CGContextStrokeRect(context, CGRectInset(self.bounds, 1, 1));
    }
    double now = NSProcessInfo.processInfo.systemUptime;
    for (size_t i = 0; i < _motion.count; ++i) {
        const LVMinimapMarker *marker = &_motion.items[i].target; double u, v;
        lv_minimap_motion_position(&_motion, i, now, &u, &v);
        CGFloat x = u * self.bounds.size.width, y = v * self.bounds.size.height;
        if (marker->is_local) {
            CGContextSetStrokeColorWithColor(context, UIColor.cyanColor.CGColor); CGContextSetLineWidth(context, 2);
            CGContextMoveToPoint(context, x-5, y); CGContextAddLineToPoint(context, x+5, y);
            CGContextMoveToPoint(context, x, y-5); CGContextAddLineToPoint(context, x, y+5); CGContextStrokePath(context);
        } else {
            CGFloat radius = self.markerSize / 2;
            x=MAX(radius+1,MIN(self.bounds.size.width-radius-1,x));
            y=MAX(radius+1,MIN(self.bounds.size.height-radius-1,y));
            CGRect circle = CGRectMake(x-radius, y-radius, radius*2, radius*2);
            UIImage *portrait = self.portraitImages[@(marker->resource_id)];
            CGContextSaveGState(context);
            if (portrait) {
                CGContextSaveGState(context);
                CGContextAddEllipseInRect(context, circle); CGContextClip(context);
                [portrait drawInRect:circle];
                CGContextRestoreGState(context);
            } else {
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1 green:0.15 blue:0.15 alpha:.95].CGColor);
                CGContextFillEllipseInRect(context, circle);
                NSString *text = [NSString stringWithFormat:@"%u", marker->ordinal];
                NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:self.markerSize * .7],
                    NSForegroundColorAttributeName: UIColor.whiteColor};
                CGSize size = [text sizeWithAttributes:attributes];
                [text drawAtPoint:CGPointMake(x-size.width/2, y-size.height/2) withAttributes:attributes];
            }
            /* Background = missing HP; progress starts at 12 o'clock and
               proceeds clockwise in UIKit coordinates. No numeric HP label. */
            CGContextSetLineWidth(context, 2);
            CGContextSetStrokeColorWithColor(context,[UIColor colorWithWhite:.25 alpha:.95].CGColor);
            CGContextStrokeEllipseInRect(context, circle);
            if(marker->health_fraction_ok && marker->health_fraction>0) {
                double hp=marker->health_fraction;
                UIColor *color=hp>.5 ? [UIColor colorWithRed:.2 green:1 blue:.3 alpha:1] :
                    hp>.25 ? UIColor.yellowColor : [UIColor colorWithRed:1 green:.2 blue:.2 alpha:1];
                CGContextSetStrokeColorWithColor(context,color.CGColor);
                CGContextAddArc(context,x,y,radius,-M_PI_2,-M_PI_2+2*M_PI*hp,0); CGContextStrokePath(context);
            }
            CGContextRestoreGState(context);
        }
    }
}
- (void)dealloc { [_displayLink invalidate]; }
@end

@interface LVHUDController : UIViewController
@property(nonatomic, strong) UIView *canvas;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) LVMinimapView *minimap;
@property(nonatomic, strong) UILabel *mapStatus;
@property(nonatomic, copy) NSArray *minimapBasis;
@property(nonatomic) NSTimeInterval lastSampleAt;
@property(nonatomic, strong) id orientationObserver;
@property(nonatomic, strong) dispatch_source_t timer;
@property(nonatomic) BOOL sampling;
@property(nonatomic) NSUInteger frames;
@property(nonatomic) UIInterfaceOrientation currentOrientation;
@end
@implementation LVHUDController
- (UIInterfaceOrientationMask)supportedInterfaceOrientations { return UIInterfaceOrientationMaskPortrait; }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor; self.view.userInteractionEnabled = NO;
    self.canvas = [[UIView alloc] initWithFrame:self.view.bounds];
    self.canvas.userInteractionEnabled = NO; [self.view addSubview:self.canvas];
    self.label = [UILabel new]; self.label.numberOfLines = 0;
    self.label.font = [UIFont monospacedSystemFontOfSize:12 weight:UIFontWeightMedium];
    self.label.textColor = UIColor.whiteColor; self.label.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.65];
    self.label.layer.cornerRadius = 7; self.label.layer.masksToBounds = YES;
    self.label.textAlignment = NSTextAlignmentCenter; self.label.userInteractionEnabled = NO;
    self.label.hidden = hudMapSettings.values[LV_HUD_INFO_PANEL] == 0;
    self.label.text = @"lvlolm · 只读悬浮窗\n正在采样…";
    [self.canvas addSubview:self.label];
    self.minimap = [LVMinimapView new]; self.minimap.opaque = NO;
    NSString *heroDirectory = [[LVHUDExecutablePath().stringByDeletingLastPathComponent
        stringByAppendingPathComponent:@"Assets"] stringByAppendingPathComponent:@"Heroes"];
    self.minimap.portraitStore = [[LVHeroPortraits alloc] initWithDirectory:heroDirectory];
    self.minimap.backgroundColor = UIColor.clearColor; self.minimap.userInteractionEnabled = NO;
    self.minimap.references = hudMapSettings.values[LV_MAP_REFERENCES] != 0;
    self.minimap.markerSize = hudMapSettings.values[LV_MAP_MARKER_SIZE];
    [self.canvas addSubview:self.minimap];
    self.mapStatus = [UILabel new]; self.mapStatus.numberOfLines = 2; self.mapStatus.userInteractionEnabled = NO;
    self.mapStatus.font = [UIFont monospacedSystemFontOfSize:10 weight:UIFontWeightMedium];
    self.mapStatus.textColor = UIColor.whiteColor;
    self.mapStatus.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.6];
    self.mapStatus.text = @"敌方位置采样中…"; [self.canvas addSubview:self.mapStatus];
    [self rotate:UIInterfaceOrientationPortrait];
    Class observerClass = NSClassFromString(@"FBSOrientationObserver");
    if (observerClass) {
        self.orientationObserver = [[observerClass alloc] init];
        __weak LVHUDController *weak = self;
        if ([self.orientationObserver respondsToSelector:@selector(setHandler:)])
            [self.orientationObserver setHandler:^(id update) {
                if (![update respondsToSelector:@selector(orientation)]) return;
                UIInterfaceOrientation orientation = (UIInterfaceOrientation)[(id<LVHUDOrientationUpdate>)update orientation];
                dispatch_async(dispatch_get_main_queue(), ^{ [weak rotate:orientation]; });
            }];
        if ([self.orientationObserver respondsToSelector:@selector(activeInterfaceOrientation)])
            [self rotate:(UIInterfaceOrientation)[self.orientationObserver activeInterfaceOrientation]];
    }
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW,
        (uint64_t)(NSEC_PER_SEC * LV_MINIMAP_SAMPLE_INTERVAL_SECONDS), NSEC_PER_MSEC * 20);
    __weak LVHUDController *weak = self;
    dispatch_source_set_event_handler(self.timer, ^{ [weak sample]; }); dispatch_resume(self.timer);
}
- (void)rotate:(UIInterfaceOrientation)orientation {
    if (orientation < UIInterfaceOrientationPortrait || orientation > UIInterfaceOrientationLandscapeRight) return;
    self.currentOrientation = orientation;
    CGRect screen = UIScreen.mainScreen.bounds; CGSize size = screen.size;
    CGFloat angle = 0;
    if (UIInterfaceOrientationIsLandscape(orientation)) { size = CGSizeMake(screen.size.height, screen.size.width); }
    if (orientation == UIInterfaceOrientationLandscapeLeft) angle = -M_PI_2;
    else if (orientation == UIInterfaceOrientationLandscapeRight) angle = M_PI_2;
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown) angle = M_PI;
    self.canvas.transform = CGAffineTransformIdentity;
    self.canvas.bounds = (CGRect){CGPointZero, size};
    self.canvas.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    self.canvas.transform = CGAffineTransformMakeRotation(angle);
    CGFloat width = MIN(340, size.width - 36);
    self.label.frame = CGRectMake((size.width - width) / 2, UIInterfaceOrientationIsLandscape(orientation) ? 16 : 64, width, 132);
    const float *v = hudMapSettings.values;
    self.minimap.frame = CGRectMake(size.width * v[LV_MAP_LEFT] / 100, size.height * v[LV_MAP_TOP] / 100,
        size.width * v[LV_MAP_WIDTH] / 100, size.height * v[LV_MAP_HEIGHT] / 100);
    self.mapStatus.frame = CGRectMake(self.minimap.frame.origin.x,
        MIN(size.height-30, CGRectGetMaxY(self.minimap.frame)+3), MIN(210, size.width-self.minimap.frame.origin.x), 28);
    BOOL show = UIInterfaceOrientationIsLandscape(orientation) && hudConfig.values[lv_config_index("drawMinimap")][0] != 0;
    self.minimap.hidden = !show;
    self.mapStatus.hidden = !show || hudMapSettings.values[LV_HUD_INFO_PANEL] == 0;
}
- (void)sample {
    if (self.lastSampleAt && NSProcessInfo.processInfo.systemUptime - self.lastSampleAt > 2) {
        self.minimap.markers = @[]; self.mapStatus.text = @"位置采样过期 · 已清除标记";
    }
    if (self.sampling) return; self.sampling = YES;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        @autoreleasepool {
            char path[PATH_MAX] = {0};
            BOOL sameTarget = proc_pidpath(targetPID, path, sizeof(path)) > 0 &&
                [[NSString stringWithUTF8String:path] isEqualToString:targetIdentity];
            BOOL bundlePresent = [NSFileManager.defaultManager fileExistsAtPath:LVHUDExecutablePath()];
            if (!sameTarget || !bundlePresent) {
                dispatch_async(dispatch_get_main_queue(), ^{ clearState(); exit(0); }); return;
            }
            NSDictionary *snapshot = LVReadTargetSnapshot(hudReader, hudMetadata, &hudConfig, &hudMapSettings);
            recordCoordinateTrace(snapshot);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sampling = NO; self.lastSampleAt = NSProcessInfo.processInfo.systemUptime;
                ++self.frames; [self presentSnapshot:snapshot];
                publishMetrics(snapshot, self.frames, (unsigned)self.currentOrientation);
            });
        }
    });
}
- (void)presentSnapshot:(NSDictionary *)snapshot {
    NSDictionary *map = snapshot[@"minimap"];
    NSDictionary *geometry = map[@"geometry"];
    NSArray *basis = @[map[@"local_camp"] ?: @0, map[@"rotation_degrees"] ?: @0,
        map[@"manual_projection"] ?: @0, geometry[@"scale_x"] ?: @0, geometry[@"scale_z"] ?: @0,
        geometry[@"half_width"] ?: @0, geometry[@"half_height"] ?: @0,
        snapshot[@"trace"][@"drive_instance"] ?: @""];
    if (![self.minimapBasis isEqual:basis]) self.minimap.markers = @[];
    self.minimapBasis = basis;
    self.minimap.markers = [map[@"projection_ready"] boolValue] ? map[@"markers"] : @[];
    NSUInteger enemyMarkers = 0;
    for (NSDictionary *marker in self.minimap.markers) if (![marker[@"is_local"] boolValue]) ++enemyMarkers;
    if ([map[@"projection_ready"] boolValue]) {
        self.mapStatus.text = [NSString stringWithFormat:@"敌方已读 %@ · 标记 %lu\n%@ · 死亡 %@ · 未定位 %lu",
            map[@"confirmed_enemy_hero_count"], (unsigned long)enemyMarkers,
            [map[@"manual_projection"] boolValue] ? @"手动映射" : @"游戏映射",
            map[@"dead_enemy_count"], (unsigned long)([map[@"missing_enemy_position_count"] unsignedIntegerValue]+[map[@"outside_map_enemy_count"] unsignedIntegerValue])];
    } else {
        NSString *reason = map[@"reason"];
        self.mapStatus.text = [NSString stringWithFormat:@"敌方已读 %@ · 位置暂不可用\n%@",
            map[@"confirmed_enemy_hero_count"] ?: @0,
            [reason isEqual:@"expanded_or_viewport_map"] ? @"请恢复普通小地图" : @"返回应用导出报告"];
    }
    if (self.label.hidden) return;
    NSString *result = snapshot[@"result"];
    if (![result isEqual:@"ready"] && ![result isEqual:@"partial"]) {
        self.label.text = @"lvlolm · 只读悬浮窗\n本次数据不可用\n不会沿用上一帧数值\n返回恢复应用检查报告";
        return;
    }
    NSMutableArray *lines = [NSMutableArray new];
    [lines addObject:[NSString stringWithFormat:@"lvlolm · 只读 · 更新 %lu", (unsigned long)self.frames]];
    NSDictionary *local = nil;
    for (NSDictionary *actor in snapshot[@"actors"]) if ([actor[@"is_local"] boolValue]) { local = actor; break; }
    [lines addObject:[local[@"health_read_ok"] boolValue] ?
        [NSString stringWithFormat:@"本机血量 %.1f · 对象 %@", [local[@"health"] doubleValue], snapshot[@"read_actor_count"] ?: @0] : @"本机血量未读到"];
    NSDictionary *smite = nil;
    for (NSDictionary *skill in snapshot[@"local_skills"][@"summoner"][@"skills"])
        if ([skill[@"values_read_ok"] boolValue] && [skill[@"resource_id"] unsignedIntValue] == 81110101) { smite = skill; break; }
    NSString *cd = [smite[@"cooldown_read_ok"] boolValue] ? [NSString stringWithFormat:@"%.2fs", [smite[@"cooldown_seconds"] doubleValue]] : @"未知";
    NSString *stock = [smite[@"stock_read_ok"] boolValue] ? [NSString stringWithFormat:@"%@/%@", smite[@"stock_current"], smite[@"stock_maximum"]] : @"未知";
    [lines addObject:[NSString stringWithFormat:@"惩戒 CD %@ · 库存 %@", cd, stock]];
    NSDictionary *preview = snapshot[@"smite_preview"], *nearest = nil;
    for (NSDictionary *candidate in preview[@"candidates"]) {
        if (![candidate[@"distance_read_ok"] boolValue]) continue;
        if (!nearest || [candidate[@"distance_world_xz"] doubleValue] < [nearest[@"distance_world_xz"] doubleValue]) nearest = candidate;
    }
    if (nearest) {
        NSString *health = nearest[@"health"] ? [NSString stringWithFormat:@"%.1f", [nearest[@"health"] doubleValue]] : @"未知";
        [lines addObject:[NSString stringWithFormat:@"目标 %@ · 血量 %@ · 距离 %.2f", nearest[@"resource_id"], health, [nearest[@"distance_world_xz"] doubleValue]]];
    }
    else [lines addObject:@"未读到原目标清单中的对象"];
    NSArray *blocks = preview[@"blockers"];
    [lines addObject:[preview[@"would_trigger_in_simulation"] boolValue] ? @"模拟符合规则 · 不会自动点击" : blockLabel(blocks.firstObject)];
    [lines addObject:[NSString stringWithFormat:@"原程序阈值 %@ · 停止请返回恢复应用", preview[@"original_rule_threshold"] ?: @0]];
    self.label.text = [lines componentsJoinedByString:@"\n"];
}
- (void)dealloc {
    if (_timer) dispatch_source_cancel(_timer);
    if ([_orientationObserver respondsToSelector:@selector(invalidate)]) [_orientationObserver invalidate];
}
@end

@interface LVHUDApp : UIApplication
@end
@implementation LVHUDApp
@end
@interface LVHUDDelegate : NSObject <UIApplicationDelegate>
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) id host;
@end
@implementation LVHUDDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)options {
    @try {
        Class hostClass = NSClassFromString(@"SBSAccessibilityWindowHostingController");
        self.host = hostClass ? [[hostClass alloc] init] : nil;
        if (![self.host respondsToSelector:@selector(registerWindowWithContextID:atLevel:)]) {
            acknowledge(@{ @"error": @"global window hosting API unavailable" }); exit(1);
        }
        self.window = [[LVHUDWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        self.window.backgroundColor = UIColor.clearColor; self.window.userInteractionEnabled = NO;
        self.window.rootViewController = [LVHUDController new]; self.window.windowLevel = 10000010.0;
        [self.window makeKeyAndVisible];
        if (![self.window respondsToSelector:@selector(_contextId)]) {
            acknowledge(@{ @"error": @"HUD window context API unavailable" }); exit(1);
        }
        unsigned int context = [self.window _contextId];
        if (!context) { acknowledge(@{ @"error": @"HUD window context is zero" }); exit(1); }
        [self.host registerWindowWithContextID:context atLevel:self.window.windowLevel];
        uint32_t code = notify_register_check(LVHUDNotification(hudSession, NO).UTF8String, &stateToken);
        if (!code) code = notify_set_state(stateToken, UINT64_C(0x4c56485500000000) | (uint32_t)getpid());
        if (!code) code = initializeMetrics();
        if (!code) code = notify_register_dispatch(LVHUDNotification(hudSession, YES).UTF8String, &stopToken,
            dispatch_get_main_queue(), ^(int token) { clearState(); exit(0); });
        if (code) { acknowledge(@{ @"error": @"HUD lifecycle notification failed", @"notify_code": @(code) }); exit(1); }
        acknowledge(@{ @"running": @YES, @"hud_pid": @(getpid()), @"target_pid": @(targetPID), @"uid": @(getuid()),
            @"task_result": @(hudReader.connectionResult), @"window_host_request_sent": @YES,
            @"touch_passthrough_requested": @YES, @"visible_on_device_verified": @NO,
            @"mode": @"read_only_live_hud", @"simulation_only": @YES, @"touch_backend_available": @NO,
            @"metrics_protocol_version": @LV_HUD_METRIC_VERSION,
            @"minimap_overlay_implemented": @YES, @"minimap_alignment_device_verified": @NO,
            @"minimap_calibration": mapCalibration(),
            @"info_panel_enabled": @(hudMapSettings.values[LV_HUD_INFO_PANEL] != 0),
            @"display_geometry": displayGeometry(),
            @"sampling_interval_seconds": @(LV_MINIMAP_SAMPLE_INTERVAL_SECONDS),
            @"minimap_animation_enabled": @YES, @"minimap_animation_duration_seconds": @(LV_MINIMAP_SAMPLE_INTERVAL_SECONDS),
            @"minimap_preferred_display_fps": @60,
            @"orientation_observer_available": @(NSClassFromString(@"FBSOrientationObserver") != nil) });
        return YES;
    } @catch (NSException *exception) {
        acknowledge(@{ @"error": @"HUD window startup exception", @"exception_name": exception.name }); exit(1);
    }
}
@end

int main(int argc, char **argv) {
    @autoreleasepool {
        if (argc != 4 || getuid() != 0) { acknowledge(@{ @"error": @"invalid HUD invocation" }); return 2; }
        char *end = NULL; errno = 0; long pid = strtol(argv[1], &end, 10);
        hudSession = [NSString stringWithUTF8String:argv[2]];
        lv_config_defaults(&hudConfig);
        lv_minimap_defaults(&hudMapSettings);
        if (errno || end == argv[1] || *end || pid <= 0 || pid > INT_MAX || !LVHUDSessionValid(hudSession) ||
            strnlen(argv[3], 16385) > 16384 || lv_config_parse(&hudConfig, argv[3], NULL) ||
            !lv_minimap_parse(&hudMapSettings, argv[3])) {
            acknowledge(@{ @"error": @"invalid HUD target, session or configuration" }); return 2;
        }
        targetPID = (pid_t)pid;
        char path[PATH_MAX] = {0};
        if (proc_pidpath(targetPID, path, sizeof(path)) <= 0 ||
            ![[NSString stringWithUTF8String:path] hasSuffix:@"/lolm.app/lolm"]) {
            acknowledge(@{ @"error": @"HUD target identity unavailable" }); return 2;
        }
        targetIdentity = [NSString stringWithUTF8String:path];
        hudReader = [[LVMachReader alloc] initWithPID:targetPID];
        if (hudReader.connectionResult != KERN_SUCCESS) {
            acknowledge(@{ @"error": @"HUD task port unavailable", @"task_result": @(hudReader.connectionResult) }); return 1;
        }
        hudMetadata = [hudReader imageMetadata];
        BOOL uuidMatches = NO;
        for (NSDictionary *image in hudMetadata[@"images"])
            if ([image[@"path"] hasSuffix:@"/Frameworks/UnityFramework.framework/UnityFramework"] &&
                [image[@"uuid"] isEqual:@"085E1DDF-4A8D-34E2-9D73-A0A28BCC0B83"]) uuidMatches = YES;
        if (!uuidMatches) { acknowledge(@{ @"error": @"HUD framework UUID does not match this profile" }); return 1; }
        atexit(clearState);
        void *graphics = dlopen("/System/Library/PrivateFrameworks/GraphicsServices.framework/GraphicsServices", RTLD_NOW | RTLD_LOCAL);
        void *backboard = dlopen("/System/Library/PrivateFrameworks/BackBoardServices.framework/BackBoardServices", RTLD_NOW | RTLD_LOCAL);
        dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_NOW | RTLD_LOCAL);
        dlopen("/System/Library/PrivateFrameworks/FrontBoardServices.framework/FrontBoardServices", RTLD_NOW | RTLD_LOCAL);
        if (!graphics || !backboard) {
            acknowledge(@{ @"error": @"HUD system framework could not load" }); return 1;
        }
        void (*gsInitialize)(void) = dlsym(graphics, "GSInitialize");
        void (*displayStart)(void) = dlsym(backboard, "BKSDisplayServicesStart");
        void (*appInitialize)(void) = dlsym(RTLD_DEFAULT, "UIApplicationInitialize");
        void (*instantiate)(id) = dlsym(RTLD_DEFAULT, "UIApplicationInstantiateSingleton");
        void (*eventInitialize)(Boolean) = dlsym(graphics, "GSEventInitialize");
        void (*pushMode)(CFStringRef) = dlsym(graphics, "GSEventPushRunLoopMode");
        if (!gsInitialize || !displayStart || !appInitialize || !instantiate || !eventInitialize || !pushMode) {
            acknowledge(@{ @"error": @"HUD plugin bootstrap symbols unavailable" }); return 1;
        }
        @try {
            [UIScreen initialize]; CFRunLoopGetCurrent();
            gsInitialize(); displayStart(); appInitialize(); instantiate(LVHUDApp.class);
            static LVHUDDelegate *delegate; delegate = [LVHUDDelegate new];
            UIApplication *app = UIApplication.sharedApplication; app.delegate = delegate;
            if (![app respondsToSelector:@selector(_accessibilityInit)] || ![app respondsToSelector:@selector(__completeAndRunAsPlugin)]) {
                acknowledge(@{ @"error": @"HUD plugin selectors unavailable" }); return 1;
            }
            [app _accessibilityInit]; eventInitialize(false); pushMode(kCFRunLoopDefaultMode);
            [app __completeAndRunAsPlugin]; CFRunLoopRun();
        } @catch (NSException *exception) {
            acknowledge(@{ @"error": @"HUD bootstrap exception", @"exception_name": exception.name }); return 1;
        }
        return 0;
    }
}
