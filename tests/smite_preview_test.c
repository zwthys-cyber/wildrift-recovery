#include "LVSmitePreview.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>

static void set(LVConfig *c, const char *key, const char *value) {
    int i = lv_config_index(key); assert(i >= 0 && !lv_config_set(c, (size_t)i, value, NULL));
}
static void fixture(LVTargetSnapshot *s, LVConfig *c) {
    memset(s, 0, sizeof(*s)); lv_config_defaults(c); set(c, "autoSmite", "1");
    s->result = LV_TARGET_READY; s->count = 3;
    for (size_t i = 0; i < 3; ++i) {
        LVTargetActor *a = &s->actors[i];
        a->object_id = (uint32_t)i + 1; a->values_ok = a->health_ok = a->position_ok = a->object_id_ok = a->classification_ok = 1;
        a->health_fixed = 600 * INT64_C(16384); a->position_fixed[0] = (2 + (int)i) * INT64_C(16384);
    }
    s->actors[0].is_local = s->actors[0].is_hero = 1; s->actors[0].camp = 1; s->actors[0].resource_id = 10094;
    s->actors[1].is_hero = 1; s->actors[1].camp = 2; s->actors[1].resource_id = 10063;
    s->actors[2].is_monster = 1; s->actors[2].camp = 4; s->actors[2].resource_id = 830001;
    s->local_skills.result = s->local_skills.summoner.result = LV_TARGET_READY;
    s->local_skills.summoner.count = 1;
    s->local_skills.summoner.skills[0] = (LVTargetSkill){ .resource_id = 81110101, .level = 1,
        .values_ok = 1, .cooldown_ok = 1, .cd_node = 0x350000000,
        .stock_ok = 1, .stock_current = 1, .stock_maximum = 2, .cast_state_ok = 1 };
}
int main(void) {
    LVTargetSnapshot s; LVConfig c; LVSmitePreview p;
    fixture(&s, &c); lv_smite_preview(&s, &c, &p);
    assert(p.would_trigger && !p.blockers && p.chosen_actor_index == 2 && p.threshold == 600);
    assert(p.candidate_count == 1 && p.eligible_count == 1 && p.enemy_count == 1);
    assert(p.candidates[0].distance_world_xz == 2.0);
    fixture(&s, &c); set(&c, "autoSmite", "0"); lv_smite_preview(&s, &c, &p);
    assert(!p.would_trigger && (p.blockers & LV_PREVIEW_DISABLED) && p.eligible_count == 1);
    fixture(&s, &c); s.actors[1].is_hero = 0; s.actors[1].is_soldier = 1; lv_smite_preview(&s, &c, &p);
    assert(!p.would_trigger && (p.blockers & LV_PREVIEW_ENEMY_REQUIRED));
    fixture(&s, &c); s.actors[1].classification_ok = 0; lv_smite_preview(&s, &c, &p);
    assert(!p.would_trigger && p.unknown_enemy_count == 1);
    fixture(&s, &c); s.actors[1].is_hero = 0; set(&c, "smiteRequireEnemy", "0"); lv_smite_preview(&s, &c, &p);
    assert(p.would_trigger && !p.enemy_count);
    fixture(&s, &c); s.actors[2].resource_id = 831001; lv_smite_preview(&s, &c, &p);
    assert(!p.would_trigger && !p.candidate_count);
    fixture(&s, &c); s.actors[2].classification_ok = 0; lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_CLASS_UNKNOWN && !p.would_trigger);
    fixture(&s, &c); s.actors[2].is_monster = 0; lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_NOT_MONSTER);
    fixture(&s, &c); s.actors[2].position_fixed[0] = 100 * INT64_C(16384); lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_OUTSIDE_RANGE);
    fixture(&s, &c); s.actors[2].position_fixed[2] = 100 * INT64_C(16384); lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_OUTSIDE_RANGE);
    fixture(&s, &c); s.actors[2].health_fixed = 601 * INT64_C(16384); lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_ABOVE_THRESHOLD);
    fixture(&s, &c); s.actors[2].health_fixed = 600 * INT64_C(16384) + 16383; lv_smite_preview(&s, &c, &p);
    assert(p.would_trigger); /* Original rule truncates health toward zero. */
    fixture(&s, &c); s.actors[2].health_fixed = 0; lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_HEALTH_TOO_LOW);
    fixture(&s, &c); s.actors[2].health_ok = 0; lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_HEALTH_UNKNOWN);
    fixture(&s, &c); s.actors[2].object_id = UINT32_MAX; lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_VALUES_UNKNOWN && !p.would_trigger);
    fixture(&s, &c); s.actors[0].object_id = UINT32_MAX; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_LOCAL);
    fixture(&s, &c); s.local_skills.summoner.skills[0].cooldown_ok = 0; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_COOLDOWN_UNREADABLE);
    fixture(&s, &c); s.local_skills.summoner.skills[0].cd_node = 0; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_COOLDOWN_UNREADABLE);
    fixture(&s, &c); s.local_skills.summoner.skills[0].cd_locked = 1; lv_smite_preview(&s, &c, &p);
    assert(!p.would_trigger && (p.blockers & LV_PREVIEW_COOLDOWN_LOCKED));
    fixture(&s, &c); s.local_skills.summoner.skills[0].cooldown_fixed = 819; lv_smite_preview(&s, &c, &p);
    assert(p.would_trigger); /* 819/16384 < .05 */
    fixture(&s, &c); s.local_skills.summoner.skills[0].cooldown_fixed = 820; lv_smite_preview(&s, &c, &p);
    assert(!p.would_trigger && (p.blockers & LV_PREVIEW_COOLDOWN_ACTIVE));
    fixture(&s, &c); s.local_skills.summoner.skills[0].cast_state = 0x40; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_CASTING);
    fixture(&s, &c); s.local_skills.summoner.skills[0].stock_current = 0; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_STOCK_EMPTY);
    fixture(&s, &c); s.local_skills.summoner.skills[0].level = 2; s.actors[2].health_fixed = 999 * INT64_C(16384);
    lv_smite_preview(&s, &c, &p); assert(p.would_trigger && p.threshold == 1000 && p.threshold_from_level);
    fixture(&s, &c); s.local_skills.summoner.skills[0].level = 0; lv_smite_preview(&s, &c, &p);
    assert(p.threshold == 1000 && !p.threshold_from_level);
    fixture(&s, &c); s.local_skills.summoner.skills[0].resource_id = 81090101; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_NO_SMITE);
    fixture(&s, &c); s.local_skills.summoner.skills[0].resource_id = 81100101; lv_smite_preview(&s, &c, &p);
    assert(p.would_trigger && !(p.blockers & LV_PREVIEW_NO_SMITE)); /* International 2813 smite id. */
    fixture(&s, &c); s.local_skills.summoner.count = 2;
    s.local_skills.summoner.skills[1] = s.local_skills.summoner.skills[0]; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_AMBIGUOUS_SMITE);
    fixture(&s, &c); s.local_skills.summoner.result = LV_TARGET_PARTIAL; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_SKILL_LIST);
    fixture(&s, &c); set(&c, "smiteRedBuff", "0"); lv_smite_preview(&s, &c, &p);
    assert(p.candidates[0].status == LV_CANDIDATE_CATEGORY_DISABLED);
    fixture(&s, &c); s.result = LV_TARGET_CHANGED; lv_smite_preview(&s, &c, &p);
    assert((p.blockers & LV_PREVIEW_SNAPSHOT) && !p.candidate_count);
    fixture(&s, &c); s.actors[1].is_local = 1; lv_smite_preview(&s, &c, &p);
    assert((p.blockers & LV_PREVIEW_LOCAL_AMBIGUOUS) && !p.would_trigger);
    fixture(&s, &c); s.count = LV_TARGET_MAX_ACTORS + 1; lv_smite_preview(&s, &c, &p);
    assert(p.blockers & LV_PREVIEW_SNAPSHOT);
    lv_smite_preview(NULL, NULL, &p); assert(p.blockers & LV_PREVIEW_SNAPSHOT);
    lv_smite_preview(&s, &c, NULL);
    puts("smite preview: 34 scenarios passed"); return 0;
}
