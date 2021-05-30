/*
 	File:		MachineExceptions.h
 
 	Contains:	Processor Exception Handling Interfaces .
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __MACHINEEXCEPTIONS__
#define __MACHINEEXCEPTIONS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=power
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

typedef KernelID AreaID;

/* Machine Dependent types for PowerPC: */
struct MachineInformationPowerPC {
	UnsignedWide					CTR;
	UnsignedWide					LR;
	UnsignedWide					PC;
	unsigned long					CR;
	unsigned long					XER;
	unsigned long					MSR;
};
typedef struct MachineInformationPowerPC MachineInformationPowerPC;

struct RegisterInformationPowerPC {
	UnsignedWide					R0;
	UnsignedWide					R1;
	UnsignedWide					R2;
	UnsignedWide					R3;
	UnsignedWide					R4;
	UnsignedWide					R5;
	UnsignedWide					R6;
	UnsignedWide					R7;
	UnsignedWide					R8;
	UnsignedWide					R9;
	UnsignedWide					R10;
	UnsignedWide					R11;
	UnsignedWide					R12;
	UnsignedWide					R13;
	UnsignedWide					R14;
	UnsignedWide					R15;
	UnsignedWide					R16;
	UnsignedWide					R17;
	UnsignedWide					R18;
	UnsignedWide					R19;
	UnsignedWide					R20;
	UnsignedWide					R21;
	UnsignedWide					R22;
	UnsignedWide					R23;
	UnsignedWide					R24;
	UnsignedWide					R25;
	UnsignedWide					R26;
	UnsignedWide					R27;
	UnsignedWide					R28;
	UnsignedWide					R29;
	UnsignedWide					R30;
	UnsignedWide					R31;
};
typedef struct RegisterInformationPowerPC RegisterInformationPowerPC;

struct FPUInformationPowerPC {
	UnsignedWide					Registers[32];
	unsigned long					FPSCR;
	unsigned long					Reserved;
};
typedef struct FPUInformationPowerPC FPUInformationPowerPC;


enum {
	kWriteReference				= 0,
	kReadReference				= 1,
	kFetchReference				= 2,
	writeReference				= kWriteReference,				/* Obsolete name*/
	readReference				= kReadReference,				/* Obsolete name*/
	fetchReference				= kFetchReference				/* Obsolete name*/
};

typedef unsigned long MemoryReferenceKind;

struct MemoryExceptionInformation {
	AreaID							theArea;
	LogicalAddress					theAddress;
	OSStatus						theError;
	MemoryReferenceKind				theReference;
};
typedef struct MemoryExceptionInformation MemoryExceptionInformation;


enum {
	kUnknownException			= 0,
	kIllegalInstructionException = 1,
	kTrapException				= 2,
	kAccessException			= 3,
	kUnmappedMemoryException	= 4,
	kExcludedMemoryException	= 5,
	kReadOnlyMemoryException	= 6,
	kUnresolvablePageFaultException = 7,
	kPrivilegeViolationException = 8,
	kTraceException				= 9,
	kInstructionBreakpointException = 10,
	kDataBreakpointException	= 11,
	kIntegerException			= 12,
	kFloatingPointException		= 13,
	kStackOverflowException		= 14,
	kTerminationException		= 15,
	unknownException			= kUnknownException,			/* Obsolete name*/
	illegalInstructionException	= kIllegalInstructionException,	/* Obsolete name*/
	trapException				= kTrapException,				/* Obsolete name*/
	accessException				= kAccessException,				/* Obsolete name*/
	unmappedMemoryException		= kUnmappedMemoryException,		/* Obsolete name*/
	excludedMemoryException		= kExcludedMemoryException,		/* Obsolete name*/
	readOnlyMemoryException		= kReadOnlyMemoryException,		/* Obsolete name*/
	unresolvablePageFaultException = kUnresolvablePageFaultException, /* Obsolete name*/
	privilegeViolationException	= kPrivilegeViolationException,	/* Obsolete name*/
	traceException				= kTraceException,				/* Obsolete name*/
	instructionBreakpointException = kInstructionBreakpointException, /* Obsolete name*/
	dataBreakpointException		= kDataBreakpointException,		/* Obsolete name*/
	integerException			= kIntegerException,			/* Obsolete name*/
	floatingPointException		= kFloatingPointException,		/* Obsolete name*/
	stackOverflowException		= kStackOverflowException,		/* Obsolete name*/
	terminationException		= kTerminationException			/* Obsolete name*/
};

typedef unsigned long ExceptionKind;

union ExceptionInfo {
	MemoryExceptionInformation		*memoryInfo;
};
typedef union ExceptionInfo ExceptionInfo;

struct ExceptionInformationPowerPC {
	ExceptionKind					theKind;
	MachineInformationPowerPC		*machineState;
	RegisterInformationPowerPC		*registerImage;
	FPUInformationPowerPC			*FPUImage;
	ExceptionInfo					info;
};
typedef struct ExceptionInformationPowerPC ExceptionInformationPowerPC;

#if GENERATINGPOWERPC
typedef ExceptionInformationPowerPC ExceptionInformation;

typedef MachineInformationPowerPC MachineInformation;

typedef RegisterInformationPowerPC RegisterInformation;

typedef FPUInformationPowerPC FPUInformation;

#endif
/* Note:	An ExceptionHandler is NOT a UniversalProcPtr.
			It must be a native function pointer with NO routine descriptor. */
typedef OSStatus (*ExceptionHandler)(ExceptionInformationPowerPC *theException);
/* Routine for installing per-process exception handlers */
extern pascal ExceptionHandler InstallExceptionHandler(ExceptionHandler theHandler);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MACHINEEXCEPTIONS__ */
