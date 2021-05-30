{
////////////////////////////////////////////////////////////////////////////////
// OPEN SCRIPTING ARCHITECTURE: AppleScript Debugging Interface
////////////////////////////////////////////////////////////////////////////////
// Copyright © 1993 Apple Computer, Inc. All rights reserved.
// Author: Warren Harris
////////////////////////////////////////////////////////////////////////////////
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT ASDEBUGGING;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingASDEBUGGING}
{$SETC UsingASDEBUGGING := 1}

{$I+}
{$SETC ASDEBUGGINGIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingAppleScript}
{$I $$Shell(PInterfaces)AppleScript.p}
{$ENDC}
{$SETC UsingIncludes := ASDEBUGGINGIncludes}

{
////////////////////////////////////////////////////////////////////////////////
// Mode Flags
////////////////////////////////////////////////////////////////////////////////
}

const
	kOSAModeDontDefine						= $0001;

{
////////////////////////////////////////////////////////////////////////////////
// Component Selectors
////////////////////////////////////////////////////////////////////////////////
}

const
	kASSelectSetProperty					= $1106;
	kASSelectGetProperty					= $1107;
	kASSelectSetHandler						= $1108;
	kASSelectGetHandler						= $1109;
	kASSelectGetAppTerminology				= $110A;
	kASSelectGetSysTerminology				= $110B;
	kASSelectGetPropertyNames				= $110C;
	kASSelectGetHandlerNames				= $110D;

{
////////////////////////////////////////////////////////////////////////////////
// Context Accessors
////////////////////////////////////////////////////////////////////////////////
}

FUNCTION
OSASetProperty(scriptingComponent	: ComponentInstance;
			   modeFlags			: LONGINT;
			   contextID			: OSAID;
			   variableName			: AEDesc;
			   scriptValueID		: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $1106, $7000, $A82A;

FUNCTION
OSAGetProperty(scriptingComponent	: ComponentInstance;
			   modeFlags			: LONGINT;
			   contextID			: OSAID;
			   variableName			: AEDesc;
			   VAR scriptValueID	: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $1107, $7000, $A82A;

FUNCTION
OSAGetPropertyNames(scriptingComponent	: ComponentInstance;
			   modeFlags			: LONGINT;
			   contextID			: OSAID;
			   VAR handlerNames		: AEDescList)
	: OSAError;
    INLINE $2F3C, $000C, $110C, $7000, $A82A;

FUNCTION
OSASetHandler(scriptingComponent	: ComponentInstance;
			   modeFlags			: LONGINT;
			   contextID			: OSAID;
			   handlerName			: AEDesc;
			   compiledScriptID		: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $1108, $7000, $A82A;

FUNCTION
OSAGetHandler(scriptingComponent	: ComponentInstance;
			   modeFlags			: LONGINT;
			   contextID			: OSAID;
			   handlerName			: AEDesc;
			   VAR compiledScriptID	: OSAID)
	: OSAError;
    INLINE $2F3C, $0010, $1109, $7000, $A82A;

FUNCTION
OSAGetHandlerNames(scriptingComponent	: ComponentInstance;
			   modeFlags			: LONGINT;
			   contextID			: OSAID;
			   VAR handlerNames		: AEDescList)
	: OSAError;
    INLINE $2F3C, $000C, $110D, $7000, $A82A;

FUNCTION
OSAGetAppTerminology(scriptingComponent		: ComponentInstance;
					 modeFlags				: LONGINT;
			 		 fileSpec				: FSSpec;		
					 terminologyID			: INTEGER;
					 VAR didLaunch			: Boolean;
					 VAR terminologyList	: AEDesc)
	: OSAError;
    INLINE $2F3C, $0012, $110A, $7000, $A82A;

FUNCTION
OSAGetSysTerminology(scriptingComponent		: ComponentInstance;
					 modeFlags				: LONGINT;
					 terminologyID			: INTEGER;
					 VAR terminologyList	: AEDesc)
	: OSAError;
    INLINE $2F3C, $000A, $110B, $7000, $A82A;

{
////////////////////////////////////////////////////////////////////////////////
}
{$ENDC}    { UsingASDEBUGGING }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}
{
////////////////////////////////////////////////////////////////////////////////
}
