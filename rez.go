// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

// Much faster than a regexp-based version
func spaceRezComments(buf []byte) {
mainLoop:
	for len(buf) >= 2 { // don't care if fewer than 2 characters
		switch {
		case buf[0] == '"' || buf[0] == '\'': // string: leave alone
			quoteChar := buf[0]
			buf = buf[1:]

			for len(buf) != 0 {
				switch {
				case buf[0] == quoteChar:
					buf = buf[1:]
					continue mainLoop
				case len(buf) >= 2 && buf[0] == '\\' && buf[1] == quoteChar:
					buf = buf[2:]
				case len(buf) >= 2 && buf[0] == '\\' && buf[1] == '\\':
					buf = buf[2:]
				default:
					buf = buf[1:]
				}
			}

		case buf[0] == '/' && buf[1] == '/': // line comment: convert to spaces
			buf[0] = ' '
			buf[1] = ' '
			buf = buf[2:]

			for len(buf) != 0 {
				switch {
				case buf[0] == '\r' || buf[0] == '\n':
					buf = buf[1:]
					continue mainLoop
				default:
					buf[0] = makeWhitespace(buf[0])
					buf = buf[1:]
				}
			}

		case buf[0] == '/' && buf[1] == '*': // block comment: convert to spaces
			buf[0] = ' '
			buf[1] = ' '
			buf = buf[2:]

			for len(buf) != 0 {
				switch {
				case len(buf) >= 2 && buf[0] == '*' && buf[1] == '/':
					buf[0] = ' '
					buf[1] = ' '
					buf = buf[2:]
					continue mainLoop
				default:
					buf[0] = makeWhitespace(buf[0])
					buf = buf[1:]
				}
			}

		default:
			buf = buf[1:]
		}
	}
}

func makeWhitespace(b byte) byte {
	switch b {
	case '\n', '\r', '\t', '\v', '\f':
		return b
	default:
		return ' '
	}
}

// covers every character
var rezStringPattern = regexp.MustCompile(`(?:\\0x[0-9a-fA-F]{2}|\\.|.)`)

func rez_string_literal(string_with_quotes []byte) []byte {
	string_alone := string_with_quotes[1 : len(string_with_quotes)-1]
	splits := rezStringPattern.FindAllSubmatchIndex(string_alone, -1)

	var retval []byte

	for _, loc := range splits {
		start := loc[0]
		end := loc[1]

		char := byte('?')
		switch end - start {
		case 1:
			char = string_alone[start]
		case 2:
			switch string_alone[start+1] {
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
				char = string_alone[start+1]
			}
		case 5:
			wide, _ := strconv.ParseUint(string(string_alone[start+3:start+5]), 16, 8)
			char = byte(wide)
		}
		retval = append(retval, char)
	}

	return retval
}

// Get the number of bytes in the initial string literal -- bit of a hack
func rezStrLen(buf []byte) int {
	origLen := len(buf)

	quoteChar := buf[0]
	buf = buf[1:]

mainLoop:
	for {
		switch {
		case buf[0] == quoteChar:
			buf = buf[1:]
			break mainLoop
		case len(buf) >= 2 && buf[0] == '\\' && buf[1] == quoteChar:
			buf = buf[2:]
		case len(buf) >= 2 && buf[0] == '\\' && buf[1] == '\\':
			buf = buf[2:]
		default:
			buf = buf[1:]
		}
	}

	return origLen - len(buf)
}

func stripSpace(buf []byte) []byte {
	for len(buf) != 0 &&
		(buf[0] == ' ' ||
			buf[0] == '\n' ||
			buf[0] == '\r' ||
			buf[0] == '\t' ||
			buf[0] == '\v' ||
			buf[0] == '\f') {
		buf = buf[1:]
	}
	return buf
}

