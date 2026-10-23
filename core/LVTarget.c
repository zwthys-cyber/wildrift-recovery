#include "LVTarget.h"
#include <string.h>
#include <math.h>

typedef struct { LVTargetRead read; void *context; } Reader;
static int address_valid(uint64_t a, size_t n) {
    return a >= 0x10000 && a < (UINT64_C(1) << 48) && n &&
           n <= 1024 * 1024 && n <= (UINT64_C(1) << 48) - a;
}
static int load(Reader *r, uint64_t a, void *out, size_t n) {
    memset(out, 0, n);
    if (!address_valid(a, n) || !r->read(r->context, a, out, n)) {
        memset(out, 0, n); return 0;
    }
    return 1;
}
static int pointer(Reader *r, uint64_t a, uint64_t *out) {
    if (!load(r, a, out, 8)) return 0;
    if (*out && (!address_valid(*out, 8) || (*out & 7))) { *out = 0; return 0; }
    return 1;
}
static int equals(Reader *r, uint64_t a, const char *s) {
    char text[96]; size_t n = strlen(s) + 1;
    return n <= sizeof(text) && load(r, a, text, n) && !memcmp(text, s, n);
}
static int class_matches(Reader *r, uint64_t cls, const char *name) {
    uint64_t np, sp;
    return load(r, cls + 0x10, &np, 8) && load(r, cls + 0x18, &sp, 8) &&
           equals(r, np, name) && equals(r, sp, "FrameEngine.Visual");
}
static void position_candidates(Reader *r,LVTargetActor *a) {
    if(!a->values_ok || !a->classification_ok ||
       !(a->is_hero || (a->ward_classification_ok && a->is_ward))) return;
    /* ActorComponentAttribute.get_lastPosition 0x4ea11d8 copies +90..a0.
       A last-position field is diagnostic evidence, never a live fallback. */
    if(a->attribute) a->attribute_last_position_ok=load(r,a->attribute+0x90,a->attribute_last_position,24);
    uint8_t visible;
    if(load(r,a->visual+0x120,&visible,1) && visible<=1 && load(r,a->visual+0xb8,&a->visual_tick,8)) {
        a->visual_state_ok=1; a->should_be_visible=visible;
    }
    uint8_t cut;
    if(load(r,a->visual+0xb0,&cut,1) && cut<=1) { a->fog_cut_state_ok=1; a->fog_cut_disappear=cut; }
    /* get_fow 0x4ee62f0; get_forcePosition 0x4eab868. The sync Fow getter
       0x1030e4c verifies owner +18. A forced position may be stale or invalid;
       collect it for diagnosis, never substitute it for the live transform. */
    uint64_t fow,owner,same_fow;
    if(pointer(r,a->native+0x120,&fow) && fow && pointer(r,fow+0x18,&owner) && owner==a->native &&
        load(r,fow+0x28,a->fow_force_position,24) && pointer(r,a->native+0x120,&same_fow) && same_fow==fow &&
        pointer(r,fow+0x18,&owner) && owner==a->native) a->fow_force_position_ok=1;
    uint64_t sync, back_visual, back_actor, same_sync;
    if(pointer(r,a->visual+0xf0,&sync) && sync && pointer(r,sync+0x18,&back_visual) && back_visual==a->visual &&
        pointer(r,sync+0x20,&back_actor) && back_actor==a->managed &&
        load(r,sync+0x2c,a->sync_logic_position,12) && load(r,sync+0x50,&a->sync_logic_time,4) &&
        pointer(r,a->visual+0xf0,&same_sync) && same_sync==sync) {
        a->sync_logic_position_ok=isfinite(a->sync_logic_time) && a->sync_logic_time>=0;
        for(size_t j=0;j<3;++j) if(!isfinite(a->sync_logic_position[j]) || fabsf(a->sync_logic_position[j])>10000)
            a->sync_logic_position_ok=0;
    }
    /* get_host 0x4ee65ac -> native +148; hostVisiPos follows host.actorVisi.
       The host may be a different actor. Export identity alongside position. */
    uint64_t host, transform, same_host;
    if(pointer(r,a->native+0x148,&host) && host && load(r,host+0x18,&a->host_object_id,4) &&
        load(r,host+0x2c,&a->host_resource_id,4) && load(r,host+0x80,&a->host_camp,4) &&
        pointer(r,host+0x20,&transform) && transform && load(r,transform+0x18,a->host_position,24) &&
        pointer(r,a->native+0x148,&same_host) && same_host==host) a->host_position_ok=1;
}
static LVTargetResult finish(LVTargetSnapshot *o, LVTargetResult result, const char *stage) {
    o->result = result; o->stage = stage; return result;
}
static void discard_values(LVTargetSnapshot *o, LVTargetResult result, const char *stage) {
    o->count = 0; memset(o->actors, 0, sizeof(o->actors));
    memset(&o->local_skills, 0, sizeof(o->local_skills));
    o->local_skills.result = o->local_skills.all.result = o->local_skills.summoner.result = result;
    o->local_skills.stage = o->local_skills.all.stage = o->local_skills.summoner.stage = stage;
}

