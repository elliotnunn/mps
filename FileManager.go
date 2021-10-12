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
	for i, component := range components {
		if len(component) == 0 { // treat :: like ..
			path = filepath.Dir(path)
		} else {
			// Fake out the pipe
			if path == mpwFolder && strings.HasPrefix(string(component), "MPW.MinPipe") {
				path = filepath.Join(systemFolder, "Temporary Items")
			}

			// Return a special recognisable (non-slash-prefixed) path for "puppet string" scripts
			if i == len(components)-1 && isPuppetFile(string(component)) {
				return string(component), 0
			}

			// ignore the error because we trust however we got "path"
			listing, _ := listdir(path)

			exists := false
			for _, el := range listing {
				if macUpper(el) == macUpper(component) {
					component = el // use the correct case in the path
					exists = true
					break
				}
			}

			path = filepath.Join(path, macToUnicode(component))

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
	}

	return path, errno
}

func quickFile(path string) (number uint16, name macstring) {
	return get_macos_dnum(filepath.Dir(path)), unicodeToMacOrPanic(filepath.Base(path))
}

func listdir(path string) ([]macstring, int) {
	dirents, err := os.ReadDir(path)
	if err != nil {
		if errors.Is(err, os.ErrNotExist) {
			return nil, -43 // fnfErr
		} else if strings.HasSuffix(err.Error(), "not a directory") {
			return nil, -120 // dirNFErr
		} else {
			panic(err)
		}
	}

	var macfiles []macstring
	for _, d := range dirents {
		if macname, ok := unicodeToMac(d.Name()); ok {
			macfiles = append(macfiles, macstring(macname))
		}
	}

	// HFS sorts files by RelString order
	sort.Slice(macfiles, func(i, j int) bool { return relString(macfiles[i], macfiles[j], false, true) > 1 })

	// Filter out ambiguous or too-long names
	macfiles2 := macfiles
	macfiles = make([]macstring, 0, len(macfiles))
	already := make(map[macstring]int)
	for _, mf := range macfiles2 {
		already[macUpper(mf)]++
	}
	for _, mf := range macfiles2 {
		if already[macUpper(mf)] > 1 {
			continue
		}

		if len(mf) > 31 {
			continue
		}

		if mf[0] == '.' {
			continue
		}

		mfstr := string(mf)
		if strings.HasSuffix(mfstr, ".idump") || strings.HasSuffix(mfstr, ".rdump") {
			continue
		}

		if mfstr == "RESOURCE.FRK" || mfstr == "FINDER.DAT" {
			continue
		}

		macfiles = append(macfiles, mf)
	}

	// what do do about colons in filenames?

	return macfiles, 0
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

func get_macos_date(path string) uint32 {
	return 0
	// logic missing from here
}

func is_regular_file(path string) bool {
	stat, err := os.Stat(path)
	return err == nil && stat.Mode().IsRegular()
}

// Set up param blk fields, but leave d0 alone (contains FSDispatch selector)
// Safe to call more than once
func paramBlkSetup() {
	pb := readl(a0ptr)
	trap := readw(d1ptr + 2)

	writew(pb+6, trap) // ioTrap
	writew(pb+16, 0)   // ioResult = noErr by default
}

// Set ioResult but leave d0 for paramBlkTeardown to set
func paramBlkResult(result int) {
	pb := readl(a0ptr)
	writew(pb+16, uint16(result))
}

// Copy ioResult to d0
// Safe to call more than once
func paramBlkTeardown() {
	pb := readl(a0ptr)
	writel(d0ptr, extwl(readw(pb+16)))
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

func tOpen() {
	paramBlkSetup()
	defer paramBlkTeardown()

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
	pb := readl(a0ptr)

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
		paramBlkResult(errno)
		return // fnfErr
	}

	dirID, name := quickFile(path)

	fkey := forkKey{dirID: dirID, name: name, isRsrc: forkIsRsrc}

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

	writel(fcbPtr+0, 1)              // fake non-zero fcbFlNum
	writeb(fcbPtr+4, flags)          // fcbMdRByt
	writel(fcbPtr+20, kVCB)          // fcbVPtr
	writel(fcbPtr+58, uint32(dirID)) // fcbDirID
	writePstring(fcbPtr+62, name)    // fcbCName

	writew(pb+24, ioRefNum)
}

func tClose() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)

	ioRefNum := readw(pb + 24)
	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramBlkResult(-38)
		return // fnOpnErr
	}

	number := readw(fcb + 58 + 2)
	string := readPstring(fcb + 62)
	path, errno := get_host_path(number, string, false)
	if errno != 0 {
		paramBlkResult(errno)
		return // fnfErr
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
}

