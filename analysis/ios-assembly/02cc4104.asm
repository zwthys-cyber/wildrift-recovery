02cc4104: stp      x22, x21, [sp, #-0x30]!
02cc4108: stp      x20, x19, [sp, #0x10]
02cc410c: stp      x29, x30, [sp, #0x20]
02cc4110: add      x29, sp, #0x20
02cc4114: mov      x19, x2
02cc4118: mov      x20, x0
02cc411c: adrp     x8, #0x10a91000
02cc4120: ldr      x8, [x8, #0x5d0]
02cc4124: adrp     x9, #0x10a91000
02cc4128: ldr      x9, [x9, #0x5d8]
02cc412c: ldrsw    x9, [x9, #0xb0]
02cc4130: add      x8, x8, x9
02cc4134: sxtw     x9, w1
02cc4138: add      x21, x8, x9, lsl #6
02cc413c: ldr      w8, [x21, #4]
02cc4140: str      w8, [x0, #8]
02cc4144: ldr      w8, [x21, #8]
02cc4148: str      w8, [x0, #0xc]
02cc414c: ldr      w8, [x21, #0xc]
02cc4150: str      w8, [x0, #0x10]
02cc4154: ldr      w0, [x21, #0x10]
02cc4158: bl       #0x2cc4004
02cc415c: str      x0, [x20, #0x18]
02cc4160: ldr      w0, [x21, #0x14]
02cc4164: bl       #0x2cc4004
02cc4168: str      x0, [x20, #0x20]
02cc416c: ldr      w0, [x21, #0x18]
02cc4170: bl       #0x2cc4004
02cc4174: str      x0, [x20, #0x28]
02cc4178: ldr      w8, [x21, #0x1c]
02cc417c: str      w8, [x20, #0x30]
02cc4180: ldr      w8, [x21, #0x20]
02cc4184: str      w8, [x20, #0x34]
02cc4188: ldr      w8, [x21, #0x24]
02cc418c: str      w8, [x20, #0x38]
02cc4190: ldr      w8, [x21, #0x28]
02cc4194: str      w8, [x20, #0x3c]
02cc4198: ldr      w8, [x21, #0x2c]
02cc419c: str      w8, [x20, #0x40]
02cc41a0: ldr      w8, [x21, #0x30]
02cc41a4: str      w8, [x20, #0x44]
02cc41a8: ldr      w8, [x21, #0x34]
02cc41ac: str      w8, [x20, #0x48]
02cc41b0: ldr      x8, [x21, #0x38]
02cc41b4: stur     x8, [x20, #0x4c]
02cc41b8: ldr      w8, [x21]
02cc41bc: str      w8, [x19]
02cc41c0: ldp      x29, x30, [sp, #0x20]
02cc41c4: ldp      x20, x19, [sp, #0x10]
02cc41c8: ldp      x22, x21, [sp], #0x30
02cc41cc: ret      
