00390230: stp      x29, x30, [sp, #-0x60]!
00390234: stp      x28, x27, [sp, #0x10]
00390238: stp      x26, x25, [sp, #0x20]
0039023c: stp      x24, x23, [sp, #0x30]
00390240: stp      x22, x21, [sp, #0x40]
00390244: stp      x20, x19, [sp, #0x50]
00390248: mov      x29, sp
0039024c: sub      sp, sp, #1, lsl #12
00390250: sub      sp, sp, #0x620
00390254: mrs      x24, tpidr_el0
00390258: mov      x19, x8
0039025c: mov      x21, x0
00390260: ldr      x8, [x24, #0x28]
00390264: adrp     x0, #0x562000
00390268: mov      x20, x1
0039026c: adrp     x1, #0x25000
00390270: add      x1, x1, #0xce5 ; '>>>正在验证卡密...'
00390274: mov      w2, #0x18
00390278: stur     x8, [x29, #-8]
0039027c: ldr      x0, [x0, #0xec0]
00390280: bl       #0x3a07c0
00390284: ldr      x8, [x0]
00390288: mov      x22, x0
0039028c: ldur     x9, [x8, #-0x18]
00390290: add      x8, sp, #0x290
00390294: add      x0, x0, x9
00390298: bl       #0x50eb5c
0039029c: adrp     x1, #0x562000
003902a0: add      x0, sp, #0x290
003902a4: ldr      x1, [x1, #0xe98]
003902a8: bl       #0x52d1b4
003902ac: ldr      x8, [x0]
003902b0: ldr      x8, [x8, #0x38]
003902b4: mov      w1, #0xa
003902b8: blr      x8
003902bc: mov      w23, w0
003902c0: add      x0, sp, #0x290
003902c4: bl       #0x52d0b4
003902c8: mov      x0, x22
003902cc: mov      w1, w23
003902d0: bl       #0x50ff00
003902d4: mov      x0, x22
003902d8: bl       #0x50f330
003902dc: add      x8, sp, #0x248
003902e0: bl       #0x3872e4
003902e4: ldrb     w8, [sp, #0x248]
003902e8: ldr      x9, [sp, #0x250]
003902ec: lsr      x10, x8, #1
003902f0: tst      w8, #1
003902f4: csel     x8, x10, x9, eq
003902f8: cbz      x8, #0x3903a0
003902fc: cmp      x8, #0xf
00390300: b.hi     #0x39045c
00390304: adrp     x0, #0x562000
00390308: adrp     x1, #0x27000
0039030c: add      x1, x1, #0xb2e
00390310: ldr      x0, [x0, #0xec0]
00390314: mov      w2, #0x28
00390318: bl       #0x3a07c0
0039031c: ldrb     w8, [sp, #0x248]
00390320: ldr      x9, [sp, #0x250]
00390324: lsr      x10, x8, #1
00390328: tst      w8, #1
0039032c: csel     x1, x10, x9, eq
00390330: bl       #0x50fbd8
00390334: adrp     x1, #0x25000
00390338: add      x1, x1, #0x7d3
0039033c: mov      w2, #0xa
00390340: bl       #0x3a07c0
00390344: ldr      x8, [x0]
00390348: mov      x20, x0
0039034c: ldur     x9, [x8, #-0x18]
00390350: add      x8, sp, #0x290
00390354: add      x0, x0, x9
00390358: bl       #0x50eb5c
0039035c: adrp     x1, #0x562000
00390360: add      x0, sp, #0x290
00390364: ldr      x1, [x1, #0xe98]
00390368: bl       #0x52d1b4
0039036c: ldr      x8, [x0]
00390370: ldr      x8, [x8, #0x38]
00390374: mov      w1, #0xa
00390378: blr      x8
0039037c: mov      w21, w0
00390380: add      x0, sp, #0x290
00390384: bl       #0x52d0b4
00390388: mov      x0, x20
0039038c: mov      w1, w21
00390390: bl       #0x50ff00
00390394: mov      x0, x20
00390398: bl       #0x50f330
0039039c: b        #0x390410
003903a0: adrp     x0, #0x562000
003903a4: adrp     x1, #0x26000
003903a8: add      x1, x1, #0x127
003903ac: ldr      x0, [x0, #0xec0]
003903b0: mov      w2, #0x35
003903b4: bl       #0x3a07c0
003903b8: ldr      x8, [x0]
003903bc: mov      x20, x0
003903c0: ldur     x9, [x8, #-0x18]
003903c4: add      x8, sp, #0x290
003903c8: add      x0, x0, x9
003903cc: bl       #0x50eb5c
003903d0: adrp     x1, #0x562000
003903d4: add      x0, sp, #0x290
003903d8: ldr      x1, [x1, #0xe98]
003903dc: bl       #0x52d1b4
003903e0: ldr      x8, [x0]
003903e4: ldr      x8, [x8, #0x38]
003903e8: mov      w1, #0xa
003903ec: blr      x8
003903f0: mov      w21, w0
003903f4: add      x0, sp, #0x290
003903f8: bl       #0x52d0b4
003903fc: mov      x0, x20
00390400: mov      w1, w21
00390404: bl       #0x50ff00
00390408: mov      x0, x20
0039040c: bl       #0x50f330
00390410: strb     wzr, [x19]
00390414: str      xzr, [x19, #8]
00390418: ldrb     w8, [sp, #0x248]
0039041c: tbz      w8, #0, #0x390428
00390420: ldr      x0, [sp, #0x258]
00390424: bl       #0x54e070
00390428: ldr      x8, [x24, #0x28]
0039042c: ldur     x9, [x29, #-8]
00390430: cmp      x8, x9
00390434: b.ne     #0x391608
00390438: add      sp, sp, #1, lsl #12
0039043c: add      sp, sp, #0x620
00390440: ldp      x20, x19, [sp, #0x50]
00390444: ldp      x22, x21, [sp, #0x40]
00390448: ldp      x24, x23, [sp, #0x30]
0039044c: ldp      x26, x25, [sp, #0x20]
00390450: ldp      x28, x27, [sp, #0x10]
00390454: ldp      x29, x30, [sp], #0x60
00390458: ret      
0039045c: adrp     x0, #0x562000
00390460: adrp     x1, #0x21000
00390464: add      x1, x1, #0x431
00390468: ldr      x0, [x0, #0xec0]
0039046c: mov      w2, #0xc
00390470: bl       #0x3a07c0
00390474: ldrb     w8, [sp, #0x248]
00390478: ldr      x11, [sp, #0x250]
0039047c: add      x12, sp, #0x248
00390480: ldr      x9, [sp, #0x258]
00390484: add      x13, sp, #0x290
00390488: orr      x25, x12, #1
0039048c: lsr      x10, x8, #1
00390490: tst      w8, #1
00390494: orr      x23, x13, #1
00390498: csel     x10, x10, x11, eq
0039049c: mov      w11, #0x10
003904a0: cmp      x10, #0x10
003904a4: csel     x22, x10, x11, lo
003904a8: lsl      w11, w22, #1
003904ac: strb     w11, [sp, #0x290]
003904b0: cbz      x10, #0x3904d0
003904b4: tst      w8, #1
003904b8: mov      x26, x0
003904bc: mov      x0, x23
003904c0: csel     x1, x25, x9, eq
003904c4: mov      x2, x22
003904c8: bl       #0x553f10 ; memmove
003904cc: mov      x0, x26
003904d0: strb     wzr, [x23, x22]
003904d4: mov      x1, x23
003904d8: mov      x2, x22
003904dc: bl       #0x3a07c0
003904e0: adrp     x1, #0x24000
003904e4: add      x1, x1, #0xcf4
003904e8: mov      w2, #3
003904ec: bl       #0x3a07c0
003904f0: ldr      x8, [x0]
003904f4: mov      x22, x0
003904f8: ldur     x9, [x8, #-0x18]
003904fc: add      x8, sp, #0x220
00390500: add      x0, x0, x9
00390504: bl       #0x50eb5c
00390508: adrp     x1, #0x562000
0039050c: add      x0, sp, #0x220
00390510: ldr      x1, [x1, #0xe98]
00390514: bl       #0x52d1b4
00390518: ldr      x8, [x0]
0039051c: ldr      x8, [x8, #0x38]
00390520: mov      w1, #0xa
00390524: blr      x8
00390528: mov      w23, w0
0039052c: add      x0, sp, #0x220
00390530: bl       #0x52d0b4
00390534: mov      x0, x22
00390538: mov      w1, w23
0039053c: bl       #0x50ff00
00390540: mov      x0, x22
00390544: bl       #0x50f330
00390548: ldrb     w8, [sp, #0x290]
0039054c: tbz      w8, #0, #0x390558
00390550: ldr      x0, [sp, #0x2a0]
00390554: bl       #0x54e070
00390558: adrp     x0, #0x562000
0039055c: adrp     x1, #0x26000
00390560: add      x1, x1, #0x7c1
00390564: ldr      x0, [x0, #0xec0]
00390568: mov      w2, #0x12
0039056c: bl       #0x3a07c0
00390570: ldrb     w8, [sp, #0x248]
00390574: ldr      x9, [sp, #0x250]
00390578: lsr      x10, x8, #1
0039057c: tst      w8, #1
00390580: csel     x1, x10, x9, eq
00390584: bl       #0x50fbd8
00390588: adrp     x1, #0x23000
0039058c: add      x1, x1, #0xd7b
00390590: mov      w2, #7
00390594: bl       #0x3a07c0
00390598: ldr      x8, [x0]
0039059c: mov      x22, x0
003905a0: ldur     x9, [x8, #-0x18]
003905a4: add      x8, sp, #0x290
003905a8: add      x0, x0, x9
003905ac: bl       #0x50eb5c
003905b0: adrp     x1, #0x562000
003905b4: add      x0, sp, #0x290
003905b8: ldr      x1, [x1, #0xe98]
003905bc: bl       #0x52d1b4
003905c0: ldr      x8, [x0]
003905c4: ldr      x8, [x8, #0x38]
003905c8: mov      w1, #0xa
003905cc: blr      x8
003905d0: mov      w23, w0
003905d4: add      x0, sp, #0x290
003905d8: bl       #0x52d0b4
003905dc: mov      x0, x22
003905e0: mov      w1, w23
003905e4: bl       #0x50ff00
003905e8: mov      x0, x22
003905ec: bl       #0x50f330
003905f0: mov      w8, #0x18
003905f4: adrp     x9, #0x29000
003905f8: add      x9, x9, #0x31b
003905fc: mov      w10, #0x646e
00390600: strb     w8, [sp, #0x290]
00390604: ldr      x8, [x9]
00390608: add      x22, sp, #0x1b0
0039060c: movk     w10, #0x6d6f, lsl #16
00390610: strb     wzr, [sp, #0x29d]
00390614: stur     w10, [x22, #0xe9]
00390618: stur     x8, [x22, #0xe1]
0039061c: add      x0, sp, #0x244
00390620: add      x1, sp, #0x290
00390624: bl       #0x50e904
00390628: ldrb     w8, [sp, #0x290]
0039062c: tbz      w8, #0, #0x390638
00390630: ldr      x0, [sp, #0x2a0]
00390634: bl       #0x54e070
00390638: add      x0, sp, #0x244
0039063c: bl       #0x50e9d0
00390640: mov      w10, #0x8965
00390644: mov      w8, w0
00390648: add      x23, sp, #0xa0
0039064c: mov      w9, #1
00390650: movk     w10, #0x6c07, lsl #16
00390654: add      x11, sp, #0x290
00390658: str      x8, [sp, #0x290]
0039065c: lsr      x12, x8, #0x1e
00390660: eor      w8, w12, w8
00390664: madd     w8, w8, w10, w9
00390668: str      x8, [x11, x9, lsl #3]
0039066c: add      x9, x9, #1
00390670: cmp      x9, #0x270
00390674: b.ne     #0x39065c
00390678: adrp     x8, #0x1f000
0039067c: str      xzr, [sp, #0x1610]
00390680: ldr      d0, [x8, #0xb30]
00390684: str      d0, [sp, #0x238]
00390688: bl       #0x50aa80
0039068c: mov      x8, #0x34db
00390690: movk     x8, #0xd7b6, lsl #16
00390694: movk     x8, #0xde82, lsl #32
00390698: movk     x8, #0x431b, lsl #48
0039069c: smulh    x8, x0, x8
003906a0: asr      x9, x8, #0x12
003906a4: add      x0, x9, x8, lsr #63
003906a8: add      x8, sp, #0x220
003906ac: bl       #0x50d104
003906b0: add      x0, sp, #0x238
003906b4: add      x1, sp, #0x290
003906b8: add      x2, sp, #0x238
003906bc: bl       #0x3a0b0c
003906c0: add      x8, sp, #0x208
003906c4: bl       #0x50cdb0
003906c8: add      x0, x21, #0x80
003906cc: add      x1, sp, #0x208
003906d0: bl       #0x50c24c
003906d4: adrp     x0, #0x2a000
003906d8: add      x0, x0, #0xc8b ; 'kami='
003906dc: add      x8, sp, #0x118
003906e0: mov      x1, x20
003906e4: bl       #0x50c928
003906e8: adrp     x1, #0x25000
003906ec: add      x1, x1, #0xcfe
003906f0: add      x0, sp, #0x118
003906f4: bl       #0x50c46c
003906f8: ldr      x8, [x0, #0x10]
003906fc: ldr      q0, [x0]
00390700: str      x8, [sp, #0x140]
00390704: str      q0, [x23, #0x90]
00390708: stp      xzr, xzr, [x0, #8]
0039070c: str      xzr, [x0]
00390710: ldrb     w8, [sp, #0x248]
00390714: ldr      x9, [sp, #0x258]
00390718: ldr      x10, [sp, #0x250]
0039071c: lsr      x11, x8, #1
00390720: tst      w8, #1
00390724: csel     x1, x25, x9, eq
00390728: csel     x2, x11, x10, eq
0039072c: add      x0, sp, #0x130
00390730: bl       #0x50ba70
00390734: ldr      x8, [x0, #0x10]
00390738: ldr      q0, [x0]
0039073c: str      x8, [sp, #0x160]
00390740: str      q0, [x23, #0xb0]
00390744: stp      xzr, xzr, [x0, #8]
00390748: str      xzr, [x0]
0039074c: adrp     x1, #0x28000
00390750: add      x1, x1, #0x44c
00390754: add      x0, sp, #0x150
00390758: bl       #0x50c46c
0039075c: ldr      x8, [x0, #0x10]
00390760: ldr      q0, [x0]
00390764: add      x9, sp, #0x220
00390768: orr      x26, x9, #1
0039076c: str      x8, [sp, #0x180]
00390770: str      q0, [x23, #0xd0]
00390774: stp      xzr, xzr, [x0, #8]
00390778: str      xzr, [x0]
0039077c: ldrb     w8, [sp, #0x220]
00390780: ldr      x10, [sp, #0x230]
00390784: ldr      x11, [sp, #0x228]
00390788: lsr      x12, x8, #1
0039078c: tst      w8, #1
00390790: csel     x1, x26, x10, eq
00390794: csel     x2, x12, x11, eq
00390798: add      x0, sp, #0x170
0039079c: bl       #0x50ba70
003907a0: ldr      x8, [x0, #0x10]
003907a4: ldr      q0, [x0]
003907a8: str      x8, [sp, #0x1a0]
003907ac: str      q0, [x23, #0xf0]
003907b0: stp      xzr, xzr, [x0, #8]
003907b4: str      xzr, [x0]
003907b8: adrp     x1, #0x24000
003907bc: add      x1, x1, #0x8c7
003907c0: add      x0, sp, #0x190
003907c4: bl       #0x50c46c
003907c8: ldr      x8, [x0, #0x10]
003907cc: ldr      q0, [x0]
003907d0: str      x8, [sp, #0x1c0]
003907d4: str      q0, [x23, #0x110]
003907d8: stp      xzr, xzr, [x0, #8]
003907dc: str      xzr, [x0]
003907e0: ldrb     w8, [x21, #0x30]
003907e4: ldp      x10, x9, [x21, #0x38]
003907e8: lsr      x11, x8, #1
003907ec: tst      w8, #1
003907f0: add      x8, x21, #0x31
003907f4: csel     x1, x8, x9, eq
003907f8: csel     x2, x11, x10, eq
003907fc: add      x0, sp, #0x1b0
00390800: bl       #0x50ba70
00390804: ldr      q0, [x0]
00390808: str      q0, [x22, #0x20]
0039080c: ldr      x8, [x0, #0x10]
00390810: str      x8, [sp, #0x1e0]
00390814: stp      xzr, xzr, [x0, #8]
00390818: str      xzr, [x0]
0039081c: add      x8, sp, #0x1f0
00390820: add      x0, sp, #0x1d0
00390824: bl       #0x38d3a8
00390828: ldrb     w8, [sp, #0x1d0]
0039082c: tbnz     w8, #0, #0x390bbc
00390830: ldrb     w8, [sp, #0x1b0]
00390834: tbnz     w8, #0, #0x390bcc
00390838: ldrb     w8, [sp, #0x190]
0039083c: tbnz     w8, #0, #0x390bdc
00390840: ldrb     w8, [sp, #0x170]
00390844: tbnz     w8, #0, #0x390bec
00390848: ldrb     w8, [sp, #0x150]
0039084c: tbnz     w8, #0, #0x390bfc
00390850: ldrb     w8, [sp, #0x130]
00390854: tbnz     w8, #0, #0x390c0c
00390858: ldrb     w8, [sp, #0x118]
0039085c: tbz      w8, #0, #0x390868
00390860: ldr      x0, [sp, #0x128]
00390864: bl       #0x54e070
00390868: adrp     x9, #0x21000
0039086c: add      x9, x9, #0x43e
00390870: mov      w8, #0x1e
00390874: ldr      x10, [x9]
00390878: ldur     x9, [x9, #7]
0039087c: strb     w8, [sp, #0x1b0]
00390880: strb     wzr, [sp, #0x1c0]
00390884: stur     x10, [x22, #1]
00390888: str      x9, [sp, #0x1b8]
0039088c: adrp     x0, #0x25000
00390890: add      x0, x0, #0xc0b ; 'app='
00390894: add      x8, sp, #0x150
00390898: add      x1, x21, #0x18
0039089c: bl       #0x50c928
003908a0: adrp     x1, #0x2b000
003908a4: add      x1, x1, #0xb77
003908a8: add      x0, sp, #0x150
003908ac: bl       #0x50c46c
003908b0: ldr      x8, [x0, #0x10]
003908b4: ldr      q0, [x0]
003908b8: str      x8, [sp, #0x180]
003908bc: str      q0, [x23, #0xd0]
003908c0: stp      xzr, xzr, [x0, #8]
003908c4: str      xzr, [x0]
003908c8: adrp     x0, #0x2a000
003908cc: add      x0, x0, #0xc8b ; 'kami='
003908d0: add      x8, sp, #8
003908d4: mov      x1, x20
003908d8: bl       #0x50c928
003908dc: adrp     x1, #0x25000
003908e0: add      x1, x1, #0xcfe
003908e4: add      x0, sp, #8
003908e8: bl       #0x50c46c
003908ec: ldr      x8, [x0, #0x10]
003908f0: ldr      q0, [x0]
003908f4: str      x8, [sp, #0x30]
003908f8: str      q0, [sp, #0x20]
003908fc: stp      xzr, xzr, [x0, #8]
00390900: str      xzr, [x0]
00390904: ldrb     w8, [sp, #0x248]
00390908: ldr      x9, [sp, #0x258]
0039090c: ldr      x10, [sp, #0x250]
00390910: lsr      x11, x8, #1
00390914: tst      w8, #1
00390918: csel     x1, x25, x9, eq
0039091c: csel     x2, x11, x10, eq
00390920: add      x0, sp, #0x20
00390924: bl       #0x50ba70
00390928: ldr      x8, [x0, #0x10]
0039092c: ldr      q0, [x0]
00390930: str      x8, [sp, #0x50]
00390934: str      q0, [sp, #0x40]
00390938: stp      xzr, xzr, [x0, #8]
0039093c: str      xzr, [x0]
00390940: adrp     x1, #0x28000
00390944: add      x1, x1, #0x44c
00390948: add      x0, sp, #0x40
0039094c: bl       #0x50c46c
00390950: ldr      x8, [x0, #0x10]
00390954: ldr      q0, [x0]
00390958: str      x8, [sp, #0x70]
0039095c: str      q0, [sp, #0x60]
00390960: stp      xzr, xzr, [x0, #8]
00390964: str      xzr, [x0]
00390968: ldrb     w8, [sp, #0x220]
0039096c: ldr      x9, [sp, #0x230]
00390970: ldr      x10, [sp, #0x228]
00390974: lsr      x11, x8, #1
00390978: tst      w8, #1
0039097c: csel     x1, x26, x9, eq
00390980: csel     x2, x11, x10, eq
00390984: add      x0, sp, #0x60
00390988: bl       #0x50ba70
0039098c: ldr      x8, [x0, #0x10]
00390990: ldr      q0, [x0]
00390994: str      x8, [sp, #0x90]
00390998: str      q0, [sp, #0x80]
0039099c: stp      xzr, xzr, [x0, #8]
003909a0: str      xzr, [x0]
003909a4: adrp     x1, #0x22000
003909a8: add      x1, x1, #0xce2
003909ac: add      x0, sp, #0x80
003909b0: bl       #0x50c46c
003909b4: ldr      x8, [x0, #0x10]
003909b8: ldr      q0, [x0]
003909bc: add      x9, sp, #0x1f0
003909c0: str      x8, [sp, #0xb0]
003909c4: str      q0, [x23]
003909c8: stp      xzr, xzr, [x0, #8]
003909cc: str      xzr, [x0]
003909d0: ldrb     w8, [sp, #0x1f0]
003909d4: ldp      x11, x10, [sp, #0x1f8]
003909d8: lsr      x12, x8, #1
003909dc: tst      w8, #1
003909e0: orr      x8, x9, #1
003909e4: csel     x1, x8, x10, eq
003909e8: csel     x2, x12, x11, eq
003909ec: add      x0, sp, #0xa0
003909f0: bl       #0x50ba70
003909f4: ldr      x8, [x0, #0x10]
003909f8: ldr      q0, [x0]
003909fc: str      x8, [sp, #0xd0]
00390a00: str      q0, [x23, #0x20]
00390a04: stp      xzr, xzr, [x0, #8]
00390a08: str      xzr, [x0]
00390a0c: adrp     x1, #0x27000
00390a10: add      x1, x1, #0x12f
00390a14: add      x0, sp, #0xc0
00390a18: bl       #0x50c46c
00390a1c: ldr      x8, [x0, #0x10]
00390a20: ldr      q0, [x0]
00390a24: add      x9, sp, #0x208
00390a28: str      x8, [sp, #0xf0]
00390a2c: str      q0, [x23, #0x40]
00390a30: stp      xzr, xzr, [x0, #8]
00390a34: str      xzr, [x0]
00390a38: ldrb     w8, [sp, #0x208]
00390a3c: ldr      x10, [sp, #0x218]
00390a40: ldr      x11, [sp, #0x210]
00390a44: lsr      x12, x8, #1
00390a48: tst      w8, #1
00390a4c: orr      x8, x9, #1
00390a50: csel     x1, x8, x10, eq
00390a54: csel     x2, x12, x11, eq
00390a58: add      x0, sp, #0xe0
00390a5c: bl       #0x50ba70
00390a60: ldr      q0, [x0]
00390a64: ldr      x8, [x0, #0x10]
00390a68: stp      xzr, xzr, [x0, #8]
00390a6c: str      xzr, [x0]
00390a70: str      q0, [x23, #0x60]
00390a74: str      x8, [sp, #0x110]
00390a78: add      x8, sp, #0x118
00390a7c: add      x0, sp, #0x100
00390a80: add      x1, x21, #0x48
00390a84: bl       #0x38dac0
00390a88: add      x8, sp, #0x130
00390a8c: add      x0, sp, #0x118
00390a90: add      x22, sp, #0x130
00390a94: bl       #0x38d8bc
00390a98: ldrb     w8, [sp, #0x130]
00390a9c: ldp      x10, x9, [sp, #0x138]
00390aa0: orr      x12, x22, #1
00390aa4: lsr      x11, x8, #1
00390aa8: tst      w8, #1
00390aac: csel     x1, x12, x9, eq
00390ab0: csel     x2, x11, x10, eq
00390ab4: add      x0, sp, #0x170
00390ab8: bl       #0x50ba70
00390abc: ldr      x8, [x0, #0x10]
00390ac0: ldr      q0, [x0]
00390ac4: str      x8, [sp, #0x1a0]
00390ac8: str      q0, [x23, #0xf0]
00390acc: stp      xzr, xzr, [x0, #8]
00390ad0: str      xzr, [x0]
00390ad4: add      x8, sp, #0x1d0
00390ad8: add      x1, sp, #0x1b0
00390adc: add      x2, sp, #0x190
00390ae0: mov      x0, x21
00390ae4: bl       #0x38c310
00390ae8: ldrb     w8, [sp, #0x190]
00390aec: tbnz     w8, #0, #0x390c20
00390af0: ldrb     w8, [sp, #0x130]
00390af4: tbnz     w8, #0, #0x390c30
00390af8: ldrb     w8, [sp, #0x118]
00390afc: tbnz     w8, #0, #0x390c40
00390b00: ldrb     w8, [sp, #0x100]
00390b04: tbnz     w8, #0, #0x390c50
00390b08: ldrb     w8, [sp, #0xe0]
00390b0c: tbnz     w8, #0, #0x390c60
00390b10: ldrb     w8, [sp, #0xc0]
00390b14: tbnz     w8, #0, #0x390c70
00390b18: ldrb     w8, [sp, #0xa0]
00390b1c: tbnz     w8, #0, #0x390c80
00390b20: ldrb     w8, [sp, #0x80]
00390b24: tbnz     w8, #0, #0x390c90
00390b28: ldrb     w8, [sp, #0x60]
00390b2c: tbnz     w8, #0, #0x390ca0
00390b30: ldrb     w8, [sp, #0x40]
00390b34: tbnz     w8, #0, #0x390cb0
00390b38: ldrb     w8, [sp, #0x20]
00390b3c: tbnz     w8, #0, #0x390cc0
00390b40: ldrb     w8, [sp, #8]
00390b44: tbnz     w8, #0, #0x390cd0
00390b48: ldrb     w8, [sp, #0x170]
00390b4c: tbnz     w8, #0, #0x390ce0
00390b50: ldrb     w8, [sp, #0x150]
00390b54: tbnz     w8, #0, #0x390cf0
00390b58: ldrb     w8, [sp, #0x1b0]
00390b5c: tbz      w8, #0, #0x390b68
00390b60: ldr      x0, [sp, #0x1c0]
00390b64: bl       #0x54e070
00390b68: add      x8, sp, #0x190
00390b6c: add      x0, sp, #0x1d0
00390b70: bl       #0x38d678
00390b74: add      x8, sp, #0x1b0
00390b78: add      x0, sp, #0x190
00390b7c: add      x1, x21, #0x48
00390b80: bl       #0x38dac0
00390b84: str      xzr, [sp, #0x280]
00390b88: add      x8, sp, #0x170
00390b8c: add      x0, sp, #0x1b0
00390b90: add      x1, sp, #0x260
00390b94: mov      w2, #1
00390b98: mov      w3, wzr
00390b9c: add      x22, sp, #0x260
00390ba0: bl       #0x391ca8
00390ba4: ldr      x0, [sp, #0x280]
00390ba8: cmp      x0, x22
00390bac: b.eq     #0x390d04
00390bb0: cbz      x0, #0x390d18
00390bb4: mov      w8, #5
00390bb8: b        #0x390d0c
00390bbc: ldr      x0, [sp, #0x1e0]
00390bc0: bl       #0x54e070
00390bc4: ldrb     w8, [sp, #0x1b0]
00390bc8: tbz      w8, #0, #0x390838
00390bcc: ldr      x0, [sp, #0x1c0]
00390bd0: bl       #0x54e070
00390bd4: ldrb     w8, [sp, #0x190]
00390bd8: tbz      w8, #0, #0x390840
00390bdc: ldr      x0, [sp, #0x1a0]
00390be0: bl       #0x54e070
00390be4: ldrb     w8, [sp, #0x170]
00390be8: tbz      w8, #0, #0x390848
00390bec: ldr      x0, [sp, #0x180]
00390bf0: bl       #0x54e070
00390bf4: ldrb     w8, [sp, #0x150]
00390bf8: tbz      w8, #0, #0x390850
00390bfc: ldr      x0, [sp, #0x160]
00390c00: bl       #0x54e070
00390c04: ldrb     w8, [sp, #0x130]
00390c08: tbz      w8, #0, #0x390858
00390c0c: ldr      x0, [sp, #0x140]
00390c10: bl       #0x54e070
00390c14: ldrb     w8, [sp, #0x118]
00390c18: tbnz     w8, #0, #0x390860
00390c1c: b        #0x390868
00390c20: ldr      x0, [sp, #0x1a0]
00390c24: bl       #0x54e070
00390c28: ldrb     w8, [sp, #0x130]
00390c2c: tbz      w8, #0, #0x390af8
00390c30: ldr      x0, [sp, #0x140]
00390c34: bl       #0x54e070
00390c38: ldrb     w8, [sp, #0x118]
00390c3c: tbz      w8, #0, #0x390b00
00390c40: ldr      x0, [sp, #0x128]
00390c44: bl       #0x54e070
00390c48: ldrb     w8, [sp, #0x100]
00390c4c: tbz      w8, #0, #0x390b08
00390c50: ldr      x0, [sp, #0x110]
00390c54: bl       #0x54e070
00390c58: ldrb     w8, [sp, #0xe0]
00390c5c: tbz      w8, #0, #0x390b10
00390c60: ldr      x0, [sp, #0xf0]
00390c64: bl       #0x54e070
00390c68: ldrb     w8, [sp, #0xc0]
00390c6c: tbz      w8, #0, #0x390b18
00390c70: ldr      x0, [sp, #0xd0]
00390c74: bl       #0x54e070
00390c78: ldrb     w8, [sp, #0xa0]
00390c7c: tbz      w8, #0, #0x390b20
00390c80: ldr      x0, [sp, #0xb0]
00390c84: bl       #0x54e070
00390c88: ldrb     w8, [sp, #0x80]
00390c8c: tbz      w8, #0, #0x390b28
00390c90: ldr      x0, [sp, #0x90]
00390c94: bl       #0x54e070
00390c98: ldrb     w8, [sp, #0x60]
00390c9c: tbz      w8, #0, #0x390b30
00390ca0: ldr      x0, [sp, #0x70]
00390ca4: bl       #0x54e070
00390ca8: ldrb     w8, [sp, #0x40]
00390cac: tbz      w8, #0, #0x390b38
00390cb0: ldr      x0, [sp, #0x50]
00390cb4: bl       #0x54e070
00390cb8: ldrb     w8, [sp, #0x20]
00390cbc: tbz      w8, #0, #0x390b40
00390cc0: ldr      x0, [sp, #0x30]
00390cc4: bl       #0x54e070
00390cc8: ldrb     w8, [sp, #8]
00390ccc: tbz      w8, #0, #0x390b48
00390cd0: ldr      x0, [sp, #0x18]
00390cd4: bl       #0x54e070
00390cd8: ldrb     w8, [sp, #0x170]
00390cdc: tbz      w8, #0, #0x390b50
00390ce0: ldr      x0, [sp, #0x180]
00390ce4: bl       #0x54e070
00390ce8: ldrb     w8, [sp, #0x150]
00390cec: tbz      w8, #0, #0x390b58
00390cf0: ldr      x0, [sp, #0x160]
00390cf4: bl       #0x54e070
00390cf8: ldrb     w8, [sp, #0x1b0]
00390cfc: tbnz     w8, #0, #0x390b60
00390d00: b        #0x390b68
00390d04: mov      w8, #4
00390d08: add      x0, sp, #0x260
00390d0c: ldr      x9, [x0]
00390d10: ldr      x8, [x9, x8, lsl #3]
00390d14: blr      x8
00390d18: ldrb     w8, [sp, #0x1b0]
00390d1c: tbz      w8, #0, #0x390d28
00390d20: ldr      x0, [sp, #0x1c0]
00390d24: bl       #0x54e070
00390d28: ldrb     w8, [sp, #0x190]
00390d2c: tbz      w8, #0, #0x390d38
00390d30: ldr      x0, [sp, #0x1a0]
00390d34: bl       #0x54e070
00390d38: ldrb     w8, [sp, #0x170]
00390d3c: cmp      w8, #1
00390d40: b.ne     #0x390ec8
00390d44: ldr      x25, [sp, #0x178]
00390d48: ldr      x27, [x25, #8]!
00390d4c: cbz      x27, #0x390da0
00390d50: adrp     x22, #0x21000
00390d54: add      x22, x22, #0x9cc
00390d58: mov      x26, x25
00390d5c: add      x0, x27, #0x20
00390d60: mov      x1, x22
00390d64: bl       #0x50c188
00390d68: add      x8, x27, #8
00390d6c: cmp      w0, #0
00390d70: csel     x8, x8, x27, lt
00390d74: csel     x26, x26, x27, lt
00390d78: ldr      x27, [x8]
00390d7c: cbnz     x27, #0x390d5c
00390d80: cmp      x26, x25
00390d84: b.eq     #0x390da0
00390d88: adrp     x1, #0x21000
00390d8c: add      x1, x1, #0x9cc
00390d90: add      x0, x26, #0x20
00390d94: bl       #0x50c188
00390d98: cmp      w0, #0
00390d9c: csel     x25, x25, x26, gt
00390da0: ldr      x8, [sp, #0x178]
00390da4: add      x8, x8, #8
00390da8: cmp      x25, x8
00390dac: b.eq     #0x390e10
00390db0: adrp     x1, #0x21000
00390db4: add      x1, x1, #0x9cc
00390db8: add      x0, sp, #0x170
00390dbc: bl       #0x39160c
00390dc0: ldrsw    x8, [x21, #0x60]
00390dc4: mov      w9, #5
00390dc8: add      x1, sp, #0x1b0
00390dcc: add      x25, sp, #0x1b0
00390dd0: stp      x9, x8, [sp, #0x1b0]
00390dd4: bl       #0x39f9c4
00390dd8: ldrb     w1, [sp, #0x1b0]
00390ddc: mov      w22, w0
00390de0: add      x0, x25, #8
00390de4: bl       #0x398d18
00390de8: tbz      w22, #0, #0x390e10
00390dec: add      x0, x21, #0x68
00390df0: mov      x1, x20
00390df4: bl       #0x50c24c
00390df8: ldr      q0, [x23, #0xd0]
00390dfc: mov      w1, wzr
00390e00: strb     wzr, [sp, #0x170]
00390e04: str      xzr, [sp, #0x178]
00390e08: str      q0, [x19]
00390e0c: b        #0x390f44
00390e10: ldrb     w8, [sp, #0x170]
00390e14: cmp      w8, #1
00390e18: b.ne     #0x390ec8
00390e1c: ldr      x21, [sp, #0x178]
00390e20: ldr      x23, [x21, #8]!
00390e24: cbz      x23, #0x390e78
00390e28: adrp     x20, #0x21000
00390e2c: add      x20, x20, #0x3de
00390e30: mov      x22, x21
00390e34: add      x0, x23, #0x20
00390e38: mov      x1, x20
00390e3c: bl       #0x50c188
00390e40: add      x8, x23, #8
00390e44: cmp      w0, #0
00390e48: csel     x8, x8, x23, lt
00390e4c: csel     x22, x22, x23, lt
00390e50: ldr      x23, [x8]
00390e54: cbnz     x23, #0x390e34
00390e58: cmp      x22, x21
00390e5c: b.eq     #0x390e78
00390e60: adrp     x1, #0x21000
00390e64: add      x1, x1, #0x3de
00390e68: add      x0, x22, #0x20
00390e6c: bl       #0x50c188
00390e70: cmp      w0, #0
00390e74: csel     x21, x21, x22, gt
00390e78: ldr      x8, [sp, #0x178]
00390e7c: add      x8, x8, #8
00390e80: cmp      x21, x8
00390e84: b.eq     #0x390ec8
00390e88: adrp     x1, #0x21000
00390e8c: add      x1, x1, #0x3de
00390e90: add      x0, sp, #0x170
00390e94: bl       #0x39160c
00390e98: ldrb     w8, [x0]
00390e9c: cmp      w8, #3
00390ea0: b.ne     #0x390fc0
00390ea4: adrp     x1, #0x21000
00390ea8: add      x1, x1, #0x3de
00390eac: add      x0, sp, #0x170
00390eb0: bl       #0x39160c
00390eb4: stp      xzr, xzr, [sp, #0x1b0]
00390eb8: str      xzr, [sp, #0x1c0]
00390ebc: add      x1, sp, #0x1b0
00390ec0: bl       #0x39d0f8
00390ec4: b        #0x390fe8
00390ec8: adrp     x0, #0x562000
00390ecc: adrp     x1, #0x27000
00390ed0: add      x1, x1, #0xb57 ; '卡密验证失败'
00390ed4: ldr      x0, [x0, #0xec0]
00390ed8: mov      w2, #0x12
00390edc: bl       #0x3a07c0
00390ee0: ldr      x8, [x0]
00390ee4: mov      x20, x0
00390ee8: ldur     x9, [x8, #-0x18]
00390eec: add      x8, sp, #0x1b0
00390ef0: add      x0, x0, x9
00390ef4: bl       #0x50eb5c
00390ef8: adrp     x1, #0x562000
00390efc: add      x0, sp, #0x1b0
00390f00: ldr      x1, [x1, #0xe98]
00390f04: bl       #0x52d1b4
00390f08: ldr      x8, [x0]
00390f0c: ldr      x8, [x8, #0x38]
00390f10: mov      w1, #0xa
00390f14: blr      x8
00390f18: mov      w21, w0
00390f1c: add      x0, sp, #0x1b0
00390f20: bl       #0x52d0b4
00390f24: mov      x0, x20
00390f28: mov      w1, w21
00390f2c: bl       #0x50ff00
00390f30: mov      x0, x20
00390f34: bl       #0x50f330
00390f38: ldrb     w1, [sp, #0x170]
00390f3c: strb     wzr, [x19]
00390f40: str      xzr, [x19, #8]
00390f44: add      x8, sp, #0x170
00390f48: add      x0, x8, #8
00390f4c: bl       #0x398d18
00390f50: ldrb     w8, [sp, #0x1d0]
00390f54: tbnz     w8, #0, #0x390f8c
00390f58: ldrb     w8, [sp, #0x1f0]
00390f5c: tbnz     w8, #0, #0x390f9c
00390f60: ldrb     w8, [sp, #0x208]
00390f64: tbnz     w8, #0, #0x390fac
00390f68: ldrb     w8, [sp, #0x220]
00390f6c: tbz      w8, #0, #0x390f78
00390f70: ldr      x0, [sp, #0x230]
00390f74: bl       #0x54e070
00390f78: add      x0, sp, #0x244
00390f7c: bl       #0x50e9ac
00390f80: ldrb     w8, [sp, #0x248]
00390f84: tbnz     w8, #0, #0x390420
00390f88: b        #0x390428
00390f8c: ldr      x0, [sp, #0x1e0]
00390f90: bl       #0x54e070
00390f94: ldrb     w8, [sp, #0x1f0]
00390f98: tbz      w8, #0, #0x390f60
00390f9c: ldr      x0, [sp, #0x200]
00390fa0: bl       #0x54e070
00390fa4: ldrb     w8, [sp, #0x208]
00390fa8: tbz      w8, #0, #0x390f68
00390fac: ldr      x0, [sp, #0x218]
00390fb0: bl       #0x54e070
00390fb4: ldrb     w8, [sp, #0x220]
00390fb8: tbnz     w8, #0, #0x390f70
00390fbc: b        #0x390f78
00390fc0: adrp     x1, #0x21000
00390fc4: add      x1, x1, #0x3de
00390fc8: add      x0, sp, #0x170
00390fcc: bl       #0x39160c
00390fd0: add      x8, sp, #0x1b0
00390fd4: mov      w1, #-1
00390fd8: mov      w2, #0x20
00390fdc: mov      w3, wzr
00390fe0: mov      w4, wzr
00390fe4: bl       #0x39d218
00390fe8: ldrb     w8, [sp, #0x1b0]
00390fec: ldp      x11, x10, [sp, #0x1b8]
00390ff0: add      x9, sp, #0x1b0
00390ff4: lsr      x12, x8, #1
00390ff8: orr      x9, x9, #1
00390ffc: tst      w8, #1
00391000: csel     x1, x9, x10, eq
00391004: csel     x2, x12, x11, eq
00391008: adrp     x0, #0x562000
0039100c: ldr      x0, [x0, #0xec0]
00391010: bl       #0x3a07c0
00391014: ldr      x8, [x0]
00391018: mov      x20, x0
0039101c: ldur     x9, [x8, #-0x18]
00391020: add      x8, sp, #0x190
00391024: add      x0, x0, x9
00391028: bl       #0x50eb5c
0039102c: adrp     x1, #0x562000
00391030: add      x0, sp, #0x190
00391034: ldr      x1, [x1, #0xe98]
00391038: bl       #0x52d1b4
0039103c: ldr      x8, [x0]
00391040: ldr      x8, [x8, #0x38]
00391044: mov      w1, #0xa
00391048: blr      x8
0039104c: mov      w21, w0
00391050: add      x0, sp, #0x190
00391054: bl       #0x52d0b4
00391058: mov      x0, x20
0039105c: mov      w1, w21
00391060: bl       #0x50ff00
00391064: mov      x0, x20
00391068: bl       #0x50f330
0039106c: ldrb     w8, [sp, #0x1b0]
00391070: tbz      w8, #0, #0x390f38
00391074: ldr      x0, [sp, #0x1c0]
00391078: bl       #0x54e070
0039107c: b        #0x390f38
00391080: ldrb     w8, [sp, #0x1b0]
00391084: mov      x20, x0
00391088: tbnz     w8, #0, #0x3910b8
0039108c: b        #0x3910c0
00391090: mov      x20, x0
00391094: add      x0, sp, #0x190
00391098: bl       #0x52d0b4
0039109c: b        #0x3910b0
003910a0: mov      x20, x0
003910a4: b        #0x3910c0
003910a8: bl       #0x3860c0
003910ac: mov      x20, x0
003910b0: ldrb     w8, [sp, #0x1b0]
003910b4: tbz      w8, #0, #0x3910c0
003910b8: ldr      x0, [sp, #0x1c0]
003910bc: bl       #0x54e070
003910c0: mov      x0, x20
003910c4: bl       #0x54e108
003910c8: adrp     x0, #0x562000
003910cc: adrp     x1, #0x27000
003910d0: add      x1, x1, #0xb57 ; '卡密验证失败'
003910d4: ldr      x0, [x0, #0xec0]
003910d8: mov      w2, #0x12
003910dc: bl       #0x3a07c0
003910e0: bl       #0x386f34
003910e4: bl       #0x54e2e8
003910e8: b        #0x390f38
003910ec: mov      x19, x0
003910f0: bl       #0x54e2e8
003910f4: b        #0x391560
003910f8: bl       #0x3860c0
003910fc: bl       #0x3860c0
00391100: ldr      x8, [sp, #0x280]
00391104: mov      x19, x0
00391108: cmp      x8, x22
0039110c: b.ne     #0x39111c
00391110: mov      w9, #4
00391114: add      x8, sp, #0x260
00391118: b        #0x391140
0039111c: cbnz     x8, #0x39113c
00391120: ldrb     w8, [sp, #0x1b0]
00391124: tbnz     w8, #0, #0x391158
00391128: ldrb     w8, [sp, #0x190]
0039112c: tbnz     w8, #0, #0x391178
00391130: ldrb     w8, [sp, #0x1d0]
00391134: tbnz     w8, #0, #0x391570
00391138: b        #0x391578
0039113c: mov      w9, #5
00391140: ldr      x10, [x8]
00391144: mov      x0, x8
00391148: ldr      x9, [x10, x9, lsl #3]
0039114c: blr      x9
00391150: ldrb     w8, [sp, #0x1b0]
00391154: tbz      w8, #0, #0x391128
00391158: ldr      x0, [sp, #0x1c0]
0039115c: bl       #0x54e070
00391160: ldrb     w8, [sp, #0x190]
00391164: tbz      w8, #0, #0x391130
00391168: b        #0x391178
0039116c: mov      x19, x0
00391170: ldrb     w8, [sp, #0x190]
00391174: tbz      w8, #0, #0x391130
00391178: ldr      x0, [sp, #0x1a0]
0039117c: bl       #0x54e070
00391180: ldrb     w8, [sp, #0x1d0]
00391184: tbnz     w8, #0, #0x391570
00391188: b        #0x391578
0039118c: mov      x19, x0
00391190: ldrb     w8, [sp, #0x1d0]
00391194: tbnz     w8, #0, #0x391570
00391198: b        #0x391578
0039119c: ldrb     w8, [sp, #0x190]
003911a0: mov      x19, x0
003911a4: tbnz     w8, #0, #0x39121c
003911a8: ldrb     w8, [sp, #0x130]
003911ac: tbnz     w8, #0, #0x39123c
003911b0: ldrb     w8, [sp, #0x118]
003911b4: tbnz     w8, #0, #0x39125c
003911b8: ldrb     w8, [sp, #0x100]
003911bc: tbnz     w8, #0, #0x39127c
003911c0: ldrb     w8, [sp, #0xe0]
003911c4: tbnz     w8, #0, #0x39129c
003911c8: ldrb     w8, [sp, #0xc0]
003911cc: tbnz     w8, #0, #0x3912bc
003911d0: ldrb     w8, [sp, #0xa0]
003911d4: tbnz     w8, #0, #0x3912dc
003911d8: ldrb     w8, [sp, #0x80]
003911dc: tbnz     w8, #0, #0x3912fc
003911e0: ldrb     w8, [sp, #0x60]
003911e4: tbnz     w8, #0, #0x39131c
003911e8: ldrb     w8, [sp, #0x40]
003911ec: tbnz     w8, #0, #0x39132c
003911f0: ldrb     w8, [sp, #0x20]
003911f4: tbnz     w8, #0, #0x39133c
003911f8: ldrb     w8, [sp, #8]
003911fc: tbnz     w8, #0, #0x39134c
00391200: ldrb     w8, [sp, #0x170]
00391204: tbnz     w8, #0, #0x39135c
00391208: ldrb     w8, [sp, #0x150]
0039120c: tbnz     w8, #0, #0x39136c
00391210: ldrb     w8, [sp, #0x1b0]
00391214: tbnz     w8, #0, #0x39137c
00391218: b        #0x391578
0039121c: ldr      x0, [sp, #0x1a0]
00391220: bl       #0x54e070
00391224: ldrb     w8, [sp, #0x130]
00391228: tbz      w8, #0, #0x3911b0
0039122c: b        #0x39123c
00391230: mov      x19, x0
00391234: ldrb     w8, [sp, #0x130]
00391238: tbz      w8, #0, #0x3911b0
0039123c: ldr      x0, [sp, #0x140]
00391240: bl       #0x54e070
00391244: ldrb     w8, [sp, #0x118]
00391248: tbz      w8, #0, #0x3911b8
0039124c: b        #0x39125c
00391250: mov      x19, x0
00391254: ldrb     w8, [sp, #0x118]
00391258: tbz      w8, #0, #0x3911b8
0039125c: ldr      x0, [sp, #0x128]
00391260: bl       #0x54e070
00391264: ldrb     w8, [sp, #0x100]
00391268: tbz      w8, #0, #0x3911c0
0039126c: b        #0x39127c
00391270: mov      x19, x0
00391274: ldrb     w8, [sp, #0x100]
00391278: tbz      w8, #0, #0x3911c0
0039127c: ldr      x0, [sp, #0x110]
00391280: bl       #0x54e070
00391284: ldrb     w8, [sp, #0xe0]
00391288: tbz      w8, #0, #0x3911c8
0039128c: b        #0x39129c
00391290: mov      x19, x0
00391294: ldrb     w8, [sp, #0xe0]
00391298: tbz      w8, #0, #0x3911c8
0039129c: ldr      x0, [sp, #0xf0]
003912a0: bl       #0x54e070
003912a4: ldrb     w8, [sp, #0xc0]
003912a8: tbz      w8, #0, #0x3911d0
003912ac: b        #0x3912bc
003912b0: mov      x19, x0
003912b4: ldrb     w8, [sp, #0xc0]
003912b8: tbz      w8, #0, #0x3911d0
003912bc: ldr      x0, [sp, #0xd0]
003912c0: bl       #0x54e070
003912c4: ldrb     w8, [sp, #0xa0]
003912c8: tbz      w8, #0, #0x3911d8
003912cc: b        #0x3912dc
003912d0: mov      x19, x0
003912d4: ldrb     w8, [sp, #0xa0]
003912d8: tbz      w8, #0, #0x3911d8
003912dc: ldr      x0, [sp, #0xb0]
003912e0: bl       #0x54e070
003912e4: ldrb     w8, [sp, #0x80]
003912e8: tbz      w8, #0, #0x3911e0
003912ec: b        #0x3912fc
003912f0: mov      x19, x0
003912f4: ldrb     w8, [sp, #0x80]
003912f8: tbz      w8, #0, #0x3911e0
003912fc: ldr      x0, [sp, #0x90]
00391300: bl       #0x54e070
00391304: ldrb     w8, [sp, #0x60]
00391308: tbz      w8, #0, #0x3911e8
0039130c: b        #0x39131c
00391310: mov      x19, x0
00391314: ldrb     w8, [sp, #0x60]
00391318: tbz      w8, #0, #0x3911e8
0039131c: ldr      x0, [sp, #0x70]
00391320: bl       #0x54e070
00391324: ldrb     w8, [sp, #0x40]
00391328: tbz      w8, #0, #0x3911f0
0039132c: ldr      x0, [sp, #0x50]
00391330: bl       #0x54e070
00391334: ldrb     w8, [sp, #0x20]
00391338: tbz      w8, #0, #0x3911f8
0039133c: ldr      x0, [sp, #0x30]
00391340: bl       #0x54e070
00391344: ldrb     w8, [sp, #8]
00391348: tbz      w8, #0, #0x391200
0039134c: ldr      x0, [sp, #0x18]
00391350: bl       #0x54e070
00391354: ldrb     w8, [sp, #0x170]
00391358: tbz      w8, #0, #0x391208
0039135c: ldr      x0, [sp, #0x180]
00391360: bl       #0x54e070
00391364: ldrb     w8, [sp, #0x150]
00391368: tbz      w8, #0, #0x391210
0039136c: ldr      x0, [sp, #0x160]
00391370: bl       #0x54e070
00391374: ldrb     w8, [sp, #0x1b0]
00391378: tbz      w8, #0, #0x391578
0039137c: ldr      x0, [sp, #0x1c0]
00391380: b        #0x391574
00391384: mov      x19, x0
00391388: ldrb     w8, [sp, #0x40]
0039138c: tbz      w8, #0, #0x3911f0
00391390: b        #0x39132c
00391394: mov      x19, x0
00391398: ldrb     w8, [sp, #0x20]
0039139c: tbz      w8, #0, #0x3911f8
003913a0: b        #0x39133c
003913a4: mov      x19, x0
003913a8: ldrb     w8, [sp, #8]
003913ac: tbz      w8, #0, #0x391200
003913b0: b        #0x39134c
003913b4: mov      x19, x0
003913b8: ldrb     w8, [sp, #0x170]
003913bc: tbz      w8, #0, #0x391208
003913c0: b        #0x39135c
003913c4: mov      x19, x0
003913c8: ldrb     w8, [sp, #0x150]
003913cc: tbz      w8, #0, #0x391210
003913d0: b        #0x39136c
003913d4: mov      x19, x0
003913d8: ldrb     w8, [sp, #0x1b0]
003913dc: tbnz     w8, #0, #0x39137c
003913e0: b        #0x391578
003913e4: ldrb     w8, [sp, #0x1d0]
003913e8: mov      x19, x0
003913ec: tbnz     w8, #0, #0x391424
003913f0: ldrb     w8, [sp, #0x1b0]
003913f4: tbnz     w8, #0, #0x391444
003913f8: ldrb     w8, [sp, #0x190]
003913fc: tbnz     w8, #0, #0x391464
00391400: ldrb     w8, [sp, #0x170]
00391404: tbnz     w8, #0, #0x391484
00391408: ldrb     w8, [sp, #0x150]
0039140c: tbnz     w8, #0, #0x3914a4
00391410: ldrb     w8, [sp, #0x130]
00391414: tbnz     w8, #0, #0x3914c4
00391418: ldrb     w8, [sp, #0x118]
0039141c: tbnz     w8, #0, #0x3914e4
00391420: b        #0x391588
00391424: ldr      x0, [sp, #0x1e0]
00391428: bl       #0x54e070
0039142c: ldrb     w8, [sp, #0x1b0]
00391430: tbz      w8, #0, #0x3913f8
00391434: b        #0x391444
00391438: mov      x19, x0
0039143c: ldrb     w8, [sp, #0x1b0]
00391440: tbz      w8, #0, #0x3913f8
00391444: ldr      x0, [sp, #0x1c0]
00391448: bl       #0x54e070
0039144c: ldrb     w8, [sp, #0x190]
00391450: tbz      w8, #0, #0x391400
00391454: b        #0x391464
00391458: mov      x19, x0
0039145c: ldrb     w8, [sp, #0x190]
00391460: tbz      w8, #0, #0x391400
00391464: ldr      x0, [sp, #0x1a0]
00391468: bl       #0x54e070
0039146c: ldrb     w8, [sp, #0x170]
00391470: tbz      w8, #0, #0x391408
00391474: b        #0x391484
00391478: mov      x19, x0
0039147c: ldrb     w8, [sp, #0x170]
00391480: tbz      w8, #0, #0x391408
00391484: ldr      x0, [sp, #0x180]
00391488: bl       #0x54e070
0039148c: ldrb     w8, [sp, #0x150]
00391490: tbz      w8, #0, #0x391410
00391494: b        #0x3914a4
00391498: mov      x19, x0
0039149c: ldrb     w8, [sp, #0x150]
003914a0: tbz      w8, #0, #0x391410
003914a4: ldr      x0, [sp, #0x160]
003914a8: bl       #0x54e070
003914ac: ldrb     w8, [sp, #0x130]
003914b0: tbz      w8, #0, #0x391418
003914b4: b        #0x3914c4
003914b8: mov      x19, x0
003914bc: ldrb     w8, [sp, #0x130]
003914c0: tbz      w8, #0, #0x391418
003914c4: ldr      x0, [sp, #0x140]
003914c8: bl       #0x54e070
003914cc: ldrb     w8, [sp, #0x118]
003914d0: tbnz     w8, #0, #0x3914e4
003914d4: b        #0x391588
003914d8: mov      x19, x0
003914dc: ldrb     w8, [sp, #0x118]
003914e0: tbz      w8, #0, #0x391588
003914e4: ldr      x0, [sp, #0x128]
003914e8: b        #0x391584
003914ec: mov      x19, x0
003914f0: b        #0x391588
003914f4: mov      x19, x0
003914f8: b        #0x391588
003914fc: mov      x19, x0
00391500: b        #0x3915a8
00391504: mov      x19, x0
00391508: b        #0x3915a8
0039150c: ldrb     w8, [sp, #0x290]
00391510: mov      x19, x0
00391514: tbnz     w8, #0, #0x3915c0
00391518: b        #0x3915e0
0039151c: mov      x19, x0
00391520: add      x0, sp, #0x1b0
00391524: bl       #0x52d0b4
00391528: b        #0x391560
0039152c: mov      x19, x0
00391530: b        #0x391598
00391534: b        #0x39154c
00391538: mov      x19, x0
0039153c: add      x0, sp, #0x220
00391540: bl       #0x52d0b4
00391544: b        #0x3915b8
00391548: b        #0x39154c
0039154c: mov      x19, x0
00391550: add      x0, sp, #0x290
00391554: bl       #0x52d0b4
00391558: b        #0x3915e0
0039155c: mov      x19, x0
00391560: add      x0, sp, #0x170
00391564: bl       #0x391938
00391568: ldrb     w8, [sp, #0x1d0]
0039156c: tbz      w8, #0, #0x391578
00391570: ldr      x0, [sp, #0x1e0]
00391574: bl       #0x54e070
00391578: ldrb     w8, [sp, #0x1f0]
0039157c: tbz      w8, #0, #0x391588
00391580: ldr      x0, [sp, #0x200]
00391584: bl       #0x54e070
00391588: ldrb     w8, [sp, #0x208]
0039158c: tbz      w8, #0, #0x391598
00391590: ldr      x0, [sp, #0x218]
00391594: bl       #0x54e070
00391598: ldrb     w8, [sp, #0x220]
0039159c: tbz      w8, #0, #0x3915a8
003915a0: ldr      x0, [sp, #0x230]
003915a4: bl       #0x54e070
003915a8: add      x0, sp, #0x244
003915ac: bl       #0x50e9ac
003915b0: b        #0x3915e0
003915b4: mov      x19, x0
003915b8: ldrb     w8, [sp, #0x290]
003915bc: tbz      w8, #0, #0x3915e0
003915c0: ldr      x0, [sp, #0x2a0]
003915c4: bl       #0x54e070
003915c8: b        #0x3915e0
003915cc: mov      x19, x0
003915d0: add      x0, sp, #0x290
003915d4: bl       #0x52d0b4
003915d8: b        #0x3915f0
003915dc: mov      x19, x0
003915e0: ldrb     w8, [sp, #0x248]
003915e4: tbz      w8, #0, #0x3915f0
003915e8: ldr      x0, [sp, #0x258]
003915ec: bl       #0x54e070
003915f0: ldr      x8, [x24, #0x28]
003915f4: ldur     x9, [x29, #-8]
003915f8: cmp      x8, x9
003915fc: b.ne     #0x391608
00391600: mov      x0, x19
00391604: bl       #0x54fffc
00391608: bl       #0x553f00 ; __stack_chk_fail
