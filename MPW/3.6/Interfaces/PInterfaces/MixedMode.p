{
     File:       MixedMode.p
 
     Contains:   Mixed Mode Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1992-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MixedMode;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MIXEDMODE__}
{$SETC __MIXEDMODE__ := 1}

{$I+}
{$SETC MixedModeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Mixed Mode constants }
{ Current Routine Descriptor Version }

CONST
	kRoutineDescriptorVersion	= 7;

	{	 MixedModeMagic Magic Cookie/Trap number 	}
	_MixedModeMagic				= $AAFE;

	{	 MixedModeState Version for CFM68K Mixed Mode 	}
	kCurrentMixedModeStateRecord = 1;

	{	 Calling Conventions 	}

TYPE
	CallingConventionType				= UInt16;

CONST
	kPascalStackBased			= 0;
	kCStackBased				= 1;
	kRegisterBased				= 2;
	kD0DispatchedPascalStackBased = 8;
	kD1DispatchedPascalStackBased = 12;
	kD0DispatchedCStackBased	= 9;
	kStackDispatchedPascalStackBased = 14;
	kThinkCStackBased			= 5;

	{	 ISA Types 	}

TYPE
	ISAType								= SInt8;

CONST
	kM68kISA					= 0;
	kPowerPCISA					= 1;

	{	 RTA Types 	}

TYPE
	RTAType								= SInt8;

CONST
	kOld68kRTA					= $00;
	kPowerPCRTA					= $00;
	kCFM68kRTA					= $10;


{$IFC TARGET_CPU_PPC }
    GetCurrentISA               = kPowerPCISA;
    GetCurrentRTA               = kPowerPCRTA;
{$ELSEC}
    {$IFC TARGET_CPU_68K }
        GetCurrentISA           = kM68kISA;
        {$IFC TARGET_RT_MAC_CFM }
            GetCurrentRTA       = kCFM68kRTA;
        {$ELSEC}
            GetCurrentRTA       = kOld68kRTA;
        {$ENDC}
    {$ELSEC}
        {$IFC TARGET_CPU_X86 }
            GetCurrentISA       = kX86ISA;
            GetCurrentRTA       = kX86RTA;
        {$ENDC}
    {$ENDC}
{$ENDC}
    GetCurrentArchitecture      = GetCurrentISA + GetCurrentRTA;

	{	 Constants for specifing 68k registers 	}
	kRegisterD0					= 0;
	kRegisterD1					= 1;
	kRegisterD2					= 2;
	kRegisterD3					= 3;
	kRegisterD4					= 8;
	kRegisterD5					= 9;
	kRegisterD6					= 10;
	kRegisterD7					= 11;
	kRegisterA0					= 4;
	kRegisterA1					= 5;
	kRegisterA2					= 6;
	kRegisterA3					= 7;
	kRegisterA4					= 12;
	kRegisterA5					= 13;
	kRegisterA6					= 14;							{  A7 is the same as the PowerPC SP  }
	kCCRegisterCBit				= 16;
	kCCRegisterVBit				= 17;
	kCCRegisterZBit				= 18;
	kCCRegisterNBit				= 19;
	kCCRegisterXBit				= 20;


TYPE
	registerSelectorType				= UInt16;
	{	 SizeCodes we use everywhere 	}

CONST
	kNoByteCode					= 0;
	kOneByteCode				= 1;
	kTwoByteCode				= 2;
	kFourByteCode				= 3;

	{	 Mixed Mode Routine Records 	}

TYPE
	ProcInfoType						= UInt32;
	{	 Routine Flag Bits 	}
	RoutineFlagsType					= UInt16;

CONST
	kProcDescriptorIsAbsolute	= $00;
	kProcDescriptorIsRelative	= $01;

	kFragmentIsPrepared			= $00;
	kFragmentNeedsPreparing		= $02;

	kUseCurrentISA				= $00;
	kUseNativeISA				= $04;

	kPassSelector				= $00;
	kDontPassSelector			= $08;

	kRoutineIsNotDispatchedDefaultRoutine = $00;
	kRoutineIsDispatchedDefaultRoutine = $10;

	kProcDescriptorIsProcPtr	= $00;
	kProcDescriptorIsIndex		= $20;


TYPE
	RoutineRecordPtr = ^RoutineRecord;
	RoutineRecord = RECORD
		procInfo:				ProcInfoType;							{  calling conventions  }
		reserved1:				SInt8;									{  Must be 0  }
		ISA:					ISAType;								{  Instruction Set Architecture  }
		routineFlags:			RoutineFlagsType;						{  Flags for each routine  }
		procDescriptor:			ProcPtr;								{  Where is the thing we’re calling?  }
		reserved2:				UInt32;									{  Must be 0  }
		selector:				UInt32;									{  For dispatched routines, the selector  }
	END;

	RoutineRecordHandle					= ^RoutineRecordPtr;
	{	 Mixed Mode Routine Descriptors 	}
	{	 Definitions of the Routine Descriptor Flag Bits 	}
	RDFlagsType							= UInt8;

