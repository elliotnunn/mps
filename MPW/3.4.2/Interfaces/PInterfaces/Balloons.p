{
 	File:		Balloons.p
 
 	Contains:	Balloon Help Package Interfaces.
 
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
 UNIT Balloons;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __BALLOONS__}
{$SETC __BALLOONS__ := 1}

{$I+}
{$SETC BalloonsIncludes := UsingIncludes}
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

{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{	Memory.p													}

{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}

{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	hmBalloonHelpVersion		= $0002;						{ The real version of the Help Manager }
	kHMHelpMenuID				= -16490;						{ Resource ID and menu ID of help menu }
	kHMAboutHelpItem			= 1;							{ help menu item number of About Balloon Help… }
	kHMShowBalloonsItem			= 3;							{ help menu item number of Show/Hide Balloons }
	kHMHelpID					= -5696;						{ ID of various Help Mgr package resources (in Pack14 range) }
	kBalloonWDEFID				= 126;							{ Resource ID of the WDEF proc used in standard balloons }
{ Dialog item template type constant }
	helpItem					= 1;							{ key value in DITL template that corresponds to the help item }
{ Options for Help Manager resources in 'hmnu', 'hdlg', 'hrct', 'hovr', & 'hfdr' resources }
	hmDefaultOptions			= 0;							{ default options for help manager resources }
	hmUseSubID					= 1;							{ treat resID's in resources as subID's of driver base ID (for Desk Accessories) }
	hmAbsoluteCoords			= 2;							{ ignore window port origin and treat rectangles as absolute coords (local to window) }

	hmSaveBitsNoWindow			= 4;							{ don't create a window, just blast bits on screen. No update event is generated }
	hmSaveBitsWindow			= 8;							{ create a window, but restore bits behind window when window goes away & generate update event }
	hmMatchInTitle				= 16;							{ for hwin resources, match string anywhere in window title string }
{ Constants for Help Types in 'hmnu', 'hdlg', 'hrct', 'hovr', & 'hfdr' resources }
	kHMStringItem				= 1;							{ pstring used in resource }
	kHMPictItem					= 2;							{ 'PICT' ResID used in resource }
	kHMStringResItem			= 3;							{ 'STR#' ResID & index used in resource }
	kHMTEResItem				= 6;							{ Styled Text Edit ResID used in resource ('TEXT' & 'styl') }
	kHMSTRResItem				= 7;							{ 'STR ' ResID used in resource }
	kHMSkipItem					= 256;							{ don't display a balloon }
	kHMCompareItem				= 512;							{ Compare pstring in menu item w/ PString in resource item ('hmnu' only) }
	kHMNamedResourceItem		= 1024;							{ Use pstring in menu item to get 'STR#', 'PICT', or 'STR ' resource ('hmnu' only) }
	kHMTrackCntlItem			= 2048;							{ Reserved }
{ Constants for hmmHelpType's when filling out HMMessageRecord }
	khmmString					= 1;							{ help message contains a PString }
	khmmPict					= 2;							{ help message contains a resource ID to a 'PICT' resource }
	khmmStringRes				= 3;							{ help message contains a res ID & index to a 'STR#' resource }
	khmmTEHandle				= 4;							{ help message contains a Text Edit handle }
	khmmPictHandle				= 5;							{ help message contains a Picture handle }
	khmmTERes					= 6;							{ help message contains a res ID to 'TEXT' & 'styl' resources }
	khmmSTRRes					= 7;							{ help message contains a res ID to a 'STR ' resource }
	kHMEnabledItem				= 0;							{ item is enabled, but not checked or control value = 0 }

{ ResTypes for Styled TE Handles in Resources }
	kHMTETextResType			= 'TEXT';						{ Resource Type of text data for styled TE record w/o style info }
	kHMTEStyleResType			= 'styl';

	kHMDisabledItem				= 1;							{ item is disabled, grayed in menus or disabled in dialogs }
	kHMCheckedItem				= 2;							{ item is enabled, and checked or control value = 1 }
	kHMOtherItem				= 3;							{ item is enabled, and control value > 1 }
{ Method parameters to pass to HMShowBalloon }
	kHMRegularWindow			= 0;							{ Create a regular window floating above all windows }
	kHMSaveBitsNoWindow			= 1;							{ Just save the bits and draw (for MDEF calls) }
	kHMSaveBitsWindow			= 2;							{ Regular window, save bits behind, AND generate update event }

{ Resource Types for whichType parameter used when extracting 'hmnu' & 'hdlg' messages }
	kHMMenuResType				= 'hmnu';						{ ResType of help resource for supporting menus }
	kHMDialogResType			= 'hdlg';						{ ResType of help resource for supporting dialogs }
	kHMWindListResType			= 'hwin';						{ ResType of help resource for supporting windows }
	kHMRectListResType			= 'hrct';						{ ResType of help resource for rectangles in windows }
	kHMOverrideResType			= 'hovr';						{ ResType of help resource for overriding system balloons }
	kHMFinderApplResType		= 'hfdr';


TYPE
	HMStringResType = RECORD
		hmmResID:				INTEGER;
		hmmIndex:				INTEGER;
	END;

	HMMessageRecord = RECORD
		hmmHelpType:			SInt16;
		CASE INTEGER OF
		0: (
			hmmString:					Str255;
		   );
		1: (
			hmmPict:					SInt16;
		   );
		2: (
			hmmTEHandle:				TEHandle;
		   );
		3: (
			hmmStringRes:				HMStringResType;
		   );
		4: (
			hmmPictRes:					SInt16;
		   );
		5: (
			hmmPictHandle:				PicHandle;
		   );
		6: (
			hmmTERes:					SInt16;
		   );
		7: (
			hmmSTRRes:					SInt16;
		   );
	END;

	HMMessageRecPtr = ^HMMessageRecord;

	TipFunctionProcPtr = ProcPtr;  { FUNCTION TipFunction(tip: Point; structure: RgnHandle; VAR r: Rect; VAR balloonVariant: INTEGER): OSErr; }
	TipFunctionUPP = UniversalProcPtr;

CONST
	uppTipFunctionProcInfo = $00003FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewTipFunctionProc(userRoutine: TipFunctionProcPtr): TipFunctionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallTipFunctionProc(tip: Point; structure: RgnHandle; VAR r: Rect; VAR balloonVariant: INTEGER; userRoutine: TipFunctionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
{  Public Interfaces  }

FUNCTION HMGetHelpMenuHandle(VAR mh: MenuRef): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0200, $A830;
	{$ENDC}
FUNCTION HMShowBalloon({CONST}VAR aHelpMsg: HMMessageRecord; tip: Point; alternateRect: RectPtr; tipProc: TipFunctionUPP; theProc: SInt16; balloonVariant: SInt16; method: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0B01, $A830;
	{$ENDC}
FUNCTION HMRemoveBalloon: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0002, $A830;
	{$ENDC}
FUNCTION HMGetBalloons: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0003, $A830;
	{$ENDC}
FUNCTION HMSetBalloons(flag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0104, $A830;
	{$ENDC}
FUNCTION HMShowMenuBalloon(itemNum: SInt16; itemMenuID: SInt16; itemFlags: SInt32; itemReserved: SInt32; tip: Point; alternateRect: RectPtr; tipProc: TipFunctionUPP; theProc: SInt16; balloonVariant: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E05, $A830;
	{$ENDC}
FUNCTION HMGetIndHelpMsg(whichType: ResType; whichResID: SInt16; whichMsg: SInt16; whichState: SInt16; VAR options: UInt32; VAR tip: Point; VAR altRect: Rect; VAR theProc: SInt16; VAR balloonVariant: SInt16; VAR aHelpMsg: HMMessageRecord; VAR count: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $1306, $A830;
	{$ENDC}
FUNCTION HMIsBalloon: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0007, $A830;
	{$ENDC}
FUNCTION HMSetFont(font: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0108, $A830;
	{$ENDC}
FUNCTION HMSetFontSize(fontSize: UInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0109, $A830;
	{$ENDC}
FUNCTION HMGetFont(VAR font: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020A, $A830;
	{$ENDC}
FUNCTION HMGetFontSize(VAR fontSize: UInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020B, $A830;
	{$ENDC}
FUNCTION HMSetDialogResID(resID: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $010C, $A830;
	{$ENDC}
FUNCTION HMSetMenuResID(menuID: SInt16; resID: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020D, $A830;
	{$ENDC}
FUNCTION HMBalloonRect({CONST}VAR aHelpMsg: HMMessageRecord; VAR coolRect: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040E, $A830;
	{$ENDC}
FUNCTION HMBalloonPict({CONST}VAR aHelpMsg: HMMessageRecord; VAR coolPict: PicHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040F, $A830;
	{$ENDC}
FUNCTION HMScanTemplateItems(whichID: SInt16; whichResFile: SInt16; whichType: ResType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0410, $A830;
	{$ENDC}
FUNCTION HMExtractHelpMsg(whichType: ResType; whichResID: SInt16; whichMsg: SInt16; whichState: SInt16; VAR aHelpMsg: HMMessageRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0711, $A830;
	{$ENDC}
FUNCTION HMGetDialogResID(VAR resID: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0213, $A830;
	{$ENDC}
FUNCTION HMGetMenuResID(menuID: SInt16; VAR resID: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0314, $A830;
	{$ENDC}
FUNCTION HMGetBalloonWindow(VAR window: WindowRef): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0215, $A830;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := BalloonsIncludes}

{$ENDC} {__BALLOONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
