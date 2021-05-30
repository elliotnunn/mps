{
     File:       OSA.p
 
     Contains:   Open Scripting Architecture Client Interfaces.
 
     Version:    Technology: AppleScript 1.4
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1992-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OSA;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OSA__}
{$SETC __OSA__ := 1}

{$I+}
{$SETC OSAIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __AEOBJECTS__}
{$I AEObjects.p}
{$ENDC}
{$IFC UNDEFINED __AEINTERACTION__}
{$I AEInteraction.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*************************************************************************
    Types and Constants
*************************************************************************}

{    The componenent manager type code for components that
        support the OSA interface defined here. }
{ 0x6f736120 }

CONST
	kOSAComponentType			= 'osa ';

	{	 0x73637074 	}
	kOSAGenericScriptingComponentSubtype = 'scpt';

	{	  Type of script document files.  	}
	{	 0x6f736173 	}
	kOSAFileType				= 'osas';

	{	
	        Suite and event code of the RecordedText event. 
	        (See OSAStartRecording, below.)
	    	}
	{	 0x61736372 	}
	kOSASuite					= 'ascr';

	{	 0x72656364 	}
	kOSARecordedText			= 'recd';

	{	 Selector returns boolean 	}
	{	 0x6d6f6469 	}
	kOSAScriptIsModified		= 'modi';

	{	 Selector returns boolean 	}
	{	 0x63736372 	}
	kOSAScriptIsTypeCompiledScript = 'cscr';

	{	 Selector returns boolean 	}
	{	 0x76616c75 	}
	kOSAScriptIsTypeScriptValue	= 'valu';

	{	 Selector returns boolean 	}
	{	 0x636e7478 	}
	kOSAScriptIsTypeScriptContext = 'cntx';

	{	 Selector returns a DescType which may be passed to OSACoerceToDesc 	}
	{	 0x62657374 	}
	kOSAScriptBestType			= 'best';

	{	
	        This selector is used to determine whether a script has source 
	        associated with it that when given to OSAGetSource, the call will not
	        fail.  The selector returns a boolean.
	    	}
	{	 0x67737263 	}
	kOSACanGetSource			= 'gsrc';


	typeOSADialectInfo			= 'difo';						{   0x6469666f    }
	keyOSADialectName			= 'dnam';						{   0x646e616d    }
	keyOSADialectCode			= 'dcod';						{   0x64636f64    }
	keyOSADialectLangCode		= 'dlcd';						{   0x646c6364    }
	keyOSADialectScriptCode		= 'dscd';						{   0x64736364    }


TYPE
	OSAError							= ComponentResult;
	{	 Under the Open Scripting Architecture all error results are longs 	}
	OSAID								= UInt32;
	{	
	        OSAIDs allow transparent manipulation of scripts associated with
	        various scripting systems.
	    	}

