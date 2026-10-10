0041a25c: stp      x29, x30, [sp, #-0x30]!
0041a260: stp      x22, x21, [sp, #0x10]
0041a264: stp      x20, x19, [sp, #0x20]
0041a268: mov      x29, sp
0041a26c: ldrb     w8, [x0, #0x68a]
0041a270: tbz      w8, #0, #0x41a440
0041a274: mov      x19, x0
0041a278: mov      x20, x1
0041a27c: bl       #0x3a2d10
0041a280: tbz      w0, #0, #0x41a440
0041a284: ldp      x10, x8, [x19, #0x138]
0041a288: cmp      x8, x10
0041a28c: b.eq     #0x41a440
0041a290: ldp      x8, x9, [x19, #0x150]
0041a294: mov      w13, #0x1b0
0041a298: lsr      x11, x8, #4
0041a29c: add      x12, x9, x8
0041a2a0: and      x8, x8, #0xf
0041a2a4: add      x9, x10, x11, lsl #3
0041a2a8: lsr      x11, x12, #1
0041a2ac: and      x12, x12, #0xf
0041a2b0: and      x11, x11, #0x7ffffffffffffff8
0041a2b4: ldr      x14, [x9]
0041a2b8: nop      
0041a2bc: umaddl   x8, w8, w13, x14
0041a2c0: ldr      x10, [x10, x11]
0041a2c4: nop      
0041a2c8: umaddl   x10, w12, w13, x10
0041a2cc: cmp      x8, x10
0041a2d0: b.eq     #0x41a440
0041a2d4: mov      w11, #0x1b00
0041a2d8: b        #0x41a2e4
0041a2dc: cmp      x8, x10
0041a2e0: b.eq     #0x41a31c
0041a2e4: ldr      w12, [x8, #8]
0041a2e8: tbnz     w12, #0x1f, #0x41a300
0041a2ec: ldrb     w12, [x8, #0x20]
0041a2f0: cbz      w12, #0x41a300
0041a2f4: ldr      s0, [x8, #0x28]
0041a2f8: fcmp     s0, #0.0
0041a2fc: b.gt     #0x41a320
0041a300: ldr      x12, [x9]
0041a304: add      x8, x8, #0x1b0
0041a308: sub      x12, x8, x12
0041a30c: cmp      x12, x11
0041a310: b.ne     #0x41a2dc
0041a314: ldr      x8, [x9, #8]!
0041a318: b        #0x41a2dc
0041a31c: mov      x8, xzr
0041a320: cbz      x8, #0x41a440
0041a324: ldr      w9, [x8, #0x24]
0041a328: sub      w9, w9, #1
0041a32c: cmp      w9, #1
0041a330: b.hi     #0x41a440
0041a334: ldrb     w9, [x8, #0x180]
0041a338: cbz      w9, #0x41a440
0041a33c: ldr      w9, [x8, #0x170]
0041a340: cmp      w9, #0x8f9
0041a344: b.ne     #0x41a440
0041a348: mov      w9, #0x2d50
0041a34c: ldr      s0, [x8, #0x178]
0041a350: ldrb     w10, [x19, x9]
0041a354: cbz      w10, #0x41a370
0041a358: fcmp     s0, #0.0
0041a35c: b.gt     #0x41a36c
0041a360: ldr      x10, [x19, #0x2d48]
0041a364: cmp      x10, x20
0041a368: b.gt     #0x41a440
0041a36c: strb     wzr, [x19, x9]
0041a370: fcmp     s0, #0.0
0041a374: b.gt     #0x41a440
0041a378: ldr      x9, [x19, #0x2d48]
0041a37c: cmp      x9, x20
0041a380: b.gt     #0x41a440
0041a384: ldr      w9, [x19, #0x6a8]
0041a388: mov      w12, #0xae14
0041a38c: ldr      w10, [x19, #0x6ac]
0041a390: movk     w12, #0x3f47, lsl #16
0041a394: ldr      s0, [x19, #0x6a0]
0041a398: and      w11, w9, #0x7fffffff
0041a39c: fmov     s1, w12
0041a3a0: cmn      w9, #1
0041a3a4: sub      w11, w11, #0x800, lsl #12
0041a3a8: mov      w12, #0x7f
0041a3ac: sub      w13, w9, #1
0041a3b0: lsr      w11, w11, #0x18
0041a3b4: fmov     s2, w9
0041a3b8: and      w9, w10, #0x7fffffff
0041a3bc: fmul     s1, s0, s1
0041a3c0: sub      w9, w9, #0x800, lsl #12
0041a3c4: fmov     s5, w10
0041a3c8: ccmp     w11, w12, #2, gt
0041a3cc: mov      w11, #0x7fffff
0041a3d0: lsr      w9, w9, #0x18
0041a3d4: ccmp     w13, w11, #0, hs
0041a3d8: mov      w13, #0x28f6
0041a3dc: movk     w13, #0x3f5c, lsl #16
0041a3e0: fcsel    s2, s2, s1, lo
0041a3e4: fmov     s3, w13
0041a3e8: ldr      s1, [x19, #0x6a4]
0041a3ec: cmn      w10, #1
0041a3f0: sub      w13, w10, #1
0041a3f4: ccmp     w9, w12, #2, gt
0041a3f8: mov      w9, #0x7f800000
0041a3fc: fmul     s3, s1, s3
0041a400: fmov     s6, w9
0041a404: ccmp     w13, w11, #0, hs
0041a408: fabs     s4, s2
0041a40c: fcsel    s3, s5, s3, lo
0041a410: fcmp     s4, s6
0041a414: b.eq     #0x41a440
0041a418: b.vs     #0x41a440
0041a41c: fabs     s4, s3
0041a420: fmov     s5, w9
0041a424: fcmp     s4, s5
0041a428: b.eq     #0x41a440
0041a42c: b.vs     #0x41a440
0041a430: fcmp     s0, #0.0
0041a434: b.ls     #0x41a440
0041a438: fcmp     s1, #0.0
0041a43c: b.hi     #0x41a450
0041a440: ldp      x20, x19, [sp, #0x20]
0041a444: ldp      x22, x21, [sp, #0x10]
0041a448: ldp      x29, x30, [sp], #0x30
0041a44c: ret      
0041a450: fcmp     s2, s0
0041a454: movi     d4, #0000000000000000
0041a458: mov      w0, #8
0041a45c: mov      x21, x8
0041a460: mov      w22, #0x2d50
0041a464: fcsel    s0, s0, s2, gt
0041a468: fcmp     s2, #0.0
0041a46c: fcsel    s0, s4, s0, mi
0041a470: fcmp     s3, s1
0041a474: fcsel    s1, s1, s3, gt
0041a478: fcmp     s3, #0.0
0041a47c: fcvtas   x1, s0
0041a480: fcsel    s1, s4, s1, mi
0041a484: fcvtas   x2, s1
0041a488: bl       #0x3a2ed0
0041a48c: mov      w0, #0x1388
0041a490: bl       #0x5544d0 ; usleep
0041a494: mov      w0, #8
0041a498: bl       #0x3a2edc
0041a49c: mov      w8, #0xb280
0041a4a0: adrp     x1, #0x24000
0041a4a4: add      x1, x1, #0x60e ; '[mercury] click control=%d cooldown=%.3f\n'
0041a4a8: movk     w8, #0xee6, lsl #16
0041a4ac: add      x8, x20, x8
0041a4b0: adrp     x20, #0x563000
0041a4b4: str      x8, [x19, #0x2d48]
0041a4b8: mov      w8, #1
0041a4bc: ldr      s0, [x21, #0x178]
0041a4c0: ldr      x20, [x20, #0x138]
0041a4c4: ldr      w2, [x21, #0x24]
0041a4c8: strb     w8, [x19, x22]
0041a4cc: fcvt     d0, s0
0041a4d0: ldr      x0, [x20]
0041a4d4: bl       #0x554500 ; fprintf
0041a4d8: ldr      x0, [x20]
0041a4dc: ldp      x20, x19, [sp, #0x20]
0041a4e0: ldp      x22, x21, [sp, #0x10]
0041a4e4: ldp      x29, x30, [sp], #0x30
0041a4e8: b        #0x5540e0 ; fflush
