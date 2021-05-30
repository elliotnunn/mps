/*
	file SampleUtils.c
	
	Description:
	This file contains a number of utility routines used by the
	HTMLSampleApplication.  These routines have been moved
	here to a separate file to simplify the example.
	
	HTMLSample is an application illustrating how to use the new
	HTMLRenderingLib services found in Mac OS 9. HTMLRenderingLib
	is Apple's light-weight HTML rendering engine capable of
	displaying HTML files.

	by John Montbriand, 1999.

	Copyright: © 1999 by Apple Computer, Inc.
	All rights reserved.
	
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

#include "SampleUtils.h"
#include <Processes.h>
#include <string.h>
#include <QuickDraw.h>
#include <Gestalt.h>
#include <Palettes.h>
#include <Resources.h>
#include <TextUtils.h>

#include <HTMLRendering.h>


/* SUstrlen Sample Utilities strlen.  Here so we don't have to link
	with the standard C libraries. */
long SUstrlen(char const* stt) {
	long count;
	char const* rover;
	for (count = 0, rover = stt; *rover; rover++, count++)
		/* empty loop */;
	return count;
}

/* SUstrcmp Sample Utilities strcmp.  Here so we don't have to link
	with the standard C libraries. */
long SUstrcmp(char const* a, char const* b) {
	long res;
	char const *aa, *bb;
	aa = a;
	bb = b;
	while (*aa && *bb)
		if ((res = (*aa++ - *bb++)) != 0)
			return res;
	return (*aa - *bb);
}

/* SetWindowStandardStateSize sets the window's standard state rectangle
	to a rectangle of the size suggested in the width and height parameters.
	In the end, it may set the standard size to something smaller than the
	width and height parameters so the entire window remains visible.  The
	standard rectangle is also centered on the main screen.  The window's
	standard state rectangle is used by ZoomWindow whenever when it
	is called with the inZoomOut partcode. */
void SetWindowStandardStateSize(WindowPtr window, short width, short height) {
	Rect standard, stdRect, global, device, c, s, diffs;
	RgnHandle tempRgn;
	GDHandle theDevice;
	CGrafPtr wport;
	Point origin;
		/* make the window's port the current port */
	wport = GetWindowPort(window);
	SetPort(wport);
	SetPt(&origin, 0, 0);
	LocalToGlobal(&origin);
		/* find the window's global coordinates */
	GetPortBounds(wport, &global);
	OffsetRect(&global, origin.h, origin.v);
		/* get the maximum intersecting screen */
	theDevice = GetMaxDevice(&global);
	device = (**theDevice).gdRect;
		/* if it's the main screen, adjust it for the menu bar height */
	if (theDevice == GetMainDevice())
		device.top += GetMBarHeight();
		/* calculate the difference between the window's content rectangle and its frame */
	tempRgn = NewRgn();
	GetWindowRegion(window, kWindowContentRgn, tempRgn);
	GetRegionBounds(tempRgn, &c);
	GetWindowRegion(window, kWindowStructureRgn, tempRgn);
	GetRegionBounds(tempRgn, &s);
	DisposeRgn(tempRgn);
	SetRect(&diffs, c.left - s.left + 2, c.top - s.top + 2, s.right - c.right + 2, s.bottom - c.bottom + 2);
		/* calculate the maximum bounds for the standard rectangle */
	SetRect(&standard, device.left + diffs.left, device.top + diffs.top, device.right - diffs.right, device.bottom - diffs.bottom);
		/* set up our 'desired' rectangle */
	SetRect(&stdRect, 0, 0, width, height);
	OffsetRect(&stdRect, standard.left, standard.top);
		/* fit it inside of the maximum allowable rectangle */
	SectRect(&stdRect, &standard, &stdRect);
		/* center it in the maximum allowable rectangle */
	OffsetRect(&stdRect, (standard.right - stdRect.right)/2, (standard.bottom - stdRect.bottom)/2);
		/* set the standard state rectangle */
	SetWindowStandardState(window, &stdRect);
}



/* GetApplicationFolder returns a URL referring to the folder
	containing the application.  If successful, *url is set
	to a new handle containing the URL.  It is the caller's
	responsibility to dispose of this handle. */
