; FEProj UUID D5B32037-47A3-3EFF-B0E5-04B071EFBEE3
; native manager +1c0 skill lookup 0xfe3c8c
00fe3c8c: stp      x22, x21, [sp, #-0x30]!
00fe3c90: stp      x20, x19, [sp, #0x10]
00fe3c94: stp      x29, x30, [sp, #0x20]
00fe3c98: add      x29, sp, #0x20
00fe3c9c: mov      x19, x1
00fe3ca0: mov      x20, x0
00fe3ca4: adrp     x8, #0x51aa000
00fe3ca8: ldr      x8, [x8, #0x518]
00fe3cac: cbz      x8, #0xfe3d18
00fe3cb0: sub      sp, sp, #0xa0
00fe3cb4: stp      x0, x1, [sp]
00fe3cb8: stp      x2, x3, [sp, #0x10]
00fe3cbc: stp      x4, x5, [sp, #0x20]
00fe3cc0: stp      x6, x7, [sp, #0x30]
00fe3cc4: stp      x8, x19, [sp, #0x40]
00fe3cc8: stp      x20, x21, [sp, #0x50]
00fe3ccc: stp      x22, x23, [sp, #0x60]
00fe3cd0: stp      x24, x25, [sp, #0x70]
00fe3cd4: stp      x26, x27, [sp, #0x80]
00fe3cd8: str      x28, [sp, #0x90]
00fe3cdc: mov      x0, sp
00fe3ce0: mov      x1, x29
00fe3ce4: mov      w2, #0xa0
00fe3ce8: bl       #0x41fdc1c
00fe3cec: ldp      x0, x1, [sp]
00fe3cf0: ldp      x8, x2, [sp, #0x10]
00fe3cf4: ldp      x19, x20, [sp, #0x20]
00fe3cf8: ldp      x21, x22, [sp, #0x30]
00fe3cfc: ldp      x23, x24, [sp, #0x40]
00fe3d00: ldp      x25, x26, [sp, #0x50]
00fe3d04: ldp      x27, x28, [sp, #0x60]
00fe3d08: ldp      x29, x30, [sp, #0x70]
00fe3d0c: add      sp, sp, x2
00fe3d10: ret      
00fe3d14: bl       #0x41fd89c
00fe3d18: ldp      x9, x8, [x20, #0x28]
00fe3d1c: sub      x10, x8, x9
00fe3d20: lsr      x11, x10, #3
00fe3d24: cmp      w11, #1
00fe3d28: b.lt     #0xfe3d70
00fe3d2c: mov      x22, #0
00fe3d30: b        #0xfe3d48
00fe3d34: add      x22, x22, #1
00fe3d38: sub      x10, x8, x9
00fe3d3c: lsr      x11, x10, #3
00fe3d40: cmp      x22, w11, sxtw
00fe3d44: b.ge     #0xfe3d70
00fe3d48: cmp      x22, x10, asr #3
00fe3d4c: b.hs     #0xfe3e48
00fe3d50: ldr      x21, [x9, x22, lsl #3]
00fe3d54: cbz      x21, #0xfe3d34
00fe3d58: mov      x0, x21
00fe3d5c: bl       #0xfefc48
00fe3d60: cmp      w0, w19
00fe3d64: b.eq     #0xfe3dc4
00fe3d68: ldp      x9, x8, [x20, #0x28]
00fe3d6c: b        #0xfe3d34
00fe3d70: ldp      x9, x8, [x20, #0x58]
00fe3d74: sub      x10, x8, x9
00fe3d78: lsr      x11, x10, #3
00fe3d7c: cmp      w11, #1
00fe3d80: b.lt     #0xfe3dd8
00fe3d84: mov      x22, #0
00fe3d88: b        #0xfe3da4
00fe3d8c: ldp      x9, x8, [x20, #0x58]
00fe3d90: add      x22, x22, #1
00fe3d94: sub      x10, x8, x9
00fe3d98: lsr      x11, x10, #3
00fe3d9c: cmp      x22, w11, sxtw
00fe3da0: b.ge     #0xfe3dd8
00fe3da4: cmp      x22, x10, asr #3
00fe3da8: b.hs     #0xfe3e48
00fe3dac: ldr      x21, [x9, x22, lsl #3]
00fe3db0: cbz      x21, #0xfe3d90
00fe3db4: mov      x0, x21
00fe3db8: bl       #0xfefc48
00fe3dbc: cmp      w0, w19
00fe3dc0: b.ne     #0xfe3d8c
00fe3dc4: mov      x0, x21
00fe3dc8: ldp      x29, x30, [sp, #0x20]
00fe3dcc: ldp      x20, x19, [sp, #0x10]
00fe3dd0: ldp      x22, x21, [sp], #0x30
00fe3dd4: ret      
00fe3dd8: ldp      x9, x8, [x20, #0xd8]
00fe3ddc: sub      x10, x8, x9
00fe3de0: lsr      x11, x10, #3
00fe3de4: cmp      w11, #1
00fe3de8: b.lt     #0xfe3e30
00fe3dec: mov      x22, #0
00fe3df0: b        #0xfe3e0c
00fe3df4: ldp      x9, x8, [x20, #0xd8]
00fe3df8: add      x22, x22, #1
00fe3dfc: sub      x10, x8, x9
00fe3e00: lsr      x11, x10, #3
00fe3e04: cmp      x22, w11, sxtw
00fe3e08: b.ge     #0xfe3e30
00fe3e0c: cmp      x22, x10, asr #3
00fe3e10: b.hs     #0xfe3e48
00fe3e14: ldr      x21, [x9, x22, lsl #3]
00fe3e18: cbz      x21, #0xfe3df8
00fe3e1c: mov      x0, x21
00fe3e20: bl       #0xfefc48
00fe3e24: cmp      w0, w19
00fe3e28: b.ne     #0xfe3df4
00fe3e2c: b        #0xfe3dc4
00fe3e30: mov      x21, #0
00fe3e34: mov      x0, x21
00fe3e38: ldp      x29, x30, [sp, #0x20]
00fe3e3c: ldp      x20, x19, [sp, #0x10]
00fe3e40: ldp      x22, x21, [sp], #0x30
00fe3e44: ret      
00fe3e48: bl       #0xfe4aec
; sync manager +140 skill lookup 0xfe3e4c
00fe3e4c: stp      x22, x21, [sp, #-0x30]!
00fe3e50: stp      x20, x19, [sp, #0x10]
00fe3e54: stp      x29, x30, [sp, #0x20]
00fe3e58: add      x29, sp, #0x20
00fe3e5c: mov      x19, x1
00fe3e60: mov      x20, x0
00fe3e64: adrp     x8, #0x51aa000
00fe3e68: ldr      x8, [x8, #0x520]
00fe3e6c: cbz      x8, #0xfe3ed8
00fe3e70: sub      sp, sp, #0xa0
00fe3e74: stp      x0, x1, [sp]
00fe3e78: stp      x2, x3, [sp, #0x10]
00fe3e7c: stp      x4, x5, [sp, #0x20]
00fe3e80: stp      x6, x7, [sp, #0x30]
00fe3e84: stp      x8, x19, [sp, #0x40]
00fe3e88: stp      x20, x21, [sp, #0x50]
00fe3e8c: stp      x22, x23, [sp, #0x60]
00fe3e90: stp      x24, x25, [sp, #0x70]
00fe3e94: stp      x26, x27, [sp, #0x80]
00fe3e98: str      x28, [sp, #0x90]
00fe3e9c: mov      x0, sp
00fe3ea0: mov      x1, x29
00fe3ea4: mov      w2, #0xa0
00fe3ea8: bl       #0x41fdc1c
00fe3eac: ldp      x0, x1, [sp]
00fe3eb0: ldp      x8, x2, [sp, #0x10]
00fe3eb4: ldp      x19, x20, [sp, #0x20]
00fe3eb8: ldp      x21, x22, [sp, #0x30]
00fe3ebc: ldp      x23, x24, [sp, #0x40]
00fe3ec0: ldp      x25, x26, [sp, #0x50]
00fe3ec4: ldp      x27, x28, [sp, #0x60]
00fe3ec8: ldp      x29, x30, [sp, #0x70]
00fe3ecc: add      sp, sp, x2
00fe3ed0: ret      
00fe3ed4: bl       #0x41fd89c
00fe3ed8: ldp      x9, x8, [x20, #0x28]
00fe3edc: sub      x10, x8, x9
00fe3ee0: lsr      x11, x10, #3
00fe3ee4: cmp      w11, #1
00fe3ee8: b.lt     #0xfe3f30
00fe3eec: mov      x22, #0
00fe3ef0: b        #0xfe3f08
00fe3ef4: add      x22, x22, #1
00fe3ef8: sub      x10, x8, x9
00fe3efc: lsr      x11, x10, #3
00fe3f00: cmp      x22, w11, sxtw
00fe3f04: b.ge     #0xfe3f30
00fe3f08: cmp      x22, x10, asr #3
00fe3f0c: b.hs     #0xfe4008
00fe3f10: ldr      x21, [x9, x22, lsl #3]
00fe3f14: cbz      x21, #0xfe3ef4
00fe3f18: mov      x0, x21
00fe3f1c: bl       #0xfefc50
00fe3f20: cmp      w0, w19
00fe3f24: b.eq     #0xfe3f84
00fe3f28: ldp      x9, x8, [x20, #0x28]
00fe3f2c: b        #0xfe3ef4
00fe3f30: ldp      x9, x8, [x20, #0x60]
00fe3f34: sub      x10, x8, x9
00fe3f38: lsr      x11, x10, #3
00fe3f3c: cmp      w11, #1
00fe3f40: b.lt     #0xfe3f98
00fe3f44: mov      x22, #0
00fe3f48: b        #0xfe3f64
00fe3f4c: ldp      x9, x8, [x20, #0x60]
00fe3f50: add      x22, x22, #1
00fe3f54: sub      x10, x8, x9
00fe3f58: lsr      x11, x10, #3
00fe3f5c: cmp      x22, w11, sxtw
00fe3f60: b.ge     #0xfe3f98
00fe3f64: cmp      x22, x10, asr #3
00fe3f68: b.hs     #0xfe4008
00fe3f6c: ldr      x21, [x9, x22, lsl #3]
00fe3f70: cbz      x21, #0xfe3f50
00fe3f74: mov      x0, x21
00fe3f78: bl       #0xfefc50
00fe3f7c: cmp      w0, w19
00fe3f80: b.ne     #0xfe3f4c
00fe3f84: mov      x0, x21
00fe3f88: ldp      x29, x30, [sp, #0x20]
00fe3f8c: ldp      x20, x19, [sp, #0x10]
00fe3f90: ldp      x22, x21, [sp], #0x30
00fe3f94: ret      
00fe3f98: ldp      x9, x8, [x20, #0xf0]
00fe3f9c: sub      x10, x8, x9
00fe3fa0: lsr      x11, x10, #3
00fe3fa4: cmp      w11, #1
00fe3fa8: b.lt     #0xfe3ff0
00fe3fac: mov      x22, #0
00fe3fb0: b        #0xfe3fcc
00fe3fb4: ldp      x9, x8, [x20, #0xf0]
00fe3fb8: add      x22, x22, #1
00fe3fbc: sub      x10, x8, x9
00fe3fc0: lsr      x11, x10, #3
00fe3fc4: cmp      x22, w11, sxtw
00fe3fc8: b.ge     #0xfe3ff0
00fe3fcc: cmp      x22, x10, asr #3
00fe3fd0: b.hs     #0xfe4008
00fe3fd4: ldr      x21, [x9, x22, lsl #3]
00fe3fd8: cbz      x21, #0xfe3fb8
00fe3fdc: mov      x0, x21
00fe3fe0: bl       #0xfefc50
00fe3fe4: cmp      w0, w19
00fe3fe8: b.ne     #0xfe3fb4
00fe3fec: b        #0xfe3f84
00fe3ff0: mov      x21, #0
00fe3ff4: mov      x0, x21
00fe3ff8: ldp      x29, x30, [sp, #0x20]
00fe3ffc: ldp      x20, x19, [sp, #0x10]
00fe4000: ldp      x22, x21, [sp], #0x30
00fe4004: ret      
00fe4008: bl       #0xfe4af0
