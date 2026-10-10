04ee5d38: stp      x20, x19, [sp, #-0x20]!
04ee5d3c: stp      x29, x30, [sp, #0x10]
04ee5d40: add      x29, sp, #0x10
04ee5d44: mov      x19, x0
04ee5d48: ldr      x8, [x0, #0x18]
04ee5d4c: ldr      x0, [x8, #0xd0]
04ee5d50: cbz      x0, #0x4ee5da0
04ee5d54: ldur     x8, [x19, #0xa0]
04ee5d58: cbz      x8, #0x4ee5d74
04ee5d5c: ldr      x9, [x8, #0x10]
04ee5d60: mov      w10, w9
04ee5d64: cmp      x9, x0
04ee5d68: mov      w9, #-0x22222223
04ee5d6c: ccmp     x10, x9, #4, eq
04ee5d70: b.ne     #0x4ee5d90
04ee5d74: mov      x1, #0
04ee5d78: bl       #0x4eb9e54
04ee5d7c: mov      x1, x0
04ee5d80: stur     x0, [x19, #0xa0]
04ee5d84: add      x0, x19, #0xa0
04ee5d88: bl       #0x2c6afb0
04ee5d8c: ldur     x8, [x19, #0xa0]
04ee5d90: mov      x0, x8
04ee5d94: ldp      x29, x30, [sp, #0x10]
04ee5d98: ldp      x20, x19, [sp], #0x20
04ee5d9c: ret      
04ee5da0: stur     xzr, [x19, #0xa0]
04ee5da4: add      x0, x19, #0xa0
04ee5da8: mov      x1, #0
04ee5dac: bl       #0x2c6afb0
04ee5db0: mov      x8, #0
04ee5db4: mov      x0, x8
04ee5db8: ldp      x29, x30, [sp, #0x10]
04ee5dbc: ldp      x20, x19, [sp], #0x20
04ee5dc0: ret      
