/*
** Apple Macintosh Developer Technical Support
**
** Program:         texteditcontrol.c
** Written by:      Eric Soldan
** Based on:        TESample, by Bryan Stearns
** Suggestions by:  Forrest Tanaka, Dave Radcliffe
**
** Copyright © 1990-1993 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

/* This is a control implementation of TextEdit.  The advantages to this are:
**
** 1) Makes using TextEdit in a non-dialog window easy.
** 2) The TextEdit record is automatically associated with the window, since
**    it is in the window's control list.
** 3) The TextEdit control can have scrollbars associated with it, and these
**    are also kept in the window's control list.
** 4) Updating of the TextEdit record is much simpler, since all that is
**    necessary is to draw the control (or all the window's controls with
**    a DrawControls call).
** 5) There are simple calls to handle TextEdit events.
** 6) Undo is already supported.
** 7) A document length can be specified.  This length will not be exceeded
**    when editing the TextEdit record.
** 8) When you close the window, the TextEdit record is disposed of.
**    (This automatic disposal can easily be defeated.)
**
**
** To create a TextEdit control, you only need a single call.  For example:
**
**	CTENew(rViewCtl,			Resource ID of view control for TextEdit control.
**		   true, 				Control initially visible.
**		   window,				Window to hold TERecord.
**		   &teHndl,				Return handle for TERecord.
**		   &ctlRct,				Rect for TextEdit view control.
**		   &destRct,			destRct for TERecord
**		   &viewRct,			viewRct for TERecord
**		   &borderRct,			Used to frame a border.
**		   32000,				Max size for TERecord text.
**		   cteVScrollLessGrow	TERecord read-write, with vertical scroll
**								that leaves space for grow box.
**	);
**
** If you create a TextEdit control that is read-only, you will not be able
** to edit it, of course.  There will also be no blinking caret for that
** TextEdit control.  You will be able to select text and copy to the
** clipboard, but that is all.

** Simply create destRct, viewRct, and borderRct appropriately, and
** then call CTENew (which stands for Control TENew).  If teHndl is returned
** nil, then CTENew failed.  Otherwise, you now have a TextEdit control in
** the window.
**
** NOTE: There is a TextEdit bug (no way!!) such that you may need to set the
**       viewRct right edge 2 bigger than the right edge of destRct.  If you
**       do not do this, then there will be some clipping on the right edge in
**       some cases.  Of course, you may want this.  You may want horizontal
**       scrolling, and therefore you would want the destRct substantially
**       larger than the viewRct.  If you don't want horizontal scrolling,
**       then you probably don't want any clipping horizontally, and therefore
**       you will need to set destRct.right 2 less than viewRct.right.
**
**
** If the CTENew call succeeds, you then have a TextEdit control in your
** window.  It will be automatically disposed of when you close the window.
** If you don't waht this to happen, then you can detach it from the
** view control which owns it.  To do this, you would to the following:
**
**  viewCtl = CTEViewFromTE(theTextEditHndl);
**  if (viewCtl) SetCRefCon(viewCtl, nil);
**
** The view control keeps a reference to the TextEdit record in the refCon.
** If the refCon is cleared, then the view control does nothing.  So, all that
** is needed to detach a TextEdit record from a view control is to set the
** view control's refCon nil.  Now if you close the window, you will still
** have the TextEdit record.
**
**
** To remove a TextEdit control completely from a window, you make one call:
**
**  CTEDispose(theTextEditHndl);
**
** This disposes of the TextEdit record, the view control, and any scrollbar
** controls that were created when the TextEdit control was created with
** the call CTENew.
**
**
** Events for TextEdit record are handled nearly automatically.  You can
** make one of 3 calls:
**
**  CTEClick(window, eventPtr, &action);
**  CTEEvent(window, eventPtr, &action);
**  CTEKey(window, eventPtr);
**
** In each case, if the event was handled, true is returned.  CTEEvent simply
** calls either CTEClick or CTEKey, whichever is appropriate.
**
**
** Another call you will want to use is CTEEditMenu.  This is used to set the
** state of cut/copy/paste/clear for TextEdit controls.  It checks the active
** control to see if text is selected, if the control is read-only, etc.
** Based on this information, it sets cut/copy/paste/clear either active
** or inactive.  If any menu items are set active, it returns true.
**
**
** One more high-level call is CTEUndo().  In response to an undo menu item
** being selected by the user, just call CTEUndo(), and the edits the user
** has made will be undone.  (This includes undoing an undo.)
**
**
** The last high-level call is CTEClipboard.  Call it when you want to do a
** cut/copy/paste/clear for the active TextEdit control.  The value to pass
** is as follows:
**
**  2: cut
**  3: copy
**  4: paste
**  5: clear
**
** These are the same values you would pass to a DA for these actions.
*/



/*****************************************************************************/



#ifndef __TEXTEDITCONTROL__
#include "TextEditControl.h"
#endif

#ifndef __BALLOONS__
#include <Balloons.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __DTSLib__
#include "DTS.Lib.h"
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __OSEVENTS__
#include <OSEvents.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __SCRAP__
#include <Scrap.h>
#endif

#ifndef __SCRIPT__
#include <Script.h>
#endif

#ifndef __TEXTSERVICES__
#include <TextServices.h>
#endif

#ifndef __TSMTE__
#include "TSMTE.h"
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif



/*****************************************************************************/

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



extern Boolean		gInBackground;

short	gTECtl    = rTECtl;

short	CTEGetLineNum(TEHandle te, short offset);
short	CTEGetLineHeight(TEHandle te, short lineNum, short *ascent);

static void				CTEInitialize(void);
static pascal long		CTECtl(short varCode, ControlHandle ctl, short msg, long parm);
static Boolean			GoFast(TEHandle teHndl, EventRecord *event);
static pascal void		TSMTEUpdateProc(TEHandle te, long fixLen, long inputAreaStart,
										long inputAreaEnd, long pinStart, long pinEnd, long refCon);

static pascal Boolean	PPCClikLoop(TEPtr pTE);
static pascal void		PPCNoCaret(const Rect *r, TEPtr pTE);

static cdefRsrcJMPHndl	gCDEF;
static Boolean			gCanGoSlow;
static Boolean			gUseTSMTE;
static WindowPtr		gTEWindow;



/*****************************************************************************/



TEClickLoopUPP	gDefaultClikLoopUPP;
	/* The clikLoop TextEdit wants to use.  Our custom clikLoop must call
	** this as well.  The default TextEdit clikLoop is stored here. */

static ControlDefUPP	gCTECtlUPP;				/* Universal ProcPtr for CTECtl() */
static TEClickLoopUPP	gClikLoopUPP;			/* Universal ProcPtr for our ClikLoop */
static CaretHookUPP		gNoCaretHookUPP;		/* Universal ProcPtr for our CaretHook */



/*****************************************************************************/



static TEHandle			gActiveTEHndl;
	/* Currently active TextEdit record.  (nil if none active.) */

static TEHandle			gFoundTEHndl;
	/* Global value used to return info from the TextEdit control proc. */

static ControlHandle	gFoundViewCtl;
	/* Global value used to return info from the TextEdit control proc. */

static pascal void		VActionProc(ControlHandle scrollCtl, short part);
static pascal void		HActionProc(ControlHandle control, short part);
static void				AdjustOneScrollValue(TEHandle teHndl, ControlHandle ctl, Boolean vert);

#define kTELastForWind	1
#define kCrChar			13



static void				dummyCTEActivate(Boolean active, TEHandle teHndl);
static Boolean			dummyCTEClick(WindowPtr window, EventRecord *event, short *action);
static ControlHandle	dummyCTECtlHit(void);
static TEHandle			dummyCTEFindActive(WindowPtr window);
static short			dummyCTEKey(WindowPtr window, EventRecord *event);
static ControlHandle	dummyCTENext(WindowPtr window, TEHandle *teHndl, ControlHandle ctl, short dir, Boolean justActive);
static void				dummyCTESetSelect(short start, short end, TEHandle teHndl);
static ControlHandle	dummyCTEViewFromTE(TEHandle teHndl);
static TEHandle			dummyCTEWindActivate(WindowPtr window, Boolean displayIt);

CTEActivateProcPtr           gcteActivate           = dummyCTEActivate;
CTEClickProcPtr              gcteClick              = dummyCTEClick;
CTECtlHitProcPtr             gcteCtlHit             = dummyCTECtlHit;
CTEFindActiveProcPtr         gcteFindActive         = dummyCTEFindActive;
CTEKeyProcPtr                gcteKey                = dummyCTEKey;
CTENextProcPtr               gcteNext               = dummyCTENext;
CTESetSelectProcPtr          gcteSetSelect          = dummyCTESetSelect;
CTEViewFromTEProcPtr         gcteViewFromTE         = dummyCTEViewFromTE;
CTEWindActivateProcPtr       gcteWindActivate       = dummyCTEWindActivate;



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* Instead of calling the functions directly, you can reference the global
** proc pointers that reference the functions.  This keeps everything from
** being linked in.  The default global proc pointers point to dummy functions
** that behave as if there aren't any TextEdit controls.  The calls can still be
** made, yet the runtime behavior is such that it will operate as if there
** no instances of the TextEdit control.  This allows intermediate code to access
** the functions or not without automatically linking in all sorts of stuff
** into the application that isn't desired.  To change the global proc pointers
** so that they point to the actual functions, just call CTEInitialize() once
** in the beginning of the application.  If CTEInitialize() is referenced, it will
** get linked in.  In turn, everything that it references directly or indirectly
** will get linked in. */

#pragma segment TextEditControl
static void	CTEInitialize(void)
{
	if (gcteActivate != CTEActivate) {
		gcteActivate           = CTEActivate;
		gcteClick              = CTEClick;
		gcteCtlHit             = CTECtlHit;
		gcteFindActive         = CTEFindActive;
		gcteKey                = CTEKey;
		gcteNext               = CTENext;
		gcteSetSelect          = CTESetSelect;
		gcteViewFromTE         = CTEViewFromTE;
		gcteWindActivate       = CTEWindActivate;

		CTEConvertClipboard(true, true);
	}
}



/*****************************************************************************/



/* Activate this TextEdit record.  If another is currently active, deactivate
** that one.  The view control for this TextEdit record is also flagged to
** indicate which was the last active one for this window.  If the previous
** active TextEdit record was in the same window, then flag the old one off
** for this window.  The whole point for this per-window flagging is so that
** activate events can reactivate the correct TextEdit control per window. */

