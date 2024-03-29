// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	_ "embed"
	"fmt"
	"io/ioutil"
	"os"
	"runtime/pprof"
	"strings"
)

var systemFolder, mpwFolder string
var tsRefNum uint16

var kUsage = `mps: Macintosh Programmer's Workshop shell emulator

Usage:
	mps                                # interactive
	mps pathToToolOrScript [arg ...]   # batch-mode
	mps -c 'shortScript' [arg ...]     # batch-mode
	mps -install [url | path]          # install MPW 3.5 from MPW-GM.img.bin
	                                     (SHA256=99bbfa95bb9800c8ffc572fce6...)

Pathname conversion:
	%% arg                             convert arg to HFS format (:sub:dir)
	%%% [arg ...]                      convert all subsequent arguments to HFS

Environment variables:
	MPSDEBUG=...                       # ` + allBugFlags + `
	MPW=...                            # override default MPW path
	                                   #    ~/mpw
	                                   #    /usr/local/share/mpw
	                                   #    /usr/share/mpw
`

// Memory layout
const (
	kOSTable        = 0x400
	kToolTable      = 0xe00   // up to 0x1e00
	kA5World        = 0x58000 // 0x8000 below and 0x8000 above, so 5xxxx is in A5 world
	kPoison         = 0x60000
	kFakeHeapHeader = 0x90000 // very short
	kQDPort         = 0x98000
	kFCBTable       = 0xb0000 // 0x8000 above
	kDQE            = 0xb9000 // 0x4 below and 0x10 above
	kVCB            = 0xba000 // ????
	kMenuList       = 0xbb000
	kExpandMem      = 0xbc000
	kFTrapTable     = 0xf0000  // 0x10000 above
	kHeap           = 0x100000 // extends up
	kHeapLimit      = 0x3f000000
	kStackLimit     = 0x3f000000
	kStackBase      = 0x3fffffe0
	kReturnAddr     = 0x3fffffea // unlikely to be found elsewhere
	kLowestIllegal  = 0x40000000
	kMemSize        = 0x40000008
)

//go:embed System.r
var embedSystemFile []byte

