#include "LVMinimapMotion.h"
#include <math.h>
#include <string.h>

void lv_minimap_motion_clear(LVMinimapMotion *m) { if (m) memset(m, 0, sizeof(*m)); }
static double progress(const LVMinimapMotion *m, double now) {
    if (!m->active || !isfinite(now) || m->duration <= 0) return 1;
    double p = (now - m->started_at) / m->duration;
    return p < 0 ? 0 : p > 1 ? 1 : p;
}
int lv_minimap_motion_active(const LVMinimapMotion *m, double now) {
    return m && m->active && isfinite(now) && progress(m, now) < 1;
}
int lv_minimap_motion_position(const LVMinimapMotion *m, size_t i, double now, double *u, double *v) {
    if (!m || i >= m->count || !u || !v) return 0;
    const LVMinimapMotionItem *item = &m->items[i]; double p = progress(m, now);
    *u = item->from_u + (item->target.u - item->from_u) * p;
    *v = item->from_v + (item->target.v - item->from_v) * p;
    return 1;
}
int lv_minimap_motion_update(LVMinimapMotion *m, const LVMinimapMarker *markers,
                            size_t count, double now, double duration) {
    if (!m) return 0;
    if (count > LV_TARGET_MAX_ACTORS || (count && !markers) || !isfinite(now) || now < 0 ||
        !isfinite(duration) || duration <= 0 || duration > 1) { lv_minimap_motion_clear(m); return 0; }
    LVMinimapMotion next = {.count=count, .started_at=now, .duration=duration};
    for (size_t i = 0; i < count; ++i) {
        const LVMinimapMarker *a = &markers[i];
        if (!a->object_id || a->is_local > 1 || a->ordinal > LV_TARGET_MAX_ACTORS ||
            a->health_fraction_ok>1 || a->edge_clamped>1 ||
            (a->health_fraction_ok && (!isfinite(a->health_fraction) || a->health_fraction<0 || a->health_fraction>1)) ||
            !isfinite(a->u) || !isfinite(a->v) || a->u < 0 || a->u > 1 || a->v < 0 || a->v > 1) {
            lv_minimap_motion_clear(m); return 0;
        }
        for (size_t j = 0; j < i; ++j) if (markers[j].object_id == a->object_id) {
            lv_minimap_motion_clear(m); return 0;
        }
        LVMinimapMotionItem *item = &next.items[i];
        item->target = *a; item->from_u = a->u; item->from_v = a->v;
        for (size_t j = 0; j < m->count; ++j) {
            const LVMinimapMarker *previous = &m->items[j].target;
            if (previous->object_id != a->object_id || previous->resource_id != a->resource_id ||
                previous->is_local != a->is_local) continue;
            double u, v; lv_minimap_motion_position(m, j, now, &u, &v);
            /* Large jumps snap to the new sample, avoiding a sweep across
               the map after teleportation or identity reuse. */
            if (hypot(a->u - u, a->v - v) <= .12) {
                item->from_u = u; item->from_v = v;
                if (a->u != u || a->v != v) next.active = 1;
            }
            break;
        }
    }
    *m = next; return 1;
}
