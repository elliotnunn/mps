/* ------------------------------------------------------------------------
	Apple Worldwide Developer Technical Support

	Multi-Lingual Text Editor Sample, Carbon version

	This file: MLTESampleCarbon.c

	Versions:	1.0		12/99

	Components:
				MLTESampleCarbon.mcp		Dec 17, 1999
				MLTESampleCarbon.c			Dec 17, 1999
				MLTESampleCarbon.h			Dec 17, 1999
				MLTESampleCarbon.rsrc		Dec 17, 1999

	MLTESampleCarbon is an example application that demonstrates the 
	fundamental MLTE toolbox calls in a CarbonLib context; it does 
	not demonstrate all the techniques you need for a large application.
	
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
				
	Copyright © 1999-2000 Apple Computer, Inc., All Rights Reserved
	
--------------------------------------------------------------------------- */
//#define TARGET_API_MAC_CARBON 1
#include "MLTESampleCarbon.h"

void main(void)
{	
	Initialize();
	EventLoop();	// call the main event loop
}

void Initialize()
{
	Handle	menuBar;
	MenuRef	menu;
	long	response;
	OSErr 	err;

	InitCursor();
	InstallAppleEventHandlers();
	if (TXNVersionInformation == (void*)kUnresolvedCFragSymbolAddress) // Check for availability of MLTE api
		BigBadError(eWrongSystem);
		
    InitMLTE(); 							// default settings for MLTE
	
	menuBar = GetNewMBar(rMenuBar);			// read in menubar definition
	if (menuBar == NULL)
		BigBadError(eNoMemory);
	SetMenuBar(menuBar);					// install menus
	DisposeHandle(menuBar);
	
	err = Gestalt(gestaltMenuMgrAttr, &response);
	if ((err == noErr) && (response & gestaltMenuMgrAquaLayoutMask))
	{
		menu = GetMenuHandle(mFile);
		DeleteMenuItem(menu, iQuit);
		DeleteMenuItem(menu, iQuitSeparator);		// if on X, accomodate Aqua Quit interface
	}

	// Get a new TXNFontMenuObject...
	// A TXNFontMenuObject is an opaque structure that describes and handles 
	// all aspects of user interaction with a Font menu. The menu is created 
	// dynamically. The application provides the menu title, the menu ID, and 
	// the menu ID to use if any hierarchical menus are created.  Hierarchical 
	// menus are created on systems with ATSUI.
	err = TXNNewFontMenuObject(GetMenuHandle(mFont), mFont, kStartHierMenuID, &gTXNFontMenuObject);
	if (err != noErr)
		BigBadError(eNoMemory);
	DrawMenuBar();

	gInBackground = false;	
	gNumDocuments = 0;
	
	DoNew(NULL);							// create a single empty document	
}

void InitMLTE(void)
{
	OSStatus							status;
	TXNMacOSPreferredFontDescription	defaults;  // fontID, pointSize, encoding, and fontStyle
        TXNInitOptions options;

	defaults.fontID = kTXNDefaultFontName;
  	defaults.pointSize = kTXNDefaultFontSize;
  	defaults.encoding = CreateTextEncoding(kTextEncodingMacRoman, kTextEncodingDefaultVariant, kTextEncodingDefaultFormat);
  	defaults.fontStyle 	= kTXNDefaultFontStyle;

	options = kTXNWantMoviesMask | kTXNWantSoundMask | kTXNWantGraphicsMask;

	status = TXNInitTextension(&defaults, 1, options);
	if (status != noErr)
		BigBadError(eNoMLTE);
}

// Get events forever, handle in DoEvent. Call AdjustCursor each time.
void EventLoop()
{
	RgnHandle	cursorRgn;
	Boolean		gotEvent;
	EventRecord	event;

	cursorRgn = NewRgn();			// pass WNE an empty region 1st time thru

	do {
		gotEvent = WaitNextEvent(everyEvent, &event, GetSleep(), cursorRgn);

		if (gotEvent)
		{
			// make sure we have the right cursor before handling the event
			AdjustCursor(cursorRgn);
			DoEvent(&event);
		}
		else
		{
			DoIdle();				// perform idle tasks when it’s not our event
		// DG	TXNTSMCheck(NULL, &event); // No longer necessary for CarbonLib 1.1
		}
	} while (true);					// loop forever... we quit via ExitToShell
}

