/*
 	File:		OSA.h
 
 	Contains:	AppleScript Client Interfaces.
 
 	Version:	Technology:	AppleScript 1.1
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __OSA__
#define __OSA__


#ifndef __ERRORS__
#include <Errors.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Types.h>											*/
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <OSUtils.h>										*/
/*	#include <Events.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __AEOBJECTS__
#include <AEObjects.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
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


enum {
	kOSAComponentType			= 'osa '
};

/* 0x73637074 */
enum {
	kOSAGenericScriptingComponentSubtype = 'scpt'
};

/*	Type of script document files.	*/
/* 0x6f736173 */
enum {
	kOSAFileType				= 'osas'
};

/*
		Suite and event code of the RecordedText event. 
		(See OSAStartRecording, below.)
	*/
/* 0x61736372 */
enum {
	kOSASuite					= 'ascr'
};

/* 0x72656364 */
enum {
	kOSARecordedText			= 'recd'
};

/* Selector returns boolean */
/* 0x6d6f6469 */
enum {
	kOSAScriptIsModified		= 'modi'
};

/* Selector returns boolean */
/* 0x63736372 */
enum {
	kOSAScriptIsTypeCompiledScript = 'cscr'
};

/* Selector returns boolean */
/* 0x76616c75 */
enum {
	kOSAScriptIsTypeScriptValue	= 'valu'
};

/* Selector returns boolean */
/* 0x636e7478 */
enum {
	kOSAScriptIsTypeScriptContext = 'cntx'
};

/* Selector returns a DescType which may be passed to OSACoerceToDesc */
/* 0x62657374 */
enum {
	kOSAScriptBestType			= 'best'
};

/*
		This selector is used to determine whether a script has source 
		associated with it that when given to OSAGetSource, the call will not
		fail.  The selector returns a boolean.
	*/
/* 0x67737263 */
enum {
	kOSACanGetSource			= 'gsrc'
};

enum {
	typeOSADialectInfo			= 'difo',						/*  0x6469666f   */
	keyOSADialectName			= 'dnam',						/*  0x646e616d   */
	keyOSADialectCode			= 'dcod',						/*  0x64636f64   */
	keyOSADialectLangCode		= 'dlcd',						/*  0x646c6364   */
	keyOSADialectScriptCode		= 'dscd'
};

typedef ComponentResult OSAError;

/* Under the Open Scripting Architecture all error results are longs */
typedef unsigned long OSAID;

/*
		OSAIDs allow transparent manipulation of scripts associated with
	 	various scripting systems.
	*/

enum {
	kOSANullScript				= (OSAID)0
};

/* No -script constant. */
enum {
	kOSANullMode				= 0,							/* sounds better */
	kOSAModeNull				= 0								/* tastes consistent */
};

/*
		Some routines take flags that control their execution.  This constant
		declares default mode settings are used.
	*/
