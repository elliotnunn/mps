package main

import (
	"fmt"
	"io/ioutil"
    "math/bits"
    "regexp"
    "os"
)

//#######################################################################
// 68000 interpreter: minimal user-mode implementation
//
// Notes {
// - all "sizes" are in bytes
// - mem is a bytearray, which must be populated from outside the block
// - minimise direct access to the mem bytearray, preferring read()/write()
// - define lineA(), lineF(), check_for_lurkers() somewhere outside this block
//#######################################################################

// Emulator state: set to something better than this before running
var pc uint32
var x, n, z, v, c bool
var mem []byte

// Where in memory the registers are kept
const (
    regs = 0x80000
    d0ptr = regs
    d1ptr = regs + 4
    d2ptr = regs + 8
    d3ptr = regs + 12
    d4ptr = regs + 16
    d5ptr = regs + 20
    d6ptr = regs + 24
    d7ptr = regs + 28
    a0ptr = a0ptr
    a1ptr = regs + 36
    a2ptr = regs + 40
    a3ptr = regs + 44
    a4ptr = regs + 48
    a5ptr = regs + 52
    a6ptr = regs + 56
    spptr = regs + 60
)

func read(numbytes int, addr uint32) (val uint32) {
    for i := range numbytes {
        val <<= 8
        val += mem[addr+i]
    }
}

func readl(addr uint32) (val uint32) {
    return (uint32(mem[addr]) << 24) | (uint32(mem[addr+1]) << 16) | (uint32(mem[addr+2]) << 8) | uint32(mem[addr+3])
}

func readw(addr uint32) (val uint16) {
    return (uint16(mem[addr]) << 8) | uint16(mem[addr+1])
}

func readb(addr uint32) (val uint8) {
    return uint8(mem[addr])
}

func write(numbytes int, addr uint32, val uint32) {
    for i := range numbytes {
        mem[addr+i] = byte(val)
        val >>= 8
    }
}

func writel(addr uint32, val uint32) {
    mem[addr] = byte(val >> 24)
    mem[addr+1] = byte(val >> 16)
    mem[addr+2] = byte(val >> 8)
    mem[addr+3] = byte(val)
}

func writew(addr uint32, val uint16) {
    mem[addr] = byte(val >> 8)
    mem[addr+1] = byte(val)
}

func writeb(addr uint32, val uint8) {
    mem[addr] = byte(val >> 8)
    mem[addr+1] = byte(val)
}

func push(size int, data uint32) {
    ptr := address_by_mode(39, size) // -(A7)
    write(size, ptr, data)
}

func pushl(val uint32) {
    ptr := readl(spptr) - 4
    writel(spptr, ptr)
    writel(ptr, val)
}

func pushw(val uint16) {
    ptr := readl(spptr) - 2
    writel(spptr, ptr)
    writew(ptr, val)
}

func pushb(val uint8) {
    ptr := readl(spptr) - 2
    writel(spptr, ptr)
    writeb(ptr + 1, 0)
    writeb(ptr, val)
}

func pop(size int) uint32 {
    ptr := address_by_mode(31, size) // (A7)+
    return read(size, ptr)
}

func popl() {
    ptr := readl(spptr)
    writel(spptr, ptr + 4)
    return readl(ptr)
}

func popw() {
    ptr := readl(spptr)
    writel(spptr, ptr + 2)
    return readw(ptr)
}

func popb() {
    ptr := readl(spptr)
    writel(spptr, ptr + 2)
    return readb(ptr)
}

func readRegs() (reglist [16]uint32) {
    copy(reglist[:], mem[regs:])
}

func writeRegs(reglist [16]uint32, which ...[]uint32) {
    for _, which := range which {
        copy(mem[which:][:4], reglist[which-regs:])
    }
}

func signed(size int, n uint32) int32 {
    shift := 32 - (8 * size)
    return (int32(n) << shift) >> shift
}

func add_then_set_vc(a uint32, b uint32, size int) (result uint32) {
    result = a + b
    signbit = 1 << ((size * 8) - 1)
    v = (a & signbit) == (b & signbit) != (result & signbit)
    c = result < a // could use result < b just as easily
}

func sub_then_set_vc(a uint32, b uint32, size int) { // subtract b from a
    result = a - b
    signbit = 1 << ((size * 8) - 1)
    v = (a & signbit) == (b & signbit) != (result & signbit)
    c = a < b
}

func set_nz(num uint32, size int) {
//    global n, z
    bitsize = size * 8
    n = bool(num & (1 << (bitsize - 1)))
    z = num == 0
}

func get_ccr() (ccr uint32) {
    for shift, value := range []bool{c, v, z, n, x} {
        if value {
            ccr |= (1 << shift)
        }
    }
}

func set_ccr(to_byte uint32) {
    x = to_byte & 16 != 0
    n = to_byte & 8 != 0
    z = to_byte & 4 != 0
    v = to_byte & 2 != 0
    c = to_byte & 1 != 0
}

func readsize(encoded int) {
    retval := 1 << encoded
    if retval == 8 {
        panic("illegal size")
    }
}

func address_by_mode(mode, size) (ptr uint32) { // mode given by bottom 6 bits
    // side effects: predecrement/postincrement, advance pc to get extension word

    if mode < 16 { // Dn or An -- optimise common case slightly
        ptr = regs + (mode & 15) * 4 + 4 - size
    } else if mode >> 3 == 2 { // (An)
        ptr = readl(a0ptr + (mode & 7) * 4)
    } else if mode >> 3 == 3 { // (An)+
        regptr = a0ptr + (mode & 7) * 4
        ptr = readl(regptr)
        newptr = ptr + size
        if mode & 7 == 7 && size == 1 {
            newptr += 1
        }
        writel(regptr, newptr)
    } else if mode >> 3 == 4 { // -(An)
        regptr = a0ptr + (mode & 7) * 4
        ptr = readl(regptr)
        ptr -= size
        if mode & 7 == 7 && size == 1 {
            ptr--
        }
        writel(regptr, ptr)
    } else if mode >> 3 == 5 { // d16(An)
        regptr = a0ptr + (mode & 7) * 4
        ptr = readl(regptr) + signed(2, readw(pc)); pc += 2
    } else if mode >> 3 == 6 { // d8(An,Xn)
        ptr = a0ptr + (mode & 7) * 4
        ptr = readl(ptr) // get An

        xreg = readb(pc); pc++
        xofs = signed(1, readb(pc)); pc++
        whichreg = regs + (xreg >> 4) * 4 // could be D or A
        if xreg & 8 {
            rofs = signed(4, readl(whichreg))
        } else {
            rofs = signed(2, readw(whichreg + 2))
        }
        ptr += xofs + rofs
    } else if mode == 58 { // d16(PC)
        ptr = pc + signed(2, readw(pc)); pc += 2
    } else if mode == 59 { // d8(PC,Xn)
        ptr = pc
        xreg = readb(pc); pc++
        xofs = signed(1, readb(pc)); pc++
        whichreg = regs + (xreg >> 4) * 4 // could be D or A
        if xreg & 8 {
            rofs = signed(4, readl(whichreg))
        } else {
            rofs = signed(2, readw(whichreg + 2))
        }
        ptr += xofs + rofs
    } else if mode == 56 { // abs.W
        ptr = readw(pc); pc += 2
    } else if mode == 57 { // abs.L
        ptr = readl(pc); pc += 4
    } else if mode == 60 { // #imm
        if size == 1 {
            ptr = pc + 1; pc += 2
        } else if size == 2 {
            ptr = pc; pc += 2
        } else if size == 4 {
            ptr = pc; pc += 4
        }
    } else {
        panic("reserved addressing mode")
    }
}

func test_condition(int cond) bool {
    if cond == 0 { // T true
        return true
    } else if cond == 1 { // F false
        return false
    } else if cond == 2 { // HI higher than
        return !(c || z)
    } else if cond == 3 { // LS lower or same
        return c || z
    } else if cond == 4 { // CC carry clear aka HS
        return !c
    } else if cond == 5 { // CS carry set aka LS
        return c
    } else if cond == 6 { // NE not equal
        return !z
    } else if cond == 7 { // EQ equal
        return z
    } else if cond == 8 { // VC overflow clear
        return !v
    } else if cond == 9 { // VS overflow set
        return v
    } else if cond == 10 { // PL plus
        return !n
    } else if cond == 11 { // MI minus
        return n
    } else if cond == 12 { // GE greater or equal
        return n == v
    } else if cond == 13 { // LT less than
        return !(n == v)
    } else if cond == 14 { // GT greater than
        return n == v && !z
    } else if cond == 15 { // LE less or equal
        return n != v || z
    }
}

func line0(inst uint16) {
    if inst & 256 || inst >> 9 == 4 { // btst,bchg,bclr,bset (or movep)
        if inst & 256 { // bit numbered by data register
            if (inst >> 3) & 7 == 1 {
                panic("movep")
            }
            dn = inst >> 9
            bit := readl(d0ptr + dn * 4)
        } else { // bit numbered by immediate
            bit = readw(pc); pc += 2
        }

        mode = inst & 63
        if mode >> 3 <= 1 {
            size = 4 // applies to register
        } else {
            size = 1 // applies to memory address
        }
        bit %= size * 8
        mask = 1 << bit

        ptr = address_by_mode(mode, size)
        val = read(size, ptr)
        z = !(val & mask)

        if (inst >> 6) & 3 == 1 { // bchg
            val ^= mask
        } else if (inst >> 6) & 3 == 2 { // bclr
            val &= ^mask
        } else if (inst >> 6) & 3 == 3 { // bset
            val |= mask
        }
        // ^^ the btst case is already handled by setting z

        write(size, ptr, val)

    } else { //ori,andi,subi,addi,eori -- including to SR/CCR
        size := readsize((inst >> 6) & 3)

        src_ptr := address_by_mode(60, size) // '#imm' mode, advances pc
        imm := read(size, src_ptr)

        // now, are we operating on a special mode?
        dest_mode = inst & 63
        if dest_mode == 60 { // '#imm' actually means CCR/SR
            // for addi/subi this would simply be invalid
            val = get_ccr()
        } else {
            dest_ptr = address_by_mode(dest_mode, size)
            val = read(size, dest_ptr)

        }
        if inst >> 9 == 0 { // ori
            val |= imm
            v = false
            c = false
            set_nz(val, size)
        } else if inst >> 9 == 1 { // andi
            val &= imm
            v = false
            c = false
            set_nz(val, size)
        } else if inst >> 9 == 2 { // subi
            val = sub_then_set_vc(val, imm, size)
            x = c
            set_nz(val, size)
        } else if inst >> 9 == 3 { // addi
            val = add_then_set_vc(val, imm, size)
            x = c
            set_nz(val, size)
        } else if inst >> 9 == 5 { // eori
            val ^= imm
            v = false
            c = false
            set_nz(val, size)
        } else if inst >> 9 == 6 { // cmpi: same as subi, but don't set
            fake_val = sub_then_set_vc(val, imm, size)
            set_nz(fake_val, size)

        }
        if dest_mode == 60 {
            set_ccr(val)
        } else {
            write(size, dest_ptr, val)
        }
    }
}

func line123(inst uint16) { // move, and movea which is a special-ish case
//    global v, c
    size = []int{0, 1, 4, 2}[(inst >> 12) & 3]
    if size == 0 {panic("move size=%00")
    }
    dest_mode = ((inst >> 3) & 0x38) | ((inst >> 9) & 7)
    src_mode = inst & 63

    src := address_by_mode(src_mode, size)
    datum = signed(size, read(size, src))

    if dest_mode >> 3 == 1 { // movea: sign extend to 32 bits
        size = 4
    } else { // non-movea: set condition codes
        v = false
        c = false
        set_nz(datum, size)

    }
    dest = address_by_mode(dest_mode, size)
    write(size, dest, datum)
}

func line4(inst uint16) { // very,crowded,line
//    global pc, x, n, z, v, c

    if (inst >> 6) & 63 == 3 { // move from sr
        dest = address_by_mode(inst & 63, 2) // sr is 2 bytes
        writew(dest, get_ccr())
    } else if (inst >> 6) & 0x3f == 0x37 { // move to sr/ccr
        if (inst >> 6) & 8 != 0 {
            size = 1 // ccr
        } else {
            size = 2 // sr
        }
        src = address_by_mode(inst & 63, size)
        set_ccr(read(size, src))
    } else if (inst >> 8) & 15 == 0 || (inst >> 8) & 15 == 4 || (inst >> 8) & 15 == 6 { // negx,neg,not
        size := readsize((inst >> 6) & 3)
        if size == 0 {panic("negx/neg/not size=%11")
        }
        dest = address_by_mode(inst & 63, size)
        datum = read(size, dest)

        if (inst >> 8) & 15 == 0 { // negx
            datum = sub_then_set_vc(0, datum+x, size)
            x = c
            set_nz(datum, size)
        } else if (inst >> 8) & 15 == 4 { // neg
            datum = sub_then_set_vc(0, datum, size)
            x = c
            set_nz(datum, size)
        } else { // not
            datum = ^datum
            v = false
            c = false
            set_nz(datum, size)
        }
        write(size, dest, datum)

    } else if (inst >> 8) & 15 == 2 { // clr
        size := readsize((inst >> 6) & 3)
        if size == 0 {panic("clr size=%11")
        }
        dest = address_by_mode(inst & 63, size)

        n = false
        z = true
        v = false
        c = false

        write(size, dest, 0)
    } else if inst & 0xFB8 == 0x880 { // ext
        if inst & 64 != 0 {
            size = 4
        } else {
            size = 2
        }
        dn = inst & 7
        src = d0ptr + dn * 4 + 4 - size/2
        dest = d0ptr + dn * 4 + 4 - size
        datum = signed(size/2, read(size/2, src))
        set_nz(datum, size)
        v = false
        c = false
        write(size, dest, datum)
    } else if inst & 0xFF8 == 0x840 { // swap.w
        dn = inst & 7
        dest = d0ptr + dn * 4
        datum = readl(dest)
        datum = ((datum >> 16) & 0xFFFF) | ((datum & 0xFFFF) << 16)
        set_nz(datum, 4)
        v = false
        c = false
        writel(dest, datum)
    } else if inst & 0xFC0 == 0x840 { // pea -- notice similarity to swap.w
        ea = address_by_mode(inst & 63, 4) // size doesn't matter here
        pushl(ea)
    } else if inst & 0xF00 == 0xA00 { // tst,tas
        size = []int{1, 2, 4, 1}[(inst >> 6) & 3]
        is_tas = (inst >> 6) & 3 == 3
        dest = address_by_mode(inst & 63, size)
        datum = read(size, dest)
        set_nz(datum, size)
        v = false
        c = false
        if is_tas {
            writeb(dest, datum | 0x80)
        }
    } else if inst & 0xFF8 == 0xE50 { // link
        an = inst & 7; an_ea = a0ptr + an * 4
        imm = signed(2, readw(pc)); pc += 2

        pushl(readl(an_ea)) // move.l a6,-(sp)
        sp = readl(regs+60)
        writel(an_ea, sp) // move.l sp,a6
        writel(regs+60, sp + imm) // add.w #imm,sp

    } else if inst & 0xFF8 == 0xE58 { // unlk
        an = inst & 7; an_ea = a0ptr + an * 4

        writel(regs+60, readl(an_ea)) // move.l a6,sp
        writel(an_ea, popl()) // move.l (sp)+,a6
    } else if inst & 0xFFF == 0xE71 { // nop
    } else if inst & 0xFFF == 0xE75 { // rts
        check_for_lurkers()
        pc = popl()
    } else if inst & 0xFFF == 0xE77 { // rtr
        set_ccr(popw())
        pc = popl()
    } else if inst & 0xF80 == 0xE80 { // jsr/jmp
        targ = address_by_mode(inst & 63, 4) // any size
        if !inst & 0x40 {
            check_for_lurkers() // don't slow down jmp's, we do them a lot
            pushl(pc)
        }
        pc = targ
    } else if inst & 0xF80 == 0x880 { // movem registers,ea
        size := 2
        if (inst & 64 != 0) {
            size = 4
        }

        which := readw(pc); pc += 2
        totalsize := bits.OnesCount16(which) * size

        mode := inst & 63
        ptr := address_by_mode(mode, totalsize)

        if mode >> 3 == 4 { // reverse the bits if predecrementing
            which = bits.Reverse16(which)
        }

        for reg := 0; reg < 16; reg++ {
            if which & (1 << reg) != 0 {
                regptr = regs + reg * 4 + 4 - size
                write(size, ptr, read(size, regptr))
                ptr += size
            }
        }
    } else if inst & 0xF80 == 0xC80 { // movem ea,registers
        size := 2
        if (inst & 64 != 0) {
            size = 4
        }

        which := readw(pc); pc += 2
        totalsize := bits.OnesCount16(which) * size

        mode := inst & 63
        ptr := address_by_mode(mode, totalsize)

        for reg := 0; reg < 16; reg++ {
            if which & (1 << reg) != 0 {
                if !(reg >= 8 && mode >> 3 == 3 && reg & 7 == mode & 7) {
                    regptr := regs + reg * 4 + 4 - size
                    writel(regptr, signed(size, read(size, ptr)))
                }
                ptr += size
            }
        }
    } else if inst & 0x1C0 == 0x1C0 { // lea
        an := (inst >> 9) & 7
        ea := address_by_mode(inst & 63, 4) // any size
        writel(a0ptr + an * 4, ea)
    } else if inst & 0x1C0 == 0x180 { // chk
        dn := (inst >> 9) & 7
        testee := signed(2, readw(d0ptr + 4 * dn + 2))
        ea := address_by_mode(inst & 63, 2)
        ubound := signed(2, readw(ea))
        if !(0 <= testee <= ubound) {
            panic("chk failed")
        }
    }
}

func line5(inst uint16) { // addq,subq,scc,dbcc
    if (inst >> 6) & 3 != 3 { // addq,subq
        size := 1 << ((inst >> 6) & 3)
        if size == 2 && (inst >> 3) & 7 == 1 {
            size = 4 // An.w is really An.l
        }
        imm := ((inst >> 9) & 7) || 8

        dest := address_by_mode(inst & 63, size)
        datum := read(size, dest)
        save_ccr := x, n, z, v, c
        if inst & 256 { // subq
            datum = sub_then_set_vc(datum, imm, size)
        } else { // addq
            datum = add_then_set_vc(datum, imm, size)
        }
        x = c
        set_nz(datum, size)
        if (inst >> 3) & 7 == 1 {
            x, n, z, v, c = save_ccr // touch not ccr if dest is An
        }
        write(size, dest, datum)

    } else if (inst >> 3) & 7 == 1 { // dbcc
        check_for_lurkers()

        disp = signed(2, readw(pc)) - 2; pc += 2

        cond = (inst >> 8) & 15 // if cond satisfied then DO NOT take loop
        if test_condition(cond) {
            return
        }
        // decrement the counter (dn)
        dn = inst & 7
        dest = d0ptr + dn * 4 + 2
        counter = (readw(dest) - 1) & 0xFFFF
        writew(dest, counter)
        if counter == 0xFFFF { // do not take the branch
            return

        }
        pc += disp

    } else { // scc
        dest = address_by_mode(inst & 63, 1)
        cond = (inst >> 8) & 15
        writeb(dest, 0xFF * test_condition(cond))
    }
}

