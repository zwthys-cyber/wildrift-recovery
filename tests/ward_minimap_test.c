#include "LVMinimap.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
static LVTargetSnapshot snapshot;
static LVMinimapSettings settings;
static LVMinimapGeometry geometry;
static LVMinimapFrame frame;
static unsigned checks;
static void check(int v) { assert(v);++checks; }
static void setup(unsigned camp) {
    memset(&snapshot,0,sizeof(snapshot));snapshot.result=LV_TARGET_READY;snapshot.count=9;
    lv_minimap_defaults(&settings);
    geometry=(LVMinimapGeometry){.ready=1,.reason="ready",.scale_x=2,.scale_z=2,.half_width=100,.half_height=100};
    for(size_t i=0;i<snapshot.count;++i) {
        snapshot.actors[i]=(LVTargetActor){.object_id=(uint32_t)i+1,.object_id_ok=1,.resource_id=10000+(int)i,
            .values_ok=1,.classification_ok=1,.ward_classification_ok=1,.health_ok=1,.health_fixed=16384,
            .position_ok=1,.position_fixed={0,0,0},.camp=(int32_t)(i?3-camp:camp),.is_local=i==0,
            .is_hero=i<6,.is_ward=i>=6};
    }
    snapshot.actors[7].camp=(int32_t)camp; /* friendly ward */
    snapshot.actors[8].is_ward=0;snapshot.actors[8].is_monster=1; /* not a ward, even with same resource */
}
static void sample(unsigned enabled) { lv_minimap_frame_with_wards(&snapshot,&geometry,&settings,enabled,&frame); }
static const LVMinimapMarker *ward(void) {
    for(size_t i=0;i<frame.count;++i) if(frame.markers[i].is_ward) return &frame.markers[i];
    return NULL;
}
int main(void) {
    for(unsigned camp=1;camp<=2;++camp) {
        setup(camp);sample(1);check(frame.ready && frame.confirmed_enemies==5 && frame.count==6);
        check(frame.confirmed_wards==1 && frame.ward_markers==1 && ward()->object_id==7);
        check(!ward()->is_local && !ward()->ordinal && ward()->position_source==1);
        sample(0);check(frame.count==5 && !frame.ward_markers && !ward());
        lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(frame.count==5 && !ward());
        sample(1);check(ward()!=NULL);
        snapshot.actors[6].health_fixed=0;sample(1);check(!ward() && frame.dead_wards==1 && frame.count==5);
        snapshot.actors[6].health_fixed=-16384;sample(1);check(!ward() && frame.dead_wards==1);
        snapshot.actors[6].health_fixed=16384;snapshot.actors[6].health_ok=0;sample(1);
        check(!ward() && frame.unavailable_wards==1 && frame.count==5);
        setup(camp);snapshot.actors[6].ward_classification_ok=0;sample(1);check(!ward() && !frame.confirmed_wards);
        setup(camp);snapshot.actors[6].classification_ok=0;sample(1);check(!ward());
        setup(camp);snapshot.actors[6].object_id=snapshot.actors[7].object_id;sample(1);check(!ward());
        setup(camp);snapshot.actors[6].camp=4;sample(1);check(!ward());
        setup(camp);snapshot.actors[6].position_ok=0;sample(1);check(!ward() && frame.unavailable_wards==1);
        setup(camp);snapshot.actors[6].position_fixed[0]=500*16384;sample(1);check(!ward() && frame.outside_wards==1);
        snapshot.actors[6].logic_position_ok=1;snapshot.actors[6].logic_position_fixed[0]=10*16384;
        snapshot.actors[6].logic_position_fixed[2]=-20*16384;sample(1);
        check(ward() && ward()->position_source==2);
        check(fabs(ward()->u-(camp==1?.6:.4))<1e-8 && fabs(ward()->v-(camp==1?.7:.3))<1e-8);
        snapshot.actors[6].logic_position_fixed[0]=500*16384;sample(1);check(!ward() && frame.outside_wards==1);
        setup(camp);snapshot.actors[6].position_fixed[0]=52*16384;sample(1);
        check(ward() && ward()->edge_clamped && !frame.edge_clamped_enemies);
        setup(camp);snapshot.count=6;sample(1);check(!ward() && frame.count==5); /* removed immediately */
        setup(camp);geometry.ready=0;geometry.reason="geometry_unavailable";sample(1);check(!frame.count && !ward());
        setup(camp);snapshot.result=LV_TARGET_CHANGED;sample(1);check(!frame.count && !ward());
    }
    printf("Ward minimap: %u checks passed\n",checks);return 0;
}
