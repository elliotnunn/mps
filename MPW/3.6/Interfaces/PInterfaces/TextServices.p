{
     File:       TextServices.p
 
     Contains:   Text Services Manager Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1991-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}
{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __AEINTERACTION__}
{$I AEInteraction.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$IFC UNDEFINED __CARBONEVENTS__}
{$I CarbonEvents.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kTextService				= 'tsvc';						{  component type for the component description  }
	kInputMethodService			= 'inpm';						{  component subtype for the component description  }
	kTSMVersion					= $0150;						{  Version of the Text Services Manager is 1.5  }

	kUnicodeDocument			= 'udoc';						{  TSM Document type for Unicode-savvy application  }
	kUnicodeTextService			= 'utsv';						{  Component type for Unicode Text Service  }

	{  Language and Script constants }
	kUnknownLanguage			= $FFFF;
	kUnknownScript				= $FFFF;
	kNeutralScript				= $FFFF;


																{  Component Flags in ComponentDescription  }
	bTakeActiveEvent			= 15;							{  bit set if the component takes active event  }
	bHandleAERecording			= 16;							{  bit set if the component takes care of recording Apple Events <new in vers2.0>  }
	bScriptMask					= $00007F00;					{  bit 8 - 14  }
	bLanguageMask				= $000000FF;					{  bit 0 - 7   }
	bScriptLanguageMask			= $00007FFF;					{  bit 0 - 14   }

																{  Typing method property constants for Input Methods  }
	kIMJaTypingMethodProperty	= 'jtyp';						{  Typing method property for Japanese input methods }
	kIMJaTypingMethodRoman		= 'roma';						{  Roman typing }
	kIMJaTypingMethodKana		= 'kana';						{  Kana typing }

																{  Low level routines which are dispatched directly to the Component Manager  }
	kCMGetScriptLangSupport		= $0001;						{  Component Manager call selector 1  }
	kCMInitiateTextService		= $0002;						{  Component Manager call selector 2  }
	kCMTerminateTextService		= $0003;						{  Component Manager call selector 3  }
	kCMActivateTextService		= $0004;						{  Component Manager call selector 4  }
	kCMDeactivateTextService	= $0005;						{  Component Manager call selector 5  }
	kCMTextServiceEvent			= $0006;						{  Component Manager call selector 6  }
	kCMGetTextServiceMenu		= $0007;						{  Component Manager call selector 7  }
	kCMTextServiceMenuSelect	= $0008;						{  Component Manager call selector 8  }
	kCMFixTextService			= $0009;						{  Component Manager call selector 9  }
	kCMSetTextServiceCursor		= $000A;						{  Component Manager call selector 10  }
	kCMHidePaletteWindows		= $000B;						{  Component Manager call selector 11  }
	kCMGetTextServiceProperty	= $000C;						{  Component Manager call selector 12  }
	kCMSetTextServiceProperty	= $000D;						{  Component Manager call selector 13  }

																{  New low level routines which are dispatched directly to the Component Manager  }
	kCMUCTextServiceEvent		= $000E;						{  Component Manager call selector 14  }



	{	 New opaque definitions for types 	}

TYPE
	TSMDocumentID    = ^LONGINT; { an opaque 32-bit type }
	TSMDocumentIDPtr = ^TSMDocumentID;  { when a VAR xx:TSMDocumentID parameter can be nil, it is changed to xx: TSMDocumentIDPtr }
	InterfaceTypeList					= ARRAY [0..0] OF OSType;

	{	 Text Service Info List 	}
	TextServiceInfoPtr = ^TextServiceInfo;
	TextServiceInfo = RECORD
		fComponent:				Component;
		fItemName:				Str255;
	END;

	TextServiceListPtr = ^TextServiceList;
	TextServiceList = RECORD
		fTextServiceCount:		INTEGER;								{  number of entries in the 'fServices' array  }
		fServices:				ARRAY [0..0] OF TextServiceInfo;		{  Note: array of 'TextServiceInfo' records follows  }
	END;

	TextServiceListHandle				= ^TextServiceListPtr;
	ScriptLanguageRecordPtr = ^ScriptLanguageRecord;
	ScriptLanguageRecord = RECORD
		fScript:				ScriptCode;
		fLanguage:				LangCode;
	END;

	ScriptLanguageSupportPtr = ^ScriptLanguageSupport;
	ScriptLanguageSupport = RECORD
		fScriptLanguageCount:	INTEGER;								{  number of entries in the 'fScriptLanguageArray' array  }
		fScriptLanguageArray:	ARRAY [0..0] OF ScriptLanguageRecord;	{  Note: array of 'ScriptLanguageRecord' records follows  }
	END;

	ScriptLanguageSupportHandle			= ^ScriptLanguageSupportPtr;
	{	 High level TSM Doucment routines 	}
	{
	 *  NewTSMDocument()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewTSMDocument(numOfInterface: INTEGER; VAR supportedInterfaceTypes: InterfaceTypeList; VAR idocID: TSMDocumentID; refcon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AA54;
	{$ENDC}

{
 *  DeleteTSMDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DeleteTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA54;
	{$ENDC}

{
 *  ActivateTSMDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ActivateTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA54;
	{$ENDC}

{
 *  DeactivateTSMDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DeactivateTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA54;
	{$ENDC}

{
 *  FixTSMDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FixTSMDocument(idocID: TSMDocumentID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AA54;
	{$ENDC}

{
 *  GetServiceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetServiceList(numOfInterface: INTEGER; VAR supportedInterfaceTypes: OSType; VAR serviceInfo: TextServiceListHandle; VAR seedValue: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AA54;
	{$ENDC}

{
 *  OpenTextService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OpenTextService(idocID: TSMDocumentID; aComponent: Component; VAR aComponentInstance: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AA54;
	{$ENDC}

{
 *  CloseTextService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CloseTextService(idocID: TSMDocumentID; aComponentInstance: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AA54;
	{$ENDC}

{
 *  SendAEFromTSMComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SendAEFromTSMComponent({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AA54;
	{$ENDC}

{
 *  SendTextInputEvent()
 *  
 *  Discussion:
 *    This API replaces SendAEFromTSMComponent on Mac OS X only. Input
 *    Methods on Mac OS X are Carbon Event based instead of AppleEvent
 *    based.  The Carbon TextInput events which they generate are
 *    provided to TSM for dispatching via this API.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib N.e.v.e.r and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SendTextInputEvent(inEvent: EventRef): OSStatus;

{
 *  SetDefaultInputMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDefaultInputMethod(ts: Component; VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AA54;
	{$ENDC}

{
 *  GetDefaultInputMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDefaultInputMethod(VAR ts: Component; VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AA54;
	{$ENDC}

{
 *  SetTextServiceLanguage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetTextServiceLanguage(VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AA54;
	{$ENDC}

{
 *  GetTextServiceLanguage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTextServiceLanguage(VAR slRecordPtr: ScriptLanguageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AA54;
	{$ENDC}

{
 *  UseInputWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UseInputWindow(idocID: TSMDocumentID; useWindow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AA54;
	{$ENDC}

{
 *  TSMSetInlineInputRegion()
 *  
 *  Discussion:
 *    Tell TSM about the region occupied by an inline input session. If
 *    the location of certain mouse events (clicks, mouse moved) occur
 *    within the specified inline input region, TSM will forward these
 *    events to the current Input Method so that it can interact with
 *    the user. Note: If you do not specify this information, TSM will
 *    need to intercept mouse events in the entire content region as
 *    the default, when an input method is active, in order to ensure
 *    that input methods can manage user interaction properly.
 *  
 *  Parameters:
 *    
 *    inTSMDocument:
 *      The document.
 *    
 *    inWindow:
 *      The window that contains the inline input session. You can pass
 *      NULL for this parameter to indicate the user focus window.
 *    
 *    inRegion:
 *      The region occupied by the current inline input region. This
 *      should be in the coordinates of the port associated with the
 *      window you passed to inPort. It will need to be recomputed when
 *      the text content of the inline input session content changes
 *      (i.e. due to Update Active Input Area events) and when the
 *      region moves for other reasons, such as window resized,
 *      scrolling, etc. If you pass a NULL region for this parameter,
 *      TSM will default to intercept mouse events in the focus
 *      window's content region.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TSMSetInlineInputRegion(inTSMDocument: TSMDocumentID; inWindow: WindowRef; inRegion: RgnHandle): OSStatus;


{ Following calls from Classic event loops not needed for Carbon clients. }
{$IFC CALL_NOT_IN_CARBON }
{
 *  TSMEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TSMEvent(VAR event: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA54;
	{$ENDC}

{
 *  TSMMenuSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TSMMenuSelect(menuResult: LONGINT): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AA54;
	{$ENDC}

{
 *  SetTSMCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetTSMCursor(mousePos: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AA54;
	{$ENDC}

{ Following ServiceWindow API replaced by Window Manager API in Carbon. }
{
 *  NewServiceWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewServiceWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; theProc: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; ts: ComponentInstance; VAR window: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AA54;
	{$ENDC}

{
 *  CloseServiceWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CloseServiceWindow(window: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AA54;
	{$ENDC}

{
 *  GetFrontServiceWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFrontServiceWindow(VAR window: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $AA54;
	{$ENDC}

{
 *  FindServiceWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FindServiceWindow(thePoint: Point; VAR theWindow: WindowRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $AA54;
	{$ENDC}

{
 *  NewCServiceWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewCServiceWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; theProc: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; ts: ComponentInstance; VAR window: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $AA54;
	{$ENDC}

{ Explicit initialization not needed for Carbon clients, since TSM is }
{ instanciated per-context. }
{
 *  InitTSMAwareApplication()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitTSMAwareApplication: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AA54;
	{$ENDC}

{
 *  CloseTSMAwareApplication()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CloseTSMAwareApplication: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AA54;
	{$ENDC}


{ Component Manager Interfaces to Input Methods }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetScriptLanguageSupport()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetScriptLanguageSupport(ts: ComponentInstance; VAR scriptHdl: ScriptLanguageSupportHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  InitiateTextService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InitiateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
	{$ENDC}

{
 *  TerminateTextService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TerminateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}

{
 *  ActivateTextService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ActivateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}

{
 *  DeactivateTextService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DeactivateTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}

{
 *  GetTextServiceMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTextServiceMenu(ts: ComponentInstance; VAR serviceMenu: MenuRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{ New Text Service call in Carbon. }
{ Note: Only Raw Key and Mouse-flavored events are passed to Text Services on MacOS X. }
{
 *  TextServiceEventRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TextServiceEventRef(ts: ComponentInstance; event: EventRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0006, $7000, $A82A;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  TextServiceEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TextServiceEvent(ts: ComponentInstance; numOfEvents: INTEGER; VAR event: EventRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0006, $7000, $A82A;
	{$ENDC}

{
 *  UCTextServiceEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UCTextServiceEvent(ts: ComponentInstance; numOfEvents: INTEGER; VAR event: EventRecord; VAR unicodeString: UniChar; unicodeStrLength: UniCharCount): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $000E, $7000, $A82A;
	{$ENDC}

{
 *  TextServiceMenuSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TextServiceMenuSelect(ts: ComponentInstance; serviceMenu: MenuRef; item: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0008, $7000, $A82A;
	{$ENDC}

{
 *  SetTextServiceCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetTextServiceCursor(ts: ComponentInstance; mousePos: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  FixTextService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FixTextService(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}

{
 *  HidePaletteWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HidePaletteWindows(ts: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000B, $7000, $A82A;
	{$ENDC}

{
 *  GetTextServiceProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTextServiceProperty(ts: ComponentInstance; propertySelector: OSType; VAR result: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000C, $7000, $A82A;
	{$ENDC}

{
 *  SetTextServiceProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetTextServiceProperty(ts: ComponentInstance; propertySelector: OSType; value: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000D, $7000, $A82A;
	{$ENDC}

{ Get the active TSMDocument in the current application context.       }
{ If TSM has enabled bottom line input mode because no TSMDocument     }
{ is active, NULL will be returned.                                    }
{
 *  TSMGetActiveDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TSMGetActiveDocument: TSMDocumentID;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextServicesIncludes}

{$ENDC} {__TEXTSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
