package main

import (
    "path/filepath"
    "embed"
    "strings"
    "os"
    "io/fs"
    "sort"
)

//go:embed MPW35
var embedMPW embed.FS

// a number for each directory encountered, usable as wdrefnum.w or dirid.l
var dnums []string

// gets populated by main func
var systemFolder string

// the contents of every open fork, indexed by refnum
var filebuffers map[uint16][]byte

// MacOS's idea of the system root
var onlyvolname = "_"

type myFS interface {
    fs.FS
    fs.ReadDirFS
    fs.ReadFileFS
}

// Could apply to either filesystem
func open(path string) (fs.File, error) {
    prefix := string(systemFolder) + "/MPW/"
    if strings.HasPrefix(path, prefix) {
        file, err := embedMPW.Open(path[len(prefix):])
        return file, err
    } else {
        file, err := os.Open(path)
        return file, err
    }
}

// return 0 if invalid
func fcbFromRefnum(refnum uint16) uint32 {
    FSFCBLen := readw(0x3f6)
    FCBSPtr := readl(0x34e)

    if refnum / FSFCBLen >= 348 || refnum % FSFCBLen != 2 {
        return 0
    }

    return FCBSPtr + uint32(refnum)
}

func get_host_path(number uint16, macname macstring) (string, int) {
    name := macToUnicode(macname)

    // If string is abolute then ignore the number, use the special root ID
    if strings.Contains(name, ":") && !strings.HasPrefix(name, ":") {
        number = 2
        root_and_name := strings.SplitN(name, ":", 2)
        name = root_and_name[1]

        if root_and_name[0] != onlyvolname {
            return "", -43 // fnfErr
        }
    }

    if int(number) > len(dnums) {
        return "", -32 // fnfErr
    }
    path := dnums[number]

    components := strings.Split(name, ":")

    // remove stray empty components, because they behave like '..'
    if len(components) > 0 && len(components[0]) == 0 {
        components = components[1:]
    }
    if len(components) > 0 && len(components[len(components) - 1]) == 0 {
        components = components[:len(components) - 1]
    }

    for _, component := range components {
        unicomponent := macToUnicode(component)
        if len(unicomponent) > 0 {
            path = filepath.Join(path, unicomponent)
        } else {
            path = filepath.Dir(path)
        }
    }

    return path, 0 // noErr
}

func listdir(path string) ([]macstring, int) {
    file, err := open(path)
    if err != nil {
        return nil, -43 // fileNotFoundError
    }
    defer file.Close()

    dir, ok := file.(fs.ReadDirFile)
    if !ok {
        panic("Failed to cast and get a method! Sad!")
    }

    dirents, err := dir.ReadDir(0)
    if err != nil {
        panic("ReadDirNames")
    }

//     macfiles := make([]macstring, 0, len(dirents))
    var macfiles []macstring
    for _, d := range dirents {
        if macname, ok := unicodeToMac(d.Name()); ok {
            macfiles = append(macfiles, macstring(macname))
        }
    }

    // HFS sorts files by RelString order
    sort.Slice(macfiles, func (i, j int) {return relString(macfiles[i], macfiles[j], false, true) > 1})

    // Filter out ambiguous or too-long names
    macfiles2 := macfiles
    macfiles = make([]macstring, 0, len(macfiles))
    already := make(map[macstring]int)
    for _, mf := range macfiles2 {
        already[macUpper(mf)]++
    }
    for _, mf := range macfiles2 {
        if already[macUpper(mf)] == 1 && len(mf) < 32 {
            macfiles = append(macfiles, mf)
        }
    }

    // what do do about colons in filenames?

    return macfiles, 0
}

func get_macos_dnum(path string) uint16 {
    for idx, maybepath := range dnums[2:] {
        if maybepath == path {
            return idx + 2
        }
    }
    dnums = append(dnums, path)
    return len(dnums) - 1
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
    writew(readl(a0ptr) + 16, uint16(int16(result)))
    writel(d0ptr, uint32(int32(result))) // sign extension
}

