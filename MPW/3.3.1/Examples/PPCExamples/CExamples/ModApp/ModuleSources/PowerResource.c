// File: Simple.c

#ifdef THINK_C
	#define ToolStartup main
#endif

#ifndef __TYPES__
	#include <Types.h>
#endif

#ifndef __MEMORY__
	#include <Memory.h>
#endif

#ifndef __LOWMEM__
	#include <LowMem.h>
#endif

#ifndef __QUICKDRAW__
	#include <Quickdraw.h>
#endif

#ifndef __FILES__
	#include <Files.h>
#endif

#ifndef __RESOURCES__
	#include <Resources.h>
#endif

#ifndef __TEXTUTILS__
	#include <TextUtils.h>
#endif

#ifndef __TEXTEDIT__
	#include <TextEdit.h>
#endif

#ifndef __MIXEDMODE__
	#include <MixedMode.h>
#endif

#include "ToolAPI.h"
#include "ModApp.h"

struct ToolPrivateData {
	Str255		message;
};

typedef struct ToolPrivateData ToolData, *ToolDataPtr;

// === Public routines

OSErr ToolStartup (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = NULL;
	OSErr				err = noErr;
	short				refNum;
	
	aWindow->toolRoutines.shutdownProc = NULL;
	aWindow->toolRoutines.menuAdjustProc = NULL;
	aWindow->toolRoutines.menuDispatchProc = NULL;
	aWindow->toolRoutines.toolIdleProc = NULL;
	aWindow->toolRoutines.toolUpdateProc = NewToolUpdateProc(ToolUpdate);
	aWindow->toolRoutines.toolClickProc = NULL;
	aWindow->toolRoutines.toolWindowMovedProc = NULL;
	aWindow->toolRoutines.toolWindowResizedProc = NULL;
	aWindow->toolRoutines.toolWindowActivateProc = NULL;

	// Allocate our private storage
	privateData = (ToolDataPtr)NewPtr(sizeof(ToolData));
	if (err = MemError()) goto error;

	// Get the appropriate message
	refNum = FSpOpenResFile(&aWindow->toolSpec, fsCurPerm);
	if (err = ResError()) goto error;
#ifdef powerc
	GetIndString(&privateData->message, 128, 1);
#else
	GetIndString(&privateData->message, 128, 2);
#endif
	CloseResFile(refNum);
	
	goto noError;

error:
	if (privateData)
		DisposPtr((Ptr)privateData);
	return err;

noError:
	aWindow->toolRefCon = (long)privateData;
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
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	Rect				scratch = wp->portRect;
	
	SetPort(wp);
	InsetRect(&scratch, 10, 10);
	TextFont(1);
	TextFace(0);
	TextFont(0);
	MoveTo(2, 14);
	DrawString((StringPtr)privateData->message);
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
