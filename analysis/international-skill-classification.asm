
; native ultimate accessors
00ff9f88: sub      sp, sp, #0x70
00ff9f8c: stp      x26, x25, [sp, #0x20]
00ff9f90: stp      x24, x23, [sp, #0x30]
00ff9f94: stp      x22, x21, [sp, #0x40]
00ff9f98: stp      x20, x19, [sp, #0x50]
00ff9f9c: stp      x29, x30, [sp, #0x60]
00ff9fa0: add      x29, sp, #0x60
00ff9fa4: mov      x19, x0
00ff9fa8: adrp     x8, #0x51aa000
00ff9fac: ldr      x8, [x8, #0xa68]
00ff9fb0: cbz      x8, #0xffa01c
00ff9fb4: sub      sp, sp, #0xa0
00ff9fb8: stp      x0, x1, [sp]
00ff9fbc: stp      x2, x3, [sp, #0x10]
00ff9fc0: stp      x4, x5, [sp, #0x20]
00ff9fc4: stp      x6, x7, [sp, #0x30]
00ff9fc8: stp      x8, x19, [sp, #0x40]
00ff9fcc: stp      x20, x21, [sp, #0x50]
00ff9fd0: stp      x22, x23, [sp, #0x60]
00ff9fd4: stp      x24, x25, [sp, #0x70]
00ff9fd8: stp      x26, x27, [sp, #0x80]
00ff9fdc: str      x28, [sp, #0x90]
00ff9fe0: mov      x0, sp
00ff9fe4: mov      x1, x29
00ff9fe8: mov      w2, #0xa0
00ff9fec: bl       #0x41fdc1c
00ff9ff0: ldp      x0, x1, [sp]
00ff9ff4: ldp      x8, x2, [sp, #0x10]
00ff9ff8: ldp      x19, x20, [sp, #0x20]
00ff9ffc: ldp      x21, x22, [sp, #0x30]
00ffa000: ldp      x23, x24, [sp, #0x40]
00ffa004: ldp      x25, x26, [sp, #0x50]
00ffa008: ldp      x27, x28, [sp, #0x60]
00ffa00c: ldp      x29, x30, [sp, #0x70]
00ffa010: add      sp, sp, x2
00ffa014: ret      
00ffa018: bl       #0x41fd89c
00ffa01c: ldr      x20, [x19, #0x28]
00ffa020: cbz      x20, #0xffa1c0
00ffa024: mov      x0, x20
00ffa028: bl       #0x101c544
00ffa02c: cbz      w0, #0xffa1c0
00ffa030: ldr      x23, [x20, #0x190]
00ffa034: ldp      x9, x8, [x23, #0x78]
00ffa038: sub      x8, x8, x9
00ffa03c: sbfx     x24, x8, #2, #0x20
00ffa040: mov      x22, sp
00ffa044: cmp      x24, #1
00ffa048: csinc    x8, x24, xzr, hi
00ffa04c: lsl      x21, x8, #2
00ffa050: stp      xzr, xzr, [sp, #8]
00ffa054: str      xzr, [sp]
00ffa058: adrp     x3, #0x45b4000
00ffa05c: add      x3, x3, #0x51b
00ffa060: mov      w25, #4
00ffa064: add      x0, x22, #0x10
00ffa068: mov      x1, x21
00ffa06c: mov      w2, #4
00ffa070: bl       #0x3c916e4
00ffa074: mov      x20, x0
00ffa078: cbnz     x0, #0xffa094
00ffa07c: cbz      x21, #0xffa090
00ffa080: mov      x0, x21
00ffa084: bl       #0x4586464
00ffa088: mov      x20, x0
00ffa08c: b        #0xffa094
00ffa090: mov      x20, #0
00ffa094: add      x8, x20, x24, lsl #2
00ffa098: str      x20, [sp]
00ffa09c: str      x8, [sp, #0x10]
00ffa0a0: str      w25, [sp, #0x18]
00ffa0a4: ldp      x10, x8, [x23, #0x78]
00ffa0a8: mov      x9, x20
00ffa0ac: cmp      x10, x8
00ffa0b0: b.eq     #0xffa134
00ffa0b4: sub      x9, x8, x10
00ffa0b8: sub      x11, x9, #4
00ffa0bc: cmp      x11, #0x1c
00ffa0c0: b.lo     #0xffa120
00ffa0c4: sub      x12, x20, x10
00ffa0c8: mov      x9, x20
00ffa0cc: cmp      x12, #0x20
00ffa0d0: b.lo     #0xffa124
00ffa0d4: lsr      x9, x11, #2
00ffa0d8: add      x11, x9, #1
00ffa0dc: and      x12, x11, #0x7ffffffffffffff8
00ffa0e0: lsl      x13, x12, #2
00ffa0e4: add      x9, x20, x13
00ffa0e8: add      x13, x10, x13
00ffa0ec: add      x10, x10, #0x10
00ffa0f0: add      x14, x20, #0x10
00ffa0f4: mov      x15, x12
00ffa0f8: ldp      q0, q1, [x10, #-0x10]
00ffa0fc: stp      q0, q1, [x14, #-0x10]
00ffa100: add      x10, x10, #0x20
00ffa104: add      x14, x14, #0x20
00ffa108: subs     x15, x15, #8
00ffa10c: b.ne     #0xffa0f8
00ffa110: mov      x10, x13
00ffa114: cmp      x11, x12
00ffa118: b.ne     #0xffa124
00ffa11c: b        #0xffa134
00ffa120: mov      x9, x20
00ffa124: ldr      w11, [x10], #4
00ffa128: str      w11, [x9], #4
00ffa12c: cmp      x10, x8
00ffa130: b.ne     #0xffa124
00ffa134: str      x9, [sp, #8]
00ffa138: sub      x9, x9, x20
00ffa13c: asr      x8, x9, #2
00ffa140: ubfx     x9, x9, #2, #0x20
00ffa144: sub      x9, x9, #1
00ffa148: mov      x21, x9
00ffa14c: tbnz     w21, #0x1f, #0xffa188
00ffa150: and      x9, x21, #0x7fffffff
00ffa154: cmp      x8, x9
00ffa158: b.ls     #0xffa1e4
00ffa15c: ldr      w1, [x20, x9, lsl #2]
00ffa160: sub      x9, x21, #1
00ffa164: cmp      w1, #1
00ffa168: b.lt     #0xffa148
00ffa16c: mov      x0, x19
00ffa170: mov      x2, #0
00ffa174: bl       #0xff8a2c
00ffa178: mov      x19, x0
00ffa17c: ldr      x20, [sp]
00ffa180: cbnz     x20, #0xffa18c
00ffa184: b        #0xffa1bc
00ffa188: cbz      x20, #0xffa1bc
00ffa18c: ldr      x23, [sp, #0x10]
00ffa190: sub      w2, w23, w20
00ffa194: adrp     x3, #0x45b4000
00ffa198: add      x3, x3, #0x51b
00ffa19c: add      x0, x22, #0x10
00ffa1a0: mov      x1, x20
00ffa1a4: bl       #0x3c91930
00ffa1a8: cmp      x23, x20
00ffa1ac: csinc    w8, w0, wzr, ne
00ffa1b0: tbnz     w8, #0, #0xffa1bc
00ffa1b4: mov      x0, x20
00ffa1b8: bl       #0x4586278
00ffa1bc: tbz      w21, #0x1f, #0xffa1c4
00ffa1c0: mov      x19, #0
00ffa1c4: mov      x0, x19
00ffa1c8: ldp      x29, x30, [sp, #0x60]
00ffa1cc: ldp      x20, x19, [sp, #0x50]
00ffa1d0: ldp      x22, x21, [sp, #0x40]
00ffa1d4: ldp      x24, x23, [sp, #0x30]
00ffa1d8: ldp      x26, x25, [sp, #0x20]
00ffa1dc: add      sp, sp, #0x70
00ffa1e0: ret      
00ffa1e4: bl       #0xffecb0
00ffa1e8: mov      x19, x0
00ffa1ec: mov      x0, sp
00ffa1f0: bl       #0x37b060
00ffa1f4: mov      x0, x19
00ffa1f8: bl       #0x4585984
00ffa1fc: bl       #0x1aa64
00ffa200: sub      sp, sp, #0x70
00ffa204: stp      x26, x25, [sp, #0x20]
00ffa208: stp      x24, x23, [sp, #0x30]
00ffa20c: stp      x22, x21, [sp, #0x40]
00ffa210: stp      x20, x19, [sp, #0x50]
00ffa214: stp      x29, x30, [sp, #0x60]
00ffa218: add      x29, sp, #0x60
00ffa21c: mov      x19, x0
00ffa220: adrp     x8, #0x51aa000
00ffa224: ldr      x8, [x8, #0xa70]
00ffa228: cbz      x8, #0xffa294
00ffa22c: sub      sp, sp, #0xa0
00ffa230: stp      x0, x1, [sp]
00ffa234: stp      x2, x3, [sp, #0x10]
00ffa238: stp      x4, x5, [sp, #0x20]
00ffa23c: stp      x6, x7, [sp, #0x30]
00ffa240: stp      x8, x19, [sp, #0x40]
00ffa244: stp      x20, x21, [sp, #0x50]
00ffa248: stp      x22, x23, [sp, #0x60]
00ffa24c: stp      x24, x25, [sp, #0x70]
00ffa250: stp      x26, x27, [sp, #0x80]
00ffa254: str      x28, [sp, #0x90]
00ffa258: mov      x0, sp
00ffa25c: mov      x1, x29
00ffa260: mov      w2, #0xa0
00ffa264: bl       #0x41fdc1c
00ffa268: ldp      x0, x1, [sp]
00ffa26c: ldp      x8, x2, [sp, #0x10]
00ffa270: ldp      x19, x20, [sp, #0x20]
00ffa274: ldp      x21, x22, [sp, #0x30]
00ffa278: ldp      x23, x24, [sp, #0x40]
00ffa27c: ldp      x25, x26, [sp, #0x50]
00ffa280: ldp      x27, x28, [sp, #0x60]
00ffa284: ldp      x29, x30, [sp, #0x70]
00ffa288: add      sp, sp, x2
00ffa28c: ret      
00ffa290: bl       #0x41fd89c
00ffa294: ldr      x20, [x19, #0x18]
00ffa298: cbz      x20, #0xffa438
00ffa29c: mov      x0, x20
00ffa2a0: bl       #0x101c560
00ffa2a4: cbz      w0, #0xffa438
00ffa2a8: ldr      x23, [x20, #0x78]
00ffa2ac: ldp      x9, x8, [x23, #0x78]
00ffa2b0: sub      x8, x8, x9
00ffa2b4: sbfx     x24, x8, #2, #0x20
00ffa2b8: mov      x22, sp
00ffa2bc: cmp      x24, #1
00ffa2c0: csinc    x8, x24, xzr, hi
00ffa2c4: lsl      x21, x8, #2
00ffa2c8: stp      xzr, xzr, [sp, #8]
00ffa2cc: str      xzr, [sp]
00ffa2d0: adrp     x3, #0x45b4000
00ffa2d4: add      x3, x3, #0x51b
00ffa2d8: mov      w25, #4
00ffa2dc: add      x0, x22, #0x10
00ffa2e0: mov      x1, x21
00ffa2e4: mov      w2, #4
00ffa2e8: bl       #0x3c916e4
00ffa2ec: mov      x20, x0
00ffa2f0: cbnz     x0, #0xffa30c
00ffa2f4: cbz      x21, #0xffa308
00ffa2f8: mov      x0, x21
00ffa2fc: bl       #0x4586464
00ffa300: mov      x20, x0
00ffa304: b        #0xffa30c
00ffa308: mov      x20, #0
00ffa30c: add      x8, x20, x24, lsl #2
00ffa310: str      x20, [sp]
00ffa314: str      x8, [sp, #0x10]
00ffa318: str      w25, [sp, #0x18]
00ffa31c: ldp      x10, x8, [x23, #0x78]
00ffa320: mov      x9, x20
00ffa324: cmp      x10, x8
00ffa328: b.eq     #0xffa3ac
00ffa32c: sub      x9, x8, x10
00ffa330: sub      x11, x9, #4
00ffa334: cmp      x11, #0x1c
00ffa338: b.lo     #0xffa398
00ffa33c: sub      x12, x20, x10
00ffa340: mov      x9, x20
00ffa344: cmp      x12, #0x20
00ffa348: b.lo     #0xffa39c
00ffa34c: lsr      x9, x11, #2
00ffa350: add      x11, x9, #1
00ffa354: and      x12, x11, #0x7ffffffffffffff8
00ffa358: lsl      x13, x12, #2
00ffa35c: add      x9, x20, x13
00ffa360: add      x13, x10, x13
00ffa364: add      x10, x10, #0x10
00ffa368: add      x14, x20, #0x10
00ffa36c: mov      x15, x12
00ffa370: ldp      q0, q1, [x10, #-0x10]
00ffa374: stp      q0, q1, [x14, #-0x10]
00ffa378: add      x10, x10, #0x20
00ffa37c: add      x14, x14, #0x20
00ffa380: subs     x15, x15, #8
00ffa384: b.ne     #0xffa370
00ffa388: mov      x10, x13
00ffa38c: cmp      x11, x12
00ffa390: b.ne     #0xffa39c
00ffa394: b        #0xffa3ac
00ffa398: mov      x9, x20
00ffa39c: ldr      w11, [x10], #4
00ffa3a0: str      w11, [x9], #4
00ffa3a4: cmp      x10, x8
00ffa3a8: b.ne     #0xffa39c
00ffa3ac: str      x9, [sp, #8]
00ffa3b0: sub      x9, x9, x20
00ffa3b4: asr      x8, x9, #2
00ffa3b8: ubfx     x9, x9, #2, #0x20
00ffa3bc: sub      x9, x9, #1
00ffa3c0: mov      x21, x9
00ffa3c4: tbnz     w21, #0x1f, #0xffa400
00ffa3c8: and      x9, x21, #0x7fffffff
00ffa3cc: cmp      x8, x9
00ffa3d0: b.ls     #0xffa45c
00ffa3d4: ldr      w1, [x20, x9, lsl #2]
00ffa3d8: sub      x9, x21, #1
00ffa3dc: cmp      w1, #1
00ffa3e0: b.lt     #0xffa3c0
00ffa3e4: mov      x0, x19
00ffa3e8: mov      x2, #0
00ffa3ec: bl       #0xff8f30
00ffa3f0: mov      x19, x0
00ffa3f4: ldr      x20, [sp]
00ffa3f8: cbnz     x20, #0xffa404
00ffa3fc: b        #0xffa434
00ffa400: cbz      x20, #0xffa434
00ffa404: ldr      x23, [sp, #0x10]
00ffa408: sub      w2, w23, w20
00ffa40c: adrp     x3, #0x45b4000
00ffa410: add      x3, x3, #0x51b
00ffa414: add      x0, x22, #0x10
00ffa418: mov      x1, x20
00ffa41c: bl       #0x3c91930
00ffa420: cmp      x23, x20
00ffa424: csinc    w8, w0, wzr, ne
00ffa428: tbnz     w8, #0, #0xffa434
00ffa42c: mov      x0, x20
00ffa430: bl       #0x4586278
00ffa434: tbz      w21, #0x1f, #0xffa43c
00ffa438: mov      x19, #0
00ffa43c: mov      x0, x19
00ffa440: ldp      x29, x30, [sp, #0x60]
00ffa444: ldp      x20, x19, [sp, #0x50]
00ffa448: ldp      x22, x21, [sp, #0x40]
00ffa44c: ldp      x24, x23, [sp, #0x30]

; get_createType 0x3945cf4
03945cf4: ldr      x8, [x0, #0x18]
03945cf8: ldr      w0, [x8, #0x510]
03945cfc: ret      
03945d00: ldr      x8, [x0, #0x18]
03945d04: ldr      w0, [x8, #0x514]
03945d08: ret      
03945d0c: ldr      x8, [x0, #0x18]
03945d10: ldrb     w8, [x8, #0x518]
03945d14: cmp      w8, #0
03945d18: cset     w0, ne
03945d1c: ret      
03945d20: ldr      x8, [x0, #0x18]
03945d24: ldrb     w8, [x8, #0x519]
03945d28: cmp      w8, #0
03945d2c: cset     w0, ne
03945d30: ret      
03945d34: ldr      x8, [x0, #0x18]
03945d38: ldrb     w8, [x8, #0x51a]
03945d3c: cmp      w8, #0
03945d40: cset     w0, ne
03945d44: ret      
03945d48: ldr      x8, [x0, #0x18]
03945d4c: ldr      w0, [x8, #0x51c]
03945d50: ret      
03945d54: stp      x20, x19, [sp, #-0x20]!
03945d58: stp      x29, x30, [sp, #0x10]
03945d5c: add      x29, sp, #0x10
03945d60: mov      x19, x0
03945d64: adrp     x20, #0xf276000
03945d68: ldrb     w8, [x20, #0xc44]
03945d6c: tbnz     w8, #0, #0x3945d90
03945d70: adrp     x0, #0xee22000
03945d74: add      x0, x0, #0x40
03945d78: bl       #0x172b24c
03945d7c: adrp     x0, #0xed74000
03945d80: add      x0, x0, #0x100
03945d84: bl       #0x172b24c
03945d88: mov      w8, #1
03945d8c: strb     w8, [x20, #0xc44]
03945d90: ldr      x8, [x19, #0x18]
03945d94: ldr      x20, [x8, #0x520]
03945d98: cbz      x20, #0x3945e00
03945d9c: ldr      x0, [x19, #0x98]!
03945da0: cbz      x0, #0x3945dbc
03945da4: ldr      x8, [x0, #0x10]
03945da8: mov      w9, w8
03945dac: cmp      x8, x20
03945db0: mov      w8, #-0x22222223
03945db4: ccmp     x9, x8, #4, eq
03945db8: b.ne     #0x3945df4

; GetFunctionTypeSync 0x3945fc8
03945fc8: stp      x20, x19, [sp, #-0x20]!
03945fcc: stp      x29, x30, [sp, #0x10]
03945fd0: add      x29, sp, #0x10
03945fd4: mov      x19, x0
03945fd8: adrp     x20, #0xf1f4000
03945fdc: ldrb     w8, [x20, #0x1b3]
03945fe0: tbz      w8, #0, #0x3946008
03945fe4: ldr      x19, [x19, #0x10]
03945fe8: adrp     x8, #0xed68000
03945fec: ldr      x0, [x8, #0x880]
03945ff0: ldr      w8, [x0, #0xe0]
03945ff4: cbz      w8, #0x3946030
03945ff8: mov      x0, x19
03945ffc: ldp      x29, x30, [sp, #0x10]
03946000: ldp      x20, x19, [sp], #0x20
03946004: b        #0x7c0f5f0
03946008: adrp     x0, #0xed68000
0394600c: add      x0, x0, #0x880
03946010: bl       #0x172b24c
03946014: mov      w8, #1
03946018: strb     w8, [x20, #0x1b3]
0394601c: ldr      x19, [x19, #0x10]
03946020: adrp     x8, #0xed68000
03946024: ldr      x0, [x8, #0x880]
03946028: ldr      w8, [x0, #0xe0]
0394602c: cbnz     w8, #0x3945ff8
03946030: bl       #0x172b3a8
03946034: mov      x0, x19
03946038: ldp      x29, x30, [sp, #0x10]
0394603c: ldp      x20, x19, [sp], #0x20
03946040: b        #0x7c0f5f0
03946044: stp      x20, x19, [sp, #-0x20]!
03946048: stp      x29, x30, [sp, #0x10]
0394604c: add      x29, sp, #0x10
03946050: mov      x19, x0
03946054: adrp     x20, #0xf1f4000
03946058: ldrb     w8, [x20, #0x1b4]
0394605c: tbz      w8, #0, #0x3946084
03946060: ldr      x19, [x19, #0x10]
03946064: adrp     x8, #0xed68000
03946068: ldr      x0, [x8, #0x880]
0394606c: ldr      w8, [x0, #0xe0]
03946070: cbz      w8, #0x39460ac
03946074: mov      x0, x19
03946078: ldp      x29, x30, [sp, #0x10]
0394607c: ldp      x20, x19, [sp], #0x20
03946080: b        #0x7c0f5f4
03946084: adrp     x0, #0xed68000
03946088: add      x0, x0, #0x880
0394608c: bl       #0x172b24c

; IsSummonerSkillSync 0x3946124
03946124: stp      x20, x19, [sp, #-0x20]!
03946128: stp      x29, x30, [sp, #0x10]
0394612c: add      x29, sp, #0x10
03946130: mov      x19, x0
03946134: adrp     x20, #0xf1f4000
03946138: ldrb     w8, [x20, #0x1b6]
0394613c: tbnz     w8, #0, #0x3946154
03946140: adrp     x0, #0xed68000
03946144: add      x0, x0, #0x880
03946148: bl       #0x172b24c
0394614c: mov      w8, #1
03946150: strb     w8, [x20, #0x1b6]
03946154: ldr      x19, [x19, #0x10]
03946158: adrp     x8, #0xed68000
0394615c: ldr      x0, [x8, #0x880]
03946160: ldr      w8, [x0, #0xe0]
03946164: cbnz     w8, #0x394616c
03946168: bl       #0x172b3a8
0394616c: mov      x0, x19
03946170: bl       #0x7c0f5fc
03946174: cmp      w0, #0
03946178: cset     w0, ne
0394617c: ldp      x29, x30, [sp, #0x10]
03946180: ldp      x20, x19, [sp], #0x20
03946184: ret      
03946188: stp      x20, x19, [sp, #-0x20]!
0394618c: stp      x29, x30, [sp, #0x10]
03946190: add      x29, sp, #0x10
03946194: mov      x19, x0
03946198: adrp     x20, #0xf1f4000
0394619c: ldrb     w8, [x20, #0x1b7]
039461a0: tbnz     w8, #0, #0x39461b8
039461a4: adrp     x0, #0xed68000
039461a8: add      x0, x0, #0x880
039461ac: bl       #0x172b24c
039461b0: mov      w8, #1
039461b4: strb     w8, [x20, #0x1b7]
039461b8: ldr      x19, [x19, #0x10]
039461bc: adrp     x8, #0xed68000
039461c0: ldr      x0, [x8, #0x880]
039461c4: ldr      w8, [x0, #0xe0]
039461c8: cbnz     w8, #0x39461d0
039461cc: bl       #0x172b3a8
039461d0: mov      x0, x19
039461d4: bl       #0x7c0f600
039461d8: cmp      w0, #0
039461dc: cset     w0, ne
039461e0: ldp      x29, x30, [sp, #0x10]
039461e4: ldp      x20, x19, [sp], #0x20
039461e8: ret      

; TYPE 332 .SkillType
; FIELDS [('value__', 16, False, 2269), ('Direction', 0, True, 2270), ('Position', 0, True, 2271), ('Target', 0, True, 2272)]

; TYPE 996 .SkillType
; FIELDS [('value__', 16, False, 6304), ('Normal', 0, True, 6305), ('Control', 0, True, 6306), ('Miss', 0, True, 6307), ('KillDragon', 0, True, 6308)]

; TYPE 18367 .ChooseChampionSkillCfg
; FIELDS [('heroSkillVidPair', 24, False, 143856)]

; TYPE 29363 star_res.ResHeroBaseAttrStruct
; FIELDS [('iSeqID', 16, False, 254148), ('iHeroBaseAttrKey', 20, False, 254149), ('iHeroId', 24, False, 254150), ('iVision', 28, False, 254151), ('iExpShareRadius', 32, False, 254152), ('iWarnRadius', 36, False, 254153), ('iAttackValueBase', 40, False, 254154), ('iSpellPowerBase', 44, False, 254155), ('iHPBase', 48, False, 254156), ('iMPBase', 52, False, 254157), ('iArmorBase', 56, False, 254158), ('iSpellResistBase', 60, False, 254159), ('iHPRecoverBase', 64, False, 254160), ('iMPRecoverBase', 68, False, 254161), ('iAttackSpeedBase', 72, False, 254162), ('iSpeedBase', 76, False, 254163), ('iCriDamageRateBase', 80, False, 254164), ('iRequiredAttr', 84, False, 254165)]

; TYPE 31613 star_res.ResHeroBaseAttr
; FIELDS [('dataPtr', 16, False, 275290), ('ptr2Ref', 0, False, 275291), ('subTypeObjectList', 8, False, 275292)]

; TYPE 33221 FrameEngineVisi.Common.CustomSkillConfig
; FIELDS [('_seriaTypeNo_ConfigVisi', 0, True, 298697), ('skillAsset', 16, False, 298698), ('customItemId', 24, False, 298699), ('btnScale', 32, False, 298700)]

; TYPE 33273 FrameEngineVisi.Common.HeroBaseAttrData
; FIELDS [('_seriaTypeNo_ConfigVisi', 0, True, 299196), ('seqID', 16, False, 299197), ('heroBaseAttrKey', 20, False, 299198), ('heroId', 24, False, 299199), ('vision', 28, False, 299200), ('expShareRadius', 32, False, 299201), ('warnRadius', 36, False, 299202), ('attackValueBase', 40, False, 299203), ('spellPowerBase', 44, False, 299204), ('hpBase', 48, False, 299205), ('mpBase', 52, False, 299206), ('armorBase', 56, False, 299207), ('spellResistBase', 60, False, 299208), ('hpRecoverBase', 64, False, 299209), ('mpRecoverBase', 68, False, 299210), ('attackSpeedBase', 72, False, 299211), ('speedBase', 76, False, 299212), ('criDamageRateBase', 80, False, 299213), ('requiredAttr', 84, False, 299214)]

; TYPE 33274 FrameEngineVisi.Common.HeroBaseAttrResObject
; FIELDS [('_seriaTypeNo_ConfigVisi', 0, True, 299215), ('heroBaseAttrList', 24, False, 299216)]

; TYPE 35881 FrameEngine.Logic.ParallelFlowEvaluatorSkillTypeCheckRes
; FIELDS [('TypeID', 0, True, 310384), ('_wrapperPool', 0, False, 310385)]

; TYPE 37040 FrameEngine.Interface.FlowActionStealSkill_SkillType
; FIELDS [('value__', 16, False, 314807), ('BasicSpell', 0, True, 314808), ('Ultimate', 0, True, 314809)]

; TYPE 37470 FrameEngine.Common.CmdSelectUseSkillType
; FIELDS [('value__', 16, False, 319093), ('SelectSkill', 0, True, 319094), ('EasterEggSelectSkill', 0, True, 319095), ('EasterEggRefreshSkill', 0, True, 319096), ('EasterEggReplaceSlot', 0, True, 319097)]

; TYPE 37697 FrameEngine.Common.HeroBaseAttrData
; FIELDS [('TypeID', 0, True, 320351), ('__Instance', 16, False, 320352), ('__InstanceLongValue', 24, False, 320353), ('NativeMap', 0, False, 320354), ('_wrapperPool', 8, False, 320355)]

; TYPE 37698 FrameEngine.Common.HeroBaseAttrResObject
; FIELDS [('TypeID', 0, True, 320356), ('_wrapperPool', 0, False, 320357)]

; TYPE 37898 FrameEngine.Common.SkillFunctionType
; FIELDS [('value__', 16, False, 321778), ('None', 0, True, 321779), ('BackHome', 0, True, 321780), ('Mark', 0, True, 321781), ('Teleport', 0, True, 321782), ('Flash', 0, True, 321783), ('Punish', 0, True, 321784), ('Heal', 0, True, 321785), ('Cleanse', 0, True, 321786), ('ZYHourglass', 0, True, 321787), ('HEXProtobelt', 0, True, 321788), ('UnbreakableSkill', 0, True, 321789), ('ReactivatingSkill', 0, True, 321790), ('WardingTotemSkill', 0, True, 321791), ('OracleLensSkill', 0, True, 321792), ('WBPUltimate', 0, True, 321793), ('ErLantern', 0, True, 321794), ('EnterCannon', 0, True, 321795), ('MagnetronEnchan', 0, True, 321796), ('Repulser', 0, True, 321797), ('Strafe', 0, True, 321798), ('HexFlash', 0, True, 321799), ('Houdini', 0, True, 321800), ('Castle', 0, True, 321801), ('WarmUp', 0, True, 321802), ('Evocation', 0, True, 321803), ('DieAnotherDay', 0, True, 321804), ('FlagOfCmd', 0, True, 321805), ('FeelTheBurn', 0, True, 321806), ('Vanish', 0, True, 321807), ('BladeWaltz', 0, True, 321808), ('ZYEpiphany', 0, True, 321809), ('Defensive', 0, True, 321810), ('ArtilleryCoverage', 0, True, 321811), ('FortuneCoin', 0, True, 321812), ('InitialL', 0, True, 321813), ('Subjugate', 0, True, 321814), ('InteractiveSkill', 0, True, 321815), ('Possession', 0, True, 321816), ('PersistLongRange', 0, True, 321817), ('HexGateChannel', 0, True, 321818), ('RavenousHydra', 0, True, 321819), ('StarBack', 0, True, 321820), ('StarHope', 0, True, 321821), ('StarChange', 0, True, 321822), ('StarBiuBiu', 0, True, 321823), ('StarRush', 0, True, 321824), ('StarExchange', 0, True, 321825), ('Evolution', 0, True, 321826), ('HexIceGun', 0, True, 321827), ('Galeforce', 0, True, 321828), ('Goredrinker', 0, True, 321829), ('Stridebreaker', 0, True, 321830), ('ChargeShot', 0, True, 321831), ('BellRingExpert', 0, True, 321832), ('SeriesForceMove', 0, True, 321833), ('SeriesTargeCast', 0, True, 321834), ('InterruptLikeRush', 0, True, 321835), ('MaxCount', 0, True, 321836)]

; TYPE 37953 FrameEngine.Common.SkillType
; FIELDS [('value__', 16, False, 322154), ('None', 0, True, 322155), ('BaseAttack', 0, True, 322156), ('Active', 0, True, 322157), ('Passive', 0, True, 322158), ('EquipActive', 0, True, 322159), ('EquipPassive', 0, True, 322160), ('SummonerSpell', 0, True, 322161), ('AttackSpell', 0, True, 322162), ('DropSpell', 0, True, 322163), ('RunesSpell', 0, True, 322164), ('ActorDynamicActive', 0, True, 322165), ('DecorationSpell', 0, True, 322166), ('DropPassive', 0, True, 322167), ('LaneTaskAward', 0, True, 322168)]
