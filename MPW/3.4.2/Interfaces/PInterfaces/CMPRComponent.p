{
 	File:		CMPRComponent.p
 
 	Contains:	ColorSync ProfileResponder Components Interface 
 
 	Version:	Technology:	ColorSync 2.0
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
 UNIT CMPRComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMPRCOMPONENT__}
{$SETC __CMPRCOMPONENT__ := 1}

{$I+}
{$SETC CMPRComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{	Files.p														}
{		OSUtils.p												}
{			Memory.p											}
{		Finder.p												}
{	Printing.p													}
{		Errors.p												}
{		Dialogs.p												}
{			Menus.p												}
{			Controls.p											}
{			Windows.p											}
{				Events.p										}
{			TextEdit.p											}
{	CMICCProfile.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	CMPRInterfaceVersion		= 0;

{ Component function selectors }
	kCMPRGetProfile				= 0;
	kCMPRSetProfile				= 1;
	kCMPRSetProfileDescription	= 2;
	kCMPRGetIndexedProfile		= 3;
	kCMPRDeleteDeviceProfile	= 4;


FUNCTION CMGetProfile(pr: ComponentInstance; aProfile: CMProfileHandle; VAR returnedProfile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 0, $7000, $A82A;
	{$ENDC}
FUNCTION CMSetProfile(pr: ComponentInstance; newProfile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 1, $7000, $A82A;
	{$ENDC}
FUNCTION CMSetProfileDescription(pr: ComponentInstance; DeviceData: LONGINT; hProfile: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 2, $7000, $A82A;
	{$ENDC}
FUNCTION CMGetIndexedProfile(pr: ComponentInstance; search: CMProfileSearchRecordHandle; VAR returnProfile: CMProfileHandle; VAR index: LONGINT): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, 3, $7000, $A82A;
	{$ENDC}
FUNCTION CMDeleteDeviceProfile(pr: ComponentInstance; deleteMe: CMProfileHandle): CMError;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 4, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMPRComponentIncludes}

{$ENDC} {__CMPRCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
