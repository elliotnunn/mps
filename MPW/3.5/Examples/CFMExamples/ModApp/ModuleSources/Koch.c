/*
	File:		KochTool.c

	Contains:	The main body of the "Koch Rotate" demo made into a ModApp tool

	Written by:	Richard Clark, Stuart E. Schechter, Craig Agricola

	Copyright:	© 1993-1994 by Apple Computer, Inc., all rights reserved.
				Portions Copyright © 1993 by Stuart E. Schechter and
				Craig Agricola. Used by permission.
	
	****************************************************************************
								Koch Rotate
				'an experiment in real time fractal generation'
								  1993 by
								  
			 by Stuart E. Schechter	-	The Ohio State University
			and	Craig Agricola		-	Case Western Reserve University
	
	This program may be copied are modified as long as all versions containing
	any of the original codes contain credit to the authors in both source code
	and the running program.
	
	
	Craig Barret Agricola					Stuart Edward Schechter
	agricocb@laird.ccds.cincinnati.oh.us	schechter.1@osu.edu
	(513) 783-2684							(513) 793-5392
	6132 Osceola Rd.						5730 Kugler Mill Rd.
	Morrow, OH								Cincinnati, OH
	45152									45236-2040
	******************************************************************************

	Change History (most recent first):

				 2/16/94	RC		Added code in ImageSnowflake() to see if the GWorld has been
				 					purged.
				  7/2/93	RC		d1 release

	To Do:
*/


#define abs(x) (((x)<0) ? -(x) : (x))

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

#ifndef __QUICKDRAW__
	#include <Quickdraw.h>
#endif

#ifndef __QDOFFSCREEN__
	#include <QDOffscreen.h>
#endif

#ifndef __WINDOWS__
	#include <Windows.h>
#endif

#include <fp.h>

#ifndef __MENUS__
	#include <Menus.h>
#endif

#ifndef __OSUTILS__
	#include <OSUtils.h>	// For Secs2Date, used in our Idle routine
#endif

#ifndef __FIXMATH__
	#include <FixMath.h>	// For fixed-point math routines, used in drawing the clock face
#endif

#include "GWorldTools.h"
#include "ToolAPI.h"
#include "ModApp.h"

// === Our private data types, enumerations, and #defines

#define NumFracts 4
#define Pi 3.1415929

#define kToolMenu 	2001
enum {
		cOneSnowflake = 1,
		cTwoSnowflakes,
		cThreeSnowflakes,
		cFourSnowflakes,
		/* ----- */
		cLowDetail = 6,
		cMediumDetail,
		cHighDetail,
		/* ----- */
		cRotateColors = 10
	 };


enum {
	kHighDetailLimit = 2,
	kMediumDetailLimit = 6,
	kLowDetailLimit = 10
};


struct ToolPrivateData {
	GWorldPtr		buffer;
	Point			centerPt;				// The center of our window
	int16			Radii[NumFracts];
	int16			Increment[NumFracts];
	int16			numSnowflakes;
	int16			detailCutoff;			/* How close should 2 points be before we stop recursing? */
	Boolean			rotateColors;			/* Should we animate the colors when drawing? */
	Point 			X_Point[NumFracts],
					Y_Point[NumFracts],
					Z_Point[NumFracts];
	double_t 		X_degree[NumFracts],
					Y_degree[NumFracts],
					Z_degree[NumFracts];
	
	RGBColor		CurrentColor;
};

typedef struct ToolPrivateData ToolData, *ToolDataPtr;

// === Local prototypes
static void CalculateXYZ (int Which, ToolDataPtr privateData);
static void DrawKochTriangle (int Which, ToolDataPtr privateData);
static void RecurKoch (int Level, Point From, Point To, ToolDataPtr privateData);
static void SizeSnowflake (WindowPtr wp);
static void RotateSnowflake (WindowPtr wp);
static void ImageSnowflake (WindowPtr wp);
static void CopySnowflake (WindowPtr wp);

// === Public routines