func line6(inst uint16) { // bra,bsr,bcc
//    global pc

    check_for_lurkers()

    disp = signed(1, inst & 255)
    if disp == 0 { // word displacement
        disp = signed(2, readw(pc)) - 2; pc += 2

    }
    cond = (inst >> 8) & 15
    if cond > 1 && !test_condition(cond) { // not taken
        return

    }
    if cond == 1 { // is bsr
        pushl(pc)

    }
    pc += disp
}

func line7(inst uint16) { // moveq
//    global n, z, v, c
    dn := (inst >> 9) & 7
    val := int32(int8(inst & 255))

    n = false
    if val < 0 {
        n = true
    }

    z = false
    if val == 0 {
        z = true
    }

    v = false
    c = false

    writel(d0ptr + dn * 4, val)
}

func line8(inst uint16) { // divu,divs,sbcd,or
//    global n, z, v, c
    if inst & 0x1F0 == 0x100 { // sbcd
        panic("sbcd")
    } else if inst & 0x0C0 == 0x0C0 { // divu,divs
        is_signed = bool(inst & 0x100)
        ea = address_by_mode(inst & 63, 2)
        divisor = readw(ea)
        if is_signed {
            divisor = signed(2, divisor)
        }
        if divisor == 0 { // div0 error
            1/0
        }
        dn = (inst >> 9) & 7
        dividend = readl(d0ptr + dn * 4)
        if is_signed {
            dividend = signed(4, dividend)

        }
        // remainder is 0 or has same sign as dividend
        quotient = abs(dividend) // abs(divisor)
        if dividend < 0 {
            quotient = -quotient
        }
        if divisor < 0 {
            quotient = -quotient
        }
        remainder = abs(dividend) % abs(divisor)
        if dividend < 0 {
            remainder = -remainder

        }
        if signed && !(-0x8000 <= quotient < 0x7FFF) {
            v = true
            return

        }
        if !signed && quotient > 0xFFFF {
            v = true
            return

        }
        v = false
        set_nz(quotient, 2)

        writel(d0ptr + dn * 4, ((remainder & 0xFFFF) << 16) | (quotient & 0xFFFF))

    } else { // or
        size := readsize((inst >> 6) & 3)
        if size == 0 {panic("or size=%11")
        }
        src = address_by_mode(inst & 63, size)
        dn = (inst >> 9) & 7
        dest = d0ptr + dn * 4 + 4 - size

        if inst & 0x100 {
            src, dest = dest, src

        }
        datum = read(size, src) | read(size, dest)
        write(size, dest, datum)
        set_nz(datum, size)
        v = false
        c = false
    }
}

func line9D(inst uint16) { // sub,subx,suba//add,addx,adda: very compactly encoded
//    global x, n, z, v, c
    sign := -1
    if inst & 0x4000 != 0 {
        sign = 1
    }

    if inst & 0x0C0 == 0x0C0 { // suba,adda
        size := 2
        if inst & 0x100 != 0 {
            size = 4
        }

        ea = address_by_mode(inst & 63, size)
        an = (inst >> 9) & 7
        result = signed(4, readl(a0ptr + an * 4)) + sign * signed(size, read(size, ea))
        writel(a0ptr + an * 4, result)

    } else if inst & 0x130 == 0x100 { // subx,addx: only two addressing modes allowed
        size := readsize((inst >> 6) & 3)

        var mode int
        if inst & 8 != 0 {
            mode = 32 // -(Ax),-(Ay)
        } else {
            mode = 0 // Dx,Dy
        }

        src := address_by_mode(mode | (inst & 7), size)
        dest := address_by_mode(mode | ((inst >> 9) & 7), size)

        if sign == 1 {
            result := add_then_set_vc(read(size, dest), read(size, src) + x, size)
        } else {
            result = sub_then_set_vc(read(size, dest), read(size, src) + x, size)
        }
        write(size, dest, result)
        x = c
        old_z := z; set_nz(result, size); z &= old_z
    } else { // sub,add
        size := readsize((inst >> 6) & 3)
        if size == 0 {panic("sub/add size=%11")
        }
        src = address_by_mode(inst & 63, size)
        dn = (inst >> 9) & 7
        dest = d0ptr + dn * 4 + 4 - size

        if inst & 0x100 { // direction bit does a swap
            src, dest = dest, src
        }
        if sign == 1 {
            result = add_then_set_vc(read(size, dest), read(size, src), size)
        } else {
            result = sub_then_set_vc(read(size, dest), read(size, src), size)
        }
        x = c
        set_nz(result, size)
        write(size, dest, result)
    }
}

func lineB(inst uint16) { // cmpa,cmp,cmpm,eor
//    global x, n, z, v, c
    if inst & 0x0C0 == 0x0C0 { // cmpa
        if inst & 0x100 != 0 {
            size = 4
        } else {
            size = 2 // size of ea but An is always .L
        }

        ea := address_by_mode(inst & 63, size)
        an := (inst >> 9) & 7
        result := sub_then_set_vc(signed(4, readl(a0ptr + an * 4)), signed(size, read(size, ea)), 4)
        set_nz(result, 4)
    } else if inst & 0x100 == 0x000 { // cmp
        size := readsize((inst >> 6) & 3)
        if size == 0 {panic("cmp size=%11")
        }
        dn = (inst >> 9) & 7
        dest = d0ptr + dn * 4 + 4 - size
        src = address_by_mode(inst & 63, size)
        result = sub_then_set_vc(read(size, dest), read(size, src), size)
        set_nz(result, size)

    } else if inst & 0x38 == 0x08 { // cmpm (Ay)+,(Ax)+
        size := readsize((inst >> 6) & 3)
        src = address_by_mode(24 | (inst & 7), size) // (An)+ mode
        dest = address_by_mode(24 | ((inst >> 9) & 7), size)
        result = sub_then_set_vc(read(size, dest), read(size, src), size)
        set_nz(result, size)

    } else { // eor
        size := readsize((inst >> 6) & 3)
        if size == 0 {panic("eor size=%11")
        }
        dn = (inst >> 9) & 7; src = d0ptr + 4 * dn + 4 - size
        dest = address_by_mode(inst & 63, size)

        result = read(size, dest) ^ read(size, src)
        v = false
        c = false
        set_nz(result, size)
        write(size, dest, result)
    }
}

func lineC(inst uint16) {
    if inst & 0xC0 == 0xC0 { // mulu,muls
        is_signed = bool(inst & 0x100)
        src = address_by_mode(inst & 63, 2) // ea.w
        dest = d0ptr + ((inst >> 9) & 7) * 4 // dn.l

        m1 = readw(dest+2); m2 = readw(src)
        if is_signed {
            m1 = signed(2, m1); m2 = signed(2, m2)
        }
        datum = m1 * m2
        set_nz(datum, 4)
        v = false
        c = false
        writel(dest, datum) // write dn.l

    } else if inst & 0x1F0 == 0x100 { // abcd
        panic("abcd")
    } else if inst & 0x1F8 == 0x140 || inst & 0x1F8 == 0x148 || inst & 0x1F8 == 0x188 { // exg
        rx = (inst >> 9) & 7
        ry = inst & 7
        if inst & 0x1F8 == 0x148 { // Ax,Ay
            rx |= 8; ry |= 8 // bump the addressing mode from Dn to An
        }
        if inst & 0x1F8 == 0x188 { // Dx,Ay
            ry |= 8

        }
        rx = address_by_mode(rx, 4)
        ry = address_by_mode(ry, 4)

        x := readl(rx)
        y := readl(ry)
        writel(rx, y)
        writel(ry, x)

    } else { // and
        size := readsize((inst >> 6) & 3)
        if size == 0 {panic("and size=%11")
        }
        dn := (inst >> 9) & 7; dest = address_by_mode(dn, size)
        src := address_by_mode(inst & 63, size)

        if inst & 0x100 { // direction bit
            src, dest = dest, src

        }
        result := read(size, src) & read(size, dest)
        set_nz(result, size)
        v = false
        c = false
        write(size, dest, result)
    }
}

func lineE(inst uint16) {
//    global x, n, z, v, c
    size := readsize((inst >> 6) & 3)

    if size == nil { // single-bit shift on a memory address
        size = 2
        kind = (inst >> 9) & 3
        dest = address_by_mode(inst & 63, size)
        by := 1
    } else {
        kind = (inst >> 3) & 3
        dest = d0ptr + (inst & 7) * 4 + 4 - size // dn
        if inst & 0x20 {
            by = readb(d0ptr + ((inst >> 9) & 7) * 4 + 3) % 64
        } else {
            by = (inst >> 9) & 7
            by = ((inst >> 9) & 7) || 8

        }
    }
    isleft = bool(inst & 0x100)

    v = false // clear V if msb never changes
    c = false // clear C if shift count is zero

    result = read(size, dest)
    mask = (1 << (size * 8)) - 1
    msb = 1 << (size * 8 - 1)
    numbits = size * 8
    if kind == 0 { // asl/asr
        if isleft {
            for i := range(by) {
                newresult = (result << 1) & mask
                c = result & msb != 0 // shifted-out bit
                x = c
                if newresult & msb != result & msb { // set V if sign ever changes
                    v = 1
                }
                result = newresult
            }
        } else {
            for i := range(by) {
                newresult := result >> 1
                c = result & 1 != 0 // shifted-out bit
                x = c
                newresult |= result & msb // replicate sign bit
                result = newresult
            }
        }
    } else if kind == 1 { // lsl/lsr
        v = false
        if isleft {
            for i := range(by) {
                newresult = (result << 1) & mask
                c = result & msb != 0 // shifted-out bit
                x = c
                result = newresult
            }
        } else {
            for i := range(by) {
                newresult = result >> 1
                c = result & 1 != 0 // shifted-out bit
                x = c
                result = newresult
            }
        }
    } else if kind == 2 { // roxl/roxr
        v = false
        if isleft {
            for i := range(by) {
                newresult = (result << 1) | x
                c = newresult >> numbits != 0
                x = c
                result = newresult & mask
            }
        } else {
            for i := range(by) {
                newresult = (result >> 1) | (x * msb)
                c = result & 1 != 0
                x = c
                result = newresult & mask
            }
        }
    } else if kind == 3 { // rol/ror
        v = false
        if isleft {
            for i := range(by) {
                result = (result << 1) | (result >> (numbits - 1))
                c = bool(result & 1)
            }
        } else {
            for i := range(by) {
                c = bool(result & 1)
                result = (result << (numbits - 1)) | (result >> 1)

            }
        }
    }
    set_nz(result, size)

    write(size, dest, result)
}

func call_m68k(addr uint32) {
    const magic_return = 0

    save_pc := pc
    pushl(magic_return) // the function we call will pop this value
    pc = addr

    for pc != magic_return {
        inst := readw(pc)
        pc += 2
        switch inst >> 12 {
        case 0:
            line0(inst)
        case 1, 2, 3:
            line123(inst)
        case 4:
            line4(inst)
        case 5:
            line5(inst)
        case 6:
            line6(inst)
        case 7:
            line7(inst)
        case 8:
            line8(inst)
        case 9, 0xd:
            line9D(inst)
        case 0xa:
            lineA(inst)
        case 0xb:
            lineB(inst)
        case 0xc:
            lineC(inst)
        case 0xe:
            lineE(inst)
        case 0xf:
            lineF(inst)
        }
    }

    pc = save_pc
}

// debug_segment_list = []
// func roughly_where_we_are(pc) {
//     retval = f"{pc:x}"
//
//     for seg_num, start, end in reversed(debug_segment_list) {
//         if start <= pc < end {
//             retval += f" seg{seg_num:x}+{pc-start:x}"
//
//             for i := range(pc, end, 2) {
//                 if i + 4 >= len(mem): break
//                 }
//                 if mem[i:i+2] in (b"Nu", b"\x4e\xd0") {
//                     if 0x81 <= mem[i+2] < 0xc0 {
//                         strlen := mem[i+2] & 0x7f
//                         trystring := mem[i+3:i+3+strlen]
//                         }
//                         if len(trystring) == strlen && all(0x20 < x < 0x7f for x in trystring) {
//                             retval += f' {trystring.decode("mac_roman")}-{i+2-pc:x}'
//                         }
//                     }
//                     break
//
//                 }
//             }
//         }
//     }
//     if mem[pc:pc+2] == b"\xaa\x69" {
//         retval += " callback:" + my_callbacks[-1].__name__
//
//     }
//     retval += f" {mem[pc:pc+2].hex()}"
//
//     return retval
// }
//
// func print_state() {
//     for _, i := range (regs, regs+32) {
//         fmt.Print(" ".join(mem[r:r+4].hex() for r := range(i, i+32, 4)))
//
//     }
//     sp := readl(a7ptr)
//     fmt.Print("sp:", " ".join(mem[r:r+2].hex() for r := range(sp, sp+20, 2)),
//         "ccr:", "xX"[x]+"nN"[n]+"zZ"[z]+"vV"[v]+"cC"[c])
//
// }

//#######################################################################
// SANE -- blobs from Mac Plus ROM
//#######################################################################

