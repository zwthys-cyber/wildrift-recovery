#include "LVTarget.h"
#include <string.h>

typedef struct { LVTargetRead read; void *context; } Reader;
static int address_valid(uint64_t a, size_t n) {
    return a >= 0x10000 && a < (UINT64_C(1)<<48) && n && n <= 4096 &&
           n <= (UINT64_C(1)<<48)-a;
}
static int load(Reader *r,uint64_t a,void *p,size_t n) {
    memset(p,0,n);
    if(!address_valid(a,n) || !r->read(r->context,a,p,n)) { memset(p,0,n); return 0; }
    return 1;
}
static int pointer(Reader *r,uint64_t a,uint64_t *p) {
    return load(r,a,p,8) && (!*p || (address_valid(*p,8) && !(*p&7)));
}
static void clear(LVTargetActor *a,LVLogicPositionStatus s) {
    a->logic_position_ok=0; a->logic_native=a->logic_transform=0;
    memset(a->logic_position_fixed,0,sizeof(a->logic_position_fixed));
    a->logic_position_status=s;
}
static int duplicate(const LVTargetSnapshot *s,size_t index) {
    for(size_t i=0;i<s->count;++i) if(i!=index && s->actors[i].object_id_ok &&
        s->actors[i].object_id==s->actors[index].object_id) return 1;
    return 0;
}
static int sync_identity(Reader *r,const LVTargetActor *a) {
    uint64_t managed,native; uint32_t id; int32_t res,camp;
    return pointer(r,a->visual+0xa0,&managed) && managed==a->managed &&
        pointer(r,managed+0x18,&native) && native==a->native &&
        load(r,native+0x18,&id,4) && id==a->object_id &&
        load(r,native+0x2c,&res,4) && res==a->resource_id &&
        load(r,native+0x80,&camp,4) && camp==a->camp;
}
static int logic_identity(Reader *r,uint64_t native,const LVTargetActor *a,uint64_t *transform) {
    /* Lua FixGameObject.objId 0x3326590; BattleActor.ResID/camp
       0x3959e5c/0x395c260; FixGameObject.transform and original Fow
       position getter 0x1030dac use the independent actor's +20. */
    uint32_t id; int32_t res,camp;
    return load(r,native+0x14,&id,4) && id==a->object_id &&
        load(r,native+0xc4,&res,4) && res==a->resource_id &&
        load(r,native+0x198,&camp,4) && camp==a->camp &&
        pointer(r,native+0x20,transform) && *transform;
}
static LVLogicPositionStatus find(Reader *r,uint64_t tree,uint32_t id,uint64_t *object) {
    /* Original logic FixObjectMgr.FindObject 0x1011924..0x1011990:
       manager +20 -> tree header; header +0 -> root; node +8/+10
       children, +20 unsigned key, +28 object. Sync uses manager +28
       and object +18 instead, so it cannot be substituted here. */
    uint64_t node,candidate=0,visited[64]; uint32_t candidate_key=0;
    size_t depth=0;
    if(!pointer(r,tree,&node)) return LV_LOGIC_UNREADABLE;
    while(node) {
        if(depth==64) return LV_LOGIC_INVALID;
        for(size_t i=0;i<depth;++i) if(visited[i]==node) return LV_LOGIC_INVALID;
        visited[depth++]=node;
        unsigned char bytes[48];
        if(!load(r,node,bytes,sizeof(bytes))) return LV_LOGIC_UNREADABLE;
        uint32_t key; uint64_t child,value;
        memcpy(&key,bytes+0x20,4); memcpy(&value,bytes+0x28,8);
        if(key>=id) { candidate=value; candidate_key=key; }
        memcpy(&child,bytes+(key<id ? 0x10 : 8),8);
        if(child && (!address_valid(child,48) || (child&7))) return LV_LOGIC_INVALID;
        node=child;
    }
    if(candidate_key!=id || !candidate) return LV_LOGIC_NOT_FOUND;
    if(!address_valid(candidate,0x1a0) || (candidate&7)) return LV_LOGIC_INVALID;
    *object=candidate; return LV_LOGIC_READY;
}
static int roots(Reader *r,uint64_t base,const LVLogicPositionReport *v,uint64_t key) {
    uint64_t desk,frame,battle,cached_battle,tree,same_key;
    return pointer(r,base+0x523cf28,&desk) && desk==v->desk &&
        pointer(r,desk+0x38,&frame) && frame==v->frame_root &&
        pointer(r,frame+0x10,&battle) && battle==v->frame_battle &&
        pointer(r,base+0x523cf30,&cached_battle) && cached_battle==v->battle &&
        pointer(r,v->manager+0x20,&tree) && tree==v->tree &&
        load(r,base+0x523cf38,&same_key,8) && same_key==key;
}
void lv_target_logic_position_read(LVTargetRead read,void *context,uint64_t base,
                                  const char *uuid,LVTargetSnapshot *s,LVLogicPositionReport *report) {
    LVLogicPositionReport v={.reason="logic_unavailable"};
    if(!s || s->count>LV_TARGET_MAX_ACTORS) { if(report) *report=v; return; }
    for(size_t i=0;i<s->count;++i) clear(&s->actors[i],LV_LOGIC_UNAVAILABLE);
    if(!read || !uuid || strcmp(uuid,LV_NATIVE_ENGINE_UUID) || !address_valid(base,8) ||
        base> (UINT64_C(1)<<48)-0x523cf40) { v.reason="logic_profile_mismatch"; goto done; }
    v.profile_matches=1;
    if(s->result!=LV_TARGET_READY && s->result!=LV_TARGET_PARTIAL) goto done;
    Reader r={read,context}; uint64_t key;
    /* Original FrameRoot initialization 0xcceaac..0xcceab8 copies its
       +10 Battle to global 0x523cf30. Actual actor dispatch 0x434748
       loads THAT global and manager +1e0, virtual slot +b0.
       FrameRoot +28 (0.7.8) is a separately allocated logger, created
       by 0xcd2e24 -> 0x3ca82e8, not a Battle or its ActorMgr. */
    if(!pointer(&r,base+0x523cf28,&v.desk) || !v.desk ||
        !pointer(&r,v.desk+0x38,&v.frame_root) || !v.frame_root ||
        !pointer(&r,v.frame_root+0x10,&v.frame_battle) || !v.frame_battle ||
        !pointer(&r,base+0x523cf30,&v.battle) || !v.battle ||
        !load(&r,base+0x523cf38,&key,8)) { v.reason="logic_root_unreadable"; goto done; }
    if(v.battle!=v.frame_battle) { v.reason="logic_battle_root_mismatch"; goto done; }
    if(!address_valid(v.battle+0x1e0,0x30)) { v.reason="logic_manager_invalid"; goto done; }
    /* Runtime battle constructors 0x4b89cc/0x4b9acc embed ActorMgr at
       +1e0 and call its constructor 0x74858c. That constructor writes
       vtable 0x4b22650; its +b0 slot contains FindObject 0x32f2318.
       This is independently checked against original constructor bytes
       and the original on-disk vtable, rather than an assumed dispatch. */
    v.manager=v.battle+0x1e0;
    if(!pointer(&r,v.manager,&v.manager_vtable) || !v.manager_vtable ||
        !load(&r,v.manager_vtable+0xb0,&v.lookup_method,8)) {
        v.reason="logic_manager_unreadable"; goto done;
    }
    if(v.manager_vtable>=base) v.manager_vtable_offset=v.manager_vtable-base;
    if(v.lookup_method>=base) v.lookup_method_offset=v.lookup_method-base;
    if(v.manager_vtable!=base+0x4b22650 || v.lookup_method!=base+0x32f2318) {
        v.reason="logic_lookup_layout_mismatch"; goto done;
    }
    if(!pointer(&r,v.manager+0x20,&v.tree) || !v.tree) { v.reason="logic_tree_unreadable"; goto done; }
    for(size_t i=0;i<s->count;++i) {
        LVTargetActor *a=&s->actors[i];
        if(!a->values_ok || !a->classification_ok || !a->is_hero || !a->object_id_ok ||
            !a->object_id || duplicate(s,i)) { clear(a,LV_LOGIC_INELIGIBLE); continue; }
        ++v.eligible;
        uint64_t native=0,transform=0,after_transform=0,same=0,encrypted[3];
        LVLogicPositionStatus status=find(&r,v.tree,a->object_id,&native);
        if(status==LV_LOGIC_READY && (!sync_identity(&r,a) ||
            !logic_identity(&r,native,a,&transform))) status=LV_LOGIC_CHANGED;
        if(status==LV_LOGIC_READY && !load(&r,transform+0x28,encrypted,sizeof(encrypted))) status=LV_LOGIC_UNREADABLE;
        int64_t position[3]={0};
        if(status==LV_LOGIC_READY) {
            /* Original logical transform 0x1030de8..0x1030e0c. Copy
               decoded bit patterns to signed Q14 without signed overflow. */
            for(size_t j=0;j<3;++j) { uint64_t decoded=encrypted[j]^key; memcpy(&position[j],&decoded,8); }
            for(size_t j=0;j<3;++j) if(position[j]<-200*INT64_C(16384) || position[j]>200*INT64_C(16384))
                status=LV_LOGIC_INVALID;
        }
        if(status==LV_LOGIC_READY && (find(&r,v.tree,a->object_id,&same)!=LV_LOGIC_READY || same!=native ||
            !logic_identity(&r,native,a,&after_transform) || after_transform!=transform || !sync_identity(&r,a)))
            status=LV_LOGIC_CHANGED;
        clear(a,status);
        switch(status) {
            case LV_LOGIC_READY:
                a->logic_native=native; a->logic_transform=transform; a->logic_position_ok=1;
                memcpy(a->logic_position_fixed,position,sizeof(position)); ++v.valid; break;
            case LV_LOGIC_NOT_FOUND: ++v.not_found; break;
            case LV_LOGIC_UNREADABLE: ++v.unreadable; break;
            case LV_LOGIC_INVALID: ++v.invalid; break;
            default: ++v.changed; break;
        }
    }
    uint64_t after_vtable=0,after_lookup=0;
    if(!roots(&r,base,&v,key) || !pointer(&r,v.manager,&after_vtable) || after_vtable!=v.manager_vtable ||
        !load(&r,v.manager_vtable+0xb0,&after_lookup,8) || after_lookup!=v.lookup_method) {
        for(size_t i=0;i<s->count;++i) if(s->actors[i].logic_position_ok) {
            clear(&s->actors[i],LV_LOGIC_CHANGED); ++v.changed;
        }
        v.valid=0; v.reason="logic_root_changed";
    } else v.reason=v.valid ? "ready" : "no_valid_logic_position";
done:
    if(report) *report=v;
}
const char *lv_logic_position_status_name(LVLogicPositionStatus s) {
    switch(s) {
        case LV_LOGIC_READY:return "ready";
        case LV_LOGIC_NOT_FOUND:return "not_found";
        case LV_LOGIC_UNREADABLE:return "unreadable";
        case LV_LOGIC_INVALID:return "invalid";
        case LV_LOGIC_CHANGED:return "changed";
        case LV_LOGIC_INELIGIBLE:return "ineligible";
        default:return "unavailable";
    }
}
