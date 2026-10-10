00448118: sub      sp, sp, #0x40
0044811c: stp      x29, x30, [sp, #0x20]
00448120: stp      x20, x19, [sp, #0x30]
00448124: add      x29, sp, #0x20
00448128: mrs      x20, tpidr_el0
0044812c: adrp     x9, #0x562000
00448130: adrp     x10, #0x563000
00448134: ldr      x8, [x20, #0x28]
00448138: ldr      x9, [x9, #0xfa0]
0044813c: mov      x19, x0
00448140: stur     x8, [x29, #-8]
00448144: adrp     x8, #0x563000
00448148: ldr      x8, [x8, #0x130]
0044814c: strb     wzr, [x0, #0x400]
00448150: ldr      x10, [x10, #0x1a8]
00448154: stp      x9, x8, [sp]
00448158: adrp     x8, #0x59f000
0044815c: add      x8, x8, #0x850
00448160: str      x10, [sp, #0x10]
00448164: ldarb    w8, [x8]
00448168: tbz      w8, #0, #0x4481e4
0044816c: adrp     x9, #0x59f000
00448170: add      x9, x9, #0x738
00448174: ldr      x8, [x9, #0x30]
00448178: cbz      x8, #0x4481ac
0044817c: ldr      x9, [x9]
00448180: cbz      x9, #0x4481ac
00448184: mov      x0, x19
00448188: blr      x8
0044818c: adrp     x8, #0x59f000
00448190: mov      x0, x19
00448194: mov      x1, x19
00448198: ldr      x8, [x8, #0x738]
0044819c: blr      x8
004481a0: mov      w8, #1
004481a4: strb     w8, [x19, #0x400]
004481a8: b        #0x4481c4
004481ac: adrp     x1, #0x20000
004481b0: add      x1, x1, #0xdd3
004481b4: adrp     x2, #0x28000
004481b8: add      x2, x2, #0x70f ; '[-] SurfaceComposerClient is unavailable'
004481bc: mov      w0, #6
004481c0: bl       #0x554b10 ; __android_log_print
004481c4: ldr      x8, [x20, #0x28]
004481c8: ldur     x9, [x29, #-8]
004481cc: cmp      x8, x9
004481d0: b.ne     #0x44823c
004481d4: ldp      x20, x19, [sp, #0x30]
004481d8: ldp      x29, x30, [sp, #0x20]
004481dc: add      sp, sp, #0x40
004481e0: ret      
004481e4: adrp     x0, #0x59f000
004481e8: add      x0, x0, #0x850
004481ec: bl       #0x533d48
004481f0: cbz      w0, #0x44816c
004481f4: adrp     x0, #0x59f000
004481f8: add      x0, x0, #0x730
004481fc: mov      x1, sp
00448200: bl       #0x448240
00448204: adrp     x0, #0x59f000
00448208: add      x0, x0, #0x850
0044820c: bl       #0x533e78
00448210: b        #0x44816c
00448214: mov      x19, x0
00448218: adrp     x0, #0x59f000
0044821c: add      x0, x0, #0x850
00448220: bl       #0x533f20
00448224: ldr      x8, [x20, #0x28]
00448228: ldur     x9, [x29, #-8]
0044822c: cmp      x8, x9
00448230: b.ne     #0x44823c
00448234: mov      x0, x19
00448238: bl       #0x54fffc
0044823c: bl       #0x553f00 ; __stack_chk_fail
