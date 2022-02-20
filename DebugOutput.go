package main

import (
	"fmt"
	"os"
	"strings"
)

const allBugFlags = "6=68k|t=stacktrace|f=FileMgr|m=MemMgr|p=hoard+poison old MM blocks"

var bugFlags = os.Getenv("MPSDEBUG")

var (
	gDebugAny        = bugFlags != ""
	gDebugEveryInst  = strings.ContainsRune(bugFlags, '6')
	gDebugStackTrace = strings.ContainsRune(bugFlags, 't')
	gDebugFileMgr    = strings.ContainsRune(bugFlags, 'f')
	gDebugMemoryMgr  = strings.ContainsRune(bugFlags, 'm')
	gPoisonOldBlocks = strings.ContainsRune(bugFlags, 'p')
)

// called before and after every trap when debugging is on
func logTrap(inst uint16, isPre bool) {
	// For OS traps, use the more informative number in d1
	if inst&0x800 == 0 {
		inst = readw(d1ptr + 2)
	}

	_, isMM := mmTraps[inst&0x8ff]

	switch {
	case inst&0x8ff <= 0x18 || inst&0x8ff == 0x44 || inst&0x8ff == 0x60:
		// File Manager
		if gDebugFileMgr {
			logFileMgrTrap(inst, isPre)
		}

	case isMM:
		if gDebugMemoryMgr {
			logMemoryMgrTrap(inst, isPre)
		}
	}
}

// prettyprinting

func logf(format string, a ...interface{}) {
	str := fmt.Sprintf(format, a...)
	str = strings.TrimRight(str, "\n")

	if len(str) == 0 {
		return
	}

	for _, line := range strings.Split(str, "\n") {
		fmt.Fprintf(os.Stderr, "#### %s\n", line)
	}
}

func logln(a ...interface{}) {
	logf("%s", fmt.Sprintln(a...))
}

// File Manager dumping

var gLastFSDispatchSelector uint16 // because d0 gets clobbered

