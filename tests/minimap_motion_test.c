#include "LVMinimapMotion.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

static unsigned checks;
static void check(int value) { assert(value); ++checks; }
static void at(const LVMinimapMotion *m, size_t i, double t, double x, double y) {
    double u, v; check(lv_minimap_motion_position(m,i,t,&u,&v));
    check(fabs(u-x)<1e-8 && fabs(v-y)<1e-8);
}
static LVMinimapMarker marker(unsigned id,double x,double y) {
    return (LVMinimapMarker){.object_id=id,.resource_id=10000+(int)id,.ordinal=id,.u=x,.v=y};
}
int main(void) {
    LVMinimapMotion m;lv_minimap_motion_clear(&m);
    LVMinimapMarker a[2]={marker(1,.2,.2),marker(2,.7,.7)};
    check(lv_minimap_motion_update(&m,a,2,10,.15));check(!lv_minimap_motion_active(&m,10));
    at(&m,0,10,.2,.2);
    a[0].u=.24;a[0].v=.28;a[1].u=.72;
    check(lv_minimap_motion_update(&m,a,2,10.15,.15));check(lv_minimap_motion_active(&m,10.225));
    at(&m,0,10.225,.22,.24);at(&m,1,10.225,.71,.7);
    /* Reordering and an interrupted transition preserve each identity's
       displayed position; the next sample changes its destination only. */
    LVMinimapMarker reordered[2]={marker(2,.73,.7),marker(1,.28,.30)};
    check(lv_minimap_motion_update(&m,reordered,2,10.225,.15));
    at(&m,0,10.225,.71,.7);at(&m,1,10.225,.22,.24);
    at(&m,1,10.3,.25,.27);at(&m,1,11,.28,.30); /* no extrapolation */
    check(!lv_minimap_motion_active(&m,11));
    reordered[1].u=.9;reordered[1].v=.9;
    check(lv_minimap_motion_update(&m,reordered,2,11,.15));at(&m,1,11,.9,.9); /* teleport snaps */
    reordered[1].resource_id=12345;reordered[1].u=.85;
    check(lv_minimap_motion_update(&m,reordered,2,11.1,.15));at(&m,1,11.1,.85,.9); /* reused ID */
    check(lv_minimap_motion_update(&m,reordered,1,11.2,.15));check(m.count==1); /* removed/dead disappears */
    check(lv_minimap_motion_update(&m,NULL,0,11.3,.15));check(!m.count && !m.active);
    a[0]=marker(1,.5,.5);
    check(lv_minimap_motion_update(&m,a,1,11.4,.15));at(&m,0,11.4,.5,.5); /* reappearance snaps */
    a[1]=a[0];check(!lv_minimap_motion_update(&m,a,2,11.5,.15));check(!m.count && !m.active);
    a[0].u=NAN;check(!lv_minimap_motion_update(&m,a,1,11.6,.15));check(!m.count);
    a[0]=marker(1,.5,.5);a[0].v=1.1;check(!lv_minimap_motion_update(&m,a,1,11.6,.15));
    check(!lv_minimap_motion_update(&m,NULL,1,11.6,.15));
    check(!lv_minimap_motion_update(&m,a,LV_TARGET_MAX_ACTORS+1,11.6,.15));
    a[0]=marker(1,.5,.5);check(!lv_minimap_motion_update(&m,a,1,NAN,.15));
    check(!lv_minimap_motion_update(&m,a,1,11.6,0));
    double u,v;check(!lv_minimap_motion_position(&m,0,12,&u,&v));
    check(!lv_minimap_motion_update(NULL,a,1,12,.15));
    printf("Minimap motion: %u checks passed\n",checks);return 0;
}
