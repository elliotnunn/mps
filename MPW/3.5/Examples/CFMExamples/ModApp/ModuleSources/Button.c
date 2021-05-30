/*
	File:		Button.c

	Contains:	simple button plug-in.

	Written by:	Richard Clark

	Copyright:	© 1993-1994, 1998 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

		   06/10/98		GAB		compatible with 3.1 interfaces
			8/15/94		BLS		updated to CFM-68K runtime

*/


#ifdef THINK_C
	#define ToolStartup main
#endif

#ifndef __TYPES__
	#include <Types.h>
#endif

#ifndef __QUICKDRAW__
	#include <Quickdraw.h>
#endif

#ifndef __CONTROLS__
	#include <Controls.h>
#endif

#ifndef __RESOURCES__
	#include <Resources.h>
#endif

#ifndef __FILES__
	#include <Files.h>
#endif

#ifndef __MIXEDMODE__
	#include <MixedMode.h>
#endif

#ifndef __SOUND__
	#include <Sound.h>
#endif

#include "ToolAPI.h"
#include "ModApp.h"

enum {
	rMyButton = 1001
	};

// === Public routines

OSErr ToolStartup (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	OSErr				err = noErr;
	ControlHandle		myButton;
	short				refNum;
	
	// Don't bother adding anything to the tool window's block, as we don't have any private info
	aWindow->toolRoutines.shutdownProc = ToolShutdown;
	aWindow->toolRoutines.menuAdjustProc = NULL;
	aWindow->toolRoutines.menuDispatchProc = NULL;
	aWindow->toolRoutines.toolIdleProc = NULL;
	aWindow->toolRoutines.toolUpdateProc = ToolUpdate;
	aWindow->toolRoutines.toolClickProc = ToolWindowClick;
	aWindow->toolRoutines.toolWindowMovedProc = NULL;
	aWindow->toolRoutines.toolWindowResizedProc = NULL;
	aWindow->toolRoutines.toolWindowActivateProc = NULL;

	// Add our button
	SetPort(wp);
	EraseRect(&wp->portRect);
	refNum = FSpOpenResFile(&aWindow->toolSpec, fsCurPerm);
	err = ResError();
	if (err) goto error;
	myButton = GetNewControl(rMyButton, wp);
	CloseResFile(refNum);

error:
	return err;
}


void ToolShutdown (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;

	DisposeControl((ControlHandle) ((WindowPeek)wp)->controlList);
}


void ToolMenuAdjust (WindowPtr wp)
{
	#pragma unused(wp)
}


void ToolMenuDispatch (WindowPtr wp, short menuID, short itemID)
{
	#pragma unused(wp, menuID, itemID)
}


void ToolIdle (WindowPtr wp)
{
	#pragma unused(wp)
}


void ToolUpdate (WindowPtr wp)
{
	DrawControls(wp);	
}


void ToolWindowClick(WindowPtr wp, EventRecord *theEvent)
{
	Point			globalPt = theEvent->where;
	Point			localPt;
	ControlHandle	theControl;
	int16			partCode;
	
	SetPort(wp);
	localPt = globalPt; GlobalToLocal(&localPt);
	partCode = FindControl(localPt, wp, &theControl);
	if (partCode) {
		partCode = TrackControl(theControl, localPt, NULL);
		if (partCode) {
			SysBeep(3);
			SysBeep(3);
			SysBeep(3);
		}
	}
}


void ToolWindowMoved(WindowPtr wp)
{
	#pragma unused(wp)
}


void ToolWindowResized(WindowPtr wp)
{
	#pragma unused(wp)
}


void ToolWindowActivate(WindowPtr wp, Boolean activeFlag)
{
	#pragma unused(wp, activeFlag)
}
