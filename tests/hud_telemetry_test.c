#include "LVHUDTelemetry.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>

/* A fixed protocol record, independently specified rather than produced by the
   encoder under test. Fields use numeric values observed in device reports,
   but this is not captured device telemetry. */
static const uint64_t golden[LV_HUD_METRIC_WORDS] = {
    UINT64_C(0x000000020000039d), 24, 12, 100000,
    UINT64_C(0x0003002f00000300), 147130,
    UINT64_C(0x0000000100000002), UINT64_C(0x0003000500040001)
};
static unsigned cases;
static void check(int condition) { assert(condition); ++cases; }
static void rejected(const uint64_t *words, uint32_t pid, uint64_t now) {
    LVHUDMetrics m; memset(&m, 0xff, sizeof(m));
    check(!lv_hud_metrics_decode(words, pid, now, &m));
    LVHUDMetrics empty = {0}; check(!memcmp(&m, &empty, sizeof(m)));
}
int main(void) {
    LVHUDMetrics m; uint64_t words[LV_HUD_METRIC_WORDS];
    check(lv_hud_metrics_decode(golden, 925, 100500, &m));
    check(m.frames == 12 && m.actor_count == 47 && m.skipped_count == 0);
    check(m.fresh && m.snapshot_usable && m.age_seconds == .5);
    check(m.cooldown_ok && m.cooldown_fixed == 147130 && m.stock_ok && m.stock_current == 1 && m.stock_maximum == 2 && m.orientation == 3);
    check(m.enemy_count == 5 && m.enemy_markers == 4 && m.enemy_unplaced == 1 && m.map_projection_ok && m.minimap_enabled && !m.map_manual);
    check(lv_hud_metrics_encode(&m, words) && !memcmp(golden, words, sizeof(words)));
    check(lv_hud_metrics_decode(golden, 925, 103000, &m) && m.fresh);
    check(lv_hud_metrics_decode(golden, 925, 103001, &m) && !m.fresh && m.snapshot_usable);
    rejected(golden, 926, 100500); rejected(golden, 0, 100500);
    rejected(golden, 925, 99999); rejected(NULL, 925, 100500);
    const struct { unsigned field; uint64_t value; } invalid[] = {
        {LV_HUD_OWNER, UINT64_C(0x000000030000039d)}, /* unknown protocol */
        {LV_HUD_OWNER, UINT64_C(0x000000010000039d)}, /* older protocol */
        {LV_HUD_OWNER, UINT64_C(0x0000000280000000)}, /* invalid process ID */
        {LV_HUD_SEQUENCE, 23}, /* incomplete writer */
        {LV_HUD_SEQUENCE, 0}, /* never sampled */
        {LV_HUD_FRAMES, 13}, /* counts changed during publication */
        {LV_HUD_FRAMES, UINT64_MAX}, /* sequence multiplication overflow */
        {LV_HUD_TIME, 0},
        {LV_HUD_DATA, UINT64_C(0x0003020100000300)}, /* 513 actors */
        {LV_HUD_DATA, UINT64_C(0x0003010001010300)}, /* total > 512 */
        {LV_HUD_DATA, UINT64_C(0xff03002f00000300)}, /* unknown result */
        {LV_HUD_DATA, UINT64_C(0x0007002f00000300)}, /* unknown flags */
        {LV_HUD_DATA, UINT64_C(0x0003002f00000500)}, /* invalid orientation */
        {LV_HUD_DATA, UINT64_C(0x0003002f00000301)}, /* nonzero reserved byte */
        {LV_HUD_DATA, UINT64_C(0x0002002f00000300)}, /* stale unread cooldown */
        {LV_HUD_DATA, UINT64_C(0x0001002f00000300)}, /* stale unread inventory */
        {LV_HUD_DATA, UINT64_C(0x0503002f00000300)}, /* failure with old skill data */
        {LV_HUD_COOLDOWN, UINT64_MAX}, /* negative signed value */
        {LV_HUD_RESERVED, UINT64_C(0x0103000500040001)}, /* reserved byte */
        {LV_HUD_RESERVED, UINT64_C(0x0008000500040001)}, /* unknown map flags */
        {LV_HUD_RESERVED, UINT64_C(0x0001000500040001)}, /* markers without projection */
        {LV_HUD_RESERVED, UINT64_C(0x0003003000040001)}, /* more heroes than actors */
        {LV_HUD_RESERVED, UINT64_C(0x0003000500060000)}, /* more markers than heroes */
        {LV_HUD_RESERVED, UINT64_C(0x0003000500040002)}, /* missing plus drawn > heroes */
        {LV_HUD_RESERVED, UINT64_C(0x00030005ffff0000)}
    };
    for (size_t i = 0; i < sizeof(invalid) / sizeof(invalid[0]); ++i) {
        memcpy(words, golden, sizeof(words)); words[invalid[i].field] = invalid[i].value;
        rejected(words, 925, 100500);
    }
    memcpy(words, golden, sizeof(words));
    words[LV_HUD_DATA] = UINT64_C(0x0500000000000300);
    words[LV_HUD_COOLDOWN] = words[LV_HUD_STOCK] = 0;
    rejected(words, 925, 100500); /* failed sample cannot keep enemy data */
    words[LV_HUD_RESERVED] = UINT64_C(0x0002000000000000);
    rejected(words, 925, 100500); /* even empty map projection must clear */
    words[LV_HUD_RESERVED] = 0;
    check(lv_hud_metrics_decode(words, 925, 100500, &m) && m.fresh && !m.snapshot_usable);
    check(!m.cooldown_ok && !m.stock_ok && m.actor_count == 0);
    memcpy(words, golden, sizeof(words)); words[LV_HUD_STOCK] = UINT64_C(0xffffffff00000002);
    check(lv_hud_metrics_decode(words, 925, 100500, &m) && m.stock_current == -1);
    check(lv_hud_metrics_encode(&m, words));
    m.owner_pid = 0; check(!lv_hud_metrics_encode(&m, words));
    check(!words[LV_HUD_OWNER] && !words[LV_HUD_SEQUENCE]);
    check(!lv_hud_metrics_decode(golden, 925, 100500, NULL));
    check(lv_hud_result_from_name(NULL) == LV_HUD_UNKNOWN);
    check(lv_hud_result_from_name("changed") == LV_HUD_CHANGED);
    check(!strcmp(lv_hud_result_name(LV_HUD_PARTIAL), "partial"));
    printf("HUD telemetry: %u checks passed\n", cases);
    return 0;
}
