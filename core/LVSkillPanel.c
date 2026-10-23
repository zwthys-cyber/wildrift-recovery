#include "LVSkillPanel.h"
#include <string.h>

typedef struct {LVTargetRead read;void *context;} Reader;
typedef struct {uint64_t header,begin,end;int32_t stride;size_t count;uint64_t entries[LV_TARGET_MAX_SKILLS];} Vector;
static int load(Reader *r,uint64_t address,void *out,size_t size) {
    memset(out,0,size);
    if(address<0x10000 || address>=(UINT64_C(1)<<48) || size>(UINT64_C(1)<<48)-address ||
        !r->read(r->context,address,out,size)) {memset(out,0,size);return 0;}return 1;
}
static int pointer(Reader *r,uint64_t address,uint64_t *out) {
    return load(r,address,out,8) && (!*out || (*out>=0x10000 && *out<(UINT64_C(1)<<48) && !(*out&7)));
}
static int vector(Reader *r,uint64_t header,Vector *out) {
    memset(out,0,sizeof(*out));out->header=header;
    if(!header || !pointer(r,header,&out->begin) || !pointer(r,header+8,&out->end) ||
        !load(r,header+0x18,&out->stride,4) || out->end<out->begin || (out->end-out->begin)%8 ||
        (out->end!=out->begin && out->stride!=8) ||
        (out->end==out->begin && out->stride!=0 && out->stride!=8)) return 0;
    out->count=(size_t)((out->end-out->begin)/8);
    if(out->count>LV_TARGET_MAX_SKILLS)return 0;
        if(out->count && !load(r,out->begin,out->entries,out->count*8))return 0;
    for(size_t i=0;i<out->count;++i)for(size_t j=0;j<i;++j)
        if(out->entries[i] && out->entries[i]==out->entries[j])return 0;
    return 1;
}
static int same_vector(Reader *r,const Vector *a) {
    Vector b;
    return vector(r,a->header,&b) && a->begin==b.begin && a->end==b.end && a->stride==b.stride &&
        a->count==b.count && !memcmp(a->entries,b.entries,a->count*8);
}
static int contains(const Vector *a,uint64_t pointer) {
    for(size_t i=0;i<a->count;++i)if(a->entries[i]==pointer)return 1;
    return 0;
}
static int unique(const LVTargetSnapshot *s,size_t index) {
    for(size_t i=0;i<s->count;++i)if(i!=index && s->actors[i].object_id_ok &&
        s->actors[i].object_id==s->actors[index].object_id)return 0;
    return 1;
}
static int identity(Reader *r,const LVTargetActor *a) {
    uint64_t managed,native;uint32_t id;int32_t res,camp;uint8_t hero;
    return pointer(r,a->visual+0xa0,&managed) && managed==a->managed &&
        pointer(r,managed+0x18,&native) && native==a->native &&
        load(r,native+0x18,&id,4) && id==a->object_id &&
        load(r,native+0x2c,&res,4) && res==a->resource_id &&
        load(r,native+0x80,&camp,4) && camp==a->camp &&
        load(r,managed+0x13f,&hero,1) && hero==1;
}
static int battle(Reader *r,const LVTargetSnapshot *s) {
    uint64_t same;int32_t count;
    return (!s->drive_statics || (pointer(r,s->drive_statics,&same) && same==s->drive)) &&
        (!s->list || (load(r,s->list+0x18,&count,4) && count==s->reported_count &&
          pointer(r,s->list+0x10,&same) && same==s->items));
}
/* Returns 0 for a non-current/passive skill, -1 for unavailable identity. */
static int skill(Reader *r,uint64_t native,uint64_t actor,unsigned summoner,LVPanelSkill *out) {
    memset(out,0,sizeof(*out));out->native=native;out->summoner=summoner;
    out->role=summoner ? LV_PANEL_SUMMONER : LV_PANEL_UNKNOWN;out->configured_index=-1;out->logic_cooldown_reason="not_requested";
    uint64_t owner,current,same;int32_t index;uint32_t id,res;
    if(native<0x10000 || native>=(UINT64_C(1)<<48) || (native&7) ||
        !pointer(r,native+0x108,&out->slot))return -1;
    if(!out->slot)return 0;
    /* International named SkillSlot getters: index +b8, owner +b0,
       currentSkill +98. The array order is never treated as a slot index. */
    if(!pointer(r,out->slot+0x98,&current))return -1;
    if(current!=native)return 0;
    if(!pointer(r,out->slot+0xb0,&owner) || owner!=actor ||
        !load(r,out->slot+0xb8,&index,4) || index<0 || index>31 ||
        !load(r,native+0x20,&out->object_id,4) || !out->object_id ||
        !load(r,native+0x44,&out->resource_id,4) || !out->resource_id ||
        !load(r,native+0x38,&out->level,4) || out->level<0)return -1;
    out->slot_index=index;
    if(pointer(r,native+0x440,&out->cd_node)) {
        uint8_t locked=0;
        if(out->cd_node && load(r,out->cd_node+0x18,&locked,1)) {
            out->locked=locked!=0;
            out->node_values_ok=load(r,out->cd_node+0x28,&out->total_fixed,8) &&
                load(r,out->cd_node+0x30,&out->start_fixed,8);
            out->cooldown_ok=out->locked || load(r,out->cd_node+0x20,&out->cooldown_fixed,8);
        }
        if(out->cooldown_ok && out->cooldown_fixed<0)out->cooldown_fixed=0;
        if(!pointer(r,native+0x440,&same) || same!=out->cd_node){out->cooldown_ok=0;out->node_values_ok=0;}
    }
    out->configured_cd_ok=load(r,native+0xa8,&out->cd1_fixed,8) &&
        load(r,native+0xa0,&out->cd2_fixed,8);
    if(!load(r,native+0x20,&id,4) || id!=out->object_id ||
        !load(r,native+0x44,&res,4) || res!=out->resource_id ||
        !pointer(r,native+0x108,&same) || same!=out->slot ||
        !pointer(r,out->slot+0x98,&same) || same!=native ||
        !pointer(r,out->slot+0xb0,&same) || same!=actor ||
        !load(r,out->slot+0xb8,&index,4) || index!=out->slot_index)return -1;
    if(!out->cooldown_ok)out->cooldown_fixed=0;
    return 1;
}
static void invalidate(LVPanelHero *h,LVTargetResult result,const char *reason) {
    memset(h->skills,0,sizeof(h->skills));h->count=0;h->result=result;h->reason=reason;
}
static void hero(Reader *r,const LVTargetActor *a,LVPanelHero *h) {
    memset(h,0,sizeof(*h));h->object_id=a->object_id;h->resource_id=a->resource_id;
    h->result=LV_TARGET_UNREADABLE;h->reason="skill_manager_unavailable";
    uint64_t manager,summoner=0,same;
    if(!identity(r,a) || !pointer(r,a->native+0xd0,&manager) || !manager)return;
    Vector all,sum;memset(&sum,0,sizeof(sum));
    int all_ok=vector(r,manager+0x218,&all);
    int sum_root_ok=pointer(r,manager+0x140,&summoner);
    int sum_ok=sum_root_ok && summoner && vector(r,summoner+0x28,&sum);
    if(!all_ok && !sum_ok){h->reason="skill_vectors_unavailable";return;}
    if(!all_ok)memset(&all,0,sizeof(all));
    if(!sum_ok)memset(&sum,0,sizeof(sum));
    unsigned partial=!all_ok || !sum_ok;
    for(size_t pass=0;pass<2;++pass) {
        const Vector *v=pass ? &sum : &all;
        for(size_t i=0;i<v->count;++i) {
            uint64_t n=v->entries[i];
            if(pass && contains(&all,n))continue;
            unsigned duplicate=0;
            for(size_t j=0;j<i;++j)if(v->entries[j]==n)duplicate=1;
            if(duplicate){++h->unavailable;partial=1;continue;}
            LVPanelSkill value;int result=skill(r,n,a->native,contains(&sum,n),&value);
            if(!result)continue;
            if(result<0){++h->unavailable;partial=1;continue;}
            size_t found=SIZE_MAX;
            for(size_t j=0;j<h->count;++j)if(h->skills[j].slot_index==value.slot_index &&
                h->skills[j].summoner==value.summoner)found=j;
            if(found!=SIZE_MAX){h->skills[found].cooldown_ok=0;h->skills[found].cooldown_fixed=0;
                h->skills[found].ambiguous=1;++h->unavailable;partial=1;continue;}
            if(h->count==LV_PANEL_MAX_SKILLS){h->truncated=1;partial=1;continue;}
            h->skills[h->count++]=value;
            if(!value.cooldown_ok)partial=1;
        }
    }
    if(!identity(r,a) || !pointer(r,a->native+0xd0,&same) || same!=manager ||
        (sum_root_ok && (!pointer(r,manager+0x140,&same) || same!=summoner)) ||
        (all_ok && !same_vector(r,&all)) || (sum_ok && !same_vector(r,&sum))) {
        invalidate(h,LV_TARGET_CHANGED,"hero_or_skill_list_changed");return;
    }
    for(size_t i=1;i<h->count;++i) {
        LVPanelSkill value=h->skills[i];size_t j=i;
        while(j && (h->skills[j-1].summoner>value.summoner ||
              (h->skills[j-1].summoner==value.summoner && h->skills[j-1].slot_index>value.slot_index))) {
            h->skills[j]=h->skills[j-1];--j;
        }h->skills[j]=value;
    }
    h->result=partial ? LV_TARGET_PARTIAL : LV_TARGET_READY;h->reason=partial ? "partial" : "ready";
}
void lv_skill_panel_read(LVTargetRead read,void *context,const LVTargetSnapshot *s,unsigned enabled,LVSkillPanel *out) {
    if(!out)return;
    memset(out,0,sizeof(*out));out->enabled=enabled!=0;out->reason="disabled";out->classification_reason="not_requested";out->result=LV_TARGET_READY;
    if(!enabled)return;
    out->result=LV_TARGET_UNREADABLE;out->reason="snapshot_unavailable";
    if(!read || !s || s->count>LV_TARGET_MAX_ACTORS || (s->result!=LV_TARGET_READY && s->result!=LV_TARGET_PARTIAL))return;
    size_t local=SIZE_MAX;
    for(size_t i=0;i<s->count;++i)if(s->actors[i].is_local) {
        if(local!=SIZE_MAX){out->reason="local_ambiguous";return;}local=i;
    }
    if(local==SIZE_MAX || !s->actors[local].values_ok || !s->actors[local].object_id_ok ||
        !s->actors[local].object_id || !unique(s,local) ||
        (s->actors[local].camp!=1 && s->actors[local].camp!=2)){out->reason="local_unavailable";return;}
    Reader r={read,context};
    if(!identity(&r,&s->actors[local]) || !battle(&r,s)){out->reason="local_or_battle_unavailable";return;}
    out->result=LV_TARGET_READY;out->reason="ready";
    for(size_t i=0;i<s->count;++i) {
        const LVTargetActor *a=&s->actors[i];
        if(a->is_local || !a->values_ok || !a->classification_ok || !a->is_hero ||
            !a->object_id_ok || !a->object_id || !unique(s,i) || a->camp!=(s->actors[local].camp^3))continue;
        if(out->count==LV_PANEL_MAX_HEROES){out->truncated=1;out->result=LV_TARGET_PARTIAL;continue;}
        hero(&r,a,&out->heroes[out->count]);
        if(out->heroes[out->count].result!=LV_TARGET_READY)out->result=LV_TARGET_PARTIAL;
        ++out->count;
    }
    for(size_t i=1;i<out->count;++i) {
        LVPanelHero value=out->heroes[i];size_t j=i;
        while(j && out->heroes[j-1].object_id>value.object_id){out->heroes[j]=out->heroes[j-1];--j;}
        out->heroes[j]=value;
    }
    if(!identity(&r,&s->actors[local]) || !battle(&r,s)) {
        memset(out->heroes,0,sizeof(out->heroes));out->count=0;out->result=LV_TARGET_CHANGED;
        out->reason="local_or_battle_changed";return;
    }
    if(out->result==LV_TARGET_PARTIAL)out->reason="partial";
}

