#ifndef LV_TARGET_H
#define LV_TARGET_H
#include <stddef.h>
#include <stdint.h>

#define LV_TARGET_UUID "085E1DDF-4A8D-34E2-9D73-A0A28BCC0B83"
#define LV_NATIVE_ENGINE_UUID "D5B32037-47A3-3EFF-B0E5-04B071EFBEE3"
#define LV_TARGET_MAX_ACTORS 512
#define LV_TARGET_MAX_SKILLS 128

/* Caller must verify the loaded framework UUID before using this profile. */
typedef int (*LVTargetRead)(void *context, uint64_t address, void *buffer, size_t length);
typedef enum {
    LV_TARGET_READY, LV_TARGET_NOT_IN_BATTLE, LV_TARGET_UNREADABLE,
    LV_TARGET_LAYOUT_MISMATCH, LV_TARGET_CHANGED, LV_TARGET_LIMIT,
    LV_TARGET_PARTIAL
} LVTargetResult;
typedef enum {
    LV_HEALTH_UNAVAILABLE, LV_HEALTH_READY, LV_HEALTH_UNREADABLE,
    LV_HEALTH_INVALID, LV_HEALTH_CHANGED, LV_HEALTH_INELIGIBLE
} LVNativeHealthStatus;
typedef enum {
    LV_LOGIC_UNAVAILABLE, LV_LOGIC_READY, LV_LOGIC_NOT_FOUND,
    LV_LOGIC_UNREADABLE, LV_LOGIC_INVALID, LV_LOGIC_CHANGED, LV_LOGIC_INELIGIBLE
} LVLogicPositionStatus;
typedef struct {
    uint64_t visual, managed, native, attribute, transform;
    uint32_t object_id;
    int32_t resource_id, tid, camp;
    int64_t health_fixed, position_fixed[3];
    unsigned values_ok, health_ok, is_local;
    unsigned object_id_ok, position_ok;
    unsigned classification_ok, is_hero, is_monster, is_soldier, is_building, is_red_blue_buff;
    unsigned ward_classification_ok, is_ward;
    /* Original minimap UI cache, independently validated; not a max-HP guess. */
    int64_t minimap_health_fraction_fixed;
    unsigned minimap_health_fraction_ok;
    /* Independently sampled current/max attribute values, not the UI cache. */
    int64_t native_current_health_fixed, native_max_health_fixed, native_health_fraction_fixed;
    unsigned native_health_fraction_ok;
    LVNativeHealthStatus native_health_status;
    /* Diagnostic alternatives only; their freshness is not established. */
    int64_t attribute_last_position[3], host_position[3];
    float sync_logic_position[3], sync_logic_time;
    uint32_t host_object_id;
    int32_t host_resource_id, host_camp;
    uint64_t visual_tick;
    unsigned attribute_last_position_ok, host_position_ok, sync_logic_position_ok, visual_state_ok, should_be_visible;
    int64_t fow_force_position[3];
    unsigned fow_force_position_ok, fog_cut_state_ok, fog_cut_disappear;
    /* Independent native logic object; never a reinterpretation of native. */
    uint64_t logic_native, logic_transform;
    int64_t logic_position_fixed[3];
    unsigned logic_position_ok;
    LVLogicPositionStatus logic_position_status;
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
typedef struct {
    const char *reason;
    unsigned profile_matches, sync_values;
    unsigned fog_config_ok, use_logic_network, logic_thread_enabled, fog_cut_enabled;
    size_t eligible, valid, unreadable, invalid, changed;
} LVNativeHealthReport;
typedef struct {
    const char *reason;
    unsigned profile_matches;
    uint64_t desk, frame_root, frame_battle, battle, manager, tree, manager_vtable, lookup_method;
    uint64_t manager_vtable_offset, lookup_method_offset;
    size_t eligible, valid, not_found, unreadable, invalid, changed;
    size_t eligible_wards, valid_wards;
} LVLogicPositionReport;

/* Caller has verified the Unity UUID. FEProj UUID is independently checked.
   Reads current logic transforms only; no calls, writes or historical cache. */
void lv_target_logic_position_read(LVTargetRead read, void *context, uint64_t engine_base,
                                  const char *engine_uuid, LVTargetSnapshot *snapshot,
                                  LVLogicPositionReport *report);
const char *lv_logic_position_status_name(LVLogicPositionStatus status);

/* Unity profile must already match. The FEProj UUID is checked here as well. */
void lv_target_native_health_read(LVTargetRead read, void *context, uint64_t engine_base,
                                 const char *engine_uuid, LVTargetSnapshot *snapshot,
                                 LVNativeHealthReport *report);
const char *lv_native_health_status_name(LVNativeHealthStatus status);

LVTargetResult lv_target_snapshot(LVTargetRead read, void *context, uint64_t image_base,
                                  LVTargetSnapshot *output);
const char *lv_target_result_name(LVTargetResult result);
#endif
