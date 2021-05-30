/************************************************************

Created: Thursday, September 7, 1989 at 7:49 PM
	SysEqu.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1989
	All rights reserved

************************************************************/


#ifndef __SYSEQU__
#define __SYSEQU__

#define PCDeskPat 0x20B 		/*[GLOBAL VAR]	desktop pat, top bit only! others are in use*/
#define HiKeyLast 0x216 		/*[GLOBAL VAR]	Same as KbdVars*/
#define KbdLast 0x218			/*[GLOBAL VAR]	Same as KbdVars+2*/
#define ExpandMem 0x2B6 		/*[GLOBAL VAR]	pointer to expanded memory block*/
#define SCSIBase 0x0C00 		/*[GLOBAL VAR]	(long) base address for SCSI chip read*/
#define SCSIDMA 0x0C04			/*[GLOBAL VAR]	(long) base address for SCSI DMA*/
#define SCSIHsk 0x0C08			/*[GLOBAL VAR]	(long) base address for SCSI handshake*/
#define SCSIGlobals 0x0C0C		/*[GLOBAL VAR]	(long) ptr for SCSI mgr locals*/
#define RGBBlack 0x0C10 		/*[GLOBAL VAR]	(6 bytes) the black field for color*/
#define RGBWhite 0x0C16 		/*[GLOBAL VAR]	(6 bytes) the white field for color*/
#define RowBits 0x0C20			/*[GLOBAL VAR]	(word) screen horizontal pixels*/
#define ColLines 0x0C22 		/*[GLOBAL VAR]	(word) screen vertical pixels*/
#define ScreenBytes 0x0C24		/*[GLOBAL VAR]	(long) total screen bytes*/
#define NMIFlag 0x0C2C			/*[GLOBAL VAR]	(byte) flag for NMI debounce*/
#define VidType 0x0C2D			/*[GLOBAL VAR]	(byte) video board type ID*/
#define VidMode 0x0C2E			/*[GLOBAL VAR]	(byte) video mode (4=4bit color)*/
#define SCSIPoll 0x0C2F 		/*[GLOBAL VAR]	(byte) poll for device zero only once.*/
#define SEVarBase 0x0C30		/*[GLOBAL VAR] */
#define MMUFlags 0x0CB0 		/*[GLOBAL VAR]	(byte) cleared to zero (reserved for future use)*/
#define MMUType 0x0CB1			/*[GLOBAL VAR]	(byte) kind of MMU present*/
#define MMU32bit 0x0CB2 		/*[GLOBAL VAR]	(byte) boolean reflecting current machine MMU mode*/
#define MMUFluff 0x0CB3 		/*[GLOBAL VAR]	(byte) fluff byte forced by reducing MMUMode to MMU32bit.*/
#define MMUTbl 0x0CB4			/*[GLOBAL VAR]	(long) pointer to MMU Mapping table*/
#define MMUTblSize 0x0CB8		/*[GLOBAL VAR]	(long) size of the MMU mapping table*/
#define SInfoPtr 0x0CBC 		/*[GLOBAL VAR]	(long) pointer to Slot manager information*/
#define ASCBase 0x0CC0			/*[GLOBAL VAR]	(long) pointer to Sound Chip*/
#define SMGlobals 0x0CC4		/* (long) pointer to Sound Manager Globals*/
#define TheGDevice 0x0CC8		/*[GLOBAL VAR]	(long) the current graphics device*/
#define CQDGlobals 0x0CCC		/* (long) quickDraw global extensions*/
#define ADBBase 0x0CF8			/*[GLOBAL VAR]	(long) pointer to Front Desk Buss Variables*/
#define WarmStart 0x0CFC		/*[GLOBAL VAR]	(long) flag to indicate it is a warm start*/
#define TimeDBRA 0x0D00 		/*[GLOBAL VAR]	(word) number of iterations of DBRA per millisecond*/
#define TimeSCCDB 0x0D02		/*[GLOBAL VAR]	(word) number of iter's of SCC access & DBRA.*/
#define SlotQDT 0x0D04			/*[GLOBAL VAR]	ptr to slot queue table*/
#define SlotPrTbl 0x0D08		/*[GLOBAL VAR]	ptr to slot priority table*/
#define SlotVBLQ 0x0D0C 		/*[GLOBAL VAR]	ptr to slot VBL queue table*/
#define ScrnVBLPtr 0x0D10		/*[GLOBAL VAR]	save for ptr to main screen VBL queue*/
#define SlotTICKS 0x0D14		/*[GLOBAL VAR]	ptr to slot tickcount table*/
#define TableSeed 0x0D20		/*[GLOBAL VAR]	(long) seed value for color table ID's*/
#define SRsrcTblPtr 0x0D24		/*[GLOBAL VAR]	(long) pointer to slot resource table.*/
#define JVBLTask 0x0D28 		/*[GLOBAL VAR]	vector to slot VBL task interrupt handler*/
#define WMgrCPort 0x0D2C		/*[GLOBAL VAR]	window manager color port */
#define VertRRate 0x0D30		/*[GLOBAL VAR]	(word) Vertical refresh rate for start manager. */
#define ChunkyDepth 0x0D60		/*[GLOBAL VAR]	depth of the pixels*/
#define CrsrPtr 0x0D62			/*[GLOBAL VAR]	pointer to cursor save area*/
#define PortList 0x0D66 		/*[GLOBAL VAR]	list of grafports*/
#define MickeyBytes 0x0D6A		/*[GLOBAL VAR]	long pointer to cursor stuff*/
#define QDErrLM 0x0D6E			/*[GLOBAL VAR] QDErr has name conflict w/ type. QuickDraw error code [word]*/
#define VIA2DT 0x0D70			/*[GLOBAL VAR]	32 bytes for VIA2 dispatch table for NuMac*/
#define SInitFlags 0x0D90		/*[GLOBAL VAR]	StartInit.a flags [word]*/
#define DTQueue 0x0D92			/*[GLOBAL VAR]	(10 bytes) deferred task queue header*/
#define DTQFlags 0x0D92 		/*[GLOBAL VAR]	flag word for DTQueue*/
#define DTskQHdr 0x0D94 		/*[GLOBAL VAR]	ptr to head of queue*/
#define DTskQTail 0x0D98		/*[GLOBAL VAR]	ptr to tail of queue*/
#define JDTInstall 0x0D9C		/*[GLOBAL VAR]	(long) ptr to deferred task install routine*/
#define HiliteRGB 0x0DA0		/*[GLOBAL VAR]	6 bytes: rgb of hilite color*/
#define TimeSCSIDB 0x0DA6		/*[GLOBAL VAR]	(word) number of iter's of SCSI access & DBRA*/
#define DSCtrAdj 0x0DA8 		/*[GLOBAL VAR]	(long) Center adjust for DS rect.*/
#define IconTLAddr 0x0DAC		/*[GLOBAL VAR]	(long) pointer to where start icons are to be put.*/
#define VideoInfoOK 0x0DB0		/*[GLOBAL VAR]	(long) Signals to CritErr that the Video card is ok*/
#define EndSRTPtr 0x0DB4		/*[GLOBAL VAR]	(long) Pointer to the end of the Slot Resource Table (Not the SRT buffer).*/
#define SDMJmpTblPtr 0x0DB8 	/*[GLOBAL VAR]	(long) Pointer to the SDM jump table*/
#define JSwapMMU 0x0DBC 		/*[GLOBAL VAR]	(long) jump vector to SwapMMU routine*/
#define SdmBusErr 0x0DC0		/*[GLOBAL VAR]	(long) Pointer to the SDM busErr handler*/
#define LastTxGDevice 0x0DC4	/*[GLOBAL VAR]	(long) copy of TheGDevice set up for fast text measure*/
#define NewCrsrJTbl 0x88C		/*[GLOBAL VAR]	location of new crsr jump vectors*/
#define JAllocCrsr 0x88C		/*[GLOBAL VAR]	(long) vector to routine that allocates cursor*/
#define JSetCCrsr 0x890 		/*[GLOBAL VAR]	(long) vector to routine that sets color cursor*/
#define JOpcodeProc 0x894		/*[GLOBAL VAR]	(long) vector to process new picture opcodes*/
#define CrsrBase 0x898			/*[GLOBAL VAR]	(long) scrnBase for cursor*/
#define CrsrDevice 0x89C		/*[GLOBAL VAR]	(long) current cursor device*/
#define SrcDevice 0x8A0 		/*[GLOBAL VAR]	(LONG) Src device for Stretchbits*/
#define MainDevice 0x8A4		/*[GLOBAL VAR]	(long) the main screen device*/
#define DeviceList 0x8A8		/*[GLOBAL VAR]	(long) list of display devices*/
#define CrsrRow 0x8AC			/*[GLOBAL VAR]	(word) rowbytes for current cursor screen*/
#define QDColors 0x8B0			/*[GLOBAL VAR]	(long) handle to default colors*/
#define HiliteMode 0x938		/*[GLOBAL VAR]	used for color highlighting*/
#define BusErrVct 0x08			/*[GLOBAL VAR]	bus error vector*/
#define RestProc 0xA8C			/*[GLOBAL VAR]	Resume procedure f InitDialogs [pointer]*/
#define ROM85 0x28E 			/*[GLOBAL VAR]	(word) actually high bit - 0 for ROM vers $75 (sic) and later*/
#define ROMMapHndl 0xB06		/*[GLOBAL VAR]	(long) handle of ROM resource map*/
#define ScrVRes 0x102			/*[GLOBAL VAR] Pixels per inch vertically (word)
   screen vertical dots/inch [word]*/
