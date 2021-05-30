/*
	File:		main.c

	Contains:	Main event loop and basic keyboard/mouse processing

	Written by:	Richard Clark

	Copyright:	© 1993-1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 2/16/94	RC		Modified suspend/resume code to create a "dummy" activate/deactivate
				 					event record.
				  2/9/94	RC		Added test to omit the "qd" definition if compiling under Metrowerks C
				 1/26/94	RC		Added rudimentary Suspend/resume support
				11/28/93	RC		First release

	To Do:
*/


#ifndef __MEMORY__
	#include <Memory.h>
#endif

#ifndef __APPLEEVENTS__
	#include <AppleEvents.h>
#endif

#ifndef __DIALOGS__
	#include <Dialogs.h>
#endif

#ifndef __DESK__
	#include <Desk.h>
#endif

#ifndef __WINDOWS__
	#include <Windows.h>
#endif

#define		__Main__
#include "ModApp.h"
#include "Prototypes.h"

#if defined(powerc) && !defined(__MWERKS__) // MetroWerks declares "qd" in their runtime
	QDGlobals	qd;
#endif

#define kIdleTime 15L		/* Take this long per null event -- 15L = 1/4 second */
static long lastTime = 0;

static void DoKey (EventRecord *theEvent);
static void DoMouseDown (EventRecord *theEvent);
static void MainLoop(void);
void main(void);

void DoKey (EventRecord *theEvent)
{
	char		keyPressed = (theEvent->message & charCodeMask);

	if (theEvent->modifiers & cmdKey) {
			AdjustMenus();
			Dispatch(MenuKey(keyPressed));		/*Command key down*/
	} else {
		// Pass all other keystrokes to the frontmost window
		DrawingWindowPeek	aWindow = (DrawingWindowPeek)FrontWindow();
		
		if (aWindow /* != NULL */) {
			SetPort((WindowPtr)aWindow);
			if (aWindow->toolRoutines.toolKeyProc)
				CallToolWindowKeyProc(aWindow->toolRoutines.toolKeyProc, (WindowPtr)aWindow, theEvent);
		}
	}
} /* DoKey */




void DoMouseDown (EventRecord *theEvent)
{
	Point			globalPt = theEvent->where;
	int16			windowPart;
	WindowPtr		wp;

	windowPart = FindWindow(globalPt, &wp);
	switch (windowPart) {
		case inMenuBar: 
			AdjustMenus();
			Dispatch(MenuSelect(globalPt));
		break;

		case inSysWindow: 
			SystemClick(theEvent, wp);
		break;


		case inGoAway: 
			if (TrackGoAway(wp, theEvent->where))
				CloseAWindow(wp);
		break;

		case inDrag:
			DoDragWindow(wp, theEvent);
		break;

		case inGrow: 
			DoGrowWindow(wp, theEvent);
		break;
		
		case inContent: 
			DoContentClick(wp, theEvent);
		break;

		case inZoomIn:
		case inZoomOut: 
			DoZoomWindow(wp, theEvent, windowPart);
		break;
	}
} /* DoMouseDown */


void MainLoop()
{
	EventRecord	theEvent;
	static  long	sleepTime = 1L;

	while (!gDone) {
		WaitNextEvent(everyEvent, &theEvent, sleepTime, NULL);	
		
		switch (theEvent.what) {
			case nullEvent:
				while (TickCount() <= lastTime + kIdleTime) {
					if (isUserWindow(gCurrentWindow)) {
						DoIdleWindow(gCurrentWindow);
					}
					/* Get the next window, wrapping around to the front if necessary */
					if (gCurrentWindow != NULL) {
						gCurrentWindow = (WindowPtr)(((WindowPeek)gCurrentWindow)->nextWindow);
					} else {
						/* We've hit the end of the window list */
						gCurrentWindow = FrontWindow();
						break;
					}
				}
				lastTime = TickCount();
			break;

			case mouseDown: 
				DoMouseDown(&theEvent);
			break;

			case keyDown:
			case autoKey: 
				DoKey(&theEvent);
			break;

			case activateEvt: 
				DoActivate(&theEvent);
			break;

			case updateEvt:
				DoUpdate((WindowPtr)theEvent.message);
			break;
			
			case osEvt:
				if ((theEvent.message >> 24) & suspendResumeMessage ) {	// suspend or resume
					gCurrentWindow = FrontWindow(); 					// Reset the idle pointer to the front window
					/* Modify the event record to look like an activate/deactivate event */
					theEvent.modifiers = theEvent.message; /* Copy suspend/resume flag */
					theEvent.message = (long)gCurrentWindow;	
					DoActivate(&theEvent);
				}
			break;
			
			case kHighLevelEvent:
				(void)AEProcessAppleEvent(&theEvent);
		}
	}
} /* MainEventLoop */


void main()
{
	MaxApplZone();
	MoreMasters();
	MoreMasters();
	MoreMasters();
	MoreMasters();
	
	InitAll();					/* call initialization routine	*/
	AdjustMenus();
	MainLoop();
}