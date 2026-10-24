#import "LVSnapshot.h"
#import "LVMachReader.h"
#include "LVTarget.h"
#include "LVSmitePreview.h"
#include "LVSkillPanel.h"
#include "LVMonsterRespawn.h"
#include <errno.h>

static int readTarget(void *context, uint64_t address, void *buffer, size_t length) {
    return [(__bridge LVMachReader *)context readAddress:address into:buffer length:length];
}
static NSString *hexAddress(uint64_t value) {
    return [NSString stringWithFormat:@"0x%llx", (unsigned long long)value];
}
static NSString *resultName(LVTargetResult value) {
    return [NSString stringWithUTF8String:lv_target_result_name(value)];
}
static NSDictionary *skillList(LVTargetSkillList *list) {
    NSMutableArray *skills = [NSMutableArray new];
    for (size_t i = 0; i < list->count; ++i) {
        LVTargetSkill *s = &list->skills[i];
        NSMutableDictionary *record = [@{ @"native_address": hexAddress(s->native),
            @"cd_node_address": hexAddress(s->cd_node), @"values_read_ok": @(s->values_ok != 0),
            @"cooldown_read_ok": @(s->cooldown_ok != 0) } mutableCopy];
        [record addEntriesFromDictionary:@{ @"stock_read_ok": @(s->stock_ok != 0),
            @"slot_state_read_ok": @(s->slot_state_ok != 0), @"cast_state_read_ok": @(s->cast_state_ok != 0),
            @"stock_manager_address": hexAddress(s->stock_manager), @"slot_address": hexAddress(s->slot) }];
        if (s->values_ok) [record addEntriesFromDictionary:@{ @"object_id": @(s->object_id),
            @"resource_id": @(s->resource_id), @"level": @(s->level) }];
        if (s->cooldown_ok) [record addEntriesFromDictionary:@{ @"cooldown_fixed": @(s->cooldown_fixed),
            @"cooldown_seconds": @((double)s->cooldown_fixed / 16384.0), @"cd_locked": @(s->cd_locked != 0) }];
        if (s->stock_ok) [record addEntriesFromDictionary:@{ @"stock_current": @(s->stock_current), @"stock_maximum": @(s->stock_maximum) }];
        if (s->slot_state_ok) record[@"slot_state_raw"] = @(s->slot_state);
        if (s->cast_state_ok) [record addEntriesFromDictionary:@{ @"cast_state_raw": @(s->cast_state),
            @"state_is_used": @((s->cast_state & 0x40) != 0), @"state_is_cast": @((s->cast_state & 0x20) != 0),
            @"state_is_casting": @((s->cast_state & 0x50) == 0x40), @"state_is_cast_success": @((s->cast_state & 0x10) != 0),
            @"state_is_finished": @((s->cast_state & 0x200) != 0), @"state_is_manual_finish": @(s->cast_state == 0x100) }];
        [skills addObject:record];
    }
    return @{ @"result": resultName(list->result),
        @"stage": [NSString stringWithUTF8String:list->stage ?: "unknown"],
        @"header_address": hexAddress(list->header), @"begin_address": hexAddress(list->begin),
        @"end_address": hexAddress(list->end), @"stride": @(list->stride),
        @"reported_skill_count": @(list->reported_count), @"read_skill_count": @(list->count),
        @"skipped_skill_count": @(list->skipped), @"skills": skills };
}
static NSDictionary *enemySkillPanel(LVMachReader *reader, const LVTargetSnapshot *snapshot, const LVConfig *config, uint64_t engineBase, NSString *engineUUID) {
    LVSkillPanel panel;
    BOOL enabled=config && config->values[lv_config_index("drawSkillPanel")][0]!=0;
    lv_skill_panel_read(readTarget,(__bridge void *)reader,snapshot,enabled,&panel);
    lv_skill_panel_native_cooldowns(readTarget,(__bridge void *)reader,engineBase,
        [engineUUID isKindOfClass:NSString.class]?engineUUID.UTF8String:NULL,snapshot,&panel);
    lv_skill_panel_classify(readTarget,(__bridge void *)reader,engineBase,
        [engineUUID isKindOfClass:NSString.class]?engineUUID.UTF8String:NULL,snapshot,&panel);
    BOOL hideSmall=YES; /* Panel keeps ultimate/summoner skills; raw diagnostics remain complete. */
    NSMutableArray *heroes=[NSMutableArray new];
    for(size_t i=0;i<panel.count;++i) {
        const LVPanelHero *hero=&panel.heroes[i];NSMutableArray *skills=[NSMutableArray new];
        NSMutableArray *displayed=[NSMutableArray new];NSUInteger hiddenRegular=0,hiddenUnknown=0;
        for(size_t j=0;j<hero->count;++j) {
            const LVPanelSkill *skill=&hero->skills[j];
            NSDictionary *entry=@{ @"object_id":@(skill->object_id), @"resource_id":@(skill->resource_id),
                @"native_address":hexAddress(skill->native), @"slot_address":hexAddress(skill->slot),
                @"cd_node_address":hexAddress(skill->cd_node),
                @"cooldown_source":skill->logic_cooldown_ok?@"native_skill_cd_trigger_node":@"sync_skill_cd_trigger_node",
                @"cooldown_node_address":hexAddress(skill->logic_cooldown_ok?skill->logic_cd_node:skill->cd_node),
                @"logic_skill_address":hexAddress(skill->logic_native), @"logic_cd_node_address":hexAddress(skill->logic_cd_node),
                @"logic_cooldown_read_ok":@(skill->logic_cooldown_ok!=0), @"logic_remain_raw":@(skill->logic_remain_raw),
                @"logic_node_values_read_ok":@(skill->logic_node_values_ok!=0), @"logic_total_raw":@(skill->logic_total_raw),
                @"logic_start_raw":@(skill->logic_start_raw),
                @"logic_lookup_source":@(skill->logic_lookup_source ?: "unavailable"),
                @"logic_cooldown_reason":@(skill->logic_cooldown_reason ?: "unavailable"), @"cooldown_zero_verified":@NO,
                @"node_values_read_ok":@(skill->node_values_ok!=0), @"node_total_fixed":@(skill->total_fixed),
                @"node_start_fixed":@(skill->start_fixed), @"configured_cd_read_ok":@(skill->configured_cd_ok!=0),
                @"configured_cd1_fixed":@(skill->cd1_fixed), @"configured_cd2_fixed":@(skill->cd2_fixed),
                @"slot_index":@(skill->slot_index), @"level":@(skill->level), @"is_summoner":@(skill->summoner!=0),
                @"cooldown_read_ok":@(skill->cooldown_ok!=0), @"cooldown_locked":@(skill->locked!=0),
                @"cooldown_fixed":@(skill->cooldown_fixed), @"ambiguous":@(skill->ambiguous!=0),
                @"role":@(lv_skill_panel_role_name(skill->role)), @"configured_index":@(skill->configured_index) };
            [skills addObject:entry];
            if(lv_skill_panel_skill_visible(skill,hideSmall))[displayed addObject:entry];
            else if(skill->role==LV_PANEL_REGULAR)++hiddenRegular;
            else ++hiddenUnknown;
        }
        NSMutableDictionary *managerSlots=[NSMutableDictionary new];
        unsigned probeOffsets[LV_MANAGER_PROBE_COUNT]=LV_MANAGER_PROBE_OFFSETS;
        for(unsigned p=0;p<LV_MANAGER_PROBE_COUNT;++p)
            managerSlots[[NSString stringWithFormat:@"0x%x",probeOffsets[p]]]=@{
                @"address":hexAddress(hero->logic_manager_slot[p]),
                @"read_ok":@(hero->logic_manager_slot_ok[p]!=0) };
        [heroes addObject:@{ @"object_id":@(hero->object_id), @"resource_id":@(hero->resource_id),
            @"result":resultName(hero->result), @"reason":@(hero->reason), @"skills":skills,
            @"display_skills":displayed, @"hidden_regular_count":@(hiddenRegular), @"hidden_unknown_count":@(hiddenUnknown),
            @"classification_read_ok":@(hero->classification_ok!=0), @"ultimate_resource_id":@(hero->ultimate_resource_id),
            @"logic_summoner_manager_address":hexAddress(hero->logic_summoner_manager),
            @"logic_summoner_manager_ok":@(hero->logic_summoner_manager_ok!=0),
            @"logic_summoner_list_ok":@(hero->logic_summoner_list_ok!=0),
            @"logic_manager_slots":managerSlots,
            @"unavailable_skill_count":@(hero->unavailable), @"truncated":@(hero->truncated!=0) }];
    }
    return @{ @"enabled":@(panel.enabled!=0), @"result":resultName(panel.result), @"reason":@(panel.reason),
        @"truncated":@(panel.truncated!=0), @"heroes":heroes,
        @"read_only":@YES, @"castability_verified":@NO, @"device_verified":@NO,
        @"slot_label_source":@"native SkillSlot.index; # is a current skill slot, S is independently enumerated in the summoner list",
        @"classification_reason":@(panel.classification_reason ?: "unavailable"),
        @"skill_role_mapping_implemented":@YES, @"ability_name_mapping_implemented":@NO,
        @"hide_small_skills_implemented":@YES, @"hide_small_skills":@(hideSmall),
        @"scope":@"Current identity/owner/slot-checked enemy skill cooldowns. Identity-matched native logic skill nodes are preferred to the sync cache. Zero values remain unverified; null nodes are unavailable. No clock arithmetic, countdown inference or history fallback." };
}

