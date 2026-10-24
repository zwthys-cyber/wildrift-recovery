; Selected original UnityFramework instructions, UUID B59675EA-20A7-306E-97FF-5EA41A2B36C6
05df5c70: ldr      x0, [x19, #0x1c8]
05df5c74: cbz      x0, #0x5df67d4
05df5c78: ldr      x8, [x0, #0x18]
05df5c7c: ldr      x8, [x8, #0x68]
05df5c80: tbnz     x8, #0x2d, #0x5df5d18
05df5c84: lsr      x8, x8, #0xe
05df5c88: cmp      w21, w8
05df5c8c: b.le     #0x5df5d18
05df5c90: mov      x1, #0
05df5c94: bl       #0x3b09950
05df5c98: cbz      x0, #0x5df67d4
05df5c9c: ldr      x8, [x0, #0x18]
05df5ca0: ldr      w8, [x8, #0x74]
05df5ca4: cmp      w8, #4
05deec4c: ldr      x8, [x19, #0x60]
05deec50: cbz      x8, #0x5def194
05deec54: ldr      x8, [x8, #0x18]
05deec58: ldr      x24, [x8, #0x68]
05deec5c: adrp     x22, #0xed5e000
05deec60: ldr      x0, [x22, #0x5a0]
05deec64: ldr      w8, [x0, #0xe0]
05deec68: cbnz     w8, #0x5deec74
05deec6c: bl       #0x172b3a8
05deec70: ldr      x0, [x22, #0x5a0]
05deec74: ldr      x8, [x0, #0xb8]
05deec78: ldr      s0, [x8, #0x188]
05deec7c: scvtf    s1, x24
05deec80: fmul     s8, s0, s1
05deec84: fcmp     s8, #0.0
05deec88: b.le     #0x5deebd4
05deec8c: ldr      s0, [x19, #0x88]
05deec90: fcmp     s8, s0
05deec94: b.hi     #0x5deebd4
03b0821c: ldr      x8, [x0, #0x18]
03b08220: ldr      x0, [x8, #0x68]
03b08224: ret      
03b0a33c: ldr      x8, [x0, #0x18]
03b0a340: ldr      x8, [x8, #0x68]
03b0a344: lsr      x0, x8, #0xe
03b0a348: ret      
03c93cf8: ldr      x8, [x0, #0x18]
03c93cfc: ldr      w0, [x8, #0x1a0]
03c93d00: ret      
03c93d04: ldr      x8, [x0, #0x18]
03c93d08: ldr      w0, [x8, #0x1a4]
03c93d0c: ret      
03c93c5c: ldr      x9, [x0, #0x18]
03c93c60: add      x10, x9, #0x128
03c93c64: ldr      x9, [x9, #0x138]
03c93c68: str      x9, [x8, #0x10]
03c93c6c: ldr      q0, [x10]
03c93c70: str      q0, [x8]
03c93c74: ret      
