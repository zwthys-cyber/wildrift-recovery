#ifndef LV_HUD_TELEMETRY_H
#define LV_HUD_TELEMETRY_H
#include <stdint.h>
#include <stddef.h>

/* Small diagnostic record transported in notify states. It never contains
   target pointers, input events, or a complete gameplay snapshot. */
#define LV_HUD_METRIC_WORDS 9
#define LV_HUD_METRIC_VERSION 3
enum {
    LV_HUD_OWNER, LV_HUD_SEQUENCE, LV_HUD_FRAMES, LV_HUD_TIME,
    LV_HUD_DATA, LV_HUD_COOLDOWN, LV_HUD_STOCK, LV_HUD_RESERVED, LV_HUD_MAPDETAIL
};
typedef enum {
    LV_HUD_READY, LV_HUD_PARTIAL, LV_HUD_NOT_IN_BATTLE, LV_HUD_UNREADABLE,
    LV_HUD_LAYOUT_MISMATCH, LV_HUD_CHANGED, LV_HUD_LIMIT, LV_HUD_UUID_MISMATCH,
    LV_HUD_FRAMEWORK_NOT_FOUND, LV_HUD_INVALID_IMAGE_ADDRESS, LV_HUD_UNKNOWN
} LVHUDResult;
typedef struct {
    uint32_t owner_pid;
    uint64_t frames, completed_at_ms;
    LVHUDResult result;
    uint16_t actor_count, skipped_count;
    unsigned orientation; /* UIInterfaceOrientation numeric value, 0 = unknown */
    unsigned cooldown_ok, stock_ok;
    int64_t cooldown_fixed;
    int32_t stock_current, stock_maximum;
    uint16_t enemy_count, enemy_markers, enemy_unplaced;
    uint16_t displayed_markers, health_ring_markers, edge_clamped_markers;
    unsigned minimap_enabled, map_projection_ok, map_manual;
    double age_seconds;
    unsigned fresh, snapshot_usable;
} LVHUDMetrics;

/* Caller reads owner and sequence again after fetching words and accepts only
   unchanged values. Odd sequences mark an incomplete publication. */
int lv_hud_metrics_decode(const uint64_t words[LV_HUD_METRIC_WORDS],
                          uint32_t expected_pid, uint64_t now_ms, LVHUDMetrics *out);
int lv_hud_metrics_encode(const LVHUDMetrics *, uint64_t words[LV_HUD_METRIC_WORDS]);
const char *lv_hud_result_name(LVHUDResult result);
LVHUDResult lv_hud_result_from_name(const char *name);
#endif
