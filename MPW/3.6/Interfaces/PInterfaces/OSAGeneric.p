{
     File:       OSAGeneric.p
 
     Contains:   AppleScript Generic Component Interfaces.
 
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
 UNIT OSAGeneric;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OSAGENERIC__}
{$SETC __OSAGENERIC__ := 1}

{$I+}
{$SETC OSAGenericIncludes := UsingIncludes}
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


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{    NOTE:   This interface defines a "generic scripting component."
            The Generic Scripting Component allows automatic dispatch to a
            specific scripting component that conforms to the OSA interface.
            This component supports OSA, by calling AppleScript or some other 
            scripting component.  Additionally it provides access to the default
            and the user-prefered scripting component.
}



CONST
																{  Component version this header file describes  }
	kGenericComponentVersion	= $0100;

	kGSSSelectGetDefaultScriptingComponent = $1001;
	kGSSSelectSetDefaultScriptingComponent = $1002;
	kGSSSelectGetScriptingComponent = $1003;
	kGSSSelectGetScriptingComponentFromStored = $1004;
	kGSSSelectGenericToRealID	= $1005;
	kGSSSelectRealToGenericID	= $1006;
	kGSSSelectOutOfRange		= $1007;


TYPE
	ScriptingComponentSelector			= OSType;
	GenericID							= OSAID;
	{	 get and set the default scripting component 	}
	{
	 *  OSAGetDefaultScriptingComponent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OSAGetDefaultScriptingComponent(genericScriptingComponent: ComponentInstance; VAR scriptingSubType: ScriptingComponentSelector): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $1001, $7000, $A82A;
	{$ENDC}

{
 *  OSASetDefaultScriptingComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSASetDefaultScriptingComponent(genericScriptingComponent: ComponentInstance; scriptingSubType: ScriptingComponentSelector): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $1002, $7000, $A82A;
	{$ENDC}

{ get a scripting component instance from its subtype code }
{
 *  OSAGetScriptingComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetScriptingComponent(genericScriptingComponent: ComponentInstance; scriptingSubType: ScriptingComponentSelector; VAR scriptingInstance: ComponentInstance): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $1003, $7000, $A82A;
	{$ENDC}

{ get a scripting component selector (subType) from a stored script }
{
 *  OSAGetScriptingComponentFromStored()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGetScriptingComponentFromStored(genericScriptingComponent: ComponentInstance; {CONST}VAR scriptData: AEDesc; VAR scriptingSubType: ScriptingComponentSelector): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $1004, $7000, $A82A;
	{$ENDC}

{ get a real component instance and script id from a generic id }
{
 *  OSAGenericToRealID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSAGenericToRealID(genericScriptingComponent: ComponentInstance; VAR theScriptID: OSAID; VAR theExactComponent: ComponentInstance): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $1005, $7000, $A82A;
	{$ENDC}

{ get a generic id from a real component instance and script id }
{
 *  OSARealToGenericID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OSARealToGenericID(genericScriptingComponent: ComponentInstance; VAR theScriptID: OSAID; theExactComponent: ComponentInstance): OSAError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $1006, $7000, $A82A;
	{$ENDC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSAGenericIncludes}

{$ENDC} {__OSAGENERIC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