func main() {
	if len(os.Args) >= 2 && len(os.Args) <= 3 && os.Args[1] == "-install" {
		source := ""
		if len(os.Args) >= 3 {
			source = os.Args[2]
		}

		ok := installFrom(source)
		if ok {
			os.Exit(0)
		} else {
			os.Exit(1)
		}
	}

	// This must be the last defer to run, because it sets the exit status
	defer func() {
		if err := recover(); err != nil {
			var msg string
			switch err := err.(type) {
			case exitToShell:
				return // exit code 0
			case uint32:
				msg = fmt.Sprintf("Memory access %08x", err)
			default:
				msg = fmt.Sprintf("%v", err)
			}

			trace := stacktrace()

			// Remove this closure and the original panic() from the trace
			trace = strings.SplitAfterN(trace, "\n", 5)[4]
			trace = strings.ReplaceAll(trace, "\t", "    ")

			logf("%s\nMixed Go-68k stack trace:\n%s", msg, trace)
			os.Exit(1)
		}
	}()

	if gProfile {
		f, err := os.Create("mps.pprof")
		if err != nil {
			panic(err)
		}
		pprof.StartCPUProfile(f)
		defer pprof.StopCPUProfile()
	}

	defer writeOutDebugInfo()

	my_traps = [...]func(){
		os_base + 0x00:  pbWrap(tOpenDF),                // _Open
		os_base + 0x01:  pbWrap(tClose),                 // _Close
		os_base + 0x02:  pbWrap(tReadWrite),             // _Read
		os_base + 0x03:  pbWrap(tReadWrite),             // _Write
		os_base + 0x07:  pbWrap(tGetVInfo),              // _GetVInfo
		os_base + 0x08:  pbWrap(tCreate),                // _Create
		os_base + 0x09:  pbWrap(tDelete),                // _Delete
		os_base + 0x0a:  pbWrap(tOpenRF),                // _OpenRF
		os_base + 0x0b:  pbWrap(tRename),                // _Rename
		os_base + 0x0c:  pbWrap(tGetFInfo),              // _GetFInfo
		os_base + 0x0d:  pbWrap(tSetFInfo),              // _SetFInfo
		os_base + 0x10:  pbWrap(tAllocate),              // _Allocate
		os_base + 0x11:  pbWrap(tGetEOF),                // _GetEOF
		os_base + 0x12:  pbWrap(tSetEOF),                // _SetEOF
		os_base + 0x13:  tParamBlkNop,                   // _FlushVol
		os_base + 0x14:  pbWrap(tGetVol),                // _GetVol
		os_base + 0x15:  pbWrap(tSetVol),                // _SetVol
		os_base + 0x18:  pbWrap(tGetFPos),               // _GetFPos
		os_base + 0x1a:  memErrD0Wrap(tGetZone),         // _GetZone
		os_base + 0x1b:  memErrD0Wrap(tSetZone),         // _SetZone
		os_base + 0x1c:  memErrWrap(tFreeMem),           // _FreeMem
		os_base + 0x1d:  memErrWrap(tMaxMem),            // _MaxMem
		os_base + 0x1e:  memErrD0Wrap(tNewPtr),          // _NewPtr
		os_base + 0x1f:  memErrD0Wrap(tDisposPtr),       // _DisposPtr
		os_base + 0x20:  memErrD0Wrap(tSetPtrSize),      // _SetPtrSize
		os_base + 0x21:  memErrWrap(tGetPtrSize),        // _GetPtrSize
		os_base + 0x22:  memErrD0Wrap(tNewHandle),       // _NewHandle
		os_base + 0x23:  memErrD0Wrap(tDisposHandle),    // _DisposHandle
		os_base + 0x24:  memErrD0Wrap(tSetHandleSize),   // _SetHandleSize
		os_base + 0x25:  memErrWrap(tGetHandleSize),     // _GetHandleSize
		os_base + 0x26:  memErrD0Wrap(tGetZone),         // _HandleZone
		os_base + 0x27:  memErrD0Wrap(tReallocHandle),   // _ReallocHandle
		os_base + 0x28:  memErrWrap(tRecoverHandle),     // _RecoverHandle
		os_base + 0x29:  memErrD0Wrap(tHLock),           // _HLock
		os_base + 0x2a:  memErrD0Wrap(tHUnlock),         // _HUnlock
		os_base + 0x2b:  memErrD0Wrap(tEmptyHandle),     // _EmptyHandle
		os_base + 0x2c:  tMemMgrNop,                     // _InitApplZone
		os_base + 0x2d:  tMemMgrNop,                     // _SetApplLimit
		os_base + 0x2e:  tBlockMove,                     // _BlockMove
		os_base + 0x30:  tGetOSEvent,                    // _OSEventAvail
		os_base + 0x31:  tGetOSEvent,                    // _GetOSEvent
		os_base + 0x32:  tMemMgrNop,                     // _FlushEvents
		os_base + 0x36:  tMemMgrNop,                     // _MoreMasters
		os_base + 0x39:  tReadDateTime,                  // _ReadDateTime
		os_base + 0x3a:  tSetDateTime,                   // _SetDateTime
		os_base + 0x3c:  tCmpString,                     // _CmpString
		os_base + 0x40:  memErrD0Wrap(tPurgeOrResrvMem), // _ResrvMem
		os_base + 0x44:  pbWrap(tSetFPos),               // _SetFPos
		os_base + 0x46:  tGetTrapAddress,                // _GetTrapAddress
		os_base + 0x47:  tSetTrapAddress,                // _SetTrapAddress
		os_base + 0x48:  memErrD0Wrap(tGetZone),         // _PtrZone
		os_base + 0x49:  memErrD0Wrap(tHPurge),          // _HPurge
		os_base + 0x4a:  memErrD0Wrap(tHNoPurge),        // _HNoPurge
		os_base + 0x4b:  tMemMgrNop,                     // _SetGrowZone
		os_base + 0x4c:  memErrWrap(tCompactMem),        // _CompactMem
		os_base + 0x4d:  tMemMgrNop,                     // _PurgeMem
		os_base + 0x51:  tReadXPram,                     // _ReadXPram
		os_base + 0x52:  tClrD0,                         // _WriteXPram
		os_base + 0x54:  tUprString,                     // _UprString
		os_base + 0x55:  tNop,                           // _StripAddress
		os_base + 0x58:  tClrD0,                         // _InsTime
		os_base + 0x59:  tClrD0,                         // _RmvTime
		os_base + 0x5a:  tClrD0,                         // _PrimeTime
		os_base + 0x60:  pbWrap(tFSDispatch),            // _FSDispatch
		os_base + 0x62:  memErrD0Wrap(tPurgeOrResrvMem), // _PurgeSpace
		os_base + 0x63:  tMemMgrNop,                     // _MaxApplZone
		os_base + 0x64:  tMemMgrNop,                     // _MoveHHi
		os_base + 0x65:  memErrWrap(tStackSpace),        // _StackSpace
		os_base + 0x66:  memErrD0Wrap(tNewEmptyHandle),  // _NewEmptyHandle
		os_base + 0x69:  memErrWrap(tHGetState),         // _HGetState
		os_base + 0x6a:  memErrD0Wrap(tHSetState),       // _HSetState
		os_base + 0x90:  tSysEnvirons,                   // _SysEnvirons
		os_base + 0x93:  tMicroseconds,                  // _Microseconds
		os_base + 0xad:  tGestalt,                       // _Gestalt
		tb_base + 0x00d: tCount1Resources,               // _Count1Resources
		tb_base + 0x00e: tGet1IndResource,               // _Get1IndResource
		tb_base + 0x00f: tGet1IndType,                   // _Get1IndType
		tb_base + 0x01a: tHOpenResFile,                  // _HOpenResFile
		tb_base + 0x01b: tHCreateResFile,                // _HCreateResFile
		tb_base + 0x01c: tCount1Types,                   // _Count1Types
		tb_base + 0x01f: tGet1Resource,                  // _Get1Resource
		tb_base + 0x020: tGet1NamedResource,             // _Get1NamedResource
		tb_base + 0x023: tAliasDispatch,                 // _AliasDispatch
		tb_base + 0x034: tPop2,                          // _SetFScaleDisable
		tb_base + 0x050: tNop,                           // _InitCursor
		tb_base + 0x051: tPop4,                          // _SetCursor
		tb_base + 0x052: tNop,                           // _HideCursor
		tb_base + 0x053: tNop,                           // _ShowCursor
		tb_base + 0x055: tPop8,                          // _ShieldCursor
		tb_base + 0x056: tNop,                           // _ObscureCursor
		tb_base + 0x058: tBitAnd,                        // _BitAnd
		tb_base + 0x059: tBitXor,                        // _BitXor
		tb_base + 0x05a: tBitNot,                        // _BitNot
		tb_base + 0x05b: tBitOr,                         // _BitOr
		tb_base + 0x05c: tBitShift,                      // _BitShift
		tb_base + 0x05d: tBitTst,                        // _BitTst
		tb_base + 0x05e: tBitSet,                        // _BitSet
		tb_base + 0x05f: tBitClr,                        // _BitClr
		tb_base + 0x060: tWaitNextEvent,                 // _WaitNextEvent
		tb_base + 0x06a: tHiWord,                        // _HiWord
		tb_base + 0x06b: tLoWord,                        // _LoWord
		tb_base + 0x06e: tInitGraf,                      // _InitGraf
		tb_base + 0x06f: tPop4,                          // _OpenPort
		tb_base + 0x073: tSetPort,                       // _SetPort
		tb_base + 0x074: tGetPort,                       // _GetPort
		tb_base + 0x08d: tCharWidth,                     // _CharWidth
		tb_base + 0x08f: tOSDispatch,                    // _OSDispatch
		tb_base + 0x09f: tUnimplemented,                 // _Unimplemented
		tb_base + 0x0a7: tSetRect,                       // _SetRect
		tb_base + 0x0a8: tOffsetRect,                    // _OffsetRect
		tb_base + 0x0a9: tInsetRect,                     // _InsetRect
		tb_base + 0x0d8: tRetZero,                       // _NewRgn
		tb_base + 0x0fe: tNop,                           // _InitFonts
		tb_base + 0x0ff: tGetFName,                      // _GetFName
		tb_base + 0x100: tGetFNum,                       // _GetFNum
		tb_base + 0x106: tNewString,                     // _NewString
		tb_base + 0x112: tNop,                           // _InitWindows
		tb_base + 0x115: tShowWindow,                    // _ShowWindow
		tb_base + 0x116: tPop4,                          // _HideWindow
		tb_base + 0x11a: tPop8,                          // _SetWTitle
		tb_base + 0x11b: tPop10,                         // _MoveWindow
		tb_base + 0x11f: tPop4,                          // _SelectWindow
		tb_base + 0x120: tPop4,                          // _BringToFront
		tb_base + 0x121: tPop4,                          // _SendBehind
		tb_base + 0x122: tPop4,                          // _BeginUpdate
		tb_base + 0x123: tPop4,                          // _EndUpdate
		tb_base + 0x124: tRetZero,                       // _FrontWindow
		tb_base + 0x130: tNop,                           // _InitMenus
		tb_base + 0x137: tNop,                           // _DrawMenuBar
		tb_base + 0x138: tPop2,                          // _HiliteMenu
		tb_base + 0x139: tPop6,                          // _EnableItem
		tb_base + 0x13a: tPop6,                          // _DisableItem
		tb_base + 0x13c: tPop4,                          // _SetMenuBar
		tb_base + 0x13e: tMenuKey,                       // _MenuKey
		tb_base + 0x149: tPop2RetZero,                   // _GetMenuHandle
		tb_base + 0x14d: tPop8,                          // _AppendResMenu
		tb_base + 0x170: tGetNextEvent,                  // _GetNextEvent
		tb_base + 0x175: tTickCount,                     // _TickCount
		tb_base + 0x178: tPop8,                          // _UpdtDialog
		tb_base + 0x179: tPop2,                          // _CouldDialog
		tb_base + 0x17a: tPop2,                          // _FreeDialog
		tb_base + 0x17b: tNop,                           // _InitDialogs
		tb_base + 0x17c: tGetNewDialog,                  // _GetNewDialog
		tb_base + 0x17d: tNewDialog,                     // _NewDialog
		tb_base + 0x17e: tPop10,                         // _SelIText
		tb_base + 0x17f: tPop4RetZeroW,                  // _IsDialogEvent
		tb_base + 0x181: tPop4,                          // _DrawDialog
		tb_base + 0x182: tCloseDialog,                   // _CloseDialog
		tb_base + 0x183: tDisposDialog,                  // _DisposDialog
		tb_base + 0x189: tPop2,                          // _CouldAlert
		tb_base + 0x18a: tPop2,                          // _FreeAlert
		tb_base + 0x18b: tParamText,                     // _ParamText
		tb_base + 0x18d: tGetDItem,                      // _GetDItem
		tb_base + 0x18e: tSetDItem,                      // _SetDItem
		tb_base + 0x18f: tSetIText,                      // _SetIText
		tb_base + 0x190: tGetIText,                      // _GetIText
		tb_base + 0x191: tModalDialog,                   // _ModalDialog
		tb_base + 0x192: tDetachResource,                // _DetachResource
		tb_base + 0x194: tCurResFile,                    // _CurResFile
		tb_base + 0x197: tOpenResFile,                   // _OpenResFile
		tb_base + 0x198: tUseResFile,                    // _UseResFile
		tb_base + 0x199: tUpdateResFile,                 // _UpdateResFile
		tb_base + 0x19a: tCloseResFile,                  // _CloseResFile
		tb_base + 0x19b: tSetResLoad,                    // _SetResLoad
		tb_base + 0x19c: tCountResources,                // _CountResources
		tb_base + 0x19d: tGetIndResource,                // _GetIndResource
		tb_base + 0x19e: tCountTypes,                    // _CountTypes
		tb_base + 0x19f: tGetIndType,                    // _GetIndType
		tb_base + 0x1a0: tGetResource,                   // _GetResource
		tb_base + 0x1a1: tGetNamedResource,              // _GetNamedResource
		tb_base + 0x1a2: tLoadResource,                  // _LoadResource
		tb_base + 0x1a3: tReleaseResource,               // _ReleaseResource
		tb_base + 0x1a4: tHomeResFile,                   // _HomeResFile
		tb_base + 0x1a5: tSizeRsrc,                      // _SizeRsrc
		tb_base + 0x1a6: tGetResAttrs,                   // _GetResAttrs
		tb_base + 0x1a7: tSetResAttrs,                   // _SetResAttrs
		tb_base + 0x1a8: tGetResInfo,                    // _GetResInfo
		tb_base + 0x1aa: tChangedResource,               // _ChangedResource
		tb_base + 0x1ab: tAddResource,                   // _AddResource
		tb_base + 0x1ac: tPop4,                          // _ErrorSound
		tb_base + 0x1ad: tRmveResource,                  // _RmveResource
		tb_base + 0x1af: tResError,                      // _ResError
		tb_base + 0x1b0: tWriteResource,                 // _WriteResource
		tb_base + 0x1b1: tCreateResFile,                 // _CreateResFile
		tb_base + 0x1b4: tNop,                           // _SystemTask
		tb_base + 0x1b8: tGetPattern,                    // _GetPattern
		tb_base + 0x1b9: tGetCursor,                     // _GetCursor
		tb_base + 0x1ba: tGetString,                     // _GetString
		tb_base + 0x1bb: tGetIcon,                       // _GetIcon
		tb_base + 0x1bc: tGetPicture,                    // _GetPicture
		tb_base + 0x1bd: tPop10RetZero,                  // _GetNewWindow
		tb_base + 0x1c0: tPop2RetZero,                   // _GetNewMBar
		tb_base + 0x1c4: tOpenRFPerm,                    // _OpenRFPerm
		tb_base + 0x1c6: tSecs2Date,                     // _Secs2Date
		tb_base + 0x1c8: tPop2,                          // _SysBeep
		tb_base + 0x1c9: tSysError,                      // _SysError
		tb_base + 0x1cc: tNop,                           // _TEInit
		tb_base + 0x1e1: tHandToHand,                    // _HandToHand
		tb_base + 0x1e2: tPtrToXHand,                    // _PtrToXHand
		tb_base + 0x1e3: tPtrToHand,                     // _PtrToHand
		tb_base + 0x1e4: tHandAndHand,                   // _HandAndHand
		tb_base + 0x1e5: tPop2,                          // _InitPack
		tb_base + 0x1e6: tNop,                           // _InitAllPacks
		tb_base + 0x1ea: tPack3,                         // _Pack3
		tb_base + 0x1eb: tFP68K,                         // _FP68K
		tb_base + 0x1ed: tPack6,                         // _Pack6
		tb_base + 0x1ee: tDecStr68K,                     // _Pack7
		tb_base + 0x1ef: tPtrAndHand,                    // _PtrAndHand
		tb_base + 0x1f0: tLoadSeg,                       // _LoadSeg
		tb_base + 0x1f1: tPop4,                          // _UnloadSeg
		tb_base + 0x1f4: tExitToShell,                   // _ExitToShell
		tb_base + 0x1f6: tGetResFileAttrs,               // _GetResFileAttrs
		tb_base + 0x1f7: tSetResFileAttrs,               // _SetResFileAttrs
		tb_base + 0x1fa: tRetZero,                       // _UnlodeScrap
		tb_base + 0x1fb: tRetZero,                       // _LodeScrap
		tb_base + 0x24b: tNewDialog,                     // _NewCDialog
		tb_base + 0x252: tHighLevelFSDispatch,           // _HighLevelFSDispatch
		tb_base + 0x3fd: tSpecialStdoutStderr,           // (inauthentic)
		tb_base + 0x3fe: tSpecialStdin,                  // (inauthentic)
		tb_base + 0x3ff: tDebugStr,                      // _DebugStr
	}

	// System Folder is ephemeral, containing temp stuff mainly
	systemFolder, _ = ioutil.TempDir("", "System Folder ")
	systemFolder = fix83Names(systemFolder)
	defer os.RemoveAll(systemFolder)

	// Poison low memory
	for i := uint32(0xc0); i < kPoison; i += 2 {
		writew(i, 0x68f1)
	}

	// Populate trap table
	for i, impl := range my_traps {
		tableAddr := kOSTable + 4*uint32(i)
		if i >= 0x100 {
			tableAddr = kToolTable + 4*uint32(i-0x100)
		}
		if impl == nil {
			writel(tableAddr, executable_ftrap(0xf89f))
		} else {
			trap := uint16(i)
			if i >= 0x100 {
				trap = trap - 0x100 + 0x800
			}
			writel(tableAddr, executable_ftrap(0xf000|trap))
		}
	}

	// Starting point for stack
	writel(spptr, kStackBase)
	writel(0x908, kStackBase) // CurStackBase

	// A5 world
	writel(a5ptr, kA5World)

	// Single fake heap zone, enough to pass validation
	writel(0x118, kFakeHeapHeader)      // TheZone
	writel(0x2a6, kFakeHeapHeader)      // SysZone
	writel(0x2aa, kFakeHeapHeader)      // ApplZone
	writel(kFakeHeapHeader, kHeapLimit) // bkLim
	writel(0x130, kHeapLimit)           // ApplLimit

	// 1 Drive Queue Element
	writew(0x308, 0)      // DrvQHdr.QFlags
	writel(0x308+2, kDQE) // DrvQHdr.QHead
	writel(0x308+6, kDQE) // DrvQHdr.QTail
	for i := -4; i < 16; i += 2 {
		writew(kDQE+uint32(i), 0)
	}

	// 1 Volume Control Block is needed for the "GetVRefNum" glue routine
	for i := 0; i < 178; i += 2 {
		writew(kVCB+uint32(i), 0)
	}
	writew(kVCB+8, 0x4244)             // vcbSigWord
	writew(kVCB+78, rootID)            // vcbVRefNum
	writePstring(kVCB+44, onlyVolName) // vcbVName

	// VCB header...
	writew(0x356, 0)
	writel(0x356+2, kVCB)
	writel(0x356+6, kVCB)

	// File Control Block table
	writel(0x34e, kFCBTable)    // FCBSPtr
	writew(0x3f6, 94)           // FSFCBLen
	writew(kFCBTable, 2+94*348) // size of FCB table

	// VBL queue: empty
	for i := uint32(0); i < 10; i++ {
		writeb(0x160+i, 0)
	}

	// DT queue: empty
	for i := uint32(0); i < 10; i++ {
		writeb(0xd92+i, 0)
	}

	// Misc globals
	writel(0x108, kLowestIllegal)      // MemTop
	writel(0x10c, kLowestIllegal)      // BufPtr
	writel(0x114, kHeapLimit)          // HeapEnd
	writeb(0x12f, 3)                   // CPUFlag = 68030
	writeb(0x12c, 0)                   // DskVerify = don't care
	writeb(0x12d, 0)                   // LoadTrap = off
	writew(0x15a, 0x0755)              // SysVersion
	writel(0x16a, 1)                   // Ticks
	writel(0x20c, 0xb492f400)          // Time = 2000-01-01 00:00:00
	writew(0x210, dirID(systemFolder)) // BootDrive
	writew(0x28e, 0x3fff)              // ROM85
	writel(0x2b6, kExpandMem)
	writel(0x282, 0)            // SwitchVars, not sure, same as Sys7
	writel(0x2f4, 0)            // CaretTime = 0 ticks
	writel(0x316, 0)            // we don't implement the 'MPGM' interface
	writel(0x31a, 0x00ffffff)   // Lo3Bytes
	writel(0x33c, 0)            // IAZNotify = nothing to do when swapping worlds
	writel(0x3e2, 0)            // FSQueueHook
	writel(0x8e0, 0)            // JSwapFont
	writel(0x904, readl(a5ptr)) // CurrentA5
	writePstring(0x910, "ToolServer")
	writel(0x9d6, 0)          // WindowList empty
	writel(0xa02, 0x00010001) // OneOne
	writel(0xa06, 0xffffffff) // MinusOne
	writew(0xa4a, 0)          // FPState
	writel(0xa4c, 0)          // FPHaltVector
	writel(0xaa0, 0)          // DAStrings 0
	writel(0xaa4, 0)          // DAStrings 1
	writel(0xaa8, 0)          // DAStrings 2
	writel(0xaac, 0)          // DAStrings 3
	writel(0xa1c, kMenuList)  // MenuList empty
	writew(0xa5e, 0xffff)     // ResLoad = true
	writel(0xa50, 0)          // TopMapHndl
	writew(0xb22, 0)          // HWCfgFlags = can't do anything
	writeb(0xbb2, 0xff)       // SegHiEnable = no need to disable MoveHHi
	writeb(0xbb3, 0xff)       // FDevDisable = don't care
	writel(0xcb0, 0x00000100) // MMUFlags.b MMUType.b MMU32bit.b
	writel(0xd50, 0)          // MenuCInfo

	// Empty app parameters
	writel(d0ptr, 128)
	lineA(0xa122) // _NewHandle
	appParms := readl(a0ptr)
	writel(0xaec, appParms)                  // handle in low memory
	writel(readl(a5ptr)+16, readl(appParms)) // pointer in a5 world

	// Create some useful folders
	for _, n := range []string{"Preferences", "Desktop Folder", "Trash", "Temporary Items"} {
		os.Mkdir(platPathJoin(systemFolder, n), 0o777)
	}

	// Disable the status window in preferences
	os.MkdirAll(platPathJoin(systemFolder, "Preferences", "MPW"), 0o777)
	os.WriteFile(platPathJoin(systemFolder, "Preferences", "MPW", "ToolServer Prefs"), make([]byte, 9), 0o777)

	// Create and open System file
	os.Create(platPathJoin(systemFolder, "System"))
	os.WriteFile(platPathJoin(systemFolder, "System.rdump"), embedSystemFile, 0o644)

	writePstring(0xad8, "System") // SysResName
	pushw(0)                      // space to return refnum
	pushw(dirID(systemFolder))    // vol ID
	pushl(0)                      // dir ID (zero means just do vol ID)
	pushl(0xad8)                  // filename ptr
	pushw(0)                      // permissions
	tHOpenResFile()
	if popw() != 2 {
		panic("Failed to open own System file")
	}

	writel(0xa54, readl(0xa50)) // SysMapHndl = TopMapHndl
	writew(0xa58, readw(0xa5a)) // SysMap = CurMap

	// Strategies to find an MPW distribution
	var search []string
	if mpw, ok := os.LookupEnv("MPW"); ok {
		mpw = fix83Names(mpw)
		search = append(search, mpw)
	} else {
		if home, err := os.UserHomeDir(); err == nil {
			home = fix83Names(home)
			search = append(search, platPathJoin(home, "MPW"))
		}

		// Cheating way of finding Unix paths
		if os.PathSeparator == '/' {
			search = append(search, "/usr/local/share/mpw")
			search = append(search, "/usr/share/mpw")
		}
	}

	// Try to launch ToolServer from each candidate
	refNum := uint16(0xffff)
	for _, try := range search {
		try = platPathJoin(try, "ToolServer")

		macPath, ok := unicodeToMac(platPathToMac(try))
		if !ok {
			continue
		}

		pathPtr, oldsp := pushzero(256)
		writePstring(pathPtr, macPath)

		pushw(0)       // refnum return
		pushl(pathPtr) // pointer to the file string
		lineA(0xa997)  // _OpenResFile
		refNum = popw()

		writel(spptr, oldsp)

		if refNum != 0xffff {
			break // Success!
		}
	}

	if refNum == 0xffff {
		logf("MPW not yet installed. Run: %s -install", os.Args[0])
		os.Exit(1)
	}

	tsRefNum = refNum
	writew(0x900, refNum) // CurApRefNum
	mpwFolder = platPathDir(openPaths[refNum].hostpath)
	dirIDs[curDirID] = mpwFolder // ToolServer uses GetVol to find its containing dir

	pushl(0)          // handle return
	pushl(0x434f4445) // CODE
	pushw(0)          // ID 0
	lineA(0xa9a0)     // _GetResource
	code0 := popl()
	code0 = readl(code0) // handle to pointer

	jtsize := readl(code0 + 8)
	jtoffset := readl(code0 + 12)

	writel(0x934, jtoffset) // CurJTOffset
	copy(mem[kA5World+jtoffset:][:jtsize], mem[code0+16:][:jtsize])

	initPuppetStrings(os.Args[1:])

	run68(kA5World + jtoffset + 2)
}

