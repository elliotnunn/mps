package main

import (
	"fmt"
	"math/bits"
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
	regs  = 0x80000
	d0ptr = regs
	d1ptr = regs + 4
	d2ptr = regs + 8
	d3ptr = regs + 12
	d4ptr = regs + 16
	d5ptr = regs + 20
	d6ptr = regs + 24
	d7ptr = regs + 28
	a0ptr = regs + 32
	a1ptr = regs + 36
	a2ptr = regs + 40
	a3ptr = regs + 44
	a4ptr = regs + 48
	a5ptr = regs + 52
	a6ptr = regs + 56
	spptr = regs + 60
)

func read(numbytes uint32, addr uint32) (val uint32) {
	for i := uint32(0); i < numbytes; i++ {
		val <<= 8
		val += uint32(mem[addr+i])
	}
	return
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

func write(numbytes uint32, addr uint32, val uint32) {
	for i := numbytes; i > 0; i-- {
		mem[addr+i-1] = byte(val)
		val >>= 8
	}
	return
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
	mem[addr] = byte(val)
}

func push(size uint32, data uint32) {
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
	writeb(ptr+1, 0)
	writeb(ptr, val)
}

func pop(size uint32) uint32 {
	ptr := address_by_mode(31, size) // (A7)+
	return read(size, ptr)
}

func popl() uint32 {
	ptr := readl(spptr)
	writel(spptr, ptr+4)
	return readl(ptr)
}

func popw() uint16 {
	ptr := readl(spptr)
	writel(spptr, ptr+2)
	return readw(ptr)
}

func popb() uint8 {
	ptr := readl(spptr)
	writel(spptr, ptr+2)
	return readb(ptr)
}

func regAddr(reg uint16) uint32 {
	return regs + uint32(reg&0xf)*4
}

func aregAddr(reg uint16) uint32 {
	return a0ptr + uint32(reg&0xf)*4
}

func readRegs() (reglist [16]uint32) {
	for i := 0; i < 16; i++ {
		reglist[i] = readl(regs + uint32(4*i))
	}
	return
}

func writeRegs(reglist [16]uint32, which ...uint32) {
	for _, i := range which {
		writel(i, reglist[(i-regs)/4])
	}
}

func readPstring(addr uint32) macstring {
	return macstring(mem[addr+1:][:mem[addr]])
}

func writePstring(addr uint32, str macstring) {
	if addr == 0 {
		return
	}
	if len(str) > 255 {
		panic("too-long pascal string")
	}
	mem[addr] = byte(len(str))
	copy(mem[addr+1:], str[:])
}

func signextend(size uint32, n uint32) uint32 {
	shift := 32 - (8 * size)
	return uint32(int32(n<<shift) >> shift)
}

func extwl(in uint16) uint32 {
	return uint32(int16(in))
}

func extbl(in uint8) uint32 {
	return uint32(int8(in))
}

func extbw(in uint8) uint16 {
	return uint16(int8(in))
}

func add_then_set_vc(a uint32, b uint32, size uint32) (result uint32) {
	result = a + b
	var signbit uint32 = 1 << ((size * 8) - 1)
	var mask uint32 = (1 << (size * 8)) - 1
	v = ((a & signbit) == (b & signbit)) && ((a & signbit) != (result & signbit))
	c = result&mask < a&mask // could use result < b just as easily
	return
}

func sub_then_set_vc(a uint32, b uint32, size uint32) (result uint32) { // subtract b from a
	result = a - b
	var signbit uint32 = 1 << ((size * 8) - 1)
	var mask uint32 = (1 << (size * 8)) - 1
	v = ((a & signbit) != (b & signbit)) && ((b & signbit) == (result & signbit))
	c = a&mask < b&mask
	return
}

func set_nz(num uint32, size uint32) {
	bitsize := size * 8
	n = num&(1<<(bitsize-1)) != 0
	z = num&((1<<bitsize)-1) == 0
}

func get_ccr() (ccr uint16) {
	for shift, value := range []bool{c, v, z, n, x} {
		if value {
			ccr |= 1 << shift
		}
	}
	return
}

func set_ccr(ccr uint16) {
	x = ccr&16 != 0
	n = ccr&8 != 0
	z = ccr&4 != 0
	v = ccr&2 != 0
	c = ccr&1 != 0
}

func readsize(encoded uint16) uint32 {
	switch encoded & 3 {
	case 0:
		return 1
	case 1:
		return 2
	case 2:
		return 4
	default:
		panic("illegal size field 0b11")
	}
}

func readsizeForMove(encoded uint16) uint32 {
	switch encoded & 3 {
	case 1:
		return 1
	case 2:
		return 4
	case 3:
		return 2
	default:
		panic("illegal size field 0b00")
	}
}

func address_by_mode(mode uint16, size uint32) (ptr uint32) { // mode given by bottom 6 bits
	// side effects: predecrement/postincrement, advance pc to get extension word

	if mode < 16 { // Dn or An -- optimise common case slightly
		ptr = regAddr(mode&0xf) + 4 - size
	} else if mode>>3 == 2 { // (An)
		ptr = readl(aregAddr(mode & 7))
	} else if mode>>3 == 3 { // (An)+
		regptr := aregAddr(mode & 7)
		ptr = readl(regptr)
		newptr := ptr + size
		if mode&7 == 7 && size == 1 {
			newptr += 1
		}
		writel(regptr, newptr)
	} else if mode>>3 == 4 { // -(An)
		regptr := aregAddr(mode & 7)
		ptr = readl(regptr)
		ptr -= size
		if mode&7 == 7 && size == 1 {
			ptr--
		}
		writel(regptr, ptr)
	} else if mode>>3 == 5 { // d16(An)
		regptr := aregAddr(mode & 7)
		ptr = readl(regptr) + extwl(readw(pc))
		pc += 2
	} else if mode>>3 == 6 { // d8(An,Xn)
		ptr = readl(aregAddr(mode & 7)) // contents of An
		xword := readw(pc)
		pc += 2
		ptr += extbl(uint8(xword)) // add constant displacement
		xn := readl(regAddr(xword >> 12 & 15))
		if xword&0x100 == 0 { // xn is word valued, so sign extend it
			xn = extwl(uint16(xn))
		}
		ptr += xn
	} else if mode == 58 { // d16(PC)
		ptr = pc + extwl(readw(pc))
		pc += 2
	} else if mode == 59 { // d8(PC,Xn)
		ptr = pc
		xword := readw(pc)
		pc += 2
		ptr += extbl(uint8(xword)) // add constant displacement
		xn := readl(regAddr(xword >> 12 & 15))
		if xword&0x100 == 0 { // xn is word valued, so sign extend it
			xn = extwl(uint16(xn))
		}
		ptr += xn
	} else if mode == 56 { // abs.W
		ptr = uint32(readw(pc))
		pc += 2
	} else if mode == 57 { // abs.L
		ptr = readl(pc)
		pc += 4
	} else if mode == 60 { // #imm
		if size == 1 {
			ptr = pc + 1
			pc += 2
		} else if size == 2 {
			ptr = pc
			pc += 2
		} else if size == 4 {
			ptr = pc
			pc += 4
		}
	} else {
		panic("reserved addressing mode")
	}
	return
}

func test_condition(cond uint16) bool {
	switch cond {
	case 0: // T true
		return true
	case 1: // F false
		return false
	case 2: // HI higher than
		return !(c || z)
	case 3: // LS lower or same
		return c || z
	case 4: // CC carry clear aka HS
		return !c
	case 5: // CS carry set aka LS
		return c
	case 6: // NE not equal
		return !z
	case 7: // EQ equal
		return z
	case 8: // VC overflow clear
		return !v
	case 9: // VS overflow set
		return v
	case 10: // PL plus
		return !n
	case 11: // MI minus
		return n
	case 12: // GE greater or equal
		return n == v
	case 13: // LT less than
		return !(n == v)
	case 14: // GT greater than
		return n == v && !z
	case 15: // LE less or equal
		return n != v || z
	}
	panic("Unknown condition code")
}

func line0(inst uint16) {
	if inst&256 != 0 || inst>>9 == 4 { // btst,bchg,bclr,bset (or movep)
		var bit uint32
		if inst&256 != 0 { // bit numbered by data register
			if inst>>3&7 == 1 {
				panic("movep")
			}
			dn := inst >> 9
			bit = readl(regAddr(dn))
		} else { // bit numbered by immediate
			bit = uint32(readw(pc))
			pc += 2
		}

		mode := inst & 63
		var size uint32
		if mode>>3 <= 1 {
			size = 4 // applies to register
		} else {
			size = 1 // applies to memory address
		}
		bit %= size * 8
		mask := uint32(1) << bit

		ptr := address_by_mode(mode, size)
		val := read(size, ptr)
		z = val&mask == 0

		if inst>>6&3 == 1 { // bchg
			val ^= mask
		} else if inst>>6&3 == 2 { // bclr
			val &= ^mask
		} else if inst>>6&3 == 3 { // bset
			val |= mask
		}
		// ^^ the btst case is already handled by setting z

		write(size, ptr, val)

	} else { //ori,andi,subi,addi,eori -- including to SR/CCR
		size := readsize(inst >> 6 & 3)

		src_ptr := address_by_mode(60, size) // '#imm' mode, advances pc
		imm := read(size, src_ptr)

		// now, are we operating on a special mode?
		dest_mode := inst & 63
		var val, dest_ptr uint32
		if dest_mode == 60 { // '#imm' actually means CCR/SR
			// for addi/subi this would simply be invalid
			val = uint32(get_ccr())
		} else {
			dest_ptr = address_by_mode(dest_mode, size)
			val = read(size, dest_ptr)
		}

		if inst>>9 == 0 { // ori
			val |= imm
			v = false
			c = false
			set_nz(val, size)
		} else if inst>>9 == 1 { // andi
			val &= imm
			v = false
			c = false
			set_nz(val, size)
		} else if inst>>9 == 2 { // subi
			val = sub_then_set_vc(val, imm, size)
			x = c
			set_nz(val, size)
		} else if inst>>9 == 3 { // addi
			val = add_then_set_vc(val, imm, size)
			x = c
			set_nz(val, size)
		} else if inst>>9 == 5 { // eori
			val ^= imm
			v = false
			c = false
			set_nz(val, size)
		} else if inst>>9 == 6 { // cmpi: same as subi, but don't set
			fake_val := sub_then_set_vc(val, imm, size)
			set_nz(fake_val, size)
		}

		if dest_mode == 60 {
			set_ccr(uint16(val))
		} else {
			write(size, dest_ptr, val)
		}
	}
}

func line123(inst uint16) { // move, and movea which is a special-ish case
	size := readsizeForMove(inst >> 12 & 3)
	dest_mode := (inst >> 3 & 0x38) | (inst >> 9 & 7)
	src_mode := inst & 63

	src := address_by_mode(src_mode, size)
	datum := read(size, src)

	if dest_mode>>3 == 1 { // movea: sign extend to 32 bits
		datum = signextend(size, datum)
		size = 4
	} else { // non-movea: set condition codes
		v = false
		c = false
		set_nz(datum, size)
	}

	dest := address_by_mode(dest_mode, size)
	write(size, dest, datum)
}

func line4(inst uint16) { // very,crowded,line
	if inst>>6&63 == 3 { // move from sr
		dest := address_by_mode(inst&63, 2) // sr is 2 bytes
		writew(dest, get_ccr())
	} else if inst>>6&63 == 19 || inst>>6&63 == 27 { // move to sr/ccr
		var size uint32
		if inst>>6&8 != 0 {
			size = 1 // ccr
		} else {
			size = 2 // sr
		}
		src := address_by_mode(inst&63, size)
		set_ccr(uint16(read(size, src)))
	} else if inst>>8&15 == 0 || inst>>8&15 == 4 || inst>>8&15 == 6 { // negx,neg,not
		size := readsize(inst >> 6 & 3)
		dest := address_by_mode(inst&63, size)
		datum := read(size, dest)

		if inst>>8&15 == 0 { // negx
			xdatum := datum
			if x {
				xdatum += 1
			}
			datum = sub_then_set_vc(0, xdatum, size)
			x = c
			set_nz(datum, size)
		} else if inst>>8&15 == 4 { // neg
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

	} else if inst>>8&15 == 2 { // clr
		size := readsize(inst >> 6 & 3)
		dest := address_by_mode(inst&63, size)

		n = false
		z = true
		v = false
		c = false

		write(size, dest, 0)
	} else if inst&0xFB8 == 0x880 { // ext
		dn := inst & 7
		if inst&64 != 0 { // ext.l
			val := extwl(readw(regAddr(dn) + 2))
			set_nz(val, 4)
			v = false
			c = false
			writel(regAddr(dn), val)
		} else { // ext.w
			val := extbw(readb(regAddr(dn) + 3))
			set_nz(uint32(val), 2)
			v = false
			c = false
			writew(regAddr(dn)+2, val)
		}
	} else if inst&0xFF8 == 0x840 { // swap.w
		dest := regAddr(inst & 7)
		datum := readl(dest)
		datum = (datum >> 16 & 0xffff) | (datum << 16 & 0xffff0000)
		set_nz(datum, 4)
		v = false
		c = false
		writel(dest, datum)
	} else if inst&0xFC0 == 0x840 { // pea -- notice similarity to swap.w
		ea := address_by_mode(inst&63, 4) // size doesn't matter here
		pushl(ea)
	} else if inst&0xF00 == 0xA00 { // tst,tas
		size := []uint32{1, 2, 4, 1}[inst>>6&3]
		dest := address_by_mode(inst&63, size)
		datum := read(size, dest)
		set_nz(datum, size)
		v = false
		c = false
		if inst>>6&3 == 3 { // tas
			writeb(dest, uint8(datum)|0x80)
		}
	} else if inst&0xFF8 == 0xE50 { // link
		ea := aregAddr(inst & 7)
		imm := extwl(readw(pc))
		pc += 2

		pushl(readl(ea)) // move.l a6,-(sp)
		sp := readl(spptr)
		writel(ea, sp)        // move.l sp,a6
		writel(spptr, sp+imm) // add.w #imm,sp

	} else if inst&0xFF8 == 0xE58 { // unlk
		ea := aregAddr(inst & 7)

		writel(spptr, readl(ea)) // move.l a6,sp
		writel(ea, popl())       // move.l (sp)+,a6
	} else if inst&0xFFF == 0xE71 { // nop
	} else if inst&0xFFF == 0xE75 { // rts
		check_for_lurkers()
		pc = popl()
	} else if inst&0xFFF == 0xE77 { // rtr
		set_ccr(popw())
		pc = popl()
	} else if inst&0xF80 == 0xE80 { // jsr/jmp
		targ := address_by_mode(inst&63, 4) // any size
		if inst&0x40 == 0 {
			check_for_lurkers() // don't slow down jmp's, we do them a lot
			pushl(pc)
		}
		pc = targ
	} else if inst&0xF80 == 0x880 { // movem registers,ea
		size := uint32(2)
		if inst&64 != 0 {
			size = 4
		}

		which := readw(pc)
		pc += 2
		totalsize := uint32(bits.OnesCount16(which)) * size

		mode := inst & 63
		ptr := address_by_mode(mode, totalsize)

		if mode>>3 == 4 { // reverse the bits if predecrementing
			which = bits.Reverse16(which)
		}

		for reg := uint16(0); reg < 16; reg++ {
			if which&(1<<reg) != 0 {
				regptr := regAddr(reg) + 4 - size
				write(size, ptr, read(size, regptr))
				ptr += size
			}
		}
	} else if inst&0xF80 == 0xC80 { // movem ea,registers
		size := uint32(2)
		if inst&64 != 0 {
			size = 4
		}

		which := readw(pc)
		pc += 2
		totalsize := uint32(bits.OnesCount16(which)) * size

		mode := inst & 63
		ptr := address_by_mode(mode, totalsize)

		for reg := uint16(0); reg < 16; reg++ {
			if which&(1<<reg) != 0 {
				if !(reg >= 8 && mode>>3 == 3 && reg&7 == mode&7) {
					regptr := regAddr(reg)
					writel(regptr, signextend(size, read(size, ptr)))
				}
				ptr += size
			}
		}
	} else if inst&0x1C0 == 0x1C0 { // lea
		an := inst >> 9 & 7
		ea := address_by_mode(inst&63, 4) // any size
		writel(aregAddr(an), ea)
	} else if inst&0x1C0 == 0x180 { // chk
		dn := inst >> 9 & 7
		testee := readw(regAddr(dn) + 2)
		ea := address_by_mode(inst&63, 2)
		ubound := readw(ea)
		if testee > ubound {
			panic("chk failed")
		}
	}
}

func line5(inst uint16) { // addq,subq,scc,dbcc
	if inst>>6&3 != 3 { // addq,subq
		size := readsize(inst >> 6 & 3)
		if size == 2 && inst>>3&7 == 1 {
			size = 4 // An.w is really An.l
		}

		imm := uint32(inst >> 9 & 7)
		if imm == 0 {
			imm = 8
		}

		dest := address_by_mode(inst&63, size)
		datum := read(size, dest)
		save_ccr := get_ccr()
		if inst&256 != 0 { // subq
			datum = sub_then_set_vc(datum, imm, size)
		} else { // addq
			datum = add_then_set_vc(datum, imm, size)
		}
		x = c
		set_nz(datum, size)
		if inst>>3&7 == 1 {
			set_ccr(save_ccr) // touch not ccr if dest is An
		}
		write(size, dest, datum)

	} else if inst>>3&7 == 1 { // dbcc
		check_for_lurkers()

		disp := extwl(readw(pc)) - 2
		pc += 2

		cond := inst >> 8 & 15 // if cond satisfied then DO NOT take loop
		if test_condition(cond) {
			return
		}
		// decrement the counter (dn)
		dn := inst & 7
		dest := regAddr(dn) + 2
		counter := readw(dest) - 1
		writew(dest, counter)
		if counter == 0xFFFF { // do not take the branch
			return
		}

		pc += disp
	} else { // scc
		dest := address_by_mode(inst&63, 1)
		cond := inst >> 8 & 15
		if test_condition(cond) {
			writeb(dest, 0xff)
		} else {
			writeb(dest, 0)
		}
	}
}

func line6(inst uint16) { // bra,bsr,bcc
	check_for_lurkers()

	disp := extbl(uint8(inst))
	if disp == 0 { // word displacement
		disp = extwl(readw(pc)) - 2
		pc += 2
	}

	cond := inst >> 8 & 15
	if cond > 1 && !test_condition(cond) { // not taken
		return
	}
	if cond == 1 { // is bsr
		pushl(pc)
	}

	pc += disp
}

func line7(inst uint16) { // moveq
	dn := inst >> 9 & 7
	val := extbl(uint8(inst))

	set_nz(val, 4)
	v = false
	c = false

	writel(regAddr(dn), val)
}

func line8(inst uint16) { // divu,divs,sbcd,or
	//    global n, z, v, c
	if inst&0x1F0 == 0x100 { // sbcd
		panic("sbcd")
	} else if inst&0x0C0 == 0x0C0 { // divu,divs
		ea := address_by_mode(inst&63, 2)
		divisor := readw(ea)
		dn := inst >> 9 & 7
		dividend := readl(regAddr(dn))

		var quotient uint32 // keep upper bits for setting the v bit
		var remainder uint16
		if inst&0x100 != 0 { // signed
			sdivisor := int32(int16(divisor))
			sdividend := int32(dividend)
			squotient := sdividend / sdivisor
			sremainder := sdividend % sdivisor
			quotient = uint32(squotient)
			remainder = uint16(sremainder)
		} else { // unsigned
			quotient = dividend / uint32(divisor)
			remainder = uint16(dividend % uint32(divisor))
		}

		if quotient>>16 != 0 {
			v = true
		}

		v = false
		set_nz(quotient, 2)
		writel(regAddr(dn), (uint32(remainder)<<16)|(quotient&0xFFFF))

	} else { // or
		size := readsize(inst >> 6 & 3)
		src := address_by_mode(inst&63, size)
		dn := inst >> 9 & 7
		dest := regAddr(dn) + 4 - size

		if inst&0x100 != 0 {
			src, dest = dest, src
		}

		datum := read(size, src) | read(size, dest)
		write(size, dest, datum)
		set_nz(datum, size)
		v = false
		c = false
	}
}

func line9D(inst uint16) { // sub,subx,suba/add,addx,adda: very compactly encoded
	isAdd := inst&0x4000 != 0

	if inst&0x0C0 == 0x0C0 { // suba,adda
		size := uint32(2)
		if inst&0x100 != 0 {
			size = 4
		}

		ea := address_by_mode(inst&63, size)
		an := inst >> 9 & 7

		result := signextend(4, readl(aregAddr(an)))
		addOrSub := signextend(size, read(size, ea))
		if isAdd {
			result += addOrSub
		} else {
			result -= addOrSub
		}

		writel(aregAddr(an), result)
	} else if inst&0x130 == 0x100 { // subx,addx: only two addressing modes allowed
		size := readsize(inst >> 6 & 3)

		mode := uint16(0) // Dx,Dy
		if inst&8 != 0 {
			mode = 32 // -(Ax),-(Ay)
		}

		src := address_by_mode(mode|(inst&7), size)
		dest := address_by_mode(mode|(inst>>9&7), size)

		result := read(size, dest)
		addOrSub := read(size, src)
		if x {
			addOrSub += 1
		}
		if isAdd {
			result = add_then_set_vc(result, addOrSub, size)
		} else {
			result = sub_then_set_vc(result, addOrSub, size)
		}

		write(size, dest, result)
		x = c
		old_z := z
		set_nz(result, size)
		z = z && old_z
	} else { // sub,add
		size := readsize(inst >> 6 & 3)
		src := address_by_mode(inst&63, size)
		dn := inst >> 9 & 7
		dest := regAddr(dn) + 4 - size

		if inst&0x100 != 0 {
			src, dest = dest, src
		}

		result := read(size, dest)
		addOrSub := read(size, src)
		if isAdd {
			result = add_then_set_vc(result, addOrSub, size)
		} else {
			result = sub_then_set_vc(result, addOrSub, size)
		}

		x = c
		set_nz(result, size)
		write(size, dest, result)
	}
}

func lineB(inst uint16) { // cmpa,cmp,cmpm,eor
	if inst&0x0C0 == 0x0C0 { // cmpa
		size := uint32(2)
		if inst&0x100 != 0 {
			size = 4
		}

		ea := address_by_mode(inst&63, size)
		an := inst >> 9 & 7 // ea may be .w/.l but an is always .l
		result := sub_then_set_vc(readl(aregAddr(an)), signextend(size, read(size, ea)), 4)
		set_nz(result, 4)
	} else if inst&0x100 == 0x000 { // cmp
		size := readsize(inst >> 6 & 3)
		dn := inst >> 9 & 7
		dest := regAddr(dn) + 4 - size
		src := address_by_mode(inst&63, size)
		result := sub_then_set_vc(read(size, dest), read(size, src), size)
		set_nz(result, size)
	} else if inst&0x38 == 0x08 { // cmpm (Ay)+,(Ax)+
		size := readsize(inst >> 6 & 3)
		src := address_by_mode(24|(inst&7), size) // (An)+ mode
		dest := address_by_mode(24|(inst>>9&7), size)
		result := sub_then_set_vc(read(size, dest), read(size, src), size)
		set_nz(result, size)
	} else { // eor
		size := readsize(inst >> 6 & 3)
		dn := inst >> 9 & 7
		src := regAddr(dn) + 4 - size
		dest := address_by_mode(inst&63, size)
		result := read(size, dest) ^ read(size, src)
		v = false
		c = false
		set_nz(result, size)
		write(size, dest, result)
	}
}

func lineC(inst uint16) {
	if inst&0xC0 == 0xC0 { // mulu,muls
		src := address_by_mode(inst&63, 2) // ea.w
		dest := regAddr(inst >> 9 & 7)     // dn.l

		m1 := readw(dest + 2)
		m2 := readw(src)

		var result uint32
		if inst&0x100 != 0 { // signed
			result = uint32(int32(int16(m1)) * int32(int16(m2)))
		} else {
			result = uint32(m1) * uint32(m2)
		}

		set_nz(result, 4)
		v = false
		c = false
		writel(dest, result) // write dn.l
	} else if inst&0x1F0 == 0x100 { // abcd
		panic("abcd")
	} else if inst&0x1F8 == 0x140 || inst&0x1F8 == 0x148 || inst&0x1F8 == 0x188 { // exg
		rx := inst >> 9 & 7
		ry := inst & 7
		if inst&0x1F8 == 0x148 { // Ax,Ay
			rx |= 8
			ry |= 8 // bump the addressing mode from Dn to An
		} else if inst&0x1F8 == 0x188 { // Dx,Ay
			ry |= 8
		}

		ptrx := address_by_mode(rx, 4)
		ptry := address_by_mode(ry, 4)

		x := readl(ptrx)
		y := readl(ptry)
		writel(ptrx, y)
		writel(ptry, x)

	} else { // and
		size := readsize(inst >> 6 & 3)
		dn := inst >> 9 & 7
		dest := address_by_mode(dn, size)
		src := address_by_mode(inst&63, size)

		if inst&0x100 != 0 { // direction bit
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
	var size uint32
	var kind uint16
	var dest uint32
	var by uint16

	isLeft := inst&0x100 != 0

	if inst>>6&3 == 3 { // single-bit shift on a memory address
		size = 2
		kind = inst >> 9 & 3
		dest = address_by_mode(inst&63, size)
		by = 1
	} else {
		size = readsize(inst >> 6 & 3)
		kind = inst >> 3 & 3
		dest = regAddr(inst&7) + 4 - size // dn
		if inst&0x20 != 0 {
			by = uint16(readb(regAddr(inst>>9&7)+3)) % 64
		} else {
			by = inst >> 9 & 7
			if by == 0 {
				by = 8
			}
		}
	}

	v = false // clear V if msb never changes
	c = false // clear C if shift count is zero

	result := read(size, dest)
	numbits := size * 8
	mask := (uint32(1) << numbits) - 1
	msb := uint32(1) << (numbits - 1)
	if kind == 0 { // asl/asr
		if isLeft {
			for i := uint16(0); i < by; i++ {
				newresult := (result << 1) & mask
				c = result&msb != 0 // shifted-out bit
				x = c
				if newresult&msb != result&msb { // set V if sign ever changes
					v = true
				}
				result = newresult
			}
		} else {
			for i := uint16(0); i < by; i++ {
				newresult := result >> 1
				c = result&1 != 0 // shifted-out bit
				x = c
				newresult |= result & msb // replicate sign bit
				result = newresult
			}
		}
	} else if kind == 1 { // lsl/lsr
		v = false
		if isLeft {
			for i := uint16(0); i < by; i++ {
				newresult := (result << 1) & mask
				c = result&msb != 0 // shifted-out bit
				x = c
				result = newresult
			}
		} else {
			for i := uint16(0); i < by; i++ {
				newresult := result >> 1
				c = result&1 != 0 // shifted-out bit
				x = c
				result = newresult
			}
		}
	} else if kind == 2 { // roxl/roxr
		v = false
		if isLeft {
			for i := uint16(0); i < by; i++ {
				newresult := (result << 1)
				if x {
					newresult += 1
				}
				c = newresult>>numbits != 0
				x = c
				result = newresult & mask
			}
		} else {
			for i := uint16(0); i < by; i++ {
				newresult := result >> 1
				if x {
					newresult += msb
				}
				c = result&1 != 0
				x = c
				result = newresult & mask
			}
		}
	} else if kind == 3 { // rol/ror
		v = false
		if isLeft {
			for i := uint16(0); i < by; i++ {
				result = (result << 1) | (result >> (numbits - 1))
				c = result&1 != 0
			}
		} else {
			for i := uint16(0); i < by; i++ {
				c = result&1 != 0
				result = (result << (numbits - 1)) | (result >> 1)

			}
		}
	}
	set_nz(result, size)

	write(size, dest, result)
}

var curFuncStart, curFuncEnd uint32
var curFuncName string

func printState() {
	conds := []byte("xnzvc")
	if x {
		conds[0] = 'X'
	}
	if n {
		conds[1] = 'N'
	}
	if z {
		conds[2] = 'Z'
	}
	if v {
		conds[3] = 'V'
	}
	if c {
		conds[4] = 'C'
	}

	r := readRegs()
	fmt.Printf("%08x %08x %08x %08x %08x %08x %08x %08x\n", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7])
	fmt.Printf("%08x %08x %08x %08x %08x %08x %08x %08x\n", r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15])
	sp := readl(spptr)
	fmt.Printf("stack %02x%02x %02x%02x %02x%02x %02x%02x %02x%02x %02x%02x %s\n", mem[sp+0], mem[sp+1], mem[sp+2], mem[sp+3], mem[sp+4], mem[sp+5], mem[sp+6], mem[sp+7], mem[sp+8], mem[sp+9], mem[sp+10], mem[sp+11], string(conds))
	fmt.Println("")

	// What about a function name?
	if pc < curFuncStart || pc >= curFuncEnd {
		curFuncStart = pc
		curFuncEnd = uint32(len(mem))
		curFuncName = ""
		for try := pc; try+130 <= uint32(len(mem)); try += 2 {
			if mem[try] == 0x4e && (mem[try+1] == 0x75 || mem[try+1] == 0xd0) {
				if mem[try+2]&0xc0 == 0x80 {
					strlen := uint32(mem[try+2] & 0x3f)
					curFuncName = string(mem[try+3:][:strlen])
					for _, ch := range []byte(curFuncName) {
						if ch < 32 || ch >= 127 {
							curFuncName = ""
						}
					}
				}
				curFuncEnd = try + 2
				break
			}
		}
	}

	printName := curFuncName
	if pc < 0x100000 {
		printName = ""
	}

	printSeg := ""
	for i, segOffset := range gSegmentOffsets {
		if pc >= segOffset {
			printSeg = fmt.Sprintf("%s+%x", gSegmentNames[i], pc-segOffset)
		}
	}

	fmt.Printf("%x: %s %s %04x\n\n", pc, printSeg, printName, readw(pc))
}

func call_m68k(addr uint32) {
	const magic_return = 0

	save_pc := pc
	pushl(magic_return) // the function we call will pop this value
	pc = addr

	for pc != magic_return {
		if gDebug >= 5 {
			printState()
		}

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