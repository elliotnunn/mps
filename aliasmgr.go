// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

/*
We can create alias records for the real MacOS and read MacOS records in turn,
but our logic is completely path-based, because mps discards CNIDs between runs.
*/

package main

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"os"
	"strings"
)

func tAliasDispatch() {
	switch readb(d0ptr + 3) {
	case 0:
		tFindFolder()
	case 2:
		tNewAlias()
	case 3:
		tResolveAlias()
	case 5:
		tMatchAlias()
	case 6:
		tUpdateAlias()
	case 7:
		tGetAliasInfo()
	case 8:
		tNewAliasMinimal()
	case 9:
		tNewAliasMinimalFromFullPath()
	case 0xc:
		tResolveAliasFile()
	default:
		panic(fmt.Sprintf("AliasDispatch %#x unimplemented", readb(d0ptr+3)))
	}
}

// Internals of alias record
const (
	alUserType     = 0   // appl stored type
	alAliasSize    = 4   // alias record size in bytes, for appl usage
	alVersion      = 6   // always 2
	alKind         = 8   // 0 for file, 1 for directory
	alVolumeName   = 10  // 27-char volume name
	alVolumeCrDate = 38  // creation date
	alVolumeSig    = 42  // "BD" for HFS
	alVolumeKind   = 44  // 0 for HD
	alParentCNID   = 46  // parent CNID
	alName         = 50  // 64-char
	alCNID         = 114 // CNID
	alCrDate       = 118 // creation date
	alType         = 122 // type code
	alCreator      = 126 // creator code
	alLevelsFrom   = 130 // relative alias: levels to nLevelFrom
	alLevelsTo     = 132 // relative alias: levels to nLevelTo
	alVolumeBits   = 134 // bitfield
	alFSID         = 138 // 0 for non-ExtFS
	alVarData      = 150 // variable length info
)

// Create an alias record fit for an absolute or relative path search
func aliasRecord(to, from string) []byte {
	// Still Unicode strings, but colon-separated
	to = strings.TrimRight(platPathToMac(to), ":")
	from = strings.TrimRight(platPathToMac(from), ":")

	var nLevelTo, nLevelFrom int
	if from != "" {
		// Count the shared left side and therefore the differing right sides
		toComps := strings.Split(to, ":")
		fromComps := strings.Split(from, ":")
		common := 0
		for {
			if common >= len(toComps) || common >= len(fromComps) {
				break
			}
			if toComps[common] != fromComps[common] {
				break
			}
			common++
		}

		nLevelTo = len(toComps) - common
		nLevelFrom = len(fromComps) - common
	}

	kind := byte(0)
	if stat, err := os.Stat(to); err == nil && stat.Mode().IsDir() {
		kind = 1
	}

	alias := []byte{
		alVersion + 1:    2,
		alKind + 1:       kind,
		alVolumeSig + 0:  'B', // HFS signature
		alVolumeSig + 1:  'D',
		alParentCNID:     '#', // mps CNIDs are short-lived
		alCNID:           '#', // ...so poison these fields
		alLevelsFrom + 0: byte(nLevelFrom >> 8),
		alLevelsFrom + 1: byte(nLevelFrom),
		alLevelsTo + 0:   byte(nLevelTo >> 8),
		alLevelsTo + 1:   byte(nLevelTo),
		alVarData - 1:    0, // extend to length
	}

	// Pascal strings
	alias[alVolumeName] = byte(len(onlyVolName))
	copy(alias[alVolumeName+1:], onlyVolName)

	nameMac := unicodeToMacOrPanic(to[strings.LastIndexByte(to, ':')+1:])
	alias[alName] = byte(len(nameMac))
	copy(alias[alName+1:], nameMac)

	// Append absolute path to variable-length area
	pathMac := unicodeToMacOrPanic(to)
	alias = append(alias, 0x00, 0x02)
	alias = append(alias, byte(len(pathMac)>>8), byte(len(pathMac)))
	alias = append(alias, pathMac...)
	if len(alias)%2 != 0 {
		alias = append(alias, 0)
	}

	// End variable-length area
	alias = append(alias, 0xff, 0xff, 0, 0)

	// Record length
	binary.BigEndian.PutUint16(alias[alAliasSize:], uint16(len(alias)))

	return alias
}

