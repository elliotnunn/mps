package main

import (
	"fmt"
)

const (
	kPascalStackBased                = 0
	kCStackBased                     = 1
	kRegisterBased                   = 2
	kThinkCStackBased                = 5
	kD0DispatchedPascalStackBased    = 8
	kD0DispatchedCStackBased         = 9
	kD1DispatchedPascalStackBased    = 12
	kStackDispatchedPascalStackBased = 14
)

// Return uint8, int16 or uint32 (note that 16-bit is signed, because often an error!)
func call68(ptr uint32, procInfo uint32, args ...interface{}) (ret interface{}) {
	// Convert signed args to their unsigned brethren
	for i, arg := range args {
		switch arg := arg.(type) {
		case int8:
			args[i] = uint8(arg)
		case int16:
			args[i] = uint16(arg)
		case int32:
			args[i] = uint32(arg)
		}
	}

	// Map a 4-bit code to a 68k register number: d0-d3-a0-a3-d4-d7-a4-a7
	regJumble := [...]byte{0, 1, 2, 3, 8, 9, 10, 11, 4, 5, 6, 7, 12, 13, 14, 15}

	// Helpful in interpreting the bit fields
	convention := procInfo & 0xf
	shift1st := 6
	shiftRest := 2
	if convention == kRegisterBased {
		shift1st = 1
		shiftRest = 5
	}

	// Check the number of arguments
	expect := 0
	for shift := shift1st; ; shift += shiftRest {
		if procInfo>>shift != 0 {
			expect += 1
		} else {
			break
		}
	}
	if expect != len(args) {
		panic(fmt.Sprintf("Expected %d args, got %d", expect, len(args)))
	}

	// Save all registers
	var regs [64]byte
	copy(regs[:], mem[d0ptr:])

	switch convention {
	case kRegisterBased:
		for i, arg := range args {
			sizeBits := procInfo >> (shiftRest*i + shift1st) & 3
			regBits := procInfo >> (shiftRest*i + shift1st + 2) & 0xf
			regPtr := d0ptr + 4*uint32(regJumble[regBits])

			switch sizeBits {
			case 1: // 1-byte
				writel(regPtr, uint32(arg.(uint8)))
			case 2: // 2-byte
				writel(regPtr, uint32(arg.(uint16)))
			case 3: // 4-byte
				writel(regPtr, arg.(uint32))
			}
		}

		run68(ptr)

		// Collect return value
		sizeBits := procInfo >> 4 & 3
		regBits := procInfo >> 6 & 0xf
		regPtr := d0ptr + 4*uint32(regJumble[regBits])

		switch sizeBits {
		case 0:
			ret = nil
		case 1: // 1-byte
			ret = uint8(readl(regPtr))
		case 2: // 2-byte
			ret = int16(readl(regPtr))
		case 3: // 4-byte
			ret = readl(regPtr)
		}

	default:
		panic("unimplemented ProcInfo")
	}

	// Restore all registers
	copy(mem[d0ptr:], regs[:])

	return ret
}
