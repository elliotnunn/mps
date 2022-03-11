/*
IO for open files

Each "access path" has a refNum (16-bit signed) and a file control block (FCB)
at FCBSPtr + refNum. RefNum limits us to 348 FCBs, which we keep in low memory.

We emulate FCBs because some programs disobey IM and access them directly.

Whole forks are slurped into memory when opened, and written out when closed.
There can be multiple access paths to a fork, so we need a mechanism to share
fork buffers between access paths.

Globals for application use:
	34e .L FCBSPtr to the base of the FCB array
	3f6 .W FSFCBLen = 94, a positive number indicates HFS installed

The size of the FCB table is stored in a word at the base of the table.
*/

package main

import (
	"path/filepath"
)

// the contents of every open fork
var openBuffers = make(map[uint16]*[]byte)
var openPaths = make(map[uint16]forkPath)

func forkRefNum(f forkPath) (uint16, bool) {
	for refNum := uint16(2); refNum < 0x8000; refNum += 94 {
		if openPaths[refNum] == f {
			return refNum, true
		}
	}
	return 0, false
}

type forkPath struct {
	hostpath string
	isRsrc   bool
}

// return 0 if invalid
func fcbFromRefnum(refnum uint16) uint32 {
	FSFCBLen := readw(0x3f6)
	FCBSPtr := readl(0x34e)

	if refnum/FSFCBLen >= 348 || refnum%FSFCBLen != 2 {
		return 0
	}

	return FCBSPtr + uint32(refnum)
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

	number := paramBlkDirID()

	// Checks for file existence
	path, errno := hostPath(number, ioName, true)

	// If fnfErr and we are allowed to create the file, then create it
	if errno == -43 && ioPermssn != 1 {
		writeDataFork(path, nil)
		errno = 0 // handled the case, so noErr
	}

	if errno != 0 {
		return errno
	}

	// Canonical dirID and name
	number = dirID(filepath.Dir(path))
	ioName, _ = macName(filepath.Base(path))

	forkPath := forkPath{hostpath: path, isRsrc: forkIsRsrc}
	oldRefNum, ok := forkRefNum(forkPath)
	if ok {
		openBuffers[ioRefNum] = openBuffers[oldRefNum]
	} else {
		var buf []byte
		if isPuppetFile(path) { // special name
			buf = puppetFile(path)
		} else if forkIsRsrc {
			buf = resourceFork(path)
		} else {
			buf = dataFork(path)
		}
		openBuffers[ioRefNum] = &buf
	}

	openPaths[ioRefNum] = forkPath

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

	// Write out
	fcbMdRByt := readb(fcb + 4)

	// When the refcount reaches zero, write out
	path := openPaths[ioRefNum]
	buf := openBuffers[ioRefNum]
	delete(openPaths, ioRefNum)
	delete(openBuffers, ioRefNum)

	if _, stillOpen := forkRefNum(path); !stillOpen {
		if fcbMdRByt&1 != 0 {
			if path.isRsrc {
				writeResourceFork(path.hostpath, *buf)
			} else {
				writeDataFork(path.hostpath, *buf)
			}
		}
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

	fileBuf := openBuffers[ioRefNum]
	eof := int32(len(*fileBuf))

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
			*fileBuf = append((*fileBuf)[:fcbCrPs], memBuf...)
		} else {
			copy((*fileBuf)[fcbCrPs:], memBuf)
		}
	} else { // _Read
		copy(memBuf, (*fileBuf)[fcbCrPs:])
	}

	return
}

func tAllocate(pb uint32) (result int) {
	ioRefNum := readw(pb + 24)
	ioReqCount := readl(pb + 36)

	ioActCount := (ioReqCount + 0x1ff) &^ 0x1ff // round up to multiple 512

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		return -38 // fnOpnErr
	}

	fileBuf := openBuffers[ioRefNum]
	*fileBuf = append(*fileBuf, make([]byte, ioActCount)...)

	writel(pb+40, ioActCount)
	return 0
}

func tGetEOF(pb uint32) int {
	ioRefNum := readw(pb + 24)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		return -38 // fnOpnErr
	}

	writel(pb+28, uint32(len(*(openBuffers[ioRefNum])))) // ioMisc
	return 0
}

func tSetEOF(pb uint32) int {
	ioRefNum := readw(pb + 24)
	ioMisc := readl(pb + 28)

	fcb := fcbFromRefnum(ioRefNum)
	if fcb == 0 || readl(fcb) == 0 {
		return -38 // fnOpnErr
	}

	buf := openBuffers[ioRefNum]

	for uint32(len(*buf)) < ioMisc {
		*buf = append(*buf, 0)
	}

	if uint32(len(*buf)) > ioMisc {
		*buf = (*buf)[:ioMisc]
	}

	if ioMisc < readl(fcb+16) { // can't have mark beyond eof
		writel(fcb+16, ioMisc)
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

// Selector 8 of HFSDispatch
func tGetFCBInfo(pb uint32) int {
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

	return 0
}