func tReadWrite() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)

	ioRefNum := readw(pb + 24)
	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramBlkResult(-38)
		return // fnOpnErr
	}

	fkey := forkKeyFromRefNum(ioRefNum)
	buf := openForks[fkey]

	ioBuffer := readl(pb + 32)
	ioReqCount := readl(pb + 36)
	ioPosMode := readw(pb + 44)
	ioPosOffset := readl(pb + 46)
	fcbCrPs := readl(fcb + 16) // the mark

	var trymark int64
	switch ioPosMode % 4 {
	case 0: // fsAtMark
		trymark = int64(fcbCrPs)
	case 1: // fsFromStart
		trymark = int64(ioPosOffset)
	case 2: // fsFromLEOF
		trymark = int64(len(buf)) + int64(int32(ioPosOffset))
	case 3: // fsFromMark
		trymark = int64(fcbCrPs) + int64(int32(ioPosOffset))
	}

	// assume that mark is inside the file
	mark := uint32(trymark)

	// handle mark outside file and continue
	if trymark > int64(len(buf)) {
		mark = uint32(len(buf))
		ioReqCount = 0
		paramBlkResult(-39) // eofErr
	} else if trymark < 0 {
		mark = 0
		ioReqCount = 0
		paramBlkResult(-40) // posErr
	}

	ioActCount := ioReqCount
	if readl(d1ptr)&0xff == 3 { // _Write
		// if file is too short then lengthen the file
		for uint32(len(buf)) < mark+ioActCount {
			buf = append(buf, 0)
		}

		copy(buf[mark:mark+ioActCount], mem[ioBuffer:ioBuffer+ioActCount])
	} else { // _Read
		// if file is too short then shorten the read
		if uint32(len(buf)) < mark+ioActCount {
			ioActCount = uint32(len(buf)) - mark
		}

		copy(mem[ioBuffer:ioBuffer+ioActCount], buf[mark:mark+ioActCount])
	}

	openForks[fkey] = buf

	writel(pb+40, ioActCount)
	writel(pb+46, mark+ioActCount)  // ioPosOffset
	writel(fcb+16, mark+ioActCount) // fcbCrPs
}

func tGetVInfo() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)
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
}

func tCreate() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)
	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)

	number := get_vol_or_dir()
	path, errno := get_host_path(number, ioName, false)
	if errno != 0 {
		paramBlkResult(errno)
		return
	}

	fp, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0777)
	if err != nil {
		paramBlkResult(-48)
		return // dupFNErr
	}
	defer fp.Close()
}

func tDelete() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)

	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)

	number := get_vol_or_dir()
	path, errno := get_host_path(number, ioName, true)
	if errno != 0 {
		paramBlkResult(errno)
		return
	}

	deleteForks(path)
}

func tGetFInfo() { // also implements GetCatInfo
	paramBlkSetup()
	defer paramBlkTeardown()

	trap := readw(d1ptr + 2)

	pb := readl(a0ptr)
	ioFDirIndex := int16(readw(pb + 28))
	ioNamePtr := readl(pb + 18)

	dirid := get_vol_or_dir()

	// removed "weird case for _HGetFInfo"

	var fname macstring
	return_fname := false

	if trap&0xff == 0x60 && ioFDirIndex < 0 {
		// info about dir specified by ioDirID, ignore ioNamePtr
		return_fname = true
	} else if ioFDirIndex > 0 {
		// info about file specified by ioVRefNum and ioFDirIndex
		return_fname = true

		path, errno := get_host_path(dirid, macstring(""), true)
		if errno != 0 {
			paramBlkResult(errno)
			return
		}

		listing, errno := listdir(path)
		if errno != 0 {
			paramBlkResult(errno)
			return
		}

		if int(ioFDirIndex) >= len(listing) {
			paramBlkResult(-43)
			return // fnfErr
		}

		fname = listing[ioFDirIndex-1]
	} else { // zero or (if GetFInfo) negative
		// info about file specified by ioVRefnum and ioNamePtr
		fname = readPstring(ioNamePtr)
	}

	path, errno := get_host_path(dirid, fname, true)
	if errno != 0 {
		paramBlkResult(errno)
		return
	}

	// at this point, we know that the file exists. let's try listing
	listing, listErr := listdir(path)

	// clear our block of return values, which is longer for GetCatInfo
	endOfReturnValues := 80
	if trap&0xff == 0x60 {
		endOfReturnValues = 108
	}
	for i := 32; i < endOfReturnValues; i++ {
		writeb(pb+uint32(i), 0)
	}

	if return_fname && ioNamePtr != 0 {
		unicodeName := filepath.Base(path)
		if unicodeName == "/" {
			fname = onlyvolname
		} else {
			fname, _ = unicodeToMac(filepath.Base(path))
		}
		writePstring(ioNamePtr, fname)
		// missing logic to switch file separator
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
}

func tSetFInfo() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)
	ioName := readPstring(readl(pb + 18))
	dirid := get_vol_or_dir()

	path, errno := get_host_path(dirid, ioName, true)
	if errno != 0 {
		paramBlkResult(errno)
		return
	}

	if stat, err := os.Stat(path); err == nil && !stat.Mode().IsDir() {
		var finfo [16]byte
		copy(finfo[:], mem[pb+32:])
		writeFinderInfo(path, finfo)

		writeMtime(path, readl(pb+76)) // ioFlMdDat
	}
}

