package main

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"strings"
	"time"
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
	format := kRez // should be read from environment variable
	var complain []string

	fe1 := platPathJoin(platPathDir(path), "FINDER.DAT", platPathBase(path))
	fe2 := platPathJoin(platPathDir(path), "RESOURCE.FRK", platPathBase(path))
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

// Fast access to datafork size and finfo, applying the text file hack.
// Compute them together so we only read potential text files once.
// fastButInaccurate will overestimate the size of text files over 32MB to avoid
// reading them. This is acceptable for speed when listing directories, but not
// e.g. when duplicating the file.
func dataForkSizeFinderInfo(path string, fastButInaccurate bool) (size uint32, finfo [16]byte) {
	finfo = finderInfoWithoutTextHack(path)
	ftype := string(finfo[:4])

	stat, err := os.Stat(path)
	if err == nil && stat.Size() <= 0x7fffffff {
		size = uint32(stat.Size())
	}

	if size == 0 {
		return
	}

	if size > 32*1024*1024 && fastButInaccurate {
		return
	}

	if ftype != "????" && ftype != "TEXT" {
		return
	}

	f, err := os.Open(path)
	if err != nil {
		return
	}
	defer f.Close()

	reader := bufio.NewReaderSize(f, 4*1024*1024)
	if textSize, ok := isTextFile(reader); ok {
		size = uint32(textSize)

		if ftype == "????" {
			copy(finfo[:], "TEXTMPS ")
		}
	}

	return
}

