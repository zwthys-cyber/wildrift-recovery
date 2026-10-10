02cdb4a8: sub      sp, sp, #0x30
02cdb4ac: stp      x20, x19, [sp, #0x10]
02cdb4b0: stp      x29, x30, [sp, #0x20]
02cdb4b4: add      x29, sp, #0x20
02cdb4b8: add      x8, x0, #0x135
02cdb4bc: ldrb     w9, [x8, #2]
02cdb4c0: ldrh     w8, [x8]
02cdb4c4: bfi      w8, w9, #0x10, #8
02cdb4c8: tbnz     w8, #8, #0x2cdb4f4
02cdb4cc: mov      x19, x0
02cdb4d0: adrp     x1, #0x10b35000
02cdb4d4: add      x1, x1, #0xbf0
02cdb4d8: add      x0, sp, #8
02cdb4dc: bl       #0x2c6c080
02cdb4e0: add      x1, sp, #8
02cdb4e4: mov      x0, x19
02cdb4e8: bl       #0x2cdc5ec
02cdb4ec: add      x0, sp, #8
02cdb4f0: bl       #0x2c6c104
02cdb4f4: ldp      x29, x30, [sp, #0x20]
02cdb4f8: ldp      x20, x19, [sp, #0x10]
02cdb4fc: add      sp, sp, #0x30
02cdb500: ret      
02cdb504: mov      x19, x0
02cdb508: add      x0, sp, #8
02cdb50c: bl       #0x2c6c104
02cdb510: mov      x0, x19
02cdb514: bl       #0x7c121f8
