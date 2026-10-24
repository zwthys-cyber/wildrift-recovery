#include "LVSkillPanel.h"
#include <assert.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
#define ENGINE UINT64_C(0x120000000)
#define HEAP UINT64_C(0x300000000)
static unsigned char heap[0x140000];
static LVTargetSnapshot snapshot;
static LVSkillPanel panel;
static uint64_t failure,mutation,replacement;
static unsigned mutation_reads,change_on,checks,reads;
static void check_at(int value,int line){if(!value)fprintf(stderr,"Skill check %u failed at line %d\n",checks+1,line);assert(value);++checks;}
#define check(value) check_at((value),__LINE__)
static void put(uint64_t a,const void *p,size_t n){assert(a>=HEAP && a-HEAP+n<=sizeof(heap));memcpy(heap+a-HEAP,p,n);}
static void q(uint64_t a,uint64_t v){put(a,&v,8);}
static void d(uint64_t a,int32_t v){put(a,&v,4);}
static void byte(uint64_t a,unsigned char v){put(a,&v,1);}
static int reader(void *ctx,uint64_t a,void *out,size_t n) {
    (void)ctx;++reads;assert(reads<100000);
    if(a==failure){memset(out,255,n);return 0;}
    if(a==ENGINE+0x523cf28 && n==8){uint64_t root=HEAP+0xf000;memcpy(out,&root,8);return 1;}
    if(a<HEAP || a-HEAP+n>sizeof(heap))return 0;
    memcpy(out,heap+a-HEAP,n);
    if(a==mutation && ++mutation_reads==change_on){memcpy(out,&replacement,n>=8?8:n);}
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
static void config_setup(void) {
    uint64_t b=HEAP+0x10000;
    q(HEAP+0xf018,HEAP+0xf100);byte(HEAP+0xf11e,1);
    q(b+0x818,b+0x400);q(b+0x478,b+0xe000);
    q(b+0xe078,b+0xe804);q(b+0xe080,b+0xe810);
    d(b+0xe804,10101001);d(b+0xe808,0);d(b+0xe80c,10101002);
    for(size_t j=0;j<3;++j)q(b+0xa090+j*0x100,b+0x2000+j*0x600);
}
static void classify(void) {
    reads=0;lv_skill_panel_classify(reader,NULL,ENGINE,LV_NATIVE_ENGINE_UUID,&snapshot,&panel);
}
static void classification_checks(void) {
    uint64_t b=HEAP+0x10000;
    setup();config_setup();sample();classify();
    check(enemy()->classification_ok && enemy()->ultimate_resource_id==10101002);
    check(enemy()->skills[0].role==LV_PANEL_REGULAR && enemy()->skills[0].configured_index==0);
    check(enemy()->skills[1].role==LV_PANEL_ULTIMATE && enemy()->skills[1].configured_index==2);
    check(enemy()->skills[2].role==LV_PANEL_SUMMONER);
    check(!lv_skill_panel_skill_visible(&enemy()->skills[0],1));
    check(lv_skill_panel_skill_visible(&enemy()->skills[0],0));
    check(lv_skill_panel_skill_visible(&enemy()->skills[1],1));
    check(lv_skill_panel_skill_visible(&enemy()->skills[2],1));
    check(!strcmp(lv_skill_panel_role_name(LV_PANEL_ULTIMATE),"ultimate"));
    /* Replaced current skill is classified by the checked default skill. */
    q(b+0xa090,b+0xf000);q(b+0xf108,b+0xa000);d(b+0xf020,900);d(b+0xf044,10101001);
    d(b+0x2044,99999999);sample();classify();check(enemy()->skills[0].role==LV_PANEL_REGULAR);
    setup();config_setup();d(b+0xe80c,10101001);sample();classify();
    check(!enemy()->classification_ok && enemy()->skills[0].role==LV_PANEL_UNKNOWN);
    check(lv_skill_panel_skill_visible(&enemy()->skills[0],1));
    setup();config_setup();q(b+0xa090,0);sample();classify();check(enemy()->skills[0].role==LV_PANEL_UNKNOWN);
    setup();config_setup();q(b+0x818,HEAP+0x400);sample();classify();check(!enemy()->classification_ok);
    setup();config_setup();sample();failure=b+0xe804;classify();check(!enemy()->classification_ok);
    setup();config_setup();sample();mutation=b+0xe080;replacement=b+0xe814;classify();
    check(!enemy()->classification_ok && enemy()->skills[1].role==LV_PANEL_UNKNOWN);
    setup();config_setup();sample();mutation=HEAP+0xf11e;replacement=0;mutation_reads=0;classify();
    check(!strcmp(panel.classification_reason,"engine_selector_changed") && !enemy()->classification_ok);
    setup();config_setup();sample();reads=0;
    lv_skill_panel_classify(reader,NULL,ENGINE,"wrong-profile",&snapshot,&panel);
    check(!reads && !enemy()->classification_ok && enemy()->skills[0].role==LV_PANEL_UNKNOWN);
    setup();config_setup();byte(HEAP+0xf11e,0);sample();classify();check(!enemy()->classification_ok);
    setup();snapshot.result=LV_TARGET_NOT_IN_BATTLE;sample();classify();
    check(!panel.count && !strcmp(panel.classification_reason,"snapshot_unavailable"));
}
static void native_setup(void) {
    uint64_t b=HEAP+0x10000,logic=b+0xf000,manager=b+0xe400;
    snapshot.actors[1].logic_native=logic;snapshot.actors[1].logic_position_ok=1;
    d(logic+0x14,2);d(logic+0xc4,snapshot.actors[1].resource_id);d(logic+0x198,2);
    q(logic+0x200,manager);
    q(manager+0x28,logic);q(manager+0x2d8,b+0xdc00);q(manager+0x2e0,b+0xdc10);
    for(size_t j=0;j<2;++j) {
        uint64_t n=b+0x4000+j*0x800,node=b+0xd800+j*0x80,wrapper=b+0xda00+j*0x20,cfg=b+0xdb00+j*0x20;
        q(b+0xdc00+j*8,n);q(n+0x580,n);q(n+0x590,node);
        q(n+0x668,wrapper);q(wrapper+8,cfg);d(cfg+0xc,10101001+(int32_t)j);
        q(node+0x18,(j?2:7)*16384);byte(node+0x10,0);
        q(node+0x20,(j?5:9)*16384);q(node+0x28,(j?1:3)*16384);
        q(b+0xc020+j*0x100,0);
    }
    /* Native summoner manager at logic hero +360 with its +60/+68 list;
       the single entry carries its resource word at +74. */
    uint64_t sn=b+0x5000,snode=b+0xde00;
    q(logic+0x360,b+0xe200);q(b+0xe260,b+0xdc40);q(b+0xe268,b+0xdc48);
    q(b+0xdc40,sn);q(sn+0x580,sn);q(sn+0x590,snode);
    d(sn+0x74,10101003);
    q(snode+0x18,4*16384);byte(snode+0x10,0);
    q(snode+0x20,12*16384);q(snode+0x28,8*16384);
}
static void summoner_setup(void) {
    uint64_t b=HEAP+0x10000;
    q(b+0xf360,0);q(b+0xe5c0,b+0xe000);q(b+0xe028,b+0xd400);q(b+0xe030,b+0xd418);
    vector(b+0xa18,b+0xc00,5);vector(b+0xb28,b+0xd00,3);
    const int32_t ids[]={10000001,81100101,81090101};
    for(size_t j=0;j<3;++j) {
        uint64_t sync=b+0x2c00+j*0x600,slot=b+0xa200+j*0x100,cd=b+0xc200+j*0x100;
        q(b+0xc10+j*8,sync);q(b+0xd00+j*8,sync);
        q(sync+0x108,slot);q(slot+0x98,sync);q(slot+0xb0,b+0x400);
        d(slot+0xb8,5+(int32_t)j);d(sync+0x20,102+(int32_t)j);d(sync+0x44,ids[j]);d(sync+0x38,1);
        q(sync+0x440,cd);q(cd+0x20,0);
        uint64_t n=b+0x6000+j*0x800,node=b+0xd000+j*0x80,wrapper=b+0xd200+j*0x20,cfg=b+0xd300+j*0x20;
        q(b+0xd400+j*8,n);q(n+0x580,n);q(n+0x590,node);
        /* Deliberately distinct config data: summoner GetSkill reads +74. */
        q(n+0x668,wrapper);q(wrapper+8,cfg);d(cfg+0xc,777);d(n+0x74,ids[j]);q(node+0x18,(j+1)*30*16384);
    }
}
static void native_sample(void) {
    reads=0;lv_skill_panel_native_cooldowns(reader,NULL,ENGINE,LV_NATIVE_ENGINE_UUID,&snapshot,&panel);
}
static void native_checks(void) {
    uint64_t b=HEAP+0x10000;
    setup();native_setup();sample();native_sample();
    check(enemy()->skills[0].logic_cooldown_ok && enemy()->skills[0].cooldown_fixed==7*16384);
    check(enemy()->skills[1].logic_cooldown_ok && enemy()->skills[1].cooldown_fixed==2*16384);
    check(enemy()->skills[0].logic_node_values_ok && enemy()->skills[0].logic_total_raw==9*16384
        && enemy()->skills[0].logic_start_raw==3*16384);
    check(enemy()->skills[1].logic_node_values_ok && enemy()->skills[1].logic_total_raw==5*16384
        && enemy()->skills[1].logic_start_raw==1*16384);
    check(enemy()->skills[2].logic_cooldown_ok && enemy()->skills[2].cooldown_fixed==4*16384);
    check(enemy()->skills[2].logic_node_values_ok && enemy()->skills[2].logic_total_raw==12*16384
        && enemy()->skills[2].logic_start_raw==8*16384);
    setup();native_setup();q(b+0xd818,0);sample();native_sample();
    check(enemy()->skills[0].logic_cooldown_ok && !enemy()->skills[0].cooldown_fixed);
    setup();native_setup();q(b+0xd818,(uint64_t)-12345);sample();native_sample();
    check(enemy()->skills[0].logic_remain_raw==-12345 && !enemy()->skills[0].cooldown_fixed);
    setup();native_setup();byte(b+0xd810,1);sample();native_sample();check(enemy()->skills[0].logic_cooldown_ok && enemy()->skills[0].locked);
    setup();native_setup();byte(b+0xd810,255);sample();native_sample();
    check(enemy()->skills[0].logic_cooldown_ok && enemy()->skills[0].locked); /* Original GetState treats any nonzero byte as locked. */
    setup();native_setup();q(b+0x4580,0);sample();native_sample();check(!enemy()->skills[0].logic_cooldown_ok);
    setup();native_setup();q(b+0xe428,HEAP+0x400);sample();native_sample();check(!enemy()->skills[0].logic_cooldown_ok);
    setup();native_setup();d(b+0xdb2c,10101001);sample();native_sample();
    check(!enemy()->skills[0].logic_cooldown_ok && !strcmp(enemy()->skills[0].logic_cooldown_reason,"skill_ambiguous"));
    setup();native_setup();sample();failure=b+0xd818;native_sample();check(!enemy()->skills[0].logic_cooldown_ok);
    setup();native_setup();sample();mutation=b+0x4590;replacement=b+0xd880;native_sample();
    check(!enemy()->skills[0].logic_cooldown_ok && !strcmp(enemy()->skills[0].logic_cooldown_reason,"identity_or_list_changed"));
    setup();native_setup();q(b+0xf360,0);sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"summoner_manager_unavailable"));
    setup();native_setup();q(b+0xe268,b+0xdc30);sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"summoner_list_unavailable"));
    /* The summoner list may carry null slots; GetSkill 1001d60 skips them. */
    setup();native_setup();q(b+0xdc40,0);q(b+0xdc48,b+0x5000);q(b+0xe268,b+0xdc50);sample();native_sample();
    check(enemy()->skills[2].logic_cooldown_ok && enemy()->skills[2].cooldown_fixed==4*16384);
    /* Original native counterpart of sync +140 is +1c0 with +28 list. */
    setup();native_setup();q(b+0xf360,0);q(b+0xe5c0,b+0xe800);q(b+0xe828,b+0xdc40);q(b+0xe830,b+0xdc48);
    sample();native_sample();
    check(enemy()->skills[2].logic_cooldown_ok && enemy()->skills[2].cooldown_fixed==4*16384);
    setup();native_setup();q(b+0xf360,0);q(b+0xe5c0,b+0xe800);q(b+0xe828,b+0xdc48);q(b+0xe830,b+0xdc40);
    sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"summoner_list_unavailable"));
    setup();native_setup();d(b+0x5074,10101001);sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"skill_not_found"));
    setup();native_setup();q(b+0xe268,b+0xdc50);q(b+0xdc48,b+0x5800);d(b+0x5874,10101003);sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"skill_ambiguous"));
    setup();native_setup();q(b+0x5590,0);sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"node_unavailable"));
    setup();native_setup();sample();mutation=b+0x5590;replacement=b+0xde80;native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"identity_or_list_changed"));
    setup();native_setup();sample();reads=0;
    lv_skill_panel_native_cooldowns(reader,NULL,ENGINE,"wrong-profile",&snapshot,&panel);
    check(!reads && !enemy()->skills[0].logic_cooldown_ok);
}
static void component_checks(void) {
    uint64_t b=HEAP+0x10000;
    setup();native_setup();summoner_setup();sample();native_sample();check(enemy()->count==5);
    for(size_t j=0;j<3;++j) {
        LVPanelSkill *k=&enemy()->skills[j+2];
        check(k->summoner && k->slot_index==(int32_t)j+5 && k->logic_cooldown_ok);
        check(k->cooldown_fixed==(int64_t)(j+1)*30*16384);
        check(!strcmp(k->logic_lookup_source,"manager_component_1c0"));
    }
    /* The same native skill may appear in two component lists. */
    setup();native_setup();summoner_setup();q(b+0xe058,b+0xd400);q(b+0xe060,b+0xd418);sample();native_sample();
    check(enemy()->skills[2].logic_cooldown_ok);
    /* Both secondary component lists are original GetSkill sources. */
    for(size_t off=0x58;off<=0xd8;off+=0x80) {
        setup();native_setup();summoner_setup();q(b+0xe028,0);q(b+0xe030,0);
        q(b+0xe000+off,b+0xd400);q(b+0xe008+off,b+0xd418);sample();native_sample();
        check(enemy()->skills[2].logic_cooldown_ok && enemy()->skills[4].logic_cooldown_ok);
    }
    /* A broken ordinary list does not block the independent component. */
    setup();native_setup();summoner_setup();q(b+0xe6e0,b+0xdc00-8);sample();native_sample();
    check(!enemy()->skills[0].logic_cooldown_ok && enemy()->skills[2].logic_cooldown_ok);
    /* The prior unproven native +140 route must never be used. */
    setup();native_setup();summoner_setup();q(b+0xe5c0,0);q(b+0xe540,b+0xe000);
    q(b+0xe060,b+0xd400);q(b+0xe068,b+0xd418);sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && enemy()->skills[0].logic_cooldown_ok);
    setup();native_setup();summoner_setup();d(b+0x6874,10000001);sample();native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"skill_ambiguous"));
    setup();native_setup();summoner_setup();sample();failure=b+0xd018;native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && enemy()->skills[3].logic_cooldown_ok);
    setup();native_setup();summoner_setup();sample();mutation=b+0xd400;replacement=b+0x7800;native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"identity_or_list_changed"));
    setup();native_setup();summoner_setup();sample();mutation=b+0xe5c0;replacement=b+0xe800;change_on=3;native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !strcmp(enemy()->skills[2].logic_cooldown_reason,"identity_or_list_changed"));
    setup();native_setup();summoner_setup();sample();native_sample();q(b+0xe5c0,0);native_sample();
    check(!enemy()->skills[2].logic_cooldown_ok && !enemy()->skills[2].cooldown_ok && !enemy()->skills[2].cooldown_fixed);
}
int main(void) {
    uint64_t b=HEAP+0x10000,skill=b+0x2000,slot=b+0xa000,node=b+0xc000;
    setup();lv_skill_panel_read(reader,NULL,&snapshot,0,&panel);check(!panel.enabled && !panel.count && !reads);
    sample();check(panel.count==1 && panel.result==LV_TARGET_READY && enemy()->count==3);
    check(enemy()->object_id==2 && enemy()->skills[0].slot_index==1 && !enemy()->skills[0].summoner);
    check(enemy()->skills[0].cooldown_ok && enemy()->skills[0].cooldown_fixed==9*16384);
    check(enemy()->skills[1].level==0 && enemy()->skills[2].summoner && enemy()->skills[2].slot_index==5);
    check(enemy()->skills[0].cd_node==node && enemy()->skills[0].node_values_ok);
    q(node+0x28,12*16384);q(node+0x30,100*16384);q(skill+0xa8,12*16384);q(skill+0xa0,7*16384);
    sample();check(enemy()->skills[0].total_fixed==12*16384 && enemy()->skills[0].start_fixed==100*16384);
    check(enemy()->skills[0].configured_cd_ok && enemy()->skills[0].cd1_fixed==12*16384 && enemy()->skills[0].cd2_fixed==7*16384);
    q(node+0x20,3*16384);sample();check(enemy()->skills[0].cooldown_fixed==3*16384);
    q(node+0x20,0);sample();check(enemy()->skills[0].cooldown_ok && !enemy()->skills[0].cooldown_fixed);
    q(node+0x20,(uint64_t)-16384);sample();check(enemy()->skills[0].cooldown_ok && !enemy()->skills[0].cooldown_fixed);
    byte(node+0x18,255);sample();check(enemy()->skills[0].locked && enemy()->skills[0].cooldown_ok);
    setup();q(skill+0x440,0);sample();check(!enemy()->skills[0].cooldown_ok && !enemy()->skills[0].cooldown_fixed);
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
    classification_checks();native_checks();component_checks();
    printf("Enemy skill panel: %u checks passed\n",checks);return 0;
}
