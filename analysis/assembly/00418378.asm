00418378: sub      sp, sp, #0xf0
0041837c: stp      x29, x30, [sp, #0x90]
00418380: stp      x28, x27, [sp, #0xa0]
00418384: stp      x26, x25, [sp, #0xb0]
00418388: stp      x24, x23, [sp, #0xc0]
0041838c: stp      x22, x21, [sp, #0xd0]
00418390: stp      x20, x19, [sp, #0xe0]
00418394: add      x29, sp, #0x90
00418398: mrs      x21, tpidr_el0
0041839c: mov      x20, x0
004183a0: add      x25, x0, #2, lsl #12
004183a4: ldr      x8, [x21, #0x28]
004183a8: stur     x8, [x29, #-8]
004183ac: bl       #0x50aaf8
004183b0: ldrb     w24, [x20, #0x688]
004183b4: ldrb     w23, [x20, #0x68a]
004183b8: mov      x19, x0
004183bc: ldr      x8, [x20]
004183c0: mov      x0, x20
004183c4: orr      w9, w23, w24
004183c8: ldr      x10, [x8, #0x30]
004183cc: add      x8, sp, #0x10
004183d0: and      w22, w9, #1
004183d4: blr      x10
004183d8: ldrb     w8, [x25, #0xd29]
004183dc: cbz      w8, #0x418880
004183e0: ldrb     w8, [x25, #0xd28]
004183e4: cmp      w8, w22
004183e8: b.ne     #0x418880
004183ec: ldr      x28, [x20, #0x2d18]
004183f0: ldr      x8, [x20, #0x2ce0]
004183f4: mov      w22, #0x4240
004183f8: ldr      x26, [x20, #0x2ce8]
004183fc: movk     w22, #0xf, lsl #16
00418400: cmp      x19, x28
00418404: cset     w25, ge
00418408: cmp      x19, x8
0041840c: b.ge     #0x418420
00418410: mov      w27, #1
00418414: cmp      x19, x28
00418418: b.ge     #0x41850c
0041841c: b        #0x418564
00418420: add      x1, sp, #8
00418424: add      x2, sp, #4
00418428: mov      x0, x20
0041842c: str      xzr, [sp, #8]
00418430: str      wzr, [sp, #4]
00418434: bl       #0x418aac
00418438: ldr      x10, [x20, #0xc8]
0041843c: tbz      w0, #0, #0x41846c
00418440: ldr      x8, [sp, #8]
00418444: ldr      w9, [sp, #4]
00418448: cmp      x10, x8
0041844c: b.ne     #0x41845c
00418450: ldr      w10, [x20, #0xf0]
00418454: cmp      w10, w9
00418458: b.eq     #0x418460
0041845c: str      wzr, [x20, #0x954]
00418460: str      x8, [x20, #0xc8]
00418464: str      w9, [x20, #0xf0]
00418468: b        #0x418474
0041846c: ldr      w9, [x20, #0xf0]
00418470: mov      x8, x10
00418474: ldr      x10, [sp, #0x20]
00418478: ldr      w11, [x20, #0x10c]
0041847c: mov      w12, #8
00418480: ldrsw    x13, [x20, #0x110]
00418484: nop      
00418488: madd     x10, x10, x22, x19
0041848c: cmp      w11, #8
00418490: csel     w11, w11, w12, hi
00418494: cmp      w9, #1
00418498: sxtw     x12, w11
0041849c: str      x10, [x20, #0x2ce0]
004184a0: add      x10, x8, x13
004184a4: b.lt     #0x4184d0
004184a8: ldr      w11, [x20, #0x954]
004184ac: ldr      w13, [x20, #0x950]
004184b0: cmp      w11, w9
004184b4: csel     w11, w11, wzr, lt
004184b8: sub      w14, w9, w11
004184bc: smaddl   x10, w12, w11, x10
004184c0: cmp      w14, w13
004184c4: csel     w13, w14, w13, lt
004184c8: add      w11, w13, w11
004184cc: b        #0x4184d8
004184d0: mov      w11, wzr
004184d4: mov      w13, wzr
004184d8: str      w11, [x20, #0x954]
004184dc: stur     x10, [x29, #-0x20]
004184e0: stur     w13, [x29, #-0x18]
004184e4: stur     x12, [x29, #-0x10]
004184e8: tbz      w0, #0, #0x4184fc
004184ec: cmp      w9, #1
004184f0: b.lt     #0x4187fc
004184f4: lsr      x8, x8, #0x18
004184f8: cbnz     x8, #0x4187fc
004184fc: mov      w27, wzr
00418500: str      wzr, [x20, #0x954]
00418504: cmp      x19, x28
00418508: b.lt     #0x418564
0041850c: mov      x4, x20
00418510: str      wzr, [x4, #0xdc]!
00418514: ldur     x0, [x4, #-0xac]
00418518: cbz      x0, #0x418554
0041851c: ldr      w8, [x20, #0xfc]
00418520: cmp      w8, #1
00418524: b.lt     #0x418554
00418528: ldr      x9, [x20, #0xa0]
0041852c: subs     x1, x9, x8
00418530: b.ls     #0x418554
00418534: mov      x9, #0xb8
00418538: mov      w8, #0x10
0041853c: sub      x2, x29, #0x20
00418540: movk     x9, #0x28, lsl #32
00418544: mov      w3, #0x1c
00418548: stur     w8, [x29, #-0x18]
0041854c: stur     x9, [x29, #-0x20]
00418550: bl       #0x434a80
00418554: ldr      x8, [sp, #0x50]
00418558: nop      
0041855c: madd     x8, x8, x22, x19
00418560: str      x8, [x20, #0x2d18]
00418564: ldr      x8, [x20, #0x2cd8]
00418568: cmp      x19, x8
0041856c: b.lt     #0x4186c0
00418570: ldr      x0, [x20, #0x30]
00418574: stur     xzr, [x29, #-0x20]
00418578: sub      x2, x29, #0x20
0041857c: ldr      x9, [x20, #0xa0]
00418580: ldrsw    x10, [x20, #0xf8]
00418584: mov      w3, #8
00418588: ldr      x8, [x0]
0041858c: sub      x9, x9, x10
00418590: ldr      x8, [x8, #0x10]
00418594: and      x1, x9, #0xffffffffff
00418598: blr      x8
0041859c: ldr      x0, [x20, #0x30]
004185a0: ldur     x8, [x29, #-0x20]
004185a4: sub      x2, x29, #0x20
004185a8: stur     xzr, [x29, #-0x20]
004185ac: mov      w3, #8
004185b0: ldr      x9, [x0]
004185b4: add      x8, x8, #0xb8
004185b8: and      x1, x8, #0xffffffffff
004185bc: ldr      x9, [x9, #0x10]
004185c0: blr      x9
004185c4: ldr      x0, [x20, #0x30]
004185c8: ldur     x8, [x29, #-0x20]
004185cc: sub      x2, x29, #0x20
004185d0: stur     xzr, [x29, #-0x20]
004185d4: mov      w3, #8
004185d8: ldr      x9, [x0]
004185dc: and      x1, x8, #0xffffffffff
004185e0: ldr      x9, [x9, #0x10]
004185e4: blr      x9
004185e8: ldr      x0, [x20, #0x30]
004185ec: ldur     x8, [x29, #-0x20]
004185f0: sub      x2, x29, #0x20
004185f4: stur     xzr, [x29, #-0x20]
004185f8: mov      w3, #8
004185fc: ldr      x9, [x0]
00418600: add      x8, x8, #0x30
00418604: and      x1, x8, #0xffffffffff
00418608: ldr      x9, [x9, #0x10]
0041860c: blr      x9
00418610: ldr      x0, [x20, #0x30]
00418614: ldur     x8, [x29, #-0x20]
00418618: sub      x2, x29, #0x20
0041861c: stur     xzr, [x29, #-0x20]
00418620: mov      w3, #8
00418624: ldr      x9, [x0]
00418628: add      x8, x8, #0x10
0041862c: and      x1, x8, #0xffffffffff
00418630: ldr      x9, [x9, #0x10]
00418634: blr      x9
00418638: ldr      x0, [x20, #0x30]
0041863c: ldur     x8, [x29, #-0x20]
00418640: sub      x2, x29, #0x20
00418644: stur     xzr, [x29, #-0x20]
00418648: mov      w3, #8
0041864c: ldr      x9, [x0]
00418650: add      x8, x8, #0x10
00418654: and      x1, x8, #0xffffffffff
00418658: ldr      x9, [x9, #0x10]
0041865c: blr      x9
00418660: ldur     x8, [x29, #-0x20]
00418664: mov      w9, #0xffff00
00418668: and      x8, x8, #0xffffffffff
0041866c: add      x1, x8, #0x100
00418670: cmp      x8, x9
00418674: str      x1, [x20, #0xc0]
00418678: b.lo     #0x41869c
0041867c: ldr      x0, [x20, #0x30]
00418680: mov      w9, #0x2c10
00418684: mov      w3, #0x40
00418688: add      x2, x20, x9
0041868c: ldr      x8, [x0]
00418690: ldr      x8, [x8, #0x10]
00418694: blr      x8
00418698: tbnz     w0, #0, #0x4186b0
0041869c: movi     v0.2d, #0000000000000000
004186a0: str      q0, [x20, #0x2c40]
004186a4: str      q0, [x20, #0x2c30]
004186a8: str      q0, [x20, #0x2c20]
004186ac: str      q0, [x20, #0x2c10]
004186b0: ldr      x8, [sp, #0x18]
004186b4: nop      
004186b8: madd     x8, x8, x22, x19
004186bc: str      x8, [x20, #0x2cd8]
004186c0: ldr      x8, [x20, #0x948]
004186c4: cmp      x19, x8
004186c8: b.lt     #0x4186e4
004186cc: mov      x0, x20
004186d0: bl       #0x419178
004186d4: ldr      x8, [sp, #0x40]
004186d8: nop      
004186dc: madd     x8, x8, x22, x19
004186e0: str      x8, [x20, #0x948]
004186e4: ldrb     w8, [x20, #0x68b]
004186e8: tbnz     w8, #0, #0x4186f4
004186ec: mov      x8, xzr
004186f0: b        #0x418718
004186f4: ldr      x8, [x20, #0x930]
004186f8: cmp      x8, x19
004186fc: b.gt     #0x41871c
00418700: add      x0, x20, #0x840
00418704: mov      w1, wzr
00418708: bl       #0x435e8c
0041870c: mov      w8, #0xc200
00418710: movk     w8, #0xbeb, lsl #16
00418714: add      x8, x19, x8
00418718: str      x8, [x20, #0x930]
0041871c: tbz      w27, #0, #0x418784
00418720: tbnz     w24, #0, #0x4187a4
00418724: cmp      x19, x26
00418728: b.ge     #0x4187b8
0041872c: cbz      w25, #0x418738
00418730: mov      x0, x20
00418734: bl       #0x419d08
00418738: ldr      x8, [x20, #0x2d00]
0041873c: cmp      x19, x8
00418740: b.ge     #0x4187dc
00418744: tbnz     w24, #0, #0x41886c
00418748: tbz      w23, #0, #0x418758
0041874c: mov      x0, x20
00418750: mov      x1, x19
00418754: bl       #0x41a25c
00418758: ldr      x8, [x20, #0x2cf8]
0041875c: cmp      x19, x8
00418760: b.lt     #0x4189d4
00418764: ldr      x8, [x20, #0xc8]
00418768: lsr      x9, x8, #0x18
0041876c: cbz      x9, #0x4189d4
00418770: ldr      x9, [x20, #0x2d10]
00418774: cmp      x9, x8
00418778: b.ne     #0x418938
0041877c: ldr      w9, [x20, #0x95c]
00418780: b        #0x418940
00418784: tbz      w24, #0, #0x418794
00418788: mov      x0, x20
0041878c: mov      x1, x19
00418790: bl       #0x419710
00418794: ldr      x8, [x20, #0x2d20]
00418798: cmp      x19, x8
0041879c: b.ge     #0x4189e8
004187a0: b        #0x418a1c
004187a4: mov      x0, x20
004187a8: mov      x1, x19
004187ac: bl       #0x419710
004187b0: cmp      x19, x26
004187b4: b.lt     #0x41872c
004187b8: add      x0, x20, #0x130
004187bc: mov      w1, wzr
004187c0: bl       #0x41901c
004187c4: ldr      x8, [sp, #0x28]
004187c8: nop      
004187cc: madd     x8, x8, x22, x19
004187d0: str      x8, [x20, #0x2ce8]
004187d4: cbnz     w25, #0x418730
004187d8: b        #0x418738
004187dc: tbnz     w24, #0, #0x41884c
004187e0: add      x0, x20, #0x220
004187e4: mov      w1, wzr
004187e8: bl       #0x41a0ec
004187ec: add      x0, x20, #0x750
004187f0: mov      w1, wzr
004187f4: bl       #0x41a0ec
004187f8: b        #0x418858
004187fc: mov      w8, #0xffffff
00418800: cmp      x10, x8
00418804: b.lo     #0x41881c
00418808: sub      x1, x29, #0x20
0041880c: mov      x0, x20
00418810: bl       #0x418cb0
00418814: tbz      w0, #0, #0x4184fc
00418818: ldr      w11, [x20, #0x954]
0041881c: ldr      w8, [x20, #0xf0]
00418820: cmp      w8, #1
00418824: b.lt     #0x418830
00418828: cmp      w11, w8
0041882c: b.lt     #0x418410
00418830: add      x0, x20, #0x130
00418834: bl       #0x418f14
00418838: ldr      x8, [x20, #0x2cf0]
0041883c: cmp      x19, x8
00418840: b.ge     #0x418a4c
00418844: mov      w25, #1
00418848: b        #0x418a6c
0041884c: mov      x0, x20
00418850: mov      w1, #0x10
00418854: bl       #0x419ef0
00418858: ldr      x8, [sp, #0x48]
0041885c: nop      
00418860: madd     x8, x8, x22, x19
00418864: str      x8, [x20, #0x2d00]
00418868: tbz      w24, #0, #0x418748
0041886c: mov      x0, x20
00418870: mov      x1, x19
00418874: bl       #0x419710
00418878: tbnz     w23, #0, #0x41874c
0041887c: b        #0x418758
00418880: mov      w8, #1
00418884: strb     w22, [x25, #0xd28]
00418888: strb     w8, [x25, #0xd29]
0041888c: str      x19, [x20, #0x2cf8]
00418890: str      x19, [x20, #0x2d00]
00418894: str      x19, [x20, #0x2ce8]
00418898: str      x19, [x20, #0x2d20]
0041889c: tbz      w23, #0, #0x4188f0
004188a0: ldp      x9, x8, [x20, #0x138]
004188a4: cmp      x8, x9
004188a8: b.eq     #0x4188f0
004188ac: ldp      x10, x8, [x20, #0x150]
004188b0: mov      w13, #0x1b0
004188b4: lsr      x11, x10, #4
004188b8: add      x12, x8, x10
004188bc: and      x10, x10, #0xf
004188c0: add      x8, x9, x11, lsl #3
004188c4: lsr      x11, x12, #1
004188c8: and      x12, x12, #0xf
004188cc: and      x11, x11, #0x7ffffffffffffff8
004188d0: ldr      x14, [x8]
004188d4: nop      
004188d8: umaddl   x10, w10, w13, x14
004188dc: ldr      x9, [x9, x11]
004188e0: nop      
004188e4: umaddl   x9, w12, w13, x9
004188e8: cmp      x10, x9
004188ec: b.ne     #0x418a74
004188f0: adrp     x25, #0x563000
004188f4: adrp     x8, #0x28000
004188f8: add      x8, x8, #0xf64
004188fc: ldr      x25, [x25, #0x138]
00418900: ldp      x3, x4, [sp, #0x40]
00418904: ldp      x5, x6, [sp, #0x28]
00418908: cmp      w22, #0
0041890c: ldr      x0, [x25]
00418910: ldr      x7, [sp, #0x10]
00418914: adrp     x9, #0x29000
00418918: add      x9, x9, #0x49c
0041891c: adrp     x1, #0x28000
00418920: add      x1, x1, #0x572 ; '[action] sampling mode=%s discovery=%lldms health=%lldms actor=%lldms skill=%lldms loop=%lldms\n'
00418924: csel     x2, x9, x8, eq
00418928: bl       #0x554500 ; fprintf
0041892c: ldr      x0, [x25]
00418930: bl       #0x5540e0 ; fflush
00418934: b        #0x4183ec
00418938: mov      w9, wzr
0041893c: str      x8, [x20, #0x2d10]
00418940: ldr      w10, [x20, #0x10c]
00418944: mov      w11, #8
00418948: ldrsw    x12, [x20, #0x110]
0041894c: ldr      w13, [x20, #0x958]
00418950: cmp      w10, #8
00418954: add      x8, x8, x12
00418958: csel     w10, w10, w11, hi
0041895c: cmp      w9, #0x3e8
00418960: mov      w11, #0x3e8
00418964: csel     w9, w9, wzr, lt
00418968: smaddl   x12, w9, w10, x8
0041896c: sub      w8, w11, w9
00418970: mov      w11, #0xffffff
00418974: cmp      w8, w13
00418978: sxtw     x10, w10
0041897c: csel     w13, w8, w13, lt
00418980: add      w8, w13, w9
00418984: cmp      x12, x11
00418988: stur     x12, [x29, #-0x20]
0041898c: stur     w13, [x29, #-0x18]
00418990: str      w8, [x20, #0x95c]
00418994: stur     x10, [x29, #-0x10]
00418998: b.lo     #0x4189b0
0041899c: sub      x1, x29, #0x20
004189a0: mov      x0, x20
004189a4: bl       #0x41a4ec
004189a8: tbz      w0, #0, #0x4189c0
004189ac: ldr      w8, [x20, #0x95c]
004189b0: cmp      w8, #0x3e8
004189b4: b.lt     #0x4189c4
004189b8: add      x0, x20, #0x220
004189bc: bl       #0x41a6b0
004189c0: str      wzr, [x20, #0x95c]
004189c4: ldr      x8, [sp, #0x40]
004189c8: nop      
004189cc: madd     x8, x8, x22, x19
004189d0: str      x8, [x20, #0x2cf8]
004189d4: ldr      x8, [x20, #0x2d20]
004189d8: cmp      x19, x8
004189dc: cset     w8, lt
004189e0: bic      w8, w8, w25
004189e4: tbnz     w8, #0, #0x418a1c
004189e8: mov      w8, #0x2d20
004189ec: mov      w24, #0x2c50
004189f0: stur     x20, [x29, #-0x20]
004189f4: add      x23, x20, x8
004189f8: bl       #0x50aaf8
004189fc: mov      x2, x0
00418a00: add      x0, x20, x24
00418a04: sub      x1, x29, #0x20
00418a08: bl       #0x4386a4
00418a0c: ldr      x8, [sp, #0x58]
00418a10: nop      
00418a14: madd     x8, x8, x22, x19
00418a18: str      x8, [x23]
00418a1c: ldr      x8, [x21, #0x28]
00418a20: ldur     x9, [x29, #-8]
00418a24: cmp      x8, x9
00418a28: b.ne     #0x418aa8
00418a2c: ldp      x20, x19, [sp, #0xe0]
00418a30: ldp      x22, x21, [sp, #0xd0]
00418a34: ldp      x24, x23, [sp, #0xc0]
00418a38: ldp      x26, x25, [sp, #0xb0]
00418a3c: ldp      x28, x27, [sp, #0xa0]
00418a40: ldp      x29, x30, [sp, #0x90]
00418a44: add      sp, sp, #0xf0
00418a48: ret      
00418a4c: add      x0, x20, #0x130
00418a50: mov      w1, #1
00418a54: mov      w25, #1
00418a58: bl       #0x41901c
00418a5c: ldr      x8, [sp, #0x38]
00418a60: nop      
00418a64: madd     x8, x8, x22, x19
00418a68: str      x8, [x20, #0x2cf0]
00418a6c: mov      w27, #1
00418a70: b        #0x418500
00418a74: ldr      x12, [x8]
00418a78: mov      w11, #0x1b00
00418a7c: b        #0x418a88
00418a80: cmp      x10, x9
00418a84: b.eq     #0x4188f0
00418a88: str      x19, [x10, #0x1a8]
00418a8c: add      x10, x10, #0x1b0
00418a90: sub      x13, x10, x12
00418a94: cmp      x13, x11
00418a98: b.ne     #0x418a80
00418a9c: ldr      x12, [x8, #8]!
00418aa0: mov      x10, x12
00418aa4: b        #0x418a80
00418aa8: bl       #0x553f00 ; __stack_chk_fail
