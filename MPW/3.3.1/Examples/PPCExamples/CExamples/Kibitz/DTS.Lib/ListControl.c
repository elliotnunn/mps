/*
** Apple Macintosh Developer Technical Support
**
** Program:         listcontrol.c
** Written by:      Eric Soldan
**
** Copyright © 1991 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

/*
**
** To create a List control, you only need a single call.  For example:
**
**	list = CLNew(rViewCtl,			Resource ID of view control for List control.
**				 true, 				Control initially visible.
**				 &viewRct,			View rect of list.
**				 numRows,			Number of rows to create List with.
**				 numCols,			Number of columns to create List with.
**				 cellHeight,
**				 cellWidth,
**				 theLProc,			Custom List procedure resource ID.
**				 window,			Window to hold List control.
**				 clHScroll | blBrdr | clActive		Horizontal scrollbar, active List.
**	);
**

** If the CLNew call succeeds, you then have a List control in your
** window.  It will be automatically disposed of when you close the window.
** If you don't want this to happen, then you can detach it from the
** view control which owns it.  To do this, you would to the following:
**
**  viewCtl = CLViewFromList(theListHndl);
**  if (viewCtl) SetCRefCon(viewCtl, nil);
**
** The view control keeps a reference to the List record in the refCon.
** If the refCon is cleared, then the view control does nothing.  So, all that
** is needed to detach a List record from a view control is to set the
** view control's refCon nil.  Now if you close the window, you will still
** have the List record.
**
**
** To remove a List control completely from a window, just dispose of the view
** control that holds the List record.  To do this, just do something like the below:
**
**  DisposeControl(CLViewFromList(theListHndl));
**
** This completely disposes of the List control.
**
**
** Events for the List record are handled nearly automatically.  Just make the
** following call:
**
**  CLClick(window, eventPtr, &action);
**
** If the event was handled, true is returned.  If the event is false, then the
** event doesn't belong to a List control, and further processing of the event
** should be done.
*/



/*****************************************************************************/



#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __DTSLib__
#include "DTS.Lib.h"
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __LISTCONTROL__
#include "ListControl.h"
#endif

#ifndef __LOWMEM__
#include <LowMem.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TEXTUTILS__
#include "TextUtils.h"
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif



/*****************************************************************************/



#define kListPosTextLen 32
#define kPrevSel		16

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
typedef struct cdefRsrcJMP {
	long	jsrInst;
	long	moveInst;
	short	jmpInst;
	long	jmpAddress;
} cdefRsrcJMP;
typedef cdefRsrcJMP *cdefRsrcJMPPtr, **cdefRsrcJMPHndl;
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif



/*****************************************************************************/



short	gListCtl = rListCtl;

static long						gLastKeyTime;
static char						gListPosText[kListPosTextLen];
static short					gListPosTextLen;
static cdefRsrcJMPHndl			gCDEF;
static CLGetCompareDataProcPtr	gGetCompareDataProc;
static CLDoCompareDataProcPtr	gDoCompareDataProc;
static ListHandle				gCLVList;
static ControlHandle			gVFLView;
static ListHandle				gVFLList;
static Rect						gLRect;

static void			CLVScrollContent(short h, short v);
static WindowPtr	CLVSetClip(ListHandle list);

static void			CLInitialize(void);
static void			CLBorderDraw(ListHandle listHndl);
static pascal long	CLCtl(short varCode, ControlHandle ctl, short msg, long parm);
static pascal short	MyIntlCompare(Ptr aPtr, Ptr bPtr, short aLen, short bLen);

static void				dummyCLActivate(Boolean makeActive, ListHandle listHndl);
static Boolean			dummyCLClick(WindowPtr window, EventRecord *event, short *action);
static ControlHandle	dummyCLCtlHit(void);
static ListHandle		dummyCLFindActive(WindowPtr window);
static Boolean			dummyCLKey(WindowPtr window, EventRecord *event);
static ControlHandle	dummyCLNext(WindowPtr window, ListHandle *listHndl, ControlHandle ctl, short dir, Boolean justActive);
static ControlHandle	dummyCLViewFromList(ListHandle listHndl);
static ListHandle		dummyCLWindActivate(WindowPtr window, Boolean displayIt);

CLActivateProcPtr		gclActivate       = dummyCLActivate;
CLClickProcPtr			gclClick          = dummyCLClick;
CLCtlHitProcPtr			gclCtlHit         = dummyCLCtlHit;
CLFindActiveProcPtr		gclFindActive     = dummyCLFindActive;
CLKeyProcPtr			gclKey            = dummyCLKey;
CLNextProcPtr			gclNext           = dummyCLNext;
CLViewFromListProcPtr	gclViewFromList   = dummyCLViewFromList;
CLWindActivateProcPtr	gclWindActivate   = dummyCLWindActivate;


CLVVariableSizeCellsProcPtr	gclvVariableSizeCells = nil;
CLVGetCellRectProcPtr		gclvGetCellRect       = nil;
CLVUpdateProcPtr			gclvUpdate            = nil;
CLVAutoScrollProcPtr		gclvAutoScroll        = nil;
CLVSetSelectProcPtr			gclvSetSelect         = nil;
CLVClickProcPtr				gclvClick             = nil;
CLVAdjustScrollBarsProcPtr  gclvAdjustScrollBars  = nil;


extern short	gPrintPage;		/* Non-zero means we are printing. */



/*****************************************************************************/



static ListHandle		gFoundLHndl;
	/* Global value used to return info from the List control proc. */

static ControlHandle	gFoundViewCtl;
	/* Global value used to return info from the List control proc. */



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* Instead of calling the functions directly, you can reference the global
** proc pointers that reference the functions.  This keeps everything from
** being linked in.  The default global proc pointers point to dummy functions
** that behave as if there aren't any list controls.  The calls can still be
** made, yet the runtime behavior is such that it will operate as if there
** no instances of the List control.  This allows intermediate code to access
** the functions or not without automatically linking in all sorts of stuff
** into the application that isn't desired.  To change the global proc pointers
** so that they point to the actual functions, just call CLInitialize() once
** in the beginning of the application.  If CLInitialize() is referenced, it will
** get linked in.  In turn, everything that it references directly or indirectly
** will get linked in. */

