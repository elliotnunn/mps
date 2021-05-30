{
 	File:		AppleScript.p
 
 	Contains:	AppleScript Specific Interfaces.
 
 	Version:	Technology:	AppleScript 1.1
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
 UNIT AppleScript;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLESCRIPT__}
{$SETC __APPLESCRIPT__ := 1}

{$I+}
{$SETC AppleScriptIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Types.p														}
{	Memory.p													}
{		MixedMode.p												}
{	OSUtils.p													}
{	Events.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __OSA__}
{$I OSA.p}
{$ENDC}
{	AEObjects.p													}
{	Components.p												}

{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	typeAppleScript				= 'ascr';
	kAppleScriptSubtype			= typeAppleScript;
	typeASStorage				= typeAppleScript;

{*************************************************************************
	Component Selectors
*************************************************************************}
	kASSelectInit				= $1001;
	kASSelectSetSourceStyles	= $1002;
	kASSelectGetSourceStyles	= $1003;
	kASSelectGetSourceStyleNames = $1004;

{*************************************************************************
	OSAGetScriptInfo Selectors
*************************************************************************}
	kASHasOpenHandler			= 'hsod';

{
		This selector is used to query a context as to whether it contains
		a handler for the kAEOpenDocuments event. This allows "applets" to be 
		distinguished from "droplets."  OSAGetScriptInfo returns false if
		there is no kAEOpenDocuments handler, and returns the error value 
		errOSAInvalidAccess if the input is not a context.
	}
{*************************************************************************
	Initialization
*************************************************************************}

FUNCTION ASInit(scriptingComponent: ComponentInstance; modeFlags: LONGINT; minStackSize: LONGINT; preferredStackSize: LONGINT; maxStackSize: LONGINT; minHeapSize: LONGINT; preferredHeapSize: LONGINT; maxHeapSize: LONGINT): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $1C, $1001, $7000, $A82A;
	{$ENDC}
{
		ComponentCallNow(kASSelectInit, 28);
		This call can be used to explicitly initialize AppleScript.  If it is
		not called, the a scripting size resource is looked for and used. If
		there is no scripting size resource, then the constants listed below
		are used.  If at any stage (the init call, the size resource, the 
		defaults) any of these parameters are zero, then parameters from the
		next stage are used.  ModeFlags are not currently used.
		Errors:
		errOSASystemError		initialization failed
	}
{
	These values will be used if ASInit is not called explicitly, or if any
	of ASInit's parameters are zero:
}

CONST
	kASDefaultMinStackSize		= 4 * 1024;
	kASDefaultPreferredStackSize = 16 * 1024;
	kASDefaultMaxStackSize		= 16 * 1024;
	kASDefaultMinHeapSize		= 4 * 1024;
	kASDefaultPreferredHeapSize	= 16 * 1024;
	kASDefaultMaxHeapSize		= 32 * 1024 * 1024;

{*************************************************************************
	Source Styles
*************************************************************************}

FUNCTION ASSetSourceStyles(scriptingComponent: ComponentInstance; sourceStyles: STHandle): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $4, $1002, $7000, $A82A;
	{$ENDC}
{
		ComponentCallNow(kASSelectSetSourceStyles, 4);
		Errors:
		errOSASystemError		operation failed
	}
FUNCTION ASGetSourceStyles(scriptingComponent: ComponentInstance; VAR resultingSourceStyles: STHandle): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $4, $1003, $7000, $A82A;
	{$ENDC}
{
		ComponentCallNow(kASSelectGetSourceStyles, 4);
		Errors:
		errOSASystemError		operation failed
	}
FUNCTION ASGetSourceStyleNames(scriptingComponent: ComponentInstance; modeFlags: LONGINT; VAR resultingSourceStyleNamesList: AEDescList): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8, $1004, $7000, $A82A;
	{$ENDC}
{
		ComponentCallNow(kASSelectGetSourceStyleNames, 8);
		This call returns an AEList of styled text descriptors the names of the
		source styles in the current dialect.  The order of the names corresponds
		to the order of the source style constants, below.  The style of each
		name is the same as the styles returned by ASGetSourceStyles.
		
		Errors:
		errOSASystemError		operation failed
	}
{
	Elements of STHandle correspond to following categories of tokens, and
	accessed through following index constants:
}

CONST
	kASSourceStyleUncompiledText = 0;
	kASSourceStyleNormalText	= 1;
	kASSourceStyleLanguageKeyword = 2;
	kASSourceStyleApplicationKeyword = 3;
	kASSourceStyleComment		= 4;
	kASSourceStyleLiteral		= 5;
	kASSourceStyleUserSymbol	= 6;
	kASSourceStyleObjectSpecifier = 7;
	kASNumberOfSourceStyles		= 8;

{ Gestalt selectors for AppleScript }
	gestaltAppleScriptAttr		= 'ascr';
	gestaltAppleScriptVersion	= 'ascv';

	gestaltAppleScriptPresent	= 0;
	gestaltAppleScriptPowerPCSupport = 1;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleScriptIncludes}

{$ENDC} {__APPLESCRIPT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