#pragma segment TextEditControl
void	CTEActivate(Boolean active, TEHandle teHndl)
{
	WindowPtr		tePort, oldPort;
	ControlHandle	viewCtl;
	TEHandle		te;
	CTEDataHndl		teData;
	short			oldDisplay, newDisplay;

	if (!teHndl) return;

	teData = nil;
	if (viewCtl = CTEViewFromTE(teHndl))
		teData = (CTEDataHndl)(*viewCtl)->contrlData;

	if (!active) {
		GetPort(&oldPort);
		SetPort(tePort = (*teHndl)->inPort);
		if(gUseTSMTE)
			DeactivateTSMDocument((*teData)->docID);
		TEDeactivate(teHndl);
		if (teHndl == gActiveTEHndl)
			gActiveTEHndl = nil;
		if (viewCtl)
			CTEUpdate(teHndl, viewCtl, true);
		SetPort(oldPort);
		return;
	}

	if (!viewCtl)               return;
	if (!(*viewCtl)->contrlVis) return;

	(*teData)->mode |= cteActive;
	GetPort(&oldPort);
	SetPort(tePort = (*teHndl)->inPort);

	if (!gInBackground) {
		if(gUseTSMTE)
			ActivateTSMDocument((*teData)->docID);
		TEActivate(gActiveTEHndl = teHndl);
	}

	CTEUpdate(teHndl, viewCtl, true);
	SetPort(oldPort);
		/* Let TextEdit know that it is supposed to be active. */

	for (viewCtl = nil;;) {
		viewCtl = CTENext(tePort, &te, viewCtl, 1, false);
		if (!viewCtl) break;
		if (te != teHndl) {
			teData = (CTEDataHndl)(*viewCtl)->contrlData;
			oldDisplay = (*teData)->mode;
			newDisplay = (oldDisplay & (0xFFFF - cteActive));
			if (oldDisplay != newDisplay) {
				(*teData)->mode = newDisplay;
				CTEActivate(false, te);
			}
		}
	}
}



static void	dummyCTEActivate(Boolean active, TEHandle teHndl)
{
#pragma unused (active, teHndl)
}



/*****************************************************************************/



/* This is called when a mouseDown occurs in the content of a window.  It
** returns true if the mouseDown caused a TextEdit action to occur.  Events
** that are handled include if the user clicks on a scrollbar that is
** associated with a TextEdit control. */

#pragma segment TextEditControl
Boolean	CTEClick(WindowPtr window, EventRecord *event, short *action)
{
	WindowPtr		oldPort;
	Point			mouseLoc;
	TEHandle		te, teActive;
	ControlHandle	ctlHit, viewCtl;
	CTEDataHndl		teData;
	Boolean			vert;
	short			extendSelect, part, value, newValue, lh, mode;

	static ControlActionUPP	hcupp, vcupp;

	if (action)
		*action = 0;

	GetPort(&oldPort);
	if (!((WindowPeek)window)->hilited) return(false);

	SetPort(window);
	mouseLoc = event->where;
	GlobalToLocal(&mouseLoc);

	if (!(viewCtl = CTEFindCtl(window, event, &te, &ctlHit))) return(false);

	if (viewCtl == ctlHit) {
			/* See if the user clicked directly on the view control for a
			** TextEdit record.  If so, we definitely have some work to do. */
		if ((*viewCtl)->contrlHilite != 255) {
			if (te != gActiveTEHndl) {
				CTEActivate(true, te);
				if (action)
					*action = -1;
				SetPort(oldPort);
				return(true);
					/* If user clicked on TextEdit control other than the
					** currently active control, then activate it.  This is our
					** only action in this case. */
			}
			extendSelect = ((event->modifiers & shiftKey) != 0);
				/* Extend-select may be occuring. */

			gCanGoSlow = true;
				/* There is a slow-zone around the TextEdit area for slow extend-select.
				** Allow this zone to slow down selection. */

				if (gUseTSMTE) {
					if (!TSMEvent(event))
						TEClick(mouseLoc, extendSelect, te);
				}
				else TEClick(mouseLoc, extendSelect, te);
					/* Do the extend-select thing.  Most of the work is handled by
					** TextEdit.  The only thing we have to do is to update the
					** scrollbars while the user is extending the select.  This is
					** taken care of by our custom clikLoop procedure. */

			teData = (CTEDataHndl)(*viewCtl)->contrlData;
			(*teData)->newUndo = true;

			SetPort(oldPort);
			return(true);
		}
	}

/* We didn't hit the view control for a TextEdit record, but don't give up yet.
** The user may be clicking on a related scrollbar.  Let's find out... */

	if (WhichControl(mouseLoc, event->when, window, &ctlHit)) {
			/* The user did click on a control.  But is it a scrollbar
			** for a TextEdit control?  Stay tuned... */

		te = CTEFromScroll(ctlHit, &viewCtl);

		if (te) {		/* It was a related scrollbar. */

			if ((*viewCtl)->contrlHilite != 255) {
				if (te != gActiveTEHndl) {
					CTEActivate(true, te);
					if (action)
						*action = -1;
					SetPort(oldPort);
					return(true);
						/* If user clicked on TextEdit control other than the
						** currently active control, then activate it.  This is our
						** only action in this case. */
				}
			}

			vert = ((*ctlHit)->contrlRect.top <= (*viewCtl)->contrlRect.top);
				/* Horizontal or vertical scroll.  Only the rect knows. */

			part = FindControl(mouseLoc, window, &ctlHit);

			switch (part) {
				case 0:		/* Inactive scrollbar. */
					break;
				case inThumb:
					value = GetCtlValue(ctlHit);
					part  = TrackControl(ctlHit, mouseLoc, nil);
					if (part) {
						newValue = GetCtlValue(ctlHit);
						if (value != newValue) {	/* If scrollbar value changed... */
							if (vert) {
								teData = (CTEDataHndl)(*viewCtl)->contrlData;
								mode   = (*teData)->mode;
								if (mode & cteScrollFullLines) {
									if (!(mode & cteStyledTE)) {
										if (lh = CTEGetLineHeight(te, 1, nil)) {
											newValue += (lh >> 1);
											newValue /= lh;
											newValue *= lh;
											SetCtlValue(ctlHit, newValue);
										}
									}
								}
								TEScroll(0, value - newValue, te);
							}
							else
								TEScroll(value - newValue, 0, te);
						}
					}
					break;

				default:
					teActive = gActiveTEHndl;
					gActiveTEHndl = te;
						/* This is a hack way to pass the action procedure
						** which TextEdit record we are dealing with. */

					if (vert) {
						if (!vcupp) vcupp = NewControlActionProc(VActionProc);
						TrackControl(ctlHit, mouseLoc, vcupp);
					}
					else {
						if (!hcupp) hcupp = NewControlActionProc(HActionProc);
						TrackControl(ctlHit, mouseLoc, hcupp);
					}

					gActiveTEHndl = teActive;
						/* Unhack our previous hack. */
					break;
			}

			SetPort(oldPort);
			return(true);
		}
	}

	SetPort(oldPort);
	return(false);
}



static Boolean	dummyCTEClick(WindowPtr window, EventRecord *event, short *action)
{
#pragma unused (window, event)

	if (action)
		*action = 0;
	return(false);
}



/*****************************************************************************/



/* This is the custom clikLoop, which is called from the assembly glue code.
** This handles updating the scrollbars as the user is drag-selecting in
** the TextEdit control. */

#pragma segment TextEditControl
void	CTEClikLoop(void)
{
	WindowPtr		oldPort, window;
	TEHandle		te;
	Point			mouseLoc;
	Rect			viewRct;
	RgnHandle		rgn;
	short			dl, dr, dt, db;
	long			tick;

	GetPort(&oldPort);
	SetPort(window = (WindowPtr)(*gActiveTEHndl)->inPort);

	te = gActiveTEHndl;
		/* This better be what the user is dragging, or we did something
		** wrong elsewhere.
		*/

	GetMouse(&mouseLoc);
	viewRct = (*te)->viewRect;

	if (!PtInRect(mouseLoc, &viewRct)) {
		/* User is outside the TextEdit area, so scrolling is happening. */

		if (tick = gCanGoSlow)
			tick = TickCount();
				/* As an extra feature, there is a zone around the TextEdit
				** viewRct that the scroll will be slowed down.  If the user
				** drags outside the viewRct outside this zone, then scrolling
				** occurs as fast as possible. */

		rgn = NewRgn();
		GetClip(rgn);
		ClipRect(&(window->portRect));
			/* The clipRgn is set to protect everything outside viewRct.
			** This doesn't work very well when we want to change
			** the scrollbars.  Save the old and open it up.
			*/

		dl = viewRct.left - mouseLoc.h;
		dr = mouseLoc.h   - viewRct.right;
		dt = viewRct.top  - mouseLoc.v;
		db = mouseLoc.v   - viewRct.bottom;
			/* Check the delta value for each side of viewRct.  This will
			** be used to determine if we should scroll fast or slow.
			*/

		CTEAdjustScrollValues(te);
			/* Scroll them puppies. */

		SetClip(rgn);								/* restore clip */
		DisposeRgn(rgn);
			/* Make Mr. clipRgn happy again. */

		if ((dl < 16) && (dr < 16) && (dt < 16) && (db < 16))
			while (tick + 10 > TickCount());
				/* Do it really slow.  (This is important on very fast machines.) */
	}

	SetPort(oldPort);
}



/*****************************************************************************/



/* Do the cut/copy/paste/clear operations for the currently active
** TextEdit control.  Caller assumes appropriateness of the call.  Typically,
** this routine won't be called at an inappropriate time, since the menu
** item should be enabled or disabled correctly.
** Use CTEEditMenu to set the menu items undo/cut/copy/paste/clear correctly
** for the active TextEdit control.  Since undo isn't currently supported,
** all that CTEEditMenu does for the undo case is to deactivate it right now. */

#pragma segment TextEditControl
ControlHandle	CTEClipboard(short menuID)
{
	WindowPtr		oldPort;
	TEHandle		te;
	ControlHandle	viewCtl;
	CTEDataHndl		teData;
	long			maxTextLen, charsToAdd;

	if (!(te = gActiveTEHndl))          return(nil);
	if (!(viewCtl = CTEViewFromTE(te))) return(nil);

	GetPort(&oldPort);
	SetPort((*te)->inPort);
	switch (menuID) {
		case 2:
			CTENewUndo(viewCtl, true);
			TECut(te);
			break;
		case 3:
			TECopy(te);
			viewCtl = nil;
			break;
		case 4:
			if (viewCtl) {
				teData = (CTEDataHndl)(*viewCtl)->contrlData;
				maxTextLen  = (*teData)->maxTextLen;
				charsToAdd  = TEGetScrapLen();
				charsToAdd -= ((*te)->selEnd - (*te)->selStart);
				if ((*te)->teLength + charsToAdd <= maxTextLen) {
					CTENewUndo(viewCtl, true);
					if ((*teData)->mode & cteStyledTE)
						TEStylPaste(te);
					else
						TEPaste(te);
				}
				else viewCtl = nil;
			}
			break;
		case 5:
			CTENewUndo(viewCtl, true);
			TEDelete(te);
			break;
	}

	CTEAdjustTEBottom(te);
	CTEAdjustScrollValues(te);
	SetPort(oldPort);

	return(viewCtl);
}



/*****************************************************************************/



#pragma segment TextEditControl
void	CTEConvertClipboard(Boolean convertClipboard, Boolean becomingActive)
{
#pragma unused (convertClipboard, becomingActive)
}



/*****************************************************************************/



