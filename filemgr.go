/*
Give the MacOS environment a reasonable view of the host filesystem.

The relationship of MacOS filenames to host filenames is:
    different-case macnames : one true macname : multiple hostnames

Converting hostname>macname in practice only happens when listing a directory.
Non-representable names are ignored. Hostnames differing only in case or Unicode
normalisation have conflicting macnames: these cause a panic.
It is worth preserving the exact hostname used, so readDir returns structs
with both macname and hostname.

Converting macname>hostname requires a full directory listing, which is filtered
for the matching hostname.

We emulate a system with a single mounted volume, exposing the system root.
What to do on Windows?

MacOS commonly refers to directories by a 32-bit catalog node ID or "dirID".
For compatibility with pre-HFS apps, the system kept a limited array of
"working directories", which mapped between 32-bit dirID and 16-bit volume ID.
For simplicity, we map these two IDs 1:1 (ignore the high part of dirID).
Host directory paths are appended to a global slice as they are encountered,
and their index gives the dirID.

0, 1 and 2 are reserved, for reasons documented in the slice declaration.

File CNIDs exist but are not needed by the APIs, so not implemented.
*/

package main

import (
	"errors"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"sort"
	"strings"
)

// The single volume
const (
	onlyVolName = macstring("_")
	onlyVRefNum = 2
)