func logFileMgrTrap(num uint16, isPre bool) {
	pb := readl(a0ptr)

	trapName := func(s string) {
		if isPre {
			logf("%04X=%s (\n", num, s)
		}
	}

	if !isPre {
		logln(") returns (")
		dumpPBField("ioResult")
	}

	switch num & 0xff {
	case 0x00:
		trapName("_Open")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
			dumpPBField("ioPermssn")
		} else {
			dumpPBField("ioRefNum")
		}

	case 0x01:
		trapName("_Close")
		if isPre {
			dumpPBField("ioRefNum")
		}

	case 0x02:
		trapName("_Read")
		if isPre {
			dumpPBField("ioRefNum")
			dumpPBField("ioBuffer")
			dumpPBField("ioReqCount")
			dumpPBField("ioPosMode")
			dumpPBField("ioPosOffset")
		} else {
			dumpPBField("ioActCount")
			dumpPBField("ioPosOffset")
		}

	case 0x03:
		trapName("_Write")
		if isPre {
			dumpPBField("ioRefNum")
			dumpPBField("ioBuffer")
			dumpPBField("ioReqCount")
			dumpPBField("ioPosMode")
			dumpPBField("ioPosOffset")
		} else {
			dumpPBField("ioActCount")
			dumpPBField("ioPosOffset")
		}

	case 0x04:
		trapName("_Control")
		if isPre {
			dumpPBField("ioVRefNum")
			dumpPBField("ioRefNum")
			dumpPBField("csCode")
			dumpPBField("csParam")
		}

	case 0x05:
		trapName("_Status")
		if isPre {
			dumpPBField("ioVRefNum")
			dumpPBField("ioRefNum")
			dumpPBField("csCode")
		} else {
			dumpPBField("csParam")
		}

	case 0x06:
		trapName("_KillIO")
		if isPre {
			dumpPBField("ioRefNum")
		}

	case 0x07:
		trapName("_GetVInfo")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
			dumpPBField("ioVolIndex")
		} else {
			dumpPBField("ioVCrDate")
			dumpPBField("ioVLsBkUp")
			dumpPBField("ioVAtrb")
			dumpPBField("ioVNmFls")
			dumpPBField("ioVDirSt")
			dumpPBField("ioVBlLn")
			dumpPBField("ioVNmAlBlks")
			dumpPBField("ioVAlBlkSiz")
			dumpPBField("ioVClpSiz")
			dumpPBField("ioAlBlSt")
			dumpPBField("ioVNxtFNum")
			dumpPBField("ioVFrBlk")
			if num&0x200 != 0 {
				dumpPBField("ioVSigWord")
				dumpPBField("ioVDrvInfo")
				dumpPBField("ioVDRefNum")
				dumpPBField("ioVFSID")
				dumpPBField("ioVBkUp")
				dumpPBField("ioVSeqNum")
				dumpPBField("ioVWrCnt")
				dumpPBField("ioVFilCnt")
				dumpPBField("ioVDirCnt")
				dumpPBField("ioVFndrInfo")
			}
		}

	case 0x08:
		trapName("_Create")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
		}

	case 0x09:
		trapName("_Delete")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
		}

	case 0x0a:
		trapName("_OpenRF")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
			dumpPBField("ioPermssn")
		} else {
			dumpPBField("ioRefNum")
		}

	case 0x0b:
		trapName("_Rename")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
			dumpPBField("ioPermssn")
		} else {
			dumpPBField("ioRefNum")
		}

	case 0x0c:
		trapName("_GetFInfo")
		if isPre {
			if int16(readw(pb+28)) <= 0 {
				dumpPBField("ioNamePtr")
			} else {
				logln("    (no ioNamePtr because of ioFDirIndex)")
			}
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
			dumpPBField("ioFDirIndex")
		} else {
			dumpPBField("ioFlAttrib")
			dumpPBField("ioFlFndrInfo")
			dumpPBField("ioFlNum")
			dumpPBField("ioFlStBlk")
			dumpPBField("ioFlLgLen")
			dumpPBField("ioFlPyLen")
			dumpPBField("ioFlRStBlk")
			dumpPBField("ioFlRLgLen")
			dumpPBField("ioFlRPyLen")
			dumpPBField("ioFlCrDat")
			dumpPBField("ioFlMdDat")
		}

	case 0x0d:
		trapName("_SetFInfo")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
			dumpPBField("ioFlFndrInfo")
			dumpPBField("ioFlCrDat")
			dumpPBField("ioFlMdDat")
		}

	case 0x10:
		trapName("_Allocate")
		if isPre {
			dumpPBField("ioRefNum")
			dumpPBField("ioReqCount")
		} else {
			dumpPBField("ioActCount")
		}

	case 0x11:
		trapName("_GetEOF")
		if isPre {
			dumpPBField("ioRefNum")
		} else {
			dumpPBField("ioMisc")
		}

	case 0x12:
		trapName("_SetEOF")
		if isPre {
			dumpPBField("ioRefNum")
			dumpPBField("ioMisc")
		}

	case 0x13:
		trapName("_FlushVol")
		if isPre {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
		}

	case 0x14:
		trapName("_GetVol")
		if isPre {
		} else {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
			if num&0x200 != 0 {
				dumpPBField("ioWDProcID")
				dumpPBField("ioWDVRefNum")
				dumpPBField("ioWDDirID")
			}
		}

	case 0x15:
		trapName("_SetVol")
		if isPre {
		} else {
			dumpPBField("ioNamePtr")
			dumpPBField("ioVRefNum")
			dumpPBField("ioDirID?")
		}

	case 0x18:
		trapName("_GetFPos")
		if isPre {
			dumpPBField("ioRefNum")
		} else {
			dumpPBField("ioReqCount")
			dumpPBField("ioActCount")
			dumpPBField("ioPosMode")
			dumpPBField("ioPosOffset")
		}

	case 0x44:
		trapName("_SetFPos")
		if isPre {
			dumpPBField("ioRefNum")
			dumpPBField("ioPosMode")
			dumpPBField("ioPosOffset")
		} else {
			dumpPBField("ioPosOffset")
		}

	case 0x60:
		if isPre {
			gLastFSDispatchSelector = readw(d0ptr + 2)
		}

		switch gLastFSDispatchSelector {
		case 1:
			trapName("_FSDispatch _OpenWD")
			if isPre {
				dumpPBField("ioNamePtr")
				dumpPBField("ioVRefNum")
				dumpPBField("ioWDDirID")
				dumpPBField("ioWDProcID")
			} else {
				dumpPBField("ioVRefNum")
			}

		case 2:
			trapName("_FSDispatch _CloseWD")
			if isPre {
				dumpPBField("ioVRefNum")
			}

		case 7:
			trapName("_FSDispatch _GetWDInfo")
			if isPre {
				dumpPBField("ioVRefNum")
				dumpPBField("ioWDIndex")
				dumpPBField("ioWDProcID")
				dumpPBField("ioWDVRefNum")
			} else {
				dumpPBField("ioNamePtr")
				dumpPBField("ioVRefNum")
				dumpPBField("ioWDProcID")
				dumpPBField("ioWDVRefNum")
				dumpPBField("ioWDDirID")
			}

		case 8:
			trapName("_FSDispatch _GetFCBInfo")
			if isPre {
				dumpPBField("ioVRefNum")
				dumpPBField("ioRefNum")
				dumpPBField("ioFCBIndx")
			} else {
				dumpPBField("ioNamePtr")
				dumpPBField("ioVRefNum")
				dumpPBField("ioRefNum")

				dumpPBField("ioFCBFlNm")
				dumpPBField("ioFCBFlags")
				dumpPBField("ioFCBStBlk")
				dumpPBField("ioFCBEOF")
				dumpPBField("ioFCBPLen")
				dumpPBField("ioFCBCrPs")
				dumpPBField("ioFCBVRefNum")
				dumpPBField("ioFCBClpSiz")
				dumpPBField("ioFCBParID")
			}

		case 9:
			trapName("_FSDispatch _GetCatInfo")
			if isPre {
				if readw(pb+28) == 0 {
					dumpPBField("ioNamePtr")
				} else {
					logln("    (no ioNamePtr because of ioFDirIndex)")
				}
				dumpPBField("ioVRefNum")
				dumpPBField("ioDirID?")
				dumpPBField("ioFDirIndex")
			} else {
				isDir := readb(pb+30)&0x10 != 0
				dumpPBField("ioNamePtr")
				dumpPBField("ioDirID")
				dumpPBField("ioFRefNum")
				dumpPBField("ioFlAttrib")
				if isDir {
					dumpPBField("ioDrUsrWds")
					dumpPBField("ioDrNmFls")
					dumpPBField("ioDrCrDat")
					dumpPBField("ioDrMdDat")
					dumpPBField("ioDrBkDat")
					dumpPBField("ioDrFndrInfo")
					dumpPBField("ioDrParID")
				} else {
					dumpPBField("ioACUser")
					dumpPBField("ioFlFndrInfo")
					dumpPBField("ioFlStBlk")
					dumpPBField("ioFlLgLen")
					dumpPBField("ioFlPyLen")
					dumpPBField("ioFlRStBlk")
					dumpPBField("ioFlRLgLen")
					dumpPBField("ioFlRPyLen")
					dumpPBField("ioFlCrDat")
					dumpPBField("ioFlMdDat")
					dumpPBField("ioFlBkDat")
					dumpPBField("ioFlXFndrInfo")
					dumpPBField("ioFlParID")
					dumpPBField("ioFlClpSiz")
				}
			}

		case 10:
			trapName("_FSDispatch _SetCatInfo")
			if isPre {
				dumpPBField("ioNamePtr")
				dumpPBField("ioVRefNum")
				dumpPBField("ioDirID")
				dumpPBField("ioFlAttrib")
				dumpPBField("ioFlFndrInfo")
				dumpPBField("ioFlCrDat")
				dumpPBField("ioFlMdDat")
				dumpPBField("ioFlBkDat")
			} else {
				dumpPBField("ioNamePtr")
			}

		case 26:
			trapName("_FSDispatch _OpenDF")
			if isPre {
				dumpPBField("ioNamePtr")
				dumpPBField("ioVRefNum")
				dumpPBField("ioDirID?")
				dumpPBField("ioPermssn")
			} else {
				dumpPBField("ioRefNum")
			}

		case 27:
			trapName("_FSDispatch _MakeFSSpec")
			if isPre {
				dumpPBField("ioNamePtr")
				dumpPBField("ioVRefNum")
				dumpPBField("ioDirID")
				dumpPBField("ioPermssn")
				dumpPBField("ioMisc")
			}

		default:
			trapName(fmt.Sprintf("_FSDispatch %#x", gLastFSDispatchSelector))
			if isPre {
			}
		}

	default:
		trapName("???")
		if isPre {
		}
	}

	if !isPre {
		logln(")")
	}
}

