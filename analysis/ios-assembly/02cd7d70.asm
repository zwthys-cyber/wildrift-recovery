02cd7d70: sub      sp, sp, #0x80
02cd7d74: stp      x20, x19, [sp, #0x60]
02cd7d78: stp      x29, x30, [sp, #0x70]
02cd7d7c: add      x29, sp, #0x70
02cd7d80: mov      x19, x0
02cd7d84: add      x20, sp, #0x20
02cd7d88: add      x8, sp, #0x20
02cd7d8c: bl       #0x2ca0ee0
02cd7d90: adrp     x8, #0xf901000
02cd7d94: add      x8, x8, #0x943
02cd7d98: mov      w9, #8
02cd7d9c: stp      x8, x9, [sp, #0x10]
02cd7da0: ldrb     w8, [sp, #0x37]
02cd7da4: sxtb     w9, w8
02cd7da8: ldp      x10, x11, [sp, #0x20]
02cd7dac: cmp      w9, #0
02cd7db0: csel     x9, x10, x20, lt
02cd7db4: csel     x8, x11, x8, lt
02cd7db8: stp      x9, x8, [x29, #-0x20]
02cd7dbc: add      x8, sp, #0x38
02cd7dc0: sub      x0, x29, #0x20
02cd7dc4: add      x1, sp, #0x10
02cd7dc8: bl       #0x2c7d6b4
02cd7dcc: ldrsb    w8, [sp, #0x37]
02cd7dd0: tbz      w8, #0x1f, #0x2cd7ddc
02cd7dd4: ldr      x0, [sp, #0x20]
02cd7dd8: bl       #0xe5038
02cd7ddc: mov      x0, x19
02cd7de0: bl       #0x7c1220c
02cd7de4: stp      x19, x0, [sp, #0x10]
02cd7de8: ldrb     w8, [sp, #0x4f]
02cd7dec: sxtb     w9, w8
02cd7df0: ldp      x10, x11, [sp, #0x38]
02cd7df4: cmp      w9, #0
02cd7df8: add      x9, sp, #0x38
02cd7dfc: csel     x9, x10, x9, lt
02cd7e00: csel     x8, x11, x8, lt
02cd7e04: stp      x9, x8, [x29, #-0x20]
02cd7e08: add      x8, sp, #0x20
02cd7e0c: sub      x0, x29, #0x20
02cd7e10: add      x1, sp, #0x10
02cd7e14: bl       #0x2c7d6b4
02cd7e18: stur     wzr, [x29, #-0x20]
02cd7e1c: add      x0, sp, #0x20
02cd7e20: sub      x5, x29, #0x20
02cd7e24: mov      w1, #3
02cd7e28: mov      w2, #1
02cd7e2c: mov      w4, #0
02cd7e30: mov      w3, #1
02cd7e34: bl       #0x2c9e640
02cd7e38: ldur     w8, [x29, #-0x20]
02cd7e3c: cbz      w8, #0x2cd7e68
02cd7e40: ldrsb    w8, [sp, #0x37]
02cd7e44: ldr      x9, [sp, #0x20]
02cd7e48: cmp      w8, #0
02cd7e4c: add      x8, sp, #0x20
02cd7e50: csel     x8, x9, x8, lt
02cd7e54: str      x8, [sp]
02cd7e58: adrp     x0, #0xf901000
02cd7e5c: add      x0, x0, #0x94c
02cd7e60: bl       #0x2ca2ef4
02cd7e64: b        #0x2cd7e9c
02cd7e68: mov      x20, x0
02cd7e6c: mov      x1, #0
02cd7e70: mov      x2, #0
02cd7e74: mov      w3, #3
02cd7e78: bl       #0x2ca31dc
02cd7e7c: mov      x19, x0
02cd7e80: sub      x1, x29, #0x20
02cd7e84: mov      x0, x20
02cd7e88: bl       #0x2c9e888
02cd7e8c: ldur     w8, [x29, #-0x20]
02cd7e90: cbz      w8, #0x2cd7ea0
02cd7e94: mov      x0, x19
02cd7e98: bl       #0x2ca307c
02cd7e9c: mov      x19, #0
02cd7ea0: ldrsb    w8, [sp, #0x37]
02cd7ea4: tbz      w8, #0x1f, #0x2cd7eb0
02cd7ea8: ldr      x0, [sp, #0x20]
02cd7eac: bl       #0xe5038
02cd7eb0: ldrsb    w8, [sp, #0x4f]
02cd7eb4: tbz      w8, #0x1f, #0x2cd7ec0
02cd7eb8: ldr      x0, [sp, #0x38]
02cd7ebc: bl       #0xe5038
02cd7ec0: mov      x0, x19
02cd7ec4: ldp      x29, x30, [sp, #0x70]
02cd7ec8: ldp      x20, x19, [sp, #0x60]
02cd7ecc: add      sp, sp, #0x80
02cd7ed0: ret      
02cd7ed4: b        #0x2cd7ef4
02cd7ed8: mov      x19, x0
02cd7edc: b        #0x2cd7f08
02cd7ee0: mov      x19, x0
02cd7ee4: ldrsb    w8, [sp, #0x37]
02cd7ee8: tbz      w8, #0x1f, #0x2cd7f18
02cd7eec: ldr      x0, [sp, #0x20]
02cd7ef0: b        #0x2cd7f14
02cd7ef4: mov      x19, x0
02cd7ef8: ldrsb    w8, [sp, #0x37]
02cd7efc: tbz      w8, #0x1f, #0x2cd7f08
02cd7f00: ldr      x0, [sp, #0x20]
02cd7f04: bl       #0xe5038
02cd7f08: ldrsb    w8, [sp, #0x4f]
02cd7f0c: tbz      w8, #0x1f, #0x2cd7f18
02cd7f10: ldr      x0, [sp, #0x38]
02cd7f14: bl       #0xe5038
02cd7f18: mov      x0, x19
02cd7f1c: bl       #0x7c121f8