#pragma segment ListControl
static void	CLInitialize(void)
{
	if (gclActivate != CLActivate) {
		gclActivate       = CLActivate;
		gclClick          = CLClick;
		gclCtlHit         = CLCtlHit;
		gclFindActive     = CLFindActive;
		gclKey            = CLKey;
		gclNext           = CLNext;
		gclViewFromList   = CLViewFromList;
		gclWindActivate   = CLWindActivate;
	}
}



/*****************************************************************************/



/* Activate this List record.  Activation is NOT done by calling LActivate().
** The active control is indicated by the 2-pixel thick border around the
** List control.  This allows all List controls in a window to display which
** cells are selected.  This behavior can be overridden by calling LActivate()
** on the List record for List controls.
** Human interface dictates that only at most a single List control has this
** active border.  For this reason, this function scans for other List
** controls in the window and removes the border from any other that it finds. */

#pragma segment ListControl
void	CLActivate(Boolean makeActive, ListHandle listHndl)
{
	WindowPtr		window, oldPort;
	ControlHandle	viewCtl;
	short			oldDisplay, newDisplay;
	ListHandle		list;
	CLDataHndl		listData;

	if (listHndl) {
		window = (WindowPtr)(*listHndl)->port;
		for (viewCtl = nil;;) {
			viewCtl = CLNext(window, &list, viewCtl, 1, false);
			if (!viewCtl) break;
			listData   = (CLDataHndl)(*viewCtl)->contrlData;
			oldDisplay = (*listData)->mode;
			newDisplay = (oldDisplay & (0xFFFF - clActive));
			if (makeActive)
				if (list == listHndl)
					newDisplay |= clActive;
			if (oldDisplay != newDisplay) {
				(*listData)->mode = newDisplay;
				GetPort(&oldPort);
				SetPort(window);
				CLBorderDraw(list);
				SetPort(oldPort);
			}
		}
	}
}



static void	dummyCLActivate(Boolean makeActive, ListHandle listHndl)
{
#pragma unused (makeActive, listHndl)
}



/*****************************************************************************/



#pragma segment ListControl
static void	CLBorderDraw(ListHandle listHndl)
{
	ControlHandle	viewCtl;
	WindowPtr		oldPort, listPort;
	short			displayInfo;
	PenState		oldPen;
	CLDataHndl		listData;

	SetRect(&gLRect, 0, 0, 0, 0);
	if (listHndl) {
		if (viewCtl = CLViewFromList(listHndl)) {
			GetPort(&oldPort);
			SetPort(listPort = (*listHndl)->port);
			GetPenState(&oldPen);
			PenNormal();
			listData    = (CLDataHndl)(*viewCtl)->contrlData;
			displayInfo = (*listData)->mode;
			gLRect = (*listHndl)->rView;
			InsetRect(&gLRect, -1, -1);
			FrameRect(&gLRect);
			if (displayInfo & clShowActive) {
				gLRect = (*listHndl)->rView;
				InsetRect(&gLRect, -4, -4);
				if ((*listHndl)->vScroll)
					gLRect.right  += 15;
				if ((*listHndl)->hScroll)
					gLRect.bottom += 15;
				PenSize(2, 2);
				if ((!((WindowPeek)listPort)->hilited) || (!(displayInfo & clActive)))
					PenPat((ConstPatternParam)&qd.white);
				FrameRect(&gLRect);
			}
			SetPenState(&oldPen);
			SetPort(oldPort);
		}
	}
}



/*****************************************************************************/



/* This is called when a mouseDown occurs in the content of a window.  It
** returns true if the mouseDown caused a List action to occur.  Events
** that are handled include if the user clicks on a scrollbar that is
** associated with a List control. */

#pragma segment ListControl
Boolean	CLClick(WindowPtr window, EventRecord *event, short *action)
{
	WindowPtr		oldPort;
	Point			mouseLoc;
	ListHandle		list;
	ControlHandle	ctlHit, viewCtl;
	CLDataHndl		listData;
	short			mode;

	if (action)
		*action = 0;
	gLastKeyTime = 0;

	GetPort(&oldPort);
	if (!((WindowPeek)window)->hilited) return(false);

	SetPort(window);
	mouseLoc = event->where;
	GlobalToLocal(&mouseLoc);

	if (!(viewCtl = CLFindCtl(window, event, &list, &ctlHit))) return(false);

	if (!list) {
		SetPort(oldPort);
		return(false);
	}		/* Didn't hit list control or related scrollbar.  No action taken. */

	if (CLFindActive(window) != list) {			/* If not active list control, activate it.	   */
		if ((*viewCtl)->contrlHilite != 255) {
			CLActivate(true, list);				/* Now is the active list control.			   */
			if (action)							/* CLClick can be called again if the control  */
				*action = -1;					/* activates and operates with the same click. */
			SetPort(oldPort);
			return(true);
		}
	}

	UseControlStyle(viewCtl);
	listData = (CLDataHndl)(*viewCtl)->contrlData;
	mode     = (*listData)->mode;
	if (mode & clVariable) {
		if ((*gclvClick)(mouseLoc, event->modifiers, list))
			if (action)
				*action = 1;		/* If double-click, then return that it was. */
	}
	else {
		if (LClick(mouseLoc, event->modifiers, list))
			if (action)
				*action = 1;		/* If double-click, then return that it was. */
	}
	UseControlStyle(nil);

	SetPort(oldPort);
	return(true);
}



static Boolean	dummyCLClick(WindowPtr window, EventRecord *event, short *action)
{
#pragma unused (window, event)

	if (action)
		*action = 0;
	return(false);
}



/*****************************************************************************/



