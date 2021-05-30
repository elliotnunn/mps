/*
	file HTMLSample.h
	
	Description:
	This file contains constant declarations and exported routine prototypes
	used in the HTMLSample application.
	
	HTMLSample is an application illustrating how to use the new
	HTMLRenderingLib services found in Mac OS 9. HTMLRenderingLib
	is Apple's light-weight HTML rendering engine capable of
	displaying HTML files.

	by John Montbriand, 1999.

	Copyright: © 1999 by Apple Computer, Inc.
	all rights reserved.
	
	Disclaimer:
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "DSC Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.
	
	Change History (most recent first):
	10/16/99 created by John Montbriand
*/

#ifndef __HTMLSAMPLE__
#define __HTMLSAMPLE__

#include <MacTypes.h>
#include <Events.h>

	/* the resource ID of the main menu bar list. */
enum {
	kMenuBarID = 128
};

	/* the resource id of the main string list */
enum {
	kMainStringList = 128,
	kNavMessageString = 1
};

	/* constants referring to the apple menu */
enum {
	mApple = 128,
	iAbout = 1,
	iFirstAppleItem = 3
};

	/* constants referring to the file menu */
enum {
	mFile = 129,
	iOpen = 1,
	iQuit = 3
};

	/* constants referring to the edit menu */
enum {
	mEdit = 130,
	iUndo = 1,
	iCut = 3,
	iCopy = 4,
	iPaste = 5,
	iClear = 6
};

	/* constants referring to the go menu */
enum {
	mGo = 131,
	iBack = 1,
	iForward = 2,
	iHome = 3,
	iGoSep = 4
};

	/* resource ID numbers for alerts that are called
	to report different error conditions. */
enum {
	kOpenFileErrorAlert = 128,
	kOpenApplicationErrorAlert = 130,
	kNoRenderingLibErrorAlert = 131,
	kNoAboutBoxErrorAlert = 132
};

	/* resource ID numbers for resources containing
	application relative links to files displayed by the
	application.  These resources contain c-style strings. */
enum {
	kCStyleStringResourceType = 'CSTR',
	kDefaultPageURLString = 128,
	kErrorPageURLString = 129
};

/* ParamAlert is a general alert handling routine.  If Apple events exist, then it
	calls AEInteractWithUser to ensure the application is in the forground, and then
	it displays an alert after passing the s1 and s2 parameters to ParamText. */
short ParamAlert(short alertID, StringPtr s1, StringPtr s2);

/* HandleEvent is the main event handling routine for the
	application.  ev points to an event record returned by
	WaitNextEvent. */
void HandleEvent(EventRecord *ev);

#endif
