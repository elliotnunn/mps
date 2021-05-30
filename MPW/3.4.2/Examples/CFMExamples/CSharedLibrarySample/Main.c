//
//	Main.c - main body of simple C program
//
//
//	Copyright © 1993, 1994, Apple Computer, Inc.  All rights reserved.
//

#include "SharedLib.h"  


static WindowPtr	gWindow;
static Rect			gRect;

QDGlobals	qd;

void main ()
{
		
	InitGraf (&qd.thePort);
	InitFonts ();
	InitWindows ();
	InitCursor ();
	SetRect (&gRect, 100, 100, 400, 200);
	gWindow = NewWindow (NULL, &gRect, (ConstStr255Param)"\pSharedLibExample", true, rDocProc,
	                     (WindowPtr)-1, false, 0);
	DoMessage(gWindow);	
}
