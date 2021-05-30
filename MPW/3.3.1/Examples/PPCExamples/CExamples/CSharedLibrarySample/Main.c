//
//	Main.c - main body of simple C program
//
//
//	Copyright © 1993, Apple Computer, Inc.  All rights reserved.
//

#include "SharedLib.h"  

extern void DoMessage (WindowPtr);

static WindowPtr	gWindow;
static Rect			gRect;

#ifdef powerc
   static QDGlobals	qd;
#endif

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
