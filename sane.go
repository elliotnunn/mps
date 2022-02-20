/*
Standard Apple Numeric Environment
the FP68K package reimplemented

SANE quirks that are emulated:
- incorrect single-precision rounding
- NaNs with only the highest bit set become infinity
- undefined rounding mode $0060 treated as $0040 (single)
- FONEXT wrong? (not sure about this)
- Non-hexadecimal NaN codes passed to FOD2B

SANE quirks that are not emulated:
- FOSETXCP corrupting stack when given an argument >4
- CCR on exit, other than comparisons
- halt vector stack address
*/
package main

import (
	"encoding/binary"
	"fmt"
	"math/big"
)

const ( // FPState bitfield 0x6000
	rndNearest = 0
	rndUp      = 1
	rndDown    = 2
	rndZero    = 3
)

const ( // FPState bitfield 0x0060
	extendedPrec = 0
	doublePrec   = 1
	singlePrec   = 2 // 3 also interpreted this way
)

const ( // FPState flags
	INEXACT = 0x1000 // inexact
	DIVZER  = 0x0800 // divide by zero
	OFLOW   = 0x0400 // overflow
	UFLOW   = 0x0200 // underflow
	INVALID = 0x0100 // invalid
	LSTRND  = 0x0080 // last round incremented
)

type Float struct {
	sign bool
	exp  int32
	mant uint64
}

func (f Float) String() string {
	sign := "+"
	if f.sign {
		sign = "-"
	}

	return fmt.Sprintf("(%s)(%x)(%016x)", sign, f.exp, f.mant)
}

var opcodeArgCounts = [...]int{
	2, // FOADD
	1, // FOSETENV
	2, // FOSUB
	1, // FOGETENV
	2, // FOMUL
	1, // FOSETHV
	2, // FODIV
	1, // FOGETHV
	2, // FOCMP
	2, // FOD2B
	2, // FOCPX
	3, // FOB2D
	2, // FOREM
	1, // FONEG
	2, // FOZ2X
	1, // FOABS
	2, // FOX2Z
	2, // FOCPYSGN
	1, // FOSQRT
	2, // FONEXT
	1, // FORTI
	1, // FOSETXCP
	1, // FOTTI
	1, // FOPROCENTRY
	2, // FOSCALB
	1, // FOPROCEXIT
	1, // FOLOGB
	1, // FOTESTXCP
	2, // FOCLASS
}

func getFPState() uint16 {
	return readw(0xa4a)
}

func setFPState(to uint16) {
	writew(0xa4a, to)
}

func getHaltVector() uint32 {
	return readl(0xa4c)
}

func setHaltVector(to uint32) {
	writel(0xa4c, to)
}