#define ScrHRes 0x104			/*[GLOBAL VAR] Pixels per inch horizontally (word)
   screen horizontal dots/inch [word]*/
#define ScrnBase 0x824			/*[GLOBAL VAR] Address of main screen buffer
   Screen Base [pointer]*/
#define ScreenRow 0x106 		/*[GLOBAL VAR]	rowBytes of screen [word]*/
#define MBTicks 0x16E			/*[GLOBAL VAR]	tick count @ last mouse button [long]*/
#define JKybdTask 0x21A 		/*[GLOBAL VAR]	keyboard VBL task hook [pointer]*/
#define KeyLast 0x184			/*[GLOBAL VAR]	ASCII for last valid keycode [word]*/
#define KeyTime 0x186			/*[GLOBAL VAR]	tickcount when KEYLAST was rec'd [long]*/
#define KeyRepTime 0x18A		/*[GLOBAL VAR]	tickcount when key was last repeated [long]*/
#define SPConfig 0x1FB			/*[GLOBAL VAR] Use types for serial ports (byte)
   config bits: 4-7 A, 0-3 B (see use type below)*/
#define SPPortA 0x1FC			/*[GLOBAL VAR] Modem port configuration (word)
   SCC port A configuration [word]*/
#define SPPortB 0x1FE			/*[GLOBAL VAR] Printer port configuration (word)
   SCC port B configuration [word]*/