func dumpPBField(f string) {
	logField := func(n ...interface{}) {
		n = append([]interface{}{"   "}, n...)
		for i := range n {
			switch n[i].(type) {
			case uint32:
				n[i] = fmt.Sprintf("%#08x", n[i])
			case uint16:
				n[i] = fmt.Sprintf("%#04x", n[i])
			case uint8:
				n[i] = fmt.Sprintf("%#02x", n[i])
			}
		}
		logln(n...)
	}

	pb := readl(a0ptr)
	switch f {
	case "ioTrap":
		logField(f, readw(pb+6))
	case "ioResult":
		logField(f, readw(pb+16), int16(readw(pb+16)))
	case "ioVRefNum":
		vrefnum := readw(pb + 22)
		logField(f, vrefnum, dirIDs[vrefnum])
	case "ioRefNum", "ioFRefNum":
		refnum := readw(pb + 24)
		logField(f, refnum, readPstring(fcbFromRefnum(refnum)+62))
	case "ioWDIndex", "csCode":
		logField(f, readw(pb+26))
	case "ioPermssn":
		perm := readb(pb + 27)
		name := ""
		switch perm {
		case 0:
			name = "fsCurPerm"
		case 1:
			name = "fsRdPerm"
		case 2:
			name = "fsRdWrPerm"
		case 3:
			name = "fsRdWrPerm"
		}
		logField(f, perm, name)
	case "ioMisc", "ioWDProcID":
		logField(f, readl(pb+28))
	case "ioVolIndex", "ioFDirIndex", "ioFCBIndx":
		logField(f, readw(pb+28))
	case "csParam":
		logField(f, fmt.Sprintf("%X", mem[pb+28:][:22]))
	case "ioFlAttrib":
		logField(f, readb(pb+30))
	case "ioVCrDate":
		logField(f, readl(pb+30))
	case "ioACUser":
		logField(f, readb(pb+31))
	case "ioBuffer", "ioFCBFlNm":
		logField(f, readl(pb+32))
	case "ioWDVRefNum":
		logField(f, readw(pb+32))
	case "ioFlFndrInfo", "ioDrUsrWds":
		logField(f, fmt.Sprintf("%X", mem[pb+32:][:16]), macToUnicode(macstring(mem[pb+32:][:8])))
	case "ioNamePtr":
		nameptr := readl(pb + 18)
		s := "\""
		suspicious := ""
		for _, char := range readPstring(nameptr) {
			if char < 32 || char > 127 {
				s += fmt.Sprintf("[%02x]", byte(char))
				suspicious = " (suspected junk)"
			} else {
				s += string(char)
			}
		}
		s += "\""
		logField(f, nameptr, s+suspicious)
	case "ioVLsBkUp":
		logField(f, readl(pb+34))
	case "ioReqCount":
		logField(f, readl(pb+36))
	case "ioFCBFlags":
		logField(f, readw(pb+36))
	case "ioVAtrb", "ioFCBStBlk":
		logField(f, readw(pb+38))
	case "ioActCount", "ioFCBEOF":
		logField(f, readl(pb+40))
	case "ioVNmFls":
		logField(f, readw(pb+40))
	case "ioVDirSt":
		logField(f, readw(pb+42))
	case "ioPosMode", "ioVBlLn":
		logField(f, readw(pb+44))
	case "ioFCBPLen":
		logField(f, readl(pb+44))
	case "ioPosOffset":
		logField(f, readl(pb+46))
	case "ioVNmAlBlks":
		logField(f, readw(pb+46))
	case "ioDirID?":
		if readw(d1ptr+2)&0x200 != 0 {
			dumpPBField("ioDirID")
		}
	case "ioDirID", "ioWDDirID":
		dirid := readl(pb + 48)
		logField(f, dirid, dirIDs[dirid])
	case "ioFlNum", "ioVAlBlkSiz", "ioFCBCrPs":
		logField(f, readl(pb+48))
	case "ioFlStBlk", "ioFCBVRefNum":
		logField(f, readw(pb+52))
	case "ioVClpSiz", "ioDrNmFls":
		logField(f, readl(pb+52))
	case "ioFlLgLen", "ioFCBClpSiz":
		logField(f, readl(pb+54))
	case "ioAlBlSt":
		logField(f, readl(pb+56))
	case "ioVNxtFNum", "ioFlPyLen":
		logField(f, readl(pb+58))
	case "ioFCBParID":
		dirid := readl(pb + 58)
		logField(f, dirid, dirIDs[dirid])
	case "ioVFrBlk", "ioFlRStBlk":
		logField(f, readw(pb+62))
	case "ioFlRLgLen":
		logField(f, readl(pb+64))
	case "ioVSigWord":
		logField(f, readw(pb+64))
	case "ioVDrvInfo":
		logField(f, readw(pb+66))
	case "ioFlRPyLen":
		logField(f, readl(pb+68))
	case "ioVDRefNum":
		logField(f, readw(pb+68))
	case "ioVFSID":
		logField(f, readw(pb+70))
	case "ioVBkUp", "ioFlCrDat", "ioDrCrDat":
		logField(f, readl(pb+72))
	case "ioFlMdDat", "ioDrMdDat":
		logField(f, readl(pb+76))
	case "ioVSeqNum":
		logField(f, readw(pb+76))
	case "ioVWrCnt":
		logField(f, readl(pb+78))
	case "ioFlBkDat", "ioDrBkDat":
		logField(f, readl(pb+80))
	case "ioVFilCnt":
		logField(f, readl(pb+82))
	case "ioFlXFndrInfo", "ioDrFndrInfo":
		logField(f, fmt.Sprintf("%X", mem[pb+84:][:16]))
	case "ioVDirCnt":
		logField(f, readl(pb+86))
	case "ioVFndrInfo":
		logField(f, fmt.Sprintf("%X", mem[pb+90:][:32]))
	case "ioFlParID", "ioDrParID":
		dirid := readl(pb + 100)
		logField(f, dirid, dirIDs[dirid])
	case "ioFlClpSiz":
		logField(f, readl(pb+104))
	default:
		panic("uncoded paramblk field " + f)
	}
}

