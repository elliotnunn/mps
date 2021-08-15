from random import randint, seed # inclusive interval

seed(2021)

_hex = hex
def hex(n):
    return _hex(n).replace('0x', '$')

def line(t):
    print('    ' + str(t))

def reset():
    global membits, regbits

    membits = ''
    for i in range(256):
        for j in [7,6,5,4,3,2,1,0]:
            if i & (1 << j):
                membits += '1'
            else:
                membits += '0'

    regbits = '10111010110110101111101100011011'

def randbits(n):
    r = ''
    for i in range(n):
        r += str(randint(0, 1))
    return r

def getbits(of_register, start, cnt):
    if of_register:
        return (regbits + regbits)[start % 32:][:cnt]

    else:
        start += 128 * 8
        return membits[start:][:cnt]

def setbits(of_register, start, bitstring):
    global membits, regbits
    if of_register:
        regbits = list(regbits)
        for idx, bit in enumerate(bitstring, start):
            regbits[idx % 32] = bit
        regbits = ''.join(regbits)

    else:
        membits = list(membits)
        for idx, bit in enumerate(bitstring, start + 128 * 8):
            membits[idx] = bit
        membits = ''.join(membits)

print('''    include 'Header.a'

    machine 68020
''')

WIDTHS = [1, 2, 32]

for su in ['u', 's']:
    for memIsReg in [False, True]:
        for offsetIsReg in [False, True]:
            for widthIsReg in [False, True]:
                for width in WIDTHS:
                    reset()

                    if offsetIsReg:
                        offset = randint(-128*8, 124*8)
                    else:
                        offset = randint(0, 31)

                    if memIsReg:
                        eaDesc = 'dn'
                        ea = 'd7'
                    else:
                        eaDesc = 'ea'
                        ea = '(a4)'

                    longaddr = offset >> 3
                    longaddr -= longaddr % 4

                    oldbits = getbits(memIsReg, offset, width)

                    z = int('1' not in oldbits)
                    n = int(oldbits.startswith('1'))

                    if su == 's':
                        oldbits = oldbits.rjust(32, oldbits[0])

                    if offsetIsReg:
                        offsetString = 'd3'
                        actualOffsetString = '#' + hex(offset)
                        offsetDesc = 'dn=rand'
                    else:
                        offsetString = str(offset)
                        offsetDesc = 'rand'

                    if widthIsReg:
                        widthString = 'd4'
                        actualWidthString = '#%' + randbits(32-5) + '00000+' + str(width)
                        widthDesc = 'dn=rand+' + str(width)
                    else:
                        widthString = str(width)
                        widthDesc = str(width)

                    line(f"StartOfTest 'bfext{su} {eaDesc}{{{offsetDesc}:{widthDesc}}},dn'")
                    line(f"bsr     ResetTestMemory")
                    if offsetIsReg:
                        line(f"move.l  {actualOffsetString},d3 ; offset")
                    if widthIsReg:
                        line(f"move.l  {actualWidthString},d4 ; width")
                    line(f"bfext{su}  {ea}{{{offsetString}:{widthString}}},d2")
                    line(f"n{n}")
                    line(f"z{z}")
                    line(f"v0")
                    line(f"c0")
                    line(f"cmp.l   #%{oldbits},d2")
                    line(f"z1")
                    line(f"EndOfTest")
                    print()

for memIsReg in [False, True]:
    for offsetIsReg in [False, True]:
        for widthIsReg in [False, True]:
            for width in WIDTHS:
                reset()

                if offsetIsReg:
                    offset = randint(-128*8, 124*8)
                else:
                    offset = randint(0, 31)

                if memIsReg:
                    eaDesc = 'dn'
                    ea = 'd7'
                else:
                    eaDesc = 'ea'
                    ea = '(a4)'

                content = randbits(32)
                realcontent = content[-width:]

                longaddr = offset >> 3
                longaddr -= longaddr % 4

                oldbits = getbits(memIsReg, offset, width)
                setbits(memIsReg, offset, realcontent)

                z = int('1' not in realcontent)
                n = int(realcontent.startswith('1'))

                if offsetIsReg:
                    offsetString = 'd3'
                    actualOffsetString = '#' + hex(offset)
                    offsetDesc = 'dn=rand'
                else:
                    offsetString = str(offset)
                    offsetDesc = 'rand'

                if widthIsReg:
                    widthString = 'd4'
                    actualWidthString = '#%' + randbits(32-5) + '00000+' + str(width)
                    widthDesc = 'dn=rand+' + str(width)
                else:
                    widthString = str(width)
                    widthDesc = str(width)

                line(f"StartOfTest 'bfins dn=rand,{eaDesc}{{{offsetDesc}:{widthDesc}}}'")
                line(f"bsr     ResetTestMemory")
                line(f"move.l  #%{content},d2")
                if offsetIsReg:
                    line(f"move.l  {actualOffsetString},d3 ; offset")
                if widthIsReg:
                    line(f"move.l  {actualWidthString},d4 ; width")
                line(f"bfins   d2,{ea}{{{offsetString}:{widthString}}}")
                line(f"n{n}")
                line(f"z{z}")
                line(f"v0")
                line(f"c0")
                if memIsReg:
                    line(f"cmp.l   #%{regbits},{ea}")
                    line(f"z1")
                else:
                    line(f"cmp.l   #%{getbits(memIsReg, longaddr * 8, 32)},{hex(longaddr)}(a4)")
                    line(f"z1")
                    line(f"cmp.l   #%{getbits(memIsReg, (longaddr + 4) * 8, 32)},{hex(longaddr + 4)}(a4)")
                    line(f"z1")
                line(f"EndOfTest")
                print()