// Determine what kind of event we have, and call the appropriate routines.
void DoEvent(EventRecord *event)
{
	short		part;
	WindowPtr	window;
	Boolean isDialogEvent;
	
	isDialogEvent = IsDialogEvent(event);
	
	if (isDialogEvent) 
	{
		DialogPtr	theDialog = NULL;
		short		itemHit;
		Boolean		result;

		result = DialogSelect(event, &theDialog, &itemHit);
	}
	switch (event->what) {
		case nullEvent:
			// we idle for null/mouse moved events and for events which aren’t ours
			DoIdle();
			break;
		case mouseDown:
			part = FindWindow(event->where, &window);
			switch (part) {
				case inMenuBar:             // process a mouse menu command (if any)
					AdjustMenus();			// bring ’em up-to-date
					DoMenuCommand(MenuSelect(event->where));
					break;
				case inContent:
					if (window != FrontWindow()) 
						SelectWindow(window);
					else
					{
						DoContentClick(window, event);
						AdjustMenus();
					}
					break;
				case inDrag:                // pass screenBits.bounds to get all gDevices
					BitMap	screenBits;
                            
                    GetQDGlobalsScreenBits(&screenBits);
					DragWindow(window, event->where, &screenBits.bounds);
					break;
				case inGoAway:
					if (TrackGoAway(window, event->where))
						DoCloseWindow(window); // we don’t care if the user cancelled
					break;
				case inGrow:
					DoGrowWindow(window, event);
					break;
				case inZoomIn:
				case inZoomOut:
					if (TrackBox(window, event->where, part))
						DoZoomWindow(window, part);
					break;
			}
			break;
		case keyDown:
		case autoKey:                       // check for menukey equivalents 
			if (event->modifiers & cmdKey)  // Command key down
			{
				if (event->what == keyDown) 
				{
					AdjustMenus();			// enable/disable/check menu items properly
					DoMenuCommand(MenuKey(event->message & charCodeMask));
				}
			} 
		//	else
		//		DoKeyDown(event);
			break;
		case activateEvt:
			DoActivate((WindowPtr) event->message, (event->modifiers & activeFlag) != 0);
			break;
		case updateEvt:
			DoUpdate((WindowPtr) event->message);
			break;
		// handle disk inserted events so uninitialized floppies are recognized.
		case osEvt:
			// 1.02 - must BitAND with 0x0FF to get only low byt
			switch ((event->message >> 24) & 0x0FF) // high byte of message
			{		
				case mouseMovedMessage:
					DoIdle();				// mouse-moved is also an idle event 
					break;
				case suspendResumeMessage:	// suspend/resume is also an activate/deactivate 
					gInBackground = (event->message & resumeFlag) == 0;
					DoActivate(FrontWindow(), !gInBackground);
					break;
			}
			break;
	}
}

//	Change the cursor's shape, depending on its position.
void AdjustCursor(RgnHandle region)
{
	WindowPtr	window = FrontWindow();			// only adjust the cursor when we are in front
	TXNObject object = NULL;
	
	if (IsAppWindow(window, &object)) 
		TXNAdjustCursor(object, region);
}

// Handle a mouseDown in the grow box of an active window.
void DoGrowWindow(WindowPtr window, EventRecord *event)
{
	TXNObject	object = NULL;
	
	if (IsAppWindow(window, &object))
		// Should only be called for a TXNObject whose view rect occupies the entire
		// window (e.g., a window is passed to TXNNewObject with a NULL FrameRect.)
		TXNGrowWindow(object, event);
}

