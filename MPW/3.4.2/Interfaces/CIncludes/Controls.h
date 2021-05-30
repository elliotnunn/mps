/*
 	File:		Controls.h
 
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
 
*/

#ifndef __CONTROLS__
#define __CONTROLS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

#ifndef __MENUS__
#include <Menus.h>
#endif
/*	#include <Memory.h>											*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*
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
*/

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL DEFINITION ID'S*/
/**/
/*_________________________________________________________________________________________________________*/
/**/
/* Standard System 7 procID's for use only with NewControl()*/
/**/

enum {
	pushButProc					= 0,
	checkBoxProc				= 1,
	radioButProc				= 2,
	scrollBarProc				= 16,
	popupMenuProc				= 1008
};

enum {
	kControlUsesOwningWindowsFontVariant = 1 << 3				/* Control uses owning windows font to display text*/
};

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL PART CODES*/
/**/
/*_________________________________________________________________________________________________________*/
typedef SInt16 ControlPartCode;


enum {
	kControlNoPart				= 0,
	kControlLabelPart			= 1,
	kControlMenuPart			= 2,
	kControlTrianglePart		= 4,
	kControlButtonPart			= 10,
	kControlCheckBoxPart		= 11,
	kControlRadioButtonPart		= 11,
	kControlUpButtonPart		= 20,
	kControlDownButtonPart		= 21,
	kControlPageUpPart			= 22,
	kControlPageDownPart		= 23,
	kControlIndicatorPart		= 129,
	kControlDisabledPart		= 254,
	kControlInactivePart		= 255
};

/*_________________________________________________________________________________________________________*/
/**/
/* • CHECK BOX VALUES*/
/**/
/*_________________________________________________________________________________________________________*/
enum {
	kControlCheckboxUncheckedValue = 0,
	kControlCheckboxCheckedValue = 1,
	kControlCheckboxMixedValue	= 2
};

/*_________________________________________________________________________________________________________*/
/**/
/* • RADIO BUTTON VALUES*/
/**/
/*_________________________________________________________________________________________________________*/
enum {
	kControlRadioButtonUncheckedValue = 0,
	kControlRadioButtonCheckedValue = 1,
	kControlRadioButtonMixedValue = 2
};

/*_________________________________________________________________________________________________________*/
/* */
/* • CONTROL POP-UP MENU CONSTANTS*/
/**/
/*_________________________________________________________________________________________________________*/
/**/
/* Variant codes for the System 7 pop-up menu*/
/**/
enum {
	popupFixedWidth				= 1 << 0,
	popupVariableWidth			= 1 << 1,
	popupUseAddResMenu			= 1 << 2,
	popupUseWFont				= 1 << 3
};

/**/
/* Menu label styles for the System 7 pop-up menu */
/**/
enum {
	popupTitleBold				= 1 << 8,
	popupTitleItalic			= 1 << 9,
	popupTitleUnderline			= 1 << 10,
	popupTitleOutline			= 1 << 11,
	popupTitleShadow			= 1 << 12,
	popupTitleCondense			= 1 << 13,
	popupTitleExtend			= 1 << 14,
	popupTitleNoStyle			= 1 << 15
};

/**/
/* Menu label justifications for the System 7 pop-up menu*/
/**/
enum {
	popupTitleLeftJust			= 0x00000000,
	popupTitleCenterJust		= 0x00000001,
	popupTitleRightJust			= 0x000000FF
};

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL DRAGGRAYRGN CONSTANTS*/
/**/
/*   For DragGrayRgnUPP used in TrackControl() */
/**/
/*_________________________________________________________________________________________________________*/
enum {
	noConstraint				= kNoConstraint,
	hAxisOnly					= 1,
	vAxisOnly					= 2
};

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL COLOR TABLE PART CODES*/
/**/
/*_________________________________________________________________________________________________________*/
enum {
	cFrameColor					= 0,
	cBodyColor					= 1,
	cTextColor					= 2,
	cThumbColor					= 3
};

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL TYPE DECLARATIONS*/
/**/
/*_________________________________________________________________________________________________________*/
/**/
/* Define ControlRef and ControlHandle*/
/**/
typedef struct ControlRecord ControlRecord, *ControlPtr, **ControlHandle;

typedef ControlHandle ControlRef;

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL ACTIONPROC POINTER*/
/**/
/*_________________________________________________________________________________________________________*/
typedef pascal void (*ControlActionProcPtr)(ControlHandle theControl, ControlPartCode partCode);

#if GENERATINGCFM
typedef UniversalProcPtr ControlActionUPP;
#else
typedef ControlActionProcPtr ControlActionUPP;
#endif

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL COLOR TABLE STRUCTURE*/
/**/
/*_________________________________________________________________________________________________________*/
struct CtlCTab {
	SInt32							ccSeed;
	SInt16							ccRider;
	SInt16							ctSize;
	ColorSpec						ctTable[4];
};
typedef struct CtlCTab CtlCTab;