#pragma segment ListControl
static pascal long	CLCtl(short varCode, ControlHandle ctl, short msg, long parm)
{
#pragma unused (varCode)

	Rect			viewRct;
	ListHandle		list;
	WindowPtr		curPort, ww;
	ControlHandle	vScroll, hScroll;
	CLDataHndl		listData;

	if (list = (ListHandle)GetCRefCon(ctl))
		viewRct = (*list)->rView;
	else
		SetRect(&viewRct, 0, 0, 0, 0);

	switch (msg) {
		case drawCntl:
			GetPort(&curPort);
			if (vScroll = (*list)->vScroll) {
				ww = (*vScroll)->contrlOwner;
				if (!((WindowPeek)ww)->hilited) (*list)->vScroll = nil;
			}
			if (hScroll = (*list)->hScroll) {
				ww = (*hScroll)->contrlOwner;
				if (!((WindowPeek)ww)->hilited) (*list)->hScroll = nil;
			}
			CLUpdate(curPort->visRgn, list);
			(*list)->vScroll = vScroll;
			(*list)->hScroll = hScroll;
			CLBorderDraw(list);
			break;

		case testCntl:
			if (PtInRect(*(Point *)&parm, &viewRct)) {
				gFoundViewCtl = ctl;
				gFoundLHndl   = list;
				return(1);
			}
			return(0);
			break;

		case calcCRgns:
		case calcCntlRgn:
			if (msg == calcCRgns)
				parm &= 0x00FFFFFF;
			RectRgn((RgnHandle)parm, &viewRct);
			break;

		case initCntl:
			break;

		case dispCntl:
			if (list) {
				GetPort(&curPort);
				SetPort((*list)->port);
				gVFLView = ctl;
				gVFLList = list;
				listData = (CLDataHndl)(*ctl)->contrlData;
				(*listData)->mode &= (0xFFFF - clActive);
				CLBorderDraw(list);
				EraseRect(&gLRect);
				InvalRect(&gLRect);
				gVFLView = nil;
				gVFLList = nil;
				LDispose(list);
				DisposeHandle((Handle)(*ctl)->contrlData);
				SetPort(curPort);
			}
			break;

		case posCntl:
			break;

		case thumbCntl:
			break;

		case dragCntl:
			break;

		case autoTrack:
			break;
	}

	return(0);
}



/*****************************************************************************/



/* The List control that was hit by calling FindControl is saved in a
** global variable, since the CDEF has no way of returning what kind it was.
** To determine that it was a List control that was hit, first call this
** function.  The first call returns the old value in the global variable,
** plus it resets the global to nil.  Then call FindControl(), and then
** call this function again.  If it returns nil, then a List control
** wasn't hit.  If it returns non-nil, then it was a List control that
** was hit, and specifically the one returned. */

#pragma segment ListControl
ControlHandle	CLCtlHit(void)
{
	ControlHandle	ctl;

	ctl = gFoundViewCtl;
	gFoundViewCtl = nil;
	return(ctl);
}



static ControlHandle	dummyCLCtlHit(void)
{
	return(nil);
}



/*****************************************************************************/



/* Handle the event if it applies to the active List control.  If some
** action occured due to the event, return true. */

#pragma segment ListControl
Boolean	CLEvent(WindowPtr window, EventRecord *event, short *action)
{
	WindowPtr	clickWindow;
	short		actn;

	if (action)
		*action = 0;

	switch(event->what) {

		case mouseDown:
			if (FindWindow(event->where, &clickWindow) == inContent)
				if (window == clickWindow)
					if (((WindowPeek)window)->hilited) return(CLClick(window, event, action));
			break;

		case autoKey:
		case keyDown:
			if (!(event->modifiers & cmdKey)) {
				actn = CLKey(window, event);
				if (action)
					*action = actn;
				if (actn) return(true);
			}
			break;
	}

	return(false);
}



/*****************************************************************************/



/* Returns the active List control, if any.  Unlike the TextEdit control, passing
** in nil doesn't return the currently active control independent of window.  The
** only reason that the TextEdit control returns the "globally active" control is
** so that the TEIdle procedure can do its thing.  The List control doesn't have
** such a thing, so there is no purpose for a "globally active" control.  If the
** window pointer passed in is nil (requesting the "globally active" List control),
** we just return nil, indicating that there isn't one. */

#pragma segment ListControl
ListHandle	CLFindActive(WindowPtr window)
{
	ControlHandle	viewCtl;
	ListHandle		list;
	short			display;
	CLDataHndl		listData;

	if (!window) return(nil);

	for (viewCtl = nil;;) {
		viewCtl = CLNext(window, &list, viewCtl, 1, true);
		if (!viewCtl) break;
		listData = (CLDataHndl)(*viewCtl)->contrlData;
		display  = (*listData)->mode;
		if (display & clActive) break;
	}
	return(list);
}



static ListHandle	dummyCLFindActive(WindowPtr window)
{
#pragma unused (window)
	return(nil);
}



/*****************************************************************************/



/* This determines if a List control was clicked on directly.  This does
** not determine if a related scrollbar was clicked on.  If a List
** control was clicked on, then true is returned, as well as the List
** handle and the handle to the view control. */

#pragma segment ListControl
ControlHandle	CLFindCtl(WindowPtr window, EventRecord *event, ListHandle *listHndl, ControlHandle *ctlHit)
{
	WindowPtr		oldPort;
	Point			mouseLoc;
	ControlHandle	ctl, listctl;
	ListHandle		list;

	if (window) {
		GetPort(&oldPort);
		SetPort(window);
		mouseLoc = event->where;
		GlobalToLocal(&mouseLoc);
		SetPort(oldPort);

		gFoundLHndl = nil;

		if (!WhichControl(mouseLoc, 0, window, &ctl)) return(nil);
			/* Didn't hit a thing, so forget it. */

		if (list = CLFromScroll(ctl, &listctl)) {
			if (ctlHit)
				*ctlHit = ctl;
			if (listHndl)
				*listHndl = list;
			return(listctl);
		}

		FindControl(mouseLoc, window, &ctl);
		if (!ctl)                                     return(nil);
		if (*(*ctl)->contrlDefProc != *(Handle)gCDEF) return(nil);
			/* Control hit was above List control, so we didn't hit a List control. */
		if (ctlHit)
			*ctlHit = ctl;
		if (listHndl)
			*listHndl = gFoundLHndl;
		if (gFoundLHndl) return(ctl);
	}

	if (listHndl)
		*listHndl = nil;
	if (ctlHit)
		*ctlHit = nil;
	return(nil);
}



/*****************************************************************************/



/* Find the List record that is related to the indicated scrollbar. */

#pragma segment ListControl
ListHandle	CLFromScroll(ControlHandle scrollCtl, ControlHandle *retCtl)
{
	WindowPtr		window;
	ControlHandle	viewCtl;
	ListHandle		list;

	*retCtl = nil;
	if (!IsScrollBar(scrollCtl)) return(nil);

	window = (*scrollCtl)->contrlOwner;

	for (*retCtl = viewCtl = nil;;) {
		viewCtl = CLNext(window, &list, viewCtl, 1, false);
		if (!viewCtl) return(nil);
		list = (ListHandle)GetCRefCon(viewCtl);
		if (
			((*list)->vScroll == scrollCtl) || 
			((*list)->hScroll == scrollCtl)
		) {
			*retCtl = viewCtl;
			return(list);
		}
	}
}



