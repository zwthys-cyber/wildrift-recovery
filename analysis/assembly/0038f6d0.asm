0038f6d0: sub      sp, sp, #0x110
0038f6d4: stp      x29, x30, [sp, #0xd0]
0038f6d8: stp      x28, x23, [sp, #0xe0]
0038f6dc: stp      x22, x21, [sp, #0xf0]
0038f6e0: stp      x20, x19, [sp, #0x100]
0038f6e4: add      x29, sp, #0xd0
0038f6e8: mrs      x23, tpidr_el0
0038f6ec: mov      x20, x0
0038f6f0: adrp     x0, #0x562000
0038f6f4: ldr      x8, [x23, #0x28]
0038f6f8: mov      x19, x1
0038f6fc: adrp     x1, #0x2b000
0038f700: add      x1, x1, #0x591
0038f704: mov      w2, #0x18
0038f708: stur     x8, [x29, #-8]
0038f70c: ldr      x0, [x0, #0xec0]
0038f710: bl       #0x3a07c0
0038f714: ldr      x8, [x0]
0038f718: mov      x21, x0
0038f71c: ldur     x9, [x8, #-0x18]
0038f720: sub      x8, x29, #0x60
0038f724: add      x0, x0, x9
0038f728: bl       #0x50eb5c
0038f72c: adrp     x1, #0x562000
0038f730: sub      x0, x29, #0x60
0038f734: ldr      x1, [x1, #0xe98]
0038f738: bl       #0x52d1b4
0038f73c: ldr      x8, [x0]
0038f740: ldr      x8, [x8, #0x38]
0038f744: mov      w1, #0xa
0038f748: blr      x8
0038f74c: mov      w22, w0
0038f750: sub      x0, x29, #0x60
0038f754: bl       #0x52d0b4
0038f758: mov      x0, x21
0038f75c: mov      w1, w22
0038f760: bl       #0x50ff00
0038f764: mov      x0, x21
0038f768: bl       #0x50f330
0038f76c: adrp     x9, #0x24000
0038f770: add      x9, x9, #0xcd0
0038f774: mov      w10, #0x693d
0038f778: ldr      x9, [x9]
0038f77c: mov      w8, #0x16
0038f780: movk     w10, #0x696e, lsl #16
0038f784: strb     w8, [sp, #0x58]
0038f788: str      w10, [sp, #0x60]
0038f78c: stur     x9, [sp, #0x59]
0038f790: strb     wzr, [sp, #0x64]
0038f794: adrp     x0, #0x25000
0038f798: add      x0, x0, #0xc0b ; 'app='
0038f79c: add      x8, sp, #0x40
0038f7a0: add      x1, x20, #0x18
0038f7a4: bl       #0x50c928
0038f7a8: sub      x8, x29, #0x60
0038f7ac: add      x1, sp, #0x58
0038f7b0: add      x2, sp, #0x40
0038f7b4: mov      x0, x20
0038f7b8: bl       #0x38c310
0038f7bc: ldrb     w8, [sp, #0x40]
0038f7c0: tbz      w8, #0, #0x38f7cc
0038f7c4: ldr      x0, [sp, #0x50]
0038f7c8: bl       #0x54e070
0038f7cc: ldrb     w8, [sp, #0x58]
0038f7d0: tbz      w8, #0, #0x38f7dc
0038f7d4: ldr      x0, [sp, #0x68]
0038f7d8: bl       #0x54e070
0038f7dc: add      x8, sp, #0x40
0038f7e0: sub      x0, x29, #0x60
0038f7e4: bl       #0x38d678
0038f7e8: add      x8, sp, #0x58
0038f7ec: add      x0, sp, #0x40
0038f7f0: add      x1, x20, #0x48
0038f7f4: bl       #0x38dac0
0038f7f8: stur     xzr, [x29, #-0x20]
0038f7fc: add      x8, sp, #0x30
0038f800: add      x0, sp, #0x58
0038f804: sub      x1, x29, #0x40
0038f808: mov      w2, #1
0038f80c: mov      w3, wzr
0038f810: sub      x20, x29, #0x40
0038f814: bl       #0x391ca8
0038f818: ldur     x0, [x29, #-0x20]
0038f81c: cmp      x0, x20
0038f820: b.eq     #0x38f830
0038f824: cbz      x0, #0x38f844
0038f828: mov      w8, #5
0038f82c: b        #0x38f838
0038f830: mov      w8, #4
0038f834: sub      x0, x29, #0x40
0038f838: ldr      x9, [x0]
0038f83c: ldr      x8, [x9, x8, lsl #3]
0038f840: blr      x8
0038f844: ldrb     w8, [sp, #0x58]
0038f848: tbz      w8, #0, #0x38f854
0038f84c: ldr      x0, [sp, #0x68]
0038f850: bl       #0x54e070
0038f854: ldrb     w8, [sp, #0x40]
0038f858: tbz      w8, #0, #0x38f864
0038f85c: ldr      x0, [sp, #0x50]
0038f860: bl       #0x54e070
0038f864: adrp     x1, #0x21000
0038f868: add      x1, x1, #0x9cc
0038f86c: add      x0, sp, #0x30
0038f870: bl       #0x39160c
0038f874: str      wzr, [sp, #0x58]
0038f878: add      x1, sp, #0x58
0038f87c: bl       #0x39cd28
0038f880: ldr      w8, [sp, #0x58]
0038f884: cmp      w8, #0xc8
0038f888: b.ne     #0x38f9b0
0038f88c: adrp     x1, #0x21000
0038f890: add      x1, x1, #0x3de
0038f894: add      x0, sp, #0x30
0038f898: bl       #0x39160c
0038f89c: adrp     x1, #0x26000
0038f8a0: add      x1, x1, #0x6a8
0038f8a4: bl       #0x39160c
0038f8a8: stp      xzr, xzr, [sp, #0x58]
0038f8ac: str      xzr, [sp, #0x68]
0038f8b0: add      x1, sp, #0x58
0038f8b4: bl       #0x39d0f8
0038f8b8: adrp     x1, #0x21000
0038f8bc: add      x1, x1, #0x3de
0038f8c0: add      x0, sp, #0x30
0038f8c4: bl       #0x39160c
0038f8c8: adrp     x1, #0x25000
0038f8cc: add      x1, x1, #0xc10
0038f8d0: bl       #0x39160c
0038f8d4: stp      xzr, xzr, [sp, #0x40]
0038f8d8: str      xzr, [sp, #0x50]
0038f8dc: add      x1, sp, #0x40
0038f8e0: bl       #0x39d0f8
0038f8e4: adrp     x1, #0x21000
0038f8e8: add      x1, x1, #0x3de
0038f8ec: add      x0, sp, #0x30
0038f8f0: bl       #0x39160c
0038f8f4: adrp     x1, #0x25000
0038f8f8: add      x1, x1, #0xc20
0038f8fc: bl       #0x39160c
0038f900: stp      xzr, xzr, [sp, #0x18]
0038f904: str      xzr, [sp, #0x28]
0038f908: add      x1, sp, #0x18
0038f90c: bl       #0x39d0f8
0038f910: adrp     x1, #0x21000
0038f914: add      x1, x1, #0x3de
0038f918: add      x0, sp, #0x30
0038f91c: bl       #0x39160c
0038f920: adrp     x1, #0x21000
0038f924: add      x1, x1, #0x9d6
0038f928: bl       #0x39160c
0038f92c: stp      xzr, xzr, [sp]
0038f930: str      xzr, [sp, #0x10]
0038f934: mov      x1, sp
0038f938: bl       #0x39d0f8
0038f93c: ldrb     w9, [sp, #0x58]
0038f940: ldrb     w10, [x19]
0038f944: ldr      x2, [sp, #0x60]
0038f948: ldr      x11, [x19, #8]
0038f94c: lsr      x8, x9, #1
0038f950: tst      w9, #1
0038f954: lsr      x12, x10, #1
0038f958: csel     x13, x8, x2, eq
0038f95c: tst      w10, #1
0038f960: csel     x11, x12, x11, eq
0038f964: cmp      x13, x11
0038f968: b.ne     #0x38f9cc
0038f96c: ldr      x11, [x19, #0x10]
0038f970: tst      w10, #1
0038f974: csinc    x1, x11, x19, ne
0038f978: tbnz     w9, #0, #0x38f9c0
0038f97c: cmp      w9, #2
0038f980: b.lo     #0x38fd48
0038f984: add      x9, sp, #0x58
0038f988: orr      x9, x9, #1
0038f98c: ldrb     w10, [x9]
0038f990: ldrb     w11, [x1]
0038f994: cmp      w10, w11
0038f998: b.ne     #0x38f9cc
0038f99c: subs     x8, x8, #1
0038f9a0: add      x9, x9, #1
0038f9a4: add      x1, x1, #1
0038f9a8: b.ne     #0x38f98c
0038f9ac: b        #0x38fd48
0038f9b0: adrp     x0, #0x26000
0038f9b4: add      x0, x0, #0x19c
0038f9b8: bl       #0x553f60 ; puts
0038f9bc: b        #0x38fcdc
0038f9c0: ldr      x0, [sp, #0x68]
0038f9c4: bl       #0x553f50 ; memcmp
0038f9c8: cbz      w0, #0x38fd48
0038f9cc: adrp     x0, #0x562000
0038f9d0: adrp     x1, #0x2b000
0038f9d4: add      x1, x1, #0x5aa
0038f9d8: ldr      x0, [x0, #0xec0]
0038f9dc: mov      w2, #0xd
0038f9e0: bl       #0x3a07c0
0038f9e4: ldr      x8, [x0]
0038f9e8: mov      x20, x0
0038f9ec: ldur     x9, [x8, #-0x18]
0038f9f0: sub      x8, x29, #0x48
0038f9f4: add      x0, x0, x9
0038f9f8: bl       #0x50eb5c
0038f9fc: adrp     x1, #0x562000
0038fa00: sub      x0, x29, #0x48
0038fa04: ldr      x1, [x1, #0xe98]
0038fa08: bl       #0x52d1b4
0038fa0c: ldr      x8, [x0]
0038fa10: ldr      x8, [x8, #0x38]
0038fa14: mov      w1, #0xa
0038fa18: blr      x8
0038fa1c: mov      w21, w0
0038fa20: sub      x0, x29, #0x48
0038fa24: bl       #0x52d0b4
0038fa28: mov      x0, x20
0038fa2c: mov      w1, w21
0038fa30: bl       #0x50ff00
0038fa34: mov      x0, x20
0038fa38: bl       #0x50f330
0038fa3c: adrp     x1, #0x2a000
0038fa40: add      x1, x1, #0x1c7
0038fa44: mov      x0, x20
0038fa48: mov      w2, #0xd
0038fa4c: bl       #0x3a07c0
0038fa50: ldrb     w8, [x19]
0038fa54: ldp      x10, x9, [x19, #8]
0038fa58: lsr      x11, x8, #1
0038fa5c: tst      w8, #1
0038fa60: csinc    x1, x9, x19, ne
0038fa64: csel     x2, x11, x10, eq
0038fa68: bl       #0x3a07c0
0038fa6c: ldr      x8, [x0]
0038fa70: mov      x19, x0
0038fa74: ldur     x9, [x8, #-0x18]
0038fa78: sub      x8, x29, #0x48
0038fa7c: add      x0, x0, x9
0038fa80: bl       #0x50eb5c
0038fa84: adrp     x1, #0x562000
0038fa88: sub      x0, x29, #0x48
0038fa8c: ldr      x1, [x1, #0xe98]
0038fa90: bl       #0x52d1b4
0038fa94: ldr      x8, [x0]
0038fa98: ldr      x8, [x8, #0x38]
0038fa9c: mov      w1, #0xa
0038faa0: blr      x8
0038faa4: mov      w20, w0
0038faa8: sub      x0, x29, #0x48
0038faac: bl       #0x52d0b4
0038fab0: mov      x0, x19
0038fab4: mov      w1, w20
0038fab8: bl       #0x50ff00
0038fabc: mov      x0, x19
0038fac0: bl       #0x50f330
0038fac4: adrp     x1, #0x2a000
0038fac8: add      x1, x1, #0x1d5
0038facc: mov      x0, x19
0038fad0: mov      w2, #0xd
0038fad4: bl       #0x3a07c0
0038fad8: ldrb     w8, [sp, #0x58]
0038fadc: ldp      x11, x10, [sp, #0x60]
0038fae0: add      x9, sp, #0x58
0038fae4: lsr      x12, x8, #1
0038fae8: orr      x9, x9, #1
0038faec: tst      w8, #1
0038faf0: csel     x1, x9, x10, eq
0038faf4: csel     x2, x12, x11, eq
0038faf8: bl       #0x3a07c0
0038fafc: ldr      x8, [x0]
0038fb00: mov      x19, x0
0038fb04: ldur     x9, [x8, #-0x18]
0038fb08: sub      x8, x29, #0x48
0038fb0c: add      x0, x0, x9
0038fb10: bl       #0x50eb5c
0038fb14: adrp     x1, #0x562000
0038fb18: sub      x0, x29, #0x48
0038fb1c: ldr      x1, [x1, #0xe98]
0038fb20: bl       #0x52d1b4
0038fb24: ldr      x8, [x0]
0038fb28: ldr      x8, [x8, #0x38]
0038fb2c: mov      w1, #0xa
0038fb30: blr      x8
0038fb34: mov      w20, w0
0038fb38: sub      x0, x29, #0x48
0038fb3c: bl       #0x52d0b4
0038fb40: mov      x0, x19
0038fb44: mov      w1, w20
0038fb48: bl       #0x50ff00
0038fb4c: mov      x0, x19
0038fb50: bl       #0x50f330
0038fb54: adrp     x1, #0x2a000
0038fb58: add      x1, x1, #0xbe9
0038fb5c: mov      x0, x19
0038fb60: mov      w2, #0xd
0038fb64: bl       #0x3a07c0
0038fb68: ldrb     w8, [sp, #0x40]
0038fb6c: ldp      x11, x10, [sp, #0x48]
0038fb70: add      x9, sp, #0x40
0038fb74: lsr      x12, x8, #1
0038fb78: orr      x9, x9, #1
0038fb7c: tst      w8, #1
0038fb80: csel     x1, x9, x10, eq
0038fb84: csel     x2, x12, x11, eq
0038fb88: bl       #0x3a07c0
0038fb8c: ldr      x8, [x0]
0038fb90: mov      x19, x0
0038fb94: ldur     x9, [x8, #-0x18]
0038fb98: sub      x8, x29, #0x48
0038fb9c: add      x0, x0, x9
0038fba0: bl       #0x50eb5c
0038fba4: adrp     x1, #0x562000
0038fba8: sub      x0, x29, #0x48
0038fbac: ldr      x1, [x1, #0xe98]
0038fbb0: bl       #0x52d1b4
0038fbb4: ldr      x8, [x0]
0038fbb8: ldr      x8, [x8, #0x38]
0038fbbc: mov      w1, #0xa
0038fbc0: blr      x8
0038fbc4: mov      w20, w0
0038fbc8: sub      x0, x29, #0x48
0038fbcc: bl       #0x52d0b4
0038fbd0: mov      x0, x19
0038fbd4: mov      w1, w20
0038fbd8: bl       #0x50ff00
0038fbdc: mov      x0, x19
0038fbe0: bl       #0x50f330
0038fbe4: adrp     x1, #0x2a000
0038fbe8: add      x1, x1, #0x1e3
0038fbec: mov      x0, x19
0038fbf0: mov      w2, #0xd
0038fbf4: bl       #0x3a07c0
0038fbf8: ldrb     w8, [sp, #0x18]
0038fbfc: ldp      x11, x10, [sp, #0x20]
0038fc00: add      x9, sp, #0x18
0038fc04: lsr      x12, x8, #1
0038fc08: orr      x9, x9, #1
0038fc0c: tst      w8, #1
0038fc10: csel     x1, x9, x10, eq
0038fc14: csel     x2, x12, x11, eq
0038fc18: bl       #0x3a07c0
0038fc1c: ldr      x8, [x0]
0038fc20: mov      x19, x0
0038fc24: ldur     x9, [x8, #-0x18]
0038fc28: sub      x8, x29, #0x48
0038fc2c: add      x0, x0, x9
0038fc30: bl       #0x50eb5c
0038fc34: adrp     x1, #0x562000
0038fc38: sub      x0, x29, #0x48
0038fc3c: ldr      x1, [x1, #0xe98]
0038fc40: bl       #0x52d1b4
0038fc44: ldr      x8, [x0]
0038fc48: ldr      x8, [x8, #0x38]
0038fc4c: mov      w1, #0xa
0038fc50: blr      x8
0038fc54: mov      w20, w0
0038fc58: sub      x0, x29, #0x48
0038fc5c: bl       #0x52d0b4
0038fc60: mov      x0, x19
0038fc64: mov      w1, w20
0038fc68: bl       #0x50ff00
0038fc6c: mov      x0, x19
0038fc70: bl       #0x50f330
0038fc74: ldrb     w8, [sp]
0038fc78: ldr      x9, [sp, #8]
0038fc7c: lsr      x10, x8, #1
0038fc80: ands     w8, w8, #1
0038fc84: csel     x9, x10, x9, eq
0038fc88: cmp      x9, #1
0038fc8c: b.ne     #0x38fcb0
0038fc90: ldr      x9, [sp, #0x10]
0038fc94: mov      x10, sp
0038fc98: cmp      w8, #0
0038fc9c: orr      x10, x10, #1
0038fca0: csel     x9, x10, x9, eq
0038fca4: ldrb     w9, [x9]
0038fca8: cmp      w9, #0x79
0038fcac: b.eq     #0x38fdc8
0038fcb0: cbz      w8, #0x38fcbc
0038fcb4: ldr      x0, [sp, #0x10]
0038fcb8: bl       #0x54e070
0038fcbc: ldrb     w8, [sp, #0x18]
0038fcc0: tbnz     w8, #0, #0x38fd24
0038fcc4: ldrb     w8, [sp, #0x40]
0038fcc8: tbnz     w8, #0, #0x38fd34
0038fccc: ldrb     w8, [sp, #0x58]
0038fcd0: tbz      w8, #0, #0x38fcdc
0038fcd4: ldr      x0, [sp, #0x68]
0038fcd8: bl       #0x54e070
0038fcdc: ldrb     w1, [sp, #0x30]
0038fce0: add      x8, sp, #0x30
0038fce4: add      x0, x8, #8
0038fce8: bl       #0x398d18
0038fcec: ldurb    w8, [x29, #-0x60]
0038fcf0: tbz      w8, #0, #0x38fcfc
0038fcf4: ldur     x0, [x29, #-0x50]
0038fcf8: bl       #0x54e070
0038fcfc: ldr      x8, [x23, #0x28]
0038fd00: ldur     x9, [x29, #-8]
0038fd04: cmp      x8, x9
0038fd08: b.ne     #0x38ffd4
0038fd0c: ldp      x20, x19, [sp, #0x100]
0038fd10: ldp      x22, x21, [sp, #0xf0]
0038fd14: ldp      x28, x23, [sp, #0xe0]
0038fd18: ldp      x29, x30, [sp, #0xd0]
0038fd1c: add      sp, sp, #0x110
0038fd20: ret      
0038fd24: ldr      x0, [sp, #0x28]
0038fd28: bl       #0x54e070
0038fd2c: ldrb     w8, [sp, #0x40]
0038fd30: tbz      w8, #0, #0x38fccc
0038fd34: ldr      x0, [sp, #0x50]
0038fd38: bl       #0x54e070
0038fd3c: ldrb     w8, [sp, #0x58]
0038fd40: tbnz     w8, #0, #0x38fcd4
0038fd44: b        #0x38fcdc
0038fd48: adrp     x0, #0x562000
0038fd4c: adrp     x1, #0x29000
0038fd50: add      x1, x1, #0x34d
0038fd54: ldr      x0, [x0, #0xec0]
0038fd58: mov      w2, #0x12
0038fd5c: bl       #0x3a07c0
0038fd60: ldr      x8, [x0]
0038fd64: mov      x19, x0
0038fd68: ldur     x9, [x8, #-0x18]
0038fd6c: sub      x8, x29, #0x48
0038fd70: add      x0, x0, x9
0038fd74: bl       #0x50eb5c
0038fd78: adrp     x1, #0x562000
0038fd7c: sub      x0, x29, #0x48
0038fd80: ldr      x1, [x1, #0xe98]
0038fd84: bl       #0x52d1b4
0038fd88: ldr      x8, [x0]
0038fd8c: ldr      x8, [x8, #0x38]
0038fd90: mov      w1, #0xa
0038fd94: blr      x8
0038fd98: mov      w20, w0
0038fd9c: sub      x0, x29, #0x48
0038fda0: bl       #0x52d0b4
0038fda4: mov      x0, x19
0038fda8: mov      w1, w20
0038fdac: bl       #0x50ff00
0038fdb0: mov      x0, x19
0038fdb4: bl       #0x50f330
0038fdb8: ldrb     w8, [sp]
0038fdbc: and      w8, w8, #1
0038fdc0: cbnz     w8, #0x38fcb4
0038fdc4: b        #0x38fcbc
0038fdc8: adrp     x0, #0x562000
0038fdcc: adrp     x1, #0x23000
0038fdd0: add      x1, x1, #0x886
0038fdd4: ldr      x0, [x0, #0xec0]
0038fdd8: mov      w2, #0x33
0038fddc: bl       #0x3a07c0
0038fde0: bl       #0x386f34
0038fde4: ldr      x8, [x23, #0x28]
0038fde8: ldur     x9, [x29, #-8]
0038fdec: cmp      x8, x9
0038fdf0: b.ne     #0x38ffd4
0038fdf4: mov      w0, wzr
0038fdf8: bl       #0x554170 ; exit
0038fdfc: b        #0x38fe50
0038fe00: ldrb     w8, [sp]
0038fe04: mov      x19, x0
0038fe08: tbnz     w8, #0, #0x38ff6c
0038fe0c: b        #0x38ff74
0038fe10: ldrb     w8, [sp, #0x18]
0038fe14: mov      x19, x0
0038fe18: tbnz     w8, #0, #0x38ff7c
0038fe1c: b        #0x38ff84
0038fe20: ldrb     w8, [sp, #0x40]
0038fe24: mov      x19, x0
0038fe28: tbnz     w8, #0, #0x38ff8c
0038fe2c: b        #0x38ff94
0038fe30: ldrb     w8, [sp, #0x58]
0038fe34: mov      x19, x0
0038fe38: tbnz     w8, #0, #0x38ff9c
0038fe3c: b        #0x38ffa4
0038fe40: b        #0x38fe50
0038fe44: b        #0x38fe50
0038fe48: b        #0x38fe50
0038fe4c: b        #0x38fe50
0038fe50: mov      x19, x0
0038fe54: sub      x0, x29, #0x48
0038fe58: bl       #0x52d0b4
0038fe5c: b        #0x38ff64
0038fe60: bl       #0x3860c0
0038fe64: mov      x19, x0
0038fe68: b        #0x38ff74
0038fe6c: mov      x19, x0
0038fe70: b        #0x38ff84
0038fe74: mov      x19, x0
0038fe78: b        #0x38ff94
0038fe7c: b        #0x38ff48
0038fe80: ldur     x8, [x29, #-0x20]
0038fe84: mov      x19, x0
0038fe88: cmp      x8, x20
0038fe8c: b.ne     #0x38fe9c
0038fe90: mov      w9, #4
0038fe94: sub      x8, x29, #0x40
0038fe98: b        #0x38fec0
0038fe9c: cbnz     x8, #0x38febc
0038fea0: ldrb     w8, [sp, #0x58]
0038fea4: tbnz     w8, #0, #0x38fed8
0038fea8: ldrb     w8, [sp, #0x40]
0038feac: tbnz     w8, #0, #0x38fef8
0038feb0: ldurb    w8, [x29, #-0x60]
0038feb4: tbnz     w8, #0, #0x38ffb4
0038feb8: b        #0x38ffbc
0038febc: mov      w9, #5
0038fec0: ldr      x10, [x8]
0038fec4: mov      x0, x8
0038fec8: ldr      x9, [x10, x9, lsl #3]
0038fecc: blr      x9
0038fed0: ldrb     w8, [sp, #0x58]
0038fed4: tbz      w8, #0, #0x38fea8
0038fed8: ldr      x0, [sp, #0x68]
0038fedc: bl       #0x54e070
0038fee0: ldrb     w8, [sp, #0x40]
0038fee4: tbz      w8, #0, #0x38feb0
0038fee8: b        #0x38fef8
0038feec: mov      x19, x0
0038fef0: ldrb     w8, [sp, #0x40]
0038fef4: tbz      w8, #0, #0x38feb0
0038fef8: ldr      x0, [sp, #0x50]
0038fefc: bl       #0x54e070
0038ff00: ldurb    w8, [x29, #-0x60]
0038ff04: tbnz     w8, #0, #0x38ffb4
0038ff08: b        #0x38ffbc
0038ff0c: mov      x19, x0
0038ff10: ldurb    w8, [x29, #-0x60]
0038ff14: tbnz     w8, #0, #0x38ffb4
0038ff18: b        #0x38ffbc
0038ff1c: ldrb     w8, [sp, #0x40]
0038ff20: mov      x19, x0
0038ff24: tbz      w8, #0, #0x38ff38
0038ff28: ldr      x0, [sp, #0x50]
0038ff2c: bl       #0x54e070
0038ff30: b        #0x38ff38
0038ff34: mov      x19, x0
0038ff38: ldrb     w8, [sp, #0x58]
0038ff3c: tbz      w8, #0, #0x38ffbc
0038ff40: ldr      x0, [sp, #0x68]
0038ff44: b        #0x38ffb8
0038ff48: mov      x19, x0
0038ff4c: b        #0x38ffa4
0038ff50: mov      x19, x0
0038ff54: sub      x0, x29, #0x60
0038ff58: bl       #0x52d0b4
0038ff5c: b        #0x38ffbc
0038ff60: mov      x19, x0
0038ff64: ldrb     w8, [sp]
0038ff68: tbz      w8, #0, #0x38ff74
0038ff6c: ldr      x0, [sp, #0x10]
0038ff70: bl       #0x54e070
0038ff74: ldrb     w8, [sp, #0x18]
0038ff78: tbz      w8, #0, #0x38ff84
0038ff7c: ldr      x0, [sp, #0x28]
0038ff80: bl       #0x54e070
0038ff84: ldrb     w8, [sp, #0x40]
0038ff88: tbz      w8, #0, #0x38ff94
0038ff8c: ldr      x0, [sp, #0x50]
0038ff90: bl       #0x54e070
0038ff94: ldrb     w8, [sp, #0x58]
0038ff98: tbz      w8, #0, #0x38ffa4
0038ff9c: ldr      x0, [sp, #0x68]
0038ffa0: bl       #0x54e070
0038ffa4: add      x0, sp, #0x30
0038ffa8: bl       #0x391938
0038ffac: ldurb    w8, [x29, #-0x60]
0038ffb0: tbz      w8, #0, #0x38ffbc
0038ffb4: ldur     x0, [x29, #-0x50]
0038ffb8: bl       #0x54e070
0038ffbc: ldr      x8, [x23, #0x28]
0038ffc0: ldur     x9, [x29, #-8]
0038ffc4: cmp      x8, x9
0038ffc8: b.ne     #0x38ffd4
0038ffcc: mov      x0, x19
0038ffd0: bl       #0x54fffc
0038ffd4: bl       #0x553f00 ; __stack_chk_fail
