// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

/*
The platform-independent part of the File Manager

Present the single-rooted tree from filemgr_*.go to the MacOS as a single volume.

The relationship of MacOS filenames to host filenames is:
    different-case macnames : one true macname : multiple hostnames

Converting hostname>macname in practice only happens when listing a directory.
Non-representable names are ignored. Hostnames differing only in case or Unicode
normalisation have conflicting macnames: these cause a panic.
It is worth preserving the exact hostname used, so readDir returns structs
with both macname and hostname.

Converting macname>hostname requires a full directory listing, which is filtered
for the matching hostname.

MacOS commonly refers to directories by a 32-bit catalog node ID or "dirID".
For compatibility with pre-HFS apps, the system kept a limited array of
"working directories", which mapped between 32-bit dirID and 16-bit volume ID.
For simplicity, we map these two IDs 1:1 (ignore the high part of dirID).
Host directory paths are appended to a global slice as they are encountered,
and their index gives the dirID.

0, 1 and 2 are reserved, for reasons documented in the slice declaration.

File CNIDs are not needed by the APIs, so not implemented.
*/

package main

import (
	"errors"
	"fmt"
	"io/fs"
	"os"
	"sort"
	"strings"
)

// The single volume
const (
	onlyVolName   = macstring("FS")
	curDirID      = 0
	rootsParentID = 1
	rootID        = 2
)

// Directories appended here as they are encountered, starting with ID 3
var dirIDs = []string{
	// a nil dirID/vRefNum means "current dir/vol"
	platRoot,
	// 1 is returned when asking about the "parent" of root
	"\x00\x01",
	// the dirID of the root of an HFS volume is 2
	// convenient to also consider the vRefNum as 2
	platRoot,
}

func dirID(hostPath string) uint16 {
	for idx, maybepath := range dirIDs[2:] {
		if maybepath == hostPath {
			return uint16(idx) + 2
		}
	}
	dirIDs = append(dirIDs, hostPath)
	return uint16(len(dirIDs)) - 1
}

// hostname>macname conversion
func macName(host string) (macstring, bool) {
	if strings.ContainsRune(host, platPathSep) {
		panic("macName passed string with a path sep: " + host)
	}

	// Disallow control and platform-specific chars
	if platNameForbid(host) {
		return "", false
	}

	// Disallow dotfiles
	if strings.HasPrefix(host, ".") {
		return "", false
	}

	// Host "and:or" appears as Mac "and/or"
	host = strings.ReplaceAll(host, ":", "/")

	// These special files belong to my "Rez" system
	if strings.HasSuffix(host, ".idump") || strings.HasSuffix(host, ".rdump") {
		return "", false
	}

	// These special folders belong to the File Exchange system
	if host == "RESOURCE.FRK" || host == "FINDER.DAT" {
		return "", false
	}

	// Convert as late as possible, to allow use of strings package
	mac, ok := unicodeToMac(host)
	if !ok {
		return "", false
	}

	// Max length of 63 (HFS says 31, but MFS says 63)
	if len(mac) == 0 || len(mac) > 63 {
		return "", false
	}

	return mac, true
}

// macname>hostname conversion
// Result might not be host's preferred Unicode normalisation,
// so in most cases we instead list directory and pick a returned name.
// But this function is still useful for validating names and creating files.
func hostName(mac macstring) (string, bool) {
	host := macToUnicode(mac)

	// Mac path separator shouldn't get through
	if strings.ContainsRune(host, ':') {
		panic("hostName passed string with a path sep: " + host)
	}

	// Mac "and/or" appears as host "and:or"
	host = strings.ReplaceAll(host, "/", ":")

	// Also run the tests for length etc in our sister function below
	_, ok := macName(host)
	if !ok {
		return "", false
	}

	return host, true
}

