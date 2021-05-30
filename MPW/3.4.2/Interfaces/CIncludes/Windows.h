/*
 	File:		Windows.h
 
 	Contains:	Window Manager Interfaces.
 
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

#ifndef __WINDOWS__
#define __WINDOWS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MEMORY__
#include <Memory.h>
#endif
/*	#include <MixedMode.h>										*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <QuickdrawText.h>									*/

#ifndef __EVENTS__
#include <Events.h>
#endif
/*	#include <OSUtils.h>										*/

#ifndef __CONTROLS__
#include <Controls.h>
#endif
/*	#include <Menus.h>											*/

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
	*****************************************************************************
	*                                                                           *
	* The conditional STRICT_WINDOWS has been removed from this interface file. *
	* The accessor macros to a WindowRecord are no longer necessary.            *
	*                                                                           *
	* All ≈Ref Types have reverted to their original Handle and Ptr Types.      *
	*                                                                           *
	*****************************************************************************

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

#ifdef __cplusplus
inline CGrafPtr	GetWindowPort(WindowPtr w) 					{ return (CGrafPtr) w; 													}
inline void		SetPortWindowPort(WindowPtr aWindowPtr)		{	SetPort( (GrafPtr) GetWindowPort(aWindowPtr)); }
inline SInt16		GetWindowKind(WindowPtr w) 					{ return ( *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort))); 			}
inline void		SetWindowKind(WindowPtr	w, SInt16 wKind)	{  *(SInt16 *)	(((UInt8 *) w) + sizeof(GrafPort)) = wKind;  			}
inline	Boolean		IsWindowVisible(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x2); 		}
inline Boolean		IsWindowHilited(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x3);		}
inline Boolean		GetWindowGoAwayFlag(WindowPtr w)			{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x4);		}
inline Boolean		GetWindowZoomFlag(WindowPtr w)				{ return *(Boolean *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x5);		}
inline void		GetWindowStructureRgn(WindowPtr w, RgnHandle r)	{	CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0x6), r );	}
inline void		GetWindowContentRgn(WindowPtr w, RgnHandle r)	{	CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xA), r );	}
inline void		GetWindowUpdateRgn(WindowPtr w, RgnHandle r)	{	CopyRgn( *(RgnHandle *)(((UInt8 *) w) + sizeof(GrafPort) + 0xE), r );	}
inline SInt16		GetWindowTitleWidth(WindowPtr w)				{ return *(SInt16 *)(((UInt8 *) w) + sizeof(GrafPort) + 0x1E);			}
inline WindowPtr	GetNextWindow(WindowPtr w)						{ return *(WindowPtr *)	(((UInt8 *) w) + sizeof(GrafPort) + 0x24);		}
inline void	GetWindowStandardState(WindowPtr w, Rect *r)  {	Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	if (stateRects != NULL)	*r = stateRects[1];		}
inline void	SetWindowStandardState(WindowPtr w, const Rect *r)	{ 	Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16))); if (stateRects != NULL)	stateRects[1] = *r; 	}
inline void	GetWindowUserState(WindowPtr w, Rect *r)	{ 	Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	if (stateRects != NULL)	*r = stateRects[0]; }
inline void	SetWindowUserState(WindowPtr w, const Rect *r)	{ Rect *stateRects = (  (Rect *) (**(Handle *) (((UInt8 *) w) + sizeof(GrafPort) + 0x16)));	if (stateRects != NULL)	stateRects[0] = *r; }
#else
#define SetPortWindowPort(aWindowPtr) SetPort( (GrafPtr) GetWindowPort(aWindowPtr) )
#define GetWindowPort(aWindowPtr) ( (CGrafPtr) aWindowPtr)
#define GetWindowKind(aWindowPtr) ( *(SInt16 *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort)))
#define SetWindowKind(aWindowPtr, wKind) ( *(SInt16 *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort)) = wKind )
#define IsWindowVisible(aWindowPtr) ( *(Boolean *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x2))
#define IsWindowHilited(aWindowPtr) ( *(Boolean *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x3))
#define GetWindowGoAwayFlag(aWindowPtr) ( *(Boolean *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x4))
#define GetWindowZoomFlag(aWindowPtr) ( *(Boolean *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x5))
#define GetWindowStructureRgn(aWindowPtr, aRgnHandle) CopyRgn( *(RgnHandle *)(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x6),  \
	aRgnHandle )
