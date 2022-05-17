// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"os"
	"path/filepath"
)

func tAliasDispatch() {
	switch readb(d0ptr + 3) {
	case 0:
		tFindFolder()
	case 0xc:
		tResolveAliasFile()
	default:
		panic("Unknown AliasDispatch selector")
	}
}

func tFindFolder() {
	foundDirID := popl()
	foundVRefNum := popl()
	popb() // ignore createFolder
	folderType := string(mem[readl(spptr):][:4])
	popl()
	popw() // ignore vRefNum

	var path string
	switch folderType {
	case "pref", "sprf":
		path = filepath.Join(systemFolder, "Preferences")
	case "desk", "sdsk":
		path = filepath.Join(systemFolder, "Desktop Folder")
	case "trsh", "strs", "empt":
		path = filepath.Join(systemFolder, "Trash")
	case "temp":
		path = filepath.Join(systemFolder, "Temporary Items")
	default:
		path = systemFolder
	}

	writew(foundVRefNum, 2)
	writel(foundDirID, uint32(dirID(path)))
	writew(readl(spptr), 0) // noErr
}

// We don't implement alias files, but MPWLibs needs this
// Canonicalise file names
func tResolveAliasFile() {
	wasAliasedPtr := popl()
	targetIsFolderPtr := popl()
	popb() // resolveAliasChains
	theSpecPtr := popl()

	err := 0
	defer func() {
		writew(readl(spptr), uint16(err))
	}()

	if theSpecPtr|targetIsFolderPtr|wasAliasedPtr == 0 {
		err = -50 // paramErr
		return
	}

	path, err := hostPathFromSpec(theSpecPtr, true)
	if err != 0 {
		return
	}

	isDir := uint8(0)
	if stat, err := os.Stat(path); err == nil && stat.Mode().IsDir() {
		isDir = 1
	}
	writeb(targetIsFolderPtr, isDir)

	writeb(wasAliasedPtr, 0)

	writew(theSpecPtr, 2) // volID
	writel(theSpecPtr+2, uint32(dirID(filepath.Dir(path))))
	writePstring(theSpecPtr+6, unicodeToMacOrPanic(filepath.Base(path)))
}