typedef CtlCTab *CCTabPtr, **CCTabHandle;

/*_________________________________________________________________________________________________________*/
/**/
/* • CONTROL RECORD STRUCTURE*/
/**/
/*_________________________________________________________________________________________________________*/
struct ControlRecord {
	ControlHandle					nextControl;
	WindowPtr						contrlOwner;
	Rect							contrlRect;
	UInt8							contrlVis;
	UInt8							contrlHilite;
	SInt16							contrlValue;
	SInt16							contrlMin;
	SInt16							contrlMax;
	Handle							contrlDefProc;
	Handle							contrlData;
	ControlActionUPP				contrlAction;
	SInt32							contrlRfCon;
	Str255							contrlTitle;
};
/*_________________________________________________________________________________________________________*/
/**/
/* • AUXILLARY CONTROL RECORD STRUCTURE*/
/**/
/*_________________________________________________________________________________________________________*/
struct AuxCtlRec {
	Handle							acNext;
	ControlHandle					acOwner;
	CCTabHandle						acCTable;
	SInt16							acFlags;
	SInt32							acReserved;
	SInt32							acRefCon;
};
typedef struct AuxCtlRec AuxCtlRec;

typedef AuxCtlRec *AuxCtlPtr, **AuxCtlHandle;

/*_________________________________________________________________________________________________________*/
/**/
/* • POP-UP MENU PRIVATE DATA STRUCTURE*/
/**/
/*_________________________________________________________________________________________________________*/
struct PopupPrivateData {
	MenuHandle						mHandle;
	SInt16							mID;
};
typedef struct PopupPrivateData PopupPrivateData;

typedef PopupPrivateData *PopupPrivateDataPtr, **PopupPrivateDataHandle;


#if GENERATINGCFM
#else
#endif

enum {
	uppControlActionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ControlHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(ControlPartCode)))
};

#if GENERATINGCFM
#define NewControlActionProc(userRoutine)		\
		(ControlActionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlActionProcInfo, GetCurrentArchitecture())