// Resolve a dirID/path pair to a host path.
// Follows the unusual MacOS rules for absolute and relative paths.
// Allows for differing Unicode normalisation by listing the directory.
func hostPath(number uint16, name macstring, leafMustExist bool) (path string, errno int) {
	if gDebugFileMgr {
		defer func(number uint16, name macstring, leafMustExist bool) {
			logf("hostPath(%v, %q, %v) = (%q, %v)", number, name, leafMustExist, path, errno)
		}(number, name, leafMustExist)
	}

	// If name is an absolute path, then start evaluating from "parent of root"
	if !strings.HasPrefix(string(name), ":") && strings.Contains(string(name), ":") {
		number = rootsParentID
	}

	path = dirIDs[number]

	var components []macstring
	for _, component := range strings.Split(string(name), ":") {
		components = append(components, macstring(component))
	}

	// remove stray empty components, because they behave like '..'
	if len(components) > 0 && len(components[0]) == 0 {
		components = components[1:]
	}
	if len(components) > 0 && len(components[len(components)-1]) == 0 {
		components = components[:len(components)-1]
	}

	for i, mac := range components {
		if len(mac) == 0 { // treat :: like ..
			if path == dirIDs[rootsParentID] || path == dirIDs[rootID] {
				return path, -120 // dirNFErr
			}

			path = platPathDir(path)
			continue
		}

		// Create the illusion of a single hard drive inside "parent of root"
		if path == dirIDs[rootsParentID] {
			if relString(onlyVolName, mac, false, true) != 0 {
				return path, -120 // dirNFErr
			}

			path = dirIDs[rootID]
			continue
		}

		// Move annoying files out of the way
		if path == mpwFolder && strings.HasPrefix(string(mac), "MPW.MinPipe") {
			path = platPathJoin(systemFolder, "Temporary Items")
		}

		host, ok := hostName(mac)
		if !ok {
			return "", -37 // bdNamErr
		}
		name := existingNamePair{mac, host}

		// Handle Windows drive letters
		if platPathImaginary(path) {
			path = platPathJoin(path, host)
			continue
		}

		// List the directory to find the matching unix name
		listing, _ := readDir(path)
		exists := false
		for _, existingName := range listing {
			if relString(name.mac, existingName.mac, false, true) == 0 {
				name = existingName // use the correct case in the path
				exists = true
				break
			}
		}

		// If matching file exists, use the unicode name supplied by the OS
		// Otherwise, use the unicode name that we made up
		path = platPathJoin(path, name.host)

		if !exists && errno == 0 { // can tolerate a nonexistent leaf file if instructed
			if i == len(components)-1 {
				if leafMustExist {
					errno = -43 // fnfErr
				}
			} else {
				errno = -120 // dirNFErr
			}
		}
	}

	return path, errno
}

func hostPathFromSpec(spec uint32, leafMustExist bool) (string, int) {
	vRefNum := readw(spec)
	dirID := readl(spec + 2)
	name := readPstring(spec + 6)

	if dirID > 0xffff {
		panic(fmt.Sprintf("dirID outside of range %#08x", dirID))
	}

	var number uint16
	if dirID == 0 {
		number = vRefNum
	} else {
		number = uint16(dirID)
	}

	return hostPath(number, name, leafMustExist)
}

// Return a mac and host-format directory listing
// The hostnames are exact, including Unicode normalisation
// The macnames are guaranteed valid and in RelString order
// Computing this is much more expensive than on HFS, so cache the answer.
func readDir(path string) ([]existingNamePair, int) {
	cachedSlice, isCached := dirCache[path]
	if isCached && !gDebugFileMgr {
		return cachedSlice, 0
	}

	f, err := os.Open(path)
	if err != nil {
		return nil, macErrCode(err)
	}
	defer f.Close()

	stat, err := f.Stat()
	if err != nil {
		return nil, macErrCode(err)
	}

	if !stat.Mode().IsDir() {
		return nil, -120 // dirNFErr
	}

	dirents, err := f.ReadDir(-1)
	if err != nil {
		return nil, macErrCode(err)
	}

	slice := make([]existingNamePair, 0, len(dirents))
	for _, d := range dirents {
		host := d.Name()

		if host[0] == '.' {
			continue
		}

		mac, ok := macName(host)
		if !ok {
			continue
		}

		slice = append(slice, existingNamePair{mac, host})
	}

	// HFS sorts files by RelString order
	sort.Slice(slice, func(i, j int) bool { return relString(slice[i].mac, slice[j].mac, false, true) > 1 })

	for i := 0; i < len(slice)-1; i++ {
		if relString(slice[i].mac, slice[i+1].mac, false, true) == 0 {
			logf("Indistinguishably named files in %s:\n  %s\n  %s\n", path, slice[i].host, slice[i+1].host)
			os.Exit(1)
		}
	}

	// Check cached answer against this one
	if isCached && gDebugFileMgr {
		matchOK := len(cachedSlice) == len(slice)
		if matchOK {
			for i := range cachedSlice {
				if cachedSlice[i] != slice[i] {
					matchOK = false
					break
				}
			}
		}

		if !matchOK {
			logf("incorrect cache listing for %q:", path)
			for _, el := range cachedSlice {
				logln("    " + el.host)
			}
			logln("updating cache with actual listing:")
			for _, el := range slice {
				logln("    " + el.host)
			}
		}
	}

	dirCache[path] = slice

	return slice, 0
}