static void skill_list_finish(LVTargetSkillList *list, LVTargetResult result, const char *stage) {
    list->result = result; list->stage = stage;
}
static void skill_list(Reader *r, uint64_t header, LVTargetSkillList *list) {
    list->header = header;
    if (!pointer(r, header, &list->begin) || !pointer(r, header + 8, &list->end) ||
        !load(r, header + 0x18, &list->stride, 4)) {
        skill_list_finish(list, LV_TARGET_UNREADABLE, "vector_header"); return;
    }
    /* DataShellList<T>::get_list embeds the native vector at +0x10.
       GetSkillAt 0x4ebd8a0 and GetSkill 0x515df2c read begin/end and stride. */
    if (list->end < list->begin || (list->begin != list->end && list->stride != 8) ||
        (list->begin == list->end && list->stride != 0 && list->stride != 8) ||
        (list->end - list->begin) % 8) {
        skill_list_finish(list, LV_TARGET_LAYOUT_MISMATCH, "vector_layout"); return;
    }
    list->reported_count = (size_t)((list->end - list->begin) / 8);
    if (list->reported_count > LV_TARGET_MAX_SKILLS) {
        skill_list_finish(list, LV_TARGET_LIMIT, "skill_count"); return;
    }
    uint64_t entries[LV_TARGET_MAX_SKILLS] = {0}, after[LV_TARGET_MAX_SKILLS] = {0};
    if (list->reported_count && !load(r, list->begin, entries, list->reported_count * 8)) {
        skill_list_finish(list, LV_TARGET_UNREADABLE, "skill_items"); return;
    }
    unsigned partial = 0;
    for (size_t i = 0; i < list->reported_count; ++i) {
        LVTargetSkill s = {0}; s.native = entries[i];
        if (!address_valid(s.native, 8) || (s.native & 7)) { ++list->skipped; partial = 1; continue; }
        /* ActorSkill.get_objId/get_level/get_resId, 0x4ecc0ec/1a4/1c8. */
        s.values_ok = load(r, s.native + 0x20, &s.object_id, 4) &&
                      load(r, s.native + 0x38, &s.level, 4) &&
                      load(r, s.native + 0x44, &s.resource_id, 4);
        /* ActorSkill.get_cdLeftTime 0x4ed1f94: embedded CDTrigger +0x420,
           cdNode pointer +0x20. Null/locked nodes return Zero, else max(remainTime, Zero).
           This getter alone does not establish that the skill can be used. */
        if (pointer(r, s.native + 0x440, &s.cd_node)) {
            uint8_t locked = 0;
            if (!s.cd_node) s.cooldown_ok = 1;
            else if (load(r, s.cd_node + 0x18, &locked, 1)) {
                s.cd_locked = locked != 0;
                s.cooldown_ok = s.cd_locked || load(r, s.cd_node + 0x20, &s.cooldown_fixed, 8);
            }
            if (s.cooldown_ok && s.cooldown_fixed < 0) s.cooldown_fixed = 0;
        }
        /* Managed getter instructions, not managed field offsets:
           get_stockMgr 0x4ecc580 -> native +0x1d0 pointer;
           get__slot 0x4ecc39c -> native +0x108 pointer;
           get_skillStateMgr 0x4ecc894 -> native +0x498 embedded object. */
        if (pointer(r, s.native + 0x1d0, &s.stock_manager) && s.stock_manager) {
            s.stock_ok = load(r, s.stock_manager + 0x1c, &s.stock_current, 4) &&
                         load(r, s.stock_manager + 0x20, &s.stock_maximum, 4);
            uint64_t stock_after = 0;
            if (!pointer(r, s.native + 0x1d0, &stock_after) || stock_after != s.stock_manager)
                s.stock_ok = 0;
            if (!s.stock_ok) s.stock_current = s.stock_maximum = 0;
        }
        if (pointer(r, s.native + 0x108, &s.slot) && s.slot) {
            s.slot_state_ok = load(r, s.slot + 0x18, &s.slot_state, 4);
            uint64_t slot_after = 0;
            if (!pointer(r, s.native + 0x108, &slot_after) || slot_after != s.slot)
                s.slot_state_ok = 0;
            if (!s.slot_state_ok) s.slot_state = 0;
        }
        s.cast_state_ok = load(r, s.native + 0x4b0, &s.cast_state, 4);
        uint32_t id_after = 0, res_after = 0; uint64_t node_after = 0;
        if (!s.values_ok || !load(r, s.native + 0x20, &id_after, 4) ||
            !load(r, s.native + 0x44, &res_after, 4) ||
            id_after != s.object_id || res_after != s.resource_id) {
            s.values_ok = s.cooldown_ok = 0;
            s.object_id = s.resource_id = 0; s.level = 0; s.cooldown_fixed = 0;
            s.stock_ok = s.slot_state_ok = s.cast_state_ok = 0;
            s.stock_current = s.stock_maximum = 0; s.slot_state = s.cast_state = 0;
        } else if (!pointer(r, s.native + 0x440, &node_after) || node_after != s.cd_node) {
            s.cooldown_ok = 0; s.cooldown_fixed = 0;
        }
        if (!s.values_ok || !s.cooldown_ok) partial = 1;
        list->skills[list->count++] = s;
    }
    uint64_t begin_after = 0, end_after = 0; int32_t stride_after = 0;
    if (!pointer(r, header, &begin_after) || !pointer(r, header + 8, &end_after) ||
        !load(r, header + 0x18, &stride_after, 4)) {
        list->count = 0; memset(list->skills, 0, sizeof(list->skills));
        skill_list_finish(list, LV_TARGET_UNREADABLE, "vector_consistency_read"); return;
    }
    if (begin_after != list->begin || end_after != list->end || stride_after != list->stride) {
        list->count = 0; memset(list->skills, 0, sizeof(list->skills));
        skill_list_finish(list, LV_TARGET_CHANGED, "skill_list_changed"); return;
    }
    if (list->reported_count && !load(r, list->begin, after, list->reported_count * 8)) {
        list->count = 0; memset(list->skills, 0, sizeof(list->skills));
        skill_list_finish(list, LV_TARGET_UNREADABLE, "skill_items_consistency_read"); return;
    }
    if (memcmp(entries, after, list->reported_count * 8)) {
        list->count = 0; memset(list->skills, 0, sizeof(list->skills));
        skill_list_finish(list, LV_TARGET_CHANGED, "skill_items_changed"); return;
    }
    skill_list_finish(list, partial ? LV_TARGET_PARTIAL : LV_TARGET_READY, "skill_values");
}
static void local_skills(Reader *r, uint64_t actor, LVTargetSkills *s) {
    s->result = LV_TARGET_UNREADABLE; s->stage = "skill_manager";
    s->all.result = s->summoner.result = LV_TARGET_UNREADABLE;
    s->all.stage = s->summoner.stage = "not_sampled";
    if (!actor || !pointer(r, actor + 0xd0, &s->manager) || !s->manager) return;
    skill_list(r, s->manager + 0x218, &s->all);
    /* get_summonerSkillMgr 0x4eba794; get_skills 0x515d554. */
    if (pointer(r, s->manager + 0x140, &s->summoner_manager) && s->summoner_manager)
        skill_list(r, s->summoner_manager + 0x28, &s->summoner);
    uint64_t manager_after = 0, summoner_after = 0;
    int consistent_read = pointer(r, actor + 0xd0, &manager_after) &&
                          pointer(r, s->manager + 0x140, &summoner_after);
    if (!consistent_read || manager_after != s->manager || summoner_after != s->summoner_manager) {
        memset(s->all.skills, 0, sizeof(s->all.skills)); memset(s->summoner.skills, 0, sizeof(s->summoner.skills));
        s->all.count = s->summoner.count = 0;
        s->all.result = s->summoner.result = s->result = consistent_read ? LV_TARGET_CHANGED : LV_TARGET_UNREADABLE;
        s->all.stage = s->summoner.stage = s->stage = consistent_read ? "skill_manager_changed" : "skill_manager_consistency_read"; return;
    }
    s->result = s->all.result == LV_TARGET_READY && s->summoner.result == LV_TARGET_READY
        ? LV_TARGET_READY : LV_TARGET_PARTIAL;
    s->stage = "local_skill_values";
}

