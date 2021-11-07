package main

import (
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"
)

// a number for each directory encountered, usable as wdrefnum.w or dirid.l
var dnums = []string{
	"/", // current directory
	"",  // parent of root, never used
	"/", // root
}

// the contents of every open fork
var openForks = make(map[forkKey][]byte)
var openForkRefCounts = make(map[forkKey]int)

type forkKey struct {
	dirID  uint16
	name   macstring
	isRsrc bool
}

type forkVal struct {
	buf      []byte
	refCount int
}

func forkKeyFromRefNum(refNum uint16) forkKey {
	fcb := fcbFromRefnum(refNum)
	if fcb == 0 {
		panic("invalid fcb")
	}

	return forkKey{
		dirID:  readw(fcb + 60),
		name:   readPstring(fcb + 62),
		isRsrc: readb(fcb+4)&2 != 0,
	}
}

// MacOS's idea of the system root
const onlyvolname macstring = "_"

// return 0 if invalid
func fcbFromRefnum(refnum uint16) uint32 {
	FSFCBLen := readw(0x3f6)
	FCBSPtr := readl(0x34e)

	if refnum/FSFCBLen >= 348 || refnum%FSFCBLen != 2 {
		return 0
	}

	return FCBSPtr + uint32(refnum)
}

func get_host_path(number uint16, name macstring, leafMustExist bool) (string, int) {
	// If string is abolute then ignore the number, use the special root ID
	if strings.Contains(string(name), ":") && !strings.HasPrefix(string(name), ":") {
		number = 2
		root_and_name := strings.SplitN(string(name), ":", 2)
		name = macstring(root_and_name[1])

		if macstring(root_and_name[0]) != onlyvolname {
			return "", -43 // fnfErr
		}
	}

	if int(number) > len(dnums) {
		panic(fmt.Sprintf("Bogus dirID %02x", number))
	}
	path := dnums[number]

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
		name := namePair{mac, host}

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

// "hostName" must *also* run the tests in this function
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

type namePair struct {
	mac  macstring
	host string
}

func readDir(path string) ([]namePair, int) {
	f, err := os.Open(path)
	if err != nil {
		if errors.Is(err, os.ErrNotExist) {
			return nil, -43 // fnfErr
		} else {
			panic(err)
		}
	}

	dirents, err := f.ReadDir(-1)
	if err != nil {
		if err.(*os.PathError).Err.Error() == "not a directory" {
			return nil, -120 // dirNFErr
		} else {
			panic(err)
		}
	}

	slice := make([]namePair, 0, len(dirents))
	for _, d := range dirents {
		host := d.Name()
		mac, ok := macName(host)
		if ok {
			slice = append(slice, namePair{mac, host})
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

func get_macos_dnum(path string) uint16 {
	for idx, maybepath := range dnums[2:] {
		if maybepath == path {
			return uint16(idx) + 2
		}
	}
	dnums = append(dnums, path)
	return uint16(len(dnums)) - 1
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

func get_vol_or_dir() (num uint16) {
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

func read_fsspec(ptr uint32) (vRefNum uint16, dirID uint32, namePtr uint32) {
	return readw(ptr), readl(ptr + 2), ptr + 6 // pointer to name string only
}

func fsspec_to_pb(fsspec uint32, pb uint32) {
	vRefNum, dirID, namePtr := read_fsspec(fsspec)
	writew(pb+22, vRefNum) // ioVRefNum
	writel(pb+48, dirID)   // ioDirID
	writel(pb+18, namePtr) // ioNamePtr
}

func tOpen(pb uint32) int {
	writew(pb+24, 0) // clear ioRefNum

	// Find a free FCB
	var ioRefNum uint16
	var fcbPtr uint32
	for ioRefNum = 2; fcbFromRefnum(ioRefNum) != 0; ioRefNum += readw(0x3f6) {
		fcbPtr = readl(0x34e) + uint32(ioRefNum)
		if readl(fcbPtr) == 0 {
			break
		}
	}

	if readl(fcbPtr) != 0 {
		panic("FCB table exhausted by 348 open files")
	}

	forkIsRsrc := readl(d1ptr)&0xff == 0xa

	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)
	ioPermssn := readb(pb + 27)

	number := get_vol_or_dir()

	// Checks for file existence
	path, errno := get_host_path(number, ioName, true)

	// If fnfErr and we are allowed to create the file, then create it
	if errno == -43 && ioPermssn != 1 {
		writeDataFork(path, nil)
		errno = 0 // handled the case, so noErr
	}

	if errno != 0 {
		return errno
	}

	// Canonical dirID and name
	number = get_macos_dnum(filepath.Dir(path))
	ioName, _ = macName(filepath.Base(path))

	fkey := forkKey{dirID: number, name: ioName, isRsrc: forkIsRsrc}

	if openForkRefCounts[fkey] == 0 {
		var buf []byte
		if isPuppetFile(path) { // special name
			buf = puppetFile(path)
		} else if forkIsRsrc {
			buf = resourceFork(path)
		} else {
			buf = dataFork(path)
		}
		openForks[fkey] = buf
	}

	openForkRefCounts[fkey]++

	flags := byte(0)
	if ioPermssn != 1 {
		flags |= 1
	}
	if forkIsRsrc {
		flags |= 2
	}

	writel(fcbPtr+0, 1)               // fake non-zero fcbFlNum
	writeb(fcbPtr+4, flags)           // fcbMdRByt
	writel(fcbPtr+20, kVCB)           // fcbVPtr
	writel(fcbPtr+58, uint32(number)) // fcbDirID
	writePstring(fcbPtr+62, ioName)   // fcbCName

	writew(pb+24, ioRefNum)
	return 0
}

func tClose(pb uint32) int {
	ioRefNum := readw(pb + 24)
	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		return -38 // fnOpnErr
	}

	number := readw(fcb + 58 + 2)
	string := readPstring(fcb + 62)
	path, errno := get_host_path(number, string, false)
	if errno != 0 {
		return errno
	}

	// Write out
	fcbMdRByt := readb(fcb + 4)

	fkey := forkKeyFromRefNum(ioRefNum)

	// When the refcount reaches zero, write out
	openForkRefCounts[fkey]--
	if openForkRefCounts[fkey] == 0 {
		buf := openForks[fkey]

		if fcbMdRByt&1 != 0 {
			if fcbMdRByt&2 == 0 {
				writeDataFork(path, buf)
			} else {
				writeResourceFork(path, buf)
			}
		}

		delete(openForks, fkey)
	}

	// Free FCB
	for i := uint32(0); i < uint32(readw(0x3f6)); i++ {
		writel(fcb+i, 0)
	}
	return 0
}

func tReadWrite(pb uint32) (result int) {
	isWrite := readb(d1ptr+3) == 3

	ioRefNum := readw(pb + 24)
	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		return -38 // fnOpnErr
	}

	fkey := forkKeyFromRefNum(ioRefNum)
	fileBuf := openForks[fkey]
	eof := int32(len(fileBuf))

	ioBuffer := readl(pb + 32)
	ioReqCount := int32(readl(pb + 36))
	ioPosMode := readw(pb + 44)
	ioPosOffset := int32(readl(pb + 46))
	fcbCrPs := int32(readl(fcb + 16)) // the mark

	switch ioPosMode % 4 {
	case 0: // fsAtMark
		// ignore ioPosOffset
	case 1: // fsFromStart
		fcbCrPs = ioPosOffset
	case 2: // fsFromLEOF
		fcbCrPs = eof + ioPosOffset
	case 3: // fsFromMark
		fcbCrPs += ioPosOffset
	}

	ioActCount := ioReqCount
	if fcbCrPs > eof {
		fcbCrPs = eof // don't go past end
		result = -39  // eofErr
		ioActCount = 0
	} else if fcbCrPs+ioActCount > eof && !isWrite {
		result = -39 // eofErr
		ioActCount = eof - fcbCrPs
	} else if fcbCrPs < 0 {
		result = -40 // posErr
		ioActCount = 0
	}

	writel(pb+40, uint32(ioActCount))          // ioActCount
	writel(pb+46, uint32(fcbCrPs+ioActCount))  // ioPosOffset
	writel(fcb+16, uint32(fcbCrPs+ioActCount)) // fcbCrPs

	// Early return to prevent memory access panic from nonsense ioBuffer
	if ioActCount == 0 {
		return
	}

	memBuf := mem[ioBuffer:][:ioActCount]

	if isWrite { // _Write
		if fcbCrPs+ioActCount > eof {
			fileBuf = append(fileBuf[:fcbCrPs], memBuf...)
		} else {
			copy(fileBuf[fcbCrPs:], memBuf)
		}
	} else { // _Read
		copy(memBuf, fileBuf[fcbCrPs:])
	}

	openForks[fkey] = fileBuf
	return
}

func tGetVInfo(pb uint32) int {
	ioVNPtr := readl(pb + 18)

	if ioVNPtr != 0 {
		writePstring(ioVNPtr, onlyvolname)
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
		writel(pb+52, 0x200)                                // ioVClpSiz
		writew(pb+56, 0x1000)                               // ioAlBlSt
		writel(pb+58, 0)                                    // ioVNxtFNum
		writew(pb+62, 0xfff0)                               // ioVFrBlk
		writew(pb+64, 0)                                    // ioVSig2
		writew(pb+66, 0)                                    // ioVDrvInfo
		writew(pb+68, 2)                                    // ioVDRefNum
		writew(pb+70, 0)                                    // ioVFSID
		writel(pb+72, 0)                                    // ioVBkUp
		writew(pb+76, 0)                                    // ioVSeqNum
		writel(pb+78, 0)                                    // ioVWrCnt
		writel(pb+82, 0)                                    // ioVFilCnt
		writel(pb+86, 0)                                    // ioVDirCnt
		write(32, pb+90, 0)                                 // ioVFndrInfo
		writel(pb+90, uint32(get_macos_dnum(systemFolder))) // must match BootDrive
	}

	return 0
}

func tCreate(pb uint32) int {
	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)

	number := get_vol_or_dir()
	path, errno := get_host_path(number, ioName, true)
	switch errno {
	case 0: // noErr: already exists
		return -48 // dupFNErr
	case -43: // fnfErr: create the file/folder
		if readb(d1ptr+3) == 0x60 { // DirCreate
			os.Mkdir(path, 0o755)
			writel(pb+48, uint32(get_macos_dnum(path))) // return ioDirID
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

	number := get_vol_or_dir()
	path, errno := get_host_path(number, ioName, true)
	if errno != 0 {
		return errno
	}

	deleteForks(path)

	return 0
}

func tGetFInfo(pb uint32) int { // also implements GetCatInfo
	trap := readw(d1ptr + 2)

	ioFDirIndex := int16(readw(pb + 28))
	ioNamePtr := readl(pb + 18)

	dirid := get_vol_or_dir()

	// removed "weird case for _HGetFInfo"

	returnIOName := false
	path := ""

	if trap&0xff == 0x60 && ioFDirIndex < 0 {
		// folder "dirID" alone
		path = dnums[dirid]
		returnIOName = true
	} else if ioFDirIndex > 0 {
		// file number "ioFDirIndex" within "dirID"
		returnIOName = true

		path = dnums[dirid]

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
		subPath, errno := get_host_path(dirid, readPstring(ioNamePtr), true)
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
		mac := onlyvolname
		if host != "/" {
			mac, _ = macName(host)
		}
		writePstring(ioNamePtr, mac)
	}

	if listErr == 0 { // folder
		writeb(pb+30, 1<<4)                         // is a directory
		writel(pb+48, uint32(get_macos_dnum(path))) // ioDrDirID
		writel(pb+52, uint32(len(listing)))         // ioDrNmFls
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
			parID = uint32(get_macos_dnum(filepath.Dir(path)))
		}
		writel(pb+100, parID) // ioFlParID
	}

	t := mtime(path)
	writel(pb+72, t) // ioFlCrDat
	writel(pb+76, t) // ioFlMdDat

	return 0
}

func tSetFInfo(pb uint32) int {
	ioName := readPstring(readl(pb + 18))
	dirid := get_vol_or_dir()

	path, errno := get_host_path(dirid, ioName, true)
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

func tGetEOF(pb uint32) int {
	ioRefNum := readw(pb + 24)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		return -38 // fnOpnErr
	}

	fkey := forkKeyFromRefNum(ioRefNum)

	writel(pb+28, uint32(len(openForks[fkey]))) // ioMisc
	return 0
}

func tSetEOF(pb uint32) int {
	ioRefNum := readw(pb + 24)
	ioMisc := readl(pb + 28)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		return -38 // fnOpnErr
	}

	fkey := forkKeyFromRefNum(ioRefNum)
	buf := openForks[fkey]

	for uint32(len(buf)) < ioMisc {
		buf = append(buf, 0)
	}

	if uint32(len(buf)) > ioMisc {
		buf = buf[:ioMisc]
	}

	openForks[fkey] = buf

	if ioMisc < readl(fcb+16) { // can't have mark beyond eof
		writel(fcb+16, ioMisc)
	}
	return 0
}

func tGetVol(pb uint32) int {
	trap := readw(d1ptr + 2)

	if trap&0x200 != 0 { // HGetVol
		writew(pb+22, 2)                                // ioVRefNum = 2
		writel(pb+48, uint32(get_macos_dnum(dnums[0]))) // ioDirID = number
	} else { // plain GetVol
		writew(pb+22, get_macos_dnum(dnums[0])) // ioVRefNum = number
	}

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		mac, ok := macName(filepath.Base(dnums[0]))
		if !ok {
			panic("macName failed on a path in dnums")
		}
		writePstring(ioVNPtr, mac)
	}

	return 0
}

func tSetVol(pb uint32) int {
	trap := readw(d1ptr + 2)

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		volname := readPstring(ioVNPtr)
		if !strings.Contains(string(volname), ":") { // this is an absolute path
			volname += ":"
		}

		path, errno := get_host_path(2, volname, true)
		if errno != 0 {
			return errno
		}

		dnums[0] = path
	} else if trap&0x200 != 0 { // HSetVol
		dnums[0] = dnums[readw(pb+48+2)] // ioDirID
	} else { // plain SetVol
		dnums[0] = dnums[readw(pb+22)] // ioVRefNum
	}

	return 0
}