typedef pascal OSErr (*OSACreateAppleEventProcPtr)(AEEventClass theAEEventClass, AEEventID theAEEventID, const AEAddressDesc *target, short returnID, long transactionID, AppleEvent *result, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr OSACreateAppleEventUPP;
#else
typedef OSACreateAppleEventProcPtr OSACreateAppleEventUPP;
#endif

enum {
	uppOSACreateAppleEventProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(AEEventClass)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(AEEventID)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(AEAddressDesc*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(AppleEvent*)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewOSACreateAppleEventProc(userRoutine)		\
		(OSACreateAppleEventUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppOSACreateAppleEventProcInfo, GetCurrentArchitecture())
#else
#define NewOSACreateAppleEventProc(userRoutine)		\
		((OSACreateAppleEventUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallOSACreateAppleEventProc(userRoutine, theAEEventClass, theAEEventID, target, returnID, transactionID, result, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppOSACreateAppleEventProcInfo, (theAEEventClass), (theAEEventID), (target), (returnID), (transactionID), (result), (refCon))
#else
#define CallOSACreateAppleEventProc(userRoutine, theAEEventClass, theAEEventID, target, returnID, transactionID, result, refCon)		\
		(*(userRoutine))((theAEEventClass), (theAEEventID), (target), (returnID), (transactionID), (result), (refCon))
#endif

typedef pascal OSErr (*OSASendProcPtr)(const AppleEvent *theAppleEvent, AppleEvent *reply, AESendMode sendMode, AESendPriority sendPriority, long timeOutInTicks, AEIdleUPP idleProc, AEFilterUPP filterProc, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr OSASendUPP;
#else
typedef OSASendProcPtr OSASendUPP;
#endif

enum {
	uppOSASendProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(AppleEvent*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(AppleEvent*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(AESendMode)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(AESendPriority)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(AEIdleUPP)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(AEFilterUPP)))
		 | STACK_ROUTINE_PARAMETER(8, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewOSASendProc(userRoutine)		\
		(OSASendUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppOSASendProcInfo, GetCurrentArchitecture())
#else
#define NewOSASendProc(userRoutine)		\
		((OSASendUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallOSASendProc(userRoutine, theAppleEvent, reply, sendMode, sendPriority, timeOutInTicks, idleProc, filterProc, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppOSASendProcInfo, (theAppleEvent), (reply), (sendMode), (sendPriority), (timeOutInTicks), (idleProc), (filterProc), (refCon))
#else
#define CallOSASendProc(userRoutine, theAppleEvent, reply, sendMode, sendPriority, timeOutInTicks, idleProc, filterProc, refCon)		\
		(*(userRoutine))((theAppleEvent), (reply), (sendMode), (sendPriority), (timeOutInTicks), (idleProc), (filterProc), (refCon))
#endif

/**************************************************************************
	Standard Script Errors
**************************************************************************
	It is recommended that scripting components use the following set of error
	codes to signal failure when applicable.  This enables applications that
	use the OSA API to deal with some class of script errors in a less than 
	ad hoc manner.  Scripting components are of course encouraged to return
	component-specific errors when these don't apply.
**************************************************************************/
/*		Dynamic errors:

	These errors result from data-dependent conditions and are typically
	signaled at runtime.
*/
/*
		Signaled when a value can't be coerced to the desired type. Similar
	  	to errOSATypeError except results from coercion.
	*/
enum {
	errOSACantCoerce			= errAECoercionFail
};

/* Signaled when an object is not found in a container */
enum {
	errOSACantAccess			= errAENoSuchObject
};

/*
		Signaled when an object cannot be set in a container.  Same as 
	  	AERegistry error errAEWriteDenied.
	*/
enum {
	errOSACantAssign			= -10006
};

/*
		Signaled by user scripts or applications when no actual error code
	  	is to be returned.  Simply means "an error has occurred".  Most useful
	  	in conjunction with an error message from the application.
	*/
enum {
	errOSAGeneralError			= -2700
};

/* Signaled when there is an attempt to divide by zero */
enum {
	errOSADivideByZero			= -2701
};

/* Signaled when integer or real value is too large to be represented */
enum {
	errOSANumericOverflow		= -2702
};

/*
		Signaled when application can't be launched or when it is remote and
	  	program linking is not enabled.
	*/
enum {
	errOSACantLaunch			= -2703
};

/* Signaled when an application can't respond to AppleEvents */
enum {
	errOSAAppNotHighLevelEventAware = -2704
};

/* Signaled when an application's terminology resource is not readable */
enum {
	errOSACorruptTerminology	= -2705
};

/* Signaled when the runtime stack overflows */
enum {
	errOSAStackOverflow			= -2706
};

/* Signaled when a runtime internal data structure overflows */
enum {
	errOSAInternalTableOverflow	= -2707
};

/*
		Signaled when an intrinsic limitation is exceeded for the size of 
	  	a value or data structure.
	*/
enum {
	errOSADataBlockTooLarge		= -2708
};

enum {
	errOSACantGetTerminology	= -2709
};

enum {
	errOSACantCreate			= -2710
};

/*		Component-specific dynamic script errors:

	The range -2720 thru -2739 is reserved for component-specific runtime errors.
	(Note that error codes from different scripting components in this range will
	overlap.)
*/
/*		Static errors:

	These errors comprise what are commonly thought of as parse and compile-
	time errors.  However, in a dynamic system (e.g. AppleScript) any or all
	of these may also occur at runtime.
*/
/* Signaled when data was not the right type and coercion is not allowed */
enum {
	errOSATypeError				= errAEWrongDataType
};

/* Signaled when a message was sent to an object that didn't handle it */
enum {
	OSAMessageNotUnderstood		= errAEEventNotHandled
};

/*
		Signaled when a function to be returned doesn't exist.  (Probably only
	  	useful in languages with first-class functions that distinguish between
	  	functions and other values (two name spaces). This is different from
	  	errOSAMessageNotUnderstood, which may be signaled when the method is
	  	invoked.
	*/
enum {
	OSAUndefinedHandler			= errAEHandlerNotFound
};

/* Signaled when a container can never have the requested object */
enum {
	OSAIllegalAccess			= errAEAccessorNotFound
};

/* Signaled when index was out of range. Specialization of errOSACantAccess. */
enum {
	OSAIllegalIndex				= errAEIllegalIndex
};

/* Signaled when a range is screwy. Specialization of errOSACantAccess. */
enum {
	OSAIllegalRange				= errAEImpossibleRange
};

/*
		Signaled when an object can never be set in a container.  Same as 
	  	AERegistry error errAENotModifiable.
	*/
enum {
	OSAIllegalAssign			= -10003
};

/*
		Signaled when a syntax error occurs. (e.g. "Syntax error" or
	 	"<this> can't go after <that>").
	*/
enum {
	OSASyntaxError				= -2740
};

/*
		Signaled when another form of syntax was expected. (e.g. "expected
	  	a <type> but found <this>").
	*/
enum {
	OSASyntaxTypeError			= -2741
};

/* Signaled when a name or number is too long to be parsed */
enum {
	OSATokenTooLong				= -2742
};

/*
		Signaled when a parameter is missing for a function invocation.  Note
	  	that in some languages, this error may occur at runtime.
	*/
enum {
	OSAMissingParameter			= errAEDescNotFound
};

/*
		Signaled when function is called with the wrong number of parameters,
	  	or a parameter pattern cannot be matched.
	*/
enum {
	OSAParameterMismatch		= errAEWrongNumberArgs
};

/*
		Signaled when a formal parameter, local variable, or instance variable
	  	is specified more than once.
	*/
enum {
	OSADuplicateParameter		= -2750
};

/*
		Signaled when a formal parameter, local variable, or instance variable
	  	is specified more than once.
	*/
enum {
	OSADuplicateProperty		= -2751
};

/*
		Signaled when more than one handler is defined with the same name in 
	  	a scope where the language doesn't allow it.
	*/
enum {
	OSADuplicateHandler			= -2752
};

/* Signaled when a variable is accessed that has no value */
enum {
	OSAUndefinedVariable		= -2753
};

/*
		Signaled when a variable is declared inconsistently in the same scope,
	  	such as both local and global.
	*/
enum {
	OSAInconsistentDeclarations	= -2754
};

/*
		Signaled when illegal control flow occurs in an application (no catcher
	  	for throw, non-lexical loop exit, etc.).
	*/
enum {
	OSAControlFlowError			= -2755
};

/*		Component-specific static script errors:

	The range -2760 thru -2779 is reserved for component-specific parsing and
	compile-time errors. (Note that error codes from different scripting
	components in this range will overlap.)
*/
/*		Dialect-specific script errors:

	The range -2780 thru -2799 is reserved for dialect specific error codes for
	scripting components that support dialects. (Note that error codes from
	different scripting components in this range will overlap, as well as error
	codes from different dialects in the same scripting component.)
*/
/**************************************************************************
	OSA Interface Descriptions
**************************************************************************
	The OSA Interface is broken down into a required interface, and several
	optional interfaces to support additional functionality.  A given scripting
	component may choose to support only some of the optional interfaces in
	addition to the basic interface.  The OSA Component Flags may be used to 
	query the Component Manager to find a scripting component with a particular
	capability, or determine if a particular scripting component supports a 
	particular capability.
**************************************************************************/
/* OSA Component Flags: */
enum {
	kOSASupportsCompiling		= 0x0002,
	kOSASupportsGetSource		= 0x0004,
	kOSASupportsAECoercion		= 0x0008,
	kOSASupportsAESending		= 0x0010,
	kOSASupportsRecording		= 0x0020,
	kOSASupportsConvenience		= 0x0040,
	kOSASupportsDialects		= 0x0080,
	kOSASupportsEventHandling	= 0x0100
};

/* Component Selectors: */
enum {
	kOSASelectLoad				= 0x0001,
	kOSASelectStore				= 0x0002,
	kOSASelectExecute			= 0x0003,
	kOSASelectDisplay			= 0x0004,
	kOSASelectScriptError		= 0x0005,
	kOSASelectDispose			= 0x0006,
	kOSASelectSetScriptInfo		= 0x0007,
	kOSASelectGetScriptInfo		= 0x0008,
	kOSASelectSetActiveProc		= 0x0009,
	kOSASelectGetActiveProc		= 0x000A
};

/* Compiling: */
enum {
	kOSASelectScriptingComponentName = 0x0102,
	kOSASelectCompile			= 0x0103,
	kOSASelectCopyID			= 0x0104
};

/* GetSource: */
enum {
	kOSASelectGetSource			= 0x0201
};

/* AECoercion: */
enum {
	kOSASelectCoerceFromDesc	= 0x0301,
	kOSASelectCoerceToDesc		= 0x0302
};

/* AESending: */
enum {
	kOSASelectSetSendProc		= 0x0401,
	kOSASelectGetSendProc		= 0x0402,
	kOSASelectSetCreateProc		= 0x0403,
	kOSASelectGetCreateProc		= 0x0404,
	kOSASelectSetDefaultTarget	= 0x0405
};

/* Recording: */
enum {
	kOSASelectStartRecording	= 0x0501,
	kOSASelectStopRecording		= 0x0502
};

/* Convenience: */
enum {
	kOSASelectLoadExecute		= 0x0601,
	kOSASelectCompileExecute	= 0x0602,
	kOSASelectDoScript			= 0x0603
};

/* Dialects: */
enum {
	kOSASelectSetCurrentDialect	= 0x0701,
	kOSASelectGetCurrentDialect	= 0x0702,
	kOSASelectAvailableDialects	= 0x0703,
	kOSASelectGetDialectInfo	= 0x0704,
	kOSASelectAvailableDialectCodeList = 0x0705
};

/* Event Handling: */
enum {
	kOSASelectSetResumeDispatchProc = 0x0801,
	kOSASelectGetResumeDispatchProc = 0x0802,
	kOSASelectExecuteEvent		= 0x0803,
	kOSASelectDoEvent			= 0x0804,
	kOSASelectMakeContext		= 0x0805
};

/* scripting component specific selectors are added beginning with this value  */
enum {
	kOSASelectComponentSpecificStart = 0x1001
};

/*		Mode Flags:

	Warning: These should not conflict with the AESend mode flags in
	AppleEvents.h, because we may want to use them as OSA mode flags too.
*/
/*
		This mode flag may be passed to OSALoad, OSAStore or OSACompile to
	  	instruct the scripting component to not retain the "source" of an
	  	expression.  This will cause the OSAGetSource call to return the error
	  	errOSASourceNotAvailable if used.  However, some scripting components
	  	may not retain the source anyway.  This is mainly used when either space
	  	efficiency is desired, or a script is to be "locked" so that its
	  	implementation may not be viewed.
	*/
enum {
	kOSAModePreventGetSource	= 0x00000001
};

/*
		These mode flags may be passed to OSACompile, OSAExecute, OSALoadExecute
	  	OSACompileExecute, OSADoScript, OSAExecuteEvent, or OSADoEvent to
	  	indicate whether or not the script may interact with the user, switch
	  	layer or reconnect if necessary.  Any AppleEvents will be sent with the
	  	corresponding AESend mode supplied.
	*/
enum {
	kOSAModeNeverInteract		= kAENeverInteract,
	kOSAModeCanInteract			= kAECanInteract,
	kOSAModeAlwaysInteract		= kAEAlwaysInteract,
	kOSAModeDontReconnect		= kAEDontReconnect
};

/*
		This mode flag may be passed to OSACompile, OSAExecute, OSALoadExecute
	  	OSACompileExecute, OSADoScript, OSAExecuteEvent, or OSADoEvent to
	  	indicate whether or not AppleEvents should be sent with the
	  	kAECanSwitchLayer mode flag sent or not. NOTE: This flag is exactly the
	  	opposite sense of the AppleEvent flag kAECanSwitchLayer.  This is to
	  	provide a more convenient default, i.e. not supplying any mode
	  	(kOSAModeNull) means to send events with kAECanSwitchLayer.  Supplying
	  	the kOSAModeCantSwitchLayer mode flag will cause AESend to be called
	  	without kAECanSwitchLayer.
	*/
enum {
	kOSAModeCantSwitchLayer		= 0x00000040
};

/*
		This mode flag may be passed to OSACompile, OSAExecute, OSALoadExecute
	  	OSACompileExecute, OSADoScript, OSAExecuteEvent, or OSADoEvent to
	  	indicate whether or not AppleEvents should be sent with the kAEDontRecord
	  	mode flag sent or not. NOTE: This flag is exactly the opposite sense of
	  	the AppleEvent flag kAEDontRecord.  This is to provide a more convenient
	  	default, i.e. not supplying any mode (kOSAModeNull) means to send events
	  	with kAEDontRecord.  Supplying the kOSAModeDoRecord mode flag will 
	  	cause AESend to be called without kAEDontRecord.
	*/
enum {
	kOSAModeDoRecord			= 0x00001000
};

/*
		This is a mode flag for OSACompile that indicates that a context should
	  	be created as the result of compilation. All handler definitions are
	  	inserted into the new context, and variables are initialized by
	  	evaluating their initial values in a null context (i.e. they must be
	  	constant expressions).
	*/
enum {
	kOSAModeCompileIntoContext	= 0x00000002
};

/*
		This is a mode flag for OSACompile that indicates that the previous
	  	script ID (input to OSACompile) should be augmented with any new
	  	definitions in the sourceData rather than replaced with a new script.
	  	This means that the previous script ID must designate a context.
	  	The presence of this flag causes the kOSAModeCompileIntoContext flag
	  	to be implicitly used, causing any new definitions to be initialized
	  	in a null context.
	*/
enum {
	kOSAModeAugmentContext		= 0x00000004
};

/*
		This mode flag may be passed to OSADisplay or OSADoScript to indicate
	  	that output only need be human-readable, not re-compilable by OSACompile.
	  	If used, output may be arbitrarily "beautified", e.g. quotes may be left
	  	off of string values, long lists may have elipses, etc.
	*/
enum {
	kOSAModeDisplayForHumans	= 0x00000008
};

/*
		This mode flag may be passed to OSAStore in the case where the scriptID
	  	is a context.  This causes the context to be saved, but not the context's
	  	parent context.  When the stored context is loaded back in, the parent
	  	will be kOSANullScript.
	*/
enum {
	kOSAModeDontStoreParent		= 0x00010000
};

/*
		This mode flag may be passed to OSAExecuteEvent to cause the event to
	  	be dispatched to the direct object of the event. The direct object (or
	  	subject attribute if the direct object is a non-object specifier) will
	  	be resolved, and the resulting script object will be the recipient of
	  	the message. The context argument to OSAExecuteEvent will serve as the
	  	root of the lookup/resolution process.
	*/
enum {
	kOSAModeDispatchToDirectObject = 0x00020000
};

/*
		This mode flag may be passed to OSAExecuteEvent to indicate that
	  	components do not have to get the data of object specifier arguments.
	*/
enum {
	kOSAModeDontGetDataForArguments = 0x00040000
};

/**************************************************************************
	OSA Basic Scripting Interface
**************************************************************************
	Scripting components must at least support the Basic Scripting interface.
**************************************************************************/
/*		Loading and Storing Scripts:

	These routines allow scripts to be loaded and stored in their internal
	(possibly compiled, non-text) representation.
*/
/* Resource type for scripts */
enum {
	kOSAScriptResourceType		= kOSAGenericScriptingComponentSubtype
};

/*
		Default type given to OSAStore which creates "generic" loadable script
	  	data descriptors.
	*/
enum {
	typeOSAGenericStorage		= kOSAScriptResourceType
};

extern pascal OSAError OSALoad(ComponentInstance scriptingComponent, const AEDesc *scriptData, long modeFlags, OSAID *resultingScriptID)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0001, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectLoad, 12);
	
		Errors:
			badComponentInstance		invalid scripting component instance
			errOSASystemError
			errOSABadStorageType:		scriptData not for this scripting component
			errOSACorruptData:			data seems to be corrupt
			errOSADataFormatObsolete	script data format is no longer supported
			errOSADataFormatTooNew		script data format is from a newer version
		
		ModeFlags:
			kOSAModePreventGetSource
	*/
extern pascal OSAError OSAStore(ComponentInstance scriptingComponent, OSAID scriptID, DescType desiredType, long modeFlags, AEDesc *resultingScriptData)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0002, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectStore, 16);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errOSABadStorageType:	desiredType not for this scripting component
		
		ModeFlags:
			kOSAModePreventGetSource
			kOSAModeDontStoreParent
	*/
/* Executing Scripts: */
extern pascal OSAError OSAExecute(ComponentInstance scriptingComponent, OSAID compiledScriptID, OSAID contextID, long modeFlags, OSAID *resultingScriptValueID)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0003, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectExecute, 16);
		This call runs a script.  The contextID represents the environment
		with which global variables in the script are resolved.  The constant
		kOSANullScript may be used for the contextID if the application wishes
		to not deal with context directly (a default one is associated with each
		scripting component instance).  The resultingScriptValueID is the 
		result of evaluation, and contains a value which may be displayed using
		the OSAGetSource call.  The modeFlags convey scripting component
		specific information.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errOSAScriptError:		the executing script got an error
	
		ModeFlags:
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
	*/
/* Displaying results: */
extern pascal OSAError OSADisplay(ComponentInstance scriptingComponent, OSAID scriptValueID, DescType desiredType, long modeFlags, AEDesc *resultingText)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0004, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectDisplay, 16);
		This call is used to convert results (script value IDs) into displayable
		text. The desiredType should be at least typeChar, and modeFlags are
		scripting system specific flags to control the formatting of the
		resulting text. This call differs from OSAGetSource in that (1) it
		always produces at least typeChar, (2) is only works on script values,
		(3) it may display it's output in non-compilable form (e.g. without
		string quotes, elipses inserted in long and/or circular lists, etc.) and
		(4) it is required by the basic scripting interface.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errAECoercionFail:		desiredType not supported by scripting component
	
		ModeFlags:
			kOSAModeDisplayForHumans
	*/
/* Getting Error Information: */
extern pascal OSAError OSAScriptError(ComponentInstance scriptingComponent, OSType selector, DescType desiredType, AEDesc *resultingErrorDescription)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0005, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectScriptError, 12);
		Whenever script execution returns errOSAExecutionError, this routine
		may be used to get information about that error.  The selector describes
		the type of information desired about the error (various selectors are
		listed below).  The desiredType indicates the data type of the result
		desired for that selector.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSABadSelector:		selector not supported by scripting component
			errAECoercionFail:		desiredType not supported by scripting component
	*/
/* OSAScriptError selectors: */
/*
		This selector is used to determine the error number of a script error.
		These error numbers may be either system error numbers, or error numbers
		that are scripting component specific.
		Required desiredTypes:	
	  		typeShortInteger
	*/

enum {
	kOSAErrorNumber				= keyErrorNumber
};

/*
		This selector is used to determine the full error message associated
		with the error number.  It should include the name of the application
		which caused the error, as well as the specific error that occurred.
		This selector is sufficient for simple error reporting (but see
		kOSAErrorBriefMessage, below).
		Required desiredTypes:
			typeChar					error message string
	*/
enum {
	kOSAErrorMessage			= keyErrorString
};

/*
		This selector is used to determine a brief error message associated with
		the error number.  This message and should not mention the name of the
		application which caused the error, any partial results or offending
		object (see kOSAErrorApp, kOSAErrorPartialResult and
		kOSAErrorOffendingObject, below).
		Required desiredTypes:
	  		typeChar					brief error message string
	*/
/*  0x65727262  */
enum {
	kOSAErrorBriefMessage		= 'errb'
};

/*
		This selector is used to determine which application actually got the
		error (if it was the result of an AESend), or the current application
		if ....
		Required desiredTypes:
	  		typeProcessSerialNumber		PSN of the errant application
	  		typeChar					name of the errant application
	*/
/*  0x65726170  */
enum {
	kOSAErrorApp				= 'erap'
};

/*
		This selector is used to determine any partial result returned by an 
		operation. If an AESend call failed, but a partial result was returned,
		then the partial result may be returned as an AEDesc.
		Required desiredTypes:
	  		typeBest					AEDesc of any partial result
	*/
/*  0x70746c72   */
enum {
	kOSAErrorPartialResult		= 'ptlr'
};

/*
		This selector is used to determine any object which caused the error
		that may have been indicated by an application.  The result is an 
		AEDesc.
		Required desiredTypes:
	  		typeBest					AEDesc of any offending object
	*/
/*  0x65726f62   */
enum {
	kOSAErrorOffendingObject	= 'erob'
};

/*
		This selector is used to determine the type expected by a coercion 
		operation if a type error occurred.
	*/
/*  0x65727274   */
enum {
	kOSAErrorExpectedType		= 'errt'
};

/*
		This selector is used to determine the source text range (start and 
		end positions) of where the error occurred.
		Required desiredTypes:
	  		typeOSAErrorRange
	*/
/*  0x65726e67  */
enum {
	kOSAErrorRange				= 'erng'
};

/*
		An AERecord type containing keyOSASourceStart and keyOSASourceEnd fields
	    of type short.
	*/
/*  0x65726e67   */
enum {
	typeOSAErrorRange			= 'erng'
};

/* Field of a typeOSAErrorRange record of typeShortInteger */
/*  0x73726373    */
enum {
	keyOSASourceStart			= 'srcs'
};

/* Field of a typeOSAErrorRange record of typeShortInteger */
/*  0x73726365   */
enum {
	keyOSASourceEnd				= 'srce'
};

/* Disposing Script IDs: */
extern pascal OSAError OSADispose(ComponentInstance scriptingComponent, OSAID scriptID)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0006, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectDispose, 4);
		Disposes a script or context.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
	*/
/* Getting and Setting Script Information: */
extern pascal OSAError OSASetScriptInfo(ComponentInstance scriptingComponent, OSAID scriptID, OSType selector, long value)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0007, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectSetScriptInfo, 12);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errOSABadSelector:		selector not supported by scripting component
									or selector not for this scriptID
	*/
extern pascal OSAError OSAGetScriptInfo(ComponentInstance scriptingComponent, OSAID scriptID, OSType selector, long *result)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0008, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetScriptInfo, 12);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errOSABadSelector:		selector not supported by scripting component
									or selector not for this scriptID
	*/
/* Manipulating the ActiveProc:

	Scripting systems will supply default values for these procedures if they
	are not set by the client:
*/
typedef pascal OSErr (*OSAActiveProcPtr)(long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr OSAActiveUPP;
#else
typedef OSAActiveProcPtr OSAActiveUPP;
#endif

enum {
	uppOSAActiveProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewOSAActiveProc(userRoutine)		\
		(OSAActiveUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppOSAActiveProcInfo, GetCurrentArchitecture())
#else
#define NewOSAActiveProc(userRoutine)		\
		((OSAActiveUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallOSAActiveProc(userRoutine, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppOSAActiveProcInfo, (refCon))
#else
#define CallOSAActiveProc(userRoutine, refCon)		\
		(*(userRoutine))((refCon))
#endif

extern pascal OSAError OSASetActiveProc(ComponentInstance scriptingComponent, OSAActiveUPP activeProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0009, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectSetActiveProc, 8);
		If activeProc is nil, the default activeProc is used.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSAGetActiveProc(ComponentInstance scriptingComponent, OSAActiveUPP *activeProc, long *refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x000A, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetActiveProc, 8);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
/**************************************************************************
	OSA Optional Compiling Interface
**************************************************************************
	Scripting components that support the Compiling interface have the 
	kOSASupportsCompiling bit set in it's ComponentDescription.
**************************************************************************/
extern pascal OSAError OSAScriptingComponentName(ComponentInstance scriptingComponent, AEDesc *resultingScriptingComponentName)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0102, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectScriptingComponentName, 4);
		Given a scripting component, this routine returns the name of that
		scripting component in a type that is coercable to text (typeChar).
		The generic scripting component returns the name of the default
		scripting component.  This name should be sufficient to convey to the
		user the kind of script (syntax) he is expected to write.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSACompile(ComponentInstance scriptingComponent, const AEDesc *sourceData, long modeFlags, OSAID *previousAndResultingScriptID)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0103, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectCompile, 12);
		Coerces input desc (possibly text) into a script's internal format.
		Once compiled, the script is ready to run.  The modeFlags convey
		scripting component specific information.  The previous script ID
		(result parameter) is made to refer to the newly compiled script,
		unless it was originally kOSANullScript.  In this case a new script
		ID is created and used.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errAECoercionFail:		sourceData is not compilable
			errOSAScriptError:		sourceData was a bad script (syntax error)
			errOSAInvalidID:		previousAndResultingCompiledScriptID was not
									valid on input
	
		ModeFlags:
			kOSAModePreventGetSource
			kOSAModeCompileIntoContext
			kOSAModeAugmentContext
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
	*/
extern pascal OSAError OSACopyID(ComponentInstance scriptingComponent, OSAID fromID, OSAID *toID)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0104, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectCopyID, 8);
		If toID is a reference to kOSANullScript then it is updated to have a
		new scriptID value.  This call can be used to perform undo or revert
		operations on scripts. 
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
	*/
/**************************************************************************
	OSA Optional GetSource Interface
**************************************************************************
	Scripting components that support the GetSource interface have the 
	kOSASupportsGetSource bit set in it's ComponentDescription.
**************************************************************************/
extern pascal OSAError OSAGetSource(ComponentInstance scriptingComponent, OSAID scriptID, DescType desiredType, AEDesc *resultingSourceData)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0201, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetSource, 12);
		This routine causes a compiled script to be output in a form (possibly
		text) such that it is suitable to be passed back to OSACompile.

		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errOSASourceNotAvailable	can't get source for this scriptID
	*/
/**************************************************************************
	OSA Optional AECoercion Interface
**************************************************************************
	Scripting components that support the AECoercion interface have the 
	kOSASupportsAECoercion bit set in it's ComponentDescription.
**************************************************************************/
extern pascal OSAError OSACoerceFromDesc(ComponentInstance scriptingComponent, const AEDesc *scriptData, long modeFlags, OSAID *resultingScriptID)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0301, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectCoerceFromDesc, 12);
		This routine causes script data to be coerced into a script value.
		If the scriptData is an AppleEvent, then the resultingScriptID is a
		compiled script ID (mode flags for OSACompile may be used in this case).
		Other scriptData descriptors create script value IDs.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	
		ModeFlags:
			kOSAModePreventGetSource
			kOSAModeCompileIntoContext
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
	*/
