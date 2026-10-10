02ca2b04: sub      sp, sp, #0xd0
02ca2b08: stp      x24, x23, [sp, #0x90]
02ca2b0c: stp      x22, x21, [sp, #0xa0]
02ca2b10: stp      x20, x19, [sp, #0xb0]
02ca2b14: stp      x29, x30, [sp, #0xc0]
02ca2b18: add      x29, sp, #0xc0
02ca2b1c: mov      x22, x5
02ca2b20: mov      x21, x2
02ca2b24: mov      x19, x1
02ca2b28: mov      x20, x0
02ca2b2c: adrp     x8, #0xfb5c000
02ca2b30: ldr      x8, [x8, #0x50]
02ca2b34: ldr      x8, [x8]
02ca2b38: stur     x8, [x29, #-0x38]
02ca2b3c: ldp      w8, w9, [x3]
02ca2b40: stp      w8, w9, [sp, #0x10]
02ca2b44: ldp      x8, x9, [x3, #8]
02ca2b48: stp      x8, x9, [sp, #0x18]
02ca2b4c: ldp      w8, w9, [x3, #0x18]
02ca2b50: stp      w8, w9, [sp, #0x28]
02ca2b54: adrp     x8, #0xeda2000
02ca2b58: ldr      q0, [x8, #0x890]
02ca2b5c: str      q0, [sp]
02ca2b60: lsr      x23, x5, #0x20
02ca2b64: stp      w22, w23, [sp, #0x30]
02ca2b68: ldp      w8, w9, [x4]
02ca2b6c: stp      w8, w9, [sp, #0x38]
02ca2b70: cmp      w2, #0x40
02ca2b74: b.lo     #0x2ca2bd0
02ca2b78: add      x24, sp, #0x48
02ca2b7c: add      x0, sp, #0x48
02ca2b80: mov      x1, sp
02ca2b84: bl       #0x2ca2c34
02ca2b88: mov      x8, #0
02ca2b8c: ldrb     w9, [x19, x8]
02ca2b90: ldrb     w10, [x24, x8]
02ca2b94: eor      w9, w10, w9
02ca2b98: strb     w9, [x20, x8]
02ca2b9c: add      x8, x8, #1
02ca2ba0: cmp      x8, #0x40
02ca2ba4: b.ne     #0x2ca2b8c
02ca2ba8: adds     w22, w22, #1
02ca2bac: str      w22, [sp, #0x30]
02ca2bb0: b.lo     #0x2ca2bbc
02ca2bb4: add      w23, w23, #1
02ca2bb8: str      w23, [sp, #0x34]
02ca2bbc: sub      w21, w21, #0x40
02ca2bc0: add      x19, x19, #0x40
02ca2bc4: add      x20, x20, #0x40
02ca2bc8: cmp      w21, #0x3f
02ca2bcc: b.hi     #0x2ca2b7c
02ca2bd0: cbz      w21, #0x2ca2c00
02ca2bd4: add      x22, sp, #0x48
02ca2bd8: add      x0, sp, #0x48
02ca2bdc: mov      x1, sp
02ca2be0: bl       #0x2ca2c34
02ca2be4: mov      w8, w21
02ca2be8: ldrb     w9, [x19], #1
02ca2bec: ldrb     w10, [x22], #1
02ca2bf0: eor      w9, w10, w9
02ca2bf4: strb     w9, [x20], #1
02ca2bf8: subs     x8, x8, #1
02ca2bfc: b.ne     #0x2ca2be8
02ca2c00: ldur     x8, [x29, #-0x38]
02ca2c04: adrp     x9, #0xfb5c000
02ca2c08: ldr      x9, [x9, #0x50]
02ca2c0c: ldr      x9, [x9]
02ca2c10: cmp      x9, x8
02ca2c14: b.ne     #0x2ca2c30
02ca2c18: ldp      x29, x30, [sp, #0xc0]
02ca2c1c: ldp      x20, x19, [sp, #0xb0]
02ca2c20: ldp      x22, x21, [sp, #0xa0]
02ca2c24: ldp      x24, x23, [sp, #0x90]
02ca2c28: add      sp, sp, #0xd0
02ca2c2c: ret      
02ca2c30: bl       #0x7c1226c