func rez(rez []byte) (result []byte, retErr error) {
	errorStr := ""
	origRez := rez

	defer func() {
		recover()

		if result == nil {
			lastWasCR := false
			line := 1
			for _, c := range origRez[:len(origRez)-len(rez)] {
				switch c {
				case '\r':
					line++
					lastWasCR = true
				case '\n':
					if !lastWasCR {
						line++
					}
					lastWasCR = false
				default:
					lastWasCR = false
				}
			}

			retErr = fmt.Errorf("line %d: %s", line, errorStr)
		}
	}()

	spaceRezComments(rez)

	type resource struct {
		type_    uint32
		id       uint16
		flags    uint8
		has_name bool
		name     []byte
		data     []byte
	}

	type_order := make([]uint32, 0)
	type_ids := make(map[uint32][]resource)

	// Tokens in somewhat strict order
	for {
		rez = stripSpace(rez)
		if len(rez) == 0 {
			break
		}

		var res resource
		var tokLen int

		errorStr = "expected \"data\""
		if !bytes.HasPrefix(rez, []byte("data")) {
			return
		}
		rez = rez[4:]

		rez = stripSpace(rez)

		errorStr = "expected single-quoted resource type"
		if rez[0] != '\'' {
			return
		}
		tokLen = rezStrLen(rez)
		res.type_ = binary.BigEndian.Uint32(rez_string_literal(rez[:tokLen]))
		rez = rez[tokLen:]

		rez = stripSpace(rez)

		errorStr = "expected open-paren"
		if rez[0] != '(' {
			return
		}
		rez = rez[1:]

		rez = stripSpace(rez)

		errorStr = "expected resource ID -32768 to 32767"
		tokLen = 0
		if rez[tokLen] == '-' {
			tokLen += 1
		}
		for '0' <= rez[tokLen] && rez[tokLen] <= '9' {
			tokLen += 1
		}
		id, err := strconv.ParseInt(string(rez[:tokLen]), 10, 16)
		if err != nil {
			return
		}
		res.id = uint16(id)
		rez = rez[tokLen:]

		rez = stripSpace(rez)

		errorStr = "expected comma or close-paren"
		if rez[0] != ',' {
			goto expectCloseBracket
		}
		rez = rez[1:]

		rez = stripSpace(rez)

		errorStr = "expected double-quoted name or flags"
		if rez[0] == '"' {
			tokLen := rezStrLen(rez)
			res.has_name = true
			res.name = rez_string_literal(rez[:tokLen])
			rez = rez[tokLen:]

			rez = stripSpace(rez)

			errorStr = "expected comma or close-paren"
			if rez[0] != ',' {
				goto expectCloseBracket
			}
			rez = rez[1:]

			rez = stripSpace(rez)
		}

		errorStr = "expected flags"
		if rez[0] == '$' {
			errorStr = "expected hex flags $00-$ff"
			flags, err := strconv.ParseInt(string(rez[1:3]), 16, 16)
			if err != nil || flags < 0 || flags > 0xff {
				return
			}
			res.flags = uint8(flags)
			rez = rez[3:]

			rez = stripSpace(rez)

			goto expectCloseBracket
		}

		for {
			ok := false
			for i, p := range []string{"preload", "protected", "locked", "purgeable", "sysheap"} {
				if bytes.HasPrefix(rez, []byte(p)) {
					res.flags |= 4 << i
					rez = rez[len(p):]
					ok = true
					break
				}
			}

			if !ok {
				errorStr = "expected preload/protected/locked/purgeable/sysheap"
				return
			}

			rez = stripSpace(rez)

			if rez[0] != ',' {
				goto expectCloseBracket
			}
			rez = rez[1:]

			rez = stripSpace(rez)
		}

	expectCloseBracket:
		errorStr = "expected close-paren"
		if rez[0] != ')' {
			return
		}
		rez = rez[1:]

		rez = stripSpace(rez)

		errorStr = "expected open-brace"
		if rez[0] != '{' {
			return
		}
		rez = rez[1:]

		rez = stripSpace(rez)

		for {
			errorStr = "expected $-double-quoted hex or close-brace"
			if rez[0] == '}' {
				rez = rez[1:]
				rez = stripSpace(rez)
				break
			}

			if rez[0] != '$' || rez[1] != '"' {
				return
			}
			rez = rez[2:]

			isFirstOfTwo := true
		hexCharLoop:
			for {
				hex := rez[0]
				rez = rez[1:]

				switch {
				case '0' <= hex && hex <= '9':
					hex = hex - '0'
				case 'a' <= hex && hex <= 'f':
					hex = hex - 'a' + 10
				case 'A' <= hex && hex <= 'F':
					hex = hex - 'A' + 10
				case hex == '"':
					break hexCharLoop
				case hex == ' ' || hex == '\t':
					continue hexCharLoop
				}

				if isFirstOfTwo {
					res.data = append(res.data, hex<<4)
				} else {
					res.data[len(res.data)-1] |= hex
				}
				isFirstOfTwo = !isFirstOfTwo
			}

			rez = stripSpace(rez)
		}

		errorStr = "expected semicolon"
		if rez[0] != ';' {
			return
		}
		rez = rez[1:]

		rez = stripSpace(rez)

		// Add the resource to our list
		if _, ok := type_ids[res.type_]; !ok {
			type_order = append(type_order, res.type_)
		}

		type_ids[res.type_] = append(type_ids[res.type_], res)
	}

	fork := make([]byte, 256) // append resource data as we go

	type_list := make([]byte, 2+8*len(type_order)) // alloc type list, append ref list
	name_list := make([]byte, 0)

	binary.BigEndian.PutUint16(type_list, uint16(len(type_order)-1))

	for type_n, type_ := range type_order {
		offset := 2 + 8*type_n
		binary.BigEndian.PutUint32(type_list[offset:], type_)
		binary.BigEndian.PutUint16(type_list[offset+4:], uint16(len(type_ids[type_])-1))
		binary.BigEndian.PutUint16(type_list[offset+6:], uint16(len(type_list)))

		for _, res := range type_ids[type_] {
			name_offset := uint16(0xffff)
			if res.has_name {
				name_offset = uint16(len(name_list))
				name_list = append(name_list, uint8(len(res.name)))
				name_list = append(name_list, res.name...)
			}

			idEntry := len(type_list)
			for i := 0; i < 12; i++ {
				type_list = append(type_list, 0)
			}
			binary.BigEndian.PutUint16(type_list[idEntry:], uint16(res.id))
			binary.BigEndian.PutUint16(type_list[idEntry+2:], name_offset)
			binary.BigEndian.PutUint32(type_list[idEntry+4:], uint32(res.flags)<<24|uint32(len(fork)-256))

			fork = append(fork, 0, 0, 0, 0)
			binary.BigEndian.PutUint32(fork[len(fork)-4:], uint32(len(res.data)))
			fork = append(fork, res.data...)
			for len(fork)%4 != 0 {
				fork = append(fork, 0)
			}
		}
	}

	boundary := len(fork) // between resource data and resource map

	// Create resource map
	for i := 0; i < 28; i++ {
		fork = append(fork, 0)
	}
	binary.BigEndian.PutUint16(fork[boundary+24:], 28)
	binary.BigEndian.PutUint16(fork[boundary+26:], uint16(28+len(type_list)))

	fork = append(fork, type_list...)
	fork = append(fork, name_list...)

	binary.BigEndian.PutUint32(fork, 256)
	binary.BigEndian.PutUint32(fork[4:], uint32(boundary))
	binary.BigEndian.PutUint32(fork[8:], uint32(boundary-256))
	binary.BigEndian.PutUint32(fork[12:], uint32(len(fork)-boundary))

	return fork, nil
}