CONST
	kOSANullScript				= 0;

	{	 No -script constant. 	}
	kOSANullMode				= 0;							{  sounds better  }
	kOSAModeNull				= 0;							{  tastes consistent  }

	{	
	        Some routines take flags that control their execution.  This constant
	        declares default mode settings are used.
	    	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OSACreateAppleEventProcPtr = FUNCTION(theAEEventClass: AEEventClass; theAEEventID: AEEventID; {CONST}VAR target: AEAddressDesc; returnID: INTEGER; transactionID: LONGINT; VAR result: AppleEvent; refCon: LONGINT): OSErr;
{$ELSEC}
	OSACreateAppleEventProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	OSASendProcPtr = FUNCTION({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP; refCon: LONGINT): OSErr;
{$ELSEC}
	OSASendProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	OSACreateAppleEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSACreateAppleEventUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	OSASendUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSASendUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppOSACreateAppleEventProcInfo = $000FEFE0;
	uppOSASendProcInfo = $003FEFE0;
	{
	 *  NewOSACreateAppleEventUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewOSACreateAppleEventUPP(userRoutine: OSACreateAppleEventProcPtr): OSACreateAppleEventUPP; { old name was NewOSACreateAppleEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewOSASendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewOSASendUPP(userRoutine: OSASendProcPtr): OSASendUPP; { old name was NewOSASendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeOSACreateAppleEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSACreateAppleEventUPP(userUPP: OSACreateAppleEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeOSASendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSASendUPP(userUPP: OSASendUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeOSACreateAppleEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSACreateAppleEventUPP(theAEEventClass: AEEventClass; theAEEventID: AEEventID; {CONST}VAR target: AEAddressDesc; returnID: INTEGER; transactionID: LONGINT; VAR result: AppleEvent; refCon: LONGINT; userRoutine: OSACreateAppleEventUPP): OSErr; { old name was CallOSACreateAppleEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeOSASendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSASendUPP({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP; refCon: LONGINT; userRoutine: OSASendUPP): OSErr; { old name was CallOSASendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{*************************************************************************
    OSA Interface Descriptions
**************************************************************************
    The OSA Interface is broken down into a required interface, and several
    optional interfaces to support additional functionality.  A given scripting
    component may choose to support only some of the optional interfaces in
    addition to the basic interface.  The OSA Component Flags may be used to 
    query the Component Manager to find a scripting component with a particular
    capability, or determine if a particular scripting component supports a 
    particular capability.
*************************************************************************}
{ OSA Component Flags: }

CONST
	kOSASupportsCompiling		= $0002;
	kOSASupportsGetSource		= $0004;
	kOSASupportsAECoercion		= $0008;
	kOSASupportsAESending		= $0010;
	kOSASupportsRecording		= $0020;
	kOSASupportsConvenience		= $0040;
	kOSASupportsDialects		= $0080;
	kOSASupportsEventHandling	= $0100;

	{	 Component Selectors: 	}
	kOSASelectLoad				= $0001;
	kOSASelectStore				= $0002;
	kOSASelectExecute			= $0003;
	kOSASelectDisplay			= $0004;
	kOSASelectScriptError		= $0005;
	kOSASelectDispose			= $0006;
	kOSASelectSetScriptInfo		= $0007;
	kOSASelectGetScriptInfo		= $0008;
	kOSASelectSetActiveProc		= $0009;
	kOSASelectGetActiveProc		= $000A;

	{	 Compiling: 	}
	kOSASelectScriptingComponentName = $0102;
	kOSASelectCompile			= $0103;
	kOSASelectCopyID			= $0104;

	kOSASelectCopyScript		= $0105;

	{	 GetSource: 	}
	kOSASelectGetSource			= $0201;

	{	 AECoercion: 	}
	kOSASelectCoerceFromDesc	= $0301;
	kOSASelectCoerceToDesc		= $0302;

	{	 AESending: 	}
	kOSASelectSetSendProc		= $0401;
	kOSASelectGetSendProc		= $0402;
	kOSASelectSetCreateProc		= $0403;
	kOSASelectGetCreateProc		= $0404;
	kOSASelectSetDefaultTarget	= $0405;

	{	 Recording: 	}
	kOSASelectStartRecording	= $0501;
	kOSASelectStopRecording		= $0502;

	{	 Convenience: 	}
	kOSASelectLoadExecute		= $0601;
	kOSASelectCompileExecute	= $0602;
	kOSASelectDoScript			= $0603;

	{	 Dialects: 	}
	kOSASelectSetCurrentDialect	= $0701;
	kOSASelectGetCurrentDialect	= $0702;
	kOSASelectAvailableDialects	= $0703;
	kOSASelectGetDialectInfo	= $0704;
	kOSASelectAvailableDialectCodeList = $0705;

	{	 Event Handling: 	}
	kOSASelectSetResumeDispatchProc = $0801;
	kOSASelectGetResumeDispatchProc = $0802;
	kOSASelectExecuteEvent		= $0803;
	kOSASelectDoEvent			= $0804;
	kOSASelectMakeContext		= $0805;

	{	 Debugging 	}
	kOSADebuggerCreateSession	= $0901;
	kOSADebuggerGetSessionState	= $0902;
	kOSADebuggerSessionStep		= $0903;
	kOSADebuggerDisposeSession	= $0904;
	kOSADebuggerGetStatementRanges = $0905;
	kOSADebuggerGetBreakpoint	= $0910;
	kOSADebuggerSetBreakpoint	= $0911;
	kOSADebuggerGetDefaultBreakpoint = $0912;
	kOSADebuggerGetCurrentCallFrame = $0906;
	kOSADebuggerGetCallFrameState = $0907;
	kOSADebuggerGetVariable		= $0908;
	kOSADebuggerSetVariable		= $0909;
	kOSADebuggerGetPreviousCallFrame = $090A;
	kOSADebuggerDisposeCallFrame = $090B;

	{	 scripting component specific selectors are added beginning with this value  	}
	kOSASelectComponentSpecificStart = $1001;


	{	        Mode Flags:
	
	    Warning: These should not conflict with the AESend mode flags in
	    AppleEvents.h, because we may want to use them as OSA mode flags too.
		}

	{	
	        This mode flag may be passed to OSALoad, OSAStore or OSACompile to
	        instruct the scripting component to not retain the "source" of an
	        expression.  This will cause the OSAGetSource call to return the error
	        errOSASourceNotAvailable if used.  However, some scripting components
	        may not retain the source anyway.  This is mainly used when either space
	        efficiency is desired, or a script is to be "locked" so that its
	        implementation may not be viewed.
	    	}
	kOSAModePreventGetSource	= $00000001;

	{	
	        These mode flags may be passed to OSACompile, OSAExecute, OSALoadExecute
	        OSACompileExecute, OSADoScript, OSAExecuteEvent, or OSADoEvent to
	        indicate whether or not the script may interact with the user, switch
	        layer or reconnect if necessary.  Any AppleEvents will be sent with the
	        corresponding AESend mode supplied.
	    	}
	kOSAModeNeverInteract		= $00000010;
	kOSAModeCanInteract			= $00000020;
	kOSAModeAlwaysInteract		= $00000030;
	kOSAModeDontReconnect		= $00000080;

	{	
	        This mode flag may be passed to OSACompile, OSAExecute, OSALoadExecute
	        OSACompileExecute, OSADoScript, OSAExecuteEvent, or OSADoEvent to
	        indicate whether or not AppleEvents should be sent with the
	        kAECanSwitchLayer mode flag sent or not. NOTE: This flag is exactly the
	        opposite sense of the AppleEvent flag kAECanSwitchLayer.  This is to
	        provide a more convenient default, i.e. not supplying any mode
	        (kOSAModeNull) means to send events with kAECanSwitchLayer.  Supplying
	        the kOSAModeCantSwitchLayer mode flag will cause AESend to be called
	        without kAECanSwitchLayer.
	    	}
	kOSAModeCantSwitchLayer		= $00000040;

	{	
	        This mode flag may be passed to OSACompile, OSAExecute, OSALoadExecute
	        OSACompileExecute, OSADoScript, OSAExecuteEvent, or OSADoEvent to
	        indicate whether or not AppleEvents should be sent with the kAEDontRecord
	        mode flag sent or not. NOTE: This flag is exactly the opposite sense of
	        the AppleEvent flag kAEDontRecord.  This is to provide a more convenient
	        default, i.e. not supplying any mode (kOSAModeNull) means to send events
	        with kAEDontRecord.  Supplying the kOSAModeDoRecord mode flag will 
	        cause AESend to be called without kAEDontRecord.
	    	}
	kOSAModeDoRecord			= $00001000;

	{	
	        This is a mode flag for OSACompile that indicates that a context should
	        be created as the result of compilation. All handler definitions are
	        inserted into the new context, and variables are initialized by
	        evaluating their initial values in a null context (i.e. they must be
	        constant expressions).
	    	}
	kOSAModeCompileIntoContext	= $00000002;

	{	
	        This is a mode flag for OSACompile that indicates that the previous
	        script ID (input to OSACompile) should be augmented with any new
	        definitions in the sourceData rather than replaced with a new script.
	        This means that the previous script ID must designate a context.
	        The presence of this flag causes the kOSAModeCompileIntoContext flag
	        to be implicitly used, causing any new definitions to be initialized
	        in a null context.
	    	}
	kOSAModeAugmentContext		= $00000004;

	{	
	        This mode flag may be passed to OSADisplay or OSADoScript to indicate
	        that output only need be human-readable, not re-compilable by OSACompile.
	        If used, output may be arbitrarily "beautified", e.g. quotes may be left
	        off of string values, long lists may have elipses, etc.
	    	}
	kOSAModeDisplayForHumans	= $00000008;

	{	
	        This mode flag may be passed to OSAStore in the case where the scriptID
	        is a context.  This causes the context to be saved, but not the context's
	        parent context.  When the stored context is loaded back in, the parent
	        will be kOSANullScript.
	    	}
	kOSAModeDontStoreParent		= $00010000;

	{	
	        This mode flag may be passed to OSAExecuteEvent to cause the event to
	        be dispatched to the direct object of the event. The direct object (or
	        subject attribute if the direct object is a non-object specifier) will
	        be resolved, and the resulting script object will be the recipient of
	        the message. The context argument to OSAExecuteEvent will serve as the
	        root of the lookup/resolution process.
	    	}
	kOSAModeDispatchToDirectObject = $00020000;

	{	
	        This mode flag may be passed to OSAExecuteEvent to indicate that
	        components do not have to get the data of object specifier arguments.
	    	}
	kOSAModeDontGetDataForArguments = $00040000;

	{	*************************************************************************
	    OSA Basic Scripting Interface
	**************************************************************************
	    Scripting components must at least support the Basic Scripting interface.
	*************************************************************************	}
	{	        Loading and Storing Scripts:
	
	    These routines allow scripts to be loaded and stored in their internal
	    (possibly compiled, non-text) representation.
		}

	{	 Resource type for scripts 	}
	kOSAScriptResourceType		= 'scpt';

	{	
	        Default type given to OSAStore which creates "generic" loadable script
	        data descriptors.
	    	}
	typeOSAGenericStorage		= 'scpt';

	{
	 *  OSALoad()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OSALoad(scriptingComponent: ComponentInstance; {CONST}VAR scriptData: AEDesc; modeFlags: LONGINT; VAR resultingScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0001, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectLoad, 12);
    
        Errors:
            badComponentInstance        invalid scripting component instance
            errOSASystemError
            errOSABadStorageType:       scriptData not for this scripting component
            errOSACorruptData:          data seems to be corrupt
            errOSADataFormatObsolete    script data format is no longer supported
            errOSADataFormatTooNew      script data format is from a newer version
        
        ModeFlags:
            kOSAModePreventGetSource
    }
{
 *  OSAStore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAStore(scriptingComponent: ComponentInstance; scriptID: OSAID; desiredType: DescType; modeFlags: LONGINT; VAR resultingScriptData: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectStore, 16);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errOSABadStorageType:   desiredType not for this scripting component
        
        ModeFlags:
            kOSAModePreventGetSource
            kOSAModeDontStoreParent
    }
{ Executing Scripts: }
{
 *  OSAExecute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAExecute(scriptingComponent: ComponentInstance; compiledScriptID: OSAID; contextID: OSAID; modeFlags: LONGINT; VAR resultingScriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0003, $7000, $A82A;
	{$ENDC}

{
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
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errOSAScriptError:      the executing script got an error
    
        ModeFlags:
            kOSAModeNeverInteract
            kOSAModeCanInteract
            kOSAModeAlwaysInteract
            kOSAModeCantSwitchLayer
            kOSAModeDontReconnect
            kOSAModeDoRecord
    }
{ Displaying results: }
{
 *  OSADisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADisplay(scriptingComponent: ComponentInstance; scriptValueID: OSAID; desiredType: DescType; modeFlags: LONGINT; VAR resultingText: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0004, $7000, $A82A;
	{$ENDC}

{
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
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errAECoercionFail:      desiredType not supported by scripting component
    
        ModeFlags:
            kOSAModeDisplayForHumans
    }
{ Getting Error Information: }
{
 *  OSAScriptError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAScriptError(scriptingComponent: ComponentInstance; selector: OSType; desiredType: DescType; VAR resultingErrorDescription: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0005, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectScriptError, 12);
        Whenever script execution returns errOSAExecutionError, this routine
        may be used to get information about that error.  The selector describes
        the type of information desired about the error (various selectors are
        listed below).  The desiredType indicates the data type of the result
        desired for that selector.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSABadSelector:      selector not supported by scripting component
            errAECoercionFail:      desiredType not supported by scripting component
    }
{ OSAScriptError selectors: }
{
        This selector is used to determine the error number of a script error.
        These error numbers may be either system error numbers, or error numbers
        that are scripting component specific.
        Required desiredTypes:  
            typeShortInteger
    }

CONST
	kOSAErrorNumber				= 'errn';

	{	
	        This selector is used to determine the full error message associated
	        with the error number.  It should include the name of the application
	        which caused the error, as well as the specific error that occurred.
	        This selector is sufficient for simple error reporting (but see
	        kOSAErrorBriefMessage, below).
	        Required desiredTypes:
	            typeChar                    error message string
	    	}
	kOSAErrorMessage			= 'errs';

	{	
	        This selector is used to determine a brief error message associated with
	        the error number.  This message and should not mention the name of the
	        application which caused the error, any partial results or offending
	        object (see kOSAErrorApp, kOSAErrorPartialResult and
	        kOSAErrorOffendingObject, below).
	        Required desiredTypes:
	            typeChar                    brief error message string
	    	}
	{	  0x65727262  	}
	kOSAErrorBriefMessage		= 'errb';

	{	
	        This selector is used to determine which application actually got the
	        error (if it was the result of an AESend), or the current application
	        if ....
	        Required desiredTypes:
	            typeProcessSerialNumber     PSN of the errant application
	            typeChar                    name of the errant application
	    	}
	{	  0x65726170  	}
	kOSAErrorApp				= 'erap';

	{	
	        This selector is used to determine any partial result returned by an 
	        operation. If an AESend call failed, but a partial result was returned,
	        then the partial result may be returned as an AEDesc.
	        Required desiredTypes:
	            typeBest                    AEDesc of any partial result
	    	}
	{	  0x70746c72   	}
	kOSAErrorPartialResult		= 'ptlr';

	{	
	        This selector is used to determine any object which caused the error
	        that may have been indicated by an application.  The result is an 
	        AEDesc.
	        Required desiredTypes:
	            typeBest                    AEDesc of any offending object
	    	}
	{	  0x65726f62   	}
	kOSAErrorOffendingObject	= 'erob';

	{	
	        This selector is used to determine the type expected by a coercion 
	        operation if a type error occurred.
	    	}
	{	  0x65727274   	}
	kOSAErrorExpectedType		= 'errt';

	{	
	        This selector is used to determine the source text range (start and 
	        end positions) of where the error occurred.
	        Required desiredTypes:
	            typeOSAErrorRange
	    	}
	{	  0x65726e67  	}
	kOSAErrorRange				= 'erng';

	{	
	        An AERecord type containing keyOSASourceStart and keyOSASourceEnd fields
	        of type short.
	    	}
	{	  0x65726e67   	}
	typeOSAErrorRange			= 'erng';

	{	 Field of a typeOSAErrorRange record of typeShortInteger 	}
	{	  0x73726373    	}
	keyOSASourceStart			= 'srcs';

	{	 Field of a typeOSAErrorRange record of typeShortInteger 	}
	{	  0x73726365   	}
	keyOSASourceEnd				= 'srce';

	{	 Disposing Script IDs: 	}
	{
	 *  OSADispose()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OSADispose(scriptingComponent: ComponentInstance; scriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectDispose, 4);
        Disposes a script or context.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
    }
{ Getting and Setting Script Information: }
{
 *  OSASetScriptInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetScriptInfo(scriptingComponent: ComponentInstance; scriptID: OSAID; selector: OSType; value: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0007, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectSetScriptInfo, 12);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errOSABadSelector:      selector not supported by scripting component
                                    or selector not for this scriptID
    }
{
 *  OSAGetScriptInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetScriptInfo(scriptingComponent: ComponentInstance; scriptID: OSAID; selector: OSType; VAR result: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0008, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetScriptInfo, 12);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errOSABadSelector:      selector not supported by scripting component
                                    or selector not for this scriptID
    }
{ Manipulating the ActiveProc:

    Scripting systems will supply default values for these procedures if they
    are not set by the client:
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OSAActiveProcPtr = FUNCTION(refCon: LONGINT): OSErr;
{$ELSEC}
	OSAActiveProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	OSAActiveUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	OSAActiveUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppOSAActiveProcInfo = $000000E0;
	{
	 *  NewOSAActiveUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewOSAActiveUPP(userRoutine: OSAActiveProcPtr): OSAActiveUPP; { old name was NewOSAActiveProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeOSAActiveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeOSAActiveUPP(userUPP: OSAActiveUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeOSAActiveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeOSAActiveUPP(refCon: LONGINT; userRoutine: OSAActiveUPP): OSErr; { old name was CallOSAActiveProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  OSASetActiveProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetActiveProc(scriptingComponent: ComponentInstance; activeProc: OSAActiveUPP; refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0009, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectSetActiveProc, 8);
        If activeProc is nil, the default activeProc is used.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSAGetActiveProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetActiveProc(scriptingComponent: ComponentInstance; VAR activeProc: OSAActiveUPP; VAR refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000A, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetActiveProc, 8);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{*************************************************************************
    OSA Optional Compiling Interface
**************************************************************************
    Scripting components that support the Compiling interface have the 
    kOSASupportsCompiling bit set in it's ComponentDescription.
*************************************************************************}
{
 *  OSAScriptingComponentName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAScriptingComponentName(scriptingComponent: ComponentInstance; VAR resultingScriptingComponentName: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectScriptingComponentName, 4);
        Given a scripting component, this routine returns the name of that
        scripting component in a type that is coercable to text (typeChar).
        The generic scripting component returns the name of the default
        scripting component.  This name should be sufficient to convey to the
        user the kind of script (syntax) he is expected to write.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSACompile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSACompile(scriptingComponent: ComponentInstance; {CONST}VAR sourceData: AEDesc; modeFlags: LONGINT; VAR previousAndResultingScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectCompile, 12);
        Coerces input desc (possibly text) into a script's internal format.
        Once compiled, the script is ready to run.  The modeFlags convey
        scripting component specific information.  The previous script ID
        (result parameter) is made to refer to the newly compiled script,
        unless it was originally kOSANullScript.  In this case a new script
        ID is created and used.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errAECoercionFail:      sourceData is not compilable
            errOSAScriptError:      sourceData was a bad script (syntax error)
            errOSAInvalidID:        previousAndResultingCompiledScriptID was not
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
    }
{
 *  OSACopyID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSACopyID(scriptingComponent: ComponentInstance; fromID: OSAID; VAR toID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0104, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectCopyID, 8);
        If toID is a reference to kOSANullScript then it is updated to have a
        new scriptID value.  This call can be used to perform undo or revert
        operations on scripts. 
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
    }
{$IFC CALL_NOT_IN_CARBON }
{
 *  OSACopyScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OSACopyScript(scriptingComponent: ComponentInstance; fromID: OSAID; VAR toID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0105, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectCopyScript, 8);
        Creates a duplicate copy of the script with the given OSAID and returns
        a new OSAID for it.  Can be used by script editors or debuggers. 
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
    }
{$ENDC}  {CALL_NOT_IN_CARBON}

{*************************************************************************
    OSA Optional GetSource Interface
**************************************************************************
    Scripting components that support the GetSource interface have the 
    kOSASupportsGetSource bit set in their ComponentDescription.
*************************************************************************}
{
 *  OSAGetSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetSource(scriptingComponent: ComponentInstance; scriptID: OSAID; desiredType: DescType; VAR resultingSourceData: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0201, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetSource, 12);
        This routine causes a compiled script to be output in a form (possibly
        text) such that it is suitable to be passed back to OSACompile.

        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errOSASourceNotAvailable    can't get source for this scriptID
    }
{*************************************************************************
    OSA Optional AECoercion Interface
**************************************************************************
    Scripting components that support the AECoercion interface have the 
    kOSASupportsAECoercion bit set in their ComponentDescription.
*************************************************************************}
{
 *  OSACoerceFromDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSACoerceFromDesc(scriptingComponent: ComponentInstance; {CONST}VAR scriptData: AEDesc; modeFlags: LONGINT; VAR resultingScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0301, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectCoerceFromDesc, 12);
        This routine causes script data to be coerced into a script value.
        If the scriptData is an AppleEvent, then the resultingScriptID is a
        compiled script ID (mode flags for OSACompile may be used in this case).
        Other scriptData descriptors create script value IDs.
    
        Errors:
            badComponentInstance    invalid scripting component instance
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
    }
{
 *  OSACoerceToDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSACoerceToDesc(scriptingComponent: ComponentInstance; scriptID: OSAID; desiredType: DescType; modeFlags: LONGINT; VAR result: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0302, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectCoerceToDesc, 16);
        This routine causes a script value to be coerced into any desired form.
        If the scriptID denotes a compiled script, then it may be coerced to 
        typeAppleEvent.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
    }
{*************************************************************************
    OSA Optional AESending Interface
**************************************************************************
    Scripting components that support the AESending interface have the 
    kOSASupportsAESending bit set in their ComponentDescription.
*************************************************************************}
{
    Scripting systems will supply default values for these procedures if they
    are not set by the client:
}
{
 *  OSASetSendProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetSendProc(scriptingComponent: ComponentInstance; sendProc: OSASendUPP; refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0401, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectSetSendProc, 8);
        If sendProc is nil, the default sendProc is used.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSAGetSendProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetSendProc(scriptingComponent: ComponentInstance; VAR sendProc: OSASendUPP; VAR refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0402, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetSendProc, 8);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSASetCreateProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetCreateProc(scriptingComponent: ComponentInstance; createProc: OSACreateAppleEventUPP; refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0403, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectSetCreateProc, 8);
        If createProc is nil, the default createProc is used.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSAGetCreateProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetCreateProc(scriptingComponent: ComponentInstance; VAR createProc: OSACreateAppleEventUPP; VAR refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0404, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetCreateProc, 8);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSASetDefaultTarget()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetDefaultTarget(scriptingComponent: ComponentInstance; {CONST}VAR target: AEAddressDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0405, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectSetDefaultTarget, 4);
        This routine sets the default target application for AE sending.
        It also establishes the default target from which terminologies come.
        It is effectively like having an AppleScript "tell" statement around
        the entire program.  If this routine is not called, or if the target 
        is a null AEDesc, then the current application is the default target.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{*************************************************************************
    OSA Optional Recording Interface
**************************************************************************
    Scripting components that support the Recording interface have the 
    kOSASupportsRecording bit set in their ComponentDescription.
*************************************************************************}
{
 *  OSAStartRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAStartRecording(scriptingComponent: ComponentInstance; VAR compiledScriptToModifyID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0501, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectStartRecording, 4);
        Starts recording.  If compiledScriptToModifyID is kOSANullScript, a
        new script ID is created and returned.  If the current application has
        a handler for the kOSARecordedText event, then kOSARecordedText events
        are sent to the application containing the text of each AppleEvent 
        recorded.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errOSARecordingIsAlreadyOn
    }
{
 *  OSAStopRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAStopRecording(scriptingComponent: ComponentInstance; compiledScriptID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0502, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectStopRecording, 4);
        If compiledScriptID is not being recorded into or recording is not
        currently on, no error is returned.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
    }
{*************************************************************************
    OSA Optional Convenience Interface
**************************************************************************
    Scripting components that support the Convenience interface have the 
    kOSASupportsConvenience bit set in their ComponentDescription.
*************************************************************************}
{
 *  OSALoadExecute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSALoadExecute(scriptingComponent: ComponentInstance; {CONST}VAR scriptData: AEDesc; contextID: OSAID; modeFlags: LONGINT; VAR resultingScriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0601, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectLoadExecute, 16);
        This routine is effectively equivalent to calling OSALoad followed by
        OSAExecute.  After execution, the compiled source is disposed.  Only the
        resulting value ID is retained.
    
        Errors:
            badComponentInstance        invalid scripting component instance
            errOSASystemError
            errOSABadStorageType:       scriptData not for this scripting component
            errOSACorruptData:          data seems to be corrupt
            errOSADataFormatObsolete    script data format is no longer supported
            errOSADataFormatTooNew      script data format is from a newer version
            errOSAInvalidID
            errOSAScriptError:          the executing script got an error
    
        ModeFlags:
            kOSAModeNeverInteract
            kOSAModeCanInteract
            kOSAModeAlwaysInteract
            kOSAModeCantSwitchLayer
            kOSAModeDontReconnect
            kOSAModeDoRecord
    }
{
 *  OSACompileExecute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSACompileExecute(scriptingComponent: ComponentInstance; {CONST}VAR sourceData: AEDesc; contextID: OSAID; modeFlags: LONGINT; VAR resultingScriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0602, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectCompileExecute, 16);
        This routine is effectively equivalent to calling OSACompile followed by
        OSAExecute.  After execution, the compiled source is disposed.  Only the
        resulting value ID is retained.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errAECoercionFail:      sourceData is not compilable
            errOSAScriptError:      sourceData was a bad script (syntax error)
            errOSAInvalidID:        previousAndResultingCompiledScriptID was not
                                    valid on input
            errOSAScriptError:      the executing script got an error
    
        ModeFlags:
            kOSAModeNeverInteract
            kOSAModeCanInteract
            kOSAModeAlwaysInteract
            kOSAModeCantSwitchLayer
            kOSAModeDontReconnect
            kOSAModeDoRecord
    }
{
 *  OSADoScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADoScript(scriptingComponent: ComponentInstance; {CONST}VAR sourceData: AEDesc; contextID: OSAID; desiredType: DescType; modeFlags: LONGINT; VAR resultingText: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0603, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectDoScript, 20);
        This routine is effectively equivalent to calling OSACompile followed by
        OSAExecute and then OSADisplay.  After execution, the compiled source
        and the resulting value are is disposed.  Only the resultingText
        descriptor is retained.  If a script error occur during processing, the 
        resultingText gets the error message of the error, and errOSAScriptError
        is returned.  OSAScriptError may still be used to extract more 
        information about the particular error.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errAECoercionFail:      sourceData is not compilable or 
                                    desiredType not supported by scripting component
            errOSAScriptError:      sourceData was a bad script (syntax error)
            errOSAInvalidID:        previousAndResultingCompiledScriptID was not
                                    valid on input
            errOSAScriptError:      the executing script got an error
    
        ModeFlags:
            kOSAModeNeverInteract
            kOSAModeCanInteract
            kOSAModeAlwaysInteract
            kOSAModeCantSwitchLayer
            kOSAModeDontReconnect
            kOSAModeDoRecord
            kOSAModeDisplayForHumans
    }
{*************************************************************************
    OSA Optional Dialects Interface
**************************************************************************
    Scripting components that support the Dialects interface have the 
    kOSASupportsDialects bit set in their ComponentDescription.
*************************************************************************}
{
    These calls allows an scripting component that supports different dialects
    to dynamically switch between those dialects.  Although this interface is
    specified, the particular dialect codes are scripting component dependent.
}
{
 *  OSASetCurrentDialect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetCurrentDialect(scriptingComponent: ComponentInstance; dialectCode: INTEGER): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0701, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectSetCurrentDialect, 2);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSANoSuchDialect:    invalid dialectCode
    }
{
 *  OSAGetCurrentDialect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetCurrentDialect(scriptingComponent: ComponentInstance; VAR resultingDialectCode: INTEGER): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0702, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetCurrentDialect, 4);
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSAAvailableDialects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAAvailableDialects(scriptingComponent: ComponentInstance; VAR resultingDialectInfoList: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0703, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectAvailableDialects, 4);
        This call return an AEList containing information about each of the
        currently available dialects of a scripting component.  Each item
        is an AERecord of typeOSADialectInfo that contains at least the fields
        keyOSADialectName, keyOSADialectCode, KeyOSADialectLangCode and 
        keyOSADialectScriptCode.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSAGetDialectInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetDialectInfo(scriptingComponent: ComponentInstance; dialectCode: INTEGER; selector: OSType; VAR resultingDialectInfo: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0704, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetDialectInfo, 10);
        This call gives information about the specified dialect of a scripting
        component. It returns an AEDesc whose type depends on the selector 
        specified. Available selectors are the same as the field keys for a
        dialect info record. The type of AEDesc returned is the same as the 
        type of the field that has same key as the selector.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSABadSelector
            errOSANoSuchDialect:    invalid dialectCode
    }
{
 *  OSAAvailableDialectCodeList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAAvailableDialectCodeList(scriptingComponent: ComponentInstance; VAR resultingDialectCodeList: AEDesc): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0705, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectAvailableDialectCodeList, 4);
        This is alternative to OSAGetAvailableDialectCodeList. Use this call
        and  OSAGetDialectInfo to get information on dialects.
        This call return an AEList containing dialect code for each of the
        currently available dialects of a scripting component. Each dialect
        code is a short integer of type typeShortInteger.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError

        Type of a dialect info record containing at least keyOSADialectName
        and keyOSADialectCode fields.

        keys for dialect info record, also used as selectors to OSAGetDialectInfo.

        Field of a typeOSADialectInfo record of typeChar.
        Field of a typeOSADialectInfo record of typeShortInteger.
        Field of a typeOSADialectInfo record of typeShortInteger.
        Field of a typeOSADialectInfo record of typeShortInteger.
    }
{*************************************************************************
    OSA Optional Event Handling Interface
**************************************************************************
    Scripting components that support the Event Handling interface have the 
    kOSASupportsEventHandling bit set in their ComponentDescription.
*************************************************************************}
{
 *  OSASetResumeDispatchProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetResumeDispatchProc(scriptingComponent: ComponentInstance; resumeDispatchProc: AEEventHandlerUPP; refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0801, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectSetResumeDispatchProc, 8);
        This function is used to set the ResumeDispatchProc that will be used
        by OSAExecuteEvent and OSADoEvent if either no event handler can be
        found in the context, or the context event hander "continues" control
        onward. The two constants kOSAUseStandardDispatch and kOSANoDispatch
        may also be passed to this routine indicating that the handler registered
        in the application with AEInstallEventHandler should be used, or no
        dispatch should occur, respectively.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }

CONST
	kOSAUseStandardDispatch		= $FFFFFFFF;

	{	
	        Special ResumeDispatchProc constant which may be passed to 
	        OSASetResumeDispatchProc indicating that the handler registered
	        in the application with AEInstallEventHandler should be used.
	        
	        NOTE:   Had to remove the cast (AEEventHandlerUPP).  The C compiler
	                doesn't allow pointer types to be assigned to an enum.  All
	                constants must be assigned as enums to translate properly to
	                Pascal.
	    	}
	kOSANoDispatch				= 0;

	{	
	        Special ResumeDispatchProc constant which may be passed to 
	        OSASetResumeDispatchProc indicating that no dispatch should occur.
	        
	        NOTE:   Had to remove the cast (AEEventHandlerUPP).  The C compiler
	                doesn't allow pointer types to be assigned to an enum.  All
	                constants must be assigned as enums to translate properly to
	                Pascal.
	    	}
	kOSADontUsePhac				= $0001;

	{	
	        Special refCon constant that may be given to OSASetResumeDispatchProc
	        only when kOSAUseStandardDispatch is used as the ResumeDispatchProc.
	        This causes the standard dispatch to be performed, except the phac
	        handler is not called.  This is useful during tinkerability, when
	        the phac handler is used to lookup a context associated with an event's 
	        direct parameter, and call OSAExecuteEvent or OSADoEvent.  Failure to
	        bypass the phac handler would result in an infinite loop.
	    	}
	{
	 *  OSAGetResumeDispatchProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OSAGetResumeDispatchProc(scriptingComponent: ComponentInstance; VAR resumeDispatchProc: AEEventHandlerUPP; VAR refCon: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0802, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectGetResumeDispatchProc, 8);
        Returns the registered ResumeDispatchProc.  If no ResumeDispatchProc has
        been registered, then kOSAUseStandardDispatch (the default) is returned.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
    }
{
 *  OSAExecuteEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAExecuteEvent(scriptingComponent: ComponentInstance; {CONST}VAR theAppleEvent: AppleEvent; contextID: OSAID; modeFlags: LONGINT; VAR resultingScriptValueID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0803, $7000, $A82A;
	{$ENDC}

{
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
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errOSAScriptError:      the executing script got an error
            errAEEventNotHandled:   no handler for event in contextID
    
        ModeFlags:
            kOSAModeNeverInteract
            kOSAModeCanInteract
            kOSAModeAlwaysInteract
            kOSAModeCantSwitchLayer
            kOSAModeDontReconnect
            kOSAModeDoRecord
    }
{
 *  OSADoEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADoEvent(scriptingComponent: ComponentInstance; {CONST}VAR theAppleEvent: AppleEvent; contextID: OSAID; modeFlags: LONGINT; VAR reply: AppleEvent): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0804, $7000, $A82A;
	{$ENDC}

{
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
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errAEEventNotHandled:   no handler for event in contextID
    
        ModeFlags:
            kOSAModeNeverInteract
            kOSAModeCanInteract
            kOSAModeAlwaysInteract
            kOSAModeCantSwitchLayer
            kOSAModeDontReconnect
            kOSAModeDoRecord
    }
{
 *  OSAMakeContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAMakeContext(scriptingComponent: ComponentInstance; {CONST}VAR contextName: AEDesc; parentContext: OSAID; VAR resultingContextID: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0805, $7000, $A82A;
	{$ENDC}

{
        OSAComponentFunctionInline(kOSASelectMakeContext, 12);
        Makes a new empty context which may be passed to OSAExecute or 
        OSAExecuteEvent.  If contextName is typeNull, an unnamed context is
        created. If parentContext is kOSANullScript then the resulting context
        does not inherit bindings from any other context.
    
        Errors:
            badComponentInstance    invalid scripting component instance
            errOSASystemError
            errOSAInvalidID
            errAECoercionFail:      contextName is invalid
    }
{
 * Debugging API
 }
{
 * Types
 }

TYPE
	OSADebugSessionRef					= OSAID;
	OSADebugCallFrameRef				= OSAID;
	{	
	 * Constants
	 	}
	OSAProgramState 			= UInt32;
CONST
	eNotStarted					= 0;
	eRunnable					= 1;
	eRunning					= 2;
	eStopped					= 3;
	eTerminated					= 4;


TYPE
	OSADebugStepKind 			= UInt32;
CONST
	eStepOver					= 0;
	eStepIn						= 1;
	eStepOut					= 2;
	eRun						= 3;

	{	
	 * Session Information
	 	}
	keyProgramState				= 'dsps';

	{	
	 * Call Frame Information
	 	}

TYPE
	StatementRangePtr = ^StatementRange;
	StatementRange = RECORD
		startPos:				UInt32;
		endPos:					UInt32;
	END;


CONST
	typeStatementRange			= 'srng';

	keyProcedureName			= 'dfnm';						{  typeChar  }
	keyStatementRange			= 'dfsr';						{  typeStatementRange  }
	keyLocalsNames				= 'dfln';						{  typeAEList of typeChar  }
	keyGlobalsNames				= 'dfgn';						{  typeAEList of typeChar  }
	keyParamsNames				= 'dfpn';						{  typeAEList of typeChar  }

	{	
	 * Sessions
	 	}
	{
	 *  OSADebuggerCreateSession()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OSADebuggerCreateSession(scriptingComponent: ComponentInstance; inScript: OSAID; inContext: OSAID; VAR outSession: OSADebugSessionRef): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0901, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerGetSessionState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetSessionState(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef; VAR outState: AERecord): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0902, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerSessionStep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerSessionStep(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef; inKind: OSADebugStepKind): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0903, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerDisposeSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerDisposeSession(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0904, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerGetStatementRanges()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetStatementRanges(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef; VAR outStatementRangeArray: AEDescList): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0905, $7000, $A82A;
	{$ENDC}

{  Returns an array of StatementRange objects. }
{
 *  OSADebuggerGetBreakpoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetBreakpoint(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef; inSrcOffset: UInt32; VAR outBreakpoint: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0910, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerSetBreakpoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerSetBreakpoint(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef; inSrcOffset: UInt32; inBreakpoint: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0911, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerGetDefaultBreakpoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetDefaultBreakpoint(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef; VAR outBreakpoint: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0912, $7000, $A82A;
	{$ENDC}

{
 * Call Frames
 }
{
 *  OSADebuggerGetCurrentCallFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetCurrentCallFrame(scriptingComponent: ComponentInstance; inSession: OSADebugSessionRef; VAR outCallFrame: OSADebugCallFrameRef): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0906, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerGetCallFrameState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetCallFrameState(scriptingComponent: ComponentInstance; inCallFrame: OSADebugCallFrameRef; VAR outState: AERecord): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0907, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerGetVariable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetVariable(scriptingComponent: ComponentInstance; inCallFrame: OSADebugCallFrameRef; {CONST}VAR inVariableName: AEDesc; VAR outVariable: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0908, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerSetVariable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerSetVariable(scriptingComponent: ComponentInstance; inCallFrame: OSADebugCallFrameRef; {CONST}VAR inVariableName: AEDesc; inVariable: OSAID): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0909, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerGetPreviousCallFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerGetPreviousCallFrame(scriptingComponent: ComponentInstance; inCurrentFrame: OSADebugCallFrameRef; VAR outPrevFrame: OSADebugCallFrameRef): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $090A, $7000, $A82A;
	{$ENDC}

{
 *  OSADebuggerDisposeCallFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.5 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSADebuggerDisposeCallFrame(scriptingComponent: ComponentInstance; inCallFrame: OSADebugCallFrameRef): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $090B, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSAIncludes}

{$ENDC} {__OSA__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
