#ifndef LV_SKILL_PANEL_H
#define LV_SKILL_PANEL_H
#include "LVTarget.h"
#define LV_PANEL_MAX_HEROES 16
#define LV_PANEL_MAX_SKILLS 16

typedef enum {
    LV_PANEL_UNKNOWN, LV_PANEL_REGULAR, LV_PANEL_ULTIMATE, LV_PANEL_SUMMONER
} LVPanelRole;
typedef struct {
    uint32_t object_id, resource_id;
    uint64_t native, slot, cd_node;
    int32_t slot_index, level;
    int64_t cooldown_fixed, total_fixed, start_fixed, cd1_fixed, cd2_fixed;
    unsigned node_values_ok, configured_cd_ok;
    uint64_t logic_native, logic_cd_node;
    int64_t logic_remain_raw, logic_total_raw, logic_start_raw;
    unsigned logic_cooldown_ok, logic_node_values_ok;
    const char *logic_cooldown_reason;
    unsigned summoner, cooldown_ok, locked, ambiguous;
    LVPanelRole role;
    int32_t configured_index;
} LVPanelSkill;
typedef struct {
    uint32_t object_id;
    int32_t resource_id;
    LVTargetResult result;
    const char *reason;
    size_t count, unavailable;
    unsigned classification_ok;
    uint32_t ultimate_resource_id;
    unsigned truncated;
    LVPanelSkill skills[LV_PANEL_MAX_SKILLS];
} LVPanelHero;
typedef struct {
    unsigned enabled, truncated;
    LVTargetResult result;
    const char *reason, *classification_reason;
    size_t count;
    LVPanelHero heroes[LV_PANEL_MAX_HEROES];
} LVSkillPanel;
/* UUID-gated caller supplies the current actor snapshot. No game calls or
   writes, no persistent cooldown state, no inferred readiness. */
void lv_skill_panel_read(LVTargetRead, void *, const LVTargetSnapshot *, unsigned enabled, LVSkillPanel *);
/* Uses the engine's actual sync/native selector and the named GetRSkill path.
   Classification failure preserves raw slot/cooldown data as unknown. */
void lv_skill_panel_classify(LVTargetRead, void *, uint64_t engine_base, const char *engine_uuid,
                            const LVTargetSnapshot *, LVSkillPanel *);
void lv_skill_panel_native_cooldowns(LVTargetRead, void *, uint64_t engine_base, const char *engine_uuid,
                                    const LVTargetSnapshot *, LVSkillPanel *);
int lv_skill_panel_skill_visible(const LVPanelSkill *, unsigned hide_small_skills);
const char *lv_skill_panel_role_name(LVPanelRole);
#endif
