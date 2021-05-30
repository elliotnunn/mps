{
 	File:		Controls.p
 
 	Contains:	Control Manager interfaces
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
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
 UNIT Controls;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONTROLS__}
{$SETC __CONTROLS__ := 1}

{$I+}
{$SETC ControlsIncludes := UsingIncludes}
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

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
	******************************************************************************
	*                                                                            *
	* The conditional STRICT_CONTROLS has been removed from this interface file. *
	* The accessor macros to a ControlRecord are no longer necessary.            *
	*                                                                            *
	* All ≈Ref Types have reverted to their original Handle and Ptr Types.       *
	*                                                                            *
	******************************************************************************

	Details:
	The original purpose of the STRICT_ conditionals and accessor macros was to
	help ease the transition to Copland.  Shared data structures are difficult
	to coordinate in a preemptive multitasking OS.  By hiding the fields in a
	WindowRecord and other data structures, we would begin the migration to the
	discipline wherein system data structures are completely hidden from
	applications.
	
	After many design reviews, we finally concluded that with this sort of
	migration, the system could never tell when an application was no longer
	peeking at a WindowRecord, and thus the data structure might never become
	system owned.  Additionally, there were many other limitations in the
	classic toolbox that were begging to be addressed.  The final decision was
	to leave the traditional toolbox as a compatibility mode.
	
	We also decided to use the Handle and Ptr based types in the function
	declarations.  For example, NewWindow now returns a WindowPtr rather than a
	WindowRef.  The Ref types are still defined in the header files, so all
	existing code will still compile exactly as it did before.  There are
	several reasons why we chose to do this:
	
	- The importance of backwards compatibility makes it unfeasible for us to
	enforce real opaque references in the implementation anytime in the
	foreseeable future.  Therefore, any opaque data types (e.g. WindowRef,
	ControlRef, etc.) in the documentation and header files would always be a
	fake veneer of opacity.
	
	- There exists a significant base of books and sample code that neophyte
	Macintosh developers use to learn how to program the Macintosh.  These
	books and sample code all use direct data access.  Introducing opaque data
	types at this point would confuse neophyte programmers more than it would
	help them.
	
	- Direct data structure access is used by nearly all Macintosh developers. 
	Changing the interfaces to reflect a false opacity would not provide any
	benefit to these developers.
	
	- Accessor functions are useful in and of themselves as convenience
	functions, without being tied to opaque data types.  We will complete and
	document the Windows and Dialogs accessor functions in an upcoming release
	of the interfaces.
}