OSStatus GetApplicationFolderURL(Handle *url) {
	OSStatus err;
	FSSpec spec;
	Handle theURL;
		/* set up locals to a known state */
	theURL = NULL;
		/* find the application's folder */ 
	err = GetApplicationFolder(&spec);
	if (err != noErr) goto bail;
		/* create a new handle for storing the URL */
	theURL = NewHandle(0);
	if (theURL == NULL) { err = memFullErr; goto bail; }
		/* ask the HTML rendering library to convert
		the FSSpec into a URL */
	err = HRUtilGetURLFromFSSpec(&spec, theURL);
	if (err != noErr) goto bail;
	
		/* add a slash at the end of the name, if one is not there */
	if ( (*theURL)[GetHandleSize(theURL) - 1] != '/')
		Munger(theURL, (GetHandleSize(theURL) - 1), NULL, 0, "/", 1);

		/* return the URL */
	*url = theURL;
	return noErr;
bail:
	if (theURL != NULL) DisposeHandle(theURL);
	return err;
}


/* GetApplicationFolder returns the volume reference number and
	directory id of the folder containing the application. */
OSStatus GetApplicationFolder(FSSpec *spec) {
	OSStatus err;
	FCBPBRec fcpb;
	Str255 name;
	CInfoPBRec cat;
	Handle h;
	
	h = GetResource('vTeZ', 0);
	if (h == NULL) return resNotFound;
	
	BlockZero(&fcpb, 0);
	fcpb.ioVRefNum = 0;
	fcpb.ioNamePtr = name;
	fcpb.ioFCBParID = 0;
	fcpb.ioRefNum = HomeResFile(h);
	fcpb.ioFCBIndx = 0;
	if ((err = PBGetFCBInfoSync(&fcpb)) != noErr) return err;
	
	BlockZero(&cat, 0);
	cat.dirInfo.ioNamePtr = name;
	cat.dirInfo.ioVRefNum = fcpb.ioFCBVRefNum;
	cat.dirInfo.ioFDirIndex = -1;
	cat.dirInfo.ioDrDirID = fcpb.ioFCBParID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return err;
	
	err = FSMakeFSSpec(fcpb.ioFCBVRefNum, cat.dirInfo.ioDrParID, name, spec);
	if (err != noErr) return err;
	
	return noErr;
}

/* DrawGrowIconWithoutScrollLines draws the grow icon in the bottom
	right corner of the frontmost window without drawing the scroll bar
	lines.  It does this by setting the clip region to the bottom right corner
	before calling DrawGrowIcon. */
void DrawGrowIconWithoutScrollLines(WindowPtr window) {
	RgnHandle clip;
	CGrafPtr wport;
	Rect r = { 0, 0, 16, 16 }, pbox;
		/* set the window to the current port */
	wport = GetWindowPort(window);
	SetPort(wport);
	GetPortBounds(wport, &pbox);
		/* save the old clipping region */
	clip = NewRgn();
	if (clip == NULL) return;
	GetClip(clip);
		/* set the clipping region to the bottom right corner of the window */
	OffsetRect(&r, pbox.right-15, pbox.bottom-15);
	ClipRect(&r);
		/* draw the grow icon */
	DrawGrowIcon(window);
	SetPort(wport);
	SetClip(clip);
	DisposeRgn(clip);
}




/* GrayOutBox grays out an area of the screen in the current grafport.  
	*theBox is in local coordinates in the current grafport. This routine
	is for direct screen drawing only.  */
void GrayOutBox(Rect *theBox) {
	long response;
	Rect globalBox;
	GDHandle maxDevice;
	RGBColor rgbWhite = {0xFFFF, 0xFFFF, 0xFFFF}, rgbBlack = {0, 0, 0}, sForground, sBackground;
	PenState penSave;
	Pattern qdgray, qdblack;
		/* save the current drawing state */
	GetPenState(&penSave);
		/* if no color quickdraw, fail...*/
	if (Gestalt(gestaltQuickdrawVersion, &response) != noErr) response = 0;
	if (response >= gestalt8BitQD) {
			/* get the device for the rectangle */
		globalBox = *theBox;
		LocalToGlobal((Point*) &globalBox.top);
		LocalToGlobal((Point*) &globalBox.bottom);
		maxDevice = GetMaxDevice(&globalBox);
		if (maxDevice != NULL) {
				/* calculate the best gray */
			if ( GetGray(maxDevice, &rgbWhite, &rgbBlack)) {
					/* draw over the area in gray using addMax transfer mode */
				GetForeColor(&sForground);
				GetBackColor(&sBackground);
				RGBForeColor(&rgbBlack);
				RGBBackColor(&rgbWhite);
				PenMode(addMax);
				PenPat(GetQDGlobalsBlack(&qdblack));
				PaintRect(theBox);
				RGBForeColor(&sForground);
				RGBBackColor(&sBackground);
					/* restore the pen state and leave */
				SetPenState(&penSave);
				return;
			}
		}
	}
		/* fall through to using the gray pattern */
	GetQDGlobalsGray(&qdgray);
	PenPat(&qdgray);
	PenMode(notPatBic);
	PaintRect(theBox);
	SetPenState(&penSave);
}