func printUsageAndQuit() {
	fmt.Print(kUsage)
	os.Exit(1)
}

// Trap Dispatcher
// - my_traps function list is set up in main() above
// - A-trap handler dispatches according to the trap table
// - F-trap handler calls the Go routine directly

const os_base = 0
const tb_base = 0x100

var my_traps [0x500]func()

func lineA(inst uint16) {
	if gDebugAny {
		logTrap(inst, true)
		defer logTrap(inst, false)
	}

	check_for_lurkers()

	unimp := readl(kToolTable + 4*0x9f)

	if inst&0x800 != 0 { // Toolbox trap
		num := uint32(inst & 0x3ff)

		// If autoPop then discard pc and use return address on stack
		if inst&0x400 != 0 {
			pc = popl()
		}

		imp := readl(kToolTable + 4*num)
		if imp == unimp {
			panic("unimplemented trap")
		}

		defaultImp := executable_ftrap(0xf800 | uint16(inst))

		if num == 0x1f0 {
			// LoadSeg does arithmetic on the return address
			// We must therefore give it the real return address
			// Never call lineA(LoadSeg) outside of the emulator!
			pushl(pc)
			pc = imp // and let the emulator run...
		} else if imp == defaultImp { // direct Go call
			my_traps[tb_base+(inst&0x3ff)]()
		} else {
			run68(imp)
		}
	} else { // OS trap
		pushl(readl(a2ptr))
		pushl(readl(d2ptr))
		pushl(readl(d1ptr))
		pushl(readl(a1ptr))
		if inst&0x100 == 0 {
			pushl(readl(a0ptr))
		}

		writew(d1ptr+2, inst)

		imp := readl(kOSTable + 4*(uint32(inst)&0xff))
		if imp == unimp {
			panic("unimplemented trap")
		}

		defaultImp := executable_ftrap(0xf000 | (inst & 0xff))
		if imp == defaultImp { // direct Go call
			my_traps[os_base+(inst&0xff)]()
		} else {
			run68(imp)
		}

		if inst&0x100 == 0 {
			writel(a0ptr, popl())
		}
		writel(a1ptr, popl())
		writel(d1ptr, popl())
		writel(d2ptr, popl())
		writel(a2ptr, popl())

		// tst.w d0
		d0 := readw(d0ptr + 2)
		n = d0&0x8000 != 0
		z = d0 == 0
	}
}

