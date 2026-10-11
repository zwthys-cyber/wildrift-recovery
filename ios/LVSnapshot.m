#import "LVSnapshot.h"
#import "LVMachReader.h"
#include "LVTarget.h"
#include "LVSmitePreview.h"
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
                                      const LVMinimapSettings *settings, const LVMinimapHealthReport *health,
                                      const LVNativeHealthReport *nativeHealth, const LVLogicPositionReport *logic) {
    LVMinimapGeometry geometry; lv_minimap_read(readTarget, (__bridge void *)reader, base, &geometry);
    if (!geometry.ready && [@(geometry.reason) isEqual:@"geometry_changed"])
        lv_minimap_read(readTarget, (__bridge void *)reader, base, &geometry);
    LVMinimapFrame frame; lv_minimap_frame(snapshot, &geometry, settings, &frame);
    size_t rawCount=0;
    for(size_t i=0;i<frame.count;++i) rawCount+=!frame.markers[i].is_local;
    size_t rawUnplaced=frame.missing_enemies+frame.outside_enemies;
    unsigned rawReady=frame.ready;
    NSMutableArray *markers = [NSMutableArray new];
    for (size_t i = 0; i < frame.count; ++i) {
        LVMinimapMarker *m = &frame.markers[i];
        [markers addObject:@{ @"object_id": @(m->object_id), @"resource_id": @(m->resource_id),
            @"ordinal": @(m->ordinal), @"is_local": @(m->is_local != 0), @"u": @(m->u), @"v": @(m->v),
            @"health_fraction_read_ok": @(m->health_fraction_ok != 0), @"health_fraction": @(m->health_fraction),
            @"health_source": m->health_source==1 ? @"native_attributes" :
                (m->health_source==2 ? @"game_minimap_cached_percent" : @"unavailable"),
            @"position_source": m->position_source==2 ? @"native_logic_transform" : @"sync_transform",
            @"edge_clamped": @(m->edge_clamped != 0) }];
    }
    return @{ @"projection_ready": @(frame.ready != 0), @"reason": @(frame.reason),
        @"confirmed_enemy_hero_count": @(frame.confirmed_enemies), @"dead_enemy_count": @(frame.dead_enemies),
        @"missing_enemy_position_count": @(frame.missing_enemies), @"outside_map_enemy_count": @(frame.outside_enemies),
        @"duplicate_id_count": @(frame.duplicate_ids), @"local_camp": @(frame.local_camp),
        @"rotation_degrees": @(frame.rotation_degrees), @"manual_projection": @(frame.manual_projection != 0),
        @"current_projection_ready": @(rawReady != 0), @"current_enemy_marker_count": @(rawCount),
        @"current_unplaced_enemy_count": @(rawUnplaced),
        @"edge_clamped_enemy_count": @(frame.edge_clamped_enemies),
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
            @"eligible_hero_count": @(logic->eligible), @"valid_position_count": @(logic->valid),
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
        if(a->classification_ok && a->is_hero) record[@"coordinate_candidates"]=positionCandidates(a);
        if(a->classification_ok && a->is_hero) {
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
        @"snapshot_read_attempts": @(attempts),
        @"minimap": minimapSnapshot(reader, base, &snapshot, mapSettings, &health, &nativeHealth, &logic),
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
        @"scope": @"Read-only actor, local skill, decision preview and minimap projection. Actor result covers baseline fields; extended fields have independent read flags. Skill-list result covers identity/cooldown; stock/slot/cast state have separate flags. Samples are not atomic. Zero cooldown does not imply castability. Prior 0.6.0 information HUD behavior has user confirmation; new minimap alignment is device-unverified. Automatic touch is not implemented." };
}
