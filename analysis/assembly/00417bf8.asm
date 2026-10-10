00417bf8: sub      sp, sp, #0xa0
00417bfc: stp      x29, x30, [sp, #0x80]
00417c00: stp      x20, x19, [sp, #0x90]
00417c04: add      x29, sp, #0x80
00417c08: mrs      x20, tpidr_el0
00417c0c: ldr      x8, [x20, #0x28]
00417c10: stur     x8, [x29, #-8]
00417c14: ldr      x19, [x0, #0x40]
00417c18: ldr      x8, [x19]
00417c1c: mov      x0, x19
00417c20: ldr      x9, [x8, #0x30]
00417c24: add      x8, sp, #0x18
00417c28: blr      x9
00417c2c: ldr      x1, [sp, #0x70]
00417c30: add      x8, sp, #8
00417c34: add      x0, x19, #0x338
00417c38: bl       #0x426dbc
00417c3c: ldr      x19, [sp, #8]
00417c40: cbz      x19, #0x417cd4
00417c44: adrp     x0, #0x2a000
00417c48: add      x0, x0, #0x87d
00417c4c: mov      x1, xzr
00417c50: mov      w2, wzr
00417c54: bl       #0x3c0ebc
00417c58: tbz      w0, #0, #0x417cd0
00417c5c: ldr      w1, [x19, #0x74]
00417c60: adrp     x0, #0x2a000
00417c64: add      x0, x0, #0xe56
00417c68: bl       #0x3e199c
00417c6c: ldp      x9, x8, [x19]
00417c70: sub      x8, x8, x9
00417c74: mov      x9, #-0x3333333333333334
00417c78: asr      x8, x8, #3
00417c7c: movk     x9, #0xcccd
00417c80: mul      x1, x8, x9
00417c84: adrp     x0, #0x21000
00417c88: add      x0, x0, #0x5e9
00417c8c: bl       #0x3e199c
00417c90: ldr      x1, [x19, #0x58]
00417c94: adrp     x0, #0x28000
00417c98: add      x0, x0, #0x5d2
00417c9c: bl       #0x3e199c
00417ca0: ldr      x1, [x19, #0x60]
00417ca4: adrp     x0, #0x26000
00417ca8: add      x0, x0, #0x8b8 ; 'GName: 0x%llX'
00417cac: bl       #0x3e199c
00417cb0: ldr      x1, [x19, #0x68]
00417cb4: adrp     x0, #0x27000
00417cb8: add      x0, x0, #0x2c4 ; 'GWorld: 0x%llX'
00417cbc: bl       #0x3e199c
00417cc0: ldr      w1, [x19, #0x70]
00417cc4: adrp     x0, #0x27000
00417cc8: add      x0, x0, #0xc6b
00417ccc: bl       #0x3e199c
00417cd0: bl       #0x3c5c78
00417cd4: ldr      x19, [sp, #0x10]
00417cd8: cbz      x19, #0x417d04
00417cdc: add      x1, x19, #8
00417ce0: mov      x0, #-1
00417ce4: bl       #0x54fd70
00417ce8: cbnz     x0, #0x417d04
00417cec: ldr      x8, [x19]
00417cf0: mov      x0, x19
00417cf4: ldr      x8, [x8, #0x10]
00417cf8: blr      x8
00417cfc: mov      x0, x19
00417d00: bl       #0x50b304
00417d04: ldr      x8, [x20, #0x28]
00417d08: ldur     x9, [x29, #-8]
00417d0c: cmp      x8, x9
00417d10: b.ne     #0x417d48
00417d14: ldp      x20, x19, [sp, #0x90]
00417d18: ldp      x29, x30, [sp, #0x80]
00417d1c: add      sp, sp, #0xa0
00417d20: ret      
00417d24: mov      x19, x0
00417d28: add      x0, sp, #8
00417d2c: bl       #0x417d4c
00417d30: ldr      x8, [x20, #0x28]
00417d34: ldur     x9, [x29, #-8]
00417d38: cmp      x8, x9
00417d3c: b.ne     #0x417d48
00417d40: mov      x0, x19
00417d44: bl       #0x54fffc
00417d48: bl       #0x553f00 ; __stack_chk_fail
