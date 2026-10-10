00422e88: sub      sp, sp, #0x120
00422e8c: stp      x29, x30, [sp, #0xd0]
00422e90: str      x28, [sp, #0xe0]
00422e94: stp      x24, x23, [sp, #0xf0]
00422e98: stp      x22, x21, [sp, #0x100]
00422e9c: stp      x20, x19, [sp, #0x110]
00422ea0: add      x29, sp, #0xd0
00422ea4: mrs      x22, tpidr_el0
00422ea8: mov      x19, x0
00422eac: mov      x20, x1
00422eb0: ldr      x8, [x22, #0x28]
00422eb4: add      x21, x19, #0x190
00422eb8: sub      x24, x29, #0x40
00422ebc: add      x23, x19, #0x1b0
00422ec0: stur     x8, [x29, #-8]
00422ec4: adrp     x8, #0x557000
00422ec8: add      x8, x8, #0xb68
00422ecc: ldr      x0, [x0, #0x1b0]
00422ed0: stp      x8, x19, [x29, #-0x40]
00422ed4: stur     x24, [x29, #-0x20]
00422ed8: cmp      x0, x21
00422edc: str      xzr, [x19, #0x1b0]
00422ee0: b.eq     #0x422ef0
00422ee4: cbz      x0, #0x422f2c
00422ee8: mov      w8, #5
00422eec: b        #0x422ef8
00422ef0: mov      w8, #4
00422ef4: mov      x0, x21
00422ef8: ldr      x9, [x0]
00422efc: ldr      x8, [x9, x8, lsl #3]
00422f00: blr      x8
00422f04: ldur     x8, [x29, #-0x20]
00422f08: cbz      x8, #0x422f24
00422f0c: sub      x9, x29, #0x40
00422f10: cmp      x8, x9
00422f14: b.eq     #0x422f2c
00422f18: add      x9, x24, #0x20
00422f1c: str      x8, [x23]
00422f20: mov      x23, x9
00422f24: str      xzr, [x23]
00422f28: b        #0x422f44
00422f2c: ldur     x8, [x29, #-0x40]
00422f30: str      x21, [x23]
00422f34: ldr      x8, [x8, #0x18]
00422f38: sub      x0, x29, #0x40
00422f3c: mov      x1, x21
00422f40: blr      x8
00422f44: ldur     x0, [x29, #-0x20]
00422f48: sub      x8, x29, #0x40
00422f4c: cmp      x0, x8
00422f50: b.eq     #0x422f60
00422f54: cbz      x0, #0x422f74
00422f58: mov      w8, #5
00422f5c: b        #0x422f68
00422f60: mov      w8, #4
00422f64: sub      x0, x29, #0x40
00422f68: ldr      x9, [x0]
00422f6c: ldr      x8, [x9, x8, lsl #3]
00422f70: blr      x8
00422f74: ldr      x0, [x19, #0x2a0]
00422f78: add      x21, x19, #0x280
00422f7c: adrp     x8, #0x557000
00422f80: add      x8, x8, #0xbf8
00422f84: add      x24, sp, #0x60
00422f88: add      x23, x19, #0x2a0
00422f8c: cmp      x0, x21
00422f90: stp      x8, x19, [sp, #0x60]
00422f94: str      x24, [sp, #0x80]
00422f98: str      xzr, [x19, #0x2a0]
00422f9c: b.eq     #0x422fac
00422fa0: cbz      x0, #0x422fe8
00422fa4: mov      w8, #5
00422fa8: b        #0x422fb4
00422fac: mov      w8, #4
00422fb0: mov      x0, x21
00422fb4: ldr      x9, [x0]
00422fb8: ldr      x8, [x9, x8, lsl #3]
00422fbc: blr      x8
00422fc0: ldr      x8, [sp, #0x80]
00422fc4: cbz      x8, #0x422fe0
00422fc8: add      x9, sp, #0x60
00422fcc: cmp      x8, x9
00422fd0: b.eq     #0x422fe8
00422fd4: add      x9, x24, #0x20
00422fd8: str      x8, [x23]
00422fdc: mov      x23, x9
00422fe0: str      xzr, [x23]
00422fe4: b        #0x423000
00422fe8: ldr      x8, [sp, #0x60]
00422fec: str      x21, [x23]
00422ff0: ldr      x8, [x8, #0x18]
00422ff4: add      x0, sp, #0x60
00422ff8: mov      x1, x21
00422ffc: blr      x8
00423000: ldr      x0, [sp, #0x80]
00423004: add      x8, sp, #0x60
00423008: cmp      x0, x8
0042300c: b.eq     #0x42301c
00423010: cbz      x0, #0x423030
00423014: mov      w8, #5
00423018: b        #0x423024
0042301c: mov      w8, #4
00423020: add      x0, sp, #0x60
00423024: ldr      x9, [x0]
00423028: ldr      x8, [x9, x8, lsl #3]
0042302c: blr      x8
00423030: ldr      x0, [x19, #0x7d0]
00423034: add      x21, x19, #0x7b0
00423038: adrp     x8, #0x557000
0042303c: add      x8, x8, #0xc88
00423040: add      x24, sp, #0x30
00423044: add      x23, x19, #0x7d0
00423048: cmp      x0, x21
0042304c: stp      x8, x19, [sp, #0x30]
00423050: str      x24, [sp, #0x50]
00423054: str      xzr, [x19, #0x7d0]
00423058: b.eq     #0x423068
0042305c: cbz      x0, #0x4230a4
00423060: mov      w8, #5
00423064: b        #0x423070
00423068: mov      w8, #4
0042306c: mov      x0, x21
00423070: ldr      x9, [x0]
00423074: ldr      x8, [x9, x8, lsl #3]
00423078: blr      x8
0042307c: ldr      x8, [sp, #0x50]
00423080: cbz      x8, #0x42309c
00423084: add      x9, sp, #0x30
00423088: cmp      x8, x9
0042308c: b.eq     #0x4230a4
00423090: add      x9, x24, #0x20
00423094: str      x8, [x23]
00423098: mov      x23, x9
0042309c: str      xzr, [x23]
004230a0: b        #0x4230bc
004230a4: ldr      x8, [sp, #0x30]
004230a8: str      x21, [x23]
004230ac: ldr      x8, [x8, #0x18]
004230b0: add      x0, sp, #0x30
004230b4: mov      x1, x21
004230b8: blr      x8
004230bc: ldr      x0, [sp, #0x50]
004230c0: add      x8, sp, #0x30
004230c4: cmp      x0, x8
004230c8: b.eq     #0x4230d8
004230cc: cbz      x0, #0x4230ec
004230d0: mov      w8, #5
004230d4: b        #0x4230e0
004230d8: mov      w8, #4
004230dc: add      x0, sp, #0x30
004230e0: ldr      x9, [x0]
004230e4: ldr      x8, [x9, x8, lsl #3]
004230e8: blr      x8
004230ec: ldr      x0, [x19, #0x8c0]
004230f0: add      x21, x19, #0x8a0
004230f4: adrp     x8, #0x557000
004230f8: add      x8, x8, #0xd08
004230fc: mov      x24, sp
00423100: add      x23, x19, #0x8c0
00423104: cmp      x0, x21
00423108: stp      x8, x19, [sp]
0042310c: str      x24, [sp, #0x20]
00423110: str      xzr, [x19, #0x8c0]
00423114: b.eq     #0x423124
00423118: cbz      x0, #0x423160
0042311c: mov      w8, #5
00423120: b        #0x42312c
00423124: mov      w8, #4
00423128: mov      x0, x21
0042312c: ldr      x9, [x0]
00423130: ldr      x8, [x9, x8, lsl #3]
00423134: blr      x8
00423138: ldr      x8, [sp, #0x20]
0042313c: cbz      x8, #0x423158
00423140: mov      x9, sp
00423144: cmp      x8, x9
00423148: b.eq     #0x423160
0042314c: add      x9, x24, #0x20
00423150: str      x8, [x23]
00423154: mov      x23, x9
00423158: str      xzr, [x23]
0042315c: b        #0x423178
00423160: ldr      x8, [sp]
00423164: str      x21, [x23]
00423168: ldr      x8, [x8, #0x18]
0042316c: mov      x0, sp
00423170: mov      x1, x21
00423174: blr      x8
00423178: ldr      x0, [sp, #0x20]
0042317c: mov      x8, sp
00423180: cmp      x0, x8
00423184: b.eq     #0x423194
00423188: cbz      x0, #0x4231a8
0042318c: mov      w8, #5
00423190: b        #0x42319c
00423194: mov      w8, #4
00423198: mov      x0, sp
0042319c: ldr      x9, [x0]
004231a0: ldr      x8, [x9, x8, lsl #3]
004231a4: blr      x8
004231a8: cbz      x20, #0x4232e0
004231ac: ldrb     w8, [x20, #0xc]
004231b0: cbz      w8, #0x4231c8
004231b4: adrp     x8, #0x59f000
004231b8: ldr      w8, [x8, #0x194]
004231bc: cmp      w8, #1
004231c0: b.ge     #0x4231d4
004231c4: b        #0x4232e0
004231c8: ldr      w8, [x20, #8]
004231cc: cmp      w8, #1
004231d0: b.lt     #0x4232e0
004231d4: ldrb     w8, [x20, #0xd]
004231d8: cbz      w8, #0x4232e0
004231dc: ldr      x8, [x20]
004231e0: adrp     x1, #0x27000
004231e4: add      x1, x1, #0x39b ; 'libil2cpp.so:bss'
004231e8: mov      x0, x20
004231ec: ldr      x8, [x8, #0x20]
004231f0: blr      x8
004231f4: str      x0, [x19, #0x740]
004231f8: str      x0, [x19, #0xa0]
004231fc: cbnz     x0, #0x423220
00423200: ldr      x8, [x20]
00423204: adrp     x1, #0x28000
00423208: add      x1, x1, #0xbc9 ; 'libil2cpp.so'
0042320c: mov      x0, x20
00423210: ldr      x8, [x8, #0x20]
00423214: blr      x8
00423218: str      x0, [x19, #0xa0]
0042321c: cbz      x0, #0x4232e4
00423220: mov      w23, #0x2c50
00423224: mov      w8, #0x2c78
00423228: add      x0, x19, x23
0042322c: add      x21, x19, x8
00423230: bl       #0x50e4d0
00423234: ldr      x20, [x19, #0x2c80]
00423238: strb     wzr, [x21, #0x58]
0042323c: str      xzr, [x19, #0x2cc8]
00423240: str      xzr, [x19, #0x2cb8]
00423244: stp      xzr, xzr, [x21]
00423248: cbz      x20, #0x423274
0042324c: add      x1, x20, #8
00423250: mov      x0, #-1
00423254: bl       #0x54fd70
00423258: cbnz     x0, #0x423274
0042325c: ldr      x8, [x20]
00423260: mov      x0, x20
00423264: ldr      x8, [x8, #0x10]
00423268: blr      x8
0042326c: mov      x0, x20
00423270: bl       #0x50b304
00423274: add      x0, x19, x23
00423278: bl       #0x50e4fc
0042327c: add      x0, x19, #0x750
00423280: bl       #0x435ff4
00423284: add      x0, x19, #0x840
00423288: bl       #0x4360c4
0042328c: movi     v0.2d, #0000000000000000
00423290: add      x8, x19, #0x93c
00423294: mov      w9, #0x2cd8
00423298: mov      w0, #1
0042329c: str      xzr, [x19, #0x930]
004232a0: str      wzr, [x19, #0x3f8]
004232a4: str      xzr, [x19, #0x2d48]
004232a8: str      q0, [x8]
004232ac: add      x8, x19, x9
004232b0: strb     wzr, [x21, #0xd8]
004232b4: str      wzr, [x19, #0xe4]
004232b8: str      xzr, [x19, #0xe8]
004232bc: str      q0, [x19, #0xd0]
004232c0: strb     wzr, [x19, #0xe0]
004232c4: str      wzr, [x19, #0x94c]
004232c8: stp      q0, q0, [x8]
004232cc: stp      q0, q0, [x8, #0x20]
004232d0: str      q0, [x8, #0x40]
004232d4: str      wzr, [x19, #0x2d40]
004232d8: str      q0, [x19, #0x2d30]
004232dc: b        #0x4232e4
004232e0: mov      w0, wzr
004232e4: ldr      x8, [x22, #0x28]
004232e8: ldur     x9, [x29, #-8]
004232ec: cmp      x8, x9
004232f0: b.ne     #0x423310
004232f4: ldp      x20, x19, [sp, #0x110]
004232f8: ldr      x28, [sp, #0xe0]
004232fc: ldp      x22, x21, [sp, #0x100]
00423300: ldp      x24, x23, [sp, #0xf0]
00423304: ldp      x29, x30, [sp, #0xd0]
00423308: add      sp, sp, #0x120
0042330c: ret      
00423310: bl       #0x553f00 ; __stack_chk_fail
00423314: bl       #0x3860c0
00423318: bl       #0x3860c0
0042331c: bl       #0x3860c0
00423320: bl       #0x3860c0