func tFP68K() {
	// Flags that govern our operation
	opword := readw(readl(spptr))
	if opword & ^uint16(0x381f) != 0 ||
		opword&0x1f > 0x1c ||
		opword&0x3800 == 0x1800 ||
		opword&0x3800 == 0x3800 {
		panic(fmt.Sprintf("Invalid SANE selector %#04x", opword))
	}

	operation := opword & 0x1f
	d6 := uint32(opword) << 16

	// Get the machine state
	var regFile [16 * 4]byte
	copy(regFile[:], mem[d0ptr:])
	stackOnEntry := readl(spptr)
	d0 := readl(d0ptr)
	ccr := uint16(0)

	// Set the machine state
	defer func() {
		// Restore all registers
		copy(mem[d0ptr:], regFile[:])

		// except SP, from which we pop our arguments
		// (unless FOSETXCP gets a bad argument and clobbers the stack)
		writel(spptr, stackOnEntry+2+4*uint32(opcodeArgCounts[operation]))

		// and D0, which REM and the trap vector can set
		writel(d0ptr, d0)

		// Compare instructions return via the CCR
		set_ccr(ccr)

	}()

	addr1 := readl(readl(spptr) + 2)
	addr2 := readl(readl(spptr) + 6)
	addr3 := readl(readl(spptr) + 10)

	// Non-numeric operations
	if operation&1 != 0 {
		switch operation & 0x1f {
		case 0x01: // FOSETENV, set environment
			setFPState(readw(addr1))

		case 0x03: // FOGETENV, get environment
			writew(addr1, getFPState())

		case 0x05: // FOSETHV, set halt vector
			setHaltVector(readl(addr1))

		case 0x07: // FOGETHV, get halt vector
			writel(addr1, getHaltVector())

		case 0x09: // FOD2B, convert decimal to binary
			sign := readb(addr2) != 0
			exp := int(int16(readw(addr2 + 2)))
			pstring := []byte(readPstring(addr2 + 4))
			result := fod2b(sign, exp, pstring)

			// Save temporary extended result
			temp, oldsp := pushzero(10)
			packExt(mem[temp:], result)

			// Convert to requested format
			pushl(temp)
			pushl(addr1)
			pushw(opword&0x3800 | 0x10) // FOX2Z + original format
			tFP68K()

			writel(spptr, oldsp)

		case 0x0b: // FOB2D, convert binary to decimal
			f, _, _ := unpack(int(opword>>11&7), mem[addr2:])
			isFixed := readb(addr3) != 0
			digits := int(int16(readw(addr3 + 2)))
			sign, exp, str := fob2d(f, isFixed, digits)

			writew(addr1+2, uint16(exp))
			writePstring(addr1+4, macstring(str))

			if sign {
				writeb(addr1, 1)
			} else {
				writeb(addr1, 0)
			}

		case 0x0d: // FONEG, negate
			writeb(addr1, readb(addr1)^0x80)

		case 0x0f: // FOABS, absolute
			writeb(addr1, readb(addr1)&^0x80)

		case 0x11: // FOCPYSGN, copy sign (DEST to SRC)
			writeb(addr2, (readb(addr1)&0x80)|(readb(addr2)&0x7f))

		case 0x13: // FONEXT, next after
			d6 = fonext(d6, addr1, addr2)

		case 0x15: // FOSETXCP
			excep := readw(addr1)
			if excep > 4 {
				panic("FOSETXCP something awful")
			}
			d6 |= 1 << (excep + 8)

		case 0x17: // FOPROCENTRY
			writew(addr1, getFPState())
			setFPState(0)

		case 0x19: // FOPROCEXIT
			d6 |= uint32(getFPState() & 0x1f00)
			setFPState(readw(addr1))

		case 0x1b: // FOTESTXCP
			whichbit := readw(addr1) & 7
			ret := uint8(getFPState() >> 8 >> whichbit & 1)
			writeb(addr1, ret)
		}
	} else {
		// Numeric operations
		// Undocumented bit LSTRND meaning that we increased the mantissa when rounding
		setFPState(getFPState() &^ LSTRND)

		d6 |= [...]uint32{
			0x0e1, // FOADD
			0x0e1, // FOSUB
			0x0e1, // FOMUL
			0x0e1, // FODIV
			0x0c1, // FOCMP
			0x0c1, // FOCPX
			0x0e1, // FOREM
			0x061, // FOZ2X
			0x161, // FOX2Z
			0x0a0, // FOSQRT
			0x0a0, // FORTI
			0x0a0, // FOTTI
			0x0a1, // FOSCALB
			0x0a0, // FOLOGB
			0x041, // FOCLASS
		}[operation/2] << 16

		precision := getFPState() >> 5 & 3
		d6 |= uint32(precision) << 30

		// FOX2Z overwrites precision bits with those of the dest format
		if d6&0x1000000 != 0 {
			d6 = ((d6 & 0x38000000) << 3) | ((d6 & 0x38000000) >> 3) | (d6 & 0xff0000)
		}

		inputs := make([]Float, 0, 2) // [DST] [SRC1]
		anySignal := false
		anyDenorm := false

		if d6&0x800000 != 0 { // Read "dst" (first ptr on stack)
			f, denorm, signal := unpack(int(d6>>24&7), mem[addr1:])
			inputs = append(inputs, f)
			anySignal = anySignal || signal
			anyDenorm = anyDenorm || denorm
		}

		if d6&0x400000 != 0 { // Read "src" (second ptr on stack)
			f, denorm, signal := unpack(int(d6>>27&7), mem[addr2:])
			inputs = append(inputs, f)
			anySignal = anySignal || signal
			anyDenorm = anyDenorm || denorm
		}

		// d6 high half = opword
		// d6 bit 8 = any signalling NaN
		if anySignal {
			d6 |= INVALID
		}

		var result Float

		anyNaN := false
		for _, f := range inputs {
			if f.IsNaN() {
				anyNaN = true
			}
		}

		if anyNaN { // NaNs in the input
			switch operation {
			case 0x08: // FOCMP, no exception from unordered
				ccr = 0b00010 // V only

			case 0x0a: // FOCPX, signal invalid if unordered
				ccr = 0b00010 // V only
				d6 |= INVALID

			case 0x1c: // FOCLASS
				class := uint16(2) // quiet
				if anySignal {
					class = 1 // signalling
				}
				if inputs[0].sign {
					class = -class
				}
				binary.BigEndian.PutUint16(mem[addr1:], class)
				d6 &^= INVALID

			default: // other operations just fail
				// Choose the one with the highest number, favouring SRC
				for _, f := range inputs {
					if f.IsNaN() && f.mant&0x00ff000000000000 >= result.mant&0x00ff000000000000 {
						result = f
					}
				}

				// Note the use of the top 2 bits of D6 for precision.
				// These bits are usually taken from FPState, except that for FCX2,
				// the "(opword & 0x3800) << 3)" term above causes them to be set
				// to the precision of the output format.
				// Therefore, FCX2 ignores the precision bits.
				result = nanCoerce(int(d6>>24&7), int(d6>>30&3), result)

				if d6>>23&0xe == 8 || d6>>23&0xe == 10 { // int16,32 cannot represent NaN
					d6 |= INVALID
				}
			}
		} else { // no NaNs in the input
			switch operation {
			case 0x02: // FOSUB
				inputs[1].sign = !inputs[1].sign
				fallthrough

			case 0x00: // FOADD
				d6, result = foadd(d6, inputs[0], inputs[1])

			case 0x04: // FOMUL
				d6, result = fomul(d6, inputs[0], inputs[1])

			case 0x06: // FODIV
				d6, result = fodiv(d6, inputs[0], inputs[1])

			case 0x08, 0x0a: // FOCMP, FOCPX (identical when non-NaN)
				ccr = focmp(inputs[0], inputs[1])

			case 0x0c: // FOREM
				var newD0w int8
				d6, result, newD0w = forem(d6, inputs[0], inputs[1])
				d0 = (d0 & 0xffff0000) | (uint32(newD0w) & 0xffff)

			case 0x0e: // FOZ2X, convert to extended
				result = inputs[0]
				if !result.Is0() && !result.IsInf() {
					d6, result = coerce(d6, result, 0)
				}

			case 0x10: // FOX2Z, convert from extended
				d6, result = fox2z(d6, inputs[0])

			case 0x12: // FOSQRT
				d6, result = fosqrt(d6, inputs[0])

			case 0x14: // FORTI, round to integral value
				d6, result = forti(d6, inputs[0])

			case 0x16: // FOTTI, truncate to integral value
				saveState := getFPState()
				setFPState(saveState | 0x6000) // force toward-zero rounding
				d6, result = forti(d6, inputs[0])
				setFPState(saveState)

			case 0x18: // FOSCALB, binary scale
				d6, result = foscalb(d6, inputs[0], int16(readw(addr2)))

			case 0x1a: // FOLOGB, binary log
				d6, result = fologb(d6, inputs[0])

			case 0x1c: // FOCLASS
				var class int
				if inputs[0].IsNum() {
					class = 5 // normal
					if anyDenorm {
						class = 6
					}
				} else if inputs[0].Is0() {
					class = 4
				} else if inputs[0].IsInf() {
					class = 3
				} else {
					panic("classify bad number")
				}

				if inputs[0].sign {
					class = -class
				}

				binary.BigEndian.PutUint16(mem[addr1:], uint16(class))
			}
		}

		if d6&0x200000 != 0 { // Save to "dst" pointer
			pack(int(d6>>24&7), result, mem[addr1:], d6)
		}
	}

	thrown := int(d6) >> 8 & 0xff
	caught := int(getFPState()) & 0xff

	setFPState(getFPState() | uint16(thrown<<8))

	if thrown&caught != 0 {
		pushl(d0)                      // misc rec: pending d0
		pushw(ccr)                     // misc rec: pending ccr
		pushw(uint16(thrown & caught)) // misc rec: halt exceptions

		postCallStack := readl(spptr) // verify that the following gets popped
		pushl(readl(spptr))           // misc rec ptr
		for i := 12; i >= 0; i -= 2 { // the whole 14b stack frame
			pushw(readw(stackOnEntry + uint32(i)))
		}

		callback := getHaltVector()
		if callback == 0 {
			panic("About to call SANE halt vector (0xA4C), but it is zero")
		}
		call_m68k(callback)

		if readl(spptr) != postCallStack {
			panic("SANE halt routine garbled the stack pointer")
		}

		popl()      // discard halt exceptions and ccr
		d0 = popl() // but the trap is allowed to change d0
	}
}

func reenter2(opword uint16, a, b Float) Float {
	aptr, oldsp := pushzero(10)
	bptr, _ := pushzero(10)
	defer writel(spptr, oldsp)

	packExt(mem[aptr:], a)
	packExt(mem[bptr:], b)

	pushl(bptr)
	pushl(aptr)
	pushw(opword)
	tFP68K()

	result := unpackExt(mem[aptr:])
	return result
}