// Handle a mouseClick in the zoom box of an active window.
void DoZoomWindow(WindowPtr window, short part)
{
	TXNObject	object = NULL;
	
	if (IsAppWindow(window, &object)) 
		// Should only be called for a TXNObject whose view rect occupies the entire
		// window (e.g., a window is passed to TXNNewObject with a NULL FrameRect.)
		TXNZoomWindow(object, part);
}

// Called when an update event is received for a window.
void DoUpdate(WindowPtr window)
{
	GrafPtr		savePort;
	TXNObject	object = NULL;
	
	GetPort(&savePort);
	
	if (IsAppWindow(window, &object)) 
		TXNUpdate(object);		// TXNUpdate calls BeginUpdate() and EndUpdate()
	SetPort(savePort);
}

//	Called when a window is activated or deactivated
void DoActivate(WindowPtr window, Boolean  becomingActive)
{
	TXNObject		object 			= NULL;
	TXNFrameID 		frameID			= 0;
	OSStatus		status			= noErr;
		
	if (IsAppWindow(window, &object))
	{
		status = GetWindowProperty(window, 'GRIT', 'tFrm', sizeof(TXNFrameID), NULL, &frameID);

		if (becomingActive) 
		{
			TXNActivate(object, frameID, kScrollBarsAlwaysActive);
			AdjustMenus();
		} 
		else 
			TXNActivate(object, frameID, kScrollBarsSyncWithFocus);
	}
	// Focus the TXNObject. Scroll bars and insertion caret become active/inactive
	TXNFocus(object, becomingActive);
}

//	Called when a mouseDown occurs in the content of a window
void DoContentClick(WindowPtr window, EventRecord *event)
{
	TXNObject	object = NULL;
	
	if (IsAppWindow(window, &object))
		TXNClick(object, event);
}

// Called for any keyDown or autoKey events, except when the Command key is held down.
// Looks at the frontmost window to decide what to do with the key typed. 
#if 0
void DoKeyDown(EventRecord *event)
{
	WindowPtr	window = FrontWindow();
	TXNObject	object = NULL;
		
	if (IsAppWindow(window, &object)) 
		TXNKeyDown(object, event);  // TXNKeyDown not necessary for CarbonLib apps
}
#endif

//	Calculate sleep value for WaitNextEvent.
static UInt32 GetSleep()
{
	UInt32		sleep;
	WindowPtr	window;
	TXNObject	object = NULL;
	
	window = FrontWindow();					// and the front window is ours
	if (IsAppWindow(window, &object)) 
		sleep = TXNGetSleepTicks(object);	// and the selection is an insertion point... 
	else
		sleep = GetCaretTime();				// blink time for the insertion point

	return sleep;
}

// Called when we get a null event. Calls TXNIdle.
void DoIdle()
{
	WindowPtr	window = FrontWindow();
	TXNObject	object = NULL;
		
	if (IsAppWindow(window, &object))
		TXNIdle(object);  // TXNIdle should not be necessary for CarbonLib apps
						  // but the cursor won't currently blink w/o it	
}

