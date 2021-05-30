{
 	File:		Memory.p
 
 	Contains:	Memory Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Memory;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MEMORY__}
{$SETC __MEMORY__ := 1}

{$I+}
{$SETC MemoryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	maxSize						= $800000;						{Max data block size is 8 megabytes}
	defaultPhysicalEntryCount	= 8;
{ values returned from the GetPageState function }
	kPageInMemory				= 0;
	kPageOnDisk					= 1;
	kNotPaged					= 2;

{ masks for Zone->heapType field }
	k32BitHeap					= 1;							{ valid in all Memory Managers }
	kNewStyleHeap				= 2;							{ true if new Heap Manager is present }
	kNewDebugHeap				= 4;							{ true if new Heap Manager is running in debug mode on this heap }

{ size of a block in bytes }
	
TYPE
	Size = LONGINT;

	GrowZoneProcPtr = ProcPtr;  { FUNCTION GrowZone(cbNeeded: Size): LONGINT; }
	PurgeProcPtr = ProcPtr;  { PROCEDURE Purge(blockToPurge: Handle); }
	{
		UserFnProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => *parameter  	A0.L
	}
	UserFnProcPtr = Register68kProcPtr;  { register PROCEDURE UserFn(parameter: UNIV Ptr); }
	GrowZoneUPP = UniversalProcPtr;
	PurgeUPP = UniversalProcPtr;
	UserFnUPP = UniversalProcPtr;

	THz = ^Zone;

	Zone = RECORD
		bkLim:					Ptr;
		purgePtr:				Ptr;
		hFstFree:				Ptr;
		zcbFree:				LONGINT;
		gzProc:					GrowZoneUPP;
		moreMast:				INTEGER;
		flags:					INTEGER;
		cntRel:					INTEGER;
		maxRel:					INTEGER;
		cntNRel:				INTEGER;
		heapType:				SInt8; (* Byte *)
		unused:					SInt8; (* Byte *)
		cntEmpty:				INTEGER;
		cntHandles:				INTEGER;
		minCBFree:				LONGINT;
		purgeProc:				PurgeUPP;
		sparePtr:				Ptr;
		allocPtr:				Ptr;
		heapData:				INTEGER;
	END;

	MemoryBlock = RECORD
		address:				Ptr;
		count:					LONGINT;
	END;

	LogicalToPhysicalTable = RECORD
		logical:				MemoryBlock;
		physical:				ARRAY [0..defaultPhysicalEntryCount-1] OF MemoryBlock;
	END;

	PageState = INTEGER;

	StatusRegisterContents = INTEGER;

CONST
	uppGrowZoneProcInfo = $000000F0; { FUNCTION (4 byte param): 4 byte result; }
	uppPurgeProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppUserFnProcInfo = $00009802; { Register PROCEDURE (4 bytes in A0); }

FUNCTION NewGrowZoneProc(userRoutine: GrowZoneProcPtr): GrowZoneUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPurgeProc(userRoutine: PurgeProcPtr): PurgeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUserFnProc(userRoutine: UserFnProcPtr): UserFnUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGrowZoneProc(cbNeeded: Size; userRoutine: GrowZoneUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallPurgeProc(blockToPurge: Handle; userRoutine: PurgeUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallUserFnProc(parameter: UNIV Ptr; userRoutine: UserFnUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}
FUNCTION GetApplLimit : Ptr;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $0130;			{ MOVE.l $0130,(SP) }
	{$ENDC}

FUNCTION SystemZone : THz;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $02A6;			{ MOVE.l $02A6,(SP) }
	{$ENDC}

FUNCTION ApplicationZone : THz;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $02AA;			{ MOVE.l $02AA,(SP) }
	{$ENDC}

FUNCTION GZSaveHnd : Handle;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $0328;			{ MOVE.l $0328,(SP) }
	{$ENDC}

FUNCTION TopMem : Ptr;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $0108;			{ MOVE.l $0108,(SP) }
	{$ENDC}

FUNCTION MemError : OSErr;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $3EB8, $0220;			{ MOVE.w $0220,(SP) }
	{$ENDC}

FUNCTION GetZone: THz;
	{$IFC NOT GENERATINGCFM}
	INLINE $A11A, $2E88;
	{$ENDC}
FUNCTION NewHandle(byteCount: Size): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A122, $2E88;
	{$ENDC}
FUNCTION NewHandleSys(byteCount: Size): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A522, $2E88;
	{$ENDC}
FUNCTION NewHandleClear(byteCount: Size): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A322, $2E88;
	{$ENDC}
FUNCTION NewHandleSysClear(byteCount: Size): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A722, $2E88;
	{$ENDC}
FUNCTION HandleZone(h: Handle): THz;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A126, $2E88;
	{$ENDC}
FUNCTION RecoverHandle(p: Ptr): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A128, $2E88;
	{$ENDC}
FUNCTION RecoverHandleSys(p: Ptr): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A528, $2E88;
	{$ENDC}
FUNCTION NewPtr(byteCount: Size): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A11E, $2E88;
	{$ENDC}
FUNCTION NewPtrSys(byteCount: Size): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A51E, $2E88;
	{$ENDC}
FUNCTION NewPtrClear(byteCount: Size): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A31E, $2E88;
	{$ENDC}
FUNCTION NewPtrSysClear(byteCount: Size): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A71E, $2E88;
	{$ENDC}
FUNCTION PtrZone(p: Ptr): THz;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A148, $2E88;
	{$ENDC}
FUNCTION MaxBlock: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A061, $2E80;
	{$ENDC}
FUNCTION MaxBlockSys: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A461, $2E80;
	{$ENDC}
FUNCTION StackSpace: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A065, $2E80;
	{$ENDC}
FUNCTION NewEmptyHandle: Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A166, $2E88;
	{$ENDC}
FUNCTION NewEmptyHandleSys: Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A566, $2E88;
	{$ENDC}
PROCEDURE HLock(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A029;
	{$ENDC}
PROCEDURE HUnlock(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A02A;
	{$ENDC}
PROCEDURE HPurge(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A049;
	{$ENDC}
PROCEDURE HNoPurge(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A04A;
	{$ENDC}
PROCEDURE HLockHi(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A064, $A029;
	{$ENDC}
FUNCTION TempNewHandle(logicalSize: Size; VAR resultCode: OSErr): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001D, $A88F;
	{$ENDC}
FUNCTION TempMaxMem(VAR grow: Size): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0015, $A88F;
	{$ENDC}
FUNCTION TempFreeMem: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0018, $A88F;
	{$ENDC}
{  Temporary Memory routines renamed, but obsolete, in System 7.0 and later.  }
PROCEDURE TempHLock(h: Handle; VAR resultCode: OSErr);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001E, $A88F;
	{$ENDC}
PROCEDURE TempHUnlock(h: Handle; VAR resultCode: OSErr);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001F, $A88F;
	{$ENDC}
PROCEDURE TempDisposeHandle(h: Handle; VAR resultCode: OSErr);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0020, $A88F;
	{$ENDC}
FUNCTION TempTopMem: Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0016, $A88F;
	{$ENDC}
PROCEDURE InitApplZone;
	{$IFC NOT GENERATINGCFM}
	INLINE $A02C;
	{$ENDC}
PROCEDURE InitZone(pgrowZone: GrowZoneUPP; cmoreMasters: INTEGER; limitPtr: UNIV Ptr; startPtr: UNIV Ptr);
PROCEDURE SetZone(hz: THz);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A01B;
	{$ENDC}
FUNCTION CompactMem(cbNeeded: Size): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A04C, $2E80;
	{$ENDC}
FUNCTION CompactMemSys(cbNeeded: Size): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A44C, $2E80;
	{$ENDC}
PROCEDURE PurgeMem(cbNeeded: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A04D;
	{$ENDC}
PROCEDURE PurgeMemSys(cbNeeded: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A44D;
	{$ENDC}
FUNCTION FreeMem: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A01C, $2E80;
	{$ENDC}
FUNCTION FreeMemSys: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A41C, $2E80;
	{$ENDC}
PROCEDURE ReserveMem(cbNeeded: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A040;
	{$ENDC}
PROCEDURE ReserveMemSys(cbNeeded: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A440;
	{$ENDC}
FUNCTION MaxMem(VAR grow: Size): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $A11D, $2288, $2E80;
	{$ENDC}
FUNCTION MaxMemSys(VAR grow: Size): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $A51D, $2288, $2E80;
	{$ENDC}
PROCEDURE SetGrowZone(growZone: GrowZoneUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A04B;
	{$ENDC}
PROCEDURE SetApplLimit(zoneLimit: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A02D;
	{$ENDC}
PROCEDURE MoveHHi(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A064;
	{$ENDC}
PROCEDURE DisposePtr(p: Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A01F;
	{$ENDC}
FUNCTION GetPtrSize(p: Ptr): Size;
PROCEDURE SetPtrSize(p: Ptr; newSize: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $205F, $A020;
	{$ENDC}
PROCEDURE DisposeHandle(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A023;
	{$ENDC}
PROCEDURE SetHandleSize(h: Handle; newSize: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $205F, $A024;
	{$ENDC}
FUNCTION GetHandleSize(h: Handle): Size;
FUNCTION InlineGetHandleSize(h: Handle): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A025, $2E80;
	{$ENDC}
PROCEDURE ReallocateHandle(h: Handle; byteCount: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $205F, $A027;
	{$ENDC}
PROCEDURE EmptyHandle(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A02B;
	{$ENDC}
PROCEDURE HSetRBit(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A067;
	{$ENDC}
PROCEDURE HClrRBit(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A068;
	{$ENDC}
PROCEDURE MoreMasters;
	{$IFC NOT GENERATINGCFM}
	INLINE $A036;
	{$ENDC}
PROCEDURE BlockMove(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $225F, $205F, $A02E;
	{$ENDC}
PROCEDURE BlockMoveData(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $225F, $205F, $A22E;
	{$ENDC}
{
	These four routines are intended to be used by developers writing drivers.
	They do not exist in “InterfaceLib.” You must link with “DriverServicesLib” to access them.
	
		BlockMoveUncached
		BlockMoveDataUncached
		BlockZero
		BlockZeroUncached
	
	Note: BlockMove and BlockMoveData exist in both in “InterfaceLib” and “DriverServicesLib.” 
	You cannot link with both libraries.
	
}
PROCEDURE BlockMoveUncached(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size); C;
PROCEDURE BlockMoveDataUncached(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size); C;
PROCEDURE BlockZero(destPtr: UNIV Ptr; byteCount: Size); C;
PROCEDURE BlockZeroUncached(destPtr: UNIV Ptr; byteCount: Size); C;

PROCEDURE PurgeSpace(VAR total: LONGINT; VAR contig: LONGINT);
FUNCTION HGetState(h: Handle): SInt8;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A069, $1E80;
	{$ENDC}
PROCEDURE HSetState(h: Handle; flags: ByteParameter);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $205F, $A06A;
	{$ENDC}
PROCEDURE SetApplBase(startPtr: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A057;
	{$ENDC}
PROCEDURE MaxApplZone;
	{$IFC NOT GENERATINGCFM}
	INLINE $A063;
	{$ENDC}
FUNCTION HoldMemory(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7000, $A05C, $3E80;
	{$ENDC}
FUNCTION UnholdMemory(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7001, $A05C, $3E80;
	{$ENDC}
FUNCTION LockMemory(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7002, $A05C, $3E80;
	{$ENDC}
FUNCTION LockMemoryForOutput(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $700A, $A05C, $3E80;
	{$ENDC}
FUNCTION LockMemoryContiguous(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7004, $A05C, $3E80;
	{$ENDC}
FUNCTION UnlockMemory(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7003, $A05C, $3E80;
	{$ENDC}
FUNCTION GetPhysical(VAR addresses: LogicalToPhysicalTable; VAR physicalEntryCount: LONGINT): OSErr;
FUNCTION DeferUserFn(userFunction: UserFnUPP; argument: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $205F, $A08F, $3E80;
	{$ENDC}
FUNCTION DebuggerGetMax: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $A08D, $2E80;
	{$ENDC}
PROCEDURE DebuggerEnter;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $A08D;
	{$ENDC}
PROCEDURE DebuggerExit;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $A08D;
	{$ENDC}
PROCEDURE DebuggerPoll;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $A08D;
	{$ENDC}
FUNCTION GetPageState(address: UNIV Ptr): PageState;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7004, $A08D, $3E80;
	{$ENDC}
FUNCTION PageFaultFatal: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $A08D, $1E80;
	{$ENDC}
FUNCTION DebuggerLockMemory(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7006, $A08D, $3E80;
	{$ENDC}
FUNCTION DebuggerUnlockMemory(address: UNIV Ptr; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7007, $A08D, $3E80;
	{$ENDC}
FUNCTION EnterSupervisorMode: StatusRegisterContents;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $A08D, $3E80;
	{$ENDC}
{ StripAddress and Translate24To32 macro to nothing on PowerPC
   StripAddress is implemented as a trap in System 6 or later }
{$IFC SystemSixOrLater }
FUNCTION StripAddress(theAddress: UNIV Ptr): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A055, $2E80;
	{$ENDC}
{$ELSEC}
FUNCTION StripAddress(theAddress: UNIV Ptr): Ptr;
{$ENDC}
FUNCTION Translate24To32(addr24: UNIV Ptr): Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A091, $2E80;
	{$ENDC}
FUNCTION HandToHand(VAR theHndl: Handle): OSErr;
FUNCTION PtrToXHand(srcPtr: UNIV Ptr; dstHndl: Handle; size: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $225F, $205F, $A9E2, $3E80;
	{$ENDC}
FUNCTION PtrToHand(srcPtr: UNIV Ptr; VAR dstHndl: Handle; size: LONGINT): OSErr;
FUNCTION HandAndHand(hand1: Handle; hand2: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $A9E4, $3E80;
	{$ENDC}
FUNCTION PtrAndHand(ptr1: UNIV Ptr; hand2: Handle; size: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $225F, $205F, $A9EF, $3E80;
	{$ENDC}
{$IFC OLDROUTINENAMES }
FUNCTION ApplicZone: THz;
	{$IFC NOT GENERATINGCFM}
	INLINE $2EB8, $02AA;
	{$ENDC}
FUNCTION MFTempNewHandle(logicalSize: Size; VAR resultCode: OSErr): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001D, $A88F;
	{$ENDC}
FUNCTION MFMaxMem(VAR grow: Size): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0015, $A88F;
	{$ENDC}
FUNCTION MFFreeMem: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0018, $A88F;
	{$ENDC}
PROCEDURE MFTempHLock(h: Handle; VAR resultCode: OSErr);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001E, $A88F;
	{$ENDC}
PROCEDURE MFTempHUnlock(h: Handle; VAR resultCode: OSErr);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001F, $A88F;
	{$ENDC}
PROCEDURE MFTempDisposHandle(h: Handle; VAR resultCode: OSErr);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0020, $A88F;
	{$ENDC}
FUNCTION MFTopMem: Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0016, $A88F;
	{$ENDC}
PROCEDURE ResrvMem(cbNeeded: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A040;
	{$ENDC}
PROCEDURE DisposPtr(p: Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A01F;
	{$ENDC}
PROCEDURE DisposHandle(h: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A023;
	{$ENDC}
PROCEDURE ReallocHandle(h: Handle; byteCount: Size);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $205F, $A027;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MemoryIncludes}

{$ENDC} {__MEMORY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