#pragma segment TextEditControl
static pascal long	CTECtl(short varCode, ControlHandle ctl, short msg, long parm)
{
#pragma unused (varCode)

	Rect			viewRct;
	TEHandle		te;
	CTEDataHndl		teData;
	ControlHandle	scrollCtl;
	StScrpHandle	uStyl;
	short			i;
	TSMDocumentID	docID;

	if (te = (TEHandle)GetCRefCon(ctl))
		viewRct = (*ctl)->contrlRect;
	else
		SetRect(&viewRct, 0, 0, 0, 0);

	switch (msg) {
		case drawCntl:
			CTEUpdate(te, ctl, false);
			break;

		case testCntl:
			if (PtInRect(*(Point *)&parm, &viewRct)) {
				gFoundViewCtl = ctl;
				gFoundTEHndl  = te;
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
			if (te) {
				if (te == gActiveTEHndl)
					gActiveTEHndl = nil;
				TEDispose(te);
				if (teData = (CTEDataHndl)(*ctl)->contrlData) {
					if ((*teData)->undoText)
						DisposeHandle((Handle)(*teData)->undoText);
					if (uStyl = (*teData)->undoStyl)
						DisposeHandle((Handle)uStyl);
					if (docID = (*teData)->docID)
						DeleteTSMDocument(docID);
					DisposeHandle((Handle)teData);
				}
				for (i = 0; i < 2; ++i)
					if (scrollCtl = CTEScrollFromView(ctl, i))
						DisposeControl(scrollCtl);
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



/* The TextEdit control that was hit by calling FindControl is saved in a
** global variable, since the CDEF has no way of returning what kind it was.
** To determine that it was a TextEdit control that was hit, first call this
** function.  The first call returns the old value in the global variable,
** plus it resets the global to nil.  Then call FindControl(), and then
** call this function again.  If it returns nil, then a TextEdit control
** wasn't hit.  If it returns non-nil, then it was a TextEdit control that
** was hit, and specifically the one returned. */

#pragma segment TextEditControl
ControlHandle	CTECtlHit(void)
{
	ControlHandle	ctl;

	ctl = gFoundViewCtl;
	gFoundViewCtl = nil;
	return(ctl);
}



static ControlHandle	dummyCTECtlHit(void)
{
	return(nil);
}



/*****************************************************************************/



/* Disposes of the TERecord, TextEdit control, and any related scrollbars. */

#pragma segment TextEditControl
void	CTEDispose(TEHandle teHndl)
{
	WindowPtr	oldPort;

	if (teHndl) {
		GetPort(&oldPort);
		SetPort((*teHndl)->inPort);
		TEDispose(CTEDisposeView(CTEViewFromTE(teHndl)));
			/* Dispose of the TextEdit control completely.  This includes
			** scrollbars, as well as the TextEdit view control.
			*/
		SetPort(oldPort);
	}
}



/*****************************************************************************/



/* Dispose of the view control and related scrollbars.  This function also
** returns the handle to the TextEdit record, since it was just orphaned.
** Use this function if you want to get rid of a TextEdit control, but you
** want to keep the TextEdit record. */

#pragma segment TextEditControl
TEHandle	CTEDisposeView(ControlHandle viewCtl)
{
	TEHandle		te;
	short			vert;
	ControlHandle	ctl;

	if (!viewCtl) return(nil);

	te = (TEHandle)GetCRefCon(viewCtl);
	SetCRefCon(viewCtl, (long)nil);

	for (vert = 0; vert < 2; ++vert)
		if (ctl = CTEScrollFromView(viewCtl, vert))
			DisposeControl(ctl);

	DisposeControl(viewCtl);
	return(te);
}



/*****************************************************************************/



/* Returns the full document height. */

#pragma segment TextEditControl
short	CTEDocHeight(TEHandle teHndl)
{
	short		h, lh, a;
	TextStyle	st;

	if (!teHndl) return(0);

	h = TEGetHeight((*teHndl)->nLines, 1, teHndl);
		/* Get the whole doc height. */

	if ((*teHndl)->nLines != CTENumTextLines(teHndl)) {		/* If # of lines is wrong by one... */
		TEGetStyle((*teHndl)->teLength, &st, &lh, &a, teHndl);
		h += lh;											/* Add in height of last line. */
	}

	return(h);
}



/*****************************************************************************/



/* Enable or disable edit menu items based on the active TextEdit control.
** You pass the menu ID of the undo item in undoID, and the menu ID of the
** cut item in cutID.  If undoID or cutID is non-zero, then some action is
** performed.  If you pass a non-zero value for cutID, then the other menu
** items cut/copy/paste/clear are updated to reflect the status of the
** active TextEdit control. */

#pragma segment TextEditControl
Boolean	CTEEditMenu(Boolean *activeItem, short editMenu, short undoID, short cutID)
{
	TEHandle		te;
	MenuHandle		menu;
	Boolean			active;
	ControlHandle	viewCtl;
	CTEDataHndl		teData;
	long			dataLen, scrapOffset;

	active = false;
	if (activeItem) *activeItem = false;
	menu = GetMHandle(editMenu);

	if (undoID)
		DisableItem(menu, undoID);

	if (cutID) {
		DisableItem(menu, cutID);			/* Disable cut. */
		DisableItem(menu, cutID + 1);		/* Disable copy. */
		DisableItem(menu, cutID + 2);		/* Disable paste. */
		DisableItem(menu, cutID + 3);		/* Disable clear. */
	}

	if (!(te = gActiveTEHndl)) return(false);

	if (undoID) {
		if (viewCtl = CTEViewFromTE(te)) {
			teData = (CTEDataHndl)(*viewCtl)->contrlData;
			if ((*teData)->undoText) {
				EnableItem(menu, undoID);
				active = true;
			}
		}
	}

	if (cutID) {
		if ((*te)->selStart != (*te)->selEnd) {
			if (!CTEReadOnly(te)) {
				EnableItem(menu, cutID);		/* Enable cut. */
				EnableItem(menu, cutID + 3);	/* Enable clear. */
			}
			active = true;
			EnableItem(menu, cutID + 1);		/* Enable copy. */
		}
		if (!CTEReadOnly(te)) {
			dataLen = GetScrap(nil, 'TEXT', &scrapOffset);
			if (dataLen > 0) {
				active = true;
				EnableItem(menu, cutID + 2);		/* Enable paste. */
			}
		}
	}

	if (activeItem)
		*activeItem = active;

	return(true);
}



/*****************************************************************************/



/* Handle the event if it applies to the active TextEdit control.  If some
** action occured due to the event, return true. */

#pragma segment TextEditControl
Boolean	CTEEvent(WindowPtr window, EventRecord *event, short *action)
{
	WindowPtr	clickWindow;
	short		actn;

	if (action)
		*action = 0;

	switch(event->what) {

		case mouseDown:
			if (FindWindow(event->where, &clickWindow) == inContent)
				if (window == clickWindow)
					if (((WindowPeek)window)->hilited) return(CTEClick(window, event, action));
			break;

		case autoKey:
		case keyDown:
			if (!(event->modifiers & cmdKey)) {
				actn = CTEKey(window, event);
				if (action)
					*action = actn;
				if (actn) return(true);
			}
			break;
	}

	return(false);
}



/*****************************************************************************/



/* Returns the active TextEdit control, if any.  If nil is passed in, then
** the return value represents whatever TextEdit control is active, independent
** of what window it is in.  If a window is passed in, then it returns a
** TextEdit control only if the active control is in the specified window.
** If the active TextEdit control is in some other window, then nil is returned. */

#pragma segment TextEditControl
TEHandle	CTEFindActive(WindowPtr window)
{
	if (!window) return(gActiveTEHndl);
		/* User wants whatever is active one, for whatever window. */

	if (!gActiveTEHndl) return(nil);
	if (window != (*gActiveTEHndl)->inPort) return(nil);
	return(gActiveTEHndl);
}



static TEHandle	dummyCTEFindActive(WindowPtr window)
{
#pragma unused (window)
	return(nil);
}



/*****************************************************************************/



/* This determines if a TextEdit control was clicked on directly.  This does
** not determine if a related scrollbar was clicked on.  If a TextEdit
** control was clicked on, then true is returned, as well as the TextEdit
** handle and the handle to the view control. */

#pragma segment TextEditControl
ControlHandle	CTEFindCtl(WindowPtr window, EventRecord *event, TEHandle *teHndl, ControlHandle *ctlHit)
{
	WindowPtr		oldPort;
	Point			mouseLoc;
	ControlHandle	ctl, tectl;
	TEHandle		te;

	if (ctlHit) *ctlHit = nil;
	if (teHndl) *teHndl = nil;

	gFoundTEHndl = nil;

	if (window) {
		GetPort(&oldPort);
		SetPort(window);
		mouseLoc = event->where;
		GlobalToLocal(&mouseLoc);
		SetPort(oldPort);

		if (!WhichControl(mouseLoc, 0, window, &ctl)) return(nil);
			/* Didn't hit a thing, so forget it. */

		if (te = CTEFromScroll(ctl, &tectl)) {
			if (ctlHit)
				*ctlHit = ctl;
			if (teHndl)
				*teHndl = te;
			return(tectl);
		}

		FindControl(mouseLoc, window, &ctl);
		if (!ctl)                                     return(nil);
		if (*(*ctl)->contrlDefProc != *(Handle)gCDEF) return(nil);
			/* Control hit was above TE control, so we didn't hit a TE control. */
		if (ctlHit)
			*ctlHit = ctl;
		if (teHndl)
			*teHndl = gFoundTEHndl;
		if (gFoundTEHndl) return(ctl);
	}

	return(nil);
}



/*****************************************************************************/



/* Find the TextEdit record that is related to the indicated scrollbar. */

#pragma segment TextEditControl
TEHandle	CTEFromScroll(ControlHandle scrollCtl, ControlHandle *retCtl)
{
	WindowPtr		window;
	ControlHandle	viewCtl;
	TEHandle		te;

	if (!IsScrollBar(scrollCtl)) {
		if (retCtl) *retCtl = nil;
		return(nil);
	}

	window = (*scrollCtl)->contrlOwner;

	for (viewCtl = nil;;) {
		viewCtl = CTENext(window, &te, viewCtl, 1, false);
		if (!viewCtl) return(nil);
		if (viewCtl == (ControlHandle)GetCRefCon(scrollCtl)) {
			if (retCtl) *retCtl = viewCtl;
			return(te);
		}
	}
}



/*****************************************************************************/



/* Hide the designated TextEdit control and related scrollbars. */

#pragma segment TextEditControl
Rect	CTEHide(TEHandle teHndl)
{
	ControlHandle	viewCtl, scrollCtl;
	short			i, mode;
	CTEDataHndl		teData;
	Rect			viewRct, brdrRct;

	SetRect(&brdrRct, 0, 0, 0, 0);

	if (teHndl) {
		CTEActivate(false, teHndl);
		viewCtl = CTEViewFromTE(teHndl);
		if (viewCtl) {
			HideControl(viewCtl);
			for (i = 0; i < 2; i++) {
				scrollCtl = CTEScrollFromView(viewCtl, i);
				if (scrollCtl)
					HideControl(scrollCtl);
			}

			teData  = (CTEDataHndl)(*viewCtl)->contrlData;
			mode    = (*teData)->mode;
			viewRct = (*teHndl)->viewRect;
			brdrRct = (*teData)->brdrRect;
		
			if (EmptyRect(&brdrRct)) brdrRct = viewRct;

			if (mode & cteVScroll) brdrRct.right  += 15;
			if (mode & cteHScroll) brdrRct.bottom += 15;

			if (mode & cteShowActive) InsetRect(&brdrRct, -3, -3);
		}
	}

	return(brdrRct);
}



/*****************************************************************************/



/* Blink the caret in the active TextEdit control.  The active TextEdit
** control may be read-only, in which case the caret does not blink. */

#pragma segment TextEditControl
void	CTEIdle(void)
{
	WindowPtr		window;
	ControlHandle	viewCtl;
	Rect			rct;

	if (gActiveTEHndl) {
		if (!(viewCtl = CTEViewFromTE(gActiveTEHndl))) return;
		if (!((*viewCtl)->contrlVis))                  return;
		if ((*viewCtl)->contrlHilite == 255)           return;
		window = (*gActiveTEHndl)->inPort;
		if (((WindowPeek)window)->hilited) {
			if (GetWRefCon(window)) {
				rct = (*(((WindowPeek)window)->updateRgn))->rgnBBox;
				if (EmptyRect(&rct))
					TEIdle(gActiveTEHndl);
			}
		}
	}
}



/*****************************************************************************/



/* See if the keypress event applies to the TextEdit control, and if it does,
** handle it and return non-zero.  If the key caused a change in the TERecord,
** return 2.  If the key was handled with no change to the TERecord, return 1. */

#pragma segment TextEditControl
short	CTEKey(WindowPtr window, EventRecord *event)
{
	TEHandle			te;
	ControlHandle		viewCtl;
	short				maxTextLen, selStart, selEnd;
	short				textSelected, arrowKey, retval;
	char				key;
	CTEDataHndl			teData;
	CTEKeyFilterProcPtr	kproc;
	CTEFastKeysProcPtr	fproc;
	short				handled;
	Boolean				looping, refig, tsmHandled;
	EventRecord			lclEvent;

	if (!(te = gActiveTEHndl))				return(0);
	if ((*gActiveTEHndl)->inPort != window) return(0);
	if (CTEReadOnly(te))					return(0);
	if (!(viewCtl = CTEViewFromTE(te)))		return(0);
	if ((*viewCtl)->contrlHilite == 255)	return(0);

	teData = (CTEDataHndl)(*viewCtl)->contrlData;
	handled = 0;
	if (kproc = (*teData)->keyFilter)
		if ((*kproc)(te, event, &handled))
			return(handled);

	retval = 1;

	for (refig = looping = false;; looping = true) {

		if (looping) {

			if (!(fproc = (*teData)->fastKeys)) {
				if (refig) {
					CTEAdjustTEBottom(te);
					CTEAdjustScrollValues(te);
				}
				return(retval);
			}						/* No fast keys looping proc defined, so leave. */

			if ((gSystemVersion >= 0x0700) && (HMGetBalloons())) {
				if (refig) {
					CTEAdjustTEBottom(te);
					CTEAdjustScrollValues(te);
				}
				return(retval);
			}						/* Don't call OSEventAvail if balloons are active, since
									** the help manager may move a balloon when it is called.
									** If we moved balloons now, that might be bad, since it
									** is likely that BeginContent was called prior to getting
									** here.  BeginContent calls BeginUpdate, which munges the
									** visRgn.  If balloons were managed, then visRgns would get
									** recalculated, and this would mess up our munged balloon. */

			event = &lclEvent;
			if (!OSEventAvail((mDownMask | keyDownMask | autoKeyMask), event)) {
				if (refig) {
					CTEAdjustTEBottom(te);
					CTEAdjustScrollValues(te);
				}
				return(retval);
			}

			if (kproc) {
				handled = 0;
				if ((*kproc)(te, event, &handled)) {
					if (refig) {
						CTEAdjustTEBottom(te);
						CTEAdjustScrollValues(te);
					}
					return(retval);
				}
			}

			if (!(*fproc)(te, event)) {
				if (refig) {
					CTEAdjustTEBottom(te);
					CTEAdjustScrollValues(te);
				}
				return(retval);
			}

			GetOSEvent((mDownMask | keyDownMask | autoKeyMask), event);
		}

		maxTextLen = (*teData)->maxTextLen;
		key        = event->message & charCodeMask;
		selStart   = (*te)->selStart;
		selEnd     = (*te)->selEnd;
		if (selStart > selEnd) {
			selStart = selEnd;
			selEnd = (*te)->selStart;
		}
		textSelected = (selStart != selEnd);
		arrowKey     = ((key >= chLeft) && (key <= chDown));

		if (
			(textSelected) ||				/* If selection range to be replaced or */
			(arrowKey) ||					/* key is an arrow or					*/
			(key == 8) ||					/* key is a delete or                   */
			((*te)->teLength < maxTextLen)	/* we have space for the key...         */
		) {
			tsmHandled = false;
			if (gUseTSMTE) {
				if (tsmHandled = TSMEvent(event))
					if (!arrowKey)
						retval = 2;
			}
			if (!tsmHandled) {
				if (arrowKey) {
					(*teData)->newUndo = true;
					TEKey(key, te);
				}
				else {
					CTENewUndo(viewCtl, false);		/* Process the character... */
					TEKey(key, te);
					retval = 2;
				}
			}
			refig = true;
		}
	}
}



static short	dummyCTEKey(WindowPtr window, EventRecord *event)
{
#pragma unused (window, event)
	return(0);
}



/*****************************************************************************/



/* This function is used to move a TextEdit control.  Pass it the TextEdit
** record to move, plus the new position.  It will move the TextEdit control,
** along with any scrollbars the control may have.  All areas that need
** updating are cleared and invalidated. */

#pragma segment TextEditControl
void	CTEMove(TEHandle teHndl, short newH, short newV)
{
	WindowPtr		oldPort;
	Rect			viewRct, brdrRct, rct;
	short			i, dx, dy, mode;
	Boolean			hScroll, vScroll;
	ControlHandle	viewCtl, ctl;
	CTEDataHndl		teData;

	if (!(viewCtl = CTEViewFromTE(teHndl))) return;

	GetPort(&oldPort);
	SetPort((*teHndl)->inPort);

	viewRct = (*viewCtl)->contrlRect;
	teData  = (CTEDataHndl)(*viewCtl)->contrlData;
	brdrRct = (*teData)->brdrRect;
	mode    = (*teData)->mode;

	dx = newH - viewRct.left;
	dy = newV - viewRct.top;
	if ((!dx) && (!dy)) return;

	hScroll = (mode & cteHScroll) ? 1 : 0;
	vScroll = (mode & cteVScroll) ? 1 : 0;
		/* Get enough info to determine if we need to fix the scrollbar sizes. */

	rct = viewRct;				/* Erase all of the old list control and scrollbars. */
	if (!EmptyRect(&brdrRct))
		UnionRect(&rct, &brdrRct, &rct);
	if (vScroll)
		rct.right += 15;
	if (hScroll)
		rct.bottom += 15;
	if (mode & cteShowActive)
		InsetRect(&rct, -4, -4);
	EraseRect(&rct);
	InvalRect(&rct);

	for (i = 0; i < 2; ++i) {
		if (ctl = CTEScrollFromView(viewCtl, i)) {
			rct = (*ctl)->contrlRect;
			MoveControl(ctl, rct.left + dx, rct.top + dy);
		}
	}

	OffsetRect(&viewRct, dx, dy);
	InvalRect(&viewRct);
	OffsetRect(&brdrRct, dx, dy);
	InvalRect(&brdrRct);

	(*viewCtl)->contrlRect = viewRct;
	(*teData)->brdrRect    = brdrRct;

	OffsetRect(&(*teHndl)->destRect, dx, dy);
	OffsetRect(&(*teHndl)->viewRect, dx, dy);

	viewRct.top  = viewRct.bottom - 16;
	viewRct.left = viewRct.right  - 16;

	if (mode & (cteVScrollLessGrow - cteVScroll + cteHScrollLessGrow - cteHScroll))
		EraseRect(&viewRct);

	if (mode & (cteVScrollLessGrow - cteVScroll))
		OffsetRect(&viewRct, 16, 0);
	if (mode & (cteHScrollLessGrow - cteHScroll))
		OffsetRect(&viewRct, 0, 16);
	InvalRect(&viewRct);

	SetPort(oldPort);
}



/*****************************************************************************/



/* Create a new TextEdit control.  See the comments at the beginning of this
** file for more information.  Note that this function doesn't get a dummy,
** as you really mean to have this code if you call it.  It calls CTEInitialize(),
** just to make sure that the proc pointers are set to point to the real function,
** instead of the dummy functions.  By having CLTENew() call CTEInitialize(), the
** application won't have to worry about calling CTEInitialize().  By the time that
** the application is using a TextEdit control, the proc pointers will be initialized. */

#pragma segment TextEditControl
OSErr	CTENew(short viewID, Boolean vis, WindowPtr window, TEHandle *teHndl, Rect *cRect, Rect *dRect,
			   Rect *vRect, Rect *bRect, short maxTextLen, short mode)
{
	Rect			ctlRct, destRct, viewRct, brdrRct, scrollRct;
	WindowPtr		oldPort;
	TEHandle		te;
	short			width, height, lh, a;
	ControlHandle	viewCtl, hScrollCtl, vScrollCtl;
	CTEDataHndl		teData;
	TextStyle		styl;
	OSErr			err;
	TSMDocumentID	docID;
	TSMTERecHandle	tsmRec;
	static OSType	supportedInterfaceTypes[] = {kTSMTEInterfaceType};

	CTEInitialize();

	if (teHndl)
		*teHndl = nil;			/* Assume that we will fail. */

	GetPort(&oldPort);
	SetPort(window);

	ctlRct  = *cRect;
	destRct = *dRect;
	viewRct = *vRect;
	brdrRct = *bRect;
		/* Make sure that the rects are not in memory that may move. */

	te = TEStylNew(&destRct, &viewRct);			/* Do the main thing. */

	err = noErr;
	viewCtl = hScrollCtl = vScrollCtl = nil;
		/* Prepare for various failures. */

	docID = nil;

	if (te) {		/* If we were able to create the TextEdit record... */

		if(gUseTSMTE) {
			if (!(err = NewTSMDocument(1, supportedInterfaceTypes, &docID, (long)&tsmRec))) {
				(*tsmRec)->textH 	      = te;
				(*tsmRec)->preUpdateProc  = nil;
				(*tsmRec)->postUpdateProc = (TSMPostUpdateProcPtr)&TSMTEUpdateProc;
				(*tsmRec)->updateFlag     = 0;
				(*tsmRec)->refCon         = 0;
			}
		}

		if (mode & cteCenterJustify)
			TESetJust(1, te);

		if (mode & cteRightJustify)
			TESetJust(-1, te);

		TEGetStyle(0, &styl, &lh, &a, te);
		if (styl.tsFont == 1) {
			styl.tsFont = GetAppFont();
			styl.tsSize = GetDefFontSize();
			TESetStyle((doFont | doSize), &styl, false, te);
		}

		TEAutoView(true, te);
			/* Let TextEdit 3.0 do most of the scrolling work. */

		gDefaultClikLoopUPP = (*te)->clickLoop;
#if USES68KINLINES
		(*te)->clickLoop = (ProcPtr)ASMTECLIKLOOP;
#else
		if (!gClikLoopUPP) {
			gClikLoopUPP = NewTEClickLoopProc(PPCClikLoop);
			TESetClickLoop(gClikLoopUPP, te);
		}
#endif
		

		if (!gCDEF) {
			gCDEF = (cdefRsrcJMPHndl)GetResource('CDEF', (viewID / 16));
			if (!gCDEF) return(resNotFound);

			if (!gCTECtlUPP) {
				gCTECtlUPP = NewControlDefProc(CTECtl);
			}
			(*gCDEF)->jmpAddress = (long)gCTECtlUPP;
			FlushInstructionCache();	/* Make sure that instruction caches don't kill us. */
		}

		if (mode & cteHScroll) {		/* Caller wants a horizontal scrollbar... */
			SetRect(&scrollRct, 0, 0, 100, 16);
			hScrollCtl = NewControl(window, &scrollRct, "\p", vis, 0, 0, 0, scrollBarProc, 0);
			if (hScrollCtl) {
				MoveControl(hScrollCtl, brdrRct.left, brdrRct.bottom - 1);
				width = brdrRct.right - brdrRct.left;
				if (mode & (cteHScrollLessGrow - cteHScroll))
					if (!(mode & cteVScroll))
						width -= 15;
				SizeControl(hScrollCtl, width, 16);
					/* Line the scrollbar up with the borderRct. */
			}
			else err = resNotFound;
		}

		if (mode & cteVScroll) {		/* Caller wants a vertical scrollbar... */
			SetRect(&scrollRct, 0, 0, 16, 100);
			vScrollCtl = NewControl(window, &scrollRct, "\p", vis, 0, 0, 0, scrollBarProc, 0);
			if (vScrollCtl) {
				MoveControl(vScrollCtl, brdrRct.right - 1, brdrRct.top);
				height = brdrRct.bottom - brdrRct.top;
				if (mode & (cteVScrollLessGrow - cteVScroll))
					if (!(mode & cteHScroll))
						height -= 15;
				SizeControl(vScrollCtl, 16, height);
					/* Line the scrollbar up with the borderRct. */
			}
			else err = resNotFound;
		}

		viewCtl = NewControl(window, &ctlRct, "\p", false, 0, 0, 0, viewID, (long)te);
			/* Use our custom view cdef.  It's wierd, but it's small. */

		if (!viewCtl)
			err = resNotFound;
		else {
			if (hScrollCtl)
				SetCRefCon(hScrollCtl, (long)viewCtl);
			if (vScrollCtl)
				SetCRefCon(vScrollCtl, (long)viewCtl);
			(*viewCtl)->contrlData = nil;
			if (teData = (CTEDataHndl)NewHandleClear(sizeof(CTEDataRec))) {
				(*teData)->maxTextLen   = maxTextLen;
				(*teData)->newUndo      = true;
				(*teData)->mode         = mode;
				(*teData)->brdrRect     = brdrRct;
				(*teData)->brdrRect     = brdrRct;
				if (!(mode & cteNoFastKeys))
					(*teData)->fastKeys = GoFast;
				(*teData)->docID        = docID;
				(*viewCtl)->contrlData  = (Handle)teData;
			}
			else {
				err = memFullErr;
				if (docID)
					DeleteTSMDocument(docID);
			}
		}
	}
	else err = memFullErr;

	SetPort(oldPort);

	if (err) {		/* Oops.  Somebody wasn't happy. */
		if (viewCtl)
			DisposeControl(viewCtl);
				/* This also disposes of TextEdit handle! */
		else
			if (te)
				TEDispose(te);
					/* We have to dispose of the TextEdit handle ourselves if
					** creating the view control failed. */

		te = nil;		/* Indicate that there is no TextEdit control. */

		if (hScrollCtl)
			DisposeControl(hScrollCtl);
				/* More clean-up. */

		if (vScrollCtl)
			DisposeControl(vScrollCtl);
				/* And still more clean-up. */
	}
	else {
		if (mode & cteActive)
			CTEActivate(true, te);

		if (vis) ShowStyledControl(viewCtl);		/* Since everything worked, show the control. */

		if (mode & cteReadOnly) {
			if (!gNoCaretHookUPP) {
#if USES68KINLINES
				gNoCaretHookUPP = (ProcPtr)ASMNOCARET;
#else
				gNoCaretHookUPP = NewCaretHookProc(PPCNoCaret);
#endif
			}
			(*te)->caretHook = gNoCaretHookUPP;
				/* If read-only, then disable caret for this TextEdit control. */
		}

		if (teHndl)
			*teHndl = te;
		CTEAdjustScrollValues(te);
			/* Give the scrollbars an initial value.  This is because the
			** TextEdit control could have been created with
			** destRct.top < viewRct.top or destRct.left < viewRct.left.
			** I don't know why anyone would want to, but it is legal.
			*/
	}

	return(err);
}

static Boolean	GoFast(TEHandle teHndl, EventRecord *event)
{
#pragma unused (teHndl)

	char	key;

	if (event->modifiers & cmdKey) return(false);
	key = event->message & charCodeMask;
	if (key == chTab) return(false);

	return(true);
}



/*****************************************************************************/



/* Save the data (if appropriate) so that user can undo. */

#pragma segment TextEditControl
void	CTENewUndo(ControlHandle viewCtl, Boolean alwaysNewUndo)
{
	TEHandle		teHndl;
	CTEDataHndl		teData;
	Handle			hText, uText;
	StScrpHandle	hStyl, uStyl;

	if (!viewCtl) return;

	teHndl = (TEHandle)GetCRefCon(viewCtl);
	teData = (CTEDataHndl)(*viewCtl)->contrlData;

	if ((!alwaysNewUndo) && (!(*teData)->newUndo)) return;
		/* If there isn't a new undo to record, then just return. */

	hText = (*teHndl)->hText;
	hStyl = CTEGetFullStylScrap(teHndl);
	uText = (*teData)->undoText;
	uStyl = (*teData)->undoStyl;
		/* hText/hStyl is styled text in the TextEdit record that is being edited.  */
		/* uText/uStyl is the undo data (if any) prior to current edit task. */

	if (uText) {				/* Dump the old undo info, if any. */
		DisposeHandle(uText);
		(*teData)->undoText = nil;
	}
	if (uStyl) {
		DisposeHandle((Handle)uStyl);
		(*teData)->undoStyl = nil;
	}

	if (!hStyl) return;
		/* Not enough ram to record undo, so leave. */

	uText = hText;
	if (HandToHand(&uText)) {			/* Copy the text (if ram available). */
		DisposeHandle((Handle)hStyl);
		return;							/* Not enough ram to record undo. */
	}

	(*teData)->undoText     = uText;
	(*teData)->undoStyl     = hStyl;
	(*teData)->newUndo      = false;
	(*teData)->undoSelStart = (*teHndl)->selStart;
	(*teData)->undoSelEnd   = (*teHndl)->selEnd;
}



/*****************************************************************************/



/* Get the next TextEdit control in the window.  You pass it a control handle
** for the view control, or nil to start at the beginning of the window.
** It returns both a TextEdit handle and the view control handle for that
** TextEdit record.  If none is found, nil is returned.  This allows you to
** repeatedly call this function and walk through all the TextEdit controls
** in a window. */

#pragma segment TextEditControl
ControlHandle	CTENext(WindowPtr window, TEHandle *teHndl, ControlHandle ctl, short dir, Boolean justActive)
{
	short			i;
	ControlHandle	nextCtl, priorCtl;

	if (teHndl)
		*teHndl = nil;

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
						if (teHndl)
							*teHndl = (TEHandle)GetCRefCon(ctl);
						return(ctl);
					}
				}
			}
			ctl = (*ctl)->nextControl;
		}
		return(ctl);
	}

	nextCtl = ((WindowPeek)window)->controlList;
	for (i = 1, priorCtl = nil; ;nextCtl = (*nextCtl)->nextControl, ++i) {
		if ((!nextCtl) || (nextCtl == ctl)) {
			if (priorCtl)
				if (teHndl)
					*teHndl = (TEHandle)GetCRefCon(priorCtl);
			return(priorCtl);
		}
		if ((!justActive) || ((*nextCtl)->contrlVis)) {
			if ((!justActive) || ((*nextCtl)->contrlHilite != 255)) {
				if (*(*nextCtl)->contrlDefProc == *(Handle)gCDEF)
					priorCtl = nextCtl;
			}
		}
	}
}