{_________________________________________________________________________________________________________}
{}
{ • CONTROL DEFINITION ID'S}
{}
{_________________________________________________________________________________________________________}
{}
{ Standard System 7 procID's for use only with NewControl()}
{}

CONST
	pushButProc					= 0;
	checkBoxProc				= 1;
	radioButProc				= 2;
	scrollBarProc				= 16;
	popupMenuProc				= 1008;

	kControlUsesOwningWindowsFontVariant = 1 * (2**(3));		{ Control uses owning windows font to display text}

{_________________________________________________________________________________________________________}
{}
{ • CONTROL PART CODES}
{}
{_________________________________________________________________________________________________________}
	
TYPE
	ControlPartCode = SInt16;


CONST
	kControlNoPart				= 0;
	kControlLabelPart			= 1;
	kControlMenuPart			= 2;
	kControlTrianglePart		= 4;
	kControlButtonPart			= 10;
	kControlCheckBoxPart		= 11;
	kControlRadioButtonPart		= 11;
	kControlUpButtonPart		= 20;
	kControlDownButtonPart		= 21;
	kControlPageUpPart			= 22;
	kControlPageDownPart		= 23;
	kControlIndicatorPart		= 129;
	kControlDisabledPart		= 254;
	kControlInactivePart		= 255;

{_________________________________________________________________________________________________________}
{}
{ • CHECK BOX VALUES}
{}
{_________________________________________________________________________________________________________}
	kControlCheckboxUncheckedValue = 0;
	kControlCheckboxCheckedValue = 1;
	kControlCheckboxMixedValue	= 2;

{_________________________________________________________________________________________________________}
{}
{ • RADIO BUTTON VALUES}
{}
{_________________________________________________________________________________________________________}
	kControlRadioButtonUncheckedValue = 0;
	kControlRadioButtonCheckedValue = 1;
	kControlRadioButtonMixedValue = 2;

{_________________________________________________________________________________________________________}
{ }
{ • CONTROL POP-UP MENU CONSTANTS}
{}
{_________________________________________________________________________________________________________}
{}
{ Variant codes for the System 7 pop-up menu}
{}
	popupFixedWidth				= 1 * (2**(0));
	popupVariableWidth			= 1 * (2**(1));
	popupUseAddResMenu			= 1 * (2**(2));
	popupUseWFont				= 1 * (2**(3));

{}
{ Menu label styles for the System 7 pop-up menu }
{}
	popupTitleBold				= 1 * (2**(8));
	popupTitleItalic			= 1 * (2**(9));
	popupTitleUnderline			= 1 * (2**(10));
	popupTitleOutline			= 1 * (2**(11));
	popupTitleShadow			= 1 * (2**(12));
	popupTitleCondense			= 1 * (2**(13));
	popupTitleExtend			= 1 * (2**(14));
	popupTitleNoStyle			= 1 * (2**(15));

{}
{ Menu label justifications for the System 7 pop-up menu}
{}
	popupTitleLeftJust			= $00000000;
	popupTitleCenterJust		= $00000001;
	popupTitleRightJust			= $000000FF;

{_________________________________________________________________________________________________________}
{}
{ • CONTROL DRAGGRAYRGN CONSTANTS}
{}
{   For DragGrayRgnUPP used in TrackControl() }
{}
{_________________________________________________________________________________________________________}
	noConstraint				= kNoConstraint;
	hAxisOnly					= 1;
	vAxisOnly					= 2;

{_________________________________________________________________________________________________________}
{}
{ • CONTROL COLOR TABLE PART CODES}
{}
{_________________________________________________________________________________________________________}
	cFrameColor					= 0;
	cBodyColor					= 1;
	cTextColor					= 2;
	cThumbColor					= 3;

{_________________________________________________________________________________________________________}
{}
{ • CONTROL TYPE DECLARATIONS}
{}
{_________________________________________________________________________________________________________}
{}
{ Define ControlRef and ControlHandle}
{}	
TYPE
	ControlPtr = ^ControlRecord;
	ControlHandle = ^ControlPtr;

	ControlRef = ControlHandle;

{_________________________________________________________________________________________________________}
{}
{ • CONTROL ACTIONPROC POINTER}
{}
{_________________________________________________________________________________________________________}
	ControlActionProcPtr = ProcPtr;  { PROCEDURE ControlAction(theControl: ControlHandle; partCode: ControlPartCode); }
	ControlActionUPP = UniversalProcPtr;

{_________________________________________________________________________________________________________}
{}
{ • CONTROL COLOR TABLE STRUCTURE}
{}
{_________________________________________________________________________________________________________}
	CtlCTab = RECORD
		ccSeed:					SInt32;
		ccRider:				SInt16;
		ctSize:					SInt16;
		ctTable:				ARRAY [0..3] OF ColorSpec;
	END;

	CCTabPtr = ^CtlCTab;
	CCTabHandle = ^CCTabPtr;


{_________________________________________________________________________________________________________}
{}
{ • CONTROL RECORD STRUCTURE}
{}
{_________________________________________________________________________________________________________}
	ControlRecord = PACKED RECORD
		nextControl:			ControlHandle;
		contrlOwner:			WindowPtr;
		contrlRect:				Rect;
		contrlVis:				UInt8;
		contrlHilite:			UInt8;
		contrlValue:			SInt16;
		contrlMin:				SInt16;
		contrlMax:				SInt16;
		contrlDefProc:			Handle;
		contrlData:				Handle;
		contrlAction:			ControlActionUPP;
		contrlRfCon:			SInt32;
		contrlTitle:			Str255;
	END;

{_________________________________________________________________________________________________________}
{}
{ • AUXILLARY CONTROL RECORD STRUCTURE}
{}
{_________________________________________________________________________________________________________}
	AuxCtlRec = RECORD
		acNext:					Handle;
		acOwner:				ControlHandle;
		acCTable:				CCTabHandle;
		acFlags:				SInt16;
		acReserved:				SInt32;
		acRefCon:				SInt32;
	END;

	AuxCtlPtr = ^AuxCtlRec;
	AuxCtlHandle = ^AuxCtlPtr;

{_________________________________________________________________________________________________________}
{}
{ • POP-UP MENU PRIVATE DATA STRUCTURE}
{}
{_________________________________________________________________________________________________________}
	PopupPrivateData = RECORD
		mHandle:				MenuHandle;
		mID:					SInt16;
	END;

	PopupPrivateDataPtr = ^PopupPrivateData;
	PopupPrivateDataHandle = ^PopupPrivateDataPtr;



CONST
	uppControlActionProcInfo = $000002C0; { PROCEDURE (4 byte param, 2 byte param); }

FUNCTION NewControlActionProc(userRoutine: ControlActionProcPtr): ControlActionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallControlActionProc(theControl: ControlHandle; partCode: ControlPartCode; userRoutine: ControlActionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL CREATION / DELETION API'S}
{}
{_________________________________________________________________________________________________________}

FUNCTION NewControl(theWindow: WindowPtr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; value: SInt16; min: SInt16; max: SInt16; procID: SInt16; refCon: SInt32): ControlHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A954;
	{$ENDC}
FUNCTION GetNewControl(controlID: SInt16; owner: WindowPtr): ControlHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9BE;
	{$ENDC}
PROCEDURE DisposeControl(theControl: ControlHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A955;
	{$ENDC}
PROCEDURE KillControls(theWindow: WindowPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A956;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL SHOWING/HIDING API'S}
{}
{_________________________________________________________________________________________________________}
PROCEDURE ShowControl(theControl: ControlHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A957;
	{$ENDC}
PROCEDURE HideControl(theControl: ControlHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A958;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL DRAWING API'S}
{}
{_________________________________________________________________________________________________________}
PROCEDURE DrawControls(theWindow: WindowPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A969;
	{$ENDC}
PROCEDURE Draw1Control(theControl: ControlHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A96D;
	{$ENDC}
PROCEDURE UpdateControls(theWindow: WindowPtr; updateRegion: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A953;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL HIGHLIGHT API'S}
{}
{_________________________________________________________________________________________________________}
PROCEDURE HiliteControl(theControl: ControlHandle; hiliteState: ControlPartCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95D;
	{$ENDC}
FUNCTION TrackControl(theControl: ControlHandle; thePoint: Point; actionProc: ControlActionUPP): ControlPartCode;
	{$IFC NOT GENERATINGCFM}
	INLINE $A968;
	{$ENDC}
PROCEDURE DragControl(theControl: ControlHandle; startPoint: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: DragConstraint);
	{$IFC NOT GENERATINGCFM}
	INLINE $A967;
	{$ENDC}
FUNCTION TestControl(theControl: ControlHandle; thePoint: Point): ControlPartCode;
	{$IFC NOT GENERATINGCFM}
	INLINE $A966;
	{$ENDC}
FUNCTION FindControl(thePoint: Point; theWindow: WindowPtr; VAR theControl: ControlHandle): ControlPartCode;
	{$IFC NOT GENERATINGCFM}
	INLINE $A96C;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL MOVING/SIZING API'S}
{}
{_________________________________________________________________________________________________________}
PROCEDURE MoveControl(theControl: ControlHandle; h: SInt16; v: SInt16);
	{$IFC NOT GENERATINGCFM}
	INLINE $A959;
	{$ENDC}
PROCEDURE SizeControl(theControl: ControlHandle; w: SInt16; h: SInt16);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95C;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL TITLE API'S}
{}
{_________________________________________________________________________________________________________}
PROCEDURE SetControlTitle(theControl: ControlHandle; title: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95F;
	{$ENDC}
PROCEDURE GetControlTitle(theControl: ControlHandle; VAR title: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95E;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL VALUE, MIMIMUM, AND MAXIMUM API'S}
{}
{_________________________________________________________________________________________________________}
FUNCTION GetControlValue(theControl: ControlHandle): SInt16;
	{$IFC NOT GENERATINGCFM}
	INLINE $A960;
	{$ENDC}
PROCEDURE SetControlValue(theControl: ControlHandle; newValue: SInt16);
	{$IFC NOT GENERATINGCFM}
	INLINE $A963;
	{$ENDC}
FUNCTION GetControlMinimum(theControl: ControlHandle): SInt16;
	{$IFC NOT GENERATINGCFM}
	INLINE $A961;
	{$ENDC}
PROCEDURE SetControlMinimum(theControl: ControlHandle; newMinimum: SInt16);
	{$IFC NOT GENERATINGCFM}
	INLINE $A964;
	{$ENDC}
FUNCTION GetControlMaximum(theControl: ControlHandle): SInt16;
	{$IFC NOT GENERATINGCFM}
	INLINE $A962;
	{$ENDC}
PROCEDURE SetControlMaximum(theControl: ControlHandle; newMaximum: SInt16);
	{$IFC NOT GENERATINGCFM}
	INLINE $A965;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL VARIANT AND WINDOW INFORMATION API'S}
{}
{_________________________________________________________________________________________________________}
FUNCTION GetControlVariant(theControl: ControlHandle): SInt16;
	{$IFC NOT GENERATINGCFM}
	INLINE $A809;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL ACTION PROC API'S}
{}
{_________________________________________________________________________________________________________}
PROCEDURE SetControlAction(theControl: ControlHandle; actionProc: ControlActionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $A96B;
	{$ENDC}
FUNCTION GetControlAction(theControl: ControlHandle): ControlActionUPP;
	{$IFC NOT GENERATINGCFM}
	INLINE $A96A;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONTROL ACCESSOR API'S}
{}
{_________________________________________________________________________________________________________}
PROCEDURE SetControlReference(theControl: ControlHandle; data: SInt32);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95B;
	{$ENDC}
FUNCTION GetControlReference(theControl: ControlHandle): SInt32;
	{$IFC NOT GENERATINGCFM}
	INLINE $A95A;
	{$ENDC}
{
*****************************************************************************
*                                                                           *
* The conditional STRICT_CONTROLS has been removed from this interface file.*
* The accessor macros to a ControlRecord are no longer necessary.           *
*                                                                           *
*****************************************************************************

Details:
The original purpose of the STRICT_ conditionals and accessor macros was to
help ease the transition to Copland.   Shared data structures are difficult
to coordinate in a preemptive multitasking OS.  By hiding the fields in a
WindowRecord and other data structures, we would begin the migration to 
system data structures being completely hidden from applications. 

After many design reviews, it was finally concluded that with this sort of
migration, the system could never tell when an application was no longer 
peeking at a WindowRecord, and thus the data structure might never become 
system owned.  Additionally, there were many other limitations in the classic
toolbox that were begging to be addressed.

The final decision was to leave the traditional toolbox as a compatibility mode.
The preferred toolbox API for Copland is a new SOM(tm) based architecture 
(e.g. HIWindows.idl).  Windows, menu, controls, etc are each a SOM object 
with methods for drawing, event handling, and customization.


}
FUNCTION GetAuxiliaryControlRecord(theControl: ControlHandle; VAR acHndl: AuxCtlHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA44;
	{$ENDC}
PROCEDURE SetControlColor(theControl: ControlHandle; newColorTable: CCTabHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA43;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • VALID 'CDEF' MESSAGES}
{}
{_________________________________________________________________________________________________________}
	
TYPE
	ControlDefProcMessage = SInt16;


CONST
	drawCntl					= 0;
	testCntl					= 1;
	calcCRgns					= 2;
	initCntl					= 3;
	dispCntl					= 4;
	posCntl						= 5;
	thumbCntl					= 6;
	dragCntl					= 7;
	autoTrack					= 8;
	calcCntlRgn					= 10;
	calcThumbRgn				= 11;
	drawThumbOutline			= 12;

{_________________________________________________________________________________________________________}
{    }
{ • MAIN ENTRY POINT FOR 'CDEF'}
{}
{_________________________________________________________________________________________________________}
TYPE
	ControlDefProcPtr = ProcPtr;  { FUNCTION ControlDef(varCode: SInt16; theControl: ControlHandle; message: ControlDefProcMessage; param: SInt32): SInt32; }
	ControlDefUPP = UniversalProcPtr;

CONST
	uppControlDefProcInfo = $00003BB0; { FUNCTION (2 byte param, 4 byte param, 2 byte param, 4 byte param): 4 byte result; }

FUNCTION NewControlDefProc(userRoutine: ControlDefProcPtr): ControlDefUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallControlDefProc(varCode: SInt16; theControl: ControlHandle; message: ControlDefProcMessage; param: SInt32; userRoutine: ControlDefUPP): SInt32;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
{_________________________________________________________________________________________________________}
{    }
{ • CONSTANTS FOR DRAWCNTL MESSAGE PASSED IN PARAM}
{}
{_________________________________________________________________________________________________________}

CONST
	kDrawControlEntireControl	= 0;
	kDrawControlIndicatorOnly	= 129;

{_________________________________________________________________________________________________________}
{    }
{ • CONSTANTS FOR DRAGCNTL MESSAGE PASSED IN PARAM}
{}
{_________________________________________________________________________________________________________}
	kDragControlEntireControl	= 0;
	kDragControlIndicator		= 1;

{_________________________________________________________________________________________________________}
{    }
{ • DRAG CONSTRAINT STRUCTURE PASSED IN PARAM FOR THUMBCNTL MESSAGE (IM I-332)}
{}
{_________________________________________________________________________________________________________}

TYPE
	IndicatorDragConstraint = RECORD
		limitRect:				Rect;
		slopRect:				Rect;
		axis:					DragConstraint;
	END;

	IndicatorDragConstraintPtr = ^IndicatorDragConstraint;
	IndicatorDragConstraintHandle = ^IndicatorDragConstraintPtr;

{_________________________________________________________________________________________________________}
{}
{ • OLD ROUTINE NAMES}
{}
{   These are provided for compatiblity with older source bases.  It is recommended to not use them since}
{	 they may removed from this interface file at any time.}
{}
{_________________________________________________________________________________________________________}
{$IFC OLDROUTINENAMES }

CONST
	useWFont					= 8;

	inLabel						= 1;
	inMenu						= 2;
	inTriangle					= 4;
	inButton					= 10;
	inCheckBox					= 11;
	inUpButton					= 20;
	inDownButton				= 21;
	inPageUp					= 22;
	inPageDown					= 23;
	inThumb						= 129;

	kNoHiliteControlPart		= 0;
	kInLabelControlPart			= 1;
	kInMenuControlPart			= 2;
	kInTriangleControlPart		= 4;
	kInButtonControlPart		= 10;
	kInCheckBoxControlPart		= 11;
	kInUpButtonControlPart		= 20;
	kInDownButtonControlPart	= 21;
	kInPageUpControlPart		= 22;
	kInPageDownControlPart		= 23;
	kInIndicatorControlPart		= 129;
	kReservedControlPart		= 254;
	kControlInactiveControlPart	= 255;

{$ENDC}
{$IFC OLDROUTINENAMES }

PROCEDURE SetCTitle(theControl: ControlHandle; title: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95F;
	{$ENDC}
PROCEDURE GetCTitle(theControl: ControlHandle; VAR title: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95E;
	{$ENDC}
PROCEDURE UpdtControl(theWindow: WindowPtr; updateRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A953;
	{$ENDC}
PROCEDURE SetCtlValue(theControl: ControlHandle; theValue: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A963;
	{$ENDC}
FUNCTION GetCtlValue(theControl: ControlHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A960;
	{$ENDC}
PROCEDURE SetCtlMin(theControl: ControlHandle; minValue: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A964;
	{$ENDC}
FUNCTION GetCtlMin(theControl: ControlHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A961;
	{$ENDC}
PROCEDURE SetCtlMax(theControl: ControlHandle; maxValue: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A965;
	{$ENDC}
FUNCTION GetCtlMax(theControl: ControlHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A962;
	{$ENDC}
PROCEDURE SetCRefCon(theControl: ControlHandle; data: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $A95B;
	{$ENDC}
FUNCTION GetCRefCon(theControl: ControlHandle): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A95A;
	{$ENDC}
PROCEDURE SetCtlAction(theControl: ControlHandle; actionProc: ControlActionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $A96B;
	{$ENDC}
FUNCTION GetCtlAction(theControl: ControlHandle): ControlActionUPP;
	{$IFC NOT GENERATINGCFM}
	INLINE $A96A;
	{$ENDC}
PROCEDURE SetCtlColor(theControl: ControlHandle; newColorTable: CCTabHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA43;
	{$ENDC}
FUNCTION GetCVariant(theControl: ControlHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A809;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ControlsIncludes}

{$ENDC} {__CONTROLS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