// pack4 = bytes.fromhex(""'
// 600A 0000 5041 434B 0004 0002 4E56 FFFE 48E7 FFF8 307C 0A4A 6026 00E1 00E1 00E1
// 00E1 00C1 00C1 00E1 0061 0161 00A0 00A0 00A0 00A1 00A0 0041 4E56 FFFE 48E7 FFF8
// 3C2E 0008 7E1E CE46 0886 0000 6600 09EA 08A8 0007 0001 8C7B 70C2 7060 C028 0001
// EE58 8C40 0806 0008 6714 3006 0246 00FF 0240 3800 3200 E749 E658 8C40 8C41 4846
// 4282 2602 3C02 0806 0017 670E 2006 4840 EE58 266E 000A 6100 00CA 0806 0016 6720
// 2244 2445 2F0C E21E D442 3003 D643 D640 2006 4840 ED58 266E 000E 6100 00A6 265F
// E306 6804 08C6 0006 E216 3007 4287 487A 002E 4A42 6600 01DC 303B 0006 4EFB 00FA
// 04BC 04B8 0556 05F6 070C 070C 068E 0778 07EC 0854 0780 078C 0930 08FA 0940 0806
// 0015 670A 2006 4840 EE58 6100 03C0 4847 3010 4206 8046 30C0 E05E C046 6718 3F07
// 3F00 4857 4CEE 000F 0006 48E7 F000 548F 2050 4E90 2E1F 0806 0010 6706 7010 720E
// 6004 700C 720A 3D40 FFFE 2DAE 0004 1000 2C56 44C7 4CDF 1FFF DED7 4E75 7014 7212
// 60E4 4284 2A04 0240 000E 303B 0006 4EFB 00F2 0068 00F2 00C8 0068 001E 0026 002C
// 700F 3813 4844 602A 701F 2813 6024 703F 2813 2A2B 0004 6704 4A84 601A 0C84 8000
// 0000 660E 387C 7FFF 7814 4844 08C4 001E 606A 4A84 673A 6A08 08C6 0007 4485 4084
// 0640 3FFF 4A84 6B3A 6030 3013 6A08 08C6 0007 0880 000F 282B 0002 2A2B 0006 0C40
// 7FFF 6724 4A84 6B1A 4A84 660A 4A85 6606 99CC 5443 4E75 08C3 001F 5340 DA85 D984
// 6AF8 48C0 2840 4E75 387C 7FFF 0884 001F 4A84 6608 4A85 6604 5843 4E75 08C4 001E
// 6604 08C6 0008 5442 4E75 4280 2813 DC06 D884 E216 E19C 1004 6712 183C 0001 E29C
// 0C00 00FF 67C2 0640 3F80 60B6 303C 3F81 E29C 6094 2813 6A04 08C6 0007 2A2B 0004
// E19D E79D E19C E99C 3004 E28C 0244 F800 3205 0241 07FF 8841 0245 F800 0240 07FF
// 6608 303C 3C01 6000 FF60 0C40 07FF 6700 FF78 08C4 001F 0640 3C00 6000 FF66 08C6
// 0008 4840 08C0 001E 2800 4285 387C 7FFF 6024 0C42 0002 671E 0C42 0004 6710 203C
// 00FF 0000 2209 C280 C084 B280 6F08 E31E 284B 2A0A 2809 0806 001A 671E 4284 7A01
// E29D 0806 0018 6608 0806 0019 6608 4845 08C6 0008 4E75 C945 4E75 0806 0015 661A
// 0806 0014 6606 7002 6000 04E2 7001 0886 0008 6602 5240 6000 0712 0806 001F 6706
// 7A00 1805 600A 0806 001E 6704 0245 F800 2004 0880 001E 8085 6608 7815 4844 08C4
// 001E 4E75 DC06 2809 2A0A 284B 4E75 0C40 0042 6304 303C 0042 E28C E295 E257 55C1
// 8E01 5340 66F2 4E75 4A84 660C 4A85 6608 4A47 6604 99CC 4E75 4A84 6008 538C DE47
// DB85 D984 6AF6 4A86 6B00 00C6 0806 001E 6600 00F6 97CB 611A 4281 7401 0805 0000
// 6120 367C 7FFE 616C 6706 284B 78FF 2A04 4E75 200B 908C 6E02 4E75 08C6 0009 284B
// 608C 56C0 4A47 6606 0886 0009 4E75 08C6 000C 0810 0005 670E 0810 0006 6702 4E75
// 4A06 6A1E 4E75 0810 0006 6610 0C47 8000 6402 4E75 620C 4A00 6608 4E75 4A06 6B02
// 4E75 08E8 0007 0001 DA82 D981 6404 E294 528C 4E75 B7CC 6D04 4240 4E75 08C6 000A
// 08C6 000C 387C 7FFF 4284 2A04 1210 0201 0060 6602 4E75 0C01 0060 6604 4A01 4E75
// 4A06 6B06 0C01 0020 4E75 0C01 0040 4E75 367C 3F81 6100 FF5C 4A85 56C0 8E00 D804
// E257 8E04 4285 4204 223C 0000 0100 4282 0804 0008 6100 FF4C 367C 407E 6196 6706
// 284B 78FF 4204 4E75 367C 3C01 6100 FF24 303C 07FF C045 0245 F800 EB48 E24F 6404
// 08C7 0000 8E40 4281 243C 0000 0800 0805 000B 6100 FF0E 367C 43FE 6100 FF58 670A
// 284B 78FF 2A3C FFFF F800 4E75 0240 000E 303B 0010 266E 000A 360C 0C43 7FFF 4EFB
// 00EC 0032 0086 0060 0000 0024 0028 002C 3685 4E75 2685 4E75 26C4 2685 4E75 0806
// 0009 6718 4A43 6714 4A84 660E 4A85 6604 4283 6008 5343 DA85 D984 6AF8 4A06 6A04
// 0643 8000 36C3 26C4 2685 4E75 6606 363C 4080 6008 4A43 6604 363C 3F81 0443 3F80
// D884 6502 5343 8843 E09C DC06 E294 2684 4E75 6606 363C 4400 6008 4A43 6604 363C
// 3C01 0443 3C00 4A84 6B02 5343 203C 0000 07FF C084 8A80 E09D E69D 0244 F800 D884
// 8843 E09C E69C DC06 E294 26C4 2685 4E75 0A06 00A0 363B 3006 4EFB 30FA 001A 0080
// FDB8 0088 0066 FDB8 FDB0 FDB0 008C 2604 2809 CB8A 300C 904B 6712 6E0C CB8A C943
// 4440 284B DC06 E206 6100 FD84 0806 0005 6612 DA8A D983 6408 E294 E295 E257 528C
// 6000 FDA4 4606 9A8A 9983 6714 6408 4447 4085 4084 4606 6000 FD80 0806 0005 6712
// 99CC 4206 0810 0006 6708 0810 0005 6602 4606 4E75 2A0A 2809 284B DC06 6000 FD68
// 0806 0005 6602 4E75 7002 6000 FC72 E51E 7008 363B 3006 4EFB 30F6 001E FD1E FD1E
// FD18 FD1E FC70 FD18 FC70 FD1E D9CB 98FC 3FFE 48E7 0680 2644 4284 2A04 2044 2217
// 6606 200A 6728 6012 200A 6130 4A85 56C7 2A04 4284 2217 2009 6122 220B 200A 611C
// 4A45 56C0 8E00 4845 8E45 2A04 2808 220B 2009 6108 4CDF 0141 6000 FCDE 3401 3601
// C4C0 3C00 4840 4841 CCC1 C6C0 C2C0 4842 4280 3002 D680 D686 3403 4842 4243 D743
// 4843 D283 DA82 D981 6402 5248 4E75 E51E 7004 363B 3006 4EFB 30F6 0034 001E 002C
// FC78 FBD0 FC78 FC78 FC78 FBD0 08C6 000B 387C 7FFF 4284 2A04 4E75 99CC 280C 2A04
// 4E75 C74C 99CB D8FC 3FFF 7041 4A86 6A02 7021 B889 6602 BA8A 6304 5240 538C 2209
// 240A 2604 2445 611A 4A86 6A04 2805 4285 44FC 0010 E294 E295 E257 8282 56C7 6000
// FC46 4284 2A04 600A DA85 D984 D482 D381 6508 B283 6602 B48A 6506 5205 948A 9383
// 5340 66E4 4E75 426F 0006 DC06 7009 0286 3FFF FFFF 363B 3006 4EFB 30EC 0028 FB38
// 0030 FBE0 FB38 FBE0 FB38 FB38 FB38 200B 5480 908C 6E08 2809 2A0A 284B 6042 538C
// 2209 240A 2604 2445 6198 0805 0000 671C 4A81 660A 4A82 6606 0805 0001 6706 0846
// 0007 5445 C58A C343 948A 9383 E20D 0806 0006 6702 4405 4885 3F45 0006 2801 2A02
// 6000 FB86 363B 301C 4EBB 30FA 0C40 0002 660A 0806 0011 6704 08C6 0008 3E00 4847
// 4E75 0048 0030 0034 0034 0044 0034 0030 0030 003E DC06 4606 7000 4A06 6B02 7019
// 4E75 0806 0005 66F0 7004 4E75 0806 0005 66E6 B7CC 6E0E 6D0E B3C4 6208 6508 B5C5
// 67E6 6502 4606 7019 4A06 6A02 7000 4E75 4A43 6700 FB32 4E75 4A43 6702 4E75 6134
// 3450 6012 4A43 6702 4E75 6128 3450 08D0 0006 08D0 0005 6100 FB0E 308A 4A84 6B12
// 6608 4A85 6604 99CC 6008 538C DA85 D984 6AF8 4E75 4A86 6B0C 0806 001E 670C 7034
// 6000 000A 7017 6000 0004 703F 0640 3FFF 3200 908C 6E02 4E75 3841 6100 FA92 44FC
// 0000 4E75 0806 001A 6786 0C43 0002 6602 4E75 0C43 0004 6604 78FF 6010 61CC 6F0C
// 4281 7401 0805 0000 6100 FAD8 7201 E299 0806 0018 6608 0806 0019 6626 4841 4A84
// 6614 BA81 6210 6504 4A06 6A0A 4A06 6A04 4485 4084 4E75 2A01 08C6 0008 0886 000C
// 4E75 4A84 6AE6 4285 2801 60EC 0C43 0002 6602 4E75 7001 4A06 6B00 F964 0C43 0004
// 6602 4E75 300C E240 40C1 6402 5240 0640 1FFF 3840 2246 2447 2E05 2C04 4283 2403
// DE87 DD86 D743 44C1 6506 DE87 DD86 D743 2002 2802 7A03 5343 7241 3641 4281 DE87
// DD86 D783 D582 D341 DE87 DD86 D783 D582 D341 DA85 D984 D140 5345 9685 9584 9340
// 6408 D685 D584 D340 6002 5445 C18B 5340 C18B 66CA 2C09 2E0A 8282 8283 6602 5345
// 7203 E248 E294 E295 E257 5341 66F4 6000 F9B6 4206 0C43 0002 660E 0046 0880 387C
// 7FFF 4284 2A04 4E75 0C43 0004 6602 4E75 4285 98FC 3FFF 280C 6A06 0006 0080 4484
// 387C 401E 6000 F962 4A43 6702 4E75 266E 000E D8D3 6000 F970 7005 4A83 6B0A 670A
// 5540 0C43 0004 6702 5240 4A06 6702 4440 266E 000A 3680 4E75 4CEE 0600 000A 3E3B
// 7006 4EFB 70F4 002A 0034 0038 003E 01F2 055A 0044 004A 005E 0072 01D8 002E 01E4
// 0052 3091 6020 3290 4250 601A 3290 6016 2151 0002 6010 22A8 0002 600A 0851 0007
// 6004 0891 0007 6000 F6BA 3011 0110 56C0 4400 1280 60F0 0811 0007 6706 08D2 0007
// 6004 0892 0007 6000 F694 9EFC 0016 284F 3A06 0245 3800 5246 4846 4246 2F0A 486C
// 000A 700E 8045 3F00 6100 F56E 4294 42AC 0004 426C 0008 4854 486C 000A 3F3C 0008
// 6100 F556 56C4 2F09 4854 3F00 6100 F54A 4854 486C 000A 3F3C 0008 6100 F53C 6822
// 4854 486C 000A 3F3C 0004 6100 F52C 486C 000A 2F0A 7010 8045 3F00 6100 F51C 6000
// 0080 677C 6408 0812 0007 6708 607A 0812 0007 6774 0805 000C 6704 5292 6034 0805
// 000B 670A 52AA 0004 6402 5292 6024 52AA 0006 641E 52AA 0002 6418 E4EA 0002 5252
// 0C52 7FFF 6706 0C52 FFFF 6606 08AA 0007 0002 2F0A 486C 0014 701C 8045 3F00 6100
// F4B8 322C 0014 6A02 4441 0C41 0003 6606 0046 1400 600A 0C41 0005 6704 0046 1200
// DEFC 0016 6000 F568 0805 000C 6710 4A04 6608 0852 0007 5292 60B8 5392 60B4 0805
// 000B 6718 4A04 660A 0852 0007 526A 0006 60A0 53AA 0004 6402 5392 6096 4A04 660A
// 0852 0007 526A 0008 6088 53AA 0006 641C 53AA 0002 6B12 4A52 6712 0C52 8000 670C
// 066A 8000 0002 6002 6402 5352 6000 FF64 4846 4246 3011 5040 01C6 600A 4846 3C3C
// 1F00 CC50 3091 6000 F4E6 9EFC 0014 264F 49EA 0004 362A 0002 4846 4284 2A04 2E04
// 7413 1C1C 6768 1014 0C00 0049 6754 0C00 004E 6654 142C FFFF 528C 5302 7008 0C02
// 0004 6C04 5900 D002 610A 2805 4285 7008 6102 601E E99D 5302 6B12 121C 0C01 0039
// 6F04 0601 0009 0201 000F 8A01 5340 66E4 4E75 0284 7FFF FFFF 6608 7815 4844 08C4
// 001E 303C 7FFF 6008 0C00 0030 6628 4280 4A12 6704 08C0 000F 6100 0074 6000 0052
// DA85 D984 2205 2004 DA85 D984 DA85 D984 DA81 D980 4E75 61E8 700F C01C DA80 4240
// D980 5306 6716 5302 66EC 1E3C 000F CE14 600E 0C43 001B 6F08 61C6 5343 5342 66F2
// 303C 403E 4A12 6704 08C0 000F 6120 6128 4846 0246 3800 0046 0010 4853 2F2E 000A
// 3F06 6100 F314 DEFC 0014 6000 F410 36C0 26C4 2685 5D8B 4E75 1C10 1F06 0206 0060
// 670E 7240 4A13 6A0C 0C06 0040 670C 600E 1086 6014 0C06 0020 6604 0A01 0060 4A43
// 6A04 0A01 0060 1081 43EB 000A 6100 00F2 0010 0060 486B 000A 4853 7004 4A43 6A02
// 7006 3F00 6100 F2B2 0810 0004 56C0 4A07 56C7 8007 1210 0201 001F 821F 1081 4400
// 673E 08D0 0004 4A06 6728 0C06 0060 6730 2F3C 0000 0001 42A7 3F13 5357 6502 6802
// 5257 4857 4853 4267 6100 F26E DEFC 000A 600E 3013 5240 D040 6706 08EB 0000 0009
// 4E75 000E 0000 402D B5E6 20F4 8000 0000 001B 0000 4058 CECB 8F27 F420 0F3A 0037
// 0001 40B5 D0CF 4B50 CFE2 0766 006C 0001 4165 DA01 EE64 1A70 8DEA 00CE FFFF 42AB
// 9F79 A169 BD20 3E41 019C 0001 4557 C6B0 A096 A952 02BE 0338 0001 4AB0 9A35 B246
// 41D0 5953 0670 0001 5561 B9C9 4B7F A8D7 6515 0CE0 0001 6AC4 86D4 8D66 26C2 7EEC
// 7209 3003 6A02 4440 0C40 000F 6564 0C40 1388 6504 303C 1388 45FA FFD8 B052 654A
// 905A 4A52 673E 08D0 0004 0810 0006 6706 4A52 6F30 600A 0810 0005 6728 4A52 6C24
// 2F0A 3F2A 000A 4A5A 6A04 5257 6002 5357 2F2A 0004 2F12 244F 6120 508F 548F 245F
// 548A 6004 548A 6112 598A 94FC 000E 5341 66AA C0FC 000A 45FB 0024 4A81 6A0E 4852
// 4851 3F3C 0004 6100 F150 4E75 32DA 22DA 2292 5D89 5D8A 08C1 001F 4E75 3FFF 8000
// 0000 0000 0000 4002 A000 0000 0000 0000 4005 C800 0000 0000 0000 4008 FA00 0000
// 0000 0000 400C 9C40 0000 0000 0000 400F C350 0000 0000 0000 4012 F424 0000 0000
// 0000 4016 9896 8000 0000 0000 4019 BEBC 2000 0000 0000 401C EE6B 2800 0000 0000
// 4020 9502 F900 0000 0000 4023 BA43 B740 0000 0000 4026 E8D4 A510 0000 0000 402A
// 9184 E72A 0000 0000 402D B5E6 20F4 8000 0000 3006 ED58 4282 2602 2C02 2E02 264A
// 6100 F1C0 300C 286E 0012 9EFC 001E 264F E31E 1286 137C 0001 0004 4A42 6734 5889
// 12FC 0011 12FC 004E 610C 2805 6108 92FC 0016 6000 01DC 7008 E99C 720F C204 0001
// 0030 0C01 0039 6F02 5E01 12C1 5340 66E8 4E75 4A43 6712 7030 0C43 0002 6702 7049
// 1340 0005 6000 01AA 2204 3200 0441 3FFF 4841 D241 4A40 6A08 E28C E295 5240 6BF8
// E25E 8046 6100 FD08 4284 4A14 662C 203C 4D10 4D42 4A81 6A02 5240 2800 4844 C8C1
// 4244 4844 4841 3A01 CBC0 4845 48C5 D885 4840 C1C1 D880 4844 5244 6100 0084 9644
// 226E 000A 3343 0002 4469 0002 3753 0014 276B 0002 0016 276B 0006 001A 6100 FCBA
// 4853 3F3C 0014 6100 EFB0 43EB 000A 4A14 6604 614C 6002 7613 6100 FDC6 3013 0880
// 000F B051 6612 202B 0002 B0A9 0002 6608 202B 0006 B0A9 0006 6540 4A14 6614 5244
// 36AB 0014 276B 0016 0002 276B 001A 0006 6088 226E 000A 137C 003F 0005 6000 00D2
// 362C 0002 4A14 6610 4A43 6F0A 0C43 0013 6F06 7613 6002 7601 4E75 4A14 6636 61E0
// 5343 6100 FD5C 3013 0880 000F B051 6612 202B 0002 B0A9 0002 6608 202B 0006 B0A9
// 0006 6410 3691 2769 0002 0002 2769 0006 0006 4E71 226E 000A 3613 222B 0002 660A
// 137C 0030 0005 6000 0068 242B 0006 0883 000F 0443 403E 6708 E289 E292 5243 6BF8
// 263C 8AC7 2304 247C 89E8 0000 7041 6100 F5D2 5285 D980 5889 2449 421A 7C13 DA85
// D984 D140 2605 2404 3200 DA85 D984 D140 DA85 D984 D140 DA83 D982 D141 4A40 670C
// 0080 0000 0130 14C0 4200 5211 5306 66CE DEFC 001E 6000 EFA6
// ""')
//
// pack5 = bytes.fromhex(""'
// 600A 0000 5041 434B 0005 0001 4E56 FFD0 48E7 FFF8 4283 2078 0ACC 1D50 FFD0 08D0
// 0007 47EE 0004 41EE 0008 3618 6A48 2858 2810 0803 000E 6618 2093 36BC 000A 2A0C
// 740F 0C43 8010 6706 2044 6110 3400 6032 5888 2A10 2093 36BC 000E 60EC 4850 486E
// FFFC 3F3C 001C A9EB 302E FFFC 6A06 4440 0040 8000 4E75 740F 2850 2093 36BC 0006
// 2A0C 2045 61D6 3200 486E FFFE 3F3C 0017 A9EB 5702 6C10 2045 224C 614C 2F04 4854
// 4267 A9EB 600E 5701 6C0E 2F05 4854 3F3C 000E A9EB 6000 030C 3003 0240 00FE 303B
// 0006 4EFB 00F4 013A 013A 013A 013A 0326 0326 03D6 03D6 04E6 0608 06F8 078E 08E8
// 093A 0A52 0B3C 0C80 22D8 22D8 3290 5189 4E75 3019 4851 4850 3F3C 000E A9EB 4852
// 4850 3F3C 0004 A9EB 5089 5489 4851 4850 4267 A9EB 5340 6EE6 5089 5489 4E75 7001
// 600A 7002 6006 7000 6002 7004 558F 4857 3F3C 0003 A9EB 0197 4857 3F3C 0001 A9EB
// 548F 4A00 4E75 7002 600E 7001 600A 7003 6006 7000 6002 7004 3F00 4857 3F3C 0015
// A9EB 60DC 7003 600E 7001 600A 7002 6006 7000 6002 7004 3F00 4857 3F3C 001B A9EB
// 1017 60BC 3D7C 7FFF FFFA 47EE FFE6 2729 0006 2729 0002 3711 0893 0007 6144 6C16
// 487A 0C9A 4853 3F3C 0002 A9EB 4A11 6A04 446E FFFA 611E 612A 6C06 487A 0C80 6002
// 4853 486E FFFA 3F3C 2010 A9EB 4A11 6A04 446E FFFA 486E FFFA 4850 3F3C 2018 A9EB
// 4E75 486E FFDC 487A 0C54 3F3C 0008 A9EB 4E75 5301 6A0C 4A41 6A00 01A0 7024 6000
// 01B0 0803 0002 660A 4A01 671C 4A41 6BEC 605A 4A01 6700 01AC 4854 487A 0BF8 3F3C
// 0008 A9EB 62D6 6504 6000 0176 204C 43EE FFF0 6100 FEB4 487A 0BD2 4854 4267 A9EB
// 487A 0C7C 4854 3F3C 0008 A9EB 6F1E 4854 487A 0C62 3F3C 0008 A9EB 6310 2049 224C
// 6100 FE86 6100 007E 6000 0064 204C 43EE FFF0 6100 FE74 4851 3F3C 001A A9EB 0851
// 0007 204C 6100 FEFE 0851 0007 487A 0C26 4854 3F3C 0008 A9EB 6F00 001A 487A 0B6C
// 486E FFF0 4267 A9EB 487A 0B88 4854 3F3C 0006 A9EB 487A 0B54 4854 3F3C 0002 A9EB
// 6100 0022 486E FFF0 4854 4267 A9EB 0803 0001 660C 487A 0BFC 4854 3F3C 0004 A9EB
// 6000 00E0 4854 486E FFFA 3F3C 001C A9EB 302E FFFA 6A02 4440 5940 6602 4E75 5340
// 670A 487A 0BCE 6100 FE42 6064 204C 43EE FFE6 6100 FDD4 487A 0B1A 4854 4267 A9EB
// 4854 4851 3F3C 0006 A9EB 2049 4851 4851 43EE FFDC 6100 FDB2 3F3C 0004 A9EB 204C
// 43FA 0A20 45EE FFE6 6100 FDA8 486E FFDC 4854 3F3C 0004 A9EB 41EE FFDC 43FA 0A42
// 45EE FFE6 6100 FD8C 6100 FDB4 486E FFDC 4854 3F3C 0006 A9EB 6100 FDDC 4E75 41FA
// 0A9E 6024 41FA 0AA2 601E 41FA 0A7E 6018 41FA 0A82 6012 6100 FDB6 41FA 0AAA 6008
// 6100 FDAC 41FA 0AAA 224C 6100 FD3C 6012 0080 7FFF 4000 28C0 429C 4254 518C 6100
// FD92 486E FFFE 3F3C 0019 A9EB 2078 0ACC 10AE FFD0 4CDF 1FFF 4E5E DED7 4E75 5301
// 67A8 6E06 4A41 6B96 60D8 0803 0001 6704 613A 601E 6100 0058 6100 FD72 6714 6100
// FD56 4A41 6A94 6100 FD1A 6100 FD3E 6000 FF6E 6100 010E 487A 09F2 4854 4267 A9EB
// 204C 43EE FFF0 6100 FD5C 6096 204C 43EE FFF0 6100 FCB4 4851 3F3C 0014 A9EB 6100
// FCEA 4851 4854 3F3C 0002 A9EB 4E75 204C 43EE FFF0 6100 FC92 487A 0A78 2F17 2F17
// 4854 3F3C 000C A9EB 4854 4851 3F3C 0002 A9EB 4851 3F3C 0006 A9EB 4851 3F3C 0014
// A9EB 4854 3F3C 0006 A9EB 6000 FC9E 5301 6E0E 6700 0008 4A41 6B00 FEF6 6000 FF24
// 5301 0803 0001 6720 4A01 6716 487A 0A24 4854 3F3C 0004 A9EB 6100 FC90 6100 FC98
// 605C 6100 FF68 601E 4A01 66EC 6180 6100 FC9C 6712 6100 FC80 4A41 6A00 FEBE 6100
// FC42 6000 FEAC 6100 003A 487A 0932 486E FFF0 3F3C 0008 A9EB 6724 487A 090E 4854
// 4267 A9EB 204C 43EE FFF0 6100 FC78 487A 08FA 4854 3F3C 0002 A9EB 6100 FC02 6000
// FEA2 487A 08FA 4854 3F3C 0008 A9EB 6602 4E75 43EE FFDC 204C 6100 FBAE 4851 4851
// 3F3C 0004 A9EB 41EE FFE6 43FA 0874 45EE FFDC 6100 FB9E 486E FFE6 4854 3F3C 0004
// A9EB 41EE FFE6 43FA 0882 45EE FFDC 6100 FB82 4854 486E FFE6 3F3C 0002 A9EB 487A
// 08B2 4854 3F3C 0004 A9EB 486E FFE6 4854 3F3C 0006 A9EB 6100 FBBE 6000 FB82 2044
// 3410 6700 FDE6 5301 6E26 E242 6504 0894 0007 D542 6A00 FE0C 4A01 6A0A 4A14 6A00
// FDBE 6000 FDC0 4A14 6A00 FDCC 6000 FDD2 3002 6A02 4440 0C40 00FF 6206 612C 6000
// FDE2 3F14 0894 0007 2F04 486E FFF0 2817 3F3C 200E A9EB 6100 0098 301F 6A08 E242
// 6404 08D4 0007 6000 FDBA 204C 43EE FFE6 6100 FAD6 614E 4A42 6B08 2049 224C 6000
// FAC8 41FA 07E6 43D4 6100 FABE 6100 FB3A 6614 6100 FB38 660E 486E FFF0 4854 3F3C
// 0006 A9EB 4E75 6100 FADA 6100 FAD2 486E FFE6 4854 3F3C 0006 A9EB 3002 6A02 4440
// 6102 60B6 41FA 07A4 43EE FFF0 6100 FA7A 600A 4854 4854 3F3C 0004 A9EB E248 640A
// 4854 4851 3F3C 0004 A9EB 4A40 66E4 4E75 204C 43EE FFE6 6100 FA50 4851 3F3C 0002
// 6100 F95E 2F04 4851 3F3C 0004 A9EB 4851 3F3C 000A 6100 F94A 2049 224C 6000 FA2A
// 4A41 6B14 6100 0068 6000 FCF8 588F 6100 FA5A 7025 6000 FCDA 4A02 67F2 2044 43EE
// FFF0 6100 FA04 4851 3F3C 0014 A9EB 6100 FA84 66DA 487A 073C 4851 3F3C 0006 A9EB
// 4851 3F3C 0014 A9EB 486E FFFA 3F3C 0003 A9EB 6100 FA16 0894 0007 6100 0012 082E
// 0004 FFFA 6704 0854 0007 6000 FC96 5301 661C 5302 6796 4A42 6A0A 6100 FA12 41FA
// 0706 6004 41FA 06D8 224C 6000 F99C 6A08 5302 6618 6000 FF76 5302 6A10 487A 06AC
// 4854 3F3C 0008 A9EB 6700 FF62 3C02 2F04 486E FFFC 3F3C 2010 A9EB 6100 F9F4 56C7
// 6100 F9A4 6100 F9EE 56C1 8E01 6612 342E FFFC 3002 6A02 4440 0C40 00FF 6F00 FE6C
// 6100 F988 6100 FEEA 4A06 6B00 F97E 4E75 487A 0662 2F05 3F3C 0008 A9EB 6D00 0082
// 6E00 0016 5302 6604 6000 FBC0 2044 4A10 6B00 FBC4 6000 FBA8 5302 67EC 6E0C 5301
// 675E B541 6BEE 6000 FBB2 43EE FFE6 2045 6100 F8F6 3011 0880 000F 0C40 3F7F 6D1C
// 4851 3F3C 0006 6100 F7F8 2F04 4851 3F3C 0004 A9EB 4851 3F3C 000A 6010 2F04 4851
// 3F3C 0004 A9EB 4851 3F3C 0008 6100 F8F0 6100 F7CE 2049 224C 6100 F8AE 6000 FB84
// 7026 6000 FB6C 487A 05CC 2F05 3F3C 0008 A9EB 6DEC 660E 5302 670E 4A42 6A00 FB38
// 6000 FB2E 5302 6604 6000 FB14 5301 6E28 6D0C 224C 2044 6100 F870 6000 FB46 4A42
// 6AE6 487A 0590 2F04 3F3C 0008 A9EB 67D0 6E00 FAF2 6000 FB0E 4A02 6A26 B541 6BD2
// 2045 43EE FFE6 6100 F840 4851 224C 41FA 055A 6100 F834 4851 3F3C 0006 A9EB 6000
// FB02 43EE FFE6 2045 6100 F81E 3011 0880 000F 0C40 3F7F 6D2E 4851 3F3C 0006 6100
// F720 2F04 4851 3F3C 0004 A9EB 0851 0007 0C51 4007 6D08 2045 0C50 407F 6C5C 4851
// 3F3C 000E 6014 2F04 4851 3F3C 0004 A9EB 0851 0007 4851 3F3C 000C 6100 F6E4 0851
// 0007 2F05 4851 3F3C 0006 A9EB 6100 F7F0 6100 F7F0 2049 6100 F724 5700 6606 6100
// F806 6008 5500 6704 6100 F800 41EE FFE6 224C 6100 F794 6000 FA6A 2045 6100 F78A
// 4851 3F3C 0002 6100 F698 43EE FFDC 2044 6100 F776 487A 0494 4851 4267 A9EB 4851
// 43EE FFE6 4851 3F3C 0004 A9EB 0851 0007 4851 3F3C 000A 6100 F668 0851 0007 608C
// 7021 7400 5301 6700 FA1A 6B00 FA04 614E 0802 0000 6604 6156 6004 6100 00B8 0242
// 0003 5542 6B04 0854 0007 6100 F752 6100 F786 4854 486E FFFC 3F3C 001C A9EB 302E
// FFFC 6A02 4440 5D40 6604 6100 F75E 6000 F9D2 7021 7401 5301 66B0 6000 F98E 487A
// 048C 4854 3F3C 000C A9EB D440 4E75 45FA 04EA 612E 4854 4852 3F3C 0004 A9EB 4852
// 4850 3F3C 0004 A9EB 4850 4854 3F3C 0002 A9EB 4E75 610C 4852 4850 3F3C 0004 A9EB
// 4E75 204C 43EE FFF0 6100 F69E 4851 4851 3F3C 0004 A9EB C34A 41EE FFDC 6100 F694
// 4850 41EE FFE6 6100 F68A 4850 3F3C 0006 A9EB 4E75 45FA 04D8 61BA 4852 4850 3F3C
// 0004 A9EB 487A 03DE 4852 3F3C 0008 A9EB 6E28 487A 03DA 4852 3F3C 0004 A9EB 4852
// 4850 3F3C 0002 A9EB 224C 6100 F63C 487A 035A 4854 4267 A9EB 4E75 0894 0007 487A
// 03AE 4854 3F3C 0002 A9EB 4850 204C 224A 6100 F616 487A 0398 4851 3F3C 0004 A9EB
// 4851 4854 3F3C 0004 A9EB 4854 3F3C 0002 A9EB 4851 4854 4267 A9EB 0854 0007 487A
// 0382 4854 4267 A9EB 4E75 7021 7400 5301 6B00 F89E 6700 F8AC 6100 FEE4 6134 E25A
// 642C 0854 0007 204C 43EE FFF0 6100 F5BA 4851 41FA 02D6 224C 6100 F5AE 4854 3F3C
// 0006 A9EB 6100 F61E 6704 0854 0007 6000 FE7A 45FA 044E 6100 FEDC 204C 43EE FFD2
// 6100 F586 4852 4851 3F3C 0004 A9EB 4851 41EE FFE6 4850 3F3C 0004 A9EB 487A 02E6
// 4852 3F3C 0008 A9EB 6E16 487A 02CE 4851 3F3C 0006 A9EB 4851 4850 4267 A9EB 604A
// 4850 204C 43EE FFDC 6100 F53E 487A 02CA 4851 3F3C 0002 A9EB 487A 02A0 4851 3F3C
// 0006 A9EB 4852 4851 3F3C 0004 A9EB 4851 4267 A9EB 487A 028E 4852 3F3C 0004 A9EB
// 4852 4851 4267 A9EB 2049 4850 4854 4267 A9EB 4E75 5301 6C10 41FA 0292 224C 6100
// F4E8 4201 8354 6002 6604 6000 F7B6 0894 0007 6108 4201 8354 6000 FDB0 7400 487A
// 01EA 4854 3F3C 0008 A9EB 6320 74FF 204C 43EE FFF0 6100 F4B2 4851 41FA 01CE 224C
// 6100 F4A6 4851 3F3C 0006 A9EB 2F1C 2F1C 3F14 518C 487A 029A 4854 3F3C 0008 A9EB
// 6E16 45FA 0392 6100 FDDA 4850 4854 3F3C 0004 A9EB 6000 0098 204C 43EE FFF0 6100
// F468 487A 0258 4851 3F3C 0004 A9EB 4851 41FA 0178 43EE FFDC 6100 F44E 4851 3F3C
// 0006 A9EB 487A 0164 4851 4267 A9EB 487A 015A 486E FFF0 4267 A9EB 487A 0220 4854
// 3F3C 0002 A9EB 204C 43EE FFD2 6100 F41A 486E FFF0 4854 3F3C 0006 A9EB 486E FFDC
// 4851 3F3C 0006 A9EB 45FA 030C 6100 FD54 4850 4854 3F3C 0004 A9EB 487A 01EA 4854
// 4267 A9EB 486E FFD2 4854 4267 A9EB 43EE FFF8 329F 231F 231F 4851 4854 3F3C 0002
// A9EB 4A42 6606 0854 0007 4E75 487A 015E 4854 4267 A9EB 4E75 487A 0166 4854 3F3C
// 0004 A9EB 487A 0164 4854 3F3C 000C A9EB 4A14 6A0A 487A 0154 4854 4267 A9EB 6000
// F662 0005 3FF6 B946 46AF F6CE 3BFF 3FF9 94F4 3221 4D61 FBEB 3FFB DC97 8903 D944
// 7893 3FFF 9F9E 3946 57CA 1D05 C001 CD6B C53A 46EC DC9A 4001 B483 97E7 BAE6 FCE0
// 0002 3FFF 8000 0000 0000 0000 C000 B818 35C3 CE0A 5E1D 3FFF FA3E DF0E DDF4 1A96
// 0003 BFEE FF88 90C8 1B20 9B79 3FF9 DA5C 84EF B813 272F 4003 97D3 BAEA F80F FD45
// 4009 AB86 71A1 95BE FF0C 0002 3FFF 8000 0000 0000 0000 4006 D548 7002 984B 5AB4
// 400A F775 612E 96B7 0780 3FFF 8000 0000 0000 0000 BFFF 8000 0000 0000 0000 0000
// 0000 0000 0000 0000 8000 0000 0000 0000 0000 4000 8000 0000 0000 0000 400D FFFE
// 0000 0000 0000 7FFF 0000 0000 0000 0000 FFFF 0000 0000 0000 0000 4000 C000 0000
// 0000 0000 3FFD 8000 0000 0000 0000 3FFE 8000 0000 0000 0000 3FFE C000 0000 0000
// 0000 3FFE E000 0000 0000 0000 3FFF C90F DAA2 2168 C235 3FFE C90F DAA2 2168 C235
// 400D 834E 0000 0000 0000 401D FFFF FFFE 0000 0000 3FFF B504 F333 F9DE 6484 3FFE
// B504 F333 F9DE 6484 4000 ADF8 5458 A2BB 4A9B 3FFE B172 17F7 D1CF 79AC 3FFE 93CD
// 3A2C 8198 E26A 3FFA DC2A 86B1 5FDB 6462 3FFD 8930 A2F4 F66A B18A 0003 3FFF 8000
// 0000 0000 0000 4007 88D8 B844 A6A8 5A30 400E 8A15 8A49 0979 2320 4013 FAA9 FE26
// FE63 F22B 0003 BFFE C250 86AE 43F5 CBF5 4006 9E76 EC66 BEE7 6BA2 C00C AF51 A1D6
// C4C4 AA01 4011 A71B FEC4 A997 F6CE 0003 3FFF 8000 0000 0000 0000 4007 A6D9 6A95
// FBDF 9685 400E C7A7 EA65 E85D 156B 4014 D26E 871C 7B17 52B2 0003 BFFB D57E 18D7
// A6F6 D758 4003 E364 937E 32B3 D072 C00A A62D 4056 586B C045 4010 8C49 AF68 520F
// 8C7A 0003 BFFF 8000 0000 0000 0000 4005 B513 0324 83C0 0955 C009 D1FF B242 5762
// E0CF 400A E190 9309 9376 66AB 0003 BFE9 B1FC 3363 D79B 2838 3FFD AA9D 71D8 3EC7
// 4CD1 C003 E9CD 8E24 B965 7DBB 4007 F09A 3670 9D4B 1836 0004 3FFF 98D3 1EAE 2AFA
// 5DAD 4003 8F79 4CD8 B3CD EFD9 4005 8E37 ED85 70B8 B368 4005 CDA4 BEA1 AC59 F3B8
// 4004 C405 9C55 4CF0 C656 0004 3FFF 8000 0000 0000 0000 4002 A23B 6C13 1F92 0E30
// 4003 C3C8 593D FA3A 486F 4003 82AE 6838 DDF5 D945 0000 0000 0000 0000 0000
// ""')
//
// pack7 = bytes.fromhex(""'
// 600A 0000 5041 434B 0007 0001 536F 0004 6A76 2F57 0002 544F 48E7 FE40 7200 7400
// 7600 7800 7A00 7C1F 43E8 0001 4A80 6E0E 6B06 12FC 0030 6028 12FC 002D 4480 D080
// CB05 C904 C703 C502 C301 51CE FFF2 611E 1202 611A 1203 6116 1204 6112 1205 610E
// 3009 9048 5300 1080 4CDF 027F 4E75 E859 6102 E959 4A46 6A06 4A01 670A 7C00 0001
// 0030 12C1 9201 4E75 302F 0004 2F57 0002 544F 5340 6A3E 48E7 7080 7000 7200 7600
// 1418 672A 0C10 002B 6708 0C10 002D 6608 7601 5288 5302 6716 720F C218 D080 D280
// E588 D081 5302 66F0 4A03 6702 4480 4CDF 010E 4E75 5340 6B0A 670C 0C40 0001 670A
// 4E75 4EFA 0010 4EFA 02A8 4EFA 0002 7201 E299 6002 7200 4E56 0000 48E7 3F30 4CEE
// 0070 000C CCB8 031A 2046 2245 7C00 1C10 47F0 6000 D0D1 2C08 2244 45E9 0004 2801
// 0604 0030 7E39 7000 7200 7400 7600 7A00 4291 24BC 054E 3030 357C 3131 0004 6100
// 008A 0C00 0020 67F6 0C00 00CA 67F0 0C00 0009 67EA 0C00 002B 6708 0C00 002D 6604
// 5211 6166 0C00 0030 650C 621C 08C4 000F 7CFF 6156 60EE 0C00 002E 6700 0074 4A44
// 6A00 01B0 6000 00E4 0C00 0039 630A 4A44 6A00 0130 6000 0086 7CFF 6118 6506 0C00
// 0039 63F6 0C00 002E 6600 0072 611C 6500 00BA 6062 0C02 0013 6D04 6E0A 5241 528A
// 1480 5202 6004 8112 5241 4A84 6A06 1018 6710 6006 B7C8 6D08 1018 0C00 0030 4E75
// 5288 08C4 0010 4A86 6A00 0148 6000 007C 61D8 6710 6506 0C00 0039 6312 4A44 6A00
// 0132 6018 08C4 000F 7CFF 5341 60E2 7CFF 5341 61A0 6554 0C00 0039 63F2 2C08 5386
// 0C00 0045 6706 0C00 0065 663E 619C 0C00 002B 670A 0C00 002D 6606 08C2 001F 618A
// 0C00 0030 651E 0C00 0039 6218 7CFF 0240 000F CAFC 000A DA40 0C45 2000 6504 3A3C
// 2000 60DA 4A86 6A00 00CA 5388 4A02 660A 4A44 6A2A 34BC 0130 6024 4A82 6A02 4445
// 0C31 0030 2004 660C 5302 0C02 0013 6702 5245 60EC 1342 0004 DA41 3345 0002 91EE
// 0014 226E 0010 3288 206E 0004 226E 0008 4844 1284 4CEE 0CFC FFE0 4E5E DEFC 0014
// 4ED0 0C00 00B0 6700 007C 5388 7649 6100 0094 6700 0064 0C00 004E 6656 7641 6100
// 0084 664E 764E 6100 007C 6600 0046 24FC 054E 3430 34BC 3030 2C08 6100 FECE 0C00
// 0028 662E 7600 6100 FEC2 6512 0C00 0039 6220 C6FC 000A 0240 000F D640 60E8 0C00
// 0029 660E 6156 E058 E81B 6150 E058 3480 6016 2046 6000 FF36 764E 6128 66F4 7646
// 6122 66EE 34BC 0149 7CFF 4A84 6A08 1010 6600 FF4C 6006 B7C8 6C00 FF44 08C4 0010
// 6000 FF3C 6100 FE64 0C00 0061 650A 0C00 007A 6204 0400 0020 B003 4E75 103C 000F
// C003 0C00 0009 6302 5E00 0600 0030 4E75 48E7 3C00 4E56 0000 206E 0020 2A10 206E
// 0018 226E 001C 2819 5248 74B0 7200 1219 671E 0804 0018 6706 10FC 002D 600A 0805
// 0018 6606 10FC 0020 5242 1011 0C00 003F 6700 00FE 0000 0020 0C00 0069 6700 0150
// 0C00 006E 6646 10FC 004E 10FC 0041 10FC 004E 10FC 0028 117C 0029 0003 5A42 7600
// 0C01 0005 6F02 7205 610C 2003 6108 E903 8680 7004 6068 5341 6FF8 1631 1000 0C03
// 0039 6F02 5F03 0203 000F 4E75 0C11 0030 6604 7201 7800 0805 0018 6600 009E 4A45
// 6E02 7A01 7001 6162 3601 48C3 5383 6E06 0C45 0001 6F0C 6160 3003 614E 3005 9041
// 6168 5442 6E6A 10FC 0065 48C4 D684 6D06 10FC 002B 6006 10FC 002D 4483 7000 43FA
// 00BE 5440 B671 00FE 6518 0C00 0008 6DF2 86F1 00FE 5242 6E38 0643 0030 10C3 4843
// 48C3 5540 6EEA 67EC 606E 6F0A D440 6E20 10D9 5340 6EFA 4E75 5242 6E14 10FC 002E
// 4E75 5242 6E0A 10FC 0030 5340 6CF4 4E75 206E 0018 30BC 013F 6048 3601 D644 6F22
// 4A44 6C0C 3003 61C2 61CE 7000 9044 6020 3001 61B6 3004 61D2 3005 6F1C 61BA 61CA
// 6016 7001 61C4 61B0 7000 9043 61BC 3001 6198 3004 D045 61B2 206E 0018 0642 0050
// 1082 4E5E 4CDF 013C DEFC 000C 4ED0 10FC 0049 10FC 004E 10BC 0046 5642 60DA 000A
// 0064 03E8 2710
// ""')