//	Enable and disable menus based on the current state.
void AdjustMenus()
{
	WindowPtr	window;
	MenuHandle	menu;
	Boolean		undo;
	Boolean		cutCopyClear;
	Boolean		paste;
	TXNObject	object = NULL;
	
	window = FrontWindow();

	menu = GetMenuHandle(mFile);
	if (gNumDocuments < kMaxOpenDocuments)
		EnableMenuItem(menu, iNew);		// New is enabled when we can open more documents
	else
		DisableMenuItem(menu, iNew);
		
	if (window != NULL)					// Printing and Close are enabled when a window is up
	{
		EnableMenuItem(menu, iPageSetup);
		EnableMenuItem(menu, iPrint);	
		EnableMenuItem(menu, iClose);
	}
	else
	{
		DisableMenuItem(menu, iPageSetup);
		DisableMenuItem(menu, iPrint);	
		DisableMenuItem(menu, iClose);
	}
	
	menu = GetMenuHandle(mEdit);
	undo = cutCopyClear = paste = false;
	
	if (IsAppWindow(window, &object)) 
	{
		if (!TXNIsSelectionEmpty(object))
			cutCopyClear = true;	// Cut, Copy, Clear enabled for app windows with selections
			
		if (TXNIsScrapPastable())	// if there is text in the clipboard, paste is enabled
			paste = true;
	}
	
	if (undo)
		EnableMenuItem(menu, iUndo);
	else
		DisableMenuItem(menu, iUndo);
		
	if (cutCopyClear) 
	{
		EnableMenuItem(menu, iCut);
		EnableMenuItem(menu, iCopy);
		EnableMenuItem(menu, iClear);
	} 
	else 
	{
		DisableMenuItem(menu, iCut);
		DisableMenuItem(menu, iCopy);
		DisableMenuItem(menu, iClear);
	}
	
	if (paste)
		EnableMenuItem(menu, iPaste);
	else
		DisableMenuItem(menu, iPaste);
		
	if (TXNDataSize(object))		// if there is data in the object
		EnableMenuItem(menu, iSelectAll);
	
	InvalMenuBar();		// invalidate menubar - it gets updated next event loop
}

//	Handles items chosen from the menu bar.
void DoMenuCommand(long menuResult)
{
	short				menuID, menuItem;
	short				itemHit;
	WindowPtr			window;
	OSStatus			status = noErr;
	TXNObject			object = NULL;
	TXNTypeAttributes	typeAttr;

	window = FrontWindow();
	menuID = HiWord(menuResult);	// use macros to get menu 
	menuItem = LoWord(menuResult);	// item number and menu number

	switch (menuID) 
	{
		case mApple:
			switch (menuItem) 
			{
				case iAbout:		// bring up alert for About
					itemHit = Alert(rAboutAlert, NULL);
					break;
				default:
					break;
			}
			break;
		case mFile:
			switch (menuItem) 
			{
				case iNew:
					DoNew(NULL);
					break;
				case iClose:
					DoCloseWindow(FrontWindow());			// ignore the result
					break;
				case iPageSetup:
					if (IsAppWindow(window, &object)) 
						status = TXNPageSetup(object);
					break;
				case iPrint:
					if (IsAppWindow(window, &object)) 
						status = TXNPrint(object);
					break;
				case iQuit:
					Terminate();
					break;
			}
			break;
		case mEdit:			
			if (IsAppWindow(window, &object))
			{
				switch (menuItem) 
				{
					case iUndo:
						TXNUndo(object);
						break;
					case iCut:
						status = TXNCut(object);
						if (status != noErr)
							AlertUser(eNoCut);
						break;
					case iCopy:
						status = TXNCopy(object);
						if (status != noErr)
							AlertUser(eNoCopy);
						break;
					case iPaste:
						status = TXNPaste(object);
						if (status != noErr)
							AlertUser(eNoPaste);
						break;
					case iClear:
						status = TXNClear(object);
						if (status != noErr)
							AlertUser(eNoClear);
						break;
					case iSelectAll:
						TXNSelectAll(object);
					default:
						break;
				}
			}	
		case mFont:			
			if (IsAppWindow(window, &object))
			{
				if (gTXNFontMenuObject != NULL)	// change to the selected font
					 status = TXNDoFontMenuSelection(object, gTXNFontMenuObject, menuID, menuItem);
				if (status != noErr) 			//	Check for error
					AlertUser(eNoFontName);
				break;
			}
		case mSize:
			if (IsAppWindow(window, &object))
			{
				static short aFontSizeList[] = {9, 10, 12, 14, 18, 24, 36};
				short shortValue = aFontSizeList[menuItem - 1];
				
				//	Specify the size attributes
				typeAttr.tag = kTXNQDFontSizeAttribute;
				typeAttr.size = kTXNFontSizeAttributeSize;
				typeAttr.data.dataValue = shortValue << 16;
				
				//	Set the size attributes
				 status = TXNSetTypeAttributes(object, 1, &typeAttr, kTXNUseCurrentSelection, kTXNUseCurrentSelection);
				 if (status != noErr) 		//	Check for error
					AlertUser(eNoFontSize);
				break; 
			}
		case mStyle:
			if (IsAppWindow(window, &object))
			{
				Style	newStyle;
				
				switch (menuItem) 
				{
					case iPlain:
						newStyle = normal;		// 0		
						break;
					case iBold:
						newStyle = bold;		// 1				
						break;
					case iItalic:
						newStyle = italic;		// 2				
						break;
					case iUnderline:
						newStyle = underline;	// 3				
						break;
					case iOutline:
						newStyle = outline;		// 4				
						break;
					case iShadow:
						newStyle = shadow;		// 0x10				
						break;
					case iCondensed:
						newStyle = condense;	// 0x20				
						break;					
					case iExtended:
						newStyle = extend;		// 0x40				
						break;
					default:
						break;
				}
			
				// Specify the sytle attributes
				typeAttr.tag = kTXNQDFontStyleAttribute;
				typeAttr.size = kTXNQDFontStyleAttributeSize;
				typeAttr.data.dataValue = newStyle;

				// Set the style attributes
				status = TXNSetTypeAttributes(object, 1, &typeAttr, kTXNUseCurrentSelection, kTXNUseCurrentSelection);
				if (status != noErr) 		//	Check for error
					AlertUser(eNoFontStyle);
				break;
			}
		case mLayout:
			if (menuItem <= iForceJustify)
				DoJustification(window, menuItem);
			else
				DoWordWrap(window);
			break;
		default:
			if ((menuID >= kStartHierMenuID) && (IsAppWindow(window, &object)))
			{
				if (gTXNFontMenuObject != NULL)	// change to the selected font
					 status = TXNDoFontMenuSelection(object, gTXNFontMenuObject, menuID, menuItem);
				if (status != noErr) 			//	Check for error
					AlertUser(eNoFontName);
			}
			break;
	}	
	HiliteMenu(0);							// unhighlight the menu
	AdjustMenus();
}