// To run the default implementation of a trap,
// execute Fxxx with the return address already on the stack.
// Only used when the app uses the result of GetTrapAddress(),
// or when the quirky LoadSeg trap runs.
func lineF(inst uint16) {
	pc = popl()
	check_for_lurkers()

	if inst&0x800 != 0 { // Go implementation of Toolbox trap
		my_traps[tb_base+(inst&0x3ff)]()
	} else { // Go implementation of OS trap
		my_traps[os_base+(inst&0xff)]()
	}
}

// For historical reasons, unflagged Get/SetTrapAddress need to guess between OS/TB traps
func trapTableEntry(requested_trap uint16, requesting_trap uint16) uint32 {
	if requesting_trap&0x200 != 0 { // newOS/newTool trap
		if requesting_trap&0x400 != 0 {
			return kToolTable + 4*uint32(requested_trap&0x3ff)
		} else {
			return kOSTable + 4*uint32(requested_trap&0xff)
		}
	} else { // guess, using traditional trap numbering
		requested_trap &= 0x1ff // 64k ROM had a single 512-entry trap table
		if requested_trap <= 0x4f || requested_trap == 0x54 || requested_trap == 0x57 {
			return kOSTable + 4*uint32(requested_trap)
		} else {
			return kToolTable + 4*uint32(requested_trap)
		}
	}
}

