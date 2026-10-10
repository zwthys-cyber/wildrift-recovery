0038dca4: stp      x29, x30, [sp, #-0x60]!
0038dca8: stp      x28, x27, [sp, #0x10]
0038dcac: stp      x26, x25, [sp, #0x20]
0038dcb0: stp      x24, x23, [sp, #0x30]
0038dcb4: stp      x22, x21, [sp, #0x40]
0038dcb8: stp      x20, x19, [sp, #0x50]
0038dcbc: mov      x29, sp
0038dcc0: sub      sp, sp, #0x2b0
0038dcc4: mrs      x8, tpidr_el0
0038dcc8: adrp     x9, #0x2a000
0038dccc: add      x9, x9, #0xbcb
0038dcd0: str      x8, [sp, #0x28]
0038dcd4: ldr      q0, [x9]
0038dcd8: sub      x19, x29, #0xb8
0038dcdc: ldr      x8, [x8, #0x28]
0038dce0: add      x20, sp, #0xe8
0038dce4: mov      w10, #0x20
0038dce8: stur     x8, [x29, #-0x18]
0038dcec: mov      w8, #0xa
0038dcf0: stur     q0, [x19, #1]
0038dcf4: sturb    wzr, [x29, #-0xa7]
0038dcf8: ldur     x9, [x29, #-0xa8]
0038dcfc: sturb    w10, [x29, #-0xb8]
0038dd00: strb     w8, [sp, #0x148]
0038dd04: mov      w8, #0x3637
0038dd08: ldr      q0, [x19]
0038dd0c: str      x9, [sp, #0x140]
0038dd10: mov      w9, #0x4f71
0038dd14: movk     w8, #0x3039, lsl #16
0038dd18: movk     w9, #0x6874, lsl #16
0038dd1c: stur     w8, [x20, #0x61]
0038dd20: mov      w8, #0x33
0038dd24: str      w9, [sp, #0x11c]
0038dd28: mov      w9, #0x6870
0038dd2c: movk     w9, #0x7139, lsl #16
0038dd30: sturh    w8, [x20, #0x65]
0038dd34: stur     w9, [x20, #0x31]
0038dd38: mov      x9, #0x716a
0038dd3c: movk     x9, #0x3450, lsl #16
0038dd40: str      q0, [sp, #0x130]
0038dd44: movk     x9, #0x3637, lsl #32
0038dd48: strb     w10, [sp, #0x118]
0038dd4c: movk     x9, #0x3039, lsl #48
0038dd50: stp      x9, x8, [sp, #0x120]
0038dd54: add      x0, sp, #0x160
0038dd58: add      x1, sp, #0x148
0038dd5c: add      x2, sp, #0x130
0038dd60: add      x3, sp, #0x118
0038dd64: mov      w4, #0xe7ae
0038dd68: bl       #0x38f57c
0038dd6c: ldrb     w8, [sp, #0x118]
0038dd70: tbnz     w8, #0, #0x38ea70
0038dd74: ldrb     w8, [sp, #0x130]
0038dd78: tbnz     w8, #0, #0x38ea80
0038dd7c: ldrb     w8, [sp, #0x148]
0038dd80: tbz      w8, #0, #0x38dd8c
0038dd84: ldr      x0, [sp, #0x158]
0038dd88: bl       #0x54e070
0038dd8c: mov      w9, #0x2e33
0038dd90: mov      w8, #6
0038dd94: movk     w9, #0x33, lsl #16
0038dd98: strb     w8, [sp, #0x100]
0038dd9c: stur     w9, [x20, #0x19]
0038dda0: add      x0, sp, #0x160
0038dda4: add      x1, sp, #0x100
0038dda8: bl       #0x38f6d0
0038ddac: ldrb     w8, [sp, #0x100]
0038ddb0: tbz      w8, #0, #0x38ddbc
0038ddb4: ldr      x0, [sp, #0x110]
0038ddb8: bl       #0x54e070
0038ddbc: orr      x8, x19, #1
0038ddc0: adrp     x0, #0x2b000
0038ddc4: add      x0, x0, #0x6b9
0038ddc8: str      x8, [sp, #0x20]
0038ddcc: bl       #0x553f60 ; puts
0038ddd0: add      x8, sp, #0xe8
0038ddd4: sub      x9, x29, #0xa0
0038ddd8: mov      x22, #0x2600
0038dddc: orr      x28, x8, #1
0038dde0: add      x8, sp, #0x40
0038dde4: adrp     x19, #0x2a000
0038dde8: add      x19, x19, #0xbdc
0038ddec: orr      x10, x8, #1
0038ddf0: orr      x8, x9, #1
0038ddf4: stp      x8, x10, [sp, #0x10]
0038ddf8: adrp     x8, #0x20000
0038ddfc: adrp     x23, #0x28000
0038de00: add      x23, x23, #0x989
0038de04: ldr      q0, [x8, #0x500]
0038de08: adrp     x27, #0x21000
0038de0c: add      x27, x27, #0x9cc
0038de10: mov      w24, #1
0038de14: movk     x22, #1, lsl #32
0038de18: str      q0, [sp, #0x30]
0038de1c: b        #0x38de28
0038de20: cmp      w21, #2
0038de24: b.ne     #0x38e968
0038de28: mov      x0, x19
0038de2c: mov      x1, x23
0038de30: stp      xzr, xzr, [sp, #0xe8]
0038de34: str      xzr, [sp, #0xf8]
0038de38: bl       #0x5540c0 ; fopen
0038de3c: cbz      x0, #0x38def8
0038de40: movi     v0.2d, #0000000000000000
0038de44: mov      x26, x0
0038de48: sub      x0, x29, #0xa0
0038de4c: mov      w1, #0x80
0038de50: mov      x2, x26
0038de54: stp      q0, q0, [x29, #-0xa0]
0038de58: stp      q0, q0, [x29, #-0x80]
0038de5c: stp      q0, q0, [x29, #-0x60]
0038de60: stp      q0, q0, [x29, #-0x40]
0038de64: bl       #0x553f90 ; fgets
0038de68: cbz      x0, #0x38def0
0038de6c: add      x0, sp, #0xe8
0038de70: sub      x1, x29, #0xa0
0038de74: bl       #0x50c208
0038de78: b        #0x38de84
0038de7c: str      x8, [sp, #0xf0]
0038de80: strb     wzr, [x10, x8]
0038de84: ldrb     w8, [sp, #0xe8]
0038de88: ldr      x9, [sp, #0xf0]
0038de8c: lsr      x10, x8, #1
0038de90: tst      w8, #1
0038de94: csel     x8, x10, x9, eq
0038de98: cset     w9, eq
0038de9c: cbz      x8, #0x38def0
0038dea0: ldr      x10, [sp, #0xf8]
0038dea4: tst      w9, #1
0038dea8: csel     x1, x28, x10, ne
0038deac: add      x11, x1, x8
0038deb0: ldurb    w11, [x11, #-1]
0038deb4: lsl      x12, x24, x11
0038deb8: cmp      w11, #0x20
0038debc: and      x11, x12, x22
0038dec0: ccmp     x11, #0, #4, ls
0038dec4: b.eq     #0x38dee4
0038dec8: sub      x8, x8, #1
0038decc: tbz      w9, #0, #0x38de7c
0038ded0: lsl      w9, w8, #1
0038ded4: mov      x10, x28
0038ded8: strb     w9, [sp, #0xe8]
0038dedc: strb     wzr, [x28, x8]
0038dee0: b        #0x38de84
0038dee4: adrp     x0, #0x2b000
0038dee8: add      x0, x0, #0x1b3 ; '已读取缓存卡密: %s\n'
0038deec: bl       #0x553fa0 ; printf
0038def0: mov      x0, x26
0038def4: bl       #0x5540d0 ; fclose
0038def8: ldrb     w8, [sp, #0xe8]
0038defc: ldr      x2, [sp, #0xf0]
0038df00: lsr      x9, x8, #1
0038df04: tst      w8, #1
0038df08: csel     x9, x9, x2, eq
0038df0c: cbz      x9, #0x38df28
0038df10: tbnz     w8, #0, #0x38dff8
0038df14: ldr      q0, [x20]
0038df18: ldr      x8, [sp, #0xf8]
0038df1c: str      q0, [sp, #0xc0]
0038df20: str      x8, [sp, #0xd0]
0038df24: b        #0x38e004
0038df28: adrp     x0, #0x24000
0038df2c: add      x0, x0, #0x2e6 ; '请输入卡密: '
0038df30: bl       #0x553fa0 ; printf
0038df34: adrp     x8, #0x562000
0038df38: ldr      x8, [x8, #0xec8]
0038df3c: ldr      x0, [x8]
0038df40: bl       #0x5540e0 ; fflush
0038df44: adrp     x0, #0x562000
0038df48: add      x1, sp, #0xe8
0038df4c: ldr      x0, [x0, #0xed0]
0038df50: bl       #0x38ffd8
0038df54: ldr      x8, [x0]
0038df58: mov      w9, #5
0038df5c: ldur     x8, [x8, #-0x18]
0038df60: add      x8, x0, x8
0038df64: ldrb     w8, [x8, #0x20]
0038df68: tst      w8, w9
0038df6c: b.eq     #0x38e224
0038df70: adrp     x9, #0x562000
0038df74: ldr      x9, [x9, #0xed0]
0038df78: ldr      x8, [x9]
0038df7c: ldur     x8, [x8, #-0x18]
0038df80: add      x0, x9, x8
0038df84: mov      w1, wzr
0038df88: bl       #0x50ec24
0038df8c: adrp     x0, #0x562000
0038df90: adrp     x1, #0x25000
0038df94: add      x1, x1, #0xc1
0038df98: ldr      x0, [x0, #0xec0]
0038df9c: mov      w2, #0x18
0038dfa0: bl       #0x3a07c0
0038dfa4: ldr      x8, [x0]
0038dfa8: mov      x26, x0
0038dfac: ldur     x9, [x8, #-0x18]
0038dfb0: sub      x8, x29, #0xa0
0038dfb4: add      x0, x0, x9
0038dfb8: bl       #0x50eb5c
0038dfbc: adrp     x1, #0x562000
0038dfc0: sub      x0, x29, #0xa0
0038dfc4: ldr      x1, [x1, #0xe98]
0038dfc8: bl       #0x52d1b4
0038dfcc: ldr      x8, [x0]
0038dfd0: ldr      x8, [x8, #0x38]
0038dfd4: mov      w1, #0xa
0038dfd8: blr      x8
0038dfdc: mov      w21, w0
0038dfe0: sub      x0, x29, #0xa0
0038dfe4: bl       #0x52d0b4
0038dfe8: mov      x0, x26
0038dfec: mov      w1, w21
0038dff0: bl       #0x50ff00
0038dff4: b        #0x38e310
0038dff8: ldr      x1, [sp, #0xf8]
0038dffc: add      x0, sp, #0xc0
0038e000: bl       #0x3a06bc
0038e004: add      x8, sp, #0xd8
0038e008: add      x0, sp, #0x160
0038e00c: add      x1, sp, #0xc0
0038e010: bl       #0x390230
0038e014: ldrb     w8, [sp, #0xc0]
0038e018: tbz      w8, #0, #0x38e024
0038e01c: ldr      x0, [sp, #0xd0]
0038e020: bl       #0x54e070
0038e024: ldrb     w8, [sp, #0xd8]
0038e028: cmp      w8, #1
0038e02c: b.ne     #0x38e18c
0038e030: ldr      x21, [sp, #0xe0]
0038e034: mov      x25, x23
0038e038: ldr      x23, [x21, #8]!
0038e03c: cbz      x23, #0x38e084
0038e040: mov      x26, x21
0038e044: add      x0, x23, #0x20
0038e048: mov      x1, x27
0038e04c: bl       #0x50c188
0038e050: add      x8, x23, #8
0038e054: cmp      w0, #0
0038e058: csel     x8, x8, x23, lt
0038e05c: csel     x26, x26, x23, lt
0038e060: ldr      x23, [x8]
0038e064: cbnz     x23, #0x38e044
0038e068: cmp      x26, x21
0038e06c: b.eq     #0x38e084
0038e070: add      x0, x26, #0x20
0038e074: mov      x1, x27
0038e078: bl       #0x50c188
0038e07c: cmp      w0, #0
0038e080: csel     x21, x21, x26, gt
0038e084: ldr      x8, [sp, #0xe0]
0038e088: mov      x23, x25
0038e08c: add      x8, x8, #8
0038e090: cmp      x21, x8
0038e094: b.eq     #0x38e18c
0038e098: add      x0, sp, #0xd8
0038e09c: mov      x1, x27
0038e0a0: bl       #0x39160c
0038e0a4: ldr      q0, [sp, #0x30]
0038e0a8: sub      x1, x29, #0xa0
0038e0ac: stur     q0, [x29, #-0xa0]
0038e0b0: bl       #0x39f9c4
0038e0b4: ldurb    w1, [x29, #-0xa0]
0038e0b8: mov      w21, w0
0038e0bc: sub      x8, x29, #0xa0
0038e0c0: orr      x0, x8, #8
0038e0c4: bl       #0x398d18
0038e0c8: tbz      w21, #0, #0x38e18c
0038e0cc: stur     xzr, [x29, #-0xa0]
0038e0d0: add      x0, sp, #0xd8
0038e0d4: sub      x2, x29, #0xa0
0038e0d8: adrp     x1, #0x21000
0038e0dc: add      x1, x1, #0x9d1
0038e0e0: bl       #0x391734
0038e0e4: mov      x21, x0
0038e0e8: bl       #0x50aa80
0038e0ec: mov      x8, #0xcb25
0038e0f0: movk     x8, #0x2849, lsl #16
0038e0f4: movk     x8, #0x217d, lsl #32
0038e0f8: movk     x8, #0xbce4, lsl #48
0038e0fc: smulh    x8, x0, x8
0038e100: asr      x9, x8, #0x12
0038e104: add      x8, x9, x8, lsr #63
0038e108: add      x8, x21, x8
0038e10c: sub      x8, x8, #0x1f
0038e110: cmn      x8, #0x3e
0038e114: b.hi     #0x38e330
0038e118: adrp     x0, #0x562000
0038e11c: adrp     x1, #0x2b000
0038e120: add      x1, x1, #0xb10
0038e124: ldr      x0, [x0, #0xec0]
0038e128: mov      w2, #0x12
0038e12c: bl       #0x3a07c0
0038e130: ldr      x8, [x0]
0038e134: mov      x21, x0
0038e138: ldur     x9, [x8, #-0x18]
0038e13c: sub      x8, x29, #0xa0
0038e140: add      x0, x0, x9
0038e144: bl       #0x50eb5c
0038e148: adrp     x1, #0x562000
0038e14c: sub      x0, x29, #0xa0
0038e150: ldr      x1, [x1, #0xe98]
0038e154: bl       #0x52d1b4
0038e158: ldr      x8, [x0]
0038e15c: ldr      x8, [x8, #0x38]
0038e160: mov      w1, #0xa
0038e164: blr      x8
0038e168: mov      w26, w0
0038e16c: sub      x0, x29, #0xa0
0038e170: bl       #0x52d0b4
0038e174: mov      x0, x21
0038e178: mov      w1, w26
0038e17c: bl       #0x50ff00
0038e180: mov      x0, x21
0038e184: bl       #0x50f330
0038e188: b        #0x38e1fc
0038e18c: adrp     x0, #0x562000
0038e190: adrp     x1, #0x28000
0038e194: add      x1, x1, #0x98b ; '登录失败，请重新输入卡密'
0038e198: ldr      x0, [x0, #0xec0]
0038e19c: mov      w2, #0x24
0038e1a0: bl       #0x3a07c0
0038e1a4: ldr      x8, [x0]
0038e1a8: mov      x21, x0
0038e1ac: ldur     x9, [x8, #-0x18]
0038e1b0: sub      x8, x29, #0xa0
0038e1b4: add      x0, x0, x9
0038e1b8: bl       #0x50eb5c
0038e1bc: adrp     x1, #0x562000
0038e1c0: sub      x0, x29, #0xa0
0038e1c4: ldr      x1, [x1, #0xe98]
0038e1c8: bl       #0x52d1b4
0038e1cc: ldr      x8, [x0]
0038e1d0: ldr      x8, [x8, #0x38]
0038e1d4: mov      w1, #0xa
0038e1d8: blr      x8
0038e1dc: mov      w26, w0
0038e1e0: sub      x0, x29, #0xa0
0038e1e4: bl       #0x52d0b4
0038e1e8: mov      x0, x21
0038e1ec: mov      w1, w26
0038e1f0: bl       #0x50ff00
0038e1f4: mov      x0, x21
0038e1f8: bl       #0x50f330
0038e1fc: mov      x0, x19
0038e200: bl       #0x5540f0 ; remove
0038e204: mov      w21, #2
0038e208: ldrb     w1, [sp, #0xd8]
0038e20c: add      x8, sp, #0xd8
0038e210: add      x0, x8, #8
0038e214: bl       #0x398d18
0038e218: ldrb     w8, [sp, #0xe8]
0038e21c: tbz      w8, #0, #0x38de20
0038e220: b        #0x38e324
0038e224: ldrb     w8, [sp, #0xe8]
0038e228: ldr      x2, [sp, #0xf0]
0038e22c: lsr      x9, x8, #1
0038e230: tst      w8, #1
0038e234: cset     w10, eq
0038e238: csel     x9, x9, x2, eq
0038e23c: cbz      x9, #0x38e2a8
0038e240: b        #0x38e270
0038e244: lsl      w9, w8, #1
0038e248: mov      x11, x28
0038e24c: strb     w9, [sp, #0xe8]
0038e250: strb     wzr, [x11, x8]
0038e254: ldrb     w8, [sp, #0xe8]
0038e258: ldr      x2, [sp, #0xf0]
0038e25c: lsr      x9, x8, #1
0038e260: tst      w8, #1
0038e264: cset     w10, eq
0038e268: csel     x9, x9, x2, eq
0038e26c: cbz      x9, #0x38e2a8
0038e270: ldr      x11, [sp, #0xf8]
0038e274: tst      w10, #1
0038e278: csel     x12, x28, x11, ne
0038e27c: add      x12, x12, x9
0038e280: ldurb    w12, [x12, #-1]
0038e284: lsl      x13, x24, x12
0038e288: cmp      w12, #0x20
0038e28c: and      x12, x13, x22
0038e290: ccmp     x12, #0, #4, ls
0038e294: b.eq     #0x38df10
0038e298: sub      x8, x9, #1
0038e29c: tbnz     w10, #0, #0x38e244
0038e2a0: str      x8, [sp, #0xf0]
0038e2a4: b        #0x38e250
0038e2a8: adrp     x0, #0x562000
0038e2ac: adrp     x1, #0x29000
0038e2b0: add      x1, x1, #0x328 ; '卡密不能为空，请重新输入'
0038e2b4: ldr      x0, [x0, #0xec0]
0038e2b8: mov      w2, #0x24
0038e2bc: bl       #0x3a07c0
0038e2c0: ldr      x8, [x0]
0038e2c4: mov      x26, x0
0038e2c8: ldur     x9, [x8, #-0x18]
0038e2cc: sub      x8, x29, #0xa0
0038e2d0: add      x0, x0, x9
0038e2d4: bl       #0x50eb5c
0038e2d8: adrp     x1, #0x562000
0038e2dc: sub      x0, x29, #0xa0
0038e2e0: ldr      x1, [x1, #0xe98]
0038e2e4: bl       #0x52d1b4
0038e2e8: ldr      x8, [x0]
0038e2ec: ldr      x8, [x8, #0x38]
0038e2f0: mov      w1, #0xa
0038e2f4: blr      x8
0038e2f8: mov      w21, w0
0038e2fc: sub      x0, x29, #0xa0
0038e300: bl       #0x52d0b4
0038e304: mov      x0, x26
0038e308: mov      w1, w21
0038e30c: bl       #0x50ff00
0038e310: mov      x0, x26
0038e314: bl       #0x50f330
0038e318: mov      w21, #2
0038e31c: ldrb     w8, [sp, #0xe8]
0038e320: tbz      w8, #0, #0x38de20
0038e324: ldr      x0, [sp, #0xf8]
0038e328: bl       #0x54e070
0038e32c: b        #0x38de20
0038e330: ldrb     w8, [sp, #0xd8]
0038e334: cmp      w8, #1
0038e338: b.ne     #0x38e51c
0038e33c: ldr      x23, [sp, #0xe0]
0038e340: ldr      x20, [x23, #8]!
0038e344: cbz      x20, #0x38e3a0
0038e348: mov      x26, x23
0038e34c: adrp     x19, #0x2a000
0038e350: add      x19, x19, #0x6bc
0038e354: add      x0, x20, #0x20
0038e358: mov      x1, x19
0038e35c: bl       #0x50c188
0038e360: add      x8, x20, #8
0038e364: cmp      w0, #0
0038e368: csel     x8, x8, x20, lt
0038e36c: csel     x26, x26, x20, lt
0038e370: ldr      x20, [x8]
0038e374: cbnz     x20, #0x38e354
0038e378: cmp      x26, x23
0038e37c: adrp     x19, #0x2a000
0038e380: add      x19, x19, #0xbdc
0038e384: b.eq     #0x38e3a0
0038e388: add      x0, x26, #0x20
0038e38c: adrp     x1, #0x2a000
0038e390: add      x1, x1, #0x6bc
0038e394: bl       #0x50c188
0038e398: cmp      w0, #0
0038e39c: csel     x23, x23, x26, gt
0038e3a0: ldr      x8, [sp, #0xe0]
0038e3a4: add      x20, sp, #0xe8
0038e3a8: add      x8, x8, #8
0038e3ac: cmp      x23, x8
0038e3b0: mov      x23, x25
0038e3b4: b.eq     #0x38e51c
0038e3b8: add      x0, sp, #0xd8
0038e3bc: adrp     x1, #0x2a000
0038e3c0: add      x1, x1, #0x6bc
0038e3c4: bl       #0x39160c
0038e3c8: mov      x26, x0
0038e3cc: add      x8, sp, #0x58
0038e3d0: mov      x0, x21
0038e3d4: bl       #0x50cee0
0038e3d8: ldurb    w8, [x29, #-0xb8]
0038e3dc: ldp      x10, x9, [x29, #-0xb0]
0038e3e0: lsr      x11, x8, #1
0038e3e4: tst      w8, #1
0038e3e8: ldr      x8, [sp, #0x20]
0038e3ec: csel     x1, x8, x9, eq
0038e3f0: csel     x2, x11, x10, eq
0038e3f4: add      x0, sp, #0x58
0038e3f8: bl       #0x50ba70
0038e3fc: ldr      x8, [x0, #0x10]
0038e400: ldr      q0, [x0]
0038e404: str      x8, [sp, #0x80]
0038e408: str      q0, [sp, #0x70]
0038e40c: stp      xzr, xzr, [x0, #8]
0038e410: str      xzr, [x0]
0038e414: ldrb     w8, [sp, #0x1e0]
0038e418: tbnz     w8, #0, #0x38e434
0038e41c: add      x8, sp, #0x160
0038e420: ldur     q0, [x8, #0x80]
0038e424: ldur     x8, [x8, #0x90]
0038e428: str      q0, [sp, #0x40]
0038e42c: str      x8, [sp, #0x50]
0038e430: b        #0x38e440
0038e434: ldp      x2, x1, [sp, #0x1e8]
0038e438: add      x0, sp, #0x40
0038e43c: bl       #0x3a06bc
0038e440: ldrb     w8, [sp, #0x40]
0038e444: ldp      x10, x9, [sp, #0x48]
0038e448: lsr      x11, x8, #1
0038e44c: tst      w8, #1
0038e450: ldr      x8, [sp, #0x18]
0038e454: csel     x1, x8, x9, eq
0038e458: csel     x2, x11, x10, eq
0038e45c: add      x0, sp, #0x70
0038e460: bl       #0x50ba70
0038e464: ldr      q0, [x0]
0038e468: str      q0, [sp, #0x90]
0038e46c: ldr      x8, [x0, #0x10]
0038e470: str      x8, [sp, #0xa0]
0038e474: stp      xzr, xzr, [x0, #8]
0038e478: str      xzr, [x0]
0038e47c: sub      x8, x29, #0xa0
0038e480: add      x0, sp, #0x90
0038e484: bl       #0x38d3a8
0038e488: mov      w8, #3
0038e48c: stp      xzr, xzr, [sp, #0xb0]
0038e490: strb     w8, [sp, #0xb0]
0038e494: mov      w0, #0x18
0038e498: bl       #0x54dfc0
0038e49c: ldur     q0, [x29, #-0xa0]
0038e4a0: ldur     x8, [x29, #-0x90]
0038e4a4: stp      xzr, xzr, [x29, #-0x98]
0038e4a8: stur     xzr, [x29, #-0xa0]
0038e4ac: str      q0, [x0]
0038e4b0: str      x8, [x0, #0x10]
0038e4b4: str      x0, [sp, #0xb8]
0038e4b8: ldrb     w8, [x26]
0038e4bc: cmp      w8, #9
0038e4c0: b.ne     #0x38e4d0
0038e4c4: mov      w21, wzr
0038e4c8: mov      w1, #3
0038e4cc: b        #0x38e4e4
0038e4d0: add      x1, sp, #0xb0
0038e4d4: mov      x0, x26
0038e4d8: bl       #0x39f9c4
0038e4dc: ldrb     w1, [sp, #0xb0]
0038e4e0: eor      w21, w0, #1
0038e4e4: add      x8, sp, #0xb0
0038e4e8: add      x0, x8, #8
0038e4ec: bl       #0x398d18
0038e4f0: ldurb    w8, [x29, #-0xa0]
0038e4f4: tbnz     w8, #0, #0x38e590
0038e4f8: ldrb     w8, [sp, #0x90]
0038e4fc: tbnz     w8, #0, #0x38e5a0
0038e500: ldrb     w8, [sp, #0x40]
0038e504: tbnz     w8, #0, #0x38e5b0
0038e508: ldrb     w8, [sp, #0x70]
0038e50c: tbnz     w8, #0, #0x38e5c0
0038e510: ldrb     w8, [sp, #0x58]
0038e514: tbnz     w8, #0, #0x38e5d0
0038e518: tbz      w21, #0, #0x38e5dc
0038e51c: adrp     x0, #0x562000
0038e520: adrp     x1, #0x27000
0038e524: add      x1, x1, #0xf78
0038e528: ldr      x0, [x0, #0xec0]
0038e52c: mov      w2, #0xc
0038e530: bl       #0x3a07c0
0038e534: ldr      x8, [x0]
0038e538: mov      x21, x0
0038e53c: ldur     x9, [x8, #-0x18]
0038e540: sub      x8, x29, #0xa0
0038e544: add      x0, x0, x9
0038e548: bl       #0x50eb5c
0038e54c: adrp     x1, #0x562000
0038e550: sub      x0, x29, #0xa0
0038e554: ldr      x1, [x1, #0xe98]
0038e558: bl       #0x52d1b4
0038e55c: ldr      x8, [x0]
0038e560: ldr      x8, [x8, #0x38]
0038e564: mov      w1, #0xa
0038e568: blr      x8
0038e56c: mov      w26, w0
0038e570: sub      x0, x29, #0xa0
0038e574: bl       #0x52d0b4
0038e578: mov      x0, x21
0038e57c: mov      w1, w26
0038e580: bl       #0x50ff00
0038e584: mov      x0, x21
0038e588: bl       #0x50f330
0038e58c: b        #0x38e1fc
0038e590: ldur     x0, [x29, #-0x90]
0038e594: bl       #0x54e070
0038e598: ldrb     w8, [sp, #0x90]
0038e59c: tbz      w8, #0, #0x38e500
0038e5a0: ldr      x0, [sp, #0xa0]
0038e5a4: bl       #0x54e070
0038e5a8: ldrb     w8, [sp, #0x40]
0038e5ac: tbz      w8, #0, #0x38e508
0038e5b0: ldr      x0, [sp, #0x50]
0038e5b4: bl       #0x54e070
0038e5b8: ldrb     w8, [sp, #0x70]
0038e5bc: tbz      w8, #0, #0x38e510
0038e5c0: ldr      x0, [sp, #0x80]
0038e5c4: bl       #0x54e070
0038e5c8: ldrb     w8, [sp, #0x58]
0038e5cc: tbz      w8, #0, #0x38e518
0038e5d0: ldr      x0, [sp, #0x68]
0038e5d4: bl       #0x54e070
0038e5d8: tbnz     w21, #0, #0x38e51c
0038e5dc: mov      x0, x19
0038e5e0: adrp     x1, #0x2a000
0038e5e4: add      x1, x1, #0x6c2
0038e5e8: bl       #0x5540c0 ; fopen
0038e5ec: cbz      x0, #0x38e614
0038e5f0: ldrb     w8, [sp, #0xe8]
0038e5f4: ldr      x9, [sp, #0xf8]
0038e5f8: mov      x21, x0
0038e5fc: mov      x1, x21
0038e600: tst      w8, #1
0038e604: csel     x0, x28, x9, eq
0038e608: bl       #0x554100 ; fputs
0038e60c: mov      x0, x21
0038e610: bl       #0x5540d0 ; fclose
0038e614: ldrb     w8, [sp, #0xd8]
0038e618: cmp      w8, #1
0038e61c: b.ne     #0x38e954
0038e620: ldr      x21, [sp, #0xe0]
0038e624: ldr      x20, [x21, #8]!
0038e628: cbz      x20, #0x38e67c
0038e62c: mov      x23, x21
0038e630: adrp     x26, #0x21000
0038e634: add      x26, x26, #0x3de
0038e638: add      x0, x20, #0x20
0038e63c: mov      x1, x26
0038e640: bl       #0x50c188
0038e644: add      x8, x20, #8
0038e648: cmp      w0, #0
0038e64c: csel     x8, x8, x20, lt
0038e650: csel     x23, x23, x20, lt
0038e654: ldr      x20, [x8]
0038e658: cbnz     x20, #0x38e638
0038e65c: cmp      x23, x21
0038e660: b.eq     #0x38e67c
0038e664: add      x0, x23, #0x20
0038e668: adrp     x1, #0x21000
0038e66c: add      x1, x1, #0x3de
0038e670: bl       #0x50c188
0038e674: cmp      w0, #0
0038e678: csel     x21, x21, x23, gt
0038e67c: ldr      x8, [sp, #0xe0]
0038e680: add      x20, sp, #0xe8
0038e684: mov      x23, x25
0038e688: add      x8, x8, #8
0038e68c: cmp      x21, x8
0038e690: b.eq     #0x38e830
0038e694: add      x0, sp, #0xd8
0038e698: adrp     x1, #0x21000
0038e69c: add      x1, x1, #0x3de
0038e6a0: bl       #0x39160c
0038e6a4: ldrb     w8, [x0]
0038e6a8: mov      x21, x0
0038e6ac: cmp      w8, #1
0038e6b0: b.ne     #0x38e830
0038e6b4: ldr      x26, [x21, #8]
0038e6b8: ldr      x20, [x26, #8]!
0038e6bc: cbz      x20, #0x38e718
0038e6c0: str      x26, [sp, #8]
0038e6c4: mov      x23, x26
0038e6c8: adrp     x26, #0x21000
0038e6cc: add      x26, x26, #0x3e2
0038e6d0: add      x0, x20, #0x20
0038e6d4: mov      x1, x26
0038e6d8: bl       #0x50c188
0038e6dc: add      x8, x20, #8
0038e6e0: cmp      w0, #0
0038e6e4: csel     x8, x8, x20, lt
0038e6e8: csel     x23, x23, x20, lt
0038e6ec: ldr      x20, [x8]
0038e6f0: cbnz     x20, #0x38e6d0
0038e6f4: ldr      x26, [sp, #8]
0038e6f8: cmp      x23, x26
0038e6fc: b.eq     #0x38e718
0038e700: add      x0, x23, #0x20
0038e704: adrp     x1, #0x21000
0038e708: add      x1, x1, #0x3e2
0038e70c: bl       #0x50c188
0038e710: cmp      w0, #0
0038e714: csel     x26, x26, x23, gt
0038e718: ldr      x8, [x21, #8]
0038e71c: add      x20, sp, #0xe8
0038e720: mov      x23, x25
0038e724: add      x8, x8, #8
0038e728: cmp      x26, x8
0038e72c: b.eq     #0x38e830
0038e730: add      x0, sp, #0xd8
0038e734: adrp     x1, #0x21000
0038e738: add      x1, x1, #0x3de
0038e73c: bl       #0x39160c
0038e740: adrp     x1, #0x21000
0038e744: add      x1, x1, #0x3e2
0038e748: bl       #0x39160c
0038e74c: mov      x1, x27
0038e750: bl       #0x391954
0038e754: tbz      w0, #0, #0x38e830
0038e758: adrp     x0, #0x562000
0038e75c: adrp     x1, #0x20000
0038e760: add      x1, x1, #0xa3c
0038e764: ldr      x0, [x0, #0xec0]
0038e768: mov      w2, #0xd
0038e76c: bl       #0x3a07c0
0038e770: mov      x21, x0
0038e774: add      x0, sp, #0xd8
0038e778: adrp     x1, #0x21000
0038e77c: add      x1, x1, #0x3de
0038e780: bl       #0x39160c
0038e784: str      xzr, [sp, #0x70]
0038e788: add      x2, sp, #0x70
0038e78c: adrp     x1, #0x2a000
0038e790: add      x1, x1, #0x6c4
0038e794: bl       #0x3919f8
0038e798: sub      x8, x29, #0xa0
0038e79c: bl       #0x38976c
0038e7a0: ldurb    w8, [x29, #-0xa0]
0038e7a4: ldp      x10, x9, [x29, #-0x98]
0038e7a8: lsr      x11, x8, #1
0038e7ac: tst      w8, #1
0038e7b0: ldr      x8, [sp, #0x10]
0038e7b4: csel     x1, x8, x9, eq
0038e7b8: csel     x2, x11, x10, eq
0038e7bc: mov      x0, x21
0038e7c0: bl       #0x3a07c0
0038e7c4: ldr      x8, [x0]
0038e7c8: mov      x21, x0
0038e7cc: ldur     x9, [x8, #-0x18]
0038e7d0: add      x8, sp, #0x90
0038e7d4: add      x0, x0, x9
0038e7d8: bl       #0x50eb5c
0038e7dc: adrp     x1, #0x562000
0038e7e0: add      x0, sp, #0x90
0038e7e4: ldr      x1, [x1, #0xe98]
0038e7e8: bl       #0x52d1b4
0038e7ec: ldr      x8, [x0]
0038e7f0: ldr      x8, [x8, #0x38]
0038e7f4: mov      w1, #0xa
0038e7f8: blr      x8
0038e7fc: mov      w26, w0
0038e800: add      x0, sp, #0x90
0038e804: bl       #0x52d0b4
0038e808: mov      x0, x21
0038e80c: mov      w1, w26
0038e810: bl       #0x50ff00
0038e814: mov      x0, x21
0038e818: bl       #0x50f330
0038e81c: ldurb    w8, [x29, #-0xa0]
0038e820: tbz      w8, #0, #0x38e954
0038e824: ldur     x0, [x29, #-0x90]
0038e828: bl       #0x54e070
0038e82c: b        #0x38e954
0038e830: ldrb     w8, [sp, #0xd8]
0038e834: cmp      w8, #1
0038e838: b.ne     #0x38e954
0038e83c: ldr      x21, [sp, #0xe0]
0038e840: ldr      x20, [x21, #8]!
0038e844: cbz      x20, #0x38e898
0038e848: mov      x23, x21
0038e84c: adrp     x26, #0x21000
0038e850: add      x26, x26, #0x3de
0038e854: add      x0, x20, #0x20
0038e858: mov      x1, x26
0038e85c: bl       #0x50c188
0038e860: add      x8, x20, #8
0038e864: cmp      w0, #0
0038e868: csel     x8, x8, x20, lt
0038e86c: csel     x23, x23, x20, lt
0038e870: ldr      x20, [x8]
0038e874: cbnz     x20, #0x38e854
0038e878: cmp      x23, x21
0038e87c: b.eq     #0x38e898
0038e880: add      x0, x23, #0x20
0038e884: adrp     x1, #0x21000
0038e888: add      x1, x1, #0x3de
0038e88c: bl       #0x50c188
0038e890: cmp      w0, #0
0038e894: csel     x21, x21, x23, gt
0038e898: ldr      x8, [sp, #0xe0]
0038e89c: add      x20, sp, #0xe8
0038e8a0: add      x8, x8, #8
0038e8a4: cmp      x21, x8
0038e8a8: b.eq     #0x38e95c
0038e8ac: adrp     x0, #0x562000
0038e8b0: adrp     x1, #0x23000
0038e8b4: add      x1, x1, #0x86e
0038e8b8: ldr      x0, [x0, #0xec0]
0038e8bc: mov      w2, #0x13
0038e8c0: bl       #0x3a07c0
0038e8c4: mov      x21, x0
0038e8c8: add      x0, sp, #0xd8
0038e8cc: adrp     x1, #0x21000
0038e8d0: add      x1, x1, #0x3de
0038e8d4: mov      x23, x25
0038e8d8: bl       #0x39160c
0038e8dc: str      xzr, [sp, #0x90]
0038e8e0: add      x2, sp, #0x90
0038e8e4: adrp     x1, #0x23000
0038e8e8: add      x1, x1, #0x882
0038e8ec: bl       #0x3919f8
0038e8f0: mov      x1, x0
0038e8f4: mov      x0, x21
0038e8f8: bl       #0x50fa48
0038e8fc: ldr      x8, [x0]
0038e900: mov      x21, x0
0038e904: ldur     x9, [x8, #-0x18]
0038e908: sub      x8, x29, #0xa0
0038e90c: add      x0, x0, x9
0038e910: bl       #0x50eb5c
0038e914: adrp     x1, #0x562000
0038e918: sub      x0, x29, #0xa0
0038e91c: ldr      x1, [x1, #0xe98]
0038e920: bl       #0x52d1b4
0038e924: ldr      x8, [x0]
0038e928: ldr      x8, [x8, #0x38]
0038e92c: mov      w1, #0xa
0038e930: blr      x8
0038e934: mov      w26, w0
0038e938: sub      x0, x29, #0xa0
0038e93c: bl       #0x52d0b4
0038e940: mov      x0, x21
0038e944: mov      w1, w26
0038e948: bl       #0x50ff00
0038e94c: mov      x0, x21
0038e950: bl       #0x50f330
0038e954: mov      w21, #1
0038e958: b        #0x38e208
0038e95c: mov      w21, #1
0038e960: mov      x23, x25
0038e964: b        #0x38e208
0038e968: ldrb     w8, [sp, #0x1e0]
0038e96c: tbnz     w8, #0, #0x38ea94
0038e970: ldrb     w8, [sp, #0x1c8]
0038e974: tbnz     w8, #0, #0x38eaa4
0038e978: ldrb     w8, [sp, #0x1a8]
0038e97c: tbnz     w8, #0, #0x38eab4
0038e980: ldrb     w8, [sp, #0x190]
0038e984: tbnz     w8, #0, #0x38eac4
0038e988: ldrb     w8, [sp, #0x178]
0038e98c: tbnz     w8, #0, #0x38ead4
0038e990: ldrb     w8, [sp, #0x160]
0038e994: tbnz     w8, #0, #0x38eae4
0038e998: ldurb    w8, [x29, #-0xb8]
0038e99c: tbz      w8, #0, #0x38e9a8
0038e9a0: ldur     x0, [x29, #-0xa8]
0038e9a4: bl       #0x54e070
0038e9a8: adrp     x0, #0x27000
0038e9ac: add      x0, x0, #0x17b
0038e9b0: bl       #0x553f60 ; puts
0038e9b4: adrp     x8, #0x562000
0038e9b8: ldr      x8, [x8, #0xec8]
0038e9bc: ldr      x0, [x8]
0038e9c0: bl       #0x5540e0 ; fflush
0038e9c4: bl       #0x554110 ; fork
0038e9c8: tbnz     w0, #0x1f, #0x38eaf8
0038e9cc: mov      w1, w0
0038e9d0: cbnz     w0, #0x38ed78
0038e9d4: bl       #0x554120 ; setsid
0038e9d8: tbnz     w0, #0x1f, #0x38eb04
0038e9dc: adrp     x0, #0x2b000
0038e9e0: add      x0, x0, #0xb82
0038e9e4: mov      w1, #2
0038e9e8: bl       #0x554130 ; __open_2
0038e9ec: tbnz     w0, #0x1f, #0x38eb04
0038e9f0: mov      w1, wzr
0038e9f4: mov      w19, w0
0038e9f8: bl       #0x554140 ; dup2
0038e9fc: tbnz     w0, #0x1f, #0x38eb3c
0038ea00: mov      w0, w19
0038ea04: mov      w1, #1
0038ea08: bl       #0x554140 ; dup2
0038ea0c: tbnz     w0, #0x1f, #0x38eb3c
0038ea10: mov      w0, w19
0038ea14: mov      w1, #2
0038ea18: bl       #0x554140 ; dup2
0038ea1c: tbnz     w0, #0x1f, #0x38eb3c
0038ea20: cmp      w19, #3
0038ea24: b.lo     #0x38ea30
0038ea28: mov      w0, w19
0038ea2c: bl       #0x554080 ; close
0038ea30: bl       #0x446404
0038ea34: tbz      w0, #0, #0x38eb04
0038ea38: bl       #0x41e96c
0038ea3c: bl       #0x41e958
0038ea40: adrp     x23, #0x593000
0038ea44: tbz      w0, #0, #0x38ece4
0038ea48: adrp     x26, #0x562000
0038ea4c: mov      w28, #0xca00
0038ea50: mov      x25, xzr
0038ea54: ldr      x26, [x26, #0xed8]
0038ea58: mov      x24, xzr
0038ea5c: mov      w27, #0xf0
0038ea60: movk     w28, #0x3b9a, lsl #16
0038ea64: adrp     x19, #0x593000
0038ea68: add      x19, x19, #0x748
0038ea6c: b        #0x38eb74
0038ea70: ldr      x0, [sp, #0x128]
0038ea74: bl       #0x54e070
0038ea78: ldrb     w8, [sp, #0x130]
0038ea7c: tbz      w8, #0, #0x38dd7c
0038ea80: ldr      x0, [sp, #0x140]
0038ea84: bl       #0x54e070
0038ea88: ldrb     w8, [sp, #0x148]
0038ea8c: tbnz     w8, #0, #0x38dd84
0038ea90: b        #0x38dd8c
0038ea94: ldr      x0, [sp, #0x1f0]
0038ea98: bl       #0x54e070
0038ea9c: ldrb     w8, [sp, #0x1c8]
0038eaa0: tbz      w8, #0, #0x38e978
0038eaa4: ldr      x0, [sp, #0x1d8]
0038eaa8: bl       #0x54e070
0038eaac: ldrb     w8, [sp, #0x1a8]
0038eab0: tbz      w8, #0, #0x38e980
0038eab4: ldr      x0, [sp, #0x1b8]
0038eab8: bl       #0x54e070
0038eabc: ldrb     w8, [sp, #0x190]
0038eac0: tbz      w8, #0, #0x38e988
0038eac4: ldr      x0, [sp, #0x1a0]
0038eac8: bl       #0x54e070
0038eacc: ldrb     w8, [sp, #0x178]
0038ead0: tbz      w8, #0, #0x38e990
0038ead4: ldr      x0, [sp, #0x188]
0038ead8: bl       #0x54e070
0038eadc: ldrb     w8, [sp, #0x160]
0038eae0: tbz      w8, #0, #0x38e998
0038eae4: ldr      x0, [sp, #0x170]
0038eae8: bl       #0x54e070
0038eaec: ldurb    w8, [x29, #-0xb8]
0038eaf0: tbnz     w8, #0, #0x38e9a0
0038eaf4: b        #0x38e9a8
0038eaf8: adrp     x0, #0x2b000
0038eafc: add      x0, x0, #0x6cd
0038eb00: bl       #0x553f60 ; puts
0038eb04: mov      w0, #1
0038eb08: ldr      x8, [sp, #0x28]
0038eb0c: ldr      x8, [x8, #0x28]
0038eb10: ldur     x9, [x29, #-0x18]
0038eb14: cmp      x8, x9
0038eb18: b.ne     #0x38ef14
0038eb1c: add      sp, sp, #0x2b0
0038eb20: ldp      x20, x19, [sp, #0x50]
0038eb24: ldp      x22, x21, [sp, #0x40]
0038eb28: ldp      x24, x23, [sp, #0x30]
0038eb2c: ldp      x26, x25, [sp, #0x20]
0038eb30: ldp      x28, x27, [sp, #0x10]
0038eb34: ldp      x29, x30, [sp], #0x60
0038eb38: ret      
0038eb3c: cmp      w19, #3
0038eb40: b.lo     #0x38eb04
0038eb44: mov      w0, w19
0038eb48: bl       #0x554080 ; close
0038eb4c: b        #0x38eb04
0038eb50: mov      w5, wzr
0038eb54: ldr      w4, [x0, #0xc]
0038eb58: mov      x0, x19
0038eb5c: mov      x1, x20
0038eb60: mov      x2, x21
0038eb64: mov      x3, x22
0038eb68: bl       #0x38efe0
0038eb6c: bl       #0x41e958
0038eb70: tbz      w0, #0, #0x38ece4
0038eb74: mov      x22, x25
0038eb78: bl       #0x41f0dc
0038eb7c: ldr      x8, [x23, #0xbb0]
0038eb80: cbz      x8, #0x38eb9c
0038eb84: ldrb     w8, [x8, #0x38]
0038eb88: cbz      w8, #0x38eb9c
0038eb8c: adrp     x8, #0x562000
0038eb90: ldr      x8, [x8, #0xee0]
0038eb94: ldr      w21, [x8]
0038eb98: b        #0x38ebb0
0038eb9c: bl       #0x41f124
0038eba0: tst      w0, #1
0038eba4: mov      w8, #0xa
0038eba8: mov      w9, #0x1e
0038ebac: csel     w21, w9, w8, ne
0038ebb0: bl       #0x50aaf8
0038ebb4: cmp      w21, #0xf0
0038ebb8: mov      x20, x0
0038ebbc: csel     w8, w21, w27, lo
0038ebc0: cmp      w21, #1
0038ebc4: csinc    w8, w8, wzr, ge
0038ebc8: udiv     w25, w28, w8
0038ebcc: cmp      x22, x25
0038ebd0: ccmp     x24, #0, #4, eq
0038ebd4: b.eq     #0x38ebfc
0038ebd8: cmp      x20, x24
0038ebdc: b.ge     #0x38ebf4
0038ebe0: bl       #0x50aaf8
0038ebe4: sub      x8, x24, x0
0038ebe8: add      x0, sp, #0x160
0038ebec: str      x8, [sp, #0x160]
0038ebf0: bl       #0x50e5d0
0038ebf4: mov      x20, x24
0038ebf8: mov      x25, x22
0038ebfc: bl       #0x50aaf8
0038ec00: add      x8, x25, x20
0038ec04: add      x9, x0, x25
0038ec08: cmp      x0, x8
0038ec0c: csel     x24, x8, x9, lt
0038ec10: bl       #0x50aaf8
0038ec14: mov      x20, x0
0038ec18: bl       #0x4468d0
0038ec1c: tbz      w0, #0, #0x38ece4
0038ec20: ldr      x0, [x26]
0038ec24: mov      w1, w21
0038ec28: bl       #0x3b2aec
0038ec2c: ldr      x0, [x26]
0038ec30: mov      w1, wzr
0038ec34: bl       #0x3b2abc
0038ec38: mov      x0, xzr
0038ec3c: bl       #0x447db0
0038ec40: bl       #0x50aaf8
0038ec44: ldr      x8, [x26]
0038ec48: mov      x21, x0
0038ec4c: mov      x0, x8
0038ec50: bl       #0x3b2bc8
0038ec54: bl       #0x50aaf8
0038ec58: mov      x22, x0
0038ec5c: bl       #0x3bb6c0
0038ec60: ldr      w8, [x0, #4]
0038ec64: cmp      w8, #1
0038ec68: b.lt     #0x38eb50
0038ec6c: ldr      x9, [x0, #0x18]
0038ec70: cmp      w8, #1
0038ec74: b.ne     #0x38ec84
0038ec78: mov      x10, xzr
0038ec7c: mov      w5, wzr
0038ec80: b        #0x38ecc4
0038ec84: and      x10, x8, #0x7ffffffe
0038ec88: mov      w11, wzr
0038ec8c: mov      w12, wzr
0038ec90: add      x13, x9, #8
0038ec94: mov      x14, x10
0038ec98: ldp      x15, x16, [x13, #-8]
0038ec9c: subs     x14, x14, #2
0038eca0: add      x13, x13, #0x10
0038eca4: ldr      w15, [x15]
0038eca8: ldr      w16, [x16]
0038ecac: add      w11, w15, w11
0038ecb0: add      w12, w16, w12
0038ecb4: b.ne     #0x38ec98
0038ecb8: cmp      x10, x8
0038ecbc: add      w5, w12, w11
0038ecc0: b.eq     #0x38eb54
0038ecc4: add      x9, x9, x10, lsl #3
0038ecc8: sub      x8, x8, x10
0038eccc: ldr      x10, [x9], #8
0038ecd0: subs     x8, x8, #1
0038ecd4: ldr      w10, [x10]
0038ecd8: add      w5, w10, w5
0038ecdc: b.ne     #0x38eccc
0038ece0: b        #0x38eb54
0038ece4: bl       #0x41f094
0038ece8: ldr      x19, [x23, #0xbb0]
0038ecec: cbz      x19, #0x38ed68
0038ecf0: add      x8, x19, #0x39
0038ecf4: add      x0, x19, #0x70
0038ecf8: stlrb    wzr, [x8]
0038ecfc: bl       #0x50e3a4
0038ed00: mov      x0, x19
0038ed04: ldr      x8, [x0, #0x40]!
0038ed08: cbz      x8, #0x38ed10
0038ed0c: bl       #0x50e53c
0038ed10: ldrb     w8, [x19, #0x38]
0038ed14: cbz      w8, #0x38ed4c
0038ed18: ldr      x20, [x19, #0x10]
0038ed1c: ldr      x8, [x19, #8]
0038ed20: cmp      x20, x8
0038ed24: b.eq     #0x38ed3c
0038ed28: ldr      x0, [x20, #-8]!
0038ed2c: ldr      x8, [x0]
0038ed30: ldr      x8, [x8, #0x18]
0038ed34: blr      x8
0038ed38: b        #0x38ed1c
0038ed3c: ldr      x8, [x19]
0038ed40: mov      x0, x19
0038ed44: ldr      x8, [x8, #0x28]
0038ed48: blr      x8
0038ed4c: ldr      x0, [x19, #0x30]
0038ed50: strb     wzr, [x19, #0x38]
0038ed54: cbz      x0, #0x38ed64
0038ed58: ldr      x8, [x0]
0038ed5c: ldr      x8, [x8, #8]
0038ed60: blr      x8
0038ed64: str      xzr, [x19, #0x30]
0038ed68: str      xzr, [x23, #0xbb0]
0038ed6c: bl       #0x446804
0038ed70: mov      w0, wzr
0038ed74: b        #0x38eb08
0038ed78: adrp     x0, #0x28000
0038ed7c: add      x0, x0, #0xe95
0038ed80: bl       #0x553fa0 ; printf
0038ed84: adrp     x8, #0x562000
0038ed88: ldr      x8, [x8, #0xec8]
0038ed8c: ldr      x0, [x8]
0038ed90: bl       #0x5540e0 ; fflush
0038ed94: ldr      x8, [sp, #0x28]
0038ed98: ldr      x8, [x8, #0x28]
0038ed9c: ldur     x9, [x29, #-0x18]
0038eda0: cmp      x8, x9
0038eda4: b.ne     #0x38ef14
0038eda8: mov      w0, wzr
0038edac: bl       #0x554150 ; _exit
0038edb0: b        #0x38efb0
0038edb4: mov      x19, x0
0038edb8: add      x0, sp, #0x90
0038edbc: bl       #0x52d0b4
0038edc0: b        #0x38edcc
0038edc4: b        #0x38efb0
0038edc8: mov      x19, x0
0038edcc: ldurb    w8, [x29, #-0xa0]
0038edd0: tbz      w8, #0, #0x38efb4
0038edd4: ldur     x0, [x29, #-0x90]
0038edd8: bl       #0x54e070
0038eddc: b        #0x38efb4
0038ede0: b        #0x38ef98
0038ede4: b        #0x38efb0
0038ede8: b        #0x38efb0
0038edec: mov      x19, x0
0038edf0: ldrb     w8, [sp, #0x70]
0038edf4: tbz      w8, #0, #0x38ee2c
0038edf8: b        #0x38ee88
0038edfc: bl       #0x3860c0
0038ee00: mov      x19, x0
0038ee04: add      x0, sp, #0xb0
0038ee08: bl       #0x398248
0038ee0c: ldurb    w8, [x29, #-0xa0]
0038ee10: tbnz     w8, #0, #0x38ee38
0038ee14: ldrb     w8, [sp, #0x90]
0038ee18: tbnz     w8, #0, #0x38ee58
0038ee1c: ldrb     w8, [sp, #0x40]
0038ee20: tbnz     w8, #0, #0x38ee78
0038ee24: ldrb     w8, [sp, #0x70]
0038ee28: tbnz     w8, #0, #0x38ee88
0038ee2c: ldrb     w8, [sp, #0x58]
0038ee30: tbnz     w8, #0, #0x38eea8
0038ee34: b        #0x38efb4
0038ee38: ldur     x0, [x29, #-0x90]
0038ee3c: bl       #0x54e070
0038ee40: ldrb     w8, [sp, #0x90]
0038ee44: tbz      w8, #0, #0x38ee1c
0038ee48: b        #0x38ee58
0038ee4c: mov      x19, x0
0038ee50: ldrb     w8, [sp, #0x90]
0038ee54: tbz      w8, #0, #0x38ee1c
0038ee58: ldr      x0, [sp, #0xa0]
0038ee5c: bl       #0x54e070
0038ee60: ldrb     w8, [sp, #0x40]
0038ee64: tbz      w8, #0, #0x38ee24
0038ee68: b        #0x38ee78
0038ee6c: mov      x19, x0
0038ee70: ldrb     w8, [sp, #0x40]
0038ee74: tbz      w8, #0, #0x38ee24
0038ee78: ldr      x0, [sp, #0x50]
0038ee7c: bl       #0x54e070
0038ee80: ldrb     w8, [sp, #0x70]
0038ee84: tbz      w8, #0, #0x38ee2c
0038ee88: ldr      x0, [sp, #0x80]
0038ee8c: bl       #0x54e070
0038ee90: ldrb     w8, [sp, #0x58]
0038ee94: tbnz     w8, #0, #0x38eea8
0038ee98: b        #0x38efb4
0038ee9c: mov      x19, x0
0038eea0: ldrb     w8, [sp, #0x58]
0038eea4: tbz      w8, #0, #0x38efb4
0038eea8: ldr      x0, [sp, #0x68]
0038eeac: bl       #0x54e070
0038eeb0: b        #0x38efb4
0038eeb4: b        #0x38efb0
0038eeb8: ldrb     w8, [sp, #0x100]
0038eebc: mov      x19, x0
0038eec0: tbz      w8, #0, #0x38efcc
0038eec4: ldr      x0, [sp, #0x110]
0038eec8: b        #0x38efc8
0038eecc: ldrb     w8, [sp, #0x118]
0038eed0: mov      x19, x0
0038eed4: tbnz     w8, #0, #0x38ef18
0038eed8: ldrb     w8, [sp, #0x130]
0038eedc: tbnz     w8, #0, #0x38ef28
0038eee0: ldrb     w8, [sp, #0x148]
0038eee4: tbnz     w8, #0, #0x38ef38
0038eee8: ldurb    w8, [x29, #-0xb8]
0038eeec: tbz      w8, #0, #0x38eef8
0038eef0: ldur     x0, [x29, #-0xa8]
0038eef4: bl       #0x54e070
0038eef8: ldr      x8, [sp, #0x28]
0038eefc: ldr      x8, [x8, #0x28]
0038ef00: ldur     x9, [x29, #-0x18]
0038ef04: cmp      x8, x9
0038ef08: b.ne     #0x38ef14
0038ef0c: mov      x0, x19
0038ef10: bl       #0x54fffc
0038ef14: bl       #0x553f00 ; __stack_chk_fail
0038ef18: ldr      x0, [sp, #0x128]
0038ef1c: bl       #0x54e070
0038ef20: ldrb     w8, [sp, #0x130]
0038ef24: tbz      w8, #0, #0x38eee0
0038ef28: ldr      x0, [sp, #0x140]
0038ef2c: bl       #0x54e070
0038ef30: ldrb     w8, [sp, #0x148]
0038ef34: tbz      w8, #0, #0x38eee8
0038ef38: ldr      x0, [sp, #0x158]
0038ef3c: bl       #0x54e070
0038ef40: ldurb    w8, [x29, #-0xb8]
0038ef44: tbnz     w8, #0, #0x38eef0
0038ef48: b        #0x38eef8
0038ef4c: b        #0x38ef98
0038ef50: b        #0x38ef98
0038ef54: b        #0x38efb0
0038ef58: bl       #0x3860c0
0038ef5c: b        #0x38ef6c
0038ef60: b        #0x38efa8
0038ef64: b        #0x38efb0
0038ef68: b        #0x38efa8
0038ef6c: mov      x19, x0
0038ef70: sub      x0, x29, #0xa0
0038ef74: bl       #0x52d0b4
0038ef78: b        #0x38efbc
0038ef7c: ldrb     w8, [sp, #0xc0]
0038ef80: mov      x19, x0
0038ef84: tbz      w8, #0, #0x38efbc
0038ef88: ldr      x0, [sp, #0xd0]
0038ef8c: bl       #0x54e070
0038ef90: b        #0x38efbc
0038ef94: bl       #0x3860c0
0038ef98: mov      x19, x0
0038ef9c: sub      x0, x29, #0xa0
0038efa0: bl       #0x52d0b4
0038efa4: b        #0x38efb4
0038efa8: mov      x19, x0
0038efac: b        #0x38efbc
0038efb0: mov      x19, x0
0038efb4: add      x0, sp, #0xd8
0038efb8: bl       #0x391938
0038efbc: ldrb     w8, [sp, #0xe8]
0038efc0: tbz      w8, #0, #0x38efcc
0038efc4: ldr      x0, [sp, #0xf8]
0038efc8: bl       #0x54e070
0038efcc: add      x0, sp, #0x160
0038efd0: bl       #0x391bfc
0038efd4: ldurb    w8, [x29, #-0xb8]
0038efd8: tbnz     w8, #0, #0x38eef0
0038efdc: b        #0x38eef8
