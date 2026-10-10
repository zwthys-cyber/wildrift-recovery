#import "LVHeroPortraits.h"

@interface LVHeroPortraits ()
@property(nonatomic, copy) NSString *directory;
@property(nonatomic, copy) NSDictionary *records;
@property(nonatomic, strong) NSCache<NSNumber *, id> *cache;
@end
@implementation LVHeroPortraits
- (instancetype)initWithDirectory:(NSString *)directory {
    if ((self = [super init])) {
        _directory = [directory copy];
        NSData *data = [NSData dataWithContentsOfFile:[directory stringByAppendingPathComponent:@"manifest.json"]];
        id manifest = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
        id records = [manifest isKindOfClass:NSDictionary.class] ? manifest[@"heroes"] : nil;
        _records = [records isKindOfClass:NSDictionary.class] ? records : @{};
        _cache = [NSCache new]; _cache.countLimit = 16;
    }
    return self;
}
- (NSUInteger)availableCount { return self.records.count; }
- (UIImage *)imageForResourceID:(int32_t)resourceID {
    NSNumber *key = @(resourceID); id cached = [self.cache objectForKey:key];
    if (cached) return cached == NSNull.null ? nil : cached;
    id record = self.records[key.stringValue];
    NSString *file = [record isKindOfClass:NSDictionary.class] ? record[@"file"] : nil;
    UIImage *image = nil;
    /* Unknown IDs keep their numeric marker; never guess from roster order. */
    if ([file isKindOfClass:NSString.class] && [file.lastPathComponent isEqualToString:file] &&
        [file.pathExtension isEqualToString:@"png"])
        image = [UIImage imageWithContentsOfFile:[self.directory stringByAppendingPathComponent:file]];
    [self.cache setObject:image ?: (id)NSNull.null forKey:key];
    return image;
}
@end