#define SCCRd 0x1D8 			/*[GLOBAL VAR] SCC read base address
   SCC base read address [pointer]*/
#define SCCWr 0x1DC 			/*[GLOBAL VAR] SCC write base address
   SCC base write address [pointer]*/
#define DoubleTime 0x2F0		/*[GLOBAL VAR] Double-click interval in ticks (long)
   double click ticks [long]*/
#define CaretTime 0x2F4 		/*[GLOBAL VAR] Caret-blink interval in ticks (long)
   caret blink ticks [long]*/
#define KeyThresh 0x18E 		/*[GLOBAL VAR] Auto-key threshold (word)
   threshold for key repeat [word]*/
#define KeyRepThresh 0x190		/*[GLOBAL VAR] Auto-key rate (word)
   key repeat speed [word]*/
#define SdVolume 0x260			/*[GLOBAL VAR] Current speaker volume (byte:  low-order three bits only)
   Global volume(sound) control [byte]*/
#define Ticks 0x16A 			/*[GLOBAL VAR] Current number of ticks since system startup (long)
   Tick count, time since boot [unsigned long]*/
#define TimeLM 0x20C			/*[GLOBAL VAR] Time has name conflict w/ type. Clock time (extrapolated) [long]*/
#define MonkeyLives 0x100		/*[GLOBAL VAR]	monkey lives if >= 0 [word]*/
#define SEvtEnb 0x15C			/*[GLOBAL VAR] 0 if SystemEvent should return FALSE (byte)
   enable SysEvent calls from GNE [byte]*/
#define JournalFlag 0x8DE		/*[GLOBAL VAR] Journaling mode (word)
   journaling state [word]*/
#define JournalRef 0x8E8		/*[GLOBAL VAR] Reference number of journaling device driver (word)
   Journalling driver's refnum [word]*/
#define BufPtr 0x10C			/*[GLOBAL VAR] Address of end of jump table
   top of application memory [pointer]*/
#define StkLowPt 0x110			/*[GLOBAL VAR]	Lowest stack as measured in VBL task [pointer]*/
#define TheZone 0x118			/*[GLOBAL VAR] Address of current heap zone
   current heap zone [pointer]*/
#define ApplLimit 0x130 		/*[GLOBAL VAR] Application heap limit
   application limit [pointer]*/
#define SysZone 0x2A6			/*[GLOBAL VAR] Address of system heap zone
   system heap zone [pointer]*/
#define ApplZone 0x2AA			/*[GLOBAL VAR] Address of application heap zone
   application heap zone [pointer]*/