func rezQuote(str string, dblQuotes bool) (esc string) {
	quot := byte('\'')
	if dblQuotes {
		quot = byte('"')
	}

	var bild strings.Builder
	bild.WriteByte(quot)

	for _, c := range []byte(str) { // cast because we want to iterate bytes
		switch {
		case c == 0x08:
			bild.WriteString(`\b`)
		case c == 0x09:
			bild.WriteString(`\t`)
		case c == 0x10:
			bild.WriteString(`\r`)
		case c == 0x11:
			bild.WriteString(`\v`)
		case c == 0x12:
			bild.WriteString(`\f`)
		case c == 0x13:
			bild.WriteString(`\n`)
		case c == 0x5c:
			bild.WriteString(`\\`)
		case c == 0x7f:
			bild.WriteString(`\?`)
		case c == quot:
			bild.Write([]byte{'\\', quot})
		case c < 32 || c >= 128:
			bild.WriteString(fmt.Sprintf(`\0x%02X`, c))
		default:
			bild.WriteByte(c)
		}
	}

	bild.WriteByte(quot)
	return bild.String()
}

// The right-hand comment must not be prematurely closed by */
// The Rez behaviour is to forbid slash after star, even if there
// are intervening characters <= ascii 0x1f, despite these being
// represented by dots. We share this behaviour with Rez.
// However, unlike Rez, we also turn non-ascii chars into dots.
// The output should be identical to macresources (my Python pkg).
func fmtDataAsRezLines(data []byte) string {
	const lineLen = 16
	var bild strings.Builder

	for i := 0; i < len(data); i += lineLen {
		thisLen := lineLen
		if i+thisLen > len(data) {
			thisLen = len(data) - i
		}

		lineStartOffset := bild.Len()

		bild.WriteString("\t$\"")
		for j := 0; j < thisLen; j++ {
			bild.WriteString(fmt.Sprintf("%02X", data[i+j]))
			if j%2 == 1 && j != thisLen-1 {
				bild.WriteByte(' ')
			}
		}
		bild.WriteByte('"')

		for bild.Len() < lineStartOffset+55 {
			bild.WriteByte(' ')
		}

		bild.WriteString("/* ")
		forbidSlash := false
		for j := 0; j < thisLen; j++ {
			c := data[i+j]
			switch {
			case c == '*':
				bild.WriteByte('*')
				forbidSlash = true
			case c == '/':
				if forbidSlash {
					bild.WriteByte('.')
				} else {
					bild.WriteByte('/')
				}
				forbidSlash = false
			case c < 32:
				bild.WriteByte('.')
				// do NOT clear forbidSlash
			case c >= 127:
				bild.WriteByte('.')
				forbidSlash = false
			default:
				bild.WriteByte(c)
				forbidSlash = false
			}
		}
		bild.WriteString(" */\n")
	}

	return bild.String()
}

