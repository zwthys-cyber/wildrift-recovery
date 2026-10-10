02cd09f0: sub      sp, sp, #0xb0
02cd09f4: stp      x24, x23, [sp, #0x70]
02cd09f8: stp      x22, x21, [sp, #0x80]
02cd09fc: stp      x20, x19, [sp, #0x90]
02cd0a00: stp      x29, x30, [sp, #0xa0]
02cd0a04: add      x29, sp, #0xa0
02cd0a08: mov      x20, x2
02cd0a0c: mov      x21, x1
02cd0a10: mov      x19, x0
02cd0a14: ldr      x0, [x0, #0x30]
02cd0a18: cbnz     x0, #0x2cd0ac8
02cd0a1c: adrp     x1, #0x10a91000
02cd0a20: add      x1, x1, #0x6b0
02cd0a24: add      x0, sp, #0x20
02cd0a28: bl       #0x2c6c080
02cd0a2c: ldr      x8, [x19, #0x30]
02cd0a30: cbnz     x8, #0x2cd0abc
02cd0a34: mov      w0, #0x70
02cd0a38: bl       #0xe7030
02cd0a3c: mov      x22, x0
02cd0a40: add      x2, sp, #8
02cd0a44: sub      x3, x29, #0x38
02cd0a48: mov      x1, #0
02cd0a4c: bl       #0x2cd669c
02cd0a50: str      x22, [x19, #0x30]
02cd0a54: ldr      w8, [x19, #0x18]
02cd0a58: cbz      w8, #0x2cd0a88
02cd0a5c: mov      w22, #0
02cd0a60: mov      x0, x19
02cd0a64: mov      x1, x22
02cd0a68: bl       #0x2cdef0c
02cd0a6c: mov      x1, x0
02cd0a70: mov      x0, x19
02cd0a74: bl       #0x2cd0b94
02cd0a78: add      w22, w22, #1
02cd0a7c: ldr      w8, [x19, #0x18]
02cd0a80: cmp      w22, w8
02cd0a84: b.lo     #0x2cd0a60
02cd0a88: ldr      w8, [x19, #0x1c]
02cd0a8c: cbz      w8, #0x2cd0abc
02cd0a90: mov      w22, #0
02cd0a94: mov      x0, x19
02cd0a98: mov      x1, x22
02cd0a9c: bl       #0x2cdef10
02cd0aa0: mov      x1, x0
02cd0aa4: mov      x0, x19
02cd0aa8: bl       #0x2cd0b94
02cd0aac: add      w22, w22, #1
02cd0ab0: ldr      w8, [x19, #0x1c]
02cd0ab4: cmp      w22, w8
02cd0ab8: b.lo     #0x2cd0a94
02cd0abc: add      x0, sp, #0x20
02cd0ac0: bl       #0x2c6c104
02cd0ac4: ldr      x0, [x19, #0x30]
02cd0ac8: str      wzr, [sp, #8]
02cd0acc: stp      x21, x20, [sp, #0x10]
02cd0ad0: add      x8, sp, #0x20
02cd0ad4: add      x1, sp, #8
02cd0ad8: bl       #0x2cd68e8
02cd0adc: ldp      x23, x21, [sp, #0x28]
02cd0ae0: ldp      x22, x20, [sp, #0x38]
02cd0ae4: ldr      x8, [x19, #0x30]
02cd0ae8: ldp      x9, x10, [x8, #0x48]
02cd0aec: stp      x8, x9, [sp, #0x20]
02cd0af0: stp      x10, x10, [sp, #0x30]
02cd0af4: stp      xzr, x9, [sp, #0x40]
02cd0af8: stp      x10, x10, [sp, #0x50]
02cd0afc: str      xzr, [sp, #0x60]
02cd0b00: add      x0, sp, #0x20
02cd0b04: bl       #0x2cd657c
02cd0b08: ldr      x8, [sp, #0x28]
02cd0b0c: cmp      x23, x8
02cd0b10: b.ne     #0x2cd0b40
02cd0b14: ldr      x8, [sp, #0x30]
02cd0b18: cmp      x21, x8
02cd0b1c: b.ne     #0x2cd0b40
02cd0b20: ldr      x8, [sp, #0x38]
02cd0b24: cmp      x22, x8
02cd0b28: b.ne     #0x2cd0b40
02cd0b2c: cmp      x22, x21
02cd0b30: b.eq     #0x2cd0b4c
02cd0b34: ldr      x8, [sp, #0x40]
02cd0b38: cmp      x20, x8
02cd0b3c: b.eq     #0x2cd0b4c
02cd0b40: ldr      x0, [x20, #0x18]
02cd0b44: bl       #0x2ce08a8
02cd0b48: b        #0x2cd0b50
02cd0b4c: mov      x0, #0
02cd0b50: ldp      x29, x30, [sp, #0xa0]
02cd0b54: ldp      x20, x19, [sp, #0x90]
02cd0b58: ldp      x22, x21, [sp, #0x80]
02cd0b5c: ldp      x24, x23, [sp, #0x70]
02cd0b60: add      sp, sp, #0xb0
02cd0b64: ret      
02cd0b68: mov      x19, x0
02cd0b6c: mov      x0, x22
02cd0b70: bl       #0xe5038
02cd0b74: b        #0x2cd0b84
02cd0b78: b        #0x2cd0b80
02cd0b7c: b        #0x2cd0b80
02cd0b80: mov      x19, x0
02cd0b84: add      x0, sp, #0x20
02cd0b88: bl       #0x2c6c104
02cd0b8c: mov      x0, x19
02cd0b90: bl       #0x7c121f8
