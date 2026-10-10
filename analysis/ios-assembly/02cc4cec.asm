02cc4cec: stp      x20, x19, [sp, #-0x20]!
02cc4cf0: stp      x29, x30, [sp, #0x10]
02cc4cf4: add      x29, sp, #0x10
02cc4cf8: mov      x19, x8
02cc4cfc: ldr      x8, [x0, #0x68]
02cc4d00: ldr      w8, [x8, #0x20]
02cc4d04: add      w10, w8, w1
02cc4d08: adrp     x8, #0x10a91000
02cc4d0c: ldr      x8, [x8, #0x5d0]
02cc4d10: adrp     x9, #0x10a91000
02cc4d14: ldr      x9, [x9, #0x5d8]
02cc4d18: ldrsw    x9, [x9, #0x60]
02cc4d1c: add      x8, x8, x9
02cc4d20: sxtw     x9, w10
02cc4d24: mov      w11, #0xc
02cc4d28: smaddl   x10, w10, w11, x8
02cc4d2c: ldrsw    x10, [x10, #4]
02cc4d30: cmn      w10, #1
02cc4d34: b.eq     #0x2cc4d4c
02cc4d38: adrp     x11, #0x10a91000
02cc4d3c: ldr      x11, [x11, #0x5c8]
02cc4d40: ldr      x11, [x11, #0x38]
02cc4d44: ldr      x10, [x11, x10, lsl #3]
02cc4d48: b        #0x2cc4d50
02cc4d4c: mov      x10, #0
02cc4d50: str      x10, [x19]
02cc4d54: mov      w10, #0xc
02cc4d58: madd     x20, x9, x10, x8
02cc4d5c: ldr      w0, [x20]
02cc4d60: bl       #0x2cc4004
02cc4d64: str      x0, [x19, #8]
02cc4d68: ldr      w8, [x20, #8]
02cc4d6c: str      w8, [x19, #0x10]
02cc4d70: ldp      x29, x30, [sp, #0x10]
02cc4d74: ldp      x20, x19, [sp], #0x20
02cc4d78: ret      
