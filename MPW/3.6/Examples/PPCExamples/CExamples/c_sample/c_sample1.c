/*
 *	c_sample1 - main body of simple C program
 *
 *
 *	Copyright © 1993, 1994 Apple Computer, Inc.  All rights reserved.
 */

#include "c_sample.h"

static WindowPtr	gWindow;
static Rect			gRect;

static QDGlobals	qd;

void main ()
{
	
	InitGraf (&qd.thePort);
	InitFonts ();
	InitWindows ();
	InitCursor ();
	SetRect (&gRect, 100, 100, 400, 200);
	gWindow = NewWindow (NULL, &gRect, (unsigned char*)APP_NAME_STRING, true, rDocProc,
	                     (WindowPtr)-1, false, 0);
	showMessage (gWindow);
	myPause();
}