static ControlHandle	dummyCTENext(WindowPtr window, TEHandle *teHndl, ControlHandle ctl, short dir, Boolean justActive)
{
#pragma unused (window, ctl, dir, justActive)
	*teHndl = nil;
	return(nil);
}



/*****************************************************************************/



/* Return the number of lines of text.  This is because there is a bug in
** TextEdit where the number of lines returned is incorrect if the text
** ends with a c/r.  This function adjusts for this bug. */

#pragma segment TextEditControl
short	CTENumTextLines(TEHandle teHndl)
{
	short	lines;
	char	*cptr;

	if (!teHndl) return(0);

	lines = (*teHndl)->nLines;

	cptr = *((*teHndl)->hText);		/* Pointer to first TextEdit character. */
	if (cptr[(*teHndl)->teLength - 1] == kCrChar)
		++lines;
			/* Since nLines isn’t right if the last character is a return,
			** check for that case and fix it. */

	return(lines);
}



/*****************************************************************************/



/* Use this function to print the contents of a TextEdit record.  Pass it a
** TextEdit handle, a pointer to a text offset, and a pointer to a rect to
** print the text in.  The offset should be initialized to what character
** in the TextEdit record you wish to start printing at (most likely 0).
** The print function prints as much text as will fit in the rect, and
** then updates the offset to tell you what is the first character that didn't
** print.  You can then call the print function again with another rect with
** this new offset, and it will print the text starting at the new offset.
** This method is very useful when a single TextEdit record is longer than a
** single page, and you wish the text to break at the end of the page.
** The bottom of rect is also updated, along with the offset.  The bottom edge
** of the rect is changed to reflect the actual bottom of the text printed.
** This is useful because the rect passed in didn't necessarily hold an
** integer number of lines of text.  The bottom of the rect is adjusted so
** it exactly holds complete lines of text.
** It is also possible that the rect could hold substantially more lines of
** text than there are remaining.  Again, in this situation, the bottom of
** rect is adjusted so that the rect tightly bounds the text printed.
** The remaining piece of information passed back is an indicator that the
** text through the end of the TextEdit record was printed.  When the end
** of the text is reached, the offset for the next text to be printed is
** returned as -1.  This indicates that processing of the TextEdit record
** is complete. */