func tGetTrapAddress() {
	tableEntry := trapTableEntry(readw(d0ptr+2), readw(d1ptr+2))
	writel(a0ptr, readl(tableEntry))
}

func tSetTrapAddress() {
	tableEntry := trapTableEntry(readw(d0ptr+2), readw(d1ptr+2))
	writel(tableEntry, readl(a0ptr))
}

// Get a reserved address, containing an F-trap, that can be run as code
func executable_ftrap(trap uint16) (addr uint32) {
	addr = kFTrapTable + (uint32(trap)&0xfff)*16

	writew(addr, trap)

	return
}

// Expensive cleanup on function call (JSR), return (RTS) and A-trap
func check_for_lurkers() {
	// we might do more involved things here, like check for heap corruption
	for i := uint32(0); i < 64; i++ {
		mem[i] = 0
	}
}

// Placeholder trap in the A5-based dispatch table
// _UnLoadSeg not implemented because we do not purge resources
func tLoadSeg() {
	save := readRegs()

	segNum := popw()
	pushl(0)
	pushl(0x434f4445) // CODE
	pushw(segNum)
	lineA(0xa9a0) // _GetResource
	segPtr := readl(popl())

	offset := uint32(readw(segPtr))    // offset of first entry within jump table
	count := uint32(readw(segPtr + 2)) // number of jump table entries

	for i := uint32(0); i < count; i++ {
		jtEntry := readl(a5ptr) + 0x20 + offset + 8*i

		offsetInSegment := readw(jtEntry)
		writew(jtEntry, segNum)
		writew(jtEntry+2, 0x4ef9) // jmp
		writel(jtEntry+4, segPtr+4+uint32(offsetInSegment))
	}

	pc -= 6

	writeRegs(save, a0ptr, a1ptr, d0ptr, d1ptr, d2ptr) // ??? really need to do this?
}

