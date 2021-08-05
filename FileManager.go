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
var dnums []string

// gets populated by main func
var systemFolder string

// the contents of every open fork, indexed by refnum
var filebuffers = make(map[uint16][]byte)

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
		return "", -43 // fnfErr
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

	for i, component := range components {
		if len(component) == 0 { // treat :: like ..
			path = filepath.Dir(path)
		} else {
			listing, listErr := listdir(path)
			if listErr != 0 {
				return "", listErr
			}

			exists := false
			for _, el := range listing {
				if macUpper(el) == macUpper(component) {
					component = el // use the correct case in the path
					exists = true
					break
				}
			}

			if !exists { // can tolerate a nonexistent leaf file if instructed
				if i <= len(components)-1 || leafMustExist {
					return "", -32 // fnfErr
				}
			}

			path = filepath.Join(path, macToUnicode(component))
		}
	}

	return path, 0 // noErr
}

func listdir(path string) ([]macstring, int) {
	dirents, err := gFS.ReadDir(path)
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
		if already[macUpper(mf)] == 1 && len(mf) < 32 && mf[0] != '.' {
			macfiles = append(macfiles, mf)
		}
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

func paramblk_return(result int) {
	writew(readl(a0ptr)+16, uint16(int16(result)))
	writel(d0ptr, uint32(int32(result))) // sign extension
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
	forkIsRsrc := readl(d1ptr)&0xff == 0xa
	pb := readl(a0ptr)

	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)
	ioPermssn := readb(pb + 27)

	number := get_vol_or_dir()

	// Checks for file existence
	path, errno := get_host_path(number, ioName, true)

	if gDebug >= 2 {
		fmt.Printf("tOpen n=%x ioName=%s ioPermssn=%d i.e. %s %d\n", number, string(ioName), ioPermssn, path, errno)
	}

	if errno != 0 {
		paramblk_return(errno)
		return // fnfErr
	}

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
		panic("Too many files/forks open (hundreds)")
		paramblk_return(-42)
		return // tmfoErr
	}

	var data []byte
	if forkIsRsrc {
		data = resourceFork(path)
	} else {
		data = dataFork(path)
	}

	flags := byte(0)
	if ioPermssn != 1 {
		flags |= 1
	}
	if forkIsRsrc {
		flags |= 2
	}

	filebuffers[ioRefNum] = data
	writel(fcbPtr+0, 1)                                           // fake non-zero fcbFlNum
	writeb(fcbPtr+4, flags)                                       // fcbMdRByt
	writel(fcbPtr+8, uint32(len(data)))                           // fcbEOF
	writel(fcbPtr+20, 0xa8000)                                    // fcbVPtr
	writel(fcbPtr+58, uint32(get_macos_dnum(filepath.Dir(path)))) // fcbDirID
	macpath, _ := unicodeToMac(filepath.Base(path))               // we already know it is safe
	writePstring(fcbPtr+62, macpath)                              // fcbCName

	writew(pb+24, ioRefNum)
	paramblk_return(0) // by default
}

func tClose() {
	paramblk_return(0) // by default
	pb := readl(a0ptr)

	ioRefNum := readw(pb + 24)
	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramblk_return(-38)
		return // fnOpnErr
	}

	number := readw(fcb + 58 + 2)
	string := readPstring(fcb + 62)
	path, errno := get_host_path(number, string, true)
	if errno != 0 {
		paramblk_return(errno)
		return // fnfErr
	}

	// Write out
	fcbMdRByt := readb(fcb + 4)
	buf := filebuffers[ioRefNum]
	delete(filebuffers, ioRefNum)
	if fcbMdRByt&1 != 0 {
		os.WriteFile(path, buf, 0o777)
	}

	// Free FCB
	writel(fcb, 0)
	//     for i := 0; i < readw(0x3f6); i++ {
	//         writel(fcbPtr + i, 0)
	//     }
}

