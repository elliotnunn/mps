/*

	File:		MacFramework.c

	Contains:	Code for the QuickTime sample code framework that is specific to the Macintosh. 
				This code handles windows, menus, events, and other low-level things. Put your
				application-specific code into the file ComApplication.c. 

	Written by:	Tim Monroe
				Based on the QTShell code written by Tim Monroe, which in turn was based on the MovieShell
				code written by Apple DTS (Kent Sandvik). This current version is now very far removed from
				MovieShell.

	Copyright:	Copyright © 2001 by Apple Computer, Inc., All Rights Reserved.

	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
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
*/

//////////
//
// header files
//
//////////

#include "MacFramework.h"


//////////
//
// global variables
//
//////////

Boolean 			gShuttingDown = false;				// are we shutting down?
Boolean				gAppInForeground;					// is our application in the foreground?	
Boolean				gHasNewDialogCalls;					// are the new Dialog Manager functions available?

Str255 				gWindowTitle = kDefaultWindowTitle;	// default name for created windows
Rect 				gWindowRect = kDefaultWindowRect;	// default rectangle for created windows
GrowZoneUPP			gAppGrowZoneUPP;					// UPP to our grow zone callback
ModalFilterUPP		gModalFilterUPP;					// UPP to our custom dialog event filter
UserItemUPP			gUserItemProcUPP;					// UPP to our custom dialog user item procedure
Handle				gEmergencyMemory;					// handle to our emergency memory reserve

short 				gAppResFile = kInvalidFileRefNum;	// file reference number for this application's resource file
FSSpec				gAppFSSpec;							// file specification for the application itself
Str255				gAppName;							// the name of this application

long				gMouseClickTime;					// for double-click calculation
extern OSType 		*gValidFileTypes;					// the list of file types that our application can open


//////////
//
// main
// The main function for this application.
//
// Set up the application's execution environment; make sure QuickTime (etc.) is installed,
// then start handling events.
//
//////////

void main (void)
{
	OSErr		myErr = noErr;
	
	QTFrame_InitMacEnvironment(10L);
	
#if 0	
	// make sure that QuickTime is available and that we can initialize it
	if (!QTUtils_IsQuickTimeInstalled()) {
		QTFrame_ShowWarning("\pQuickTime is not installed on this computer. Exiting.", 0);
		ExitToShell();
	}

#if TARGET_CPU_PPC	
	if (!QTUtils_IsQuickTimeCFMInstalled()) {
		QTFrame_ShowWarning("\pThe QuickTime PowerPlug extension is not installed on this computer. Exiting.", 0);
		ExitToShell();
	}
#endif 
#endif

	myErr = EnterMovies();
	if (myErr != noErr) {
		QTFrame_ShowWarning("\pCould not initialize QuickTime. Exiting.", myErr);
		ExitToShell();
	}

	// do any application-specific initialization
	QTApp_Init(kInitAppPhase_BothPhases);

	// get and process events until the user quits
	QTFrame_MainEventLoop();
	
	ExitMovies();
	ExitToShell();
}


//////////
//
// QTFrame_InitMacEnvironment
// Initialize the Macintosh runtime environment.
//
//////////

