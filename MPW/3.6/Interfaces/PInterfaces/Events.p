{
     File:       Events.p
 
     Contains:   Event Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Events;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __EVENTS__}
{$SETC __EVENTS__ := 1}

{$I+}
{$SETC EventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC NOT TARGET_OS_MAC OR NOT TARGET_API_MAC_OS8 }
{$IFC UNDEFINED __ENDIAN__}
{$I Endian.p}
{$ENDC}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	EventKind							= UInt16;
	EventMask							= UInt16;

CONST
	nullEvent					= 0;
	mouseDown					= 1;
	mouseUp						= 2;
	keyDown						= 3;
	keyUp						= 4;
	autoKey						= 5;
	updateEvt					= 6;
	diskEvt						= 7;
	activateEvt					= 8;
	osEvt						= 15;
	kHighLevelEvent				= 23;

	mDownMask					= $02;							{  mouse button pressed }
	mUpMask						= $04;							{  mouse button released }
	keyDownMask					= $08;							{  key pressed }
	keyUpMask					= $10;							{  key released }
	autoKeyMask					= $20;							{  key repeatedly held down }
	updateMask					= $40;							{  window needs updating }
	diskMask					= $80;							{  disk inserted }
	activMask					= $0100;						{  activate/deactivate window }
	highLevelEventMask			= $0400;						{  high-level events (includes AppleEvents) }
	osMask						= $8000;						{  operating system events (suspend, resume) }
	everyEvent					= $FFFF;						{  all of the above }

	charCodeMask				= $000000FF;
	keyCodeMask					= $0000FF00;
	adbAddrMask					= $00FF0000;
	osEvtMessageMask			= $FF000000;

																{  OS event messages.  Event (sub)code is in the high byte of the message field. }
	mouseMovedMessage			= $00FA;
	suspendResumeMessage		= $0001;

	resumeFlag					= 1;							{  Bit 0 of message indicates resume vs suspend }

{$IFC CALL_NOT_IN_CARBON }
	{	  convertClipboardFlag is not ever set under Carbon. This is because scrap conversion is  	}
	{	  not tied to suspend/resume events any longer. Your application should instead use the   	}
	{	  scrap promise mechanism and fulfill scrap requests only when your promise keeper proc   	}
	{	  is called. If you need to know if the scrap has changed, you can cache the last         	}
	{	  ScrapRef you received and compare it with the current ScrapRef                          	}
	convertClipboardFlag		= 2;							{  Bit 1 in resume message indicates clipboard change }

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	EventModifiers						= UInt16;

CONST
																{  modifiers  }
	activeFlagBit				= 0;							{  activate? (activateEvt and mouseDown) }
	btnStateBit					= 7;							{  state of button? }
	cmdKeyBit					= 8;							{  command key down? }
	shiftKeyBit					= 9;							{  shift key down? }
	alphaLockBit				= 10;							{  alpha lock down? }
	optionKeyBit				= 11;							{  option key down? }
	controlKeyBit				= 12;							{  control key down? }
	rightShiftKeyBit			= 13;							{  right shift key down? }
	rightOptionKeyBit			= 14;							{  right Option key down? }
	rightControlKeyBit			= 15;							{  right Control key down? }

	activeFlag					= $01;
	btnState					= $80;
	cmdKey						= $0100;
	shiftKey					= $0200;
	alphaLock					= $0400;
	optionKey					= $0800;
	controlKey					= $1000;
	rightShiftKey				= $2000;
	rightOptionKey				= $4000;
	rightControlKey				= $8000;

	kNullCharCode				= 0;
	kHomeCharCode				= 1;
	kEnterCharCode				= 3;
	kEndCharCode				= 4;
	kHelpCharCode				= 5;
	kBellCharCode				= 7;
	kBackspaceCharCode			= 8;
	kTabCharCode				= 9;
	kLineFeedCharCode			= 10;
	kVerticalTabCharCode		= 11;
	kPageUpCharCode				= 11;
	kFormFeedCharCode			= 12;
	kPageDownCharCode			= 12;
	kReturnCharCode				= 13;
	kFunctionKeyCharCode		= 16;
	kEscapeCharCode				= 27;
	kClearCharCode				= 27;
	kLeftArrowCharCode			= 28;
	kRightArrowCharCode			= 29;
	kUpArrowCharCode			= 30;
	kDownArrowCharCode			= 31;
	kDeleteCharCode				= 127;
	kNonBreakingSpaceCharCode	= 202;


