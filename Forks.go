package main

import (
	"bytes"
	"fmt"
	"os"
	"path/filepath"
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
	return finderInfoTextHack(path, true)
}

func finderInfoTextHack(path string, textHack bool) [16]byte {
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

	// Present as text file if persuaded that it is one
	if textHack && string(finfo[:4]) == "????" {
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

func dataFork(path string) []byte {
	data, _ := os.ReadFile(path)

	// Convert the data fork if persuaded it is a text file
	finfo := finderInfoTextHack(path, false)
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
	// Ensure that the main file exists
	f, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0o644)
	if err == nil {
		f.Close()
	}

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
