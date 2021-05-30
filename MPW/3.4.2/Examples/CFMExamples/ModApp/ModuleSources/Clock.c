/*
	File:		Clock.c

	Contains:	A simple analog clock

	Written by:	Richard Clark

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 8/15/94    BLS		Updated for CFM-68K.  Return ProcPtrs instead of UPPs.

				 2/16/94	RC		Added code in ToolIdle() to see if the GWorld has been
				 					purged.
				 1/27/94	RC		Changed initialization code so that not getting a buffer isn't
				 					fatal anymore.
				 1/14/94	RC		Added code to set the fg color to black before drawing the frame

	To Do:
*/

// File: ClockTool.c

#ifdef THINK_C
	#define ToolStartup main
#endif

#ifndef __MEMORY__
	#include <Memory.h>
#endif

#ifndef __RESOURCES__
	#include <Resources.h>
#endif

#ifndef __MENUS__
	#include <Menus.h>
#endif

#ifndef __OSUTILS__
	#include <OSUtils.h>	// For Secs2Date, used in our Idle routine
#endif

#ifndef __FIXMATH__
	#include <FixMath.h>	// For fixed-point math routines, used in drawing the clock face
#endif

#ifndef __TOOLUTILS__
	#include <ToolUtils.h>	// For fixed-point math routines, used in drawing the clock face
#endif

#include "GWorldTools.h"
#include "ToolAPI.h"
#include "ModApp.h"

struct ToolPrivateData {
	GWorldPtr		buffer;
	unsigned long	lastUpdate;		// What time did we last update the clock (seconds)
	Rect			bodyRect;		// The bounds of our clock face
	Point			centerPt;		// The center of our clock face
	Boolean			showSeconds;
	RGBColor		hourColor;
	RGBColor		minuteColor;
	RGBColor		secondColor;
};

typedef struct ToolPrivateData ToolData, *ToolDataPtr;

enum {
	// Menu information
	kToolMenu = 2001,
	// --- Commands
	kShowSeconds = 1
};

// === Prototypes for utility routines (at the end of the file)
static Rect GetBodyRect (Rect thePortRect);
static void AngleToPoint (short angle, short radius, Point center, Point *result);
static void PaintHand (short baseAngle, short length, short decorAngle, short decorLength, Point centerPt);

// === Public routines

OSErr ToolStartup (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	OSErr				err = noErr;
	ToolDataPtr			privateData = NULL;
	Rect				bodyRect, globalBounds;
	MenuHandle			privateMenu;
	short				refNum;
	
	aWindow->toolRoutines.shutdownProc = ToolShutdown;
	aWindow->toolRoutines.menuAdjustProc = ToolMenuAdjust;
	aWindow->toolRoutines.menuDispatchProc = ToolMenuDispatch;
	aWindow->toolRoutines.toolIdleProc = ToolIdle;
	aWindow->toolRoutines.toolUpdateProc = ToolUpdate;
	aWindow->toolRoutines.toolClickProc = ToolWindowClick;
	aWindow->toolRoutines.toolWindowMovedProc = ToolWindowMoved;
	aWindow->toolRoutines.toolWindowResizedProc = ToolWindowResized;
	aWindow->toolRoutines.toolWindowActivateProc = ToolWindowActivate;

	// Allocate our private storage
	privateData = (ToolDataPtr)NewPtrClear(sizeof(ToolData));
	err = MemError();
	if (err) goto error;

	// Allocate an offscreen buffer
	globalBounds = GetGlobalBounds(wp);
	err = AllocateBuffer (wp, globalBounds, &privateData->buffer, false);
	// Don't abort on an error, since that just means we didn't get a buffer
	
	// Set other local variables
	bodyRect = GetBodyRect(wp->portRect);
	privateData->bodyRect = bodyRect;
	privateData->centerPt.h = (bodyRect.left + bodyRect.right) / 2;
	privateData->centerPt.v = (bodyRect.top + bodyRect.bottom) / 2;
	privateData->showSeconds = true;
	privateData->lastUpdate = 0;
	
	privateData->hourColor.red = 0x0000;
	privateData->hourColor.green = 0x5A00;
	privateData->hourColor.blue = 0xFFFF;
	
	privateData->minuteColor.red = 0x0B00;
	privateData->minuteColor.green = 0x0B00;
	privateData->minuteColor.blue = 0xFFFF;
	
	privateData->secondColor.red = 0xFFFF;
	privateData->secondColor.green = 0x0000;
	privateData->secondColor.blue = 0x0000;
	
	// Add our menu
	refNum = FSpOpenResFile(&aWindow->toolSpec, fsCurPerm);
	err = ResError();
	if (err) goto error;
	privateMenu = GetMenu(kToolMenu);
	DetachResource((Handle)privateMenu);
	InsertMenu(privateMenu, 0);
	DrawMenuBar();
	CloseResFile(refNum);
	
	goto noError;

error:
	if (privateData) {
		if (privateData->buffer)
			DisposeBuffer(&privateData->buffer);
		DisposPtr((Ptr)privateData);
	}
	return err;

noError:
	aWindow->toolRefCon = (long)privateData;
	return noErr;
}


