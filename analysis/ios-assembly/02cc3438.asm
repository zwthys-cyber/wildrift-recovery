02cc3438: stp      x22, x21, [sp, #-0x30]!
02cc343c: stp      x20, x19, [sp, #0x10]
02cc3440: stp      x29, x30, [sp, #0x20]
02cc3444: add      x29, sp, #0x20
02cc3448: mov      x20, x1
02cc344c: mov      x21, x0
02cc3450: adrp     x19, #0x10239000
02cc3454: add      x19, x19, #0x680
02cc3458: adrp     x3, #0x10239000
02cc345c: add      x3, x3, #0x694
02cc3460: mov      x0, x19
02cc3464: mov      x1, x19
02cc3468: mov      w2, #0x14
02cc346c: mov      x4, x3
02cc3470: mov      x5, #0
02cc3474: bl       #0x2ca2b04
02cc3478: mov      x0, x19
02cc347c: bl       #0x2cd7d70
02cc3480: mov      x19, x0
02cc3484: adrp     x8, #0x10a91000
02cc3488: str      x0, [x8, #0x5d0]
02cc348c: cbz      x0, #0x2cc35a4
02cc3490: adrp     x22, #0x10a91000
02cc3494: str      x19, [x22, #0x5d8]
02cc3498: add      x0, x19, #8
02cc349c: adrp     x3, #0x10239000
02cc34a0: add      x3, x3, #0x6b4
02cc34a4: mov      x1, x0
02cc34a8: mov      w2, #0x20
02cc34ac: mov      x4, x3
02cc34b0: mov      x5, #0
02cc34b4: bl       #0x2ca2b04
02cc34b8: ldr      x8, [x22, #0x5d8]
02cc34bc: ldrsw    x9, [x8, #0xac]
02cc34c0: mov      x10, #-0x3333333333333334
02cc34c4: movk     x10, #0xcccd
02cc34c8: umulh    x9, x9, x10
02cc34cc: lsr      x10, x9, #5
02cc34d0: str      w10, [x21]
02cc34d4: adrp     x11, #0x10a91000
02cc34d8: str      w10, [x11, #0x5e0]
02cc34dc: ldr      w8, [x8, #0xb4]
02cc34e0: asr      w8, w8, #6
02cc34e4: str      w8, [x20]
02cc34e8: sbfx     x0, x9, #5, #0x20
02cc34ec: mov      w1, #0x18
02cc34f0: bl       #0x2ca2ff8
02cc34f4: adrp     x8, #0x10a91000
02cc34f8: str      x0, [x8, #0x5e8]
02cc34fc: adrp     x20, #0x10a91000
02cc3500: ldr      x8, [x20, #0x5c8]
02cc3504: ldrsw    x0, [x8, #0x30]
02cc3508: mov      w1, #8
02cc350c: bl       #0x2ca2ff8
02cc3510: adrp     x8, #0x10a91000
02cc3514: str      x0, [x8, #0x5f0]
02cc3518: ldr      x8, [x22, #0x5d8]
02cc351c: ldrsw    x8, [x8, #0xa4]
02cc3520: mov      x9, #0x8ba3
02cc3524: movk     x9, #0xba2e, lsl #16
02cc3528: movk     x9, #0xa2e8, lsl #32
02cc352c: movk     x9, #0x2e8b, lsl #48
02cc3530: umulh    x8, x8, x9
02cc3534: lsr      x0, x8, #4
02cc3538: mov      w1, #8
02cc353c: bl       #0x2ca2ff8
02cc3540: adrp     x8, #0x10a91000
02cc3544: str      x0, [x8, #0x5f8]
02cc3548: ldr      x8, [x22, #0x5d8]
02cc354c: ldrsw    x8, [x8, #0x34]
02cc3550: mov      x9, #0xe38f
02cc3554: movk     x9, #0x8e38, lsl #16
02cc3558: movk     x9, #0x38e3, lsl #32
02cc355c: movk     x9, #0xe38e, lsl #48
02cc3560: umulh    x8, x8, x9
02cc3564: lsr      x0, x8, #5
02cc3568: mov      w1, #8
02cc356c: bl       #0x2ca2ff8
02cc3570: adrp     x8, #0x10a91000
02cc3574: str      x0, [x8, #0x5b8]
02cc3578: ldr      x8, [x20, #0x5c8]
02cc357c: ldrsw    x0, [x8, #0x40]
02cc3580: mov      w1, #8
02cc3584: bl       #0x2ca2ff8
02cc3588: adrp     x8, #0x10a91000
02cc358c: str      x0, [x8, #0x600]
02cc3590: adrp     x0, #0x2cc3000
02cc3594: add      x0, x0, #0x66c
02cc3598: adrp     x1, #0x2cc3000
02cc359c: add      x1, x1, #0x6a8
02cc35a0: bl       #0x2cc35bc
02cc35a4: cmp      x19, #0
02cc35a8: cset     w0, ne
02cc35ac: ldp      x29, x30, [sp, #0x20]
02cc35b0: ldp      x20, x19, [sp, #0x10]
02cc35b4: ldp      x22, x21, [sp], #0x30
02cc35b8: ret      