#define HeapEnd 0x114			/*[GLOBAL VAR] Address of end of application heap zone
   end of heap [pointer]*/
#define HiHeapMark 0xBAE		/*[GLOBAL VAR]	(long) highest address used by a zone below sp<01Nov85 JTC>*/
#define MemErr 0x220			/*[GLOBAL VAR]	last memory manager error [word]*/
#define UTableBase 0x11C		/*[GLOBAL VAR] Base address of unit table
   unit I/O table [pointer]*/
#define UnitNtryCnt 0x1D2		/*[GLOBAL VAR]	count of entries in unit table [word]*/
#define JFetch 0x8F4			/*[GLOBAL VAR] Jump vector for Fetch function
   fetch a byte routine for drivers [pointer]*/
#define JStash 0x8F8			/*[GLOBAL VAR] Jump vector for Stash function
   stash a byte routine for drivers [pointer]*/
#define JIODone 0x8FC			/*[GLOBAL VAR] Jump vector for IODone function
   IODone entry location [pointer]*/
#define DrvQHdr 0x308			/*[GLOBAL VAR] Drive queue header (10 bytes)
   queue header of drives in system [10 bytes]*/
#define BootDrive 0x210 		/*[GLOBAL VAR]	drive number of boot drive [word]*/
#define EjectNotify 0x338		/*[GLOBAL VAR]	eject notify procedure [pointer]*/
#define IAZNotify 0x33C 		/*[GLOBAL VAR]	world swaps notify procedure [pointer]*/
#define SFSaveDisk 0x214		/*[GLOBAL VAR] Negative of volume reference number used by Standard File Package (word)
   last vRefNum seen by standard file [word]*/
#define CurDirStore 0x398		/*[GLOBAL VAR]	save dir across calls to Standard File [long]*/
#define OneOne 0xA02			/*[GLOBAL VAR] $00010001
   constant $00010001 [long]*/
#define MinusOne 0xA06			/*[GLOBAL VAR] $FFFFFFFF
   constant $FFFFFFFF [long]*/
#define Lo3Bytes 0x31A			/*[GLOBAL VAR] $00FFFFFF
   constant $00FFFFFF [long]*/
#define ROMBase 0x2AE			/*[GLOBAL VAR] Base address of ROM
   ROM base address [pointer]*/
#define RAMBase 0x2B2			/*[GLOBAL VAR] Trap dispatch table's base address for routines in RAM
   RAM base address [pointer]*/
#define SysVersion 0x15A		/*[GLOBAL VAR]	version # of RAM-based system [word]*/
#define RndSeed 0x156			/*[GLOBAL VAR] Random number seed (long)
   random seed/number [long]*/
#define Scratch20 0x1E4 		/*[GLOBAL VAR] 20-byte scratch area
   scratch [20 bytes]*/
#define Scratch8 0x9FA			/*[GLOBAL VAR] 8-byte scratch area
   scratch [8 bytes]*/
#define ScrapSize 0x960 		/*[GLOBAL VAR] Size in bytes of desk scrap (long)
   scrap length [long]*/
#define ScrapHandle 0x964		/*[GLOBAL VAR] Handle to desk scrap in memory
   memory scrap [handle]*/
#define ScrapCount 0x968		/*[GLOBAL VAR] Count changed by ZeroScrap (word)
   validation byte [word]*/
#define ScrapState 0x96A		/*[GLOBAL VAR] Tells where desk scrap is (word)
   scrap state [word]*/
#define ScrapName 0x96C 		/*[GLOBAL VAR] Pointer to scrap file name (preceded by length byte)
   pointer to scrap name [pointer]*/
#define IntlSpec 0xBA0			/*[GLOBAL VAR]	(long) - ptr to extra Intl data */
#define SwitcherTPtr 0x286		/*[GLOBAL VAR]	Switcher's switch table */
#define CPUFlag 0x12F			/*[GLOBAL VAR]	$00=68000, $01=68010, $02=68020 (old ROM inits to $00)*/
#define VIA 0x1D4				/*[GLOBAL VAR] VIA base address
   VIA base address [pointer]*/
#define IWM 0x1E0				/*[GLOBAL VAR]	IWM base address [pointer]*/
#define Lvl1DT 0x192			/*[GLOBAL VAR] Level-1 secondary interrupt vector table (32 bytes)
   Interrupt level 1 dispatch table [32 bytes]*/
#define Lvl2DT 0x1B2			/*[GLOBAL VAR] Level-2 secondary interrupt vector table (32 bytes)
   Interrupt level 2 dispatch table [32 bytes]*/