#pragma segment TextEditControl
OSErr	CTEPrint(TEHandle teHndl, short *teOffset, Rect *teRct)
{
	short			len, offset, numLines, rctHeight, selStart, selEnd, lnum, y, lh;
	Handle			hText;
	Rect			keepDestRct, keepViewRct;
	WindowPtr		printPort;
	StScrpHandle	fullStyl, partStyl;

	if (!teHndl) return(noErr);

	len = (*teHndl)->teLength;
	if ((offset = *teOffset) >= len) {
		*teOffset = -1;					/* We are offset further than we have text. */
		teRct->bottom = teRct->top;		/* Empty rect, since no text to draw.  */
		return(noErr);					/* Just say that we have no more text. */
	}

	if (!(hText = NewHandle(len - offset))) return(memFullErr);
		/* Can't make part-text handle, so leave. */

	BlockMove((*(*teHndl)->hText) + offset, *hText, len - offset);
		/* hText now holds all characters after offset. */

	fullStyl = CTEGetFullStylScrap(teHndl);
	if (!fullStyl) {
		DisposeHandle(hText);		/* Couldn't get styles, so clean up and leave. */
		return(memFullErr);
	}

	if (partStyl = fullStyl) {				/* This assignment tests for styled TE, and if there
											** is none, then partStyl gets initialized to nil. */

		selStart = (*teHndl)->selStart;		/* Get all styles after the offset. */
		selEnd   = (*teHndl)->selEnd;
		(*teHndl)->selStart = offset;
		(*teHndl)->selEnd   = (*teHndl)->teLength;
		partStyl = GetStylScrap(teHndl);
		(*teHndl)->selStart = selStart;
		(*teHndl)->selEnd   = selEnd;
		if (!partStyl) {
			DisposeHandle((Handle)fullStyl);
			DisposeHandle(hText);
			return(memFullErr);
		}
	}

	keepDestRct = (*teHndl)->destRect;
	keepViewRct = (*teHndl)->viewRect;
	gTEWindow   = (*teHndl)->inPort;
		/* Cache some information from the TextEdit record. */

	GetPort(&printPort);
	(*teHndl)->inPort = printPort;
	(*teHndl)->destRect = (*teHndl)->viewRect = *teRct;
		/* Install the print rect into the TextEdit record so CTESwapText
		** recalcs against the print text. */

	hText = CTESwapText(teHndl, hText, partStyl, false);
	DisposeHandle((Handle)partStyl);
		/* We now have all of the text starting at offset formatted correctly in the print rect. */

	rctHeight = teRct->bottom - teRct->top;
	numLines  = CTENumTextLines(teHndl);
	for (y = 0, lnum = 1; lnum <= numLines; ++lnum) {
		lh = CTEGetLineHeight(teHndl, lnum, nil);
		if (y + lh > rctHeight) break;
		y += lh;
	}
	teRct->bottom = teRct->top + y;
	
	(*teHndl)->destRect = (*teHndl)->viewRect = *teRct;
		/* We now have the minimum rectangle to hold as much of the text
		** as would fit into the rectangle passed in.  The final calc on
		** the rect prevents partial lines from being drawn. */

	TEUpdate(teRct, teHndl);		/* Draw this portion of the text. */

	if (--lnum >= numLines)
		*teOffset = -1;
			/* Printed the last of the text for this record. */
	else
		*teOffset = (*teHndl)->lineStarts[lnum] + offset;
			/* Offset to the first character not printed. */

	(*teHndl)->inPort   = gTEWindow;
	gTEWindow           = nil;
	(*teHndl)->destRect = keepDestRct;
	(*teHndl)->viewRect = keepViewRct;

	DisposeHandle(CTESwapText(teHndl, hText, fullStyl, false));
	DisposeHandle((Handle)fullStyl);

	return(noErr);			/* Everything worked. */
}



