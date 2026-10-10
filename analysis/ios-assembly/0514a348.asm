0514a348: ldr x8, [x0, #0x18]
0514a34c: ldr w8, [x8, #0x18]
0514a350: mov w9, #0x50
0514a354: and w8, w8, w9
0514a358: cmp w8, #0x40
0514a35c: cset w0, eq
0514a360: ret 
