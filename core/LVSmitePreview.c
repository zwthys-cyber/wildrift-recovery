#include "LVSmitePreview.h"
#include "LVActions.h"
#include <limits.h>
#include <math.h>
#include <string.h>

static float config_value(const LVConfig *c, const char *key) {
    int i = lv_config_index(key);
    return i >= 0 ? c->values[i][0] : 0;
}
static int actor_values(const LVTargetActor *a) {
    /* The original normalized model uses signed IDs. Never wrap uint32 into
       that model, or fill failed reads with apparently valid zeros. */
    return a->values_ok && a->health_ok && a->position_ok && a->object_id_ok &&
           a->object_id <= INT32_MAX;
}
static float raw_x(const LVTargetActor *a) { return (float)a->position_fixed[0]; }
static float raw_z(const LVTargetActor *a) { return (float)a->position_fixed[2]; }
static float distance_fixed(const LVTargetActor *a, const LVTargetActor *b) {
    return hypotf(raw_x(a) - raw_x(b), raw_z(a) - raw_z(b));
}

void lv_smite_preview(const LVTargetSnapshot *s, const LVConfig *config, LVSmitePreview *out) {
    if (!out) return;
    memset(out, 0, sizeof(*out));
    out->local_index = out->skill_index = out->chosen_actor_index = SIZE_MAX;
    LVConfig defaults;
    if (!config) { lv_config_defaults(&defaults); config = &defaults; }
    out->enabled = config_value(config, "autoSmite") != 0;
    out->require_enemy = config_value(config, "smiteRequireEnemy") != 0;
    out->red_enabled = config_value(config, "smiteRedBuff") != 0;
    out->blue_enabled = config_value(config, "smiteBlueBuff") != 0;
    out->dragon_enabled = config_value(config, "smiteDragon") != 0;
    out->range_fixed = (int)config_value(config, "smiteRange");
    out->fallback_threshold = (int)config_value(config, "smiteHealthThreshold");
    out->threshold = out->fallback_threshold;
    if (!out->enabled) out->blockers |= LV_PREVIEW_DISABLED;
    if (!s || (s->result != LV_TARGET_READY && s->result != LV_TARGET_PARTIAL) ||
        s->count > LV_TARGET_MAX_ACTORS || s->local_skills.summoner.count > LV_TARGET_MAX_SKILLS) {
        out->blockers |= LV_PREVIEW_SNAPSHOT; return;
    }
    size_t local_count = 0;
    for (size_t i = 0; i < s->count; ++i) if (s->actors[i].is_local) {
        out->local_index = i; ++local_count;
    }
    const LVTargetActor *local = local_count == 1 ? &s->actors[out->local_index] : NULL;
    if (local_count > 1) out->blockers |= LV_PREVIEW_LOCAL_AMBIGUOUS;
    out->local_ok = local && actor_values(local) && local->health_fixed > 0;
    if (!out->local_ok) out->blockers |= LV_PREVIEW_LOCAL;
    const LVTargetSkillList *list = &s->local_skills.summoner;
    if (s->local_skills.result != LV_TARGET_READY && s->local_skills.result != LV_TARGET_PARTIAL)
        out->blockers |= LV_PREVIEW_SKILL_LIST;
    if (list->result != LV_TARGET_READY) out->blockers |= LV_PREVIEW_SKILL_LIST;
    size_t smites = 0;
    for (size_t i = 0; i < list->count; ++i)
        if (list->skills[i].values_ok && list->skills[i].resource_id == 81110101) {
            out->skill_index = i; ++smites;
        }
    const LVTargetSkill *skill = smites == 1 ? &list->skills[out->skill_index] : NULL;
    out->smite_found = skill != NULL;
    if (!smites) out->blockers |= LV_PREVIEW_NO_SMITE;
    if (smites > 1) out->blockers |= LV_PREVIEW_AMBIGUOUS_SMITE;
    if (skill) {
        int damage = lv_smite_damage_from_rank(skill->level);
        if (damage) { out->threshold = damage; out->threshold_from_level = 1; }
        if (!skill->cooldown_ok || !skill->cd_node) out->blockers |= LV_PREVIEW_COOLDOWN_UNREADABLE;
        else {
            if (skill->cd_locked) out->blockers |= LV_PREVIEW_COOLDOWN_LOCKED;
            if ((double)skill->cooldown_fixed / 16384.0 > 0.05) out->blockers |= LV_PREVIEW_COOLDOWN_ACTIVE;
        }
        /* IsCasting 0x514a348: (currentState & 0x50) == 0x40.
           Absence of this condition does not prove castability. */
        if (skill->cast_state_ok && (skill->cast_state & 0x50) == 0x40) out->blockers |= LV_PREVIEW_CASTING;
        if (skill->stock_ok && skill->stock_maximum > 0 && skill->stock_current <= 0)
            out->blockers |= LV_PREVIEW_STOCK_EMPTY;
    }
    LVSmiteActor heroes[LV_TARGET_MAX_ACTORS]; size_t hero_count = 0;
    LVSmiteTarget targets[LV_TARGET_MAX_ACTORS]; size_t target_count = 0;
    size_t target_actors[LV_TARGET_MAX_ACTORS];
    memset(heroes, 0, sizeof(heroes)); memset(targets, 0, sizeof(targets));
    if (out->local_ok) {
        heroes[hero_count++] = (LVSmiteActor){ .id = (int32_t)local->object_id, .is_local = 1,
            .health = (float)((double)local->health_fixed / 16384.0),
            .x = raw_x(local), .y = raw_z(local), .camp = local->camp,
            .smite_available = skill != NULL, .smite_id = skill ? (int32_t)skill->resource_id : 0 };
    }
    for (size_t i = 0; i < s->count; ++i) {
        const LVTargetActor *a = &s->actors[i];
        if (!a->is_local && out->local_ok && a->values_ok && (local->camp == 1 || local->camp == 2) &&
            (a->camp ^ local->camp) == 3 &&
            (!a->classification_ok || (a->is_hero && !actor_values(a)))) ++out->unknown_enemy_count;
        if (!a->is_local && a->classification_ok && a->is_hero && actor_values(a) && out->local_ok) {
            LVSmiteActor h = { .id = (int32_t)a->object_id,
                .health = (float)((double)a->health_fixed / 16384.0), .x = raw_x(a), .y = raw_z(a), .camp = a->camp };
            heroes[hero_count++] = h;
            float d = distance_fixed(a, local);
            if ((local->camp == 1 || local->camp == 2) && (a->camp ^ local->camp) == 3 &&
                a->health_fixed > 0 && (h.x != 0 || h.y != 0) &&
                (raw_x(local) != 0 || raw_z(local) != 0) && isfinite(d) && d <= out->range_fixed)
                ++out->enemy_count;
        }
        if (!a->values_ok || !lv_smite_type_enabled(a->resource_id, 1, 1, 1)) continue;
        LVPreviewCandidate *c = &out->candidates[out->candidate_count++]; c->actor_index = i;
        if (out->local_ok && a->position_ok) {
            float d = distance_fixed(a, local); c->distance_ok = isfinite(d);
            c->distance_world_xz = (double)d / 16384.0;
        }
        if (!lv_smite_type_enabled(a->resource_id, out->red_enabled, out->blue_enabled, out->dragon_enabled))
            c->status = LV_CANDIDATE_CATEGORY_DISABLED;
        else if (!a->classification_ok) c->status = LV_CANDIDATE_CLASS_UNKNOWN;
        else if (!a->is_monster) c->status = LV_CANDIDATE_NOT_MONSTER;
        else if (!a->position_ok || !a->object_id_ok || a->object_id > INT32_MAX || a->is_local)
            c->status = LV_CANDIDATE_VALUES_UNKNOWN;
        else if (!out->local_ok) c->status = LV_CANDIDATE_LOCAL_UNKNOWN;
        else if (!c->distance_ok || c->distance_world_xz > (double)out->range_fixed / 16384.0)
            c->status = LV_CANDIDATE_OUTSIDE_RANGE;
        else if (!a->health_ok) c->status = LV_CANDIDATE_HEALTH_UNKNOWN;
        else if (a->health_fixed < 16384) c->status = LV_CANDIDATE_HEALTH_TOO_LOW;
        else if (a->health_fixed / 16384 > out->threshold) c->status = LV_CANDIDATE_ABOVE_THRESHOLD;
        else {
            c->status = LV_CANDIDATE_ELIGIBLE; ++out->eligible_count;
            target_actors[target_count] = i;
            targets[target_count++] = (LVSmiteTarget){ .id = (int32_t)a->object_id, .type_id = a->resource_id,
                .valid = 1, .x = raw_x(a), .y = raw_z(a), .health_read_ok = 1, .health_fixed = a->health_fixed };
        }
    }
    if (out->require_enemy && !out->enemy_count) out->blockers |= LV_PREVIEW_ENEMY_REQUIRED;
    if (!out->eligible_count) out->blockers |= LV_PREVIEW_NO_ELIGIBLE_TARGET;
    if (out->blockers) return;
    LVSmiteInput in = { .enabled = 1, .touch_available = 1, .require_enemy = out->require_enemy,
        .red_enabled = out->red_enabled, .blue_enabled = out->blue_enabled, .dragon_enabled = out->dragon_enabled,
        .range = out->range_fixed, .fallback_damage = out->fallback_threshold, .width = 1, .height = 1,
        .skill_read_ok = 1, .skill_id = 81110101, .skill_cooldown = (float)((double)skill->cooldown_fixed / 16384.0),
        .damage_rank = skill->level };
    LVSmiteState state = {0}; LVSmiteDecision decision;
    /* A synthetic unit canvas enables the pure decision function. Its touch
       coordinates are discarded; they never reach an input backend. */
    if (lv_smite_decide(&in, heroes, hero_count, targets, target_count, &state, &decision)) {
        out->would_trigger = 1; out->chosen_actor_index = target_actors[decision.touch.actor_index];
    } else out->blockers |= LV_PREVIEW_RULE_REJECTED;
}

