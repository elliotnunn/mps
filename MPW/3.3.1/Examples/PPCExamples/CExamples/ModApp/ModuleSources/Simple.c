// File: Simple.c

#ifdef THINK_C
	#define ToolStartup main
#endif

#ifndef __TYPES__
	#include <Types.h>
#endif

#ifndef __QUICKDRAW__
	#include <Quickdraw.h>
#endif

#ifndef __MIXEDMODE__
	#include <MixedMode.h>
#endif

#include "ToolAPI.h"
#include "ModApp.h"


// === Public routines

OSErr ToolStartup (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	
	// Don't bother adding anything to the tool window's block, as we don't have any private info
	aWindow->toolRoutines.shutdownProc = NULL;
	aWindow->toolRoutines.menuAdjustProc = NULL;
	aWindow->toolRoutines.menuDispatchProc = NULL;
	aWindow->toolRoutines.toolIdleProc = NULL;
	aWindow->toolRoutines.toolUpdateProc = NewToolUpdateProc(ToolUpdate);
	aWindow->toolRoutines.toolClickProc = NULL;
	aWindow->toolRoutines.toolWindowMovedProc = NULL;
	aWindow->toolRoutines.toolWindowResizedProc = NULL;
	aWindow->toolRoutines.toolWindowActivateProc = NULL;

	return noErr;
}


void ToolShutdown (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;

	DisposeRoutineDescriptor(aWindow->toolRoutines.toolUpdateProc);
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
	Rect	scratch = wp->portRect;
	
	InsetRect(&scratch, 10, 10);
	InvertRect(&scratch);
}


void ToolWindowClick(WindowPtr wp, EventRecord *theEvent)
{
	#pragma unused(wp, theEvent)
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