/*****************************************************************************/



/* Return if the TextEdit control is read/write (true) or read-only (false). */

#pragma segment TextEditControl
Boolean	CTEReadOnly(TEHandle teHndl)
{
	if (teHndl)
		if (gNoCaretHookUPP)
			if ((*teHndl)->caretHook == (ProcPtr)gNoCaretHookUPP)
				return(true);

	return(false);
}



/*****************************************************************************/



/* Return the control handle for the TextEdit control's scrollbar, either
** vertical or horizontal.  If the scrollbar doesn't, nil is returned. */

#pragma segment TextEditControl
ControlHandle	CTEScrollFromTE(TEHandle teHndl, Boolean vertScroll)
{
	ControlHandle	viewCtl;

	if (!(viewCtl = CTEViewFromTE(teHndl))) return(nil);

	return(CTEScrollFromView(viewCtl, vertScroll));
}



/*****************************************************************************/



/* Return the control handle for the scrollbar related to the view control,
** either horizontal or vertical.  If the scrollbar doesn't exist, return nil. */

#pragma segment TextEditControl
ControlHandle	CTEScrollFromView(ControlHandle viewCtl, Boolean vertScroll)
{
	ControlHandle	ctl;
	WindowPtr		window;
	Boolean			vert;

	if (!viewCtl) return(nil);

	window = (*viewCtl)->contrlOwner;
	ctl    = ((WindowPeek)window)->controlList;

	for (; ctl;) {
		if ((ControlHandle)GetCRefCon(ctl) == viewCtl) {
			vert = false;
			if ((*ctl)->contrlRect.right == (*ctl)->contrlRect.left + 16)
				vert = true;
			if (vert == vertScroll) return(ctl);
		}
		ctl = (*ctl)->nextControl;
	}
	return(nil);
}



/*****************************************************************************/



/* A TextEdit control can have an optional key filter, which is called whenever
** CTEKey() is called.  If you pass in nil, then the filtering is turned off.
** This allows individual TextEdit controls to handle their own filtering.
** The filter procedure is of the form:
**     Boolean (*CTEKeyFilterProcPtr)(TEHandle teHndl, EventRecord *event, short *handled);
** If true is returned, then CTEKey() is aborted, and the value in "handled" is
** returned.  By having a separate abort value and return value, you can determine
** if processing of the event should be continued or not, independent of whether
** or not you aborted CTEKey(). */

#pragma segment TextEditControl
void	CTESetKeyFilter(TEHandle teHndl, CTEKeyFilterProcPtr proc)
{
	ControlHandle	viewCtl;
	CTEDataHndl		teData;

	if (!(viewCtl = CTEViewFromTE(teHndl))) return;
	teData = (CTEDataHndl)(*viewCtl)->contrlData;
	(*teData)->keyFilter = proc;
}



/*****************************************************************************/



#pragma segment TextEditControl
void	CTESetFastKeys(TEHandle teHndl, CTEFastKeysProcPtr proc)
{
	ControlHandle	viewCtl;
	CTEDataHndl		teData;

	if (!(viewCtl = CTEViewFromTE(teHndl))) return;
	teData = (CTEDataHndl)(*viewCtl)->contrlData;
	(*teData)->fastKeys = proc;
}



/*****************************************************************************/



/* Select a range of text.  TESetSelect can't be used alone because it doesn't
** update the scrollbars.  This function calls TESetSelect, and then fixes up
** the scrollbars. */

#pragma segment TextEditControl
void	CTESetSelect(short start, short end, TEHandle teHndl)
{
	WindowPtr		oldPort;
	ControlHandle	viewCtl;
	CTEDataHndl		teData;

	if (teHndl) {
		GetPort(&oldPort);
		SetPort((*teHndl)->inPort);
		TESetSelect(start, end, teHndl);
		CTEAdjustScrollValues(teHndl);
		if (viewCtl = CTEViewFromTE(teHndl)) {
			teData = (CTEDataHndl)(*viewCtl)->contrlData;
			(*teData)->newUndo = true;
		}
		SetPort(oldPort);
	}
}



static void	dummyCTESetSelect(short start, short end, TEHandle teHndl)
{
#pragma unused (start, end, teHndl)
}



/*****************************************************************************/



/* Show the designated TextEdit control and related scrollbars. */

#pragma segment TextEditControl
void	CTEShow(TEHandle teHndl)
{
	ControlHandle	viewCtl, scrollCtl;
	short			i;

	if (viewCtl = CTEViewFromTE(teHndl)) {
		ShowStyledControl(viewCtl);
		for (i = 0; i < 2; i++) {
			scrollCtl = CTEScrollFromView(viewCtl, i);
			if (scrollCtl)
				ShowStyledControl(scrollCtl);
		}
	}
}



/*****************************************************************************/



/* This function is used to resize a TextEdit control.  Pass it the TextEdit
** record to resize, plus the new horizontal and vertical size.  It will
** resize the TextEdit control, realign the text, if necessary, plus it will
** resize and adjust any scrollbars the TextEdit control may have.  All areas
** that need updating are cleared and invalidated. */

#pragma segment TextEditControl
void	CTESize(TEHandle teHndl, short newH, short newV, Boolean newDest)
{
	WindowPtr		oldPort;
	Rect			viewRct, brdrRct, teViewRct, oldTeViewRct, rct;
	short			i, dx, dy, mode, hScroll, vScroll;
	ControlHandle	viewCtl, ctl[2];
	CTEDataHndl		teData;
	RgnHandle		rgn1, rgn2;

	if (!(viewCtl = CTEViewFromTE(teHndl))) return;

	GetPort(&oldPort);
	SetPort((*teHndl)->inPort);

	viewRct = (*viewCtl)->contrlRect;
	teData  = (CTEDataHndl)(*viewCtl)->contrlData;
	brdrRct = (*teData)->brdrRect;
	mode    = (*teData)->mode;

	dx = newH - (viewRct.right  - viewRct.left);
	dy = newV - (viewRct.bottom - viewRct.top);
	if ((!dx) && (!dy)) return;

	hScroll = (mode & cteHScroll) ? 1 : 0;
	vScroll = (mode & cteVScroll) ? 1 : 0;
		/* Get enough info to determine if we need to fix the scrollbar sizes. */

	rct = viewRct;				/* Erase all of the old list control and scrollbars. */
	if (!EmptyRect(&brdrRct))
		UnionRect(&rct, &brdrRct, &rct);
	if (vScroll)
		rct.right += 15;
	if (hScroll)
		rct.bottom += 15;
	if (mode & cteShowActive)
		InsetRect(&rct, -4, -4);
	EraseRect(&rct);
	InvalRect(&rct);

	for (i = 0; i < 2; ++i) {
		if (ctl[i] = CTEScrollFromView(viewCtl, i)) {
			rct = (*ctl[i])->contrlRect;
			if (i) {
				HideControl(ctl[i]);
				SizeControl(ctl[i], rct.right - rct.left, rct.bottom - rct.top + dy);
				MoveControl(ctl[i], rct.left + dx, rct.top);
			}
			else {
				HideControl(ctl[i]);
				SizeControl(ctl[i], rct.right - rct.left + dx, rct.bottom - rct.top);
				MoveControl(ctl[i], rct.left, rct.top + dy);
			}
		}
	}		/* Reposition the scrollbars, if we have any. */

	InvalRect(&viewRct);		/* Resize our view control. */
	viewRct.right  += dx;
	viewRct.bottom += dy;
	(*viewCtl)->contrlRect = viewRct;
	InvalRect(&viewRct);

	InvalRect(&brdrRct);		/* Resize our border rect. */
	brdrRct.right  += dx;
	brdrRct.bottom += dy;
	(*teData)->brdrRect = brdrRct;
	InvalRect(&brdrRct);

	teViewRct = oldTeViewRct = (*teHndl)->viewRect;		/* Resize TextEdit viewRect. */
	teViewRct.right  += dx;
	teViewRct.bottom += dy;
	(*teHndl)->viewRect = teViewRct;

	if (newDest) {		/* Resize TextEdit destRect, if so indicated. */
		(*teHndl)->destRect.right  += dx;
		(*teHndl)->destRect.bottom += dy;
		TECalText(teHndl);
		EraseRect(&oldTeViewRct);		/* Redraw the whole thing if destRect changes. */
		InvalRect(&oldTeViewRct);
	}

	rgn1 = NewRgn();
	rgn2 = NewRgn();
	RectRgn(rgn1, &oldTeViewRct);		/* Clear old areas if we are shrinking. */
	RectRgn(rgn2, &teViewRct);
	DiffRgn(rgn1, rgn2, rgn2);
	EraseRgn(rgn2);
	InvalRgn(rgn2);
	RectRgn(rgn2, &teViewRct);			/* Update new areas if we are growing. */
	DiffRgn(rgn2, rgn1, rgn2);
	InvalRgn(rgn2);
	DisposeRgn(rgn1);
	DisposeRgn(rgn2);

	for (i = 0; i < 2; ++i)
		if (ctl[i])
			ShowStyledControl(ctl[i]);
				/* Show the controls in their new position. */

	if (mode & (cteVScrollLessGrow - cteVScroll + cteHScrollLessGrow - cteHScroll)) {
		rct = viewRct;
		rct.top  = rct.bottom - 16;
		rct.left = rct.right - 16;
		if (mode & (cteVScrollLessGrow - cteVScroll))
			OffsetRect(&rct, 16, 0);
		if (mode & (cteHScrollLessGrow - cteHScroll))
			OffsetRect(&rct, 0, 16);
		EraseRect(&rct);
		InvalRect(&rct);
	}

	CTEAdjustTEBottom(teHndl);
	CTEAdjustScrollValues(teHndl);

	SetPort(oldPort);
}