func get_vol_or_dir() (num uint16) {
    pb := readl(a0ptr)
    trap := readl(d1ptr)

    if trap & 0x200 != 0 {
        num = readw(pb + 48 + 2) // lower word of dirID
    }
    if num == 0 {
        num = readw(pb + 22) // whole vRefNum
    }
}

func read_fsspec(ptr uint32) (vRefNum uint16, dirID uint32, namePtr uint32) {
    return readw(ptr), readl(ptr + 2), ptr + 6 // pointer to name string only
}

func fsspec_to_pb(fsspec uint32, pb uint32) {
    vRefNum, dirID, namePtr := read_fsspec(fsspec)
    writew(pb + 22, vRefNum) // ioVRefNum
    writel(pb + 48, dirID) // ioDirID
    writel(pb + 18, namePtr) // ioNamePtr
}

func tOpen() {
    paramblk_return(0) // by default

    fork := 'd'
    if readl(d1ptr) & 0xff == 0xa {
        fork = 'r'
    }

    pb := read4(a0ptr)

    ioNamePtr := readl(pb + 18)
    ioName := readPstring(ioNamePtr)
    ioPermssn := readb(pb + 27)

    number := get_vol_or_dir()

    path := get_host_path(number, ioName)
    if !is_regular_file(path) {
        paramblk_return(-39); return // fnfErr
    }

    var ioRefNum uint16
    var fcbPtr uint32
    for ioRefNum = 2; fcbFromRefnum(ioRefNum) != 0; ioRefNum += read2(0x3f6) {
        fcbPtr = read4(0x34e) + ioRefNum
        if read4(fcbPtr) != 0 {
            break
        }
    }
    // -42 // tmfoErr ??????

    var data []byte
    if fork == 'd' {
        data = os.ReadFile(path)
    } else if fork == 'r' {
        // Try various resource fork schemes, fall back on empty fork
        if rpath := filepath.Join(filepath.Dir(path), "RESOURCE.FRK", filepath.Base(path)); is_regular_file(rpath) {
            data = os.ReadFile(rpath)
        } else if rpath := path + ".rdump"; is_regular_file(rpath) {
            data = rez(rpath)
        }
    }

    flags := 0
    if ioPermssn != 1 {
        flags |= 1
    }
    if fork == 'r' {
        flags |= 2
    }

    filebuffers[ioRefNum] = data
    for i := 0; i < read2(0x3f6); i++ {
        writel(fcbPtr + i, 0) // zero the block for safety
    }
    writel(fcbPtr + 0, 1) // fake non-zero fcbFlNum
    writeb(fcbPtr + 4, flags) // fcbMdRByt
    writel(fcbPtr + 8, len(data)) // fcbEOF
    writel(fcbPtr + 20, 0xa8000) // fcbVPtr
    writel(fcbPtr + 58, uint32(get_macos_dnum(path.parent))) // fcbDirID
    write_pstring(fcbPtr + 62, strings.Replace(path.name, ":", -1)) // fcbCName

    writew(pb + 24, ioRefNum)
}

func tClose() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    ioRefNum := readw(pb + 24)
    fcb := fcbFromRefnum(ioRefNum)
    if fcb == 0 || readl(fcb) == 0 {
        paramblk_return(-38); return // fnOpnErr
    }

    number := readl(fcb + 58)
    string := readPstring(fcb + 62)
    path := get_host_path(number, string)

    // Write out
    fcbMdRByt := readb(fcb + 4)
    buf := filebuffers[ioRefNum]
    delete(filebuffers, ioRefNum)
    if fcbMdRByt & 1 {
        os.WriteFile(path, buf)
    }

    // Free FCB
    for i := 0; i < read2(0x3f6); i++ {
        writel(fcbPtr + i, 0)
    }
}

