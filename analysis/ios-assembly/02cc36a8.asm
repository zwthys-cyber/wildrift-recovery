02cc36a8: ldrsw    x8, [x0]
02cc36ac: cmn      w8, #1
02cc36b0: b.eq     #0x2cc36d4
02cc36b4: adrp     x9, #0x10a91000
02cc36b8: ldr      x9, [x9, #0x5d0]
02cc36bc: adrp     x10, #0x10a91000
02cc36c0: ldr      x10, [x10, #0x5d8]
02cc36c4: ldrsw    x10, [x10, #0x68]
02cc36c8: add      x9, x9, x10
02cc36cc: add      x8, x9, x8, lsl #4
02cc36d0: b        #0x2cc36d8
02cc36d4: mov      x8, #0
02cc36d8: str      x8, [x0]
02cc36dc: ret      
