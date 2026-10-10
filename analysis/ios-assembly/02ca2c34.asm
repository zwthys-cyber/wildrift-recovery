02ca2c34: sub      sp, sp, #0x70
02ca2c38: stp      x24, x23, [sp, #0x40]
02ca2c3c: stp      x22, x21, [sp, #0x50]
02ca2c40: stp      x20, x19, [sp, #0x60]
02ca2c44: ldp      q0, q1, [x1]
02ca2c48: stp      q0, q1, [sp]
02ca2c4c: ldp      q1, q0, [x1, #0x20]
02ca2c50: stp      q1, q0, [sp, #0x20]
02ca2c54: ldp      w10, w11, [sp]
02ca2c58: ldp      w19, w13, [sp, #0x10]
02ca2c5c: ldp      w3, w4, [sp, #0x30]
02ca2c60: ldp      w6, w7, [sp, #0x20]
02ca2c64: ldp      w17, w2, [sp, #8]
02ca2c68: ldp      w15, w16, [sp, #0x18]
02ca2c6c: ldp      w5, w9, [sp, #0x38]
02ca2c70: mov      w8, #0x16
02ca2c74: ldp      w12, w14, [sp, #0x28]
02ca2c78: add      w10, w19, w10
02ca2c7c: eor      w3, w3, w10
02ca2c80: ror      w20, w3, #0x10
02ca2c84: add      w6, w6, w20
02ca2c88: eor      w19, w6, w19
02ca2c8c: ror      w20, w19, #0x14
02ca2c90: add      w10, w20, w10
02ca2c94: eor      w3, w10, w3, ror #16
02ca2c98: ror      w20, w3, #0x18
02ca2c9c: add      w6, w20, w6
02ca2ca0: eor      w19, w6, w19, ror #20
02ca2ca4: ror      w20, w19, #0x19
02ca2ca8: add      w11, w13, w11
02ca2cac: eor      w4, w4, w11
02ca2cb0: ror      w21, w4, #0x10
02ca2cb4: add      w7, w7, w21
02ca2cb8: eor      w13, w7, w13
02ca2cbc: ror      w21, w13, #0x14
02ca2cc0: add      w11, w21, w11
02ca2cc4: eor      w4, w11, w4, ror #16
02ca2cc8: ror      w21, w4, #0x18
02ca2ccc: add      w7, w21, w7
02ca2cd0: eor      w13, w7, w13, ror #20
02ca2cd4: ror      w21, w13, #0x19
02ca2cd8: add      w17, w15, w17
02ca2cdc: eor      w5, w5, w17
02ca2ce0: ror      w22, w5, #0x10
02ca2ce4: add      w12, w12, w22
02ca2ce8: eor      w15, w12, w15
02ca2cec: ror      w22, w15, #0x14
02ca2cf0: add      w17, w22, w17
02ca2cf4: eor      w5, w17, w5, ror #16
02ca2cf8: ror      w22, w5, #0x18
02ca2cfc: add      w12, w22, w12
02ca2d00: eor      w15, w12, w15, ror #20
02ca2d04: ror      w22, w15, #0x19
02ca2d08: add      w2, w16, w2
02ca2d0c: eor      w9, w9, w2
02ca2d10: ror      w23, w9, #0x10
02ca2d14: add      w14, w14, w23
02ca2d18: eor      w16, w14, w16
02ca2d1c: ror      w23, w16, #0x14
02ca2d20: add      w2, w23, w2
02ca2d24: eor      w9, w2, w9, ror #16
02ca2d28: ror      w23, w9, #0x18
02ca2d2c: add      w14, w23, w14
02ca2d30: eor      w16, w14, w16, ror #20
02ca2d34: ror      w23, w16, #0x19
02ca2d38: add      w10, w21, w10
02ca2d3c: eor      w9, w10, w9, ror #24
02ca2d40: ror      w21, w9, #0x10
02ca2d44: add      w12, w21, w12
02ca2d48: eor      w13, w12, w13, ror #25
02ca2d4c: ror      w21, w13, #0x14
02ca2d50: add      w10, w21, w10
02ca2d54: eor      w9, w10, w9, ror #16
02ca2d58: ror      w9, w9, #0x18
02ca2d5c: add      w12, w9, w12
02ca2d60: eor      w13, w12, w13, ror #20
02ca2d64: ror      w13, w13, #0x19
02ca2d68: add      w11, w22, w11
02ca2d6c: eor      w3, w11, w3, ror #24
02ca2d70: ror      w21, w3, #0x10
02ca2d74: add      w14, w14, w21
02ca2d78: eor      w15, w14, w15, ror #25
02ca2d7c: ror      w21, w15, #0x14
02ca2d80: add      w11, w21, w11
02ca2d84: eor      w3, w11, w3, ror #16
02ca2d88: ror      w3, w3, #0x18
02ca2d8c: add      w14, w3, w14
02ca2d90: eor      w15, w14, w15, ror #20
02ca2d94: ror      w15, w15, #0x19
02ca2d98: add      w17, w23, w17
02ca2d9c: eor      w4, w17, w4, ror #24
02ca2da0: ror      w21, w4, #0x10
02ca2da4: add      w6, w21, w6
02ca2da8: eor      w16, w6, w16, ror #25
02ca2dac: ror      w21, w16, #0x14
02ca2db0: add      w17, w21, w17
02ca2db4: eor      w4, w17, w4, ror #16
02ca2db8: ror      w4, w4, #0x18
02ca2dbc: add      w6, w4, w6
02ca2dc0: eor      w16, w6, w16, ror #20
02ca2dc4: ror      w16, w16, #0x19
02ca2dc8: add      w2, w2, w20
02ca2dcc: eor      w5, w2, w5, ror #24
02ca2dd0: ror      w20, w5, #0x10
02ca2dd4: add      w7, w20, w7
02ca2dd8: eor      w19, w7, w19, ror #25
02ca2ddc: ror      w20, w19, #0x14
02ca2de0: add      w2, w20, w2
02ca2de4: eor      w5, w2, w5, ror #16
02ca2de8: ror      w5, w5, #0x18
02ca2dec: add      w7, w5, w7
02ca2df0: eor      w19, w7, w19, ror #20
02ca2df4: sub      w8, w8, #2
02ca2df8: ror      w19, w19, #0x19
02ca2dfc: cmp      w8, #2
02ca2e00: b.hi     #0x2ca2c78
02ca2e04: stp      w19, w13, [sp, #0x10]
02ca2e08: stp      w3, w4, [sp, #0x30]
02ca2e0c: stp      w6, w7, [sp, #0x20]
02ca2e10: stp      w17, w2, [sp, #8]
02ca2e14: stp      w15, w16, [sp, #0x18]
02ca2e18: stp      w5, w9, [sp, #0x38]
02ca2e1c: stp      w12, w14, [sp, #0x28]
02ca2e20: ldr      w8, [x1]
02ca2e24: add      w10, w8, w10
02ca2e28: mov      w8, #4
02ca2e2c: mov      x9, sp
02ca2e30: stp      w10, w11, [sp]
02ca2e34: ldr      w10, [x9, x8]
02ca2e38: ldr      w11, [x1, x8]
02ca2e3c: add      w10, w11, w10
02ca2e40: str      w10, [x9, x8]
02ca2e44: add      x8, x8, #4
02ca2e48: cmp      x8, #0x40
02ca2e4c: b.ne     #0x2ca2e34
02ca2e50: ldp      q1, q0, [sp]
02ca2e54: ldp      q3, q2, [sp, #0x20]
02ca2e58: uzp1     v4.8h, v3.8h, v2.8h
02ca2e5c: uzp1     v5.8h, v1.8h, v0.8h
02ca2e60: uzp1     v4.16b, v5.16b, v4.16b
02ca2e64: xtn      v16.4h, v1.4s
02ca2e68: xtn      v17.4h, v3.4s
02ca2e6c: xtn      v18.4h, v2.4s
02ca2e70: ushr     v18.4h, v18.4h, #8
02ca2e74: ushr     v17.4h, v17.4h, #8
02ca2e78: mov      v17.d[1], v18.d[0]
02ca2e7c: xtn      v18.4h, v0.4s
02ca2e80: ushr     v18.4h, v18.4h, #8
02ca2e84: ushr     v16.4h, v16.4h, #8
02ca2e88: mov      v16.d[1], v18.d[0]
02ca2e8c: uzp1     v5.16b, v16.16b, v17.16b
02ca2e90: shrn     v16.4h, v3.4s, #0x10
02ca2e94: shrn2    v16.8h, v2.4s, #0x10
02ca2e98: shrn     v17.4h, v1.4s, #0x10
02ca2e9c: shrn2    v17.8h, v0.4s, #0x10
02ca2ea0: uzp1     v6.16b, v17.16b, v16.16b
02ca2ea4: ushr     v0.4s, v0.4s, #0x18
02ca2ea8: ushr     v1.4s, v1.4s, #0x18
02ca2eac: ushr     v2.4s, v2.4s, #0x18
02ca2eb0: ushr     v3.4s, v3.4s, #0x18
02ca2eb4: uzp1     v2.8h, v3.8h, v2.8h
02ca2eb8: uzp1     v0.8h, v1.8h, v0.8h
02ca2ebc: uzp1     v7.16b, v0.16b, v2.16b
02ca2ec0: st4      {v4.16b, v5.16b, v6.16b, v7.16b}, [x0]
02ca2ec4: ldp      x20, x19, [sp, #0x60]
02ca2ec8: ldp      x22, x21, [sp, #0x50]
02ca2ecc: ldp      x24, x23, [sp, #0x40]
02ca2ed0: add      sp, sp, #0x70
02ca2ed4: ret      
