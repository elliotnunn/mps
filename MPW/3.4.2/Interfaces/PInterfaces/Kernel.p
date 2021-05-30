{
 	File:		Kernel.p
 
 	Contains:	Kernel Interfaces
 
 	Version:	Technology:	PowerSurge 1.0.2
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
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
 UNIT Kernel;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KERNEL__}
{$SETC __KERNEL__ := 1}

{$I+}
{$SETC KernelIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __MACHINEEXCEPTIONS__}
{$I MachineExceptions.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{  Kernel basics }

TYPE
	AddressSpaceID = ^LONGINT;
	IOPreparationID = ^LONGINT;
	SoftwareInterruptID = ^LONGINT;
	TaskID = ^LONGINT;
	TimerID = ^LONGINT;
	
{  OrderedItems }
	OrderedItemService					= OSType;
	OrderedItemSignature				= OSType;

CONST
	kMatchAnyOrderedItemService	= '****';
	kMatchAnyOrderedItemSignature = '****';
	kDoNotMatchAnyOrderedItemService = '----';
	kDoNotMatchAnyOrderedItemSignature = '----';


TYPE
	OrderedItemNamePtr = ^OrderedItemName;
	OrderedItemName = RECORD
		service:				OrderedItemService;
		signature:				OrderedItemSignature;
	END;

	OrderedItemOptions					= OptionBits;

CONST
	kOrderedItemIsRightBefore	= $00000001;
	kOrderedItemIsRightAfter	= $00000002;


TYPE
	OrderRequirementsPtr = ^OrderRequirements;
	OrderRequirements = RECORD
		options:				OrderedItemOptions;
		itemBefore:				OrderedItemName;
		itemAfter:				OrderedItemName;
	END;

{  Tasking }
	ExecutionLevel						= UInt32;

CONST
	kTaskLevel					= 0;
	kSoftwareInterruptLevel		= 1;
	kAcceptFunctionLevel		= 2;
	kKernelLevel				= 3;
	kSIHAcceptFunctionLevel		= 4;
	kSecondaryInterruptLevel	= 5;
	kHardwareInterruptLevel		= 6;


TYPE
	SoftwareInterruptHandler = ProcPtr;  { PROCEDURE SoftwareInterruptHandler(p1: UNIV Ptr; p2: UNIV Ptr); C; }

	SecondaryInterruptHandler2 = ProcPtr;  { FUNCTION SecondaryInterruptHandler2(p1: UNIV Ptr; p2: UNIV Ptr): OSStatus; C; }

{  Memory System basics }

CONST
	kNoAreaID					= 0;


TYPE
	LogicalAddressRangePtr = ^LogicalAddressRange;
	LogicalAddressRange = RECORD
		address:				LogicalAddress;
		count:					ByteCount;
	END;

	PhysicalAddressRangePtr = ^PhysicalAddressRange;
	PhysicalAddressRange = RECORD
		address:				PhysicalAddress;
		count:					ByteCount;
	END;

{  For PrepareMemoryForIO and CheckpointIO }
	IOPreparationOptions				= OptionBits;

CONST
	kIOMultipleRanges			= $00000001;
	kIOLogicalRanges			= $00000002;
	kIOMinimalLogicalMapping	= $00000004;
	kIOShareMappingTables		= $00000008;
	kIOIsInput					= $00000010;
	kIOIsOutput					= $00000020;
	kIOCoherentDataPath			= $00000040;
	kIOTransferIsLogical		= $00000080;
	kIOClientIsUserMode			= $00000080;


TYPE
	IOPreparationState					= OptionBits;

CONST
	kIOStateDone				= $00000001;

	kInvalidPageAddress			= -1;


TYPE
	AddressRangePtr = ^AddressRange;
	AddressRange = RECORD
		base:					Ptr;
		length:					ByteCount;
	END;

{  C's treatment of arrays and array pointers is atypical }
	LogicalMappingTablePtr				= ^LogicalAddress;
	PhysicalMappingTablePtr				= ^PhysicalAddress;
	AddressRangeTablePtr				= ^AddressRange;
	MultipleAddressRangePtr = ^MultipleAddressRange;
	MultipleAddressRange = RECORD
		entryCount:				ItemCount;
		rangeTable:				AddressRangeTablePtr;
	END;

{  Separate C definition so that union has a name.  A future version of the interfacer }
{  tool will allow a name (that gets thrown out in Pascal and Asm). }
	IOPreparationTablePtr = ^IOPreparationTable;
	IOPreparationTable = RECORD
		options:				IOPreparationOptions;
		state:					IOPreparationState;
		preparationID:			IOPreparationID;
		addressSpace:			AddressSpaceID;
		granularity:			ByteCount;
		firstPrepared:			ByteCount;
		lengthPrepared:			ByteCount;
		mappingEntryCount:		ItemCount;
		logicalMapping:			LogicalMappingTablePtr;
		physicalMapping:		PhysicalMappingTablePtr;
		CASE INTEGER OF
		0: (
			range:				AddressRange;
			);
		1: (
			multipleRanges:		MultipleAddressRange;
			);
	END;

	IOCheckpointOptions					= OptionBits;

CONST
	kNextIOIsInput				= $00000001;
	kNextIOIsOutput				= $00000002;
	kMoreIOTransfers			= $00000004;

{  For SetProcessorCacheMode }

TYPE
	ProcessorCacheMode					= UInt32;

CONST
	kProcessorCacheModeDefault	= 0;
	kProcessorCacheModeInhibited = 1;
	kProcessorCacheModeWriteThrough = 2;
	kProcessorCacheModeCopyBack	= 3;

{  For GetPageInformation and UnmapMemory }
	kPageInformationVersion		= 0;


TYPE
	PageStateInformation				= UInt32;

CONST
	kPageIsProtected			= $00000001;
	kPageIsProtectedPrivileged	= $00000002;
	kPageIsModified				= $00000004;
	kPageIsReferenced			= $00000008;
	kPageIsLocked				= $00000010;
	kPageIsResident				= $00000020;
	kPageIsShared				= $00000040;
	kPageIsWriteThroughCached	= $00000080;
	kPageIsCopyBackCached		= $00000100;


TYPE
	PageInformationPtr = ^PageInformation;
	PageInformation = RECORD
		area:					AreaID;
		count:					ItemCount;
		information:			ARRAY [0..0] OF PageStateInformation;
	END;

	IteratorKey							= UInt32;
{   Hardware Interrupt related declarations   }
	InterruptVector						= UInt32;
	InterruptVectorHandler = ProcPtr;  { PROCEDURE InterruptVectorHandler(theVector: InterruptVector; theParameter: UNIV Ptr); C; }

FUNCTION CurrentExecutionLevel: ExecutionLevel; C;
FUNCTION CurrentTaskID: TaskID; C;
FUNCTION DelayFor(expirationTime: Duration): OSStatus; C;
{   Software Interrupts   }
FUNCTION CreateSoftwareInterrupt(handler: SoftwareInterruptHandler; task: TaskID; p1: UNIV Ptr; persistent: BOOLEAN; VAR softwareInterrupt: SoftwareInterruptID): OSStatus; C;
FUNCTION SendSoftwareInterrupt(softwareInterrupt: SoftwareInterruptID; p2: UNIV Ptr): OSStatus; C;
FUNCTION DeleteSoftwareInterrupt(softwareInterrupt: SoftwareInterruptID): OSStatus; C;
PROCEDURE RunSoftwareInterrupts; C;
{   Secondary Interrupts   }
FUNCTION CallSecondaryInterruptHandler2(handler: SecondaryInterruptHandler2; exceptionHandler: ExceptionHandler; p1: UNIV Ptr; p2: UNIV Ptr): OSStatus; C;
FUNCTION QueueSecondaryInterruptHandler(handler: SecondaryInterruptHandler2; exceptionHandler: ExceptionHandler; p1: UNIV Ptr; p2: UNIV Ptr): OSStatus; C;
{   Timers   }
FUNCTION SetInterruptTimer({CONST}VAR expirationTime: AbsoluteTime; handler: SecondaryInterruptHandler2; p1: UNIV Ptr; VAR timer: TimerID): OSStatus; C;
FUNCTION CancelTimer(timer: TimerID; VAR timeRemaining: AbsoluteTime): OSStatus; C;
{   IO related Operations   }
FUNCTION PrepareMemoryForIO(VAR theIOPreparationTable: IOPreparationTable): OSStatus; C;
FUNCTION CheckpointIO(thePreparationID: IOPreparationID; theOptions: IOCheckpointOptions): OSStatus; C;
{   Memory Operations   }
FUNCTION GetPageInformation(theAddressSpace: AddressSpaceID; theBase: LogicalAddress; theLength: ByteCount; theVersion: PBVersion; VAR thePageInfo: PageInformation): OSStatus; C;
{   Processor Cache Related   }
FUNCTION SetProcessorCacheMode(theAddressSpace: AddressSpaceID; theBase: UNIV Ptr; theLength: ByteCount; theMode: ProcessorCacheMode): OSStatus; C;
{   Debugging   }
PROCEDURE SysDebug; C;
PROCEDURE SysDebugStr(str: StringPtr); C;
{   Hardware Interrupts   }
FUNCTION InstallInterruptVectorHandler(theVector: InterruptVector; theHandler: InterruptVectorHandler; theExceptionHandler: ExceptionHandler; theParameter1: UNIV Ptr): OSStatus; C;
FUNCTION RemoveInterruptVectorHandler(theVector: InterruptVector; theHandler: InterruptVectorHandler): OSStatus; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := KernelIncludes}

{$ENDC} {__KERNEL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