static void QTFrame_InitMacEnvironment (long theNumMoreMasters)
{
#if TARGET_API_MAC_CARBON
#pragma unused(theNumMoreMasters)
#endif

	short			myVRefNum;
	long			myDirID;

#if !TARGET_API_MAC_CARBON	
	long			myIndex;

	// add more space to the stack
	SetApplLimit((Ptr)(GetApplLimit() - kExtraStackSpaceSize));
			
	// expand heap zone to its limit
	MaxApplZone();
	
	// allocate some additional master pointer blocks
	for (myIndex = 0; myIndex < theNumMoreMasters; myIndex++)
		MoreMasters();

	InitGraf(&qd.thePort);
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(NULL);
#endif
	InitCursor();

	// initialize and install the menu bar
	QTFrame_InitMenuBar();

#if !TARGET_API_MAC_CARBON
	// install a grow zone procedure to handle low memory situations
	gEmergencyMemory = NewHandle(kEmergencyMemorySize);
	if (gEmergencyMemory != NULL) {
		gAppGrowZoneUPP = NewGrowZoneProc(QTFrame_GrowZoneProcedure);
		SetGrowZone(gAppGrowZoneUPP);
	}
#endif
	
	// initialize foreground/background state
	gAppInForeground = true;

	// see whether the new Dialog Manager functions are available
#if TARGET_API_MAC_CARBON
	gHasNewDialogCalls = true;
#else
	gHasNewDialogCalls = QTUtils_TrapAvailable(_DialogDispatch);
#endif
		
	// create modal dialog filter and user item UPPs
	gModalFilterUPP = NewModalFilterUPP(QTFrame_StandardModalDialogEventFilter);
	gUserItemProcUPP = NewUserItemUPP(QTFrame_StandardUserItemProcedure);

	// get the application's resource file
	gAppResFile = CurResFile();
	
	// get the application's name from the resource file
	GetIndString(gAppName, kAppNameResID, kAppNameResIndex);
	
	// get the application's location and save it in gAppFSSpec
	HGetVol(NULL, &myVRefNum, &myDirID);
	FSMakeFSSpec(myVRefNum, myDirID, gAppName, &gAppFSSpec);
}


//////////
//
// QTFrame_GrowZoneProcedure
// A grow zone procedure. This is straight out of IM: Memory (pp. 1-46ff)
//
//////////

PASCAL_RTN long QTFrame_GrowZoneProcedure (Size theBytesNeeded)
{
#pragma unused(theBytesNeeded)

	long		myA5;
	Size		myBytesFreed;
	
	// get current A5; we might get called at a time that A5 isn't valid
	myA5 = SetCurrentA5();
	
	if ((*gEmergencyMemory != NULL) && (gEmergencyMemory != GZSaveHnd())) {
		EmptyHandle(gEmergencyMemory);
		myBytesFreed = kEmergencyMemorySize;
	} else {
		myBytesFreed = 0;						// no more memory to release	
	}	
		
	myA5 = SetA5(myA5);
	
	return(myBytesFreed);
}


//////////
//
// QTFrame_InitMenuBar
// Set up the menu bar. This is straight out of IM: Macintosh Toolbox Essentials (pp. 3-50ff)
//
//////////

static Boolean QTFrame_InitMenuBar (void)
{
	Handle		myMenuBar = NULL;
	long		myResponse;
	OSErr		myErr = noErr;

	myMenuBar = GetNewMBar(kMenuBarResID);

#if TARGET_API_MAC_CARBON	
	// to get the theme-savvy menu bar, we need to call RegisterAppearanceClient.
	RegisterAppearanceClient();
#endif

	if (myMenuBar == NULL)
		return(false);
	
	SetMenuBar(myMenuBar);									// install the menus
	DisposeHandle(myMenuBar);
	
	// see whether we are running under MacOS X;
	// if so, remove the Quit menu item and its preceding separator line
	myErr = Gestalt(gestaltSystemVersion, &myResponse);
	if (myErr == noErr)
		if (myResponse >= 0x00000A00) {
			DeleteMenuItem(GetMenuHandle(kFileMenuResID), MENU_ITEM(IDM_EXIT));
			DeleteMenuItem(GetMenuHandle(kFileMenuResID), MENU_ITEM(IDM_EXIT) - 1);	// the separator line
		}
		
#if !TARGET_API_MAC_CARBON	
	AppendResMenu(GetMenuHandle(kAppleMenuResID), 'DRVR');	// add desk accessory names to Apple menu
#endif
	QTFrame_AdjustMenus(NULL, NULL);
	DrawMenuBar();
	
	return(true);
}


//////////
//
// QTFrame_MainEventLoop
// Retrieve and process events.
//
//////////

