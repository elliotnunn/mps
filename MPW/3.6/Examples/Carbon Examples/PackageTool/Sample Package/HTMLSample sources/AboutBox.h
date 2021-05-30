/*
	file AboutBox.h
	
	Description:
	This file contains the routine prototypes for calls defined in AboutBox.c
	These routines are used to manage the about box window displayed when
	the user chooses 'About HTMLSample...' from the file menu.
	
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


#ifndef __ABOUTBOX__
#define __ABOUTBOX__

#include <Types.h>
#include <Windows.h>


/* OpenAboutBox opens the about box window and returns
	a pointer to the window in *aboutBox.  There can only
	be one about box open at a time, so if the about box is
	already open, then this routine brings it to the front
	by calling SelectWindow before returning a pointer to
	it. */
OSStatus OpenAboutBox(WindowPtr *aboutBox);


/* EnsureAboutBoxIsClosed closes the about box window
	if it is open.  If it is not open then this routine does
	nothing. */
void EnsureAboutBoxIsClosed(void);


/* AboutBoxUpdate should be called for update events
	directed at the about box window.  It calls
	BeginUpdate and EndUpdate and does all of the
	drawing required to refresh the about box window. */
void AboutBoxUpdate(WindowPtr aboutBox);


/* AboutBoxActivate should be called for activate events
	directed at the about box window. */
void AboutBoxActivate(WindowPtr aboutBox, Boolean activate);


/* AboutBoxCloseWindow closes the about box window. 
	this routine deallocates any structures allocated
	by the OpenAboutBox. */
void AboutBoxCloseWindow(WindowPtr aboutBox);


/* IsAboutBox returns true if the window pointer
	in the aboutBox parameter is not NULL and
	points to the about box. */
Boolean IsAboutBox(WindowPtr aboutBox);


#endif