type existingNamePair struct {
	mac  macstring
	host string
}

var dirCache = make(map[string][]existingNamePair)

func clearDirCache(dir string) {
	if dir == "" {
		dirCache = make(map[string][]existingNamePair)
	} else {
		delete(dirCache, dir)
	}
}

// Convert some filesystem errors to MacOS error codes
func macErrCode(err error) int {
	if err == nil {
		return 0 // noErr
	} else if errors.Is(err, fs.ErrExist) {
		return -48 // dupFNErr
	} else if errors.Is(err, fs.ErrNotExist) {
		return -43 // fnfErr
	} else if errors.Is(err, fs.ErrPermission) {
		return -54 // permErr
	} else {
		panic(err)
	}
}

// Let the funcs in this file accept a pb pointer and return an osErr
func pbWrap(actualTrap func(uint32) int) func() {
	return func() {
		pb := readl(a0ptr)
		trap := readw(d1ptr + 2)

		writew(pb+6, trap) // ioTrap

		err := actualTrap(pb)

		writew(pb+16, uint16(err)) // ioResult
		writel(d0ptr, uint32(err))
	}
}

// Read vRefNum or dirID, depending on the "hierarchical" trap flag.
// These are treated equivalently, as a 16-bit index into dirIDs
func paramBlkDirID() (num uint16) {
	pb := readl(a0ptr)
	trap := readl(d1ptr)

	if trap&0x200 != 0 {
		num = readw(pb + 48 + 2) // lower word of dirID
	}
	if num == 0 {
		num = readw(pb + 22) // whole vRefNum
	}
	return
}

func tCreate(pb uint32) int { // also DirCreate
	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)

	number := paramBlkDirID()
	path, errno := hostPath(number, ioName, true)
	switch errno {
	case 0: // noErr: already exists
		return -48 // dupFNErr
	case -43: // fnfErr: create the file/folder
		if readb(d1ptr+3) == 0x60 { // DirCreate
			os.Mkdir(path, 0o755)
			writel(pb+48, uint32(dirID(path))) // return ioDirID
		} else { // Create
			writeDataFork(path, nil)
		}
		clearDirCache(platPathDir(path))
		return 0
	default: // likely a containing folder not found, complain loudly
		return errno
	}
}

func tDelete(pb uint32) int {
	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)

	number := paramBlkDirID()
	path, errno := hostPath(number, ioName, true)
	if errno != 0 {
		return errno
	}

	deleteForks(path)
	clearDirCache(platPathDir(path))

	return 0
}

