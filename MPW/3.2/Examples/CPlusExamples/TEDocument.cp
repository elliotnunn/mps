/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	TEDocument.cp	-	C++ source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			CPlusTESample.make		July 9, 1989
#			TApplicationCommon.h	July 9, 1989
#			TApplication.h			July 9, 1989
#			TDocument.h				July 9, 1989
#			TECommon.h				July 9, 1989
#			TESample.h				July 9, 1989
#			TEDocument.h			July 9, 1989
#			TApplication.cp			July 9, 1989
#			TDocument.cp			July 9, 1989
#			TESample.cp				July 9, 1989
#			TEDocument.cp			July 9, 1989
#			TESampleGlue.a			July 9, 1989
#			TApplication.r			July 9, 1989
#			TESample.r				July 9, 1989
#
#	CPlusTESample is an example application that demonstrates
#	how to initialize the commonly used toolbox managers,
#	operate successfully under MultiFinder, handle desk
#	accessories and create, grow, and zoom windows. The
#	fundamental TextEdit toolbox calls and TextEdit autoscroll
#	are demonstrated. It also shows how to create and maintain
#	scrollbar controls. 
#
#	This version of TESample has been substantially reworked in
#	C++ to show how a "typical" object oriented program could
#	be written. To this end, what was once a single source code
#	file has been restructured into a set of classes which
#	demonstrate the advantages of object-oriented programming.
#
------------------------------------------------------------------------------*/


/*
Segmentation strategy:

    This program has only one segment, since the issues
    surrounding segmentation within a class's methods have
    not been investigated yet. We DO unload the data
    initialization segment at startup time, which frees up
    some memory 

SetPort strategy:

    Toolbox routines do not change the current port. In
    spite of this, in this program we use a strategy of
    calling SetPort whenever we want to draw or make calls
    which depend on the current port. This makes us less
    vulnerable to bugs in other software which might alter
    the current port (such as the bug (feature?) in many
    desk accessories which change the port on OpenDeskAcc).
    Hopefully, this also makes the routines from this
    program more self-contained, since they don't depend on
    the current port setting. 

Clipboard strategy:

    This program does not maintain a private scrap.
    Whenever a cut, copy, or paste occurs, we import/export
    from the public scrap to TextEdit's scrap right away,
    using the TEToScrap and TEFromScrap routines. If we did
    use a private scrap, the import/export would be in the
    activate/deactivate event and suspend/resume event
    routines. 
*/

// Mac Includes
#include <Types.h>
#include <QuickDraw.h>
#include <Fonts.h>
#include <Events.h>
#include <Controls.h>
#include <Windows.h>
#include <Menus.h>
#include <TextEdit.h>
#include <Dialogs.h>
#include <Desk.h>
#include <Scrap.h>
#include <ToolUtils.h>
#include <Memory.h>
#include <SegLoad.h>
#include <Files.h>
#include <OSUtils.h>
#include <Traps.h>

#include "TEDocument.h"
#include "TESample.h"

extern "C" { 
	// prototypes for functions that don't belong to any one class
	pascal ClikLoopProcPtr GetOldClikLoop(void);
	pascal void PascalClikLoop(void);
	void CommonAction(ControlHandle control,short* amount);
	pascal void VActionProc(ControlHandle control,short part);
	pascal void HActionProc(ControlHandle control,short part);
	// this routine is written in Assembler, since it needs to tweak registers
	pascal void ASMCLIKLOOP();
};

// kTextMargin is the number of pixels we leave blank at the edge of the window.
const short kTextMargin = 2;

// kMaxDocWidth is an arbitrary number used to specify the width of the TERec's
// destination rectangle so that word wrap and horizontal scrolling can be
// demonstrated.
const short	kMaxDocWidth = 576;
	
// kMinDocDim is used to limit the minimum dimension of a window when GrowWindow
// is called.
const short	kMinDocDim = 64;
	
