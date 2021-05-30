/*
** Apple Macintosh Developer Technical Support
**
** Program:     DTS.Lib
** File:        window2.c
** Written by:  Eric Soldan
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



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __BALLOONS__
#include <Balloons.h>
#endif

#ifndef __DESK__
#include <Desk.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __CLPROCS__
#include "ListControlProcs.h"
#endif

#ifndef __LOWMEM__
#include <LowMem.h>
#endif

#ifndef __MOVIES__
#include <Movies.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __SCRIPT__
#include <Script.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif



/*****************************************************************************/


typedef struct {
	Rect			contrlRect;
    short			contrlValue;
    unsigned char	contrlVis;
    short			contrlMax;
    short			contrlMin;
    short			procID;
    long			contrlRfCon;
    Str255			contrlTitle;
} CtlTemplate;

extern short	gTECtl;
extern short	gListCtl;
extern short	gCIconCtl;
extern short	gPICTCtl;
extern short	gDataCtl;

extern Handle	gPopupProc;

extern short			gPrintPage;					/* Non-zero means we are printing. */
extern short			gMinVersion, gMaxVersion;
extern Boolean			gInBackground;
extern WindowTemplate	gWindowTemplate, gOpenedWindowTemplate;

extern short			gTypeListLen;
extern SFTypeList		gTypeList;
extern long				gAppWindowAttr;
extern OSType			gAppWindowType;
extern Boolean			gNoDefaultDocument;
extern OSErr			gGetWindowErr;

OSType				*gTypeListPtr = gTypeList;
short				gBeginUpdateNested;
TreeObjHndl			gWindowFormats;
OSErr				gDialogErr;
HideWindowProcPtr	gHideWindowProc;

static RgnHandle	gKeepUpdateRgn;
static WindowPtr	gOldPort;

RgnHandle	gCursorRgn;
	/* The current cursor region.  The initial cursor region is an empty
	** region, which will cause WaitNextEvent to generate a mouse-moved
	** event, which will cause us to set the cursor for the first time. */

static Cursor	gCursor;
CursPtr			gCursorPtr;
	/* The current cursor that applies to gCursorRgn.  These values
	** are here to shorten the re-processing time for determining the
	** correct cursor after an event.  This is specifically so that characters
	** can be typed into the TextEdit control faster.  If we spend a great
	** deal of time per-event recalculating the cursor region, text entry for
	** the TextEdit control slows down considerably.  If you want to override
	** the time savings because you are changing the cursor directly, either
	** set gCursorPtr to nil, or call DoSetCursor to set the cursor.
	** DoSetCursor simply sets gCursorPtr to nil, as well as setting
	** the cursor. */

static Rect					OldLocWindow(WindowPtr window, WindowPtr relatedWindow, Rect sizeInfo);
static PositionWndProcPtr	gOldLocProc;

static pascal void	DefaultScrollAction(ControlHandle scrollCtl, short part);
static Boolean		DefaultScroll(ControlHandle ctl, short part, EventRecord *event);



/*****************************************************************************/
/*****************************************************************************/



/* This function creates a new application window.  An application window
** contains a document which is referenced by a handle in the refCon field. */

#pragma segment Window
OSErr	DoNewWindow(FileRecHndl frHndl, WindowPtr *retWindow, WindowPtr relatedWindow, WindowPtr behind)
{
	WindowPtr			oldPort, window;
	FileRecHndl			ffrHndl;
	ControlHandle		ctl;
	Rect				ctlRect, contRect, userState, sizeInfo, rct, rct2, msrct, oldPlaceRct;
	short				h, v, hDocSize, vDocSize;
	long				wkind, wwkind, attributes;
	OSErr				err;
	PositionWndProcPtr	proc;
	GDHandle			device;
	PixMapHandle		pmap;

	if (!frHndl) return(noErr);
	attributes = (*frHndl)->fileState.attributes;

	err = noErr;
	GetPort(&oldPort);

	proc = (*frHndl)->fileState.getDocWindow;

	if (attributes & kwStaggerWindow) proc = StaggerWindow;
	if (attributes & kwCenterWindow)  proc = CenterWindow;

	gOldLocProc = proc;
	if (attributes & kwOpenAtOldLoc)  proc = OldLocWindow;			/* Try to open window at old location. */

	SetRect(&sizeInfo, 0, 0, 0, 0);
	if ((proc == StaggerWindow) || (proc == OldLocWindow)) {
		if (hDocSize = (*frHndl)->d.doc.fhInfo.hDocSize) {
			hDocSize += (*frHndl)->fileState.leftSidebar;
			if (attributes & kwHScroll) hDocSize += 15;
		}
		if (vDocSize = (*frHndl)->d.doc.fhInfo.vDocSize) {
			vDocSize += (*frHndl)->fileState.topSidebar;
			if (attributes & kwVScroll) vDocSize += 15;
		}
		SetRect(&sizeInfo, hDocSize, vDocSize, hDocSize, vDocSize);
	}

	wkind = (attributes & (kwIsPalette | kwIsModalDialog));
	if (behind) {
		for (;;) {
			if (!(behind = GetNextWindow(behind, 0))) break;
				/* break if behind all windows.  behind is nil, so that's what we have. */
			if (!((WindowPeek)behind)->visible) continue;
			ffrHndl = (FileRecHndl)GetWRefCon(behind);
			wwkind  = ((*ffrHndl)->fileState.attributes & (kwIsPalette | kwIsModalDialog));
			if (wkind >= wwkind) {
				for (;;) {
					behind = GetPreviousWindow(behind);
					if (behind == (WindowPtr)-1)       break;
					if (((WindowPeek)behind)->visible) break;
				}
				break;
			}
		}
	}

	oldPlaceRct = SetWindowPlacementRect(nil);
	if (EmptyRect(&oldPlaceRct)) {

		if (attributes & kwSameMonitor)
			for (relatedWindow = nil; relatedWindow = GetNextWindow(relatedWindow, (*frHndl)->fileState.sfType);)
				if (((WindowPeek)relatedWindow)->visible) break;

		if ((!(attributes & kwSameMonitor)) || (!relatedWindow)) {
			if (attributes & (kwColorMonitor | kwSecondaryMonitor)) {
	
				if (gQDVersion > kQDOriginal) {
					rct = msrct = GetMainScreenRect();
					for (device = GetDeviceList(); device; device = GetNextDevice(device)) {
						rct2 = (*device)->gdRect;
						if (TestDeviceAttribute(device, screenDevice) &&
							TestDeviceAttribute(device, screenActive)
						) {
							pmap = (*device)->gdPMap;
							if (attributes & kwColorMonitor) {
								if ((*pmap)->pixelSize > 1) {
									rct = rct2;
									if (!(rct.top | rct.left)) break;
								}
							}
							else {
								if (!EqualRect(&rct2, &msrct)) {
									rct = rct2;
									break;
								}
							}
						}
					}
					if (EqualRect(&rct, &msrct))
						rct.top += GetMBarHeight();
					SetWindowPlacementRect(&rct);
				}
			}
		}
	}

	window = GetSomeKindOfWindow(proc, (*frHndl)->fileState.windowID, nil, false, relatedWindow,
								 behind, true, sizeInfo, (long)frHndl);

	SetWindowPlacementRect(&oldPlaceRct);

	if (window) {
		((WindowPeek)window)->windowKind = 1000;		/* ID it as an AppsToGo window. */

		SetPort(window);
		NewWindowTitle(window, nil);

		(*frHndl)->fileState.window = window;

		(*frHndl)->fileState.hArrowVal = 16;	/* Default arrow value is 16. */
		(*frHndl)->fileState.vArrowVal = 16;

		if (!(*frHndl)->d.doc.fhInfo.hDocSize) {
			h  = gOpenedWindowTemplate.boundsRect.right - gOpenedWindowTemplate.boundsRect.left;
			h -= (*frHndl)->fileState.leftSidebar;	/* Default document size is */
			if (attributes & kwVScroll)				/* content less leftSidebar */
				h -= 15;							/* value less scrollbars.   */
			(*frHndl)->d.doc.fhInfo.hDocSize = h;
		}
		if (!(*frHndl)->d.doc.fhInfo.vDocSize) {
			v  = gOpenedWindowTemplate.boundsRect.bottom - gOpenedWindowTemplate.boundsRect.top;
			v -= (*frHndl)->fileState.topSidebar;	/* We don't have to initialize the page */
			if (attributes & kwHScroll)				/* values since the scrollbars won't be */
				v -= 15;							/* active until the window is resized   */
			(*frHndl)->d.doc.fhInfo.vDocSize = v;	/* or these values are set elsewhere.   */
		}

		if (attributes & kwHScroll) {		/* Caller wants a horizontal scrollbar... */
			ctlRect = window->portRect;
			ctlRect.left += (*frHndl)->fileState.leftSidebar;
			ctlRect.left += (*frHndl)->fileState.hScrollIndent;
			--ctlRect.left;
			++ctlRect.right;
			ctlRect.top = ++ctlRect.bottom - 16;
			if (attributes & (kwHScrollLessGrow - kwHScroll +  kwGrowIcon))
				ctlRect.right -= 15;
			OffsetRect(&ctlRect, 0, -16384);
			ctl = NewControl(window, &ctlRect, "\p", true, 0, 0, 0, scrollBarProc, 0L);
			if (ctl)
				(*frHndl)->fileState.hScroll = ctl;
			else
				err = memFullErr;
		}

		if (!err) {
			if (attributes & kwVScroll) {		/* Caller wants a vertical scrollbar... */
				ctlRect = window->portRect;
				ctlRect.top += (*frHndl)->fileState.topSidebar;
				ctlRect.top += (*frHndl)->fileState.vScrollIndent;
				--ctlRect.top;
				++ctlRect.bottom;
				ctlRect.left = ++ctlRect.right - 16;
				if (attributes & (kwVScrollLessGrow - kwVScroll +  kwGrowIcon))
					ctlRect.bottom -= 15;
				OffsetRect(&ctlRect, 0, -16384);
				ctl = NewControl(window, &ctlRect, "\p", true, 0, 0, 0, scrollBarProc, 0L);
				if (ctl)
					(*frHndl)->fileState.vScroll = ctl;
				else
					err = memFullErr;
			}
		}

		if (!err) {
			err = DoInitContent(frHndl, window);
			if (!err) {
				if (!((WindowPeek)window)->visible) {
					contRect = GetWindowContentRect(window);
					if (((WindowPeek)window)->spareFlag)
						userState = mDerefWStateData(window)->userState;
							/* Cache this.  ShowWindow offscreen messes it up.  We want to keep
							** whatever it is because some other function may be tweeking stdState
							** and userState so that window position and zoom state can be saved
							** along with a document. */

					MoveWindow(window, 16384, 16384, false);
						/* When an invisible window is added, it isn't the frontmost window.
						** This causes a problem when we make it visible.  By moving it
						** offscreen, we can make it visible without the user seeing that it
						** isn't the top window. */

					if (gPrintPage) {
						ShowWindow(window);							/* Window now visible. */
						MoveWindow(window, 16384, 16384, true);		/* Window now on top.  */
					}	/* If we are printing, we want to leave the window offscreen, since we
						** don't want it seen.  We do need a visible window when printing so
						** PrintMonitor can get the document name. */

					if (!gPrintPage) {
						if (attributes & kwVisible)
							ShowHide(window, true);
						CleanSendBehind(window, behind);
						MoveWindow(window, contRect.left, contRect.top, false);
					}

					if (((WindowPeek)window)->spareFlag)
						mDerefWStateData(window)->userState = userState;
							/* The ShowWindow metrics we did cause the userState to change.  Put it
							** back the way it was before we started messing around with the window. */

					AdjustScrollBars(window);
				}
			}
		}
		if (err) {
			DisposeAnyWindow(window);
			(*frHndl)->fileState.window = window = nil;
		}
	}
	else err = gGetWindowErr;

	SetPort(oldPort);
	if (retWindow)
		*retWindow = window;

	return(err);
}



/*****************************************************************************/



/* This function updates the window title to reflect the new document name.
** The new document name is stored in the fileState portion of the document.
** This is automatically set to 'Untitled # N' for new documents, and is
** updated when a user does a save-as.  If the window that is being opened
** should have the resource name, then set the new document name to an
** empty string prior to calling DoNewWindow.  When this is called by
** DoNewWindow, the SetWTitle will be suppressed. */

#pragma segment Window
void	NewWindowTitle(WindowPtr window, StringPtr altTitle)
{
	FileRecHndl	frHndl;
	Str255		wTitle;

	if (window) {
		if (altTitle) {
			pcpy(wTitle, altTitle);
			SetWTitle(window, wTitle);
		}
		else if (frHndl = (FileRecHndl)GetWRefCon(window)) {
			pcpy(wTitle, (*frHndl)->fileState.fss.name);
			if (*wTitle)
				SetWTitle(window, wTitle);
			else {
				if ((*frHndl)->fileState.refNum == kInvalRefNum) {
					GetWTitle(window, wTitle);
					if (*wTitle > 63) *wTitle = 63;
					pcpy((*frHndl)->fileState.fss.name, wTitle);
				}
			}
		}
	}
}



/*****************************************************************************/



/* Close all the windows.  This is called prior to quitting the application.
** This function returns true if all windows were closed.  The user may decide
** to abort a save, thus stopping the closing of the windows.  If the user
** does this, false will be returned, indicating that all windows were not
** closed after all. */

