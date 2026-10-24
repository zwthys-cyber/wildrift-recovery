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
static int vector_item(Reader *r,uint64_t header,int32_t index,size_t limit,uint64_t *item) {
    uint64_t begin,end;int32_t stride;
    return index>=0 && ptr(r,header,&begin) && ptr(r,header+8,&end) && end>=begin &&
        end-begin<=limit*8 && !((end-begin)%8) && load(r,header+0x18,&stride,4) && stride==8 &&
        (uint64_t)index<(end-begin)/8 && ptr(r,begin+(uint64_t)index*8,item);
}
static int current_desk(Reader *r,const LVLogicPositionReport *logic) {
    uint64_t frame,battle;
    return logic && logic->profile_matches && logic->desk && logic->battle &&
        logic->battle==logic->frame_battle && ptr(r,logic->desk+0x38,&frame) && frame==logic->frame_root &&
        ptr(r,frame+0x10,&battle) && battle==logic->battle;
}
/* Mirror original MonsterAnchor.get_anchorData / MapDataProxy.GetMapDC.
   Resolve current native configuration without calling a getter or populating
   the managed anchor's lazy +60 cache. Native +68 remains the timer source. */
static int native_config(Reader *r,uint64_t base,uint64_t cache,const LVLogicPositionReport *logic,
                         uint64_t native,uint32_t key,uint64_t *config,const char **reason) {
    *reason="native_map_context_unavailable";
    if(!current_desk(r,logic))return 0;
    uint64_t data_cls,statics,object,data,same;
    *reason="native_data_config_class_unavailable";
    if((!ptr(r,cache+34147*8ULL,&data_cls) || !named(r,data_cls,"DataConfig","FrameEngine")) &&
       (!ptr(r,base+0xed5a230,&data_cls) || !named(r,data_cls,"DataConfig","FrameEngine")))return 0;
    *reason="native_data_config_unavailable";
    if(!ptr(r,data_cls+0xb8,&statics) || !ptr(r,statics+0x10,&object) ||
        !instance(r,object,data_cls) || !handle(r,object,&data))return 0;
    int32_t mode,id,map_index;uint64_t map_dc,header;
    *reason="native_anchor_identity_unavailable";
    if(!load(r,native+0x28,&id,4) || id<0 || (uint32_t)id!=key ||
        !load(r,native+0x30,&map_index,4))return 0;
    uint64_t proxy=data+0xca0;
    *reason="native_map_mode_unreadable";
    if(!load(r,proxy+0x30,&mode,4))return 0;
    if(mode==1 || mode==2) {
        uint64_t set,vtable,bridge_cls,bridge_statics,bridge,bridge_type;uint16_t kind,again_kind;
        *reason="native_map_dataset_unavailable";
        if(!vector_item(r,proxy+8,mode==1?0:map_index,32,&set))return 0;
        /* Original LGameObject conversion a9c7744..7790 selects managed
           handle storage for kind 4. Only the native pointer payload is
           supported here; do not mistake a managed handle for an address. */
        *reason="map_payload_backend_unavailable";
        if(!ptr(r,base+0xed5e090,&bridge_cls) || !ptr(r,bridge_cls+0xb8,&bridge_statics) ||
            !ptr(r,bridge_statics+0x10,&bridge) || !ptr(r,bridge+0x18,&bridge_type) ||
            !load(r,bridge_type+8,&kind,2))return 0;
        *reason="managed_map_payload_unsupported";
        if(kind==4)return 0;
        *reason="native_map_dataset_unavailable";
        /* The vector item itself is the native MapDataSet. Its first word
           is a factory/vtable key: a9c7790..7828 uses that key to choose a
           wrapper factory, passing the original item to the factory. */
        if(!ptr(r,set,&vtable) || !ptr(r,set+0xb8,&map_dc) ||
            !load(r,bridge_type+8,&again_kind,2) || again_kind!=kind)return 0;
    } else {
        *reason="native_default_map_unavailable";
        if(!mode) {
            /* The default map DC is embedded in DataConfig, not the desk. */
            map_dc=data+0xc30;
        } else return 0;
    }
    *reason="native_anchor_config_unavailable";
    if(!ptr(r,map_dc+0x28,&header) || !vector_item(r,header,id,4096,config))return 0;
    *reason="native_data_config_changed";
    if(!ptr(r,data_cls+0xb8,&same) || same!=statics || !ptr(r,statics+0x10,&same) || same!=object ||
        !handle(r,object,&same) || same!=data || !current_desk(r,logic))return 0;
    *reason="ready";return 1;
}
/* This probe is separate from timer eligibility: a config can be available
   while the icon is showing a living monster or another UI state. Probe at
   most the retained observation limit, and never promote a probe to a timer. */
