// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

/*
HighLevelHFSDispatch, aka HFS Pinafore

Routines with very dissimilar calling conventions from the rest of the
File Mgr, that deal with FSSpecs.

These routines must call other File Mgr traps, to enable patches to be run.
*/

package main

import (
	"fmt"
)

func tHighLevelFSDispatch() {
	selector := readb(d0ptr + 3)
	switch selector {
	case 1: // pascal OSErr FSMakeFSSpec(short vRefNum, long dirID, ConstStr255Param fileName, FSSpecPtr spec)
		specPtr := popl()
		ioNamePtr := popl()
		ioDirID := popl()
		ioVRefNum := popw()

		pb, oldsp := pushzero(128)
		writel(a0ptr, pb)
		writew(pb+22, ioVRefNum)
		writel(pb+48, ioDirID)
		writel(pb+18, ioNamePtr)
		writel(pb+28, specPtr) // ioMisc

		writel(d0ptr, 0x1b) // MakeFSSpec selector...
		lineA(0xa260)       // FSDispatch
		writel(spptr, oldsp)

		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 2, 3: // pascal OSErr FSpOpenDF/RF(const FSSpec *spec, char permission, short *refNum)
		refNumPtr := popl()
		ioPermssn := popb()
		specPtr := popl()

		pb, oldsp := pushzero(128)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))   // ioVRefNum
		writel(pb+48, readl(specPtr+2)) // ioDirID
		writel(pb+18, specPtr+6)        // ioNamePtr
		writeb(pb+27, ioPermssn)

		if selector == 2 { // FSpOpenDF
			writel(d0ptr, 0x1a) // OpenDF selector...
			lineA(0xa260)       // FSDispatch
		} else { // FSpOpenRF
			lineA(0xa20a) // OpenRF
		}
		ioRefNum := readw(pb + 24)
		writel(spptr, oldsp)

		writew(refNumPtr, ioRefNum)
		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 4, 14: // pascal OSErr FSpCreate[ResFile](const FSSpec *spec, OSType creator, OSType fileType, ScriptCode scriptTag)
		isResFile := readb(d0ptr+3) == 14
		popw() // discard scriptTag
		tCode := popl()
		cCode := popl()
		specPtr := popl()

		pb, oldsp := pushzero(128)

		if isResFile {
			pushw(readw(specPtr))         // vRefNum
			pushl(readl(specPtr + 2))     // dirID
			pushl(specPtr + 6)            // namePtr
			lineA(0xa81b)                 // _HCreateResFile
			writew(d0ptr+2, readw(0xa60)) // d0.w = ResErr (checked below)
		} else {
			writel(a0ptr, pb)
			writew(pb+22, readw(specPtr))   // ioVRefNum
			writel(pb+48, readl(specPtr+2)) // ioDirID
			writel(pb+18, specPtr+6)        // ioNamePtr
			lineA(0xa208)                   // _HCreate
		}

		if readw(d0ptr+2) == 0 {
			writel(a0ptr, pb)
			writew(pb+22, readw(specPtr))   // ioVRefNum
			writel(pb+48, readl(specPtr+2)) // ioDirID
			writel(pb+18, specPtr+6)        // ioNamePtr
			lineA(0xa20c)                   // _HGetFInfo

			if readw(d0ptr+2) == 0 {
				writel(a0ptr, pb)
				writew(pb+22, readw(specPtr))   // ioVRefNum
				writel(pb+48, readl(specPtr+2)) // ioDirID
				writel(pb+18, specPtr+6)        // ioNamePtr
				writel(pb+32, cCode)            // fdType
				writel(pb+36, tCode)            // fdCreator
				lineA(0xa20d)                   // _HSetFInfo
			}
		}

		writel(spptr, oldsp)
		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 5: // pascal OSErr FSpDirCreate(const FSSpec *spec, ScriptCode scriptTag, long *createdDirID)
		idPtr := popl()
		popw() // discard scriptTag
		specPtr := popl()

		pb, oldsp := pushzero(128)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))   // ioVRefNum
		writel(pb+48, readl(specPtr+2)) // ioDirID
		writel(pb+18, specPtr+6)        // ioNamePtr

		writel(d0ptr, 6) // DirCreate selector
		lineA(0xa260)    // FSDispatch
		ioDirID := readl(pb + 48)
		writel(spptr, oldsp)

		if readw(d0ptr+2) == 0 {
			writel(idPtr, ioDirID)
		}
		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 6: // pascal OSErr FSpDelete(const FSSpec *spec)
		specPtr := popl()

		pb, oldsp := pushzero(128)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))   // ioVRefNum
		writel(pb+48, readl(specPtr+2)) // ioDirID
		writel(pb+18, specPtr+6)        // ioNamePtr

		lineA(0xa209) // _HDelete
		writel(spptr, oldsp)

		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 7: // pascal OSErr FSpGetFInfo(const FSSpec *spec, FInfo *fndrInfo)
		fInfoPtr := popl()
		specPtr := popl()

		pb, oldsp := pushzero(128)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))   // ioVRefNum
		writel(pb+48, readl(specPtr+2)) // ioDirID
		writel(pb+18, specPtr+6)        // ioNamePtr

		lineA(0xa20c) // _HGetFInfo

		copy(mem[fInfoPtr:][:16], mem[pb+32:][:16]) // ioFlFndrInfo
		writel(spptr, oldsp)

		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 8: // pascal OSErr FSpSetFInfo(const FSSpec *spec, const FInfo *fndrInfo)
		fInfoPtr := popl()
		specPtr := popl()

		pb, oldsp := pushzero(128)
		writel(a0ptr, pb)
		writew(pb+22, readw(specPtr))               // ioVRefNum
		writel(pb+48, readl(specPtr+2))             // ioDirID
		writel(pb+18, specPtr+6)                    // ioNamePtr
		copy(mem[pb+32:][:16], mem[fInfoPtr:][:16]) // ioFlFndrInfo

		lineA(0xa20d) // _HSetFInfo
		writel(spptr, oldsp)

		writew(readl(spptr), readw(d0ptr+2)) // return osErr

	case 13: // pascal short FSpOpenResFile(const FSSpec *spec, char permission)
		perm := popb()
		specPtr := popl()

		pushw(readw(specPtr))     // vRefNum
		pushl(readl(specPtr + 2)) // dirID
		pushl(specPtr + 6)        // namePtr
		pushb(perm)

		lineA(0xa81a) // _HOpenResFile
		// and the result will be left on the stack for us

	default:
		panic(fmt.Sprintf("Not implemented: _HighLevelFSDispatch d0=0x%x", selector))
	}
}
