{
 	File:		LocationManager.p
 
 	Contains:	Walkabout Interfaces
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT LocationManager;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __LOCATIONMANAGER__}
{$SETC __LOCATIONMANAGER__ := 1}

{$I+}
{$SETC LocationManagerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	ALMToken							= LONGINT;
{
----------------------------------
 public error codes
}

CONST
	ALMInternalErr				= -30049;
	ALMLocationNotFound			= -30048;
	ALMNoSuchModuleErr			= -30047;
	ALMModuleCommunicationErr	= -30046;
	ALMDuplicateModuleErr		= -30045;
	ALMInstallationErr			= -30044;
	ALMDeferSwitchErr			= -30043;
	ALMLastErr					= -30043;
	ALMLastAllocatedErrNum		= -30030;

{ ------------------------------------ }
																{  ALMConfirmName reports these results }
	ALMConfirmRenameConfig		= 1;
	ALMConfirmReplaceConfig		= 2;
	kALMDefaultSwitchFlags		= 0;							{  switchFlags masks }
	kALMDontShowStatusWindow	= 1;
	kALMSignalViaAE				= 2;							{  gestalt selectors }
	gestaltALMVers				= 'walk';
	gestaltALMAttr				= 'trip';
	gestaltALMPresent			= 0;
	kALMLocationNameMaxLen		= 31;
	kALMMaxLocations			= 16;							{  arbitrary limit.  enforced by walkabout. }
	kALMNoLocationIndex			= -1;							{  index and token for the 'off' location }
	kALMNoLocationToken			= -1;							{  Notification AEvent sent to apps when location }
																{  changes. }
																{  kAESystemConfigNotice		= 'cnfg',				// (defined in Displays.i) }
	kAELocationNotice			= 'walk';						{  creator type of walkabout files }
	kALMFileCreator				= 'walk';

{ -------------------------------------------------------------------------------------- }

TYPE
	ALMNotificationProcPtr = ProcPtr;  { PROCEDURE ALMNotification(VAR theEvent: AppleEvent); }

	ALMNotificationUPP = UniversalProcPtr;

CONST
	uppALMNotificationProcInfo = $000000C0;

FUNCTION NewALMNotificationProc(userRoutine: ALMNotificationProcPtr): ALMNotificationUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallALMNotificationProc(VAR theEvent: AppleEvent; userRoutine: ALMNotificationUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
{
--------------------------------------------------------------------------------------
 dispatched trap API
}

CONST
	_ALMDispatch				= $AAA4;

FUNCTION ALMGetCurrentLocation(VAR index: INTEGER; VAR token: ALMToken; VAR name: Str31): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0600, $AAA4;
	{$ENDC}
FUNCTION ALMGetIndLocation(index: INTEGER; VAR token: ALMToken; VAR name: Str31): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0501, $AAA4;
	{$ENDC}
FUNCTION ALMCountLocations(VAR nLocations: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0202, $AAA4;
	{$ENDC}
FUNCTION ALMSwitchToLocation(newLocation: ALMToken; switchFlags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0403, $AAA4;
	{$ENDC}
FUNCTION ALMRegisterNotifyProc(notificationProc: ALMNotificationUPP; {CONST}VAR whichPSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0404, $AAA4;
	{$ENDC}
FUNCTION ALMRemoveNotifyProc(notificationProc: ALMNotificationUPP; {CONST}VAR whichPSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0405, $AAA4;
	{$ENDC}
FUNCTION ALMConfirmName(VAR msg: Str255; VAR configName: Str255; VAR choice: INTEGER; filter: ModalFilterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0806, $AAA4;
	{$ENDC}
{
--------------------------------------------------------------------------------------
 Location Manager Module API
}

CONST
	kALMComponentType			= 'walk';						{  These masks apply to the "flags" field in the ComponentDescription record.  }
	kALMMultiplePerLocation		= 1;							{  this module can be added more than once to a location }
																{  this module's settings' descriptions can change even  }
	kALMDescriptionGetsStale	= 2;							{  when the setting didn't change. }


TYPE
	ALMComponentFlagsEnum				= LONGINT;
{  These are the possible values to be returned in the 'flags' parameter of ALMSetCurrent() }

CONST
	kALMNoChange				= 0;
	kALMAvailableNow			= 1;
	kALMFinderRestart			= 2;
	kALMProcesses				= 3;
	kALMExtensions				= 4;
	kALMWarmBoot				= 5;
	kALMColdBoot				= 6;
	kALMShutdown				= 7;


TYPE
	ALMRebootFlags						= LONGINT;

CONST
	kALMScriptInfoVersion		= 2;


TYPE
	ALMScriptMgrInfoPtr = ^ALMScriptMgrInfo;
	ALMScriptMgrInfo = RECORD
		version:				INTEGER;								{  set to kALMScriptInfoVersion }
		scriptCode:				INTEGER;
		regionCode:				INTEGER;
		langCode:				INTEGER;
		fontNum:				INTEGER;
		fontSize:				INTEGER;
	END;

{
 These are prototypes for the routines that your module will implement (some are optional).
 Each prototype is given in two forms, the one you'll use depends on whether you dispatch to 
 the routine with CallComponentFunction() or CallComponentFunctionWithStorage().
 If you use CallComponentFunctionWithStorage(), you'll create the globals handle in your Open
 routine.
}
	MyGlobals							= Handle;
{  CallComponentFunction() variant }
FUNCTION MyALMGetCurrent(setting: Handle): ComponentResult;
FUNCTION MyALMSetCurrent(setting: Handle; VAR flags: ALMRebootFlags): ComponentResult;
FUNCTION MyALMCompareSetting(setting1: Handle; setting2: Handle; VAR equal: BOOLEAN): ComponentResult;
FUNCTION MyALMEditSetting(setting: Handle): ComponentResult;
FUNCTION MyALMDescribeSettings(setting: Handle; text: CharsHandle): ComponentResult;
FUNCTION MyALMDescribeError(lastErr: OSErr; VAR errStr: Str255): ComponentResult;
FUNCTION MyALMImportExport(import: BOOLEAN; setting: Handle; resRefNum: INTEGER): ComponentResult;
FUNCTION MyALMGetScriptInfo(VAR info: ALMScriptMgrInfo): ComponentResult;
FUNCTION MyALMGetInfo(VAR text: CharsHandle; VAR style: StScrpHandle; filter: ModalFilterUPP): ComponentResult;
{  CallComponentFunctionWithStorage() variant. }
FUNCTION MyALMGetCurrentStorage(g: MyGlobals; setting: Handle): ComponentResult;
FUNCTION MyALMSetCurrentStorage(g: MyGlobals; setting: Handle; VAR flags: ALMRebootFlags): ComponentResult;
FUNCTION MyALMCompareSettingStorage(g: MyGlobals; setting1: Handle; setting2: Handle; VAR equal: BOOLEAN): ComponentResult;
FUNCTION MyALMEditSettingStorage(g: MyGlobals; setting: Handle): ComponentResult;
FUNCTION MyALMDescribeSettingsStorage(g: MyGlobals; setting: Handle; text: CharsHandle): ComponentResult;
FUNCTION MyALMDescribeErrorStorage(g: MyGlobals; lastErr: OSErr; VAR errStr: Str255): ComponentResult;
FUNCTION MyALMImportExportStorage(g: MyGlobals; import: BOOLEAN; setting: Handle; resRefNum: INTEGER): ComponentResult;
FUNCTION MyALMGetScriptInfoStorage(g: MyGlobals; VAR info: ALMScriptMgrInfo): ComponentResult;
FUNCTION MyALMGetInfoStorage(g: MyGlobals; VAR text: CharsHandle; VAR style: StScrpHandle; filter: ModalFilterUPP): ComponentResult;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := LocationManagerIncludes}

{$ENDC} {__LOCATIONMANAGER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
