/*
 	File:		MixedMode.h
 
 	Contains:	Mixed Mode Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __MIXEDMODE__
#define __MIXEDMODE__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	kRoutineDescriptorVersion	= 7
};

/* MixedModeMagic Magic Cookie/Trap number */
enum {
	_MixedModeMagic				= 0xAAFE
};

/* MixedModeState Version for CFM68K Mixed Mode */

enum {
	kCurrentMixedModeStateRecord = 1
};

/* Calling Conventions */
typedef unsigned short CallingConventionType;


enum {
	kPascalStackBased			= (CallingConventionType)0,
	kCStackBased				= (CallingConventionType)1,
	kRegisterBased				= (CallingConventionType)2,
	kD0DispatchedPascalStackBased = (CallingConventionType)8,
	kD1DispatchedPascalStackBased = (CallingConventionType)12,
	kD0DispatchedCStackBased	= (CallingConventionType)9,
	kStackDispatchedPascalStackBased = (CallingConventionType)14,
	kThinkCStackBased			= (CallingConventionType)5
};

/* ISA Types */
typedef SInt8 ISAType;


enum {
	kM68kISA					= (ISAType)0,
	kPowerPCISA					= (ISAType)1
};

/* RTA Types */
typedef SInt8 RTAType;


enum {
	kOld68kRTA					= (RTAType)(0 << 4),
	kPowerPCRTA					= (RTAType)(0 << 4),
	kCFM68kRTA					= (RTAType)(1 << 4)
};

#if GENERATINGPOWERPC
#define GetCurrentISA() ((ISAType) kPowerPCISA)
#define GetCurrentRTA() ((RTAType) kPowerPCRTA)
#else
#define GetCurrentISA() ((ISAType) kM68kISA)
#if GENERATINGCFM
#define GetCurrentRTA() ((RTAType) kCFM68kRTA)
#else
#define GetCurrentRTA() ((RTAType) kOld68kRTA)
#endif
#endif
#define GetCurrentArchitecture() (GetCurrentISA() | GetCurrentRTA())
enum {
	kRegisterD0					= 0,
	kRegisterD1					= 1,
	kRegisterD2					= 2,
	kRegisterD3					= 3,
	kRegisterD4					= 8,
	kRegisterD5					= 9,
	kRegisterD6					= 10,
	kRegisterD7					= 11,
	kRegisterA0					= 4,
	kRegisterA1					= 5,
	kRegisterA2					= 6,
	kRegisterA3					= 7,
	kRegisterA4					= 12,
	kRegisterA5					= 13,
	kRegisterA6					= 14,
/* A7 is the same as the PowerPC SP */
	kCCRegisterCBit				= 16,
	kCCRegisterVBit				= 17,
	kCCRegisterZBit				= 18,
	kCCRegisterNBit				= 19,
	kCCRegisterXBit				= 20
};

typedef unsigned short registerSelectorType;

/* SizeCodes we use everywhere */

enum {
	kNoByteCode					= 0,
	kOneByteCode				= 1,
	kTwoByteCode				= 2,
	kFourByteCode				= 3
};

/* Mixed Mode Routine Records */
typedef unsigned long ProcInfoType;

/* Routine Flag Bits */
typedef unsigned short RoutineFlagsType;


enum {
	kProcDescriptorIsAbsolute	= (RoutineFlagsType)0x00,
	kProcDescriptorIsRelative	= (RoutineFlagsType)0x01
};

enum {
	kFragmentIsPrepared			= (RoutineFlagsType)0x00,
	kFragmentNeedsPreparing		= (RoutineFlagsType)0x02
};

enum {
	kUseCurrentISA				= (RoutineFlagsType)0x00,
	kUseNativeISA				= (RoutineFlagsType)0x04
};

enum {
	kPassSelector				= (RoutineFlagsType)0x0,
	kDontPassSelector			= (RoutineFlagsType)0x08
};