// Set the justification tag
void DoJustification(WindowPtr window, short menuItem)
{
	TXNObject	object = NULL;
	MenuHandle 	layoutMenu;
	OSStatus	status = noErr;
	
	layoutMenu = GetMenuHandle(mLayout);
	
	if (IsAppWindow(window, &object)) 
	{
		SInt32			justification;
		TXNControlTag	controlTag[1];
		TXNControlData	controlData[1];
		
		for (int i = 1; i <= iForceJustify; i++)	// brute technique to uncheck last item
			CheckMenuItem(layoutMenu, i, false);
		switch (menuItem) 
		{
			case iDefaultJustify:
				justification = kTXNFlushDefault;	// flush according to the line direction						
				break;
			case iLeftJustify:
				justification = kTXNFlushLeft;
				break;
			case iRightJustify:
				justification = kTXNFlushRight;
				break;
			case iCenterJustify:
				justification = kTXNCenter;
				break;
			case iFullJustify:
				justification = kTXNFullJust;
				break;
			case iForceJustify:
				justification = kTXNForceFullJust;	// flush left for all scripts
				break;
			default:
				break;
		}
		CheckMenuItem(layoutMenu, menuItem, true);		// check this menu item
		
		controlTag[0] = kTXNJustificationTag;
		status = TXNGetTXNObjectControls(object, 1, controlTag, controlData);
		if (controlData[0].sValue != justification) // if we have a new justification
		{				 	
			controlData[0].sValue = justification;
			status = TXNSetTXNObjectControls(object, false, 1, controlTag, controlData);
		}
		if (status != noErr)
			AlertUser(eNoJustification);
	}
}

