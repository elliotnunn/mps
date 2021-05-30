/*
	file SampleUtils.h
	
	Description:
	This file contains routine prototypes that can be used to access
	routines defined in SampleUtils.c.  These routines have been moved
	here to a separate file to simplify the example.
	
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

#ifndef __SAMPLEUTILS__
#define __SAMPLEUTILS__

#include <Types.h>
#include <Windows.h>

/* GetApplicationFolder returns the volume reference number and
	directory id of the folder containing the application. */
OSStatus GetApplicationFolder(FSSpec *spec);

/* GetApplicationFolder returns a URL referring to the folder
	containing the application.  If successful, *url is set
	to a new handle containing the URL.  It is the caller's
	responsibility to dispose of this handle. */
OSStatus GetApplicationFolderURL(Handle *url);

/* DrawGrowIconWithoutScrollLines draws the grow icon in the bottom
	right corner of the frontmost window without drawing the scroll bar
	lines.  It does this by setting the clip region to the bottom right corner
	before calling DrawGrowIcon. */
void DrawGrowIconWithoutScrollLines(WindowPtr window);

/* SetWindowStandardStateSize sets the window's standard state rectangle
	to a rectangle of the size suggested in the width and height parameters.
	In the end, it may set the standard size to something smaller than the
	width and height parameters so the entire window remains visible.  The
	standard rectangle is also centered on the main screen.  The window's
	standard state rectangle is used by ZoomWindow whenever when it
	is called with the inZoomOut partcode. */
void SetWindowStandardStateSize(WindowPtr window, short width, short height);

/* GrayOutBox grays out an area of the screen in the current grafport.  
	*theBox is in local coordinates in the current grafport. This routine
	is for direct screen drawing only.  */
void GrayOutBox(Rect *theBox);

/* SUstrlen Sample Utilities strlen.  Here so we don't have to link
	with the standard C libraries. */
long SUstrlen(char const* stt);

/* SUstrcmp Sample Utilities strcmp.  Here so we don't have to link
	with the standard C libraries. */
long SUstrcmp(char const* a, char const* b);

#endif