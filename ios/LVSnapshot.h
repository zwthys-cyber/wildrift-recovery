#import <Foundation/Foundation.h>
@class LVMachReader;
#include "LVConfig.h"
#include "LVMinimap.h"
NSDictionary *LVReadTargetSnapshot(LVMachReader *reader, NSDictionary *imageMetadata, const LVConfig *config,
                                    const LVMinimapSettings *mapSettings);
