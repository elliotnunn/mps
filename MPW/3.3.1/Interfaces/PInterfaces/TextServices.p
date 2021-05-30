{
	File:		TextServices.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1• for ETO #13
	Created:	Tuesday, March 30, 1993 18:00
	Modified:	Tue, Nov 30, 1993 01:24:07

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TextServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingTextServices}
{$SETC UsingTextServices := 1}

{$I+}
{$SETC UsingTextServices := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingEvents}
{$I $$Shell(PInterfaces)Events.p}
{$ENDC}
{$IFC UNDEFINED UsingMenus}
{$I $$Shell(PInterfaces)Menus.p}
{$ENDC}
{$IFC UNDEFINED UsingAppleEvents}
{$I $$Shell(PInterfaces)AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED UsingErrors}
{$I $$Shell(PInterfaces)Errors.p}
{$ENDC}
{$IFC UNDEFINED UsingComponents}
{$I $$Shell(PInterfaces)Components.p}
{$ENDC}
{$SETC UsingIncludes := UsingTextServices}

CONST

	kTSMVersion			=	1;						{ Version of Text Services Manager }
	kTextService		=	'tsvc';					{ Component type for component description }
	kInputMethodService	=	'inpm';					{ Component subtype for component description }
	
	bTakeActiveEvent	=	15;						{ Bit set if the component takes activate events }
	bScriptMask			=	$00007F00;				{ Bits 8 - 14 }
	bLanguageMask		=	$000000FF;				{ Bits 0 - 7 }
	bScriptLanguageMask	=	bScriptMask + bLanguageMask;	{Bits 0 - 14 }

{ Hilite styles ... }
	kCursorPosition				=	1;				{ specify cursor position }
	kRawText					=	2;				{ specify range of raw text }
	kSelectedRawText			=	3;				{ specify range of selected raw text }
	kConvertedText				=	4;				{ specify range of converted text }
	kSelectedConvertedText		=	5;				{ specify range of selected converted text }
	
{
	Apple Event constants
}

	kTextServiceClass		=	kTextService;		{ Event class }
	kUpdateActiveInputArea	=	'updt';				{ Update the active inline area }
	kPos2Offset				=	'p2st';				{ Convert global coordinates to character position }
	kOffset2Pos				=	'st2p';				{ Convert character position to global coordinate }
	kShowHideInputWindow	=	'shiw';				{ show or hide the input window }
	

	{ Event keywords ... }

	keyAETSMDocumentRefcon	=	'refc';				{ TSM document refcon }

	keyAEServerInstance	=	'srvi';					{ Server instance }
	keyAETheData		=	'kdat';					{ typeText }
{ already defined in AERegistry.p }
	{keyAEScriptTag		=	'sclg';}				{ Script tag }
	keyAEFixLength		=	'fixl';
	keyAEHiliteRange	=	'hrng';					{ Hilite range array }
	keyAEUpdateRange	=	'udng';					{ Update range array }
	keyAEClauseOffsets	=	'clau';					{ Clause offsets array }
	keyAECurrentPoint	=	'cpos';					{ Current point }
	keyAEDragging		=	'bool';					{ Dragging flag }
	keyAEOffset			=	'ofst';					{ Offset }
	keyAERegionClass	=	'rgnc';					{ Region class }
	keyAEPoint			=	'gpos';					{ Current point }
	keyAEBufferSize		=	'buff';					{ Buffer size to get the text }
{ already defined in AERegistry.p }
	{keyAERequestedType	=	'rtyp';}				{ Requested text type }
	keyAEMoveView		=	'mvvw';					{ Move view flag }
	keyAELength			=	'leng';					{ Length }
	keyAENextBody		=	'nxbd';					{ Next or previous body }

{ optional keywords for Offset2Pos		-- 28Mar92 }

{ already defined in AERegistry.p }
	{keyAETextFont		=	'ktxf';}
{ already defined in AERegistry.p }
	{keyAETextPointSize	=	'ktps';}
	keyAETextLineHeight	=	'ktlh';
	keyAETextLineAscent	=	'ktas';
{ already defined in AERegistry.p }
	{keyAEAngle			=	'kang';}
	
{ optional keyword for Pos2Offset		}

	keyAELeftSide		=	'klef';					{ type Boolean }


{ optional keyword for kShowHideInputWindow	}

	keyAEShowHideInputWindow	=	'shiw';			{ type Boolean }

