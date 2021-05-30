/*
 * File Sample.c
 *
 * Copyright Apple Computer, Inc. 1985, 1986
 * All rights reserved.
 *
 * Sample application in C
 *
 *	This sample displays a fixed sized window in which the user can
 *	enter and edit text.  The style and layout of the procedures
 *	reflects C programming style, and differs somewhat from the
 *	simple example Pascal program outlined in "Inside Macintosh".
 *
 *	The C Sample includes a few minor additions to the Pascal sample:
 *	[1] About Sample... dialog box supported.
 *	[2] The I-Beam cursor is set when inside the window
 *	[3] Various bugs are fixed concerning the current port, cut/copy/paste
 *		to/from the clipboard, a few random crasher bugs
 *	[4] Segmentation is demonstrated
 */

# include <types.h> 				/* Nearly always required */
# include <quickdraw.h> 			/* To access the qd globals */
# include <toolutils.h> 			/* CursHandle and iBeamCursor */
# include <fonts.h> 				/* Only for InitFonts() trap */
# include <events.h>				/* GetNextEvent(), ... */
# include <windows.h>				/* GetNewWindow(), ... */
# include <dialogs.h>				/* InitDialogs() and GetNewDialog() */
# include <menus.h> 				/* EnableItem(), DisableItem() */
# include <desk.h>					/* SystemTask(), SystemClick() */
# include <textedit.h>				/* TENew() */
# include <scrap.h> 				/* ZeroScrap() */
# include <segload.h>				/* UnloadSeg() */
extern _DataInit();

/*
 * Resource ID constants.
 */
# define appleID		128 			/* This is a resource ID */
# define fileID 		129 			/* ditto */
# define editID 		130 			/* ditto */

# define appleMenu		0				/* MyMenus[] array indexes */
# define	aboutMeCommand	1

# define fileMenu		1
# define	quitCommand 	1

# define editMenu		2
# define	undoCommand 	1
# define	cutCommand		3
# define	copyCommand 	4
# define	pasteCommand	5
# define	clearCommand	6

# define menuCount	 3
/*
 * For the one and only text window
 */
# define windowID		128
/*
 * For the About Sample... DLOG
 */
# define aboutMeDLOG	128
# define	okButton		1
# define	authorItem		2			/* For SetIText */
# define	languageItem	3			/* For SetIText */

/*
 * C programs typically use macros for simple expressions which
 * must be function calls in Pascal.  Here are a couple of examples:
 */

/*
 * Inline SetRect() macro, efficient when (rectp) is a constant.
 * Must not be used if (rectp) has side effects.
 *
 * We could do an InsetRect() macro in a similar vein.
 */
# define SETRECT(rectp, _left, _top, _right, _bottom)	\
	(rectp)->left = (_left), (rectp)->top = (_top), 	\
	(rectp)->right = (_right), (rectp)->bottom = (_bottom)

/*
 * HIWORD and LOWORD macros, for readability.
 */
# define HIWORD(aLong)		(((aLong) >> 16) & 0xFFFF)
# define LOWORD(aLong)		((aLong) & 0xFFFF)

/*
 * Global Data objects, used by routines external to main().
 */
MenuHandle		MyMenus[menuCount]; 	/* The menu handles */
Boolean 		DoneFlag;				/* Becomes TRUE when File/Quit chosen */
TEHandle		TextH;					/* The TextEdit handle */

