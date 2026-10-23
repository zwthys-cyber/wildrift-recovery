#include "LVMinimap.h"
#include <assert.h>
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
static LVTargetSnapshot snapshot;
static LVMinimapSettings settings;
static LVMinimapGeometry geometry;
static LVMinimapFrame frame;
static unsigned checks;
static void check(int v) { assert(v); ++checks; }
static void setup(int camp) {
    memset(&snapshot,0,sizeof(snapshot));snapshot.result=LV_TARGET_READY;snapshot.count=4;
    lv_minimap_defaults(&settings);
    geometry=(LVMinimapGeometry){.ready=1,.reason="ready",.scale_x=2,.scale_z=2,.half_width=100,.half_height=100};
    for(size_t i=0;i<snapshot.count;++i) snapshot.actors[i]=(LVTargetActor){
        .object_id=(uint32_t)i+1,.object_id_ok=1,.resource_id=10000+(int)i,.values_ok=1,
        .classification_ok=1,.ward_classification_ok=1,.health_ok=1,.health_fixed=7000*INT64_C(16384),
        .position_ok=1,.position_fixed={10*16384,0,-20*16384},.camp=(i==0?camp:3-camp),
        .is_local=i==0,.is_hero=i<2,.is_ward=i==2,.is_monster=i==3};
    snapshot.actors[3].camp=0; /* Established monster flag, independent of hero camps. */
}
static void sample(unsigned enabled) {lv_minimap_frame_with_layers(&snapshot,&geometry,&settings,1,enabled,&frame);}
static const LVMinimapMarker *monster(void) {
    for(size_t i=0;i<frame.count;++i) if(frame.markers[i].is_monster)return &frame.markers[i];
    return NULL;
}
int main(void) {
    for(int camp=1;camp<=2;++camp) {
        setup(camp);sample(1);
        check(frame.ready && frame.count==3 && frame.confirmed_enemies==1 && frame.ward_markers==1);
        check(frame.monster_markers==1 && frame.confirmed_monsters==1 && monster());
        check(monster()->object_id==4 && !monster()->ordinal && !monster()->is_ward && !monster()->is_local);
        check(monster()->health_read_ok && monster()->health_fixed==7000*INT64_C(16384));
        check(monster()->position_source==1 && !monster()->health_fraction_ok);
        check(fabs(monster()->u-(camp==1?.6:.4))<1e-8 && fabs(monster()->v-(camp==1?.7:.3))<1e-8);
        sample(0);check(frame.count==2 && !frame.monster_markers && !monster());
        lv_minimap_frame_with_wards(&snapshot,&geometry,&settings,1,&frame);check(frame.count==2);
        lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(frame.count==1);
        sample(1);snapshot.actors[3].health_fixed=0;sample(1);
        check(!monster() && frame.dead_monsters==1 && frame.count==2);
        snapshot.actors[3].health_fixed=-16384;sample(1);check(!monster() && frame.dead_monsters==1);
        setup(camp);snapshot.actors[3].health_ok=0;sample(1);check(!monster() && frame.unavailable_monsters==1);
        setup(camp);snapshot.actors[3].position_ok=0;sample(1);check(!monster() && frame.unavailable_monsters==1);
        setup(camp);snapshot.actors[3].position_fixed[0]=500*16384;sample(1);
        check(!monster() && frame.outside_monsters==1 && frame.count==2);
        setup(camp);snapshot.actors[3].classification_ok=0;sample(1);check(!monster() && !frame.confirmed_monsters);
        setup(camp);snapshot.actors[3].values_ok=0;sample(1);check(!monster());
        setup(camp);snapshot.actors[3].is_monster=0;sample(1);check(!monster());
        setup(camp);snapshot.actors[3].is_soldier=1;sample(1);check(!monster());
        setup(camp);snapshot.actors[3].is_building=1;sample(1);check(!monster());
        setup(camp);snapshot.actors[3].is_ward=1;sample(1);check(!monster());
        setup(camp);snapshot.actors[3].object_id_ok=0;sample(1);check(!monster());
        setup(camp);snapshot.actors[3].object_id=0;sample(1);check(!monster());
        setup(camp);snapshot.actors[3].object_id=snapshot.actors[2].object_id;sample(1);
        check(!monster() && !frame.ward_markers && frame.count==1);
        setup(camp);snapshot.actors[3].health_fixed=INT64_MAX;sample(1);
        check(monster() && monster()->health_fixed==INT64_MAX);
        setup(camp);snapshot.actors[3].health_fixed=1;sample(1);check(monster() && monster()->health_fixed==1);
        setup(camp);snapshot.actors[3].position_fixed[0]=52*16384;sample(1);
        check(monster() && monster()->edge_clamped && !frame.edge_clamped_enemies);
        setup(camp);settings.values[LV_MAP_MANUAL]=1;geometry.ready=0;sample(1);check(monster());
        setup(camp);geometry.full_map_showing=1;sample(1);check(!frame.count && !monster());
        setup(camp);geometry.viewport_mode=1;sample(1);check(!frame.count);
        setup(camp);snapshot.result=LV_TARGET_CHANGED;sample(1);check(!frame.count);
        setup(camp);sample(1);snapshot.count=3;sample(1);check(!monster() && !frame.monster_markers);
        setup(camp);sample(1);snapshot.actors[3].health_fixed=300*16384;sample(1);
        check(monster() && monster()->health_fixed==300*16384); /* Never retains previous HP. */
        setup(camp);snapshot.actors[3].is_hero=1;sample(1);check(!monster());
    }
    printf("Monster minimap: %u checks passed\n",checks);return 0;
}
