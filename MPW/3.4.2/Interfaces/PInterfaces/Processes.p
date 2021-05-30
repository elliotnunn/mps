{
 	File:		Processes.p
 
 	Contains:	Process Manager Interfaces.
 
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
 UNIT Processes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PROCESSES__}
{$SETC __PROCESSES__ := 1}

{$I+}
{$SETC ProcessesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	OSUtils.p													}
{		Memory.p												}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

TYPE
	ProcessSerialNumber = RECORD
		highLongOfPSN:			LONGINT;
		lowLongOfPSN:			LONGINT;
	END;

	ProcessSerialNumberPtr = ^ProcessSerialNumber;


CONST
{ Process identifier - Various reserved process serial numbers }
	kNoProcess					= 0;
	kSystemProcess				= 1;
	kCurrentProcess				= 2;

{ Definition of the parameter block passed to _Launch
	Typedef and flags for launchControlFlags field }
	
TYPE
	LaunchFlags = INTEGER;


CONST
{ Definition of the parameter block passed to _Launch }
	launchContinue				= $4000;
	launchNoFileFlags			= $0800;
	launchUseMinimum			= $0400;
	launchDontSwitch			= $0200;
	launchAllow24Bit			= $0100;
	launchInhibitDaemon			= $0080;

{ Format for first AppleEvent to pass to new process.  The size of the overall
  buffer variable: the message body immediately follows the messageLength }

TYPE
	AppParameters = RECORD
		theMsgEvent:			EventRecord;
		eventRefCon:			LONGINT;
		messageLength:			LONGINT;
	END;

	AppParametersPtr = ^AppParameters;

{ Parameter block to _Launch }
	LaunchParamBlockRec = RECORD
		reserved1:				LONGINT;
		reserved2:				INTEGER;
		launchBlockID:			INTEGER;
		launchEPBLength:		LONGINT;
		launchFileFlags:		INTEGER;
		launchControlFlags:		LaunchFlags;
		launchAppSpec:			FSSpecPtr;
		launchProcessSN:		ProcessSerialNumber;
		launchPreferredSize:	LONGINT;
		launchMinimumSize:		LONGINT;
		launchAvailableSize:	LONGINT;
		launchAppParameters:	AppParametersPtr;
	END;

	LaunchPBPtr = ^LaunchParamBlockRec;

{ Set launchBlockID to extendedBlock to specify that extensions exist.
 Set launchEPBLength to extendedBlockLen for compatibility.}

CONST
	extendedBlock				= $4C43;						{ 'LC' }
	extendedBlockLen			= 32;							{ sizeof(LaunchParamBlockRec) - 12 }

{ Definition of the information block returned by GetProcessInformation }
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

{ Record returned by GetProcessInformation }

TYPE
	ProcessInfoRec = RECORD
		processInfoLength:		LONGINT;
		processName:			StringPtr;
		processNumber:			ProcessSerialNumber;
		processType:			LONGINT;
		processSignature:		OSType;
		processMode:			LONGINT;
		processLocation:		Ptr;
		processSize:			LONGINT;
		processFreeMem:			LONGINT;
		processLauncher:		ProcessSerialNumber;
		processLaunchDate:		LONGINT;
		processActiveTime:		LONGINT;
		processAppSpec:			FSSpecPtr;
	END;

	ProcessInfoRecPtr = ^ProcessInfoRec;


FUNCTION LaunchApplication(LaunchParams: LaunchPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A9F2, $3E80;
	{$ENDC}
FUNCTION LaunchDeskAccessory({CONST}VAR pFileSpec: FSSpec; pDAName: ConstStr255Param): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0036, $A88F;
	{$ENDC}
FUNCTION GetCurrentProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0037, $A88F;
	{$ENDC}
FUNCTION GetFrontProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $70FF, $2F00, $3F3C, $0039, $A88F;
	{$ENDC}
FUNCTION GetNextProcess(VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0038, $A88F;
	{$ENDC}
FUNCTION GetProcessInformation({CONST}VAR PSN: ProcessSerialNumber; VAR info: ProcessInfoRec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $003A, $A88F;
	{$ENDC}
FUNCTION SetFrontProcess({CONST}VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $003B, $A88F;
	{$ENDC}
FUNCTION WakeUpProcess({CONST}VAR PSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $003C, $A88F;
	{$ENDC}
FUNCTION SameProcess({CONST}VAR PSN1: ProcessSerialNumber; {CONST}VAR PSN2: ProcessSerialNumber; VAR result: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $003D, $A88F;
	{$ENDC}
{$IFC NOT OLDROUTINELOCATIONS }
PROCEDURE ExitToShell;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9F4;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ProcessesIncludes}

{$ENDC} {__PROCESSES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
