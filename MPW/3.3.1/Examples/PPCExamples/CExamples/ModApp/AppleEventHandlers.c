/*
	File:		AppleEventHandlers.c

	Contains:	Handlers for the 4 "required" events
				(although this app doesn't have documents to print)

	Written by:	Richard Clark

	Copyright:	© 1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				  11/28/93	RC		First release

	To Do:
*/


#ifndef __MIXEDMODE__
	#include <MixedMode.h>
#endif

#ifndef __GESTALTEQU__
	#include <GestaltEqu.h>
#endif

#ifndef __APPLEEVENTS__
	#include <AppleEvents.h>
#endif

#include "ModApp.h"
#include "Prototypes.h"

static pascal OSErr HandleOapp (AEDescList *aevt, AEDescList *reply, long refCon);
static pascal OSErr HandleQuit (AEDescList *aevt, AEDescList *reply, long refCon);
static pascal OSErr HandleOdoc (AEDescList *aevt, AEDescList *reply, long refCon);
static pascal OSErr HandlePdoc (AEDescList *aevt, AEDescList *reply, long refCon);

#ifndef NewEventHandlerProc
	#define NewEventHandlerProc(x) (EventHandlerProcPtr)x
#endif

void InstallAppleEventHandlers()
{
	OSErr	err;
	long	result;

	err = Gestalt(gestaltAppleEventsAttr, &result);
	if (err == noErr) {	
		(void)AEInstallEventHandler(kCoreEventClass, kAEOpenApplication, NewAEEventHandlerProc(HandleOapp), 0, false);
		(void)AEInstallEventHandler(kCoreEventClass, kAEOpenDocuments,   NewAEEventHandlerProc(HandleOdoc), 0, false);
		(void)AEInstallEventHandler(kCoreEventClass, kAEPrintDocuments,  NewAEEventHandlerProc(HandlePdoc), 0, false);
		(void)AEInstallEventHandler(kCoreEventClass, kAEQuitApplication, NewAEEventHandlerProc(HandleQuit), 0, false);
	}
} /* init_apple_events_hook */


pascal OSErr HandleOapp (AEDescList *aevt, AEDescList *reply, long refCon)
{
#pragma unused (aevt, reply, refCon)
	NewDisplayWindow();
	return noErr;
} /* NotHandled */


pascal OSErr HandleOdoc (AEDescList *aevt, AEDescList *reply, long refCon)
// We'll get this if somebody double-clicks on a tool, so create a window and
// load up a tool
{
	#pragma unused (reply, refCon)
	AEDesc		fileListDesc = {'NULL', NULL};
	long		numFiles;
	DescType	actualType;
	long		actualSize;
	AEKeyword	actualKeyword;
	FSSpec		oneFile;
	long		index;
	OSErr		err;
						
	/* The "odoc" and "pdoc" messages contain a list of aliases as the direct paramater.  */
	/* This means that we'll need to extract the list, count the list's elements, and     */
	/* then process each file in turn.																										 */
	
	/* Extract the list of aliases into fileListDesc */
	err = AEGetKeyDesc( aevt, keyDirectObject, typeAEList, &fileListDesc );
	if (err) goto done;
		
	/* Count the list elements */
	err = AECountItems( &fileListDesc, &numFiles);
	if (err) goto done;
				
	/* now get each file from the list and process it. */
	/* Even though the event contains a list of alises, the Apple Event Manager */
	/* will convert each alias to an FSSpec if we ask it to. */
	for (index = 1; index <= numFiles; index ++) {
		err = AEGetNthPtr( &fileListDesc, index, typeFSS, &actualKeyword,
							&actualType, (Ptr)&oneFile, sizeof(oneFile), &actualSize);
		if (err) goto done;
		
		NewDisplayWindow();
		LoadTool(&oneFile, FrontWindow());
	}

done:
	(void)AEDisposeDesc(&fileListDesc);
	return err;
} /* HandleOdoc */


pascal OSErr HandlePdoc (AEDescList *aevt, AEDescList *reply, long refCon)
{
#pragma unused (aevt, reply, refCon)
	return errAEEventNotHandled;
} /* HandlePdoc */


pascal OSErr HandleQuit (AEDescList *aevt, AEDescList *reply, long refCon)
{
#pragma unused (aevt, reply, refCon)
	gDone = true;
	return noErr;
} /* HandleQuit */
