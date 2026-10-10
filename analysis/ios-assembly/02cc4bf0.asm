02cc4bf0: ldr      x8, [x0, #0x68]
02cc4bf4: adrp     x9, #0x10a91000
02cc4bf8: ldr      x9, [x9, #0x5d0]
02cc4bfc: adrp     x10, #0x10a91000
02cc4c00: ldr      x10, [x10, #0x5d8]
02cc4c04: ldrsw    x10, [x10, #0xa0]
02cc4c08: add      x9, x9, x10
02cc4c0c: sub      x8, x8, x9
02cc4c10: lsr      x8, x8, #3
02cc4c14: mov      w9, #0x8ba3
02cc4c18: movk     w9, #0xba2e, lsl #16
02cc4c1c: mul      w8, w8, w9
02cc4c20: adrp     x9, #0x10a91000
02cc4c24: ldr      x9, [x9, #0x5c8]
02cc4c28: ldr      x9, [x9, #0x58]
02cc4c2c: ldr      x8, [x9, w8, uxtw #3]
02cc4c30: ldr      w0, [x8, w1, sxtw #2]
02cc4c34: ret      
