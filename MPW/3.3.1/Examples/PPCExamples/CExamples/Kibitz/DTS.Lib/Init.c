/*
** Apple Macintosh Developer Technical Support
**
** Program:         DTS.Lib
** File:            init.c
** Some code from:  Traffic Light 2.0 (2.0 version by Keith Rollin)
** Modified by:     Eric Soldan
**
** Copyright © 1989-1991 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */



/*****************************************************************************/



#ifndef OBSOLETE
#define OBSOLETE
#endif

#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
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

OSType	gDocCreator;
Boolean	gQuitApplication;
Boolean gNoFinderPrint;

short	gMenuBar   = rMenuBar;
short	gAppleMenu = mApple;

extern Boolean		gHasAppleEvents, gNoDefaultDocument;
extern RgnHandle	gCursorRgn;
extern short		gPrintPage;
extern OSType		gAppWindowType;
extern TreeObjHndl	gWindowFormats;
extern DescType		gAERequiredType;

typedef void (*callBack)(void);



/*****************************************************************************/
/*****************************************************************************/



/* Given minHeap and minSpace values, get stuff going.  Also, we are passed
** in two procedure pointers.  If these are not nil, they are called at
** intermediate points during the initialization process.  The first proc
** is called after the Utilities.c standard initialization is complete.  The
** second proc is called very near the end of the initialization, but just
** prior to the menus being initialized. */

#pragma segment Initialize
void	Initialize(short moreMasters, long minHeap, long minSpace, ProcPtr init1, ProcPtr init2)
{
	long	total, contig;

	StandardInitialization(moreMasters);

	if (init1)
		(*(callBack)init1)();	/* Give app a chance to do some init stuff here. */

	/* Make sure that the machine has at least 128K ROMs.
	** If it doesn’t, exit. */

	if ((gMachineType < gestaltMac512KE) || (!gHasWaitNextEvent))
		DeathAlert(rBadNewsStrings, sWimpyMachine);

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
	** requested from MultiFinder is described in DTS.Lib.h.  The check should
	** be made because the preferred size can end up being set smaller than
	** the minimum size by the user.  This extra check acts to ensure that
	** your application is starting from a solid memory foundation. */

	if ((long)GetApplLimit() - (long)ApplicZone() < minHeap)
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

	PurgeSpace(&total, &contig);
	if (total < minSpace)
		DeathAlert(rBadNewsStrings, sNoFreeRoomInHeap);

	/* The extra benefit to waiting until after the Toolbox Managers have been
	** initialized to check memory is that we can now give the user an alert
	** to tell him/her what happened.  Although it is possible that the memory
	** situation could be worsened by displaying an alert, MultiFinder would
	** gracefully exit the application with an informative alert if memory
	** became critical.  Here we are acting more in a preventative manner to
	** avoid future disaster from low-memory problems. */

	if (init2)
		(*(callBack)init2)();	/* Give app a chance to do some init stuff here. */

	gDocCreator = gSignature;
		/* Copy the app creator type read by Utilities.c.  By copying it, the app can
		** change it if necessary to coerce various file I/O functions that use
		** gDocCreator to generate a file of a different creator type. */

	StandardMenuSetup(gMenuBar, gAppleMenu);

	qd.randSeed = TickCount();
}



/*****************************************************************************/



/* This function handles the documents selected in the finder, either for
** loading or for printing.  This is only if we don't have AppleEvents.
** If we have AppleEvents, then this will all be done automatically via
** those wonderful AppleEvent thingies. */

#pragma segment Initialize
void	StartDocuments(void)
{
	OSErr		err;
	short		i;
	short		whatToDo;
	short		numberOfFiles;
	AppFile		theAppFile;
	FSSpec		fileSpec;
	long		ignore;
	FileRecHndl	frHndl;
	WindowPtr	docWindow;
	TreeObjHndl	wobj;
	long		attr;

	if (gNoDefaultDocument) return;

	err = noErr;

	if (!gHasAppleEvents) {

		CountAppFiles(&whatToDo, &numberOfFiles);
		if (gNoFinderPrint) whatToDo = appOpen;

		if (numberOfFiles > 0) {

			gAERequiredType = (whatToDo == appPrint) ? 'pdoc' : 'odoc';		/* To inform the application what is gong on. */

			for (i = 1; (i <= numberOfFiles) && (!err); ++i) {
				GetAppFiles(i, &theAppFile);
				ClrAppFiles(i);
				err = GetWDInfo(theAppFile.vRefNum, &fileSpec.vRefNum, &fileSpec.parID, &ignore);

				if (err)
					HCenteredAlert(rErrorAlert, nil, gAlertFilterUPP);

				else {
					pcpy(fileSpec.name, theAppFile.fName);
					err = OpenDocument(&frHndl, &fileSpec, fsRdWrPerm);
					if (!err) {
						gPrintPage = whatToDo;
							/* Open the window off-screen if we are printing. */
						err = DoNewWindow(frHndl, &docWindow, FrontWindow(), (WindowPtr)-1);
						if (err)
							DisposeDocument(frHndl);
						else {
							if (gPrintPage) {
								err = PrintDocument(frHndl, (i == 1), (i == 1));
								DisposeDocument(frHndl);
								DisposeAnyWindow(docWindow);
							}
						}
						gPrintPage = 0;
					}
					if ((err) && (err != userCanceledErr)) {
						HCenteredAlert(rErrorAlert, nil, gAlertFilterUPP);
						break;
					}
				}
			}

			gAERequiredType = 0;
			if (whatToDo == appPrint) gQuitApplication = true;
		}
		else {
			err = noErr;
			if (gWindowFormats) {
				for (i = (*gWindowFormats)->numChildren; i;) {
					wobj = GetChildHndl(gWindowFormats, --i);
					attr = mDerefWFMT(wobj)->attributes;
					if (!(attr & kwRuntimeOnlyDoc)) {
						if (attr & kwAutoNew) {
							err = NewDocumentWindow(&frHndl, mDerefWFMT(wobj)->sfType, true);
							if (err) break;
						}
					}
				}
			}
			else {
				if (!gNoDefaultDocument) {
					err = NewDocument(&frHndl, gAppWindowType, true);
					if (!err)
						if (frHndl)
							if (err = DoNewWindow(frHndl, nil, FrontWindow(), (WindowPtr)-1))
								DisposeDocument(frHndl);
				}
			}
		}
	}

	DonePrinting();		/* Clean up after printing, if we did any. */
}



