// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// SANE unit tests
// Only for functions that can be isolated from a SANE binary,
// which is found in TestTools/sane (use a Mac Plus ROM)

package main

import (
	"bytes"
	"fmt"
	"math/rand"
	"os"
	"testing"
)

// The coerce function overflows, underflows and rounds a numeric result
func TestCoerce(t *testing.T) {
	rom, err := os.ReadFile("TestTools/sane")
	if err != nil {
		t.Fatal("Need a Mac Plus ROM in TestTools/sane")
	}

	// Standard PACK 4 header
	saneOffset := bytes.Index(rom, []byte{0x60, 0x0a, 0x00, 0x00, 0x50, 0x41, 0x43, 0x4b, 0x00, 0x04})
	if saneOffset == -1 {
		t.Fatal("No PACK 4 in TestTools/sane")
	}

	// The first (not only!) occurrence of "TST.L D6; BMI..."
	coerceOffset := bytes.Index(rom[saneOffset:], []byte{0x4a, 0x86, 0x6b})
	if coerceOffset == -1 {
		t.Fatal("No coerce function TestTools/sane")
	}

	const romBase = 0x1000000
	copy(mem[romBase:], rom)
	addr := uint32(romBase + saneOffset + coerceOffset)

	for _, exp := range interestingExps() {
		for secondbit := 1; secondbit < 80; secondbit++ {
			for _, sign := range [...]bool{false, true} {
				mant := uint64(0x8000000000000000)
				mant |= 0x8000000000000000 >> secondbit

				sticky := uint16(0)
				if secondbit >= 64 {
					sticky |= 0x8000 >> (secondbit - 64)
				}

				for dir := 0; dir < 4; dir++ {
					for prec := 0; prec < 3; prec++ {
						name := fmt.Sprintf(
							"sign,exp,mant,sticky,prec,dir="+
								"%v,%#x,%#016x,%#04x,%d,%d",
							sign, exp, mant, sticky, prec, dir)

						t.Run(name, func(t *testing.T) { testCoerce(t, addr, sign, exp, mant, sticky, prec, dir) })
					}
				}
			}
		}
	}
}

func testCoerce(t *testing.T, addr uint32, sign bool, exp int32, mant uint64, sticky uint16, prec, dir int) {
	fpState := uint16(dir<<13) | uint16(prec<<5)

	d6 := uint32(prec) << 30
	if sign {
		d6 |= 0xf0
	}

	// Run my version. It touches the global FPState.
	writew(0xa4a, fpState)
	myd6, myresult := coerce(d6, Float{sign, exp, mant}, sticky)
	myfpstate := readw(0xa4a)
	myd6 &= 0xffffff00 // discard sign bits
	mysign := myresult.sign
	myexp := myresult.exp
	mymant := myresult.mant

	// Run Apple's version. More legwork here.
	writew(0xa4a, fpState)
	writel(d6ptr, d6)
	writel(a4ptr, uint32(exp))
	writed(d4ptr, mant)
	writel(d7ptr, uint32(sticky))
	writel(a0ptr, 0xa4a)    // global pointer
	writel(spptr, 0xf00000) // safe place for stack
	run68(addr)
	theird6 := readl(d6ptr) & 0xffffff00 // discard sign bits
	theirfpstate := readw(0xa4a)
	theirsign := readl(d6ptr)&0x80 != 0
	theirexp := int32(readl(a4ptr))
	theirmant := readd(d4ptr)

	if theird6 != myd6 {
		t.Errorf("D6: Apple %08x me %08x", theird6, myd6)
	}

	if theirfpstate != myfpstate {
		t.Errorf("FPState: Apple %04x me %04x", theirfpstate, myfpstate)
	}

	if theirsign != mysign {
		t.Errorf("Sign: Apple %v me %v", theirsign, mysign)
	}

	if theirexp != myexp {
		t.Errorf("Exponent: Apple %#x me %#x", theirexp, myexp)
	}

	if theirmant != mymant {
		t.Errorf("Mantissa: Apple %016x me %016x", theirmant, mymant)
	}
}

func randExp() int32 {
	exp := int32(rand.Uint32())

	extendBits := 14 + rand.Intn(19)
	exp >>= extendBits

	exp += 0x3fff // bias me

	return exp
}

func randMantissa() uint64 {
	mant := uint64(0)
	nbits := rand.Intn(65)

	// Set a random number of bits!
	for i := 0; i < nbits; i++ {
		whichbit := rand.Intn(64)
		for mant>>whichbit&1 != 0 {
			whichbit = rand.Intn(64)
		}
		mant |= 1 << whichbit
	}

	// Cut some bits off the right, just for fun
	cutbits := [...]int{
		0, 0, 0, 0, 0, 10, 39,
	}[rand.Intn(7)]

	mant &= 0xffffffffffffffff << cutbits

	return mant
}

func randSticky() uint16 {
	sticky := uint16(rand.Uint32())

	switch rand.Intn(3) {
	case 0:
		sticky &= 0xff00
	case 1:
		sticky |= 0xff
	}

	if rand.Intn(4) != 0 {
		sticky &= 0xc0ff
	}

	return sticky
}

// Interesting exponents that we should test exhaustively
func interestingExps() []int32 {
	centers := [...]int32{0, 0x3c00, 0x3f80, 0x4000, 0x4080, 0x4400, 0x8000}

	exps := make([]int32, 2000)
	for _, c := range centers {
		for i := c - 90; i <= c+90; i++ {
			if len(exps) > 1 && exps[len(exps)-1] == i {
				continue
			}
			exps = append(exps, i)
		}
	}

	return exps
}
