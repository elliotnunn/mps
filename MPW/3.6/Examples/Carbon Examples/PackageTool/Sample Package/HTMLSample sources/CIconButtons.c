/*
	file CIconButtons.c
	
	Description:
	This file contains routines used to implement the color icon buttons
	displayed in the top of HTMLSample's windows.
	
	HTMLSample is an application illustrating how to use the new
	HTMLRenderingLib services found in Mac OS 9. HTMLRenderingLib
	is Apple's light-weight HTML rendering engine capable of
	displaying HTML files.

	by John Montbriand, 1999.

	Copyright: © 1999 by Apple Computer, Inc.
	all rights reserved.
	
	Disclaimer:
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "DSC Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.
	
	Change History (most recent first):
	10/16/99 created by John Montbriand
*/

#include "CIconButtons.h"
#include "SampleUtils.h"
#include <QuickDraw.h>
#include <Icons.h>
#include <Events.h>
#include <Resources.h>
#include <string.h>



/* NewCIconButton retrieves a new color icon button
	resource from the resource file.  the id number
	corresponds to the resource id of the CICB resource. */
CIconButtonHandle NewCIconButton(short id) {
	Handle theRsrc;
	theRsrc = GetResource(kIconButtonType, id);
		/* here, we call detach resource because we
		may have many windows open with many buttons
		each having a different state. */
	if (theRsrc != NULL) DetachResource(theRsrc);
	return (CIconButtonHandle) theRsrc;
}


/* DisposeCIconButton disposes of any structures allocated
	for the color icon button allocated by NewCIconButton. */
void DisposeCIconButton(CIconButtonHandle cicb) {
	DisposeHandle((Handle) cicb);
}



/* GetCIconButtonStringData returns a new handled containing
	the string data copied from the color icon resource.  The
	handle will contain a C-style string terminated with a zero
	byte.  It is the caller's responsibility to dispose of this
	handle after it has been used. */
OSErr GetCIconButtonStringData(CIconButtonHandle cicb, Handle *strdata) {
	char handstate;
	OSErr err;
	handstate = HGetState((Handle) cicb);
	HLock((Handle) cicb);
	err = PtrToHand((**cicb).stringdata, strdata, SUstrlen((**cicb).stringdata) + 1);
	HSetState((Handle) cicb, handstate);
	return err;
}


/* SetCIconButtonPosition sets the color icon button's 
	screen postion. h and v are coordinates in the
	current grafport. */
void SetCIconButtonPosition(CIconButtonHandle cicb, short h, short v) {
	char handstate;
	handstate = HGetState((Handle) cicb);
	HLock((Handle) cicb);
	OffsetRect(&(**cicb).bounds, h - (**cicb).bounds.left, v - (**cicb).bounds.top);
	HSetState((Handle) cicb, handstate);
}


/* DrawCIconButton draws the icon button using the
	as it should appear given the state specified.  state
	should be either kCBdisabled, kCBup, or kCBdown.
	The last state a button is drawn in affects the
	result of TrackCIconButton. */
void DrawCIconButton(CIconButtonHandle cicb, short state) {
	CIconHandle theIcon;
	char handstate;
	handstate = HGetState((Handle) cicb);
	HLock((Handle) cicb);
	theIcon = GetCIcon((**cicb).cicnIDs[state]);
	if (theIcon != NULL) {
		PlotCIcon(&(**cicb).bounds, theIcon);
		DisposeCIcon(theIcon);
	}
	(**cicb).drawnstate = state;
	HSetState((Handle) cicb, handstate);
}


/* TrackCIconButton should be called whenever a click is made
	inside of a color icon button.  if the last time the button
	was drawn its state was not kCBup or the click is outside
	of the button, then this routine returns false. */
Boolean TrackCIconButton(CIconButtonHandle cicb, Point where) {
	Boolean result;
	char handstate;
	handstate = HGetState((Handle) cicb);
	HLock((Handle) cicb);
	if ((**cicb).drawnstate == kCBdisabled) {
		result = false;
	} else if (PtInRect(where, &(**cicb).bounds)) {
		Boolean isin, ishilited;
		Point mouseLoc;
		isin = true;
		ishilited = true;
		mouseLoc = where;
		DrawCIconButton(cicb, kCBdown);
		while (StillDown()) {
			GetMouse(&mouseLoc);
			isin = PtInRect(mouseLoc, &(**cicb).bounds);
			if (isin != ishilited) {
				ishilited = isin;
				DrawCIconButton(cicb, ishilited ? kCBdown : kCBup);
			}
		}
		result = ishilited;
	} else result = false;
	HSetState((Handle) cicb, handstate);
	return result;
}