// Directories appended here as they are encountered, starting with ID 3
var dirIDs = []string{
	// a nil dirID/vRefNum means "current dir/vol"
	"/",
	// 1 is returned when asking about the "parent" of root
	"",
	// the dirID of the root of an HFS volume is 2
	// convenient to also consider the vRefNum as 2
	"/",
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
	// Disallow nulls, newlines, other control characters
	for _, char := range []byte(host) {
		if char < 0x20 || char == 0x7f {
			return "", false
		}
	}

	for _, char := range []byte(host) {
		if os.IsPathSeparator(char) {
			panic("path separator passed to macName")
		}
	}

	// Unix "and:or" appears as Mac "and/or"
	host = strings.ReplaceAll(host, ":", "/")

	// This test more to prevent a Mac app from creating one of these names
	if host == "." || host == ".." {
		return "", false
	}
	// ... could also test for WinNT forbidden names?

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

	// We interconvert between : and /
	// but this means we cannot allow Windows \
	for _, char := range []byte(host) {
		if char != '/' && os.IsPathSeparator(char) {
			return "", false
		}
	}

	// Mac "and/or" appears as Unix "and:or"
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
func hostPath(number uint16, name macstring, leafMustExist bool) (string, int) {
	// If string is abolute then ignore the number, use the special root ID
	if strings.Contains(string(name), ":") && !strings.HasPrefix(string(name), ":") {
		number = 2
		root_and_name := strings.SplitN(string(name), ":", 2)
		name = macstring(root_and_name[1])

		if macstring(root_and_name[0]) != onlyVolName {
			return "", -43 // fnfErr
		}
	}

	path := dirIDs[number]

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

	errno := 0
	for i, mac := range components {
		if len(mac) == 0 { // treat :: like ..
			path = filepath.Dir(path)
			continue
		}

		// Fake out the pipe
		if path == mpwFolder && strings.HasPrefix(string(mac), "MPW.MinPipe") {
			path = filepath.Join(systemFolder, "Temporary Items")
		}

		// Return a special recognisable (non-slash-prefixed) path for "puppet string" scripts
		if i == len(components)-1 && isPuppetFile(string(mac)) {
			return string(mac), 0
		}

		// List the directory to find the matching unix name
		listing, _ := readDir(path)

		host, ok := hostName(mac)
		if !ok {
			return "", -37 // bdNamErr
		}
		name := existingNamePair{mac, host}

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
		path = filepath.Join(path, name.host)

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

// Return a mac and host-format directory listing
// The hostnames are exact, including Unicode normalisation
// The macnames are guaranteed valid and in RelString order
func readDir(path string) ([]existingNamePair, int) {
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
		mac, ok := macName(host)
		if ok {
			slice = append(slice, existingNamePair{mac, host})
		}
	}

	// HFS sorts files by RelString order
	sort.Slice(slice, func(i, j int) bool { return relString(slice[i].mac, slice[j].mac, false, true) > 1 })

	for i := 0; i < len(slice)-1; i++ {
		if relString(slice[i].mac, slice[i+1].mac, false, true) == 0 {
			logf("Indistinguishably named files in %s:\n  %s\n  %s\n", path, slice[i].host, slice[i+1].host)
			os.Exit(1)
		}
	}

	return slice, 0
}

type existingNamePair struct {
	mac  macstring
	host string
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

	return 0
}

// A bit like stat
func tGetFInfo(pb uint32) int { // also GetCatInfo
	trap := readw(d1ptr + 2)

	ioFDirIndex := int16(readw(pb + 28))
	ioNamePtr := readl(pb + 18)

	dirid := paramBlkDirID()

	// removed "weird case for _HGetFInfo"

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

		listing, errno := readDir(path)
		if errno != 0 {
			panic("readDir failed on a safe path")
		}

		if int(ioFDirIndex) > len(listing) {
			return -43 // fnfErr
		}

		path = filepath.Join(path, listing[ioFDirIndex-1].host)
	} else { // zero or (if GetFInfo) negative
		// file named "ioNamePtr" within "dirID"
		subPath, errno := hostPath(dirid, readPstring(ioNamePtr), true)
		if errno != 0 { // could be nonexistent
			return errno
		}
		path = subPath
	}

	// at this point, we know that the file exists. let's try listing
	listing, listErr := readDir(path)

	// clear our block of return values, which is longer for GetCatInfo
	endOfReturnValues := 80
	if trap&0xff == 0x60 {
		endOfReturnValues = 108
	}
	for i := 30; i < endOfReturnValues; i++ {
		writeb(pb+uint32(i), 0)
	}

	if returnIOName && ioNamePtr != 0 {
		host := filepath.Base(path)
		mac := onlyVolName
		if host != "/" {
			mac, _ = macName(host)
		}
		writePstring(ioNamePtr, mac)
	}

	if listErr == 0 { // folder
		writeb(pb+30, 1<<4)                 // is a directory
		writel(pb+48, uint32(dirID(path)))  // ioDrDirID
		writel(pb+52, uint32(len(listing))) // ioDrNmFls
	} else { // file
		finfo := finderInfo(path)
		copy(mem[pb+32:], finfo[:]) // ioFlFndrInfo (16b)

		// hack to make puppet-string scripts executable
		if isPuppetFile(path) {
			copy(mem[pb+32:], "TEXTMPS ")
		}
	}

	if trap&0xff == 0x60 {
		parID := uint32(1) // parent of root
		if path != filepath.Dir(path) {
			parID = uint32(dirID(filepath.Dir(path)))
		}
		writel(pb+100, parID) // ioFlParID
	}

	t := mtime(path)
	writel(pb+72, t) // ioFlCrDat
	writel(pb+76, t) // ioFlMdDat

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

		writeMtime(path, readl(pb+76)) // ioFlMdDat
	}

	return 0
}

// More like "get current directory"
// IM documents some subtlety about exactly how hierarchical and flat
// calls interact with each other, which we ignore.
func tGetVol(pb uint32) int {
	trap := readw(d1ptr + 2)

	if trap&0x200 != 0 { // HGetVol
		writew(pb+22, 2)                        // ioVRefNum = 2
		writel(pb+48, uint32(dirID(dirIDs[0]))) // ioDirID = number
	} else { // plain GetVol
		writew(pb+22, dirID(dirIDs[0])) // ioVRefNum = number
	}

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		mac, ok := macName(filepath.Base(dirIDs[0]))
		if !ok {
			panic("macName failed on a path in dirIDs")
		}
		writePstring(ioVNPtr, mac)
	}

	return 0
}