#else
#define NewControlActionProc(userRoutine)		\
		((ControlActionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallControlActionProc(userRoutine, theControl, partCode)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppControlActionProcInfo, (theControl), (partCode))
#else
#define CallControlActionProc(userRoutine, theControl, partCode)		\
		(*(userRoutine))((theControl), (partCode))
#endif

/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL CREATION / DELETION API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal ControlHandle NewControl(WindowPtr theWindow, const Rect *boundsRect, ConstStr255Param title, Boolean visible, SInt16 value, SInt16 min, SInt16 max, SInt16 procID, SInt32 refCon)
 ONEWORDINLINE(0xA954);
extern pascal ControlHandle GetNewControl(SInt16 controlID, WindowPtr owner)
 ONEWORDINLINE(0xA9BE);
extern pascal void DisposeControl(ControlHandle theControl)
 ONEWORDINLINE(0xA955);
extern pascal void KillControls(WindowPtr theWindow)
 ONEWORDINLINE(0xA956);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL SHOWING/HIDING API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal void ShowControl(ControlHandle theControl)
 ONEWORDINLINE(0xA957);
extern pascal void HideControl(ControlHandle theControl)
 ONEWORDINLINE(0xA958);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL DRAWING API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal void DrawControls(WindowPtr theWindow)
 ONEWORDINLINE(0xA969);
extern pascal void Draw1Control(ControlHandle theControl)
 ONEWORDINLINE(0xA96D);
#define DrawOneControl(theControl) Draw1Control(theControl)
extern pascal void UpdateControls(WindowPtr theWindow, RgnHandle updateRegion)
 ONEWORDINLINE(0xA953);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL HIGHLIGHT API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal void HiliteControl(ControlHandle theControl, ControlPartCode hiliteState)
 ONEWORDINLINE(0xA95D);
extern pascal ControlPartCode TrackControl(ControlHandle theControl, Point thePoint, ControlActionUPP actionProc)
 ONEWORDINLINE(0xA968);
extern pascal void DragControl(ControlHandle theControl, Point startPoint, const Rect *limitRect, const Rect *slopRect, DragConstraint axis)
 ONEWORDINLINE(0xA967);
extern pascal ControlPartCode TestControl(ControlHandle theControl, Point thePoint)
 ONEWORDINLINE(0xA966);
extern pascal ControlPartCode FindControl(Point thePoint, WindowPtr theWindow, ControlHandle *theControl)
 ONEWORDINLINE(0xA96C);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL MOVING/SIZING API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal void MoveControl(ControlHandle theControl, SInt16 h, SInt16 v)
 ONEWORDINLINE(0xA959);
extern pascal void SizeControl(ControlHandle theControl, SInt16 w, SInt16 h)
 ONEWORDINLINE(0xA95C);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL TITLE API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal void SetControlTitle(ControlHandle theControl, ConstStr255Param title)
 ONEWORDINLINE(0xA95F);
extern pascal void GetControlTitle(ControlHandle theControl, Str255 title)
 ONEWORDINLINE(0xA95E);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL VALUE, MIMIMUM, AND MAXIMUM API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal SInt16 GetControlValue(ControlHandle theControl)
 ONEWORDINLINE(0xA960);
extern pascal void SetControlValue(ControlHandle theControl, SInt16 newValue)
 ONEWORDINLINE(0xA963);
extern pascal SInt16 GetControlMinimum(ControlHandle theControl)
 ONEWORDINLINE(0xA961);
extern pascal void SetControlMinimum(ControlHandle theControl, SInt16 newMinimum)
 ONEWORDINLINE(0xA964);
extern pascal SInt16 GetControlMaximum(ControlHandle theControl)
 ONEWORDINLINE(0xA962);
extern pascal void SetControlMaximum(ControlHandle theControl, SInt16 newMaximum)
 ONEWORDINLINE(0xA965);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL VARIANT AND WINDOW INFORMATION API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal SInt16 GetControlVariant(ControlHandle theControl)
 ONEWORDINLINE(0xA809);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL ACTION PROC API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal void SetControlAction(ControlHandle theControl, ControlActionUPP actionProc)
 ONEWORDINLINE(0xA96B);
extern pascal ControlActionUPP GetControlAction(ControlHandle theControl)
 ONEWORDINLINE(0xA96A);
/*_________________________________________________________________________________________________________*/
/*    */
/* • CONTROL ACCESSOR API'S*/
/**/
/*_________________________________________________________________________________________________________*/
extern pascal void SetControlReference(ControlHandle theControl, SInt32 data)
 ONEWORDINLINE(0xA95B);
extern pascal SInt32 GetControlReference(ControlHandle theControl)
 ONEWORDINLINE(0xA95A);
/*
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

*/
#define GetControlListFromWindow(theWindowPtr)		( *(ControlHandle *) (((UInt8 *) theWindowPtr) + sizeof(GrafPort) + 0x20))

extern pascal Boolean GetAuxiliaryControlRecord(ControlHandle theControl, AuxCtlHandle *acHndl)
 ONEWORDINLINE(0xAA44);

extern pascal void SetControlColor(ControlHandle theControl, CCTabHandle newColorTable)
 ONEWORDINLINE(0xAA43);
/*_________________________________________________________________________________________________________*/
/*    */
/* • VALID 'CDEF' MESSAGES*/
/**/
/*_________________________________________________________________________________________________________*/
typedef SInt16 ControlDefProcMessage;


enum {
	drawCntl					= 0,
	testCntl					= 1,
	calcCRgns					= 2,
	initCntl					= 3,
	dispCntl					= 4,
	posCntl						= 5,
	thumbCntl					= 6,
	dragCntl					= 7,
	autoTrack					= 8,
	calcCntlRgn					= 10,
	calcThumbRgn				= 11,
	drawThumbOutline			= 12
};

/*_________________________________________________________________________________________________________*/
/*    */
/* • MAIN ENTRY POINT FOR 'CDEF'*/
/**/
/*_________________________________________________________________________________________________________*/
typedef pascal SInt32 (*ControlDefProcPtr)(SInt16 varCode, ControlHandle theControl, ControlDefProcMessage message, SInt32 param);

#if GENERATINGCFM
typedef UniversalProcPtr ControlDefUPP;
#else
typedef ControlDefProcPtr ControlDefUPP;
#endif

enum {
	uppControlDefProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(SInt32)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SInt16)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(ControlHandle)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(ControlDefProcMessage)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(SInt32)))
};

#if GENERATINGCFM
#define NewControlDefProc(userRoutine)		\
		(ControlDefUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppControlDefProcInfo, GetCurrentArchitecture())
