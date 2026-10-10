#import "LVHUDTrace.h"
#import "LVHUDControl.h"
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>

#define LV_TRACE_LIMIT (512*1024)
static NSString *traceDirectory(NSString *session) {
    if(!LVHUDSessionValid(session)) return nil;
    return [@"/private/var/tmp/lvlolm-hud-" stringByAppendingString:session.lowercaseString];
}
static int openDirectory(NSString *session,BOOL create) {
    NSString *path=traceDirectory(session);
    if(!path || getuid()!=0) return -1;
    if(create && mkdir(path.fileSystemRepresentation,0700) && errno!=EEXIST) return -1;
    int fd=open(path.fileSystemRepresentation,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);
    if(fd<0) return -1;
    struct stat st;
    if(fstat(fd,&st) || !S_ISDIR(st.st_mode) || st.st_uid!=0 || (st.st_mode&0777)!=0700) {
        close(fd); return -1;
    }
    return fd;
}
BOOL LVHUDWriteTrace(NSString *session,NSDictionary *trace) {
    if(![trace[@"session"] isEqual:session.lowercaseString]) return NO;
    NSData *data=[NSJSONSerialization dataWithJSONObject:trace options:0 error:NULL];
    if(!data.length || data.length>LV_TRACE_LIMIT) return NO;
    int directory=openDirectory(session,YES); if(directory<0) return NO;
    NSString *temporary=[@"pending-" stringByAppendingString:NSUUID.UUID.UUIDString];
    int fd=openat(directory,temporary.fileSystemRepresentation,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC,0600);
    if(fd<0) { close(directory); return NO; }
    const unsigned char *bytes=data.bytes; size_t offset=0;
    while(offset<data.length) {
        ssize_t n=write(fd,bytes+offset,data.length-offset);
        if(n<0 && errno==EINTR) continue;
        if(n<=0) break;
        offset+=(size_t)n;
    }
    BOOL success=offset==data.length;
    if(close(fd)) success=NO;
    if(success && renameat(directory,temporary.fileSystemRepresentation,directory,"positions.json")) success=NO;
    if(!success) unlinkat(directory,temporary.fileSystemRepresentation,0);
    close(directory); return success;
}
NSDictionary *LVHUDReadTrace(NSString *session) {
    int directory=openDirectory(session,NO); if(directory<0) return nil;
    int fd=openat(directory,"positions.json",O_RDONLY|O_NOFOLLOW|O_CLOEXEC); close(directory);
    if(fd<0) return nil;
    struct stat st;
    if(fstat(fd,&st) || !S_ISREG(st.st_mode) || st.st_uid!=0 || (st.st_mode&0777)!=0600 ||
        st.st_size<=0 || st.st_size>LV_TRACE_LIMIT) { close(fd); return nil; }
    NSMutableData *data=[NSMutableData dataWithLength:(NSUInteger)st.st_size];
    unsigned char *bytes=data.mutableBytes; size_t offset=0;
    while(offset<data.length) {
        ssize_t n=read(fd,bytes+offset,data.length-offset);
        if(n<0 && errno==EINTR) continue;
        if(n<=0) break;
        offset+=(size_t)n;
    }
    close(fd); if(offset!=data.length) return nil;
    id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if(![result isKindOfClass:NSDictionary.class] || ![result[@"session"] isEqual:session.lowercaseString] ||
        [result[@"format_version"] intValue]!=1 || ![result[@"samples"] isKindOfClass:NSArray.class] ||
        [result[@"samples"] count]>32) return nil;
    return result;
}
void LVHUDRemoveTrace(NSString *session) {
    int directory=openDirectory(session,NO); if(directory<0) return;
    unlinkat(directory,"positions.json",0); close(directory);
    rmdir(traceDirectory(session).fileSystemRepresentation);
}
