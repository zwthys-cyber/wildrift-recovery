#ifndef LV_ACTIONS_H
#define LV_ACTIONS_H
#include <stddef.h>
#include <stdint.h>

// Normalized data, not the game's or the Android binary's memory layout.
typedef struct {
    int32_t id;
    int is_local;
    float health;
    int32_t control;
    int item_available;
    int32_t item_id;
    float cooldown;
} LVActionActor;
typedef struct {
    int enabled, touch_available;
    float width, height, touch_x, touch_y;
    int64_t now_ns;
} LVMercuryInput;
typedef struct { int64_t next_allowed_ns; int pending; } LVMercuryState;
typedef struct { int64_t x, y; uint32_t press_microseconds; size_t actor_index; } LVTouchDecision;

// Reconstructed from Android 0x41a25c. Performs no I/O or touch injection.
// On an emitted decision, state assumes the consumer accepts that decision.
int lv_mercury_decide(const LVMercuryInput *, const LVActionActor *, size_t,
                     LVMercuryState *, LVTouchDecision *);

typedef struct {
    int32_t id;
    int is_local;
    float health, x, y;
    int32_t camp;
    int smite_available;
    int32_t smite_id;
} LVSmiteActor;
typedef struct {
    int32_t id, type_id;
    int valid;
    float x, y;
    int health_read_ok;
    int64_t health_fixed;
} LVSmiteTarget;
typedef struct {
    int enabled, touch_available, require_enemy;
    int red_enabled, blue_enabled, dragon_enabled;
    int32_t range, fallback_damage;
    float width, height, touch_x, touch_y;
    int64_t now_ns;
    // Results supplied by a reader. The Android pointer chains are not portable.
    int skill_read_ok;
    int32_t skill_id;
    float skill_cooldown;
    int damage_rank;
} LVSmiteInput;
typedef struct {
    int64_t next_allowed_ns, next_damage_refresh_ns;
    int32_t cached_damage;
} LVSmiteState;
typedef struct {
    LVTouchDecision touch;
    int32_t type_id, threshold;
    int64_t health;
} LVSmiteDecision;

// Reconstructed Android outer decision at 0x419710 and classification at
// 0x439998. Readers supply normalized snapshots; no memory or touch I/O.
int lv_smite_damage_from_rank(int rank);
int lv_smite_type_enabled(int32_t type_id, int red, int blue, int dragon);
int lv_smite_decide(const LVSmiteInput *, const LVSmiteActor *, size_t,
                    const LVSmiteTarget *, size_t, LVSmiteState *, LVSmiteDecision *);
#endif