func tGetFPos(pb uint32) int {
	// Act like _Read with ioReqCount=0 and ioPosMode=fsAtMark
	writel(pb+36, 0) // ioReqCount
	writew(pb+44, 0) // ioPosMode
	return tReadWrite(pb)
}

func tSetFPos(pb uint32) int {
	// Act like _Read with ioReqCount=0
	writel(pb+36, 0) // ioReqCount
	return tReadWrite(pb)
}

func tFSDispatch(pb uint32) int {
	// These might get called twice, which is harmless
	switch readw(d0ptr + 2) {
	case 1: // OpenWD
		// just return dirID as wdRefNum, because we treat them the same
		ioName := readPstring(readl(pb + 18))
		ioWDDirID := readw(pb + 48 + 2)

		path, errno := get_host_path(ioWDDirID, ioName, true)
		if errno != 0 {
			return errno
		}

		ioVRefNum := get_macos_dnum(path)
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
		ioFCBIndx := readw(pb + 28)
		ioRefNum := readw(pb + 24)

		if ioFCBIndx > 0 { // treat as a 1-based index into open FCBs
			for ioRefNum = 2; ; ioRefNum += readw(0x3f6) {
				fcb := fcbFromRefnum(ioRefNum)
				if fcb == 0 {
					return -38 // fnOpnErr
				}

				if readl(fcb) != 0 { // if open then decrement the index
					ioFCBIndx--
				}

				if ioFCBIndx == 0 { // we found our match!
					break
				}
			}
		}

		fcb := fcbFromRefnum(ioRefNum)
		if fcb == 0 || readl(fcb) == 0 {
			return -38 // fnOpnErr
		}

		for i := uint32(0); i < 20; i++ {
			writeb(pb+32+i, readb(fcb+i))
		}

		writew(pb+24, ioRefNum)
		writew(pb+52, 2)             // ioFCBVRefNum
		writel(pb+54, 0)             // ioFCBClpSiz, don't care
		writel(pb+58, readl(fcb+58)) // ioFCBParID

		ioNamePtr := readl(pb + 18)
		writePstring(ioNamePtr, readPstring(fcb+62))

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

		path, errno := get_host_path(ioDirID, ioName, false)
		if errno != 0 {
			return errno
		}

		writew(ioMisc, 2) // vRefNum = 2 always
		writel(ioMisc+2, uint32(get_macos_dnum(filepath.Dir(path))))
		writePstring(ioMisc+6, ioName)

	default:
		panic(fmt.Sprintf("Not implemented: _FSDispatch d0=0x%x", readw(d0ptr+2)))
	}

	return 0
}

