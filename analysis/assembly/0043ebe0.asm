0043ebe0: sub      sp, sp, #0x70
0043ebe4: stp      x29, x30, [sp, #0x10]
0043ebe8: stp      x28, x27, [sp, #0x20]
0043ebec: stp      x26, x25, [sp, #0x30]
0043ebf0: stp      x24, x23, [sp, #0x40]
0043ebf4: stp      x22, x21, [sp, #0x50]
0043ebf8: stp      x20, x19, [sp, #0x60]
0043ebfc: add      x29, sp, #0x10
0043ec00: mrs      x27, tpidr_el0
0043ec04: mov      w24, wzr
0043ec08: mov      w25, #1
0043ec0c: ldr      x8, [x27, #0x28]
0043ec10: str      x8, [sp, #8]
0043ec14: adrp     x8, #0x59f000
0043ec18: ldr      w8, [x8, #0x1e8]
0043ec1c: cmp      w8, #3
0043ec20: b.gt     #0x43ec74
0043ec24: cmp      w8, #1
0043ec28: b.eq     #0x43ecc4
0043ec2c: cmp      w8, #2
0043ec30: b.eq     #0x43ed04
0043ec34: cmp      w8, #3
0043ec38: mov      w28, w24
0043ec3c: mov      w22, w24
0043ec40: mov      w21, w24
0043ec44: mov      w20, w24
0043ec48: mov      w19, w24
0043ec4c: mov      w23, w24
0043ec50: b.ne     #0x43ed44
0043ec54: mov      w25, wzr
0043ec58: mov      w24, wzr
0043ec5c: mov      w28, wzr
0043ec60: mov      w21, wzr
0043ec64: mov      w20, wzr
0043ec68: mov      w19, wzr
0043ec6c: mov      w22, #1
0043ec70: b        #0x43ed40
0043ec74: cmp      w8, #4
0043ec78: b.eq     #0x43ece4
0043ec7c: cmp      w8, #5
0043ec80: b.eq     #0x43ed24
0043ec84: cmp      w8, #6
0043ec88: mov      w28, w24
0043ec8c: mov      w22, w24
0043ec90: mov      w21, w24
0043ec94: mov      w20, w24
0043ec98: mov      w19, w24
0043ec9c: mov      w23, w24
0043eca0: b.ne     #0x43ed44
0043eca4: mov      w25, wzr
0043eca8: mov      w24, wzr
0043ecac: mov      w28, wzr
0043ecb0: mov      w22, wzr
0043ecb4: mov      w21, wzr
0043ecb8: mov      w20, wzr
0043ecbc: mov      w19, #1
0043ecc0: b        #0x43ed40
0043ecc4: mov      w25, wzr
0043ecc8: mov      w28, wzr
0043eccc: mov      w22, wzr
0043ecd0: mov      w21, wzr
0043ecd4: mov      w20, wzr
0043ecd8: mov      w19, wzr
0043ecdc: mov      w24, #1
0043ece0: b        #0x43ed40
0043ece4: mov      w25, wzr
0043ece8: mov      w24, wzr
0043ecec: mov      w28, wzr
0043ecf0: mov      w22, wzr
0043ecf4: mov      w20, wzr
0043ecf8: mov      w19, wzr
0043ecfc: mov      w21, #1
0043ed00: b        #0x43ed40
0043ed04: mov      w25, wzr
0043ed08: mov      w24, wzr
0043ed0c: mov      w22, wzr
0043ed10: mov      w21, wzr
0043ed14: mov      w20, wzr
0043ed18: mov      w19, wzr
0043ed1c: mov      w28, #1
0043ed20: b        #0x43ed40
0043ed24: mov      w25, wzr
0043ed28: mov      w24, wzr
0043ed2c: mov      w28, wzr
0043ed30: mov      w22, wzr
0043ed34: mov      w21, wzr
0043ed38: mov      w19, wzr
0043ed3c: mov      w20, #1
0043ed40: mov      w23, w8
0043ed44: adrp     x0, #0x20000
0043ed48: add      x0, x0, #0xd81
0043ed4c: bl       #0x3ca8b0
0043ed50: adrp     x0, #0x23000
0043ed54: add      x0, x0, #0xd08
0043ed58: bl       #0x3ca8b0
0043ed5c: fmov     s0, #-1.00000000
0043ed60: bl       #0x3b523c
0043ed64: adrp     x8, #0x557000
0043ed68: add      x8, x8, #0x9e0
0043ed6c: adrp     x0, #0x27000
0043ed70: add      x0, x0, #0x896
0043ed74: ldr      x1, [x8, w23, uxtw #3]
0043ed78: mov      w2, wzr
0043ed7c: bl       #0x3e4f84
0043ed80: tbz      w0, #0, #0x43eef0
0043ed84: adrp     x0, #0x20000
0043ed88: add      x0, x0, #0xd90
0043ed8c: mov      x3, sp
0043ed90: mov      w1, w25
0043ed94: mov      w2, wzr
0043ed98: str      xzr, [sp]
0043ed9c: bl       #0x3e5620
0043eda0: tst      w0, #1
0043eda4: mov      w26, w0
0043eda8: csel     w23, wzr, w23, ne
0043edac: cbz      w25, #0x43edb4
0043edb0: bl       #0x3ca2cc
0043edb4: adrp     x0, #0x2a000
0043edb8: add      x0, x0, #0x935 ; 'Qx11 驱动'
0043edbc: mov      x3, sp
0043edc0: mov      w1, w24
0043edc4: mov      w2, wzr
0043edc8: str      xzr, [sp]
0043edcc: bl       #0x3e5620
0043edd0: tst      w0, #1
0043edd4: orr      w25, w26, w0
0043edd8: csinc    w23, w23, wzr, eq
0043eddc: cbz      w24, #0x43ede4
0043ede0: bl       #0x3ca2cc
0043ede4: adrp     x0, #0x23000
0043ede8: add      x0, x0, #0x555 ; 'TwT 驱动'
0043edec: mov      x3, sp
0043edf0: mov      w1, w28
0043edf4: mov      w2, wzr
0043edf8: str      xzr, [sp]
0043edfc: bl       #0x3e5620
0043ee00: mov      w8, #2
0043ee04: tst      w0, #1
0043ee08: orr      w24, w25, w0
0043ee0c: csel     w23, w8, w23, ne
0043ee10: cbz      w28, #0x43ee18
0043ee14: bl       #0x3ca2cc
0043ee18: adrp     x0, #0x29000
0043ee1c: add      x0, x0, #0xf ; 'Paradise 驱动'
0043ee20: mov      x3, sp
0043ee24: mov      w1, w22
0043ee28: mov      w2, wzr
0043ee2c: str      xzr, [sp]
0043ee30: bl       #0x3e5620
0043ee34: mov      w8, #3
0043ee38: tst      w0, #1
0043ee3c: orr      w24, w24, w0
0043ee40: csel     w23, w8, w23, ne
0043ee44: cbz      w22, #0x43ee4c
0043ee48: bl       #0x3ca2cc
0043ee4c: adrp     x0, #0x25000
0043ee50: add      x0, x0, #0xf50 ; '时间驱动'
0043ee54: mov      x3, sp
0043ee58: mov      w1, w21
0043ee5c: mov      w2, wzr
0043ee60: str      xzr, [sp]
0043ee64: bl       #0x3e5620
0043ee68: mov      w8, #4
0043ee6c: tst      w0, #1
0043ee70: csel     w22, w8, w23, ne
0043ee74: orr      w23, w24, w0
0043ee78: cbz      w21, #0x43ee80
0043ee7c: bl       #0x3ca2cc
0043ee80: adrp     x0, #0x2b000
0043ee84: add      x0, x0, #0x3ff ; 'rt-QX 驱动'
0043ee88: mov      x3, sp
0043ee8c: mov      w1, w20
0043ee90: mov      w2, wzr
0043ee94: str      xzr, [sp]
0043ee98: bl       #0x3e5620
0043ee9c: mov      w8, #5
0043eea0: tst      w0, #1
0043eea4: csel     w21, w8, w22, ne
0043eea8: orr      w22, w23, w0
0043eeac: cbz      w20, #0x43eeb4
0043eeb0: bl       #0x3ca2cc
0043eeb4: adrp     x0, #0x24000
0043eeb8: add      x0, x0, #0x645 ; 'RTHook 驱动'
0043eebc: mov      x3, sp
0043eec0: mov      w1, w19
0043eec4: mov      w2, wzr
0043eec8: str      xzr, [sp]
0043eecc: bl       #0x3e5620
0043eed0: mov      w8, #6
0043eed4: tst      w0, #1
0043eed8: orr      w26, w22, w0
0043eedc: csel     w23, w8, w21, ne
0043eee0: cbz      w19, #0x43eee8
0043eee4: bl       #0x3ca2cc
0043eee8: bl       #0x3e55ec
0043eeec: b        #0x43eef4
0043eef0: mov      w26, wzr
0043eef4: bl       #0x3cad20
0043eef8: bl       #0x3cad20
0043eefc: tbz      w26, #0, #0x43ef14
0043ef00: adrp     x8, #0x2bd000
0043ef04: add      x8, x8, #0xf84
0043ef08: adrp     x9, #0x59f000
0043ef0c: ldr      w8, [x8, w23, uxtw #2]
0043ef10: str      w8, [x9, #0x1e8]
0043ef14: ldr      x8, [x27, #0x28]
0043ef18: ldr      x9, [sp, #8]
0043ef1c: cmp      x8, x9
0043ef20: b.ne     #0x43ef44
0043ef24: ldp      x20, x19, [sp, #0x60]
0043ef28: ldp      x22, x21, [sp, #0x50]
0043ef2c: ldp      x24, x23, [sp, #0x40]
0043ef30: ldp      x26, x25, [sp, #0x30]
0043ef34: ldp      x28, x27, [sp, #0x20]
0043ef38: ldp      x29, x30, [sp, #0x10]
0043ef3c: add      sp, sp, #0x70
0043ef40: ret      
0043ef44: bl       #0x553f00 ; __stack_chk_fail
