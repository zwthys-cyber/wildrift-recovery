#include "LVMinimap.h"
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const LVMinimapField lv_minimap_fields[LV_MINIMAP_FIELDS] = {
    /* Estimated from the user's cropped 0.7.0 screenshot and old rectangle,
       not from the attachment's dimensions or a recovered UI transform. */
    {"iosMapLeftPercent", "小地图左边（屏宽 %）", 6.8f, 0, 95},
    {"iosMapTopPercent", "小地图上边（屏高 %）", 1.2f, 0, 95},
    {"iosMapWidthPercent", "小地图宽度（屏宽 %）", 15.5f, 5, 60},
    {"iosMapHeightPercent", "小地图高度（屏高 %）", 33.5f, 5, 60},
    {"iosMapRotation", "地图方向（-1 自动）", -1, -1, 270},
    {"iosMapWorldSpan", "手动映射世界宽度", 110, 50, 1000},
    {"iosMapManualProjection", "使用手动映射", 0, 0, 1},
    {"iosMapReferences", "显示对齐框", 1, 0, 1},
    {"iosMapMarkerSize", "敌方标记直径（点）", 12, 6, 24},
    {"iosHUDInfoPanel", "显示信息面板", 0, 0, 1},
    {"iosMapLocalPoint", "显示本机定位点（＋）", 0, 0, 1},
};
static int settings_valid(const LVMinimapSettings *s) {
    if (!s) return 0;
    for (size_t i = 0; i < LV_MINIMAP_FIELDS; ++i)
        if (!isfinite(s->values[i]) || s->values[i] < lv_minimap_fields[i].minimum ||
            s->values[i] > lv_minimap_fields[i].maximum) return 0;
    float r = s->values[LV_MAP_ROTATION];
    return (r == -1 || r == 0 || r == 90 || r == 180 || r == 270) &&
        (s->values[LV_MAP_MANUAL] == 0 || s->values[LV_MAP_MANUAL] == 1) &&
        (s->values[LV_MAP_REFERENCES] == 0 || s->values[LV_MAP_REFERENCES] == 1) &&
        (s->values[LV_HUD_INFO_PANEL] == 0 || s->values[LV_HUD_INFO_PANEL] == 1) &&
        (s->values[LV_MAP_LOCAL_POINT] == 0 || s->values[LV_MAP_LOCAL_POINT] == 1) &&
        s->values[LV_MAP_LEFT] + s->values[LV_MAP_WIDTH] <= 100 &&
        s->values[LV_MAP_TOP] + s->values[LV_MAP_HEIGHT] <= 100;
}
void lv_minimap_defaults(LVMinimapSettings *s) {
    if (s) for (size_t i = 0; i < LV_MINIMAP_FIELDS; ++i) s->values[i] = lv_minimap_fields[i].initial;
}
int lv_minimap_apply_recommended_rect(LVMinimapSettings *s) {
    if (!s) return 0;
    LVMinimapSettings next = *s;
    for (size_t i = LV_MAP_LEFT; i <= LV_MAP_HEIGHT; ++i) next.values[i] = lv_minimap_fields[i].initial;
    if (!settings_valid(&next)) return 0;
    *s = next; return 1;
}
int lv_minimap_migrate_legacy_rect(LVMinimapSettings *s) {
    /* Only replace the exact old default rectangle. A customized edge or
       size must survive upgrading, along with direction and other settings. */
    if (!s || s->values[LV_MAP_LEFT] != 5 || s->values[LV_MAP_TOP] != 2 ||
        s->values[LV_MAP_WIDTH] != 15 || s->values[LV_MAP_HEIGHT] != 32) return 0;
    return lv_minimap_apply_recommended_rect(s);
}
static int parse_value(LVMinimapSettings *s, size_t i, const char *text) {
    if (!s || i >= LV_MINIMAP_FIELDS || !text) return 0;
    char *end; errno = 0; float value = strtof(text, &end);
    if (end == text || errno || !isfinite(value)) return 0;
    while (*end == ' ' || *end == '\t' || *end == '\r') ++end;
    if (*end) return 0;
    s->values[i] = value; return 1;
}
int lv_minimap_set(LVMinimapSettings *s, size_t i, const char *text) {
    if (!s) return 0;
    LVMinimapSettings next = *s;
    if (!parse_value(&next, i, text) || !settings_valid(&next)) return 0;
    *s = next; return 1;
}
int lv_minimap_parse(LVMinimapSettings *s, const char *text) {
    if (!s || !text || strnlen(text, 16385) > 16384) return 0;
    LVMinimapSettings next = *s;
    char buffer[16385]; strcpy(buffer, text);
    for (char *line = buffer; line;) {
        char *tail = strchr(line, '\n'); if (tail) *tail++ = 0;
        while (*line == ' ' || *line == '\t' || *line == '\r') ++line;
        char *eq = strchr(line, '=');
        if (*line != '#' && *line != ';' && eq) {
            *eq++ = 0;
            size_t n = strlen(line);
            while (n && (line[n-1] == ' ' || line[n-1] == '\t' || line[n-1] == '\r')) line[--n] = 0;
            for (size_t i = 0; i < LV_MINIMAP_FIELDS; ++i)
                if (!strcmp(line, lv_minimap_fields[i].key) && !parse_value(&next, i, eq)) return 0;
        }
        line = tail;
    }
    if (!settings_valid(&next)) return 0;
    *s = next; return 1;
}
size_t lv_minimap_serialize(const LVMinimapSettings *s, char *out, size_t capacity) {
    if (!settings_valid(s)) return 0;
    size_t used = 0;
    for (size_t i = 0; i < LV_MINIMAP_FIELDS; ++i) {
        char line[128]; int n = snprintf(line, sizeof(line), "%s=%.4f\n", lv_minimap_fields[i].key, (double)s->values[i]);
        if (n < 0 || (size_t)n >= sizeof(line)) return 0;
        if (out && used < capacity) {
            size_t count = (size_t)n < capacity - used - 1 ? (size_t)n : capacity - used - 1;
            memcpy(out + used, line, count); out[used + count] = 0;
        }
        used += (size_t)n;
    }
    return used + 1;
}
static int valid_address(uint64_t a, size_t n) {
    return a >= 0x10000 && a < (UINT64_C(1) << 48) && n && n <= 4096 && n <= (UINT64_C(1) << 48) - a;
}
static int load(LVTargetRead read, void *ctx, uint64_t a, void *out, size_t n) {
    memset(out, 0, n);
    if (!read || !valid_address(a, n) || !read(ctx, a, out, n)) { memset(out, 0, n); return 0; }
    return 1;
}
static int ptr(LVTargetRead read, void *ctx, uint64_t a, uint64_t *out) {
    return load(read, ctx, a, out, 8) && *out && !(*out & 7) && valid_address(*out, 8);
}
static int class_name(LVTargetRead read, void *ctx, uint64_t cls, const char *name) {
    uint64_t np, sp; char text[96], ns;
    size_t n = strlen(name) + 1;
    return n <= sizeof(text) && load(read, ctx, cls + 0x10, &np, 8) && load(read, ctx, cls + 0x18, &sp, 8) &&
        load(read, ctx, np, text, n) && !memcmp(text, name, n) && load(read, ctx, sp, &ns, 1) && ns == 0;
}
static float f32(const unsigned char *data, size_t offset) { float f; memcpy(&f, data + offset - 0x10, 4); return f; }
static int geometry_equal(const unsigned char *a, const unsigned char *b) {
    /* Animation/camera vectors between these fields are unrelated to projection. */
    return a[0] == b[0] && a[0x64] == b[0x64] &&
        !memcmp(a+0x34,b+0x34,8) && !memcmp(a+0x54,b+0x54,8) && !memcmp(a+0x60,b+0x60,4);
}
void lv_minimap_read(LVTargetRead read, void *ctx, uint64_t base, LVMinimapGeometry *out) {
    if (!out) return;
    memset(out, 0, sizeof(*out)); out->reason = "geometry_unavailable";
    if (!valid_address(base, 8) || base > (UINT64_C(1) << 48) - (LV_TARGET_CLASS_CACHE_OFFSET+8)) return;
    uint64_t cache, cls, statics, instance, ui_cls, ui_statics, ui, object_cls;
    if (!ptr(read, ctx, base + LV_TARGET_CLASS_CACHE_OFFSET, &cache) || !ptr(read, ctx, cache + LV_TYPE_MINIMAP_MAPPING * 8ULL, &cls) ||
        !class_name(read, ctx, cls, "UIMiniMappingMgr") || !ptr(read, ctx, cls + 0xb8, &statics) ||
        !ptr(read, ctx, statics, &instance) || !ptr(read, ctx, instance, &object_cls) || object_cls != cls ||
        !ptr(read, ctx, cache + LV_TYPE_MINIMAP_CONTROLLER * 8ULL, &ui_cls) || !class_name(read, ctx, ui_cls, "UIMainBattleMiniMapCtrl") ||
        !ptr(read, ctx, ui_cls + 0xb8, &ui_statics) || !ptr(read, ctx, ui_statics + 0x18, &ui) ||
        !ptr(read, ctx, ui, &object_cls) || object_cls != ui_cls) return;
    unsigned char data[0x74], after[0x74]; uint8_t full, full_after; uint32_t zoom, zoom_after;
    if (!load(read, ctx, instance + 0x10, data, sizeof(data)) || !load(read, ctx, ui + 0x2d9, &full, 1) ||
        !load(read, ctx, ui + 0x330, &zoom, 4)) return;
    int32_t suspended; memcpy(&suspended, data + 0x60, 4);
    if (data[0] > 1 || data[0x64] > 1 || full > 1 || suspended < 0) { out->reason = "geometry_invalid"; return; }
    uint64_t same_cache, same_cls, same_statics, same_instance, same_ui;
    if (!load(read, ctx, instance + 0x10, after, sizeof(after)) || !geometry_equal(data,after) ||
        !ptr(read, ctx, base + LV_TARGET_CLASS_CACHE_OFFSET, &same_cache) || same_cache != cache ||
        !ptr(read, ctx, cache + LV_TYPE_MINIMAP_MAPPING * 8ULL, &same_cls) || same_cls != cls ||
        !ptr(read, ctx, cls + 0xb8, &same_statics) || same_statics != statics ||
        !ptr(read, ctx, statics, &same_instance) || same_instance != instance ||
        !ptr(read, ctx, ui_cls + 0xb8, &same_statics) || same_statics != ui_statics ||
        !ptr(read, ctx, ui_statics + 0x18, &same_ui) || same_ui != ui ||
        !load(read, ctx, ui + 0x2d9, &full_after, 1) || full_after != full ||
        !load(read, ctx, ui + 0x330, &zoom_after, 4) || zoom_after != zoom) {
        out->reason = "geometry_changed"; return;
    }
    out->viewport_mode = data[0]; out->full_map_showing = full; out->zoom_state = zoom;
    /* Only the ordinary map branch at WorldToMiniMap 0x740199c..1a04
       is supported. Viewport/full-map branches use a different origin. */
    if (data[0] || data[0x64] || full) { out->reason = "expanded_or_viewport_map"; return; }
    float sx = f32(data, 0x44), sz = f32(data, 0x48), hw = f32(data, 0x64), hh = f32(data, 0x68);
    if (!isfinite(sx) || !isfinite(sz) || !isfinite(hw) || !isfinite(hh) ||
        sx <= 0 || sz <= 0 || hw <= 0 || hh <= 0 || sx > 10000 || sz > 10000 ||
        hw > 100000 || hh > 100000 || 2*hw/sx < 1 || 2*hw/sx > 10000 ||
        2*hh/sz < 1 || 2*hh/sz > 10000) { out->reason = "geometry_invalid"; return; }
    out->scale_x = sx; out->scale_z = sz; out->half_width = hw; out->half_height = hh;
    out->ready = 1; out->reason = "ready";
}
void lv_minimap_health_read(LVTargetRead read, void *ctx, uint64_t base,
                           LVTargetSnapshot *s, LVMinimapHealthReport *report) {
    LVMinimapHealthReport result = {.reason="health_cache_unavailable"};
    if (report) *report=result;
    if (!s || s->count > LV_TARGET_MAX_ACTORS) return;
    for (size_t i=0;i<s->count;++i) {
        s->actors[i].minimap_health_fraction_ok=0; s->actors[i].minimap_health_fraction_fixed=0;
    }
    if ((s->result!=LV_TARGET_READY && s->result!=LV_TARGET_PARTIAL) ||
        !valid_address(base,8) || base > (UINT64_C(1)<<48)-(LV_TARGET_CLASS_CACHE_OFFSET+8)) return;
    uint64_t cache, cls, statics, entity, icons, dictionary, entries, hero_cls, object_cls, capacity;
    if (!ptr(read,ctx,base+LV_TARGET_CLASS_CACHE_OFFSET,&cache) || !ptr(read,ctx,cache+LV_TYPE_MINIMAP_CONTROLLER*8ULL,&cls) ||
        !class_name(read,ctx,cls,"UIMainBattleMiniMapCtrl") || !ptr(read,ctx,cls+0xb8,&statics) ||
        !ptr(read,ctx,statics,&entity) || !ptr(read,ctx,entity,&object_cls) ||
        !class_name(read,ctx,object_cls,"MiniMapEntityCtrl") || !ptr(read,ctx,entity+0x190,&icons) ||
        !ptr(read,ctx,icons,&object_cls) || !class_name(read,ctx,object_cls,"UIMiniMapIconCtrl") ||
        !ptr(read,ctx,icons+0x80,&dictionary) || !ptr(read,ctx,dictionary+0x18,&entries) ||
        !load(read,ctx,entries+0x18,&capacity,8) || capacity>4096 ||
        !ptr(read,ctx,cache+LV_TYPE_MINIMAP_HERO_ICON*8ULL,&hero_cls) || !class_name(read,ctx,hero_cls,"UIMiniIconHeroCtrl")) return;
    unsigned seen[LV_TARGET_MAX_ACTORS]={0};
    /* GetIconByBattleActor 0x738b8bc..8d8 verifies +18 entries, array +20,
       24-byte Entry<UInt32,UIMiniIconBaseCtrl> and value +10. Read bounded
       chunks, including tombstones, rather than invoking Dictionary methods. */
    for (uint64_t start=0;start<capacity;start+=128) {
        unsigned char chunk[128*24]; size_t count=(size_t)(capacity-start);
        if(count>128) count=128;
        if(!load(read,ctx,entries+0x20+start*24,chunk,count*24)) { result.reason="health_entries_unreadable"; goto discard; }
        for(size_t j=0;j<count;++j) {
            const unsigned char *entry=chunk+j*24; int32_t hash; uint32_t key; uint64_t icon;
            memcpy(&hash,entry,4); memcpy(&key,entry+8,4); memcpy(&icon,entry+16,8);
            if(hash<0 || !key || (icon&7) || !valid_address(icon,8)) continue;
            size_t index=SIZE_MAX;
            for(size_t i=0;i<s->count;++i) if(s->actors[i].values_ok && s->actors[i].classification_ok &&
                s->actors[i].is_hero && s->actors[i].object_id_ok && s->actors[i].object_id==key) {
                if(index!=SIZE_MAX) { index=SIZE_MAX; break; } index=i;
            }
            if(index==SIZE_MAX || !ptr(read,ctx,icon,&object_cls) || object_cls!=hero_cls) continue;
            LVTargetActor *a=&s->actors[index];
            if(++seen[index]>1) { a->minimap_health_fraction_ok=0; continue; }
            uint64_t visual, visual_after; unsigned char before[0x148], after[0x148], same_entry[24];
            if(!ptr(read,ctx,icon+0x98,&visual) || visual!=a->visual ||
                !load(read,ctx,icon+0xc0,before,sizeof(before))) continue;
            uint32_t object_id; int64_t fraction; float update_time;
            memcpy(&object_id,before+0x100,4); memcpy(&fraction,before+0xe0,8); memcpy(&update_time,before+0x140,4);
            if(object_id!=key || before[0]!=1 || before[8]!=0) continue;
            ++result.matched;
            if(before[0xf4]!=1) continue;
            ++result.enabled;
            /* Hidden or never-updated UI percentages are not fresh HP. Failed
               reads and disabled game HP rings remain explicitly unknown. */
            if(before[1]!=1 || !isfinite(update_time) || update_time<=0 || fraction<0 || fraction>16384 ||
                !load(read,ctx,icon+0xc0,after,sizeof(after)) ||
                before[0]!=after[0] || before[1]!=after[1] || before[8]!=after[8] || before[0xf4]!=after[0xf4] ||
                memcmp(before+0xe0,after+0xe0,8) || memcmp(before+0x100,after+0x100,4) ||
                memcmp(before+0x140,after+0x140,4) || !ptr(read,ctx,icon+0x98,&visual_after) || visual_after!=visual ||
                !load(read,ctx,entries+0x20+(start+j)*24,same_entry,24) || memcmp(entry,same_entry,24)) continue;
            a->minimap_health_fraction_fixed=fraction; a->minimap_health_fraction_ok=1;
        }
    }
    uint64_t same;
    if(!ptr(read,ctx,base+LV_TARGET_CLASS_CACHE_OFFSET,&same) || same!=cache ||
        !ptr(read,ctx,cls+0xb8,&same) || same!=statics || !ptr(read,ctx,statics,&same) || same!=entity ||
        !ptr(read,ctx,entity+0x190,&same) || same!=icons || !ptr(read,ctx,icons+0x80,&same) || same!=dictionary ||
        !ptr(read,ctx,dictionary+0x18,&same) || same!=entries ||
        !load(read,ctx,entries+0x18,&same,8) || same!=capacity) { result.reason="health_cache_changed"; goto discard; }
    result.reason="ready";
    for(size_t i=0;i<s->count;++i) result.valid+=s->actors[i].minimap_health_fraction_ok!=0;
    if(report) *report=result;
    return;
discard:
    for(size_t i=0;i<s->count;++i) s->actors[i].minimap_health_fraction_ok=0;
    result.valid=0; if(report) *report=result;
}
static int duplicate_id(const LVTargetSnapshot *s, size_t index) {
    const LVTargetActor *a = &s->actors[index];
    for (size_t i = 0; i < s->count; ++i)
        if (i != index && s->actors[i].object_id_ok && s->actors[i].object_id == a->object_id) return 1;
    return 0;
}
static int add_marker(LVMinimapFrame *out, const LVTargetActor *a, unsigned ordinal,
                       const LVMinimapGeometry *g, const LVMinimapSettings *settings) {
    if ((!a->logic_position_ok && !a->position_ok) || (a->health_ok && a->health_fixed <= 0)) return 0;
    const int64_t *p=a->logic_position_ok ? a->logic_position_fixed : a->position_fixed;
    double x = (double)p[0] / 16384, z = (double)p[2] / 16384;
    /* Red-side 180-degree camera orientation is a default, with a user
       override for camera/layout settings. Native rotation APIs are not called. */
    switch (out->rotation_degrees) {
        case 90: { double old = x; x = z; z = -old; break; }
        case 180: x = -x; z = -z; break;
        case 270: { double old = x; x = -z; z = old; break; }
    }
    double u = .5 + x / settings->values[LV_MAP_SPAN];
    double v = .5 - z / settings->values[LV_MAP_SPAN];
    if (!out->manual_projection) {
        u = .5 + x * g->scale_x / (2 * g->half_width);
        v = .5 - z * g->scale_z / (2 * g->half_height);
    }
    /* Native WorldToMiniMap has an edge-clamp branch. Permit only a small
       border overshoot (spawn points); never pin an off-board 500,500 sentinel. */
    if (!isfinite(u) || !isfinite(v) || u < -.04 || u > 1.04 || v < -.04 || v > 1.04) return -1;
    unsigned clamped = u < 0 || u > 1 || v < 0 || v > 1;
    u = fmax(0,fmin(1,u)); v = fmax(0,fmin(1,v));
    if (out->count >= LV_TARGET_MAX_ACTORS) return 0;
    out->markers[out->count++] = (LVMinimapMarker){ .object_id = a->object_id, .resource_id = a->resource_id,
        .ordinal = ordinal, .is_local = a->is_local, .is_ward = !a->is_hero && a->is_ward,
        .u = u, .v = v, .edge_clamped = clamped,
        .position_source = a->logic_position_ok ? 2 : 1,
        .health_fraction_ok = a->native_health_fraction_ok || a->minimap_health_fraction_ok,
        .health_source = a->native_health_fraction_ok ? 1 : (a->minimap_health_fraction_ok ? 2 : 0),
        .health_fraction = (double)(a->native_health_fraction_ok ? a->native_health_fraction_fixed :
                                   a->minimap_health_fraction_fixed) / 16384.0 };
    if (clamped && !a->is_local && a->is_hero) ++out->edge_clamped_enemies;
    return 1;
}
void lv_minimap_frame(const LVTargetSnapshot *s, const LVMinimapGeometry *g,
                      const LVMinimapSettings *settings, LVMinimapFrame *out) {
    lv_minimap_frame_with_wards(s,g,settings,0,out);
}
void lv_minimap_frame_with_wards(const LVTargetSnapshot *s, const LVMinimapGeometry *g,
                                const LVMinimapSettings *settings, unsigned draw_wards, LVMinimapFrame *out) {
    if (!out) return;
    memset(out, 0, sizeof(*out)); out->reason = "snapshot_unavailable";
    if (!s || s->count > LV_TARGET_MAX_ACTORS || (s->result != LV_TARGET_READY && s->result != LV_TARGET_PARTIAL)) return;
    if (!settings_valid(settings)) { out->reason = "settings_invalid"; return; }
    size_t local = SIZE_MAX;
    for (size_t i = 0; i < s->count; ++i) if (s->actors[i].is_local) {
        if (local != SIZE_MAX) { out->reason = "local_ambiguous"; return; }
        local = i;
    }
    if (local == SIZE_MAX || !s->actors[local].values_ok || !s->actors[local].object_id_ok ||
        !s->actors[local].object_id || duplicate_id(s, local) ||
        (s->actors[local].camp != 1 && s->actors[local].camp != 2)) { out->reason = "local_unavailable"; return; }
    out->local_camp = s->actors[local].camp;
    out->rotation_degrees = settings->values[LV_MAP_ROTATION] == -1 ?
        (out->local_camp == 2 ? 180 : 0) : (int)settings->values[LV_MAP_ROTATION];
    out->manual_projection = settings->values[LV_MAP_MANUAL] != 0;
    size_t enemies[LV_TARGET_MAX_ACTORS], n = 0;
    for (size_t i = 0; i < s->count; ++i) {
        const LVTargetActor *a = &s->actors[i];
        if (!a->values_ok || !a->classification_ok || !a->is_hero || a->is_local ||
            a->camp != (out->local_camp ^ 3) || !a->object_id_ok || !a->object_id) continue;
        if (duplicate_id(s, i)) { ++out->duplicate_ids; continue; }
        enemies[n++] = i;
    }
    out->confirmed_enemies = n;
    /* Stable numbers while the same roster remains present, even when dead
       or missing a coordinate. Never fabricate five entries. */
    for (size_t i = 1; i < n; ++i) {
        size_t item = enemies[i], j = i;
        while (j && s->actors[enemies[j-1]].object_id > s->actors[item].object_id) { enemies[j] = enemies[j-1]; --j; }
        enemies[j] = item;
    }
    if (!g || (!out->manual_projection && !g->ready) || g->full_map_showing || g->viewport_mode ||
        (g->reason && !strcmp(g->reason, "expanded_or_viewport_map"))) {
        out->reason = g ? g->reason : "geometry_unavailable"; return;
    }
    out->ready = 1; out->reason = "ready";
    if (settings->values[LV_MAP_LOCAL_POINT]) add_marker(out, &s->actors[local], 0, g, settings);
    for (size_t i = 0; i < n; ++i) {
        const LVTargetActor *a = &s->actors[enemies[i]];
        if (a->health_ok && a->health_fixed <= 0) { ++out->dead_enemies; continue; }
        int result = add_marker(out, a, (unsigned)i + 1, g, settings);
        if (!result) ++out->missing_enemies;
        else if (result < 0) ++out->outside_enemies;
    }
    if(draw_wards) for(size_t i=0;i<s->count;++i) {
        const LVTargetActor *a=&s->actors[i];
        if(!a->values_ok || !a->classification_ok || !a->ward_classification_ok || !a->is_ward ||
            a->is_hero || a->is_local || a->camp!=(out->local_camp^3) || !a->object_id_ok ||
            !a->object_id || duplicate_id(s,i)) continue;
        ++out->confirmed_wards;
        /* A ward with unknown life state is not an established active ward.
           Destroyed/unreadable/out-of-map wards never keep an old marker. */
        if(!a->health_ok) { ++out->unavailable_wards; continue; }
        if(a->health_fixed<=0) { ++out->dead_wards; continue; }
        int result=add_marker(out,a,0,g,settings);
        if(result>0) ++out->ward_markers;
        else if(result<0) ++out->outside_wards;
        else ++out->unavailable_wards;
    }
}
