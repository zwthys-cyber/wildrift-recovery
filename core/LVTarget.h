#ifndef LV_TARGET_H
#define LV_TARGET_H
#include <stddef.h>
#include <stdint.h>

#define LV_TARGET_UUID "085E1DDF-4A8D-34E2-9D73-A0A28BCC0B83"
#define LV_TARGET_MAX_ACTORS 512
#define LV_TARGET_MAX_SKILLS 128

/* Caller must verify the loaded framework UUID before using this profile. */
typedef int (*LVTargetRead)(void *context, uint64_t address, void *buffer, size_t length);
typedef enum {
    LV_TARGET_READY, LV_TARGET_NOT_IN_BATTLE, LV_TARGET_UNREADABLE,
    LV_TARGET_LAYOUT_MISMATCH, LV_TARGET_CHANGED, LV_TARGET_LIMIT,
    LV_TARGET_PARTIAL
} LVTargetResult;
typedef struct {
    uint64_t visual, managed, native, attribute, transform;
    uint32_t object_id;
    int32_t resource_id, tid, camp;
    int64_t health_fixed, position_fixed[3];
    unsigned values_ok, health_ok, is_local;
    unsigned object_id_ok, position_ok;
    unsigned classification_ok, is_hero, is_monster, is_soldier, is_building, is_red_blue_buff;
} LVTargetActor;
typedef struct {
    uint64_t native, cd_node;
    uint32_t object_id, resource_id;
    int32_t level;
    int64_t cooldown_fixed;
    unsigned values_ok, cooldown_ok, cd_locked;
    uint64_t stock_manager, slot;
    int32_t stock_current, stock_maximum;
    uint32_t slot_state, cast_state;
    unsigned stock_ok, slot_state_ok, cast_state_ok;
} LVTargetSkill;
typedef struct {
    LVTargetResult result;
    const char *stage;
    uint64_t header, begin, end;
    int32_t stride;
    size_t reported_count, count, skipped;
    LVTargetSkill skills[LV_TARGET_MAX_SKILLS];
} LVTargetSkillList;
typedef struct {
    LVTargetResult result;
    const char *stage;
    uint64_t manager, summoner_manager;
    LVTargetSkillList all, summoner;
} LVTargetSkills;
typedef struct {
    LVTargetResult result;
    const char *stage;
    uint64_t class_cache, drive_class, drive_statics, drive, manager, list, items;
    uint64_t local_native;
    int32_t reported_count;
    size_t count, skipped;
    LVTargetActor actors[LV_TARGET_MAX_ACTORS];
    LVTargetSkills local_skills;
} LVTargetSnapshot;

LVTargetResult lv_target_snapshot(LVTargetRead read, void *context, uint64_t image_base,
                                  LVTargetSnapshot *output);
const char *lv_target_result_name(LVTargetResult result);
#endif
