/*
** Apple Macintosh Developer Technical Support
**
** Program:	    DTS.Lib
** File:	    AERequired.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1991 Apple Computer, Inc.
** All rights reserved.
**
** This code implements the required AppleEvents, specific to DTS.Lib.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif



/*****************************************************************************/



#define kTimeOutInTicks (60 * 30)	/* 30 second timeout. */

static pascal OSErr	DoAEOpenDocuments(AppleEvent *message, AppleEvent *reply, long refcon);
static pascal OSErr	DoAEPrintDocuments(AppleEvent *message, AppleEvent *reply, long refcon);
static pascal OSErr	DoAEQuitApplication(AppleEvent *message, AppleEvent *reply, long refcon);
static OSErr		OpenDocEventHandler(AppleEvent *message, AppleEvent *reply, short mode);



/*****************************************************************************/



static AEHandler keywordsToInstall[] = {
	{ kCoreEventClass,		kAEOpenApplication,		(ProcPtr)DoAEOpenApplication,	nil },
	{ kCoreEventClass,		kAEOpenDocuments,		(ProcPtr)DoAEOpenDocuments,		nil },
	{ kCoreEventClass,		kAEPrintDocuments,		(ProcPtr)DoAEPrintDocuments,	nil },
	{ kCoreEventClass,		kAEQuitApplication,		(ProcPtr)DoAEQuitApplication,	nil }
		/* The above are the four required AppleEvents. */
};

#define kNumKeywords (sizeof(keywordsToInstall) / sizeof(AEHandler))

Boolean		gHasAppleEvents = false;
Boolean		gHasPPCToolbox  = false;
DescType	gAERequiredType;

extern TreeObjHndl	gWindowFormats;
extern Boolean		gNoFinderPrint;



/*****************************************************************************/



extern Boolean		gQuitApplication, gNoDefaultDocument, gInBackground;
extern short		gPrintPage;

extern Cursor		*gCursorPtr;
extern OSType		gAppWindowType;



/*****************************************************************************/
/*****************************************************************************/



/* Intializes AppleEvent dispatcher table for the required events.  It also
** determines if the machine is PPCBrowser and AppleEvent capable.  If so,
** the booleans gHasAppleEvents and gHasPPCToolbox are set true.  This function
** must be the first AppleEvents initialization DTS.framework function called, as the
** other functions depend on the booleans being set correctly. */

#pragma segment AppleEvents
OSErr	InitRequiredAppleEvents(void)
{
	OSErr	err;
	long	result;
	short	i;

	gHasPPCToolbox  = (Gestalt(gestaltPPCToolboxAttr, &result) ? false : result != 0);
	gHasAppleEvents = (Gestalt(gestaltAppleEventsAttr, &result) ? false : result != 0);

	if (gHasAppleEvents) {

		for (i = 0; i < kNumKeywords; ++i) {

			if (!keywordsToInstall[i].theUPP)
				keywordsToInstall[i].theUPP = NewAEEventHandlerProc(keywordsToInstall[i].theHandler);

			err = AEInstallEventHandler(
				keywordsToInstall[i].theEventClass,	/* What class to install.  */
				keywordsToInstall[i].theEventID,	/* Keywords to install.    */
				keywordsToInstall[i].theUPP,		/* The AppleEvent handler. */
				0L,									/* Unused refcon.		   */
				false								/* Only for our app.	   */
			);
			if (err) {
				HCenteredAlert(rErrorAlert, nil, gAlertFilterUPP);
				return(err);
			}
		}
	}

	return(noErr);
}



/*****************************************************************************/



/* This function opens a new DTS.framework document due to an AppleEvents request. */

#pragma segment AppleEvents
pascal OSErr	DoAEOpenApplication(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (message, reply, refcon)

	FileRecHndl	frHndl;
	OSErr		err;
	short		i;
	TreeObjHndl	wobj;
	long		attr;

	gAERequiredType = 'oapp';

	gCursorPtr = nil;
		/* Force re-calc of cursor region and cursor to use. */

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

	gAERequiredType = 0;

	return(err);
}



/*****************************************************************************/



/* This function opens existing DTS.framework documents due to an AppleEvents request. */

#pragma segment AppleEvents
static pascal OSErr	DoAEOpenDocuments(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	OSErr	err;

	gAERequiredType = 'odoc';

	gCursorPtr = nil;		/* Force re-calc of cursor region and cursor to use. */
	err = OpenDocEventHandler(message, reply, 0);
		/* The 0 means regular open document. */

	gAERequiredType = 0;

	return(err);
}



/*****************************************************************************/



/* This function prints DTS.framework documents due to an AppleEvents request. */

