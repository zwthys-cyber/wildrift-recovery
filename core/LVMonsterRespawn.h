#ifndef LV_MONSTER_RESPAWN_H
#define LV_MONSTER_RESPAWN_H
#include "LVTarget.h"
#define LV_RESPAWN_MAX_TIMERS 64
#define LV_RESPAWN_MAX_OBSERVATIONS 16
typedef struct {
    uint32_t anchor_id;
    const char *reason;
    int32_t active, showing, recycled, state, anchor_type, poi_type;
    unsigned flags_ok, state_ok, timer_ok;
    int64_t remaining_fixed;
} LVMonsterRespawnObservation;
typedef struct {
    uint32_t anchor_id;
    int32_t poi_type;
    int64_t remaining_fixed, position_fixed[3];
} LVMonsterRespawnTimer;
typedef struct {
    const char *reason;
    unsigned enabled, class_root_fallbacks;
    size_t count, examined, unavailable, duplicates;
    size_t not_counting, excluded, observation_count;
    unsigned observations_truncated;
    LVMonsterRespawnObservation observations[LV_RESPAWN_MAX_OBSERVATIONS];
    LVMonsterRespawnTimer timers[LV_RESPAWN_MAX_TIMERS];
} LVMonsterRespawnReport;
/* Current game-owned monster anchor timers only. No wall clock, death-history
   inference, game calls or writes. UUID and usable battle snapshot required. */
void lv_monster_respawn_read(LVTargetRead,void *,uint64_t,const char *,
                            const LVTargetSnapshot *,unsigned,LVMonsterRespawnReport *);
#endif