void ToolShutdown (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	
	if (privateData) {
		if (privateData->buffer)
			DisposeBuffer(&privateData->buffer);
		DisposPtr((Ptr)privateData);
	}

}


void ToolMenuAdjust (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;

	CheckItem(GetMHandle(kToolMenu), kShowSeconds, privateData->showSeconds);
}


void ToolMenuDispatch (WindowPtr wp, short menuID, short itemID)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	
	if ((menuID == kToolMenu) && (itemID == kShowSeconds))
			privateData->showSeconds = !privateData->showSeconds;
}


void ToolIdle (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	OSErr				bufError;
	unsigned long		currTime;
	DateTimeRec			now;
	CGrafPtr			oldPort;
	GDHandle			oldDevice;
	GWorldFlags 		oldPixState;

	// Values used in drawing the clock face
	short				hour;
	short				radius, handLength;
	Point				startPt, endPt;
	Point				centerPt;

	GetDateTime(&currTime);
	if (currTime > privateData->lastUpdate) {	// <<< Need to update less frequently if the second hand is off

		if (privateData->buffer != NULL) {
			bufError = LockBuffer (privateData->buffer, &oldPixState);
			// Was our buffer purged?
			if (bufError == kPixelsPurged) {
				// try to reallocate and lock the buffer
				OSErr err2;
				err2 = UpdateBuffer(wp, &privateData->buffer);
				if (err2 == noErr) 
					bufError = LockBuffer (privateData->buffer, &oldPixState);
			}
			// An error should only happen if the buffer couldn't be locked down
			// or was purged and cannot be reallocated. In that case, we'll draw
			// without buffering
			if (bufError == noErr) {
				GetGWorld(&oldPort,&oldDevice);
				SetGWorld(privateData->buffer, NULL);
			}
		}
		
		// Draw, podnah
		EraseRect(&wp->portRect);
		privateData->lastUpdate = currTime;
		Secs2Date(currTime, &now);
		radius = privateData->centerPt.h - privateData->bodyRect.left;
		centerPt = privateData->centerPt;
		
		// Draw the clock face
		ForeColor(blackColor);
		FrameOval(&privateData->bodyRect);
		// Draw the tick marks
		for (hour = 0; hour <= 11; hour++) {
			AngleToPoint(hour * 30, radius - 1, centerPt, &startPt);
			AngleToPoint(hour * 30, radius - 5, centerPt, &endPt);
			MoveTo(startPt.h, startPt.v);
			LineTo(endPt.h, endPt.v);
		}
			
		// draw the hour hand
		RGBForeColor(&privateData->hourColor);
		handLength = radius / 2;
		if (now.hour >= 12) now.hour -= 12;
		PaintHand((now.hour * 30) + (now.minute / 2), handLength, 120, radius / 16, centerPt);	// hour hand
		
		// Draw the minute hand
		
		RGBForeColor(&privateData->minuteColor);
		handLength = (radius * 7) / 8;
		PaintHand(now.minute * 6, handLength, 120, radius / 16, centerPt);	// hour hand
		
		// Draw the second hand
		if (privateData->showSeconds) {
			RGBForeColor(&privateData->secondColor);
			PaintHand(now.second * 6, radius - 5, 0, 0, centerPt);	// second hand
			ForeColor(blackColor);
		}
		
		// Now, take the buffered image and transfer it to the screen
		if ((privateData->buffer != NULL) && (bufError == noErr)) {
			UnlockBuffer(privateData->buffer, oldPixState);
			SetGWorld(oldPort, oldDevice);
			CopyBufferToWindow (wp, privateData->buffer);
		}
	}
}