//#######################################################################
// Code for reading Finder info and resource forks
//#######################################################################

func rez_strip_comments(rez string) {
    pattern := regex.MustCompile(`(?://[^\n]*|/\*.*?\*/|("(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'))`)

    return pattern.ReplaceAllString(rez, `\1 `) // keep quotes, append a space to be safe
}

func rez_string_literal(string_with_quotes string) {
    pattern := regex.MustCompile(`(?:\\0x[0-9a-fA-F]{2}|\\.|.)`) // covers every character
    string_alone := string_with_quotes[1:-1]
    splits := pattern.FindAllSubmatchIndex(string_alone)

    retval := ""

    for loc := range splits {
        start := loc[0]
        end := loc[1]

        char := '?'
        switch end - start {
        case 1:
            char = string_alone[start]
        case 2:
            switch string_alone[start + 1] {
            case 'b':
                char = 8 // backspace
            case 't':
                char = 9 // tab
            case 'r':
                char = 10 // LF (opposite to convention)
            case 'v':
                char = 11 // vertical tab
            case 'f':
                char = 12 // form feed
            case 'n':
                char = 13 // CR (opposite to convention)
            case '?':
                char = 127 // backspace
            default:
                char = string_alone[start + 1]
            }
        case 5:
            char, _ = strconv.ParseInt(string_alone[start+3:start+5], 16, 8)
        }
        retval = append(retval, char)
    }

    return retval
}

