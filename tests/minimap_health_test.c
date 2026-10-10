#include "LVMinimap.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

/* Independently specified managed layout and native Entry<UInt32,object>.
   The fixture never evaluates recovered game methods or accepts unmapped data. */
typedef struct { uint64_t address; size_t size; unsigned char data[4096]; } Block;
static Block blocks[24]; static size_t count;
static unsigned checks, mutation_reads;
static uint64_t failure, mutation;
static LVTargetSnapshot snapshot;
static LVMinimapHealthReport report;
static void check(int v) { assert(v); ++checks; }
static void block(uint64_t a,size_t n) { assert(count<24 && n<=4096); blocks[count++]=(Block){.address=a,.size=n}; }
static void put(uint64_t a,const void *p,size_t n) {
    for(size_t i=0;i<count;++i) if(a>=blocks[i].address && a-blocks[i].address+n<=blocks[i].size) {
        memcpy(blocks[i].data+a-blocks[i].address,p,n); return;
    }
    assert(0);
}
static void q(uint64_t a,uint64_t v) { put(a,&v,8); }
static void u(uint64_t a,uint32_t v) { put(a,&v,4); }
static void b(uint64_t a,unsigned char v) { put(a,&v,1); }
static int reader(void *context,uint64_t a,void *p,size_t n) {
    (void)context;
    if(a==failure) { memset(p,255,n); return 0; }
    for(size_t i=0;i<count;++i) if(a>=blocks[i].address && a-blocks[i].address+n<=blocks[i].size) {
        memcpy(p,blocks[i].data+a-blocks[i].address,n);
        if(a==mutation && ++mutation_reads==2) ((unsigned char *)p)[0]^=1;
        return 1;
    }
    return 0;
}
static void cls(uint64_t a,uint64_t name,const char *text) {
    block(a,0x100); q(a+0x10,name); q(a+0x18,0x220100); put(name,text,strlen(text)+1);
}
static void fixture(void) {
    memset(blocks,0,sizeof(blocks)); count=0; failure=mutation=mutation_reads=0;
    memset(&snapshot,0,sizeof(snapshot)); snapshot.result=LV_TARGET_READY; snapshot.count=2;
    block(0x110a915f8,8); q(0x110a915f8,0x200000);
    block(0x200000+6780*8,8); block(0x200000+6835*8,8); block(0x220000,512);
    cls(0x230000,0x220000,"UIMainBattleMiniMapCtrl");
    cls(0x230100,0x220030,"MiniMapEntityCtrl");
    cls(0x230200,0x220050,"UIMiniMapIconCtrl");
    cls(0x230300,0x220070,"UIMiniIconHeroCtrl");
    q(0x200000+6835*8,0x230000); q(0x200000+6780*8,0x230300);
    block(0x240000,32); q(0x2300b8,0x240000); q(0x240000,0x250000);
    block(0x250000,0x200); q(0x250000,0x230100); q(0x250190,0x251000);
    block(0x251000,0x100); q(0x251000,0x230200); q(0x251080,0x252000);
    block(0x252000,0x100); q(0x252018,0x253000);
    block(0x253000,0x100); q(0x253018,2);
    for(size_t i=0;i<2;++i) {
        uint64_t icon=0x260000+i*0x1000, entry=0x253020+i*24;
        block(icon,0x210); q(icon,0x230300); q(icon+0x98,0x270000+i*0x1000);
        b(icon+0xc0,1); b(icon+0xc1,1); b(icon+0x1b4,1);
        u(icon+0x1c0,(uint32_t)i+4); q(icon+0x1a0,i ? 16384 : 4096); u(icon+0x200,0x41200000);
        u(entry,123+(uint32_t)i); u(entry+8,(uint32_t)i+4); q(entry+16,icon);
        snapshot.actors[i]=(LVTargetActor){.values_ok=1,.classification_ok=1,.is_hero=1,
            .object_id_ok=1,.object_id=(uint32_t)i+4,.visual=0x270000+i*0x1000};
    }
}
static void read_health(void) { lv_minimap_health_read(reader,NULL,0x100000000,&snapshot,&report); }
int main(void) {
    fixture(); read_health();
    check(!strcmp(report.reason,"ready") && report.matched==2 && report.enabled==2 && report.valid==2);
    check(snapshot.actors[0].minimap_health_fraction_ok && snapshot.actors[0].minimap_health_fraction_fixed==4096);
    check(snapshot.actors[1].minimap_health_fraction_ok && snapshot.actors[1].minimap_health_fraction_fixed==16384);
    b(0x2601b4,0); read_health(); check(report.valid==1 && report.enabled==1 && !snapshot.actors[0].minimap_health_fraction_ok);
    fixture(); b(0x2600c1,0); read_health(); check(report.valid==1); /* hidden = no current HP ring */
    fixture(); b(0x2600c0,0); read_health(); check(report.matched==1 && report.valid==1);
    fixture(); b(0x2600c8,1); read_health(); check(report.valid==1); /* recycled icon */
    fixture(); q(0x2601a0,16385); read_health(); check(report.valid==1);
    fixture(); q(0x2601a0,UINT64_MAX); read_health(); check(report.valid==1);
    fixture(); q(0x2601a0,0); read_health(); check(report.valid==2 && snapshot.actors[0].minimap_health_fraction_fixed==0);
    fixture(); u(0x260200,0); read_health(); check(report.valid==1); /* never updated */
    fixture(); u(0x260200,0x7fc00000); read_health(); check(report.valid==1);
    fixture(); u(0x2601c0,99); read_health(); check(report.valid==1);
    fixture(); q(0x260098,0x270008); read_health(); check(report.valid==1);
    fixture(); q(0x260000,0x230200); read_health(); check(report.valid==1); /* wrong icon subclass */
    fixture(); u(0x253020,UINT32_MAX); read_health(); check(report.valid==1); /* tombstone */
    fixture(); u(0x253040,4); q(0x253048,0x260000); read_health(); check(report.valid==0); /* duplicate identity */
    fixture(); snapshot.actors[1].object_id=4; read_health(); check(report.valid==0);
    fixture(); failure=0x253020; read_health(); check(!report.valid && !strcmp(report.reason,"health_entries_unreadable"));
    fixture(); mutation=0x252018; read_health(); check(!report.valid && !strcmp(report.reason,"health_cache_changed"));
    fixture(); mutation=0x2600c0; read_health(); check(report.valid==1); /* icon changes during read */
    fixture(); q(0x253018,4097); read_health(); check(!report.valid && !snapshot.actors[0].minimap_health_fraction_ok);
    fixture(); snapshot.result=LV_TARGET_NOT_IN_BATTLE; read_health(); check(!report.valid);
    fixture(); lv_minimap_health_read(NULL,NULL,0x100000000,&snapshot,&report); check(!report.valid);
    fixture(); lv_minimap_health_read(reader,NULL,UINT64_MAX,&snapshot,&report); check(!report.valid);
    printf("Minimap health: %u checks passed\n",checks); return 0;
}