// kMaxTELength is an arbitrary number used to limit the length of text in the TERec
// so that various errors won't occur from too many characters being in the text.
const short	kMaxTELength = 32000;

// kControlInvisible is used the same way to 'turn on' the control.
const short kControlVisible = 0xFF;

// ScrollBarAdjust, GrowBoxAdjust, and ScrollBar width are used in calculating
// values for control positioning and sizing.
const short kScrollbarAdjust = 15;
const short kGrowboxAdjust = 15;
const short kScrollbarWidth = 16;

// kTESlop provides some extra security when pre-flighting edit commands.
const short kTESlop = 1024;

// kScrollTweek compensates for off-by-one requirements of the scrollbars
// to have borders coincide with the growbox.
const short kScrollTweek = 2;
	
// kCrChar is used to match with a carriage return when calculating the
// number of lines in the TextEdit record. kDelChar is used to check for
// delete in keyDowns.
const short kCrChar = 13;
const short kDelChar = 8;

// notice that we pass the resID parameter up to our base class,
// which actually creates the window for us
TEDocument::TEDocument(short resID)	: (resID)
{
	Boolean good;
	Rect destRect, viewRect;

	good = false;
	SetPort(fDocWindow);
	GetTERect(&viewRect);
	destRect = viewRect;
	destRect.right = destRect.left + kMaxDocWidth;
	fDocTE = TENew(&destRect, &viewRect);
	
	good = fDocTE != nil;	// if TENew succeeded, we have a good document 

	if ( good )
	  {
		// set up TE record
		AdjustViewRect();
		TEAutoView(true, fDocTE);
		fDocClik = (*fDocTE)->clikLoop;
		(*fDocTE)->clikLoop = (ClikLoopProcPtr) ASMCLIKLOOP;

		// get vertical scrollbar
		fDocVScroll = GetNewControl(rVScroll, fDocWindow);
		good = (fDocVScroll != nil);
	  }
	if ( good)
	  {
		fDocHScroll = GetNewControl(rHScroll, fDocWindow);
		good = (fDocHScroll != nil);
	  }
	
	if ( good )				// good? — adjust & draw the controls, draw the window
	  {
		AdjustScrollValues(true);
		ShowWindow(fDocWindow);
	  }
	else
	  {
		// tell user we failed
		AlertUser(kTEDocErrStrings,eNoWindow); 
	  }
}

// At this point, if there was a document associated with a
// window, you could do any document saving processing if it is 'dirty'.
// DoCloseWindow would return true if the window actually closed, i.e.,
// the user didn’t cancel from a save dialog. This result is handy when
// the user quits an application, but then cancels the save of a document
// associated with a window.

TEDocument::~TEDocument(void)
{
	HideWindow(fDocWindow);
	if ( fDocTE != nil )
	  {
		TEDispose(fDocTE);			// dispose the TEHandle if we got far enough to make one 
	  }
	if ( fDocVScroll != nil )
	  {
		DisposeControl(fDocVScroll);
	  }
	if ( fDocHScroll != nil )
	  {
		DisposeControl(fDocHScroll);
	  }
	// base class destructor will dispose of window
}

void TEDocument::DoZoom(short partCode)
{
	Rect tRect;

	tRect = fDocWindow->portRect;
	EraseRect(&tRect);
	ZoomWindow(fDocWindow, partCode, fDocWindow == FrontWindow());
	AdjustScrollbars(true);		// adjust, redraw anyway 
	AdjustTE();
	InvalRect(&tRect);			// invalidate the whole content 
	// the scrollbars were taken care of by AdjustScrollbars, so validate ’em 
	tRect = (*fDocVScroll)->contrlRect;
	ValidRect(&tRect);
	tRect = (*fDocHScroll)->contrlRect;
	ValidRect(&tRect);
}

// Called when a mouseDown occurs in the grow box of an active window. 

