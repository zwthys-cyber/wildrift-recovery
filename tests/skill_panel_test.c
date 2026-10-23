#include "LVSkillPanel.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
#define HEAP UINT64_C(0x300000000)
static unsigned char heap[0x140000];
static LVTargetSnapshot snapshot;
static LVSkillPanel panel;
static uint64_t failure,mutation,replacement;
static unsigned mutation_reads,change_on,checks,reads;
static void check(int value){assert(value);++checks;}
static void put(uint64_t a,const void *p,size_t n){assert(a>=HEAP && a-HEAP+n<=sizeof(heap));memcpy(heap+a-HEAP,p,n);}
static void q(uint64_t a,uint64_t v){put(a,&v,8);}
static void d(uint64_t a,int32_t v){put(a,&v,4);}
static void byte(uint64_t a,unsigned char v){put(a,&v,1);}
static int reader(void *ctx,uint64_t a,void *out,size_t n) {
    (void)ctx;++reads;assert(reads<100000);
    if(a==failure){memset(out,255,n);return 0;}
    if(a<HEAP || a-HEAP+n>sizeof(heap))return 0;
    memcpy(out,heap+a-HEAP,n);
    if(a==mutation && ++mutation_reads==change_on){assert(n>=4);memcpy(out,&replacement,n>=8?8:4);}
    return 1;
}
static void vector(uint64_t header,uint64_t entries,size_t count) {
    q(header,entries);q(header+8,entries+count*8);d(header+0x18,count?8:0);
}
static void actor(size_t i,int camp,int local) {
    uint64_t b=HEAP+i*0x10000;
    LVTargetActor *a=&snapshot.actors[i];
    *a=(LVTargetActor){.visual=b,.managed=b+0x200,.native=b+0x400,.object_id=(uint32_t)i+1,
        .resource_id=10001+(int32_t)i,.values_ok=1,.classification_ok=1,.is_hero=1,
        .object_id_ok=1,.camp=camp,.is_local=local};
    q(a->visual+0xa0,a->managed);q(a->managed+0x18,a->native);byte(a->managed+0x13f,1);
    d(a->native+0x18,(int32_t)a->object_id);d(a->native+0x2c,a->resource_id);d(a->native+0x80,camp);
    q(a->native+0xd0,b+0x800);q(b+0x940,b+0xb00);
    vector(b+0xa18,b+0xc00,3);vector(b+0xb28,b+0xd00,1);
    for(size_t j=0;j<3;++j) {
        uint64_t skill=b+0x2000+j*0x600,slot=b+0xa000+j*0x100,node=b+0xc000+j*0x100;
        q(b+0xc00+j*8,skill);if(j==2)q(b+0xd00,skill);
        q(skill+0x108,slot);q(slot+0x98,skill);q(slot+0xb0,a->native);
        d(slot+0xb8,j==0?1:(j==1?3:5));
        d(skill+0x20,100+(int32_t)j);d(skill+0x44,10101001+(int32_t)j);d(skill+0x38,j==1?0:1);
        q(skill+0x440,node);byte(node+0x18,0);q(node+0x20,(j==0?9:(j==1?0:60))*16384);
    }
}
static void setup(void) {
    memset(heap,0,sizeof(heap));memset(&snapshot,0,sizeof(snapshot));
    failure=mutation=replacement=mutation_reads=reads=0;change_on=2;
    snapshot.result=LV_TARGET_READY;snapshot.count=4;
    actor(0,1,1);actor(1,2,0);actor(2,1,0);actor(3,0,0);
    snapshot.actors[3].is_hero=0;snapshot.actors[3].is_monster=1;
}
static void sample(void){reads=0;lv_skill_panel_read(reader,NULL,&snapshot,1,&panel);}
static LVPanelHero *enemy(void){assert(panel.count);return &panel.heroes[0];}
int main(void) {
    uint64_t b=HEAP+0x10000,skill=b+0x2000,slot=b+0xa000,node=b+0xc000;
    setup();lv_skill_panel_read(reader,NULL,&snapshot,0,&panel);check(!panel.enabled && !panel.count && !reads);
    sample();check(panel.count==1 && panel.result==LV_TARGET_READY && enemy()->count==3);
    check(enemy()->object_id==2 && enemy()->skills[0].slot_index==1 && !enemy()->skills[0].summoner);
    check(enemy()->skills[0].cooldown_ok && enemy()->skills[0].cooldown_fixed==9*16384);
    check(enemy()->skills[1].level==0 && enemy()->skills[2].summoner && enemy()->skills[2].slot_index==5);
    q(node+0x20,3*16384);sample();check(enemy()->skills[0].cooldown_fixed==3*16384);
    q(node+0x20,0);sample();check(enemy()->skills[0].cooldown_ok && !enemy()->skills[0].cooldown_fixed);
    q(node+0x20,(uint64_t)-16384);sample();check(enemy()->skills[0].cooldown_ok && !enemy()->skills[0].cooldown_fixed);
    byte(node+0x18,255);sample();check(enemy()->skills[0].locked && enemy()->skills[0].cooldown_ok);
    setup();q(skill+0x440,0);sample();check(enemy()->skills[0].cooldown_ok && !enemy()->skills[0].cooldown_fixed);
    setup();failure=node+0x20;sample();check(!enemy()->skills[0].cooldown_ok && !enemy()->skills[0].cooldown_fixed);
    setup();mutation=skill+0x440;replacement=node+0x100;sample();check(!enemy()->skills[0].cooldown_ok);
    setup();q(skill+0x108,0);sample();check(enemy()->count==2); /* Passive/no slot. */
    setup();q(slot+0x98,skill+0x600);sample();check(enemy()->count==2); /* Replaced skill. */
    setup();q(slot+0xb0,HEAP+0x400);sample();check(enemy()->count==2 && enemy()->unavailable==1);
    setup();d(slot+0xb8,-1);sample();check(enemy()->count==2);
    setup();d(slot+0xb8,32);sample();check(enemy()->count==2);
    setup();d(skill+0x38,-1);sample();check(enemy()->count==2);
    setup();d(skill+0x44,0);sample();check(enemy()->count==2);
    setup();mutation=skill+0x20;replacement=999;sample();check(enemy()->count==2);
    setup();mutation=slot+0x98;replacement=skill+0x600;sample();check(enemy()->count==2);
    setup();mutation=b+0xc00;replacement=skill+0x600;sample();check(!enemy()->count && enemy()->result==LV_TARGET_CHANGED);
    setup();mutation=b+0x4d0;replacement=b+0x900;sample();check(!enemy()->count && enemy()->result==LV_TARGET_CHANGED);
    setup();mutation=b+0x418;replacement=999;sample();check(!enemy()->count && enemy()->result==LV_TARGET_CHANGED);
    setup();mutation=HEAP+0x418;replacement=999;sample();check(!panel.count && panel.result==LV_TARGET_CHANGED);
    setup();d(b+0xa30,4);sample();check(enemy()->count==1 && enemy()->result==LV_TARGET_PARTIAL);
    setup();vector(b+0xa18,b+0xc00,LV_TARGET_MAX_SKILLS+1);sample();check(enemy()->count==1);
    setup();q(b+0xc08,skill);sample();check(enemy()->count==1); /* Duplicate vector rejected. */
    setup();d(b+0xa1c,0);q(b+0xa18,b+0xc18);q(b+0xa20,b+0xc00);sample();check(enemy()->result==LV_TARGET_PARTIAL);
    setup();d(b+0xa1c,0);vector(b+0xa18,b+0xc00,0);sample();check(enemy()->count==1);
    setup();q(b+0x940,0);sample();check(enemy()->count==3 && enemy()->result==LV_TARGET_PARTIAL);
    setup();d(b+0xa1b8,1);sample(); /* Second active skill shares an index: no false zero cooldown. */
    check(enemy()->count==2 && enemy()->skills[0].ambiguous && !enemy()->skills[0].cooldown_ok);
    setup();snapshot.actors[1].camp=1;sample();check(!panel.count);
    setup();snapshot.actors[1].object_id=1;sample();check(!panel.count);
    setup();snapshot.actors[2].is_local=1;sample();check(!panel.count);
    setup();snapshot.actors[0].is_local=0;sample();check(!panel.count);
    setup();snapshot.result=LV_TARGET_CHANGED;sample();check(!panel.count);
    setup();snapshot.count=LV_TARGET_MAX_ACTORS+1;sample();check(!panel.count);
    setup();snapshot.count=19;
    for(size_t i=1;i<19;++i)actor(i,2,0);
    sample();check(panel.count==LV_PANEL_MAX_HEROES && panel.truncated && panel.result==LV_TARGET_PARTIAL);
    for(size_t i=1;i<panel.count;++i)check(panel.heroes[i-1].object_id<panel.heroes[i].object_id);
    setup();vector(b+0xa18,b+0xc00,17);
    for(size_t j=3;j<17;++j) {
        uint64_t n=b+0x2000+j*0x600,sl=b+0xa000+j*0x100,cd=b+0xc000+j*0x100;
        q(b+0xc00+j*8,n);q(n+0x108,sl);q(sl+0x98,n);q(sl+0xb0,b+0x400);d(sl+0xb8,(int32_t)j+5);
        d(n+0x20,100+(int32_t)j);d(n+0x44,10101001+(int32_t)j);d(n+0x38,1);q(n+0x440,cd);
    }
    sample();check(enemy()->count==LV_PANEL_MAX_SKILLS && enemy()->truncated);
    setup();snapshot.drive_statics=HEAP+0xf000;snapshot.drive=HEAP+0xf100;q(snapshot.drive_statics,snapshot.drive);
    snapshot.list=HEAP+0xf200;snapshot.items=HEAP+0xf300;snapshot.reported_count=4;
    d(snapshot.list+0x18,4);q(snapshot.list+0x10,snapshot.items);mutation=snapshot.list+0x18;replacement=5;
    sample();check(!panel.count && panel.result==LV_TARGET_CHANGED);
    setup();snapshot.count=0;sample();check(!panel.count);
    lv_skill_panel_read(NULL,NULL,NULL,1,&panel);check(!panel.count);
    printf("Enemy skill panel: %u checks passed\n",checks);return 0;
}