func rez(path) (fork []byte, err error) {
    pattern := regex.MustCompile(
        `data\s*('(?:[^'\\]|\\.){4}')\s*` +
        `\(\s*` +
        `(-?\d+)\s*` +
        `(?:,\s*("(?:[^"\\]|\\.)*")\s*)?` +
        `((?:,\s*(?:\$[0-9a-fA-F]|sysheap|purgeable|locked|protected|preload)\s*)*)` +
        `\)\s*` +
        `\{\s*` +
        `((?:\$"[0-9A-Fa-f\s*]*"\s*)*)\s*` +
        `\}\s*;\s*|.`)

    rez, err := os.ReadFile(path)
    if err != nil {
        return nil, err
    }

    rez = rez_strip_comments(rez)

    type resource struct {
        type_ uint32
        id uint16
        flags uint8
        has_name bool
        name string
        data []byte
    }

    type_order := make([]uint32, 0)
    type_ids := make(map[uint32][]resource)

    splits := pattern.FindAllSubmatchIndex(rez)
    for loc := range splits {
        if loc[1] - loc[0] == 1 {
            return nil, errors.New(fmt.Sprintf("bad rez file %s", path))
        }

        type_str := rez[loc[2]:loc[3]]
        id_str := rez[loc[4]:loc[5]]
        name_str := rez[loc[6]:loc[7]]
        flags_str := rez[loc[8]:loc[9]]
        data_str := rez[loc[10]:loc[11]]

        var res resource

        res.type_ = binary.BigEndian.Uint32(rez_string_literal(type_str))
        res.id, err = strconv.ParseInt(id_str, 10, 16)
        if err != nil { // might fail with out-of-range number
            return nil, errors.New("out-of-range ID in res file")
        }

        if len(name_str) > 0 {
            res.has_name = true
            res.name = rez_string_literal(name_str)
        }

        for _, arg := range string.Split(flags_str, ",") {
            arg = strings.TrimSpace(arg)
            switch arg {
            case "sysheap":
                res.flags |= 0x40
            case "purgeable":
                res.flags |= 0x20
            case "locked":
                res.flags |= 0x10
            case "protected":
                res.flags |= 0x08
            case "preload":
                res.flags |= 0x04
            default: // regex guarantees that this is $FF
                theseflags, err := strconv.ParseInt(arg[1:], 16, 8)
                res.flags |= theseflags
            }
        }

        if ids, ok := type_ids[type_]; !ok {
            type_order = append(type_order, type_)
        }

        type_ids[type_] = append(type_ids[type_], res)
    }

    fork = make([]byte, 256) // append resource data as we go

    type_list := make([]byte, 2 + 8 * len(types)) // alloc type list, append ref list
    name_list := make([]byte, 0)

    binary.BigEndian.PutUint16(type_list, (len(type_order) - 1) % 0xffff)

    for type_n, type_ := range type_order {
        offset := 2 + 8 * type_n
        binary.BigEndian.PutUint32(type_list[offset:], type_)
        binary.BigEndian.PutUint16(type_list[offset+4:], len(type_ids[type_]) - 1)
        binary.BigEndian.PutUint16(type_list[offset+6:], len(type_list))

        for _, res := range type_ids[type_] {
            name_offset := uint16(0xffff)
            if res.has_name {
                name_offset = uint16(len(name_list))
                name_list = append(name_list, res.name...)
            }

            for i := 0; i < 12; i++ {
                type_list = append(type_list, 0)
            }
            binary.BigEndian.PutUint16(type_list[-12:], uint16(res.id))
            binary.BigEndian.PutUint16(type_list[-10:], name_offset)
            binary.BigEndian.PutUint32(type_list[-8:], (uint32(flags) << 24) | (len(fork) - 256))

            fork = append(fork, 0, 0, 0, 0)
            binary.BigEndian.PutUint32(fork[-4:], len(res.data))
            fork = append(fork, res.data...)
            for len(fork) % 4 != 0 {
                fork = append(fork, 0)
            }
        }
    }

    boundary := len(fork) // between resource data and resource map

    // Create resource map
    for i := 0; i < 28; i++ {
        fork = append(fork, 0)
    }
    binary.BigEndian.PutUint16(type_list[-4:], 28)
    binary.BigEndian.PutUint16(type_list[-2:], 28 + len(type_list))

    fork = append(fork, type_list)
    fork = append(fork, name_list)

    binary.BigEndian.PutUint32(fork, 0)
    binary.BigEndian.PutUint32(fork[4:], 256)
    binary.BigEndian.PutUint32(fork[8:], boundary - 256)
    binary.BigEndian.PutUint32(fork[12:], len(fork) - boundary)
}

//#######################################################################
// The Macintosh Toolbox. Wish me luck...
//#######################################################################

// a number for each directory encountered, usable as wdrefnum.w or dirid.l
var dnums []string

// the contents of every open fork, indexed by refnum
var filebuffers map[uint16][]byte

const onlyvolname = []byte("@")

// return 0 if invalid
func fcb_from_refnum(refnum uint16) uint32 {
    FSFCBLen := readw(0x3f6)
    FCBSPtr := readl(0x34e)

    if refnum / FSFCBLen >= 348 || refnum % FSFCBLen != 2 {
        return 0
    }

    return FCBSPtr + refnum
}

func read_cstring(addr uint32) []byte {
    for i := addr; i < len(mem); i++ {
        if mem[i] == 0 {
            return mem[addr:i]
        }
    }
}

func read_pstring(addr uint32) []byte {
    if addr == 0 {
        return
    }
    return mem[addr+1:addr+1+mem[addr]]
}

func write_pstring(addr uint32, str []byte) {
    if addr == 0 {
        return
    }
    mem[addr] = byte(len(str))
    copy(mem[addr+1:], str)
}

func get_host_path(number uint16, name []byte) (path string, errno int) {
    // If string is abolute then ignore the number, use the special root ID
    if bytes.Contains(name, []byte(":")) && !bytes.HasPrefix(name, []byte(":")) {
        number = 2
        root_and_name := bytes.SplitN(name, []byte(":"))
        name = root_and_name[1]

        if root_and_name[0] != onlyvolname {
            errno = -43 // fnfErr
            return
        }
    }

    if number > len(dnums) {
        errno = -32 // fnfErr
        return
    }
    path = dnums[number]

    components := bytes.Split(name, []byte(":"))

    // remove stray empty components, because they behave like '..'
    if len(components) > 0 && len(components[0]) == 0 {
        components = components[1:]
    }
    if len(components) > 0 && len(components[-1]) == 0 {
        components = components[:-1]
    }

    for component := range components {
        unicomponent := macToUnicode(component)
        if len(unicomponent) > 0 {
            path = filepath.Join(accum, unicomponent)
        } else {
            path = filepath.Parent(accum)
        }
    }
}

func listdir(path string) (macfiles [][]byte, errno int) {
    files, err := ioutil.ReadDir(path)
    if err != nil {
        errno = -39 // fnfErr
    }

    for name := range files {
        macfiles = append(macfiles, unicodeToMac(name))
    }

    // case, sort and :/ logic missing from here
}

func get_macos_dnum(path string) uint16 {
    for idx, maybepath := range dnums[2:] {
        if maybepath == path {
            return idx
        }
    }
    dnums = append(dnums, path)
    return len(dnums) - 1
}

func get_macos_date(path string) uint32 {
    return 0
    // logic missing from here
}

func is_regular_file(path) bool {
    stat, err := os.Stat(path)
    return err == nil && stat.Mode().IsRegular()
}

func paramblk_return(result int) {
    writew(readl(a0ptr) + 16, uint16(int16(result)))
    writel(d0ptr, uint32(int32(result))) // sign extension
}

func get_vol_or_dir() (num uint16) {
    pb := readl(a0ptr)
    trap := readl(d1ptr)

    if trap & 0x200 != 0 {
        num = readw(pb + 48 + 2) // lower word of dirID
    }
    if num == 0 {
        num = readw(pb + 22) // whole vRefNum
    }
}

func tOpen() {
    paramblk_return(0) // by default

    fork := 'd'
    if readl(d1ptr) & 0xff == 0xa {
        fork = 'r'
    }

    pb := read4(a0ptr)

    ioNamePtr := readl(pb + 18)
    ioName := read_pstring(ioNamePtr)
    ioPermssn := readb(pb + 27)

    number := get_vol_or_dir()

    path := get_host_path(number, ioName)
    if !is_regular_file(path) {
        paramblk_return(-39); return // fnfErr
    }

    var ioRefNum uint16
    var fcbPtr uint32
    for ioRefNum = 2; fcb_from_refnum(ioRefNum) != 0; ioRefNum += read2(0x3f6) {
        fcbPtr = read4(0x34e) + ioRefNum
        if read4(fcbPtr) != 0 {
            break
        }
    }
    // -42 // tmfoErr ??????

    var data []byte
    if fork == 'd' {
        data = os.ReadFile(path)
    } else if fork == 'r' {
        // Try various resource fork schemes, fall back on empty fork
        if rpath := filepath.Join(filepath.Dir(path), "RESOURCE.FRK", filepath.Base(path)); is_regular_file(rpath) {
            data = os.ReadFile(rpath)
        } else if rpath := path + ".rdump"; is_regular_file(rpath) {
            data = rez(rpath)
        }
    }

    flags := 0
    if ioPermssn != 1 {
        flags |= 1
    }
    if fork == 'r' {
        flags |= 2
    }

    filebuffers[ioRefNum] = data
    for i := 0; i < read2(0x3f6); i++ {
        writel(fcbPtr + i, 0) // zero the block for safety
    }
    writel(fcbPtr + 0, 1) // fake non-zero fcbFlNum
    writeb(fcbPtr + 4, flags) // fcbMdRByt
    writel(fcbPtr + 8, len(data)) // fcbEOF
    writel(fcbPtr + 20, 0xa8000) // fcbVPtr
    writel(fcbPtr + 58, uint32(get_macos_dnum(path.parent))) // fcbDirID
    write_pstring(fcbPtr + 62, strings.Replace(path.name, ":", -1)) // fcbCName

    writew(pb + 24, ioRefNum)
}

func tClose() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    ioRefNum := readw(pb + 24)
    fcb := fcb_from_refnum(ioRefNum)
    if fcb == 0 || readl(fcb) == 0 {
        paramblk_return(-38); return // fnOpnErr
    }

    number := readl(fcb + 58)
    string := read_pstring(fcb + 62)
    path := get_host_path(number, string)

    // Write out
    fcbMdRByt := readb(fcb + 4)
    buf := filebuffers[ioRefNum]
    delete(filebuffers, ioRefNum)
    if fcbMdRByt & 1 {
        os.WriteFile(path, buf)
    }

    // Free FCB
    for i := 0; i < read2(0x3f6); i++ {
        writel(fcbPtr + i, 0)
    }
}

func tReadWrite() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    ioRefNum := readw(pb + 24)
    fcb := fcb_from_refnum(ioRefNum)
    if fcb == 0 || readl(fcb) == 0 {
        paramblk_return(-38); return // fnOpnErr
    }

    buf := &filebuffers[ioRefNum]
    ioBuffer := readl(pb + 32)
    ioReqCount := readl(pb + 36)
    ioPosMode := readw(pb + 44)
    ioPosOffset := readl(pb + 46)
    fcbCrPs = readl(fcb + 16) // the mark
    fcbEOF = readl(fcb + 8) // leof

    if fcbEOF != len(buf) { // totally effed
        panic("recorded fcbEOF inconsistent with byte slice size")
    }

    var trymark int64
    switch ioPosMode % 4 {
    case 0: // fsAtMark
        trymark = int64(fcbCrPs)
    case 1: // fsFromStart
        trymark = int64(ioPosOffset)
    case 2: // fsFromLEOF
        trymark = int64(fcbEOF) + int32(ioPosOffset)
    case 3: // fsFromMark
        trymark = int64(fcbCrPs) + int32(ioPosOffset)
    }

    // assume that mark is inside the file
    mark := uint32(trymark)

    // handle mark outside file and continue
    if trymark > fcbEOF {
        mark = fcbEOF
        ioReqCount = 0
        paramblk_return(-39) // eofErr
    } else if trymark < 0 {
        mark = 0
        ioReqCount = 0
        paramblk_return(-40) // posErr
    }

    ioActCount := ioReqCount
    if readl(d1ptr) & 0xff == 3 { // _Write
        // if file is too short then lengthen the file
        for len(buf) < mark + ioActCount {
            *buf = append(*buf, 0)
        }
        writel(fcb + 8, len(buf)) // fcbEOF needs to be updated

        copy(buf[mark:mark+ioActCount], mem[ioBuffer:ioBuffer+ioActCount])

    } else { // _Read
        // if file is too short then shorten the read
        if len(buf) < mark + ioActCount {
            ioActCount = len(buf) - mark
        }

        copy(mem[ioBuffer:ioBuffer+ioActCount], buf[mark:mark+ioActCount])
    }

    writel(pb + 40, ioActCount)
    writel(pb + 46, mark + ioActCount) // ioPosOffset
    writel(fcb + 16, mark + ioActCount) // fcbCrPs
}

func tGetVInfo() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioVNPtr := readl(pb + 18)

    if ioVNPtr != 0 {
        write_pstring(ioVNPtr, unicodeToMac(onlyvolname))
    }
    writew(pb + 22, 2) // ioVRefNum: our "root volume" is 2

    writel(pb + 30, 0) // ioVCrDate
    writel(pb + 34, 0) // ioVLsMod
    writew(pb + 38, 0) // ioVAtrb
    writew(pb + 40, 100) // ioVNmFls
    writew(pb + 42, 0) // ioVBitMap
    writew(pb + 44, 0) // ioVAllocPtr
    writew(pb + 46, 0xffff) // ioVNmAlBlks
    writel(pb + 48, 0x200) // ioVAlBlkSiz
    if trap & 0x200 != 0 {
        writel(pb + 52, 0x200) // ioVClpSiz
        writew(pb + 56, 0x1000) // ioAlBlSt
        writel(pb + 58, 0) // ioVNxtFNum
        writew(pb + 62, 0xfff0) // ioVFrBlk
        writew(pb + 64, 0) // ioVSig2
        writew(pb + 66, 0) // ioVDrvInfo
        writew(pb + 68, 2) // ioVDRefNum
        writew(pb + 70, 0) // ioVFSID
        writel(pb + 72, 0) // ioVBkUp
        writew(pb + 76, 0) // ioVSeqNum
        writel(pb + 78, 0) // ioVWrCnt
        writel(pb + 82, 0) // ioVFilCnt
        writel(pb + 86, 0) // ioVDirCnt
        write(32, pb + 90, 0) // ioVFndrInfo
        writel(pb + 90, uint32(get_macos_dnum(systemFolder))) // must match BootDrive
    }
}

func tCreate() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioNamePtr := readl(pb + 18)
    ioName := read_pstring(ioNamePtr)

    number := get_vol_or_dir()
    path := get_host_path(number, ioName)

    fp, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0777)
    if err != nil {
        paramblk_return(-48); return // dupFNErr
    }
    defer fd.Close()
}

func tDelete() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    ioNamePtr = readl(pb + 18)
    ioName := read_pstring(ioNamePtr)

    number := get_vol_or_dir()
    path := get_host_path(number, ioName)

    os.Remove(path)
}

func tGetFInfo() { // also implements GetCatInfo
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioFDirIndex := int16(readw(pb + 28))
    ioNamePtr = readl(pb + 18)

    dirid := get_vol_or_dir()

    // removed "weird case for _HGetFInfo"

    fname := []byte("")
    return_fname := false

    if trap & 0xff == 0x60 && ioFDirIndex < 0 {
        return_fname = true
    } else if ioFDirIndex > 0 {
        return_fname = true

        path, errno := get_host_path(number)
        if errno != 0 {
            paramblk_return(errno); return
        }

        listing, errno := listdir(path)
        if errno != 0 {
            paramblk_return(errno); return
        }

        if ioFDirIndex >= len(listing) {
            paramblk_return(-43); return // fnfErr
        }

        fname = listing[ioFDirIndex - 1]
    } else {
        fname = read_pstring(ioNamePtr)
    }

    // clear our block of return values, which is longer for GetCatInfo
    for i := 0; (trap & 0xff == 0x60 && i < 84) || (i < 56); i++ {
        writeb(pb + 24 + i, 0)
    }

    path, errno := get_host_path(dirid, fname)
    if errno != 0 {
        paramblk_return(errno); return
    }

    if return_fname && ioNamePtr != 0 {
        write_pstring(ioNamePtr, fname)
        // missing logic to switch file separator
    }

    if !is_regular_file(path) {
        writeb(pb + 30, 1 << 4) // is a directory
        writel(pb + 48, uint32(get_macos_dnum(path))) // ioDrDirID
        writel(pb + 52, len(listdir(path))) // ioDrNmFls
    } else {
        // missing quite a bit of logic here
    }

    if trap & 0xff == 0x60 {
        writel(pb + 100, unt32(get_macos_dnum(filepath.Dir(path)))) // ioFlParID
    }

    date := get_macos_date(p)
    writel(pb + 72, date) // ioFlCrDat
    writel(pb + 76, date) // ioFlMdDat
}