/*****************************************************************************/



/* Get the Nth List control in the control list of a window. */

#pragma segment ListControl
ListHandle	CLGetList(WindowPtr window, short lnum)
{
	ControlHandle	ctl;
	ListHandle		list;

	for (ctl = nil; lnum--; ctl = CLNext(window, &list, ctl, 1, false));
	return(list);
}



/*****************************************************************************/



/* Insert a cell alphabetically into the list.  Whichever parameter is passed in
** as -1, either row or column, that is the dimension that is determined. */

#pragma segment ListControl
short	CLInsert(ListHandle listHndl, char *data, short dataLen, short row, short col)
{
	short			loc, len;
	Point			cell;
	char			cstr[256];
	CLDataHndl		listData;
	ControlHandle	viewCtl;

	if (!listHndl) return(-1);

	gGetCompareDataProc = nil;
	if (viewCtl = CLViewFromList(listHndl))
		if (listData = (CLDataHndl)(*viewCtl)->contrlData)
			gGetCompareDataProc = (*listData)->getCompareData;

	if (gGetCompareDataProc) {
		(*gGetCompareDataProc)(data, dataLen, cstr, &len);
		loc = CLRowOrColSearch(listHndl, cstr, len, row, col);
	}
	else loc = CLRowOrColSearch(listHndl, data, dataLen, row, col);

	if (row == -1) {
		LAddRow(1, cell.v = loc, listHndl);
		cell.h = col;
	}
	else {
		LAddColumn(1, cell.h = loc, listHndl);
		cell.v = row;
	}

	LSetCell(data, dataLen, cell, listHndl);
	return(loc);
}



/*****************************************************************************/



/* See if the keypress event applies to the List control, and if it does,
** handle it and return true. */

#pragma segment ListControl
Boolean	CLKey(WindowPtr window, EventRecord *event)
{
	ListHandle			list;
	ControlHandle		listCtl;
	short				key, mode, thresh;
	long				ll;
	Point				cell, dcell, mm, oldCell, lastCell;
	Rect				bnds, visCells, rct;
	CLDataHndl			listData;
	CLKeyFilterProcPtr	kproc;

	if (list = CLFindActive(window)) {

		listCtl  = CLViewFromList(list);
		listData = (CLDataHndl)(*listCtl)->contrlData;
		mode     = (*listData)->mode;
		if (!(mode & clKeyPos)) return(false);

		if (kproc = (*listData)->keyFilter)
			if ((*kproc)(list, event))
				return(true);

		bnds = (*list)->dataBounds;
		if (bnds.top == bnds.bottom) return(true);
		if (bnds.left == bnds.right) return(true);
			/* The list is empty, so whatever was typed has been "handled". */

		if (mode & clVariable) {
			++bnds.top;
			++bnds.left;
		}

		cell.h = bnds.left;
		cell.v = bnds.top;
		key = event->message & charCodeMask;

		if ((key >= chLeft) && (key <= chDown)) {
			if (LGetSelect(true, &cell, list)) key -= kPrevSel;
			else							   cell.h = cell.v = -1;
			for (oldCell = lastCell = cell;; lastCell = cell) {
				switch (key) {
					case chLeft - kPrevSel:
						if (cell.h > bnds.left)
							--cell.h;
						break;
					case chRight - kPrevSel:
						if (cell.h < bnds.right - 1)
							++cell.h;
						break;
					case chUp - kPrevSel:
						if (cell.v > bnds.top)
							--cell.v;
						break;
					case chDown - kPrevSel:
						if (cell.v < bnds.bottom - 1)
							++cell.v;
						break;
					case chLeft:
						cell.v = (*list)->visible.top;
						cell.h = bnds.right - 1;
						break;
					case chRight:
						cell.v = (*list)->visible.top;
						cell.h = bnds.left;
						break;
					case chUp:
						cell.h = (*list)->visible.left;
						cell.v = bnds.bottom - 1;
						break;
					case chDown:
						cell.h = (*list)->visible.left;
						cell.v = bnds.top;
						break;
				}
				if (!(mode & clVariable)) break;
				if ((cell.h == lastCell.h) && (cell.v == lastCell.v)) break;
				(*gclvGetCellRect)(list, cell.h, cell.v, &rct);
				if (!EmptyRect(&rct)) break;
				if (key > (chDown - kPrevSel)) key -= kPrevSel;
			}
			if (mode & clVariable) {
				(*gclvGetCellRect)(list, cell.h, cell.v, &rct);
				if (EmptyRect(&rct)) cell = oldCell;
				if (cell.h == -1) return(true);
			}
		}
		else {
			thresh = LMGetKeyThresh();;
			if (thresh > 60) thresh = 60;
			thresh <<= 1;
			if (gLastKeyTime + thresh < event->when)		/* Too long, reset char collection. */
				gListPosTextLen = 0;
			gLastKeyTime = event->when;
			if (gListPosTextLen < kListPosTextLen)
				gListPosText[gListPosTextLen++] = key;
			gGetCompareDataProc = (*listData)->getCompareData;
			gDoCompareDataProc  = (*listData)->doCompareData;
			if (!LGetSelect(true, &cell, list)) cell.h = (*list)->visible.left;
			cell.v = CLRowOrColSearch(list, gListPosText, gListPosTextLen, -1, cell.h);
			if (cell.v >= bnds.bottom) cell.v = bnds.bottom - 1;
		}

		UseControlStyle(listCtl);

		if (mode & clVariable)
			(*gclvSetSelect)(true, cell, list);
		else
			LSetSelect(true, cell, list);		/* Select cell that is closest. */

		dcell.h = bnds.left;
		dcell.v = bnds.top;
		for (;;) {				/* Deselect old cells. */
			if (!LGetSelect(true, &dcell, list)) break;
			if ((dcell.h == cell.h) && (dcell.v == cell.v)) {
				if (++dcell.h >= bnds.right) {
					dcell.h = bnds.left;
					++dcell.v;
				}
			}
			else {
				if (mode & clVariable)
					(*gclvSetSelect)(false, dcell, list);
				else
					LSetSelect(false, dcell, list);
			}
		}
		UseControlStyle(nil);

		visCells = (*list)->visible;
		if (PtInRect(cell, &visCells)) return(true);		/* Already in view. */

		UseControlStyle(listCtl);			/* Scroll into view the way we want it done. */
		if (mode & clVariable) (*gclvAutoScroll)(list);
		else {
			ll = PinRect(&visCells, cell);
			mm = *(Point *)&ll;
			LScroll(cell.h - mm.h, cell.v - mm.v, list);
		}
		UseControlStyle(nil);
		return(true);
	}

	return(false);
}