#define GetWindowContentRgn(aWindowPtr, aRgnHandle) CopyRgn( *(RgnHandle *)(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0xA),  \
	aRgnHandle )
#define GetWindowUpdateRgn(aWindowPtr, aRgnHandle) CopyRgn( *(RgnHandle *)(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0xE),  \
	aRgnHandle )
#define GetWindowTitleWidth(aWindowPtr) ( *(SInt16 *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x1E))
#define GetNextWindow(aWindowPtr) ( *(WindowPtr *)	(((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x24))
#define GetWindowStandardState(aWindowPtr, aRectPtr) do { Rect *stateRects = ( (Rect *) (**(Handle *) (((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x16)));	 \
	if (stateRects != NULL)	*aRectPtr = stateRects[1]; } while (false)
#define SetWindowStandardState(aWindowPtr, aRectPtr) do { Rect *stateRects = ( (Rect *) (**(Handle *) (((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x16)));	 \
	if (stateRects != NULL)	stateRects[1] = *aRectPtr; } while (false)
#define GetWindowUserState(aWindowPtr, aRectPtr) do { Rect *stateRects = ( (Rect *) (**(Handle *) (((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x16)));	 \
	if (stateRects != NULL)	*aRectPtr = stateRects[0]; } while (false)
#define SetWindowUserState(aWindowPtr, aRectPtr) do { Rect *stateRects = ( (Rect *) (**(Handle *) (((UInt8 *) aWindowPtr) + sizeof(GrafPort) + 0x16)));	 \
	if (stateRects != NULL)	stateRects[0] = *aRectPtr; } while (false)
#endif

enum {
	kWindowDefProcType			= 'WDEF'
};

/*####################################################################################*/
/**/
/*	Window Definition ID's*/
/**/
/*####################################################################################*/
enum {
	kStandardWindowDefinition	= 0,							/* for document windows and dialogs*/
	kRoundWindowDefinition		= 1,							/* old da-style window*/
	kFloatingWindowDefinition	= 124							/* for floating windows*/
};

/*####################################################################################*/
/**/
/* Window Variant Codes*/
/**/
/*####################################################################################*/
enum {
/* for use with kStandardWindowDefinition */
	kModalDialogVariantCode		= 1,
	kMovableModalDialogVariantCode = 5,
/* for use with kFloatingWindowDefinition */
	kSideFloaterVariantCode		= 8
};

/*####################################################################################*/
/**/
/* Old-style procIDs.  For use only with New(C)Window*/
/**/
/*####################################################################################*/
enum {
	documentProc				= 0,
	dBoxProc					= 1,
	plainDBox					= 2,
	altDBoxProc					= 3,
	noGrowDocProc				= 4,
	movableDBoxProc				= 5,
	zoomDocProc					= 8,
	zoomNoGrow					= 12,
	rDocProc					= 16,
/* floating window defproc ids */
	floatProc					= 1985,
	floatGrowProc				= 1987,
	floatZoomProc				= 1989,
	floatZoomGrowProc			= 1991,
	floatSideProc				= 1993,
	floatSideGrowProc			= 1995,
	floatSideZoomProc			= 1997,
	floatSideZoomGrowProc		= 1999
};

/*####################################################################################*/
/**/
/* Standard window kinds*/
/**/
/*####################################################################################*/
enum {
	dialogKind					= 2,
	userKind					= 8,
	kDialogWindowKind			= 2,
	kApplicationWindowKind		= 8
};

/*####################################################################################*/
/**/
/* FindWindow result codes*/
/**/
/*####################################################################################*/
enum {
	inDesk						= 0,
	inMenuBar					= 1,
	inSysWindow					= 2,
	inContent					= 3,
	inDrag						= 4,
	inGrow						= 5,
	inGoAway					= 6,
	inZoomIn					= 7,
	inZoomOut					= 8
};

enum {
	wDraw						= 0,
	wHit						= 1,
	wCalcRgns					= 2,
	wNew						= 3,
	wDispose					= 4,
	wGrow						= 5,
	wDrawGIcon					= 6
};

enum {
	deskPatID					= 16
};

/*####################################################################################*/
/**/
/* Window Definition hit test result codes ("WindowPart")*/
/**/
/*####################################################################################*/
enum {
	wNoHit						= 0,
	wInContent					= 1,
	wInDrag						= 2,
	wInGrow						= 3,
	wInGoAway					= 4,
	wInZoomIn					= 5,
	wInZoomOut					= 6
};