extern pascal OSAError OSACoerceToDesc(ComponentInstance scriptingComponent, OSAID scriptID, DescType desiredType, long modeFlags, AEDesc *result)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0302, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectCoerceToDesc, 16);
		This routine causes a script value to be coerced into any desired form.
		If the scriptID denotes a compiled script, then it may be coerced to 
		typeAppleEvent.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
	*/
/**************************************************************************
	OSA Optional AESending Interface
**************************************************************************
	Scripting components that support the AESending interface have the 
	kOSASupportsAESending bit set in it's ComponentDescription.
**************************************************************************/
/*
	Scripting systems will supply default values for these procedures if they
	are not set by the client:
*/
extern pascal OSAError OSASetSendProc(ComponentInstance scriptingComponent, OSASendUPP sendProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0401, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectSetSendProc, 8);
		If sendProc is nil, the default sendProc is used.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSAGetSendProc(ComponentInstance scriptingComponent, OSASendUPP *sendProc, long *refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0402, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetSendProc, 8);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSASetCreateProc(ComponentInstance scriptingComponent, OSACreateAppleEventUPP createProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0403, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectSetCreateProc, 8);
		If createProc is nil, the default createProc is used.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSAGetCreateProc(ComponentInstance scriptingComponent, OSACreateAppleEventUPP *createProc, long *refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0404, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetCreateProc, 8);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSASetDefaultTarget(ComponentInstance scriptingComponent, const AEAddressDesc *target)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0405, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectSetDefaultTarget, 4);
		This routine sets the default target application for AE sending.
		It also establishes the default target from which terminologies come.
		It is effectively like having an AppleScript "tell" statement around
		the entire program.  If this routine is not called, or if the target 
		is a null AEDesc, then the current application is the default target.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
