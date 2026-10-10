04ea1310  stp      x20, x19, [sp, #-0x20]!
04ea1314  stp      x29, x30, [sp, #0x10]
04ea1318  add      x29, sp, #0x10
04ea131c  mov      x19, x0
04ea1320  ldr      x8, [x0, #0x18]
04ea1324  adds     x0, x8, #0x168
04ea1328  b.eq     #0x4ea1378
04ea132c  ldur     x8, [x19, #0x28]
04ea1330  cbz      x8, #0x4ea134c
04ea1334  ldr      x9, [x8, #0x10]
04ea1338  mov      w10, w9
04ea133c  cmp      x9, x0
04ea1340  mov      w9, #-0x22222223
04ea1344  ccmp     x10, x9, #4, eq
04ea1348  b.ne     #0x4ea1368
04ea134c  mov      x1, #0
04ea1350  bl       #0x4e7f9a0
04ea1354  mov      x1, x0
04ea1358  stur     x0, [x19, #0x28]
04ea135c  add      x0, x19, #0x28
04ea1360  bl       #0x2c6afb0
04ea1364  ldur     x8, [x19, #0x28]
04ea1368  mov      x0, x8
04ea136c  ldp      x29, x30, [sp, #0x10]
04ea1370  ldp      x20, x19, [sp], #0x20
04ea1374  ret      
04ea1378  stur     xzr, [x19, #0x28]
04ea137c  add      x0, x19, #0x28
04ea1380  mov      x1, #0
04ea1384  bl       #0x2c6afb0
04ea1388  mov      x8, #0
04ea138c  mov      x0, x8
04ea1390  ldp      x29, x30, [sp, #0x10]
04ea1394  ldp      x20, x19, [sp], #0x20
04ea1398  ret      