void TEDocument::DoGrow(EventRecord* theEvent)
{
	long growResult;
	Rect tRect, tRect2;
	
	tRect = qd.screenBits.bounds;
	tRect.left = kMinDocDim;
	tRect.top = kMinDocDim;
	growResult = GrowWindow(fDocWindow, theEvent->where, &tRect);
	// see if it really changed size 
	if ( growResult != 0 )
	  {
		tRect = (*fDocTE)->viewRect;
		SizeWindow(fDocWindow, LoWrd(growResult), HiWrd(growResult), true);
		AdjustScrollbars(true);
		AdjustTE();
		// calculate & validate the region that hasn’t changed so it won’t get redrawn
		// Note: we copy rectangles so that we don't take address of object fields.
		tRect2 = (*fDocTE)->viewRect;
		(void) SectRect(&tRect, &tRect2, &tRect);
		tRect2 = fDocWindow->portRect; InvalRect(&tRect2);
		ValidRect(&tRect);
		tRect2 = (*fDocVScroll)->contrlRect; ValidRect(&tRect2);
		tRect2 = (*fDocHScroll)->contrlRect; ValidRect(&tRect2);
	  }
}

void TEDocument::DoContent(EventRecord* theEvent)
{
	Point mouse;
	ControlHandle control;
	short part, value;
	Boolean shiftDown;
	Rect teRect;

	SetPort(fDocWindow);
	mouse = theEvent->where;							// get the click position 
	GlobalToLocal(&mouse);
	GetTERect(&teRect);
	if ( PtInRect(mouse, &teRect) )
	  {
		/* see if we need to extend the selection */
		shiftDown = (theEvent->modifiers & shiftKey) != 0;	/* extend if Shift is down */
		TEClick(mouse, shiftDown, fDocTE);
	  }
	else
	  {
		part = FindControl(mouse, fDocWindow, &control);
		switch ( part )
		  {
			case 0:
				// do nothing if not in a control
				break;
			case inThumb:
				value = GetCtlValue(control);
				part = TrackControl(control, mouse, nil);
				if ( part != 0 )
				  {
					value -= GetCtlValue(control);
					// value now has CHANGE in value; if value changed, scroll 
					if ( value != 0 )
						if ( control == fDocVScroll )
							TEScroll(0, value * (*fDocTE)->lineHeight, fDocTE);
						else TEScroll(value, 0, fDocTE);
				  }
				break;
			default:						// they clicked in an arrow, so track & scroll 
				if ( control == fDocVScroll )
					value = TrackControl(control, mouse, (ProcPtr) VActionProc);
				else value = TrackControl(control, mouse, (ProcPtr) HActionProc);
				break;
		  }
	  }
}

void TEDocument::DoKeyDown(EventRecord* theEvent)
{
	char key;

	if (theEvent->modifiers & cmdKey)	// don't process command characters
	  return;
	key = (char) (theEvent->message & charCodeMask);
	// we have a char. for our window; see if we are still below TextEdit’s
	// limit for the number of characters
	if ((key == kDelChar) ||
		((*fDocTE)->teLength - ((*fDocTE)->selEnd - (*fDocTE)->selStart) + 1 < kMaxTELength) )
	  {
		TEKey(key, fDocTE);
		AdjustScrollbars(false);
		AdjustTE();
	  }
	else AlertUser(kTEDocErrStrings,eExceedChar);
}