// Informational message that would bomb if MacsBug weren't installed
func tDebugStr() {
	string := readPstring(popl())
	fmt.Println(macToUnicode(string))
}

// "Bomb" error
func tSysError() {
	err := int16(readw(d0ptr + 2))
	panicstr := fmt.Sprintf("_SysError %d", err)
	if err == -491 { // display string on stack
		panicstr += macToUnicode(readPstring(popl()))
	}
	panic(panicstr)
}

// Baby version of Gestalt
// TODO: should match the SysEnvirons routine in the MPW libraries
func tSysEnvirons() {
	block := readl(a0ptr)

	for i := uint32(0); i < 16; i++ {
		writeb(block+i, 0)
	}

	writew(block, 2)                      // environsVersion = 2
	writew(block+2, 4)                    // machineType = II
	writew(block+4, readw(0x15a))         // systemVersion
	writew(block+6, uint16(readb(0x12f))) // processor = 68020
	writel(d0ptr, 0)                      // noErr
}

// Key-value storage to test for presence of OS features
func tGestalt() {
	trap := readw(d1ptr + 2)
	selector := string(mem[d0ptr:][:4])

	if trap&0x600 == 0 { // ab=00
		var reply uint32
		var err int
		switch selector {
		case "sysv":
			reply = uint32(readw(0x15a)) // SysVersion
		case "ostt":
			reply = kOSTable
		case "tbtt":
			reply = kToolTable
		case "ram ":
			reply = kLowestIllegal
		case "fs  ":
			reply = 2 // FSSpec calls, not much else
		case "alis":
			reply = 1 // Alias Manager present
			// Enables MPWLibs' more capable path processing
		case "fold":
			reply = 1 // Folder Manager present
		case "mach":
			reply = 6 // Mac II
		case "proc":
			reply = uint32(readb(0x12f)) + 1 // CPUFlag
		case "addr":
			reply = 7 // all the 32-bit flags
		default:
			err = -5551 // gestaltUndefSelectorErr
		}

		writel(a0ptr, reply)
		writel(d0ptr, uint32(err))

	} else if trap&0x600 == 0x200 { // ab=01
		panic("NewGestalt unimplemented")

	} else if trap&0x600 == 0x400 { // ab=10
		panic("ReplaceGestalt unimplemented")

	} else { // ab=11
		panic("GetGestaltProcPtr unimplemented")
	}
}