func finderInfoWithoutTextHack(path string) [16]byte {
	finfo := [16]byte{'?', '?', '?', '?', '?', '?', '?', '?', 0}

	switch whichFormat(path) {
	case kFileExchange:
		path2 := platPathJoin(platPathDir(path), "FINDER.DAT", platPathBase(path))
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

func writeFinderInfo(path string, finfo [16]byte) {
	// We do not care for the last few bytes
	for i := 8; i < 16; i++ {
		finfo[i] = 0
	}

	switch whichFormat(path) {
	case kFileExchange:
		path2 := platPathJoin(platPathDir(path), "FINDER.DAT", platPathBase(path))
		if string(finfo[:8]) == "????????" {
			os.Remove(path2)
			os.Remove(platPathDir(path2))
		} else {
			os.Mkdir(platPathDir(path2), 0o755)
			os.WriteFile(path2, finfo[:], 0o644)
		}

	case kRez:
		path2 := path + ".idump"
		if string(finfo[:8]) == "????????" {
			os.Remove(path2)
		} else {
			os.WriteFile(path2, finfo[:8], 0o644)
		}

	case kOSX:
		var bigfinfo [32]byte
		copy(bigfinfo[:8], finfo[:8])
		setDarwinFInfo(path, bigfinfo)
	}
}

func dataFork(path string) (data []byte) {
	data, _ = os.ReadFile(path)

	// Convert the data fork if persuaded it is a text file
	finfo := finderInfoWithoutTextHack(path)
	ftype := string(finfo[:4])

	if ftype != "????" && ftype != "TEXT" {
		return
	}

	reader := bytes.NewReader(data)
	if _, ok := isTextFile(reader); !ok {
		return
	}

	// Use "unsafe" for zero-copy conversion?
	return []byte(unicodeToMacOrPanic(string(data)))
}

func writeDataFork(path string, fork []byte) {
	os.WriteFile(path, fork, 0o666) // ignore error
	writeMtimeFile(path, readl(0x20c))
}

func resourceFork(path string) []byte {
	var data []byte

	switch whichFormat(path) {
	case kFileExchange:
		path2 := platPathJoin(platPathDir(path), "RESOURCE.FRK", platPathBase(path))
		data, _ = os.ReadFile(path2) // accept a nonexistent file

	case kRez:
		path2 := path + ".rdump"
		var err error // variable shadowing???
		data, err = os.ReadFile(path2)

		// accept a nonexistent file as an empty data fork
		if err != nil {
			return nil
		}

		data, err = rez(data)
		if err != nil {
			fmt.Fprintf(os.Stderr, "#### %s\n#### %v\n", path2, err)
			os.Exit(1)
		}

	case kOSX:
		data, _ = os.ReadFile(path + "/..namedfork/rsrc")
		return data
	}

	return data
}

func writeResourceFork(path string, fork []byte) {
	// Ensure that the main file exists
	f, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0o644)
	if err == nil {
		f.Close()
	}

	switch whichFormat(path) {
	case kFileExchange:
		path2 := platPathJoin(platPathDir(path), "RESOURCE.FRK", platPathBase(path))
		if len(fork) > 256 {
			os.Mkdir(platPathDir(path2), 0o777) // ignore error
			os.WriteFile(path2, fork, 0o666)    // ignore error
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

	writeMtimeFile(path, readl(0x20c))
}

var frozenTime = time.Now()

func epochToMac(host time.Time) uint32 {
	if host.Unix() == 0 {
		return 0
	}

	// Lowmem Time is unchanging and corresponds with frozenTime
	mac := int64(readl(0x20c)) + int64(host.Sub(frozenTime))/1e9

	// Clip to earliest and latest practical Mac times
	if mac < 0x80000000 {
		return 0x80000000
	} else if mac > 0xffffffff {
		return 0xffffffff
	} else {
		return uint32(mac)
	}
}

func epochToHost(mac uint32) time.Time {
	if mac == 0 {
		return time.Unix(0, 0)
	}

	return frozenTime.Add(time.Duration((int64(mac) - int64(readl(0x20c))) * 1e9))
}

// Map a zero Unix time to a zero Macintosh time
// (which tends to indicate a corrupt file)
func mtimeFile(path string) uint32 {
	var modTime time.Time
	// Check forks, but ignore the files containing Finder info
	for _, p := range []string{path, path + ".rdump", platPathJoin(platPathDir(path), "RESOURCE.FRK", platPathBase(path))} {
		if stat, err := os.Stat(p); err == nil {
			t := stat.ModTime()
			if t.Unix() == 0 {
				return 0
			}
			if t.After(modTime) {
				modTime = t
			}
		}
	}

	return epochToMac(modTime)
}

func mtimeDir(path string) uint32 {
	stat, err := os.Stat(path)
	if err != nil {
		return 0
	}

	modTime := stat.ModTime()
	if modTime.Unix() == 0 {
		return 0
	}

	return epochToMac(modTime)
}

func writeMtimeFile(path string, macTime uint32) {
	// Do not set the time if it would make no difference anyway,
	// to prevent subtly altering files when setting only the type/creator
	if macTime == mtimeFile(path) {
		return
	}

	t := epochToHost(macTime)

	// Do not touch the files containing the Finder info
	for _, p := range []string{path, path + ".rdump", platPathJoin(platPathDir(path), "RESOURCE.FRK", platPathBase(path))} {
		os.Chtimes(p, t, t)
	}
}

func writeMtimeDir(path string, macTime uint32) {
	// Do not set the time if it would make no difference anyway,
	// to prevent subtly altering files when setting only the type/creator
	if macTime == mtimeFile(path) {
		return
	}

	t := epochToHost(macTime)

	os.Chtimes(path, t, t)
}

func deleteForks(path string) {
	for _, p := range underlyingPaths(path) {
		os.Remove(p)
	}
}

func underlyingPaths(path string) []string {
	return []string{
		path,
		path + ".idump",
		path + ".rdump",
		platPathJoin(platPathDir(path), "RESOURCE.FRK", platPathBase(path)),
		platPathJoin(platPathDir(path), "FINDER.DAT", platPathBase(path)),
	}
}

// Is this a UTF-8+LF/CRLF text file that can be converted to MacRoman+CR?
// If not, fail early, before reading a very large file!
// More stringent than unicodeToMac() by checking line endings and
// forbidding control characters, but returns the same length as unicodeToMac().
func isTextFile(reader io.RuneReader) (size int, ok bool) {
	anyNewline := false
	prev := rune(0)
	for {
		r, _, err := reader.ReadRune()
		if err == io.EOF {
			break
		} else if err != nil {
			panic(err)
		}

		// CR must be followed by LF
		if prev == '\r' && r != '\n' {
			return 0, false
		}

		switch {
		case r == '\n':
			size++
			anyNewline = true

		case r == '\r':
			// Don't count CR as a character because it is paired with LF

		case r == '\t':
			size++

		case r < 0x20 || r == 0x7f: // control characters except \r\n\t
			return 0, false

		case r < 0x7f: // ordinary ASCII (but not DEL)
			size++

		case r == 0xc4 || r == 0xc5 || r == 0xc7 || r == 0xc9 || r == 0xd1 ||
			r == 0xd6 || r == 0xdc || r == 0xe1 || r == 0xe0 || r == 0xe2 ||
			r == 0xe4 || r == 0xe3 || r == 0xe5 || r == 0xe7 || r == 0xe9 ||
			r == 0xe8 || r == 0xea || r == 0xeb || r == 0xed || r == 0xec ||
			r == 0xee || r == 0xef || r == 0xf1 || r == 0xf3 || r == 0xf2 ||
			r == 0xf4 || r == 0xf6 || r == 0xf5 || r == 0xfa || r == 0xf9 ||
			r == 0xfb || r == 0xfc || r == 0x2020 || r == 0xb0 || r == 0xa2 ||
			r == 0xa3 || r == 0xa7 || r == 0x2022 || r == 0xb6 || r == 0xdf ||
			r == 0xae || r == 0xa9 || r == 0x2122 || r == 0xb4 || r == 0xa8 ||
			r == 0x2260 || r == 0xc6 || r == 0xd8 || r == 0x221e || r == 0xb1 ||
			r == 0x2264 || r == 0x2265 || r == 0xa5 || r == 0xb5 || r == 0x2202 ||
			r == 0x2211 || r == 0x220f || r == 0x3c0 || r == 0x222b || r == 0xaa ||
			r == 0xba || r == 0x3a9 || r == 0xe6 || r == 0xf8 || r == 0xbf ||
			r == 0xa1 || r == 0xac || r == 0x221a || r == 0x192 || r == 0x2248 ||
			r == 0x2206 || r == 0xab || r == 0xbb || r == 0x2026 || r == 0xa0 ||
			r == 0xc0 || r == 0xc3 || r == 0xd5 || r == 0x152 || r == 0x153 ||
			r == 0x2013 || r == 0x2014 || r == 0x201c || r == 0x201d || r == 0x2018 ||
			r == 0x2019 || r == 0xf7 || r == 0x25ca || r == 0xff || r == 0x178 ||
			r == 0x2044 || r == 0xa4 || r == 0x20ac || r == 0x2039 || r == 0x203a ||
			r == 0xfb01 || r == 0xfb02 || r == 0x2021 || r == 0xb7 || r == 0x201a ||
			r == 0x201e || r == 0x2030 || r == 0xc2 || r == 0xca || r == 0xc1 ||
			r == 0xcb || r == 0xc8 || r == 0xcd || r == 0xce || r == 0xcf ||
			r == 0xcc || r == 0xd3 || r == 0xd4 || r == 0xf8ff || r == 0xd2 ||
			r == 0xda || r == 0xdb || r == 0xd9 || r == 0x131 || r == 0x2c6 ||
			r == 0x2dc || r == 0xaf || r == 0x2d8 || r == 0x2d9 || r == 0x2da ||
			r == 0xb8 || r == 0x2dd || r == 0x2db || r == 0x2c7: // single code points
			size++

		case r == 0x300 || r == 0x301 || r == 0x302: // COMBINING GRAVE/ACUTE/CIRCUMFLEX ACCENT
			if upper := prev &^ 0x20; upper == 'A' || upper == 'E' || upper == 'I' || upper == 'O' || upper == 'U' {
				size++
			} else {
				return 0, false
			}

		case r == 0x303: // COMBINING TILDE
			if upper := prev &^ 0x20; upper == 'A' || upper == 'N' || upper == 'O' {
				size++
			} else {
				return 0, false
			}

		case r == 0x308: // COMBINING DIAERESIS
			if upper := prev &^ 0x20; upper == 'A' || upper == 'E' || upper == 'I' || upper == 'O' || upper == 'U' || upper == 'Y' {
				size++
			} else {
				return 0, false
			}

		case r == 0x30a: // COMBINING RING ABOVE
			if upper := prev &^ 0x20; upper == 'A' {
				size++
			} else {
				return 0, false
			}

		case r == 0x327: // COMBINING CEDILLA
			if upper := prev &^ 0x20; upper == 'C' {
				size++
			} else {
				return 0, false
			}

		case r == 0x338: // COMBINING LONG SOLIDUS OVERLAY
			if prev == '=' {
				size++
			} else {
				return 0, false
			}

		default:
			return 0, false
		}

		prev = r
	}

	// Can't end with a CR, because CR is only permitted in CRLF
	if prev == '\r' {
		return 0, false
	}

	if !anyNewline {
		return 0, false
	}

	return size, true
}
