04ed1f94  stp      x22, x21, [sp, #-0x30]!
04ed1f98  stp      x20, x19, [sp, #0x10]
04ed1f9c  stp      x29, x30, [sp, #0x20]
04ed1fa0  add      x29, sp, #0x20
04ed1fa4  mov      x19, x0
04ed1fa8  adrp     x20, #0x10b37000
04ed1fac  ldrb     w8, [x20, #0xbdd]
04ed1fb0  tbnz     w8, #0, #0x4ed1fc8
04ed1fb4  adrp     x0, #0x10604000
04ed1fb8  add      x0, x0, #0x8c0
04ed1fbc  bl       #0x2c6b024
04ed1fc0  mov      w8, #1
04ed1fc4  strb     w8, [x20, #0xbdd]
04ed1fc8  ldr      x8, [x19, #0x18]
04ed1fcc  adds     x0, x8, #0x420
04ed1fd0  b.eq     #0x4ed2248
04ed1fd4  mov      w20, #-0x22222223
04ed1fd8  ldur     x21, [x19, #0x60]
04ed1fdc  cbz      x21, #0x4ed1ff4
04ed1fe0  ldr      x8, [x21, #0x10]
04ed1fe4  mov      w9, w8
04ed1fe8  cmp      x8, x0
04ed1fec  ccmp     x9, x20, #4, eq
04ed1ff0  b.ne     #0x4ed2014
04ed1ff4  mov      x1, #0
04ed1ff8  bl       #0x512d290
04ed1ffc  mov      x1, x0
04ed2000  stur     x0, [x19, #0x60]
04ed2004  add      x0, x19, #0x60
04ed2008  bl       #0x2c6afb0
04ed200c  ldur     x21, [x19, #0x60]
04ed2010  cbz      x21, #0x4ed2258
04ed2014  ldr      x8, [x21, #0x18]
04ed2018  ldr      x0, [x8, #0x20]
04ed201c  cbz      x0, #0x4ed21dc
04ed2020  ldur     x8, [x21, #0x28]
04ed2024  cbz      x8, #0x4ed203c
04ed2028  ldr      x8, [x8, #0x10]
04ed202c  mov      w9, w8
04ed2030  cmp      x8, x0
04ed2034  ccmp     x9, x20, #4, eq
04ed2038  b.ne     #0x4ed205c
04ed203c  bl       #0x512c6c4
04ed2040  mov      x1, x0
04ed2044  stur     x0, [x21, #0x28]
04ed2048  add      x0, x21, #0x28
04ed204c  bl       #0x2c6afb0
04ed2050  ldur     x8, [x21, #0x28]
04ed2054  cbz      x8, #0x4ed21ec
04ed2058  ldr      x0, [x8, #0x10]
04ed205c  mov      w8, w0
04ed2060  cmp      x0, #0
04ed2064  ccmp     x8, x20, #4, ne
04ed2068  b.eq     #0x4ed21ec
04ed206c  ldr      x8, [x19, #0x18]
04ed2070  adds     x0, x8, #0x420
04ed2074  b.eq     #0x4ed2248
04ed2078  ldur     x21, [x19, #0x60]
04ed207c  cbz      x21, #0x4ed2098
04ed2080  ldr      x8, [x21, #0x10]
04ed2084  cmp      x8, x0
04ed2088  b.ne     #0x4ed2098
04ed208c  mov      w8, w8
04ed2090  cmp      x8, x20
04ed2094  b.ne     #0x4ed20b8
04ed2098  mov      x1, #0
04ed209c  bl       #0x512d290
04ed20a0  mov      x1, x0
04ed20a4  stur     x0, [x19, #0x60]
04ed20a8  add      x0, x19, #0x60
04ed20ac  bl       #0x2c6afb0
04ed20b0  ldur     x21, [x19, #0x60]
04ed20b4  cbz      x21, #0x4ed2258
04ed20b8  ldr      x8, [x21, #0x18]
04ed20bc  ldr      x0, [x8, #0x20]
04ed20c0  cbz      x0, #0x4ed225c
04ed20c4  ldur     x8, [x21, #0x28]
04ed20c8  cbz      x8, #0x4ed20e4
04ed20cc  ldr      x9, [x8, #0x10]
04ed20d0  cmp      x9, x0
04ed20d4  b.ne     #0x4ed20e4
04ed20d8  mov      w9, w9
04ed20dc  cmp      x9, x20
04ed20e0  b.ne     #0x4ed2100
04ed20e4  bl       #0x512c6c4
04ed20e8  mov      x1, x0
04ed20ec  stur     x0, [x21, #0x28]
04ed20f0  add      x0, x21, #0x28
04ed20f4  bl       #0x2c6afb0
04ed20f8  ldur     x8, [x21, #0x28]
04ed20fc  cbz      x8, #0x4ed2258
04ed2100  ldr      x8, [x8, #0x18]
04ed2104  ldrb     w9, [x8, #0x18]
04ed2108  adrp     x21, #0x10604000
04ed210c  ldr      x0, [x21, #0x8c0]
04ed2110  cbnz     w9, #0x4ed2220
04ed2114  ldr      x22, [x8, #0x20]
04ed2118  ldr      w8, [x0, #0xe0]
04ed211c  cbz      w8, #0x4ed2208
04ed2120  ldr      x8, [x0, #0xb8]
04ed2124  ldr      x8, [x8, #0x18]
04ed2128  cmp      x22, x8
04ed212c  b.le     #0x4ed2220
04ed2130  ldr      x8, [x19, #0x18]
04ed2134  adds     x0, x8, #0x420
04ed2138  b.eq     #0x4ed2248
04ed213c  ldur     x21, [x19, #0x60]
04ed2140  cbz      x21, #0x4ed215c
04ed2144  ldr      x8, [x21, #0x10]
04ed2148  cmp      x8, x0
04ed214c  b.ne     #0x4ed215c
04ed2150  mov      w8, w8
04ed2154  cmp      x8, x20
04ed2158  b.ne     #0x4ed217c
04ed215c  mov      x1, #0
04ed2160  bl       #0x512d290
04ed2164  mov      x1, x0
04ed2168  stur     x0, [x19, #0x60]
04ed216c  add      x0, x19, #0x60
04ed2170  bl       #0x2c6afb0
04ed2174  ldur     x21, [x19, #0x60]
04ed2178  cbz      x21, #0x4ed2258
04ed217c  ldr      x8, [x21, #0x18]
04ed2180  ldr      x0, [x8, #0x20]
04ed2184  cbz      x0, #0x4ed225c
04ed2188  ldur     x8, [x21, #0x28]
04ed218c  cbz      x8, #0x4ed21a8
04ed2190  ldr      x9, [x8, #0x10]
04ed2194  cmp      x9, x0
04ed2198  b.ne     #0x4ed21a8
04ed219c  mov      w9, w9
04ed21a0  cmp      x9, x20
04ed21a4  b.ne     #0x4ed21c4
04ed21a8  bl       #0x512c6c4
04ed21ac  mov      x1, x0
04ed21b0  stur     x0, [x21, #0x28]
04ed21b4  add      x0, x21, #0x28
04ed21b8  bl       #0x2c6afb0
04ed21bc  ldur     x8, [x21, #0x28]
04ed21c0  cbz      x8, #0x4ed2258
04ed21c4  ldr      x8, [x8, #0x18]
04ed21c8  ldr      x0, [x8, #0x20]!
04ed21cc  ldp      x29, x30, [sp, #0x20]
04ed21d0  ldp      x20, x19, [sp, #0x10]
04ed21d4  ldp      x22, x21, [sp], #0x30
04ed21d8  ret      
04ed21dc  stur     xzr, [x21, #0x28]
04ed21e0  add      x0, x21, #0x28
04ed21e4  mov      x1, #0
04ed21e8  bl       #0x2c6afb0
04ed21ec  adrp     x19, #0x10604000
04ed21f0  ldr      x0, [x19, #0x8c0]
04ed21f4  ldr      w8, [x0, #0xe0]
04ed21f8  cbnz     w8, #0x4ed2230
04ed21fc  bl       #0x2c6b180
04ed2200  ldr      x0, [x19, #0x8c0]
04ed2204  b        #0x4ed2230
04ed2208  bl       #0x2c6b180
04ed220c  ldr      x0, [x21, #0x8c0]
04ed2210  ldr      x8, [x0, #0xb8]
04ed2214  ldr      x8, [x8, #0x18]
04ed2218  cmp      x22, x8
04ed221c  b.gt     #0x4ed2130
04ed2220  ldr      w8, [x0, #0xe0]
04ed2224  cbnz     w8, #0x4ed2230
04ed2228  bl       #0x2c6b180
04ed222c  ldr      x0, [x21, #0x8c0]
04ed2230  ldr      x8, [x0, #0xb8]
04ed2234  ldr      x0, [x8, #0x18]!
04ed2238  ldp      x29, x30, [sp, #0x20]
04ed223c  ldp      x20, x19, [sp, #0x10]
04ed2240  ldp      x22, x21, [sp], #0x30
04ed2244  ret      
04ed2248  stur     xzr, [x19, #0x60]
04ed224c  add      x0, x19, #0x60
04ed2250  mov      x1, #0
04ed2254  bl       #0x2c6afb0
04ed2258  bl       #0x2c6b2d0
04ed225c  stur     xzr, [x21, #0x28]
04ed2260  add      x0, x21, #0x28
04ed2264  b        #0x4ed2250
