00440620: stp      x29, x30, [sp, #-0x40]!
00440624: stp      x28, x23, [sp, #0x10]
00440628: stp      x22, x21, [sp, #0x20]
0044062c: stp      x20, x19, [sp, #0x30]
00440630: mov      x29, sp
00440634: sub      sp, sp, #0x550
00440638: mrs      x22, tpidr_el0
0044063c: mov      w20, w0
00440640: mov      x0, xzr
00440644: ldr      x8, [x22, #0x28]
00440648: cmp      w20, #1
0044064c: stur     x8, [x29, #-8]
00440650: b.lt     #0x4407ac
00440654: mov      x4, x1
00440658: cbz      x1, #0x4407ac
0044065c: ldrb     w8, [x4]
00440660: cbz      w8, #0x4407a8
00440664: movi     v0.2d, #0000000000000000
00440668: adrp     x3, #0x25000
0044066c: add      x3, x3, #0xdc7
00440670: add      x0, sp, #0x440
00440674: mov      w1, #0x100
00440678: mov      w2, #0x100
0044067c: str      q0, [sp, #0x530]
00440680: str      q0, [sp, #0x520]
00440684: str      q0, [sp, #0x510]
00440688: str      q0, [sp, #0x500]
0044068c: str      q0, [sp, #0x4f0]
00440690: str      q0, [sp, #0x4e0]
00440694: str      q0, [sp, #0x4d0]
00440698: str      q0, [sp, #0x4c0]
0044069c: str      q0, [sp, #0x4b0]
004406a0: str      q0, [sp, #0x4a0]
004406a4: str      q0, [sp, #0x490]
004406a8: str      q0, [sp, #0x480]
004406ac: str      q0, [sp, #0x470]
004406b0: str      q0, [sp, #0x460]
004406b4: str      q0, [sp, #0x450]
004406b8: str      q0, [sp, #0x440]
004406bc: bl       #0x41dd88
004406c0: adrp     x1, #0x27000
004406c4: add      x1, x1, #0x38b
004406c8: add      x0, sp, #0x440
004406cc: bl       #0x554220 ; strstr
004406d0: mov      x19, x0
004406d4: cbz      x0, #0x4406dc
004406d8: strb     wzr, [x19]
004406dc: adrp     x3, #0x25000
004406e0: add      x3, x3, #0x3f8 ; '/proc/%d/maps'
004406e4: add      x0, sp, #0x400
004406e8: mov      w1, #0x40
004406ec: mov      w2, #0x40
004406f0: mov      w4, w20
004406f4: bl       #0x41dd88
004406f8: adrp     x1, #0x28000
004406fc: add      x1, x1, #0x989
00440700: add      x0, sp, #0x400
00440704: bl       #0x5540c0 ; fopen
00440708: cbz      x0, #0x4407ac
0044070c: mov      x20, x0
00440710: mov      w23, wzr
00440714: adrp     x21, #0x2a000
00440718: add      x21, x21, #0x941
0044071c: mov      x0, sp
00440720: mov      w1, #0x400
00440724: mov      x2, x20
00440728: bl       #0x553f90 ; fgets
0044072c: cbz      x0, #0x4407a0
00440730: cmp      x19, #0
00440734: cset     w8, ne
00440738: and      w8, w8, w23
0044073c: cmp      w8, #1
00440740: b.ne     #0x440758
00440744: mov      x0, sp
00440748: mov      x1, x21
0044074c: bl       #0x554220 ; strstr
00440750: cbnz     x0, #0x440778
00440754: mov      w23, wzr
00440758: mov      x0, sp
0044075c: add      x1, sp, #0x440
00440760: bl       #0x554220 ; strstr
00440764: cmp      x0, #0
00440768: cset     w8, ne
0044076c: orr      w23, w8, w23
00440770: cbnz     x19, #0x44071c
00440774: cbz      x0, #0x44071c
00440778: mov      x0, sp
0044077c: mov      x1, xzr
00440780: mov      w2, #0x10
00440784: bl       #0x5541b0 ; strtoull
00440788: mov      x19, x0
0044078c: mov      x0, x20
00440790: bl       #0x5540d0 ; fclose
00440794: cmp      x19, #8, lsl #12
00440798: csel     x0, xzr, x19, eq
0044079c: b        #0x4407ac
004407a0: mov      x0, x20
004407a4: bl       #0x5540d0 ; fclose
004407a8: mov      x0, xzr
004407ac: ldr      x8, [x22, #0x28]
004407b0: ldur     x9, [x29, #-8]
004407b4: cmp      x8, x9
004407b8: b.ne     #0x4407d4
004407bc: add      sp, sp, #0x550
004407c0: ldp      x20, x19, [sp, #0x30]
004407c4: ldp      x22, x21, [sp, #0x20]
004407c8: ldp      x28, x23, [sp, #0x10]
004407cc: ldp      x29, x30, [sp], #0x40
004407d0: ret      
004407d4: bl       #0x553f00 ; __stack_chk_fail
