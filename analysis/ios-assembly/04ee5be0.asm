04ee5be0: stp      x20, x19, [sp, #-0x20]!
04ee5be4: stp      x29, x30, [sp, #0x10]
04ee5be8: add      x29, sp, #0x10
04ee5bec: mov      x19, x0
04ee5bf0: adrp     x20, #0x10b37000
04ee5bf4: ldrb     w8, [x20, #0xbe7]
04ee5bf8: tbnz     w8, #0, #0x4ee5c1c
04ee5bfc: adrp     x0, #0x106c6000
04ee5c00: add      x0, x0, #0xf58
04ee5c04: bl       #0x2c6b024
04ee5c08: adrp     x0, #0x10619000
04ee5c0c: add      x0, x0, #0xce0
04ee5c10: bl       #0x2c6b024
04ee5c14: mov      w8, #1
04ee5c18: strb     w8, [x20, #0xbe7]
04ee5c1c: ldr      x8, [x19, #0x18]
04ee5c20: ldr      x20, [x8, #0xc0]
04ee5c24: cbz      x20, #0x4ee5c8c
04ee5c28: ldr      x0, [x19, #0x90]!
04ee5c2c: cbz      x0, #0x4ee5c48
04ee5c30: ldr      x8, [x0, #0x10]
04ee5c34: mov      w9, w8
04ee5c38: cmp      x8, x20
04ee5c3c: mov      w8, #-0x22222223
04ee5c40: ccmp     x9, x8, #4, eq
04ee5c44: b.ne     #0x4ee5c80
04ee5c48: adrp     x8, #0x10619000
04ee5c4c: ldr      x0, [x8, #0xce0]
04ee5c50: ldr      w8, [x0, #0xe0]
04ee5c54: cbnz     w8, #0x4ee5c5c
04ee5c58: bl       #0x2c6b180
04ee5c5c: adrp     x8, #0x106c6000
04ee5c60: ldr      x1, [x8, #0xf58]
04ee5c64: mov      x0, x20
04ee5c68: bl       #0xbf10d48
04ee5c6c: mov      x1, x0
04ee5c70: str      x0, [x19]
04ee5c74: mov      x0, x19
04ee5c78: bl       #0x2c6afb0
04ee5c7c: ldr      x0, [x19]
04ee5c80: ldp      x29, x30, [sp, #0x10]
04ee5c84: ldp      x20, x19, [sp], #0x20
04ee5c88: ret      
04ee5c8c: str      xzr, [x19, #0x90]!
04ee5c90: mov      x0, x19
04ee5c94: mov      x1, #0
04ee5c98: bl       #0x2c6afb0
04ee5c9c: mov      x0, #0
04ee5ca0: ldp      x29, x30, [sp, #0x10]
04ee5ca4: ldp      x20, x19, [sp], #0x20
04ee5ca8: ret      