func tGetOSEvent() {
	evt := readl(a0ptr)
	for i := uint32(0); i < 16; i++ { // null event
		writeb(evt+i, 0)
	}
	writel(d0ptr, 0xffffffff)
}

type exitToShell struct{}

func tExitToShell() {
	panic(exitToShell{})
}

// MultiFinder/ProcessManager routines
func tOSDispatch() {
	selector := popw()

	switch selector {
	case 0x37: // FUNCTION GetCurrentProcess (VAR PSN: ProcessSerialNumber): OSErr;
		psn := popl()
		writed(psn, 1)
		writew(readl(spptr), 0)

	case 0x38: // FUNCTION GetNextProcess (VAR PSN: ProcessSerialNumber): OSErr;
		psn := popl()
		switch readd(psn) {
		case 0: // kNoProcess
			writed(psn, 1)          // our process
			writew(readl(spptr), 0) // noErr
		case 1: // our process
			writed(psn, 0)                    // kNoProcess
			writew(readl(spptr), 0xffff&-600) // procNotFound
		default: // nonsense value
			writed(psn, 0)                   // kNoProcess
			writew(readl(spptr), 0xffff&-50) // paramErr
		}

	case 0x3a: // FUNCTION GetProcessInformation (PSN: ProcessSerialNumber; VAR info: ProcessInfoRec): OSErr;
		info := popl()
		psn := popl()

		// Nonsense process
		if readd(psn) != 1 {
			writew(readl(spptr), 0xffff&-600) // procNotFound
			return
		}

		// Reasonable size parameter
		infoLen := readl(info)
		if infoLen < 60 {
			panic("Extended GetProcessInformation")
			writew(readl(spptr), 0xffff&-50) // paramErr
		}

		processName := readl(info + 4)
		if processName != 0 {
			writePstring(processName, macstring("ToolServer"))
		}

		processAppSpec := readl(info + 56)
		if processAppSpec != 0 { // construct our own FSSpec
			fcb := fcbFromRefnum(readw(0x900)) // CurApRefNum
			fcbVPtr := readl(fcb + 20)
			vcbVRefNum := readw(fcbVPtr + 78)
			fcbDirID := readl(fcb + 58)
			fcbCName := readPstring(fcb + 62)
			writew(processAppSpec, vcbVRefNum)
			writel(processAppSpec+2, fcbDirID)
			writePstring(processAppSpec+6, fcbCName)
		}

		writed(info+8, 1)           // processNumber
		writel(info+16, 0x4150504c) // processType = APPL
		writel(info+20, 0x4d505358) // processSignature = MPSX
		writel(info+24, 0)          // processMode
		writel(info+28, kHeap)      // processLocation
		writel(info+32, 0x7ffffffe) // processSize
		writel(info+36, 0x7ffffffe) // processFreeMem
		writed(info+40, 0)          // processLauncher = kNoProcess
		writel(info+48, 1)          // processLaunchDate
		writel(info+52, 1)          // processActiveTime

	case 0x15, 0x16, 0x18, 0x1d, 0x1e, 0x1f, 0x20:
		mfMemRoutine(selector)

	default:
		panic(fmt.Sprintf("OSDispatch 0x%x unimplemented", selector))
	}
}