static void observe_config(Reader *r,uint64_t base,uint64_t cache,const LVLogicPositionReport *logic,
                           uint64_t icon,uint64_t anchor_cls,uint64_t config_cls,
                           LVMonsterRespawnObservation *o) {
    uint64_t anchor,native,config=0,raw,again,after;unsigned source;
    const char *why="anchor_config_unavailable";
    o->config_reason="anchor_binding_unavailable";
    if(!ptr(r,icon+0x1c8,&anchor) || !instance(r,anchor,anchor_cls))return;
    o->config_reason="anchor_handle_unavailable";
    if(!handle(r,anchor,&native))return;
    if(!o->timer_ok && load(r,native+0x68,&o->remaining_fixed,8))o->timer_ok=1;
    o->config_reason=why;
    if(ptr(r,anchor+0x60,&config) && instance(r,config,config_cls) && handle(r,config,&raw))source=1;
    else {
        if(!logic)return;
        if(!native_config(r,base,cache,logic,native,o->anchor_id,&raw,&why)) {o->config_reason=why;return;}
        source=2;
    }
    int32_t type,poi;int64_t position[3],after_position[3];
    o->config_reason="anchor_config_fields_unreadable";
    if(!load(r,raw+0x1a4,&type,4) || !load(r,raw+0x1a0,&poi,4) ||
        !load(r,raw+0x128,position,sizeof(position)))return;
    o->config_reason="anchor_config_changed";
    if(!ptr(r,icon+0x1c8,&again) || again!=anchor || !instance(r,anchor,anchor_cls) ||
        !handle(r,anchor,&again) || again!=native)return;
    if(source==1) {
        if(!ptr(r,anchor+0x60,&again) || again!=config || !instance(r,config,config_cls) ||
            !handle(r,config,&after) || after!=raw)return;
    } else if(!native_config(r,base,cache,logic,native,o->anchor_id,&after,&why) || after!=raw)return;
    int32_t after_type,after_poi;
    if(!load(r,raw+0x1a4,&after_type,4) || after_type!=type ||
        !load(r,raw+0x1a0,&after_poi,4) || after_poi!=poi ||
        !load(r,raw+0x128,after_position,sizeof(after_position)) || memcmp(position,after_position,sizeof(position)))return;
    o->config_source=source;o->config_ok=1;o->anchor_type=type;o->poi_type=poi;
    o->position_ok=1;
    for(size_t j=0;j<3;++j)if(position[j]<-200*INT64_C(16384) || position[j]>200*INT64_C(16384))o->position_ok=0;
    if(o->position_ok)memcpy(o->position_fixed,position,sizeof(position));
    o->config_reason=o->position_ok ? "ready" : "anchor_position_invalid";
}
void lv_monster_respawn_read(LVTargetRead read,void *context,uint64_t base,const char *uuid,
                            const LVTargetSnapshot *snapshot,const LVLogicPositionReport *logic,unsigned enabled,LVMonsterRespawnReport *out) {
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
        uint64_t anchor,native,config=0,raw_config;uint8_t active,showing,recycled;int32_t state,type;
        LVMonsterRespawnTimer t={.anchor_id=key};
        LVMonsterRespawnObservation observation={.anchor_id=key,.reason="not_sampled",.config_reason="not_sampled",
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
        /* The anchor dictionary holds current bindings even when its UI
           init/show flags stay zero. Native state and binding identity gate
           timers; visibility flags are diagnostics, not lifetime evidence. */
        if(recycled)REJECT("icon_recycled",excluded);
        if(state!=1)REJECT("not_born_countdown",not_counting);
        if(!ptr(&r,icon+0x1c8,&anchor) || !instance(&r,anchor,anchor_cls))REJECT("anchor_binding_unavailable",unavailable);
        if(!handle(&r,anchor,&native))REJECT("anchor_handle_unavailable",unavailable);
        if(ptr(&r,anchor+0x60,&config) && instance(&r,config,config_cls) && handle(&r,config,&raw_config)) {
            observation.config_source=1;
        } else {
            const char *why="anchor_config_unavailable";
            if(!logic)REJECT(why,unavailable);
            if(!native_config(&r,base,cache,logic,native,key,&raw_config,&why))REJECT(why,unavailable);
            observation.config_source=2;
        }
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
            !load(&r,icon+0xc0,&active,1) || active!=observation.active ||
            !load(&r,icon+0xc1,&showing,1) || showing!=observation.showing ||
            !load(&r,icon+0xc8,&recycled,1) || recycled ||
            !instance(&r,anchor,anchor_cls) || !handle(&r,anchor,&after_native) || after_native!=native ||
            !load(&r,raw_config+0x1a4,&after_type,4) || after_type!=type ||
            !load(&r,raw_config+0x1a0,&after_poi,4) || after_poi!=t.poi_type ||
            !load(&r,raw_config+0x128,position,sizeof(position)) || memcmp(position,t.position_fixed,sizeof(position))) {
            REJECT("anchor_changed_during_read",unavailable);
        }
        if(observation.config_source==1) {
            if(!instance(&r,config,config_cls) || !ptr(&r,anchor+0x60,&same) || same!=config ||
                !handle(&r,config,&after_config) || after_config!=raw_config)REJECT("anchor_config_changed",unavailable);
        } else {
            const char *why;
            if(!native_config(&r,base,cache,logic,native,key,&after_config,&why) || after_config!=raw_config)
                REJECT("native_anchor_config_changed",unavailable);
        }
        unsigned duplicate=0;
        for(size_t j=0;j<out->count;++j)if(seen[j]==native || out->timers[j].anchor_id==key) {
            out->timers[j].remaining_fixed=0;duplicate=1;++out->duplicates;
        }
        if(duplicate){observation.reason="duplicate_anchor";goto record_anchor;}
        if(out->count==LV_RESPAWN_MAX_TIMERS){out->reason="anchor_limit";out->count=0;return;}
        seen[out->count]=native;out->timers[out->count++]=t;observation.reason="ready";
        observation.config_reason="ready";observation.config_ok=observation.position_ok=1;
        memcpy(observation.position_fixed,t.position_fixed,sizeof(t.position_fixed));
        if(observation.config_source==2)++out->native_config_count;
record_anchor:
        /* Bounded diagnostics also sample a checked current binding for
           excluded icons. A positive raw value here never makes a marker:
           only the fully checked BornCountDown path above emits timers. */
        if(out->observation_count<LV_RESPAWN_MAX_OBSERVATIONS) {
            if(!observation.config_ok)observe_config(&r,base,cache,logic,icon,anchor_cls,config_cls,&observation);
            if(observation.config_ok) {
                ++out->config_observation_count;
                if(observation.config_source==2)++out->native_config_observation_count;
            }
            out->observations[out->observation_count++]=observation;
        } else out->observations_truncated=1;
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
