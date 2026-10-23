#include "LVMinimap.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

static unsigned checks;
static void check(int value) { assert(value); ++checks; }
static void close_to(double a, double b) { check(fabs(a-b) < 1e-7); }
static LVTargetSnapshot snapshot;
static LVMinimapFrame frame;
static LVTargetActor hero(uint32_t id, int camp, int local, int x, int z) {
    LVTargetActor a = {.object_id=id, .resource_id=10000+(int)id, .camp=camp, .is_local=local,
        .values_ok=1, .object_id_ok=1, .classification_ok=1, .is_hero=1, .health_ok=1, .position_ok=1,
        .health_fixed=100*16384, .position_fixed={x*16384,0,z*16384}};
    return a;
}
static void roster(void) {
    memset(&snapshot, 0, sizeof(snapshot)); snapshot.result=LV_TARGET_READY; snapshot.count=11;
    snapshot.actors[0]=hero(1,1,1,-40,-40);
    for (size_t i=1;i<=5;++i) snapshot.actors[i]=hero((uint32_t)(7-i),2,0,10*(int)i,0);
    for (size_t i=6;i<11;++i) snapshot.actors[i]=hero((uint32_t)i+1,1,0,0,0);
}
/* Sparse fixture models independently specified IL2CPP classes, statics and
   instances. It rejects unmapped reads rather than pretending zero is data. */