// Toggle word wrapping
void DoWordWrap(WindowPtr window)
{
	TXNObject	object = NULL;
	MenuHandle 	layoutMenu;
	OSStatus	status = noErr;
	
	layoutMenu = GetMenuHandle(mLayout);
	
	if (IsAppWindow(window, &object))
	{
		TXNControlTag	controlTag[1];
		TXNControlData	controlData[1];

		controlTag[0] = kTXNWordWrapStateTag;

		status = TXNGetTXNObjectControls(object, 1, controlTag, controlData);

		if (controlData[0].uValue == kTXNAutoWrap) 		// if we are autowrapped
		{		 	
			controlData[0].uValue = kTXNNoAutoWrap; 	// toggle to not autowrapped
			CheckMenuItem(layoutMenu, iAutoWrap, false);// uncheck this menu item
		}
		else
		{
			controlData[0].uValue = kTXNAutoWrap;
			CheckMenuItem(layoutMenu, iAutoWrap, true);	// check this menu item
		}
			
		status = TXNSetTXNObjectControls(object, false, 1, controlTag, controlData);
		if (status != noErr)
			AlertUser(eNoWordWrap);
	}
}

// Create a new document and window.
OSStatus DoNew(const FSSpec *fileSpecPtr)
{
	OSStatus		status = noErr;
	WindowPtr		window;
	MenuHandle 		layoutMenu;
	
	window = GetNewCWindow(rDocWindow, NULL, (WindowPtr)-1L);
	
	if (window != NULL) 
	{
		TXNObject		object = NULL;
		TXNFrameID		frameID	= 0;
		WindowPtr		paramWindow = NULL;
		Rect			frame;
		TXNFrameOptions	frameOptions;
		
		frameOptions = kTXNShowWindowMask; // ShowWindow() not needed if kTXNShowWindowMask used
		frameOptions |= kTXNWantHScrollBarMask | kTXNWantVScrollBarMask;
		frameOptions |= kTXNDrawGrowIconMask;// | kTXNNoKeyboardSyncMask;
		
		paramWindow = window;
		GetWindowPortBounds(window, &frame);

		status = TXNNewObject(	fileSpecPtr, 
								paramWindow, 
								&frame,
								frameOptions,
								kTXNTextEditStyleFrameType,
								kTXNTextensionFile,
								kTXNSystemDefaultEncoding,
								&object,
								&frameID, 
								0);
		if (status == noErr) 
		{
			status = TXNAttachObjectToWindow(object, (GWorldPtr)window, true);	
			if (status != noErr)
				AlertUser(eNoAttachObjectToWindow);
		}
		
		if (status == noErr)
		{		
			if (object != NULL) 
			{
				Boolean	isAttached;

				//	Activate the window.
				status = TXNActivate(object, frameID, kScrollBarsAlwaysActive);
				if (status != noErr)
					AlertUser(eNoActivate);
			
				//	Set the ID type of this window.
			// DG	storage->SetWindow(window);
			// DG	storage->SetObjectAttributes(object, frameID, kTXNDocRefCon);
			// DG	storage->SetFileSpec(fileSpecPtr);
				
				status = SetWindowProperty(window,'GRIT','tFrm',sizeof(TXNFrameID),&frameID);
				status = SetWindowProperty(window,'GRIT','tObj',sizeof(TXNObject),&object);
				
				//	Check if object is really attached to the window.
			 	isAttached = TXNIsObjectAttachedToWindow(object);
				if (!isAttached)
					AlertUser(eObjectNotAttachedToWindow);
			}

			AdjustMenus();
			gNumDocuments++;							// will be decremented in DoCloseWindow
			
			DoJustification(window, iDefaultJustify); 	// set justification default for new doc
	
			layoutMenu = GetMenuHandle(mLayout);
			CheckMenuItem(layoutMenu, iAutoWrap, true);	// check this menu item
		} 
	}
	else
	{
		DisposeWindow(window);
		window = NULL;
		AlertUser(eNoWindow);		// and tell user
	}
	return status;
}

