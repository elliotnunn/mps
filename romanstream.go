// stdinReadMac has blocking semantics that match MPW

package main

import (
	"bufio"
	"os"
	"syscall"
)

var bufin = bufio.NewReader(os.Stdin)

func fcntl(fd, cmd, arg int) int {
	ret, _, _ := syscall.Syscall(syscall.SYS_FCNTL, uintptr(fd), uintptr(cmd), uintptr(arg))
	return int(ret)
}

// I assume that fcntl(2) is expensive, so cache the current O_NONBLOCK state
func stdinNonBlock(nonBlock bool) {
	if nonBlock != stdinNonBlockState {
		stdinNonBlockState = nonBlock
		fd := syscall.Stdin
		flags := fcntl(fd, syscall.F_GETFL, 0)
		flags &= ^syscall.O_NONBLOCK
		if nonBlock {
			flags |= syscall.O_NONBLOCK
		}
		fcntl(fd, syscall.F_SETFL, flags)
	}
}

var stdinNonBlockState = false

func stdinReadMac(rom []byte) int {
	var i int
	for i = 0; i < len(rom); i++ {
		// Block until we have received at least one char, or EOF
		if bufin.Buffered() < 4 {
			stdinNonBlock(i > 0)
		}

		// Return if EOR or simply no chars available currently
		r, _, err := bufin.ReadRune()
		if err != nil {
			break
		}

		switch {
		case r == '\r':
			i-- // delete CR
		case r == '\n':
			rom[i] = '\r' // convert LF to CR

		case r == 'A' || r == 'C' || r == 'E' || r == 'I' || r == 'N' || r == 'O' || r == 'U' || r == 'Y' ||
			r == 'a' || r == 'c' || r == 'e' || r == 'i' || r == 'n' || r == 'o' || r == 'u' || r == 'y' || r == '=':
			// Need to check whether any of these are followed by a diacritical mark
			// Unfortunately we block the whole read to determine this
			if bufin.Buffered() < 1 {
				stdinNonBlock(false)
			}

			if peek, _ := bufin.Peek(1); len(peek) == 0 || peek[0] != 0xcc {
				// No combining character
				rom[i] = byte(r)
			} else {
				// Get the combining character, which will only ever be 2 bytes long
				if bufin.Buffered() < 4 {
					stdinNonBlock(false)
				}

				r2, _, err := bufin.ReadRune()
				if err != nil {
					panic("stdin: not convertible from UTF-8 to Mac Roman")
				}

				switch {
				case r == 'A' && r2 == 0x300: // COMBINING GRAVE ACCENT...
					rom[i] = 0xcb
				case r == 'E' && r2 == 0x300:
					rom[i] = 0xe9
				case r == 'I' && r2 == 0x300:
					rom[i] = 0xed
				case r == 'O' && r2 == 0x300:
					rom[i] = 0xf1
				case r == 'U' && r2 == 0x300:
					rom[i] = 0xf4
				case r == 'a' && r2 == 0x300:
					rom[i] = 0x88
				case r == 'e' && r2 == 0x300:
					rom[i] = 0x8f
				case r == 'i' && r2 == 0x300:
					rom[i] = 0x93
				case r == 'o' && r2 == 0x300:
					rom[i] = 0x98
				case r == 'u' && r2 == 0x300:
					rom[i] = 0x9d
				case r == 'A' && r2 == 0x301: // COMBINING ACUTE ACCENT ...
					rom[i] = 0xe7
				case r == 'E' && r2 == 0x301:
					rom[i] = 0x83
				case r == 'I' && r2 == 0x301:
					rom[i] = 0xea
				case r == 'O' && r2 == 0x301:
					rom[i] = 0xee
				case r == 'U' && r2 == 0x301:
					rom[i] = 0xf2
				case r == 'a' && r2 == 0x301:
					rom[i] = 0x87
				case r == 'e' && r2 == 0x301:
					rom[i] = 0x8e
				case r == 'i' && r2 == 0x301:
					rom[i] = 0x92
				case r == 'o' && r2 == 0x301:
					rom[i] = 0x97
				case r == 'u' && r2 == 0x301:
					rom[i] = 0x9c
				case r == 'A' && r2 == 0x302: // COMBINING CIRCUMFLEX ACCENT...
					rom[i] = 0xe5
				case r == 'E' && r2 == 0x302:
					rom[i] = 0xe6
				case r == 'I' && r2 == 0x302:
					rom[i] = 0xeb
				case r == 'O' && r2 == 0x302:
					rom[i] = 0xef
				case r == 'U' && r2 == 0x302:
					rom[i] = 0xf3
				case r == 'a' && r2 == 0x302:
					rom[i] = 0x89
				case r == 'e' && r2 == 0x302:
					rom[i] = 0x90
				case r == 'i' && r2 == 0x302:
					rom[i] = 0x94
				case r == 'o' && r2 == 0x302:
					rom[i] = 0x99
				case r == 'u' && r2 == 0x302:
					rom[i] = 0x9e
				case r == 'A' && r2 == 0x303: // COMBINING TILDE...
					rom[i] = 0xcc
				case r == 'N' && r2 == 0x303:
					rom[i] = 0x84
				case r == 'O' && r2 == 0x303:
					rom[i] = 0xcd
				case r == 'a' && r2 == 0x303:
					rom[i] = 0x8b
				case r == 'n' && r2 == 0x303:
					rom[i] = 0x96
				case r == 'o' && r2 == 0x303:
					rom[i] = 0x9b
				case r == 'A' && r2 == 0x308: // COMBINING DIAERESIS...
					rom[i] = 0x80
				case r == 'E' && r2 == 0x308:
					rom[i] = 0xe8
				case r == 'I' && r2 == 0x308:
					rom[i] = 0xec
				case r == 'O' && r2 == 0x308:
					rom[i] = 0x85
				case r == 'U' && r2 == 0x308:
					rom[i] = 0x86
				case r == 'Y' && r2 == 0x308:
					rom[i] = 0xd9
				case r == 'a' && r2 == 0x308:
					rom[i] = 0x8a
				case r == 'e' && r2 == 0x308:
					rom[i] = 0x91
				case r == 'i' && r2 == 0x308:
					rom[i] = 0x95
				case r == 'o' && r2 == 0x308:
					rom[i] = 0x9a
				case r == 'u' && r2 == 0x308:
					rom[i] = 0x9f
				case r == 'y' && r2 == 0x308:
					rom[i] = 0xd8
				case r == 'A' && r2 == 0x30a: // COMBINING RING ABOVE...
					rom[i] = 0x81
				case r == 'a' && r2 == 0x30a:
					rom[i] = 0x8c
				case r == 'C' && r2 == 0x327: // COMBINING CEDILLA...
					rom[i] = 0x82
				case r == 'c' && r2 == 0x327:
					rom[i] = 0x8d
				case r == '=' && r2 == 0x338: // COMBINING LONG SOLIDUS OVERLAY...
					rom[i] = 0xad
				default:
					panic("stdin: not convertible from UTF-8 to Mac Roman")
				}

			}

		case r < 128:
			rom[i] = byte(r)

		case r == 0xc4: // LATIN CAPITAL LETTER A WITH DIAERESIS
			rom[i] = 0x80
		case r == 0xc5: // LATIN CAPITAL LETTER A WITH RING ABOVE
			rom[i] = 0x81
		case r == 0xc7: // LATIN CAPITAL LETTER C WITH CEDILLA
			rom[i] = 0x82
		case r == 0xc9: // LATIN CAPITAL LETTER E WITH ACUTE
			rom[i] = 0x83
		case r == 0xd1: // LATIN CAPITAL LETTER N WITH TILDE
			rom[i] = 0x84
		case r == 0xd6: // LATIN CAPITAL LETTER O WITH DIAERESIS
			rom[i] = 0x85
		case r == 0xdc: // LATIN CAPITAL LETTER U WITH DIAERESIS
			rom[i] = 0x86
		case r == 0xe1: // LATIN SMALL LETTER A WITH ACUTE
			rom[i] = 0x87
		case r == 0xe0: // LATIN SMALL LETTER A WITH GRAVE
			rom[i] = 0x88
		case r == 0xe2: // LATIN SMALL LETTER A WITH CIRCUMFLEX
			rom[i] = 0x89
		case r == 0xe4: // LATIN SMALL LETTER A WITH DIAERESIS
			rom[i] = 0x8a
		case r == 0xe3: // LATIN SMALL LETTER A WITH TILDE
			rom[i] = 0x8b
		case r == 0xe5: // LATIN SMALL LETTER A WITH RING ABOVE
			rom[i] = 0x8c
		case r == 0xe7: // LATIN SMALL LETTER C WITH CEDILLA
			rom[i] = 0x8d
		case r == 0xe9: // LATIN SMALL LETTER E WITH ACUTE
			rom[i] = 0x8e
		case r == 0xe8: // LATIN SMALL LETTER E WITH GRAVE
			rom[i] = 0x8f
		case r == 0xea: // LATIN SMALL LETTER E WITH CIRCUMFLEX
			rom[i] = 0x90
		case r == 0xeb: // LATIN SMALL LETTER E WITH DIAERESIS
			rom[i] = 0x91
		case r == 0xed: // LATIN SMALL LETTER I WITH ACUTE
			rom[i] = 0x92
		case r == 0xec: // LATIN SMALL LETTER I WITH GRAVE
			rom[i] = 0x93
		case r == 0xee: // LATIN SMALL LETTER I WITH CIRCUMFLEX
			rom[i] = 0x94
		case r == 0xef: // LATIN SMALL LETTER I WITH DIAERESIS
			rom[i] = 0x95
		case r == 0xf1: // LATIN SMALL LETTER N WITH TILDE
			rom[i] = 0x96
		case r == 0xf3: // LATIN SMALL LETTER O WITH ACUTE
			rom[i] = 0x97
		case r == 0xf2: // LATIN SMALL LETTER O WITH GRAVE
			rom[i] = 0x98
		case r == 0xf4: // LATIN SMALL LETTER O WITH CIRCUMFLEX
			rom[i] = 0x99
		case r == 0xf6: // LATIN SMALL LETTER O WITH DIAERESIS
			rom[i] = 0x9a
		case r == 0xf5: // LATIN SMALL LETTER O WITH TILDE
			rom[i] = 0x9b
		case r == 0xfa: // LATIN SMALL LETTER U WITH ACUTE
			rom[i] = 0x9c
		case r == 0xf9: // LATIN SMALL LETTER U WITH GRAVE
			rom[i] = 0x9d
		case r == 0xfb: // LATIN SMALL LETTER U WITH CIRCUMFLEX
			rom[i] = 0x9e
		case r == 0xfc: // LATIN SMALL LETTER U WITH DIAERESIS
			rom[i] = 0x9f
		case r == 0x2020: // DAGGER
			rom[i] = 0xa0
		case r == 0xb0: // DEGREE SIGN
			rom[i] = 0xa1
		case r == 0xa2: // CENT SIGN
			rom[i] = 0xa2
		case r == 0xa3: // POUND SIGN
			rom[i] = 0xa3
		case r == 0xa7: // SECTION SIGN
			rom[i] = 0xa4
		case r == 0x2022: // BULLET
			rom[i] = 0xa5
		case r == 0xb6: // PILCROW SIGN
			rom[i] = 0xa6
		case r == 0xdf: // LATIN SMALL LETTER SHARP S
			rom[i] = 0xa7
		case r == 0xae: // REGISTERED SIGN
			rom[i] = 0xa8
		case r == 0xa9: // COPYRIGHT SIGN
			rom[i] = 0xa9
		case r == 0x2122: // TRADE MARK SIGN
			rom[i] = 0xaa
		case r == 0xb4: // ACUTE ACCENT
			rom[i] = 0xab
		case r == 0xa8: // DIAERESIS
			rom[i] = 0xac
		case r == 0x2260: // NOT EQUAL TO
			rom[i] = 0xad
		case r == 0xc6: // LATIN CAPITAL LETTER AE
			rom[i] = 0xae
		case r == 0xd8: // LATIN CAPITAL LETTER O WITH STROKE
			rom[i] = 0xaf
		case r == 0x221e: // INFINITY
			rom[i] = 0xb0
		case r == 0xb1: // PLUS-MINUS SIGN
			rom[i] = 0xb1
		case r == 0x2264: // LESS-THAN OR EQUAL TO
			rom[i] = 0xb2
		case r == 0x2265: // GREATER-THAN OR EQUAL TO
			rom[i] = 0xb3
		case r == 0xa5: // YEN SIGN
			rom[i] = 0xb4
		case r == 0xb5: // MICRO SIGN
			rom[i] = 0xb5
		case r == 0x2202: // PARTIAL DIFFERENTIAL
			rom[i] = 0xb6
		case r == 0x2211: // N-ARY SUMMATION
			rom[i] = 0xb7
		case r == 0x220f: // N-ARY PRODUCT
			rom[i] = 0xb8
		case r == 0x3c0: // GREEK SMALL LETTER PI
			rom[i] = 0xb9
		case r == 0x222b: // INTEGRAL
			rom[i] = 0xba
		case r == 0xaa: // FEMININE ORDINAL INDICATOR
			rom[i] = 0xbb
		case r == 0xba: // MASCULINE ORDINAL INDICATOR
			rom[i] = 0xbc
		case r == 0x3a9: // GREEK CAPITAL LETTER OMEGA
			rom[i] = 0xbd
		case r == 0xe6: // LATIN SMALL LETTER AE
			rom[i] = 0xbe
		case r == 0xf8: // LATIN SMALL LETTER O WITH STROKE
			rom[i] = 0xbf
		case r == 0xbf: // INVERTED QUESTION MARK
			rom[i] = 0xc0
		case r == 0xa1: // INVERTED EXCLAMATION MARK
			rom[i] = 0xc1
		case r == 0xac: // NOT SIGN
			rom[i] = 0xc2
		case r == 0x221a: // SQUARE ROOT
			rom[i] = 0xc3
		case r == 0x192: // LATIN SMALL LETTER F WITH HOOK
			rom[i] = 0xc4
		case r == 0x2248: // ALMOST EQUAL TO
			rom[i] = 0xc5
		case r == 0x2206: // INCREMENT
			rom[i] = 0xc6
		case r == 0xab: // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
			rom[i] = 0xc7
		case r == 0xbb: // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
			rom[i] = 0xc8
		case r == 0x2026: // HORIZONTAL ELLIPSIS
			rom[i] = 0xc9
		case r == 0xa0: // NO-BREAK SPACE
			rom[i] = 0xca
		case r == 0xc0: // LATIN CAPITAL LETTER A WITH GRAVE
			rom[i] = 0xcb
		case r == 0xc3: // LATIN CAPITAL LETTER A WITH TILDE
			rom[i] = 0xcc
		case r == 0xd5: // LATIN CAPITAL LETTER O WITH TILDE
			rom[i] = 0xcd
		case r == 0x152: // LATIN CAPITAL LIGATURE OE
			rom[i] = 0xce
		case r == 0x153: // LATIN SMALL LIGATURE OE
			rom[i] = 0xcf
		case r == 0x2013: // EN DASH
			rom[i] = 0xd0
		case r == 0x2014: // EM DASH
			rom[i] = 0xd1
		case r == 0x201c: // LEFT DOUBLE QUOTATION MARK
			rom[i] = 0xd2
		case r == 0x201d: // RIGHT DOUBLE QUOTATION MARK
			rom[i] = 0xd3
		case r == 0x2018: // LEFT SINGLE QUOTATION MARK
			rom[i] = 0xd4
		case r == 0x2019: // RIGHT SINGLE QUOTATION MARK
			rom[i] = 0xd5
		case r == 0xf7: // DIVISION SIGN
			rom[i] = 0xd6
		case r == 0x25ca: // LOZENGE
			rom[i] = 0xd7
		case r == 0xff: // LATIN SMALL LETTER Y WITH DIAERESIS
			rom[i] = 0xd8
		case r == 0x178: // LATIN CAPITAL LETTER Y WITH DIAERESIS
			rom[i] = 0xd9
		case r == 0x2044: // FRACTION SLASH
			rom[i] = 0xda
		case r == 0xa4: // CURRENCY SIGN (pre-8.5)
			rom[i] = 0xdb
		case r == 0x20ac: // EURO SIGN
			rom[i] = 0xdb
		case r == 0x2039: // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
			rom[i] = 0xdc
		case r == 0x203a: // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
			rom[i] = 0xdd
		case r == 0xfb01: // LATIN SMALL LIGATURE FI
			rom[i] = 0xde
		case r == 0xfb02: // LATIN SMALL LIGATURE FL
			rom[i] = 0xdf
		case r == 0x2021: // DOUBLE DAGGER
			rom[i] = 0xe0
		case r == 0xb7: // MIDDLE DOT
			rom[i] = 0xe1
		case r == 0x201a: // SINGLE LOW-9 QUOTATION MARK
			rom[i] = 0xe2
		case r == 0x201e: // DOUBLE LOW-9 QUOTATION MARK
			rom[i] = 0xe3
		case r == 0x2030: // PER MILLE SIGN
			rom[i] = 0xe4
		case r == 0xc2: // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
			rom[i] = 0xe5
		case r == 0xca: // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
			rom[i] = 0xe6
		case r == 0xc1: // LATIN CAPITAL LETTER A WITH ACUTE
			rom[i] = 0xe7
		case r == 0xcb: // LATIN CAPITAL LETTER E WITH DIAERESIS
			rom[i] = 0xe8
		case r == 0xc8: // LATIN CAPITAL LETTER E WITH GRAVE
			rom[i] = 0xe9
		case r == 0xcd: // LATIN CAPITAL LETTER I WITH ACUTE
			rom[i] = 0xea
		case r == 0xce: // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
			rom[i] = 0xeb
		case r == 0xcf: // LATIN CAPITAL LETTER I WITH DIAERESIS
			rom[i] = 0xec
		case r == 0xcc: // LATIN CAPITAL LETTER I WITH GRAVE
			rom[i] = 0xed
		case r == 0xd3: // LATIN CAPITAL LETTER O WITH ACUTE
			rom[i] = 0xee
		case r == 0xd4: // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
			rom[i] = 0xef
		case r == 0xf8ff: // apple logo
			rom[i] = 0xf0
		case r == 0xd2: // LATIN CAPITAL LETTER O WITH GRAVE
			rom[i] = 0xf1
		case r == 0xda: // LATIN CAPITAL LETTER U WITH ACUTE
			rom[i] = 0xf2
		case r == 0xdb: // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
			rom[i] = 0xf3
		case r == 0xd9: // LATIN CAPITAL LETTER U WITH GRAVE
			rom[i] = 0xf4
		case r == 0x131: // LATIN SMALL LETTER DOTLESS I
			rom[i] = 0xf5
		case r == 0x2c6: // MODIFIER LETTER CIRCUMFLEX ACCENT
			rom[i] = 0xf6
		case r == 0x2dc: // SMALL TILDE
			rom[i] = 0xf7
		case r == 0xaf: // MACRON
			rom[i] = 0xf8
		case r == 0x2d8: // BREVE
			rom[i] = 0xf9
		case r == 0x2d9: // DOT ABOVE
			rom[i] = 0xfa
		case r == 0x2da: // RING ABOVE
			rom[i] = 0xfb
		case r == 0xb8: // CEDILLA
			rom[i] = 0xfc
		case r == 0x2dd: // DOUBLE ACUTE ACCENT
			rom[i] = 0xfd
		case r == 0x2db: // OGONEK
			rom[i] = 0xfe
		case r == 0x2c7: // CARON
			rom[i] = 0xff
		default:
			panic("stdin: not convertible from UTF-8 to Mac Roman")
		}
	}

	return i
}
