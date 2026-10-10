0515df2c  sub      sp, sp, #0x70
0515df30  stp      x28, x27, [sp, #0x10]
0515df34  stp      x26, x25, [sp, #0x20]
0515df38  stp      x24, x23, [sp, #0x30]
0515df3c  stp      x22, x21, [sp, #0x40]
0515df40  stp      x20, x19, [sp, #0x50]
0515df44  stp      x29, x30, [sp, #0x60]
0515df48  add      x29, sp, #0x60
0515df4c  str      w1, [sp, #0xc]
0515df50  mov      x20, x0
0515df54  adrp     x19, #0x10b37000
0515df58  ldrb     w8, [x19, #0xc8d]
0515df5c  tbz      w8, #0, #0x515e134
0515df60  adrp     x19, #0x10b37000
0515df64  ldrb     w8, [x19, #0xc8b]
0515df68  tbz      w8, #0, #0x515e16c
0515df6c  ldr      x8, [x20, #0x18]
0515df70  adds     x0, x8, #0x18
0515df74  b.eq     #0x515e18c
0515df78  ldur     x24, [x20, #0x20]
0515df7c  cbz      x24, #0x515df8c
0515df80  ldr      x8, [x24, #0x10]
0515df84  cmp      x8, x0
0515df88  b.eq     #0x515dfb0
0515df8c  adrp     x8, #0x1062f000
0515df90  ldr      x1, [x8, #0x7d0]
0515df94  bl       #0xce537ec
0515df98  mov      x1, x0
0515df9c  stur     x0, [x20, #0x20]
0515dfa0  add      x0, x20, #0x20
0515dfa4  bl       #0x2c6afb0
0515dfa8  ldur     x24, [x20, #0x20]
0515dfac  cbz      x24, #0x515e19c
0515dfb0  ldr      x8, [x24, #0x18]
0515dfb4  adds     x22, x8, #0x10
0515dfb8  b.eq     #0x515e3bc
0515dfbc  mov      w25, #0
0515dfc0  adrp     x27, #0x1062f000
0515dfc4  adrp     x28, #0x10645000
0515dfc8  adrp     x19, #0x10b3c000
0515dfcc  adrp     x26, #0x10619000
0515dfd0  b        #0x515dfe4
0515dfd4  add      w25, w25, #1
0515dfd8  ldr      x8, [x24, #0x18]
0515dfdc  adds     x22, x8, #0x10
0515dfe0  b.eq     #0x515e3bc
0515dfe4  ldr      x8, [x27, #0x7e0]
0515dfe8  ldur     x21, [x24, #0x20]
0515dfec  cbz      x21, #0x515dffc
0515dff0  ldr      x9, [x21, #0x10]
0515dff4  cmp      x9, x22
0515dff8  b.eq     #0x515e034
0515dffc  ldr      x8, [x8, #0x20]
0515e000  ldr      x0, [x8, #0xc0]
0515e004  mov      w1, #6
0515e008  bl       #0x2c6bf40
0515e00c  mov      x1, x0
0515e010  mov      x0, x22
0515e014  bl       #0x7c0a454
0515e018  mov      x1, x0
0515e01c  stur     x0, [x24, #0x20]
0515e020  add      x0, x24, #0x20
0515e024  bl       #0x2c6afb0
0515e028  ldur     x21, [x24, #0x20]
0515e02c  cbz      x21, #0x515e3d8
0515e030  ldr      x22, [x21, #0x10]
0515e034  ldr      w8, [x22, #0x18]
0515e038  ldr      w9, [x22]
0515e03c  ldr      w10, [x22, #8]
0515e040  sub      w9, w10, w9
0515e044  sdiv     w8, w9, w8
0515e048  cmp      w25, w8
0515e04c  b.ge     #0x515e19c
0515e050  ldr      x8, [x24, #0x18]
0515e054  adds     x23, x8, #0x10
0515e058  b.eq     #0x515e3bc
0515e05c  cmp      x22, x23
0515e060  b.eq     #0x515e09c
0515e064  ldr      x8, [x27, #0x7e0]
0515e068  ldr      x8, [x8, #0x20]
0515e06c  ldr      x0, [x8, #0xc0]
0515e070  mov      w1, #6
0515e074  bl       #0x2c6bf40
0515e078  mov      x1, x0
0515e07c  mov      x0, x23
0515e080  bl       #0x7c0a454
0515e084  mov      x1, x0
0515e088  stur     x0, [x24, #0x20]
0515e08c  add      x0, x24, #0x20
0515e090  bl       #0x2c6afb0
0515e094  ldur     x21, [x24, #0x20]
0515e098  cbz      x21, #0x515e3d8
0515e09c  ldr      x23, [x28, #0x128]
0515e0a0  ldrb     w8, [x19, #0x84]
0515e0a4  tbnz     w8, #0, #0x515e0bc
0515e0a8  adrp     x0, #0x10619000
0515e0ac  add      x0, x0, #0xce0
0515e0b0  bl       #0x2c6b024
0515e0b4  mov      w8, #1
0515e0b8  strb     w8, [x19, #0x84]
0515e0bc  ldr      x8, [x21, #0x10]
0515e0c0  ldr      w9, [x8, #0x18]
0515e0c4  ldr      x8, [x8]
0515e0c8  mul      w9, w9, w25
0515e0cc  ldr      x22, [x8, w9, sxtw]
0515e0d0  cbz      x22, #0x515dfd4
0515e0d4  ldr      x0, [x26, #0xce0]
0515e0d8  ldr      w8, [x0, #0xe0]
0515e0dc  cbnz     w8, #0x515e0e4
0515e0e0  bl       #0x2c6b180
0515e0e4  ldr      x8, [x23, #0x20]
0515e0e8  ldr      x0, [x8, #0xc0]
0515e0ec  mov      w1, #6
0515e0f0  bl       #0x2c6bf40
0515e0f4  mov      x1, x0
0515e0f8  mov      x0, x22
0515e0fc  bl       #0xbf10d48
0515e100  cbz      x0, #0x515dfd4
0515e104  ldr      x8, [x0, #0x10]
0515e108  mov      w9, w8
0515e10c  cmp      x8, #0
0515e110  mov      w8, #-0x22222223
0515e114  ccmp     x9, x8, #4, ne
0515e118  b.eq     #0x515dfd4
0515e11c  ldr      x8, [x0, #0x18]
0515e120  ldr      w8, [x8, #0x44]
0515e124  ldr      w9, [sp, #0xc]
0515e128  cmp      w8, w9
0515e12c  b.ne     #0x515dfd4
0515e130  b        #0x515e39c
0515e134  adrp     x0, #0x1062f000
0515e138  add      x0, x0, #0x7e0
0515e13c  bl       #0x2c6b024
0515e140  adrp     x0, #0x10645000
0515e144  add      x0, x0, #0x120
0515e148  bl       #0x2c6b024
0515e14c  adrp     x0, #0x10645000
0515e150  add      x0, x0, #0x128
0515e154  bl       #0x2c6b024
0515e158  mov      w8, #1
0515e15c  strb     w8, [x19, #0xc8d]
0515e160  adrp     x19, #0x10b37000
0515e164  ldrb     w8, [x19, #0xc8b]
0515e168  tbnz     w8, #0, #0x515df6c
0515e16c  adrp     x0, #0x1062f000
0515e170  add      x0, x0, #0x7d0
0515e174  bl       #0x2c6b024
0515e178  mov      w8, #1
0515e17c  strb     w8, [x19, #0xc8b]
0515e180  ldr      x8, [x20, #0x18]
0515e184  adds     x0, x8, #0x18
0515e188  b.ne     #0x515df78
0515e18c  stur     xzr, [x20, #0x20]
0515e190  add      x0, x20, #0x20
0515e194  mov      x1, #0
0515e198  bl       #0x2c6afb0
0515e19c  adrp     x19, #0x10b37000
0515e1a0  ldrb     w8, [x19, #0xc8c]
0515e1a4  tbnz     w8, #0, #0x515e1bc
0515e1a8  adrp     x0, #0x1062f000
0515e1ac  add      x0, x0, #0x7d0
0515e1b0  bl       #0x2c6b024
0515e1b4  mov      w8, #1
0515e1b8  strb     w8, [x19, #0xc8c]
0515e1bc  ldr      x8, [x20, #0x18]
0515e1c0  adds     x0, x8, #0x50
0515e1c4  b.eq     #0x515e388
0515e1c8  ldur     x23, [x20, #0x28]
0515e1cc  cbz      x23, #0x515e1dc
0515e1d0  ldr      x8, [x23, #0x10]
0515e1d4  cmp      x8, x0
0515e1d8  b.eq     #0x515e200
0515e1dc  adrp     x8, #0x1062f000
0515e1e0  ldr      x1, [x8, #0x7d0]
0515e1e4  bl       #0xce537ec
0515e1e8  mov      x1, x0
0515e1ec  stur     x0, [x20, #0x28]
0515e1f0  add      x0, x20, #0x28
0515e1f4  bl       #0x2c6afb0
0515e1f8  ldur     x23, [x20, #0x28]
0515e1fc  cbz      x23, #0x515e398
0515e200  ldr      x8, [x23, #0x18]
0515e204  adds     x21, x8, #0x10
0515e208  b.eq     #0x515e3c8
0515e20c  mov      w24, #0
0515e210  adrp     x26, #0x1062f000
0515e214  adrp     x19, #0x10645000
0515e218  adrp     x27, #0x10b3c000
0515e21c  adrp     x28, #0x10619000
0515e220  adrp     x20, #0x10619000
0515e224  add      x20, x20, #0xce0
0515e228  b        #0x515e23c
0515e22c  add      w24, w24, #1
0515e230  ldr      x8, [x23, #0x18]
0515e234  adds     x21, x8, #0x10
0515e238  b.eq     #0x515e3c8
0515e23c  ldr      x8, [x26, #0x7e0]
0515e240  ldur     x25, [x23, #0x20]
0515e244  cbz      x25, #0x515e254
0515e248  ldr      x9, [x25, #0x10]
0515e24c  cmp      x9, x21
0515e250  b.eq     #0x515e28c
0515e254  ldr      x8, [x8, #0x20]
0515e258  ldr      x0, [x8, #0xc0]
0515e25c  mov      w1, #6
0515e260  bl       #0x2c6bf40
0515e264  mov      x1, x0
0515e268  mov      x0, x21
0515e26c  bl       #0x7c0a454
0515e270  mov      x1, x0
0515e274  stur     x0, [x23, #0x20]
0515e278  add      x0, x23, #0x20
0515e27c  bl       #0x2c6afb0
0515e280  ldur     x25, [x23, #0x20]
0515e284  cbz      x25, #0x515e3d8
0515e288  ldr      x21, [x25, #0x10]
0515e28c  ldr      w8, [x21, #0x18]
0515e290  ldr      w9, [x21]
0515e294  ldr      w10, [x21, #8]
0515e298  sub      w9, w10, w9
0515e29c  sdiv     w8, w9, w8
0515e2a0  cmp      w24, w8
0515e2a4  b.ge     #0x515e398
0515e2a8  ldr      x8, [x23, #0x18]
0515e2ac  adds     x22, x8, #0x10
0515e2b0  b.eq     #0x515e3c8
0515e2b4  cmp      x21, x22
0515e2b8  b.eq     #0x515e2f4
0515e2bc  ldr      x8, [x26, #0x7e0]
0515e2c0  ldr      x8, [x8, #0x20]
0515e2c4  ldr      x0, [x8, #0xc0]
0515e2c8  mov      w1, #6
0515e2cc  bl       #0x2c6bf40
0515e2d0  mov      x1, x0
0515e2d4  mov      x0, x22
0515e2d8  bl       #0x7c0a454
0515e2dc  mov      x1, x0
0515e2e0  stur     x0, [x23, #0x20]
0515e2e4  add      x0, x23, #0x20
0515e2e8  bl       #0x2c6afb0
0515e2ec  ldur     x25, [x23, #0x20]
0515e2f0  cbz      x25, #0x515e3d8
0515e2f4  ldr      x22, [x19, #0x128]
0515e2f8  ldrb     w8, [x27, #0x84]
0515e2fc  tbnz     w8, #0, #0x515e310
0515e300  mov      x0, x20
0515e304  bl       #0x2c6b024
0515e308  mov      w8, #1
0515e30c  strb     w8, [x27, #0x84]
0515e310  ldr      x8, [x25, #0x10]
0515e314  ldr      w9, [x8, #0x18]
0515e318  ldr      x8, [x8]
0515e31c  mul      w9, w9, w24
0515e320  ldr      x21, [x8, w9, sxtw]
0515e324  cbz      x21, #0x515e22c
0515e328  ldr      x0, [x28, #0xce0]
0515e32c  ldr      w8, [x0, #0xe0]
0515e330  cbnz     w8, #0x515e338
0515e334  bl       #0x2c6b180
0515e338  ldr      x8, [x22, #0x20]
0515e33c  ldr      x0, [x8, #0xc0]
0515e340  mov      w1, #6
0515e344  bl       #0x2c6bf40
0515e348  mov      x1, x0
0515e34c  mov      x0, x21
0515e350  bl       #0xbf10d48
0515e354  cbz      x0, #0x515e22c
0515e358  ldr      x8, [x0, #0x10]
0515e35c  mov      w9, w8
0515e360  cmp      x8, #0
0515e364  mov      w8, #-0x22222223
0515e368  ccmp     x9, x8, #4, ne
0515e36c  b.eq     #0x515e22c
0515e370  ldr      x8, [x0, #0x18]
0515e374  ldr      w8, [x8, #0x44]
0515e378  ldr      w9, [sp, #0xc]
0515e37c  cmp      w8, w9
0515e380  b.ne     #0x515e22c
0515e384  b        #0x515e39c
0515e388  stur     xzr, [x20, #0x28]
0515e38c  add      x0, x20, #0x28
0515e390  mov      x1, #0
0515e394  bl       #0x2c6afb0
0515e398  mov      x0, #0
0515e39c  ldp      x29, x30, [sp, #0x60]
0515e3a0  ldp      x20, x19, [sp, #0x50]
0515e3a4  ldp      x22, x21, [sp, #0x40]
0515e3a8  ldp      x24, x23, [sp, #0x30]
0515e3ac  ldp      x26, x25, [sp, #0x20]
0515e3b0  ldp      x28, x27, [sp, #0x10]
0515e3b4  add      sp, sp, #0x70
0515e3b8  ret      
0515e3bc  stur     xzr, [x24, #0x20]
0515e3c0  add      x0, x24, #0x20
0515e3c4  b        #0x515e3d0
0515e3c8  stur     xzr, [x23, #0x20]
0515e3cc  add      x0, x23, #0x20
0515e3d0  mov      x1, #0
0515e3d4  bl       #0x2c6afb0
0515e3d8  bl       #0x2c6b2d0
