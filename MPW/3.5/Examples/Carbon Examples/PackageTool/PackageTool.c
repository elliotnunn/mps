/*
    File: PackageTool.c
    
    Description:
        This file contains the main event dispatching code used in the PackageTool
	application.
	
	PackageTool is an application illustrating how to create application
	packages in Mac OS 9.  It provides a simple interface for converting
	correctly formatted folders into packages and vice versa.

    Copyright:
        © Copyright 1999 Apple Computer, Inc. All rights reserved.
    
    Disclaimer:
        IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
        ("Apple") in consideration of your agreement to the following terms, and your
        use, installation, modification or redistribution of this Apple software
        constitutes acceptance of these terms.  If you do not agree with these terms,
        please do not use, install, modify or redistribute this Apple software.

        In consideration of your agreement to abide by the following terms, and subject
        to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
        copyrights in this original Apple software (the "Apple Software"), to use,
        reproduce, modify and redistribute the Apple Software, with or without
        modifications, in source and/or binary forms; provided that if you redistribute
        the Apple Software in its entirety and without modifications, you must retain
        this notice and the following text and disclaimers in all such redistributions of
        the Apple Software.  Neither the name, trademarks, service marks or logos of
        Apple Computer, Inc. may be used to endorse or promote products derived from the
        Apple Software without specific prior written permission from Apple.  Except as
        expressly stated in this notice, no other rights or licenses, express or implied,
        are granted by Apple herein, including but not limited to any patent rights that
        may be infringed by your derivative works or by other works in which the Apple
        Software may be incorporated.

        The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
        WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
        WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
        PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
        COMBINATION WITH YOUR PRODUCTS.

        IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
        CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
        GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
        ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
        OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
        (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
        ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

    Change History (most recent first):
        Fri, Dec 17, 1999 -- created
*/


#include "PackageTool.h"
#include "Utilities.h"

//#include <Fonts.h>
//#include <Dialogs.h>
//#include <PLStringFuncs.h>
//#include <TextUtils.h>
//#include <Gestalt.h>
//#include <StdIO.h>
//#include <Devices.h>
//#include <Appearance.h>
//#include <Resources.h>
//#include <Navigation.h>

#include "SimplePrefs.h"
#include "PackageUtils.h"
#include "PackageWindow.h"


	/* application's globals */
Boolean gRunning = true; /* true while the application is running, set to false to quit */
Collection gPreferences = NULL; /* main preferences collection, saved in the prefs file.  */
Boolean gIsFrontProcess = true;


/* GetCollectedPreferences returns the collection that is used for storing
	application preferences. */
Collection GetCollectedPreferences(void) {
	return gPreferences;
}

/* IsFrontProcess returns true when our
	application is the frontmost process. */
Boolean IsFrontProcess(void) {
	return gIsFrontProcess;
}




/* OpenDocumentList is called when the application receives a document a list of
	documents to open.  */
OSErr OpenDocumentList(AEDescList *documents) {
	OSErr err;
	long n;
	FSSpec fileSpec, packageSpec;
	AEKeyword keyWd;
	DescType typeCd;
	Size actSz;
		
		/* count the documents in the list, there must be at least one */
	err = AECountItems(documents, &n);
	if (err != noErr) goto bail;
	if (n == 0) { err = paramErr; goto bail; }
		/* get the first one */
	err = AEGetNthPtr(documents, 1, typeFSS, &keyWd, &typeCd,
		(Ptr) &fileSpec, sizeof(fileSpec), (actSz = sizeof(fileSpec), &actSz));
	if (err != noErr) goto bail;
	
		/* set the display */
	if (IdentifyPackage(&fileSpec, &packageSpec))
		SetNewDisplay(&fileSpec);
	else if (FSSpecIsAFolder(&fileSpec))
		SetNewDisplay(&fileSpec);
	else SetNewDisplay(NULL);

bail:
	return err;
}




/* ResetMenus is called to reset the menus immediately before
	either MenuSelect or MenuKey is called. */
static void ResetMenus(void) {
		/* Here, we set the file selection item depending on
		the availability of navigation services.  */
	if (NavServicesAvailable())
		EnableMenuItem(GetMenuHandle(mFile), iSelect);
	else DisableMenuItem(GetMenuHandle(mFile), iSelect);
}