/**************************************************************************
	OSA Optional Recording Interface
**************************************************************************
	Scripting components that support the Recording interface have the 
	kOSASupportsRecording bit set in it's ComponentDescription.
**************************************************************************/
extern pascal OSAError OSAStartRecording(ComponentInstance scriptingComponent, OSAID *compiledScriptToModifyID)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0501, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectStartRecording, 4);
		Starts recording.  If compiledScriptToModifyID is kOSANullScript, a
		new script ID is created and returned.  If the current application has
		a handler for the kOSARecordedText event, then kOSARecordedText events
		are sent to the application containing the text of each AppleEvent 
		recorded.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errOSARecordingIsAlreadyOn
	*/
extern pascal OSAError OSAStopRecording(ComponentInstance scriptingComponent, OSAID compiledScriptID)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0502, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectStopRecording, 4);
		If compiledScriptID is not being recorded into or recording is not
		currently on, no error is returned.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
	*/
/**************************************************************************
	OSA Optional Convenience Interface
**************************************************************************
	Scripting components that support the Convenience interface have the 
	kOSASupportsConvenience bit set in it's ComponentDescription.
**************************************************************************/
extern pascal OSAError OSALoadExecute(ComponentInstance scriptingComponent, const AEDesc *scriptData, OSAID contextID, long modeFlags, OSAID *resultingScriptValueID)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0601, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectLoadExecute, 16);
		This routine is effectively equivalent to calling OSALoad followed by
		OSAExecute.  After execution, the compiled source is disposed.  Only the
		resulting value ID is retained.
	
		Errors:
			badComponentInstance		invalid scripting component instance
			errOSASystemError
			errOSABadStorageType:		scriptData not for this scripting component
			errOSACorruptData:			data seems to be corrupt
			errOSADataFormatObsolete	script data format is no longer supported
			errOSADataFormatTooNew		script data format is from a newer version
			errOSAInvalidID
			errOSAScriptError:			the executing script got an error
	
		ModeFlags:
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
	*/
