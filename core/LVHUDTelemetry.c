#include "LVHUDTelemetry.h"
#include <limits.h>
#include <string.h>

static const char *const results[] = {
    "ready", "partial", "not_in_battle", "unreadable", "layout_mismatch",
    "changed", "limit", "uuid_mismatch", "framework_not_found",
    "invalid_image_address", "unknown"
};
const char *lv_hud_result_name(LVHUDResult result) {
    return result >= LV_HUD_READY && result <= LV_HUD_UNKNOWN ? results[result] : "unknown";
}
LVHUDResult lv_hud_result_from_name(const char *name) {
    if (name && !strcmp(name, "changed_during_read")) return LV_HUD_CHANGED;
    if (name && !strcmp(name, "actor_limit")) return LV_HUD_LIMIT;
    if (name) for (size_t i = 0; i < sizeof(results) / sizeof(results[0]); ++i)
        if (!strcmp(name, results[i])) return (LVHUDResult)i;
    return LV_HUD_UNKNOWN;
}
static int bounded(const LVHUDMetrics *m) {
    return m && m->owner_pid > 0 && m->owner_pid <= INT32_MAX &&
        m->frames > 0 && m->frames <= UINT64_MAX / 2 && m->completed_at_ms > 0 &&
        m->result >= LV_HUD_READY && m->result <= LV_HUD_UNKNOWN &&
        (unsigned)m->actor_count + m->skipped_count <= 512 && m->orientation <= 4 &&
        m->cooldown_ok <= 1 && m->stock_ok <= 1 && m->cooldown_fixed >= 0 &&
        m->enemy_count <= m->actor_count && (unsigned)m->enemy_markers + m->enemy_unplaced <= m->enemy_count &&
        m->displayed_markers<=m->enemy_markers && m->health_ring_markers<=m->displayed_markers &&
        m->edge_clamped_markers<=m->displayed_markers &&
        m->minimap_enabled <= 1 && m->map_projection_ok <= 1 && m->map_manual <= 1 &&
        (m->map_projection_ok || !m->enemy_markers) &&
        (m->result <= LV_HUD_PARTIAL || (!m->cooldown_ok && !m->stock_ok &&
            !m->enemy_count && !m->map_projection_ok && !m->map_manual));
}
int lv_hud_metrics_encode(const LVHUDMetrics *m, uint64_t words[LV_HUD_METRIC_WORDS]) {
    if (!words) return 0;
    memset(words, 0, sizeof(uint64_t) * LV_HUD_METRIC_WORDS);
    if (!bounded(m)) return 0;
    words[LV_HUD_OWNER] = ((uint64_t)LV_HUD_METRIC_VERSION << 32) | m->owner_pid;
    words[LV_HUD_SEQUENCE] = m->frames * 2;
    words[LV_HUD_FRAMES] = m->frames;
    words[LV_HUD_TIME] = m->completed_at_ms;
    words[LV_HUD_DATA] = ((uint64_t)m->result << 56) |
        ((uint64_t)(m->cooldown_ok | (m->stock_ok << 1)) << 48) |
        ((uint64_t)m->actor_count << 32) | ((uint64_t)m->skipped_count << 16) |
        ((uint64_t)m->orientation << 8);
    if (m->cooldown_ok) words[LV_HUD_COOLDOWN] = (uint64_t)m->cooldown_fixed;
    if (m->stock_ok) words[LV_HUD_STOCK] = ((uint64_t)(uint32_t)m->stock_current << 32) | (uint32_t)m->stock_maximum;
    /* Word 7 was reserved in protocol 1. Protocol 2 adds only aggregate map
       counts; no enemy positions or target addresses travel through notify. */
    words[LV_HUD_RESERVED] = ((uint64_t)(m->minimap_enabled | (m->map_projection_ok << 1) | (m->map_manual << 2)) << 48) |
        ((uint64_t)m->enemy_count << 32) | ((uint64_t)m->enemy_markers << 16) | m->enemy_unplaced;
    /* Protocol 3 adds aggregate current ring/clamp counts only. */
    words[LV_HUD_MAPDETAIL] = ((uint64_t)m->displayed_markers<<32) |
        ((uint64_t)m->health_ring_markers<<16) | m->edge_clamped_markers;
    return 1;
}
int lv_hud_metrics_decode(const uint64_t words[LV_HUD_METRIC_WORDS],
                          uint32_t expected_pid, uint64_t now_ms, LVHUDMetrics *out) {
    if (!out) return 0;
    memset(out, 0, sizeof(*out));
    if (!words || !expected_pid || (words[LV_HUD_OWNER] >> 32) != LV_HUD_METRIC_VERSION ||
        (uint32_t)words[LV_HUD_OWNER] != expected_pid || !words[LV_HUD_SEQUENCE] ||
        (words[LV_HUD_SEQUENCE] & 1) || (words[LV_HUD_RESERVED] >> 56)) return 0;
    LVHUDMetrics m = {0};
    m.owner_pid = expected_pid; m.frames = words[LV_HUD_FRAMES];
    m.completed_at_ms = words[LV_HUD_TIME];
    uint64_t data = words[LV_HUD_DATA];
    m.result = (LVHUDResult)(data >> 56);
    unsigned flags = (unsigned)((data >> 48) & 255);
    m.actor_count = (uint16_t)(data >> 32); m.skipped_count = (uint16_t)(data >> 16);
    m.orientation = (unsigned)((data >> 8) & 255);
    m.cooldown_ok = flags & 1; m.stock_ok = (flags >> 1) & 1;
    if (words[LV_HUD_COOLDOWN] > INT64_MAX) return 0;
    m.cooldown_fixed = (int64_t)words[LV_HUD_COOLDOWN];
    uint32_t current = (uint32_t)(words[LV_HUD_STOCK] >> 32), maximum = (uint32_t)words[LV_HUD_STOCK];
    memcpy(&m.stock_current, &current, sizeof(current)); memcpy(&m.stock_maximum, &maximum, sizeof(maximum));
    uint64_t map = words[LV_HUD_RESERVED]; unsigned map_flags = (unsigned)(map >> 48);
    m.enemy_count = (uint16_t)(map >> 32); m.enemy_markers = (uint16_t)(map >> 16); m.enemy_unplaced = (uint16_t)map;
    m.minimap_enabled = map_flags & 1; m.map_projection_ok = (map_flags >> 1) & 1; m.map_manual = (map_flags >> 2) & 1;
    uint64_t detail=words[LV_HUD_MAPDETAIL];
    if(detail>>48) return 0;
    m.displayed_markers=(uint16_t)(detail>>32);
    m.health_ring_markers=(uint16_t)(detail>>16); m.edge_clamped_markers=(uint16_t)detail;
    if (!bounded(&m) || flags > 3 || map_flags > 7 || (data & 255) || m.completed_at_ms > now_ms ||
        words[LV_HUD_SEQUENCE] != m.frames * 2 ||
        (!m.cooldown_ok && words[LV_HUD_COOLDOWN]) || (!m.stock_ok && words[LV_HUD_STOCK])) return 0;
    m.age_seconds = (double)(now_ms - m.completed_at_ms) / 1000.0;
    m.fresh = now_ms - m.completed_at_ms <= 3000;
    m.snapshot_usable = m.result == LV_HUD_READY || m.result == LV_HUD_PARTIAL;
    *out = m; return 1;
}
