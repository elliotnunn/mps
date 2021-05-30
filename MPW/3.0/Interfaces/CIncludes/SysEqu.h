/************************************************************

Created: Tuesday, October 25, 1988 at 12:20 PM
    SysEqu.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1988 
    All rights reserved

************************************************************/


#ifndef __SYSEQU__
#define __SYSEQU__

#define PCDeskPat 0x20B         /* desktop pat, top bit only! others are in use*/
#define HiKeyLast 0x216         /* Same as KbdVars*/
#define KbdLast 0x218           /* Same as KbdVars+2*/
#define ExpandMem 0x2B6         /* pointer to expanded memory block*/
#define SCSIBase 0x0C00         /* (long) base address for SCSI chip read*/
#define SCSIDMA 0x0C04          /* (long) base address for SCSI DMA*/
#define SCSIHsk 0x0C08          /* (long) base address for SCSI handshake*/
#define SCSIGlobals 0x0C0C      /* (long) ptr for SCSI mgr locals*/
#define RGBBlack 0x0C10         /* (6 bytes) the black field for color*/
#define RGBWhite 0x0C16         /* (6 bytes) the white field for color*/
#define RowBits 0x0C20          /* (word) screen horizontal pixels*/
#define ColLines 0x0C22         /* (word) screen vertical pixels*/
#define ScreenBytes 0x0C24      /* (long) total screen bytes*/
#define NMIFlag 0x0C2C          /* (byte) flag for NMI debounce*/
#define VidType 0x0C2D          /* (byte) video board type ID*/
#define VidMode 0x0C2E          /* (byte) video mode (4=4bit color)*/
#define SCSIPoll 0x0C2F         /* (byte) poll for device zero only once.*/
#define SEVarBase 0x0C30
#define MMUFlags 0x0CB0         /* (byte) cleared to zero (reserved for future use)*/
#define MMUType 0x0CB1          /* (byte) kind of MMU present*/
#define MMU32bit 0x0CB2         /* (byte) boolean reflecting current machine MMU mode*/
#define MMUFluff 0x0CB3         /* (byte) fluff byte forced by reducing MMUMode to MMU32bit.*/
#define MMUTbl 0x0CB4           /* (long) pointer to MMU Mapping table*/
#define MMUTblSize 0x0CB8       /* (long) size of the MMU mapping table*/
#define SInfoPtr 0x0CBC         /* (long) pointer to Slot manager information*/
#define ASCBase 0x0CC0          /* (long) pointer to Sound Chip*/
#define SMGlobals 0x0CC4        /* (long) pointer to Sound Manager Globals*/
#define TheGDevice 0x0CC8       /* (long) the current graphics device*/
#define CQDGlobals 0x0CCC       /* (long) quickDraw global extensions*/
#define ADBBase 0x0CF8          /* (long) pointer to Front Desk Buss Variables*/
#define WarmStart 0x0CFC        /* (long) flag to indicate it is a warm start*/
#define TimeDBRA 0x0D00         /* (word) number of iterations of DBRA per millisecond*/
#define TimeSCCDB 0x0D02        /* (word) number of iter's of SCC access & DBRA.*/
#define SlotQDT 0x0D04          /* ptr to slot queue table*/
#define SlotPrTbl 0x0D08        /* ptr to slot priority table*/
#define SlotVBLQ 0x0D0C         /* ptr to slot VBL queue table*/
#define ScrnVBLPtr 0x0D10       /* save for ptr to main screen VBL queue*/
#define SlotTICKS 0x0D14        /* ptr to slot tickcount table*/
#define TableSeed 0x0D20        /* (long) seed value for color table ID's*/
#define SRsrcTblPtr 0x0D24      /* (long) pointer to slot resource table.*/
#define JVBLTask 0x0D28         /* vector to slot VBL task interrupt handler*/
#define WMgrCPort 0x0D2C        /* window manager color port */
#define VertRRate 0x0D30        /* (word) Vertical refresh rate for start manager. */
#define ChunkyDepth 0x0D60      /* depth of the pixels*/
#define CrsrPtr 0x0D62          /* pointer to cursor save area*/
#define PortList 0x0D66         /* list of grafports*/
#define MickeyBytes 0x0D6A      /* long pointer to cursor stuff*/
#define QDErrLM 0x0D6E          /*QDErr has name conflict w/ type. QuickDraw error code [word]*/
#define VIA2DT 0x0D70           /* 32 bytes for VIA2 dispatch table for NuMac*/
#define SInitFlags 0x0D90       /* StartInit.a flags [word]*/
#define DTQueue 0x0D92          /* (10 bytes) deferred task queue header*/
#define DTQFlags 0x0D92         /* flag word for DTQueue*/
#define DTskQHdr 0x0D94         /* ptr to head of queue*/
#define DTskQTail 0x0D98        /* ptr to tail of queue*/
#define JDTInstall 0x0D9C       /* (long) ptr to deferred task install routine*/
#define HiliteRGB 0x0DA0        /* 6 bytes: rgb of hilite color*/
#define TimeSCSIDB 0x0DA6       /* (word) number of iter's of SCSI access & DBRA*/
#define DSCtrAdj 0x0DA8         /* (long) Center adjust for DS rect.*/
#define IconTLAddr 0x0DAC       /* (long) pointer to where start icons are to be put.*/
#define VideoInfoOK 0x0DB0      /* (long) Signals to CritErr that the Video card is ok*/
#define EndSRTPtr 0x0DB4        /* (long) Pointer to the end of the Slot Resource Table (Not the SRT buffer).*/
#define SDMJmpTblPtr 0x0DB8     /* (long) Pointer to the SDM jump table*/
#define JSwapMMU 0x0DBC         /* (long) jump vector to SwapMMU routine*/
#define SdmBusErr 0x0DC0        /* (long) Pointer to the SDM busErr handler*/
#define LastTxGDevice 0x0DC4    /* (long) copy of TheGDevice set up for fast text measure*/
#define NewCrsrJTbl 0x88C       /* location of new crsr jump vectors*/
#define JAllocCrsr 0x88C        /* (long) vector to routine that allocates cursor*/
#define JSetCCrsr 0x890         /* (long) vector to routine that sets color cursor*/
#define JOpcodeProc 0x894       /* (long) vector to process new picture opcodes*/
#define CrsrBase 0x898          /* (long) scrnBase for cursor*/
#define CrsrDevice 0x89C        /* (long) current cursor device*/
#define SrcDevice 0x8A0         /* (LONG) Src device for Stretchbits*/
#define MainDevice 0x8A4        /* (long) the main screen device*/
#define DeviceList 0x8A8        /* (long) list of display devices*/
#define CrsrRow 0x8AC           /* (word) rowbytes for current cursor screen*/
#define QDColors 0x8B0          /* (long) handle to default colors*/
#define HiliteMode 0x938        /* used for color highlighting*/
#define BusErrVct 0x08          /* bus error vector*/
#define RestProc 0xA8C          /* Resume procedure f InitDialogs [pointer]*/
#define ROM85 0x28E             /* (word) actually high bit - 0 for ROM vers $75 (sic) and later*/
#define ROMMapHndl 0xB06        /* (long) handle of ROM resource map*/
#define ScrVRes 0x102           /* screen vertical dots/inch [word]*/
#define ScrHRes 0x104           /* screen horizontal dots/inch [word]*/
#define ScrnBase 0x824          /* Screen Base [pointer]*/
#define ScreenRow 0x106         /* rowBytes of screen [word]*/
#define MBTicks 0x16E           /* tick count @ last mouse button [long]*/
#define JKybdTask 0x21A         /* keyboard VBL task hook [pointer]*/
#define KeyLast 0x184           /* ASCII for last valid keycode [word]*/
#define KeyTime 0x186           /* tickcount when KEYLAST was rec'd [long]*/
#define KeyRepTime 0x18A        /* tickcount when key was last repeated [long]*/
#define SPConfig 0x1FB          /* config bits: 4-7 A, 0-3 B (see use type below)*/
#define SPPortA 0x1FC           /* SCC port A configuration [word]*/
#define SPPortB 0x1FE           /* SCC port B configuration [word]*/
#define SCCRd 0x1D8             /* SCC base read address [pointer]*/
#define SCCWr 0x1DC             /* SCC base write address [pointer]*/
#define DoubleTime 0x2F0        /* double click ticks [long]*/
#define CaretTime 0x2F4         /* caret blink ticks [long]*/
#define KeyThresh 0x18E         /* threshold for key repeat [word]*/
#define KeyRepThresh 0x190      /* key repeat speed [word]*/
#define SdVolume 0x260          /* Global volume(sound) control [byte]*/
#define Ticks 0x16A             /* Tick count, time since boot [unsigned long]*/
#define TimeLM 0x20C            /*Time has name conflict w/ type. Clock time (extrapolated) [long]*/
#define MonkeyLives 0x100       /* monkey lives if >= 0 [word]*/
#define SEvtEnb 0x15C           /* enable SysEvent calls from GNE [byte]*/
#define JournalFlag 0x8DE       /* journaling state [word]*/
#define JournalRef 0x8E8        /* Journalling driver's refnum [word]*/
#define BufPtr 0x10C            /* top of application memory [pointer]*/
#define StkLowPt 0x110          /* Lowest stack as measured in VBL task [pointer]*/
#define TheZone 0x118           /* current heap zone [pointer]*/
#define ApplLimit 0x130         /* application limit [pointer]*/
#define SysZone 0x2A6           /* system heap zone [pointer]*/
#define ApplZone 0x2AA          /* application heap zone [pointer]*/
#define HeapEnd 0x114           /* end of heap [pointer]*/
#define HiHeapMark 0xBAE        /* (long) highest address used by a zone below sp<01Nov85 JTC>*/
#define MemErr 0x220            /* last memory manager error [word]*/
#define UTableBase 0x11C        /* unit I/O table [pointer]*/
#define UnitNtryCnt 0x1D2       /* count of entries in unit table [word]*/
#define JFetch 0x8F4            /* fetch a byte routine for drivers [pointer]*/
#define JStash 0x8F8            /* stash a byte routine for drivers [pointer]*/
#define JIODone 0x8FC           /* IODone entry location [pointer]*/
#define DrvQHdr 0x308           /* queue header of drives in system [10 bytes]*/
#define BootDrive 0x210         /* drive number of boot drive [word]*/
#define EjectNotify 0x338       /* eject notify procedure [pointer]*/
#define IAZNotify 0x33C         /* world swaps notify procedure [pointer]*/
#define SFSaveDisk 0x214        /* last vRefNum seen by standard file [word]*/
#define CurDirStore 0x398       /* save dir across calls to Standard File [long]*/
#define OneOne 0xA02            /* constant $00010001 [long]*/
#define MinusOne 0xA06          /* constant $FFFFFFFF [long]*/
#define Lo3Bytes 0x31A          /* constant $00FFFFFF [long]*/
#define ROMBase 0x2AE           /* ROM base address [pointer]*/
#define RAMBase 0x2B2           /* RAM base address [pointer]*/
#define SysVersion 0x15A        /* version # of RAM-based system [word]*/
#define RndSeed 0x156           /* random seed/number [long]*/
#define Scratch20 0x1E4         /* scratch [20 bytes]*/
#define Scratch8 0x9FA          /* scratch [8 bytes]*/
#define ScrapSize 0x960         /* scrap length [long]*/
#define ScrapHandle 0x964       /* memory scrap [handle]*/
#define ScrapCount 0x968        /* validation byte [word]*/
#define ScrapState 0x96A        /* scrap state [word]*/
#define ScrapName 0x96C         /* pointer to scrap name [pointer]*/
#define IntlSpec 0xBA0          /* (long) - ptr to extra Intl data */
#define SwitcherTPtr 0x286      /* Switcher's switch table */
#define CPUFlag 0x12F           /* $00=68000, $01=68010, $02=68020 (old ROM inits to $00)*/
#define VIA 0x1D4               /* VIA base address [pointer]*/
#define IWM 0x1E0               /* IWM base address [pointer]*/
#define Lvl1DT 0x192            /* Interrupt level 1 dispatch table [32 bytes]*/
#define Lvl2DT 0x1B2            /* Interrupt level 2 dispatch table [32 bytes]*/
#define ExtStsDT 0x2BE          /* SCC ext/sts secondary dispatch table [16 bytes]*/
#define SPValid 0x1F8           /* validation field ($A7) [byte]*/
#define SPATalkA 0x1F9          /* AppleTalk node number hint for port A*/
#define SPATalkB 0x1FA          /* AppleTalk node number hint for port B*/
#define SPAlarm 0x200           /* alarm time [long]*/
#define SPFont 0x204            /* default application font number minus 1 [word]*/
#define SPKbd 0x206             /* kbd repeat thresh in 4/60ths [2 4-bit]*/
#define SPPrint 0x207           /* print stuff [byte]*/
#define SPVolCtl 0x208          /* volume control [byte]*/
#define SPClikCaret 0x209       /* double click/caret time in 4/60ths[2 4-bit]*/
#define SPMisc1 0x20A           /* miscellaneous [1 byte]*/
#define SPMisc2 0x20B           /* miscellaneous [1 byte]*/
#define GetParam 0x1E4          /* system parameter scratch [20 bytes]*/
#define SysParam 0x1F8          /* system parameter memory [20 bytes]*/
#define CrsrThresh 0x8EC        /* delta threshold for mouse scaling [word]*/
#define JCrsrTask 0x8EE         /* address of CrsrVBLTask [long]*/
#define MTemp 0x828             /* Low-level interrupt mouse location [long]*/
#define RawMouse 0x82C          /* un-jerked mouse coordinates [long]*/
#define CrsrRect 0x83C          /* Cursor hit rectangle [8 bytes]*/
#define TheCrsr 0x844           /* Cursor data, mask & hotspot [68 bytes]*/
#define CrsrAddr 0x888          /* Address of data under cursor [long]*/
#define CrsrSave 0x88C          /* data under the cursor [64 bytes]*/
#define CrsrVis 0x8CC           /* Cursor visible? [byte]*/
#define CrsrBusy 0x8CD          /* Cursor locked out? [byte]*/
#define CrsrNew 0x8CE           /* Cursor changed? [byte]*/
#define CrsrState 0x8D0         /* Cursor nesting level [word]*/
#define CrsrObscure 0x8D2       /* Cursor obscure semaphore [byte]*/
#define KbdVars 0x216           /* Keyboard manager variables [4 bytes]*/
#define KbdType 0x21E           /* keyboard model number [byte]*/
#define MBState 0x172           /* current mouse button state [byte]*/
#define KeyMapLM 0x174          /*KeyMap has name conflict w/ type. Bitmap of the keyboard [2 longs]*/
#define KeypadMap 0x17C         /* bitmap for numeric pad-18bits [long]*/
#define Key1Trans 0x29E         /* keyboard translator procedure [pointer]*/
#define Key2Trans 0x2A2         /* numeric keypad translator procedure [pointer]*/
#define JGNEFilter 0x29A        /* GetNextEvent filter proc [pointer]*/
#define KeyMVars 0xB04          /* (word) for ROM KEYM proc state*/
#define Mouse 0x830             /* processed mouse coordinate [long]*/
#define CrsrPin 0x834           /* cursor pinning rectangle [8 bytes]*/
#define CrsrCouple 0x8CF        /* cursor coupled to mouse? [byte]*/
#define CrsrScale 0x8D3         /* cursor scaled? [byte]*/
#define MouseMask 0x8D6         /* V-H mask for ANDing with mouse [long]*/
#define MouseOffset 0x8DA       /* V-H offset for adding after ANDing [long]*/
#define AlarmState 0x21F        /* Bit7=parity, Bit6=beeped, Bit0=enable [byte]*/
#define VBLQueue 0x160          /* VBL queue header [10 bytes]*/
#define SysEvtMask 0x144        /* system event mask [word]*/
#define SysEvtBuf 0x146         /* system event queue element buffer [pointer]*/
#define EventQueue 0x14A        /* event queue header [10 bytes]*/
#define EvtBufCnt 0x154         /* max number of events in SysEvtBuf - 1 [word]*/
#define GZRootHnd 0x328         /* root handle for GrowZone [handle]*/
#define GZRootPtr 0x32C         /* root pointer for GrowZone [pointer]*/
#define GZMoveHnd 0x330         /* moving handle for GrowZone [handle]*/
#define MemTop 0x108            /* top of memory [pointer]*/
#define MmInOK 0x12E            /* initial memory mgr checks ok? [byte]*/
#define HpChk 0x316             /* heap check RAM code [pointer]*/
#define MaskBC 0x31A            /* Memory Manager Byte Count Mask [long]*/
#define MaskHandle 0x31A        /* Memory Manager Handle Mask [long]*/
#define MaskPtr 0x31A           /* Memory Manager Pointer Mask [long]*/
#define MinStack 0x31E          /* min stack size used in InitApplZone [long]*/
#define DefltStack 0x322        /* default size of stack [long]*/
#define MMDefFlags 0x326        /* default zone flags [word]*/
#define DSAlertTab 0x2BA        /* system error alerts [pointer]*/
#define DSAlertRect 0x3F8       /* rectangle for disk-switch alert [8 bytes]*/
#define DSDrawProc 0x334        /* alternate syserror draw procedure [pointer]*/
#define DSWndUpdate 0x15D       /* GNE not to paintBehind DS AlertRect? [byte]*/
#define WWExist 0x8F2           /* window manager initialized? [byte]*/
#define QDExist 0x8F3           /* quickdraw is initialized [byte]*/
#define ResumeProc 0xA8C        /* Resume procedure from InitDialogs [pointer]*/
#define DSErrCode 0xAF0         /* last system error alert ID*/
#define IntFlag 0x15F           /* reduce interrupt disable time when bit 7 = 0*/
#define SerialVars 0x2D0        /* async driver variables [16 bytes]*/
#define ABusVars 0x2D8          /*;Pointer to AppleTalk local variables*/
#define ABusDCE 0x2DC           /*;Pointer to AppleTalk DCE*/
#define PortAUse 0x290          /* bit 7: 1 = not in use, 0 = in use*/
#define PortBUse 0x291          /* port B use, same format as PortAUse*/
#define SCCASts 0x2CE           /* SCC read reg 0 last ext/sts rupt - A [byte]*/
#define SCCBSts 0x2CF           /* SCC read reg 0 last ext/sts rupt - B [byte]*/
#define DskErr 0x142            /* disk routine result code [word]*/
#define PWMBuf2 0x312           /* PWM buffer 1 (or 2 if sound) [pointer]*/
#define SoundPtr 0x262          /* 4VE sound definition table [pointer]*/
#define SoundBase 0x266         /* sound bitMap [pointer]*/
#define SoundVBL 0x26A          /* vertical retrace control element [16 bytes]*/
#define SoundDCE 0x27A          /* sound driver DCE [pointer]*/
#define SoundActive 0x27E       /* sound is active? [byte]*/
#define SoundLevel 0x27F        /* current level in buffer [byte]*/
#define CurPitch 0x280          /* current pitch value [word]*/
#define DskVerify 0x12C         /* used by 3.5 disk driver for read/verify [byte]*/
#define TagData 0x2FA           /* sector tag info for disk drivers [14 bytes]*/
#define BufTgFNum 0x2FC         /* file number [long]*/
#define BufTgFFlg 0x300         /* flags [word]*/
#define BufTgFBkNum 0x302       /* logical block number [word]*/
#define BufTgDate 0x304         /* time stamp [word]*/
#define ScrDmpEnb 0x2F8         /* screen dump enabled? [byte]*/
#define ScrDmpType 0x2F9        /* FF dumps screen, FE dumps front window [byte]*/
#define ScrapVars 0x960         /* scrap manager variables [32 bytes]*/
#define ScrapInfo 0x960         /* scrap length [long]*/
#define ScrapEnd 0x980          /* end of scrap vars*/
#define ScrapTag 0x970          /* scrap file name [STRING[15]]*/
#define LaunchFlag 0x902        /* from launch or chain [byte]*/
#define SaveSegHandle 0x930     /* seg 0 handle [handle]*/
#define CurJTOffset 0x934       /* current jump table offset [word]*/
#define CurPageOption 0x936     /* current page 2 configuration [word]*/
#define LoaderPBlock 0x93A      /* param block for ExitToShell [10 bytes]*/
#define CurApRefNum 0x900       /* refNum of application's resFile [word]*/
#define CurrentA5 0x904         /* current value of A5 [pointer]*/
#define CurStackBase 0x908      /* current stack base [pointer]*/
#define CurApName 0x910         /* name of application [STRING[31]]*/
#define LoadTrap 0x12D          /* trap before launch? [byte]*/
#define SegHiEnable 0xBB2       /* (byte) 0 to disable MoveHHi in LoadSeg*/