func tGetEOF() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)
	ioRefNum := readw(pb + 24)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramBlkResult(-38)
		return // fnOpnErr
	}

	fkey := forkKeyFromRefNum(ioRefNum)

	writel(pb+28, uint32(len(openForks[fkey]))) // ioMisc
}

func tSetEOF() {
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)
	ioRefNum := readw(pb + 24)
	ioMisc := readl(pb + 28)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramBlkResult(-38)
		return // fnOpnErr
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
}

func tGetVol() {
	paramBlkSetup()
	defer paramBlkTeardown()

	trap := readw(d1ptr + 2)
	pb := readl(a0ptr)

	if trap&0x200 != 0 { // HGetVol
		writew(pb+22, 2)                                // ioVRefNum = 2
		writel(pb+48, uint32(get_macos_dnum(dnums[0]))) // ioDirID = number
	} else { // plain GetVol
		writew(pb+22, get_macos_dnum(dnums[0])) // ioVRefNum = number
	}

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		macstr, _ := unicodeToMac(filepath.Base(dnums[0]))
		writePstring(ioVNPtr, macstr)
	}
}

func tSetVol() {
	paramBlkSetup()
	defer paramBlkTeardown()

	trap := readw(d1ptr + 2)
	pb := readl(a0ptr)

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		volname := readPstring(ioVNPtr)
		if !strings.Contains(string(volname), ":") { // this is an absolute path
			volname += ":"
		}

		path, errno := get_host_path(2, volname, true)
		if errno != 0 {
			paramBlkResult(errno)
			return
		}

		dnums[0] = path
	} else if trap&0x200 != 0 { // HSetVol
		dnums[0] = dnums[readw(pb+48+2)] // ioDirID
	} else { // plain SetVol
		dnums[0] = dnums[readw(pb+22)] // ioVRefNum
	}
}

func tGetFPos() {
	// Act like _Read with ioReqCount=0 and ioPosMode=fsAtMark
	pb := readl(a0ptr)
	writel(pb+32, 0) // ioBuffer
	writel(pb+36, 0) // ioReqCount
	writew(pb+44, 0) // ioPosMode
	tReadWrite()
}

func tSetFPos() {
	// Act like _Read with ioReqCount=0
	pb := readl(a0ptr)
	writel(pb+32, 0) // ioBuffer
	writel(pb+36, 0) // ioReqCount
	tReadWrite()
}

func tFSDispatch() {
	// These might get called twice, which is harmless
	paramBlkSetup()
	defer paramBlkTeardown()

	pb := readl(a0ptr)

	switch readw(d0ptr + 2) {
	case 1: // OpenWD
		// just return dirID as wdRefNum, because we treat them the same
		ioName := readPstring(readl(pb + 18))
		ioWDDirID := readw(pb + 48 + 2)

		path, errno := get_host_path(ioWDDirID, ioName, true)
		if errno != 0 {
			paramBlkResult(errno)
			return
		}

		ioVRefNum := get_macos_dnum(path)
		writew(pb+22, ioVRefNum)

	case 2: // CloseWD
		// do nothing

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
					paramBlkResult(-38)
					return // fnOpnErr
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
			paramBlkResult(-38)
			return // fnOpnErr
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
		tGetFInfo()

	case 10: // SetCatInfo
		tSetFInfo()

	case 26: // OpenDF
		tOpen()

	case 27: // MakeFSSpec
		ioDirID := readw(pb + 48 + 2)
		ioName := readPstring(readl(pb + 18))
		ioMisc := readl(pb + 28)

		path, errno := get_host_path(ioDirID, ioName, false)
		if errno != 0 {
			paramBlkResult(errno)
			return // fnfErr
		}

		writew(ioMisc, 2) // vRefNum = 2 always
		writel(ioMisc+2, uint32(get_macos_dnum(filepath.Dir(path))))
		writePstring(ioMisc+6, ioName)

	default:
		panic(fmt.Sprintf("Not implemented: _FSDispatch d0=0x%x", readw(d0ptr+2)))
	}
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