func tHighLevelFSDispatch() {
	selector := readb(d0ptr + 3)
	switch selector {
	case 1: // pascal OSErr FSMakeFSSpec(short vRefNum, long dirID, ConstStr255Param fileName, FSSpecPtr spec)
		specPtr := popl()
		ioNamePtr := popl()
		ioDirID := popl()
		ioVRefNum := popw()

		push(128, 0)
		pb := readl(spptr)
		writel(a0ptr, pb)
		writew(pb+22, ioVRefNum)
		writel(pb+48, ioDirID)
		writel(pb+18, ioNamePtr)
		writel(pb+28, specPtr) // ioMisc

		writel(d0ptr, 0x1b)                 // MakeFSSpec selector...
		call_m68k(executable_atrap(0xa260)) // FSDispatch
		pop(128)

		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 2, 3: // pascal OSErr FSpOpenDF/RF(const FSSpec *spec, char permission, short *refNum)
		refNumPtr := popl()
		ioPermssn := popb()
		specPtr := popl()

		push(128, 0)
		pb := readl(spptr)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))   // ioVRefNum
		writel(pb+48, readl(specPtr+2)) // ioDirID
		writel(pb+18, specPtr+6)        // ioNamePtr
		writeb(pb+27, ioPermssn)

		if selector == 2 { // FSpOpenDF
			writel(d0ptr, 0x1a)                 // OpenDF selector...
			call_m68k(executable_atrap(0xa260)) // FSDispatch
		} else { // FSpOpenRF
			call_m68k(executable_atrap(0xa20a)) // OpenRF
		}
		ioRefNum := readw(pb + 24)
		pop(128)

		writew(refNumPtr, ioRefNum)
		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 5: // pascal OSErr FSpDirCreate(const FSSpec *spec, ScriptCode scriptTag, long *createdDirID)
		idPtr := popl()
		popw() // discard scriptTag
		specPtr := popl()

		push(128, 0)
		pb := readl(spptr)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))   // ioVRefNum
		writel(pb+48, readl(specPtr+2)) // ioDirID
		writel(pb+18, specPtr+6)        // ioNamePtr

		writel(d0ptr, 6)                    // DirCreate selector
		call_m68k(executable_atrap(0xa260)) // FSDispatch
		ioDirID := readl(pb + 48)
		pop(128)

		if readw(d0ptr+2) == 0 {
			writel(idPtr, ioDirID)
		}
		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 7: // pascal OSErr FSpGetFInfo(const FSSpec *spec, FInfo *fndrInfo)
		fInfoPtr := popl()
		specPtr := popl()

		push(128, 0)
		pb := readl(spptr)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))   // ioVRefNum
		writel(pb+48, readl(specPtr+2)) // ioDirID
		writel(pb+18, specPtr+6)        // ioNamePtr

		call_m68k(executable_atrap(0xa20c)) // _HGetFInfo

		copy(mem[fInfoPtr:][:16], mem[pb+32:][:16]) // ioFlFndrInfo
		pop(128)

		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 8: // pascal OSErr FSpSetFInfo(const FSSpec *spec, const FInfo *fndrInfo)
		fInfoPtr := popl()
		specPtr := popl()

		push(128, 0)
		pb := readl(spptr)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))               // ioVRefNum
		writel(pb+48, readl(specPtr+2))             // ioDirID
		writel(pb+18, specPtr+6)                    // ioNamePtr
		copy(mem[pb+32:][:16], mem[fInfoPtr:][:16]) // ioFlFndrInfo

		call_m68k(executable_atrap(0xa20d)) // _HSetFInfo
		pop(128)

		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 13: // pascal short FSpOpenResFile(const FSSpec *spec, char permission)
		perm := popb()
		specPtr := popl()

		pushw(readw(specPtr))     // vRefNum
		pushl(readl(specPtr + 2)) // dirID
		pushl(specPtr + 6)        // namePtr
		pushb(perm)

		call_m68k(executable_atrap(0xac1a)) // _HOpenResFile ,autoPop
		// and the result will be left on the stack for us

	default:
		panic(fmt.Sprintf("Not implemented: _HighLevelFSDispatch d0=0x%x", selector))
	}
}