// Memory Manager dumping
var lastMemFree uint32

func printRegs(flags int) {
	slice := []string{}
	for i := 0; i < 16; i++ {
		if flags&(1<<i) != 0 {
			addr := d0ptr + 4*uint32(i)
			letter := "d"
			if i >= 8 {
				letter = "a"
			}
			slice = append(slice, fmt.Sprintf("%s%d=%08x", letter, i%8, readl(addr)))
		}
	}

	if len(slice) > 0 {
		logln("    " + strings.Join(slice, ", "))
	}
}

func logMemoryMgrTrap(num uint16, isPre bool) {
	info := mmTraps[num&0x8ff]
	if isPre {
		logf("%04X=%s (\n", num, info.name)
		printRegs(info.arg)
		lastMemFree = memFree
	} else {
		logln(") returns (")

		printRegs(info.ret)

		if memFree != lastMemFree {
			logf("   %+d b total heap\n", int32(lastMemFree-memFree))
		}

		if memErr := uint16(readw(0x220)); memErr != 0 {
			logf("    memErr=%d\n", memErr)
		}

		logln(")")
	}
}

type mmTrapSig struct {
	name string
	arg  int
	ret  int
}

const (
	flagD0 = 1 << iota
	flagD1
	flagD2
	flagD3
	flagD4
	flagD5
	flagD6
	flagD7
	flagA0
	flagA1
	flagA2
	flagA3
	flagA4
	flagA5
	flagA6
	flagA7
)