extern pascal OSAError OSACompileExecute(ComponentInstance scriptingComponent, const AEDesc *sourceData, OSAID contextID, long modeFlags, OSAID *resultingScriptValueID)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0602, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectCompileExecute, 16);
		This routine is effectively equivalent to calling OSACompile followed by
		OSAExecute.  After execution, the compiled source is disposed.  Only the
		resulting value ID is retained.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errAECoercionFail:		sourceData is not compilable
			errOSAScriptError:		sourceData was a bad script (syntax error)
			errOSAInvalidID:		previousAndResultingCompiledScriptID was not
									valid on input
			errOSAScriptError:		the executing script got an error
	
		ModeFlags:
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
	*/
extern pascal OSAError OSADoScript(ComponentInstance scriptingComponent, const AEDesc *sourceData, OSAID contextID, DescType desiredType, long modeFlags, AEDesc *resultingText)
 FIVEWORDINLINE(0x2F3C, 0x14, 0x0603, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectDoScript, 20);
		This routine is effectively equivalent to calling OSACompile followed by
		OSAExecute and then OSADisplay.  After execution, the compiled source
		and the resulting value are is disposed.  Only the resultingText
		descriptor is retained.  If a script error occur during processing, the 
		resultingText gets the error message of the error, and errOSAScriptError
		is returned.  OSAScriptError may still be used to extract more 
		information about the particular error.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errAECoercionFail:		sourceData is not compilable or 
									desiredType not supported by scripting component
			errOSAScriptError:		sourceData was a bad script (syntax error)
			errOSAInvalidID:		previousAndResultingCompiledScriptID was not
									valid on input
			errOSAScriptError:		the executing script got an error
	
		ModeFlags:
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
			kOSAModeDisplayForHumans
	*/
