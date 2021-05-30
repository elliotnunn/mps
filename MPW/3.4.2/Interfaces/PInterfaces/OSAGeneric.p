{
 	File:		OSAGeneric.p
 
 	Contains:	AppleScript Generic Component Interfaces.
 
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
 UNIT OSAGeneric;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OSAGENERIC__}
{$SETC __OSAGENERIC__ := 1}

{$I+}
{$SETC OSAGenericIncludes := UsingIncludes}
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

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{ 	NOTE:	This interface defines a "generic scripting component."
			The Generic Scripting Component allows automatic dispatch to a
			specific scripting component that conforms to the OSA interface.
			This component supports OSA, by calling AppleScript or some other 
			scripting component.  Additionally it provides access to the default
			and the user-prefered scripting component.
}

CONST
{ Component version this header file describes }
	kGenericComponentVersion	= $0100;

	kGSSSelectGetDefaultScriptingComponent = $1001;
	kGSSSelectSetDefaultScriptingComponent = $1002;
	kGSSSelectGetScriptingComponent = $1003;
	kGSSSelectGetScriptingComponentFromStored = $1004;
	kGSSSelectGenericToRealID	= $1005;
	kGSSSelectRealToGenericID	= $1006;
	kGSSSelectOutOfRange		= $1007;

	
TYPE
	ScriptingComponentSelector = OSType;

	GenericID = OSAID;

{ get and set the default scripting component }

FUNCTION OSAGetDefaultScriptingComponent(genericScriptingComponent: ComponentInstance; VAR scriptingSubType: ScriptingComponentSelector): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, $1001, $7000, $A82A;
	{$ENDC}
FUNCTION OSASetDefaultScriptingComponent(genericScriptingComponent: ComponentInstance; scriptingSubType: ScriptingComponentSelector): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, $1002, $7000, $A82A;
	{$ENDC}
{ get a scripting component instance from its subtype code }
FUNCTION OSAGetScriptingComponent(genericScriptingComponent: ComponentInstance; scriptingSubType: ScriptingComponentSelector; VAR scriptingInstance: ComponentInstance): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, $1003, $7000, $A82A;
	{$ENDC}
{ get a scripting component selector (subType) from a stored script }
FUNCTION OSAGetScriptingComponentFromStored(genericScriptingComponent: ComponentInstance; {CONST}VAR scriptData: AEDesc; VAR scriptingSubType: ScriptingComponentSelector): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, $1004, $7000, $A82A;
	{$ENDC}
{ get a real component instance and script id from a generic id }
FUNCTION OSAGenericToRealID(genericScriptingComponent: ComponentInstance; VAR theScriptID: OSAID; VAR theExactComponent: ComponentInstance): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, $1005, $7000, $A82A;
	{$ENDC}
{ get a generic id from a real component instance and script id }
FUNCTION OSARealToGenericID(genericScriptingComponent: ComponentInstance; VAR theScriptID: OSAID; theExactComponent: ComponentInstance): OSAError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, $1006, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSAGenericIncludes}

{$ENDC} {__OSAGENERIC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
