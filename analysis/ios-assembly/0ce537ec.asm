0ce537ec  sub      sp, sp, #0x40
0ce537f0  stp      x22, x21, [sp, #0x10]
0ce537f4  stp      x20, x19, [sp, #0x20]
0ce537f8  stp      x29, x30, [sp, #0x30]
0ce537fc  add      x29, sp, #0x30
0ce53800  mov      x20, x1
0ce53804  mov      x19, x0
0ce53808  adrp     x21, #0x10ac1000
0ce5380c  ldrb     w8, [x21, #0x492]
0ce53810  tbz      w8, #0, #0xce53890
0ce53814  str      xzr, [sp, #8]
0ce53818  ldr      x0, [x20, #0x20]
0ce5381c  add      x8, x0, #0x135
0ce53820  ldrh     w8, [x8]
0ce53824  tbz      w8, #0, #0xce53900
0ce53828  ldr      x0, [x0, #0xc0]
0ce5382c  mov      w1, #1
0ce53830  bl       #0x7c0bdb8
0ce53834  ldr      x8, [x0, #0xb8]
0ce53838  ldr      x8, [x8]
0ce5383c  cbz      x8, #0xce5391c
0ce53840  cbz      x19, #0xce539c0
0ce53844  mov      w8, #-0x22222223
0ce53848  cmp      w19, w8
0ce5384c  b.ne     #0xce539dc
0ce53850  adrp     x8, #0x1061c000
0ce53854  ldr      x0, [x8, #0x5b0]
0ce53858  ldr      w8, [x0, #0xe0]
0ce5385c  cbnz     w8, #0xce53864
0ce53860  bl       #0x7c0bcf0
0ce53864  adrp     x8, #0x1071b000
0ce53868  ldr      x0, [x8, #0x70]
0ce5386c  mov      x1, #0
0ce53870  bl       #0x98461e4
0ce53874  mov      x21, #0
0ce53878  mov      x0, x21
0ce5387c  ldp      x29, x30, [sp, #0x30]
0ce53880  ldp      x20, x19, [sp, #0x20]
0ce53884  ldp      x22, x21, [sp, #0x10]
0ce53888  add      sp, sp, #0x40
0ce5388c  ret      
0ce53890  adrp     x0, #0x10637000
0ce53894  add      x0, x0, #0xc30
0ce53898  bl       #0x7c0bcac
0ce5389c  adrp     x0, #0x10637000
0ce538a0  add      x0, x0, #0xc38
0ce538a4  bl       #0x7c0bcac
0ce538a8  adrp     x0, #0x10637000
0ce538ac  add      x0, x0, #0xc10
0ce538b0  bl       #0x7c0bcac
0ce538b4  adrp     x0, #0x105e7000
0ce538b8  add      x0, x0, #0xbf8
0ce538bc  bl       #0x7c0bcac
0ce538c0  adrp     x0, #0x1065b000
0ce538c4  add      x0, x0, #0x878
0ce538c8  bl       #0x7c0bcac
0ce538cc  adrp     x0, #0x1061c000
0ce538d0  add      x0, x0, #0x5b0
0ce538d4  bl       #0x7c0bcac
0ce538d8  adrp     x0, #0x1071b000
0ce538dc  add      x0, x0, #0x70
0ce538e0  bl       #0x7c0bcac
0ce538e4  mov      w8, #1
0ce538e8  strb     w8, [x21, #0x492]
0ce538ec  str      xzr, [sp, #8]
0ce538f0  ldr      x0, [x20, #0x20]
0ce538f4  add      x8, x0, #0x135
0ce538f8  ldrh     w8, [x8]
0ce538fc  tbnz     w8, #0, #0xce53828
0ce53900  bl       #0x7c0c4b4
0ce53904  ldr      x0, [x0, #0xc0]
0ce53908  mov      w1, #1
0ce5390c  bl       #0x7c0bdb8
0ce53910  ldr      x8, [x0, #0xb8]
0ce53914  ldr      x8, [x8]
0ce53918  cbnz     x8, #0xce53840
0ce5391c  adrp     x8, #0x105e7000
0ce53920  ldr      x0, [x8, #0xbf8]
0ce53924  bl       #0x7c0bd0c
0ce53928  mov      x21, x0
0ce5392c  adrp     x8, #0x10637000
0ce53930  ldr      x8, [x8, #0xc10]
0ce53934  ldr      x8, [x8, #0x20]
0ce53938  ldr      x0, [x8, #0xc0]
0ce5393c  mov      w1, #0
0ce53940  bl       #0x7c0bdc4
0ce53944  ldr      x8, [x0, #0x20]
0ce53948  ldr      x0, [x8, #0xc0]
0ce5394c  mov      w1, #3
0ce53950  bl       #0x7c0bdc4
0ce53954  bl       #0xbd1a034
0ce53958  cbz      x0, #0xce5396c
0ce5395c  mov      x0, x21
0ce53960  str      xzr, [x0, #0x30]!
0ce53964  mov      x1, #0
0ce53968  bl       #0x7c0bc80
0ce5396c  ldr      x0, [x20, #0x20]
0ce53970  add      x8, x0, #0x135
0ce53974  ldrh     w8, [x8]
0ce53978  tbnz     w8, #0, #0xce53980
0ce5397c  bl       #0x7c0c4b4
0ce53980  ldr      x0, [x0, #0xc0]
0ce53984  mov      w1, #1
0ce53988  bl       #0x7c0bdb8
0ce5398c  ldr      x8, [x0, #0xb8]
0ce53990  str      x21, [x8]
0ce53994  ldr      x0, [x20, #0x20]
0ce53998  ldrb     w8, [x0, #0x135]
0ce5399c  tbnz     w8, #0, #0xce539a4
0ce539a0  bl       #0x7c0c4b4
0ce539a4  ldr      x0, [x0, #0xc0]
0ce539a8  mov      w1, #1
0ce539ac  bl       #0x7c0bdb8
0ce539b0  ldr      x0, [x0, #0xb8]
0ce539b4  mov      x1, x21
0ce539b8  bl       #0x7c0bc80
0ce539bc  cbnz     x19, #0xce53844
0ce539c0  mov      x21, #0
0ce539c4  mov      x0, x21
0ce539c8  ldp      x29, x30, [sp, #0x30]
0ce539cc  ldp      x20, x19, [sp, #0x20]
0ce539d0  ldp      x22, x21, [sp, #0x10]
0ce539d4  add      sp, sp, #0x40
0ce539d8  ret      
0ce539dc  ldr      x0, [x20, #0x20]
0ce539e0  add      x8, x0, #0x135
0ce539e4  ldrh     w8, [x8]
0ce539e8  tbnz     w8, #0, #0xce539f0
0ce539ec  bl       #0x7c0c4b4
0ce539f0  ldr      x0, [x0, #0xc0]
0ce539f4  mov      w1, #1
0ce539f8  bl       #0x7c0bdb8
0ce539fc  ldr      x8, [x0, #0xb8]
0ce53a00  ldr      x21, [x8]
0ce53a04  cbz      x21, #0xce53c3c
0ce53a08  adrp     x8, #0x10637000
0ce53a0c  ldr      x8, [x8, #0xc30]
0ce53a10  ldr      x8, [x8, #0x20]
0ce53a14  ldr      x0, [x8, #0xc0]
0ce53a18  mov      w1, #0x1f
0ce53a1c  bl       #0x7c0bdc4
0ce53a20  mov      x2, x0
0ce53a24  mov      x0, x21
0ce53a28  mov      x1, x19
0ce53a2c  bl       #0xcfe0cb8
0ce53a30  tbnz     w0, #0x1f, #0xce53a98
0ce53a34  ldr      x8, [x21, #0x18]
0ce53a38  cbz      x8, #0xce53c3c
0ce53a3c  ldr      w9, [x8, #0x18]
0ce53a40  cmp      w0, w9
0ce53a44  b.hs     #0xce53c40
0ce53a48  mov      w9, #0x18
0ce53a4c  umaddl   x8, w0, w9, x8
0ce53a50  ldr      x1, [x8, #0x30]
0ce53a54  str      x1, [sp, #8]
0ce53a58  add      x0, sp, #8
0ce53a5c  bl       #0x7c0bc80
0ce53a60  ldr      x21, [sp, #8]
0ce53a64  ldr      x0, [x20, #0x20]
0ce53a68  add      x8, x0, #0x135
0ce53a6c  ldrh     w8, [x8]
0ce53a70  tbnz     w8, #0, #0xce53a78
0ce53a74  bl       #0x7c0c4b4
0ce53a78  ldr      x0, [x0, #0xc0]
0ce53a7c  mov      w1, #0
0ce53a80  bl       #0x7c0bdb8
0ce53a84  cbz      x21, #0xce53a9c
0ce53a88  ldr      x8, [x21]
0ce53a8c  cmp      x8, x0
0ce53a90  b.ne     #0xce53a9c
0ce53a94  b        #0xce53878
0ce53a98  str      xzr, [sp, #8]
0ce53a9c  ldr      x0, [x20, #0x20]
0ce53aa0  add      x8, x0, #0x135
0ce53aa4  ldrh     w8, [x8]
0ce53aa8  tbnz     w8, #0, #0xce53ab0
0ce53aac  bl       #0x7c0c4b4
0ce53ab0  ldr      x0, [x0, #0xc0]
0ce53ab4  mov      w1, #1
0ce53ab8  bl       #0x7c0bdb8
0ce53abc  ldr      x8, [x0, #0xb8]
0ce53ac0  ldr      x8, [x8, #8]
0ce53ac4  cbz      x8, #0xce53bcc
0ce53ac8  ldr      x0, [x20, #0x20]
0ce53acc  add      x8, x0, #0x135
0ce53ad0  ldrh     w8, [x8]
0ce53ad4  tbnz     w8, #0, #0xce53adc
0ce53ad8  bl       #0x7c0c4b4
0ce53adc  ldr      x0, [x0, #0xc0]
0ce53ae0  mov      w1, #1
0ce53ae4  bl       #0x7c0bdb8
0ce53ae8  ldr      x8, [x0, #0xb8]
0ce53aec  ldr      x8, [x8, #8]
0ce53af0  cbz      x8, #0xce53c3c
0ce53af4  ldr      w8, [x8, #0x18]
0ce53af8  cmp      w8, #1
0ce53afc  b.lt     #0xce53bcc
0ce53b00  ldr      x0, [x20, #0x20]
0ce53b04  add      x8, x0, #0x135
0ce53b08  ldrh     w8, [x8]
0ce53b0c  tbnz     w8, #0, #0xce53b14
0ce53b10  bl       #0x7c0c4b4
0ce53b14  ldr      x0, [x0, #0xc0]
0ce53b18  mov      w1, #1
0ce53b1c  bl       #0x7c0bdb8
0ce53b20  ldr      x8, [x0, #0xb8]
0ce53b24  ldr      x0, [x8, #8]
0ce53b28  cbz      x0, #0xce53c3c
0ce53b2c  adrp     x8, #0x1065b000
0ce53b30  ldr      x1, [x8, #0x878]
0ce53b34  bl       #0xca107e4
0ce53b38  mov      x21, x0
0ce53b3c  ldr      x0, [x20, #0x20]
0ce53b40  add      x8, x0, #0x135
0ce53b44  ldrh     w8, [x8]
0ce53b48  tbnz     w8, #0, #0xce53b50
0ce53b4c  bl       #0x7c0c4b4
0ce53b50  ldr      x0, [x0, #0xc0]
0ce53b54  mov      w1, #0
0ce53b58  bl       #0x7c0bdb8
0ce53b5c  cbz      x21, #0xce53c3c
0ce53b60  ldr      x8, [x21]
0ce53b64  cmp      x8, x0
0ce53b68  b.ne     #0xce53c3c
0ce53b6c  stp      x19, x19, [x21, #0x10]
0ce53b70  ldr      x0, [x20, #0x20]
0ce53b74  add      x8, x0, #0x135
0ce53b78  ldrh     w8, [x8]
0ce53b7c  tbnz     w8, #0, #0xce53b84
0ce53b80  bl       #0x7c0c4b4
0ce53b84  ldr      x0, [x0, #0xc0]
0ce53b88  mov      w1, #1
0ce53b8c  bl       #0x7c0bdb8
0ce53b90  ldr      x8, [x0, #0xb8]
0ce53b94  ldr      x0, [x8]
0ce53b98  cbz      x0, #0xce53c3c
0ce53b9c  adrp     x8, #0x10637000
0ce53ba0  ldr      x4, [x8, #0xc38]
0ce53ba4  mov      x1, x19
0ce53ba8  mov      x2, x21
0ce53bac  mov      w3, #1
0ce53bb0  bl       #0xcfe10b4
0ce53bb4  mov      x0, x21
0ce53bb8  ldp      x29, x30, [sp, #0x30]
0ce53bbc  ldp      x20, x19, [sp, #0x20]
0ce53bc0  ldp      x22, x21, [sp, #0x10]
0ce53bc4  add      sp, sp, #0x40
0ce53bc8  ret      
0ce53bcc  ldr      x0, [x20, #0x20]
0ce53bd0  add      x8, x0, #0x135
0ce53bd4  ldrh     w8, [x8]
0ce53bd8  tbnz     w8, #0, #0xce53be0
0ce53bdc  bl       #0x7c0c4b4
0ce53be0  ldr      x0, [x0, #0xc0]
0ce53be4  mov      w1, #0
0ce53be8  bl       #0x7c0bdb8
0ce53bec  bl       #0x7c0bd0c
0ce53bf0  mov      x21, x0
0ce53bf4  ldr      x0, [x20, #0x20]
0ce53bf8  add      x8, x0, #0x135
0ce53bfc  ldrh     w8, [x8]
0ce53c00  tbnz     w8, #0, #0xce53c08
0ce53c04  bl       #0x7c0c4b4
0ce53c08  ldr      x0, [x0, #0xc0]
0ce53c0c  mov      w1, #4
0ce53c10  bl       #0x7c0bdc4
0ce53c14  mov      x2, x0
0ce53c18  mov      x0, x21
0ce53c1c  mov      x1, x19
0ce53c20  bl       #0xce53c44
0ce53c24  mov      x0, x21
0ce53c28  ldp      x29, x30, [sp, #0x30]
0ce53c2c  ldp      x20, x19, [sp, #0x20]
0ce53c30  ldp      x22, x21, [sp, #0x10]
0ce53c34  add      sp, sp, #0x40
0ce53c38  ret      
0ce53c3c  bl       #0x7c0bd18
0ce53c40  bl       #0x7c0bd1c
