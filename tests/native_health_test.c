#include "LVTarget.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>

#define BASE UINT64_C(0x100000000)
#define HEAP UINT64_C(0x300000000)
static unsigned char heap[0x10000];
static uint64_t root, failure, mutation;
static unsigned checks, mutation_reads;
static LVTargetSnapshot snapshot;
static LVNativeHealthReport report;
static void check(int v) { assert(v); ++checks; }
static void put(uint64_t a,const void *p,size_t n) {
    assert(a>=HEAP && a-HEAP+n<=sizeof(heap)); memcpy(heap+a-HEAP,p,n);
}
static void q(uint64_t a,uint64_t v) { put(a,&v,8); }
static void u(uint64_t a,uint32_t v) { put(a,&v,4); }
static void b(uint64_t a,unsigned char v) { put(a,&v,1); }
static int reader(void *ctx,uint64_t a,void *p,size_t n) {
    (void)ctx;
    if(a==failure) { memset(p,255,n); return 0; }
    if(a==BASE+0x523cf28 && n==8) memcpy(p,&root,8);
    else if(a>=HEAP && a-HEAP+n<=sizeof(heap)) memcpy(p,heap+a-HEAP,n);
    else return 0;
    if(a==mutation && ++mutation_reads==2) ((unsigned char *)p)[0]^=1;
    return 1;
}
static void fixture(void) {
    memset(heap,0,sizeof(heap)); memset(&snapshot,0,sizeof(snapshot));
    root=HEAP; failure=mutation=mutation_reads=0;
    q(root+0x18,HEAP+0x100); b(HEAP+0x11e,1);
    snapshot.result=LV_TARGET_READY; snapshot.count=2;
    for(size_t i=0;i<2;++i) {
        uint64_t p=HEAP+0x1000+i*0x3000;
        LVTargetActor *a=&snapshot.actors[i];
        *a=(LVTargetActor){.visual=p,.managed=p+0x200,.native=p+0x400,.attribute=p+0x800,
            .values_ok=1,.classification_ok=1,.is_hero=1,.object_id_ok=1,.object_id=(uint32_t)i+1,
            .resource_id=10000+(int32_t)i,.camp=i ? 2 : 1,.health_ok=1,.health_fixed=123,
            .minimap_health_fraction_ok=1,.minimap_health_fraction_fixed=7777};
        q(p+0xa0,a->managed); q(a->managed+0x18,a->native); q(a->native+0xc0,a->attribute);
        u(a->native+0x18,a->object_id); u(a->native+0x2c,(uint32_t)a->resource_id); u(a->native+0x80,(uint32_t)a->camp);
        q(a->attribute+0x1f8,p+0x1000); q(a->attribute+0x200,p+0x1018); q(p+0x1010,p+0x1100);
        q(a->attribute+0x150,250*16384); q(p+0x1160,500*16384); q(p+0x1168,1000*16384);
    }
}
static void sample(void) { lv_target_native_health_read(reader,NULL,BASE,LV_NATIVE_ENGINE_UUID,&snapshot,&report); }
static void no_first(LVNativeHealthStatus status) {
    sample(); check(report.valid==1 && !snapshot.actors[0].native_health_fraction_ok &&
        snapshot.actors[0].native_health_status==status && !snapshot.actors[0].native_health_fraction_fixed);
}
int main(void) {
    fixture(); sample();
    check(!strcmp(report.reason,"ready") && report.profile_matches && report.sync_values && report.valid==2);
    check(snapshot.actors[0].native_current_health_fixed==250*16384 && snapshot.actors[0].native_max_health_fixed==1000*16384);
    check(snapshot.actors[0].native_health_fraction_fixed==4096);
    check(snapshot.actors[0].health_fixed==123 && snapshot.actors[0].minimap_health_fraction_fixed==7777);
    b(HEAP+0x11e,0); sample(); check(!report.sync_values && snapshot.actors[0].native_health_fraction_fixed==8192);
    b(HEAP+0x11e,255); sample(); check(report.sync_values && snapshot.actors[0].native_health_fraction_fixed==4096);
    /* UI cache absence and visibility do not enter the attribute reader. */
    snapshot.actors[0].minimap_health_fraction_ok=0; snapshot.actors[0].should_be_visible=0; sample();
    check(snapshot.actors[0].native_health_fraction_ok && snapshot.actors[0].native_health_fraction_fixed==4096);
    q(HEAP+0x1950,0); sample(); check(snapshot.actors[0].native_health_fraction_ok && !snapshot.actors[0].native_health_fraction_fixed);
    q(HEAP+0x1950,2000*16384); sample(); check(snapshot.actors[0].native_health_fraction_fixed==16384);
    q(HEAP+0x1950,INT64_MAX-1); q(HEAP+0x2168,INT64_MAX); sample();
    check(snapshot.actors[0].native_health_fraction_fixed==16383); /* no signed overflow */
    fixture(); q(HEAP+0x1950,UINT64_MAX); no_first(LV_HEALTH_INVALID);
    fixture(); q(HEAP+0x2168,0); no_first(LV_HEALTH_INVALID);
    fixture(); q(HEAP+0x2168,UINT64_MAX); no_first(LV_HEALTH_INVALID);
    fixture(); q(HEAP+0x2010,0); no_first(LV_HEALTH_UNREADABLE);
    fixture(); failure=HEAP+0x2168; no_first(LV_HEALTH_UNREADABLE);
    fixture(); failure=HEAP+0x1950; no_first(LV_HEALTH_UNREADABLE);
    fixture(); q(HEAP+0x19f8,HEAP+0x2001); no_first(LV_HEALTH_UNREADABLE);
    fixture(); q(HEAP+0x1a00,HEAP+0x1ff8); no_first(LV_HEALTH_INVALID);
    fixture(); q(HEAP+0x1a00,HEAP+0x2010); no_first(LV_HEALTH_INVALID);
    fixture(); q(HEAP+0x1a00,HEAP+0x2000+4097*8); no_first(LV_HEALTH_INVALID);
    fixture(); u(HEAP+0x1418,88); no_first(LV_HEALTH_CHANGED);
    fixture(); u(HEAP+0x142c,10099); no_first(LV_HEALTH_CHANGED);
    fixture(); u(HEAP+0x1480,4); no_first(LV_HEALTH_CHANGED);
    fixture(); q(HEAP+0x1218,HEAP+0x4400); no_first(LV_HEALTH_CHANGED);
    for(size_t i=0;i<8;++i) {
        const uint64_t a[]={0x10a0,0x1218,0x14c0,0x1418,0x19f8,0x2010,0x1950,0x2168};
        fixture(); mutation=HEAP+a[i]; no_first(LV_HEALTH_CHANGED);
    }
    fixture(); mutation=HEAP+0x11e; sample(); check(!report.valid && !strcmp(report.reason,"native_config_changed"));
    fixture(); mutation=BASE+0x523cf28; sample(); check(!report.valid && !snapshot.actors[0].native_health_fraction_ok);
    fixture(); mutation=HEAP+0x18; sample(); check(!report.valid && report.changed==2);
    fixture(); root=0; sample(); check(!report.valid && !strcmp(report.reason,"native_config_unreadable"));
    fixture(); q(HEAP+0x18,0); sample(); check(!report.valid);
    fixture(); failure=HEAP+0x11e; sample(); check(!report.valid);
    fixture(); sample(); lv_target_native_health_read(reader,NULL,BASE,"wrong",&snapshot,&report);
    check(!report.valid && !report.profile_matches && !snapshot.actors[0].native_health_fraction_ok);
    fixture(); lv_target_native_health_read(reader,NULL,BASE,NULL,&snapshot,&report); check(!report.valid);
    fixture(); lv_target_native_health_read(reader,NULL,UINT64_MAX,LV_NATIVE_ENGINE_UUID,&snapshot,&report); check(!report.valid);
    fixture(); lv_target_native_health_read(NULL,NULL,BASE,LV_NATIVE_ENGINE_UUID,&snapshot,&report); check(!report.valid);
    fixture(); snapshot.actors[0].is_hero=0; no_first(LV_HEALTH_INELIGIBLE);
    fixture(); snapshot.actors[1].object_id=1; sample(); check(!report.eligible && !report.valid);
    fixture(); snapshot.result=LV_TARGET_NOT_IN_BATTLE; sample(); check(!report.valid);
    fixture(); sample(); snapshot.result=LV_TARGET_CHANGED; sample(); check(!report.valid && !snapshot.actors[0].native_health_fraction_ok);
    fixture(); b(HEAP+0x11c,1); b(HEAP+0x11d,1); b(HEAP+0x126,1); sample();
    check(report.fog_config_ok && report.use_logic_network && report.logic_thread_enabled && report.fog_cut_enabled);
    fixture(); mutation=HEAP+0x126; sample(); check(report.valid==2 && !report.fog_config_ok);
    fixture(); failure=HEAP+0x126; sample(); check(report.valid==2 && !report.fog_config_ok);
    check(!strcmp(lv_native_health_status_name(LV_HEALTH_READY),"ready"));
    printf("Native health: %u checks passed\n",checks);
    return 0;
}
