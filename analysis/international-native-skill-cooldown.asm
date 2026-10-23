01015078: ldrb     w8, [x19, #0x10]
0101507c: cbz      w8, #0x1015090
01015080: mov      w0, #1
01015084: ldp      x29, x30, [sp, #0x10]
01015088: ldp      x20, x19, [sp], #0x20
0101508c: ret      
01015090: ldr      x8, [x19, #0x18]
01015094: cmp      x8, #0
01015098: cset     w8, gt
0101509c: lsl      w0, w8, #1
010150a0: ldp      x29, x30, [sp, #0x10]
010150a4: ldp      x20, x19, [sp], #0x20
; cooldown caller 0x62f0 -> 0x101516c
; cooldown caller 0x6328 -> 0x1015164
; cooldown caller 0x6424 -> 0x10249b0
; cooldown caller 0x645c -> 0x102498c
; cooldown caller 0xff5bf0 -> 0x102498c
00ff5b90: ldr      x8, [x19, #0x660]
00ff5b94: cmp      x8, x9
00ff5b98: b.eq     #0xff5ba0
00ff5b9c: cbnz     x8, #0xff5bac
00ff5ba0: ldp      x29, x30, [sp, #0x10]
00ff5ba4: ldp      x20, x19, [sp], #0x20
00ff5ba8: ret      
00ff5bac: ldr      x8, [x8]
00ff5bb0: cmp      x8, x9
00ff5bb4: b.ne     #0xff5bc8
00ff5bb8: mov      w0, #0
00ff5bbc: ldp      x29, x30, [sp, #0x10]
00ff5bc0: ldp      x20, x19, [sp], #0x20
00ff5bc4: ret      
00ff5bc8: mov      w0, #0
00ff5bcc: add      x8, x19, #0x570
00ff5bd0: cmp      x8, x9
00ff5bd4: b.eq     #0xff5ba0
00ff5bd8: cbz      x8, #0xff5ba0
00ff5bdc: ldr      x9, [x8]
00ff5be0: mov      x10, #-0x2222222222222223
00ff5be4: cmp      x9, x10
00ff5be8: b.eq     #0xff5bb8
00ff5bec: mov      x0, x8
00ff5bf0: bl       #0x102498c
00ff5bf4: cbz      w0, #0xff5ba0
00ff5bf8: adrp     x8, #0x51aa000
00ff5bfc: ldr      x8, [x8, #0x900]
00ff5c00: cbz      x8, #0xff5c6c
00ff5c04: sub      sp, sp, #0xa0
00ff5c08: stp      x0, x1, [sp]
00ff5c0c: stp      x2, x3, [sp, #0x10]
00ff5c10: stp      x4, x5, [sp, #0x20]
; cooldown caller 0xff5ca8 -> 0x1015164
00ff5c48: ldp      x19, x20, [sp, #0x20]
00ff5c4c: ldp      x21, x22, [sp, #0x30]
00ff5c50: ldp      x23, x24, [sp, #0x40]
00ff5c54: ldp      x25, x26, [sp, #0x50]
00ff5c58: ldp      x27, x28, [sp, #0x60]
00ff5c5c: ldp      x29, x30, [sp, #0x70]
00ff5c60: add      sp, sp, x2
00ff5c64: ret      
00ff5c68: bl       #0x41fd89c
00ff5c6c: mov      w0, #0
00ff5c70: ldr      x19, [x19, #0x590]
00ff5c74: mov      x8, #-0x2222222222222223
00ff5c78: cmp      x19, x8
00ff5c7c: b.eq     #0xff5ba0
00ff5c80: cbz      x19, #0xff5ba0
00ff5c84: ldr      x8, [x19]
00ff5c88: mov      x9, #-0x2222222222222223
00ff5c8c: cmp      x8, x9
00ff5c90: b.eq     #0xff5bb8
00ff5c94: mov      x0, x19
00ff5c98: bl       #0x1014ff4
00ff5c9c: cmp      w0, #2
00ff5ca0: b.ne     #0xff5bb8
00ff5ca4: mov      x0, x19
00ff5ca8: bl       #0x1015164
00ff5cac: cmp      x0, #0
00ff5cb0: cset     w0, gt
00ff5cb4: ldp      x29, x30, [sp, #0x10]
00ff5cb8: ldp      x20, x19, [sp], #0x20
; cooldown caller 0xff5de4 -> 0x102498c
; cooldown caller 0xff5eb4 -> 0x1015164
; cooldown caller 0xff6878 -> 0x10249b0
; cooldown caller 0xff6930 -> 0x101516c
; cooldown caller 0xff6a6c -> 0x10249b0
; cooldown caller 0xff6b3c -> 0x101516c
; selected native field/clock accessor 0xff1a6c
00ff1a6c: mov      x8, #-0x2222222222222223
00ff1a70: cmp      x0, x8
00ff1a74: ccmp     x0, #0, #4, ne
00ff1a78: b.ne     #0xff1a84
00ff1a7c: mov      x0, #0
00ff1a80: ret      
00ff1a84: ldr      x9, [x0]
00ff1a88: cmp      x9, x8
00ff1a8c: b.ne     #0xff1a98
00ff1a90: mov      x0, #0
00ff1a94: ret      
00ff1a98: ldr      x0, [x0, #0x668]
00ff1a9c: ret      
; selected native field/clock accessor 0x32edfb0
; named skill-manager string reference 0x358153c -> 0x465f494
; named skill-manager string reference 0x3586148 -> 0x465f494
; named skill-manager string reference 0x35f4b34 -> 0x465f494
035f4b34: adrp     x1, #0x465f000
035f4b38: add      x1, x1, #0x494
035f4b3c: adrp     x2, #0x395d000
035f4b40: add      x2, x2, #0xc7c
035f4b44: mov      x3, #0
035f4b48: mov      x4, #0
035f4b4c: mov      x5, #0
035f4b50: bl       #0x395da84
; named skillMgr property getter 0x395dc7c
0395dc7c: ldr      x0, [x0, #0x200]
0395dc80: ret      
; named skillMgr property getter 0x35f9dd8
; named skillMgr property getter 0x3619494
; selected node accessor and trigger helper evidence (international-analysis run)
; GetState engine 0x1014ff4
01014ff4: stp      x20, x19, [sp, #-0x20]!
01014ff8: stp      x29, x30, [sp, #0x10]
01014ffc: add      x29, sp, #0x10
01015000: mov      x19, x0
01015004: adrp     x8, #0x51ab000
01015008: ldr      x8, [x8, #0x48]
0101500c: cbz      x8, #0x1015078
01015010: sub      sp, sp, #0xa0
01015014: stp      x0, x1, [sp]
01015018: stp      x2, x3, [sp, #0x10]
0101501c: stp      x4, x5, [sp, #0x20]
01015020: stp      x6, x7, [sp, #0x30]
01015024: stp      x8, x19, [sp, #0x40]
01015028: stp      x20, x21, [sp, #0x50]
0101502c: stp      x22, x23, [sp, #0x60]
01015030: stp      x24, x25, [sp, #0x70]
01015034: stp      x26, x27, [sp, #0x80]
01015038: str      x28, [sp, #0x90]
0101503c: mov      x0, sp
01015040: mov      x1, x29
01015044: mov      w2, #0xa0
01015048: bl       #0x41fdc1c
0101504c: ldp      x0, x1, [sp]
01015050: ldp      x8, x2, [sp, #0x10]
01015054: ldp      x19, x20, [sp, #0x20]
01015058: ldp      x21, x22, [sp, #0x30]
0101505c: ldp      x23, x24, [sp, #0x40]
01015060: ldp      x25, x26, [sp, #0x50]
01015064: ldp      x27, x28, [sp, #0x60]
01015068: ldp      x29, x30, [sp, #0x70]
0101506c: add      sp, sp, x2
01015070: ret      
01015074: bl       #0x41fd89c
01015078: ldrb     w8, [x19, #0x10]
0101507c: cbz      w8, #0x1015090
01015080: mov      w0, #1
01015084: ldp      x29, x30, [sp, #0x10]
01015088: ldp      x20, x19, [sp], #0x20
0101508c: ret      
; GetStateSync engine 0x10150ac
; engine node getters +18/+20/+28 0x1015164
01015164: ldr      x0, [x0, #0x18]
01015168: ret      
0101516c: ldr      x0, [x0, #0x20]
01015170: ret      
01015174: ldr      x0, [x0, #0x20]
01015178: ret      
0101517c: ldr      x0, [x0, #0x28]
01015180: ret      
; IsCDing/IsCDingSync helpers 0x102498c
0102498c: ldr      x0, [x0, #0x20]
01024990: cbz      x0, #0x10249ac
01024994: stp      x29, x30, [sp, #-0x10]!
01024998: mov      x29, sp
0102499c: bl       #0x1014ff4
010249a0: cmp      w0, #2
010249a4: cset     w0, eq
010249a8: ldp      x29, x30, [sp], #0x10
010249ac: ret      
010249b0: ldr      x0, [x0, #0x20]
010249b4: cbz      x0, #0x10249d0
010249b8: stp      x29, x30, [sp, #-0x10]!
010249bc: mov      x29, sp
010249c0: bl       #0x10150ac
010249c4: cmp      w0, #2
010249c8: cset     w0, eq
010249cc: ldp      x29, x30, [sp], #0x10
; trigger owner resource context 0x1024bf0
01024bf0: ldr      x19, [x19, #0x10]
01024bf4: mov      x0, x19
01024bf8: bl       #0xff1a6c
01024bfc: cbz      x0, #0x1024c30
01024c00: ldr      x8, [x0, #0x10]
01024c04: cbz      x8, #0x1024c44
01024c08: ldp      x8, x9, [x8, #0x120]
01024c0c: cmp      x9, x8
01024c10: b.eq     #0x1024d00
01024c14: ldr      x21, [x8]
01024c18: add      x20, x21, #8
01024c1c: mov      x8, #-0x2222222222222223
; selected native summoner manager evidence (international-analysis run)
; native summoner GetSkill +60/+68 list +74 resource 0x1001d60
01001d60: stp      x22, x21, [sp, #-0x30]!
01001d64: stp      x20, x19, [sp, #0x10]
01001d68: stp      x29, x30, [sp, #0x20]
01001d6c: add      x29, sp, #0x20
01001d70: mov      x19, x1
01001d74: mov      x20, x0
01001d78: adrp     x8, #0x51aa000
01001d7c: ldr      x8, [x8, #0xc18]
01001d80: cbz      x8, #0x1001dec
01001d84: sub      sp, sp, #0xa0
01001d88: stp      x0, x1, [sp]
01001d8c: stp      x2, x3, [sp, #0x10]
01001d90: stp      x4, x5, [sp, #0x20]
01001d94: stp      x6, x7, [sp, #0x30]
01001d98: stp      x8, x19, [sp, #0x40]
01001d9c: stp      x20, x21, [sp, #0x50]
01001da0: stp      x22, x23, [sp, #0x60]
01001da4: stp      x24, x25, [sp, #0x70]
01001da8: stp      x26, x27, [sp, #0x80]
01001dac: str      x28, [sp, #0x90]
01001db0: mov      x0, sp
01001db4: mov      x1, x29
01001db8: mov      w2, #0xa0
01001dbc: bl       #0x41fdc1c
01001dc0: ldp      x0, x1, [sp]
01001dc4: ldp      x8, x2, [sp, #0x10]
01001dc8: ldp      x19, x20, [sp, #0x20]
01001dcc: ldp      x21, x22, [sp, #0x30]
01001dd0: ldp      x23, x24, [sp, #0x40]
01001dd4: ldp      x25, x26, [sp, #0x50]
01001dd8: ldp      x27, x28, [sp, #0x60]
01001ddc: ldp      x29, x30, [sp, #0x70]
01001de0: add      sp, sp, x2
01001de4: ret      
01001de8: bl       #0x41fd89c
01001dec: ldp      x9, x8, [x20, #0x60]
01001df0: sub      x10, x8, x9
01001df4: lsr      x11, x10, #3
01001df8: cmp      w11, #1
01001dfc: b.lt     #0x1001e44
01001e00: mov      x22, #0
01001e04: b        #0x1001e1c
01001e08: add      x22, x22, #1
01001e0c: sub      x10, x8, x9
01001e10: lsr      x11, x10, #3
01001e14: cmp      x22, w11, sxtw
01001e18: b.ge     #0x1001e44
01001e1c: cmp      x22, x10, asr #3
01001e20: b.hs     #0x1001e5c
01001e24: ldr      x21, [x9, x22, lsl #3]
01001e28: cbz      x21, #0x1001e08
01001e2c: mov      x0, x21
01001e30: bl       #0xfefc48
01001e34: cmp      w0, w19
01001e38: b.eq     #0x1001e48
01001e3c: ldp      x9, x8, [x20, #0x60]
01001e40: b        #0x1001e08
01001e44: mov      x21, #0
01001e48: mov      x0, x21
01001e4c: ldp      x29, x30, [sp, #0x20]
01001e50: ldp      x20, x19, [sp, #0x10]
01001e54: ldp      x22, x21, [sp], #0x30
01001e58: ret      
01001e5c: bl       #0x1002d28
; sync summoner GetSkill +48/+50 list +44 resource 0x1001e60
01001e60: stp      x22, x21, [sp, #-0x30]!
01001e64: stp      x20, x19, [sp, #0x10]
01001e68: stp      x29, x30, [sp, #0x20]
01001e6c: add      x29, sp, #0x20
01001e70: mov      x19, x1
01001e74: mov      x20, x0
01001e78: adrp     x8, #0x51aa000
01001e7c: ldr      x8, [x8, #0xc20]
01001e80: cbz      x8, #0x1001eec
01001e84: sub      sp, sp, #0xa0
01001e88: stp      x0, x1, [sp]
01001e8c: stp      x2, x3, [sp, #0x10]
01001e90: stp      x4, x5, [sp, #0x20]
01001e94: stp      x6, x7, [sp, #0x30]
01001e98: stp      x8, x19, [sp, #0x40]
01001e9c: stp      x20, x21, [sp, #0x50]
01001ea0: stp      x22, x23, [sp, #0x60]
01001ea4: stp      x24, x25, [sp, #0x70]
01001ea8: stp      x26, x27, [sp, #0x80]
01001eac: str      x28, [sp, #0x90]
01001eb0: mov      x0, sp
01001eb4: mov      x1, x29
01001eb8: mov      w2, #0xa0
01001ebc: bl       #0x41fdc1c
01001ec0: ldp      x0, x1, [sp]
01001ec4: ldp      x8, x2, [sp, #0x10]
01001ec8: ldp      x19, x20, [sp, #0x20]
01001ecc: ldp      x21, x22, [sp, #0x30]
01001ed0: ldp      x23, x24, [sp, #0x40]
01001ed4: ldp      x25, x26, [sp, #0x50]
01001ed8: ldp      x27, x28, [sp, #0x60]
01001edc: ldp      x29, x30, [sp, #0x70]
01001ee0: add      sp, sp, x2
01001ee4: ret      
01001ee8: bl       #0x41fd89c
01001eec: ldp      x9, x8, [x20, #0x48]
01001ef0: sub      x10, x8, x9
01001ef4: lsr      x11, x10, #3
01001ef8: cmp      w11, #1
01001efc: b.lt     #0x1001f44
01001f00: mov      x22, #0
01001f04: b        #0x1001f1c
01001f08: add      x22, x22, #1
01001f0c: sub      x10, x8, x9
01001f10: lsr      x11, x10, #3
01001f14: cmp      x22, w11, sxtw
01001f18: b.ge     #0x1001f44
01001f1c: cmp      x22, x10, asr #3
01001f20: b.hs     #0x1001f5c
01001f24: ldr      x21, [x9, x22, lsl #3]
01001f28: cbz      x21, #0x1001f08
01001f2c: mov      x0, x21
01001f30: bl       #0xfefc50
01001f34: cmp      w0, w19
01001f38: b.eq     #0x1001f48
01001f3c: ldp      x9, x8, [x20, #0x48]
01001f40: b        #0x1001f08
01001f44: mov      x21, #0
01001f48: mov      x0, x21
01001f4c: ldp      x29, x30, [sp, #0x20]
01001f50: ldp      x20, x19, [sp, #0x10]
01001f54: ldp      x22, x21, [sp], #0x30
01001f58: ret      
01001f5c: bl       #0x1002d2c
; summoner resource getters +74/+44 0xfefc48
00fefc48: ldr      w0, [x0, #0x74]
00fefc4c: ret      
00fefc50: ldr      w0, [x0, #0x44]
00fefc54: ret      
; native summoner manager consumer hero +360 0xff8b28
00ff8b28: mov      x0, x23
00ff8b2c: bl       #0x1fafccc
00ff8b30: mov      x21, x0
00ff8b34: cbz      x0, #0xff8b4c
00ff8b38: ldr      x0, [x21, #0x360]
00ff8b3c: cbz      x0, #0xff8b4c
00ff8b40: mov      x1, x20
00ff8b44: bl       #0x1001d60
00ff8b48: cbnz     x0, #0xff8e88
00ff8b4c: ldr      x8, [x19, #0x2e0]
00ff8b50: ldr      x9, [x19, #0x2d8]
00ff8b54: sub      x8, x8, x9
00ff8b58: lsr      x9, x8, #3
00ff8b5c: cmp      w9, #1
; sync summoner manager consumer hero +198 0xff9030
00ff9030: bl       #0xffeb18
00ff9034: mov      x21, x0
00ff9038: cbz      x0, #0xff9050
00ff903c: ldr      x0, [x21, #0x198]
00ff9040: cbz      x0, #0xff9050
00ff9044: mov      x1, x20
00ff9048: bl       #0x1001e60
00ff904c: cbnz     x0, #0xff9384