// Opcode 00, 02
func foadd(d6 uint32, f1 Float, f2 Float) (uint32, Float) { // f1=dst, f2=src
	switch {
	case f1.IsNum() && f2.IsNum():
		// A note for posterity: the exponents we are provided could be negative!

		stick1 := uint16(0)

		// Put the number with the initially larger exponent in 2
		if f1.exp > f2.exp {
			f1, f2 = f2, f1
		}

		if f1.exp < f2.exp { // right-shift f2.exp bit by bit
			f1.mant, stick1 = rshift(int(f2.exp-f1.exp), f1.mant, stick1)
			f1.exp = f2.exp
		}

		if f1.sign == f2.sign { // same signs
			f2.mant += f1.mant
			if f2.mant < f1.mant {
				f2.exp += 1
				f2.mant, stick1 = rshift(1, f2.mant, stick1)
				f2.mant |= 1 << 63 // restore the missing bit
			}

			return coerce(d6, Float{f2.sign, f2.exp, f2.mant}, stick1)

		} else { // opposite signs
			if f1.mant == f2.mant {
				neg := getFPState()>>13&3 == rndDown // negative if rounding down
				return d6, Float{neg, 0, 0}
			} else if f1.mant < f2.mant {
				// this is the usual case
				f1.mant -= f2.mant

				// now take the additive inverse
				stick1 = -stick1
				f1.mant = -f1.mant
				if stick1 != 0 {
					f1.mant -= 1
				}

				return normCoerce(d6, Float{f2.sign, f1.exp, f1.mant}, stick1)
			} else {
				f1.mant -= f2.mant
				return normCoerce(d6, Float{f1.sign, f1.exp, f1.mant}, stick1)
			}
		}

	case f1.Is0() && f2.IsNum():
		return coerce(d6, f2, 0)

	case f1.IsInf() && f2.IsNum():
		return d6, f1

	case f1.IsNum() && f2.Is0():
		return coerce(d6, f1, 0)

	case f1.Is0() && f2.Is0():
		// sign tie-break
		if f1.sign == f2.sign {
			return d6, f1
		} else {
			return d6, Float{getFPState()&0x6000 == 0x4000, 0, 0}
		}

	case f1.IsInf() && f2.Is0():
		return d6, f1

	case f1.IsNum() && f2.IsInf():
		return d6, f2

	case f1.Is0() && f2.IsInf():
		return d6, f2

	case f1.IsInf() && f2.IsInf():
		// sign tie-break
		if f1.sign == f2.sign {
			return d6, f1
		} else {
			d6 |= INVALID
			return d6, Float{f2.sign, 0x7fff, 0x4002000000000000}
		}

	default:
		panic("bad case to foadd")
	}
}

// Opcode 04
func fomul(d6 uint32, f1, f2 Float) (uint32, Float) { // f1=dst, f2=src
	// Returned sign is always the XOR of the arguments
	sign := f1.sign != f2.sign
	zero := Float{sign, 0, 0}
	inf := Float{sign, 0x7fff, 0}
	nan := Float{sign, 0x7fff, 0x4008000000000000}

	switch {
	case f1.IsNum() && f2.IsNum():
		hprod, lprod := mul64(f1.mant, f2.mant)

		result := Float{sign, f1.exp + f2.exp - 0x3ffe, hprod}
		sticky := uint16(lprod >> 48 & 0xff00)
		if lprod<<8 != 0 {
			sticky |= 0xff
		}

		return normCoerce(d6, result, sticky)

	case f1.IsNum() && f2.Is0():
		return d6, zero

	case f1.IsNum() && f2.IsInf():
		return d6, inf

	case f1.Is0() && f2.IsNum():
		return d6, zero

	case f1.Is0() && f2.Is0():
		return d6, zero

	case f1.Is0() && f2.IsInf():
		d6 |= INVALID
		return d6, nan

	case f1.IsInf() && f2.IsNum():
		return d6, inf

	case f1.IsInf() && f2.Is0():
		d6 |= INVALID
		return d6, nan

	case f1.IsInf() && f2.IsInf():
		return d6, inf

	default:
		panic("at least one of the arguments is NaN")
	}
}

// Opcode 06
func fodiv(d6 uint32, f1, f2 Float) (uint32, Float) { // f1=dst, f2=src
	// Returned sign is always the XOR of the arguments
	sign := f1.sign != f2.sign
	zero := Float{sign, 0, 0}
	inf := Float{sign, 0x7fff, 0}
	nan := Float{sign, 0x7fff, 0x4004000000000000}

	switch {
	case f1.IsNum() && f2.IsNum():
		exp := f1.exp - f2.exp + 0x3fff
		qbits := 65
		if d6&0x80000000 != 0 { // single
			qbits = 33
		}
		if f1.mant < f2.mant {
			qbits += 1
			exp -= 1
		}

		quo, rem := restoringDivision(f1.mant, f2.mant, qbits)

		if d6&0x80000000 != 0 { // single
			quo <<= 32
		}

		sticky := uint16(0)
		if quo&1 != 0 {
			sticky = 0x8000
		}
		quo >>= 1
		quo |= 0x8000000000000000

		if rem != 0 { // remainder
			sticky |= 0xff
		}

		return coerce(d6, Float{sign, exp, quo}, sticky)

	case f1.IsNum() && f2.Is0():
		d6 |= DIVZER
		return d6, inf

	case f1.IsNum() && f2.IsInf():
		return d6, zero

	case f1.Is0() && f2.IsNum():
		return d6, zero

	case f1.Is0() && f2.Is0():
		d6 |= INVALID
		return d6, nan

	case f1.Is0() && f2.IsInf():
		return d6, zero

	case f1.IsInf() && f2.IsNum():
		return d6, inf

	case f1.IsInf() && f2.Is0():
		return d6, inf

	case f1.IsInf() && f2.IsInf():
		d6 |= INVALID
		return d6, nan

	default:
		panic("at least one of the arguments is NaN")
	}
}

// Opcode 08, 0a
// Does not need to handle NaNs
func focmp(f1, f2 Float) (ccr uint16) {
	const ( // f1 [<=>] fn
		lt = 0b11001 // XN..C
		eq = 0b00100 // ..Z..
		gt = 0b00000 // .....
	)

	// Check both zero, to handle the special case -0.0 == 0.0
	if f1.exp != 0x7fff && f1.mant == 0 && f2.exp != 0x7fff && f2.mant == 0 {
		return eq
	}

	// Opposite signs, no need for detailed comparison
	if f1.sign == true && f2.sign == false {
		return lt
	} else if f1.sign == false && f2.sign == true {
		return gt
	}

	// Give zero the lowest exponent of our internal (signed 32) representation
	for _, f := range [...]*Float{&f1, &f2} {
		if f.exp != 0x7fff && f.mant == 0 {
			f.exp = -0x80000000
		}
	}

	// Both negative, invert the comparison
	if f1.sign {
		f1, f2 = f2, f1
	}

	if f1.exp < f2.exp {
		return lt
	}

	if f1.exp > f2.exp {
		return gt
	}

	if f1.mant < f2.mant {
		return lt
	}

	if f1.mant > f2.mant {
		return gt
	}

	return eq
}

