"""Resolve local 64-bit chained rebases in an in-memory analysis copy only.

Layout reference: Apple's include/mach-o/fixup-chains.h in apple-oss-distributions/dyld.
External binds remain encoded and cannot be mistaken for local file pointers.
This module never writes or executes a Mach-O image.
"""
import struct


def local_rebases(data):
    if data[:4] != b'\xcf\xfa\xed\xfe':
        raise ValueError('Expected a little-endian ARM64 Mach-O')
    segments=[];fixups=None;off=32
    for _ in range(struct.unpack_from('<I',data,16)[0]):
        cmd,size=struct.unpack_from('<II',data,off)
        if size<8 or off+size>len(data):raise ValueError('Invalid load command')
        if cmd==0x19:segments.append(struct.unpack_from('<4Q',data,off+24))
        if cmd==0x80000034:fixups=struct.unpack_from('<II',data,off+8)
        off+=size
    if fixups is None:return bytes(data),0
    def fileoff(address,size=8):
        for va,vs,fo,fs in segments:
            if va<=address and address+size<=va+fs:return fo+address-va
        raise ValueError('Chained pointer outside file-backed segment')
    base=next(va for va,vs,fo,fs in segments if fo==0 and fs)
    start,length=fixups
    if start+length>len(data):raise ValueError('Invalid chained fixup payload')
    version,starts=struct.unpack_from('<II',data,start)
    if version!=0:raise ValueError('Unsupported chained fixup version')
    image=start+starts;count=struct.unpack_from('<I',data,image)[0]
    if count!=len(segments):raise ValueError('Chained segment count mismatch')
    out=bytearray(data);visited=set();rebases=0
    for i in range(count):
        relative=struct.unpack_from('<I',data,image+4+i*4)[0]
        if not relative:continue
        desc=image+relative
        size,page,fmt,segment,maxptr,pages=struct.unpack_from('<IHHQIH',data,desc)
        if fmt not in (2,6):raise ValueError('Unsupported chained pointer format: '+str(fmt))
        for p in range(pages):
            first=struct.unpack_from('<H',data,desc+22+p*2)[0]
            if first==0xffff:continue
            starts_on_page=[]
            if first&0x8000:
                index=first&0x7fff
                while True:
                    if 22+index*2+2>size:raise ValueError('Chained start overflow')
                    value=struct.unpack_from('<H',data,desc+22+index*2)[0]
                    starts_on_page.append(value&0x7fff);index+=1
                    if value&0x8000:break
            else:starts_on_page=[first]
            for first in starts_on_page:
                address=base+segment+p*page+first
                while True:
                    if address in visited:raise ValueError('Repeated chained fixup')
                    visited.add(address);offset=fileoff(address)
                    word=struct.unpack_from('<Q',data,offset)[0]
                    step=(word>>51)&0xfff
                    if not word>>63:
                        if (word>>44)&0x7f:raise ValueError('Reserved rebase bits set')
                        target=(word&((1<<36)-1))|(((word>>36)&255)<<56)
                        if fmt==6:target+=base
                        struct.pack_into('<Q',out,offset,target);rebases+=1
                    if not step:break
                    address+=step*4
                    if (address-base-segment)//page!=p:raise ValueError('Chain escaped page')
    return bytes(out),rebases
