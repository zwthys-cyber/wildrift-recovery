0041f138: stp      d15, d14, [sp, #-0xa0]!
0041f13c: stp      d13, d12, [sp, #0x10]
0041f140: stp      d11, d10, [sp, #0x20]
0041f144: stp      d9, d8, [sp, #0x30]
0041f148: stp      x29, x30, [sp, #0x40]
0041f14c: stp      x28, x27, [sp, #0x50]
0041f150: stp      x26, x25, [sp, #0x60]
0041f154: stp      x24, x23, [sp, #0x70]
0041f158: stp      x22, x21, [sp, #0x80]
0041f15c: stp      x20, x19, [sp, #0x90]
0041f160: add      x29, sp, #0x40
0041f164: sub      sp, sp, #0x5e0
0041f168: mrs      x8, tpidr_el0
0041f16c: adrp     x1, #0x59f000
0041f170: add      x1, x1, #0x19c
0041f174: str      x8, [sp, #0x48]
0041f178: mov      w0, wzr
0041f17c: ldr      x8, [x8, #0x28]
0041f180: stur     x8, [x29, #-0x58]
0041f184: bl       #0x54fcb0
0041f188: adrp     x20, #0x593000
0041f18c: add      x20, x20, #0x554
0041f190: tbz      w0, #0, #0x41f19c
0041f194: mov      w8, #1
0041f198: stlrb    w8, [x20]
0041f19c: tbz      w0, #1, #0x41f1a4
0041f1a0: stlrb    wzr, [x20]
0041f1a4: bl       #0x3b559c
0041f1a8: mov      x19, x0
0041f1ac: add      x21, x0, #0x11c
0041f1b0: add      x0, sp, #0x80
0041f1b4: bl       #0x3b3bac
0041f1b8: add      x1, sp, #0x80
0041f1bc: mov      x0, x19
0041f1c0: mov      w2, #0x4a0
0041f1c4: bl       #0x553fb0 ; memcpy
0041f1c8: mov      x0, x19
0041f1cc: bl       #0x3d10b4
0041f1d0: bl       #0x3bb6a0
0041f1d4: fmov     s9, #4.00000000
0041f1d8: ldr      s0, [x0, #0x38]
0041f1dc: mov      w24, #0xd70a
0041f1e0: fmov     s10, #20.00000000
0041f1e4: movk     w24, #0x3c23, lsl #16
0041f1e8: mov      w8, #0xcccc
0041f1ec: fmov     s8, w24
0041f1f0: movk     w8, #0x3e4c, lsl #16
0041f1f4: fcmp     s0, s9
0041f1f8: fmov     s13, w8
0041f1fc: fcsel    s1, s9, s0, gt
0041f200: fcmp     s0, s8
0041f204: fmul     s1, s1, s10
0041f208: fcsel    s0, s13, s1, mi
0041f20c: str      s0, [x19, #0x10]
0041f210: bl       #0x3bb6a0
0041f214: ldr      s0, [x0, #0x38]
0041f218: fmov     s11, #25.00000000
0041f21c: fmov     s12, #0.25000000
0041f220: fcmp     s0, s9
0041f224: fcsel    s1, s9, s0, gt
0041f228: fcmp     s0, s8
0041f22c: fmul     s1, s1, s11
0041f230: fcsel    s0, s12, s1, mi
0041f234: str      s0, [x19, #0x30]
0041f238: bl       #0x3bb6a0
0041f23c: ldr      s0, [x0, #0x38]
0041f240: fcmp     s0, s9
0041f244: fcsel    s1, s9, s0, gt
0041f248: fcmp     s0, s8
0041f24c: fmul     s1, s1, s11
0041f250: fcsel    s0, s12, s1, mi
0041f254: str      s0, [x19, #0x48]
0041f258: bl       #0x3bb6a0
0041f25c: ldr      s0, [x0, #0x38]
0041f260: fcmp     s0, s9
0041f264: fcsel    s1, s9, s0, gt
0041f268: fcmp     s0, s8
0041f26c: fmul     s1, s1, s10
0041f270: fcsel    s0, s13, s1, mi
0041f274: str      s0, [x19, #0x38]
0041f278: bl       #0x3bb6a0
0041f27c: ldr      s0, [x0, #0x38]
0041f280: fcmp     s0, s9
0041f284: fcsel    s1, s9, s0, gt
0041f288: fcmp     s0, s8
0041f28c: fmul     s1, s1, s10
0041f290: fcsel    s0, s13, s1, mi
0041f294: str      s0, [x19, #0x7c]
0041f298: bl       #0x3bb6a0
0041f29c: ldr      s0, [x0, #0x38]
0041f2a0: mov      w8, #0xc000
0041f2a4: movk     w8, #0x4479, lsl #16
0041f2a8: fcmp     s0, s9
0041f2ac: fmov     s2, w8
0041f2b0: mov      w8, #0xd70a
0041f2b4: movk     w8, #0x411f, lsl #16
0041f2b8: fcsel    s1, s9, s0, gt
0041f2bc: fcmp     s0, s8
0041f2c0: fmov     s0, w8
0041f2c4: fmul     s1, s1, s2
0041f2c8: fcsel    s0, s0, s1, mi
0041f2cc: str      s0, [x19, #0x84]
0041f2d0: bl       #0x3bb6a0
0041f2d4: ldr      s0, [x0, #0x38]
0041f2d8: fmov     s2, #15.00000000
0041f2dc: mov      w8, #0x9999
0041f2e0: movk     w8, #0x3e19, lsl #16
0041f2e4: fcmp     s0, s9
0041f2e8: fcsel    s1, s9, s0, gt
0041f2ec: fcmp     s0, s8
0041f2f0: fmov     s0, w8
0041f2f4: fmul     s1, s1, s2
0041f2f8: fcsel    s0, s0, s1, mi
0041f2fc: str      s0, [x19, #0x90]
0041f300: bl       #0x3bb6a0
0041f304: ldr      s0, [x0, #0x38]
0041f308: fmov     s2, #3.00000000
0041f30c: mov      w23, #0xc28f
0041f310: movk     w23, #0x3cf5, lsl #16
0041f314: fcmp     s0, s9
0041f318: fcsel    s1, s9, s0, gt
0041f31c: fcmp     s0, s8
0041f320: fmov     s0, w23
0041f324: fmul     s1, s1, s2
0041f328: fcsel    s0, s0, s1, mi
0041f32c: str      s0, [x19, #0x14]
0041f330: bl       #0x3bb6a0
0041f334: ldr      s0, [x0, #0x38]
0041f338: fcmp     s0, s9
0041f33c: fcsel    s1, s9, s0, gt
0041f340: fcmp     s0, s8
0041f344: fcsel    s0, s8, s1, mi
0041f348: str      s0, [x19, #0x34]
0041f34c: bl       #0x3bb6a0
0041f350: ldr      s0, [x0, #0x38]
0041f354: fcmp     s0, s9
0041f358: fcsel    s1, s9, s0, gt
0041f35c: fcmp     s0, s8
0041f360: fcsel    s0, s8, s1, mi
0041f364: str      s0, [x19, #0x3c]
0041f368: bl       #0x3bb6a0
0041f36c: ldr      s0, [x0, #0x38]
0041f370: mov      w8, #0xd70a
0041f374: movk     w8, #0x3ca3, lsl #16
0041f378: fcmp     s0, s9
0041f37c: fcsel    s1, s9, s0, gt
0041f380: fcmp     s0, s8
0041f384: fmov     s0, w8
0041f388: fadd     s1, s1, s1
0041f38c: fcsel    s0, s0, s1, mi
0041f390: str      s0, [x19, #0x4c]
0041f394: bl       #0x3bb6a0
0041f398: ldr      d0, [x0, #0x38]
0041f39c: str      q0, [sp, #0x50]
0041f3a0: bl       #0x3bb6a0
0041f3a4: ldr      q1, [sp, #0x50]
0041f3a8: fmov     v10.2s, #4.00000000
0041f3ac: add      x8, x0, #0x38
0041f3b0: dup      v13.2s, w24
0041f3b4: mov      w24, #0x9999
0041f3b8: ld1      {v1.s}[1], [x8]
0041f3bc: movk     w24, #0x3e99, lsl #16
0041f3c0: fcmgt    v0.2s, v1.2s, v10.2s
0041f3c4: mov      v2.16b, v1.16b
0041f3c8: fcmgt    v2.2s, v13.2s, v2.2s
0041f3cc: bsl      v0.8b, v10.8b, v1.8b
0041f3d0: fmov     v1.2s, #30.00000000
0041f3d4: fmul     v0.2s, v0.2s, v1.2s
0041f3d8: dup      v1.2s, w24
0041f3dc: bit      v0.8b, v1.8b, v2.8b
0041f3e0: str      d0, [x19, #8]
0041f3e4: bl       #0x3bb6a0
0041f3e8: ldr      d0, [x0, #0x38]
0041f3ec: str      q0, [sp, #0x50]
0041f3f0: bl       #0x3bb6a0
0041f3f4: ldr      q2, [sp, #0x50]
0041f3f8: add      x8, x0, #0x38
0041f3fc: fmov     v0.2s, #12.00000000
0041f400: ld1      {v2.s}[1], [x8]
0041f404: mov      w8, #0xc28f
0041f408: movk     w8, #0x3df5, lsl #16
0041f40c: fcmgt    v1.2s, v2.2s, v10.2s
0041f410: bsl      v1.8b, v10.8b, v2.8b
0041f414: fcmgt    v2.2s, v13.2s, v2.2s
0041f418: fmul     v0.2s, v1.2s, v0.2s
0041f41c: dup      v1.2s, w8
0041f420: bit      v0.8b, v1.8b, v2.8b
0041f424: str      d0, [x19, #0x40]
0041f428: bl       #0x3bb6a0
0041f42c: ldr      d0, [x0, #0x38]
0041f430: str      q0, [sp, #0x50]
0041f434: bl       #0x3bb6a0
0041f438: ldr      q1, [sp, #0x50]
0041f43c: add      x9, x0, #0x38
0041f440: adrp     x8, #0x1f000
0041f444: ld1      {v1.s}[1], [x9]
0041f448: fcmgt    v0.2s, v1.2s, v10.2s
0041f44c: mov      v2.16b, v1.16b
0041f450: fcmgt    v2.2s, v13.2s, v2.2s
0041f454: bsl      v0.8b, v10.8b, v1.8b
0041f458: ldr      d1, [x8, #0xac0]
0041f45c: adrp     x8, #0x1f000
0041f460: fmul     v0.2s, v0.2s, v1.2s
0041f464: ldr      d1, [x8, #0xb60]
0041f468: bit      v0.8b, v1.8b, v2.8b
0041f46c: str      d0, [x19, #0x50]
0041f470: bl       #0x3bb6a0
0041f474: ldr      d0, [x0, #0x38]
0041f478: str      q0, [sp, #0x50]
0041f47c: bl       #0x3bb6a0
0041f480: ldr      q1, [sp, #0x50]
0041f484: add      x9, x0, #0x38
0041f488: adrp     x8, #0x1f000
0041f48c: ld1      {v1.s}[1], [x9]
0041f490: fcmgt    v0.2s, v1.2s, v10.2s
0041f494: mov      v2.16b, v1.16b
0041f498: fcmgt    v2.2s, v13.2s, v2.2s
0041f49c: bsl      v0.8b, v10.8b, v1.8b
0041f4a0: ldr      d1, [x8, #0x970]
0041f4a4: adrp     x8, #0x1f000
0041f4a8: fmul     v0.2s, v0.2s, v1.2s
0041f4ac: ldr      d1, [x8, #0xa68]
0041f4b0: bit      v0.8b, v1.8b, v2.8b
0041f4b4: str      d0, [x19, #0x58]
0041f4b8: bl       #0x3bb6a0
0041f4bc: ldr      d0, [x0, #0x38]
0041f4c0: str      q0, [sp, #0x50]
0041f4c4: bl       #0x3bb6a0
0041f4c8: ldr      q1, [sp, #0x50]
0041f4cc: add      x9, x0, #0x38
0041f4d0: adrp     x8, #0x1f000
0041f4d4: ld1      {v1.s}[1], [x9]
0041f4d8: str      xzr, [x19, #0x68]
0041f4dc: fcmgt    v0.2s, v1.2s, v10.2s
0041f4e0: mov      v2.16b, v1.16b
0041f4e4: fcmgt    v2.2s, v13.2s, v2.2s
0041f4e8: bsl      v0.8b, v10.8b, v1.8b
0041f4ec: ldr      d1, [x8, #0x918]
0041f4f0: adrp     x8, #0x1f000
0041f4f4: fmul     v0.2s, v0.2s, v1.2s
0041f4f8: ldr      d1, [x8, #0xa98]
0041f4fc: bit      v0.8b, v1.8b, v2.8b
0041f500: str      d0, [x19, #0x60]
0041f504: bl       #0x3bb6a0
0041f508: ldr      s0, [x0, #0x38]
0041f50c: fmov     s2, #21.00000000
0041f510: mov      w8, #0xa3d
0041f514: movk     w8, #0x3e57, lsl #16
0041f518: fcmp     s0, s9
0041f51c: fcsel    s1, s9, s0, gt
0041f520: fcmp     s0, s8
0041f524: fmov     s0, w8
0041f528: fmul     s1, s1, s2
0041f52c: fcsel    s0, s0, s1, mi
0041f530: str      s0, [x19, #0x70]
0041f534: bl       #0x3bb6a0
0041f538: ldr      s0, [x0, #0x38]
0041f53c: fmov     s2, #6.00000000
0041f540: mov      w8, #0xc28f
0041f544: movk     w8, #0x3d75, lsl #16
0041f548: fcmp     s0, s9
0041f54c: fcsel    s1, s9, s0, gt
0041f550: fcmp     s0, s8
0041f554: fmov     s0, w8
0041f558: fmul     s1, s1, s2
0041f55c: fcsel    s0, s0, s1, mi
0041f560: str      s0, [x19, #0x74]
0041f564: bl       #0x3bb6a0
0041f568: ldr      s0, [x0, #0x38]
0041f56c: fcmp     s0, s9
0041f570: fcsel    s1, s9, s0, gt
0041f574: fcmp     s0, s8
0041f578: fmul     s1, s1, s11
0041f57c: fcsel    s0, s12, s1, mi
0041f580: str      s0, [x19, #0x78]
0041f584: bl       #0x3bb6a0
0041f588: ldr      s0, [x0, #0x38]
0041f58c: fmov     s2, #30.00000000
0041f590: fcmp     s0, s9
0041f594: fcsel    s1, s9, s0, gt
0041f598: fcmp     s0, s8
0041f59c: fmov     s0, w24
0041f5a0: fmul     s1, s1, s2
0041f5a4: fcsel    s0, s0, s1, mi
0041f5a8: str      s0, [x19, #0x80]
0041f5ac: bl       #0x3bb6a0
0041f5b0: ldr      d0, [x0, #0x38]
0041f5b4: str      q0, [sp, #0x50]
0041f5b8: bl       #0x3bb6a0
0041f5bc: ldr      q2, [sp, #0x50]
0041f5c0: add      x8, x0, #0x38
0041f5c4: movi     v0.2s, #0x42, lsl #24
0041f5c8: ld1      {v2.s}[1], [x8]
0041f5cc: mov      w8, #0xd70a
0041f5d0: movk     w8, #0x3ea3, lsl #16
0041f5d4: fcmgt    v1.2s, v2.2s, v10.2s
0041f5d8: bsl      v1.8b, v10.8b, v2.8b
0041f5dc: fcmgt    v2.2s, v13.2s, v2.2s
0041f5e0: fmul     v0.2s, v1.2s, v0.2s
0041f5e4: dup      v1.2s, w8
0041f5e8: bit      v0.8b, v1.8b, v2.8b
0041f5ec: stur     d0, [x19, #0x1c]
0041f5f0: bl       #0x3bb6a0
0041f5f4: ldr      d0, [x0, #0x38]
0041f5f8: str      q0, [sp, #0x50]
0041f5fc: bl       #0x3bb6a0
0041f600: ldr      q2, [sp, #0x50]
0041f604: add      x8, x0, #0x38
0041f608: fmov     v0.2s, #3.00000000
0041f60c: ld1      {v2.s}[1], [x8]
0041f610: fcmgt    v1.2s, v2.2s, v10.2s
0041f614: bsl      v1.8b, v10.8b, v2.8b
0041f618: fcmgt    v2.2s, v13.2s, v2.2s
0041f61c: fmul     v0.2s, v1.2s, v0.2s
0041f620: dup      v1.2s, w23
0041f624: bit      v0.8b, v1.8b, v2.8b
0041f628: stur     d0, [x19, #0xe4]
0041f62c: bl       #0x3bb6a0
0041f630: ldr      s2, [x0, #0x38]
0041f634: adrp     x9, #0x34000
0041f638: add      x9, x9, #0x624
0041f63c: ldr      q0, [x9]
0041f640: adrp     x9, #0x35000
0041f644: add      x9, x9, #0x248
0041f648: fcmp     s2, s9
0041f64c: ldr      q1, [x9]
0041f650: adrp     x9, #0x20000
0041f654: stur     q0, [x19, #0xfc]
0041f658: ldr      q0, [x9, #0x270]
0041f65c: adrp     x9, #0x20000
0041f660: movi     v3.2s, #0x3f, lsl #24
0041f664: add      x8, x19, #0xfc
0041f668: ldr      q4, [x9, #0x6d0]
0041f66c: fcsel    s5, s9, s2, gt
0041f670: adrp     x9, #0x1f000
0041f674: fcmp     s2, s8
0041f678: str      q1, [x8, #0x10]
0041f67c: ldr      q1, [x9, #0xc90]
0041f680: adrp     x9, #0x1f000
0041f684: adrp     x10, #0x20000
0041f688: str      q0, [x21]
0041f68c: movi     v0.2d, #0000000000000000
0041f690: stp      q4, q1, [x21, #0x20]
0041f694: ldr      q2, [x9, #0xf40]
0041f698: adrp     x9, #0x35000
0041f69c: add      x9, x9, #0x268
0041f6a0: fcsel    s4, s8, s5, mi
0041f6a4: stur     d3, [x19, #0x24]
0041f6a8: str      d3, [x19, #0xb8]
0041f6ac: ldr      q3, [x10, #0x560]
0041f6b0: ldr      q5, [x9]
0041f6b4: adrp     x9, #0x35000
0041f6b8: add      x9, x9, #0x278
0041f6bc: mov      x10, #0xc28f00000000
0041f6c0: stp      q2, q3, [x21, #0x60]
0041f6c4: ldr      q3, [x9]
0041f6c8: adrp     x9, #0x20000
0041f6cc: str      s4, [x19, #0xc8]
0041f6d0: ldr      q4, [x9, #0x150]
0041f6d4: adrp     x9, #0x20000
0041f6d8: stp      q0, q5, [x8, #0x60]
0041f6dc: ldr      q5, [x9, #0x160]
0041f6e0: adrp     x9, #0x1f000
0041f6e4: stp      q3, q3, [x8, #0xa0]
0041f6e8: movk     x10, #0x3cf5, lsl #48
0041f6ec: stp      q3, q3, [x8, #0xc0]
0041f6f0: ldr      q3, [x9, #0xde0]
0041f6f4: adrp     x9, #0x35000
0041f6f8: add      x9, x9, #0x288
0041f6fc: stp      q4, q5, [x21, #0xc0]
0041f700: str      q3, [x21, #0xe0]
0041f704: ldr      q3, [x9]
0041f708: adrp     x9, #0x34000
0041f70c: add      x9, x9, #0x634
0041f710: str      q5, [x21, #0x150]
0041f714: ldr      q4, [x9]
0041f718: adrp     x9, #0x20000
0041f71c: str      q0, [x8, #0x30]
0041f720: ldr      q6, [x9, #0x630]
0041f724: adrp     x9, #0x20000
0041f728: stp      q3, q3, [x8, #0x130]
0041f72c: ldr      q7, [x9, #0x780]
0041f730: adrp     x9, #0x35000
0041f734: add      x9, x9, #0x298
0041f738: str      q6, [x21, #0x210]
0041f73c: stp      q6, q7, [x21, #0x130]
0041f740: ldr      q7, [x9]
0041f744: adrp     x9, #0x1f000
0041f748: ldr      q5, [x9, #0xe00]
0041f74c: adrp     x9, #0x1f000
0041f750: stp      q3, q4, [x8, #0x110]
0041f754: ldr      q16, [x9, #0xe10]
0041f758: adrp     x9, #0x1f000
0041f75c: str      q7, [x8, #0x180]
0041f760: str      q4, [x8, #0x200]
0041f764: stp      q5, q16, [x21, #0x170]
0041f768: ldr      q16, [x9, #0xc20]
0041f76c: adrp     x9, #0x34000
0041f770: add      x9, x9, #0x644
0041f774: str      q7, [x8, #0x220]
0041f778: ldr      q17, [x9]
0041f77c: adrp     x9, #0x20000
0041f780: str      q16, [x21, #0x190]
0041f784: ldr      q16, [x9, #0xa0]
0041f788: adrp     x9, #0x20000
0041f78c: str      q4, [x8, #0x240]
0041f790: stp      q17, q4, [x8, #0x1c0]
0041f794: ldr      q17, [x9, #0x6e0]
0041f798: adrp     x9, #0x20000
0041f79c: ldr      q6, [x9, #0x30]
0041f7a0: add      x9, x19, #0x414
0041f7a4: str      q7, [x8, #0x270]
0041f7a8: stp      q16, q17, [x21, #0x1c0]
0041f7ac: stp      q2, q1, [x21, #0x2b0]
0041f7b0: str      q6, [x21, #0x2d0]
0041f7b4: str      xzr, [x8, #0x310]
0041f7b8: str      q0, [x8, #0x300]
0041f7bc: str      x10, [x9]
0041f7c0: str      q5, [x21, #0x310]
0041f7c4: str      q4, [x8, #0x350]
0041f7c8: str      q4, [x8, #0x290]
0041f7cc: str      q3, [x8, #0x2b0]
0041f7d0: ldarb    w8, [x20]
0041f7d4: tbnz     w8, #0, #0x41f7fc
0041f7d8: adrp     x8, #0x59f000
0041f7dc: adrp     x9, #0x593000
0041f7e0: strb     wzr, [x8, #0x1a0]
0041f7e4: adrp     x8, #0x59f000
0041f7e8: str      wzr, [x8, #0x1a8]
0041f7ec: adrp     x8, #0x59f000
0041f7f0: str      wzr, [x9, #0x558]
0041f7f4: str      wzr, [x8, #0x1ac]
0041f7f8: b        #0x421374
0041f7fc: bl       #0x3bb6a0
0041f800: mov      x19, x0
0041f804: add      x0, sp, #0x70
0041f808: bl       #0x43d978
0041f80c: adrp     x8, #0x59f000
0041f810: adrp     x20, #0x593000
0041f814: ldrb     w9, [x8, #0x1a0]
0041f818: cmp      w9, #1
0041f81c: b.ne     #0x41f828
0041f820: ldr      s8, [x20, #0x558]
0041f824: b        #0x41f838
0041f828: movi     d8, #0000000000000000
0041f82c: mov      w9, #1
0041f830: str      wzr, [x20, #0x558]
0041f834: strb     w9, [x8, #0x1a0]
0041f838: bl       #0x3bb6a0
0041f83c: mov      w8, #0xcccd
0041f840: ldr      s0, [x0, #0x10]
0041f844: fmov     s2, #9.00000000
0041f848: movk     w8, #0x3dcc, lsl #16
0041f84c: fmov     s1, w8
0041f850: adrp     x8, #0x593000
0041f854: ldr      x8, [x8, #0xbb0]
0041f858: fcmp     s0, s1
0041f85c: fcsel    s1, s1, s0, gt
0041f860: fcmp     s0, #0.0
0041f864: fmul     s1, s1, s2
0041f868: movi     d2, #0000000000000000
0041f86c: fcsel    s0, s2, s1, mi
0041f870: fmov     s2, #1.00000000
0041f874: fsub     s1, s2, s8
0041f878: fminnm   s0, s0, s2
0041f87c: fmadd    s8, s1, s0, s8
0041f880: str      s8, [x20, #0x558]
0041f884: cbz      x8, #0x41f934
0041f888: ldrb     w9, [x8, #0x38]
0041f88c: cbz      w9, #0x41f934
0041f890: ldp      x22, x23, [x8, #8]
0041f894: cmp      x22, x23
0041f898: b.eq     #0x41f934
0041f89c: add      x8, sp, #0x80
0041f8a0: mov      w27, wzr
0041f8a4: adrp     x20, #0x556000
0041f8a8: add      x20, x20, #0xf00
0041f8ac: add      x24, x8, #8
0041f8b0: adrp     x21, #0x556000
0041f8b4: add      x21, x21, #0xf10
0041f8b8: mov      w25, #0x40
0041f8bc: b        #0x41f8cc
0041f8c0: add      x22, x22, #8
0041f8c4: cmp      x22, x23
0041f8c8: b.eq     #0x41f940
0041f8cc: ldr      x0, [x22]
0041f8d0: cbz      x0, #0x41f8c0
0041f8d4: mov      x1, x20
0041f8d8: mov      x2, x21
0041f8dc: mov      x3, xzr
0041f8e0: bl       #0x534808
0041f8e4: cbz      x0, #0x41f8c0
0041f8e8: ldp      x12, x8, [x0, #0x28]
0041f8ec: cmp      x12, x8
0041f8f0: b.eq     #0x41f8c0
0041f8f4: sxtw     x11, w27
0041f8f8: cmp      w27, #0x40
0041f8fc: add      x10, x24, w27, sxtw #4
0041f900: csel     w9, w27, w25, gt
0041f904: sub      x11, x9, x11
0041f908: cbz      x11, #0x41f93c
0041f90c: mov      x13, x12
0041f910: add      w27, w27, #1
0041f914: sub      x11, x11, #1
0041f918: ldr      x14, [x13], #0x40
0041f91c: cmp      x13, x8
0041f920: stp      x14, x12, [x10, #-8]
0041f924: add      x10, x10, #0x10
0041f928: mov      x12, x13
0041f92c: b.ne     #0x41f908
0041f930: b        #0x41f8c0
0041f934: mov      w27, wzr
0041f938: b        #0x41f940
0041f93c: mov      w27, w9
0041f940: adrp     x8, #0x59f000
0041f944: ldr      w20, [x8, #0x1a4]
0041f948: cmp      w20, w27
0041f94c: b.le     #0x41f958
0041f950: mov      w20, wzr
0041f954: str      wzr, [x8, #0x1a4]
0041f958: ldr      d12, [x19, #8]
0041f95c: bl       #0x3bb6a0
0041f960: mov      w10, #0x8000
0041f964: mov      w11, #0xc000
0041f968: cmp      w20, #0
0041f96c: movk     w10, #0x44a2, lsl #16
0041f970: movk     w11, #0x448f, lsl #16
0041f974: cset     w8, gt
0041f978: cmp      w20, w27
0041f97c: fmov     s14, #4.00000000
0041f980: fmov     s1, w10
0041f984: fmov     s2, w11
0041f988: cset     w9, le
0041f98c: ldr      s0, [x0, #0x38]
0041f990: fmov     v5.2s, #1.00000000
0041f994: ands     w19, w8, w9
0041f998: mov      w8, #0xd70a
0041f99c: movk     w8, #0x3c23, lsl #16
0041f9a0: fcsel    s1, s2, s1, ne
0041f9a4: fcmp     s0, s14
0041f9a8: fmov     s4, w8
0041f9ac: fmov     v2.2s, #-24.00000000
0041f9b0: fmaxnm   v6.2s, v12.2s, v5.2s
0041f9b4: str      d5, [sp, #8]
0041f9b8: fcsel    s3, s14, s0, gt
0041f9bc: fcmp     s0, s4
0041f9c0: fadd     v0.2s, v6.2s, v2.2s
0041f9c4: str      d6, [sp, #0x30]
0041f9c8: fcsel    s2, s4, s3, mi
0041f9cc: fmaxnm   v3.2s, v0.2s, v5.2s
0041f9d0: fmul     s0, s1, s2
0041f9d4: str      q3, [sp, #0x50]
0041f9d8: fcmp     s3, s0
0041f9dc: fcsel    s13, s3, s0, mi
0041f9e0: bl       #0x3bb6a0
0041f9e4: mov      w8, #0x44610000
0041f9e8: mov      w9, #0x44480000
0041f9ec: ldr      s0, [x0, #0x38]
0041f9f0: fmov     s1, w8
0041f9f4: fmov     s2, w9
0041f9f8: tst      w19, #1
0041f9fc: mov      w8, #0xd70a
0041fa00: adrp     x19, #0x59f000
0041fa04: fmov     s12, s8
0041fa08: movk     w8, #0x3c23, lsl #16
0041fa0c: ldr      s15, [x19, #0x1a8]
0041fa10: adrp     x20, #0x59f000
0041fa14: fcsel    s1, s2, s1, ne
0041fa18: fcmp     s0, s14
0041fa1c: fmov     s3, w8
0041fa20: fcsel    s2, s14, s0, gt
0041fa24: fcmp     s0, s3
0041fa28: fcsel    s0, s3, s2, mi
0041fa2c: fmul     s0, s1, s0
0041fa30: ldr      q1, [sp, #0x50]
0041fa34: mov      s1, v1.s[1]
0041fa38: fcmp     s1, s0
0041fa3c: fcsel    s14, s1, s0, mi
0041fa40: fcmp     s15, #0.0
0041fa44: b.ls     #0x41fa54
0041fa48: ldr      s0, [x20, #0x1ac]
0041fa4c: fcmp     s0, #0.0
0041fa50: b.hi     #0x41fa60
0041fa54: fmov     s15, s13
0041fa58: str      s13, [x19, #0x1a8]
0041fa5c: str      s14, [x20, #0x1ac]
0041fa60: bl       #0x3bb6a0
0041fa64: mov      w8, #0xcccd
0041fa68: ldr      s0, [x0, #0x10]
0041fa6c: fmov     s9, #10.00000000
0041fa70: movk     w8, #0x3dcc, lsl #16
0041fa74: movi     d8, #0000000000000000
0041fa78: fmov     s11, #1.00000000
0041fa7c: fmov     s1, w8
0041fa80: fcmp     s0, s1
0041fa84: fcsel    s1, s1, s0, gt
0041fa88: fcmp     s0, #0.0
0041fa8c: fmul     s1, s1, s9
0041fa90: fcsel    s0, s8, s1, mi
0041fa94: fsub     s1, s13, s15
0041fa98: ldr      s13, [x20, #0x1ac]
0041fa9c: fminnm   s0, s0, s11
0041faa0: fmadd    s0, s1, s0, s15
0041faa4: str      s0, [x19, #0x1a8]
0041faa8: bl       #0x3bb6a0
0041faac: mov      w8, #0xcccd
0041fab0: ldr      s0, [x0, #0x10]
0041fab4: fmov     s3, #1.00000000
0041fab8: movk     w8, #0x3dcc, lsl #16
0041fabc: fsub     s2, s14, s13
0041fac0: fmov     s1, w8
0041fac4: mov      w8, #0xc28f
0041fac8: movk     w8, #0x3cf5, lsl #16
0041facc: fcmp     s0, s1
0041fad0: fcsel    s1, s1, s0, gt
0041fad4: fcmp     s0, #0.0
0041fad8: fmul     s1, s1, s9
0041fadc: fcsel    s0, s8, s1, mi
0041fae0: fsub     s1, s3, s12
0041fae4: fminnm   s0, s0, s11
0041fae8: fmsub    s1, s1, s1, s3
0041faec: fmadd    s2, s2, s0, s13
0041faf0: fmov     s0, w8
0041faf4: fmaxnm   s0, s1, s0
0041faf8: ldr      s1, [x19, #0x1a8]
0041fafc: str      s2, [x20, #0x1ac]
0041fb00: stp      q1, q2, [sp, #0x10]
0041fb04: mov      w0, wzr
0041fb08: bl       #0x3b598c
0041fb0c: ldp      q2, q0, [sp, #0x10]
0041fb10: ldr      q1, [sp, #0x50]
0041fb14: ldr      w8, [sp, #0x74]
0041fb18: mov      v2.s[1], v0.s[0]
0041fb1c: add      w8, w8, #1
0041fb20: str      w8, [sp, #0x74]
0041fb24: fcmgt    v0.2s, v2.2s, v1.2s
0041fb28: mov      v8.8b, v0.8b
0041fb2c: bsl      v8.8b, v1.8b, v2.8b
0041fb30: stur     d8, [x29, #-0xa0]
0041fb34: sub      x0, x29, #0xa0
0041fb38: mov      w1, #1
0041fb3c: bl       #0x3c0e90
0041fb40: movi     d0, #0000000000000000
0041fb44: bl       #0x3c9e20
0041fb48: ldr      d0, [sp, #0x30]
0041fb4c: movi     v1.2s, #0x3f, lsl #24
0041fb50: stur     xzr, [x29, #-0xc0]
0041fb54: fsub     v0.2s, v0.2s, v8.2s
0041fb58: fmul     v0.2s, v0.2s, v1.2s
0041fb5c: stur     d0, [x29, #-0xa0]
0041fb60: sub      x0, x29, #0xa0
0041fb64: sub      x2, x29, #0xc0
0041fb68: mov      w1, #2
0041fb6c: bl       #0x3c9d70
0041fb70: adrp     x0, #0x25000
0041fb74: add      x0, x0, #0x9e9 ; 'lvlolm##main_menu'
0041fb78: mov      x1, xzr
0041fb7c: mov      w2, #0x13b
0041fb80: bl       #0x3c0ebc
0041fb84: tbz      w0, #0, #0x41fc68
0041fb88: bl       #0x3c9d48
0041fb8c: stp      s0, s1, [sp, #0x68]
0041fb90: bl       #0x3c9d5c
0041fb94: str      q0, [sp, #0x50]
0041fb98: str      q1, [sp, #0x30]
0041fb9c: adrp     x8, #0x562000
0041fba0: adrp     x20, #0x59f000
0041fba4: ldr      x8, [x8, #0xed8]
0041fba8: ldr      x0, [x8]
0041fbac: cbz      x0, #0x41fbf4
0041fbb0: ldr      x8, [x20, #0x1b0]
0041fbb4: ldr      x19, [x0, #8]
0041fbb8: adrp     x21, #0x59f000
0041fbbc: cbz      x8, #0x41fbcc
0041fbc0: ldr      x8, [x21, #0x1c0]
0041fbc4: cmp      x8, x19
0041fbc8: b.eq     #0x41fbf4
0041fbcc: adrp     x22, #0x59f000
0041fbd0: add      x22, x22, #0x1b0
0041fbd4: stp      xzr, xzr, [x22]
0041fbd8: mov      w2, #0x8c9a
0041fbdc: adrp     x1, #0x35000
0041fbe0: add      x1, x1, #0x2a8
0041fbe4: movk     w2, #0x28, lsl #16
0041fbe8: bl       #0x3b3284
0041fbec: stp      x0, x1, [x22]
0041fbf0: str      x19, [x21, #0x1c0]
0041fbf4: bl       #0x3c9e3c
0041fbf8: mov      x19, x0
0041fbfc: add      x0, x0, #0x80
0041fc00: mov      w2, #2
0041fc04: mov      x1, x19
0041fc08: bl       #0x3d5fbc
0041fc0c: add      x0, x19, #0x80
0041fc10: mov      x1, x19
0041fc14: mov      w2, wzr
0041fc18: bl       #0x3d6130
0041fc1c: ldr      q1, [sp, #0x50]
0041fc20: ldr      q0, [sp, #0x30]
0041fc24: ldr      x1, [x20, #0x1b0]
0041fc28: mov      v1.s[1], v0.s[0]
0041fc2c: cbz      x1, #0x41fc70
0041fc30: ldr      d0, [sp, #0x68]
0041fc34: stur     xzr, [x29, #-0xc0]
0041fc38: fadd     v0.2s, v1.2s, v0.2s
0041fc3c: stur     d0, [x29, #-0xa0]
0041fc40: ldr      d0, [sp, #8]
0041fc44: stur     d0, [x29, #-0xe0]
0041fc48: add      x2, sp, #0x68
0041fc4c: sub      x3, x29, #0xa0
0041fc50: sub      x4, x29, #0xc0
0041fc54: sub      x5, x29, #0xe0
0041fc58: mov      x0, x19
0041fc5c: mov      w6, #-1
0041fc60: bl       #0x3d566c
0041fc64: b        #0x41fce0
0041fc68: bl       #0x3c5c78
0041fc6c: b        #0x421360
0041fc70: ldr      d0, [sp, #0x68]
0041fc74: fadd     v0.2s, v1.2s, v0.2s
0041fc78: stur     d0, [x29, #-0xa0]
0041fc7c: adrp     x0, #0x35000
0041fc80: add      x0, x0, #0x278
0041fc84: bl       #0x3b5664
0041fc88: mov      w20, w0
0041fc8c: bl       #0x3bb6a0
0041fc90: fmov     s0, #4.00000000
0041fc94: ldr      s1, [x0, #0x38]
0041fc98: fmov     s2, #20.00000000
0041fc9c: mov      w8, #0xd70a
0041fca0: movk     w8, #0x3c23, lsl #16
0041fca4: fcmp     s1, s0
0041fca8: fcsel    s0, s0, s1, gt
0041fcac: fmul     s0, s0, s2
0041fcb0: fmov     s2, w8
0041fcb4: mov      w8, #0xcccc
0041fcb8: movk     w8, #0x3e4c, lsl #16
0041fcbc: fcmp     s1, s2
0041fcc0: fmov     s1, w8
0041fcc4: fcsel    s0, s1, s0, mi
0041fcc8: add      x1, sp, #0x68
0041fccc: sub      x2, x29, #0xa0
0041fcd0: mov      x0, x19
0041fcd4: mov      w3, w20
0041fcd8: mov      w4, wzr
0041fcdc: bl       #0x3d4734
0041fce0: add      x0, x19, #0x80
0041fce4: mov      x1, x19
0041fce8: mov      w2, #1
0041fcec: bl       #0x3d6130
0041fcf0: adrp     x8, #0x593000
0041fcf4: adrp     x9, #0x59f000
0041fcf8: adrp     x19, #0x593000
0041fcfc: ldr      w10, [x8, #0x55c]
0041fd00: ldr      w9, [x9, #0x1a4]
0041fd04: cmp      w10, w9
0041fd08: b.ne     #0x41fd14
0041fd0c: ldr      s8, [x19, #0x560]
0041fd10: b        #0x41fd20
0041fd14: movi     d8, #0000000000000000
0041fd18: str      w9, [x8, #0x55c]
0041fd1c: str      wzr, [x19, #0x560]
0041fd20: bl       #0x3bb6a0
0041fd24: mov      w8, #0xcccd
0041fd28: ldr      s0, [x0, #0x10]
0041fd2c: fmov     s2, #10.00000000
0041fd30: movk     w8, #0x3dcc, lsl #16
0041fd34: fmov     s1, w8
0041fd38: fcmp     s0, s1
0041fd3c: fcsel    s1, s1, s0, gt
0041fd40: fcmp     s0, #0.0
0041fd44: fmul     s1, s1, s2
0041fd48: movi     d2, #0000000000000000
0041fd4c: fcsel    s0, s2, s1, mi
0041fd50: fsub     s1, s11, s8
0041fd54: fminnm   s0, s0, s11
0041fd58: fmadd    s12, s1, s0, s8
0041fd5c: str      s12, [x19, #0x560]
0041fd60: bl       #0x3c712c
0041fd64: fmov     s9, s0
0041fd68: fmov     s8, s1
0041fd6c: bl       #0x3bb6a0
0041fd70: fmov     s0, #4.00000000
0041fd74: ldr      s1, [x0, #0x38]
0041fd78: mov      w8, #0x435c0000
0041fd7c: fmov     s2, w8
0041fd80: mov      w8, #0xd70a
0041fd84: movk     w8, #0x3c23, lsl #16
0041fd88: fcmp     s1, s0
0041fd8c: fcsel    s0, s0, s1, gt
0041fd90: fmul     s0, s0, s2
0041fd94: fmov     s2, w8
0041fd98: mov      w8, #0xcccd
0041fd9c: movk     w8, #0x400c, lsl #16
0041fda0: fcmp     s1, s2
0041fda4: fmov     s1, w8
0041fda8: fcsel    s13, s1, s0, mi
0041fdac: bl       #0x3bb6a0
0041fdb0: ldr      s14, [x0, #0x38]
0041fdb4: bl       #0x3bb6a0
0041fdb8: fmov     s0, #4.00000000
0041fdbc: mov      w8, #0x42f00000
0041fdc0: ldr      s3, [x0, #0x38]
0041fdc4: fmov     s2, w8
0041fdc8: mov      w8, #0xd70a
0041fdcc: stp      xzr, xzr, [x29, #-0xa0]
0041fdd0: movk     w8, #0x3c23, lsl #16
0041fdd4: fcmp     s14, s0
0041fdd8: fcsel    s1, s0, s14, gt
0041fddc: fmul     s1, s1, s2
0041fde0: fmov     s2, w8
0041fde4: mov      w8, #0x9999
0041fde8: movk     w8, #0x3f99, lsl #16
0041fdec: fmov     s4, w8
0041fdf0: mov      w8, #0x43200000
0041fdf4: fcmp     s14, s2
0041fdf8: fcsel    s1, s4, s1, mi
0041fdfc: fcmp     s3, s0
0041fe00: fmov     s4, w8
0041fe04: mov      w8, #0xcccc
0041fe08: movk     w8, #0x3fcc, lsl #16
0041fe0c: fcsel    s0, s0, s3, gt
0041fe10: fcmp     s3, s2
0041fe14: fmov     s2, w8
0041fe18: fmul     s0, s0, s4
0041fe1c: fcsel    s0, s2, s0, mi
0041fe20: fsub     s0, s9, s0
0041fe24: fcmp     s1, s0
0041fe28: fcsel    s0, s0, s1, mi
0041fe2c: fcmp     s0, s13
0041fe30: fcsel    s9, s0, s13, mi
0041fe34: sub      x1, x29, #0xa0
0041fe38: mov      w0, #3
0041fe3c: bl       #0x3b5758
0041fe40: stp      xzr, xzr, [x29, #-0xa0]
0041fe44: sub      x1, x29, #0xa0
0041fe48: mov      w0, #0x15
0041fe4c: bl       #0x3b5758
0041fe50: stp      xzr, xzr, [x29, #-0xa0]
0041fe54: sub      x1, x29, #0xa0
0041fe58: mov      w0, #0x17
0041fe5c: bl       #0x3b5758
0041fe60: bl       #0x3bb6a0
0041fe64: ldr      d0, [x0, #0x38]
0041fe68: str      q0, [sp, #0x50]
0041fe6c: bl       #0x3bb6a0
0041fe70: ldr      q3, [sp, #0x50]
0041fe74: add      x8, x0, #0x38
0041fe78: ld1      {v3.s}[1], [x8]
0041fe7c: mov      w8, #0xd70a
0041fe80: movk     w8, #0x3c23, lsl #16
0041fe84: dup      v1.2s, w8
0041fe88: adrp     x8, #0x1f000
0041fe8c: fcmgt    v0.2s, v3.2s, v10.2s
0041fe90: ldr      d2, [x8, #0x9a8]
0041fe94: adrp     x8, #0x1f000
0041fe98: fcmgt    v1.2s, v1.2s, v3.2s
0041fe9c: bsl      v0.8b, v10.8b, v3.8b
0041fea0: fmul     v0.2s, v0.2s, v2.2s
0041fea4: ldr      d2, [x8, #0xb80]
0041fea8: bit      v0.8b, v2.8b, v1.8b
0041feac: stur     d0, [x29, #-0xa0]
0041feb0: sub      x1, x29, #0xa0
0041feb4: mov      w0, #2
0041feb8: bl       #0x3b5c4c
0041febc: stp      s9, s8, [x29, #-0xa0]
0041fec0: adrp     x0, #0x28000
0041fec4: add      x0, x0, #0xff2
0041fec8: sub      x1, x29, #0xa0
0041fecc: mov      w2, wzr
0041fed0: mov      w3, #0x118
0041fed4: bl       #0x3c6b78
0041fed8: mov      w0, #1
0041fedc: bl       #0x3b5db0
0041fee0: bl       #0x3cc48c
0041fee4: fmov     s8, s0
0041fee8: bl       #0x3bb6a0
0041feec: fmov     s0, #4.00000000
0041fef0: ldr      s1, [x0, #0x38]
0041fef4: fmov     s2, #5.00000000
0041fef8: mov      w8, #0xd70a
0041fefc: movk     w8, #0x3c23, lsl #16
0041ff00: fcmp     s1, s0
0041ff04: fcsel    s0, s0, s1, gt
0041ff08: fmul     s0, s0, s2
0041ff0c: fmov     s2, w8
0041ff10: mov      w8, #0xcccc
0041ff14: movk     w8, #0x3d4c, lsl #16
0041ff18: fcmp     s1, s2
0041ff1c: fmov     s1, w8
0041ff20: fcsel    s0, s1, s0, mi
0041ff24: fadd     s0, s8, s0
0041ff28: bl       #0x3cc4e0
0041ff2c: adrp     x8, #0x59f000
0041ff30: ldr      w19, [x8, #0x1a4]
0041ff34: bl       #0x3c712c
0041ff38: fmov     s8, s0
0041ff3c: bl       #0x3bb6a0
0041ff40: fmov     s0, #4.00000000
0041ff44: ldr      s1, [x0, #0x38]
0041ff48: cmp      w19, #0
0041ff4c: cset     w2, ne
0041ff50: mov      w8, #0x42a20000
0041ff54: fmov     s2, w8
0041ff58: mov      w8, #0xd70a
0041ff5c: fcmp     s1, s0
0041ff60: movk     w8, #0x3c23, lsl #16
0041ff64: fcsel    s0, s0, s1, gt
0041ff68: fmul     s0, s0, s2
0041ff6c: fmov     s2, w8
0041ff70: mov      w8, #0x5c29
0041ff74: movk     w8, #0x3f4f, lsl #16
0041ff78: fcmp     s1, s2
0041ff7c: fmov     s1, w8
0041ff80: fcsel    s0, s1, s0, mi
0041ff84: stp      s8, s0, [x29, #-0xa0]
0041ff88: adrp     x0, #0x23000
0041ff8c: add      x0, x0, #0xba9
0041ff90: sub      x1, x29, #0xa0
0041ff94: bl       #0x428e44
0041ff98: tbz      w0, #0, #0x41ffe4
0041ff9c: adrp     x8, #0x59f000
0041ffa0: adrp     x9, #0x2a000
0041ffa4: add      x9, x9, #0xf5f
0041ffa8: str      wzr, [x8, #0x1a4]
0041ffac: mov      w8, #0x24
0041ffb0: ldr      q0, [x9]
0041ffb4: mov      w10, #0xb5a1
0041ffb8: sturb    w8, [x29, #-0xa0]
0041ffbc: sub      x8, x29, #0x100
0041ffc0: sturh    w10, [x8, #0x71]
0041ffc4: stur     q0, [x8, #0x61]
0041ffc8: sturb    wzr, [x29, #-0x8d]
0041ffcc: sub      x0, x29, #0xa0
0041ffd0: bl       #0x43e330
0041ffd4: ldurb    w8, [x29, #-0xa0]
0041ffd8: tbz      w8, #0, #0x41ffe4
0041ffdc: ldur     x0, [x29, #-0x90]
0041ffe0: bl       #0x54e070
0041ffe4: cmp      w27, #1
0041ffe8: b.lt     #0x420114
0041ffec: mov      x8, xzr
0041fff0: fmov     s9, #4.00000000
0041fff4: sub      x9, x29, #0xc0
0041fff8: sub      x24, x8, w27, uxtw
0041fffc: mov      w22, #0xd70a
00420000: mov      w25, #0x5c29
00420004: add      x20, sp, #0x80
00420008: mov      w28, #1
0042000c: orr      x23, x9, #1
00420010: mov      w26, #0x42a20000
00420014: movk     w22, #0x3c23, lsl #16
00420018: movk     w25, #0x3f4f, lsl #16
0042001c: b        #0x420034
00420020: add      x28, x28, #1
00420024: add      x20, x20, #0x10
00420028: add      x8, x24, x28
0042002c: cmp      x8, #1
00420030: b.eq     #0x420114
00420034: bl       #0x3e4960
00420038: adrp     x8, #0x59f000
0042003c: ldr      x19, [x20]
00420040: ldr      w21, [x8, #0x1a4]
00420044: bl       #0x3c712c
00420048: fmov     s8, s0
0042004c: bl       #0x3bb6a0
00420050: ldr      s0, [x0, #0x38]
00420054: cmp      x28, x21
00420058: fmov     s2, w26
0042005c: cset     w2, ne
00420060: fcmp     s0, s9
00420064: fcsel    s1, s9, s0, gt
00420068: fmul     s1, s1, s2
0042006c: fmov     s2, w22
00420070: fcmp     s0, s2
00420074: fmov     s0, w25
00420078: fcsel    s0, s0, s1, mi
0042007c: stp      s8, s0, [x29, #-0xa0]
00420080: sub      x1, x29, #0xa0
00420084: mov      x0, x19
00420088: bl       #0x428e44
0042008c: tbz      w0, #0, #0x420020
00420090: adrp     x8, #0x59f000
00420094: mov      w9, #0xe5a2
00420098: sturb    wzr, [x29, #-0xb3]
0042009c: str      w28, [x8, #0x1a4]
004200a0: mov      w8, #0x18
004200a4: movk     w9, #0xb088, lsl #16
004200a8: sturb    w8, [x29, #-0xc0]
004200ac: adrp     x8, #0x20000
004200b0: add      x8, x8, #0xd63
004200b4: ldr      x8, [x8]
004200b8: str      w9, [x23, #8]
004200bc: str      x8, [x23]
004200c0: sub      x0, x29, #0xc0
004200c4: mov      x1, x19
004200c8: bl       #0x50c46c
004200cc: ldr      x8, [x0, #0x10]
004200d0: ldr      q0, [x0]
004200d4: stur     x8, [x29, #-0x90]
004200d8: sub      x8, x29, #0x100
004200dc: str      q0, [x8, #0x60]
004200e0: stp      xzr, xzr, [x0, #8]
004200e4: str      xzr, [x0]
004200e8: sub      x0, x29, #0xa0
004200ec: bl       #0x43e330
004200f0: ldurb    w8, [x29, #-0xa0]
004200f4: tbz      w8, #0, #0x420100
004200f8: ldur     x0, [x29, #-0x90]
004200fc: bl       #0x54e070
00420100: ldurb    w8, [x29, #-0xc0]
00420104: tbz      w8, #0, #0x420020
00420108: ldur     x0, [x29, #-0xb0]
0042010c: bl       #0x54e070
00420110: b        #0x420020
00420114: bl       #0x3e4960
00420118: bl       #0x3c72cc
0042011c: mov      w0, #3
00420120: bl       #0x3b58b4
00420124: movi     d0, #0000000000000000
00420128: fmov     s1, #-1.00000000
0042012c: bl       #0x3cc3a0
00420130: adrp     x1, #0x35000
00420134: add      x1, x1, #0x258
00420138: mov      w0, #3
0042013c: bl       #0x3b5758
00420140: bl       #0x3bb6a0
00420144: ldr      d0, [x0, #0x38]
00420148: str      q0, [sp, #0x50]
0042014c: bl       #0x3bb6a0
00420150: ldr      q3, [sp, #0x50]
00420154: add      x8, x0, #0x38
00420158: ld1      {v3.s}[1], [x8]
0042015c: mov      w8, #0xd70a
00420160: movk     w8, #0x3c23, lsl #16
00420164: dup      v1.2s, w8
00420168: adrp     x8, #0x1f000
0042016c: fcmgt    v0.2s, v3.2s, v10.2s
00420170: ldr      d2, [x8, #0xae0]
00420174: adrp     x8, #0x1f000
00420178: fcmgt    v1.2s, v1.2s, v3.2s
0042017c: bsl      v0.8b, v10.8b, v3.8b
00420180: fmul     v0.2s, v0.2s, v2.2s
00420184: ldr      d2, [x8, #0xb00]
00420188: bit      v0.8b, v2.8b, v1.8b
0042018c: stur     d0, [x29, #-0xa0]
00420190: sub      x1, x29, #0xa0
00420194: mov      w0, #2
00420198: bl       #0x3b5c4c
0042019c: stur     xzr, [x29, #-0xa0]
004201a0: adrp     x0, #0x22000
004201a4: add      x0, x0, #0x971
004201a8: sub      x1, x29, #0xa0
004201ac: mov      w2, wzr
004201b0: mov      w3, #0x118
004201b4: bl       #0x3c6b78
004201b8: mov      w0, #1
004201bc: bl       #0x3b5db0
004201c0: mov      w0, #1
004201c4: bl       #0x3b58b4
004201c8: bl       #0x3c712c
004201cc: bl       #0x3bb6a0
004201d0: ldr      s9, [x0, #0x38]
004201d4: bl       #0x3b559c
004201d8: ldr      s8, [x0, #0x54]
004201dc: bl       #0x3bb6a0
004201e0: fmov     s0, #4.00000000
004201e4: mov      w8, #0x42f00000
004201e8: ldr      s3, [x0, #0x38]
004201ec: fmov     s2, w8
004201f0: mov      w8, #0xd70a
004201f4: movk     w8, #0x3c23, lsl #16
004201f8: fcmp     s9, s0
004201fc: fcsel    s1, s0, s9, gt
00420200: fmul     s1, s1, s2
00420204: fmov     s2, w8
00420208: mov      w8, #0x9999
0042020c: movk     w8, #0x3f99, lsl #16
00420210: fmov     s4, w8
00420214: mov      w8, #0x51eb
00420218: fcmp     s9, s2
0042021c: movk     w8, #0x3e38, lsl #16
00420220: fcsel    s14, s4, s1, mi
00420224: fcmp     s3, s0
00420228: fmov     s1, #18.00000000
0042022c: fcsel    s0, s0, s3, gt
00420230: fcmp     s3, s2
00420234: fmul     s0, s0, s1
00420238: fmov     s1, w8
0042023c: fcsel    s10, s1, s0, mi
00420240: bl       #0x3c712c
00420244: fmov     s9, s1
00420248: bl       #0x3b559c
0042024c: ldr      s13, [x0, #0x54]
00420250: bl       #0x3bb6a0
00420254: fmov     s0, #4.00000000
00420258: ldr      s1, [x0, #0x38]
0042025c: mov      w8, #0x42a00000
00420260: fmov     s3, w8
00420264: fmov     s2, #2.00000000
00420268: mov      w8, #0xd70a
0042026c: movk     w8, #0x3c23, lsl #16
00420270: fmov     s4, #1.00000000
00420274: str      s13, [sp, #0x50]
00420278: fcmp     s1, s0
0042027c: stur     wzr, [x29, #-0xa0]
00420280: fmadd    s2, s14, s2, s8
00420284: fmaxnm   s14, s9, s4
00420288: fcsel    s0, s0, s1, gt
0042028c: fadd     s8, s2, s10
00420290: fmul     s0, s0, s3
00420294: fmov     s3, w8
00420298: mov      w8, #0xcccc
0042029c: movk     w8, #0x3f4c, lsl #16
004202a0: fcmp     s1, s3
004202a4: fmov     s1, w8
004202a8: fcsel    s0, s1, s0, mi
004202ac: fsub     s1, s14, s8
004202b0: fadd     s0, s8, s0
004202b4: fsub     s1, s1, s13
004202b8: fadd     s15, s13, s0
004202bc: fmov     s0, #1.00000000
004202c0: fmaxnm   s0, s1, s0
004202c4: fcmp     s14, s15
004202c8: fcsel    s0, s14, s0, mi
004202cc: stur     s0, [x29, #-0x9c]
004202d0: adrp     x0, #0x24000
004202d4: add      x0, x0, #0xa
004202d8: sub      x1, x29, #0xa0
004202dc: mov      w2, #2
004202e0: mov      w3, #0x100
004202e4: bl       #0x3c6b78
004202e8: tbz      w0, #0, #0x421344
004202ec: bl       #0x3cc468
004202f0: fmov     s9, s0
004202f4: bl       #0x3bb6a0
004202f8: fmov     s0, #4.00000000
004202fc: ldr      s1, [x0, #0x38]
00420300: fsub     s2, s11, s12
00420304: mov      w8, #0xd70a
00420308: fmov     s3, #28.00000000
0042030c: movk     w8, #0x3c23, lsl #16
00420310: fcmp     s1, s0
00420314: fmsub    s10, s2, s2, s11
00420318: fmov     s2, w8
0042031c: mov      w8, #0x5c29
00420320: movk     w8, #0x3e8f, lsl #16
00420324: fcsel    s0, s0, s1, gt
00420328: fcmp     s1, s2
0042032c: fmov     s1, #1.00000000
00420330: fmov     s2, w8
00420334: fmul     s0, s0, s3
00420338: fsub     s1, s1, s10
0042033c: fcsel    s0, s2, s0, mi
00420340: fmadd    s0, s1, s0, s9
00420344: bl       #0x3cc4b0
00420348: bl       #0x3b559c
0042034c: mov      w8, #0xc28f
00420350: ldr      s1, [x0]
00420354: movk     w8, #0x3d75, lsl #16
00420358: fmov     s0, w8
0042035c: fmaxnm   s0, s10, s0
00420360: fmul     s0, s0, s1
00420364: mov      w0, wzr
00420368: bl       #0x3b598c
0042036c: adrp     x8, #0x59f000
00420370: ldr      w8, [x8, #0x1a4]
00420374: cmp      w8, #1
00420378: b.lt     #0x42042c
0042037c: cmp      w8, w27
00420380: b.gt     #0x42042c
00420384: add      x9, sp, #0x80
00420388: add      x8, x9, x8, lsl #4
0042038c: ldur     x0, [x8, #-0x10]
00420390: mov      w8, #0x42700000
00420394: adrp     x1, #0x2bd000
00420398: add      x1, x1, #0xf44
0042039c: fmov     s0, w8
004203a0: adrp     x2, #0x2bd000
004203a4: add      x2, x2, #0xf54
004203a8: mov      w3, #1
004203ac: bl       #0x43e904
004203b0: bl       #0x3e4640
004203b4: bl       #0x3bb6a0
004203b8: fmov     s0, #4.00000000
004203bc: ldr      s1, [x0, #0x38]
004203c0: fmov     s2, #3.00000000
004203c4: mov      w8, #0xd70a
004203c8: stur     wzr, [x29, #-0xa0]
004203cc: movk     w8, #0x3c23, lsl #16
004203d0: fcmp     s1, s0
004203d4: fcsel    s0, s0, s1, gt
004203d8: fmul     s0, s0, s2
004203dc: fmov     s2, w8
004203e0: mov      w8, #0xc28f
004203e4: movk     w8, #0x3cf5, lsl #16
004203e8: fcmp     s1, s2
004203ec: fmov     s1, w8
004203f0: fcsel    s0, s1, s0, mi
004203f4: stur     s0, [x29, #-0x9c]
004203f8: sub      x0, x29, #0xa0
004203fc: bl       #0x3e46b0
00420400: adrp     x8, #0x59f000
00420404: add      x9, sp, #0x80
00420408: ldrsw    x8, [x8, #0x1a4]
0042040c: add      x8, x9, x8, lsl #4
00420410: ldur     x8, [x8, #-8]
00420414: ldr      x0, [x8, #0x30]
00420418: cbz      x0, #0x4214f4
0042041c: ldr      x8, [x0]
00420420: ldr      x8, [x8, #0x30]
00420424: blr      x8
00420428: b        #0x421318
0042042c: mov      w8, #0x42700000
00420430: adrp     x0, #0x24000
00420434: add      x0, x0, #0x638 ; 'lvlolm内核'
00420438: fmov     s0, w8
0042043c: adrp     x1, #0x2bd000
00420440: add      x1, x1, #0xf44
00420444: adrp     x2, #0x2bd000
00420448: add      x2, x2, #0xf54
0042044c: mov      w3, #1
00420450: bl       #0x43e904
00420454: bl       #0x3e4640
00420458: bl       #0x3bb6a0
0042045c: fmov     s0, #4.00000000
00420460: ldr      s1, [x0, #0x38]
00420464: fmov     s2, #3.00000000
00420468: mov      w8, #0xd70a
0042046c: stur     wzr, [x29, #-0xa0]
00420470: movk     w8, #0x3c23, lsl #16
00420474: fcmp     s1, s0
00420478: fcsel    s0, s0, s1, gt
0042047c: fmul     s0, s0, s2
00420480: fmov     s2, w8
00420484: mov      w8, #0xc28f
00420488: movk     w8, #0x3cf5, lsl #16
0042048c: fcmp     s1, s2
00420490: fmov     s1, w8
00420494: fcsel    s0, s1, s0, mi
00420498: stur     s0, [x29, #-0x9c]
0042049c: sub      x0, x29, #0xa0
004204a0: bl       #0x3e46b0
004204a4: movi     v0.2d, #0000000000000000
004204a8: mov      w8, #1
004204ac: adrp     x27, #0x593000
004204b0: add      x27, x27, #0x564
004204b4: str      w8, [x27, #4]
004204b8: strh     w8, [x27]
004204bc: stur     q0, [x27, #8]
004204c0: stur     q0, [x27, #0x18]
004204c4: stur     q0, [x27, #0x24]
004204c8: adrp     x0, #0x26000
004204cc: add      x0, x0, #0x493
004204d0: bl       #0x3ca8b0
004204d4: bl       #0x3cc42c
004204d8: fmov     s9, s1
004204dc: adrp     x8, #0x593000
004204e0: add      x8, x8, #0x574
004204e4: stp      s0, s1, [x8]
004204e8: bl       #0x3c712c
004204ec: fmov     s10, s0
004204f0: adrp     x8, #0x593000
004204f4: str      s0, [x8, #0x57c]
004204f8: bl       #0x3bb6a0
004204fc: fmov     s0, #4.00000000
00420500: ldr      s1, [x0, #0x38]
00420504: mov      w8, #0x443e0000
00420508: fmov     s2, w8
0042050c: mov      w8, #0xd70a
00420510: adrp     x9, #0x593000
00420514: movk     w8, #0x3c23, lsl #16
00420518: fcmp     s1, s0
0042051c: fcsel    s0, s0, s1, gt
00420520: fmul     s0, s0, s2
00420524: fmov     s2, w8
00420528: mov      w8, #0x3333
0042052c: movk     w8, #0x40f3, lsl #16
00420530: fcmp     s1, s2
00420534: fmov     s1, w8
00420538: mov      w8, #2
0042053c: fcsel    s0, s1, s0, mi
00420540: fcmp     s10, s0
00420544: movi     d0, #0000000000000000
00420548: csinc    w8, w8, wzr, ge
0042054c: str      w8, [x9, #0x568]
00420550: b.lt     #0x42055c
00420554: bl       #0x3b559c
00420558: ldr      s0, [x0, #0x50]
0042055c: adrp     x8, #0x593000
00420560: str      s0, [x8, #0x584]
00420564: bl       #0x3bb6a0
00420568: adrp     x26, #0x593000
0042056c: add      x26, x26, #0x568
00420570: fmov     s2, #4.00000000
00420574: ldr      s0, [x26, #0x14]
00420578: ldr      s1, [x26, #0x1c]
0042057c: ldr      s3, [x26]
00420580: ldr      s4, [x0, #0x38]
00420584: mov      w8, #0xd70a
00420588: stp      s9, s9, [x26, #0x28]
0042058c: fsub     s1, s0, s1
00420590: scvtf    s3, s3
00420594: movk     w8, #0x3c23, lsl #16
00420598: fcmp     s4, s2
0042059c: fdiv     s1, s1, s3
004205a0: fcsel    s3, s2, s4, gt
004205a4: fmul     s2, s3, s2
004205a8: fmov     s3, w8
004205ac: mov      w8, #0xd70a
004205b0: movk     w8, #0x3d23, lsl #16
004205b4: fcmp     s4, s3
004205b8: fmov     s3, w8
004205bc: adrp     x8, #0x593000
004205c0: ldr      x8, [x8, #0xbb0]
004205c4: fcsel    s2, s3, s2, mi
004205c8: str      s1, [x26, #0x18]
004205cc: str      s2, [x26, #0x20]
004205d0: cbz      x8, #0x4205e4
004205d4: ldrb     w8, [x8, #0x38]
004205d8: cmp      w8, #0
004205dc: cset     w28, ne
004205e0: b        #0x4205e8
004205e4: mov      w28, wzr
004205e8: fmov     s2, s9
004205ec: adrp     x8, #0x593000
004205f0: mov      x25, x8
004205f4: ldrb     w8, [x8, #0x565]
004205f8: cbz      w8, #0x420690
004205fc: bl       #0x3bb6a0
00420600: fmov     s0, #4.00000000
00420604: ldr      s1, [x0, #0x38]
00420608: fmov     s2, #3.00000000
0042060c: mov      w8, #0xd70a
00420610: stur     wzr, [x29, #-0xa0]
00420614: movk     w8, #0x3c23, lsl #16
00420618: fcmp     s1, s0
0042061c: fcsel    s0, s0, s1, gt
00420620: fmul     s0, s0, s2
00420624: fmov     s2, w8
00420628: mov      w8, #0xc28f
0042062c: movk     w8, #0x3cf5, lsl #16
00420630: fcmp     s1, s2
00420634: fmov     s1, w8
00420638: fcsel    s0, s1, s0, mi
0042063c: stur     s0, [x29, #-0x9c]
00420640: sub      x0, x29, #0xa0
00420644: bl       #0x3e46b0
00420648: bl       #0x3c9d48
0042064c: fmov     s9, s1
00420650: bl       #0x3c9d5c
00420654: fmov     s10, s1
00420658: bl       #0x3c72cc
0042065c: fadd     s0, s9, s10
00420660: adrp     x8, #0x593000
00420664: add      x8, x8, #0x565
00420668: ldur     s1, [x8, #0x23]
0042066c: ldursw   x9, [x8, #0xb]
00420670: add      x10, x8, #0x2b
00420674: strb     wzr, [x8]
00420678: fadd     s0, s0, s1
0042067c: str      s0, [x10, x9, lsl #2]
00420680: ldur     s2, [x8, #0x2b]
00420684: ldur     s9, [x8, #0x2f]
00420688: ldur     s1, [x8, #0x1b]
0042068c: ldur     s0, [x8, #0x17]
00420690: fcmp     s2, s9
00420694: adrp     x19, #0x593000
00420698: add      x19, x19, #0x56c
0042069c: str      wzr, [x19]
004206a0: str      s1, [x19, #0x20]
004206a4: fcsel    s2, s9, s2, mi
004206a8: str      s0, [x19, #0x14]
004206ac: stp      s2, s2, [x19, #0x24]
004206b0: adrp     x0, #0x25000
004206b4: add      x0, x0, #0x9fb
004206b8: bl       #0x43ef48
004206bc: cbz      w28, #0x4206e8
004206c0: mov      w0, #1
004206c4: bl       #0x3c9884
004206c8: bl       #0x43ebe0
004206cc: bl       #0x3c9990
004206d0: adrp     x0, #0x35000
004206d4: add      x0, x0, #0x248
004206d8: adrp     x1, #0x27000
004206dc: add      x1, x1, #0xce7 ; '运行中不可切换驱动，停止后可更换。'
004206e0: bl       #0x3e1af4
004206e4: b        #0x420728
004206e8: bl       #0x43ebe0
004206ec: adrp     x8, #0x59f000
004206f0: ldr      w8, [x8, #0x1e8]
004206f4: cmp      w8, #6
004206f8: b.hi     #0x42070c
004206fc: adrp     x9, #0x557000
00420700: add      x9, x9, #0xd88
00420704: ldr      x2, [x9, x8, lsl #3]
00420708: b        #0x420714
0042070c: adrp     x2, #0x29000
00420710: add      x2, x2, #0x1f
00420714: adrp     x0, #0x35000
00420718: add      x0, x0, #0x248
0042071c: adrp     x1, #0x23000
00420720: add      x1, x1, #0xbb0
00420724: bl       #0x3e1af4
00420728: ldrb     w8, [x25, #0x565]
0042072c: cbz      w8, #0x4207ac
00420730: bl       #0x3bb6a0
00420734: fmov     s0, #4.00000000
00420738: ldr      s1, [x0, #0x38]
0042073c: fmov     s2, #3.00000000
00420740: mov      w8, #0xd70a
00420744: stur     wzr, [x29, #-0xa0]
00420748: movk     w8, #0x3c23, lsl #16
0042074c: fcmp     s1, s0
00420750: fcsel    s0, s0, s1, gt
00420754: fmul     s0, s0, s2
00420758: fmov     s2, w8
0042075c: mov      w8, #0xc28f
00420760: movk     w8, #0x3cf5, lsl #16
00420764: fcmp     s1, s2
00420768: fmov     s1, w8
0042076c: fcsel    s0, s1, s0, mi
00420770: stur     s0, [x29, #-0x9c]
00420774: sub      x0, x29, #0xa0
00420778: bl       #0x3e46b0
0042077c: bl       #0x3c9d48
00420780: fmov     s9, s1
00420784: bl       #0x3c9d5c
00420788: fmov     s10, s1
0042078c: bl       #0x3c72cc
00420790: fadd     s0, s9, s10
00420794: ldr      s1, [x27, #0x24]
00420798: ldrsw    x8, [x27, #0xc]
0042079c: strb     wzr, [x27, #1]
004207a0: add      x8, x27, x8, lsl #2
004207a4: fadd     s0, s0, s1
004207a8: str      s0, [x8, #0x2c]
004207ac: ldp      s1, s0, [x19, #0x24]
004207b0: ldr      s2, [x19, #0x20]
004207b4: str      wzr, [x19]
004207b8: str      s2, [x19, #0x14]
004207bc: fcmp     s1, s0
004207c0: fcsel    s0, s0, s1, mi
004207c4: stp      s0, s0, [x19, #0x24]
004207c8: adrp     x0, #0x24000
004207cc: add      x0, x0, #0xf50
004207d0: bl       #0x43ef48
004207d4: bl       #0x3c712c
004207d8: fmov     s9, s0
004207dc: bl       #0x3bb6a0
004207e0: fmov     s0, #4.00000000
004207e4: ldr      s1, [x0, #0x38]
004207e8: mov      w8, #0x43d20000
004207ec: fmov     s2, w8
004207f0: mov      w8, #0xd70a
004207f4: movk     w8, #0x3c23, lsl #16
004207f8: fcmp     s1, s0
004207fc: fcsel    s0, s0, s1, gt
00420800: fmul     s0, s0, s2
00420804: fmov     s2, w8
00420808: mov      w8, #0x6666
0042080c: movk     w8, #0x4086, lsl #16
00420810: fcmp     s1, s2
00420814: fmov     s1, w8
00420818: fcsel    s0, s1, s0, mi
0042081c: fcmp     s9, s0
00420820: b.ge     #0x420874
00420824: bl       #0x3bb6a0
00420828: fmov     s0, #4.00000000
0042082c: ldr      s1, [x0, #0x38]
00420830: mov      w8, #0x438c0000
00420834: fmov     s2, w8
00420838: mov      w8, #0xd70a
0042083c: movk     w8, #0x3c23, lsl #16
00420840: fcmp     s1, s0
00420844: fcsel    s0, s0, s1, gt
00420848: fmul     s0, s0, s2
0042084c: fmov     s2, w8
00420850: mov      w8, #0x3333
00420854: movk     w8, #0x4033, lsl #16
00420858: fcmp     s1, s2
0042085c: fmov     s1, w8
00420860: mov      w8, #2
00420864: fcsel    s0, s1, s0, mi
00420868: fcmp     s9, s0
0042086c: csinc    w1, w8, wzr, ge
00420870: b        #0x420878
00420874: mov      w1, #3
00420878: stur     xzr, [x29, #-0xa0]
0042087c: movi     d0, #0000000000000000
00420880: adrp     x0, #0x28000
00420884: add      x0, x0, #0x2b1
00420888: sub      x3, x29, #0xa0
0042088c: mov      w2, #0x8010
00420890: bl       #0x3db058
00420894: tbz      w0, #0, #0x4209cc
00420898: adrp     x8, #0x27000
0042089c: add      x8, x8, #0x87e
004208a0: adrp     x9, #0x25000
004208a4: add      x9, x9, #0xf24
004208a8: cmp      w28, #0
004208ac: csel     x19, x9, x8, ne
004208b0: adrp     x8, #0x35000
004208b4: add      x8, x8, #0x248
004208b8: adrp     x9, #0x2bd000
004208bc: add      x9, x9, #0xf64
004208c0: csel     x20, x9, x8, ne
004208c4: bl       #0x3dfdf4
004208c8: adrp     x0, #0x35000
004208cc: add      x0, x0, #0x248
004208d0: adrp     x1, #0x25000
004208d4: add      x1, x1, #0xdc7
004208d8: adrp     x2, #0x27000
004208dc: add      x2, x2, #0x877
004208e0: bl       #0x3e1af4
004208e4: adrp     x1, #0x25000
004208e8: add      x1, x1, #0xdc7
004208ec: mov      x0, x20
004208f0: mov      x2, x19
004208f4: bl       #0x3e1af4
004208f8: movi     v0.2d, #0000000000000000
004208fc: sub      x8, x29, #0x100
00420900: stp      q0, q0, [x8, #0x60]
00420904: bl       #0x3bb6a0
00420908: ldr      s0, [x0, #0xb8]
0042090c: fcvt     d0, s0
00420910: adrp     x3, #0x2a000
00420914: add      x3, x3, #0x361
00420918: sub      x0, x29, #0xa0
0042091c: mov      w1, #0x20
00420920: mov      w2, #0x20
00420924: bl       #0x41dd88
00420928: bl       #0x3dfdf4
0042092c: adrp     x19, #0x35000
00420930: add      x19, x19, #0x248
00420934: adrp     x1, #0x25000
00420938: add      x1, x1, #0xdc7
0042093c: adrp     x2, #0x29000
00420940: add      x2, x2, #0x7ea
00420944: mov      x0, x19
00420948: bl       #0x3e1af4
0042094c: adrp     x0, #0x2bd000
00420950: add      x0, x0, #0xf74
00420954: adrp     x1, #0x25000
00420958: add      x1, x1, #0xdc7
0042095c: sub      x2, x29, #0xa0
00420960: bl       #0x3e1af4
00420964: adrp     x8, #0x563000
00420968: adrp     x9, #0x21000
0042096c: add      x9, x9, #0x1fa
00420970: ldr      x8, [x8, #0x150]
00420974: adrp     x10, #0x28000
00420978: add      x10, x10, #0xb9e
0042097c: ldr      x8, [x8]
00420980: cmp      x8, #0
00420984: adrp     x8, #0x34000
00420988: add      x8, x8, #0x634
0042098c: csel     x20, x10, x9, eq
00420990: csel     x19, x19, x8, eq
00420994: bl       #0x3dfdf4
00420998: adrp     x0, #0x35000
0042099c: add      x0, x0, #0x248
004209a0: adrp     x1, #0x25000
004209a4: add      x1, x1, #0xdc7
004209a8: adrp     x2, #0x29000
004209ac: add      x2, x2, #0xe87
004209b0: bl       #0x3e1af4
004209b4: adrp     x1, #0x25000
004209b8: add      x1, x1, #0xdc7
004209bc: mov      x0, x19
004209c0: mov      x2, x20
004209c4: bl       #0x3e1af4
004209c8: bl       #0x3ddfe4
004209cc: strb     w28, [sp, #0x7c]
004209d0: mov      w8, #0x42280000
004209d4: fmov     s1, #-1.00000000
004209d8: adrp     x0, #0x20000
004209dc: add      x0, x0, #0xd70
004209e0: fmov     s0, w8
004209e4: add      x1, sp, #0x7c
004209e8: bl       #0x429268
004209ec: tbz      w0, #0, #0x4209f8
004209f0: ldrb     w0, [sp, #0x7c]
004209f4: bl       #0x43f5b0
004209f8: adrp     x19, #0x563000
004209fc: ldr      x19, [x19, #0x158]
00420a00: ldrb     w8, [x19]
00420a04: strb     w8, [sp, #0x78]
00420a08: mov      w8, #0x42280000
00420a0c: fmov     s1, #-1.00000000
00420a10: adrp     x0, #0x22000
00420a14: add      x0, x0, #0x980
00420a18: fmov     s0, w8
00420a1c: add      x1, sp, #0x78
00420a20: bl       #0x429268
00420a24: tbz      w0, #0, #0x420a40
00420a28: adrp     x9, #0x563000
00420a2c: ldrb     w8, [sp, #0x78]
00420a30: mov      w10, #1
00420a34: ldr      x9, [x9, #0x160]
00420a38: strb     w8, [x19]
00420a3c: strb     w10, [x9]
00420a40: bl       #0x3bb6a0
00420a44: fmov     s0, #4.00000000
00420a48: ldr      s1, [x0, #0x38]
00420a4c: mov      w8, #0xd70a
00420a50: movk     w8, #0x3c23, lsl #16
00420a54: stur     wzr, [x29, #-0xa0]
00420a58: fmov     s2, w8
00420a5c: mov      w8, #0xd70a
00420a60: fcmp     s1, s0
00420a64: movk     w8, #0x3ca3, lsl #16
00420a68: fcsel    s0, s0, s1, gt
00420a6c: fcmp     s1, s2
00420a70: fmov     s1, w8
00420a74: fadd     s0, s0, s0
00420a78: fcsel    s0, s1, s0, mi
00420a7c: stur     s0, [x29, #-0x9c]
00420a80: sub      x0, x29, #0xa0
00420a84: bl       #0x3e46b0
00420a88: adrp     x24, #0x563000
00420a8c: mov      w8, #2
00420a90: ldr      x24, [x24, #0x168]
00420a94: ldr      w21, [x24]
00420a98: cmp      w21, #2
00420a9c: csel     w19, w21, w8, lt
00420aa0: adrp     x0, #0x35000
00420aa4: add      x0, x0, #0x248
00420aa8: adrp     x1, #0x25000
00420aac: add      x1, x1, #0xdc7
00420ab0: adrp     x2, #0x28000
00420ab4: add      x2, x2, #0x2c0
00420ab8: bl       #0x3e1af4
00420abc: adrp     x0, #0x28000
00420ac0: add      x0, x0, #0x2c0
00420ac4: bl       #0x3ca8b0
00420ac8: fmov     s0, #-1.00000000
00420acc: bl       #0x3b523c
00420ad0: bic      w22, w19, w19, asr #31
00420ad4: adrp     x8, #0x557000
00420ad8: add      x8, x8, #0x9c8
00420adc: ldr      x1, [x8, w22, uxtw #3]
00420ae0: adrp     x0, #0x27000
00420ae4: add      x0, x0, #0x896
00420ae8: mov      w2, wzr
00420aec: bl       #0x3e4f84
00420af0: tbz      w0, #0, #0x420bcc
00420af4: cmp      w21, #1
00420af8: stur     xzr, [x29, #-0xa0]
00420afc: cset     w1, lt
00420b00: adrp     x0, #0x27000
00420b04: add      x0, x0, #0xfea
00420b08: sub      x3, x29, #0xa0
00420b0c: mov      w2, wzr
00420b10: bl       #0x3e5620
00420b14: tst      w0, #1
00420b18: mov      w19, w0
00420b1c: csel     w23, wzr, w22, ne
00420b20: cmp      w21, #0
00420b24: b.gt     #0x420b2c
00420b28: bl       #0x3ca2cc
00420b2c: cmp      w21, #1
00420b30: stur     xzr, [x29, #-0xa0]
00420b34: cset     w1, eq
00420b38: adrp     x0, #0x21000
00420b3c: add      x0, x0, #0xa59
00420b40: sub      x3, x29, #0xa0
00420b44: mov      w2, wzr
00420b48: bl       #0x3e5620
00420b4c: tst      w0, #1
00420b50: mov      w20, w0
00420b54: csinc    w23, w23, wzr, eq
00420b58: cmp      w21, #1
00420b5c: b.ne     #0x420b64
00420b60: bl       #0x3ca2cc
00420b64: cmp      w22, #1
00420b68: stur     xzr, [x29, #-0xa0]
00420b6c: cset     w1, hi
00420b70: adrp     x0, #0x2a000
00420b74: add      x0, x0, #0x79e
00420b78: sub      x3, x29, #0xa0
00420b7c: mov      w2, wzr
00420b80: bl       #0x3e5620
00420b84: tst      w0, #1
00420b88: mov      w8, #2
00420b8c: mov      w21, w0
00420b90: csel     w23, w8, w23, ne
00420b94: cmp      w22, #2
00420b98: b.lo     #0x420ba0
00420b9c: bl       #0x3ca2cc
00420ba0: bl       #0x3e55ec
00420ba4: bl       #0x3cad20
00420ba8: orr      w8, w19, w20
00420bac: orr      w8, w8, w21
00420bb0: tbz      w8, #0, #0x420bd0
00420bb4: adrp     x8, #0x563000
00420bb8: mov      w9, #1
00420bbc: ldr      x8, [x8, #0x170]
00420bc0: str      w23, [x24]
00420bc4: strb     w9, [x8]
00420bc8: b        #0x420bd0
00420bcc: bl       #0x3cad20
00420bd0: movi     v0.2d, #0000000000000000
00420bd4: adrp     x8, #0x562000
00420bd8: sub      x9, x29, #0x100
00420bdc: ldr      x8, [x8, #0xee0]
00420be0: ldr      w4, [x8]
00420be4: stp      q0, q0, [x9, #0x60]
00420be8: stp      q0, q0, [x9, #0x80]
00420bec: adrp     x3, #0x20000
00420bf0: add      x3, x3, #0xd7a
00420bf4: sub      x0, x29, #0xa0
00420bf8: mov      w1, #0x40
00420bfc: mov      w2, #0x40
00420c00: bl       #0x41dd88
00420c04: bl       #0x3cc42c
00420c08: fmov     s10, s0
00420c0c: fmov     s11, s1
00420c10: stp      s0, s1, [x29, #-0xc0]
00420c14: bl       #0x3c712c
00420c18: fmov     s12, s0
00420c1c: bl       #0x3cc760
00420c20: fmov     s9, s0
00420c24: fmov     s0, #-1.00000000
00420c28: sub      x0, x29, #0xa0
00420c2c: mov      x1, xzr
00420c30: mov      w2, wzr
00420c34: bl       #0x3b6774
00420c38: fmov     s1, #1.00000000
00420c3c: fmaxnm   s1, s12, s1
00420c40: fadd     s1, s10, s1
00420c44: fsub     s0, s1, s0
00420c48: fcmp     s10, s0
00420c4c: fcsel    s12, s0, s10, mi
00420c50: bl       #0x3bb6a0
00420c54: ldr      s13, [x0, #0x38]
00420c58: bl       #0x3c9e3c
00420c5c: fmov     s0, #4.00000000
00420c60: fmov     s1, #10.00000000
00420c64: mov      w8, #0xd70a
00420c68: movk     w8, #0x3c23, lsl #16
00420c6c: mov      x20, x0
00420c70: fcmp     s13, s0
00420c74: fcsel    s0, s0, s13, gt
00420c78: fmul     s0, s0, s1
00420c7c: fmov     s1, w8
00420c80: mov      w8, #0xcccc
00420c84: movk     w8, #0x3dcc, lsl #16
00420c88: fcmp     s13, s1
00420c8c: fmov     s1, w8
00420c90: fcsel    s0, s1, s0, mi
00420c94: fadd     s1, s11, s9
00420c98: fsub     s0, s12, s0
00420c9c: fcmp     s10, s0
00420ca0: fcsel    s0, s0, s10, mi
00420ca4: stp      s0, s1, [x29, #-0xe0]
00420ca8: sub      x1, x29, #0xc0
00420cac: sub      x2, x29, #0xe0
00420cb0: mov      w3, #1
00420cb4: bl       #0x3d20e0
00420cb8: adrp     x19, #0x35000
00420cbc: add      x19, x19, #0x248
00420cc0: mov      x0, x19
00420cc4: bl       #0x3b5664
00420cc8: mov      w2, w0
00420ccc: adrp     x3, #0x22000
00420cd0: add      x3, x3, #0xec6
00420cd4: sub      x1, x29, #0xc0
00420cd8: mov      x0, x20
00420cdc: mov      x4, xzr
00420ce0: bl       #0x3d55dc
00420ce4: mov      x0, x20
00420ce8: bl       #0x3d22f0
00420cec: ldur     s0, [x29, #-0xbc]
00420cf0: stp      s12, s0, [x29, #-0xe0]
00420cf4: adrp     x0, #0x34000
00420cf8: add      x0, x0, #0x624
00420cfc: bl       #0x3b5664
00420d00: mov      w2, w0
00420d04: sub      x1, x29, #0xe0
00420d08: sub      x3, x29, #0xa0
00420d0c: mov      x0, x20
00420d10: mov      x4, xzr
00420d14: bl       #0x3d55dc
00420d18: stur     wzr, [x29, #-0xe0]
00420d1c: stur     s9, [x29, #-0xdc]
00420d20: sub      x0, x29, #0xe0
00420d24: bl       #0x3e46b0
00420d28: adrp     x0, #0x22000
00420d2c: add      x0, x0, #0xec6
00420d30: bl       #0x3ca8b0
00420d34: fmov     s0, #-1.00000000
00420d38: bl       #0x3b523c
00420d3c: mov      w0, wzr
00420d40: bl       #0x3b5710
00420d44: ldr      x8, [x0]
00420d48: ldr      w9, [x0, #8]
00420d4c: stur     x8, [x29, #-0xc0]
00420d50: stp      w9, wzr, [x29, #-0xb8]
00420d54: sub      x1, x29, #0xc0
00420d58: mov      w0, wzr
00420d5c: bl       #0x3b5758
00420d60: adrp     x1, #0x562000
00420d64: adrp     x0, #0x27000
00420d68: add      x0, x0, #0x896
00420d6c: ldr      x1, [x1, #0xee0]
00420d70: adrp     x4, #0x20000
00420d74: add      x4, x4, #0xd7a
00420d78: mov      w2, #0x1e
00420d7c: mov      w3, #0x78
00420d80: mov      w5, wzr
00420d84: bl       #0x3ee3c0
00420d88: mov      w0, #1
00420d8c: bl       #0x3b58b4
00420d90: bl       #0x3cad20
00420d94: adrp     x8, #0x59f000
00420d98: add      x8, x8, #0x118
00420d9c: cmp      w28, #0
00420da0: ldrb     w9, [x8]
00420da4: ldr      x10, [x8, #0x10]
00420da8: adrp     x11, #0x2bd000
00420dac: add      x11, x11, #0xf64
00420db0: csel     x0, x11, x19, ne
00420db4: tst      w9, #1
00420db8: csinc    x2, x10, x8, ne
00420dbc: adrp     x1, #0x25000
00420dc0: add      x1, x1, #0xdc7
00420dc4: bl       #0x3e1af4
00420dc8: adrp     x0, #0x23000
00420dcc: add      x0, x0, #0xbc7
00420dd0: bl       #0x43ef48
00420dd4: adrp     x0, #0x35000
00420dd8: add      x0, x0, #0x248
00420ddc: adrp     x1, #0x26000
00420de0: add      x1, x1, #0xe23
00420de4: bl       #0x3e1af4
00420de8: adrp     x8, #0x59c000
00420dec: ldr      x2, [x8, #0x300]
00420df0: adrp     x0, #0x34000
00420df4: add      x0, x0, #0x624
00420df8: adrp     x1, #0x25000
00420dfc: add      x1, x1, #0xdc7
00420e00: bl       #0x3e1af4
00420e04: adrp     x0, #0x35000
00420e08: add      x0, x0, #0x248
00420e0c: adrp     x1, #0x26000
00420e10: add      x1, x1, #0xe2a
00420e14: bl       #0x3e1af4
00420e18: adrp     x8, #0x59c000
00420e1c: adrp     x9, #0x21000
00420e20: add      x9, x9, #0x204
00420e24: ldr      x8, [x8, #0x308]
00420e28: cmp      x8, #0
00420e2c: csel     x2, x9, x8, eq
00420e30: adrp     x0, #0x34000
00420e34: add      x0, x0, #0x624
00420e38: adrp     x1, #0x25000
00420e3c: add      x1, x1, #0xdc7
00420e40: bl       #0x3e1af4
00420e44: adrp     x0, #0x35000
00420e48: add      x0, x0, #0x248
00420e4c: adrp     x1, #0x22000
00420e50: add      x1, x1, #0xed9
00420e54: bl       #0x3e1af4
00420e58: adrp     x8, #0x563000
00420e5c: adrp     x9, #0x563000
00420e60: ldr      x8, [x8, #0x178]
00420e64: ldr      x9, [x9, #0x180]
00420e68: ldr      w2, [x8]
00420e6c: ldr      w3, [x9]
00420e70: adrp     x0, #0x34000
00420e74: add      x0, x0, #0x624
00420e78: adrp     x1, #0x23000
00420e7c: add      x1, x1, #0x54d
00420e80: bl       #0x3e1af4
00420e84: adrp     x0, #0x35000
00420e88: add      x0, x0, #0x248
00420e8c: adrp     x1, #0x29000
00420e90: add      x1, x1, #0x7f1 ; '内核版本'
00420e94: bl       #0x3e1af4
00420e98: adrp     x8, #0x59f000
00420e9c: add      x8, x8, #0x210
00420ea0: ldarb    w8, [x8]
00420ea4: tbz      w8, #0, #0x42150c
00420ea8: adrp     x8, #0x59f000
00420eac: add      x8, x8, #0x1f8
00420eb0: ldrb     w9, [x8]
00420eb4: ldr      x10, [x8, #0x10]
00420eb8: tst      w9, #1
00420ebc: csinc    x2, x10, x8, ne
00420ec0: adrp     x0, #0x34000
00420ec4: add      x0, x0, #0x624
00420ec8: adrp     x1, #0x25000
00420ecc: add      x1, x1, #0xdc7
00420ed0: bl       #0x3e1af4
00420ed4: adrp     x0, #0x26000
00420ed8: add      x0, x0, #0xe37
00420edc: bl       #0x43ef48
00420ee0: stur     xzr, [x29, #-0xa0]
00420ee4: movi     d0, #0000000000000000
00420ee8: adrp     x0, #0x2a000
00420eec: add      x0, x0, #0xf72
00420ef0: sub      x3, x29, #0xa0
00420ef4: mov      w1, #3
00420ef8: mov      w2, #0x8010
00420efc: bl       #0x3db058
00420f00: tbz      w0, #0, #0x421030
00420f04: movi     v1.2d, #0000000000000000
00420f08: adrp     x8, #0x593000
00420f0c: ldr      s0, [x8, #0x748]
00420f10: sub      x8, x29, #0x100
00420f14: fcvt     d0, s0
00420f18: stp      q1, q1, [x8, #0x20]
00420f1c: stp      q1, q1, [x8, #0x40]
00420f20: stp      q1, q1, [x8, #0x60]
00420f24: adrp     x3, #0x29000
00420f28: add      x3, x3, #7
00420f2c: sub      x0, x29, #0xa0
00420f30: mov      w1, #0x20
00420f34: mov      w2, #0x20
00420f38: bl       #0x41dd88
00420f3c: adrp     x8, #0x593000
00420f40: ldr      s0, [x8, #0x74c]
00420f44: fcvt     d0, s0
00420f48: adrp     x3, #0x29000
00420f4c: add      x3, x3, #7
00420f50: sub      x0, x29, #0xc0
00420f54: mov      w1, #0x20
00420f58: mov      w2, #0x20
00420f5c: bl       #0x41dd88
00420f60: adrp     x8, #0x593000
00420f64: ldr      s0, [x8, #0x750]
00420f68: fcvt     d0, s0
00420f6c: adrp     x3, #0x29000
00420f70: add      x3, x3, #7
00420f74: sub      x0, x29, #0xe0
00420f78: mov      w1, #0x20
00420f7c: mov      w2, #0x20
00420f80: bl       #0x41dd88
00420f84: bl       #0x3dfdf4
00420f88: adrp     x0, #0x35000
00420f8c: add      x0, x0, #0x248
00420f90: adrp     x1, #0x25000
00420f94: add      x1, x1, #0xdc7
00420f98: adrp     x2, #0x29000
00420f9c: add      x2, x2, #0x7fe
00420fa0: bl       #0x3e1af4
00420fa4: adrp     x0, #0x34000
00420fa8: add      x0, x0, #0x634
00420fac: adrp     x1, #0x25000
00420fb0: add      x1, x1, #0xdc7
00420fb4: sub      x2, x29, #0xa0
00420fb8: bl       #0x3e1af4
00420fbc: bl       #0x3dfdf4
00420fc0: adrp     x0, #0x35000
00420fc4: add      x0, x0, #0x248
00420fc8: adrp     x1, #0x25000
00420fcc: add      x1, x1, #0xdc7
00420fd0: adrp     x2, #0x27000
00420fd4: add      x2, x2, #0x888
00420fd8: bl       #0x3e1af4
00420fdc: adrp     x0, #0x34000
00420fe0: add      x0, x0, #0x634
00420fe4: adrp     x1, #0x25000
00420fe8: add      x1, x1, #0xdc7
00420fec: sub      x2, x29, #0xc0
00420ff0: bl       #0x3e1af4
00420ff4: bl       #0x3dfdf4
00420ff8: adrp     x0, #0x35000
00420ffc: add      x0, x0, #0x248
00421000: adrp     x1, #0x25000
00421004: add      x1, x1, #0xdc7
00421008: adrp     x2, #0x25000
0042100c: add      x2, x2, #0x3eb
00421010: bl       #0x3e1af4
00421014: adrp     x0, #0x2bd000
00421018: add      x0, x0, #0xf74
0042101c: adrp     x1, #0x25000
00421020: add      x1, x1, #0xdc7
00421024: sub      x2, x29, #0xe0
00421028: bl       #0x3e1af4
0042102c: bl       #0x3ddfe4
00421030: stur     xzr, [x29, #-0xa0]
00421034: movi     d0, #0000000000000000
00421038: adrp     x0, #0x25000
0042103c: add      x0, x0, #0xf2e
00421040: sub      x3, x29, #0xa0
00421044: mov      w1, #4
00421048: mov      w2, #0x8010
0042104c: bl       #0x3db058
00421050: tbz      w0, #0, #0x4211d8
00421054: movi     v1.2d, #0000000000000000
00421058: adrp     x8, #0x593000
0042105c: sub      x9, x29, #0x100
00421060: ldr      s0, [x8, #0x754]
00421064: fcvt     d0, s0
00421068: stp      q1, q1, [x9]
0042106c: stp      q1, q1, [x9, #0x20]
00421070: stp      q1, q1, [x9, #0x40]
00421074: stp      q1, q1, [x9, #0x60]
00421078: adrp     x3, #0x29000
0042107c: add      x3, x3, #7
00421080: sub      x0, x29, #0xa0
00421084: mov      w1, #0x20
00421088: mov      w2, #0x20
0042108c: bl       #0x41dd88
00421090: adrp     x8, #0x593000
00421094: ldr      s0, [x8, #0x758]
00421098: fcvt     d0, s0
0042109c: adrp     x3, #0x29000
004210a0: add      x3, x3, #7
004210a4: sub      x0, x29, #0xc0
004210a8: mov      w1, #0x20
004210ac: mov      w2, #0x20
004210b0: bl       #0x41dd88
004210b4: adrp     x8, #0x593000
004210b8: ldr      w4, [x8, #0x75c]
004210bc: adrp     x3, #0x28000
004210c0: add      x3, x3, #0x45c
004210c4: sub      x0, x29, #0xe0
004210c8: mov      w1, #0x20
004210cc: mov      w2, #0x20
004210d0: bl       #0x41dd88
004210d4: adrp     x8, #0x593000
004210d8: ldr      w4, [x8, #0x760]
004210dc: adrp     x3, #0x28000
004210e0: add      x3, x3, #0x45c
004210e4: sub      x0, x29, #0x100
004210e8: mov      w1, #0x20
004210ec: mov      w2, #0x20
004210f0: bl       #0x41dd88
004210f4: bl       #0x3dfdf4
004210f8: adrp     x0, #0x35000
004210fc: add      x0, x0, #0x248
00421100: adrp     x1, #0x25000
00421104: add      x1, x1, #0xdc7
00421108: adrp     x2, #0x23000
0042110c: add      x2, x2, #0xbd4
00421110: bl       #0x3e1af4
00421114: adrp     x0, #0x34000
00421118: add      x0, x0, #0x624
0042111c: adrp     x1, #0x25000
00421120: add      x1, x1, #0xdc7
00421124: sub      x2, x29, #0xa0
00421128: bl       #0x3e1af4
0042112c: bl       #0x3dfdf4
00421130: adrp     x0, #0x35000
00421134: add      x0, x0, #0x248
00421138: adrp     x1, #0x25000
0042113c: add      x1, x1, #0xdc7
00421140: adrp     x2, #0x25000
00421144: add      x2, x2, #0xf3c
00421148: bl       #0x3e1af4
0042114c: adrp     x0, #0x34000
00421150: add      x0, x0, #0x624
00421154: adrp     x1, #0x25000
00421158: add      x1, x1, #0xdc7
0042115c: sub      x2, x29, #0xc0
00421160: bl       #0x3e1af4
00421164: bl       #0x3dfdf4
00421168: adrp     x0, #0x35000
0042116c: add      x0, x0, #0x248
00421170: adrp     x1, #0x25000
00421174: add      x1, x1, #0xdc7
00421178: adrp     x2, #0x28000
0042117c: add      x2, x2, #0xba8
00421180: bl       #0x3e1af4
00421184: adrp     x0, #0x35000
00421188: add      x0, x0, #0x248
0042118c: adrp     x1, #0x25000
00421190: add      x1, x1, #0xdc7
00421194: sub      x2, x29, #0xe0
00421198: bl       #0x3e1af4
0042119c: bl       #0x3dfdf4
004211a0: adrp     x0, #0x35000
004211a4: add      x0, x0, #0x248
004211a8: adrp     x1, #0x25000
004211ac: add      x1, x1, #0xdc7
004211b0: adrp     x2, #0x25000
004211b4: add      x2, x2, #0xf49
004211b8: bl       #0x3e1af4
004211bc: adrp     x0, #0x35000
004211c0: add      x0, x0, #0x248
004211c4: adrp     x1, #0x25000
004211c8: add      x1, x1, #0xdc7
004211cc: sub      x2, x29, #0x100
004211d0: bl       #0x3e1af4
004211d4: bl       #0x3ddfe4
004211d8: adrp     x0, #0x23000
004211dc: add      x0, x0, #0xba9
004211e0: bl       #0x43ef48
004211e4: adrp     x1, #0x35000
004211e8: add      x1, x1, #0x248
004211ec: mov      w0, wzr
004211f0: bl       #0x3b5758
004211f4: adrp     x0, #0x2a000
004211f8: add      x0, x0, #0x8f8
004211fc: bl       #0x3e1cdc
00421200: adrp     x0, #0x24000
00421204: add      x0, x0, #0x1e
00421208: bl       #0x3e1cdc
0042120c: mov      w0, #1
00421210: bl       #0x3b58b4
00421214: ldrb     w8, [x25, #0x565]
00421218: cbz      w8, #0x421298
0042121c: bl       #0x3bb6a0
00421220: fmov     s0, #4.00000000
00421224: ldr      s1, [x0, #0x38]
00421228: fmov     s2, #3.00000000
0042122c: mov      w8, #0xd70a
00421230: stur     wzr, [x29, #-0xa0]
00421234: movk     w8, #0x3c23, lsl #16
00421238: fcmp     s1, s0
0042123c: fcsel    s0, s0, s1, gt
00421240: fmul     s0, s0, s2
00421244: fmov     s2, w8
00421248: mov      w8, #0xc28f
0042124c: movk     w8, #0x3cf5, lsl #16
00421250: fcmp     s1, s2
00421254: fmov     s1, w8
00421258: fcsel    s0, s1, s0, mi
0042125c: stur     s0, [x29, #-0x9c]
00421260: sub      x0, x29, #0xa0
00421264: bl       #0x3e46b0
00421268: bl       #0x3c9d48
0042126c: fmov     s9, s1
00421270: bl       #0x3c9d5c
00421274: fmov     s10, s1
00421278: bl       #0x3c72cc
0042127c: fadd     s0, s9, s10
00421280: ldr      s1, [x27, #0x24]
00421284: ldrsw    x8, [x27, #0xc]
00421288: strb     wzr, [x27, #1]
0042128c: add      x8, x27, x8, lsl #2
00421290: fadd     s0, s0, s1
00421294: str      s0, [x8, #0x2c]
00421298: ldr      w8, [x26]
0042129c: ldr      s0, [x26, #0x10]
004212a0: cmp      w8, #1
004212a4: b.lt     #0x4212cc
004212a8: adrp     x9, #0x593000
004212ac: add      x9, x9, #0x588
004212b0: ldr      s1, [x9], #8
004212b4: ldr      s2, [x9], #4
004212b8: fsub     s2, s2, s1
004212bc: fcmp     s0, s2
004212c0: fcsel    s0, s2, s0, mi
004212c4: subs     x8, x8, #1
004212c8: b.ne     #0x4212b4
004212cc: adrp     x8, #0x593000
004212d0: ldr      s1, [x8, #0x574]
004212d4: stp      s1, s0, [x29, #-0xa0]
004212d8: sub      x0, x29, #0xa0
004212dc: bl       #0x3cc444
004212e0: adrp     x8, #0x593000
004212e4: stur     wzr, [x29, #-0x9c]
004212e8: ldr      s0, [x8, #0x57c]
004212ec: stur     s0, [x29, #-0xa0]
004212f0: sub      x0, x29, #0xa0
004212f4: bl       #0x3e46b0
004212f8: bl       #0x3cad20
004212fc: movi     v0.2d, #0000000000000000
00421300: mov      w8, #1
00421304: strh     wzr, [x27]
00421308: str      w8, [x27, #4]
0042130c: stur     q0, [x27, #8]
00421310: stur     q0, [x27, #0x18]
00421314: stur     q0, [x27, #0x24]
00421318: mov      w0, #1
0042131c: bl       #0x3b5db0
00421320: fcmp     s14, s15
00421324: b.pl     #0x421344
00421328: ldr      s0, [sp, #0x50]
0042132c: stur     wzr, [x29, #-0xa0]
00421330: stur     s0, [x29, #-0x9c]
00421334: sub      x0, x29, #0xa0
00421338: bl       #0x3e46b0
0042133c: fmov     s0, s8
00421340: bl       #0x43dfc4
00421344: bl       #0x3c72cc
00421348: fcmp     s14, s15
0042134c: b.mi     #0x421358
00421350: fmov     s0, s8
00421354: bl       #0x43dfc4
00421358: bl       #0x3c72cc
0042135c: bl       #0x3c5c78
00421360: ldr      w0, [sp, #0x70]
00421364: bl       #0x3b58b4
00421368: ldr      w0, [sp, #0x74]
0042136c: bl       #0x3b5db0
00421370: bl       #0x421644
00421374: adrp     x8, #0x593000
00421378: ldr      x8, [x8, #0xbb0]
0042137c: cbz      x8, #0x4213ac
00421380: ldrb     w9, [x8, #0x38]
00421384: cbz      w9, #0x4213ac
00421388: ldp      x19, x20, [x8, #8]
0042138c: cmp      x19, x20
00421390: b.eq     #0x4213ac
00421394: ldr      x0, [x19], #8
00421398: ldr      x8, [x0]
0042139c: ldr      x8, [x8, #0x10]
004213a0: blr      x8
004213a4: cmp      x19, x20
004213a8: b.ne     #0x421394
004213ac: bl       #0x3c9e58
004213b0: cbz      x0, #0x4214b0
004213b4: mov      x19, x0
004213b8: bl       #0x3bb6a0
004213bc: fmov     s10, #4.00000000
004213c0: ldr      s0, [x0, #0x38]
004213c4: mov      w8, #0xd70a
004213c8: fmov     s2, #24.00000000
004213cc: movk     w8, #0x3c23, lsl #16
004213d0: adrp     x20, #0x29000
004213d4: add      x20, x20, #0xea1
004213d8: fmov     s11, w8
004213dc: mov      w8, #0xc28f
004213e0: fcmp     s0, s10
004213e4: movk     w8, #0x3e75, lsl #16
004213e8: mov      x0, x19
004213ec: mov      x1, x20
004213f0: mov      x2, xzr
004213f4: mov      x3, xzr
004213f8: fcsel    s1, s10, s0, gt
004213fc: fcmp     s0, s11
00421400: fmov     s0, w8
00421404: mov      w8, #0x7f7fffff
00421408: fmul     s1, s1, s2
0042140c: movi     d2, #0000000000000000
00421410: fcsel    s8, s0, s1, mi
00421414: fmov     s1, w8
00421418: fmov     s0, s8
0042141c: bl       #0x3d9ebc
00421420: fmov     s9, s1
00421424: bl       #0x3bb6a0
00421428: ldr      s13, [x0, #0xc]
0042142c: bl       #0x3bb6a0
00421430: ldr      s0, [x0, #0x38]
00421434: fmov     s14, #18.00000000
00421438: mov      w8, #0x51eb
0042143c: movk     w8, #0x3e38, lsl #16
00421440: fsub     s9, s13, s9
00421444: fcmp     s0, s10
00421448: fmov     s15, w8
0042144c: fcsel    s1, s10, s0, gt
00421450: fcmp     s0, s11
00421454: fmul     s1, s1, s14
00421458: fcsel    s12, s15, s1, mi
0042145c: bl       #0x3bb6a0
00421460: ldr      s0, [x0, #0x38]
00421464: fcmp     s0, s10
00421468: fcsel    s1, s10, s0, gt
0042146c: fcmp     s0, s11
00421470: fmul     s0, s1, s14
00421474: movi     d1, #0000000000000000
00421478: fcsel    s0, s15, s0, mi
0042147c: fsub     s0, s9, s0
00421480: fmaxnm   s0, s0, s1
00421484: stp      s12, s0, [sp, #0x80]
00421488: bl       #0x3bb7f0
0042148c: movi     d1, #0000000000000000
00421490: fmov     s0, s8
00421494: add      x2, sp, #0x80
00421498: mov      x1, x19
0042149c: mov      w3, #-0xffff01
004214a0: mov      x4, x20
004214a4: mov      x5, xzr
004214a8: mov      x6, xzr
004214ac: bl       #0x3d4f4c
004214b0: ldr      x8, [sp, #0x48]
004214b4: ldr      x8, [x8, #0x28]
004214b8: ldur     x9, [x29, #-0x58]
004214bc: cmp      x8, x9
004214c0: b.ne     #0x421640
004214c4: add      sp, sp, #0x5e0
004214c8: ldp      x20, x19, [sp, #0x90]
004214cc: ldp      x22, x21, [sp, #0x80]
004214d0: ldp      x24, x23, [sp, #0x70]
004214d4: ldp      x26, x25, [sp, #0x60]
004214d8: ldp      x28, x27, [sp, #0x50]
004214dc: ldp      x29, x30, [sp, #0x40]
004214e0: ldp      d9, d8, [sp, #0x30]
004214e4: ldp      d11, d10, [sp, #0x20]
004214e8: ldp      d13, d12, [sp, #0x10]
004214ec: ldp      d15, d14, [sp], #0xa0
004214f0: ret      
004214f4: ldr      x8, [sp, #0x48]
004214f8: ldr      x8, [x8, #0x28]
004214fc: ldur     x9, [x29, #-0x58]
00421500: cmp      x8, x9
00421504: b.ne     #0x421640
00421508: bl       #0x3979b4
0042150c: adrp     x0, #0x59f000
00421510: add      x0, x0, #0x210
00421514: bl       #0x533d48
00421518: cbz      w0, #0x420ea8
0042151c: bl       #0x4426bc
00421520: adrp     x0, #0x562000
00421524: adrp     x1, #0x59f000
00421528: add      x1, x1, #0x1f8
0042152c: ldr      x0, [x0, #0xf48]
00421530: adrp     x2, #0x593000
00421534: add      x2, x2, #0x6c8
00421538: bl       #0x553ec0 ; __cxa_atexit
0042153c: adrp     x0, #0x59f000
00421540: add      x0, x0, #0x210
00421544: bl       #0x533e78
00421548: b        #0x420ea8
0042154c: mov      x19, x0
00421550: adrp     x0, #0x59f000
00421554: add      x0, x0, #0x210
00421558: bl       #0x533f20
0042155c: b        #0x42161c
00421560: b        #0x421618
00421564: b        #0x421618
00421568: b        #0x421618
0042156c: ldurb    w8, [x29, #-0xa0]
00421570: mov      x19, x0
00421574: tbz      w8, #0, #0x42161c
00421578: ldur     x0, [x29, #-0x90]
0042157c: bl       #0x54e070
00421580: b        #0x42161c
00421584: b        #0x421618
00421588: b        #0x421618
0042158c: b        #0x421618
00421590: b        #0x421618
00421594: b        #0x421618
00421598: b        #0x421618
0042159c: b        #0x421618
004215a0: b        #0x421618
004215a4: b        #0x421618
004215a8: b        #0x421618
004215ac: b        #0x421618
004215b0: b        #0x421618
004215b4: b        #0x421618
004215b8: b        #0x421618
004215bc: b        #0x421618
004215c0: b        #0x421618
004215c4: b        #0x421618
004215c8: b        #0x421618
004215cc: b        #0x421618
004215d0: b        #0x421618
004215d4: bl       #0x3860c0
004215d8: b        #0x421618
004215dc: b        #0x421618
004215e0: mov      x19, x0
004215e4: b        #0x4215fc
004215e8: ldurb    w8, [x29, #-0xa0]
004215ec: mov      x19, x0
004215f0: tbz      w8, #0, #0x4215fc
004215f4: ldur     x0, [x29, #-0x90]
004215f8: bl       #0x54e070
004215fc: ldurb    w8, [x29, #-0xc0]
00421600: tbz      w8, #0, #0x42161c
00421604: ldur     x0, [x29, #-0xb0]
00421608: bl       #0x54e070
0042160c: b        #0x42161c
00421610: b        #0x421618
00421614: b        #0x421618
00421618: mov      x19, x0
0042161c: add      x0, sp, #0x70
00421620: bl       #0x43e300
00421624: ldr      x8, [sp, #0x48]
00421628: ldr      x8, [x8, #0x28]
0042162c: ldur     x9, [x29, #-0x58]
00421630: cmp      x8, x9
00421634: b.ne     #0x421640
00421638: mov      x0, x19
0042163c: bl       #0x54fffc
00421640: bl       #0x553f00 ; __stack_chk_fail
