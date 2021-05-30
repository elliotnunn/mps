/*
** Apple Macintosh Developer Technical Support
**
** MultiFinder-Aware Kibitz Application
**
** File:             eventloop.c
** Originally from:  Traffic Light 2.0 (2.0 version by Keith Rollin)
** Modified by:      Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __TEXTEDITCONTROL__
#include <TextEditControl.h>
#endif



/*****************************************************************************/



extern RgnHandle	gCurrentCursorRgn;		/* The current cursor region.
											** The initial cursor region is
											** an empty region, which will
											** cause WaitNextEvent to generate
											** a mouse-moved event, which will
											** cause us to set the cursor for
											** the first time.
											*/
extern Boolean		gQuitApplication;		/* This is set to false by
											** Initialize.  When the user
											** selects Quit (and does not
											** abort the quit), then this
											** boolean is set true.
											*/



/*****************************************************************************/
/*****************************************************************************/



/* Get events forever, and handle them by calling DoEvent.  Get the events by
** calling WaitNextEvent.  (This sample does a DeathAlert if WaitNextEvent
** isn't available.) */

#pragma segment Main
void	EventLoop(void)
{
	EventRecord		event;

	while (!gQuitApplication) {

		if (!WaitNextEvent(everyEvent, &event, 15, gCurrentCursorRgn))
			event.what = nullEvent;
		DoEvent(&event);

		CTEIdle();
	};
}



