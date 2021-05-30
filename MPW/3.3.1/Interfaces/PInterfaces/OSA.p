{
////////////////////////////////////////////////////////////////////////////////
// OPEN SCRIPTING ARCHITECTURE: Client Interface
////////////////////////////////////////////////////////////////////////////////
// Copyright © 1992 Apple Computer, Inc. All rights reserved.
// Authors: Jens Alfke, William Cook, Donn Denman, and Warren Harris
////////////////////////////////////////////////////////////////////////////////
// This interface defines what it means to be a "scripting component."
// Scripting components allow "scripts" to be loaded and executed.  This
// interface does not define the way in which a particular scripting
// component's scripts are editing and debugged.
////////////////////////////////////////////////////////////////////////////////
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT OSA;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingOSA}
{$SETC UsingOSA := 1}

{$I+}
{$SETC OSAIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingAppleEvents}
{$I $$Shell(PInterfaces)AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED UsingAEObjects}
{$I $$Shell(PInterfaces)AEObjects.p}
{$ENDC}
{$IFC UNDEFINED UsingComponents}
{$I $$Shell(PInterfaces)Components.p}
{$ENDC}
{$SETC UsingIncludes := OSAIncludes}

{ Types and Constants }
CONST
	kOSAComponentType							= 'osa ';
	kOSAGenericScriptingComponentSubtype		= 'scpt';

	kOSAFileType								= 'osas';
	{ Type of script document files. }

TYPE
	OSAID							= LONGINT;
	OSAError						= ComponentResult;

CONST
	kOSANullScript					= 0;
	kOSANullMode					= 0;
	kOSAModeNull					= 0;
	
	kOSASuite						= 'ascr';
	kOSARecordedText				= 'recd';
	
	kOSAScriptResourceType			= kOSAGenericScriptingComponentSubtype;
	typeOSAGenericStorage			= kOSAScriptResourceType;

{ Error Codes }
	
	{ API Errors }
	errOSASystemError				= -1750;
	errOSAInvalidID					= -1751;
	errOSABadStorageType			= -1752;
	errOSAScriptError				= -1753;
	errOSABadSelector				= -1754;
	errOSASourceNotAvailable		= -1756;
	errOSANoSuchDialect				= -1757;
	errOSADataFormatObsolete		= -1758;
	errOSADataFormatTooNew			= -1759;
	errOSACorruptData				= errAECorruptData;
	errOSARecordingIsAlreadyOn		= errAERecordingIsAlreadyOn;

	{ Dynamic errors }
	errOSACantCoerce				= errAECoercionFail;
	errOSACantAccess				= errAENoSuchObject;
	errOSACantAssign				= -10006;
	errOSAGeneralError				= -2700;
	errOSADivideByZero				= -2701;
	errOSANumericOverflow			= -2702;
	errOSACantLaunch				= -2703;
	errOSAAppNotHighLevelEventAware	= -2704;
	errOSACorruptTerminology		= -2705;
	errOSAStackOverflow				= -2706;
	errOSAInternalTableOverflow		= -2707;
	errOSADataBlockTooLarge			= -2708;
	errOSACantGetTerminology		= -2709;
	errOSACantCreate				= -2710;
	
	{ Component-specific dynamic script errors: -2720 thru -2739 } 

	{ Static errors }
	errOSATypeError					= errAEWrongDataType;
	errOSAMessageNotUnderstood		= errAEEventNotHandled;
	errOSAUndefinedHandler			= errAEHandlerNotFound;
	errOSAIllegalAccess				= errAEAccessorNotFound;
	errOSAIllegalIndex				= errAEIllegalIndex;
	errOSAIllegalRange				= errAEImpossibleRange;
	errOSAIllegalAssign				= -10003;
	errOSASyntaxError				= -2740;
	errOSASyntaxTypeError			= -2741;
	errOSATokenTooLong				= -2742;
	errOSAMissingParameter			= errAEDescNotFound;
	errOSAParameterMismatch			= errAEWrongNumberArgs;
	errOSADuplicateParameter		= -2750;
	errOSADuplicateProperty			= -2751;
	errOSADuplicateHandler			= -2752;
	errOSAUndefinedVariable			= -2753;
	errOSAInconsistentDeclarations	= -2754;
	errOSAControlFlowError			= -2755;

	{ Component-specific static script errors: -2760 thru -2779 }

	{ Dialect-specific script errors: -2780 thru -2799 }