func tSetFInfo() {
    paramblk_return(0)
//     ioNamePtr := readl(pb + 18)
//     ioName := read_pstring(ioNamePtr)
//
//     // idiom to get dirID for hierarchical call, but fall back on ioVRefNum
//     number := (readl(pb + 48) if trap & 0x200 else 0) || readw(pb + 22)
//
//     path = get_host_path(number=number, string=ioName)
//     if !path.exists() { // fnfErr
//         return -43
//     }
//     idump = path.parent / (path.name + ".idump")
//     typecreator = mem[a0+32:a0+40]
//     if typecreator != b"????????" || idump.exists() {
//         idump.write_bytes(typecreator)
//     }
//     // todo: mtime
}

func tGetEOF() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioRefNum := readw(pb + 24)

    fcb := fcb_from_refnum(ioRefNum)
    if fcb == 0 || readl(fcb) == 0 {
        paramblk_return(-38); return // fnOpnErr
    }

    writel(pb + 28, readl(fcb + 8)) // ioMisc = fcbEOF
}

func tSetEOF() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioRefNum := readw(pb + 24)
    ioMisc := readl(pb + 28)

    fcb := fcb_from_refnum(ioRefNum)
    if fcb == 0 || readl(fcb) == 0 {
        paramblk_return(-38); return // fnOpnErr
    }

    for len(filebuffers[ioRefNum]) < ioMisc {
        filebuffers[ioRefNum] = append(filebuffers[ioRefNum], 0)
    }

    if len(filebuffers[ioRefNum]) > ioMisc {
        filebuffers[ioRefNum] = filebuffers[ioRefNum][:ioMisc]
    }

    writel(fcb + 8, ioMisc) // fcbEOF

    if ioMisc < readl(fcb + 16) { // can't have mark beyond eof
        writel(fcb + 16, ioMisc)
    }
}

func tGetVol() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    if trap & 0x200 != 0 { // HGetVol
        writew(pb + 22, 2) // ioVRefNum = 2
        writel(pb + 48, uint32(get_macos_dnum(dnums[0]))) // ioDirID = number
    } else { // plain GetVol
        writew(pb + 22, get_macos_dnum(dnums[0])) // ioVRefNum = number
    }

    ioVNPtr := readl(pb + 18)
    if ioVNPtr != 0 {
        write_pstring(ioVNPtr, unicodeToMac(filepath.Base(dnums[0])))
    }
}

func tSetVol() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioRefNum := readw(pb + 24)

    ioVNPtr := readl(pb + 18)
    if ioVNPtr != 0 {
        volname := read_pstring(ioVNPtr)
        if !string.Contains(volname, ":") { // this is an absolute path
            volname += ":"
        }
        dnums[0] = get_host_path(2, volname)
    } else if trap & 0x200 != 0 { // HSetVol
        dnums[0] = dnums[readl(pb + 48)] // ioDirID
    } else { // plain SetVol
        dnums[0] = dnums[readw(pb + 22)] // ioVRefNum
    }
}

func tGetFPos() {
    // Act like _Read with ioReqCount=0 and ioPosMode=fsAtMark
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    writel(pb + 36, 0)
    writew(pb + 44, 0) // ioPosMode
    tReadWrite()
}

func tSetFPos() {
    // Act like _Read with ioReqCount=0
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    writel(pb + 36, 0) // ioReqCount
    tReadWrite()
}

func tFSDispatch() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    switch readw(d0ptr + 2) {
    case 1: // OpenWD
        // just return dirID as wdRefNum, because we treat them the same
        ioName := read_pstring(readl(pb + 18))
        ioWDDirID := readl(pb + 48)

        ioVRefNum := get_macos_dnum(get_host_path(ioWDDirID, ioName))
        writew(pb + 22, ioVRefNum)

    case 2: // CloseWD
        // do nothing

    case 7: // GetWDInfo
        // the opposite transformation to OpenWD
        writel(pb + 48, uint32(readw(pb + 22))) // ioWDDirID = ioVRefNum
        writew(pb + 32, 2) // ioWDVRefNum = 2 (our root)
        writel(pb + 28, 0) // ioWDProcID = who cares who created it

    case 8: // GetFCBInfo
        ioFCBIndx := readl(pb + 28)

        ioRefNum := readw(pb + 24)
        if ioFCBIndx != 0 { // treat as a 1-based index into open FCBs
            for ioRefNum = 2;; ioRefNum += read2(0x3f6) {
                fcb := fcb_from_refnum(ioRefNum)
                if fcb == 0 {
                    paramblk_return(-38); return // fnOpnErr
                }

                if readl(fcb) != 0 { // if open then decrement the index
                    ioFCBIndx--
                }

                if ioFCBIndx == 0 { // we found our match!
                    break
                }
            }
        }

        fcb := fcb_from_refnum(ioRefNum)
        if fcb == 0 || readl(fcb) == 0 {
            paramblk_return(-38); return // fnOpnErr
        }

        for i := 0; i < 2; i++ {
            writeb(pb + 20 + i, readb(fcb + i))
        }

        writew(pb + 24, ioRefNum)
        writew(pb + 52, 2) // ioFCBVRefNum
        writel(pb + 54, 0) // ioFCBClpSiz, don't care
        writel(pb + 58, readl(fcb + 58)) // ioFCBParID

        ioNamePtr := readl(pb + 18)
        write_pstring(ioNamePtr, read_pstring(fcb + 62))

    case 9: // GetCatInfo
        return tGetFInfo()

    case 26: // OpenDF
        return tOpen()

    case 27: // MakeFSSpec
        ioVRefNum := readw(pb + 22)
        ioDirID := readl(pb + 48)
        ioName := read_pstring(readl(pb + 18))
        ioMisc := readl(pb + 28)

        path := get_host_path(ioDirID, ioName)

        // The parent must exist
        if _, err := os.Stat(filepath.Dir(path)); os.IsNotExist(err) {
            paramblk_return(-39); return // fnfErr
        }

        writew(ioMisc, 2) // vRefNum = 2 always
        writel(ioMisc + 2, uint32(get_macos_dnum(filepath.Dir(path))))
        write_pstring(ioMisc + 6, unicodeToMac(filepath.Base(path)))

    default:
        panic(str.Sprintf("Not implemented: _FSDispatch d0=0x%x", readw(d0ptr + 2)))
    }
}

func read_fsspec(ptr uint32) (vRefNum uint16, dirID uint32, namePtr uint32) {
    return readw(ptr), readl(ptr + 2), ptr + 6 // pointer to name string only
}

func fsspec_to_pb(fsspec uint32, pb uint32) {
    vRefNum, dirID, namePtr := read_fsspec(fsspec)
    writew(pb + 22, vRefNum) // ioVRefNum
    writel(pb + 48, dirID) // ioDirID
    writel(pb + 18, namePtr) // ioNamePtr
}

// func highlevelhfsdispatch() {
// }
// //    global pc
//
//     // ToolServer relies on this to call other traps, which is a problem
//     selector := readb(d0ptr + 3) // d0.b
//
//     if selector == 1 { // pascal OSErr FSMakeFSSpec(short vRefNum, long dirID, ConstStr255Param fileName, FSSpecPtr spec)
//
//         spec := popl()
//         ioNamePtr = popl()
//         ioDirID = popl()
//         ioVRefNum = popw()
//
//         // Get ready to return when a callback_trap_word is executed
//         return_pc = pc
//         return_sp = readl(spptr)
//
//         // Create and populate a param block (longer than it needs to be)
//         push(128, 0)
//         pb = readl(spptr)
//         writel(a0ptr, pb) // a0 = pb
//
//         writew(pb + 22, ioVRefNum)
//         writel(pb + 48, ioDirID)
//         writel(pb + 18, ioNamePtr)
//         writel(pb + 28, spec) // ioMisc
//
//         // Push _Open and then another special word to the stack, and run them
//         pushw(callback_trap_word)
//         pushw(0xa260)
//         pushw(0x701b) // _MakeFSSpec
//         pc = readl(spptr)
//
//         // Return here when the special word gets called
//         @oneoff_callback
//         def fsmakefsspec_finish() {
//         }
//     }
// //            global pc
//             pc = return_pc
//             writel(spptr, return_sp)
//
//             ioResult = readw(pb + 16)
//             writew(readl(spptr), ioResult)
//
//     else if selector in (2, 3) { // pascal OSErr FSpOpenDF(const FSSpec *spec, char permission, short *refNum)
//         refNumPtr = popl()
//         ioPermssn := popw() >> 8
//         fsspec := popl()
//
//         // Get ready to return when a callback_trap_word is executed
//         return_pc = pc
//         return_sp := readl(spptr)
//
//         // Create and populate a param block (longer than it needs to be)
//         push(128, 0)
//         pb := readl(spptr)
//         writel(a0ptr, pb) // a0 = pb
//
//         fsspec_to_pb(fsspec, pb)
//         writeb(pb + 27, ioPermssn)
//
//         // Push _Open and then another special word to the stack, and run them
//         pushw(callback_trap_word)
//         pushw(0xa000 if selector == 3 else 0xa00a) // _Open or _OpenRF
//         pc = readl(spptr)
//
//         // Return here when the special word gets called
//         @oneoff_callback
//         def fspopendf_finish() {
//         }
//     }
// //            global pc
//             pc = return_pc
//             writel(spptr, return_sp)
//
//             ioRefnum = readw(pb + 24)
//             writew(refNumPtr, ioRefNum)
//             ioResult = readw(pb + 16)
//             writew(readl(spptr), ioResult)
//
//     else if selector == 0x4 { // pascal OSErr FSpCreate(const FSSpec  *spec, OSType creator, OSType fileType, ScriptCode scriptTag)
//         pass
//     } else if selector == 0x5 { // pascal OSErr FSpDirCreate(const FSSpec *spec, ScriptCode scriptTag, long *createdDirID)
//         pass
//     } else if selector == 0x6 { // pascal OSErr FSpDelete(const FSSpec *spec)
//         pass
//     } else if selector == 0x7 { // pascal OSErr FSpGetFInfo(const FSSpec *spec, FInfo *fndrInfo)
//         pass
//     } else if selector == 0x8 { // pascal OSErr FSpSetFInfo(const FSSpec *spec, const FInfo *fndrInfo)
//         pass
//     } else if selector == 0x9 { // pascal OSErr FSpSetFLock(const FSSpec *spec)
//         pass
//     } else if selector == 0xa { // pascal OSErr FSpRstFLock(const FSSpec *spec)
//         pass
//     } else if selector == 0xb { // pascal OSErr FSpRename(const FSSpec *spec, ConstStr255Param newName)
//         pass
//     } else if selector == 0xc { // pascal OSErr FSpCatMove(const FSSpec *source, const FSSpec *dest)
//         pass
//     } else if selector == 0xd { // pascal OSErr FSpExchangeFiles(const FSSpec *source, const FSSpec *dest)
//         pass
//     } else {
//         raise NotImplementedError(f"AA52 {hex(selector)}")
//
//
//     }

// Memory Manager OS traps

func return_memerr_and_d0(result int) {
    writew(0x220, uint16(result))
    writel(d0ptr, uint32(result))
}

func return_memerr(result int) {
    writew(0x220, uint16(result))
}

var block_sizes map[uint32]uint32
var master_ptrs map[uint32]bool

func tGetZone() {
    return_memerr_and_d0(0)
    ApplZone := readl(0x2aa)
    writel(a0ptr, ApplZone) // ApplZone
}

func tFreeMem() { // _FreeMem _MaxMem _CompactMem _PurgeSpace
    return_memerr(0)
    writel(d0ptr, 0x7ffffffe) // free
    writel(a0ptr, 0x7ffffffe) // growable (MaxMem only)
}

// Final common pathway for making heap blocks
// TODO: improve on this bump allocator
func tNewPtr() {
    size := readl(d0ptr)
    return_memerr_and_d0(0)

    for i := 0; i < 16; i++ {
        mem = append(mem, 0)
    }
    for len(mem) % 0x1000 != 0 {
        mem = append(mem, 0)
    }
    block := uint32(len(mem))
    for len(mem) < block + size {
        mem = append(mem, 0)
    }
    block_sizes[block] = size

    writel(a0ptr, block)
}

func tDisposPtr() {
    return_memerr_and_d0(0)
    ptr := readl(a0ptr)
    disposptr(ptr)
}

func tSetPtrSize() {
    ptr := readl(a0ptr)
    size := readl(d0ptr)

    if block_sizes[ptr] >= size {
        block_sizes[ptr] = size
        return_memerr_and_d0(0)
    } else {
        return_memerr_and_d0(-108) // memFullErr
    }
}

func tGetPtrSize() {
    return_memerr(0)
    writel(d0ptr, block_sizes[readl(a0ptr)])
}

func tNewHandle() {
    tNewPtr()

    ptr := readl(a0ptr)
    writel(ptr - 16, ptr) // stash the master pointer in the header
    writel(a0ptr, ptr - 16)
}

func tDisposHandle() {
    tDisposPtr(readl(readl(a0ptr)))
}

func tSetHandleSize() {
    handle := readl(a0ptr)
    size := readl(d0ptr)
    return_memerr_and_d0(0)

    ptr := readl(handle)
    oldsize := block_sizes[ptr]
    if oldsize >= size {
        // can shrink the handle
        block_sizes[ptr] = size
    } else {
        ptr2 := newptr(size)
        delete(master_ptrs, ptr)
        master_ptrs[ptr2] = handle
        copy(mem[ptr2:ptr2+size], mem[ptr:ptr+size])
        writel(handle, ptr2)
    }
}

func tGetHandleSize() {
    return_memerr(0)
    writel(d0ptr, block_sizes[readl(readl(a0ptr))]) // might die??
}

func tReallocHandle() {
    handle := readl(a0ptr)
    size := readl(d0ptr)
    emptyhandle(handle)
    writel(a0ptr, handle)
    writel(d0ptr, size)
    sethandlesize(handle, size)
}

func tRecoverHandle() {
    return_memerr(0) // preserves d0, oddly
    writel(a0ptr, master_ptrs[readl(a0)])
}

func tEmptyHandle() {
    handle := readl(a0ptr)
    writel(a0ptr, readl(handle))
    tDisposPtr()
    writel(handle, 0)
    return_memerr_and_d0(0)
}

func tBlockMove() {
    src := readl(a0ptr)
    dest := readl(a1ptr)
    size := readl(d0ptr)
    copy(mem[dest:dest+size], mem[src:src+size])
    return_memerr_and_d0(0)
}

func tHGetState() {
    handle := readl(a0ptr)
    flags := readb(handle + 4)
    writel(d0ptr, uint32(flags))
    return_memerr(0)
}

func tHSetState() {
    handle := readl(a0ptr)
    flags := readb(d0ptr + 3)
    writeb(handle + 4, flags)
    return_memerr(0)
}

// Trap Manager OS traps

// For historical reasons, unflagged Get/SetTrapAddress need to guess between OS/TB traps
func trap_kind(requested_trap uint16, requesting_trap uint16) (uint16, rune) {
    if requesting_trap & 0x200 != 0 { // newOS/newTool trap
        if requesting_trap & 0x400 {
            return requested_trap & 0x3ff, 't'
        } else {
            return requested_trap & 0xff, 'o'
        }
    } else { // guess, using traditional trap numbering
        requested_trap &= 0x1ff // 64k ROM had a single 512-entry trap table
        if requested_trap <= 0x4f || requested_trap == 0x54 || requested_trap == 0x57 {
            return requested_trap, 'o'
        } else {
            return requested_trap, 't'
        }
    }
}

func tGetTrapAddress() {
    trapnum, trapkind = trap_kind(readw(d0ptr + 2), readw(d1ptr + 2))
    if trapkind == 't' {
        trapnum += 0x100 // index into our special table
    }
    writel(a0ptr, trap_address_table[trapnum])
}
func tSetTrapAddress() {
    trapnum, trapkind = trap_kind(readw(d0ptr + 2), readw(d1ptr + 2))
    if trapkind == 't' {
        trapnum += 0x100 // index into our special table
    }
    trap_address_table[trapnum] = readl(a0ptr)
}

// Resource Manager Toolbox traps

// All map handles from TopMapHndl
func allResMaps() (list []uint32) {
    for handle := readl(0xa50); handle != 0; handle = readl(readl(handle) + 16) {
        list = append(list, handle)
    }
}

// All map handles from CurMap
func currentResMaps(stopAt1 bool) (list []uint32) {
    all_maps = allResMaps()
    CurMap := readw(0xa5a)
    for i, maphdl := range all_maps {
        if readw(readl(maphdl) + 20) == CurMap {
            return all_maps[i:]
        }
    }
}

// {{type_entry_1, id_entry_1, id_entry_2, ...}, {type_entry_2, ...}, ...}
func resMapEntries(resMap uint32) (retval [][]uint16) {
    resMap = readl(resMap) // handle to pointer

    refbase := readw(resMap + 24)
    namebase := readw(resMap + 26)
    num_types := readw(resMap + refbase) + 1

    for t := 0; t < num_types; t++ {
        this_type_entry := refbase + 2 + 8 * t
        num_ids := readw(resMap + this_type_entry + 4) + 1
        retval := append(retval, []uint32{this_type_entry})
        first_of_this_type := readw(resMap + this_type_entry + 6)

        for i := 0; i < num_ids; i++ {
            this_id_entry := refbase + first_of_this_type + 12 * i
            retval[-1] = append(retval[-1], this_id_entry)
        }
    }
}

func uniqueTypesInMaps(maps []uint32) (types []uint32) {
    var already map[uint32]bool

    for _, handle := range maps {
        ptr := readl(handle)
        for _, entries := range resMapEntries(handle) {
            type_entry := entries[0] // ignore the type entries
            the_type := readl(ptr + type_entry)
            if !already[the_type] {
                already[the_type] = true
                types = append(types, the_type)
            }
        }
    }
}

func uniqueIdsInMaps(the_type uint32, maps []uint32) (ids []uint16) {
    var already map[uint16]bool

    for _, handle := range maps {
        ptr := readl(handle)
        for _, entries := range resMapEntries(handle) {
            type_entry := entries[0] // ignore the type entries
            if the_type == readl(ptr + type_entry) {
                for _, id_entry := range entries[1:] {
                    the_id := readw(id_entry)
                    if !already[the_id] {
                        already[the_id] = true
                        ids = append(ids, the_id)
                    }
                }
            }
        }
    }
}

// Use the resource map to find the data
func resData(resMap uint32, type_entry, id_entry uint16) []byte {
    resMap = readl(resMap) // handle to pointer

    refnum := readw(resMap + 20)
    filedata := filebuffers[refnum]

    data_ofs := binary.BigEndian.Uint32(filedata) + (readl(resMap + id_entry + 4) & 0xffffff) + 4
    data_len := binary.BigEndian.Uint32(filedata[data_ofs-4:])
    return filedata[data_ofs:][:data_len]
}