for unary in ['bftst', 'bfchg', 'bfclr', 'bfset']:
    for memIsReg in [False, True]:
        for offsetIsReg in [False, True]:
            for widthIsReg in [False, True]:
                for width in WIDTHS:
                    reset()

                    if offsetIsReg:
                        offset = randint(-128*8, 124*8)
                    else:
                        offset = randint(0, 31)

                    if memIsReg:
                        eaDesc = 'dn'
                        ea = 'd7'
                    else:
                        eaDesc = 'ea'
                        ea = '(a4)'

                    content = randbits(32)
                    realcontent = content[-width:]

                    longaddr = offset >> 3
                    longaddr -= longaddr % 4

                    oldbits = getbits(memIsReg, offset, width)

                    if unary == 'bfchg':
                        setbits(memIsReg, offset, oldbits.replace('1', '.').replace('0', '1').replace('.', '0'))
                    elif unary == 'bfset':
                        setbits(memIsReg, offset, '1' * len(oldbits))
                    elif unary == 'bfclr':
                        setbits(memIsReg, offset, '0' * len(oldbits))

                    z = int('1' not in oldbits)
                    n = int(oldbits.startswith('1'))

                    if offsetIsReg:
                        offsetString = 'd3'
                        actualOffsetString = '#' + hex(offset)
                        offsetDesc = 'dn=rand'
                    else:
                        offsetString = str(offset)
                        offsetDesc = 'rand'

                    if widthIsReg:
                        widthString = 'd4'
                        actualWidthString = '#%' + randbits(32-5) + '00000+' + str(width)
                        widthDesc = 'dn=rand+' + str(width)
                    else:
                        widthString = str(width)
                        widthDesc = str(width)

                    line(f"StartOfTest '{unary} {eaDesc}{{{offsetDesc}:{widthDesc}}}'")
                    line(f"bsr     ResetTestMemory")
                    if offsetIsReg:
                        line(f"move.l  {actualOffsetString},d3 ; offset")
                    if widthIsReg:
                        line(f"move.l  {actualWidthString},d4 ; width")
                    line(f"{unary}   {ea}{{{offsetString}:{widthString}}}")
                    line(f"n{n}")
                    line(f"z{z}")
                    line(f"v0")
                    line(f"c0")
                    if memIsReg:
                        line(f"cmp.l   #%{regbits},{ea}")
                        line(f"z1")
                    else:
                        line(f"cmp.l   #%{getbits(memIsReg, longaddr * 8, 32)},{hex(longaddr)}(a4)")
                        line(f"z1")
                        line(f"cmp.l   #%{getbits(memIsReg, (longaddr + 4) * 8, 32)},{hex(longaddr + 4)}(a4)")
                        line(f"z1")
                    line(f"EndOfTest")
                    print()


for memIsReg in [False, True]:
    for offsetIsReg in [False, True]:
        for widthIsReg in [False, True]:
            for width in WIDTHS:
                reset()

                if offsetIsReg:
                    offset = randint(-128*8, 124*8)
                else:
                    offset = randint(0, 31)

                if memIsReg:
                    eaDesc = 'dn'
                    ea = 'd7'
                else:
                    eaDesc = 'ea'
                    ea = '(a4)'

                longaddr = offset >> 3
                longaddr -= longaddr % 4

                oldbits = getbits(memIsReg, offset, width)

                fo = oldbits.find('1')
                if fo == -1: fo = len(oldbits)

                fo += offset

                z = int('1' not in oldbits)
                n = int(oldbits.startswith('1'))

                if offsetIsReg:
                    offsetString = 'd3'
                    actualOffsetString = '#' + hex(offset)
                    offsetDesc = 'dn=rand'
                else:
                    offsetString = str(offset)
                    offsetDesc = 'rand'

                if widthIsReg:
                    widthString = 'd4'
                    actualWidthString = '#%' + randbits(32-5) + '00000+' + str(width)
                    widthDesc = 'dn=rand+' + str(width)
                else:
                    widthString = str(width)
                    widthDesc = str(width)

                line(f"StartOfTest 'bfffo  {eaDesc}{{{offsetDesc}:{widthDesc}}},dn'")
                line(f"bsr     ResetTestMemory")
                if offsetIsReg:
                    line(f"move.l  {actualOffsetString},d3 ; offset")
                if widthIsReg:
                    line(f"move.l  {actualWidthString},d4 ; width")
                line(f"bfffo  {ea}{{{offsetString}:{widthString}}},d2")
                line(f"n{n}")
                line(f"z{z}")
                line(f"v0")
                line(f"c0")
                line(f"cmp.l   #{hex(fo)},d2")
                line(f"z1")
                line(f"EndOfTest")
                print()

reset()

print(f'''    PrintPlan
    rts

ResetTestMemory
    move.l  #%{regbits},d7
    move.l  a5,a4
    move.w  #255,d0
fillLoop
    move.b  d0,-(a4)
    dbra    d0,fillLoop
    lea     -128(a5),a4
    rts''')