static void QTFrame_MainEventLoop (void)
{
	EventRecord				myEvent;
	Boolean					isEventHandled;
	
	while (!gShuttingDown) {
#if !TARGET_API_MAC_CARBON	
		// make sure we've still got our memory reserve; reallocate it if it's been used
		if ((gEmergencyMemory == NULL) || (*gEmergencyMemory == NULL))
			ReallocateHandle(gEmergencyMemory, kEmergencyMemorySize);
#endif
	
		WaitNextEvent(everyEvent, &myEvent, kWNEDefaultSleep, NULL);
		
		// first, perform any application-specific event loop actions
		isEventHandled = QTApp_HandleEvent(&myEvent);
			
		// then, if this event hasn't been handled, let all movie controllers have access to the event
		if (!isEventHandled)
			isEventHandled = QTFrame_CheckMovieControllers(&myEvent);

		// then, if this event hasn't been handled, handle it ourselves
		if (!isEventHandled)
			QTFrame_HandleEvent(&myEvent);
		
	} // while (!gShuttingDown)
}


//////////
//
// QTFrame_MainEventLoop
// Retrieve and process events.
//
//////////

void QTFrame_HandleEvent (EventRecord *theEvent)
{
	WindowPtr				myWindow = NULL;
	WindowObject 			myWindowObject = NULL;
	short					myWindowPart;
	Rect					myScreenRect;
	Rect					myRefreshArea;

	myWindow = FrontWindow();

	switch (theEvent->what) {
		case mouseUp:
			gMouseClickTime = TickCount();		// for double-click calculation
			break;

		case mouseDown:
		
			myWindowPart = FindWindow(theEvent->where, &myWindow);

			// menu bar and window-related events:			
			switch (myWindowPart) {
				case inSysWindow:
#if !TARGET_API_MAC_CARBON
					// a mouse click in a window belonging to a desk accessory
					SystemClick(theEvent, myWindow);
#endif
					break;
					
				case inMenuBar:
					// a mouse click in the menu bar
					QTFrame_AdjustMenus(FrontWindow(), NULL);
					QTFrame_HandleMenuCommand(MenuSelect(theEvent->where));
					break;
					
				case inDrag: {
					Rect 				myRect;
					
					myWindowObject = QTFrame_GetWindowObjectFromWindow(myWindow);
					if (myWindowObject != NULL) {
						
						if ((**myWindowObject).fMovie != NULL)
							GetMovieBox((**myWindowObject).fMovie, &myRect);
						
						if ((**myWindowObject).fGraphicsImporter != NULL)
							GraphicsImportGetNaturalBounds((**myWindowObject).fGraphicsImporter, &myRect);
						
						GetRegionBounds(GetGrayRgn(), &myScreenRect);
						DragAlignedWindow(myWindow, theEvent->where, &myScreenRect, &myRect, NULL);

					} else {
						GetRegionBounds(GetGrayRgn(), &myScreenRect);
						DragWindow(myWindow, theEvent->where, &myScreenRect);
					}
					
					break;							
				}
					
				case inContent:
					if (myWindow != FrontWindow()) {
						SelectWindow(myWindow);
						MacSetPort((GrafPtr)GetWindowPort(myWindow));
					} else {
						QTApp_HandleContentClick(myWindow, theEvent);
					}
					
					break;
				
				case inGoAway:
					if (TrackGoAway(myWindow, theEvent->where)) {
						// if the option key is down, close all open movie windows; otherwise, close just the frontmost
						if (theEvent->modifiers & optionKey)
							QTFrame_CloseMovieWindows();
						else
							QTFrame_DestroyMovieWindow(myWindow);
					}
					break;
			} // end switch(myWindowPart)
			break;

		// system-level events:
		case updateEvt:
			myWindow = (WindowReference)theEvent->message;
			if (myWindow != NULL) {
				RgnHandle		myVisRegion;
				
				// draw an image file
				myWindowObject = QTFrame_GetWindowObjectFromWindow(myWindow);
				if (myWindowObject != NULL)
					if ((**myWindowObject).fGraphicsImporter != NULL)
						GraphicsImportDraw((**myWindowObject).fGraphicsImporter);
				
				myVisRegion = NewRgn();
				GetPortVisibleRegion(GetWindowPort(myWindow), myVisRegion);
				GetRegionBounds(myVisRegion, &myRefreshArea);
				
				QTApp_Draw(myWindow, &myRefreshArea);
				DisposeRgn(myVisRegion);
			}
			break;
			
		case keyDown:
		case autoKey:
			QTFrame_HandleKeyPress(theEvent);
			break;
		
		case diskEvt: {
#if !TARGET_API_MAC_CARBON
			Point			myPoint = {100, 100};
		
			if (HiWord(theEvent->message) != noErr)
				(void)DIBadMount(myPoint, theEvent->message);
#endif
			break;
		}
		
		case activateEvt:
			myWindow = (WindowReference)theEvent->message;
			
		 	if (QTFrame_IsAppWindow(myWindow))
				QTFrame_ActivateController(myWindow, ((theEvent->modifiers & activeFlag) != 0 ));
			break;
			
		case osEvt:
			switch ((theEvent->message >> 24) & 0x00ff) {		// get high byte of message
				case suspendResumeMessage:
				
					// set the foreground/background state
					gAppInForeground = (theEvent->message & resumeFlag) != 0;
					
					// activate the front window, if there is one	
					if (myWindow != NULL)
						QTFrame_ActivateController(myWindow, gAppInForeground);
					break;
				
				case mouseMovedMessage:
					break;
			}
			break;
		
		case kHighLevelEvent:
			AEProcessAppleEvent(theEvent);
			break;
			
		case nullEvent:
			// do idle-time processing for all open movie windows
			myWindow = QTFrame_GetFrontMovieWindow();
			while (myWindow != NULL) {
				if (gAppInForeground)
					QTApp_Idle(myWindow);
					
				myWindow = QTFrame_GetNextMovieWindow(myWindow);
			}
			break;
	} // switch (theEvent->what)
}
		