// Return possible targets via the absolute and relative route.
func resolveAlias(alias []byte, baseNum uint16, base macstring, relFirst bool) (recordOK, needsUpdate bool, found []string) {
	absolute := aliasAbsPath(alias)
	if absolute == "" {
		return false, false, nil // bad record
	}
	if absolute[0] == ':' {
		panic("Alias absolute path record should never start with colon, but does")
	}

	searchOrder := []macstring{absolute}

	// Do we have the "base" necessary for a relative search?
	if len(base) != 0 {
		nLevelFrom := int(binary.BigEndian.Uint16(alias[alLevelsFrom:]))
		nLevelTo := int(binary.BigEndian.Uint16(alias[alLevelsTo:]))

		// Climb up the directory tree using colons
		relative := base
		for i := 0; i < nLevelFrom; i++ {
			relative += ":"
		}

		// And down using the right hand side of the absolute path
		cut := len(absolute)
		for i := 0; i < nLevelTo; i++ {
			cut = strings.LastIndex(string(absolute[:cut]), ":")
		}
		relative += absolute[cut:]

		if relFirst {
			searchOrder = []macstring{relative, absolute}
		} else {
			searchOrder = []macstring{absolute, relative}
		}
	}

	// See if either of our schemes work
	for _, try := range searchOrder {
		path, errno := hostPath(baseNum, try, true)

		if errno != 0 {
			continue
		}

		// Reject a file when expecting a folder or vice versa
		wantDir := alias[alKind]|alias[alKind+1] != 0
		stat, _ := os.Stat(path) // discard error because we trust it exists

		if wantDir != stat.Mode().IsDir() {
			continue
		}

		found = append(found, path)
	}

	// Was there something imperfect about the alias?
	if len(found) != len(searchOrder) {
		needsUpdate = true
	}

	if len(found) == 2 && found[0] != found[1] {
		needsUpdate = true
	}

	// Deduplicate
	if len(found) == 2 && found[0] == found[1] {
		found = found[:1]
	}

	return true, needsUpdate, found
}

// Extract absolute path from the end of the alias record
func aliasAbsPath(alias []byte) macstring {
	reclen := binary.BigEndian.Uint16(alias[alAliasSize:])
	alias = alias[:reclen]

	varrec := alVarData
	for {
		// Truncated alias record
		if varrec+4 > len(alias) {
			return ""
		}

		rectype := binary.BigEndian.Uint16(alias[varrec:])
		reclen := binary.BigEndian.Uint16(alias[varrec+2:])
		recdata := alias[varrec+4:][:reclen]

		// Failed to find abspath before end record
		if rectype == 0xffff {
			return ""
		}

		// Succeed
		if rectype == 2 {
			return macstring(recdata)
		}

		// Next record
		varrec += 4 + int(reclen)
		if varrec%2 != 0 {
			varrec += 1
		}
	}
}

func goodAliasHand(h uint32) bool {
	block, ok := usedBlocks[h]
	if block == nil || block.kind != masterPtrBlock || !ok {
		return false
	}

	ptr := readl(h)
	if ptr == 0 || readw(ptr+alVersion) != 2 {
		return false
	}

	return true
}

// Selector 0
// FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN;
// VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
func tFindFolder() {
	foundDirID := popl()
	foundVRefNum := popl()
	popb() // ignore createFolder
	folderType := string(mem[readl(spptr):][:4])
	popl()
	popw()                  // ignore vRefNum
	writel(readl(spptr), 0) // noErr

	var path string
	switch folderType {
	case "pref", "sprf":
		path = platPathJoin(systemFolder, "Preferences")
	case "desk", "sdsk":
		path = platPathJoin(systemFolder, "Desktop Folder")
	case "trsh", "strs", "empt":
		path = platPathJoin(systemFolder, "Trash")
	case "temp":
		path = platPathJoin(systemFolder, "Temporary Items")
	default:
		path = systemFolder
	}

	writew(foundVRefNum, rootID)
	writel(foundDirID, uint32(dirID(path)))
}

// Selector 2
// FUNCTION NewAlias (fromFile: FSSpecPtr; target: FSSpec;
// VAR alias: AliasHandle): OSErr;
func tNewAlias() {
	handPtr := popl()
	toSpec := popl()
	fromSpec := popl()
	writel(readl(spptr), 0) // noErr

	if handPtr == 0 || toSpec == 0 {
		writel(readl(spptr), 0x1000-50) // paramErr
		return
	}

	toPath, err := hostPathFromSpec(toSpec, true)
	if err != 0 {
		writew(readl(spptr), uint16(err))
		return
	}

	fromPath := ""
	if fromSpec != 0 {
		fromPath, err = hostPathFromSpec(fromSpec, true)
		if err != 0 {
			writew(readl(spptr), uint16(err))
			return
		}
	}

	alias := aliasRecord(toPath, fromPath)
	hand := newHandleFrom(alias)

	writel(handPtr, hand)
}

