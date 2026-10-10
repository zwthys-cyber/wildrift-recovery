02c69a40: stp      x20, x19, [sp, #-0x20]!
02c69a44: stp      x29, x30, [sp, #0x10]
02c69a48: add      x29, sp, #0x10
02c69a4c: mov      x19, x0
02c69a50: adrp     x1, #0xf8dc000
02c69a54: add      x1, x1, #0xaa0
02c69a58: mov      w0, #0
02c69a5c: bl       #0x7c13bc0
02c69a60: mov      x0, x19
02c69a64: bl       #0x2cd7fe8
02c69a68: ldp      x29, x30, [sp, #0x10]
02c69a6c: ldp      x20, x19, [sp], #0x20
02c69a70: ret      
02c69a74: sub      sp, sp, #0x50
02c69a78: stp      x22, x21, [sp, #0x20]
02c69a7c: stp      x20, x19, [sp, #0x30]
02c69a80: stp      x29, x30, [sp, #0x40]
02c69a84: add      x29, sp, #0x40
02c69a88: add      x19, sp, #8
02c69a8c: add      x8, sp, #8
02c69a90: bl       #0x2ca40e8
02c69a94: ldrsb    w20, [sp, #0x1f]
02c69a98: ldr      x21, [sp, #8]
02c69a9c: adrp     x1, #0xf8dc000
02c69aa0: add      x1, x1, #0xaa0
02c69aa4: mov      w0, #0
02c69aa8: bl       #0x7c13bc0
02c69aac: cmp      w20, #0
02c69ab0: csel     x0, x21, x19, lt
02c69ab4: bl       #0x2cd7fe8
02c69ab8: mov      x19, x0
02c69abc: ldrsb    w8, [sp, #0x1f]
02c69ac0: tbz      w8, #0x1f, #0x2c69acc
02c69ac4: ldr      x0, [sp, #8]
02c69ac8: bl       #0xe5038
02c69acc: mov      x0, x19
02c69ad0: ldp      x29, x30, [sp, #0x40]
02c69ad4: ldp      x20, x19, [sp, #0x30]
02c69ad8: ldp      x22, x21, [sp, #0x20]
02c69adc: add      sp, sp, #0x50
02c69ae0: ret      
02c69ae4: mov      x19, x0
02c69ae8: ldrsb    w8, [sp, #0x1f]
02c69aec: tbz      w8, #0x1f, #0x2c69af8
02c69af0: ldr      x0, [sp, #8]
02c69af4: bl       #0xe5038
02c69af8: mov      x0, x19
02c69afc: bl       #0x7c121f8
02c69b00: b        #0x2cd8ee0