//////////
//
// QTFrame_HandleMenuCommand
// Handle a menu selection.
//
//////////

void QTFrame_HandleMenuCommand (long theMenuResult)
{
	short		myMenuID, myMenuItem;
	Cursor		myArrow;
	
	MacSetCursor(GetQDGlobalsArrow(&myArrow));

	myMenuID = HiWord(theMenuResult);
	myMenuItem = LoWord(theMenuResult);
	
	switch (myMenuID) {
	
		case kAppleMenuResID:
			switch (myMenuItem) {
				case kAboutMenuItem:		// About box
					QTFrame_ShowAboutBox();	 
					break;
				
				default:	 				// Apple menu handling
#if !TARGET_API_MAC_CARBON
					{
						Str255		myDAName;
						
						GetMenuItemText(GetMenuHandle(kAppleMenuResID), myMenuItem, myDAName);
						(void)OpenDeskAcc(myDAName);
					}
#endif
					break;
			}
			break;

		case kFileMenuResID:
			QTFrame_HandleFileMenuItem(QTFrame_GetFrontMovieWindow(), MENU_IDENTIFIER(myMenuID, myMenuItem));
			break;
	
		case kEditMenuResID:
			QTFrame_HandleEditMenuItem(QTFrame_GetFrontMovieWindow(), MENU_IDENTIFIER(myMenuID, myMenuItem));
			break;

		default:
			// do any application-specific menu handling
			QTApp_HandleMenu(MENU_IDENTIFIER(myMenuID, myMenuItem));
			break;
		
	} // switch (myMenuID)
	
	HiliteMenu(0);
}


//////////
//
// QTFrame_HandleKeyPress
// Handle key presses. This is modelled on Inside Macintosh: Macintosh Toolbox Essentials, p. 3-78.
//
//////////

void QTFrame_HandleKeyPress (EventRecord *theEvent)
{
	char		myKey;
	
	myKey = theEvent->message & charCodeMask;
	
	if (theEvent->modifiers & cmdKey) {
		// if the command key is down, it must be a keyboard shortcut for a menu selection;
		// adjust the menus and find the menu command that the shortcut picks out
		QTFrame_AdjustMenus(FrontWindow(), NULL);
		QTFrame_HandleMenuCommand(MenuKey(myKey));
	} else {
		// otherwise, we'll assume it's meant for our application
		QTApp_HandleKeyPress(myKey);
	}
}