LVTargetResult lv_target_snapshot(LVTargetRead read, void *context, uint64_t base,
                                  LVTargetSnapshot *o) {
    if (!o) return LV_TARGET_UNREADABLE;
    memset(o, 0, sizeof(*o));
    o->local_skills.result = LV_TARGET_UNREADABLE; o->local_skills.stage = "not_sampled";
    o->local_skills.all.result = o->local_skills.summoner.result = LV_TARGET_UNREADABLE;
    o->local_skills.all.stage = o->local_skills.summoner.stage = "not_sampled";
    Reader r = {read, context};
    if (!read || !address_valid(base, 8) || base > (UINT64_C(1) << 48) - (LV_TARGET_CLASS_CACHE_OFFSET+8))
        return finish(o, LV_TARGET_UNREADABLE, "image_base");
    /* GlobalMetadata::GetTypeInfoFromTypeDefinitionIndex, 0x2cc42e8. */
    if (!pointer(&r, base + LV_TARGET_CLASS_CACHE_OFFSET, &o->class_cache) || !o->class_cache)
        return finish(o, LV_TARGET_UNREADABLE, "class_cache");
    if (!pointer(&r, o->class_cache + LV_TYPE_DRIVE_ENTRY_UNITY * 8ULL, &o->drive_class))
        return finish(o, LV_TARGET_UNREADABLE, "drive_class");
    if (!o->drive_class) return finish(o, LV_TARGET_NOT_IN_BATTLE, "drive_class_uninitialized");
    if (!class_matches(&r, o->drive_class, "DriveEntryUnity"))
        return finish(o, LV_TARGET_LAYOUT_MISMATCH, "drive_class_name");
    if (!pointer(&r, o->drive_class + 0xb8, &o->drive_statics) || !o->drive_statics ||
        !pointer(&r, o->drive_statics, &o->drive))
        return finish(o, LV_TARGET_UNREADABLE, "drive_statics");
    if (!o->drive) return finish(o, LV_TARGET_NOT_IN_BATTLE, "drive_instance_null");
    if (!pointer(&r, o->drive + 0x10, &o->manager) || !o->manager ||
        !pointer(&r, o->manager + 0x10, &o->list) || !o->list)
        return finish(o, LV_TARGET_UNREADABLE, "actor_list");
    if (!load(&r, o->list + 0x18, &o->reported_count, 4) ||
        !pointer(&r, o->list + 0x10, &o->items))
        return finish(o, LV_TARGET_UNREADABLE, "list_header");
    if (o->reported_count < 0 || o->reported_count > LV_TARGET_MAX_ACTORS)
        return finish(o, LV_TARGET_LIMIT, "actor_count");
    if (!o->reported_count) return finish(o, LV_TARGET_NOT_IN_BATTLE, "actor_count_zero");
    uint64_t capacity = 0;
    if (!o->items || !load(&r, o->items + 0x18, &capacity, 8))
        return finish(o, LV_TARGET_UNREADABLE, "array_capacity");
    if (capacity < (uint64_t)o->reported_count || capacity > 65536)
        return finish(o, LV_TARGET_LAYOUT_MISMATCH, "array_capacity");
    uint64_t fe_class = 0, statics = 0, my_visual = 0, my_actor = 0;
    if (pointer(&r, o->class_cache + LV_TYPE_FE_VISI * 8ULL, &fe_class) && fe_class &&
        class_matches(&r, fe_class, "FEVisi") && pointer(&r, fe_class + 0xb8, &statics) && statics &&
        pointer(&r, statics + 0x30, &my_visual) && my_visual &&
        pointer(&r, my_visual + 0xa0, &my_actor) && my_actor)
        pointer(&r, my_actor + 0x18, &o->local_native);
    for (int32_t i = 0; i < o->reported_count; ++i) {
        LVTargetActor a = {0};
        if (!pointer(&r, o->items + 0x20 + (uint64_t)i * 8, &a.visual) || !a.visual ||
            !pointer(&r, a.visual + 0xa0, &a.managed) || !a.managed ||
            !pointer(&r, a.managed + 0x18, &a.native) || !a.native) { ++o->skipped; continue; }
        /* BattleActor getters: 0x4ee53fc, 0x4ee5408, 0x4ee5780. */
        a.values_ok = load(&r, a.native + 0x2c, &a.resource_id, 4) &&
                      load(&r, a.native + 0x30, &a.tid, 4) &&
                      load(&r, a.native + 0x80, &a.camp, 4);
        /* FixGameObject.get_objId 0x4f81308; get_transform 0x4f81314;
           FixTransform.get_position 0x4f82550 copies three signed Fix64 values. */
        a.object_id_ok = load(&r, a.native + 0x18, &a.object_id, 4);
        if (pointer(&r, a.native + 0x20, &a.transform) && a.transform)
            a.position_ok = load(&r, a.transform + 0x18, a.position_fixed, sizeof(a.position_fixed));
        /* get_attribute 0x4ee5be0; get_curHP 0x4ea20cc. */
        if (pointer(&r, a.native + 0xc0, &a.attribute) && a.attribute)
            a.health_ok = load(&r, a.attribute + 0x150, &a.health_fixed, 8);
        a.is_local = o->local_native && a.native == o->local_native;
        /* BattleActor managed bool fields recovered from the metadata offset
           table. These cached flags are observations, not a native IsValid or
           IsSkillable predicate. Do not guess categories from resource IDs. */
        uint8_t flags[0x24] = {0};
        if (load(&r, a.managed + 0x138, flags, sizeof(flags)) &&
            flags[0] <= 1 && flags[7] <= 1 && flags[9] <= 1 && flags[11] <= 1 && flags[35] <= 1) {
            a.classification_ok = 1; a.is_building = flags[0]; a.is_hero = flags[7];
            a.is_soldier = flags[9]; a.is_monster = flags[11]; a.is_red_blue_buff = flags[35];
            /* Metadata isSummonedWards +158 and original getter 4eeebac.
               Keep its validity separate so an unknown ward flag cannot
               suppress previously verified hero classification. */
            if(flags[32]<=1) { a.ward_classification_ok=1; a.is_ward=flags[32]; }
        }
        position_candidates(&r,&a);
        if(a.ward_classification_ok && a.is_ward) {
            uint8_t same_ward;
            if(!load(&r,a.managed+0x158,&same_ward,1) || same_ward!=1)
                a.ward_classification_ok=a.is_ward=0;
        }
        uint64_t visual_after = 0, managed_after = 0, native_after = 0; uint32_t id_after = 0;
        if (!pointer(&r, o->items + 0x20 + (uint64_t)i * 8, &visual_after) || visual_after != a.visual ||
            !pointer(&r, a.visual + 0xa0, &managed_after) || managed_after != a.managed ||
            !pointer(&r, a.managed + 0x18, &native_after) || native_after != a.native ||
            (a.object_id_ok && (!load(&r, a.native + 0x18, &id_after, 4) || id_after != a.object_id))) {
            a.values_ok = a.health_ok = a.position_ok = a.object_id_ok = a.classification_ok = 0;
            a.attribute_last_position_ok=a.host_position_ok=a.sync_logic_position_ok=a.visual_state_ok=0;
            a.fow_force_position_ok=a.fog_cut_state_ok=0;
            a.resource_id = a.tid = a.camp = 0; a.object_id = 0; a.health_fixed = 0;
            memset(a.position_fixed, 0, sizeof(a.position_fixed));
            a.is_hero = a.is_monster = a.is_soldier = a.is_building = a.is_red_blue_buff = 0;
            a.ward_classification_ok=a.is_ward=0;
        }
        o->actors[o->count++] = a;
    }
    local_skills(&r, o->local_native, &o->local_skills);
    int32_t count_after = 0; uint64_t items_after = 0, drive_after = 0;
    if (!load(&r, o->list + 0x18, &count_after, 4) ||
        !pointer(&r, o->list + 0x10, &items_after) || !pointer(&r, o->drive_statics, &drive_after)) {
        discard_values(o, LV_TARGET_UNREADABLE, "actor_list_consistency_read");
        return finish(o, LV_TARGET_UNREADABLE, "consistency_read");
    }
    if (count_after != o->reported_count || items_after != o->items || drive_after != o->drive) {
        discard_values(o, LV_TARGET_CHANGED, "actor_list_changed");
        return finish(o, LV_TARGET_CHANGED, "list_changed_during_read");
    }
    int partial = o->skipped || !o->local_native;
    unsigned local_found = 0;
    for (size_t i = 0; i < o->count; ++i)
        { local_found += o->actors[i].is_local;
          if (!o->actors[i].values_ok || !o->actors[i].health_ok) partial = 1; }
    if (!local_found) partial = 1;
    return finish(o, partial ? LV_TARGET_PARTIAL : LV_TARGET_READY, "actor_values");
}

