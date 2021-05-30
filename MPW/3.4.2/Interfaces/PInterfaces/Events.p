{
 	File:		Events.p
 
 	Contains:	Event Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
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
 UNIT Events;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __EVENTS__}
{$SETC __EVENTS__ := 1}

{$I+}
{$SETC EventsIncludes := UsingIncludes}
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

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{	Memory.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	EventKind = UInt16;


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

	
TYPE
	EventMask = UInt16;


CONST
	mDownMask					= $0002;						{ mouse button pressed }
	mUpMask						= $0004;						{ mouse button released }
	keyDownMask					= $0008;						{ key pressed }
	keyUpMask					= $0010;						{ key released }
	autoKeyMask					= $0020;						{ key repeatedly held down }
	updateMask					= $0040;						{ window needs updating }
	diskMask					= $0080;						{ disk inserted }
	activMask					= $0100;						{ activate/deactivate window }
	highLevelEventMask			= $0400;						{ high-level events (includes AppleEvents) }
	osMask						= $8000;						{ operating system events (suspend, resume) }
	everyEvent					= $FFFF;						{ all of the above }

{ event message equates }
	charCodeMask				= $000000FF;
	keyCodeMask					= $0000FF00;
	adbAddrMask					= $00FF0000;
	osEvtMessageMask			= $FF000000;
{ OS event messages.  Event (sub)code is in the high byte of the message field. }
	mouseMovedMessage			= $00FA;
	suspendResumeMessage		= $0001;
	resumeFlag					= 1;							{ Bit 0 of message indicates resume vs suspend }
	convertClipboardFlag		= 2;							{ Bit 1 in resume message indicates clipboard change }

	
TYPE
	EventModifiers = UInt16;


CONST
{ modifiers }
	activeFlag					= $0001;						{ Bit 0 of modifiers for activateEvt and mouseDown events }
	btnState					= $0080;						{ Bit 7 of low byte is mouse button state }
	cmdKey						= $0100;						{ Bit 0 of high byte }
	shiftKey					= $0200;						{ Bit 1 of high byte }
	alphaLock					= $0400;						{ Bit 2 of high byte }
	optionKey					= $0800;						{ Bit 3 of high byte }
	controlKey					= $1000;						{ Bit 4 of high byte }
	rightShiftKey				= $2000;						{ Bit 5 of high byte }
	rightOptionKey				= $4000;						{ Bit 6 of high byte }
	rightControlKey				= $8000;						{ Bit 7 of high byte }
	activeFlagBit				= 0;							{ activate? (activateEvt and mouseDown) }
	btnStateBit					= 7;							{ state of button? }
	cmdKeyBit					= 8;							{ command key down? }
	shiftKeyBit					= 9;							{ shift key down? }
	alphaLockBit				= 10;							{ alpha lock down? }
	optionKeyBit				= 11;							{ option key down? }
	controlKeyBit				= 12;							{ control key down? }
	rightShiftKeyBit			= 13;							{ right shift key down? }
	rightOptionKeyBit			= 14;							{ right Option key down? }
	rightControlKeyBit			= 15;							{ right Control key down? }


TYPE
	EventRecord = RECORD
		what:					EventKind;
		message:				UInt32;
		when:					UInt32;
		where:					Point;
		modifiers:				EventModifiers;
	END;

	KeyMap = PACKED ARRAY [0..127] OF BOOLEAN;

	EvQEl = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		evtQWhat:				EventKind;								{ this part is identical to the EventRecord as... }
		evtQMessage:			UInt32;									{ defined above }
		evtQWhen:				UInt32;
		evtQWhere:				Point;
		evtQModifiers:			EventModifiers;
	END;

	EvQElPtr = ^EvQEl;

	GetNextEventFilterProcPtr = ProcPtr;  { PROCEDURE GetNextEventFilter(VAR theEvent: EventRecord; VAR result: BOOLEAN); }
	GetNextEventFilterUPP = UniversalProcPtr;

CONST
	uppGetNextEventFilterProcInfo = $000000BF; { SPECIAL_CASE_PROCINFO( kSpecialCaseGNEFilterProc ) }

FUNCTION NewGetNextEventFilterProc(userRoutine: GetNextEventFilterProcPtr): GetNextEventFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallGetNextEventFilterProc(VAR theEvent: EventRecord; VAR result: BOOLEAN; userRoutine: GetNextEventFilterUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}
	
TYPE
	GNEFilterUPP = GetNextEventFilterUPP;

	FKEYProcPtr = ProcPtr;  { PROCEDURE FKEY; }
	FKEYUPP = UniversalProcPtr;

CONST
	uppFKEYProcInfo = $00000000; { PROCEDURE ; }

FUNCTION NewFKEYProc(userRoutine: FKEYProcPtr): FKEYUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallFKEYProc(userRoutine: FKEYUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION GetCaretTime : UInt32;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $02F4;			{ MOVE.l $02F4,(SP) }
	{$ENDC}

PROCEDURE SetEventMask( value: EventMask );
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $31DF, $0144;			{ MOVE.w (SP)+,$0144 }
	{$ENDC}

FUNCTION GetEventMask : EventMask;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $3EB8, $0144;			{ MOVE.w $0144,(SP) }
	{$ENDC}

FUNCTION GetEvQHdr: QHdrPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2EBC, $0000, $014A;
	{$ENDC}
{ InterfaceLib exports GetEvQHdr, so make GetEventQueue map to that }
FUNCTION GetDblTime : UInt32;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $2EB8, $02F0;			{ MOVE.l $02F0,(SP) }
	{$ENDC}

{ InterfaceLib exports GetDblTime, so make GetDoubleClickTime map to that }
FUNCTION GetNextEvent(eventMask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A970;
	{$ENDC}
FUNCTION WaitNextEvent(eventMask: EventMask; VAR theEvent: EventRecord; sleep: UInt32; mouseRgn: RgnHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A860;
	{$ENDC}
FUNCTION EventAvail(eventMask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A971;
	{$ENDC}
PROCEDURE GetMouse(VAR mouseLoc: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A972;
	{$ENDC}
FUNCTION Button: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A974;
	{$ENDC}
FUNCTION StillDown: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A973;
	{$ENDC}
FUNCTION WaitMouseUp: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A977;
	{$ENDC}
PROCEDURE GetKeys(theKeys: KeyMap);
	{$IFC NOT GENERATINGCFM}
	INLINE $A976;
	{$ENDC}
FUNCTION KeyTranslate(transData: UNIV Ptr; keycode: UInt16; VAR state: UInt32): UInt32;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C3;
	{$ENDC}
FUNCTION TickCount: UInt32;
	{$IFC NOT GENERATINGCFM}
	INLINE $A975;
	{$ENDC}
FUNCTION PostEvent(eventNum: EventKind; eventMsg: UInt32): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $305F, $A02F, $3E80;
	{$ENDC}
FUNCTION PPostEvent(eventCode: EventKind; eventMsg: UInt32; VAR qEl: EvQElPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $201F, $305F, $A12F, $2288, $3E80;
	{$ENDC}
FUNCTION OSEventAvail(mask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $301F, $A030, $5240, $1E80;
	{$ENDC}
FUNCTION GetOSEvent(mask: EventMask; VAR theEvent: EventRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $301F, $A031, $5240, $1E80;
	{$ENDC}
PROCEDURE FlushEvents(whichMask: EventMask; stopMask: EventMask);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A032;
	{$ENDC}
PROCEDURE SystemClick({CONST}VAR theEvent: EventRecord; theWindow: WindowRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B3;
	{$ENDC}
PROCEDURE SystemTask;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B4;
	{$ENDC}
FUNCTION SystemEvent({CONST}VAR theEvent: EventRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B2;
	{$ENDC}
{$IFC OLDROUTINENAMES }

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


FUNCTION KeyTrans(transData: UNIV Ptr; keycode: UInt16; VAR state: UInt32): UInt32;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C3;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EventsIncludes}

{$ENDC} {__EVENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