TYPE
	EventRecordPtr = ^EventRecord;
	EventRecord = RECORD
		what:					EventKind;
		message:				UInt32;
		when:					UInt32;
		where:					Point;
		modifiers:				EventModifiers;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	FKEYProcPtr = PROCEDURE;
{$ELSEC}
	FKEYProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FKEYUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FKEYUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppFKEYProcInfo = $00000000;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewFKEYUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewFKEYUPP(userRoutine: FKEYProcPtr): FKEYUPP; { old name was NewFKEYProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeFKEYUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFKEYUPP(userUPP: FKEYUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeFKEYUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeFKEYUPP(userRoutine: FKEYUPP); { old name was CallFKEYProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetMouse(VAR mouseLoc: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A972;
	{$ENDC}

{
 *  Button()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION Button: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A974;
	{$ENDC}

{
 *  StillDown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StillDown: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A973;
	{$ENDC}

{
 *  WaitMouseUp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION WaitMouseUp: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A977;
	{$ENDC}

{
 *  KeyTranslate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION KeyTranslate(transData: UNIV Ptr; keycode: UInt16; VAR state: UInt32): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C3;
	{$ENDC}

{
 *  GetCaretTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCaretTime: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $02F4;
	{$ENDC}


TYPE
    KeyMap                          = PACKED ARRAY [0..127] OF BOOLEAN;
{
 *  GetKeys()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetKeys(theKeys: KeyMap);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A976;
	{$ENDC}

{ Obsolete event types & masks }

CONST
	networkEvt					= 10;
	driverEvt					= 11;
	app1Evt						= 12;
	app2Evt						= 13;
	app3Evt						= 14;
	app4Evt						= 15;
	networkMask					= $0400;
	driverMask					= $0800;
	app1Mask					= $1000;
	app2Mask					= $2000;
	app3Mask					= $4000;
	app4Mask					= $8000;


TYPE
	EvQElPtr = ^EvQEl;
	EvQEl = RECORD
		qLink:					QElemPtr;
		qType:					SInt16;
		evtQWhat:				EventKind;								{  this part is identical to the EventRecord as defined above  }
		evtQMessage:			UInt32;
		evtQWhen:				UInt32;
		evtQWhere:				Point;
		evtQModifiers:			EventModifiers;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	GetNextEventFilterProcPtr = PROCEDURE(VAR theEvent: EventRecord; VAR result: BOOLEAN);
{$ELSEC}
	GetNextEventFilterProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	GetNextEventFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	GetNextEventFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppGetNextEventFilterProcInfo = $000000BF;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewGetNextEventFilterUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewGetNextEventFilterUPP(userRoutine: GetNextEventFilterProcPtr): GetNextEventFilterUPP; { old name was NewGetNextEventFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeGetNextEventFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeGetNextEventFilterUPP(userUPP: GetNextEventFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeGetNextEventFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeGetNextEventFilterUPP(VAR theEvent: EventRecord; VAR result: BOOLEAN; userRoutine: GetNextEventFilterUPP); { old name was CallGetNextEventFilterProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	GNEFilterUPP						= GetNextEventFilterUPP;
	{
	 *  GetDblTime()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetDblTime: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $02F0;
	{$ENDC}

{
 *  SetEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetEventMask(value: EventMask);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0144;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GetEvQHdr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetEvQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $014A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  PPostEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPostEvent(eventCode: EventKind; eventMsg: UInt32; VAR qEl: EvQElPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $201F, $305F, $A12F, $2288, $3E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetNextEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNextEvent(eventMask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A970;
	{$ENDC}

{
 *  WaitNextEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION WaitNextEvent(eventMask: EventMask; VAR theEvent: EventRecord; sleep: UInt32; mouseRgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A860;
	{$ENDC}

{
 *  EventAvail()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EventAvail(eventMask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A971;
	{$ENDC}

{
 *  PostEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PostEvent(eventNum: EventKind; eventMsg: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $305F, $A02F, $3E80;
	{$ENDC}

{
    For Carbon, use EventAvail, TickCount, GetGlobalMouse,
    GetKeys, or GetCurrentKeyModifiers instead of
    OSEventAvail, and use GetNextEvent or WaitNextEvent
    instead of GetOSEvent.
}

{$IFC CALL_NOT_IN_CARBON }
{
 *  OSEventAvail()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OSEventAvail(mask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $A030, $5240, $1E80;
	{$ENDC}

{
 *  GetOSEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetOSEvent(mask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $A031, $5240, $1E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  FlushEvents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FlushEvents(whichMask: EventMask; stopMask: EventMask);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A032;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SystemClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SystemClick({CONST}VAR theEvent: EventRecord; theWindow: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B3;
	{$ENDC}

{
 *  SystemTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SystemTask;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B4;
	{$ENDC}

{
 *  SystemEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SystemEvent({CONST}VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B2;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  KeyTrans()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION KeyTrans(transData: UNIV Ptr; keycode: UInt16; VAR state: UInt32): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C3;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{
    GetGlobalMouse, GetCurrentKeyModifiers, and CheckEventQueueForUserCancel
    are only available as part of the Carbon API.
}

{
 *  GetGlobalMouse()
 *  
 *  Summary:
 *    Returns the position of the mouse in global coordinates.
 *  
 *  Parameters:
 *    
 *    globalMouse:
 *      On exit, contains the mouse position in global coordinates.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetGlobalMouse(VAR globalMouse: Point);

{
 *  GetCurrentKeyModifiers()
 *  
 *  Summary:
 *    Returns the current state of the keyboard modifier keys.
 *  
 *  Discussion:
 *    The format of the return value is the same as the modifiers field
 *    of the EventRecord.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCurrentKeyModifiers: UInt32;

{
 *  CheckEventQueueForUserCancel()
 *  
 *  Summary:
 *    Determines if there is a cancel event in the event queue.
 *  
 *  Discussion:
 *    This API supports two cancel events: Escape and Cmd-Period. Mouse
 *    or keyboard events in front of the cancel event in the event
 *    queue will be removed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CheckEventQueueForUserCancel: BOOLEAN;


{
    The core data structure for the Carbon event system. It is declared here instead of
    in CarbonEvents.h to avoid recursive include problems.
}

TYPE
	EventRef    = ^LONGINT; { an opaque 32-bit type }
	EventRefPtr = ^EventRef;  { when a VAR xx:EventRef parameter can be nil, it is changed to xx: EventRefPtr }
	{
	 *  KeyScript()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE KeyScript(code: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8002, $0004, $A8B5;
	{$ENDC}

{
 *  IsCmdChar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsCmdChar({CONST}VAR event: EventRecord; test: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8206, $FFD0, $A8B5;
	{$ENDC}


{ 
    LowMem accessor functions previously in LowMem.h
}
{
 *  LMGetKeyThresh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetKeyThresh: SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $018E;
	{$ENDC}

{
 *  LMSetKeyThresh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetKeyThresh(value: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $018E;
	{$ENDC}


{
 *  LMGetKeyRepThresh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetKeyRepThresh: SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0190;
	{$ENDC}

{
 *  LMSetKeyRepThresh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetKeyRepThresh(value: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0190;
	{$ENDC}

{
 *  LMGetKbdLast()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetKbdLast: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $1EB8, $0218;
	{$ENDC}

{
 *  LMSetKbdLast()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetKbdLast(value: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $11DF, $0218;
	{$ENDC}


{
 *  LMGetKbdType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetKbdType: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $1EB8, $021E;
	{$ENDC}

{
 *  LMSetKbdType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetKbdType(value: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $11DF, $021E;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EventsIncludes}

{$ENDC} {__EVENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
