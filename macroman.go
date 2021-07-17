package main

import (
    "bytes"
)

var macToUnicodeTable = []rune({
    0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
    0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x000d, 0x000e, 0x000f,
    0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, 0x0017,
    0x0018, 0x0019, 0x001a, 0x001b, 0x001c, 0x001d, 0x001e, 0x001f,
    0x0020, 0x0021, 0x0022, 0x0023, 0x0024, 0x0025, 0x0026, 0x0027,
    0x0028, 0x0029, 0x002a, 0x002b, 0x002c, 0x002d, 0x002e, 0x002f,
    0x0030, 0x0031, 0x0032, 0x0033, 0x0034, 0x0035, 0x0036, 0x0037,
    0x0038, 0x0039, 0x003a, 0x003b, 0x003c, 0x003d, 0x003e, 0x003f,
    0x0040, 0x0041, 0x0042, 0x0043, 0x0044, 0x0045, 0x0046, 0x0047,
    0x0048, 0x0049, 0x004a, 0x004b, 0x004c, 0x004d, 0x004e, 0x004f,
    0x0050, 0x0051, 0x0052, 0x0053, 0x0054, 0x0055, 0x0056, 0x0057,
    0x0058, 0x0059, 0x005a, 0x005b, 0x005c, 0x005d, 0x005e, 0x005f,
    0x0060, 0x0061, 0x0062, 0x0063, 0x0064, 0x0065, 0x0066, 0x0067,
    0x0068, 0x0069, 0x006a, 0x006b, 0x006c, 0x006d, 0x006e, 0x006f,
    0x0070, 0x0071, 0x0072, 0x0073, 0x0074, 0x0075, 0x0076, 0x0077,
    0x0078, 0x0079, 0x007a, 0x007b, 0x007c, 0x007d, 0x007e, 0x007f,
    0x00c4, 0x00c5, 0x00c7, 0x00c9, 0x00d1, 0x00d6, 0x00dc, 0x00e1,
    0x00e0, 0x00e2, 0x00e4, 0x00e3, 0x00e5, 0x00e7, 0x00e9, 0x00e8,
    0x00ea, 0x00eb, 0x00ed, 0x00ec, 0x00ee, 0x00ef, 0x00f1, 0x00f3,
    0x00f2, 0x00f4, 0x00f6, 0x00f5, 0x00fa, 0x00f9, 0x00fb, 0x00fc,
    0x2020, 0x00b0, 0x00a2, 0x00a3, 0x00a7, 0x2022, 0x00b6, 0x00df,
    0x00ae, 0x00a9, 0x2122, 0x00b4, 0x00a8, 0x2260, 0x00c6, 0x00d8,
    0x221e, 0x00b1, 0x2264, 0x2265, 0x00a5, 0x00b5, 0x2202, 0x2211,
    0x220f, 0x03c0, 0x222b, 0x00aa, 0x00ba, 0x03a9, 0x00e6, 0x00f8,
    0x00bf, 0x00a1, 0x00ac, 0x221a, 0x0192, 0x2248, 0x2206, 0x00ab,
    0x00bb, 0x2026, 0x00a0, 0x00c0, 0x00c3, 0x00d5, 0x0152, 0x0153,
    0x2013, 0x2014, 0x201c, 0x201d, 0x2018, 0x2019, 0x00f7, 0x25ca,
    0x00ff, 0x0178, 0x2044, 0x20ac, 0x2039, 0x203a, 0xfb01, 0xfb02,
    0x2021, 0x00b7, 0x201a, 0x201e, 0x2030, 0x00c2, 0x00ca, 0x00c1,
    0x00cb, 0x00c8, 0x00cd, 0x00ce, 0x00cf, 0x00cc, 0x00d3, 0x00d4,
    0xf8ff, 0x00d2, 0x00da, 0x00db, 0x00d9, 0x0131, 0x02c6, 0x02dc,
    0x00af, 0x02d8, 0x02d9, 0x02da, 0x00b8, 0x02dd, 0x02db, 0x02c7,
})

func macToUnicode(mac []byte) string {
    var buf bytes.Buffer
    for macbyte := range mac {
        buf.WriteRune(macToUnicodeTable[macbyte])
    }
    return buf.String()
}