/* This bounded vector is a resource-ID list in hero configuration, not a
   skill pointer list. The native GetRSkill helpers select its last positive ID. */
#define CONFIG_SKILLS_MAX 64
typedef struct {uint64_t manager,config,begin,end;size_t count;int32_t ids[CONFIG_SKILLS_MAX];} SkillConfig;
static int config_read(Reader *r,const LVTargetActor *a,unsigned sync,SkillConfig *c) {
    memset(c,0,sizeof(*c));uint64_t owner;
    if(!pointer(r,a->native+0xd0,&c->manager) || !c->manager ||
        !pointer(r,c->manager+(sync?0x18:0x28),&owner) || owner!=a->native ||
        !pointer(r,owner+(sync?0x78:0x190),&c->config) || !c->config ||
        !load(r,c->config+0x78,&c->begin,8) || !load(r,c->config+0x80,&c->end,8) ||
        c->begin<0x10000 || c->end>=(UINT64_C(1)<<48) || (c->begin&3) || (c->end&3) ||
        c->end<c->begin || (c->end-c->begin)%4 || c->end-c->begin>CONFIG_SKILLS_MAX*4)return 0;
    c->count=(size_t)((c->end-c->begin)/4);
    /* Resource ID vectors contain int32 elements and may be only 4-byte aligned.
       The vector pointers have separately validated alignment below. */
    return c->count && load(r,c->begin,c->ids,c->count*4);
}
static int config_same(Reader *r,const LVTargetActor *a,unsigned sync,const SkillConfig *c) {
    SkillConfig again;
    return config_read(r,a,sync,&again) && c->manager==again.manager && c->config==again.config &&
        c->begin==again.begin && c->end==again.end && c->count==again.count &&
        !memcmp(c->ids,again.ids,c->count*4);
}
static int config_index(const SkillConfig *c,uint32_t resource) {
    int index=-1;
    for(size_t i=0;i<c->count;++i)if(c->ids[i]>0 && (uint32_t)c->ids[i]==resource) {
        if(index>=0)return -1;
        index=(int)i;
    }
    return index;
}
static int default_resource(Reader *r,const LVPanelSkill *skill,uint64_t actor,uint32_t *resource) {
    uint64_t current,owner,def,slot_again,def_again;uint32_t id,res;
    if(!pointer(r,skill->slot+0x98,&current) || current!=skill->native ||
        !pointer(r,skill->native+0x108,&slot_again) || slot_again!=skill->slot ||
        !pointer(r,skill->slot+0xb0,&owner) || owner!=actor ||
        !pointer(r,skill->slot+0x90,&def) || !def ||
        !pointer(r,def+0x108,&slot_again) || slot_again!=skill->slot ||
        !load(r,def+0x20,&id,4) || !id || !load(r,def+0x44,&res,4) || !res)return 0;
    uint32_t id_after,res_after,current_id,current_res;
    if(!pointer(r,skill->slot+0x90,&def_again) || def_again!=def ||
        !load(r,def+0x20,&id_after,4) || id_after!=id ||
        !load(r,def+0x44,&res_after,4) || res_after!=res ||
        !load(r,skill->native+0x20,&current_id,4) || current_id!=skill->object_id ||
        !load(r,skill->native+0x44,&current_res,4) || current_res!=skill->resource_id ||
        !pointer(r,skill->slot+0x98,&current) || current!=skill->native ||
        !pointer(r,def+0x108,&slot_again) || slot_again!=skill->slot ||
        !pointer(r,skill->slot+0xb0,&owner) || owner!=actor)return 0;
    *resource=res;return 1;
}
static void clear_roles(LVPanelHero *h) {
    h->classification_ok=0;h->ultimate_resource_id=0;
    for(size_t j=0;j<h->count;++j){h->skills[j].role=h->skills[j].summoner?LV_PANEL_SUMMONER:LV_PANEL_UNKNOWN;
        h->skills[j].configured_index=-1;}
}
void lv_skill_panel_classify(LVTargetRead read,void *context,uint64_t base,const char *uuid,
                            const LVTargetSnapshot *s,LVSkillPanel *panel) {
    if(!panel || !panel->enabled)return;
    panel->classification_reason="engine_profile_unavailable";
    if(panel->count>LV_PANEL_MAX_HEROES)return;
    for(size_t i=0;i<panel->count;++i){
        if(panel->heroes[i].count>LV_PANEL_MAX_SKILLS){panel->count=0;return;}
        clear_roles(&panel->heroes[i]);
    }
    if(!s || (s->result!=LV_TARGET_READY && s->result!=LV_TARGET_PARTIAL) || !panel->count) {
        panel->classification_reason="snapshot_unavailable";return;
    }
    if(!read || s->count>LV_TARGET_MAX_ACTORS || !uuid || strcmp(uuid,LV_NATIVE_ENGINE_UUID) ||
        base<0x10000 || base>(UINT64_C(1)<<48)-0x523cf30)return;
    Reader r={read,context};uint64_t root,config,same;uint8_t sync,same_mode;
    if(!pointer(&r,base+0x523cf28,&root) || !root || !pointer(&r,root+0x18,&config) || !config ||
        !load(&r,config+0x1e,&sync,1) || sync>1){panel->classification_reason="engine_selector_unavailable";return;}
    size_t classified=0;
    for(size_t i=0;i<panel->count;++i) {
        LVPanelHero *h=&panel->heroes[i];const LVTargetActor *a=NULL;
        for(size_t j=0;j<s->count;++j)if(s->actors[j].object_id_ok && s->actors[j].object_id==h->object_id &&
            s->actors[j].resource_id==h->resource_id){if(a){a=NULL;break;}a=&s->actors[j];}
        if(!a || !a->values_ok || !a->classification_ok || !a->is_hero || !identity(&r,a))continue;
        SkillConfig c;
        if(!config_read(&r,a,sync,&c))continue;
        int ultimate=-1;
        for(size_t j=0;j<c.count;++j)if(c.ids[j]>0)ultimate=(int)j;
        if(ultimate<0 || config_index(&c,(uint32_t)c.ids[ultimate])!=ultimate)continue;
        h->ultimate_resource_id=(uint32_t)c.ids[ultimate];
        for(size_t j=0;j<h->count;++j) {
            LVPanelSkill *skill=&h->skills[j];
            if(skill->summoner || skill->ambiguous)continue;
            uint32_t resource;
            if(!default_resource(&r,skill,a->native,&resource))continue;
            int index=config_index(&c,resource);
            if(index<0)continue;
            skill->configured_index=index;
            skill->role=index==ultimate ? LV_PANEL_ULTIMATE : LV_PANEL_REGULAR;
        }
        if(!identity(&r,a) || !config_same(&r,a,sync,&c)) {clear_roles(h);continue;}
        unsigned complete=1;
        for(size_t j=0;j<h->count;++j)if(h->skills[j].role==LV_PANEL_UNKNOWN)complete=0;
        h->classification_ok=complete;classified+=complete;
    }
    if(!pointer(&r,base+0x523cf28,&same) || same!=root || !pointer(&r,root+0x18,&same) || same!=config ||
        !load(&r,config+0x1e,&same_mode,1) || same_mode!=sync) {
        for(size_t i=0;i<panel->count;++i)clear_roles(&panel->heroes[i]);
        panel->classification_reason="engine_selector_changed";return;
    }
    panel->classification_reason=classified==panel->count ? "ready" : "partial_or_unavailable";
}
int lv_skill_panel_skill_visible(const LVPanelSkill *skill,unsigned hide_small_skills) {
    return skill && !(hide_small_skills && skill->role==LV_PANEL_REGULAR);
}
const char *lv_skill_panel_role_name(LVPanelRole role) {
    switch(role){case LV_PANEL_REGULAR:return "regular";case LV_PANEL_ULTIMATE:return "ultimate";
        case LV_PANEL_SUMMONER:return "summoner";default:return "unknown";}
}