static Boolean	dummyCLKey(WindowPtr window, EventRecord *event)
{
#pragma unused (window, event)
	return(false);
}



/*****************************************************************************/



/* Create a new List control.  See the comments at the beginning of this
** file for more information.  Note that this function doesn't get a dummy,
** as you really mean to have this code if you call it.  It calls CLInitialize(),
** just to make sure that the proc pointers are set to point to the real function,
** instead of the dummy functions.  By having CLNew() call CLInitialize(), the
** application won't have to worry about calling CLInitialize().  By the time that
** the application is using a List control, the proc pointers will be initialized. */

#pragma segment ListControl
ListHandle	CLNew(short viewID, Boolean vis, Rect *vrct, short numRows, short numCols,
				  short cellHeight, short cellWidth, short theLProc, WindowPtr window, short mode)
{
	WindowPtr		oldPort;
	Rect			viewRct, dataBnds, rct;
	Point			cellSize;
	ListHandle		list;
	Boolean			err;
	ControlHandle	viewCtl;
	Boolean			drawIt, hasGrow;
	short			hScroll, vScroll;
	CLDataHndl		listData;
	ControlHandle	ctl;
	RgnHandle		oldClip, newClip;

	static ControlDefUPP	cdefupp;

	CLInitialize();			/* Make sure that this code gets linked in, in case the application
							** is using the proc pointers.  CtlHandler.c uses the proc pointers
							** so that if the application doesn't use List controls, this code
							** won't get linked in. */
	GetPort(&oldPort);
	SetPort(window);

	viewRct         = *vrct;
	dataBnds.top    = dataBnds.left = 0;
	dataBnds.right  = numCols;
	dataBnds.bottom = numRows;

	cellSize.h = cellWidth;
	cellSize.v = cellHeight;

	drawIt  = (mode & clDrawIt)  ? 1 : 0;
	hScroll = (mode & clHScroll) ? 1 : 0;
	vScroll = (mode & clVScroll) ? 1 : 0;
	hasGrow = (mode & clHasGrow) ? 1 : 0;

	viewCtl = nil;

	if (!vis) {
		GetClip(oldClip = NewRgn());
		SetClip(newClip = NewRgn());
	}
	list = LNew(&viewRct, &dataBnds, cellSize, theLProc, window, false, hasGrow, hScroll, vScroll);
	if (!vis) {
		if (list) {
			if (ctl = (*list)->hScroll) HideControl(ctl);
			if (ctl = (*list)->vScroll) HideControl(ctl);
		}
		SetClip(oldClip);
		DisposeRgn(oldClip);
		DisposeRgn(newClip);
	}

	err = false;
	if (list) {		/* If we were able to create the List record... */

		if ((hasGrow) && (hScroll + vScroll == 1)) {
			if (ctl = (*list)->hScroll) {
				rct = (*ctl)->contrlRect;
				if (rct.right >= viewRct.right)
					SizeControl(ctl, viewRct.right - viewRct.left - 13, rct.bottom - rct.top);
			}
			if (ctl = (*list)->vScroll) {
				rct = (*ctl)->contrlRect;
				if (rct.bottom >= viewRct.bottom)
					SizeControl(ctl, rct.right - rct.left, viewRct.bottom - viewRct.top - 13);
			}
		}

		if (!gCDEF) {
			gCDEF = (cdefRsrcJMPHndl)GetResource('CDEF', (viewID / 16));
			if (gCDEF) {
				if (!cdefupp) {
					cdefupp = NewControlDefProc(CLCtl);
				}
				(*gCDEF)->jmpAddress = (long)cdefupp;
				FlushInstructionCache();	/* Make sure that instruction caches don't kill us. */
			}
			else err = true;
		}

		if (!err)
			viewCtl = NewControl(window, &viewRct, "\p", false, 0, 0, 0, viewID, (long)list);
				/* Use our custom view cdef.  It's wierd, but it's small. */
				/* We have to create the control initially invisible because we haven't */
				/* initialized all of the data needed by the update procedure.  If it   */
				/* is created visible, the update procedure will be immediately called, */
				/* and this would be very bad to do until all of the data is there.     */

		mode &= (0xFFFF - clDrawIt);

		if (!viewCtl) err = true;

		if (!err) {
			(*viewCtl)->contrlData = nil;
			if (listData = (CLDataHndl)NewHandleClear(sizeof(CLDataRec))) {
				(*listData)->mode      = mode & (0xFFFF - clVariable);
				(*viewCtl)->contrlData = (Handle)listData;
				if (mode & clVariable)
					if (gclvVariableSizeCells)
						(*gclvVariableSizeCells)(list);
				if (vis) {
					LDoDraw(drawIt, list);
					if (vis) ShowStyledControl(viewCtl);
						/* Now that the data is initialized, we can show the control. */
				}
				else
					if (drawIt)
						(*list)->listFlags &= (0xFFFF - 0x08);
							/* The silly ListMgr shows the scrollbars if we just call LDoDraw. */
				if (mode & clActive)
					CLActivate(true, list);
			}
			else err = true;
		}
	}
	else err = true;

	SetPort(oldPort);

	if (err) {		/* Oops.  Somebody wasn't happy. */
		if (viewCtl)
			DisposeControl(viewCtl);
				/* This also disposes of the List handle! */
		else
			if (list)
				LDispose(list);
					/* We have to dispose of the List handle ourselves if
					** creating the view control failed. */

		list = nil;		/* Return that there is no List control. */
	}

	return(list);
}



/*****************************************************************************/



/* Get the next List control in the window.  You pass it a control handle
** for the view control, or nil to start at the beginning of the window.
** It returns both a List handle and the view control handle for that
** List record.  If none is found, nil is returned.  This allows you to
** repeatedly call this function and walk through all the List controls
** in a window. */