OSErr ToolStartup (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	OSErr				err = noErr;
	ToolDataPtr			privateData = NULL;
	Rect				globalBounds;
	MenuHandle			privateMenu;
	short				refNum;
	
	// Don't bother adding anything to the tool window's block, as we don't have any private info
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
//	if (err) goto error; // Don't fail if we can't get the buffer
	
	// Set other local variables
	privateData->X_degree[0] = 0;
	privateData->Y_degree[0] = (2 * Pi) / 3;
	privateData->Z_degree[0] = (4 * Pi) / 3;
	
	privateData->X_degree[1] = 0;
	privateData->Y_degree[1] = (2 * Pi) / 3;
	privateData->Z_degree[1] = (4 * Pi) / 3;
	
	privateData->X_degree[2] = 0;
	privateData->Y_degree[2] = (2 * Pi) / 3;
	privateData->Z_degree[2] = (4 * Pi) / 3;
	
	privateData->X_degree[3] = 0;
	privateData->Y_degree[3] = (2 * Pi) / 3;
	privateData->Z_degree[3] = (4 * Pi) / 3;
			
	privateData->numSnowflakes = 3;
	privateData->detailCutoff = kMediumDetailLimit;
	privateData->rotateColors = true;
	
	privateData->CurrentColor.red = 0x4400;
	privateData->CurrentColor.green = 0x8008;
	privateData->CurrentColor.blue = 0x2020;
	SizeSnowflake(wp);

	privateData->centerPt.h = (wp->portRect.left + wp->portRect.right) / 2;
	privateData->centerPt.v = (wp->portRect.top + wp->portRect.bottom) / 2;
	
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
		DisposePtr((Ptr)privateData);
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
		DisposePtr((Ptr)privateData);
	}

}


void ToolMenuAdjust (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	MenuHandle			toolMenu = GetMenuHandle(kToolMenu);
		
	CheckItem(toolMenu, cOneSnowflake, privateData->numSnowflakes == 1);
	CheckItem(toolMenu, cTwoSnowflakes, privateData->numSnowflakes == 2);
	CheckItem(toolMenu, cThreeSnowflakes, privateData->numSnowflakes == 3);
	CheckItem(toolMenu, cFourSnowflakes, privateData->numSnowflakes == 4);
	CheckItem(toolMenu, cLowDetail, privateData->detailCutoff == kLowDetailLimit);
	CheckItem(toolMenu, cMediumDetail, privateData->detailCutoff == kMediumDetailLimit);
	CheckItem(toolMenu, cHighDetail, privateData->detailCutoff == kHighDetailLimit);
	CheckItem(toolMenu, cRotateColors, privateData->rotateColors);
}


void ToolMenuDispatch (WindowPtr wp, short menuID, short itemID)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;

	if (menuID == kToolMenu) {
		switch (itemID) {
			case cOneSnowflake:
			case cTwoSnowflakes:
			case cThreeSnowflakes:
			case cFourSnowflakes:
				privateData->numSnowflakes = (itemID - cOneSnowflake) + 1;
			break;
			
			case cLowDetail:
				privateData->detailCutoff = kLowDetailLimit;
			break;
			
			case cMediumDetail:
				privateData->detailCutoff = kMediumDetailLimit;
			break;
			
			case cHighDetail:
				privateData->detailCutoff = kHighDetailLimit;
			break;
			
			case cRotateColors:
				privateData->rotateColors = !privateData->rotateColors;
			break;
		}
		ToolMenuAdjust (wp);
	}
}


void ToolIdle (WindowPtr wp)
{
	SetPort(wp);
	RotateSnowflake(wp);
	ImageSnowflake(wp);
}


void ToolUpdate (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	OSErr				err;
	
	SetPort(wp);
	if (privateData->buffer) {
		err = CopyBufferToWindow (wp, privateData->buffer);
		if (err)
			// Something went wrong with the buffer, so use our idle routine to redraw the
			// window
			ImageSnowflake(wp);
	} else {
		ImageSnowflake(wp);
	}
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
	ToolIdle(wp);
}


