/*
 	File:		Kernel.h
 
 	Contains:	Kernel Interfaces
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __KERNEL__
#define __KERNEL__


#ifndef __ERRORS__
#include <Errors.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __MACHINEEXCEPTIONS__
#include <MachineExceptions.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

typedef KernelID AddressSpaceID, TimerID, IOPreparationID, TaskID, SoftwareInterruptID;

/* OrderedItems*/
/**/
/* This should move to a more appropriate place in the future.*/
typedef OSType OrderedItemService;

typedef OSType OrderedItemSignature;


enum {
	kMatchAnyOrderedItemService	= (OrderedItemService)'****',
	kMatchAnyOrderedItemSignature = (OrderedItemSignature)'****',
	kDoNotMatchAnyOrderedItemService = (OrderedItemService)'----',
	kDoNotMatchAnyOrderedItemSignature = (OrderedItemSignature)'----'
};

struct OrderedItemName {
	OrderedItemService				service;
	OrderedItemSignature			signature;
};
typedef struct OrderedItemName OrderedItemName, *OrderedItemNamePtr;

typedef OptionBits OrderedItemOptions;


enum {
	kOrderedItemIsRightBefore	= 0x00000001,
	kOrderedItemIsRightAfter	= 0x00000002
};

struct OrderRequirements {
	OrderedItemOptions				options;
	OrderedItemName					itemBefore;
	OrderedItemName					itemAfter;
};
typedef struct OrderRequirements OrderRequirements, *OrderRequirementsPtr;

/* Tasking*/
typedef UInt32 ExecutionLevel;


enum {
	kTaskLevel					= 0,
	kSoftwareInterruptLevel		= 1,
	kAcceptFunctionLevel		= 2,
	kKernelLevel				= 3,
	kSIHAcceptFunctionLevel		= 4,
	kSecondaryInterruptLevel	= 5,
	kHardwareInterruptLevel		= 6
};

typedef void (*SoftwareInterruptHandler)(void *p1, void *p2);
typedef OSStatus (*SecondaryInterruptHandler2)(void *p1, void *p2);
/* Memory System basics*/

enum {
	kNoAreaID					= 0
};

#define kCurrentAddressSpaceID ((AddressSpaceID) -1)
struct LogicalAddressRange {
	LogicalAddress					address;
	ByteCount						count;
};
typedef struct LogicalAddressRange LogicalAddressRange, *LogicalAddressRangePtr;

struct PhysicalAddressRange {
	PhysicalAddress					address;
	ByteCount						count;
};
typedef struct PhysicalAddressRange PhysicalAddressRange, *PhysicalAddressRangePtr;

/* For PrepareMemoryForIO and CheckpointIO*/
typedef OptionBits IOPreparationOptions;


enum {
	kIOMultipleRanges			= 0x00000001,
	kIOLogicalRanges			= 0x00000002,
	kIOMinimalLogicalMapping	= 0x00000004,
	kIOShareMappingTables		= 0x00000008,
	kIOIsInput					= 0x00000010,
	kIOIsOutput					= 0x00000020,
	kIOCoherentDataPath			= 0x00000040,
	kIOTransferIsLogical		= 0x00000080,
	kIOClientIsUserMode			= 0x00000080
};

typedef OptionBits IOPreparationState;


enum {
	kIOStateDone				= 0x00000001
};

enum {
	kInvalidPageAddress			= (-1)
};

struct AddressRange {
	void							*base;
	ByteCount						length;
};
typedef struct AddressRange AddressRange;

/* C's treatment of arrays and array pointers is atypical*/
typedef LogicalAddress *LogicalMappingTablePtr;

typedef PhysicalAddress *PhysicalMappingTablePtr;

typedef struct AddressRange *AddressRangeTablePtr;

struct MultipleAddressRange {
	ItemCount						entryCount;
	AddressRangeTablePtr			rangeTable;
};
typedef struct MultipleAddressRange MultipleAddressRange;

/* Separate C definition so that union has a name.  A future version of the interfacer*/
/* tool will allow a name (that gets thrown out in Pascal and Asm).*/
struct IOPreparationTable {
	IOPreparationOptions			options;
	IOPreparationState				state;
	IOPreparationID					preparationID;
	AddressSpaceID					addressSpace;
	ByteCount						granularity;
	ByteCount						firstPrepared;
	ByteCount						lengthPrepared;
	ItemCount						mappingEntryCount;
	LogicalMappingTablePtr			logicalMapping;
	PhysicalMappingTablePtr			physicalMapping;
	union {
		AddressRange					range;
		MultipleAddressRange			multipleRanges;
	}								rangeInfo;
};
typedef struct IOPreparationTable IOPreparationTable;

