{
     File:       Processes.p
 
     Contains:   Process Manager Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Processes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PROCESSES__}
{$SETC __PROCESSES__ := 1}

{$I+}
{$SETC ProcessesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ type for unique process identifier }

TYPE
	ProcessSerialNumberPtr = ^ProcessSerialNumber;
	ProcessSerialNumber = RECORD
		highLongOfPSN:			UInt32;
		lowLongOfPSN:			UInt32;
	END;


CONST
																{  Process identifier - Various reserved process serial numbers  }
	kNoProcess					= 0;
	kSystemProcess				= 1;
	kCurrentProcess				= 2;

	{	 Definition of the parameter block passed to _Launch 	}
	{  Typedef and flags for launchControlFlags field }

TYPE
	LaunchFlags							= UInt16;

CONST
	launchContinue				= $4000;
	launchNoFileFlags			= $0800;
	launchUseMinimum			= $0400;
	launchDontSwitch			= $0200;
	launchAllow24Bit			= $0100;
	launchInhibitDaemon			= $0080;

	{	 Format for first AppleEvent to pass to new process.  The size of the overall
	  buffer variable: the message body immediately follows the messageLength 	}

TYPE
	AppParametersPtr = ^AppParameters;
	AppParameters = RECORD
		theMsgEvent:			EventRecord;
		eventRefCon:			UInt32;
		messageLength:			UInt32;
	END;

	{	 Parameter block to _Launch 	}
	LaunchParamBlockRecPtr = ^LaunchParamBlockRec;
	LaunchParamBlockRec = RECORD
		reserved1:				UInt32;
		reserved2:				UInt16;
		launchBlockID:			UInt16;
		launchEPBLength:		UInt32;
		launchFileFlags:		UInt16;
		launchControlFlags:		LaunchFlags;
		launchAppSpec:			FSSpecPtr;
		launchProcessSN:		ProcessSerialNumber;
		launchPreferredSize:	UInt32;
		launchMinimumSize:		UInt32;
		launchAvailableSize:	UInt32;
		launchAppParameters:	AppParametersPtr;
	END;

	LaunchPBPtr							= ^LaunchParamBlockRec;
	{	 Set launchBlockID to extendedBlock to specify that extensions exist.
	 Set launchEPBLength to extendedBlockLen for compatibility.	}

CONST
	extendedBlock				= $4C43;						{  'LC'  }
	extendedBlockLen			= 32;

																{  Definition of the information block returned by GetProcessInformation  }
	modeReserved				= $01000000;
	modeControlPanel			= $00080000;
	modeLaunchDontSwitch		= $00040000;
	modeDeskAccessory			= $00020000;
	modeMultiLaunch				= $00010000;
	modeNeedSuspendResume		= $00004000;
	modeCanBackground			= $00001000;
	modeDoesActivateOnFGSwitch	= $00000800;
	modeOnlyBackground			= $00000400;
	modeGetFrontClicks			= $00000200;
	modeGetAppDiedMsg			= $00000100;
	mode32BitCompatible			= $00000080;
	modeHighLevelEventAware		= $00000040;
	modeLocalAndRemoteHLEvents	= $00000020;
	modeStationeryAware			= $00000010;
	modeUseTextEditServices		= $00000008;
	modeDisplayManagerAware		= $00000004;

	{
	   Record returned by GetProcessInformation
	    When calling GetProcessInformation(), the input ProcesInfoRec
	    should have the processInfoLength set to sizeof(ProcessInfoRec),
	    the processName field set to nil or a pointer to a Str255, and
	    processAppSpec set to nil or a pointer to an FSSpec.  If
	    processName or processAppSpec are not specified, this routine
	    will very likely write data to whatever random location in memory
	    these happen to point to, which is not a good thing.
	}