// Opcode 0c
func forem(d6 uint32, dvd, dvr Float) (uint32, Float, int8) { // dvd=dst, dvr=src
	remsign := dvd.sign
	quosign := dvd.sign != dvr.sign

	d6 &^= 0xc0000000 // clear precision bits to "extended" for coerce()

	zero := Float{remsign, 0, 0}
	nan := Float{remsign, 0x7fff, 0x4009000000000000} // NANREM

	switch {
	case dvd.IsNum() && dvr.IsNum():
		nbits := int(dvd.exp - dvr.exp + 2)
		if nbits <= 0 {
			goto returnDividend
		}

		quo, rem := restoringDivision(dvd.mant, dvr.mant, nbits)

		if quo&1 != 0 {
			if rem != 0 || quo&2 != 0 {
				remsign = !remsign
				quo += 2
			}

			rem = dvr.mant - rem
		}

		d0 := int8(quo >> 1 & 0x7f)
		if quosign { // i.e. quotient is negative
			d0 = -d0
		}

		d6, result := zNormCoerce(d6, Float{remsign, dvr.exp - 1, rem}, 0)
		return d6, result, d0

	case dvd.IsNum() && dvr.Is0():
		d6 |= INVALID
		return d6, nan, 0

	case dvd.IsNum() && dvr.IsInf():
		goto returnDividend

	case dvd.Is0() && dvr.IsNum():
		return d6, zero, 0

	case dvd.Is0() && dvr.Is0():
		d6 |= INVALID
		return d6, nan, 0

	case dvd.Is0() && dvr.IsInf():
		return d6, zero, 0

	case dvd.IsInf():
		d6 |= INVALID
		return d6, nan, 0

	default:
		panic("at least one of the arguments is NaN")
	}

returnDividend:
	d6, dvd = zNormCoerce(d6, dvd, 0 /*sticky bits*/)
	return d6, dvd, 0 /*d0*/
}

// Opcode 10
// Stuff the two's complement integer in the mant field
func fox2z(d6 uint32, f Float) (uint32, Float) {
	sticky := uint16(0)

	// Float coercion is implemented elsewere
	if d6&0x4000000 == 0 { // not DSTINT, i.e. am converting to float
		if f.IsNum() {
			d6, f = coerce(d6, f, 0)
		}
		return d6, f
	}

	if f.Is0() {
		return d6, f
	}

	if f.IsInf() {
		goto integerOverflow
	}

	// 2^64 and larger are not representable
	if f.exp >= 0x3fff+63 {
		goto integerOverflow
	}

	// "Right-align" so that the smallest bit has a place value of one
	const ialign = 0x3fff + 63
	if f.exp < ialign {
		f.mant, sticky = rshift(int(ialign-f.exp), f.mant, sticky)
		f.exp = ialign
	}

	// Dispose of the fractional bits
	d6, f.mant = roundInt(d6, f, sticky)

	// Can fit in a 16/32/64 bit two's complement number?
	if d6&0x1000000 != 0 { // int32
		if f.mant > 0x80000000 || (f.mant > 0x7fffffff && f.sign == false) {
			goto integerOverflow
		}
	} else if d6&0x2000000 != 0 { // comp64
		// different because 8000000000000000 is reserved for NaN
		if f.mant > 0x7fffffffffffffff {
			goto integerOverflow
		}
	} else { // int16
		if f.mant > 0x8000 || (f.mant > 0x7fff && f.sign == false) {
			goto integerOverflow
		}
	}

	// Take two's complement if negative
	if f.sign {
		f.mant = -f.mant
	}

	return d6, f

integerOverflow:
	if d6&0x1000000 != 0 { // int32
		f.mant = 0x80000000
	} else if d6&0x2000000 != 0 { // comp64
		f.mant = 0x8000000000000000
	} else { // int16
		f.mant = 0x8000
	}

	d6 |= INVALID
	d6 &^= INEXACT // (INEXACT was set by roundInt)

	return d6, f
}

// Opcode 12
func fosqrt(d6 uint32, f Float) (uint32, Float) {
	if f.Is0() {
		return d6, f
	}

	if f.sign {
		d6 |= INVALID
		return d6, Float{f.sign, 0x7fff, 0x4001000000000000} // SQRTNAN
	}

	if f.IsInf() {
		return d6, f
	}

	oddExponent := f.exp&1 != 0
	f.exp >>= 1
	if oddExponent {
		f.exp += 1
	}
	f.exp += 0x1fff // rebias

	radicand := new(big.Int).SetUint64(f.mant)
	root := big.NewInt(3)

	if oddExponent {
		radicand.Lsh(radicand, 1)
	} else {
		radicand.Lsh(radicand, 2)
	}

	radicand.Sub(radicand, new(big.Int).Lsh(big.NewInt(1), 64))

	for i := 0; i < 65; i++ {
		radicand.Lsh(radicand, 2)
		root.Lsh(root, 1)
		root.Sub(root, big.NewInt(1))

		bigroot := new(big.Int).Lsh(root, 64)
		if radicand.Cmp(bigroot) >= 0 {
			radicand.Sub(radicand, bigroot)
			root.Add(root, big.NewInt(2))
		}
	}

	if radicand.Cmp(big.NewInt(0)) == 0 {
		root.Sub(root, big.NewInt(1))
	}

	b := root.Bytes()
	sticky := uint16(b[len(b)-1]) << 13

	root = root.Rsh(root, 3)
	f.mant = root.Uint64()

	return coerce(d6, f, sticky)
}

// Opcode 14, 16
func forti(d6 uint32, f Float) (uint32, Float) {
	if !f.IsNum() {
		return d6, f
	}

	wantExp := int32(0x3fff)
	if d6&0x80000000 != 0 { // single
		wantExp += 23
	} else if d6&0x40000000 != 0 { // double
		wantExp += 52
	} else { // extended
		wantExp += 63
	}

	// Right-align, so that every sub-integer bit spills out into sticky
	sticky := uint16(0)
	if f.exp < wantExp {
		f.mant, sticky = rshift(int(wantExp-f.exp), f.mant, sticky)
		f.exp = wantExp
	}

	// Call coerce() without pre-normalising, to preserve this alignment
	// Do not permit coerce to set the LSTRND bit
	saveState := getFPState()
	d6, f = coerce(d6, f, sticky)
	setFPState(saveState)

	// Post-normalise
	if f.mant == 0 { // also catches infinities from coerce()
		f.exp = 0
	} else {
		for f.mant>>63 == 0 {
			f.mant <<= 1
			f.exp -= 1
		}
	}

	return d6, f
}

// Opcode 18
func foscalb(d6 uint32, f Float, by int16) (uint32, Float) {
	if f.Is0() || f.IsInf() {
		return d6, f
	}

	f.exp += int32(by)
	return coerce(d6, f, 0)
}

// Opcode 1a
func fologb(d6 uint32, f Float) (uint32, Float) {
	f.sign = false
	if f.Is0() {
		d6 |= DIVZER
		return d6, Float{true, 0x7fff, 0} // -inf
	} else if f.IsInf() {
		return d6, Float{false, 0x7fff, 0} // +inf
	} else {
		result := Float{exp: 0x403e}

		if f.exp < 0x3fff {
			result.sign = true
			result.mant = uint64(0x3fff - f.exp)
		} else {
			result.mant = uint64(f.exp - 0x3fff)
		}

		return zNormCoerce(d6, result, 0)
	}
}

