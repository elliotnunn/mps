package main

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

import (
	"bytes"
	"fmt"
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

// Assume the existence of the file
func finderInfo(path string) [16]byte {
	finfo := finderInfoWithoutTextHack(path)

	// Present as text file if persuaded that it is one
	if string(finfo[:4]) == "????" {
		if data, err := os.ReadFile(path); err == nil {
			if bytes.Contains(data, []byte{'\n'}) && !bytes.Contains(data, []byte{'\r'}) {
				if _, ok := unicodeToMac(string(data)); ok {
					copy(finfo[:], "TEXTMPS ")
				}
			}
		}
	}

	return finfo
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

func dataFork(path string) []byte {
	data, _ := os.ReadFile(path)

	// Convert the data fork if persuaded it is a text file
	finfo := finderInfoWithoutTextHack(path)
	ftype := string(finfo[:4])
	if ftype == "TEXT" || ftype == "????" {
		if bytes.Contains(data, []byte{'\n'}) && !bytes.Contains(data, []byte{'\r'}) {
			if data2, ok := unicodeToMac(string(data)); ok {
				data = []byte(data2)
			}
		}
	}

	return data
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
