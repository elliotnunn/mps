{
     File:       IBCarbonRuntime.p
 
     Contains:   Nib support for Carbon
 
     Version:    Technology: CarbonLib 1.1/Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT IBCarbonRuntime;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __IBCARBONRUNTIME__}
{$SETC __IBCARBONRUNTIME__ := 1}

{$I+}
{$SETC IBCarbonRuntimeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFBUNDLE__}
{$I CFBundle.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLDEFINITIONS__}
{$I ControlDefinitions.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kIBCarbonRuntimeCantFindNibFile = -10960;
	kIBCarbonRuntimeObjectNotOfRequestedType = -10961;
	kIBCarbonRuntimeCantFindObject = -10962;

	{	 ----- typedef ------ 	}

TYPE
	IBNibRef    = ^LONGINT; { an opaque 32-bit type }
	IBNibRefPtr = ^IBNibRef;  { when a VAR xx:IBNibRef parameter can be nil, it is changed to xx: IBNibRefPtr }
	{	 ----- Create & Dispose NIB References ------ 	}
	{
	 *  CreateNibReference()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateNibReference(inNibName: CFStringRef; VAR outNibRef: IBNibRef): OSStatus; C;

{
 *  CreateNibReferenceWithCFBundle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateNibReferenceWithCFBundle(inBundle: CFBundleRef; inNibName: CFStringRef; VAR outNibRef: IBNibRef): OSStatus; C;

{
 *  DisposeNibReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeNibReference(inNibRef: IBNibRef); C;

{ ----- Window ------ }
{
 *  CreateWindowFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateWindowFromNib(inNibRef: IBNibRef; inName: CFStringRef; VAR outWindow: WindowRef): OSStatus; C;

{  ----- Menu ----- }

{
 *  CreateMenuFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateMenuFromNib(inNibRef: IBNibRef; inName: CFStringRef; VAR outMenuRef: MenuRef): OSStatus; C;

{  ----- MenuBar ------ }

{
 *  CreateMenuBarFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateMenuBarFromNib(inNibRef: IBNibRef; inName: CFStringRef; VAR outMenuBar: Handle): OSStatus; C;

{
 *  SetMenuBarFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuBarFromNib(inNibRef: IBNibRef; inName: CFStringRef): OSStatus; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IBCarbonRuntimeIncludes}

{$ENDC} {__IBCARBONRUNTIME__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