// Selector 3
// FUNCTION ResolveAlias (fromFile: FSSpecPtr; alias: AliasHandle;
// VAR target: FSSpec; VAR wasChanged: Boolean): OSErr;
func tResolveAlias() {
	wasChangedPtr := popl()
	target := popl()
	aliasHand := popl()
	fromFile := popl()
	writel(readl(spptr), 0) // noErr

	if !goodAliasHand(aliasHand) || target == 0 || wasChangedPtr == 0 {
		writew(readl(spptr), uint16(0x10000-50)) // paramErr
		return
	}

	// Read the FSSpec
	var baseNum uint16
	var baseStr macstring
	var basePath string
	if fromFile != 0 {
		vRefNum := readw(fromFile)
		dirID := readl(fromFile + 2)
		if dirID == 0 {
			baseNum = vRefNum
		} else {
			baseNum = uint16(dirID)
		}

		baseStr = readPstring(fromFile + 6)

		basePath, _ = hostPath(baseNum, baseStr, false)
	}

	aliasOK, needsUpdate, found := resolveAlias(mem[readl(aliasHand):], baseNum, baseStr, false)
	if !aliasOK {
		writew(readl(spptr), uint16(0x10000-50)) // paramErr
		return
	}

	if len(found) == 0 {
		writew(readl(spptr), uint16(0x10000-120)) // dirNFErr
		return
	}

	dirID := dirID(platPathDir(found[0]))
	name, _ := macName(platPathBase(found[0]))

	writew(target, rootID)          // vRefNum
	writel(target+2, uint32(dirID)) // dirID
	writePstring(target+6, name)

	if needsUpdate {
		alias := aliasRecord(found[0], basePath)
		copy(alias[:4], mem[readl(aliasHand):]) // keep 4-byte user data
		setHandleBlock(aliasHand, alias)

		writeb(wasChangedPtr, 1)
	} else {
		writeb(wasChangedPtr, 0)
	}
}

// Selector 5
// FUNCTION MatchAlias (fromFile: FSSpecPtr; rulesMask: LongInt;
// alias: AliasHandle; VAR aliasCount: Integer; aliasList: FSSpecArrayPtr;
// VAR needsUpdate: Boolean; aliasFilter: AliasFilterProcPtr; yourDataPtr: UNIV Ptr): OSErr;

// FUNCTION(cpbPtr: CInfoPBPtr; VAR quitFlag: BOOLEAN; myDataPtr: Ptr): BOOLEAN;

// Don't bother with the found-folder-but-not-contained-file case
// NeedsUpdate if the absolute path is incorrect
func tMatchAlias() {
	yourDataPtr := popl()
	aliasFilter := popl()
	needsUpdatePtr := popl()
	aliasList := popl()
	aliasCountPtr := popl()
	aliasHand := popl()
	rulesMask := popl()
	fromFile := popl()
	writel(readl(spptr), 0) // noErr

	if !goodAliasHand(aliasHand) || needsUpdatePtr == 0 {
		writew(readl(spptr), uint16(0x10000-50)) // paramErr
		return
	}

	// Read the FSSpec
	var baseNum uint16
	var baseStr macstring
	if fromFile != 0 {
		vRefNum := readw(fromFile)
		dirID := readl(fromFile + 2)
		if dirID == 0 {
			baseNum = vRefNum
		} else {
			baseNum = uint16(dirID)
		}

		baseStr = readPstring(fromFile + 6)
	}

	relFirst := rulesMask&0x400 != 0 // kARMSearchRelFirst

	aliasOK, needsUpdate, found := resolveAlias(mem[readl(aliasHand):], baseNum, baseStr, relFirst)
	if !aliasOK {
		writew(readl(spptr), uint16(0x10000-50)) // paramErr
		return
	}

	if needsUpdate {
		writeb(needsUpdatePtr, 1)
	} else {
		writeb(needsUpdatePtr, 0)
	}

	max := readw(aliasCountPtr)
	writew(aliasCountPtr, 0)

	for _, path := range found {
		if readw(aliasCountPtr) == max {
			break
		}

		dirID := dirID(platPathDir(path))
		name, _ := macName(platPathBase(path))

		// Give the callback a chance to cancel this alias or the entire operation
		if aliasFilter != 0 {
			namePtr, oldsp := pushzero(256)
			writePstring(namePtr, name)

			// GetCatInfo
			pb, _ := pushzero(128)
			writel(pb+18, namePtr)
			writew(pb+22, rootID) // vRefNum
			writel(pb+48, uint32(dirID))
			writel(a0ptr, pb)
			writel(d0ptr, 9)
			lineA(0xa260)

			// Callback
			pushb(0) // indirect return value (quitFlag)
			quitFlagPtr := readl(spptr)
			pushw(0)  // return value (discard)
			pushl(pb) // paramBlk of PBHGetCatInfo
			pushl(quitFlagPtr)
			pushl(yourDataPtr)
			run68(aliasFilter)

			discard := popb() != 0
			quitFlag := popb() != 0

			writel(spptr, oldsp)

			if quitFlag {
				writew(readl(spptr), uint16(0x10000-128)) // usrCanceledErr
				return
			} else if discard {
				continue
			}
		}

		// Append the FSSpec to the alias array
		spec := aliasList + 70*uint32(readw(aliasCountPtr))
		writew(spec, rootID)          // vRefNum
		writel(spec+2, uint32(dirID)) // dirID
		writePstring(spec+6, name)
		writew(aliasCountPtr, readw(aliasCountPtr)+1)
	}
}