void TEDocument::DoActivate(Boolean becomingActive)
{
	if ( becomingActive )
	  {
		RgnHandle	tempRgn;
		RgnHandle	clipRgn;
		Rect		growRect;
		Rect		tRect;

		// since we don’t want TEActivate to draw a selection in an area where
		// we’re going to erase and redraw, we’ll clip out the update region
		// before calling it.
		tempRgn = NewRgn();
		clipRgn = NewRgn();
		// save old update region
		CopyRgn(((WindowPeek) fDocWindow)->updateRgn, tempRgn);
		// put it in local coords
		OffsetRgn(tempRgn, fDocWindow->portBits.bounds.left, fDocWindow->portBits.bounds.top);
		GetClip(clipRgn);
		// subtract updateRgn from clipRgn
		DiffRgn(clipRgn, tempRgn, tempRgn);
		// make it the new clipRgn
		SetClip(tempRgn);
		TEActivate(fDocTE);
		// restore the full-blown clipRgn
		SetClip(clipRgn);
		// get rid of temp regions
		DisposeRgn(tempRgn);
		DisposeRgn(clipRgn);

		/* the controls must be redrawn on activation: */
		(*fDocVScroll)->contrlVis = kControlVisible;
		(*fDocHScroll)->contrlVis = kControlVisible;
		// copy rectangles to avoid unsafe object field references!
		tRect = (*fDocVScroll)->contrlRect; InvalRect(&tRect);
		tRect = (*fDocHScroll)->contrlRect; InvalRect(&tRect);
		// the growbox needs to be redrawn on activation:
		growRect = fDocWindow->portRect;
		// adjust for the scrollbars
		growRect.top = growRect.bottom - kScrollbarAdjust;
		growRect.left = growRect.right - kScrollbarAdjust;
		InvalRect(&growRect);
	  }
	else
	  {		
		TEDeactivate(fDocTE);
		/* the controls must be hidden on deactivation: */
		HideControl(fDocVScroll);
		HideControl(fDocHScroll);
		// we draw grow icon immediately, since we deactivate controls
		// immediately, and the update delay looks funny
		DrawGrowIcon(fDocWindow);
	  }
}

void TEDocument::DoUpdate(void)
{
	BeginUpdate(fDocWindow);				// this sets up the visRgn 
	if ( ! EmptyRgn(fDocWindow->visRgn) )	// draw if updating needs to be done 
	  {
		DrawWindow();
	  }
	EndUpdate(fDocWindow);
}

// calculate how much idle time we need

unsigned long TEDocument::CalcIdle(void)
{
	if (HaveSelection())
	  return GetCaretTime();
	else return kMaxSleepTime;	// if we don't have a selection, we don't need to idle
}

// This is called whenever we get a null event et al.
// It takes care of necessary periodic actions. For this program,
// it calls TEIdle.

void TEDocument::DoIdle(void)
{
	TEIdle(fDocTE);
} // DoIdle

// Draw the contents of an application window. 

void TEDocument::DrawWindow(void)
{
	Rect tRect;

	SetPort(fDocWindow);
	tRect = fDocWindow->portRect;
	EraseRect(&tRect);
	TEUpdate(&tRect, fDocTE);
	DrawControls(fDocWindow);
	DrawGrowIcon(fDocWindow);
} // DrawWindow

// Return a rectangle that is inset from the portRect by the size of
// the scrollbars and a little extra margin.

void TEDocument::GetTERect(Rect* teRect)
{
	*teRect = fDocWindow->portRect;
	InsetRect(teRect, kTextMargin, kTextMargin);			// adjust for margin 
	teRect->bottom = teRect->bottom - kScrollbarAdjust;	// and for the scrollbars 
	teRect->right = teRect->right - kScrollbarAdjust;
} // GetTERect

// setup a region which contains the visible text

void TEDocument::GetVisTERgn(RgnHandle rgn)
{
	Rect teRect;

	teRect = (*fDocTE)->viewRect;	// get a local copy of viewRect
	SetPort(fDocWindow);			// make sure we have right port
	LocalToGlobal(&TopLeft(teRect));
	LocalToGlobal(&BotRight(teRect));
	RectRgn(rgn, &teRect);
	// we temporarily change the port’s origin to “globalfy” the visRgn
	SetOrigin(-(fDocWindow->portBits.bounds.left),
			  -(fDocWindow->portBits.bounds.top));
	SectRgn(rgn, fDocWindow->visRgn, rgn);
	SetOrigin(0, 0);
} // GetTERgn

// Return boolean value indicating that there is or is not a
// selection in the document