/**************************************************************************
	OSA Optional Dialects Interface
**************************************************************************
	Scripting components that support the Dialects interface have the 
	kOSASupportsDialects bit set in it's ComponentDescription.
**************************************************************************/
/*
	These calls allows an scripting component that supports different dialects
	to dynamically switch between those dialects.  Although this interface is
	specified, the particular dialect codes are scripting component dependent.
*/
extern pascal OSAError OSASetCurrentDialect(ComponentInstance scriptingComponent, short dialectCode)
 FIVEWORDINLINE(0x2F3C, 0x2, 0x0701, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectSetCurrentDialect, 2);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSANoSuchDialect:	invalid dialectCode
	*/
extern pascal OSAError OSAGetCurrentDialect(ComponentInstance scriptingComponent, short *resultingDialectCode)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0702, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetCurrentDialect, 4);
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSAAvailableDialects(ComponentInstance scriptingComponent, AEDesc *resultingDialectInfoList)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0703, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectAvailableDialects, 4);
		This call return an AEList containing information about each of the
		currently available dialects of a scripting component.  Each item
		is an AERecord of typeOSADialectInfo that contains at least the fields
		keyOSADialectName, keyOSADialectCode, KeyOSADialectLangCode and 
		keyOSADialectScriptCode.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSAGetDialectInfo(ComponentInstance scriptingComponent, short dialectCode, OSType selector, AEDesc *resultingDialectInfo)
 FIVEWORDINLINE(0x2F3C, 0xA, 0x0704, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetDialectInfo, 10);
		This call gives information about the specified dialect of a scripting
		component. It returns an AEDesc whose type depends on the selector 
		specified. Available selectors are the same as the field keys for a
		dialect info record. The type of AEDesc returned is the same as the 
		type of the field that has same key as the selector.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
		 	errOSABadSelector
			errOSANoSuchDialect:	invalid dialectCode
	*/
