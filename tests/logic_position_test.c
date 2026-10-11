#include "LVTarget.h"
#include "LVMinimap.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>

#define BASE UINT64_C(0x100000000)
#define HEAP UINT64_C(0x350000000)
static unsigned char heap[0x20000];
static uint64_t desk,key,lookup,failure,mutation;
static unsigned mutation_reads,mutate_at,mutation_byte,checks;
static LVTargetSnapshot snapshot;
static LVLogicPositionReport report;
static LVMinimapFrame frame;
static void checked(int v,unsigned line) { if(!v) fprintf(stderr,"Logic position check failed at line %u\n",line); assert(v); ++checks; }
#define check(v) checked((v),__LINE__)
static void put(uint64_t a,const void *p,size_t n) {
    assert(a>=HEAP && a-HEAP+n<=sizeof(heap)); memcpy(heap+a-HEAP,p,n);
}
static void q(uint64_t a,uint64_t v) { put(a,&v,8); }
static void u(uint64_t a,uint32_t v) { put(a,&v,4); }
static uint64_t logic(size_t i) { return HEAP+0x10000+i*0x1000; }
static uint64_t node(unsigned id) { return HEAP+0x3000+id*0x100; }
static void position(size_t i,int64_t x,int64_t y,int64_t z) {
    int64_t p[]={x,y,z};
    for(size_t j=0;j<3;++j) { uint64_t v; memcpy(&v,&p[j],8); q(logic(i)+0x828+j*8,v^key); }
}
static int reader(void *ctx,uint64_t a,void *p,size_t n) {
    (void)ctx;
    if(a==failure) { memset(p,255,n); return 0; }
    if(a==BASE+0x523cf28 && n==8) memcpy(p,&desk,8);
    else if(a==BASE+0x523cf38 && n==8) memcpy(p,&key,8);
    else if(a==BASE+0x4b22700 && n==8) memcpy(p,&lookup,8);
    else if(a>=HEAP && a-HEAP+n<=sizeof(heap)) memcpy(p,heap+a-HEAP,n);
    else return 0;
    if(a==mutation && ++mutation_reads==mutate_at) { assert(mutation_byte<n); ((unsigned char *)p)[mutation_byte]^=8; }
    return 1;
}
static void fixture(void) {
    memset(heap,0,sizeof(heap)); memset(&snapshot,0,sizeof(snapshot));
    desk=HEAP; key=UINT64_C(0x8123456789abcdef); failure=mutation=mutation_reads=mutation_byte=0; mutate_at=2;
    /* Distinct resource and runtime roots. The 0.7.7 data-root path
       reaches resource tables whose actual +78 lookup is 0x37c868. */
    q(desk+0x10,HEAP+0x200); q(HEAP+0x218,HEAP+0x2200);
    q(HEAP+0x2f10,BASE+0x4ac9df8);
    q(desk+0x38,HEAP+0x100); q(HEAP+0x128,HEAP+0x800);
    q(HEAP+0x9e0,BASE+0x4b22650); lookup=BASE+0x32f2318;
    q(HEAP+0xa00,HEAP+0x2000); q(HEAP+0x2000,node(4));
    q(node(4)+8,node(2)); q(node(4)+0x10,node(5));
    q(node(2)+8,node(1)); q(node(2)+0x10,node(3)); q(node(5)+0x10,node(6));
    snapshot.result=LV_TARGET_READY; snapshot.count=6;
    for(size_t i=0;i<6;++i) {
        uint64_t p=HEAP+0x4000+i*0x1000;
        LVTargetActor *a=&snapshot.actors[i];
        *a=(LVTargetActor){.visual=p,.managed=p+0x200,.native=p+0x400,
            .values_ok=1,.classification_ok=1,.is_hero=1,.object_id_ok=1,.object_id=(uint32_t)i+1,
            .resource_id=10001+(int32_t)i,.camp=i?2:1,.is_local=i==0,
            .health_ok=1,.health_fixed=500*16384,.position_ok=1,.position_fixed={500*16384,0,500*16384},
            .fog_cut_state_ok=1,.fog_cut_disappear=1,.visual_state_ok=1,.should_be_visible=0,
            .native_health_fraction_ok=1,.native_health_fraction_fixed=8192};
        q(p+0xa0,a->managed);q(a->managed+0x18,a->native);
        u(a->native+0x18,a->object_id);u(a->native+0x2c,(uint32_t)a->resource_id);u(a->native+0x80,(uint32_t)a->camp);
        u(node((unsigned)i+1)+0x20,(unsigned)i+1);q(node((unsigned)i+1)+0x28,logic(i));
        u(logic(i)+0x14,a->object_id);u(logic(i)+0xc4,(uint32_t)a->resource_id);u(logic(i)+0x198,(uint32_t)a->camp);
        q(logic(i)+0x20,logic(i)+0x800);position(i,((int64_t)i-3)*16384,0,((int64_t)i-1)*16384);
    }
}
static void sample(void) { lv_target_logic_position_read(reader,NULL,BASE,LV_NATIVE_ENGINE_UUID,&snapshot,&report); }
static void map(void) {
    LVMinimapSettings s;lv_minimap_defaults(&s);
    LVMinimapGeometry g={.ready=1,.reason="ready",.scale_x=2,.scale_z=2,.half_width=100,.half_height=100};
    lv_minimap_frame(&snapshot,&g,&s,&frame);
}
static void first_failed(LVLogicPositionStatus s) {
    sample();if(report.valid!=5 || snapshot.actors[0].logic_position_status!=s)
        fprintf(stderr,"After %u checks: expected %s, actual %s; valid=%zu, reason=%s\n",checks,
            lv_logic_position_status_name(s),lv_logic_position_status_name(snapshot.actors[0].logic_position_status),report.valid,report.reason);
    check(report.valid==5 && !snapshot.actors[0].logic_position_ok &&
        snapshot.actors[0].logic_position_status==s && !snapshot.actors[0].logic_native);
}
int main(void) {
    fixture();sample();check(report.profile_matches && report.eligible==6 && report.valid==6 && !strcmp(report.reason,"ready"));
    check(report.desk==HEAP && report.frame_root==HEAP+0x100 && report.battle==HEAP+0x800 && report.manager==HEAP+0x9e0);
    check(report.manager_vtable_offset==0x4b22650 && report.lookup_method_offset==0x32f2318);
    fixture();failure=desk+0x10;sample();check(report.valid==6);
    for(size_t i=0;i<6;++i) check(snapshot.actors[i].logic_native==logic(i) &&
        snapshot.actors[i].logic_position_fixed[0]==((int64_t)i-3)*16384 &&
        snapshot.actors[i].logic_position_fixed[2]==((int64_t)i-1)*16384 &&
        snapshot.actors[i].position_fixed[0]==500*16384);
    map();check(frame.ready && frame.confirmed_enemies==5 && frame.count==5 && !frame.outside_enemies);
    check(frame.markers[0].position_source==2 && frame.markers[0].health_source==1 && frame.markers[0].health_fraction==.5);
    double before=frame.markers[0].u;position(1,10*16384,0,20*16384);sample();map();
    check(frame.markers[0].u>before && frame.markers[0].u==.6 && frame.markers[0].v==.3);
    /* An invalid new sample does not reuse that successfully drawn point. */
    position(1,500*16384,0,500*16384);sample();map();check(frame.count==4 && frame.outside_enemies==1);
    check(!snapshot.actors[1].logic_position_ok && report.invalid==1 && report.valid==5);
    fixture();key=0;for(size_t i=0;i<6;++i) position(i,0,0,0);sample();check(report.valid==6);
    fixture();position(0,-200*16384,200*16384,0);sample();check(report.valid==6);
    const int64_t bad[]={INT64_MIN,INT64_MAX,200*16384+1,-200*16384-1,-10000*16384};
    for(size_t i=0;i<sizeof(bad)/sizeof(*bad);++i) {fixture();position(0,bad[i],0,0);first_failed(LV_LOGIC_INVALID);}
    fixture();q(node(1)+0x28,0);first_failed(LV_LOGIC_NOT_FOUND);
    fixture();q(node(2)+8,0);first_failed(LV_LOGIC_NOT_FOUND);
    fixture();u(logic(0)+0x14,99);first_failed(LV_LOGIC_CHANGED);
    fixture();u(logic(0)+0xc4,10099);first_failed(LV_LOGIC_CHANGED);
    fixture();u(logic(0)+0x198,2);first_failed(LV_LOGIC_CHANGED);
    fixture();q(logic(0)+0x20,0);first_failed(LV_LOGIC_CHANGED);
    fixture();u(snapshot.actors[0].native+0x18,99);first_failed(LV_LOGIC_CHANGED);
    fixture();q(node(1)+0x28,UINT64_MAX);first_failed(LV_LOGIC_INVALID);
    fixture();q(node(1)+8,node(1));first_failed(LV_LOGIC_INVALID);
    fixture();q(node(1)+8,node(2));first_failed(LV_LOGIC_INVALID);
    fixture();q(node(1)+8,HEAP+1);first_failed(LV_LOGIC_INVALID);
    fixture();failure=logic(0)+0x828;first_failed(LV_LOGIC_UNREADABLE);
    fixture();failure=node(1);sample();check(report.valid==4 && report.unreadable==2 &&
        snapshot.actors[0].logic_position_status==LV_LOGIC_UNREADABLE && snapshot.actors[2].logic_position_ok);
    /* Reject a manager with a sync lookup or unknown virtual implementation. */
    fixture();lookup=BASE+0x1011a30;sample();check(!report.valid && !strcmp(report.reason,"logic_lookup_layout_mismatch"));
    fixture();lookup=BASE+0x1011910;sample();check(!report.valid && !strcmp(report.reason,"logic_lookup_layout_mismatch"));
    fixture();q(HEAP+0x9e0,BASE+0x4ac9df8);sample();check(!report.valid && !strcmp(report.reason,"logic_manager_unreadable"));
    fixture();failure=BASE+0x4b22700;sample();check(!report.valid && !strcmp(report.reason,"logic_manager_unreadable"));
    for(size_t i=0;i<2;++i) {
        uint32_t id=i ? UINT32_MAX : UINT32_C(0x80000000);
        fixture();snapshot.actors[5].object_id=id;u(snapshot.actors[5].native+0x18,id);
        u(logic(5)+0x14,id);u(node(6)+0x20,id);sample();check(report.valid==6);
    }
    fixture();q(HEAP+0x2000,HEAP+0x18000);
    for(size_t i=0;i<65;++i) { uint64_t p=HEAP+0x18000+i*0x60;u(p+0x20,77);q(p+8,i<64?p+0x60:0); }
    sample();check(!report.valid && report.invalid==6);
    for(size_t i=0;i<6;++i) {
        const uint64_t a[]={0x523cf28,0x523cf38,0x38,0x128,0xa00,0x10020};
        fixture();mutation=i<2 ? BASE+a[i] : HEAP+a[i];sample();
        check(!snapshot.actors[0].logic_position_ok && report.changed>0);
        if(i<5) check(!report.valid && !strcmp(report.reason,"logic_root_changed"));
    }
    fixture();mutation=logic(0)+0x14;first_failed(LV_LOGIC_CHANGED);
    fixture();mutation=logic(0)+0xc4;first_failed(LV_LOGIC_CHANGED);
    fixture();mutation=logic(0)+0x198;first_failed(LV_LOGIC_CHANGED);
    fixture();mutation=node(1);mutation_byte=0x20;first_failed(LV_LOGIC_CHANGED);
    fixture();desk=0;sample();check(!report.valid && !strcmp(report.reason,"logic_root_unreadable"));
    fixture();q(HEAP+0x128,0);sample();check(!report.valid);
    fixture();q(HEAP+0xa00,0);sample();check(!report.valid);
    fixture();q(HEAP+0x2000,0);sample();check(!report.valid && report.not_found==6);
    fixture();failure=BASE+0x523cf38;sample();check(!report.valid);
    fixture();mutation=BASE+0x4b22700;sample();check(!report.valid && !strcmp(report.reason,"logic_root_changed"));
    fixture();mutation=HEAP+0x9e0;sample();check(!report.valid && !strcmp(report.reason,"logic_root_changed"));
    fixture();snapshot.actors[1].object_id=1;sample();check(report.eligible==4 && report.valid==4);
    fixture();snapshot.actors[0].is_hero=0;first_failed(LV_LOGIC_INELIGIBLE);
    fixture();sample();snapshot.result=LV_TARGET_CHANGED;sample();check(!report.valid && !snapshot.actors[0].logic_position_ok);
    fixture();lv_target_logic_position_read(reader,NULL,BASE,"wrong",&snapshot,&report);check(!report.profile_matches && !report.valid);
    fixture();lv_target_logic_position_read(reader,NULL,BASE,NULL,&snapshot,&report);check(!report.valid);
    fixture();lv_target_logic_position_read(NULL,NULL,BASE,LV_NATIVE_ENGINE_UUID,&snapshot,&report);check(!report.valid);
    fixture();lv_target_logic_position_read(reader,NULL,UINT64_MAX,LV_NATIVE_ENGINE_UUID,&snapshot,&report);check(!report.valid);
    check(!strcmp(lv_logic_position_status_name(LV_LOGIC_READY),"ready"));
    printf("Logic position: %u checks passed\n",checks);return 0;
}