Boolean TEDocument::HaveSelection()
{
	if ( (*fDocTE)->selStart < (*fDocTE)->selEnd )
	  return true;
	else return false;
}

// Update the TERec's view rect so that it is the greatest multiple of
// the lineHeight that still fits in the old viewRect.

void TEDocument::AdjustViewRect(void)
{
	TEPtr te;
	
	te = *fDocTE;
	te->viewRect.bottom = (((te->viewRect.bottom - te->viewRect.top) / te->lineHeight)
							* te->lineHeight) + te->viewRect.top;
} // AdjustViewRect

// Scroll the TERec around to match up to the potentially updated scrollbar
// values. This is really useful when the window has been resized such that the
// scrollbars became inactive but the TERec was already scrolled.

void TEDocument::AdjustTE(void)
{
	TEPtr te;
	
	te = *fDocTE;
	TEScroll((te->viewRect.left - te->destRect.left) - GetCtlValue(fDocHScroll),
			 (te->viewRect.top - te->destRect.top) - 
			 	(GetCtlValue(fDocVScroll) * te->lineHeight),
			 fDocTE);
} // AdjustTE

// Re-calculate the position and size of the viewRect and the scrollbars.
// kScrollTweek compensates for off-by-one requirements of the scrollbars
// to have borders coincide with the growbox.

void TEDocument::AdjustScrollSizes(void)
{
	Rect teRect;
	
	GetTERect(&teRect);
	(*fDocTE)->viewRect = teRect;
	AdjustViewRect();
	MoveControl(fDocVScroll, fDocWindow->portRect.right - kScrollbarAdjust, -1);
	SizeControl(fDocVScroll, kScrollbarWidth,
				fDocWindow->portRect.bottom - fDocWindow->portRect.top -
					kGrowboxAdjust + kScrollTweek);
	MoveControl(fDocHScroll, -1, fDocWindow->portRect.bottom - kScrollbarAdjust);
	SizeControl(fDocHScroll,
				fDocWindow->portRect.right - fDocWindow->portRect.left -
					kGrowboxAdjust + kScrollTweek,
				kScrollbarWidth);
} // AdjustScrollSizes

// Turn off the controls by jamming a zero into their contrlVis fields (HideControl erases them
// and we don't want that). If the controls are to be resized as well, call the procedure to do that,
// then call the procedure to adjust the maximum and current values. Finally re-enable the controls
// by jamming a $FF in their contrlVis fields (ShowControl re-draws the control, which may not be
// necessary).

void TEDocument::AdjustScrollbars(Boolean needsResize)
{
	// First, turn visibility of scrollbars off so we won’t get unwanted redrawing 
	(*fDocVScroll)->contrlVis = 0;
	(*fDocHScroll)->contrlVis = 0;
	if ( needsResize )
	  AdjustScrollSizes();
	AdjustScrollValues(needsResize);
	// Now, restore visibility in case we never had to draw during adjustment 
	(*fDocVScroll)->contrlVis = 0xff;
	(*fDocHScroll)->contrlVis = 0xff;
} // AdjustScrollbars 

// Calculate the new control maximum value and current value, whether it is the horizontal or
// vertical scrollbar. The vertical max is calculated by comparing the number of lines to the
// vertical size of the viewRect. The horizontal max is calculated by comparing the maximum document
// width to the width of the viewRect. The current values are set by comparing the offset between
// the view and destination rects. If necessary, redraw the control by calling ShowControl.

