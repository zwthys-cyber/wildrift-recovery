004329d4: sub      sp, sp, #0x80
004329d8: stp      d9, d8, [sp, #0x20]
004329dc: stp      x29, x30, [sp, #0x30]
004329e0: stp      x26, x25, [sp, #0x40]
004329e4: stp      x24, x23, [sp, #0x50]
004329e8: stp      x22, x21, [sp, #0x60]
004329ec: stp      x20, x19, [sp, #0x70]
004329f0: add      x29, sp, #0x30
004329f4: mrs      x25, tpidr_el0
004329f8: mov      x20, x0
004329fc: fmov     s9, s1
00432a00: ldr      x8, [x25, #0x28]
00432a04: fmov     s8, s0
00432a08: mov      x19, x2
00432a0c: mov      x23, x1
00432a10: str      x8, [sp, #0x18]
00432a14: ldr      x21, [x0]
00432a18: mov      x0, x1
00432a1c: bl       #0x553f20
00432a20: cmn      x0, #0x10
00432a24: b.hs     #0x432afc
00432a28: mov      x22, x0
00432a2c: cmp      x0, #0x17
00432a30: b.hs     #0x432a4c
00432a34: lsl      w8, w22, #1
00432a38: mov      x9, sp
00432a3c: orr      x24, x9, #1
00432a40: strb     w8, [sp]
00432a44: cbnz     x22, #0x432a68
00432a48: b        #0x432a78
00432a4c: orr      x26, x22, #0xf
00432a50: add      x0, x26, #1
00432a54: bl       #0x54dfc0
00432a58: add      x8, x26, #2
00432a5c: mov      x24, x0
00432a60: stp      x22, x0, [sp, #8]
00432a64: str      x8, [sp]
00432a68: mov      x0, x24
00432a6c: mov      x1, x23
00432a70: mov      x2, x22
00432a74: bl       #0x553fb0
00432a78: strb     wzr, [x24, x22]
00432a7c: mov      x1, sp
00432a80: mov      x0, x21
00432a84: bl       #0x432e24
00432a88: ldrb     w8, [sp]
00432a8c: mov      x21, x0
00432a90: tbz      w8, #0, #0x432a9c
00432a94: ldr      x0, [sp, #0x10]
00432a98: bl       #0x54e070
00432a9c: ldr      x8, [x20]
00432aa0: add      x8, x8, #8
00432aa4: cmp      x8, x21
00432aa8: b.eq     #0x432acc
00432aac: add      x0, x21, #0x38
00432ab0: mov      x1, xzr
00432ab4: bl       #0x50cc68
00432ab8: fcmp     s0, s9
00432abc: fcsel    s1, s9, s0, gt
00432ac0: fcmp     s0, s8
00432ac4: fcsel    s0, s8, s1, mi
00432ac8: str      s0, [x19]
00432acc: ldr      x8, [x25, #0x28]
00432ad0: ldr      x9, [sp, #0x18]
00432ad4: cmp      x8, x9
00432ad8: b.ne     #0x432b4c
00432adc: ldp      x20, x19, [sp, #0x70]
00432ae0: ldp      x22, x21, [sp, #0x60]
00432ae4: ldp      x24, x23, [sp, #0x50]
00432ae8: ldp      x26, x25, [sp, #0x40]
00432aec: ldp      x29, x30, [sp, #0x30]
00432af0: ldp      d9, d8, [sp, #0x20]
00432af4: add      sp, sp, #0x80
00432af8: ret      
00432afc: ldr      x8, [x25, #0x28]
00432b00: ldr      x9, [sp, #0x18]
00432b04: cmp      x8, x9
00432b08: b.ne     #0x432b4c
00432b0c: mov      x0, sp
00432b10: bl       #0x39e640
00432b14: bl       #0x54e108
00432b18: bl       #0x54e2e8
00432b1c: b        #0x432acc
00432b20: ldrb     w8, [sp]
00432b24: mov      x19, x0
00432b28: tbz      w8, #0, #0x432b34
00432b2c: ldr      x0, [sp, #0x10]
00432b30: bl       #0x54e070
00432b34: ldr      x8, [x25, #0x28]
00432b38: ldr      x9, [sp, #0x18]
00432b3c: cmp      x8, x9
00432b40: b.ne     #0x432b4c
00432b44: mov      x0, x19
00432b48: bl       #0x54fffc
00432b4c: bl       #0x553f00