{
////////////////////////////////////////////////////////////////////////////////
// OSA Interface Descriptions
////////////////////////////////////////////////////////////////////////////////
// The OSA Interface is broken down into a required interface, and several
// optional interfaces to support additional functionality.  A given scripting
// component may choose to support only some of the optional interfaces in
// addition to the basic interface.  The OSA Component Flags may be used to 
// query the Component Manager to find a scripting component with a particular
// capability, or determine if a particular scripting component supports a 
// particular capability.
////////////////////////////////////////////////////////////////////////////////
}
	
	{ OSA Component Flags }
	kOSASupportsCompiling				= $0002;
	kOSASupportsGetSource				= $0004;
	kOSASupportsAECoercion				= $0008;
	kOSASupportsAESending				= $0010;
	kOSASupportsRecording				= $0020;
	kOSASupportsConvenience				= $0040;
	kOSASupportsDialects				= $0080;
	kOSASupportsEventHandling			= $0100;
	
	{ Component Selectors }
	{ Basic Scripting: }
	kOSASelectLoad						= $0001;
	kOSASelectStore						= $0002;
	kOSASelectExecute					= $0003;
	kOSASelectDisplay					= $0004;
	kOSASelectScriptError				= $0005;
	kOSASelectDispose					= $0006;
	kOSASelectSetScriptInfo				= $0007;
	kOSASelectGetScriptInfo				= $0008;
	kOSASelectSetActiveProc				= $0009;
	kOSASelectGetActiveProc				= $000A;
	{ Compiling: }
	kOSASelectScriptingComponentName	= $0102;
	kOSASelectCompile					= $0103;
	kOSASelectCopyID					= $0104;
	{ GetSource: }
	kOSASelectGetSource					= $0201;
	{ AECoercion: }
	kOSASelectCoerceFromDesc			= $0301;
	kOSASelectCoerceToDesc				= $0302;
	{ AESending: }
	kOSASelectSetSendProc				= $0401;
	kOSASelectGetSendProc				= $0402;
	kOSASelectSetCreateProc				= $0403;
	kOSASelectGetCreateProc				= $0404;
	kOSASelectSetDefaultTarget			= $0405;
	{ Recording: }
	kOSASelectStartRecording			= $0501;
	kOSASelectStopRecording				= $0502;
	{ Convenience: }
	kOSASelectLoadExecute				= $0601;
	kOSASelectCompileExecute			= $0602;
	kOSASelectDoScript					= $0603;
	{ Dialects: }
	kOSASelectSetCurrentDialect			= $0701;
	kOSASelectGetCurrentDialect			= $0702;
	kOSASelectAvailableDialects			= $0703;
	kOSASelectGetDialectInfo			= $0704;
	kOSASelectAvailableDialectCodeList	= $0705;
	{ Event Handling: }
	kOSASelectSetResumeDispatchProc		= $0801;
	kOSASelectGetResumeDispatchProc		= $0802;
	kOSASelectExecuteEvent				= $0803;
	kOSASelectDoEvent					= $0804;
	kOSASelectMakeContext				= $0805;

	kOSASelectComponentSpecificStart	= $1001;
	{ scripting component specific selectors are added beginning with this 
	  value }
	
	{ Mode Flags }
	kOSAModePreventGetSource			= $00000001;
	kOSAModeNeverInteract				= kAENeverInteract;
	kOSAModeCanInteract					= kAECanInteract;
	kOSAModeAlwaysInteract				= kAEAlwaysInteract;
	kOSAModeDontReconnect				= kAEDontReconnect;
	kOSAModeCantSwitchLayer				= $00000040;
	kOSAModeDoRecord					= $00001000;
	kOSAModeCompileIntoContext			= $00000002;
	kOSAModeAugmentContext				= $00000004;
	kOSAModeDisplayForHumans			= $00000008;
	kOSAModeDontStoreParent				= $00010000;
	kOSAModeDispatchToDirectObject		= $00020000;
	kOSAModeDontGetDataForArguments		= $00040000;
	
{
////////////////////////////////////////////////////////////////////////////////
// OSA Basic Scripting Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components must at least support the Basic Scripting interface.
////////////////////////////////////////////////////////////////////////////////
}

{ Loading and Storing Scripts }

