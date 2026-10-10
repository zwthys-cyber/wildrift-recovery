02cdc5ec: sub      sp, sp, #0xe0
02cdc5f0: stp      x26, x25, [sp, #0x90]
02cdc5f4: stp      x24, x23, [sp, #0xa0]
02cdc5f8: stp      x22, x21, [sp, #0xb0]
02cdc5fc: stp      x20, x19, [sp, #0xc0]
02cdc600: stp      x29, x30, [sp, #0xd0]
02cdc604: add      x29, sp, #0xd0
02cdc608: add      x24, x0, #0x135
02cdc60c: ldrb     w9, [x24, #2]
02cdc610: ldrh     w8, [x24]
02cdc614: bfi      w8, w9, #0x10, #8
02cdc618: tbnz     w8, #8, #0x2cdca40
02cdc61c: mov      x20, x1
02cdc620: mov      x19, x0
02cdc624: orr      w9, w8, #0x80
02cdc628: lsr      w8, w8, #0x10
02cdc62c: strb     w8, [x24, #2]
02cdc630: strh     w9, [x24]
02cdc634: ldr      x0, [x0, #0x58]
02cdc638: cbz      x0, #0x2cdc658
02cdc63c: add      x8, x0, #0x135
02cdc640: ldrb     w9, [x8, #2]
02cdc644: ldrh     w8, [x8]
02cdc648: bfi      w8, w9, #0x10, #8
02cdc64c: tbnz     w8, #8, #0x2cdc658
02cdc650: mov      x1, x20
02cdc654: bl       #0x2cdc5ec
02cdc658: ldr      x0, [x19, #0x60]
02cdc65c: cbz      x0, #0x2cdc678
02cdc660: bl       #0x2cd00d0
02cdc664: mov      x1, x20
02cdc668: bl       #0x2cdc5ec
02cdc66c: mov      x0, x19
02cdc670: bl       #0x2cd0320
02cdc674: b        #0x2cdc6fc
02cdc678: ldrh     w0, [x19, #0x124]
02cdc67c: cbz      x0, #0x2cdc6f8
02cdc680: mov      w1, #0x20
02cdc684: bl       #0x2cbf848
02cdc688: mov      x21, x0
02cdc68c: ldrh     w25, [x19, #0x124]
02cdc690: cbz      w25, #0x2cdc6f0
02cdc694: mov      w22, #0
02cdc698: mov      x23, x21
02cdc69c: add      x8, sp, #0x60
02cdc6a0: mov      x0, x19
02cdc6a4: mov      x1, x22
02cdc6a8: bl       #0x2cc4cec
02cdc6ac: ldr      x8, [sp, #0x60]
02cdc6b0: str      x8, [x23, #8]
02cdc6b4: ldr      x8, [sp, #0x68]
02cdc6b8: str      x8, [x23]
02cdc6bc: str      x19, [x23, #0x10]
02cdc6c0: mov      x0, x19
02cdc6c4: mov      x1, x22
02cdc6c8: mov      x2, x23
02cdc6cc: mov      x3, x20
02cdc6d0: bl       #0x2ce0950
02cdc6d4: str      w0, [x23, #0x18]
02cdc6d8: ldr      w8, [sp, #0x70]
02cdc6dc: str      w8, [x23, #0x1c]
02cdc6e0: add      x23, x23, #0x20
02cdc6e4: add      w22, w22, #1
02cdc6e8: cmp      w25, w22
02cdc6ec: b.ne     #0x2cdc69c
02cdc6f0: str      x21, [x19, #0x80]
02cdc6f4: b        #0x2cdc6fc
02cdc6f8: str      xzr, [x19, #0x80]
02cdc6fc: ldrb     w9, [x24, #2]
02cdc700: ldrh     w8, [x24]
02cdc704: bfi      w8, w9, #0x10, #8
02cdc708: tbnz     w8, #4, #0x2cdca24
02cdc70c: ldr      x9, [x19, #0x58]
02cdc710: cbz      x9, #0x2cdc748
02cdc714: add      x10, x9, #0x135
02cdc718: ldrh     w10, [x10]
02cdc71c: and      w10, w10, #0x20
02cdc720: orr      w10, w10, w8
02cdc724: lsr      w8, w8, #0x10
02cdc728: strb     w8, [x24, #2]
02cdc72c: strh     w10, [x24]
02cdc730: ldr      w8, [x9, #0xf8]
02cdc734: ldr      w22, [x9, #0x100]
02cdc738: ldr      w10, [x19, #0x28]
02cdc73c: tbnz     w10, #0x1f, #0x2cdc758
02cdc740: ldrb     w9, [x9, #0x133]
02cdc744: b        #0x2cdc75c
02cdc748: mov      w22, #0x10
02cdc74c: mov      w9, #8
02cdc750: mov      w8, #0x10
02cdc754: b        #0x2cdc75c
02cdc758: mov      w9, #1
02cdc75c: strb     w9, [x19, #0x133]
02cdc760: mov      w21, w8
02cdc764: ldrh     w8, [x19, #0x124]
02cdc768: cbz      w8, #0x2cdc988
02cdc76c: mov      x25, #0
02cdc770: mov      w22, w22
02cdc774: mov      w26, #8
02cdc778: ldr      x23, [x19, #0x80]
02cdc77c: add      x8, x23, x26
02cdc780: sub      x0, x8, #8
02cdc784: bl       #0x2cd7ce0
02cdc788: cbz      w0, #0x2cdc7cc
02cdc78c: ldr      x0, [x23, x26]
02cdc790: bl       #0x2cd41ac
02cdc794: mov      x23, x0
02cdc798: bl       #0x2cd445c
02cdc79c: tbnz     w0, #0, #0x2cdc7c0
02cdc7a0: mov      x0, x23
02cdc7a4: bl       #0x2cd44ac
02cdc7a8: cbz      w0, #0x2cdc7cc
02cdc7ac: mov      x0, x23
02cdc7b0: mov      w1, #1
02cdc7b4: bl       #0x2cdadc8
02cdc7b8: bl       #0x2cde600
02cdc7bc: cbz      w0, #0x2cdc7cc
02cdc7c0: ldrh     w8, [x24]
02cdc7c4: orr      w8, w8, #0x20
02cdc7c8: strh     w8, [x24]
02cdc7cc: add      x25, x25, #1
02cdc7d0: ldrh     w8, [x19, #0x124]
02cdc7d4: add      x26, x26, #0x20
02cdc7d8: cmp      x25, x8
02cdc7dc: b.lo     #0x2cdc778
02cdc7e0: ldrb     w8, [x24, #2]
02cdc7e4: ldrh     w9, [x24]
02cdc7e8: bfi      w9, w8, #0x10, #8
02cdc7ec: ldrb     w3, [x19, #0x133]
02cdc7f0: stp      xzr, xzr, [sp, #0x60]
02cdc7f4: str      xzr, [sp, #0x70]
02cdc7f8: stp      xzr, xzr, [sp, #0x30]
02cdc7fc: str      xzr, [sp, #0x40]
02cdc800: stp      xzr, xzr, [sp]
02cdc804: str      xzr, [sp, #0x10]
02cdc808: ldrb     w8, [x19, #0x134]
02cdc80c: tst      w9, #0x20
02cdc810: csel     w8, w8, wzr, eq
02cdc814: and      w4, w8, #0xff
02cdc818: add      x5, sp, #0x60
02cdc81c: mov      x0, x19
02cdc820: mov      x1, x21
02cdc824: mov      x2, x22
02cdc828: bl       #0x2c88524
02cdc82c: ldr      x21, [sp, #0x78]
02cdc830: ldr      w8, [x19, #0x28]
02cdc834: tbz      w8, #0x1f, #0x2cdc84c
02cdc838: ldp      x9, x8, [sp, #0x60]
02cdc83c: cmp      x8, x9
02cdc840: b.ne     #0x2cdc84c
02cdc844: mov      w21, #0x11
02cdc848: str      w21, [x19, #0x100]
02cdc84c: ldr      x8, [x19, #0x60]
02cdc850: cbz      x8, #0x2cdc874
02cdc854: ldr      x0, [x8]
02cdc858: bl       #0x2cc46f4
02cdc85c: ldr      w8, [x0, #0xf8]
02cdc860: cmp      x8, x21
02cdc864: csel     x9, x8, x21, hi
02cdc868: cmp      w8, #0
02cdc86c: csel     x21, x21, x9, eq
02cdc870: str      w21, [x19, #0xf8]
02cdc874: ldrh     w8, [x24]
02cdc878: orr      w8, w8, #0x100
02cdc87c: strh     w8, [x24]
02cdc880: add      x1, sp, #0x30
02cdc884: mov      x0, x19
02cdc888: bl       #0x2c88754
02cdc88c: mov      x1, sp
02cdc890: mov      x0, x19
02cdc894: bl       #0x2c88778
02cdc898: ldrb     w8, [sp, #0x88]
02cdc89c: strb     w8, [x19, #0x133]
02cdc8a0: ldr      x8, [x19, #0x60]
02cdc8a4: cbnz     x8, #0x2cdc8b4
02cdc8a8: ldr      x0, [x19, #0x68]
02cdc8ac: bl       #0x2cc4800
02cdc8b0: cbz      w0, #0x2cdca5c
02cdc8b4: ldr      w8, [sp, #0x80]
02cdc8b8: str      w8, [x19, #0x100]
02cdc8bc: ldr      x8, [x19]
02cdc8c0: adrp     x9, #0x10b35000
02cdc8c4: add      x9, x9, #0x8e8
02cdc8c8: ldr      x9, [x9]
02cdc8cc: cmp      x8, x9
02cdc8d0: b.ne     #0x2cdc8fc
02cdc8d4: ldr      x1, [x19, #0x10]
02cdc8d8: adrp     x0, #0xf901000
02cdc8dc: add      x0, x0, #0xf10
02cdc8e0: bl       #0x7c12384
02cdc8e4: cbnz     w0, #0x2cdc8fc
02cdc8e8: ldrb     w8, [x24, #2]
02cdc8ec: ldrh     w9, [x24]
02cdc8f0: bfi      w9, w8, #0x10, #8
02cdc8f4: and      w8, w9, #0xffffffdf
02cdc8f8: strh     w8, [x24]
02cdc8fc: ldr      x8, [x19, #0x60]
02cdc900: cbz      x8, #0x2cdc954
02cdc904: ldr      x23, [sp, #0x48]
02cdc908: ldr      x22, [sp, #0x18]
02cdc90c: add      x3, sp, #0x60
02cdc910: mov      w0, #0
02cdc914: mov      x1, x19
02cdc918: mov      x2, x21
02cdc91c: mov      x4, x20
02cdc920: bl       #0x2ce0c68
02cdc924: add      x3, sp, #0x30
02cdc928: mov      w0, #1
02cdc92c: mov      x1, x19
02cdc930: mov      x2, x23
02cdc934: mov      x4, x20
02cdc938: bl       #0x2ce0c68
02cdc93c: mov      x3, sp
02cdc940: mov      w0, #2
02cdc944: mov      x1, x19
02cdc948: mov      x2, x22
02cdc94c: mov      x4, x20
02cdc950: bl       #0x2ce0c68
02cdc954: ldr      x0, [sp]
02cdc958: cbz      x0, #0x2cdc964
02cdc95c: str      x0, [sp, #8]
02cdc960: bl       #0xe5038
02cdc964: ldr      x0, [sp, #0x30]
02cdc968: cbz      x0, #0x2cdc974
02cdc96c: str      x0, [sp, #0x38]
02cdc970: bl       #0xe5038
02cdc974: ldr      x0, [sp, #0x60]
02cdc978: cbz      x0, #0x2cdc9b4
02cdc97c: str      x0, [sp, #0x68]
02cdc980: bl       #0xe5038
02cdc984: b        #0x2cdc9b4
02cdc988: ldr      x8, [x19, #0x60]
02cdc98c: cbz      x8, #0x2cdc9b0
02cdc990: ldr      x0, [x8]
02cdc994: bl       #0x2cc46f4
02cdc998: ldr      w8, [x0, #0xf8]
02cdc99c: cmp      w8, w21
02cdc9a0: csel     w9, w8, w21, hi
02cdc9a4: cmp      w8, #0
02cdc9a8: csel     w8, w21, w9, eq
02cdc9ac: str      w8, [x19, #0xf8]
02cdc9b0: str      w22, [x19, #0x100]
02cdc9b4: ldr      w0, [x19, #0x10c]
02cdc9b8: cbz      w0, #0x2cdc9f8
02cdc9bc: mov      x1, #0
02cdc9c0: bl       #0x2c6c8bc
02cdc9c4: str      x0, [x19, #0xb8]
02cdc9c8: adrp     x0, #0x2ce0000
02cdc9cc: add      x0, x0, #0xdc4
02cdc9d0: mov      x1, x19
02cdc9d4: bl       #0x2c6c924
02cdc9d8: ldr      w8, [x19, #0x10c]
02cdc9dc: adrp     x9, #0x10b35000
02cdc9e0: add      x9, x9, #0x5a0
02cdc9e4: add      x9, x9, #0x18
02cdc9e8: ldaxr    x10, [x9]
02cdc9ec: add      x10, x10, x8
02cdc9f0: stlxr    w11, x10, [x9]
02cdc9f4: cbnz     w11, #0x2cdc9e8
02cdc9f8: ldr      w0, [x19, #0x110]
02cdc9fc: cbz      w0, #0x2cdca08
02cdca00: bl       #0x2cc59f0
02cdca04: str      w0, [x19, #0x114]
02cdca08: ldr      w8, [x19, #0x28]
02cdca0c: tbnz     w8, #0x1f, #0x2cdca18
02cdca10: mov      w8, #8
02cdca14: b        #0x2cdca20
02cdca18: ldr      w8, [x19, #0xf8]
02cdca1c: sub      w8, w8, #0x10
02cdca20: str      w8, [x19, #0xfc]
02cdca24: dmb      ish
02cdca28: ldrb     w8, [x24, #2]
02cdca2c: ldrh     w9, [x24]
02cdca30: bfi      w9, w8, #0x10, #8
02cdca34: and      w8, w9, #0xfffffe7f
02cdca38: orr      w8, w8, #0x100
02cdca3c: strh     w8, [x24]
02cdca40: ldp      x29, x30, [sp, #0xd0]
02cdca44: ldp      x20, x19, [sp, #0xc0]
02cdca48: ldp      x22, x21, [sp, #0xb0]
02cdca4c: ldp      x24, x23, [sp, #0xa0]
02cdca50: ldp      x26, x25, [sp, #0x90]
02cdca54: add      sp, sp, #0xe0
02cdca58: ret      
02cdca5c: ldr      w8, [x19, #0xf8]
02cdca60: b        #0x2cdc8b8
02cdca64: b        #0x2cdca68
02cdca68: mov      x19, x0
02cdca6c: ldr      x0, [sp]
02cdca70: cbz      x0, #0x2cdca7c
02cdca74: str      x0, [sp, #8]
02cdca78: bl       #0xe5038
02cdca7c: ldr      x0, [sp, #0x30]
02cdca80: cbz      x0, #0x2cdca8c
02cdca84: str      x0, [sp, #0x38]
02cdca88: bl       #0xe5038
02cdca8c: ldr      x0, [sp, #0x60]
02cdca90: cbz      x0, #0x2cdca9c
02cdca94: str      x0, [sp, #0x68]
02cdca98: bl       #0xe5038
02cdca9c: mov      x0, x19
02cdcaa0: bl       #0x7c121f8
