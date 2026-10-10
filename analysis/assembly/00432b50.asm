00432b50: sub      sp, sp, #0x1a0
00432b54: stp      x29, x30, [sp, #0x140]
00432b58: str      x28, [sp, #0x150]
00432b5c: stp      x26, x25, [sp, #0x160]
00432b60: stp      x24, x23, [sp, #0x170]
00432b64: stp      x22, x21, [sp, #0x180]
00432b68: stp      x20, x19, [sp, #0x190]
00432b6c: add      x29, sp, #0x140
00432b70: mrs      x25, tpidr_el0
00432b74: mov      x20, x0
00432b78: mov      x19, x2
00432b7c: ldr      x8, [x25, #0x28]
00432b80: mov      x23, x1
00432b84: stur     x8, [x29, #-8]
00432b88: ldr      x21, [x0]
00432b8c: mov      x0, x1
00432b90: bl       #0x553f20
00432b94: cmn      x0, #0x10
00432b98: b.hs     #0x432dcc
00432b9c: mov      x22, x0
00432ba0: cmp      x0, #0x17
00432ba4: b.hs     #0x432bc0
00432ba8: lsl      w8, w22, #1
00432bac: add      x9, sp, #8
00432bb0: orr      x24, x9, #1
00432bb4: strb     w8, [sp, #8]
00432bb8: cbnz     x22, #0x432bdc
00432bbc: b        #0x432bec
00432bc0: orr      x26, x22, #0xf
00432bc4: add      x0, x26, #1
00432bc8: bl       #0x54dfc0
00432bcc: add      x8, x26, #2
00432bd0: mov      x24, x0
00432bd4: stp      x22, x0, [sp, #0x10]
00432bd8: str      x8, [sp, #8]
00432bdc: mov      x0, x24
00432be0: mov      x1, x23
00432be4: mov      x2, x22
00432be8: bl       #0x553fb0
00432bec: strb     wzr, [x24, x22]
00432bf0: add      x1, sp, #8
00432bf4: mov      x0, x21
00432bf8: bl       #0x432e24
00432bfc: ldrb     w8, [sp, #8]
00432c00: mov      x21, x0
00432c04: tbz      w8, #0, #0x432c10
00432c08: ldr      x0, [sp, #0x18]
00432c0c: bl       #0x54e070
00432c10: ldr      x8, [x20]
00432c14: add      x8, x8, #8
00432c18: cmp      x8, x21
00432c1c: b.eq     #0x432d9c
00432c20: add      x0, sp, #8
00432c24: add      x1, x21, #0x38
00432c28: mov      w2, #0x18
00432c2c: sub      x20, x29, #0x20
00432c30: bl       #0x432f20
00432c34: strb     wzr, [sp, #4]
00432c38: stp      xzr, xzr, [x20]
00432c3c: add      x0, sp, #8
00432c40: sub      x1, x29, #0x20
00432c44: bl       #0x50f428
00432c48: add      x1, sp, #4
00432c4c: bl       #0x433088
00432c50: ldr      x8, [x0]
00432c54: mov      w9, #5
00432c58: ldur     x8, [x8, #-0x18]
00432c5c: add      x8, x0, x8
00432c60: ldrb     w8, [x8, #0x20]
00432c64: tst      w8, w9
00432c68: b.ne     #0x432d40
00432c6c: ldrb     w8, [sp, #4]
00432c70: cmp      w8, #0x2c
00432c74: b.ne     #0x432d40
00432c78: sub      x8, x29, #0x20
00432c7c: add      x0, sp, #8
00432c80: orr      x1, x8, #4
00432c84: bl       #0x50f428
00432c88: add      x1, sp, #4
00432c8c: bl       #0x433088
00432c90: ldr      x8, [x0]
00432c94: mov      w9, #5
00432c98: ldur     x8, [x8, #-0x18]
00432c9c: add      x8, x0, x8
00432ca0: ldrb     w8, [x8, #0x20]
00432ca4: tst      w8, w9
00432ca8: b.ne     #0x432d40
00432cac: ldrb     w8, [sp, #4]
00432cb0: cmp      w8, #0x2c
00432cb4: b.ne     #0x432d40
00432cb8: sub      x8, x29, #0x20
00432cbc: add      x0, sp, #8
00432cc0: orr      x1, x8, #8
00432cc4: bl       #0x50f428
00432cc8: add      x1, sp, #4
00432ccc: bl       #0x433088
00432cd0: ldr      x8, [x0]
00432cd4: mov      w9, #5
00432cd8: ldur     x8, [x8, #-0x18]
00432cdc: add      x8, x0, x8
00432ce0: ldrb     w8, [x8, #0x20]
00432ce4: tst      w8, w9
00432ce8: b.ne     #0x432d40
00432cec: ldrb     w8, [sp, #4]
00432cf0: cmp      w8, #0x2c
00432cf4: b.ne     #0x432d40
00432cf8: sub      x8, x29, #0x20
00432cfc: add      x0, sp, #8
00432d00: orr      x1, x8, #0xc
00432d04: bl       #0x50f428
00432d08: ldr      x8, [x0]
00432d0c: mov      w9, #5
00432d10: ldur     x8, [x8, #-0x18]
00432d14: add      x8, x0, x8
00432d18: ldrb     w8, [x8, #0x20]
00432d1c: tst      w8, w9
00432d20: b.ne     #0x432d40
00432d24: fmov     v0.4s, #1.00000000
00432d28: ldr      q1, [x20]
00432d2c: fcmlt    v3.4s, v1.4s, #0.0
00432d30: fcmgt    v2.4s, v1.4s, v0.4s
00432d34: bif      v0.16b, v1.16b, v2.16b
00432d38: bic      v0.16b, v0.16b, v3.16b
00432d3c: str      q0, [x19]
00432d40: adrp     x19, #0x562000
00432d44: add      x20, sp, #8
00432d48: ldr      x19, [x19, #0xe80]
00432d4c: ldr      x8, [x19]
00432d50: ldp      x9, x10, [x19, #0x40]
00432d54: str      x8, [sp, #8]
00432d58: ldur     x8, [x8, #-0x18]
00432d5c: str      x9, [x20, x8]
00432d60: adrp     x8, #0x55e000
00432d64: add      x8, x8, #0x130
00432d68: ldrb     w9, [sp, #0x60]
00432d6c: add      x8, x8, #0x10
00432d70: stp      x10, x8, [sp, #0x18]
00432d74: tbz      w9, #0, #0x432d80
00432d78: ldr      x0, [sp, #0x70]
00432d7c: bl       #0x54e070
00432d80: add      x0, x20, #0x18
00432d84: bl       #0x50eddc
00432d88: add      x0, sp, #8
00432d8c: add      x1, x19, #8
00432d90: bl       #0x51000c
00432d94: add      x0, x20, #0x80
00432d98: bl       #0x50eda8
00432d9c: ldr      x8, [x25, #0x28]
00432da0: ldur     x9, [x29, #-8]
00432da4: cmp      x8, x9
00432da8: b.ne     #0x432e20
00432dac: ldp      x20, x19, [sp, #0x190]
00432db0: ldr      x28, [sp, #0x150]
00432db4: ldp      x22, x21, [sp, #0x180]
00432db8: ldp      x24, x23, [sp, #0x170]
00432dbc: ldp      x26, x25, [sp, #0x160]
00432dc0: ldp      x29, x30, [sp, #0x140]
00432dc4: add      sp, sp, #0x1a0
00432dc8: ret      
00432dcc: ldr      x8, [x25, #0x28]
00432dd0: ldur     x9, [x29, #-8]
00432dd4: cmp      x8, x9
00432dd8: b.ne     #0x432e20
00432ddc: add      x0, sp, #8
00432de0: bl       #0x39e640
00432de4: ldrb     w8, [sp, #8]
00432de8: mov      x19, x0
00432dec: tbz      w8, #0, #0x432e08
00432df0: ldr      x0, [sp, #0x18]
00432df4: bl       #0x54e070
00432df8: b        #0x432e08
00432dfc: mov      x19, x0
00432e00: add      x0, sp, #8
00432e04: bl       #0x386704
00432e08: ldr      x8, [x25, #0x28]
00432e0c: ldur     x9, [x29, #-8]
00432e10: cmp      x8, x9
00432e14: b.ne     #0x432e20
00432e18: mov      x0, x19
00432e1c: bl       #0x54fffc
00432e20: bl       #0x553f00
