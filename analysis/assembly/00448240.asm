00448240: sub      sp, sp, #0x60
00448244: stp      x29, x30, [sp, #0x20]
00448248: stp      x24, x23, [sp, #0x30]
0044824c: stp      x22, x21, [sp, #0x40]
00448250: stp      x20, x19, [sp, #0x50]
00448254: add      x29, sp, #0x20
00448258: mrs      x23, tpidr_el0
0044825c: movi     v0.2d, #0000000000000000
00448260: mov      x20, x0
00448264: ldr      x8, [x23, #0x28]
00448268: mov      x24, x0
0044826c: mov      x19, x1
00448270: stur     x8, [x29, #-8]
00448274: mov      w8, #0xd
00448278: str      x8, [x0]
0044827c: stur     q0, [x0, #0x18]
00448280: stur     q0, [x0, #0x28]
00448284: stur     q0, [x0, #0x38]
00448288: stur     q0, [x0, #0x48]
0044828c: stur     q0, [x0, #0x58]
00448290: stur     q0, [x0, #0x68]
00448294: stur     q0, [x0, #0x78]
00448298: stur     q0, [x0, #0x88]
0044829c: stur     q0, [x0, #0x98]
004482a0: stur     q0, [x0, #0xa8]
004482a4: stur     q0, [x0, #0xb8]
004482a8: stur     q0, [x0, #0xc8]
004482ac: stur     q0, [x0, #0xd8]
004482b0: stur     q0, [x0, #0xe8]
004482b4: stur     q0, [x0, #0xf8]
004482b8: str      xzr, [x0, #0x118]
004482bc: mov      w0, #0x90
004482c0: str      q0, [x24, #8]!
004482c4: str      q0, [x24, #0x100]
004482c8: bl       #0x54dfc0
004482cc: movi     v1.2d, #0000000000000000
004482d0: adrp     x8, #0x20000
004482d4: mov      x1, x0
004482d8: ldr      q0, [x8, #0x280]
004482dc: str      x0, [sp, #0x10]
004482e0: strb     wzr, [x0, #0x80]
004482e4: str      q0, [sp]
004482e8: stp      q1, q1, [x0]
004482ec: stp      q1, q1, [x0, #0x20]
004482f0: stp      q1, q1, [x0, #0x40]
004482f4: stp      q1, q1, [x0, #0x60]
004482f8: adrp     x0, #0x29000
004482fc: add      x0, x0, #0x53 ; 'ro.build.version.release'
00448300: bl       #0x554160 ; __system_property_get
00448304: sxtw     x1, w0
00448308: mov      x0, sp
0044830c: mov      w2, wzr
00448310: bl       #0x50c4a8
00448314: ldrb     w8, [sp]
00448318: ldr      x9, [sp, #8]
0044831c: lsr      x10, x8, #1
00448320: tst      w8, #1
00448324: csel     x8, x10, x9, eq
00448328: cbz      x8, #0x448368
0044832c: mov      x0, sp
00448330: mov      x1, xzr
00448334: mov      w2, #0xa
00448338: bl       #0x50ca28
0044833c: sxtw     x3, w0
00448340: str      x3, [x20]
00448344: cmp      x3, #4
00448348: b.hi     #0x448374
0044834c: adrp     x1, #0x20000
00448350: add      x1, x1, #0xdd3
00448354: adrp     x2, #0x22000
00448358: add      x2, x2, #0xf07
0044835c: mov      w0, #6
00448360: bl       #0x554b10 ; __android_log_print
00448364: b        #0x449040
00448368: ldr      x3, [x20]
0044836c: cmp      x3, #4
00448370: b.ls     #0x44834c
00448374: ldr      x8, [x19]
00448378: adrp     x0, #0x26000
0044837c: add      x0, x0, #0xe61
00448380: mov      w1, #1
00448384: blr      x8
00448388: mov      x21, x0
0044838c: ldr      x8, [x19]
00448390: adrp     x0, #0x25000
00448394: add      x0, x0, #0xa31
00448398: mov      w1, #1
0044839c: blr      x8
004483a0: cbz      x21, #0x448568
004483a4: mov      x22, x0
004483a8: cbz      x0, #0x448568
004483ac: ldr      x8, [x19, #8]
004483b0: adrp     x1, #0x25000
004483b4: add      x1, x1, #0xa4b
004483b8: mov      x0, x22
004483bc: blr      x8
004483c0: str      x0, [x24]
004483c4: cbnz     x0, #0x4483f8
004483c8: adrp     x1, #0x20000
004483cc: add      x1, x1, #0xdd3
004483d0: adrp     x2, #0x22000
004483d4: add      x2, x2, #0x9ef
004483d8: adrp     x3, #0x25000
004483dc: add      x3, x3, #0xa4b
004483e0: adrp     x4, #0x2b000
004483e4: add      x4, x4, #0xdf3
004483e8: adrp     x5, #0x26000
004483ec: add      x5, x5, #0x996
004483f0: mov      w0, #6
004483f4: bl       #0x554b10 ; __android_log_print
004483f8: ldr      x8, [x19, #8]
004483fc: adrp     x1, #0x28000
00448400: add      x1, x1, #0x738
00448404: mov      x0, x22
00448408: blr      x8
0044840c: str      x0, [x20, #0x10]
00448410: cbnz     x0, #0x448444
00448414: adrp     x1, #0x20000
00448418: add      x1, x1, #0xdd3
0044841c: adrp     x2, #0x22000
00448420: add      x2, x2, #0x9ef
00448424: adrp     x3, #0x28000
00448428: add      x3, x3, #0x738
0044842c: adrp     x4, #0x2b000
00448430: add      x4, x4, #0xdf3
00448434: adrp     x5, #0x27000
00448438: add      x5, x5, #0xd1b
0044843c: mov      w0, #6
00448440: bl       #0x554b10 ; __android_log_print
00448444: ldr      x8, [x19, #8]
00448448: adrp     x1, #0x22000
0044844c: add      x1, x1, #0xa12
00448450: mov      x0, x22
00448454: blr      x8
00448458: str      x0, [x20, #0x18]
0044845c: cbnz     x0, #0x448490
00448460: adrp     x1, #0x20000
00448464: add      x1, x1, #0xdd3
00448468: adrp     x2, #0x22000
0044846c: add      x2, x2, #0x9ef
00448470: adrp     x3, #0x22000
00448474: add      x3, x3, #0xa12
00448478: adrp     x4, #0x27000
0044847c: add      x4, x4, #0x3c7
00448480: adrp     x5, #0x28000
00448484: add      x5, x5, #0x2cd
00448488: mov      w0, #6
0044848c: bl       #0x554b10 ; __android_log_print
00448490: ldr      x8, [x19, #8]
00448494: adrp     x1, #0x24000
00448498: add      x1, x1, #0xab
0044849c: mov      x0, x22
004484a0: blr      x8
004484a4: str      x0, [x20, #0x20]
004484a8: cbnz     x0, #0x4484dc
004484ac: adrp     x1, #0x20000
004484b0: add      x1, x1, #0xdd3
004484b4: adrp     x2, #0x22000
004484b8: add      x2, x2, #0x9ef
004484bc: adrp     x3, #0x24000
004484c0: add      x3, x3, #0xab
004484c4: adrp     x4, #0x27000
004484c8: add      x4, x4, #0x3c7
004484cc: adrp     x5, #0x27000
004484d0: add      x5, x5, #0x3cf
004484d4: mov      w0, #6
004484d8: bl       #0x554b10 ; __android_log_print
004484dc: ldr      x8, [x20]
004484e0: sub      x9, x8, #0xa
004484e4: cmp      x9, #3
004484e8: b.hi     #0x44858c
004484ec: ldr      x8, [x19, #8]
004484f0: adrp     x1, #0x27000
004484f4: add      x1, x1, #0x3da
004484f8: mov      x0, x21
004484fc: blr      x8
00448500: str      x0, [x20, #0x28]
00448504: cbnz     x0, #0x448538
00448508: adrp     x1, #0x20000
0044850c: add      x1, x1, #0xdd3
00448510: adrp     x2, #0x22000
00448514: add      x2, x2, #0x9ef
00448518: adrp     x3, #0x27000
0044851c: add      x3, x3, #0x3da
00448520: adrp     x4, #0x27000
00448524: add      x4, x4, #0xd25
00448528: adrp     x5, #0x28000
0044852c: add      x5, x5, #0x2cd
00448530: mov      w0, #6
00448534: bl       #0x554b10 ; __android_log_print
00448538: ldr      x8, [x19, #8]
0044853c: adrp     x1, #0x21000
00448540: add      x1, x1, #0x74f
00448544: mov      x0, x21
00448548: blr      x8
0044854c: str      x0, [x20, #0x30]
00448550: cbnz     x0, #0x4485e0
00448554: adrp     x5, #0x24000
00448558: add      x5, x5, #0xb16
0044855c: adrp     x3, #0x21000
00448560: add      x3, x3, #0x74f
00448564: b        #0x4485c0
00448568: bl       #0x554b20 ; dlerror
0044856c: mov      x3, x0
00448570: adrp     x1, #0x20000
00448574: add      x1, x1, #0xdd3
00448578: adrp     x2, #0x22000
0044857c: add      x2, x2, #0xf2b
00448580: mov      w0, #6
00448584: bl       #0x554b10 ; __android_log_print
00448588: b        #0x449040
0044858c: cmp      x8, #0xe
00448590: b.lo     #0x4485e0
00448594: ldr      x8, [x19, #8]
00448598: adrp     x1, #0x25000
0044859c: add      x1, x1, #0x436
004485a0: mov      x0, x21
004485a4: blr      x8
004485a8: str      x0, [x20, #0x28]
004485ac: cbnz     x0, #0x4485e0
004485b0: adrp     x5, #0x28000
004485b4: add      x5, x5, #0x2cd
004485b8: adrp     x3, #0x25000
004485bc: add      x3, x3, #0x436
004485c0: adrp     x1, #0x20000
004485c4: add      x1, x1, #0xdd3
004485c8: adrp     x2, #0x22000
004485cc: add      x2, x2, #0x9ef
004485d0: adrp     x4, #0x27000
004485d4: add      x4, x4, #0xd25
004485d8: mov      w0, #6
004485dc: bl       #0x554b10 ; __android_log_print
004485e0: ldr      x8, [x19, #8]
004485e4: adrp     x1, #0x27000
004485e8: add      x1, x1, #0x3f9
004485ec: mov      x0, x21
004485f0: blr      x8
004485f4: str      x0, [x20, #0x38]
004485f8: cbnz     x0, #0x44862c
004485fc: adrp     x1, #0x20000
00448600: add      x1, x1, #0xdd3
00448604: adrp     x2, #0x22000
00448608: add      x2, x2, #0x9ef
0044860c: adrp     x3, #0x27000
00448610: add      x3, x3, #0x3f9
00448614: adrp     x4, #0x23000
00448618: add      x4, x4, #0xbe1
0044861c: adrp     x5, #0x28000
00448620: add      x5, x5, #0x2cd
00448624: mov      w0, #6
00448628: bl       #0x554b10 ; __android_log_print
0044862c: ldr      x8, [x20]
00448630: sub      x9, x8, #5
00448634: cmp      x9, #2
00448638: b.hi     #0x448ddc
0044863c: ldr      x8, [x19, #8]
00448640: adrp     x1, #0x29000
00448644: add      x1, x1, #0x6c
00448648: mov      x0, x21
0044864c: blr      x8
00448650: str      x0, [x20, #0x48]
00448654: cbnz     x0, #0x448688
00448658: adrp     x5, #0x29000
0044865c: add      x5, x5, #0xb1
00448660: adrp     x3, #0x29000
00448664: add      x3, x3, #0x6c
00448668: adrp     x1, #0x20000
0044866c: add      x1, x1, #0xdd3
00448670: adrp     x2, #0x22000
00448674: add      x2, x2, #0x9ef
00448678: adrp     x4, #0x23000
0044867c: add      x4, x4, #0xbe1
00448680: mov      w0, #6
00448684: bl       #0x554b10 ; __android_log_print
00448688: ldr      x8, [x20]
0044868c: cmp      x8, #0xb
00448690: b.lo     #0x4486e0
00448694: ldr      x8, [x19, #8]
00448698: adrp     x1, #0x24000
0044869c: add      x1, x1, #0xc3
004486a0: mov      x0, x21
004486a4: blr      x8
004486a8: str      x0, [x20, #0x60]
004486ac: cbnz     x0, #0x4486e0
004486b0: adrp     x1, #0x20000
004486b4: add      x1, x1, #0xdd3
004486b8: adrp     x2, #0x22000
004486bc: add      x2, x2, #0x9ef
004486c0: adrp     x3, #0x24000
004486c4: add      x3, x3, #0xc3
004486c8: adrp     x4, #0x23000
004486cc: add      x4, x4, #0xbe1
004486d0: adrp     x5, #0x29000
004486d4: add      x5, x5, #0x11b
004486d8: mov      w0, #6
004486dc: bl       #0x554b10 ; __android_log_print
004486e0: ldr      x8, [x20]
004486e4: sub      x8, x8, #5
004486e8: cmp      x8, #4
004486ec: b.hi     #0x44873c
004486f0: ldr      x8, [x19, #8]
004486f4: adrp     x1, #0x28000
004486f8: add      x1, x1, #0xbd6
004486fc: mov      x0, x21
00448700: blr      x8
00448704: str      x0, [x20, #0x70]
00448708: cbnz     x0, #0x44873c
0044870c: adrp     x1, #0x20000
00448710: add      x1, x1, #0xdd3
00448714: adrp     x2, #0x22000
00448718: add      x2, x2, #0x9ef
0044871c: adrp     x3, #0x28000
00448720: add      x3, x3, #0xbd6
00448724: adrp     x4, #0x23000
00448728: add      x4, x4, #0xbe1
0044872c: adrp     x5, #0x21000
00448730: add      x5, x5, #0x2a3
00448734: mov      w0, #6
00448738: bl       #0x554b10 ; __android_log_print
0044873c: ldr      x8, [x20]
00448740: sub      x9, x8, #0xa
00448744: cmp      x9, #3
00448748: b.hi     #0x44879c
0044874c: ldr      x8, [x19, #8]
00448750: adrp     x1, #0x26000
00448754: add      x1, x1, #0x4ff
00448758: mov      x0, x21
0044875c: blr      x8
00448760: str      x0, [x20, #0x68]
00448764: cbnz     x0, #0x448798
00448768: adrp     x1, #0x20000
0044876c: add      x1, x1, #0xdd3
00448770: adrp     x2, #0x22000
00448774: add      x2, x2, #0x9ef
00448778: adrp     x3, #0x26000
0044877c: add      x3, x3, #0x4ff
00448780: adrp     x4, #0x23000
00448784: add      x4, x4, #0xbe1
00448788: adrp     x5, #0x28000
0044878c: add      x5, x5, #0x75b
00448790: mov      w0, #6
00448794: bl       #0x554b10 ; __android_log_print
00448798: ldr      x8, [x20]
0044879c: cmp      x8, #0xa
004487a0: b.lo     #0x4487f0
004487a4: ldr      x8, [x19, #8]
004487a8: adrp     x1, #0x29000
004487ac: add      x1, x1, #0x129
004487b0: mov      x0, x21
004487b4: blr      x8
004487b8: str      x0, [x20, #0x88]
004487bc: cbnz     x0, #0x4487f0
004487c0: adrp     x1, #0x20000
004487c4: add      x1, x1, #0xdd3
004487c8: adrp     x2, #0x22000
004487cc: add      x2, x2, #0x9ef
004487d0: adrp     x3, #0x29000
004487d4: add      x3, x3, #0x129
004487d8: adrp     x4, #0x23000
004487dc: add      x4, x4, #0xbe1
004487e0: adrp     x5, #0x20000
004487e4: add      x5, x5, #0xdda
004487e8: mov      w0, #6
004487ec: bl       #0x554b10 ; __android_log_print
004487f0: ldr      x8, [x20]
004487f4: cmp      x8, #0xc
004487f8: b.lo     #0x448848
004487fc: ldr      x8, [x19, #8]
00448800: adrp     x1, #0x21000
00448804: add      x1, x1, #0x7e3
00448808: mov      x0, x21
0044880c: blr      x8
00448810: str      x0, [x20, #0x90]
00448814: cbnz     x0, #0x448848
00448818: adrp     x1, #0x20000
0044881c: add      x1, x1, #0xdd3
00448820: adrp     x2, #0x22000
00448824: add      x2, x2, #0x9ef
00448828: adrp     x3, #0x21000
0044882c: add      x3, x3, #0x7e3
00448830: adrp     x4, #0x23000
00448834: add      x4, x4, #0xbe1
00448838: adrp     x5, #0x21000
0044883c: add      x5, x5, #0x837
00448840: mov      w0, #6
00448844: bl       #0x554b10 ; __android_log_print
00448848: ldr      x8, [x20]
0044884c: sub      x9, x8, #5
00448850: cmp      x9, #6
00448854: b.hi     #0x4488a8
00448858: ldr      x8, [x19, #8]
0044885c: adrp     x1, #0x28000
00448860: add      x1, x1, #0x773
00448864: mov      x0, x21
00448868: blr      x8
0044886c: str      x0, [x20, #0x80]
00448870: cbnz     x0, #0x4488a4
00448874: adrp     x1, #0x20000
00448878: add      x1, x1, #0xdd3
0044887c: adrp     x2, #0x22000
00448880: add      x2, x2, #0x9ef
00448884: adrp     x3, #0x28000
00448888: add      x3, x3, #0x773
0044888c: adrp     x4, #0x23000
00448890: add      x4, x4, #0xbe1
00448894: adrp     x5, #0x29000
00448898: add      x5, x5, #0xeb9
0044889c: mov      w0, #6
004488a0: bl       #0x554b10 ; __android_log_print
004488a4: ldr      x8, [x20]
004488a8: cmp      x8, #0xb
004488ac: b.lo     #0x4488fc
004488b0: ldr      x8, [x19, #8]
004488b4: adrp     x1, #0x22000
004488b8: add      x1, x1, #0xaa1
004488bc: mov      x0, x21
004488c0: blr      x8
004488c4: str      x0, [x20, #0x78]
004488c8: cbnz     x0, #0x4488fc
004488cc: adrp     x1, #0x20000
004488d0: add      x1, x1, #0xdd3
004488d4: adrp     x2, #0x22000
004488d8: add      x2, x2, #0x9ef
004488dc: adrp     x3, #0x22000
004488e0: add      x3, x3, #0xaa1
004488e4: adrp     x4, #0x23000
004488e8: add      x4, x4, #0xbe1
004488ec: adrp     x5, #0x27000
004488f0: add      x5, x5, #0x922
004488f4: mov      w0, #6
004488f8: bl       #0x554b10 ; __android_log_print
004488fc: ldr      x8, [x20]
00448900: sub      x9, x8, #5
00448904: cmp      x9, #3
00448908: b.hi     #0x4489a8
0044890c: ldr      x8, [x19, #8]
00448910: adrp     x1, #0x29000
00448914: add      x1, x1, #0x165
00448918: mov      x0, x21
0044891c: blr      x8
00448920: str      x0, [x20, #0x98]
00448924: cbnz     x0, #0x448958
00448928: adrp     x1, #0x20000
0044892c: add      x1, x1, #0xdd3
00448930: adrp     x2, #0x22000
00448934: add      x2, x2, #0x9ef
00448938: adrp     x3, #0x29000
0044893c: add      x3, x3, #0x165
00448940: adrp     x4, #0x23000
00448944: add      x4, x4, #0xbe1
00448948: adrp     x5, #0x26000
0044894c: add      x5, x5, #0xeea
00448950: mov      w0, #6
00448954: bl       #0x554b10 ; __android_log_print
00448958: ldr      x8, [x19, #8]
0044895c: adrp     x1, #0x28000
00448960: add      x1, x1, #0xc0e
00448964: mov      x0, x21
00448968: blr      x8
0044896c: str      x0, [x20, #0xa0]
00448970: cbnz     x0, #0x4489a4
00448974: adrp     x1, #0x20000
00448978: add      x1, x1, #0xdd3
0044897c: adrp     x2, #0x22000
00448980: add      x2, x2, #0x9ef
00448984: adrp     x3, #0x28000
00448988: add      x3, x3, #0xc0e
0044898c: adrp     x4, #0x23000
00448990: add      x4, x4, #0xbe1
00448994: adrp     x5, #0x26000
00448998: add      x5, x5, #0x53d
0044899c: mov      w0, #6
004489a0: bl       #0x554b10 ; __android_log_print
004489a4: ldr      x8, [x20]
004489a8: cmp      x8, #0xc
004489ac: b.lo     #0x4489fc
004489b0: ldr      x8, [x19, #8]
004489b4: adrp     x1, #0x21000
004489b8: add      x1, x1, #0x84f
004489bc: mov      x0, x21
004489c0: blr      x8
004489c4: str      x0, [x20, #0xa8]
004489c8: cbnz     x0, #0x4489fc
004489cc: adrp     x1, #0x20000
004489d0: add      x1, x1, #0xdd3
004489d4: adrp     x2, #0x22000
004489d8: add      x2, x2, #0x9ef
004489dc: adrp     x3, #0x21000
004489e0: add      x3, x3, #0x84f
004489e4: adrp     x4, #0x24000
004489e8: add      x4, x4, #0x10b
004489ec: adrp     x5, #0x28000
004489f0: add      x5, x5, #0x2cd
004489f4: mov      w0, #6
004489f8: bl       #0x554b10 ; __android_log_print
004489fc: ldr      x8, [x20]
00448a00: cmp      x8, #9
00448a04: b.lo     #0x448bec
00448a08: ldr      x8, [x19, #8]
00448a0c: adrp     x1, #0x29000
00448a10: add      x1, x1, #0xec8
00448a14: mov      x0, x21
00448a18: blr      x8
00448a1c: str      x0, [x20, #0xb0]
00448a20: cbnz     x0, #0x448a54
00448a24: adrp     x1, #0x20000
00448a28: add      x1, x1, #0xdd3
00448a2c: adrp     x2, #0x22000
00448a30: add      x2, x2, #0x9ef
00448a34: adrp     x3, #0x29000
00448a38: add      x3, x3, #0xec8
00448a3c: adrp     x4, #0x24000
00448a40: add      x4, x4, #0x10b
00448a44: adrp     x5, #0x28000
00448a48: add      x5, x5, #0x2d9
00448a4c: mov      w0, #6
00448a50: bl       #0x554b10 ; __android_log_print
00448a54: ldr      x8, [x19, #8]
00448a58: adrp     x1, #0x29000
00448a5c: add      x1, x1, #0xf22
00448a60: mov      x0, x21
00448a64: blr      x8
00448a68: str      x0, [x20, #0xc8]
00448a6c: cbnz     x0, #0x448aa0
00448a70: adrp     x1, #0x20000
00448a74: add      x1, x1, #0xdd3
00448a78: adrp     x2, #0x22000
00448a7c: add      x2, x2, #0x9ef
00448a80: adrp     x3, #0x29000
00448a84: add      x3, x3, #0xf22
00448a88: adrp     x4, #0x24000
00448a8c: add      x4, x4, #0x10b
00448a90: adrp     x5, #0x2a000
00448a94: add      x5, x5, #0xfbe
00448a98: mov      w0, #6
00448a9c: bl       #0x554b10 ; __android_log_print
00448aa0: ldr      x8, [x19, #8]
00448aa4: adrp     x1, #0x2a000
00448aa8: add      x1, x1, #0x997
00448aac: mov      x0, x21
00448ab0: blr      x8
00448ab4: str      x0, [x20, #0xd0]
00448ab8: cbnz     x0, #0x448aec
00448abc: adrp     x1, #0x20000
00448ac0: add      x1, x1, #0xdd3
00448ac4: adrp     x2, #0x22000
00448ac8: add      x2, x2, #0x9ef
00448acc: adrp     x3, #0x2a000
00448ad0: add      x3, x3, #0x997
00448ad4: adrp     x4, #0x24000
00448ad8: add      x4, x4, #0x10b
00448adc: adrp     x5, #0x2b000
00448ae0: add      x5, x5, #0x94d
00448ae4: mov      w0, #6
00448ae8: bl       #0x554b10 ; __android_log_print
00448aec: ldr      x8, [x20]
00448af0: cmp      x8, #0xc
00448af4: b.lo     #0x448b94
00448af8: ldr      x8, [x19, #8]
00448afc: adrp     x1, #0x25000
00448b00: add      x1, x1, #0x459
00448b04: mov      x0, x21
00448b08: blr      x8
00448b0c: str      x0, [x20, #0xb8]
00448b10: cbnz     x0, #0x448b44
00448b14: adrp     x1, #0x20000
00448b18: add      x1, x1, #0xdd3
00448b1c: adrp     x2, #0x22000
00448b20: add      x2, x2, #0x9ef
00448b24: adrp     x3, #0x25000
00448b28: add      x3, x3, #0x459
00448b2c: adrp     x4, #0x24000
00448b30: add      x4, x4, #0x10b
00448b34: adrp     x5, #0x22000
00448b38: add      x5, x5, #0xb03
00448b3c: mov      w0, #6
00448b40: bl       #0x554b10 ; __android_log_print
00448b44: ldr      x8, [x19, #8]
00448b48: adrp     x1, #0x22000
00448b4c: add      x1, x1, #0xf65
00448b50: mov      x0, x21
00448b54: blr      x8
00448b58: str      x0, [x20, #0xd8]
00448b5c: cbnz     x0, #0x448b90
00448b60: adrp     x1, #0x20000
00448b64: add      x1, x1, #0xdd3
00448b68: adrp     x2, #0x22000
00448b6c: add      x2, x2, #0x9ef
00448b70: adrp     x3, #0x22000
00448b74: add      x3, x3, #0xf65
00448b78: adrp     x4, #0x24000
00448b7c: add      x4, x4, #0x10b
00448b80: adrp     x5, #0x25000
00448b84: add      x5, x5, #0xa6e
00448b88: mov      w0, #6
00448b8c: bl       #0x554b10 ; __android_log_print
00448b90: ldr      x8, [x20]
00448b94: cmp      x8, #9
00448b98: b.lo     #0x448be8
00448b9c: ldr      x8, [x19, #8]
00448ba0: adrp     x1, #0x2a000
00448ba4: add      x1, x1, #0xfc3
00448ba8: mov      x0, x21
00448bac: blr      x8
00448bb0: str      x0, [x20, #0xe0]
00448bb4: cbnz     x0, #0x448be8
00448bb8: adrp     x1, #0x20000
00448bbc: add      x1, x1, #0xdd3
00448bc0: adrp     x2, #0x22000
00448bc4: add      x2, x2, #0x9ef
00448bc8: adrp     x3, #0x2a000
00448bcc: add      x3, x3, #0xfc3
00448bd0: adrp     x4, #0x24000
00448bd4: add      x4, x4, #0x10b
00448bd8: adrp     x5, #0x22000
00448bdc: add      x5, x5, #0xfc1
00448be0: mov      w0, #6
00448be4: bl       #0x554b10 ; __android_log_print
00448be8: ldr      x8, [x20]
00448bec: cmp      x8, #5
00448bf0: b.lo     #0x448c40
00448bf4: ldr      x8, [x19, #8]
00448bf8: adrp     x1, #0x23000
00448bfc: add      x1, x1, #0x597
00448c00: mov      x0, x21
00448c04: blr      x8
00448c08: str      x0, [x20, #0xe8]
00448c0c: cbnz     x0, #0x448c40
00448c10: adrp     x1, #0x20000
00448c14: add      x1, x1, #0xdd3
00448c18: adrp     x2, #0x22000
00448c1c: add      x2, x2, #0x9ef
00448c20: adrp     x3, #0x23000
00448c24: add      x3, x3, #0x597
00448c28: adrp     x4, #0x24000
00448c2c: add      x4, x4, #0x10b
00448c30: adrp     x5, #0x24000
00448c34: add      x5, x5, #0xb1f
00448c38: mov      w0, #6
00448c3c: bl       #0x554b10 ; __android_log_print
00448c40: ldr      x8, [x20]
00448c44: cmp      x8, #0xd
00448c48: b.lo     #0x448c98
00448c4c: ldr      x8, [x19, #8]
00448c50: adrp     x1, #0x2a000
00448c54: add      x1, x1, #0x47b
00448c58: mov      x0, x21
00448c5c: blr      x8
00448c60: str      x0, [x20, #0xc0]
00448c64: cbnz     x0, #0x448c98
00448c68: adrp     x1, #0x20000
00448c6c: add      x1, x1, #0xdd3
00448c70: adrp     x2, #0x22000
00448c74: add      x2, x2, #0x9ef
00448c78: adrp     x3, #0x2a000
00448c7c: add      x3, x3, #0x47b
00448c80: adrp     x4, #0x24000
00448c84: add      x4, x4, #0x10b
00448c88: adrp     x5, #0x23000
00448c8c: add      x5, x5, #0x5f6
00448c90: mov      w0, #6
00448c94: bl       #0x554b10 ; __android_log_print
00448c98: ldr      x8, [x20]
00448c9c: sub      x9, x8, #9
00448ca0: cmp      x9, #3
00448ca4: b.hi     #0x448cf8
00448ca8: ldr      x8, [x19, #8]
00448cac: adrp     x1, #0x29000
00448cb0: add      x1, x1, #0x869
00448cb4: mov      x0, x21
00448cb8: blr      x8
00448cbc: str      x0, [x20, #0xf0]
00448cc0: cbnz     x0, #0x448cf4
00448cc4: adrp     x1, #0x20000
00448cc8: add      x1, x1, #0xdd3
00448ccc: adrp     x2, #0x22000
00448cd0: add      x2, x2, #0x9ef
00448cd4: adrp     x3, #0x29000
00448cd8: add      x3, x3, #0x869
00448cdc: adrp     x4, #0x24000
00448ce0: add      x4, x4, #0x10b
00448ce4: adrp     x5, #0x29000
00448ce8: add      x5, x5, #0x1a1
00448cec: mov      w0, #6
00448cf0: bl       #0x554b10 ; __android_log_print
00448cf4: ldr      x8, [x20]
00448cf8: cmp      x8, #0xd
00448cfc: b.lo     #0x448d4c
00448d00: ldr      x8, [x19, #8]
00448d04: adrp     x1, #0x27000
00448d08: add      x1, x1, #0x420
00448d0c: mov      x0, x21
00448d10: blr      x8
00448d14: str      x0, [x20, #0xf0]
00448d18: cbnz     x0, #0x448d4c
00448d1c: adrp     x1, #0x20000
00448d20: add      x1, x1, #0xdd3
00448d24: adrp     x2, #0x22000
00448d28: add      x2, x2, #0x9ef
00448d2c: adrp     x3, #0x27000
00448d30: add      x3, x3, #0x420
00448d34: adrp     x4, #0x24000
00448d38: add      x4, x4, #0x10b
00448d3c: adrp     x5, #0x29000
00448d40: add      x5, x5, #0x1a1
00448d44: mov      w0, #6
00448d48: bl       #0x554b10 ; __android_log_print
00448d4c: ldr      x8, [x20]
00448d50: cmp      x8, #5
00448d54: b.lo     #0x448eb8
00448d58: ldr      x8, [x19, #8]
00448d5c: adrp     x1, #0x25000
00448d60: add      x1, x1, #0xf5d
00448d64: mov      x0, x21
00448d68: blr      x8
00448d6c: str      x0, [x20, #0xf8]
00448d70: cbnz     x0, #0x448da4
00448d74: adrp     x1, #0x20000
00448d78: add      x1, x1, #0xdd3
00448d7c: adrp     x2, #0x22000
00448d80: add      x2, x2, #0x9ef
00448d84: adrp     x3, #0x25000
00448d88: add      x3, x3, #0xf5d
00448d8c: adrp     x4, #0x21000
00448d90: add      x4, x4, #0x883
00448d94: adrp     x5, #0x2b000
00448d98: add      x5, x5, #0x43c
00448d9c: mov      w0, #6
00448da0: bl       #0x554b10 ; __android_log_print
00448da4: ldr      x8, [x20]
00448da8: sub      x9, x8, #5
00448dac: cmp      x9, #6
00448db0: b.hi     #0x448e64
00448db4: ldr      x8, [x19, #8]
00448db8: adrp     x1, #0x26000
00448dbc: add      x1, x1, #0x9a0
00448dc0: mov      x0, x21
00448dc4: blr      x8
00448dc8: str      x0, [x20, #0x100]
00448dcc: cbnz     x0, #0x448eb8
00448dd0: adrp     x3, #0x26000
00448dd4: add      x3, x3, #0x9a0
00448dd8: b        #0x448e90
00448ddc: cmp      x8, #9
00448de0: b.gt     #0x448e24
00448de4: cmp      x8, #8
00448de8: b.eq     #0x4490b4
00448dec: cmp      x8, #9
00448df0: b.ne     #0x449078
00448df4: ldr      x8, [x19, #8]
00448df8: adrp     x1, #0x26000
00448dfc: add      x1, x1, #0x4a3
00448e00: mov      x0, x21
00448e04: blr      x8
00448e08: str      x0, [x20, #0x58]
00448e0c: cbnz     x0, #0x448688
00448e10: adrp     x5, #0x29000
00448e14: add      x5, x5, #0x856
00448e18: adrp     x3, #0x26000
00448e1c: add      x3, x3, #0x4a3
00448e20: b        #0x448668
00448e24: cmp      x8, #0xa
00448e28: b.eq     #0x4490e4
00448e2c: cmp      x8, #0xb
00448e30: b.ne     #0x449078
00448e34: ldr      x8, [x19, #8]
00448e38: adrp     x1, #0x21000
00448e3c: add      x1, x1, #0x234
00448e40: mov      x0, x21
00448e44: blr      x8
00448e48: str      x0, [x20, #0x48]
00448e4c: cbnz     x0, #0x448688
00448e50: adrp     x5, #0x29000
00448e54: add      x5, x5, #0xb1
00448e58: adrp     x3, #0x21000
00448e5c: add      x3, x3, #0x234
00448e60: b        #0x448668
00448e64: cmp      x8, #0xc
00448e68: b.lo     #0x448eb8
00448e6c: ldr      x8, [x19, #8]
00448e70: adrp     x1, #0x2a000
00448e74: add      x1, x1, #0x9ec
00448e78: mov      x0, x21
00448e7c: blr      x8
00448e80: str      x0, [x20, #0x100]
00448e84: cbnz     x0, #0x448eb8
00448e88: adrp     x3, #0x2a000
00448e8c: add      x3, x3, #0x9ec
00448e90: adrp     x1, #0x20000
00448e94: add      x1, x1, #0xdd3
00448e98: adrp     x2, #0x22000
00448e9c: add      x2, x2, #0x9ef
00448ea0: adrp     x4, #0x21000
00448ea4: add      x4, x4, #0x883
00448ea8: adrp     x5, #0x23000
00448eac: add      x5, x5, #0xbf7
00448eb0: mov      w0, #6
00448eb4: bl       #0x554b10 ; __android_log_print
00448eb8: ldr      x8, [x20]
00448ebc: sub      x9, x8, #5
00448ec0: cmp      x9, #1
00448ec4: b.hi     #0x448f18
00448ec8: ldr      x8, [x19, #8]
00448ecc: adrp     x1, #0x29000
00448ed0: add      x1, x1, #0x8a1
00448ed4: mov      x0, x21
00448ed8: blr      x8
00448edc: str      x0, [x20, #0x118]
00448ee0: cbnz     x0, #0x448f14
00448ee4: adrp     x1, #0x20000
00448ee8: add      x1, x1, #0xdd3
00448eec: adrp     x2, #0x22000
00448ef0: add      x2, x2, #0x9ef
00448ef4: adrp     x3, #0x29000
00448ef8: add      x3, x3, #0x8a1
00448efc: adrp     x4, #0x2b000
00448f00: add      x4, x4, #0x952
00448f04: adrp     x5, #0x28000
00448f08: add      x5, x5, #0x2e2
00448f0c: mov      w0, #6
00448f10: bl       #0x554b10 ; __android_log_print
00448f14: ldr      x8, [x20]
00448f18: cmp      x8, #7
00448f1c: b.lo     #0x448f6c
00448f20: ldr      x8, [x19, #8]
00448f24: adrp     x1, #0x25000
00448f28: add      x1, x1, #0xa77
00448f2c: mov      x0, x21
00448f30: blr      x8
00448f34: str      x0, [x20, #0x108]
00448f38: cbnz     x0, #0x448f6c
00448f3c: adrp     x1, #0x20000
00448f40: add      x1, x1, #0xdd3
00448f44: adrp     x2, #0x22000
00448f48: add      x2, x2, #0x9ef
00448f4c: adrp     x3, #0x25000
00448f50: add      x3, x3, #0xa77
00448f54: adrp     x4, #0x21000
00448f58: add      x4, x4, #0x883
00448f5c: adrp     x5, #0x28000
00448f60: add      x5, x5, #0x2e2
00448f64: mov      w0, #6
00448f68: bl       #0x554b10 ; __android_log_print
00448f6c: ldr      x8, [x20]
00448f70: cmp      x8, #8
00448f74: b.eq     #0x448f80
00448f78: cmp      x8, #5
00448f7c: b.ne     #0x448fcc
00448f80: ldr      x8, [x19, #8]
00448f84: adrp     x1, #0x27000
00448f88: add      x1, x1, #0xd33
00448f8c: mov      x0, x21
00448f90: blr      x8
00448f94: str      x0, [x20, #0x110]
00448f98: cbnz     x0, #0x448fcc
00448f9c: adrp     x1, #0x20000
00448fa0: add      x1, x1, #0xdd3
00448fa4: adrp     x2, #0x22000
00448fa8: add      x2, x2, #0x9ef
00448fac: adrp     x3, #0x27000
00448fb0: add      x3, x3, #0xd33
00448fb4: adrp     x4, #0x21000
00448fb8: add      x4, x4, #0x883
00448fbc: adrp     x5, #0x28000
00448fc0: add      x5, x5, #0x2d9
00448fc4: mov      w0, #6
00448fc8: bl       #0x554b10 ; __android_log_print
00448fcc: ldr      x8, [x20]
00448fd0: and      x8, x8, #0xfffffffffffffffe
00448fd4: cmp      x8, #6
00448fd8: b.ne     #0x449028
00448fdc: ldr      x8, [x19, #8]
00448fe0: adrp     x1, #0x27000
00448fe4: add      x1, x1, #0x459
00448fe8: mov      x0, x21
00448fec: blr      x8
00448ff0: str      x0, [x20, #0x110]
00448ff4: cbnz     x0, #0x449028
00448ff8: adrp     x1, #0x20000
00448ffc: add      x1, x1, #0xdd3
00449000: adrp     x2, #0x22000
00449004: add      x2, x2, #0x9ef
00449008: adrp     x3, #0x27000
0044900c: add      x3, x3, #0x459
00449010: adrp     x4, #0x21000
00449014: add      x4, x4, #0x883
00449018: adrp     x5, #0x28000
0044901c: add      x5, x5, #0x2d9
00449020: mov      w0, #6
00449024: bl       #0x554b10 ; __android_log_print
00449028: ldr      x8, [x19, #0x10]
0044902c: mov      x0, x22
00449030: blr      x8
00449034: ldr      x8, [x19, #0x10]
00449038: mov      x0, x21
0044903c: blr      x8
00449040: ldrb     w8, [sp]
00449044: tbz      w8, #0, #0x449050
00449048: ldr      x0, [sp, #0x10]
0044904c: bl       #0x54e070
00449050: ldr      x8, [x23, #0x28]
00449054: ldur     x9, [x29, #-8]
00449058: cmp      x8, x9
0044905c: b.ne     #0x4491bc
00449060: ldp      x20, x19, [sp, #0x50]
00449064: ldp      x22, x21, [sp, #0x40]
00449068: ldp      x24, x23, [sp, #0x30]
0044906c: ldp      x29, x30, [sp, #0x20]
00449070: add      sp, sp, #0x60
00449074: ret      
00449078: and      x9, x8, #0xfffffffffffffffe
0044907c: cmp      x9, #0xc
00449080: b.ne     #0x449114
00449084: ldr      x8, [x19, #8]
00449088: adrp     x1, #0x26000
0044908c: add      x1, x1, #0xe79
00449090: mov      x0, x21
00449094: blr      x8
00449098: str      x0, [x20, #0x48]
0044909c: cbnz     x0, #0x448688
004490a0: adrp     x5, #0x29000
004490a4: add      x5, x5, #0xb1
004490a8: adrp     x3, #0x26000
004490ac: add      x3, x3, #0xe79
004490b0: b        #0x448668
004490b4: ldr      x8, [x19, #8]
004490b8: adrp     x1, #0x29000
004490bc: add      x1, x1, #0xbf
004490c0: mov      x0, x21
004490c4: blr      x8
004490c8: str      x0, [x20, #0x50]
004490cc: cbnz     x0, #0x448688
004490d0: adrp     x5, #0x22000
004490d4: add      x5, x5, #0xf52
004490d8: adrp     x3, #0x29000
004490dc: add      x3, x3, #0xbf
004490e0: b        #0x448668
004490e4: ldr      x8, [x19, #8]
004490e8: adrp     x1, #0x21000
004490ec: add      x1, x1, #0x776
004490f0: mov      x0, x21
004490f4: blr      x8
004490f8: str      x0, [x20, #0x48]
004490fc: cbnz     x0, #0x448688
00449100: adrp     x5, #0x29000
00449104: add      x5, x5, #0xb1
00449108: adrp     x3, #0x21000
0044910c: add      x3, x3, #0x776
00449110: b        #0x448668
00449114: sub      x9, x8, #0xe
00449118: cmp      x9, #2
0044911c: b.hi     #0x449150
00449120: ldr      x8, [x19, #8]
00449124: adrp     x1, #0x22000
00449128: add      x1, x1, #0xa2c
0044912c: mov      x0, x21
00449130: blr      x8
00449134: str      x0, [x20, #0x48]
00449138: cbnz     x0, #0x448688
0044913c: adrp     x5, #0x29000
00449140: add      x5, x5, #0xb1
00449144: adrp     x3, #0x22000
00449148: add      x3, x3, #0xa2c
0044914c: b        #0x448668
00449150: cmp      x8, #0x11
00449154: b.lo     #0x448688
00449158: ldr      x8, [x19, #8]
0044915c: adrp     x1, #0x27000
00449160: add      x1, x1, #0x8ab
00449164: mov      x0, x21
00449168: blr      x8
0044916c: str      x0, [x20, #0x48]
00449170: cbnz     x0, #0x448688
00449174: adrp     x5, #0x29000
00449178: add      x5, x5, #0xb1
0044917c: adrp     x3, #0x27000
00449180: add      x3, x3, #0x8ab
00449184: b        #0x448668
00449188: b        #0x449190
0044918c: b        #0x449190
00449190: ldrb     w8, [sp]
00449194: mov      x19, x0
00449198: tbz      w8, #0, #0x4491a4
0044919c: ldr      x0, [sp, #0x10]
004491a0: bl       #0x54e070
004491a4: ldr      x8, [x23, #0x28]
004491a8: ldur     x9, [x29, #-8]
004491ac: cmp      x8, x9
004491b0: b.ne     #0x4491bc
004491b4: mov      x0, x19
004491b8: bl       #0x54fffc
004491bc: bl       #0x553f00 ; __stack_chk_fail