// A bit like stat
func tGetFInfo(pb uint32) int { // also GetCatInfo
	trap := readw(d1ptr + 2)
	ioFDirIndex := int16(readw(pb + 28))
	ioNamePtr := readl(pb + 18)
	dirid := paramBlkDirID()

	// clear our block of return values, which is longer for GetCatInfo
	for i := 30; i < 80 || (trap&0xff == 0x60 && i < 108); i++ {
		writeb(pb+uint32(i), 0)
	}

	returnIOName := false
	path := ""

	if trap&0xff == 0x60 && ioFDirIndex < 0 {
		// folder "dirID" alone
		path = dirIDs[dirid]
		returnIOName = true
	} else if ioFDirIndex > 0 {
		// file number "ioFDirIndex" within "dirID"
		returnIOName = true

		path = dirIDs[dirid]
		if platPathImaginary(path) {
			return -43 // fnfErr
		}

		listing, errno := readDir(path)
		if errno != 0 {
			panic("readDir failed on a safe path")
		}

		if int(ioFDirIndex) > len(listing) {
			return -43 // fnfErr
		}

		path = platPathJoin(path, listing[ioFDirIndex-1].host)
	} else { // zero or (if GetFInfo) negative
		// file named "ioNamePtr" within "dirID"
		subPath, errno := hostPath(dirid, readPstring(ioNamePtr), true)
		if errno != 0 { // could be nonexistent
			return errno
		}
		path = subPath
	}

	// -1 meaning file, otherwise meaning count of contained folders
	arity := 0
	if !platPathImaginary(path) {
		listing, listErr := readDir(path)
		if listErr == 0 {
			arity = len(listing)
		} else {
			arity = -1
		}
	}

	if returnIOName && ioNamePtr != 0 {
		if path == platRoot {
			writePstring(ioNamePtr, onlyVolName)
		} else {
			mac, _ := macName(platPathBase(path))
			writePstring(ioNamePtr, mac)
		}
	}

	if arity != -1 { // folder
		writeb(pb+30, 1<<4)                // is a directory
		writel(pb+48, uint32(dirID(path))) // ioDrDirID
		writel(pb+52, uint32(arity))       // ioDrNmFls

		t := mtimeDir(path)
		writel(pb+72, t) // ioFlCrDat
		writel(pb+76, t) // ioFlMdDat
	} else { // file
		fastButInaccurate := ioFDirIndex > 0
		sizeD, finfo := dataForkSizeFinderInfo(path, fastButInaccurate)

		copy(mem[pb+32:], finfo[:])     // ioFlFndrInfo (16b)
		writel(pb+54, sizeD)            // ioFlLgLen
		writel(pb+58, (sizeD+511)&^511) // ioFlPyLen

		sizeR := uint32(len(resourceFork(path)))

		writel(pb+64, sizeR)            // ioFlRLgLen
		writel(pb+68, (sizeR+511)&^511) // ioFlRPyLen

		t := mtimeFile(path)
		writel(pb+72, t) // ioFlCrDat
		writel(pb+76, t) // ioFlMdDat
	}

	if trap&0xff == 0x60 {
		parID := uint32(1) // parent of root
		if path != platRoot {
			parID = uint32(dirID(platPathDir(path)))
		}
		writel(pb+100, parID) // ioFlParID
	}

	return 0
}

func tSetFInfo(pb uint32) int { // also SetCatInfo
	ioName := readPstring(readl(pb + 18))
	dirid := paramBlkDirID()

	path, errno := hostPath(dirid, ioName, true)
	if errno != 0 {
		return errno
	}

	if stat, err := os.Stat(path); err == nil && !stat.Mode().IsDir() {
		var finfo [16]byte
		copy(finfo[:], mem[pb+32:])
		writeFinderInfo(path, finfo)

		writeMtimeFile(path, readl(pb+76)) // ioFlMdDat
	}

	return 0
}

// More like "get current directory"
// IM documents some subtlety about exactly how hierarchical and flat
// calls interact with each other, which we ignore.
func tGetVol(pb uint32) int {
	trap := readw(d1ptr + 2)

	if trap&0x200 != 0 { // HGetVol
		writew(pb+22, rootID)                          // ioVRefNum
		writel(pb+48, uint32(dirID(dirIDs[curDirID]))) // ioDirID = number
	} else { // plain GetVol
		writew(pb+22, dirID(dirIDs[curDirID])) // ioVRefNum = number
	}

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		mac, _ := macName(platPathBase(dirIDs[curDirID]))
		writePstring(ioVNPtr, mac)
	}

	return 0
}