const char *lv_target_result_name(LVTargetResult r) {
    switch (r) {
        case LV_TARGET_READY: return "ready";
        case LV_TARGET_NOT_IN_BATTLE: return "not_in_battle";
        case LV_TARGET_UNREADABLE: return "unreadable";
        case LV_TARGET_LAYOUT_MISMATCH: return "layout_mismatch";
        case LV_TARGET_CHANGED: return "changed_during_read";
        case LV_TARGET_LIMIT: return "actor_limit";
        case LV_TARGET_PARTIAL: return "partial";
    }
    return "unknown";
}

static void clear_native_health(LVTargetActor *a, LVNativeHealthStatus status) {
    a->native_health_fraction_ok=0;
    a->native_current_health_fixed=a->native_max_health_fixed=a->native_health_fraction_fixed=0;
    a->native_health_status=status;
}
static int native_health_identity(Reader *r, const LVTargetActor *a) {
    uint64_t p; uint32_t id; int32_t resource, camp;
    return pointer(r,a->visual+0xa0,&p) && p==a->managed &&
        pointer(r,a->managed+0x18,&p) && p==a->native &&
        pointer(r,a->native+0xc0,&p) && p==a->attribute &&
        load(r,a->native+0x18,&id,4) && id==a->object_id &&
        load(r,a->native+0x2c,&resource,4) && resource==a->resource_id &&
        load(r,a->native+0x80,&camp,4) && camp==a->camp;
}
void lv_target_native_health_read(LVTargetRead read, void *context, uint64_t base,
                                 const char *uuid, LVTargetSnapshot *s, LVNativeHealthReport *report) {
    LVNativeHealthReport result={.reason="native_health_unavailable"};
    if(report) *report=result;
    if(!s || s->count>LV_TARGET_MAX_ACTORS) return;
    for(size_t i=0;i<s->count;++i) clear_native_health(&s->actors[i],LV_HEALTH_UNAVAILABLE);
    if(!uuid || strcmp(uuid,LV_NATIVE_ENGINE_UUID)) {
        result.reason="native_engine_uuid_mismatch"; goto done;
    }
    result.profile_matches=1;
    if(!read || (s->result!=LV_TARGET_READY && s->result!=LV_TARGET_PARTIAL) ||
        !address_valid(base,8) || base>(UINT64_C(1)<<48)-0x523cf30) goto done;
    Reader r={read,context}; uint64_t root,config; uint8_t mode;
    /* FE_TN212 -> GetFEInterfaceConfig -> AttrDB tag 2. Same selector and
       vector/node layout as the original maxHPVisi getter. No code is invoked. */
    if(!pointer(&r,base+0x523cf28,&root) || !root ||
        !pointer(&r,root+0x18,&config) || !config || !load(&r,config+0x1e,&mode,1)) {
        result.reason="native_config_unreadable"; goto done;
    }
    result.sync_values=mode!=0;
    uint8_t network,thread,fog;
    if(load(&r,config+0x1c,&network,1) && network<=1 &&
        load(&r,config+0x1d,&thread,1) && thread<=1 && load(&r,config+0x26,&fog,1) && fog<=1) {
        result.fog_config_ok=1; result.use_logic_network=network;
        result.logic_thread_enabled=thread; result.fog_cut_enabled=fog;
    }
    for(size_t i=0;i<s->count;++i) {
        LVTargetActor *a=&s->actors[i];
        unsigned duplicate=0;
        for(size_t j=0;j<s->count;++j) if(j!=i && s->actors[j].object_id_ok &&
            s->actors[j].object_id==a->object_id) duplicate=1;
        if(!a->values_ok || !a->classification_ok || !a->is_hero || !a->object_id_ok ||
            !a->object_id || duplicate || !a->attribute || !address_valid(a->attribute,0x208)) {
            clear_native_health(a,LV_HEALTH_INELIGIBLE); continue;
        }
        ++result.eligible;
        uint64_t begin,end,node; int64_t cur,max;
        if(!native_health_identity(&r,a)) {
            a->native_health_status=LV_HEALTH_CHANGED; ++result.changed; continue;
        }
        if(!pointer(&r,a->attribute+0x1f8,&begin) || !pointer(&r,a->attribute+0x200,&end)) {
            a->native_health_status=LV_HEALTH_UNREADABLE; ++result.unreadable; continue;
        }
        if(!begin || end<begin || (end-begin)%8 || end-begin<24 || end-begin>4096*8) {
            a->native_health_status=LV_HEALTH_INVALID; ++result.invalid; continue;
        }
        if(!pointer(&r,begin+16,&node) || !node ||
            !load(&r,a->attribute+0x150,&cur,8) || !load(&r,node+(mode ? 0x68 : 0x60),&max,8)) {
            a->native_health_status=LV_HEALTH_UNREADABLE; ++result.unreadable; continue;
        }
        if(cur<0 || max<=0) { a->native_health_status=LV_HEALTH_INVALID; ++result.invalid; continue; }
        uint64_t same; int64_t cur_after,max_after;
        if(!pointer(&r,a->attribute+0x1f8,&same) || same!=begin ||
            !pointer(&r,a->attribute+0x200,&same) || same!=end ||
            !pointer(&r,begin+16,&same) || same!=node ||
            !load(&r,a->attribute+0x150,&cur_after,8) || cur_after!=cur ||
            !load(&r,node+(mode ? 0x68 : 0x60),&max_after,8) || max_after!=max ||
            !native_health_identity(&r,a)) {
            a->native_health_status=LV_HEALTH_CHANGED; ++result.changed; continue;
        }
        a->native_current_health_fixed=cur; a->native_max_health_fixed=max;
        a->native_health_fraction_fixed=cur>=max ? 16384 : (int64_t)(((__int128)cur*16384)/max);
        a->native_health_fraction_ok=1; a->native_health_status=LV_HEALTH_READY; ++result.valid;
    }
    uint64_t same; uint8_t same_mode;
    if(!pointer(&r,base+0x523cf28,&same) || same!=root ||
        !pointer(&r,root+0x18,&same) || same!=config ||
        !load(&r,config+0x1e,&same_mode,1) || same_mode!=mode) {
        result.reason="native_config_changed"; result.valid=0;
        result.fog_config_ok=0;
        for(size_t i=0;i<s->count;++i) if(s->actors[i].native_health_fraction_ok) {
            clear_native_health(&s->actors[i],LV_HEALTH_CHANGED); ++result.changed;
        }
    } else {
        result.reason=result.valid==result.eligible ? "ready" : "partial";
        uint8_t n,t,f;
        if(result.fog_config_ok && (!load(&r,config+0x1c,&n,1) || n!=network ||
            !load(&r,config+0x1d,&t,1) || t!=thread || !load(&r,config+0x26,&f,1) || f!=fog))
            result.fog_config_ok=0;
    }
done:
    if(report) *report=result;
}
const char *lv_native_health_status_name(LVNativeHealthStatus status) {
    switch(status) {
        case LV_HEALTH_READY:return "ready";
        case LV_HEALTH_UNREADABLE:return "unreadable";
        case LV_HEALTH_INVALID:return "invalid_values_or_layout";
        case LV_HEALTH_CHANGED:return "changed_during_read";
        case LV_HEALTH_INELIGIBLE:return "ineligible_actor";
        case LV_HEALTH_UNAVAILABLE:return "unavailable";
    }
    return "unknown";
}