FUNCTION
OSALoad(scriptingComponent		: ComponentInstance;
		scriptData				: AEDesc;
		modeFlags				: LONGINT;
		VAR resultingScriptID	: OSAID)
	: OSAError;
    INLINE $2F3C, $000C, $0001, $7000, $A82A;

FUNCTION
OSAStore(scriptingComponent			: ComponentInstance; 
		 scriptID					: OSAID; 
		 desiredType				: DescType;
		 modeFlags					: LONGINT;
		 VAR resultingScriptData	: AEDesc)
	: OSAError;
    INLINE $2F3C, $0010, $0002, $7000, $A82A;

{ Executing Scripts }

FUNCTION
OSAExecute(scriptingComponent			: ComponentInstance;
		   compiledScriptID				: OSAID;
		   contextID					: OSAID;
		   modeFlags					: LONGINT;
		   VAR resultingScriptValueID	: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $0003, $7000, $A82A;

{ Displaying Results }

FUNCTION
OSADisplay(scriptingComponent		: ComponentInstance;
		   scriptValueID			: OSAID;
		   desiredType				: DescType;
		   modeFlags				: LONGINT;
		   VAR resultingText		: AEDesc)
	: OSAError;
    INLINE $2F3C, $0010, $0004, $7000, $A82A;

{ Getting Error Information }

FUNCTION
OSAScriptError(scriptingComponent				: ComponentInstance;
			   selector							: OSType;
			   desiredType						: DescType;
			   VAR resultingErrorDescription	: AEDesc)
	: OSAError;
    INLINE $2F3C, $000C, $0005, $7000, $A82A;

CONST	{ OSAScriptError selectors: }
	kOSAErrorNumber				= keyErrorNumber;
	kOSAErrorMessage			= keyErrorString;
	kOSAErrorBriefMessage		= 'errb';
	kOSAErrorApp				= 'erap';
	kOSAErrorPartialResult		= 'ptlr';
	kOSAErrorOffendingObject	= 'erob';
	kOSAErrorExpectedType		= 'errt';
	kOSAErrorRange				= 'erng';

		{ text ranges: }
	typeOSAErrorRange			= 'erng';
	keyOSASourceStart			= 'srcs';
	keyOSASourceEnd				= 'srce';

{ Disposing Script IDs }

FUNCTION
OSADispose(scriptingComponent	: ComponentInstance;
		   scriptID				: OSAID)
	: OSAError;
    INLINE $2F3C, $0004, $0006, $7000, $A82A;

{ Getting and Setting Script Information }

FUNCTION
OSASetScriptInfo(scriptingComponent	: ComponentInstance;
				 scriptID			: OSAID;
				 selector			: OSType;
				 value				: LONGINT)
	: OSAError;
    INLINE $2F3C, $000C, $0007, $7000, $A82A;

FUNCTION
OSAGetScriptInfo(scriptingComponent	: ComponentInstance;
				 scriptID			: OSAID;
				 selector			: OSType;
				 VAR result			: LONGINT)
	: OSAError;
    INLINE $2F3C, $000C, $0008, $7000, $A82A;

CONST	{ selectors }
	kOSAScriptIsModified			= 'modi';
	kOSAScriptIsTypeCompiledScript	= 'cscr';
	kOSAScriptIsTypeScriptValue		= 'valu';
	kOSAScriptIsTypeScriptContext	= 'cntx';
	kOSAScriptBestType				= 'best';
	kOSACanGetSource				= 'gsrc';

{ Manipulating the ActiveProc }

TYPE
	OSAActiveProcPtr = ProcPtr;

FUNCTION
OSASetActiveProc(scriptingComponent	: ComponentInstance;
				 activeProc			: OSAActiveProcPtr;
				 refCon				: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $0009, $7000, $A82A;

FUNCTION
OSAGetActiveProc(scriptingComponent	: ComponentInstance;
				 VAR activeProc		: OSAActiveProcPtr;
				 VAR refCon			: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $000A, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional Compiling Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the Compiling interface have the 
// kOSASupportsCompiling bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

FUNCTION
OSAScriptingComponentName(
			scriptingComponent					: ComponentInstance;
			VAR resultingScriptingComponentName	: AEDesc)
	: OSAError;
    INLINE $2F3C, $0004, $0102, $7000, $A82A;

FUNCTION
OSACompile(scriptingComponent				: ComponentInstance;
		   sourceData						: AEDesc;
		   modeFlags						: LONGINT;
		   VAR previousAndResultingScriptID	: OSAID)
	: OSAError;
    INLINE $2F3C, $000C, $0103, $7000, $A82A;

FUNCTION
OSACopyID(scriptingComponent	: ComponentInstance;
		  fromID				: OSAID;
		  VAR toID				: OSAID)
	: OSAError;
    INLINE $2F3C, $0008, $0104, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional GetSource Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the GetSource interface have the 
// kOSASupportsGetSource bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

FUNCTION
OSAGetSource(scriptingComponent			: ComponentInstance;
			 scriptID					: OSAID;
			 desiredType				: DescType;
			 VAR resultingSourceData	: AEDesc)
	: OSAError;
    INLINE $2F3C, $000C, $0201, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional AECoercion Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the AECoercion interface have the 
// kOSASupportsGetSource bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

FUNCTION
OSACoerceFromDesc(scriptingComponent			: ComponentInstance;
				  scriptData					: AEDesc;
				  modeFlags						: LONGINT;
				  VAR resultingScriptID			: OSAID)
	: OSAError;
    INLINE $2F3C, $000C, $0301, $7000, $A82A;

FUNCTION
OSACoerceToDesc(scriptingComponent	: ComponentInstance;
				scriptID			: OSAID;
				desiredType			: DescType;
				modeFlags			: LONGINT;
				VAR result			: AEDesc)
	: OSAError;
    INLINE $2F3C, $0010, $0302, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional AESending Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the AESending interface have the 
// kOSASupportsAESending bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

TYPE 
	AESendProcPtr = ProcPtr;
	AECreateAppleEventProcPtr = ProcPtr;
	
{  The first two proc pointers have the following interfaces
   taken from AppleEvents.p 
   
	FUNCTION MyAECreateProc(theAEEventClass: AEEventClass;
							theAEEventID: AEEventID;
							target: AEAddressDesc;
							returnID: INTEGER;
							transactionID: LONGINT;
							VAR result: AppleEvent): OSErr;
	
	FUNCTION MyAESendProc(theAppleEvent: AppleEvent;
						  VAR reply: AppleEvent;
						  sendMode: AESendMode;
						  sendPriority: AESendPriority;
						  timeOutInTicks: LONGINT;
						  idleProc: IdleProcPtr;
						  filterProc: EventFilterProcPtr): OSErr;

	FUNCTION MyActiveProc(): OSErr;

}

FUNCTION
OSASetSendProc(scriptingComponent	: ComponentInstance;
			   sendProc				: AESendProcPtr;
			   refCon				: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $0401, $7000, $A82A;

FUNCTION
OSAGetSendProc(scriptingComponent	: ComponentInstance;
			   VAR sendProc			: AESendProcPtr;
			   VAR refCon			: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $0402, $7000, $A82A;

FUNCTION
OSASetCreateProc(scriptingComponent	: ComponentInstance;
				 createProc			: AECreateAppleEventProcPtr;
				 refCon				: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $0403, $7000, $A82A;

FUNCTION
OSAGetCreateProc(scriptingComponent	: ComponentInstance;
				 VAR createProc		: AECreateAppleEventProcPtr;
				 VAR refCon			: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $0404, $7000, $A82A;

FUNCTION
OSASetDefaultTarget(scriptingComponent	: ComponentInstance;
				 	target				: AEAddressDesc)
	: OSAError;
    INLINE $2F3C, $0004, $0405, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional Recording Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the Recording interface have the 
// kOSASupportsRecording bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

FUNCTION
OSAStartRecording(scriptingComponent			: ComponentInstance;
				  VAR compiledScriptToModifyID	: OSAID)
	: OSAError;
    INLINE $2F3C, $0004, $0501, $7000, $A82A;

FUNCTION
OSAStopRecording(scriptingComponent		: ComponentInstance;
				 compiledScriptID		: OSAID)
	: OSAError;
    INLINE $2F3C, $0004, $0502, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional Convenience Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the Convenience interface have the 
// kOSASupportsConvenience bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

FUNCTION 
OSALoadExecute(scriptingComponent			: ComponentInstance;
			   scriptData					: AEDesc;
			   contextID					: OSAID;
			   modeFlags					: LONGINT;
			   VAR resultingScriptValueID	: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $0601, $7000, $A82A;

FUNCTION 
OSACompileExecute(scriptingComponent			: ComponentInstance;
				  sourceData					: AEDesc;
				  contextID						: OSAID;
				  modeFlags						: LONGINT;
				  VAR resultingScriptValueID	: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $0602, $7000, $A82A;

FUNCTION 
OSADoScript(scriptingComponent			: ComponentInstance;
			sourceData					: AEDesc;
			contextID					: OSAID;
			desiredType					: DescType;
			modeFlags					: LONGINT;
			VAR resultingText			: AEDesc)
	: OSAError;
    INLINE $2F3C, $0014, $0603, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional Dialects Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the Dialects interface have the 
// kOSASupportsDialects bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

FUNCTION 
OSASetCurrentDialect(scriptingComponent	: ComponentInstance;
					 dialectCode		: INTEGER)
	: OSAError;
    INLINE $2F3C, $0002, $0701, $7000, $A82A;

FUNCTION 
OSAGetCurrentDialect(scriptingComponent			: ComponentInstance;
					 VAR resultingDialectCode	: INTEGER)
	: OSAError;
    INLINE $2F3C, $0004, $0702, $7000, $A82A;

FUNCTION 
OSAAvailableDialects(scriptingComponent				: ComponentInstance;
					 VAR resultingDialectInfoList	: AEDesc)
	: OSAError;
    INLINE $2F3C, $0004, $0703, $7000, $A82A;
	{ *** This is obsolete. }
	{ *** Use OSAAvailableDialectCodeList and OSAGetDialectInfo. }

FUNCTION 
OSAGetDialectInfo(scriptingComponent			: ComponentInstance;
				  dialectCode					: INTEGER;
				  selector						: OSType;
				  VAR resultingDialectInfo		: AEDesc)
	: OSAError;
    INLINE $2F3C, $000A, $0704, $7000, $A82A;

FUNCTION 
OSAAvailableDialectCodeList(scriptingComponent			: ComponentInstance;
					 		resultingDialectCodeList	: AEDesc)
	: OSAError;
    INLINE $2F3C, $0004, $0705, $7000, $A82A;

CONST
	typeOSADialectInfo					= 'difo';
	keyOSADialectName					= 'dnam';
	keyOSADialectCode					= 'dcod';
	keyOSADialectLangCode				= 'dlcd';
	keyOSADialectScriptCode				= 'dscd';

{
////////////////////////////////////////////////////////////////////////////////
// OSA Optional Event Handling Interface
////////////////////////////////////////////////////////////////////////////////
// Scripting components that support the Event Handling interface have the 
// kOSASupportsEventHandling bit set in it's ComponentDescription.
////////////////////////////////////////////////////////////////////////////////
}

TYPE
	AEHandlerProcPtr			= EventHandlerProcPtr;

FUNCTION
OSASetResumeDispatchProc(scriptingComponent	: ComponentInstance;
						 resumeDispatchProc	: AEHandlerProcPtr;
						 refCon				: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $0801, $7000, $A82A;

CONST
	{ ResumeDispatchProc constants }
	kOSAUseStandardDispatch		= kAEUseStandardDispatch;
	kOSANoDispatch				= kAENoDispatch;
	{ OSASetResumeDispatchProc refCon constants }
	kOSADontUsePhac				= $0001;

FUNCTION
OSAGetResumeDispatchProc(scriptingComponent		: ComponentInstance;
						 VAR resumeDispatchProc	: AEHandlerProcPtr;
						 VAR refCon				: LONGINT)
	: OSAError;
    INLINE $2F3C, $0008, $0802, $7000, $A82A;

FUNCTION
OSAExecuteEvent(scriptingComponent			: ComponentInstance;
				theAppleEvent				: AppleEvent;
				contextID					: OSAID;
				modeFlags					: LONGINT;
				VAR resultingScriptValueID	: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $0803, $7000, $A82A;

FUNCTION
OSADoEvent(scriptingComponent	: ComponentInstance;
		   theAppleEvent		: AppleEvent;
		   contextID			: OSAID;
		   modeFlags			: LONGINT;
		   VAR reply			: AppleEvent)
	: OSAError;
    INLINE $2F3C, $0010, $0804, $7000, $A82A;

FUNCTION
OSAMakeContext(scriptingComponent		: ComponentInstance;
			   contextName				: AEDesc;
			   parentContext			: OSAID;
			   VAR resultingContextID	: OSAID)
	: OSAError;
    INLINE $2F3C, $000C, $0805, $7000, $A82A;

{$ENDC}    { UsingOSA }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}