#else
#define NewControlDefProc(userRoutine)		\
		((ControlDefUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallControlDefProc(userRoutine, varCode, theControl, message, param)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppControlDefProcInfo, (varCode), (theControl), (message), (param))
#else
#define CallControlDefProc(userRoutine, varCode, theControl, message, param)		\
		(*(userRoutine))((varCode), (theControl), (message), (param))
#endif

/*_________________________________________________________________________________________________________*/
/*    */
/* • CONSTANTS FOR DRAWCNTL MESSAGE PASSED IN PARAM*/
/**/
/*_________________________________________________________________________________________________________*/
enum {
	kDrawControlEntireControl	= 0,
	kDrawControlIndicatorOnly	= 129
};

/*_________________________________________________________________________________________________________*/
/*    */
/* • CONSTANTS FOR DRAGCNTL MESSAGE PASSED IN PARAM*/
/**/
/*_________________________________________________________________________________________________________*/
enum {
	kDragControlEntireControl	= 0,
	kDragControlIndicator		= 1
};

/*_________________________________________________________________________________________________________*/
/*    */
/* • DRAG CONSTRAINT STRUCTURE PASSED IN PARAM FOR THUMBCNTL MESSAGE (IM I-332)*/
/**/
/*_________________________________________________________________________________________________________*/
struct IndicatorDragConstraint {
	Rect							limitRect;
	Rect							slopRect;
	DragConstraint					axis;
};
typedef struct IndicatorDragConstraint IndicatorDragConstraint;

typedef IndicatorDragConstraint *IndicatorDragConstraintPtr, **IndicatorDragConstraintHandle;

/*_________________________________________________________________________________________________________*/
/**/
/* • OLD ROUTINE NAMES*/
/**/
/*   These are provided for compatiblity with older source bases.  It is recommended to not use them since*/
/*	 they may removed from this interface file at any time.*/
/**/
/*_________________________________________________________________________________________________________*/
#if OLDROUTINENAMES

enum {
	useWFont					= 8
};

enum {
	inLabel						= 1,
	inMenu						= 2,
	inTriangle					= 4,
	inButton					= 10,
	inCheckBox					= 11,
	inUpButton					= 20,
	inDownButton				= 21,
	inPageUp					= 22,
	inPageDown					= 23,
	inThumb						= 129
};

enum {
	kNoHiliteControlPart		= 0,
	kInLabelControlPart			= 1,
	kInMenuControlPart			= 2,
	kInTriangleControlPart		= 4,
	kInButtonControlPart		= 10,
	kInCheckBoxControlPart		= 11,
	kInUpButtonControlPart		= 20,
	kInDownButtonControlPart	= 21,
	kInPageUpControlPart		= 22,
	kInPageDownControlPart		= 23,
	kInIndicatorControlPart		= 129,
	kReservedControlPart		= 254,
	kControlInactiveControlPart	= 255
};

#endif
#if CGLUESUPPORTED
extern void dragcontrol(ControlHandle theControl, Point *startPt, const Rect *limitRect, const Rect *slopRect, short axis);
extern ControlHandle newcontrol(WindowPtr theWindow, const Rect *boundsRect, const char *title, Boolean visible, short value, short min, short max, short procID, long refCon);
extern short findcontrol(Point *thePoint, WindowPtr theWindow, ControlHandle *theControl);
extern void getcontroltitle(ControlHandle theControl, char *title);
extern void setcontroltitle(ControlHandle theControl, const char *title);
extern short trackcontrol(ControlHandle theControl, Point *thePoint, ControlActionUPP actionProc);
extern short testcontrol(ControlHandle theControl, Point *thePt);
#endif
#if OLDROUTINENAMES
#define GetControlOwningWindowControlList(theWindowPtr)		( *(ControlHandle *) (((UInt8 *) theWindowPtr) + sizeof(GrafPort) + 0x20))
#define SetCTitle(theControl, title) SetControlTitle(theControl, title)
#define GetCTitle(theControl, title) GetControlTitle(theControl, title)
#define UpdtControl(theWindow, updateRgn) UpdateControls(theWindow, updateRgn)
#define SetCtlValue(theControl, theValue) SetControlValue(theControl, theValue)
#define GetCtlValue(theControl) GetControlValue(theControl)
#define SetCtlMin(theControl, minValue) SetControlMinimum(theControl, minValue)
#define GetCtlMin(theControl) GetControlMinimum(theControl)
#define SetCtlMax(theControl, maxValue) SetControlMaximum(theControl, maxValue)
#define GetCtlMax(theControl) GetControlMaximum(theControl)
#define GetAuxCtl(theControl, acHndl) GetAuxiliaryControlRecord(theControl, acHndl)
#define SetCRefCon(theControl, data) SetControlReference(theControl, data)
#define GetCRefCon(theControl) GetControlReference(theControl)
#define SetCtlAction(theControl, actionProc) SetControlAction(theControl, actionProc)
#define GetCtlAction(theControl) GetControlAction(theControl)
#define SetCtlColor(theControl, newColorTable) SetControlColor(theControl, newColorTable)
#define GetCVariant(theControl) GetControlVariant(theControl)
#if CGLUESUPPORTED
#define getctitle(theControl, title) getcontroltitle(theControl, title)
#define setctitle(theControl, title) setcontroltitle(theControl, title)
#endif
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CONTROLS__ */
