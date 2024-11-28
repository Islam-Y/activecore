# -*- coding:utf-8 -*-
from __future__ import division

import udm
from udm import *

udm = udm('COM4', 921600)
print("")

CSR_LED_ADDR    = 0x00000000
CSR_SW_ADDR     = 0x00000004
TESTMEM_ADDR    = 0x80000000

INPUT_ADDR     = 0x00000008
OUTPUT_ADDR    = 0x0000000C


udm.wr32(CSR_LED_ADDR, 0xaa55)
#udm.wr32(CSR_LED_ADDR, 0xb0111111111111110)
print("Conclusion: ", hex(udm.rd32(CSR_SW_ADDR)))
udm.memtest32(TESTMEM_ADDR, 1024)

#udm.wr32(IN_ADDR, 0xfff51428)
udm.wr32(INPUT_ADDR, 0x1234fadc)
#print("Conclusion: ", bin(udm.rd32(OUT_ADDR)))
print("lfsr: ", hex(udm.rd32(OUTPUT_ADDR)))
udm.disconnect()