enum {
	kRoutineIsNotDispatchedDefaultRoutine = (RoutineFlagsType)0x0,
	kRoutineIsDispatchedDefaultRoutine = (RoutineFlagsType)0x10
};

struct RoutineRecord {
	ProcInfoType					procInfo;					/* calling conventions */
	UInt8							reserved1;					/* Must be 0 */
	ISAType							ISA;						/* Instruction Set Architecture */
	RoutineFlagsType				routineFlags;				/* Flags for each routine */
	ProcPtr							procDescriptor;				/* Where is the thing we’re calling? */
	UInt32							reserved2;					/* Must be 0 */
	UInt32							selector;					/* For dispatched routines, the selector */
};
typedef struct RoutineRecord RoutineRecord;

typedef RoutineRecord *RoutineRecordPtr, **RoutineRecordHandle;

/* Mixed Mode Routine Descriptors */
/* Definitions of the Routine Descriptor Flag Bits */
typedef UInt8 RDFlagsType;


enum {
	kSelectorsAreNotIndexable	= (RDFlagsType)0x00,
	kSelectorsAreIndexable		= (RDFlagsType)0x01
};

/* Routine Descriptor Structure */
struct RoutineDescriptor {
	UInt16							goMixedModeTrap;			/* Our A-Trap */
	SInt8							version;					/* Current Routine Descriptor version */
	RDFlagsType						routineDescriptorFlags;		/* Routine Descriptor Flags */
	UInt32							reserved1;					/* Unused, must be zero */
	UInt8							reserved2;					/* Unused, must be zero */
	UInt8							selectorInfo;				/* If a dispatched routine, calling convention, else 0 */
	UInt16							routineCount;				/* Number of routines in this RD */
	RoutineRecord					routineRecords[1];			/* The individual routines */
};
typedef struct RoutineDescriptor RoutineDescriptor;

typedef RoutineDescriptor *RoutineDescriptorPtr, **RoutineDescriptorHandle;
/* 68K MixedModeStateRecord */
struct MixedModeStateRecord {
	UInt32 							state1;
	UInt32 							state2;
	UInt32 							state3;
	UInt32 							state4;
};
typedef struct MixedModeStateRecord MixedModeStateRecord;

#define BUILD_ROUTINE_DESCRIPTOR(procInfo, procedure)  \
	{								\
	_MixedModeMagic,				\
	kRoutineDescriptorVersion,		\
	kSelectorsAreNotIndexable,		\
	0,								\
	0,								\
	0,								\
	0,								\
	{								\
	{								\
	(procInfo),					\
	0,								\
	GetCurrentArchitecture(), 	\
	kProcDescriptorIsAbsolute |	 \
	kFragmentIsPrepared |			\
	kUseNativeISA,					\
	(ProcPtr)(procedure),			\
	0,								\
	0								\
	}								\
	}								\
	}
#define BUILD_FAT_ROUTINE_DESCRIPTOR(m68kProcInfo, m68kProcPtr, powerPCProcInfo, powerPCProcPtr)  \
	{								\
	_MixedModeMagic,				\
	kRoutineDescriptorVersion,		\
	kSelectorsAreNotIndexable,		\
	0,								\
	0,								\
	0,								\
	1,								\
	{								\
	{								\
	(m68kProcInfo),				\
	0,								\
	kM68kISA |						\
	kOld68kRTA,					\
	kProcDescriptorIsAbsolute |	 \
	kUseCurrentISA,				\
	(ProcPtr)(m68kProcPtr),		\
	0,								\
	0,								\
	},								\
	{								\
	(powerPCProcInfo),				\
	0,								\
	GetCurrentArchitecture(), 	\
	kProcDescriptorIsAbsolute |	 \
	kFragmentIsPrepared |			\
	kUseCurrentISA,				\
	(ProcPtr)(powerPCProcPtr),		\
	0,								\
	0								\
	}								\
	}								\
	}