#define ExtStsDT 0x2BE			/*[GLOBAL VAR] External/status interrupt vector table (16 bytes)
   SCC ext/sts secondary dispatch table [16 bytes]*/
#define SPValid 0x1F8			/*[GLOBAL VAR] Validity status (byte)
   validation field ($A7) [byte]*/
#define SPATalkA 0x1F9			/*[GLOBAL VAR] AppleTalk node ID hint for modem port (byte)
   AppleTalk node number hint for port A*/
#define SPATalkB 0x1FA			/*[GLOBAL VAR] AppleTalk node ID hint for printer port (byte)
   AppleTalk node number hint for port B*/
#define SPAlarm 0x200			/*[GLOBAL VAR] Alarm setting (long)
   alarm time [long]*/
#define SPFont 0x204			/*[GLOBAL VAR] Application font number minus 1 (word)
   default application font number minus 1 [word]*/
#define SPKbd 0x206 			/*[GLOBAL VAR] Auto-key threshold and rate (byte)
   kbd repeat thresh in 4/60ths [2 4-bit]*/
#define SPPrint 0x207			/*[GLOBAL VAR] Printer connection (byte)
   print stuff [byte]*/
#define SPVolCtl 0x208			/*[GLOBAL VAR] Speaker volume setting in parameter RAM (byte)
   volume control [byte]*/
#define SPClikCaret 0x209		/*[GLOBAL VAR] Double-click and caret-blink times (byte)
   double click/caret time in 4/60ths[2 4-bit]*/
#define SPMisc1 0x20A			/*[GLOBAL VAR]	miscellaneous [1 byte]*/
#define SPMisc2 0x20B			/*[GLOBAL VAR] Mouse scaling, system startup disk, menu blink (byte)
   miscellaneous [1 byte]*/
#define GetParam 0x1E4			/*[GLOBAL VAR]	system parameter scratch [20 bytes]*/
#define SysParam 0x1F8			/*[GLOBAL VAR] Low-memory copy of parameter RAM (20 bytes)
   system parameter memory [20 bytes]*/
#define CrsrThresh 0x8EC		/*[GLOBAL VAR] Mouse-scaling threshold (word)
   delta threshold for mouse scaling [word]*/
#define JCrsrTask 0x8EE 		/*[GLOBAL VAR]	address of CrsrVBLTask [long]*/
#define MTemp 0x828 			/*[GLOBAL VAR]	Low-level interrupt mouse location [long]*/
#define RawMouse 0x82C			/*[GLOBAL VAR]	un-jerked mouse coordinates [long]*/
#define CrsrRect 0x83C			/*[GLOBAL VAR]	Cursor hit rectangle [8 bytes]*/
#define TheCrsr 0x844			/*[GLOBAL VAR]	Cursor data, mask & hotspot [68 bytes]*/
#define CrsrAddr 0x888			/*[GLOBAL VAR]	Address of data under cursor [long]*/
#define CrsrSave 0x88C			/*[GLOBAL VAR]	data under the cursor [64 bytes]*/
#define CrsrVis 0x8CC			/*[GLOBAL VAR]	Cursor visible? [byte]*/
#define CrsrBusy 0x8CD			/*[GLOBAL VAR]	Cursor locked out? [byte]*/
#define CrsrNew 0x8CE			/*[GLOBAL VAR]	Cursor changed? [byte]*/
#define CrsrState 0x8D0 		/*[GLOBAL VAR]	Cursor nesting level [word]*/
#define CrsrObscure 0x8D2		/*[GLOBAL VAR]	Cursor obscure semaphore [byte]*/
#define KbdVars 0x216			/*[GLOBAL VAR]	Keyboard manager variables [4 bytes]*/
#define KbdType 0x21E			/*[GLOBAL VAR]	keyboard model number [byte]*/
#define MBState 0x172			/*[GLOBAL VAR]	current mouse button state [byte]*/
#define KeyMapLM 0x174			/*[GLOBAL VAR] KeyMap has name conflict w/ type. Bitmap of the keyboard [4 longs]*/
#define KeypadMap 0x17C 		/*[GLOBAL VAR]	bitmap for numeric pad-18bits [long]*/
#define Key1Trans 0x29E 		/*[GLOBAL VAR]	keyboard translator procedure [pointer]*/
#define Key2Trans 0x2A2 		/*[GLOBAL VAR]	numeric keypad translator procedure [pointer]*/
#define JGNEFilter 0x29A		/*[GLOBAL VAR]	GetNextEvent filter proc [pointer]*/
#define KeyMVars 0xB04			/*[GLOBAL VAR]	(word) for ROM KEYM proc state*/
#define Mouse 0x830 			/*[GLOBAL VAR]	processed mouse coordinate [long]*/
#define CrsrPin 0x834			/*[GLOBAL VAR]	cursor pinning rectangle [8 bytes]*/
#define CrsrCouple 0x8CF		/*[GLOBAL VAR]	cursor coupled to mouse? [byte]*/
#define CrsrScale 0x8D3 		/*[GLOBAL VAR]	cursor scaled? [byte]*/
#define MouseMask 0x8D6 		/*[GLOBAL VAR]	V-H mask for ANDing with mouse [long]*/
#define MouseOffset 0x8DA		/*[GLOBAL VAR]	V-H offset for adding after ANDing [long]*/
#define AlarmState 0x21F		/*[GLOBAL VAR]	Bit7=parity, Bit6=beeped, Bit0=enable [byte]*/
#define VBLQueue 0x160			/*[GLOBAL VAR] Vertical retrace queue header (10 bytes)
   VBL queue header [10 bytes]*/
