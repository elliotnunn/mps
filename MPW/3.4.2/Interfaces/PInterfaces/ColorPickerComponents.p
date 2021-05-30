{
 	File:		ColorPickerComponents.p
 
 	Contains:	Color Picker Component Interfaces.
 
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
 UNIT ColorPickerComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COLORPICKERCOMPONENTS__}
{$SETC __COLORPICKERCOMPONENTS__ := 1}

{$I+}
{$SETC ColorPickerComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __COLORPICKER__}
{$I ColorPicker.p}
{$ENDC}
{	Quickdraw.p													}
{		Types.p													}
{			ConditionalMacros.p									}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	Windows.p													}
{		Memory.p												}
{		Events.p												}
{			OSUtils.p											}
{		Controls.p												}
{			Menus.p												}
{	Dialogs.p													}
{		Errors.p												}
{		TextEdit.p												}
{	CMApplication.p												}
{		Files.p													}
{			Finder.p											}
{		Printing.p												}
{		CMICCProfile.p											}
{	Balloons.p													}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kPickerComponentType		= 'cpkr';

	kInitPicker					= 0;
	kTestGraphicsWorld			= 1;
	kGetDialog					= 2;
	kGetItemList				= 3;
	kGetColor					= 4;
	kSetColor					= 5;
	kEvent						= 6;
	kEdit						= 7;
	kSetVisibility				= 8;
	kDrawPicker					= 9;
	kItemHit					= 10;
	kSetBaseItem				= 11;
	kGetProfile					= 12;
	kSetProfile					= 13;
	kGetPrompt					= 14;
	kSetPrompt					= 15;
	kGetIconData				= 16;
	kGetEditMenuState			= 17;
	kSetOrigin					= 18;
	kExtractHelpItem			= 19;


FUNCTION InitPicker(thePicker: ComponentInstance; VAR data: PickerInitData): LONGINT;
FUNCTION GetDialog(thePicker: ComponentInstance): DialogPtr;
FUNCTION TestGraphicsWorld(thePicker: ComponentInstance; VAR data: PickerInitData): LONGINT;
FUNCTION GetTheColor(thePicker: ComponentInstance; whichColor: ColorType; color: PMColorPtr): LONGINT;
FUNCTION SetTheColor(thePicker: ComponentInstance; whichColor: ColorType; color: PMColorPtr): LONGINT;
FUNCTION DoEvent(thePicker: ComponentInstance; VAR data: EventData): LONGINT;
FUNCTION DoEdit(thePicker: ComponentInstance; VAR data: EditData): LONGINT;
FUNCTION SetVisibility(thePicker: ComponentInstance; visible: BOOLEAN): LONGINT;
FUNCTION DisplayPicker(thePicker: ComponentInstance): LONGINT;
FUNCTION ItemHit(thePicker: ComponentInstance; VAR data: ItemHitData): LONGINT;
FUNCTION GetItemList(thePicker: ComponentInstance): LONGINT;
FUNCTION SetBaseItem(thePicker: ComponentInstance; baseItem: INTEGER): LONGINT;
FUNCTION GetTheProfile(thePicker: ComponentInstance): CMProfileHandle;
FUNCTION SetTheProfile(thePicker: ComponentInstance; profile: CMProfileHandle): LONGINT;
FUNCTION GetPrompt(thePicker: ComponentInstance; VAR prompt: Str255): LONGINT;
FUNCTION SetPrompt(thePicker: ComponentInstance; VAR prompt: Str255): LONGINT;
FUNCTION GetIconData(thePicker: ComponentInstance; VAR data: PickerIconData): LONGINT;
FUNCTION GetEditMenuState(thePicker: ComponentInstance; VAR mState: PickerMenuState): LONGINT;
FUNCTION SetTheOrigin(thePicker: ComponentInstance; where: Point): LONGINT;
FUNCTION ExtractHelpItem(thePicker: ComponentInstance; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: HelpItemInfo): LONGINT;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ColorPickerComponentsIncludes}

{$ENDC} {__COLORPICKERCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
