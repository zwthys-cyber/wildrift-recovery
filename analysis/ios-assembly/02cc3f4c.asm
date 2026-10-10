02cc3f4c: stp      x22, x21, [sp, #-0x30]!
02cc3f50: stp      x20, x19, [sp, #0x10]
02cc3f54: stp      x29, x30, [sp, #0x20]
02cc3f58: add      x29, sp, #0x20
02cc3f5c: mov      x19, x2
02cc3f60: mov      x20, x1
02cc3f64: mov      x21, x0
02cc3f68: adrp     x8, #0x10a91000
02cc3f6c: ldr      x8, [x8, #0x5d0]
02cc3f70: adrp     x9, #0x10a91000
02cc3f74: ldr      x9, [x9, #0x5d8]
02cc3f78: ldrsw    x9, [x9, #0xa8]
02cc3f7c: add      x8, x8, x9
02cc3f80: mov      w9, #0x28
02cc3f84: smaddl   x22, w1, w9, x8
02cc3f88: ldr      w0, [x22]
02cc3f8c: bl       #0x2cc4004
02cc3f90: str      x0, [x21]
02cc3f94: ldr      w8, [x22, #4]
02cc3f98: str      w8, [x19]
02cc3f9c: ldr      w8, [x22, #0xc]
02cc3fa0: str      w8, [x21, #0x18]
02cc3fa4: ldr      w8, [x22, #0x14]
02cc3fa8: str      w8, [x21, #0x1c]
02cc3fac: ldr      w8, [x22, #0x1c]
02cc3fb0: str      w8, [x21, #0x40]
02cc3fb4: ldr      w8, [x22, #0x24]
02cc3fb8: str      w8, [x21, #0x20]
02cc3fbc: adrp     x8, #0x10a91000
02cc3fc0: ldr      x8, [x8, #0x5e8]
02cc3fc4: mov      w9, #0x18
02cc3fc8: smaddl   x8, w20, w9, x8
02cc3fcc: ldr      w9, [x22, #8]
02cc3fd0: str      w9, [x8]
02cc3fd4: ldr      w9, [x22, #0x20]
02cc3fd8: str      w9, [x8, #8]
02cc3fdc: ldr      w9, [x22, #0x18]
02cc3fe0: str      w9, [x8, #0xc]
02cc3fe4: ldr      w9, [x22, #0x10]
02cc3fe8: str      w9, [x8, #4]
02cc3fec: str      x21, [x8, #0x10]
02cc3ff0: str      x8, [x21, #0x28]
02cc3ff4: ldp      x29, x30, [sp, #0x20]
02cc3ff8: ldp      x20, x19, [sp, #0x10]
02cc3ffc: ldp      x22, x21, [sp], #0x30
02cc4000: ret      
