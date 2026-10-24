#include "LVMonsterRespawn.h"
#include <string.h>
#define ICON_ANCHOR_TYPE 6772
#define ANCHOR_TYPE 35519
#define CONFIG_TYPE 36514
#define MAX_ENTRIES 512

typedef struct {LVTargetRead read;void *context;} Reader;
static int load(Reader *r,uint64_t a,void *p,size_t n) {
    memset(p,0,n);
    return r->read && a>=0x10000 && a<(UINT64_C(1)<<48) && n<4096 &&
        n<=(UINT64_C(1)<<48)-a && r->read(r->context,a,p,n);
}
static int ptr(Reader *r,uint64_t a,uint64_t *p) {
    return load(r,a,p,8) && *p>=0x10000 && *p<(UINT64_C(1)<<48) && !(*p&7);
}
static int named(Reader *r,uint64_t cls,const char *name,const char *ns) {
    uint64_t a,b;char x[64],y[64];size_t n=strlen(name)+1,m=strlen(ns)+1;
    /* These fields point to byte strings, whose addresses need no pointer
       alignment. Keep aligned ptr() checks for managed/native objects only. */
    return n<=sizeof(x) && m<=sizeof(y) && load(r,cls+0x10,&a,8) && load(r,cls+0x18,&b,8) &&
        load(r,a,x,n) && !memcmp(x,name,n) && load(r,b,y,m) && !memcmp(y,ns,m);
}
static int instance(Reader *r,uint64_t object,uint64_t cls) {
    uint64_t actual;return ptr(r,object,&actual) && actual==cls;
}
static int handle(Reader *r,uint64_t object,uint64_t *native) {
    uint64_t mirror;return ptr(r,object+0x18,native) && ptr(r,object+0x10,&mirror) && mirror==*native;
}
static int combat_poi(int32_t poi) {return (poi>=2 && poi<=11) || (poi>=13 && poi<=15);}
void lv_monster_respawn_read(LVTargetRead read,void *context,uint64_t base,const char *uuid,
                            const LVTargetSnapshot *snapshot,unsigned enabled,LVMonsterRespawnReport *out) {
    if(!out)return;
    memset(out,0,sizeof(*out));out->enabled=enabled!=0;out->reason="disabled";
    if(!enabled)return;
    out->reason="snapshot_unavailable";
    if(!snapshot || (snapshot->result!=LV_TARGET_READY && snapshot->result!=LV_TARGET_PARTIAL))return;
    out->reason="profile_mismatch";
    if(!uuid || strcmp(uuid,LV_TARGET_UUID) || base<0x10000 || base>(UINT64_C(1)<<48)-LV_TARGET_CLASS_CACHE_OFFSET-8)return;
    Reader r={read,context};uint64_t cache,controller_cls,statics,entity,icons,dict,entries,capacity;
    uint64_t icon_cls,anchor_cls,config_cls,cls,same;
    out->reason="map_class_cache_unavailable";
    if(!ptr(&r,base+LV_TARGET_CLASS_CACHE_OFFSET,&cache))return;
    out->reason="map_controller_class_unavailable";
    uint64_t controller_slot=cache+LV_TYPE_MINIMAP_CONTROLLER*8ULL;
    if(!ptr(&r,controller_slot,&controller_cls) || !named(&r,controller_cls,"UIMainBattleMiniMapCtrl","")) {
        controller_slot=base+LV_MINIMAP_CONTROLLER_CLASS_GLOBAL;
        if(!ptr(&r,controller_slot,&controller_cls) || !named(&r,controller_cls,"UIMainBattleMiniMapCtrl",""))return;
        out->class_root_fallbacks=1;
    }
    out->reason="map_controller_statics_unavailable";
    if(!ptr(&r,controller_cls+0xb8,&statics))return;
    out->reason="map_entity_unavailable";
    if(!ptr(&r,statics,&entity) || !ptr(&r,entity,&cls) || !named(&r,cls,"MiniMapEntityCtrl",""))return;
    out->reason="map_icons_unavailable";
    if(!ptr(&r,entity+0x190,&icons) || !ptr(&r,icons,&cls) || !named(&r,cls,"UIMiniMapIconCtrl",""))return;
    out->reason="anchor_dictionary_unavailable";
    if(!ptr(&r,icons+0x88,&dict))return;
    out->reason="anchor_entries_unavailable";
    if(!ptr(&r,dict+0x18,&entries) || !load(&r,entries+0x18,&capacity,8) || capacity>MAX_ENTRIES)return;
    out->reason="anchor_classes_unavailable";
    if(!ptr(&r,cache+ICON_ANCHOR_TYPE*8ULL,&icon_cls) || !named(&r,icon_cls,"UIMiniIconAnchorCtrl","") ||
        !ptr(&r,cache+ANCHOR_TYPE*8ULL,&anchor_cls) || !named(&r,anchor_cls,"MonsterAnchor","FrameEngine.Logic") ||
        !ptr(&r,cache+CONFIG_TYPE*8ULL,&config_cls) || !named(&r,config_cls,"AnchorDataData","FrameEngine.Interface"))return;
    out->reason="anchor_dictionary_version_unreadable";
    int32_t version;
    if(!load(&r,dict+0x24,&version,4))return;
    out->reason="ready";uint64_t seen[LV_RESPAWN_MAX_TIMERS]={0};
    for(size_t i=0;i<capacity;++i) {
        unsigned char entry[24],again[24];uint64_t icon;uint32_t key;int32_t hash;
        if(!load(&r,entries+0x20+i*24,entry,sizeof(entry))) {out->reason="anchor_entries_unreadable";out->count=0;return;}
        memcpy(&hash,entry,4);memcpy(&key,entry+8,4);memcpy(&icon,entry+16,8);
        if(hash<0 || !key || !icon)continue;
        if(!instance(&r,icon,icon_cls))continue;
        ++out->examined;
        uint64_t anchor,native,config,raw_config;uint8_t active,showing,recycled;int32_t state,type;
        LVMonsterRespawnTimer t={.anchor_id=key};
        /* Current UI BornCountDown state excludes live/leaving anchors. It is
           not used to estimate a deadline. The remaining Q14 value is the
           game's MonsterAnchor.timeNeedToBorn (+68), used by its own UI. */
        if(!load(&r,icon+0xc0,&active,1) || active!=1 || !load(&r,icon+0xc1,&showing,1) || showing!=1 ||
            !load(&r,icon+0xc8,&recycled,1) || recycled || !load(&r,icon+0x1e8,&state,4) || state!=1 ||
            !ptr(&r,icon+0x1c8,&anchor) || !instance(&r,anchor,anchor_cls) || !handle(&r,anchor,&native) ||
            !ptr(&r,anchor+0x60,&config) || !instance(&r,config,config_cls) || !handle(&r,config,&raw_config) ||
            !load(&r,raw_config+0x1a4,&type,4) || type!=0 ||
            !load(&r,raw_config+0x1a0,&t.poi_type,4) || !combat_poi(t.poi_type) ||
            !load(&r,native+0x68,&t.remaining_fixed,8) || t.remaining_fixed<=0 || t.remaining_fixed>3600*INT64_C(16384) ||
            !load(&r,raw_config+0x128,t.position_fixed,sizeof(t.position_fixed))) {++out->unavailable;continue;}
        unsigned valid=1;
        for(size_t j=0;j<3;++j)if(t.position_fixed[j]<-200*INT64_C(16384) || t.position_fixed[j]>200*INT64_C(16384))valid=0;
        int32_t after_state,after_type,after_poi;int64_t position[3];uint64_t after_native,after_config;
        if(!valid || !load(&r,entries+0x20+i*24,again,sizeof(again)) || memcmp(entry,again,sizeof(entry)) ||
            !instance(&r,icon,icon_cls) || !ptr(&r,icon+0x1c8,&same) || same!=anchor ||
            !load(&r,icon+0x1e8,&after_state,4) || after_state!=state ||
            !load(&r,icon+0xc0,&active,1) || active!=1 || !load(&r,icon+0xc1,&showing,1) || showing!=1 ||
            !load(&r,icon+0xc8,&recycled,1) || recycled ||
            !instance(&r,anchor,anchor_cls) || !instance(&r,config,config_cls) ||
            !handle(&r,anchor,&after_native) || after_native!=native || !ptr(&r,anchor+0x60,&same) || same!=config ||
            !handle(&r,config,&after_config) || after_config!=raw_config ||
            !load(&r,raw_config+0x1a4,&after_type,4) || after_type!=type ||
            !load(&r,raw_config+0x1a0,&after_poi,4) || after_poi!=t.poi_type ||
            !load(&r,raw_config+0x128,position,sizeof(position)) || memcmp(position,t.position_fixed,sizeof(position))) {
            ++out->unavailable;continue;
        }
        unsigned duplicate=0;
        for(size_t j=0;j<out->count;++j)if(seen[j]==native || out->timers[j].anchor_id==key) {
            out->timers[j].remaining_fixed=0;duplicate=1;++out->duplicates;
        }
        if(duplicate)continue;
        if(out->count==LV_RESPAWN_MAX_TIMERS){out->reason="anchor_limit";out->count=0;return;}
        seen[out->count]=native;out->timers[out->count++]=t;
    }
    int32_t after_version;uint64_t after_capacity;
    if(!ptr(&r,base+LV_TARGET_CLASS_CACHE_OFFSET,&same) || same!=cache ||
        !ptr(&r,controller_slot,&same) || same!=controller_cls ||
        !ptr(&r,controller_cls+0xb8,&same) || same!=statics || !ptr(&r,statics,&same) || same!=entity ||
        !ptr(&r,entity+0x190,&same) || same!=icons || !ptr(&r,icons+0x88,&same) || same!=dict ||
        !ptr(&r,dict+0x18,&same) || same!=entries || !load(&r,entries+0x18,&after_capacity,8) || after_capacity!=capacity ||
        !load(&r,dict+0x24,&after_version,4) || after_version!=version) {
        out->reason="anchor_collection_changed";out->count=0;return;
    }
    size_t kept=0;
    for(size_t i=0;i<out->count;++i)if(out->timers[i].remaining_fixed>0)out->timers[kept++]=out->timers[i];
    out->count=kept;
    if(!kept)out->reason="no_current_respawn_timer";
}
