00419710: sub      sp, sp, #0xb0
00419714: stp      d9, d8, [sp, #0x40]
00419718: stp      x29, x30, [sp, #0x50]
0041971c: stp      x28, x27, [sp, #0x60]
00419720: stp      x26, x25, [sp, #0x70]
00419724: stp      x24, x23, [sp, #0x80]
00419728: stp      x22, x21, [sp, #0x90]
0041972c: stp      x20, x19, [sp, #0xa0]
00419730: add      x29, sp, #0x50
00419734: mrs      x22, tpidr_el0
00419738: ldr      x8, [x22, #0x28]
0041973c: stur     x8, [x29, #-0x18]
00419740: ldrb     w8, [x0, #0x688]
00419744: tbz      w8, #0, #0x419c3c
00419748: mov      x19, x0
0041974c: bl       #0x3a2d10
00419750: tbz      w0, #0, #0x419c3c
00419754: bl       #0x50aaf8
00419758: ldr      x8, [x19, #0x2d30]
0041975c: cmp      x0, x8
00419760: b.lt     #0x419c3c
00419764: ldp      x8, x10, [x19, #0x138]
00419768: cmp      x10, x8
0041976c: b.eq     #0x419c3c
00419770: ldp      x9, x11, [x19, #0x150]
00419774: mov      w13, #0x1b0
00419778: lsr      x12, x9, #4
0041977c: add      x11, x11, x9
00419780: and      x14, x9, #0xf
00419784: and      x15, x11, #0xf
00419788: add      x20, x8, x12, lsl #3
0041978c: lsr      x12, x11, #4
00419790: ldr      x16, [x20]
00419794: nop      
00419798: umaddl   x23, w14, w13, x16
0041979c: ldr      x14, [x8, x12, lsl #3]
004197a0: nop      
004197a4: umaddl   x13, w15, w13, x14
004197a8: cmp      x23, x13
004197ac: b.eq     #0x419c3c
004197b0: mov      w14, #0x1b00
004197b4: mov      x15, x20
004197b8: b        #0x4197c4
004197bc: cmp      x23, x13
004197c0: b.eq     #0x419c3c
004197c4: ldr      w16, [x23, #8]
004197c8: tbnz     w16, #0x1f, #0x4197e0
004197cc: ldrb     w16, [x23, #0x20]
004197d0: cbz      w16, #0x4197e0
004197d4: ldr      s0, [x23, #0x28]
004197d8: fcmp     s0, #0.0
004197dc: b.hi     #0x4197fc
004197e0: ldr      x16, [x15]
004197e4: add      x23, x23, #0x1b0
004197e8: sub      x16, x23, x16
004197ec: cmp      x16, x14
004197f0: b.ne     #0x4197bc
004197f4: ldr      x23, [x15, #8]!
004197f8: b        #0x4197bc
004197fc: ldrb     w13, [x23, #0x1a0]
00419800: ldr      w14, [x23, #0x190]
00419804: mov      w21, #0xa455
00419808: movk     w21, #0x4d5, lsl #16
0041980c: add      x15, x23, #0x188
00419810: cmp      w13, #0
00419814: cset     w13, ne
00419818: cmp      w14, w21
0041981c: cset     w14, eq
00419820: ands     w13, w13, w14
00419824: csel     x25, x15, xzr, ne
00419828: cmp      w13, #1
0041982c: b.ne     #0x419c3c
00419830: ldr      w13, [x19, #0x690]
00419834: str      w13, [sp, #0xc]
00419838: ldrb     w13, [x19, #0x689]
0041983c: tbnz     w13, #0, #0x419a7c
00419840: ldr      x9, [x25]
00419844: mov      w10, #1
00419848: stp      xzr, xzr, [sp, #0x20]
0041984c: movk     w10, #0x100, lsl #16
00419850: str      wzr, [sp, #0x30]
00419854: add      x8, x9, #1
00419858: cmp      x8, x10
0041985c: b.lo     #0x419c3c
00419860: ldr      x8, [x19, #0x30]
00419864: add      x1, x9, #0x10
00419868: add      x2, sp, #0x20
0041986c: mov      x20, x0
00419870: mov      w3, #0x14
00419874: ldr      x10, [x8]
00419878: mov      x0, x8
0041987c: ldr      x10, [x10, #0x10]
00419880: blr      x10
00419884: tbz      w0, #0, #0x419c3c
00419888: ldp      w10, w9, [sp, #0x20]
0041988c: ldr      s0, [sp, #0x28]
00419890: stp      w9, w10, [x25, #8]
00419894: scvtf    s0, s0
00419898: mov      w10, #0x38800000
0041989c: ldr      s1, [sp, #0x30]
004198a0: fmov     s2, w10
004198a4: ldrb     w10, [x25, #0x18]
004198a8: scvtf    s1, s1
004198ac: fmul     s0, s0, s2
004198b0: fmul     s1, s1, s2
004198b4: stp      s0, s1, [x25, #0x10]
004198b8: cbz      w10, #0x419c3c
004198bc: cmp      w9, w21
004198c0: b.ne     #0x419c3c
004198c4: mov      w9, #0xcccd
004198c8: movk     w9, #0x3d4c, lsl #16
004198cc: fmov     s1, w9
004198d0: fcmp     s0, s1
004198d4: b.gt     #0x419c3c
004198d8: ldr      x9, [x19, #0x2d38]
004198dc: mov      x8, x20
004198e0: str      x19, [sp, #0x18]
004198e4: cmp      x20, x9
004198e8: b.lt     #0x41990c
004198ec: mov      x0, x19
004198f0: bl       #0x4396c0
004198f4: str      w0, [x19, #0x2d40]
004198f8: bl       #0x50aaf8
004198fc: mov      w8, #0xc200
00419900: movk     w8, #0xbeb, lsl #16
00419904: add      x8, x0, x8
00419908: str      x8, [x19, #0x2d38]
0041990c: ldr      w20, [x19, #0x2d40]
00419910: cmp      w20, #0
00419914: b.gt     #0x41991c
00419918: ldr      w20, [x19, #0x68c]
0041991c: ldr      x8, [x19, #0x758]
00419920: ldr      x9, [x19, #0x760]
00419924: cmp      x9, x8
00419928: b.eq     #0x419c3c
0041992c: ldr      x10, [x19, #0x770]
00419930: ldr      x9, [x19, #0x778]
00419934: mov      x12, #0xc30d
00419938: movk     x12, #0xc30, lsl #16
0041993c: add      x13, x9, x10
00419940: lsr      x11, x10, #1
00419944: movk     x12, #0x30c3, lsl #32
00419948: lsr      x9, x13, #1
0041994c: movk     x12, #0xc30c, lsl #48
00419950: umulh    x11, x11, x12
00419954: umulh    x12, x9, x12
00419958: lsr      x9, x11, #4
0041995c: mov      w11, #0x2a
00419960: lsr      x12, x12, #4
00419964: msub     x10, x9, x11, x10
00419968: ldr      x14, [x8, x9, lsl #3]
0041996c: nop      
00419970: msub     x11, x12, x11, x13
00419974: mov      w13, #0x60
00419978: madd     x21, x10, x13, x14
0041997c: ldr      x10, [x8, x12, lsl #3]
00419980: nop      
00419984: madd     x25, x11, x13, x10
00419988: cmp      x21, x25
0041998c: b.eq     #0x419c3c
00419990: ldr      w10, [sp, #0xc]
00419994: add      x24, x8, x9, lsl #3
00419998: sxtw     x26, w20
0041999c: mov      w27, #0x7f800000
004199a0: mov      w28, #0x3fff
004199a4: scvtf    s8, w10
004199a8: b        #0x4199b4
004199ac: cmp      x21, x25
004199b0: b.eq     #0x419c3c
004199b4: ldr      w8, [x21, #8]
004199b8: tbnz     w8, #0x1f, #0x419a60
004199bc: ldrb     w8, [x21, #0x3d]
004199c0: cbz      w8, #0x419a60
004199c4: ldr      w1, [x21, #0x18]
004199c8: add      x0, sp, #0x18
004199cc: bl       #0x439998
004199d0: tbz      w0, #0, #0x419a60
004199d4: ldp      s0, s1, [x21, #0xc]
004199d8: ldp      s2, s3, [x23, #0xc]
004199dc: fsub     s0, s0, s2
004199e0: fsub     s1, s1, s3
004199e4: bl       #0x5549b0 ; hypotf
004199e8: fcmp     s0, s8
004199ec: b.gt     #0x419a60
004199f0: fabs     s0, s0
004199f4: fmov     s1, w27
004199f8: fcmp     s0, s1
004199fc: b.eq     #0x419a60
00419a00: b.vs     #0x419a60
00419a04: ldr      x0, [x19, #0x30]
00419a08: ldr      x9, [x21, #0x50]
00419a0c: add      x2, sp, #0x10
00419a10: mov      w3, #8
00419a14: str      xzr, [sp, #0x10]
00419a18: ldr      x8, [x0]
00419a1c: add      x1, x9, #0x150
00419a20: ldr      x8, [x8, #0x10]
00419a24: blr      x8
00419a28: tbz      w0, #0, #0x419a60
00419a2c: ldr      x9, [sp, #0x10]
00419a30: add      x8, x9, x28
00419a34: cmp      x9, #0
00419a38: csel     x8, x8, x9, lt
00419a3c: cmp      x9, #4, lsl #12
00419a40: asr      x8, x8, #0xe
00419a44: str      x8, [x21, #0x20]
00419a48: b.lt     #0x419a54
00419a4c: cmp      x8, x26
00419a50: b.le     #0x419b8c
00419a54: mov      x0, x19
00419a58: mov      x1, x21
00419a5c: bl       #0x436454
00419a60: ldr      x8, [x24]
00419a64: add      x21, x21, #0x60
00419a68: sub      x8, x21, x8
00419a6c: cmp      x8, #0xfc0
00419a70: b.ne     #0x4199ac
00419a74: ldr      x21, [x24, #8]!
00419a78: b        #0x4199ac
00419a7c: ldr      w26, [x23, #0x1c]
00419a80: sub      w13, w26, #1
00419a84: cmp      w13, #1
00419a88: b.hi     #0x419c3c
00419a8c: ldr      s8, [x23, #0xc]
00419a90: fcmp     s8, #0.0
00419a94: b.ne     #0x419aa4
00419a98: ldr      s0, [x23, #0x10]
00419a9c: fcmp     s0, #0.0
00419aa0: b.eq     #0x419c3c
00419aa4: cmp      x10, x8
00419aa8: b.eq     #0x419c3c
00419aac: and      x9, x9, #0xf
00419ab0: mov      w10, #0x1b0
00419ab4: and      x11, x11, #0xf
00419ab8: ldr      x13, [x20]
00419abc: nop      
00419ac0: umaddl   x27, w9, w10, x13
00419ac4: ldr      x8, [x8, x12, lsl #3]
00419ac8: nop      
00419acc: umaddl   x28, w11, w10, x8
00419ad0: cmp      x27, x28
00419ad4: b.eq     #0x419c3c
00419ad8: ldr      w8, [sp, #0xc]
00419adc: mov      w24, #0x1b00
00419ae0: scvtf    s9, w8
00419ae4: b        #0x419af0
00419ae8: cmp      x27, x28
00419aec: b.eq     #0x419c3c
00419af0: ldr      w8, [x27, #8]
00419af4: tbnz     w8, #0x1f, #0x419b70
00419af8: ldrb     w8, [x27, #0x20]
00419afc: cbnz     w8, #0x419b70
00419b00: ldr      w8, [x27, #0x1c]
00419b04: eor      w8, w8, w26
00419b08: cmp      w8, #3
00419b0c: b.ne     #0x419b70
00419b10: ldr      s0, [x27, #0x28]
00419b14: fcmp     s0, #0.0
00419b18: b.le     #0x419b70
00419b1c: ldp      s0, s1, [x27, #0xc]
00419b20: fcmp     s0, #0.0
00419b24: b.ne     #0x419b30
00419b28: fcmp     s1, #0.0
00419b2c: b.eq     #0x419b70
00419b30: ldr      s2, [x23, #0x10]
00419b34: fsub     s0, s0, s8
00419b38: mov      x21, x0
00419b3c: fsub     s1, s1, s2
00419b40: bl       #0x5549b0 ; hypotf
00419b44: fcmp     s0, s9
00419b48: mov      x0, x21
00419b4c: mov      w21, #0xa455
00419b50: movk     w21, #0x4d5, lsl #16
00419b54: b.hi     #0x419b70
00419b58: fabs     s0, s0
00419b5c: mov      w8, #0x7f800000
00419b60: fmov     s1, w8
00419b64: fcmp     s0, s1
00419b68: b.mi     #0x419840
00419b6c: b.gt     #0x419840
00419b70: ldr      x8, [x20]
00419b74: add      x27, x27, #0x1b0
00419b78: sub      x8, x27, x8
00419b7c: cmp      x8, x24
00419b80: b.ne     #0x419ae8
00419b84: ldr      x27, [x20, #8]!
00419b88: b        #0x419ae8
00419b8c: mov      w11, #0x28f6
00419b90: ldr      w8, [x19, #0x698]
00419b94: ldr      w9, [x19, #0x69c]
00419b98: movk     w11, #0x3f5c, lsl #16
00419b9c: ldr      s0, [x19, #0x6a0]
00419ba0: fmov     s3, w11
00419ba4: and      w10, w8, #0x7fffffff
00419ba8: cmn      w8, #1
00419bac: sub      w10, w10, #0x800, lsl #12
00419bb0: mov      w11, #0x7f
00419bb4: fmov     s2, w8
00419bb8: lsr      w10, w10, #0x18
00419bbc: sub      w12, w8, #1
00419bc0: and      w8, w9, #0x7fffffff
00419bc4: fmul     s1, s0, s3
00419bc8: sub      w8, w8, #0x800, lsl #12
00419bcc: fmov     s5, w9
00419bd0: ccmp     w10, w11, #2, gt
00419bd4: mov      w10, #0x7fffff
00419bd8: lsr      w8, w8, #0x18
00419bdc: ccmp     w12, w10, #0, hs
00419be0: sub      w12, w9, #1
00419be4: fcsel    s2, s2, s1, lo
00419be8: ldr      s1, [x19, #0x6a4]
00419bec: cmn      w9, #1
00419bf0: ccmp     w8, w11, #2, gt
00419bf4: mov      w8, #0x7f800000
00419bf8: fmul     s3, s1, s3
00419bfc: fmov     s6, w8
00419c00: ccmp     w12, w10, #0, hs
00419c04: fabs     s4, s2
00419c08: fcsel    s3, s5, s3, lo
00419c0c: fcmp     s4, s6
00419c10: b.eq     #0x419c3c
00419c14: b.vs     #0x419c3c
00419c18: fabs     s4, s3
00419c1c: fmov     s5, w8
00419c20: fcmp     s4, s5
00419c24: b.eq     #0x419c3c
00419c28: b.vs     #0x419c3c
00419c2c: fcmp     s0, #0.0
00419c30: b.ls     #0x419c3c
00419c34: fcmp     s1, #0.0
00419c38: b.hi     #0x419c74
00419c3c: ldr      x8, [x22, #0x28]
00419c40: ldur     x9, [x29, #-0x18]
00419c44: cmp      x8, x9
00419c48: b.ne     #0x419c70
00419c4c: ldp      x20, x19, [sp, #0xa0]
00419c50: ldp      x22, x21, [sp, #0x90]
00419c54: ldp      x24, x23, [sp, #0x80]
00419c58: ldp      x26, x25, [sp, #0x70]
00419c5c: ldp      x28, x27, [sp, #0x60]
00419c60: ldp      x29, x30, [sp, #0x50]
00419c64: ldp      d9, d8, [sp, #0x40]
00419c68: add      sp, sp, #0xb0
00419c6c: ret      
00419c70: bl       #0x553f00 ; __stack_chk_fail
00419c74: fcmp     s2, s0
00419c78: movi     d4, #0000000000000000
00419c7c: mov      w0, #8
00419c80: fcsel    s0, s0, s2, gt
00419c84: fcmp     s2, #0.0
00419c88: fcsel    s0, s4, s0, mi
00419c8c: fcmp     s3, s1
00419c90: fcsel    s1, s1, s3, gt
00419c94: fcmp     s3, #0.0
00419c98: fcvtas   x1, s0
00419c9c: fcsel    s1, s4, s1, mi
00419ca0: fcvtas   x2, s1
00419ca4: bl       #0x3a2ed0
00419ca8: mov      w0, #0x1388
00419cac: bl       #0x5544d0 ; usleep
00419cb0: mov      w0, #8
00419cb4: bl       #0x3a2edc
00419cb8: bl       #0x50aaf8
00419cbc: mov      w8, #0xe100
00419cc0: mov      x1, x21
00419cc4: movk     w8, #0x5f5, lsl #16
00419cc8: add      x8, x0, x8
00419ccc: mov      x0, x19
00419cd0: str      x8, [x19, #0x2d30]
00419cd4: bl       #0x436454
00419cd8: adrp     x19, #0x563000
00419cdc: adrp     x1, #0x2b000
00419ce0: add      x1, x1, #0x884 ; '[smite] click id=%d health=%lld threshold=%d\n'
00419ce4: ldr      x19, [x19, #0x138]
00419ce8: ldr      w2, [x21, #0x18]
00419cec: ldr      x3, [x21, #0x20]
00419cf0: mov      w4, w20
00419cf4: ldr      x0, [x19]
00419cf8: bl       #0x554500 ; fprintf
00419cfc: ldr      x0, [x19]
00419d00: bl       #0x5540e0 ; fflush
00419d04: b        #0x419c3c