/* Window Manager Globals */

#define WindowList 0x9D6        /*Z-ordered linked list of windows [pointer]*/
#define PaintWhite 0x9DC        /*erase newly drawn windows? [word]*/
#define WMgrPort 0x9DE          /*window manager's grafport [pointer]*/
#define GrayRgn 0x9EE           /*rounded gray desk region [handle]*/
#define CurActivate 0xA64       /*window slated for activate event [pointer]*/
#define CurDeactive 0xA68       /*window slated for deactivate event [pointer]*/
#define DragHook 0x9F6          /*user hook during dragging [pointer]*/
#define DeskPattern 0xA3C       /*desk pattern [8 bytes]*/
#define DeskHook 0xA6C          /*hook for painting the desk [pointer]*/
#define GhostWindow 0xA84       /*window hidden from FrontWindow [pointer]*/

/* Text Edit Globals */

#define TEDoText 0xA70          /*textEdit doText proc hook [pointer]*/
#define TERecal 0xA74           /*textEdit recalText proc hook [pointer]*/
#define TEScrpLength 0xAB0      /*textEdit Scrap Length [word]*/
#define TEScrpHandle 0xAB4      /*textEdit Scrap [handle]*/
#define TEWdBreak 0xAF6         /*default word break routine [pointer]*/
#define WordRedraw 0xBA5        /*(byte) - used by TextEdit RecalDraw*/
#define TESysJust 0xBAC         /*(word) system justification (intl. textEdit)*/

/* Resource Manager Globals */

#define TopMapHndl 0xA50        /*topmost map in list [handle]*/
#define SysMapHndl 0xA54        /*system map [handle]*/
#define SysMap 0xA58            /*reference number of system map [word]*/
#define CurMap 0xA5A            /*reference number of current map [word]*/
#define ResReadOnly 0xA5C       /*Read only flag [word]*/
#define ResLoad 0xA5E           /*Auto-load feature [word]*/
#define ResErr 0xA60            /*Resource error code [word]*/
#define ResErrProc 0xAF2        /*Resource error procedure [pointer]*/
#define SysResName 0xAD8        /*Name of system resource file [STRING[19]]*/
#define RomMapInsert 0xB9E      /*(byte) determines if we should link in map*/
#define TmpResLoad 0xB9F        /*second byte is temporary ResLoad value.*/


#endif