func tReadWrite() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    ioRefNum := readw(pb + 24)
    fcb := fcbFromRefnum(ioRefNum)
    if fcb == 0 || readl(fcb) == 0 {
        paramblk_return(-38); return // fnOpnErr
    }

    buf := &filebuffers[ioRefNum]
    ioBuffer := readl(pb + 32)
    ioReqCount := readl(pb + 36)
    ioPosMode := readw(pb + 44)
    ioPosOffset := readl(pb + 46)
    fcbCrPs = readl(fcb + 16) // the mark
    fcbEOF = readl(fcb + 8) // leof

    if fcbEOF != len(buf) { // totally effed
        panic("recorded fcbEOF inconsistent with byte slice size")
    }

    var trymark int64
    switch ioPosMode % 4 {
    case 0: // fsAtMark
        trymark = int64(fcbCrPs)
    case 1: // fsFromStart
        trymark = int64(ioPosOffset)
    case 2: // fsFromLEOF
        trymark = int64(fcbEOF) + int32(ioPosOffset)
    case 3: // fsFromMark
        trymark = int64(fcbCrPs) + int32(ioPosOffset)
    }

    // assume that mark is inside the file
    mark := uint32(trymark)

    // handle mark outside file and continue
    if trymark > fcbEOF {
        mark = fcbEOF
        ioReqCount = 0
        paramblk_return(-39) // eofErr
    } else if trymark < 0 {
        mark = 0
        ioReqCount = 0
        paramblk_return(-40) // posErr
    }

    ioActCount := ioReqCount
    if readl(d1ptr) & 0xff == 3 { // _Write
        // if file is too short then lengthen the file
        for len(buf) < mark + ioActCount {
            *buf = append(*buf, 0)
        }
        writel(fcb + 8, len(buf)) // fcbEOF needs to be updated

        copy(buf[mark:mark+ioActCount], mem[ioBuffer:ioBuffer+ioActCount])

    } else { // _Read
        // if file is too short then shorten the read
        if len(buf) < mark + ioActCount {
            ioActCount = len(buf) - mark
        }

        copy(mem[ioBuffer:ioBuffer+ioActCount], buf[mark:mark+ioActCount])
    }

    writel(pb + 40, ioActCount)
    writel(pb + 46, mark + ioActCount) // ioPosOffset
    writel(fcb + 16, mark + ioActCount) // fcbCrPs
}

func tGetVInfo() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioVNPtr := readl(pb + 18)

    if ioVNPtr != 0 {
        write_pstring(ioVNPtr, unicodeToMac(onlyvolname))
    }
    writew(pb + 22, 2) // ioVRefNum: our "root volume" is 2

    writel(pb + 30, 0) // ioVCrDate
    writel(pb + 34, 0) // ioVLsMod
    writew(pb + 38, 0) // ioVAtrb
    writew(pb + 40, 100) // ioVNmFls
    writew(pb + 42, 0) // ioVBitMap
    writew(pb + 44, 0) // ioVAllocPtr
    writew(pb + 46, 0xffff) // ioVNmAlBlks
    writel(pb + 48, 0x200) // ioVAlBlkSiz
    if trap & 0x200 != 0 {
        writel(pb + 52, 0x200) // ioVClpSiz
        writew(pb + 56, 0x1000) // ioAlBlSt
        writel(pb + 58, 0) // ioVNxtFNum
        writew(pb + 62, 0xfff0) // ioVFrBlk
        writew(pb + 64, 0) // ioVSig2
        writew(pb + 66, 0) // ioVDrvInfo
        writew(pb + 68, 2) // ioVDRefNum
        writew(pb + 70, 0) // ioVFSID
        writel(pb + 72, 0) // ioVBkUp
        writew(pb + 76, 0) // ioVSeqNum
        writel(pb + 78, 0) // ioVWrCnt
        writel(pb + 82, 0) // ioVFilCnt
        writel(pb + 86, 0) // ioVDirCnt
        write(32, pb + 90, 0) // ioVFndrInfo
        writel(pb + 90, uint32(get_macos_dnum(systemFolder))) // must match BootDrive
    }
}