func closeAll() {
	for ioRefNum := uint16(2); fcbFromRefnum(ioRefNum) != 0; ioRefNum += readw(0x3f6) {
		if readl(fcbFromRefnum(ioRefNum)) != 0 {
			push(128, 0)
			pb := readl(spptr)
			writel(a0ptr, pb)
			writew(pb+24, ioRefNum)
			tClose() // too late to bother patching traps
			pop(128)
		}
	}
}

func tReadWrite() {
	paramblk_return(0) // by default
	pb := readl(a0ptr)

	ioRefNum := readw(pb + 24)
	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramblk_return(-38)
		return // fnOpnErr
	}

	buf := filebuffers[ioRefNum]
	ioBuffer := readl(pb + 32)
	ioReqCount := readl(pb + 36)
	ioPosMode := readw(pb + 44)
	ioPosOffset := readl(pb + 46)
	fcbCrPs := readl(fcb + 16) // the mark
	fcbEOF := readl(fcb + 8)   // leof

	if fcbEOF != uint32(len(buf)) { // totally effed
		panic("recorded fcbEOF inconsistent with byte slice size")
	}

	var trymark int64
	switch ioPosMode % 4 {
	case 0: // fsAtMark
		trymark = int64(fcbCrPs)
	case 1: // fsFromStart
		trymark = int64(ioPosOffset)
	case 2: // fsFromLEOF
		trymark = int64(fcbEOF) + int64(int32(ioPosOffset))
	case 3: // fsFromMark
		trymark = int64(fcbCrPs) + int64(int32(ioPosOffset))
	}

	// assume that mark is inside the file
	mark := uint32(trymark)

	// handle mark outside file and continue
	if trymark > int64(fcbEOF) {
		mark = fcbEOF
		ioReqCount = 0
		paramblk_return(-39) // eofErr
	} else if trymark < 0 {
		mark = 0
		ioReqCount = 0
		paramblk_return(-40) // posErr
	}

	ioActCount := ioReqCount
	if readl(d1ptr)&0xff == 3 { // _Write
		// if file is too short then lengthen the file
		for uint32(len(buf)) < mark+ioActCount {
			buf = append(buf, 0)
		}
		writel(fcb+8, uint32(len(buf))) // fcbEOF needs to be updated

		copy(buf[mark:mark+ioActCount], mem[ioBuffer:ioBuffer+ioActCount])

	} else { // _Read
		// if file is too short then shorten the read
		if uint32(len(buf)) < mark+ioActCount {
			ioActCount = uint32(len(buf)) - mark
		}

		copy(mem[ioBuffer:ioBuffer+ioActCount], buf[mark:mark+ioActCount])
	}

	filebuffers[ioRefNum] = buf

	writel(pb+40, ioActCount)
	writel(pb+46, mark+ioActCount)  // ioPosOffset
	writel(fcb+16, mark+ioActCount) // fcbCrPs
}

func tGetVInfo() {
	paramblk_return(0) // by default
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
	paramblk_return(0) // by default
	pb := readl(a0ptr)
	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)

	number := get_vol_or_dir()
	path, errno := get_host_path(number, ioName, false)
	if errno != 0 {
		paramblk_return(errno)
		return
	}

	fp, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0777)
	if err != nil {
		paramblk_return(-48)
		return // dupFNErr
	}
	defer fp.Close()
}

func tDelete() {
	paramblk_return(0) // by default
	pb := readl(a0ptr)

	ioNamePtr := readl(pb + 18)
	ioName := readPstring(ioNamePtr)

	number := get_vol_or_dir()
	path, errno := get_host_path(number, ioName, true)
	if errno != 0 {
		paramblk_return(errno)
		return
	}

	os.Remove(path)
}

