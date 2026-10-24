#include "LVMonsterRespawn.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#define BASE UINT64_C(0x100000000)
#define HEAP UINT64_C(0x300000000)
static unsigned char memory[0x80000];
static LVTargetSnapshot snapshot;
static LVMonsterRespawnReport report;
static uint64_t failure,mutation,replacement,global_root;
static unsigned reads,mutation_reads,checks;
static void put(uint64_t a,const void *p,size_t n){assert(a>=HEAP && a-HEAP+n<=sizeof(memory));memcpy(memory+a-HEAP,p,n);}
static void q(uint64_t a,uint64_t n){put(a,&n,8);}
static void d(uint64_t a,int32_t n){put(a,&n,4);}
static void b(uint64_t a,unsigned char n){put(a,&n,1);}
static void check_at(int x,int line){if(!x)fprintf(stderr,"Respawn check failed at %d\n",line);assert(x);++checks;}
#define check(x) check_at((x),__LINE__)
static int reader(void *context,uint64_t a,void *p,size_t n) {
    (void)context;++reads;assert(reads<20000);
    if(a==failure)return 0;
    if(a==BASE+LV_TARGET_CLASS_CACHE_OFFSET){uint64_t v=HEAP;memcpy(p,&v,8);return 1;}
    if(a==BASE+LV_MINIMAP_CONTROLLER_CLASS_GLOBAL){memcpy(p,&global_root,8);return 1;}
    if(a<HEAP || a-HEAP+n>sizeof(memory))return 0;
    memcpy(p,memory+a-HEAP,n);
    if(a==mutation && ++mutation_reads==2)memcpy(p,&replacement,n<8?n:8);
    return 1;
}
static void cls(unsigned i,const char *name,const char *ns) {
    /* Runtime class names and namespace strings need not be 8-byte aligned. */
    uint64_t c=HEAP+0x50000+i*0x200,a=HEAP+0x51003+i*0x80,z=HEAP+0x51805+i*0x80;
    q(c+0x10,a);q(c+0x18,z);put(a,name,strlen(name)+1);put(z,ns,strlen(ns)+1);
}
static void setup(void) {
    memset(memory,0,sizeof(memory));memset(&snapshot,0,sizeof(snapshot));snapshot.result=LV_TARGET_READY;
    failure=mutation=replacement=global_root=reads=mutation_reads=0;
    cls(0,"UIMainBattleMiniMapCtrl","");cls(1,"MiniMapEntityCtrl","");cls(2,"UIMiniMapIconCtrl","");
    cls(3,"UIMiniIconAnchorCtrl","");cls(4,"MonsterAnchor","FrameEngine.Logic");cls(5,"AnchorDataData","FrameEngine.Interface");
    q(HEAP+LV_TYPE_MINIMAP_CONTROLLER*8ULL,HEAP+0x50000);
    q(HEAP+6772*8ULL,HEAP+0x50600);q(HEAP+35519*8ULL,HEAP+0x50800);q(HEAP+36514*8ULL,HEAP+0x50a00);
    q(HEAP+0x500b8,HEAP+0x53000);q(HEAP+0x53000,HEAP+0x54000);
    q(HEAP+0x54000,HEAP+0x50200);q(HEAP+0x54190,HEAP+0x55000);
    q(HEAP+0x55000,HEAP+0x50400);q(HEAP+0x55088,HEAP+0x56000);
    q(HEAP+0x56018,HEAP+0x57000);q(HEAP+0x57018,2);d(HEAP+0x56024,10);
    d(HEAP+0x57020,123);d(HEAP+0x57028,7);q(HEAP+0x57030,HEAP+0x60000);
    d(HEAP+0x57038,-1);
    q(HEAP+0x60000,HEAP+0x50600);b(HEAP+0x600c0,1);b(HEAP+0x600c1,1);d(HEAP+0x601e8,1);
    q(HEAP+0x601c8,HEAP+0x58000);q(HEAP+0x58000,HEAP+0x50800);
    q(HEAP+0x58010,HEAP+0x5a000);q(HEAP+0x58018,HEAP+0x5a000);q(HEAP+0x58060,HEAP+0x59000);
    q(HEAP+0x59000,HEAP+0x50a00);q(HEAP+0x59010,HEAP+0x5b000);q(HEAP+0x59018,HEAP+0x5b000);
    q(HEAP+0x5a068,90*16384);d(HEAP+0x5b1a0,2);d(HEAP+0x5b1a4,0);
    /* +160 is a vector-of-positions header, not three coordinates. */
    q(HEAP+0x5b160,HEAP+0x61000);q(HEAP+0x5b168,HEAP+0x61018);d(HEAP+0x5b178,24);
    q(HEAP+0x5b128,(uint64_t)(-10*INT64_C(16384)));q(HEAP+0x5b138,20*16384);
}
static void sample(void){reads=0;lv_monster_respawn_read(reader,NULL,BASE,LV_TARGET_UUID,&snapshot,1,&report);}
int main(void) {
    setup();sample();check(report.count==1 && !strcmp(report.reason,"ready"));
    setup();cls(1,"MiniMapEntityCtrlExtra","");sample();
    check(!report.count && !strcmp(report.reason,"map_entity_unavailable"));
    setup();cls(1,"MiniMapEntityCtrl","OtherNamespace");sample();
    check(!report.count && !strcmp(report.reason,"map_entity_unavailable"));
    setup();q(HEAP+0x50210,0x42);sample();check(!report.count);
    setup();failure=HEAP+0x51083;sample();check(!report.count);
    setup();q(HEAP+0x50218,(UINT64_C(1)<<48)-1);sample();check(!report.count);
    setup();sample();
    setup();q(HEAP+LV_TYPE_MINIMAP_CONTROLLER*8ULL,0);global_root=HEAP+0x50000;sample();
    check(report.count==1 && report.class_root_fallbacks==1);
    global_root=HEAP+0x50200;sample();check(!report.count && !strcmp(report.reason,"map_controller_class_unavailable"));
    setup();q(HEAP+0x55088,0);sample();check(!report.count && !strcmp(report.reason,"anchor_dictionary_unavailable"));
    setup();sample();
    check(report.timers[0].anchor_id==7 && report.timers[0].poi_type==2 && report.timers[0].remaining_fixed==90*16384);
    check(report.timers[0].position_fixed[0]==-10*16384 && report.timers[0].position_fixed[2]==20*16384);
    q(HEAP+0x5a068,89*16384);sample();check(report.timers[0].remaining_fixed==89*16384);
    setup();lv_monster_respawn_read(reader,NULL,BASE,LV_TARGET_UUID,&snapshot,0,&report);check(!report.count && !reads);
    setup();lv_monster_respawn_read(reader,NULL,BASE,"wrong-profile",&snapshot,1,&report);check(!report.count && !reads);
    setup();snapshot.result=LV_TARGET_NOT_IN_BATTLE;sample();check(!report.count && !reads);
    setup();lv_monster_respawn_read(reader,NULL,UINT64_MAX,LV_TARGET_UUID,&snapshot,1,&report);check(!report.count && !reads);
    for(int state=0;state<6;++state)if(state!=1){setup();d(HEAP+0x601e8,state);sample();check(!report.count);}
    setup();b(HEAP+0x600c0,0);sample();check(!report.count);
    setup();b(HEAP+0x600c1,0);sample();check(!report.count);
    setup();b(HEAP+0x600c8,1);sample();check(!report.count);
    setup();d(HEAP+0x5b1a0,1);sample();check(!report.count); /* Fruit is not a combat monster. */
    setup();d(HEAP+0x5b1a4,1);sample();check(!report.count); /* Building anchor. */
    setup();q(HEAP+0x5a068,0);sample();check(!report.count);
    setup();q(HEAP+0x5a068,UINT64_MAX);sample();check(!report.count);
    setup();q(HEAP+0x5a068,3601*16384);sample();check(!report.count);
    setup();q(HEAP+0x5b128,10000*16384);sample();check(!report.count);
    setup();q(HEAP+0x58060,0);sample();check(!report.count);
    setup();q(HEAP+0x58010,HEAP+0x5a008);sample();check(!report.count);
    setup();q(HEAP+0x59018,HEAP+0x5b008);sample();check(!report.count);
    setup();mutation=HEAP+0x59000;replacement=HEAP+0x50800;sample();check(!report.count);
    setup();q(HEAP+0x60000,HEAP+0x50400);sample();check(!report.count);
    setup();failure=HEAP+0x5a068;sample();check(!report.count);
    setup();failure=HEAP+0x57020;sample();check(!report.count && !strcmp(report.reason,"anchor_entries_unreadable"));
    setup();mutation=HEAP+0x56024;replacement=11;sample();check(!report.count && !strcmp(report.reason,"anchor_collection_changed"));
    setup();mutation=HEAP+0x601c8;replacement=HEAP+0x58008;sample();check(!report.count);
    setup();mutation=HEAP+0x5b1a0;replacement=3;sample();check(!report.count);
    setup();q(HEAP+0x57018,513);sample();check(!report.count);
    setup();d(HEAP+0x57038,124);d(HEAP+0x57040,8);q(HEAP+0x57048,HEAP+0x60000);sample();
    check(!report.count && report.duplicates==1);
    setup();d(HEAP+0x57020,-1);sample();check(!report.count); /* Dictionary tombstone. */
    printf("Monster respawn: %u checks passed\n",checks);return 0;
}
