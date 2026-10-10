#include "LVActions.h"
#include <limits.h>
#include <math.h>
#include <string.h>

static int64_t nearest_pixel(float v) {
    if (v >= (float)INT64_MAX) return INT64_MAX;
    return (int64_t)floor((double)v + 0.5);
}

static int64_t after_ns(int64_t now, int64_t delay) {
    return now > INT64_MAX - delay ? INT64_MAX : now + delay;
}

int lv_mercury_decide(const LVMercuryInput *in, const LVActionActor *actors, size_t count,
                     LVMercuryState *state, LVTouchDecision *out) {
    if (out) memset(out, 0, sizeof(*out));
    if (!in || !state || !out || !actors || !in->enabled || !in->touch_available) return 0;
    size_t index = 0;
    for (; index < count; ++index)
        if (actors[index].id >= 0 && actors[index].is_local && actors[index].health > 0) break;
    if (index == count) return 0;
    const LVActionActor *actor = &actors[index];
    if ((actor->control != 1 && actor->control != 2) || !actor->item_available || actor->item_id != 2297) return 0;
    if (state->pending) {
        if (!(actor->cooldown > 0) && state->next_allowed_ns > in->now_ns) return 0;
        state->pending = 0;
    }
    if (actor->cooldown > 0 || state->next_allowed_ns > in->now_ns) return 0;
    // Exact float32 constants in the original: 0x3f47ae14 and 0x3f5c28f6.
    float x = isfinite(in->touch_x) && in->touch_x > 0 ? in->touch_x : in->width * 0.78f;
    float y = isfinite(in->touch_y) && in->touch_y > 0 ? in->touch_y : in->height * 0.86f;
    if (!isfinite(x) || !isfinite(y) || !(in->width > 0) || !(in->height > 0)) return 0;
    x = fminf(in->width, fmaxf(0, x));
    y = fminf(in->height, fmaxf(0, y));
    out->x = nearest_pixel(x);
    out->y = nearest_pixel(y);
    out->press_microseconds = 5000;
    out->actor_index = index;
    state->next_allowed_ns = after_ns(in->now_ns, 250000000);
    state->pending = 1;
    return 1;
}

int lv_smite_damage_from_rank(int rank) {
    return rank >= 1 && rank <= 3 ? 600 + (rank - 1) * 400 : 0;
}

int lv_smite_type_enabled(int32_t type, int red, int blue, int dragon) {
    switch (type) {
        case 201401: case 830001: case 830002: return !!red;
        case 201402: case 830101: case 830102: return !!blue;
        case 201104: case 201105: case 201201: case 201202:
        case 202902: case 203001: case 260101:
        case 830701: case 830702: case 830704: case 830705: case 830721:
            return !!dragon;
        default: return 0;
    }
}

int lv_smite_decide(const LVSmiteInput *in, const LVSmiteActor *actors, size_t count,
                    const LVSmiteTarget *targets, size_t target_count,
                    LVSmiteState *state, LVSmiteDecision *out) {
    if (out) memset(out, 0, sizeof(*out));
    if (!in || !actors || !state || !out || !in->enabled || !in->touch_available ||
        in->now_ns < state->next_allowed_ns) return 0;
    size_t self = 0;
    for (; self < count; ++self)
        // Original B.HI also admits unordered (NaN), unlike Mercury's B.GT.
        if (actors[self].id >= 0 && actors[self].is_local && !(actors[self].health <= 0)) break;
    if (self == count) return 0;
    const LVSmiteActor *local = &actors[self];
    if (!local->smite_available || local->smite_id != 81110101) return 0;
    if (in->require_enemy) {
        if ((local->camp != 1 && local->camp != 2) || (local->x == 0 && local->y == 0)) return 0;
        size_t i = 0;
        for (; i < count; ++i) {
            const LVSmiteActor *enemy = &actors[i];
            if (enemy->id < 0 || enemy->is_local || (enemy->camp ^ local->camp) != 3 ||
                !(enemy->health > 0) || (enemy->x == 0 && enemy->y == 0)) continue;
            float distance = hypotf(enemy->x - local->x, enemy->y - local->y);
            if (isfinite(distance) && distance <= (float)in->range) break;
        }
        if (i == count) return 0;
    }
    if (!in->skill_read_ok || in->skill_id != 81110101 ||
        in->skill_cooldown > 0.05f) return 0;
    if (in->now_ns >= state->next_damage_refresh_ns) {
        state->cached_damage = lv_smite_damage_from_rank(in->damage_rank);
        state->next_damage_refresh_ns = after_ns(in->now_ns, 200000000);
    }
    int32_t threshold = state->cached_damage > 0 ? state->cached_damage : in->fallback_damage;
    if (!targets) return 0;
    size_t chosen = 0;
    int64_t health = 0;
    for (; chosen < target_count; ++chosen) {
        const LVSmiteTarget *target = &targets[chosen];
        if (target->id < 0 || !target->valid ||
            !lv_smite_type_enabled(target->type_id, in->red_enabled, in->blue_enabled, in->dragon_enabled)) continue;
        float distance = hypotf(target->x - local->x, target->y - local->y);
        if (!isfinite(distance) || distance > (float)in->range || !target->health_read_ok) continue;
        health = target->health_fixed / 16384;
        if (target->health_fixed >= 16384 && health <= threshold) break;
    }
    if (chosen == target_count) return 0;
    float x = isfinite(in->touch_x) && in->touch_x > 0 ? in->touch_x : in->width * 0.86f;
    float y = isfinite(in->touch_y) && in->touch_y > 0 ? in->touch_y : in->height * 0.86f;
    if (!isfinite(x) || !isfinite(y) || !(in->width > 0) || !(in->height > 0)) return 0;
    x = fminf(in->width, fmaxf(0, x));
    y = fminf(in->height, fmaxf(0, y));
    out->touch.x = nearest_pixel(x);
    out->touch.y = nearest_pixel(y);
    out->touch.press_microseconds = 5000;
    out->touch.actor_index = chosen; // Index into targets, unlike Mercury's actor index.
    out->type_id = targets[chosen].type_id;
    out->threshold = threshold;
    out->health = health;
    state->next_allowed_ns = after_ns(in->now_ns, 100000000);
    return 1;
}