/*****************************************************************************/



/* Swap the TextEdit text handle with the text handle passed in. */

#pragma segment TextEditControl
Handle	CTESwapText(TEHandle teHndl, Handle newText, StScrpHandle styl, Boolean update)
{
	WindowPtr		oldPort;
	Handle			oldText;
	Rect			destRct, viewRct;
	TextStyle		srun;
	ScrpSTElement	s;
	ControlHandle	viewCtl;
	CTEDataHndl		teData;
	RgnHandle		oldClip, newClip;

	if (!teHndl) return(nil);

	GetPort(&oldPort);
	SetPort((*teHndl)->inPort);

	oldText = (*teHndl)->hText;
	HandToHand(&oldText);

	HLock(newText);
	TESetText(*newText, 0, teHndl);							/* Make there be only 1 style run. */
	TESetText(*newText, GetHandleSize(newText), teHndl);	/* Put the correct text in the record. */
	DisposeHandle(newText);

	viewCtl = CTEViewFromTE(teHndl);
	teData  = (CTEDataHndl)(*viewCtl)->contrlData;
	if (!((*teData)->mode & cteRightJustify)) {
		if (!(*viewCtl)->contrlVis) {
			GetClip(oldClip = NewRgn());
			SetClip(newClip = NewRgn());
		}
		TESetSelect(0, 0, teHndl);
		if (!(*viewCtl)->contrlVis) {
			SetClip(oldClip);
			DisposeRgn(oldClip);
			DisposeRgn(newClip);
		}
	}

	if (styl) {
		CTESetStylScrap(0, (*teHndl)->teLength, styl, teHndl);		/* Apply style to all text. */
		if ((*teHndl)->selStart)									/* Apply style to caret loc. */
			s = (*styl)->scrpStyleTab[0];
		else
			s = (*styl)->scrpStyleTab[(*styl)->scrpNStyles - 1];
		srun.tsFont  = s.scrpFont;
		srun.tsFace  = s.scrpFace;
		srun.tsSize  = s.scrpSize;
		srun.tsColor = s.scrpColor;
		TESetStyle(doAll, &srun, false, teHndl);
	}

	GetClip(oldClip = NewRgn());		/* Force the nullStyle to become active. */
	SetClip(newClip = NewRgn());		/* This also resizes the caret to reflect nullStyle size. */
	TEKey(' ', teHndl);
	TEKey(8, teHndl);
	SetClip(oldClip);
	DisposeRgn(oldClip);
	DisposeRgn(newClip);

	TECalText(teHndl);

	if (update) {
		destRct = (*teHndl)->destRect;
		viewRct = (*teHndl)->viewRect;

		OffsetRect(&destRct,
			viewRct.left - destRct.left,
			viewRct.top  - destRct.top);

		(*teHndl)->destRect = destRct;
		(*teHndl)->selStart = (*teHndl)->selEnd = 0;

		CTEUpdate(teHndl, CTEViewFromTE(teHndl), false);
	}

	CTEAdjustTEBottom(teHndl);		/* Fix these things up, whether showing or not. */
	CTEAdjustScrollValues(teHndl);

	SetPort(oldPort);
	return(oldText);
}



/*****************************************************************************/



/* Return information for the currently active TextEdit control.  The currently
** active TextEdit control is stored in gActiveTEHndl, and can be accessed
** directly.  If gActiveTEHndl is nil, then there is no currently active one.
** The information that we return is the viewRect and window of the active
** TextEdit control.  This is information that could be gotten directly, but
** this call makes it a little more convenient. */

#pragma segment TextEditControl
WindowPtr	CTETargetInfo(TEHandle *teHndl, Rect *teView)
{
	if (teView)
		SetRect(teView, 0, 0, 0, 0);

	if (teHndl)
		*teHndl = gActiveTEHndl;

	if (!gActiveTEHndl) return(nil);

	if (teView)
		*teView = (*gActiveTEHndl)->viewRect;

	return((*gActiveTEHndl)->inPort);
}



/*****************************************************************************/



/* Perform an undo function for the TextEdit control. */

#pragma segment TextEditControl
ControlHandle	CTEUndo(void)
{
	TEHandle		teHndl;
	ControlHandle	viewCtl;
	CTEDataHndl		teData;
	Handle			hText, uText;
	StScrpHandle	hStyl, uStyl;
	short			oldStart, oldEnd;

	if (!(teHndl = gActiveTEHndl)) return(nil);

	if (viewCtl = CTEViewFromTE(teHndl)) {
		oldStart = (*teHndl)->selStart;
		oldEnd   = (*teHndl)->selEnd;

		(*teHndl)->selStart = (*teHndl)->selEnd = 0;

		teData = (CTEDataHndl)(*viewCtl)->contrlData;
		hText  = (*teHndl)->hText;
		uText  = (*teData)->undoText;
		if (!uText) return(nil);		/* There is no undo yet.  Getting called in this state is
										** actually an error, but we check, just in case. */

		hStyl = CTEGetFullStylScrap(teHndl);
		uStyl = (*teData)->undoStyl;

		(*teData)->undoText = CTESwapText(teHndl, (*teData)->undoText, uStyl, false);
		DisposeHandle((Handle)uStyl);
		(*teData)->undoStyl = hStyl;

		CTEUpdate(teHndl, viewCtl, false);
		TESetSelect((*teData)->undoSelStart, (*teData)->undoSelEnd, teHndl);
		CTEAdjustTEBottom(teHndl);
		CTEAdjustScrollValues(teHndl);

		(*teData)->newUndo      = true;
		(*teData)->undoSelStart = oldStart;
		(*teData)->undoSelEnd   = oldEnd;
	}

	return(viewCtl);
}



/*****************************************************************************/



/* Draw the TextEdit control and frame. */

#pragma segment TextEditControl
void	CTEUpdate(TEHandle teHndl, ControlHandle ctl, Boolean justShowActive)
{
	WindowPtr	oldPort, tePort;
	Rect		viewRct, brdrRct;
	CTEDataHndl	teData;
	short		mode;

	if (teHndl) {
		if ((*ctl)->contrlVis) {

			GetPort(&oldPort);
			SetPort(tePort = (*teHndl)->inPort);

			teData  = (CTEDataHndl)(*ctl)->contrlData;
			mode    = (*teData)->mode;
			viewRct = (*teHndl)->viewRect;
			brdrRct = (*teData)->brdrRect;

			if (!justShowActive) {
				if (!EmptyRect(&brdrRct)) {
					if (!(mode & cteNoBorder)) {
						FrameRect(&brdrRct);
						InsetRect(&brdrRct, 1, 1);
						EraseRect(&brdrRct);
						InsetRect(&brdrRct, -1, -1);
					}
					else EraseRect(&brdrRct);
				}
				else EraseRect(&viewRct);
				(*teHndl)->caretState &= 0xFF;
				TEUpdate(&viewRct, teHndl);
			}
	
			if (mode & cteShowActive) {
				if (!EmptyRect(&brdrRct)) {
					InsetRect(&brdrRct, -3, -3);
					if (mode & cteVScroll)
						brdrRct.right  += 15;
					if (mode & cteHScroll)
						brdrRct.bottom += 15;
					if ((!((WindowPeek)tePort)->hilited) || (teHndl != gActiveTEHndl))
						PenPat((ConstPatternParam)&qd.white);
					PenSize(2, 2);
					FrameRect(&brdrRct);
					InsetRect(&brdrRct, 2, 2);
					PenSize(1, 1);
					PenPat((ConstPatternParam)&qd.white);
					FrameRect(&brdrRct);
					PenNormal();
				}
			}

			SetPort(oldPort);
		}
	}
}



/*****************************************************************************/



/* Return the control handle for the view control that owns the TextEdit
** record.  Use this to find the view to do customizations such as changing
** the update procedure for this TextEdit control. */

#pragma segment TextEditControl
ControlHandle	CTEViewFromTE(TEHandle teHndl)
{
	WindowPtr		window;
	ControlHandle	viewCtl;
	TEHandle		te;

	if (!teHndl) return(nil);

	if (!(window = gTEWindow))
		window = (WindowPtr)(*teHndl)->inPort;

	for (viewCtl = nil;;) {

		viewCtl = CTENext(window, &te, viewCtl, 1, false);
		if ((!viewCtl) || (te == teHndl)) return(viewCtl);
	}
}



static ControlHandle	dummyCTEViewFromTE(TEHandle teHndl)
{
#pragma unused (teHndl)
	return(nil);
}



/*****************************************************************************/



/* Call this when a window with TextEdit controls is being activated.  This
** will make the TextEdit control that was last active in this window the
** active TextEdit control again. */

#pragma segment TextEditControl
TEHandle	CTEWindActivate(WindowPtr window, Boolean displayIt)
{
	short			hilite, scrollNum;
	ControlHandle	viewCtl, scrollCtl;
	TEHandle		te;
	CTEDataHndl		teData;

	if (!window) return(nil);

	hilite = 255;
	if (((WindowPeek)window)->hilited)
		hilite = 0;

	for (viewCtl = nil; viewCtl = CTENext(window, &te, viewCtl, 1, true);) {

		teData = (CTEDataHndl)(*viewCtl)->contrlData;
		if (!((*teData)->mode & cteActive)) continue;

		if (displayIt) {

			if (!hilite)
				CTEActivate(true, te);
			else
				CTEActivate(false, te);

			for (scrollNum = 0; scrollNum < 2; ++scrollNum) {
				scrollCtl = CTEScrollFromTE(te, scrollNum);
				if (scrollCtl)
					HiliteControl(scrollCtl, hilite);
			}
		}

		if (hilite)
			te = nil;

		return(te);
	}

	return(nil);
}