#pragma segment ListControl
ControlHandle	CLNext(WindowPtr window, ListHandle *listHndl, ControlHandle ctl, short dir, Boolean justActive)
{
	ControlHandle	nextCtl, priorCtl;

	if (listHndl)
		*listHndl = nil;

	if (!window) return(nil);
	if (!gCDEF)  return(nil);

	if (dir > 0) {
		if (!ctl)
			ctl = ((WindowPeek)window)->controlList;
		else
			ctl = (*ctl)->nextControl;
		while (ctl) {
			if ((!justActive) || ((*ctl)->contrlVis)) {
				if ((!justActive) || ((*ctl)->contrlHilite != 255)) {
					if (*(*ctl)->contrlDefProc == *(Handle)gCDEF) {
							/* The handle may be locked, which means that the hi-bit
							** may be on, thus invalidating the compare.  Dereference the
							** handles to get rid of this possibility. */
						if (listHndl)
							*listHndl = (ListHandle)GetCRefCon(ctl);
						return(ctl);
					}
				}
			}
			ctl = (*ctl)->nextControl;
		}
		return(ctl);
	}

	nextCtl = ((WindowPeek)window)->controlList;
	for (priorCtl = nil; ;nextCtl = (*nextCtl)->nextControl) {
		if ((!nextCtl) || (nextCtl == ctl)) {
			if (priorCtl)
				if (listHndl)
					*listHndl = (ListHandle)GetCRefCon(priorCtl);
			return(priorCtl);
		}
		if ((!justActive) || ((*nextCtl)->contrlVis)) {
			if ((!justActive) || ((*nextCtl)->contrlHilite != 255)) {
				if (*(*nextCtl)->contrlDefProc == *(Handle)gCDEF)
					priorCtl = nextCtl;
						/* The handle may be locked, which means that the hi-bit
						** may be on, thus invalidating the compare.  Dereference the
						** handles to get rid of this possibility. */
			}
		}
	}
}



static ControlHandle	dummyCLNext(WindowPtr window, ListHandle *listHndl, ControlHandle ctl, short dir, Boolean justActive)
{
#pragma unused (window, ctl, dir, justActive)
	*listHndl = nil;
	return(nil);
}



/*****************************************************************************/



/* From the starting for or column, print as many cells as will fit into the
** designated rect.  Pass in a starting row and column, and they will be
** adjusted to indicate the first cell that didn't fit into the rect.  If all
** remaining cells were printed, the row is returned as -1.  The bottom of the
** rect to print in is also adjusted to indicate where the actual cut-off
** point was. */

#pragma segment ListControl
void	CLPrint(RgnHandle clipRgn, ListHandle listHndl, short *row, short *col,
				short leftEdge, Rect *drawRct)
{
	Rect		dataBnds, keepView, keepVis;
	Point		csize;
	short		h, v;
	RgnHandle	rgn;

	if (!listHndl) return;

	dataBnds = (*listHndl)->dataBounds;
	if ((*col < dataBnds.left) || (*col >= dataBnds.right))
		*col = leftEdge;
	if (*row < dataBnds.top)
		*row = dataBnds.top;
	if (*row >= dataBnds.bottom) {
		*row = -1;
		return;
	}

	keepView = (*listHndl)->rView;
	csize    = (*listHndl)->cellSize;
	keepVis  = (*listHndl)->visible;

	h = (drawRct->right - drawRct->left) / csize.h;
	if (!h)
		++h;
	v = (drawRct->bottom - drawRct->top) / csize.v;
	if (!v)
		++v;

	if (*col + h > dataBnds.right)
		h = dataBnds.right  - *col;
	if (*row + v > dataBnds.bottom)
		v = dataBnds.bottom - *row;

	drawRct->bottom = drawRct->top + v * csize.v;

	(*listHndl)->rView = *drawRct;
	(*listHndl)->visible.right  = ((*listHndl)->visible.left = *col) + h;
	(*listHndl)->visible.bottom = ((*listHndl)->visible.top  = *row) + v;

	if (!(rgn = clipRgn)) {
		rgn = NewRgn();
		RectRgn(rgn, drawRct);
	}
	CLUpdate(rgn, listHndl);
	if (!clipRgn)
		DisposeRgn(rgn);

	(*listHndl)->rView   = keepView;
	(*listHndl)->visible = keepVis;

	*col += h;
	if (*col >= dataBnds.right) {
		*col = leftEdge;
		*row += v;
		if (*row >= dataBnds.bottom)
			*row = -1;
	}
}



/*****************************************************************************/



/* Find the location in the list where the data would belong if inserted.  The row
** and column are passed in.  If either is -1, that is the dimension that will be
** determined and returned. */