func tGetFInfo() { // also implements GetCatInfo
	trap := readw(d1ptr + 2)

	paramblk_return(0) // by default
	pb := readl(a0ptr)
	ioFDirIndex := int16(readw(pb + 28))
	ioNamePtr := readl(pb + 18)

	dirid := get_vol_or_dir()

	// removed "weird case for _HGetFInfo"

	var fname macstring
	return_fname := false

	if trap&0xff == 0x60 && ioFDirIndex < 0 {
		// info about dir specified by ioDirID, ignore ioNamePtr
		if gDebug >= 2 {
			x, _ := get_host_path(dirid, macstring(""), true)
			fmt.Printf("GetCatInfo of dir=%d (%s)\n", dirid, x)
		}

		return_fname = true
	} else if ioFDirIndex > 0 {
		// info about file specified by ioVRefNum and ioFDirIndex
		if gDebug >= 2 {
			x, _ := get_host_path(dirid, macstring(""), false)
			fmt.Printf("GetF/CatInfo of\n  vol/dir=%d (%s),\n  idx=%d\n", dirid, x, ioFDirIndex)
		}

		return_fname = true

		path, errno := get_host_path(dirid, macstring(""), true)
		if errno != 0 {
			paramblk_return(errno)
			return
		}

		listing, errno := listdir(path)
		if errno != 0 {
			paramblk_return(errno)
			return
		}

		if int(ioFDirIndex) >= len(listing) {
			paramblk_return(-43)
			return // fnfErr
		}

		fname = listing[ioFDirIndex-1]
	} else { // zero or (if GetFInfo) negative
		// info about file specified by ioVRefnum and ioNamePtr
		fname = readPstring(ioNamePtr)

		if gDebug >= 2 {
			x, _ := get_host_path(dirid, macstring(""), false)
			fmt.Printf("GetF/CatInfo vol/dir=%d (%s),\n  name=%s\n", dirid, x, macToUnicode(fname))
		}
	}

	path, errno := get_host_path(dirid, fname, true)
	if errno != 0 {
		paramblk_return(errno)
		return
	}

	// at this point, we know that the file exists. let's try listing
	listing, listErr := listdir(path)
	if listErr != 0 && listErr != -120 { // accept noErr and dirNFErr (i.e. is file)
		paramblk_return(listErr)
		return
	}

	// clear our block of return values, which is longer for GetCatInfo
	for i := uint32(0); (trap&0xff == 0x60 && i < 84) || (i < 56); i++ {
		writeb(pb+24+i, 0)
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
	}

	if trap&0xff == 0x60 {
		parID := uint32(1) // parent of root
		if path != filepath.Dir(path) {
			parID = uint32(get_macos_dnum(filepath.Dir(path)))
		}
		writel(pb+100, parID) // ioFlParID
	}

	writel(pb+72, 0xf0000000) // ioFlCrDat
	writel(pb+76, 0xf0000000) // ioFlMdDat
}

func tSetFInfo() {
	paramblk_return(0)
	//     ioNamePtr := readl(pb + 18)
	//     ioName := readPstring(ioNamePtr)
	//
	//     // idiom to get dirID for hierarchical call, but fall back on ioVRefNum
	//     number := (readw(pb + 48 + 2) if trap & 0x200 else 0) || readw(pb + 22)
	//
	//     path = get_host_path(number=number, string=ioName)
	//     if !path.exists() { // fnfErr
	//         return -43
	//     }
	//     idump = path.parent / (path.name + ".idump")
	//     typecreator = mem[a0+32:a0+40]
	//     if typecreator != b"????????" || idump.exists() {
	//         idump.write_bytes(typecreator)
	//     }
	//     // todo: mtime
}

func tGetEOF() {
	paramblk_return(0) // by default
	pb := readl(a0ptr)
	ioRefNum := readw(pb + 24)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramblk_return(-38)
		return // fnOpnErr
	}

	writel(pb+28, readl(fcb+8)) // ioMisc = fcbEOF
}