static NSDictionary *smitePreview(LVTargetSnapshot *snapshot, const LVConfig *config) {
    LVSmitePreview p; lv_smite_preview(snapshot, config, &p);
    NSMutableArray *blocks = [NSMutableArray new], *candidates = [NSMutableArray new];
    for (unsigned bit = 1; bit <= LV_PREVIEW_LOCAL_AMBIGUOUS; bit <<= 1)
        if (p.blockers & bit) [blocks addObject:[NSString stringWithUTF8String:lv_smite_preview_block_name(bit)]];
    for (size_t i = 0; i < p.candidate_count; ++i) {
        LVPreviewCandidate *c = &p.candidates[i]; LVTargetActor *a = &snapshot->actors[c->actor_index];
        NSMutableDictionary *record = [@{ @"resource_id": @(a->resource_id), @"actor_index": @(c->actor_index),
            @"status": [NSString stringWithUTF8String:lv_smite_candidate_status_name(c->status)],
            @"distance_read_ok": @(c->distance_ok != 0) } mutableCopy];
        if (a->object_id_ok) record[@"object_id"] = @(a->object_id);
        if (a->health_ok) record[@"health"] = @((double)a->health_fixed / 16384.0);
        if (c->distance_ok) record[@"distance_world_xz"] = @(c->distance_world_xz);
        [candidates addObject:record];
    }
    NSMutableDictionary *r = [@{ @"read_only": @YES, @"touch_backend_available": @NO,
        @"castability_verified": @NO, @"coordinate_scale_device_verified": @NO,
        @"coordinate_basis": @"Raw X/Z Fix64; Android/iOS distance scale is an explicit unverified assumption",
        @"would_trigger_in_simulation": @(p.would_trigger != 0), @"blockers": blocks,
        @"settings": @{ @"autoSmite": @(p.enabled != 0), @"smiteRequireEnemy": @(p.require_enemy != 0),
          @"smiteRedBuff": @(p.red_enabled != 0), @"smiteBlueBuff": @(p.blue_enabled != 0), @"smiteDragon": @(p.dragon_enabled != 0),
          @"smiteRange": @(p.range_fixed), @"smiteHealthThreshold": @(p.fallback_threshold) },
        @"range_world_xz_assumed": @((double)p.range_fixed / 16384.0), @"original_rule_threshold": @(p.threshold),
        @"threshold_source": p.threshold_from_level ? @"recovered_android_level_formula" : @"configuration_fallback",
        @"actual_ios_damage_verified": @NO,
        @"nearby_enemy_hero_count": @(p.enemy_count), @"unconfirmed_enemy_object_count": @(p.unknown_enemy_count),
        @"recognized_target_count": @(p.candidate_count), @"eligible_target_count": @(p.eligible_count), @"candidates": candidates,
        @"scope": @"One-snapshot simulation with synthetic touch availability. No touch event or persistent action state. Cached category flags, slot and skill state do not establish native IsValid/IsSkillable." } mutableCopy];
    if (p.smite_found) {
        LVTargetSkill *s = &snapshot->local_skills.summoner.skills[p.skill_index];
        r[@"smite_resource_id"] = @(s->resource_id); r[@"smite_level"] = @(s->level);
    }
    if (p.would_trigger && p.chosen_actor_index < snapshot->count)
        r[@"chosen_object_id"] = @(snapshot->actors[p.chosen_actor_index].object_id);
    return r;
}
static NSArray *fixedPosition(const int64_t *p) {
    return @[@((double)p[0]/16384.0),@((double)p[1]/16384.0),@((double)p[2]/16384.0)];
}
static NSDictionary *positionCandidates(const LVTargetActor *a) {
    NSMutableDictionary *r=[@{ @"attribute_last_position_read_ok": @(a->attribute_last_position_ok!=0),
        @"sync_logic_position_read_ok": @(a->sync_logic_position_ok!=0),
        @"host_position_read_ok": @(a->host_position_ok!=0), @"visual_state_read_ok": @(a->visual_state_ok!=0),
        @"fow_force_position_read_ok":@(a->fow_force_position_ok!=0), @"fog_cut_state_read_ok":@(a->fog_cut_state_ok!=0),
        @"used_for_overlay": @NO } mutableCopy];
    if(a->attribute_last_position_ok) r[@"attribute_last_position"]=fixedPosition(a->attribute_last_position);
    if(a->sync_logic_position_ok) {
        r[@"sync_logic_position"]=@[@(a->sync_logic_position[0]),@(a->sync_logic_position[1]),@(a->sync_logic_position[2])];
        r[@"sync_logic_time"]=@(a->sync_logic_time);
    }
    if(a->host_position_ok) {
        r[@"host_position"]=fixedPosition(a->host_position);
        r[@"host_object_id"]=@(a->host_object_id); r[@"host_resource_id"]=@(a->host_resource_id); r[@"host_camp"]=@(a->host_camp);
    }
    if(a->visual_state_ok) { r[@"should_be_visible"]=@(a->should_be_visible!=0); r[@"visual_tick"]=@(a->visual_tick); }
    if(a->fow_force_position_ok) r[@"fow_force_position"]=fixedPosition(a->fow_force_position);
    if(a->fog_cut_state_ok) r[@"fog_cut_disappear"]=@(a->fog_cut_disappear!=0);
    return r;
}
static NSDictionary *minimapSnapshot(LVMachReader *reader, uint64_t base, LVTargetSnapshot *snapshot,
                                      const LVMinimapSettings *settings, const LVConfig *config, const LVMinimapHealthReport *health,
                                      const LVNativeHealthReport *nativeHealth, const LVLogicPositionReport *logic) {
    LVMinimapGeometry geometry; lv_minimap_read(readTarget, (__bridge void *)reader, base, &geometry);
    if (!geometry.ready && [@(geometry.reason) isEqual:@"geometry_changed"])
        lv_minimap_read(readTarget, (__bridge void *)reader, base, &geometry);
    BOOL drawWards=config && config->values[lv_config_index("drawWards")][0]!=0;
    BOOL drawMonsters=config && config->values[lv_config_index("drawMonsters")][0]!=0;
    LVMinimapFrame frame; lv_minimap_frame_with_layers(snapshot, &geometry, settings, drawWards, drawMonsters, &frame);
    size_t rawCount=0;
    for(size_t i=0;i<frame.count;++i) rawCount+=!frame.markers[i].is_local && !frame.markers[i].is_ward && !frame.markers[i].is_monster;
    size_t rawUnplaced=frame.missing_enemies+frame.outside_enemies;
    unsigned rawReady=frame.ready;
    NSMutableArray *markers = [NSMutableArray new];
    for (size_t i = 0; i < frame.count; ++i) {
        LVMinimapMarker *m = &frame.markers[i];
        [markers addObject:@{ @"object_id": @(m->object_id), @"resource_id": @(m->resource_id),
            @"ordinal": @(m->ordinal), @"is_local": @(m->is_local != 0), @"is_ward": @(m->is_ward != 0),
            @"is_monster": @(m->is_monster != 0), @"health_read_ok": @(m->health_read_ok != 0),
            @"health_fixed": @(m->health_fixed),
            @"u": @(m->u), @"v": @(m->v),
            @"health_fraction_read_ok": @(m->health_fraction_ok != 0), @"health_fraction": @(m->health_fraction),
            @"health_source": m->health_source==1 ? @"native_attributes" :
                (m->health_source==2 ? @"game_minimap_cached_percent" : @"unavailable"),
            @"position_source": m->position_source==2 ? @"native_logic_transform" : @"sync_transform",
            @"edge_clamped": @(m->edge_clamped != 0) }];
    }
    BOOL timersEnabled=config && config->values[lv_config_index("showMonsterRespawn")][0]!=0;
    LVMonsterRespawnReport respawn;
    lv_monster_respawn_read(readTarget,(__bridge void *)reader,base,LV_TARGET_UUID,snapshot,timersEnabled,&respawn);
    NSMutableArray *timers=[NSMutableArray new];
    if(frame.ready)for(size_t i=0;i<respawn.count;++i) {
        const LVMonsterRespawnTimer *t=&respawn.timers[i];double u,v;
        int projected=lv_minimap_project_world(&geometry,settings,frame.rotation_degrees,
            (double)t->position_fixed[0]/16384.0,(double)t->position_fixed[2]/16384.0,&u,&v);
        if(projected<=0)continue;
        int64_t seconds=t->remaining_fixed/16384+(t->remaining_fixed%16384!=0);
        [timers addObject:@{ @"anchor_id":@(t->anchor_id), @"poi_type":@(t->poi_type),
            @"remaining_fixed":@(t->remaining_fixed), @"remaining_seconds":@(seconds),
            @"position":fixedPosition(t->position_fixed), @"position_source":@"anchor_configuration_transformPos", @"u":@(u), @"v":@(v) }];
    }
    return @{ @"projection_ready": @(frame.ready != 0), @"reason": @(frame.reason),
        @"confirmed_enemy_hero_count": @(frame.confirmed_enemies), @"dead_enemy_count": @(frame.dead_enemies),
        @"missing_enemy_position_count": @(frame.missing_enemies), @"outside_map_enemy_count": @(frame.outside_enemies),
        @"duplicate_id_count": @(frame.duplicate_ids), @"local_camp": @(frame.local_camp),
        @"rotation_degrees": @(frame.rotation_degrees), @"manual_projection": @(frame.manual_projection != 0),
        @"current_projection_ready": @(rawReady != 0), @"current_enemy_marker_count": @(rawCount),
        @"current_unplaced_enemy_count": @(rawUnplaced),
        @"edge_clamped_enemy_count": @(frame.edge_clamped_enemies),
        @"wards": @{ @"enabled":@(drawWards), @"confirmed_enemy_count":@(frame.confirmed_wards),
            @"current_marker_count":@(frame.ward_markers), @"dead_count":@(frame.dead_wards),
            @"unavailable_count":@(frame.unavailable_wards), @"outside_map_count":@(frame.outside_wards),
            @"classification_source":@"BattleActor.isSummonedWards", @"device_verified":@NO },
        @"monsters": @{ @"enabled":@(drawMonsters), @"confirmed_count":@(frame.confirmed_monsters),
            @"current_marker_count":@(frame.monster_markers), @"dead_count":@(frame.dead_monsters),
            @"unavailable_count":@(frame.unavailable_monsters), @"outside_map_count":@(frame.outside_monsters),
            @"classification_source":@"BattleActor.isMonster", @"health_source":@"current_attribute_hp",
            @"respawn_timer_implemented":@YES, @"device_verified":@NO },
        @"respawn_timers": @{ @"enabled":@(timersEnabled), @"reason":@(respawn.reason),
            @"source":@"current_monster_anchor_timeNeedToBorn", @"read_only":@YES,
            @"device_verified":@NO, @"examined_anchor_count":@(respawn.examined),
            @"read_timer_count":@(respawn.count), @"marker_count":@(timers.count),
            @"unavailable_count":@(respawn.unavailable), @"duplicate_count":@(respawn.duplicates),
            @"timers":timers, @"scope":@"Current game-owned BornCountDown monster anchors and remaining Q14 time only. No historical death timers or clock extrapolation. Only currently available anchor UI bindings are sampled." },
        @"health_cache": @{ @"reason": @(health->reason), @"matched_hero_count": @(health->matched),
            @"enabled_hero_count": @(health->enabled), @"valid_fraction_count": @(health->valid),
            @"source": @"game_minimap_cached_percent", @"max_health_inferred": @NO },
        @"native_health": @{ @"reason": @(nativeHealth->reason),
            @"profile_matches": @(nativeHealth->profile_matches!=0), @"sync_values": @(nativeHealth->sync_values!=0),
            @"fog_config_read_ok":@(nativeHealth->fog_config_ok!=0),
            @"use_logic_network":@(nativeHealth->use_logic_network!=0),
            @"logic_thread_enabled":@(nativeHealth->logic_thread_enabled!=0),
            @"fog_cut_enabled":@(nativeHealth->fog_cut_enabled!=0),
            @"eligible_hero_count": @(nativeHealth->eligible), @"valid_fraction_count": @(nativeHealth->valid),
            @"unreadable_count": @(nativeHealth->unreadable), @"invalid_count": @(nativeHealth->invalid),
            @"changed_count": @(nativeHealth->changed), @"source": @"native_attributes", @"max_health_inferred": @NO },
        @"logic_positions": @{ @"reason": @(logic->reason), @"profile_matches": @(logic->profile_matches!=0),
            @"layout_version": @3,
            @"runtime_battle_matches_frame": @(logic->battle!=0 && logic->battle==logic->frame_battle),
            @"manager_vtable_offset": hexAddress(logic->manager_vtable_offset),
            @"lookup_method_offset": hexAddress(logic->lookup_method_offset),
            @"eligible_hero_count": @(logic->eligible-logic->eligible_wards),
            @"eligible_ward_count": @(logic->eligible_wards), @"valid_ward_position_count": @(logic->valid_wards),
            @"valid_hero_position_count": @(logic->valid-logic->valid_wards), @"valid_position_count": @(logic->valid),
            @"not_found_count": @(logic->not_found), @"unreadable_count": @(logic->unreadable),
            @"invalid_count": @(logic->invalid), @"changed_count": @(logic->changed),
            @"source": @"native_logic_transform" },
        @"markers": markers, @"alignment_device_verified": @NO,
        @"geometry": @{ @"ready": @(geometry.ready != 0), @"reason": @(geometry.reason),
            @"viewport_mode": @(geometry.viewport_mode != 0), @"full_map_showing": @(geometry.full_map_showing != 0),
            @"zoom_state": @(geometry.zoom_state), @"scale_x": @(geometry.scale_x), @"scale_z": @(geometry.scale_z),
            @"half_width": @(geometry.half_width), @"half_height": @(geometry.half_height) },
        @"scope": @"Current client-memory coordinates only; no historical positions or extrapolation. Identity-matched independent logic transforms are preferred to the sync view. HP fraction prefers native current/max attributes. Remaining coordinate candidates are diagnostic only. Ordinary map only; native logic positions require device verification." };
}
NSDictionary *LVReadTargetSnapshot(LVMachReader *reader, NSDictionary *metadata, const LVConfig *config,
                                  const LVMinimapSettings *mapSettings) {
    NSDictionary *image = nil, *engineImage = nil;
    id rawImages = metadata[@"images"];
    if ([rawImages isKindOfClass:NSArray.class]) {
        for (id item in rawImages) {
            if (![item isKindOfClass:NSDictionary.class]) continue;
            NSString *path = item[@"path"];
            if ([path isKindOfClass:NSString.class] &&
                [path hasSuffix:@"/Frameworks/UnityFramework.framework/UnityFramework"]) {
                image = item;
            }
            if ([path isKindOfClass:NSString.class] && [path hasSuffix:@"/Frameworks/FEProj.framework/FEProj"])
                engineImage = item;
        }
    }
    NSString *profile = @LV_TARGET_UUID;
    if (!image) return @{ @"result": @"framework_not_found", @"profile_uuid": profile };
    if (![image[@"uuid"] isEqual:profile]) return @{ @"result": @"uuid_mismatch",
        @"profile_uuid": profile, @"loaded_uuid": image[@"uuid"] ?: @"missing" };
    NSString *address = image[@"load_address"];
    if (![address isKindOfClass:NSString.class]) return @{ @"result": @"invalid_image_address" };
    char *end = NULL; errno = 0;
    const char *text = address.UTF8String;
    uint64_t base = strtoull(text, &end, 0);
    if (errno || end == text || *end) return @{ @"result": @"invalid_image_address" };
    LVTargetSnapshot snapshot;
    unsigned attempts=0;
    do { lv_target_snapshot(readTarget, (__bridge void *)reader, base, &snapshot); ++attempts; }
    while(snapshot.result==LV_TARGET_CHANGED && attempts<3);
    LVMinimapHealthReport health;
    lv_minimap_health_read(readTarget,(__bridge void *)reader,base,&snapshot,&health);
    uint64_t engineBase=0; NSString *engineAddress=engineImage[@"load_address"];
    if([engineAddress isKindOfClass:NSString.class]) {
        errno=0; const char *engineText=engineAddress.UTF8String;
        engineBase=strtoull(engineText,&end,0);
        if(errno || end==engineText || *end) engineBase=0;
    }
    NSString *engineUUID=engineImage[@"uuid"];
    LVNativeHealthReport nativeHealth;
    lv_target_native_health_read(readTarget,(__bridge void *)reader,engineBase,
        [engineUUID isKindOfClass:NSString.class] ? engineUUID.UTF8String : NULL,&snapshot,&nativeHealth);
    LVLogicPositionReport logic;
    lv_target_logic_position_read(readTarget,(__bridge void *)reader,engineBase,
        [engineUUID isKindOfClass:NSString.class] ? engineUUID.UTF8String : NULL,&snapshot,&logic);
    NSMutableArray *actors = [NSMutableArray new];
    for (size_t i = 0; i < snapshot.count; ++i) {
        LVTargetActor *a = &snapshot.actors[i];
        NSMutableDictionary *record = [@{ @"visual_address": hexAddress(a->visual),
            @"managed_address": hexAddress(a->managed), @"native_address": hexAddress(a->native),
            @"attribute_address": hexAddress(a->attribute), @"values_read_ok": @(a->values_ok != 0),
            @"health_read_ok": @(a->health_ok != 0), @"is_local": @(a->is_local != 0),
            @"object_id_read_ok": @(a->object_id_ok != 0), @"position_read_ok": @(a->position_ok != 0),
            @"transform_address": hexAddress(a->transform) } mutableCopy];
        record[@"classification_read_ok"] = @(a->classification_ok != 0);
        record[@"ward_classification_read_ok"]=@(a->ward_classification_ok!=0);
        if(a->ward_classification_ok) record[@"is_ward"]=@(a->is_ward!=0);
        if(a->classification_ok && (a->is_hero || (a->ward_classification_ok && a->is_ward)))
            record[@"coordinate_candidates"]=positionCandidates(a);
        if(a->classification_ok && (a->is_hero || (a->ward_classification_ok && a->is_ward))) {
            record[@"logic_position_read_ok"]=@(a->logic_position_ok!=0);
            record[@"logic_position_status"]=@(lv_logic_position_status_name(a->logic_position_status));
            if(a->logic_position_ok) {
                record[@"logic_position"]=fixedPosition(a->logic_position_fixed);
                record[@"logic_native_address"]=hexAddress(a->logic_native);
                record[@"logic_transform_address"]=hexAddress(a->logic_transform);
            }
        }
        record[@"minimap_health_fraction_read_ok"] = @(a->minimap_health_fraction_ok != 0);
        if(a->minimap_health_fraction_ok) record[@"minimap_health_fraction"] = @((double)a->minimap_health_fraction_fixed/16384.0);
        record[@"native_health_fraction_read_ok"]=@(a->native_health_fraction_ok!=0);
        record[@"native_health_status"]=@(lv_native_health_status_name(a->native_health_status));
        if(a->native_health_fraction_ok) [record addEntriesFromDictionary:@{
            @"native_current_health":@((double)a->native_current_health_fixed/16384.0),
            @"native_max_health":@((double)a->native_max_health_fixed/16384.0),
            @"native_health_fraction":@((double)a->native_health_fraction_fixed/16384.0) }];
        if (a->classification_ok) [record addEntriesFromDictionary:@{ @"is_hero": @(a->is_hero != 0),
            @"is_monster": @(a->is_monster != 0), @"is_soldier": @(a->is_soldier != 0),
            @"is_building": @(a->is_building != 0), @"is_red_blue_buff": @(a->is_red_blue_buff != 0) }];
        if (a->values_ok) [record addEntriesFromDictionary:@{ @"resource_id": @(a->resource_id),
            @"tid": @(a->tid), @"camp": @(a->camp) }];
        if (a->health_ok) {
            record[@"health_fixed"] = @(a->health_fixed);
            record[@"health"] = @((double)a->health_fixed / 16384.0);
        }
        if (a->object_id_ok) record[@"object_id"] = @(a->object_id);
        if (a->position_ok) {
            record[@"position_fixed"] = @[@(a->position_fixed[0]), @(a->position_fixed[1]), @(a->position_fixed[2])];
            record[@"position"] = @[@((double)a->position_fixed[0] / 16384.0),
                @((double)a->position_fixed[1] / 16384.0), @((double)a->position_fixed[2] / 16384.0)];
        }
        [actors addObject:record];
    }
    return @{ @"profile_uuid": profile, @"result": resultName(snapshot.result),
        @"stage": [NSString stringWithUTF8String:snapshot.stage ?: "unknown"],
        @"read_only": @YES, @"reported_actor_count": @(snapshot.reported_count),
        @"read_actor_count": @(snapshot.count), @"skipped_actor_count": @(snapshot.skipped),
        @"local_native_address": hexAddress(snapshot.local_native), @"actors": actors,
        @"smite_preview": smitePreview(&snapshot, config),
        @"enemy_skill_panel":enemySkillPanel(reader,&snapshot,config,engineBase,engineUUID),
        @"snapshot_read_attempts": @(attempts),
        @"minimap": minimapSnapshot(reader, base, &snapshot, mapSettings, config, &health, &nativeHealth, &logic),
        @"logic_trace": @{ @"desk":hexAddress(logic.desk), @"frame_root":hexAddress(logic.frame_root),
            @"frame_battle":hexAddress(logic.frame_battle),
            @"battle":hexAddress(logic.battle), @"actor_manager":hexAddress(logic.manager), @"tree":hexAddress(logic.tree),
            @"manager_vtable":hexAddress(logic.manager_vtable), @"lookup_method":hexAddress(logic.lookup_method) },
        @"trace": @{ @"class_cache": hexAddress(snapshot.class_cache), @"drive_class": hexAddress(snapshot.drive_class),
          @"drive_statics": hexAddress(snapshot.drive_statics), @"drive_instance": hexAddress(snapshot.drive),
          @"actor_manager": hexAddress(snapshot.manager), @"actor_list": hexAddress(snapshot.list),
          @"actor_items": hexAddress(snapshot.items) },
        @"local_skills": @{ @"result": resultName(snapshot.local_skills.result),
            @"stage": [NSString stringWithUTF8String:snapshot.local_skills.stage ?: "unknown"],
            @"manager_address": hexAddress(snapshot.local_skills.manager),
            @"summoner_manager_address": hexAddress(snapshot.local_skills.summoner_manager),
            @"all": skillList(&snapshot.local_skills.all), @"summoner": skillList(&snapshot.local_skills.summoner) },
        @"scope": @"Read-only actor, local skill, decision preview and minimap projection. Actor result covers baseline fields; extended fields have independent read flags. Skill-list result covers identity/cooldown; stock/slot/cast state have separate flags. Samples are not atomic. Zero cooldown does not imply castability. International 0.8.0 enemy portrait visibility is user-confirmed in one scene. Full five-enemy fog coverage, health/ward/monster behavior and precise alignment still require device verification. Automatic touch is not implemented." };
}