/* DoMenuCommand is called after either MenuSelect of MenuKey.  The
	parameter rawMenuSelectResult is the result from one of these two routines. 
	DoMenuCommand parses this result into its two parts, and dispatches
	the menu command as appropriate. */
static void DoMenuCommand(long rawMenuSelectResult) {
	short menu, item;
		/* decode the MenuSelect result */
	menu = (rawMenuSelectResult >> 16);
	if (menu == 0) return;
	item = (rawMenuSelectResult & 0x0000FFFF);
		/* dispatch on result */
	switch (menu) {
		case mApple:
			if (item == iAbout) {
					/* show the about box. */
				ParamAlert(kAboutBoxAlert, NULL, NULL);
			}
			break;
		case mFile:
			if (item == iSelect) {
				SelectFolderOrPackage();
			} else if (item == iQuit)
				gRunning = false; /* file.quit == quit */
			break;
		case mEdit:
			if (item == iClear)
				SetNewDisplay(NULL); /* edit.clear == clear the display */
			break;
	}
		/* unhilite the menu once we're done the command */
	HiliteMenu(0);
}







/* OpenApplication is an apple event handler called for 'open application' apple events. */
static pascal OSErr OpenApplication(const AppleEvent *appleEvt, AppleEvent* reply, long refcon) {
	return noErr;
}

/* CloseApplication is an apple event handler called for 'close application' apple events. */
static pascal OSErr CloseApplication(const AppleEvent *appleEvt, AppleEvent* reply, long refcon) {
	gRunning = false;
	return noErr;
}


/* OpenDocument is called for 'odoc' Apple events.  We install this routine
	as our open document apple event handler when our application starts up. */
static pascal OSErr OpenDocument(const AppleEvent *appleEvt, AppleEvent* reply, long refcon) {
	OSErr err;
	AEDescList documents;
	
		/* initial state */
	AECreateDesc(typeNull, NULL, 0, &documents);
	
		/* get the document list */
	err = AEGetParamDesc(appleEvt, keyDirectObject, typeAEList, &documents);
	if (err != noErr) goto bail;
	
		/* call our document opener routine */
	err = OpenDocumentList(&documents);

bail:
	AEDisposeDesc(&documents);
	return err;
}


/* EVENT HANDLING ------------------------------------------------ */


/* HandleNextEvent handles the event in the event record *ev dispatching
	the event to appropriate routines.   */
void HandleNextEvent(EventRecord *ev) {
	DialogPtr theDialog;
	WindowPtr theWindow;
	short itemNo;
	
		/* dialog pre-processing */
	if (((ev->what == keyDown) || (ev->what == autoKey)) && ((ev->modifiers & cmdKey) != 0)) {
		ResetMenus();
		DoMenuCommand(MenuKey((char) (ev->message & charCodeMask)));
	} else if (ev->what == osEvt) {
		WindowPtr target;
		if ( ((ev->message >> 24) & 0x0FF) == suspendResumeMessage ) {
			gIsFrontProcess = (ev->message & resumeFlag) != 0;/* switching in */
			target = FrontWindow();
			if (IsPackageWindow(target))
				ActivatePackageWindow(target, gIsFrontProcess);
		}
	} else if (ev->what == activateEvt) {
		WindowPtr target;
		target = (WindowPtr) ev->message;
		if (IsPackageWindow(target))
			ActivatePackageWindow(target, ((ev->modifiers & activeFlag) != 0));
	}

		/* handle clicks in the dialog window */
	if (IsDialogEvent(ev))
		if (DialogSelect(ev, &theDialog, &itemNo)) {
			if (IsPackageWindow(GetDialogWindow(theDialog)))
				HitPackageWindow(theDialog, ev, itemNo);
		}

		/* clicks and apple events... */
	if (ev->what == kHighLevelEvent) {
		AEProcessAppleEvent(ev);
	} else if (ev->what == mouseDown)
		switch (FindWindow(ev->where, &theWindow)) {
			
				/* menu bar clicks */
			case inMenuBar:
				ResetMenus();
				DoMenuCommand(MenuSelect(ev->where));
				break;
				
				/* clicks in the close box, close the app */
			case inGoAway:
				if (TrackGoAway(theWindow, ev->where)) {
					gRunning = false;
				}
				break;
				
				/* allow window drags */
			case inDrag:
				if (theWindow == FrontWindow()) {
					Rect boundsRect = { -32000, -32000, 32000, 32000};
					DragWindow(theWindow, ev->where, &boundsRect);
				}
				break;
		}
}




