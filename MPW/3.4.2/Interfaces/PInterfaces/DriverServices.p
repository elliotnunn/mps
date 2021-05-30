{
 	File:		DriverServices.p
 
 	Contains:	Driver Services Interfaces.
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
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
 UNIT DriverServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERSERVICES__}
{$SETC __DRIVERSERVICES__ := 1}

{$I+}
{$SETC DriverServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __KERNEL__}
{$I Kernel.p}
{$ENDC}
{$IFC UNDEFINED __DEVICES__}
{$I Devices.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	DeviceLogicalAddressPtr				= ^LogicalAddress;

CONST
	durationMicrosecond			= -1;							{  Microseconds are negative }
	durationMillisecond			= 1;							{  Milliseconds are positive }
	durationSecond				= 1000;							{  1000 * durationMillisecond }
	durationMinute				= 60000;						{  60 * durationSecond, }
	durationHour				= 3600000;						{  60 * durationMinute, }
	durationDay					= 86400000;						{  24 * durationHour, }
	durationNoWait				= 0;							{  don't block }
	durationForever				= $7FFFFFFF;					{  no time limit }

	k8BitAccess					= 0;							{  access as 8 bit }
	k16BitAccess				= 1;							{  access as 16 bit }
	k32BitAccess				= 2;							{  access as 32 bit }


TYPE
	Nanoseconds							= UnsignedWide;
	NanosecondsPtr 						= ^Nanoseconds;
	
FUNCTION IOCommandIsComplete(ID: IOCommandID; result: OSErr): OSErr; C;
FUNCTION GetIOCommandInfo(ID: IOCommandID; VAR contents: IOCommandContents; VAR command: IOCommandCode; VAR kind: IOCommandKind): OSErr; C;
PROCEDURE BlockCopy(srcPtr: UNIV Ptr; destPtr: UNIV Ptr; byteCount: Size); C;
FUNCTION PoolAllocateResident(byteSize: ByteCount; clear: BOOLEAN): LogicalAddress; C;
FUNCTION PoolDeallocate(address: LogicalAddress): OSStatus; C;
FUNCTION GetLogicalPageSize: ByteCount; C;
FUNCTION GetDataCacheLineSize: ByteCount; C;
FUNCTION FlushProcessorCache(spaceID: AddressSpaceID; base: LogicalAddress; length: ByteCount): OSStatus; C;
PROCEDURE SynchronizeIO; C;
FUNCTION MemAllocatePhysicallyContiguous(byteSize: ByteCount; clear: BOOLEAN): LogicalAddress; C;
FUNCTION MemDeallocatePhysicallyContiguous(address: LogicalAddress): OSStatus; C;
FUNCTION UpTime: AbsoluteTime; C;
PROCEDURE GetTimeBaseInfo(VAR minAbsoluteTimeDelta: UInt32; VAR theAbsoluteTimeToNanosecondNumerator: UInt32; VAR theAbsoluteTimeToNanosecondDenominator: UInt32; VAR theProcessorToAbsoluteTimeNumerator: UInt32; VAR theProcessorToAbsoluteTimeDenominator: UInt32); C;
FUNCTION AbsoluteToNanoseconds(absoluteTime: AbsoluteTime): Nanoseconds; C;
FUNCTION AbsoluteToDuration(absoluteTime: AbsoluteTime): Duration; C;
FUNCTION NanosecondsToAbsolute(nanoseconds: Nanoseconds): AbsoluteTime; C;
FUNCTION DurationToAbsolute(duration: Duration): AbsoluteTime; C;
FUNCTION AddAbsoluteToAbsolute(absoluteTime1: AbsoluteTime; absoluteTime2: AbsoluteTime): AbsoluteTime; C;
FUNCTION SubAbsoluteFromAbsolute(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION AddNanosecondsToAbsolute(nanoseconds: Nanoseconds; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION AddDurationToAbsolute(duration: Duration; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION SubNanosecondsFromAbsolute(nanoseconds: Nanoseconds; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION SubDurationFromAbsolute(duration: Duration; absoluteTime: AbsoluteTime): AbsoluteTime; C;
FUNCTION AbsoluteDeltaToNanoseconds(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): Nanoseconds; C;
FUNCTION AbsoluteDeltaToDuration(leftAbsoluteTime: AbsoluteTime; rightAbsoluteTime: AbsoluteTime): Duration; C;
FUNCTION DurationToNanoseconds(theDuration: Duration): Nanoseconds; C;
FUNCTION NanosecondsToDuration(theNanoseconds: Nanoseconds): Duration; C;
FUNCTION CompareAndSwap(oldVvalue: UInt32; newValue: UInt32; VAR OldValueAdr: UInt32): BOOLEAN; C;
FUNCTION TestAndSet(bit: UInt32; VAR startAddress: UInt8): BOOLEAN; C;
FUNCTION TestAndClear(bit: UInt32; VAR startAddress: UInt8): BOOLEAN; C;
FUNCTION IncrementAtomic(VAR value: SInt32): SInt32; C;
FUNCTION DecrementAtomic(VAR value: SInt32): SInt32; C;
FUNCTION AddAtomic(amount: SInt32; VAR value: SInt32): SInt32; C;
FUNCTION BitAndAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;
FUNCTION BitOrAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;
FUNCTION BitXorAtomic(mask: UInt32; VAR value: UInt32): UInt32; C;
FUNCTION IncrementAtomic8(VAR value: SInt8): SInt8; C;
FUNCTION DecrementAtomic8(VAR value: SInt8): SInt8; C;
FUNCTION AddAtomic8(amount: SInt32; VAR value: SInt8): SInt8; C;
FUNCTION BitAndAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;
FUNCTION BitOrAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;
FUNCTION BitXorAtomic8(mask: UInt32; VAR value: UInt8): ByteParameter; C;
FUNCTION IncrementAtomic16(VAR value: SInt16): SInt16; C;
FUNCTION DecrementAtomic16(VAR value: SInt16): SInt16; C;
FUNCTION AddAtomic16(amount: SInt32; VAR value: SInt16): SInt16; C;
FUNCTION BitAndAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;
FUNCTION BitOrAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;
FUNCTION BitXorAtomic16(mask: UInt32; VAR value: UInt16): UInt16; C;
FUNCTION PBQueueInit(qHeader: QHdrPtr): OSErr; C;
FUNCTION PBQueueCreate(VAR qHeader: QHdrPtr): OSErr; C;
FUNCTION PBQueueDelete(qHeader: QHdrPtr): OSErr; C;
PROCEDURE PBEnqueue(qElement: QElemPtr; qHeader: QHdrPtr); C;
FUNCTION PBEnqueueLast(qElement: QElemPtr; qHeader: QHdrPtr): OSErr; C;
FUNCTION PBDequeue(qElement: QElemPtr; qHeader: QHdrPtr): OSErr; C;
FUNCTION PBDequeueFirst(qHeader: QHdrPtr; VAR theFirstqElem: QElemPtr): OSErr; C;
FUNCTION PBDequeueLast(qHeader: QHdrPtr; VAR theLastqElem: QElemPtr): OSErr; C;
FUNCTION CStrCopy(dst: CStringPtr; src: ConstCStringPtr): CStringPtr; C;
FUNCTION PStrCopy(dst: StringPtr; src: Str255): StringPtr; C;
FUNCTION CStrNCopy(dst: CStringPtr; src: ConstCStringPtr; max: UInt32): CStringPtr; C;
FUNCTION PStrNCopy(dst: StringPtr; src: Str255; max: UInt32): StringPtr; C;
FUNCTION CStrCat(dst: CStringPtr; src: ConstCStringPtr): CStringPtr; C;
FUNCTION PStrCat(dst: StringPtr; src: Str255): StringPtr; C;
FUNCTION CStrNCat(dst: CStringPtr; src: ConstCStringPtr; max: UInt32): CStringPtr; C;
FUNCTION PStrNCat(dst: StringPtr; src: Str255; max: UInt32): StringPtr; C;
PROCEDURE PStrToCStr(dst: CStringPtr; src: Str255); C;
PROCEDURE CStrToPStr(VAR dst: Str255; src: ConstCStringPtr); C;
FUNCTION CStrCmp(s1: ConstCStringPtr; s2: ConstCStringPtr): SInt16; C;
FUNCTION PStrCmp(str1: Str255; str2: Str255): SInt16; C;
FUNCTION CStrNCmp(s1: ConstCStringPtr; s2: ConstCStringPtr; max: UInt32): SInt16; C;
FUNCTION PStrNCmp(str1: Str255; str2: Str255; max: UInt32): SInt16; C;
FUNCTION CStrLen(src: ConstCStringPtr): UInt32; C;
FUNCTION PStrLen(src: Str255): UInt32; C;
FUNCTION DeviceProbe(theSrc: UNIV Ptr; theDest: UNIV Ptr; AccessType: UInt32): OSStatus; C;
FUNCTION DelayForHardware(absoluteTime: AbsoluteTime): OSStatus; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DriverServicesIncludes}

{$ENDC} {__DRIVERSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