typedef pascal long (*WindowDefProcPtr)(short varCode, WindowPtr theWindow, short message, long param);
/*
		DeskHookProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal void (*DeskHookProcPtr)(Boolean mouseClick, EventRecord *theEvent);

		In:
		 => mouseClick  	D0.B
		 => *theEvent   	A0.L
*/

#if GENERATINGCFM
typedef UniversalProcPtr WindowDefUPP;
typedef UniversalProcPtr DeskHookUPP;
#else
typedef WindowDefProcPtr WindowDefUPP;
typedef Register68kProcPtr DeskHookUPP;
#endif

enum {
	uppWindowDefProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(WindowPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long))),
	uppDeskHookProcInfo = kRegisterBased
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterD0, SIZE_CODE(sizeof(Boolean)))
		 | REGISTER_ROUTINE_PARAMETER(2, kRegisterA0, SIZE_CODE(sizeof(EventRecord*)))
};

#if GENERATINGCFM
#define NewWindowDefProc(userRoutine)		\
		(WindowDefUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowDefProcInfo, GetCurrentArchitecture())
#define NewDeskHookProc(userRoutine)		\
		(DeskHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDeskHookProcInfo, GetCurrentArchitecture())
#else
#define NewWindowDefProc(userRoutine)		\
		((WindowDefUPP) (userRoutine))