// Opcode 09
// This function may return a signalling NaN, but the final result
// will always be quiet due to conversion by FOX2Z.
func fod2b(sign bool, decimalExp int, str []byte) Float {
	// Zero
	if len(str) == 0 || str[0] == '0' {
		return Float{sign, 0, 0}
	}

	// Infinity
	if str[0] == 'I' {
		return Float{sign, 0x7fff, 0}
	}

	// NaN
	if str[0] == 'N' {
		ndig := len(str) - 1
		if ndig > 16 {
			ndig = 16
		}

		mant := uint64(0)
		for _, digit := range str[1 : 1+ndig] {
			if int8(digit) > '9' {
				digit += 9
			}
			mant <<= 4
			mant |= uint64(digit & 0xf)
		}

		// Left align
		mant <<= 64 - 4*ndig

		// If few, then right align in top 16
		if ndig < 4 {
			mant >>= 16 - 4*ndig
		}

		mant &^= 1 << 63 // clear top bit
		if mant == 0 {
			mant = 0x4015000000000000 // NANZERO
		}

		return Float{sign, 0x7fff, mant}
	}

	// Truncate to 19 digits, but remember if 20th was nonzero
	truncatedNonzero := false
	if len(str) > 19 {
		truncatedNonzero = str[19]&0xf != 0
		str = str[:19]
	}

	// Interpret the decimal digits
	decimalMant := uint64(0)
	for _, digit := range str {
		decimalMant *= 10
		decimalMant += uint64(digit & 0xf)
	}

	// Append zeroes up to 19 chars
	// DO NOT use Go's append utility because it will corrupt the memory array
	for i := 0; len(str)+i < 19 && decimalExp > 27; i++ {
		decimalMant *= 10
		decimalExp -= 1
	}

	return timesExp10(Float{sign, 0x403e, decimalMant}, int(decimalExp), truncatedNonzero)
}

// Opcode 0b
func fob2d(f Float, fixed bool, digits int) (sign bool, decimalExp int, str []byte) {
	if f.Is0() {
		return f.sign, 0, []byte("0")
	}

	if f.IsInf() {
		return f.sign, 0, []byte("I")
	}

	if f.IsNaN() {
		str = make([]byte, 17)
		str[0] = 'N'

		for i := 0; i < 16; i++ {
			val := byte(f.mant >> (60 - 4*i) & 0xf)
			if val <= 9 {
				val += '0'
			} else {
				val += 'A' - 10
			}
			str[i+1] = val
		}

		return f.sign, decimalExp, str
	}

	// Nonzero real number.
	if !fixed {
		if digits < 1 {
			digits = 1
		} else if digits > 19 {
			digits = 19
		}
	}

	log10 := 0
	if !fixed {
		// Approximate binary log as concatenating exponent and mantissa bits
		log2 := int32((f.exp-0x3fff)<<16) | int32(f.mant>>47&0xfffe)

		// and convert to decimal log (ceiling, but probably an underestimate)
		logAdjust := uint32(0x4d104d42)
		if log2 < 0 {
			logAdjust += 1
		}
		log10 = int(mul32su(logAdjust, log2) + 1)
	}

	// f might have a negative exponent from pack()
	// We will need to save it to memory for reentrant calls, so fix that.
	for f.exp < 0 {
		f.exp += 1
		f.mant >>= 1
	}

	// Divide f by a decimal unit
	var scaled Float
	for {
		decimalExp = log10 - digits // part of return val

		scaled = timesExp10(f, -int(decimalExp), false)

		// Round to the nearest integer
		sp, oldsp := pushzero(10)
		packExt(mem[sp:], scaled)
		pushl(sp)
		pushw(0x0014) // FRINTX
		tFP68K()
		scaled = unpackExt(mem[sp:])
		writel(spptr, oldsp)

		var check Float
		if fixed {
			check = exp10(19)
		} else {
			check = exp10(int(digits))
		}

		// If it doesn't go, then try a different one
		if scaled.exp > check.exp || (scaled.exp == check.exp && scaled.mant >= check.mant) {
			if fixed {
				return f.sign, decimalExp, []byte("?")
			} else {
				log10 += 1
				continue
			}
		} else {
			break
		}
	}

	if !fixed {
		check := exp10(int(digits) - 1)
		if scaled.exp < check.exp || (scaled.exp == check.exp && scaled.mant < check.mant) {
			scaled = check
		}
	}

	if scaled.mant == 0 {
		return f.sign, decimalExp, []byte("0")
	}

	// Turn scaled.mant into a right-aligned integer
	for scaled.exp < 0x403e {
		scaled.mant >>= 1
		scaled.exp += 1
	}

	quo, _ := restoringDivision(scaled.mant, 10000000000000000000, 65)
	quo += 1

	str = make([]byte, 0, 19)
	for i := 0; i < 19; i++ {
		// Add quo to itself 10 times, counting the number of overflows
		digit := byte(0)
		accum := uint64(0)
		for j := 0; j < 10; j++ {
			accum += quo
			if accum < quo {
				digit += 1
			}
		}
		quo = accum

		// Strip leading zeros
		if len(str) > 0 || digit != 0 {
			str = append(str, '0'+byte(digit))
		}
	}

	return f.sign, decimalExp, str
}