#define SysEvtMask 0x144		/*[GLOBAL VAR] System event mask (word)
   system event mask [word]*/
#define SysEvtBuf 0x146 		/*[GLOBAL VAR]	system event queue element buffer [pointer]*/
#define EventQueue 0x14A		/*[GLOBAL VAR] Event queue header (10 bytes)
   event queue header [10 bytes]*/
#define EvtBufCnt 0x154 		/*[GLOBAL VAR]	max number of events in SysEvtBuf - 1 [word]*/
#define GZRootHnd 0x328 		/*[GLOBAL VAR] Handle to relocatable block not to be moved by grow zone function
   root handle for GrowZone [handle]*/
#define GZRootPtr 0x32C 		/*[GLOBAL VAR]	root pointer for GrowZone [pointer]*/
#define GZMoveHnd 0x330 		/*[GLOBAL VAR]	moving handle for GrowZone [handle]*/
#define MemTop 0x108			/*[GLOBAL VAR] Address of end of RAM (on Macintosh XL, end of RAM available to applications)
   top of memory [pointer]*/
#define MmInOK 0x12E			/*[GLOBAL VAR]	initial memory mgr checks ok? [byte]*/
#define HpChk 0x316 			/*[GLOBAL VAR]	heap check RAM code [pointer]*/
#define MaskBC 0x31A			/*[GLOBAL VAR]	Memory Manager Byte Count Mask [long]*/
#define MaskHandle 0x31A		/*[GLOBAL VAR]	Memory Manager Handle Mask [long]*/
#define MaskPtr 0x31A			/*[GLOBAL VAR]	Memory Manager Pointer Mask [long]*/
#define MinStack 0x31E			/*[GLOBAL VAR] Minimum space allotment for stack (long)
   min stack size used in InitApplZone [long]*/
#define DefltStack 0x322		/*[GLOBAL VAR] Default space allotment for stack (long) 
   default size of stack [long]*/
#define MMDefFlags 0x326		/*[GLOBAL VAR]	default zone flags [word]*/
#define DSAlertTab 0x2BA		/*[GLOBAL VAR] Pointer to system error alert table in use
   system error alerts [pointer]*/
#define DSAlertRect 0x3F8		/*[GLOBAL VAR] Rectangle enclosing system error alert (8 bytes)
   rectangle for disk-switch alert [8 bytes]*/
#define DSDrawProc 0x334		/*[GLOBAL VAR]	alternate syserror draw procedure [pointer]*/
#define DSWndUpdate 0x15D		/*[GLOBAL VAR]	GNE not to paintBehind DS AlertRect? [byte]*/
#define WWExist 0x8F2			/*[GLOBAL VAR]	window manager initialized? [byte]*/
#define QDExist 0x8F3			/*[GLOBAL VAR]	quickdraw is initialized [byte]*/
#define ResumeProc 0xA8C		/*[GLOBAL VAR] Address of resume procedure
   Resume procedure from InitDialogs [pointer]*/
#define DSErrCode 0xAF0 		/*[GLOBAL VAR] Current system error ID (word)
   last system error alert ID*/
#define IntFlag 0x15F			/*[GLOBAL VAR]	reduce interrupt disable time when bit 7 = 0*/
#define SerialVars 0x2D0		/*[GLOBAL VAR]	async driver variables [16 bytes]*/
#define ABusVars 0x2D8			/*[GLOBAL VAR] Pointer to AppleTalk variables
  ;Pointer to AppleTalk local variables*/