enum {
/* Calling Convention Offsets */
	kCallingConventionWidth		= 4,
	kCallingConventionPhase		= 0,
	kCallingConventionMask		= 0xF,
/* Result Offsets */
	kResultSizeWidth			= 2,
	kResultSizePhase			= kCallingConventionWidth,
	kResultSizeMask				= 0x30,
/* Parameter offsets & widths */
	kStackParameterWidth		= 2,
	kStackParameterPhase		= (kCallingConventionWidth + kResultSizeWidth),
	kStackParameterMask			= 0xFFFFFFC0,
/* Register Result Location offsets & widths */
	kRegisterResultLocationWidth = 5,
	kRegisterResultLocationPhase = (kCallingConventionWidth + kResultSizeWidth),
/* Register Parameter offsets & widths */
	kRegisterParameterWidth		= 5,
	kRegisterParameterPhase		= (kCallingConventionWidth + kResultSizeWidth + kRegisterResultLocationWidth),
	kRegisterParameterMask		= 0x7FFFF800,
	kRegisterParameterSizePhase	= 0,
	kRegisterParameterSizeWidth	= 2,
	kRegisterParameterWhichPhase = kRegisterParameterSizeWidth,
	kRegisterParameterWhichWidth = 3,
/* Dispatched Stack Routine Selector offsets & widths */
	kDispatchedSelectorSizeWidth = 2,
	kDispatchedSelectorSizePhase = (kCallingConventionWidth + kResultSizeWidth),
/* Dispatched Stack Routine Parameter offsets */
	kDispatchedParameterPhase	= (kCallingConventionWidth + kResultSizeWidth + kDispatchedSelectorSizeWidth),
/* Special Case offsets & widths */
	kSpecialCaseSelectorWidth	= 6,
	kSpecialCaseSelectorPhase	= kCallingConventionWidth,
	kSpecialCaseSelectorMask	= 0x3F0,
/* Component Manager Special Case offsets & widths */
	kComponentMgrResultSizeWidth = 2,
	kComponentMgrResultSizePhase = kCallingConventionWidth + kSpecialCaseSelectorWidth, /* 4 + 6 = 10 */
	kComponentMgrParameterWidth	= 2,
	kComponentMgrParameterPhase	= kComponentMgrResultSizePhase + kComponentMgrResultSizeWidth /* 10 + 2 = 12 */
};

#define SIZE_CODE(size) 		\
	(((size) == 4) ? kFourByteCode : (((size) == 2) ? kTwoByteCode : (((size) == 1) ? kOneByteCode : 0)))
#define RESULT_SIZE(sizeCode) 	\
	((ProcInfoType)(sizeCode) << kResultSizePhase)
#define STACK_ROUTINE_PARAMETER(whichParam, sizeCode)  \
	((ProcInfoType)(sizeCode) << (kStackParameterPhase + (((whichParam) - 1) * kStackParameterWidth)))
#define DISPATCHED_STACK_ROUTINE_PARAMETER(whichParam, sizeCode)  \
	((ProcInfoType)(sizeCode) << (kDispatchedParameterPhase + (((whichParam) - 1) * kStackParameterWidth)))
#define DISPATCHED_STACK_ROUTINE_SELECTOR_SIZE(sizeCode)  \
	((ProcInfoType)(sizeCode) << kDispatchedSelectorSizePhase)
#define REGISTER_RESULT_LOCATION(whichReg)  \
	((ProcInfoType)(whichReg) << kRegisterResultLocationPhase)
#define REGISTER_ROUTINE_PARAMETER(whichParam, whichReg, sizeCode)  \
	((((ProcInfoType)(sizeCode) << kRegisterParameterSizePhase) | ((ProcInfoType)(whichReg) << kRegisterParameterWhichPhase)) <<  \
	(kRegisterParameterPhase + (((whichParam) - 1) * kRegisterParameterWidth)))
#define COMPONENT_MGR_RESULT_SIZE(sizeCode)  \
	((ProcInfoType)(sizeCode) << kComponentMgrResultSizePhase)
