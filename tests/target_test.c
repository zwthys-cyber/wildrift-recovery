#include "LVTarget.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define BASE UINT64_C(0x100000000)
#define CACHE UINT64_C(0x200000000)
#define HEAP UINT64_C(0x300000000)
typedef struct {
    uint64_t global;
    unsigned char *cache;
    unsigned char heap[0x40000];
    uint64_t fail;
    unsigned race, count_reads, reads, consistency_fail;
    uint64_t change_address, replacement;
    unsigned change_reads;
    unsigned race_entries, entries_reads;
} Fixture;
static void put(Fixture *f, uint64_t address, const void *data, size_t n) {
    if (address >= CACHE && address + n <= CACHE + 47894 * 8ULL)
        memcpy(f->cache + address - CACHE, data, n);
    else { assert(address >= HEAP && address + n <= HEAP + sizeof(f->heap));
           memcpy(f->heap + address - HEAP, data, n); }
}
static void q(Fixture *f, uint64_t address, uint64_t value) { put(f, address, &value, 8); }
static void d(Fixture *f, uint64_t address, int32_t value) { put(f, address, &value, 4); }
static void text(Fixture *f, uint64_t address, const char *s) { put(f, address, s, strlen(s) + 1); }
static int read_fixture(void *context, uint64_t address, void *out, size_t n) {
    Fixture *f = context; ++f->reads; assert(f->reads < 20000);
    if (address == f->fail) { memset(out, 0xff, n); return 0; }
    if (address == f->change_address && ++f->change_reads == 2) {
        assert(n == 8 || n == 4); memcpy(out, &f->replacement, n); return 1;
    }
    if (address == HEAP + 0xc000 && ++f->entries_reads == 2 && f->race_entries) {
        assert(n == 24); memcpy(out, f->heap + 0xc000, n);
        uint64_t changed = HEAP + 0x10600; memcpy(out, &changed, 8); return 1;
    }
    if (address == HEAP + 0x1018 && ++f->count_reads == 2) {
        if (f->consistency_fail) { memset(out, 0xff, n); return 0; }
        if (f->race) { int32_t changed = 1; assert(n == 4); memcpy(out, &changed, 4); return 1; }
    }
    if (address == BASE + 0x10a915f8 && n == 8) { memcpy(out, &f->global, n); return 1; }
    if (address >= CACHE && address + n <= CACHE + 47894 * 8ULL) {
        memcpy(out, f->cache + address - CACHE, n); return 1;
    }
    if (address >= HEAP && address + n <= HEAP + sizeof(f->heap)) {
        memcpy(out, f->heap + address - HEAP, n); return 1;
    }
    memset(out, 0xaa, n); return 0;
}
static void reset(Fixture *f) {
    memset(f->cache, 0, 47894 * 8); memset(f->heap, 0, sizeof(f->heap));
    f->global = CACHE; f->fail = f->race = f->count_reads = f->reads = f->consistency_fail = 0;
    f->change_address = f->replacement = f->change_reads = 0;
    f->race_entries = f->entries_reads = 0;
    q(f, CACHE + 37468 * 8ULL, HEAP);
    q(f, CACHE + 37473 * 8ULL, HEAP + 0x200);
    q(f, HEAP + 0x10, HEAP + 0x8001); q(f, HEAP + 0x18, HEAP + 0x8103);
    q(f, HEAP + 0x210, HEAP + 0x8021); q(f, HEAP + 0x218, HEAP + 0x8103);
    text(f, HEAP + 0x8001, "DriveEntryUnity"); text(f, HEAP + 0x8021, "FEVisi");
    text(f, HEAP + 0x8103, "FrameEngine.Visual");
    q(f, HEAP + 0xb8, HEAP + 0x400); q(f, HEAP + 0x2b8, HEAP + 0x600);
    q(f, HEAP + 0x400, HEAP + 0x800); q(f, HEAP + 0x630, HEAP + 0x2000);
    q(f, HEAP + 0x810, HEAP + 0xc00); q(f, HEAP + 0xc10, HEAP + 0x1000);
    q(f, HEAP + 0x1010, HEAP + 0x1400); d(f, HEAP + 0x1018, 2); q(f, HEAP + 0x1418, 2);
    for (unsigned i = 0; i < 2; ++i) {
        uint64_t visual = HEAP + 0x2000 + i * 0x200;
        uint64_t managed = HEAP + 0x3000 + i * 0x200;
        uint64_t native = HEAP + 0x4000 + i * 0x400;
        uint64_t attribute = HEAP + 0x5000 + i * 0x400;
        q(f, HEAP + 0x1420 + i * 8, visual); q(f, visual + 0xa0, managed);
        q(f, managed + 0x18, native); q(f, native + 0xc0, attribute);
        d(f, native + 0x2c, i ? 60001 : 10001); d(f, native + 0x30, i ? 9 : 2);
        d(f, native + 0x80, i ? 2 : 1);
        q(f, attribute + 0x150, i ? 599 * UINT64_C(16384) + 8192 : 1000 * UINT64_C(16384));
    }
}
static void skills(Fixture *f) {
    q(f, HEAP + 0x40d0, HEAP + 0xa000);
    q(f, HEAP + 0xa140, HEAP + 0xb000);
    q(f, HEAP + 0xa218, HEAP + 0xc000); q(f, HEAP + 0xa220, HEAP + 0xc018); d(f, HEAP + 0xa230, 8);
    q(f, HEAP + 0xb028, HEAP + 0xd000); q(f, HEAP + 0xb030, HEAP + 0xd010); d(f, HEAP + 0xb040, 8);
    for (unsigned i = 0; i < 3; ++i) {
        uint64_t skill = HEAP + 0x10000 + i * 0x600, node = HEAP + 0x20000 + i * 0x100;
        q(f, HEAP + 0xc000 + i * 8, skill);
        if (i < 2) q(f, HEAP + 0xd000 + i * 8, skill);
        d(f, skill + 0x20, 100 + i); d(f, skill + 0x38, i + 1);
        d(f, skill + 0x44, i == 0 ? 81110101 : (i == 1 ? 81120101 : 10101001));
        q(f, skill + 0x440, i == 2 ? 0 : node); q(f, node + 0x20, 7 * UINT64_C(16384) + 4096);
        unsigned char locked = i == 1; put(f, node + 0x18, &locked, 1);
    }
    d(f, HEAP + 0x4018, -1); q(f, HEAP + 0x4020, HEAP + 0xe000);
    int64_t position[3] = {-9 * INT64_C(16384), 8192, 100 * INT64_C(16384)};
    put(f, HEAP + 0xe018, position, sizeof(position));
}
static void extended(Fixture *f) {
    reset(f); skills(f);
    q(f, HEAP + 0x101d0, HEAP + 0x22000);
    d(f, HEAP + 0x2201c, 2); d(f, HEAP + 0x22020, 2);
    q(f, HEAP + 0x10108, HEAP + 0x23000); d(f, HEAP + 0x23018, 0x21);
    d(f, HEAP + 0x104b0, 0x240);
    unsigned char one = 1; put(f, HEAP + 0x313f, &one, 1);
    put(f, HEAP + 0x3343, &one, 1); put(f, HEAP + 0x335b, &one, 1);
}
int main(void) {
    Fixture f = {0}; f.cache = calloc(47894, 8); assert(f.cache);
    LVTargetSnapshot s;
    reset(&f); assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_READY);
    assert(s.count == 2 && s.actors[0].is_local && !s.actors[1].is_local);
    assert(s.actors[0].resource_id == 10001 && s.actors[1].camp == 2);
    assert(s.actors[1].health_fixed == 599 * INT64_C(16384) + 8192);
    reset(&f); f.global = 0;
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_UNREADABLE && !s.count);
    reset(&f); q(&f, HEAP + 0x400, 0);
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_NOT_IN_BATTLE);
    reset(&f); text(&f, HEAP + 0x8001, "WrongEntryUnity");
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_LAYOUT_MISMATCH);
    reset(&f); d(&f, HEAP + 0x1018, -1);
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_LIMIT && !s.count);
    reset(&f); d(&f, HEAP + 0x1018, LV_TARGET_MAX_ACTORS + 1);
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_LIMIT);
    reset(&f); q(&f, HEAP + 0x1418, 1);
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_LAYOUT_MISMATCH);
    reset(&f); f.fail = HEAP + 0x5550;
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_PARTIAL);
    assert(s.count == 2 && !s.actors[1].health_ok && !s.actors[1].health_fixed);
    reset(&f); q(&f, HEAP + 0x630, 0);
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_PARTIAL && !s.local_native);
    reset(&f); f.race = 1;
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_CHANGED && !s.count);
    for (size_t i = 0; i < sizeof(s.actors); ++i) assert(!((unsigned char *)s.actors)[i]);
    reset(&f); q(&f, HEAP + 0x1428, UINT64_MAX);
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_PARTIAL && s.skipped == 1);
    assert(lv_target_snapshot(read_fixture, &f, UINT64_MAX, &s) == LV_TARGET_UNREADABLE);
    assert(lv_target_snapshot(NULL, &f, BASE, &s) == LV_TARGET_UNREADABLE);
    assert(lv_target_snapshot(read_fixture, &f, BASE, NULL) == LV_TARGET_UNREADABLE);
    reset(&f); skills(&f); assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_READY);
    assert(s.actors[0].object_id_ok && s.actors[0].object_id == UINT32_MAX);
    assert(s.actors[0].position_ok && s.actors[0].position_fixed[0] == -9 * INT64_C(16384));
    assert(s.local_skills.result == LV_TARGET_READY && s.local_skills.all.count == 3 && s.local_skills.summoner.count == 2);
    assert(s.local_skills.summoner.skills[0].resource_id == 81110101 && s.local_skills.summoner.skills[0].level == 1);
    assert(s.local_skills.all.skills[0].cooldown_fixed == 7 * INT64_C(16384) + 4096);
    assert(s.local_skills.all.skills[1].cd_locked && !s.local_skills.all.skills[1].cooldown_fixed);
    assert(s.local_skills.all.skills[2].cooldown_ok && !s.local_skills.all.skills[2].cooldown_fixed);
    reset(&f); skills(&f); q(&f, HEAP + 0x20020, (uint64_t)-16384);
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.skills[0].cooldown_ok && !s.local_skills.all.skills[0].cooldown_fixed);
    reset(&f); skills(&f); f.fail = HEAP + 0x20020;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_PARTIAL);
    assert(!s.local_skills.all.skills[0].cooldown_ok && !s.local_skills.all.skills[0].cooldown_fixed);
    reset(&f); skills(&f); d(&f, HEAP + 0xa230, 4);
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_LAYOUT_MISMATCH && !s.local_skills.all.count);
    reset(&f); skills(&f); q(&f, HEAP + 0xa220, HEAP + 0xc000 + (LV_TARGET_MAX_SKILLS + 1) * 8ULL);
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_LIMIT);
    reset(&f); skills(&f); q(&f, HEAP + 0xa220, HEAP + 0xb000);
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_LAYOUT_MISMATCH);
    reset(&f); skills(&f); q(&f, HEAP + 0xa218, 0); q(&f, HEAP + 0xa220, 0); d(&f, HEAP + 0xa230, 0);
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_READY && !s.local_skills.all.count);
    reset(&f); skills(&f); q(&f, HEAP + 0xc000, UINT64_MAX);
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_PARTIAL && s.local_skills.all.skipped == 1);
    reset(&f); skills(&f); f.change_address = HEAP + 0xa218; f.replacement = HEAP + 0xf000;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_CHANGED && !s.local_skills.all.count);
    reset(&f); skills(&f); f.change_address = HEAP + 0x40d0; f.replacement = HEAP + 0xf000;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.result == LV_TARGET_CHANGED && !s.local_skills.all.count && !s.local_skills.summoner.count);
    reset(&f); skills(&f); f.fail = HEAP + 0xe018;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(!s.actors[0].position_ok && !s.actors[0].position_fixed[0]);
    reset(&f); skills(&f); f.race = 1;
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_CHANGED && !s.local_skills.all.count);
    reset(&f); skills(&f); f.race_entries = 1;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(s.local_skills.all.result == LV_TARGET_CHANGED && !s.local_skills.all.count);
    reset(&f); skills(&f); f.consistency_fail = 1;
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_UNREADABLE);
    assert(!s.count && !s.local_skills.all.count && !s.local_skills.summoner.count);
    extended(&f); lv_target_snapshot(read_fixture, &f, BASE, &s);
    assert(s.actors[0].classification_ok && s.actors[0].is_hero && !s.actors[0].is_monster);
    assert(s.actors[1].classification_ok && s.actors[1].is_monster && s.actors[1].is_red_blue_buff);
    assert(s.local_skills.all.skills[0].stock_ok && s.local_skills.all.skills[0].stock_current == 2);
    assert(s.local_skills.all.skills[0].stock_maximum == 2);
    assert(s.local_skills.all.skills[0].slot_state_ok && s.local_skills.all.skills[0].slot_state == 0x21);
    assert(s.local_skills.all.skills[0].cast_state_ok && s.local_skills.all.skills[0].cast_state == 0x240);
    extended(&f); f.fail = HEAP + 0x2201c; lv_target_snapshot(read_fixture, &f, BASE, &s);
    assert(!s.local_skills.all.skills[0].stock_ok && !s.local_skills.all.skills[0].stock_current);
    extended(&f); f.fail = HEAP + 0x22020; lv_target_snapshot(read_fixture, &f, BASE, &s);
    assert(!s.local_skills.all.skills[0].stock_ok && !s.local_skills.all.skills[0].stock_current);
    extended(&f); q(&f, HEAP + 0x101d0, 0); lv_target_snapshot(read_fixture, &f, BASE, &s);
    assert(!s.local_skills.all.skills[0].stock_ok);
    extended(&f); f.change_address = HEAP + 0x101d0; f.replacement = HEAP + 0x24000;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(!s.local_skills.all.skills[0].stock_ok);
    extended(&f); f.change_address = HEAP + 0x10108; f.replacement = HEAP + 0x24000;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(!s.local_skills.all.skills[0].slot_state_ok && !s.local_skills.all.skills[0].slot_state);
    extended(&f); f.fail = HEAP + 0x104b0; lv_target_snapshot(read_fixture, &f, BASE, &s);
    assert(!s.local_skills.all.skills[0].cast_state_ok && !s.local_skills.all.skills[0].cast_state);
    extended(&f); unsigned char bad = 2; put(&f, HEAP + 0x313f, &bad, 1);
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(!s.actors[0].classification_ok && !s.actors[0].is_hero);
    extended(&f); f.fail = HEAP + 0x3138; lv_target_snapshot(read_fixture, &f, BASE, &s);
    assert(!s.actors[0].classification_ok);
    extended(&f); f.change_address = HEAP + 0x3018; f.replacement = HEAP + 0x4800;
    assert(lv_target_snapshot(read_fixture, &f, BASE, &s) == LV_TARGET_PARTIAL);
    assert(!s.actors[0].values_ok && !s.actors[0].classification_ok && !s.actors[0].position_ok);
    extended(&f); f.change_address = HEAP + 0x4018; f.replacement = 27;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(!s.actors[0].values_ok && !s.actors[0].object_id_ok);
    extended(&f); f.change_address = HEAP + 0x1420; f.replacement = HEAP + 0x2800;
    lv_target_snapshot(read_fixture, &f, BASE, &s); assert(!s.actors[0].values_ok && !s.actors[0].classification_ok);
    /* Candidate coordinates are observations only. Do not substitute them
       for the independently recovered native FixTransform position. */
    extended(&f);
    int64_t last[3]={2*16384,0,-3*16384};put(&f,HEAP+0x5090,last,24);
    q(&f,HEAP+0x20f0,HEAP+0x25000);q(&f,HEAP+0x25018,HEAP+0x2000);q(&f,HEAP+0x25020,HEAP+0x3000);
    float logic[3]={4,0,-5},time=12;put(&f,HEAP+0x2502c,logic,12);put(&f,HEAP+0x25050,&time,4);
    q(&f,HEAP+0x4148,HEAP+0x4000);
    lv_target_snapshot(read_fixture,&f,BASE,&s);
    assert(s.actors[0].attribute_last_position_ok && !memcmp(s.actors[0].attribute_last_position,last,24));
    assert(s.actors[0].sync_logic_position_ok && s.actors[0].sync_logic_time==12 && !memcmp(s.actors[0].sync_logic_position,logic,12));
    assert(s.actors[0].host_position_ok && s.actors[0].host_object_id==UINT32_MAX && s.actors[0].host_position[0]==-9*16384);
    assert(s.actors[0].position_fixed[0]==-9*16384); /* candidate does not change the displayed source */
    f.fail=HEAP+0x5090;lv_target_snapshot(read_fixture,&f,BASE,&s);assert(!s.actors[0].attribute_last_position_ok);
    f.fail=0;q(&f,HEAP+0x25020,HEAP+0x3200);lv_target_snapshot(read_fixture,&f,BASE,&s);assert(!s.actors[0].sync_logic_position_ok);
    q(&f,HEAP+0x25020,HEAP+0x3000);time=NAN;put(&f,HEAP+0x25050,&time,4);
    lv_target_snapshot(read_fixture,&f,BASE,&s);assert(!s.actors[0].sync_logic_position_ok);
    time=13;put(&f,HEAP+0x25050,&time,4);logic[0]=INFINITY;put(&f,HEAP+0x2502c,logic,12);
    lv_target_snapshot(read_fixture,&f,BASE,&s);assert(!s.actors[0].sync_logic_position_ok);
    f.change_address=HEAP+0x4148;f.replacement=HEAP+0x4400;
    lv_target_snapshot(read_fixture,&f,BASE,&s);assert(!s.actors[0].host_position_ok);
    free(f.cache); puts("target reader: 46 scenarios passed"); return 0;
}
