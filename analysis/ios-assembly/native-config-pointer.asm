; Selected getter evidence from exact FEProj UUID/SHA input; no game code is invoked.
00d03e60: adrp     x8, #0x523c000
00d03e64: add      x8, x8, #0xf28
00d03e68: ldr      x8, [x8]
00d03e6c: cbz      x8, #0xd03e7c
00d03e70: ldr      x0, [x8, #0x18]
00d03e74: cbz      x0, #0xd03e7c
00d03e78: ret      
00d03e7c: mov      x0, #0
00d03e80: ret      
