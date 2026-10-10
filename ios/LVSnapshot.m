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
static NSDictionary *minimapSnapshot(LVMachReader *reader, uint64_t base, LVTargetSnapshot *snapshot,
                                      const LVMinimapSettings *settings) {
    LVMinimapGeometry geometry; lv_minimap_read(readTarget, (__bridge void *)reader, base, &geometry);
    LVMinimapFrame frame; lv_minimap_frame(snapshot, &geometry, settings, &frame);
    NSMutableArray *markers = [NSMutableArray new];
    for (size_t i = 0; i < frame.count; ++i) {
        LVMinimapMarker *m = &frame.markers[i];
        [markers addObject:@{ @"object_id": @(m->object_id), @"resource_id": @(m->resource_id),
            @"ordinal": @(m->ordinal), @"is_local": @(m->is_local != 0), @"u": @(m->u), @"v": @(m->v) }];
    }
    return @{ @"projection_ready": @(frame.ready != 0), @"reason": @(frame.reason),
        @"confirmed_enemy_hero_count": @(frame.confirmed_enemies), @"dead_enemy_count": @(frame.dead_enemies),
        @"missing_enemy_position_count": @(frame.missing_enemies), @"outside_map_enemy_count": @(frame.outside_enemies),
        @"duplicate_id_count": @(frame.duplicate_ids), @"local_camp": @(frame.local_camp),
        @"rotation_degrees": @(frame.rotation_degrees), @"manual_projection": @(frame.manual_projection != 0),
        @"markers": markers, @"alignment_device_verified": @NO,
        @"geometry": @{ @"ready": @(geometry.ready != 0), @"reason": @(geometry.reason),
            @"viewport_mode": @(geometry.viewport_mode != 0), @"full_map_showing": @(geometry.full_map_showing != 0),
            @"zoom_state": @(geometry.zoom_state), @"scale_x": @(geometry.scale_x), @"scale_z": @(geometry.scale_z),
            @"half_width": @(geometry.half_width), @"half_height": @(geometry.half_height) },
        @"scope": @"Current client-memory positions only. No fog-of-war freshness or visibility claim. Ordinary minimap projection uses recovered scale/half-size fields; screen rectangle and camp rotation require device alignment. No guessed extra enemies or last-position cache." };
}
NSDictionary *LVReadTargetSnapshot(LVMachReader *reader, NSDictionary *metadata, const LVConfig *config,
                                    const LVMinimapSettings *mapSettings) {
    NSDictionary *image = nil;
    id rawImages = metadata[@"images"];
    if ([rawImages isKindOfClass:NSArray.class]) {
        for (id item in rawImages) {
            if (![item isKindOfClass:NSDictionary.class]) continue;
            NSString *path = item[@"path"];
            if ([path isKindOfClass:NSString.class] &&
                [path hasSuffix:@"/Frameworks/UnityFramework.framework/UnityFramework"]) {
                image = item; break;
            }
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
    lv_target_snapshot(readTarget, (__bridge void *)reader, base, &snapshot);
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
        @"minimap": minimapSnapshot(reader, base, &snapshot, mapSettings),
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