/* MyIdleProc is the idle procedure called by AEInteractWithUser while we are waiting
	for the application to be pulled into the forground.  It simply passes the event along
	to HandleNextEvent */
static pascal Boolean MyIdleProc(EventRecord *theEvent, long *sleepTime, RgnHandle *mouseRgn) {
	HandleNextEvent(theEvent);
	return false;
}

/* ParamAlert is a general alert handling routine.  If Apple events exist, then it
	calls AEInteractWithUser to ensure the application is in the forground, and then
	it displays an alert after passing the s1 and s2 parameters to ParamText. */
OSStatus ParamAlert(short alertID, StringPtr s1, StringPtr s2) {
	AEIdleUPP theIdleUPP;
	OSStatus err;
	theIdleUPP = NewAEIdleUPP(MyIdleProc);
	if (theIdleUPP == NULL) { err = memFullErr; goto bail; }
	err = AEInteractWithUser(kNoTimeOut, NULL, theIdleUPP);
	if (err != noErr) goto bail;
	ParamText(s1, s2, NULL, NULL);
	err = Alert(alertID, NULL);
	DisposeAEIdleUPP(theIdleUPP);
	return err;
bail:
	if (theIdleUPP != NULL) DisposeAEIdleUPP(theIdleUPP);
	return err;
}




/* main program */

int main(void) {
	OSErr err;
	long response;
	AEEventHandlerUPP aehandler;
	
		/* set up the managers */
	InitCursor();
		
		/* Packages are not supported in versions of the Finder
		prior to Mac OS 9.  Although it may be possible to run a
		Carbon application on */
	if (Gestalt('sysv', &response) != noErr) response = 0;
	if (response < 0x0900) {
		Str255 message;
		GetIndString(message, kMainStringList, kMustHaveOS9);
		ParamAlert(kGenericAlert, message, NULL);
		err = userCanceledErr;
		goto bail;
	}
	
		/* Apple event handlers */
	aehandler = NewAEEventHandlerUPP(OpenApplication);
	if (aehandler == NULL) { err = memFullErr; goto bail; }
	err = AEInstallEventHandler(kCoreEventClass, kAEOpenApplication, aehandler, 0, false);
	if (err != noErr) goto bail;
	aehandler = NewAEEventHandlerUPP(CloseApplication);
	if (aehandler == NULL) { err = memFullErr; goto bail; }
	err = AEInstallEventHandler(kCoreEventClass, kAEQuitApplication, aehandler, 0, false);
	if (err != noErr) goto bail;
	aehandler = NewAEEventHandlerUPP(OpenDocument);
	if (aehandler == NULL) { err = memFullErr; goto bail; }
	err = AEInstallEventHandler(kCoreEventClass, kAEOpenDocuments, aehandler, 0, false);
	if (err != noErr) goto bail;

		/* get our preferences */	
	gPreferences = NewCollection();
	if (gPreferences == NULL) { err = memFullErr; goto bail; }
	GetPreferences(kAppPrefsType, kAppCreatorType, gPreferences);

		/* ***** set up the menu bar ***** */
	SetMenuBar(GetNewMBar(kMenuBarResource));
	DrawMenuBar();
	
		/* open the window */
	err = CreatePackageWindow();
	if (err != noErr) {
		Str255 errStr;
		NumToString(err, errStr);
		ParamAlert(kOpenAppFailedAlert, errStr, NULL);
	}

		/* run the main loop */
	while (gRunning) {
		EventRecord ev;
			/* get the next event */
		if ( ! WaitNextEvent(everyEvent, &ev,  GetCaretTime(), NULL) )
			ev.what = nullEvent;
		HandleNextEvent(&ev);
	}
	
		/* all done */
	ClosePackageWindow();
	UnregisterAppearanceClient();
	SavePreferences(kAppPrefsType, kAppCreatorType, "\pPackageTool Preferences", gPreferences);
	DisposeCollection(gPreferences);
	ExitToShell();
	return 0;
bail:
	if (err != userCanceledErr) {
		Str255 errStr;
		NumToString(err, errStr);
		ParamAlert(kMainFailedAlert, errStr, NULL);
	}
	ExitToShell();
	return 1;
}