CONST
	kSelectorsAreNotIndexable	= $00;
	kSelectorsAreIndexable		= $01;

	{	 Routine Descriptor Structure 	}

TYPE
	RoutineDescriptorPtr = ^RoutineDescriptor;
	RoutineDescriptor = PACKED RECORD
		goMixedModeTrap:		UInt16;									{  Our A-Trap  }
		version:				SInt8;									{  Current Routine Descriptor version  }
		routineDescriptorFlags:	RDFlagsType;							{  Routine Descriptor Flags  }
		reserved1:				UInt32;									{  Unused, must be zero  }
		reserved2:				UInt8;									{  Unused, must be zero  }
		selectorInfo:			UInt8;									{  If a dispatched routine, calling convention, else 0  }
		routineCount:			UInt16;									{  Number of routines in this RD  }
		routineRecords:			ARRAY [0..0] OF RoutineRecord;			{  The individual routines  }
	END;

	RoutineDescriptorHandle				= ^RoutineDescriptorPtr;
	{	 68K MixedModeStateRecord 	}
	MixedModeStateRecordPtr = ^MixedModeStateRecord;
	MixedModeStateRecord = RECORD
		state1:					UInt32;
		state2:					UInt32;
		state3:					UInt32;
		state4:					UInt32;
	END;


	{	 Mixed Mode ProcInfos 	}

CONST
																{  Calling Convention Offsets  }
	kCallingConventionWidth		= 4;
	kCallingConventionPhase		= 0;
	kCallingConventionMask		= $0F;							{  Result Offsets  }
	kResultSizeWidth			= 2;
	kResultSizePhase			= 4;
	kResultSizeMask				= $30;							{  Parameter offsets & widths  }
	kStackParameterWidth		= 2;
	kStackParameterPhase		= 6;
	kStackParameterMask			= $FFFFFFC0;					{  Register Result Location offsets & widths  }
	kRegisterResultLocationWidth = 5;
	kRegisterResultLocationPhase = 6;							{  Register Parameter offsets & widths  }
	kRegisterParameterWidth		= 5;
	kRegisterParameterPhase		= 11;
	kRegisterParameterMask		= $7FFFF800;
	kRegisterParameterSizePhase	= 0;
	kRegisterParameterSizeWidth	= 2;
	kRegisterParameterWhichPhase = 2;
	kRegisterParameterWhichWidth = 3;							{  Dispatched Stack Routine Selector offsets & widths  }
	kDispatchedSelectorSizeWidth = 2;
	kDispatchedSelectorSizePhase = 6;							{  Dispatched Stack Routine Parameter offsets  }
	kDispatchedParameterPhase	= 8;							{  Special Case offsets & widths  }
	kSpecialCaseSelectorWidth	= 6;
	kSpecialCaseSelectorPhase	= 4;
	kSpecialCaseSelectorMask	= $03F0;

	kSpecialCase				= $000F;						{  (CallingConventionType)  }

																{  all of the special cases enumerated.  The selector field is 6 bits wide  }
	kSpecialCaseHighHook		= 0;
	kSpecialCaseCaretHook		= 0;							{  same as kSpecialCaseHighHook  }
	kSpecialCaseEOLHook			= 1;
	kSpecialCaseWidthHook		= 2;
	kSpecialCaseTextWidthHook	= 2;							{  same as kSpecialCaseWidthHook  }
	kSpecialCaseNWidthHook		= 3;
	kSpecialCaseDrawHook		= 4;
	kSpecialCaseHitTestHook		= 5;
	kSpecialCaseTEFindWord		= 6;
	kSpecialCaseProtocolHandler	= 7;
	kSpecialCaseSocketListener	= 8;
	kSpecialCaseTERecalc		= 9;
	kSpecialCaseTEDoText		= 10;
	kSpecialCaseGNEFilterProc	= 11;
	kSpecialCaseMBarHook		= 12;


	{	
	    NOTES ON USING ROUTINE DESCRIPTOR FUNCTIONS
	    
	    When calling these routine from classic 68k code there are two possible intentions.
	
	    The first is source compatibility with code ported to CFM (either PowerPC or 68k CFM). When
	    the code is compiled for CFM the functions create routine descriptors that can be used by
	    the mixed mode manager operating on that machine. When the code is compiled for classic 68k
	    these functions do nothing so that the code will run on Macintoshes that do not have a
	    mixed mode manager. The dual nature of these functions is achieved by turning the CFM calls
	    into "no-op" macros for classic 68k: You can put "NewRoutineDescriptor" in your source,
	    compile it for any runtime or instruction set architecture, and it will run correctly on the
	    intended runtime/instruction platform. All without source changes and/or conditional source.
	    
	    The other intention is for code that "knows" that it is executing as classic 68k runtime
	    and is specifically trying to call code of another architecture using mixed mode. Since the
	    routines were designed with classic <-> CFM source compatibility in mind this second case
	    is treated special. For classic 68k code to create routines descriptors for use by mixed mode
	    it must call the "Trap" versions of the routines (NewRoutineDescriptorTrap). These versions
	    are only available to classic 68k callers: rigging the interfaces to allow calling them
	    from CFM code will result in runtime failure because no shared library implements or exports
	    the functions.
	    
	
	    This almost appears seamless until you consider "fat" routine descriptors and the advent of
	    CFM-68K. What does "fat" mean? CFM-68K is not emulated on PowerPC and PowerPC is not emulated
	    on CFM-68K. It makes no sense to create a routine descriptor having both a CFM-68K routine
	    and a PowerPC native routine pointer. Therefore "fat" is defined to be a mix of classic and
	    CFM for the hardware's native instruction set: on PowerPC fat is classic and PowerPC native,
	    on a 68k machine with CFM-68K installed fat is classic and CFM-68K.
	    
	    By definition fat routine descriptors are only constructed by code that is aware of the 
	    architecture it is executing as and that another architecture exists. Source compatibility
	    between code intented as pure classic and pure CFM is not an issue and so NewFatRoutineDescriptor
	    is not available when building pure classic code.
	    
	    NewFatRoutineDescriptorTrap is available to classic code on both PowerPC and CFM-68K. The
	    classic code can use the code fragment manager routine "FindSymbol" to obtain the address of 
	    a routine in a shared library and then construct a routine descriptor with both the CFM routine 
	    and classic routine.
		}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewRoutineDescriptor()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewRoutineDescriptor(theProc: ProcPtr; theProcInfo: ProcInfoType; theISA: ISAType): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $5C4F, $2E9F;
	{$ENDC}