#define COMPONENT_MGR_PARAMETER(whichParam, sizeCode)  \
	((ProcInfoType)(sizeCode) << (kComponentMgrParameterPhase + (((whichParam) - 1) * kComponentMgrParameterWidth)))
#define SPECIAL_CASE_PROCINFO(specialCaseCode)  \
	(kSpecialCase | ((ProcInfoType)(specialCaseCode) << 4))
enum {
	kSpecialCase				= (CallingConventionType)0x0000000F
};

enum {
/* all of the special cases enumerated.  The selector field is 6 bits wide */
	kSpecialCaseHighHook		= 0,
	kSpecialCaseCaretHook		= 0,							/* same as kSpecialCaseHighHook */
	kSpecialCaseEOLHook			= 1,
	kSpecialCaseWidthHook		= 2,
	kSpecialCaseTextWidthHook	= 2,							/* same as kSpecialCaseWidthHook */
	kSpecialCaseNWidthHook		= 3,
	kSpecialCaseDrawHook		= 4,
	kSpecialCaseHitTestHook		= 5,
	kSpecialCaseTEFindWord		= 6,
	kSpecialCaseProtocolHandler	= 7,
	kSpecialCaseSocketListener	= 8,
	kSpecialCaseTERecalc		= 9,
	kSpecialCaseTEDoText		= 10,
	kSpecialCaseGNEFilterProc	= 11,
	kSpecialCaseMBarHook		= 12,
	kSpecialCaseComponentMgr	= 13
};

/*
	NOTES ON USING New[Fat]RoutineDescriptor[Trap] 
	
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
	and classic	routine.
*/	

#if GENERATINGCFM
extern pascal UniversalProcPtr NewRoutineDescriptor(ProcPtr theProc, ProcInfoType theProcInfo, ISAType theISA);
extern pascal void DisposeRoutineDescriptor(UniversalProcPtr theProcPtr);
extern pascal UniversalProcPtr NewFatRoutineDescriptor(ProcPtr theM68kProc, ProcPtr thePowerPCProc, ProcInfoType theProcInfo);
#else
#define DisposeRoutineDescriptor(theProcPtr)
#define NewRoutineDescriptor(theProc, theProcInfo, theISA) ((UniversalProcPtr)theProc)
/* Note that the call to NewFatRoutineDescriptor is undefined when GENERATINGCFM is false. */

extern pascal UniversalProcPtr NewRoutineDescriptorTrap(ProcPtr theProc, ProcInfoType theProcInfo, ISAType theISA)
 TWOWORDINLINE(0x7000, 0xAA59);
extern pascal void DisposeRoutineDescriptorTrap(UniversalProcPtr theProcPtr)
 TWOWORDINLINE(0x7001, 0xAA59);
extern pascal UniversalProcPtr NewFatRoutineDescriptorTrap(ProcPtr theM68kProc, ProcPtr thePowerPCProc, ProcInfoType theProcInfo)
 TWOWORDINLINE(0x7002, 0xAA59);
#endif

#if GENERATINGCFM
/*
 CallUniversalProc is only implemented in shared libraries on 68k and PowerPC, it is now
 conditionalize with GENERATINGCFM.  This will catch accidental calls from classic 68K code
 that previously only showed up as linker errors.
*/
extern long CallUniversalProc(UniversalProcPtr theProcPtr, ProcInfoType procInfo, ...);
extern long CallOSTrapUniversalProc(UniversalProcPtr theProcPtr, ProcInfoType procInfo, ...);
#endif
#if GENERATING68K
extern pascal OSErr SaveMixedModeState(MixedModeStateRecord *stateStorage, UInt32 stateVersion)
 TWOWORDINLINE(0x7003, 0xAA59);
extern pascal OSErr RestoreMixedModeState(MixedModeStateRecord *stateStorage, UInt32 stateVersion)
 TWOWORDINLINE(0x7004, 0xAA59);
#endif


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MIXEDMODE__ */