typedef struct { uint64_t address; unsigned char bytes[1024]; size_t size; } Block;
static Block blocks[16]; static size_t block_count;
static uint64_t failure, change; static unsigned change_reads, change_byte;
static void block(uint64_t a,size_t size) { blocks[block_count++]=(Block){.address=a,.size=size}; }
static void put(uint64_t a,const void *data,size_t size) {
    for(size_t i=0;i<block_count;++i) if(a>=blocks[i].address && a-blocks[i].address+size<=blocks[i].size) {
        memcpy(blocks[i].bytes+a-blocks[i].address,data,size);return;
    }
    assert(0);
}
static void q(uint64_t a,uint64_t v) {put(a,&v,8);}
static void f(uint64_t a,float v) {put(a,&v,4);}
static int reader(void *ctx,uint64_t a,void *out,size_t size) {
    (void)ctx;
    if(a==failure) {memset(out,255,size);return 0;}
    for(size_t i=0;i<block_count;++i) if(a>=blocks[i].address && a-blocks[i].address+size<=blocks[i].size) {
        memcpy(out,blocks[i].bytes+a-blocks[i].address,size);
        if(a==change && ++change_reads==2) ((unsigned char *)out)[change_byte]^=1;
        return 1;
    }
    return 0;
}
static void geometry_fixture(void) {
    memset(blocks,0,sizeof(blocks));block_count=0;failure=change=change_reads=change_byte=0;
    block((UINT64_C(0x100000000)+LV_TARGET_CLASS_CACHE_OFFSET),8);block(0x200000+LV_TYPE_MINIMAP_CONTROLLER*8,40); /* cache */
    block(0x300000,0x100);block(0x300100,0x100); /* classes */
    block(0x310003,80); /* deliberately unaligned string addresses */
    block(0x400000,32);block(0x400100,32);block(0x500000,0x90);block(0x501000,0x340);
    q((UINT64_C(0x100000000)+LV_TARGET_CLASS_CACHE_OFFSET),0x200000);q(0x200000+LV_TYPE_MINIMAP_MAPPING*8,0x300000);q(0x200000+LV_TYPE_MINIMAP_CONTROLLER*8,0x300100);
    q(0x300010,0x310003);q(0x300018,0x31004a);put(0x310003,"UIMiniMappingMgr",17);
    q(0x300110,0x310020);q(0x300118,0x31004a);put(0x310020,"UIMainBattleMiniMapCtrl",23);
    q(0x3000b8,0x400000);q(0x3001b8,0x400100);q(0x400000,0x500000);q(0x400118,0x501000);
    q(0x500000,0x300000);q(0x501000,0x300100);
    f(0x500044,2);f(0x500048,3);f(0x500064,100);f(0x500068,150);
}
int main(void) {
    LVMinimapSettings settings;lv_minimap_defaults(&settings);
    LVMinimapGeometry geometry={.ready=1,.reason="ready",.scale_x=2,.scale_z=3,.half_width=100,.half_height=150};
    roster();lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.ready && frame.confirmed_enemies==5 && frame.count==5 && !frame.markers[0].is_local);
    settings.values[LV_MAP_LOCAL_POINT]=1; /* coordinate tests explicitly request the reference marker */
    roster();lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.ready && frame.confirmed_enemies==5 && frame.count==6);
    close_to(frame.markers[0].u,.1);close_to(frame.markers[0].v,.9);
    check(frame.markers[1].object_id==2 && frame.markers[5].object_id==6);
    close_to(frame.markers[1].u,1);close_to(frame.markers[1].v,.5);
    snapshot.actors[1].health_fixed=0;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.count==5 && frame.dead_enemies==1 && frame.confirmed_enemies==5);
    check(frame.markers[4].ordinal==4); /* dead number 5 remains absent */
    roster();snapshot.actors[1].position_ok=0;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.count==5 && frame.missing_enemies==1 && frame.confirmed_enemies==5);
    roster();snapshot.actors[1].health_ok=0;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.count==6 && frame.missing_enemies==0); /* HP failure does not invalidate a current position. */
    roster();snapshot.actors[1].classification_ok=0;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.confirmed_enemies==4 && frame.count==5);
    roster();snapshot.actors[1].is_hero=0;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.confirmed_enemies==4);
    roster();snapshot.actors[1].camp=4;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.confirmed_enemies==4);
    roster();snapshot.actors[1].object_id=snapshot.actors[2].object_id;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.confirmed_enemies==3 && frame.duplicate_ids==2 && frame.count==4);
    roster();snapshot.actors[1].object_id=0;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(frame.confirmed_enemies==4);
    roster();snapshot.actors[1].position_fixed[0]=INT64_MAX;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.outside_enemies==1 && frame.count==5);
    roster();snapshot.actors[1].position_fixed[0]=52*16384;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.count==6 && frame.edge_clamped_enemies==1 && frame.markers[5].edge_clamped);
    close_to(frame.markers[5].u,1);
    snapshot.actors[1].position_fixed[0]=500*16384;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.count==5 && frame.outside_enemies==1 && frame.edge_clamped_enemies==0);
    snapshot.actors[1].position_fixed[0]=-500*16384;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.count==5 && frame.outside_enemies==1);
    roster();snapshot.actors[1].minimap_health_fraction_ok=1;snapshot.actors[1].minimap_health_fraction_fixed=4096;
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.markers[5].health_fraction_ok && frame.markers[5].health_fraction==.25);
    roster();snapshot.result=LV_TARGET_CHANGED;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(!frame.ready && !frame.count);
    roster();snapshot.actors[1].is_local=1;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(!frame.ready && !frame.count);
    roster();snapshot.actors[0].camp=4;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(!frame.ready);
    roster();snapshot.actors[0].position_ok=0;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.ready && frame.count==5); /* roster can still render without local coordinate */
    roster();for(size_t i=0;i<snapshot.count;++i) snapshot.actors[i].camp^=3;
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(frame.rotation_degrees==180);
    close_to(frame.markers[0].u,.9);close_to(frame.markers[0].v,.1);
    check(lv_minimap_set(&settings,LV_MAP_ROTATION,"90"));lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    close_to(frame.markers[0].u,.1);close_to(frame.markers[0].v,.1);
    check(lv_minimap_set(&settings,LV_MAP_ROTATION,"270"));lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    close_to(frame.markers[0].u,.9);close_to(frame.markers[0].v,.9);
    check(!lv_minimap_set(&settings,LV_MAP_ROTATION,"45"));
    LVMinimapSettings before=settings;check(!lv_minimap_set(&settings,LV_MAP_LEFT,"99"));check(!memcmp(&before,&settings,sizeof(settings)));
    check(!lv_minimap_set(&settings,LV_MAP_WIDTH,"nan"));check(!lv_minimap_set(&settings,LV_MAP_HEIGHT,"inf"));
    check(!lv_minimap_set(&settings,LV_MAP_MANUAL,".5"));
    check(!lv_minimap_parse(&settings,"iosMapWidthPercent=20\niosMapRotation=45\n"));check(!memcmp(&before,&settings,sizeof(settings)));
    check(lv_minimap_parse(&settings,"drawMinimap=1\niosMapWidthPercent=20\niosMapHeightPercent=20\n"));
    char text[1024];size_t n=lv_minimap_serialize(&settings,text,sizeof(text));check(n && n<=sizeof(text));
    LVMinimapSettings restored;lv_minimap_defaults(&restored);check(lv_minimap_parse(&restored,text));check(!memcmp(&settings,&restored,sizeof(settings)));
    char tiny[2];check(lv_minimap_serialize(&settings,tiny,sizeof(tiny))==n && tiny[1]==0);
    /* An upgrade replaces only the untouched legacy rectangle. Non-rectangle
       preferences and every individually customized rectangle edge survive. */
    LVMinimapSettings legacy;lv_minimap_defaults(&legacy);
    check(lv_minimap_parse(&legacy,"iosMapLeftPercent=5\niosMapTopPercent=2\niosMapWidthPercent=15\niosMapHeightPercent=32\niosMapRotation=270\niosMapWorldSpan=140\niosMapManualProjection=1\niosMapReferences=0\niosMapMarkerSize=18\niosHUDInfoPanel=1\niosMapLocalPoint=1\n"));
    before=legacy;check(lv_minimap_migrate_legacy_rect(&legacy));
    check(legacy.values[LV_MAP_LEFT]>before.values[LV_MAP_LEFT] && legacy.values[LV_MAP_TOP]<before.values[LV_MAP_TOP] &&
          legacy.values[LV_MAP_WIDTH]>before.values[LV_MAP_WIDTH] && legacy.values[LV_MAP_HEIGHT]>before.values[LV_MAP_HEIGHT]);
    check(!memcmp(legacy.values+LV_MAP_ROTATION,before.values+LV_MAP_ROTATION,
                  (LV_MINIMAP_FIELDS-LV_MAP_ROTATION)*sizeof(float)));
    restored=legacy;check(!lv_minimap_migrate_legacy_rect(&legacy) && !memcmp(&legacy,&restored,sizeof(legacy)));
    for(size_t i=LV_MAP_LEFT;i<=LV_MAP_HEIGHT;++i) {
        LVMinimapSettings custom=before;custom.values[i]+=.25f;restored=custom;
        check(!lv_minimap_migrate_legacy_rect(&custom) && !memcmp(&custom,&restored,sizeof(custom)));
    }
    restored=before;restored.values[LV_MAP_LEFT]=20;
    check(lv_minimap_apply_recommended_rect(&restored));
    check(!memcmp(&legacy,&restored,sizeof(legacy))); /* explicit apply retains direction, toggles and size */
    restored=before;restored.values[LV_MAP_ROTATION]=45;legacy=restored;
    check(!lv_minimap_migrate_legacy_rect(&restored) && !memcmp(&legacy,&restored,sizeof(legacy)));
    check(!lv_minimap_apply_recommended_rect(NULL) && !lv_minimap_migrate_legacy_rect(NULL));
    lv_minimap_defaults(&settings);settings.values[LV_MAP_LOCAL_POINT]=1;roster();geometry.ready=0;geometry.reason="geometry_unavailable";
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(!frame.ready && !frame.count && frame.confirmed_enemies==5);
    check(lv_minimap_set(&settings,LV_MAP_MANUAL,"1"));lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.ready && frame.manual_projection);close_to(frame.markers[0].u,.5-40.0/110);
    geometry.full_map_showing=1;lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(!frame.ready && !frame.count);
    geometry.full_map_showing=0;geometry.reason="expanded_or_viewport_map";
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);check(!frame.ready && !frame.count);
    geometry_fixture();lv_minimap_read(reader,NULL,0x100000000,&geometry);
    check(geometry.ready && geometry.scale_x==2 && geometry.scale_z==3 && geometry.half_width==100);
    failure=0x500010;lv_minimap_read(reader,NULL,0x100000000,&geometry);check(!geometry.ready && !geometry.scale_x);
    geometry_fixture();change=0x500010;lv_minimap_read(reader,NULL,0x100000000,&geometry);check(!geometry.ready && !strcmp(geometry.reason,"geometry_changed"));
    geometry_fixture();change=0x500010;change_byte=4;lv_minimap_read(reader,NULL,0x100000000,&geometry);
    check(geometry.ready); /* unrelated camera/animation value must not hide every marker */
    geometry_fixture();change=0x500010;change_byte=0x34;lv_minimap_read(reader,NULL,0x100000000,&geometry);
    check(!geometry.ready && !strcmp(geometry.reason,"geometry_changed"));
    geometry_fixture();change=0x501330;lv_minimap_read(reader,NULL,0x100000000,&geometry);
    check(!geometry.ready && !strcmp(geometry.reason,"geometry_changed"));
    geometry_fixture();f(0x500044,NAN);lv_minimap_read(reader,NULL,0x100000000,&geometry);check(!geometry.ready && !strcmp(geometry.reason,"geometry_invalid"));
    geometry_fixture();unsigned char one=1;put(0x5012d9,&one,1);lv_minimap_read(reader,NULL,0x100000000,&geometry);check(!geometry.ready && geometry.full_map_showing);
    geometry_fixture();put(0x500010,&one,1);lv_minimap_read(reader,NULL,0x100000000,&geometry);check(!geometry.ready && geometry.viewport_mode);
    geometry_fixture();q(0x500000,0x300100);lv_minimap_read(reader,NULL,0x100000000,&geometry);check(!geometry.ready);
    /* The 0.7.3 device probe has five enemies: four (500,500) sentinels
       and one spawn just beyond the native edge. Only the spawn can render. */
    roster(); snapshot.count=6; lv_minimap_defaults(&settings);
    snapshot.actors[0].camp=2;
    for(size_t i=1;i<=5;++i) {
        snapshot.actors[i].camp=1; snapshot.actors[i].object_id=(uint32_t)i;
        snapshot.actors[i].position_fixed[0]=snapshot.actors[i].position_fixed[2]=8192000;
    }
    snapshot.actors[0].object_id=10;
    snapshot.actors[3].position_fixed[0]=-827548;
    snapshot.actors[3].position_fixed[2]=-798249;
    geometry=(LVMinimapGeometry){.ready=1,.reason="ready",.scale_x=4.158415794372559f,
        .scale_z=4.158415794372559f,.half_width=210,.half_height=210};
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.ready && frame.confirmed_enemies==5 && frame.count==1 && frame.outside_enemies==4);
    check(frame.markers[0].object_id==3 && frame.edge_clamped_enemies==1);
    close_to(frame.markers[0].u,1); check(frame.markers[0].v>0 && frame.markers[0].v<.02);
    lv_minimap_read(reader,NULL,UINT64_MAX,&geometry);check(!geometry.ready && !geometry.scale_x);
    lv_minimap_read(NULL,NULL,0x100000000,&geometry);check(!geometry.ready);
    /* Native attributes outrank an old visible UI percentage. */
    roster(); lv_minimap_defaults(&settings);
    geometry=(LVMinimapGeometry){.ready=1,.reason="ready",.scale_x=2,.scale_z=3,.half_width=100,.half_height=150};
    snapshot.actors[5].minimap_health_fraction_ok=1;
    snapshot.actors[5].minimap_health_fraction_fixed=12288;
    snapshot.actors[5].native_health_fraction_ok=1;
    snapshot.actors[5].native_health_fraction_fixed=4096;
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.markers[0].health_fraction_ok && frame.markers[0].health_source==1);
    close_to(frame.markers[0].health_fraction,.25);
    snapshot.actors[5].native_health_fraction_ok=0;
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(frame.markers[0].health_fraction_ok && frame.markers[0].health_source==2);
    close_to(frame.markers[0].health_fraction,.75);
    snapshot.actors[5].minimap_health_fraction_ok=0;
    lv_minimap_frame(&snapshot,&geometry,&settings,&frame);
    check(!frame.markers[0].health_fraction_ok && !frame.markers[0].health_source);
    printf("Minimap: %u checks passed\n",checks);return 0;
}
