package main

import (
	"path/filepath"
)

func tAliasDispatch() {
	switch readb(d0ptr + 3) {
	case 0:
		tFindFolder()
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
