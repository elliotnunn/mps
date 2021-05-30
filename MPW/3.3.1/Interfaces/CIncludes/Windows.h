/*
	File:		Windows.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __WINDOWS__
#define __WINDOWS__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*		#include <MixedMode.h>									*/
/*			#include <Traps.h>									*/
/*	#include <QuickdrawText.h>									*/
/*		#include <IntlResources.h>								*/
#endif

#ifndef __EVENTS__
#include <Events.h>
/*	#include <OSUtils.h>										*/
#endif

#ifndef __CONTROLS__
#include <Controls.h>
/*	#include <Menus.h>											*/
#endif

enum  {
	documentProc				= 0,
	dBoxProc					= 1,
	plainDBox					= 2,
	altDBoxProc					= 3,
	noGrowDocProc				= 4,
	movableDBoxProc				= 5,
	zoomDocProc					= 8,
	zoomNoGrow					= 12,
	rDocProc					= 16,
	dialogKind					= 2,
	userKind					= 8,
/*FindWindow Result Codes*/
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

enum  {
/*window messages*/
	wDraw						= 0,
	wHit						= 1,
	wCalcRgns					= 2,
	wNew						= 3,
	wDispose					= 4,
	wGrow						= 5,
	wDrawGIcon					= 6,
/*defProc hit test codes*/
	wNoHit						= 0,
	wInContent					= 1,
	wInDrag						= 2,
	wInGrow						= 3,
	wInGoAway					= 4,
	wInZoomIn					= 5,
	wInZoomOut					= 6,
	deskPatID					= 16,
/*Window Part Identifiers which correlate color table entries with window elements*/
	wContentColor				= 0,
	wFrameColor					= 1,
	wTextColor					= 2,
	wHiliteColor				= 3,
	wTitleBarColor				= 4
};

typedef pascal void (*DragGrayRgnProcPtr)(void);

enum {
	uppDragGrayRgnProcInfo = kPascalStackBased
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr DragGrayRgnUPP;

#define CallDragGrayRgnProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDragGrayRgnProcInfo)
#define NewDragGrayRgnProc(userRoutine)		\
		(DragGrayRgnUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDragGrayRgnProcInfo, GetCurrentISA())
#else
typedef DragGrayRgnProcPtr DragGrayRgnUPP;

#define CallDragGrayRgnProc(userRoutine)		\
		(*(userRoutine))()
#define NewDragGrayRgnProc(userRoutine)		\
		(DragGrayRgnUPP)(userRoutine)
#endif

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct WindowRecord {
	GrafPort					port;
	short						windowKind;
	Boolean						visible;
	Boolean						hilited;
	Boolean						goAwayFlag;
	Boolean						spareFlag;
	RgnHandle					strucRgn;
	RgnHandle					contRgn;
	RgnHandle					updateRgn;
	Handle						windowDefProc;
	Handle						dataHandle;
	StringHandle				titleHandle;
	short						titleWidth;
	ControlHandle				controlList;
	struct WindowRecord			*nextWindow;
	PicHandle					windowPic;
	long						refCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct WindowRecord WindowRecord;

typedef WindowRecord *WindowPeek;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct CWindowRecord {
	CGrafPort					port;
	short						windowKind;
	Boolean						visible;
	Boolean						hilited;
	Boolean						goAwayFlag;
	Boolean						spareFlag;
	RgnHandle					strucRgn;
	RgnHandle					contRgn;
	RgnHandle					updateRgn;
	Handle						windowDefProc;
	Handle						dataHandle;
	StringHandle				titleHandle;
	short						titleWidth;
	ControlHandle				controlList;
	struct CWindowRecord		*nextWindow;
	PicHandle					windowPic;
	long						refCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct CWindowRecord CWindowRecord;

typedef CWindowRecord *CWindowPeek;

typedef pascal long (*WindowDefProcPtr)(short varCode, WindowPtr theWindow, short message, long param);

enum {
	uppWindowDefProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(WindowPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr WindowDefUPP;

#define CallWindowDefProc(userRoutine, varCode, theWindow, message, param)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppWindowDefProcInfo, (varCode), (theWindow), (message), (param))
#define NewWindowDefProc(userRoutine)		\
		(WindowDefUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowDefProcInfo, GetCurrentISA())
#else
typedef WindowDefProcPtr WindowDefUPP;

#define CallWindowDefProc(userRoutine, varCode, theWindow, message, param)		\
		(*(userRoutine))((varCode), (theWindow), (message), (param))
#define NewWindowDefProc(userRoutine)		\
		(WindowDefUPP)(userRoutine)
#endif

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct WStateData {
	Rect						userState;						/*user state*/
	Rect						stdState;						/*standard state*/
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct WStateData WStateData;

typedef WStateData *WStateDataPtr, **WStateDataHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct AuxWinRec {
	struct AuxWinRec			**awNext;						/*handle to next AuxWinRec*/
	WindowPtr					awOwner;						/*ptr to window */
	CTabHandle					awCTable;						/*color table for this window*/
	Handle						dialogCItem;					/*handle to dialog manager structures*/
	long						awFlags;						/*reserved for expansion*/
	CTabHandle					awReserved;						/*reserved for expansion*/
	long						awRefCon;						/*user Constant*/
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct AuxWinRec AuxWinRec;

typedef AuxWinRec *AuxWinPtr, **AuxWinHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct WinCTab {
	long						wCSeed;							/*reserved*/
	short						wCReserved;						/*reserved*/
	short						ctSize;							/*usually 4 for windows*/
	ColorSpec					ctTable[5];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct WinCTab WinCTab;

typedef WinCTab *WCTabPtr, **WCTabHandle;


/*
	DeskHookProcs cannot be written in or called from a high-level 
	language without the help of mixed mode or assembly glue because they 
	use the following parameter-passing convention:

	typedef pascal void (*DeskHookProcPtr)(Boolean mouseClick, EventRecord *theEvent);

		In:
			=> 	mouseClick				D0.B
			=> 	theEvent				A0.L
		Out:
			none
*/

enum  {
	uppDeskHookProcInfo			= kRegisterBased|REGISTER_ROUTINE_PARAMETER(1,kRegisterD0,kOneByteCode)|REGISTER_ROUTINE_PARAMETER(2,kRegisterA0,kFourByteCode)
};

#if USESROUTINEDESCRIPTORS
typedef pascal void (*DeskHookProcPtr)(Boolean mouseClick, EventRecord *theEvent);

typedef UniversalProcPtr DeskHookUPP;

#define CallDeskHookProc(userRoutine, mouseClick, theEvent)  \
	CallUniversalProc((UniversalProcPtr)(userRoutine), uppDeskHookProcInfo, (mouseClick), (theEvent))

#define NewDeskHookProc(userRoutine)  \
	(DeskHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDeskHookProcInfo, GetCurrentISA())

#else
typedef ProcPtr DeskHookUPP;

#define NewDeskHookProc(userRoutine)  \
	(DeskHookUPP)(userRoutine)

#endif

#ifdef __cplusplus
extern "C" {
#endif

#if USESCODEFRAGMENTS
extern pascal RgnHandle GetGrayRgn(void);
#else
#define GetGrayRgn() (* (RgnHandle*) 0x09EE)

#endif

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
extern void setwtitle(WindowPtr theWindow, char *title);
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
extern pascal void ClipAbove(WindowPeek window)
 ONEWORDINLINE(0xA90B);
extern pascal void SaveOld(WindowPeek window)
 ONEWORDINLINE(0xA90E);
extern pascal void DrawNew(WindowPeek window, Boolean update)
 ONEWORDINLINE(0xA90F);
extern pascal void PaintOne(WindowPeek window, RgnHandle clobberedRgn)
 ONEWORDINLINE(0xA90C);
extern pascal void PaintBehind(WindowPeek startWindow, RgnHandle clobberedRgn)
 ONEWORDINLINE(0xA90D);
extern pascal void CalcVis(WindowPeek window)
 ONEWORDINLINE(0xA909);
extern pascal void CalcVisBehind(WindowPeek startWindow, RgnHandle clobberedRgn)
 ONEWORDINLINE(0xA90A);
extern pascal long GrowWindow(WindowPtr theWindow, Point startPt, const Rect *bBox)
 ONEWORDINLINE(0xA92B);
extern Boolean trackgoaway(WindowPtr theWindow, Point *thePt);
extern pascal short FindWindow(Point thePoint, WindowPtr *theWindow)
 ONEWORDINLINE(0xA92C);
extern short findwindow(Point *thePoint, WindowPtr *theWindow);
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
extern void getwtitle(WindowPtr theWindow, char *title);
extern pascal void SetWinColor(WindowPtr theWindow, WCTabHandle newColorTable)
 ONEWORDINLINE(0xAA41);
extern pascal Boolean GetAuxWin(WindowPtr theWindow, AuxWinHandle *awHndl)
 ONEWORDINLINE(0xAA42);
extern long growwindow(WindowPtr theWindow, Point *startPt, const Rect *bBox);
extern pascal void SetDeskCPat(PixPatHandle deskPixPat)
 ONEWORDINLINE(0xAA47);
extern WindowPtr newwindow(void *wStorage, const Rect *boundsRect, char *title, Boolean visible, short theProc, WindowPtr behind, Boolean goAwayFlag, long refCon);
extern pascal WindowPtr NewCWindow(void *wStorage, const Rect *boundsRect, ConstStr255Param title, Boolean visible, short procID, WindowPtr behind, Boolean goAwayFlag, long refCon)
 ONEWORDINLINE(0xAA45);
extern WindowPtr newcwindow(void *wStorage, const Rect *boundsRect, char *title, Boolean visible, short procID, WindowPtr behind, Boolean goAwayFlag, long refCon);
extern pascal WindowPtr GetNewCWindow(short windowID, void *wStorage, WindowPtr behind)
 ONEWORDINLINE(0xAA46);
extern pascal short GetWVariant(WindowPtr theWindow)
 ONEWORDINLINE(0xA80A);
extern long pinrect(const Rect *theRect, Point *thePt);
extern pascal void SetWTitle(WindowPtr theWindow, ConstStr255Param title)
 ONEWORDINLINE(0xA91A);
extern Boolean trackbox(WindowPtr theWindow, Point *thePt, short partCode);
extern pascal Boolean TrackGoAway(WindowPtr theWindow, Point thePt)
 ONEWORDINLINE(0xA91E);
extern pascal void DragWindow(WindowPtr theWindow, Point startPt, const Rect *boundsRect)
 ONEWORDINLINE(0xA925);
extern long draggrayrgn(RgnHandle theRgn, Point *startPt, const Rect *boundsRect, const Rect *slopRect, short axis, DragGrayRgnUPP actionProc);
extern void dragwindow(WindowPtr theWindow, Point *startPt, const Rect *boundsRect);
#ifdef __cplusplus
}
#endif

#endif