#pragma segment Window
Boolean	DisposeAllWindows(void)
{
	WindowPtr	window;
	FileRecHndl	frHndl;
	long		attr;

	for (window = nil;;) {

		if (!window)
			window = FrontWindow();
		else
			window = (WindowPtr)(((WindowPeek)window)->nextWindow);

		if (!window) break;		/* All out of windows to get rid of. */

		if (!((WindowPeek)window)->visible) continue;
			/* Invisible windows shouldn't be disposed of, since the user may cancel the quit,
			** and therefore the user will want windows around.  If a "hide on close" window
			** was closed, it was simply made invisible, so these windows are still actually
			** intact.  The user will have to show them again, but they still exist. */

		if (!IsDAWindow(window)) {
			if (((WindowPeek)window)->windowKind >= 1000) {
				if (frHndl = (FileRecHndl)GetWRefCon(window)) {
					attr   = (*frHndl)->fileState.attributes;
					if (attr & kwIsPalette) continue;
						/* Closing of all of the windows may be stopped at a
						** dirty document, so don't close the palettes. */
				}
			}
		}

		if (!DisposeOneWindow(window, kQuit)) return(false);
			/* When DisposeOneWindow returns false, this means that the window
			** didn't close.  The only cause of this is if the window had a
			** document that needed saving, and the user cancelled the save.
			** If the windows succeed in getting closed, then we are
			** returned true. */

		window = nil;
			/* The close of a window may have caused other window to close, so
			** start looking at windows from the beginning of the list.  This
			** guarantees that we are always looking at valid window records. */
	}

	return(true);
}



/*****************************************************************************/



/* Closes one window.  This window may be an application window, or it may be
** a system window.  If it is an application window, it may have a document
** that needs saving. */

#pragma segment Window
Boolean	DisposeOneWindow(WindowPtr window, short saveMode)
{
	FileRecHndl	frHndl;
	long		attr;
	OSErr		err;

	if (window) {
		if (!IsDAWindow(window)) {
			/* First, if the window is an application window, try saving
			** the document.  Remember that the user may cancel the save. */

			if (((WindowPeek)window)->windowKind >= 1000) {
				if (frHndl = (FileRecHndl)GetWRefCon(window)) {

					attr = (*frHndl)->fileState.attributes;
					if (attr & kwHideOnClose) {
						if (gHideWindowProc)
							if (err = (*gHideWindowProc)(frHndl, window))
								return(false);
						HideWindow(window);
						HiliteWindows();
						WindowGoneFixup(window);
						return(true);
					}

					if (!((*frHndl)->fileState.attributes & kwRuntimeOnlyDoc)) {
						if (IsAppWindow(window)) {
							err = SaveDocument(frHndl, window, saveMode);
							if (err) {
								if (err != userCanceledErr) {
									gDialogErr = err;
									NewDocumentWindow(nil, 'ERR#', false);
								}
								return(false);
							}		/* Stop closing windows on error or user cancel. */
						}
					}

					err = DoFreeWindow(frHndl, window);
					if (err) return(false);

					DisposeDocument(frHndl);
						/* If everything is cool, dispose of the document. */
				}
			}
		}

		DisposeAnyWindow(window);
		HiliteWindows();
		WindowGoneFixup(window);
			/* Give the application a chance to do any related tasks. */
	}

	return(true);
}



/*****************************************************************************/



#pragma segment Window
WindowPtr	SetFilePort(FileRecHndl frHndl)
{
	WindowPtr	oldPort;

	GetPort(&oldPort);
	if (frHndl)
		SetPort((*frHndl)->fileState.window);
	return(oldPort);
}



/*****************************************************************************/



#pragma segment Window
void	DoResizeWindow(WindowPtr window, short oldh, short oldv)
{
	FileRecHndl		frHndl;
	WindowPtr		oldPort;
	long			attributes;
	Boolean			growIconSpace;
	Rect			portRct, rct;
	ControlHandle	hScroll, vScroll;
	RgnHandle		updateRgn;
	short			i;

	if (!window)									 return;
	if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return;

	oldPort       = SetFilePort(frHndl);
	attributes    = (*frHndl)->fileState.attributes;
	growIconSpace = (attributes & (kwGrowIcon | (kwHScrollLessGrow - kwHScroll) | (kwVScrollLessGrow - kwVScroll)));
		/* growIconSpace true if window has grow icon or a blank space for one. */

	SetOrigin(0, 0);
	portRct = window->portRect;

	if (growIconSpace) {
		rct.left = (rct.right  = oldh) - 15;
		rct.top  = (rct.bottom = oldv) - 15;
		EraseRect(&rct);
		InvalRect(&rct);
		rct = portRct;
		rct.left = rct.right  - 15;
		rct.top  = rct.bottom - 15;
		EraseRect(&rct);
	}

	SetOrigin(0, -16384);
	if (hScroll = (*frHndl)->fileState.hScroll) {
		HideControl(hScroll);
		rct = (*hScroll)->contrlRect;
		MoveControl(hScroll, rct.left, portRct.bottom - 15 - 16384);
		SizeControl(hScroll, rct.right - rct.left + (portRct.right - portRct.left - oldh), 16);
	}
	if (vScroll = (*frHndl)->fileState.vScroll) {
		HideControl(vScroll);
		rct = (*vScroll)->contrlRect;
		MoveControl(vScroll, portRct.right - 15, rct.top);
		SizeControl(vScroll, 16, rct.bottom - rct.top + (portRct.bottom - portRct.top - oldv));
	}

	if (i = (*frHndl)->fileState.hScrollIndent) {
		rct       = window->portRect;
		rct.right = --i;
		rct.top   = rct.bottom - 15;
		InvalRect(&rct);
		rct.bottom = window->portRect.top + oldv;
		rct.top    = rct.bottom - 15;
		EraseRect(&rct);
		InvalRect(&rct);
	}

	if (i = (*frHndl)->fileState.vScrollIndent) {
		rct        = window->portRect;
		rct.bottom = --i;
		rct.left   = rct.right - 15;
		InvalRect(&rct);
		rct.right  = window->portRect.left + oldh;
		rct.left   = rct.right - 15;
		EraseRect(&rct);
		InvalRect(&rct);
	}

	AdjustScrollBars(window);

	if (hScroll)
		ShowControl(hScroll);
	if (vScroll)
		ShowControl(vScroll);

	SetOrigin(0, 0);
	if (attributes & kwGrowIcon)
		DoDrawGrowIcon(window, false, false);

	BeginContent(window);
	DoResizeContent(window, oldh, oldv);
	updateRgn = NewRgn();
	CopyRgn(((WindowPeek)window)->updateRgn, updateRgn);
	EndContent(window);
	UnionRgn(updateRgn, ((WindowPeek)window)->updateRgn, ((WindowPeek)window)->updateRgn);
	DisposeRgn(updateRgn);

	SetPort(oldPort);
}



/*****************************************************************************/



/* This function returns the difference between the old window size and the new window
** size.  Pass in the old window size, and this function looks up the current size,
** gets the difference, and returns it. */

#pragma segment Window
void	GetWindowChange(WindowPtr window, short oldh, short oldv, short *dx, short *dy)
{
	*dx = (window->portRect.right  - window->portRect.left) - oldh;
	*dy = (window->portRect.bottom - window->portRect.top)  - oldv;

}



/*****************************************************************************/



#pragma segment Window
void	DoUpdateSeparate(WindowPtr window, RgnHandle *contRgn, RgnHandle *frameRgn)
{
	RgnHandle	urgn, wrgn;

	*contRgn = *frameRgn = nil;
	if (!window) return;

	urgn = DoCalcFrameRgn(window);
	wrgn = NewRgn();

	DiffRgn(((WindowPeek)window)->updateRgn, urgn, wrgn);
	if (!EmptyRgn(wrgn)) {
		*contRgn = wrgn;
		wrgn = NewRgn();
	}
	SectRgn(((WindowPeek)window)->updateRgn, urgn, wrgn);

	if (!EmptyRgn(wrgn))
		*frameRgn = wrgn;
	else
		DisposeRgn(wrgn);

	DisposeRgn(urgn);
}



/*****************************************************************************/



#pragma segment Window
void	BeginContent(WindowPtr window)
{
	RgnHandle	updateRgn, frameRgn;
	Point		contOrg;

	if (!gBeginUpdateNested++) {
		GetPort(&gOldPort);
		CopyRgn(updateRgn = ((WindowPeek)window)->updateRgn, gKeepUpdateRgn = NewRgn());
		frameRgn = DoCalcFrameRgn(window);
		DiffRgn(((WindowPeek)window)->contRgn, frameRgn, updateRgn);
		DisposeRgn(frameRgn);
		BeginUpdate(window);
	}
	SetPort(window);
	GetContentOrigin(window, &contOrg);
	SetOrigin(contOrg.h, contOrg.v);
}



/*****************************************************************************/



#pragma segment Window
void	EndContent(WindowPtr window)
{
	if (gBeginUpdateNested) {
		if (!--gBeginUpdateNested) {
			EndUpdate(window);
			if (gKeepUpdateRgn) {
				UnionRgn(gKeepUpdateRgn, ((WindowPeek)window)->updateRgn, ((WindowPeek)window)->updateRgn);
				DisposeRgn(gKeepUpdateRgn);
				SetPort(gOldPort);
				gKeepUpdateRgn = nil;
			}
		}
	}
}



/*****************************************************************************/



#pragma segment Window
void	BeginFrame(WindowPtr window)
{
	RgnHandle	updateRgn, frameRgn, scrollRgn;

	if (!gBeginUpdateNested++) {
		GetPort(&gOldPort);
		CopyRgn(updateRgn = ((WindowPeek)window)->updateRgn, gKeepUpdateRgn = NewRgn());
		frameRgn  = DoCalcFrameRgn(window);
		scrollRgn = DoCalcScrollRgn(window);
		DiffRgn(frameRgn, scrollRgn, frameRgn);
		DisposeRgn(scrollRgn);
		SectRgn(((WindowPeek)window)->contRgn, frameRgn, updateRgn);
		DisposeRgn(frameRgn);
		BeginUpdate(window);
	}
	SetPort(window);
	SetOrigin(-16384, 0);
}



/*****************************************************************************/



#pragma segment Window
void	EndFrame(WindowPtr window)
{
	EndContent(window);
}



/*****************************************************************************/



