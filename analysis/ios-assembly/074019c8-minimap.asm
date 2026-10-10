; Ordinary-map scalar branch only; extracted locally from the exact UUID/SHA input.
074019c8: ldp      s1, s4, [x20, #0x44]
074019cc: fmul     s0, s0, s1
074019d0: fmul     s1, s2, s4
074019d4: cbz      w19, #0x7401a04
074019d8: ldp      s2, s4, [x20, #0x64]
074019dc: fneg     s5, s2
074019e0: fcmp     s0, s2
074019e4: fcsel    s2, s2, s0, gt
074019e8: fcmp     s0, s5
074019ec: fcsel    s0, s5, s2, mi
074019f0: fneg     s2, s4
074019f4: fcmp     s1, s4
074019f8: fcsel    s4, s4, s1, gt
074019fc: fcmp     s1, s2
07401a00: fcsel    s1, s2, s4, mi