void TEDocument::AdjustHV(Boolean isVert,Boolean mustRedraw)
{
	short value, lines, max;
	short oldValue, oldMax;
	TEPtr te;
	ControlHandle control;

	if (isVert)
	  control = fDocVScroll;
	else control = fDocHScroll;
	oldValue = GetCtlValue(control);
	oldMax = GetCtlMax(control);
	te = *fDocTE;							// point to TERec for convenience 
	if ( isVert )
	  {
		lines = te->nLines;
		// since nLines isn’t right if the last character is a return, check for that case
		if ( *(*te->hText + te->teLength - 1) == kCrChar )
		  lines += 1;
		max = lines - ((te->viewRect.bottom - te->viewRect.top) /
					   te->lineHeight);
	  }
	else max = kMaxDocWidth - (te->viewRect.right - te->viewRect.left);
	
	if ( max < 0 )
	  max = 0;
	SetCtlMax(control, max);
	
	// Must deref. after SetCtlMax since, technically, it could draw and therefore move
	// memory. This is why we don’t just do it once at the beginning.
	te = *fDocTE;
	if ( isVert )
	  value = (te->viewRect.top - te->destRect.top) / te->lineHeight;
	else value = te->viewRect.left - te->destRect.left;
	
	if ( value < 0 )
	  value = 0;
	else if ( value >  max )
	  value = max;
	
	SetCtlValue(control, value);
	// now redraw the control if asked to or if a setting changed 
	if ( mustRedraw || (max != oldMax) || (value != oldValue) )
		ShowControl(control);
} // AdjustHV

// Simply call the common adjust routine for the vertical and horizontal scrollbars. 

void TEDocument::AdjustScrollValues(Boolean mustRedraw)
{
	AdjustHV(true, mustRedraw);
	AdjustHV(false, mustRedraw);
} // AdjustScrollValues

ClikLoopProcPtr TEDocument::GetClikLoop(void)
{
	return fDocClik;
}

TEHandle TEDocument::GetTEHandle(void)
{
	return fDocTE;
}

void TEDocument::DoCut(void)
{
	long total, contig;

	if (ZeroScrap() == noErr)
	  {
		PurgeSpace(&total, &contig);
		if ((*fDocTE)->selEnd - (*fDocTE)->selStart + kTESlop > contig)
		  AlertUser(kTEDocErrStrings,eNoSpaceCut);
		else
		  {
			TECut(fDocTE);
			if (TEToScrap() != noErr)
			  {
				AlertUser(kTEDocErrStrings,eNoCut);
				(void) ZeroScrap();
			  }
		  }
	  }
	AdjustScrollbars(false);
	AdjustTE();
}

void TEDocument::DoCopy(void)
{
	if ( ZeroScrap() == noErr )
	  {
		TECopy(fDocTE);				// after copying, export the TE scrap
		if ( TEToScrap() != noErr )
		  {
			AlertUser(kTEDocErrStrings,eNoCopy);
			ZeroScrap();
		  }
	  }
	AdjustScrollbars(false);
	AdjustTE();
}

void TEDocument::DoPaste(void)
{
	Handle aHandle;
	long oldSize, newSize;
	OSErr saveErr;

	if ( TEFromScrap() == noErr )
	  {
		if ( TEGetScrapLen() + ((*fDocTE)->teLength -
			 ((*fDocTE)->selEnd - (*fDocTE)->selStart)) > kMaxTELength )
		  AlertUser(kTEDocErrStrings,eExceedPaste);
		else
		  {
			aHandle = (Handle) TEGetText(fDocTE);
			oldSize = GetHandleSize(aHandle);
			newSize = oldSize + TEGetScrapLen() + kTESlop;
			SetHandleSize(aHandle, newSize);
			saveErr = MemError();
			SetHandleSize(aHandle, oldSize);
			if (saveErr != noErr)
			  AlertUser(kTEDocErrStrings,eNoSpacePaste);
			else TEPaste(fDocTE);
		  }
	  }
	else AlertUser(kTEDocErrStrings,eNoPaste);
	AdjustScrollbars(false);
	AdjustTE();
}

void TEDocument::DoClear(void)
{
	TEDelete(fDocTE);
	AdjustScrollbars(false);
	AdjustTE();
}

/*
	Routines used by this class, which don't belong to the class since we use
	them as toolbox filter routines, and you cannot pass class methods as ProcPtrs.
*/

