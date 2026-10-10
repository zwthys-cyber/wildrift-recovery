02cc366c: ldrsw    x8, [x0]
02cc3670: cmn      w8, #1
02cc3674: b.eq     #0x2cc369c
02cc3678: adrp     x9, #0x10a91000
02cc367c: ldr      x9, [x9, #0x5d0]
02cc3680: adrp     x10, #0x10a91000
02cc3684: ldr      x10, [x10, #0x5d8]
02cc3688: ldrsw    x10, [x10, #0xa0]
02cc368c: add      x9, x9, x10
02cc3690: mov      w10, #0x58
02cc3694: madd     x8, x8, x10, x9
02cc3698: b        #0x2cc36a0
02cc369c: mov      x8, #0
02cc36a0: str      x8, [x0]
02cc36a4: ret      
