from itertools import product
from random import randint, seed # inclusive interval

seed(2021)

_hex = hex
def hex(n):
    return _hex(n).replace('0x', '$')

def line(t):
    print('    ' + str(t).rstrip())

longs = [0x80000000, 0x7fffffff, 3, 1, 0]
doubles = [
    0x8000000000000000,
    0x7fffffffffffffff,
    0x0000000080000000,
    3, 1, 0,
]

line("include 'Header.a'")
line("machine 68020")
line('')

for dividend, divisor, signed, keepremain in product(longs, longs, [False, True], [False, True]):
    if divisor == 0: continue # no point testing that

    inst = 'div'
    inst += 's' if signed else 'u'
    if keepremain: inst += 'l'
    inst += '.l'

    infoLine = f"StartOfTest '{inst} #{hex(divisor)},dn={hex(dividend)}'"
    if keepremain:
        infoLine = infoLine.replace(',', ',dn:')

    line(infoLine)

    line(f"move.l  #{hex(dividend)},d3")

    divLine = f"{inst.ljust(7)} #{hex(divisor)},d3"

    if keepremain:
        line("clr.l   d4")
        divLine = divLine.replace(',', ',d4:')

    line("move    #$f,ccr")
    line(divLine)

    if signed:
        if divisor & 0x80000000: divisor -= 0x100000000
        if dividend & 0x80000000: dividend -= 0x100000000

    quotient = abs(dividend) // abs(divisor)
    if dividend < 0: quotient = -quotient
    if divisor < 0: quotient = -quotient
    remainder = abs(dividend) % abs(divisor)
    if dividend < 0: remainder = -remainder

    quotient &= 0xffffffff
    remainder &= 0xffffffff

    line("n" + str(int(quotient & 0x80000000 != 0)))
    line("z" + str(int(quotient == 0)))
    line("v0")
    line("c0")

    line(f"cmpi.l  #{hex(quotient)},d3 ; quotient")
    line("z1")

    if keepremain:
        line(f"cmpi.l  #{hex(remainder)},d4 ; remainder")
        line("z1")

    line("EndOfTest")
    line("")

for dividend, divisor, signed in product(doubles, longs, [False, True]):
    if divisor == 0: continue # no point testing that

    inst = 'div'
    inst += 's' if signed else 'u'
    inst += '.l'

    line(f"StartOfTest '{inst} #{hex(divisor)},dn={hex(dividend >> 32)}:dn={hex(dividend & 0xffffffff)}'")
    line(f"move.l  #{hex(dividend >> 32)},d4")
    line(f"move.l  #{hex(dividend & 0xffffffff)},d3")

    divLine = f"{inst.ljust(7)} #{hex(divisor)},d4:d3"

    line("move    #$f,ccr")
    line(divLine)

    if signed:
        if divisor & 0x80000000: divisor -= 0x100000000
        if dividend & 0x8000000000000000: dividend -= 0x10000000000000000

    quotient = abs(dividend) // abs(divisor)
    if dividend < 0: quotient = -quotient
    if divisor < 0: quotient = -quotient
    remainder = abs(dividend) % abs(divisor)
    if dividend < 0: remainder = -remainder

    if signed:
        v = not (-0x80000000 <= quotient <= 0x7fffffff)
    else:
        v = not (0 <= quotient <= 0xffffffff)

    quotient &= 0xffffffff
    remainder &= 0xffffffff

    if v:
        line("; n and z undefined due to overflow")
    else:
        line("n" + str(int(quotient & 0x80000000 != 0)))
        line("z" + str(int(quotient == 0)))
    line(f"v{v:d}")
    line("c0")

    if v:
        line(f"cmpi.l  #{hex(dividend & 0xffffffff)},d3 ; unchanged due to overflow")
        line("z1")

        line(f"cmpi.l  #{hex(dividend >> 32)},d4 ; unchanged due to overflow")
        line("z1")
    else:
        line(f"cmpi.l  #{hex(quotient)},d3 ; quotient")
        line("z1")

        line(f"cmpi.l  #{hex(remainder)},d4 ; remainder")
        line("z1")

    line("EndOfTest")
    line("")



line("PrintPlan")
line("rts")
