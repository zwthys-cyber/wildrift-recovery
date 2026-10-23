
; 04ea11d8-last-position.asm -> 0x391a2bc
0391a2bc: ldr      x9, [x0, #0x18]
0391a2c0: ldr      q0, [x9, #0x90]
0391a2c4: str      q0, [x8]
0391a2c8: ldr      x9, [x9, #0xa0]
0391a2cc: str      x9, [x8, #0x10]
0391a2d0: ret      
0391a2d4: ldr      x8, [x0, #0x18]
0391a2d8: ldr      x0, [x8, #0xa8]
0391a2dc: ret      
0391a2e0: ldr      x8, [x0, #0x18]

; 04ea1310.asm -> 0x391a3f4
0391a3f4: stp      x20, x19, [sp, #-0x20]!
0391a3f8: stp      x29, x30, [sp, #0x10]
0391a3fc: add      x29, sp, #0x10
0391a400: mov      x19, x0
0391a404: ldr      x8, [x0, #0x18]
0391a408: adds     x0, x8, #0x168
0391a40c: b.eq     #0x391a45c
0391a410: ldur     x8, [x19, #0x28]
0391a414: cbz      x8, #0x391a430
0391a418: ldr      x9, [x8, #0x10]
0391a41c: mov      w10, w9
0391a420: cmp      x9, x0
0391a424: mov      w9, #-0x22222223
0391a428: ccmp     x10, x9, #4, eq
0391a42c: b.ne     #0x391a44c
0391a430: mov      x1, #0
0391a434: bl       #0x3910cf8
0391a438: mov      x1, x0
0391a43c: stur     x0, [x19, #0x28]
0391a440: add      x0, x19, #0x28
0391a444: bl       #0x172b1d8
0391a448: ldur     x8, [x19, #0x28]
0391a44c: mov      x0, x8
0391a450: ldp      x29, x30, [sp, #0x10]
0391a454: ldp      x20, x19, [sp], #0x20
0391a458: ret      
0391a45c: stur     xzr, [x19, #0x28]
0391a460: add      x0, x19, #0x28
0391a464: mov      x1, #0
0391a468: bl       #0x172b1d8
0391a46c: mov      x8, #0
0391a470: mov      x0, x8
0391a474: ldp      x29, x30, [sp, #0x10]
0391a478: ldp      x20, x19, [sp], #0x20
0391a47c: ret      

; 04ea20cc.asm -> 0x391b1b0
0391b1b0: ldr      x8, [x0, #0x18]
0391b1b4: ldr      x0, [x8, #0x150]
0391b1b8: ret      

; 04eba794.asm -> 0x3933878
03933878: stp      x20, x19, [sp, #-0x20]!
0393387c: stp      x29, x30, [sp, #0x10]
03933880: add      x29, sp, #0x10
03933884: mov      x19, x0
03933888: ldr      x8, [x0, #0x18]
0393388c: ldr      x0, [x8, #0x140]
03933890: cbz      x0, #0x39338e0
03933894: ldur     x8, [x19, #0x60]
03933898: cbz      x8, #0x39338b4
0393389c: ldr      x9, [x8, #0x10]
039338a0: mov      w10, w9
039338a4: cmp      x9, x0
039338a8: mov      w9, #-0x22222223
039338ac: ccmp     x10, x9, #4, eq
039338b0: b.ne     #0x39338d0
039338b4: mov      x1, #0
039338b8: bl       #0x3bee40c
039338bc: mov      x1, x0
039338c0: stur     x0, [x19, #0x60]
039338c4: add      x0, x19, #0x60
039338c8: bl       #0x172b1d8
039338cc: ldur     x8, [x19, #0x60]
039338d0: mov      x0, x8
039338d4: ldp      x29, x30, [sp, #0x10]
039338d8: ldp      x20, x19, [sp], #0x20
039338dc: ret      
039338e0: stur     xzr, [x19, #0x60]
039338e4: add      x0, x19, #0x60
039338e8: mov      x1, #0
039338ec: bl       #0x172b1d8
039338f0: mov      x8, #0
039338f4: mov      x0, x8
039338f8: ldp      x29, x30, [sp, #0x10]
039338fc: ldp      x20, x19, [sp], #0x20
03933900: ret      

; 04ebb3d0.asm -> 0x39344b4
039344b4: stp      x20, x19, [sp, #-0x20]!
039344b8: stp      x29, x30, [sp, #0x10]
039344bc: add      x29, sp, #0x10
039344c0: mov      x19, x0
039344c4: adrp     x20, #0xf276000
039344c8: ldrb     w8, [x20, #0xc2f]
039344cc: tbnz     w8, #0, #0x39344e4
039344d0: adrp     x0, #0xed89000
039344d4: add      x0, x0, #0xb58
039344d8: bl       #0x172b24c
039344dc: mov      w8, #1
039344e0: strb     w8, [x20, #0xc2f]
039344e4: ldr      x8, [x19, #0x18]
039344e8: adds     x0, x8, #0x208
039344ec: b.eq     #0x3934534
039344f0: ldur     x8, [x19, #0xf8]
039344f4: cbz      x8, #0x3934504
039344f8: ldr      x9, [x8, #0x10]
039344fc: cmp      x9, x0
03934500: b.eq     #0x3934524
03934504: adrp     x8, #0xed89000
03934508: ldr      x1, [x8, #0xb58]
0393450c: bl       #0x7c0995c
03934510: mov      x1, x0
03934514: stur     x0, [x19, #0xf8]
03934518: add      x0, x19, #0xf8
0393451c: bl       #0x172b1d8
03934520: ldur     x8, [x19, #0xf8]
03934524: mov      x0, x8
03934528: ldp      x29, x30, [sp, #0x10]
0393452c: ldp      x20, x19, [sp], #0x20
03934530: ret      
03934534: stur     xzr, [x19, #0xf8]
03934538: add      x0, x19, #0xf8
0393453c: mov      x1, #0
03934540: bl       #0x172b1d8
03934544: mov      x8, #0
03934548: mov      x0, x8
0393454c: ldp      x29, x30, [sp, #0x10]
03934550: ldp      x20, x19, [sp], #0x20
03934554: ret      

; 04ebd8a0.asm -> 0x3936984
03936984: stp      x24, x23, [sp, #-0x40]!
03936988: stp      x22, x21, [sp, #0x10]
0393698c: stp      x20, x19, [sp, #0x20]
03936990: stp      x29, x30, [sp, #0x30]
03936994: add      x29, sp, #0x30
03936998: mov      x19, x1
0393699c: mov      x20, x0
039369a0: adrp     x21, #0xf276000
039369a4: ldrb     w8, [x21, #0xc34]
039369a8: tbz      w8, #0, #0x3936b48
039369ac: adrp     x21, #0xf276000
039369b0: ldrb     w8, [x21, #0xc2f]
039369b4: tbz      w8, #0, #0x3936b80
039369b8: ldr      x8, [x20, #0x18]
039369bc: adds     x0, x8, #0x208
039369c0: b.eq     #0x3936ba0
039369c4: ldur     x22, [x20, #0xf8]
039369c8: cbz      x22, #0x39369d8
039369cc: ldr      x8, [x22, #0x10]
039369d0: cmp      x8, x0
039369d4: b.eq     #0x39369f8
039369d8: adrp     x8, #0xed89000
039369dc: ldr      x1, [x8, #0xb58]
039369e0: bl       #0x7c0995c
039369e4: mov      x1, x0
039369e8: stur     x0, [x20, #0xf8]
039369ec: add      x0, x20, #0xf8
039369f0: bl       #0x172b1d8
039369f4: ldur     x22, [x20, #0xf8]
039369f8: tbnz     w19, #0x1f, #0x3936bb0
039369fc: cbz      x22, #0x3936bb0
03936a00: ldr      x8, [x22, #0x18]
03936a04: adds     x20, x8, #0x10
03936a08: b.eq     #0x3936bc8
03936a0c: adrp     x23, #0xed89000
03936a10: ldr      x8, [x23, #0xb68]
03936a14: ldur     x24, [x22, #0x20]
03936a18: cbz      x24, #0x3936a28
03936a1c: ldr      x9, [x24, #0x10]
03936a20: cmp      x9, x20
03936a24: b.eq     #0x3936a60
03936a28: ldr      x8, [x8, #0x20]
03936a2c: ldr      x0, [x8, #0xc0]
03936a30: mov      w1, #6
03936a34: bl       #0x172c164
03936a38: mov      x1, x0
03936a3c: mov      x0, x20
03936a40: bl       #0x7c09e64
03936a44: mov      x1, x0
03936a48: stur     x0, [x22, #0x20]
03936a4c: add      x0, x22, #0x20
03936a50: bl       #0x172b1d8
03936a54: ldur     x24, [x22, #0x20]
03936a58: cbz      x24, #0x3936bd8
03936a5c: ldr      x20, [x24, #0x10]
03936a60: ldr      w8, [x20, #0x18]
03936a64: ldr      w9, [x20]
03936a68: ldr      w10, [x20, #8]
03936a6c: sub      w9, w10, w9
03936a70: sdiv     w8, w9, w8
03936a74: cmp      w8, w19
03936a78: b.le     #0x3936bb0
03936a7c: ldr      x8, [x22, #0x18]
03936a80: adds     x21, x8, #0x10
03936a84: b.eq     #0x3936bc8
03936a88: cmp      x20, x21
03936a8c: b.eq     #0x3936ac8
03936a90: ldr      x8, [x23, #0xb68]
03936a94: ldr      x8, [x8, #0x20]
03936a98: ldr      x0, [x8, #0xc0]
03936a9c: mov      w1, #6
03936aa0: bl       #0x172c164
03936aa4: mov      x1, x0
03936aa8: mov      x0, x21
03936aac: bl       #0x7c09e64
03936ab0: mov      x1, x0
03936ab4: stur     x0, [x22, #0x20]
03936ab8: add      x0, x22, #0x20
03936abc: bl       #0x172b1d8
03936ac0: ldur     x24, [x22, #0x20]
03936ac4: cbz      x24, #0x3936bd8
03936ac8: adrp     x8, #0xed9f000
03936acc: ldr      x20, [x8, #0x730]
03936ad0: adrp     x21, #0xf27b000
03936ad4: ldrb     w8, [x21, #0xb8]
03936ad8: tbnz     w8, #0, #0x3936af0
03936adc: adrp     x0, #0xed74000
03936ae0: add      x0, x0, #0x100
03936ae4: bl       #0x172b24c
03936ae8: mov      w8, #1
03936aec: strb     w8, [x21, #0xb8]
03936af0: ldr      x8, [x24, #0x10]
03936af4: ldr      w9, [x8, #0x18]
03936af8: ldr      x8, [x8]
03936afc: mul      w9, w9, w19
03936b00: ldr      x19, [x8, w9, sxtw]
03936b04: cbz      x19, #0x3936bb0
03936b08: adrp     x8, #0xed74000
03936b0c: ldr      x0, [x8, #0x100]
03936b10: ldr      w8, [x0, #0xe0]
03936b14: cbnz     w8, #0x3936b1c
03936b18: bl       #0x172b3a8
03936b1c: ldr      x8, [x20, #0x20]
03936b20: ldr      x0, [x8, #0xc0]
03936b24: mov      w1, #6
03936b28: bl       #0x172c164
03936b2c: mov      x1, x0
03936b30: mov      x0, x19
03936b34: ldp      x29, x30, [sp, #0x30]
03936b38: ldp      x20, x19, [sp, #0x20]
03936b3c: ldp      x22, x21, [sp, #0x10]
03936b40: ldp      x24, x23, [sp], #0x40
03936b44: b        #0xa9c76a0
03936b48: adrp     x0, #0xed89000
03936b4c: add      x0, x0, #0xb68
03936b50: bl       #0x172b24c
03936b54: adrp     x0, #0xed9f000
03936b58: add      x0, x0, #0x728
03936b5c: bl       #0x172b24c
03936b60: adrp     x0, #0xed9f000
03936b64: add      x0, x0, #0x730
03936b68: bl       #0x172b24c
03936b6c: mov      w8, #1
03936b70: strb     w8, [x21, #0xc34]
03936b74: adrp     x21, #0xf276000
03936b78: ldrb     w8, [x21, #0xc2f]
03936b7c: tbnz     w8, #0, #0x39369b8
03936b80: adrp     x0, #0xed89000
03936b84: add      x0, x0, #0xb58
03936b88: bl       #0x172b24c
03936b8c: mov      w8, #1
03936b90: strb     w8, [x21, #0xc2f]
03936b94: ldr      x8, [x20, #0x18]
03936b98: adds     x0, x8, #0x208
03936b9c: b.ne     #0x39369c4
03936ba0: stur     xzr, [x20, #0xf8]
03936ba4: add      x0, x20, #0xf8
03936ba8: mov      x1, #0
03936bac: bl       #0x172b1d8
03936bb0: mov      x0, #0
03936bb4: ldp      x29, x30, [sp, #0x30]
03936bb8: ldp      x20, x19, [sp, #0x20]
03936bbc: ldp      x22, x21, [sp, #0x10]
03936bc0: ldp      x24, x23, [sp], #0x40
03936bc4: ret      
03936bc8: stur     xzr, [x22, #0x20]
03936bcc: add      x0, x22, #0x20
03936bd0: mov      x1, #0
03936bd4: bl       #0x172b1d8
03936bd8: bl       #0x172b4f8

; 04ecc0ec.asm -> 0x39451d0
039451d0: ldr      x8, [x0, #0x18]
039451d4: ldr      w0, [x8, #0x20]
039451d8: ret      

; 04ecc1a4.asm -> 0x3945288
03945288: ldr      x8, [x0, #0x18]
0394528c: ldr      w0, [x8, #0x38]
03945290: ret      

; 04ecc1c8.asm -> 0x39452ac
039452ac: ldr      x8, [x0, #0x18]
039452b0: ldr      w0, [x8, #0x44]
039452b4: ret      

; 04ecc39c.asm -> 0x3945480
03945480: stp      x20, x19, [sp, #-0x20]!
03945484: stp      x29, x30, [sp, #0x10]
03945488: add      x29, sp, #0x10
0394548c: mov      x19, x0
03945490: adrp     x20, #0xf276000
03945494: ldrb     w8, [x20, #0xc40]
03945498: tbnz     w8, #0, #0x39454bc
0394549c: adrp     x0, #0xee22000
039454a0: add      x0, x0, #0x100
039454a4: bl       #0x172b24c
039454a8: adrp     x0, #0xed74000
039454ac: add      x0, x0, #0x100
039454b0: bl       #0x172b24c
039454b4: mov      w8, #1
039454b8: strb     w8, [x20, #0xc40]
039454bc: ldr      x8, [x19, #0x18]
039454c0: ldr      x20, [x8, #0x108]
039454c4: cbz      x20, #0x394552c
039454c8: ldr      x0, [x19, #0x30]!
039454cc: cbz      x0, #0x39454e8
039454d0: ldr      x8, [x0, #0x10]
039454d4: mov      w9, w8
039454d8: cmp      x8, x20
039454dc: mov      w8, #-0x22222223
039454e0: ccmp     x9, x8, #4, eq
039454e4: b.ne     #0x3945520
039454e8: adrp     x8, #0xed74000
039454ec: ldr      x0, [x8, #0x100]
039454f0: ldr      w8, [x0, #0xe0]
039454f4: cbnz     w8, #0x39454fc
039454f8: bl       #0x172b3a8
039454fc: adrp     x8, #0xee22000
03945500: ldr      x1, [x8, #0x100]
03945504: mov      x0, x20
03945508: bl       #0xa9c76a0
0394550c: mov      x1, x0
03945510: str      x0, [x19]
03945514: mov      x0, x19
03945518: bl       #0x172b1d8
0394551c: ldr      x0, [x19]
03945520: ldp      x29, x30, [sp, #0x10]
03945524: ldp      x20, x19, [sp], #0x20
03945528: ret      
0394552c: str      xzr, [x19, #0x30]!
03945530: mov      x0, x19
03945534: mov      x1, #0
03945538: bl       #0x172b1d8
0394553c: mov      x0, #0
03945540: ldp      x29, x30, [sp, #0x10]
03945544: ldp      x20, x19, [sp], #0x20
03945548: ret      

; 04ecc580.asm -> 0x3945664
03945664: stp      x20, x19, [sp, #-0x20]!
03945668: stp      x29, x30, [sp, #0x10]
0394566c: add      x29, sp, #0x10
03945670: mov      x19, x0
03945674: adrp     x20, #0xf276000
03945678: ldrb     w8, [x20, #0xc41]
0394567c: tbnz     w8, #0, #0x39456a0
03945680: adrp     x0, #0xee22000
03945684: add      x0, x0, #0x108
03945688: bl       #0x172b24c
0394568c: adrp     x0, #0xed74000
03945690: add      x0, x0, #0x100
03945694: bl       #0x172b24c
03945698: mov      w8, #1
0394569c: strb     w8, [x20, #0xc41]
039456a0: ldr      x8, [x19, #0x18]
039456a4: ldr      x20, [x8, #0x1d0]
039456a8: cbz      x20, #0x3945710
039456ac: ldr      x0, [x19, #0x48]!
039456b0: cbz      x0, #0x39456cc
039456b4: ldr      x8, [x0, #0x10]
039456b8: mov      w9, w8
039456bc: cmp      x8, x20
039456c0: mov      w8, #-0x22222223
039456c4: ccmp     x9, x8, #4, eq
039456c8: b.ne     #0x3945704
039456cc: adrp     x8, #0xed74000
039456d0: ldr      x0, [x8, #0x100]
039456d4: ldr      w8, [x0, #0xe0]
039456d8: cbnz     w8, #0x39456e0
039456dc: bl       #0x172b3a8
039456e0: adrp     x8, #0xee22000
039456e4: ldr      x1, [x8, #0x108]
039456e8: mov      x0, x20
039456ec: bl       #0xa9c76a0
039456f0: mov      x1, x0
039456f4: str      x0, [x19]
039456f8: mov      x0, x19
039456fc: bl       #0x172b1d8
03945700: ldr      x0, [x19]
03945704: ldp      x29, x30, [sp, #0x10]
03945708: ldp      x20, x19, [sp], #0x20
0394570c: ret      
03945710: str      xzr, [x19, #0x48]!
03945714: mov      x0, x19
03945718: mov      x1, #0
0394571c: bl       #0x172b1d8
03945720: mov      x0, #0
03945724: ldp      x29, x30, [sp, #0x10]
03945728: ldp      x20, x19, [sp], #0x20
0394572c: ret      

; 04ecc764.asm -> 0x3945848
03945848: stp      x20, x19, [sp, #-0x20]!
0394584c: stp      x29, x30, [sp, #0x10]
03945850: add      x29, sp, #0x10
03945854: mov      x19, x0
03945858: ldr      x8, [x0, #0x18]
0394585c: adds     x0, x8, #0x420
03945860: b.eq     #0x39458b0
03945864: ldur     x8, [x19, #0x60]
03945868: cbz      x8, #0x3945884
0394586c: ldr      x9, [x8, #0x10]
03945870: mov      w10, w9
03945874: cmp      x9, x0
03945878: mov      w9, #-0x22222223
0394587c: ccmp     x10, x9, #4, eq
03945880: b.ne     #0x39458a0
03945884: mov      x1, #0
03945888: bl       #0x3ba894c
0394588c: mov      x1, x0
03945890: stur     x0, [x19, #0x60]
03945894: add      x0, x19, #0x60
03945898: bl       #0x172b1d8
0394589c: ldur     x8, [x19, #0x60]
039458a0: mov      x0, x8
039458a4: ldp      x29, x30, [sp, #0x10]
039458a8: ldp      x20, x19, [sp], #0x20
039458ac: ret      
039458b0: stur     xzr, [x19, #0x60]
039458b4: add      x0, x19, #0x60
039458b8: mov      x1, #0
039458bc: bl       #0x172b1d8
039458c0: mov      x8, #0
039458c4: mov      x0, x8
039458c8: ldp      x29, x30, [sp, #0x10]
039458cc: ldp      x20, x19, [sp], #0x20
039458d0: ret      

; 04ecc894.asm -> 0x3945978
03945978: stp      x20, x19, [sp, #-0x20]!
0394597c: stp      x29, x30, [sp, #0x10]
03945980: add      x29, sp, #0x10
03945984: mov      x19, x0
03945988: ldr      x8, [x0, #0x18]
0394598c: adds     x0, x8, #0x498
03945990: b.eq     #0x39459e0
03945994: ldur     x8, [x19, #0x70]
03945998: cbz      x8, #0x39459b4
0394599c: ldr      x9, [x8, #0x10]
039459a0: mov      w10, w9
039459a4: cmp      x9, x0
039459a8: mov      w9, #-0x22222223
039459ac: ccmp     x10, x9, #4, eq
039459b0: b.ne     #0x39459d0
039459b4: mov      x1, #0
039459b8: bl       #0x3bdaf7c
039459bc: mov      x1, x0
039459c0: stur     x0, [x19, #0x70]
039459c4: add      x0, x19, #0x70
039459c8: bl       #0x172b1d8
039459cc: ldur     x8, [x19, #0x70]
039459d0: mov      x0, x8
039459d4: ldp      x29, x30, [sp, #0x10]
039459d8: ldp      x20, x19, [sp], #0x20
039459dc: ret      
039459e0: stur     xzr, [x19, #0x70]
039459e4: add      x0, x19, #0x70
039459e8: mov      x1, #0
039459ec: bl       #0x172b1d8
039459f0: mov      x8, #0
039459f4: mov      x0, x8
039459f8: ldp      x29, x30, [sp, #0x10]
039459fc: ldp      x20, x19, [sp], #0x20
03945a00: ret      

; 04ed1f94.asm -> 0x394b078
0394b078: stp      x22, x21, [sp, #-0x30]!
0394b07c: stp      x20, x19, [sp, #0x10]
0394b080: stp      x29, x30, [sp, #0x20]
0394b084: add      x29, sp, #0x20
0394b088: mov      x19, x0
0394b08c: adrp     x20, #0xf276000
0394b090: ldrb     w8, [x20, #0xc4f]
0394b094: tbnz     w8, #0, #0x394b0ac
0394b098: adrp     x0, #0xed5e000
0394b09c: add      x0, x0, #0x5a0
0394b0a0: bl       #0x172b24c
0394b0a4: mov      w8, #1
0394b0a8: strb     w8, [x20, #0xc4f]
0394b0ac: ldr      x8, [x19, #0x18]
0394b0b0: adds     x0, x8, #0x420
0394b0b4: b.eq     #0x394b32c
0394b0b8: mov      w20, #-0x22222223
0394b0bc: ldur     x21, [x19, #0x60]
0394b0c0: cbz      x21, #0x394b0d8
0394b0c4: ldr      x8, [x21, #0x10]
0394b0c8: mov      w9, w8
0394b0cc: cmp      x8, x0
0394b0d0: ccmp     x9, x20, #4, eq
0394b0d4: b.ne     #0x394b0f8
0394b0d8: mov      x1, #0
0394b0dc: bl       #0x3ba894c
0394b0e0: mov      x1, x0
0394b0e4: stur     x0, [x19, #0x60]
0394b0e8: add      x0, x19, #0x60
0394b0ec: bl       #0x172b1d8
0394b0f0: ldur     x21, [x19, #0x60]
0394b0f4: cbz      x21, #0x394b33c
0394b0f8: ldr      x8, [x21, #0x18]
0394b0fc: ldr      x0, [x8, #0x20]
0394b100: cbz      x0, #0x394b2c0
0394b104: ldur     x8, [x21, #0x28]
0394b108: cbz      x8, #0x394b120
0394b10c: ldr      x8, [x8, #0x10]
0394b110: mov      w9, w8
0394b114: cmp      x8, x0
0394b118: ccmp     x9, x20, #4, eq
0394b11c: b.ne     #0x394b140
0394b120: bl       #0x3ba7d80
0394b124: mov      x1, x0
0394b128: stur     x0, [x21, #0x28]
0394b12c: add      x0, x21, #0x28
0394b130: bl       #0x172b1d8
0394b134: ldur     x8, [x21, #0x28]
0394b138: cbz      x8, #0x394b2d0
0394b13c: ldr      x0, [x8, #0x10]
0394b140: mov      w8, w0
0394b144: cmp      x0, #0
0394b148: ccmp     x8, x20, #4, ne
0394b14c: b.eq     #0x394b2d0
0394b150: ldr      x8, [x19, #0x18]
0394b154: adds     x0, x8, #0x420
0394b158: b.eq     #0x394b32c
0394b15c: ldur     x21, [x19, #0x60]
0394b160: cbz      x21, #0x394b17c
0394b164: ldr      x8, [x21, #0x10]
0394b168: cmp      x8, x0
0394b16c: b.ne     #0x394b17c
0394b170: mov      w8, w8
0394b174: cmp      x8, x20
0394b178: b.ne     #0x394b19c
0394b17c: mov      x1, #0
0394b180: bl       #0x3ba894c
0394b184: mov      x1, x0
0394b188: stur     x0, [x19, #0x60]
0394b18c: add      x0, x19, #0x60
0394b190: bl       #0x172b1d8
0394b194: ldur     x21, [x19, #0x60]
0394b198: cbz      x21, #0x394b33c
0394b19c: ldr      x8, [x21, #0x18]
0394b1a0: ldr      x0, [x8, #0x20]
0394b1a4: cbz      x0, #0x394b340
0394b1a8: ldur     x8, [x21, #0x28]
0394b1ac: cbz      x8, #0x394b1c8
0394b1b0: ldr      x9, [x8, #0x10]
0394b1b4: cmp      x9, x0
0394b1b8: b.ne     #0x394b1c8
0394b1bc: mov      w9, w9
0394b1c0: cmp      x9, x20
0394b1c4: b.ne     #0x394b1e4
0394b1c8: bl       #0x3ba7d80
0394b1cc: mov      x1, x0
0394b1d0: stur     x0, [x21, #0x28]
0394b1d4: add      x0, x21, #0x28
0394b1d8: bl       #0x172b1d8
0394b1dc: ldur     x8, [x21, #0x28]
0394b1e0: cbz      x8, #0x394b33c
0394b1e4: ldr      x8, [x8, #0x18]
0394b1e8: ldrb     w9, [x8, #0x18]
0394b1ec: adrp     x21, #0xed5e000
0394b1f0: ldr      x0, [x21, #0x5a0]
0394b1f4: cbnz     w9, #0x394b304
0394b1f8: ldr      x22, [x8, #0x20]
0394b1fc: ldr      w8, [x0, #0xe0]
0394b200: cbz      w8, #0x394b2ec
0394b204: ldr      x8, [x0, #0xb8]
0394b208: ldr      x8, [x8, #0x18]
0394b20c: cmp      x22, x8
0394b210: b.le     #0x394b304
0394b214: ldr      x8, [x19, #0x18]
0394b218: adds     x0, x8, #0x420
0394b21c: b.eq     #0x394b32c
0394b220: ldur     x21, [x19, #0x60]
0394b224: cbz      x21, #0x394b240
0394b228: ldr      x8, [x21, #0x10]
0394b22c: cmp      x8, x0
0394b230: b.ne     #0x394b240
0394b234: mov      w8, w8
0394b238: cmp      x8, x20
0394b23c: b.ne     #0x394b260
0394b240: mov      x1, #0
0394b244: bl       #0x3ba894c
0394b248: mov      x1, x0
0394b24c: stur     x0, [x19, #0x60]
0394b250: add      x0, x19, #0x60
0394b254: bl       #0x172b1d8
0394b258: ldur     x21, [x19, #0x60]
0394b25c: cbz      x21, #0x394b33c
0394b260: ldr      x8, [x21, #0x18]
0394b264: ldr      x0, [x8, #0x20]
0394b268: cbz      x0, #0x394b340
0394b26c: ldur     x8, [x21, #0x28]
0394b270: cbz      x8, #0x394b28c
0394b274: ldr      x9, [x8, #0x10]
0394b278: cmp      x9, x0
0394b27c: b.ne     #0x394b28c
0394b280: mov      w9, w9
0394b284: cmp      x9, x20
0394b288: b.ne     #0x394b2a8
0394b28c: bl       #0x3ba7d80
0394b290: mov      x1, x0
0394b294: stur     x0, [x21, #0x28]
0394b298: add      x0, x21, #0x28
0394b29c: bl       #0x172b1d8
0394b2a0: ldur     x8, [x21, #0x28]
0394b2a4: cbz      x8, #0x394b33c
0394b2a8: ldr      x8, [x8, #0x18]
0394b2ac: ldr      x0, [x8, #0x20]!
0394b2b0: ldp      x29, x30, [sp, #0x20]
0394b2b4: ldp      x20, x19, [sp, #0x10]
0394b2b8: ldp      x22, x21, [sp], #0x30
0394b2bc: ret      
0394b2c0: stur     xzr, [x21, #0x28]
0394b2c4: add      x0, x21, #0x28
0394b2c8: mov      x1, #0
0394b2cc: bl       #0x172b1d8
0394b2d0: adrp     x19, #0xed5e000
0394b2d4: ldr      x0, [x19, #0x5a0]
0394b2d8: ldr      w8, [x0, #0xe0]
0394b2dc: cbnz     w8, #0x394b314
0394b2e0: bl       #0x172b3a8
0394b2e4: ldr      x0, [x19, #0x5a0]
0394b2e8: b        #0x394b314
0394b2ec: bl       #0x172b3a8
0394b2f0: ldr      x0, [x21, #0x5a0]
0394b2f4: ldr      x8, [x0, #0xb8]
0394b2f8: ldr      x8, [x8, #0x18]
0394b2fc: cmp      x22, x8
0394b300: b.gt     #0x394b214
0394b304: ldr      w8, [x0, #0xe0]
0394b308: cbnz     w8, #0x394b314
0394b30c: bl       #0x172b3a8
0394b310: ldr      x0, [x21, #0x5a0]
0394b314: ldr      x8, [x0, #0xb8]
0394b318: ldr      x0, [x8, #0x18]!
0394b31c: ldp      x29, x30, [sp, #0x20]
0394b320: ldp      x20, x19, [sp, #0x10]
0394b324: ldp      x22, x21, [sp], #0x30
0394b328: ret      
0394b32c: stur     xzr, [x19, #0x60]
0394b330: add      x0, x19, #0x60
0394b334: mov      x1, #0
0394b338: bl       #0x172b1d8
0394b33c: bl       #0x172b4f8
0394b340: stur     xzr, [x21, #0x28]
0394b344: add      x0, x21, #0x28
0394b348: b        #0x394b334

; 04ee3298.asm -> 0x395c37c
0395c37c: stp      x20, x19, [sp, #-0x20]!
0395c380: stp      x29, x30, [sp, #0x10]
0395c384: add      x29, sp, #0x10
0395c388: mov      x19, x0
0395c38c: ldr      x8, [x0, #0x18]
0395c390: adds     x0, x8, #0x138
0395c394: b.eq     #0x395c3e4
0395c398: ldur     x8, [x19, #0x70]
0395c39c: cbz      x8, #0x395c3b8
0395c3a0: ldr      x9, [x8, #0x10]
0395c3a4: mov      w10, w9
0395c3a8: cmp      x9, x0
0395c3ac: mov      w9, #-0x22222223
0395c3b0: ccmp     x10, x9, #4, eq
0395c3b4: b.ne     #0x395c3d4
0395c3b8: mov      x1, #0
0395c3bc: bl       #0x3941d98
0395c3c0: mov      x1, x0
0395c3c4: stur     x0, [x19, #0x70]
0395c3c8: add      x0, x19, #0x70
0395c3cc: bl       #0x172b1d8
0395c3d0: ldur     x8, [x19, #0x70]
0395c3d4: mov      x0, x8
0395c3d8: ldp      x29, x30, [sp, #0x10]
0395c3dc: ldp      x20, x19, [sp], #0x20
0395c3e0: ret      
0395c3e4: stur     xzr, [x19, #0x70]
0395c3e8: add      x0, x19, #0x70
0395c3ec: mov      x1, #0
0395c3f0: bl       #0x172b1d8
0395c3f4: mov      x8, #0
0395c3f8: mov      x0, x8
0395c3fc: ldp      x29, x30, [sp, #0x10]
0395c400: ldp      x20, x19, [sp], #0x20
0395c404: ret      

; 04ee53e8.asm -> 0x3976740
03976740: ldr      x8, [x0, #0x18]
03976744: ldrb     w8, [x8, #0x28]
03976748: cmp      w8, #0
0397674c: cset     w0, ne
03976750: ret      

; 04ee53fc.asm -> 0x3976754
03976754: ldr      x8, [x0, #0x18]
03976758: ldr      w0, [x8, #0x2c]
0397675c: ret      

; 04ee5408.asm -> 0x3976760
03976760: ldr      x8, [x0, #0x18]
03976764: ldr      w0, [x8, #0x30]
03976768: ret      

; 04ee5780.asm -> 0x3976ad8
03976ad8: ldr      x8, [x0, #0x18]
03976adc: ldr      w0, [x8, #0x80]
03976ae0: ret      

; 04ee5ac8.asm -> 0x3976e20
03976e20: stp      x20, x19, [sp, #-0x20]!
03976e24: stp      x29, x30, [sp, #0x10]
03976e28: add      x29, sp, #0x10
03976e2c: mov      x19, x0
03976e30: ldr      x8, [x0, #0x18]
03976e34: ldr      x0, [x8, #0xb0]
03976e38: cbz      x0, #0x3976e88
03976e3c: ldur     x8, [x19, #0x80]
03976e40: cbz      x8, #0x3976e5c
03976e44: ldr      x9, [x8, #0x10]
03976e48: mov      w10, w9
03976e4c: cmp      x9, x0
03976e50: mov      w9, #-0x22222223
03976e54: ccmp     x10, x9, #4, eq
03976e58: b.ne     #0x3976e78
03976e5c: mov      x1, #0
03976e60: bl       #0x39932dc
03976e64: mov      x1, x0
03976e68: stur     x0, [x19, #0x80]
03976e6c: add      x0, x19, #0x80
03976e70: bl       #0x172b1d8
03976e74: ldur     x8, [x19, #0x80]
03976e78: mov      x0, x8
03976e7c: ldp      x29, x30, [sp, #0x10]
03976e80: ldp      x20, x19, [sp], #0x20
03976e84: ret      
03976e88: stur     xzr, [x19, #0x80]
03976e8c: add      x0, x19, #0x80
03976e90: mov      x1, #0
03976e94: bl       #0x172b1d8
03976e98: mov      x8, #0
03976e9c: mov      x0, x8
03976ea0: ldp      x29, x30, [sp, #0x10]
03976ea4: ldp      x20, x19, [sp], #0x20
03976ea8: ret      

; 04ee5be0.asm -> 0x3976f38
03976f38: stp      x20, x19, [sp, #-0x20]!
03976f3c: stp      x29, x30, [sp, #0x10]
03976f40: add      x29, sp, #0x10
03976f44: mov      x19, x0
03976f48: adrp     x20, #0xf276000
03976f4c: ldrb     w8, [x20, #0xc5a]
03976f50: tbnz     w8, #0, #0x3976f74
03976f54: adrp     x0, #0xee22000
03976f58: add      x0, x0, #8
03976f5c: bl       #0x172b24c
03976f60: adrp     x0, #0xed74000
03976f64: add      x0, x0, #0x100
03976f68: bl       #0x172b24c
03976f6c: mov      w8, #1
03976f70: strb     w8, [x20, #0xc5a]
03976f74: ldr      x8, [x19, #0x18]
03976f78: ldr      x20, [x8, #0xc0]
03976f7c: cbz      x20, #0x3976fe4
03976f80: ldr      x0, [x19, #0x90]!
03976f84: cbz      x0, #0x3976fa0
03976f88: ldr      x8, [x0, #0x10]
03976f8c: mov      w9, w8
03976f90: cmp      x8, x20
03976f94: mov      w8, #-0x22222223
03976f98: ccmp     x9, x8, #4, eq
03976f9c: b.ne     #0x3976fd8
03976fa0: adrp     x8, #0xed74000
03976fa4: ldr      x0, [x8, #0x100]
03976fa8: ldr      w8, [x0, #0xe0]
03976fac: cbnz     w8, #0x3976fb4
03976fb0: bl       #0x172b3a8
03976fb4: adrp     x8, #0xee22000
03976fb8: ldr      x1, [x8, #8]
03976fbc: mov      x0, x20
03976fc0: bl       #0xa9c76a0
03976fc4: mov      x1, x0
03976fc8: str      x0, [x19]
03976fcc: mov      x0, x19
03976fd0: bl       #0x172b1d8
03976fd4: ldr      x0, [x19]
03976fd8: ldp      x29, x30, [sp, #0x10]
03976fdc: ldp      x20, x19, [sp], #0x20
03976fe0: ret      
03976fe4: str      xzr, [x19, #0x90]!
03976fe8: mov      x0, x19
03976fec: mov      x1, #0
03976ff0: bl       #0x172b1d8
03976ff4: mov      x0, #0
03976ff8: ldp      x29, x30, [sp, #0x10]
03976ffc: ldp      x20, x19, [sp], #0x20
03977000: ret      

; 04ee5d38.asm -> 0x3977090
03977090: stp      x20, x19, [sp, #-0x20]!
03977094: stp      x29, x30, [sp, #0x10]
03977098: add      x29, sp, #0x10
0397709c: mov      x19, x0
039770a0: ldr      x8, [x0, #0x18]
039770a4: ldr      x0, [x8, #0xd0]
039770a8: cbz      x0, #0x39770f8
039770ac: ldur     x8, [x19, #0xa0]
039770b0: cbz      x8, #0x39770cc
039770b4: ldr      x9, [x8, #0x10]
039770b8: mov      w10, w9
039770bc: cmp      x9, x0
039770c0: mov      w9, #-0x22222223
039770c4: ccmp     x10, x9, #4, eq
039770c8: b.ne     #0x39770e8
039770cc: mov      x1, #0
039770d0: bl       #0x3932f38
039770d4: mov      x1, x0
039770d8: stur     x0, [x19, #0xa0]
039770dc: add      x0, x19, #0xa0
039770e0: bl       #0x172b1d8
039770e4: ldur     x8, [x19, #0xa0]
039770e8: mov      x0, x8
039770ec: ldp      x29, x30, [sp, #0x10]
039770f0: ldp      x20, x19, [sp], #0x20
039770f4: ret      
039770f8: stur     xzr, [x19, #0xa0]
039770fc: add      x0, x19, #0xa0
03977100: mov      x1, #0
03977104: bl       #0x172b1d8
03977108: mov      x8, #0
0397710c: mov      x0, x8
03977110: ldp      x29, x30, [sp, #0x10]
03977114: ldp      x20, x19, [sp], #0x20
03977118: ret      

; 04ee65e8-host-actor.asm -> 0x3977940
03977940: ldr      x8, [x19, #0x18]
03977944: ldr      x20, [x8, #0x148]
03977948: cbz      x20, #0x39779b0

; 04eea6a8.asm -> 0x397ba00
0397ba00: ldr      x8, [x0, #0x18]
0397ba04: ldr      w0, [x8, #0x18]
0397ba08: ret      

; 04eec4b8.asm -> 0x397d810
0397d810: stp      x20, x19, [sp, #-0x20]!
0397d814: stp      x29, x30, [sp, #0x10]
0397d818: add      x29, sp, #0x10
0397d81c: mov      x19, x0
0397d820: ldr      x8, [x0, #0x18]
0397d824: ldr      x8, [x8, #0xc8]
0397d828: cbz      x8, #0x397d894
0397d82c: mov      w20, #-0x22222223
0397d830: ldur     x0, [x19, #0x98]
0397d834: cbz      x0, #0x397d84c
0397d838: ldr      x9, [x0, #0x10]
0397d83c: mov      w10, w9
0397d840: cmp      x9, x8
0397d844: ccmp     x10, x20, #4, eq
0397d848: b.ne     #0x397d874
0397d84c: mov      x0, x8
0397d850: mov      x1, #0
0397d854: bl       #0x3924ed4
0397d858: mov      x1, x0
0397d85c: stur     x0, [x19, #0x98]
0397d860: add      x0, x19, #0x98
0397d864: bl       #0x172b1d8
0397d868: ldur     x0, [x19, #0x98]
0397d86c: cbz      x0, #0x397d888
0397d870: ldr      x8, [x0, #0x10]
0397d874: mov      w9, w8
0397d878: cmp      x8, #0
0397d87c: ccmp     x9, x20, #4, ne
0397d880: b.ne     #0x397d8b4
0397d884: mov      w0, #0
0397d888: ldp      x29, x30, [sp, #0x10]
0397d88c: ldp      x20, x19, [sp], #0x20
0397d890: ret      
0397d894: stur     xzr, [x19, #0x98]
0397d898: add      x0, x19, #0x98
0397d89c: mov      x1, #0
0397d8a0: bl       #0x172b1d8
0397d8a4: mov      w0, #0
0397d8a8: ldp      x29, x30, [sp, #0x10]
0397d8ac: ldp      x20, x19, [sp], #0x20
0397d8b0: ret      
0397d8b4: ldr      x9, [x19, #0x18]
0397d8b8: ldr      x9, [x9, #0xc8]
0397d8bc: cbz      x9, #0x397d924
0397d8c0: cmp      x8, x9
0397d8c4: b.eq     #0x397d8ec
0397d8c8: mov      x0, x9
0397d8cc: mov      x1, #0
0397d8d0: bl       #0x3924ed4
0397d8d4: mov      x1, x0
0397d8d8: stur     x0, [x19, #0x98]
0397d8dc: add      x0, x19, #0x98
0397d8e0: bl       #0x172b1d8
0397d8e4: ldur     x0, [x19, #0x98]
0397d8e8: cbz      x0, #0x397d934
0397d8ec: mov      x1, #0
0397d8f0: bl       #0x3925474
0397d8f4: cbz      x0, #0x397d888
0397d8f8: ldr      x8, [x0, #0x10]
0397d8fc: cbz      x8, #0x397d914
0397d900: cmp      x20, w8, uxtw
0397d904: cset     w0, ne
0397d908: ldp      x29, x30, [sp, #0x10]
0397d90c: ldp      x20, x19, [sp], #0x20
0397d910: ret      
0397d914: mov      w0, #0
0397d918: ldp      x29, x30, [sp, #0x10]
0397d91c: ldp      x20, x19, [sp], #0x20
0397d920: ret      
0397d924: stur     xzr, [x19, #0x98]
0397d928: add      x0, x19, #0x98
0397d92c: mov      x1, #0
0397d930: bl       #0x172b1d8
0397d934: bl       #0x172b4f8

; 04eee6e8.asm -> 0x397fa40
0397fa40: stp      x20, x19, [sp, #-0x20]!
0397fa44: stp      x29, x30, [sp, #0x10]
0397fa48: add      x29, sp, #0x10
0397fa4c: mov      x19, x0
0397fa50: adrp     x20, #0xf1f4000
0397fa54: ldrb     w8, [x20, #0x3ee]
0397fa58: tbnz     w8, #0, #0x397fa70
0397fa5c: adrp     x0, #0xed68000
0397fa60: add      x0, x0, #0x880
0397fa64: bl       #0x172b24c
0397fa68: mov      w8, #1
0397fa6c: strb     w8, [x20, #0x3ee]
0397fa70: ldr      x19, [x19, #0x10]
0397fa74: adrp     x8, #0xed68000
0397fa78: ldr      x0, [x8, #0x880]
0397fa7c: ldr      w8, [x0, #0xe0]
0397fa80: cbnz     w8, #0x397fa88
0397fa84: bl       #0x172b3a8
0397fa88: mov      x0, x19
0397fa8c: bl       #0x7c0f3e8
0397fa90: cmp      w0, #0
0397fa94: cset     w0, ne
0397fa98: ldp      x29, x30, [sp, #0x10]
0397fa9c: ldp      x20, x19, [sp], #0x20
0397faa0: ret      

; 04eeebac-ward-classification.asm -> 0x397ff04
0397ff04: ldrb     w0, [x19, #0x158]
0397ff08: ldp      x29, x30, [sp, #0x10]
0397ff0c: ldp      x20, x19, [sp], #0x20
0397ff10: ret      
0397ff14: stp      x20, x19, [sp, #-0x20]!
0397ff18: stp      x29, x30, [sp, #0x10]
0397ff1c: add      x29, sp, #0x10
0397ff20: mov      x19, x0
0397ff24: adrp     x20, #0xf1f4000
0397ff28: ldrb     w8, [x20, #0x3f9]
0397ff2c: tbnz     w8, #0, #0x397ff44
0397ff30: adrp     x0, #0xed68000
0397ff34: add      x0, x0, #0x880
0397ff38: bl       #0x172b24c
0397ff3c: mov      w8, #1
0397ff40: strb     w8, [x20, #0x3f9]
0397ff44: ldr      x19, [x19, #0x10]
0397ff48: adrp     x8, #0xed68000
0397ff4c: ldr      x0, [x8, #0x880]
0397ff50: ldr      w8, [x0, #0xe0]
0397ff54: cbnz     w8, #0x397ff5c

; 04ef9844.asm -> 0x398ab9c
0398ab9c: stp      x20, x19, [sp, #-0x20]!
0398aba0: stp      x29, x30, [sp, #0x10]
0398aba4: add      x29, sp, #0x10
0398aba8: mov      x19, x0
0398abac: ldr      x8, [x0, #0x18]
0398abb0: ldr      x0, [x8, #0x170]
0398abb4: cbz      x0, #0x398ac04
0398abb8: ldr      x8, [x19, #0x198]
0398abbc: cbz      x8, #0x398abd8
0398abc0: ldr      x9, [x8, #0x10]
0398abc4: mov      w10, w9
0398abc8: cmp      x9, x0
0398abcc: mov      w9, #-0x22222223
0398abd0: ccmp     x10, x9, #4, eq
0398abd4: b.ne     #0x398abf4
0398abd8: mov      x1, #0
0398abdc: bl       #0x3a370e4
0398abe0: mov      x1, x0
0398abe4: str      x0, [x19, #0x198]
0398abe8: add      x0, x19, #0x198
0398abec: bl       #0x172b1d8
0398abf0: ldr      x8, [x19, #0x198]
0398abf4: mov      x0, x8
0398abf8: ldp      x29, x30, [sp, #0x10]
0398abfc: ldp      x20, x19, [sp], #0x20
0398ac00: ret      
0398ac04: str      xzr, [x19, #0x198]
0398ac08: add      x0, x19, #0x198
0398ac0c: mov      x1, #0
0398ac10: bl       #0x172b1d8
0398ac14: mov      x8, #0
0398ac18: mov      x0, x8
0398ac1c: ldp      x29, x30, [sp, #0x10]
0398ac20: ldp      x20, x19, [sp], #0x20
0398ac24: ret      

; 04ef995c.asm -> 0x398acb4
0398acb4: stp      x20, x19, [sp, #-0x20]!
0398acb8: stp      x29, x30, [sp, #0x10]
0398acbc: add      x29, sp, #0x10
0398acc0: mov      x19, x0
0398acc4: ldr      x8, [x0, #0x18]
0398acc8: ldr      x0, [x8, #0x180]
0398accc: cbz      x0, #0x398ad1c
0398acd0: ldr      x8, [x19, #0x1a8]
0398acd4: cbz      x8, #0x398acf0
0398acd8: ldr      x9, [x8, #0x10]
0398acdc: mov      w10, w9
0398ace0: cmp      x9, x0
0398ace4: mov      w9, #-0x22222223
0398ace8: ccmp     x10, x9, #4, eq
0398acec: b.ne     #0x398ad0c
0398acf0: mov      x1, #0
0398acf4: bl       #0x3a112fc
0398acf8: mov      x1, x0
0398acfc: str      x0, [x19, #0x1a8]
0398ad00: add      x0, x19, #0x1a8
0398ad04: bl       #0x172b1d8
0398ad08: ldr      x8, [x19, #0x1a8]
0398ad0c: mov      x0, x8
0398ad10: ldp      x29, x30, [sp, #0x10]
0398ad14: ldp      x20, x19, [sp], #0x20
0398ad18: ret      
0398ad1c: str      xzr, [x19, #0x1a8]
0398ad20: add      x0, x19, #0x1a8
0398ad24: mov      x1, #0
0398ad28: bl       #0x172b1d8
0398ad2c: mov      x8, #0
0398ad30: mov      x0, x8
0398ad34: ldp      x29, x30, [sp, #0x10]
0398ad38: ldp      x20, x19, [sp], #0x20
0398ad3c: ret      

; 04f81308.asm -> 0x39f9840
039f9840: ldr      x8, [x0, #0x18]
039f9844: ldr      w0, [x8, #0x18]
039f9848: ret      

; 04f81314.asm -> 0x39f984c
039f984c: stp      x20, x19, [sp, #-0x20]!
039f9850: stp      x29, x30, [sp, #0x10]
039f9854: add      x29, sp, #0x10
039f9858: mov      x19, x0
039f985c: ldr      x8, [x0, #0x18]
039f9860: ldr      x0, [x8, #0x20]
039f9864: cbz      x0, #0x39f98b4
039f9868: ldur     x8, [x19, #0x20]
039f986c: cbz      x8, #0x39f9888
039f9870: ldr      x9, [x8, #0x10]
039f9874: mov      w10, w9
039f9878: cmp      x9, x0
039f987c: mov      w9, #-0x22222223
039f9880: ccmp     x10, x9, #4, eq
039f9884: b.ne     #0x39f98a4
039f9888: mov      x1, #0
039f988c: bl       #0x39fa588
039f9890: mov      x1, x0
039f9894: stur     x0, [x19, #0x20]
039f9898: add      x0, x19, #0x20
039f989c: bl       #0x172b1d8
039f98a0: ldur     x8, [x19, #0x20]
039f98a4: mov      x0, x8
039f98a8: ldp      x29, x30, [sp, #0x10]
039f98ac: ldp      x20, x19, [sp], #0x20
039f98b0: ret      
039f98b4: stur     xzr, [x19, #0x20]
039f98b8: add      x0, x19, #0x20
039f98bc: mov      x1, #0
039f98c0: bl       #0x172b1d8
039f98c4: mov      x8, #0
039f98c8: mov      x0, x8
039f98cc: ldp      x29, x30, [sp, #0x10]
039f98d0: ldp      x20, x19, [sp], #0x20
039f98d4: ret      

; 04f82550.asm -> 0x39faa88
039faa88: ldr      x9, [x0, #0x18]
039faa8c: ldur     q0, [x9, #0x18]
039faa90: str      q0, [x8]
039faa94: ldr      x9, [x9, #0x28]
039faa98: str      x9, [x8, #0x10]
039faa9c: ret      

; 0512c6c4.asm -> 0x3ba7d80
03ba7d80: sub      sp, sp, #0x40
03ba7d84: stp      x22, x21, [sp, #0x10]
03ba7d88: stp      x20, x19, [sp, #0x20]
03ba7d8c: stp      x29, x30, [sp, #0x30]
03ba7d90: add      x29, sp, #0x30
03ba7d94: mov      x19, x0
03ba7d98: adrp     x20, #0xf1f5000
03ba7d9c: ldrb     w8, [x20, #0x525]
03ba7da0: tbz      w8, #0, #0x3ba7e08
03ba7da4: adrp     x21, #0xed70000
03ba7da8: ldr      x8, [x21, #0xf80]
03ba7dac: ldr      x8, [x8, #0xb8]
03ba7db0: ldr      x8, [x8]
03ba7db4: cbz      x8, #0x3ba7e84
03ba7db8: cbz      x19, #0x3ba7ef4
03ba7dbc: mov      w8, #-0x22222223
03ba7dc0: cmp      w19, w8
03ba7dc4: b.ne     #0x3ba7f10
03ba7dc8: adrp     x8, #0xed76000
03ba7dcc: ldr      x0, [x8, #0x9e8]
03ba7dd0: ldr      w8, [x0, #0xe0]
03ba7dd4: cbnz     w8, #0x3ba7ddc
03ba7dd8: bl       #0x172b3a8
03ba7ddc: adrp     x8, #0xee7a000
03ba7de0: ldr      x0, [x8, #0x770]
03ba7de4: mov      x1, #0
03ba7de8: bl       #0x82daed0
03ba7dec: mov      x20, #0
03ba7df0: mov      x0, x20
03ba7df4: ldp      x29, x30, [sp, #0x30]
03ba7df8: ldp      x20, x19, [sp, #0x20]
03ba7dfc: ldp      x22, x21, [sp, #0x10]
03ba7e00: add      sp, sp, #0x40
03ba7e04: ret      
03ba7e08: adrp     x0, #0xed91000
03ba7e0c: add      x0, x0, #0xee0
03ba7e10: bl       #0x172b24c
03ba7e14: adrp     x0, #0xed91000
03ba7e18: add      x0, x0, #0xee8
03ba7e1c: bl       #0x172b24c
03ba7e20: adrp     x0, #0xed91000
03ba7e24: add      x0, x0, #0xec0
03ba7e28: bl       #0x172b24c
03ba7e2c: adrp     x0, #0xed40000
03ba7e30: add      x0, x0, #0xd90
03ba7e34: bl       #0x172b24c
03ba7e38: adrp     x0, #0xed70000
03ba7e3c: add      x0, x0, #0xf80
03ba7e40: bl       #0x172b24c
03ba7e44: adrp     x0, #0xedb6000
03ba7e48: add      x0, x0, #0x2f0
03ba7e4c: bl       #0x172b24c
03ba7e50: adrp     x0, #0xed76000
03ba7e54: add      x0, x0, #0x9e8
03ba7e58: bl       #0x172b24c
03ba7e5c: adrp     x0, #0xee7a000
03ba7e60: add      x0, x0, #0x770
03ba7e64: bl       #0x172b24c
03ba7e68: mov      w8, #1
03ba7e6c: strb     w8, [x20, #0x525]
03ba7e70: adrp     x21, #0xed70000
03ba7e74: ldr      x8, [x21, #0xf80]
03ba7e78: ldr      x8, [x8, #0xb8]
03ba7e7c: ldr      x8, [x8]
03ba7e80: cbnz     x8, #0x3ba7db8
03ba7e84: adrp     x8, #0xed40000
03ba7e88: ldr      x0, [x8, #0xd90]
03ba7e8c: bl       #0x172b4e4
03ba7e90: mov      x20, x0
03ba7e94: adrp     x8, #0xed91000
03ba7e98: ldr      x8, [x8, #0xec0]
03ba7e9c: ldr      x8, [x8, #0x20]
03ba7ea0: ldr      x0, [x8, #0xc0]
03ba7ea4: mov      w1, #0
03ba7ea8: bl       #0x172c164
03ba7eac: ldr      x8, [x0, #0x20]
03ba7eb0: ldr      x0, [x8, #0xc0]
03ba7eb4: mov      w1, #3
03ba7eb8: bl       #0x172c164
03ba7ebc: bl       #0xa7bcd48
03ba7ec0: cbz      x0, #0x3ba7ed4
03ba7ec4: mov      x0, x20
03ba7ec8: str      xzr, [x0, #0x30]!
03ba7ecc: mov      x1, #0
03ba7ed0: bl       #0x172b1d8
03ba7ed4: ldr      x8, [x21, #0xf80]
03ba7ed8: ldr      x8, [x8, #0xb8]
03ba7edc: str      x20, [x8]
03ba7ee0: ldr      x8, [x21, #0xf80]
03ba7ee4: ldr      x0, [x8, #0xb8]
03ba7ee8: mov      x1, x20
03ba7eec: bl       #0x172b1d8
03ba7ef0: cbnz     x19, #0x3ba7dbc
03ba7ef4: mov      x20, #0
03ba7ef8: mov      x0, x20
03ba7efc: ldp      x29, x30, [sp, #0x30]
03ba7f00: ldp      x20, x19, [sp, #0x20]
03ba7f04: ldp      x22, x21, [sp, #0x10]
03ba7f08: add      sp, sp, #0x40
03ba7f0c: ret      
03ba7f10: ldr      x8, [x21, #0xf80]
03ba7f14: ldr      x8, [x8, #0xb8]
03ba7f18: ldr      x20, [x8]
03ba7f1c: cbz      x20, #0x3ba8050
03ba7f20: adrp     x8, #0xed91000
03ba7f24: ldr      x8, [x8, #0xee0]
03ba7f28: ldr      x8, [x8, #0x20]
03ba7f2c: ldr      x0, [x8, #0xc0]
03ba7f30: mov      w1, #0x1f
03ba7f34: bl       #0x172c164
03ba7f38: mov      x2, x0
03ba7f3c: mov      x0, x20
03ba7f40: mov      x1, x19
03ba7f44: bl       #0xbb28ad0
03ba7f48: tbnz     w0, #0x1f, #0x3ba7fa0
03ba7f4c: ldr      x8, [x20, #0x18]
03ba7f50: cbz      x8, #0x3ba8050
03ba7f54: ldr      w9, [x8, #0x18]
03ba7f58: cmp      w0, w9
03ba7f5c: b.hs     #0x3ba8054
03ba7f60: mov      w9, #0x18
03ba7f64: umaddl   x8, w0, w9, x8
03ba7f68: ldr      x1, [x8, #0x30]
03ba7f6c: str      x1, [sp, #8]
03ba7f70: add      x0, sp, #8
03ba7f74: bl       #0x172b1d8
03ba7f78: ldr      x20, [sp, #8]
03ba7f7c: ldr      x0, [x21, #0xf80]
03ba7f80: cbz      x20, #0x3ba7f90
03ba7f84: ldr      x9, [x20]
03ba7f88: cmp      x9, x0
03ba7f8c: b.eq     #0x3ba7df0
03ba7f90: ldr      x8, [x0, #0xb8]
03ba7f94: ldr      x8, [x8, #8]
03ba7f98: cbnz     x8, #0x3ba7fb4
03ba7f9c: b        #0x3ba8028
03ba7fa0: str      xzr, [sp, #8]
03ba7fa4: ldr      x0, [x21, #0xf80]
03ba7fa8: ldr      x8, [x0, #0xb8]
03ba7fac: ldr      x8, [x8, #8]
03ba7fb0: cbz      x8, #0x3ba8028
03ba7fb4: ldr      w9, [x8, #0x18]
03ba7fb8: cmp      w9, #1
03ba7fbc: b.lt     #0x3ba8028
03ba7fc0: adrp     x9, #0xedb6000
03ba7fc4: ldr      x1, [x9, #0x2f0]
03ba7fc8: mov      x0, x8
03ba7fcc: bl       #0xb507668
03ba7fd0: cbz      x0, #0x3ba8050
03ba7fd4: ldr      x9, [x21, #0xf80]
03ba7fd8: ldr      x8, [x0]
03ba7fdc: cmp      x8, x9
03ba7fe0: b.ne     #0x3ba8050
03ba7fe4: stp      x19, x19, [x0, #0x10]
03ba7fe8: mov      x20, x0
03ba7fec: ldr      x9, [x9, #0xb8]
03ba7ff0: ldr      x0, [x9]
03ba7ff4: cbz      x0, #0x3ba8050
03ba7ff8: adrp     x9, #0xed91000
03ba7ffc: ldr      x4, [x9, #0xee8]
03ba8000: mov      x1, x19
03ba8004: mov      x2, x20
03ba8008: mov      w3, #1
03ba800c: bl       #0xbb28ecc
03ba8010: mov      x0, x20
03ba8014: ldp      x29, x30, [sp, #0x30]
03ba8018: ldp      x20, x19, [sp, #0x20]
03ba801c: ldp      x22, x21, [sp, #0x10]
03ba8020: add      sp, sp, #0x40
03ba8024: ret      
03ba8028: bl       #0x172b4e4
03ba802c: mov      x20, x0
03ba8030: mov      x1, x19
03ba8034: bl       #0x3ba8058
03ba8038: mov      x0, x20
03ba803c: ldp      x29, x30, [sp, #0x30]
03ba8040: ldp      x20, x19, [sp, #0x20]
03ba8044: ldp      x22, x21, [sp, #0x10]
03ba8048: add      sp, sp, #0x40
03ba804c: ret      
03ba8050: bl       #0x172b4f8
03ba8054: bl       #0x172b504

; 0512cb80.asm -> 0x3ba823c
03ba823c: ldr      x8, [x0, #0x18]
03ba8240: ldr      x0, [x8, #0x20]
03ba8244: ret      

; 0512d290.asm -> 0x3ba894c
03ba894c: sub      sp, sp, #0x40
03ba8950: stp      x22, x21, [sp, #0x10]
03ba8954: stp      x20, x19, [sp, #0x20]
03ba8958: stp      x29, x30, [sp, #0x30]
03ba895c: add      x29, sp, #0x30
03ba8960: mov      x19, x0
03ba8964: adrp     x20, #0xf1f5000
03ba8968: ldrb     w8, [x20, #0x52e]
03ba896c: tbz      w8, #0, #0x3ba89d4
03ba8970: adrp     x21, #0xed70000
03ba8974: ldr      x8, [x21, #0xf98]
03ba8978: ldr      x8, [x8, #0xb8]
03ba897c: ldr      x8, [x8]
03ba8980: cbz      x8, #0x3ba8a50
03ba8984: cbz      x19, #0x3ba8ac0
03ba8988: mov      w8, #-0x22222223
03ba898c: cmp      w19, w8
03ba8990: b.ne     #0x3ba8adc
03ba8994: adrp     x8, #0xed76000
03ba8998: ldr      x0, [x8, #0x9e8]
03ba899c: ldr      w8, [x0, #0xe0]
03ba89a0: cbnz     w8, #0x3ba89a8
03ba89a4: bl       #0x172b3a8
03ba89a8: adrp     x8, #0xee7a000
03ba89ac: ldr      x0, [x8, #0x778]
03ba89b0: mov      x1, #0
03ba89b4: bl       #0x82daed0
03ba89b8: mov      x20, #0
03ba89bc: mov      x0, x20
03ba89c0: ldp      x29, x30, [sp, #0x30]
03ba89c4: ldp      x20, x19, [sp, #0x20]
03ba89c8: ldp      x22, x21, [sp, #0x10]
03ba89cc: add      sp, sp, #0x40
03ba89d0: ret      
03ba89d4: adrp     x0, #0xed91000
03ba89d8: add      x0, x0, #0xee0
03ba89dc: bl       #0x172b24c
03ba89e0: adrp     x0, #0xed91000
03ba89e4: add      x0, x0, #0xee8
03ba89e8: bl       #0x172b24c
03ba89ec: adrp     x0, #0xed91000
03ba89f0: add      x0, x0, #0xec0
03ba89f4: bl       #0x172b24c
03ba89f8: adrp     x0, #0xed40000
03ba89fc: add      x0, x0, #0xd90
03ba8a00: bl       #0x172b24c
03ba8a04: adrp     x0, #0xed70000
03ba8a08: add      x0, x0, #0xf98
03ba8a0c: bl       #0x172b24c
03ba8a10: adrp     x0, #0xedb6000
03ba8a14: add      x0, x0, #0x2f0
03ba8a18: bl       #0x172b24c
03ba8a1c: adrp     x0, #0xed76000
03ba8a20: add      x0, x0, #0x9e8
03ba8a24: bl       #0x172b24c
03ba8a28: adrp     x0, #0xee7a000
03ba8a2c: add      x0, x0, #0x778
03ba8a30: bl       #0x172b24c
03ba8a34: mov      w8, #1
03ba8a38: strb     w8, [x20, #0x52e]
03ba8a3c: adrp     x21, #0xed70000
03ba8a40: ldr      x8, [x21, #0xf98]
03ba8a44: ldr      x8, [x8, #0xb8]
03ba8a48: ldr      x8, [x8]
03ba8a4c: cbnz     x8, #0x3ba8984
03ba8a50: adrp     x8, #0xed40000
03ba8a54: ldr      x0, [x8, #0xd90]
03ba8a58: bl       #0x172b4e4
03ba8a5c: mov      x20, x0
03ba8a60: adrp     x8, #0xed91000
03ba8a64: ldr      x8, [x8, #0xec0]
03ba8a68: ldr      x8, [x8, #0x20]
03ba8a6c: ldr      x0, [x8, #0xc0]
03ba8a70: mov      w1, #0
03ba8a74: bl       #0x172c164
03ba8a78: ldr      x8, [x0, #0x20]
03ba8a7c: ldr      x0, [x8, #0xc0]
03ba8a80: mov      w1, #3
03ba8a84: bl       #0x172c164
03ba8a88: bl       #0xa7bcd48
03ba8a8c: cbz      x0, #0x3ba8aa0
03ba8a90: mov      x0, x20
03ba8a94: str      xzr, [x0, #0x30]!
03ba8a98: mov      x1, #0
03ba8a9c: bl       #0x172b1d8
03ba8aa0: ldr      x8, [x21, #0xf98]
03ba8aa4: ldr      x8, [x8, #0xb8]
03ba8aa8: str      x20, [x8]
03ba8aac: ldr      x8, [x21, #0xf98]
03ba8ab0: ldr      x0, [x8, #0xb8]
03ba8ab4: mov      x1, x20
03ba8ab8: bl       #0x172b1d8
03ba8abc: cbnz     x19, #0x3ba8988
03ba8ac0: mov      x20, #0
03ba8ac4: mov      x0, x20
03ba8ac8: ldp      x29, x30, [sp, #0x30]
03ba8acc: ldp      x20, x19, [sp, #0x20]
03ba8ad0: ldp      x22, x21, [sp, #0x10]
03ba8ad4: add      sp, sp, #0x40
03ba8ad8: ret      
03ba8adc: ldr      x8, [x21, #0xf98]
03ba8ae0: ldr      x8, [x8, #0xb8]
03ba8ae4: ldr      x20, [x8]
03ba8ae8: cbz      x20, #0x3ba8c1c
03ba8aec: adrp     x8, #0xed91000
03ba8af0: ldr      x8, [x8, #0xee0]
03ba8af4: ldr      x8, [x8, #0x20]
03ba8af8: ldr      x0, [x8, #0xc0]
03ba8afc: mov      w1, #0x1f
03ba8b00: bl       #0x172c164
03ba8b04: mov      x2, x0
03ba8b08: mov      x0, x20
03ba8b0c: mov      x1, x19
03ba8b10: bl       #0xbb28ad0
03ba8b14: tbnz     w0, #0x1f, #0x3ba8b6c
03ba8b18: ldr      x8, [x20, #0x18]
03ba8b1c: cbz      x8, #0x3ba8c1c
03ba8b20: ldr      w9, [x8, #0x18]
03ba8b24: cmp      w0, w9
03ba8b28: b.hs     #0x3ba8c20
03ba8b2c: mov      w9, #0x18
03ba8b30: umaddl   x8, w0, w9, x8
03ba8b34: ldr      x1, [x8, #0x30]
03ba8b38: str      x1, [sp, #8]
03ba8b3c: add      x0, sp, #8
03ba8b40: bl       #0x172b1d8
03ba8b44: ldr      x20, [sp, #8]
03ba8b48: ldr      x0, [x21, #0xf98]
03ba8b4c: cbz      x20, #0x3ba8b5c
03ba8b50: ldr      x9, [x20]
03ba8b54: cmp      x9, x0
03ba8b58: b.eq     #0x3ba89bc
03ba8b5c: ldr      x8, [x0, #0xb8]
03ba8b60: ldr      x8, [x8, #8]
03ba8b64: cbnz     x8, #0x3ba8b80
03ba8b68: b        #0x3ba8bf4
03ba8b6c: str      xzr, [sp, #8]
03ba8b70: ldr      x0, [x21, #0xf98]
03ba8b74: ldr      x8, [x0, #0xb8]
03ba8b78: ldr      x8, [x8, #8]
03ba8b7c: cbz      x8, #0x3ba8bf4
03ba8b80: ldr      w9, [x8, #0x18]
03ba8b84: cmp      w9, #1
03ba8b88: b.lt     #0x3ba8bf4
03ba8b8c: adrp     x9, #0xedb6000
03ba8b90: ldr      x1, [x9, #0x2f0]
03ba8b94: mov      x0, x8
03ba8b98: bl       #0xb507668
03ba8b9c: cbz      x0, #0x3ba8c1c
03ba8ba0: ldr      x9, [x21, #0xf98]
03ba8ba4: ldr      x8, [x0]
03ba8ba8: cmp      x8, x9
03ba8bac: b.ne     #0x3ba8c1c
03ba8bb0: stp      x19, x19, [x0, #0x10]
03ba8bb4: mov      x20, x0
03ba8bb8: ldr      x9, [x9, #0xb8]
03ba8bbc: ldr      x0, [x9]
03ba8bc0: cbz      x0, #0x3ba8c1c
03ba8bc4: adrp     x9, #0xed91000
03ba8bc8: ldr      x4, [x9, #0xee8]
03ba8bcc: mov      x1, x19
03ba8bd0: mov      x2, x20
03ba8bd4: mov      w3, #1
03ba8bd8: bl       #0xbb28ecc
03ba8bdc: mov      x0, x20
03ba8be0: ldp      x29, x30, [sp, #0x30]
03ba8be4: ldp      x20, x19, [sp, #0x20]
03ba8be8: ldp      x22, x21, [sp, #0x10]
03ba8bec: add      sp, sp, #0x40
03ba8bf0: ret      
03ba8bf4: bl       #0x172b4e4
03ba8bf8: mov      x20, x0
03ba8bfc: mov      x1, x19
03ba8c00: bl       #0x3ba8c24
03ba8c04: mov      x0, x20
03ba8c08: ldp      x29, x30, [sp, #0x30]
03ba8c0c: ldp      x20, x19, [sp, #0x20]
03ba8c10: ldp      x22, x21, [sp, #0x10]
03ba8c14: add      sp, sp, #0x40
03ba8c18: ret      
03ba8c1c: bl       #0x172b4f8
03ba8c20: bl       #0x172b504

; 0512d7f0.asm -> 0x3ba8eac
03ba8eac: stp      x20, x19, [sp, #-0x20]!
03ba8eb0: stp      x29, x30, [sp, #0x10]
03ba8eb4: add      x29, sp, #0x10
03ba8eb8: mov      x19, x0
03ba8ebc: ldr      x8, [x0, #0x18]
03ba8ec0: ldr      x0, [x8, #0x20]
03ba8ec4: cbz      x0, #0x3ba8f10
03ba8ec8: ldur     x8, [x19, #0x28]
03ba8ecc: cbz      x8, #0x3ba8ee8
03ba8ed0: ldr      x9, [x8, #0x10]
03ba8ed4: mov      w10, w9
03ba8ed8: cmp      x9, x0
03ba8edc: mov      w9, #-0x22222223
03ba8ee0: ccmp     x10, x9, #4, eq
03ba8ee4: b.ne     #0x3ba8f00
03ba8ee8: bl       #0x3ba7d80
03ba8eec: mov      x1, x0
03ba8ef0: stur     x0, [x19, #0x28]
03ba8ef4: add      x0, x19, #0x28
03ba8ef8: bl       #0x172b1d8
03ba8efc: ldur     x8, [x19, #0x28]
03ba8f00: mov      x0, x8
03ba8f04: ldp      x29, x30, [sp, #0x10]
03ba8f08: ldp      x20, x19, [sp], #0x20
03ba8f0c: ret      
03ba8f10: stur     xzr, [x19, #0x28]
03ba8f14: add      x0, x19, #0x28
03ba8f18: mov      x1, #0
03ba8f1c: bl       #0x172b1d8
03ba8f20: mov      x8, #0
03ba8f24: mov      x0, x8
03ba8f28: ldp      x29, x30, [sp, #0x10]
03ba8f2c: ldp      x20, x19, [sp], #0x20
03ba8f30: ret      

; 05146a6c.asm -> 0x3bd7db8
03bd7db8: ldr      x8, [x0, #0x18]
03bd7dbc: ldr      w0, [x8, #0x18]
03bd7dc0: ret      

; 05146ca4.asm -> 0x3bd7ff0
03bd7ff0: stp      x20, x19, [sp, #-0x20]!
03bd7ff4: stp      x29, x30, [sp, #0x10]
03bd7ff8: add      x29, sp, #0x10
03bd7ffc: mov      x19, x0
03bd8000: adrp     x20, #0xf276000
03bd8004: ldrb     w8, [x20, #0xcf5]
03bd8008: tbnz     w8, #0, #0x3bd802c
03bd800c: adrp     x0, #0xee22000
03bd8010: add      x0, x0, #0x40
03bd8014: bl       #0x172b24c
03bd8018: adrp     x0, #0xed74000
03bd801c: add      x0, x0, #0x100
03bd8020: bl       #0x172b24c
03bd8024: mov      w8, #1
03bd8028: strb     w8, [x20, #0xcf5]
03bd802c: ldr      x8, [x19, #0x18]
03bd8030: ldr      x20, [x8, #0x98]
03bd8034: cbz      x20, #0x3bd809c
03bd8038: ldr      x0, [x19, #0x38]!
03bd803c: cbz      x0, #0x3bd8058
03bd8040: ldr      x8, [x0, #0x10]
03bd8044: mov      w9, w8
03bd8048: cmp      x8, x20
03bd804c: mov      w8, #-0x22222223
03bd8050: ccmp     x9, x8, #4, eq
03bd8054: b.ne     #0x3bd8090
03bd8058: adrp     x8, #0xed74000
03bd805c: ldr      x0, [x8, #0x100]
03bd8060: ldr      w8, [x0, #0xe0]
03bd8064: cbnz     w8, #0x3bd806c
03bd8068: bl       #0x172b3a8
03bd806c: adrp     x8, #0xee22000
03bd8070: ldr      x1, [x8, #0x40]
03bd8074: mov      x0, x20
03bd8078: bl       #0xa9c76a0
03bd807c: mov      x1, x0
03bd8080: str      x0, [x19]
03bd8084: mov      x0, x19
03bd8088: bl       #0x172b1d8
03bd808c: ldr      x0, [x19]
03bd8090: ldp      x29, x30, [sp, #0x10]
03bd8094: ldp      x20, x19, [sp], #0x20
03bd8098: ret      
03bd809c: str      xzr, [x19, #0x38]!
03bd80a0: mov      x0, x19
03bd80a4: mov      x1, #0
03bd80a8: bl       #0x172b1d8
03bd80ac: mov      x0, #0
03bd80b0: ldp      x29, x30, [sp, #0x10]
03bd80b4: ldp      x20, x19, [sp], #0x20
03bd80b8: ret      

; 0514a0c4.asm -> 0x3bdb410
03bdb410: ldr      x8, [x0, #0x18]
03bdb414: ldr      w0, [x8, #0x18]
03bdb418: ret      

; 0514a328.asm -> 0x3bdb674
03bdb674: ldr      x8, [x0, #0x18]
03bdb678: ldrb     w8, [x8, #0x18]
03bdb67c: ubfx     w0, w8, #6, #1
03bdb680: ret      

; 0514a338.asm -> 0x3bdb684
03bdb684: ldr      x8, [x0, #0x18]
03bdb688: ldrb     w8, [x8, #0x18]
03bdb68c: ubfx     w0, w8, #5, #1
03bdb690: ret      

; 0514a348.asm -> 0x3bdb694
03bdb694: ldr      x8, [x0, #0x18]
03bdb698: ldr      w8, [x8, #0x18]
03bdb69c: mov      w9, #0x50
03bdb6a0: and      w8, w8, w9
03bdb6a4: cmp      w8, #0x40
03bdb6a8: cset     w0, eq
03bdb6ac: ret      

; 0514a364.asm -> 0x3bdb6b0
03bdb6b0: ldr      x8, [x0, #0x18]
03bdb6b4: ldrb     w8, [x8, #0x18]
03bdb6b8: ubfx     w0, w8, #4, #1
03bdb6bc: ret      

; 0514a374.asm -> 0x3bdb6c0
03bdb6c0: ldr      x8, [x0, #0x18]
03bdb6c4: ldrb     w8, [x8, #0x19]
03bdb6c8: ubfx     w0, w8, #1, #1
03bdb6cc: ret      

; 0514a384.asm -> 0x3bdb6d0
03bdb6d0: ldr      x8, [x0, #0x18]
03bdb6d4: ldr      w8, [x8, #0x18]
03bdb6d8: cmp      w8, #0x100
03bdb6dc: cset     w0, eq
03bdb6e0: ret      

; 0514b264.asm -> 0x3bdc5b0
03bdc5b0: ldr      x8, [x0, #0x18]
03bdc5b4: ldr      w0, [x8, #0x1c]
03bdc5b8: ret      

; 0514b270.asm -> 0x3bdc5bc
03bdc5bc: ldr      x8, [x0, #0x18]
03bdc5c0: ldr      w0, [x8, #0x20]
03bdc5c4: ret      

; 0515d554.asm -> 0x3bee8a0
03bee8a0: stp      x20, x19, [sp, #-0x20]!
03bee8a4: stp      x29, x30, [sp, #0x10]
03bee8a8: add      x29, sp, #0x10
03bee8ac: mov      x19, x0
03bee8b0: adrp     x20, #0xf276000
03bee8b4: ldrb     w8, [x20, #0xcfe]
03bee8b8: tbnz     w8, #0, #0x3bee8d0
03bee8bc: adrp     x0, #0xed89000
03bee8c0: add      x0, x0, #0xb58
03bee8c4: bl       #0x172b24c
03bee8c8: mov      w8, #1
03bee8cc: strb     w8, [x20, #0xcfe]
03bee8d0: ldr      x8, [x19, #0x18]
03bee8d4: adds     x0, x8, #0x18
03bee8d8: b.eq     #0x3bee920
03bee8dc: ldur     x8, [x19, #0x20]
03bee8e0: cbz      x8, #0x3bee8f0
03bee8e4: ldr      x9, [x8, #0x10]
03bee8e8: cmp      x9, x0
03bee8ec: b.eq     #0x3bee910
03bee8f0: adrp     x8, #0xed89000
03bee8f4: ldr      x1, [x8, #0xb58]
03bee8f8: bl       #0xb9687a8
03bee8fc: mov      x1, x0
03bee900: stur     x0, [x19, #0x20]
03bee904: add      x0, x19, #0x20
03bee908: bl       #0x172b1d8
03bee90c: ldur     x8, [x19, #0x20]
03bee910: mov      x0, x8
03bee914: ldp      x29, x30, [sp, #0x10]
03bee918: ldp      x20, x19, [sp], #0x20
03bee91c: ret      
03bee920: stur     xzr, [x19, #0x20]
03bee924: add      x0, x19, #0x20
03bee928: mov      x1, #0
03bee92c: bl       #0x172b1d8
03bee930: mov      x8, #0
03bee934: mov      x0, x8
03bee938: ldp      x29, x30, [sp, #0x10]
03bee93c: ldp      x20, x19, [sp], #0x20
03bee940: ret      

; 0515df2c.asm -> 0x3bef278
03bef278: sub      sp, sp, #0x70
03bef27c: stp      x28, x27, [sp, #0x10]
03bef280: stp      x26, x25, [sp, #0x20]
03bef284: stp      x24, x23, [sp, #0x30]
03bef288: stp      x22, x21, [sp, #0x40]
03bef28c: stp      x20, x19, [sp, #0x50]
03bef290: stp      x29, x30, [sp, #0x60]
03bef294: add      x29, sp, #0x60
03bef298: str      w1, [sp, #0xc]
03bef29c: mov      x20, x0
03bef2a0: adrp     x19, #0xf276000
03bef2a4: ldrb     w8, [x19, #0xd00]
03bef2a8: tbz      w8, #0, #0x3bef480
03bef2ac: adrp     x19, #0xf276000
03bef2b0: ldrb     w8, [x19, #0xcfe]
03bef2b4: tbz      w8, #0, #0x3bef4b8
03bef2b8: ldr      x8, [x20, #0x18]
03bef2bc: adds     x0, x8, #0x18
03bef2c0: b.eq     #0x3bef4d8
03bef2c4: ldur     x24, [x20, #0x20]
03bef2c8: cbz      x24, #0x3bef2d8
03bef2cc: ldr      x8, [x24, #0x10]
03bef2d0: cmp      x8, x0
03bef2d4: b.eq     #0x3bef2fc
03bef2d8: adrp     x8, #0xed89000
03bef2dc: ldr      x1, [x8, #0xb58]
03bef2e0: bl       #0xb9687a8
03bef2e4: mov      x1, x0
03bef2e8: stur     x0, [x20, #0x20]
03bef2ec: add      x0, x20, #0x20
03bef2f0: bl       #0x172b1d8
03bef2f4: ldur     x24, [x20, #0x20]
03bef2f8: cbz      x24, #0x3bef4e8
03bef2fc: ldr      x8, [x24, #0x18]
03bef300: adds     x22, x8, #0x10
03bef304: b.eq     #0x3bef708
03bef308: mov      w25, #0
03bef30c: adrp     x27, #0xed89000
03bef310: adrp     x28, #0xed9f000
03bef314: adrp     x19, #0xf27b000
03bef318: adrp     x26, #0xed74000
03bef31c: b        #0x3bef330
03bef320: add      w25, w25, #1
03bef324: ldr      x8, [x24, #0x18]
03bef328: adds     x22, x8, #0x10
03bef32c: b.eq     #0x3bef708
03bef330: ldr      x8, [x27, #0xb68]
03bef334: ldur     x21, [x24, #0x20]
03bef338: cbz      x21, #0x3bef348
03bef33c: ldr      x9, [x21, #0x10]
03bef340: cmp      x9, x22
03bef344: b.eq     #0x3bef380
03bef348: ldr      x8, [x8, #0x20]
03bef34c: ldr      x0, [x8, #0xc0]
03bef350: mov      w1, #6
03bef354: bl       #0x172c164
03bef358: mov      x1, x0
03bef35c: mov      x0, x22
03bef360: bl       #0x7c09e64
03bef364: mov      x1, x0
03bef368: stur     x0, [x24, #0x20]
03bef36c: add      x0, x24, #0x20
03bef370: bl       #0x172b1d8
03bef374: ldur     x21, [x24, #0x20]
03bef378: cbz      x21, #0x3bef724
03bef37c: ldr      x22, [x21, #0x10]
03bef380: ldr      w8, [x22, #0x18]
03bef384: ldr      w9, [x22]
03bef388: ldr      w10, [x22, #8]
03bef38c: sub      w9, w10, w9
03bef390: sdiv     w8, w9, w8
03bef394: cmp      w25, w8
03bef398: b.ge     #0x3bef4e8
03bef39c: ldr      x8, [x24, #0x18]
03bef3a0: adds     x23, x8, #0x10
03bef3a4: b.eq     #0x3bef708
03bef3a8: cmp      x22, x23
03bef3ac: b.eq     #0x3bef3e8
03bef3b0: ldr      x8, [x27, #0xb68]
03bef3b4: ldr      x8, [x8, #0x20]
03bef3b8: ldr      x0, [x8, #0xc0]
03bef3bc: mov      w1, #6
03bef3c0: bl       #0x172c164
03bef3c4: mov      x1, x0
03bef3c8: mov      x0, x23
03bef3cc: bl       #0x7c09e64
03bef3d0: mov      x1, x0
03bef3d4: stur     x0, [x24, #0x20]
03bef3d8: add      x0, x24, #0x20
03bef3dc: bl       #0x172b1d8
03bef3e0: ldur     x21, [x24, #0x20]
03bef3e4: cbz      x21, #0x3bef724
03bef3e8: ldr      x23, [x28, #0x730]
03bef3ec: ldrb     w8, [x19, #0xb8]
03bef3f0: tbnz     w8, #0, #0x3bef408
03bef3f4: adrp     x0, #0xed74000
03bef3f8: add      x0, x0, #0x100
03bef3fc: bl       #0x172b24c
03bef400: mov      w8, #1
03bef404: strb     w8, [x19, #0xb8]
03bef408: ldr      x8, [x21, #0x10]
03bef40c: ldr      w9, [x8, #0x18]
03bef410: ldr      x8, [x8]
03bef414: mul      w9, w9, w25
03bef418: ldr      x22, [x8, w9, sxtw]
03bef41c: cbz      x22, #0x3bef320
03bef420: ldr      x0, [x26, #0x100]
03bef424: ldr      w8, [x0, #0xe0]
03bef428: cbnz     w8, #0x3bef430
03bef42c: bl       #0x172b3a8
03bef430: ldr      x8, [x23, #0x20]
03bef434: ldr      x0, [x8, #0xc0]
03bef438: mov      w1, #6
03bef43c: bl       #0x172c164
03bef440: mov      x1, x0
03bef444: mov      x0, x22
03bef448: bl       #0xa9c76a0
03bef44c: cbz      x0, #0x3bef320
03bef450: ldr      x8, [x0, #0x10]
03bef454: mov      w9, w8
03bef458: cmp      x8, #0
03bef45c: mov      w8, #-0x22222223
03bef460: ccmp     x9, x8, #4, ne
03bef464: b.eq     #0x3bef320
03bef468: ldr      x8, [x0, #0x18]
03bef46c: ldr      w8, [x8, #0x44]
03bef470: ldr      w9, [sp, #0xc]
03bef474: cmp      w8, w9
03bef478: b.ne     #0x3bef320
03bef47c: b        #0x3bef6e8
03bef480: adrp     x0, #0xed89000
03bef484: add      x0, x0, #0xb68
03bef488: bl       #0x172b24c
03bef48c: adrp     x0, #0xed9f000
03bef490: add      x0, x0, #0x728
03bef494: bl       #0x172b24c
03bef498: adrp     x0, #0xed9f000
03bef49c: add      x0, x0, #0x730
03bef4a0: bl       #0x172b24c
03bef4a4: mov      w8, #1
03bef4a8: strb     w8, [x19, #0xd00]
03bef4ac: adrp     x19, #0xf276000
03bef4b0: ldrb     w8, [x19, #0xcfe]
03bef4b4: tbnz     w8, #0, #0x3bef2b8
03bef4b8: adrp     x0, #0xed89000
03bef4bc: add      x0, x0, #0xb58
03bef4c0: bl       #0x172b24c
03bef4c4: mov      w8, #1
03bef4c8: strb     w8, [x19, #0xcfe]
03bef4cc: ldr      x8, [x20, #0x18]
03bef4d0: adds     x0, x8, #0x18
03bef4d4: b.ne     #0x3bef2c4
03bef4d8: stur     xzr, [x20, #0x20]
03bef4dc: add      x0, x20, #0x20
03bef4e0: mov      x1, #0
03bef4e4: bl       #0x172b1d8
03bef4e8: adrp     x19, #0xf276000
03bef4ec: ldrb     w8, [x19, #0xcff]
03bef4f0: tbnz     w8, #0, #0x3bef508
03bef4f4: adrp     x0, #0xed89000
03bef4f8: add      x0, x0, #0xb58
03bef4fc: bl       #0x172b24c
03bef500: mov      w8, #1
03bef504: strb     w8, [x19, #0xcff]
03bef508: ldr      x8, [x20, #0x18]
03bef50c: adds     x0, x8, #0x50
03bef510: b.eq     #0x3bef6d4
03bef514: ldur     x23, [x20, #0x28]
03bef518: cbz      x23, #0x3bef528
03bef51c: ldr      x8, [x23, #0x10]
03bef520: cmp      x8, x0
03bef524: b.eq     #0x3bef54c
03bef528: adrp     x8, #0xed89000
03bef52c: ldr      x1, [x8, #0xb58]
03bef530: bl       #0xb9687a8
03bef534: mov      x1, x0
03bef538: stur     x0, [x20, #0x28]
03bef53c: add      x0, x20, #0x28
03bef540: bl       #0x172b1d8
03bef544: ldur     x23, [x20, #0x28]
03bef548: cbz      x23, #0x3bef6e4
03bef54c: ldr      x8, [x23, #0x18]
03bef550: adds     x21, x8, #0x10
03bef554: b.eq     #0x3bef714
03bef558: mov      w24, #0
03bef55c: adrp     x26, #0xed89000
03bef560: adrp     x19, #0xed9f000
03bef564: adrp     x27, #0xf27b000
03bef568: adrp     x28, #0xed74000
03bef56c: adrp     x20, #0xed74000
03bef570: add      x20, x20, #0x100
03bef574: b        #0x3bef588
03bef578: add      w24, w24, #1
03bef57c: ldr      x8, [x23, #0x18]
03bef580: adds     x21, x8, #0x10
03bef584: b.eq     #0x3bef714
03bef588: ldr      x8, [x26, #0xb68]
03bef58c: ldur     x25, [x23, #0x20]
03bef590: cbz      x25, #0x3bef5a0
03bef594: ldr      x9, [x25, #0x10]
03bef598: cmp      x9, x21
03bef59c: b.eq     #0x3bef5d8
03bef5a0: ldr      x8, [x8, #0x20]
03bef5a4: ldr      x0, [x8, #0xc0]
03bef5a8: mov      w1, #6
03bef5ac: bl       #0x172c164
03bef5b0: mov      x1, x0
03bef5b4: mov      x0, x21
03bef5b8: bl       #0x7c09e64
03bef5bc: mov      x1, x0
03bef5c0: stur     x0, [x23, #0x20]
03bef5c4: add      x0, x23, #0x20
03bef5c8: bl       #0x172b1d8
03bef5cc: ldur     x25, [x23, #0x20]
03bef5d0: cbz      x25, #0x3bef724
03bef5d4: ldr      x21, [x25, #0x10]
03bef5d8: ldr      w8, [x21, #0x18]
03bef5dc: ldr      w9, [x21]
03bef5e0: ldr      w10, [x21, #8]
03bef5e4: sub      w9, w10, w9
03bef5e8: sdiv     w8, w9, w8
03bef5ec: cmp      w24, w8
03bef5f0: b.ge     #0x3bef6e4
03bef5f4: ldr      x8, [x23, #0x18]
03bef5f8: adds     x22, x8, #0x10
03bef5fc: b.eq     #0x3bef714
03bef600: cmp      x21, x22
03bef604: b.eq     #0x3bef640
03bef608: ldr      x8, [x26, #0xb68]
03bef60c: ldr      x8, [x8, #0x20]
03bef610: ldr      x0, [x8, #0xc0]
03bef614: mov      w1, #6
03bef618: bl       #0x172c164
03bef61c: mov      x1, x0
03bef620: mov      x0, x22
03bef624: bl       #0x7c09e64
03bef628: mov      x1, x0
03bef62c: stur     x0, [x23, #0x20]
03bef630: add      x0, x23, #0x20
03bef634: bl       #0x172b1d8
03bef638: ldur     x25, [x23, #0x20]
03bef63c: cbz      x25, #0x3bef724
03bef640: ldr      x22, [x19, #0x730]
03bef644: ldrb     w8, [x27, #0xb8]
03bef648: tbnz     w8, #0, #0x3bef65c
03bef64c: mov      x0, x20
03bef650: bl       #0x172b24c
03bef654: mov      w8, #1
03bef658: strb     w8, [x27, #0xb8]
03bef65c: ldr      x8, [x25, #0x10]
03bef660: ldr      w9, [x8, #0x18]
03bef664: ldr      x8, [x8]
03bef668: mul      w9, w9, w24
03bef66c: ldr      x21, [x8, w9, sxtw]
03bef670: cbz      x21, #0x3bef578
03bef674: ldr      x0, [x28, #0x100]

; 053631c4.asm -> 0x3df44e0
03df44e0: sub      sp, sp, #0x50
03df44e4: stp      x24, x23, [sp, #0x10]
03df44e8: stp      x22, x21, [sp, #0x20]
03df44ec: stp      x20, x19, [sp, #0x30]
03df44f0: stp      x29, x30, [sp, #0x40]
03df44f4: add      x29, sp, #0x40
03df44f8: mov      x19, x1
03df44fc: mov      x20, x0
03df4500: adrp     x21, #0xf1f6000
03df4504: ldrb     w8, [x21, #0x471]
03df4508: tbnz     w8, #0, #0x3df4640
03df450c: adrp     x0, #0xed5a000
03df4510: add      x0, x0, #0xf40
03df4514: bl       #0x172b24c
03df4518: adrp     x0, #0xed5c000
03df451c: add      x0, x0, #0x360
03df4520: bl       #0x172b24c
03df4524: adrp     x0, #0xed5e000
03df4528: add      x0, x0, #0x590
03df452c: bl       #0x172b24c
03df4530: adrp     x0, #0xed62000
03df4534: add      x0, x0, #0x198
03df4538: bl       #0x172b24c
03df453c: adrp     x0, #0xed62000
03df4540: add      x0, x0, #0xe20
03df4544: bl       #0x172b24c
03df4548: adrp     x0, #0xed63000
03df454c: add      x0, x0, #0x9d0
03df4550: bl       #0x172b24c
03df4554: adrp     x0, #0xed63000
03df4558: add      x0, x0, #0xe80
03df455c: bl       #0x172b24c
03df4560: adrp     x0, #0xed64000
03df4564: add      x0, x0, #0x560
03df4568: bl       #0x172b24c
03df456c: adrp     x0, #0xed66000
03df4570: add      x0, x0, #0xb0
03df4574: bl       #0x172b24c
03df4578: adrp     x0, #0xed66000
03df457c: add      x0, x0, #0x6f0
03df4580: bl       #0x172b24c
03df4584: adrp     x0, #0xed68000
03df4588: add      x0, x0, #0xce8
03df458c: bl       #0x172b24c
03df4590: adrp     x0, #0xed4f000
03df4594: add      x0, x0, #0x478
03df4598: bl       #0x172b24c
03df459c: adrp     x0, #0xed68000
03df45a0: add      x0, x0, #0xfa0
03df45a4: bl       #0x172b24c
03df45a8: adrp     x0, #0xed6c000
03df45ac: add      x0, x0, #0x9f0
03df45b0: bl       #0x172b24c
03df45b4: adrp     x0, #0xed6c000
03df45b8: add      x0, x0, #0xa00
03df45bc: bl       #0x172b24c
03df45c0: adrp     x0, #0xed70000
03df45c4: add      x0, x0, #0xec8
03df45c8: bl       #0x172b24c
03df45cc: adrp     x0, #0xed4b000
03df45d0: add      x0, x0, #0xea0
03df45d4: bl       #0x172b24c
03df45d8: adrp     x0, #0xed71000
03df45dc: add      x0, x0, #0
03df45e0: bl       #0x172b24c
03df45e4: adrp     x0, #0xed72000
03df45e8: add      x0, x0, #0x380
03df45ec: bl       #0x172b24c
03df45f0: adrp     x0, #0xed73000
03df45f4: add      x0, x0, #0xf98
03df45f8: bl       #0x172b24c
03df45fc: adrp     x0, #0xed75000
03df4600: add      x0, x0, #0xb90
03df4604: bl       #0x172b24c
03df4608: adrp     x0, #0xed79000
03df460c: add      x0, x0, #0x4f8
03df4610: bl       #0x172b24c
03df4614: adrp     x0, #0xed79000
03df4618: add      x0, x0, #0x500
03df461c: bl       #0x172b24c
03df4620: adrp     x0, #0xee62000
03df4624: add      x0, x0, #0xef8
03df4628: bl       #0x172b24c
03df462c: adrp     x0, #0xee5a000
03df4630: add      x0, x0, #0x828
03df4634: bl       #0x172b24c
03df4638: mov      w8, #1
03df463c: strb     w8, [x21, #0x471]
03df4640: adrp     x8, #0xed4f000
03df4644: ldr      x0, [x8, #0x478]
03df4648: mov      w1, #2
03df464c: bl       #0x172b30c
03df4650: mov      x21, x0
03df4654: mov      w8, #0x401c
03df4658: movk     w8, #0x37e9, lsl #16
03df465c: str      w8, [sp, #0xc]
03df4660: adrp     x8, #0xed63000
03df4664: ldr      x0, [x8, #0xe80]
03df4668: add      x1, sp, #0xc
03df466c: bl       #0x172b3b0
03df4670: cbz      x21, #0x3df4ba8
03df4674: ldr      w8, [x21, #0x18]
03df4678: cbz      w8, #0x3df4ba4
03df467c: mov      x1, x0
03df4680: mov      x22, x21
03df4684: str      x0, [x22, #0x20]!
03df4688: mov      x0, x22
03df468c: bl       #0x172b1d8
03df4690: str      w20, [sp, #8]
03df4694: adrp     x8, #0xed5c000
03df4698: ldr      x0, [x8, #0x360]
03df469c: add      x1, sp, #8
03df46a0: bl       #0x172b3b0
03df46a4: ldur     w8, [x22, #-8]
03df46a8: tst      w8, #0xfffffffe
03df46ac: b.eq     #0x3df4ba4
03df46b0: mov      x1, x0
03df46b4: mov      x0, x21
03df46b8: str      x1, [x0, #0x28]!
03df46bc: bl       #0x172b1d8
03df46c0: adrp     x22, #0xed72000
03df46c4: ldr      x8, [x22, #0x380]
03df46c8: ldr      x8, [x8, #0xb8]
03df46cc: ldr      x1, [x8]
03df46d0: adrp     x23, #0xed66000
03df46d4: ldr      x0, [x23, #0x6f0]
03df46d8: ldr      w8, [x0, #0xe0]
03df46dc: cbnz     w8, #0x3df46ec
03df46e0: mov      x24, x1
03df46e4: bl       #0x172b3a8
03df46e8: mov      x1, x24
03df46ec: adrp     x8, #0xee62000
03df46f0: ldr      x0, [x8, #0xef8]
03df46f4: mov      w2, #0
03df46f8: mov      w3, #1
03df46fc: mov      x4, x21
03df4700: mov      x5, #0
03df4704: bl       #0x8216824
03df4708: cmp      w20, #5
03df470c: b.gt     #0x3df474c
03df4710: cmp      w20, #2
03df4714: b.gt     #0x3df478c
03df4718: cbz      w20, #0x3df491c
03df471c: cmp      w20, #1
03df4720: b.eq     #0x3df497c
03df4724: cmp      w20, #2
03df4728: b.ne     #0x3df49e0
03df472c: adrp     x8, #0xed79000
03df4730: ldr      x0, [x8, #0x4f8]
03df4734: bl       #0x172b4e4
03df4738: mov      x21, x0
03df473c: mov      x1, #0
03df4740: bl       #0x3e56e30
03df4744: cbnz     x21, #0x3df4aa4
03df4748: b        #0x3df4a80
03df474c: cmp      w20, #8
03df4750: b.gt     #0x3df47c4
03df4754: cmp      w20, #6
03df4758: b.eq     #0x3df47fc
03df475c: cmp      w20, #7
03df4760: b.eq     #0x3df4a88
03df4764: cmp      w20, #8
03df4768: b.ne     #0x3df49e0
03df476c: adrp     x8, #0xed73000
03df4770: ldr      x0, [x8, #0xf98]
03df4774: bl       #0x172b4e4
03df4778: mov      x21, x0
03df477c: mov      x1, #0
03df4780: bl       #0x3e24210
03df4784: cbnz     x21, #0x3df4aa4
03df4788: b        #0x3df4a80
03df478c: cmp      w20, #3
03df4790: b.eq     #0x3df493c
03df4794: cmp      w20, #4
03df4798: b.eq     #0x3df47fc
03df479c: cmp      w20, #5
03df47a0: b.ne     #0x3df49e0
03df47a4: adrp     x8, #0xed71000
03df47a8: ldr      x0, [x8]
03df47ac: bl       #0x172b4e4
03df47b0: mov      x21, x0
03df47b4: mov      x1, #0
03df47b8: bl       #0x3e1e1f8
03df47bc: cbnz     x21, #0x3df4aa4
03df47c0: b        #0x3df4a80
03df47c4: cmp      w20, #9
03df47c8: b.eq     #0x3df495c
03df47cc: cmp      w20, #0xa
03df47d0: b.eq     #0x3df49c0
03df47d4: cmp      w20, #0xb
03df47d8: b.ne     #0x3df49e0
03df47dc: adrp     x8, #0xed6c000
03df47e0: ldr      x0, [x8, #0xa00]
03df47e4: bl       #0x172b4e4
03df47e8: mov      x21, x0
03df47ec: mov      x1, #0
03df47f0: bl       #0x3e1bcbc
03df47f4: cbnz     x21, #0x3df4aa4
03df47f8: b        #0x3df4a80
03df47fc: adrp     x21, #0xed4b000
03df4800: ldr      x8, [x21, #0xea0]
03df4804: ldr      x8, [x8, #0xb8]
03df4808: ldr      x8, [x8]
03df480c: cbz      x8, #0x3df4ba8
03df4810: ldr      x0, [x8, #0x130]
03df4814: cbz      x0, #0x3df4ba8
03df4818: mov      w1, #0
03df481c: mov      w2, #0
03df4820: mov      x3, #0
03df4824: bl       #0x7f9741c
03df4828: cbz      w0, #0x3df4a5c
03df482c: ldr      x8, [x21, #0xea0]
03df4830: ldr      x8, [x8, #0xb8]
03df4834: ldr      x8, [x8]
03df4838: cbz      x8, #0x3df4ba8
03df483c: ldr      x21, [x8, #0x130]
03df4840: adrp     x22, #0xed62000
03df4844: ldr      x0, [x22, #0xe20]
03df4848: ldr      w8, [x0, #0xe0]
03df484c: cbnz     w8, #0x3df4858
03df4850: bl       #0x172b3a8
03df4854: ldr      x0, [x22, #0xe20]
03df4858: ldr      x8, [x0, #0xb8]
03df485c: ldr      x8, [x8]
03df4860: cbz      x8, #0x3df4ba8
03df4864: ldr      w9, [x8, #0x18]
03df4868: mov      w10, #0xde47
03df486c: cmp      w9, w10
03df4870: b.lt     #0x3df4a28
03df4874: ldr      w9, [x0, #0xe0]
03df4878: cbnz     w9, #0x3df48a0
03df487c: bl       #0x172b3a8
03df4880: ldr      x0, [x22, #0xe20]
03df4884: ldr      x8, [x0, #0xb8]
03df4888: ldr      x8, [x8]
03df488c: cbz      x8, #0x3df4ba8
03df4890: ldr      w9, [x8, #0x18]
03df4894: mov      w10, #0xde46
03df4898: cmp      w9, w10
03df489c: b.ls     #0x3df4ba4
03df48a0: mov      w9, #0xf250
03df48a4: movk     w9, #6, lsl #16
03df48a8: ldr      x9, [x8, x9]
03df48ac: cbz      x9, #0x3df4a28
03df48b0: ldr      w9, [x0, #0xe0]
03df48b4: cbnz     w9, #0x3df48dc
03df48b8: bl       #0x172b3a8
03df48bc: ldr      x8, [x22, #0xe20]
03df48c0: ldr      x8, [x8, #0xb8]
03df48c4: ldr      x8, [x8]
03df48c8: cbz      x8, #0x3df4ba8
03df48cc: ldr      w9, [x8, #0x18]
03df48d0: mov      w10, #0xde46
03df48d4: cmp      w9, w10
03df48d8: b.ls     #0x3df4ba4
03df48dc: mov      w9, #0xf250

; 07378554-hp-fraction.asm -> 0x5e0ca2c
05e0ca2c: lsl      x8, x21, #0xe
05e0ca30: sdiv     x21, x8, x20
05e0ca34: ldr      x8, [x19, #0x1a0]

; 07378768-hp-store.asm -> 0x5e0cc40
05e0cc40: str      x21, [x19, #0x1a0]
05e0cc44: ldr      x19, [x19, #0x158]

; 0738b8d0-icon-entry.asm -> 0x5e1fda8
05e1fda8: mov      w9, #0x18
05e1fdac: umaddl   x8, w0, w9, x8
05e1fdb0: ldr      x1, [x8, #0x30]
05e1fdb4: str      x1, [sp, #8]

; 074019c8-minimap.asm -> 0x5e95ea0
05e95ea0: ldp      s1, s4, [x20, #0x44]
05e95ea4: fmul     s0, s0, s1
05e95ea8: fmul     s1, s2, s4
05e95eac: cbz      w19, #0x5e95edc
05e95eb0: ldp      s2, s4, [x20, #0x64]
05e95eb4: fneg     s5, s2
05e95eb8: fcmp     s0, s2
05e95ebc: fcsel    s2, s2, s0, gt
05e95ec0: fcmp     s0, s5
05e95ec4: fcsel    s0, s5, s2, mi
05e95ec8: fneg     s2, s4
05e95ecc: fcmp     s1, s4
05e95ed0: fcsel    s4, s4, s1, gt
05e95ed4: fcmp     s1, s2
05e95ed8: fcsel    s1, s2, s4, mi
05e95edc: fmov     s2, s3

; 092af05c-sync-position-store.asm -> 0x7d43898
07d43898: stur     d4, [x19, #0x2c]
07d4389c: str      s3, [x19, #0x34]
07d438a0: fsub     s0, s4, s9
