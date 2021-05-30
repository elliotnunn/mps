/*
** Apple Macintosh Developer Technical Support
**
** File:            init.c
** Some code from:  Traffic Light 2.0 (2.0 version by Keith Rollin)
** Modified by:     Eric Soldan
**
** Copyright © 1989-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



/* Set up the whole world, including global variables, Toolbox managers, and
** menus.  We also create our one application window at this time.  Since
** window storage is non-relocateable, how and when to allocate space for
** windows is very important so that heap fragmentation does not occur. */

/* The code that used to be part of ForceEnvirons has been moved into this
** module.  If an error is detected, instead of merely doing an ExitToShell,
** which leaves the user without much to go on, we call DeathAlert, which puts
** up a simple alert that just says an error occurred and then calls
** ExitToShell.  Since there is no other cleanup needed at this point if an
** error is detected, this form of error-handling is acceptable.  If more
** sophisticated error recovery is needed, an exception mechanism, such as is
** provided by Signals, can be used. */



/*****************************************************************************/



/* NOTE:  The “g” prefix is used to emphasize that a variable is global. */

Boolean	gQuitApplication;		/* Set to 0 by Initialize. */
								/* Checked by EventLoop. */

extern Boolean		gHasAppleEvents;
extern RgnHandle	gCurrentCursorRgn;


/*****************************************************************************/
/*****************************************************************************/



#pragma segment Initialize
void	Initialize(void)
{
	long		total, contig;

	StandardInitialization(1);			/* 1 MoreMasters. */

	/* Make sure that the machine has at least 128K ROMs.
	** If it doesn’t, exit. */
	
	if (gSystemVersion < 0x0700) DeathAlert(rBadNewsStrings, sWimpyMachine);
	
	/* We used to make a check for memory at this point by examining
	** ApplLimit, ApplicZone, and StackSpace and comparing that to the minimum
	** size we told MultiFinder we needed.  This did not work well because it
	** assumed too much about the relationship between what we asked
	** MultiFinder for and what we would actually get back, as well as how to
	** measure it.  Instead, we will use an alternate method comprised of
	** two steps. */
	 
	/* It is better to first check the size of the application heap against a
	** value that you have determined is the smallest heap the application can
	** reasonably work in.  This number should be derived by examining the
	** size of the heap that is actually provided by MultiFinder when the
	** minimum size requested is used.  The derivation of the minimum size
	** requested from MultiFinder is described in Kibitz.h.  The check should
	** be made because the preferred size can end up being set smaller than
	** the minimum size by the user.  This extra check acts to ensure that
	** your application is starting from a solid memory foundation. */
	 
	if ((long) GetApplLimit() - (long) ApplicZone() < kMinHeap)
		DeathAlert(rBadNewsStrings, sHeapTooSmall);

	/* Next, make sure that enough memory is free for your application to run.
	** It is possible for a situation to arise where the heap may have been of
	** required size, but a large scrap was loaded which left too little
	** memory.  To check for this, call PurgeSpace and compare the result with
	** a value that you have determined is the minimum amount of free memory
	** your application needs at initialization.  This number can be derived
	** several different ways.  One way that is fairly straightforward is to
	** run the application in the minimum size configuration as described
	** previously.  Call PurgeSpace at initialization and examine the value
	** returned.  However, you should make sure that this result is not being
	** modified by the scrap’s presence.  You can do that by calling ZeroScrap
	** before calling PurgeSpace.  Make sure to remove that call before
	** shipping, though. */
	
	/* ZeroScrap(); */

	PurgeSpace(&total, &contig);
	if (total < kMinSpace)
		DeathAlert(rBadNewsStrings, sNoFreeRoomInHeap);

	/* The extra benefit to waiting until after the Toolbox Managers have been
	** initialized to check memory is that we can now give the user an alert
	** to tell him/her what happened.  Although it is possible that the memory
	** situation could be worsened by displaying an alert, MultiFinder would
	** gracefully exit the application with an informative alert if memory
	** became critical.  Here we are acting more in a preventative manner to
	** avoid future disaster from low-memory problems. */

	StandardMenuSetup(rMenuBar, mApple);
	AdjustMenus();

	InitAppleEvents();
	InitCustomAppleEvents();

	if (InitOffscreen()) DeathAlert(rBadNewsStrings, sHeapTooSmall);
	if (InitLogic())	 DeathAlert(rBadNewsStrings, sHeapTooSmall);

	gCurrentCursorRgn  = NewRgn();		/* The current cursor region. */
	DoSetCursor(&qd.arrow);

	qd.randSeed = TickCount();
	gQuitApplication = false;	/* We are only starting.  Don't quit now! */
}



/*****************************************************************************/



#pragma segment Initialize
void	StartDocuments(void)
{
}