#pragma segment ListControl
short	CLRowOrColSearch(ListHandle listHndl, void *data, short dataLen, short row, short col)
{
	ControlHandle	viewCtl;
	Rect			dataBnds;
	short			numCells, baseCell, iter, pow, loc, cdataLen, varSize;
	Point			cell;
	Str255			cdata, gcdata;
	CLDataHndl		listData;

	if (!listHndl) return(-1);

	gGetCompareDataProc = nil;
	gDoCompareDataProc  = nil;

	varSize = 0;
	if (viewCtl = CLViewFromList(listHndl)) {
		if (listData = (CLDataHndl)(*viewCtl)->contrlData) {
			gGetCompareDataProc = (*listData)->getCompareData;
			gDoCompareDataProc  = (*listData)->doCompareData;
			if ((*listData)->mode & clVariable) ++varSize;
		}
	}

	dataBnds = (*listHndl)->dataBounds;
	if (row == -1)
		numCells = dataBnds.bottom - (baseCell = dataBnds.top);
	else
		numCells = dataBnds.right  - (baseCell = dataBnds.left);
			/* Get some reference info on the size/start of the list. */

	if (varSize) {
		++baseCell;
		--numCells;
	}

	cell.v = cell.h = varSize;

	for (;numCells > baseCell; --numCells) {		/* Exclude empty end cells. */
		if (row == -1)
			cell.v = baseCell + numCells - 1;
		else
			cell.h = baseCell + numCells - 1;
		cdataLen = 1;
		LGetCell(cdata, &cdataLen, cell, listHndl);
		if (cdataLen) break;
	}

	if (numCells) {
		if (row != -1)
			cell.v = row;
		if (col != -1)
			cell.h = col;
		for (pow = 1; pow < numCells; ++iter, pow <<= 1);
		pow >>= 1;		/* pow = 2^n such that pow < numCells. */

		for (loc = pow; pow;) {			/* Do binary search for where to insert. */
			if (loc >= numCells)
				loc = numCells - 1;		/* Off the end is bad. */
			if (row == -1)
				cell.v = baseCell + loc;
			else
				cell.h = baseCell + loc;
			pow >>= 1;

			cdataLen = 255;
			LGetCell(cdata, &cdataLen, cell, listHndl);		/* Get cell data to compare against. */
			if (gGetCompareDataProc) {
				(*gGetCompareDataProc)(cdata, cdataLen, gcdata, &cdataLen);
				BlockMove(gcdata, cdata, cdataLen);
			}

			if (gDoCompareDataProc)		/* Adjust location based on compare result. */
				loc += (pow * (*gDoCompareDataProc)(data, cdata, dataLen, cdataLen));
			else
				loc += (pow * IUMagString(data, cdata, dataLen, cdataLen));
		}

		/* The binary search got us close, but not exact.  We may be off by one
		** in either direction.  (The binary search can't position in front of
		** the first cell in the list, for example.)  Do a linear compare from
		** this point to find the correct cell we should insert in front of. */


		if (loc < numCells) {					/* Move to the first duplicate. */
			for (; --loc >= 0;) {
				if (row == -1) cell.v = baseCell + loc;
				else		   cell.h = baseCell + loc;
				cdataLen = 255;
				LGetCell(cdata, &cdataLen, cell, listHndl);
				if (gDoCompareDataProc) {
					if ((*gDoCompareDataProc)(data, cdata, dataLen, cdataLen)) break;
				}
				else {
					if (IUMagString(data, cdata, dataLen, cdataLen)) break;
				}
			}
			++loc;
		}

		if (loc) --loc;				/* Start linear search one back. */
		for (;; ++loc) {
			if (row == -1)
				cell.v = baseCell + loc;
			else
				cell.h = baseCell + loc;
			if (loc >= numCells) break;
			cdataLen = 255;
			LGetCell(cdata, &cdataLen, cell, listHndl);
			if (gGetCompareDataProc) {
				(*gGetCompareDataProc)(cdata, cdataLen, gcdata, &cdataLen);
				BlockMove(gcdata, cdata, cdataLen);
			}

			if (gDoCompareDataProc) {
				if ((*gDoCompareDataProc)(data, cdata, dataLen, cdataLen) < 1) break;
			}
			else {
				if (IUMagString(data, cdata, dataLen, cdataLen) < 1) break;
			}		/* If we are less than or equal to this cell, we have
					** found our insertion point, so break. */
		}
	}

	if (row == -1) return(cell.v);
	else		   return(cell.h);
}



/*****************************************************************************/



/* Draw the List control in the correct form. */

#pragma segment ListControl
void	CLUpdate(RgnHandle clipRgn, ListHandle listHndl)
{
	WindowPtr		curPort, listPort;
	ControlHandle	ctl;
	Rect			view, vis, bnds, r;
	RgnHandle		rgn1, rgn2;
	CLDataHndl		listData;
	short			mode;

	if (listHndl) {

		if (ctl = CLViewFromList(listHndl)) {

			GetPort(&curPort);

			listPort = (*listHndl)->port;
			(*listHndl)->port = curPort;

			listData = (CLDataHndl)(*ctl)->contrlData;
			mode     = (*listData)->mode;
			if (mode & clVariable) (*gclvUpdate)(clipRgn, listHndl);
			else				   LUpdate(clipRgn, listHndl);

			(*listHndl)->port = listPort;

			view = (*listHndl)->rView;
			vis  = (*listHndl)->visible;
			bnds = (*listHndl)->dataBounds;
			SectRect(&vis, &bnds, &vis);

			r = view;
			if (mode & clVariable) {
				if ((--vis.right > 0) && (--vis.bottom > 0)) {
					(*gclvGetCellRect)(listHndl, vis.right, vis.bottom, &r);
					r.top  = view.top;
					r.left = view.left;
				}
				else SetRect(&r, 0, 0, 0, 0);
			}
			else {
				r.right  = r.left + (vis.right  - vis.left) * (*listHndl)->cellSize.h;
				r.bottom = r.top  + (vis.bottom - vis.top ) * (*listHndl)->cellSize.v;
			}
			SectRect(&r, &view, &r);

			RectRgn(rgn1 = NewRgn(), &view);
			RectRgn(rgn2 = NewRgn(), &r);
			DiffRgn(rgn1, rgn2, rgn1);
			EraseRgn(rgn1);
			DisposeRgn(rgn1);
			DisposeRgn(rgn2);
		}
	}
}



/*****************************************************************************/



/* Return the control handle for the view control that owns the List
** record.  Use this to find the view to do customizations such as changing
** the update procedure for this List control. */

#pragma segment ListControl
ControlHandle	CLViewFromList(ListHandle listHndl)
{
	WindowPtr		window;
	ControlHandle	viewCtl;
	ListHandle		list;

	if (!listHndl) return(nil);

	if (gVFLView)
		if (gVFLList == listHndl)
			return(gVFLView);

	window = (WindowPtr)(*listHndl)->port;
	for (viewCtl = nil;;) {
		viewCtl = CLNext(window, &list, viewCtl, 1, false);
		if ((!viewCtl) || (list == listHndl)) return(viewCtl);
	}
}



static ControlHandle	dummyCLViewFromList(ListHandle listHndl)
{
#pragma unused (listHndl)
	return(nil);
}



/*****************************************************************************/



/* This window is becoming active or inactive.  The borders of the List
** controls need to be redrawn due to this.  For each List control in the
** window, redraw the active border. */

#pragma segment ListControl
ListHandle	CLWindActivate(WindowPtr window, Boolean displayIt)
{
	ListHandle	list;

	gLastKeyTime = 0;		/* Restart the entry collection for Lists. */

	if (!window) return(nil);

	if (list = CLFindActive(window)) {
		if (displayIt)
			CLBorderDraw(list);
		return(list);
	}

	return(nil);
}



static ListHandle	dummyCLWindActivate(WindowPtr window, Boolean displayIt)
{
#pragma unused (window, displayIt)

	return(nil);
}



/*****************************************************************************/



#pragma segment ListControl
static pascal short	MyIntlCompare(Ptr aPtr, Ptr bPtr, short aLen, short bLen)
{
	short	cmp;
	char	cstr[256];

	if (gGetCompareDataProc) {
		(*gGetCompareDataProc)(aPtr, aLen, cstr, &aLen);
		aPtr = cstr;
	}

	if (gDoCompareDataProc)
		cmp = (*gDoCompareDataProc)(aPtr, bPtr, aLen, bLen);
	else
		cmp = IUMagString(aPtr, bPtr, aLen, bLen);

	if (cmp == -1) return(1);
	else		   return(0);
}