// Opcode 13
func fonext(d6 uint32, dst, src uint32) uint32 {
	format := uint16(d6 >> 16 & 0x3800) // OR this with opcodes

	for i := 0; i < 11; i++ {
		pushw(0)
	}
	frame := readl(spptr)

	// Convert src to extended
	pushl(src)
	pushl(frame + 10)
	pushw(format + 0x0e) // FOZ2X
	tFP68K()

	// Is it zero?
	pushl(frame) // zeroed
	pushl(frame + 10)
	pushw(0x0008) // FOCMP
	tFP68K()
	isZero := z

	// Convert dst to extended
	pushl(dst)
	pushl(frame)
	pushw(format + 0x0e) // FOZ2X
	tFP68K()

	// Compare src and dst
	pushl(frame)
	pushl(frame + 10)
	pushw(0x0008) // FOCMP
	tFP68K()

	if v { // NaN
		// Pick the "winner"
		pushl(frame)
		pushl(frame + 10)
		pushw(0x0004) // FOMUL, but could be any 2-arg arithmetic
		tFP68K()

		// Return that NaN
		pushl(frame + 10)
		pushl(src)
		pushw(format + 0x10) // FOX2Z
		tFP68K()

	} else if !z { // Increment or decrement
		if c != (readb(src)&0x80 != 0) { // Enlarge src
			if format&0x1000 != 0 { // single
				writel(src, readl(src)+1)
			} else if format&0x800 != 0 { // double
				writed(src, readd(src)+1)
			} else { // extended
				exp := readw(src) // actually has sign too
				mant := readd(src + 2)

				mant += 1
				if mant == 0 { // rollover
					exp += 1
					mant = 0x8000000000000000
					if exp&0x7fff == 0x7fff { // ensure infinity looks like zero
						mant = 0
					}
				}

				writew(src, exp)
				writed(src+2, mant)
			}
		} else { // Shrink src
			if format&0x1000 != 0 { // single
				if isZero {
					writel(src, readl(src)+0x80000001)
				} else {
					writel(src, readl(src)-1)
				}
			} else if format&0x800 != 0 { // double
				if isZero {
					writeb(src, readb(src)^0x80)
					writew(src+6, readw(src+6)+1)
				} else {
					writed(src, readd(src)-1)
				}
			} else { // extended
				if isZero {
					writeb(src, readb(src)^0x80)
					writew(src+8, readw(src+8)+1)
				} else {

					exp := readw(src) // actually has sign too
					mant := readd(src + 2)

					// I suspect that this is buggy
					mant -= 1
					if mant == 0xffffffffffffffff {
						exp -= 1
					} else if mant&0x80000000ffffffff == 0xffffffff {
						if exp&0x7fff != 0 {
							mant += 1 << 63
							exp -= 1
						}
					}

					writew(src, exp)
					writed(src+2, mant)
				}
			}
		}

		// Test our shrunk number for exceptions
		pushl(src)
		pushl(frame + 20)
		pushw(format + 0x1c) // FOCLASS
		tFP68K()
		class := readw(frame + 20)

		if class&0x8000 != 0 {
			class = -class
		}

		if class == 3 { // infinity, overflow
			d6 |= INEXACT | OFLOW
		} else if class != 5 { // not normal, underflow
			d6 |= INEXACT | UFLOW
		}
	}

	writel(spptr, frame+22)
	return d6
}

func (f Float) Is0() bool {
	return f.exp == 0 && f.mant == 0
}

func (f Float) IsNum() bool {
	return f.exp != 0x7fff && f.mant != 0
}

func (f Float) IsInf() bool {
	return f.exp == 0x7fff && f.mant == 0
}

func (f Float) IsNaN() bool {
	return f.exp == 0x7fff && f.mant != 0
}

// Usually takes only norms, but FORTI is allowed to send denorms
func coerce(d6 uint32, f Float, sticky uint16) (uint32, Float) {
	rndMode := getFPState() >> 13 & 3

	prec := int(d6 >> 30)
	if prec == 3 { // treat undefined as single
		prec = singlePrec
	}

	var loExp, hiExp int32
	var ignore int
	switch prec {
	case extendedPrec:
		loExp, hiExp = 0, 0x7ffe
		ignore = 0
	case doublePrec:
		loExp, hiExp = 0x3c01, 0x43fe
		ignore = 11
	case singlePrec:
		loExp, hiExp = 0x3f81, 0x407e
		ignore = 40
	}

	// Underflow
	if f.exp < loExp {
		d6 |= UFLOW
		f.mant, sticky = rshift(int(loExp-f.exp), f.mant, sticky)
		f.exp = loExp
	}

	// Discard bits to match precision, preserving rightmost ones as sticky
	if prec != singlePrec {
		f.mant, sticky = rshift(ignore, f.mant, sticky)
		f.mant <<= ignore
	} else {
		// Emulate SANE's buggy coercion to single precision

		// Test D5.L and SNE&OR D7.B
		if f.mant&0xffffffff != 0 {
			sticky |= 0xff
		}

		// Left-shift D4.B, and right-shift the carried bit into D7.W
		sticky >>= 1
		if f.mant>>32&0x80 != 0 {
			sticky |= 0x8000
		}

		// OR the shifted D4.B into D7.B
		sticky |= uint16(f.mant >> 31 & 0xfe)

		// Finally truncate the bits
		f.mant &= 0xffffff0000000000
	}

	// Round -- enlarge mantissa or leave as is?
	enlarge := false
	if sticky == 0 {
		d6 &^= UFLOW
	} else {
		d6 |= INEXACT
		switch rndMode {
		case rndNearest:
			switch {
			case sticky < 0x8000:
				enlarge = false
			case sticky == 0x8000:
				enlarge = f.mant&(1<<ignore) != 0
			case sticky > 0x8000:
				enlarge = true
			}
		case rndUp:
			enlarge = !f.sign
		case rndDown:
			enlarge = f.sign
		case rndZero:
			enlarge = false
		}
	}

	// Mantissa larger, and handle if it wraps around
	if enlarge {
		f.mant += 1 << ignore
		if f.mant == 0 {
			f.mant = 0x8000000000000000
			f.exp += 1
		}

		setFPState(getFPState() | LSTRND)
	}

	// Overflow
	if f.exp > hiExp {
		d6 |= INEXACT | OFLOW
		if rndMode == 0 ||
			(rndMode == 1 && f.sign == false) ||
			(rndMode == 2 && f.sign == true) {
			f.exp = 0x7fff // infinity
			f.mant = 0
		} else {
			f.exp = hiExp // largest finity
			f.mant = 0xffffffffffffffff << ignore
		}
	}

	return d6, f
}

func zNormCoerce(d6 uint32, f Float, sticky uint16) (uint32, Float) {
	if f.mant == 0 && sticky == 0 {
		f.exp = 0
		return d6, f
	} else {
		return normCoerce(d6, f, sticky)
	}
}

func normCoerce(d6 uint32, f Float, sticky uint16) (uint32, Float) {
	if f.mant == 0 {
		panic("can't feed zero to nornCoerce, need zNormCoerce!")
	}

	for f.mant>>63 == 0 {
		f.exp -= 1
		f.mant <<= 1
		if sticky&0x8000 != 0 {
			f.mant |= 1
		}
		sticky <<= 1
	}

	return coerce(d6, f, sticky)
}

// Does not account for comparisons and classifys
// Does not raise the invalid signal for non-NaN-capable formats
func nanCoerce(format int, precision int, f Float) Float {
	if !f.IsNaN() {
		panic("non-NaN passed to nanCoerce")
	}

	switch format {
	case 4: // int16
		f.mant = 0x8000
	case 5: // int32
		f.mant = 0x80000000
	case 6: // comp64
		f.mant = 0x8000000000000000
	default: // floating formats
		switch precision {
		case 1: // double
			f.mant &= 0xfffffffffffff800
		case 2, 3: // single
			f.mant &= 0xffffff0000000000
		}

		if f.mant&0xbfffffffffffffff == 0 {
			f.mant = 0x4015000000000000
		}

		f.mant |= 0x4000000000000000 // always set the quiet bit
	}

	return f
}

// Round an integer that is right-aligned in f.mant
// A special enough case of coerce() that it deserves its own function
func roundInt(d6 uint32, f Float, sticky uint16) (uint32, uint64) {
	rndMode := getFPState() >> 13 & 3

	// Round -- enlarge mantissa or leave as is?
	enlarge := false
	if sticky != 0 {
		d6 |= INEXACT
		switch rndMode {
		case rndNearest:
			switch {
			case sticky < 0x8000:
				enlarge = false
			case sticky == 0x8000:
				enlarge = f.mant&1 != 0
			case sticky > 0x8000:
				enlarge = true
			}
		case rndUp:
			enlarge = !f.sign
		case rndDown:
			enlarge = f.sign
		case rndZero:
			enlarge = false
		}
	}

	// Mantissa larger, and handle if it wraps around
	if enlarge {
		f.mant += 1
		if f.mant == 0 {
			panic("should never get an int that rounds and flips")
		}

		setFPState(getFPState() | LSTRND)
	}

	return d6, f.mant
}

