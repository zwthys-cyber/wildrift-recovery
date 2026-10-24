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
        LVMonsterRespawnObservation observation={.anchor_id=key,.reason="not_sampled",
            .active=-1,.showing=-1,.recycled=-1,.state=-1,.anchor_type=-1,.poi_type=-1};
        /* Each rejection has an explicit category. An alive/hidden anchor is
           not an unreadable anchor and does not establish a respawn timer. */
#define REJECT(why,category) {observation.reason=(why);++out->category;goto record_anchor;}
        if(!load(&r,icon+0xc0,&active,1) || !load(&r,icon+0xc1,&showing,1) ||
            !load(&r,icon+0xc8,&recycled,1))REJECT("icon_flags_unreadable",unavailable);
        observation.flags_ok=1;observation.active=active;observation.showing=showing;observation.recycled=recycled;
        if(!load(&r,icon+0x1e8,&state,4))REJECT("anchor_state_unreadable",unavailable);
        observation.state_ok=1;observation.state=state;
        if(state<0 || state>4)REJECT("anchor_state_invalid",unavailable);
        if(active!=1)REJECT("icon_not_initialized",excluded);
        if(showing!=1)REJECT("icon_hidden",excluded);
        if(recycled)REJECT("icon_recycled",excluded);
        if(state!=1)REJECT("not_born_countdown",not_counting);
        if(!ptr(&r,icon+0x1c8,&anchor) || !instance(&r,anchor,anchor_cls))REJECT("anchor_binding_unavailable",unavailable);
        if(!handle(&r,anchor,&native))REJECT("anchor_handle_unavailable",unavailable);
        if(!ptr(&r,anchor+0x60,&config) || !instance(&r,config,config_cls))REJECT("anchor_config_unavailable",unavailable);
        if(!handle(&r,config,&raw_config))REJECT("config_handle_unavailable",unavailable);
        if(!load(&r,raw_config+0x1a4,&type,4))REJECT("anchor_type_unreadable",unavailable);
        observation.anchor_type=type;
        if(type!=0)REJECT("not_monster_anchor",excluded);
        if(!load(&r,raw_config+0x1a0,&t.poi_type,4))REJECT("anchor_poi_unreadable",unavailable);
        observation.poi_type=t.poi_type;
        if(!combat_poi(t.poi_type))REJECT("not_combat_monster_poi",excluded);
        if(!load(&r,native+0x68,&t.remaining_fixed,8))REJECT("remaining_time_unreadable",unavailable);
        observation.timer_ok=1;observation.remaining_fixed=t.remaining_fixed;
        if(!t.remaining_fixed)REJECT("no_remaining_timer",not_counting);
        if(t.remaining_fixed<0 || t.remaining_fixed>3600*INT64_C(16384))REJECT("remaining_time_invalid",unavailable);
        if(!load(&r,raw_config+0x128,t.position_fixed,sizeof(t.position_fixed)))REJECT("anchor_position_unreadable",unavailable);
        unsigned valid=1;
        for(size_t j=0;j<3;++j)if(t.position_fixed[j]<-200*INT64_C(16384) || t.position_fixed[j]>200*INT64_C(16384))valid=0;
        if(!valid)REJECT("anchor_position_invalid",unavailable);
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
            REJECT("anchor_changed_during_read",unavailable);
        }
        unsigned duplicate=0;
        for(size_t j=0;j<out->count;++j)if(seen[j]==native || out->timers[j].anchor_id==key) {
            out->timers[j].remaining_fixed=0;duplicate=1;++out->duplicates;
        }
        if(duplicate){observation.reason="duplicate_anchor";goto record_anchor;}
        if(out->count==LV_RESPAWN_MAX_TIMERS){out->reason="anchor_limit";out->count=0;return;}
        seen[out->count]=native;out->timers[out->count++]=t;observation.reason="ready";
record_anchor:
        /* Bounded diagnostics also sample a checked current binding for
           excluded icons. A positive raw value here never makes a marker:
           only the fully checked BornCountDown path above emits timers. */
        {
            uint64_t observed_anchor,observed_native,observed_config,observed_raw;
            if(ptr(&r,icon+0x1c8,&observed_anchor) && instance(&r,observed_anchor,anchor_cls) &&
                handle(&r,observed_anchor,&observed_native)) {
                if(!observation.timer_ok && load(&r,observed_native+0x68,&observation.remaining_fixed,8))observation.timer_ok=1;
                if(ptr(&r,observed_anchor+0x60,&observed_config) && instance(&r,observed_config,config_cls) &&
                    handle(&r,observed_config,&observed_raw)) {
                    int32_t observed_value;
                    if(observation.anchor_type==-1 && load(&r,observed_raw+0x1a4,&observed_value,4))observation.anchor_type=observed_value;
                    if(observation.poi_type==-1 && load(&r,observed_raw+0x1a0,&observed_value,4))observation.poi_type=observed_value;
                }
            }
        }
        if(out->observation_count<LV_RESPAWN_MAX_OBSERVATIONS)
            out->observations[out->observation_count++]=observation;
        else out->observations_truncated=1;
#undef REJECT
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
    if(!kept)out->reason=out->unavailable ? "anchor_data_unavailable" : "no_current_respawn_timer";
}
