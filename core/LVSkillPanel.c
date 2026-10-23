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
        if(!out->cd_node)out->cooldown_ok=1;
        else if(load(r,out->cd_node+0x18,&locked,1)) {
            out->locked=locked!=0;
            out->cooldown_ok=out->locked || load(r,out->cd_node+0x20,&out->cooldown_fixed,8);
        }
        if(out->cooldown_ok && out->cooldown_fixed<0)out->cooldown_fixed=0;
        if(!pointer(r,native+0x440,&same) || same!=out->cd_node)out->cooldown_ok=0;
    }
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
    memset(out,0,sizeof(*out));out->enabled=enabled!=0;out->reason="disabled";out->result=LV_TARGET_READY;
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