func tCreate() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioNamePtr := readl(pb + 18)
    ioName := readPstring(ioNamePtr)

    number := get_vol_or_dir()
    path := get_host_path(number, ioName)

    fp, err := os.OpenFile(path, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0777)
    if err != nil {
        paramblk_return(-48); return // dupFNErr
    }
    defer fd.Close()
}

func tDelete() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    ioNamePtr = readl(pb + 18)
    ioName := readPstring(ioNamePtr)

    number := get_vol_or_dir()
    path := get_host_path(number, ioName)

    os.Remove(path)
}

func tGetFInfo() { // also implements GetCatInfo
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioFDirIndex := int16(readw(pb + 28))
    ioNamePtr = readl(pb + 18)

    dirid := get_vol_or_dir()

    // removed "weird case for _HGetFInfo"

    fname := []byte("")
    return_fname := false

    if trap & 0xff == 0x60 && ioFDirIndex < 0 {
        return_fname = true
    } else if ioFDirIndex > 0 {
        return_fname = true

        path, errno := get_host_path(number)
        if errno != 0 {
            paramblk_return(errno); return
        }

        listing, errno := listdir(path)
        if errno != 0 {
            paramblk_return(errno); return
        }

        if ioFDirIndex >= len(listing) {
            paramblk_return(-43); return // fnfErr
        }

        fname = listing[ioFDirIndex - 1]
    } else {
        fname = readPstring(ioNamePtr)
    }

    // clear our block of return values, which is longer for GetCatInfo
    for i := 0; (trap & 0xff == 0x60 && i < 84) || (i < 56); i++ {
        writeb(pb + 24 + i, 0)
    }

    path, errno := get_host_path(dirid, fname)
    if errno != 0 {
        paramblk_return(errno); return
    }

    if return_fname && ioNamePtr != 0 {
        write_pstring(ioNamePtr, fname)
        // missing logic to switch file separator
    }

    if !is_regular_file(path) {
        writeb(pb + 30, 1 << 4) // is a directory
        writel(pb + 48, uint32(get_macos_dnum(path))) // ioDrDirID
        writel(pb + 52, len(listdir(path))) // ioDrNmFls
    } else {
        // missing quite a bit of logic here
    }

    if trap & 0xff == 0x60 {
        writel(pb + 100, unt32(get_macos_dnum(filepath.Dir(path)))) // ioFlParID
    }

    date := get_macos_date(p)
    writel(pb + 72, date) // ioFlCrDat
    writel(pb + 76, date) // ioFlMdDat
}

func tSetFInfo() {
    paramblk_return(0)
//     ioNamePtr := readl(pb + 18)
//     ioName := readPstring(ioNamePtr)
//
//     // idiom to get dirID for hierarchical call, but fall back on ioVRefNum
//     number := (readl(pb + 48) if trap & 0x200 else 0) || readw(pb + 22)
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
        paramblk_return(-38); return // fnOpnErr
    }

    writel(pb + 28, readl(fcb + 8)) // ioMisc = fcbEOF
}

func tSetEOF() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioRefNum := readw(pb + 24)
    ioMisc := readl(pb + 28)

    fcb := fcbFromRefnum(ioRefNum)
    if fcb == 0 || readl(fcb) == 0 {
        paramblk_return(-38); return // fnOpnErr
    }

    for len(filebuffers[ioRefNum]) < ioMisc {
        filebuffers[ioRefNum] = append(filebuffers[ioRefNum], 0)
    }

    if len(filebuffers[ioRefNum]) > ioMisc {
        filebuffers[ioRefNum] = filebuffers[ioRefNum][:ioMisc]
    }

    writel(fcb + 8, ioMisc) // fcbEOF

    if ioMisc < readl(fcb + 16) { // can't have mark beyond eof
        writel(fcb + 16, ioMisc)
    }
}

func tGetVol() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    if trap & 0x200 != 0 { // HGetVol
        writew(pb + 22, 2) // ioVRefNum = 2
        writel(pb + 48, uint32(get_macos_dnum(dnums[0]))) // ioDirID = number
    } else { // plain GetVol
        writew(pb + 22, get_macos_dnum(dnums[0])) // ioVRefNum = number
    }

    ioVNPtr := readl(pb + 18)
    if ioVNPtr != 0 {
        write_pstring(ioVNPtr, unicodeToMac(filepath.Base(dnums[0])))
    }
}