void ToolUpdate (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	OSErr				err;
	
	if (privateData->buffer) {
		err = CopyBufferToWindow (wp, privateData->buffer);
		if (err)
		// Something went wrong with the buffer, so use our idle routine to redraw the
		// window
			ToolIdle(wp);
	} else
		ToolIdle(wp);
}


void ToolWindowClick(WindowPtr wp, EventRecord *theEvent)
{
	// Do nothing!
	#pragma unused(wp, theEvent)
}


void ToolWindowMoved(WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;

	(void)UpdateBuffer(wp, &privateData->buffer);
	privateData->lastUpdate = 0; // Force an update
	ToolIdle(wp);
}


void ToolWindowResized(WindowPtr wp)
// Update the offscreen gWorld and our local bounds rect to match the
// new window size.
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	OSErr				err;
	Rect				bodyRect;
	Rect				globalBounds;
	
	// Calculate the new body rect
	bodyRect = GetBodyRect(wp->portRect);
	privateData->bodyRect = bodyRect;
	privateData->centerPt.h = (bodyRect.left + bodyRect.right) / 2;
	privateData->centerPt.v = (bodyRect.top + bodyRect.bottom) / 2;

	// Create the new off-screen buffer
	globalBounds = GetGlobalBounds(wp);
	err = AllocateBuffer (wp, globalBounds, &privateData->buffer, true); // Delete the old buffer & create a new one
	if (err == noErr) {
		// Force a redraw
		privateData->lastUpdate = 0; // Force an update
		ToolIdle(wp);
	}
}


void ToolWindowActivate(WindowPtr wp, Boolean activeFlag)
{
	// Nothing special to do
	#pragma unused(wp, activeFlag)
}


// === Private routines
// Private routine to calculate the rectangle which will hold our clock face
static Rect GetBodyRect (Rect thePortRect)
{
	short	height, width;
	short	side;
	Rect	bodyRect;

	// Find the smaller side of the port rectangle and use that
	// as the size of our rectangle
	height = thePortRect.bottom - thePortRect.top;
	width = thePortRect.right - thePortRect.left;
	if (height < width)
		side = height;
	else
		side = width;
	// Create the new rectangle, centered
	side /= 2;
	SetRect(&bodyRect, -side, -side, side, side);
	OffsetRect(&bodyRect, (thePortRect.right + thePortRect.left) / 2, (thePortRect.bottom + thePortRect.top) / 2);
	InsetRect(&bodyRect, 8, 8);
	return bodyRect;
}

enum {
	pi = 0x32439
	};


Fixed DecToRad (short angle)
{
	return FixDiv(FixMul(angle, pi), 180L);
}

#define FixedToShort(x) ((x >> 16) & 0x0000FFFF)
#define ShortToFixed(x) ((long)x << 16)

void AngleToPoint (short angle, short radius, Point center, Point *result)
// Given an angle, and a distance from a central point, find the resulting point
// N.B. 0 is straight up
{	
	register Fixed fixedRadius = ShortToFixed(radius);
	
	// First, bring the angle into the range 0..360
	while (angle > 360) angle -= 360;
	while (angle < 0) angle += 360;
	
	result->h = center.h + FixedToShort(FracMul(fixedRadius, FracSin(DecToRad(angle))));
	result->v = center.v - FixedToShort(FracMul(fixedRadius, FracCos(DecToRad(angle))));
}


static void PaintHand (short baseAngle, short length, short decorAngle, short decorLength, Point centerPt)
{
	PolyHandle		scratchPoly;
	Point			nextPt;


	MoveTo(centerPt.h, centerPt.v);

	// Draw the right-hand side of the base
	if (decorAngle) {
		// Use a polygon to build the image if the width is > 1
		scratchPoly = OpenPoly();
		AngleToPoint(baseAngle + decorAngle, decorLength, centerPt, &nextPt);
		LineTo(nextPt.h, nextPt.v);
	}

	// Out to the end of the hand
	AngleToPoint(baseAngle, length, centerPt, &nextPt);
	LineTo(nextPt.h, nextPt.v);

	// Down the other side...
	if (decorAngle) {
		AngleToPoint(baseAngle - decorAngle, decorLength, centerPt, &nextPt);
		LineTo(nextPt.h, nextPt.v);
		// ...and back home
		MoveTo(centerPt.h, centerPt.v);
		ClosePoly();
		PaintPoly(scratchPoly);
		KillPoly(scratchPoly);
	}
}

