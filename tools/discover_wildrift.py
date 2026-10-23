#!/usr/bin/env python3
"""CI-only static recovery of the exact international framework profile.

No game entry points are executed. Only selected layout/assembly evidence is
published; the complete metadata and original binaries remain private.
"""
import hashlib
import importlib.util
import json
import os
import re
import struct
from pathlib import Path
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from keystone import Ks, KS_ARCH_ARM64, KS_MODE_LITTLE_ENDIAN

ROOT = Path(__file__).resolve().parents[1]
if os.environ.get('GITHUB_ACTIONS') != 'true':
    raise SystemExit('Run recovery and validation in GitHub Actions only.')
fw = (ROOT/'inputs/UnityFramework').read_bytes()
raw = (ROOT/'inputs/global-metadata.dat').read_bytes()
assert hashlib.sha256(fw).hexdigest() == 'b82b1ece4d3017df66ccc68f4306d69d4df1fb69305fe8a287648008821f310c'
assert hashlib.sha256(raw).hexdigest() == '33ff8fc0b20f782af0b1cee13653b5c3b0073857704e5c41d667258a0e77a7f6'
cs=Cs(CS_ARCH_ARM64,CS_MODE_LITTLE_ENDIAN); cs.detail=True
ks=Ks(KS_ARCH_ARM64,KS_MODE_LITTLE_ENDIAN)

def locate(name, lines):
    listing=(ROOT/'analysis/ios-assembly'/name).read_text().splitlines()[:lines]
    parts=[]; previous=''
    for line in listing:
        instruction=line.split(':',1)[1].strip()
        mnemonic=instruction.split()[0]
        relative=mnemonic in ('adr','adrp','bl','b','cbz','cbnz','tbz','tbnz') or mnemonic.startswith('b.')
        address_pair=previous=='adrp' and mnemonic in ('ldr','str','add')
        large_memory=mnemonic in ('ldr','str') and any(int(x,16)>=0x300 for x in re.findall(r'#0x([0-9a-f]+)',instruction))
        parts.append(b'.{4}' if relative or address_pair or large_memory else re.escape(bytes(ks.asm(instruction)[0])))
        previous=mnemonic
    pattern=b''.join(parts)
    matches=[m.start() for m in re.finditer(pattern,fw,re.DOTALL) if m.start()%4==0]
    if len(matches)!=1: raise ValueError((name,'signature matches',matches))
    return matches[0]

def insns(start,size): return list(cs.disasm(fw[start:start+size],start))
def ref(pc):
    a,b=insns(pc,8)
    assert a.mnemonic=='adrp'
    if b.mnemonic=='add':return a.operands[1].imm+b.operands[2].imm
    if b.mnemonic in ('ldr','str'):return a.operands[1].imm+b.operands[1].mem.disp
    raise ValueError((hex(pc),b.mnemonic))