/*****************************************************************************/



#pragma segment ListControl
void	CLSize(ListHandle list, short newH, short newV)
{
#pragma unused (oldh, oldv)

	WindowPtr		oldPort;
	ControlHandle	viewCtl, ctl;
	Rect			viewRct, rct;
	RgnHandle		oldClip, newClip;
	CLDataHndl		listData;
	short			mode, hScroll, vScroll;

	if (!(viewCtl = CLViewFromList(list))) return;

	GetPort(&oldPort);
	SetPort((*list)->port);

	viewRct  = (*viewCtl)->contrlRect;
	listData = (CLDataHndl)(*viewCtl)->contrlData;
	mode     = (*listData)->mode;

	GetClip(oldClip = NewRgn());
	SetClip(newClip = NewRgn());
		/* Prevent any drawing, since the newly resized scrollbars may not account for
		** the growIcon area.  We don't want them temporarily redrawing over the
		** growIcon. */

	LSize(newH, newV, list);

	hScroll = (mode & clHScroll) ? 1 : 0;
	vScroll = (mode & clVScroll) ? 1 : 0;
		/* Get enough info to determine if we need to fix the scrollbar sizes. */

	viewRct.right  = viewRct.left + newH;
	viewRct.bottom = viewRct.top  + newV;
	(*viewCtl)->contrlRect = viewRct;

	if ((mode & clHasGrow) && (hScroll + vScroll == 1)) {
		if (ctl = (*list)->hScroll) {
			rct = (*ctl)->contrlRect;
			if (rct.right >= viewRct.right)
				SizeControl(ctl, viewRct.right - viewRct.left - 13, rct.bottom - rct.top);
		}
		if (ctl = (*list)->vScroll) {
			rct = (*ctl)->contrlRect;
			if (rct.bottom >= viewRct.bottom)
				SizeControl(ctl, rct.right - rct.left, viewRct.bottom - viewRct.top - 13);
		}
	}

	SetClip(oldClip);
	DisposeRgn(oldClip);
	DisposeRgn(newClip);
		/* Allow drawing again so we can redisplay the newly resized list control and scrollbars. */

	InsetRect(&viewRct, -1, -1);		/* Erase all of the old list control and scrollbars. */
	if (vScroll)
		viewRct.right += 15;
	if (hScroll)
		viewRct.bottom += 15;
	if (mode & clShowActive)
		InsetRect(&viewRct, -4, -4);
	if ((*viewCtl)->contrlVis)
		EraseRect(&viewRct);

	if (mode & clVariable) (*gclvAdjustScrollBars)(list);

	DoDraw1Control(viewCtl, false);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment ListControl
void	CLMove(ListHandle list, short newH, short newV)
{
#pragma unused (oldh, oldv)

	WindowPtr		oldPort;
	ControlHandle	viewCtl, ctl;
	Rect			viewRct, rct;
	RgnHandle		oldClip, newClip;
	CLDataHndl		listData;
	short			mode, hScroll, vScroll, dx, dy;

	if (!(viewCtl = CLViewFromList(list))) return;

	GetPort(&oldPort);
	SetPort((*list)->port);

	viewRct  = (*viewCtl)->contrlRect;
	listData = (CLDataHndl)(*viewCtl)->contrlData;
	mode     = (*listData)->mode;

	dx = newH - viewRct.left;
	dy = newV - viewRct.top;
	if ((!dx) && (!dy)) return;

	hScroll = (mode & clHScroll) ? 1 : 0;
	vScroll = (mode & clVScroll) ? 1 : 0;
		/* Get enough info to determine if we need to fix the scrollbar sizes. */

	rct = viewRct;				/* Erase all of the old list control and scrollbars. */
	InsetRect(&rct, -1, -1);
	if (vScroll)
		rct.right += 15;
	if (hScroll)
		rct.bottom += 15;
	if (mode & clShowActive)
		InsetRect(&rct, -4, -4);
	if ((*viewCtl)->contrlVis)
		EraseRect(&rct);

	OffsetRect(&viewRct, dx, dy);
	(*viewCtl)->contrlRect = viewRct;
	(*list)->rView = viewRct;

	GetClip(oldClip = NewRgn());
	SetClip(newClip = NewRgn());

	if (ctl = (*list)->hScroll) {
		rct = (*ctl)->contrlRect;
		MoveControl(ctl, rct.left + dx, rct.top + dy);
	}

	if (ctl = (*list)->vScroll) {
		rct = (*ctl)->contrlRect;
		MoveControl(ctl, rct.left + dx, rct.top + dy);
	}

	SetClip(oldClip);
	DisposeRgn(oldClip);
	DisposeRgn(newClip);

	DoDraw1Control(viewCtl, false);
	SetPort(oldPort);
}



/*****************************************************************************/



/* Show the designated List control and related scrollbars. */

#pragma segment ListControl
void	CLShow(ListHandle list)
{
	ControlHandle	viewCtl, scrollCtl;
	short			i;

	if (viewCtl = CLViewFromList(list)) {
		ShowStyledControl(viewCtl);
		for (i = 0; i < 2; i++) {
			if (scrollCtl = (i) ? (*list)->hScroll : (*list)->vScroll)
				ShowStyledControl(scrollCtl);
		}
	}
}



/*****************************************************************************/



/* Hide the designated List control and related scrollbars. */

#pragma segment ListControl
Rect	CLHide(ListHandle list)
{
	ControlHandle	viewCtl, scrollCtl;
	short			i;
	WindowPtr		oldPort;
	CLDataHndl		listData;
	short			displayInfo;
	Rect			rct;

	if (viewCtl = CLViewFromList(list)) {
		HideControl(viewCtl);
		for (i = 0; i < 2; i++) {
			if (scrollCtl = (i) ? (*list)->hScroll : (*list)->vScroll)
				HideControl(scrollCtl);
		}
	}

	GetPort(&oldPort);
	SetPort((*list)->port);
	listData    = (CLDataHndl)(*viewCtl)->contrlData;
	displayInfo = (*listData)->mode;
	rct         = (*list)->rView;
	InsetRect(&rct, -1, -1);
	if ((*list)->vScroll)
		rct.right  += 15;
	if ((*list)->hScroll)
		rct.bottom += 15;
	if (displayInfo & clActive)
		if (displayInfo & clShowActive)
			InsetRect(&rct, -3, -3);

	EraseRect(&rct);
	SetPort(oldPort);

	return(rct);
}



