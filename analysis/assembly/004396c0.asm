004396c0: sub      sp, sp, #0x60
004396c4: stp      x29, x30, [sp, #0x20]
004396c8: stp      x24, x23, [sp, #0x30]
004396cc: stp      x22, x21, [sp, #0x40]
004396d0: stp      x20, x19, [sp, #0x50]
004396d4: add      x29, sp, #0x20
004396d8: mrs      x19, tpidr_el0
004396dc: mov      x8, x0
004396e0: ldr      x9, [x19, #0x28]
004396e4: stur     x9, [x29, #-8]
004396e8: ldr      x0, [x0, #0x30]
004396ec: cbz      x0, #0x439880
004396f0: ldr      x9, [x8, #0x740]
004396f4: mov      w10, #0x71b1
004396f8: movk     w10, #0x38, lsl #16
004396fc: cmp      x9, x10
00439700: b.lo     #0x43987c
00439704: mov      x10, #-0x71b0
00439708: mov      x20, #0xfffffffe0000
0043970c: str      xzr, [sp, #0x10]
00439710: movk     x10, #0xffc6, lsl #16
00439714: movk     x20, #0xfff9
00439718: add      x11, x9, x10
0043971c: cmp      x11, x20
00439720: b.hs     #0x43987c
00439724: mov      x21, x8
00439728: ldr      x8, [x0]
0043972c: add      x9, x10, x9
00439730: add      x1, x9, #0x10, lsl #12
00439734: add      x2, sp, #0x10
00439738: mov      w3, #8
0043973c: ldr      x8, [x8, #0x10]
00439740: blr      x8
00439744: tbz      w0, #0, #0x43987c
00439748: ldr      x8, [sp, #0x10]
0043974c: mov      x10, #-0x10001
00439750: movk     x10, #0, lsl #48
00439754: and      x9, x8, #0xffffffffff
00439758: sub      x8, x9, #0x10, lsl #12
0043975c: cmp      x8, x10
00439760: b.hi     #0x43987c
00439764: mov      x8, x21
00439768: mov      x22, xzr
0043976c: adrp     x23, #0x34000
00439770: add      x23, x23, #0xbc0
00439774: mov      x24, #0xffffffff0000
00439778: ldr      x10, [x23, x22]
0043977c: cmn      x10, x9
00439780: b.hs     #0x43987c
00439784: add      x1, x9, x10
00439788: ldr      x8, [x8, #0x30]
0043978c: mov      w0, wzr
00439790: sub      x9, x1, #0x10, lsl #12
00439794: str      xzr, [sp, #0x10]
00439798: cmp      x9, x20
0043979c: b.hs     #0x439880
004397a0: cbz      x8, #0x439880
004397a4: ldr      x9, [x8]
004397a8: add      x2, sp, #0x10
004397ac: mov      x0, x8
004397b0: mov      w3, #8
004397b4: ldr      x9, [x9, #0x10]
004397b8: blr      x9
004397bc: tbz      w0, #0, #0x43987c
004397c0: ldr      x8, [sp, #0x10]
004397c4: and      x9, x8, #0xffffffffff
004397c8: sub      x8, x9, #0x10, lsl #12
004397cc: str      x9, [sp, #0x10]
004397d0: cmp      x8, x24
004397d4: b.hs     #0x43987c
004397d8: add      x22, x22, #8
004397dc: mov      x8, x21
004397e0: cmp      x22, #0x38
004397e4: b.ne     #0x439778
004397e8: ldr      x0, [x8, #0x30]
004397ec: str      wzr, [sp, #4]
004397f0: str      xzr, [sp, #8]
004397f4: cbz      x0, #0x43986c
004397f8: ldr      x8, [x0]
004397fc: add      x1, x9, #8
00439800: add      x2, sp, #8
00439804: mov      w3, #8
00439808: ldr      x8, [x8, #0x10]
0043980c: blr      x8
00439810: mov      x8, x21
00439814: tbz      w0, #0, #0x43986c
00439818: ldr      x9, [sp, #8]
0043981c: sub      x11, x20, #0x3d
00439820: and      x9, x9, #0xffffffffff
00439824: sub      x10, x9, #0x10, lsl #12
00439828: str      x9, [sp, #8]
0043982c: cmp      x10, x11
00439830: b.hs     #0x43986c
00439834: ldr      x0, [x8, #0x30]
00439838: add      x1, x9, #0x44
0043983c: add      x2, sp, #4
00439840: mov      w3, #4
00439844: ldr      x8, [x0]
00439848: ldr      x8, [x8, #0x10]
0043984c: blr      x8
00439850: mov      x8, x21
00439854: tbz      w0, #0, #0x43986c
00439858: ldr      w9, [sp, #4]
0043985c: mov      w10, #0xa455
00439860: movk     w10, #0x4d5, lsl #16
00439864: cmp      w9, w10
00439868: b.eq     #0x439934
0043986c: ldr      x9, [sp, #0x10]
00439870: str      wzr, [sp, #4]
00439874: cmn      x9, #0x11
00439878: b.ls     #0x4398a8
0043987c: mov      w0, wzr
00439880: ldr      x8, [x19, #0x28]
00439884: ldur     x9, [x29, #-8]
00439888: cmp      x8, x9
0043988c: b.ne     #0x439994
00439890: ldp      x20, x19, [sp, #0x50]
00439894: ldp      x22, x21, [sp, #0x40]
00439898: ldp      x24, x23, [sp, #0x30]
0043989c: ldp      x29, x30, [sp, #0x20]
004398a0: add      sp, sp, #0x60
004398a4: ret      
004398a8: mov      x10, #-0xfff0
004398ac: ldr      x0, [x8, #0x30]
004398b0: str      xzr, [sp, #8]
004398b4: add      x10, x9, x10
004398b8: cmp      x10, x20
004398bc: b.hs     #0x43987c
004398c0: cbz      x0, #0x43987c
004398c4: ldr      x8, [x0]
004398c8: add      x1, x9, #0x10
004398cc: add      x2, sp, #8
004398d0: mov      w3, #8
004398d4: ldr      x8, [x8, #0x10]
004398d8: blr      x8
004398dc: tbz      w0, #0, #0x43987c
004398e0: ldr      x8, [sp, #8]
004398e4: sub      x11, x20, #0x3d
004398e8: and      x8, x8, #0xffffffffff
004398ec: sub      x10, x8, #0x10, lsl #12
004398f0: str      x8, [sp, #8]
004398f4: cmp      x10, x11
004398f8: b.hs     #0x43987c
004398fc: ldr      x0, [x21, #0x30]
00439900: add      x1, x8, #0x44
00439904: add      x2, sp, #4
00439908: mov      w3, #4
0043990c: ldr      x9, [x0]
00439910: ldr      x9, [x9, #0x10]
00439914: blr      x9
00439918: tbz      w0, #0, #0x43987c
0043991c: ldr      w9, [sp, #4]
00439920: mov      w10, #0xa455
00439924: mov      x8, x21
00439928: movk     w10, #0x4d5, lsl #16
0043992c: cmp      w9, w10
00439930: b.ne     #0x43987c
00439934: ldr      x9, [sp, #8]
00439938: mov      x10, #-0xffc8
0043993c: add      x11, x20, #4
00439940: mov      w0, wzr
00439944: str      wzr, [sp]
00439948: add      x10, x9, x10
0043994c: cmp      x10, x11
00439950: b.hs     #0x439880
00439954: ldr      x0, [x8, #0x30]
00439958: add      x1, x9, #0x38
0043995c: mov      x2, sp
00439960: mov      w3, #4
00439964: ldr      x8, [x0]
00439968: ldr      x8, [x8, #0x10]
0043996c: blr      x8
00439970: tbz      w0, #0, #0x43987c
00439974: ldr      w8, [sp]
00439978: sub      w8, w8, #1
0043997c: cmp      w8, #2
00439980: b.hi     #0x43987c
00439984: mov      w9, #0x190
00439988: mov      w10, #0x258
0043998c: madd     w0, w8, w9, w10
00439990: b        #0x439880
00439994: bl       #0x553f00