stream=locate('02ca2b04.asm',10)
loader=locate('02cc3438.asm',30)
names=locate('02cc4004.asm',30)
klass=locate('02cc42e8.asm',23)
constants=ref(stream+0x50)
key=ref(loader+0x64)
string_key=ref(names+0xac)
cache=ref(klass+0x2c)
spec=importlib.util.spec_from_file_location('metadata',ROOT/'tools/recover_ios_metadata.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
# Reuse the recovered algorithm with international, instruction-derived addresses.
source=(ROOT/'tools/recover_ios_metadata.py').read_text()
source=source.replace('0x102396d4',hex(key+32)).replace('0xeda2890',hex(constants)).replace('0x102396b4',hex(key)).replace('0x10239480',hex(string_key)).replace('0x10239580',hex(string_key+256))
namespace={'__file__':str(ROOT/'tools/recover_ios_metadata.py'),'__name__':'international_metadata'}
exec(compile(source,str(ROOT/'tools/recover_ios_metadata.py'),'exec'),namespace)
md=namespace['Metadata'](raw,fw,verify=False)
# Only DATA_CONST and file-backed DATA are scanned for registration tables.
segments=[];off=32
for _ in range(struct.unpack_from('<I',fw,16)[0]):
    cmd,size=struct.unpack_from('<II',fw,off)
    if cmd==0x19:
        nm=fw[off+8:off+24].split(b'\0')[0].decode();va,vs,fo,fs=struct.unpack_from('<4Q',fw,off+24)
        if nm in ('__DATA','__DATA_CONST'):segments.append((va,fo,fs))
    off+=size

def q(addr):
    for va,fo,fs in segments:
        if va<=addr and addr+8<=va+fs:return struct.unpack_from('<Q',fw,fo+addr-va)[0]
    raise ValueError('pointer outside file-backed DATA: '+hex(addr))

def candidates(count):
    pattern=struct.pack('<Q',count)
    for va,fo,fs in segments:
        for match in re.finditer(re.escape(pattern),fw[fo:fo+fs]):
            pos=match.start()
            if pos%8==0:yield va+pos

print('Recovered loader addresses',*[hex(x) for x in (stream,loader,names,klass,constants,key,string_key,cache)])
print('Metadata tables',md.tables)
print('Registration candidates',[(hex(a),[hex(q(a+d)) for d in (-0x20,-0x18,0,8)]) for a in candidates(md.tables['types']['count'])])
regs=[]
for addr in candidates(md.tables['types']['count']):
    reg=addr-0x50
    try:
        tc,tp=q(reg+0x30),q(reg+0x38);fp=q(addr+8)
        if not 0<tc<1000000:continue
        for i in range(6):q(fp+i*8);q(tp+i*8)
        regs.append(reg)
    except (ValueError,struct.error):pass
if len(regs)!=1:raise ValueError(('metadata registrations',list(map(hex,regs))))
codes=[]
for addr in candidates(md.tables['images']['count']):
    try:
        array=q(addr+8);module=q(array);name=q(module)
        end=fw.find(b'\0',name,name+256)
        if end>name and fw[name:end].endswith(b'.dll'):codes.append(addr-0x78)
    except (ValueError,struct.error):pass
if len(codes)!=1:raise ValueError(('code registrations',list(map(hex,codes))))
source=source.replace('0xfc1e1f8, 0xfe40a58',f'{hex(codes[0])}, {hex(regs[0])}')
namespace={'__file__':str(ROOT/'tools/recover_ios_metadata.py'),'__name__':'international_metadata'}
exec(compile(source,str(ROOT/'tools/recover_ios_metadata.py'),'exec'),namespace)
md=namespace['Metadata'](raw,fw,verify=False);native=namespace['NativeTables'](fw,md)
all_types=[md.type(i) for i in range(md.tables['types']['count'])]
by_name={(t['namespace'],t['name']):t for t in all_types}
baseline=json.loads((ROOT/'analysis/ios-layout.json').read_text())
selected=[];mapping={};methods={}
# Include all previously selected types so offsets can be checked independently.
for old in baseline['selected_types']:
    k=(old['namespace'],old['name'])
    if k not in by_name:continue
    t=by_name[k];mapping[str(old['index'])]=t['index']
    fields=native.fields(t);new_methods=native.methods(t)
    old_fields={f['name']:f for f in old['fields']}
    differences=[{'name':f['name'],'old':old_fields[f['name']]['offset'],'new':f['offset']} for f in fields if f['name'] in old_fields and f['offset']!=old_fields[f['name']]['offset']]
    old_methods={(x['name'],x['parameter_count']):x for x in old['methods']}
    for method in new_methods:
        om=old_methods.get((method['name'],method['parameter_count']))
        if om and om['native_address']:methods[hex(om['native_address'])]=hex(method['native_address'])
    selected.append(dict(t,fields=fields,methods=new_methods,changed_offsets=differences))
# UI types are kept in separate original reports.
for filename in ('ios-minimap-layout.json','ios-minimap-health-layout.json','ios-ward-layout.json'):
    report=json.loads((ROOT/'analysis'/filename).read_text())
    for old in report.get('selected_types',[]):
        k=(old['namespace'],old['name']);t=by_name[k];mapping[str(old['index'])]=t['index']
        fields=native.fields(t);new_methods=native.methods(t)
        for om in old.get('methods',[]):
            mm=[x for x in new_methods if x['name']==om['name'] and x['parameter_count']==om['parameter_count']]
            if len(mm)==1 and om['native_address']:methods[hex(om['native_address'])]=hex(mm[0]['native_address'])
        old_fields={f['name']:f for f in old.get('fields',[])}
        differences=[{'name':f['name'],'old':old_fields[f['name']]['offset'],'new':f['offset']} for f in fields if f['name'] in old_fields and f['offset']!=old_fields[f['name']]['offset']]
        if not any(x['index']==t['index'] for x in selected):selected.append(dict(t,fields=fields,methods=new_methods,changed_offsets=differences))
out=ROOT/'build';out.mkdir(exist_ok=True)
profile={'framework_uuid':'B59675EA-20A7-306E-97FF-5EA41A2B36C6','class_cache':hex(cache),'metadata_loader':hex(loader),'stream_wrapper':hex(stream),'string_getter':hex(names),'class_getter':hex(klass),'stream_constants':hex(constants),'header_key':hex(key),'string_keys':hex(string_key),'registration':{'code':hex(codes[0]),'metadata':hex(regs[0])},'tables':md.tables,'type_mapping':mapping,'method_mapping':methods,'selected_types':selected}
(out/'international-layout.json').write_text(json.dumps(profile,indent=2,ensure_ascii=False)+'\n')
# Relocate selected old assembly snippets using recovered named methods when possible.
assembly=[]
old_methods=[(int(a,16),int(b,16)) for a,b in methods.items()]
for path in sorted((ROOT/'analysis/ios-assembly').glob('*.asm')):
    try:start=int(path.name.split('-')[0].split('.')[0],16)
    except ValueError:continue
    nearest=sorted(((a,b) for a,b in old_methods if a<=start<a+0x1000),reverse=True)
    if not nearest:continue
    a,b=nearest[0];new=b+start-a
    assembly.append('\n; '+path.name+' -> '+hex(new))
    assembly.extend(f'{x.address:08x}: {x.mnemonic:8s} {x.op_str}' for x in insns(new,min(len(path.read_text().splitlines())*4,1024)))
(out/'international-selected.asm').write_text('\n'.join(assembly)+'\n')
print(json.dumps({k:v for k,v in profile.items() if k not in ('selected_types','method_mapping')},indent=2))
print('Changed managed offsets:',[(t['namespace']+'.'+t['name'],t['changed_offsets']) for t in selected if t['changed_offsets']])