{
 *  DisposeRoutineDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeRoutineDescriptor(theUPP: UniversalProcPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  NewFatRoutineDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFatRoutineDescriptor(theM68kProc: ProcPtr; thePowerPCProc: ProcPtr; theProcInfo: ProcInfoType): UniversalProcPtr;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM }
{
    The "Trap" versions of the MixedMode calls are only for classic 68K clients that 
    want to load and use CFM based code.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  NewRoutineDescriptorTrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewRoutineDescriptorTrap(theProc: ProcPtr; theProcInfo: ProcInfoType; theISA: ISAType): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AA59;
	{$ENDC}

{
 *  DisposeRoutineDescriptorTrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeRoutineDescriptorTrap(theProcPtr: UniversalProcPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA59;
	{$ENDC}

{
 *  NewFatRoutineDescriptorTrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFatRoutineDescriptorTrap(theM68kProc: ProcPtr; thePowerPCProc: ProcPtr; theProcInfo: ProcInfoType): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA59;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$IFC NOT TARGET_CPU_68K OR TARGET_RT_MAC_CFM }
{
    CallUniversalProc is defined for all targets except classic 68k code.  This will 
    catch accidental calls from classic 68K code that previously only showed up as 
    linker errors.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  CallUniversalProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CallUniversalProc(theProcPtr: UniversalProcPtr; procInfo: ProcInfoType; ...): LONGINT; C;

{
 *  CallOSTrapUniversalProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CallOSTrapUniversalProc(theProcPtr: UniversalProcPtr; procInfo: ProcInfoType; ...): LONGINT; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SaveMixedModeState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SaveMixedModeState(VAR stateStorage: MixedModeStateRecord; stateVersion: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA59;
	{$ENDC}

{
 *  RestoreMixedModeState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RestoreMixedModeState(VAR stateStorage: MixedModeStateRecord; stateVersion: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA59;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}

{ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 *
 *  Macros for building ProcInfos.  Examples:
 *  
 *  
 *  uppModalFilterProcInfo = kPascalStackBased
 *       | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
 *       | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogRef)))
 *       | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*)))
 *       | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short*))),
 *
 *  uppDeskHookProcInfo = kRegisterBased
 *       | REGISTER_ROUTINE_PARAMETER(1, kRegisterD0, SIZE_CODE(sizeof(Boolean)))
 *       | REGISTER_ROUTINE_PARAMETER(2, kRegisterA0, SIZE_CODE(sizeof(EventRecord*)))
 *
 *  uppGXSpoolResourceProcInfo = kCStackBased
 *       | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
 *       | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
 *       | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Handle)))
 *       | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(ResType)))
 *       | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
 *
 *  uppTEFindWordProcInfo = SPECIAL_CASE_PROCINFO( 6 ),
 *
 }





{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MixedModeIncludes}

{$ENDC} {__MIXEDMODE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
