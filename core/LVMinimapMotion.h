#ifndef LV_MINIMAP_MOTION_H
#define LV_MINIMAP_MOTION_H
#include "LVMinimap.h"

#define LV_MINIMAP_SAMPLE_INTERVAL_SECONDS 0.15
typedef struct {
    LVMinimapMarker target;
    double from_u, from_v;
} LVMinimapMotionItem;
typedef struct {
    size_t count;
    double started_at, duration;
    unsigned active;
    LVMinimapMotionItem items[LV_TARGET_MAX_ACTORS];
} LVMinimapMotion;
/* Rendering state only. Empty/invalid frames clear it immediately. */
void lv_minimap_motion_clear(LVMinimapMotion *motion);
int lv_minimap_motion_update(LVMinimapMotion *motion, const LVMinimapMarker *markers,
                            size_t count, double now, double duration);
int lv_minimap_motion_active(const LVMinimapMotion *motion, double now);
int lv_minimap_motion_position(const LVMinimapMotion *motion, size_t index,
                              double now, double *u, double *v);
#endif