extern pascal OSAError OSAAvailableDialectCodeList(ComponentInstance scriptingComponent, AEDesc *resultingDialectCodeList)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0705, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectAvailableDialectCodeList, 4);
		This is alternative to OSAGetAvailableDialectCodeList. Use this call
		and  OSAGetDialectInfo to get information on dialects.
		This call return an AEList containing dialect code for each of the
		currently available dialects of a scripting component. Each dialect
		code is a short integer of type typeShortInteger.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError

		Type of a dialect info record containing at least keyOSADialectName
		and keyOSADialectCode fields.

		keys for dialect info record, also used as selectors to OSAGetDialectInfo.

		Field of a typeOSADialectInfo record of typeChar.
		Field of a typeOSADialectInfo record of typeShortInteger.
		Field of a typeOSADialectInfo record of typeShortInteger.
		Field of a typeOSADialectInfo record of typeShortInteger.
	*/
/**************************************************************************
	OSA Optional Event Handling Interface
**************************************************************************
	Scripting components that support the Event Handling interface have the 
	kOSASupportsEventHandling bit set in it's ComponentDescription.
**************************************************************************/
extern pascal OSAError OSASetResumeDispatchProc(ComponentInstance scriptingComponent, AEEventHandlerUPP resumeDispatchProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0801, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectSetResumeDispatchProc, 8);
		This function is used to set the ResumeDispatchProc that will be used
		by OSAExecuteEvent and OSADoEvent if either no event handler can be
		found in the context, or the context event hander "continues" control
		onward. The two constants kOSAUseStandardDispatch and kOSANoDispatch
		may also be passed to this routine indicating that the handler registered
		in the application with AEInstallEventHandler should be used, or no
		dispatch should occur, respectively.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/