var mmTraps = map[uint16]mmTrapSig{
	0x1a: {"_GetZone", 0, flagD0 + flagA0},
	0x1b: {"_SetZone", flagA0, flagD0},
	0x1c: {"_FreeMem", 0, flagD0},
	0x1d: {"_MaxMem", 0, flagD0 + flagA0},
	0x1e: {"_NewPtr", flagD0, flagD0 + flagA0},
	0x1f: {"_DisposPtr", flagA0, flagD0},
	0x20: {"_SetPtrSize", flagD0 + flagA0, flagD0},
	0x21: {"_GetPtrSize", flagA0, flagD0},
	0x22: {"_NewHandle", flagD0, flagD0 + flagA0},
	0x23: {"_DisposHandle", flagA0, flagD0},
	0x24: {"_SetHandleSize", flagD0 + flagA0, flagD0},
	0x25: {"_GetHandleSize", flagA0, flagD0},
	0x26: {"_HandleZone", flagA0, flagD0 + flagA0},
	0x27: {"_ReallocHandle", flagD0 + flagA0, flagD0},
	0x28: {"_RecoverHandle", flagA0, flagD0 + flagA0},
	0x29: {"_HLock", flagA0, flagD0},
	0x2a: {"_HUnlock", flagA0, flagD0},
	0x2b: {"_EmptyHandle", flagA0, flagD0 + flagA0},
	0x2c: {"_InitApplZone", 0, flagD0},
	0x2d: {"_SetApplLimit", flagA0, flagD0},
	0x36: {"_MoreMasters", 0, 0},
	0x40: {"_ResrvMem", flagD0, flagD0},
	0x48: {"_PtrZone", flagA0, flagD0 + flagA0},
	0x49: {"_HPurge", flagA0, flagD0},
	0x4a: {"_HNoPurge", flagA0, flagD0},
	0x4b: {"_SetGrowZone", flagA0, flagD0},
	0x4c: {"_CompactMem", flagD0, flagD0},
	0x4d: {"_PurgeMem", flagD0, flagD0},
	0x55: {"_StripAddress", flagD0, flagD0},
	0x62: {"_PurgeSpace", flagA0, flagD0},
	0x63: {"_MaxApplZone", 0, flagD0},
	0x64: {"_MoveHHi", flagA0, flagD0},
	0x65: {"_StackSpace", 0, flagD0},
	0x66: {"_NewEmptyHandle", flagA0, flagD0},
	0x69: {"_HGetState", flagA0, flagD0},
	0x6a: {"_HSetState", flagD0 + flagA0, flagD0},
}