#define ABusDCE 0x2DC			/*[GLOBAL VAR] ;Pointer to AppleTalk DCE*/
#define PortAUse 0x290			/*[GLOBAL VAR]	bit 7: 1 = not in use, 0 = in use*/
#define PortBUse 0x291			/*[GLOBAL VAR] Current availability of serial port B (byte)
   port B use, same format as PortAUse*/
#define SCCASts 0x2CE			/*[GLOBAL VAR]	SCC read reg 0 last ext/sts rupt - A [byte]*/
#define SCCBSts 0x2CF			/*[GLOBAL VAR]	SCC read reg 0 last ext/sts rupt - B [byte]*/
#define DskErr 0x142			/*[GLOBAL VAR]	disk routine result code [word]*/
#define PWMBuf2 0x312			/*[GLOBAL VAR]	PWM buffer 1 (or 2 if sound) [pointer]*/
#define SoundPtr 0x262			/*[GLOBAL VAR] Pointer to four-tone record
   4VE sound definition table [pointer]*/
#define SoundBase 0x266 		/*[GLOBAL VAR] Pointer to free-form synthesizer buffer
   sound bitMap [pointer]*/
#define SoundVBL 0x26A			/*[GLOBAL VAR]	vertical retrace control element [16 bytes]*/
#define SoundDCE 0x27A			/*[GLOBAL VAR]	sound driver DCE [pointer]*/
#define SoundActive 0x27E		/*[GLOBAL VAR]	sound is active? [byte]*/
#define SoundLevel 0x27F		/*[GLOBAL VAR] Amplitude in 740-byte buffer (byte)
   current level in buffer [byte]*/
#define CurPitch 0x280			/*[GLOBAL VAR] Value of count in square-wave synthesizer buffer (word)
   current pitch value [word]*/
#define DskVerify 0x12C 		/*[GLOBAL VAR]	used by 3.5 disk driver for read/verify [byte]*/
#define TagData 0x2FA			/*[GLOBAL VAR]	sector tag info for disk drivers [14 bytes]*/
#define BufTgFNum 0x2FC 		/*[GLOBAL VAR] File tags buffer:  file number (long)
   file number [long]*/
#define BufTgFFlg 0x300 		/*[GLOBAL VAR] File tags buffer:  flags (word:	bit 1=1 if resource fork)
   flags [word]*/
#define BufTgFBkNum 0x302		/*[GLOBAL VAR] File tags buffer:  logical block number (word)
   logical block number [word]*/
#define BufTgDate 0x304 		/*[GLOBAL VAR] File tags buffer:  date and time of last modification (long)
   time stamp [word]*/
#define ScrDmpEnb 0x2F8 		/*[GLOBAL VAR] 0 if GetNextEvent shouldn't process Command-Shift-number combinations (byte)
   screen dump enabled? [byte]*/
#define ScrDmpType 0x2F9		/*[GLOBAL VAR]	FF dumps screen, FE dumps front window [byte]*/
#define ScrapVars 0x960 		/*[GLOBAL VAR]	scrap manager variables [32 bytes]*/
#define ScrapInfo 0x960 		/*[GLOBAL VAR]	scrap length [long]*/
#define ScrapEnd 0x980			/*[GLOBAL VAR]	end of scrap vars*/
#define ScrapTag 0x970			/*[GLOBAL VAR]	scrap file name [STRING[15]]*/
#define LaunchFlag 0x902		/*[GLOBAL VAR]	from launch or chain [byte]*/
#define SaveSegHandle 0x930 	/*[GLOBAL VAR]	seg 0 handle [handle]*/
#define CurJTOffset 0x934		/*[GLOBAL VAR] Offset to jump table from location pointed to by A5 (word)
   current jump table offset [word]*/
#define CurPageOption 0x936 	/*[GLOBAL VAR] Sound/screen buffer configuration passed to Chain or Launch (word)
   current page 2 configuration [word]*/
#define LoaderPBlock 0x93A		/*[GLOBAL VAR]	param block for ExitToShell [10 bytes]*/
#define CurApRefNum 0x900		/*[GLOBAL VAR] Reference number of current application's resource file (word)
   refNum of application's resFile [word]*/
#define CurrentA5 0x904 		/*[GLOBAL VAR] Address of boundary between application globals and application parameters
   current value of A5 [pointer]*/
#define CurStackBase 0x908		/*[GLOBAL VAR] Address of base of stack; start of application globals
   current stack base [pointer]*/
#define CurApName 0x910 		/*[GLOBAL VAR] Name of current application (length byte followed by up to 31 characters)
   name of application [STRING[31]]*/
