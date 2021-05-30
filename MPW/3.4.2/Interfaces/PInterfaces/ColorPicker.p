{
 	File:		ColorPicker.p
 
 	Contains:	Color Picker package Interfaces.
 
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
 UNIT ColorPicker;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COLORPICKER__}
{$SETC __COLORPICKER__ := 1}

{$I+}
{$SETC ColorPickerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Memory.p													}
{	Events.p													}
{		OSUtils.p												}
{	Controls.p													}
{		Menus.p													}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Errors.p													}
{	TextEdit.p													}

{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{	Files.p														}
{		Finder.p												}
{	Printing.p													}
{	CMICCProfile.p												}

{$IFC UNDEFINED __BALLOONS__}
{$I Balloons.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{Maximum small fract value, as long}
	MaxSmallFract				= $0000FFFF;

	kDefaultWidth				= 383;
	kDefaultHeight				= 238;

	kDidNothing					= 0;
	kColorChanged				= 1;
	kOkHit						= 2;
	kCancelHit					= 3;
	kNewPickerChosen			= 4;
	kApplItemHit				= 5;

	
TYPE
	PickerAction = INTEGER;


CONST
	kOriginalColor				= 0;
	kNewColor					= 1;

	
TYPE
	ColorType = INTEGER;


CONST
	kCut						= 0;
	kCopy						= 1;
	kPaste						= 2;
	kClear						= 3;
	kUndo						= 4;

	
TYPE
	EditOperation = INTEGER;


CONST
	kMouseDown					= 0;
	kKeyDown					= 1;
	kFieldEntered				= 2;
	kFieldLeft					= 3;
	kCutOp						= 4;
	kCopyOp						= 5;
	kPasteOp					= 6;
	kClearOp					= 7;
	kUndoOp						= 8;

	
TYPE
	ItemModifier = INTEGER;


CONST
	kAtSpecifiedOrigin			= 0;
	kDeepestColorScreen			= 1;
	kCenterOnMainScreen			= 2;

	
TYPE
	DialogPlacementSpec = INTEGER;


CONST
	DialogIsMoveable			= 1;
	DialogIsModal				= 2;
	CanModifyPalette			= 4;
	CanAnimatePalette			= 8;
	AppIsColorSyncAware			= 16;
	InSystemDialog				= 32;
	InApplicationDialog			= 64;
	InPickerDialog				= 128;
	DetachedFromChoices			= 256;
	CanDoColor					= 1;
	CanDoBlackWhite				= 2;
	AlwaysModifiesPalette		= 4;
	MayModifyPalette			= 8;
	PickerIsColorSyncAware		= 16;
	CanDoSystemDialog			= 32;
	CanDoApplDialog				= 64;
	HasOwnDialog				= 128;
	CanDetach					= 256;

	kNoForcast					= 0;
	kMenuChoice					= 1;
	kDialogAccept				= 2;
	kDialogCancel				= 3;
	kLeaveFocus					= 4;
	kPickerSwitch				= 5;
	kNormalKeyDown				= 6;
	kNormalMouseDown			= 7;

	
TYPE
	EventForcaster = INTEGER;

{ A SmallFract value is just the fractional part of a Fixed number,
which is the low order word.  SmallFracts are used to save room,
and to be compatible with Quickdraw's RGBColor.  They can be
assigned directly to and from INTEGERs. }
{ Unsigned fraction between 0 and 1 }
	SmallFract = INTEGER;

{ For developmental simplicity in switching between the HLS and HSV
models, HLS is reordered into HSL. Thus both models start with
hue and saturation values; value/lightness/brightness is last. }
	HSVColor = RECORD
		hue:					SmallFract;								{Fraction of circle, red at 0}
		saturation:				SmallFract;								{0-1, 0 for gray, 1 for pure color}
		value:					SmallFract;								{0-1, 0 for black, 1 for max intensity}
	END;

	HSLColor = RECORD
		hue:					SmallFract;								{Fraction of circle, red at 0}
		saturation:				SmallFract;								{0-1, 0 for gray, 1 for pure color}
		lightness:				SmallFract;								{0-1, 0 for black, 1 for white}
	END;

	CMYColor = RECORD
		cyan:					SmallFract;
		magenta:				SmallFract;
		yellow:					SmallFract;
	END;

	PMColor = RECORD
		profile:				CMProfileHandle;
		color:					CMColor;
	END;

	PMColorPtr = ^PMColor;

	picker = Ptr;

	PickerIconData = RECORD
		scriptCode:				INTEGER;
		iconSuiteID:			INTEGER;
		helpResType:			ResType;
		helpResID:				INTEGER;
	END;

	PickerInitData = RECORD
		pickerDialog:			DialogPtr;
		choicesDialog:			DialogPtr;
		flags:					LONGINT;
		yourself:				picker;
	END;

	PickerMenuItemInfo = RECORD
		editMenuID:				INTEGER;
		cutItem:				INTEGER;
		copyItem:				INTEGER;
		pasteItem:				INTEGER;
		clearItem:				INTEGER;
		undoItem:				INTEGER;
	END;

	PickerMenuState = RECORD
		cutEnabled:				BOOLEAN;
		copyEnabled:			BOOLEAN;
		pasteEnabled:			BOOLEAN;
		clearEnabled:			BOOLEAN;
		undoEnabled:			BOOLEAN;
		undoString:				Str255;
	END;

	ColorChangedProcPtr = ProcPtr;  { PROCEDURE ColorChanged(userData: LONGINT; VAR newColor: PMColor); }
	UserEventProcPtr = ProcPtr;  { FUNCTION UserEvent(VAR event: EventRecord): BOOLEAN; }
	ColorChangedUPP = UniversalProcPtr;
	UserEventUPP = UniversalProcPtr;

	ColorPickerInfo = RECORD
		theColor:				PMColor;
		dstProfile:				CMProfileHandle;
		flags:					LONGINT;
		placeWhere:				DialogPlacementSpec;
		dialogOrigin:			Point;
		pickerType:				LONGINT;
		eventProc:				UserEventUPP;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		prompt:					Str255;
		mInfo:					PickerMenuItemInfo;
		newColorChosen:			BOOLEAN;
		filler:					SInt8;
	END;

	SystemDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		placeWhere:				DialogPlacementSpec;
		dialogOrigin:			Point;
		mInfo:					PickerMenuItemInfo;
	END;

	PickerDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		dialogOrigin:			^Point;
		mInfo:					PickerMenuItemInfo;
	END;

	ApplicationDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		theDialog:				DialogPtr;
		pickerOrigin:			Point;
		mInfo:					PickerMenuItemInfo;
	END;

	EventData = RECORD
		event:					^EventRecord;
		action:					PickerAction;
		itemHit:				INTEGER;
		handled:				BOOLEAN;
		filler:					SInt8;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		forcast:				EventForcaster;
	END;

	EditData = RECORD
		theEdit:				EditOperation;
		action:					PickerAction;
		handled:				BOOLEAN;
		filler:					SInt8;
	END;

	ItemHitData = RECORD
		itemHit:				INTEGER;
		iMod:					ItemModifier;
		action:					PickerAction;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		where:					Point;
	END;

	HelpItemInfo = RECORD
		options:				LONGINT;
		tip:					Point;
		altRect:				Rect;
		theProc:				INTEGER;
		helpVariant:			INTEGER;
		helpMessage:			HMMessageRecord;
	END;

{	Below are the color conversion routines.}

FUNCTION Fix2SmallFract(f: Fixed): SmallFract;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0001, $A82E;
	{$ENDC}
FUNCTION SmallFract2Fix(s: SmallFract): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0002, $A82E;
	{$ENDC}
PROCEDURE CMY2RGB({CONST}VAR cColor: CMYColor; VAR rColor: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0003, $A82E;
	{$ENDC}
PROCEDURE RGB2CMY({CONST}VAR rColor: RGBColor; VAR cColor: CMYColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A82E;
	{$ENDC}
PROCEDURE HSL2RGB({CONST}VAR hColor: HSLColor; VAR rColor: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0005, $A82E;
	{$ENDC}
PROCEDURE RGB2HSL({CONST}VAR rColor: RGBColor; VAR hColor: HSLColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $A82E;
	{$ENDC}
PROCEDURE HSV2RGB({CONST}VAR hColor: HSVColor; VAR rColor: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0007, $A82E;
	{$ENDC}
PROCEDURE RGB2HSV({CONST}VAR rColor: RGBColor; VAR hColor: HSVColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0008, $A82E;
	{$ENDC}
{	Below brings up the ColorPicker 1.0 Dialog}
FUNCTION GetColor(where: Point; prompt: ConstStr255Param; {CONST}VAR inColor: RGBColor; VAR outColor: RGBColor): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0009, $A82E;
	{$ENDC}
{	Below are the ColorPicker 2.0 routines.}
FUNCTION PickColor(VAR theColorInfo: ColorPickerInfo): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0213, $A82E;
	{$ENDC}
FUNCTION AddPickerToDialog(VAR info: ApplicationDialogInfo; VAR thePicker: picker): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0414, $A82E;
	{$ENDC}
FUNCTION CreateColorDialog(VAR info: SystemDialogInfo; VAR thePicker: picker): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0415, $A82E;
	{$ENDC}
FUNCTION CreatePickerDialog(VAR info: PickerDialogInfo; VAR thePicker: picker): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0416, $A82E;
	{$ENDC}
FUNCTION DisposeColorPicker(thePicker: picker): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0217, $A82E;
	{$ENDC}
FUNCTION GetPickerVisibility(thePicker: picker; VAR visible: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0418, $A82E;
	{$ENDC}
FUNCTION SetPickerVisibility(thePicker: picker; visible: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0319, $A82E;
	{$ENDC}
FUNCTION SetPickerPrompt(thePicker: picker; VAR promptString: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $041a, $A82E;
	{$ENDC}
FUNCTION DoPickerEvent(thePicker: picker; VAR data: EventData): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $041b, $A82E;
	{$ENDC}
FUNCTION DoPickerEdit(thePicker: picker; VAR data: EditData): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $041c, $A82E;
	{$ENDC}
FUNCTION DoPickerDraw(thePicker: picker): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $021d, $A82E;
	{$ENDC}
FUNCTION GetPickerColor(thePicker: picker; whichColor: ColorType; VAR color: PMColor): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $051e, $A82E;
	{$ENDC}
FUNCTION SetPickerColor(thePicker: picker; whichColor: ColorType; VAR color: PMColor): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $051f, $A82E;
	{$ENDC}
FUNCTION GetPickerOrigin(thePicker: picker; VAR where: Point): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0420, $A82E;
	{$ENDC}
FUNCTION SetPickerOrigin(thePicker: picker; where: Point): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0421, $A82E;
	{$ENDC}
FUNCTION GetPickerProfile(thePicker: picker; VAR profile: CMProfileHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0422, $A82E;
	{$ENDC}
FUNCTION SetPickerProfile(thePicker: picker; profile: CMProfileHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0423, $A82E;
	{$ENDC}
FUNCTION GetPickerEditMenuState(thePicker: picker; VAR mState: PickerMenuState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0424, $A82E;
	{$ENDC}
FUNCTION ExtractPickerHelpItem(thePicker: picker; itemNo: INTEGER; whichState: INTEGER; VAR helpInfo: HelpItemInfo): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0625, $A82E;
	{$ENDC}
CONST
	uppColorChangedProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }
	uppUserEventProcInfo = $000000D0; { FUNCTION (4 byte param): 1 byte result; }

FUNCTION NewColorChangedProc(userRoutine: ColorChangedProcPtr): ColorChangedUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUserEventProc(userRoutine: UserEventProcPtr): UserEventUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallColorChangedProc(userData: LONGINT; VAR newColor: PMColor; userRoutine: ColorChangedUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallUserEventProc(VAR event: EventRecord; userRoutine: UserEventUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ColorPickerIncludes}

{$ENDC} {__COLORPICKER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