func resToHand(resMap uint32, typeEntry, idEntry uint16, loadPlease bool) (handle uint32) {
    resMap = readl(resMap) // handle to pointer

    // Is a memory block already recorded?
    handle = readl(resMap + idEntry + 8)

    if loadPlease == false && handle == 0 {
        // Create empty handle
        call_m68k(executable_trap(0xa166)) // _NewEmptyHandle
        handle = readl(a0ptr)
    } else if loadPlease == true && handle == 0 {
        // Create full handle
        data := resData(resMap, typeEntry, idEntry)

        writel(d0ptr, len(data))
        call_m68k(executable_atrap(0xa122)) // _NewHandle
        handle = readl(a0ptr)

        copy(mem[readl(handle):], data)
    } else if loadPlease == true && handle != 0 && readl(handle) == 0 {
        // Fill empty handle
        data := resData(resMap, typeEntry, idEntry)

        writel(d0ptr, len(data))
        writel(a0ptr, handle)
        call_m68k(executable_atrap(0xa027)) // _ReallocHandle

        copy(mem[readl(handle):], data)
    }

    // Record memory block in map
    writel(resMap + idEntry + 8, handle)
}

func getResName(resMap uint32, idEntry uint16) (hasName bool, theName []byte) {
    resMap = readl(resMap) // handle to pointer

    nameList := readw(resMap + 26)
    nameOffset := readw(resMap + idEntry + 2)

    if nameOffset == 0xffff {
        return false, ""
    } else {
        return true, read_pstring(resMap + nameList + nameOffset)
    }
}

// func set_resource_name(map_handle, res_entry_ptr, name) {
//     if name == nil {
//         writew(res_entry_ptr + 2, 0xffff)
//
//     } else {
//         name_list_offset := readw(readl(map_handle) + 26) // from start of map
//         name_offset = gethandlesize(map_handle) // from start of map
//         writew(res_entry_ptr + 2, name_offset - name_list_offset)
//
//         // after set_handle_size, all pointers into the map are invalid
//         set_handle_size(map_handle, gethandlesize(map_handle) + 1 + len(name))
//         write_pstring(readl(map_handle) + name_offset, name)
//
//     }
// }

func setResError(err int) {
    writew(0xa60, int16(err))
}

func tResError() {
    ResError := readw(0xa60)
    writew(readl(spptr), ResError)
}

func tCurResFile() {
    CurMap := readw(0xa5a)
    writew(readl(spptr), CurMap)
}

func tUseResFile() {
    writew(0xa5a, popw()) // CurMap
}

func tOpenResFile() {
    strarg := popl()
    pushw(0) // zero vRefNum
    pushl(0) // zero dirID
    pushl(strarg)
    pushw(0) // zero permission
    tHOpenResFile()
}

func tOpenRFPerm() {
    permission = popw()
    vRefNum := popw()
    fileName := popl()
    pushw(vRefNum)
    pushl(0) // dirID
    pushl(fileName)
    pushw(permission)
    tHOpenResFile()
}

func tHOpenResFile() {
    permission := popw()
    ioNamePtr := popl()
    ioDirID := popl()
    ioVRefNum := popw()
    writew(readl(spptr), -1) // return "failed" refnum

    // Call _HOpenRF with a parameter block
    push(128, 0)
    pb := readl(spptr); writel(a0ptr, pb) // a0 = pb
    writew(pb + 22, ioVRefNum)
    writel(pb + 48, ioDirID)
    writel(pb + 18, ioNamePtr)
    call_m68k(executable_atrap(0xa20a)) // _HOpenRF
    pop(128)

    ioResult = readw(pb + 16)
    writew(0xa60, ioResult) // set ResError
    if ioResult != 0 {
        return
    }

    ioRefNum := readw(pb + 24)
    forkdata := filebuffers[ioRefNum] // access buffer directly, not _Read trap
    if len(forkdata) < 256 {
        writew(0xa60, -39) // ResErr = eofErr
        return
    }

    // The "resource map" sits at the end of the fork
    mapstart := binary.BigEndian.Uint32(forkdata[4:])
    maplen := binary.BigEndian.Uint32(forkdata[12:])

    // Create a handle to hold it
    writel(d0ptr, maplen)
    call_m68k(executable_atrap(0xa20a)) // _NewHandle for map
    maphdl := readl(a0ptr); mapptr := readl(maphdl)

    // The in-memory map's first 16b mirror the on-disk fork's first 16b
    copy(mem[maphdl:], forkdata[mapstart:][:maplen])
    copy(mem[maphdl:], forkdata[:16])
    writew(mapptr + 20, ioRefNum) // and there is a spot for the filenum too

    // Point TopMapHndl to us (start of the linked list)
    writel(mapptr + 16, readl(0xa50))
    writel(0xa50, maphdl)
    writew(0xa5a, ioRefNum) // CurMap = filenum so we are the first searched

    writew(readl(spptr), ioRefNum) // return refnum
}

func tCountTypes() {
    only1Please := gCurToolTrapNum & 0x3ff == 0x1c
    answer := len(uniqueTypesInMaps(currentResMaps(only1Please)))
    writew(readl(spptr), uint16(answer))
}

func tCountResources() {
    only1Please := gCurToolTrapNum & 0x3ff == 0xd
    the_type := popl()
    answer := len(uniqueIdsInMaps(the_type, currentResMaps(only1Please)))
    writew(readl(spptr), uint16(answer))
}

func tGetIndType() {
    only1Please := gCurToolTrapNum & 0x3ff == 0xf
    index := popw() - 1
    theTypePtr := popl()

    theType := 0
    typeList := uniqueTypesInMaps(currentResMaps(only1Please))
    if index < len(typeList) {
        theType = typeList[index]
    }

    writel(theTypePtr, theType)
}

// func tGetResInfo() {
//     nameptr := popl()
//     typeptr := popl()
//     idptr := popl()
//     handle := popl()
//
//     for _, map := range iter_resource_maps(top_only=false, include_inactive=true) {
//         for type_entry, res_entry in iter_map(map) {
//             if readl(res_entry + 8) == handle {
//                 if nameptr {
//                     write_pstring(nameptr, get_resource_name(map, res_entry) || "")
//                 }
//                 if typeptr {
//                     writel(typeptr, readl(type_entry))
//                 }
//                 if idptr {
//                     writew(idptr, readw(res_entry))
//
//                 }
//                 writew(0xa60, 0) // ResErr = noErr
//                 return
//
//             }
//         }
//     }
//     writew(0xa60, -192) // ResErr = resNotFound
// }

func tGetResource() {
    only1Please := gCurToolTrapNum & 0x3ff == 0x1f
    loadPlease := readb(0xa5e) != 0
    rid = popw()
    rtype = popl()

    var handle uint32
    for _, resMap := range currentResMaps(only1Please) {
        entries := resMapEntries(resMap)
        typeEntry := entries[0]
        for _, idEntry := range entries[1:] {
            if rtype == readl(typeEntry) && rid == readl(idEntry) {
                handle := resToHand(resMap, typeEntry, idEntry, loadPlease)
                goto found
            }
        }
    }
    found:

    writel(readl(spptr), handle)
    if handle == 0 {
        setResError(-192) // resNotFound
    } else {
        setResError(0)
    }
}

func tGetNamedResource() {
    only1Please := gCurToolTrapNum & 0x3ff == 0x20
    loadPlease := readb(0xa5e) != 0
    rname := readPString(popl())
    rtype = popl()

    var handle uint32
    for _, resMap := range currentResMaps(only1Please) {
        entries := resMapEntries(resMap)
        typeEntry := entries[0]
        for _, idEntry := range entries[1:] {
            if rtype == readl(typeEntry) && rname == getResName(resMap, idEntry) { // this wont work, fix later
                handle := resToHand(resMap, typeEntry, idEntry, loadPlease)
                goto found
            }
        }
    }
    found:

    writel(readl(spptr), handle)
    if handle == 0 {
        setResError(-192) // resNotFound
    } else {
        setResError(0)
    }
}

func tGetIndResource() {
    only1Please := gCurToolTrapNum & 0x3ff == 0xe
    loadPlease := readb(0xa5e) != 0
    rindex = popw()
    rtype = popl()

    var handle uint32
    for _, resMap := range currentResMaps(only1Please) {
        entries := resMapEntries(resMap)
        typeEntry := entries[0]
        for _, idEntry := range entries[1:] {
            if rtype == readl(typeEntry) {
                rindex--
                if rindex == 0 {
                    handle := resToHand(resMap, typeEntry, idEntry, loadPlease)
                    goto found
                }
            }
        }
    }
    found:

    writel(readl(spptr), handle)
    if handle == 0 {
        setResError(-192) // resNotFound
    } else {
        setResError(0)
    }
}

func tGetPattern() {
    id := popw()
    pushl(0x50415420) // PAT
    pushw(id)
    tGetResource()
}

func tGetCursor() {
    id := popw()
    pushl(0x43555253) // CURS
    pushw(id)
    tGetResource()
}

func tGetString() {
    id := popw()
    pushl(0x53545220) // STR
    pushw(id)
    tGetResource()
}

func tGetIcon() {
    id := popw()
    pushl(0x49434f4e) // ICON
    pushw(id)
    tGetResource()
}

func tGetPicture() {
    id := popw()
    pushl(0x50494354) // PICT
    pushw(id)
    tGetResource()
}

func tHomeResFile() {
    handle = popl()

    setResError(-192) // resNotFound
    writew(readl(spptr), 0xffff) // return this meaning "bad"

    for _, resMap := range currentResMaps(only1Please) {
        entries := resMapEntries(resMap)
        typeEntry := entries[0]
        for _, idEntry := range entries[1:] {
            if handle == readl(resMap + idEntry + 4) {
                setResError(0)
                writew(readl(spptr), readw(resMap + 20))
                return
            }
        }
    }
}

func tSizeRsrc() {
    handle = popl()

    setResError(-192) // resNotFound
    writel(readl(spptr), 0) // return this meaning "bad"

    for _, resMap := range currentResMaps(only1Please) {
        entries := resMapEntries(resMap)
        typeEntry := entries[0]
        for _, idEntry := range entries[1:] {
            if handle == readl(resMap + idEntry + 4) {
                setResError(0)
                writew(readl(spptr), uint32(len(resData(resMap, typeEntry, idEntry))))
                return
            }
        }
    }
}
// Segment Loader Toolbox traps

func tLoadSeg() {
    save := readRegs()

    segNum := popw()
    pushl(0)
    pushl(0x434f4445) // CODE
    pushw(segNum)
    call_m68k(executable_atrap(0xa9a9)) // _GetResource
    segPtr := readl(popl())

    first := readw(segPtr) // index of first entry within jump table
    count := readw(segPtr + 2) // number of jump table entries

    for i := first; i < first + count; i++ {
        jtEntry := readl(a5ptr) + 32 + 8*i

        offsetInSegment := readw(jtEntry)
        writew(jtEntry, segNum)
        writew(jtEntry + 2, 0x4ef9) // jmp
        writel(jtEntry + 4, segPtr + 4 + offsetInSegment)
    }

    pc -= 6

    writeRegs(save, a0ptr, a1ptr, d0ptr, d1ptr, d2ptr) // ??? really need to do this?
}

// Package Toolbox traps

// QuickDraw Toolbox traps
func tBitAnd() {
    result = popl() & popl()
    writel(readl(spptr), result)
}
func tBitXor() {
    result = popl() ^ popl()
    writel(readl(spptr), result)
}

func tBitNot() {
    result = ^popl()
    writel(readl(spptr), result)
}

func tBitOr() {
    result = popl() | popl()
    writel(readl(spptr), result)
}

func tBitShift() {
    by = signed(2, popw())
    result = popl()
    if by > 0 {
        result <<= by % 32
    } else {
        result >>= (-by) % 32
    }
    writel(readl(spptr), result)
}

func tBitTst() {
    bitNum := popl()
    bytePtr := popl()
    bytePtr += bitNum / 8
    bitNum %= 8
    result := readb(bytePtr) & (0x80 >> bitNum) != 0

    if result {
        writew(readl(spptr), 0x0100) // bool true
    } else {
        writew(readl(spptr), 0)
    }
}

func tBitSet() {
    bitNum := popl()
    bytePtr := popl()
    bytePtr += bitNum / 8
    bitNum %= 8
    writeb(bytePtr, readb(bytePtr) | (0x80 >> bitNum))
}

func tBitClr() {
    bitNum := popl()
    bytePtr := popl()
    bytePtr += bitNum / 8
    bitNum %= 8
    writeb(bytePtr, readb(bytePtr) & ^(0x80 >> bitNum))
}

// func tRandom() {
//     writew(readl(spptr), random.randint(0x10000))
// }

func tHiWord() {
    x = popw(); popw(); writew(readl(spptr), x)
}

func tLoWord() {
    popw(); x = popw(); writew(readl(spptr), x)
}

func tInitGraf() {
    a5 := readl(a5ptr)
    qd = popl()
    writel(a5, qd)
    writel(qd, 0xf8f8f8f8) // illegal thePort address
}

func tSetPort() {
    a5 := readl(a5ptr)
    qd := readl(a5)
    port := popl()
    writel(qd, port)
}

func tGetPort() {
    a5 := readl(a5ptr)
    qd := readl(a5)
    port = readl(qd)
    retaddr = popl()
    writel(retaddr, port)
}

// func tSetRect() {
//     br := popl(); tl = popl(); rectptr = popl()
//     writel(rectptr, tl); writel(rectptr + 4, br)
// }
//
// func tOffsetRect() {
//     dv = popw(); dh = popw(); rectptr = popl()
//     for delta, ptr in ((dv, 0), (dh, 2), (dv, 4), (dh, 6)) {
//         writew(rectptr + ptr, readw(rectptr + ptr) + delta)
//
//     }
// }
// OS and Toolbox Event Manager traps

// Misc traps

func tDebugStr() {
    string := read_pstring(popl())
    fmt.Print(macToUnicode(string))
}

// trap is in toolbox table but actually uses registers
func tSysError() {
    err := int16(readw(d0ptr + 2))
    panicstr := fmt.Sprintf("_SysError %d", err)
    if err == -491 { // display string on stack
        panicstr += macToUnicode(read_pstring(popl()))
    }
    panic(panicstr)
}


func tSysEnvirons() {
    block := readl(a0ptr)
    write(16, block, 0) // wipe
    writew(block) // environsVersion = 2
    writew(block + 2, 3) // machineType = SE
    writew(block + 4, 0x0700) // systemVersion = seven
    writew(block + 6, 3) // processor = 68020
}

func tGestalt() {
    selector := d0.to_bytes(4, "big")

    if trap & 0x600 == 0 { // ab=00
        var uint32 reply
        var int16 err
        switch mem[d0:d0+4] {
        case "sysv":
            reply = 0x09228000 // highest possible
        case "fs  ":
            reply = 2 // FSSpec calls, not much else
        case "fold":
            reply = 1 // Folder Manager present
        default:
            err = -5551 // gestaltUndefSelectorErr
        }

        writel(a0ptr, reply)
        writew(d0ptr, uint32(uint16(err)))

    } else if trap & 0x600 == 0x200 { // ab=01
        panic("NewGestalt unimplemented")

    } else if trap & 0x600 == 0x400 { // ab=10
        panic("ReplaceGestalt unimplemented")

    } else { // ab=11
        panic("GetGestaltProcPtr unimplemented")
    }
}

// func tAliasDispatch() {
//     selector = readl(regs)
//     if selector == 0 { // FindFolder
//         foundDirID = popl(); foundVRefNum = popl()
//         createFolder = popw() >> 8
//         folderType = popl().to_bytes(4, "big")
//         vRefNum := popw() // ignore volume number
//
//         known := {b"pref": "Preferences"}
//         filename := known.get(folderType, folderType.decode("ascii", "ignore"))
//         path := systemFolder/filename
//
//         if createFolder {
//             path.mkdir(exist_ok=true)
//
//         }
//         if createFolder || path.exists() {
//             oserr := 0 // noErr
//             writew(foundVRefNum, 2)
//             writel(foundDirID, uint32(get_macos_dnum(path)))
//         } else {
//             oserr := -43 // fnfErr
//
//         }
//         writew(readl(spptr), oserr)
//
//     } else {
//         raise NotImplementedError(f"_AliasDispatch {selector}")
//
//     }
// }

func tCmpString() {
    aptr := readl(a0ptr)
    bptr := readl(a1ptr)
    alen := readw(d0ptr)
    blen := readw(d0ptr + 2)
    diacSens := readw(d1ptr) & 0x200 == 0 // ,MARKS
    caseSens := readw(d1ptr) & 0x400 != 0 // ,CASE

    if relString(mem[aptr:][:alen], mem[bptr:][:blen], caseSens, diacSens) == 0 {
        writel(d0ptr, 0)
    } else {
        writel(d0ptr, 1)
    }
}

func tGetOSEvent() {
    write(16, a0, 0) // null event
    writel(d0ptr, 0xffffffff)
}

// ToolServer-specific code
func tMenuKey() {
    keycode := popw() & 0xff
    if keycode == 12 { // cmd-Q
        writel(readl(spptr), 0x00810005) // quit menu item, hardcoded sadly
        return
    }
    writel(readl(spptr), 0) // return nothing
}

func tGetNextEvent() {
    eventrecord := popl(); write(16, eventrecord, 0)
    mask := popw()

    // ToolServer-specific code: if accepting high-level events then do cmd-Q
    if mask & 0x400 {
        writew(eventrecord, 3) // keyDown
        writel(eventrecord + 2, 12) // Q
        writew(eventrecord + 14, 0x100) // command
        writew(readl(spptr), -1) // return true
        return

    }
    writew(readl(spptr), 0) // return false
}

func tWaitNextEvent() {
    pop(8) // ignore sleep and mouseRgn args
    tGetNextEvent()
}

func tExitToShell() {
    panic("ExitToShell")

}

// Munger and related traps

func tHandToHand() {
    hdl := readl(a0ptr); ptr = readl(hdl)
    size := gethandlesize(hdl)
    hdl2 := newhandle(size); ptr2 = readl(hdl2)
    memcpy(ptr2, ptr, size)
    writel(a0ptr, hdl2) // a0 = result
    writel(regs, 0) // d0 = noErr
}

func tPtrToXHand() {
    srcptr := readl(a0ptr) // a0
    dsthdl := readl(a1ptr) // a1
    size := readl(regs) // d0
    sethandlesize(dsthdl, size)
    dstptr := readl(dsthdl)
    memcpy(dstptr, srcptr, size)
    writel(a0ptr, dsthdl) // a0
    writel(regs, 0) // d0 = noErr
}

func tPtrToHand() {
    srcptr := readl(a0ptr) // a0
    size = readl(regs) // d0
    dsthdl = newhandle(size)
    dstptr = readl(dsthdl)
    memcpy(dstptr, srcptr, size)
    writel(a0ptr, dsthdl) // a0
    writel(regs, 0) // d0 = noErr
}

func tHandAndHand() {
    ahdl := readl(a0ptr); asize = gethandlesize(ahdl) // a0
    bhdl := readl(a1ptr); bsize = gethandlesize(bhdl) // a1
    sethandlesize(bhdl, asize + bsize)
    aptr := readl(ahdl); bptr = readl(bhdl)
    memcpy(bptr, aptr, size)
    writel(a0ptr, bhdl) // a0 = dest handle
    writel(regs, 0) // d0 = noErr

}

// Trivial do-nothing traps

func tNop() {
}

func tClrD0() {
    writel(d0ptr, 0)
}

func tClrD0A0() {
    writel(d0ptr, 0)
    writel(a0ptr, 0)
}

