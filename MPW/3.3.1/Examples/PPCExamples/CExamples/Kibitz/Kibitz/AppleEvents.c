/*
** Apple Macintosh Developer Technical Support
**
** File:	    appleevents.c
** Written by:  Keith Rollin
**
** Copyright © 1990-1994 Apple Computer, Inc.
** All rights reserved.
**
** This code is completely based on the great work done by Keith Rollin.
** All I did was to add more comments than _anybody_ would want, make some
** things a little more general, and to set the code up so the the custom
** events are handled in a separate file. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __AEUTILS__
#include <AEUtils.h>
#endif

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



#define rErrorAlert 129
#define kTimeOutInTicks (60 * 30)	/* 30 second timeout. */



/*****************************************************************************/



struct triplets{
	AEEventClass		theEventClass;
	AEEventID			theEventID;
	ProcPtr				theHandler;
	AEEventHandlerUPP	theUPP;
};
typedef struct triplets triplets;
static triplets keywordsToInstall[] = {
	{ kCoreEventClass,		kAEOpenApplication,		KibitzAEOpenApplication },
	{ kCoreEventClass,		kAEOpenDocuments,		KibitzAEOpenDocuments },
	{ kCoreEventClass,		kAEPrintDocuments,		KibitzAEPrintDocuments },
	{ kCoreEventClass,		kAEQuitApplication,		KibitzAEQuitApplication }
		/* The above are the four required AppleEvents. */
};

Boolean		gHasAppleEvents = false;
Boolean		gHasPPCToolbox  = false;



/*****************************************************************************/



extern Boolean	gQuitApplication;
extern Cursor	*gCurrentCursor;
extern short	gPrintPage;



/*****************************************************************************/
/*****************************************************************************/



/* InitAppleEvents
**
** Intialize our AppleEvent dispatcher table.  For every triplet of entries in
** keywordsToInstall, we make a call to AEInstallEventHandler(). */

#pragma segment AppleEvents
void	InitAppleEvents(void)
{
	OSErr	err;
	long	result;
	short	i;

	gHasPPCToolbox  = (Gestalt(gestaltPPCToolboxAttr, &result) ? false : result != 0);
	gHasAppleEvents = (Gestalt(gestaltAppleEventsAttr, &result) ? false : result != 0);

	if (gHasAppleEvents) {
		for (i = 0; i < (sizeof(keywordsToInstall) / sizeof(triplets)); ++i) {

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
				Alert(rErrorAlert, gAlertFilterUPP);
				return;
			}
		}
	}
}



/*****************************************************************************/
/*****************************************************************************/



#pragma segment AppleEvents
pascal OSErr	KibitzAEOpenApplication(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (message, refcon)

	OSErr		err;

	err = noErr;

	gCurrentCursor = nil;
		/* Force re-calc of cursor region and cursor to use. */

	AEPutParamPtr(				/* RETURN REPLY ERROR, EVEN IF NONE... */
		reply,					/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		(Ptr)&err,				/* Pointer to area for data. */ 
		sizeof(short)			/* Size of data area.		 */
	);

	return(err);
}



/*****************************************************************************/



#pragma segment AppleEvents
pascal OSErr	KibitzAEOpenDocuments(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	OSErr		err;

	gCurrentCursor = nil;
		/* Force re-calc of cursor region and cursor to use. */

	err = OpenDocEventHandler(message, reply, 0);

	AEPutParamPtr(				/* RETURN REPLY ERROR, EVEN IF NONE... */
		reply,					/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		(Ptr)&err,				/* Pointer to area for data. */ 
		sizeof(short)			/* Size of data area.		 */
	);

	return(err);
}



/*****************************************************************************/



#pragma segment AppleEvents
pascal OSErr	KibitzAEPrintDocuments(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	OSErr		err;
	short		openMode;

	DoSetCursor(&qd.arrow);

	openMode = 1;
	if (!AEInteractWithUser(kTimeOutInTicks, nil, nil)) ++openMode;

	err = OpenDocEventHandler(message, reply, openMode);

	AEPutParamPtr(				/* RETURN REPLY ERROR, EVEN IF NONE... */
		reply,					/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		(Ptr)&err,				/* Pointer to area for data. */ 
		sizeof(short)			/* Size of data area.		 */
	);

	return(err);
}



/*****************************************************************************/



#pragma segment AppleEvents
pascal OSErr	KibitzAEQuitApplication(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (message, refcon)

	OSErr	err;

	gCurrentCursor = nil;
		/* Force re-calc of cursor region and cursor to use. */

	if (CloseAllWindows()) {
		gQuitApplication = true;
		err = noErr;
	}
	else err = errAEEventNotHandled;

	AEPutParamPtr(				/* RETURN REPLY ERROR, EVEN IF NONE... */
		reply,					/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		(Ptr)&err,				/* Pointer to area for data. */ 
		sizeof(short)			/* Size of data area.		 */
	);

	return(noErr);
}



/*****************************************************************************/



/* OpenDocEventHandler
**
** Called when we recieve an AppleEvent with an ID of "kAEOpenDocuments".
** This routine gets the direct parameter, parses it up into little FSSpecs,
** and opens each indicated file.  It also shows the technique to be used in
** determining if you are doing everything the AppleEvent record is telling
** you.  Parameters can be divided up into two groups: required and optional.
** Before executing an event, you must make sure that you've read all the
** required events.  This is done by making an "any more?" call to the
** AppleEvent manager. */

#pragma segment AppleEvents
OSErr	OpenDocEventHandler(AppleEvent *message, AppleEvent *reply, short mode)
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

				err = AppOpenDocument(&frHndl, &theFSS, fsRdWrPerm);
				if (err) break;

				gPrintPage = mode;
					/* Open the window off-screen if we are printing. */
				if (err = AppNewWindow(frHndl, &docWindow, (WindowPtr)-1))
					AppDisposeDocument(frHndl);
				else {
					if (gPrintPage) {
						err  = AppPrintDocument(frHndl, (mode == 2), (loop == 1));
						mode = 1;
						AppDisposeDocument(frHndl);
						DisposeAnyWindow(docWindow);
					}
					else AppAutoLaunch(frHndl);
				}
				gPrintPage = 0;
			}
		}
	}
	AppPrintDocument(nil, false, false);	/* Clean up after printing, if we did any. */

	err2 = AEDisposeDesc(&theDesc);
	return(err ? err : err2);
}