func tSetEOF() {
	paramblk_return(0) // by default
	pb := readl(a0ptr)
	ioRefNum := readw(pb + 24)
	ioMisc := readl(pb + 28)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		paramblk_return(-38)
		return // fnOpnErr
	}

	for uint32(len(filebuffers[ioRefNum])) < ioMisc {
		filebuffers[ioRefNum] = append(filebuffers[ioRefNum], 0)
	}

	if uint32(len(filebuffers[ioRefNum])) > ioMisc {
		filebuffers[ioRefNum] = filebuffers[ioRefNum][:ioMisc]
	}

	writel(fcb+8, ioMisc) // fcbEOF

	if ioMisc < readl(fcb+16) { // can't have mark beyond eof
		writel(fcb+16, ioMisc)
	}
}

func tGetVol() {
	trap := readw(d1ptr + 2)

	paramblk_return(0) // by default
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
	trap := readw(d1ptr + 2)

	paramblk_return(0) // by default
	pb := readl(a0ptr)

	ioVNPtr := readl(pb + 18)
	if ioVNPtr != 0 {
		volname := readPstring(ioVNPtr)
		if !strings.Contains(string(volname), ":") { // this is an absolute path
			volname += ":"
		}

		path, errno := get_host_path(2, volname, true)
		if errno != 0 {
			paramblk_return(errno)
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
	pb := readl(a0ptr)

	switch readw(d0ptr + 2) {
	case 1: // OpenWD
		// just return dirID as wdRefNum, because we treat them the same
		ioName := readPstring(readl(pb + 18))
		ioWDDirID := readw(pb + 48 + 2)

		path, errno := get_host_path(ioWDDirID, ioName, true)
		if errno != 0 {
			paramblk_return(errno)
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
			if gDebug >= 2 {
				fmt.Printf("GetFCBInfo of %d-th FCB\n", ioFCBIndx)
			}

			for ioRefNum = 2; ; ioRefNum += readw(0x3f6) {
				fcb := fcbFromRefnum(ioRefNum)
				if fcb == 0 {
					paramblk_return(-38)
					return // fnOpnErr
				}

				if readl(fcb) != 0 { // if open then decrement the index
					ioFCBIndx--
				}

				if ioFCBIndx == 0 { // we found our match!
					break
				}
			}

		} else {
			if gDebug >= 2 {
				fmt.Printf("GetFCBInfo ioRefNum=%d\n", ioRefNum)
			}
		}

		fcb := fcbFromRefnum(ioRefNum)
		if fcb == 0 || readl(fcb) == 0 {
			paramblk_return(-38)
			return // fnOpnErr
		}

		if gDebug >= 2 {
			fmt.Printf("  FCB is %s\n", macToUnicode(readPstring(fcb+62)))
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
		return // to avoid paramblk_return

	case 26: // OpenDF
		tOpen()
		return // to avoid paramblk_return

	case 27: // MakeFSSpec
		ioDirID := readw(pb + 48 + 2)
		ioName := readPstring(readl(pb + 18))
		ioMisc := readl(pb + 28)

		path, errno := get_host_path(ioDirID, ioName, false)
		if errno != 0 {
			paramblk_return(errno)
			return // fnfErr
		}

		writew(ioMisc, 2) // vRefNum = 2 always
		writel(ioMisc+2, uint32(get_macos_dnum(filepath.Dir(path))))
		writePstring(ioMisc+6, ioName)

		if gDebug >= 2 {
			fmt.Printf("MakeFSSpec ... vRefNum=%d dirID=%d name=%s\n", readw(ioMisc), readl(ioMisc+2), macToUnicode(readPstring(ioMisc+6)))
		}

	default:
		panic(fmt.Sprintf("Not implemented: _FSDispatch d0=0x%x", readw(d0ptr+2)))
	}

	paramblk_return(0) // by default
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

		writew(readl(spptr), readw(d0ptr)) // return osErr

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
		writew(readl(spptr), readw(d0ptr)) // return osErr
	}
}