// we refer back to the owning application so that we can get access to
// the document list, to find the current document object.
extern TESample *gTheApplication;

// Common algorithm for pinning the value of a control. It returns the actual amount
// the value of the control changed.

void CommonAction(ControlHandle control,short* amount)
{
	short		value, max;
	
	value = GetCtlValue(control);
	max = GetCtlMax(control);
	*amount = value - *amount;
	if ( *amount <= 0 )
		*amount = 0;
	else if ( *amount >= max )
		*amount = max;
	SetCtlValue(control, *amount);
	*amount = value - *amount;
} // CommonAction 


// Determines how much to change the value of the vertical scrollbar by and how
// much to scroll the TE record.

pascal void VActionProc(ControlHandle control,short part)
{
	short		amount;
	WindowPtr	window;
	TEPtr		te;
	TEDocument* doc;

	if ( part != 0 )
	  {
		window = (*control)->contrlOwner;
		doc = (TEDocument*) (gTheApplication->DocList())->FindDoc(window);
		te = *(doc->GetTEHandle());
		switch ( part )
		  {
			case inUpButton:
			case inDownButton:		// one line 
				amount = 1;
				break;
			case inPageUp:			// one page 
			case inPageDown:
				amount = (te->viewRect.bottom - te->viewRect.top) / te->lineHeight;
				break;
		  }
		if ( (part == inDownButton) || (part == inPageDown) )
			amount = -amount;		// reverse direction for a downer 
		CommonAction(control, &amount);
		if ( amount != 0 )
			TEScroll(0, amount * te->lineHeight, doc->GetTEHandle());
	  }
} // VActionProc 

// Determines how much to change the value of the horizontal scrollbar by and how
// much to scroll the TE record.

pascal void HActionProc(ControlHandle control,short part)
{
	short		amount;
	WindowPtr	window;
	TEPtr		te;
	TEDocument* doc;

	if ( part != 0 )
	  {
		window = (*control)->contrlOwner;
		doc = (TEDocument*) (gTheApplication->DocList())->FindDoc(window);
		te = *(doc->GetTEHandle());
		switch ( part )
		  {
			case inUpButton:
			case inDownButton:		// a few pixels 
				amount = 4;
				break;
			case inPageUp:			// a page 
			case inPageDown:
				amount = te->viewRect.right - te->viewRect.left;
				break;
		  }
		if ( (part == inDownButton) || (part == inPageDown) )
			amount = -amount;		// reverse direction 
		CommonAction(control, &amount);
		if ( amount != 0 )
			TEScroll(amount, 0, doc->GetTEHandle());
	  }
} // VActionProc 

// Gets called from our assembly language routine, AsmClikLoop, which is in
// turn called by the TEClick toolbox routine. Saves the windows clip region,
// sets it to the portRect, adjusts the scrollbar values to match the TE scroll
// amount, then restores the clip region.

pascal void PascalClikLoop(void)
{
	RgnHandle	region;
	WindowPtr wind;
	TEDocument* doc;

	wind = FrontWindow();
	doc = (TEDocument*) (gTheApplication->DocList())->FindDoc(wind);
	region = NewRgn();
	GetClip(region);	// save clip 
	ClipRect(&wind->portRect);
	doc->AdjustScrollValues(false);
	SetClip(region);	// restore clip 
	DisposeRgn(region);
} // PascalClikLoop 

// Gets called from our assembly language routine, AsmClikLoop, which is in
// turn called by the TEClick toolbox routine. It returns the address of the
// default clikLoop routine that was put into the TERec by TEAutoView to
// AsmClikLoop so that it can call it.

pascal ClikLoopProcPtr GetOldClikLoop(void)
{
	TEDocument* doc;

	doc = (TEDocument*) (gTheApplication->DocList())->FindDoc(FrontWindow());
	if (doc == nil)
	  return nil;
	return doc->GetClikLoop();
} // GetOldClikLoop