int
main()
{
	extern void 	setupMenus();
	extern void 	doCommand();
	Rect			screenRect, dragRect, txRect;
	Point			mousePt;
	CursHandle		ibeamHdl;
	EventRecord 	myEvent;
	WindowRecord	wRecord;
	WindowPtr		theActiveWindow, whichWindow;
	register
		WindowPtr	myWindow;			/* Referenced often */
	/*
	 * Initialization traps
	 */
	UnloadSeg(_DataInit);
	InitGraf(&qd.thePort);
	InitFonts();
	FlushEvents(everyEvent, 0);
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(nil);
	InitCursor();
	/*
	 * setupMenus is execute-once code, so we can unload it now.
	 */
	setupMenus();			/* Local procedure, below */
	UnloadSeg(setupMenus);
	/*
	 * Calculate the drag rectangle in advance.
	 * This will be used when dragging a window frame around.
	 * It constrains the area to within 4 pixels from the screen edge
	 * and below the menu bar, which is 20 pixels high.
	 */
	screenRect = qd.screenBits.bounds;
	SETRECT(&dragRect, 4, 20 + 4, screenRect.right-4, screenRect.bottom-4);
	/*
	 * Create our one and only window from the WIND resource.
	 * If the WIND resource isn't there, we die.
	 */
	myWindow = GetNewWindow(windowID, &wRecord, (WindowPtr) -1);
	SetPort(myWindow);
	/*
	 * Create a TextEdit record with the destRect and viewRect set
	 * to my window's portRect (offset by 4 pixels on the left and right
	 * sides so that text doesn't jam up against the window frame).
	 */
	txRect = myWindow->portRect;
	InsetRect(&txRect, 4, 0);
	TextH = TENew(&txRect, &txRect);	/* Not growable, so destRect == viewRect */

	ibeamHdl = GetCursor(iBeamCursor);		/* Grab this for use later */
	/*
	 * Ready to go.
	 * Start with a clean event slate, and cycle the main event loop
	 * until the File/Quit menu item sets DoneFlag.
	 *
	 * It would not be good practice for the doCommand() routine to
	 * simply ExitToShell() when it saw the QuitItem -- to ensure
	 * orderly shutdown, satellite routines should set global state,
	 * and let the main event loop handle program control.
	 */
	DoneFlag = false;
	for ( ;; ) {
		if (DoneFlag) {
			/*
			 * Quit has been requested, by the File/Quit menu, or perhaps
			 * by a fatal error somewhere else (missing resource, etc).
			 * Here we could put up a Save Changes? DLOG, which would also
			 * allow the Cancel buttion to set DoneFlag to false.
			 */
			break;		/* from main event loop */
		}
		/*
		 * Main Event tasks:
		 */
		SystemTask();
		theActiveWindow = FrontWindow();		/* Used often, avoid repeated calls */
		/*
		 * Things to do on each pass throught the event loop
		 * when we are the active window:
		 *		[1] Track the mouse, and set the cursor appropriately:
		 *			(IBeam if in content region, Arrow if outside)
		 *		[2] TEIdle our textedit window, so the insertion bar blinks.
		 */
		if (myWindow == theActiveWindow) {
			GetMouse(&mousePt);
			SetCursor(PtInRect(&mousePt, &myWindow->portRect) ? *ibeamHdl : &qd.arrow);
			TEIdle(TextH);
		}
		/*
		 * Handle the next event.
		 * In a more complex application, this switch statement
		 * would probably call satellite routines to handle the
		 * major cases (mouseDown, keyDown, etc), but our actions
		 * are simple here and it suffices to perform the code in-line.
		 */
		if ( ! GetNextEvent(everyEvent, &myEvent)) {
			/*
			 * A null or system event, not for me.
			 * Here is a good place for heap cleanup and/or
			 * segment unloading if I want to.
			 */
			continue;
		}
		/*
		 * In the unlikely case that the active desk accessory does not
		 * handle mouseDown, keyDown, or other events, GetNextEvent() will
		 * give them to us!  So before we perform actions on some events,
		 * we check to see that the affected window in question is really
		 * our window.
		 */
		switch (myEvent.what) {
			case mouseDown:
				switch (FindWindow(&myEvent.where, &whichWindow)) {
					case inSysWindow:
						SystemClick(&myEvent, whichWindow);
						break;
					case inMenuBar:
						doCommand(MenuSelect(&myEvent.where));
						break;
					case inDrag:
						DragWindow(whichWindow, &myEvent.where, &dragRect);
						break;
					case inGrow:
						/* There is no grow box. (Fall through) */
					case inContent:
						if (whichWindow != theActiveWindow) {
							SelectWindow(whichWindow);
						} else if (whichWindow == myWindow) {
							GlobalToLocal(&myEvent.where);
							TEClick(&myEvent.where, (myEvent.modifiers & shiftKey) != 0, TextH);
						}
						break;
					default:
						break;
				}/*endsw FindWindow*/
				break;

			case keyDown:
			case autoKey:
				if (myWindow == theActiveWindow) {
					if (myEvent.modifiers & cmdKey) {
						doCommand(MenuKey(myEvent.message & charCodeMask));
					} else {
						TEKey((char) (myEvent.message & charCodeMask), TextH);
					}
				}
				break;

			case activateEvt:
				if ((WindowPtr) myEvent.message == myWindow) {
					if (myEvent.modifiers & activeFlag) {
						TEActivate(TextH);
						DisableItem(MyMenus[editMenu], undoCommand);
					} else {
						TEDeactivate(TextH);
						EnableItem(MyMenus[editMenu], undoCommand);
					}
				}
				break;

			case updateEvt:
				if ((WindowPtr) myEvent.message == myWindow) {
					BeginUpdate(myWindow);
					EraseRect(&myWindow->portRect);
					TEUpdate(&myWindow->portRect, TextH);
					EndUpdate(myWindow);
				}
				break;

			default:
				break;

		}/*endsw myEvent.what*/

	}/*endfor Main Event loop*/
	/*
	 * No cleanup required, but if there was, it would happen here.
	 */
	return(0);		/* Return from main() to allow C runtime cleanup */
}