#pragma segment Window
void	AdjustScrollBars(WindowPtr window)
{
	FileRecHndl			frHndl;
	WindowPtr			oldPort;
	ControlHandle		hScroll, vScroll;
	Rect				portRct;
	Point				keepOrg;
	short				h, v, maxVal, val;
	DocScrollBarProc	proc;

	if (!window)									 return;
	if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return;

	oldPort = SetFilePort(frHndl);
	portRct = window->portRect;

	keepOrg.h = portRct.left;
	keepOrg.v = portRct.top;

	portRct.left += (*frHndl)->fileState.leftSidebar;
	portRct.top  += (*frHndl)->fileState.topSidebar;

	hScroll = (*frHndl)->fileState.hScroll;
	vScroll = (*frHndl)->fileState.vScroll;

	SetOrigin(0, -16384);

	if ((maxVal = (*frHndl)->d.doc.fhInfo.hDocSize) > 0) {
		h = portRct.right - portRct.left;
		if (vScroll)
			h -= 15;
		maxVal -= h;
		if (maxVal < 0)
			maxVal = 0;
		if (hScroll) {
			proc = (DocScrollBarProc)GetCRefCon(hScroll);
			if (proc)
				(*proc)(frHndl, hScroll, kscrollHAdjust, h);
			else {
				if (maxVal < (val = GetCtlValue(hScroll)))
					maxVal = val;
				if ((*hScroll)->contrlMax != maxVal) {
					(*hScroll)->contrlMax = maxVal;
					DoDraw1Control(hScroll, true);
				}
				h -= (val = (*frHndl)->fileState.hArrowVal);
				if (h < val)
					h = val;
				(*frHndl)->fileState.hPageVal = h;
			}
		}
	}

	if ((maxVal = (*frHndl)->d.doc.fhInfo.vDocSize) > 0) {
		v = portRct.bottom - portRct.top;
		if (hScroll)
			v -= 15;
		maxVal -= v;
		if (maxVal < 0)
			maxVal = 0;
		if (vScroll) {
			proc = (DocScrollBarProc)GetCRefCon(vScroll);
			if (proc)
				(*proc)(frHndl, vScroll, kscrollVAdjust, v);
			else {
				if (maxVal < (val = GetCtlValue(vScroll)))
					maxVal = val;
				if ((*vScroll)->contrlMax != maxVal) {
					(*vScroll)->contrlMax = maxVal;
					DoDraw1Control(vScroll, true);
				}
				v -= (val = (*frHndl)->fileState.vArrowVal);
				if (v < val)
					v = val;
				(*frHndl)->fileState.vPageVal = v;
			}
		}
	}

	SetOrigin(keepOrg.h, keepOrg.v);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Window
void	GetContentOrigin(WindowPtr window, Point *contOrg)
{
	FileRecHndl			frHndl;
	ControlHandle		ctl;
	DocScrollBarProc	proc;

	contOrg->h = contOrg->v = 0;

	if (window) {
		if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return;
		if (ctl = (*frHndl)->fileState.hScroll) {
			contOrg->h = GetCtlValue(ctl);
			if (proc = (DocScrollBarProc)GetCRefCon(ctl))
				contOrg->h = (*proc)(frHndl, ctl, kscrollGetHOrigin, 0);
		}
		if (ctl = (*frHndl)->fileState.vScroll) {
			contOrg->v = GetCtlValue(ctl);
			if (proc = (DocScrollBarProc)GetCRefCon(ctl))
				contOrg->v = (*proc)(frHndl, ctl, kscrollGetVOrigin, 0);
		}
		contOrg->h -= (*frHndl)->fileState.leftSidebar;
		contOrg->v -= (*frHndl)->fileState.topSidebar;
	}
}



/*****************************************************************************/



#pragma segment Window
void	SetContentOrigin(WindowPtr window, long newh, long newv)
{
	FileRecHndl		frHndl;
	WindowPtr		oldPort;
	ControlHandle	hScroll, vScroll;
	short			topSide, leftSide, max, dh, dv;
	Point			old, contOrg;
	RgnHandle		updateRgn;
	Rect			contRct;

	if (!window)									 return;
	if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return;

	oldPort = SetFilePort(frHndl);
	hScroll = (*frHndl)->fileState.hScroll;
	vScroll = (*frHndl)->fileState.vScroll;
	GetContentOrigin(window, &old);
	GetContentRect(window, &contRct);

	SetOrigin(0, -16384);
	topSide  = (*frHndl)->fileState.topSidebar;
	leftSide = (*frHndl)->fileState.leftSidebar;

	if (!hScroll)
		newh = kwNoChange;
	if (newh != kwNoChange) {
		if (newh != kwBotScroll)
			newh += leftSide;
		if (newh < 0)
			newh = 0;
		if (newh > (max = GetCtlMax(hScroll)))
			newh = max;
		if ((*hScroll)->contrlValue != newh) {
			(*hScroll)->contrlValue = newh;
			DoDraw1Control(hScroll, true);
		}
		newh -= leftSide;
	}

	if (!vScroll)
		newv = kwNoChange;
	if (newv != kwNoChange) {
		if (newv != kwBotScroll)
			newv += topSide;
		if (newv < 0)
			newv = 0;
		if (newv > (max = GetCtlMax(vScroll)))
			newv = max;
		if ((*vScroll)->contrlValue != newv) {
			(*vScroll)->contrlValue = newv;
			DoDraw1Control(vScroll, true);
		}
		newv -= topSide;
	}

	AdjustScrollBars(window);

	dh = dv = 0;
	if (newh != kwNoChange)
		dh = old.h - newh;
	if (newv != kwNoChange)
		dv = old.v - newv;

	BeginContent(window);
	ScrollRect(&(window->portRect), dh, dv, updateRgn = NewRgn());
	EndContent(window);

	OffsetRgn(((WindowPeek)window)->updateRgn, dh, dv);
		/* We want to add the scrolled-in area into the updateRgn.  We
		** also want to keep the old area.  The old update area is
		** no longer mapped to the same location, due to the scroll,
		** so offset it by the amount scrolled.  Once it is offset, we
		** can add our new update portion to the updateRgn. */

	GetContentOrigin(window, &contOrg);
	SetOrigin(contOrg.h, contOrg.v);
	InvalRgn(updateRgn);
	DisposeRgn(updateRgn);

	SetOrigin(old.h, old.v);
	SetPort(oldPort);				/* Put things back the way we found them. */

	DoScrollFrame(window, dh, dv);	/* There may be changes in the frame due to scrolling. */

	DoSetCursor(nil);				/* Cursor region may be invalid due to
									** content being scrolled.  Force it to
									** be recalculated. */
}



/*****************************************************************************/



#pragma segment Window
void	GetContentRect(WindowPtr window, Rect *contRct)
{
	FileRecHndl		frHndl;
	ControlHandle	ctl;

	SetRect(contRct, 0, 0, 0, 0);

	if (window) {
		if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return;
		*contRct = window->portRect;
		if (ctl = (*frHndl)->fileState.hScroll)
			contRct->bottom -= 15;
		if (ctl = (*frHndl)->fileState.vScroll)
			contRct->right  -= 15;
		contRct->top  += (*frHndl)->fileState.topSidebar;
		contRct->left += (*frHndl)->fileState.leftSidebar;
	}
}



/*****************************************************************************/



#pragma segment Window
void	SetDocSize(FileRecHndl frHndl, long hSize, long vSize)
{
	if (frHndl) {
		if (hSize >= 0)
			(*frHndl)->d.doc.fhInfo.hDocSize = hSize;
		if (vSize >= 0)
			(*frHndl)->d.doc.fhInfo.vDocSize = vSize;
		AdjustScrollBars((*frHndl)->fileState.window);
	}
}



/*****************************************************************************/



#pragma segment Window
void	SetSidebarSize(FileRecHndl frHndl, short newLeft, short newTop)
{
	WindowPtr			oldPort, window;
	Rect				portRct, rct;
	Point				contOrg;
	short				oldLeft, oldTop, dh, dv;
	ControlHandle		ctl;
	RgnHandle			updateRgn;
	DrawFrameProcPtr	proc;

	if (window = (*frHndl)->fileState.window) {
		oldPort = SetFilePort(frHndl);
		portRct = window->portRect;
		SetOrigin(0, -16384);		/* Prepare to modify (redraw) document scrollbars. */
	}

	oldLeft = (*frHndl)->fileState.leftSidebar;
	oldTop  = (*frHndl)->fileState.topSidebar;

	dh = 0;
	if (newLeft != kwNoChange) {
		if (ctl = (*frHndl)->fileState.hScroll) {
			HideControl(ctl);
			rct = (*ctl)->contrlRect;
			rct.left += (newLeft - oldLeft);
			MoveControl(ctl, rct.left, rct.top);
			SizeControl(ctl, rct.right - rct.left, 16);
			ShowControl(ctl);
		}
		dh = newLeft - oldLeft;
	}

	dv = 0;
	if (newTop != kwNoChange) {
		if (ctl = (*frHndl)->fileState.vScroll) {
			HideControl(ctl);
			rct = (*ctl)->contrlRect;
			rct.top += (newTop - oldTop);
			MoveControl(ctl, rct.left, rct.top);
			SizeControl(ctl, 16, rct.bottom - rct.top);
			ShowControl(ctl);
		}
		dv = newTop - oldTop;
	}

	if (dh < 0)
		(*frHndl)->fileState.leftSidebar = newLeft;
	if (dv < 0)
		(*frHndl)->fileState.topSidebar  = newTop;

	if (window) {
		BeginContent(window);
		ScrollRect(&(window->portRect), dh, dv, updateRgn = NewRgn());
		EndContent(window);
	}

	if (dh)
		(*frHndl)->fileState.leftSidebar = newLeft;
	if (dv)
		(*frHndl)->fileState.topSidebar  = newTop;

	if (window) {
		AdjustScrollBars(window);

		if (proc = (*frHndl)->fileState.drawFrameProc) {
			SetOrigin(-16384, 0);
			(*proc)(frHndl, window, false);		/* Draw the application's portion of the frame. */
		}

		OffsetRgn(((WindowPeek)window)->updateRgn, dh, dv);
			/* We want to add the scrolled-in area into the updateRgn.  We
			** also want to keep the old area.  The old update area is
			** no longer mapped to the same location, due to the scroll,
			** so offset it by the amount scrolled.  Once it is offset, we
			** can add our new update portion to the updateRgn. */
		GetContentOrigin(window, &contOrg);
		SetOrigin(contOrg.h, contOrg.v);
		InvalRgn(updateRgn);
		DisposeRgn(updateRgn);

		SetOrigin(portRct.left, portRct.top);
		SetPort(oldPort);

		DoScrollFrame(window, dh, dv);		/* There may be changes in the frame due to scrolling. */
	}
}



/*****************************************************************************/



#pragma segment Window
void	SetScrollIndentSize(FileRecHndl frHndl, short newh, short newv)
{
	WindowPtr			oldPort, window;
	Rect				portRct, rct;
	short				oldh, oldv;
	ControlHandle		ctl;
	DrawFrameProcPtr	proc;

	oldPort = SetFilePort(frHndl);
	GetPort(&window);
	portRct = window->portRect;
	SetOrigin(0, -16384);

	oldh = (*frHndl)->fileState.hScrollIndent;
	oldv = (*frHndl)->fileState.vScrollIndent;

	if (newh != kwNoChange) {
		if (ctl = (*frHndl)->fileState.hScroll) {
			HideControl(ctl);
			rct = (*ctl)->contrlRect;
			rct.left += (newh - oldh);
			MoveControl(ctl, rct.left, rct.top);
			SizeControl(ctl, rct.right - rct.left, 16);
			ShowControl(ctl);
		}
		(*frHndl)->fileState.hScrollIndent = newh;
	}

	if (newv != kwNoChange) {
		if (ctl = (*frHndl)->fileState.vScroll) {
			HideControl(ctl);
			rct = (*ctl)->contrlRect;
			rct.top += (newv - oldv);
			MoveControl(ctl, rct.left, rct.top);
			SizeControl(ctl, 16, rct.bottom - rct.top);
			ShowControl(ctl);
		}
		(*frHndl)->fileState.vScrollIndent = newv;
	}

	if (proc = (*frHndl)->fileState.drawFrameProc) {
		SetOrigin(-16384, 0);
		(*proc)(frHndl, window, false);		/* Draw the application's portion of the frame. */
	}

	SetOrigin(portRct.left, portRct.top);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Window
FileRecHndl	GetNextDocument(WindowPtr window, OSType sftype)
{
	if (!(window = GetNextWindow(window, sftype))) return(nil);
	return((FileRecHndl)GetWRefCon(window));
}



/*****************************************************************************/



#pragma segment Window
WindowPtr	GetNextWindow(WindowPtr window, OSType sftype)
{
	WindowPeek	wpeek;
	FileRecHndl	frHndl;

	if (window == (WindowPtr)-1)
		window = nil;

	if (!window)
		wpeek = LMGetWindowList();
	else
		wpeek = ((WindowPeek)window)->nextWindow;

	for (; wpeek; wpeek = wpeek->nextWindow) {

		if (wpeek->windowKind < 1000) continue;

		if (!sftype) break;
			/* Request is for any window.  We have a window, so break. */

		if (!(frHndl = (FileRecHndl)GetWRefCon((WindowPtr)wpeek))) continue;		/* Doesn't match request, so try next window. */

		if ((*frHndl)->fileState.sfType == sftype) break;		/* Bingo. */
			/* The sfType field is the first 4 bytes in the refcon handle.  If you don't
			** want to use the application framework completely, but you still want this
			** function, then all you have to do is place an identifier in the first 4
			** bytes of the refcon handle. */
	}

	return((WindowPtr)wpeek);
}



/*****************************************************************************/



#pragma segment Window
WindowPtr	GetPreviousWindow(WindowPtr window)
{
	WindowPeek	wpeek;
	WindowPtr	lastWindow;

	if (window == (WindowPtr)-1) return((WindowPtr)-1);
	wpeek = LMGetWindowList();

	for (lastWindow = (WindowPtr)-1; wpeek; wpeek = wpeek->nextWindow) {
		if (window == (WindowPtr)wpeek) break;
		lastWindow = (WindowPtr)wpeek;
	}

	return(lastWindow);
}



/*****************************************************************************/



#pragma segment Window
void	DoZoomWindow(WindowPtr window, EventRecord *event, short zoomDir)
{
	Boolean		doit;
	Rect		old;
	FileRecHndl	frHndl;
	short		hDocSize, vDocSize;

	if (!window)									 return;
	if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return;

	doit = true;
	if (event)
		doit = TrackBox(window, event->where, zoomDir);

	if (doit) {
		old       = GetWindowContentRect(window);
		hDocSize  = (*frHndl)->d.doc.fhInfo.hDocSize;
		hDocSize += (*frHndl)->fileState.leftSidebar;
		if ((*frHndl)->fileState.vScroll)
			hDocSize += 15;
		vDocSize  = (*frHndl)->d.doc.fhInfo.vDocSize;
		vDocSize += (*frHndl)->fileState.topSidebar;
		if ((*frHndl)->fileState.hScroll)
			vDocSize += 15;

		if (hDocSize < (*frHndl)->fileState.windowSizeBounds.left)
			hDocSize = (*frHndl)->fileState.windowSizeBounds.left;
		if (vDocSize < (*frHndl)->fileState.windowSizeBounds.top)
			vDocSize = (*frHndl)->fileState.windowSizeBounds.top;

		ZoomToWindowDevice(window, hDocSize, vDocSize, zoomDir, false);
		DoResizeWindow(window, old.right - old.left, old.bottom - old.top);
	}
}



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Window
RgnHandle	DoCalcFrameRgn(WindowPtr window)
{
	FileRecHndl			frHndl;
	WindowPtr			oldPort;
	RgnHandle			urgn, wrgn;
	short				i;
	Rect				rct;
	Point				l2g;
	CalcFrameRgnProcPtr	proc;

	urgn = NewRgn();
	if (!window)									 return(urgn);
	if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return(urgn);

	oldPort = SetFilePort(frHndl);
	SetOrigin(0, 0);

	if (proc = (*frHndl)->fileState.calcFrameRgnProc)
		(*proc)(frHndl, window, urgn);

	wrgn = NewRgn();
	for (i = 0; i < 2; ++i) {
		rct = window->portRect;
		if (i)
			rct.bottom = (*frHndl)->fileState.topSidebar;
		else
			rct.right  = (*frHndl)->fileState.leftSidebar;
		RectRgn(wrgn, &rct);
		UnionRgn(urgn, wrgn, urgn);
	}
	DisposeRgn(wrgn);

	l2g.h = l2g.v = 0;
	LocalToGlobal(&l2g);
	OffsetRgn(urgn, l2g.h, l2g.v);

	wrgn = DoCalcScrollRgn(window);
	UnionRgn(urgn, wrgn, urgn);
	DisposeRgn(wrgn);

	SetPort(oldPort);
	return(urgn);
}



/*****************************************************************************/



#pragma segment Window
RgnHandle	DoCalcScrollRgn(WindowPtr window)
{
	FileRecHndl			frHndl;
	WindowPtr			oldPort;
	RgnHandle			urgn, wrgn;
	short				i;
	long				attributes;
	Boolean				growIconSpace;
	Rect				rct;
	Point				l2g;
	ControlHandle		ctl;

	urgn = NewRgn();
	if (!window) return(urgn);
	if (!window)									 return(urgn);
	if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return(urgn);

	oldPort = SetFilePort(frHndl);
	SetOrigin(0, 0);

	attributes    = (*frHndl)->fileState.attributes;
	growIconSpace = (attributes & (kwGrowIcon | (kwHScrollLessGrow - kwHScroll) | (kwVScrollLessGrow - kwVScroll)));
		/* growIconSpace true if window has grow icon or a blank space for one. */

	wrgn = NewRgn();
	if (growIconSpace) {
		rct = window->portRect;
		rct.left = rct.right  - 15;
		rct.top  = rct.bottom - 15;
		RectRgn(wrgn, &rct);
		UnionRgn(urgn, wrgn, urgn);
	}
	for (i = 0; i < 2; ++i) {
		ctl = (i) ? (*frHndl)->fileState.vScroll : (*frHndl)->fileState.hScroll;
		if (ctl) {
			rct = (*ctl)->contrlRect;
			if (i)
				rct.top  -= (*frHndl)->fileState.vScrollIndent;
			else
				rct.left -= (*frHndl)->fileState.hScrollIndent;
			OffsetRect(&rct, 0, 16384);
			RectRgn(wrgn, &rct);
			UnionRgn(urgn, wrgn, urgn);
		}
	}
	DisposeRgn(wrgn);

	l2g.h = l2g.v = 0;
	LocalToGlobal(&l2g);
	OffsetRgn(urgn, l2g.h, l2g.v);

	SetPort(oldPort);
	return(urgn);
}



/*****************************************************************************/



#pragma segment Window
void	DoContentClick(WindowPtr window, EventRecord *event, Boolean firstClick)
{
	FileRecHndl			frHndl;
	ContentClickProcPtr	proc;

	if (!IsDAWindow(window))
		if (frHndl = (FileRecHndl)GetWRefCon(window))
			if (proc = (*frHndl)->fileState.contentClickProc)
				(*proc)(window, event, firstClick);
}



/*****************************************************************************/



#pragma segment Window
void	DoDragWindow(WindowPtr window, EventRecord *event, Rect bounds)
{
	WindowPtr	oldPort, fwindow;
	GrafPort	bigPort;
	WindowPeek	wpeek;
	FileRecHndl	frHndl;
	RgnHandle	dragRgn;
	Point		offset, windOrg;
	long		wkind;

	if (!StillDown()) return;

	GetPort(&oldPort);

	OpenPort(&bigPort);
	CopyRgn(GetGrayRgn(), bigPort.visRgn);
	bigPort.portRect = (*bigPort.visRgn)->rgnBBox;

	if (gSystemVersion >= 0x0700) {
		HMGetBalloonWindow(&fwindow);
		if (fwindow)
			DiffRgn(bigPort.visRgn, ((WindowPeek)fwindow)->strucRgn, bigPort.visRgn);
	}

	fwindow = (WindowPtr)-1;
	if (!IsDAWindow(window)) {
		if (!(frHndl = (FileRecHndl)GetWRefCon(window))) return;
		wkind   = (*frHndl)->fileState.attributes & (kwIsPalette | kwIsModalDialog);
		fwindow = FrontWindowOfType(wkind, true);
		for (wpeek = (WindowPeek)FrontWindow(); wpeek; wpeek = wpeek->nextWindow) {
			if (fwindow == (WindowPtr)wpeek) break;
			DiffRgn(bigPort.visRgn, wpeek->strucRgn, bigPort.visRgn);
		}
	}

	CopyRgn(((WindowPeek)window)->strucRgn, dragRgn = NewRgn());
	*(long *)&offset = DragGrayRgn(dragRgn, event->where, &bounds, &bounds, noConstraint, nil);

	DisposeRgn(dragRgn);
	ClosePort(&bigPort);

	if ((offset.h != (short)0x8000) || (offset.v != (short)0x8000)) {
		windOrg.h = window->portRect.left;
		windOrg.v = window->portRect.top;
		SetPort(window);
		LocalToGlobal(&windOrg);
		MoveWindow(window, windOrg.h + offset.h, windOrg.v + offset.v, false);
	}

	SetPort(oldPort);

	if (!(event->modifiers & cmdKey))
		CleanSendInFront(window, fwindow);
}



/*****************************************************************************/



#pragma segment Window
void	DoDrawFrame(WindowPtr window, Boolean activate)
{
	FileRecHndl			frHndl;
	WindowPtr			oldPort;
	Rect				worg;
	long				attributes;
	DrawFrameProcPtr	proc;

	if (window) {
		if (frHndl = (FileRecHndl)GetWRefCon(window)) {
			oldPort = SetFilePort(frHndl);
			worg    = window->portRect;
			SetOrigin(0, 0);
	
			attributes = (*frHndl)->fileState.attributes;
			if (attributes & kwGrowIcon)
				DoDrawGrowIcon(window, false, false);
	
			SetOrigin(0, -16384);
			DoDrawControls(window, true);
			SetOrigin(-16384, 0);
			if (proc = (*frHndl)->fileState.drawFrameProc)
				(*proc)(frHndl, window, activate);
	
			SetOrigin(worg.left, worg.top);
			SetPort(oldPort);
		}
	}
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoFreeDocument(FileRecHndl frHndl)
{
	FreeDocumentProcPtr	proc;
	OSErr				err;

	err = noErr;
	if (proc = (*frHndl)->fileState.freeDocumentProc)
		err = (*proc)(frHndl);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoFreeWindow(FileRecHndl frHndl, WindowPtr window)
{
	FreeWindowProcPtr	proc;
	OSErr				err;

	err = noErr;
	if (proc = (*frHndl)->fileState.freeWindowProc)
		err = (*proc)(frHndl, window);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoImageDocument(FileRecHndl frHndl)
{
	ImageProcPtr	proc;
	OSErr			err;

	err = noErr;
	if (proc = (*frHndl)->fileState.imageProc)
		err = (*proc)(frHndl);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoInitContent(FileRecHndl frHndl, WindowPtr window)
{
	InitContentProcPtr	proc;
	OSErr				err;

	err = noErr;
	if (proc = (*frHndl)->fileState.initContentProc)
		err = (*proc)(frHndl, window);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
Boolean	DoKeyDown(EventRecord *event)
{
	char				key;
	WindowPtr			window, fwindow;
	FileRecHndl			frHndl;
	ContentKeyProcPtr	proc;
	Boolean				passThrough;
	short				menuID, menuItem, menuItem2, charsUsed;
	long				menuVal, attr, wkind;
	Str32				str;
	OSType				sftype;
	OSErr				err;
	DoMenuItemProcPtr	mproc, mp;

	key = event->message & charCodeMask;
	if (event->modifiers & cmdKey) {		/* If command key down... */
		if (event->what == keyDown) {
			DoAdjustMenus();				/* Prepare menus properly. */
			menuVal   = MenuKey(key);
			menuID    = HiWord(menuVal);
			menuItem  = LoWord(menuVal);
			menuItem2 = MapMItem(menuID, menuItem);
			if (menuID) {
				mproc = DoMenuItem;
				if (IsAppWindow(window = FrontWindow()))
					if (mp = (*(FileRecHndl)GetWRefCon(window))->fileState.doMenuItemProc)
						mproc = mp;
				if (!(*mproc)(window, menuID, menuItem2)) {
					GetIndString(str, menuID, menuItem);
					if (str[0]) {
						p2dec(str, &charsUsed);
						if (str[0] > charsUsed + 2) {
							if (str[charsUsed + 2] == '\'') {
								BlockMove(str + charsUsed + 3, (Ptr)&sftype, sizeof(OSType));
								if (window = GetNextWindow(nil, sftype)) {
									frHndl = (FileRecHndl)GetWRefCon(window);
									attr   = (*frHndl)->fileState.attributes;
									if (attr & kwHideOnClose) {
										if (!((WindowPeek)window)->visible)
											ShowHide(window, true);
										wkind = (attr & (kwIsPalette | kwIsModalDialog));
										if (!(fwindow = FrontWindowOfType(wkind, false)))
											fwindow = (WindowPtr)-1;
										CleanSendInFront(window, fwindow);
									}
									else window = nil;
								}
								if (!window) {
									err = NewDocumentWindow(&frHndl, sftype, true);
									if (!err) {
										if (frHndl) {
											window = (*frHndl)->fileState.window;
											if (!((WindowPeek)window)->visible)
												ShowHide(window, true);
											wkind = (attr & (kwIsPalette | kwIsModalDialog));
											if (!(fwindow = FrontWindowOfType(wkind, false)))
												fwindow = (WindowPtr)-1;
											CleanSendInFront(window, fwindow);
										}
									}
									else {
										gDialogErr = err;
										NewDocumentWindow(nil, 'ERR#', false);
									}
								}
							}
						}
					}
				}
				HiliteMenu(0);		/* Unhighlight what MenuKey hilited. */
				DoSetCursor(nil);
				return(false);
			}
		}
		else return(false);
	}

	for (window = nil; window = GetNextWindow(window, 0);) {
		if (!((WindowPeek)window)->visible) continue;
		if (((WindowPeek)window)->windowKind >= 1000) {
			if (frHndl = (FileRecHndl)GetWRefCon(window)) {
				if (proc = (*frHndl)->fileState.contentKeyProc) {
					passThrough = false;
					if ((*proc)(window, event, &passThrough)) return(true);
					if (!passThrough) break;
				}
			}
		}
	}

	return(false);
}



/*****************************************************************************/



#pragma segment Window
void	DoMouseDown(EventRecord *event)
{
	WindowPtr			window, fwindow, dlog;
	FileRecHndl			frHndl;
	Rect				contentRct, old, growLimits, tearRect;
	Point				pt;
	short				part, menuID, menuItem, menuItem2, charsUsed;
	long				menuVal, size, wkind, attr;
	Str63				str;
	OSType				sftype;
	OSErr				err;
	DoMenuItemProcPtr	mproc, mp;

	gCursorPtr = nil;
		/* No shortcuts when we recalculate the cursor region. */

	part = FindWindow(event->where, &window);

	frHndl = nil;
	if (window)
		if (((WindowPeek)window)->windowKind >= 1000)
			frHndl = (FileRecHndl)GetWRefCon(window);

	if (part != inContent)
		DoSetCursor(&qd.arrow);

	dlog = FrontWindowOfType(kwIsModalDialog, true);
	if ((dlog) && (window != dlog)) {
		if (part != inMenuBar) {
			SysBeep(1);
			return;
		}
	}

	switch(part) {

		case inContent:

			if (!IsAppWindow(window)) {
				if (window != FrontWindow()) {
					SelectWindow(window);
					HiliteWindows();
				}
				break;
			}

			wkind   = (*frHndl)->fileState.attributes & (kwIsPalette | kwIsModalDialog);
			fwindow = FrontWindowOfType(wkind, true);
				/* fwindow guaranteed, since worst case we find ourself. */

			if (window == fwindow) {
				DoContentClick(window, event, false);
				break;
			}		/* The window is the frontmost of this type, so handle the click. */

			CleanSendInFront(window, fwindow);

			if ((*frHndl)->fileState.attributes & kwDoFirstClick) {
				DoUpdate(window);
				contentRct = GetWindowContentRect(window);
				if (PtInRect(event->where, &contentRct))
					DoContentClick(window, event, true);
			}
			break;

		case inDrag:
			DoDragWindow(window, event, qd.screenBits.bounds);
			break;		/* Pass screenBits.bounds to get all gDevices. */

		case inGoAway:
			if (TrackGoAway(window, event->where))
				DisposeOneWindow(window, kClose);
			break;

		case inGrow:
			old = GetWindowContentRect(window);
			growLimits = (*frHndl)->fileState.windowSizeBounds;
			++growLimits.right;
			++growLimits.bottom;
			if (size = GrowWindow(window, event->where, &growLimits)) {
				pt = *(Point *)&size;
				SizeWindow(window, pt.h, pt.v, true);
				DoResizeWindow(window, old.right - old.left, old.bottom - old.top);
			}
			break;

		case inMenuBar:		/* Process mouse menu command (if any). */
			DoAdjustMenus();
			DoSetCursor(&qd.arrow);
			menuVal  = MenuSelect(event->where);
			menuID   = HiWord(menuVal);
			menuItem = LoWord(menuVal);
			if (menuItem == -1)
				menuItem = CountMItems(GetMHandle(menuID));
			menuItem2 = MapMItem(menuID, menuItem);
			mproc = DoMenuItem;
			if (IsAppWindow(window = FrontWindow()))
				if (mp = (*(FileRecHndl)GetWRefCon(window))->fileState.doMenuItemProc)
					mproc = mp;
			if (!(*mproc)(window, menuID, menuItem2)) {
				GetIndString(str, menuID, menuItem);
				if (str[0]) {
					p2dec(str, &charsUsed);
					if (str[0] > charsUsed + 2) {
						if (str[charsUsed + 2] == '\'') {
							BlockMove(str + charsUsed + 3, (Ptr)&sftype, sizeof(OSType));
							if (window = GetNextWindow(nil, sftype)) {
								frHndl = (FileRecHndl)GetWRefCon(window);
								attr   = (*frHndl)->fileState.attributes;
								if (attr & kwHideOnClose) {
									if (menuItem2 == -1) {
										GetItem(GetMHandle(menuID), menuItem, str);
										BlockMove(str + 1, &tearRect, sizeof(Rect));
										MoveWindow(window, tearRect.left, tearRect.top, false);
									}
									if (!((WindowPeek)window)->visible)
										ShowHide(window, true);
									wkind = (attr & (kwIsPalette | kwIsModalDialog));
									if (!(fwindow = FrontWindowOfType(wkind, false)))
										fwindow = (WindowPtr)-1;
									CleanSendInFront(window, fwindow);
								}
								else window = nil;
							}
							if (!window) {
								err = NewDocumentWindow(&frHndl, sftype, true);
								if (!err) {
									if (frHndl) {
										window = (*frHndl)->fileState.window;
										attr   = (*frHndl)->fileState.attributes;
										if (!((WindowPeek)window)->visible)
											ShowHide(window, true);
										wkind = (attr & (kwIsPalette | kwIsModalDialog));
										if (!(fwindow = FrontWindowOfType(wkind, false)))
											fwindow = (WindowPtr)-1;
										CleanSendInFront(window, fwindow);
									}
								}
								else {
									gDialogErr = err;
									NewDocumentWindow(nil, 'ERR#', false);
								}
							}
						}
					}
				}
			}
			HiliteMenu(0);		/* Unhighlight what MenuSelect hilited. */
			break;

		case inSysWindow:	/* Let the system handle the mouseDown. */
			SystemClick(event, window);
			break;

		case inZoomIn:
		case inZoomOut:
			DoZoomWindow(window, event, part);
			break;

	}
}



/*****************************************************************************/



/* This function converts a menu item hard-id (one returned by the toolbox) to a
** soft-id (defined in the 'STR#' resource associated with the menu.  If there is
** a 'STR#' resource defined with the same id as the menu, it is assumed to be
** for the purpose of converting hard-id values to soft-id values. */

#pragma segment Window
short	MapMItem(short menuID, short menuItem)
{
	Str32	str;

	if (menuID == 128)
		return(menuItem);

	GetIndString(str, menuID, menuItem);
	if (str[0])
		menuItem = p2dec(str, nil);

	return(menuItem);
}



/*****************************************************************************/



/* This function is the logical reverse of MapMItem(). */

#pragma segment Window
short	UnmapMItem(short menuID, short menuItem)
{
	Str32	str;
	short	i, j;

	if (menuID == 128)				   return(menuItem);
	if (!Get1Resource('STR#', menuID)) return(menuItem);
		/* No such table, so don't convert it. */

	if (menuItem) {
		for (i = 1;; ++i) {
			GetIndString(str, menuID, i);
			if (!str[0]) return(32767);		/* No such entry found.  Return something invalid. */
			j = p2dec(str, nil);
			if (menuItem == j) return(i);
		}
	}
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoReadDocument(FileRecHndl frHndl)
{
	ReadDocumentProcPtr	proc;
	OSErr				err;

	err = noErr;
	if (proc = (*frHndl)->fileState.readDocumentProc)
		err = (*proc)(frHndl);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoReadDocumentHeader(FileRecHndl frHndl)
{
	ReadDocumentHeaderProcPtr	proc;
	OSErr						err;

	err = noErr;
	if ((*frHndl)->fileState.refNum)
		if (proc = (*frHndl)->fileState.readDocumentHeaderProc)
			err = (*proc)(frHndl);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DefaultReadDocumentHeader(FileRecHndl frHndl)
{
	short	refNum, vers, resAlreadyOpen, oldRes;
	OSErr	err;
	char	hstate;
	Ptr		ptr1, ptr2;
	long	count, attr;
	OSType	sftype;
	Handle	hndl;

	if (err = SetFPos(refNum = (*frHndl)->fileState.refNum, fsFromStart, 0)) return(err);

	attr   = (*frHndl)->fileState.attributes;
	sftype = (*frHndl)->fileState.sfType;

	if (attr & kwDefaultDocHeader) {
		if (sftype != MovieFileType) {
			if (attr & kwHeaderIsResource) {
				resAlreadyOpen = (*frHndl)->fileState.resRefNum;
				UseDocResFile(frHndl, &oldRes, fsRdWrPerm);
				hndl = Get1Resource('DFDH', 128);
				err  = ResError();
				if (!err)
					if (!hndl)
						err = resNotFound;
				if (!err) {
					ptr1   = (Ptr)&((*frHndl)->d.doc);
					ptr2   = (Ptr)&((*frHndl)->d.doc.fhInfo.endDocHeaderInfo);
					count  = (long)ptr2 - (long)ptr1;
					BlockMove(*hndl, ptr1, count);
				}
				if (hndl)
					ReleaseResource(hndl);
				if (!resAlreadyOpen)
					CloseDocResFile(frHndl);
				UseResFile(oldRes);
			}
			else {
				if (!err) {		/* Read header info from file. */
					hstate = HGetState((Handle)frHndl);
					HLock((Handle)frHndl);
					ptr1   = (Ptr)&((*frHndl)->d.doc);
					ptr2   = (Ptr)&((*frHndl)->d.doc.fhInfo.endDocHeaderInfo);
					count  = (long)ptr2 - (long)ptr1;
					err    = FSRead(refNum, &count, ptr1);
					HSetState((Handle)frHndl, hstate);
				}
			}
			if (!err) {
				vers = (*frHndl)->d.doc.fhInfo.version;
				if ((vers < gMinVersion) || (vers > gMaxVersion))
					err = kWrongVersion;
			}
		}
	}

	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoWriteDocument(FileRecHndl frHndl)
{
	WriteDocumentProcPtr	proc;
	OSErr					err;

	err = noErr;
	if (proc = (*frHndl)->fileState.writeDocumentProc)
		err = (*proc)(frHndl);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DoWriteDocumentHeader(FileRecHndl frHndl)
{
	WriteDocumentHeaderProcPtr	proc;
	OSErr						err;

	err = noErr;
	if ((*frHndl)->fileState.refNum)
		if (proc = (*frHndl)->fileState.writeDocumentHeaderProc)
			err = (*proc)(frHndl);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
OSErr	DefaultWriteDocumentHeader(FileRecHndl frHndl)
{
	short		refNum, resAlreadyOpen, oldRes;
	OSErr		err;
	WindowPtr	window;
	char		hstate;
	Ptr			ptr1, ptr2;
	long		count, attr;
	OSType		sftype;
	Handle		hndl;

	if (err = SetFPos(refNum = (*frHndl)->fileState.refNum, fsFromStart, 0)) return(err);

	attr   = (*frHndl)->fileState.attributes;
	sftype = (*frHndl)->fileState.sfType;

	if (attr & kwDefaultDocHeader) {
		if (sftype != MovieFileType) {
			if (window = (*frHndl)->fileState.window) {
				if (!(*frHndl)->fileState.readOnly) {
					(*frHndl)->d.doc.fhInfo.structureRect = GetWindowStructureRect(window);
					(*frHndl)->d.doc.fhInfo.contentRect   = GetWindowContentRect(window);
					(*frHndl)->d.doc.fhInfo.stdState      = mDerefWStateData(window)->stdState;
					if (((WindowPeek)window)->spareFlag)
						(*frHndl)->d.doc.fhInfo.userState = mDerefWStateData(window)->userState;
				}
			}
			else SetRect(&(*frHndl)->d.doc.fhInfo.structureRect, 0, 0, 0, 0);
			if (attr & kwHeaderIsResource) {
				resAlreadyOpen = (*frHndl)->fileState.resRefNum;
				UseDocResFile(frHndl, &oldRes, fsRdWrPerm);
				ptr1   = (Ptr)&((*frHndl)->d.doc);
				ptr2   = (Ptr)&((*frHndl)->d.doc.fhInfo.endDocHeaderInfo);
				count  = (long)ptr2 - (long)ptr1;
				if (hndl = Get1Resource('DFDH', 128)) {
					RmveResource(hndl);
					DisposeHandle(hndl);
				}
				hndl = NewHandle(count);
				if (hndl) {
					ptr1 = (Ptr)&((*frHndl)->d.doc);
					BlockMove(ptr1, *hndl, count);
					AddResource(hndl, 'DFDH', 128, nil);
					ChangedResource(hndl);
					WriteResource(hndl);
					UpdateResFile(CurResFile());
					DetachResource(hndl);
					DisposeHandle(hndl);
				}
				else err = memFullErr;
				if (!resAlreadyOpen)
					CloseDocResFile(frHndl);
				UseResFile(oldRes);
			}
			else {
				hstate = HGetState((Handle)frHndl);
				HLock((Handle)frHndl);
				ptr1   = (Ptr)&((*frHndl)->d.doc);
				ptr2   = (Ptr)&((*frHndl)->d.doc.fhInfo.endDocHeaderInfo);
				count  = (long)ptr2 - (long)ptr1;
				err    = FSWrite(refNum, &count, ptr1);
				HSetState((Handle)frHndl, hstate);
			}
		}
	}

	return(err);
}



/*****************************************************************************/



#pragma segment Window
void	DoResizeContent(WindowPtr window, short oldh, short oldv)
{
	FileRecHndl				frHndl;
	ResizeContentProcPtr	proc;

	if (IsAppWindow(window))
		if (frHndl = (FileRecHndl)GetWRefCon(window))
			if (proc = (*frHndl)->fileState.resizeContentProc)
				(*proc)(window, oldh, oldv);
}



/*****************************************************************************/



#pragma segment Window
void	DoScrollFrame(WindowPtr window, long dh, long dv)
{
	FileRecHndl			frHndl;
	ScrollFrameProcPtr	proc;

	if (IsAppWindow(window))
		if (frHndl = (FileRecHndl)GetWRefCon(window))
			if (proc = (*frHndl)->fileState.scrollFrameProc)
				(*proc)(frHndl, window, dh, dv);
}



/*****************************************************************************/



#pragma segment Window
void	DoUndoFixup(FileRecHndl frHndl, Point contOrg, Boolean afterUndo)
{
	UndoFixupProcPtr	proc;

	if (proc = (*frHndl)->fileState.undoFixupProc)
		(*proc)(frHndl, contOrg, afterUndo);
}



/*****************************************************************************/
/*****************************************************************************/



/* Open a window where it was stored at.  This would be simple, except for the
** complication that the user may be opening the document on a different Mac
** that doesn't have the same monitor configuration.  Due to this, we need to
** make sure that the window doesn't open completely out of view. */

#pragma segment Window
static Rect	OldLocWindow(WindowPtr window, WindowPtr relatedWindow, Rect sizeInfo)
{
	FileRecHndl	frHndl;
	RgnHandle	rgn;
	Rect		rct, bbox, srct, crct;
	short		dh, dv, h, v;
	long		attributes;

	frHndl     = (FileRecHndl)GetWRefCon(window);
	attributes = (*frHndl)->fileState.attributes;

	srct = (*frHndl)->d.doc.fhInfo.structureRect;
	crct = (*frHndl)->d.doc.fhInfo.contentRect;
	if (EmptyRect(&srct)) {
		if (!gOldLocProc) return(window->portRect);
		return((*gOldLocProc)(window, relatedWindow, sizeInfo));
	}

	rct = srct;
	rct.bottom = crct.top;

	RectRgn(rgn = NewRgn(), &rct);
	SectRgn(rgn, GetGrayRgn(), rgn);
	bbox = (*rgn)->rgnBBox;
	DisposeRgn(rgn);

	if (EqualRect(&rct, &bbox)) {
		rct = (*frHndl)->d.doc.fhInfo.contentRect;
		SizeWindow(window, rct.right - rct.left, rct.bottom - rct.top, false);
		MoveWindow(window, rct.left, rct.top, false);
		mDerefWStateData(window)->stdState  = (*frHndl)->d.doc.fhInfo.stdState;
		if (((WindowPeek)window)->spareFlag)
			mDerefWStateData(window)->userState = (*frHndl)->d.doc.fhInfo.userState;
		return(rct);
	}

	rct = srct;
	if (!(dh = bbox.left - rct.left))
		dh = bbox.right  - rct.right;
	if (!(dv = bbox.top  - rct.top))
		dv = bbox.bottom - rct.bottom;
	OffsetRect(&rct, dh, dv);

	RectRgn(rgn = NewRgn(), &rct);
	SectRgn(rgn, GetGrayRgn(), rgn);
	bbox = (*rgn)->rgnBBox;
	DisposeRgn(rgn);

	if (EqualRect(&rct, &bbox)) {
		h = crct.right  - crct.left;
		v = crct.bottom - crct.top;
		SetRect(&sizeInfo, h, v, h, v);
			/* Force window big as possible for this screen and data size. */
	}

	if (!gOldLocProc) return(window->portRect);
	return((*gOldLocProc)(window, relatedWindow, sizeInfo));
}



/*****************************************************************************/



#pragma segment Window
void	CleanSendBehind(WindowPtr window, WindowPtr afterWindow)
{
	WindowPtr	oldPort;
	Point		offset;
	RgnHandle	contRgn, keepContRgn, visRgn;

	if (afterWindow == (WindowPtr)-1) {
		BringToFront(window);
		HiliteWindows();
		return;
	}

	GetPort(&oldPort);
	SetPort(window);
	offset.h = offset.v = 0;
	LocalToGlobal(&offset);
	SetPort(oldPort);

	CopyRgn(contRgn = ((WindowPeek)window)->contRgn, keepContRgn = NewRgn());
	OffsetRgn(visRgn = window->visRgn, offset.h, offset.v);
	DiffRgn(contRgn, visRgn, contRgn);
	OffsetRgn(visRgn, -offset.h, -offset.v);
		/* Don't allow PaintOne to touch the part of the window already visible. */

	SendBehind(window, afterWindow);
		/* Do the SendBehind.  Since the content region is way off the
		** screen(s), no erasing of the content of the window will occur. */

	CopyRgn(keepContRgn, contRgn);
	DisposeRgn(keepContRgn);

	CalcVis((WindowPeek)window);
		/* One negative to the content region games is that the visRgn gets
		** calculated incorrectly when SendBehind() is called.  The call to
		** CalcVis() fixes this problem. */

	HiliteWindows();
}



/*****************************************************************************/



#pragma segment Window
void	CleanSendInFront(WindowPtr window, WindowPtr beforeWindow)
{
	if (beforeWindow = GetPreviousWindow(beforeWindow))
		CleanSendBehind(window, beforeWindow);
}



/*****************************************************************************/



#pragma segment Window
void	HiliteWindows(void)
{
	WindowPtr	window, ww;
	FileRecHndl	frHndl, ff;
	long		thisKind, lastKind;
	Boolean		haveModal;

	lastKind = -1;			/* No such kind. */

	haveModal = false;
	for (window = FrontWindow(); window; window = (WindowPtr)(((WindowPeek)window)->nextWindow)) {

		if (!((WindowPeek)window)->visible)          continue;
		if (((WindowPeek)window)->windowKind < 1000) continue;

		thisKind = kwIsDocument;
		if (IsAppWindow(window)) {
			frHndl   = (FileRecHndl)GetWRefCon(window);
			thisKind = (*frHndl)->fileState.attributes & (kwIsPalette | kwIsModalDialog);
		}

		if (gInBackground)
			lastKind = thisKind;
				/* If application moved to background, we want to turn all hilighting off
				** for all windows.  This is accomplished by pretending that the kind of
				** the current window is the same as the kind of the last window. */

		if (haveModal)
			lastKind = thisKind;
				/* If we have a modal dialog in front, then turn off the hilighting for
				** all the other windows. */

		if (thisKind != lastKind) {
			for (ww = window; ww = (WindowPtr)(((WindowPeek)ww)->nextWindow);) {
				if (!((WindowPeek)ww)->visible) continue;
				if (IsAppWindow(ww)) {
					ff = (FileRecHndl)GetWRefCon(ww);
					if (thisKind == ((*ff)->fileState.attributes & (kwIsPalette | kwIsModalDialog))) {
						if (thisKind == kwIsPalette) {
							if (!((WindowPeek)ww)->hilited) {
								HiliteWindow(ww, true);
								DoActivate(ww);
							}
						}
						else {
							if (((WindowPeek)ww)->hilited) {
								HiliteWindow(ww, false);
								DoActivate(ww);
							}
						}
					}
					else break;
				}
			}
			if (!((WindowPeek)window)->hilited) {
				HiliteWindow(window, true);
				DoActivate(window);
			}
			lastKind = thisKind;
		}
		else {
			if (((WindowPeek)window)->hilited) {
				HiliteWindow(window, false);
				DoActivate(window);
			}
		}

		if (thisKind == kwIsModalDialog)
			haveModal = true;
	}
}



/*****************************************************************************/



#pragma segment Window
void	UnhiliteWindows(void)
{
	WindowPtr	window;

	for (window = nil; window = GetNextWindow(window, 0);) {
		if (!((WindowPeek)window)->visible) continue;
		if (((WindowPeek)window)->windowKind <= dialogKind) continue;
		if (((WindowPeek)window)->hilited) {
			HiliteWindow(window, false);
			DoActivate(window);
		}
	}
}



/*****************************************************************************/



/* This is called when an update event is received for a window.  First, the
** updateRgn is separated into two parts.  Part 1 holds the window frame area,
** if any.  This is the area that might hold the scrollbars, grow icon, and
** any other application-specific frame parts.  This is drawn first.  Once
** this is done, the remainder of the updateRgn is drawn.  This allows us to
** handle all of the frame clipping without using the clipRgn.  By freeing up
** the clipRgn, we allow the application to use it without having to share. */

#pragma segment Window
void	DoUpdate(WindowPtr window)
{
	RgnHandle	contPart, framePart;
	Point		contOrg;
	FileRecHndl	frHndl;

	SetPort(window);

	if (IsAppWindow(window)) {

		DoUpdateSeparate(window, &contPart, &framePart);

		if (framePart) {		/* Update the document frame, if any. */
			CopyRgn(framePart, ((WindowPeek)window)->updateRgn);
			DisposeRgn(framePart);
			++gBeginUpdateNested;
			BeginUpdate(window);
			DoDrawFrame(window, false);
			if (gBeginUpdateNested) {
				EndUpdate(window);
				--gBeginUpdateNested;
			}
		}
		if (contPart) {			/* Update the rest of the content. */
			CopyRgn(contPart, ((WindowPeek)window)->updateRgn);
			DisposeRgn(contPart);
			++gBeginUpdateNested;
			BeginUpdate(window);
			GetContentOrigin(window, &contOrg);
			SetOrigin(contOrg.h, contOrg.v);
			frHndl = (FileRecHndl)GetWRefCon(window);
			DoImageDocument(frHndl);
			SetOrigin(0, 0);
			if (gBeginUpdateNested) {
				EndUpdate(window);
				--gBeginUpdateNested;
			}
		}
	}
}



/*****************************************************************************/



#pragma segment Window
void	DoSetCursor(Cursor *cursor)
{
	gCursorPtr = nil;

	if (cursor)
		SetCursor(cursor);

	if (!cursor)
		DoCursor();
}



/*****************************************************************************/



#pragma segment Window
CursPtr	DoSetResCursor(short crsrID)
{
	CursHandle	crsr;

	gCursorPtr = nil;

	crsr = GetCursor(crsrID);
	if (crsr) {
		gCursor = **crsr;
		DoSetCursor(&gCursor);
		return(&gCursor);
	}

	SetCursor(&qd.arrow);
	return(&qd.arrow);
}



/*****************************************************************************/



#pragma segment Window
void	DoWindowCursor(void)
{
	WindowPeek			wpeek;
	WindowPtr			window;
	Point				mouseLoc;
	FileRecHndl			frHndl;
	RgnHandle			srgn;
	WindowCursorProcPtr	proc;

	if (gInBackground) return;
		/* Don't change cursors if we aren't the front application. */

	if (!gCursorRgn)
		gCursorRgn = NewRgn();

	mouseLoc = GetGlobalMouse();

	if (!(wpeek = (WindowPeek)FrontWindow())) {
		WindowCursor(nil, nil, mouseLoc);
		return;
	}

	if (!IsAppWindow((WindowPtr)wpeek)) {
		SetRectRgn(gCursorRgn, kExtremeNeg, kExtremeNeg, kExtremePos, kExtremePos);
		SetCursor(gCursorPtr = &qd.arrow);
	}		/* Non-application windows get an arrow cursor. */

	if (gCursorPtr) {							/* Do we already have a cursor... */
		if (PtInRgn(mouseLoc, gCursorRgn)) {	/* Are we still in the cursor area... */
			SetCursor(gCursorPtr);				/* Then set it to that. */
			return;
		}
	}

	SetRectRgn(gCursorRgn, kExtremeNeg, kExtremeNeg, kExtremePos, kExtremePos);

	for (wpeek = (WindowPeek)FrontWindow();; wpeek = wpeek->nextWindow) {

		if (!IsAppWindow((WindowPtr)wpeek)) break;

		if (!wpeek->visible) continue;		/* No cursors for invisible windows. */

		window = (WindowPtr)wpeek;
		srgn   = wpeek->strucRgn;
		frHndl = (FileRecHndl)GetWRefCon(window);

		proc = (frHndl) ? (*frHndl)->fileState.windowCursorProc : nil;
		if (!proc) {
			if (PtInRgn(mouseLoc, srgn)) {
				SectRgn(gCursorRgn, srgn, gCursorRgn);
				SetCursor(gCursorPtr = &qd.arrow);
				return;
			}
		}
		else if ((*proc)(frHndl, window, mouseLoc)) return;

		DiffRgn(gCursorRgn, srgn, gCursorRgn);
	}

	SetCursor(gCursorPtr = &qd.arrow);
}



/*****************************************************************************/



#pragma segment Window
WindowPtr	FrontWindowOfType(long wkind, Boolean firstVis)
{
	WindowPtr	window;
	FileRecHndl	frHndl;
	long		wk;

	wkind &= (kwIsPalette | kwIsModalDialog);
	for (window = nil; window = GetNextWindow(window, 0);) {
		if (firstVis)
			if (!(((WindowPeek)window)->visible))
				continue;
		if (((WindowPeek)window)->windowKind >= 1000) {
			if (frHndl = (FileRecHndl)GetWRefCon(window)) {
				wk = (*frHndl)->fileState.attributes & (kwIsPalette | kwIsModalDialog);
				if (wk < wkind)  break;
				if (wk == wkind) return(window);
			}
		}
	}

	return(nil);
}



/*****************************************************************************/



/* This function gets an alert, and handles hiliting of windows correctly.
** The reason for this function is that there may be more than one hilited
** window due to the possibility of floating palettes.  The calls to UnhiliteWindows
** and HiliteWindows make sure that while the alert is up, there are no other
** hilited windows. */

#pragma segment Window
short	HCenteredAlert(short alertID, WindowPtr relatedWindow, ModalFilterUPP filter)
{
	short	itemHit;

	UnhiliteWindows();
	itemHit = CenteredAlert(alertID, relatedWindow, filter);
	HiliteWindows();
	return(itemHit);
}



/*****************************************************************************/
/*****************************************************************************/



/* This function gets the application window formats that were created with
** the AppsToGo application editor.  The window formats are stored in the resource
** 'WFMT' id #128.  They are first read in, and then they are unflattened
** by calling HReadWindowFormats(). */

#pragma segment Window
OSErr	GetWindowFormats(void)
{
	Handle	wfmt;
	OSErr	err;

	if (!(wfmt = GetAppResource('WFMT', 128, nil))) return(ResError());
	DetachResource(wfmt);

	err = HReadWindowFormats(wfmt);
	DisposeHandle(wfmt);

	return(err);
}



/*****************************************************************************/



/* This function is called to unflatten a window-format handle into separate
** hierarchical document objects.  The assumption is that there is only one
** of these multiple window definitions, and therefore if there is already
** one in the global gWindowFormats, it is disposed of.  This is exactly the
** behavior needed by the AppsToGo application editor. */

#pragma segment Window
OSErr	HReadWindowFormats(Handle wfmt)
{
	TreeObjHndl		wobj;
	long			attr;
	short			i, j;
	OSErr			err;
	static OSType	*lastTypeListPtr;

	err = noErr;
	NewDocument(nil, 0, 0);		/* This resets the doc.increment value. */

	if (wfmt) {
		if (gWindowFormats)
			DisposeObjAndOffspring(gWindowFormats);
		if (!(gWindowFormats = NewRootObj(WFMTOBJ, 0))) return(memFullErr);
		err = HReadTree(gWindowFormats, wfmt);
	}

	if (!err) {
		gTypeListLen       = 0;
		gAppWindowAttr     = 0;
		gAppWindowType     = 0;
		gNoDefaultDocument = true;
		for (i = 0; i < (*gWindowFormats)->numChildren; ++i) {
			wobj = GetChildHndl(gWindowFormats, i);
			attr = mDerefWFMT(wobj)->attributes;
			if (!(attr & kwRuntimeOnlyDoc))
				++gTypeListLen;
			if (attr & kwDefaultDocType) {
				gAppWindowAttr     = attr;
				gAppWindowType     = mDerefWFMT(wobj)->sfType;
				gNoDefaultDocument = false;
			}
		}
		if (gTypeListLen) {
			if (lastTypeListPtr)
				DisposePtr((Ptr)lastTypeListPtr);
			gTypeListPtr = lastTypeListPtr = (OSType *)NewPtr(gTypeListLen * sizeof(OSType));
			if (!gTypeListPtr)
				return(memFullErr);
			for (i = j = 0; i < (*gWindowFormats)->numChildren; ++i) {
				wobj = GetChildHndl(gWindowFormats, i);
				attr = mDerefWFMT(wobj)->attributes;
				if (!(attr & kwRuntimeOnlyDoc))
					gTypeListPtr[j++] = mDerefWFMT(wobj)->sfType;
			}
		}
	}

	return(err);
}



/*****************************************************************************/



/* This function is called to add a named 'WFMT' resource that isn't included in
** the 'WFMT' id #128 standard resource.  The purpose for not including all of
** the 'WFMT' resources into the id #128 is for speed reasons.  For really complex
** applications, the number of items in the various windows and dialogs can cause
** a huge number of handled to be created, thus slowing down the application.
** By separating out one or more window definitions and saving them off, the size
** of the main 'WFMT' resource can be reduced.  Named 'WFMT' resources should be
** named with the document type used to reference them.  They are read in, used,
** and then disposed of automatically. */

#pragma segment Window
OSErr	GetSeparateWFMT(OSType sftype, short *numAdded)
{
	short			i, nadd, *naddptr;
	TreeObjHndl		wfmt;
	OSErr			err;
	Handle			hndl;
	Str15			str;

	nadd    = 0;
	naddptr = (numAdded) ? numAdded : &nadd;

	if (!sftype) {
		while (*naddptr)
			DisposeChild(NO_EDIT, gWindowFormats, --*naddptr);
		return(noErr);
	}

	*naddptr = 0;
	for (i = (*gWindowFormats)->numChildren; i;) {
		wfmt = GetChildHndl(gWindowFormats, --i);
		if (mDerefWFMT(wfmt)->sfType == sftype) return(noErr);
	}

	str[0] = 4;
	BlockMove(&sftype, str + 1, sizeof(OSType));
	hndl = GetAppNamedResource('WFMT', str, &err);
	if (err) return(err);

	if (hndl) {
		DetachResource(hndl);
		wfmt = NewChild(NO_EDIT, gWindowFormats, *naddptr, WFMTOBJ, 0);
		if (!wfmt) {
			DisposeChild(NO_EDIT, gWindowFormats, *naddptr);
			return(memFullErr);
		}

		err = HReadTree(wfmt, hndl);		/* Unflatten the WFMT resource into the place-holder */
		DisposeHandle(hndl);

		if (err) {
			DisposeChild(NO_EDIT, gWindowFormats, *naddptr);
			return(err);
		}

		for (; (*wfmt)->numChildren;)
			MoveChild(NO_EDIT, wfmt, 0, gWindowFormats, (*naddptr)++);

		DisposeChild(NO_EDIT, gWindowFormats, *naddptr);
	}

	return(noErr);
}



/*****************************************************************************/
/*****************************************************************************/



/* This function adds a set of controls (and sets referenced by that set) to the
** window.  The control sets are created with the AppsToGo application editor. */

#pragma segment Window
OSErr	AddControlSet(WindowPtr window, OSType sftype, short visMode,
					  short xoffset, short yoffset, CObjCtlHndl retcoc)
{
	WindowPtr			oldPort;
	ControlHandle		ctl, dataCtl;
	CObjCtlHndl			coc;
	short				cocnum, i, j, len, ii, jj, vm, xo, yo, numAdded;
	OSType				sft;
	long				ofst, oldSize, newSize;
	TreeObjHndl			wfmt, cobj;
	char				str[256];
	OSErr				err;
	Rect				rct;

	if (!gWindowFormats) return(noErr);

	SetRect(&rct, 0, 0, 0, 0);
	dataCtl = NewControl(window, &rct, "\p", false, 0,0,0, gDataCtl + 7, sftype);
	if (!dataCtl) return(memFullErr);

	if (!(coc = (CObjCtlHndl)NewHandle(0x100))) return(memFullErr);

	if (err = GetSeparateWFMT(sftype, &numAdded)) return(err);

	GetPort(&oldPort);
	SetPort(window);

	(*dataCtl)->contrlData = (Handle)coc;
	cocnum = 0;

	for (i = (*gWindowFormats)->numChildren; i;) {
		wfmt = GetChildHndl(gWindowFormats, --i);
		if (mDerefWFMT(wfmt)->sfType == sftype) {
			for (j = 0; j < (*wfmt)->numChildren; ++j) {
				cobj = GetChildHndl(wfmt, j);
				ctl  = MakeControl(window, cobj, visMode, xoffset, yoffset);
				if (ctl) {
					SetHandleSize((Handle)coc, (((++cocnum * sizeof(CObjCtl)) | 0xFF) + 1));
					(**coc)[--cocnum].ctlObj = cobj;	/* The handle was already big enough. */
					(**coc)[cocnum++].ctl    = ctl;
					err = MemError();
				}
				if (!ctl) err = memFullErr;
				if (err) {
					SetHandleSize((Handle)coc, cocnum * sizeof(CObjCtl));
					SetPort(oldPort);
					GetSeparateWFMT(0, &numAdded);
					return(err);
				}
			}

			ofst = GetDataOffset(wfmt, offsetof(WFMTObj,title), kPStr, 1);
			GetPData(wfmt, ofst, (StringPtr)str);
			len = str[0];
			p2c((StringPtr)str);
			for (ii = 0; ii < len;) {
				BlockMove(str + ii + 1, &sft, sizeof(OSType));
				ii += sizeof(OSType) + 3;
				vm = c2dec(str + ii, &jj);
				ii += ++jj;
				xo = c2dec(str + ii, &jj);
				ii += ++jj;
				yo = c2dec(str + ii, &jj);
				ii += ++jj;
				mDerefWFMT(wfmt)->sfType = 0;
					/* Prevent self-references, which cause infinite recursion (boom). */
				err = AddControlSet(window, sft, vm, xoffset + xo, yoffset + yo, retcoc);
				mDerefWFMT(wfmt)->sfType = sftype;
				if (err) {
					SetHandleSize((Handle)coc, cocnum * sizeof(CObjCtl));
					SetPort(oldPort);
					GetSeparateWFMT(0, &numAdded);
					return(err);
				}
			}
		}
	}

	newSize = cocnum * sizeof(CObjCtl);
	SetHandleSize((Handle)coc, newSize);

	SetPort(oldPort);

	GetSeparateWFMT(0, &numAdded);

	if (retcoc) {
		oldSize = GetHandleSize((Handle)retcoc);
		SetHandleSize((Handle)retcoc, oldSize + newSize);
		if (err = MemError()) return(err);
		BlockMove(*coc, (*(Handle)retcoc) + oldSize, newSize);
	}

	return(noErr);
}



/*****************************************************************************/



#pragma segment Window

static pascal void	DefaultScrollAction(ControlHandle ctl, short part);
static pascal void	DefaultScrollAction(ControlHandle ctl, short part)
{
	short				delta, value;
	short				oldValue, min, max;
	ControlStyleInfo	cinfo;
	Boolean				vert;
	short				hArrowVal = 1;
	short				vArrowVal = 1;
	short				hPageVal = 10;
	short				vPageVal = 10;

	cinfo.scrollProc = nil;
	if (GetControlStyle(ctl, &cinfo)) {
		if (cinfo.hArrowVal) hArrowVal = cinfo.hArrowVal;
		if (cinfo.vArrowVal) vArrowVal = cinfo.vArrowVal;
		if (cinfo.hPageVal)  hPageVal  = cinfo.hPageVal;
		if (cinfo.vPageVal)  vPageVal  = cinfo.vPageVal;
	}

	vert = (((*ctl)->contrlRect.right - (*ctl)->contrlRect.left) == 16);

	if (part) {						/* If it was actually in the control. */

		switch (part) {
			case inUpButton:
			case inDownButton:		/* One line. */
				delta = (vert) ? vArrowVal : hArrowVal;
				break;
			case inPageUp:			/* One page. */
			case inPageDown:
				delta = (vert) ? vPageVal : hPageVal;
				break;
		}

		if ( (part == inUpButton) || (part == inPageUp) )
			delta = -delta;		/* Reverse direction for an upper. */

		value = (oldValue = GetCtlValue(ctl)) + delta;
		if (value < (min = GetCtlMin(ctl))) value = min;
		if (value > (max = GetCtlMax(ctl))) value = max;

		if (value != oldValue)
			SetCtlValue(ctl, value);

		if (cinfo.scrollProc) (*cinfo.scrollProc)(ctl, part, oldValue, value);
	}
}

static Boolean	DefaultScroll(ControlHandle ctl, short part, EventRecord *event);
static Boolean	DefaultScroll(ControlHandle ctl, short part, EventRecord *event)
{
	short				oldValue, newValue;
	ControlStyleInfo	cinfo;

	static ControlActionUPP	cupp;

	oldValue = newValue = GetCtlValue(ctl);
	switch (part) {
		case inThumb:
			if (TrackControl(ctl, event->where, nil)) {
				newValue = GetCtlValue(ctl);
				if (oldValue != newValue) {
					if (GetControlStyle(ctl, &cinfo))
						if (cinfo.scrollProc)
							(*cinfo.scrollProc)(ctl, part, oldValue, newValue);
				}
			}
			break;
		default:
			if (!cupp) cupp = NewControlActionProc(DefaultScrollAction);
			TrackControl(ctl, event->where, cupp);
			newValue = GetCtlValue(ctl);
			break;
	}

	return((oldValue != newValue) ? true : false);
}

static void	AddRect(Rect *r1, Rect *r2, Rect *r3);
static void	AddRect(Rect *r1, Rect *r2, Rect *r3)
{
	Rect	r;

	r = *r1;	
	r.top    += r2->top;
	r.left   += r2->left;
	r.bottom += r2->bottom;
	r.right  += r2->right;
	if ((r.left >= r.right) || (r.top >= r.bottom)) SetRect(&r, 0, 0, 0, 0);
	*r3 = r;
}

/* This function is used to create a control based on the control definition object.
** The control definition objects are created with the AppsToGo application editor. */

#pragma segment Window
ControlHandle	MakeControl(WindowPtr window, TreeObjHndl cobj, short visMode, short xoffset, short yoffset)
{
	WindowPtr			oldPort;
	ControlHandle		ctl;
	short				cctbID, tlen, slen, vis, maxTextLen;
	short				variant, rr, cc, ll, procID, mode;
	long				ofst;
	ControlStyleInfo	cinfo;
	CCTabHandle			cctbHndl;
	TEHandle			te;
	ListHandle			list;
	Handle				txt;
	StScrpHandle		styl;
	Ptr					ptr;
	Point				cell;
	Rect				destRct, viewRct, brdrRct;
	char				hstate;
	CtlTemplate			**crsrc;
	short				txFont, txSize, fnum;
	Style				txFace;

	GetPort(&oldPort);
	SetPort(window);

	HLock((Handle)cobj);
	OffsetRect(&mDerefCtl(cobj)->rect, xoffset, yoffset);

	variant = (mDerefCtl(cobj)->procID & 0x0F);
	ctl = nil;
	vis  = mDerefCtl(cobj)->visible;
	vis |= visMode;
	vis ^= (visMode > 1);
	vis &= 0x01;

	cinfo.ctlID       = mDerefCtl(cobj)->ctlID;
	cinfo.trackProc   = nil;
	cinfo.scrollProc  = nil;
	cinfo.hArrowVal   = 0;
	cinfo.vArrowVal   = 0;
	cinfo.hPageVal    = 0;
	cinfo.vPageVal    = 0;
	cinfo.drawControl = nil;
	cinfo.fontSize    = mDerefCtl(cobj)->fontSize;
	cinfo.fontStyle   = mDerefCtl(cobj)->fontStyle;
	ofst = GetDataOffset(cobj, offsetof(CtlObj,title), kPStr, 1);
	GetPData(cobj, ofst, cinfo.keyEquivs);
	ofst = GetDataOffset(cobj, offsetof(CtlObj,title), kPStr, 2);
	GetPData(cobj, ofst, cinfo.font);
	ofst = GetDataOffset(cobj, offsetof(CtlObj,title), kPStr, 3);
	GetPData(cobj, ofst, cinfo.balloonHelp);
	txFont = window->txFont;
	txSize = window->txSize;
	txFace = window->txFace;
	procID = mDerefCtl(cobj)->procID;
	if (procID & 0x08) {
		TextFace(cinfo.fontStyle);
		fnum = 0;
		if (cinfo.font[0])
			GetFNum(cinfo.font, &fnum);
		TextFont(fnum);
		TextSize(cinfo.fontSize);
	}

	switch (procID & 0xFFF0) {
		case rTECtl:
			destRct = mDerefCtl(cobj)->extCtl.ctenew.destRct;
			viewRct = mDerefCtl(cobj)->extCtl.ctenew.viewRct;
			brdrRct = mDerefCtl(cobj)->extCtl.ctenew.brdrRct;
			maxTextLen = mDerefCtl(cobj)->extCtl.ctenew.maxTextLen;
			if (maxTextLen < 1) {
				maxTextLen = -maxTextLen;
				AddRect(&mDerefCtl(cobj)->rect, &destRct, &destRct);
				AddRect(&mDerefCtl(cobj)->rect, &viewRct, &viewRct);
				AddRect(&mDerefCtl(cobj)->rect, &brdrRct, &brdrRct);
			}
			else {
				OffsetRect(&destRct, xoffset, yoffset);
				OffsetRect(&viewRct, xoffset, yoffset);
				OffsetRect(&brdrRct, xoffset, yoffset);
			}
			CTENew(gTECtl + variant,
				   false, window, &te,
				  &mDerefCtl(cobj)->rect,
				  &destRct, &viewRct, &brdrRct,
				   maxTextLen, mDerefCtl(cobj)->extCtl.ctenew.mode
			);
			if (te) {
				UseControlStyle(ctl = CTEViewFromTE(te));
				ofst = GetDataOffset(cobj, offsetof(CtlObj,title), kPStr, 4);
				BlockMove((char *)GetDataPtr(cobj) + ofst, &tlen, sizeof(short));
				txt = NewHandle(tlen);
				if (txt) {
					ptr = GetDataPtr(cobj);
					BlockMove(ptr + ofst + sizeof(short), *txt, tlen);
					slen = 0;
					styl = nil;
					if (mDerefCtl(cobj)->extCtl.ctenew.mode & cteStyledTE) {
						ofst = GetDataOffset(cobj, ofst, kSDataBlock, 1);
						BlockMove((char *)GetDataPtr(cobj) + ofst, &slen, sizeof(short));
						if (slen)
							styl = (StScrpHandle)NewHandle(slen);
						if (styl) {
							ptr = GetDataPtr(cobj);
							BlockMove(ptr + ofst + sizeof(short), (Ptr)*styl, slen);
						}
					}
					DisposeHandle(CTESwapText(te, txt, styl, false));
					if (styl)
						DisposeHandle((Handle)styl);
					if (!(*ctl)->contrlHilite)
				 		if (mDerefCtl(cobj)->extCtl.ctenew.mode & cteActive)
							if (!CTEReadOnly(te))
								CTESetSelect(mDerefCtl(cobj)->min, mDerefCtl(cobj)->max, te);
				}
				UseControlStyle(nil);
			}
			break;
		case rListCtl:
			mode = mDerefCtl(cobj)->extCtl.clnew.mode;
			if (!gclvVariableSizeCells)
				mode &= (0xFFFF - clVariable);
			list = CLNew(gListCtl + variant,
						 false,
					    &mDerefCtl(cobj)->rect,
						 mDerefCtl(cobj)->extCtl.clnew.numRows,
						 mDerefCtl(cobj)->extCtl.clnew.numCols,
						 mDerefCtl(cobj)->extCtl.clnew.cellHeight,
						 mDerefCtl(cobj)->extCtl.clnew.cellWidth,
						 mDerefCtl(cobj)->refCon,
						 window,
						 (mode & (0xFFFF - clVariable))
			);
			if (list) {
				(*list)->listFlags |= 0x08;
				ctl  = CLViewFromList(list);
				ofst = GetDataOffset(cobj, offsetof(CtlObj,title), kPStr, 4);
				BlockMove((char *)GetDataPtr(cobj) + ofst, &tlen, sizeof(short));
				txt = NewHandle(tlen);
				if (txt) {
					ptr = GetDataPtr(cobj);
					BlockMove(ptr + ofst + sizeof(short), *txt, tlen);
					ofst = 0;
					HLock(txt);
					for (rr = 0; rr < mDerefCtl(cobj)->extCtl.clnew.numRows; ++rr) {
						if (ofst >= tlen) break;
						for (cc = 0; cc < mDerefCtl(cobj)->extCtl.clnew.numCols; ++cc) {
							if (ofst >= tlen) break;
							cell.h = cc;
							cell.v = rr;
							ll = ((unsigned char *)*txt)[ofst];
							LSetCell(*txt + ofst + 1, ll, cell, list);
							ofst += ++ll;
						}
					}
					DisposeHandle(txt);
				}
				if (mode & clVariable)
					(*gclvVariableSizeCells)(list);
				else
					if ((mDerefCtl(cobj)->extCtl.clnew.mode) & clDrawIt)
						(*list)->listFlags &= (0xFFFF - 0x08);
			}
			break;
		case rCIconCtl:
			ctl = CCIconNew(window,
						   &mDerefCtl(cobj)->rect,
				 (StringPtr)mDerefCtl(cobj)->title,
							false,
							mDerefCtl(cobj)->value,
							mDerefCtl(cobj)->min,
							mDerefCtl(cobj)->max,
							gCIconCtl + variant,
							mDerefCtl(cobj)->refCon
			);
			break;
		case rPICTCtl:
			ctl = CPICTNew(window,
						  &mDerefCtl(cobj)->rect,
				(StringPtr)mDerefCtl(cobj)->title,
						   false,
						   mDerefCtl(cobj)->value,
						   mDerefCtl(cobj)->min,
						   mDerefCtl(cobj)->max,
						   gPICTCtl + variant,
						   mDerefCtl(cobj)->refCon
			);
			break;
		default:
			procID = mDerefCtl(cobj)->procID;
			if (procID == -1) {
				crsrc = (CtlTemplate **)GetResource('CNTL', mDerefCtl(cobj)->refCon);
				if (crsrc) {
					hstate = HGetState((Handle)crsrc);
					HLock((Handle)crsrc);
					ctl = NewControl(window,
							  &mDerefCtl(cobj)->rect,
					(StringPtr)(*crsrc)->contrlTitle,
							   false,
							   (*crsrc)->contrlValue,
							   (*crsrc)->contrlMin,
							   (*crsrc)->contrlMax,
							   (*crsrc)->procID,
							   (*crsrc)->contrlRfCon
					);
					HSetState((Handle)crsrc, hstate);
					if (((*crsrc)->procID & 0xFFF0) == popupMenuProc)
						gPopupProc = (*ctl)->contrlDefProc;
				}
				if (ctl) break;
				procID = 0;
			}
			if ((procID > rPICTCtl) && (procID < rDataCtl + 16))
					procID += (gDataCtl - rDataCtl);
						/* For AppsToGo to be able to use the target's CDEF's,
						** we have to have unique numbers for the extended controls.
						** AppsToGo has added a constant to all of the extended
						** controls for this reason.  We have to do the same for
						** these extra extended controls so that the contrlDefProc
						** is constant for compare purposes. */
			ctl = NewControl(window,
					  &mDerefCtl(cobj)->rect,
			(StringPtr)mDerefCtl(cobj)->title,
					   false,
					   mDerefCtl(cobj)->value,
					   mDerefCtl(cobj)->min,
					   mDerefCtl(cobj)->max,
					   procID,
					   mDerefCtl(cobj)->refCon
			);
			if (procID == scrollBarProc) cinfo.trackProc = DefaultScroll;
			break;
	}

	TextFont(txFont);
	TextSize(txSize);
	TextFace(txFace);

	OffsetRect(&mDerefCtl(cobj)->rect, -xoffset, -yoffset);
	HUnlock((Handle)cobj);

	if (ctl) {
		HiliteControl(ctl, mDerefCtl(cobj)->hilite);
		SetControlStyle(ctl, &cinfo);
		if (cctbID = mDerefCtl(cobj)->cctbID) {
			if (gQDVersion > kQDOriginal) {
				cctbHndl = (CCTabHandle)GetResource('cctb', cctbID);
				if (cctbHndl)
					SetCtlColor(ctl, cctbHndl);
			}
		}

		if (vis) {
			switch (mDerefCtl(cobj)->procID & 0xFFF0) {
				case rTECtl:
					CTEShow((TEHandle)GetCRefCon(ctl));
					break;
				case rListCtl:
					CLShow((ListHandle)GetCRefCon(ctl));
					break;
				default:
					ShowControl(ctl);
					break;
			}
		}
	}

	SetPort(oldPort);
	return(ctl);
}



/*****************************************************************************/



/* This function is called to return the handle of the Data control that has
** a reference to all of the controls in the control set.  Once you get the
** Data control, you can then look at the data in the control to get the handle
** of the controls within the control set. */

#pragma segment Window
CObjCtlHndl	GetControlSet(WindowPtr window, OSType sftype, ControlHandle *retDataCtl)
{
	ControlHandle	dataCtl;
	CObjCtlHndl		coc;

	for (dataCtl = nil; dataCtl = CDataNext(window, dataCtl);) {
		if ((*dataCtl)->contrlRfCon != sftype) continue;
		if (GetCVariant(dataCtl) != 7)		   continue;
		if (coc = (CObjCtlHndl)(*dataCtl)->contrlData) {
			if (retDataCtl) *retDataCtl = dataCtl;
			return(coc);
		}
	}

	if (retDataCtl) *retDataCtl = nil;
	return(nil);
}



/*****************************************************************************/



/* This function is used to show or hide a set of controls. */

#pragma segment Window
void	DisplayControlSet(WindowPtr window, OSType sftype, short visMode)
{
	WindowPtr		curPort;
	CObjCtlHndl		coc;
	short			i, vis;
	TreeObjHndl		cobj;
	ControlHandle	ctl;
	Rect			rct;

	GetPort(&curPort);
	SetPort(window);
	if (coc = GetControlSet(window, sftype, nil)) {
		for (i = GetHandleSize((Handle)coc) / sizeof(CObjCtl); i;) {
			cobj = (**coc)[--i].ctlObj;
			ctl  = (**coc)[  i].ctl;
			vis  = mDerefCtl(cobj)->visible,
			vis  = ((vis | visMode) ^ (visMode > 1)) & 0x01;
			if (vis) {
				switch (mDerefCtl(cobj)->procID & 0xFFF0) {
					case rTECtl:
						CTEShow((TEHandle)GetCRefCon(ctl));
						break;
					case rListCtl:
						CLShow((ListHandle)GetCRefCon(ctl));
						break;
					default:
						ShowStyledControl(ctl);
						break;
				}
			}
			else {
				switch (mDerefCtl(cobj)->procID & 0xFFF0) {
					case rTECtl:
						rct = CTEHide((TEHandle)GetCRefCon(ctl));
						if (!(visMode & kwInvalOnHide)) ValidRect(&rct);
						break;
					case rListCtl:
						rct = CLHide((ListHandle)GetCRefCon(ctl));
						if (!(visMode & kwInvalOnHide)) ValidRect(&rct);
						break;
					default:
						HideStyledControl(ctl);
						if (!(visMode & kwInvalOnHide)) {
							rct = (*ctl)->contrlRect;
							if (GetButtonVariant(ctl) == pushButProc)
								if ((*ctl)->contrlValue)
									InsetRect(&rct, kButtonFrameInset, kButtonFrameInset);
							ValidRect(&rct);
						}
						break;
				}
			}
		}
	}
	SetPort(curPort);
}



/*****************************************************************************/



/* This function is used to draw a set of controls. */

#pragma segment Window
void	DrawControlSet(WindowPtr window, OSType sftype)
{
	CObjCtlHndl		coc;
	short			i, j;
	TreeObjHndl		cobj;
	ControlHandle	ctl, cc;
	ListHandle		list;

	if (coc = GetControlSet(window, sftype, nil)) {
		for (i = GetHandleSize((Handle)coc) / sizeof(CObjCtl); i;) {
			cobj = (**coc)[--i].ctlObj;
			ctl  = (**coc)[  i].ctl;
			DoDraw1Control(ctl, false);
			switch (mDerefCtl(cobj)->procID & 0xFFF0) {
				case rTECtl:
					for (j = 0; j < 2; ++j) {
						cc = CTEScrollFromView(ctl, j);
						if (cc) DoDraw1Control(cc, false);
					}
					break;
				case rListCtl:
					if (list = (ListHandle)GetCRefCon(ctl)) {
						if (cc = (*list)->vScroll) DoDraw1Control(cc, false);
						if (cc = (*list)->hScroll) DoDraw1Control(cc, false);
					}
					break;
			}
		}
	}
}



/*****************************************************************************/



/* This function is used to dispose a set of controls. */

#pragma segment Window
void	DisposeControlSet(WindowPtr window, OSType sftype)
{
	CObjCtlHndl		coc;
	ControlHandle	dataCtl;
	short			i;

	if (coc = GetControlSet(window, sftype, &dataCtl)) {
		for (i = GetHandleSize((Handle)coc) / sizeof(CObjCtl); i;) {
			HideStyledControl((**coc)[--i].ctl);
			DisposeControl((**coc)[i].ctl);
		}
		DisposeControl(dataCtl);
	}
}



/*****************************************************************************/



/* This fuction is called to adjust all of the menus in the designated MBAR. 
** The functions gets each menu handle, and then disables all of the menu items
** for that menu.  It then calls the application to give the application the
** chance to enable the appropriate menu items. */

#pragma segment Window
Boolean	DoAdjustMBARMenus(WindowPtr window, short menuBarID)
{
	FileRecHndl				frHndl;
	short					**mbar, i;
	long					oldFlags;
	AdjustMenuItemsProcPtr	proc;
	Boolean					redrawMenuBar;
	MenuHandle				menu;

	redrawMenuBar = false;

	proc = AdjustMenuItems;
	if (window)
		if (frHndl = (FileRecHndl)GetWRefCon(window))
			proc = (*frHndl)->fileState.adjustMenuItemsProc;

	if (mbar = (short **)GetAppResource('MBAR', menuBarID, nil)) {
		for (i = **mbar; i; --i) {
			if (menu = GetMHandle((*mbar)[i])) {
				oldFlags             = (*menu)->enableFlags;
				(*menu)->enableFlags = oldFlags & 0x01;
				redrawMenuBar       |= (*proc)(window, (*mbar)[i]);
				if ((*menu)->enableFlags & 0xFFFFFFFEL) EnableItem(menu, 0);
				else									DisableItem(menu, 0);
				if ((oldFlags & 0x01) != ((*menu)->enableFlags & 0x01))
					redrawMenuBar = true;
			}
		}
	}

	return(redrawMenuBar);
}



/*****************************************************************************/



/* This function is used to open all of the windows that are correctly designated
** with the AppsToGo application editor.  You should call this in your application
** at startup time if your application is editable with the AppsToGo application editor. */

#pragma segment Window
OSErr	OpenRuntimeOnlyAutoNewWindows(void)
{
	FileRecHndl	frHndl;
	OSErr		err;
	short		i;
	TreeObjHndl	wobj;
	long		attr;

	err = noErr;
	if (gWindowFormats) {
		for (i = (*gWindowFormats)->numChildren; i;) {
			wobj = GetChildHndl(gWindowFormats, --i);
			attr = mDerefWFMT(wobj)->attributes;
			if (attr & kwRuntimeOnlyDoc) {
				if (attr & kwAutoNew) {
					err = NewDocumentWindow(&frHndl, mDerefWFMT(wobj)->sfType, true);
					if (err) break;
				}
			}
		}
	}
	return(err);
}



/*****************************************************************************/



/* This call can be done as two separate calls.  However, this function does both
** functions of creating the document, and then giving the document a window.  It
** also handles errors and puts up an error window if something goes wrong. */

#pragma segment Window
OSErr	NewDocumentWindow(FileRecHndl *frHndl, OSType sftype, Boolean incTitleNum)
{
	FileRecHndl	ff, *ffp;
	OSErr		err;
	short		i, numAdded;

	ffp = (frHndl) ? frHndl : &ff;
	*ffp = nil;

	if (!gWindowFormats) return(noErr);

	err = GetSeparateWFMT(sftype, &numAdded);
	if (!err) {
		for (i = (*gWindowFormats)->numChildren; i;) {
			if (sftype == mDerefWFMT(GetChildHndl(gWindowFormats, --i))->sfType) {
				err = NewDocument(ffp, sftype, incTitleNum);
				if (!err) {
					err = DoNewWindow(*ffp, nil, FrontWindowOfType(kwIsDocument, true), (WindowPtr)-1);
					if (err) DisposeDocument(*ffp);
				}
				break;
			}
		}
	}
	GetSeparateWFMT(0, &numAdded);

	return(err);
}



/*****************************************************************************/



/* This call can be done as two separate calls.  However, this function does both
** functions of creating the document, and then giving the document a window.  It
** also handles errors and puts up an error window if something goes wrong. */

#pragma segment Window
OSErr	OpenDocumentWindow(FileRecHndl *frHndl, FSSpecPtr fileToOpen, char permission)
{
	FileRecHndl	ff, *ffp;
	OSErr		err;

	ffp = (frHndl) ? frHndl : &ff;
	*ffp = nil;

	if (!gWindowFormats) return(noErr);

	err = OpenDocument(ffp, fileToOpen, permission);
	if (!err) {
		err = DoNewWindow(*ffp, nil, FrontWindowOfType(kwIsDocument, true), (WindowPtr)-1);
		if (err) DisposeDocument(*ffp);
	}

	return(err);
}