void ToolWindowResized(WindowPtr wp)
// Update the offscreen gWorld and our local bounds rect to match the
// new window size.
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	OSErr				err;
	Rect				globalBounds;
	
	// Calculate the new body rect
	privateData->centerPt.h = (wp->portRect.left + wp->portRect.right) / 2;
	privateData->centerPt.v = (wp->portRect.top + wp->portRect.bottom) / 2;

	// Create the new off-screen buffer
	globalBounds = GetGlobalBounds(wp);
	err = AllocateBuffer (wp, globalBounds, &privateData->buffer, true); // Delete the old buffer & create a new one
	// Force a redraw
	SetPort(wp);
	InvalRect(&wp->portRect);
	ToolUpdate(wp);
}


void ToolWindowActivate(WindowPtr wp, Boolean activeFlag)
{
	// Nothing special to do
	#pragma unused(wp, activeFlag)
}


// === Private routines


void CalculateXYZ(int Which, ToolDataPtr privateData)
{
	privateData->X_Point[Which].h = privateData->centerPt.h + (int16) (privateData->Radii[Which] * cos(privateData->X_degree[Which]));
	privateData->X_Point[Which].v = privateData->centerPt.h - (int16) (privateData->Radii[Which] * sin(privateData->X_degree[Which]));

	privateData->Y_Point[Which].h = privateData->centerPt.h + (int16) (privateData->Radii[Which] * cos(privateData->Y_degree[Which]));
	privateData->Y_Point[Which].v = privateData->centerPt.h - (int16) (privateData->Radii[Which] * sin(privateData->Y_degree[Which]));

	privateData->Z_Point[Which].h = privateData->centerPt.h + (int16) (privateData->Radii[Which] * cos(privateData->Z_degree[Which]));
	privateData->Z_Point[Which].v = privateData->centerPt.h - (int16) (privateData->Radii[Which] * sin(privateData->Z_degree[Which]));
}


void SizeSnowflake (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	Rect				localBounds;
	int16				h, v;

	localBounds = wp->portRect;
		
	h = (localBounds.left + localBounds.right) >> 1;
	v = (localBounds.top + localBounds.bottom) >> 1;
	/* Find the smaller of the 2 values and center on that */
	if (h < v)
		v = h;
	else
		h = v;

	privateData->centerPt.h = h;
	privateData->centerPt.v = v;
		
	privateData->Increment[0] = 1;
	privateData->Radii[0] = h / 1.25;
	
	privateData->Increment[1] = 1;
	privateData->Radii[1] = h / 3.5;
	
	privateData->Increment[2] = -1;
	privateData->Radii[2] = h / 7.0;
	
	privateData->Increment[3] = -1;
	privateData->Radii[3] = h;

}


void RotateSnowflake (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	Point				centerPt = privateData->centerPt;
	
	/* Calculate the new position for the snowflake */
	if ( privateData->Radii[0] > centerPt.h/1.5 )
		privateData->Increment[0] =-3;
	else if ( privateData->Radii[0] < centerPt.h/4 )
		privateData->Increment[0] = 3;
	privateData->Radii[0] +=  privateData->Increment[0];
	privateData->X_degree[0] += .05;
	privateData->Y_degree[0] += .05;
	privateData->Z_degree[0] += .05;

	if ( privateData->Radii[1] > centerPt.h/4 )
		privateData->Increment[1] =-2;
	else if ( privateData->Radii[1] < centerPt.h/7 )
		privateData->Increment[1] = 2;
	privateData->Radii[1] +=  privateData->Increment[1];
	privateData->X_degree[1] += .07;
	privateData->Y_degree[1] += .07;
	privateData->Z_degree[1] += .07;

	if ( privateData->Radii[2] > centerPt.h/7 )
		privateData->Increment[2] =-1;
	else if ( privateData->Radii[2] < centerPt.h/9 )
		privateData->Increment[2] = 1;
	privateData->Radii[2] += privateData->Increment[2];
	privateData->X_degree[2] -= .08;
	privateData->Y_degree[2] -= .08;
	privateData->Z_degree[2] -= .08;

	if ( privateData->Radii[3] > centerPt.h/1.1 )
		privateData->Increment[3] =-2;
	else if ( privateData->Radii[3] < centerPt.h )
		privateData->Increment[3] = 2;
	privateData->Radii[3] += privateData->Increment[3];
	privateData->X_degree[3] -= .05;
	privateData->Y_degree[3] -= .05;
	privateData->Z_degree[3] -= .05;
}