// would usually return mantissa in d4/d5
func unpack(format int, slice []byte) (f Float, denorm bool, signal bool) {
	switch format {
	case 0: // extended
		f.sign = slice[0]&0x80 != 0
		f.exp = int32(int16(binary.BigEndian.Uint16(slice) & 0x7fff))
		f.mant = binary.BigEndian.Uint64(slice[2:])

		if f.exp == 0x7fff {
			goto infOrNaN
		}

		if f.mant>>63 != 0 {
			goto norm
		}

		goto zeroOrDenorm

	case 1: // double
		f64 := binary.BigEndian.Uint64(slice)
		f.sign = f64>>63 != 0
		f.mant = f64 << 11 & 0x7ffffffffffff800
		f.exp = int32(int16(f64 >> 52 & 0x7ff))

		if f.exp == 0 {
			f.exp = 0x3c01
			goto zeroOrDenorm
		} else if f.exp == 0x7ff {
			goto infOrNaN
		} else {
			f.mant |= 1 << 63
			f.exp += 0x3c00
			goto norm
		}

	case 2: // single
		f32 := binary.BigEndian.Uint32(slice)
		f.sign = f32>>31 != 0
		f.mant = uint64(f32) << 40 & 0x7fffff0000000000
		f.exp = int32(int16(f32 >> 23 & 0xff))

		if f.exp == 0 {
			f.exp = 0x3f81
			goto zeroOrDenorm
		} else if f.exp == 0xff {
			goto infOrNaN
		} else {
			f.mant |= 1 << 63
			f.exp += 0x3f80
			goto norm
		}

	case 4: // int16
		i16 := binary.BigEndian.Uint16(slice)
		if i16>>15 != 0 {
			f.sign = true
			i16 = -i16
		}
		f.mant = uint64(i16) << 48
		f.exp = 0x400e
		if f.mant == 0 {
			goto zero
		} else {
			goto normaliseInt
		}

	case 5: // int32
		i32 := binary.BigEndian.Uint32(slice)
		if i32>>31 != 0 {
			f.sign = true
			i32 = -i32
		}
		f.mant = uint64(i32) << 32
		f.exp = 0x401e
		if f.mant == 0 {
			goto zero
		} else {
			goto normaliseInt
		}

	case 6: // comp64
		f.mant = binary.BigEndian.Uint64(slice)
		if f.mant == 0x8000000000000000 {
			f.exp = 0x7fff
			f.mant = 0x4014000000000000
			goto NaN
		}

		if f.mant>>63 != 0 {
			f.sign = true
			f.mant = -f.mant
		}
		f.exp = 0x403e
		if f.mant == 0 {
			goto zero
		} else {
			goto normaliseInt
		}

	default:
		panic("invalid format to unpack")
	}

zeroOrDenorm:
	if f.mant == 0 {
		goto zero
	} else {
		goto denormFloat
	}

zero:
	f.exp = 0
	return

denormFloat:
	denorm = true

normaliseInt:
	for f.mant>>63 == 0 {
		f.mant <<= 1
		f.exp -= 1
	}
	return

norm:
	return

infOrNaN:
	f.exp = 0x7fff
	f.mant &= 0x7fffffffffffffff
	if f.mant == 0 {
		goto inf
	} else {
		goto NaN
	}

inf:
	return

NaN:
	signal = f.mant&(1<<62) == 0 // check !QNANBIT
	f.mant |= 1 << 62            // set QNANBIT
	return

}

// Unlike the general pack/unpack, these do not normalise/denormalise the number.
// They are helper functions to enable the use of Float structs in code that
// reenters SANE to do arithmetic like FADDX, FMULX etc.
// They have no analog in Apple SANE.
func unpackExt(slice []byte) Float {
	return Float{
		sign: slice[0]&0x80 != 0,
		exp:  int32(int16(binary.BigEndian.Uint16(slice) & 0x7fff)),
		mant: binary.BigEndian.Uint64(slice[2:]),
	}
}

// d6 only used for UFLOW bit
func pack(format int, f Float, slice []byte, d6 uint32) {
	switch format {
	case 0: // extended
		// truly need to check the "UFLOW" underflow bit??
		if d6&0x200 != 0 && f.exp != 0 {
			if f.mant == 0 {
				f.exp = 0
			} else {
				// normalise
				for f.exp != 0x7fff && f.exp != 0 && f.mant>>63 == 0 && f.mant != 0 {
					f.exp -= 1
					f.mant <<= 1
				}
			}
		}

		binary.BigEndian.PutUint16(slice, uint16(f.exp))
		binary.BigEndian.PutUint64(slice[2:], f.mant)
		if f.sign {
			slice[0] |= 0x80
		}

	case 1: // double
		if f.exp == 0x7fff {
			f.exp = 0x800 // will get decremented to 0x7ff
		} else if f.exp == 0 {
			f.exp = 1 // will get decremented to 0
		} else {
			f.exp -= 0x3c00 // adjust exponent bias
		}

		// surprising that this applies to inf and NaN
		if f.mant>>63 == 0 {
			f.exp -= 1
		}
		f.mant <<= 1

		// squish all together
		f64 := uint64(f.exp)<<52 | f.mant>>12
		if f.sign {
			f64 |= 1 << 63
		}

		binary.BigEndian.PutUint64(slice, f64)

	case 2: // single
		if f.exp == 0x7fff {
			f.exp = 0x100 // will get decremented to 0xff
		} else if f.exp == 0 {
			f.exp = 1 // will get decremented to 0
		} else {
			f.exp -= 0x3f80 // adjust exponent bias
		}

		// surprising that this applies to inf and NaN
		if f.mant>>63 == 0 {
			f.exp -= 1
		}
		f.mant <<= 1

		// squish all together
		f32 := uint32(f.exp<<23) | uint32(f.mant>>41)
		if f.sign {
			f32 |= 1 << 31
		}

		binary.BigEndian.PutUint32(slice, f32)

	case 4: // int16
		binary.BigEndian.PutUint16(slice, uint16(f.mant))

	case 5: // int32
		binary.BigEndian.PutUint32(slice, uint32(f.mant))

	case 6: // comp64
		binary.BigEndian.PutUint64(slice, f.mant)

	default:
		panic("invalid format to pack")
	}
}

func packExt(slice []byte, f Float) {
	if f.exp < 0 || f.exp > 0x7fff {
		panic("exponent out of range of an extended float")
	}

	binary.BigEndian.PutUint16(slice, uint16(f.exp))
	binary.BigEndian.PutUint64(slice[2:], f.mant)
	if f.sign {
		slice[0] |= 0x80
	}
}

