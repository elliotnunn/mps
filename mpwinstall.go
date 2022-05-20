// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Download MPW 3.5 (1999 Golden Master)

package main

import (
	"crypto/sha256"
	"fmt"
	"math/rand"
	"os"
	"path/filepath"
	"strings"
	"time"
)

const pathsep = string(os.PathSeparator)

var mirrors = []string{
	"https://staticky.com/dl/ftp.apple.com/developer/Tool_Chest/Core_Mac_OS_Tools/MPW_etc./MPW-GM_Images/MPW-GM.img.bin",
	"https://ftpmirror.your.org/pub/misc/apple/ftp.apple.com/developer/Tool_Chest/Core_Mac_OS_Tools/MPW_etc./MPW-GM_Images/MPW-GM.img.bin",
	"https://macintoshgarden.org/sites/macintoshgarden.org/files/apps/mpw-gm.img__0.bin",
	"https://mirror.macintosharchive.org/macintoshgarden.org/files/apps/mpw-gm.img__0.bin",
	"https://www.sonixwave.com/apple/developer/Tool_Chest/Core_Mac_OS_Tools/MPW_etc./MPW-GM_Images/MPW-GM.img.bin",
	"https://ftp.zx.net.nz/pub/micro/macintosh/developer/Tool_Chest/Core_Mac_OS_Tools/MPW_etc/MPW-GM_Images/MPW-GM.img.bin",
}

var mpwSHA256 = [...]byte{
	0x99, 0xbb, 0xfa, 0x95, 0xbb, 0x98, 0x00, 0xc8,
	0xff, 0xc5, 0x72, 0xfc, 0xe6, 0xd7, 0x2e, 0x56,
	0x1f, 0x01, 0x23, 0x31, 0xc5, 0xc6, 0x23, 0xfa,
	0x45, 0xf7, 0x32, 0x50, 0x2b, 0x6f, 0xa8, 0x72,
}

// Install MPW for the user.
// A messy tour through vintage Macintosh data formats.
func installFrom(binFile string) bool {
	// $MPW or $HOME/MPW or ./MPW
	dest, ok := os.LookupEnv("MPW")
	if !ok {
		if home, ok := os.LookupEnv("HOME"); ok {
			dest = filepath.Join(home, "MPW")
		} else {
			dest = "MPW"
		}
	}

	// Download MPW if not already present
	if binFile == "" || strings.HasPrefix(binFile, "http") {
		// If we were provided a URL, make it our "mirror"
		if binFile != "" {
			mirrors = []string{binFile}
		}

		// $HOME/ or ./
		binFile = "MPW-GM.img.bin"
		if home, ok := os.LookupEnv("HOME"); ok {
			binFile = filepath.Join(home, binFile)
		}

		// Download file if not already in home directory
		if _, err := os.Stat(binFile); os.IsNotExist(err) {
			rand.Seed(time.Now().UnixNano())
			rand.Shuffle(len(mirrors), func(i, j int) { mirrors[i], mirrors[j] = mirrors[j], mirrors[i] })

			okMirror := false
			for _, m := range mirrors {
				fmt.Println("Getting", m)
				err := download(binFile, m)
				if err != nil {
					fmt.Println(err)
					continue
				}
				okMirror = true
				break
			}

			if !okMirror {
				fmt.Println("No more mirrors to try")
				return false
			}
		}
	}

	data, err := os.ReadFile(binFile)
	if err != nil {
		fmt.Println(err)
		return false
	}

	// After this, trust the file, no need to fail gracefully
	if sha256.Sum256(data) != mpwSHA256 {
		fmt.Println("Incorrect checksum: ", binFile)
		return false
	}

	// MacBinary II is a trivial concatenation of header, data, resource
	data, resource, ftype, _ := macbinary(data)
	if ftype != "rohd" {
		panic(ftype)
	}

	// Disk Copy's "ROCo" compression scheme is newly documented below
	bcem := extractRes(resource, "bcem", 128)
	if bcem == nil {
		panic("no bcem")
	}
	data = extractROCo(data, bcem)

	// Dump files from raw disk image
	paths, fileContent := hfs(data)
	for _, path := range paths {
		content, isFile := fileContent[path]

		// Convert the path to agree with the OS
		path = macToUnicode(macstring(path))
		slice := []byte(path)
		for i := range slice {
			switch slice[i] {
			case ':':
				slice[i] = filepath.Separator
			case filepath.Separator:
				slice[i] = ':'
			}
		}
		path = string(slice)

		// Slightly rearrange things to keep homedirs tidy
		// MPW's startup scripts allow this "old-style" structure
		if _, sub, ok := strings.Cut(path, pathsep+"MPW"+pathsep); ok {
			path = filepath.Join(dest, sub)
		} else if _, sub, ok := strings.Cut(path, pathsep+"Interfaces&Libraries"+pathsep); ok {
			path = filepath.Join(dest, sub)
		} else {
			continue
		}

		// Create folders and write files.
		if isFile {
			if string(content.finfo[:4]) == "TEXT" {
				// Modernise text files to UTF-8, LF line endings
				// No Finder info nor resource fork
				content.data = []byte(macToUnicode(macstring(content.data)))
				err := os.WriteFile(path, content.data, 0o666)
				if err != nil {
					panic(err)
				}
			} else {
				// Non-text: preserve Finder info and resource fork
				err := os.WriteFile(path, content.data, 0o666)
				if err != nil {
					panic(err)
				}

				if len(content.rsrc) != 0 {
					err = os.WriteFile(path+".rdump", deRez(content.rsrc), 0o666)
					if err != nil {
						panic(path)
					}
				}

				err = os.WriteFile(path+".idump", content.finfo[:8], 0o666)
				if err != nil {
					panic(err)
				}
			}
		} else {
			err := os.MkdirAll(path, 0o777)
			if err != nil {
				panic(err)
			}
		}
	}

	logln("MPW 3.5 (Golden Master) installed:", dest)
	return true
}
