02ce0950: sub      sp, sp, #0x90
02ce0954: stp      x20, x19, [sp, #0x70]
02ce0958: stp      x29, x30, [sp, #0x80]
02ce095c: add      x29, sp, #0x80
02ce0960: mov      x19, x2
02ce0964: bl       #0x2cc4bf0
02ce0968: tbz      w0, #0x1f, #0x2ce09a4
02ce096c: and      w8, w0, #0x7fffffff
02ce0970: stur     wzr, [x29, #-0x28]
02ce0974: stur     x19, [x29, #-0x20]
02ce0978: stur     w8, [x29, #-0x18]
02ce097c: adrp     x19, #0x10a91000
02ce0980: add      x19, x19, #0xaf0
02ce0984: mov      x0, x19
02ce0988: mov      w1, #1
02ce098c: bl       #0x2ceb900
02ce0990: add      x8, sp, #8
02ce0994: sub      x1, x29, #0x28
02ce0998: mov      x0, x19
02ce099c: bl       #0x2ceba44
02ce09a0: mov      w0, #-1
02ce09a4: ldp      x29, x30, [sp, #0x80]
02ce09a8: ldp      x20, x19, [sp, #0x70]
02ce09ac: add      sp, sp, #0x90
02ce09b0: ret      
