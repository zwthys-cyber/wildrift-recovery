0044b8c0: sub      sp, sp, #0x120
0044b8c4: stp      x29, x30, [sp, #0xc0]
0044b8c8: stp      x28, x27, [sp, #0xd0]
0044b8cc: stp      x26, x25, [sp, #0xe0]
0044b8d0: stp      x24, x23, [sp, #0xf0]
0044b8d4: stp      x22, x21, [sp, #0x100]
0044b8d8: stp      x20, x19, [sp, #0x110]
0044b8dc: add      x29, sp, #0xc0
0044b8e0: mrs      x23, tpidr_el0
0044b8e4: mov      x27, #0x6944
0044b8e8: mov      x28, #0x7665
0044b8ec: ldr      x9, [x23, #0x28]
0044b8f0: movk     x27, #0x7073, lsl #16
0044b8f4: movk     x28, #0x6369, lsl #16
0044b8f8: add      x24, sp, #0x10
0044b8fc: movk     x27, #0x616c, lsl #32
0044b900: movk     x28, #0x4965, lsl #32
0044b904: stur     x9, [x29, #-0x10]
0044b908: mov      x20, x0
0044b90c: mov      x19, x8
0044b910: ldr      x9, [x0, #8]
0044b914: mov      x8, xzr
0044b918: adrp     x26, #0x25000
0044b91c: add      x26, x26, #0xf85
0044b920: orr      x10, x24, #1
0044b924: movk     x27, #0x4479, lsl #48
0044b928: movk     x28, #0x666e, lsl #48
0044b92c: mov      w25, #0x6f
0044b930: stp      xzr, xzr, [x19]
0044b934: str      xzr, [x19, #0x10]
0044b938: str      x10, [sp, #8]
0044b93c: ldr      x21, [x20]
0044b940: add      x0, x21, x8
0044b944: add      x22, x21, x9
0044b948: sub      x8, x22, x0
0044b94c: cmp      x8, #0x11
0044b950: b.lt     #0x44bc58
0044b954: sub      x2, x8, #0x10
0044b958: mov      w1, #0x44
0044b95c: bl       #0x553f70 ; memchr
0044b960: cbz      x0, #0x44bc58
0044b964: ldp      x8, x9, [x0]
0044b968: ldrb     w10, [x0, #0x10]
0044b96c: cmp      x8, x27
0044b970: ccmp     x9, x28, #0, eq
0044b974: ccmp     w10, w25, #0, eq
0044b978: b.eq     #0x44b984
0044b97c: add      x0, x0, #1
0044b980: b        #0x44b948
0044b984: cmp      x0, x22
0044b988: b.eq     #0x44bc58
0044b98c: sub      x21, x0, x21
0044b990: cmn      x21, #1
0044b994: b.eq     #0x44bc58
0044b998: sub      x0, x29, #0x11
0044b99c: mov      x1, x20
0044b9a0: mov      x2, x26
0044b9a4: mov      w3, #5
0044b9a8: adrp     x4, #0x24000
0044b9ac: add      x4, x4, #0xf5d
0044b9b0: mov      w5, #1
0044b9b4: mov      w6, w21
0044b9b8: bl       #0x44c5e4
0044b9bc: stp      x0, x1, [x29, #-0x28]
0044b9c0: sub      x0, x29, #0x11
0044b9c4: mov      x1, x20
0044b9c8: adrp     x2, #0x2a000
0044b9cc: add      x2, x2, #0x29
0044b9d0: mov      w3, #0xa
0044b9d4: adrp     x4, #0x28000
0044b9d8: add      x4, x4, #0x813
0044b9dc: mov      w5, #1
0044b9e0: mov      w6, w21
0044b9e4: bl       #0x44c5e4
0044b9e8: adrp     x22, #0x28000
0044b9ec: add      x22, x22, #0x10a
0044b9f0: stp      x0, x1, [x29, #-0x38]
0044b9f4: sub      x0, x29, #0x11
0044b9f8: mov      x1, x20
0044b9fc: adrp     x2, #0x24000
0044ba00: add      x2, x2, #0x14f ; 'mCurrentLayerStack='
0044ba04: mov      w3, #0x13
0044ba08: mov      x4, x22
0044ba0c: mov      w5, #1
0044ba10: mov      w6, w21
0044ba14: bl       #0x44c5e4
0044ba18: stp      x0, x1, [x29, #-0x48]
0044ba1c: sub      x0, x29, #0x11
0044ba20: mov      x1, x20
0044ba24: adrp     x2, #0x28000
0044ba28: add      x2, x2, #0x815 ; 'mCurrentLayerStackRect='
0044ba2c: mov      w3, #0x17
0044ba30: mov      x4, x22
0044ba34: mov      w5, #1
0044ba38: mov      w6, w21
0044ba3c: bl       #0x44c5e4
0044ba40: stp      x0, x1, [x29, #-0x58]
0044ba44: sub      x0, x29, #0x11
0044ba48: mov      x1, x20
0044ba4c: adrp     x2, #0x22000
0044ba50: add      x2, x2, #0xfcb ; 'mCurrentOrientation='
0044ba54: mov      w3, #0x14
0044ba58: mov      x4, x22
0044ba5c: mov      w5, #1
0044ba60: mov      w6, w21
0044ba64: bl       #0x44c5e4
0044ba68: ldur     x8, [x29, #-0x40]
0044ba6c: stp      x0, x1, [sp, #0x58]
0044ba70: cmp      x8, #2
0044ba74: b.ne     #0x44ba8c
0044ba78: ldur     x9, [x29, #-0x48]
0044ba7c: mov      w10, #0x312d
0044ba80: ldrh     w9, [x9]
0044ba84: cmp      w9, w10
0044ba88: b.eq     #0x44bb50
0044ba8c: cbz      x8, #0x44bb3c
0044ba90: ldur     x8, [x29, #-0x30]
0044ba94: cbz      x8, #0x44bb3c
0044ba98: add      x8, sp, #0x10
0044ba9c: sub      x0, x29, #0x38
0044baa0: sub      x1, x29, #0x48
0044baa4: sub      x2, x29, #0x58
0044baa8: add      x3, sp, #0x58
0044baac: sub      x4, x29, #0x28
0044bab0: bl       #0x44c784
0044bab4: ldp      x8, x9, [x19, #8]
0044bab8: cmp      x8, x9
0044babc: b.hs     #0x44bb0c
0044bac0: ldr      x9, [sp, #0x20]
0044bac4: ldr      q0, [sp, #0x10]
0044bac8: str      x9, [x8, #0x10]
0044bacc: str      q0, [x8]
0044bad0: ldr      x9, [sp, #0x28]
0044bad4: stp      xzr, xzr, [sp, #0x18]
0044bad8: str      xzr, [sp, #0x10]
0044badc: str      x9, [x8, #0x18]
0044bae0: ldur     x9, [x24, #0x30]
0044bae4: ldur     q0, [x24, #0x20]
0044bae8: str      x9, [x8, #0x30]
0044baec: add      x9, x8, #0x48
0044baf0: str      q0, [x8, #0x20]
0044baf4: ldur     q0, [x24, #0x38]
0044baf8: stp      xzr, xzr, [x24, #0x28]
0044bafc: stur     xzr, [x24, #0x20]
0044bb00: stur     q0, [x8, #0x38]
0044bb04: str      x9, [x19, #8]
0044bb08: b        #0x44bb2c
0044bb0c: add      x1, sp, #0x10
0044bb10: mov      x0, x19
0044bb14: bl       #0x44d3a4
0044bb18: ldrb     w8, [sp, #0x30]
0044bb1c: str      x0, [x19, #8]
0044bb20: tbz      w8, #0, #0x44bb2c
0044bb24: ldr      x0, [sp, #0x40]
0044bb28: bl       #0x54e070
0044bb2c: ldrb     w8, [sp, #0x10]
0044bb30: tbz      w8, #0, #0x44bb3c
0044bb34: ldr      x0, [sp, #0x20]
0044bb38: bl       #0x54e070
0044bb3c: ldr      x9, [x20, #8]
0044bb40: add      x8, x21, #1
0044bb44: cmp      x9, x8
0044bb48: b.hs     #0x44b93c
0044bb4c: b        #0x44bc58
0044bb50: ldur     x26, [x29, #-0x30]
0044bb54: cmn      x26, #0x10
0044bb58: b.hs     #0x44bc88
0044bb5c: ldur     x14, [x29, #-0x38]
0044bb60: cmp      x26, #0x17
0044bb64: b.hs     #0x44bb80
0044bb68: lsl      w8, w26, #1
0044bb6c: strb     w8, [sp, #0x10]
0044bb70: ldr      x8, [sp, #8]
0044bb74: mov      x0, x8
0044bb78: cbnz     x26, #0x44bba8
0044bb7c: b        #0x44bc14
0044bb80: orr      x8, x26, #0xf
0044bb84: mov      x24, x14
0044bb88: add      x22, x8, #1
0044bb8c: mov      x0, x22
0044bb90: bl       #0x54dfc0
0044bb94: orr      x8, x22, #1
0044bb98: stp      x26, x0, [sp, #0x18]
0044bb9c: mov      x14, x24
0044bba0: str      x8, [sp, #0x10]
0044bba4: add      x24, sp, #0x10
0044bba8: cmp      x26, #0x20
0044bbac: b.lo     #0x44bbf8
0044bbb0: sub      x8, x0, x14
0044bbb4: cmp      x8, #0x20
0044bbb8: b.lo     #0x44bbf8
0044bbbc: and      x10, x26, #0xffffffffffffffe0
0044bbc0: add      x11, x0, #0x10
0044bbc4: add      x12, x14, #0x10
0044bbc8: add      x9, x14, x10
0044bbcc: add      x8, x0, x10
0044bbd0: mov      x13, x10
0044bbd4: ldp      q0, q1, [x12, #-0x10]
0044bbd8: subs     x13, x13, #0x20
0044bbdc: add      x12, x12, #0x20
0044bbe0: stp      q0, q1, [x11, #-0x10]
0044bbe4: add      x11, x11, #0x20
0044bbe8: b.ne     #0x44bbd4
0044bbec: cmp      x26, x10
0044bbf0: b.ne     #0x44bc00
0044bbf4: b        #0x44bc14
0044bbf8: mov      x9, x14
0044bbfc: mov      x8, x0
0044bc00: add      x10, x14, x26
0044bc04: ldrb     w11, [x9], #1
0044bc08: cmp      x9, x10
0044bc0c: strb     w11, [x8], #1
0044bc10: b.ne     #0x44bc04
0044bc14: strb     wzr, [x8]
0044bc18: ldrb     w8, [sp, #0x10]
0044bc1c: ldr      x9, [sp, #0x20]
0044bc20: tst      w8, #1
0044bc24: ldr      x8, [sp, #8]
0044bc28: csel     x3, x8, x9, eq
0044bc2c: mov      w0, #6
0044bc30: adrp     x1, #0x20000
0044bc34: add      x1, x1, #0xdd3
0044bc38: adrp     x2, #0x22000
0044bc3c: add      x2, x2, #0xb15
0044bc40: bl       #0x554b10 ; __android_log_print
0044bc44: ldrb     w8, [sp, #0x10]
0044bc48: adrp     x26, #0x25000
0044bc4c: add      x26, x26, #0xf85
0044bc50: tbnz     w8, #0, #0x44bb34
0044bc54: b        #0x44bb3c
0044bc58: ldr      x8, [x23, #0x28]
0044bc5c: ldur     x9, [x29, #-0x10]
0044bc60: cmp      x8, x9
0044bc64: b.ne     #0x44bd08
0044bc68: ldp      x20, x19, [sp, #0x110]
0044bc6c: ldp      x22, x21, [sp, #0x100]
0044bc70: ldp      x24, x23, [sp, #0xf0]
0044bc74: ldp      x26, x25, [sp, #0xe0]
0044bc78: ldp      x28, x27, [sp, #0xd0]
0044bc7c: ldp      x29, x30, [sp, #0xc0]
0044bc80: add      sp, sp, #0x120
0044bc84: ret      
0044bc88: ldr      x8, [x23, #0x28]
0044bc8c: ldur     x9, [x29, #-0x10]
0044bc90: cmp      x8, x9
0044bc94: b.ne     #0x44bd08
0044bc98: add      x0, sp, #0x10
0044bc9c: bl       #0x39e640
0044bca0: b        #0x44bce4
0044bca4: b        #0x44bce4
0044bca8: ldrb     w8, [sp, #0x10]
0044bcac: mov      x20, x0
0044bcb0: tbz      w8, #0, #0x44bce8
0044bcb4: ldr      x0, [sp, #0x20]
0044bcb8: bl       #0x54e070
0044bcbc: b        #0x44bce8
0044bcc0: mov      x20, x0
0044bcc4: add      x0, sp, #0x10
0044bcc8: bl       #0x44d360
0044bccc: b        #0x44bce8
0044bcd0: b        #0x44bce4
0044bcd4: b        #0x44bce4
0044bcd8: b        #0x44bce4
0044bcdc: b        #0x44bce4
0044bce0: b        #0x44bce4
0044bce4: mov      x20, x0
0044bce8: mov      x0, x19
0044bcec: bl       #0x44c55c
0044bcf0: ldr      x8, [x23, #0x28]
0044bcf4: ldur     x9, [x29, #-0x10]
0044bcf8: cmp      x8, x9
0044bcfc: b.ne     #0x44bd08
0044bd00: mov      x0, x20
0044bd04: bl       #0x54fffc
0044bd08: bl       #0x553f00 ; __stack_chk_fail
