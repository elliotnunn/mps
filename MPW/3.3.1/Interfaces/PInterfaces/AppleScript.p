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
    UNIT AppleScript;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingAppleScript}
{$SETC UsingAppleScript := 1}

{$I+}
{$SETC AppleScriptIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingAppleEvents}
{$I $$Shell(PInterfaces)AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED UsingComponents}
{$I $$Shell(PInterfaces)Components.p}
{$ENDC}
{$IFC UNDEFINED UsingOSA}
{$I $$Shell(PInterfaces)OSA.p}
{$ENDC}
{$IFC UNDEFINED UsingTextEdit}
{$I $$Shell(PInterfaces)TextEdit.p}
{$ENDC}
{$SETC UsingIncludes := AppleScriptIncludes}

{ Types and Constants }
CONST
	typeAppleScript						= 'ascr';
	kAppleScriptSubtype					= typeAppleScript;
	typeASStorage						= typeAppleScript;

{ Error Codes }
CONST
	{ Runtime errors }
	errASCantConsiderAndIgnore			= -2720;
	errASCantCompareMoreThan32k			= -2721;

	{ Compiler errors }
	errASTerminologyNestingTooDeep		= -2760;
	errASIllegalFormalParameter			= -2761;
	errASParameterNotForEvent			= -2762;
	errASNoResultReturned				= -2763;
	
	{ Dialect specific errors }
	{ The range -2780 thru -2799 is reserved for dialect specific error codes. }
	{ (Error codes from different dialects may overlap.) }
	
	{ English errors }
	errASInconsistentNames				= -2780;

{ Component Selectors }
	kASSelectInit					= $1001;
	kASSelectSetSourceStyles		= $1002;
	kASSelectGetSourceStyles		= $1003;
	kASSelectGetSourceStyleNames	= $1004;

{ OSAGetScriptInfo Selectors }
	kASHasOpenHandler				= 'hsod';

{ Initialization }

FUNCTION
ASInit(scriptingComponent	: ComponentInstance;
	   modeFlags			: LONGINT;
	   minStackSize			: LONGINT;
	   preferredStackSize	: LONGINT;
	   maxStackSize			: LONGINT;
	   minHeapSize			: LONGINT;
	   preferredHeapSize	: LONGINT;
	   maxHeapSize			: LONGINT)
	: OSAError;
    INLINE $2F3C, $001C, $1001, $7000, $A82A;

{ Default Initialization Parameters }
CONST
	kASDefaultMinStackSize				=  4 * 1024;
	kASDefaultPreferredStackSize		= 16 * 1024;
	kASDefaultMaxStackSize				= 16 * 1024;
	kASDefaultMinHeapSize				=  4 * 1024;
	kASDefaultPreferredHeapSize			= 16 * 1024;
	kASDefaultMaxHeapSize				= 32 * 1024 * 1024;

{ Source Styles }

FUNCTION
ASSetSourceStyles(scriptingComponent	: ComponentInstance;
				  sourceStyles			: STHandle)
	: OSAError;
    INLINE $2F3C, $0004, $1002, $7000, $A82A;

FUNCTION
ASGetSourceStyles(scriptingComponent		: ComponentInstance;
				  VAR resultingSourceStyles	: STHandle)
	: OSAError;
    INLINE $2F3C, $0004, $1003, $7000, $A82A;

FUNCTION
ASGetSourceStyleNames(scriptingComponent				: ComponentInstance;
					  modeFlags							: LONGINT;
					  VAR resultingSourceStyleNamesList	: AEDescList)
	: OSAError;
    INLINE $2F3C, $0008, $1004, $7000, $A82A;

CONST
	kASSourceStyleUncompiledText			= 0;
	kASSourceStyleNormalText				= 1;
	kASSourceStyleLanguageKeyword			= 2;
	kASSourceStyleApplicationKeyword		= 3;
	kASSourceStyleComment					= 4;
	kASSourceStyleLiteral					= 5;
	kASSourceStyleUserSymbol				= 6;
	kASSourceStyleObjectSpecifier			= 7;
	kASNumberOfSourceStyles					= 8;

{$ENDC}    { UsingAppleScript }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}