func tTickCount() {
	writel(readl(spptr), readl(0x16a))
}

func tMicroseconds() {
	ticks := readl(0x16a)
	usec := uint64(ticks) * 1000000 / 60
	writel(a0ptr, uint32(usec>>32))
	writel(d0ptr, uint32(usec))
}

func tReadDateTime() {
	writel(readl(a0ptr), readl(0x20c)) // Time into buffer
	writel(d0ptr, 0)                   // noErr
}

func tSetDateTime() {
	writel(0x20c, readl(d0ptr)) // register into Time
	writel(d0ptr, 0)            // noErr
}

// Trivial do-nothing traps

func tUnimplemented() {
	panic("unimplemented trap")
}

func tNop() {
}

func tClrD0() {
	writel(d0ptr, 0)
}

func tClrD0A0() {
	writel(d0ptr, 0)
	writel(a0ptr, 0)
}

func tPop2() {
	writel(spptr, readl(spptr)+2)
}

func tPop4() {
	writel(spptr, readl(spptr)+4)
}

func tPop6() {
	writel(spptr, readl(spptr)+6)
}

func tPop8() {
	writel(spptr, readl(spptr)+8)
}

func tPop10() {
	writel(spptr, readl(spptr)+10)
}

func tRetZero() {
	writel(readl(spptr), 0)
}

func tPop2RetZero() {
	sp := readl(spptr) + 2
	writel(spptr, sp)
	writel(sp, 0)
}

func tPop4RetZero() {
	sp := readl(spptr) + 4
	writel(spptr, sp)
	writel(sp, 0)
}

func tPop4RetZeroW() {
	sp := readl(spptr) + 4
	writel(spptr, sp)
	writew(sp, 0)
}

func tPop6RetZero() {
	sp := readl(spptr) + 6
	writel(spptr, sp)
	writel(sp, 0)
}

func tPop8RetZero() {
	sp := readl(spptr) + 8
	writel(spptr, sp)
	writel(sp, 0)
}

func tPop10RetZero() {
	sp := readl(spptr) + 10
	writel(spptr, sp)
	writel(sp, 0)
}

func tParamBlkNop() {
	pb := readl(a0ptr)
	writew(pb+16, 0)
	writel(d0ptr, 0)
}
