#ifndef LV_SMITE_PREVIEW_H
#define LV_SMITE_PREVIEW_H
#include "LVTarget.h"
#include "LVConfig.h"

/* An isolated, read-only application of recovered Android rules. Coordinates
   use raw X/Z Fix64 integers, converted to float for the original rule core.
   Cross-platform distance scale and actual skill castability remain unverified. */
typedef enum {
    LV_PREVIEW_DISABLED = 1u << 0,
    LV_PREVIEW_SNAPSHOT = 1u << 1,
    LV_PREVIEW_LOCAL = 1u << 2,
    LV_PREVIEW_SKILL_LIST = 1u << 3,
    LV_PREVIEW_NO_SMITE = 1u << 4,
    LV_PREVIEW_AMBIGUOUS_SMITE = 1u << 5,
    LV_PREVIEW_COOLDOWN_UNREADABLE = 1u << 6,
    LV_PREVIEW_COOLDOWN_LOCKED = 1u << 7,
    LV_PREVIEW_COOLDOWN_ACTIVE = 1u << 8,
    LV_PREVIEW_CASTING = 1u << 9,
    LV_PREVIEW_STOCK_EMPTY = 1u << 10,
    LV_PREVIEW_ENEMY_REQUIRED = 1u << 11,
    LV_PREVIEW_NO_ELIGIBLE_TARGET = 1u << 12,
    LV_PREVIEW_RULE_REJECTED = 1u << 13,
    LV_PREVIEW_LOCAL_AMBIGUOUS = 1u << 14
} LVPreviewBlock;
typedef enum {
    LV_CANDIDATE_ELIGIBLE, LV_CANDIDATE_CATEGORY_DISABLED,
    LV_CANDIDATE_CLASS_UNKNOWN, LV_CANDIDATE_NOT_MONSTER,
    LV_CANDIDATE_VALUES_UNKNOWN, LV_CANDIDATE_OUTSIDE_RANGE,
    LV_CANDIDATE_HEALTH_UNKNOWN, LV_CANDIDATE_HEALTH_TOO_LOW,
    LV_CANDIDATE_ABOVE_THRESHOLD, LV_CANDIDATE_LOCAL_UNKNOWN
} LVPreviewCandidateStatus;
typedef struct {
    size_t actor_index;
    LVPreviewCandidateStatus status;
    double distance_world_xz;
    unsigned distance_ok;
} LVPreviewCandidate;
typedef struct {
    unsigned blockers;
    int enabled, require_enemy, red_enabled, blue_enabled, dragon_enabled;
    int range_fixed, fallback_threshold, threshold, threshold_from_level;
    unsigned local_ok, smite_found, would_trigger;
    size_t local_index, skill_index, enemy_count, unknown_enemy_count;
    size_t candidate_count, eligible_count, chosen_actor_index;
    LVPreviewCandidate candidates[LV_TARGET_MAX_ACTORS];
} LVSmitePreview;

/* Config must come from lv_config_defaults/parse/set (or be NULL for defaults).
   No task port, clock, touch output, or persistent action state is used. */
void lv_smite_preview(const LVTargetSnapshot *, const LVConfig *, LVSmitePreview *);
const char *lv_smite_preview_block_name(unsigned single_bit);
const char *lv_smite_candidate_status_name(LVPreviewCandidateStatus);
#endif
