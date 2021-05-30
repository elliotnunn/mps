{
     File:       AppleScript.p
 
     Contains:   AppleScript Specific Interfaces.
 
     Version:    Technology: AppleScript 1.1
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
 UNIT AppleScript;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLESCRIPT__}
{$SETC __APPLESCRIPT__ := 1}

{$I+}
{$SETC AppleScriptIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __OSA__}
{$I OSA.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*************************************************************************
    Types and Constants
*************************************************************************}
{
    The specific type for the AppleScript instance of the
    Open Scripting Architecture type.
}

CONST
	typeAppleScript				= 'ascr';
	kAppleScriptSubtype			= 'ascr';
	typeASStorage				= 'ascr';

	{	*************************************************************************
	    Component Selectors
	*************************************************************************	}

	kASSelectInit				= $1001;
	kASSelectSetSourceStyles	= $1002;
	kASSelectGetSourceStyles	= $1003;
	kASSelectGetSourceStyleNames = $1004;


	{	*************************************************************************
	    OSAGetScriptInfo Selectors
	*************************************************************************	}
	kASHasOpenHandler			= 'hsod';

	{	
	        This selector is used to query a context as to whether it contains
	        a handler for the kAEOpenDocuments event. This allows "applets" to be 
	        distinguished from "droplets."  OSAGetScriptInfo returns false if
	        there is no kAEOpenDocuments handler, and returns the error value 
	        errOSAInvalidAccess if the input is not a context.
	    	}
	{	*************************************************************************
	    Initialization
	*************************************************************************	}
	{
	 *  ASInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION ASInit(scriptingComponent: ComponentInstance; modeFlags: LONGINT; minStackSize: LONGINT; preferredStackSize: LONGINT; maxStackSize: LONGINT; minHeapSize: LONGINT; preferredHeapSize: LONGINT; maxHeapSize: LONGINT): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $1001, $7000, $A82A;
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
        errOSASystemError       initialization failed
    }
{
    These values will be used if ASInit is not called explicitly, or if any
    of ASInit's parameters are zero:
}

CONST
	kASDefaultMinStackSize		= 4096;
	kASDefaultPreferredStackSize = 16384;
	kASDefaultMaxStackSize		= 16384;
	kASDefaultMinHeapSize		= 4096;
	kASDefaultPreferredHeapSize	= 16384;
	kASDefaultMaxHeapSize		= 33554432;

	{	*************************************************************************
	    Source Styles
	*************************************************************************	}
	{
	 *  ASSetSourceStyles()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION ASSetSourceStyles(scriptingComponent: ComponentInstance; sourceStyles: STHandle): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $1002, $7000, $A82A;
	{$ENDC}

{
        ComponentCallNow(kASSelectSetSourceStyles, 4);
        Errors:
        errOSASystemError       operation failed
    }
{
 *  ASGetSourceStyles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ASGetSourceStyles(scriptingComponent: ComponentInstance; VAR resultingSourceStyles: STHandle): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $1003, $7000, $A82A;
	{$ENDC}

{
        ComponentCallNow(kASSelectGetSourceStyles, 4);
        Errors:
        errOSASystemError       operation failed
    }
{
 *  ASGetSourceStyleNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ASGetSourceStyleNames(scriptingComponent: ComponentInstance; modeFlags: LONGINT; VAR resultingSourceStyleNamesList: AEDescList): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $1004, $7000, $A82A;
	{$ENDC}

{
        ComponentCallNow(kASSelectGetSourceStyleNames, 8);
        This call returns an AEList of styled text descriptors the names of the
        source styles in the current dialect.  The order of the names corresponds
        to the order of the source style constants, below.  The style of each
        name is the same as the styles returned by ASGetSourceStyles.
        
        Errors:
        errOSASystemError       operation failed
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


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleScriptIncludes}

{$ENDC} {__APPLESCRIPT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
