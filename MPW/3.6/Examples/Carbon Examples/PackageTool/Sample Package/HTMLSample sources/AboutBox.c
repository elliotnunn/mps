/*
	file AboutBox.c
	
	Description:
	This file contains the routines used to manage the about box window
	displayed when the user chooses 'About HTMLSample...' from the file menu.
	
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

#include "AboutBox.h"

#include <HTMLRendering.h>
#include <Resources.h>
#include <StdDef.h>
#include <string.h>
#include <Sound.h>


enum {
	kAboutBoxWindowID = 129, /* WIND resource ID for the about box. */
	kMaxAboutBoxHeight = 380 /* maximum about box window height */
};

	/* resource type and ID for the about box's contents */
enum {
	kHTMLResourceType = 'HTML',
	kAboutBoxHTMLID = 128
};

	/* variables used by the about box.  there is only
		one about box, so these are allocated as globals */
WindowPtr gAboutBox = NULL;
HRReference gAboutRenderer = NULL;


/* IsAboutBox returns true if the window pointer
	in the aboutBox parameter is not NULL and
	points to the about box. */
Boolean IsAboutBox(WindowPtr aboutBox) {
	return (aboutBox == gAboutBox && aboutBox != NULL);
}


/* OpenAboutBox opens the about box window and returns
	a pointer to the window in *aboutBox.  There can only
	be one about box open at a time, so if the about box is
	already open, then this routine brings it to the front
	by calling SelectWindow before returning a pointer to
	it. */
OSStatus OpenAboutBox(WindowPtr *aboutBox) {
	OSStatus err;
	if (gAboutBox != NULL) {
			/* already showing??? bring it to the front. */
		SelectWindow(gAboutBox);
	} else {
		Point theSize;
		Handle text;
		Rect aboutboxbounds;
		gAboutBox = NULL;
		gAboutRenderer = NULL;
			/* get the window */
		gAboutBox = GetNewCWindow(kAboutBoxWindowID, NULL, (WindowPtr)(-1));
		if (gAboutBox == NULL) { err = resNotFound; goto bail; }
			/* allocate a new rendering object */
		err = HRNewReference(&gAboutRenderer, kHRRendererHTML32Type, GetWindowPort(gAboutBox));
		if (err != noErr) goto bail;
			/* we don't have a grow box in this window */
		err = HRSetGrowboxCutout(gAboutRenderer, false);
		if (err != noErr) goto bail;
			/* we only want a vertical scroll bar */
		err = HRSetScrollbarState(gAboutRenderer, eHRScrollbarOff, eHRScrollbarAuto);
		if (err != noErr) goto bail;
			/* set the bounds for the rendering object */
		SetPortWindowPort(gAboutBox);
		GetPortBounds(GetWindowPort(gAboutBox), &aboutboxbounds);
		err = HRSetRenderingRect(gAboutRenderer, &aboutboxbounds);
		if (err != noErr) goto bail;
			/* get the HTML data we want to draw in the window */
		text = GetResource(kHTMLResourceType, kAboutBoxHTMLID);
		if (text == NULL) { err = resNotFound; goto bail; }
			/* put the data into the rendering object */
		MoveHHi(text);
		HLock(text);
		err = HRGoToPtr(gAboutRenderer, *text, GetHandleSize(text), false, false);
		HUnlock(text);
		if (err != noErr) goto bail;
			/* find out the 'best' rectangle for displaying the data */
		err = HRGetRenderedImageSize(gAboutRenderer, &theSize);
		if (err != noErr) goto bail;
			/* adjust the window's size, constraining it by the
			maximum size */
		if (theSize.v > kMaxAboutBoxHeight) theSize.v = kMaxAboutBoxHeight;
		SizeWindow(gAboutBox, theSize.h+16, theSize.v, false);
		SetPortWindowPort(gAboutBox);
			/* adjust the rendering object's size to the window's size */
		err = HRSetRenderingRect(gAboutRenderer, &aboutboxbounds);
		if (err != noErr) goto bail;
			/* show the window */
		ShowWindow(gAboutBox);
	}
		/* done, return the window pointer */
	*aboutBox = gAboutBox;
	return noErr;
bail:
	if (gAboutRenderer != NULL) { HRDisposeReference(gAboutRenderer); gAboutRenderer = NULL; }
	if (gAboutBox) { DisposeWindow(gAboutBox); gAboutBox = NULL; }
	return err;
}


/* AboutBoxCloseWindow closes the about box window. 
	this routine deallocates any structures allocated
	by the OpenAboutBox. */
void AboutBoxCloseWindow(WindowPtr aboutBox) {
	if (IsAboutBox(aboutBox)) { 
		HRDisposeReference(gAboutRenderer);
		gAboutRenderer = NULL;
		DisposeWindow(gAboutBox);
		gAboutBox = NULL;
	}
}


/* EnsureAboutBoxIsClosed closes the about box window
	if it is open.  If it is not open then this routine does
	nothing. */
void EnsureAboutBoxIsClosed(void) {
	if (gAboutBox != NULL) 
		AboutBoxCloseWindow(gAboutBox);
}


/* AboutBoxUpdate should be called for update events
	directed at the about box window.  It calls
	BeginUpdate and EndUpdate and does all of the
	drawing required to refresh the about box window. */
void AboutBoxUpdate(WindowPtr aboutBox) {
	if (IsAboutBox(aboutBox)) {
		RgnHandle windowVisibleRgn;
		GetPortVisibleRegion(GetWindowPort(aboutBox), (windowVisibleRgn = NewRgn()));
		SetPortWindowPort(gAboutBox);
		BeginUpdate(gAboutBox);
		HRDraw(gAboutRenderer, windowVisibleRgn);
		EndUpdate(gAboutBox);
		DisposeRgn(windowVisibleRgn);
	}
}


/* AboutBoxActivate should be called for activate events
	directed at the about box window. */
void AboutBoxActivate(WindowPtr aboutBox, Boolean activate) {
	if (IsAboutBox(aboutBox)) {
		SetPortWindowPort(gAboutBox);
		if (activate)
			HRActivate(gAboutRenderer);
		else HRDeactivate(gAboutRenderer);
	}
}