#define NewDeskHookProc(userRoutine)		\
		((DeskHookUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallWindowDefProc(userRoutine, varCode, theWindow, message, param)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppWindowDefProcInfo, (varCode), (theWindow), (message), (param))
#define CallDeskHookProc(userRoutine, mouseClick, theEvent)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDeskHookProcInfo, (mouseClick), (theEvent))
#else
#define CallWindowDefProc(userRoutine, varCode, theWindow, message, param)		\
		(*(userRoutine))((varCode), (theWindow), (message), (param))
/* (*DeskHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#endif

extern pascal RgnHandle GetGrayRgn( void )
	TWOWORDINLINE( 0x2EB8, 0x09EE ); /* MOVE.l $09EE,(SP) */
/*####################################################################################*/
/**/
/*	Color table defined for compatibility only.  Will move to some ifdef'd wasteland.*/
/**/
/*####################################################################################*/
struct WinCTab {
	long							wCSeed;						/* reserved */
	short							wCReserved;					/* reserved */
	short							ctSize;						/* usually 4 for windows */
	ColorSpec						ctTable[5];
};
typedef struct WinCTab WinCTab;

typedef WinCTab *WCTabPtr, **WCTabHandle;

extern pascal void InitWindows(void)
 ONEWORDINLINE(0xA912);
extern pascal void GetWMgrPort(GrafPtr *wPort)
 ONEWORDINLINE(0xA910);
extern pascal WindowPtr NewWindow(void *wStorage, const Rect *boundsRect, ConstStr255Param title, Boolean visible, short theProc, WindowPtr behind, Boolean goAwayFlag, long refCon)
 ONEWORDINLINE(0xA913);
extern pascal WindowPtr GetNewWindow(short windowID, void *wStorage, WindowPtr behind)
 ONEWORDINLINE(0xA9BD);
extern pascal void CloseWindow(WindowPtr theWindow)
 ONEWORDINLINE(0xA92D);
extern pascal void DisposeWindow(WindowPtr theWindow)
 ONEWORDINLINE(0xA914);
extern pascal void GetWTitle(WindowPtr theWindow, Str255 title)
 ONEWORDINLINE(0xA919);
extern pascal void SelectWindow(WindowPtr theWindow)
 ONEWORDINLINE(0xA91F);
extern pascal void HideWindow(WindowPtr theWindow)
 ONEWORDINLINE(0xA916);
extern pascal void ShowWindow(WindowPtr theWindow)
 ONEWORDINLINE(0xA915);
extern pascal void ShowHide(WindowPtr theWindow, Boolean showFlag)
 ONEWORDINLINE(0xA908);
extern pascal void HiliteWindow(WindowPtr theWindow, Boolean fHilite)
 ONEWORDINLINE(0xA91C);
extern pascal void BringToFront(WindowPtr theWindow)
 ONEWORDINLINE(0xA920);
extern pascal void SendBehind(WindowPtr theWindow, WindowPtr behindWindow)
 ONEWORDINLINE(0xA921);
extern pascal WindowPtr FrontWindow(void)
 ONEWORDINLINE(0xA924);
extern pascal void DrawGrowIcon(WindowPtr theWindow)
 ONEWORDINLINE(0xA904);
extern pascal void MoveWindow(WindowPtr theWindow, short hGlobal, short vGlobal, Boolean front)
 ONEWORDINLINE(0xA91B);
extern pascal void SizeWindow(WindowPtr theWindow, short w, short h, Boolean fUpdate)
 ONEWORDINLINE(0xA91D);
extern pascal void ZoomWindow(WindowPtr theWindow, short partCode, Boolean front)
 ONEWORDINLINE(0xA83A);
extern pascal void InvalRect(const Rect *badRect)
 ONEWORDINLINE(0xA928);
extern pascal void InvalRgn(RgnHandle badRgn)
 ONEWORDINLINE(0xA927);
extern pascal void ValidRect(const Rect *goodRect)
 ONEWORDINLINE(0xA92A);
extern pascal void ValidRgn(RgnHandle goodRgn)
 ONEWORDINLINE(0xA929);
extern pascal void BeginUpdate(WindowPtr theWindow)
 ONEWORDINLINE(0xA922);
extern pascal void EndUpdate(WindowPtr theWindow)
 ONEWORDINLINE(0xA923);
extern pascal void SetWRefCon(WindowPtr theWindow, long data)
 ONEWORDINLINE(0xA918);
extern pascal long GetWRefCon(WindowPtr theWindow)
 ONEWORDINLINE(0xA917);
extern pascal void SetWindowPic(WindowPtr theWindow, PicHandle pic)
 ONEWORDINLINE(0xA92E);
extern pascal PicHandle GetWindowPic(WindowPtr theWindow)
 ONEWORDINLINE(0xA92F);
extern pascal Boolean CheckUpdate(EventRecord *theEvent)
 ONEWORDINLINE(0xA911);
extern pascal void ClipAbove(WindowPtr window)
 ONEWORDINLINE(0xA90B);
extern pascal void SaveOld(WindowPtr window)
 ONEWORDINLINE(0xA90E);
extern pascal void DrawNew(WindowPtr window, Boolean update)
 ONEWORDINLINE(0xA90F);
extern pascal void PaintOne(WindowPtr window, RgnHandle clobberedRgn)
 ONEWORDINLINE(0xA90C);
extern pascal void PaintBehind(WindowPtr startWindow, RgnHandle clobberedRgn)
 ONEWORDINLINE(0xA90D);
extern pascal void CalcVis(WindowPtr window)
 ONEWORDINLINE(0xA909);
extern pascal void CalcVisBehind(WindowPtr startWindow, RgnHandle clobberedRgn)
 ONEWORDINLINE(0xA90A);
extern pascal long GrowWindow(WindowPtr theWindow, Point startPt, const Rect *bBox)
 ONEWORDINLINE(0xA92B);
extern pascal short FindWindow(Point thePoint, WindowPtr *theWindow)
 ONEWORDINLINE(0xA92C);
extern pascal long PinRect(const Rect *theRect, Point thePt)
 ONEWORDINLINE(0xA94E);
extern pascal long DragGrayRgn(RgnHandle theRgn, Point startPt, const Rect *limitRect, const Rect *slopRect, short axis, DragGrayRgnUPP actionProc)
 ONEWORDINLINE(0xA905);
extern pascal long DragTheRgn(RgnHandle theRgn, Point startPt, const Rect *limitRect, const Rect *slopRect, short axis, DragGrayRgnUPP actionProc)
 ONEWORDINLINE(0xA926);
extern pascal Boolean TrackBox(WindowPtr theWindow, Point thePt, short partCode)
 ONEWORDINLINE(0xA83B);
extern pascal void GetCWMgrPort(CGrafPtr *wMgrCPort)
 ONEWORDINLINE(0xAA48);
extern pascal void SetWinColor(WindowPtr theWindow, WCTabHandle newColorTable)
 ONEWORDINLINE(0xAA41);
extern pascal void SetDeskCPat(PixPatHandle deskPixPat)
 ONEWORDINLINE(0xAA47);
extern pascal WindowPtr NewCWindow(void *wStorage, const Rect *boundsRect, ConstStr255Param title, Boolean visible, short procID, WindowPtr behind, Boolean goAwayFlag, long refCon)
 ONEWORDINLINE(0xAA45);
extern pascal WindowPtr GetNewCWindow(short windowID, void *wStorage, WindowPtr behind)
 ONEWORDINLINE(0xAA46);
extern pascal short GetWVariant(WindowPtr theWindow)
 ONEWORDINLINE(0xA80A);
extern pascal void SetWTitle(WindowPtr theWindow, ConstStr255Param title)
 ONEWORDINLINE(0xA91A);
extern pascal Boolean TrackGoAway(WindowPtr theWindow, Point thePt)
 ONEWORDINLINE(0xA91E);
extern pascal void DragWindow(WindowPtr theWindow, Point startPt, const Rect *boundsRect)
 ONEWORDINLINE(0xA925);
#if CGLUESUPPORTED
extern void setwtitle(WindowPtr theWindow, const char *title);
extern Boolean trackgoaway(WindowPtr theWindow, Point *thePt);
extern short findwindow(Point *thePoint, WindowPtr *theWindow);
extern void getwtitle(WindowPtr theWindow, char *title);
extern long growwindow(WindowPtr theWindow, Point *startPt, const Rect *bBox);
extern WindowPtr newwindow(void *wStorage, const Rect *boundsRect, const char *title, Boolean visible, short theProc, WindowPtr behind, Boolean goAwayFlag, long refCon);
extern WindowPtr newcwindow(void *wStorage, const Rect *boundsRect, const char *title, Boolean visible, short procID, WindowPtr behind, Boolean goAwayFlag, long refCon);
extern long pinrect(const Rect *theRect, Point *thePt);
extern Boolean trackbox(WindowPtr theWindow, Point *thePt, short partCode);
extern long draggrayrgn(RgnHandle theRgn, Point *startPt, const Rect *boundsRect, const Rect *slopRect, short axis, DragGrayRgnUPP actionProc);
extern void dragwindow(WindowPtr theWindow, Point *startPt, const Rect *boundsRect);
#endif

typedef struct WindowRecord WindowRecord;

typedef WindowRecord *WindowPeek;

struct WindowRecord {
	GrafPort						port;
	short							windowKind;
	Boolean							visible;
	Boolean							hilited;
	Boolean							goAwayFlag;
	Boolean							spareFlag;
	RgnHandle						strucRgn;
	RgnHandle						contRgn;
	RgnHandle						updateRgn;
	Handle							windowDefProc;
	Handle							dataHandle;
	StringHandle					titleHandle;
	short							titleWidth;
	ControlHandle					controlList;
	WindowPeek						nextWindow;
	PicHandle						windowPic;
	long							refCon;
};
typedef struct CWindowRecord CWindowRecord;

typedef CWindowRecord *CWindowPeek;

struct CWindowRecord {
	CGrafPort						port;
	short							windowKind;
	Boolean							visible;
	Boolean							hilited;
	Boolean							goAwayFlag;
	Boolean							spareFlag;
	RgnHandle						strucRgn;
	RgnHandle						contRgn;
	RgnHandle						updateRgn;
	Handle							windowDefProc;
	Handle							dataHandle;
	StringHandle					titleHandle;
	short							titleWidth;
	ControlHandle					controlList;
	CWindowPeek						nextWindow;
	PicHandle						windowPic;
	long							refCon;
};
struct WStateData {
	Rect							userState;					/*user state*/
	Rect							stdState;					/*standard state*/
};
typedef struct WStateData WStateData;

typedef WStateData *WStateDataPtr, **WStateDataHandle;

typedef struct AuxWinRec AuxWinRec;

typedef AuxWinRec *AuxWinPtr, **AuxWinHandle;

struct AuxWinRec {
	AuxWinHandle					awNext;						/*handle to next AuxWinRec*/
	WindowPtr						awOwner;					/*ptr to window */
	CTabHandle						awCTable;					/*color table for this window*/
	Handle							dialogCItem;				/*  */
	long							awFlags;					/*reserved for expansion*/
	CTabHandle						awReserved;					/*reserved for expansion*/
	long							awRefCon;					/*user Constant*/
};
extern pascal Boolean GetAuxWin(WindowPtr theWindow, AuxWinHandle *awHndl)
 ONEWORDINLINE(0xAA42);

enum {
	wContentColor				= 0,
	wFrameColor					= 1,
	wTextColor					= 2,
	wHiliteColor				= 3,
	wTitleBarColor				= 4
};



#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __WINDOWS__ */
