// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"bytes"
	"fmt"
	"strconv"
	"strings"
)

func tDecStr68K() {
	selector := popw()

	switch selector {
	case 0: // NumToString
		ptr := readl(a0ptr)
		num := int(int32(readl(d0ptr)))
		str := strconv.Itoa(num)
		writePstring(ptr, macstring(str))

	case 1: // StringToNum
		str := string(readPstring(readl(a0ptr)))

		num := uint32(0)
		neg := false
		if strings.HasPrefix(str, "-") {
			neg = true
			str = str[1:]
		} else if strings.HasPrefix(str, "+") {
			neg = false
			str = str[1:]
		}

		for _, dig := range []byte(str) {
			num *= 10
			num += uint32(dig & 0xf)
		}

		if neg {
			num = -num
		}

		writel(d0ptr, num)

	case 2, 4: // PStr2Dec, CStr2Dec
		validPrefixPtr := popl() // return "ok" bool
		recordPtr := popl()      // return decimal record
		indexPtr := popl()       // return number of good bytes
		strPtr := popl()

		index := int(readw(indexPtr))
		if index&0x8000 != 0 {
			panic("Negative index")
		}

		// Get a slice: [index : pascalLength or nullTerminator]
		slice := mem[strPtr:]
		if selector == 2 { // length-prefixed
			slice = slice[:int(slice[0])+1]

			if len(slice) < index {
				panic("Index exceeds length of Pascal string")
			}

			slice = slice[index:]
		} else { // null-terminated
			slice = slice[index:]

			// I doubt it will be hard to find a null somewhere...
			nullOffset := bytes.IndexByte(slice, 0)
			if nullOffset != -1 {
				slice = slice[:nullOffset]
			}
		}

		decimal, validPrefix, consumed := str2dec(slice)

		copy(mem[recordPtr:], decimal)

		if validPrefix {
			writeb(validPrefixPtr, 1)
		} else {
			writeb(validPrefixPtr, 0)
		}

		writew(indexPtr, readw(indexPtr)+uint16(consumed))

	default:
		panic("unimp")

	}
}

func str2dec(str []byte) (decimal []byte, validPrefix bool, consumed int) {
	decimal = make([]byte, 5, 260)
	exp := int16(0)

	defer func() {
		// Default answer
		if len(decimal) == 5 {
			decimal = append(decimal, "N0011"...)
		}

		decimal[2] = byte(exp >> 8) // exponent field
		decimal[3] = byte(exp)
		decimal[4] = uint8(len(decimal) - 5) // length byte

		// validPrefix = (read past end of string) || (read whole string)
		// i.e. "the token stream might continue"
		if recover() != nil || consumed == len(str) {
			validPrefix = true
		}

	}()

	i := 0

	for str[i] == '\t' || str[i] == ' ' {
		i++
	}

	if str[i] == '-' {
		decimal[0] = 1 // decimal.sgn = true
		i++
	} else if str[i] == '+' {
		i++ // ignore
	}

	switch str[i] {
	case 'I', 'i':
		i++

		if str[i] != 'N' && str[i] != 'n' {
			return
		}
		i++

		if str[i] != 'F' && str[i] != 'f' {
			return
		}
		i++

		consumed = i // checkpoint
		decimal = append(decimal, 'I')
		return

	case 'N', 'n':
		i++

		if str[i] != 'A' && str[i] != 'a' {
			return
		}
		i++

		if str[i] != 'N' && str[i] != 'n' {
			return
		}
		i++

		consumed = i // checkpoint
		decimal = append(decimal, "N4000"...)
		// this is locked in, in case we panic below

		if str[i] != '(' {
			return
		}
		i++

		nanCode := 0
		for '0' <= str[i] && str[i] <= '9' {
			nanCode = nanCode*10 + int(str[i]-'0')
			i++
		}
		nanCode &= 0xff

		if str[i] != ')' {
			return
		}
		i++

		consumed = i // checkpoint
		decimal = append(decimal[:5], fmt.Sprintf("N40%02X", nanCode)...)
		return

	case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.':
		digits := make([]byte, 0, 255)

		// Strip leading and trailing zeros, even if we panic
		defer func() {
			for len(digits) >= 2 && digits[0] == '0' {
				digits = digits[1:]
			}
			for len(digits) >= 2 && digits[len(digits)-1] == '0' {
				digits = digits[:len(digits)-1]
				exp += 1
			}
			if len(digits) == 1 && digits[0] == '0' {
				exp = 0
			}

			decimal = append(decimal, digits...)
		}()

		for '0' <= str[i] && str[i] <= '9' {
			digits = append(digits, str[i])
			i++
			consumed = i // checkpoint
		}

		if str[i] == '.' {
			i++
			consumed = i // checkpoint

			for '0' <= str[i] && str[i] <= '9' {
				digits = append(digits, str[i])
				i++
				consumed = i // checkpoint
				exp -= 1
			}
		}

		if str[i] == 'E' || str[i] == 'e' {
			i++

			neg := false
			if str[i] == '-' {
				neg = true
				i++
			} else if str[i] == '+' {
				i++ // ignore
			}

			expField := int16(0)

			// Must do this even if the loop panics
			defer func() {
				if neg {
					expField = -expField
				}
				exp += expField
			}()

			for '0' <= str[i] && str[i] <= '9' {
				expField = expField*10 + int16(str[i]-'0')
				i++
				consumed = i // checkpoint
			}
		}

		return

	default:
		return
	}
}