func tPop2() {
    writel(spptr, readl(spptr) + 2)
}

func tPop4() {
    writel(spptr, readl(spptr) + 4)
}

func tPop6() {
    writel(spptr, readl(spptr) + 6)
}

func tPop8() {
    writel(spptr, readl(spptr) + 8)
}

func tPop10() {
    writel(spptr, readl(spptr) + 10)
}

func tRetZero() {
    writel(readl(spptr), 0)
}

func tPop2RetZero() {
    sp := readl(spptr) + 2
    writel(spptr, sp)
    writel(sp, 0)
}

func tPop4RetZero() {
    sp := readl(spptr) + 4
    writel(spptr, sp)
    writel(sp, 0)
}

func tPop6RetZero() {
    sp := readl(spptr) + 6
    writel(spptr, sp)
    writel(sp, 0)
}

func tPop8RetZero() {
    sp := readl(spptr) + 8
    writel(spptr, sp)
    writel(sp, 0)
}

func tPop10RetZero() {
    sp := readl(spptr) + 10
    writel(spptr, sp)
    writel(sp, 0)
}

var gCurToolTrapNum int

func lineA(inst uint16) {
    if inst & 0x800 != 0 { // Toolbox trap
        // Push a return address unless autoPop is used
        if inst & 0x400 == 0 {
            pushl(pc)
        }

        pc = readl(kOSTable + ((inst & 0xff) * 4))
    } else { // OS trap
        writew(d1ptr + 2, inst)

        pushl(readl(a2ptr))
        pushl(readl(d2ptr))
        pushl(readl(d1ptr))
        pushl(readl(a1ptr))
        if inst & 0x100 == 0 {
            pushl(readl(a0ptr))
        }

        call_m68k(readl(kToolTable + ((inst & 0x3ff) * 4)))

        if inst & 0x100 == 0 {
            writel(a0ptr, popl())
        }

        writel(a1ptr, popl())
        writel(d1ptr, popl())
        writel(d2ptr, popl())
        writel(a2ptr, popl())
    }
}

func lineF(inst uint16) {
    check_for_lurkers()
    if inst & 0x800 != 0 { // Go implementation of Toolbox trap
        my_traps[os_table + (inst & 0xff)]()
    } else { // Go implementation of OS trap
        my_traps[tb_table + (inst & 0x3ff)]()
    }
    pc = popl()
}

// Set up the Toolbox and launch ToolServer

const (
    kOSTable = 0x400
    kToolTable = 0x800 // up to 0x1800
    kStackBase = 0x40000 // extends down, note that registers are here too!
    kA5World = 0x58000 // 0x8000 below and 0x8000 above, so 5xxxx is in A5 world
    kFakeHeapHeader = 0x90000 // very short
    kATrapTable = 0xa0000 // 0x10000 above
    kFCBTable = 0xb0000 // 0x8000 above
    kDQE = 0xb9000 // 0x4 below and 0x10 above
    kVCB = 0xba000 // ????
    kFTrapTable = 0xf0000 // 0x10000 above
    kHeap = 0x100000 // extends up
)


func check_for_lurkers() {
    // we might do more involved things here, like check for heap corruption
    mem[:64] = bytes(64)
}

// Get an address to jump to
func executable_atrap(trap uint16) (addr uint32) {
    addr = kATrapTable + (trap & 0xfff) * 16

    writew(addr, trap) // consider using autoPop instead?
    writew(addr + 2, 0x4e75) // RTS
}

// Get an address to jump to
func executable_ftrap(trap uint16) (addr uint32) {
    addr = kFTrapTable + (trap & 0xfff) * 16

    writew(addr, trap)
}

var systemFolder string

func main() {
    mem = make([]byte, kHeap)

    // Poison low memory
    for i := 0x40; i < kStackBase; i += 2 {
        writeb(i, 0x68f1)
    }

    // Starting point for stack
    writel(spptr, kStackBase)
    writel(0x908, kStackBase) // CurStackBase

    // A5 world
    writel(a5ptr, kA5World)

    // Single fake heap zone, enough to pass validation
    writel(0x118, kFakeHeapHeader) // TheZone
    writel(0x2a6, kFakeHeapHeader) // SysZone
    writel(0x2aa, kFakeHeapHeader) // ApplZone
    writel(kFakeHeapHeader, 0xffffffe) // bkLim
    writel(0x130, 0) // ApplLimit

    // 1 Drive Queue Element
    writew(0x308, 0) // DrvQHdr.QFlags
    writel(0x308+2, kDQE) // DrvQHdr.QHead
    writel(0x308+6, kDQE) // DrvQHdr.QTail
    for (i := -4; i += 2; i < 16) {
        writew(kDQE + i, 0)
    }

    // 1 Volume Control Block is needed for the "GetVRefNum" glue routine
    for (i := 0; i += 2; i < 178) {
        writew(kVCB + i, 0)
    }
    writew(kVCB + 78, 2) // vcbVRefNum
    write_pstring(kVCB + 44, onlyvolname) // vcbVName

    // File Control Block table
    writel(0x34e, kFCBTable) // FCBSPtr
    writew(0x3f6, 94) // FSFCBLen
    writew(kFCBTable, 2 + 94 * 348) // size of FCB table

    // Misc globals
    writew(0x210, get_macos_dnum(systemFolder)) // BootDrive
    writel(0x2f4, 0) // CaretTime = 0 ticks
    writel(0x316, 0) // we don't implement the 'MPGM' interface
    writel(0x31a, 0x00ffffff) // Lo3Bytes
    writel(0x33c, 0) // IAZNotify = nothing to do when swapping worlds
    write_pstring(0x910, "ToolServer")
    writel(0x9d6, 0) // WindowList empty
    writel(0xa02, 0x00010001) // OneOne
    writel(0xa06, 0xffffffff) // MinusOne
    writel(0xa1c, newhandle(6)) // MenuList empty
    writel(0xa50, 0) // TopMapHndl

    systemFolder, err := ioutil.TempDir("", "NuMPW")
    if err != nil {
        panic("Failed to create temp directory")
    }

    // Disable the status window in preferences
    os.MkdirAll(filepath.Join(systemFolder, "Preferences", "MPW"))
    os.WriteFile(filepath.Join(systemFolder, "Preferences", "MPW", "ToolServer Prefs"), make([]byte, 9))

    // Open a script as if from Finder
    writel(d0ptr, 128)
    call_m68k(executable_atrap(0xa122))
    appParms := readl(a0ptr)
    writel(0xaec, appParms)
    appParms = readl(appParms) // handle to pointer
    writew(appParms + 2, 1) // one file
    writew(appParms + 4, get_macos_dnum(systemFolder))
    writel(appParms + 6, 0x54455854) // TEXT
    writePstring(appParms + 12, "Script")

    os.WriteFile(filepath.Join(systemfolder, "Script"), "set")
    os.WriteFile(filepath.Join(systemfolder, "Script.idump"), "TEXTMPS ")
    os.Create(filepath.Join(systemfolder, "Script.out"))
    os.Create(filepath.Join(systemfolder, "Script.err"))
}



// Do some prep that requires loading code

pushw(callback_trap_word)
pc = readl(spptr)

func open_toolserver() {
}
//    global pc

    pushw(callback_trap_word)
    pushw(0xa81a) // _HOpenResFile
    pc = readl(spptr)

    toolserver := Path(os.Args[1]).resolve()
    push(32, 0); filenameptr = readl(spptr)
    write_pstring(filenameptr, strings.Replace(toolserver.name, ":", -1))

    pushw(0) // space for return, we don't use it
    pushw(2) // vRefNum
    pushl(get_macos_dnum(toolserver.parent)) // dirID
    pushl(filenameptr)
    pushw(0) // permission

    @oneoff_callback
    def load_code() {
    }
//        global pc

        writew(0xa58, readw(0xa5a)) // SysMap = CurMap

        pushw(callback_trap_word)
        pushw(0xa9a0) // _GetResource
        pc = readl(spptr)

        pushl(0) // space for returned CODE 0 handle
        pushl(int.from_bytes(b"CODE", "big"))
        pushw(0)

        @oneoff_callback
        def run_code() {
        }
//            global pc

            handle = popl()
            if !handle {
                1/0
            }
            pointer = readl(handle)

            jtsize = readl(pointer + 8)
            jtoffset = readl(pointer + 12)

            memcpy(a5world + jtoffset, pointer + 16, jtsize)

            pc = a5world + jtoffset + 2
            pushw(0xa9f4) // _ExitToShell
            pushl(readl(spptr)) // ...which is where we will return

try {
    run_m68k_interpreter()
}
except SystemExit { // happens when we reach ExitToShell
    pass
}
finally {
    for _, ioRefNum := range everyfref {
        tClose(-1, -1, -1, -1, ioRefNum=ioRefNum)

    }
    tmp.cleanup()
}

const os_base = 0
const tb_base = 0x100
const my_traps [0x100+0x400]func() = {
    os_base + 0x00: tOpen                       // _Open
    os_base + 0x01: tClose                      // _Close
    os_base + 0x02: tReadWrite                  // _Read
    os_base + 0x03: tReadWrite                  // _Write
    os_base + 0x07: tGetVInfo                   // _GetVInfo
    os_base + 0x08: tCreate                     // _Create
    os_base + 0x09: tDelete                     // _Delete
    os_base + 0x0a: tOpen                       // _OpenRF
    os_base + 0x0c: tGetFInfo                   // _GetFInfo
    os_base + 0x0d: tSetFInfo                   // _SetFInfo
    os_base + 0x11: tGetEOF                     // _GetEOF
    os_base + 0x12: tSetEOF                     // _SetEOF
    os_base + 0x13: os_pb_trap                  // _FlushVol
    os_base + 0x14: tGetVol                     // _GetVol
    os_base + 0x15: tSetVol                     // _SetVol
    os_base + 0x18: tGetFPos                    // _GetFPos
    os_base + 0x1a: tGetZone                    // _GetZone
    os_base + 0x1b: tClrD0A0                    // _SetZone
    os_base + 0x1c: tFreeMem                    // _FreeMem
    os_base + 0x1d: tFreeMem                    // _MaxMem
    os_base + 0x1e: tNewPtr                     // _NewPtr
    os_base + 0x1f: tDisposPtr                  // _DisposPtr
    os_base + 0x20: tSetPtrSize                 // _SetPtrSize
    os_base + 0x21: tGetPtrSize                 // _GetPtrSize
    os_base + 0x22: tNewHandle                  // _NewHandle
    os_base + 0x23: tDisposHandle               // _DisposHandle
    os_base + 0x24: tSetHandleSize              // _SetHandleSize
    os_base + 0x25: tGetHandleSize              // _GetHandleSize
    os_base + 0x26: tGetZone                    // _HandleZone
    os_base + 0x27: tReallocHandle              // _ReallocHandle
    os_base + 0x28: tRecoverHandle              // _RecoverHandle
    os_base + 0x29: tClrD0                      // _HLock
    os_base + 0x2a: tClrD0                      // _HUnlock
    os_base + 0x2b: tEmptyHandle                // _EmptyHandle
    os_base + 0x2c: tClrD0A0                    // _InitApplZone
    os_base + 0x2d: tClrD0A0                    // _SetApplLimit
    os_base + 0x2e: tBlockMove                  // _BlockMove
    os_base + 0x30: tGetOSEvent                 // _OSEventAvail
    os_base + 0x31: tGetOSEvent                 // _GetOSEvent
    os_base + 0x32: tClrD0A0                    // _FlushEvents
    os_base + 0x36: tClrD0A0                    // _MoreMasters
    os_base + 0x3c: tCmpString                  // _CmpString
    os_base + 0x40: tClrD0A0                    // _ResrvMem
    os_base + 0x44: tSetFPos                    // _SetFPos
    os_base + 0x46: tGetTrapAddress             // _GetTrapAddress
    os_base + 0x47: tSetTrapAddress             // _SetTrapAddress
    os_base + 0x48: tGetZone                    // _PtrZone
    os_base + 0x49: tClrD0                      // _HPurge
    os_base + 0x4a: tClrD0                      // _HNoPurge
    os_base + 0x4b: tClrD0                      // _SetGrowZone
    os_base + 0x4c: tFreeMem                    // _CompactMem
    os_base + 0x4d: tClrD0A0                    // _PurgeMem
    os_base + 0x55: tNop                        // _StripAddress
    os_base + 0x60: tFSDispatch                 // _FSDispatch
    os_base + 0x62: tFreeMem                    // _PurgeSpace
    os_base + 0x63: tClrD0A0                    // _MaxApplZone
    os_base + 0x64: tClrD0                      // _MoveHHi
    os_base + 0x69: tHGetState                  // _HGetState
    os_base + 0x6a: tHSetState                  // _HSetState
    os_base + 0x90: tSysEnvirons                // _SysEnvirons
    os_base + 0xad: tGestalt                    // _Gestalt
    tb_base + 0x00d: tCountResources            // _Count1Resources
    tb_base + 0x00e: tGetIndResource            // _Get1IndResource
    tb_base + 0x00f: tGetIndType                // _Get1IndType
    tb_base + 0x01a: tHOpenResFile              // _HOpenResFile
    tb_base + 0x01c: tCountTypes                // _Count1Types
    tb_base + 0x01f: tGetResource               // _Get1Resource
    tb_base + 0x020: tGetNamedResource          // _Get1NamedResource
    tb_base + 0x023: tAliasDispatch             // _AliasDispatch
    tb_base + 0x034: tPop2                      // _SetFScaleDisable
    tb_base + 0x050: tNop                       // _InitCursor
    tb_base + 0x051: tPop4                      // _SetCursor
    tb_base + 0x052: tNop                       // _HideCursor
    tb_base + 0x053: tNop                       // _ShowCursor
    tb_base + 0x055: tPop8                      // _ShieldCursor
    tb_base + 0x056: tNop                       // _ObscureCursor
    tb_base + 0x058: tBitAnd                    // _BitAnd
    tb_base + 0x059: tBitXor                    // _BitXor
    tb_base + 0x05a: tBitNot                    // _BitNot
    tb_base + 0x05b: tBitOr                     // _BitOr
    tb_base + 0x05c: tBitShift                  // _BitShift
    tb_base + 0x05d: tBitTst                    // _BitTst
    tb_base + 0x05e: tBitSet                    // _BitSet
    tb_base + 0x05f: tBitClr                    // _BitClr
    tb_base + 0x060: tWaitNextEvent             // _WaitNextEvent
    tb_base + 0x061: tRandom                    // _Random
    tb_base + 0x06a: tHiWord                    // _HiWord
    tb_base + 0x06b: tLoWord                    // _LoWord
    tb_base + 0x06e: tInitGraf                  // _InitGraf
    tb_base + 0x06f: tPop4                      // _OpenPort
    tb_base + 0x073: tSetPort                   // _SetPort
    tb_base + 0x074: tGetPort                   // _GetPort
    tb_base + 0x0a7: tSetRect                   // _SetRect
    tb_base + 0x0a8: tOffsetRect                // _OffsetRect
    tb_base + 0x0d8: tRetZero                   // _NewRgn
    tb_base + 0x0fe: tNop                       // _InitFonts
    tb_base + 0x112: tNop                       // _InitWindows
    tb_base + 0x124: tRetZero                   // _FrontWindow
    tb_base + 0x130: tNop                       // _InitMenus
    tb_base + 0x137: tNop                       // _DrawMenuBar
    tb_base + 0x138: tPop2                      // _HiliteMenu
    tb_base + 0x139: tPop6                      // _EnableItem
    tb_base + 0x13a: tPop6                      // _DisableItem
    tb_base + 0x13c: tPop4                      // _SetMenuBar
    tb_base + 0x13e: tMenuKey                   // _MenuKey
    tb_base + 0x149: tPop2RetZero               // _GetMenuHandle
    tb_base + 0x14d: tPop8                      // _AppendResMenu
    tb_base + 0x170: tGetNextEvent              // _GetNextEvent
    tb_base + 0x175: tRetZero                   // _TickCount
    tb_base + 0x179: tPop2                      // _CouldDialog
    tb_base + 0x17b: tNop                       // _InitDialogs
    tb_base + 0x17c: tPop10RetZero              // _GetNewDialog
    tb_base + 0x194: tCurResFile                // _CurResFile
    tb_base + 0x197: tOpenResFile               // _OpenResFile
    tb_base + 0x198: tUseResFile                // _UseResFile
    tb_base + 0x199: tPop2                      // _UpdateResFile
    tb_base + 0x19b: tPop2                      // _SetResLoad
    tb_base + 0x19c: tCountResources            // _CountResources
    tb_base + 0x19d: tGetIndResource            // _GetIndResource
    tb_base + 0x19e: tCountTypes                // _CountTypes
    tb_base + 0x19f: tGetIndType                // _GetIndType
    tb_base + 0x1a0: tGetResource               // _GetResource
    tb_base + 0x1a1: tGetNamedResource          // _GetNamedResource
    tb_base + 0x1a3: tPop4                      // _ReleaseResource
    tb_base + 0x1a4: tHomeResFile               // _HomeResFile
    tb_base + 0x1a5: tSizeRsrc                  // _SizeRsrc
    tb_base + 0x1a8: tGetResInfo                // _GetResInfo
    tb_base + 0x1af: tResError                  // _ResError
    tb_base + 0x1b4: tNop                       // _SystemTask
    tb_base + 0x1b8: tGetPattern                // _GetPattern
    tb_base + 0x1b9: tGetCursor                 // _GetCursor
    tb_base + 0x1ba: tGetString                 // _GetString
    tb_base + 0x1bb: tGetIcon                   // _GetIcon
    tb_base + 0x1bc: tGetPicture                // _GetPicture
    tb_base + 0x1bd: tPop10RetZero              // _GetNewWindow
    tb_base + 0x1c0: tPop2RetZero               // _GetNewMBar
    tb_base + 0x1c4: tOpenRFPerm                // _OpenRFPerm
    tb_base + 0x1c8: tNop                       // _SysBeep
    tb_base + 0x1c9: tSysError                  // _SysError
    tb_base + 0x1cc: tNop                       // _TEInit
    tb_base + 0x1e1: tHandToHand                // _HandToHand
    tb_base + 0x1e2: tPtrToXHand                // _PtrToXHand
    tb_base + 0x1e3: tPtrToHand                 // _PtrToHand
    tb_base + 0x1e4: tHandAndHand               // _HandAndHand
    tb_base + 0x1e5: tPop2                      // _InitPack
    tb_base + 0x1e6: tNop                       // _InitAllPacks
    tb_base + 0x1eb: tFP68K                     // _FP68K
    tb_base + 0x1ec: tElems68K                  // _Elems68K
    tb_base + 0x1ee: tDecStr68K                 // _DecStr68K
    tb_base + 0x1f0: tLoadSeg                   // _LoadSeg
    tb_base + 0x1f1: tPop4                      // _UnloadSeg
    tb_base + 0x1f4: tExitToShell               // _ExitToShell
    tb_base + 0x1fa: tRetZero                   // _UnlodeScrap
    tb_base + 0x1fb: tRetZero                   // _LodeScrap
    tb_base + 0x3ff: tDebugStr                  // _DebugStr
}