void ImageSnowflake (WindowPtr wp)
{
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolDataPtr			privateData = (ToolDataPtr)aWindow->toolRefCon;
	OSErr				bufError;
	CGrafPtr			oldPort;
	GDHandle			oldDevice;
	int16				numSnowflakes = privateData->numSnowflakes;
	GWorldFlags			oldPixState;

	if (privateData->buffer == NULL) {
		SetPort(wp);
	} else {
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
		
	/* Image the snowflake */
	EraseRect(&wp->portRect);
	if (numSnowflakes == 4) {
		CalculateXYZ(1, privateData);		/* Calculate triangular points for basis of Koch Snowflakes */
		DrawKochTriangle(1, privateData);	/* Call function to draw the Koch Snowflake */
	}
	
	if (numSnowflakes >= 3) {
		CalculateXYZ(0, privateData);
		DrawKochTriangle(0, privateData);
	}
	
	if (numSnowflakes >= 2) {
		CalculateXYZ(2, privateData);
		DrawKochTriangle(2, privateData);
	}

	CalculateXYZ(3, privateData);
	DrawKochTriangle(3, privateData);

	// Now, take the buffered image and transfer it to the screen
	if ((privateData->buffer != NULL) && (bufError == noErr)) {
		UnlockBuffer(privateData->buffer, oldPixState);
		SetGWorld(oldPort, oldDevice);
		CopyBufferToWindow (wp, privateData->buffer);
	}
}


void DrawKochTriangle(int Which, ToolDataPtr privateData)
{
	RecurKoch(0, privateData->X_Point[Which], privateData->Y_Point[Which], privateData);
	RecurKoch(0, privateData->Y_Point[Which], privateData->Z_Point[Which], privateData);
	RecurKoch(0, privateData->Z_Point[Which], privateData->X_Point[Which], privateData);
}


void	RecurKoch(int Level, Point From, Point To, ToolDataPtr privateData)
{
	Point	NewFrom, NewTo, NewVertex;
	int16	hDif,vDif;

	hDif = To.h-From.h;
	vDif = To.v - From.v;

	if ((abs(hDif) + abs(vDif)) <= privateData->detailCutoff) {
			MoveTo(From.h,From.v);
			LineTo(To.h,To.v);
			return;
	}				

	if ((Level == 3) && (privateData->rotateColors)) {
		/* Change the color value by rotating it */
		RGBColor	currentColor = privateData->CurrentColor;
		
		currentColor.red = (currentColor.red + 200) % 0x10000;
		currentColor.green = (currentColor.green + 350) % 0x10000;
		currentColor.blue = (currentColor.blue + 500) % 0x10000;
		privateData->CurrentColor = currentColor;
		RGBForeColor(&currentColor);
	}

	/* Recurse down some more before drawing */

	NewFrom.h = From.h + (hDif) / 3;
	NewFrom.v = From.v + (vDif) / 3;
	NewTo.h = From.h + (hDif*2) / 3;
	NewTo.v = From.v + (vDif*2) / 3;
	NewVertex.h = ((NewFrom.h + NewTo.h) /2)  -  (vDif/3);
	NewVertex.v = ((NewFrom.v + NewTo.v) /2)  +  (hDif/3);
	
	RecurKoch(Level + 1, From, NewFrom, privateData);
	RecurKoch(Level + 1, NewFrom, NewVertex, privateData);
	RecurKoch(Level + 1, NewVertex, NewTo, privateData);
	RecurKoch(Level + 1, NewTo, To, privateData);
}