//////////
//
// QTFrame_QuitFramework
// Do any framework-specific shut-down.
//
//////////

void QTFrame_QuitFramework (void)
{
	// set our global flag to indicate we're shutting down
	gShuttingDown = true;
	
	// do application-specific processing that must occur before movie windows are closed
	QTApp_Stop(kStopAppPhase_BeforeDestroyWindows);
	
	// close all open movie windows; note that the user can cancel the shutting down
	QTFrame_CloseMovieWindows();
		
	// test the quit flag; a call to QTFrame_DestroyMovieWindow may have reset it
	if (!gShuttingDown)
		return;
	
	// do application-specific processing that must occur after movie windows are closed
	QTApp_Stop(kStopAppPhase_AfterDestroyWindows);

	// release our list of valid file types
	if (gValidFileTypes != NULL)
		DisposePtr((Ptr)gValidFileTypes);

#if !TARGET_API_MAC_CARBON	
	// release the grow zone memory
	DisposeHandle(gEmergencyMemory);
#endif
	
	// release any routine descriptors
	DisposeGrowZoneUPP(gAppGrowZoneUPP);
	DisposeModalFilterUPP(gModalFilterUPP);
	DisposeUserItemUPP(gUserItemProcUPP);	
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Framework utilities.
//
// The framework uses the following functions to create movies and handle dialog boxes. You probably won't
// need to use them directly.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////
//
// QTFrame_CreateMovieWindow
// Create a new window to display the movie in.
//
//////////

WindowReference QTFrame_CreateMovieWindow (void)
{
	WindowReference			myWindow = NULL;
	WindowObject			myWindowObject = NULL;
	
	// create a new window to display the movie in
	myWindow = NewCWindow(NULL,
							&gWindowRect,
							gWindowTitle,
							false,
							noGrowDocProc,
							(WindowPtr)-1L,
							true,
							0);

	// create a new window object associated with the new window
	QTFrame_CreateWindowObject(myWindow);

	return(myWindow);
}


//////////
//
// QTFrame_DestroyMovieWindow
// Close the specified movie window.
//
//////////

void QTFrame_DestroyMovieWindow (WindowReference theWindow)
{
	WindowObject		myWindowObject = NULL;
	OSErr				myErr = noErr;
	
	// get the window object associated with the specified window
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject == NULL) {
		// if the window passed in isn't a movie window, just dispose of it and return
		if (theWindow != NULL) {
			DisposeWindow(theWindow);
			theWindow = NULL;
		}
		return;
	}
	
	// if the window's data is "dirty", give the user a chance to save it
	if ((**myWindowObject).fIsDirty) {
		Str255						myString;
		NavAskSaveChangesAction		myAction;
		NavAskSaveChangesResult		myResult;
		NavDialogOptions			myDialogOptions;
		NavEventUPP					myEventUPP = NewNavEventUPP(QTFrame_HandleNavEvent);

		// get the title of the window
		GetWTitle(theWindow, myString);
		
		// install the application and document names
		NavGetDefaultDialogOptions(&myDialogOptions);
		BlockMoveData(gAppName, myDialogOptions.clientName, gAppName[0] + 1);
		BlockMoveData(myString, myDialogOptions.savedFileName, myString[0] + 1);
		
		// specify the action
		myAction = gShuttingDown ? kNavSaveChangesQuittingApplication : kNavSaveChangesClosingDocument;
		
		// display the "Save changes" dialog box
		myErr = NavAskSaveChanges(&myDialogOptions, myAction, &myResult, myEventUPP, NULL);
		if (myErr != noErr)
			myResult = kNavAskSaveChangesCancel;
			
		switch (myResult) {
			case kNavAskSaveChangesSave:
				// save the data in the window
				QTFrame_UpdateMovieFile(theWindow);
				break;
				
			case kNavAskSaveChangesCancel:
				// do not close the window, and do not quit the application
				gShuttingDown = false;
				return;
				
			case kNavAskSaveChangesDontSave:
				// discard any unsaved changes (that is, don't do anything)
				break;
		}

		DisposeNavEventUPP(myEventUPP);
	}

	// if we got to this point, it's okay to close and destroy the window
	QTFrame_CloseWindowObject(myWindowObject);

	DisposeWindow(theWindow);
}


