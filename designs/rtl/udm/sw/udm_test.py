# -*- coding:utf-8 -*-
from __future__ import division

import udm
from udm import *

import time

udm = udm('COM3', 921600)
print("")

CSR_LED_ADDR    = 0x00000000
CSR_SW_ADDR     = 0x00000004
TESTMEM_ADDR    = 0x80000000

INPUT_ADDR     = 0x00000008
OUTPUT_ADDR    = 0x0000000C
START_ADDR     = 0x00000010
BUSY_ADDR      = 0x00000014
RESET_ADDR     = 0x00000018


udm.wr32(RESET_ADDR, 0x1)
time.sleep(1)
udm.wr32(RESET_ADDR, 0x0)

udm.wr32(INPUT_ADDR, 0x1234fadc)

time.sleep(0.1)
udm.wr32(START_ADDR, 0x1)
time.sleep(0.25)
udm.wr32(START_ADDR, 0x0)

while udm.rd32(BUSY_ADDR) == 1:
    time.sleep(0.1)

print("lfsr: ", hex(udm.rd32(OUTPUT_ADDR)))
udm.disconnect()


#__________________________________________________________________________


# # -*- coding:utf-8 -*-
# from __future__ import division

# import udm
# from udm import *

# udm = udm('COM4', 921600)
# print("")

# CSR_LED_ADDR    = 0x00000000
# CSR_SW_ADDR     = 0x00000004
# TESTMEM_ADDR    = 0x80000000

# INPUT_ADDR     = 0x00000008
# OUTPUT_ADDR    = 0x0000000C

# udm.wr32(INPUT_ADDR, 0x1234fadc)
# print("lfsr: ", hex(udm.rd32(OUTPUT_ADDR)))
# udm.disconnect()