func rshift(by int, mant uint64, sticky uint16) (uint64, uint16) {
	if by > 66 {
		by = 66
	}

	for i := 0; i < by; i++ {
		if sticky&1 != 0 {
			sticky |= 0x1ff
		}
		sticky >>= 1

		if mant&1 != 0 {
			sticky |= 0x8000
		}
		mant >>= 1
	}

	return mant, sticky
}

// Hideous! There are machine instructions to do this.
func mul64(a, b uint64) (hi, lo uint64) {
	for i := 0; i < 64; i++ {
		if a&(1<<i) != 0 {
			ladd := b << i
			lo += ladd
			if lo < ladd {
				hi += 1 // carry
			}
			hi += b >> (64 - i)
		}
	}
	return
}

// Unusual operation
func mul32su(d0 uint32, d1 int32) int16 {
	var result int32

	d0h := int16(d0 >> 16)
	d0l := int16(d0)
	d1h := int16(d1 >> 16)
	d1l := int16(d1)

	result += int32(uint32(uint16(d0h)) * uint32(uint16(d1l)) >> 16) // unsigned
	result += int32(d0l) * int32(d1h) >> 16
	result += int32(d0h) * int32(d1h)

	return int16(result >> 16)
}

func restoringDivision(dvd, dvr uint64, nbits int) (quo, rem uint64) {
	rem = dvd

	for i := 0; i < nbits; i++ {
		if i != 0 {
			quo <<= 1

			mustSubtract := rem>>63 != 0
			rem <<= 1

			if mustSubtract {
				goto doSubtract
			}
		}

		if rem < dvr {
			goto dontSubtract
		}

	doSubtract:
		quo |= 1
		rem -= dvr
	dontSubtract:
	}

	return
}

// Strange shortcut to multiplication
func timesExp10(f Float, decimalExp int, inexact bool) Float {
	// Because we postprocess the result of FMULX/FDIVX, we must adjust the
	// rounding direction of those operations:
	oldState := getFPState()
	oldRndMode := oldState >> 13 & 3

	//              ++++ ++++ ---- ----  sign of mantissa
	//              ++++ ---- ++++ ----  sign of exponent
	//              ~^v0 ~^v0 ~^v0 ~^v0  rounding dir (near/up/down/zero)
	modeLookup := 0x0122_0211_0212_0121
	modeLookup <<= oldRndMode * 4
	if f.sign {
		modeLookup <<= 32
	}
	if decimalExp < 0 {
		modeLookup <<= 16
	}

	rndMode := uint16(modeLookup >> 60) // get new rounding mode in bottom bits
	setFPState(rndMode<<13 | oldState&0xff)

	// Get 10^|decimalExp|. Calls through to FMULX, using the round mode we just set.
	scale := exp10(decimalExp)

	// Get decimalMant * 10^decimalExp, or decimalMant / 10^-decimalExp
	setFPState(getFPState() | 0x6000) // force round-to-zero
	if decimalExp >= 0 {
		f = reenter2(0x0004, f, scale) // FMULX
	} else {
		f = reenter2(0x0006, f, scale) // FDIVX
	}

	// Test INEXACT
	// inexact may already be true because the calling routine truncated digits
	if getFPState()&INEXACT != 0 {
		inexact = true
	}

	// Restore state: OR flags, discard rounding mode.
	// Bottom byte is not changed by the routines we called, so don't restore.
	setFPState(oldState&0xff00 | getFPState()&0x1fff)

	// The below adjustments will be according to the original rounding mode
	if inexact {
		setFPState(getFPState() | INEXACT) // Set INEXACT, if not already done

		rndMode := getFPState() >> 13 & 3
		switch rndMode {
		case rndNearest:
			// Force-set LSB
			if f.exp != 0x7fff {
				f.mant |= 1
			}

		case rndUp, rndDown:
			// Add a half-LSB
			halfLSB := Float{f.sign, f.exp - 1, 1}
			if halfLSB.exp == -1 {
				halfLSB.exp = 0
			}

			f = reenter2(0x0000, f, halfLSB) // FOADD

		case rndZero: // Do nothing
		}
	}

	return f
}

type step struct {
	exp     int
	inexact int
	float   Float
}

// 10^3296 and so on, most of them imprecise
var largePowersOf10 = [...]step{
	{3296, +1, Float{false, 0x6ac4, 0x86d48d6626c27eec}},
	{1648, +1, Float{false, 0x5561, 0xb9c94b7fa8d76515}},
	{824, +1, Float{false, 0x4ab0, 0x9a35b24641d05953}},
	{412, +1, Float{false, 0x4557, 0xc6b0a096a95202be}},
	{206, -1, Float{false, 0x42ab, 0x9f79a169bd203e41}},
	{108, +1, Float{false, 0x4165, 0xda01ee641a708dea}},
	{55, +1, Float{false, 0x40b5, 0xd0cf4b50cfe20766}},
	{27, 0, Float{false, 0x4058, 0xcecb8f27f4200f3a}},
	{14, 0, Float{false, 0x402d, 0xb5e620f480000000}},
}

// 10^0 and so on
var smallPowersOf10 = [...]Float{
	{false, 0x3fff, 0x8000000000000000},
	{false, 0x4002, 0xa000000000000000},
	{false, 0x4005, 0xc800000000000000},
	{false, 0x4008, 0xfa00000000000000},
	{false, 0x400c, 0x9c40000000000000},
	{false, 0x400f, 0xc350000000000000},
	{false, 0x4012, 0xf424000000000000},
	{false, 0x4016, 0x9896800000000000},
	{false, 0x4019, 0xbebc200000000000},
	{false, 0x401c, 0xee6b280000000000},
	{false, 0x4020, 0x9502f90000000000},
	{false, 0x4023, 0xba43b74000000000},
	{false, 0x4026, 0xe8d4a51000000000},
	{false, 0x402a, 0x9184e72a00000000},
	{false, 0x402d, 0xb5e620f480000000},
}

// gets and sets flags, beware
func exp10(exp int) Float {
	if exp < 0 {
		exp = -exp
	}

	if exp > 5000 {
		exp = 5000
	}

	one := Float{false, 0x3fff, 0x8000000000000000}
	accum := one

	if exp >= 15 {
		for _, step := range largePowersOf10 {
			if exp < step.exp {
				continue
			}
			exp -= step.exp

			float := step.float

			if step.inexact != 0 {
				setFPState(getFPState() | INEXACT)

				rndMode := int(getFPState() >> 13 & 3)
				switch step.inexact * rndMode {
				case +rndDown, +rndZero:
					float.mant -= 1
				case -rndUp:
					float.mant += 1
				}
			}

			if accum == one {
				accum = float
			} else {
				accum = reenter2(0x0004, accum, float) // FMULX
			}
		}
	}

	// now exp <= 14
	if accum == one {
		accum = smallPowersOf10[exp]
	} else {
		accum = reenter2(0x0004, accum, smallPowersOf10[exp]) // FMULX
	}

	return accum
}