// Selector 6
// FUNCTION UpdateAlias (fromFile: FSSpecPtr; target: FSSpec;
// alias: AliasHandle; VAR wasChanged: Boolean): OSErr;
func tUpdateAlias() {
	wasChangedPtr := popl()
	aliasHand := popl()
	target := popl()
	fromFile := popl()
	writel(readl(spptr), 0) // noErr

	if !goodAliasHand(aliasHand) || wasChangedPtr == 0 || target == 0 {
		writew(readl(spptr), uint16(0x10000-50)) // paramErr
		return
	}

	targetPath, err := hostPathFromSpec(target, true)
	if err != 0 {
		writew(readl(spptr), uint16(err))
		return
	}

	fromPath := ""
	if fromFile != 0 {
		fromPath, err = hostPathFromSpec(fromFile, true)
		if err != 0 {
			writew(readl(spptr), uint16(err))
			return
		}
	}

	alias := aliasRecord(targetPath, fromPath)
	copy(alias[:4], mem[readl(aliasHand):]) // keep 4-byte user data

	if !bytes.Equal(alias, mem[readl(aliasHand):][:len(alias)]) {
		setHandleBlock(aliasHand, alias)
		writeb(wasChangedPtr, 1)
	} else {
		writeb(wasChangedPtr, 0)
	}
}

// Selector 7
// FUNCTION GetAliasInfo (alias: AliasHandle; index: AliasInfoType;
// VAR theString: Str63): OSErr;
func tGetAliasInfo() {
	theString := popl()
	index := int(int16(popw()))
	aliasHand := popl()
	writel(readl(spptr), 0) // noErr

	if !goodAliasHand(aliasHand) || theString == 0 || index < -3 {
		writel(readl(spptr), 0x1000-50) // paramErr
		return
	}

	// Empty string for AppleShare zone/server/volume name
	if index < 0 {
		writeb(theString, 0)
		return
	}

	// Zero is last component, 1 is second last etc
	comps := strings.Split(string(aliasAbsPath(mem[readl(aliasHand):])), ":")
	if index >= len(comps) {
		writeb(theString, 0)
		return
	}

	writePstring(theString, macstring(comps[len(comps)-1-index]))
}

// Selector 8
// FUNCTION NewAliasMinimal (target: FSSpec; VAR alias: AliasHandle): OSErr;
func tNewAliasMinimal() {
	handPtr := popl()
	toSpec := popl()
	writel(readl(spptr), 0) // noErr

	if handPtr == 0 || toSpec == 0 {
		writel(readl(spptr), 0x1000-50) // paramErr
		return
	}

	toPath, err := hostPathFromSpec(toSpec, true)
	if err != 0 {
		writew(readl(spptr), uint16(err))
		return
	}

	alias := aliasRecord(toPath, "")
	hand := newHandleFrom(alias)

	writel(handPtr, hand)
}

// Selector 9
// FUNCTION NewAliasMinimalFromFullPath(fullPathLength: Integer; fullPath: Ptr;
// zoneName: Str32; serverName: Str31; VAR alias: AliasHandle): OSErr;
func tNewAliasMinimalFromFullPath() {
	handPtr := popl()
	popl() // discard AppleShare info
	popl()
	pathPtr := popl()
	pathLen := popw()
	writel(readl(spptr), 0) // noErr

	if handPtr == 0 || pathPtr == 0 || pathLen == 0 {
		writel(readl(spptr), 0x1000-50) // paramErr
		return
	}

	toPath, err := hostPath(2, macstring(mem[pathPtr:][:pathLen]), true)
	if err != 0 {
		writew(readl(spptr), uint16(err))
		return
	}

	alias := aliasRecord(toPath, "")
	hand := newHandleFrom(alias)

	writel(handPtr, hand)
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

	writew(theSpecPtr, rootID) // volID
	writel(theSpecPtr+2, uint32(dirID(platPathDir(path))))
	writePstring(theSpecPtr+6, unicodeToMacOrPanic(platPathBase(path)))
}
