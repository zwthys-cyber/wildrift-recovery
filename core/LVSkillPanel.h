#ifndef LV_SKILL_PANEL_H
#define LV_SKILL_PANEL_H
#include "LVTarget.h"
#define LV_PANEL_MAX_HEROES 16
#define LV_PANEL_MAX_SKILLS 16

typedef struct {
    uint32_t object_id, resource_id;
    uint64_t native, slot, cd_node;
    int32_t slot_index, level;
    int64_t cooldown_fixed;
    unsigned summoner, cooldown_ok, locked, ambiguous;
} LVPanelSkill;
typedef struct {
    uint32_t object_id;
    int32_t resource_id;
    LVTargetResult result;
    const char *reason;
    size_t count, unavailable;
    unsigned truncated;
    LVPanelSkill skills[LV_PANEL_MAX_SKILLS];
} LVPanelHero;
typedef struct {
    unsigned enabled, truncated;
    LVTargetResult result;
    const char *reason;
    size_t count;
    LVPanelHero heroes[LV_PANEL_MAX_HEROES];
} LVSkillPanel;
/* UUID-gated caller supplies the current actor snapshot. No game calls or
   writes, no persistent cooldown state, no inferred readiness. */
void lv_skill_panel_read(LVTargetRead, void *, const LVTargetSnapshot *, unsigned enabled, LVSkillPanel *);
#endif