// "Set current directory", i.e. set dirIDs[0]
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

		dirIDs[0] = path
	} else if trap&0x200 != 0 { // HSetVol
		dirIDs[0] = dirIDs[readw(pb+48+2)] // ioDirID
	} else { // plain SetVol
		dirIDs[0] = dirIDs[readw(pb+22)] // ioVRefNum
	}

	return 0
}

// Return some nonsense about the single volume that we emulate
func tGetVInfo(pb uint32) int {
	ioVNPtr := readl(pb + 18)

	if ioVNPtr != 0 {
		writePstring(ioVNPtr, onlyVolName)
	}
	writew(pb+22, 2) // ioVRefNum: our "root volume" is 2

	writel(pb+30, 0)      // ioVCrDate
	writel(pb+34, 0)      // ioVLsMod
	writew(pb+38, 0)      // ioVAtrb
	writew(pb+40, 100)    // ioVNmFls
	writew(pb+42, 0)      // ioVBitMap
	writew(pb+44, 0)      // ioVAllocPtr
	writew(pb+46, 0xffff) // ioVNmAlBlks
	writel(pb+48, 0x200)  // ioVAlBlkSiz
	if readw(d1ptr+2)&0x200 != 0 {
		writel(pb+52, 0x200)                       // ioVClpSiz
		writew(pb+56, 0x1000)                      // ioAlBlSt
		writel(pb+58, 0)                           // ioVNxtFNum
		writew(pb+62, 0xfff0)                      // ioVFrBlk
		writew(pb+64, 0)                           // ioVSig2
		writew(pb+66, 0)                           // ioVDrvInfo
		writew(pb+68, 2)                           // ioVDRefNum
		writew(pb+70, 0)                           // ioVFSID
		writel(pb+72, 0)                           // ioVBkUp
		writew(pb+76, 0)                           // ioVSeqNum
		writel(pb+78, 0)                           // ioVWrCnt
		writel(pb+82, 0)                           // ioVFilCnt
		writel(pb+86, 0)                           // ioVDirCnt
		write(32, pb+90, 0)                        // ioVFndrInfo
		writel(pb+90, uint32(dirID(systemFolder))) // must match BootDrive
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

	case 6: // DirCreate
		return tCreate(pb)

	case 7: // GetWDInfo
		// the opposite transformation to OpenWD
		writel(pb+48, uint32(readw(pb+22))) // ioWDDirID = ioVRefNum
		writew(pb+32, 2)                    // ioWDVRefNum = 2 (our root)
		writel(pb+28, 0)                    // ioWDProcID = who cares who created it

	case 8: // GetFCBInfo
		return tGetFCBInfo(pb)

	case 9: // GetCatInfo
		return tGetFInfo(pb)

	case 10: // SetCatInfo
		return tSetFInfo(pb)

	case 26: // OpenDF
		return tOpen(pb)

	case 27: // MakeFSSpec
		ioDirID := readw(pb + 48 + 2)
		ioName := readPstring(readl(pb + 18))
		ioMisc := readl(pb + 28)

		path, errno := hostPath(ioDirID, ioName, false)
		if errno != 0 {
			return errno
		}

		writew(ioMisc, 2) // vRefNum = 2 always
		writel(ioMisc+2, uint32(dirID(filepath.Dir(path))))
		writePstring(ioMisc+6, ioName)

	case 48: // GetVolParms
		// Don't care which volume, because there is only one
		ioBuffer := readl(pb + 32)
		ioReqCount := readl(pb + 36)

		var buf = [20]byte{0, 2} // version 2
		// In future, consider flagging support for MoveRename and CopyFile

		ioActCount := copy(mem[ioBuffer:][:ioReqCount], buf[:])
		writel(pb+40, uint32(ioActCount))

	default:
		panic(fmt.Sprintf("Not implemented: _FSDispatch d0=0x%x", readw(d0ptr+2)))
	}

	return 0
}
