{
 	File:		TextServices.p
 
 	Contains:	Text Services Manager Interfaces.
 
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
 UNIT TextServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTSERVICES__}
{$SETC __TEXTSERVICES__ := 1}

{$I+}
{$SETC TextServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	OSUtils.p													}
{		Memory.p												}

{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kTSMVersion					= $200;							{ Version of the Text Services Manager is 2.0  }
	kTextService				= 'tsvc';						{ component type for the component description }
	kInputMethodService			= 'inpm';						{ component subtype for the component description }
{ Component Flags in ComponentDescription }
	bTakeActiveEvent			= 15;							{ bit set if the component takes active event }
	bHandleAERecording			= 16;							{ bit set if the component takes care of recording Apple Events <new in vers2.0> }
	bScriptMask					= $00007F00;					{ bit 8 - 14 }
	bLanguageMask				= $000000FF;					{ bit 0 - 7  }
	bScriptLanguageMask			= bScriptMask + bLanguageMask;	{ bit 0 - 14  }

{ Hilite styles }
	kCaretPosition				= 1;							{ specify caret position }
	kRawText					= 2;							{ specify range of raw text }
	kSelectedRawText			= 3;							{ specify range of selected raw text }
	kConvertedText				= 4;							{ specify range of converted text }
	kSelectedConvertedText		= 5;							{ specify range of selected converted text }

{ Apple Event constants }
{ Event class }
	kTextServiceClass			= kTextService;
{ event ID }
	kUpdateActiveInputArea		= 'updt';						{ update the active Inline area }
	kPos2Offset					= 'p2st';						{ converting global coordinates to char position }
	kOffset2Pos					= 'st2p';						{ converting char position to global coordinates }
	kShowHideInputWindow		= 'shiw';						{ show or hide the input window }
{ Event keywords }
	keyAETSMDocumentRefcon		= 'refc';						{ TSM document refcon, typeLongInteger }
{ Note: keyAETSMScriptTag, keyAERequestedType, keyAETSMTextFont, keyAETextPointSize
	typeAEText, typeIntlWritingCode, typeQDPoint, and keyAEAngle have been moved to 
	AERegistry.h }
	keyAEServerInstance			= 'srvi';						{ component instance }
	keyAETheData				= 'kdat';						{ typeText }
	keyAEFixLength				= 'fixl';						{ fix len ?? }
	keyAEHiliteRange			= 'hrng';						{ hilite range array }
	keyAEUpdateRange			= 'udng';						{ update range array }
	keyAEClauseOffsets			= 'clau';						{ Clause Offsets array }
	keyAECurrentPoint			= 'cpos';						{ current point }
	keyAEDragging				= 'bool';						{ dragging falg }
	keyAEOffset					= 'ofst';						{ offset }
	keyAERegionClass			= 'rgnc';						{ region class }
	keyAEPoint					= 'gpos';						{ current point }
	keyAEBufferSize				= 'buff';						{ buffer size to get the text }
	keyAEMoveView				= 'mvvw';						{ move view flag }
	keyAELength					= 'leng';						{ length }
	keyAENextBody				= 'nxbd';						{ next or previous body }
{ optional keywords for Offset2Pos (Info about the active input area) }
	keyAETextLineHeight			= 'ktlh';						{ typeShortInteger }
	keyAETextLineAscent			= 'ktas';						{ typeShortInteger }
{ optional keywords for Pos2Offset }
	keyAELeftSide				= 'klef';						{ type Boolean }
{ optional keywords for kShowHideInputWindow }
	keyAEShowHideInputWindow	= 'shiw';						{ type Boolean }
{ for PinRange  }
	keyAEPinRange				= 'pnrg';
{ Desc type ... }
	typeComponentInstance		= 'cmpi';						{ server instance }
	typeTextRangeArray			= 'tray';						{ text range array }
	typeOffsetArray				= 'ofay';						{ offset array }
	typeText					= typeChar;						{ Plain text }
	typeTextRange				= 'txrn';

{ Desc type constants }
	kTSMOutsideOfBody			= 1;
	kTSMInsideOfBody			= 2;
	kTSMInsideOfActiveInputArea	= 3;

	kNextBody					= 1;
	kPreviousBody				= 2;

{ Low level routines which are dispatched directly to the Component Manager }
	kCMGetScriptLangSupport		= $0001;						{ Component Manager call selector 1 }
	kCMInitiateTextService		= $0002;						{ Component Manager call selector 2 }
	kCMTerminateTextService		= $0003;						{ Component Manager call selector 3 }
	kCMActivateTextService		= $0004;						{ Component Manager call selector 4 }
	kCMDeactivateTextService	= $0005;						{ Component Manager call selector 5 }
	kCMTextServiceEvent			= $0006;						{ Component Manager call selector 6 }
	kCMGetTextServiceMenu		= $0007;						{ Component Manager call selector 7 }
	kCMTextServiceMenuSelect	= $0008;						{ Component Manager call selector 8 }
	kCMFixTextService			= $0009;						{ Component Manager call selector 9 }
	kCMSetTextServiceCursor		= $000A;						{ Component Manager call selector 10 }
	kCMHidePaletteWindows		= $000B;						{ Component Manager call selector 11 }

{ typeTextRange 		'txrn' }

TYPE
	TextRange = RECORD
		fStart:					LONGINT;
		fEnd:					LONGINT;
		fHiliteStyle:			INTEGER;
	END;

	TextRangePtr = ^TextRange;

	TextRangeHandle = ^TextRangePtr;

{ typeTextRangeArray	'txra' }
	TextRangeArray = RECORD
		fNumOfRanges:			INTEGER;								{ specify the size of the fRange array }
		fRange:					ARRAY [0..0] OF TextRange;				{ when fNumOfRanges > 1, the size of this array has to be calculated }
	END;

	TextRangeArrayPtr = ^TextRangeArray;

	TextRangeArrayHandle = ^TextRangeArrayPtr;

{ typeOffsetArray		'offa' }
	OffsetArray = RECORD
		fNumOfOffsets:			INTEGER;								{ specify the size of the fOffset array }
		fOffset:				ARRAY [0..0] OF LONGINT;				{ when fNumOfOffsets > 1, the size of this array has to be calculated }
	END;

	OffsetArrayPtr = ^OffsetArray;

	OffsetArrayHandle = ^OffsetArrayPtr;

	TSMDocumentID = Ptr;

	InterfaceTypeList = ARRAY [0..0] OF OSType;

{ Text Service Info List }
	TextServiceInfo = RECORD
		fComponent:				Component;
		fItemName:				Str255;
	END;

	TextServiceInfoPtr = ^TextServiceInfo;

	TextServiceList = RECORD
		fTextServiceCount:		INTEGER;								{ number of entries in the 'fServices' array }
		fServices:				ARRAY [0..0] OF TextServiceInfo;		{ Note: array of 'TextServiceInfo' records follows }
	END;

	TextServiceListPtr = ^TextServiceList;

	TextServiceListHandle = ^TextServiceListPtr;

	ScriptLanguageRecord = RECORD
		fScript:				ScriptCode;
		fLanguage:				LangCode;
	END;

	ScriptLanguageSupport = RECORD
		fScriptLanguageCount:	INTEGER;								{ number of entries in the 'fScriptLanguageArray' array }
		fScriptLanguageArray:	ARRAY [0..0] OF ScriptLanguageRecord;	{ Note: array of 'ScriptLanguageRecord' records follows }
	END;

	ScriptLanguageSupportPtr = ^ScriptLanguageSupport;

	ScriptLanguageSupportHandle = ^ScriptLanguageSupportPtr;


FUNCTION NewTSMDocument(numOfInterface: INTEGER; VAR supportedInterfaceTypes: InterfaceTypeList; VAR idocID: TSMDocumentID; refcon: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $AA54;
	{$ENDC}
FUNCTION DeleteTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $AA54;
	{$ENDC}
FUNCTION ActivateTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $AA54;
	{$ENDC}
FUNCTION DeactivateTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $AA54;
	{$ENDC}
FUNCTION TSMEvent(VAR event: EventRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $AA54;
	{$ENDC}
FUNCTION TSMMenuSelect(menuResult: LONGINT): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $AA54;
	{$ENDC}
FUNCTION SetTSMCursor(mousePos: Point): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $AA54;
	{$ENDC}
FUNCTION FixTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $AA54;
	{$ENDC}
FUNCTION GetServiceList(numOfInterface: INTEGER; VAR supportedInterfaceTypes: OSType; VAR serviceInfo: TextServiceListHandle; VAR seedValue: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $AA54;
	{$ENDC}
FUNCTION OpenTextService(idocID: TSMDocumentID; aComponent: Component; VAR aComponentInstance: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $AA54;
	{$ENDC}
FUNCTION CloseTextService(idocID: TSMDocumentID; aComponentInstance: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $AA54;
	{$ENDC}
FUNCTION SendAEFromTSMComponent({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $AA54;
	{$ENDC}
FUNCTION InitTSMAwareApplication: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $AA54;
	{$ENDC}
FUNCTION CloseTSMAwareApplication: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $AA54;
	{$ENDC}
{ Utilities }
FUNCTION SetDefaultInputMethod(ts: Component; VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $AA54;
	{$ENDC}
FUNCTION GetDefaultInputMethod(VAR ts: Component; VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $AA54;
	{$ENDC}
FUNCTION SetTextServiceLanguage(VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $AA54;
	{$ENDC}
FUNCTION GetTextServiceLanguage(VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $AA54;
	{$ENDC}
FUNCTION UseInputWindow(idocID: TSMDocumentID; useWindow: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $AA54;
	{$ENDC}
FUNCTION NewServiceWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; theProc: INTEGER; behind: WindowPtr; goAwayFlag: BOOLEAN; ts: ComponentInstance; VAR window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $AA54;
	{$ENDC}
FUNCTION CloseServiceWindow(window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $AA54;
	{$ENDC}
FUNCTION GetFrontServiceWindow(VAR window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7013, $AA54;
	{$ENDC}
FUNCTION FindServiceWindow(thePoint: Point; VAR theWindow: WindowPtr): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7017, $AA54;
	{$ENDC}
{ Low level TSM routines }
FUNCTION GetScriptLanguageSupport(ts: ComponentInstance; VAR scriptHdl: ScriptLanguageSupportHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $04, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION InitiateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $00, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION TerminateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $00, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION ActivateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $00, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION DeactivateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $00, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION TextServiceEvent(ts: ComponentInstance; numOfEvents: INTEGER; VAR event: EventRecord): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $06, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION GetTextServiceMenu(ts: ComponentInstance; VAR serviceMenu: MenuHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $4, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION TextServiceMenuSelect(ts: ComponentInstance; serviceMenu: MenuHandle; item: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $06, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION FixTextService(ts: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $00, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION SetTextServiceCursor(ts: ComponentInstance; mousePos: Point): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $04, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION HidePaletteWindows(ts: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $00, $000B, $7000, $A82A;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextServicesIncludes}

{$ENDC} {__TEXTSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
