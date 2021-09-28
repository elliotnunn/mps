package main

import (
	"encoding/binary"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
)

// Storage format
const (
	kFileExchange = iota // FINDER.DAT/aaa RESOURCE.FRK/aaa
	kRez                 // aaa.idump aaa.rdump
	kOSX                 // aaa/..namedfork/rsrc (UNIMPLEMENTED)
	kAppleDouble         // ._aaa (UNIMPLEMENTED)
)

// Panics if the file has conflicting storage formats
func whichFormat(path string) int {
	format := kFileExchange // should be read from environment variable
	var complain []string

	fe1 := filepath.Join(filepath.Dir(path), "FINDER.DAT", filepath.Base(path))
	fe2 := filepath.Join(filepath.Dir(path), "RESOURCE.FRK", filepath.Base(path))
	if existsAsFile(fe1) || existsAsFile(fe2) {
		format = kFileExchange
		complain = append(complain, "File Exchange")
	}

	rz1 := path + ".idump"
	rz2 := path + ".rdump"
	if existsAsFile(rz1) || existsAsFile(rz2) {
		format = kRez
		complain = append(complain, "Rez")
	}

	if darwinForksExist(path) {
		format = kOSX
		complain = append(complain, "native filesystem")
	}

	if len(complain) > 1 {
		complaint := strings.Join(complain, " & ")
		panic(fmt.Sprintf("Conflicting %s data for file: %s", complaint, path))
	}

	return format
}

func existsAsFile(path string) bool {
	stat, err := os.Stat(path)
	return err == nil && stat.Mode().IsRegular()
}

// Assume the existence of the file
func finderInfo(path string) [16]byte {
	finfo := [16]byte{'?', '?', '?', '?', '?', '?', '?', '?', 0}

	switch whichFormat(path) {
	case kFileExchange:
		path2 := filepath.Join(filepath.Dir(path), "FINDER.DAT", filepath.Base(path))
		if data, err := os.ReadFile(path2); err == nil {
			copy(finfo[:], data)
		}

	case kRez:
		path2 := path + ".idump"
		if data, err := os.ReadFile(path2); err == nil {
			copy(finfo[:], data)
		}

	case kOSX:
		bigfinfo, _ := darwinFInfo(path)
		copy(finfo[:8], bigfinfo[:8])
		if finfo[0] == 0 && finfo[1] == 0 && finfo[2] == 0 && finfo[3] == 0 {
			copy(finfo[:], "????")
		}
		if finfo[4] == 0 && finfo[5] == 0 && finfo[6] == 0 && finfo[7] == 0 {
			copy(finfo[4:], "????")
		}
	}

	return finfo
}

func dataFork(path string) []byte {
	data, _ := os.ReadFile(path)

	// Textfile conversion unique to Elliot's idump/rdump system
	if whichFormat(path) == kRez {
		finfo := finderInfo(path)
		if string(finfo[:4]) == "TEXT" || string(finfo[:4]) == "ttro" {
			// Convert encoding if possible
			if data2, ok := unicodeToMac(string(data)); ok {
				data = []byte(data2)
			}
		}
	}

	return data
}

func writeDataFork(path string, fork []byte) {
	os.WriteFile(path, fork, 0o666) // ignore error
}

func resourceFork(path string) []byte {
	var data []byte

	switch whichFormat(path) {
	case kFileExchange:
		path2 := filepath.Join(filepath.Dir(path), "RESOURCE.FRK", filepath.Base(path))
		data, _ = os.ReadFile(path2) // accept a nonexistent file

	case kRez:
		path2 := path + ".rdump"
		var err error // variable shadowing???
		data, err = os.ReadFile(path2)

		// accept a nonexistent file as an empty data fork
		if err != nil {
			return nil
		}

		data = rez(data) // TODO: this panics, which is messy

	case kOSX:
		data, _ = os.ReadFile(path + "/..namedfork/rsrc")
		return data
	}

	return data
}

func writeResourceFork(path string, fork []byte) {
	os.Create(path) // ignore error

	switch whichFormat(path) {
	case kFileExchange:
		path2 := filepath.Join(filepath.Dir(path), "RESOURCE.FRK", filepath.Base(path))
		if len(fork) > 256 {
			os.Mkdir(filepath.Dir(path2), 0o777) // ignore error
			os.WriteFile(path2, fork, 0o666)     // ignore error
		} else {
			os.Remove(path2) // ignore error
		}

	case kRez:
		path2 := path + ".rdump"
		if len(fork) > 256 {
			os.WriteFile(path2, deRez(fork), 0o666) // ignore error
		} else {
			os.Remove(path2) // ignore error
		}

	case kOSX:
		os.WriteFile(path+"/..namedfork/rsrc", fork, 0o666) // ignore error
	}
}

func deleteForks(path string) {
	os.Remove(path)
	os.Remove(path + ".idump")
	os.Remove(path + ".rdump")
	os.Remove(filepath.Join(filepath.Dir(path), "RESOURCE.FRK", filepath.Base(path)))
	os.Remove(filepath.Join(filepath.Dir(path), "FINDER.DAT", filepath.Base(path)))
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
	// This hack saves code
	resMap := uint32(len(mem))
	mem = append(mem, fork[mapstart:][:maplen]...)
	defer func() { mem = mem[:resMap] }()

	for _, entriesOfType := range resMapEntries(resMap) {
		typeEntry := entriesOfType[0]
		for _, idEntry := range entriesOfType[1:] {
			bild.WriteString("data ")
			bild.WriteString(rezQuote(string(mem[typeEntry:][:4]), false))
			bild.WriteString(" (")
			bild.WriteString(fmt.Sprintf("%d", int16(readw(idEntry))))

			hasName, name := getResName(resMap, idEntry)
			if hasName {
				bild.WriteString(", ")
				bild.WriteString(rezQuote(string(name), true))
			}

			flags := readb(idEntry + 4)
			if flags&0x83 != 0 {
				bild.WriteString(fmt.Sprintf(", $%02X", flags))
			} else {
				if flags&0x40 != 0 {
					bild.WriteString(", sysheap")
				}
				if flags&0x20 != 0 {
					bild.WriteString(", purgeable")
				}
				if flags&0x10 != 0 {
					bild.WriteString(", locked")
				}
				if flags&8 != 0 {
					bild.WriteString(", protected")
				}
				if flags&4 != 0 {
					bild.WriteString(", preload")
				}
			}

			dataStart := binary.BigEndian.Uint32(fork) // base of all data within fork
			dataStart += readl(idEntry+4) & 0xffffff   // this res within fork
			dataLen := binary.BigEndian.Uint32(fork[dataStart:])

			data := fork[dataStart+4:][:dataLen]

			bild.WriteString(") {\n")
			bild.WriteString(fmtDataAsRezLines(data))
			bild.WriteString("};\n\n")
		}
	}

	return []byte(bild.String())
}