#pragma segment AppleEvents
static pascal OSErr	DoAEPrintDocuments(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	short				openMode;
	ProcessSerialNumber	cpsn, fpsn;
	Boolean				procsSame;
	OSErr				err;

	if (gNoFinderPrint) err = DoAEOpenDocuments(message, reply, refcon);
	else {
		gAERequiredType = 'pdoc';
		gCursorPtr = nil;				/* Force re-calc of cursor region and cursor to use. */

		openMode = 1;
		if (!AEInteractWithUser(kTimeOutInTicks, nil, nil))
			++openMode;

		GetCurrentProcess(&cpsn);		/* We may have been moved to the front. */
		GetFrontProcess(&fpsn);
		SameProcess(&cpsn, &fpsn, &procsSame);
		gInBackground = !procsSame;

		err = OpenDocEventHandler(message, reply, openMode);
			/* openMode is either 1 or 2, depending if user interaction is okay. */

		gAERequiredType = 0;
	}

	return(err);
}



/*****************************************************************************/



/* This function sets a quit flag so that DTS.framework will quit due to an
** AppleEvents request. */

#pragma segment AppleEvents
static pascal OSErr	DoAEQuitApplication(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (message, reply, refcon)

	OSErr	err;

	gCursorPtr = nil;
		/* Force re-calc of cursor region and cursor to use. */

	if (DisposeAllWindows()) {
		gQuitApplication = true;
		err = noErr;
	}
	else err = errAEEventNotHandled;
		/* All windows didn't close because user cancelled the quit. */

	return(err);
}



/*****************************************************************************/



/* Called when we recieve an AppleEvent with an ID of "kAEOpenDocuments".
** This routine gets the direct parameter, parses it up into little FSSpecs,
** and opens each indicated file.  It also shows the technique to be used in
** determining if you are doing everything the AppleEvent record is telling
** you.  Parameters can be divided up into two groups: required and optional.
** Before executing an event, you must make sure that you've read all the
** required events.  This is done by making an "any more?" call to the
** AppleEvent manager. */

#pragma segment AppleEvents
static OSErr	OpenDocEventHandler(AppleEvent *message, AppleEvent *reply, short mode)
{
#pragma unused (reply)

	OSErr		err;
	OSErr		err2;
	AEDesc		theDesc;
	FSSpec		theFSS;
	short		loop;
	long		numFilesToOpen;
	AEKeyword	ignoredKeyWord;
	DescType	ignoredType;
	Size		ignoredSize;
	FileRecHndl	frHndl;
	WindowPtr	docWindow;

	theDesc.dataHandle = nil;
		/* Make sure disposing of the descriptors is okay in all cases.
		** This will not be necessary after 7.0b3, since the calls that
		** attempt to create the descriptors will nil automatically
		** upon failure. */

	if (err = AEGetParamDesc(message, keyDirectObject, typeAEList, &theDesc))
		return(err);

	if (!MissedAnyParameters(message)) {

/* Got all the parameters we need.  Now, go through the direct object,
** see what type it is, and parse it up. */

		err = AECountItems(&theDesc, &numFilesToOpen);
		if (!err) {
			/* We have numFilesToOpen that need opening, as either a window
			** or to be printed.  Go to it... */

			for (loop = 1; ((loop <= numFilesToOpen) && (!err)); ++loop) {
				err = AEGetNthPtr(		/* GET NEXT IN THE LIST...		 */
					&theDesc,			/* List of file names.			 */
					loop,				/* Item # in the list.			 */
					typeFSS,			/* Item is of type FSSpec.		 */
					&ignoredKeyWord,	/* Returned keyword -- we know.  */
					&ignoredType,		/* Returned type -- we know.	 */
					(Ptr)&theFSS,		/* Where to put the FSSpec info. */
					sizeof(theFSS),		/* Size of the FSSpec info.		 */
					&ignoredSize		/* Actual size -- we know.		 */
				);
				if (err) break;

				err = OpenDocument(&frHndl, &theFSS, fsRdWrPerm);
				if (err) break;

				gPrintPage = mode;
					/* Open the window off-screen if we are printing.
					** We use the gPrintPage global to flag this.  Normally, the
					** gPrintPage global is to tell ImageDocument if we are imaging
					** to the window or to paper.  We don't need it for this yet,
					** as we can't image the document until it is opened.  DoNewWindow()
					** uses gPrintPage as a flag to open the window off-screen, but
					** visible, so that PrintMonitor can use the title of the window
					** as the document name that is being printed. */

				if (err = DoNewWindow(frHndl, &docWindow, FrontWindow(), (WindowPtr)-1))
					DisposeDocument(frHndl);
				else {
					if (gPrintPage) {
						err  = PrintDocument(frHndl, (mode == 2), (loop == 1));
						mode = 1;	/* No interaction mode (mode == 2) only valid
									** for the first printed document. */
						DisposeDocument(frHndl);
						DisposeAnyWindow(docWindow);
					}
				}
				gPrintPage = 0;
					/* Put the ImageDocument controlling global back to normal. */
			}
		}
	}
	DonePrinting();		/* Clean up after printing, if we did any. */

	err2 = AEDisposeDesc(&theDesc);
	return(err ? err : err2);
}