func tSetVol() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    ioRefNum := readw(pb + 24)

    ioVNPtr := readl(pb + 18)
    if ioVNPtr != 0 {
        volname := readPstring(ioVNPtr)
        if !strings.Contains(volname, ":") { // this is an absolute path
            volname += ":"
        }
        dnums[0] = get_host_path(2, volname)
    } else if trap & 0x200 != 0 { // HSetVol
        dnums[0] = dnums[readl(pb + 48)] // ioDirID
    } else { // plain SetVol
        dnums[0] = dnums[readw(pb + 22)] // ioVRefNum
    }
}

func tGetFPos() {
    // Act like _Read with ioReqCount=0 and ioPosMode=fsAtMark
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    writel(pb + 36, 0)
    writew(pb + 44, 0) // ioPosMode
    tReadWrite()
}

func tSetFPos() {
    // Act like _Read with ioReqCount=0
    paramblk_return(0) // by default
    pb := readl(a0ptr)
    writel(pb + 36, 0) // ioReqCount
    tReadWrite()
}

func tFSDispatch() {
    paramblk_return(0) // by default
    pb := readl(a0ptr)

    switch readw(d0ptr + 2) {
    case 1: // OpenWD
        // just return dirID as wdRefNum, because we treat them the same
        ioName := readPstring(readl(pb + 18))
        ioWDDirID := readl(pb + 48)

        ioVRefNum := get_macos_dnum(get_host_path(ioWDDirID, ioName))
        writew(pb + 22, ioVRefNum)

    case 2: // CloseWD
        // do nothing

    case 7: // GetWDInfo
        // the opposite transformation to OpenWD
        writel(pb + 48, uint32(readw(pb + 22))) // ioWDDirID = ioVRefNum
        writew(pb + 32, 2) // ioWDVRefNum = 2 (our root)
        writel(pb + 28, 0) // ioWDProcID = who cares who created it

    case 8: // GetFCBInfo
        ioFCBIndx := readl(pb + 28)

        ioRefNum := readw(pb + 24)
        if ioFCBIndx != 0 { // treat as a 1-based index into open FCBs
            for ioRefNum = 2;; ioRefNum += read2(0x3f6) {
                fcb := fcbFromRefnum(ioRefNum)
                if fcb == 0 {
                    paramblk_return(-38); return // fnOpnErr
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
            paramblk_return(-38); return // fnOpnErr
        }

        for i := 0; i < 2; i++ {
            writeb(pb + 20 + i, readb(fcb + i))
        }

        writew(pb + 24, ioRefNum)
        writew(pb + 52, 2) // ioFCBVRefNum
        writel(pb + 54, 0) // ioFCBClpSiz, don't care
        writel(pb + 58, readl(fcb + 58)) // ioFCBParID

        ioNamePtr := readl(pb + 18)
        write_pstring(ioNamePtr, readPstring(fcb + 62))

    case 9: // GetCatInfo
        return tGetFInfo()

    case 26: // OpenDF
        return tOpen()

    case 27: // MakeFSSpec
        ioVRefNum := readw(pb + 22)
        ioDirID := readl(pb + 48)
        ioName := readPstring(readl(pb + 18))
        ioMisc := readl(pb + 28)

        path := get_host_path(ioDirID, ioName)

        // The parent must exist
        if _, err := os.Stat(filepath.Dir(path)); os.IsNotExist(err) {
            paramblk_return(-39); return // fnfErr
        }

        writew(ioMisc, 2) // vRefNum = 2 always
        writel(ioMisc + 2, uint32(get_macos_dnum(filepath.Dir(path))))
        write_pstring(ioMisc + 6, unicodeToMac(filepath.Base(path)))

    default:
        panic(str.Sprintf("Not implemented: _FSDispatch d0=0x%x", readw(d0ptr + 2)))
    }
}