{ keyword for PinRange  }

	keyAEPinRange				=	'pnrg';			{ <#6> }


{ Desc type ... }

	typeComponentInstance	=	'cmpi';				{ Component instance }
	typeTextRangeArray		=	'tray';				{ Text range array }
	typeOffsetArray			=	'ofay';				{ Offset array }
{ already defined in AERegistry.p }
	{typeIntlWritingCode	=	'intl';}			{ Script code }
{ already defined in AERegistry.p }
	{typeQDPoint			=	'QDpt';}			{ QuickDraw point }
{ already defined in AERegistry.p }
	{typeAEText				=	'tTXT';}			{ Apple Event text }
	typeText				=	'TEXT';				{ Plain text }
	
	typeTextRange			=	'txrn';				{ <#6> }


{
	Error codes
}

	tsmComponentNoErr	=	0;						{ Component result = no error }
	
	tsmUnsupScriptLanguageErr	=	-2500;
	tsmInputMethodNotFoundErr	=	-2501;
	tsmNotAnAppErr				=	-2502;			{ Not an application error }
	tsmAlreadyRegisteredErr		=	-2503;			{ Attemp to register again }
	tsmNeverRegisteredErr		=	-2504;			{ App never registered.  (Not TSM Aware) }
	tsmInvalidDocIDErr			=	-2505;			{ Invalid TSM documentation ID }
	tsmTSMDocBusyErr			=	-2506;			{ Document is still active }
	tsmDocNotActiveErr			=	-2507;			{ Document is not active }
	tsmNoOpenTSErr				=	-2508;			{ No open text service }
	tsmCantOpenComponentErr		=	-2509;			{ Can’t open the component }
	tsmTextServiceNotFoundErr	=	-2510;			{ No text service found }
	tsmDocumentOpenErr			=	-2511;			{ There are open documents }
	tsmUseInputWindowErr		=	-2512;			{ Not TSM aware because an input window is being used }
	tsmTSHasNoMenuErr			=	-2513;			{ The Text Service has no menu }
	tsmTSNotOpenErr				=	-2514;			{ Text service is not open }
	tsmComponentAlreadyOpenErr	=	-2515;			{ Text service already open for document }

	tsmInputMethodIsOldErr		=	-2516;			{ Returned by GetDefaultInputMethod }
	tsmScriptHasNoIMErr			=	-2517;			{ Script has no input method or is using old input method }
	tsmUnsupportedTypeErr		=	-2518;			{ unSupported interface type error }
	tsmUnknownErr				=	-2519;			{ Any other errors }

	kTSMOutsideOfBody			=	1;
	kTSMInsideOfBody			=	2;
	kTSMInsideOfActiveInputArea	=	3;
	
	kNextBody					=	1;
	kPreviousBody				=	2;
	
	errOffsetInvalid			=	-1800;
	errOffsetIsOutsideOfView	=	-1801;
	errTopOfDocument			=	-1810;
	errTopOfBody				=	-1811;
	errEndOfDocument			=	-1812;
	errEndOfBody				=	-1813;
	
TYPE
	TextRangeHandle	=	^TextRangePtr;
	TextRangePtr	=	^TextRange;
	TextRange		=	Record							{ typeTextRange }
							fStart:			Longint;
							fEnd:			Longint;
							fHiliteStyle:	Integer;
						End;
						
	TextRangeArrayHandle	=	^TextRangeArrayPtr;
	TextRangeArrayPtr		=	^TextRangeArray;
	TextRangeArray			=	Record					{ typeTextRangeArray }
									fNumOfRanges:	Integer;
									fRange:			Array [0..0] of TextRange;
								End;
								
	OffsetArrayHandle	=	^OffsetArrayPtr;
	OffsetArrayPtr		=	^OffsetArray;
	OffsetArray			=	Record						{ typeOffsetArray }
								fNumOfOffsets:	Integer;
								fOffset:		Array [0..0] of Longint;
							End;


	TextServicesInfoPtr	=	^TextServiceInfo;
	TextServiceInfo		=	Record
								fComponent:		Component;
								fItemName:		Str255;
							End;
							
	TextServiceListHandle	=	^TextServiceListPtr;
	TextServiceListPtr		=	^TextServiceList;
	TextServiceList			=	Record
									fTextServiceCount:	Integer;
									fServices: 			Array [0..0] of TextServiceInfo;
								End;
							
	ScriptLanguageRecord	=	Record
									fScript:	ScriptCode;
									fLanguage:	LangCode;
								End;
								
	ScriptLanguageSupportHandle	=	^ScriptLanguageSupportPtr;
	ScriptLanguageSupportPtr	=	^ScriptLanguageSupport;
	ScriptLanguageSupport		=	Record
										fScriptLanguageCount:	Integer;
										fScriptLanguageArray:	Array [0..0] of ScriptLanguageRecord;
									End;

	InterfaceTypeList	=	Array [0..0] of OSType;
	
	TSMDocumentID		=	Ptr;
	
{
	Text Services Routines
}

Function NewTSMDocument(numOfInterface: Integer; supportedInterfaceTypes: InterfaceTypeList; VAR idocID: TSMDocumentID; refCon: Longint): OSErr;
	INLINE $303C, $0000, $AA54;
Function DeleteTSMDocument(idocID: TSMDocumentID): OSErr;
	INLINE $303C, $0001, $AA54;
Function ActivateTSMDocument(idocID: TSMDocumentID): OSErr;
	INLINE $303C, $0002, $AA54;
Function DeactivateTSMDocument(idocID: TSMDocumentID): OSErr;
	INLINE $303C, $0003, $AA54;
Function TSMEvent(VAR event: EventRecord): Boolean;
	INLINE $303C, $0004, $AA54;
Function TSMMenuSelect(menuResult: Longint): Boolean;
	INLINE $303C, $0005, $AA54;
Function SetTSMCursor(mousePos: Point): Boolean;
	INLINE $303C, $0006, $AA54;
Function FixTSMDocument(idocID: TSMDocumentID): OSErr;
	INLINE $303C, $0007, $AA54;
Function GetServiceList(numOfInterface: Integer; supportedInterfaceTypes: InterfaceTypeList; VAR serviceInfo: TextServiceListHandle; VAR seedValue: Longint): OSErr;
	INLINE $303C, $0008, $AA54;
Function OpenTextService(idocID: TSMDocumentID; aComponent: Component; VAR aComponentInstance: ComponentInstance): OSErr;
	INLINE $303C, $0009, $AA54;
Function CloseTextService(idocID: TSMDocumentID; aComponentInstance: ComponentInstance): OSErr;
	INLINE $303C, $000A, $AA54;

Function SendAEFromTSMComponent(VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: Longint; idleProc: IdleProcPtr; filterProc: EventFilterProcPtr): OSErr;
	INLINE $303C, $000B, $AA54;
Function InitTSMAwareApplication: OSErr;
	INLINE $303C, $0014, $AA54;
Function CloseTSMAwareApplication: OSErr;
	INLINE $303C, $0015, $AA54;


Function SetDefaultInputMethod(ts: Component; VAR slRecord: ScriptLanguageRecord): OSErr;
	INLINE $303C, $000C, $AA54;
Function GetDefaultInputMethod(VAR ts: Component; VAR slRecord: ScriptLanguageRecord): OSErr;
	INLINE $303C, $000D, $AA54;
Function SetTextServiceLanguage(VAR slRecord: ScriptLanguageRecord): OSErr;
	INLINE $303C, $000E, $AA54;
Function GetTextServiceLanguage(VAR slRecord: ScriptLanguageRecord): OSErr;
	INLINE $303C, $000F, $AA54;
Function UseInputWindow(idocID: TSMDocumentID; useWindow: Boolean): OSErr;
	INLINE $303C, $0010, $AA54;
Function NewServiceWindow(wStorage: Ptr; boundsRect: Rect; title: Str255; 
	visible: Boolean; theProc: Integer; behind: WindowPtr; goAwayFlag: BOOLEAN;
	ts: ComponentInstance; VAR window: WindowPtr): OSErr;
	INLINE $303C, $0011, $AA54;
Function CloseServiceWindow(window: WindowPtr): OSErr;
	INLINE $303C, $0012, $AA54;
Function GetFrontServiceWindow(VAR window: WindowPtr): OSErr;
	INLINE $303C, $0013, $AA54;
Function FindServiceWindow(thePoint: Point; VAR theWindow: WindowPtr): Integer;
	INLINE $303C, $0017, $AA54;

{
	Low level Text Services routines
}

Function GetScriptLanguageSupport(ts: ComponentInstance; VAR scriptHandle: ScriptLanguageSupportHandle): ComponentResult;
	INLINE $2F3C, $0400, $0001, $7000, $A82A;
Function InitiateTextService(ts: ComponentInstance): ComponentResult;
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
Function TerminateTextService(ts: ComponentInstance): ComponentResult;
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
Function ActivateTextService(ts: ComponentInstance): ComponentResult;
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
Function DeactivateTextService(ts: ComponentInstance): ComponentResult;
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
Function TextServiceEvent(ts: ComponentInstance; numOfEvents: Integer; VAR event: EventRecord): ComponentResult;
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
Function GetTextServiceMenu(ts: ComponentInstance; VAR serviceMenu: MenuHandle): ComponentResult;
	INLINE $2F3C, $0000, $0007, $7000, $A82A;
Function TextServiceMenuSelect(ts: ComponentInstance; serviceMenu: MenuHandle; item: Integer): ComponentResult;
	INLINE $2F3C, $0000, $0008, $7000, $A82A;
Function FixTextService(ts: ComponentInstance): ComponentResult;
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
Function SetTextServiceCursor(ts: ComponentInstance; mousePos: Point): ComponentResult;
	INLINE $2F3C, $0000, $000A, $7000, $A82A;
Function HidePaletteWindows(ts: ComponentInstance): ComponentResult;
	INLINE $2F3C, $0000, $000B, $7000, $A82A;


{$ENDC} { UsingTextServices }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