typedef OptionBits IOCheckpointOptions;


enum {
	kNextIOIsInput				= 0x00000001,
	kNextIOIsOutput				= 0x00000002,
	kMoreIOTransfers			= 0x00000004
};

/* For SetProcessorCacheMode*/
typedef UInt32 ProcessorCacheMode;


enum {
	kProcessorCacheModeDefault	= 0,
	kProcessorCacheModeInhibited = 1,
	kProcessorCacheModeWriteThrough = 2,
	kProcessorCacheModeCopyBack	= 3
};

/* For GetPageInformation and UnmapMemory*/
enum {
	kPageInformationVersion		= 0
};

typedef UInt32 PageStateInformation;


enum {
	kPageIsProtected			= 0x00000001,
	kPageIsProtectedPrivileged	= 0x00000002,
	kPageIsModified				= 0x00000004,
	kPageIsReferenced			= 0x00000008,
	kPageIsLocked				= 0x00000010,
	kPageIsResident				= 0x00000020,
	kPageIsShared				= 0x00000040,
	kPageIsWriteThroughCached	= 0x00000080,
	kPageIsCopyBackCached		= 0x00000100
};

struct PageInformation {
	AreaID							area;
	ItemCount						count;
	PageStateInformation			information[1];
};
typedef struct PageInformation PageInformation, *PageInformationPtr;

typedef UInt32 IteratorKey;

/*  Hardware Interrupt related declarations  */
typedef UInt32 InterruptVector;

typedef void (*InterruptVectorHandler)(InterruptVector theVector, void *theParameter);
extern ExecutionLevel CurrentExecutionLevel(void);
extern TaskID CurrentTaskID(void);
extern OSStatus DelayFor(Duration expirationTime);
/*  Software Interrupts  */
extern OSStatus CreateSoftwareInterrupt(SoftwareInterruptHandler handler, TaskID task, const void *p1, Boolean persistent, SoftwareInterruptID *softwareInterrupt);
extern OSStatus SendSoftwareInterrupt(SoftwareInterruptID softwareInterrupt, const void *p2);
extern OSStatus DeleteSoftwareInterrupt(SoftwareInterruptID softwareInterrupt);
extern void RunSoftwareInterrupts(void);
/*  Secondary Interrupts  */
extern OSStatus CallSecondaryInterruptHandler2(SecondaryInterruptHandler2 handler, ExceptionHandler exceptionHandler, const void *p1, const void *p2);
extern OSStatus QueueSecondaryInterruptHandler(SecondaryInterruptHandler2 handler, ExceptionHandler exceptionHandler, const void *p1, const void *p2);
/*  Timers  */
extern OSStatus SetInterruptTimer(const AbsoluteTime *expirationTime, SecondaryInterruptHandler2 handler, const void *p1, TimerID *timer);
extern OSStatus CancelTimer(TimerID timer, AbsoluteTime *timeRemaining);
/*  IO related Operations  */
extern OSStatus PrepareMemoryForIO(IOPreparationTable *theIOPreparationTable);
extern OSStatus CheckpointIO(IOPreparationID thePreparationID, IOCheckpointOptions theOptions);
/*  Memory Operations  */
extern OSStatus GetPageInformation(AddressSpaceID theAddressSpace, LogicalAddress theBase, ByteCount theLength, PBVersion theVersion, PageInformation *thePageInfo);
/*  Processor Cache Related  */
extern OSStatus SetProcessorCacheMode(AddressSpaceID theAddressSpace, void *theBase, ByteCount theLength, ProcessorCacheMode theMode);
/*  Debugging  */
extern void SysDebug(void);
extern void SysDebugStr(StringPtr str);
/*  Hardware Interrupts  */
extern OSStatus InstallInterruptVectorHandler(InterruptVector theVector, InterruptVectorHandler theHandler, ExceptionHandler theExceptionHandler, const void *theParameter1);
extern OSStatus RemoveInterruptVectorHandler(InterruptVector theVector, InterruptVectorHandler theHandler);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __KERNEL__ */