//////////
//
// QTFrame_StandardUserItemProcedure
// A standard user-item procedure to outline the OK button in a modal dialog.
//
//////////

PASCAL_RTN void QTFrame_StandardUserItemProcedure (DialogPtr theDialog, short theItem)
{
#pragma unused(theItem)

	short				myItemKind;			// for GetDialogItem
	Handle				myItemHandle;		// for GetDialogItem
	Rect				myItemRect;			// for GetDialogItem

	if (!gHasNewDialogCalls) {		// no need to do any of this if the new Dialog Manager calls are available
		GetDialogItem(theDialog, kStdOkItemIndex, &myItemKind, &myItemHandle, &myItemRect);		
		MacInsetRect(&myItemRect, -4, -4);
		PenSize(3, 3);
		FrameRoundRect(&myItemRect, 16, 16);
		PenSize(1, 1);
	}
}


//////////
//
// QTFrame_StandardModalDialogEventFilter
// A standard modal dialog event filter. 
//
//////////

PASCAL_RTN Boolean QTFrame_StandardModalDialogEventFilter (DialogPtr theDialog, EventRecord *theEvent, short *theItemHit)
{
	Boolean				myEventHandled = false;
	short				myItemKind;			// for GetDialogItem
	Handle				myItemHandle;		// for GetDialogItem
	Rect				myItemRect;			// for GetDialogItem
	unsigned long		myTicks;			// for Delay
	char				myKey;		
	WindowReference		myWindow = NULL;
	short				myPart;	
	OSErr				myErr = noErr;
		
	switch (theEvent->what) {
		case updateEvt:
			// update the specified window, if it's behind the modal dialog box
			myWindow = (WindowReference)theEvent->message;
			if ((myWindow != NULL) && (myWindow != GetDialogWindow(theDialog))) {
				QTFrame_HandleEvent(theEvent);
				myEventHandled = false;		// so sayeth IM
			}
			break;

		case nullEvent:
			// do idle-time processing for all open windows in our window list
			if (gAppInForeground) 
				QTFrame_IdleMovieWindows();

			myEventHandled = false;
			break;
			
		case keyDown:
		case autoKey:
			// if new Dialog Manager calls are NOT available, handle certain key presses
			if (!gHasNewDialogCalls) {
				// first, map Command-period to Escape key...
				myKey = theEvent->message & charCodeMask;
				if (theEvent->modifiers & cmdKey)
					if (myKey == kPeriod)
						myKey = kEscapeKey;
						
				// ...then, handle the standard keyboard equivalents of OK and Cancel buttons
				switch (myKey) {
					case kReturnKey:
					case kEnterKey:
						*theItemHit = kStdOkItemIndex;
						GetDialogItem(theDialog, kStdOkItemIndex, &myItemKind, &myItemHandle, &myItemRect);
						HiliteControl((ControlHandle)myItemHandle, kControlButtonPart);
						Delay(kMyButtonDelay, &myTicks);
						HiliteControl((ControlHandle)myItemHandle, kControlNoPart);
						myEventHandled = true;
						break;
					case kEscapeKey:
						*theItemHit = kStdCancelItemIndex;
						GetDialogItem(theDialog, kStdCancelItemIndex, &myItemKind, &myItemHandle, &myItemRect);
						HiliteControl((ControlHandle)myItemHandle, kControlButtonPart);
						Delay(kMyButtonDelay, &myTicks);
						HiliteControl((ControlHandle)myItemHandle, kControlNoPart);
						myEventHandled = true;
						break;
					default:
						break;
				}
			}
			break;
			
		case mouseDown:
			myPart = FindWindow(theEvent->where, &myWindow);
			if ((myPart == inDrag) && (myWindow == GetDialogWindow(theDialog))) {
				Rect		myScreenRect;
				
				GetRegionBounds(GetGrayRgn(), &myScreenRect);
				DragWindow(myWindow, theEvent->where, &myScreenRect);
				myEventHandled = true;
			}
			break;
			
		default:
			myEventHandled = false;
			break;
	}	
	
	// let the OS's standard filter proc handle the event, if it hasn't already been handled
	if (gHasNewDialogCalls && (myEventHandled == false))
		myEventHandled = StdFilterProc(theDialog, theEvent, theItemHit);
	
	return(myEventHandled);
}


