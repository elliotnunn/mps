{
 	File:		MachineExceptions.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MachineExceptions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACHINEEXCEPTIONS__}
{$SETC __MACHINEEXCEPTIONS__ := 1}

{$I+}
{$SETC MachineExceptionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	AreaID = KernelID;

{ Machine Dependent types for PowerPC: }
	MachineInformationPowerPC = RECORD
		CTR:					UnsignedWide;
		LR:						UnsignedWide;
		PC:						UnsignedWide;
		CR:						LONGINT;
		XER:					LONGINT;
		MSR:					LONGINT;
	END;

	RegisterInformationPowerPC = RECORD
		R0:						UnsignedWide;
		R1:						UnsignedWide;
		R2:						UnsignedWide;
		R3:						UnsignedWide;
		R4:						UnsignedWide;
		R5:						UnsignedWide;
		R6:						UnsignedWide;
		R7:						UnsignedWide;
		R8:						UnsignedWide;
		R9:						UnsignedWide;
		R10:					UnsignedWide;
		R11:					UnsignedWide;
		R12:					UnsignedWide;
		R13:					UnsignedWide;
		R14:					UnsignedWide;
		R15:					UnsignedWide;
		R16:					UnsignedWide;
		R17:					UnsignedWide;
		R18:					UnsignedWide;
		R19:					UnsignedWide;
		R20:					UnsignedWide;
		R21:					UnsignedWide;
		R22:					UnsignedWide;
		R23:					UnsignedWide;
		R24:					UnsignedWide;
		R25:					UnsignedWide;
		R26:					UnsignedWide;
		R27:					UnsignedWide;
		R28:					UnsignedWide;
		R29:					UnsignedWide;
		R30:					UnsignedWide;
		R31:					UnsignedWide;
	END;

	FPUInformationPowerPC = RECORD
		Registers:				ARRAY [0..31] OF UnsignedWide;
		FPSCR:					LONGINT;
		Reserved:				LONGINT;
	END;


CONST
	kWriteReference				= 0;
	kReadReference				= 1;
	kFetchReference				= 2;
	writeReference				= kWriteReference;				{ Obsolete name}
	readReference				= kReadReference;				{ Obsolete name}
	fetchReference				= kFetchReference;				{ Obsolete name}

	
TYPE
	MemoryReferenceKind = LONGINT;

	MemoryExceptionInformation = RECORD
		theArea:				AreaID;
		theAddress:				LogicalAddress;
		theError:				OSStatus;
		theReference:			MemoryReferenceKind;
	END;


CONST
	kUnknownException			= 0;
	kIllegalInstructionException = 1;
	kTrapException				= 2;
	kAccessException			= 3;
	kUnmappedMemoryException	= 4;
	kExcludedMemoryException	= 5;
	kReadOnlyMemoryException	= 6;
	kUnresolvablePageFaultException = 7;
	kPrivilegeViolationException = 8;
	kTraceException				= 9;
	kInstructionBreakpointException = 10;
	kDataBreakpointException	= 11;
	kIntegerException			= 12;
	kFloatingPointException		= 13;
	kStackOverflowException		= 14;
	kTerminationException		= 15;
	unknownException			= kUnknownException;			{ Obsolete name}
	illegalInstructionException	= kIllegalInstructionException;	{ Obsolete name}
	trapException				= kTrapException;				{ Obsolete name}
	accessException				= kAccessException;				{ Obsolete name}
	unmappedMemoryException		= kUnmappedMemoryException;		{ Obsolete name}
	excludedMemoryException		= kExcludedMemoryException;		{ Obsolete name}
	readOnlyMemoryException		= kReadOnlyMemoryException;		{ Obsolete name}
	unresolvablePageFaultException = kUnresolvablePageFaultException; { Obsolete name}
	privilegeViolationException	= kPrivilegeViolationException;	{ Obsolete name}
	traceException				= kTraceException;				{ Obsolete name}
	instructionBreakpointException = kInstructionBreakpointException; { Obsolete name}
	dataBreakpointException		= kDataBreakpointException;		{ Obsolete name}
	integerException			= kIntegerException;			{ Obsolete name}
	floatingPointException		= kFloatingPointException;		{ Obsolete name}
	stackOverflowException		= kStackOverflowException;		{ Obsolete name}
	terminationException		= kTerminationException;		{ Obsolete name}

	
TYPE
	ExceptionKind = LONGINT;

	ExceptionInfo = RECORD
		CASE INTEGER OF
		0: (
			memoryInfo:					^MemoryExceptionInformation;
		   );
	END;

	ExceptionInformationPowerPC = RECORD
		theKind:				ExceptionKind;
		machineState:			^MachineInformationPowerPC;
		registerImage:			^RegisterInformationPowerPC;
		FPUImage:				^FPUInformationPowerPC;
		info:					ExceptionInfo;
	END;

{$IFC GENERATINGPOWERPC }
	ExceptionInformation = ExceptionInformationPowerPC;

	MachineInformation = MachineInformationPowerPC;

	RegisterInformation = RegisterInformationPowerPC;

	FPUInformation = FPUInformationPowerPC;

{$ENDC}
{ Note:	An ExceptionHandler is NOT a UniversalProcPtr.
			It must be a native function pointer with NO routine descriptor. }
	ExceptionHandler = ProcPtr;  { FUNCTION (VAR theException: ExceptionInformationPowerPC): OSStatus; }

{ Routine for installing per-process exception handlers }

FUNCTION InstallExceptionHandler(theHandler: ExceptionHandler): ExceptionHandler;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MachineExceptionsIncludes}

{$ENDC} {__MACHINEEXCEPTIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