func deRez(fork []byte) []byte {
	mapstart := binary.BigEndian.Uint32(fork[4:])
	maplen := binary.BigEndian.Uint32(fork[12:])

	var bild strings.Builder

	// Load the map into memory and use the Resource Manager to interpret it
	resMap := dumpMap(fork[mapstart:][:maplen])
	for _, res := range resMap.list {
		bild.WriteString("data ")
		type_ := string([]byte{byte(res.tType >> 24), byte(res.tType >> 16), byte(res.tType >> 8), byte(res.tType)})
		bild.WriteString(rezQuote(type_, false))
		bild.WriteString(" (")
		bild.WriteString(fmt.Sprintf("%d", int16(res.rID)))

		if res.hasName {
			bild.WriteString(", ")
			bild.WriteString(rezQuote(string(res.name), true))
		}

		if res.rAttr&0x83 != 0 {
			bild.WriteString(fmt.Sprintf(", $%02X", res.rAttr))
		} else {
			if res.rAttr&0x40 != 0 {
				bild.WriteString(", sysheap")
			}
			if res.rAttr&0x20 != 0 {
				bild.WriteString(", purgeable")
			}
			if res.rAttr&0x10 != 0 {
				bild.WriteString(", locked")
			}
			if res.rAttr&8 != 0 {
				bild.WriteString(", protected")
			}
			if res.rAttr&4 != 0 {
				bild.WriteString(", preload")
			}
		}

		dataStart := binary.BigEndian.Uint32(fork) // base of all data within fork
		dataStart += res.rLocn & 0xffffff          // this res within fork
		dataLen := binary.BigEndian.Uint32(fork[dataStart:])

		data := fork[dataStart+4:][:dataLen]

		bild.WriteString(") {\n")
		bild.WriteString(fmtDataAsRezLines(data))
		bild.WriteString("};\n\n")
	}

	return []byte(bild.String())
}