TYPE
	ProcessInfoRecPtr = ^ProcessInfoRec;
	ProcessInfoRec = RECORD
		processInfoLength:		UInt32;
		processName:			StringPtr;
		processNumber:			ProcessSerialNumber;
		processType:			UInt32;
		processSignature:		OSType;
		processMode:			UInt32;
		processLocation:		Ptr;
		processSize:			UInt32;
		processFreeMem:			UInt32;
		processLauncher:		ProcessSerialNumber;
		processLaunchDate:		UInt32;
		processActiveTime:		UInt32;
		processAppSpec:			FSSpecPtr;
	END;

	{
	    Some applications assumed the size of a ProcessInfoRec would never change,
	    which has caused problems trying to return additional information.  In
	    the future, we will add fields to ProcessInfoExtendedRec when necessary,
	    and callers which wish to access 'more' data than originally was present
	    in ProcessInfoRec should allocate space for a ProcessInfoExtendedRec,
	    fill in the processInfoLength ( and processName and processAppSpec ptrs ),
	    then coerce this to a ProcessInfoRecPtr in the call to
	    GetProcessInformation().
	}
	ProcessInfoExtendedRecPtr = ^ProcessInfoExtendedRec;
	ProcessInfoExtendedRec = RECORD
		processInfoLength:		UInt32;
		processName:			StringPtr;
		processNumber:			ProcessSerialNumber;
		processType:			UInt32;
		processSignature:		OSType;
		processMode:			UInt32;
		processLocation:		Ptr;
		processSize:			UInt32;
		processFreeMem:			UInt32;
		processLauncher:		ProcessSerialNumber;
		processLaunchDate:		UInt32;
		processActiveTime:		UInt32;
		processAppSpec:			FSSpecPtr;
		processTempMemTotal:	UInt32;
		processPurgeableTempMemTotal: UInt32;
	END;

	{	 Record corresponding to the SIZE resource definition 	}
	SizeResourceRecPtr = ^SizeResourceRec;
	SizeResourceRec = RECORD
		flags:					UInt16;
		preferredHeapSize:		UInt32;
		minimumHeapSize:		UInt32;
	END;

	SizeResourceRecHandle				= ^SizeResourceRecPtr;
	{
	    Applications and background applications can control when they are asked to quit
	    by the system at restart/shutdown by setting these bits in a 'quit' ( 0 ) resource
	    in their application's resource fork.  Applications without a 'quit' ( 0 ) will
	    be quit at kQuitAtNormalTime mask.
	}