/* Named native BattleActor.skillMgr getter 395dc7c reads actor +200.
   Native GetSkill iterates manager +2d8/+2e0; its resource equality
   path is skill +668 -> wrapper +8 -> resource +c (ff1a6c/ff8b98).
   ff5bcc obtains trigger at +570; ff5c70 obtains node at +590.
   Node GetState/GetRemainCD use +10/+18, distinct from sync +18/+20.
   No game calls, clock arithmetic or persistent values are used here. */
static int logic_actor_identity(Reader *r,const LVTargetActor *a) {
    uint32_t id;int32_t res,camp;
    return a->logic_position_ok && a->logic_native &&
        load(r,a->logic_native+0x14,&id,4) && id==a->object_id &&
        load(r,a->logic_native+0xc4,&res,4) && res==a->resource_id &&
        load(r,a->logic_native+0x198,&camp,4) && camp==a->camp;
}
static int native_vector(Reader *r,uint64_t header,Vector *v) {
    memset(v,0,sizeof(*v));v->header=header;
    if(!pointer(r,header,&v->begin) || !pointer(r,header+8,&v->end) ||
        v->end<v->begin || (v->end-v->begin)%8 ||
        v->end-v->begin>LV_TARGET_MAX_SKILLS*8)return 0;
    v->count=(size_t)((v->end-v->begin)/8);
    if(v->count && !load(r,v->begin,v->entries,v->count*8))return 0;
    for(size_t i=0;i<v->count;++i) {
        if(!v->entries[i] || (v->entries[i]&7))return 0;
        for(size_t j=0;j<i;++j)if(v->entries[i]==v->entries[j])return 0;
    }
    return 1;
}
static int native_resource(Reader *r,uint64_t n,uint32_t *id) {
    uint64_t wrapper,config;
    return pointer(r,n+0x668,&wrapper) && wrapper && pointer(r,wrapper+8,&config) && config &&
        load(r,config+0xc,id,4) && *id;
}
void lv_skill_panel_native_cooldowns(LVTargetRead read,void *context,uint64_t base,const char *uuid,
                                    const LVTargetSnapshot *s,LVSkillPanel *panel) {
    if(!panel || !panel->enabled || panel->count>LV_PANEL_MAX_HEROES)return;
    for(size_t i=0;i<panel->count;++i) {
        if(panel->heroes[i].count>LV_PANEL_MAX_SKILLS)return;
        for(size_t j=0;j<panel->heroes[i].count;++j) {
            LVPanelSkill *k=&panel->heroes[i].skills[j];
            if(k->logic_cooldown_ok){k->cooldown_ok=0;k->cooldown_fixed=0;k->locked=0;}
            k->logic_cooldown_ok=0;k->logic_native=0;k->logic_cd_node=0;k->logic_remain_raw=0;
            k->logic_cooldown_reason="logic_profile_unavailable";
        }
    }
    if(!read || !s || s->count>LV_TARGET_MAX_ACTORS || !uuid || strcmp(uuid,LV_NATIVE_ENGINE_UUID) ||
        base<0x10000 || base>(UINT64_C(1)<<48)-0x523cf40 ||
        (s->result!=LV_TARGET_READY && s->result!=LV_TARGET_PARTIAL))return;
    Reader r={read,context};
    for(size_t i=0;i<panel->count;++i) {
        LVPanelHero *h=&panel->heroes[i];const LVTargetActor *a=NULL;
        for(size_t j=0;j<s->count;++j)if(s->actors[j].object_id_ok &&
            s->actors[j].object_id==h->object_id && s->actors[j].resource_id==h->resource_id) {
            if(a){a=NULL;break;}a=&s->actors[j];
        }
        uint64_t manager=0,owner=0;Vector list;
        int ready=a && identity(&r,a) && logic_actor_identity(&r,a) &&
            pointer(&r,a->logic_native+0x200,&manager) && manager &&
            pointer(&r,manager+0x28,&owner) && owner==a->logic_native &&
            native_vector(&r,manager+0x2d8,&list);
        for(size_t j=0;j<h->count;++j) {
            LVPanelSkill *k=&h->skills[j];
            k->logic_cooldown_reason=ready?"skill_not_found":"logic_manager_unavailable";
            if(!ready || k->ambiguous)continue;
            uint64_t found=0;unsigned matches=0,complete=1;
            for(size_t z=0;z<list.count;++z) {
                uint32_t res;
                if(!native_resource(&r,list.entries[z],&res)){complete=0;break;}
                if(res==k->resource_id){found=list.entries[z];++matches;}
            }
            if(!complete){k->logic_cooldown_reason="skill_configuration_unavailable";continue;}
            if(matches!=1){if(matches>1)k->logic_cooldown_reason="skill_ambiguous";continue;}
            uint64_t node=0,same=0;uint32_t res;uint8_t locked=0;int64_t remain=0;
            k->logic_native=found;k->logic_cooldown_reason="node_unavailable";
            if(!pointer(&r,found+0x580,&owner) || owner!=found ||
                !pointer(&r,found+0x590,&node) || !node ||
                !load(&r,node+0x10,&locked,1) || locked>1 ||
                !load(&r,node+0x18,&remain,8))continue;
            k->logic_cd_node=node;k->logic_remain_raw=remain;
            Vector again;
            if(!native_resource(&r,found,&res) || res!=k->resource_id ||
                !pointer(&r,found+0x580,&same) || same!=found ||
                !pointer(&r,found+0x590,&same) || same!=node ||
                !native_vector(&r,manager+0x2d8,&again) || again.begin!=list.begin || again.end!=list.end ||
                again.count!=list.count || memcmp(again.entries,list.entries,list.count*8) ||
                !pointer(&r,a->logic_native+0x200,&same) || same!=manager ||
                !pointer(&r,manager+0x28,&same) || same!=a->logic_native ||
                !identity(&r,a) || !logic_actor_identity(&r,a) ||
                !pointer(&r,k->slot+0x98,&same) || same!=k->native) {
                k->logic_cooldown_reason="identity_or_list_changed";continue;
            }
            k->logic_cooldown_ok=1;k->logic_cooldown_reason="ready";
            k->cooldown_fixed=remain<0?0:remain;k->locked=locked;k->cooldown_ok=1;
        }
    }
}