func unicodeToMac(unicode string) (mac []byte, err error) {
    var accum []byte
    // should do some normalisation here
    for codepoint := range unicode {
        macbyte byte
        switch {
        case codepount < 0x80:
            macbyte = byte(codepoint)
        case codepoint == 0xc4: // LATIN CAPITAL LETTER A WITH DIAERESIS
            macbyte = 0x80
        case codepoint == 0xc5: // LATIN CAPITAL LETTER A WITH RING ABOVE
            macbyte = 0x81
        case codepoint == 0xc7: // LATIN CAPITAL LETTER C WITH CEDILLA
            macbyte = 0x82
        case codepoint == 0xc9: // LATIN CAPITAL LETTER E WITH ACUTE
            macbyte = 0x83
        case codepoint == 0xd1: // LATIN CAPITAL LETTER N WITH TILDE
            macbyte = 0x84
        case codepoint == 0xd6: // LATIN CAPITAL LETTER O WITH DIAERESIS
            macbyte = 0x85
        case codepoint == 0xdc: // LATIN CAPITAL LETTER U WITH DIAERESIS
            macbyte = 0x86
        case codepoint == 0xe1: // LATIN SMALL LETTER A WITH ACUTE
            macbyte = 0x87
        case codepoint == 0xe0: // LATIN SMALL LETTER A WITH GRAVE
            macbyte = 0x88
        case codepoint == 0xe2: // LATIN SMALL LETTER A WITH CIRCUMFLEX
            macbyte = 0x89
        case codepoint == 0xe4: // LATIN SMALL LETTER A WITH DIAERESIS
            macbyte = 0x8a
        case codepoint == 0xe3: // LATIN SMALL LETTER A WITH TILDE
            macbyte = 0x8b
        case codepoint == 0xe5: // LATIN SMALL LETTER A WITH RING ABOVE
            macbyte = 0x8c
        case codepoint == 0xe7: // LATIN SMALL LETTER C WITH CEDILLA
            macbyte = 0x8d
        case codepoint == 0xe9: // LATIN SMALL LETTER E WITH ACUTE
            macbyte = 0x8e
        case codepoint == 0xe8: // LATIN SMALL LETTER E WITH GRAVE
            macbyte = 0x8f
        case codepoint == 0xea: // LATIN SMALL LETTER E WITH CIRCUMFLEX
            macbyte = 0x90
        case codepoint == 0xeb: // LATIN SMALL LETTER E WITH DIAERESIS
            macbyte = 0x91
        case codepoint == 0xed: // LATIN SMALL LETTER I WITH ACUTE
            macbyte = 0x92
        case codepoint == 0xec: // LATIN SMALL LETTER I WITH GRAVE
            macbyte = 0x93
        case codepoint == 0xee: // LATIN SMALL LETTER I WITH CIRCUMFLEX
            macbyte = 0x94
        case codepoint == 0xef: // LATIN SMALL LETTER I WITH DIAERESIS
            macbyte = 0x95
        case codepoint == 0xf1: // LATIN SMALL LETTER N WITH TILDE
            macbyte = 0x96
        case codepoint == 0xf3: // LATIN SMALL LETTER O WITH ACUTE
            macbyte = 0x97
        case codepoint == 0xf2: // LATIN SMALL LETTER O WITH GRAVE
            macbyte = 0x98
        case codepoint == 0xf4: // LATIN SMALL LETTER O WITH CIRCUMFLEX
            macbyte = 0x99
        case codepoint == 0xf6: // LATIN SMALL LETTER O WITH DIAERESIS
            macbyte = 0x9a
        case codepoint == 0xf5: // LATIN SMALL LETTER O WITH TILDE
            macbyte = 0x9b
        case codepoint == 0xfa: // LATIN SMALL LETTER U WITH ACUTE
            macbyte = 0x9c
        case codepoint == 0xf9: // LATIN SMALL LETTER U WITH GRAVE
            macbyte = 0x9d
        case codepoint == 0xfb: // LATIN SMALL LETTER U WITH CIRCUMFLEX
            macbyte = 0x9e
        case codepoint == 0xfc: // LATIN SMALL LETTER U WITH DIAERESIS
            macbyte = 0x9f
        case codepoint == 0x2020: // DAGGER
            macbyte = 0xa0
        case codepoint == 0xb0: // DEGREE SIGN
            macbyte = 0xa1
        case codepoint == 0xa2: // CENT SIGN
            macbyte = 0xa2
        case codepoint == 0xa3: // POUND SIGN
            macbyte = 0xa3
        case codepoint == 0xa7: // SECTION SIGN
            macbyte = 0xa4
        case codepoint == 0x2022: // BULLET
            macbyte = 0xa5
        case codepoint == 0xb6: // PILCROW SIGN
            macbyte = 0xa6
        case codepoint == 0xdf: // LATIN SMALL LETTER SHARP S
            macbyte = 0xa7
        case codepoint == 0xae: // REGISTERED SIGN
            macbyte = 0xa8
        case codepoint == 0xa9: // COPYRIGHT SIGN
            macbyte = 0xa9
        case codepoint == 0x2122: // TRADE MARK SIGN
            macbyte = 0xaa
        case codepoint == 0xb4: // ACUTE ACCENT
            macbyte = 0xab
        case codepoint == 0xa8: // DIAERESIS
            macbyte = 0xac
        case codepoint == 0x2260: // NOT EQUAL TO
            macbyte = 0xad
        case codepoint == 0xc6: // LATIN CAPITAL LETTER AE
            macbyte = 0xae
        case codepoint == 0xd8: // LATIN CAPITAL LETTER O WITH STROKE
            macbyte = 0xaf
        case codepoint == 0x221e: // INFINITY
            macbyte = 0xb0
        case codepoint == 0xb1: // PLUS-MINUS SIGN
            macbyte = 0xb1
        case codepoint == 0x2264: // LESS-THAN OR EQUAL TO
            macbyte = 0xb2
        case codepoint == 0x2265: // GREATER-THAN OR EQUAL TO
            macbyte = 0xb3
        case codepoint == 0xa5: // YEN SIGN
            macbyte = 0xb4
        case codepoint == 0xb5: // MICRO SIGN
            macbyte = 0xb5
        case codepoint == 0x2202: // PARTIAL DIFFERENTIAL
            macbyte = 0xb6
        case codepoint == 0x2211: // N-ARY SUMMATION
            macbyte = 0xb7
        case codepoint == 0x220f: // N-ARY PRODUCT
            macbyte = 0xb8
        case codepoint == 0x3c0: // GREEK SMALL LETTER PI
            macbyte = 0xb9
        case codepoint == 0x222b: // INTEGRAL
            macbyte = 0xba
        case codepoint == 0xaa: // FEMININE ORDINAL INDICATOR
            macbyte = 0xbb
        case codepoint == 0xba: // MASCULINE ORDINAL INDICATOR
            macbyte = 0xbc
        case codepoint == 0x3a9: // GREEK CAPITAL LETTER OMEGA
            macbyte = 0xbd
        case codepoint == 0xe6: // LATIN SMALL LETTER AE
            macbyte = 0xbe
        case codepoint == 0xf8: // LATIN SMALL LETTER O WITH STROKE
            macbyte = 0xbf
        case codepoint == 0xbf: // INVERTED QUESTION MARK
            macbyte = 0xc0
        case codepoint == 0xa1: // INVERTED EXCLAMATION MARK
            macbyte = 0xc1
        case codepoint == 0xac: // NOT SIGN
            macbyte = 0xc2
        case codepoint == 0x221a: // SQUARE ROOT
            macbyte = 0xc3
        case codepoint == 0x192: // LATIN SMALL LETTER F WITH HOOK
            macbyte = 0xc4
        case codepoint == 0x2248: // ALMOST EQUAL TO
            macbyte = 0xc5
        case codepoint == 0x2206: // INCREMENT
            macbyte = 0xc6
        case codepoint == 0xab: // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
            macbyte = 0xc7
        case codepoint == 0xbb: // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
            macbyte = 0xc8
        case codepoint == 0x2026: // HORIZONTAL ELLIPSIS
            macbyte = 0xc9
        case codepoint == 0xa0: // NO-BREAK SPACE
            macbyte = 0xca
        case codepoint == 0xc0: // LATIN CAPITAL LETTER A WITH GRAVE
            macbyte = 0xcb
        case codepoint == 0xc3: // LATIN CAPITAL LETTER A WITH TILDE
            macbyte = 0xcc
        case codepoint == 0xd5: // LATIN CAPITAL LETTER O WITH TILDE
            macbyte = 0xcd
        case codepoint == 0x152: // LATIN CAPITAL LIGATURE OE
            macbyte = 0xce
        case codepoint == 0x153: // LATIN SMALL LIGATURE OE
            macbyte = 0xcf
        case codepoint == 0x2013: // EN DASH
            macbyte = 0xd0
        case codepoint == 0x2014: // EM DASH
            macbyte = 0xd1
        case codepoint == 0x201c: // LEFT DOUBLE QUOTATION MARK
            macbyte = 0xd2
        case codepoint == 0x201d: // RIGHT DOUBLE QUOTATION MARK
            macbyte = 0xd3
        case codepoint == 0x2018: // LEFT SINGLE QUOTATION MARK
            macbyte = 0xd4
        case codepoint == 0x2019: // RIGHT SINGLE QUOTATION MARK
            macbyte = 0xd5
        case codepoint == 0xf7: // DIVISION SIGN
            macbyte = 0xd6
        case codepoint == 0x25ca: // LOZENGE
            macbyte = 0xd7
        case codepoint == 0xff: // LATIN SMALL LETTER Y WITH DIAERESIS
            macbyte = 0xd8
        case codepoint == 0x178: // LATIN CAPITAL LETTER Y WITH DIAERESIS
            macbyte = 0xd9
        case codepoint == 0x2044: // FRACTION SLASH
            macbyte = 0xda
        case codepoint == 0x20ac: // EURO SIGN
            macbyte = 0xdb
        case codepoint == 0x2039: // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
            macbyte = 0xdc
        case codepoint == 0x203a: // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
            macbyte = 0xdd
        case codepoint == 0xfb01: // LATIN SMALL LIGATURE FI
            macbyte = 0xde
        case codepoint == 0xfb02: // LATIN SMALL LIGATURE FL
            macbyte = 0xdf
        case codepoint == 0x2021: // DOUBLE DAGGER
            macbyte = 0xe0
        case codepoint == 0xb7: // MIDDLE DOT
            macbyte = 0xe1
        case codepoint == 0x201a: // SINGLE LOW-9 QUOTATION MARK
            macbyte = 0xe2
        case codepoint == 0x201e: // DOUBLE LOW-9 QUOTATION MARK
            macbyte = 0xe3
        case codepoint == 0x2030: // PER MILLE SIGN
            macbyte = 0xe4
        case codepoint == 0xc2: // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
            macbyte = 0xe5
        case codepoint == 0xca: // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
            macbyte = 0xe6
        case codepoint == 0xc1: // LATIN CAPITAL LETTER A WITH ACUTE
            macbyte = 0xe7
        case codepoint == 0xcb: // LATIN CAPITAL LETTER E WITH DIAERESIS
            macbyte = 0xe8
        case codepoint == 0xc8: // LATIN CAPITAL LETTER E WITH GRAVE
            macbyte = 0xe9
        case codepoint == 0xcd: // LATIN CAPITAL LETTER I WITH ACUTE
            macbyte = 0xea
        case codepoint == 0xce: // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
            macbyte = 0xeb
        case codepoint == 0xcf: // LATIN CAPITAL LETTER I WITH DIAERESIS
            macbyte = 0xec
        case codepoint == 0xcc: // LATIN CAPITAL LETTER I WITH GRAVE
            macbyte = 0xed
        case codepoint == 0xd3: // LATIN CAPITAL LETTER O WITH ACUTE
            macbyte = 0xee
        case codepoint == 0xd4: // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
            macbyte = 0xef
        case codepoint == 0xf8ff: // apple logo
            macbyte = 0xf0
        case codepoint == 0xd2: // LATIN CAPITAL LETTER O WITH GRAVE
            macbyte = 0xf1
        case codepoint == 0xda: // LATIN CAPITAL LETTER U WITH ACUTE
            macbyte = 0xf2
        case codepoint == 0xdb: // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
            macbyte = 0xf3
        case codepoint == 0xd9: // LATIN CAPITAL LETTER U WITH GRAVE
            macbyte = 0xf4
        case codepoint == 0x131: // LATIN SMALL LETTER DOTLESS I
            macbyte = 0xf5
        case codepoint == 0x2c6: // MODIFIER LETTER CIRCUMFLEX ACCENT
            macbyte = 0xf6
        case codepoint == 0x2dc: // SMALL TILDE
            macbyte = 0xf7
        case codepoint == 0xaf: // MACRON
            macbyte = 0xf8
        case codepoint == 0x2d8: // BREVE
            macbyte = 0xf9
        case codepoint == 0x2d9: // DOT ABOVE
            macbyte = 0xfa
        case codepoint == 0x2da: // RING ABOVE
            macbyte = 0xfb
        case codepoint == 0xb8: // CEDILLA
            macbyte = 0xfc
        case codepoint == 0x2dd: // DOUBLE ACUTE ACCENT
            macbyte = 0xfd
        case codepoint == 0x2db: // OGONEK
            macbyte = 0xfe
        case codepoint == 0x2c7: // CARON
            macbyte = 0xff
        default:
            err = error.New("failed conversion to mac roman")
            return
        }
        mac = append(mac, macbyte)
    }
}