CONST
	kQuitBeforeNormalTimeMask	= 1;
	kQuitAtNormalTimeMask		= 2;
	kQuitBeforeFBAsQuitMask		= 4;
	kQuitBeforeShellQuitsMask	= 8;
	kQuitBeforeTerminatorAppQuitsMask = 16;
	kQuitNeverMask				= 32;
	kQuitOptionsMask			= $7F;
	kQuitNotQuitDuringInstallMask = $0100;
	kQuitNotQuitDuringLogoutMask = $0200;


	{
	 *  LaunchApplication()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION LaunchApplication(LaunchParams: LaunchPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A9F2, $3E80;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  LaunchDeskAccessory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LaunchDeskAccessory({CONST}VAR pFileSpec: FSSpec; pDAName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0036, $A88F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  [Mac]GetCurrentProcess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCurrentProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0037, $A88F;
	{$ENDC}

{
 *  GetFrontProcess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFrontProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $70FF, $2F00, $3F3C, $0039, $A88F;
	{$ENDC}

{
 *  GetNextProcess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNextProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0038, $A88F;
	{$ENDC}

{
 *  GetProcessInformation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetProcessInformation({CONST}VAR PSN: ProcessSerialNumber; VAR info: ProcessInfoRec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003A, $A88F;
	{$ENDC}

{
 *  SetFrontProcess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetFrontProcess({CONST}VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003B, $A88F;
	{$ENDC}

{
 *  WakeUpProcess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION WakeUpProcess({CONST}VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003C, $A88F;
	{$ENDC}

{
 *  SameProcess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SameProcess({CONST}VAR PSN1: ProcessSerialNumber; {CONST}VAR PSN2: ProcessSerialNumber; VAR result: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003D, $A88F;
	{$ENDC}

{   ExitToShell was previously in SegLoad.h }
{
 *  ExitToShell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ExitToShell;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9F4;
	{$ENDC}

{
   LaunchControlPanel is similar to LaunchDeskAccessory, but for Control Panel files instead.
   It launches a control panel in an application shell maintained by the Process Manager.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  LaunchControlPanel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LaunchControlPanel({CONST}VAR pFileSpec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $007B, $A88F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetApplicationTextEncoding()
 *  
 *  Summary:
 *    Returns the application text encoding for Resource Manager
 *    resources.
 *  
 *  Discussion:
 *    The application text encoding is used when you create a
 *    CFStringRef from text stored in Resource Manager resources, which
 *    typically uses one of the Mac encodings such as MacRoman or
 *    MacJapanese.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetApplicationTextEncoding: TextEncoding;

{
 *  GetApplicationScript()
 *  
 *  Summary:
 *    Returns the application script.
 *  
 *  Discussion:
 *    The application script is used when you need a ScriptCode to pass
 *    to some other API, such as UseThemeFont.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetApplicationScript: ScriptCode;

{
 *  GetProcessBundleLocation()
 *  
 *  Summary:
 *    Retrieve the filesystem location of the process bundle, or
 *    executable if unbundled.
 *  
 *  Discussion:
 *    Retrieves a reference to the filesystem location of the specified
 *    application.  For an application that is packaged as an app
 *    bundle, this will be the app bundle directory; otherwise it will
 *    be the location of the executable itself.
 *  
 *  Parameters:
 *    
 *    psn:
 *      Serial number of the target process
 *    
 *    location:
 *      Location of the bundle or executable, as an FSRef
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetProcessBundleLocation({CONST}VAR psn: ProcessSerialNumber; VAR location: FSRef): OSStatus; C;

{
 *  CopyProcessName()
 *  
 *  Summary:
 *    Get a copy of the name of a process.
 *  
 *  Discussion:
 *    Use this call to get the name of a process as a CFString.  The
 *    name returned is a copy, so the caller must CFRelease the name
 *    when finished with it.  The difference between this call and the
 *    processName field filled in by GetProcessInformation is that the
 *    name here is a CFString, and thus is capable of representing a
 *    multi-lingual name, whereas previously only a mac-encoded string
 *    was possible.
 *  
 *  Parameters:
 *    
 *    psn:
 *      Serial number of the target process
 *    
 *    name:
 *      CFString representing the name of the process (must be released
 *      by caller with CFRelease)
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyProcessName({CONST}VAR psn: ProcessSerialNumber; VAR name: CFStringRef): OSStatus; C;

{ Values of the 'message' parameter to a Control Panel 'cdev' }

CONST
	initDev						= 0;							{ Time for cdev to initialize itself }
	hitDev						= 1;							{ Hit on one of my items }
	closeDev					= 2;							{ Close yourself }
	nulDev						= 3;							{ Null event }
	updateDev					= 4;							{ Update event }
	activDev					= 5;							{ Activate event }
	deactivDev					= 6;							{ Deactivate event }
	keyEvtDev					= 7;							{ Key down/auto key }
	macDev						= 8;							{ Decide whether or not to show up }
	undoDev						= 9;
	cutDev						= 10;
	copyDev						= 11;
	pasteDev					= 12;
	clearDev					= 13;
	cursorDev					= 14;

	{	 Special values a Control Panel 'cdev' can return 	}
	cdevGenErr					= -1;							{ General error; gray cdev w/o alert }
	cdevMemErr					= 0;							{ Memory shortfall; alert user please }
	cdevResErr					= 1;							{ Couldn't get a needed resource; alert }
	cdevUnset					= 3;							{  cdevValue is initialized to this }

	{	 Control Panel Default Proc 	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ControlPanelDefProcPtr = FUNCTION(message: INTEGER; item: INTEGER; numItems: INTEGER; cPanelID: INTEGER; VAR theEvent: EventRecord; cdevValue: LONGINT; cpDialog: DialogPtr): LONGINT;
{$ELSEC}
	ControlPanelDefProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ControlPanelDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ControlPanelDefUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppControlPanelDefProcInfo = $000FEAB0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewControlPanelDefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewControlPanelDefUPP(userRoutine: ControlPanelDefProcPtr): ControlPanelDefUPP; { old name was NewControlPanelDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeControlPanelDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeControlPanelDefUPP(userUPP: ControlPanelDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeControlPanelDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeControlPanelDefUPP(message: INTEGER; item: INTEGER; numItems: INTEGER; cPanelID: INTEGER; VAR theEvent: EventRecord; cdevValue: LONGINT; cpDialog: DialogPtr; userRoutine: ControlPanelDefUPP): LONGINT; { old name was CallControlPanelDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ProcessesIncludes}

{$ENDC} {__PROCESSES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
