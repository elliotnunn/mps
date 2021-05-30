{
     File:       MachineExceptions.p
 
     Contains:   Processor Exception Handling Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{ Some basic declarations used throughout the kernel }

TYPE
	AreaID    = ^LONGINT; { an opaque 32-bit type }
	AreaIDPtr = ^AreaID;  { when a VAR xx:AreaID parameter can be nil, it is changed to xx: AreaIDPtr }
{$IFC TARGET_OS_MAC }
	{	 Machine Dependent types for PowerPC: 	}
	MachineInformationPowerPCPtr = ^MachineInformationPowerPC;
	MachineInformationPowerPC = RECORD
		CTR:					UnsignedWide;
		LR:						UnsignedWide;
		PC:						UnsignedWide;
		CR:						UInt32;
		XER:					UInt32;
		MSR:					UInt32;
		MQ:						UInt32;
		ExceptKind:				UInt32;
		DSISR:					UInt32;
		DAR:					UnsignedWide;
		Reserved:				UnsignedWide;
	END;

	RegisterInformationPowerPCPtr = ^RegisterInformationPowerPC;
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

	FPUInformationPowerPCPtr = ^FPUInformationPowerPC;
	FPUInformationPowerPC = RECORD
		Registers:				ARRAY [0..31] OF UnsignedWide;
		FPSCR:					UInt32;
		Reserved:				UInt32;
	END;

	Vector128Ptr = ^Vector128;
	Vector128 = RECORD
		CASE INTEGER OF
		0: (
			l:					ARRAY [0..3] OF UInt32;
			);
		1: (
			s:					ARRAY [0..7] OF UInt16;
			);
		2: (
			c:					PACKED ARRAY [0..15] OF UInt8;
			);
	END;

	VectorInformationPowerPCPtr = ^VectorInformationPowerPC;
	VectorInformationPowerPC = RECORD
		Registers:				ARRAY [0..31] OF Vector128;
		VSCR:					Vector128;
		VRsave:					UInt32;
	END;

	{	 Exception related declarations 	}

CONST
	kWriteReference				= 0;
	kReadReference				= 1;
	kFetchReference				= 2;
	writeReference				= 0;							{  Obsolete name }
	readReference				= 1;							{  Obsolete name }
	fetchReference				= 2;							{  Obsolete name }


TYPE
	MemoryReferenceKind					= UInt32;
	MemoryExceptionInformationPtr = ^MemoryExceptionInformation;
	MemoryExceptionInformation = RECORD
		theArea:				AreaID;									{  The area related to the execption, same as MPAreaID. }
		theAddress:				LogicalAddress;							{  The 32-bit address of the exception. }
		theError:				OSStatus;								{  See enum below. }
		theReference:			MemoryReferenceKind;					{  read, write, instruction fetch. }
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
	kInstructionBreakpointException = 10;						{  Optional }
	kDataBreakpointException	= 11;							{  Optional }
	kIntegerException			= 12;
	kFloatingPointException		= 13;
	kStackOverflowException		= 14;							{  Optional, may be implemented as kAccessException on some systems. }
	kTaskTerminationException	= 15;							{  Obsolete }
	kTaskCreationException		= 16;							{  Obsolete }
	kDataAlignmentException		= 17;							{  May occur when a task is in little endian mode or created with kMPTaskTakesAllExceptions. }

{$IFC OLDROUTINENAMES }
	unknownException			= 0;							{  Obsolete name }
	illegalInstructionException	= 1;							{  Obsolete name }
	trapException				= 2;							{  Obsolete name }
	accessException				= 3;							{  Obsolete name }
	unmappedMemoryException		= 4;							{  Obsolete name }
	excludedMemoryException		= 5;							{  Obsolete name }
	readOnlyMemoryException		= 6;							{  Obsolete name }
	unresolvablePageFaultException = 7;							{  Obsolete name }
	privilegeViolationException	= 8;							{  Obsolete name }
	traceException				= 9;							{  Obsolete name }
	instructionBreakpointException = 10;						{  Obsolete name }
	dataBreakpointException		= 11;							{  Obsolete name }
	integerException			= 12;							{  Obsolete name }
	floatingPointException		= 13;							{  Obsolete name }
	stackOverflowException		= 14;							{  Obsolete name }
	terminationException		= 15;							{  Obsolete name }
	kTerminationException		= 15;							{  Obsolete name }

{$ENDC}  {OLDROUTINENAMES}

TYPE
	ExceptionKind						= UInt32;
	ExceptionInfoPtr = ^ExceptionInfo;
	ExceptionInfo = RECORD
		CASE INTEGER OF
		0: (
			memoryInfo:			MemoryExceptionInformationPtr;
			);
	END;

	ExceptionInformationPowerPCPtr = ^ExceptionInformationPowerPC;
	ExceptionInformationPowerPC = RECORD
		theKind:				ExceptionKind;
		machineState:			MachineInformationPowerPCPtr;
		registerImage:			RegisterInformationPowerPCPtr;
		FPUImage:				FPUInformationPowerPCPtr;
		info:					ExceptionInfo;
		vectorImage:			VectorInformationPowerPCPtr;
	END;

{$IFC TARGET_CPU_PPC OR TARGET_CPU_68K }
	ExceptionInformation				= ExceptionInformationPowerPC;
	ExceptionInformationPtr 			= ^ExceptionInformation;
	MachineInformation					= MachineInformationPowerPC;
	MachineInformationPtr 				= ^MachineInformation;
	RegisterInformation					= RegisterInformationPowerPC;
	RegisterInformationPtr 				= ^RegisterInformation;
	FPUInformation						= FPUInformationPowerPC;
	FPUInformationPtr 					= ^FPUInformation;
	VectorInformation					= VectorInformationPowerPC;
	VectorInformationPtr 				= ^VectorInformation;
{$ENDC}
	{	 
	    Note:   An ExceptionHandler is NOT a UniversalProcPtr, except in Carbon.
	            It must be a PowerPC function pointer with NO routine descriptor, 
	            except on Carbon, where it must be a UniversalProcPtr (TPP actually)
	            to allow the interface to work from both CFM and Mach-O.
		}
{$IFC TYPED_FUNCTION_POINTERS}
	ExceptionHandlerProcPtr = FUNCTION(VAR theException: ExceptionInformation): OSStatus; C;
{$ELSEC}
	ExceptionHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ExceptionHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ExceptionHandlerUPP = ExceptionHandlerProcPtr;
{$ENDC}	

CONST
	uppExceptionHandlerProcInfo = $000000F1;
	{
	 *  NewExceptionHandlerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewExceptionHandlerUPP(userRoutine: ExceptionHandlerProcPtr): ExceptionHandlerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeExceptionHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeExceptionHandlerUPP(userUPP: ExceptionHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeExceptionHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeExceptionHandlerUPP(VAR theException: ExceptionInformation; userRoutine: ExceptionHandlerUPP): OSStatus;
{
   ExceptionHandler function pointers (TPP):
   on classic PowerPC, use raw function pointers
   on classic PowerPC with OPAQUE_UPP_TYPES=1, use UPP's
   on Carbon, use UPP's
}
{$IFC TARGET_OS_MAC AND NOT OPAQUE_UPP_TYPES }
{  use raw function pointers }

TYPE
	ExceptionHandlerTPP					= ExceptionHandlerProcPtr;
{$ELSEC}
{  use UPP's }

TYPE
	ExceptionHandlerTPP					= ExceptionHandlerUPP;
{$ENDC}
	ExceptionHandler					= ExceptionHandlerTPP;
	{	 Routine for installing per-process exception handlers 	}
	{
	 *  InstallExceptionHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION InstallExceptionHandler(theHandler: ExceptionHandlerTPP): ExceptionHandlerTPP;

{$ENDC}  {TARGET_OS_MAC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MachineExceptionsIncludes}

{$ENDC} {__MACHINEEXCEPTIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
