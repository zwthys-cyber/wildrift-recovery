00426f24: sub      sp, sp, #0xe0
00426f28: stp      x29, x30, [sp, #0xa0]
00426f2c: stp      x24, x23, [sp, #0xb0]
00426f30: stp      x22, x21, [sp, #0xc0]
00426f34: stp      x20, x19, [sp, #0xd0]
00426f38: add      x29, sp, #0xa0
00426f3c: mrs      x24, tpidr_el0
00426f40: movi     v1.2s, #1, lsl #16
00426f44: adrp     x9, #0x556000
00426f48: add      x9, x9, #0xf50
00426f4c: ldr      x8, [x24, #0x28]
00426f50: adrp     x10, #0x1f000
00426f54: adrp     x11, #0x2a000
00426f58: add      x11, x11, #0x890
00426f5c: mov      x13, #0x41f00000
00426f60: stur     x8, [x29, #-8]
00426f64: adrp     x8, #0x22000
00426f68: add      x8, x8, #0x8c9
00426f6c: stp      x9, x8, [x0]
00426f70: adrp     x9, #0x1f000
00426f74: ldr      x12, [x11]
00426f78: ldr      d2, [x9, #0xae8]
00426f7c: stur     s1, [x0, #0x55]
00426f80: ldr      d1, [x10, #0xaa0]
00426f84: adrp     x10, #0x1f000
00426f88: stur     x12, [x0, #0xc1]
00426f8c: adrp     x12, #0x1f000
00426f90: stur     d2, [x0, #0x4d]
00426f94: ldr      d2, [x10, #0x920]
00426f98: adrp     x10, #0x1f000
00426f9c: stur     d1, [x0, #0x5c]
00426fa0: ldr      d1, [x10, #0xa08]
00426fa4: mov      w10, #0x1e
00426fa8: strb     w10, [x0, #0xc0]
00426fac: ldur     x10, [x11, #7]
00426fb0: add      x11, x0, #0x10c
00426fb4: stur     d1, [x0, #0x9c]
00426fb8: movk     x13, #0x4248, lsl #48
00426fbc: movi     v0.2d, #0000000000000000
00426fc0: str      x10, [x0, #0xc8]
00426fc4: adrp     x10, #0x1f000
00426fc8: mov      w8, #0x1010101
00426fcc: ldr      q1, [x10, #0xe70]
00426fd0: adrp     x10, #0x20000
00426fd4: stur     d2, [x0, #0x64]
00426fd8: ldr      q2, [x10, #0x590]
00426fdc: adrp     x10, #0x1f000
00426fe0: str      w8, [x0, #0x48]
00426fe4: stur     q1, [x0, #0xec]
00426fe8: ldr      q1, [x10, #0xc30]
00426fec: adrp     x10, #0x1f000
00426ff0: stur     q2, [x0, #0xfc]
00426ff4: ldr      q2, [x10, #0xca0]
00426ff8: adrp     x10, #0x1f000
00426ffc: strb     w8, [x0, #0x4c]
00427000: mov      w8, #0x101
00427004: mov      w9, #1
00427008: stp      q1, q2, [x11]
0042700c: ldr      q1, [x10, #0xff0]
00427010: add      x10, x0, #0x12c
00427014: str      x13, [x10]
00427018: adrp     x10, #0x20000
0042701c: mov      x19, x0
00427020: stur     q1, [x11, #0x38]
00427024: ldr      q1, [x12, #0xcb0]
00427028: add      x12, x0, #0x134
0042702c: sturh    w8, [x0, #0x59]
00427030: add      x20, x0, #0x188
00427034: add      x21, x0, #0x1d8
00427038: stur     q1, [x11, #0x48]
0042703c: ldr      q1, [x10, #0x40]
00427040: adrp     x10, #0x20000
00427044: strh     w8, [x0, #0x384]
00427048: add      x8, x0, #0x388
0042704c: add      x22, x0, #0x228
00427050: stur     q1, [x11, #0x58]
00427054: ldr      q1, [x10, #0x1d0]
00427058: mov      w10, #0x3f800000
0042705c: stur     xzr, [x12, #5]
00427060: sub      x23, x29, #0x40
00427064: str      xzr, [x12]
00427068: mov      x12, #0x3e8
0042706c: stur     q1, [x11, #0x68]
00427070: mov      w11, #2
00427074: movk     x12, #0x4438, lsl #32
00427078: str      q0, [x8]
0042707c: mov      w8, #0x2710
00427080: movk     x12, #1, lsl #48
00427084: str      x11, [x0, #0x328]
00427088: add      x11, x0, #0x379
0042708c: str      w8, [x0, #0x3f8]
00427090: add      x8, x0, #0x3fc
00427094: strb     w9, [x0, #0x5b]
00427098: strh     w9, [x11]
0042709c: add      x11, x0, #0x37c
004270a0: strb     w9, [x0, #0x37b]
004270a4: strb     w9, [x0, #0x386]
004270a8: add      x9, x0, #0x3a4
004270ac: stur     q0, [x8, #0x1c]
004270b0: stp      q0, q0, [x8]
004270b4: adrp     x8, #0x557000
004270b8: add      x8, x8, #0x278
004270bc: str      xzr, [x0, #0x28]
004270c0: strb     wzr, [x0, #0x20]
004270c4: str      q0, [x0, #0x30]
004270c8: str      q0, [x0, #0x10]
004270cc: str      x1, [x0, #0x40]
004270d0: stur     xzr, [x0, #0x6c]
004270d4: stur     xzr, [x0, #0x71]
004270d8: str      q0, [x0, #0x80]
004270dc: strb     wzr, [x0, #0x98]
004270e0: str      xzr, [x0, #0x90]
004270e4: str      xzr, [x0, #0xa8]
004270e8: strh     wzr, [x0, #0xb0]
004270ec: str      xzr, [x0, #0xb8]
004270f0: strb     wzr, [x0, #0xd0]
004270f4: str      wzr, [x0, #0xe8]
004270f8: stur     q0, [x0, #0xd8]
004270fc: str      w10, [x0, #0x184]
00427100: stp      q0, q0, [x20]
00427104: str      w10, [x0, #0x1a8]
00427108: stp      q0, q0, [x0, #0x1b0]
0042710c: str      w10, [x0, #0x1d0]
00427110: stp      q0, q0, [x21]
00427114: str      w10, [x0, #0x1f8]
00427118: stp      q0, q0, [x0, #0x200]
0042711c: str      w10, [x0, #0x220]
00427120: stp      q0, q0, [x22]
00427124: str      w10, [x0, #0x248]
00427128: stp      q0, q0, [x0, #0x250]
0042712c: stp      q0, q0, [x0, #0x270]
00427130: stp      q0, q0, [x0, #0x290]
00427134: stp      q0, q0, [x0, #0x2b0]
00427138: stp      q0, q0, [x0, #0x2d0]
0042713c: stp      q0, q0, [x0, #0x2f0]
00427140: str      q0, [x0, #0x310]
00427144: str      xzr, [x0, #0x320]
00427148: stp      q0, q0, [x0, #0x330]
0042714c: str      w10, [x0, #0x350]
00427150: strb     wzr, [x0, #0x358]
00427154: strb     wzr, [x0, #0x378]
00427158: str      xzr, [x0, #0x370]
0042715c: str      q0, [x0, #0x360]
00427160: str      x12, [x11]
00427164: str      xzr, [x0, #0x3f0]
00427168: str      q0, [x0, #0x3e0]
0042716c: strb     wzr, [x0, #0x3a0]
00427170: str      xzr, [x0, #0x398]
00427174: str      xzr, [x9, #0x30]
00427178: stp      q0, q0, [x9, #0x10]
0042717c: str      q0, [x9]
00427180: str      w10, [x0, #0x428]
00427184: stp      x8, x0, [x29, #-0x40]
00427188: stur     x23, [x29, #-0x20]
