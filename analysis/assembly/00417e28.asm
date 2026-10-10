00417e28: stp      x29, x30, [sp, #-0x30]!
00417e2c: str      x21, [sp, #0x10]
00417e30: stp      x20, x19, [sp, #0x20]
00417e34: mov      x29, sp
00417e38: adrp     x8, #0x25000
00417e3c: add      x8, x8, #0xe8e
00417e40: adrp     x9, #0x24000
00417e44: add      x9, x9, #0xf11 ; 'com.tencent.lolm'
00417e48: movi     v2.2d, #0000000000000000
00417e4c: mov      x19, x0
00417e50: stp      x8, x9, [x0, #0x20]
00417e54: adrp     x8, #0x556000
00417e58: add      x8, x8, #0xfa0
00417e5c: str      x8, [x0]
00417e60: adrp     x8, #0x20000
00417e64: add      x9, x0, #0x108
00417e68: ldr      q0, [x8, #0x760]
00417e6c: adrp     x8, #0x20000
00417e70: mov      x20, x0
00417e74: ldr      q1, [x8, #0x770]
00417e78: adrp     x8, #0x20000
00417e7c: mov      w21, #0x3f800000
00417e80: stur     q0, [x0, #0xf8]
00417e84: ldr      q0, [x8, #0x460]
00417e88: adrp     x8, #0x1f000
00417e8c: str      xzr, [x20, #8]!
00417e90: stp      q1, q0, [x9]
00417e94: ldr      d0, [x8, #0x9c8]
00417e98: stp      xzr, xzr, [x0, #0x10]
00417e9c: str      xzr, [x0, #0x30]
00417ea0: strh     wzr, [x0, #0x38]
00417ea4: stp      q2, q2, [x0, #0x40]
00417ea8: stp      q2, q2, [x0, #0x60]
00417eac: stp      q2, q2, [x0, #0x80]
00417eb0: stp      q2, q2, [x0, #0xa0]
00417eb4: stp      q2, q2, [x0, #0xc0]
00417eb8: strb     wzr, [x0, #0xe0]
00417ebc: stur     xzr, [x0, #0xec]
00417ec0: stur     xzr, [x0, #0xe4]
00417ec4: str      d0, [x0, #0x128]
00417ec8: stp      q2, q2, [x0, #0x130]
00417ecc: stp      q2, q2, [x0, #0x150]
00417ed0: str      q2, [x0, #0x170]
00417ed4: str      w21, [x0, #0x180]
00417ed8: str      wzr, [x0, #0x188]
00417edc: str      xzr, [x0, #0x1b0]
00417ee0: str      xzr, [x0, #0x1e0]
00417ee4: stp      q2, q2, [x0, #0x1f0]
00417ee8: str      xzr, [x0, #0x210]
00417eec: stp      q2, q2, [x0, #0x230]
00417ef0: stp      q2, q2, [x0, #0x250]
00417ef4: str      q2, [x0, #0x220]
00417ef8: str      w21, [x0, #0x270]
00417efc: str      wzr, [x0, #0x278]
00417f00: str      xzr, [x0, #0x2a0]
00417f04: str      xzr, [x0, #0x2d0]
00417f08: stp      q2, q2, [x0, #0x2e0]
00417f0c: str      xzr, [x0, #0x300]
00417f10: add      x0, x0, #0x310
00417f14: mov      x1, x19
00417f18: bl       #0x426f24
00417f1c: movi     v0.2d, #0000000000000000
00417f20: movi     v1.2d, #0000000000000000
00417f24: adrp     x9, #0x1f000
00417f28: mov      w8, #0x20
00417f2c: add      x10, x19, #0x938
00417f30: add      x0, x19, #0x95c
00417f34: str      w8, [x19, #0x938]
00417f38: mov      w1, wzr
00417f3c: mov      w2, #0x2375
00417f40: str      w8, [x19, #0x958]
00417f44: mov      w8, #0x2d50
00417f48: str      q0, [x19, #0x750]
00417f4c: str      q0, [x19, #0x760]
00417f50: str      q0, [x19, #0x770]
00417f54: str      q0, [x19, #0x780]
00417f58: str      q0, [x19, #0x790]
00417f5c: str      q0, [x19, #0x810]
00417f60: str      q0, [x19, #0x820]
00417f64: str      q0, [x19, #0x840]
00417f68: str      q0, [x19, #0x850]
00417f6c: str      q0, [x19, #0x860]
00417f70: str      q0, [x19, #0x870]
00417f74: str      q0, [x19, #0x880]
00417f78: str      q0, [x19, #0x900]
00417f7c: str      q0, [x19, #0x910]
00417f80: ldr      d0, [x9, #0xa58]
00417f84: mov      w9, #0x2cd8
00417f88: str      xzr, [x19, #0x740]
00417f8c: str      w21, [x19, #0x7a0]
00417f90: str      wzr, [x19, #0x7a8]
00417f94: str      xzr, [x19, #0x7d0]
00417f98: str      xzr, [x19, #0x800]
00417f9c: str      xzr, [x19, #0x830]
00417fa0: str      w21, [x19, #0x890]
00417fa4: add      x21, x19, x9
00417fa8: str      wzr, [x19, #0x898]
00417fac: str      xzr, [x19, #0x8c0]
00417fb0: str      xzr, [x19, #0x8f0]
00417fb4: str      xzr, [x19, #0x920]
00417fb8: str      xzr, [x19, #0x930]
00417fbc: str      wzr, [x19, #0x94c]
00417fc0: stur     q1, [x10, #4]
00417fc4: str      d0, [x19, #0x950]
00417fc8: str      xzr, [x19, #0x2d48]
00417fcc: strb     wzr, [x19, x8]
00417fd0: bl       #0x554090 ; memset
00417fd4: movi     v0.2d, #0000000000000000
00417fd8: strh     wzr, [x21, #0x50]
00417fdc: str      wzr, [x19, #0x2d40]
00417fe0: stp      q0, q0, [x21]
00417fe4: stp      q0, q0, [x21, #0x20]
00417fe8: str      q0, [x21, #0x40]
00417fec: str      q0, [x19, #0x2d30]
00417ff0: add      x1, x19, #0x310
00417ff4: mov      x0, x20
00417ff8: bl       #0x423590
00417ffc: ldp      x20, x19, [sp, #0x20]
00418000: ldr      x21, [sp, #0x10]
00418004: ldp      x29, x30, [sp], #0x30
00418008: ret      
0041800c: mov      w8, #0x2c50
00418010: mov      x20, x0
00418014: add      x0, x19, x8
00418018: bl       #0x4273a8
0041801c: add      x0, x19, #0x840
00418020: bl       #0x427488
00418024: add      x0, x19, #0x750
00418028: bl       #0x427538
0041802c: add      x0, x19, #0x310
00418030: bl       #0x422890
00418034: b        #0x41803c
00418038: mov      x20, x0
0041803c: add      x0, x19, #0x220
00418040: bl       #0x427538
00418044: add      x0, x19, #0x130
00418048: bl       #0x4275e8
0041804c: mov      x0, x19
00418050: bl       #0x423de4
00418054: mov      x0, x20
00418058: bl       #0x54fffc