enum {
	kOSAUseStandardDispatch		= kAEUseStandardDispatch
};

/*
		Special ResumeDispatchProc constant which may be passed to 
		OSASetResumeDispatchProc indicating that the handler registered
		in the application with AEInstallEventHandler should be used.
		
		NOTE:	Had to remove the cast (AEEventHandlerUPP).  The C compiler
				doesn't allow pointer types to be assigned to an enum.  All
				constants must be assigned as enums to translate properly to
				Pascal.
	*/
enum {
	kOSANoDispatch				= kAENoDispatch
};

/*
		Special ResumeDispatchProc constant which may be passed to 
		OSASetResumeDispatchProc indicating that no dispatch should occur.
		
		NOTE:	Had to remove the cast (AEEventHandlerUPP).  The C compiler
				doesn't allow pointer types to be assigned to an enum.  All
				constants must be assigned as enums to translate properly to
				Pascal.
	*/
enum {
	kOSADontUsePhac				= 0x0001
};

/*
		Special refCon constant that may be given to OSASetResumeDispatchProc
		only when kOSAUseStandardDispatch is used as the ResumeDispatchProc.
		This causes the standard dispatch to be performed, except the phac
		handler is not called.  This is useful during tinkerability, when
		the phac handler is used to lookup a context associated with an event's 
		direct parameter, and call OSAExecuteEvent or OSADoEvent.  Failure to
		bypass the phac handler would result in an infinite loop.
	*/
extern pascal OSAError OSAGetResumeDispatchProc(ComponentInstance scriptingComponent, AEEventHandlerUPP *resumeDispatchProc, long *refCon)
 FIVEWORDINLINE(0x2F3C, 0x8, 0x0802, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectGetResumeDispatchProc, 8);
		Returns the registered ResumeDispatchProc.  If no ResumeDispatchProc has
		been registered, then kOSAUseStandardDispatch (the default) is returned.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
	*/
extern pascal OSAError OSAExecuteEvent(ComponentInstance scriptingComponent, const AppleEvent *theAppleEvent, OSAID contextID, long modeFlags, OSAID *resultingScriptValueID)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0803, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectExecuteEvent, 16);
		This call is similar to OSAExecute except the initial command to
		execute comes in the form of an AppleEvent.  If the contextID
		defines any event handlers for that event, they are used to process
		the event.  If no event handler can be found in the context
		errAEEventNotHandled is returned.  If an event handler is found and
		the hander "continues" control onward, the ResumeDispatchProc
		(registered with OSASetResumeDispatchProc, above) is called given the
		AppleEvent.  The result is returned as a scriptValueID.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errOSAScriptError:		the executing script got an error
			errAEEventNotHandled:	no handler for event in contextID
	
		ModeFlags:
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
	*/
extern pascal OSAError OSADoEvent(ComponentInstance scriptingComponent, const AppleEvent *theAppleEvent, OSAID contextID, long modeFlags, AppleEvent *reply)
 FIVEWORDINLINE(0x2F3C, 0x10, 0x0804, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectDoEvent, 16);
		This call is similar to OSADoScript except the initial command to
		execute comes in the form of an AppleEvent, and the result is an 
		AppleEvent reply record.  If the contextID defines any event handlers
		for that event, they are used to process the event.  If no event handler
		can be found in the context errAEEventNotHandled is returned.  If an
		event handler is found and the hander "continues" control onward, the
		ResumeDispatchProc (registered with OSASetResumeDispatchProc, above) is
		called given the AppleEvent.  The result is returned in the form of an
		AppleEvent reply descriptor. If at any time the script gets an error, or
		if the ResumeDispatchProc returns a reply event indicating an error,
		then the OSADoEvent call itself returns an error reply (i.e. OSADoEvent
		should never return errOSAScriptError).  Any error result returned by
		the ResumeDispatchProc will be returned by OSADoEvent.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errAEEventNotHandled:	no handler for event in contextID
	
		ModeFlags:
			kOSAModeNeverInteract
			kOSAModeCanInteract
			kOSAModeAlwaysInteract
			kOSAModeCantSwitchLayer
			kOSAModeDontReconnect
			kOSAModeDoRecord
	*/
extern pascal OSAError OSAMakeContext(ComponentInstance scriptingComponent, const AEDesc *contextName, OSAID parentContext, OSAID *resultingContextID)
 FIVEWORDINLINE(0x2F3C, 0xC, 0x0805, 0x7000, 0xA82A);
/*
		OSAComponentFunctionInline(kOSASelectMakeContext, 12);
		Makes a new empty context which may be passed to OSAExecute or 
		OSAExecuteEvent.  If contextName is typeNull, an unnamed context is
		created. If parentContext is kOSANullScript then the resulting context
		does not inherit bindings from any other context.
	
		Errors:
			badComponentInstance	invalid scripting component instance
			errOSASystemError
			errOSAInvalidID
			errAECoercionFail:		contextName is invalid
	*/

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __OSA__ */
