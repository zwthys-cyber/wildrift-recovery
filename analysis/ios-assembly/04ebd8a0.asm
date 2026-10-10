04ebd8a0  stp      x24, x23, [sp, #-0x40]!
04ebd8a4  stp      x22, x21, [sp, #0x10]
04ebd8a8  stp      x20, x19, [sp, #0x20]
04ebd8ac  stp      x29, x30, [sp, #0x30]
04ebd8b0  add      x29, sp, #0x30
04ebd8b4  mov      x19, x1
04ebd8b8  mov      x20, x0
04ebd8bc  adrp     x21, #0x10b37000
04ebd8c0  ldrb     w8, [x21, #0xbc2]
04ebd8c4  tbz      w8, #0, #0x4ebda64
04ebd8c8  adrp     x21, #0x10b37000
04ebd8cc  ldrb     w8, [x21, #0xbbd]
04ebd8d0  tbz      w8, #0, #0x4ebda9c
04ebd8d4  ldr      x8, [x20, #0x18]
04ebd8d8  adds     x0, x8, #0x208
04ebd8dc  b.eq     #0x4ebdabc
04ebd8e0  ldur     x22, [x20, #0xf8]
04ebd8e4  cbz      x22, #0x4ebd8f4
04ebd8e8  ldr      x8, [x22, #0x10]
04ebd8ec  cmp      x8, x0
04ebd8f0  b.eq     #0x4ebd914
04ebd8f4  adrp     x8, #0x1062f000
04ebd8f8  ldr      x1, [x8, #0x7d0]
04ebd8fc  bl       #0xce537ec
04ebd900  mov      x1, x0
04ebd904  stur     x0, [x20, #0xf8]
04ebd908  add      x0, x20, #0xf8
04ebd90c  bl       #0x2c6afb0
04ebd910  ldur     x22, [x20, #0xf8]
04ebd914  tbnz     w19, #0x1f, #0x4ebdacc
04ebd918  cbz      x22, #0x4ebdacc
04ebd91c  ldr      x8, [x22, #0x18]
04ebd920  adds     x20, x8, #0x10
04ebd924  b.eq     #0x4ebdae4
04ebd928  adrp     x23, #0x1062f000
04ebd92c  ldr      x8, [x23, #0x7e0]
04ebd930  ldur     x24, [x22, #0x20]
04ebd934  cbz      x24, #0x4ebd944
04ebd938  ldr      x9, [x24, #0x10]
04ebd93c  cmp      x9, x20
04ebd940  b.eq     #0x4ebd97c
04ebd944  ldr      x8, [x8, #0x20]
04ebd948  ldr      x0, [x8, #0xc0]
04ebd94c  mov      w1, #6
04ebd950  bl       #0x2c6bf40
04ebd954  mov      x1, x0
04ebd958  mov      x0, x20
04ebd95c  bl       #0x7c0a454
04ebd960  mov      x1, x0
04ebd964  stur     x0, [x22, #0x20]
04ebd968  add      x0, x22, #0x20
04ebd96c  bl       #0x2c6afb0
04ebd970  ldur     x24, [x22, #0x20]
04ebd974  cbz      x24, #0x4ebdaf4
04ebd978  ldr      x20, [x24, #0x10]
04ebd97c  ldr      w8, [x20, #0x18]
04ebd980  ldr      w9, [x20]
04ebd984  ldr      w10, [x20, #8]
04ebd988  sub      w9, w10, w9
04ebd98c  sdiv     w8, w9, w8
04ebd990  cmp      w8, w19
04ebd994  b.le     #0x4ebdacc
04ebd998  ldr      x8, [x22, #0x18]
04ebd99c  adds     x21, x8, #0x10
04ebd9a0  b.eq     #0x4ebdae4
04ebd9a4  cmp      x20, x21
04ebd9a8  b.eq     #0x4ebd9e4
04ebd9ac  ldr      x8, [x23, #0x7e0]
04ebd9b0  ldr      x8, [x8, #0x20]
04ebd9b4  ldr      x0, [x8, #0xc0]
04ebd9b8  mov      w1, #6
04ebd9bc  bl       #0x2c6bf40
04ebd9c0  mov      x1, x0
04ebd9c4  mov      x0, x21
04ebd9c8  bl       #0x7c0a454
04ebd9cc  mov      x1, x0
04ebd9d0  stur     x0, [x22, #0x20]
04ebd9d4  add      x0, x22, #0x20
04ebd9d8  bl       #0x2c6afb0
04ebd9dc  ldur     x24, [x22, #0x20]
04ebd9e0  cbz      x24, #0x4ebdaf4
04ebd9e4  adrp     x8, #0x10645000
04ebd9e8  ldr      x20, [x8, #0x128]
04ebd9ec  adrp     x21, #0x10b3c000
04ebd9f0  ldrb     w8, [x21, #0x84]
04ebd9f4  tbnz     w8, #0, #0x4ebda0c
04ebd9f8  adrp     x0, #0x10619000
04ebd9fc  add      x0, x0, #0xce0
04ebda00  bl       #0x2c6b024
04ebda04  mov      w8, #1
04ebda08  strb     w8, [x21, #0x84]
04ebda0c  ldr      x8, [x24, #0x10]
04ebda10  ldr      w9, [x8, #0x18]
04ebda14  ldr      x8, [x8]
04ebda18  mul      w9, w9, w19
04ebda1c  ldr      x19, [x8, w9, sxtw]
04ebda20  cbz      x19, #0x4ebdacc
04ebda24  adrp     x8, #0x10619000
04ebda28  ldr      x0, [x8, #0xce0]
04ebda2c  ldr      w8, [x0, #0xe0]
04ebda30  cbnz     w8, #0x4ebda38
04ebda34  bl       #0x2c6b180
04ebda38  ldr      x8, [x20, #0x20]
04ebda3c  ldr      x0, [x8, #0xc0]
04ebda40  mov      w1, #6
04ebda44  bl       #0x2c6bf40
04ebda48  mov      x1, x0
04ebda4c  mov      x0, x19
04ebda50  ldp      x29, x30, [sp, #0x30]
04ebda54  ldp      x20, x19, [sp, #0x20]
04ebda58  ldp      x22, x21, [sp, #0x10]
04ebda5c  ldp      x24, x23, [sp], #0x40
04ebda60  b        #0xbf10d48
04ebda64  adrp     x0, #0x1062f000
04ebda68  add      x0, x0, #0x7e0
04ebda6c  bl       #0x2c6b024
04ebda70  adrp     x0, #0x10645000
04ebda74  add      x0, x0, #0x120
04ebda78  bl       #0x2c6b024
04ebda7c  adrp     x0, #0x10645000
04ebda80  add      x0, x0, #0x128
04ebda84  bl       #0x2c6b024
04ebda88  mov      w8, #1
04ebda8c  strb     w8, [x21, #0xbc2]
04ebda90  adrp     x21, #0x10b37000
04ebda94  ldrb     w8, [x21, #0xbbd]
04ebda98  tbnz     w8, #0, #0x4ebd8d4
04ebda9c  adrp     x0, #0x1062f000
04ebdaa0  add      x0, x0, #0x7d0
04ebdaa4  bl       #0x2c6b024
04ebdaa8  mov      w8, #1
04ebdaac  strb     w8, [x21, #0xbbd]
04ebdab0  ldr      x8, [x20, #0x18]
04ebdab4  adds     x0, x8, #0x208
04ebdab8  b.ne     #0x4ebd8e0
04ebdabc  stur     xzr, [x20, #0xf8]
04ebdac0  add      x0, x20, #0xf8
04ebdac4  mov      x1, #0
04ebdac8  bl       #0x2c6afb0
04ebdacc  mov      x0, #0
04ebdad0  ldp      x29, x30, [sp, #0x30]
04ebdad4  ldp      x20, x19, [sp, #0x20]
04ebdad8  ldp      x22, x21, [sp, #0x10]
04ebdadc  ldp      x24, x23, [sp], #0x40
04ebdae0  ret      
04ebdae4  stur     xzr, [x22, #0x20]
04ebdae8  add      x0, x22, #0x20
04ebdaec  mov      x1, #0
04ebdaf0  bl       #0x2c6afb0
04ebdaf4  bl       #0x2c6b2d0
