{
Created: Wednesday, October 19, 1988 at 7:52 PM
    Memory.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Memory;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingMemory}
{$SETC UsingMemory := 1}

{$I+}
{$SETC MemoryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := MemoryIncludes}

CONST
maxSize = $800000;  {Max data block size is 8 megabytes}


TYPE


THz = ^Zone;
Zone = RECORD
    bkLim: Ptr;
    purgePtr: Ptr;
    hFstFree: Ptr;
    zcbFree: LONGINT;
    gzProc: ProcPtr;
    moreMast: INTEGER;
    flags: INTEGER;
    cntRel: INTEGER;
    maxRel: INTEGER;
    cntNRel: INTEGER;
    maxNRel: INTEGER;
    cntEmpty: INTEGER;
    cntHandles: INTEGER;
    minCBFree: LONGINT;
    purgeProc: ProcPtr;
    sparePtr: Ptr;
    allocPtr: Ptr;
    heapData: INTEGER;
    END;

Size = LONGINT;     { size of a block in bytes }



FUNCTION GetApplLimit: Ptr;
    INLINE $2EB8,$0130;
FUNCTION GetZone: THz;
FUNCTION SystemZone: THz;
    INLINE $2EB8,$02A6;
FUNCTION ApplicZone: THz;
    INLINE $2EB8,$02AA;
FUNCTION NewHandle(byteCount: Size): Handle;
FUNCTION NewHandleSys(byteCount: Size): Handle;
FUNCTION NewHandleClear(byteCount: Size): Handle;
FUNCTION NewHandleSysClear(byteCount: Size): Handle;
FUNCTION HandleZone(h: Handle): THz;
FUNCTION RecoverHandle(p: Ptr): Handle;
FUNCTION NewPtr(byteCount: Size): Ptr;
FUNCTION NewPtrSys(byteCount: Size): Ptr;
FUNCTION NewPtrClear(byteCount: Size): Ptr;
FUNCTION NewPtrSysClear(byteCount: Size): Ptr;
FUNCTION PtrZone(p: Ptr): THz;
FUNCTION GZSaveHnd: Handle;
    INLINE $2EB8,$0328;
FUNCTION TopMem: Ptr;
    INLINE $2EB8,$0108;
FUNCTION MaxBlock: LONGINT;
FUNCTION StackSpace: LONGINT;
FUNCTION NewEmptyHandle: Handle;
PROCEDURE HLock(h: Handle);
PROCEDURE HUnlock(h: Handle);
PROCEDURE HPurge(h: Handle);
PROCEDURE HNoPurge(h: Handle);
FUNCTION StripAddress(theAddress: Ptr): Ptr;
FUNCTION MFMaxMem(VAR grow: Size): Size;
    INLINE $3F3C,$0015,$A88F;
FUNCTION MFFreeMem: LONGINT;
    INLINE $3F3C,$0018,$A88F;
FUNCTION MFTempNewHandle(logicalSize: Size;VAR resultCode: OSErr): Handle;
    INLINE $3F3C,$001D,$A88F;
PROCEDURE MFTempHLock(h: Handle;VAR resultCode: OSErr);
    INLINE $3F3C,$001E,$A88F;
PROCEDURE MFTempHUnlock(h: Handle;VAR resultCode: OSErr);
    INLINE $3F3C,$001F,$A88F;
PROCEDURE MFTempDisposHandle(h: Handle;VAR resultCode: OSErr);
    INLINE $3F3C,$0020,$A88F;
FUNCTION MFTopMem: Ptr;
    INLINE $3F3C,$0016,$A88F;
PROCEDURE InitApplZone;
PROCEDURE InitZone(pgrowZone: ProcPtr;cmoreMasters: INTEGER;limitPtr: Ptr;
    startPtr: Ptr);
PROCEDURE SetZone(hz: THz);
FUNCTION CompactMem(cbNeeded: Size): Size;
PROCEDURE PurgeMem(cbNeeded: Size);
FUNCTION FreeMem: LONGINT;
PROCEDURE ResrvMem(cbNeeded: Size);
FUNCTION MaxMem(VAR grow: Size): Size;
PROCEDURE SetGrowZone(growZone: ProcPtr);
PROCEDURE SetApplLimit(zoneLimit: Ptr);
PROCEDURE MoveHHi(h: Handle);
PROCEDURE DisposPtr(p: Ptr);
FUNCTION GetPtrSize(p: Ptr): Size;
PROCEDURE SetPtrSize(p: Ptr;newSize: Size);
PROCEDURE DisposHandle(h: Handle);
FUNCTION GetHandleSize(h: Handle): Size;
PROCEDURE SetHandleSize(h: Handle;newSize: Size);
PROCEDURE EmptyHandle(h: Handle);
PROCEDURE ReallocHandle(h: Handle;byteCount: Size);
PROCEDURE HSetRBit(h: Handle);
PROCEDURE HClrRBit(h: Handle);
PROCEDURE MoreMasters;
PROCEDURE BlockMove(srcPtr: Ptr;destPtr: Ptr;byteCount: Size);
FUNCTION MemError: OSErr;
    INLINE $3EB8,$0220;
PROCEDURE PurgeSpace(VAR total: LONGINT;VAR contig: LONGINT);
FUNCTION HGetState(h: Handle): SignedByte;
PROCEDURE HSetState(h: Handle;flags: SignedByte);
PROCEDURE SetApplBase(startPtr: Ptr);
PROCEDURE MaxApplZone;

{$ENDC}    { UsingMemory }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}