/*
 * Demonstration of the segmenting facility:
 *
 * This code is execute-once, so we toss it in the "Initialize"
 * segment so that main() can unload it after it's called.
 *
 * There really isn't much here, but it demonstrates the segmenting facility.
 */
/*
 * Set the segment to Initialize.  BEWARE: leading and trailing white space
 * would be part of the segment name!
 */
# define	__SEG__ Initialize

/*
 * Set up the Apple, File, and Edit menus.
 * If the MENU resources are missing, we die.
 */
void
setupMenus()
{
	extern MenuHandle	MyMenus[];
	register MenuHandle *pMenu;
	/*
	 * Set up the desk accessories menu.
	 * The "About Sample..." item, followed by a grey line,
	 * is presumed to be already in the resource.  We then
	 * append the desk accessory names from the 'DRVR' resources.
	 */
	MyMenus[appleMenu] = GetMenu(appleID);
	AddResMenu(MyMenus[appleMenu], (ResType) 'DRVR');
	/*
	 * Now the File and Edit menus.
	 */
	MyMenus[fileMenu] = GetMenu(fileID);
	MyMenus[editMenu] = GetMenu(editID);
	/*
	 * Now insert all of the application menus in the menu bar.
	 *
	 * "Real" C programmers never use array indexes
	 * unless they're constants :-)
	 */
	for (pMenu = &MyMenus[0]; pMenu < &MyMenus[menuCount]; ++pMenu) {
		InsertMenu(*pMenu, 0);
	}

	DrawMenuBar();

	return;
}

/*
 * Back to the Main segment.
 */
# define	__SEG__ Main

/*
 * Display the Sample Application dialog.
 * We insert two static text items in the DLOG:
 *		The author name
 *		The source language
 * Then wait until the OK button is clicked before returning.
 */
void
showAboutMeDialog()
{
	GrafPtr 	savePort;
	DialogPtr	theDialog;
	short		itemType;
	Handle		itemHdl;
	Rect		itemRect;
	short		itemHit;

	GetPort(&savePort);
	theDialog = GetNewDialog(aboutMeDLOG, nil, (WindowPtr) -1);
	SetPort(theDialog);

	GetDItem(theDialog, authorItem, &itemType, &itemHdl, &itemRect);
	SetIText(itemHdl, "Flash Bazbo");
	GetDItem(theDialog, languageItem, &itemType, &itemHdl, &itemRect);
	SetIText(itemHdl, "C");

	do {
		ModalDialog(nil, &itemHit);
	} while (itemHit != okButton);

	CloseDialog(theDialog);

	SetPort(savePort);
	return;
}
/*
 * Process mouse clicks in menu bar
 */
void
doCommand(mResult)
long mResult;
{
	extern MenuHandle	MyMenus[];
	extern Boolean		DoneFlag;
	extern TEHandle 	TextH;
	extern void 		showAboutMeDialog();
	int 				theMenu, theItem;
	char				daName[256];
	GrafPtr 			savePort;

	theItem = LOWORD(mResult);
	theMenu = HIWORD(mResult);		/* This is the resource ID */

	switch (theMenu) {
		case appleID:
			if (theItem == aboutMeCommand) {
				showAboutMeDialog();
			} else {
				GetItem(MyMenus[appleMenu], theItem, daName);
				GetPort(&savePort);
				(void) OpenDeskAcc(daName);
				SetPort(savePort);
			}
			break;

		case fileID:
			switch (theItem) {
				case quitCommand:
					DoneFlag = true;			/* Request exit */
					break;
				default:
					break;
			}
			break;
		case editID:
			/*
			 * If this is for a 'standard' edit item,
			 * run it through SystemEdit first.
			 * SystemEdit will return FALSE if it's not a system window.
			 */
			if ((theItem <= clearCommand) && SystemEdit(theItem-1)) {
				break;
			}
			/*
			 * Otherwise, it's my window.
			 * Handle Cut/Copy/Paste properly
			 * between the TEScrap and the Clipboard.
			 */
			switch (theItem) {
				case undoCommand:
					/* can't undo */
					break;
				case cutCommand:
				case copyCommand:
					if (theItem == cutCommand) {
						TECut(TextH);
					} else {
						TECopy(TextH);
					}
					ZeroScrap();
					TEToScrap();
					break;
				case pasteCommand:
					TEFromScrap();
					TEPaste(TextH);
					break;
				case clearCommand:
					TEDelete(TextH);
					break;
				default:
					break;
			} /*endsw theItem*/
			break;

		default:
			break;

	}/*endsw theMenu*/

	HiliteMenu(0);

	return;
}