// Close a window. Handles desk accessory and application windows.
Boolean DoCloseWindow(WindowPtr window)
{
	Boolean		isClosed 	= true;
	TXNObject	object 		= NULL;

	if (IsAppWindow(window, &object)) 
	{
// DG	if (TXNGetChangeCount(object))	// if document has been changed
// DG		isClosed = ShowSaveDialog(window, object);
		if (isClosed) 
		{
			TXNDeleteObject(object);
			DisposeWindow(window);
			gNumDocuments -= 1;
		}
	}
	AdjustMenus();
	return isClosed;
}

// Clean up and exit. Close all of the windows. If a cancel occurrs, return instead.
void Terminate()
{
	WindowPtr	aWindow;
	Boolean		closed;
	
	closed = true;
	do {
		aWindow = FrontWindow();				// get current front window
		if (aWindow != NULL)
			closed = DoCloseWindow(aWindow);	// close this window
	}
	while (closed && (aWindow != NULL));
	if (closed)
	{
		// Dispose the font menu object before terminating Textension.
		if (gTXNFontMenuObject != NULL) 
		{
			OSStatus	status;
		
			status = TXNDisposeFontMenuObject(gTXNFontMenuObject);
			if (status != noErr)
				AlertUser(eNoDisposeFontMenuObject);

			//	Nullify font menu object even if error.
			gTXNFontMenuObject = NULL;
		}
	}
	TXNTerminateTextension();
	ExitToShell();						// exit if no cancellation
}

// Check whether a window is a document window created by the application. They
// are distinguished from dialogs and other windows by their windowKind userKind.
Boolean IsAppWindow(WindowPtr window, TXNObject *object)
{
	OSErr status = noErr;
	
	status = GetWindowProperty(window, 'GRIT', 'tObj', sizeof(TXNObject), NULL, object);
	return (window != NULL) && (GetWindowKind(window) == userKind);
}

//	Display an alert that tells the user an error occurred.
void AlertUser(short error)
{
	short		itemHit;
	Str255		message;
	Cursor		arrow;
	
	SetCursor(GetQDGlobalsArrow(&arrow));
	GetIndString(message, kErrStrings, error);
	ParamText(message, (ConstStr255Param)"",(ConstStr255Param)"", (ConstStr255Param)"");
	itemHit = Alert(rUserAlert, NULL);
}

// Used whenever a fatal error happens
void BigBadError(short error)
{
	AlertUser(error);
	ExitToShell();
}

// install the core apple event handlers
void InstallAppleEventHandlers(void)
{
	long result;
	
	OSErr err = Gestalt(gestaltAppleEventsAttr, &result);
	
	if (err == noErr)
	{	// we should check the AEInstallEventHandler return value but since it's just a sample...
		AEInstallEventHandler(kCoreEventClass, kAEOpenApplication, NewAEEventHandlerUPP(HandleOapp), 0, false);
		AEInstallEventHandler(kCoreEventClass, kAEOpenDocuments,   NewAEEventHandlerUPP(HandleOdoc), 0, false);
		AEInstallEventHandler(kCoreEventClass, kAEPrintDocuments,  NewAEEventHandlerUPP(HandlePdoc), 0, false);
		AEInstallEventHandler(kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(HandleQuit), 0, false);
	}
}

// Respond to an open application apple event
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr HandleOapp (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon)
#else
pascal OSErr HandleOapp (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
{
#pragma unused (aevt, reply, refCon)
	return noErr;
}

// Respond to an open document apple event
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr HandleOdoc (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon)
#else
pascal OSErr HandleOdoc (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
{
#pragma unused (aevt, reply, refCon)
	return errAEEventNotHandled;
}

// Respond to a print apple event
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr HandlePdoc (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon)
#else
pascal OSErr HandlePdoc (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
{
#pragma unused (aevt, reply, refCon)
	return errAEEventNotHandled;
}

// Respond to a quit apple event
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr HandleQuit (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon)
#else
pascal OSErr HandleQuit (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
{
#pragma unused (aevt, reply, refCon)
	Terminate();
	return noErr;
}
