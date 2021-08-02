package main

import (
	"encoding/binary"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
)

func finderInfo(path string) [16]byte {
	finfo := [16]byte{'?', '?', '?', '?', '?', '?', '?', '?', 0}

	fileExchangeScheme := filepath.Join(filepath.Dir(path), "FINDER.DAT", filepath.Base(path))
	rezScheme := path + ".idump"

	// Try various resource fork schemes, fall back on empty fork
	if data, err := gFS.ReadFile(fileExchangeScheme); err == nil {
		copy(finfo[:], data)
	}

	if data, err := gFS.ReadFile(rezScheme); err == nil {
		copy(finfo[:], data)
	}

	return finfo
}

var rezStripPattern = regexp.MustCompile(`(?://[^\n]*|/\*.*?\*/|("(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'))`)

func rez_strip_comments(in []byte) []byte {
	return rezStripPattern.ReplaceAll(in, []byte(`$1 `)) // keep quotes, append a space to be safe
}

func rez_string_literal(string_with_quotes []byte) []byte {
	pattern := regexp.MustCompile(`(?:\\0x[0-9a-fA-F]{2}|\\.|.)`) // covers every character
	string_alone := string_with_quotes[1 : len(string_with_quotes)-1]
	splits := pattern.FindAllSubmatchIndex(string_alone, -1)

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

var rezPattern = regexp.MustCompile(
	`data\s*('(?:[^'\\]|\\.){4}')\s*` +
		`\(\s*` +
		`(-?\d+)\s*` +
		`(?:,\s*("(?:[^"\\]|\\.)*")\s*)?` +
		`((?:,\s*(?:\$[0-9a-fA-F]|sysheap|purgeable|locked|protected|preload)\s*)*)` +
		`\)\s*` +
		`\{\s*` +
		`((?:\$"[0-9A-Fa-f\s*]*"\s*)*)\s*` +
		`\}\s*;\s*|.`)

func rez(rez []byte) []byte {
	rez = rez_strip_comments(rez)

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

	splits := rezPattern.FindAllSubmatchIndex(rez, -1)
	for _, loc := range splits {
		if loc[1]-loc[0] == 1 {
			panic("bad rez")
		}

		for i := range loc {
			if loc[i] == -1 {
				loc[i] = 0
			}
		}

		type_str := rez[loc[2]:loc[3]]
		id_str := rez[loc[4]:loc[5]]
		name_str := rez[loc[6]:loc[7]]
		flags_str := rez[loc[8]:loc[9]]
		data_str := rez[loc[10]:loc[11]]

		var res resource

		res.type_ = binary.BigEndian.Uint32(rez_string_literal(type_str))
		id, err := strconv.ParseInt(string(id_str), 10, 16)
		if err != nil { // might fail with out-of-range number
			panic("out-of-range ID in res file")
		}
		res.id = uint16(id)

		if len(name_str) > 0 {
			res.has_name = true
			res.name = rez_string_literal(name_str)
		}

		for _, arg := range strings.Split(string(flags_str), ",") {
			arg = strings.TrimSpace(arg)
			if len(arg) == 0 {
				continue
			}

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
				theseflags, _ := strconv.ParseInt(arg[1:], 16, 8)
				res.flags |= uint8(theseflags)
			}
		}

		isFirstOfTwo := true
		for _, hex := range data_str {
			if '0' <= hex && hex <= '9' {
				hex = hex - '0'
			} else if 'a' <= hex && hex <= 'f' {
				hex = hex - 'a' + 10
			} else if 'A' <= hex && hex <= 'F' {
				hex = hex - 'A' + 10
			} else {
				continue
			}

			if isFirstOfTwo {
				res.data = append(res.data, hex<<4)
			} else {
				res.data[len(res.data)-1] |= hex
			}
			isFirstOfTwo = !isFirstOfTwo
		}

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

	return fork
}