#define LoadTrap 0x12D			/*[GLOBAL VAR]	trap before launch? [byte]*/
#define SegHiEnable 0xBB2		/*[GLOBAL VAR]	(byte) 0 to disable MoveHHi in LoadSeg*/

/* Window Manager Globals */

#define WindowList 0x9D6		/*[GLOBAL VAR] Pointer to first window in window list; 0 if using events but not windows
  Z-ordered linked list of windows [pointer]*/
#define PaintWhite 0x9DC		/*[GLOBAL VAR] Flag for whether to paint window white before update event (word)
  erase newly drawn windows? [word]*/
#define WMgrPort 0x9DE			/*[GLOBAL VAR] Pointer to Window Manager port
  window manager's grafport [pointer]*/
#define GrayRgn 0x9EE			/*[GLOBAL VAR] Handle to region drawn as desktop
  rounded gray desk region [handle]*/
#define CurActivate 0xA64		/*[GLOBAL VAR] Pointer to window to receive activate event
  window slated for activate event [pointer]*/
#define CurDeactive 0xA68		/*[GLOBAL VAR] Pointer to window to receive deactivate event
  window slated for deactivate event [pointer]*/
#define DragHook 0x9F6			/*[GLOBAL VAR] Address of procedure to execute during TrackGoAway, DragWindow, GrowWindow, DragGrayRgn, TrackControl, and DragControl
  user hook during dragging [pointer]*/
#define DeskPattern 0xA3C		/*[GLOBAL VAR] Pattern with which desktop is painted (8 bytes)
  desk pattern [8 bytes]*/
#define DeskHook 0xA6C			/*[GLOBAL VAR] Address of procedure for painting desktop or responding to clicks on desktop
  hook for painting the desk [pointer]*/
#define GhostWindow 0xA84		/*[GLOBAL VAR] Pointer to window never to be considered frontmost
  window hidden from FrontWindow [pointer]*/

/* Text Edit Globals */

#define TEDoText 0xA70			/*[GLOBAL VAR] Address of TextEdit multi-purpose routine
  textEdit doText proc hook [pointer]*/
#define TERecal 0xA74			/*[GLOBAL VAR] Address of routine to recalculate line starts for TextEdit
  textEdit recalText proc hook [pointer]*/
#define TEScrpLength 0xAB0		/*[GLOBAL VAR] Size in bytes of TextEdit scrap (long)
  textEdit Scrap Length [word]*/
#define TEScrpHandle 0xAB4		/*[GLOBAL VAR] Handle to TextEdit scrap
  textEdit Scrap [handle]*/
#define TEWdBreak 0xAF6 		/*[GLOBAL VAR] default word break routine [pointer]*/
#define WordRedraw 0xBA5		/*[GLOBAL VAR] (byte) - used by TextEdit RecalDraw*/
#define TESysJust 0xBAC 		/*[GLOBAL VAR] (word) system justification (intl. textEdit)*/

/* Resource Manager Globals */

#define TopMapHndl 0xA50		/*[GLOBAL VAR] Handle to resource map of most recently opened resource file
  topmost map in list [handle]*/
#define SysMapHndl 0xA54		/*[GLOBAL VAR] Handle to map of system resource file
  system map [handle]*/
#define SysMap 0xA58			/*[GLOBAL VAR] Reference number of system resource file (word)
  reference number of system map [word]*/
#define CurMap 0xA5A			/*[GLOBAL VAR] Reference number of current resource file (word) 
  reference number of current map [word]*/
#define ResReadOnly 0xA5C		/*[GLOBAL VAR] Read only flag [word]*/
#define ResLoad 0xA5E			/*[GLOBAL VAR] Current SetResLoad state (word)
  Auto-load feature [word]*/
#define ResErr 0xA60			/*[GLOBAL VAR] Current value of ResError (word)
  Resource error code [word]*/
#define ResErrProc 0xAF2		/*[GLOBAL VAR] Address of resource error procedure
  Resource error procedure [pointer]*/
#define SysResName 0xAD8		/*[GLOBAL VAR] Name of system resource file (length byte followed by up to 19 characters)
  Name of system resource file [STRING[19]]*/
#define RomMapInsert 0xB9E		/*[GLOBAL VAR] (byte) determines if we should link in map*/
#define TmpResLoad 0xB9F		/*[GLOBAL VAR] second byte is temporary ResLoad value.*/

/* Menu Mgr globals */

#define MBarHeight 0xBAA		/*[GLOBAL VAR] height of the menu bar*/


#endif