const char *lv_smite_preview_block_name(unsigned bit) {
    switch (bit) {
        case LV_PREVIEW_DISABLED: return "setting_disabled";
        case LV_PREVIEW_SNAPSHOT: return "snapshot_unusable";
        case LV_PREVIEW_LOCAL: return "local_actor_unusable";
        case LV_PREVIEW_LOCAL_AMBIGUOUS: return "local_actor_ambiguous";
        case LV_PREVIEW_SKILL_LIST: return "skill_list_incomplete";
        case LV_PREVIEW_NO_SMITE: return "smite_not_found";
        case LV_PREVIEW_AMBIGUOUS_SMITE: return "smite_ambiguous";
        case LV_PREVIEW_COOLDOWN_UNREADABLE: return "cooldown_unavailable";
        case LV_PREVIEW_COOLDOWN_LOCKED: return "cooldown_locked";
        case LV_PREVIEW_COOLDOWN_ACTIVE: return "cooldown_active";
        case LV_PREVIEW_CASTING: return "skill_casting";
        case LV_PREVIEW_STOCK_EMPTY: return "stock_empty";
        case LV_PREVIEW_ENEMY_REQUIRED: return "nearby_enemy_hero_not_confirmed";
        case LV_PREVIEW_NO_ELIGIBLE_TARGET: return "no_eligible_target";
        case LV_PREVIEW_RULE_REJECTED: return "original_rule_rejected";
    }
    return "unknown";
}
const char *lv_smite_candidate_status_name(LVPreviewCandidateStatus status) {
    switch (status) {
        case LV_CANDIDATE_ELIGIBLE: return "eligible";
        case LV_CANDIDATE_CATEGORY_DISABLED: return "category_disabled";
        case LV_CANDIDATE_CLASS_UNKNOWN: return "classification_unavailable";
        case LV_CANDIDATE_NOT_MONSTER: return "not_monster";
        case LV_CANDIDATE_VALUES_UNKNOWN: return "actor_values_unavailable";
        case LV_CANDIDATE_OUTSIDE_RANGE: return "outside_range";
        case LV_CANDIDATE_HEALTH_UNKNOWN: return "health_unavailable";
        case LV_CANDIDATE_HEALTH_TOO_LOW: return "health_below_one";
        case LV_CANDIDATE_ABOVE_THRESHOLD: return "above_threshold";
        case LV_CANDIDATE_LOCAL_UNKNOWN: return "local_actor_unavailable";
    }
    return "unknown";
}
