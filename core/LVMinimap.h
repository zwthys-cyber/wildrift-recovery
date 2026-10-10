#ifndef LV_MINIMAP_H
#define LV_MINIMAP_H
#include "LVTarget.h"

/* iOS calibration is separate from the 57 recovered Android settings. */
#define LV_MINIMAP_FIELDS 11
typedef struct { const char *key, *label; float initial, minimum, maximum; } LVMinimapField;
extern const LVMinimapField lv_minimap_fields[LV_MINIMAP_FIELDS];
typedef struct { float values[LV_MINIMAP_FIELDS]; } LVMinimapSettings;
enum { LV_MAP_LEFT, LV_MAP_TOP, LV_MAP_WIDTH, LV_MAP_HEIGHT, LV_MAP_ROTATION,
       LV_MAP_SPAN, LV_MAP_MANUAL, LV_MAP_REFERENCES, LV_MAP_MARKER_SIZE, LV_HUD_INFO_PANEL,
       LV_MAP_LOCAL_POINT };
void lv_minimap_defaults(LVMinimapSettings *settings);
/* Apply only the four screen rectangle fields, retaining all other options. */
int lv_minimap_apply_recommended_rect(LVMinimapSettings *settings);
/* Caller guards migration with its persisted preset version. */
int lv_minimap_migrate_legacy_rect(LVMinimapSettings *settings);
int lv_minimap_set(LVMinimapSettings *settings, size_t index, const char *value);
int lv_minimap_parse(LVMinimapSettings *settings, const char *text);
size_t lv_minimap_serialize(const LVMinimapSettings *settings, char *output, size_t capacity);

typedef struct {
    unsigned ready, viewport_mode, full_map_showing;
    const char *reason;
    float scale_x, scale_z, half_width, half_height;
    uint32_t zoom_state;
} LVMinimapGeometry;
/* UUID must already match LV_TARGET_UUID. No remote calls or writes. */
void lv_minimap_read(LVTargetRead read, void *context, uint64_t base, LVMinimapGeometry *output);
typedef struct {
    const char *reason;
    size_t matched, enabled, valid;
} LVMinimapHealthReport;
/* Read UIMiniIconHeroCtrl.currentHpPercent without executing game methods. */
void lv_minimap_health_read(LVTargetRead read, void *context, uint64_t base,
                           LVTargetSnapshot *snapshot, LVMinimapHealthReport *report);
typedef struct {
    uint32_t object_id;
    int32_t resource_id;
    unsigned ordinal, is_local;
    double u, v; /* UIKit coordinates in the calibrated rectangle, [0,1]. */
    double health_fraction;
    unsigned health_fraction_ok, edge_clamped;
    unsigned health_source; /* 0 unknown, 1 native current/max, 2 minimap UI */
} LVMinimapMarker;
typedef struct {
    unsigned ready, manual_projection;
    const char *reason;
    int local_camp, rotation_degrees;
    size_t confirmed_enemies, dead_enemies, missing_enemies, outside_enemies, duplicate_ids;
    size_t count;
    size_t edge_clamped_enemies;
    LVMinimapMarker markers[LV_TARGET_MAX_ACTORS];
} LVMinimapFrame;
void lv_minimap_frame(const LVTargetSnapshot *snapshot, const LVMinimapGeometry *geometry,
                      const LVMinimapSettings *settings, LVMinimapFrame *output);
#endif