static TEHandle	dummyCTEWindActivate(WindowPtr window, Boolean displayIt)
{
#pragma unused (window, displayIt)

	return(nil);
}



/*****************************************************************************/



/* This function is called after an edit to make sure that there is no extra
** white space at the bottom of the viewRect.  If there are blank lines at
** the bottom of the viewRect, and there is text scrolled off the top of the
** viewRect, then the TextEdit control is scrolled to fill this space, or as
** much of it as possible. */

#pragma segment TextEditControl
void	CTEAdjustTEBottom(TEHandle teHndl)
{
	Rect	destRct, viewRct;
	short	botDiff, topDiff;

	destRct = (*teHndl)->destRect;
	viewRct = (*teHndl)->viewRect;
	destRct.bottom = destRct.top + CTEDocHeight(teHndl);

	botDiff = viewRct.bottom - destRct.bottom;

	if (botDiff > 0) {
		topDiff = viewRct.top - destRct.top;
		if (botDiff > topDiff)
			botDiff = topDiff;
		if (botDiff)
			TEScroll(0, botDiff, teHndl);
	}
}



/*****************************************************************************/



/* Bring the scrollbar values up to date with the current document position
** and length. */

#pragma segment TextEditControl
void	CTEAdjustScrollValues(TEHandle teHndl)
{
	short			scrollNum;
	ControlHandle	scrollCtl;

	for (scrollNum = 0; scrollNum < 2; ++scrollNum) {
		scrollCtl = CTEScrollFromTE(teHndl, scrollNum);
		if (scrollCtl)
			AdjustOneScrollValue(teHndl, scrollCtl, scrollNum);
	}
}



/*****************************************************************************/



#pragma segment TextEditControl
StScrpHandle	CTEGetFullStylScrap(TEHandle teHndl)
{
	short			selStart, selEnd;
	StScrpHandle	styl;

	selStart = (*teHndl)->selStart;
	selEnd   = (*teHndl)->selEnd;

	(*teHndl)->selStart = 0;
	(*teHndl)->selEnd   = (*teHndl)->teLength;

	styl = GetStylScrap(teHndl);

	(*teHndl)->selStart = selStart;
	(*teHndl)->selEnd   = selEnd;

	return(styl);
}



/*****************************************************************************/



#pragma segment TextEditControl
void	CTESetStylScrap(short begRng, short endRng, StScrpHandle styles, TEHandle teHndl)
{
	short			n, i, b, e, selStart, selEnd;
	ScrpSTElement	styl, s;
	TextStyle		srun;
	TEStyleHandle	shndl;

	if (!styles) return;

	shndl = GetStylHandle(teHndl);

	selStart = (*teHndl)->selStart;
	selEnd   = (*teHndl)->selEnd;

	n = (*styles)->scrpNStyles;

	for (i = 0; i < n;) {
		styl = (*styles)->scrpStyleTab[i++];
		b  = styl.scrpStartChar;
		if (i == n)
			e = endRng;
		else {
			s = (*styles)->scrpStyleTab[i];
			e = s.scrpStartChar;
		}
		if (b >= endRng) break;			/* We're past the range for style application. */
		if (e <= begRng) continue;		/* We're not to the range for style application. */

		if (b < begRng) b = begRng;		/* Clip to range for style application. */
		if (e > endRng) e = endRng;

		if (b < e) {
			srun.tsFont  = styl.scrpFont;
			srun.tsFace  = styl.scrpFace;
			srun.tsSize  = styl.scrpSize;
			srun.tsColor = styl.scrpColor;
			(*teHndl)->selStart = b;
			(*teHndl)->selEnd   = e;
			TESetStyle(doAll, &srun, false, teHndl);
			TECalText(teHndl);
		}
	}

	(*teHndl)->selStart = selStart;
	(*teHndl)->selEnd   = selEnd;
}



/*****************************************************************************/



#pragma segment TextEditControl
short	CTEGetLineNum(TEHandle te, short offset)
{
	short	i;

	for (i = 0; i < (*te)->nLines; ++i)
		if ((*te)->lineStarts[i] > offset)
			break;

	return(i);
}



/*****************************************************************************/



#pragma segment TextEditControl
short	CTEGetLineHeight(TEHandle te, short lineNum, short *ascent)
{
	TEStyleHandle	tes;
	LHHandle		lhh;

	tes = *(TEStyleHandle *)&((*te)->txFont);
	lhh = (*tes)->lhTab;

	if (ascent) *ascent = (*lhh)[lineNum - 1].lhAscent;
	return((*lhh)[--lineNum].lhHeight);
}



/*****************************************************************************/



#pragma segment TextEditControl
void	CTEGetPStr(ControlHandle ctl, StringPtr pstr)
{
	TEHandle		te;
	unsigned short	len;

	if (!ctl) return;
	te = (TEHandle)GetCRefCon(ctl);
	if (!te) return;

	len = (*te)->teLength;
	if (len > 255) len = 255;

	BlockMove(*(*te)->hText, pstr + 1, *pstr = len);
}



/*****************************************************************************/



#pragma segment TextEditControl
void	CTESetPStr(ControlHandle ctl, StringPtr pstr)
{
	TEHandle	te;
	Handle		h;

	if (!ctl) return;
	te = (TEHandle)GetCRefCon(ctl);
	if (!te) return;

	if (h = NewHandle(pstr[0])) {
		BlockMove(pstr + 1, *h, pstr[0]);
		DisposeHandle(CTESwapText(te, h, nil, true));
	}
}



/*****************************************************************************/
/*****************************************************************************/



#pragma segment TextEditControl
static pascal void	VActionProc(ControlHandle scrollCtl, short part)
{
	short		delta, value, teOffset;
	short		oldValue, max, lh, as;
	TEHandle	te;
	TextStyle	styl;
	
	if (part) {						/* If it was actually in the control. */

		te = gActiveTEHndl;
		TEGetStyle((*te)->selStart, &styl, &lh, &as, te);
		switch (part) {
			case inUpButton:
			case inDownButton:		/* One line. */
				delta = lh;
				break;
			case inPageUp:			/* One page. */
			case inPageDown:
				delta = (*te)->viewRect.bottom - (*te)->viewRect.top;
				if (delta > lh)
					delta -= lh;
				break;
		}
		if ( (part == inUpButton) || (part == inPageUp) )
			delta = -delta;		/* Reverse direction for an upper. */

		value = (oldValue = GetCtlValue(scrollCtl)) + delta;
		if (value < 0)
			value = 0;
		if (value > (max = GetCtlMax(scrollCtl)))
			value = max;

		if (value != oldValue) {
			SetCtlValue(scrollCtl, value);
			teOffset = (*te)->viewRect.top - (*te)->destRect.top;
			if (value -= teOffset)
				TEScroll(0, -value, te);
		}
	}
}



/*****************************************************************************/



#pragma segment TextEditControl
static pascal void	HActionProc(ControlHandle scrollCtl, short part)
{
	short		delta, value, teOffset;
	short		oldValue, max;
	TEHandle	te;
	
	if (part) {						/* If it was actually in the control. */

		te = gActiveTEHndl;
		switch (part) {
			case inUpButton:
			case inDownButton:		/* One line. */
				delta = 16;
				break;
			case inPageUp:			/* One page. */
			case inPageDown:
				delta = (*te)->viewRect.right - (*te)->viewRect.left;
				if (delta > 16)
					delta -= 16;
				break;
		}
		if ( (part == inUpButton) || (part == inPageUp) )
			delta = -delta;		/* Reverse direction for an upper. */

		value = (oldValue = GetCtlValue(scrollCtl)) + delta;
		if (value < 0)
			value = 0;
		if (value > (max = GetCtlMax(scrollCtl)))
			value = max;

		if (value != oldValue) {
			SetCtlValue(scrollCtl, value);
			teOffset = (*te)->viewRect.left - (*te)->destRect.left;
			if (value -= teOffset)
				TEScroll(-value, 0, te);
		}
	}
}



/*****************************************************************************/



/* Bring one scrollbar value up to date with the current document position
** and length. */

#pragma segment TextEditControl
static void	AdjustOneScrollValue(TEHandle teHndl, ControlHandle ctl, Boolean vert)
{
	Boolean	front;
	short	textPix, viewPix;
	short	max, oldMax, value, oldValue;

	front = ((WindowPeek)(*ctl)->contrlOwner)->hilited;

	oldValue = GetCtlValue(ctl);
	oldMax   = GetCtlMax(ctl);

	if (vert) {
		textPix = CTEDocHeight(teHndl);
		viewPix = (*teHndl)->viewRect.bottom - (*teHndl)->viewRect.top;
	}
	else {
		textPix = (*teHndl)->destRect.right - (*teHndl)->destRect.left;
		viewPix = (*teHndl)->viewRect.right - (*teHndl)->viewRect.left;
	}
	max = textPix - viewPix;

	if (max < 0)
		max = 0;
	if (max != oldMax) {
		if (front)
			SetCtlMax(ctl, max);
		else
			(*ctl)->contrlMax = max;
	}

	if (vert)
		value = (*teHndl)->viewRect.top  - (*teHndl)->destRect.top;
	else
		value = (*teHndl)->viewRect.left - (*teHndl)->destRect.left;

	if (value < 0)
		value = 0;
	if (value > max)
		value = max;
	if (value != oldValue) {
		if (front)
			SetCtlValue(ctl, value);
		else
			(*ctl)->contrlValue = value;
	}
}



/*****************************************************************************/



#pragma segment TextEditControl
Boolean	CTEUseTSMTE(void)
{
	return(gUseTSMTE = TSMTEAvailable());
}



/*****************************************************************************/



#pragma segment TextEditControl
Boolean	TSMTEAvailable(void)
{
	long	response;
	
	if (Gestalt(kTSMTESignature, &response)) return(false);

	return((response & (1 << gestaltTSMTE)) != 0);
}



/*****************************************************************************/



#pragma segment TextEditControl
static pascal void		TSMTEUpdateProc(TEHandle te, long fixLen, long inputAreaStart,
										long inputAreaEnd, long pinStart, long pinEnd, long refCon)
{
#pragma unused (fixLen, inputAreaStart, inputAreaEnd, pinStart, pinEnd, refCon)

	CTEAdjustTEBottom(te);
	CTEAdjustScrollValues(te);
}



/*****************************************************************************/



/* PPCClikLoop gets called by the TextEdit Manager from TEClick.
** It calls the old, default click loop routine that scrolls the
** text, and then calls our own Pascal routine that handles
** tracking the scroll bars to follow along.  It does the same thing as the
** 68K asm routine ASMTECLIKLOOP, but for PowerPC we don't have all the
** register concerns. */

#ifdef __powerc
static pascal Boolean	PPCClikLoop(TEPtr pTE)
{
	CallTEClickLoopProc(gDefaultClikLoopUPP, pTE);
		/* First call TextEdit's default ClikLoop routine */

	CTEClikLoop();		/* Now call our custom routine */
	return(true);
}

/*****/

/* PPCNoCaret does the samething as the 68K asm routine ASMNOCARET. Namely -- nothing. */
static pascal void	PPCNoCaret(const Rect *r, TEPtr pTE)
{
#pragma unused (boundsRect, pTE)
	return;
}
#endif


