00422284: stp      x29, x30, [sp, #-0x50]!
00422288: str      x28, [sp, #0x10]
0042228c: stp      x24, x23, [sp, #0x20]
00422290: stp      x22, x21, [sp, #0x30]
00422294: stp      x20, x19, [sp, #0x40]
00422298: mov      x29, sp
0042229c: sub      sp, sp, #0x4d0
004222a0: movi     v0.2d, #0000000000000000
004222a4: mrs      x22, tpidr_el0
004222a8: mov      x19, x1
004222ac: ldr      x8, [x22, #0x28]
004222b0: mov      x20, x0
004222b4: stur     x8, [x29, #-8]
004222b8: stp      q0, q0, [sp]
004222bc: stp      q0, q0, [sp, #0x20]
004222c0: stp      q0, q0, [sp, #0x40]
004222c4: stp      q0, q0, [sp, #0x60]
004222c8: cbz      x1, #0x422308
004222cc: adrp     x3, #0x25000
004222d0: add      x3, x3, #0xdc7
004222d4: mov      x0, sp
004222d8: mov      w1, #0x80
004222dc: mov      w2, #0x80
004222e0: mov      x4, x19
004222e4: bl       #0x41dd88
004222e8: adrp     x1, #0x27000
004222ec: add      x1, x1, #0x38b
004222f0: mov      x0, sp
004222f4: bl       #0x554220 ; strstr
004222f8: cbz      x0, #0x422308
004222fc: mov      w23, #1
00422300: strb     wzr, [x0]
00422304: b        #0x42230c
00422308: mov      w23, wzr
0042230c: ldrb     w8, [sp]
00422310: ldrb     w9, [x20, #0xc]
00422314: cmp      w8, #0
00422318: mov      x8, sp
0042231c: csel     x19, x19, x8, eq
00422320: cbz      w9, #0x422330
00422324: adrp     x8, #0x59f000
00422328: ldr      w4, [x8, #0x194]
0042232c: b        #0x422334
00422330: ldr      w4, [x20, #8]
00422334: adrp     x3, #0x25000
00422338: add      x3, x3, #0x3f8 ; '/proc/%d/maps'
0042233c: sub      x0, x29, #0x48
00422340: mov      w1, #0x40
00422344: mov      w2, #0x40
00422348: bl       #0x41dd88
0042234c: adrp     x1, #0x28000
00422350: add      x1, x1, #0x989
00422354: sub      x0, x29, #0x48
00422358: bl       #0x5540c0 ; fopen
0042235c: cbz      x0, #0x4223cc
00422360: mov      x20, x0
00422364: mov      w24, wzr
00422368: adrp     x21, #0x2a000
0042236c: add      x21, x21, #0x941
00422370: b        #0x422394
00422374: add      x0, sp, #0x88
00422378: mov      x1, x19
0042237c: bl       #0x554220 ; strstr
00422380: cmp      x0, #0
00422384: cset     w8, ne
00422388: csinc    w9, w23, wzr, ne
0042238c: orr      w24, w8, w24
00422390: tbz      w9, #0, #0x4223d4
00422394: add      x0, sp, #0x88
00422398: mov      w1, #0x400
0042239c: mov      x2, x20
004223a0: bl       #0x553f90 ; fgets
004223a4: cbz      x0, #0x4223ec
004223a8: and      w8, w23, w24
004223ac: cmp      w8, #1
004223b0: b.ne     #0x422374
004223b4: add      x0, sp, #0x88
004223b8: mov      x1, x21
004223bc: bl       #0x554220 ; strstr
004223c0: cbnz     x0, #0x4223d4
004223c4: mov      w24, wzr
004223c8: b        #0x422374
004223cc: mov      x19, xzr
004223d0: b        #0x4223f8
004223d4: add      x0, sp, #0x88
004223d8: mov      x1, xzr
004223dc: mov      w2, #0x10
004223e0: bl       #0x5549d0 ; strtoul
004223e4: mov      x19, x0
004223e8: b        #0x4223f0
004223ec: mov      x19, xzr
004223f0: mov      x0, x20
004223f4: bl       #0x5540d0 ; fclose
004223f8: ldr      x8, [x22, #0x28]
004223fc: ldur     x9, [x29, #-8]
00422400: cmp      x8, x9
00422404: b.ne     #0x422428
00422408: mov      x0, x19
0042240c: add      sp, sp, #0x4d0
00422410: ldp      x20, x19, [sp, #0x40]
00422414: ldr      x28, [sp, #0x10]
00422418: ldp      x22, x21, [sp, #0x30]
0042241c: ldp      x24, x23, [sp, #0x20]
00422420: ldp      x29, x30, [sp], #0x50
00422424: ret      
00422428: bl       #0x553f00 ; __stack_chk_fail