// "Set current directory", i.e. set dirIDs[curDirID]
func tSetVol(pb uint32) int {
	trap := readw(d1ptr + 2)

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		volname := readPstring(ioVNPtr)
		if !strings.Contains(string(volname), ":") { // this is an absolute path
			volname += ":"
		}

		path, errno := hostPath(2, volname, true)
		if errno != 0 {
			return errno
		}

		dirIDs[curDirID] = path
	} else if trap&0x200 != 0 { // HSetVol
		dirIDs[curDirID] = dirIDs[readw(pb+48+2)] // ioDirID
	} else { // plain SetVol
		dirIDs[curDirID] = dirIDs[readw(pb+22)] // ioVRefNum
	}

	return 0
}

// Return some nonsense about the single volume that we emulate
func tGetVInfo(pb uint32) int {
	ioVNPtr := readl(pb + 18)

	if ioVNPtr != 0 {
		writePstring(ioVNPtr, onlyVolName)
	}
	writew(pb+22, rootID) // ioVRefNum: our "root volume" is 2

	writel(pb+30, 0)      // ioVCrDate
	writel(pb+34, 0)      // ioVLsMod
	writew(pb+38, 0)      // ioVAtrb
	writew(pb+40, 100)    // ioVNmFls
	writew(pb+42, 0)      // ioVBitMap
	writew(pb+44, 0)      // ioVAllocPtr
	writew(pb+46, 0xffff) // ioVNmAlBlks
	writel(pb+48, 0x200)  // ioVAlBlkSiz
	if readw(d1ptr+2)&0x200 != 0 {
		for i := uint32(52); i < 122; i++ {
			writeb(pb+i, 0)
		}

		writel(pb+52, 0x200)  // ioVClpSiz
		writew(pb+56, 0x1000) // ioAlBlSt
		//writel(pb+58, 0) // ioVNxtFNum
		writew(pb+62, 0xfff0) // ioVFrBlk
		writew(pb+64, 0x4244) // ioVSigWord = 'BD'
		//writew(pb+66, 0) // ioVDrvInfo
		writew(pb+68, rootID) // ioVDRefNum
		//writew(pb+70, 0) // ioVFSID
		//writel(pb+72, 0) // ioVBkUp
		//writew(pb+76, 0) // ioVSeqNum
		//writel(pb+78, 0) // ioVWrCnt
		//writel(pb+82, 0) // ioVFilCnt
		//writel(pb+86, 0) // ioVDirCnt
		writel(pb+90, uint32(dirID(systemFolder))) // ioVFndrInfo... must match BootDrive
		// ioVFndrInfo goes to 122
	}

	return 0
}

