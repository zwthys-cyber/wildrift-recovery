#include "LVMinimap.h"
/* Numeric-only bridge for isolated original-instruction comparison. */
int project(int x, int z, float sx, float sz, float hw, float hh, double *u, double *v) {
    LVTargetSnapshot s = {.result=LV_TARGET_READY,.count=2};
    s.actors[0]=(LVTargetActor){.object_id=1,.camp=1,.is_local=1,.values_ok=1,.object_id_ok=1};
    s.actors[1]=(LVTargetActor){.object_id=2,.camp=2,.values_ok=1,.object_id_ok=1,.position_ok=1,
        .health_ok=1,.health_fixed=16384,.classification_ok=1,.is_hero=1,.position_fixed={x*16384LL,0,z*16384LL}};
    LVMinimapGeometry g={.ready=1,.reason="ready",.scale_x=sx,.scale_z=sz,.half_width=hw,.half_height=hh};
    LVMinimapSettings settings;lv_minimap_defaults(&settings);
    LVMinimapFrame f;lv_minimap_frame(&s,&g,&settings,&f);
    if(!f.ready || f.count!=1) return 0;
    *u=f.markers[0].u;*v=f.markers[0].v;return 1;
}
