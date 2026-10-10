02c6a038: stp      x20, x19, [sp, #-0x20]!
02c6a03c: stp      x29, x30, [sp, #0x10]
02c6a040: add      x29, sp, #0x10
02c6a044: mov      x19, x1
02c6a048: bl       #0x2ca88e4
02c6a04c: ldp      x9, x8, [x0]
02c6a050: sub      x8, x8, x9
02c6a054: asr      x8, x8, #3
02c6a058: str      x8, [x19]
02c6a05c: ldr      x0, [x0]
02c6a060: ldp      x29, x30, [sp, #0x10]
02c6a064: ldp      x20, x19, [sp], #0x20
02c6a068: ret      