// The HFSDispatch trap grouped some functions added with HFS
func tFSDispatch(pb uint32) int {
	switch readw(d0ptr + 2) {
	case 1: // OpenWD
		// just return dirID as wdRefNum, because we treat them the same
		ioName := readPstring(readl(pb + 18))
		ioWDDirID := readw(pb + 48 + 2)

		path, errno := hostPath(ioWDDirID, ioName, true)
		if errno != 0 {
			return errno
		}

		ioVRefNum := dirID(path)
		writew(pb+22, ioVRefNum)

	case 2: // CloseWD
		// do nothing

	case 5: // CatMove
		file, errno := hostPath(paramBlkDirID(), readPstring(readl(pb+18)), true)
		if errno != 0 {
			return errno
		}

		dir, errno := hostPath(uint16(readl(pb+36)), readPstring(readl(pb+28)), true)
		if errno != 0 {
			return errno
		}

		// File must not contain dir
		if sameOrChildOf(dir, file) {
			return -122 // badMovErr
		}

		// Dir must be a directory
		dirStat, err := os.Stat(dir)
		if err != nil {
			return -43 // fnfErr
		}
		if !dirStat.Mode().IsDir() {
			return -37 // bdNamErr, attempt to move into a file
		}

		// Dest must not already exist
		newFile := platPathJoin(dir, platPathBase(file))
		if _, err := os.Stat(newFile); err == nil || !os.IsNotExist(err) {
			return -37 // bdNamErr, dest already exists
		}

		// Test what we are moving (need to tweak our data structures later)
		fileStat, err := os.Stat(file)
		if err != nil {
			return -43 // fnfErr
		}
		isDir := fileStat.Mode().IsDir()

		// Do the move!
		err = os.Rename(file, newFile)
		if err != nil {
			if os.IsPermission(err) {
				return -46 // vLckdErr
			} else {
				panic(err)
			}
		}

		// And resource fork, finder info
		if !isDir {
			os.Rename(file+".rdump", newFile+".rdump") // ignore error
			os.Rename(file+".idump", newFile+".idump") // ignore error

			res := platPathJoin(platPathDir(file), "RESOURCE.FRK", platPathBase(file))
			newRes := platPathJoin(platPathDir(newFile), "RESOURCE.FRK", platPathBase(file))
			if _, err := os.Stat(res); err == nil || !os.IsNotExist(err) {
				os.Mkdir(platPathDir(newRes), 0o755)
				os.Rename(res, newRes)
			}

			inf := platPathJoin(platPathDir(file), "FINDER.DAT", platPathBase(file))
			newInf := platPathJoin(platPathDir(newFile), "FINDER.DAT", platPathBase(file))
			if _, err := os.Stat(inf); err == nil || !os.IsNotExist(err) {
				os.Mkdir(platPathDir(newInf), 0o755)
				os.Rename(inf, newInf)
			}
		}

		if isDir {
			for k, v := range openPaths {
				if sameOrChildOf(v.hostpath, file) {
					v.hostpath = newFile + v.hostpath[len(file):]
					openPaths[k] = v
				}
			}
		} else {
			for i, p := range dirIDs {
				if sameOrChildOf(p, file) {
					dirIDs[i] = newFile + p[len(file):]
				}
			}
		}

		// If we moved a folder, then many entries in the cache could have changed,
		// simpler just to delete the cache
		if isDir {
			clearDirCache("")
		} else {
			clearDirCache(platPathDir(file)) // donor dir shorter
			clearDirCache(dir)               // recipient dir longer
		}

	case 6: // DirCreate
		return tCreate(pb)

	case 7: // GetWDInfo
		// the opposite transformation to OpenWD
		writel(pb+48, uint32(readw(pb+22))) // ioWDDirID = ioVRefNum
		writew(pb+32, rootsParentID)        // ioWDVRefNum
		writel(pb+28, 0)                    // ioWDProcID = who cares who created it

	case 8: // GetFCBInfo
		return tGetFCBInfo(pb)

	case 9: // GetCatInfo
		return tGetFInfo(pb)

	case 10: // SetCatInfo
		return tSetFInfo(pb)

	case 26: // OpenDF
		return tOpenDF(pb)

	case 27: // MakeFSSpec
		ioDirID := readw(pb + 48 + 2)
		ioName := readPstring(readl(pb + 18))
		ioMisc := readl(pb + 28)

		path, errno := hostPath(ioDirID, ioName, false)
		if errno != 0 {
			return errno
		}

		writew(ioMisc, rootID) // vRefNum
		writel(ioMisc+2, uint32(dirID(platPathDir(path))))
		writePstring(ioMisc+6, ioName)

	case 48: // GetVolParms
		// Don't care which volume, because there is only one
		ioBuffer := readl(pb + 32)
		ioReqCount := readl(pb + 36)

		var buf = [20]byte{0, 2} // version 2
		// In future, consider flagging support for MoveRename and CopyFile

		ioActCount := copy(mem[ioBuffer:][:ioReqCount], buf[:])
		writel(pb+40, uint32(ioActCount))

	case 56: // OpenDeny
		return tOpenDF(pb)

	case 57: // OpenRFDeny
		return tOpenRF(pb)

	default:
		panic(fmt.Sprintf("Not implemented: _FSDispatch d0=0x%x", readw(d0ptr+2)))
	}

	return 0
}

func sameOrChildOf(inner, outer string) bool {
	return inner == outer || strings.HasPrefix(inner, outer+string(platPathSep))
}