//////////
//
// QTFrame_CheckMovieControllers
// Let all movie controllers have a chance to process the event.
//
// Returns true if the event was handled by some movie controller, false otherwise
//
//////////

static Boolean QTFrame_CheckMovieControllers (EventRecord *theEvent)
{	
	WindowPtr				myWindow = NULL;
	MovieController			myMC = NULL;
	
	myWindow = QTFrame_GetFrontMovieWindow();
	while (myWindow != NULL) {
		myMC = QTFrame_GetMCFromWindow(myWindow);
		if (myMC != NULL)
			if (MCIsPlayerEvent(myMC, theEvent))
				return(true);
		
		myWindow = QTFrame_GetNextMovieWindow(myWindow);
	}
	
	return(false);
}


//////////
//
// QTFrame_ShowAboutBox
// Display and manage the About dialog box.
//
//////////

void QTFrame_ShowAboutBox (void)
{
	DialogPtr			myDialog = NULL;
	short 				myItem;
	short 				mySavedResFile;
	GrafPtr				mySavedPort;
	short				myItemKind;
	Handle				myItemHandle;
	Rect				myItemRect;
	
	// get the current resource file and port
	mySavedResFile = CurResFile();
	GetPort(&mySavedPort);
	
	// set the application's resource file;
	// otherwise, we'd get the dialog's resources from the current resource file,
	// which might not be the correct one....
	UseResFile(gAppResFile);
	
	// deactivate any frontmost movie window
	QTFrame_ActivateController(QTFrame_GetFrontMovieWindow(), false);
	
	myDialog = GetNewDialog(kAboutBoxID, NULL, (WindowPtr)-1L);
	if (myDialog == NULL)
		goto bail;
		
	SetPortDialogPort(myDialog);
		
	if (gHasNewDialogCalls)
		SetDialogDefaultItem(myDialog, kStdOkItemIndex);
	
	// make sure that the OK button is outlined in bold, even if new Dialog Manager calls not available
	GetDialogItem(myDialog, kOKButtonUserItem, &myItemKind, &myItemHandle, &myItemRect);
	SetDialogItem(myDialog, kOKButtonUserItem, myItemKind, (Handle)gUserItemProcUPP, &myItemRect);

	// display and handle events in the dialog box until the user clicks OK
	do {
		ModalDialog(gModalFilterUPP, &myItem);
	} while (myItem != kStdOkItemIndex);
	
bail:
	// restore the previous resource file and port
	MacSetPort(mySavedPort);
	UseResFile(mySavedResFile);
	
	if (myDialog != NULL)
		DisposeDialog(myDialog);
}


//////////
//
// QTFrame_ShowWarning
// Display a warning box.
//
//////////

void QTFrame_ShowWarning (Str255 theMessage, OSErr theErr)
{
	Str255				myString;
	short 				mySavedResFile;
	
	// get the current resource file and set the application's resource file
	mySavedResFile = CurResFile();
	UseResFile(gAppResFile);

	// insert argument into the message text template, to get the message text
	NumToString(theErr, myString);
	ParamText("\pWarning!", theMessage, theErr ? myString: NULL, NULL);

	// display the dialog box
	Alert(kAlertErrorID, gModalFilterUPP);
	
	// restore the original resource file
	UseResFile(mySavedResFile);
}

